-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			PO_CUSTOMER_HDR
-- // OPERATION:		TABLE
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

-- USE [DATA_02Pruebas]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PO_CUSTOMER_DET]') AND type in (N'U'))
	DROP TABLE [dbo].[PO_CUSTOMER_DET]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PO_CUSTOMER_HDR]') AND type in (N'U'))
	DROP TABLE [dbo].[PO_CUSTOMER_HDR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STATUS_PO_CUSTOMER]') AND type in (N'U'))
	DROP TABLE [dbo].[STATUS_PO_CUSTOMER]
GO


-- ////////////////////////////////////////////////////////////////
-- //					STATUS_PO_CUSTOMER				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[STATUS_PO_CUSTOMER] (
	[K_STATUS_PO_CUSTOMER]				[INT]			NOT NULL,
	[D_STATUS_PO_CUSTOMER]				[VARCHAR](100)	NOT NULL,
	[C_STATUS_PO_CUSTOMER]				[VARCHAR](255)	NOT NULL,
	[S_STATUS_PO_CUSTOMER]				[VARCHAR](10)	NOT NULL,
	[O_STATUS_PO_CUSTOMER]				[INT]			NOT NULL,
	[L_STATUS_PO_CUSTOMER]				[INT]			NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[STATUS_PO_CUSTOMER]
	ADD CONSTRAINT [PK_STATUS_PO_CUSTOMER]
		PRIMARY KEY CLUSTERED ([K_STATUS_PO_CUSTOMER])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_STATUS_PO_CUSTOMER_01_DESCRIPCION] 
	   ON [dbo].[STATUS_PO_CUSTOMER] ( [D_STATUS_PO_CUSTOMER] )
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_STATUS_PO_CUSTOMER]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_STATUS_PO_CUSTOMER]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - STATUS_PO_CUSTOMER
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_STATUS_PO_CUSTOMER]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_STATUS_PO_CUSTOMER				INT,
	@PP_D_STATUS_PO_CUSTOMER				VARCHAR(100),
	@PP_C_STATUS_PO_CUSTOMER				VARCHAR(255),
	@PP_S_STATUS_PO_CUSTOMER				VARCHAR(10),
	@PP_O_STATUS_PO_CUSTOMER				INT,
	@PP_L_STATUS_PO_CUSTOMER				INT
AS				
	-- ===========================
	INSERT INTO STATUS_PO_CUSTOMER
			(	[K_STATUS_PO_CUSTOMER], [D_STATUS_PO_CUSTOMER], 
				[C_STATUS_PO_CUSTOMER], [S_STATUS_PO_CUSTOMER], 
				[O_STATUS_PO_CUSTOMER], [L_STATUS_PO_CUSTOMER]		)
	VALUES	
			(	@PP_K_STATUS_PO_CUSTOMER, @PP_D_STATUS_PO_CUSTOMER, 
				@PP_C_STATUS_PO_CUSTOMER, @PP_S_STATUS_PO_CUSTOMER,
				@PP_O_STATUS_PO_CUSTOMER, @PP_L_STATUS_PO_CUSTOMER	 )
GO

EXECUTE [dbo].[PG_CI_STATUS_PO_CUSTOMER] 0,139,00, 'CANCEL',						'', 'CANCL', 00,0		-- ACTUALIZA QUIEN LA GENERA
-- =================================================================================
EXECUTE [dbo].[PG_CI_STATUS_PO_CUSTOMER] 0,139,01, 'ACTIVE',						'', 'ACTVE', 10,1		-- ESTATUS INICIAL
EXECUTE [dbo].[PG_CI_STATUS_PO_CUSTOMER] 0,139,01, 'INACTIVE',						'', 'INACT', 20,1		-- INNACTIVAR REGISTRO
-- =================================================================================
GO


-- ////////////////////////////////////////////////////////////////
-- //					PURCHASE_ORDER				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PO_CUSTOMER_HDR] (
	[K_PO_CUSTOMER_HDR]						[INT] IDENTITY (1,1)	NOT NULL,
	-- ============================													-- INFORMACIÓN REFERENTE AL CLIENTE
	[K_CUSTOMER]							[INT] NOT NULL,
	[PO_CUSTOMER_NO]						[VARCHAR](50) NOT NULL,
	[PO_CUSTOMER_REVISION_NO]				[VARCHAR](50) NOT NULL,
	[C_PO_CUSTOMER]							[VARCHAR](255) NOT NULL DEFAULT '',
	[K_STATUS_PO_CUSTOMER]					[INT] NOT NULL,
	[D_PO_CUSTOMER_NO_BILL_TO]				[INT] NOT NULL,
	[D_PO_CUSTOMER_NO_SHIP_TO]				[INT] NOT NULL,
	-- ============================													-- TERMINOS DE ENTREGA Y PUNTOS ESTABLECIDOS
	[K_CURRENCY]							[INT] NOT NULL,
	[K_TERMS]								[INT] NOT NULL,
	[K_CUSTOMER_TERMS_PERIOD]				[INT] NOT NULL,
	[K_FOB_POINT]							[INT] NOT NULL,
	[K_FREIGHT_CHARGES_01]					[INT] NOT NULL,
	[K_TAXABLE]								[INT] NOT NULL,
	-- ============================													-- FECHAS DE PO
	[F_DATE_PO_CUSTOMER]					[DATE] NOT NULL,
	[F_EFFECTIVE_PO_CUSTOMER]				[DATE] NOT NULL,
	[L_EXPIRE_PO_CUSTOMER]					[INT]  NOT NULL DEFAULT 0,
	[F_EXPIRE_PO_CUSTOMER]					[DATE] NULL	DEFAULT NULL,
	-- ============================													-- INFORMACIÓN DE INVOLUCRADOS
	[ISSUED_BY_PO_CUSTOMER]					[VARCHAR] (150) NOT NULL,
	[REQUIRED_PO_CUSTOMER]					[VARCHAR] (150) NOT NULL,
	[CONFIRMING_ORDER_WITH]					[VARCHAR] (150) NOT NULL,
	-- ============================													--	CAMPOS EXCLUSIVOS POR TIPO DE CLIENTE
	-- ============================													--	IRVIN
	-- [D_SHIP_VIA]							[VARCHAR](500) NOT NULL DEFAULT '',
	-- [D_FREIGHT TERMS]					[VARCHAR](500) NOT NULL DEFAULT '',
	-- ============================
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[PO_CUSTOMER_HDR]
	ADD CONSTRAINT [PK_PO_CUSTOMER_HDR]
		PRIMARY KEY CLUSTERED ([K_PO_CUSTOMER_HDR])	
GO


ALTER TABLE [dbo].[PO_CUSTOMER_HDR] ADD 
	CONSTRAINT [FK_STATUS_PO_CUSTOMER_01] 
		FOREIGN KEY ( K_STATUS_PO_CUSTOMER ) 
		REFERENCES [dbo].[STATUS_PO_CUSTOMER] (K_STATUS_PO_CUSTOMER )
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[PO_CUSTOMER_HDR] 
	ADD		[K_USUARIO_ALTA]			[INT] NOT NULL,
			[F_ALTA]					[DATETIME] NOT NULL,
			[K_USUARIO_CAMBIO]			[INT] NOT NULL,
			[F_CAMBIO]					[DATETIME] NOT NULL,
			[L_BORRADO]					[INT] NOT NULL,
			[K_USUARIO_BAJA]			[INT] NULL,
			[F_BAJA]					[DATETIME] NULL;
GO


-- ////////////////////////////////////////////////////////////////
-- //					PO_CUSTOMER_DET				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PO_CUSTOMER_DET] (
	[K_PO_CUSTOMER_DET]						[INT] IDENTITY (1,1)	NOT NULL,
	[K_PO_CUSTOMER_HDR]						[INT] NOT NULL,
	-- ============================
	[K_QUOTE_TRIM_LEVEL]					[INT] NOT NULL
	-- ============================
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[PO_CUSTOMER_DET] ADD 
	CONSTRAINT [FK_PO_CUSTOMER_HDR_01] 
		FOREIGN KEY ( K_PO_CUSTOMER_HDR ) 
		REFERENCES [dbo].[PO_CUSTOMER_HDR] (K_PO_CUSTOMER_HDR )
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////

