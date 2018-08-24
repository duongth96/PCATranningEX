-- CSDL --
-- Tạo cơ sở dữ liệu với điều kiện không tồn tại:
	if not exists (select 1 from sys.databases where name = 'db_news')
		begin
			create database db_news
			on primary(
				name = db_news,
				filename = 'D:\SQL EXE\db_news.mdf',
				size = 5,
				maxsize = 50,
				filegrowth = 5);
		end;
	else
		begin
			print N'Cơ sở dữ liệu đã tồn tại T.T';
		end;
-----

-- Trỏ đến database db_news:
	use db_news;
	go
-----

-- Tạo bảng với điều kiện không tồn tại:
-- Tạo bảng Thanh_Vien --
	if not exists (select 1 from sys.objects where name = 'Thanh_Vien')
		begin
			create table Thanh_Vien (
			Id int not null identity unique,
			TaiKhoan nchar(255),
			MatKhau nvarchar(255)
			);
		end;
	else
		begin
			print N'Bảng ghi đã tồn tại T.T';
		end;

-- Tạo bảng Dm_BaiViet --
	if not exists (select 1 from sys.objects where name = 'Dm_BaiViet')
		begin
			create table Dm_BaiViet (
			Id int not null identity unique,
			TenDm nvarchar(255),
			constraint pk_Dm_BaiViet primary key(Id)
			);
		end;
	else
		begin
			print N'Bảng ghi đã tồn tại T.T';
		end;

-- Tạo bảng Bai_Viet --
	if not exists (select 1 from sys.objects where name = 'Bai_Viet')
		begin
			create table Bai_Viet (
			Id int not null identity unique,
			TieuDe nchar(255),
			NoiDung ntext,
			HinhAnh ntext,
			Id_Dm int not null,
			constraint fk_Bai_Viet_DM foreign key(Id_Dm) references Dm_BaiViet(Id)
			);
		end;
	else
		begin
			print N'Bảng ghi đã tồn tại T.T';
		end;
-----

---- Bài Tập ----

-- Yêu cầu 1 - Thêm dữ liệu cho các bảng, mỗi bảng 30 record dữ liệu --
-- Thêm dữ liệu bảng Thanh_Viên:
	insert into Thanh_Vien values
		(N'Nguyễn Hải Cường 1', 123456),
		(N'Nguyễn Hải Cường 2', 123456),
		(N'Nguyễn Hải Cường 3', 123456),
		(N'Nguyễn Hải Cường 4', 123456),
		(N'Nguyễn Hải Cường 5', 123456),
		(N'Nguyễn Hải Cường 6', 123456),
		(N'Nguyễn Hải Cường 7', 123456),
		(N'Nguyễn Hải Cường 8', 123456),
		(N'Nguyễn Hải Cường 9', 123456),
		(N'Nguyễn Hải Cường 10', 123456),
		(N'Nguyễn Hải Cường 11', 123456),
		(N'Nguyễn Hải Cường 12', 123456),
		(N'Nguyễn Hải Cường 13', 123456),
		(N'Nguyễn Hải Cường 14', 123456),
		(N'Nguyễn Hải Cường 15', 123456),
		(N'Nguyễn Hải Cường 16', 123456),
		(N'Nguyễn Hải Cường 17', 123456),
		(N'Nguyễn Hải Cường 18', 123456),
		(N'Nguyễn Hải Cường 19', 123456),
		(N'Nguyễn Hải Cường 20', 123456),
		(N'Nguyễn Hải Cường 21', 123456),
		(N'Nguyễn Hải Cường 22', 123456),
		(N'Nguyễn Hải Cường 23', 123456),
		(N'Nguyễn Hải Cường 24', 123456),
		(N'Nguyễn Hải Cường 25', 123456),
		(N'Nguyễn Hải Cường 26', 123456),
		(N'Nguyễn Hải Cường 27', 123456),
		(N'Nguyễn Hải Cường 28', 123456),
		(N'Nguyễn Hải Cường 29', 123456),
		(N'Nguyễn Hải Cường 30', 123456);
-----

-- Thêm dữ liệu bảng Dm_BaiViet
	insert into Dm_BaiViet values 
		(N'Thể Thao'),
		(N'Danh Mục Số 2'),
		(N'Danh Mục Số 3'),
		(N'Danh Mục Số 4'),
		(N'Danh Mục Số 5'),
		(N'Danh Mục Số 6'),
		(N'Danh Mục Số 7'),
		(N'Danh Mục Số 8'),
		(N'Danh Mục Số 9'),
		(N'Danh Mục Số 10'),
		(N'Danh Mục Số 11'),
		(N'Danh Mục Số 12'),
		(N'Danh Mục Số 13'),
		(N'Danh Mục Số 14'),
		(N'Danh Mục Số 15'),
		(N'Danh Mục Số 16'),
		(N'Danh Mục Số 17'),
		(N'Danh Mục Số 18'),
		(N'Danh Mục Số 19'),
		(N'Danh Mục Số 20'),
		(N'Danh Mục Số 21'),
		(N'Danh Mục Số 22'),
		(N'Danh Mục Số 23'),
		(N'Danh Mục Số 24'),
		(N'Danh Mục Số 25'),
		(N'Danh Mục Số 26'),
		(N'Danh Mục Số 27'),
		(N'Danh Mục Số 28'),
		(N'Danh Mục Số 29'),
		(N'Danh Mục Số 30');
-----

-- Thêm dữ liệu bảng Bai_Viet
	insert into Bai_Viet values
		(N'Tiêu đề 1', N'Nội dung bài viết 1', N'Hình ảnh 1', 1),
		(N'Tiêu đề 2', N'Nội dung bài viết 2', N'Hình ảnh 2', 2),
		(N'Tiêu đề 3', N'Nội dung bài viết 3', N'Hình ảnh 3', 3),
		(N'Tiêu đề 4', N'Nội dung bài viết 4', N'Hình ảnh 4', 4),
		(N'Tiêu đề 5', N'Nội dung bài viết 5', N'Hình ảnh 5', 5),
		(N'Tiêu đề 6', N'Nội dung bài viết 6', N'Hình ảnh 6', 6),
		(N'Tiêu đề 7', N'Nội dung bài viết 7', N'Hình ảnh 7', 7),
		(N'Tiêu đề 8', N'Nội dung bài viết 8', N'Hình ảnh 8', 8),
		(N'Tiêu đề 9', N'Nội dung bài viết 9', N'Hình ảnh 9', 9),
		(N'Tiêu đề 10', N'Nội dung bài viết 10', N'Hình ảnh 10', 10),
		(N'Tiêu đề 11', N'Nội dung bài viết 11', N'Hình ảnh 11', 11),
		(N'Tiêu đề 12', N'Nội dung bài viết 12', N'Hình ảnh 12', 12),
		(N'Tiêu đề 13', N'Nội dung bài viết 13', N'Hình ảnh 13', 13),
		(N'Tiêu đề 14', N'Nội dung bài viết 14', N'Hình ảnh 14', 14),
		(N'Tiêu đề 15', N'Nội dung bài viết 15', N'Hình ảnh 15', 15),
		(N'Tiêu đề 16', N'Nội dung bài viết 16', N'Hình ảnh 16', 16),
		(N'Tiêu đề 17', N'Nội dung bài viết 17', N'Hình ảnh 17', 17),
		(N'Tiêu đề 18', N'Nội dung bài viết 18', N'Hình ảnh 18', 18),
		(N'Tiêu đề 19', N'Nội dung bài viết 19', N'Hình ảnh 19', 19),
		(N'Tiêu đề 20', N'Nội dung bài viết 20', N'Hình ảnh 20', 20),
		(N'Tiêu đề 21', N'Nội dung bài viết 21', N'Hình ảnh 21', 21),
		(N'Tiêu đề 22', N'Nội dung bài viết 22', N'Hình ảnh 22', 22),
		(N'Tiêu đề 23', N'Nội dung bài viết 23', N'Hình ảnh 23', 23),
		(N'Tiêu đề 24', N'Nội dung bài viết 24', N'Hình ảnh 24', 24),
		(N'Tiêu đề 25', N'Nội dung bài viết 25', N'Hình ảnh 25', 25),
		(N'Tiêu đề 26', N'Nội dung bài viết 26', N'Hình ảnh 26', 26),
		(N'Tiêu đề 27', N'Nội dung bài viết 27', N'Hình ảnh 27', 27),
		(N'Tiêu đề 28', N'Nội dung bài viết 28', N'Hình ảnh 28', 28),
		(N'Tiêu đề 29', N'Nội dung bài viết 29', N'Hình ảnh 29', 29),
		(N'Tiêu đề 30', N'Nội dung bài viết 30', N'Hình ảnh 30', 30);
-----

-- Yêu cầu 2 - Đổi tên bảng Thanhvien thành bảng User --
	sp_rename 'Thanh_Vien', 'user';

-- Yêu cầu 3 - Chèn thêm cột gender, email, phone, birthday, country cho bảng User --
	alter table [user] add 
		gender ntext, 
		email ntext,  
		phone int, 
		birthday date, 
		country ntext;
-----

-- Yêu cầu 4 - Thêm dữ liệu cho các cột mới tạo --
	SET DATEFORMAT dmy;
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '1';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '2';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '3';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '4';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '5';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '6';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '7';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '8';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '9';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '10';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '11';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '12';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '13';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '14';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '15';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '16';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '17';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '18';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '19';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '20';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '21';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '22';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '23';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '24';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '25';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '26';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '27';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '28';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '29';
	update [user] set gender = N'Nam', email = N'cuongnh0907@gmail.com', phone = 0989113968, birthday = '09-07-1991', country = N'Hà Tĩnh' where Id = '30';
	--SET DATEFORMAT dmy;
	--Select CONVERT(varchar, GETDATE(), 103)
	--select Id, TaiKhoan, Matkhau, gender, email, phone, country, convert(varchar, birthday, 103) as NgaySinh from [user]
	--Tạo hàm
-----

-- Yêu cầu 5 - Tìm danh mục Thể Thao trong bảng danh mục và xóa bỏ danh mục đó --
-- Tìm danh mục Thể Thao
	select TenDm from Dm_BaiViet where Id = '1';
----

-- Xóa bỏ danh mục Thể Thao
	alter table Bai_Viet drop constraint fk_Bai_Viet_DM; --Xóa bỏ ràng buộc--
	delete from Dm_BaiViet where Id = '1';
	alter table Bai_Viet with nocheck  add constraint fk_Bai_Viet_DM foreign key(Id_Dm)	 references Dm_BaiViet(Id); --Tạo lại ràng buộc--
-----

-----------------------------END--------------------------------

-- Hiển thị bảng:
	select * from [user];
	select Id, TaiKhoan, Matkhau, gender, email, phone, country, convert(varchar, birthday, 103) as NgaySinh from [user];
	select * from Thanh_Vien;
	select * from Dm_BaiViet;
	select * from Bai_Viet;
-----

-- Lệnh bổ trợ --
/*
-- Xóa ràng buộc
	alter table Bai_Viet drop constraint fk_Bai_Viet_DM;
	alter table Dm_BaiViet drop constraint pk_Dm_BaiViet;
	alter table Bai_Viet nocheck constraint fk_Bai_Viet_DM; --Bỏ kiểm tra ràng buộc--
	alter table Bai_Viet with check check constraint fk_Bai_Viet_DM --Tạo lại ràng buộc--
-----
-- Xóa bảng
	drop table Thanh_Vien
	drop table Dm_BaiViet
	drop table Bai_Viet
	drop table [user]
-----
-- Xóa bản ghi giữ nguyên index
	delete from Thanh_Vien
	delete from Dm_BaiViet
	delete from Bai_Viet
	delete from [user]
-----
-- Xóa bản ghi và index
	truncate table Thanh_Vien
	truncate table Bai_Viet
	truncate table Dm_BaiViet
	truncate table [user]
-----
-- Thay đổi kiểu dữ liệu của cột
	alter table [user] alter column gender ntext;
	alter table [user] alter column email ntext;
	alter table [user] alter column phone int;
	alter table [user] alter column birthday date;
	alter table [user] alter column country ntext;
-----
*/