-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			ARCUSFIL_PROGRAM
-- // OPERATION:		REGLAS NEGOCIO
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210122
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02]
GO
-- //////////////////////////////////////////////////////////////
-- //////		CONTENIDO DEL SP
--	[PG_RN_ARCUSFIL_PROGRAM_UNICO]
--	[PG_RN_ARCUSFIL_PROGRAM_ITS_DELETEABLE]
--	[PG_RN_ARCUSFIL_PROGRAM_EXISTE]
--	[PG_RN_ARCUSFIL_PROGRAM_ELIMINAR]
--	[PG_RN_ARCUSFIL_PROGRAM_ACTUALIZAR]
-- //////////////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_UNIQUE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_UNICO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_UNICO]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_UNICO]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL						[INT],
	@PP_K_ARCUSFIL_PROGRAM				[INT],
	@PP_S_ARCUSFIL_PROGRAM				[VARCHAR] (20)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	DECLARE @VP_N_ARCUSFIL_PROGRAM_X_D_ARCUSFIL_PROGRAM			INT		

	SELECT	@VP_N_ARCUSFIL_PROGRAM_X_D_ARCUSFIL_PROGRAM		 =		COUNT	(ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM)
	FROM	ARCUSFIL_PROGRAM					(NOLOCK)
	WHERE	K_ARCUSFIL							= @PP_K_ARCUSFIL
	AND		ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM <> @PP_K_ARCUSFIL_PROGRAM
	AND		ARCUSFIL_PROGRAM.S_ARCUSFIL_PROGRAM =  @PP_S_ARCUSFIL_PROGRAM

	-- /////////////////////////////////////////////////////
	IF @VP_N_ARCUSFIL_PROGRAM_X_D_ARCUSFIL_PROGRAM > 0
	BEGIN
			SET @VP_MENSAJE=  'El programa ya existe ['+@PP_S_ARCUSFIL_PROGRAM+']. //UNIQUE// '
			RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_ES_EDITABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ES_EDITABLE]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ES_EDITABLE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT]
	-- ===========================		
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''		
-- /////////////////////////////////////////////////////
	IF (
		SELECT	COUNT(K_QUOTE_TRIM_LEVEL) 
		FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_TRIM_LEVEL	(NOLOCK)
		WHERE	K_ARCUSFIL_PROGRAM		= @PP_K_ARCUSFIL_PROGRAM			) > 0
	BEGIN
		SET @VP_MENSAJE =  'El programa ya no se puede modificar, ya tiene modelos asignados, si desea realizar el cambio es necesario comunicarse a SISTEMAS para su revisión.'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_EXISTS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTE]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT]
	-- ===========================		
AS
	DECLARE @VP_MENSAJE					VARCHAR(300) = ''		
	-- /////////////////////////////////////////////////////
	DECLARE @VP_K_ARCUSFIL_PROGRAM		INT
	DECLARE @VP_L_BORRADO				INT
		
	SELECT	@VP_K_ARCUSFIL_PROGRAM	=		ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM,
			@VP_L_BORRADO			=		ARCUSFIL_PROGRAM.L_BORRADO
	FROM	ARCUSFIL_PROGRAM		(NOLOCK)
	WHERE	ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM	= @PP_K_ARCUSFIL_PROGRAM										
	-- /////////////////////////////////////////////////////	

	IF ( @VP_K_ARCUSFIL_PROGRAM IS NULL )
			SET @VP_MENSAJE=  'El programa no existe.'
			RAISERROR (@VP_MENSAJE, 16, 1 )
	-- ===========================
		IF @VP_L_BORRADO=1
			SET @VP_MENSAJE=  'El programa fue dado de baja.'
			RAISERROR (@VP_MENSAJE, 16, 1 )
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_DELETE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_ELIMINAR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ELIMINAR]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ELIMINAR]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT]
	-- ===========================
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_ARCUSFIL_PROGRAM
	-- ///////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ES_EDITABLE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_ARCUSFIL_PROGRAM
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_UPDATE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_ACTUALIZAR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ACTUALIZAR]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ACTUALIZAR]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT]
	-- ===========================
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_ARCUSFIL_PROGRAM
	-- ///////////////////////////////////////////
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ES_EDITABLE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_ARCUSFIL_PROGRAM
	-- /////////////////////////////////////////////////////
GO


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
