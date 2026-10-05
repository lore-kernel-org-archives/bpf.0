Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4535B65D;
	Mon,  5 Oct 2026 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191848; cv=fail; b=kio2UDP/9EWVylolUKOk6iIW77PT5LF19ZL9tReccB12rPAQnYRe6sQvtGv4Bk/4LUzVKSHwGUlMfriHHWOQLeaTd+jOXCq4IOJE2g+7ze8CHGSaC2ApYtSySpuF2ATwmM2aceavQyrEEIdIkQxditdF568ctpocSASJB+8MPZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191848; c=relaxed/simple;
	bh=yb76xX3rINqtqky/8K1e1vILl8lQJrefgV9mI+rzmWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfcQTSoooOUptHumgfcY82JYWbytuUKz/qQCmMwB9iU4VaTTX5Ga3RXW+7pRecNKAoZOg1fV46SqR8lqQ13Chm2P+Q8B8s2xmWKAyghw3YYW1XJFqlC/grGIG0PFEdlIdEDUMoYKhxC2uwr4eiO4stKL/cyVVLeJf3OoFnBRPGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pIAXwDGU; arc=fail smtp.client-ip=52.101.193.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pIAXwDGU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7zFKZctWLCLkRV439VdYndSGV3AOW2ZDy/1gaJrl2bv/5bWNySjAH3ZOq9hwxBgx4VFNpWTkXqnOg2qp22Be1QpjttMvqn191yyfPpLS/10eObeHkDJxdBfCeYn63evjVm9slVdRUk6LCB7RQCZAvT2IxViD6HRSH1SR0x67vPxQ3wTTxjE1DTebUVd3wedMD1qocd+kxqXTIIsJdJUy2rhbw9ImM7WGzmB673f1u+vnAxTWJwQ6uZrsWFspb+C9d6KTFonPbMRvdSHGNrYz++kS+FsDRzUoMYbsGAuSw/Kfx34013JROjzaABBzZnJrjTLXSM0lUB0Z46pPQi+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EBEWFNjBvJx3hVFlMaLuzWu7lvWxRbNVlT2LUlFLwY=;
 b=uoE9qhN06bh62svcGvLv+VznDMWO98dYoRdTWbNeTpi3X0ERCVqQF4BjGKg5Hv6AlkD0/bI7FOHPO2IrzXDKSMEm0zegzN1+5sNSqXPLEB/QsUEVfriRyBSL49rk3kWOphYnbsmHx+TBOXw6PYQUA/ExpKRXLcwsdjPhP1rvbg86bp+Uzx3EHyxouvI1lTEH2eMfbeoQFbWIjG2EaleyK5eCE0VVRJLelD47NOxavg56GnMsbSKhXVySwct5feumFc8+hgMfYfg5iPJDqG4W0uX45s1l1FUq/gF3hT+anT1JDuc6KKKZTTJaiqGWnwpdS1lptYviMExxmxhzWpWUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EBEWFNjBvJx3hVFlMaLuzWu7lvWxRbNVlT2LUlFLwY=;
 b=pIAXwDGUtEx8S7imy+Hz8jN+saZ3uPgyD/Caq0XkMrAxN8hmQvIaZCQrqv7Tb+W5520V5AefGtg2Ewn8XEuWD79x+dnNgiPMBgStDMba4rmttdpknjIpiFf0H5BmnZJyoGQ7geTIrosy3RbxKNCGm9oJRcZ3nVUydSKw92VMNsE=
Received: from SJ0PR05CA0134.namprd05.prod.outlook.com (2603:10b6:a03:33d::19)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:17:19 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:a03:33d:cafe::98) by SJ0PR05CA0134.outlook.office365.com
 (2603:10b6:a03:33d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 09:17:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Mon, 5 Oct 2026 09:17:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:17:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:17:16 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:17:14 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <Sunil-kumar.Dommati@amd.com>,
	<vijendar.mukunda@amd.com>, <Mario.Limonciello@amd.com>,
	<venkataprasad.potturu@amd.com>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.dev>, <anson.tsao@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, "open list:SOUNDWIRE SUBSYSTEM"
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
Subject: [PATCH v3 5/5] soundwire: amd: honor peripheral BRA block alignment
Date: Mon, 5 Oct 2026 14:45:48 +0530
Message-ID: <20261005091620.1390916-6-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005091620.1390916-1-syed.sabakareem@amd.com>
References: <20261005091620.1390916-1-syed.sabakareem@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 879993a7-6043-4120-4f4b-08df22c1747b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DOs2RfzdL98tZpUrSvpaMksMag1MuMOXoRC528mWpBPnaZAYsvALolsp5wQGCMIXoo1rE0FLSIiSikeCqAfyiadGQnMeJ80chIPVT62o52LKyioWrH+b0KDxxG6zUr4JrhJyPej663oEFqU70ylT7CHbgVeDBvfo+241Sp91uecMAjyX6muLsa5ls0tUi0btppIeg56yIbbRdYyhDQvz+aTKxeJsylnL3HN/Wey8/+DdzxXt1o/8gakFmlPYuCZYQRvJ2gt7xeH/OKV+mROUFCSGZkTlFRrG54bFo6bb5i7tG5a7GjXlNXFkQwsFXy/rgxbFe4rgv5FbMhHYeMaGJioIzJF+dtD3fOxyTRhlan5bn669asak70mcKR7ismt3EhqB2U6hPC813KraGuIpKWfiVHkSyRz1PQw41aZIY7uSAsTsNdE7H7wZHkHBANGohgmLffR2nbEYHnnILE+p1k4/tc0j2wXIc+gzFYlnzhEl1EQcVBSiGULotnybAJj/9/VwJ6wU/QoDmMWCPLjhUpyNR0BhcBxXvFW2gafh9BctKypVhDZgbvzXQVWio/kPCpwsKJQaWUrP4cJexQL2Ei0iHUPA6QLDIjxUL6xGHCPKITNTOQF7EXz+/OJAGPBu4ctw1BCqpYQquMeq5Agp+YAenbXXHQTCLc3IjYQzhefXDW/SGhvAfI3FU0yaw0FvHIkjlubjUOlzc2c6ETpchw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+mMD+Auf0JCTko4AiKIPhIIAAaoNMMZhEILkNETtWHJ5S4gL3dCx0U7RyQ6La4ozVQccLh47Xy0aE9xwgfnuQG3a2q9hFKSZovlvUj4QcveBlJN7wjVw4TwN6EgMbolwXo2vWAmPPK2EGsX87P99E91WPcs+ZlwlWsPmUAViDscofij1E+rRcPyCfH9o4H7TAJbiT7XgUur1TapTzebGriyWlaoxIU1NTTGCpj+wEA1Qv06reKjDfpkWwyBAhsc8pODzrWOIHFLEYDKpjNGB8CBsotBmbz2D6vG5o+xRzJ0SX2j6CAR+VE5CfdCG2kzVODWBjNUmlvDLQmqn3y30ZQfNVrwtbuazb98AbkixFh802vP57guqG/FJtt7mWU60J8a1kUC7CsS5nrCrz77e92ukVk/bjWSDT9sYD9wMRvTxJSJRtuGnObhg2kQm+aTe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:17:18.6829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 879993a7-6043-4120-4f4b-08df22c1747b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1

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
index 078e13b01ac9..9da60e8681f0 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -901,7 +901,7 @@ static int amd_sdw_port_enable(struct sdw_bus *bus,
 
 static int amd_sdw_calculate_bra_params(struct amd_sdw_manager *amd_manager,
 					struct amd_bra_params *params,
-					u8 peripheral_addr)
+					struct sdw_slave *slave)
 {
 	struct sdw_bus *bus = &amd_manager->bus;
 	u32 nr = bus->params.row;  /* current rows - NOT enlarged */
@@ -912,6 +912,7 @@ static int amd_sdw_calculate_bra_params(struct amd_sdw_manager *amd_manager,
 	u32 sample_interval;
 	u32 bits_per_frame;
 	u32 bpf;
+	u32 block_alignment = slave->prop.bra_block_alignment;
 
 	params->hstart      = hstart;
 	params->hstop       = hstop;
@@ -943,14 +944,33 @@ static int amd_sdw_calculate_bra_params(struct amd_sdw_manager *amd_manager,
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
 
@@ -1356,7 +1376,7 @@ static int amd_sdw_bra_transfer(struct amd_sdw_manager *amd_manager,
 	int ret;
 
 	ret = amd_sdw_calculate_bra_params(amd_manager, &params,
-					   (u8)slave->dev_num);
+					   slave);
 	if (ret < 0)
 		return ret;
 
@@ -1780,7 +1800,7 @@ static int amd_sdw_bpt_wait(struct sdw_bus *bus,
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

