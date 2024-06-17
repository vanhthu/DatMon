using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace DACN.Admin
{
    public partial class Report : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(txtFromDate.Text))
                {
                    // Chuyển đổi từ chuỗi ngày MM/dd/yyyy sang kiểu DateTime
                    DateTime fromDate;
                    if (DateTime.TryParse(txtFromDate.Text, out fromDate))
                    {
                        // Định dạng lại ngày theo "dd/MM/yyyy" và gán lại vào TextBox
                        txtFromDate.Text = fromDate.ToString("dd/MM/yyyy");
                    }
                }

                // Kiểm tra nếu có giá trị trong TextBox đến ngày
                if (!string.IsNullOrEmpty(txtToDate.Text))
                {
                    // Chuyển đổi từ chuỗi ngày MM/dd/yyyy sang kiểu DateTime
                    DateTime toDate;
                    if (DateTime.TryParse(txtToDate.Text, out toDate))
                    {
                        // Định dạng lại ngày theo "dd/MM/yyyy" và gán lại vào TextBox
                        txtToDate.Text = toDate.ToString("dd/MM/yyyy");
                    }
                }
                Session["breadCrum"] = "Doanh thu bán hàng";
                // admin phải đăng nhập thì mới vào trang admin được
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }

                

            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DateTime fromDate = Convert.ToDateTime(txtFromDate.Text);
            DateTime toDate = Convert.ToDateTime(txtToDate.Text);
            if (toDate > DateTime.Now)
            {
                Response.Write("<script>alert('Không hợp lệ! Vui lòng nhập lại!');</script>");
            }
            else if (fromDate > toDate)
            {
                Response.Write("<script>alert('Không hợp lệ! Vui lòng nhập lại!');</script>");
            }
            else
            {
                GetReport(fromDate, toDate);
            }


            //DateTime fromDate, toDate;
            //if (DateTime.TryParse(txtFromDate.Text, out fromDate) && DateTime.TryParse(txtToDate.Text, out toDate))
            //{
            //    fromDate = fromDate.Date;
            //    toDate = toDate.Date;

            //    if (toDate > DateTime.Now)
            //    {
            //        Response.Write("<script>alert('Không hợp lệ! Vui lòng nhập lại!');</script>");
            //    }
            //    else if (fromDate > toDate)
            //    {
            //        Response.Write("<script>alert('Không hợp lệ! Vui lòng nhập lại!');</script>");
            //    }
            //    else
            //    {
            //        // Format date before assigning to TextBox
            //        txtFromDate.Text = fromDate.ToString("dd/MM/yyyy");
            //        txtToDate.Text = toDate.ToString("dd/MM/yyyy");
            //        GetReport(fromDate, toDate);
            //    }
            //}
            //else
            //{
            //    Response.Write("<script>alert('Định dạng ngày không hợp lệ! Vui lòng nhập lại.');</script>");
            //}
        }

        protected void repeatReport_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
        private void GetReport(DateTime fromDate, DateTime toDate)
        {
            double grandTotal = 0;
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("REPORT", cn);
            cmd.Parameters.AddWithValue("@fromDate", fromDate);
            cmd.Parameters.AddWithValue("@toDate", toDate);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                foreach(DataRow row in dt.Rows)
                {
                    grandTotal += Convert.ToDouble(row["tongtien"]);
                }
                lblTotal.Text = "Doanh thu: " + grandTotal + " VNĐ";
                lblTotal.CssClass = "badge badge-primary";
            }
            // thêm dữ liệu bằng repeater
            repeatReport.DataSource = dt;
            repeatReport.DataBind();
        }
    }

}