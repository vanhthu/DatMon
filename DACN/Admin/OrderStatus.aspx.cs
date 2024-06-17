using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace DACN.Admin
{
    public partial class OrderStatus : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Trạng thái đơn hàng";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    GetOrderStatus();
                }
            }
            lbMessage.Visible = false;
            panelUpdateStatus.Visible= false;
        }

        protected void repeatOrderStatus_ItemCommand(object source, RepeaterCommandEventArgs e)
        {            
            lbMessage.Visible = false;
            cn = new SqlConnection(Connection.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("HOADON", cn);
                cmd.Parameters.AddWithValue("@action", "TRANGTHAIDONHANGID");
                cmd.Parameters.AddWithValue("@orderDetailsID", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);

                string status = dt.Rows[0]["status"].ToString();

                // Kiểm tra xem giá trị status có tồn tại trong DropDownList không
                ListItem item = ddlOrderStatus.Items.FindByValue(status);
                if (item != null)
                {
                    ddlOrderStatus.SelectedValue = status;
                }
                else
                {
                    
                    ddlOrderStatus.SelectedIndex = 0; // Chọn mục mặc định
                    
                }

                hdnID.Value = dt.Rows[0]["orderDetailsID"].ToString();
                panelUpdateStatus.Visible = true;

                LinkButton btn = e.Item.FindControl("LinkButtonEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int orderDetailsID = Convert.ToInt32(hdnID.Value);

            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("HOADON", cn);
            cmd.Parameters.AddWithValue("@action", "CAPNHATTRANGTHAI");
            cmd.Parameters.AddWithValue("@orderDetailsID", orderDetailsID);            
            cmd.Parameters.AddWithValue("@trangthai", ddlOrderStatus.SelectedValue);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                cn.Open();
                cmd.ExecuteNonQuery();
                
                lbMessage.Visible = true;
                lbMessage.Text = "Cập nhật trạng thái thành công!";
                lbMessage.CssClass = "alert alert-success";
                GetOrderStatus();
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

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            panelUpdateStatus.Visible = false;
        }
        private void GetOrderStatus()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("HOADON", cn);
            cmd.Parameters.AddWithValue("@action", "TRANGTHAIDONHANG");           
            cmd.Parameters.AddWithValue("@trangthai", ddlOrderStatus.SelectedValue);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            repeatOrderStatus.DataSource = dt;
            repeatOrderStatus.DataBind();
            
        }
        

    }
}