using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DACN.User
{
    public partial class User : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.Url.AbsoluteUri.ToString().Contains("TrangChu.aspx"))
            {
                form1.Attributes.Add("class", "sub_page");
            }
            else
            {
                form1.Attributes.Remove("class");
                // load control
                Control sliderControl = (Control)Page.LoadControl("SliderControl.ascx");
                panelSlider.Controls.Add(sliderControl);
            }

            if (Session["userID"] == null)
            {
                lbLoginOrLogOut.Text = "Đăng nhập";
                Session["CartCount"] = "0";
            }
            else
            {
                lbLoginOrLogOut.Text = "Đăng xuất";
                Utils utils = new Utils();
                Session["CartCount"] = utils.CartCount(Convert.ToInt32(Session["userID"])).ToString();
            }
        }

        protected void lbLoginOrLogOut_Click(object sender, EventArgs e)
        {
            if (Session["userID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Session.Abandon();
                Response.Redirect("Login.aspx");
            }
        }

        protected void lbRegisterOrProfile_Click(object sender, EventArgs e)
        {
            if (Session["userID"] == null)
            {
                lbRegisterOrProfile.ToolTip = "Thông tin đăng ký";
                Response.Redirect("Registeration.aspx");
            }
            else
            {
                lbRegisterOrProfile.ToolTip = "Thông tin người dùng";
                Response.Redirect("Profile.aspx");
            }
        }
    }
}