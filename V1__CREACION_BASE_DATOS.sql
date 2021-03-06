USE [ChangeIt]
GO
/****** Object:  Table [dbo].[BitacoraPosts]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitacoraPosts](
	[idBitacoraPost] [bigint] IDENTITY(1,1) NOT NULL,
	[idPost] [bigint] NOT NULL,
	[idInteraction] [int] NOT NULL,
	[value] [decimal](10, 2) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[idUser] [bigint] NULL,
 CONSTRAINT [PK_BitacoraPosts] PRIMARY KEY CLUSTERED 
(
	[idBitacoraPost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[idGender] [tinyint] IDENTITY(1,1) NOT NULL,
	[gender] [nvarchar](70) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[idGender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Habit]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Habit](
	[idHabit] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](148) NOT NULL,
	[description] [nvarchar](800) NOT NULL,
	[idImage] [bigint] NULL,
 CONSTRAINT [PK_Habit] PRIMARY KEY CLUSTERED 
(
	[idHabit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HabitLog]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HabitLog](
	[idHabitLog] [bigint] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[idHabit] [bigint] NOT NULL,
	[idImpact] [int] NOT NULL,
	[value] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_HabitLog] PRIMARY KEY CLUSTERED 
(
	[idHabitLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HabitsPerPosts]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HabitsPerPosts](
	[idPost] [bigint] NOT NULL,
	[idLocationPerHabit] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[idImage] [bigint] IDENTITY(1,1) NOT NULL,
	[link] [varchar](512) NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[idImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impact]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impact](
	[idImpact] [int] IDENTITY(1,1) NOT NULL,
	[impact] [varchar](254) NOT NULL,
	[measureSystem] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Impact] PRIMARY KEY CLUSTERED 
(
	[idImpact] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InfoPerSocialMedia]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InfoPerSocialMedia](
	[idUser] [bigint] NOT NULL,
	[idSocialMedia] [int] NOT NULL,
	[id_user] [varchar](256) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interactions]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interactions](
	[idInteraction] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](148) NOT NULL,
 CONSTRAINT [PK_Interactions] PRIMARY KEY CLUSTERED 
(
	[idInteraction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[idLocation] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](148) NOT NULL,
	[country] [nvarchar](148) NOT NULL,
	[latitude] [decimal](10, 8) NOT NULL,
	[longitude] [decimal](11, 8) NOT NULL,
	[population] [int] NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[idLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocationsPerHabit]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationsPerHabit](
	[idHabit] [bigint] NOT NULL,
	[idLocation] [bigint] NOT NULL,
	[idLocationsPerHabit] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_LocationsPerHabit] PRIMARY KEY CLUSTERED 
(
	[idLocationsPerHabit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginSessions]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginSessions](
	[idLoginSession] [bigint] IDENTITY(1,1) NOT NULL,
	[idUser] [bigint] NOT NULL,
	[idSocialMedia] [int] NOT NULL,
	[access_token] [varbinary](512) NOT NULL,
	[token_type] [varchar](128) NULL,
	[expire_date] [datetime] NOT NULL,
 CONSTRAINT [PK_LoginSessions] PRIMARY KEY CLUSTERED 
(
	[idLoginSession] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Merchants]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Merchants](
	[idMerchants] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](148) NOT NULL,
	[url] [varchar](512) NOT NULL,
	[enabled] [bit] NOT NULL,
	[idIcon] [bigint] NULL,
 CONSTRAINT [PK_Merchants] PRIMARY KEY CLUSTERED 
(
	[idMerchants] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentAttempts]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentAttempts](
	[idPaymentAttempts] [bigint] IDENTITY(1,1) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[merchanTransNumber] [int] NOT NULL,
	[description] [nvarchar](148) NOT NULL,
	[referenceNumber] [int] NOT NULL,
	[errorNumber] [int] NULL,
	[computerName] [varchar](148) NOT NULL,
	[userName] [varchar](148) NOT NULL,
	[ipAddress] [varchar](14) NOT NULL,
	[checksum] [binary](256) NOT NULL,
	[idMerchant] [int] NOT NULL,
	[idUser] [bigint] NULL,
	[idPaymentStatus] [int] NOT NULL,
 CONSTRAINT [PK_PaymentAttempts] PRIMARY KEY CLUSTERED 
(
	[idPaymentAttempts] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentFromAd]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentFromAd](
	[idPaymentFromAd] [bigint] IDENTITY(1,1) NOT NULL,
	[idPost] [bigint] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[ChangeItPercentage] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_PaymentFromAd] PRIMARY KEY CLUSTERED 
(
	[idPaymentFromAd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentStatus]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentStatus](
	[idPaymentStatus] [int] IDENTITY(1,1) NOT NULL,
	[status] [varchar](148) NOT NULL,
 CONSTRAINT [PK_PaymentStatus] PRIMARY KEY CLUSTERED 
(
	[idPaymentStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentTransactions]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTransactions](
	[idPaymentTransaction] [bigint] IDENTITY(1,1) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[description] [varchar](45) NOT NULL,
	[computerName] [varchar](45) NOT NULL,
	[ipAddress] [varchar](14) NOT NULL,
	[checksum] [binary](256) NULL,
	[amount] [decimal](10, 2) NULL,
	[referenceID] [bigint] NULL,
	[idUser] [bigint] NOT NULL,
	[idTransactionType] [int] NOT NULL,
	[idTransactionSubType] [int] NOT NULL,
	[idPaymentAttempts] [bigint] NOT NULL,
 CONSTRAINT [PK_PaymentTransactions] PRIMARY KEY CLUSTERED 
(
	[idPaymentTransaction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[idPost] [bigint] IDENTITY(1,1) NOT NULL,
	[idSocialMedia] [int] NOT NULL,
	[link] [varchar](512) NULL,
	[description] [nvarchar](148) NULL,
	[idUser] [bigint] NOT NULL,
	[idPostType] [int] NOT NULL,
	[postTime] [datetime] NOT NULL,
	[linkAction] [varchar](512) NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[idPost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostType]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostType](
	[idPostType] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](70) NOT NULL,
 CONSTRAINT [PK_PostType] PRIMARY KEY CLUSTERED 
(
	[idPostType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prices]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prices](
	[idPrice] [bigint] IDENTITY(1,1) NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[idLocationPerHabit] [bigint] NOT NULL,
 CONSTRAINT [PK_Prices] PRIMARY KEY CLUSTERED 
(
	[idPrice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocialMedia]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocialMedia](
	[idSocialMedia] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](70) NOT NULL,
	[idIcon] [bigint] NULL,
 CONSTRAINT [PK_SocialMedia] PRIMARY KEY CLUSTERED 
(
	[idSocialMedia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sponsors]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sponsors](
	[idSponsor] [bigint] IDENTITY(1,1) NOT NULL,
	[idLocationsPerHabit] [bigint] NOT NULL,
	[radius] [decimal](10, 2) NOT NULL,
	[idUser] [bigint] NOT NULL,
	[startSponsor] [datetime] NOT NULL,
	[endSponsor] [datetime] NULL,
	[amount] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_SponsorsPerLocationsPerHabit] PRIMARY KEY CLUSTERED 
(
	[idSponsor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SponsorsPayment]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SponsorsPayment](
	[idSponsorPayment] [bigint] IDENTITY(1,1) NOT NULL,
	[idPaymentFromAd] [bigint] NOT NULL,
	[idSponsor] [bigint] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[postTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SponsorsPayment] PRIMARY KEY CLUSTERED 
(
	[idSponsorPayment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionSubTypes]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionSubTypes](
	[idTransactionSubType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
 CONSTRAINT [PK_TransactionSubTypes] PRIMARY KEY CLUSTERED 
(
	[idTransactionSubType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionTypes]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypes](
	[idTransactionType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
 CONSTRAINT [PK_TransactionTypes] PRIMARY KEY CLUSTERED 
(
	[idTransactionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[idUser] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](70) NOT NULL,
	[lastName] [nvarchar](70) NOT NULL,
	[birthday] [datetime] NOT NULL,
	[idProfilePicture] [bigint] NOT NULL,
	[idGender] [tinyint] NULL,
	[email] [varchar](256) NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UTMTags]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UTMTags](
	[idUTMTag] [int] IDENTITY(1,1) NOT NULL,
	[tag] [varchar](56) NOT NULL,
 CONSTRAINT [PK_UTMTags] PRIMARY KEY CLUSTERED 
(
	[idUTMTag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UTMTagsPerHabit]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UTMTagsPerHabit](
	[idHabit] [bigint] NOT NULL,
	[idUTMTag] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UTMTagsPerPost]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UTMTagsPerPost](
	[idUTMTag] [int] NOT NULL,
	[idPost] [bigint] NOT NULL,
	[value] [varchar](256) NOT NULL,
	[postTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Variables]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Variables](
	[idVariable] [int] IDENTITY(1,1) NOT NULL,
	[variable] [varchar](70) NOT NULL,
	[datatype] [varchar](70) NOT NULL,
 CONSTRAINT [PK_Variables] PRIMARY KEY CLUSTERED 
(
	[idVariable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VariablesPerPost]    Script Date: 6/22/2021 3:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VariablesPerPost](
	[idVariable] [int] NOT NULL,
	[idPost] [bigint] NOT NULL,
	[value] [varchar](128) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[UTMTagsPerPost] ADD  CONSTRAINT [DF_UTMTagsPerPost_postTime]  DEFAULT (getdate()) FOR [postTime]
GO
ALTER TABLE [dbo].[BitacoraPosts]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraPosts_Interactions] FOREIGN KEY([idInteraction])
REFERENCES [dbo].[Interactions] ([idInteraction])
GO
ALTER TABLE [dbo].[BitacoraPosts] CHECK CONSTRAINT [FK_BitacoraPosts_Interactions]
GO
ALTER TABLE [dbo].[BitacoraPosts]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraPosts_Posts] FOREIGN KEY([idPost])
REFERENCES [dbo].[Posts] ([idPost])
GO
ALTER TABLE [dbo].[BitacoraPosts] CHECK CONSTRAINT [FK_BitacoraPosts_Posts]
GO
ALTER TABLE [dbo].[BitacoraPosts]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraPosts_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[BitacoraPosts] CHECK CONSTRAINT [FK_BitacoraPosts_Users]
GO
ALTER TABLE [dbo].[Habit]  WITH CHECK ADD  CONSTRAINT [FK_Habit_Images] FOREIGN KEY([idImage])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[Habit] CHECK CONSTRAINT [FK_Habit_Images]
GO
ALTER TABLE [dbo].[HabitLog]  WITH CHECK ADD  CONSTRAINT [FK_HabitLog_Habit] FOREIGN KEY([idHabit])
REFERENCES [dbo].[Habit] ([idHabit])
GO
ALTER TABLE [dbo].[HabitLog] CHECK CONSTRAINT [FK_HabitLog_Habit]
GO
ALTER TABLE [dbo].[HabitLog]  WITH CHECK ADD  CONSTRAINT [FK_HabitLog_Impact] FOREIGN KEY([idImpact])
REFERENCES [dbo].[Impact] ([idImpact])
GO
ALTER TABLE [dbo].[HabitLog] CHECK CONSTRAINT [FK_HabitLog_Impact]
GO
ALTER TABLE [dbo].[HabitsPerPosts]  WITH CHECK ADD  CONSTRAINT [FK_HabitsPerPosts_LocationsPerHabit] FOREIGN KEY([idLocationPerHabit])
REFERENCES [dbo].[LocationsPerHabit] ([idLocationsPerHabit])
GO
ALTER TABLE [dbo].[HabitsPerPosts] CHECK CONSTRAINT [FK_HabitsPerPosts_LocationsPerHabit]
GO
ALTER TABLE [dbo].[HabitsPerPosts]  WITH CHECK ADD  CONSTRAINT [FK_HabitsPerPosts_Posts] FOREIGN KEY([idPost])
REFERENCES [dbo].[Posts] ([idPost])
GO
ALTER TABLE [dbo].[HabitsPerPosts] CHECK CONSTRAINT [FK_HabitsPerPosts_Posts]
GO
ALTER TABLE [dbo].[InfoPerSocialMedia]  WITH CHECK ADD  CONSTRAINT [FK_InfoPerSocialMedia_SocialMedia] FOREIGN KEY([idSocialMedia])
REFERENCES [dbo].[SocialMedia] ([idSocialMedia])
GO
ALTER TABLE [dbo].[InfoPerSocialMedia] CHECK CONSTRAINT [FK_InfoPerSocialMedia_SocialMedia]
GO
ALTER TABLE [dbo].[InfoPerSocialMedia]  WITH CHECK ADD  CONSTRAINT [FK_InfoPerSocialMedia_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[InfoPerSocialMedia] CHECK CONSTRAINT [FK_InfoPerSocialMedia_Users]
GO
ALTER TABLE [dbo].[LocationsPerHabit]  WITH CHECK ADD  CONSTRAINT [FK_LocationsPerHabit_Habit] FOREIGN KEY([idHabit])
REFERENCES [dbo].[Habit] ([idHabit])
GO
ALTER TABLE [dbo].[LocationsPerHabit] CHECK CONSTRAINT [FK_LocationsPerHabit_Habit]
GO
ALTER TABLE [dbo].[LocationsPerHabit]  WITH CHECK ADD  CONSTRAINT [FK_LocationsPerHabit_Locations] FOREIGN KEY([idLocation])
REFERENCES [dbo].[Locations] ([idLocation])
GO
ALTER TABLE [dbo].[LocationsPerHabit] CHECK CONSTRAINT [FK_LocationsPerHabit_Locations]
GO
ALTER TABLE [dbo].[LoginSessions]  WITH CHECK ADD  CONSTRAINT [FK_LoginSessions_SocialMedia] FOREIGN KEY([idSocialMedia])
REFERENCES [dbo].[SocialMedia] ([idSocialMedia])
GO
ALTER TABLE [dbo].[LoginSessions] CHECK CONSTRAINT [FK_LoginSessions_SocialMedia]
GO
ALTER TABLE [dbo].[LoginSessions]  WITH CHECK ADD  CONSTRAINT [FK_LoginSessions_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[LoginSessions] CHECK CONSTRAINT [FK_LoginSessions_Users]
GO
ALTER TABLE [dbo].[Merchants]  WITH CHECK ADD  CONSTRAINT [FK_Merchants_Images] FOREIGN KEY([idIcon])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[Merchants] CHECK CONSTRAINT [FK_Merchants_Images]
GO
ALTER TABLE [dbo].[PaymentAttempts]  WITH CHECK ADD  CONSTRAINT [FK_PaymentAttempts_Merchants] FOREIGN KEY([idMerchant])
REFERENCES [dbo].[Merchants] ([idMerchants])
GO
ALTER TABLE [dbo].[PaymentAttempts] CHECK CONSTRAINT [FK_PaymentAttempts_Merchants]
GO
ALTER TABLE [dbo].[PaymentAttempts]  WITH CHECK ADD  CONSTRAINT [FK_PaymentAttempts_PaymentStatus] FOREIGN KEY([idPaymentStatus])
REFERENCES [dbo].[PaymentStatus] ([idPaymentStatus])
GO
ALTER TABLE [dbo].[PaymentAttempts] CHECK CONSTRAINT [FK_PaymentAttempts_PaymentStatus]
GO
ALTER TABLE [dbo].[PaymentAttempts]  WITH CHECK ADD  CONSTRAINT [FK_PaymentAttempts_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[PaymentAttempts] CHECK CONSTRAINT [FK_PaymentAttempts_Users]
GO
ALTER TABLE [dbo].[PaymentFromAd]  WITH CHECK ADD  CONSTRAINT [FK_PaymentFromAd_Posts] FOREIGN KEY([idPost])
REFERENCES [dbo].[Posts] ([idPost])
GO
ALTER TABLE [dbo].[PaymentFromAd] CHECK CONSTRAINT [FK_PaymentFromAd_Posts]
GO
ALTER TABLE [dbo].[PaymentTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_PaymentAttempts] FOREIGN KEY([idPaymentAttempts])
REFERENCES [dbo].[PaymentAttempts] ([idPaymentAttempts])
GO
ALTER TABLE [dbo].[PaymentTransactions] CHECK CONSTRAINT [FK_PaymentTransactions_PaymentAttempts]
GO
ALTER TABLE [dbo].[PaymentTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_TransactionSubTypes] FOREIGN KEY([idTransactionSubType])
REFERENCES [dbo].[TransactionSubTypes] ([idTransactionSubType])
GO
ALTER TABLE [dbo].[PaymentTransactions] CHECK CONSTRAINT [FK_PaymentTransactions_TransactionSubTypes]
GO
ALTER TABLE [dbo].[PaymentTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_TransactionTypes] FOREIGN KEY([idTransactionType])
REFERENCES [dbo].[TransactionTypes] ([idTransactionType])
GO
ALTER TABLE [dbo].[PaymentTransactions] CHECK CONSTRAINT [FK_PaymentTransactions_TransactionTypes]
GO
ALTER TABLE [dbo].[PaymentTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[PaymentTransactions] CHECK CONSTRAINT [FK_PaymentTransactions_Users]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_PostType] FOREIGN KEY([idPostType])
REFERENCES [dbo].[PostType] ([idPostType])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_PostType]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_SocialMedia] FOREIGN KEY([idSocialMedia])
REFERENCES [dbo].[SocialMedia] ([idSocialMedia])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_SocialMedia]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_Users]
GO
ALTER TABLE [dbo].[Prices]  WITH CHECK ADD  CONSTRAINT [FK_Prices_LocationsPerHabit] FOREIGN KEY([idLocationPerHabit])
REFERENCES [dbo].[LocationsPerHabit] ([idLocationsPerHabit])
GO
ALTER TABLE [dbo].[Prices] CHECK CONSTRAINT [FK_Prices_LocationsPerHabit]
GO
ALTER TABLE [dbo].[SocialMedia]  WITH CHECK ADD  CONSTRAINT [FK_SocialMedia_Images] FOREIGN KEY([idIcon])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[SocialMedia] CHECK CONSTRAINT [FK_SocialMedia_Images]
GO
ALTER TABLE [dbo].[Sponsors]  WITH CHECK ADD  CONSTRAINT [FK_SponsorsPerLocationsPerHabit_LocationsPerHabit] FOREIGN KEY([idLocationsPerHabit])
REFERENCES [dbo].[LocationsPerHabit] ([idLocationsPerHabit])
GO
ALTER TABLE [dbo].[Sponsors] CHECK CONSTRAINT [FK_SponsorsPerLocationsPerHabit_LocationsPerHabit]
GO
ALTER TABLE [dbo].[Sponsors]  WITH CHECK ADD  CONSTRAINT [FK_SponsorsPerLocationsPerHabit_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[Sponsors] CHECK CONSTRAINT [FK_SponsorsPerLocationsPerHabit_Users]
GO
ALTER TABLE [dbo].[SponsorsPayment]  WITH CHECK ADD  CONSTRAINT [FK_SponsorsPayment_PaymentFromAd] FOREIGN KEY([idPaymentFromAd])
REFERENCES [dbo].[PaymentFromAd] ([idPaymentFromAd])
GO
ALTER TABLE [dbo].[SponsorsPayment] CHECK CONSTRAINT [FK_SponsorsPayment_PaymentFromAd]
GO
ALTER TABLE [dbo].[SponsorsPayment]  WITH CHECK ADD  CONSTRAINT [FK_SponsorsPayment_Sponsors] FOREIGN KEY([idSponsor])
REFERENCES [dbo].[Sponsors] ([idSponsor])
GO
ALTER TABLE [dbo].[SponsorsPayment] CHECK CONSTRAINT [FK_SponsorsPayment_Sponsors]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Gender] FOREIGN KEY([idGender])
REFERENCES [dbo].[Gender] ([idGender])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Gender]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Images] FOREIGN KEY([idProfilePicture])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Images]
GO
ALTER TABLE [dbo].[UTMTagsPerHabit]  WITH CHECK ADD  CONSTRAINT [FK_UTMTagsPerHabit_Habit] FOREIGN KEY([idHabit])
REFERENCES [dbo].[Habit] ([idHabit])
GO
ALTER TABLE [dbo].[UTMTagsPerHabit] CHECK CONSTRAINT [FK_UTMTagsPerHabit_Habit]
GO
ALTER TABLE [dbo].[UTMTagsPerHabit]  WITH CHECK ADD  CONSTRAINT [FK_UTMTagsPerHabit_UTMTags] FOREIGN KEY([idUTMTag])
REFERENCES [dbo].[UTMTags] ([idUTMTag])
GO
ALTER TABLE [dbo].[UTMTagsPerHabit] CHECK CONSTRAINT [FK_UTMTagsPerHabit_UTMTags]
GO
ALTER TABLE [dbo].[UTMTagsPerPost]  WITH CHECK ADD  CONSTRAINT [FK_UTMTagsPerPost_Posts] FOREIGN KEY([idPost])
REFERENCES [dbo].[Posts] ([idPost])
GO
ALTER TABLE [dbo].[UTMTagsPerPost] CHECK CONSTRAINT [FK_UTMTagsPerPost_Posts]
GO
ALTER TABLE [dbo].[UTMTagsPerPost]  WITH CHECK ADD  CONSTRAINT [FK_UTMTagsPerPost_UTMTags] FOREIGN KEY([idUTMTag])
REFERENCES [dbo].[UTMTags] ([idUTMTag])
GO
ALTER TABLE [dbo].[UTMTagsPerPost] CHECK CONSTRAINT [FK_UTMTagsPerPost_UTMTags]
GO
ALTER TABLE [dbo].[VariablesPerPost]  WITH CHECK ADD  CONSTRAINT [FK_VariablesPerPost_Posts] FOREIGN KEY([idPost])
REFERENCES [dbo].[Posts] ([idPost])
GO
ALTER TABLE [dbo].[VariablesPerPost] CHECK CONSTRAINT [FK_VariablesPerPost_Posts]
GO
ALTER TABLE [dbo].[VariablesPerPost]  WITH CHECK ADD  CONSTRAINT [FK_VariablesPerPost_Variables] FOREIGN KEY([idVariable])
REFERENCES [dbo].[Variables] ([idVariable])
GO
ALTER TABLE [dbo].[VariablesPerPost] CHECK CONSTRAINT [FK_VariablesPerPost_Variables]
GO
