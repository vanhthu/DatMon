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
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userID"] != null)
            {
                Response.Redirect("TrangChu.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtUserName.Text.Trim() == "admin" && txtPassword.Text.Trim() == "admin123")
            {
                Session["admin"] = txtUserName.Text.Trim();
                Response.Redirect("../Admin/Dashboard.aspx");
            }
            else
            {
                cn = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("USER_CRUD", cn);
                cmd.Parameters.AddWithValue("@action", "SELECTFORLOGIN");
                cmd.Parameters.AddWithValue("@username", txtUserName.Text.Trim());
                cmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 1)
                {

                    Session["username"] = txtUserName.Text.Trim();
                    Session["userID"] = dt.Rows[0]["userID"];
                    Response.Redirect("TrangChu.aspx");
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Tên tài khoản hoặc mật khẩu bị sai. Vui lòng nhập lại!";
                    lblMessage.CssClass = "alert alert-danger";
                }
            }
        }
    }
}