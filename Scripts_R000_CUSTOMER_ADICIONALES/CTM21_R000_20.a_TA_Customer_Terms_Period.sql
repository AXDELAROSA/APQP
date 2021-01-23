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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CUSTOMER_TERMS_PERIOD]') AND type in (N'U'))
	DROP TABLE [dbo].[CUSTOMER_TERMS_PERIOD]
GO


-- ////////////////////////////////////////////////////////////////
-- //					CUSTOMER_TERMS_PERIOD				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[CUSTOMER_TERMS_PERIOD] (
	[K_CUSTOMER_TERMS_PERIOD]				[INT]			NOT NULL,
	[D_CUSTOMER_TERMS_PERIOD]				[VARCHAR](100)	NOT NULL,
	[C_CUSTOMER_TERMS_PERIOD]				[VARCHAR](255)	NOT NULL,
	[S_CUSTOMER_TERMS_PERIOD]				[VARCHAR](10)	NOT NULL,
	[O_CUSTOMER_TERMS_PERIOD]				[INT]			NOT NULL,
	[L_CUSTOMER_TERMS_PERIOD]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[CUSTOMER_TERMS_PERIOD]
	ADD CONSTRAINT [PK_CUSTOMER_TERMS_PERIOD]
		PRIMARY KEY CLUSTERED ([K_CUSTOMER_TERMS_PERIOD])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CUSTOMER_TERMS_PERIOD_01_DESCRIPCION] 
	   ON [dbo].[CUSTOMER_TERMS_PERIOD] ( [D_CUSTOMER_TERMS_PERIOD] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CUSTOMER_TERMS_PERIOD]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - CUSTOMER_TERMS_PERIOD
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_CUSTOMER_TERMS_PERIOD				INT,
	@PP_D_CUSTOMER_TERMS_PERIOD				VARCHAR(100),
	@PP_C_CUSTOMER_TERMS_PERIOD				VARCHAR(255),
	@PP_S_CUSTOMER_TERMS_PERIOD				VARCHAR(10),
	@PP_O_CUSTOMER_TERMS_PERIOD				INT,
	@PP_L_CUSTOMER_TERMS_PERIOD				INT
AS				
	-- ===========================
	INSERT INTO CUSTOMER_TERMS_PERIOD
			(	[K_CUSTOMER_TERMS_PERIOD], [D_CUSTOMER_TERMS_PERIOD], 
				[C_CUSTOMER_TERMS_PERIOD], [S_CUSTOMER_TERMS_PERIOD], 
				[O_CUSTOMER_TERMS_PERIOD], [L_CUSTOMER_TERMS_PERIOD]		)
	VALUES	
			(	@PP_K_CUSTOMER_TERMS_PERIOD, @PP_D_CUSTOMER_TERMS_PERIOD, 
				@PP_C_CUSTOMER_TERMS_PERIOD, @PP_S_CUSTOMER_TERMS_PERIOD,
				@PP_O_CUSTOMER_TERMS_PERIOD, @PP_L_CUSTOMER_TERMS_PERIOD	 )
GO

EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,00, '( TO DEFINE )',					'', '2DFINE'	,000	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,01, '5 DAYS',							'', '5DAYS'		,010	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,02, '7 DAYS ',						'', '7DAYS'		,020	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,03, '10 DAYS',						'', '10DAYS'	,030	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,04, '14 DAYS',						'', '14DAYS'	,040	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,05, '15 DAYS',						'', '15DAYS'	,050	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,06, '25 DAYS',						'', '25DAYS'	,060	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,07, '30 DAYS',						'', '30DAYS'	,070	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,08, '40 DAYS',						'', '40DAYS'	,080	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,09, '45 DAYS',						'', '45DAYS'	,090	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,10, '50 DAYS',						'', '50DAYS'	,100	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,12, '60 DAYS',						'', '60DAYS'	,120	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,13, '64 DAYS',						'', '64DAYS'	,130	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,14, 'CSH AGAINST DOC',				'', 'CAD'		,140	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_TERMS_PERIOD] 0,139,15, 'CASH ON DELIVER',				'', 'COD'		,150	,1
-- =================================================================================
GO