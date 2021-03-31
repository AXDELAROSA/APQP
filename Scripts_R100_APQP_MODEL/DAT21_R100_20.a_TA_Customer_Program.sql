-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210122
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ARCUSFIL_PROGRAM]') AND type in (N'U'))
	DROP TABLE [dbo].[ARCUSFIL_PROGRAM]
GO

--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ARCUSFIL_PROGRAM_OPTION]') AND type in (N'U'))
--	DROP TABLE [dbo].[ARCUSFIL_PROGRAM_OPTION]
--GO


---- ////////////////////////////////////////////////////////////////
---- //					ARCUSFIL_PROGRAM_OPTION				 
---- ////////////////////////////////////////////////////////////////

--CREATE TABLE [dbo].[ARCUSFIL_PROGRAM_OPTION] (
--	[K_ARCUSFIL_PROGRAM_OPTION]				[INT]			IDENTITY (1,1)	NOT NULL,
--	[D_ARCUSFIL_PROGRAM_OPTION]				[VARCHAR](255)	NOT NULL,
--	[S_ARCUSFIL_PROGRAM_OPTION]				[VARCHAR](20)	NOT NULL,
--	-- ===========================
--	[K_ARCUSFIL_PROGRAM]					[INT]			NOT NULL,
--	-- ===========================
--	[ARCUSFIL_PROGRAM_OPTION_MODEL]			[VARCHAR](255)	NOT NULL DEFAULT '',
--	[ARCUSFIL_PROGRAM_OPTION_YEAR]			[VARCHAR](20)	NOT NULL DEFAULT '',
--	[ARCUSFIL_PROGRAM_OPTION_MAKER]			[VARCHAR](255)	NOT NULL DEFAULT '',
--) ON [PRIMARY]
--GO
---- //////////////////////////////////////////////////////
--ALTER TABLE [dbo].[ARCUSFIL_PROGRAM_OPTION]
--	ADD CONSTRAINT [PK_ARCUSFIL_PROGRAM_OPTION]
--		PRIMARY KEY CLUSTERED ([K_ARCUSFIL_PROGRAM_OPTION])
--GO
--ALTER TABLE [dbo].[ARCUSFIL_PROGRAM_OPTION]
--ADD
--			[K_USUARIO_ALTA]					[INT] NOT NULL,
--			[F_ALTA]							[DATETIME] NOT NULL,
--			[K_USUARIO_CAMBIO]					[INT] NOT NULL,
--			[F_CAMBIO]							[DATETIME] NOT NULL,
--			[L_BORRADO]							[INT] NOT NULL,
--			[K_USUARIO_BAJA]					[INT] NULL,
--			[F_BAJA]							[DATETIME] NULL;
--GO


-- ////////////////////////////////////////////////////////////////
-- //					ARCUSFIL_PROGRAM				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ARCUSFIL_PROGRAM] (
	[K_ARCUSFIL_PROGRAM]				[INT]			IDENTITY (1,1)	NOT NULL,
	[D_ARCUSFIL_PROGRAM]				[VARCHAR](500)	NOT NULL,
	[S_ARCUSFIL_PROGRAM]				[VARCHAR](20)	NOT NULL,
	[O_ARCUSFIL_PROGRAM]				[INT]			NOT NULL DEFAULT 15,
	[L_ARCUSFIL_PROGRAM]				[INT]			NOT NULL DEFAULT 1,
	-- ===========================
	[K_ARCUSFIL]						[INT]			NOT NULL
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
	@PP_D_ARCUSFIL_PROGRAM				VARCHAR(500),
	-- ===========================
	@PP_K_ARCUSFIL						INT
	-- ===========================
AS
	-- ===========================
	INSERT INTO ARCUSFIL_PROGRAM
			(	[S_ARCUSFIL_PROGRAM],
				[D_ARCUSFIL_PROGRAM],
				-- ===========================
				[K_ARCUSFIL],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]		)
	VALUES	
			(	LTRIM(RTRIM(@PP_S_ARCUSFIL_PROGRAM)),
				LTRIM(RTRIM(@PP_D_ARCUSFIL_PROGRAM)),
				-- ===========================
				@PP_K_ARCUSFIL,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
	-- //////////////////////////////////////////////////////////////
GO
-- ===================================================================================================================
SET NOCOUNT OFF
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WD7','2021 WL DL 75 VPD',46
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '77H','U377 FORD HEADREST',1
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WDK','2021 WK WD 2ND ROW ARMREST',56
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WLE','2021 WL EISMANN',57
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'C3A','2021 WS BL-GL EEP 3RD ROW',51
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'C3B','2021 WS AL JEEP 3RD ROW',51
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'FW2','2021 WS JEEP SL NEVER QUILTED',51
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'FWS','2021 WS AL JEEP BASE',51
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'S3S','2021 WS SL JEEP 3RD ROW',51
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'S3U','2021 WS UL JEEP 3RD ROW',51
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WS3','2021 WS UL ALWAYS QUILTED',51
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'MCY','U364 MERCURY LTD FINDALY',5
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GAR','U388 LINCOLN ARMREST',40
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GR1','2021 WL 75 QUADS 2ND. ROW ARMR',54
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GR2','WS FOLDING 2ND-ROW ARM REST',54
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GRM','2021 WL 74/75 2ND. ROW ARMREST',54
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GW2','2021 WL 75 QUADS 2ND. ROW AR',54
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GWL','2021 WL 74/75 2ND. ROW ARMRE',54
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GWS','2021 WS GRAN WAGONNER',54
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '193','GMT 193 2007',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '87C','U387 FORD CUTTING EDGE',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '87P','U387 FORD PREMIUM',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '88A','U388 LINCOLN ARMREST',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '88H','U388 HEADREST',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '88L','U388 LINCOLN LIMITED',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GM1','GMT 191 PONTIAC TORRENT',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GM2','GMT 192 PONTIAC PERSUIT',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GM3','ARMREST GMT 193',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GXP','GMT 192 GXP 2008',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'JJT','2019 JEEP JT',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'JLI','2018 JEEP JL',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'JPH','2020 JEEP JL PHEV',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'JPS','2021 JEEP JL PHEV SUMMIT',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'JSU','JEEPJL SUMMIT',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'JTM','2019 JEEP JT MOJAVE',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'JTS','2021 JEEP JT SUMMIT',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'VFL','V229 FORD FREESTAR LTD',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'VML','V229 FREESTAR MERCURY LTD',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'VMP','V229 FREESTAR MPA',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'VMX','V229 FREESTAR MXA',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WLS','WLS JEEP 2020',7
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '191','GMT 191 2008',34
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '192','GMT 192 2008',34
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'ARM','ARMREST GMT 193',34
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'G93','GMT 193 2008',34
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GX2','GMT 192 GXP 2008',34
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL0','U388 CONSOLE',32
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '114','EN114 CONSOLE JCI',9
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'CHI','GM360 CHEVY / ISUZU /GMC CHINA',9
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'JCT','JCI-TESLA',9
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '228','U228 NAVIGATOR LUX/ULT',37
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '415','P415 PLATINIUM',37
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'BUI','GM 360 BUICK',37
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'CHE','GM 360 CHEVY / ISUZU / GMC',37
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'DEN','GM 360 DENALY',37
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GSS','GM 360 TRAILBLAZER SS',37
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'NAV','U228 NAVIGATOR LUX EDIASA 3',37
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'SAA','GM 360 SAAB',37
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'SHA','GM 360 CHEVY/ISUZU/GMC SHANGAI',38
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'SHI','GM360 CHEVY SHANGAI',38
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'KHE','U388 HEADREST',39
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '365','GMX 365 2008 FIXED',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'CAL','2013 S197 MUSTANG CALIFORNIA',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'G65','GMX365 BUICK LACROSSE',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'IUP','2013 S197 MUSTANG IUP',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PRM','2013 S197 MUSTANG PREMIUM',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'SH1','2013 S197 MUSTANG SHELBY 5B8',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'SH2','2013 S197 MUSTANG SHELBY TT',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'THL','2013 D258 TAURUS LTD',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'THO','2013 D258 TAURUS SHO & LIMITED',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'TSL','2013 D258 TAURUS SEL',13
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GMC','GMX 001 COUPE',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GX1','GMX 001 COUPE L4',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GXS','GMX001 SEDAN',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'HRM','U377 HEADREST 2010',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'MAZ','U377 MAZDA PREMIUM 2009',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'MP9','U377 MERCURY PREMIUM 2009',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL1','U377 FORD PREMIUM 11 PLM',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PLA','VN-127 FORD ECONOLINE',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U20','U204 MAZDA AIR BAG',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U2F','U204 FORD LTD AB',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U2L','U204 FORD LTD STD',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U2M','U204 MAZDA PREMIUM',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U37','U377 MERCURY LTD 2008',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U3L','U364 MERCURY LTD STD',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U3M','U377 MERCURY PREMIUM 2008',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U3P','U364 MCY PREMIUM',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U55','2019 U553 EXPEDITION',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U77','U377 FORD MONO TONE',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'UMA','U377 MAZDA PREMIUM 2008',17
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'W7A','2021 WL 74 AL',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'W7B','2021 WL 74 BL',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'W7C','2021 WL 74 CL 8W',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'W7D','2021 WL 74 DL',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'W7E','2021 WL 74 EC',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'W7S','2021 WL 74 SL',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'W7T','2021 WL 74 TL',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WAL','2021 WL 75 AL 8W LIMITED',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WC1','2021 WL 75 CL 12 WAY',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WCL','2021 WL 75 CL 8 WAY',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WDL','2021 WL 75 DL LIMITED',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WE6','2021 WL 75 E6',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WEC','2021 WL 75 EC SUMMIT',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WLB','2021 WL 75 BL OVERLAND',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WLK','2021 WL KL 8W BASE SRT',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WTL','2021 WL 75 TL 12 WAY',18
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '387','U387 FORD PREMIUM',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, '3SU','GMT 315 SUV',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'FCE','U387 FORD CUTTING EDGE',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'GRE','U387 FORD GREY',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'L88','U388 LINCOLN LIMITED',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL2','U387 FORD SEL 2011 PLM',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL3','U388 LINCOLN BASE 2012',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL4','D471 SEL 2012',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL5','D471 LTD 2012',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL6','U388 LINCOLN ULTIMATE',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL7','U387 FORD SEL 2012',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL7','U387 FORD SEL 2013',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL8','U387 FORD SPORT 2012',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PL9','U387 FORD SPORT 2011',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PLB','U388 HEADREST 2012',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PLC','D471 LTD PLATINIUM',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PLD','D471 SEL 2013',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PLE','D471 LTD 2013',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PLS','D471 2016 SALERNO',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'PVP','U387 FORD VPP',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'RDL','2021 RU DL PINNACLE',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'RUA','2016 RU OPCION AL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'RUE','2016 RU OPCION EL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'RUM','2016 RU OPCION ML',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'SI3','3NEWMODELSIS',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'SL3','2013 U387 SEL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'U54','U540 VINYL LAMINATION',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WBL','2017 WK BL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WD2','2017 WD ML DOS TONOS',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WDM','2017 WD ML',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WEL','2017 WK-EL RESERVE',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WKG','2014 WK JEEP GL/DL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WKJ','2017 WK CJ',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WKL','2015 WK KL ALTITUDE II',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WKT','2014 WK JEEP GL/DL TWO TONES',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WKU','2014 WK JEEP UL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WKY','2018 WK YL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WKZ','2014 WK DZ(SRT)',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WNL','2018 WK NL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WPL','2018 WD PL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WSL','2019 WS JEEP AL',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'XYZ','WK TEST',19
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'MYS','U388 HEADREST',41
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'THE','U228 NAVIGATOR HEADREST',27
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'RUP','2021 RU PINNACLE',36
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'WPI','2021 WPI WD CONSOLE LID',55
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'YWD','WS YANGFENG DOOR PANEL',53
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'YWS','2021 WS JEEP GRAND WAGONEER',53
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'YC4','2021 WL 74 JEEP GRAND CHEROKEE',58
EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM]  0, 0, 'YC5','2021 WL 75 JEEP GRAND CHEROKEE',58

SET NOCOUNT ON


--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]
--GO
---- //////////////////////////////////////////////////////////////
---- //				CI - ARCUSFIL_PROGRAM_OPTION
---- //////////////////////////////////////////////////////////////
--CREATE PROCEDURE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]
--	@PP_K_SISTEMA_EXE					INT,
--	@PP_K_USUARIO_ACCION				INT,
--	-- ===========================
--	@PP_K_ARCUSFIL_PROGRAM				INT,
--	-- ===========================
--	@PP_S_ARCUSFIL_PROGRAM_OPTION		VARCHAR(20),
--	@PP_D_ARCUSFIL_PROGRAM_OPTION		VARCHAR(255),
--	-- ===========================
--	@PP_ARCUSFIL_PROGRAM_OPTION_MODEL	VARCHAR(255),
--	@PP_ARCUSFIL_PROGRAM_OPTION_YEAR	VARCHAR(20),
--	@PP_ARCUSFIL_PROGRAM_OPTION_MAKER	VARCHAR(255)
--AS
--	-- ===========================
--	INSERT INTO ARCUSFIL_PROGRAM_OPTION
--			(	[D_ARCUSFIL_PROGRAM_OPTION],			
--				[S_ARCUSFIL_PROGRAM_OPTION],
--				-- ===========================
--				[K_ARCUSFIL_PROGRAM],
--				-- ===========================
--				[ARCUSFIL_PROGRAM_OPTION_MODEL],		[ARCUSFIL_PROGRAM_OPTION_YEAR],
--				[ARCUSFIL_PROGRAM_OPTION_MAKER],			
--				-- ===========================
--				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
--				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]		)
--	VALUES	
--			(	LTRIM(RTRIM(@PP_D_ARCUSFIL_PROGRAM_OPTION)),			
--				LTRIM(RTRIM(@PP_S_ARCUSFIL_PROGRAM_OPTION)),
--				-- ===========================
--				@PP_K_ARCUSFIL_PROGRAM,
--				-- ===========================
--				LTRIM(RTRIM(@PP_ARCUSFIL_PROGRAM_OPTION_MODEL)),		@PP_ARCUSFIL_PROGRAM_OPTION_YEAR,
--				LTRIM(RTRIM(@PP_ARCUSFIL_PROGRAM_OPTION_MAKER)),
--				-- ===========================
--				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
--				0, NULL, NULL  )	
--	-- //////////////////////////////////////////////////////////////
--GO

---- ===================================================================================================================
--SET NOCOUNT OFF
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		1,				'75 DL	',				'VPD						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		2,				'U377	',				'HEADREST					',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		3,				'WD		',				'2ND ROW ARMREST			',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		4,				'WL		',				'----						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		5,				'BL-GL	',				'3RD ROW     				',				'----			',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		5,				'AL		',				'3RD ROW       				',				'----			',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		5,				'SL		',				'NEVER QUILTED 				',				'----			',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		5,				'AL		',				'BASE          				',				'----			',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		5,				'SL		',				'3RD ROW       				',				'----			',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		5,				'UL		',				'3RD ROW       				',				'----			',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		5,				'UL		',				'ALWAYS QUILTED     		',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		6,				'LTD	',				'FINDALY					',				'MERCURY		',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		7,				'U388	',				'ARMREST          			',				'----			',		'----',				'LINCOLN	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		8,				'75		',				'QUADS 2ND. ROW ARMREST		',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		8,				'74/75	',				'2ND ROW ARMREST			',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		9,				'193	',				'----						',				'----			',		'2007',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		9,				'191	',				'TORRENT       				',				'PONTIAC		',		'----',				'GM			'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		9,				'192	',				'PERSUIT					',				'PONTIAC		',		'----',				'GM			'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		9,				'193	',				'ARMREST					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		9,				'192	',				'GXP						',				'----			',		'2008',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		12,				'JT     ',				'----						',				'----			',		'2019',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		12,				'JL		',				'----						',				'----			',		'2018',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		12,				'JL		',				'PHEV						',				'----			',		'2020',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		12,				'JL		',				'PHEV SUMMIT				',				'----			',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		12,				'JL		',				'SUMMIT						',				'----			',		'----',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		12,				'JT		',				'MOJAVE           			',				'----			',		'2019',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		12,				'JT		',				'SUMMIT						',				'----			',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		10,				'U387	',				'CUTTING EDGE				',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		10,				'U387	',				'PREMIUM					',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		11,				'U387	',				'ARMREST					',				'----			',		'----',				'LINCOLN	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		11,				'U387	',				'HEADREST					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		11,				'U387	',				'LIMITED          			',				'----			',		'----',				'LINCOLN	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		13,				'LTD	',				'----						',				'FREESTAR		',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		13,				'LTD	',				'----						',				'FREESTAR		',		'----',				'MERCURY	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		13,				'MPA	',				'----						',				'FREESTAR		',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		13,				'MXA	',				'----						',				'FREESTAR		',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		14,				'WL		',				'----						',				'----			',		'2020',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		15,				'191	',				'----						',				'----			',		'2008',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		15,				'192	',				'----						',				'----			',		'2008',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		15,				'193	',				'ARMREST					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		15,				'193	',				'----						',				'----			',		'2008',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		15,				'192	',				'GXP						',				'----			',		'2008',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		16,				'U388	',				'CONSOLE					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		18,				'CHINA	',				'CHEVY/ISUZU/GMC			',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		17,				'EN114	',				'CONSOLE					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		17,				'JCI	',				'----						',				'----			',		'----',				'TESLA		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		21,				'GM360	',				'----						',				'----			',		'----',				'BUICK		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		21,				'GM360	',				'CHEVY/ISUZU/GMC			',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		21,				'GM360	',				'----						',				'DENALY			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		21,				'GM360	',				'----						',				'TRAILBLAZER SS	',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		21,				'GM360	',				'----						',				'----			',		'----',				'SAAB		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		20,				'P415	',				'PLATINIUM					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		22,				'U228	',				'LUX						',				'NAVIGATOR		',		'----',				'LINCOLN	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		19,				'U288	',				'LUX/ULT					',				'NAVIGATOR		',		'----',				'LINCOLN	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		23,				'GM360	',				'CHEVY/ISUZU/GMC SHANGAI	',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		23,				'GM360	',				'SHANGAI					',				'CHEVY			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		24,				'U388	',				'HEADREST               	',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		27,				'LTD    ',				'----						',				'TAURUS			',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		27,				'D258	',				'SHO & LIMITED				',				'TAURUS			',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		27,				'SEL	',				'----						',				'TAURUS			',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		25,				'GMX365	',				'FIXED            			',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		25,				'GMX365	',				'----						',				'LACROSSE		',		'----',				'BUICK		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		26,				'S197	',				'CALIFORNIA					',				'MUSTANG		',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		26,				'IUP	',				'----						',				'MUSTANG		',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		26,				'PREMIUM',				'----						',				'MUSTANG		',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		26,				'5B8  	',				'----						',				'MUSTANG SHELBY	',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		26,				'TT		',				'----						',				'MUSTANG SHELBY	',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		28,				'001	',				'COUPE						',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		28,				'001	',				'COUPE L4					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		28,				'001	',				'SEDAN						',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		31,				'U204	',				'AIR BAG					',				'----			',		'----',				'MAZDA		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		31,				'LTD	',				'AB							',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		31,				'LTD	',				'STD						',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		31,				'U204	',				'PREMIUM					',				'----			',		'----',				'MAZDA		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		32,				'LTD	',				'STD						',				'----			',		'----',				'MERCURY	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		32,				'MCY	',				'PREMIUM					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		29,				'U377	',				'HEADREST					',				'----			',		'2010',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		29,				'U377	',				'PREMIUM					',				'----			',		'2009',				'MAZDA		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		29,				'U377	',				'PREMIUM					',				'----			',		'2009',				'MERCURY	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		29,				'PLM    ',				'PREMIUM					',				'----			',		'2011',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		29,				'LTD	',				'----						',				'----			',		'2008',				'MERCURY	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		29,				'U377	',				'PREMIUM					',				'----			',		'2008',				'MERCURY	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		29,				'U377	',				'MONO TONE					',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		29,				'U377	',				'PREMIUM					',				'----			',		'2008',				'MAZDA		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		33,				'U553	',				'----						',				'EXPEDITION		',		'2019',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		30,				'VN127	',				'ECONOLINE         			',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'74 AL	',				'----						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'74 BL	',				'----						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'74 CL	',				'8W							',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'74 DL	',				'----						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'74 EC	',				'----						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'74 SL	',				'----						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'74 TL	',				'----						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'75 AL	',				'8W LIMITED					',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'75 CL	',				'12 WAY						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'75 CL	',				'8 WAY						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'75 DL	',				'LIMITED					',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'75 EC	',				'SUMMIT						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'75 BL	',				'OVERLAND					',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'KL		',				'8W BASE SRT				',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		34,				'75 TL	',				'12 WAY						',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		38,				'D471	',				'SEL						',				'----			',		'2012',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		38,				'LTD	',				'----						',				'----			',		'2012',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		38,				'LTD	',				'----						',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		38,				'SEL	',				'----						',				'----			',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		38,				'LTD	',				'----						',				'----			',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		38,				'D471	',				'SALERNO					',				'----			',		'2016',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		36,				'315	',				'SUV						',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		39,				'DL		',				'PINNACLE					',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		39,				'AL		',				'----						',				'----			',		'2016',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		39,				'EL		',				'----						',				'----			',		'2016',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		39,				'ML		',				'----						',				'----			',		'2016',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'U387	',				'PREMIUM					',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'U387	',				'CUTTING EDGE				',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'U387	',				'GREY						',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'PLM    ',				'SEL						',				'----			',		'2011',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'SEL	',				'----						',				'----			',		'2012',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'SEL	',				'----						',				'----			',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'U387	',				'SPORT						',				'----			',		'2012',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'U387	',				'SPORT						',				'----			',		'2011',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'VPP	',				'----						',				'----			',		'----',				'FORD		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		35,				'SEL	',				'----						',				'----			',		'2013',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		37,				'U388	',				'LIMITED					',				'----			',		'----',				'LINCOLN	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		37,				'U388	',				'BASE						',				'----			',		'2012',				'LINCOLN	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		37,				'U388	',				'ULTIMATE					',				'----			',		'----',				'LINCOLN	'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		37,				'U388	',				'HEADREST					',				'----			',		'2012',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		40,				'U540	',				'VINYL LAMINATION			',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		42,				'ML		',				'DOS TONOS					',				'----			',		'2017',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		42,				'ML		',				'----						',				'----			',		'2017',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		42,				'PL		',				'----						',				'----			',		'2018',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'BL		',				'----						',				'----			',		'2017',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'EL		',				'RESERVE					',				'----			',		'2017',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'GL/DL	',				'----						',				'----			',		'2014',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'CJ		',				'----						',				'----			',		'2017',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'KL		',				'ALTITUDE II        		',				'----			',		'2015',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'GL/DL	',				'TWO TONES					',				'----			',		'2014',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'UL		',				'----						',				'----			',		'2014',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'YL		',				'----						',				'----			',		'2018',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'DZ		',				'SRT						',				'----			',		'2014',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'NL		',				'----						',				'----			',		'2018',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		41,				'YL     ',				'----						',				'----			',		'2018',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		43,				'AL     ',				'2019 WS JEEP AL        	',				'----			',		'2019',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		44,				'U388	',				'HEADREST					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		45,				'U228	',				'HEADREST					',				'NAVIGATOR		',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		46,				'RU		',				'PINNACLE					',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		47,				'WD		',				'CONSOLE LID				',				'----			',		'2021',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		48,				'WS		',				'DOOR PANEL					',				'----			',		'----',				'----		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		48,				'WS		',				'----						',				'GRAND WAGONEER	',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		49,				'74		',				'----						',				'GRAND CHEROKEE	',		'2021',				'JEEP		'
--EXECUTE [dbo].[PG_CI_ARCUSFIL_PROGRAM_OPTION]  0, 0,		49,				'75		',				'----						',				'GRAND CHEROKEE	',		'2021',				'JEEP		'
--SET NOCOUNT ON
--GO

--UPDATE	ARCUSFIL_PROGRAM_OPTION
--SET		D_ARCUSFIL_PROGRAM_OPTION=''
--WHERE	D_ARCUSFIL_PROGRAM_OPTION like '%--%'

--UPDATE	ARCUSFIL_PROGRAM_OPTION
--SET		ARCUSFIL_PROGRAM_OPTION_MODEL=''
--WHERE	ARCUSFIL_PROGRAM_OPTION_MODEL like '%--%'

--UPDATE	ARCUSFIL_PROGRAM_OPTION
--SET		ARCUSFIL_PROGRAM_OPTION_YEAR=''
--WHERE	ARCUSFIL_PROGRAM_OPTION_YEAR like '%--%'

--UPDATE	ARCUSFIL_PROGRAM_OPTION
--SET		ARCUSFIL_PROGRAM_OPTION_MAKER=''
--WHERE	ARCUSFIL_PROGRAM_OPTION_MAKER like '%--%'