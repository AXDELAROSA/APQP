-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210201
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02Pruebas]
GO
--			SELECT * FROM [APQP_TEAM_ACTIVITY_LIST]
--			SELECT * FROM [APQP_TOOL_ACTIVITY_LIST]		
--			SELECT * FROM [APQP_QUAL_ACTIVITY_LIST]
--			SELECT * FROM [APQP_FLOOR_ACTIVITY_LIST]
--			SELECT * FROM [APQP_FLOW_ACTIVITY_LIST]
--			SELECT * FROM [APQP_PFMEA_ACTIVITY_LIST]
--			SELECT * FROM [APQP_CONTROL_ACTIVITY_LIST]
--			SELECT * FROM [APQP_RISK_ACTIVITY_LIST]			

-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_RISK_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_RISK_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_CONTROL_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_CONTROL_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_PFMEA_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_PFMEA_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_FLOW_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_FLOW_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_FLOOR_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_FLOOR_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_QUAL_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_QUAL_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_TOOL_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_TOOL_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_TEAM_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_TEAM_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]
GO

-- ////////////////////////////////////////////////////////////////
-- //					APQP_TEAM_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_TEAM_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_TEAM_ACTIVITY_LIST]				[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_TEAM_ACTIVITY_LIST]				[VARCHAR](255),
			-- ===========================
			[L_APQP_TEAM_ACTIVITY_LIST]				[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_TEAM_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_TEAM_ACTIVITY_LIST]				[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_TEAM_ACTIVITY_LIST_VISIBLE]		[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_TEAM_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_TEAM_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_TEAM_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_TEAM_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_TEAM_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_TEAM_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_TEAM_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_TEAM_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_TEAM_ACTIVITY_LIST				VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_TEAM_ACTIVITY_LIST
			(	[D_APQP_TEAM_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_TEAM_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_TEAM_ACTIVITY_LIST_VISIBLE],
				[K_APQP_TEAM_ACTIVITY_LIST_TYPE],
				[O_APQP_TEAM_ACTIVITY_LIST]
				)
	VALUES	
			(	@PP_D_APQP_TEAM_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_TEAM_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_TEAM_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_TEAM_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_TEAM_ACTIVITY_LIST
				)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'TEAM CHECK GENERAL'

EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,01,	'Is product adequately defined (application requirements, etc.) to enable feasibility evaluation?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,02,	'Can Engineering Performance Specifications be met as written?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,03,	'Can product be manufactured to tolerances specified on drawing?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,04,	'Can product be manufactured with Cpk´s that meet requirements?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,05,	'Is there adequate capacity to produce product?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,06,	'Does the design allow the use of efficient material handling techniques?'
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'Can the product be manufactured without incurring any unusual:'

EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,01,	'- Costs for capital equipment?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,02,	'- Costs for tooling?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,03,	'- Alternative manufacturing methods?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,04,	'Is statistical process control required on the product?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,05,	'Is statistical process control presently used on similar products?'
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'Where statistical process control is used on similar products:'

EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,30,01,	'- Are the processes in control and stable?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,30,02,	'- Are Cpk´s greater than 1.33?'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_TOOL_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_TOOL_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_TOOL_ACTIVITY_LIST]				[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_TOOL_ACTIVITY_LIST]				[VARCHAR](255),
			[RESPONSIBLE_APQP_TOOL_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_TOOL_ACTIVITY_LIST]				[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_TOOL_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_TOOL_ACTIVITY_LIST]				[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_TOOL_ACTIVITY_LIST_VISIBLE]		[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_TOOL_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_TOOL_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_TOOL_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_TOOL_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_TOOL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_TOOL_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_TOOL_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_TOOL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_TOOL_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_TOOL_ACTIVITY_LIST		VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_TOOL_ACTIVITY_LIST
			(	[D_APQP_TOOL_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_TOOL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_TOOL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_TOOL_ACTIVITY_LIST_VISIBLE],
				[K_APQP_TOOL_ACTIVITY_LIST_TYPE],
				[O_APQP_TOOL_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_TOOL_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_TOOL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_TOOL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_TOOL_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_TOOL_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_TOOL_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,00,	'Does the design require:'											,''

EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,01,	'New materials?'													,'Guillermo Mata / Jorge Holguin'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,02,	'Quick change?'														,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,03,	'Volume fluctuations?'												,'Guillermo Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,04,	'Mistake proofing?'													,'Miguel Carrasco'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'Have lists been prepared identifying:'								,''

EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,20,01,	'New equipment?'													,'Guillermo Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,20,02,	'New tooling?'														,'Guillermo Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,20,03,	'New test equipment?'												,'Omar Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'Has acceptance criteria been agreed upon for:'																			,''

EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,01,	'New equipment?'																										,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,02,	'New tooling?'																											,'Guillermo Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,03,	'New test equipment?'																									,''
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,04,	'Will a preliminary capability study be conducted at the tooling and/or equipment manufacturer?'						,'Jorge Holguin / Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,05,	'Has test equipment feasibility and accuracy been established?'															,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,06,	'Is a preventive maintenance plan complete for equipment and tooling?'													,'Guillermo Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,07,	'Are setup instructions for new equipment and tooling complete and understandable?'										,'Guillermo Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,08,	'Will capable gages be available to run preliminary process capability studies at the equipment supplier´s facility?'	,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,09,	'Will preliminary process capability studies be run at the processing plant?'											,'Omar Decena / J. Holguin'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,10,	'Have process characteristics that affect special product characteristics been identified?'								,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,11,	'Were special product characteristics used in determining acceptance criteria?'											,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,12,	'Does the manufacturing equipment have sufficient capacity to handle forecasted production and service volumes?'		,'Omar Decena / J. Holguin'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,13,	'Is testing capacity sufficient to provide adequate testing?'															,'Omar Decena / J. Holguin'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_QUAL_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_QUAL_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_QUAL_ACTIVITY_LIST]				[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_QUAL_ACTIVITY_LIST]				[VARCHAR](255),
			[RESPONSIBLE_APQP_QUAL_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_QUAL_ACTIVITY_LIST]				[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_QUAL_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_QUAL_ACTIVITY_LIST]				[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_QUAL_ACTIVITY_LIST_VISIBLE]		[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_QUAL_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_QUAL_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_QUAL_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_QUAL_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_QUAL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_QUAL_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_QUAL_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_QUAL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_QUAL_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_QUAL_ACTIVITY_LIST		VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_QUAL_ACTIVITY_LIST
			(	[D_APQP_QUAL_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_QUAL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_QUAL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_QUAL_ACTIVITY_LIST_VISIBLE],
				[K_APQP_QUAL_ACTIVITY_LIST_TYPE],
				[O_APQP_QUAL_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_QUAL_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_QUAL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_QUAL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_QUAL_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_QUAL_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_QUAL_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'QUAL CHECK GENERAL'															,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,10,01,	'Is the assistance of the customer[ s quality assurance or product engineering activity needed to develop or concur to the control plan?'	,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,10,02,	'Has the supplier identified who will be the quality liaison with the customer?'															,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,10,03,	'Has the supplier identified who will be the quality liaison with its suppliers?'															,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,10,04,	'Has the quality assurance system been reviewed using the Chrysler, Ford, and General Motors Quality System Assessment?'					,'Omar Decena'
		  
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'Are there sufficient personnel identified to cover:'							,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,01,	'Control plan requirements?'																												,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,02,	'Layout inspection?'																														,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,03,	'Engineering performance testing?'																											,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,04,	'Problem resolution analysis?'																												,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,25,00,	'Is there a documented training program that:'																								,''
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,25,01,	'Includes all employees?'																													,'Adriana de la Ree'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,25,02,	'Lists whose been trained?'																													,'Adriana de la Ree'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,25,03,	'Provides a training schedule?'																												,'Adriana de la Ree'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'Has training been completed for:'											,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,01,	'Statistical process control?'																												,'J. Holguin/ Omar D'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,02,	'Capability studies?'																														,'J. Holguin/ Omar D'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,03,	'Problem solving?'																															,'J. Holguin/ Omar D'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,04,	'Mistake proofing?'																															,'J. Holguin/ Omar D'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,05,	'Other topics as identified?'																												,''
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,06,	'Is each operation provided with process instructions that are keyed to the control plan?'													,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,07,	'Are standard operator instructions available at each operation?'																			,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,08,	'Were operator/team leaders involved in developing standard operator instructions?'															,'O. Decena / G. Mata'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,00,	'Do inspection instructions include:'								,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,01,	'Easily understood engineering performance specifications?'													,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,02,	'Test frequencies?'																							,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,03,	'Sample sizes?'																								,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,04,	'Reaction plans?'																							,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,05,	'Documentation?'																							,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,00,	'Are visual aids:'																							,''
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,01,	'Easily understood?'																						,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,02,	'Available?'																								,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,03,	'Accessible?'																								,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,04,	'Approved?'																									,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,05,	'Dated and current?'																						,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,06,	'Is there a procedure to implement, maintain, and establish reaction plans for statistical control charts?'	,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,07,	'Is there an effective root cause analysis system in place?'												,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,08,	'Have provisions been made to place the latest drawings and specifications at the point of the inspection?'	,'Guillermo M. / Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,45,09,	'Are forms/logs available for appropriate personnel to record inspection results?'							,'Omar Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,00,	'Have provisions been made to place the following at the monitored operation:'								,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,01,	'Inspection gages?'																							,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,02,	'Gage instructions?'																						,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,03,	'Reference samples?'																						,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,04,	'Inspection logs?'																							,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,05,	'Have provisions been made to certify and routinely calibrate gages and test equipment?'					,'Omar Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,00,	'Have required measurement system capability studies been:'								,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,01,	'Completed?'																													,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,02,	'Acceptable?'																													,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,03,	'Are layout inspection equipment and facilities adequate to provide initial and ongoing layout of all details and components?'	,'Omar Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,00,	'Is there a procedure for controlling incoming product that identifies:'								,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,01,	'Characteristics to be inspected?'																			,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,02,	'Frequency of inspection?'																					,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,03,	'Sample size?'																								,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,04,	'Designated location for approved product?'																	,'O. Decena / Guillermo Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,05,	'Disposition of nonconforming products?'																	,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,06,	'Is there a procedure to identify, segregate, and control nonconforming products to prevent shipment?'		,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,07,	'Are rework/repair procedures available?'																	,''
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,08,	'Is there a procedure to requalify repaired/reworked material?'												,''
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,09,	'Is there an appropriate lot traceability procedure?'														,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,10,	'Are periodic audits of outgoing products planned and implemented?'											,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,11,	'Are periodic surveys of the quality system planned and implemented?'										,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,12,	'Has the customer approved the packaging specification?'													,'Omar Decena'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_FLOOR_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_FLOOR_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_FLOOR_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_FLOOR_ACTIVITY_LIST]			[VARCHAR](255),
			[RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_FLOOR_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_FLOOR_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_FLOOR_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_FLOOR_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_FLOOR_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_FLOOR_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_FLOOR_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_FLOOR_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_FLOOR_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_FLOOR_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_FLOOR_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_FLOOR_ACTIVITY_LIST
			(	[D_APQP_FLOOR_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_FLOOR_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE],
				[K_APQP_FLOOR_ACTIVITY_LIST_TYPE],
				[O_APQP_FLOOR_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_FLOOR_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_FLOOR_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_FLOOR_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_FLOOR_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'FLOOR CHECK GENERAL'									,''

EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,10,01,	'Does the floor plan identify all required process and inspection points?'									,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,10,02,	'Have clearly marked areas for all material, tools, and equipment at each operation been considered?'		,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,10,03,	'Has sufficient space been allocated for all equipment?'													,'STAFF'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'Are process and inspection areas:'						,''

EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,20,01,	'Of adequate size?'																							,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,20,02,	'Properly lighted?'																							,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,20,03,	'Do inspection areas contain necessary equipment and files?'												,'STAFF'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'Are there adequate:'									,''

EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,01,	'Staging areas?'																																		,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,02,	'Impound areas?'																																		,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,03,	'Are inspection points logically located to prevent shipment of nonconforming products?'																,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,04,	'Have controls been established to eliminate the potential for an operation, including outside processing, to contaminate or mix similar products?'		,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,05,	'Is material protected from overhead or air handling systems contamination?'																			,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,06,	'Have final audit facilities been provided?'																											,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,07,	'Are controls adequate to prevent movement of nonconforming incoming material to storage or point of use?'												,'Miguel Carrasco'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_FLOW_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_FLOW_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_FLOW_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_FLOW_ACTIVITY_LIST]			[VARCHAR](255),
			[RESPONSIBLE_APQP_FLOW_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_FLOW_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_FLOW_ACTIVITY_LIST_TYPE]	[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_FLOW_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_FLOW_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_FLOW_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_FLOW_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_FLOW_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_FLOW_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_FLOW_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_FLOW_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_FLOW_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_FLOW_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_FLOW_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_FLOW_ACTIVITY_LIST	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_FLOW_ACTIVITY_LIST
			(	[D_APQP_FLOW_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_FLOW_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_FLOW_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_FLOW_ACTIVITY_LIST_VISIBLE],
				[K_APQP_FLOW_ACTIVITY_LIST_TYPE],
				[O_APQP_FLOW_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_FLOW_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_FLOW_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_FLOW_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_FLOW_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_FLOW_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_FLOW_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'FLOW CHECK GENERAL'									,''

EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,01,	'Does the flow chart illustrate the sequence of production and inspection stations?'							,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,02,	'Were all appropriate FMEA´s (SFMEA, DFMEA) available and used as aids to develop the process flow chart?'		,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,03,	'Is the flow chart keyed to product and process checks in the control plan?'									,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,04,	'Does the flow chart describe how the product will move, i.e., roller conveyor, slide containers, etc.?'		,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,05,	'Has the pull system/optimization been considered for this process?'											,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,06,	'Have provisions been made to identify and inspect reworked product before being used?'							,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,07,	'Have potential quality problems due to handling and outside processing been identified and corrected?'			,'Miguel Carrasco'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_PFMEA_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_PFMEA_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_PFMEA_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_PFMEA_ACTIVITY_LIST]			[VARCHAR](255),
			[RESPONSIBLE_APQP_PFMEA_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_PFMEA_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_PFMEA_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_PFMEA_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_PFMEA_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_PFMEA_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_PFMEA_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_PFMEA_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_PFMEA_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_PFMEA_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_PFMEA_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_PFMEA_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_PFMEA_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_PFMEA_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_PFMEA_ACTIVITY_LIST	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_PFMEA_ACTIVITY_LIST
			(	[D_APQP_PFMEA_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_PFMEA_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_PFMEA_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_PFMEA_ACTIVITY_LIST_VISIBLE],
				[K_APQP_PFMEA_ACTIVITY_LIST_TYPE],
				[O_APQP_PFMEA_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_PFMEA_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_PFMEA_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_PFMEA_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_PFMEA_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_PFMEA_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_PFMEA_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'PFMEA CHECK GENERAL'									,''

EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,01,	'Was the Process FMEA prepared using the Chrysler, Ford, and General Motors guidelines?'													,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,02,	'Have all operations affecting fit, function, durability, governmental regulations and safety been identified and listed sequentially?'		,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,03,	'Were similar part FMEA´s considered?'																										,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,04,	'Have historical campaign and warranty data been reviewed?'																					,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,05,	'Have appropriate corrective actions been planned or taken for high risk priority items?'													,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,06,	'Have appropriate corrective actions been planned or taken for high severity numbers?'														,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,07,	'Were risk priorities numbers revised when corrective action was completed?'																,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,08,	'Were high severity numbers revised when a design change was completed?'																	,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,09,	'Do the effects consider the customer in terms of the subsequent operation, assembly, and product?'											,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'Was warranty information used as an aid in developing the Process FMEA?'																	,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,11,	'Were customer plant problems used as an aid in developing the Process FMEA?'																,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,12,	'Have the causes been described in terms of something that can be fixed or controlled?'														,'Miguel Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,13,	'Where detection is the major factor, have provisions been made to control the cause prior to the next operation?'							,'Miguel Carrasco'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_CONTROL_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_CONTROL_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_CONTROL_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_CONTROL_ACTIVITY_LIST]			[VARCHAR](255),
			[RESPONSIBLE_APQP_CONTROL_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_CONTROL_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_CONTROL_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_CONTROL_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_CONTROL_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_CONTROL_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_CONTROL_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_CONTROL_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_CONTROL_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_CONTROL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_CONTROL_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_CONTROL_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_CONTROL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_CONTROL_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_CONTROL_ACTIVITY_LIST	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_CONTROL_ACTIVITY_LIST
			(	[D_APQP_CONTROL_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_CONTROL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_CONTROL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_CONTROL_ACTIVITY_LIST_VISIBLE],
				[K_APQP_CONTROL_ACTIVITY_LIST_TYPE],
				[O_APQP_CONTROL_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_CONTROL_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_CONTROL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_CONTROL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_CONTROL_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_CONTROL_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_CONTROL_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'CONTROL CHECK GENERAL'									,''

EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,01,	'Was the control plan methodology referenced in Section 6 used in preparing the control plan?'										,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,02,	'Have all known customer complaints been identified to facilitate the selection of special product/process characteristics?'		,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,03,	'Are all special product/process characteristics included in the control plan?'														,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,04,	'Were SFMEA, DFMEA, and PFMEA used to prepare the control plan?'																	,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,05,	'Are material specifications requiring inspection identified?'																		,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,06,	'Does the control pan address incoming (material/components) through processing/assembly including packaging?'						,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,07,	'Are engineering performance testing requirements identified?'																		,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,08,	'Are gages and test equipment available as required by the control plan?'															,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,09,	'If required, has the customer approved the control plan?'																			,'Omar Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'Are gage methods compatible between supplier and customer?'																		,'Omar Decena'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_RISK_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_RISK_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_RISK_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_RISK_ACTIVITY_LIST]			[VARCHAR](255),
			-- ===========================
			[L_APQP_RISK_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_RISK_ACTIVITY_LIST_TYPE]	[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_RISK_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_RISK_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_RISK_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_RISK_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_RISK_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_RISK_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_RISK_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_RISK_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_RISK_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_RISK_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_RISK_ACTIVITY_LIST				VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_RISK_ACTIVITY_LIST
			(	[D_APQP_RISK_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_RISK_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_RISK_ACTIVITY_LIST_VISIBLE],
				[K_APQP_RISK_ACTIVITY_LIST_TYPE],
				[O_APQP_RISK_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_RISK_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_RISK_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_RISK_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_RISK_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_RISK_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,00,	'DESIGN CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,01,	'- New Commodity For Selected Supplier? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,02,	'- New Materials or Technology? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,03,	'- New/Different Application of a Carry-Over Part? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,04,	'- New Design Concept?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,05,	'- Are there Safety/Emissions/Noise Requirements?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,06,	'- Offshore Engineering Site?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,07,	'- Will Design Need To Be Coordinated With Mating Parts For Fit, Function, or Appearance?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,08,	'- Are There Other Car Line Applications Planned?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,09,	'- Any Historic Quality/Warranty Issues?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'- Is Program Timing An Issue?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,11,	'- Are Sample Submission Dates Too Late for MTS´s?'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'MANUFACTURING CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,01,	'- New Manufacturing Facility? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,02,	'- Is This a New Manufacturing Process? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,03,	'- A Part or System With Historical Launch Problems? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,04,	'- Offshore Manufacturing Site?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,05,	'- Will Supplier Need Source Evaluation?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,06,	'- Is New Production Equipment Required?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,07,	'- Are Special Tools or Tooling Fixtures Required?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,08,	'- Are Gages or Check Fixtures Required to Ensure Dimensional Integrity?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,09,	'- Any Potential Handling or Shipping Issues?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,10,	'- Will Parts Ever Be Shipped From a Location Other Than The Primary Source (i.e. Warehouse ,Offshore, etc.)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,11,	'- Will Returnable Packaging Be Required?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,12,	'- Is JIT Delivery or Sequenced Part Delivery Required?'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'ASSEMBLY CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,30,01,	'- Is Part Installation an Issue?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,30,02,	'- Are Special Tools/Fixtures Required to Install Part in Vehicle?'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,40,00,	'SERVICE CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,40,01,	'- Is Part Serviceability a Problem?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,40,02,	'- Are Special Tools/Fixtures Required?'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,50,00,	'OTHER CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,50,01,	'- Other?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,50,02,	'- Other?'

SET NOCOUNT OFF
GO