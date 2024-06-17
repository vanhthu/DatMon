using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DACN.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Người dùng";
                // admin phải đăng nhập thì mới vào trang admin được
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    LayThongTinNguoiDung();
                }
            }
        }

        protected void repeatUser_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                cn = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("USER_CRUD", cn);
                cmd.Parameters.AddWithValue("@action", "DELETE");
                cmd.Parameters.AddWithValue("@userID", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    lbMessage.Visible = true;
                    lbMessage.Text = "Xóa người dùng thành công!";
                    lbMessage.CssClass = "alert alert-success";
                    LayThongTinNguoiDung();
                }
                catch (Exception ex)
                {
                    lbMessage.Visible = true;
                    lbMessage.Text = "Lỗi: " + ex.Message;
                    lbMessage.CssClass = "alert alert-danger";
                }
                finally
                {
                    cn.Close();
                }
            }
        }

        protected void repeatUser_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }
        private void LayThongTinNguoiDung()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("USER_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "SELECTFORADMIN");
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            // thêm dữ liệu bằng repeater
            repeatUser.DataSource = dt;
            repeatUser.DataBind();
        }
    }
}