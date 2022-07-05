CREATE DATABASE BAITAP1
Go

Use BAITAP1
Go

Create table Khoa(
makhoa char(10) primary key,
tenkhoa char(30),
dienthoai char(10)
)
insert into Khoa values('T1','TOAN',012345678)
insert into Khoa values('T2','DIA LY va QLTN',094522637)
insert into Khoa values('T3','Triet',09213612)
insert into Khoa values('T4','CONG NGHE SINH HOC',09126351)

Create table GiangVien(
magv int primary key,
hotengv char(30),
luong decimal(5,2),
makhoa char(10)
constraint fk_Khoa_GiangVien foreign key(makhoa) REFERENCES Khoa(makhoa)
)

insert into GiangVien values(2523,'Tran son',123,'T1')
insert into GiangVien values(9316,'Luong thi tuan',153,'T2')
insert into GiangVien values(5172,'Nguyen Tuan dz',193,'T3')
insert into GiangVien values(1234,'Do Minh Thanh dz sieucapvutru',203,'T4')

Create table SinhVien(
masv int primary key,
hotensv char(30),
makhoa char(10),
namsinh int,
quequan char(30)
constraint fk_Khoa_SinhVien foreign key(makhoa) REFERENCES Khoa(makhoa)
)

insert into SinhVien values(1,'Le van son','T1',2003,'Quang Ninh')
insert into SinhVien values(2,'Nguyen khanh vy','T2',2003,'TP Ho Chi Minh')
insert into SinhVien values(3,'Tran Khanh Huyen','T3',2003,'Ha Noi')
insert into SinhVien values(4,'Ngo duc minh','T4',2003,'Quang Ninh')
insert into SinhVien values(5,'Hoang vu tang minh',null,2003,'Dien Bien')
insert into SinhVien values(6,'Le tien dat','T2',2003,'Cao Bang')
insert into SinhVien values(7,'tran dan','T2',2003,'lang Son')
insert into SinhVien values(8,'tran quan','T2',2003,'Mong Cai')

Create table DeTai(
madt char(10) primary key,
tendt char(30),
kinhphi int,
NoiThucTap char(30)
)

insert into DeTai values('Vu','Tham quan du lich',200000,'Quang Ninh')
insert into DeTai values('Mu','Tam Bien',5000,'Nha Trang')
insert into DeTai values('Ps','Leo Nui',12000,'Day Himalaya')
insert into DeTai values('So','Tham Hiem',9999,'Nui Phu Si Japanese')
insert into DeTai values('So1','Tham Hiem1',1200000,'Nui PhanSiPhang')

Create table HuongDan(
masv int primary key,
madt char(10),
magv int,
ketqua decimal(5,2)
constraint fk_HuongDan_DeTai foreign key(madt) REFERENCES DeTai (madt),
constraint fk_HuongDan_SinhVien foreign key(masv) REFERENCES SinhVien(masv),
constraint fk_HuongDan_GiangVien foreign key(magv) REFERENCES GiangVien(magv)
)

insert into HuongDan values(1,'Vu',2523,9.8)
insert into HuongDan values(2,'Mu',9316,10)
insert into HuongDan values(3,'Ps',5172,7.5)
insert into HuongDan values(4,'So',1234,6)
insert into HuongDan values(5,'Mu',9316,4)
insert into HuongDan values(6,'Vu',5172,0)
insert into HuongDan values(7,'So1',9316,null)

--I
--cau 1a  Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên (DONE)
select magv,hotengv,tenkhoa from GiangVien 
join Khoa on GiangVien.makhoa = Khoa.makhoa


--cau 1b  Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’ (DONE)
select magv,hotengv,tenkhoa from Khoa 
join GiangVien on Khoa.makhoa = Khoa.makhoa 
where tenkhoa = 'DIA LY va QLTN'

--cau 2  Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’ (DONE)
select masv from SinhVien
join Khoa on SinhVien.makhoa = Khoa.makhoa 
where tenkhoa = 'CONG NGHE SINH HOC'

--cau 3  Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’ (DONE)
select masv,hotensv,namsinh from SinhVien
join Khoa on SinhVien.makhoa = Khoa.makhoa 
where tenkhoa = 'TOAN'

--cau 4  Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’ (DONE)
select magv from GiangVien
join Khoa on GiangVien.makhoa = Khoa.makhoa
where tenkhoa = 'CONG NGHE SINH HOC'

--cau 5  Cho biết thông tin về sinh viên không tham gia thực tập  (DONE)
select * from SinhVien
where makhoa is null

--cau 6  Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa (DONE)
select Khoa.makhoa,tenkhoa from Khoa 
join GiangVien on Khoa.makhoa = GiangVien.makhoa order by tenkhoa 

--cau 7  Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học (DONE)
select dienthoai from Khoa 
join SinhVien on Khoa.makhoa = SinhVien.makhoa
where SinhVien.hotensv = 'Le van son'

--II
--cau 1  Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn  (DONE)
select DeTai.madt,tendt from DeTai 
join HuongDan on DeTai.madt = HuongDan.madt
join GiangVien on HuongDan.magv = GiangVien.magv
where GiangVien.hotengv = 'Tran son'

--cau 2  Cho biết tên đề tài không có sinh viên nào thực tập (DONE)
select DeTai.tendt from DeTai
join HuongDan on DeTai.madt = HuongDan.madt
where HuongDan.masv is null
insert into HuongDan values(1,'Vu',2523,9.8)
insert into HuongDan values(2,'Mu',9316,10)
insert into HuongDan values(3,'Ps',5172,7.5)
insert into HuongDan values(4,'So',1234,6)
insert into HuongDan values(5,'Mu',9316,4)
insert into HuongDan values(6,'Vu',5172,0)
insert into HuongDan values(7,'So1',9316,null)
insert into HuongDan values(8,'So1',9316,null)
--cau 3 Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.  (DONE)
SELECT distinct HuongDan.magv,GiangVien.hotengv,Khoa.tenkhoa FROM GiangVien 
join HuongDan on GiangVien.magv = HuongDan.magv
join Khoa on GiangVien.makhoa = Khoa.makhoa
WHERE GiangVien.magv IN (SELECT HuongDan.magv FROM HuongDan
GROUP BY magv
HAVING COUNT(masv) > 3)
--cau 4 Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất  (DONE)
select madt,tendt,kinhphi from DeTai  
where kinhphi in ( select MAX(kinhphi) from DeTai)

--cau 5  Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIA LY và QLTN’  (DONE)
select SinhVien.masv,SinhVien.hotensv,HuongDan.ketqua from Khoa
join SinhVien on Khoa.makhoa = SinhVien.makhoa
join HuongDan on SinhVien.masv = HuongDan.masv
where tenkhoa = 'DIA LY va QLTN'

--cau 6  Đưa ra tên khoa, số lượng sinh viên của mỗi khoa  (DONE)
select Khoa.tenkhoa,count(SinhVien.makhoa) as "Số Lượng Sinh Viên" from Khoa
join SinhVien on Khoa.makhoa = SinhVien.makhoa group by tenkhoa

--cau 7  Cho biết thông tin về các sinh viên thực tập tại quê nhà  (DONE)
select SinhVien.masv,hotensv,SinhVien.makhoa,SinhVien.namsinh,SinhVien.quequan,DeTai.NoiThucTap from SinhVien
join HuongDan on SinhVien.masv = HuongDan.masv
join DeTai on HuongDan.madt = DeTai.madt
where DeTai.NoiThucTap = quequan;

--cau 8  Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập  (DONE)
select HuongDan.masv,SinhVien.hotensv,SinhVien.makhoa,SinhVien.namsinh,SinhVien.quequan from HuongDan
join SinhVien on HuongDan.masv = SinhVien.masv
where ketqua is null

--cau 9  Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0  (DONE)
select SinhVien.masv ,SinhVien.hotensv from SinhVien
join HuongDan on SinhVien.masv = HuongDan.masv
where HuongDan.ketqua = 0