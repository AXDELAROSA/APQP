-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL_HDR
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210119
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_MODEL_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_APQP_MODEL_HDR]
GO
-- SELECT * FROM APQP_MODEL_HDR
-- EXECUTE [dbo].[PG_LI_APQP_MODEL_HDR] 0,139,-1
CREATE PROCEDURE [dbo].[PG_LI_APQP_MODEL_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(200)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================
	SELECT		TOP (5000)
				D_STATUS_APQP_MODEL, D_APQP_MODEL_HDR_TYPE,
				S_STATUS_APQP_MODEL, S_APQP_MODEL_HDR_TYPE,
				APQP_MODEL_HDR.*
				-- =============================	
	FROM		APQP_MODEL_HDR
	INNER JOIN	STATUS_APQP_MODEL			ON	STATUS_APQP_MODEL.K_STATUS_APQP_MODEL=APQP_MODEL_HDR.K_STATUS_APQP_MODEL
	INNER JOIN	APQP_MODEL_HDR_TYPE			ON	APQP_MODEL_HDR_TYPE.K_APQP_MODEL_HDR_TYPE=APQP_MODEL_HDR.K_APQP_MODEL_HDR_TYPE
				-- =============================
	WHERE		APQP_MODEL_HDR.L_BORRADO<>1
				-- =============================
	ORDER BY	D_APQP_MODEL_HDR DESC
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_MODEL_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_APQP_MODEL_DET]
GO
-- SELECT * FROM APQP_MODEL_DET
--		 EXECUTE [dbo].[PG_LI_APQP_MODEL_DET] 0,139,1
CREATE PROCEDURE [dbo].[PG_LI_APQP_MODEL_DET]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR			VARCHAR(200)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================
	SELECT		TOP(500)
				D_APQP_MODEL_ACTIVITY_LIST,
				RESPONSIBLE_APQP_MODEL_ACTIVITY_LIST,
				S_STATUS_APQP_MODEL,
				APQP_MODEL_DET.*
				-- =============================	
	FROM		APQP_MODEL_DET
	INNER JOIN	APQP_MODEL_HDR				ON	APQP_MODEL_DET.K_APQP_MODEL_HDR=APQP_MODEL_HDR.K_APQP_MODEL_HDR
	INNER JOIN	APQP_MODEL_ACTIVITY_LIST	ON	APQP_MODEL_DET.K_APQP_MODEL_ACTIVITY_LIST=APQP_MODEL_ACTIVITY_LIST.K_APQP_MODEL_ACTIVITY_LIST
	INNER JOIN	STATUS_APQP_MODEL			ON	APQP_MODEL_DET.K_STATUS_APQP_MODEL=STATUS_APQP_MODEL.K_STATUS_APQP_MODEL
				-- =============================
	WHERE		APQP_MODEL_HDR.L_BORRADO<>1
	AND			APQP_MODEL_DET.K_APQP_MODEL_HDR=@PP_K_APQP_MODEL_HDR
				-- =============================
	ORDER BY	K_APQP_MODEL_ACTIVITY_LIST
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_APQP_MODEL_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_APQP_MODEL_HDR]
GO
--		 EXECUTE [dbo].[PG_SK_APQP_MODEL_HDR] 0,139,32
CREATE PROCEDURE [dbo].[PG_SK_APQP_MODEL_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR			INT
AS
	-- ///////////////////////////////////////////
	SELECT		TOP (1)
				D_STATUS_APQP_MODEL, D_APQP_MODEL_HDR_TYPE,
				S_STATUS_APQP_MODEL, S_APQP_MODEL_HDR_TYPE,
				APQP_MODEL_HDR.*
				-- =============================	
	FROM		APQP_MODEL_HDR
	INNER JOIN	STATUS_APQP_MODEL			ON	STATUS_APQP_MODEL.K_STATUS_APQP_MODEL=APQP_MODEL_HDR.K_STATUS_APQP_MODEL
	INNER JOIN	APQP_MODEL_HDR_TYPE			ON	APQP_MODEL_HDR_TYPE.K_APQP_MODEL_HDR_TYPE=APQP_MODEL_HDR.K_APQP_MODEL_HDR_TYPE
				-- =============================
	WHERE		APQP_MODEL_HDR.K_APQP_MODEL_HDR=@PP_K_APQP_MODEL_HDR
				-- =============================
	ORDER BY	D_APQP_MODEL_HDR DESC
	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_APQP_MODEL_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_APQP_MODEL_HDR]
GO
--		 EXECUTE [dbo].[PG_IN_APQP_MODEL_HDR] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_APQP_MODEL_HDR]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_D_APQP_MODEL_HDR				VARCHAR(200),
	@PP_C_APQP_MODEL_HDR				VARCHAR(500),
	-- ============================
	@PP_K_STATUS_APQP_MODEL				INT,
	@PP_K_APQP_MODEL_HDR_TYPE			INT,
	-- ============================
	@PP_APQP_MODEL_HDR_NUMBER			VARCHAR(200),
	@PP_F_APQP_MODEL_HDR_CREATED		DATE
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_K_APQP_MODEL_HDR			INT = 0
BEGIN TRANSACTION 
BEGIN TRY
	---- /////////////////////////////////////////////////////////////////////
	-- ===========================
	INSERT INTO APQP_MODEL_HDR
			(	[D_APQP_MODEL_HDR],				[C_APQP_MODEL_HDR],
				-- ===========================
				[K_STATUS_APQP_MODEL],			[K_APQP_MODEL_HDR_TYPE],
				-- ===========================
				[APQP_MODEL_HDR_NUMBER],		[F_APQP_MODEL_HDR_CREATED],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
	VALUES	
			(	@PP_D_APQP_MODEL_HDR,			@PP_C_APQP_MODEL_HDR,
				-- ============================
				@PP_K_STATUS_APQP_MODEL,		@PP_K_APQP_MODEL_HDR_TYPE,
				-- ============================
				@PP_APQP_MODEL_HDR_NUMBER,		@PP_F_APQP_MODEL_HDR_CREATED,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

		IF @@ROWCOUNT = 0
		BEGIN
			--SET @VP_MENSAJE='El APQP_MODEL_HDR no fue insertado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@VP_K_APQP_MODEL_HDR)+']'
			SET @VP_MENSAJE='The record was not inserted.'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		ELSE
		BEGIN
			SELECT @VP_K_APQP_MODEL_HDR=SCOPE_IDENTITY()

			IF @VP_K_APQP_MODEL_HDR=NULL
			BEGIN
				--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
				SET @VP_MENSAJE='The record was not inserted.(identity)'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
		END

	EXECUTE	[dbo].[PG_IN_APQP_MODEL_DET]	@PP_K_SISTEMA_EXE	,@PP_K_USUARIO_ACCION,
											-- ===========================
											@VP_K_APQP_MODEL_HDR,	@PP_K_APQP_MODEL_HDR_TYPE

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

	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_APQP_MODEL_HDR AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_APQP_MODEL_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_APQP_MODEL_DET]
GO
--		 EXECUTE [dbo].[PG_IN_APQP_MODEL_DET] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_APQP_MODEL_DET]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR				INT,
	@PP_K_APQP_MODEL_HDR_TYPE			INT
	--@PP_L_APQP_MODEL_ACTIVITY_LIST_01	INT	= 0,
	--@PP_L_APQP_MODEL_ACTIVITY_LIST_02	INT	= 0,
	--@PP_L_APQP_MODEL_ACTIVITY_LIST_03	INT	= 0,
	--@PP_L_APQP_MODEL_ACTIVITY_LIST_04	INT = 0
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_K_APQP_MODEL_HDR			INT = 0
---===================================================================================================================================================
	--	PARA LA CREACIÓN DE LA CONSULTA DINAMICA	

	DECLARE	@TA_RESULTADOS_SELECT	AS TABLE
		(	TA_K_APQP_MODEL_ACTIVITY_LIST	INT		)

	DECLARE @VP_STR_SQL					NVARCHAR(MAX)

		SET @VP_STR_SQL = ' SELECT '
						+	' K_APQP_MODEL_ACTIVITY_LIST'
						+	' FROM	APQP_MODEL_ACTIVITY_LIST'
					
		IF @PP_K_APQP_MODEL_HDR_TYPE	= 10
		BEGIN
			SET @VP_STR_SQL =	@VP_STR_SQL +	'	WHERE	L_APQP_MODEL_TYPE_01	= 1'
		END
		ELSE IF @PP_K_APQP_MODEL_HDR_TYPE	= 20
		BEGIN
			SET @VP_STR_SQL =	@VP_STR_SQL +	'	WHERE	L_APQP_MODEL_TYPE_02	= 1'
		END
		ELSE IF @PP_K_APQP_MODEL_HDR_TYPE	= 30
		BEGIN
			SET @VP_STR_SQL =	@VP_STR_SQL +	'	WHERE	L_APQP_MODEL_TYPE_03	= 1'
		END
		ELSE IF @PP_K_APQP_MODEL_HDR_TYPE	= 40
		BEGIN
			SET @VP_STR_SQL =	@VP_STR_SQL +	'	WHERE	L_APQP_MODEL_TYPE_04	= 1'
		END
		-- ==========================================	
		INSERT INTO @TA_RESULTADOS_SELECT
		EXECUTE sp_executesql @VP_STR_SQL
---===================================================================================================================================================
---===================================================================================================================================================
---===================================================================================================================================================	
	DECLARE @VP_CU_K_ACTIVITY_LIST INT
	DECLARE CU_LISTA_ACTIVIDADES CURSOR FOR  
		SELECT	*	FROM @TA_RESULTADOS_SELECT
	OPEN			CU_LISTA_ACTIVIDADES;  
	FETCH NEXT FROM CU_LISTA_ACTIVIDADES INTO @VP_CU_K_ACTIVITY_LIST;
	WHILE @@FETCH_STATUS = 0  
	   BEGIN
			---- /////////////////////////////////////////////////////////////////////
			INSERT INTO APQP_MODEL_DET
				(	[K_APQP_MODEL_HDR],
					[K_APQP_MODEL_ACTIVITY_LIST],
					-- ===========================
					[F_APQP_MODEL_DET_CREATED],
					[K_STATUS_APQP_MODEL],
					-- ===========================
					[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
					[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
			VALUES
				(	@PP_K_APQP_MODEL_HDR,
					@VP_CU_K_ACTIVITY_LIST,
					-- ===========================
					GETDATE(),
					10,
					-- ===========================
					@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
					0, NULL, NULL  )
			
			IF @@ROWCOUNT = 0
			BEGIN
				SET @VP_MENSAJE='The record was not inserted.' + ' [' +	CONVERT(VARCHAR(10),@VP_CU_K_ACTIVITY_LIST)	+ ']'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
			ELSE
			BEGIN
				SELECT @VP_K_APQP_MODEL_HDR=SCOPE_IDENTITY()

				IF @VP_K_APQP_MODEL_HDR=NULL
				BEGIN
					--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
					SET @VP_MENSAJE='The record was not inserted.(identity)' + ' [' +	CONVERT(VARCHAR(10),@VP_CU_K_ACTIVITY_LIST)	+ ']'
					RAISERROR (@VP_MENSAJE, 16, 1 )
				END
			END
			-- /////////////////////////////////////////////////////////////////////
	      FETCH NEXT FROM CU_LISTA_ACTIVIDADES INTO @VP_CU_K_ACTIVITY_LIST;  
	   END;  
	CLOSE		CU_LISTA_ACTIVIDADES;  
	DEALLOCATE	CU_LISTA_ACTIVIDADES;  
	GO
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_APQP_MODEL_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_APQP_MODEL_HDR]
GO
-- EXECUTE [dbo].[PG_UP_APQP_MODEL_HDR] 0,139,  1 , 21 , 'TELFONO IP' , '76855545649' , '' , 'PANASONIC' , 'KX-T7630' , '2,890.50' , 1 , 1 , 11 , 1
CREATE PROCEDURE [dbo].[PG_UP_APQP_MODEL_HDR]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR				INT,
	@PP_D_APQP_MODEL_HDR				VARCHAR(200),
	@PP_C_APQP_MODEL_HDR				VARCHAR(500),
	-- ============================
	@PP_K_STATUS_APQP_MODEL				INT,
	@PP_K_APQP_MODEL_HDR_TYPE			INT,
	-- ============================
	@PP_APQP_MODEL_HDR_NUMBER			VARCHAR(200),
	@PP_F_APQP_MODEL_HDR_CREATED		DATE
AS			
DECLARE @VP_MENSAJE					VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_RN_APQP_MODEL_HDR_UPDATE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_APQP_MODEL_HDR, 
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE<>''
	BEGIN
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	EXECUTE [dbo].[PG_RN_APQP_MODEL_HDR_UNIQUE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_APQP_MODEL_HDR, @PP_D_APQP_MODEL_HDR,
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	
		-- //////////////////////////////////////////////////////////////
	IF @VP_MENSAJE<>''
	BEGIN
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END

	UPDATE	APQP_MODEL_HDR
	SET		[D_APQP_MODEL_HDR]				= @PP_D_APQP_MODEL_HDR,
			[C_APQP_MODEL_HDR]				= @PP_C_APQP_MODEL_HDR,
			-- ===========================	= -- ============================
			[K_STATUS_APQP_MODEL]			= @PP_K_STATUS_APQP_MODEL,
			[K_APQP_MODEL_HDR_TYPE]			= @PP_K_APQP_MODEL_HDR_TYPE,
			-- ===========================	= -- ============================
			[APQP_MODEL_HDR_NUMBER]			= @PP_APQP_MODEL_HDR_NUMBER,
			[F_APQP_MODEL_HDR_CREATED]		= @PP_F_APQP_MODEL_HDR_CREATED,
			-- ====================		
			[F_CAMBIO]						= GETDATE(), 
			[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
	WHERE	K_APQP_MODEL_HDR=@PP_K_APQP_MODEL_HDR
	
	IF @@ROWCOUNT = 0
	BEGIN
		--DECLARE @VP_ERROR_2 VARCHAR(250)='El APQP_MODEL_HDR no fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
		SET @VP_MENSAJE='The record was not Updated.'
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


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
--  EXECUTE [dbo].[PG_SK_APQP_MODEL_HDR] 0,139,9
--	EXECUTE [dbo].[PG_DL_APQP_MODEL_HDR] 0,139,9
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_APQP_MODEL_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_APQP_MODEL_HDR]
GO

CREATE PROCEDURE [dbo].[PG_DL_APQP_MODEL_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR						INT
AS
DECLARE @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	--/////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_RN_APQP_MODEL_HDR_DELETE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
											@PP_K_APQP_MODEL_HDR, 
											@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	--////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		BEGIN		
		UPDATE	APQP_MODEL_HDR
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_APQP_MODEL_HDR=@PP_K_APQP_MODEL_HDR
	
		IF @@ROWCOUNT = 0
			BEGIN
				--DECLARE @VP_ERROR_2 VARCHAR(250)='No fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
				SET @VP_MENSAJE='The record was not inserted.'
				RAISERROR (@VP_MENSAJE, 16, 1 ) 
			END
		
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

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////