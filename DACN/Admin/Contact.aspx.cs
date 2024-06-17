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
    public partial class Contact : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Phản hồi";
                // admin phải đăng nhập thì mới vào trang admin được
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    GetContact();
                }
            }
        }

        protected void repeatContact_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                cn = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("CONTACTPro", cn);
                cmd.Parameters.AddWithValue("@action", "DELETE");
                cmd.Parameters.AddWithValue("@contactID", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    lbMessage.Visible = true;
                    lbMessage.Text = "Xóa phản hồi thành công!";
                    lbMessage.CssClass = "alert alert-success";
                    GetContact();
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
        private void GetContact()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("CONTACTPro", cn);
            cmd.Parameters.AddWithValue("@action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            // thêm dữ liệu bằng repeater
            repeatContact.DataSource = dt;
            repeatContact.DataBind();
        }
    }
}