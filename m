Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795027776;
	b=wg1hRFRu4JMTBbhyg77xT6QVhOeV2MFZDoCMssvzvm4SEd5fv1R4o6cwTqUiaZxvMTkI
	 VIr15bu5kZYFwgb3nyvlyUfaHj2/nbG2my6K4yOtX1y60HIbsUb5R3ygRbtGoIvAW1t6N
	 fdzoal3DBeOR3qmYM1If3g4YRzXWL1P6ZZSg08BmlaG9DYhnvI/BTixHPrcsdojE9ofPs
	 gaHWL5qC8DpryXs1fAR7Uty/BvXLybYIqP1WO/ZfDcMjO3nErL17isyE7oMs3xOc4No0H
	 TWBaloWPVUaqZIjqfDnNiwAQ1HG5NBHhziP7Ax46lUNLlu0aRkDr3TN1Uz2PC8ewsJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027776;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=oGoIdUKZC58CfGSe4NIMIb7tr32EOH9GaV3TFHeepVU=;
	b=qWyNZUS0yQj7yohzU1tE506bOEEreVp9z3fMNbcim+oh1Uwty/ECFldbB3Xt/XSzXDfx
	 AxY212aetBucm0NHJWW1KZkhXpAtzG67JxLrjNh+5pFb3sysEdQ8mx2ic6cjMUVS93pMk
	 us+/76IUUqIGTC6IeiTx/+Z68MARj7ZDlifC6SciPfGRQjll5IUvM46KC+5xwM8eUWO+7
	 Fz5BFVZIDobfEjYk6GM7css1Det9kmVGMK1m7Yjj6zeDgI4HcXL3OUEX7TBGWqOqifO/D
	 UwDeWXPrsjh9xzWbwCOgo6ugG4/GR7ewEPCBVT8I/qnbk8xBELwxOewDlfG4iTaPbgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=aG6lu1KO;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=HppMumam;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D460A260C;
	Wed, 18 Nov 2026 18:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A29D460A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=aG6lu1KO;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=HppMumam
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHG6lQ2871555;
	Wed, 18 Nov 2026 12:48:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=oGoIdUKZC58Cf
	GSe4NIMIb7tr32EOH9GaV3TFHeepVU=; b=aG6lu1KOpTHYUDoUQT+65OEySjLal
	bstLPPyOHsvu5b0doFofnNVYtC+/ugY7tmhs4sFshsbqNoNsKoqsUW5P/A/yP6xC
	OlnKPWhv760MnlgbWYQ5REPocTo+TO2l82uqAaX5eiK+9SGbGDTtPYnsTm6FyJTC
	XtzVlBlB7ubpxYiCDfhhZ1Kqlif6ctRalP3vZJHufoTiW2F9RaTsqic4iP6Y9lOP
	GtJccNNP39g8p6CI2pal8BpEPzO9iNO8TLHMxWcr/hWx7haY3rUj+YsmsOzugor7
	LIxROAGP9+xheq3gTS+LB1Bxz+pwvv5G6bLPBSKXFrT2beKrHb5d5filg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j0yuw6ccw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 12:48:44 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/ST2NU2OdC+qXIJ1drKyhtzKxYc58xuEsLwSM2yWWbundGkoSlVoynhif0nGD4dNJMjonoLDZolqtQdbT6Vmw3nG3ifg7dvhrOC8K0aTGXFTDtkBugPZUuAsqiSXoeromoBevJS0+Rj97kfRF0JOjvDudb+29N5j+ePBvL5a06T74SszmlFyV00gRBv+WwxC3ppy23YduZ7mrjzcFw/U+iPLBYs6py85vJwp41RmFPO1YOXOz21CPT9Qj5AU2pfuS63de/qKjsQU75NgO7GJ1VBXEir7x8Rop9JOG/NIfEUAlFym1gOLNS7X/T6yVDYXHWeYBcIokrLmIppTGTXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGoIdUKZC58CfGSe4NIMIb7tr32EOH9GaV3TFHeepVU=;
 b=gX2cldhOi65gvEtKWPnTmbaPJNz+K4/XfpDHfN41F86D7I2kAcpImhni/QyzJuJI2gWhWbbNoYCxyeUuGIIDXBx6rciZFXsR9T5GDF7SbxUlSCrhDxWhGdCRa3KWVGQjntj/r2ISR1fRYlE7XQkndHL4YuFQ4WpOKPeVCa/qTy9HMm988AobPQPMj5df2K8CDtVlNalb7dqzEoMziJGywoET822bUSWUhvsEQvG76DGX0e1OCM77v7r/z6A9QZ114dBiFQ4La2mnRM7z4Ub4Hkkd7QRKeYldnDYjFD32/d2zcGLr//h2nrKyYa1trNgsaIpnPeSAK44n51hmr/qJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=suse.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGoIdUKZC58CfGSe4NIMIb7tr32EOH9GaV3TFHeepVU=;
 b=HppMumam2REBQEjehFP1vWbs1YE5Lm7fC3M+euisutMDeZEQ1LvfR1mGahzcB0q1oiASU7VWIJINTpSkQpxWrfACTpHY+zVIJ2dc9FX6ocxHeX1R4CH20BOtN5ALx6RKg5O6wGAI2LRbJtL2/0xm0k8spPQgQv3Eiiblhhlj6GU=
Received: from MN2PR15CA0056.namprd15.prod.outlook.com (2603:10b6:208:237::25)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:48:41 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::2b) by MN2PR15CA0056.outlook.office365.com
 (2603:10b6:208:237::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 18
 Nov 2026 18:48:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:48:39 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 12:47:35 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 12:47:35 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 18 Nov 2026 12:47:35 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AIIlZeo2563981;
	Wed, 18 Nov 2026 12:47:35 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6AIIlXjo007449;
	Wed, 18 Nov 2026 12:47:34 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <marco.crivellari@suse.com>, <kees+treewide@kernel.org>,
        <laixiangwu@cmss.chinamobile.com>, <philippe.schenker@impulsing.ch>,
        <haokexin@gmail.com>, <devnexen@gmail.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>, <sdf@fomichev.me>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <danishanwar@ti.com>
Subject: [PATCH net-next 0/2] net: ti: icssg: Multi-flow RX and ethtool RX flow classification
Date: Thu, 19 Nov 2026 00:17:25 +0530
Message-ID: <20261118184729.2302130-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ff8387-171e-4d97-90f4-08df45a48f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|18002099003|6133799003|261009223027099003|3023799007|13003099007|921020|56012099006|261022105027099003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	aSbL5zYjEisZc+XAMcOuL/KFKk0Kh3VvyGtVKl27Akhlwf6JYdysu/iGLiVOmr9mLscPLlBHFGmNo8H5ls8ZGJ8P4keTThH9brEusaWVHIULhHAs3ODu+pchpJ0yOIWxVRe3e4Przpd8GaPd/45b8e6w8oVHs/0rGgE64StG63p3C+KIFPqHrpj2JfcWMAhxfTv3zK1Vq62jQDRJMPnhqKxGTBM/YxosxojLBKnJVn4o5051YCkh7hevF7uOl5V2Y0akTbvn5fnXhEEjHVttL0j50cV43yTTmDis+MkzeiSCYqVXGkcaPjfjQscPQqShqiLqVLgjxnTxedMfc4xzgVaXdWlIPSH0TE/m2O3HVrL0doGUyAOdG5UgPoVqxywlD574uP1I+uVbyjqSD9G13lLeE3dC0ak5nxaRpWZp6e29XnyO627OTzJFnUIpJquIyFGot2nJCCvzhUZvvUEdZVT8JPTcz5GynXN1z7xVApTWW+dmgi6Dk7mHywru+gvcbyDgUfc1xfMZLZja7aZn+0Yo1z2hO7TirOsds2cjiowCz6xZhylshT3OzijcO25ofeZ9AquTvP02gmSNbQkRs/HnNffPmtHIRjygx55ZCLLLy9Mjx5zoWZEVdwaX75kVeHFvRXZKaXS2scPKA0xW8lz9L4KnOsIJPDJxQl65E/5ecEpulrhtOO3kfrm1v2xF
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(6133799003)(261009223027099003)(3023799007)(13003099007)(921020)(56012099006)(261022105027099003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UpjzGU91yLLvpG0CTTjzhimrm+FsMKma9ysB6iweAOdl2b62tuQN9f03ynvmeqtxH/BrPvW+PfLOUY8npg2nM9eKshpDKdziLZAsa0h7l7ewoRWFFVqa67HtyHwwMd1txsgMiCIpz75w38OUYhvqtZPVFIAAPbJSObjsXGuIu5QTBGRIlj3wyEVwhZnR8h28uYgPBMdDASCjdi6sMRn8B4aDbewRKIuT+4Xxe5nRxqhatpBzhbTxx30DHo4cUMABNLJxWmZe9FKryTCBJO5hgK2qtEO/nA64fHQb6GxgAjKMgLNYZvMglMV2ilcu5WxIKu6ogVg5LDS9EbDHJ6OHAm9wRvOsQHg1vM8KXidqG57IZFoZBJMzIkQnCbjgvCmHOSswZyTBJgEYE6tDe7NI83Hag4+DuhIFv5OQLPvQbl6trB5mqyQ0pMM3+2MzePwQ
X-Exchange-RoutingPolicyChecked:
	VxN85K0bGcPD4fb//x3M6H2EhKRfnEbBYpN62d+qGwJRXAn3IYGAguHKtWoxIwgySBV/nQ2A+NJJPqXp7mKhILC92rZWZfDGYmMmzLK4mcRzObbhMhtiJ96Y0ppjvvUwsLWycZKmWO7EjRZ+6SQV69h8LDVM72Xr+Fn0K0yG7e2cCwJq4o3hAdwDRtiuW9AQQOeWQbMiikgcsE1EzwgilszXi0UZcwuDXi61giCRKqJ/wkeT58ittqa1cF2Y46ue+13LmS6pSzlaJrP9gpkRIQI8iqIEGCEtuJ00KKGRpre6rEXjfw0NCCM06+r3dsosUwJtz7/gPKHbjKJyqSvtNA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:48:39.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ff8387-171e-4d97-90f4-08df45a48f96
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Authority-Analysis: v=2.4 cv=TJXQ2Fla c=1 sm=1 tr=0 ts=6afdf30c cx=c_pps
 a=7whtcbPCeBOLW6TxF+pv5A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=aIMHsmKe8IOObArol7sA:9
X-Proofpoint-ORIG-GUID: GzRyDaDs12blvR-1g2SYX4D3NLKXcI9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfXzV2h/ofqS6vj
 Sc6MIj5zBydpoMPeGR0/mAAIADY7mHEz3tRhIZupucRlG8leHONBZzt/KyBaIfv1ICdghWlJ2jR
 EDRdf4fKVGllYVHGXHQIoF4KIMms2aGVHu45ESSAHH3bB3+Oyg8YFjsX19ytlK4ZlINWDhpa5/0
 FYhL+dLSlWumE7jw43P7IrW74shNkGEMKLOd3BfLFjAyX1EVBSY+Q335BR0n6xSDRig99gzu2ZG
 g6wKXwjaJ1lkTyseki/+5+AbdMBK8rkQpIJcdOhCyBCEEC1PacI5UtFT2azIlbUWRFAxUaWP7gy
 TfNJIlJbihqQByiNvtShkG/PFnXsgbmhLML0Ejc9sk3jy+pF7ABR184+OtkAojrZWqCPBCugEQ7
 ReAyN51skjIBwm0t/FTraHP/efoxDhwdICRB4vqWtgtPQxRJu2LzJw3japAeTpZ/cGjFpxcWfxE
 GNn89t8fq3KR/1j6qCQ==
X-Proofpoint-GUID: GzRyDaDs12blvR-1g2SYX4D3NLKXcI9L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX5tOjG3GGyZ0T
 dT/q93wXDt3NaciLxbkZdxB6C5rIiK/3YneAT7dzq1W5gW/y1yS9CVr/d0X+6ETjpDv6pHKmRXh
 yZUatMi3+yPBlr9S+EmGL3A0JAxixLc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180074

This series adds multi-flow RX support to the ICSSG ethernet driver and
exposes it via ethtool RX flow classification (rxnfc).

Patch (1/2): restructures the driver to support up to 8 independent RX flows
per EMAC interface. Each flow gets its own NAPI instance, IRQ, hrtimer,
page pool, and XDP/AF_XDP context while sharing a single UDMA channel and
descriptor pool. AF_XDP zero-copy is updated to track per-flow pools via a
bitmap, and per-flow page pool recycling is fixed by storing the flow_id in
prueth_swdata.

Patch (2/2): adds ethtool ETHTOOL_SRXCLSRLINS/SRXCLSRLDEL/SRXCLSRLALL support.
Rules match on EtherType (ETHER_FLOW) and steer matched frames to a
user-specified RX queue via ICSSG FT3 hardware content filters and the
16-entry classifier table. The classifier N result maps directly to UDMA
flow rx_flow_id_base+N, so queue steering takes effect in hardware without
per-packet CPU involvement.

Tested on AM64x EVM (SR2), both eth1 (PRU0/slice0) and eth2
(PRU1/slice1) with 8 RX flows. Verified via /proc/interrupts IRQ deltas

RFC: https://lore.kernel.org/all/20261103134501.4123194-1-m-malladi@ti.com/

Meghana Malladi (2):
  net: ti: icssg-prueth: Add multi-flow RX support with per-flow NAPI
  net: ti: icssg-prueth: Add ethtool RX flow classification support

 .../net/ethernet/ti/icssg/icssg_classifier.c  | 407 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 380 +++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  77 +++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 336 ++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  95 ++--
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  | 266 ++++++++++--
 7 files changed, 1189 insertions(+), 379 deletions(-)


base-commit: d6816d9a93b66a12bf01e10037e377f3333ad6cc
-- 
2.43.0

