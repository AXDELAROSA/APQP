-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			CUSTOMER
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CUSTOMER_SELLER]') AND type in (N'U'))
	DROP TABLE [dbo].[CUSTOMER_SELLER]
GO


-- ////////////////////////////////////////////////////////////////
-- //					CUSTOMER_SELLER				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[CUSTOMER_SELLER] (
	[K_CUSTOMER_SELLER]				[INT]			NOT NULL,
	[D_CUSTOMER_SELLER]				[VARCHAR](100)	NOT NULL,
	[C_CUSTOMER_SELLER]				[VARCHAR](255)	NOT NULL,
	[S_CUSTOMER_SELLER]				[VARCHAR](10)	NOT NULL,
	[O_CUSTOMER_SELLER]				[INT]			NOT NULL,
	[L_CUSTOMER_SELLER]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[CUSTOMER_SELLER]
	ADD CONSTRAINT [PK_CUSTOMER_SELLER]
		PRIMARY KEY CLUSTERED ([K_CUSTOMER_SELLER])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CUSTOMER_SELLER_01_DESCRIPCION] 
	   ON [dbo].[CUSTOMER_SELLER] ( [D_CUSTOMER_SELLER] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CUSTOMER_SELLER]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CUSTOMER_SELLER]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - CUSTOMER_SELLER
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_CUSTOMER_SELLER]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_CUSTOMER_SELLER				INT,
	@PP_D_CUSTOMER_SELLER				VARCHAR(100),
	@PP_C_CUSTOMER_SELLER				VARCHAR(255),
	@PP_S_CUSTOMER_SELLER				VARCHAR(10),
	@PP_O_CUSTOMER_SELLER				INT,
	@PP_L_CUSTOMER_SELLER				INT
AS				
	-- ===========================
	INSERT INTO CUSTOMER_SELLER
			(	[K_CUSTOMER_SELLER], [D_CUSTOMER_SELLER], 
				[C_CUSTOMER_SELLER], [S_CUSTOMER_SELLER], 
				[O_CUSTOMER_SELLER], [L_CUSTOMER_SELLER]		)
	VALUES	
			(	@PP_K_CUSTOMER_SELLER, @PP_D_CUSTOMER_SELLER, 
				@PP_C_CUSTOMER_SELLER, @PP_S_CUSTOMER_SELLER,
				@PP_O_CUSTOMER_SELLER, @PP_L_CUSTOMER_SELLER	 )
GO

EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,01, 'AUSTRALIA',							'', 'AUS',			010	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,02, 'NORTH AMERICA',						'', 'NAM',			020	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,03, 'BMW',									'', 'BMW',			030	,1
EXECUTE [DBO].[PG_CI_CUSTOMER_SELLER] 0,139,04, 'MISSING SALES PERSON KEEP!',			'', 'MSPKP!',		040	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,05, 'ASIA',									'', 'ASIA',			050	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,06, 'NEW ZEALAND',							'', 'NZ',			060	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,07, 'SOUTH AFRICA',							'', 'SA',			070	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,08, 'OTHER',								'', 'OTHR',			080	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,09, 'DISTINCTIVE USA',						'', 'DSTUSA',		090	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,10, 'LEAR THAILAND',						'', 'THLEAR',		100	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SELLER] 0,139,11, 'JCI CHINA',							'', 'CNJCI',		110	,1
-- =================================================================================
GO
