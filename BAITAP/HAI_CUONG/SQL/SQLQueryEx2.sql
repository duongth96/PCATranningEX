use [master]
go

drop database if exists  QLBanHang
go

--go
--Tạo cơ sở dữ liệu QLBH--
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

--Trỏ đến CSDL QLBanHang:
use QLBanHang;
go

--Tạo bảng--
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
	ALTER TABLE DonDatHang ADD CONSTRAINT pk_DonDatHang_MaDDH PRIMARY KEY(MaDDH);
	ALTER TABLE DonDatHang ADD CONSTRAINT fk_DonDatHang_MaNCC FOREIGN KEY(MaNCC) references NhaCungCap(MaNCC);
go

--4_ChiTietDonDatHang:
if not exists (select 1 from sys.objects where name = 'ChiTietDonDatHang')
	create table ChiTietDonDatHang(
		MaDDH char(20) not null,
		MaVT char(20) not null,
		SoLuongDat bigint,
		constraint pk_ChiTietDonDatHang_MaCTDDH primary key(MaDDH, MaVT),
		constraint fk_ChiTietDonDatHang_MaDDH foreign key(MaDDH) references DonDatHang(MaDDH),
		constraint fk_ChiTietDonDatHang_MaVT foreign key(MaVT) references VatTu(MaVT)
	);
else
	print(N'Bảng đã tồn tại T.T');

go

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

--6_ChiTietPhieuNhap:
if not exists (select 1 from sys.objects where name = 'ChiTietPhieuNhap')
	create table ChiTietPhieuNhap(
		MaPN char(20) not null,
		MaVT char(20) not null,
		SoLuongNhap bigint,
		DonGiaNhap money,
		constraint pk_ChiTietPhieuNhap_MaCTPN primary key(MaPN, MaVT),
		constraint fk_ChiTietPhieuNhap_MaPN foreign key(MaPN) references PhieuNhapHang(MaPN),
		constraint fk_ChiTietPhieuNhap_MaVT foreign key(MaVT) references VatTu(MaVT)
	);
else
	print(N'Bảng đã tồn tại T.T');

go

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

--8_ChiTiePhieutXuat:
if not exists (select 1 from sys.objects where name = 'ChiTietPhieuXuat')
	create table ChiTietPhieuXuat(
		MaPX char(20) not null,
		MaVT char(20) not null,
		SoLuongXuat bigint,
		DonGiaXuat money,
		constraint pk_ChiTietPhieuXuat primary key (MaPX, MaVT),
		constraint fk_ChiTietPhieuXuat foreign key (MaPX) references PhieuXuatHang(MaPX),
		constraint fk_ChiTietPhieuXuat_MaVT foreign key (MaVT) references VatTu(MaVT)
	);
else
	print(N'Bảng đã tồn tại T.T');

go

--9_TonKho:
create table TonKho(
NamThang char,
MaVT char(20),
SLDau int CHECK(SLDau>0), --Check SL > 0 <Cách 2>
SLCuoi int CHECK(SLCuoi>0),
TongSLNhap int CHECK(TongSLNhap>0),
TongSLXuat int CHECK(TongSLXuat>0),
constraint fk_TonKho_MaVT foreign key(MaVT) references VatTu(MaVT)
);
go
SELECT * FROM TonKho;
---------------------------------------------------------------------------
--Chèn dữ liệu vào bảng--

--1_VatTu:
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

--2_NhaCungCap:
insert into NhaCungCap(MaNCC,TenNhaCungCap,DiaChi,DienThoai) values
('NCC01',N'MobibeVn Miền Bắc',N'TP.Hà Nội','+84 0226668889'),
('NCC02',N'MobileVn Miền Trung',N'TP.Đồng Hới','+84 0256668889'),
('NCC03',N'MobileVn Miền Nam',N'TP.Hồ Chí Minh','+84 0286668889');

select * from NhaCungCap;
go

--3_DonDatHang:
set dateformat dmy;
go
insert into DonDatHang(MaDDH, MaNCC,NgayDat) values
('DDH01','NCC01','1-1-2018'),
('DDH02','NCC02','11-1-2018'),
('DDH03','NCC03','21-1-2018'),
('DDH04','NCC01','1-3-2018'),
('DDH05','NCC02','11-3-2018'),
('DDH06','NCC03','21-3-2018'),
('DDH07','NCC01','1-6-2018'),
('DDH08','NCC02','11-6-2018'),
('DDH09','NCC03','21-6-2018'),
('DDH10','NCC01','1-9-2018'),
('DDH11','NCC02','11-9-2018'),
('DDH12','NCC03','21-9-2018'),
('DDH13','NCC01','1-12-2018'),
('DDH14','NCC02','11-12-2018'),
('DDH15','NCC03','21-12-2018');

select * from DonDatHang;
go

--4_ChiTietDonDatHang:
insert into ChiTietDonDatHang(MaDDH,MaVT,SoLuongDat) values
('DDH01','VT01',200),
('DDH02','VT01',200),
('DDH03','VT01',200),
('DDH04','VT02',200),
('DDH06','VT02',200),
('DDH07','VT03',100),
('DDH08','VT03',100),
('DDH09','VT03',100),
('DDH10','VT04',500),
('DDH11','VT04',200),
('DDH12','VT04',400),
('DDH13','VT05',200),
('DDH14','VT05',200),
('DDH15','VT05',700);

select * from ChiTietDonDatHang;
go

--5_PhieuNhapHang:
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

--6_ChiTietPhieuNhap:
insert into ChiTietPhieuNhap(MaPN,MaVT,SoLuongNhap,DonGiaNhap) values
('PN01','VT01',200,8000000),
('PN02','VT01',200,8000000),
('PN03','VT01',200,8000000),
('PN04','VT02',200,10000000),
('PN05','VT02',200,10000000),
('PN06','VT02',200,10000000),
('PN07','VT03',100,11000000),
('PN08','VT03',100,11000000),
('PN09','VT03',100,11000000),
('PN10','VT04',500,4000000),
('PN11','VT04',200,5000000),
('PN12','VT04',400,4500000),
('PN13','VT05',200,3000000),
('PN14','VT05',200,3000000),
('PN15','VT05',700,2500000);

select * from ChiTietPhieuNhap;
update ChiTietPhieuNhap set SoLuongNhap = 100 where MaPN = 'PN14' AND MaVT = 'VT05'
go

--7_PhieuXuatHang:
set dateformat dmy;
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

--8_ChiTiePhieutXuat:
insert into ChiTietPhieuXuat(MaPX,MaVT,SoLuongXuat,DonGiaXuat) values
('PX01','VT01',100,9000000),
('PX02','VT01',100,9000000),
('PX03','VT01',100,9000000),
('PX04','VT02',100,11000000),
('PX05','VT02',100,11000000),
('PX06','VT02',100,11000000),
('PX07','VT03',50,12000000),
('PX08','VT03',50,12000000),
('PX09','VT03',50,12000000),
('PX10','VT04',400,5000000),
('PX11','VT04',100,6000000),
('PX12','VT04',300,5500000),
('PX13','VT05',100,4000000),
('PX14','VT05',100,4000000),
('PX15','VT05',600,3500000);			

select * from ChiTietPhieuXuat;
go

--9_TonKho:
set dateformat dmy;
insert into TonKho(MaVT, NamThang, SLCuoi, SLDau, TongSLNhap, TongSLXuat) values
('VT01', '1/1/2019', 100, 200, 600, 300),
('VT01', '1/2/2019', 100, 200, 600, 300),
('VT01', '1/3/2019', 100, 100, 600, 300),
('VT02', '1/4/2019', 100, 200, 600, 300),
('VT02', '1/5/2019', 100, 200, 600, 300),
('VT02', '1/6/2019', 100, 200, 600, 300),
('VT03', '1/7/2019', 50, 100, 300, 150),
('VT03', '1/8/2019', 50, 100, 300, 150),
('VT03', '1/9/2019', 50, 100, 300, 150),
('VT04', '1/10/2019', 400, 500, 600, 300),
('VT04', '1/11/2019', 100, 200, 600, 300),
('VT04', '1/12/2019', 300, 400, 600, 300),
('VT05', '1/1/2020', 100, 200, 600, 300),
('VT05', '1/2/2020', 100, 200, 600, 300),
('VT05', '1/3/2020', 600, 700, 600, 300);
---------------------------------------END---------------------------------

------Bài Tập------
--\\EX2 (8/8/2018)//
--1_Tạo CSDL trên SQL Server.
--Done--
-----
--2_Thiết lập khóa chính, khóa ngoại, tạo liên kết giữa các bảng.
--Done--
-----
--3_Chèn dữ liệu vào các bảng.
--Done--
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
--6_Thống kê số lượng mặt hàng theo nhà cung cấp - Sắp xếp theo miền:
select NhaCungCap.TenNhaCungCap, VatTu.TenVatTu, sum(ChiTietPhieuNhap.SoLuongNhap)[Số lượng theo miền] from NhaCungCap, VatTu, ChiTietPhieuNhap group by TenNhaCungCap, TenVatTu;

-----

--\\Update EX2 (9/8/2018)//
--7_Kiểm tra xem mặt hàng nào được đặt hàng nhiều nhất:
SELECT TOP 1 MaVT, MAX(SoLuongDat)[VT Đặt Nhiều Nhất] FROM ChiTietDonDatHang GROUP BY MaVT ORDER BY MAX(SoLuongDat) DESC;
SELECT * FROM ChiTietDonDatHang;
--8_Tìm tất cả mặt hàng bắt đầu bằng chữ T:
SELECT VatTu.TenVatTu FROM VatTu WHERE TenVatTu LIKE 'T%';
-----
--9_Thống kê các mặt hàng  mà có tổng số lượng đặt hàng nhiều hơn 1000:
SELECT ChiTietDonDatHang.MaVT, SUM(ChiTietDonDatHang.SoLuongDat)[Tổng MH > 1000] FROM ChiTietDonDatHang GROUP BY MaVT HAVING SUM(ChiTietDonDatHang.SoLuongDat) > 1000;
SELECT * FROM ChiTietDonDatHang;
-----
--10.1_Tìm tất cả các mặt hàng đã nhập về nhưng chưa xuất:
SELECT * FROM VatTu WHERE MaVT IN (SELECT MaVT FROM ChiTietPhieuNhap) AND MaVT NOT IN (SELECT MaVT FROM ChiTietPhieuXuat);
-----
--10.2_Tìm tất cả các mặt hàng đã nhập về và đã xuất:
SELECT * FROM VatTu WHERE MaVT IN (SELECT MaVT FROM ChiTietPhieuNhap) AND MaVT IN (SELECT MaVT FROM ChiTietPhieuXuat);
-----
--\\Update EX2 (10/8/2018)//
--11_Tạo bảng tồn kho:
--Done--
-----
--12_Đặt điều kiện ràng buộc giá trị nhập vào cho các trường số lượng có giá trị lớn hơn không, giá trị ngày tháng lớn hơn 1/1/1999 và nhỏ hơn 31/12/2999:
ALTER TABLE TonKho ADD CONSTRAINT ck_TonKho_SL CHECK (SLDau > 0 and SLCuoi > 0 and TongSLNhap > 0 and TongSLXuat > 0); --Check SL > 0 <Cách 1>
go
alter table TonKho alter column NamThang date; --Check Ngày Tháng <Cách 1>
alter table TonKho add constraint ck_TonKho_NamThang check(NamThang > 1/1/1991 and NamThang < 31/12/2999);
go
-----
--13_Truy vấn danh sách các phiếu đặt hàng chưa được nhập hàng:
SELECT * FROM DonDatHang WHERE MaDDH NOT IN (SELECT MaDDH FROM PhieuNhapHang);
-----
--14_Lấy thông tin nhà cung cấp có nhiều đơn đặt hàng nhất:
SELECT NhaCungCap.MaNCC, TenNhaCungCap, DiaChi, DienThoai, COUNT(MaDDH)[NCCNhieuDonDatHangNhat] FROM NhaCungCap 
LEFT JOIN DonDatHang ON NhaCungCap.MaNCC = DonDatHang.MaNCC GROUP BY NhaCungCap.MaNCC, TenNhaCungCap, DiaChi, DienThoai;
SELECT * FROM DonDatHang;
SELECT * FROM NhaCungCap;
-----
--15_Lấy thông tin vật tư được xuất bán nhiều nhất:
SELECT TOP 2 VatTu.MaVT, VatTu.TenVatTu, VatTu.DonViTinh, VatTu.TiLePhanTram, SUM(SoLuongXuat)[VTXuatBanNhieuNhat] FROM VatTu LEFT JOIN ChiTietPhieuXuat ON VatTu.MaVT = ChiTietPhieuXuat.MaVT GROUP BY VatTu.MaVT, VatTu.TenVatTu, VatTu.DonViTinh, VatTu.TiLePhanTram ORDER BY VTXuatBanNhieuNhat DESC;
SELECT * FROM VatTu;
SELECT * FROM ChiTietPhieuXuat;
-----
--16_Tính tổng tiền của các đơn đặt hàng, đưa ra đơn đặt hàng có giá trị lớn nhất:
SELECT ChiTietDonDatHang.MaDDH, SUM(SoLuongDat * DonGiaNhap)[Tổng Tiền]
FROM ChiTietDonDatHang LEFT JOIN ChiTietPhieuNhap 
ON ChiTietDonDatHang.MaVT = ChiTietPhieuNhap.MaVT GROUP BY MaDDH;
SELECT TOP 1 ChiTietDonDatHang.MaDDH, SUM(SoLuongDat * DonGiaNhap)[Tổng Tiền]
FROM ChiTietDonDatHang LEFT JOIN ChiTietPhieuNhap 
ON ChiTietDonDatHang.MaVT = ChiTietPhieuNhap.MaVT
GROUP BY MaDDH ORDER BY [Tổng Tiền] DESC;

SELECT * FROM ChiTietDonDatHang;
SELECT * FROM ChiTietPhieuNhap;
-----
--17_Thống kê những đơn đặt hàng chưa nhập đủ số lượng:
SELECT Ctddh.MaVT, Ctddh.MaDDH, Ctpn.MaPN, SoLuongDat, SoLuongNhap FROM ChiTietDonDatHang Ctddh LEFT JOIN ChiTietPhieuNhap Ctpn ON 
Ctddh.MaVT = Ctpn.MaVT WHERE SoLuongDat = SoLuongNhap;
-----
--18_Tạo View  vw_DMVT gồm (MAVTu và TenVTu) dùng liệt kê các danh sách trong bảng vật tư:
CREATE VIEW Vw_DMVT AS SELECT MaVT, TenVatTu FROM VatTu;
SELECT * FROM Vw_DMVT;
-----
--19_Tạo View vw_DonDH_Tong SLDatNhap gồm (SoDH, TongSLDat và TongSLNhap) dùng để thống kê những đơn đặt hàng đã được nhập hàng đầy đủ:
CREATE VIEW Vw_DonDH_Tong(SoDH,TongSLDat,TongSLNhap) AS SELECT 
MaDDH, SUM(SoLuongDat)[TongSLDat], SUM(SoLuongNhap)[TongSLNhap] FROM ChiTietDonDatHang Ctddh LEFT JOIN ChiTietPhieuNhap Ctpn ON 
Ctddh.MaVT = Ctpn.MaVT GROUP BY MaDDH HAVING SUM(SoLuongDat) = SUM(SoLuongNhap);
SELECT * FROM Vw_DonDH_Tong;
-----
--20_Tạo View vw_DonDH_DaNhapDu gồm (Số DH, DaNhapDu) có hai giá trị là “Da Nhap Du” nếu đơn hàng đó đã nhập đủ 
--hoặc “Chua Nhap Du” nếu đơn đặt hàng chưa nhập đủ:
CREATE VIEW Vw_DonDH_DaNhapDu AS 
SELECT DISTINCT ChiTietDonDatHang.MaDDH[So DH], ChiTietDonDatHang.MaVT, CASE 
WHEN SoLuongNhap = SoLuongDat THEN 'Da Nhap Du'
ELSE 'Chua Nhap Du'
END
AS DaNhapDu 
FROM ChiTietPhieuNhap, ChiTietDonDatHang, PhieuNhapHang
WHERE ChiTietPhieuNhap.MaPN = PhieuNhapHang.MaPN AND ChiTietDonDatHang.MaDDH = PhieuNhapHang.MaDDH AND ChiTietDonDatHang.MaVT = ChiTietPhieuNhap.MaVT
GO
SELECT * FROM Vw_DonDH_DaNhapDu;
-----
--21_Tạo View vw_TongNhap gồm (NamThang, MaVTu và TongSLNhap) dùng để thống kê số lượng nhập của các vật tư trong 
--năm tháng tương ứng (Không sử dụng bảng tồn kho):

-----
--22_Tạo View vw_TongXuat gồm (NamThang, MaVTu và TongSLXuat) dùng để thống kê SL xuất của vật tư 
--trong từng năm tương ứng (Không sử dụng bảng tồn kho):

-----
--//Upddate EX2(15/8) – Store Procedure, Trigger, Fuction And Transaction\\
--23_Tạo Stored procedure (SP) cho biết tổng số lượng cuối của vật tư với mã vật tư là tham số vào:

-----
--24_Tạo SP cho biết tổng tiền xuất của vật tư với mã vật tư là tham số vào:

-----
--25_Tạo SP cho biết tổng số lượng đặt theo số đơn hàng với số đơn hàng là tham số vào:

-----
--26_Tạo SP dùng để thêm một đơn đặt hàng:

-----
--27_Tạo SP dùng để thêm một chi tiết đơn đặt hang:

-----
--28_Tạo trigger kiểm soát quá trình thêm dữ liệu vào bảng vật tư, đưa ra thông báo khi số lượng vật tư vượt quá 100 sp:

-----
----------

--Lệnh bổ sung--
--Hiển thị các bảng:
Select * from VatTu;
Select * from NhaCungCap;
Select * from DonDatHang;
Select * from ChiTietDonDatHang;
Select * from PhieuNhapHang;
Select * from ChiTietPhieuNhap;
Select * from PhieuXuatHang;
Select * from ChiTietPhieuXuat;
-----