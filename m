Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795027832;
	b=EqNINFpJ+f3fQKFu6DK0UYT0NVCnkm/Kj0+L9FTY0eUOaA1VHa2bx6+yw+jXS6Yffoc3
	 ZHLv1TZgOu7eCPWdDZXnSm0bFd0auMxJ1lHfD6/f17858iYUGfGys3UylWkRg84WoI8/E
	 WP9LoKyjj5T358k9FY8mNSTsbUic+Qr2I3+OoWyplTfQczB60UHlSOfuoW/9vDq+sPbRf
	 Mvt6N2bMyTLBhhW7RJQPyFzAl0d8/0HNgd9pQh24q5w7jy704r9MoykcBfVIr1V8T+xZe
	 RXIm3HHtsSUYzDodoPY5cgD0HgXvemMmaWeKX196upZ0QSu9GIDiq6m949npztoSQvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027832;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=j4EZ2rDwAjqxdYv1TNNSflD1AzzP7hTHP5n8zfkaohI=;
	b=iTTsJgS4g3mAgE0oCu0m1zI1UdqYw371C4iiQvE1HVksDpgMxApeJPschvFRoKuRhDq/
	 gxCywNBmm27TEZG+glyG0XSY76uVplBISIK1Zfz71jtZGaiNKZ8LTgETA6tTeXcJlFMHn
	 kYekyCJG6mHkWdfevVJ7XQRSJz9xitCxhN1dxdOB6E9eRO4pPZ9l6p9CblsxqjWaGS6PM
	 WIgVkaqLgPWHo5aeKSRrQaLYjEIHyoF/12im6TCRz6KlqymL6zELBzlTHbEGrJTTqj0q1
	 1Yxg2ot9SEj+mL9JluO7xDuDxm0m69vPhHijrbXY7Gtodow2ypANMXLHVNeYJbFkPpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=APrffa5p;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=X8n+jzUn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABF606A31C;
	Wed, 18 Nov 2026 18:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44ABF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=APrffa5p;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=X8n+jzUn
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AIHFm6t3882377;
	Wed, 18 Nov 2026 12:49:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=j4EZ2rDwAjqxdYv1TNNSflD1AzzP7hTHP5n8zfkao
	hI=; b=APrffa5pfOthml/40jSSF4XFIh9oBcEUdZXHvzt2w0M+P1qBlVpka3uuu
	2Gj31YyzoJ+PP7JZSVHXy/FXahujPmZimGXGVWb+NsDR1BjF3xxRm4Lf9RGCxwxS
	AQbsJTJdVBRk6CFauu4yFfR63fsl515sdHivU2eNV3XaU2t3wk1XjCjM5oqxDqJe
	giFHHvtlZYbLVYdfAi9PET3PguY/orjSwN3pnXxqcjWev13q2xE4YIbBIeqEuT5F
	5reUixkCjsMRDtwDX1HejcK+YglHaldPYz96LxjGAEDkrvSUYC5HHMonkRHcAuDn
	54AMDskpoaqNXpOhueY4X26Skt29Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012029.outbound.protection.outlook.com [40.107.200.29])
	by m0384305.ppops.net (PPS) with ESMTPS id 4j19fp32bh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 12:49:36 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibpdxuCEu+y+r5ZlZElyLpx0l6J62vyO3dDByzfzsgJuTyRZ2GUnxdIuBF2yShXt7p8Xx5qnS3rzghQ7k7j+9mzpUP9H4B/ftuAWWrBFRgnd5WRPKnL2EzGnMg3OYI1dZ1BiAiw76HFII0ExC2xeDwejYg7wX0X+VtbA3OoIcmPfg+mUcxU1iYTmzFRsgaLPS0Iih3xy5p9tOu4NARU1vUYon7Pe0jLo14APIgRmOtd/NyLHYcB2x8YkkT1hk416o9gQJU+PHhNF1HkdPhHxHwhS7CdS5PsBNumhrucHU+nDStjyYYob8fyj+GRozl4dPJTiTO6JiDWR4Z/IrOQzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4EZ2rDwAjqxdYv1TNNSflD1AzzP7hTHP5n8zfkaohI=;
 b=cP9Xhljq6FgsS/19iu72pMv87yZH9sGCnEm1fUE3sJ/WGZY2nXQ5Tnf+ENy62prtfq23IBnJaT/VMVOL973rfNrnbTXAL1O9GczmHNObL64uqPLRj4DpwACyPytY2yo/gKx6JGe82Xj3pFY0njNBKSxwAB1mbP72gcNnfabkSClUItTZi8QcvnRKX9CpegqpFOPpAH+ceMuKf04VpQiX+vaTyHaP9U0SuCUhE+DkcHPBFdGQcCR+lxNOSCNR4FxqDhGyy86msay95PG5QBpgoc1Xx92Qbl2o8YU8hnTWzSo+X1H/epeaWpDPMIip5SGE7uYafzepbVEfhx94v/X9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=suse.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4EZ2rDwAjqxdYv1TNNSflD1AzzP7hTHP5n8zfkaohI=;
 b=X8n+jzUnXmfyModc9v3oWh8oFdeDxXtaZcahuCakdpYckx0F4idKk7bvrKCLQQvjyzUMgBnRRL7/yZAEWasXWBE/lQfsyYTAXKgBWlWWESU/K+YB1+i7sMYsvrFNLgjiwPJkIAhI7Dzh1nkxIXYyTl41THxi/m6JUCvkDDI3ngs=
Received: from SJ2P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::8)
 by MN2PR10MB4127.namprd10.prod.outlook.com (2603:10b6:208:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 18:48:29 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::95) by SJ2P220CA0009.outlook.office365.com
 (2603:10b6:a03:5da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 18:48:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:48:29 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 12:47:44 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 12:47:44 -0600
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 18 Nov 2026 12:47:44 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AIIliEh321271;
	Wed, 18 Nov 2026 12:47:44 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6AIIlgrA007573;
	Wed, 18 Nov 2026 12:47:43 -0600
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
Subject: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool RX flow classification support
Date: Thu, 19 Nov 2026 00:17:27 +0530
Message-ID: <20261118184729.2302130-3-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|MN2PR10MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: e671cc52-89a5-4311-d42d-08df45a4898f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|6133799003|22082099003|18002099003|261009223027099003|3023799007|921020|56012099006|261102130727099003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	rTYKuO8RGZtiXPCRrMqUnz3PXYkMq7R/Ku8+pb7sZOrov4D/boV9h8G8KMJ1+NBxNsZpcZPKXA8SRgCWLl1/okc9O6cWt4rACCl2keXzWY8ckJPlN0zBSk0KkLYd3gXoK7PxD/LtUnbHnS+Bg2jcgPXmrVw+39HaGuayBZN1jIY0oI/DmecjMfZ/4b9P5pZdZuJHgG5x7Eqft6QxeI+XL78O/MhJ5oBhoLoBj7toNV28bP1D86a0p6faznVrdDFJkWYJRjU2vWqT1MOataEqXrKP4FVv8bg/Q8+5cIN+j5seYBw4xfzqFaSLl3SSvFAi0IhbYgJ7DywbDW6xgtuciLxMahCXLWTCpFmgfdrW5Py0t2TPlcqkj+MPH/AXAeUfchrI1h7IFHB/ubjpQ2yx0msOtmN2Bg/wynEYipVa8p7iEh9pNGUmb6ga7Ts8MoCmfJFBgAk4TmtrTbD6emtOEQjPfcoIa4fKXhF4v8NyMnY3Vx43xgSnbj+6mmDteaGO82xfSc/HezHdOPbndPkC5O+KGcDvcWTgpI/GGs1RsQCvUd4zNDQ0ocsavdHERJz07yBQFGyigeeqXBks1xZ9IgNt/XfBWfXJyvlMKajLHcmECUF/StAxmXBs/nuEivA6QUe6pz1mf6ckP6QZwfyPJqZ4WEpXIGODWtDNaZ/fMcxoTljWTZimWGjPMXWwCTlwxtPGsLMqCIi5ATNaZG6hzwBxhVqz6ouX6a9YPBDLx+rqNOco7FzrQxv67roMIL01
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(921020)(56012099006)(261102130727099003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LJIOAF/JkO6kstyHv0S30JRq6o1okFToHvxmlkfWAYWsDuzo/2Y7X725JmEwBR0DXLaF1Tky4ZqSCEUAC7sQ7wONCe0v96vglRX5GcOh0ky9mA0we9snmKwrLCSF7J9fbNGii3kfk/E81dsvYsqW10mQIMXO1ierI65PqX+O/cio7TCqpxtC4Io4UszoxIh9xhg8k7T+32TqtqpPyZWYxlL/9B3NajMxGg9xBVB4+EnxjfMay+9gZrps6x01mXarYzr9fuVXty/TtDfw+endl/9kSKWYs89ACgMi60I3qoc0E8cGdK4o/x+OD0FF1uTmm+96afCafEpZAk/gSYAe0XqT4rvdkY/CBABLhNcmnLy1lEtTaT/aE2/2jc5dUVlIh61ktRRvzNYJAGb/mW4FBasBLPtF5rFKA5tljRBZFv5Lc7GA9WopqI0sqaFvrbMe
X-Exchange-RoutingPolicyChecked:
	5mwOoRq0hgEdDXZ1Gj9GqNY0KC7jKUCTPwTksjgpG9Euc6vjssA2oYf00SCqnXpNIecr+63cjSo3B2EMm1v3iv21BEo7yEZ2WtrswB43U020h+yKq3DXmmU0RxyKxa1grMIaJvDaVhe3qU+NBhaR81/YvZ/h++y68VmM5NPQ5lfnnGU0YHtfO54pRoZvEFjBREaFbvnzhphtFHsrCJKHc7rFYDHAtxgFUaaE229AtNF6OXTi9Dvu86lDUzncnlWJmH08e++Bnxc77T3ZtCiQXSqGy+aLPHJYcHf6ehE52Pmf7Njr3Dnq6O5z1JGdpdFRsmZiS+7QSbxeQ2zV9TU8nA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:48:29.3468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e671cc52-89a5-4311-d42d-08df45a4898f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4127
X-Proofpoint-GUID: uEZZ7YC5jEKV32QliHb80WD01ZvTNacb
X-Authority-Analysis: v=2.4 cv=ebKo7LEH c=1 sm=1 tr=0 ts=6afdf340 cx=c_pps
 a=6BjqzLHNfcmCQygjyc7k5Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=fzIV0iIhEgMQ3wqdSLwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX5s2HNgaghPJx
 pm6pEAYcCYnNXmJEDhChhqUaCeuY3cVJF8KPzhS0W3VaSy6/9GgGXIjbKLKdlCgoaWr/YMoaC3b
 fpu9D4wNN7egT90MatrsDEA7D7PZc8M=
X-Proofpoint-ORIG-GUID: uEZZ7YC5jEKV32QliHb80WD01ZvTNacb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX6L0yt7gvuOtz
 JoWLUaYIrovOu28kwqzWDjUX1EpOeEINtYr17cY7pzlSoo4L6FqTXSgcdM0x09DHkwzqXgNZqtL
 rQWFTME3gHCyM8J3bKZH8k9AqGFsX3fMeicOIZ7wIx7hRgYMIlW8LVFW+qOH+tIcYB8rkiDbdKL
 6ubMmP8y6OX4iKCSaIplp/IRS/jfExkPQ4LUKytAn/kmWxG8NOFFgbh04fq0l35BhS4Th7Akp/A
 RvOc2wUOWxmqIyjvyQ+4vhSVaDug32IbK3yZMzNogxq5QAA82nKaio+b4ES9LsYBAV+o04UlwpA
 vOGhynckfrtL3ZXBJQrbpXy1Ydk3HTf69n+aNPJTYulgx0gxc/vVENZkRJjdLs4AbS/F3ecdFVN
 cd5RhqFywx33Mdngl2prCPIlju01xkTG86vc2jJ5N1htLVrGk+9YYYHLz952LH/gylrukqiWP/A
 oaNuH1qgFHbN8u8HCJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180074

Enable dynamic RX flow classification via ethtool set_rxnfc/get_rxnfc.
Users can install/remove filter rules to steer packets to specific RX flows
based on EtherType patterns via FT3 hardware filters.

- Add RXNFC rule tracking structures and lifecycle management
- Implement ethtool get_rxnfc/set_rxnfc callbacks
- FT3 slot allocation and hardware programming for pattern matching
- RX classifier OR table updates based on active rules
- Max 15 rules per EMAC, using FT3 slots 0-13,15 (slot 14 reserved)

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

RFC->v1 Changelog:
Sashiko comments addressed:
- Classifier/cleanup loop clobbers HSR/PRP classifiers 10/11
- Masks not checked; ring_cookie==0 rule never reaches HW 
- fs->location not validated; FT3 slot â‰  location; duplicates
- icssg_rxnfc_rule_get_all NULL deref / heap overflow 
- ETHTOOL_GRXRINGS dead code in emac_get_rxnfc
- SR1 uses icssg_ethtool_ops but rxnfc uninitialized
- Rules lost on suspend/resume; not re-applied on open
- Rules leaked when driver removed while interface down

Sashiko comments skipped:
- ringrxfdq overflow with multi-flow, doesn't get affected for
  BCDMA
- prueth_create_rxq napi hang - fixed in previous patch
- Sequential prueth_destroy_rxqs destroys flow 0 pool before
  flows 1..N drained - doesn't get affected for BCDMA
- __be16 â†’ u16 sparse warning - low priority and fix doesn't add
  much value

 .../net/ethernet/ti/icssg/icssg_classifier.c  | 407 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_common.c  |   4 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  59 +++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   9 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  35 ++
 5 files changed, 514 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 87a8577093dbb..520b3f3377784 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -105,6 +105,14 @@ enum ft1_cfg_type {
 	((BIT(slot) << RX_CLASS_FT_FT1_MATCH_SHIFT) & \
 	RX_CLASS_FT_FT1_MATCH_MASK)
 
+#define RX_CLASS_FT_FT3_MATCH(slot)	\
+	((BIT(slot) << RX_CLASS_FT_FT3_MATCH_SHIFT) & \
+	RX_CLASS_FT_FT3_MATCH_MASK)
+
+/* FT3 Configuration registers and modes */
+#define FT3_CFG_REGISTER_EQUAL		(1U)
+#define FT3_CFG_REGISTER_VLAN_SKIP	BIT(2)
+
 /* HSR/PRP protocol frame filtering */
 #define HSR_PTP_ETHERTYPE_OFFSET	0x12
 #define PRP_PTP_ETHERTYPE_OFFSET	0x0C
@@ -532,3 +540,402 @@ void icssg_ft3_hsr_configurations(struct regmap *miig_rt, int slice,
 	}
 }
 EXPORT_SYMBOL_GPL(icssg_ft3_hsr_configurations);
+
+/* RX Flow Classification (ethtool) rule management */
+
+/* Allocate free FT3 slot, avoiding reserved slot 14 */
+static int allocate_ft3_slot(struct prueth_emac *emac)
+{
+	u16 used = emac->rxnfc.ft3_slots_used | ICSSG_FT3_RESERVED_SLOTS;
+	int slot;
+
+	for (slot = 0; slot < ICSSG_NUM_FT3_SLOTS; slot++) {
+		if (!(used & BIT(slot))) {
+			emac->rxnfc.ft3_slots_used |= BIT(slot);
+			return slot;
+		}
+	}
+	return -ENOSPC;
+}
+
+/* Free allocated FT3 slot */
+static void free_ft3_slot(struct prueth_emac *emac, int slot)
+{
+	emac->rxnfc.ft3_slots_used &= ~BIT(slot);
+}
+
+/* Program FT3 filter slot with ethertype pattern */
+static void icssg_ft3_program_filter(struct regmap *miig_rt, int slice,
+				     int slot, struct icssg_rxnfc_rule *rule)
+{
+	const struct ethtool_rx_flow_spec *fs = &rule->flow_spec;
+	u16 ether_type;
+
+	/* Extract EtherType from flow spec (network byte order) */
+	ether_type = fs->h_u.ether_spec.h_proto;
+
+	/* Deactivate filter before programming */
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_CFG), 0);
+
+	/* EtherType is at byte 12 in standard Ethernet frames */
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_START),
+		     PRP_PTP_ETHERTYPE_OFFSET);
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_START_AUTO), 0);
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_START_OFFSET), 0);
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_JUMP_OFFSET), 0);
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_LEN), 0);
+
+	/* FT3 compares a 32-bit LE word at FT3_START. EtherType occupies the
+	 * lower 16 bits of that word. FT3_T_MASK=0xFFFF0000 masks the upper
+	 * 16 bits (payload bytes), so only the lower 16 bits are compared.
+	 *
+	 * h_proto is __be16 (network byte order). On LE the raw integer value
+	 * equals the lower 16 bits of the LE 32-bit word at the EtherType
+	 * offset in the frame — e.g. IPv4 0x0800 BE → h_proto = 0x0008 on LE,
+	 * which is exactly what FT3 sees in the lower 16 bits of the word at
+	 * byte 12. No conversion needed; using be16_to_cpu() here would invert
+	 * the byte order and break the match.
+	 * Reference: FT3_PTP_PATTERN = 0xF788 = htons(0x88F7) = raw h_proto value.
+	 */
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_T),
+		     (__force u32)ether_type);
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_T_MASK), FT3_ETHERTYPE_MASK);
+
+	/* Enable filter: register-equal mode */
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_CFG),
+		     FT3_CFG_REGISTER_EQUAL);
+}
+
+/* Disable FT3 filter slot */
+static void icssg_ft3_disable_filter(struct regmap *miig_rt, int slice, int slot)
+{
+	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_CFG), 0);
+}
+
+/* Update RX classifiers for all active FT3 rules.
+ * Classifier N maps to RX flow N (firmware routes classifier-N hits to
+ * UDMA flow rx_flow_id_base + N). Build a per-classifier OR table so
+ * that each target queue gets its own classifier entry.
+ */
+static void icssg_rxnfc_classifier_update(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	struct regmap *miig_rt = prueth->miig_rt;
+	int slice = prueth_emac_slice(emac);
+	u32 or_table[ICSSG_NUM_CLASSIFIERS] = { };
+	struct icssg_rxnfc_rule *rule;
+	int n;
+
+	if (slice < 0)
+		return;
+
+	/* Build per-classifier OR table: classifier index = target queue index */
+	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
+		int cls = rule->queue_index;
+
+		if (cls < emac->rx_flow_num)
+			or_table[cls] |= RX_CLASS_FT_FT3_MATCH(rule->ft3_slot);
+	}
+
+	/* Write OR tables for classifiers 0..rx_flow_num-1. Only update
+	 * classifiers within the user-flow range to avoid disturbing HSR/PRP
+	 * classifiers (e.g. 10/11) beyond it. Use RX_CLASS_N_REG with
+	 * RX_CLASS_OR_EN — NOT RX_CLASS_OR_REG which uses rx_class_or_base
+	 * (= rx_class_base + 4), causing an off-by-4 that lands on AND_EN of
+	 * classifier n+1 instead of OR_EN of classifier n.
+	 */
+	for (n = 0; n < emac->rx_flow_num; n++) {
+		regmap_write(miig_rt,
+			     RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN),
+			     or_table[n]);
+	}
+}
+
+/* Validate rule parameters */
+static int validate_rule(struct prueth_emac *emac,
+			 struct ethtool_rx_flow_spec *fs)
+{
+	/* Only ETHER_FLOW supported; reject extension flags */
+	if (fs->flow_type != ETHER_FLOW)
+		return -EOPNOTSUPP;
+
+	/* Only exact EtherType match supported — reject partial proto mask,
+	 * non-zero MAC address masks, and flow extension flags.
+	 */
+	if (fs->m_u.ether_spec.h_proto != htons(0xFFFF))
+		return -EOPNOTSUPP;
+	if (!is_zero_ether_addr(fs->m_u.ether_spec.h_dest) ||
+	    !is_zero_ether_addr(fs->m_u.ether_spec.h_source))
+		return -EOPNOTSUPP;
+
+	/* Check RX queue is valid */
+	if (fs->ring_cookie >= emac->rx_flow_num)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Check if identical rule already exists */
+static bool rule_exists(struct prueth_emac *emac,
+			struct ethtool_rx_flow_spec *fs)
+{
+	struct icssg_rxnfc_rule *rule;
+
+	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
+		if (rule->flow_spec.flow_type == fs->flow_type &&
+		    rule->flow_spec.h_u.ether_spec.h_proto ==
+		    fs->h_u.ether_spec.h_proto) {
+			return true;
+		}
+	}
+	return false;
+}
+
+/* Initialize RX flow classification */
+void icssg_rxnfc_rule_init(struct prueth_emac *emac)
+{
+	INIT_LIST_HEAD(&emac->rxnfc.rules);
+	mutex_init(&emac->rxnfc.rxnfc_lock);
+	emac->rxnfc.rxnfc_rule_count = 0;
+	emac->rxnfc.ft3_slots_used = ICSSG_FT3_RESERVED_SLOTS; /* Mark slot 14 reserved */
+}
+EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_init);
+
+/* Restore RX flow classification hardware state from the in-memory rule list.
+ * Call after icssg_class_default() resets the classifier registers on open or
+ * after firmware restart so that existing rules take effect again.
+ */
+void icssg_rxnfc_rule_restore(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	struct regmap *miig_rt = prueth->miig_rt;
+	int slice = prueth_emac_slice(emac);
+	struct icssg_rxnfc_rule *rule;
+
+	if (slice < 0)
+		return;
+
+	mutex_lock(&emac->rxnfc.rxnfc_lock);
+
+	list_for_each_entry(rule, &emac->rxnfc.rules, list)
+		icssg_ft3_program_filter(miig_rt, slice, rule->ft3_slot, rule);
+
+	icssg_rxnfc_classifier_update(emac);
+
+	mutex_unlock(&emac->rxnfc.rxnfc_lock);
+}
+EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_restore);
+
+/* Cleanup RX flow classification */
+void icssg_rxnfc_rule_cleanup(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	struct regmap *miig_rt = prueth->miig_rt;
+	int slice = prueth_emac_slice(emac);
+	struct icssg_rxnfc_rule *rule, *tmp;
+	int n;
+
+	if (slice < 0)
+		return;
+
+	mutex_lock(&emac->rxnfc.rxnfc_lock);
+
+	/* Disable all active FT3 filters */
+	list_for_each_entry_safe(rule, tmp, &emac->rxnfc.rules, list) {
+		icssg_ft3_disable_filter(miig_rt, slice, rule->ft3_slot);
+		free_ft3_slot(emac, rule->ft3_slot);
+		list_del(&rule->list);
+		kfree(rule);
+	}
+
+	emac->rxnfc.rxnfc_rule_count = 0;
+	emac->rxnfc.ft3_slots_used = ICSSG_FT3_RESERVED_SLOTS;
+
+	/* Clear user-rule classifier OR tables; stop at rx_flow_num to avoid
+	 * disturbing HSR/PRP classifiers beyond the user-flow range.
+	 */
+	for (n = 0; n < emac->rx_flow_num; n++)
+		regmap_write(miig_rt,
+			     RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN), 0);
+
+	mutex_unlock(&emac->rxnfc.rxnfc_lock);
+}
+EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_cleanup);
+
+/* Add a new RX flow classification rule */
+int icssg_rxnfc_rule_add(struct prueth_emac *emac, struct ethtool_rxnfc *info)
+{
+	struct ethtool_rx_flow_spec *fs = &info->fs;
+	struct prueth *prueth = emac->prueth;
+	struct regmap *miig_rt = prueth->miig_rt;
+	int slice = prueth_emac_slice(emac);
+	struct icssg_rxnfc_rule *rule;
+	int ft3_slot;
+	int ret;
+
+	if (slice < 0)
+		return -EINVAL;
+
+	/* Validate rule parameters */
+	ret = validate_rule(emac, fs);
+	if (ret)
+		return ret;
+
+	/* Validate explicit location: reject special specifiers, out-of-range
+	 * values, and the reserved slot 14 used by HSR/PRP.
+	 */
+	if (fs->location != RX_CLS_LOC_ANY) {
+		if (fs->location >= ICSSG_RXNFC_MAX_RULES ||
+		    BIT(fs->location) & ICSSG_FT3_RESERVED_SLOTS)
+			return -EINVAL;
+	}
+
+	mutex_lock(&emac->rxnfc.rxnfc_lock);
+
+	/* Check max rules */
+	if (emac->rxnfc.rxnfc_rule_count >= ICSSG_RXNFC_MAX_RULES) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	/* Check for duplicate flow spec */
+	if (rule_exists(emac, fs)) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	/* Allocate FT3 slot. For explicit locations, the location IS the FT3
+	 * slot — this keeps location and slot aligned so rule_del operates on
+	 * the correct hardware slot. For RX_CLS_LOC_ANY, auto-allocate the
+	 * lowest free slot and assign it as the location.
+	 */
+	if (fs->location != RX_CLS_LOC_ANY) {
+		ft3_slot = fs->location;
+		if (emac->rxnfc.ft3_slots_used & BIT(ft3_slot)) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+		emac->rxnfc.ft3_slots_used |= BIT(ft3_slot);
+	} else {
+		ft3_slot = allocate_ft3_slot(emac);
+		if (ft3_slot < 0) {
+			ret = -ENOSPC;
+			goto unlock;
+		}
+		fs->location = ft3_slot;
+	}
+
+	/* Allocate rule structure */
+	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
+	if (!rule) {
+		ret = -ENOMEM;
+		free_ft3_slot(emac, ft3_slot);
+		goto unlock;
+	}
+
+	/* Program FT3 hardware */
+	rule->flow_spec = *fs;
+	rule->ft3_slot = ft3_slot;
+	rule->queue_index = fs->ring_cookie;
+	rule->location = fs->location;
+
+	icssg_ft3_program_filter(miig_rt, slice, ft3_slot, rule);
+
+	/* Add to rule list */
+	list_add(&rule->list, &emac->rxnfc.rules);
+	emac->rxnfc.rxnfc_rule_count++;
+
+	/* Update classifier */
+	icssg_rxnfc_classifier_update(emac);
+
+	ret = 0;
+
+unlock:
+	mutex_unlock(&emac->rxnfc.rxnfc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_add);
+
+/* Delete a RX flow classification rule */
+int icssg_rxnfc_rule_del(struct prueth_emac *emac, u32 location)
+{
+	struct prueth *prueth = emac->prueth;
+	struct regmap *miig_rt = prueth->miig_rt;
+	int slice = prueth_emac_slice(emac);
+	struct icssg_rxnfc_rule *rule, *tmp;
+	int ret = -ENOENT;
+
+	if (slice < 0)
+		return -EINVAL;
+
+	mutex_lock(&emac->rxnfc.rxnfc_lock);
+
+	list_for_each_entry_safe(rule, tmp, &emac->rxnfc.rules, list) {
+		if (rule->location == location) {
+			icssg_ft3_disable_filter(miig_rt, slice, rule->ft3_slot);
+			free_ft3_slot(emac, rule->ft3_slot);
+			list_del(&rule->list);
+			kfree(rule);
+			emac->rxnfc.rxnfc_rule_count--;
+			icssg_rxnfc_classifier_update(emac);
+			ret = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&emac->rxnfc.rxnfc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_del);
+
+/* Get single RX flow classification rule */
+int icssg_rxnfc_rule_get(struct prueth_emac *emac, u32 location,
+			 struct ethtool_rx_flow_spec *fs)
+{
+	struct icssg_rxnfc_rule *rule;
+	int ret = -ENOENT;
+
+	mutex_lock(&emac->rxnfc.rxnfc_lock);
+
+	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
+		if (rule->location == location) {
+			*fs = rule->flow_spec;
+			ret = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&emac->rxnfc.rxnfc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_get);
+
+/* Get all RX flow classification rules */
+int icssg_rxnfc_rule_get_all(struct prueth_emac *emac, u32 *rule_locs,
+			     u32 rule_locs_capacity, u32 *rule_cnt)
+{
+	struct icssg_rxnfc_rule *rule;
+	u32 count = 0;
+	int ret = 0;
+
+	mutex_lock(&emac->rxnfc.rxnfc_lock);
+
+	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
+		if (!rule_locs) {
+			/* Caller passed rule_cnt=0: just count active rules */
+			count++;
+			continue;
+		}
+		if (count >= rule_locs_capacity) {
+			ret = -EMSGSIZE;
+			break;
+		}
+		rule_locs[count++] = rule->location;
+	}
+
+	*rule_cnt = count;
+
+	mutex_unlock(&emac->rxnfc.rxnfc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_get_all);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 6cd2a77c491ac..e5ad57d2a0713 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1830,6 +1830,10 @@ void prueth_netdev_exit(struct prueth *prueth,
 	if (of_phy_is_fixed_link(emac->phy_node))
 		of_phy_deregister_fixed_link(emac->phy_node);
 
+	/* Free any rules added while the interface was down */
+	if (!emac->is_sr1)
+		icssg_rxnfc_rule_cleanup(emac);
+
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 68646cb7df442..35eb056dab6d9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -300,6 +300,62 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static u32 emac_get_rx_ring_count(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	return emac->rx_flow_num;
+}
+
+static int emac_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *info,
+			  u32 *rule_locs)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret = 0;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		info->rule_cnt = emac->rxnfc.rxnfc_rule_count;
+		info->data = ICSSG_RXNFC_MAX_RULES | RX_CLS_LOC_SPECIAL;
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		ret = icssg_rxnfc_rule_get(emac, info->fs.location, &info->fs);
+		break;
+	case ETHTOOL_GRXCLSRLALL: {
+		u32 rule_cnt = 0;
+
+		ret = icssg_rxnfc_rule_get_all(emac, rule_locs,
+					       info->rule_cnt, &rule_cnt);
+		info->rule_cnt = rule_cnt;
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static int emac_set_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *info)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	switch (info->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		return icssg_rxnfc_rule_add(emac, info);
+	case ETHTOOL_SRXCLSRLDEL:
+		return icssg_rxnfc_rule_del(emac, info->fs.location);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -323,5 +379,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_rx_ring_count = emac_get_rx_ring_count,
+	.get_rxnfc = emac_get_rxnfc,
+	.set_rxnfc = emac_set_rxnfc,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 716f1b9195d67..b08e74e24a5a3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1101,6 +1101,12 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
 
+	/* Re-program FT3 filters and classifier OR tables from the persistent
+	 * rule list. icssg_class_default() called above resets all classifiers,
+	 * so rules must be restored here on every open/restart.
+	 */
+	icssg_rxnfc_rule_restore(emac);
+
 	ret = request_threaded_irq(emac->tx_ts_irq, NULL, prueth_tx_ts_irq,
 				   IRQF_ONESHOT, dev_name(dev), emac);
 	if (ret)
@@ -1715,6 +1721,9 @@ static int prueth_netdev_init(struct prueth *prueth,
 	emac->ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
 
+	/* Initialize RX flow classification */
+	icssg_rxnfc_rule_init(emac);
+
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
 	ret = pruss_request_mem_region(prueth->pruss,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index d54966730d102..af225e4ea00a6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/genalloc.h>
 #include <linux/if_vlan.h>
 #include <linux/if_hsr.h>
@@ -192,6 +193,26 @@ struct prueth_swdata {
 /* Minimum coalesce time in usecs for both Tx and Rx */
 #define ICSSG_MIN_COALESCE_USECS 20
 
+/* RX flow classification (ethtool) */
+#define ICSSG_RXNFC_MAX_RULES    15      /* Max user-installable rules */
+#define ICSSG_FT3_RESERVED_SLOTS BIT(14) /* Slot 14 reserved for HSR/PRP */
+
+/* RX flow classification rule structure */
+struct icssg_rxnfc_rule {
+	struct list_head list;
+	struct ethtool_rx_flow_spec flow_spec;  /* User-provided filter */
+	u16 ft3_slot;                            /* Allocated FT3 slot (0-15, excluding 14) */
+	int location;                            /* Rule location (user-provided) */
+	u32 queue_index;                         /* RX flow to route matches to */
+};
+
+struct prueth_rxnfc {
+	struct list_head rules;
+	struct mutex rxnfc_lock;
+	unsigned int rxnfc_rule_count;
+	u16 ft3_slots_used;
+};
+
 /* data for each emac port */
 struct prueth_emac {
 	bool is_sr1;
@@ -256,6 +277,9 @@ struct prueth_emac {
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
 	unsigned long *xsk_queues;
+
+	/* RX flow classification via ethtool */
+	struct prueth_rxnfc rxnfc;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
@@ -400,6 +424,17 @@ static inline int prueth_emac_slice(struct prueth_emac *emac)
 	}
 }
 
+/* RX flow classification functions */
+void icssg_rxnfc_rule_init(struct prueth_emac *emac);
+void icssg_rxnfc_rule_restore(struct prueth_emac *emac);
+void icssg_rxnfc_rule_cleanup(struct prueth_emac *emac);
+int icssg_rxnfc_rule_add(struct prueth_emac *emac, struct ethtool_rxnfc *info);
+int icssg_rxnfc_rule_del(struct prueth_emac *emac, u32 location);
+int icssg_rxnfc_rule_get(struct prueth_emac *emac, u32 location,
+			 struct ethtool_rx_flow_spec *fs);
+int icssg_rxnfc_rule_get_all(struct prueth_emac *emac, u32 *rule_locs,
+			     u32 rule_locs_capacity, u32 *rule_cnt);
+
 extern const struct ethtool_ops icssg_ethtool_ops;
 extern const struct dev_pm_ops prueth_dev_pm_ops;
 
-- 
2.43.0

