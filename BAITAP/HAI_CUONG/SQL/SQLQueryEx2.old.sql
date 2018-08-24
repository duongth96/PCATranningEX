use [master]
go

drop database if exists  QLBanHang
go

--go
--Tạo cơ sở dữ liệu QLBH:
if not exists (select 1 from sys.databases where name = 'QLBanHang')
	create database QLBanHang
	on primary(
	name = QLBanHang,
	filename = 'D:\SQL EXE\Sql Ex 2\QLBanHang.mdf',
	size = 5,
	maxsize = 50,
	filegrowth = 5);
else
	print(N'Cơ sở dữ liệu đã tồn tại T.T');

go
------

use QLBanHang;
go

--Tạo và thêm mới dữ liệu vào bảng--
--1_VatTu:
if not exists (select 1 from sys.objects where name = 'VatTu')
	create table VatTu(
		MaVT char(20) unique not null,
		TenVatTu nvarchar(50),
		DonViTinh nchar(10),
		TiLePhanTram int,
		constraint pk_VatTu_MaVT primary key(MaVT)
	);
else
	print(N'Bảng đã tồn tại T.T');

go
---


--2_NhaCungCap:
if not exists (select 1 from sys.objects where name = 'NhaCungCap')
	create table NhaCungCap(
		MaNCC char(20) unique not null,
		TenNhaCungCap nvarchar(50),
		DiaChi nvarchar(50),
		DienThoai char(20),
		constraint pk_NhaCungCap_MaNCC primary key(MaNCC)
	);
else
	print(N'Bảng đã tồn tại T.T');

go
---

--3_DonDatHang:
if not exists (select 1 from sys.objects where name = 'DonDatHang')
	create table DonDatHang(
		MaDDH char(20) unique not null,
		MaNCC char(20) not null,
		NgayDat date,
		constraint pk_DonDatHang_MaDDH primary key(MaDDH),
		constraint fk_DonDatHang_MaNCC foreign key(MaNCC) references NhaCungCap(MaNCC)
	);
else
	print(N'Bảng đã tồn tại T.T');

go
---

--4_ChiTietDonDatHang:
if not exists (select 1 from sys.objects where name = 'ChiTietDonDatHang')
	create table ChiTietDonDatHang(
		MaCTDDH char(20) unique not null,
		MaDDH char(20) not null,
		MaVT char(20) not null,
		SoLuongDat int,
		constraint pk_ChiTietDonDatHang_MaCTDDH primary key(MaCTDDH),
		constraint fk_ChiTietDonDatHang_MaDDH foreign key(MaDDH) references DonDatHang(MaDDH),
		constraint fk_ChiTietDonDatHang_MaVT foreign key(MaVT) references VatTu(MaVT)
	);
else
	print(N'Bảng đã tồn tại T.T');

go
---

--5_PhieuNhapHang:
if not exists (select 1 from sys.objects where name = 'PhieuNhapHang')
	create table PhieuNhapHang(
		MaPN char(20) unique not null,
		MaDDH char(20) not null,
		NgayNhap date,
		constraint pk_PhieuNhapHang_MaPN primary key(MaPN),
		constraint fk_PhieuNhapHang_MaDDH foreign key(MaDDH) references DonDatHang(MaDDH)
	);
else
	print(N'Bảng đã tồn tại T.T');

go
---


--6_ChiTietPhieuNhap:
if not exists (select 1 from sys.objects where name = 'ChiTietPhieuNhap')
	create table ChiTietPhieuNhap(
		MaCTPN char(20) unique not null,
		MaPN char(20) not null,
		MaVT char(20) not null,
		SoLuongNhap int,
		DonGiaNhap int,
		constraint pk_ChiTietPhieuNhap_MaCTPN primary key(MaCTPN),
		constraint fk_ChiTietPhieuNhap_MaPN foreign key(MaPN) references PhieuNhapHang(MaPN),
		constraint fk_ChiTietPhieuNhap_MaVT foreign key(MaVT) references VatTu(MaVT)
	);
else
	print(N'Bảng đã tồn tại T.T');

go
---

--7_PhieuXuatHang:
if not exists (select 1 from sys.objects where name = 'PhieuXuatHang')
	create table PhieuXuatHang(
		MaPX char(20) unique not null,
		NgayXuat date,
		TenKhachHang nvarchar(255),
		constraint pk_PhieuXuatHang primary key(MaPX)
	);
else
	print(N'Bảng đã tồn tại T.T');

go
---


--8_ChiTiePhieutXuat:
if not exists (select 1 from sys.objects where name = 'ChiTietPhieuXuat')
	create table ChiTietPhieuXuat(
		MaCTPX char(20) unique not null,
		MaPX char(20) not null,
		MaVT char(20) not null,
		SoLuongXuat int,
		DonGiaXuat int,
		constraint pk_ChiTietPhieuXuat primary key (MaCTPX),
		constraint fk_ChiTietPhieuXuat foreign key (MaPX) references PhieuXuatHang(MaPX),
		constraint fk_ChiTietPhieuXuat_MaVT foreign key (MaVT) references VatTu(MaVT)
	);
else
	print(N'Bảng đã tồn tại T.T');

go
---
----------------------Ket thuc tao bang--------------------------------

------------Chen du lieu------------------------------------------




insert into VatTu(MaVT,TenVatTu,DonViTinh,TiLePhanTram) values
('VT01',N'Nokia N73',N'Máy',10),
('VT02',N'Nokia N86',N'Máy',10),
('VT03',N'Nokia N86',N'Máy',10),
('VT04',N'Nokia N92',N'Máy',10),
('VT05',N'TellMobile S8800',N'Máy',10),
('VT06',N'TellMobile S6300',N'Máy',20),
('VT07',N'TellMobile S1200',N'Máy',20),
('VT08',N'TellMobile S110i',N'Máy',20);

select * from VatTu;
go
-----

insert into NhaCungCap(MaNCC,TenNhaCungCap,DiaChi,DienThoai) values
('NCC01',N'MobibeVn Miền Bắc',N'TP.Hà Nội','+84 0226668889'),
('NCC02',N'MobileVn Miền Trung',N'TP.Đồng Hới','+84 0256668889'),
('NCC03',N'MobileVn Miền Nam',N'TP.Hồ Chí Minh','+84 0286668889');

select * from NhaCungCap;
go
-----

set dateformat dmy;
go
insert into DonDatHang(MaDDH, MaNCC,NgayDat) values
('DDH1','NCC01','1-1-2018'),
('DDH2','NCC02','11-1-2018'),
('DDH3','NCC03','21-1-2018'),
('DDH4','NCC01','1-3-2018'),
('DDH5','NCC02','11-3-2018'),
('DDH6','NCC03','21-3-2018'),
('DDH7','NCC01','1-6-2018'),
('DDH8','NCC02','11-6-2018'),
('DDH9','NCC03','21-6-2018'),
('DDH10','NCC01','1-9-2018'),
('DDH11','NCC02','11-9-2018'),
('DDH12','NCC03','21-9-2018'),
('DDH13','NCC01','1-12-2018'),
('DDH14','NCC02','11-12-2018'),
('DDH15','NCC03','21-12-2018');

select * from DonDatHang;
go
-----

insert into ChiTietDonDatHang(MaCTDDH,MaDDH,MaVT,SoLuongDat) values
('CTDDH01','DDH01','VT01',200),
('CTDDH02','DDH02','VT01',200),
('CTDDH03','DDH03','VT01',200),
('CTDDH04','DDH04','VT02',200),
('CTDDH05','DDH06','VT02',200),
('CTDDH06','DDH07','VT03',100),
('CTDDH07','DDH08','VT03',100),
('CTDDH08','DDH09','VT03',100),
('CTDDH09','DDH10','VT04',500),
('CTDDH11','DDH11','VT04',200),
('CTDDH12','DDH12','VT04',400),
('CTDDH13','DDH13','VT05',200),
('CTDDH14','DDH14','VT05',200),
('CTDDH15','DDH15','VT05',700);

select * from ChiTietDonDatHang;
go
-----

set dateformat dmy;
go
insert into PhieuNhapHang(MaPN,MaDDH,NgayNhap) values
('PN01','DDH01','10-1-2018'),
('PN02','DDH02','22-1-2018'),
('PN03','DDH03','28-1-2018'),
('PN04','DDH04','10-3-2018'),
('PN05','DDH05','22-3-2018'),
('PN06','DDH06','28-3-2018'),
('PN07','DDH07','10-6-2018'),
('PN08','DDH08','22-6-2018'),
('PN09','DDH09','28-6-2018'),
('PN10','DDH10','10-9-2018'),
('PN11','DDH11','22-9-2018'),
('PN12','DDH12','28-9-2018'),
('PN13','DDH13','10-12-2018'),
('PN14','DDH14','22-12-2018'),
('PN15','DDH15','28-12-2018');

select * from PhieuNhapHang;
go
-----

insert into ChiTietPhieuNhap(MaCTPN,MaPN,MaVT,SoLuongNhap,DonGiaNhap) values
('CTPN01','PN01','VT01',200,8000000),
('CTPN02','PN02','VT01',200,8000000),
('CTPN03','PN03','VT01',200,8000000),
('CTPN04','PN04','VT02',200,10000000),
('CTPN05','PN05','VT02',200,10000000),
('CTPN06','PN06','VT02',200,10000000),
('CTPN07','PN07','VT03',100,11000000),
('CTPN08','PN08','VT03',100,11000000),
('CTPN09','PN09','VT03',100,11000000),
('CTPN10','PN10','VT04',500,4000000),
('CTPN11','PN11','VT04',200,5000000),
('CTPN12','PN12','VT04',400,4500000),
('CTPN13','PN13','VT05',200,3000000),
('CTPN14','PN14','VT05',200,3000000),
('CTPN15','PN15','VT05',700,2500000);

select * from ChiTietPhieuNhap;
go
-----

set dateformat dmy;
go
--set ansi_warnings off
--go
insert into PhieuXuatHang(MaPX,NgayXuat,TenKhachHang) values
('PX01','15-1-2018',N'Nguyễn Hải A'),
('PX02','25-1-2018',N'Nguyễn Hải B'),
('PX03','28-1-2018',N'Nguyễn Hải C'),
('PX04','15-3-2018',N'Nguyễn Hải D'),
('PX05','25-3-2018',N'Nguyễn Hải E'),
('PX06','28-3-2018',N'Nguyễn Hải F'),
('PX07','15-6-2018',N'Nguyễn Hải G'),
('PX08','25-6-2018',N'Nguyễn Hải H'),
('PX09','28-6-2018',N'Nguyễn Hải I'),
('PX10','15-9-2018',N'Nguyễn Hải J'),
('PX11','25-9-2018',N'Nguyễn Hải K'),
('PX12','28-9-2018',N'Nguyễn Hải L'),
('PX13','15-12-2018',N'Nguyễn Hải M'),
('PX14','25-12-2018',N'Nguyễn Hải N'),
('PX15','28-12-2018',N'Nguyễn Hải P');

select * from PhieuXuatHang;
go
-----

insert into ChiTietPhieuXuat(MaCTPX,MaPX,MaVT,SoLuongXuat,DonGiaXuat) values
('CTPX01','PX01','VT01',200,9000000),
('CTPX02','PX02','VT01',200,9000000),
('CTPX03','PX03','VT01',200,9000000),
('CTPX04','PX04','VT02',200,11000000),
('CTPX05','PX05','VT02',200,11000000),
('CTPX06','PX06','VT02',200,11000000),
('CTPX07','PX07','VT03',100,12000000),
('CTPX08','PX08','VT03',100,12000000),
('CTPX09','PX09','VT03',100,12000000),
('CTPX10','PX10','VT04',500,5000000),
('CTPX11','PX11','VT04',200,6000000),
('CTPX12','PX12','VT04',400,5500000),
('CTPX13','PX13','VT05',200,4000000),
('CTPX14','PX14','VT05',200,4000000),
('CTPX15','PX15','VT05',700,3500000);

go


------------------------ket thuc chen du lieu ------------------------------


select * from ChiTietPhieuXuat;
go
-----
----------

--Bài Tập--
--\\EX2 (8/8/2018)//
--1_Tạo CSDL trên SQL Server.
-----
--2_Thiết lập khóa chính, khóa ngoại, tạo liên kết giữa các bảng.
-----
--3_Chèn dữ liệu vào các bảng.
-----
--4.Thực hiện truy vấn thêm, sửa, xóa trên các bảng:

--[Thao tác thêm cột mới trong bảng ChiTietPhieuNhap]:
alter table ChiTietPhieuNhap add DemoThemCot int;

--[Thao tác thêm bản ghi mới trong cột DemoThemCot]:
update ChiTietPhieuNhap set DemoThemCot = 8888888 where MaPN = 1;
update ChiTietPhieuNhap set DemoThemCot = 8888888 where MaPN = 2;
update ChiTietPhieuNhap set DemoThemCot = 8888888 where MaPN = 3;
update ChiTietPhieuNhap set DemoThemCot = 8888888 where MaPN = 4;
update ChiTietPhieuNhap set DemoThemCot = 8888888 where MaPN = 5;

--[Thao tác sửa thuộc tính của cột DemoThemCot trong bảng ChiTietPhieuNhap]:
alter table ChiTietPhieuNhap alter column DemoThemCot numeric;

--[Thao tác sửa bản ghi trong bảng ChiTietPhieuNhap]:
update ChiTietPhieuNhap set DemoThemCot = 9999999 where MaVT =1;

--[Thao tác xóa một cột]
alter table ChiTietPhieuNhap drop column DemoThemCot;
--[Thao tác xóa một và tất cả bản ghi]
delete from ChiTietPhieuNhap;
delete from ChiTietPhieuNhap where DemoThemCot = 8888888;
truncate table ChiTietPhieuNhap; --//Xoa cả Index
-----
--5_Lấy ra danh sách các đơn đặt hàng từ 1/1/2018 đến 1/6/2018:
select * from DonDatHang where NgayDat between '1/1/2018' and '1/6/2018';
-----
--6_Thống kê số lượng mặt hàng theo nhà cung cấp:

-----

--\\Update EX2 (9/8/2018)//
--7_Kiểm tra xem mặt hàng nào được đặt hàng nhiều nhất:

-----
--8_Tìm tất cả mặt hàng bắt đầu bằng chữ T:

-----
--9_Thống kê các mặt hàng  mà có tổng số lượng đặt hàng nhiều hơn 1000:

-----
--10_Tìm tất cả các mặt hàng đã nhập về nhưng chưa xuất:

-----
--11_Tìm tất cả các mặt hàng đã nhập về và đã xuất:

-----
----------

--Lệnh bổ sung--
--Hiển thị các bảng:
Select * from VatTu;
Select * from NhaCungCap;
Select * from DonDatHang;
Select * from ChiTietDonHang;
Select * from PhieuNhapHang;
Select * from ChiTietPhieuNhap;
Select * from PhieuXuatHang;
Select * from ChiTietXuatHang;
-----