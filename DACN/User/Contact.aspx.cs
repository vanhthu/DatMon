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
    public partial class Contact : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                cn = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("CONTACTPro", cn);
                cmd.Parameters.AddWithValue("@action", "INSERT");
                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@subject", txtSubject.Text.Trim());
                cmd.Parameters.AddWithValue("@message", txtMessage.Text.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                cmd.ExecuteNonQuery();
                lblMessage.Visible = true;
                lblMessage.Text = "Cảm ơn sự phản hồi của bạn!";
                lblMessage.CssClass = "alert alert-success";
                Clear();
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('"+ex.Message+"')</script>");
            }
            finally
            {
                cn.Close();
            }
        }

        private void Clear()
        {
            txtName.Text = String.Empty;
            txtEmail.Text = String.Empty;
            txtSubject.Text = String.Empty;
            txtMessage.Text = String.Empty;
        }
    }
}