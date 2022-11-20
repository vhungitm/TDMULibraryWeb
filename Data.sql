USE [master]
GO
/****** Object:  Database [Library]    Script Date: 21/11/2022 1:12:28 SA ******/
CREATE DATABASE [Library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Library] SET  MULTI_USER 
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Library] SET QUERY_STORE = OFF
GO
USE [Library]
GO
/****** Object:  Table [dbo].[Banner]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Image] [varchar](200) NOT NULL,
	[Order] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Banner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[MetaTitle] [varchar](100) NOT NULL,
	[Image] [varchar](300) NOT NULL,
	[Authors] [nvarchar](100) NOT NULL,
	[CategoryId] [bigint] NOT NULL,
	[PublisherId] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PageNumber] [int] NOT NULL,
	[Size] [varchar](20) NOT NULL,
	[Weight] [varchar](10) NOT NULL,
	[PublishYear] [int] NOT NULL,
	[Description] [ntext] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Borrow]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrow](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StudentId] [char](13) NOT NULL,
	[StaffId] [char](10) NOT NULL,
	[BookId] [bigint] NOT NULL,
	[BorrowDate] [datetime] NOT NULL,
	[ReturnDeadline] [datetime] NULL,
	[ReturnDate] [datetime] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Borrow] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[MetaTitle] [varchar](50) NOT NULL,
	[Image] [varchar](300) NOT NULL,
 CONSTRAINT [PK_BookType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Content] [ntext] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StaffId] [char](10) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Quantity] [int] NOT NULL,
	[TotalPrice] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_BookImport] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportDetail]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportDetail](
	[ImportId] [bigint] NOT NULL,
	[BookId] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[TotalPrice] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[ImportId] ASC,
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[MetaTitle] [varchar](50) NOT NULL,
	[Address] [nvarchar](200) NULL,
	[Phone] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[Id] [char](10) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Avatar] [varchar](200) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Lecturer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [char](13) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Avatar] [varchar](200) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](5) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Class] [char](10) NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Banner] ON 

INSERT [dbo].[Banner] ([Id], [Image], [Order], [Status]) VALUES (1, N'/Upload/Images/banner-1.jpg', 1, 1)
INSERT [dbo].[Banner] ([Id], [Image], [Order], [Status]) VALUES (2, N'/Upload/Images/banner-2.jpg', 4, 1)
INSERT [dbo].[Banner] ([Id], [Image], [Order], [Status]) VALUES (3, N'/Upload/Images/banner-3.png', 3, 1)
INSERT [dbo].[Banner] ([Id], [Image], [Order], [Status]) VALUES (4, N'/Upload/Images/banner-4.jpg', 4, 1)
SET IDENTITY_INSERT [dbo].[Banner] OFF
GO
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (1, N'Tôi Quyết Định Sống Cho Chính Tôi (Tái Bản 2020)', N'toi-quyet-dinh-song-cho-chinh-toi-(tai-ban-2020)', N'/Upload/images/toi-quyet-dinh-song-cho-chinh-toi.png', N'Kim Suhyun', 2, 1, 40, 236, N'19.5 x 13.5', N'250', 2020, N'<p>Cuốn s&aacute;ch đạt giải thưởng&nbsp;<strong>&ldquo;Cuốn s&aacute;ch của năm&rdquo;</strong>&nbsp;tại H&agrave;n Quốc v&agrave;o năm 2017.</p>

<p>Đ&atilde;&nbsp;<strong>t&aacute;i bản hơn 100 lần</strong>&nbsp;kể từ lần xuất bản đầu ti&ecirc;n v&agrave;o năm 2016.</p>

<p>Được nhiều nghệ sĩ chọn đọc v&agrave; giới thiệu đến c&aacute;c fan của m&igrave;nh, đơn cử l&agrave;&nbsp;<strong>JungKook (BTS).</strong></p>

<p>&nbsp;Như t&aacute;c giả Kim Suhyun đ&atilde; chia sẻ về qu&aacute; tr&igrave;nh s&aacute;ng t&aacute;c cuốn s&aacute;ch n&agrave;y:</p>

<p>&ldquo;T&ocirc;i đ&atilde; cố gắng ghi ra những điều quan trọng nhất trong cuộc sống như:</p>

<p>C&ocirc;ng việc, c&aacute;c mối quan hệ, niềm vui, tinh thần, thể chất, sức khỏe&hellip;</p>

<p>T&ocirc;i đ&atilde; kh&ocirc;ng lường trước những việc c&oacute; thể xảy ra . M&agrave; t&ocirc;i chỉ l&agrave;m (Do) những việc t&ocirc;i muốn (Want) v&agrave; c&oacute; thể (Can).&nbsp;</p>

<p>Một c&ocirc;ng thức đơn giản l&agrave; Want + Can = Do</p>

<p>Thay v&agrave;o đ&oacute;, h&atilde;y l&agrave;m việc chăm chỉ.</p>

<p>T&ocirc;i dần tr&aacute;nh những mối quan hệ chỉ nhấn ch&igrave;m t&ocirc;i hoặc kh&ocirc;ng quan trọng với t&ocirc;i v&agrave; tự nhủ rằng t&ocirc;i sẽ kh&ocirc;ng cho ph&eacute;p bản th&acirc;n l&agrave;m bất kể điều g&igrave; một c&aacute;ch t&ugrave;y tiện nữa. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>

<p>T&ocirc;i d&agrave;nh thời gian t&igrave;m kiếm niềm vui trong cuộc sống.</p>

<p>C&oacute; những ng&agrave;y, t&ocirc;i ngồi ngắm bầu trời v&agrave;i lần để cảm nhận cuộc sống. T&ocirc;i đối diện với những vấn đề c&ograve;n bỏ ngỏ, giải quyết ch&uacute;ng v&agrave; cố gắng sống l&agrave;nh mạnh.</p>

<p>V&igrave; những đ&aacute;p &aacute;n do x&atilde; hội quy định kh&aacute;c xa những quan niệm th&ocirc;ng thường của mọi người xung quanh ch&uacute;ng ta n&ecirc;n chỉ c&oacute; một điều m&agrave; ch&uacute;ng ta biết chắc, đ&oacute; l&agrave; cuộc sống rất r&otilde; r&agrave;ng v&agrave; nhẹ tựa l&ocirc;ng hồng.</p>

<p>Vậy &yacute; nghĩa của cuộc sống rốt cuộc l&agrave; g&igrave;?</p>

<p>Sau nhiều lần chất vấn, c&acirc;u trả lời t&ocirc;i t&igrave;m thấy kh&ocirc;ng c&ograve;n l&agrave; đ&aacute;p &aacute;n c&aacute; nh&acirc;n m&agrave; trở th&agrave;nh đ&aacute;p &aacute;n của cả một cộng đồng, đ&oacute; ch&iacute;nh l&agrave; hiện thực h&oacute;a gi&aacute; trị của bản th&acirc;n trong x&atilde; hội.</p>

<p>T&ocirc;i lu&ocirc;n quan t&acirc;m v&agrave; kh&iacute;ch lệ sự đ&oacute;ng g&oacute;p của c&aacute; nh&acirc;n cho một x&atilde; hội tương lai.</p>

<p>Bởi v&igrave; giải quyết c&aacute;c vấn đề x&atilde; hội ch&iacute;nh l&agrave; một c&aacute;ch trực tiếp để giải quyết c&aacute;c vấn đề c&aacute; nh&acirc;n.</p>

<p>Nhưng đ&oacute; kh&ocirc;ng phải l&iacute; do duy nhất khiến ch&uacute;ng ta đ&oacute;ng g&oacute;p một phần bản th&acirc;n v&agrave;o x&atilde; hội.</p>

<p>Th&ocirc;ng qua cuốn s&aacute;ch n&agrave;y, t&ocirc;i muốn lan truyền một l&agrave;n s&oacute;ng d&ugrave; nhỏ nhưng c&oacute; &yacute; nghĩa đến mọi người.</p>

<p>Những c&acirc;u hỏi kh&ocirc;ng c&oacute; hồi kết như &ldquo;Ch&uacute;ng ta phải sống thế n&agrave;o?&rdquo; lu&ocirc;n nảy sinh trong cuộc sống. Để t&ocirc;i n&oacute;i cho bạn nghe c&acirc;u trả lời của t&ocirc;i nh&eacute;, đ&oacute; ch&iacute;nh l&agrave;: &ldquo;H&atilde;y sống tốt với đời m&igrave;nh.&rdquo;</p>

<p>Bạn kh&ocirc;ng cần phải phức tạp h&oacute;a mọi vấn đề.</p>

<p>Bạn chỉ cần l&agrave;m việc chăm chỉ, t&acirc;m sự với những người th&acirc;n y&ecirc;u, c&ugrave;ng nhau ăn những m&oacute;n ngon, chia sẻ với nhau những b&agrave;i h&aacute;t y&ecirc;u th&iacute;ch, những cuốn s&aacute;ch hay v&agrave;o một ng&agrave;y đẹp trời bạn tận hưởng &aacute;nh mặt trời.</p>

<p>T&ocirc;i nghĩ rằng một cuộc sống tốt đẹp trọn vẹn ch&iacute;nh l&agrave; chuỗi ng&agrave;y ấm &aacute;p, b&igrave;nh dị đang diễn ra. Nếu c&oacute; thể, h&atilde;y bước th&ecirc;m một nhịp để hướng tới cuộc sống c&oa', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (2, N'Tôi Ơi Đừng Tuyệt Vọng!', N'toi-oi-dung-tuyet-vong!', N'/Upload/images/toi-oi-dung-tuyet-vong.png', N'Hiroki Kashiragi', 2, 10, 40, 172, N'19.5 x 13.5', N'180', 2020, N'<p>T&ocirc;i Ơi Đừng Tuyệt Vọng!</p>

<p><strong>Một cuốn s&aacute;ch d&agrave;nh cho mọi thời điểm.</strong></p>

<p>Khi tuyệt vọng, trước hết bạn cần điều g&igrave;? Phải chăng l&agrave; c&aacute;ch b&igrave;nh phục? Hay lời động vi&ecirc;n? T&ocirc;i nghĩ rằng trước những c&aacute;i đ&oacute; c&ograve;n c&oacute; điều cần thiết hơn.</p>

<p>Nếu c&oacute; thể, t&ocirc;i mong những người hiện đang kh&ocirc;ng tuyệt vọng cũng đọc cuốn s&aacute;ch n&agrave;y. Chắc hẳn bạn kh&ocirc;ng muốn nghe những c&acirc;u chuyện tuyệt vọng giữa l&uacute;c t&acirc;m trạng bạn đang tươi s&aacute;ng. Khi t&acirc;m trạng u &aacute;m, bạn c&agrave;ng kh&ocirc;ng muốn nghe ch&uacute;ng. V&agrave; cũng c&oacute; nhiều người nghĩ rằng trong cuộc sống sau n&agrave;y, nếu c&oacute; thể th&igrave; họ kh&ocirc;ng muốn trải nghiệm bất cứ điều g&igrave; gọi l&agrave; tuyệt vọng hết, d&ugrave; cho gặp cảnh tuyệt vọng th&igrave; đến l&uacute;c đ&oacute; hẵng nghĩ tới cũng được. Họ muốn cố hết sức l&agrave;m ngơ tuyệt vọng. Điều n&agrave;y v&ocirc; c&ugrave;ng hợp l&yacute;.</p>

<p>C&oacute; điều, sau khi xảy ra động đất mới bắt đầu đọc s&aacute;ch về c&aacute;ch đối ph&oacute; với động đất th&igrave; kh&ocirc;ng c&ograve;n kịp nữa. Giữa l&uacute;c mặt đất đang chao đảo, bạn đ&acirc;u thể đi mua t&uacute;i khẩn cấp hay gom g&oacute;p những vật dụng cần thiết. Một cuốn s&aacute;ch d&agrave;nh cho thời điểm khẩn cấp cần được đọc trước khi thời điểm đ&oacute; xảy ra.</p>

<p>Cuốn s&aacute;ch nhỏ b&eacute; n&agrave;y gồm hai phần.</p>

<p>Phần thứ nhất, t&ocirc;i muốn bạn suy nghĩ về việc n&ecirc;n l&agrave;m thế n&agrave;o để vượt qua giai đoạn tuyệt vọng. Phần thứ hai, t&ocirc;i muốn giới thiệu những cuốn s&aacute;ch, phim điện ảnh, phim truyền h&igrave;nh sẽ xoa dịu bạn khi tuyệt vọng.</p>

<p><strong>Đối mặt với tuyệt vọng sẽ sinh ra hạnh ph&uacute;c</strong></p>

<p>Gandhi đ&atilde; n&oacute;i vậy.</p>

<p>Những t&acirc;m hồn chỉ truy cầu hạnh ph&uacute;c sẽ mời gọi bi kịch. Hạnh ph&uacute;c l&agrave; c&aacute;i được sinh ra bởi t&acirc;m hồn đ&atilde; chinh phục đau buồn v&agrave; khổ sở.</p>

<p>Dẫu vậy, t&ocirc;i cũng mong c&aacute;c bạn lu&ocirc;n gặp hạnh ph&uacute;c v&agrave; d&ugrave; bạn phải trải qua giai đoạn tuyệt vọng th&igrave; hạnh ph&uacute;c cũng sẽ từ đ&oacute; m&agrave; sinh ra.</p>

<p>- Kashiragi Hiroki &ndash;</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (3, N'Tuổi Trẻ Không Hối Tiếc', N'tuoi-tre-khong-hoi-tiec', N'/Upload/images/tuoi-tre-khong-hoi-tiec.png', N'Huyền Chip', 2, 2, 40, 100, N'13.5 x 20', N'300', 2018, N'<p><strong>Tuổi Trẻ Kh&ocirc;ng Hối Tiếc</strong></p>

<p>Quảng Văn tr&acirc;n trọng gửi tới qu&yacute; nh&agrave; s&aacute;ch v&agrave; độc giả&nbsp;<strong>cuốn s&aacute;ch &ldquo;Tuổi trẻ kh&ocirc;ng hối tiếc&rdquo;&nbsp;</strong>của t&aacute;c giả Huyền Chip.&ldquo;Tuổi trẻ kh&ocirc;ng hối tiếc&rdquo; l&agrave; cuốn s&aacute;ch Self-helf trong đ&oacute; tổng kết gần như tất cả những g&igrave; hữu &iacute;ch về c&aacute;c phương diện học, sống, l&agrave;m việc, đi v&agrave; y&ecirc;u m&agrave; t&aacute;c giả Huyền Chip đ&atilde; đ&uacute;c r&uacute;t ra được dựa tr&ecirc;n những trải nghiệm du lịch một m&igrave;nh, du học v&agrave; l&agrave;m việc ở nước ngo&agrave;i của t&aacute;c giả. S&aacute;ch dự kiến được ra mắt v&agrave;o ng&agrave;y 26/05/2018.</p>

<p>&ldquo;T&ocirc;i tin rằng chỉ khi n&agrave;o d&aacute;m đối mặt với c&aacute;i chết, ch&uacute;ng ta mới c&oacute; thể hiểu được gi&aacute; trị của sự sống. Ai cũng biết rằng một ng&agrave;y n&agrave;o đ&oacute; m&igrave;nh sẽ chết nhưng vẫn sống như m&igrave;nh l&agrave; bất tử. Một ng&agrave;y n&agrave;o đ&oacute; ch&uacute;ng ta sẽ l&agrave;m điều m&igrave;nh y&ecirc;u th&iacute;ch. Một ng&agrave;y n&agrave;o đ&oacute; ch&uacute;ng ta sẽ thay đổi. Một ng&agrave;y n&agrave;o đ&oacute; ch&uacute;ng ta sẽ trở th&agrave;nh con người m&igrave;nh muốn trở th&agrave;nh. Nhưng nếu bạn đ&atilde; chần chừ cả năm mười năm kh&ocirc;ng l&agrave;m việc g&igrave; đ&oacute;, chẳng c&oacute; l&yacute; do g&igrave; để l&agrave;m việc đ&oacute; ng&agrave;y h&ocirc;m nay, hay ng&agrave;y mai, hay một ng&agrave;y n&agrave;o đ&oacute;. Đến khi c&aacute;i chết t&igrave;m đến với ta, tất cả đ&atilde; qu&aacute; muộn&hellip;&rdquo;</p>

<p>&ldquo;Một cuộc sống kh&ocirc;ng xo&agrave;ng xĩnh, với t&ocirc;i, l&agrave; một cuộc sống c&oacute; &yacute; nghĩa. L&agrave; cuộc sống m&agrave; t&ocirc;i tạo ra được gi&aacute; trị thực sự, gi&uacute;p đỡ được nhiều người, cho đi nhiều hơn l&agrave; nhận. L&agrave; cuộc sống m&agrave; sau khi t&ocirc;i chết đi, sẽ c&oacute; người thương tiếc sự ra đi của t&ocirc;i kh&ocirc;ng phải v&igrave; mối quan hệ m&aacute;u mủ, m&agrave; bởi v&igrave; t&ocirc;i đ&atilde; g&oacute;p phần tạo n&ecirc;n những thay đổi t&iacute;ch cực trong cuộc sống của họ.&rdquo;</p>

<p>&ldquo;T&ocirc;i kh&ocirc;ng chỉ l&agrave; c&ocirc; g&aacute;i &ldquo;x&aacute;ch ba l&ocirc; l&ecirc;n v&agrave; đi&rdquo;. T&ocirc;i kh&ocirc;ng chỉ l&agrave; lập tr&igrave;nh vi&ecirc;n m&aacute;y t&iacute;nh. T&ocirc;i kh&ocirc;ng chỉ l&agrave; đứa con g&aacute;i nh&agrave; n&ocirc;ng. T&ocirc;i l&agrave; tất cả những thứ đ&oacute;, v&agrave; c&ograve;n nhiều hơn nữa. T&ocirc;i l&agrave; t&ocirc;i, c&aacute; thể v&agrave; ri&ecirc;ng biệt.&rdquo;</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (4, N'Khởi Đầu Muôn Màng, Kết Thúc Giàu Sang', N'khoi-dau-muon-mang,-ket-thuc-giau-sang', N'/Upload/images/khoi-dau-muon-mang-ket-thuc-giau-sang.png', N'David Bach', 2, 3, 40, 540, N'	14.5 x 20.5', N'550', 2019, N'<p>Kh&ocirc;ng bao giờ l&agrave; qu&aacute; muộn để bắt đầu</p>

<p>&ldquo;<em>Nếu coi đời người d&agrave;i một ng&agrave;y 24 tiếng, chẳng hạn sống đến 80 tuổi đi, th&igrave; thực ra 25 tuổi mới chỉ l&agrave; khoảng 7 giờ s&aacute;ng. Đ&oacute; mới l&agrave; l&uacute;c ch&uacute;ng ta chuẩn bị ra khỏi nh&agrave;, đi học, đi l&agrave;m, với một số người kh&aacute;c thậm ch&iacute; c&ograve;n chưa ngủ dậy. Thực ra kh&ocirc;ng l&uacute;c n&agrave;o l&agrave; qu&aacute; muộn</em>&rdquo; &ndash; Rando Kim.</p>

<p>Họa sỹ nổi tiếng của Mỹ Grandma Moses t&ecirc;n thật l&agrave; Anna Mary Robertson Moses c&oacute; một khởi đầu rất muộn m&agrave;ng. Từ nhỏ, b&agrave; đ&atilde; rất y&ecirc;u th&iacute;ch hội họa v&agrave; lu&ocirc;n mơ được trở th&agrave;nh một họa sĩ nổi tiếng thế giới. Nhưng bố mẹ b&agrave; n&oacute;i rằng b&agrave; sẽ chết đ&oacute;i với nghề đ&oacute; v&agrave; khuy&ecirc;n b&agrave; n&ecirc;n qu&ecirc;n đi giấc mơ đi&ecirc;n rồ đ&oacute;. V&acirc;ng lời bố mẹ, Anna g&aacute;c giấc mơ của m&igrave;nh sang một b&ecirc;n v&agrave; bắt đầu cuộc sống gia đ&igrave;nh ở tuổi thiếu ni&ecirc;n. B&agrave; c&oacute; đến 10 đứa con v&agrave; 40 đứa ch&aacute;u.</p>

<p>Ở tuổi 75, sau khi chồng mất v&agrave; tất cả c&aacute;c con đ&atilde; trưởng th&agrave;nh v&agrave; b&agrave; đ&atilde; qu&aacute; gi&agrave; để l&agrave;m việc ở trang trại n&ecirc;n b&agrave; quyết định ho&agrave;n th&agrave;nh giấc mơ thời thơ ấu. B&agrave; bắt đầu vẽ. Thật bất ngờ khi ở tuổi 79, c&aacute;c bức vẽ của b&agrave; được trưng b&agrave;y ở Bảo t&agrave;ng Nghệ thuật cận đại New York. Suốt những năm 1950, những bức vẽ của b&agrave; nổi tiếng đến mức n&oacute; ph&aacute; vỡ tất cả những kỷ lục tr&ecirc;n thế giới về số người đến xem. Năm 1952, b&agrave; cho ra đời cuốn tự truyện My Life&rsquo;s History trong đ&oacute; c&oacute; đoạn viết: &ldquo;T&ocirc;i nh&igrave;n lại cuộc đời t&ocirc;i như l&agrave; c&ocirc;ng việc của một ng&agrave;y tốt đẹp đ&atilde; được thực hiện xong v&agrave; cảm thấy h&agrave;i l&ograve;ng với điều đ&oacute;. T&ocirc;i rất hạnh ph&uacute;c v&agrave; m&atilde;n nguyện bởi t&ocirc;i biết rằng m&igrave;nh đ&atilde; l&agrave;m tốt nhất những g&igrave; m&agrave; cuộc sống mang lại&rsquo;.</p>

<p>&ldquo;<em>Kh&ocirc;ng ai c&oacute; thể quay trở lại v&agrave; bắt đầu một khởi đầu mới, nhưng bất cứ ai cũng c&oacute; thể bắt đầu ngay h&ocirc;m nay v&agrave; tạo ra một kết th&uacute;c mới</em>&rdquo; &ndash; Maria Robinson.</p>

<p>Nếu bạn đang cảm thấy m&igrave;nh khởi đầu muộn m&agrave;ng, th&igrave; h&atilde;y nhớ rằng kể cả khi bạn đang ở độ tuổi 30, 40 hay 50 &ndash; thậm chí ở độ tuổi 60 v&agrave; muộn hơn nữa &ndash; bạn vẫn c&oacute; cơ hội để đưa cuộc sống của bạn đi đ&uacute;ng hướng về mặt t&agrave;i chính v&agrave; kh&ocirc;ng phải lo lắng về tương lai.</p>

<p>Điều g&igrave; sẽ xảy ra nếu bạn biết rằng bạn vẫn &ldquo;kịp&rdquo; tiết kiệm cho tương lai m&agrave; kh&ocirc;ng phải chịu những rủi ro LỚN?</p>

<p>Ngay cả với mức thu nhập b&igrave;nh thường, trong v&ograve;ng một v&agrave;i giờ, bạn c&oacute; thể thay đổi c&aacute;ch bạn kiếm tiền, c&aacute;ch bạn tiết kiệm v&agrave; c&aacute;ch bạn đầu tư &ndash; đến khi bạn thực sự c&oacute; thể &ndash; d&ugrave; khởi đầu muộn m&agrave;ng nhưng bạn vẫn sống gi&agrave;u c&oacute;?&nbsp;</p>

<p>C&oacute; những chiến lược đơn giản m&agrave; bạn c&oacute; thể sử dụng để kiếm nhiều tiền hơn b&acirc;y giờ m&agrave; kh&ocirc;ng cần bỏ việc, để bạn c&oacute; thể kết th&uacute;c thậm chí gi&agrave;u hơn cả khi bạn khởi đầu từ sớm.</p>

<p><strong>Cuốn s&aacute;ch gi&uacute;p bạn đi đ&uacute;ng hướng</strong></p>

<p>Cuốn s&aacute;ch n&agrave;y được chia th&agrave;nh 5 phần chính, mỗi phần bao gồm một lĩnh vực t&agrave;i chính của bạn m&agrave; bạn cần phải giải quyết để c&oacute; thể khởi đầu muộn nhưng kết th&uacute;c gi&agrave;u.</p>

<p>Cho d&ugrave; bạn đọc cuốn s&aacute;ch n&agrave;y từ đầu đến cuối hay chỉ đơn giản l&agrave; tập trung v&agrave;o c&aacute', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (5, N'Sống Đơn Giản Cho Mình Thanh Thản', N'song-don-gian-cho-minh-thanh-than', N'/Upload/images/song-don-gian-cho-minh-thanh-than.png', N'Shunmyo Masuno', 2, 1, 40, 100, N'13 × 20.5', N'250', 2018, N'<p>Sống Đơn Giản Cho M&igrave;nh Thanh Thản</p>

<p>Sống đơn giản l&agrave; sống như thế n&agrave;o? Để c&oacute; một cuộc sống đơn giản th&igrave; phải như thế n&agrave;o? N&oacute; kh&ocirc;ng đơn giản như việc sắp xếp, dọn dẹp, b&agrave;y biện lại một đống đồ vật. N&oacute; cũng chẳng phải l&agrave; sự bằng l&ograve;ng với cuộc sống b&igrave;nh dị m&agrave; bạn đang c&oacute;. M&agrave; sống đơn giản l&agrave; nh&igrave;n thấu được những điều quan trọng đối với bản th&acirc;n m&igrave;nh.</p>

<p>B&acirc;y giờ, điều quan trọng nhất bạn muốn l&agrave;m cho ch&iacute;nh m&igrave;nh l&agrave; g&igrave;? Điều g&igrave; l&agrave; thực sự cần thiết trong cuộc sống hiện tại của bạn? Ch&iacute;nh bản th&acirc;n mỗi người cần kh&aacute;m ph&aacute; ra điều g&igrave; l&agrave; quan trọng với m&igrave;nh, cả về vật chất cũng như tinh thần. Chẳng phải khi bạn nhận ra những điều đ&oacute; rồi, th&igrave; cuộc sống hay suy nghĩ đều rất đơn giản hay sao?</p>

<p>Đừng chỉ để m&igrave;nh bị cuốn v&agrave;o những phong cảnh đẹp đẽ ngo&agrave;i kia, h&atilde;y tự tr&ograve; chuyện với ch&iacute;nh bản th&acirc;n. Đ&ocirc;i khi bạn h&atilde;y dừng lại, để tự hỏi xem &ldquo;rốt cuộc bản th&acirc;n m&igrave;nh l&agrave; g&igrave; nhỉ?&rdquo;.</p>

<p>V&agrave;<em>&nbsp;Sống đơn giản cho m&igrave;nh thanh thản</em>&nbsp;sẽ đem đến cho bạn những lời khuy&ecirc;n giản dị, ch&acirc;n th&agrave;nh để tr&uacute;t bỏ bớt đi những g&aacute;nh nặng kh&ocirc;ng cần thiết trong mọi kh&iacute;a cạnh của cuộc sống hằng ng&agrave;y, để kh&aacute;m ph&aacute; ra một t&acirc;m hồn phong ph&uacute; trong con người m&igrave;nh.</p>

<p>Mục lục</p>

<p><em>Lời n&oacute;i đầu</em></p>

<p>Chương 1: Sống đơn giản</p>

<p>Chương 2: Vứt bỏ, sắp xếp</p>

<p>Chương 3: Hạnh ph&uacute;c l&agrave; biết đủ</p>

<p>Chương 4: Kh&ocirc;ng để bị chi phối, kh&ocirc;ng để bị cuốn v&agrave;o</p>

<p><em>Lời kết</em></p>

<p><em>Giới thiệu t&aacute;c giả</em></p>

<p>Th&ocirc;ng tin t&aacute;c giả:</p>

<p>Shunmyo Masuno,&nbsp;sinh năm 1953 ở tỉnh Kangawa. L&agrave; trụ tr&igrave; tại ch&ugrave;a Kenkoji, l&agrave; nh&agrave; thiết kế vườn Nhật v&agrave; l&agrave; giảng vi&ecirc;n trường Đại học Mỹ thuật Tamabijutsu. Sau khi tốt nghiệp khoa N&ocirc;ng nghiệp tại trường Đại học Tamagawa, &ocirc;ng đến ch&ugrave;a Soji để tu h&agrave;nh. &Ocirc;ng tham gia hoạt động s&aacute;ng tạo s&acirc;n vườn dựa tr&ecirc;n tư tưởng của thiền v&agrave; phong c&aacute;ch truyền thống của Nhật. Những t&aacute;c phẩm của &ocirc;ng nhận được đ&aacute;nh gi&aacute; cao cả trong v&agrave; ngo&agrave;i nước.&nbsp;&Ocirc;ng từng nhận được giải thưởng nghệ sĩ mới xuất sắc với tư c&aacute;ch l&agrave; một nh&agrave; thiết kế vườn Nhật. Ngo&agrave;i ra, &ocirc;ng c&ograve;n nhận được nhiều giải thưởng, bằng khen kh&aacute;c như Bằng khen của Bộ trưởng Bộ Ngoại giao, Hu&acirc;n chương Khen thưởng của To&agrave;n quyền Canada, Hu&acirc;n chương Tập tự Cộng h&ograve;a Li&ecirc;n bang Đức&hellip;</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (6, N'Minh Triết Trong Đời Sống (Tái Bản 2019)', N'minh-triet-trong-doi-song-(-tai-ban-2019)', N'/Upload/images/minh-triet-trong-doi-song.png', N'Darshani Deane', 1, 1, 30, 100, N'15 x 21', N'300', 2019, N'<p>Trong thập ni&ecirc;n vừa qua, t&ocirc;i đ&atilde; diễn thuyết khắp nơi về nhiều đề t&agrave;i kh&aacute;c nhau như &quot;Con đường chuyển h&oacute;a&quot;, &quot;Định hướng cho tương lai&quot;, &quot;Hạnh ph&uacute;c v&agrave; đau khổ&quot;,... Th&iacute;nh giả của t&ocirc;i gồm đủ mọi hạng người trong x&atilde; hội, gi&aacute;m đốc x&iacute; nghiệp, quản l&yacute; thương mại, gi&aacute;o sư đại học, sinh vi&ecirc;n, học sinh, qu&acirc;n nh&acirc;n, c&ocirc;ng nh&acirc;n, thợ thuyền... Sau buổi n&oacute;i chuyện thường c&oacute; phần thảo luận, một số người đ&atilde; đặt những c&acirc;u hỏi tương tự như sau:<br />
<br />
- Cuộc đời của t&ocirc;i l&agrave; một chuỗi đau khổ, b&agrave; c&oacute; c&aacute;ch n&agrave;o gi&uacute;p t&ocirc;i kh&ocirc;ng?<br />
<br />
- Tại sao những bất hạnh lại xảy ra cho t&ocirc;i? T&ocirc;i đ&atilde; l&agrave;m g&igrave; n&ecirc;n tội?<br />
<br />
- Tại sao l&uacute;c n&agrave;o t&ocirc;i cũng cảm thấy bất an, lo sợ?<br />
<br />
- L&agrave;m c&aacute;ch n&agrave;o để một người b&igrave;nh thường như t&ocirc;i c&oacute; thể thoải m&aacute;i trong đời sống hiện tại?<br />
<br />
...<br />
&nbsp;</p>

<p>T&ocirc;i quan niệm rằng: &quot;T&acirc;m hồn con người hiện nay đ&atilde; trở n&ecirc;n qu&aacute; m&aacute;y m&oacute;c, thụ động, kh&ocirc;ng thể tự chữa cho n&oacute; bằng c&aacute;c l&yacute; luận th&ocirc;ng thường. N&oacute; cần phải được n&acirc;ng l&ecirc;n một b&igrave;nh diện kh&aacute;c cao hơn để mở rộng ra, nh&igrave;n mọi sự qua một nh&atilde;n quang mới. Chỉ c&oacute; &aacute;p dụng c&aacute;ch đ&oacute; việc chữa trị mới mang lại kết quả tốt đẹp được&quot;</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (7, N'Muôn Kiếp Nhân Sinh - Many Times, Many Lives', N'muon-kiep-nhan-sinh-many-times,-many-lives', N'/Upload/images/muon-kiep-nhan-sinh.png', N'Nguyên Phong', 2, 8, 30, 100, N'20.5 x 14', N'450', 2020, N'<p><strong>Mu&ocirc;n Kiếp Nh&acirc;n Sinh - Many Times, Many Lives</strong></p>

<p><strong><em>Gi&aacute;o sư John Vũ &ndash; Nguy&ecirc;n Phong v&agrave; những c&acirc;u chuyện</em></strong><strong><em>&nbsp;chưa từng c&oacute; về tiền kiếp, kh&aacute;m ph&aacute; luật Nh&acirc;n quả, Lu&acirc;n hồi.</em></strong></p>

<p><strong><em>&ldquo;Mu&ocirc;n kiếp nh&acirc;n sinh&rdquo;</em></strong>&nbsp;l&agrave; t&aacute;c phẩm do Gi&aacute;o sư John Vũ - Nguy&ecirc;n Phong viết từ năm 2017 v&agrave; ho&agrave;n tất đầu năm 2020 ghi lại những c&acirc;u chuyện, trải nghiệm tiền kiếp kỳ lạ từ nhiều kiếp sống của người bạn t&acirc;m giao l&acirc;u năm, &ocirc;ng Thomas &ndash; một nh&agrave; kinh doanh t&agrave;i ch&iacute;nh nổi tiếng ở New York. Những c&acirc;u chuyện chưa từng tiết lộ n&agrave;y sẽ gi&uacute;p mọi người tr&ecirc;n thế giới chi&ecirc;m nghiệm, kh&aacute;m ph&aacute; c&aacute;c quy luật về luật Nh&acirc;n quả v&agrave; Lu&acirc;n hồi của vũ trụ giữa l&uacute;c tr&aacute;i đất đang gặp nhiều tai ương, biến động, khủng hoảng từng ng&agrave;y.</p>

<p><strong><em>&ldquo;Mu&ocirc;n kiếp nh&acirc;n sinh&rdquo;</em></strong>&nbsp;l&agrave; một bức tranh lớn với v&ocirc; v&agrave;n mảnh gh&eacute;p cuộc đời, l&agrave; một cuốn phim đồ sộ, sống động về những kiếp sống huyền b&iacute;, trải d&agrave;i từ nền văn minh Atlantis h&ugrave;ng mạnh đến vương quốc Ai Cập cổ đại của c&aacute;c Pharaoh quyền uy, đến Hợp Chủng Quốc Hoa Kỳ ng&agrave;y nay.</p>

<p><strong><em>&ldquo;Mu&ocirc;n kiếp nh&acirc;n sinh&rdquo;</em></strong>cung cấp cho bạn đọc kiến thức mới mẻ, v&ocirc; tận của nh&acirc;n loại lần đầu được h&eacute; mở, c&ugrave;ng những ph&acirc;n t&iacute;ch uy&ecirc;n b&aacute;c, ti&ecirc;n đo&aacute;n bất ngờ về hiện tại v&agrave; tương lai thế giới của những bậc hiền triết th&ocirc;ng th&aacute;i. Đời người tưởng chừng rất d&agrave;i nhưng lại tr&ocirc;i qua rất nhanh, sinh vượng suy tử, mong manh như s&oacute;ng nước. Luật nh&acirc;n quả cực kỳ ch&iacute;nh x&aacute;c, chi tiết, phức tạp được thu thập qua nhiều đời, nhiều kiếp, li&ecirc;n hệ tương hỗ đan xen chặt chữ lẫn nhau, kh&ocirc;ng ai c&oacute; thể t&iacute;nh được t&iacute;ch đức n&agrave;y c&oacute; thể trừ được nghiệp kia kh&ocirc;ng, kh&ocirc;ng ai c&oacute; thể biết được khi n&agrave;o nh&acirc;n sẽ trổ quả. Nhưng, một khi đ&atilde; g&acirc;y ra nh&acirc;n th&igrave; chắc chắn sẽ gặt quả - luật Nh&acirc;n quả của vũ trụ trước giờ kh&ocirc;ng bao giờ sai.</p>

<p>Luật Lu&acirc;n hồi v&agrave; Nh&acirc;n quả đ&atilde; tạo nh&acirc;n duy&ecirc;n để người n&agrave;y gặp người kia. Gặp nhau c&oacute; khi l&agrave; duy&ecirc;n, c&oacute; khi l&agrave; nợ; gặp nhau c&oacute; l&uacute;c để trả nợ, c&oacute; l&uacute;c để nối lại duy&ecirc;n xưa. C&oacute; biết bao việc diễn ra trong đời, tưởng chừng như l&agrave; ngẫu nhi&ecirc;n nhưng thật ra đ&atilde; được sắp đặt từ trước. Lu&acirc;n hồi l&agrave; một ng&ocirc;i trường rộng lớn, nơi tất cả con người, tất cả sinh vật đều phải học b&agrave;i học của ri&ecirc;ng m&igrave;nh cho đến khi thật ho&agrave;n thiện mới th&ocirc;i. Nếu kh&ocirc;ng chịu học hay chưa học được trọn vẹn th&igrave; buộc phải học lại, ch&iacute;nh x&aacute;c theo quy luật của Nh&acirc;n quả.</p>

<p>Thomas đ&atilde; chia sẻ v&igrave; sao đ&atilde; kể những c&acirc;u chuyện ri&ecirc;ng tư huyền b&iacute; n&agrave;y với Gi&aacute;o sư John Vũ để thực hiện t&aacute;c phẩm&nbsp;<strong><em>&ldquo;Mu&ocirc;n kiếp nh&acirc;n sinh&rdquo;:</em></strong></p>

<p>&nbsp;&ldquo;<em>Hiện nay thế giới đang trải qua giai đoạn hỗn loạn, x&aacute;o trộn, m&agrave; thật ra th&igrave; mọi quốc gia đều đang g&aacute;nh chịu những nghiệp quả m&agrave; họ đ&atilde; g&acirc;y ra trong qu&aacute; khứ. Mỗi quốc gia, cũng như mọi c&aacute; nh&acirc;n, đều c&oacute; những nghiệp quả ri&ecirc;ng do những nh&acirc;n m&agrave; họ đ&atilde; g&acirc;y ra. C&aacute; nh&acirc;n th&igrave; c&oacute; &lsquo;biệt nghiệp&lsquo; ri&ecirc;ng của từng người, nhưng quốc gia th&igrave;', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (8, N' Hiểu Và Ứng Dụng Nhanh - Chữa Lành Bằng Luân Xa', N'hieu-va-ung-dung-nhanh-chua-lanh-bang-luan-xa', N'/Upload/images/chua-lanh-bang-luan-xa.png', N'Jennie Harding', 1, 3, 30, 100, N'21 x 13.5', N'200', 2020, N'<p>Chữa bệnh qua c&aacute;c lu&acirc;n xa l&agrave; một hệ thống đ&atilde; được c&ocirc;ng nhận suốt h&agrave;ng ngh&igrave;n năm. D&ugrave; cho bạn muốn cải thiện sự khỏe mạnh của bản th&acirc;n về mặt thể chất, tinh thần hay t&acirc;m linh, liệu ph&aacute;p lu&acirc;n xa ch&iacute;nh l&agrave; chiếc ch&igrave;a kh&oacute;a vạn năm.<br />
CHỮA L&Agrave;NH BẰNG LU&Acirc;N XA chỉ ra vị tr&iacute; v&agrave; giải th&iacute;ch tầm quan trọng của c&aacute;c lu&acirc;n xa, cũng như những c&aacute;ch bạn c&oacute; thể &aacute;p dụng l&ecirc;n lu&acirc;n xa để đạt được sức khỏe, sự h&agrave;i h&ograve;a v&agrave; hạnh ph&uacute;c. Bạn sẽ kh&aacute;m ph&aacute; ra c&aacute;ch xử l&yacute; c&aacute;c trung t&acirc;m năng lượng n&agrave;y để tối ưu h&oacute;a d&ograve;ng năng lượng nội t&acirc;m, để thanh tẩy, khai th&ocirc;ng v&agrave; c&acirc;n bằng lại bản th&acirc;n. Với c&aacute;c b&agrave;i tập yoga, thực h&agrave;nh tưởng tượng v&agrave; thiền định cho mỗi lu&acirc;n xa, đ&acirc;y l&agrave; một hướng dẫn r&otilde; r&agrave;ng v&agrave; đầy cảm hứng cho bạn đọc.</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (9, N'Lối Sống Đơn Giản Của Người Nhật', N'loi-song-don-gian-cua-nguoi-nhat', N'/Upload/images/loi-song-toi-gian-cua-nguoi-nhat.png', N'Sasaki Fumio', 2, 8, 30, 100, N'13 x 20.5', N'300', 2018, N'<p><strong>Lối Sống Tối Giản Của Người Nhật</strong></p>

<p><em>Lối sống tối giản</em>&nbsp;l&agrave; c&aacute;ch sống cắt giảm vật dụng xuống c&ograve;n mức tối thiểu. V&agrave; c&ugrave;ng với cuộc sống &iacute;t đồ đạc, ta c&oacute; thể để t&acirc;m nhiều hơn tới hạnh ph&uacute;c, đ&oacute; ch&iacute;nh l&agrave; chủ đề của cuốn s&aacute;ch n&agrave;y.</p>

<p>Chẳng c&oacute; ai từ khi sinh ra đ&atilde; c&oacute; t&agrave;i sản, đồ đạc g&igrave; trong tay. Vậy n&ecirc;n bất cứ ai khi mới ch&agrave;o đời đều l&agrave; những người sống tối giản. Cứ mỗi lần bạn sở hữu trong tay những đồ d&ugrave;ng hơn mức cần thiết l&agrave; một lần bạn lấy mất tự do của ch&iacute;nh m&igrave;nh. Gi&aacute; trị bản th&acirc;n ch&uacute;ng ta kh&ocirc;ng đo bằng những đồ d&ugrave;ng m&agrave; ch&uacute;ng ta sở hữu. Những đồ d&ugrave;ng n&agrave;y chỉ cho ch&uacute;ng ta một ch&uacute;t cảm gi&aacute;c hạnh ph&uacute;c nhất thời m&agrave; th&ocirc;i. Mang theo những đồ d&ugrave;ng hơn mức cần thiết sẽ lấy hết thời gian, năng lượng của bạn. Khi nhận ra được điều đ&oacute;, tức l&agrave; bạn đ&atilde; bắt đầu trở th&agrave;nh một người sống tối giản.</p>

<p>Những người sống tối giản lu&ocirc;n cảm thấy vui vẻ, mới lạ mỗi ng&agrave;y. C&aacute;i cảm gi&aacute;c n&agrave;y, t&ocirc;i nghĩ bất cứ ai cũng c&oacute; thể cảm nhận được, d&ugrave; bạn c&oacute; phải l&agrave; một người sống tối giản hay kh&ocirc;ng, bởi bất cứ ai.</p>

<p><em>Lối sống tối giản của người Nhật&nbsp;</em>gồm c&oacute; năm chương, trong đ&oacute;, chương một, t&aacute;c giả sẽ giới thiệu cho bạn lối sống tối giản l&agrave; g&igrave;, đưa ra định nghĩa của anh về n&oacute;. Sau đ&oacute; anh sẽ đưa ra l&yacute; do v&igrave; sao m&igrave;nh lại theo lối sống n&agrave;y sau nhiều năm sống trong căn ph&ograve;ng của bản th&acirc;n.</p>

<p>Chương hai t&aacute;c giả sẽ đề cập đến tại sao sau ngần ấy năm, đồ đạc trong nh&agrave; lại chất nhiều đến thế. Những đồ đạc được t&iacute;ch tụ lại do th&oacute;i quen hay nhu cầu của con người n&agrave;y mang &yacute; nghĩa g&igrave;?</p>

<p>Chương ba l&agrave; những b&iacute; quyết để cắt giảm đồ đạc trong nh&agrave;. T&aacute;c giả sẽ đưa ra cho bạn những quy tắc cụ thể, những phương ph&aacute;p để c&oacute; thể giảm bớt đồ đạc trong nh&agrave;. Th&ecirc;m v&agrave;o đ&oacute; cũng sẽ giới thiệu cho bạn danh s&aacute;ch bổ sung 15 điều cho những người muốn tối giản hơn nữa c&ugrave;ng với toa thuốc cho &ldquo;căn bệnh muốn vứt bỏ&rdquo;.</p>

<p>Chương bốn, những thay đổi của ch&iacute;nh t&aacute;c giả sau khi dọn hết đồ đạc trong nh&agrave;. K&egrave;m theo đ&oacute;, anh c&ograve;n ph&acirc;n t&iacute;ch v&agrave; khảo s&aacute;t th&ecirc;m về c&aacute;c kết quả nghi&ecirc;n cứu t&acirc;m l&yacute; học.</p>

<p>Cuối c&ugrave;ng chương năm, tiếp nối &yacute; từ chương bốn, t&aacute;c giả sẽ giải th&iacute;ch tại sao những thay đổi của bản th&acirc;n lại dẫn đến &ldquo;hạnh ph&uacute;c&rdquo;.</p>

<p>Để hiểu s&acirc;u hơn về lối sống tối giản, bạn n&ecirc;n đọc hết từ chương một đến chương bốn. Tuy nhi&ecirc;n, bạn cũng c&oacute; thể đọc ri&ecirc;ng từng chương. Thậm ch&iacute; chỉ cần đọc chương ba cũng c&oacute; thể gi&uacute;p bạn cắt giảm được đồ đạc của m&igrave;nh.</p>

<p>Trong cuốn s&aacute;ch n&agrave;y, &ldquo;lối sống tối giản&rdquo; được hiểu l&agrave;: 1) giới hạn tối thiểu cần thiết cho bản th&acirc;n v&agrave; 2) vứt bỏ tất cả mọi thứ trừ những thứ quan trọng.</p>

<p>V&agrave; những người sống theo lối sống đ&oacute; gọi l&agrave; người sống tối giản.</p>

<p>Mục lục:</p>

<p><em>Cấu tr&uacute;c cuốn s&aacute;ch</em></p>

<p><em>Lời mở đầu</em></p>

<p>Chương 1: Tại sao lại c&oacute; những người sống tối giản?</p>

<p>Chương 2: Tại sao đồ đạc lại chất nhiều đến vậy?</p>

<p>Chương 3: 55 quy tắc vứt bỏ</p>

<p>Chương 4: Vứt bớt đồ đạc, 12 điều thay đổi trong t&ocirc;i</p>

<p>Chương 5: Kh&ocirc;ng phải trở n&ecirc;n hạnh ph&uacute;c m&agrave; l&agrave; cảm nhận hạnh ph&uacute;c</p>

<p><em>Lời kết &ndash; Lời cảm ơn c', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (10, N'Càng Kỷ Luật, Càng Tự Do', N'cang-ky-luat-cang-tu-do', N'/Upload/images/cang-ky-luat-cang-tu-do.png', N'Ca Tây', 2, 5, 30, 100, N'20 x 14.5', N'300', 2020, N'<p><strong>C&agrave;ng Kỷ Luật, C&agrave;ng Tự Do</strong></p>

<p>KỶ LUẬT vốn l&agrave; v&aacute;n cờ bạn phải tự đấu với ch&iacute;nh m&igrave;nh. Thắng - bạn sẽ c&oacute; được &ldquo;bản năng của người mạnh mẽ nhất&rdquo;, đ&oacute; l&agrave; sự tự kiểm so&aacute;t bản th&acirc;n. Thua - bạn m&atilde;i sống trong cảm gi&aacute;c tạm bợ, nuối tiếc. C&agrave;ng dễ d&agrave;ng dung t&uacute;ng cho những th&oacute;i quen tr&igrave; ho&atilde;n bao nhi&ecirc;u, cuộc sống của bạn sẽ đi c&agrave;ng nhanh tới sự mất kiểm so&aacute;t v&agrave; thiếu quy hoạch bấy nhi&ecirc;u.</p>

<p>H&atilde;y ki&ecirc;n tr&igrave; đặt ra y&ecirc;u cầu cao với bản th&acirc;n, từ chối sự m&ecirc; hoặc của th&oacute;i t&ugrave;y tiện đồng thời thiết lập cho m&igrave;nh những th&oacute;i quen tốt trong h&agrave;nh vi thường ng&agrave;y. Sự nỗ lực sẽ lu&ocirc;n được đền đ&aacute;p xứng đ&aacute;ng nếu bạn biết c&aacute;ch đầu tư c&ocirc;ng sức v&agrave; thời gian. Bởi một ng&agrave;y n&agrave;o đ&oacute; trong tương lai, những g&igrave; bạn l&agrave;m sẽ phản chiếu đầy đủ tr&ecirc;n ch&iacute;nh con người v&agrave; cuộc đời của bạn.&nbsp;</p>

<p>C&Agrave;NG KỶ LUẬT, C&Agrave;NG TỰ DO - Mong rằng tại thời điểm kết th&uacute;c h&agrave;nh tr&igrave;nh với cuốn s&aacute;ch, bạn đ&atilde; l&agrave; một phi&ecirc;n bản kh&aacute;c kỷ luật hơn, nhưng tự do hơn.</p>

<p><strong>Một v&agrave;i tr&iacute;ch dẫn:</strong></p>

<p>&ldquo;Bạn cần phải biết rằng t&igrave;nh y&ecirc;u l&agrave; hoa th&ecirc;u tr&ecirc;n gấm. C&oacute; th&igrave; tốt, kh&ocirc;ng c&oacute; cũng chẳng sao, thực sự kh&ocirc;ng đ&aacute;ng để bạn v&igrave; n&oacute; m&agrave; từ bỏ sự nghiệp, từ bỏ cơ hội thăng tiến thậm ch&iacute; l&agrave; từ bỏ cả cuộc đời vinh hoa sau n&agrave;y.&rdquo;</p>

<p>&ldquo;Những người trưởng th&agrave;nh như ch&uacute;ng ta n&ecirc;n nh&igrave;n cuộc sống rộng hơn một ch&uacute;t, ghen c&oacute; thể c&oacute;, tức giận c&oacute; thể c&oacute;. Thế nhưng, c&oacute; những cảm x&uacute;c chỉ n&ecirc;n lướt qua trong l&ograve;ng, ng&agrave;y h&ocirc;m sau ngủ dậy h&atilde;y để n&oacute; rời đi c&ugrave;ng với đ&ecirc;m đen mới l&agrave; c&aacute;ch lựa chọn tốt nhất.&rdquo;</p>

<p>&ldquo;Mỗi người đều c&oacute; kinh nghiệm sống kh&ocirc;ng giống nhau, y&ecirc;u cầu kh&ocirc;ng giống nhau. Điều giống nhau l&agrave; ch&uacute;ng ta đều n&ecirc;n t&igrave;m mọi c&aacute;ch trau dồi khả năng của bản th&acirc;n để sống tốt cuộc đời n&agrave;y.&rdquo;</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (11, N'CR7 - Hành Trình Lên Đỉnh Thế Giới', N'cr7-hanh-trinh-len-dinh-the-gioi', N'/Upload/images/cr7-hanh-trinh-len-dinh-the-gioi.jpg', N'Guillem Balague', 6, 10, 35, 476, N'24 x 16', N'500', 2020, N'<p>Khi sinh ra, c&oacute; 4 điều m&agrave; ch&uacute;ng ta kh&ocirc;ng c&oacute; quyền được lựa chọn l&agrave;: cha, mẹ, anh chị em và nơi được sinh ra. V&agrave; c&ograve;n một điều nữa l&agrave; đam m&ecirc; của chúng ta, thứ lu&ocirc;n tạo động lực gi&uacute;p ta hướng về ph&iacute;a trước. Ngo&agrave;i ra, tất cả l&agrave; kh&ocirc;ng thực sự cần thiết.</p>

<p>&nbsp;Trước khi b&agrave;n tới đam m&ecirc; của một Cristiano Ronaldo đang ở tr&ecirc;n đỉnh cao danh vọng, điều g&igrave; xứng đáng với những trang đ&acirc;̀u ti&ecirc;n của cuốn s&aacute;ch n&agrave;y: người mẹ, gia đình hay nơi mà anh &acirc;́y đã được sinh ra? C&acirc;u trả lời nhất định l&agrave; Dolores Aveiro, người mẹ vĩ đại hiện vẫn đang sống c&ugrave;ng v&agrave; chăm chút cho cậu con trai Junior của Ronaldo như m&ocirc;̣t người mẹ chăm con, chứ kh&ocirc;ng phải bà n&ocirc;̣i chăm cháu. C&aacute;ch đ&acirc;y hơn 20 năm, bà đã dằn l&ograve;ng cho ph&eacute;p c&acirc;̣u con trai 12 tu&ocirc;̉i của mình rời miền qu&ecirc; ngh&egrave;o Madeira đ&ecirc;̉ theo đu&ocirc;̉i đam m&ecirc; trở thành m&ocirc;̣t c&acirc;̀u thủ bóng đá chuy&ecirc;n nghi&ecirc;̣p. M&ocirc;̣t quy&ecirc;́t định x&eacute; l&ograve;ng, nhưng bà ch&acirc;́p nh&acirc;̣n, bởi b&agrave; tin đó là lựa chọn t&ocirc;́t nh&acirc;́t, th&acirc;̣m chí có th&ecirc;̉ là duy nh&acirc;́t. Hoặc cũng c&oacute; thể v&igrave; b&agrave; đ&atilde; từng phải trải qua điều tương tự. Người ta thường n&oacute;i, trong cuộc đời, những đức t&iacute;nh v&agrave; khiếm khuyết c&oacute; thể được lặp lại từ thế hệ n&agrave;y qua thế hệ kh&aacute;c. Năm xưa, cha của b&agrave; cũng đã ra đi, mặc d&ugrave; theo một c&aacute;ch kh&aacute;c, trong chiếc vali ng&agrave;y xưa ấy kh&ocirc;ng c&oacute; niềm thương y&ecirc;u - thứ m&agrave; b&agrave; đ&atilde; n&iacute;ch chặt trong vali của cậu con trai trước chuyến bay đ&ecirc;́n Lisbon</p>

<p>----</p>

<p>Khi l&ecirc;n 8 hay 9, Ronaldo r&acirc;́t thích được ở b&ecirc;n cha. Nhi&ecirc;̀u đ&ecirc;m, đ&ocirc;̀ng h&ocirc;̀ đã chỉ 11 giờ và mắt đ&atilde; d&iacute;u lại nhưng anh kh&ocirc;ng th&ecirc;̉ nào y&ecirc;n t&acirc;m l&ecirc;n giường khi kh&ocirc;ng có cha b&ecirc;n cạnh. Anh sẽ cùng với chị gái hay m&ocirc;̣t vài người bạn đ&ecirc;́n quán bar đ&ecirc;̉ kéo &ocirc;ng &acirc;́y v&ecirc;̀, mặc cho &ocirc;ng kh&ocirc;ng chịu. Anh cũng r&acirc;́t thích ở b&ecirc;n cạnh &ocirc;ng tại m&ocirc;̣t góc nào đó trong quán bar. Chỉ đơn giản l&agrave; ngồi y&ecirc;n lặng và u&ocirc;́ng. Và kh&ocirc;ng g&acirc;y ra b&acirc;́t kì rắc r&ocirc;́i nào.</p>

<p>Khi &ocirc;ng chịu v&ecirc;̀ nhà cũng là lúc mà &ocirc;ng cần đến bờ vai của cậu con trai. &Ocirc;ng đ&atilde; qu&aacute; say rồi.</p>

<p>Ở đ&ocirc;̣ tu&ocirc;̉i c&ograve;n rất trẻ, Ronaldo d&acirc;̀n dần phải gánh v&aacute;c vai trò của người cha trong gia đình - thứ m&agrave; cha của anh bỏ b&ecirc; v&igrave; những cơn say.</p>

<p>&ldquo;T&ocirc;i chỉ mu&ocirc;́n con trai t&ocirc;i được hạnh phúc và thành c&ocirc;ng.&rdquo; Đó là c&acirc;u nói mà anh đã nghe th&acirc;́y ở quán bar. &ldquo;T&ocirc;i mu&ocirc;́n s&ocirc;́ng ở th&ecirc;́ giới của t&ocirc;i. Và th&ecirc;́ giới của n&oacute; do n&oacute; quyết định.&rdquo; Thực t&ecirc;́, &ocirc;ng kh&ocirc;ng thích chuy&ecirc;̉n đ&ecirc;́n Manchester khi Cristiano thi đ&acirc;́u ở đó, và cũng chỉ đ&ecirc;́n thăm một vài l&acirc;̀n.</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (12, N'Phép Màu Để Trở Thành Chính Mình ( Tái Bản 2018)', N'phep-mau-de-tro-thanh-chinh-minh-tai-ban-2019', N'/Upload/images/phep-mau-de-tro-thanh-chinh-minh.png', N'Nhan Húc Quân', 2, 2, 35, 100, N'13 x 20.5', N'280', 2018, N'<p>Cuốn s&aacute;ch&nbsp;<strong>Ph&eacute;p m&agrave;u để trở th&agrave;nh ch&iacute;nh m&igrave;nh</strong>&nbsp;ch&iacute;nh l&agrave; những đ&uacute;c kết th&agrave;nh c&ocirc;ng qua những nỗ lực vượt kh&oacute; của t&aacute;c giả, từ khi bắt đầu lập nghiệp cho đến b&acirc;y giờ - l&agrave; Tổng Gi&aacute;m đốc New Toyo Việt Nam. L&agrave; phụ nữ, con đường lập nghiệp kh&ocirc;ng hề đơn giản, v&agrave; c&agrave;ng kh&ocirc;ng hề đơn giản hơn đối với bản th&acirc;n t&aacute;c giả - l&agrave; một phụ nữ l&agrave;m việc trong một m&ocirc;i trường m&agrave; chỉ c&oacute; sức lực người đ&agrave;n &ocirc;ng nhiều khi mới đảm đương nổi. Đối với c&ocirc;ng việc, chị kh&ocirc;ng hề c&oacute; kinh nghiệm, c&agrave;ng kh&ocirc;ng được đ&agrave;o tạo trước đ&oacute;.&nbsp; V&igrave; thế, chị vừa l&agrave; thực tập sinh vừa l&agrave; thầy gi&aacute;o cho ch&iacute;nh m&igrave;nh; ng&atilde; từ đ&acirc;u đứng l&ecirc;n từ đấy; sai s&oacute;t chỗ n&agrave;o chỉnh sửa tại chỗ đ&oacute;. B&agrave;i học mỗi ng&agrave;y của chị l&agrave; r&uacute;t kinh nghiệm v&agrave; ng&agrave;y mai phải tốt hơn ng&agrave;y h&ocirc;m nay.</p>

<p>Những kinh nghiệm lập nghiệp, điều h&agrave;nh doanh nghiệp kinh doanh được t&aacute;c giả Nhan H&uacute;c Qu&acirc;n chia sẻ trong t&aacute;c phẩm, ch&iacute;nh l&agrave; những kinh nghiệm qu&yacute; b&aacute;u, b&agrave;i học gi&aacute; trị d&agrave;nh cho c&aacute;c bạn trẻ - những ai đ&atilde; v&agrave; đang đi tr&ecirc;n con đường lập th&acirc;n, lập nghiệp đặc biệt l&agrave; những c&ocirc; g&aacute;i trẻ mang nhiều kh&aacute;t vọng th&agrave;nh c&ocirc;ng.</p>

<p>T&aacute;c giả Nhan H&uacute;c Qu&acirc;n chia sẻ: &ldquo;Ước mơ chỉ c&oacute; thể th&agrave;nh hiện thực khi tr&aacute;i tim bạn đ&atilde; cảm nhận hoặc t&igrave;m thấy niềm đam m&ecirc; trong lĩnh vực m&agrave; m&igrave;nh y&ecirc;u th&iacute;ch; hoặc trong c&ocirc;ng việc hằng ng&agrave;y của ch&iacute;nh m&igrave;nh. C&aacute;c bạn ho&agrave;n to&agrave;n c&oacute; quyền hy vọng v&agrave; đặt niềm tin v&agrave;o sự đam m&ecirc; ch&iacute;nh đ&aacute;ng của m&igrave;nh bằng l&ograve;ng quả cảm, th&aacute;i độ nghi&ecirc;m t&uacute;c, ch&iacute;nh chắn trong suy nghĩ, sự chăm chỉ, nhiệt huyết v&agrave; t&iacute;nh ki&ecirc;n định cộng với khả năng thực h&agrave;nh của ch&iacute;nh bản th&acirc;n. Biết chọn c&aacute;ch sống tử tế, đ&agrave;ng ho&agrave;ng với những người xung quanh th&igrave; cuộc sống sẽ lu&ocirc;n mỉm cười với bạn. V&agrave; bạn sẽ thong dong, khoan thai bước tiếp những con đường rộng mở ở ph&iacute;a trước&hellip;&rdquo; Với ri&ecirc;ng c&aacute;c độc giả nữ chị c&ograve;n nhắn nhủ: &ldquo;T&ocirc;i c&ograve;n nhớ năm học lớp 5, c&ocirc; gi&aacute;o dạy học sinh nữ rằng: &ldquo;Sau n&agrave;y trưởng th&agrave;nh, c&aacute;c em phải c&oacute; 50% sự nhu m&igrave;, tỉ mỉ của phụ nữ v&agrave; 50% c&ograve;n lại phải c&oacute; sự can đảm, dũng cảm của người đ&agrave;n &ocirc;ng&rdquo;. L&uacute;c đ&oacute;, t&ocirc;i rất t&acirc;m đắc v&agrave; th&iacute;ch th&uacute; lời n&oacute;i n&agrave;y. V&agrave; b&acirc;y giờ, t&ocirc;i h&agrave;i l&ograve;ng v&igrave; đ&atilde; l&agrave;m được điều đ&oacute;. Hy vọng c&aacute;c bạn cũng vậy&rdquo;.</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (13, N'Rich Habits - Poor Habits - Sự Khác Biệt Giữa Người Giàu Và Người Nghèo', N'rich-habits-poor-habits-su-khac-biet-giua-nguoi-giau-va-nguoi-ngheo', N'/Upload/images/rich-habits-poor-habits-su-khac-biet-giua-nguoi-giau-va-nguoi-ngheo.png', N'Tom Corley, Michael Yardney', 2, 3, 35, 100, N'13 x 20.5', N'450', 2019, N'<p><strong>Sự kh&aacute;c biệt giữa người gi&agrave;u v&agrave; người ngh&egrave;o</strong></p>

<p><strong>- Ch&uacute;ng ta thường đặt c&acirc;u hỏi: &ldquo;Tại sao người gi&agrave;u ng&agrave;y c&agrave;ng gi&agrave;u?&rdquo;. Hầu như kh&ocirc;ng phải do may mắn. Kh&ocirc;ng phải v&igrave; nơi họ sinh ra v&agrave; cũng kh&ocirc;ng phải v&igrave; họ thắng xổ số. Chỉ l&agrave; người gi&agrave;u l&agrave;m mọi thứ theo một c&aacute;ch kh&aacute;c. Họ nghĩ kh&aacute;c, họ h&agrave;nh động kh&aacute;c v&agrave; họ c&oacute; những th&oacute;i quen kh&aacute;c.</strong></p>

<p><strong>- C&oacute; c&acirc;u ngạn ngữ: &ldquo;Cho một người một con c&aacute; gi&uacute;p anh ấy ấm bụng một ng&agrave;y. Dạy một người c&aacute;ch c&acirc;u c&aacute; gi&uacute;p họ ấm bụng cả đời&rdquo;.</strong></p>

<p><strong>- Cuốn s&aacute;ch &ldquo;Sự kh&aacute;c biệt giữa người gi&agrave;u v&agrave; người ngh&egrave;o&rdquo; gi&uacute;p bạn ph&aacute;t triển c&aacute;c th&oacute;i quen gi&agrave;u c&oacute; v&agrave; loại bỏ th&oacute;i quen ngh&egrave;o kh&oacute;.</strong></p>

<p><strong>- Khi bạn l&agrave;m những việc m&agrave; người gi&agrave;u c&oacute; v&agrave; th&agrave;nh c&ocirc;ng l&agrave;m, khi bạn suy nghĩ giống họ, khi bạn h&agrave;nh động như họ, bạn sẽ bắt đầu c&oacute; được những kết quả giống họ v&agrave; trở n&ecirc;n gi&agrave;u c&oacute;.</strong></p>

<p><strong>V&igrave; sao người gi&agrave;u ng&agrave;y c&agrave;ng gi&agrave;u hơn?</strong></p>

<p>Rất nhiều nghi&ecirc;n cứu cho thấy, trong khi người gi&agrave;u ng&agrave;y c&agrave;ng gi&agrave;u, th&igrave; tầng lớp trung lưu lại phải l&agrave;m việc vất vả hơn v&agrave; nhiều thời gian hơn so với một thập kỷ trước, nhưng kiếm được &iacute;t hơn mỗi tuần. Thế c&ograve;n người ngh&egrave;o th&igrave; sao? Chuyện g&igrave; đang xảy ra với họ? Họ tăng về số lượng v&agrave; họ bị tổn thương. Số lượng người ngh&egrave;o tăng l&ecirc;n trong khi tầng lớp trung lưu mỏng dần.</p>

<p>&ldquo;Khoảng c&aacute;ch thu nhập&rdquo; đang ng&agrave;y c&agrave;ng tăng v&agrave; hầu hết c&aacute;c chuy&ecirc;n gia t&agrave;i ch&iacute;nh nhận thấy xu hướng n&agrave;y vẫn sẽ tiếp tục v&agrave; chưa kết th&uacute;c. Một trong c&aacute;c thực tế cuộc sống l&agrave;, mặc d&ugrave; sống trong thời đại tốt đẹp nhất ở những quốc gia gi&agrave;u c&oacute; nhất thế giới, hầu hết con người ng&agrave;y nay vẫn chật vật trong chuyện t&agrave;i ch&iacute;nh. V&agrave; khoảng c&aacute;ch giữa người gi&agrave;u v&agrave; người ngh&egrave;o c&oacute; vẻ ng&agrave;y c&agrave;ng lớn hơn.</p>

<p>Vậy n&ecirc;n hiện thực n&agrave;y khiến người ta đặt c&acirc;u hỏi &ldquo;Tại sao người gi&agrave;u ng&agrave;y c&agrave;ng gi&agrave;u?&rdquo; Hầu như kh&ocirc;ng phải do may mắn. Kh&ocirc;ng phải v&igrave; nơi họ sinh ra v&agrave; cũng kh&ocirc;ng phải v&igrave; họ thắng xổ số. Chỉ l&agrave; người gi&agrave;u l&agrave;m mọi thứ theo một c&aacute;ch kh&aacute;c. Họ nghĩ kh&aacute;c, họ h&agrave;nh động kh&aacute;c v&agrave; họ c&oacute; những th&oacute;i quen kh&aacute;c. D&ugrave; bạn đang ở đ&acirc;u trong cuộc đời t&agrave;i ch&iacute;nh của m&igrave;nh, bạn cũng c&oacute; thể trở n&ecirc;n gi&agrave;u c&oacute;. Nhưng để gi&agrave;u c&oacute; bạn sẽ phải l&agrave;m mọi thứ theo c&aacute;ch kh&aacute;c đi. Bạn sẽ phải nghĩ kh&aacute;c. Bạn sẽ phải h&agrave;nh xử kh&aacute;c. V&agrave; bạn sẽ phải c&oacute; những th&oacute;i quen kh&aacute;c - Th&oacute;i quen gi&agrave;u c&oacute;.</p>

<p><strong>Cuốn s&aacute;ch n&agrave;y c&oacute; thật sự gi&uacute;p bạn gi&agrave;u c&oacute;?</strong></p>

<p>Đ&acirc;y kh&ocirc;ng phải một cuốn s&aacute;ch về tiền bạc, đầu tư, bất động sản hay chứng kho&aacute;n. Thay v&agrave;o đ&oacute;, đ&acirc;y l&agrave; cuốn s&aacute;ch về bắt chước c&aacute;ch người gi&agrave;u cảm nhận, suy nghĩ, h&agrave;nh động v&agrave; h&agrave;nh xử. Đ&acirc;y l&agrave; cuốn s&aacute;ch về ph&aacute;t triển c&aacute;c th&oacute;i quen gi&agrave;u c&oacute; (c&aacute;c th&oacute;i quen hầu hết', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (14, N'Đời Ngắn Đừng Ngủ Dài (Tái Bản 2018)', N'doi-ngan-dung-ngu-dai-tai-ban-2018', N'/Upload/images/doi-ngan-dung-ngu-dai.png', N'Robin Sharma', 2, 6, 35, 100, N'13 x 20.5', N'250', 2018, N'<p>&ldquo;Mọi lựa chọn đều gi&aacute; trị. Mọi bước đi đều quan trọng. Cuộc sống vẫn diễn ra theo c&aacute;ch của n&oacute;, kh&ocirc;ng phải theo c&aacute;ch của ta. H&atilde;y ki&ecirc;n nhẫn. Tin tưởng. H&atilde;y giống như người thợ cắt đ&aacute;, đều đặn từng nhịp, ng&agrave;y qua ng&agrave;y. Cuối c&ugrave;ng, một nh&aacute;t cắt duy nhất sẽ ph&aacute; vỡ tảng đ&aacute; v&agrave; lộ ra vi&ecirc;n kim cương. Người tr&agrave;n đầy nhiệt huyết v&agrave; tận t&acirc;m với việc m&igrave;nh l&agrave;m kh&ocirc;ng bao giờ bị chối bỏ. Sự thật l&agrave; thế.&rdquo;</p>

<p>Bằng những lời chia sẻ thật ngắn gọn, dễ hiểu về những trải nghiệm v&agrave; suy ngẫm trong đời, Robin Sharma tiếp tục phong c&aacute;ch viết của &ocirc;ng từ cuốn s&aacute;ch&nbsp;Điều vĩ đại đời thường&nbsp;để mang đến cho độc giả những b&agrave;i viết như lời t&acirc;m sự, vừa ch&acirc;n th&agrave;nh vừa s&acirc;u sắc.</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (15, N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh (Bản In Mới - 2018)', N'toi-thay-hoa-vang-tren-co-xanh-ban-in-moi-2018', N'/Upload/images/toi-thay-hoa-vang-tren-co-xanh.jpg', N'Nguyễn Nhật Ánh', 3, 6, 35, 378, N'13 x 20', N'400', 2018, N'<p>Những c&acirc;u chuyện nhỏ xảy ra ở một ng&ocirc;i l&agrave;ng nhỏ: chuyện người, chuyện c&oacute;c, chuyện ma, chuyện c&ocirc;ng ch&uacute;a v&agrave; ho&agrave;ng tử , rồi chuyện đ&oacute;i ăn, ch&aacute;y nh&agrave;, lụt lội,... Bối cảnh l&agrave; trường học, nh&agrave; trong x&oacute;m, b&atilde;i tha ma. Dẫn chuyện l&agrave; cậu b&eacute; 15 tuổi t&ecirc;n Thiều. Thiều c&oacute; ch&uacute; ruột l&agrave; ch&uacute; Đ&agrave;n, c&oacute; bạn th&acirc;n l&agrave; c&ocirc; b&eacute; Mận. Nhưng nh&acirc;n vật đ&aacute;ng y&ecirc;u nhất lại l&agrave; Tường, em trai Thiều, một cậu b&eacute; học kh&ocirc;ng giỏi. Thiều, Tường v&agrave; những đứa trẻ sống trong c&ugrave;ng một l&agrave;ng, học c&ugrave;ng một trường, c&oacute; biết bao chuyện chung. Ch&uacute;ng n&ocirc; đ&ugrave;a, c&atilde;i cọ rồi y&ecirc;u thương nhau, c&ugrave;ng lớn l&ecirc;n theo năm th&aacute;ng, trải qua bao sự kiện biến cố của cuộc đời.<br />
T&aacute;c giả vẫn giữ c&aacute;ch kể chuyện bằng ch&iacute;nh giọng trong s&aacute;ng hồn nhi&ecirc;n của trẻ con. 81 chương ngắn l&agrave; 81 c&acirc;u chuyện hấp dẫn với nhiều chi tiết th&uacute; vị, cảm động, c&oacute; những t&igrave;nh tiết bất ngờ, từ đ&oacute; lộ r&otilde; t&iacute;nh c&aacute;ch người. Cuốn s&aacute;ch, v&igrave; thế, c&oacute; sức &aacute;m ảnh.</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (17, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai Tập 16 (Tái Bản 2019)', N'doreamon-chu-meo-may-den-tu-tuong-lai-tai-ban-2019', N'/Upload/images/chu-meo-may-den-tu-tuong-lai-tap-16.jpg', N'Fujiko F Fujio', 5, 9, 50, 192, N'11.3 x 17.6', N'200', 2019, N'<p>Những c&acirc;u chuyện về ch&uacute; m&egrave;o m&aacute;y th&ocirc;ng minh Doraemon v&agrave; nh&oacute;m bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa ch&uacute;ng ta bước v&agrave;o thế giới hồn nhi&ecirc;n, trong s&aacute;ng đầy ắp tiếng cười với một kho bảo bối k&igrave; diệu - những bảo bối biến ước mơ của ch&uacute;ng ta th&agrave;nh sự thật. Nhưng tr&ecirc;n tất cả Doraemon l&agrave; hiện th&acirc;n của t&igrave;nh bạn cao đẹp, của niềm kh&aacute;t khao vương tới những tầm cao.</p>

<p>Đại b&aacute;c truyền tin mật</p>

<p>M&aacute;y chữ &quot;nghe g&igrave; viết nấy&quot;</p>

<p>Tiếng vọng l&uacute;c nửa đ&ecirc;m</p>

<p>Bộ dụng cụ &quot;Ng&agrave;y tết lười biếng&quot;</p>

<p>Cần số tạo dốc</p>

<p>Con g&agrave; sao ch&eacute;p</p>

<p>Vụt trượt th&igrave; ... &quot;tua lại&quot;</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (18, N'Lớp Học Mật Ngữ - Tập 13', N'lop-hoc-mat-ngu-tap-13', N'/Upload/images/lop-hoc-mat-ngu-tap-13.jpg', N'Nhiều tác giả', 5, 9, 50, 100, N'14.5 x 20.5', N'150', 2020, N'<p><strong>Lớp Học Mật Ngữ - Tập 13</strong></p>

<p>V&agrave;o team y&ecirc;u mưa xem c&oacute; g&igrave; n&agrave;o, c&oacute; g&igrave; n&agrave;o...</p>

<p>Hội những bạn đang than &ldquo;trời n&oacute;ng qu&aacute;, cần gấp một cơn mưa&rdquo; đ&acirc;u, h&atilde;y &ldquo;bơi&rdquo; v&agrave;o đ&acirc;y th&ocirc;i! Tập 13 n&agrave;y sẽ c&oacute; phần ngoại truyện 12 người bạn lớp Ho&agrave;ng Đạo sẽ phản ứng như thế n&agrave;o khi trời mưa. Tập thể dục dưới mưa, chuẩn bị kỹ c&agrave;ng cho trời mưa, đắp chăn coi phim khi ngo&agrave;i trời đang mưa... bạn c&oacute; muốn biết cung ho&agrave;ng đạo của m&igrave;nh sẽ lựa chọn &ldquo;bối cảnh&rdquo; n&agrave;o cho bộ phim &ldquo;mưa m&ugrave;a H&egrave;&rdquo; của m&igrave;nh kh&ocirc;ng? Đ&oacute;n đọc tập 13 n&agrave;y nh&eacute;!</p>

<p><strong>Kim Ngưu v&agrave; những người bạn</strong></p>

<p>Truyện mới co&oacute;ng Hiệp Sĩ Tiết Kiệm sẽ xuất hiện trong tập n&agrave;y sẽ mời bạn c&ugrave;ng tham gia v&agrave;o một tr&ograve; chơi si&ecirc;u hấp dẫn tr&ecirc;n... b&atilde;i phế liệu c&ugrave;ng c&aacute;c bạn lớp Ho&agrave;ng Đạo v&agrave; Ho&agrave;ng Cung. &ldquo;G&aacute;nh Xiếc Phế Liệu&rdquo; sẽ đem đến những m&agrave;n tr&igrave;nh diễn c&ugrave;ng c&aacute;c thử th&aacute;ch si&ecirc;u h&oacute;c b&uacute;a, cực th&oacute;t tim, v&agrave; dĩ nhi&ecirc;n, v&ocirc; c&ugrave;ng h&agrave;i hước để c&aacute;c &ldquo;hiệp sĩ ho&agrave;ng đạo&rdquo; t&iacute;ch điểm gi&agrave;nh phần thưởng. H&atilde;y xem sau một giờ chơi, Kim Ngưu c&oacute; l&agrave; người gi&agrave;nh chiến thắng với chiếc balo ho&agrave;ng đạo cực ngầu m&agrave; bạn b&egrave; cố t&igrave;nh gi&agrave;nh cho cậu ấy kh&ocirc;ng nh&eacute;!</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (19, N'Châu Nhuận Phát - Đại Hiệp Hồng Kông', N'chau-nhuan-phat-dai-hiep-hong-kong', N'/Upload/images/chau-nhuan-phat-dai-hiep-hong-kong.png', N'Lin Feng', 6, 8, 50, 364, N'20.5 x 14.5', N'385', 2021, N'<p><strong><em>Ch&acirc;u Nhuận Ph&aacute;t - Đại hiệp Hồng K&ocirc;ng</em></strong></p>

<p>Cuốn s&aacute;ch đầy đủ v&agrave; chi tiết nhất về ng&ocirc;i sao điện ảnh Hồng K&ocirc;ng Ch&acirc;u Nhuận Ph&aacute;t từng được ph&aacute;t h&agrave;nh tr&ecirc;n thế giới.</p>

<p>Với mong muốn mang đến một bức tranh to&agrave;n diện, s&acirc;u sắc về cuộc đời diễn vi&ecirc;n Ch&acirc;u Nhuận Ph&aacute;t, First News - Tr&iacute; Việt kh&ocirc;ng chỉ dịch từ một khảo cứu điện ảnh Hồng K&ocirc;ng dựa tr&ecirc;n sự nghiệp Ch&acirc;u Nhuận Ph&aacute;t của Tiến sĩ Lin Feng -&nbsp;<em>&ldquo;Chow Yun-Fat and Territories of Hong Kong Stardom&rdquo;,&nbsp;</em>m&agrave; c&ograve;n tổng hợp, ph&acirc;n t&iacute;ch th&ecirc;m rất nhiều tư liệu qu&yacute; về diễn vi&ecirc;n huyền thoại n&agrave;y để ra mắt độc giả Việt Nam.</p>

<p>Ch&acirc;u Nhuận Ph&aacute;t kh&ocirc;ng chỉ l&agrave; một người được c&ocirc;ng ch&uacute;ng đặc biệt y&ecirc;u mến m&agrave; c&ograve;n l&agrave; biểu tượng lớn của nền điện ảnh mang đậm bản sắc Hồng K&ocirc;ng. Điều n&agrave;y được khẳng định kh&ocirc;ng chỉ bởi t&agrave;i năng v&agrave; sự cống hiến hơn 40 năm tr&ecirc;n m&agrave;n ảnh, m&agrave; c&ograve;n bởi đức độ, nh&acirc;n c&aacute;ch, kh&iacute; chất, nghĩa kh&iacute; v&agrave; sự khi&ecirc;m nhường hiếm c&oacute; của &ldquo;người h&ugrave;ng&rdquo; Ch&acirc;u Nhuận Ph&aacute;t.</p>

<p>&nbsp;Để vinh danh những cống hiến của Ch&acirc;u Nhuận Ph&aacute;t, Đại học Hồng K&ocirc;ng đ&atilde; trao bằng Tiến sĩ Danh dự cho &ocirc;ng v&agrave;o năm 2001. Năm 2003, một nội dung mới về sự nghiệp Ch&acirc;u Nhuận Ph&aacute;t được đưa v&agrave;o trong s&aacute;ch gi&aacute;o khoa tại Hồng K&ocirc;ng. &Ocirc;ng l&agrave; nghệ sĩ Hồng K&ocirc;ng duy nhất c&oacute; được vinh dự n&agrave;y. Ng&agrave;nh Gi&aacute;o dục Hồng K&ocirc;ng cho rằng ch&iacute;nh sự &ldquo;chăm chỉ nỗ lực&rdquo;, &ldquo;khi&ecirc;m tốn&rdquo;, &ldquo;hiếu thảo&rdquo;, &ldquo;tinh thần học hỏi suốt đời&rdquo;, &ldquo;khả năng tự ho&agrave;n thiện&rdquo; v&agrave; &ldquo;t&iacute;nh ch&iacute;nh trực&rdquo; khiến Ch&acirc;u Nhuận Ph&aacute;t trở th&agrave;nh một tấm gương cho lớp trẻ, sinh vi&ecirc;n, học sinh noi theo.</p>

<p>Kh&ocirc;ng chỉ ghi dấu ấn ở tất cả mọi bước ngoặt quan trọng của điện ảnh Hồng K&ocirc;ng, Ch&acirc;u Nhuận Ph&aacute;t c&ograve;n g&oacute;p phần th&uacute;c đẩy cuộc c&aacute;ch mạng vượt giai cấp, truyền cảm hứng cho người Hồng K&ocirc;ng ở mọi tầng lớp vươn l&ecirc;n trong x&atilde; hội. Khi Ch&acirc;u Nhuận Ph&aacute;t tuy&ecirc;n bố hiến tặng to&agrave;n bộ t&agrave;i sản hơn 700 triệu USD của m&igrave;nh cho người ngh&egrave;o, c&oacute; thể n&oacute;i rằng Ch&acirc;u Nhuận Ph&aacute;t ch&iacute;nh l&agrave; một trong những nh&acirc;n vật ti&ecirc;u biểu g&oacute;p phần tạo dựng n&ecirc;n &ldquo;Niềm tự h&agrave;o Hồng K&ocirc;ng&rdquo;.</p>

<p><strong>Ch&acirc;u Nhuận Ph&aacute;t - Đại hiệp Hồng K&ocirc;ng</strong><em>&nbsp;</em>mang đến cho độc giả bức tranh đa dạng của văn h&oacute;a, x&atilde; hội, điện ảnh Hồng K&ocirc;ng từ những năm 1950 cho đến nay. Th&ocirc;ng qua chặng đường điện ảnh v&agrave; sự tương t&aacute;c của Ch&acirc;u Nhuận Ph&aacute;t đến văn h&oacute;a - x&atilde; hội Hồng K&ocirc;ng v&agrave; khu vực, ch&uacute;ng ta hiểu được v&igrave; sao Hồng K&ocirc;ng lại vươn m&igrave;nh trở th&agrave;nh một con rồng ch&acirc;u &Aacute; với những ph&aacute;t triển vượt trội về kinh tế, gi&aacute;o dục; v&agrave; v&igrave; sao người Hồng K&ocirc;ng, giới trẻ Hồng K&ocirc;ng lại l&agrave; những c&ocirc;ng d&acirc;n ưu t&uacute; v&agrave; c&oacute; &yacute; thức về tương lai Hồng K&ocirc;ng.</p>

<p>Một Hương Cảng Hồng K&ocirc;ng đầy sống động v&agrave; thăng trầm hiện l&ecirc;n trong h&agrave;nh tr&igrave;nh của Ch&acirc;u Nhuận Ph&aacute;t với đủ h&agrave;o kh&iacute;, nghĩa t&igrave;nh, bi kịch, nụ cười v&agrave; nước mắt. Sức hấp dẫn của thi&ecirc;n đường mua sắm Hồng K&ocirc;ng, sức hấp dẫn của những ng&ocirc;i sao điện ảnh lừng lẫy một thời như Ch', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (20, N'999 Lá Thư Gửi Cho Chính Mình - Mong Bạn Trở Thành Phiên Bản Hoàn Hảo Nhất (Tái Bản 2020)', N'999-la-thu-gui-cho-chinh-minh-mong-ban-tro-thanh-phien-ban-hoan-hoa-nhat-tai-ban-2020', N'/Upload/images/999-la-thu-gui-cho-chinh-minh.jpg', N'Miêu Công Tử', 3, 1, 50, 220, N'18 x 12.5', N'220', 2020, N'<p>&ldquo;999 l&aacute; thư gửi cho ch&iacute;nh m&igrave;nh&rdquo; l&agrave; một t&aacute;c phẩm đặc biệt đầy cảm hứng đến từ t&aacute;c giả văn học mạng nổi tiếng Mi&ecirc;u C&ocirc;ng Tử, mang một m&agrave;u sắc ri&ecirc;ng biệt qua những lời thư nhỏ nhắn nhủ đến người đọc về gi&aacute; trị cuộc sống, t&igrave;nh y&ecirc;u, tuổi trẻ, tương lai&hellip; v.v.. đ&atilde; l&agrave;m lay động tr&aacute;i tim của h&agrave;ng vạn độc giả trẻ. Cầm tr&ecirc;n tay cuốn s&aacute;ch &ldquo;999 l&aacute; thư gửi cho ch&iacute;nh m&igrave;nh&rdquo; &ndash; bạn sẽ hiểu rằng: tuổi trẻ của ch&uacute;ng ta d&ugrave; c&oacute; mong manh đến đ&acirc;u th&igrave; cũng sẽ th&agrave;nh c&ocirc;ng vượt qua mọi kh&oacute; khăn một c&aacute;ch mạnh mẽ ngo&agrave;i sức tưởng tượng. Một ng&agrave;y n&agrave;o đ&oacute;, bạn sẽ cảm nhận được hạnh ph&uacute;c, tự tin của ch&iacute;nh bản th&acirc;n v&agrave; học được c&aacute;ch mỉm cười trước những nỗi đau của qu&aacute; khứ. Bạn sẽ biết c&aacute;ch n&oacute;i lời cảm ơn với những ai đ&atilde; rời bỏ bạn, hiểu ra rằng họ kh&ocirc;ng phải người th&iacute;ch hợp để c&ugrave;ng đồng h&agrave;nh với bạn tr&ecirc;n đoạn đường ch&ocirc;ng gai đi tới tương lai. Đ&ocirc;i l&uacute;c bạn c&oacute; thể yếu đuối mỏi mệt rơi nước mắt, thế nhưng khi bất chợt nh&igrave;n lại, bạn sẽ thấy th&igrave; ra m&igrave;nh đ&atilde; rất mạnh mẽ, dũng cảm đi hết cả một qu&atilde;ng đường d&agrave;i.</p>

<p>&ldquo;999 l&aacute; thư gửi cho ch&iacute;nh m&igrave;nh&rdquo; &ndash; Mong bạn trở th&agrave;nh phi&ecirc;n bản ho&agrave;n hảo nhất. C&aacute;i gọi l&agrave; vẻ đẹp nội t&acirc;m lu&ocirc;n lu&ocirc;n tốt hơn vẻ bề ngo&agrave;i h&agrave;o nho&aacute;ng, hy vọng bạn sẽ m&atilde;i lu&ocirc;n ki&ecirc;n cường, dũng cảm đứng ở nơi &aacute;nh s&aacute;ng chiếu rọi, sống tốt một cuộc sống m&agrave; m&igrave;nh hằng mong ước.</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (21, N'Luyện Thi Vào Lớp 10 - Môn Ngữ Văn - Chuyên Đề Nghị Luận Xã Hội', N'luyen-thi-vao-lop-10-mon-ngu-van-chuyen-de-nghi-luan-xa-hoi', N'/Upload/images/luyen-thi-vao-lop-10-mon-ngu-van-chuyen-de-nghi-luan-xa-hoi.jpg', N'Nguyễn Thành Huân', 7, 7, 30, 276, N'19 x 26', N'500', 2018, N'<p><strong>Luyện thi v&agrave;o lớp 10 m&ocirc;n Ngữ văn - Chuy&ecirc;n đề Nghị luận x&atilde; hội</strong></p>

<p>C&aacute;c em học sinh th&acirc;n mến!<br />
Trước ngưỡng cửa bước v&agrave;o cấp ba, hẳn c&aacute;c em đang rất băn khoăn, lo lắng kh&ocirc;ng biết n&ecirc;n &ocirc;n luyện v&agrave; t&iacute;ch lũy những kiến thức, kĩ năng thiết yếu n&agrave;o để c&oacute; thể ho&agrave;n th&agrave;nh tốt y&ecirc;u cầu kiểm tra, đ&aacute;nh gi&aacute; m&ocirc;n&nbsp;Ngữ văn.</p>

<p>Nhằm gi&uacute;p c&aacute;c em tự trang bị những kiến thức, kĩ năng quan trọng, đồng thời c&oacute; định hướng đ&uacute;ng v&agrave; biết vận dụng tốt v&agrave;o qu&aacute; tr&igrave;nh luyện b&uacute;t cho ch&iacute;nh m&igrave;nh, hướng tới n&acirc;ng cao chất lượng viết văn trong học tập, thi cử v&agrave; ho&agrave;n th&agrave;nh tốt b&agrave;i thi v&agrave;o lớp 10, ch&uacute;ng t&ocirc;i bi&ecirc;n soạn cuốn s&aacute;ch&nbsp;Luyện thi v&agrave;o lớp 10 m&ocirc;n Ngữ văn&nbsp;&ndash;&nbsp;Chuy&ecirc;n đề Nghị luận x&atilde; hội&nbsp;n&agrave;y.<br />
Cuốn s&aacute;ch gồm ba phần cơ bản:<br />
Phần 1.&nbsp;Kiến thức v&agrave; kĩ năng l&agrave;m b&agrave;i Nghị luận x&atilde; hội<br />
Phần 2.&nbsp;Sơ đồ tư duy v&agrave; d&agrave;n &yacute; chi tiết 40 đề b&agrave;i nghị luận x&atilde; hội<br />
Phần 3.&nbsp;Tuyển chọn những b&agrave;i văn nghị luận x&atilde; hội đặc sắc<br />
Với nội dung phong ph&uacute;, đa dạng, hi vọng cuốn s&aacute;ch sẽ l&agrave; nguồn t&agrave;i liệu bổ &iacute;ch, gi&uacute;p c&aacute;c em tự học, tự &ocirc;n luyện để học m&ocirc;n Ngữ văn tốt hơn. Ngo&agrave;i ra, điểm đặc biệt của cuốn s&aacute;ch l&agrave; định hướng cho c&aacute;c em c&aacute;ch viết v&agrave; sử dụng c&aacute;c b&agrave;i văn mẫu một c&aacute;ch hiệu quả. V&igrave; vậy, đối với những b&agrave;i văn trong t&agrave;i liệu n&agrave;y, c&aacute;c em n&ecirc;n tham khảo để t&iacute;ch lũy kinh nghiệm, học hỏi c&aacute;ch viết, từ đ&oacute; kết hợp với năng lực s&aacute;ng tạo của bản th&acirc;n để r&egrave;n luyện sao cho ng&agrave;y c&agrave;ng viết đ&uacute;ng, viết hay.<br />
Hi vọng cuốn s&aacute;ch sẽ l&agrave; một người bạn đồng h&agrave;nh c&ugrave;ng c&aacute;c em học sinh lớp 9, gi&uacute;p c&aacute;c em &ocirc;n luyện thật tốt m&ocirc;n Ngữ văn, vượt qua k&igrave; thi v&agrave;o lớp 10 đạt kết quả cao.<br />
Ch&uacute;c c&aacute;c em c&oacute; nhiều ho&agrave;i b&atilde;o, kh&aacute;t vọng, học tập v&agrave; r&egrave;n luyện tốt, đạt được nhiều th&agrave;nh t&iacute;ch tr&ecirc;n con đường học tập h&ocirc;m nay v&agrave; ng&agrave;y mai.<br />
Trong qu&aacute; tr&igrave;nh bi&ecirc;n soạn, ch&uacute;ng t&ocirc;i c&oacute; tham khảo v&agrave; tr&iacute;ch dẫn một số t&aacute;c phẩm, b&agrave;i viết của c&aacute;c nh&agrave; văn, nh&agrave; thơ, c&aacute;c nh&agrave; ph&ecirc; b&igrave;nh v&agrave; một số tư liệu của thầy c&ocirc; gi&aacute;o,<br />
Mặc d&ugrave; đ&atilde; rất cố gắng trong qu&aacute; tr&igrave;nh bi&ecirc;n soạn, nhưng cuốn s&aacute;ch chắc chắn vẫn<br />
kh&ocirc;ng tr&aacute;nh khỏi thiếu s&oacute;t, t&ocirc;i mong nhận được những g&oacute;p &yacute; ch&acirc;n th&agrave;nh từ qu&yacute; bạn đọc<br />
để cuốn s&aacute;ch ng&agrave;y một ho&agrave;n thiện hơn.<br />
Xin tr&acirc;n trọng cảm ơn!</p>
', 1)
INSERT [dbo].[Book] ([Id], [Title], [MetaTitle], [Image], [Authors], [CategoryId], [PublisherId], [Quantity], [PageNumber], [Size], [Weight], [PublishYear], [Description], [Status]) VALUES (22, N'Cambridge Ielts 15 Academic With Answers (Savina)', N'cambridge-ielts-15-academic-with-answers-savina', N'/Upload/images/cambridge-ielts-15-academic-with-answers.png', N'Cambridge', 8, 10, 35, 142, N'24 x 18.5', N'150', 2020, N'<p>Cambridge IELTS 15 ACADEMIC&nbsp;&ndash; Cuốn s&aacute;ch thứ 15&nbsp;trong bộ s&aacute;ch huyền thoại<br />
Cambridge IELTS từ nh&agrave; xuất bản&nbsp;Cambridge, với 2 phi&ecirc;n bản Academic v&agrave; General Training đ&atilde; ch&iacute;nh thức l&ecirc;n kệ tại C&ocirc;ng ty Cổ phần S&aacute;ch Việt Nam. Với đầy đủ 4 kỹ năng listening, reading, writing, speaking c&ugrave;ng với answer keys, Cambridge IELTS 14 sẽ cung cấp những kiến thức đầy đủ từ cấu tr&uacute;c b&agrave;i thi, c&aacute;c modul cần thiết, b&agrave;i mẫu hay c&aacute;c kĩ năng cần thiết gi&uacute;p bạn c&oacute; thể sẵn s&agrave;ng bước v&agrave;o k&igrave; thi IELTS với những trải nghiệm tốt nhất, s&aacute;t với thực tế nhất.</p>
', 1)
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
SET IDENTITY_INSERT [dbo].[Borrow] ON 

INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (5, N'1724801030068', N'NV001     ', 3, CAST(N'2021-01-07T00:00:00.000' AS DateTime), CAST(N'2021-01-14T00:00:00.000' AS DateTime), CAST(N'2021-01-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (6, N'1724801030068', N'NV001     ', 3, CAST(N'2021-01-08T00:00:00.000' AS DateTime), CAST(N'2021-01-15T00:00:00.000' AS DateTime), CAST(N'2021-01-08T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (9, N'1724801030001', N'NV001     ', 5, CAST(N'2021-01-13T00:00:00.000' AS DateTime), CAST(N'2021-01-20T00:00:00.000' AS DateTime), CAST(N'2021-01-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (10, N'1724801030070', N'NV001     ', 5, CAST(N'2021-01-13T00:00:00.000' AS DateTime), CAST(N'2021-01-20T00:00:00.000' AS DateTime), CAST(N'2021-01-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (11, N'1724801030126', N'NV001     ', 6, CAST(N'2021-01-16T00:00:00.000' AS DateTime), CAST(N'2021-01-23T00:00:00.000' AS DateTime), CAST(N'2021-01-16T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (12, N'1724801030070', N'NV001     ', 6, CAST(N'2021-01-18T00:00:00.000' AS DateTime), CAST(N'2021-01-25T00:00:00.000' AS DateTime), CAST(N'2021-01-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (13, N'1724801030057', N'NV001     ', 7, CAST(N'2021-01-18T00:00:00.000' AS DateTime), CAST(N'2021-01-25T00:00:00.000' AS DateTime), CAST(N'2021-01-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (14, N'1724801030066', N'NV001     ', 7, CAST(N'2021-01-19T00:00:00.000' AS DateTime), CAST(N'2021-01-26T00:00:00.000' AS DateTime), CAST(N'2021-01-19T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (15, N'1724801030056', N'NV001     ', 8, CAST(N'2021-01-21T00:00:00.000' AS DateTime), CAST(N'2021-01-28T00:00:00.000' AS DateTime), CAST(N'2021-01-21T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (16, N'1724801030069', N'NV001     ', 8, CAST(N'2021-01-25T00:00:00.000' AS DateTime), CAST(N'2021-02-01T00:00:00.000' AS DateTime), CAST(N'2021-01-25T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (17, N'1724801030055', N'NV001     ', 9, CAST(N'2021-01-26T00:00:00.000' AS DateTime), CAST(N'2021-02-02T00:00:00.000' AS DateTime), CAST(N'2021-01-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (18, N'1724801030126', N'NV001     ', 9, CAST(N'2021-01-26T00:00:00.000' AS DateTime), CAST(N'2021-02-02T00:00:00.000' AS DateTime), CAST(N'2021-01-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (19, N'1724801030070', N'NV001     ', 10, CAST(N'2021-01-28T00:00:00.000' AS DateTime), CAST(N'2021-02-04T00:00:00.000' AS DateTime), CAST(N'2021-01-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (20, N'1724801030055', N'NV001     ', 10, CAST(N'2021-01-30T00:00:00.000' AS DateTime), CAST(N'2021-02-06T00:00:00.000' AS DateTime), CAST(N'2021-01-30T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (21, N'1724801030057', N'NV001     ', 12, CAST(N'2021-02-01T00:00:00.000' AS DateTime), CAST(N'2021-02-08T00:00:00.000' AS DateTime), CAST(N'2021-02-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (22, N'1724801030055', N'NV001     ', 12, CAST(N'2021-02-02T00:00:00.000' AS DateTime), CAST(N'2021-02-09T00:00:00.000' AS DateTime), CAST(N'2021-02-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (23, N'1724801030126', N'NV001     ', 13, CAST(N'2021-02-05T00:00:00.000' AS DateTime), CAST(N'2021-02-12T00:00:00.000' AS DateTime), CAST(N'2021-02-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (24, N'1724801030057', N'NV001     ', 13, CAST(N'2021-02-05T00:00:00.000' AS DateTime), CAST(N'2021-02-12T00:00:00.000' AS DateTime), CAST(N'2021-02-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (25, N'1724801030126', N'NV001     ', 14, CAST(N'2021-02-07T00:00:00.000' AS DateTime), CAST(N'2021-02-14T00:00:00.000' AS DateTime), CAST(N'2021-02-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (26, N'1724801030059', N'NV001     ', 14, CAST(N'2021-02-09T00:00:00.000' AS DateTime), CAST(N'2021-02-16T00:00:00.000' AS DateTime), CAST(N'2021-02-09T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (31, N'1724801030065', N'NV001     ', 3, CAST(N'2021-02-18T00:00:00.000' AS DateTime), CAST(N'2021-02-25T00:00:00.000' AS DateTime), CAST(N'2021-02-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (32, N'1724801030068', N'NV001     ', 3, CAST(N'2021-02-21T00:00:00.000' AS DateTime), CAST(N'2021-02-28T00:00:00.000' AS DateTime), CAST(N'2021-02-21T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (35, N'1724801030126', N'NV001     ', 5, CAST(N'2021-02-28T00:00:00.000' AS DateTime), CAST(N'2021-03-07T00:00:00.000' AS DateTime), CAST(N'2021-02-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (36, N'1724801030070', N'NV001     ', 5, CAST(N'2021-03-02T00:00:00.000' AS DateTime), CAST(N'2021-03-09T00:00:00.000' AS DateTime), CAST(N'2021-03-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (37, N'1724801030057', N'NV001     ', 6, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(N'2021-03-12T00:00:00.000' AS DateTime), CAST(N'2021-03-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (38, N'1724801030126', N'NV001     ', 6, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(N'2021-03-12T00:00:00.000' AS DateTime), CAST(N'2021-03-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (39, N'1724801030059', N'NV001     ', 7, CAST(N'2021-03-07T00:00:00.000' AS DateTime), CAST(N'2021-03-14T00:00:00.000' AS DateTime), CAST(N'2021-03-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (40, N'1724801030057', N'NV001     ', 7, CAST(N'2021-03-07T00:00:00.000' AS DateTime), CAST(N'2021-03-14T00:00:00.000' AS DateTime), CAST(N'2021-03-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (41, N'1724801030068', N'NV001     ', 8, CAST(N'2021-03-08T00:00:00.000' AS DateTime), CAST(N'2021-03-15T00:00:00.000' AS DateTime), CAST(N'2021-03-08T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (42, N'1724801030055', N'NV001     ', 8, CAST(N'2021-03-10T00:00:00.000' AS DateTime), CAST(N'2021-03-17T00:00:00.000' AS DateTime), CAST(N'2021-03-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (43, N'1724801030069', N'NV001     ', 9, CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(N'2021-03-20T00:00:00.000' AS DateTime), CAST(N'2021-03-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (44, N'1724801030063', N'NV001     ', 9, CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(N'2021-03-20T00:00:00.000' AS DateTime), CAST(N'2021-03-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (45, N'1724801030068', N'NV001     ', 10, CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(N'2021-03-20T00:00:00.000' AS DateTime), CAST(N'2021-03-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (46, N'1724801030055', N'NV001     ', 10, CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(N'2021-03-23T00:00:00.000' AS DateTime), CAST(N'2021-03-16T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (47, N'1724801030070', N'NV001     ', 12, CAST(N'2021-03-18T00:00:00.000' AS DateTime), CAST(N'2021-03-25T00:00:00.000' AS DateTime), CAST(N'2021-03-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (48, N'1724801030071', N'NV001     ', 12, CAST(N'2021-03-18T00:00:00.000' AS DateTime), CAST(N'2021-03-25T00:00:00.000' AS DateTime), CAST(N'2021-03-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (49, N'1724801030066', N'NV001     ', 13, CAST(N'2021-03-19T00:00:00.000' AS DateTime), CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(N'2021-03-19T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (50, N'1724801030055', N'NV001     ', 13, CAST(N'2021-03-21T00:00:00.000' AS DateTime), CAST(N'2021-03-28T00:00:00.000' AS DateTime), CAST(N'2021-03-21T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (51, N'1724801030069', N'NV001     ', 14, CAST(N'2021-03-25T00:00:00.000' AS DateTime), CAST(N'2021-04-01T00:00:00.000' AS DateTime), CAST(N'2021-03-25T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (52, N'1724801030059', N'NV001     ', 14, CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(N'2021-04-02T00:00:00.000' AS DateTime), CAST(N'2021-03-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (53, N'1724801030059', N'NV001     ', 15, CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(N'2021-04-02T00:00:00.000' AS DateTime), CAST(N'2021-03-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (54, N'1724801030065', N'NV001     ', 15, CAST(N'2021-03-28T00:00:00.000' AS DateTime), CAST(N'2021-04-04T00:00:00.000' AS DateTime), CAST(N'2021-03-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (57, N'1724801030056', N'NV001     ', 17, CAST(N'2021-04-02T00:00:00.000' AS DateTime), CAST(N'2021-04-09T00:00:00.000' AS DateTime), CAST(N'2021-04-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (58, N'1724801030057', N'NV001     ', 17, CAST(N'2021-04-02T00:00:00.000' AS DateTime), CAST(N'2021-04-09T00:00:00.000' AS DateTime), CAST(N'2021-04-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (59, N'1724801030001', N'NV001     ', 18, CAST(N'2021-04-04T00:00:00.000' AS DateTime), CAST(N'2021-04-11T00:00:00.000' AS DateTime), CAST(N'2021-04-04T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (60, N'1724801030071', N'NV001     ', 18, CAST(N'2021-04-06T00:00:00.000' AS DateTime), CAST(N'2021-04-13T00:00:00.000' AS DateTime), CAST(N'2021-04-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (61, N'1724801030059', N'NV001     ', 19, CAST(N'2021-04-06T00:00:00.000' AS DateTime), CAST(N'2021-04-13T00:00:00.000' AS DateTime), CAST(N'2021-04-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (62, N'1724801030055', N'NV001     ', 19, CAST(N'2021-04-06T00:00:00.000' AS DateTime), CAST(N'2021-04-13T00:00:00.000' AS DateTime), CAST(N'2021-04-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (65, N'1724801030055', N'NV001     ', 21, CAST(N'2021-04-09T00:00:00.000' AS DateTime), CAST(N'2021-04-16T00:00:00.000' AS DateTime), CAST(N'2021-04-09T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (66, N'1724801030065', N'NV001     ', 21, CAST(N'2021-04-11T00:00:00.000' AS DateTime), CAST(N'2021-04-18T00:00:00.000' AS DateTime), CAST(N'2021-04-11T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (67, N'1724801030066', N'NV001     ', 22, CAST(N'2021-04-13T00:00:00.000' AS DateTime), CAST(N'2021-04-20T00:00:00.000' AS DateTime), CAST(N'2021-04-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (68, N'1724801030065', N'NV001     ', 22, CAST(N'2021-04-13T00:00:00.000' AS DateTime), CAST(N'2021-04-20T00:00:00.000' AS DateTime), CAST(N'2021-04-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (73, N'1724801030057', N'NV001     ', 3, CAST(N'2021-04-17T00:00:00.000' AS DateTime), CAST(N'2021-04-24T00:00:00.000' AS DateTime), CAST(N'2021-04-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (74, N'1724801030071', N'NV001     ', 3, CAST(N'2021-04-19T00:00:00.000' AS DateTime), CAST(N'2021-04-26T00:00:00.000' AS DateTime), CAST(N'2021-04-19T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (77, N'1724801030059', N'NV001     ', 5, CAST(N'2021-04-21T00:00:00.000' AS DateTime), CAST(N'2021-04-28T00:00:00.000' AS DateTime), CAST(N'2021-04-21T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (78, N'1724801030069', N'NV001     ', 5, CAST(N'2021-04-23T00:00:00.000' AS DateTime), CAST(N'2021-04-30T00:00:00.000' AS DateTime), CAST(N'2021-04-23T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (79, N'1724801030055', N'NV001     ', 6, CAST(N'2021-04-23T00:00:00.000' AS DateTime), CAST(N'2021-04-30T00:00:00.000' AS DateTime), CAST(N'2021-04-23T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (80, N'1724801030001', N'NV001     ', 6, CAST(N'2021-04-24T00:00:00.000' AS DateTime), CAST(N'2021-05-01T00:00:00.000' AS DateTime), CAST(N'2021-04-24T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (81, N'1724801030056', N'NV001     ', 7, CAST(N'2021-04-26T00:00:00.000' AS DateTime), CAST(N'2021-05-03T00:00:00.000' AS DateTime), CAST(N'2021-04-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (82, N'1724801030057', N'NV001     ', 7, CAST(N'2021-04-28T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-04-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (83, N'1724801030055', N'NV001     ', 8, CAST(N'2021-04-28T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-04-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (84, N'1724801030055', N'NV001     ', 8, CAST(N'2021-04-28T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-04-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (85, N'1724801030071', N'NV001     ', 9, CAST(N'2021-04-29T00:00:00.000' AS DateTime), CAST(N'2021-05-06T00:00:00.000' AS DateTime), CAST(N'2021-04-29T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (86, N'1724801030126', N'NV001     ', 9, CAST(N'2021-05-01T00:00:00.000' AS DateTime), CAST(N'2021-05-08T00:00:00.000' AS DateTime), CAST(N'2021-05-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (87, N'1724801030071', N'NV001     ', 10, CAST(N'2021-05-02T00:00:00.000' AS DateTime), CAST(N'2021-05-09T00:00:00.000' AS DateTime), CAST(N'2021-05-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (88, N'1724801030055', N'NV001     ', 10, CAST(N'2021-05-02T00:00:00.000' AS DateTime), CAST(N'2021-05-09T00:00:00.000' AS DateTime), CAST(N'2021-05-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (89, N'1724801030126', N'NV001     ', 12, CAST(N'2021-05-04T00:00:00.000' AS DateTime), CAST(N'2021-05-11T00:00:00.000' AS DateTime), CAST(N'2021-05-04T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (90, N'1724801030126', N'NV001     ', 12, CAST(N'2021-05-06T00:00:00.000' AS DateTime), CAST(N'2021-05-13T00:00:00.000' AS DateTime), CAST(N'2021-05-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (91, N'1724801030063', N'NV001     ', 13, CAST(N'2021-05-06T00:00:00.000' AS DateTime), CAST(N'2021-05-13T00:00:00.000' AS DateTime), CAST(N'2021-05-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (92, N'1724801030055', N'NV001     ', 14, CAST(N'2021-05-06T00:00:00.000' AS DateTime), CAST(N'2021-05-07T00:00:00.000' AS DateTime), NULL, -1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (93, N'1724801030069', N'NV001     ', 15, CAST(N'2021-05-07T00:00:00.000' AS DateTime), CAST(N'2021-05-14T00:00:00.000' AS DateTime), CAST(N'2021-05-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (95, N'1724801030001', N'NV001     ', 17, CAST(N'2021-05-08T00:00:00.000' AS DateTime), CAST(N'2021-05-15T00:00:00.000' AS DateTime), CAST(N'2021-05-08T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (96, N'1724801030059', N'NV001     ', 18, CAST(N'2021-05-09T00:00:00.000' AS DateTime), CAST(N'2021-05-16T00:00:00.000' AS DateTime), CAST(N'2021-05-09T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (97, N'1724801030126', N'NV001     ', 19, CAST(N'2021-05-11T00:00:00.000' AS DateTime), CAST(N'2021-05-18T00:00:00.000' AS DateTime), CAST(N'2021-05-11T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (99, N'1724801030001', N'NV001     ', 21, CAST(N'2021-05-13T00:00:00.000' AS DateTime), CAST(N'2021-05-20T00:00:00.000' AS DateTime), CAST(N'2021-05-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([Id], [StudentId], [StaffId], [BookId], [BorrowDate], [ReturnDeadline], [ReturnDate], [Status]) VALUES (100, N'1724801030055', N'NV001     ', 22, CAST(N'2021-05-14T00:00:00.000' AS DateTime), CAST(N'2021-05-21T00:00:00.000' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[Borrow] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name], [MetaTitle], [Image]) VALUES (1, N'Kinh tế', N'kinh-te', N'/Upload/images/rich-habits-poor-habits-su-khac-biet-giua-nguoi-giau-va-nguoi-ngheo.png')
INSERT [dbo].[Category] ([Id], [Name], [MetaTitle], [Image]) VALUES (2, N'Tâm lý - kỹ năng sống', N'tam-ly-ky-nang-song', N'/Upload/images/muon-kiep-nhan-sinh.png')
INSERT [dbo].[Category] ([Id], [Name], [MetaTitle], [Image]) VALUES (3, N'Văn học', N'van-hoc', N'/Upload/images/toi-thay-hoa-vang-tren-co-xanh.jpg')
INSERT [dbo].[Category] ([Id], [Name], [MetaTitle], [Image]) VALUES (5, N'Thiếu nhi', N'thieu-nhi', N'/Upload/images/lop-hoc-mat-ngu-tap-13.jpg')
INSERT [dbo].[Category] ([Id], [Name], [MetaTitle], [Image]) VALUES (6, N'Tiểu sử hồi ký', N'tieu-su-hoi-ky', N'/Upload/images/cr7-hanh-trinh-len-dinh-the-gioi.jpg')
INSERT [dbo].[Category] ([Id], [Name], [MetaTitle], [Image]) VALUES (7, N'Giáo khoa - tham khảo', N'giao-khoa-tham-khao', N'/Upload/images/luyen-thi-vao-lop-10-mon-ngu-van-chuyen-de-nghi-luan-xa-hoi.jpg')
INSERT [dbo].[Category] ([Id], [Name], [MetaTitle], [Image]) VALUES (8, N'Ngoại ngữ', N'ngoai-ngu', N'/Upload/images/cambridge-ielts-15-academic-with-answers.png')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([Id], [Name], [Phone], [Email], [Content], [Status]) VALUES (1, N'Trần Văn Hùng', N'0385968197', N'vhungitm@gmail.com', N'Tuyệt vời', 1)
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[Import] ON 

INSERT [dbo].[Import] ([Id], [StaffId], [CreatedDate], [Quantity], [TotalPrice]) VALUES (1, N'NV001     ', CAST(N'2021-05-13T18:23:25.720' AS DateTime), 200, CAST(20000000 AS Decimal(18, 0)))
INSERT [dbo].[Import] ([Id], [StaffId], [CreatedDate], [Quantity], [TotalPrice]) VALUES (2, N'NV001     ', CAST(N'2021-05-13T18:28:29.247' AS DateTime), 150, CAST(16500000 AS Decimal(18, 0)))
INSERT [dbo].[Import] ([Id], [StaffId], [CreatedDate], [Quantity], [TotalPrice]) VALUES (3, N'NV001     ', CAST(N'2021-05-13T18:30:19.997' AS DateTime), 175, CAST(19600000 AS Decimal(18, 0)))
INSERT [dbo].[Import] ([Id], [StaffId], [CreatedDate], [Quantity], [TotalPrice]) VALUES (4, N'NV001     ', CAST(N'2021-05-13T18:32:10.903' AS DateTime), 200, CAST(20000000 AS Decimal(18, 0)))
INSERT [dbo].[Import] ([Id], [StaffId], [CreatedDate], [Quantity], [TotalPrice]) VALUES (5, N'NV001     ', CAST(N'2021-05-13T18:33:29.900' AS DateTime), 65, CAST(6500000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Import] OFF
GO
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (1, 1, 40, CAST(100000 AS Decimal(18, 0)), CAST(4000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (1, 2, 40, CAST(100000 AS Decimal(18, 0)), CAST(4000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (1, 3, 40, CAST(100000 AS Decimal(18, 0)), CAST(4000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (1, 4, 40, CAST(100000 AS Decimal(18, 0)), CAST(4000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (1, 5, 40, CAST(100000 AS Decimal(18, 0)), CAST(4000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (2, 6, 30, CAST(110000 AS Decimal(18, 0)), CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (2, 7, 30, CAST(110000 AS Decimal(18, 0)), CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (2, 8, 30, CAST(110000 AS Decimal(18, 0)), CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (2, 9, 30, CAST(110000 AS Decimal(18, 0)), CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (2, 10, 30, CAST(110000 AS Decimal(18, 0)), CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (3, 11, 35, CAST(112000 AS Decimal(18, 0)), CAST(3920000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (3, 12, 35, CAST(112000 AS Decimal(18, 0)), CAST(3920000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (3, 13, 35, CAST(112000 AS Decimal(18, 0)), CAST(3920000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (3, 14, 35, CAST(112000 AS Decimal(18, 0)), CAST(3920000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (3, 15, 35, CAST(112000 AS Decimal(18, 0)), CAST(3920000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (4, 17, 50, CAST(100000 AS Decimal(18, 0)), CAST(5000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (4, 18, 50, CAST(100000 AS Decimal(18, 0)), CAST(5000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (4, 19, 50, CAST(100000 AS Decimal(18, 0)), CAST(5000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (4, 20, 50, CAST(100000 AS Decimal(18, 0)), CAST(5000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (5, 21, 30, CAST(100000 AS Decimal(18, 0)), CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[ImportDetail] ([ImportId], [BookId], [Quantity], [Price], [TotalPrice]) VALUES (5, 22, 35, CAST(100000 AS Decimal(18, 0)), CAST(3500000 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[Publisher] ON 

INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (1, N'Thanh Niên', N'thanh-nien', N'Quận 1, Hồ Chí Minh', N'0283.930.5243', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (2, N'Phụ Nữ', N'phu-nu', N'Quận Hai Bà Trưng, Hà Nội', N'0243.971.0717', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (3, N'Hồng Đức', N'hong-duc', N'Tràng Thi, Hà Nội', N'0243.926.0024', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (4, N'Công Thương', N'cong-thuong', N'Bắc Từ Liêm, Hà Nội', N'8439.341.562', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (5, N'Văn Hóa - Văn Nghệ', N'van-hoa-van-nghe', N'Quận 7, Hồ Chí Minh', N'02568.956.123', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (6, N'Trẻ', N'tre', N'Quận 3, TP.HCM', N'0283.8437.450', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (7, N'Hội Nhà Văn', N'hoi-nha-van', N'Quận Hai Bà Trưng, thành phố Hà Nội', N'0243.8222.135', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (8, N'Tổng hợp TP.HCM', N'tong-hop-tphcm', N'Quận 1, TP.HCM', N'0283.8256.713', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (9, N'Kim Đồng', N'kim-dong', N'55 Quang Trung, Hà Nội', N'0243.943.4730', N'')
INSERT [dbo].[Publisher] ([Id], [Name], [MetaTitle], [Address], [Phone], [Email]) VALUES (10, N'Hà Nội', N'ha-noi', N'Hoàn Kiếm, Hà Nội', N'024.38252916', N'')
SET IDENTITY_INSERT [dbo].[Publisher] OFF
GO
INSERT [dbo].[Staff] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Status]) VALUES (N'NV001     ', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Lê Thị Nguyên', N'Nam', CAST(N'1990-01-01' AS Date), N'Bình Dương', N'0365425896', N'lethihongnguyen@gmail.com', 1)
INSERT [dbo].[Staff] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Status]) VALUES (N'NV002     ', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Lê Thị Hồng Đào', N'Nam', CAST(N'1994-07-02' AS Date), N'Bình Dương', N'0365425896', N'lethihongnguyen@gmail.com', 1)
INSERT [dbo].[Staff] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Status]) VALUES (N'NV003     ', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Lê Thị Hương', N'Nữ', CAST(N'1990-01-01' AS Date), N'TDM, Bình Dương', N'0368953245', N'lethihuong@gmail.co', 1)
INSERT [dbo].[Staff] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Status]) VALUES (N'NV004     ', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Trịnh Ngọc Bảo', N'Nam', CAST(N'1990-01-01' AS Date), N'TDM, Bình Dương', N'0354628996', N'trinhngocbao@gmail.com', 1)
GO
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030001', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Phạm Thị Thu An', N'Nữ', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'0386965264', N'thuan1724801030001@gmail.com', N'D17PM01   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030055', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Trần Văn Hùng', N'Nam', CAST(N'1990-01-01' AS Date), N'Bình Dương', N'0385968197', N'vhungitm@gmail.com', N'D17PM01   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030056', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Trịnh Ngọc Hùng', N'Nam', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'039689645', N'trinhngochung@gmail.com', N'D17PM01   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030057', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Nguyễn Lê Huy', N'Nam', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'0396866954', N'nguyenlehuy@gmail.com', N'D17PM01   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030059', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Phạm Hoài Hưng', N'Nam', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'0386965426', N'phamhoaihung@gmail.com', N'D17PM01   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030063', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Nguyễn Minh Kha', N'Nam', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'0389665246', N'nguyenminhkha@gmail.com', N'D17PM02   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030065', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Trần Bảo Khôi', N'Nam', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'0385964164', N'tranbaokhoi@gmail.com', N'D17PM02   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030066', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Nguyễn Hoàng Khương', N'Nam', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'0345662896', N'nguyenhoangkhuong@gmail.com', N'D17PM02   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030068', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Trần Trung Lễ', N'Nam', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'0368965264', N'trantrungle@gmail.com', N'D17PM02   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030069', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Đỗ Thị Yến Linh', N'Nam', CAST(N'1999-01-01' AS Date), N'TDM, Bình Dương', N'036599462', N'dothiyenlinh@gmail.com', N'D17PM02   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030070', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Lê Văn Linh', N'Nam', CAST(N'1999-11-22' AS Date), N'TDM, Bình Dương', N'036956624', N'levanlinh@gmail.com', N'D17PM02   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030071', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Trịnh Tiến Linh', N'Nam', CAST(N'1990-01-01' AS Date), N'TDM, Bình Dương', N'0356896524', N'trinhtienlinh@gmail.com', N'D17PM02   ', 1)
INSERT [dbo].[Student] ([Id], [Password], [Avatar], [FullName], [Gender], [Birthday], [Address], [Phone], [Email], [Class], [Status]) VALUES (N'1724801030126', N'e10adc3949ba59abbe56e057f20f883e', N'/Upload/Images/no-avatar.png', N'Trương Văn Toàn', N'Nam', CAST(N'1998-11-21' AS Date), N'TDM, Bình Dương', N'0357646784', N'toansiro13@gmail.com', N'D17PM03   ', 1)
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [fk_Book_CategoryId_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [fk_Book_CategoryId_Category]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [fk_Book_PublisherId_Publisher] FOREIGN KEY([PublisherId])
REFERENCES [dbo].[Publisher] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [fk_Book_PublisherId_Publisher]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [fk_Borrow_BookId_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [fk_Borrow_BookId_Book]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [fk_Borrow_StaffId_Staff] FOREIGN KEY([StaffId])
REFERENCES [dbo].[Staff] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [fk_Borrow_StaffId_Staff]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [fk_Borrow_StudentId_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [fk_Borrow_StudentId_Student]
GO
ALTER TABLE [dbo].[Import]  WITH CHECK ADD  CONSTRAINT [fk_Import_StaffId_Staff] FOREIGN KEY([StaffId])
REFERENCES [dbo].[Staff] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Import] CHECK CONSTRAINT [fk_Import_StaffId_Staff]
GO
ALTER TABLE [dbo].[ImportDetail]  WITH CHECK ADD  CONSTRAINT [fk_ImportDetail_BookId_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImportDetail] CHECK CONSTRAINT [fk_ImportDetail_BookId_Book]
GO
ALTER TABLE [dbo].[ImportDetail]  WITH CHECK ADD  CONSTRAINT [fk_ImportDetail_ImportId_Import] FOREIGN KEY([ImportId])
REFERENCES [dbo].[Import] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImportDetail] CHECK CONSTRAINT [fk_ImportDetail_ImportId_Import]
GO
/****** Object:  StoredProcedure [dbo].[uspCountAuthor]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountAuthor]
	@Key nvarchar(50)
AS
BEGIN
	SELECT COUNT(Id)
	FROM
		Author
	WHERE
		Name LIKE '%' + @Key + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountBanner]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountBanner]
	@Status int
AS
BEGIN
	SELECT COUNT(Id)
	FROM Banner
	WHERE
		@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountBook]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountBook]
	@Key nvarchar(50),
	@Category varchar(60),
	@Publisher varchar(60),
	@PublishYear int,
	@Status int
AS
BEGIN
	SELECT
		COUNT(A.Id)
	FROM
		Book AS A,
		Category AS C,
		Publisher AS D
	WHERE
		A.CategoryId = C.Id AND
		A.PublisherId = D.Id AND
		A.Title LIKE '%' + @Key + '%' AND
		(
			@Category = (CASE WHEN @Category = '' THEN '' ELSE CONVERT(varchar, C.Id) END) OR
			@Category = (CASE WHEN @Category = '' THEN '' ELSE C.MetaTitle END)
		) AND (
			@Publisher = (CASE WHEN @Publisher = '' THEN '' ELSE CONVERT(varchar, D.Id) END) OR
			@Publisher = (CASE WHEN @Publisher = '' THEN '' ELSE D.MetaTitle END)
		) AND
		@PublishYear = (CASE WHEN @PublishYear = 0 THEN 0 ELSE A.PublishYear END) AND
		@Status = (CASE WHEN @Status = 2 THEN 2 ELSE A.Status END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountBorrow]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountBorrow]
	@Id bigint,
	@Student varchar(50),
	@Staff varchar(50),
	@Book varchar(110),
	@BorrowDate varchar(20),
	@ReturnDate varchar(20),
	@Status int
AS
BEGIN
	SELECT COUNT(A.Id)
	FROM
		Borrow A,
		Student B,
		Staff C,
		Book D,
		Category E
	WHERE
		A.StudentId = B.Id AND
		A.StaffId = C.Id AND
		A.BookId = D.Id AND
		D.CategoryId = E.Id AND
		@Id = (CASE WHEN @Id = 0 THEN 0 ELSE A.Id END) AND
		@Student = (CASE WHEN @Student = '' THEN '' ELSE A.StudentId END) AND
		@Staff = (CASE WHEN @Staff = '' THEN '' ELSE A.StaffId END) AND
		(
			@Book = (CASE WHEN @Book = '' THEN '' ELSE CONVERT(varchar, D.Id) END) OR
			@Book = (CASE WHEN @Book = '' THEN '' ELSE D.MetaTitle END)
		) AND
		@BorrowDate = (CASE WHEN @BorrowDate = '' THEN '' ELSE CONVERT(varchar, A.BorrowDate, 103) END) AND
		@ReturnDate = (CASE WHEN @ReturnDate = '' THEN '' ELSE CONVERT(varchar, A.ReturnDate, 103) END) AND
		@Status = (CASE WHEN @Status = 2 THEN 2 ELSE A.Status END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountCategory]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountCategory]
	@Key nvarchar(50)
AS
BEGIN
	SELECT COUNT(Id)
	FROM Category
	WHERE
		Name LIKE '%' + @Key + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountFeedback]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[uspCountFeedback]
	@Status int
AS
BEGIN
	SELECT COUNT(Id)
	FROM Feedback
	WHERE
		@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountImport]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountImport]
	@Id nvarchar(50),
	@StaffId varchar(50),
	@CreatedDate varchar(50)
AS
BEGIN
	SELECT
		COUNT(A.Id)
	FROM
		Import A,
		Staff B
	WHERE
		A.StaffId = B.Id AND
		@StaffId = (CASE WHEN @StaffId = '' THEN '' ELSE A.StaffId END) AND
		@CreatedDate = (CASE WHEN @CreatedDate = '' THEN '' ELSE CONVERT(varchar, A.CreatedDate, 103) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountImportDetail]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountImportDetail]
	@ImportId bigint,
	@Book varchar(110)
AS
BEGIN
	SELECT COUNT(A.BookId)
	FROM
		ImportDetail A,
		Book B
	WHERE
		A.BookId = B.Id AND
		A.ImportId = @ImportId AND
		(
			@Book = (CASE WHEN @Book = '' THEN '' ELSE CONVERT(varchar, B.Id) END) OR
			@Book = (CASE WHEN @Book = '' THEN '' ELSE B.MetaTitle END)
		)
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountPublisher]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountPublisher]
	@Key nvarchar(50)
AS
BEGIN
	SELECT
		COUNT(Id)
	FROM
		Publisher
	WHERE
		Name	LIKE ('%' + @Key + '%') OR
		Address	LIKE ('%' + @Key + '%') OR
		Phone	LIKE ('%' + @Key + '%') OR
		Email	LIKE ('%' + @Key + '%')
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountStaff]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountStaff]
	@Key nvarchar(50),
	@Status int
AS
BEGIN
	SELECT COUNT(Id)
	FROM
		Staff
	WHERE
		(
			Id LIKE '%' + @Key + '%' OR
			FullName LIKE '%' + @Key + '%'
		) AND
		@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspCountStudent]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCountStudent]
	@Key nvarchar(50),
	@Status int
AS
BEGIN
	SELECT COUNT(Id)
	FROM
		Student
	WHERE
		FullName LIKE '%' + @Key + '%' AND
		Id LIKE '%' + @Key + '%' AND
		@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteBanner]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteBanner]
	@Id bigint
AS
BEGIN
	BEGIN TRY
		DELETE FROM Banner
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteBook]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteBook]
	@Id bigint
AS
BEGIN
	BEGIN TRY
		DELETE FROM Book
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteBorrow]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteBorrow]
	@Id bigint
AS
BEGIN
	BEGIN TRY
		DELETE FROM Borrow
		WHERE Id = @Id
		
		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteCategory]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteCategory]
	@Id bigint
AS
BEGIN
	BEGIN TRY
		DELETE
		FROM Category
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteFeedback]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteFeedback]
	@Id bigint
AS
BEGIN TRAN
	BEGIN TRY
		DELETE FROM Feedback
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		ROLLBACK
		SELECT 0
	END CATCH
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteImport]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteImport]
	@Id bigint
AS
BEGIN
	BEGIN TRY
		DELETE FROM Import
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteImportDetail]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteImportDetail]
	@ImportId bigint,
	@BookId bigint
AS
BEGIN
	BEGIN TRY
		DELETE FROM ImportDetail
		WHERE ImportId = @ImportId AND BookId = @BookId

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeletePublisher]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeletePublisher]
	@Id bigint
AS
BEGIN
	BEGIN TRY
		DELETE Publisher
		WHERE Id = @Id
	
		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteStaff]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteStaff]
	@Id varchar(20)
AS
BEGIN
	BEGIN TRY
		DELETE FROM Staff
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteStudent]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspDeleteStudent]
	@Id varchar(20)
AS
BEGIN
	BEGIN TRY
		DELETE FROM Student
		WHERE Id = @ID
	
		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAuthor]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetAuthor]
	@Id bigint
AS
BEGIN
	SELECT *
	FROM Author
	WHERE
		Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAuthors]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetAuthors]
	@Key nvarchar(50),
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT
			ROW_NUMBER() OVER ( ORDER BY Id DESC) AS RowNum,
			*
		FROM
			Author
		WHERE
			Name LIKE '%' + @Key + '%'
	) AS data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetBanner]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetBanner]
	@Id bigint
AS
BEGIN
	SELECT * FROM Banner
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetBanners]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetBanners]
	@Status int,
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT
			ROW_NUMBER() OVER ( ORDER BY [Order] ) AS RowNum,
			*
		FROM Banner
		WHERE
			@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
	) AS data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetBook]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetBook]
	@Key varchar(110)
AS
BEGIN
	SELECT
		ROW_NUMBER() OVER ( ORDER BY A.Id DESC) AS RowNum,
		A.Id,
		A.Title,
		A.MetaTitle,
		A.Image,
		A.Authors,
		A.CategoryId,
		C.Name AS CategoryName,
		C.MetaTitle AS CategoryMetaTitle,
		A.PublisherId,
		D.Name AS PublisherName,
		D.MetaTitle AS PublisherMetaTitle,
		A.Quantity,
		A.PageNumber,
		A.Size,
		A.Weight,
		A.PublishYear,
		A.Description,
		A.Status
	FROM
		Book AS A,
		Category AS C,
		Publisher AS D
	WHERE
		A.CategoryId = C.Id AND
		A.PublisherId = D.Id AND
		(CONVERT(varchar, A.Id) = @Key OR A.MetaTitle = @Key)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetBookQuantityInStock]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetBookQuantityInStock]
	@Id bigint
AS
BEGIN
	DECLARE @BorrowingQuantity int = 0
	DECLARE @BookQuantity int = 0

	SELECT @BorrowingQuantity = COUNT(BookId)
	FROM Borrow
	WHERE BookId = @Id

	SELECT @BookQuantity = Quantity
	FROM Book
	WHERE Id = @Id

	SELECT (@BookQuantity - @BorrowingQuantity)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetBooks]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetBooks]
	@Key nvarchar(50),
	@Category varchar(60),
	@Publisher varchar(60),
	@PublishYear int,
	@Status int,
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM (
		SELECT
			ROW_NUMBER() OVER ( ORDER BY A.Id DESC) AS RowNum,
			A.Id,
			A.Title,
			A.MetaTitle,
			A.Authors,
			A.Image,
			A.CategoryId,
			C.Name AS CategoryName,
			C.MetaTitle AS CategoryMetaTitle,
			A.PublisherId,
			D.Name AS PublisherName,
			D.MetaTitle AS PublisherMetaTitle,
			A.Quantity,
			A.PageNumber,
			A.Size,
			A.Weight,
			A.PublishYear,
			A.Description,
			A.Status
		FROM
			Book AS A,
			Category AS C,
			Publisher AS D
		WHERE
			A.CategoryId = C.Id AND
			A.PublisherId = D.Id AND
			A.Title LIKE '%' + @Key + '%' AND
			(
				@Category = (CASE WHEN @Category = '' THEN '' ELSE CONVERT(varchar, C.Id) END) OR
				@Category = (CASE WHEN @Category = '' THEN '' ELSE C.MetaTitle END)
			) AND (
				@Publisher = (CASE WHEN @Publisher = '' THEN '' ELSE CONVERT(varchar, D.Id) END) OR
				@Publisher = (CASE WHEN @Publisher = '' THEN '' ELSE D.MetaTitle END)
			) AND
			@PublishYear = (CASE WHEN @PublishYear = 0 THEN 0 ELSE A.PublishYear END) AND
			@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
	) AS Data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetBorrow]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetBorrow]
	@Id bigint
AS
BEGIN
	SELECT
		A.Id,
		A.StudentId,
		B.FullName StudentName,
		A.StaffId,
		C.FullName StaffName,
		A.BookId,
		D.Title BookTitle,
		D.MetaTitle AS BookMetaTitle,
		D.Image BookImage,
		E.MetaTitle AS BookCategoryMetaTitle,
		CONVERT(varchar, BorrowDate, 103) BorrowDate,
		CONVERT(varchar, ReturnDeadline, 103) ReturnDeadline,
		CONVERT(varchar, ReturnDate, 103) ReturnDate,
		A.Status
	FROM
		Borrow A,
		Student B,
		Staff C,
		Book D,
		Category E
	WHERE
		A.StudentId = B.Id AND
		A.StaffId = C.Id AND
		A.BookId = D.Id AND
		D.CategoryId = E.Id AND
		@Id = (CASE WHEN @Id = 0 THEN 0 ELSE A.Id END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetBorrowQuantity]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetBorrowQuantity]
	@StartDate date,
	@EndDate date,
	@Type int
AS
BEGIN
	-- Type = 1 get by month --
	-- Type = 2 get by year --
	-- Type = 3 get custom --
	DECLARE @Quantity int = 0
	CREATE TABLE #QuantityTable( Quantity int )

	IF @Type = 2
	BEGIN
		DECLARE @Month int = 1

		WHILE @Month <= 12
		BEGIN
			SELECT @Quantity = COUNT(BookId)
			FROM Borrow
			WHERE
				MONTH(BorrowDate)	= @Month AND
				YEAR(BorrowDate)	= YEAR(@StartDate)

			INSERT INTO #QuantityTable VALUES (@Quantity)
			SET @Month = @Month + 1
		END

		SELECT * FROM #QuantityTable
	END
	ELSE
	BEGIN
		DECLARE @Day int = 1
		DECLARE @DayQuantity int = 0

		SELECT @DayQuantity = DAY(EOMONTH(@StartDate))

		WHILE @Day <= @DayQuantity
		BEGIN
			SET @Quantity = 0

			SELECT @Quantity = COUNT(BookId)
			FROM Borrow
			WHERE
				DAY(BorrowDate)		= @Day AND
				MONTH(BorrowDate)	= MONTH(@StartDate) AND
				YEAR(BorrowDate)	= YEAR(@StartDate)

			INSERT INTO #QuantityTable VALUES (@Quantity)
			SET @Day = @Day + 1
		END

		SELECT * FROM #QuantityTable
	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetBorrows]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetBorrows]
	@Id bigint,
	@Student varchar(50),
	@Staff varchar(50),
	@Book varchar(110),
	@BorrowDate varchar(50),
	@ReturnDate varchar(50),
	@Status int,
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM (
		SELECT
			ROW_NUMBER() OVER ( ORDER BY A.Id DESC) AS RowNum,
			A.Id,
			A.StudentId,
			B.FullName StudentName,
			A.StaffId,
			C.FullName StaffName,
			A.BookId,
			D.Title BookTitle,
			D.MetaTitle AS BookMetaTitle,
			D.Image BookImage,
			E.MetaTitle AS BookCategoryMetaTitle,
			CONVERT(varchar, BorrowDate, 103) BorrowDate,
			CONVERT(varchar, ReturnDeadline, 103) ReturnDeadline,
			CONVERT(varchar, ReturnDate, 103) ReturnDate,
			A.Status
		FROM
			Borrow A,
			Student B,
			Staff C,
			Book D,
			Category E
		WHERE
			A.StudentId = B.Id AND
			A.StaffId = C.Id AND
			A.BookId = D.Id AND
			D.CategoryId = E.Id AND
			@Id = (CASE WHEN @Id = 0 THEN 0 ELSE A.Id END) AND
			@Student = (CASE WHEN @Student = '' THEN '' ELSE A.StudentId END) AND
			@Staff = (CASE WHEN @Staff = '' THEN '' ELSE A.StaffId END) AND
			(
				@Book = (CASE WHEN @Book = '' THEN '' ELSE CONVERT(varchar, D.Id) END) OR
				@Book = (CASE WHEN @Book = '' THEN '' ELSE D.MetaTitle END)
			) AND
			@BorrowDate = (CASE WHEN @BorrowDate = '' THEN '' ELSE CONVERT(varchar, A.BorrowDate, 103) END) AND
			@ReturnDate = (CASE WHEN @ReturnDate = '' THEN '' ELSE CONVERT(varchar, A.ReturnDate, 103) END) AND
			@Status = (CASE WHEN @Status = 2 THEN 2 ELSE A.Status END)
			) AS Data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetCategories]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetCategories]
	@Key nvarchar(50),
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT
			ROW_NUMBER() OVER ( ORDER BY Id DESC) AS RowNum,
			*
		FROM Category
		WHERE
			Name LIKE '%' + @Key + '%'
	) AS data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetCategory]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetCategory]
	@Key varchar(60)
AS
BEGIN
	SELECT *
	FROM Category
	WHERE (CONVERT(varchar, Id) = @Key OR MetaTitle = @Key)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetFeedback]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[uspGetFeedback]
	@Id bigint
AS
BEGIN
	SELECT * FROM Feedback
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetFeedbacks]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetFeedbacks]
	@Status int,
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT
			ROW_NUMBER() OVER ( ORDER BY Id ) AS RowNum,
			*
		FROM Feedback
		WHERE
			@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
	) AS data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetImport]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetImport]
	@Id nvarchar(50)
AS
BEGIN
	SELECT
		A.Id,
		A.StaffId,
		B.FullName StaffName,
		A.CreatedDate,
		A.Quantity,
		A.TotalPrice
	FROM
		Import A,
		Staff B
	WHERE
		A.StaffId = B.Id AND
		A.Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetImportDetail]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetImportDetail]
	@ImportId bigint,
	@Book varchar(110)
AS
BEGIN
	SELECT
		A.ImportId,
		A.BookId,
		B.Title BookTitle,
		B.MetaTitle AS BookMetaTitle,
		A.Quantity,
		A.Price,
		A.TotalPrice
	FROM
		ImportDetail A,
		Book B
	WHERE
		A.BookId = B.Id AND
		A.ImportId = @ImportId AND
		(
			@Book = (CASE WHEN @Book = '' THEN '' ELSE CONVERT(varchar, B.Id) END) OR
			@Book = (CASE WHEN @Book = '' THEN '' ELSE B.MetaTitle END)
		)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetImportDetails]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetImportDetails]
	@ImportId bigint,
	@Book varchar(110),
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM (
		SELECT
			ROW_NUMBER() OVER ( ORDER BY A.BookId DESC) AS RowNum,
			A.ImportId,
			A.BookId,
			B.Title BookTitle,
			B.MetaTitle AS BookMetaTitle,
			A.Quantity,
			A.Price,
			A.TotalPrice
		FROM
			ImportDetail A,
			Book B
		WHERE
			A.BookId = B.Id AND
			A.ImportId = @ImportId AND
			(
				@Book = (CASE WHEN @Book = '' THEN '' ELSE CONVERT(varchar, B.Id) END) OR
				@Book = (CASE WHEN @Book = '' THEN '' ELSE B.MetaTitle END)
			)
			
		) AS Data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetImports]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetImports]
	@Id nvarchar(50),
	@StaffId varchar(50),
	@CreatedDate varchar(50),
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM (
		SELECT
			ROW_NUMBER() OVER ( ORDER BY A.Id DESC) AS RowNum,
			A.Id,
			A.StaffId,
			B.FullName StaffName,
			CONVERT(varchar, A.CreatedDate, 103) CreatedDate,
			A.Quantity,
			A.TotalPrice
		FROM
			Import A,
			Staff B
		WHERE
			A.StaffId = B.Id AND
			@Id = (CASE WHEN @Id = 0 THEN 0 ELSE A.Id END) AND
			@StaffId = (CASE WHEN @StaffId = '' THEN '' ELSE A.StaffId END) AND
			@CreatedDate = (CASE WHEN @CreatedDate = '' THEN '' ELSE CONVERT(varchar, A.CreatedDate, 103) END)
	) AS Data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPublisher]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetPublisher]
	@Key varchar(60)
AS
BEGIN
	SELECT *
	FROM Publisher
	WHERE (CONVERT(varchar, Id) = @Key OR MetaTitle = @Key)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPublishers]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetPublishers]
	@Key nvarchar(50),
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM (
		SELECT
			ROW_NUMBER() OVER ( ORDER BY Id DESC) AS RowNum,
			*
		FROM
			Publisher
		WHERE
			Name	LIKE ('%' + @Key + '%') OR
			Address	LIKE ('%' + @Key + '%') OR
			Phone	LIKE ('%' + @Key + '%') OR
			Email	LIKE ('%' + @Key + '%')
	) AS data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetStaff]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetStaff]
	@Id varchar(20)
AS
BEGIN
	SELECT
		Id,
		Password,
		Avatar,
		FullName,
		Gender,
		CONVERT(varchar, Birthday, 103) Birthday,
		Address,
		Phone,
		Email,
		Status
	FROM
		Staff
	WHERE
		Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetStaffs]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetStaffs]
	@Key nvarchar(50),
	@Status int,
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM (
		SELECT
			ROW_NUMBER() OVER ( ORDER BY Id DESC) AS RowNum,
			Id,
			Password,
			Avatar,
			FullName,
			Gender,
			CONVERT(varchar, Birthday, 103) Birthday,
			Address,
			Phone,
			Email,
			Status
		FROM
			Staff
		WHERE
			(
				Id LIKE '%' + @Key + '%' OR
				FullName LIKE '%' + @Key + '%'
			) AND
			@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
	) AS Data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetStudent]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetStudent]
	@Id varchar(20)
AS
BEGIN
	SELECT
		Id,
		Password,
		Avatar,
		FullName,
		Gender,
		CONVERT(varchar, Birthday, 103) Birthday,
		Address,
		Phone,
		Email,
		Class,
		Status
	FROM
		Student
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetStudents]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetStudents]
	@Key nvarchar(50),
	@Status int,
	@Page int,
	@PageSize int
AS
BEGIN
	SELECT *
	FROM (
		SELECT
			ROW_NUMBER() OVER ( ORDER BY Id DESC) AS RowNum,
			Id,
			Password,
			Avatar,
			FullName,
			Gender,
			CONVERT(varchar, Birthday, 103) Birthday,
			Address,
			Phone,
			Email,
			Class,
			Status
		FROM
			Student
		WHERE
			(
				FullName LIKE '%' + @Key + '%' OR
				Id LIKE '%' + @Key + '%'
			) AND
 			@Status = (CASE WHEN @Status = 2 THEN 2 ELSE Status END)
	) AS Data
	WHERE
		RowNum > ( CASE WHEN @Page > 0 THEN ((@Page - 1) * @PageSize) ELSE (RowNum - 1) END) AND
		RowNum <= ( CASE WHEN @Page > 0 THEN (@Page * @PageSize)  ELSE (RowNum + 1) END)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetTopBook]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetTopBook]
	@Top int,
	@StartDate date,
	@EndDate date,
	@Type int
AS
BEGIN
	IF @Type = 0
		SELECT TOP (@Top)
			B.Id, B.Title, B.Image, COUNT(B.Id) Quantity
		FROM
			Borrow A,
			Book B
		WHERE
			A.BookId = B.Id
 		GROUP BY
			B.Id, B.Title, B.Image
		ORDER BY
			COUNT(B.Id) DESC
	ELSE

		IF @Type = 1
		SELECT TOP (@Top)
				B.Id, B.Title, B.Image, COUNT(B.Id) Quantity
			FROM
				Borrow A,
				Book B
			WHERE
				A.BookId			= B.Id AND
				MONTH(@StartDate)	= MONTH(A.BorrowDate) AND
				YEAR(@StartDate)	= YEAR(A.BorrowDate)
 			GROUP BY
				B.Id, B.Title, B.Image
			ORDER BY
				COUNT(B.Id) DESC
		ELSE
			SELECT TOP (@Top)
				B.Id, B.Title, B.Image, COUNT(B.Id) Quantity
			FROM
				Borrow A,
				Book B
			WHERE
				A.BookId = B.Id AND
				YEAR(@StartDate) = YEAR(A.BorrowDate)
			GROUP BY
				B.Id, B.Title, B.Image
			ORDER BY
				COUNT(B.Id) DESC			
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetTopStudent]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetTopStudent]
	@Top int,
	@StartDate date,
	@EndDate date,
	@Type int
AS
BEGIN
	IF @Type = 0
		SELECT TOP (@Top)
			B.Id, B.FullName, B.Avatar, b.Class ClassName, COUNT(B.Id) Quantity
		FROM
			Borrow A,
			Student B
		WHERE
			A.StudentId = B.Id
 		GROUP BY
			B.Id, B.FullName, B.Avatar, b.Class
		ORDER BY
			COUNT(B.Id) DESC
	ELSE
		IF @Type = 1
		SELECT TOP (@Top)
				B.Id, B.FullName, B.Avatar, b.Class ClassName, COUNT(B.Id) Quantity
			FROM
				Borrow A,
				Student B
			WHERE
				A.StudentId			= B.Id AND
				MONTH(@StartDate)	= MONTH(A.BorrowDate) AND
				YEAR(@StartDate)	= YEAR(A.BorrowDate)
 			GROUP BY
				B.Id, B.FullName, B.Avatar, b.Class
			ORDER BY
				COUNT(B.Id) DESC
		ELSE
			SELECT TOP (@Top)
				B.Id, B.FullName, B.Avatar, b.Class ClassName, COUNT(B.Id) Quantity
			FROM
				Borrow A,
				Student B
			WHERE
				A.StudentId = B.Id AND
				YEAR(@StartDate) = YEAR(A.BorrowDate)
			GROUP BY
				B.Id, B.FullName, B.Avatar, b.Class
			ORDER BY
				COUNT(B.Id) DESC			
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertAuthor]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertAuthor]
	@Name nvarchar(50)
AS
BEGIN
	INSERT INTO Author
	VALUES (@Name)
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertBanner]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertBanner]
	@Image varchar(200),
	@Order int,
	@Status int
AS
BEGIN
	BEGIN TRY
		INSERT INTO Banner
		VALUES (
			@Image,
			@Order,
			@Status
		)

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertBook]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertBook]
	@Title nvarchar(100),
	@MetaTitle varchar(100),
	@Image varchar(300),
	@Authors nvarchar(100),
	@CategoryId bigint,
	@PublisherId bigint,
	@Quantity int,
	@PageNumber int,
	@Size varchar(20),
	@Weight varchar(10),
	@PublishYear int,
	@Description nvarchar(4000),
	@Status int
AS
BEGIN
	INSERT INTO Book
	VALUES (
		@Title, 
		@MetaTitle,
		@Image,
		@Authors,
		@CategoryId, 
		@PublisherId, 
		@Quantity, 
		@PageNumber, 
		@Size, 
		@Weight, 
		@PublishYear, 
		@Description, 
		@Status
	)

	SELECT 1
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertBorrow]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertBorrow]
	@StudentId varchar(20),
	@StaffId varchar(20),
	@BookId varchar(20),
	@ReturnDate date,
	@Status int
AS
BEGIN
	BEGIN TRY
		INSERT INTO Borrow
		VALUES (
			@StudentId, 
			@StaffId, 
			@BookId, 
			GETDATE(), 
			(CASE WHEN @Status = -1
				THEN DATEADD(DAY, 1, GETDATE())
				ELSE DATEADD(DAY, 7, GETDATE())
			END),
			( CASE WHEN @Status = 1
				THEN (CASE WHEN @ReturnDate = '' THEN GETDATE() ELSE @ReturnDate END) 
				ELSE NULL
			END ),
			@Status
		)

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertCategory]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertCategory]
	@Name nvarchar(50),
	@MetaTitle varchar(50),
	@Image nvarchar(300)
AS
BEGIN
	BEGIN TRY
		INSERT INTO Category
		VALUES (@Name, @MetaTitle, @Image)

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertFeedback]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertFeedback]
	@Name nvarchar(50),
	@Phone varchar(15),
	@Email varchar(50),
	@Content ntext
AS
BEGIN TRAN
	BEGIN TRY
		INSERT INTO Feedback
		VALUES (@Name, @Phone, @Email, @Content, 0)

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
		ROLLBACK
	END CATCH
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[uspInsertImport]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertImport]
	@StaffId varchar(50)
AS
BEGIN
	BEGIN TRY
		INSERT INTO Import
		VALUES ( @StaffId, GETDATE(), 0, 0)

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertImportDetail]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertImportDetail]
	@ImportId bigint,
	@BookId bigint,
	@Quantity int,
	@Price decimal(18,0)
AS
BEGIN
	BEGIN TRY
		INSERT INTO ImportDetail
		VALUES (
			@ImportId,
			@BookId,
			@Quantity,
			@Price,
			@Quantity * @Price
		)

		SELECT 1
	END TRY
	
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertPublisher]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertPublisher]
	@Name nvarchar(50),
	@MetaTitle varchar(50),
	@Address nvarchar(200),
	@Phone varchar(15),
	@Email varchar(50)
AS
BEGIN
	INSERT INTO Publisher
	VALUES (@Name, @MetaTitle, @Address, @Phone, @Email)
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertStaff]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertStaff]
	@Id varchar(20),
	@Password varchar(50),
	@Avatar varchar(301),
	@FullName nvarchar(50),
	@Gender nvarchar(5),
	@Birthday varchar(20),
	@Address nvarchar(300),
	@Phone varchar(20),
	@Email varchar(50),
	@Status int
AS
BEGIN
	BEGIN TRY
		DECLARE @Count int = 0

		-- Check Id unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Staff
		WHERE Id = @Id

		IF @Count > 0
		BEGIN
			SELECT -1
			RETURN
		END
		
		-- Check Phone unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Staff
		WHERE Phone = @Phone

		IF @Count > 0
		BEGIN
			SELECT -2
			RETURN
		END

		-- Check Email unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Staff
		WHERE Email = @Email

		IF @Count > 0
		BEGIN
			SELECT -3
			RETURN
		END

		INSERT INTO Staff
		VALUES (
			@Id,
			@Password,
			@Avatar,
			@FullName,
			@Gender,
			@Birthday,
			@Address,
			@Phone,
			@Email,
			@Status
		)

		SELECT 1

	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertStudent]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspInsertStudent]
	@Id varchar(20),
	@Password varchar(50),
	@Avatar varchar(301),
	@FullName nvarchar(50),
	@Gender nvarchar(5),
	@Birthday varchar(20),
	@Address nvarchar(300),
	@Phone varchar(20),
	@Email varchar(50),
	@Class varchar(50),
	@Status int
AS
BEGIN
	BEGIN TRY
		DECLARE @Count int = 0

		-- Check Id unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Student
		WHERE Id = @Id

		IF @Count > 0
		BEGIN
			SELECT -1
			RETURN
		END
		
		-- Check Phone unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Student
		WHERE Phone = @Phone

		IF @Count > 0
		BEGIN
			SELECT -2
			RETURN
		END

		-- Check Email unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Student
		WHERE Email = @Email

		IF @Count > 0
		BEGIN
			SELECT -3
			RETURN
		END

		INSERT INTO Student
		VALUES (
			@Id,
			@Password,
			@Avatar,
			@FullName,
			@Gender,
			@Birthday,
			@Address,
			@Phone,
			@Email,
			@Class,
			@Status
		)

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspLogin]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspLogin]
	@Username varchar(20),
	@Password varchar(50),
	@Type int
AS
BEGIN
	DECLARE @Status int = -1

	IF @Type = 0
	BEGIN
		SELECT
			@Status = Status
		FROM
			Student
		WHERE
			Id			= @Username AND
			Password	= @Password
		
		SELECT @Status
	END
	ELSE
	BEGIN
		SELECT
			@Status = Status
		FROM
			Staff
		WHERE
			Id			= @Username AND
			Password	= @Password
		
		SELECT @Status
	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateAuthor]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateAuthor]
	@Id bigint,
	@Name nvarchar(50)
AS
BEGIN
	UPDATE Author
	SET Name = @Name
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateBanner]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
cREATE PROC [dbo].[uspUpdateBanner]
	@Id bigint,
	@Image varchar(200),
	@Order int,
	@Status int
AS
BEGIN
	BEGIN TRY
		UPDATE Banner
		SET 
			Image	= @Image,
			[Order]	= @Order,
			Status	= @Status
		WHERE
			Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateBannerStatus]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateBannerStatus]
	@Id varchar(20)
AS
BEGIN
	BEGIN TRY
		UPDATE Banner
		SET Status = (CASE WHEN Status = 1 THEN 0 ELSE 1 END)
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateBook]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateBook]
	@Id bigint,
	@Title nvarchar(100),
	@MetaTitle varchar(100),
	@Image varchar(300),
	@Authors nvarchar(100),
	@CategoryId bigint,
	@PublisherId bigint,
	@Quantity int,
	@PageNumber int,
	@Size varchar(20),
	@Weight varchar(10),
	@PublishYear int,
	@Description nvarchar(4000),
	@Status int
AS
BEGIN
	UPDATE Book
	SET
		Title = @Title,
		MetaTitle = @MetaTitle,
		Image = @Image,
		Authors = @Authors,
		CategoryId = @CategoryId, 
		PublisherId = @PublisherId, 
		Quantity = @Quantity, 
		PageNumber = @PageNumber, 
		Size = @Size, 
		Weight = @Weight, 
		PublishYear = @PublishYear, 
		Description = @Description, 
		Status = @Status
	WHERE
		Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateBookStatus]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateBookStatus]
	@Id varchar(20)
AS
BEGIN
	BEGIN TRY
		UPDATE Book
		SET Status = (CASE WHEN Status = 1 THEN 0 ELSE 1 END)
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateBorrow]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateBorrow]
	@Id bigint,
	@StudentId varchar(20),
	@StaffId varchar(20),
	@BookId varchar(20),
	@BorrowDate date,
	@ReturnDate date,
	@Status int
AS
BEGIN
	BEGIN TRY
		UPDATE Borrow
		SET
			StudentId = @StudentId, 
			StaffId = @StaffId,
			BookId = @BookId,
			BorrowDate = @BorrowDate,
			ReturnDeadline = (CASE WHEN @Status = -1
								THEN DATEADD(DAY, 1, @BorrowDate)
								ELSE DATEADD(DAY, 7, @BorrowDate)
							 END),
			ReturnDate = (CASE WHEN @Status = 1
							THEN (CASE WHEN @ReturnDate = '' THEN GETDATE() ELSE @ReturnDate END) 
							ELSE NULL END
						 ),
			Status = @Status
		WHERE
			Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateBorrowStatus]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateBorrowStatus]
	@Id bigint,
	@Status int
AS
BEGIN 
	BEGIN TRY
		UPDATE Borrow
		SET
			ReturnDate = (CASE WHEN @Status = 1 THEN GETDATE() ELSE NULL END),
			Status = @Status
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateCategory]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateCategory]
	@Id bigint,
	@Name nvarchar(50),
	@MetaTitle varchar(50),
	@Image nvarchar(300)
AS
BEGIN
	BEGIN TRY
		UPDATE Category
		SET
			Name		= @Name,
			MetaTitle	= @MetaTitle,
			Image		= @Image
		WHERE Id = @Id
		
		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateFeedbackStatus]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateFeedbackStatus]
	@Id bigint
AS
BEGIN TRAN
	BEGIN TRY
		UPDATE Feedback
		SET Status = (CASE WHEN Status = 1 THEN 0 ELSE 1 END)
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		ROLLBACK

		SELECT 0
	END CATCH
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateImportDetail]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateImportDetail]
	@ImportId bigint,
	@BookId bigint,
	@Quantity int,
	@Price decimal(18,0)
AS
BEGIN
	BEGIN TRY
		UPDATE ImportDetail
		SET
			Quantity	= @Quantity,
			Price		= @Price,
			TotalPrice	= @Quantity * @Price
		WHERE
			ImportId	= @ImportId AND
			BookId		= @BookId

		SELECT 1
	END TRY
	
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdatePublisher]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdatePublisher]
	@Id bigint,
	@Name nvarchar(50),
	@MetaTitle varchar(50),
	@Address nvarchar(200),
	@Phone varchar(15),
	@Email varchar(50)
AS
BEGIN
	UPDATE Publisher
	SET
		Name = @Name,
		MetaTitle = @MetaTitle,
		Address = @Address,
		Phone = @Phone,
		Email = @Email
	WHERE
		Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateStaff]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateStaff]
	@Id varchar(20),
	@Password varchar(50),
	@Avatar varchar(301),
	@FullName nvarchar(50),
	@Gender nvarchar(5),
	@Birthday varchar(20),
	@Address nvarchar(300),
	@Phone varchar(20),
	@Email varchar(50),
	@Status int
AS
BEGIN
	BEGIN TRY
		DECLARE @Count int = 0
		
		-- Check Phone unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Staff
		WHERE 
			Id != @Id AND
			Phone = @Phone

		IF @Count > 0
		BEGIN
			SELECT -2
			RETURN
		END

		-- Check Email unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Staff
		WHERE 
			Id != @Id AND
			Email = @Email

		IF @Count > 0
		BEGIN
			SELECT -3
			RETURN
		END

		UPDATE Staff
		SET
			Password	= (CASE WHEN @Password = '' THEN Password ELSE @Password END),
			Avatar		= @Avatar,
			FullName	= @FullName,
			Gender		= @Gender,
			Birthday	= @Birthday,
			Address		= @Address,
			Phone		= @Phone,
			Email		= @Email,
			Status		= @Status
		WHERE
			Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateStaffStatus]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateStaffStatus]
	@Id varchar(20)
AS
BEGIN
	BEGIN TRY
		UPDATE Staff
		SET Status = (CASE WHEN Status = 1 THEN 0 ELSE 1 END)
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateStudent]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateStudent]
	@Id varchar(20),
	@Password varchar(50),
	@Avatar varchar(301),
	@FullName nvarchar(50),
	@Gender nvarchar(5),
	@Birthday varchar(20),
	@Address nvarchar(300),
	@Phone varchar(20),
	@Email varchar(50),
	@Class varchar(50),
	@Status int
AS
BEGIN
	BEGIN TRY
		DECLARE @Count int = 0
		
		-- Check Phone unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Student
		WHERE 
			Id != @Id AND
			Phone = @Phone

		IF @Count > 0
		BEGIN
			SELECT -2
			RETURN
		END

		-- Check Email unique
		SELECT @Count = ISNULL(COUNT(Id), 0)
		FROM Student
		WHERE 
			Id != @Id AND
			Email = @Email

		IF @Count > 0
		BEGIN
			SELECT -3
			RETURN
		END

		UPDATE Student
		SET
			Password	= (CASE WHEN @Password = '' THEN Password ELSE @Password END),
			Avatar		= @Avatar,
			FullName	= @FullName,
			Gender		= @Gender,
			Birthday	= @Birthday,
			Address		= @Address,
			Phone		= @Phone,
			Email		= @Email,
			Class		= @Class,
			Status		= @Status
		WHERE
			Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateStudentStatus]    Script Date: 21/11/2022 1:12:28 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspUpdateStudentStatus]
	@Id varchar(20)
AS
BEGIN
	BEGIN TRY
		UPDATE Student
		SET Status = (CASE WHEN Status = 1 THEN 0 ELSE 1 END)
		WHERE Id = @Id

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO
