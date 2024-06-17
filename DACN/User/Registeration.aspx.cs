using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace DACN.User
{
    public partial class Registeration : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    GetUserDetail();
                }
                else if (Session["userID"] != null)
                {
                    Response.Redirect("TrangChu.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty;
            string imagePath = string.Empty;
            string fileExtention = string.Empty;
            bool isValidToExcute = false;
            int userID = Convert.ToInt32(Request.QueryString["id"]);

            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("USER_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", userID == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@userID", userID);
            cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@username", txtUserName.Text.Trim());
            cmd.Parameters.AddWithValue("@mobile", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@address", txtAddress.Text.Trim());
            cmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());            

            // xử lý hình ảnh 
            if (fuUserImage.HasFile)
            {
                if (Utils.IsValidExtention(fuUserImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtention = Path.GetExtension(fuUserImage.FileName);
                    imagePath = "Images/User/" + obj.ToString() + fileExtention;
                    fuUserImage.PostedFile.SaveAs(Server.MapPath("~/Images/User/") + obj.ToString() + fileExtention);
                    cmd.Parameters.AddWithValue("@imageURL", imagePath);
                    isValidToExcute = true;
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Vui lòng chọn định dạng .jpg, .jpeg hoặc .png";
                    lblMessage.CssClass = "alert alert-danger";
                    isValidToExcute = false;
                }
            }
            else
            {
                isValidToExcute = true;
            }
            if (isValidToExcute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    actionName = userID == 0 ? "Đăng ký thành công! <b><a href='Login.aspx'>Nhấn vào đây</a></b> để đăng nhập." :
                                               "Thông tin được cập nhật thành công! <b><a href='Profile.aspx'>Nhấn vào đây</a></b>";
                    lblMessage.Visible = true;
                    lblMessage.Text = "<b>" + txtUserName.Text.Trim() + "</b>" + actionName;
                    lblMessage.CssClass = "alert alert-success";
                    if (userID != 0)
                    {
                        Response.AddHeader("REFRESH", "1;URL=Profile.aspx");
                    }
                    Clear();
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("Violation of UNIQUE KEY constraint"))
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "<b>" + txtUserName.Text.Trim() + "</b>" + " tên đã tồn tại. Vui lòng chọn tên khác!";
                        lblMessage.CssClass = "alert alert-danger";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Không thành công " + ex.Message;
                    lblMessage.CssClass = "alert alert-danger";
                }
                finally
                {
                    cn.Close();
                }
            }
        }
        private void Clear()
        {
            txtName.Text = string.Empty;
            txtUserName.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtPassword.Text = string.Empty;
            //txtRePassWord.Text = string.Empty;         
        }
        private void GetUserDetail()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("USER_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "SELECTFORPROFILE");
            cmd.Parameters.AddWithValue("@userID", Request.QueryString["id"]);
            cmd.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count == 1)
            {
                txtName.Text = dt.Rows[0]["name"].ToString();
                txtUserName.Text = dt.Rows[0]["username"].ToString();
                txtMobile.Text = dt.Rows[0]["mobile"].ToString();
                txtEmail.Text = dt.Rows[0]["email"].ToString();
                txtAddress.Text = dt.Rows[0]["address"].ToString();                
                imgUser.ImageUrl = String.IsNullOrEmpty(dt.Rows[0]["imageURL"].ToString()) ?
                    "../Images/No_image.png" :
                    "../" + dt.Rows[0]["imageURL"].ToString();

                imgUser.Width = 200;
                imgUser.Height = 200;
                txtPassword.TextMode = TextBoxMode.SingleLine;
                txtPassword.ReadOnly = true;
                txtPassword.Text = dt.Rows[0]["password"].ToString();
                //txtRePassWord.Text = dt.Rows[0]["repassword"].ToString();
            }
            lblHeaderMessage.Text = "<h2>Cập nhật thông tin</h2>";
            btnRegister.Text = "Cập nhật";
            lblDaDK.Text = "";
        }
    }
}