-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_DOCUMENT
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210203
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02Pruebas]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_INDEX_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_APQP_INDEX_HDR]
GO
--		 EXECUTE [dbo].[PG_LI_APQP_INDEX_HDR] 0,139,	1
CREATE PROCEDURE [dbo].[PG_LI_APQP_INDEX_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR			INT
AS
	DECLARE  @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_APQP_TEAM_SUMMARY		DECIMAL(10,4)=0--			,@VP_F_COMPLETED_TEAM		DATE
			,@VP_APQP_TOOL_SUMMARY		DECIMAL(10,4)=0--			,@VP_F_COMPLETED_TOOL		DATE
			,@VP_APQP_QUAL_SUMMARY		DECIMAL(10,4)=0--			,@VP_F_COMPLETED_QUAL		DATE
			,@VP_APQP_FLOOR_SUMMARY		DECIMAL(10,4)=0--			,@VP_F_COMPLETED_FLOOR		DATE
			,@VP_APQP_FLOW_SUMMARY		DECIMAL(10,4)=0--			,@VP_F_COMPLETED_FLOW		DATE
			,@VP_APQP_PFMEA_SUMMARY		DECIMAL(10,4)=0--			,@VP_F_COMPLETED_PFMEA		DATE
			,@VP_APQP_CONTROL_SUMMARY	DECIMAL(10,4)=0--			,@VP_F_COMPLETED_CONTROL	DATE
			,@VP_APQP_RISK_SUMMARY		DECIMAL(10,4)=0--			,@VP_F_COMPLETED_RISK		DATE
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================

	DECLARE	@PP_TABLA_INDEX	AS TABLE
	(	K_TIPO_DOCUMENTO		INT
		,D_TIPO_DOCUMENTO		VARCHAR(250)
		,S_TIPO_DOCUMENTO		VARCHAR(50)
		,O_TIPO_DOCUMENTO		INT NOT NULL DEFAULT 10
		,SUMMARY				DECIMAL(10,2) NOT NULL DEFAULT 0
		--,F_COMPLETED			DATE	DEFAULT NULL
	)

	SELECT	TOP(1)	@VP_APQP_TEAM_SUMMARY		= APQP_TEAM_SUMMARY		FROM APQP_TEAM_HDR		WHERE	K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR	ORDER BY K_APQP_TEAM_HDR		ASC
	SELECT	TOP(1)	@VP_APQP_TOOL_SUMMARY		= APQP_TOOL_SUMMARY		FROM APQP_TOOL_HDR		WHERE	K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR	ORDER BY K_APQP_TOOL_HDR		ASC
	SELECT	TOP(1)	@VP_APQP_QUAL_SUMMARY		= APQP_QUAL_SUMMARY		FROM APQP_QUAL_HDR		WHERE	K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR	ORDER BY K_APQP_QUAL_HDR		ASC
	SELECT	TOP(1)	@VP_APQP_FLOOR_SUMMARY		= APQP_FLOOR_SUMMARY	FROM APQP_FLOOR_HDR		WHERE	K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR	ORDER BY K_APQP_FLOOR_HDR		ASC
	SELECT	TOP(1)	@VP_APQP_FLOW_SUMMARY		= APQP_FLOW_SUMMARY		FROM APQP_FLOW_HDR		WHERE	K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR	ORDER BY K_APQP_FLOW_HDR		ASC
	SELECT	TOP(1)	@VP_APQP_PFMEA_SUMMARY		= APQP_PFMEA_SUMMARY	FROM APQP_PFMEA_HDR		WHERE	K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR	ORDER BY K_APQP_PFMEA_HDR		ASC
	SELECT	TOP(1)	@VP_APQP_CONTROL_SUMMARY	= APQP_CONTROL_SUMMARY	FROM APQP_CONTROL_HDR	WHERE	K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR	ORDER BY K_APQP_CONTROL_HDR		ASC
	SELECT	TOP(1)	@VP_APQP_RISK_SUMMARY		= APQP_RISK_SUMMARY		FROM APQP_RISK_HDR		WHERE	K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR	ORDER BY K_APQP_RISK_HDR		ASC

	-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	SET NOCOUNT ON
	INSERT INTO	@PP_TABLA_INDEX	
	(	 K_TIPO_DOCUMENTO
		,D_TIPO_DOCUMENTO
		,S_TIPO_DOCUMENTO
		,O_TIPO_DOCUMENTO
		,SUMMARY		
	)	VALUES
	( 1	, 'TEAM FEASIBILITY COMMITMENT'									, 'TEAM'	, 80 , @VP_APQP_TEAM_SUMMARY		)	,
	( 2	, 'A-3 NEW EQUIPMENT, TOOLING, AND TEST EQUIPMENT CHECKLIST'	, 'TOOL'	, 10 , @VP_APQP_TOOL_SUMMARY		)	,
	( 3	, 'A-4 PRODUCT/PROCESS QUALITY CHECKLIST'						, 'QUAL'	, 20 , @VP_APQP_QUAL_SUMMARY		)	,
	( 4	, 'A-5 FLOOR PLAN CHECKLIST'									, 'FLOOR'	, 30 , @VP_APQP_FLOOR_SUMMARY		)	,
	( 5	, 'A-6 PROCESS FLOW CHART CHECKLIST'							, 'FLOW'	, 40 , @VP_APQP_FLOW_SUMMARY		)	,
	( 6	, 'A-7 PROCESS FMEA CHECKLIST'									, 'PFMEA'	, 50 , @VP_APQP_PFMEA_SUMMARY		)	,
	( 7	, 'A-8 CONTROL PLAN CHECKLIST'									, 'CONTROL'	, 60 , @VP_APQP_CONTROL_SUMMARY		)	,
	( 8	, 'INITIAL RISK EVALUATION CHECKLIST'							, 'RISK'	, 70 , @VP_APQP_RISK_SUMMARY		)
															
	SET NOCOUNT OFF
	-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	SELECT * FROM @PP_TABLA_INDEX	ORDER BY O_TIPO_DOCUMENTO
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / SELECCION EL LISTADO A CONSULTAR
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_APQP_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_APQP_HDR]
GO
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	0,1
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	10,1
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	20,1
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	30,1
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	40,1
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	50,1
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	60,1
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	70,1
--		 EXECUTE [dbo].[PG_SK_APQP_HDR] 0,139,	80,1
CREATE PROCEDURE [dbo].[PG_SK_APQP_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_LISTADO					INT,
	@PP_K_APQP_MODEL_HDR			INT
AS
	-- /////////////////////////////////////////////////////////////////////

	IF @PP_K_LISTADO	=	0
	BEGIN	
		EXECUTE [dbo].[PG_SK_APQP_MODEL_HDR]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END
	
	ELSE IF @PP_K_LISTADO	=	10
	BEGIN
		EXECUTE [dbo].[PG_SK_APQP_TEAM_HDR]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END

	ELSE IF @PP_K_LISTADO	=	20
	BEGIN
		EXECUTE [dbo].[PG_SK_APQP_TOOL_HDR]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END

	ELSE IF @PP_K_LISTADO	=	30
	BEGIN
		EXECUTE [dbo].[PG_SK_APQP_QUAL_HDR]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END

	ELSE IF @PP_K_LISTADO	=	40
	BEGIN
		EXECUTE [dbo].[PG_SK_APQP_FLOOR_HDR]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END

	ELSE IF @PP_K_LISTADO	=	50
	BEGIN
		EXECUTE [dbo].[PG_SK_APQP_FLOW_HDR]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END

	ELSE IF @PP_K_LISTADO	=	60
	BEGIN
		EXECUTE [dbo].[PG_SK_APQP_PFMEA_HDR]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END

	ELSE IF @PP_K_LISTADO	=	70
	BEGIN
		EXECUTE [dbo].[PG_SK_APQP_CONTROL_HDR]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END

	ELSE IF @PP_K_LISTADO	=	80
	BEGIN
		EXECUTE [dbo].[PG_SK_APQP_RISK_HDR]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_MODEL_HDR										
	END
	-- /////////////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / SELECCION EL LISTADO A CONSULTAR
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_APQP_DET]
GO
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	0,1
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	10,1
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	20,1
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	30,1
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	40,1
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	50,1
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	60,1
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	70,1
--		 EXECUTE [dbo].[PG_LI_APQP_DET] 0,139,	80,1
CREATE PROCEDURE [dbo].[PG_LI_APQP_DET]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_LISTADO					INT,
	@PP_K_APQP_HDR					INT
AS
	-- /////////////////////////////////////////////////////////////////////
	
	IF @PP_K_LISTADO	=	0
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_INDEX_HDR]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END

	ELSE IF @PP_K_LISTADO	=	10
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_TEAM_DET]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END

	ELSE IF @PP_K_LISTADO	=	20
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_TOOL_DET]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END

	ELSE IF @PP_K_LISTADO	=	30
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_QUAL_DET]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END

	ELSE IF @PP_K_LISTADO	=	40
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_FLOOR_DET]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END

	ELSE IF @PP_K_LISTADO	=	50
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_FLOW_DET]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END

	ELSE IF @PP_K_LISTADO	=	60
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_PFMEA_DET]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END

	ELSE IF @PP_K_LISTADO	=	70
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_CONTROL_DET]	@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END

	ELSE IF @PP_K_LISTADO	=	80
	BEGIN
		EXECUTE	[dbo].[PG_LI_APQP_RISK_DET]		@PP_K_SISTEMA_EXE,	@PP_K_USUARIO_ACCION,
												-- ===========================
												@PP_K_APQP_HDR
	END
	-- /////////////////////////////////////////////////////////////////////
GO



---- //////////////////////////////////////////////////////////////
---- //////////////////////////////////////////////////////////////
---- //////////////////////////////////////////////////////////////