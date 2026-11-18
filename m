Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795027803;
	b=K9jM83W7S6DlUKnMOaHG19a7405+fq5g7UmyO0iC9GQ/atgf6XoMI6rKHhG41mX8tuNY
	 9s1LBFS6fvfBTru9tlMut39A91M1X2zYzgf/R9d6kulO87suEhTZ1ux2V8jXInEYMxpYq
	 PNGK61jey8Rgq6Jg6a8R3knbYsQoYhGOZnKIJ3V5/4RPSvoc5g/TocubS9uWy9QgyOPyl
	 cBwStsmHdFdA5Gm7tdMrxGN5NQbI7UCHuKwqJOPk1uRzG9eBSpn8xq59XbP1ZS4iVPYJh
	 X8FoBZ1L/RkvVp2ISuYMJQpuBhYKCAtCs2oCmUyu4/glYUtVJGBtqs7QjfAuI2kzqUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027803;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lTng0t7kCezWKp84rIpbsnVpbPQMnrfCK+sxJEIYcek=;
	b=o8qLm3TJQH/qYXb079YQRyEvBM/3OP4qAbIGnUDocl38LzNHHpipLRTVsew5tZlq8W+Z
	 IqmrGeve+D6DXXecH2qoVg6e+Oq0JvGy4igEvS+EwQNBjEuvbuqi20WxcxD7camlssAts
	 9O1hMPZrr7vXGDWdxFkSmCfg9tx+mOIRwmdM8t1ra9W0f9ZH4MF/NK1i9xQFX8xZGMNDU
	 kHxaX1ee/jFzRERQxxrzv9ijapayR8fOO++xgv9PDmcrE+SigyKp1p53eH/29RnSEGLR4
	 KUHY54uawfCTsxKkfbS0mB6FUyX10KqQGDc1R3BkMXcv5MboU3PsHJAzpXdAftcQrcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=C1wMetHN;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=aMHHr2hD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EDB606A31C;
	Wed, 18 Nov 2026 18:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14EDB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=C1wMetHN;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=aMHHr2hD
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHGVjD3638369;
	Wed, 18 Nov 2026 12:49:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=lTng0t7kCezWKp84rIpbsnVpbPQMnrfCK+sxJEIYc
	ek=; b=C1wMetHNmP+Y4ZU3BhHOMZtezOw5HS3QZ1KDshwVgH8InD8wm3/aPIsE4
	53dMrn3IIdhzw5wSxp1cqsorOw7rB4D4w1o7hCkrI32coQZbPOTaNpozuPxjvZ5t
	vGHcPaKy1zwCDgdLKfbH/zpdpFVGvdDcQzBg3dsMiB6154IrHL7bAe9RxMRTQZHA
	2GRQs39F/x757XMjajBhZrqmkT/oJWUzb3A3FY0aWfULlF58+ix8abo0V6WQhM/k
	b28wBCytWptawQO2GeM+Yz9elqZVemFhYOOHAivlZbt+uWJ1tinR8dmfZfSF9AEV
	N2zamok0Ef7GLPyZLo+kMyGwokO4Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j19ft359k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 12:49:04 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feglMuzkwbMpO9iaZHzwnBP3f4P2t4gQs0VL4xM0IEFF3wgvGkKwJ63t19RpcHhlW+xurzmxv5td76+j0cIR8kFFGUJ7Rq1b6xSeXLRGQ4o0x1OL9GBYnnMnpdhaWD2xLUdoCCZGhemm32rui7o/YEnTS8aYorn3gRnSuyc8tj9BM63i0JfzN/WAXt0k5/8ljYtgKFc/vJg4NdpRn21esu8T1GQ+pAU39hP9N+btv0NIAg+s86hPsSapvMmR/J247/YSM/gUmqEP9ghkRPUx/s4oIpr//MsD5wEgkb/gXn9oAlJzTo0NE98G6QS9AgfsQJZHBGRwsCrqExcf7TfHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTng0t7kCezWKp84rIpbsnVpbPQMnrfCK+sxJEIYcek=;
 b=Dr78opLOPEXc7MkR4vqQCxNxgN2+sKlz5AkG48I99M3Ar8BqvD+Wx8xyVFNOFjXBU9qOMnq9JC9bf1IT8GDseRflyN6zxVWb+UZxxdb6MyRfnsIAQkdVKBiyXK9X5IJii75W9REIFGF2kBMdPENELs8TSVUMeqsCsmH/RXLo4uoUZdkzcKXBWH4rEvbPiEhGq72vWKfraytTqf31OStI3Z5FQC5QNESzj7IirIjIXBfvhIS2dLfZWSWvP8eDPyJNyOv3rwaspoqkd+9fv2yaJ0d3ek6VFMHEbHRn6mTuKKbkOATvhkRf11DpBhAx5nFUASrawQrELjsuuGItTOC5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=suse.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTng0t7kCezWKp84rIpbsnVpbPQMnrfCK+sxJEIYcek=;
 b=aMHHr2hD8Y4tTBiX4qWfNZEu9Fz5cc68niuhi4JnPeS8AHYnTPUXTUv3d+2yzwT/PztNc+6aLyHJpwX4MzKH0JYi5YbufxsDAPZZYNmQSZzB/lRA7oxGmGGefmS50y14l7TmbLj/yEbzxQ9sG2kAAjvRvphQbqckuVwtvX62unQ=
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:48:32 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::a0) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 18:48:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:48:25 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 12:47:39 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 12:47:39 -0600
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 18 Nov 2026 12:47:39 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AIIlcCQ321228;
	Wed, 18 Nov 2026 12:47:38 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6AIIlbCK007536;
	Wed, 18 Nov 2026 12:47:38 -0600
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
Subject: [PATCH net-next 1/2] net: ti: icssg-prueth: Add multi-flow RX support with per-flow NAPI
Date: Thu, 19 Nov 2026 00:17:26 +0530
Message-ID: <20261118184729.2302130-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118184729.2302130-1-m-malladi@ti.com>
References: <20261118184729.2302130-1-m-malladi@ti.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CO1PR10MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: c227a75d-8fa7-4607-43c5-08df45a48756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|36860700016|1800799024|376014|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261021135927099003|921020|261102130727099003|56012099006|10067099003|18002099003|22082099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|6133799003|261009223327099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZRl55+628bqcJclbb/DETWS2DYsXRD9HxqAgYMBazlUDVM/Ekt2bO67xAv2+/ZtAh+CQao4NiXE4qgopvdyK8P9mqpxQFnJnoHufiRMxezqvwWZKtggZpOy4MmoHg18nThnce25hknMEh/W2HE0KlhMayPcRFOUfaohWPDG3dIjgIadoem8fJUnJ1ubKADGY57/2zKDMnwIs0ppkU1vIIN+iPh2dKCYV2/EotyzpYi1TjYy/mrpLsvfHPexF/Z5JqUgy1qX1xSIZeu3UH/VDPl1UoycDH3DPNV89Ya6jtdWS5Eq+JzU051Wv4BMCUJLmdAIQdF72muQTrCJ/vtfBJBgxa8D+ERVJqMWq4hH964h+N7QjjbyWm0efd/1hXrnElvksJkJx7nhh9/gIhc06buN9bu5HGm4j3IkTI1t3Ojp5d+q9nnI88v6PrLV522wGg0jZf36b7xFaUk5xevwF7SPKrC23RhGciG9sjlgmZ9U08osPJXqdL3aUpHU7Mdnu/cEXNPHngLn4a/KR6pIqAGA70eK1jGrmvgSFk3zSqh0EI5OHNGK3ZRZwtoigcETfPPn29p4EbCmSDGiqG8xEhQZiq9bB3nMbrbxq/HMBYDPEE2WQ36nW1t2Qer5IP1pIEqoZdY9he0eJRP+qwd3a4gWju9njL5zYqy8l3BiVCSYhnEpTQenZ6IPZTIQ9VTor21Zz/Q2kvAwnTtSUmN5JDLJiAjt024TIx/FwivxZBTRRrmB4UsPbgerzCF4XxzSp
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(36860700016)(1800799024)(376014)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261021135927099003)(921020)(261102130727099003)(56012099006)(10067099003)(18002099003)(22082099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(6133799003)(261009223327099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jdm/7Y7afwwHMsIxUMl3rcQfwV+QfilZ4P46a3pfW54W4YdkdxrrpVFSJIqHVs97YU+e5R4CNvUWEl3GKFnol2GvnfV4TXoiLcClfnI9dk95veeuIxCDjfHHosmuVpGbIxa2vXiaAMUlUlNETfzXQn6Fby6AJ/eZuNhg8ONDgYIfiJKMLgKe/rNXYCBa3xqHd38fcCGoKVOdLPb0jbHmoNCoAI55ZduIH4KdxIWuogjDplHZo2hJ4EVbtfqkv0EsCNxRfbD7JTTcumN+x0d08n8Nt57TEuM/OrH6S8iDD/ySGqYsMmsIjdfZSKX00v/fpEQYOx1aH23HEYCm/JULrxFzgxvVxreWYGCZXaYZPRN2p2xiU62ge1jut9ctQISdQWsYSfF+i3vdMkkBpCUXodWQHHTJKOOdkN/NmHS5w8g40JcBPDWNFO5oTEqYZ4yj
X-Exchange-RoutingPolicyChecked:
	fdq2h805XpOzNukH1AOolO6uz5rjRd0SbvqfPREgSJcV/e14R9LC3CuoC1SxUWaaRO/SzwwtrdyNnWKwp5MJUinkvMTouREpTJl4byEJ4Pi5FVRJkdKR85pXJJywu9hDFJNGiYKVgxENpSrpoHwb1LBBPL/X6L/LVwY94XAEv3MoPXtQ0K4l9hgH4Dpk0ZOlF3yo9EYvNeUeIFJYbO46cPp+wRPWYUqemSRTWUMecNrbg9sxufSepYiZ6jxHoMqUI5Ig9pCWn1u/TFtyIpzdlmMXNaYFgHyyfMAkGAza772HXWZ0Q9nKPkpmPOKaDn4aL50TeOX6DNw5y4IsQxAf2Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:48:25.6061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c227a75d-8fa7-4607-43c5-08df45a48756
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Authority-Analysis: v=2.4 cv=NMFAaE6g c=1 sm=1 tr=0 ts=6afdf320 cx=c_pps
 a=4QVYENZnsEoURNel/cbnog==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=86EWBTCqkmpres7dKK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hdI0bYHdN7dwZEGpvOp5Q4bo6fpitn-q
X-Proofpoint-ORIG-GUID: hdI0bYHdN7dwZEGpvOp5Q4bo6fpitn-q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfXx360nsWRSMBE
 bQaZLOnfoA0cwL1XYpSroLbXUpn+5nTD3GMe+zTJp8H+Nj+AorbXkNySuGdpZN/dZj2ZNWaf2Fm
 wUWM9aMmcqgDQjy46lXxlHHEJ1+ESAY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX+9gZeLXS6R7i
 kaijbaPOkBFbEtkppRaiIWOkmhOjmiyadtkAtL7+rlIBuVD65CcPwh2k3HuKZdfAlG9/mlsGN+r
 32e0p2Y1QO+p5jVKqHvCL+iKjZ5C6NtHRxx2dmO/dr5//T7K65dxtaYHGFJJhNLrki9g23AqoC+
 rRl2bVtTjX0YLQS5uSmmHk7K9lcRkUNvjBI7qBO7gGtzUhMvHY18ftVsis1YSSpS1k1J+A0+4Z4
 iO0VydbgwA0PgAZnzyLLUGjNqbc+anngmL5O0iEgysWsXMdVMUdNhb83RaPg5V9cxi9FsqTEko4
 juddzXRmh7P8O4UsAKLIPZQ2aWtIaryXcPY9gowAO/sHBtOfkd1POKtXv5Z79ASjpBBIZW5XIUD
 tKbr4Zr6dXDRd+mPcUEW5LhJpI+RuYl5OGtD3QxKxsmk4AtaG8WQ36cHI3schqYGEY/zE0hrtmK
 AVDRO9z0eCPRhDiuc3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180074

Extend ICSSG driver to support up to 8 independent RX flows per EMAC
(PRUETH_MAX_RX_FLOWS 1 --> 8), enabling ethtool queue steering via set_rxnfc.

Data structures:
- Introduce prueth_rx_flow for per-flow state: NAPI, hrtimer, page pool,
  XDP rxq, AF_XDP pool, IRQ. All flows share one UDMA channel and
  descriptor pool (PRUETH_MAX_RX_DESC x flow_count).
- Restructure prueth_rx_chn: strip per-flow fields, add flows[] array.
- Add flow_id to prueth_swdata so recycled pages return to the correct
  per-flow page pool (previously always used flows[0]).
- Replace xsk_qid int with xsk_queues bitmap for multi-pool AF_XDP.

Channel lifecycle:
- prueth_create_rxq / prueth_destroy_rxq operate on a single flow.
- prueth_create_rxqs / prueth_destroy_rxqs iterate all active flows and
  enable the shared UDMA channel only after all flows are ready.
- prueth_ndev_add_rx_napi / prueth_ndev_del_rx_napi register per-flow
  NAPI, hrtimer, and IRQ with teardown on partial failure.
ethtool: report rx_flow_num active queues; ICSSG_MAX_RFLOWS as max.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

RFC->v1 changelog:
sashiko comments addressed:
- unsigned int irq handling, and flow->irq <= 0 returns 0 (success)
- desc_rx leaked on prueth_dma_rx_push_mapped() and _zc() failure
- prueth_dma_rx_push_mapped_zc hardcodes flow 0
- XSK desc_avail not capped per-flow
- emac_set_coalesce only updates flow 0 timeout 
- IRQ left permanently disabled after hrtimer_cancel
- NAPI scheduling in teardown restricted to XSK flows
- xdp_rxq_info_reg hardcodes queue index 0
- prueth_create_rxq error path calls napi_disable before napi_enable
- alloc_etherdev_mq + no netif_set_real_num_rx_queues
- prueth_set_xsk_pool hardcodes PRUETH_RX_FLOW_DATA
- prueth_xsk_pool_enable/disable missing rx_flow_num check+ error cleanup
- prueth_xsk_wakeup OOB test_bit + rx_flow hardcoded to flow 0
- bitmap fail goto free_ndev skips pruss_release_mem_region

sashiko comments skipped:
- rxfdq_cfg.size not scaled for multi-flow
- Shared FDQ per-flow reset issues
As single_fdq=false on BCDMA/PKTDMA (AM64xx)

 drivers/net/ethernet/ti/icssg/icssg_common.c  | 378 +++++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  18 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 327 ++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  60 +--
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  | 266 +++++++++---
 6 files changed, 676 insertions(+), 380 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 4a7d1a6f470b1..6cd2a77c491ac 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -39,16 +39,10 @@
 				 NETIF_MSG_HW | \
 				 NETIF_MSG_WOL)
 
-#define prueth_napi_to_emac(napi) container_of(napi, struct prueth_emac, napi_rx)
 
-void prueth_cleanup_rx_chns(struct prueth_emac *emac,
-			    struct prueth_rx_chn *rx_chn,
-			    int max_rflows)
+void prueth_cleanup_rx_chns(struct prueth_emac *emac)
 {
-	if (rx_chn->pg_pool) {
-		page_pool_destroy(rx_chn->pg_pool);
-		rx_chn->pg_pool = NULL;
-	}
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
 
 	if (rx_chn->desc_pool)
 		k3_cppi_desc_pool_destroy(rx_chn->desc_pool);
@@ -79,6 +73,20 @@ void prueth_cleanup_tx_chns(struct prueth_emac *emac)
 }
 EXPORT_SYMBOL_GPL(prueth_cleanup_tx_chns);
 
+void prueth_ndev_del_rx_napi(struct prueth_emac *emac, int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[i];
+
+		if (rx_flow->irq)
+			free_irq(rx_flow->irq, &rx_flow->napi_rx);
+		netif_napi_del(&rx_flow->napi_rx);
+	}
+}
+EXPORT_SYMBOL_GPL(prueth_ndev_del_rx_napi);
+
 void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num)
 {
 	int i;
@@ -311,6 +319,19 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 	return num_tx;
 }
 
+static enum hrtimer_restart emac_rx_timer_callback(struct hrtimer *timer)
+{
+	struct prueth_rx_flow *rx_flow =
+				container_of(timer, struct prueth_rx_flow, rx_hrtimer);
+
+	if (rx_flow->irq_disabled) {
+		/* re-enable the RX IRQ */
+		rx_flow->irq_disabled = false;
+		enable_irq(rx_flow->irq);
+	}
+	return HRTIMER_NORESTART;
+}
+
 static enum hrtimer_restart emac_tx_timer_callback(struct hrtimer *timer)
 {
 	struct prueth_tx_chn *tx_chns =
@@ -363,6 +384,35 @@ static irqreturn_t prueth_tx_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+int prueth_ndev_add_rx_napi(struct prueth_emac *emac)
+{
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth *prueth = emac->prueth;
+	struct prueth_rx_flow *flow;
+	int i, ret;
+
+	for (i = 0; i < emac->rx_flow_num; i++) {
+		flow = &rx_chn->flows[i];
+
+		netif_napi_add(emac->ndev, &flow->napi_rx, icssg_napi_rx_poll);
+		hrtimer_setup(&flow->rx_hrtimer, &emac_rx_timer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
+		ret = request_irq(emac->rx_chns.flows[i].irq, prueth_rx_irq,
+				  IRQF_TRIGGER_HIGH, flow->name, &flow->napi_rx);
+		if (ret) {
+			netif_napi_del(&flow->napi_rx);
+			dev_err(prueth->dev, "unable to request RX IRQ\n");
+			goto fail;
+		}
+	}
+
+	return 0;
+fail:
+	prueth_ndev_del_rx_napi(emac, i);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(prueth_ndev_add_rx_napi);
+
 int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
@@ -475,7 +525,8 @@ EXPORT_SYMBOL_GPL(prueth_init_tx_chns);
 
 static struct page_pool *prueth_create_page_pool(struct prueth_emac *emac,
 						 struct device *dma_dev,
-						 int size)
+						 int size,
+						 struct prueth_rx_flow *rx_flow)
 {
 	struct page_pool_params pp_params = { 0 };
 	struct page_pool *pool;
@@ -486,7 +537,7 @@ static struct page_pool *prueth_create_page_pool(struct prueth_emac *emac,
 	pp_params.nid = dev_to_node(emac->prueth->dev);
 	pp_params.dma_dir = DMA_BIDIRECTIONAL;
 	pp_params.dev = dma_dev;
-	pp_params.napi = &emac->napi_rx;
+	pp_params.napi = &rx_flow->napi_rx;
 	pp_params.max_len = PAGE_SIZE;
 
 	pool = page_pool_create(&pp_params);
@@ -496,38 +547,30 @@ static struct page_pool *prueth_create_page_pool(struct prueth_emac *emac,
 	return pool;
 }
 
-int prueth_init_rx_chns(struct prueth_emac *emac,
-			struct prueth_rx_chn *rx_chn,
-			char *name, u32 max_rflows,
-			u32 max_desc_num)
+int prueth_init_rx_chns(struct prueth_emac *emac)
 {
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
 	struct k3_udma_glue_rx_channel_cfg rx_cfg;
 	struct device *dev = emac->prueth->dev;
 	struct net_device *ndev = emac->ndev;
+	struct prueth_rx_flow *flow;
 	u32 fdqring_id, hdesc_size;
-	struct page_pool *pool;
 	int i, ret = 0, slice;
-	int flow_id_base;
+	char udma_name[32];
 
 	slice = prueth_emac_slice(emac);
 	if (slice < 0)
 		return slice;
 
-	/* To differentiate channels for SLICE0 vs SLICE1 */
-	snprintf(rx_chn->name, sizeof(rx_chn->name), "%s%d", name, slice);
-
 	hdesc_size = cppi5_hdesc_calc_size(true, PRUETH_NAV_PS_DATA_SIZE,
 					   PRUETH_NAV_SW_DATA_SIZE);
 	memset(&rx_cfg, 0, sizeof(rx_cfg));
 	rx_cfg.swdata_size = PRUETH_NAV_SW_DATA_SIZE;
-	rx_cfg.flow_id_num = max_rflows;
+	rx_cfg.flow_id_num = emac->rx_flow_num;
 	rx_cfg.flow_id_base = -1; /* udmax will auto select flow id base */
 
-	/* init all flows */
-	rx_chn->dev = dev;
-	rx_chn->descs_num = max_desc_num;
-
-	rx_chn->rx_chn = k3_udma_glue_request_rx_chn(dev, rx_chn->name,
+	snprintf(udma_name, sizeof(udma_name), "%s%d", "rx", slice);
+	rx_chn->rx_chn = k3_udma_glue_request_rx_chn(dev, udma_name,
 						     &rx_cfg);
 	if (IS_ERR(rx_chn->rx_chn)) {
 		ret = PTR_ERR(rx_chn->rx_chn);
@@ -536,11 +579,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 		goto fail;
 	}
 
+	/* Initialize the RX channel (shared by all flows) */
+	rx_chn->emac = emac;
+	rx_chn->descs_num = PRUETH_MAX_RX_DESC * rx_cfg.flow_id_num;
 	rx_chn->dma_dev = k3_udma_glue_rx_get_dma_device(rx_chn->rx_chn);
 	rx_chn->desc_pool = k3_cppi_desc_pool_create_name(rx_chn->dma_dev,
 							  rx_chn->descs_num,
 							  hdesc_size,
-							  rx_chn->name);
+							  "rx_desc_pool");
 	if (IS_ERR(rx_chn->desc_pool)) {
 		ret = PTR_ERR(rx_chn->desc_pool);
 		rx_chn->desc_pool = NULL;
@@ -548,22 +594,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 		goto fail;
 	}
 
-	pool = prueth_create_page_pool(emac, rx_chn->dma_dev, rx_chn->descs_num);
-	if (IS_ERR(pool)) {
-		ret = PTR_ERR(pool);
-		goto fail;
+	for (i = 0; i < rx_cfg.flow_id_num; i++) {
+		flow = &rx_chn->flows[i];
+		flow->pg_pool = NULL;
+		flow->xsk_pool = NULL;
 	}
 
-	rx_chn->pg_pool = pool;
-
-	flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
-	if (emac->is_sr1 && !strcmp(name, "rxmgm")) {
-		emac->rx_mgm_flow_id_base = flow_id_base;
-		netdev_dbg(ndev, "mgm flow id base = %d\n", flow_id_base);
-	} else {
-		emac->rx_flow_id_base = flow_id_base;
-		netdev_dbg(ndev, "flow id base = %d\n", flow_id_base);
-	}
+	emac->rx_flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
+	netdev_dbg(ndev, "flow id base = %d\n", emac->rx_flow_id_base);
 
 	fdqring_id = K3_RINGACC_RING_ID_ANY;
 	for (i = 0; i < rx_cfg.flow_id_num; i++) {
@@ -584,9 +622,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 				K3_UDMA_GLUE_SRC_TAG_LO_USE_REMOTE_SRC_TAG,
 		};
 
+		flow = &rx_chn->flows[i];
+		flow->emac = emac;
+		flow->id = i;
+		flow->irq = -EINVAL;
+
 		rx_flow_cfg.ring_rxfdq0_id = fdqring_id;
-		rx_flow_cfg.rx_cfg.size = max_desc_num;
-		rx_flow_cfg.rxfdq_cfg.size = max_desc_num;
+		rx_flow_cfg.rx_cfg.size = PRUETH_MAX_RX_DESC;
+		rx_flow_cfg.rxfdq_cfg.size = PRUETH_MAX_RX_DESC;
 		rx_flow_cfg.rxfdq_cfg.mode = emac->prueth->pdata.fdqring_mode;
 
 		ret = k3_udma_glue_rx_flow_init(rx_chn->rx_chn,
@@ -599,31 +642,36 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 		if (!i)
 			fdqring_id = k3_udma_glue_rx_flow_get_fdq_id(rx_chn->rx_chn,
 								     i);
-		ret = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
-		if (ret < 0) {
+		flow->irq = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
+		if (flow->irq <= 0) {
+			ret = flow->irq < 0 ? flow->irq : -EINVAL;
 			netdev_err(ndev, "Failed to get rx dma irq");
 			goto fail;
 		}
-		rx_chn->irq[i] = ret;
+
+		snprintf(flow->name, sizeof(flow->name),
+			 "%s-rx%d-%d", dev_name(dev), slice, i);
 	}
 
 	return 0;
 
 fail:
-	prueth_cleanup_rx_chns(emac, rx_chn, max_rflows);
+	prueth_cleanup_rx_chns(emac);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(prueth_init_rx_chns);
 
 int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
 			      struct prueth_rx_chn *rx_chn,
-			      struct page *page, u32 buf_len)
+			      struct page *page, u32 buf_len,
+			      int flow_id)
 {
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
 	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma;
 	dma_addr_t buf_dma;
+	int ret;
 
 	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;
 	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
@@ -641,9 +689,12 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
 	swdata->type = PRUETH_SWDATA_PAGE;
 	swdata->data.page = page;
+	swdata->flow_id = flow_id;
 
-	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
-					desc_rx, desc_dma);
+	ret = k3_udma_glue_push_rx_chn(rx_chn->rx_chn, flow_id, desc_rx, desc_dma);
+	if (ret)
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(prueth_dma_rx_push_mapped);
 
@@ -860,14 +911,17 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len
 
 static int prueth_dma_rx_push_mapped_zc(struct prueth_emac *emac,
 					struct prueth_rx_chn *rx_chn,
-					struct xdp_buff *xdp)
+					struct xdp_buff *xdp,
+					int flow_id)
 {
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[flow_id];
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
 	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma;
 	dma_addr_t buf_dma;
 	int buf_len;
+	int ret;
 
 	buf_dma = xsk_buff_xdp_get_dma(xdp);
 	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
@@ -880,28 +934,32 @@ static int prueth_dma_rx_push_mapped_zc(struct prueth_emac *emac,
 	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
 			 PRUETH_NAV_PS_DATA_SIZE);
 	k3_udma_glue_rx_dma_to_cppi5_addr(rx_chn->rx_chn, &buf_dma);
-	buf_len = xsk_pool_get_rx_frame_size(rx_chn->xsk_pool);
+	buf_len = xsk_pool_get_rx_frame_size(rx_flow->xsk_pool);
 	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
 	swdata->type = PRUETH_SWDATA_XSK;
 	swdata->data.xdp = xdp;
+	swdata->flow_id = flow_id;
 
-	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
+	ret = k3_udma_glue_push_rx_chn(rx_chn->rx_chn, flow_id,
 					desc_rx, desc_dma);
+	if (ret)
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+	return ret;
 }
 
-static int prueth_rx_alloc_zc(struct prueth_emac *emac, int budget)
+static int prueth_rx_alloc_zc(struct prueth_emac *emac, int flow_id, int budget)
 {
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[flow_id];
 	struct xdp_buff *xdp;
 	int i, ret;
 
 	for (i = 0; i < budget; i++) {
-		xdp = xsk_buff_alloc(rx_chn->xsk_pool);
+		xdp = xsk_buff_alloc(rx_flow->xsk_pool);
 		if (!xdp)
 			break;
 
-		ret = prueth_dma_rx_push_mapped_zc(emac, rx_chn, xdp);
+		ret = prueth_dma_rx_push_mapped_zc(emac, &emac->rx_chns, xdp, flow_id);
 		if (ret) {
 			netdev_err(emac->ndev, "rx alloc: failed to map descriptors to xdp buff\n");
 			xsk_buff_free(xdp);
@@ -912,14 +970,14 @@ static int prueth_rx_alloc_zc(struct prueth_emac *emac, int budget)
 	return i;
 }
 
-static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *psdata)
+static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *psdata, int flow_id)
 {
 	unsigned int headroom = xdp->data - xdp->data_hard_start;
 	unsigned int pkt_len = xdp->data_end - xdp->data;
 	struct net_device *ndev = emac->ndev;
 	struct sk_buff *skb;
 
-	skb = napi_alloc_skb(&emac->napi_rx, xdp->data_end - xdp->data_hard_start);
+	skb = napi_alloc_skb(&emac->rx_chns.flows[flow_id].napi_rx, xdp->data_end - xdp->data_hard_start);
 	if (unlikely(!skb)) {
 		ndev->stats.rx_dropped++;
 		return;
@@ -938,7 +996,7 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
 		skb->offload_fwd_mark = emac->offload_fwd_mark;
 	skb->protocol = eth_type_trans(skb, ndev);
 
-	napi_gro_receive(&emac->napi_rx, skb);
+	napi_gro_receive(&emac->rx_chns.flows[flow_id].napi_rx, skb);
 	ndev->stats.rx_bytes += pkt_len;
 	ndev->stats.rx_packets++;
 }
@@ -947,6 +1005,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 			     int budget)
 {
 	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[flow_id];
 	u32 buf_dma_len, pkt_len, port_id = 0;
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
@@ -997,7 +1056,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 			switch (ret) {
 			case ICSSG_XDP_PASS:
 				/* prepare skb and send to n/w stack */
-				emac_dispatch_skb_zc(emac, xdp, psdata);
+				emac_dispatch_skb_zc(emac, xdp, psdata, flow_id);
 				xsk_buff_free(xdp);
 				break;
 			case ICSSG_XDP_CONSUMED:
@@ -1010,7 +1069,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 			}
 		} else {
 			/* prepare skb and send to n/w stack */
-			emac_dispatch_skb_zc(emac, xdp, psdata);
+			emac_dispatch_skb_zc(emac, xdp, psdata, flow_id);
 			xsk_buff_free(xdp);
 		}
 		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
@@ -1022,13 +1081,13 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 	avail_desc = k3_cppi_desc_pool_avail(rx_chn->desc_pool);
 	alloc_budget = min_t(int, budget, avail_desc);
 
-	ret = prueth_rx_alloc_zc(emac, alloc_budget);
+	ret = prueth_rx_alloc_zc(emac, flow_id, alloc_budget);
 
-	if (xsk_uses_need_wakeup(rx_chn->xsk_pool)) {
+	if (xsk_uses_need_wakeup(rx_flow->xsk_pool)) {
 		if (ret < alloc_budget)
-			xsk_set_rx_need_wakeup(rx_chn->xsk_pool);
+			xsk_set_rx_need_wakeup(rx_flow->xsk_pool);
 		else
-			xsk_clear_rx_need_wakeup(rx_chn->xsk_pool);
+			xsk_clear_rx_need_wakeup(rx_flow->xsk_pool);
 	}
 
 	return count;
@@ -1037,6 +1096,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 {
 	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[flow_id];
 	u32 buf_dma_len, pkt_len, port_id = 0;
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
@@ -1051,7 +1111,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	void *pa;
 
 	*xdp_state = 0;
-	pool = rx_chn->pg_pool;
+	pool = rx_flow->pg_pool;
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
 	if (ret) {
 		if (ret != -ENODATA)
@@ -1093,7 +1153,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 
 	pa = page_address(page);
 	if (prueth_xdp_is_enabled(emac)) {
-		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
+		xdp_init_buff(&xdp, PAGE_SIZE, &rx_flow->xdp_rxq);
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
 		*xdp_state = emac_run_xdp(emac, &xdp, &pkt_len);
@@ -1132,15 +1192,15 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	skb->protocol = eth_type_trans(skb, ndev);
 
 	skb_mark_for_recycle(skb);
-	napi_gro_receive(&emac->napi_rx, skb);
+	napi_gro_receive(&emac->rx_chns.flows[flow_id].napi_rx, skb);
 	ndev->stats.rx_bytes += pkt_len;
 	ndev->stats.rx_packets++;
 
 requeue:
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 	/* queue another RX DMA */
-	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
-					PRUETH_MAX_PKT_SIZE);
+	ret = prueth_dma_rx_push_mapped(emac, rx_chn, new_page,
+					PRUETH_MAX_PKT_SIZE, flow_id);
 	if (WARN_ON(ret < 0)) {
 		page_pool_recycle_direct(pool, new_page);
 		ndev->stats.rx_errors++;
@@ -1155,19 +1215,22 @@ void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
 	struct prueth_rx_chn *rx_chn = data;
 	struct cppi5_host_desc_t *desc_rx;
 	struct prueth_swdata *swdata;
-	struct page_pool *pool;
+	struct page_pool *pool = NULL;
 	struct xdp_buff *xdp;
 	struct page *page;
 
-	pool = rx_chn->pg_pool;
 	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	if (rx_chn->xsk_pool) {
+
+	if (swdata->type == PRUETH_SWDATA_XSK) {
 		xdp = swdata->data.xdp;
 		xsk_buff_free(xdp);
-	} else {
-		page = swdata->data.page;
-		page_pool_recycle_direct(pool, page);
+	} else if (swdata->type == PRUETH_SWDATA_PAGE) {
+		pool = rx_chn->flows[swdata->flow_id].pg_pool;
+		if (pool) {
+			page = swdata->data.page;
+			page_pool_recycle_direct(pool, page);
+		}
 	}
 
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
@@ -1411,11 +1474,12 @@ EXPORT_SYMBOL_GPL(prueth_tx_cleanup);
 
 irqreturn_t prueth_rx_irq(int irq, void *dev_id)
 {
-	struct prueth_emac *emac = dev_id;
+	struct napi_struct *napi_rx = dev_id;
+	struct prueth_rx_flow *rx_flow = container_of(napi_rx, struct prueth_rx_flow, napi_rx);
 
-	emac->rx_chns.irq_disabled = true;
+	rx_flow->irq_disabled = true;
 	disable_irq_nosync(irq);
-	napi_schedule(&emac->napi_rx);
+	napi_schedule(napi_rx);
 
 	return IRQ_HANDLED;
 }
@@ -1436,50 +1500,38 @@ EXPORT_SYMBOL_GPL(prueth_cleanup_tx_ts);
 
 int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 {
-	struct prueth_emac *emac = prueth_napi_to_emac(napi_rx);
-	int rx_flow = emac->is_sr1 ?
-		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
-	int flow = emac->is_sr1 ?
-		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = prueth_napi_to_rx_chn(napi_rx);
+	struct prueth_emac *emac = rx_flow->emac;
 	int xdp_state_or = 0;
 	int num_rx = 0;
-	int cur_budget;
 	u32 xdp_state;
 	int ret;
 
-	while (flow--) {
-		if (rx_chn->xsk_pool) {
-			num_rx = emac_rx_packet_zc(emac, flow, budget);
-		} else {
-			cur_budget = budget - num_rx;
-
-			while (cur_budget--) {
-				ret = emac_rx_packet(emac, flow, &xdp_state);
-				xdp_state_or |= xdp_state;
-				if (ret)
-					break;
-				num_rx++;
-			}
+	if (rx_flow->xsk_pool) {
+		num_rx = emac_rx_packet_zc(emac, rx_flow->id, budget);
+	} else {
+		while (budget - num_rx > 0) {
+			ret = emac_rx_packet(emac, rx_flow->id, &xdp_state);
+			xdp_state_or |= xdp_state;
+			if (ret)
+				break;
+			num_rx++;
 		}
-
-		if (num_rx >= budget)
-			break;
 	}
 
 	if (xdp_state_or & ICSSG_XDP_REDIR)
 		xdp_do_flush();
 
 	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
-		if (unlikely(emac->rx_pace_timeout_ns)) {
-			hrtimer_start(&emac->rx_hrtimer,
-				      ns_to_ktime(emac->rx_pace_timeout_ns),
+		if (unlikely(rx_flow->rx_pace_timeout_ns)) {
+			hrtimer_start(&rx_flow->rx_hrtimer,
+				      ns_to_ktime(rx_flow->rx_pace_timeout_ns),
 				      HRTIMER_MODE_REL_PINNED);
 		} else {
-			if (emac->rx_chns.irq_disabled) {
+			if (rx_flow->irq_disabled) {
 				/* re-enable the RX IRQ */
-				emac->rx_chns.irq_disabled = false;
-				enable_irq(emac->rx_chns.irq[rx_flow]);
+				rx_flow->irq_disabled = false;
+				enable_irq(rx_flow->irq);
 			}
 		}
 	}
@@ -1488,59 +1540,81 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 }
 EXPORT_SYMBOL_GPL(icssg_napi_rx_poll);
 
-int prueth_prepare_rx_chan(struct prueth_emac *emac,
-			   struct prueth_rx_chn *chn,
-			   int buf_size)
+int prueth_prepare_rx_flow(struct prueth_emac *emac,
+			   int flow)
 {
+	int buf_size = PRUETH_MAX_PKT_SIZE;
+	struct prueth_rx_flow *rx_flow;
+	struct prueth_rx_chn *rx_chn;
+	struct page_pool *pool;
 	struct page *page;
 	int desc_avail;
 	int i, ret;
 
-	desc_avail = k3_cppi_desc_pool_avail(chn->desc_pool);
-	if (desc_avail < chn->descs_num)
-		netdev_warn(emac->ndev,
-			    "not enough RX descriptors available %d < %d\n",
-			    desc_avail, chn->descs_num);
+	rx_chn = &emac->rx_chns;
+	rx_flow = &emac->rx_chns.flows[flow];
 
-	if (chn->xsk_pool) {
-		/* get pages from xsk_pool and push to RX ring
-		 * queue as much as possible
+	if (rx_flow->xsk_pool) {
+		/* XSK zero-copy: buffers come from the XSK fill ring, no page
+		 * pool needed.  Push up to PRUETH_MAX_RX_DESC XSK buffers.
 		 */
-		ret = prueth_rx_alloc_zc(emac, desc_avail);
-		if (!ret)
-			goto recycle_alloc_pg;
-	} else {
-		for (i = 0; i < desc_avail; i++) {
-			/* NOTE: we're not using memory efficiently here.
-			 * 1 full page (4KB?) used here instead of
-			 * PRUETH_MAX_PKT_SIZE (~1.5KB?)
-			 */
-			page = page_pool_dev_alloc_pages(chn->pg_pool);
-			if (!page) {
-				netdev_err(emac->ndev, "couldn't allocate rx page\n");
-				ret = -ENOMEM;
-				goto recycle_alloc_pg;
-			}
+		desc_avail = k3_cppi_desc_pool_avail(rx_chn->desc_pool);
+		if (desc_avail < PRUETH_MAX_RX_DESC) {
+			netdev_err(emac->ndev,
+				   "not enough RX descriptors available %d < %d\n",
+				   desc_avail, PRUETH_MAX_RX_DESC);
+			return -ENOSPC;
+		}
 
-			ret = prueth_dma_rx_push_mapped(emac, chn, page, buf_size);
-			if (ret < 0) {
-				netdev_err(emac->ndev,
-					   "cannot submit page for rx chan %s ret %d\n",
-					   chn->name, ret);
-				page_pool_recycle_direct(chn->pg_pool, page);
-				goto recycle_alloc_pg;
-			}
+		prueth_rx_alloc_zc(emac, flow, PRUETH_MAX_RX_DESC);
+		return 0;
+	}
+
+	pool = prueth_create_page_pool(emac, rx_chn->dma_dev, rx_chn->descs_num, rx_flow);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	rx_flow->pg_pool = pool;
+
+	desc_avail = k3_cppi_desc_pool_avail(rx_chn->desc_pool);
+	if (desc_avail < PRUETH_MAX_RX_DESC) {
+		netdev_err(emac->ndev,
+			   "not enough RX descriptors available %d < %d\n",
+			   desc_avail, PRUETH_MAX_RX_DESC);
+		ret = -ENOSPC;
+		goto err_free_pushed;
+	}
+
+	for (i = 0; i < PRUETH_MAX_RX_DESC; ++i) {
+		page = page_pool_dev_alloc_pages(pool);
+		if (!page) {
+			netdev_err(emac->ndev, "couldn't allocate rx page\n");
+			ret = -ENOMEM;
+			goto err_free_pushed;
+		}
+
+		ret = prueth_dma_rx_push_mapped(emac, rx_chn, page, buf_size, flow);
+		if (ret < 0) {
+			netdev_err(emac->ndev,
+				   "cannot submit skb for rx chan %s ret %d\n",
+				   rx_flow->name, ret);
+			page_pool_recycle_direct(pool, page);
+			goto err_free_pushed;
 		}
 	}
 
 	return 0;
 
-recycle_alloc_pg:
-	prueth_reset_rx_chan(&emac->rx_chns, PRUETH_MAX_RX_FLOWS, false);
-
+err_free_pushed:
+	/* i pages were successfully pushed to the ring.  Reset the channel
+	 * to drain them back and recycle via prueth_rx_cleanup before the
+	 * caller destroys the page pool.
+	 */
+	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, flow, rx_chn,
+				   prueth_rx_cleanup);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(prueth_prepare_rx_chan);
+EXPORT_SYMBOL_GPL(prueth_prepare_rx_flow);
 
 void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 			  bool free_skb)
@@ -1557,16 +1631,20 @@ void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 }
 EXPORT_SYMBOL_GPL(prueth_reset_tx_chan);
 
-void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
-			  int num_flows, bool disable)
+void prueth_reset_rx_chan(struct prueth_emac *emac, bool disable)
 {
 	int i;
+	int num_flows = emac->rx_flow_num;
+	struct prueth_rx_chn *chn;
+
+	chn = &emac->rx_chns;
 
 	for (i = 0; i < num_flows; i++)
 		k3_udma_glue_reset_rx_chn(chn->rx_chn, i, chn,
 					  prueth_rx_cleanup);
+
 	if (disable)
-		k3_udma_glue_disable_rx_chn(chn->rx_chn);
+		k3_udma_glue_disable_rx_chn(emac->rx_chns.rx_chn);
 }
 EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
 
@@ -1752,8 +1830,6 @@ void prueth_netdev_exit(struct prueth *prueth,
 	if (of_phy_is_fixed_link(emac->phy_node))
 		of_phy_deregister_fixed_link(emac->phy_node);
 
-	netif_napi_del(&emac->napi_rx);
-
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 60d69744ffae2..25f5863d27028 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -23,7 +23,12 @@ struct icssg_flow_cfg {
 #define PRUETH_NAV_SW_DATA_SIZE	16	/* SW related data size */
 #define PRUETH_MAX_TX_DESC	512
 #define PRUETH_MAX_RX_DESC	512
-#define PRUETH_MAX_RX_FLOWS	1	/* excluding default flow */
+
+/* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
+ * and lower three are lower priority channels or threads.
+ */
+#define PRUETH_MAX_TX_QUEUES	4
+#define PRUETH_MAX_RX_FLOWS	8
 #define PRUETH_RX_FLOW_DATA	0
 
 /* Defines for forwarding path buffer pools:
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23ac..68646cb7df442 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -140,13 +140,14 @@ static int emac_set_channels(struct net_device *ndev,
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 
-	/* Check if interface is up. Can change the num queues when
-	 * the interface is down.
+	/* Check if interface is up. Can't change the num queues when
+	 * the interface is up.
 	 */
 	if (netif_running(emac->ndev))
 		return -EBUSY;
 
 	emac->tx_ch_num = ch->tx_count;
+	emac->rx_flow_num = ch->rx_count;
 
 	if (emac->is_sr1)
 		emac->tx_ch_num++;
@@ -159,7 +160,7 @@ static void emac_get_channels(struct net_device *ndev,
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 
-	ch->max_rx = 1;
+	ch->max_rx = ICSSG_MAX_RFLOWS;
 	ch->max_tx = PRUETH_MAX_TX_QUEUES;
 
 	/* Disable multiple TX channels due to timeouts
@@ -167,7 +168,7 @@ static void emac_get_channels(struct net_device *ndev,
 	if (emac->is_sr1)
 		ch->max_tx = 1;
 
-	ch->rx_count = 1;
+	ch->rx_count = emac->rx_flow_num;
 	ch->tx_count = emac->tx_ch_num;
 
 	if (emac->is_sr1)
@@ -213,11 +214,13 @@ static int emac_get_coalesce(struct net_device *ndev,
 			     struct netlink_ext_ack *extack)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *flow = &rx_chn->flows[0];
 	struct prueth_tx_chn *tx_chn;
 
 	tx_chn = &emac->tx_chns[0];
 
-	coal->rx_coalesce_usecs = emac->rx_pace_timeout_ns / 1000;
+	coal->rx_coalesce_usecs = flow->rx_pace_timeout_ns / 1000;
 	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout_ns / 1000;
 
 	return 0;
@@ -245,8 +248,10 @@ static int emac_set_coalesce(struct net_device *ndev,
 			     struct netlink_ext_ack *extack)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
 	struct prueth *prueth = emac->prueth;
 	struct prueth_tx_chn *tx_chn;
+	int i;
 
 	tx_chn = &emac->tx_chns[0];
 
@@ -264,7 +269,8 @@ static int emac_set_coalesce(struct net_device *ndev,
 		coal->tx_coalesce_usecs = ICSSG_MIN_COALESCE_USECS;
 	}
 
-	emac->rx_pace_timeout_ns = coal->rx_coalesce_usecs * 1000;
+	for (i = 0; i < emac->rx_flow_num; i++)
+		rx_chn->flows[i].rx_pace_timeout_ns = coal->rx_coalesce_usecs * 1000;
 	tx_chn->tx_pace_timeout_ns = coal->tx_coalesce_usecs * 1000;
 
 	return 0;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 9bb67e185a3ea..716f1b9195d67 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -36,8 +36,6 @@
 #include "icssg_switchdev.h"
 #include "../k3-cppi-desc-pool.h"
 
-#define PRUETH_MODULE_DESCRIPTION "PRUSS ICSSG Ethernet driver"
-
 #define DEFAULT_VID		1
 #define DEFAULT_PORT_MASK	1
 #define DEFAULT_UNTAG_MASK	1
@@ -50,8 +48,6 @@
 #define PRUETH_RX_DMA_ATTR			(DMA_ATTR_SKIP_CPU_SYNC |\
 						 DMA_ATTR_WEAK_ORDERING)
 
-/* CTRLMMR_ICSSG_RGMII_CTRL register bits */
-#define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
 
 static void emac_adjust_link(struct net_device *ndev);
 
@@ -403,20 +399,6 @@ static void emac_adjust_link(struct net_device *ndev)
 	}
 }
 
-static enum hrtimer_restart emac_rx_timer_callback(struct hrtimer *timer)
-{
-	struct prueth_emac *emac =
-			container_of(timer, struct prueth_emac, rx_hrtimer);
-	int rx_flow = PRUETH_RX_FLOW_DATA;
-
-	if (emac->rx_chns.irq_disabled) {
-		/* re-enable the RX IRQ */
-		emac->rx_chns.irq_disabled = false;
-		enable_irq(emac->rx_chns.irq[rx_flow]);
-	}
-	return HRTIMER_NORESTART;
-}
-
 static int emac_phy_connect(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
@@ -587,43 +569,6 @@ const struct icss_iep_clockops prueth_iep_clockops = {
 	.perout_enable = prueth_perout_enable,
 };
 
-static void prueth_destroy_xdp_rxqs(struct prueth_emac *emac)
-{
-	struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
-
-	if (xdp_rxq_info_is_reg(rxq))
-		xdp_rxq_info_unreg(rxq);
-}
-
-static int prueth_create_xdp_rxqs(struct prueth_emac *emac)
-{
-	struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
-	struct page_pool *pool = emac->rx_chns.pg_pool;
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
-	int ret;
-
-	ret = xdp_rxq_info_reg(rxq, emac->ndev, 0, emac->napi_rx.napi_id);
-	if (ret)
-		return ret;
-
-	if (rx_chn->xsk_pool) {
-		ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_XSK_BUFF_POOL, NULL);
-		if (ret)
-			goto xdp_unreg;
-		xsk_pool_set_rxq_info(rx_chn->xsk_pool, rxq);
-	} else {
-		ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL, pool);
-		if (ret)
-			goto xdp_unreg;
-	}
-
-	return 0;
-
-xdp_unreg:
-	prueth_destroy_xdp_rxqs(emac);
-	return ret;
-}
-
 static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
 {
 	struct net_device *real_dev;
@@ -883,14 +828,14 @@ static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
 static void prueth_set_xsk_pool(struct prueth_emac *emac, u16 queue_id)
 {
 	struct prueth_tx_chn *tx_chn = &emac->tx_chns[queue_id];
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[queue_id];
 
-	if (emac->xsk_qid != queue_id) {
-		rx_chn->xsk_pool = NULL;
-		tx_chn->xsk_pool = NULL;
-	} else {
-		rx_chn->xsk_pool = xsk_get_pool_from_qid(emac->ndev, queue_id);
+	if (test_bit(queue_id, emac->xsk_queues)) {
+		rx_flow->xsk_pool = xsk_get_pool_from_qid(emac->ndev, queue_id);
 		tx_chn->xsk_pool = xsk_get_pool_from_qid(emac->ndev, queue_id);
+	} else {
+		rx_flow->xsk_pool = NULL;
+		tx_chn->xsk_pool = NULL;
 	}
 }
 
@@ -921,7 +866,43 @@ static void prueth_destroy_txq(struct prueth_emac *emac)
 	}
 }
 
-static void prueth_destroy_rxq(struct prueth_emac *emac)
+static void prueth_destroy_rxq(struct prueth_emac *emac, int qid)
+{
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *flow = &rx_chn->flows[qid];
+	dma_addr_t desc_dma;
+
+	napi_disable(&flow->napi_rx);
+	hrtimer_cancel(&flow->rx_hrtimer);
+	if (flow->irq_disabled) {
+		enable_irq(flow->irq);
+		flow->irq_disabled = false;
+	}
+
+	/* k3_udma_glue_reset_rx_chn() only drains the FDQ; it resets the
+	 * completion ring (RXCQ) without freeing descriptors still in it.
+	 * Teardown posts TDCM only to flow 0's RXCQ; flows 1..N have no
+	 * NAPI trigger to drain their RXCQs. Drain each flow's RXCQ here
+	 * so page_pool_destroy() finds no inflight pages.
+	 */
+	while (!k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, qid, &desc_dma)) {
+		if (!cppi5_desc_is_tdcm(desc_dma))
+			prueth_rx_cleanup(rx_chn, desc_dma);
+	}
+
+	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, flow->id, rx_chn,
+				  prueth_rx_cleanup);
+
+	if (xdp_rxq_info_is_reg(&flow->xdp_rxq))
+		xdp_rxq_info_unreg(&flow->xdp_rxq);
+
+	if (flow->pg_pool) {
+		page_pool_destroy(flow->pg_pool);
+		flow->pg_pool = NULL;
+	}
+}
+
+static void prueth_destroy_rxqs(struct prueth_emac *emac)
 {
 	int i, ret;
 
@@ -929,16 +910,14 @@ static void prueth_destroy_rxq(struct prueth_emac *emac)
 	reinit_completion(&emac->tdown_complete);
 	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
 
-	/* When RX DMA Channel Teardown is initiated, it will result in an
-	 * interrupt and a Teardown Completion Marker (TDCM) is queued into
-	 * the RX Completion queue. Acknowledging the interrupt involves
-	 * popping the TDCM descriptor from the RX Completion queue via the
-	 * RX NAPI Handler. To avoid timing out when waiting for the TDCM to
-	 * be popped, schedule the RX NAPI handler to run immediately.
+	/* When RX DMA Channel Teardown is initiated, the hardware posts a
+	 * Teardown Completion Marker (TDCM) to flow 0's RXCQ. Schedule flow
+	 * 0's NAPI unconditionally so the TDCM is popped promptly regardless
+	 * of whether the RX IRQ is currently disabled by hrtimer coalescing.
 	 */
-	if (!napi_if_scheduled_mark_missed(&emac->napi_rx)) {
-		if (napi_schedule_prep(&emac->napi_rx))
-			__napi_schedule(&emac->napi_rx);
+	if (!napi_if_scheduled_mark_missed(&emac->rx_chns.flows[0].napi_rx)) {
+		if (napi_schedule_prep(&emac->rx_chns.flows[0].napi_rx))
+			__napi_schedule(&emac->rx_chns.flows[0].napi_rx);
 	}
 
 	ret = wait_for_completion_timeout(&emac->tdown_complete,
@@ -946,15 +925,9 @@ static void prueth_destroy_rxq(struct prueth_emac *emac)
 	if (!ret)
 		netdev_err(emac->ndev, "rx teardown timeout\n");
 
-	for (i = 0; i < PRUETH_MAX_RX_FLOWS; i++) {
-		napi_disable(&emac->napi_rx);
-		hrtimer_cancel(&emac->rx_hrtimer);
-		k3_udma_glue_reset_rx_chn(emac->rx_chns.rx_chn, i,
-					  &emac->rx_chns,
-					  prueth_rx_cleanup);
-	}
+	for (i = 0; i < emac->rx_flow_num; i++)
+		prueth_destroy_rxq(emac, i);
 
-	prueth_destroy_xdp_rxqs(emac);
 	k3_udma_glue_disable_rx_chn(emac->rx_chns.rx_chn);
 }
 
@@ -978,27 +951,78 @@ static int prueth_create_txq(struct prueth_emac *emac)
 	return ret;
 }
 
-static int prueth_create_rxq(struct prueth_emac *emac)
+static int prueth_create_rxq(struct prueth_emac *emac, int id)
 {
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *flow = &rx_chn->flows[id];
+	struct xdp_rxq_info *rxq = &flow->xdp_rxq;
 	int ret;
 
-	ret = prueth_prepare_rx_chan(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZE);
+	ret = prueth_prepare_rx_flow(emac, id);
 	if (ret)
-		return ret;
+		goto err;
 
-	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
+	ret = xdp_rxq_info_reg(rxq, emac->ndev, id, flow->napi_rx.napi_id);
 	if (ret)
-		goto reset_rx_chn;
+		goto err;
 
-	ret = prueth_create_xdp_rxqs(emac);
-	if (ret)
-		goto reset_rx_chn;
+	if (flow->xsk_pool) {
+		ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_XSK_BUFF_POOL, NULL);
+		if (ret)
+			goto err;
+		xsk_pool_set_rxq_info(flow->xsk_pool, rxq);
+	} else {
+		ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL, flow->pg_pool);
+		if (ret)
+			goto err;
+	}
+
+	napi_enable(&flow->napi_rx);
+	return 0;
+
+err:
+	/* napi_enable() not yet called; prueth_destroy_rxq() calls
+	 * napi_disable() which busy-waits for NAPI_STATE_SCHED to clear —
+	 * a bit set by netif_napi_add() that only clears after napi_enable().
+	 * Clean up directly to avoid hanging.
+	 */
+	hrtimer_cancel(&flow->rx_hrtimer);
+	if (flow->irq_disabled) {
+		enable_irq(flow->irq);
+		flow->irq_disabled = false;
+	}
+	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, id, rx_chn, prueth_rx_cleanup);
+	if (xdp_rxq_info_is_reg(&flow->xdp_rxq))
+		xdp_rxq_info_unreg(&flow->xdp_rxq);
+	if (flow->pg_pool) {
+		page_pool_destroy(flow->pg_pool);
+		flow->pg_pool = NULL;
+	}
+	return ret;
+}
+
+static int prueth_create_rxqs(struct prueth_emac *emac)
+{
+	int i, ret;
 
-	napi_enable(&emac->napi_rx);
+	for (i = 0; i < emac->rx_flow_num; i++) {
+		ret = prueth_create_rxq(emac, i);
+		if (ret) {
+			netdev_err(emac->ndev, "failed to create rxq for flow %d: %d\n",
+				   i, ret);
+			goto err;
+		}
+	}
+
+	/* All flows share the same DMA channel */
+	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
+	if (ret)
+		goto err;
 	return 0;
 
-reset_rx_chn:
-	prueth_reset_rx_chan(&emac->rx_chns, PRUETH_MAX_RX_FLOWS, false);
+err:
+	for (--i; i >= 0; i--)
+		prueth_destroy_rxq(emac, i);
 	return ret;
 }
 
@@ -1018,8 +1042,6 @@ static int emac_ndo_open(struct net_device *ndev)
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
 	struct device *dev = prueth->dev;
-	int max_rx_flows;
-	int rx_flow;
 
 	/* set h/w MAC as user might have re-configured */
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
@@ -1034,7 +1056,12 @@ static int emac_ndo_open(struct net_device *ndev)
 		return ret;
 	}
 
-	emac->xsk_qid = -EINVAL;
+	ret = netif_set_real_num_rx_queues(ndev, emac->rx_flow_num);
+	if (ret) {
+		dev_err(dev, "cannot set real number of rx queues\n");
+		return ret;
+	}
+
 	init_completion(&emac->cmd_complete);
 	ret = prueth_init_tx_chns(emac);
 	if (ret) {
@@ -1042,9 +1069,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		return ret;
 	}
 
-	max_rx_flows = PRUETH_MAX_RX_FLOWS;
-	ret = prueth_init_rx_chns(emac, &emac->rx_chns, "rx",
-				  max_rx_flows, PRUETH_MAX_RX_DESC);
+	ret = prueth_init_rx_chns(emac);
 	if (ret) {
 		dev_err(dev, "failed to init rx channel: %d\n", ret);
 		goto cleanup_tx;
@@ -1054,14 +1079,9 @@ static int emac_ndo_open(struct net_device *ndev)
 	if (ret)
 		goto cleanup_rx;
 
-	/* we use only the highest priority flow for now i.e. @irq[3] */
-	rx_flow = PRUETH_RX_FLOW_DATA;
-	ret = request_irq(emac->rx_chns.irq[rx_flow], prueth_rx_irq,
-			  IRQF_TRIGGER_HIGH, dev_name(dev), emac);
-	if (ret) {
-		dev_err(dev, "unable to request RX IRQ\n");
+	ret = prueth_ndev_add_rx_napi(emac);
+	if (ret)
 		goto cleanup_napi;
-	}
 
 	if (!prueth->emacs_initialized) {
 		ret = prueth_emac_common_start(prueth);
@@ -1087,7 +1107,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		goto stop;
 
 	/* Prepare RX */
-	ret = prueth_create_rxq(emac);
+	ret = prueth_create_rxqs(emac);
 	if (ret)
 		goto free_tx_ts_irq;
 
@@ -1105,18 +1125,18 @@ static int emac_ndo_open(struct net_device *ndev)
 	return 0;
 
 destroy_rxq:
-	prueth_destroy_rxq(emac);
+	prueth_destroy_rxqs(emac);
 free_tx_ts_irq:
 	free_irq(emac->tx_ts_irq, emac);
 stop:
 	if (!prueth->emacs_initialized)
 		prueth_emac_common_stop(prueth);
 free_rx_irq:
-	free_irq(emac->rx_chns.irq[rx_flow], emac);
+	prueth_ndev_del_rx_napi(emac, emac->rx_flow_num);
 cleanup_napi:
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
 cleanup_rx:
-	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
+	prueth_cleanup_rx_chns(emac);
 cleanup_tx:
 	prueth_cleanup_tx_chns(emac);
 
@@ -1149,7 +1169,7 @@ static int emac_ndo_stop(struct net_device *ndev)
 		__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
 
 	prueth_destroy_txq(emac);
-	prueth_destroy_rxq(emac);
+	prueth_destroy_rxqs(emac);
 
 	cancel_work_sync(&emac->rx_mode_work);
 
@@ -1162,10 +1182,10 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	free_irq(emac->tx_ts_irq, emac);
 
-	free_irq(emac->rx_chns.irq[PRUETH_RX_FLOW_DATA], emac);
+	prueth_ndev_del_rx_napi(emac, emac->rx_flow_num);
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
 
-	prueth_cleanup_rx_chns(emac, &emac->rx_chns, PRUETH_MAX_RX_FLOWS);
+	prueth_cleanup_rx_chns(emac);
 	prueth_cleanup_tx_chns(emac);
 
 	prueth->emacs_initialized--;
@@ -1467,11 +1487,11 @@ static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
 static int prueth_xsk_pool_enable(struct prueth_emac *emac,
 				  struct xsk_buff_pool *pool, u16 queue_id)
 {
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
 	u32 frame_size;
 	int ret;
 
 	if (queue_id >= PRUETH_MAX_RX_FLOWS ||
+	    queue_id >= emac->rx_flow_num ||
 	    queue_id >= emac->tx_ch_num) {
 		netdev_err(emac->ndev, "Invalid XSK queue ID %d\n", queue_id);
 		return -EINVAL;
@@ -1481,7 +1501,7 @@ static int prueth_xsk_pool_enable(struct prueth_emac *emac,
 	if (frame_size < PRUETH_MAX_PKT_SIZE)
 		return -EOPNOTSUPP;
 
-	ret = xsk_pool_dma_map(pool, rx_chn->dma_dev, PRUETH_RX_DMA_ATTR);
+	ret = xsk_pool_dma_map(pool, emac->rx_chns.dma_dev, PRUETH_RX_DMA_ATTR);
 	if (ret) {
 		netdev_err(emac->ndev, "Failed to map XSK pool: %d\n", ret);
 		return ret;
@@ -1492,21 +1512,24 @@ static int prueth_xsk_pool_enable(struct prueth_emac *emac,
 		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		if (ret)
 			return ret;
-		prueth_destroy_rxq(emac);
+		prueth_destroy_rxq(emac, queue_id);
 	}
 
-	emac->xsk_qid = queue_id;
+	set_bit(queue_id, emac->xsk_queues);
 	prueth_set_xsk_pool(emac, queue_id);
 
 	if (netif_running(emac->ndev)) {
-		ret = prueth_create_rxq(emac);
+		ret = prueth_create_rxq(emac, queue_id);
 		if (ret) {
 			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
+			clear_bit(queue_id, emac->xsk_queues);
+			prueth_set_xsk_pool(emac, queue_id);
+			xsk_pool_dma_unmap(pool, PRUETH_RX_DMA_ATTR);
 			return ret;
 		}
 		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
 		if (ret) {
-			prueth_destroy_rxq(emac);
+			prueth_destroy_rxq(emac, queue_id);
 			return ret;
 		}
 		ret = prueth_xsk_wakeup(emac->ndev, queue_id, XDP_WAKEUP_RX);
@@ -1523,12 +1546,13 @@ static int prueth_xsk_pool_disable(struct prueth_emac *emac, u16 queue_id)
 	int ret;
 
 	if (queue_id >= PRUETH_MAX_RX_FLOWS ||
+	    queue_id >= emac->rx_flow_num ||
 	    queue_id >= emac->tx_ch_num) {
 		netdev_err(emac->ndev, "Invalid XSK queue ID %d\n", queue_id);
 		return -EINVAL;
 	}
 
-	if (emac->xsk_qid != queue_id) {
+	if (!test_bit(queue_id, emac->xsk_queues)) {
 		netdev_err(emac->ndev, "XSK queue ID %d not registered\n", queue_id);
 		return -EINVAL;
 	}
@@ -1544,27 +1568,28 @@ static int prueth_xsk_pool_disable(struct prueth_emac *emac, u16 queue_id)
 		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		if (ret)
 			return ret;
-		prueth_destroy_rxq(emac);
+		prueth_destroy_rxq(emac, queue_id);
 	}
 
 	xsk_pool_dma_unmap(pool, PRUETH_RX_DMA_ATTR);
-	emac->xsk_qid = -EINVAL;
+	clear_bit(queue_id, emac->xsk_queues);
 	prueth_set_xsk_pool(emac, queue_id);
 
 	if (netif_running(emac->ndev)) {
-		ret = prueth_create_rxq(emac);
-		if (ret) {
-			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
-			return ret;
-		}
-		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
-		if (ret) {
-			prueth_destroy_rxq(emac);
-			return ret;
-		}
+		ret = prueth_create_rxq(emac, queue_id);
+		if (ret)
+			netdev_err(emac->ndev, "Failed to recreate RX queue after XSK disable: %d\n",
+				   ret);
+
+		/* Always re-enable port forwarding so the interface is not left
+		 * permanently disabled if prueth_create_rxq() failed due to a
+		 * transient descriptor shortage (inflight pages not yet returned
+		 * by the network stack).
+		 */
+		icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1593,25 +1618,31 @@ static int emac_ndo_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
-	struct prueth_tx_chn *tx_chn = &emac->tx_chns[qid];
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_tx_chn *tx_chn;
+	struct prueth_rx_flow *rx_flow;
 
-	if (emac->xsk_qid != qid) {
-		netdev_err(ndev, "XSK queue %d not registered\n", qid);
+	/* Bounds check before any array/bitmap access */
+	if (qid >= PRUETH_MAX_RX_FLOWS ||
+	    qid >= emac->rx_flow_num ||
+	    qid >= emac->tx_ch_num) {
+		netdev_err(ndev, "Invalid XSK queue ID %d\n", qid);
 		return -EINVAL;
 	}
 
-	if (qid >= PRUETH_MAX_RX_FLOWS || qid >= emac->tx_ch_num) {
-		netdev_err(ndev, "Invalid XSK queue ID %d\n", qid);
+	if (!test_bit(qid, emac->xsk_queues)) {
+		netdev_err(ndev, "XSK queue %d not registered\n", qid);
 		return -EINVAL;
 	}
 
+	tx_chn = &emac->tx_chns[qid];
+	rx_flow = &emac->rx_chns.flows[qid];
+
 	if (!tx_chn->xsk_pool) {
 		netdev_err(ndev, "XSK pool not registered for queue %d\n", qid);
 		return -EINVAL;
 	}
 
-	if (!rx_chn->xsk_pool) {
+	if (!rx_flow->xsk_pool) {
 		netdev_err(ndev, "XSK pool not registered for RX queue %d\n", qid);
 		return -EINVAL;
 	}
@@ -1624,9 +1655,9 @@ int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
 	}
 
 	if (flags & XDP_WAKEUP_RX) {
-		if (!napi_if_scheduled_mark_missed(&emac->napi_rx)) {
-			if (likely(napi_schedule_prep(&emac->napi_rx)))
-				__napi_schedule(&emac->napi_rx);
+		if (!napi_if_scheduled_mark_missed(&rx_flow->napi_rx)) {
+			if (likely(napi_schedule_prep(&rx_flow->napi_rx)))
+				__napi_schedule(&rx_flow->napi_rx);
 		}
 	}
 
@@ -1657,12 +1688,12 @@ static const struct net_device_ops emac_netdev_ops = {
 static int prueth_netdev_init(struct prueth *prueth,
 			      struct device_node *eth_node)
 {
-	int ret, num_tx_chn = PRUETH_MAX_TX_QUEUES;
 	struct prueth_emac *emac;
 	struct net_device *ndev;
 	enum prueth_port port;
 	const char *irq_name;
 	enum prueth_mac mac;
+	int ret;
 
 	port = prueth_node_port(eth_node);
 	if (port == PRUETH_PORT_INVALID)
@@ -1672,7 +1703,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	if (mac == PRUETH_MAC_INVALID)
 		return -EINVAL;
 
-	ndev = alloc_etherdev_mq(sizeof(*emac), num_tx_chn);
+	ndev = alloc_etherdev_mqs(sizeof(*emac), PRUETH_MAX_TX_QUEUES, PRUETH_MAX_RX_FLOWS);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -1697,6 +1728,14 @@ static int prueth_netdev_init(struct prueth *prueth,
 	}
 
 	emac->tx_ch_num = 1;
+	emac->rx_flow_num = 1;
+	emac->xsk_queues = devm_bitmap_zalloc(prueth->dev,
+					      PRUETH_MAX_RX_FLOWS, GFP_KERNEL);
+	if (!emac->xsk_queues) {
+		dev_err(prueth->dev, "failed to allocate xsk_queues bitmap\n");
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	irq_name = "tx_ts0";
 	if (emac->port_id == PRUETH_PORT_MII1)
@@ -1783,11 +1822,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 			      NETDEV_XDP_ACT_NDO_XMIT |
 			      NETDEV_XDP_ACT_XSK_ZEROCOPY);
 
-	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
-	hrtimer_setup(&emac->rx_hrtimer, &emac_rx_timer_callback, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL_PINNED);
 	prueth->emac[mac] = emac;
-
 	return 0;
 
 free:
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b786..d54966730d102 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -132,18 +132,27 @@ struct prueth_tx_chn {
 	bool irq_disabled;
 };
 
+struct prueth_rx_flow {
+	u32 id;
+	struct prueth_emac *emac;
+	struct napi_struct napi_rx;
+	int irq;
+	bool irq_disabled;
+	struct hrtimer rx_hrtimer;
+	unsigned long rx_pace_timeout_ns;
+	struct page_pool *pg_pool;
+	struct xdp_rxq_info xdp_rxq;
+	struct xsk_buff_pool *xsk_pool;
+	char name[32];
+};
+
 struct prueth_rx_chn {
-	struct device *dev;
 	struct device *dma_dev;
 	struct k3_cppi_desc_pool *desc_pool;
 	struct k3_udma_glue_rx_channel *rx_chn;
+	struct prueth_emac *emac;
 	u32 descs_num;
-	unsigned int irq[ICSSG_MAX_RFLOWS];	/* separate irq per flow */
-	char name[32];
-	struct page_pool *pg_pool;
-	struct xdp_rxq_info xdp_rxq;
-	struct xsk_buff_pool *xsk_pool;
-	bool irq_disabled;
+	struct prueth_rx_flow flows[PRUETH_MAX_RX_FLOWS];
 };
 
 enum prueth_swdata_type {
@@ -162,6 +171,7 @@ enum prueth_tx_buff_type {
 
 struct prueth_swdata {
 	enum prueth_swdata_type type;
+	u32 flow_id;
 	union prueth_data {
 		struct sk_buff *skb;
 		struct page *page;
@@ -171,11 +181,6 @@ struct prueth_swdata {
 	} data;
 };
 
-/* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
- * and lower three are lower priority channels or threads.
- */
-#define PRUETH_MAX_TX_QUEUES	4
-
 #define PRUETH_MAX_TX_TS_REQUESTS	50 /* Max simultaneous TX_TS requests */
 
 /* XDP BPF state */
@@ -193,7 +198,6 @@ struct prueth_emac {
 	struct prueth *prueth;
 	struct net_device *ndev;
 	u8 mac_addr[6];
-	struct napi_struct napi_rx;
 	u32 msg_enable;
 
 	int link;
@@ -216,6 +220,7 @@ struct prueth_emac {
 	struct prueth_rx_chn rx_chns;
 	int rx_flow_id_base;
 	int tx_ch_num;
+	int rx_flow_num;
 
 	/* SR1.0 Management channel */
 	struct prueth_rx_chn rx_mgm_chn;
@@ -246,14 +251,11 @@ struct prueth_emac {
 	u64 stats[ICSSG_NUM_MIIG_STATS];
 	u64 pa_stats[ICSSG_NUM_PA_STATS];
 
-	/* RX IRQ Coalescing Related */
-	struct hrtimer rx_hrtimer;
-	unsigned long rx_pace_timeout_ns;
-
 	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	unsigned long *xsk_queues;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
@@ -455,30 +457,30 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
 int emac_fdb_flow_id_updated(struct prueth_emac *emac);
 #define prueth_napi_to_tx_chn(pnapi) \
 	container_of(pnapi, struct prueth_tx_chn, napi_tx)
+#define prueth_napi_to_rx_chn(pnapi) \
+	container_of(pnapi, struct prueth_rx_flow, napi_rx)
 
 void icssg_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
 /* Common functions */
-void prueth_cleanup_rx_chns(struct prueth_emac *emac,
-			    struct prueth_rx_chn *rx_chn,
-			    int max_rflows);
+void prueth_cleanup_rx_chns(struct prueth_emac *emac);
 void prueth_cleanup_tx_chns(struct prueth_emac *emac);
 void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num);
+void prueth_ndev_del_rx_napi(struct prueth_emac *emac, int num);
 void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 		      struct cppi5_host_desc_t *desc);
 int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 			     int budget, bool *tdown);
 int prueth_ndev_add_tx_napi(struct prueth_emac *emac);
+int prueth_ndev_add_rx_napi(struct prueth_emac *emac);
 int prueth_init_tx_chns(struct prueth_emac *emac);
-int prueth_init_rx_chns(struct prueth_emac *emac,
-			struct prueth_rx_chn *rx_chn,
-			char *name, u32 max_rflows,
-			u32 max_desc_num);
+int prueth_init_rx_chns(struct prueth_emac *emac);
 int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
 			      struct prueth_rx_chn *rx_chn,
-			      struct page *page, u32 buf_len);
+			      struct page *page, u32 buf_len,
+			      int flow_id);
 unsigned int prueth_rxbuf_total_len(unsigned int len);
 void emac_rx_timestamp(struct prueth_emac *emac,
 		       struct sk_buff *skb, u32 *psdata);
@@ -486,13 +488,11 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 irqreturn_t prueth_rx_irq(int irq, void *dev_id);
 void prueth_cleanup_tx_ts(struct prueth_emac *emac);
 int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget);
-int prueth_prepare_rx_chan(struct prueth_emac *emac,
-			   struct prueth_rx_chn *chn,
-			   int buf_size);
+int prueth_prepare_rx_flow(struct prueth_emac *emac,
+			   int flow);
 void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 			  bool free_skb);
-void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
-			  int num_flows, bool disable);
+void prueth_reset_rx_chan(struct prueth_emac *emac, bool disable);
 void icssg_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue);
 int icssg_ndo_get_ts_config(struct net_device *ndev,
 			    struct kernel_hwtstamp_config *config);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 21a14b3bc889b..589b73be3ac60 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -306,7 +306,7 @@ static struct page *prueth_process_rx_mgm(struct prueth_emac *emac,
 	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
-	new_page = page_pool_dev_alloc_pages(rx_chn->pg_pool);
+	new_page = page_pool_dev_alloc_pages(rx_chn->flows[flow_id].pg_pool);
 	/* if allocation fails we drop the packet but push the
 	 * descriptor back to the ring with old skb to prevent a stall
 	 */
@@ -319,14 +319,104 @@ static struct page *prueth_process_rx_mgm(struct prueth_emac *emac,
 	}
 
 	/* queue another DMA */
-	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
-					PRUETH_MAX_PKT_SIZE);
+	ret = prueth_dma_rx_push_mapped(emac, rx_chn, new_page,
+					PRUETH_MAX_PKT_SIZE, flow_id);
 	if (WARN_ON(ret < 0))
-		page_pool_recycle_direct(rx_chn->pg_pool, new_page);
+		page_pool_recycle_direct(rx_chn->flows[flow_id].pg_pool, new_page);
 
 	return page;
 }
 
+/* SR1-specific helpers for rx_mgm_chn */
+
+static int prueth_sr1_prepare_rx_mgm_flow(struct prueth_emac *emac, int flow, u32 buf_len)
+{
+	struct prueth_rx_flow *rx_flow;
+	struct prueth_rx_chn *rx_chn;
+	struct page_pool *pool;
+	struct page *page;
+	int desc_avail;
+	int i, ret;
+
+	rx_chn = &emac->rx_mgm_chn;
+	rx_flow = &rx_chn->flows[flow];
+
+	/* Initialize page pool for this flow - using simple page pool */
+	pool = page_pool_create(&(struct page_pool_params){
+		.order = 0,
+		.pool_size = rx_chn->descs_num,
+		.nid = NUMA_NO_NODE,
+		.dev = rx_chn->dma_dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.max_len = PRUETH_MAX_PKT_SIZE,
+	});
+
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	rx_flow->pg_pool = pool;
+
+	desc_avail = k3_cppi_desc_pool_avail(rx_chn->desc_pool);
+	if (desc_avail < PRUETH_MAX_RX_DESC)
+		netdev_warn(emac->ndev,
+			    "not enough RX descriptors available %d < %d\n",
+			    desc_avail, PRUETH_MAX_RX_DESC);
+
+	for (i = 0; i < desc_avail; i++) {
+		page = page_pool_dev_alloc_pages(rx_flow->pg_pool);
+		if (!page)
+			break;
+
+		ret = prueth_dma_rx_push_mapped(emac, rx_chn, page, buf_len, flow);
+		if (ret < 0) {
+			page_pool_recycle_direct(rx_flow->pg_pool, page);
+			netdev_err(emac->ndev, "failed to push rx mgm buf %d\n", ret);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static void prueth_sr1_cleanup_rx_mgm_chn(struct prueth_emac *emac)
+{
+	struct prueth_rx_flow *flow;
+	int i;
+
+	for (i = 0; i < PRUETH_MAX_RX_MGM_FLOWS_SR1; i++) {
+		flow = &emac->rx_mgm_chn.flows[i];
+		if (flow->pg_pool) {
+			page_pool_destroy(flow->pg_pool);
+			flow->pg_pool = NULL;
+		}
+	}
+
+	if (emac->rx_mgm_chn.rx_chn) {
+		k3_udma_glue_release_rx_chn(emac->rx_mgm_chn.rx_chn);
+		emac->rx_mgm_chn.rx_chn = NULL;
+	}
+}
+
+static void prueth_sr1_reset_rx_mgm_chn(struct prueth_emac *emac, bool disable)
+{
+	struct prueth_rx_flow *flow;
+	int i;
+
+	for (i = 0; i < PRUETH_MAX_RX_MGM_FLOWS_SR1; i++) {
+		flow = &emac->rx_mgm_chn.flows[i];
+		if (flow->irq <= 0)
+			continue;
+
+		if (disable) {
+			disable_irq(flow->irq);
+			flow->irq_disabled = true;
+		} else if (flow->irq_disabled) {
+			enable_irq(flow->irq);
+			flow->irq_disabled = false;
+		}
+	}
+}
+
 static void prueth_tx_ts_sr1(struct prueth_emac *emac,
 			     struct emac_tx_ts_response_sr1 *tsr)
 {
@@ -484,9 +574,15 @@ static int emac_ndo_open(struct net_device *ndev)
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
 	struct device *dev = prueth->dev;
-	int max_rx_flows, rx_flow;
+	struct k3_udma_glue_rx_channel_cfg rx_cfg;
+	struct prueth_rx_flow *flow;
+	char udma_name[32];
+	u32 hdesc_size;
 	int ret, i;
 
+	if (slice < 0)
+		return slice;
+
 	/* clear SMEM and MSMC settings for all slices */
 	if (!prueth->emacs_initialized) {
 		memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
@@ -514,37 +610,116 @@ static int emac_ndo_open(struct net_device *ndev)
 		return ret;
 	}
 
-	max_rx_flows = PRUETH_MAX_RX_FLOWS_SR1;
-	ret = prueth_init_rx_chns(emac, &emac->rx_chns, "rx",
-				  max_rx_flows, PRUETH_MAX_RX_DESC);
+	emac->rx_flow_num = 1;
+	ret = prueth_init_rx_chns(emac);
 	if (ret) {
 		dev_err(dev, "failed to init rx channel: %d\n", ret);
 		goto cleanup_tx;
 	}
 
-	ret = prueth_init_rx_chns(emac, &emac->rx_mgm_chn, "rxmgm",
-				  PRUETH_MAX_RX_MGM_FLOWS_SR1,
-				  PRUETH_MAX_RX_MGM_DESC_SR1);
-	if (ret) {
-		dev_err(dev, "failed to init rx mgmt channel: %d\n",
-			ret);
+	/* Initialize management channel - SR1 specific */
+	emac->rx_mgm_chn.emac = emac;
+	hdesc_size = cppi5_hdesc_calc_size(true, PRUETH_NAV_PS_DATA_SIZE,
+					   PRUETH_NAV_SW_DATA_SIZE);
+	memset(&rx_cfg, 0, sizeof(rx_cfg));
+	rx_cfg.swdata_size = PRUETH_NAV_SW_DATA_SIZE;
+	rx_cfg.flow_id_num = PRUETH_MAX_RX_MGM_FLOWS_SR1;
+	rx_cfg.flow_id_base = -1;
+
+	snprintf(udma_name, sizeof(udma_name), "%s%d", "rxmgm", slice);
+	emac->rx_mgm_chn.rx_chn = k3_udma_glue_request_rx_chn(dev, udma_name,
+							     &rx_cfg);
+	if (IS_ERR(emac->rx_mgm_chn.rx_chn)) {
+		ret = PTR_ERR(emac->rx_mgm_chn.rx_chn);
+		emac->rx_mgm_chn.rx_chn = NULL;
+		dev_err(dev, "Failed to request rx mgm dma ch: %d\n", ret);
 		goto cleanup_rx;
 	}
 
+	emac->rx_mgm_chn.descs_num = PRUETH_MAX_RX_MGM_DESC_SR1 * rx_cfg.flow_id_num;
+	emac->rx_mgm_chn.dma_dev = k3_udma_glue_rx_get_dma_device(emac->rx_mgm_chn.rx_chn);
+	emac->rx_mgm_chn.desc_pool = k3_cppi_desc_pool_create_name(emac->rx_mgm_chn.dma_dev,
+								    emac->rx_mgm_chn.descs_num,
+								    hdesc_size,
+								    "rx_mgm_desc_pool");
+	if (IS_ERR(emac->rx_mgm_chn.desc_pool)) {
+		ret = PTR_ERR(emac->rx_mgm_chn.desc_pool);
+		emac->rx_mgm_chn.desc_pool = NULL;
+		dev_err(dev, "Failed to create rx mgm pool: %d\n", ret);
+		k3_udma_glue_release_rx_chn(emac->rx_mgm_chn.rx_chn);
+		emac->rx_mgm_chn.rx_chn = NULL;
+		goto cleanup_rx_mgm_init;
+	}
+
+	for (i = 0; i < rx_cfg.flow_id_num; i++) {
+		flow = &emac->rx_mgm_chn.flows[i];
+		flow->pg_pool = NULL;
+		flow->xsk_pool = NULL;
+	}
+
+	emac->rx_mgm_flow_id_base = k3_udma_glue_rx_get_flow_id_base(emac->rx_mgm_chn.rx_chn);
+	netdev_dbg(ndev, "rx mgm flow id base = %d\n", emac->rx_mgm_flow_id_base);
+
+	for (i = 0; i < rx_cfg.flow_id_num; i++) {
+		struct k3_ring_cfg rxring_cfg = {
+			.elm_size = K3_RINGACC_RING_ELSIZE_8,
+			.mode = K3_RINGACC_RING_MODE_RING,
+			.flags = 0,
+		};
+		struct k3_ring_cfg fdqring_cfg = {
+			.elm_size = K3_RINGACC_RING_ELSIZE_8,
+			.flags = K3_RINGACC_RING_SHARED,
+		};
+		struct k3_udma_glue_rx_flow_cfg rx_flow_cfg = {
+			.rx_cfg = rxring_cfg,
+			.rxfdq_cfg = fdqring_cfg,
+			.ring_rxq_id = K3_RINGACC_RING_ID_ANY,
+			.src_tag_lo_sel =
+				K3_UDMA_GLUE_SRC_TAG_LO_USE_REMOTE_SRC_TAG,
+		};
+
+		flow = &emac->rx_mgm_chn.flows[i];
+		flow->emac = emac;
+		flow->id = i;
+		flow->irq = -EINVAL;
+
+		rx_flow_cfg.ring_rxfdq0_id = K3_RINGACC_RING_ID_ANY;
+		rx_flow_cfg.rx_cfg.size = PRUETH_MAX_RX_MGM_DESC_SR1;
+		rx_flow_cfg.rxfdq_cfg.size = PRUETH_MAX_RX_MGM_DESC_SR1;
+		rx_flow_cfg.rxfdq_cfg.mode = prueth->pdata.fdqring_mode;
+
+		ret = k3_udma_glue_rx_flow_init(emac->rx_mgm_chn.rx_chn,
+					i, &rx_flow_cfg);
+		if (ret) {
+			dev_err(dev, "Failed to init rx mgm flow%d %d\n",
+				i, ret);
+			goto cleanup_rx_mgm_init;
+		}
+
+		flow->irq = k3_udma_glue_rx_get_irq(emac->rx_mgm_chn.rx_chn, i);
+		if (flow->irq == 0 || flow->irq > INT_MAX) {
+			ret = flow->irq > INT_MAX ? -EINVAL : flow->irq;
+			dev_err(dev, "Failed to get rx mgm dma irq");
+			goto cleanup_rx_mgm_init;
+		}
+
+		snprintf(flow->name, sizeof(flow->name),
+			 "%s-rxmgm%d-%d", dev_name(dev), slice, i);
+	}
+
 	ret = prueth_ndev_add_tx_napi(emac);
 	if (ret)
 		goto cleanup_rx_mgm;
 
-	/* we use only the highest priority flow for now i.e. @irq[3] */
-	rx_flow = PRUETH_RX_FLOW_DATA_SR1;
-	ret = request_irq(emac->rx_chns.irq[rx_flow], prueth_rx_irq,
-			  IRQF_TRIGGER_HIGH, dev_name(dev), emac);
+	/* Data NAPI and IRQ registration via common API */
+	ret = prueth_ndev_add_rx_napi(emac);
 	if (ret) {
-		dev_err(dev, "unable to request RX IRQ\n");
+		dev_err(dev, "unable to add rx napi\n");
 		goto cleanup_napi;
 	}
 
-	ret = request_threaded_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_RESPONSE_SR1],
+	/* Management channel IRQs - SR1 specific */
+	ret = request_threaded_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_RESPONSE_SR1].irq,
 				   NULL, prueth_rx_mgm_rsp_thread,
 				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
 				   dev_name(dev), emac);
@@ -553,7 +728,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		goto free_rx_irq;
 	}
 
-	ret = request_threaded_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1],
+	ret = request_threaded_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1].irq,
 				   NULL, prueth_rx_mgm_ts_thread_sr1,
 				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
 				   dev_name(dev), emac);
@@ -570,11 +745,15 @@ static int emac_ndo_open(struct net_device *ndev)
 	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
 
 	/* Prepare RX */
-	ret = prueth_prepare_rx_chan(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZE);
+	ret = prueth_prepare_rx_flow(emac, PRUETH_RX_FLOW_DATA_SR1);
 	if (ret)
 		goto stop;
 
-	ret = prueth_prepare_rx_chan(emac, &emac->rx_mgm_chn, 64);
+	ret = prueth_sr1_prepare_rx_mgm_flow(emac, PRUETH_RX_MGM_FLOW_RESPONSE_SR1, 64);
+	if (ret)
+		goto reset_rx_chn;
+
+	ret = prueth_sr1_prepare_rx_mgm_flow(emac, PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1, 64);
 	if (ret)
 		goto reset_rx_chn;
 
@@ -595,7 +774,7 @@ static int emac_ndo_open(struct net_device *ndev)
 	/* Enable NAPI in Tx and Rx direction */
 	for (i = 0; i < emac->tx_ch_num; i++)
 		napi_enable(&emac->tx_chns[i].napi_tx);
-	napi_enable(&emac->napi_rx);
+	napi_enable(&emac->rx_chns.flows[PRUETH_RX_FLOW_DATA_SR1].napi_rx);
 
 	/* start PHY */
 	phy_start(ndev->phydev);
@@ -612,27 +791,27 @@ static int emac_ndo_open(struct net_device *ndev)
 	 */
 	prueth_reset_tx_chan(emac, i, false);
 reset_rx_mgm_chn:
-	prueth_reset_rx_chan(&emac->rx_mgm_chn,
-			     PRUETH_MAX_RX_MGM_FLOWS_SR1, true);
+	prueth_sr1_reset_rx_mgm_chn(emac, true);
 reset_rx_chn:
-	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, false);
+	prueth_reset_rx_chan(emac, false);
+cleanup_rx_mgm_init:
+	prueth_sr1_cleanup_rx_mgm_chn(emac);
 stop:
 	prueth_emac_stop(emac);
 free_rx_mgmt_ts_irq:
-	free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1],
+	free_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1].irq,
 		 emac);
 free_rx_mgm_rsp_irq:
-	free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_RESPONSE_SR1],
+	free_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_RESPONSE_SR1].irq,
 		 emac);
 free_rx_irq:
-	free_irq(emac->rx_chns.irq[rx_flow], emac);
+	prueth_ndev_del_rx_napi(emac, 1);
 cleanup_napi:
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
 cleanup_rx_mgm:
-	prueth_cleanup_rx_chns(emac, &emac->rx_mgm_chn,
-			       PRUETH_MAX_RX_MGM_FLOWS_SR1);
+	prueth_sr1_cleanup_rx_mgm_chn(emac);
 cleanup_rx:
-	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
+	prueth_cleanup_rx_chns(emac);
 cleanup_tx:
 	prueth_cleanup_tx_chns(emac);
 
@@ -650,9 +829,7 @@ static int emac_ndo_open(struct net_device *ndev)
 static int emac_ndo_stop(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
-	int rx_flow = PRUETH_RX_FLOW_DATA_SR1;
 	struct prueth *prueth = emac->prueth;
-	int max_rx_flows;
 	int ret, i;
 
 	/* inform the upper layers. */
@@ -683,16 +860,14 @@ static int emac_ndo_stop(struct net_device *ndev)
 	for (i = 0; i < emac->tx_ch_num; i++)
 		napi_disable(&emac->tx_chns[i].napi_tx);
 
-	max_rx_flows = PRUETH_MAX_RX_FLOWS_SR1;
 	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
 
-	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, true);
+	prueth_reset_rx_chan(emac, true);
 	/* Teardown RX MGM channel */
 	k3_udma_glue_tdown_rx_chn(emac->rx_mgm_chn.rx_chn, true);
-	prueth_reset_rx_chan(&emac->rx_mgm_chn,
-			     PRUETH_MAX_RX_MGM_FLOWS_SR1, true);
+	prueth_sr1_reset_rx_mgm_chn(emac, true);
 
-	napi_disable(&emac->napi_rx);
+	napi_disable(&emac->rx_chns.flows[PRUETH_RX_FLOW_DATA_SR1].napi_rx);
 
 	/* Destroying the queued work in ndo_stop() */
 	cancel_delayed_work_sync(&emac->stats_work);
@@ -700,14 +875,14 @@ static int emac_ndo_stop(struct net_device *ndev)
 	/* stop PRUs */
 	prueth_emac_stop(emac);
 
-	free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1], emac);
-	free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_RESPONSE_SR1], emac);
-	free_irq(emac->rx_chns.irq[rx_flow], emac);
+	free_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1].irq, emac);
+	free_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_RESPONSE_SR1].irq, emac);
+	prueth_ndev_del_rx_napi(emac, 1);
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
 	prueth_cleanup_tx_chns(emac);
 
-	prueth_cleanup_rx_chns(emac, &emac->rx_mgm_chn, PRUETH_MAX_RX_MGM_FLOWS_SR1);
-	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
+	prueth_sr1_cleanup_rx_mgm_chn(emac);
+	prueth_cleanup_rx_chns(emac);
 
 	prueth->emacs_initialized--;
 
@@ -871,7 +1046,6 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features = ndev->hw_features;
 
-	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
 	prueth->emac[mac] = emac;
 
 	return 0;
-- 
2.43.0

