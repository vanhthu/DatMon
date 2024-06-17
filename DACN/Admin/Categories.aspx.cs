using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DACN.Admin
{
    public partial class Categories : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Danh mục";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    GetCategories();
                }                
            }
            lbMessage.Visible = false;
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty;
            string imagePath = string.Empty;
            string fileExtention = string.Empty;
            bool isValidToExcute = false;
            int categoryID = Convert.ToInt32(hdnID.Value); 

            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("CATEGORY_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", categoryID == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@categoryID", categoryID);
            cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@isActive", cbIsActive.Checked);

            // xử lý hình ảnh 
            if (fuCategoryImage.HasFile)
            {                
                if (Utils.IsValidExtention(fuCategoryImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtention = Path.GetExtension(fuCategoryImage.FileName);
                    imagePath = "Images/Category/" + obj.ToString() + fileExtention;
                    fuCategoryImage.PostedFile.SaveAs(Server.MapPath("~/Images/Category/") + obj.ToString() + fileExtention);
                    cmd.Parameters.AddWithValue("@imageURL", imagePath);
                    isValidToExcute = true;
                }
                else
                {
                    lbMessage.Visible = true;
                    lbMessage.Text = "Vui lòng chọn định dạng .jpg, .jpeg hoặc .png";
                    lbMessage.CssClass = "alert alert-danger";
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
                    actionName = categoryID == 0 ? "được thêm" : "được cập nhật";
                    lbMessage.Visible = true;
                    lbMessage.Text = "Danh mục " + actionName + " thành công!";
                    lbMessage.CssClass = "alert alert-success";
                    GetCategories();
                    Clear();
                }
                catch (Exception ex)
                {
                    lbMessage.Visible = true;
                    lbMessage.Text = "Không thành công " + ex.Message;
                    lbMessage.CssClass = "alert alert-danger";
                }
                finally
                {
                    cn.Close();
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void GetCategories()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("CATEGORY_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            // thêm dữ liệu bằng repeater
            repeatCategory.DataSource = dt;
            repeatCategory.DataBind();
            //imageCategory.Visible = false;
            //imageCategory.ImageUrl = String.Empty;
        }

        private void Clear()
        {
            txtName.Text = String.Empty;
            cbIsActive.Checked = false;
            hdnID.Value = "0";
            btnAddOrUpdate.Text = "Thêm";
        }

        protected void repeatCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lbMessage.Visible = false;
            cn = new SqlConnection(Connection.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("CATEGORY_CRUD", cn);
                cmd.Parameters.AddWithValue("@action", "GETBYID");
                cmd.Parameters.AddWithValue("@categoryID", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);

                txtName.Text = dt.Rows[0]["name"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["isActive"].ToString());
                imageCategory.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["imageURL"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["imageURL"].ToString();
                imageCategory.Width = 200;
                imageCategory.Height = 200;
                hdnID.Value = dt.Rows[0]["categoryID"].ToString();
                btnAddOrUpdate.Text = "Cập nhật";
                LinkButton btn = e.Item.FindControl("LinkButtonEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";

            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("CATEGORY_CRUD", cn);
                cmd.Parameters.AddWithValue("@action", "DELETE");
                cmd.Parameters.AddWithValue("@categoryID", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    lbMessage.Visible = true;
                    lbMessage.Text = "Xóa danh mục thành công!";
                    lbMessage.CssClass = "alert alert-success";
                    GetCategories();
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

        protected void repeatCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lbl = e.Item.FindControl("lblIsActive") as Label;
                if (lbl.Text == "True")
                {
                    lbl.Text = "Active";
                    lbl.CssClass = "badge badge-success";
                }
                else
                {
                    lbl.Text = "In-Active";
                    lbl.CssClass = "badge badge-danger";
                }
            }
        }
    }
}