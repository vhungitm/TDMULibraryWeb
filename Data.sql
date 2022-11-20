USE [master]
GO
/****** Object:  Database [Library]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Banner]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Book]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Borrow]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Feedback]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Import]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[ImportDetail]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Publisher]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Staff]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  Table [dbo].[Student]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountAuthor]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountBanner]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountBook]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountBorrow]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountCategory]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountFeedback]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountImport]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountImportDetail]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountPublisher]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountStaff]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspCountStudent]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteBanner]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteBook]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteBorrow]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteCategory]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteFeedback]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteImport]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteImportDetail]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeletePublisher]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteStaff]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspDeleteStudent]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetAuthor]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetAuthors]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetBanner]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetBanners]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetBook]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetBookQuantityInStock]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetBooks]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetBorrow]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetBorrowQuantity]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetBorrows]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetCategories]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetCategory]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetFeedback]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetFeedbacks]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetImport]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetImportDetail]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetImportDetails]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetImports]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetPublisher]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetPublishers]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetStaff]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetStaffs]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetStudent]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetStudents]    Script Date: 21/11/2022 12:41:23 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetTopBook]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetTopStudent]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertAuthor]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertBanner]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertBook]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertBorrow]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertCategory]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertFeedback]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertImport]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertImportDetail]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertPublisher]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertStaff]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspInsertStudent]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspLogin]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateAuthor]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateBanner]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateBannerStatus]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateBook]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateBookStatus]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateBorrow]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateBorrowStatus]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateCategory]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateFeedbackStatus]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateImportDetail]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdatePublisher]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateStaff]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateStaffStatus]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateStudent]    Script Date: 21/11/2022 12:41:24 SA ******/
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
/****** Object:  StoredProcedure [dbo].[uspUpdateStudentStatus]    Script Date: 21/11/2022 12:41:24 SA ******/
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
