USE [master]
GO
/****** Object:  Database [Tiich]    Script Date: 23/11/2014 01:49:48 ******/
CREATE DATABASE [Tiich]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Tiich', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Tiich.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Tiich_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Tiich_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Tiich] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Tiich].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Tiich] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Tiich] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Tiich] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Tiich] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Tiich] SET ARITHABORT OFF 
GO
ALTER DATABASE [Tiich] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Tiich] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Tiich] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Tiich] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Tiich] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Tiich] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Tiich] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Tiich] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Tiich] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Tiich] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Tiich] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Tiich] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Tiich] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Tiich] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Tiich] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Tiich] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Tiich] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Tiich] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Tiich] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Tiich] SET  MULTI_USER 
GO
ALTER DATABASE [Tiich] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Tiich] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Tiich] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Tiich] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Tiich]
GO
/****** Object:  StoredProcedure [dbo].[StraightSearch]    Script Date: 23/11/2014 01:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StraightSearch] 
    @term nvarchar(50),
	@option nvarchar(3)
AS 
	IF(@option = 'Or')
		BEGIN
		DECLARE @individual varchar(30)
		DECLARE @terms varchar(50)
		
		SET @terms = @term
		WHILE LEN(@terms) > 0
			BEGIN
			IF PATINDEX('% %',@terms) > 0
				BEGIN
				print 'if'

					SET @individual = SUBSTRING(@terms, 0, PATINDEX('% %',@terms))
					SELECT * FROM Workshop
					WHERE
						LABEL LIKE '%'+@individual+'%'
						
						PRINT @terms
						PRINT LEN(@individual) + 1
						PRINT LEN(@terms)
					SET @terms = LTRIM(SUBSTRING(@terms, LEN(@individual) + 1,
																 LEN(@terms)))
				END
			ELSE
				BEGIN
					SELECT * FROM Workshop
					WHERE
						LABEL LIKE '%'+@terms+'%'

					SET @individual = @terms
					SET @terms = NULL
				END
			END
		END
	ELSE if (@option = 'And')
		SELECT * FROM Workshop
		WHERE
			LABEL LIKE '%'+@term+'%'

GO
/****** Object:  Table [dbo].[Tag]    Script Date: 23/11/2014 01:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[parentId] [int] NULL,
	[label] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 23/11/2014 01:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Password] [nchar](30) NOT NULL,
	[Email] [nchar](30) NOT NULL,
	[Bio] [text] NULL,
	[Phone] [nchar](10) NULL,
	[Avatar] [nchar](30) NULL,
	[Birthday] [date] NULL,
	[FirstName] [nchar](30) NULL,
	[LastName] [nchar](30) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Workshop]    Script Date: 23/11/2014 01:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Workshop](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nchar](100) NULL,
	[Date] [date] NULL,
	[Hour] [time](7) NULL,
	[PeopleMin] [int] NOT NULL,
	[PeopleMax] [int] NOT NULL,
	[Location] [geography] NULL,
	[PriceMin] [float] NULL,
	[PriceMax] [float] NULL,
	[Recurence] [nchar](50) NULL,
	[CreationDate] [datetime] NOT NULL,
	[Equipement] [text] NULL,
	[UserID] [int] NULL,
	[Address] [text] NULL,
	[Details] [text] NULL,
 CONSTRAINT [PK_Workshop] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkshopTags]    Script Date: 23/11/2014 01:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkshopTags](
	[WorkshopID] [int] NOT NULL,
	[TagID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TagID] ASC,
	[WorkshopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Tag] ON 

INSERT [dbo].[Tag] ([ID], [parentId], [label]) VALUES (45, NULL, N'banjo                                                                                               ')
INSERT [dbo].[Tag] ([ID], [parentId], [label]) VALUES (46, NULL, N'luth                                                                                                ')
INSERT [dbo].[Tag] ([ID], [parentId], [label]) VALUES (47, NULL, N'mandoline                                                                                           ')
INSERT [dbo].[Tag] ([ID], [parentId], [label]) VALUES (48, NULL, N'cistre                                                                                              ')
INSERT [dbo].[Tag] ([ID], [parentId], [label]) VALUES (49, NULL, N'mandore                                                                                             ')
INSERT [dbo].[Tag] ([ID], [parentId], [label]) VALUES (50, NULL, N'théorbe                                                                                             ')
SET IDENTITY_INSERT [dbo].[Tag] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwB3AG8AcgBkAA==      ', N'eleonore.pirri@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 9)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 12)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 15)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 16)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 20)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 39)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 43)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 46)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 48)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 49)
INSERT [dbo].[User] ([Password], [Email], [Bio], [Phone], [Avatar], [Birthday], [FirstName], [LastName], [ID]) VALUES (N'cABhAHMAcwA=                  ', N'wieser.laurent@gmail.com      ', NULL, NULL, NULL, NULL, NULL, NULL, 50)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[Workshop] ON 

INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (3, N'Cours de guitare                                                                                    ', CAST(0x44390B00 AS Date), CAST(0x07002058A3A70000 AS Time), 0, 4, NULL, NULL, NULL, NULL, CAST(0x0000A3E800D4DC66 AS DateTime), N'Une brosse à dents', 8, N'Mommenheim, Deutschland', N'Cours de solfège possible')
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (4, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3E900BC7168 AS DateTime), NULL, 9, N'Afrique', NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (5, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3E900BD210E AS DateTime), NULL, 10, N'Mommert Sebastien, Rue des Jonquilles, Meximieux, France', NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (6, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3E900BD3F6E AS DateTime), NULL, 11, N'Mommert Sebastien, Rue des Jonquilles, Meximieux, France', NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (7, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3E900BD515C AS DateTime), NULL, 12, N'Mommert Sebastien, Rue des Jonquilles, Meximieux, France', NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (8, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3E900BD9C11 AS DateTime), NULL, 13, N'Mommert Sebastien, Rue des Jonquilles, Meximieux, France', NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (9, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3E900BDBF47 AS DateTime), NULL, 14, N'Mommert Sebastien, Rue des Jonquilles, Meximieux, France', NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (10, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3E900BDD4FF AS DateTime), NULL, 15, N'Mommert Sebastien, Rue des Jonquilles, Meximieux, France', NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (11, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3E900BE0343 AS DateTime), NULL, 16, N'Mommert Sebastien, Rue des Jonquilles, Meximieux, France', NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (15, N'tenis                                                                                               ', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3EA00ACB89A AS DateTime), NULL, 20, NULL, NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (34, N'guitare                                                                                             ', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3EA00C5CA8E AS DateTime), NULL, 39, NULL, NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (38, N'tennis                                                                                              ', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3EB0130903E AS DateTime), NULL, 43, NULL, NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (41, N'guitare                                                                                             ', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3EB0132B881 AS DateTime), NULL, 46, NULL, NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (42, N'guitare                                                                                             ', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3EB01362B4F AS DateTime), NULL, 47, NULL, NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (43, N'guitare                                                                                             ', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3EB013CF82D AS DateTime), NULL, 48, NULL, NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (44, N'guitare                                                                                             ', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3EB013D02F9 AS DateTime), NULL, 49, NULL, NULL)
INSERT [dbo].[Workshop] ([ID], [Label], [Date], [Hour], [PeopleMin], [PeopleMax], [Location], [PriceMin], [PriceMax], [Recurence], [CreationDate], [Equipement], [UserID], [Address], [Details]) VALUES (45, N'Tennis                                                                                              ', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, CAST(0x0000A3EB013D3A21 AS DateTime), NULL, 50, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Workshop] OFF
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (41, 37)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (41, 38)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (41, 39)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (41, 40)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (41, 41)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (41, 42)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (42, 45)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (43, 45)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (44, 45)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (42, 46)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (43, 46)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (44, 46)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (42, 47)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (43, 47)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (44, 47)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (42, 48)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (43, 48)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (44, 48)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (42, 49)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (43, 49)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (44, 49)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (42, 50)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (43, 50)
INSERT [dbo].[WorkshopTags] ([WorkshopID], [TagID]) VALUES (44, 50)
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Tag]    Script Date: 23/11/2014 01:49:48 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Tag] ON [dbo].[Tag]
(
	[label] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Workshop]  WITH CHECK ADD  CONSTRAINT [FK_Workshop_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Workshop] CHECK CONSTRAINT [FK_Workshop_User]
GO
ALTER TABLE [dbo].[WorkshopTags]  WITH NOCHECK ADD  CONSTRAINT [FK_WorkshopTags_Tag] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tag] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WorkshopTags] NOCHECK CONSTRAINT [FK_WorkshopTags_Tag]
GO
ALTER TABLE [dbo].[WorkshopTags]  WITH NOCHECK ADD  CONSTRAINT [FK_WorkshopTags_Workshop] FOREIGN KEY([WorkshopID])
REFERENCES [dbo].[Workshop] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WorkshopTags] CHECK CONSTRAINT [FK_WorkshopTags_Workshop]
GO
USE [master]
GO
ALTER DATABASE [Tiich] SET  READ_WRITE 
GO
