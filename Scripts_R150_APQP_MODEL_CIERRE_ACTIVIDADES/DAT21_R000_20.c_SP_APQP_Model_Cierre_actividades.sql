-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL_CIERRE_ACTIVIDADES
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210330
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02]
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO MODELOS POR CLIENTE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_APQP_CLOSE_ACTIVITY]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_APQP_CLOSE_ACTIVITY]
GO
--		 EXECUTE [dbo].[PG_UP_APQP_CLOSE_ACTIVITY] 0,139,	53
--		 EXECUTE [dbo].[PG_UP_APQP_CLOSE_ACTIVITY] 0,139,	54
--		 EXECUTE [dbo].[PG_UP_APQP_CLOSE_ACTIVITY] 0,139,	58
CREATE PROCEDURE [dbo].[PG_UP_APQP_CLOSE_ACTIVITY]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR			INT,
	@PP_K_QUOTE_TRIM_LEVEL			INT
AS
	DECLARE  @VP_MENSAJE				NVARCHAR(MAX)	= ''
			,@VP_FECHA					VARCHAR(250)	= ''			
BEGIN TRANSACTION 
BEGIN TRY
	-- ///////////////////////////////////////////	
	SELECT	@VP_FECHA						= F_APQP_MODEL_DET_COMPLETED
	FROM	APQP_MODEL_DET
	WHERE	[K_APQP_MODEL_HDR]				= @PP_K_APQP_MODEL_HDR			
	AND		[K_APQP_MODEL_ACTIVITY_LIST]	= 3	

	-- =========================================	-- =========================================
	IF ( @VP_FECHA	= '' )	OR ( @VP_FECHA IS NULL )
	BEGIN
		UPDATE	APQP_MODEL_DET
		SET		[F_APQP_MODEL_DET_COMPLETED]	= GETDATE(),
				[F_CAMBIO]						= GETDATE(),
				[K_STATUS_APQP_MODEL]			= 11,
				[COMPLEMENT_APQP_MODEL]				= @PP_K_QUOTE_TRIM_LEVEL
		WHERE	[K_APQP_MODEL_HDR]				= @PP_K_APQP_MODEL_HDR			
		AND		[K_APQP_MODEL_ACTIVITY_LIST]	= 3	--@PP_K_APQP_MODEL_ACTIVITY_LIST
	END
	ELSE
	BEGIN
		UPDATE	APQP_MODEL_DET
		SET		[F_CAMBIO]						= GETDATE(),
				[K_STATUS_APQP_MODEL]			= 11,
				[COMPLEMENT_APQP_MODEL]				= @PP_K_QUOTE_TRIM_LEVEL
		WHERE	[K_APQP_MODEL_HDR]				= @PP_K_APQP_MODEL_HDR			
		AND		[K_APQP_MODEL_ACTIVITY_LIST]	= 3	--@PP_K_APQP_MODEL_ACTIVITY_LIST
	END
	
	IF @@ROWCOUNT = 0
	BEGIN
		SET @VP_MENSAJE='The record was not updated. Activity (3)'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	-- /////////////////////////////////////////////////////////////////////

COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
		BEGIN
			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
		END

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_APQP_MODEL_HDR AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


---- //////////////////////////////////////////////////////////////
---- // STORED PROCEDURE ---> SELECT / LISTADO MODELOS POR CLIENTE
---- //////////////////////////////////////////////////////////////
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_MODEL_QUOTE_X_CUSTOMER]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_LI_APQP_MODEL_QUOTE_X_CUSTOMER]
--GO
----		 EXECUTE [dbo].[PG_LI_APQP_MODEL_QUOTE_X_CUSTOMER] 0,139,	53
----		 EXECUTE [dbo].[PG_LI_APQP_MODEL_QUOTE_X_CUSTOMER] 0,139,	54
----		 EXECUTE [dbo].[PG_LI_APQP_MODEL_QUOTE_X_CUSTOMER] 0,139,	58
--CREATE PROCEDURE [dbo].[PG_LI_APQP_MODEL_QUOTE_X_CUSTOMER]
--	@PP_K_SISTEMA_EXE				INT,
--	@PP_K_USUARIO_ACCION			INT,
--	-- ===========================
--	@PP_K_CUSTOMER						INT
--AS
--	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
--	-- ///////////////////////////////////////////
--	-- =========================================	-- =========================================
--	SELECT	S_QUOTE_TRIM_LEVEL, D_QUOTE_TRIM_LEVEL
--	FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_TRIM_LEVEL
--	INNER JOIN	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE	ON QUOTE.K_QUOTE	=QUOTE_TRIM_LEVEL.K_QUOTE 
--	WHERE	K_CUSTOMER= @PP_K_CUSTOMER
--	AND		QUOTE_TRIM_LEVEL.L_BORRADO <> 1
--	GROUP BY	S_QUOTE_TRIM_LEVEL, D_QUOTE_TRIM_LEVEL
--	ORDER BY	S_QUOTE_TRIM_LEVEL
--	-- /////////////////////////////////////////////////////////////////////
--GO

---- //////////////////////////////////////////////////////////////
---- //////////////////////////////////////////////////////////////
---- // STORED PROCEDURE ---> SELECT / LISTADO VERSIONES PO MODELO
---- //////////////////////////////////////////////////////////////
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_VERSIONES_X_MODELO]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_LI_APQP_VERSIONES_X_MODELO]
--GO
----		 EXECUTE [dbo].[PG_LI_APQP_VERSIONES_X_MODELO] 0,139, 54,'GWS'
--CREATE PROCEDURE [dbo].[PG_LI_APQP_VERSIONES_X_MODELO]
--	@PP_K_SISTEMA_EXE				INT,
--	@PP_K_USUARIO_ACCION			INT,
--	-- ==============================================
--	@PP_K_CUSTOMER					INT,
--	@PP_S_MODELO					VARCHAR(50)
--AS
--	DECLARE @VP_LI_N_REGISTROS			INT	= 5000	
--	-- ///////////////////////////////////////////
--		SELECT	
--				K_QUOTE_TRIM_LEVEL,
--				VERSION_NO,		D_VERSION,
--				PBD_REFERENCE,	VOLUME,
--				S_STATUS_QUOTE_TRIM_LEVEL,
--				(CASE
--					WHEN L_PRECIO_CORTE = 1 THEN 'YES'
--					ELSE	'NO'
--				END
--				) AS L_PRECIO_CORTE_LETRAS
--		FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_TRIM_LEVEL
--		INNER JOIN	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE					ON QUOTE.K_QUOTE	=QUOTE_TRIM_LEVEL.K_QUOTE 
--		INNER JOIN COT19_COTIZACIONES_V9999_R0.DBO.STATUS_QUOTE_TRIM_LEVEL	ON QUOTE_TRIM_LEVEL.K_STATUS_QUOTE_TRIM_LEVEL=STATUS_QUOTE_TRIM_LEVEL.K_STATUS_QUOTE_TRIM_LEVEL
--		WHERE	K_CUSTOMER			= @PP_K_CUSTOMER
--		AND		S_QUOTE_TRIM_LEVEL	= @PP_S_MODELO
--		AND		QUOTE_TRIM_LEVEL.L_BORRADO <> 1
--		ORDER BY	S_QUOTE_TRIM_LEVEL				,STATUS_QUOTE_TRIM_LEVEL.K_STATUS_QUOTE_TRIM_LEVEL
--					,QUOTE_TRIM_LEVEL.VERSION_NO	,K_QUOTE_TRIM_LEVEL

--	-- /////////////////////////////////////////////////////////////////////
--	-- /////////////////////////////////////////////////////////////////////
--GO
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////