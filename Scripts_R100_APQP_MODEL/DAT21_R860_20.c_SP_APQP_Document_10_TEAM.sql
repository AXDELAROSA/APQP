-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_DOCUMENT
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210203
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02]
GO

---- //////////////////////////////////////////////////////////////
---- //////////////////////////////////////////////////////////////
---- // STORED PROCEDURE ---> SELECT / LISTADO
---- //////////////////////////////////////////////////////////////
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_TEAM_HDR]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_LI_APQP_TEAM_HDR]
--GO
----		 EXECUTE [dbo].[PG_LI_APQP_TEAM_HDR] 0,139,	1
--CREATE PROCEDURE [dbo].[PG_LI_APQP_TEAM_HDR]
--	@PP_K_SISTEMA_EXE				INT,
--	@PP_K_USUARIO_ACCION			INT,
--	-- ===========================
--	@PP_K_APQP_TEAM_HDR				INT
--AS
--	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
--	-- ///////////////////////////////////////////
--	-- =========================================	-- =========================================
--	SELECT		TOP (5000)
--				D_STATUS_APQP_DOCUMENT,
--				S_STATUS_APQP_DOCUMENT,
--				APQP_TEAM_HDR.*
--				-- =============================	
--	FROM		APQP_TEAM_HDR
--	INNER JOIN	STATUS_APQP_DOCUMENT			ON	STATUS_APQP_DOCUMENT.K_STATUS_APQP_DOCUMENT	= APQP_TEAM_HDR.K_STATUS_APQP_DOCUMENT
--				-- =============================
--	WHERE		APQP_TEAM_HDR.L_BORRADO<>1
--				-- =============================
--	AND			(	APQP_TEAM_HDR.K_APQP_TEAM_HDR = -1		OR APQP_TEAM_HDR.K_APQP_TEAM_HDR = @PP_K_APQP_TEAM_HDR	)
--	--ORDER BY	D_APQP_TEAM_HDR DESC
--	-- /////////////////////////////////////////////////////////////////////
--GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_TEAM_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_APQP_TEAM_DET]
GO
--		 EXECUTE [dbo].[PG_LI_APQP_TEAM_DET] 0,139,	1
CREATE PROCEDURE [dbo].[PG_LI_APQP_TEAM_DET]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_TEAM_HDR				INT
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================
	SELECT		--TOP (5000)
				K_APQP_TEAM_ACTIVITY_LIST_TYPE	AS K_TYPE,
				O_APQP_TEAM_DET					AS L_ESTATUS_CHECK,
				D_APQP_TEAM_ACTIVITY_LIST		AS D_LIST,
				L_APQP_TEAM_DET_YES				AS L_YES,
				L_APQP_TEAM_DET_NO				AS L_NO,
				K_APQP_TEAM_DET					AS K_DET,
				F_APQP_TEAM_DET_COMPLETED		AS F_DET,
				APQP_TEAM_DET.*
				-- =============================
	FROM		APQP_TEAM_DET
	INNER JOIN	APQP_TEAM_HDR			ON	APQP_TEAM_HDR.K_APQP_TEAM_HDR	= APQP_TEAM_DET.K_APQP_TEAM_HDR
	INNER JOIN	APQP_TEAM_ACTIVITY_LIST	ON	APQP_TEAM_ACTIVITY_LIST.K_APQP_TEAM_ACTIVITY_LIST	= APQP_TEAM_DET.K_APQP_TEAM_ACTIVITY_LIST
				-- =============================
	WHERE		APQP_TEAM_DET.L_BORRADO				<> 1
	AND			L_APQP_TEAM_ACTIVITY_LIST_VISIBLE	=  1
				-- =============================
	AND			APQP_TEAM_DET.K_APQP_TEAM_HDR						= @PP_K_APQP_TEAM_HDR
	ORDER BY	K_APQP_TEAM_ACTIVITY_LIST_TYPE,
				O_APQP_TEAM_ACTIVITY_LIST
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_APQP_TEAM_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_APQP_TEAM_HDR]
GO
--		 EXECUTE [dbo].[PG_SK_APQP_TEAM_HDR] 0,139,1
CREATE PROCEDURE [dbo].[PG_SK_APQP_TEAM_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_TEAM_HDR				INT
AS
	-- ///////////////////////////////////////////
	SELECT		TOP (1)
				D_STATUS_APQP_DOCUMENT,
				S_STATUS_APQP_DOCUMENT,
				APQP_TEAM_HDR.*,
				'TEAM FEASIBILITY COMMITMENT'	AS TITULO_REPORTE
				-- =============================	
	FROM		APQP_TEAM_HDR
	INNER JOIN	STATUS_APQP_DOCUMENT			ON	STATUS_APQP_DOCUMENT.K_STATUS_APQP_DOCUMENT	= APQP_TEAM_HDR.K_STATUS_APQP_DOCUMENT
				-- =============================
	WHERE		APQP_TEAM_HDR.L_BORRADO<>1
				-- =============================
	AND			APQP_TEAM_HDR.K_APQP_TEAM_HDR = @PP_K_APQP_TEAM_HDR
	--AND			APQP_TEAM_HDR.K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR
	-- ////////////////////////////////////////////////////////////////////
GO


---- //////////////////////////////////////////////////////////////
---- // STORED PROCEDURE ---> SELECT / FICHA
---- //////////////////////////////////////////////////////////////
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_APQP_TEAM_DET]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_SK_APQP_TEAM_DET]
--GO
----		 EXECUTE [dbo].[PG_SK_APQP_TEAM_DET] 0,139,1
--CREATE PROCEDURE [dbo].[PG_SK_APQP_TEAM_DET]
--	@PP_K_SISTEMA_EXE				INT,
--	@PP_K_USUARIO_ACCION			INT,
--	-- ===========================
--	@PP_K_APQP_TEAM_DET				INT
--AS
--	-- ///////////////////////////////////////////
--	SELECT		TOP (1)
--				APQP_TEAM_DET.*
--				-- =============================	
--	FROM		APQP_TEAM_DET
--	INNER JOIN	APQP_TEAM_HDR			ON	APQP_TEAM_HDR.K_APQP_TEAM_HDR	= APQP_TEAM_DET.K_APQP_TEAM_HDR
--				-- =============================
--	WHERE		APQP_TEAM_DET.L_BORRADO<>1
--				-- =============================
--	AND			APQP_TEAM_DET.K_APQP_TEAM_DET = @PP_K_APQP_TEAM_DET
--	-- ////////////////////////////////////////////////////////////////////
--GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_APQP_TEAM_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_APQP_TEAM_HDR]
GO
--		 EXECUTE [dbo].[PG_IN_APQP_TEAM_HDR] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_APQP_TEAM_HDR]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR				INT
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_K_APQP_TEAM_HDR			INT = 0
--BEGIN TRANSACTION 
--BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	-- ===========================
	INSERT INTO APQP_TEAM_HDR
			(	[K_APQP_MODEL_HDR],
				-- ===========================
				[K_STATUS_APQP_DOCUMENT],	
				[F_APQP_TEAM_HDR_CREATED],
				-- ===========================
				[L_APQP_TEAM_HDR_01],		[L_APQP_TEAM_HDR_02],
				[L_APQP_TEAM_HDR_03],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
	VALUES	
			(	@PP_K_APQP_MODEL_HDR,
				-- ============================
				20,	--	STATUS	#2	= INCOMPLETO
				GETDATE(),
				-- ============================
				0,							0,
				1,
				-- ============================
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
			SELECT @VP_K_APQP_TEAM_HDR=SCOPE_IDENTITY()

			IF @VP_K_APQP_TEAM_HDR=NULL
			BEGIN
				--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
				SET @VP_MENSAJE='The record was not inserted.(identity)'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
		END
	
	-- //////////////////////////////////////////////////////////////
	EXECUTE	[dbo].[PG_IN_APQP_TEAM_DET]	@PP_K_SISTEMA_EXE	,@PP_K_USUARIO_ACCION,
											-- ===========================
											@VP_K_APQP_TEAM_HDR
	-- /////////////////////////////////////////////////////////////////////
--COMMIT TRANSACTION 
--END TRY

--BEGIN CATCH
--	/* Ocurrió un error, deshacemos los cambios*/ 
--	ROLLBACK TRANSACTION
--	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
--	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
--	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
--END CATCH
	
--	IF @VP_MENSAJE<>''
--		BEGIN
--			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
--		END

--	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_APQP_TEAM_HDR AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_APQP_TEAM_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_APQP_TEAM_DET]
GO
--		 EXECUTE [dbo].[PG_IN_APQP_TEAM_DET] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_APQP_TEAM_DET]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_TEAM_HDR					INT
AS
	DECLARE @VP_MENSAJE								VARCHAR(300) = ''
			,@VP_K_APQP_MODEL_ACTIVITY_LIST			INT = 0
---===================================================================================================================================================
---===================================================================================================================================================
---===================================================================================================================================================
---===================================================================================================================================================	
	DECLARE  @VP_CU_K_ACTIVITY_TEAM_LIST		INT
			,@VP_O_APQP_TEAM_ACTIVITY_LIST		INT
	DECLARE CU_LISTA_ACTIVIDADES CURSOR FOR  
		SELECT	--*
				K_APQP_TEAM_ACTIVITY_LIST,
				O_APQP_TEAM_ACTIVITY_LIST
		FROM	APQP_TEAM_ACTIVITY_LIST
		WHERE	L_APQP_TEAM_ACTIVITY_LIST	= 1
		ORDER BY K_APQP_TEAM_ACTIVITY_LIST_TYPE, O_APQP_TEAM_ACTIVITY_LIST
	OPEN			CU_LISTA_ACTIVIDADES;  
	FETCH NEXT FROM CU_LISTA_ACTIVIDADES INTO @VP_CU_K_ACTIVITY_TEAM_LIST, @VP_O_APQP_TEAM_ACTIVITY_LIST;
	WHILE @@FETCH_STATUS = 0  
	   BEGIN
			---- /////////////////////////////////////////////////////////////////////
			INSERT INTO APQP_TEAM_DET
				(	[K_APQP_TEAM_HDR],
					[K_APQP_TEAM_ACTIVITY_LIST],
					-- ===========================
					[O_APQP_TEAM_DET],
					-- ===========================
					[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
					[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
			VALUES
				(	@PP_K_APQP_TEAM_HDR,
					@VP_CU_K_ACTIVITY_TEAM_LIST,
					-- ===========================
					@VP_O_APQP_TEAM_ACTIVITY_LIST,
					-- ===========================
					@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
					0, NULL, NULL  )
			
			IF @@ROWCOUNT = 0
			BEGIN
				SET @VP_MENSAJE='The record was not inserted.' + ' [' +	CONVERT(VARCHAR(10),@VP_CU_K_ACTIVITY_TEAM_LIST)	+ ']'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
			ELSE
			BEGIN
				SELECT @VP_K_APQP_MODEL_ACTIVITY_LIST=SCOPE_IDENTITY()

				IF @VP_K_APQP_MODEL_ACTIVITY_LIST=NULL
				BEGIN
					--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
					SET @VP_MENSAJE='The record was not inserted.(identity)' + ' [' +	CONVERT(VARCHAR(10),@VP_CU_K_ACTIVITY_TEAM_LIST)	+ ']'
					RAISERROR (@VP_MENSAJE, 16, 1 )
				END
			END
			-- /////////////////////////////////////////////////////////////////////
	      FETCH NEXT FROM CU_LISTA_ACTIVIDADES INTO @VP_CU_K_ACTIVITY_TEAM_LIST, @VP_O_APQP_TEAM_ACTIVITY_LIST;
	   END;  
	CLOSE		CU_LISTA_ACTIVIDADES;  
	DEALLOCATE	CU_LISTA_ACTIVIDADES;  
	GO
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_APQP_TEAM_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_APQP_TEAM_HDR]
GO
--		 EXECUTE [dbo].[PG_UP_APQP_TEAM_HDR] 0,139,		1,1,										
--														0,1,0,							
--														'2/3/4/5/6/7/8/9/10/11/12/13/14/15/16' , 
--														'1/1/1/0/0/0/0/0/0/0/0/0/0/0/0' , 
--														'0/0/0/0/0/0/0/0/0/0/0/0/0/0/0' , 
--														'0/0/0/0/0/0/0/0/0/0/0/0/0/0/0' 
CREATE PROCEDURE [dbo].[PG_UP_APQP_TEAM_HDR]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR				INT,
	@PP_K_APQP_TEAM_HDR					INT,
	-- ===========================
	--@PP_APQP_TEAM_HDR_RFQ				VARCHAR(255),
	-- ===========================
	@PP_L_APQP_TEAM_HDR_01				INT,
	@PP_L_APQP_TEAM_HDR_02				INT,
	@PP_L_APQP_TEAM_HDR_03				INT,
	@PP_ARRAY_DET_KL					NVARCHAR(MAX),
	@PP_ARRAY_DET_YS					NVARCHAR(MAX),
	@PP_ARRAY_DET_NO					NVARCHAR(MAX)
--	@PP_ARRAY_DET_NA					NVARCHAR(MAX)
AS			
DECLARE @VP_MENSAJE					VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	UPDATE	APQP_TEAM_HDR
	SET		-- ===========================	= -- ===========================
			--[APQP_TEAM_HDR_RFQ]				= @PP_APQP_TEAM_HDR_RFQ			,	
			-- ===========================	= -- ===========================	
			[L_APQP_TEAM_HDR_01]			= @PP_L_APQP_TEAM_HDR_01		,	
			[L_APQP_TEAM_HDR_02]			= @PP_L_APQP_TEAM_HDR_02		,	
			[L_APQP_TEAM_HDR_03]			= @PP_L_APQP_TEAM_HDR_03		,	
			-- ===========================	= -- ===========================
			[F_CAMBIO]						= GETDATE(), 
			[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
	WHERE	K_APQP_TEAM_HDR				= @PP_K_APQP_TEAM_HDR
	
	IF @@ROWCOUNT = 0
	BEGIN
		--DECLARE @VP_ERROR_2 VARCHAR(250)='El APQP_MODEL_HDR no fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
		SET @VP_MENSAJE='The record was not Updated.'
		RAISERROR (@VP_MENSAJE, 16, 1 ) 
	END

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE	[dbo].[PG_UP_APQP_TEAM_DET]		@PP_K_SISTEMA_EXE	,@PP_K_USUARIO_ACCION
											-- ===========================
											,@PP_ARRAY_DET_KL		,@PP_ARRAY_DET_YS
											,@PP_ARRAY_DET_NO		--,@PP_ARRAY_DET_NA


	-- /////////////////////////////////////////////////////////////////////
	DECLARE  @PP_K_STATUS_APQP_DOCUMENT		INT	=	0
			,@PP_TOTAL_ACTIVIDADES			DECIMAL(10,2)	=	0
			,@PP_TOTAL_COMPLETADAS			DECIMAL(10,2)	=	0
			,@PP_SUMMARY					DECIMAL(10,2)

	SELECT	@PP_TOTAL_COMPLETADAS	=	ISNULL(SUM(L_APQP_TEAM_DET_YES) + SUM(L_APQP_TEAM_DET_NO)	+ SUM(L_APQP_TEAM_DET_NA)	, 0)
	FROM	APQP_TEAM_DET
	WHERE	K_APQP_TEAM_HDR			=	@PP_K_APQP_TEAM_HDR

	SELECT	@PP_TOTAL_ACTIVIDADES	=	COUNT(K_APQP_TEAM_DET) 
	FROM	APQP_TEAM_DET
	INNER JOIN	APQP_TEAM_ACTIVITY_LIST	ON	APQP_TEAM_ACTIVITY_LIST.K_APQP_TEAM_ACTIVITY_LIST	=	APQP_TEAM_DET.K_APQP_TEAM_ACTIVITY_LIST
	WHERE	K_APQP_TEAM_HDR			=	@PP_K_APQP_TEAM_HDR
	AND		APQP_TEAM_ACTIVITY_LIST.L_APQP_TEAM_ACTIVITY_LIST_VISIBLE<>0
	AND		APQP_TEAM_DET.O_APQP_TEAM_DET	<>	0

		SET 	@PP_SUMMARY	=	(	@PP_TOTAL_COMPLETADAS	/	@PP_TOTAL_ACTIVIDADES	)	*	100
		
	IF	(	@PP_TOTAL_COMPLETADAS	)		>=	(	@PP_TOTAL_ACTIVIDADES	)
	BEGIN
		SET @PP_K_STATUS_APQP_DOCUMENT	= 10			--	STATUS: DOCUMENTO COMPLETADO

		UPDATE	APQP_MODEL_DET
		SET		 K_STATUS_APQP_MODEL			= 11	-- ACTIVIDAD CERRADA
				,L_APQP_MODEL_DET_COMPLETED		= 1
				,F_APQP_MODEL_DET_COMPLETED		= GETDATE()
				-- ===========================	= -- ===========================
				,[F_CAMBIO]						= GETDATE() 
				,[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
		WHERE	K_APQP_MODEL_ACTIVITY_LIST		= 4
		AND		K_APQP_MODEL_HDR				= @PP_K_APQP_MODEL_HDR

	END
	ELSE
	BEGIN
		SET @PP_K_STATUS_APQP_DOCUMENT	= 20		--	STATUS: DOCUMENTO NO COMPLETADO
		
		IF @PP_SUMMARY <= 0
		BEGIN

			UPDATE	APQP_MODEL_DET
			SET		 K_STATUS_APQP_MODEL			= 10	-- ACTIVIDAD ABIERTA
					,L_APQP_MODEL_DET_COMPLETED		= 0
					,F_APQP_MODEL_DET_COMPLETED		= NULL
					-- ===========================	= -- ===========================
					,[F_CAMBIO]						= GETDATE() 
					,[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
			WHERE	K_APQP_MODEL_ACTIVITY_LIST		= 4
			AND		K_APQP_MODEL_HDR				= @PP_K_APQP_MODEL_HDR
		END
		ELSE
		BEGIN
		UPDATE	APQP_MODEL_DET
		SET		 K_STATUS_APQP_MODEL			= 12	-- ACTIVIDAD EN PROCESO
				,L_APQP_MODEL_DET_COMPLETED		= 0
				,F_APQP_MODEL_DET_COMPLETED		= GETDATE()
				-- ===========================	= -- ===========================
				,[F_CAMBIO]						= GETDATE() 
				,[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
		WHERE	K_APQP_MODEL_ACTIVITY_LIST		= 4
		AND		K_APQP_MODEL_HDR				= @PP_K_APQP_MODEL_HDR
		END
	END

	IF @@ROWCOUNT = 0
		BEGIN
			--DECLARE @VP_ERROR_2 VARCHAR(250)='El APQP_MODEL_HDR no fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
			SET @VP_MENSAJE='The record was not Updated.(MODEL_DET)'
			RAISERROR (@VP_MENSAJE, 16, 1 ) 
		END
	-- ==================================================================================================================================================================
	-- ==================================================================================================================================================================

		UPDATE	APQP_TEAM_HDR
		SET		-- ===========================	= -- ===========================	
				[K_STATUS_APQP_DOCUMENT]		= @PP_K_STATUS_APQP_DOCUMENT,
				[APQP_TEAM_SUMMARY]				= @PP_SUMMARY
		WHERE	K_APQP_TEAM_HDR				= @PP_K_APQP_TEAM_HDR
	
		IF @@ROWCOUNT = 0
		BEGIN
			--DECLARE @VP_ERROR_2 VARCHAR(250)='El APQP_MODEL_HDR no fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
			SET @VP_MENSAJE='The record was not Updated.(MODEL_HDR)'
			RAISERROR (@VP_MENSAJE, 16, 1 ) 
		END
	-- ==================================================================================================================================================================
	-- ==================================================================================================================================================================


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

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_APQP_TEAM_HDR AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_APQP_TEAM_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_APQP_TEAM_DET]
GO
--		 EXECUTE [dbo].[PG_UP_APQP_TEAM_DET] 0,139,
CREATE PROCEDURE [dbo].[PG_UP_APQP_TEAM_DET]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_ARRAY_DET_KL					NVARCHAR(MAX),
	@PP_ARRAY_DET_YS					NVARCHAR(MAX),
	@PP_ARRAY_DET_NO					NVARCHAR(MAX)
	--@PP_ARRAY_DET_NA					NVARCHAR(MAX)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
---===================================================================================================================================================
---===================================================================================================================================================
---===================================================================================================================================================	
	DECLARE @VP_K_DETAIL_PO	INT = 1
	
	DECLARE @VP_POSICION_KL INT
	DECLARE @VP_POSICION_YS INT
	DECLARE @VP_POSICION_NO INT 
	--DECLARE @VP_POSICION_NA	INT
	DECLARE @VP_VALOR_KL	VARCHAR(500)
	DECLARE @VP_VALOR_YS	VARCHAR(500)
	DECLARE @VP_VALOR_NO	VARCHAR(500)
	--DECLARE @VP_VALOR_NA	VARCHAR(500)
	--Colocamos un separador al final de los parametros para que funcione bien nuestro codigo
	SET	@PP_ARRAY_DET_KL		= @PP_ARRAY_DET_KL		+ '/'
	SET	@PP_ARRAY_DET_YS		= @PP_ARRAY_DET_YS		+ '/'
	SET	@PP_ARRAY_DET_NO		= @PP_ARRAY_DET_NO		+ '/'
	--SET	@PP_ARRAY_DET_NA		= @PP_ARRAY_DET_NA		+ '/'
	
	--Hacemos un bucle que se repite mientras haya separadores, patindex busca un patron en una cadena y nos devuelve su posicion
	WHILE patindex('%/%' , @PP_ARRAY_DET_KL) <> 0
		BEGIN
			SELECT @VP_POSICION_KL	=	patindex('%/%' , @PP_ARRAY_DET_KL	)
			SELECT @VP_POSICION_YS	=	patindex('%/%' , @PP_ARRAY_DET_YS	)
			SELECT @VP_POSICION_NO	=	patindex('%/%' , @PP_ARRAY_DET_NO	)
			--SELECT @VP_POSICION_NA	=	patindex('%/%' , @PP_ARRAY_DET_NA	)

			--Buscamos la posicion de la primera y obtenemos los caracteres hasta esa posicion
			SELECT @VP_VALOR_KL		= LEFT(@PP_ARRAY_DET_KL		, @VP_POSICION_KL	- 1)
			SELECT @VP_VALOR_YS		= LEFT(@PP_ARRAY_DET_YS		, @VP_POSICION_YS	- 1)
			SELECT @VP_VALOR_NO		= LEFT(@PP_ARRAY_DET_NO		, @VP_POSICION_NO	- 1)
			--SELECT @VP_VALOR_NA		= LEFT(@PP_ARRAY_DET_NA		, @VP_POSICION_NA	- 1)

			UPDATE	APQP_TEAM_DET
			SET	
					[L_APQP_TEAM_DET_YES]			= @VP_VALOR_YS	,
					[L_APQP_TEAM_DET_NO]			= @VP_VALOR_NO	,
					--[L_APQP_TEAM_DET_NA]			= @VP_VALOR_NA	,
					-- ===========================	= -- ===========================
					[F_CAMBIO]						= GETDATE(), 
					[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
			WHERE	K_APQP_TEAM_DET			= @VP_VALOR_KL
			
			IF @@ROWCOUNT = 0
			BEGIN
				SET @VP_MENSAJE='The record was not updated.' + ' [' +	CONVERT(VARCHAR(10),@VP_VALOR_KL)	+ ']'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END

			IF (@VP_VALOR_YS=1	OR @VP_VALOR_NO=1	)--OR @VP_VALOR_NA=1)
			BEGIN
				--	PARA COLOCAR LA FECHA DE COMPLETADA, SIN IMPORTAR SI FUE EN SI O NO.
				IF (SELECT F_APQP_TEAM_DET_COMPLETED FROM APQP_TEAM_DET WHERE K_APQP_TEAM_DET= @VP_VALOR_KL) IS NULL
				BEGIN
					UPDATE	APQP_TEAM_DET
					SET	
							[F_APQP_TEAM_DET_COMPLETED]		= GETDATE()
					WHERE	K_APQP_TEAM_DET			= @VP_VALOR_KL
					IF @@ROWCOUNT = 0
					BEGIN
						SET @VP_MENSAJE='The record was not updated.' + ' [' +	CONVERT(VARCHAR(10),@VP_VALOR_KL)	+ ']'
						RAISERROR (@VP_MENSAJE, 16, 1 )
					END
				END
			END
			ELSE
			BEGIN
				UPDATE	APQP_TEAM_DET
				SET	
						[F_APQP_TEAM_DET_COMPLETED]		= NULL
				WHERE	K_APQP_TEAM_DET			= @VP_VALOR_KL
				IF @@ROWCOUNT = 0
				BEGIN
					SET @VP_MENSAJE='The record was not updated.' + ' [' +	CONVERT(VARCHAR(10),@VP_VALOR_KL)	+ ']'
					RAISERROR (@VP_MENSAJE, 16, 1 )
				END			
			END
			--Reemplazamos lo procesado con nada con la funcion stuff
			SELECT @PP_ARRAY_DET_KL= STUFF(@PP_ARRAY_DET_KL , 1, @VP_POSICION_KL, '')
			SELECT @PP_ARRAY_DET_YS= STUFF(@PP_ARRAY_DET_YS , 1, @VP_POSICION_YS, '')
			SELECT @PP_ARRAY_DET_NO= STUFF(@PP_ARRAY_DET_NO , 1, @VP_POSICION_NO, '')
			--SELECT @PP_ARRAY_DET_NA= STUFF(@PP_ARRAY_DET_NA , 1, @VP_POSICION_NA, '')
		END
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_APQP_TEAM_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_APQP_TEAM_HDR]
GO
--		 EXECUTE [dbo].[PG_DL_APQP_TEAM_HDR] 0,139,9
CREATE PROCEDURE [dbo].[PG_DL_APQP_TEAM_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_TEAM_HDR			INT
AS
DECLARE @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	--/////////////////////////////////////////////////////////////
	UPDATE	APQP_TEAM_HDR
	SET		
			[L_BORRADO]				= 1,
			-- ====================
			[F_BAJA]				= GETDATE(), 
			[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
	WHERE	K_APQP_TEAM_HDR=@PP_K_APQP_TEAM_HDR
	
	IF @@ROWCOUNT = 0
	BEGIN
		--DECLARE @VP_ERROR_2 VARCHAR(250)='No fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
		SET @VP_MENSAJE='The record was not inserted.'
		RAISERROR (@VP_MENSAJE, 16, 1 ) 
	END

	UPDATE	APQP_TEAM_DET
	SET
			[L_BORRADO]				= 1,
			-- ====================
			[F_BAJA]				= GETDATE(), 
			[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
	WHERE	K_APQP_TEAM_HDR=@PP_K_APQP_TEAM_HDR

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

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_APQP_TEAM_HDR AS CLAVE
	-- //////////////////////////////////////////////////////////////	
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////