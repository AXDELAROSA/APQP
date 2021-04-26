-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210122
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_MODEL_DET]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_MODEL_DET]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_MODEL_HDR]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_MODEL_HDR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_MODEL_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_MODEL_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_MODEL_HDR_TYPE]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_MODEL_HDR_TYPE]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STATUS_APQP_MODEL]') AND type in (N'U'))
	DROP TABLE [dbo].[STATUS_APQP_MODEL]
GO


-- ////////////////////////////////////////////////////////////////
-- //					STATUS_APQP_MODEL				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[STATUS_APQP_MODEL] (
	[K_STATUS_APQP_MODEL]				[INT]			NOT NULL,
	[D_STATUS_APQP_MODEL]				[VARCHAR](100)	NOT NULL,
	[C_STATUS_APQP_MODEL]				[VARCHAR](255)	NOT NULL,
	[S_STATUS_APQP_MODEL]				[VARCHAR](10)	NOT NULL,
	[O_STATUS_APQP_MODEL]				[INT]			NOT NULL,
	[L_STATUS_APQP_MODEL]				[INT]			NOT NULL,
	[K_STATUS_APQP_MODEL_CLASS]			[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[STATUS_APQP_MODEL]
	ADD CONSTRAINT [PK_STATUS_APQP_MODEL]
		PRIMARY KEY CLUSTERED ([K_STATUS_APQP_MODEL])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_STATUS_APQP_MODEL_01_DESCRIPCION] 
	   ON [dbo].[STATUS_APQP_MODEL] ( [D_STATUS_APQP_MODEL] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_STATUS_APQP_MODEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_STATUS_APQP_MODEL]
GO
-- //////////////////////////////////////////////////////////////
-- //				CI - STATUS_APQP_MODEL
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_STATUS_APQP_MODEL]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_STATUS_APQP_MODEL			INT,
	@PP_D_STATUS_APQP_MODEL			VARCHAR(100),
	@PP_C_STATUS_APQP_MODEL			VARCHAR(255),
	@PP_S_STATUS_APQP_MODEL			VARCHAR(10),
	@PP_O_STATUS_APQP_MODEL			INT,
	@PP_L_STATUS_APQP_MODEL			INT,
	@PP_K_STATUS_APQP_MODEL_CLASS	INT
AS
	-- ===========================
	INSERT INTO STATUS_APQP_MODEL
			(	[K_STATUS_APQP_MODEL], [D_STATUS_APQP_MODEL], 
				[C_STATUS_APQP_MODEL], [S_STATUS_APQP_MODEL], 
				[O_STATUS_APQP_MODEL], [L_STATUS_APQP_MODEL],
				[K_STATUS_APQP_MODEL_CLASS]		)
	VALUES	
			(	@PP_K_STATUS_APQP_MODEL, @PP_D_STATUS_APQP_MODEL, 
				@PP_C_STATUS_APQP_MODEL, @PP_S_STATUS_APQP_MODEL,
				@PP_O_STATUS_APQP_MODEL, @PP_L_STATUS_APQP_MODEL,
				@PP_K_STATUS_APQP_MODEL_CLASS	)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
--	K_STATUS_APQP_MODEL_CLASS		PARA EL ENCABEZADO ES CLASE 10		/	PARA LAS ACTIVIDADES ES CLASE 20
-- ============================================================================================================
--	ESTATUS PARA EL CIERRE EL ENCABEZADO DE APQP_MODEL
EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	00, '( POR DEFINIR )'		,'' , 'XDEFI'	, 00 , 1	,00
EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	01, 'ACTIVA'				,'' , 'ACTIV'	, 10 , 1	,10
EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	02, 'INACTIVA'				,'' , 'INACT'	, 20 , 1	,10
-- ============================================================================================================
--	ESTATUS PARA EL CIERRE DE LAS ACTIVIDADES
EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	10, 'ABIERTA'				,'' , 'ABIER'	, 10 , 1	,20
EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	11, 'CERRADA'				,'' , 'CERRA'	, 20 , 1	,20
EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	12, 'EN PROCESO'			,'' , 'PROCE'	, 30 , 1	,30
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_MODEL_HDR_TYPE				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[APQP_MODEL_HDR_TYPE] (
	[K_APQP_MODEL_HDR_TYPE]				[INT]			NOT NULL,
	[D_APQP_MODEL_HDR_TYPE]				[VARCHAR](100)	NOT NULL,
	[C_APQP_MODEL_HDR_TYPE]				[VARCHAR](255)	NOT NULL,
	[S_APQP_MODEL_HDR_TYPE]				[VARCHAR](10)	NOT NULL,
	[O_APQP_MODEL_HDR_TYPE]				[INT]			NOT NULL,
	[L_APQP_MODEL_HDR_TYPE]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_MODEL_HDR_TYPE]
	ADD CONSTRAINT [PK_APQP_MODEL_HDR_TYPE]
		PRIMARY KEY CLUSTERED ([K_APQP_MODEL_HDR_TYPE])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_APQP_MODEL_HDR_TYPE_01_DESCRIPCION] 
	   ON [dbo].[APQP_MODEL_HDR_TYPE] ( [D_APQP_MODEL_HDR_TYPE] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_MODEL_HDR_TYPE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_MODEL_HDR_TYPE]
GO
-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_MODEL_HDR_TYPE
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_MODEL_HDR_TYPE]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR_TYPE			INT,
	@PP_D_APQP_MODEL_HDR_TYPE			VARCHAR(100),
	@PP_C_APQP_MODEL_HDR_TYPE			VARCHAR(255),
	@PP_S_APQP_MODEL_HDR_TYPE			VARCHAR(10),
	@PP_O_APQP_MODEL_HDR_TYPE			INT,
	@PP_L_APQP_MODEL_HDR_TYPE			INT
AS
	-- ===========================
	INSERT INTO APQP_MODEL_HDR_TYPE
			(	[K_APQP_MODEL_HDR_TYPE], [D_APQP_MODEL_HDR_TYPE], 
				[C_APQP_MODEL_HDR_TYPE], [S_APQP_MODEL_HDR_TYPE], 
				[O_APQP_MODEL_HDR_TYPE], [L_APQP_MODEL_HDR_TYPE]		)
	VALUES	
			(	@PP_K_APQP_MODEL_HDR_TYPE, @PP_D_APQP_MODEL_HDR_TYPE, 
				@PP_C_APQP_MODEL_HDR_TYPE, @PP_S_APQP_MODEL_HDR_TYPE,
				@PP_O_APQP_MODEL_HDR_TYPE, @PP_L_APQP_MODEL_HDR_TYPE	)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
--EXECUTE [dbo].[PG_CI_APQP_MODEL_HDR_TYPE]  0, 139,	00, '( TO DEFINE )'			,'' , '2DFINE'	, 00 , 1
EXECUTE [dbo].[PG_CI_APQP_MODEL_HDR_TYPE]  0, 139,	01, 'NUEVO MODELO'				,'' , 'NVOMOD'	, 10 , 1
EXECUTE [dbo].[PG_CI_APQP_MODEL_HDR_TYPE]  0, 139,	02, 'CAMBIO INGENIERÍA'			,'' , 'CMBING'	, 20 , 1
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_MODEL_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_MODEL_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_MODEL_ACTIVITY_LIST]				[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_MODEL_ACTIVITY_LIST]				[VARCHAR](255),
			[RESPONSIBLE_APQP_MODEL_ACTIVITY_LIST]		[VARCHAR](255)	NOT NULL,
			-- ===========================
			--	ESTOS CAMPOS SE CREAN CON EL FIN DE IDENTIFICAR SI LA ACTIVIDAD SE IMPLEMENTA CUANDO ES NUEVO MODELO, CAMBIO DE MODELO O ALGÚN OTRO PARAMETRO DE CAMBIO QUE SURGA.
			--	SE ASIGNA LA ACTIVIDAD A CADA UNO DE LOS TIPOS Y SE LE ASIGNA LA NUMERACIÓN CORRESPONDIENTE.
			[L_APQP_MODEL_TYPE_01]						[INT] NOT NULL DEFAULT 1,	-- TYPE	= NEW MODEL
			[N_APQP_MODEL_TYPE_01]						[VARCHAR](10) NOT NULL DEFAULT 0,	-- # DE ACTIVIDAD EN LISTADO.
			-- ===========================			
			-- AL INICIO DEL PROYECTO SOLO SE CONTEMPLAN NUEVOS MODELOS EN CASO DE AGREGAR MÁS TIPOS SE DEBEN HABILITAR ESTOS CAMPOS Y ASIGNAR LOS VALORES CORRESPONDIENTES.
			--[L_APQP_MODEL_TYPE_02]						[INT] NOT NULL DEFAULT 0,
			--[N_APQP_MODEL_TYPE_02]						[VARCHAR](10) NOT NULL DEFAULT 0,	-- # DE ACTIVIDAD EN LISTADO.
			--[L_APQP_MODEL_TYPE_03]						[INT] NOT NULL DEFAULT 0,
			--[N_APQP_MODEL_TYPE_03]						[VARCHAR](10) NOT NULL DEFAULT 0,	-- # DE ACTIVIDAD EN LISTADO.
			--[L_APQP_MODEL_TYPE_04]						[INT] NOT NULL DEFAULT 0,
			--[N_APQP_MODEL_TYPE_04]						[VARCHAR](10) NOT NULL DEFAULT 0,	-- # DE ACTIVIDAD EN LISTADO.
			-- ===========================
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_MODEL_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_MODEL_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_MODEL_ACTIVITY_LIST])
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]
GO
-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_MODEL_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	--@PP_K_APQP_MODEL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_MODEL_ACTIVITY_LIST_01			INT,
	@PP_N_APQP_MODEL_ACTIVITY_LIST_01			VARCHAR(10),
	--@PP_L_APQP_MODEL_ACTIVITY_LIST_03			INT,
	--@PP_L_APQP_MODEL_ACTIVITY_LIST_04			INT,
	@PP_RESPONSIBLE_APQP_MODEL_ACTIVITY_LIST	VARCHAR(255),
	@PP_D_APQP_MODEL_ACTIVITY_LIST				VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_MODEL_ACTIVITY_LIST
			(	--	[K_APQP_MODEL_ACTIVITY_LIST],	
				[D_APQP_MODEL_ACTIVITY_LIST], 
				[RESPONSIBLE_APQP_MODEL_ACTIVITY_LIST],
				[L_APQP_MODEL_TYPE_01],			[N_APQP_MODEL_TYPE_01]			)
				--	[L_APQP_MODEL_TYPE_03],			[L_APQP_MODEL_TYPE_04]			)
	VALUES	
			(	--	@PP_K_APQP_MODEL_ACTIVITY_LIST, 
				@PP_D_APQP_MODEL_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_MODEL_ACTIVITY_LIST,
				@PP_L_APQP_MODEL_ACTIVITY_LIST_01,	@PP_N_APQP_MODEL_ACTIVITY_LIST_01				)
				--	@PP_L_APQP_MODEL_ACTIVITY_LIST_03,	@PP_L_APQP_MODEL_ACTIVITY_LIST_04			)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'1',		'Omar D.'						,'Fecha de aviso del cambio o inicio.'																																													
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'2',		'Omar D.'						,'Inicio del programa o cambio (implementacion).'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'3',		'Omar D.'						,'Cotización.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'4',		'Equipo Gerencial'				,'Capacidad y factibilidad de corte (evaluación de requerimientos de volumen y de entrega).'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'5',		'Omar D.'						,'Dibujos, planos o mylars o especificaciones de ingeniería nuevas (ver actividad #22).'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'6',		'Omar D.'						,'Cotización de herramental de corte.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'6.1',	'Omar D.'						,'PO de herramental.'
EXECUTE [DBO].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'6.2',	'Omar D.'						,'Herramental recibido / listo para producción.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'7',		'Omar D'						,'Disponibilidad de materia prima, cantidades y colores.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'8',		'Guillermo M, Jorge H.'			,'Requerimientos de mano de obra adicional.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'9',		'Guillermo M, Jorge H.'			,'Necesides de equipo adicional o de mejoras al ya existente.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'10',		'Equipo Gerencial'				,'Necesidades de entrenamiento adicionales.'
EXECUTE [DBO].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'11',		'Miguel C.'						,'Documentación de calidad, control plan, FMEA´S, diagrama de flujo, etc.'
EXECUTE [DBO].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'11.1',	'Miguel C.'						,'Envío de PPAP.'
EXECUTE [DBO].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'11.2',	'Miguel C.'						,'PPAP aprobado por el cliente.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'12',		'Miguel C.'						,'Equipo de inspección adicional, disponibilidad de criterios de calidad, masters, ayudas visuales, etc.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'13',		'Miguel C.'						,'Documentación de piso, instrucciones de trabajo y criterios.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'14',		'Omar D.'						,'Requerimientos de monitoreo, inspección y medición del producto o del proceso.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'15',		'Omar D.'						,'Especificaciones adicionales o especiales de ingenieria, esto incluye caracteristicas criticas y/o de segutidad del producto (considerando la flamabilidad como caracteristica crítica).'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'15-A',	'Miguel C.'						,'Especificaciones especiales del cliente (manual de proveedores).'
EXECUTE [DBO].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'16',		'Omar D.'						,'Requerir lista de paises destino.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'17',		'Omar D.'						,'Archivos de corte.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'18',		'Omar D.'						,'Muestras.'
--EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'',	'Miguel C, Omar D.'				,'validaciones de acciones/muestras en areas modelo antes de implementar masivamente'		--20210409
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'19',		'Miguel C.'						,'Masters de color, manual de marcas naturales y/o cualquier otro criterio de calidad que se requiera.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'20',		'Omar D.'						,'Blanket PO.'
EXECUTE [DBO].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'21',		'Omar D.'						,'Número de parte en el sistema.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'22',		'Omar D.'						,'Información de empaque y etiquetas.'
EXECUTE [DBO].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'23',		'Omar D.'						,'Inicio de corte produccion normal.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'24',		'MANUEL G.'						,'Inventarios (obsolescencias).'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'25',		'Omar D.'						,'Recordatorio de requerimiento de confidencialidad de IATF 16949.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'26',		'Omar D.'						,'Consideraciones preventivas del producto o del proceso.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'27',		'Miguel C.'						,'Objetivos de calidad.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'28',		'Equipo Gerencial'				,'Consideraciones de infraestructuras y medio ambiente de trabajo.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'29',		'Equipo Gerencial'				,'Consideraciones de seguridad.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'30',		'Gerencia General'				,'Objetivo de productividad.'
EXECUTE [dbo].[PG_CI_APQP_MODEL_ACTIVITY_LIST]  0, 139,	1,'31',		'Omar D.'						,'Lecciones aprendidas de procesos/productos similares.'

SET NOCOUNT OFF
GO

-- ////////////////////////////////////////////////////////////////
-- //					APQP_MODEL_HDR				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_MODEL_HDR]	(
			-- ============================	
			[K_APQP_MODEL_HDR]					[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_MODEL_HDR]					[VARCHAR](255),
			[C_APQP_MODEL_HDR]					[VARCHAR](500)	NOT NULL,
			-- ===========================
			--[APQP_MODEL_HDR_OPTION_01]			[VARCHAR](255),						---	OPTIONS
			--[APQP_MODEL_HDR_OPTION_02]			[VARCHAR](255),						---	OPTIONS
			-- ===========================
			[K_ARCUSFIL]						[INT] NOT NULL,
			[K_ARCUSFIL_PROGRAM]				[INT] NOT NULL,
			--	[S_APQP_MODEL_HDR]					[VARCHAR](25),						---	PROGRAM
			-- ===========================
			[K_STATUS_APQP_MODEL]				[INT] NOT NULL DEFAULT 1,
			[K_APQP_MODEL_HDR_TYPE]				[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[APQP_MODEL_HDR_NUMBER]				[VARCHAR](255),
			[F_APQP_MODEL_HDR_CREATED]			[DATE]	NOT NULL,
			-- ===========================
			[APQP_ECN_RFQ_SP_REFERENCE]			[VARCHAR](255)	NOT NULL DEFAULT ''
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_MODEL_HDR]
ADD
			[K_USUARIO_ALTA]					[INT] NOT NULL,
			[F_ALTA]							[DATETIME] NOT NULL,
			[K_USUARIO_CAMBIO]					[INT] NOT NULL,
			[F_CAMBIO]							[DATETIME] NOT NULL,
			[L_BORRADO]							[INT] NOT NULL,
			[K_USUARIO_BAJA]					[INT] NULL,
			[F_BAJA]							[DATETIME] NULL;
GO

-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_MODEL_HDR]	
	ADD CONSTRAINT [K_APQP_MODEL_HDR]
		PRIMARY KEY CLUSTERED ([K_APQP_MODEL_HDR])
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_MODEL_DET
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_MODEL_DET]	(
			-- ============================	
			[K_APQP_MODEL_DET]					[INT] IDENTITY (1,1)	NOT NULL,
			[K_APQP_MODEL_HDR]					[INT] NOT NULL DEFAULT 0,
			[K_APQP_MODEL_ACTIVITY_LIST]		[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[F_APQP_MODEL_DET_CREATED]			[DATE]	NOT NULL DEFAULT GETDATE(),
			[F_APQP_MODEL_DET_COMPLETED]		[DATE]	NULL,
			-- ===========================
			[K_STATUS_APQP_MODEL]				[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[L_APQP_MODEL_DET_COMPLETED]		[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[C_APQP_MODEL_DET]					[NVARCHAR](MAX) NOT NULL DEFAULT '',		--ES EL CAMPO DE COMENTARIOS.
			-- ===========================
			[COMPLEMENT_APQP_MODEL]				[NVARCHAR](MAX) NOT NULL DEFAULT ''
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_MODEL_DET]
ADD
			[K_USUARIO_ALTA]					[INT] NOT NULL,
			[F_ALTA]							[DATETIME] NOT NULL,
			[K_USUARIO_CAMBIO]					[INT] NOT NULL,
			[F_CAMBIO]							[DATETIME] NOT NULL,
			[L_BORRADO]							[INT] NOT NULL,
			[K_USUARIO_BAJA]					[INT] NULL,
			[F_BAJA]							[DATETIME] NULL;
GO

-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_MODEL_DET]	
	ADD CONSTRAINT [K_APQP_MODEL_DET]
		PRIMARY KEY CLUSTERED ([K_APQP_MODEL_DET])
GO

--ALTER TABLE [dbo].[APQP_MODEL_DET]											
--ADD
--		[C_APQP_MODEL_DET_COMPLETED]		[NVARCHAR](MAX) NOT NULL DEFAULT ''
--GO
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////