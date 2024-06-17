using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Drawing;

namespace DACN
{
    public class Connection
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        }
    }
    public class Utils
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        public static bool IsValidExtention(string fileName)
        {
            bool isValid = false;
            string[] fileExtention = { ".jpg", ".png", ".jpeg" };

            for (int i = 0; i <= fileExtention.Length - 1; i++)
            {
                if (fileName.Contains(fileExtention[i]))
                {
                    isValid = true;
                    break;
                }
            }
            return isValid;
        }


        public static string GetImageURL(object url)
        {
            string url1 = "";
            if (string.IsNullOrEmpty(url.ToString()) || url == DBNull.Value)
            {
                url1 = "../Images/No_image.png";
            }
            else
            {
                url1 = string.Format("../{0}", url);
            }
            return url1;

        }

        public bool UpdateCartQuantity(int quantity, int productID, int userID)
        {
            bool isUpdated = false;
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("CART_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "UPDATE");
            cmd.Parameters.AddWithValue("@productID", productID);
            cmd.Parameters.AddWithValue("@quantity", quantity);
            cmd.Parameters.AddWithValue("@userID", userID);
            cmd.CommandType = CommandType.StoredProcedure;

            try
            {
                cn.Open();
                cmd.ExecuteNonQuery();
                isUpdated = true;
            }
            catch (Exception ex)
            {
                isUpdated = false;
                System.Web.HttpContext.Current.Response.Write("<script> alert('Lỗi - " + ex.Message + "'); </script>");
            }
            finally
            {
                cn.Close();
            }
            return isUpdated;

        }

        public int CartCount(int userID)
        {
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("CART_CRUD", cn);
            cmd.Parameters.AddWithValue("@action", "SELECT");
            cmd.Parameters.AddWithValue("@userID", userID);
            cmd.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(cmd);
            dt = new DataTable();

            da.Fill(dt);
            return dt.Rows.Count;
        }

        public static string GetUniqueID()
        {
            Guid guid = new Guid();
            String uniqueID = guid.ToString();
            return uniqueID;
        }
    }
    public class DashboardCount
    {
        SqlConnection cn;
        SqlCommand cmd;
        SqlDataReader dr;
        public decimal Count(string tableName)
        {
            decimal count = 0;
            cn = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("DASHBOARD", cn);
            cmd.Parameters.AddWithValue("@action", tableName);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if (dr[0] == DBNull.Value)
                {
                    count = 0;
                }
                else
                {
                    count = Convert.ToDecimal(dr[0]);
                    
                }
            }
            dr.Close();
            cn.Close();
            return count;
        }
    }
}