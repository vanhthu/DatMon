using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DACN.User
{
    public partial class Payment : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataReader dr, dr1;
        DataTable dt;
        SqlTransaction transaction = null;
        string _name = string.Empty;
        string _cardNo = string.Empty;
        string _expiryDate = string.Empty;
        string _CVV = string.Empty;
        string _address = string.Empty;
        string _paymentMode = string.Empty;        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userID"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }
        protected void lbCODSubmit_Click(object sender, EventArgs e)
        {
            _address = txtCODAddress.Text.Trim();
            _paymentMode = "cod";

            if (Session["userID"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _CVV, _address, _paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void lbCardSubmit_Click(object sender, EventArgs e)
        {
            _name = txtName.Text.Trim();
            _cardNo = txtCardNo.Text.Trim();
            _cardNo = string.Format("************{0}", txtCardNo.Text.Trim().Substring(12, 4));
            _expiryDate = txtExpMonth.Text.Trim() + "/" + txtExpYear.Text.Trim();
            _CVV = txtCVV.Text.Trim();
            _address = txtAddress.Text.Trim();
            _paymentMode = "card";

            if (Session["userID"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _CVV, _address, _paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        void OrderPayment(string name, string cardNo, string expiryDate, string CVV, string address, string paymentMode)
        {
            int paymentID; // mã thanh toán
            int productID; // mã món ăn
            int quantity;  // số lượng

            dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[7]
            {
                // tương tác với bảng CHITIETDATHANG
                new DataColumn("orderNo", typeof(string)),
                new DataColumn("productID", typeof(int)),
                new DataColumn("quantity", typeof(int)),
                new DataColumn("userID", typeof(int)),
                new DataColumn("status", typeof(string)),
                new DataColumn("paymentID", typeof(int)),
                new DataColumn("orderDate", typeof(DateTime))
            });

            cn = new SqlConnection(Connection.GetConnectionString());
            cn.Open();

            #region sql transaction
            transaction = cn.BeginTransaction();
            cmd = new SqlCommand("SAVE_PAYMENT", cn, transaction);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@cardNo", cardNo);
            cmd.Parameters.AddWithValue("@expiryDate", expiryDate);
            cmd.Parameters.AddWithValue("@CVV", CVV);
            cmd.Parameters.AddWithValue("@address", address);
            cmd.Parameters.AddWithValue("@paymentMode", paymentMode);
            cmd.Parameters.AddWithValue("@insertedID", SqlDbType.Int);
            cmd.Parameters["@insertedID"].Direction = ParameterDirection.Output;
            try
            {
                cmd.ExecuteNonQuery();
                paymentID = Convert.ToInt32(cmd.Parameters["@insertedID"].Value);

                #region lấy sản phẩm
                cmd = new SqlCommand("CART_CRUD", cn, transaction);
                cmd.Parameters.AddWithValue("@action", "SELECT");
                cmd.Parameters.AddWithValue("@userID", Session["userID"]);
                cmd.CommandType = CommandType.StoredProcedure;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    productID = (int)dr["productID"];
                    quantity = (int)dr["quantity"];
                    // cập nhật số lượng món ăn
                    UpdateQuantity(productID, quantity, transaction, cn);
                    // xóa món ăn
                    DeleteCartItem(productID, transaction, cn);

                    dt.Rows.Add(Utils.GetUniqueID(), productID, quantity, (int)Session["userID"], "Đang giao", paymentID, Convert.ToDateTime(DateTime.Now));
                }
                dr.Close();
                #endregion lấy sản phẩm

                #region Chi tiết thông tin đặt hàng
                if (dt.Rows.Count > 0)
                {
                    cmd = new SqlCommand("SAVE_ORDER", cn, transaction);
                    cmd.Parameters.AddWithValue("@tblOrders", dt);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
                #endregion Chi tiết thông tin đặt hàng
                transaction.Commit();
                lblMessage.Visible = true;
                lblMessage.Text = "Đặt hàng thành công";
                lblMessage.CssClass = "alert alert-success";
                Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?id=" + paymentID);
            }
            catch (Exception e)
            {
                try
                {
                    transaction.Rollback();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
            }
            #endregion sql transaction
            finally
            {
                cn.Close();
            }
        }
        void UpdateQuantity(int _productID, int quantity, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            int dbQuantity;
            cmd = new SqlCommand("PRODUCT_CRUD", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@action", "GETBYID");
            cmd.Parameters.AddWithValue("@productID", _productID);
            cmd.CommandType = CommandType.StoredProcedure;

            try
            {
                dr1 = cmd.ExecuteReader();
                while (dr1.Read())
                {
                    dbQuantity = (int)dr1["quantity"];
                    if (dbQuantity > quantity && dbQuantity > 2)
                    {
                        dbQuantity = dbQuantity - quantity;
                        cmd = new SqlCommand("PRODUCT_CRUD", sqlConnection, sqlTransaction);
                        cmd.Parameters.AddWithValue("@action", "QTYUPDATE");
                        cmd.Parameters.AddWithValue("@quantity", dbQuantity);
                        cmd.Parameters.AddWithValue("@productID", _productID);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                }
                dr1.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");

            }
        }
        void DeleteCartItem(int _productID, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            cmd = new SqlCommand("CART_CRUD", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@action", "DELETE");
            cmd.Parameters.AddWithValue("@productID", _productID);
            cmd.Parameters.AddWithValue("@userID", Session["userID"]);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}