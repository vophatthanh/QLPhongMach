using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using DAL;
using System.Reflection;

namespace BLL
{
    public class TaiKhoanBLL
    {
        TaiKhoanAccess Tkaccess =new TaiKhoanAccess();
        public string CheckLogic(TaiKhoan taiKhoan)
        {
            if (taiKhoan.Ten_tai_khoan == "")
            {
                return "requeid_taiKhoan";
            }
            if (taiKhoan.Mat_khau=="")
            {
                return "requeid_password";
            }
            string infor = Tkaccess.CheckLogic(taiKhoan);
            return infor;
        }
    }
}
