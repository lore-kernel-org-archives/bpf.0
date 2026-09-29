Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01F513549;
	Tue, 29 Sep 2026 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682717; cv=fail; b=NlY/SL7CO2nLL1DpRPZ8S/+9w4iGd98dBP+tXzgrTA2WaowMlkv5WUhK0JVUscKxxwIiL3PJkBq0hP/ryicbtMkkuct68J6i3brEGOPfqJyYBJyq0MgsCkHexNN8kTDKGtKq5fK0ef94GLUwlt5ZX0DaZnLrurHEX+m+6mrnA/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682717; c=relaxed/simple;
	bh=rc6EqlPqP4561peSV0IdsYM5M44fwiAiznV9MLThmBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avoDp73AaLYKEpdIVFuc13jlBnol0/dsBRkg3PErXCXtVojII17c7jDLjHb/PEkIs9Al4hdzf7lCOUWbNe70gyypUmRYAvKW8kHhxXQ2UJmr6B5/8n2F1m80OJeZlinZc9vv9vexT7KNgNgYI2jgrbsDANdno7hBOEr9fIqf8WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eMycSf5Z; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eMycSf5Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXKzh+j3xFu1UX7oJWCrZRPKV2bEcgBxQ5j3lcmzf7KRef5wt9om0x/892aVkokg7ye6E5ozKanttZWEl04snz07KaofyE8NE8VVi3byj+ONrorRDWJaYo8bdQBdd7bOsMThW6nCjzajyEuGLFZWs5d5Wfn/zft9x2s+UU8zUFpr3GS21VLm7lHuuPVNUIjGZnWee3pdesNLc+M+ufX3Q5Fa+KWDFv0clVIlQT2weXb7DeUpEQwvsCwlitZnv2mLTIvftq07Smzk96GOYSFUEd1PwBz2imqzFLGxQH0lnN9SqzJFxO8WroC65ZAl0H5siJSsHUszRVw2SHOILR6EaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaP8HBu0w/srGFAieVMBNs549dqmYrYlSlAx6VQtTfA=;
 b=vBFDVJi9S56abEjRsrXBT9sTBYxPayvg8sg/gUi+nIJuF2UvCqySQz3Zx932xDylr4+T5OCw0Jr5cgIKIsja5F3VPuDTNIhkgHiJ9IAFt3pboDFmn1APWH1AP5b4rblehPde10atZCgF8FHDPnc0bPhGh7Cbr3JY2OFjyxdTRP0fHIkkr8VTAVMom0R+Hm35Qzvh18Km5gyBMYkPo8/d1/UcPQUmyxOnzNQFepjScctPmKLKAV1OMDKs3p4+nHXTwffROC3Rq3jvglcDd3cEZgXTfEkA1J8TYYTwaYBYSKR2f30Y8Sevhw4PgFjlMlXdCqNYIPEnmyYZaOdtGmbN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaP8HBu0w/srGFAieVMBNs549dqmYrYlSlAx6VQtTfA=;
 b=eMycSf5ZnK22Mqp9Sshv1T0Cpn6M/5Xf4V73FquN7W0DGQxddVpytLzefIvSDKzXiA7wOUjXsb+iVd0aMUZrH1XhDlvk2bxa5/nptLtsVpnnitMwQ0GJwhKACtODahKfg8oY47hJvPdIVDWp9UhFM15DjWxwRp2WHkssoEIYgKg=
Received: from BN1PR14CA0027.namprd14.prod.outlook.com (2603:10b6:408:e3::32)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 11:51:51 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::a3) by BN1PR14CA0027.outlook.office365.com
 (2603:10b6:408:e3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 11:51:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 11:51:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 06:51:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 06:51:50 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 06:51:47 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <Sunil-kumar.Dommati@amd.com>,
	<vijendar.mukunda@amd.com>, <Mario.Limonciello@amd.com>,
	<venkataprasad.potturu@amd.com>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.dev>, <anson.tsao@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, "open list:SOUNDWIRE SUBSYSTEM"
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
Subject: [PATCH v2 5/5] soundwire: amd: honor peripheral BRA block alignment
Date: Tue, 29 Sep 2026 17:20:38 +0530
Message-ID: <20260929115052.247086-6-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929115052.247086-1-syed.sabakareem@amd.com>
References: <20260929115052.247086-1-syed.sabakareem@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: bc12de7f-694a-4df9-82e9-08df1e200ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|56012099006|11063799006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G0AI91WbHi3aupfyVKUzGGS4Lm8XHoC4fdmi++zfuzltzBwLiF1EvBz1UycZ+7TiaRipBEk3YScZaAPxSTseHB+fjVAfmniMbNS0YjGtU7N1QwtSNa/gGq9zm1PxFcFZ/fvG0fB4KidfC1WUl1DDb6W5FBKL0NEjUc5QNU9iabvvxRX6CmPJxxRgngPkUaO9UWpM9vbhljjRaOVD9tu6MsVKlbvQFpQh9nyDGFxGkFnqJdM37W8gUGjETLf2XOMT0ardy5NdjzH1I09aIKCQXcZZin3V71myiWpJhJj70QCMPfbkzhktHnqUsDlGg343ks4R1EncMen8YDbdH2YGRY44akehAdzW7rOpOtmxyxBQ4wqe+lMIsc9dFPLQUw7H2hsbqPlRnjcwiYJVmrg3FMoXEv5PSvsCSdHemcjzj0VOsXUkkqUM9F8heZGeAAc0ylv26sq6mnoFoO8iMV8NC8WDLSBYVZVFk4trHba8hvrc5Q4AGSwUjPygzuKtyJW5ejq+Mcy2+Xcbe6KJvLVWZVgsUxp3F5PL7rvd49cRgA6PWQsgOGlGF/8rxVN5Bx9ZkWXtKZ2amnRl4MlsKo4up+L7RofpvGovqwOheDK1u8TxdM/nP3X4KlsH3N7cvCR5xK9KcAOfr+9WRvI+SF/5keIvInWpG7xJRGa66gC4dF4QjkSrRbdDtGeuly2Jwt5JlsLKxT4vMHh/WXjMDgGS1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(56012099006)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4BhSpLkCBURZqLcbHBP3VST/hMtUviFsnMrTkK8kotXG5a2EfZp8QYlz3CaRQFpBCBDG9tdf9EJD8BVDqvdK73925U2SBsyGL5ehSCZzRqCXxeG30XU1ofrzpOX3qZR+Om3/ONtXotm19WZs2vfCy6K6YZpztz/D9jnSZJ2F5jWB6y1CoKQrnq0fn2C0eEDpg3k4yGVixzrBaUBGg0yTQMiNPtyadkT+5fBJ7luKWVYkOJ75TWEDkxJqHHvjxNm9tNApiXO16xZNMX+zZ3zcfYcOXsMsH9lZxDPfzYs19VJxnr8odTx0XQDogX6heUj+vrAjfr+RTjPJ+bn77l7siJuUboWZUHWAC8INTaKz1VV++3LeDmP35/C6ZENWB5U4CisfAM7TPSWHb0WpQgGuxwDQGN9CjhcBScxBMIHiYYvOhWlxLJuxVYgzveqtRBnG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 11:51:51.3697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc12de7f-694a-4df9-82e9-08df1e200ce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

The MIPI DisCo property "mipi-sdw-bra-mode-block-alignment" (parsed into
sdw_slave_prop.bra_block_alignment) states that the BRA data payload must
be an integer multiple of the advertised value. Some peripherals only
ingest the BRA payload in fixed-size blocks and mis-assemble a trailing
partial block otherwise.

The ACP BRA descriptor programs BytesPerFrame (frame_format[19:11]), which
is the number of data payload bytes the engine packs into each BRA frame.
Derive it as before, then, when the peripheral advertises a non-zero
alignment, round bytes_per_frame down to the nearest multiple of it; the
engine simply uses more frames to cover the same transfer_length. This
mirrors the Cadence/Intel handling in sdw_cdns_bpt_find_buffer_sizes().

To read the property, amd_sdw_calculate_bra_params() now takes the
sdw_slave directly instead of just its device number, and derives
dev_addr from it.

Peripherals that do not advertise the property leave bra_block_alignment
at 0, so the new path is skipped and behavior is unchanged.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 drivers/soundwire/amd_manager.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index f5b4096c83ac..c5aa543255b7 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -889,7 +889,7 @@ static int amd_sdw_port_enable(struct sdw_bus *bus,
 
 static int amd_sdw_calculate_bra_params(struct amd_sdw_manager *amd_manager,
 					struct amd_bra_params *params,
-					u8 peripheral_addr)
+					struct sdw_slave *slave)
 {
 	struct sdw_bus *bus = &amd_manager->bus;
 	u32 nr = bus->params.row;  /* current rows - NOT enlarged */
@@ -900,6 +900,7 @@ static int amd_sdw_calculate_bra_params(struct amd_sdw_manager *amd_manager,
 	u32 sample_interval;
 	u32 bits_per_frame;
 	u32 bpf;
+	u32 block_alignment = slave->prop.bra_block_alignment;
 
 	params->hstart      = hstart;
 	params->hstop       = hstop;
@@ -931,14 +932,33 @@ static int amd_sdw_calculate_bra_params(struct amd_sdw_manager *amd_manager,
 	if (bpf > 511)
 		bpf = 511;
 
+	/*
+	 * If the peripheral advertises the DisCo BRA block-alignment property
+	 * (mipi-sdw-bra-mode-block-alignment), the data payload carried in each
+	 * BRA frame must be an integer multiple of that value. Round
+	 * bytes_per_frame down to the nearest multiple; the ACP BRA engine then
+	 * packs an aligned payload per frame and simply uses more frames to
+	 * cover the same transfer_length. When the property is absent (0) the
+	 * value is left unchanged.
+	 */
+	if (block_alignment) {
+		if (bpf < block_alignment) {
+			dev_err(amd_manager->dev,
+				"BPT: bytes_per_frame %u smaller than block alignment %u\n",
+				bpf, block_alignment);
+			return -EINVAL;
+		}
+		bpf -= bpf % block_alignment;
+	}
+
 	params->sample_interval = sample_interval;
 	params->bytes_per_frame = bpf;
-	params->dev_addr        = peripheral_addr;
+	params->dev_addr        = (u8)slave->dev_num;
 
 	dev_dbg(amd_manager->dev,
 		"BPT calc_params: NR=%u NC=%u col_width=%u WL=%u SI=%u BPF=%u hstart=%u hstop=%u dev=%u\n",
 		nr, nc, col_width, params->word_length, sample_interval,
-		bpf, hstart, hstop, peripheral_addr);
+		bpf, hstart, hstop, slave->dev_num);
 	return 0;
 }
 
@@ -1343,7 +1363,7 @@ static int amd_sdw_bra_transfer(struct amd_sdw_manager *amd_manager,
 	int ret;
 
 	ret = amd_sdw_calculate_bra_params(amd_manager, &params,
-					   (u8)slave->dev_num);
+					   slave);
 	if (ret < 0)
 		return ret;
 
@@ -1759,7 +1779,7 @@ static int amd_sdw_bpt_wait(struct sdw_bus *bus,
 	 * to register read/write commands.
 	 */
 	ret = amd_sdw_calculate_bra_params(amd_manager, &prep_params,
-					   (u8)slave->dev_num);
+					   slave);
 	if (ret < 0) {
 		dev_err(amd_manager->dev,
 			"BPT: failed to calc params: %d\n", ret);
-- 
2.43.0

