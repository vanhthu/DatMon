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
    public partial class Cart : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        decimal grandTotal = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userID"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    GetCartItems();
                }
            }
        }

        protected void repeatCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Utils utils = new Utils();
            if (e.CommandName == "delete")
            {
                cn = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("CART_CRUD", cn);
                cmd.Parameters.AddWithValue("@action", "DELETE");
                cmd.Parameters.AddWithValue("@productID", e.CommandArgument);
                cmd.Parameters.AddWithValue("@userID", Session["userID"]);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    GetCartItems();
                    // đếm số lượng sản phẩm trong giỏ
                    Session["CartCount"] = utils.CartCount(Convert.ToInt32(Session["userID"]));
                }
                catch (Exception ex)
                {
                    Response.Write("<script> alert('Lỗi - " + ex.Message + "'); </script>");
                }
                finally
                {
                    cn.Close();
                }
            }

            if (e.CommandName == "update")
            {
                bool isCartUpdated = false;
                for (int i = 0; i < repeatCart.Items.Count; i++)
                {
                    if (repeatCart.Items[i].ItemType == ListItemType.Item || repeatCart.Items[i].ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox quantity = repeatCart.Items[i].FindControl("txtQuantity") as TextBox;
                        HiddenField _productID = repeatCart.Items[i].FindControl("hdnProductID") as HiddenField;
                        HiddenField _quantity = repeatCart.Items[i].FindControl("hdnQuantity") as HiddenField;
                        int quantityFromCart = Convert.ToInt32(quantity.Text); // lấy từ textbox
                        int productID = Convert.ToInt32(_productID.Value);
                        int quantityFromDB = Convert.ToInt32(_quantity.Value);
                        bool isTrue = false;
                        int updateQuantity = 1;
                        if (quantityFromCart > quantityFromDB)
                        {
                            updateQuantity = quantityFromCart;
                            isTrue = true;
                        }
                        else if (quantityFromCart < quantityFromDB)
                        {
                            updateQuantity = quantityFromCart;
                            isTrue = true;
                        }
                        if (isTrue)
                        {
                            // cập nhật số lượng sản phẩm vào database
                            isCartUpdated = utils.UpdateCartQuantity(updateQuantity, productID, Convert.ToInt32(Session["userID"]));
                        }
                    }
                }
                GetCartItems();
            }

            if (e.CommandName == "checkout")
            {
                bool isTrue = false;
                string ten = string.Empty;
                // kiểm tra số lượng sản phẩm trước khi thanh toán
                for (int i = 0; i < repeatCart.Items.Count; i++)
                {
                    if (repeatCart.Items[i].ItemType == ListItemType.Item || repeatCart.Items[i].ItemType == ListItemType.AlternatingItem)
                    {
                        HiddenField _productID = repeatCart.Items[i].FindControl("hdnProductID") as HiddenField;
                        HiddenField _cartQuantity = repeatCart.Items[i].FindControl("hdnQuantity") as HiddenField;
                        HiddenField _productQuantity = repeatCart.Items[i].FindControl("hdnPrdQuantity") as HiddenField;
                        Label productName = repeatCart.Items[i].FindControl("lblName") as Label;

                        int productID = Convert.ToInt32(_productID.Value);
                        int cartQuantity = Convert.ToInt32(_cartQuantity.Value);
                        int productQuantity = Convert.ToInt32(_productID.Value);

                        if (productQuantity > cartQuantity && productQuantity > 2)
                        {
                            isTrue = true;
                        }
                        else
                        {
                            isTrue = true;
                            ten = productName.Text.ToString();
                            break;
                        }
                    }
                }

                if (isTrue)
                {
                    Response.Redirect("Payment.aspx");
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Món <b>'" + ten + "'</b> đã được bán hết.";
                    lblMessage.CssClass = "alert alert-warning";
                }
            }
        }

        protected void repeatCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label totalPrice = e.Item.FindControl("lblTotalPrice") as Label;
                Label productPrice = e.Item.FindControl("lblPrice") as Label;
                TextBox quantity = e.Item.FindControl("txtQuantity") as TextBox;

                decimal calTotalPrice = Convert.ToDecimal(productPrice.Text) * Convert.ToDecimal(quantity.Text);
                totalPrice.Text = calTotalPrice.ToString();
                grandTotal += calTotalPrice;
            }
            Session["grandTotalPrice"] = grandTotal;
        }
        void GetCartItems()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("CART_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "SELECT");
            cmd.Parameters.AddWithValue("@userID", Session["userID"]);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            repeatCart.DataSource = dt;
            if (dt.Rows.Count == 0)
            {
                repeatCart.FooterTemplate = null;
                repeatCart.FooterTemplate = new TuyChinhMau(ListItemType.Footer);
            }
            repeatCart.DataBind();

        }
        private sealed class TuyChinhMau : ITemplate
        {
            private ListItemType ListItemType { get; set; }
            public TuyChinhMau(ListItemType type)
            {
                ListItemType = type;
            }

            public void InstantiateIn(Control container)
            {
                if (ListItemType == ListItemType.Footer)
                {
                    var footer = new LiteralControl("<tr><td colspan='5'><b>Giỏ hàng trống.</b><a href='Menu.aspx' class='badge badge-info ml-2'>Tiếp tục mua sắm!</a></td></tr></tbody></table>");
                    container.Controls.Add(footer);
                }
            }
        }
    }
}