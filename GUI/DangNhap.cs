using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BLL;
using DTO;

namespace GUI
{
    public partial class DangNhap : Form
    {
        TaiKhoan tk = new TaiKhoan();
        TaiKhoanBLL TkBLL = new TaiKhoanBLL();
        public DangNhap()
        {
            InitializeComponent();
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            tk.Ten_tai_khoan = txtTaiKhoan.Text;
            tk.Mat_khau = txtMk.Text;

            string getuser = TkBLL.CheckLogic(tk);

            switch (getuser)
            {
                case "requeid_taikhoan":
                    MessageBox.Show("Tài khoản không được để trống");
                    return;
                case "requeid_password":
                    MessageBox.Show("Không được để trống mật khẩu");
                    return;
                case "Tài khoản hoặc mật khẩu không chính xác!!!":
                    MessageBox.Show("Tài khoản hoặc mật khẩu không chính xác!!!");
                    return;
            }
            MessageBox.Show("Đăng nhập thành công");
        }
        
    }
}
