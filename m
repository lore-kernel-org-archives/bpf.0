Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673752;
	b=AWfP/NUd4ARheMIfqaJDAbhi8sOnbLroxq5mLxGSRSCkUukOwaTimOk9UwnJ1mFtm47a
	 AjtGQSJnGz+8RwtPhplQb3zbgKdfNYI+P2tTgrX5SAIA51t3jqL/JjbWYmM6gpdEgTNBu
	 7H11YV6F/QmbTQTTs8ZbS7LOhRMjHs8FIRbaLHEwFVL3a/rQ+ft4PlRj2fY2zNphjPOnt
	 ppSaOrBzFR6/OvJ6xnwp8zBNJBAU30uICzOWHxITv8qJa5Hmaa/SHzsPXS+GsH3vDjVoh
	 FL1eOU3WajskOXVe43ZIY950dFZfi54EXPrJWOJuRKKI9Ixx43K4M0nZgNNGyJO7lJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673752;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/0GaP0jY7Sa5Y59job5VH/oxCy76oPBh2bAbY4OUnTU=;
	b=vX7imlFPOKGlUt/NKsHNdtL22a0EMb3id2/V/2HuH0/1lQS1PAB08Iy/iI+//5PKAYhQ
	 PPTIVyD9gExtWbPRoJpPsGHBwRq55SsCQ+Qw7mSDYF9wOwpSQ1GMxenCx3UhacLjdxd9e
	 /lQJm2IDsDsLLXz35lfThSfl4Uwnlwo6KJpP9kuU3wlLaG4xLfAGF1KBO3hMqlpNiH+Zd
	 nhQVbW2mypXc4u1xqrIdttJaU0SYU4csaYM+eLj524fRZSTu8G8MHWncmpklFxTiHY2kF
	 37uKMJMI2orO4L8/h8KOSD5DyroTwHPt/3BCOwBXUtdJotpwz1J8akscYNMyRG4US7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MHpi1OZ4;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=A7ZcJyGy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8FA606A31E;
	Thu, 26 Nov 2026 06:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F8FA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MHpi1OZ4;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=A7ZcJyGy
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36LjV2540568;
	Thu, 26 Nov 2026 00:15:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/0GaP0jY7Sa5Y59job5VH/oxCy76oPBh2bAbY4OUn
	TU=; b=MHpi1OZ49TPbN83SrAZGz7/EtsfZ93xpqvbvyUBgBA1iM3i8+JGDoFQLa
	zmIbj07Um6FxWFck4idjFhxJRy+g4d5dpvpe5KB5NzlB+HS3mbBs+liRL7eSjekf
	oam+IPwxHo6p278xZcnGhZZKViqrBMVPbVAytpVV4Yzn6DhQXcjV2tu6jADf4hVh
	Iy8v+dxlmnisxrvrBXrJcw+MwDuq4bJg/9TZ3zESKPmgMZmVbN77BjFSttz719cl
	Cc4Mt1LnbjG+YXr03biINPZkO4mcZf49/+4oeBW7wyXqDHfVrTsHPNQBj1DeBuqX
	YGcsunK4VY2mWgnGskF4HsdmQXxSQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	by m0384305.ppops.net (PPS) with ESMTPS id 4j606fd0an-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 00:15:01 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+Yx2rDuXZWKTKTDaWLF8SQe2EZRODRm1HxtlfNWnw+DfYIMmo+eqEmk5Qdz6OujAO9/Vpm0Yx64BdYChYBhPoyi5pa3jKDxRsNSIaDq5tr7XxJhDam4BJfCXzw4Ij0T5p+17LbwyFYMLl291hnirrzHFMpKNXy6q3i8DzWPFVPDP+7ubTBZ29X+dj9UCGUweDaThygSJqLknC7lsnGUHq6CqdFhisOkUOGUW+1kGiIGLr/5s9DYN2yjGEp0/DPQXcov6AX/D1G9aPeD4F7/ORH9Dy54q9sta4aUScG8bEBrO1WiympIRbox8ccCBvM+s17NiYA4r6eRrtXXAq9zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0GaP0jY7Sa5Y59job5VH/oxCy76oPBh2bAbY4OUnTU=;
 b=UvESs5vSXMeFvVw/qNuUMgYoJfPq6JLBcZhm/GdcxB/9C9JDu9sUrJJEyqKPzCJmo3zHOIAOy+qfHEql+jVCIsF+T1NhzbA2yvN2VnlkcqSE/6p5/6ZetKkdwxOuKr3twb6NaDyQT2ft88+MDCeRuCGRuk2V1jqML5K2G0vtP1YUxeWpeQNbPYMkG+AeGVHYgsOaaQEJYVOjcY2Hz8/HsghKl+9baZ65WVWc3/eY1Uk21D2cMTivFOV9EdeRl8Cj0DX4vwXsCjTb3WvsVQI/ZNbtCg5VO8f16Cx6p3VOCXyzXKao9iTFws28g+OuwCWEpLzMWTK6QVdqRP7c6RaR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0GaP0jY7Sa5Y59job5VH/oxCy76oPBh2bAbY4OUnTU=;
 b=A7ZcJyGyqSZePz3X5wniIsKh+1WCXDfnAWmt1D/FPNuJJMMROOqn5gY6goI/LvWaA/3zAXCf+fX29+S8klAJJPM/Mwra5/muX0935+Zxz0fv+9WgG8HyYj7HOuNclnwKRpy/xfNyQriy9qU+H51JWupkJPddsJrTiXQrD+r2NOo=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by LVWPR10MB997863.namprd10.prod.outlook.com (2603:10b6:408:3be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 06:11:57 +0000
Received: from MN1PEPF000793FC.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::38) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 26 Nov 2026 06:11:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF000793FC.mail.protection.outlook.com (10.167.249.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:11:55 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 26 Nov
 2026 00:11:03 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 26 Nov
 2026 00:11:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 26 Nov 2026 00:11:03 -0600
Received: from [172.24.231.93] (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AQ6AupX1090819;
	Thu, 26 Nov 2026 00:10:57 -0600
Message-ID: <b32f88cf-292f-4bf9-b118-d11f3e6af402@ti.com>
Date: Thu, 26 Nov 2026 11:40:55 +0530
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool RX flow
 classification support
To: Simon Horman <horms@kernel.org>,
        Marco Crivellari
	<marco.crivellari@suse.com>
CC: <kees+treewide@kernel.org>, <laixiangwu@cmss.chinamobile.com>,
        <philippe.schenker@impulsing.ch>, <haokexin@gmail.com>,
        <devnexen@gmail.com>, <jacob.e.keller@intel.com>, <sdf@fomichev.me>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        <danishanwar@ti.com>
References: <20261118184729.2302130-1-m-malladi@ti.com>
 <20261118184729.2302130-3-m-malladi@ti.com>
 <CAAofZF4XYd5z8X56DRARMxbu3t7QX48T7V69MPBw9TW1BQAmKg@mail.gmail.com>
 <20261125113634.GT31322@horms.kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20261125113634.GT31322@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FC:EE_|LVWPR10MB997863:EE_
X-MS-Office365-Filtering-Correlation-Id: 775d7cc4-b7f1-494b-71db-08df4b842c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|10067099003|261102130727099003|261022115727099003|261028144727099003|261022113327099003|261022105027099003|261026121527099003|261021123027099003|261021121427099003|261026140227099003|261026130827099003|261021130227099003|261021135927099003|56012099006|261022075727099003|261102123227099003|261009223027099003|4143699003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	V2zyzLi7RZdEBO2nRiFPywI5tiyGfk6ymtxG8nYq7usZMcih1JWW1c3QvYB7vTxW2ezJ8H3k8A7zBfPCw0kVw+BwZIwVmJlvKnu40w0uR+K7tBDgU++BHfGKrUH/xOZop4f2a6XXctAgWefjvtOn0mkAYbo/pvvJjAYFhDdpjVosrYa9oZnmEn2dubfeP+TYAAu59HTQzjIxFF1FEEnUlnTRwzmutSJHYItKv1TZJQYLXwf1CVHp/jGzFdIKjNVRqB+AIiWc3zFZ95UK82ROXZwznFMyf487NeW0Dha61smwfi5Q5/PRY7XPX0RqQxxiBP5EHxqz20aLH2XJ7UY02B7SQ5/1LELmuOaHpWGOlg7xt85imuCu+aRTg4qIE6DnMzhwN0VIC4mNTylq2T9zYawZkVMfG0G3Rgh3uQXtgyIrf7+jB3pqx0cBW1mgeZjcdpXESWrzbYQMK1uj8XSASsK0G6UbNxUeP1rXN8tDTWKbdvF7++uN0dskuEK3lRSKv/bN0gwcPycPedtEnfZZIPXrsMgtNqMHXNVoTJF0fcMoQz8rdDRCbsPsvBD7j5KvhGWApANKU1b9kGxisjX3PtrxFq7d2CehfNSUbPo8CX+WxhuQnFmgsWowpFbVbz0NJ+ihZQPXG5ORDqVOE5xjCA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(10067099003)(261102130727099003)(261022115727099003)(261028144727099003)(261022113327099003)(261022105027099003)(261026121527099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026130827099003)(261021130227099003)(261021135927099003)(56012099006)(261022075727099003)(261102123227099003)(261009223027099003)(4143699003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uEEp+YZg5stUBBw9MUFOsbyayM4p84oS7RwIJI6Rf57ClA3kXnTYG5rKiBXjodBbsekc5yXTdCohrPBlu1UcgwpTOZsO/UXgSvP4Zwx+QuOn9+FzSMMi1rDPQYUxBdf7qTS5B781y75Y51TmIrcvpgVJsTbLC+xqLhWXwF2RiWL15COpiX2ITUmwmkgE8T/RKojx3UCtZ7NxcSfZCnKwEPpN6tOBFMFjo1lh2L9/JbZcIH7txT9LbpSNgPXpPHRhLWr7/JAJZdewvpuo2sUiV9/ELUaYDeiJlMSyV66sCEqe51zuOei63lNp/3FmZqnCEbpQmoV/oThWEGfYHENmM/fXbCdSoj28VnXuunVn9tbeg16VxgfNwpK4e6mDU+wcLM9gwsJIZJbf5yEQfXhiPcijRR8xkPwZvcXIyOsYJNI975sZ09ZgfBzJDTNL6H49
X-Exchange-RoutingPolicyChecked:
	UMbi6lf3/ZnHPX5nRwDnBqWakLwzJxN6zQR6wtO9g1iBTv52E1WSuHtdrri6adPLlEMJVTbpFXvrzCgEzqpFQJKl/jOjx4g2gVTRutP3kpKwDkAZNWMbRreoavYi7XI9eObBC+8q4efaO6SUZKJw+fKlNw7gBfm+jezqAlp9Ks/HIPuZ4e3R8FF6fQD/FeLWGxpmNsU4Sd32fu1cLy8Hs6qHH5+nm3mYf2DT6cx+dNuP7GRxc51cO3shRNHvlWKUyXf3xnD25ptEelBR13ZOWZmc7Slu0OJFIdlkhkuolKb83QNqa8JpkdN/xxVh575NoDfrVrf6Mswem5VT96PZ/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:11:55.5416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775d7cc4-b7f1-494b-71db-08df4b842c0b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF000793FC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR10MB997863
X-Proofpoint-GUID: 1pcREU3s0YoO8_qHZ8ac7Qeae6HVa1me
X-Proofpoint-ORIG-GUID: 1pcREU3s0YoO8_qHZ8ac7Qeae6HVa1me
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfXzKy7YIYQefdn
 UvfD9qy6p7ol2R1the4gyMn+cTNigFj2WlcQY9frEOQGpdRkk8AiJqCYQAUn3TPIG8ybLYiU6Od
 MkzIYNp67ydBXKV01HXiHtAVwb57qPs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX9ir8bsvVaWM/
 wKKzP1kzsmVJpSUvHjmKyoPT6hRxayLxCXnADdOUH8mMMTY/q8GrWO9YqWMi6ZUHfsL/o9n2v5F
 QgwlTUrplJU33i3zS+PbFRVQxnNR/fBlQDefXkRKE0psJ6zbA21f1/unG55sHdFoSatBFhvryeh
 +SMSELX1OvGGoXuNAp8Zt9bDpwuGSDWbFdrcIQwHP4hZ+4w2DAPqILSEHPsjgwbigzx7kiwGI2k
 LclIHYncUG7niAlnoChhRlVU3FNNbIiTcWt4BUWGrXto9x9Owmbn1OhKPseb0txqHD0811+e43v
 Il6Jnj/e1LJlJfDUvit2VURS4zokgiJIEYVvCP04QdAzIHOjMA9qfXn8ng99Dzh0Zm0RAjJzDHi
 HPnLwiYUko8dARJH+FIOv81AMXsi208fq441xghtlYTpErX7ZKek2n7mtNrcvGWoGg7FLhFV7y0
 5A/ZfrnxiT4MTOhRqUA==
X-Authority-Analysis: v=2.4 cv=Ss4Fe/O0 c=1 sm=1 tr=0 ts=6b07ce65 cx=c_pps
 a=qId4hgiKfVM5Ptks7FQs9w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=Wjxvn9WGenj0ScDUp0oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260023

Hi Marco, Simon,

On 11/25/26 17:06, Simon Horman wrote:
> On Thu, Nov 19, 2026 at 10:19:48AM +0100, Marco Crivellari wrote:
>> Hi,
>>
>> On Wed, Nov 18, 2026 at 7:50 PM Meghana Malladi <m-malladi@ti.com> wrote:
>>> [...]
>>> +       mutex_lock(&emac->rxnfc.rxnfc_lock);
>>> +
>>> +       /* Check max rules */
>>> +       if (emac->rxnfc.rxnfc_rule_count >= ICSSG_RXNFC_MAX_RULES) {
>>> +               ret = -ENOSPC;
>>> +               goto unlock;
>>> +       }
>>>   [...]
>>> +
>>> +unlock:
>>> +       mutex_unlock(&emac->rxnfc.rxnfc_lock);
>>> +       return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_add);
>>
>> nit: instead of mutex_lock() you can use guard() [1]:
>>
>>      guard(mutex)(&emac->rxnfc.rxnfc_lock)
>>
>> and remove all the "goto unlock", returning directly. This handles the
>> automatic cleanup.
>>
>> Same for other places where you're using mutex_lock() / mutex_unlock().
>>
>> - [1] https://docs.kernel.org/core-api/cleanup.html
> 
> Thanks Marco,
> 
> That may be good general advice.
> But for networking code the explicit approach taken by this patch
> is still preferred.
> 
>    Using device-managed and cleanup.h constructs
> 
>    Netdev remains skeptical about promises of all “auto-cleanup” APIs,
>    including even devm_ helpers, historically. They are not the preferred
>    style of implementation, merely an acceptable one.
> 
>    Use of guard() is discouraged within any function longer than 20 lines,
>    scoped_guard() is considered more readable. Using normal lock/unlock is
>    still (weakly) preferred.
> 
>    Low level cleanup constructs (such as __free()) can be used when building
>    APIs and helpers, especially scoped iterators. However, direct use of
>    __free() within networking core and drivers is discouraged. Similar
>    guidance applies to declaring variables mid-function.
> 
>    Link: https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

Thanks for the insights! I had actually just implemented Marco's 
suggestion locally, so I'll revert that back now :/ I'll definitely give 
the netdev documentation a good read as well.
