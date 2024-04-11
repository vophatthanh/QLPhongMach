using DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DAL
{
    public class SqlConnectionData
    {
        //tạo chuỗi kết nối
        public static SqlConnection Connect()
        {
            string strcon = @"Data Source=LAPTOP-E098VM2Q\MSSQLSERVER01;Initial Catalog=QLPhongMach;Integrated Security=True;";
            SqlConnection conn = new SqlConnection(strcon);
            return conn;
        }
    }

    public class DatabaseAccess
    {
        public  static string CheckLogicDTO(TaiKhoan tk)
        {
            string user = null;
            SqlConnection conn = SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand("proc_logic", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("user", tk.Ten_tai_khoan);
            cmd.Parameters.AddWithValue("pass", tk.Mat_khau);
            cmd.Connection = conn;
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while(reader.Read())
                {
                    user = reader.GetString(0);
                }
                reader.Close();
                conn.Close();
            }
            else
            {
                return "Tài khoản hoặc mật khẩu không chính xác!!!";
            }
            return user;
        }
    }
}
