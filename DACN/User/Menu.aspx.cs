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
    public partial class Menu : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getCategories();
                getProducts();
            }
        }       

        protected void repeatProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (Session["userID"] != null)
            {
                bool isCartItemUpdated = false;
                int i = isItemExitInCart(Convert.ToInt32(e.CommandArgument));

                if (i == 0)
                {
                    // thêm sản phẩm vào đây
                    cn = new SqlConnection(Connection.GetConnectionString());
                    cmd = new SqlCommand("CART_CRUD", cn);
                    cmd.Parameters.AddWithValue("@action", "INSERT");
                    cmd.Parameters.AddWithValue("@productID", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@quantity", 1);
                    cmd.Parameters.AddWithValue("@userID", Session["userID"]);
                    cmd.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        cn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Lỗi - " + ex.Message + "')</script>");
                    }
                    finally
                    {
                        cn.Close();
                    }

                }
                else
                {
                    // thêm sản phẩm đã tồn tại vào giỏ hàng
                    Utils utils = new Utils();
                    isCartItemUpdated = utils.UpdateCartQuantity(i + 1, Convert.ToInt32(e.CommandArgument), 
                        Convert.ToInt32(Session["userID"]));
                }
                lblMessage.Visible = true;
                lblMessage.Text = "Đã thêm sản phẩm vào giỏ hàng";
                lblMessage.CssClass = "alert alert-success";
                Response.AddHeader("REFRESH", "1;URL=Cart.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
                
        private void getProducts()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("PRODUCT_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "ACTIVEPROD");
            cmd.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            repeatProduct.DataSource = dt;
            repeatProduct.DataBind();
        }
        private void getCategories()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("CATEGORY_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "ACTIVECAT");
            cmd.CommandType = CommandType.StoredProcedure; 
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            repeatCategory.DataSource = dt;
            repeatCategory.DataBind();

        }

        public string ChuyenDanhMucThanhChuThuong(object obj)
        {
            return obj.ToString().ToLower();
        }

        int isItemExitInCart(int productID)
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("CART_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "GETBYID");
            cmd.Parameters.AddWithValue("@productID", productID);
            cmd.Parameters.AddWithValue("@userID", Session["userID"]);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            int quantity = 0;
            if (dt.Rows.Count > 0)
            {
                quantity = Convert.ToInt32(dt.Rows[0]["quantity"]);
            }
            return quantity;
        }
        protected void repeatSanPham_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // không có xài tới
        }
    }
}