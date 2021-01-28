-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210122
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02Pruebas]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ARCUSFIL_PROGRAM]') AND type in (N'U'))
	DROP TABLE [dbo].[ARCUSFIL_PROGRAM]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ARCUSFIL_PROGRAM_OPTION]') AND type in (N'U'))
	DROP TABLE [dbo].[ARCUSFIL_PROGRAM_OPTION]
GO


-- ////////////////////////////////////////////////////////////////
-- //					ARCUSFIL_PROGRAM_OPTION				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ARCUSFIL_PROGRAM_OPTION] (
	[K_ARCUSFIL_PROGRAM_OPTION]				[INT]			IDENTITY (1,1)	NOT NULL,
	[D_ARCUSFIL_PROGRAM_OPTION]				[VARCHAR](255)	NOT NULL,
	[S_ARCUSFIL_PROGRAM_OPTION]				[VARCHAR](20)	NOT NULL,
	-- ===========================
	[K_ARCUSFIL_PROGRAM]					[INT]			NOT NULL,
	-- ===========================
	[ARCUSFIL_PROGRAM_OPTION_MODEL]			[VARCHAR](255)	NOT NULL DEFAULT '',
	[ARCUSFIL_PROGRAM_OPTION_YEAR]			[VARCHAR](20)	NOT NULL DEFAULT '',
	[ARCUSFIL_PROGRAM_OPTION_MAKER]			[VARCHAR](255)	NOT NULL DEFAULT '',
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[ARCUSFIL_PROGRAM_OPTION]
	ADD CONSTRAINT [PK_ARCUSFIL_PROGRAM_OPTION]
		PRIMARY KEY CLUSTERED ([K_ARCUSFIL_PROGRAM_OPTION])
GO
ALTER TABLE [dbo].[ARCUSFIL_PROGRAM_OPTION]
ADD
			[K_USUARIO_ALTA]					[INT] NOT NULL,
			[F_ALTA]							[DATETIME] NOT NULL,
			[K_USUARIO_CAMBIO]					[INT] NOT NULL,
			[F_CAMBIO]							[DATETIME] NOT NULL,
			[L_BORRADO]							[INT] NOT NULL,
			[K_USUARIO_BAJA]					[INT] NULL,
			[F_BAJA]							[DATETIME] NULL;
GO


-- ////////////////////////////////////////////////////////////////
-- //					ARCUSFIL_PROGRAM				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ARCUSFIL_PROGRAM] (
	[K_ARCUSFIL_PROGRAM]				[INT]			IDENTITY (1,1)	NOT NULL,
	[S_ARCUSFIL_PROGRAM]				[VARCHAR](20)	NOT NULL,
	[O_ARCUSFIL_PROGRAM]				[INT]			NOT NULL DEFAULT 15,
	[L_ARCUSFIL_PROGRAM]				[INT]			NOT NULL DEFAULT 1,
	-- ===========================
	[A4GLIdentity]						[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[ARCUSFIL_PROGRAM]
	ADD CONSTRAINT [PK_ARCUSFIL_PROGRAM]
		PRIMARY KEY CLUSTERED ([K_ARCUSFIL_PROGRAM])
GO

ALTER TABLE [dbo].[ARCUSFIL_PROGRAM]
ADD
			[K_USUARIO_ALTA]					[INT] NOT NULL,
			[F_ALTA]							[DATETIME] NOT NULL,
			[K_USUARIO_CAMBIO]					[INT] NOT NULL,
			[F_CAMBIO]							[DATETIME] NOT NULL,
			[L_BORRADO]							[INT] NOT NULL,
			[K_USUARIO_BAJA]					[INT] NULL,
			[F_BAJA]							[DATETIME] NULL;
GO

-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ARCUSFIL_PROGRAM]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ARCUSFIL_PROGRAM]
GO
-- //////////////////////////////////////////////////////////////
-- //				CI - ARCUSFIL_PROGRAM
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_ARCUSFIL_PROGRAM]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_S_ARCUSFIL_PROGRAM				VARCHAR(20),
	-- ===========================
	@PP_A4GLIdentity					INT
	-- ===========================
AS
	-- ===========================
	INSERT INTO ARCUSFIL_PROGRAM
			(	[S_ARCUSFIL_PROGRAM],
				-- ===========================
				[A4GLIdentity],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]		)
	VALUES	
			(	LTRIM(RTRIM(@PP_S_ARCUSFIL_PROGRAM)),
				-- ===========================
				@PP_A4GLIdentity,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
	-- //////////////////////////////////////////////////////////////
GO
-- ===================================================================================================================
SET NOCOUNT OFF
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WL		'			,'46'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U377	'			,'01'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WK		'			,'56'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WL		'			,'57'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WS		'			,'51'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U364	'			,'05'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U388	'			,'40'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WL		'			,'54'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'GMT	'			,'07'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U387	'			,'07'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U388	'			,'07'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'JL		'			,'07'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'V229	'			,'07'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WL		'			,'07'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'GMT	'			,'34'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U388	'			,'32'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'JCI	'			,'09'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'GM360	'			,'09'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U288	'			,'37'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'P415	'			,'37'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'GM360	'			,'37'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U228	'			,'37'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'GM360	'			,'38'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U388	'			,'39'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'GMX365	'			,'13'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'S197	'			,'13'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'D258	'			,'13'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'GMX001	'			,'17'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U377	'			,'17'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'VN127	'			,'17'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U204	'			,'17'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U364	'			,'17'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U553	'			,'17'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WL		'			,'18'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U387	'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'GMT	'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U388	'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'D471	'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'RU		'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U540	'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WK		'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WD		'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WS		'			,'19'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U388	'			,'41'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'U228	'			,'27'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'RU		'			,'36'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WPI	'			,'55'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WS		'			,'53'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 139,		'WL		'			,'58'
SET NOCOUNT ON


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]
GO
-- //////////////////////////////////////////////////////////////
-- //				CI - ARCUSFIL_PROGRAM_OPTION
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_ARCUSFIL_PROGRAM				INT,
	-- ===========================
	@PP_S_ARCUSFIL_PROGRAM_OPTION		VARCHAR(20),
	@PP_D_ARCUSFIL_PROGRAM_OPTION		VARCHAR(255),
	-- ===========================
	@PP_ARCUSFIL_PROGRAM_OPTION_MODEL	VARCHAR(255),
	@PP_ARCUSFIL_PROGRAM_OPTION_YEAR	VARCHAR(20),
	@PP_ARCUSFIL_PROGRAM_OPTION_MAKER	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO ARCUSFIL_PROGRAM_OPTION
			(	[D_ARCUSFIL_PROGRAM_OPTION],			
				[S_ARCUSFIL_PROGRAM_OPTION],
				-- ===========================
				[K_ARCUSFIL_PROGRAM],
				-- ===========================
				[ARCUSFIL_PROGRAM_OPTION_MODEL],		[ARCUSFIL_PROGRAM_OPTION_YEAR],
				[ARCUSFIL_PROGRAM_OPTION_MAKER],			
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]		)
	VALUES	
			(	LTRIM(RTRIM(@PP_D_ARCUSFIL_PROGRAM_OPTION)),			
				LTRIM(RTRIM(@PP_S_ARCUSFIL_PROGRAM_OPTION)),
				-- ===========================
				@PP_K_ARCUSFIL_PROGRAM,
				-- ===========================
				LTRIM(RTRIM(@PP_ARCUSFIL_PROGRAM_OPTION_MODEL)),		@PP_ARCUSFIL_PROGRAM_OPTION_YEAR,
				LTRIM(RTRIM(@PP_ARCUSFIL_PROGRAM_OPTION_MAKER)),
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )	
	-- //////////////////////////////////////////////////////////////
GO

-- ===================================================================================================================
SET NOCOUNT OFF
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		1,				'75 DL	',				'VPD						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		2,				'U377	',				'HEADREST					',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		3,				'WD		',				'2ND ROW ARMREST			',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		4,				'WL		',				'----						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		5,				'BL-GL	',				'3RD ROW     				',				'----			',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		5,				'AL		',				'3RD ROW       				',				'----			',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		5,				'SL		',				'NEVER QUILTED 				',				'----			',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		5,				'AL		',				'BASE          				',				'----			',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		5,				'SL		',				'3RD ROW       				',				'----			',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		5,				'UL		',				'3RD ROW       				',				'----			',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		5,				'UL		',				'ALWAYS QUILTED     		',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		6,				'LTD	',				'FINDALY					',				'MERCURY		',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		7,				'U388	',				'ARMREST          			',				'----			',		'----',				'LINCOLN	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		8,				'75		',				'QUADS 2ND. ROW ARMREST		',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		8,				'74/75	',				'2ND ROW ARMREST			',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		9,				'193	',				'----						',				'----			',		'2007',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		9,				'191	',				'TORRENT       				',				'PONTIAC		',		'----',				'GM			'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		9,				'192	',				'PERSUIT					',				'PONTIAC		',		'----',				'GM			'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		9,				'193	',				'ARMREST					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		9,				'192	',				'GXP						',				'----			',		'2008',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		12,				'JT     ',				'----						',				'----			',		'2019',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		12,				'JL		',				'----						',				'----			',		'2018',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		12,				'JL		',				'PHEV						',				'----			',		'2020',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		12,				'JL		',				'PHEV SUMMIT				',				'----			',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		12,				'JL		',				'SUMMIT						',				'----			',		'----',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		12,				'JT		',				'MOJAVE           			',				'----			',		'2019',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		12,				'JT		',				'SUMMIT						',				'----			',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		10,				'U387	',				'CUTTING EDGE				',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		10,				'U387	',				'PREMIUM					',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		11,				'U387	',				'ARMREST					',				'----			',		'----',				'LINCOLN	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		11,				'U387	',				'HEADREST					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		11,				'U387	',				'LIMITED          			',				'----			',		'----',				'LINCOLN	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		13,				'LTD	',				'----						',				'FREESTAR		',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		13,				'LTD	',				'----						',				'FREESTAR		',		'----',				'MERCURY	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		13,				'MPA	',				'----						',				'FREESTAR		',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		13,				'MXA	',				'----						',				'FREESTAR		',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		14,				'WL		',				'----						',				'----			',		'2020',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		15,				'191	',				'----						',				'----			',		'2008',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		15,				'192	',				'----						',				'----			',		'2008',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		15,				'193	',				'ARMREST					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		15,				'193	',				'----						',				'----			',		'2008',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		15,				'192	',				'GXP						',				'----			',		'2008',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		16,				'U388	',				'CONSOLE					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		18,				'CHINA	',				'CHEVY/ISUZU/GMC			',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		17,				'EN114	',				'CONSOLE					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		17,				'JCI	',				'----						',				'----			',		'----',				'TESLA		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		21,				'GM360	',				'----						',				'----			',		'----',				'BUICK		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		21,				'GM360	',				'CHEVY/ISUZU/GMC			',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		21,				'GM360	',				'----						',				'DENALY			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		21,				'GM360	',				'----						',				'TRAILBLAZER SS	',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		21,				'GM360	',				'----						',				'----			',		'----',				'SAAB		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		20,				'P415	',				'PLATINIUM					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		22,				'U228	',				'LUX						',				'NAVIGATOR		',		'----',				'LINCOLN	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		19,				'U288	',				'LUX/ULT					',				'NAVIGATOR		',		'----',				'LINCOLN	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		23,				'GM360	',				'CHEVY/ISUZU/GMC SHANGAI	',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		23,				'GM360	',				'SHANGAI					',				'CHEVY			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		24,				'U388	',				'HEADREST               	',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		27,				'LTD    ',				'----						',				'TAURUS			',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		27,				'D258	',				'SHO & LIMITED				',				'TAURUS			',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		27,				'SEL	',				'----						',				'TAURUS			',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		25,				'GMX365	',				'FIXED            			',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		25,				'GMX365	',				'----						',				'LACROSSE		',		'----',				'BUICK		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		26,				'S197	',				'CALIFORNIA					',				'MUSTANG		',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		26,				'IUP	',				'----						',				'MUSTANG		',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		26,				'PREMIUM',				'----						',				'MUSTANG		',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		26,				'5B8  	',				'----						',				'MUSTANG SHELBY	',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		26,				'TT		',				'----						',				'MUSTANG SHELBY	',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		28,				'001	',				'COUPE						',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		28,				'001	',				'COUPE L4					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		28,				'001	',				'SEDAN						',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		31,				'U204	',				'AIR BAG					',				'----			',		'----',				'MAZDA		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		31,				'LTD	',				'AB							',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		31,				'LTD	',				'STD						',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		31,				'U204	',				'PREMIUM					',				'----			',		'----',				'MAZDA		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		32,				'LTD	',				'STD						',				'----			',		'----',				'MERCURY	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		32,				'MCY	',				'PREMIUM					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		29,				'U377	',				'HEADREST					',				'----			',		'2010',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		29,				'U377	',				'PREMIUM					',				'----			',		'2009',				'MAZDA		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		29,				'U377	',				'PREMIUM					',				'----			',		'2009',				'MERCURY	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		29,				'PLM    ',				'PREMIUM					',				'----			',		'2011',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		29,				'LTD	',				'----						',				'----			',		'2008',				'MERCURY	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		29,				'U377	',				'PREMIUM					',				'----			',		'2008',				'MERCURY	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		29,				'U377	',				'MONO TONE					',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		29,				'U377	',				'PREMIUM					',				'----			',		'2008',				'MAZDA		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		33,				'U553	',				'----						',				'EXPEDITION		',		'2019',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		30,				'VN127	',				'ECONOLINE         			',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'74 AL	',				'----						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'74 BL	',				'----						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'74 CL	',				'8W							',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'74 DL	',				'----						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'74 EC	',				'----						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'74 SL	',				'----						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'74 TL	',				'----						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'75 AL	',				'8W LIMITED					',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'75 CL	',				'12 WAY						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'75 CL	',				'8 WAY						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'75 DL	',				'LIMITED					',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'75 EC	',				'SUMMIT						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'75 BL	',				'OVERLAND					',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'KL		',				'8W BASE SRT				',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		34,				'75 TL	',				'12 WAY						',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		38,				'D471	',				'SEL						',				'----			',		'2012',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		38,				'LTD	',				'----						',				'----			',		'2012',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		38,				'LTD	',				'----						',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		38,				'SEL	',				'----						',				'----			',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		38,				'LTD	',				'----						',				'----			',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		38,				'D471	',				'SALERNO					',				'----			',		'2016',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		36,				'315	',				'SUV						',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		39,				'DL		',				'PINNACLE					',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		39,				'AL		',				'----						',				'----			',		'2016',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		39,				'EL		',				'----						',				'----			',		'2016',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		39,				'ML		',				'----						',				'----			',		'2016',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'U387	',				'PREMIUM					',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'U387	',				'CUTTING EDGE				',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'U387	',				'GREY						',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'PLM    ',				'SEL						',				'----			',		'2011',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'SEL	',				'----						',				'----			',		'2012',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'SEL	',				'----						',				'----			',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'U387	',				'SPORT						',				'----			',		'2012',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'U387	',				'SPORT						',				'----			',		'2011',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'VPP	',				'----						',				'----			',		'----',				'FORD		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		35,				'SEL	',				'----						',				'----			',		'2013',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		37,				'U388	',				'LIMITED					',				'----			',		'----',				'LINCOLN	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		37,				'U388	',				'BASE						',				'----			',		'2012',				'LINCOLN	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		37,				'U388	',				'ULTIMATE					',				'----			',		'----',				'LINCOLN	'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		37,				'U388	',				'HEADREST					',				'----			',		'2012',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		40,				'U540	',				'VINYL LAMINATION			',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		42,				'ML		',				'DOS TONOS					',				'----			',		'2017',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		42,				'ML		',				'----						',				'----			',		'2017',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		42,				'PL		',				'----						',				'----			',		'2018',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'BL		',				'----						',				'----			',		'2017',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'EL		',				'RESERVE					',				'----			',		'2017',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'GL/DL	',				'----						',				'----			',		'2014',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'CJ		',				'----						',				'----			',		'2017',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'KL		',				'ALTITUDE II        		',				'----			',		'2015',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'GL/DL	',				'TWO TONES					',				'----			',		'2014',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'UL		',				'----						',				'----			',		'2014',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'YL		',				'----						',				'----			',		'2018',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'DZ		',				'SRT						',				'----			',		'2014',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'NL		',				'----						',				'----			',		'2018',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		41,				'YL     ',				'----						',				'----			',		'2018',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		43,				'AL     ',				'2019 WS JEEP AL        	',				'----			',		'2019',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		44,				'U388	',				'HEADREST					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		45,				'U228	',				'HEADREST					',				'NAVIGATOR		',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		46,				'RU		',				'PINNACLE					',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		47,				'WD		',				'CONSOLE LID				',				'----			',		'2021',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		48,				'WS		',				'DOOR PANEL					',				'----			',		'----',				'----		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		48,				'WS		',				'----						',				'GRAND WAGONEER	',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		49,				'74		',				'----						',				'GRAND CHEROKEE	',		'2021',				'JEEP		'
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 139,		49,				'75		',				'----						',				'GRAND CHEROKEE	',		'2021',				'JEEP		'
SET NOCOUNT ON
GO

UPDATE	ARCUSFIL_PROGRAM_OPTION
SET		D_ARCUSFIL_PROGRAM_OPTION=''
WHERE	D_ARCUSFIL_PROGRAM_OPTION like '%--%'

UPDATE	ARCUSFIL_PROGRAM_OPTION
SET		ARCUSFIL_PROGRAM_OPTION_MODEL=''
WHERE	ARCUSFIL_PROGRAM_OPTION_MODEL like '%--%'

UPDATE	ARCUSFIL_PROGRAM_OPTION
SET		ARCUSFIL_PROGRAM_OPTION_YEAR=''
WHERE	ARCUSFIL_PROGRAM_OPTION_YEAR like '%--%'

UPDATE	ARCUSFIL_PROGRAM_OPTION
SET		ARCUSFIL_PROGRAM_OPTION_MAKER=''
WHERE	ARCUSFIL_PROGRAM_OPTION_MAKER like '%--%'