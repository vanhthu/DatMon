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
    public partial class Profile : System.Web.UI.Page
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
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
                    getUserDetail();
                    getPurchaseHistory();
                }
            }
        }
        private void getUserDetail()
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("USER_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "SELECTFORPROFILE");
            cmd.Parameters.AddWithValue("@userID", Session["userID"]);
            //System.Diagnostics.Debug.WriteLine("Giá trị của session userID: " + Session["userID"]);

            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            repeatProfile.DataSource = dt;
            repeatProfile.DataBind();

            if (dt.Rows.Count == 1)
            {
                Session["name"] = dt.Rows[0]["name"].ToString();
                Session["email"] = dt.Rows[0]["email"].ToString();
                Session["imageURL"] = dt.Rows[0]["imageURL"].ToString();
                Session["createdDate"] = dt.Rows[0]["createdDate"].ToString();
            }
        }

        private void getPurchaseHistory()
        {
            int stt = 1;
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("HOADON", cn);
            cmd.Parameters.AddWithValue("@action", "LICHSUDONHANG");
            cmd.Parameters.AddWithValue("@userID", Session["userID"]);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);

            dt.Columns.Add("STT", typeof(Int32));
            if(dt.Rows.Count > 0)
            {
                foreach(DataRow row in dt.Rows)
                {
                    row["STT"] = stt;
                    stt++;
                }
            }

            if (dt.Rows.Count == 0)
            {
                repeatPurchaseHistoty.FooterTemplate = null;
                repeatPurchaseHistoty.FooterTemplate = new TuyChinhMau(ListItemType.Footer);
            }
            repeatPurchaseHistoty.DataSource = dt;
            repeatPurchaseHistoty.DataBind();
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

        protected void repeatPurchaseHistoty_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) {
                double grandTotal = 0;
                HiddenField paymentID = e.Item.FindControl("hdnPaymentID") as HiddenField;
                Repeater repeatOrder = e.Item.FindControl("repeatOrder") as Repeater;

                cn = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("HOADON", cn);
                cmd.Parameters.AddWithValue("@action", "IDHOADON");
                cmd.Parameters.AddWithValue("@paymentID", Convert.ToInt32(paymentID.Value));
                cmd.Parameters.AddWithValue("@userID", Session["userID"]);
                cmd.CommandType = CommandType.StoredProcedure;
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        grandTotal += Convert.ToDouble(row["tongtien"]);

                    }
                }

                DataRow dr = dt.NewRow();
                dr["tongtien"] = grandTotal;
                dt.Rows.Add(dr);
                repeatOrder.DataSource = dt;
                repeatOrder.DataBind();
            }            
        }
    }
}