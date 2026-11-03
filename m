Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793713603;
	b=aaLckXmxGwyMlIWclMl/j1JI+9OsMvwg6hnadq4Ghvv/ysIk4UaH8YjA1PpcRes9kh3k
	 JQsim0PWoSzjZ5Xz5Q1mCsnA1k8E+DHsyBLQzcgMgMv4SKDXbf/oDb6V46UgNzICS0jOO
	 /AyS0bLLImifWZRmqvSLE5zMEkR33qdvSMsSDvnKVHYtwihungaarT7lLgf0B1tZAztgs
	 Egy2YxpiG2rS19gZhEW/idYP+2CjmRM4GpT+1BNNaTTy+gvMk24vmP9P2hNEqxPVIL1oG
	 qCYqoMTdojBA12sUeZxPLXZQRSDFSuaGLDkvzrRvB+QAjcvcEvL0yYlViDed9fg68eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713603;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iUJIUnaTjpazeZwyWqeAb7HNyT+ng84puzlLBDekHSs=;
	b=THjD0MvDhzinmAYwUWMgmCUTnIcH3QPgAMHOYxAPN4UZQRLrpyqRQqj86D+U/guSA8VF
	 X/2+55cGZgH1tTH+bqe5o7aQ9iVvXyhoeWZUCPxqs9TbDt+EoVTt4evdr3JJQM1/T3m0m
	 osA0bwm8wtufO8s/l9dY4cfsKn9PCgXg9Vl51ADCiEH0AMGryLr4Df+nmQrOGNpTmtIIj
	 CXGS4E7Xsy265tVFqv9XWLPppB+mKVCkUPUih6ZTAK0oJSrE4M2Ce+xZcc34UOl7+qmqS
	 rSw/Frg1iWvKi11LADHPKSPRa1NocoQ/HbN4cIDfnyo2/BcEJ3R5+bQU48m+LpMAb5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=A8UE0z5K;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=cOc2ZG2X;
	arc=fail smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E0606D803;
	Tue,  3 Nov 2026 13:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 805E0606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=A8UE0z5K;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=cOc2ZG2X
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Dbpp93278605;
	Tue, 3 Nov 2026 07:46:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=iUJIUnaTjpazeZwyWqeAb7HNyT+ng84puzlLBDekH
	Ss=; b=A8UE0z5KdtOHoexvp7yEgiklou+LRZGmU07AtuHYV28hQtOhuIoTCZRd1
	wwsOFgxD5wV56RP33LSv2eypTbF7GsxrCz/I3xp/btURf+n4gH9u+2cfnfnypEXA
	z4gLj8O21y/iul6N0eeo5qzFGNMsoCHvZhd9bI7Jnk84Y2u9ISapcUDy/IOdbRXh
	szyQSDtYmQk4ItKi3IJ9n6l0Pcw7TGCB2/xyafPOntLJnSHZ3uQrdvrLOS7HhG9m
	vY6oRSQQnnX12g2MyKf9xF7dfYwbZUcUHWwq2/aRJMv5J/b+KHTCK1DeaIhSTyY8
	RyNd9wbXeDip6lZx8Rwb/ungMDLtw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hqcrvs88m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:46:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehDi/fQrf+hIxnMpk0ql/D95evdrh0j0Pece+BPL+CPNYDW7u8ESD8sdK780ffsDZw9/wiO05CqiUj6xCO0QvjppqTjbnTNTBqcyigEzbbRU3N1/WFDQRn98yAgkqAlW+EKixNIQ+/bXmgJJUd6maRJWN8LznItsshZG08aV30iSTwYcJNIgpLN6huXxSLa6ONcrlLprCbDacIbaIb/3cEjnKbO1CfsxCUHN9TKRGHb+D/WjVI1HAu5UGDNhzCWY0WYWZWuGb7zbmjvcre3dvGA4zwz8lZMl1/90DqwP6o1LWT6jlZvMHD5IScpr14D/Gg2bedyBg64fsiztly4RnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUJIUnaTjpazeZwyWqeAb7HNyT+ng84puzlLBDekHSs=;
 b=XqmIrvwlAjUDubf96OInvpoK7H6gMJHMuIyHeaL3U91ptmP9p5QN89o9TG9JWeSS4sXkFxSLSazp627/Eq81C3rDzLpKfHc2cgf0L9EA9Wb1bHCCGju1IzdmAMzmgrhyTILMqwve/DqDaTT6bu64XVwnc+bno/eMp6WnyNXyoDm8WlPhFDcuxy+2RXYbcJ8KxYUyls1mhoK/+XDrVomCirIV1B5UPgG/mxCdpfV0O+FTL/u9Lx0mE10zfZhcBIpGiub7p+motvSPorcvZQSkG4y4/orbCkELba4FMny5K4QskTZFCePcGCkvjbxapVnTcQd75k9n/vLIy8h7+pzHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUJIUnaTjpazeZwyWqeAb7HNyT+ng84puzlLBDekHSs=;
 b=cOc2ZG2Xtb5yaRPZ5P7ZDHxzfiDFGIuPRWXMYr7iU9ozRLodskg4UpGLvfOD+2LCQOYxuACoF/L/hAfHg9SvT8Y7WtohzXG4FHDoDyKVKEcOIysf0/yfuMNe0K9egbcn2it7M/QrTOJDIVF36KZGJ+dqbLg7W5iUz02aGgiG9b4=
Received: from BN9PR03CA0741.namprd03.prod.outlook.com (2603:10b6:408:110::26)
 by LV8PR10MB7821.namprd10.prod.outlook.com (2603:10b6:408:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:45:53 +0000
Received: from BN2PEPF0000A993.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::4a) by BN9PR03CA0741.outlook.office365.com
 (2603:10b6:408:110::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 13:45:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF0000A993.mail.protection.outlook.com (10.167.248.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 13:45:51 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:45:08 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:45:08 -0600
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 3 Nov 2026 07:45:08 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A3Dj8kh803392;
	Tue, 3 Nov 2026 07:45:08 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6A3Dj7DP022226;
	Tue, 3 Nov 2026 07:45:07 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <haokexin@gmail.com>, <philippe.schenker@impulsing.ch>,
        <devnexen@gmail.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@kernel.org>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <danishanwar@ti.com>
Subject: [RFC PATCH net-next 1/2] icssg: Add multi-flow RX support with per-flow NAPI and classification
Date: Tue, 3 Nov 2026 19:14:56 +0530
Message-ID: <20261103134501.4123194-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103134501.4123194-1-m-malladi@ti.com>
References: <20261103134501.4123194-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A993:EE_|LV8PR10MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1c0ca0-67af-4f9d-d148-08df39b0c6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|1800799024|376014|6133799003|10067099003|18002099003|22082099003|261102123227099003|261102130727099003|3023799007|56012099006|261028144727099003|261026140227099003|921020|261022105027099003|261009223027099003|261022075727099003|261026121527099003|261021121427099003|261021123027099003|260925021311599003|260925022911599003|260925021911599003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	JFHTxWv/8obbWL/bFTmEV+MLt0Ga+BLt6MAhG4Rav+y6DKeGve0GcRwCxl54s7u3PJXoo6rWUb8n8dAZbn1iOBIEGBpi4lYNGjPYp0rKPQG5PHjTCOJ2Z3l48njO+zl6tHrDuQzTEt51Fyya72K0Kh6uuUrOASFgLmHuSwFArKBh1lZnEUlT7qAGrZDysrZYfduCE99V0WbXeKldTAkFH3tE0hmKZlmOgbE+SpAxZBDryfhBquScu3Iv/2HEFaSCVK1MfX2WVEpvNhBgNiqdcRBqp72t9jTV8574YYQ/YzKEOpsUrE+1D1vxeCA3Un+T1QndmjeqYH38NDzrj8GpnWXKnQL5EFV3iynJWaGsDTioTdrwUtxitzrBQ6EYY7YSJhHrjDd3B/tUSI75VD7ltSChDDnoRyTJ286MGfXcriZg0pR82NoR4eM20BKiHyT0pdAf6doKUh8HkLMOFyogEh7jK4oBPCCtrrXC2d//kM9H32JkOUK8C2Hd60Oh7qxl3o/Khp1RdGO5/0VNbZyhF3CSe6UTTkuLGYcBPCN81lb9AxTz6/2rV8xwFLbOo3vZcR4vgsX2vvHnZRM43wpUlVc2nhgUjxCXqRjcpMWshq96XQRuvd7xC4XahYL5waGFWShPUIwje/dR8w4+23/hghDKwjefKY0hsfQNC+3I1PwPO+X5sPw4378+PhooccuL+/sOAHFFUMpaln3rHSJ2ija1VZgNEeWbizZOTC4eD0zizXkvPr13hKl/IXojP/u3
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261102130727099003)(3023799007)(56012099006)(261028144727099003)(261026140227099003)(921020)(261022105027099003)(261009223027099003)(261022075727099003)(261026121527099003)(261021121427099003)(261021123027099003)(260925021311599003)(260925022911599003)(260925021911599003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B0t/36EFcxPp/iU1XDy5T8ERltSfWGzmgWr/O7B7GFLzbQYIRZ+XEyJFbQMAwv0zmoiPkz164jX16zMNgaXC68HAAuRVa0HeBpYbB7IqYb+hB9MK/c/oH93WMi7qlMx8w/KNyz8aYJWqlTu1tm/26EhejMaRmoKrcH9IsdmNVTu8lT5ceI6YbWn1Rx4Do2X5CgKxK3vG+8uSWv02JnmrA81LLxCQxkWII4uBr/9jYs7+2O9ntlsZ5ExgX+ecCAbor5VYKaHLDkZsuZ3n33rZicCuLDDeZD4f5SZidtJudUYKtIkN1/4lM6k4FV4NwqJsQcJlHwbATJSrVDvnyRltNATHJtESGK0+A8wpe2pe5MIHNBzk4N8NiA8Hv7bFqunRVM0fKy6OESJnZlXuXViiYJa72wx1n/aoQzvXt6LQm6F+Cslx9Mn6TU7D45EWhGBm
X-Exchange-RoutingPolicyChecked:
	cvWoMXbsBDvgJwIFbTcT1Z27+I7F8GtT1mHqSrN3crjjMWSaWvGN5nbQiJH8UglzrAnXaeKPXZDUA1Ngb6IWmiPS7+ZLW/9ysOsh7y2kz7tNCKJq2gJ34mhMawnW1iCvBOiLHXYKj0yv2Jhl7w+yVcYYKXGkPac15MatrT5EhTp4RrUiONR42cUw5SWpk9yp7NVlJIbcFu4wUx50eLB4s0nzjK3317/S2nC30JEz+gK3FNnH2TZzENzn8OW2g9SLJJU72z6OJ3s6CDrkWjc251ju1eHL46WbXUEJdVox9AhqrMxUXqMMcrmkH6LJQb5d5Kb7fDPXXRQa7vDGk7S0yg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:45:51.8293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1c0ca0-67af-4f9d-d148-08df39b0c6a2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A993.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7821
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX/fZ/9X57+req
 RWfx/JuW6fAnOR/gYlfkiLvJ50Rr5DRw//2q36BCCkamQcxpsLTrz0hQZnhn5CiAicpX8N0rfD6
 PIqB7UhoPvHiI55/A1v//5vcPCn1Ahi4mH00/ZkltFB1dDBnQUfruE4gTAglS0vRL/WL4o9Bjo6
 XifjEeqZn+ytkOhFXgmKxlnQPQSHfq1uloCt50Sx1lUJKzhN3eDAXneEg/TM88JrsiI/enBd31z
 yPEn48BhRC2ouG3GAdmbnjXjwdZQZ0XsQAb87gBHkO7cMwFkRmgf8SiQFk+stzSPb3IMwfCkK0W
 iaec1XqKqrkTt0SpUVyX9uFzokNHUcQlVB7DAOTccDwocPmBM4Hkh+kZSfbvPYeaJSGcUEwjKkP
 1RHVr+yx6GoO/ARr07w6tJRTF06D0YY28782uqo7fPIuW3e1kfE6OOKw2ACpUIFkJgExr4G31dK
 OyUtcL6SyC6Qy14084Q==
X-Authority-Analysis: v=2.4 cv=BflNQbt2 c=1 sm=1 tr=0 ts=6ae9e598 cx=c_pps
 a=D1syOSCgd/TrkoObF8KiHg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=7W41c5MMuVg88q0r6tsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pC5ZsED2lRdMCKlDx8MWtrjl7P7TKR8x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX5klTEP3EMJao
 Z9NpLU6Y3FfCcRYwLapOQKOQwggqCid6thONqpVSTRddmg8t6945ivw46Nky+1EuhWOgTR9RVKd
 aHbMtW0GgQSO0n+FCEXZvj5ieuWtOtg=
X-Proofpoint-GUID: pC5ZsED2lRdMCKlDx8MWtrjl7P7TKR8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054

Extend ICSSG driver to support up to 8 independent RX flows per EMAC
(PRUETH_MAX_RX_FLOWS 1→8), enabling ethtool queue steering added in the
next commit.

Data structures:
- Introduce prueth_rx_flow for per-flow state: NAPI, hrtimer, page pool,
  XDP rxq, AF_XDP pool, IRQ. All flows share one UDMA channel and
  descriptor pool (PRUETH_MAX_RX_DESC × flow_count).
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
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 359 ++++++++++--------
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  17 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 256 ++++++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  61 ++-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |   4 +-
 6 files changed, 386 insertions(+), 318 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 4a7d1a6f470b1..99f4353b46966 100644
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
@@ -599,25 +642,29 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 		if (!i)
 			fdqring_id = k3_udma_glue_rx_flow_get_fdq_id(rx_chn->rx_chn,
 								     i);
-		ret = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
-		if (ret < 0) {
+		flow->irq = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
+		if (flow->irq <= 0) {
+			ret = flow->irq;
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
@@ -641,8 +688,9 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
 	swdata->type = PRUETH_SWDATA_PAGE;
 	swdata->data.page = page;
+	swdata->flow_id = flow_id;
 
-	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
+	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, flow_id,
 					desc_rx, desc_dma);
 }
 EXPORT_SYMBOL_GPL(prueth_dma_rx_push_mapped);
@@ -863,6 +911,7 @@ static int prueth_dma_rx_push_mapped_zc(struct prueth_emac *emac,
 					struct xdp_buff *xdp)
 {
 	struct net_device *ndev = emac->ndev;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[PRUETH_RX_FLOW_DATA];
 	struct cppi5_host_desc_t *desc_rx;
 	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma;
@@ -880,7 +929,7 @@ static int prueth_dma_rx_push_mapped_zc(struct prueth_emac *emac,
 	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
 			 PRUETH_NAV_PS_DATA_SIZE);
 	k3_udma_glue_rx_dma_to_cppi5_addr(rx_chn->rx_chn, &buf_dma);
-	buf_len = xsk_pool_get_rx_frame_size(rx_chn->xsk_pool);
+	buf_len = xsk_pool_get_rx_frame_size(rx_flow->xsk_pool);
 	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
 	swdata->type = PRUETH_SWDATA_XSK;
@@ -890,18 +939,18 @@ static int prueth_dma_rx_push_mapped_zc(struct prueth_emac *emac,
 					desc_rx, desc_dma);
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
+		ret = prueth_dma_rx_push_mapped_zc(emac, &emac->rx_chns, xdp);
 		if (ret) {
 			netdev_err(emac->ndev, "rx alloc: failed to map descriptors to xdp buff\n");
 			xsk_buff_free(xdp);
@@ -912,14 +961,14 @@ static int prueth_rx_alloc_zc(struct prueth_emac *emac, int budget)
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
@@ -938,7 +987,7 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
 		skb->offload_fwd_mark = emac->offload_fwd_mark;
 	skb->protocol = eth_type_trans(skb, ndev);
 
-	napi_gro_receive(&emac->napi_rx, skb);
+	napi_gro_receive(&emac->rx_chns.flows[flow_id].napi_rx, skb);
 	ndev->stats.rx_bytes += pkt_len;
 	ndev->stats.rx_packets++;
 }
@@ -947,6 +996,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 			     int budget)
 {
 	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[flow_id];
 	u32 buf_dma_len, pkt_len, port_id = 0;
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
@@ -997,7 +1047,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 			switch (ret) {
 			case ICSSG_XDP_PASS:
 				/* prepare skb and send to n/w stack */
-				emac_dispatch_skb_zc(emac, xdp, psdata);
+				emac_dispatch_skb_zc(emac, xdp, psdata, flow_id);
 				xsk_buff_free(xdp);
 				break;
 			case ICSSG_XDP_CONSUMED:
@@ -1010,7 +1060,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 			}
 		} else {
 			/* prepare skb and send to n/w stack */
-			emac_dispatch_skb_zc(emac, xdp, psdata);
+			emac_dispatch_skb_zc(emac, xdp, psdata, flow_id);
 			xsk_buff_free(xdp);
 		}
 		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
@@ -1022,13 +1072,13 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
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
@@ -1037,6 +1087,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 {
 	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[flow_id];
 	u32 buf_dma_len, pkt_len, port_id = 0;
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
@@ -1051,7 +1102,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	void *pa;
 
 	*xdp_state = 0;
-	pool = rx_chn->pg_pool;
+	pool = rx_flow->pg_pool;
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
 	if (ret) {
 		if (ret != -ENODATA)
@@ -1093,7 +1144,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 
 	pa = page_address(page);
 	if (prueth_xdp_is_enabled(emac)) {
-		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
+		xdp_init_buff(&xdp, PAGE_SIZE, &rx_flow->xdp_rxq);
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
 		*xdp_state = emac_run_xdp(emac, &xdp, &pkt_len);
@@ -1132,15 +1183,15 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
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
@@ -1155,19 +1206,22 @@ void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
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
@@ -1411,11 +1465,12 @@ EXPORT_SYMBOL_GPL(prueth_tx_cleanup);
 
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
@@ -1436,50 +1491,38 @@ EXPORT_SYMBOL_GPL(prueth_cleanup_tx_ts);
 
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
@@ -1488,59 +1531,77 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
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
+		 * pool needed.  Push as many XSK buffers as descriptors allow;
+		 * the fill ring will be replenished by user-space.
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
+		if (desc_avail < PRUETH_MAX_RX_DESC)
+			netdev_warn(emac->ndev,
+				    "not enough RX descriptors available %d < %d\n",
+				    desc_avail, PRUETH_MAX_RX_DESC);
 
-			ret = prueth_dma_rx_push_mapped(emac, chn, page, buf_size);
-			if (ret < 0) {
-				netdev_err(emac->ndev,
-					   "cannot submit page for rx chan %s ret %d\n",
-					   chn->name, ret);
-				page_pool_recycle_direct(chn->pg_pool, page);
-				goto recycle_alloc_pg;
-			}
+		prueth_rx_alloc_zc(emac, flow, desc_avail);
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
+	if (desc_avail < PRUETH_MAX_RX_DESC)
+		netdev_warn(emac->ndev,
+			    "not enough RX descriptors available %d < %d\n",
+			    desc_avail, PRUETH_MAX_RX_DESC);
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
@@ -1557,16 +1618,20 @@ void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
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
 
@@ -1752,8 +1817,6 @@ void prueth_netdev_exit(struct prueth *prueth,
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
index b715af21d23ac..5c2936ecd595c 100644
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
@@ -245,6 +248,8 @@ static int emac_set_coalesce(struct net_device *ndev,
 			     struct netlink_ext_ack *extack)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *flow = &rx_chn->flows[0];
 	struct prueth *prueth = emac->prueth;
 	struct prueth_tx_chn *tx_chn;
 
@@ -264,7 +269,7 @@ static int emac_set_coalesce(struct net_device *ndev,
 		coal->tx_coalesce_usecs = ICSSG_MIN_COALESCE_USECS;
 	}
 
-	emac->rx_pace_timeout_ns = coal->rx_coalesce_usecs * 1000;
+	flow->rx_pace_timeout_ns = coal->rx_coalesce_usecs * 1000;
 	tx_chn->tx_pace_timeout_ns = coal->tx_coalesce_usecs * 1000;
 
 	return 0;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b4..8338402597b21 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -403,20 +403,6 @@ static void emac_adjust_link(struct net_device *ndev)
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
@@ -587,43 +573,6 @@ const struct icss_iep_clockops prueth_iep_clockops = {
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
@@ -883,14 +832,14 @@ static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
 static void prueth_set_xsk_pool(struct prueth_emac *emac, u16 queue_id)
 {
 	struct prueth_tx_chn *tx_chn = &emac->tx_chns[queue_id];
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[PRUETH_RX_FLOW_DATA];
 
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
 
@@ -921,7 +870,27 @@ static void prueth_destroy_txq(struct prueth_emac *emac)
 	}
 }
 
-static void prueth_destroy_rxq(struct prueth_emac *emac)
+static void prueth_destroy_rxq(struct prueth_emac *emac, int qid)
+{
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *flow = &rx_chn->flows[qid];
+
+	/* reset napi and hrtimer, and free all pending buffers */
+	napi_disable(&flow->napi_rx);
+	hrtimer_cancel(&flow->rx_hrtimer);
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
 
@@ -936,9 +905,13 @@ static void prueth_destroy_rxq(struct prueth_emac *emac)
 	 * RX NAPI Handler. To avoid timing out when waiting for the TDCM to
 	 * be popped, schedule the RX NAPI handler to run immediately.
 	 */
-	if (!napi_if_scheduled_mark_missed(&emac->napi_rx)) {
-		if (napi_schedule_prep(&emac->napi_rx))
-			__napi_schedule(&emac->napi_rx);
+	for (int i = 0; i < emac->rx_flow_num; i++) {
+		if (test_bit(i, emac->xsk_queues)) {
+			if (!napi_if_scheduled_mark_missed(&emac->rx_chns.flows[i].napi_rx)) {
+				if (napi_schedule_prep(&emac->rx_chns.flows[i].napi_rx))
+					__napi_schedule(&emac->rx_chns.flows[i].napi_rx);
+			}
+		}
 	}
 
 	ret = wait_for_completion_timeout(&emac->tdown_complete,
@@ -946,15 +919,9 @@ static void prueth_destroy_rxq(struct prueth_emac *emac)
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
 
@@ -978,27 +945,62 @@ static int prueth_create_txq(struct prueth_emac *emac)
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
+	ret = xdp_rxq_info_reg(rxq, emac->ndev, 0, flow->napi_rx.napi_id);
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
+	prueth_destroy_rxq(emac, id);
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
 
@@ -1018,8 +1020,6 @@ static int emac_ndo_open(struct net_device *ndev)
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
 	struct device *dev = prueth->dev;
-	int max_rx_flows;
-	int rx_flow;
 
 	/* set h/w MAC as user might have re-configured */
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
@@ -1034,7 +1034,6 @@ static int emac_ndo_open(struct net_device *ndev)
 		return ret;
 	}
 
-	emac->xsk_qid = -EINVAL;
 	init_completion(&emac->cmd_complete);
 	ret = prueth_init_tx_chns(emac);
 	if (ret) {
@@ -1042,9 +1041,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		return ret;
 	}
 
-	max_rx_flows = PRUETH_MAX_RX_FLOWS;
-	ret = prueth_init_rx_chns(emac, &emac->rx_chns, "rx",
-				  max_rx_flows, PRUETH_MAX_RX_DESC);
+	ret = prueth_init_rx_chns(emac);
 	if (ret) {
 		dev_err(dev, "failed to init rx channel: %d\n", ret);
 		goto cleanup_tx;
@@ -1054,14 +1051,9 @@ static int emac_ndo_open(struct net_device *ndev)
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
@@ -1087,7 +1079,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		goto stop;
 
 	/* Prepare RX */
-	ret = prueth_create_rxq(emac);
+	ret = prueth_create_rxqs(emac);
 	if (ret)
 		goto free_tx_ts_irq;
 
@@ -1105,18 +1097,18 @@ static int emac_ndo_open(struct net_device *ndev)
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
 
@@ -1149,7 +1141,7 @@ static int emac_ndo_stop(struct net_device *ndev)
 		__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
 
 	prueth_destroy_txq(emac);
-	prueth_destroy_rxq(emac);
+	prueth_destroy_rxqs(emac);
 
 	cancel_work_sync(&emac->rx_mode_work);
 
@@ -1162,10 +1154,10 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	free_irq(emac->tx_ts_irq, emac);
 
-	free_irq(emac->rx_chns.irq[PRUETH_RX_FLOW_DATA], emac);
+	prueth_ndev_del_rx_napi(emac, emac->rx_flow_num);
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
 
-	prueth_cleanup_rx_chns(emac, &emac->rx_chns, PRUETH_MAX_RX_FLOWS);
+	prueth_cleanup_rx_chns(emac);
 	prueth_cleanup_tx_chns(emac);
 
 	prueth->emacs_initialized--;
@@ -1467,7 +1459,6 @@ static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
 static int prueth_xsk_pool_enable(struct prueth_emac *emac,
 				  struct xsk_buff_pool *pool, u16 queue_id)
 {
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
 	u32 frame_size;
 	int ret;
 
@@ -1481,7 +1472,7 @@ static int prueth_xsk_pool_enable(struct prueth_emac *emac,
 	if (frame_size < PRUETH_MAX_PKT_SIZE)
 		return -EOPNOTSUPP;
 
-	ret = xsk_pool_dma_map(pool, rx_chn->dma_dev, PRUETH_RX_DMA_ATTR);
+	ret = xsk_pool_dma_map(pool, emac->rx_chns.dma_dev, PRUETH_RX_DMA_ATTR);
 	if (ret) {
 		netdev_err(emac->ndev, "Failed to map XSK pool: %d\n", ret);
 		return ret;
@@ -1492,21 +1483,21 @@ static int prueth_xsk_pool_enable(struct prueth_emac *emac,
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
 			return ret;
 		}
 		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
 		if (ret) {
-			prueth_destroy_rxq(emac);
+			prueth_destroy_rxq(emac, queue_id);
 			return ret;
 		}
 		ret = prueth_xsk_wakeup(emac->ndev, queue_id, XDP_WAKEUP_RX);
@@ -1528,7 +1519,7 @@ static int prueth_xsk_pool_disable(struct prueth_emac *emac, u16 queue_id)
 		return -EINVAL;
 	}
 
-	if (emac->xsk_qid != queue_id) {
+	if (!test_bit(queue_id, emac->xsk_queues)) {
 		netdev_err(emac->ndev, "XSK queue ID %d not registered\n", queue_id);
 		return -EINVAL;
 	}
@@ -1544,27 +1535,28 @@ static int prueth_xsk_pool_disable(struct prueth_emac *emac, u16 queue_id)
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
@@ -1594,9 +1586,9 @@ int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth_tx_chn *tx_chn = &emac->tx_chns[qid];
-	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	struct prueth_rx_flow *rx_flow = &emac->rx_chns.flows[PRUETH_RX_FLOW_DATA];
 
-	if (emac->xsk_qid != qid) {
+	if (!test_bit(qid, emac->xsk_queues)) {
 		netdev_err(ndev, "XSK queue %d not registered\n", qid);
 		return -EINVAL;
 	}
@@ -1611,7 +1603,7 @@ int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
 		return -EINVAL;
 	}
 
-	if (!rx_chn->xsk_pool) {
+	if (!rx_flow->xsk_pool) {
 		netdev_err(ndev, "XSK pool not registered for RX queue %d\n", qid);
 		return -EINVAL;
 	}
@@ -1624,9 +1616,9 @@ int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
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
 
@@ -1697,6 +1689,14 @@ static int prueth_netdev_init(struct prueth *prueth,
 	}
 
 	emac->tx_ch_num = 1;
+	emac->rx_flow_num = 1;
+	emac->xsk_queues = devm_bitmap_zalloc(prueth->dev,
+					      PRUETH_MAX_RX_FLOWS, GFP_KERNEL);
+	if (!emac->xsk_queues) {
+		dev_err(prueth->dev, "failed to allocate xsk_queues bitmap\n");
+		ret = -ENOMEM;
+		goto free_ndev;
+	}
 
 	irq_name = "tx_ts0";
 	if (emac->port_id == PRUETH_PORT_MII1)
@@ -1783,11 +1783,7 @@ static int prueth_netdev_init(struct prueth *prueth,
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
index df93d15c5b786..509b9cbda58cf 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -132,18 +132,27 @@ struct prueth_tx_chn {
 	bool irq_disabled;
 };
 
+struct prueth_rx_flow {
+	u32 id;
+	struct prueth_emac *emac;
+	struct napi_struct napi_rx;
+	unsigned int irq;
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
@@ -246,14 +251,10 @@ struct prueth_emac {
 	u64 stats[ICSSG_NUM_MIIG_STATS];
 	u64 pa_stats[ICSSG_NUM_PA_STATS];
 
-	/* RX IRQ Coalescing Related */
-	struct hrtimer rx_hrtimer;
-	unsigned long rx_pace_timeout_ns;
-
 	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
-	int xsk_qid;
+	unsigned long *xsk_queues;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
@@ -455,30 +456,30 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
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
@@ -486,13 +487,11 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
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
index b8115ca47082f..582d582cba89f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -570,11 +570,11 @@ static int emac_ndo_open(struct net_device *ndev)
 	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
 
 	/* Prepare RX */
-	ret = prueth_prepare_rx_chan(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZE);
+	ret = prueth_prepare_rx_flow(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZE);
 	if (ret)
 		goto stop;
 
-	ret = prueth_prepare_rx_chan(emac, &emac->rx_mgm_chn, 64);
+	ret = prueth_prepare_rx_flow(emac, &emac->rx_mgm_chn, 64);
 	if (ret)
 		goto reset_rx_chn;
 
-- 
2.43.0

