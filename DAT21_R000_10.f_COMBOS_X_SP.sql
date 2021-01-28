-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			DATA_02
-- // OPERATION:		CARGA COMBO
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_ARCUSFIL
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> CONTINENTES
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_ARCUSFIL_CONTINENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_ARCUSFIL_CONTINENTE]
GO
--		 EXECUTE [dbo].[PG_CB_ARCUSFIL_CONTINENTE] 0,139,1
CREATE PROCEDURE [dbo].[PG_CB_ARCUSFIL_CONTINENTE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT	= 0
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_CONTINENTE			AS K_COMBOBOX,
				D_CONTINENTE			AS D_COMBOBOX
	FROM	BD_GENERAL.DBO.CONTINENTE
	WHERE	L_CONTINENTE =	1
	AND		L_BORRADO=0
	ORDER BY D_CONTINENTE


	IF @PP_L_CON_TODOS=1
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( SELECT ONE OPTION )'	)
	END
	ELSE IF @PP_L_CON_TODOS=2
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( ALL )'	)
	END

		SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
					TA_D_CATALOGO	AS D_COMBOBOX 
		FROM		@VP_TA_CATALOGO
		ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO

-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_ARCUSFIL
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> PARA CARGAR LOS PAISES EN LA PANTALLA DE ARCUSFILS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_ARCUSFIL_COUNTRY]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_ARCUSFIL_COUNTRY]
GO
--		 EXECUTE [dbo].[PG_CB_ARCUSFIL_COUNTRY] 0,139,0,1
CREATE PROCEDURE [dbo].[PG_CB_ARCUSFIL_COUNTRY]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_CONTINENTE				INT,
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_COUNTRY				AS K_COMBOBOX,
				C_COUNTRY				AS D_COMBOBOX
	FROM	BD_GENERAL.DBO.COUNTRY
	WHERE	L_COUNTRY =	1
	AND		COUNTRY.K_CONTINENTE	= @PP_CONTINENTE
	AND		L_BORRADO=0
	ORDER BY D_COUNTRY


	IF @PP_L_CON_TODOS=1
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( SELECT ONE OPTION )'	)
	END
	ELSE IF @PP_L_CON_TODOS=2
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( ALL )'	)
	END

		SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
					TA_D_CATALOGO	AS D_COMBOBOX 
		FROM		@VP_TA_CATALOGO
		ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_ARCUSFIL
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> PARA CARGAR LOS ESTADOS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_ARCUSFIL_STATE_GEO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_ARCUSFIL_STATE_GEO]
GO
--		 EXECUTE [dbo].[PG_CB_ARCUSFIL_STATE_GEO] 0,139,150,1
CREATE PROCEDURE [dbo].[PG_CB_ARCUSFIL_STATE_GEO]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_COUNTRY					INT,
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_STATE_GEO				AS K_COMBOBOX,
				D_STATE_GEO				AS D_COMBOBOX
	FROM	BD_GENERAL.DBO.STATE_GEO
	WHERE	L_STATE_GEO =	1
	AND		K_COUNTRY	= @PP_COUNTRY
	AND		L_BORRADO=0
	ORDER BY D_STATE_GEO


	IF @PP_L_CON_TODOS=1
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( SELECT ONE OPTION )'	)
	END
	ELSE IF @PP_L_CON_TODOS=2
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( ALL )'	)
	END

		SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
					TA_D_CATALOGO	AS D_COMBOBOX 
		FROM		@VP_TA_CATALOGO
		ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_ARCUSFIL
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> PARA CARGAR LOS ESTADOS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_ARCUSFIL_ADDRES_TYPE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_ARCUSFIL_ADDRES_TYPE]
GO
--		 EXECUTE [dbo].[PG_CB_ARCUSFIL_ADDRES_TYPE] 0,139,1
CREATE PROCEDURE [dbo].[PG_CB_ARCUSFIL_ADDRES_TYPE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_ADDRESS_TYPE				AS K_COMBOBOX,
				D_ADDRESS_TYPE				AS D_COMBOBOX
	FROM	ADDRESS_TYPE
	WHERE	L_ADDRESS_TYPE =	1
	ORDER BY D_ADDRESS_TYPE


	IF @PP_L_CON_TODOS=1
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( SELECT ONE OPTION )'	)
	END
	ELSE IF @PP_L_CON_TODOS=2
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( ALL )'	)
	END

		SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
					TA_D_CATALOGO	AS D_COMBOBOX 
		FROM		@VP_TA_CATALOGO
		ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_APQP_MODEL_HDR
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> PARA CARGAR LOS ESTADOS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_STATUS_APQP_MODEL_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_STATUS_APQP_MODEL_HDR]
GO
--		 EXECUTE [dbo].[PG_CB_STATUS_APQP_MODEL_HDR] 0,139,0,10
--		 EXECUTE [dbo].[PG_CB_STATUS_APQP_MODEL_HDR] 0,139,0,20
CREATE PROCEDURE [dbo].[PG_CB_STATUS_APQP_MODEL_HDR]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT,
	@PP_K_STATUS_CLASS			INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_STATUS_APQP_MODEL				AS K_COMBOBOX,
				D_STATUS_APQP_MODEL				AS D_COMBOBOX
	FROM	STATUS_APQP_MODEL
	WHERE	L_STATUS_APQP_MODEL			= 1
	AND		K_STATUS_APQP_MODEL_CLASS	IN	(0, @PP_K_STATUS_CLASS)
	ORDER BY D_STATUS_APQP_MODEL


	IF @PP_L_CON_TODOS=1
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( SELECT ONE OPTION )'	)
	END
	ELSE IF @PP_L_CON_TODOS=2
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( ALL )'	)
	END

		SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
					TA_D_CATALOGO	AS D_COMBOBOX 
		FROM		@VP_TA_CATALOGO
		ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_APQP_MODEL_HDR
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> PARA CARGAR LOS ESTADOS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_APQP_MODEL_HDR_TYPE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_APQP_MODEL_HDR_TYPE]
GO
--		 EXECUTE [dbo].[PG_CB_APQP_MODEL_HDR_TYPE] 0,139,1
CREATE PROCEDURE [dbo].[PG_CB_APQP_MODEL_HDR_TYPE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_APQP_MODEL_HDR_TYPE				AS K_COMBOBOX,
				D_APQP_MODEL_HDR_TYPE				AS D_COMBOBOX
	FROM		APQP_MODEL_HDR_TYPE
	WHERE		L_APQP_MODEL_HDR_TYPE = 1
	ORDER BY	D_APQP_MODEL_HDR_TYPE


	IF @PP_L_CON_TODOS=1
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( SELECT ONE OPTION )'	)
	END
	ELSE IF @PP_L_CON_TODOS=2
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( ALL )'	)
	END

		SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
					TA_D_CATALOGO	AS D_COMBOBOX 
		FROM		@VP_TA_CATALOGO
		ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////