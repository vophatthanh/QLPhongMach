use master
create database QLPhongMach
CONTAINMENT = NONE
ON PRIMARY 
( NAME = N'QLPM', FILENAME = N'D:\DAHDT\QLPhongMach\Database\QLPMdata.mdf' , SIZE = 10MB , MAXSIZE = 100MB, FILEGROWTH = 5MB )
LOG ON 
( NAME = N'QLPMlog', FILENAME = N'D:\DAHDT\QLPhongMach\Database\QLPMlog.ldf' , SIZE = 10MB , MAXSIZE = 100MB, FILEGROWTH = 5MB )
GO

use QLPhongMach

CREATE TABLE Quyen(
	Ma_quyen INT PRIMARY KEY NOT NULL,
	Ten_quyen NVARCHAR(50) NOT NULL, 
)

CREATE TABLE Tai_khoan(
	Ma_tai_khoan NVARCHAR(50) PRIMARY KEY NOT NULL,
	Ma_quyen INT NOT NULL,
	Ten_tai_khoan NVARCHAR(50) NOT NULL,
	Mat_khau NVARCHAR(100) NOT NULL
	
	FOREIGN KEY (Ma_quyen) REFERENCES Quyen(Ma_quyen)
);

CREATE PROC proc_logic
@user NVARCHAR(50),
@pass NVARCHAR(50)
AS
BEGIN
	SELECT * FROM Tai_khoan WHERE Ten_tai_khoan = @user AND Mat_khau = @pass
END

CREATE TABLE Chuc_vu (
    Ma_chuc_vu CHAR(2) PRIMARY KEY CHECK (Ma_chuc_vu LIKE '[B][S]' OR Ma_chuc_vu LIKE '[N][V]' ) NOT NULL,
    Ten_chuc_vu NVARCHAR(100) CHECK (Ten_chuc_vu LIKE N'%Bác sĩ%' OR Ten_chuc_vu LIKE N'%Nhân viên hỗ trợ%') NOT NULL
);


CREATE TABLE Nhan_vien (
    Ma_nhan_vien CHAR(5) PRIMARY KEY CHECK (Ma_nhan_vien like '[B][S][0-9][0-9][0-9]' OR Ma_nhan_vien like '[N][V][0-9][0-9][0-9]') NOT NULL,
    Ma_chuc_vu CHAR(2) NOT NULL,
	Ho_ten NVARCHAR(255) NOT NULL,
    So_dien_thoai VARCHAR(20) NOT NULL,
    Gioi_tinh NVARCHAR(10) NOT NULL,
    Dia_chi NVARCHAR(255) NOT NULL,
    Ngay_sinh DATE NOT NULL,
    Luong DECIMAL(10, 2) NOT NULL

	FOREIGN KEY (Ma_chuc_vu) REFERENCES Chuc_vu(Ma_chuc_vu)
);

CREATE TABLE Benh (
    Ma_benh CHAR(3) PRIMARY KEY CHECK (Ma_benh like '[K][2][1]' OR Ma_benh like '[K][7][2]' OR Ma_benh like '[J][1][2]' OR Ma_benh like '[A][3][0]' OR Ma_benh like '[Z][0][0]') NOT NULL,
    Ten_benh NVARCHAR(255) NOT NULL
);

CREATE TABLE Benh_nhan (
    Ma_benh_nhan CHAR(5) PRIMARY KEY CHECK (Ma_benh_nhan like '[B][N][0-9][0-9][0-9]') NOT NULL,
	Ma_benh CHAR(3) CHECK (Ma_benh like '[K][2][1]' OR Ma_benh like '[K][7][2]' OR Ma_benh like '[J][1][2]' OR Ma_benh like '[A][3][0]' OR Ma_benh like '[Z][0][0]') NOT NULL,
    Ho_ten NVARCHAR(255) NOT NULL,
    So_dien_thoai VARCHAR(20) NOT NULL,
    Gioi_tinh NVARCHAR(10) NOT NULL,
    Dia_chi NVARCHAR(255) NOT NULL,
    Nam_sinh DATE

	FOREIGN KEY (Ma_benh) REFERENCES Benh(Ma_benh)
);


CREATE TABLE Thuoc (
    Ma_thuoc INT PRIMARY KEY NOT NULL,
    Ten_thuoc NVARCHAR(255) NOT NULL,
	So_luong INT NOT NULL,
    Gia DECIMAL(10, 2) NOT NULL
);


CREATE TABLE Don_thuoc (
    Ma_don_thuoc INT PRIMARY KEY NOT NULL,
    Ma_benh_nhan CHAR(5) CHECK (Ma_benh_nhan like '[B][N][0-9][0-9][0-9]') NOT NULL,
    Ma_nhan_vien CHAR(5) CHECK (Ma_nhan_vien like '[B][S][0-9][0-9][0-9]') NOT NULL,
    Ma_benh CHAR(3) CHECK (Ma_benh like '[K][2][1]' OR Ma_benh like '[K][7][2]' OR Ma_benh like '[J][1][2]' OR Ma_benh like '[A][3][0]' OR Ma_benh like '[Z][0][0]') NOT NULL,

    FOREIGN KEY (Ma_benh_nhan) REFERENCES Benh_nhan(Ma_benh_nhan),
    FOREIGN KEY (Ma_nhan_vien) REFERENCES Nhan_vien(Ma_nhan_vien),
    FOREIGN KEY (Ma_benh) REFERENCES Benh(Ma_benh)
);
CREATE TABLE Chi_tiet_don_thuoc (
    Ma_don_thuoc INT NOT NULL,
    Ma_thuoc INT NOT NULL,
    So_luong INT NOT NULL,
	Lieu_dung NVARCHAR(50) NOT NULL,
	CONSTRAINT Ma PRIMARY KEY (Ma_don_thuoc, Ma_thuoc),
    FOREIGN KEY (Ma_don_thuoc) REFERENCES Don_thuoc(Ma_don_thuoc),
    FOREIGN KEY (Ma_thuoc) REFERENCES Thuoc(Ma_thuoc)

);

CREATE TABLE Hoa_don (
    Ma_hoa_don INT PRIMARY KEY NOT NULL,
    Ma_don_thuoc INT NOT NULL,
    Tong_so_tien DECIMAL(10, 2) NOT NULL,
    Trang_thai_thanh_toan NVARCHAR(50) NOT NULL,
    FOREIGN KEY (Ma_don_thuoc) REFERENCES Don_thuoc(Ma_don_thuoc)
);

INSERT INTO Benh (Ma_benh, Ten_benh)
VALUES 
    (N'A30', N'Bệnh phong'),
    (N'J12', N'Bệnh viêm phổi do virus'),
    (N'K21', N'Bệnh dạ dày'),
    (N'K72', N'Bệnh suy gan'),
    (N'Z00', N'Chưa xác định');

INSERT INTO Chuc_vu (Ma_chuc_vu, Ten_chuc_vu) 
VALUES 
('BS', N'Bác sĩ chính'),
('NV', N'Nhân viên hỗ trợ');

INSERT INTO Nhan_vien (Ma_nhan_vien, Ma_chuc_vu, Ho_ten, So_dien_thoai, Gioi_tinh, Dia_chi, Ngay_sinh, Luong) 
VALUES 
('BS001', N'BS', N'Võ Phát Thành', '0123456789', N'Nam', N'Hà Nội', CAST(N'2003-02-17' AS Date), 5000000),
('BS002', N'BS', N'Nguyễn Trường Vũ', '0987654321', N'Nữ', N'Hồ Chí Minh', CAST(N'2003-12-24' AS Date), 4500000),
('NV001', N'NV', N'Nguyễn Trường Phong', '0369876543', N'Nam', N'Hải Phòng', CAST(N'2003-12-24' AS Date), 6000000),
('NV002', N'NV', N'Đoàn Thị Ngọc Vân', '0321654987', N'Nữ', N'Đà Nẵng', CAST(N'2003-06-15' AS Date), 5500000);



INSERT INTO Thuoc (Ma_thuoc, Ten_thuoc, So_luong, Gia)
VALUES 
    (101, N'Paracetamol', 100, 5000),
    (102, N'Ibuprofen', 80, 7000),
    (103, N'Amoxicilin', 120, 10000),
    (104, N'Loperamide', 60, 15000),
    (105, N'Gaviscon', 50, 20000);


INSERT INTO Benh_nhan (Ma_benh_nhan, Ho_ten, Ma_benh, Nam_sinh, Dia_chi , Gioi_tinh, So_dien_thoai  )
VALUES 
    (N'BN001', N'Lê Tuấn Đạt', N'A30', CAST(N'2003-03-19' AS Date), N'Chợ Mới', N'Nam', 0978123456 ),
    (N'BN002', N'Huỳnh Phú Lộc', N'J12', CAST(N'2003-05-20' AS Date), N'Long Xuyên', N'Nam', 0988888888),
    (N'BN003', N'Ngô Thanh Phong', N'K21', CAST(N'2003-04-15' AS Date), N'Kiên Giang', N'Nam', 0912345678),
    (N'BN004', N'Dương Phú Khang', N'K72', CAST(N'2003-07-14' AS Date), N'An Giang', N'Nam', 0909876543),
    (N'BN005', N'Đoàn Thanh Khiết', N'J12', CAST(N'2003-08-14' AS Date), N'Long Xuyên', N'Nam', 0987654321);


INSERT INTO Don_thuoc (Ma_don_thuoc, Ma_benh_nhan, Ma_nhan_vien, Ma_benh)
VALUES 
    (1001, N'BN001','BS001', 'A30'),
    (1002, N'BN002','BS002', 'J12'),
    (1003, N'BN003','BS001', 'K72'),
    (1004, N'BN004','BS002', 'K21'),
    (1005, N'BN005','BS001', 'Z00');


INSERT INTO Chi_tiet_don_thuoc ( Ma_don_thuoc, Ma_thuoc, So_luong, Lieu_dung)
VALUES 
    ( 1001, 101, 2, N'Uống 3 lần/ngày'),
    ( 1002, 102, 3, N'Uống 2 viên/trưa'),
    ( 1003, 103, 1, N'Uống 1 viên/chiều'),
    ( 1004, 104, 2, N'Uống 1 viên/sáng'),
    ( 1005, 105, 1, N'Uống 2 viên/tối');


INSERT INTO Hoa_don (Ma_hoa_don, Ma_don_thuoc, Tong_so_tien, Trang_thai_thanh_toan)
VALUES 
    (3001, 1001, 10000, N'Đã thanh toán'),
    (3002, 1002, 21000, N'Chưa thanh toán'),
    (3003, 1003, 10000, N'Đã thanh toán')

INSERT INTO Quyen (Ma_quyen, Ten_quyen)
VALUES 
    (1, N'Bác sĩ'),
    (2, N'Nhân viên');


INSERT INTO Tai_khoan (Ma_tai_khoan, Ma_quyen, Ten_tai_khoan, Mat_khau)
VALUES 
	(N'BAS', 1, N'bacsi', N'123'),
	(N'NAV', 2, N'nhanvien', N'123');

SELECT * FROM Nhan_vien

SELECT * FROM Benh

SELECT * FROM Benh_nhan

SELECT * FROM Hoa_don

SELECT * FROM Don_thuoc

SELECT * FROM Chi_tiet_don_thuoc

SELECT * FROM Quyen

SELECT * FROM Tai_khoan
