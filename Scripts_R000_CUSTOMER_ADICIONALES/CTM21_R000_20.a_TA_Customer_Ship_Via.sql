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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CUSTOMER_SHIP_VIA]') AND type in (N'U'))
	DROP TABLE [dbo].[CUSTOMER_SHIP_VIA]
GO
-- ////////////////////////////////////////////////////////////////
-- //					CUSTOMER_SHIP_VIA				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[CUSTOMER_SHIP_VIA] (
	[K_CUSTOMER_SHIP_VIA]				[INT]			NOT NULL,
	[D_CUSTOMER_SHIP_VIA]				[VARCHAR](100)	NOT NULL,
	[C_CUSTOMER_SHIP_VIA]				[VARCHAR](255)	NOT NULL,
	[S_CUSTOMER_SHIP_VIA]				[VARCHAR](10)	NOT NULL,
	[O_CUSTOMER_SHIP_VIA]				[INT]			NOT NULL,
	[L_CUSTOMER_SHIP_VIA]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[CUSTOMER_SHIP_VIA]
	ADD CONSTRAINT [PK_CUSTOMER_SHIP_VIA]
		PRIMARY KEY CLUSTERED ([K_CUSTOMER_SHIP_VIA])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CUSTOMER_SHIP_VIA_01_DESCRIPCION] 
	   ON [dbo].[CUSTOMER_SHIP_VIA] ( [D_CUSTOMER_SHIP_VIA] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CUSTOMER_SHIP_VIA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CUSTOMER_SHIP_VIA]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - CUSTOMER_SHIP_VIA
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_CUSTOMER_SHIP_VIA]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_CUSTOMER_SHIP_VIA				INT,
	@PP_D_CUSTOMER_SHIP_VIA				VARCHAR(100),
	@PP_C_CUSTOMER_SHIP_VIA				VARCHAR(255),
	@PP_S_CUSTOMER_SHIP_VIA				VARCHAR(10),
	@PP_O_CUSTOMER_SHIP_VIA				INT,
	@PP_L_CUSTOMER_SHIP_VIA				INT
AS				
	-- ===========================
	INSERT INTO CUSTOMER_SHIP_VIA
			(	[K_CUSTOMER_SHIP_VIA], [D_CUSTOMER_SHIP_VIA], 
				[C_CUSTOMER_SHIP_VIA], [S_CUSTOMER_SHIP_VIA], 
				[O_CUSTOMER_SHIP_VIA], [L_CUSTOMER_SHIP_VIA]		)
	VALUES	
			(	@PP_K_CUSTOMER_SHIP_VIA, @PP_D_CUSTOMER_SHIP_VIA, 
				@PP_C_CUSTOMER_SHIP_VIA, @PP_S_CUSTOMER_SHIP_VIA,
				@PP_O_CUSTOMER_SHIP_VIA, @PP_L_CUSTOMER_SHIP_VIA	 )
GO

EXECUTE [dbo].[PG_CI_CUSTOMER_SHIP_VIA] 0,139,01, 'AIR FREIGHT',						'', 'AF'	, 10	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SHIP_VIA] 0,139,02, 'AIR TO GERMANY',						'', 'AGR'	, 20	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SHIP_VIA] 0,139,03, 'EXPRESS POST',						'', 'EXP'	, 30	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SHIP_VIA] 0,139,04, 'LOCAL FREIGHT',						'', 'LOC'	, 40	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SHIP_VIA] 0,139,05, 'PLACE ON HORSES',					'', 'HRS'	, 50	,1
EXECUTE [dbo].[PG_CI_CUSTOMER_SHIP_VIA] 0,139,06, 'SEA FREIGHT',						'', 'SEA'	, 60	,1
-- =================================================================================
GO