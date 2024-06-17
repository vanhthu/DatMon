using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace DACN.Admin
{
    public partial class Products : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Món ăn";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    GetProducts();
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
            int productID = Convert.ToInt32(hdnID.Value);

            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("PRODUCT_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", productID == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@productID", productID);
            cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@description", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@price", txtPrice.Text.Trim());
            cmd.Parameters.AddWithValue("@quantity", txtQuantity.Text.Trim());
            cmd.Parameters.AddWithValue("@categoryID", ddlCategories.SelectedValue);
            cmd.Parameters.AddWithValue("@isActive", cbIsActive.Checked);

            // xử lý hình ảnh 
            if (fuProductImage.HasFile)
            {
                if (Utils.IsValidExtention(fuProductImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtention = Path.GetExtension(fuProductImage.FileName);
                    imagePath = "Images/Product/" + obj.ToString() + fileExtention;
                    fuProductImage.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + obj.ToString() + fileExtention);
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
                    actionName = productID == 0 ? "được thêm" : "được cập nhật";
                    lbMessage.Visible = true;
                    lbMessage.Text = "Món ăn " + actionName + " thành công!";
                    lbMessage.CssClass = "alert alert-success";
                    GetProducts();
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

        protected void repeatProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lbMessage.Visible = false;
            cn = new SqlConnection(Connection.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("PRODUCT_CRUD", cn);
                cmd.Parameters.AddWithValue("@action", "GETBYID");
                cmd.Parameters.AddWithValue("@productID", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);

                txtName.Text = dt.Rows[0]["name"].ToString();
                txtDescription.Text = dt.Rows[0]["description"].ToString();
                txtPrice.Text = dt.Rows[0]["price"].ToString();
                txtQuantity.Text = dt.Rows[0]["quantity"].ToString();
                ddlCategories.SelectedValue = dt.Rows[0]["categoryID"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["isActive"].ToString());
                imageMonAn.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["imageURL"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["imageURL"].ToString();
                imageMonAn.Width = 200;
                imageMonAn.Height = 200;
                hdnID.Value = dt.Rows[0]["productID"].ToString();
                btnAddOrUpdate.Text = "Cập nhật";
                LinkButton btn = e.Item.FindControl("LinkButtonEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";

            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("PRODUCT_CRUD", cn);
                cmd.Parameters.AddWithValue("@action", "DELETE");
                cmd.Parameters.AddWithValue("@productID", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    lbMessage.Visible = true;
                    lbMessage.Text = "Xóa món ăn thành công!";
                    lbMessage.CssClass = "alert alert-success";
                    GetProducts();
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

        protected void repeatProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblIsActive = e.Item.FindControl("lblIsActive") as Label;
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                if (lblIsActive.Text == "True")
                {
                    lblIsActive.Text = "Active";
                    lblIsActive.CssClass = "badge badge-success";
                }
                else
                {
                    lblIsActive.Text = "In-Active";
                    lblIsActive.CssClass = "badge badge-danger";
                }
                if(Convert.ToInt32(lblQuantity.Text) <= 5)
                {
                    lblQuantity.CssClass = "badge badge-danger";
                    lblQuantity.ToolTip = "Món ăn này sắp hết!";
                }
            }
        }
        private void GetProducts()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("PRODUCT_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            // thêm dữ liệu bằng repeater
            repeatProduct.DataSource = dt;
            repeatProduct.DataBind();
            
        }

        private void Clear()
        {
            txtName.Text = String.Empty;
            txtDescription.Text = String.Empty;
            txtPrice.Text = String.Empty;
            txtQuantity.Text = String.Empty;
            ddlCategories.ClearSelection();
            cbIsActive.Checked = false;
            hdnID.Value = "0";
            btnAddOrUpdate.Text = "Thêm";
            imageMonAn.ImageUrl = string.Empty;
        }
    }
}