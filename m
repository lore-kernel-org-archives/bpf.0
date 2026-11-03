Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793713567;
	b=iIRp4e0G7sT4FxgLQ7622OPzPwRv5WnFbYqQaqlrYVnp0zYBQ+4ITGgimMQ8bMDy3l8r
	 dMYGlNu0Xd/Gy9aOlwwCs9IzL13kY4em2KzMLJETEtbotmiNs90XV1ErdDiYkLAxC4+Ik
	 iyTp5AdYmYhX0ZYSqljMgAwCFHHfk0Ze55KXvKSfDiR1JghO042kSGBYwzEHeGuf7IOYu
	 JDslD9pK+3MiOS8pftaN1jkVFIJyOBFJ1QtDgGkeBum8PU1aMOebhVAEEaJ305B3iXP+W
	 WlVbbDygHApMx1A8225PJf93Fx90+yl7k2gxMmVdUN97mImuDlAeHjzmE5577+jVWMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713567;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=m1s7mEz401MORpUJ2adENd4DjHt2LmLCRWwrJoJQd00=;
	b=BiuoKYHILFgQ43haCMqg8hmmVr4kwV2LhuIpQd2j00csjxu+XeK+h/UhhogZrQWGSqHf
	 fEcPpauDrY4otbjxlFs4KMywobmnbodcoGOueMDHbg1uRJr0AGwn0p6EEZjmAg1MaRiun
	 h/HV+vS/+O6sMM1oc0mKNP8qyOfW/sht5Ma2koGLFsG8r9u6duMqDc7ASc2VbcE6xrMTc
	 4eMB7dgaHN5ME/bD3d4OSo0sA30BT4jHI1zl2S8IEGYTENAKmiDswRiYIkXFJJ/ii1A36
	 b/oL570W07w6vH8yLav5c1vCpVJ6I1EqtKgUt7dC0e8IdEvn+8B9XwhKeGiJS0ukX7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=WY7uvYcJ;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=YVC++tC4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08E606A32E;
	Tue,  3 Nov 2026 13:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D08E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=WY7uvYcJ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=YVC++tC4
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Dc9oB3942172;
	Tue, 3 Nov 2026 07:45:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=m1s7mEz401MORpUJ2adENd4DjHt2LmLCRWwrJoJQd
	00=; b=WY7uvYcJnSL59QbnAMYw4N6DVjK722yOj8VLYwTJAUVYiBfQ1xa2IeeEk
	5buKLT9DAHRvwxPYVb1TJzZhJ689NrRCylQ1ltQ3gyvG30ehyRnDqv2dw4EcgGoB
	WgDWYwejYr5yqz16KMOx8BQ9P8BRH6uVfD/YzdMsMuFFBWlAKrHGzHWm54i5i2X3
	Wo/TY9bABxvW4YtHdEEDzCsXYsnzvJU9gVxBgOEeQpCr1zG5D6cjhEtDtU/ttXSl
	RVQE91J06CjL+LdJww4EreWbx2/CwPXoI4E2Nz9RjgViW1+Hzn4oB5tSlRxYhqx0
	wIL2cAS9ihcRHxp6rxXnSLBN02bMQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hqcuq98er-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:45:34 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mg7rlvd3IoWoTlHpsh7H7GvWn9x9E8MA7yfhstpNoS4R1TJ/BnaleGJVxBwUO27g8Z7da4UXWS5Hv7PiHNDI/PJEoPIABQT2/mDHuAxn9jaqGdB97rIeJ9jfp6Q9I/2QrkUJu2lXzguM9z+eAz/74slJKkamyQkPFetUOYXgN2Tz/jlT+o4+ZJXxnxxS34F1eJcWTrzsOy0xHhIPMACRZb7oYAFSui83ssd/VdUbGLcFhaNUqz+lw2sEuuoIPTChU8UpiBhn5bVU6rQHaAdYsL465xc/iLX7x2uC9VdYv+gvhh/C8tR3Ik+AAFUvUiP2cP4S3zDvMtHEUALyfRMdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1s7mEz401MORpUJ2adENd4DjHt2LmLCRWwrJoJQd00=;
 b=sR0QIR6XwfOqV9cDhfWrzXKHU2JLwkbF5WmDwHVE/hlnvJRIOGSv0lm495NYUW7KaSdJw43UvpqfCQxIkKuP0Ts8RVFkVhYqq/ANYYMV0yRDZbpfTLsCAyhnzWHgoK15K/Qgj7kBWi8ozt3qQShhnykVSlVfaEOKvh3W9B915K+gy8netxDrhZ1isaq3P87pYIGs91hN09wH9OG/qWXYLYbPAz6xGbu4JgALjWgwVstks6ztJqfK7ng87cVldheY7Axo+Fkw2IS3cvaeNbSsr8mZf5x4LaNdFnMdP/x7X/1kAa5qMCFpLZxwzqk6Y0mWObYRyuRN1bMOn1zRSNiejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1s7mEz401MORpUJ2adENd4DjHt2LmLCRWwrJoJQd00=;
 b=YVC++tC4otFCFH3dmSqixPLZKr046bpedzia5Z95WMuPRcixjGndSi8bNSetqSnKQF298TM6ocqou2fLGESk94HaIVO8i+fEwpY6Xy09ymEcN2CtAEvbdvVzZqmadJMymLb25VHnbYCddonId8GQ3j3MxHC3kjX0Z/tWqzt21QU=
Received: from BL1PR13CA0092.namprd13.prod.outlook.com (2603:10b6:208:2b9::7)
 by DS4PPFA5A8CF00B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:45:28 +0000
Received: from LV8PEPF00000069.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::78) by BL1PR13CA0092.outlook.office365.com
 (2603:10b6:208:2b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 13:45:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 LV8PEPF00000069.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 13:45:28 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:45:11 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:45:11 -0600
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 3 Nov 2026 07:45:11 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A3DjBLG803465;
	Tue, 3 Nov 2026 07:45:11 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6A3DjAFk022235;
	Tue, 3 Nov 2026 07:45:11 -0600
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
Subject: [RFC PATCH net-next 2/2] icssg: Add ethtool RX flow classification support
Date: Tue, 3 Nov 2026 19:14:57 +0530
Message-ID: <20261103134501.4123194-3-m-malladi@ti.com>
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
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000069:EE_|DS4PPFA5A8CF00B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b764737-526a-4a85-e382-08df39b0b8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|1800799024|376014|6133799003|10067099003|18002099003|22082099003|261102123227099003|261102130727099003|3023799007|56012099006|261028144727099003|261026140227099003|921020|261022105027099003|261009223027099003|261022075727099003|261026121527099003|261021121427099003|261021123027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	xeVIXHysq7R6GAZ8K3rIeMiro0bX4RjPTK8+cqnvv5HcB0h2dRxX70aoK7TUyKGtcjOSI0MlKjqBNbav7B7H7nTtlamsIUAim0X9bovXOIya7M3fiW4nHufxneQp9yNkiE7RG+jGX49HzmhcE31gpr2ZJQGf6EJsuW+knuD6VhOd/YlV4jwmFOZ0Dq/rw+gJ1dShUWByjNVM46nI9TzcQkV6ghkCQAieysxG7+9Wf4BtaHkRFRtg+beSj/sTH8Go/NAZyGchawz29yYmAZY77CxTF6j08PHSd95jWNFSL41fiGC4OSBebXlucPF1sRxPuvq28ekeB3PMt09C8pnU5oqFAEVV3HJ5zwkUcVfTOhNp0tef9bDNlHQtXY6VxtBwSFSbPvQb0uOZq9OEZ+IpLYj1MUAphr2mWYau3eE42KTsgtFgO09UUcv84+UQV9Obcv/Tg6vWU6/Jg2BFoS/TlDtj7Ek9NPfSy3GJ+AD5Tohu/1Q2/26Pf8hh8w52mTGQaM2LdEeRzThI2latHaeZD8+Y2PEMY/me2sH5X/6DqKSAYXrz8/IkQQ16AgDsk9Gtxuixljyo/4tKdw4opq4a3HekFFv2Db1vuDXtgfdQ0mIHaUVmR1jcrcvUqdYG87t6Bgtpc2UJWa5L/iKhL9Zjf7xnY2ofpWlo2uriCmSKqWDypOUU2Uinl8+i9FpJpeWUWydmdN+FkjjOQOpNclgkektPCQJPXRyPxE09AzBvpmv0G+KFuHYmM1MroQcebc69
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261102130727099003)(3023799007)(56012099006)(261028144727099003)(261026140227099003)(921020)(261022105027099003)(261009223027099003)(261022075727099003)(261026121527099003)(261021121427099003)(261021123027099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fHx6ECo8WSxpbJKOd8b+B/gRFD7QaHxyRf88CUUEPwDJ6S52EM5yFTBFOOqIWo4jQhtCSM5IJCIrvtPRevcIWcc76gvk/4y9Ue32ghl5R6Di37+IfIQJrhSLTyrnAldKDiM3GZKarxysd8DFuaVrq/QTo18DwFH+JxxEqPUuzHmrCNUcxPot8zzGAJccGWE7+MSXE0dsdIc4e2zXwhatJfjWtQZNFv75k9VhB0oCDnAFFC0wS0KrWzqdpx+9uGfGuK9dAGk6k4xFu+ZfPt45WAqGG+hjw9k5gnLRn7pWhft4aXlTlQ8/JqBeV6vS3HbPykfLfTgOyedDRJoZCc3b12lV6dFSdiq9p8WBMJJgb/qJbUanwVwHBsHApHYB4yBhI8X+2vtu+eWqySU5wapPNHCGV9OMbClX6GQ4mlOR4LuRWjlEukIJsqA+6FdXI1n9
X-Exchange-RoutingPolicyChecked:
	XTsYyg2qPt2jTOCruQYYdfCnbqZVEnYN3XaDGtug8CCC5f3WWi09LakJ3ZEOA8h0j1Q0vaNxAiUxDI2mwa0gLaLT4XLdmvXAI2kv/Ee7hy5SHeJvsqcGMcpjkO2uz+WatVCAnZO7HEz7zSoXRo2Uctf+XUKXmQPrkFhJU6ZYzG+lg6ojN/yJpdadFJrU4Sawrc9ATyK5+FVZERsbt9NMFiIFDtG+j/1cC1DpIBnZeotoH6ubtMsD3pKa/mIXrte1dNaY7HCuvrErRjVCQGrL68xFOBVWUZshpHPX20EJInhCy/1mjfIswTUBJM8vGKSXHEi94JhccDp7zt5C3DG8qA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:45:28.4225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b764737-526a-4a85-e382-08df39b0b8af
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000069.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA5A8CF00B
X-Authority-Analysis: v=2.4 cv=fc84WEQF c=1 sm=1 tr=0 ts=6ae9e57e cx=c_pps
 a=5YU8ENXygJz5UkgxsLF+dA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=WN52PlUurRMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=p5BLjhJybKsi-UoUADsA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
X-Proofpoint-GUID: SdM9AH3O2mfpe4uDfQL7f7ZXc_a_B_eH
X-Proofpoint-ORIG-GUID: SdM9AH3O2mfpe4uDfQL7f7ZXc_a_B_eH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX2Si6FcEQuSw8
 PQsbOVHNZSZJxaOGl6nwYXotWAZl5tWeN/+zPxhyb/HOYDPvhASBT6HORzL8rcLdTRxBS3mS1cV
 XtBzp6NnDtGlHpxOnGeQfkFRc7e3Aey0sGHmICAHv4bbV4yew1iIHkyQzenHS4s+7So1tj/h9aO
 PAfSApDwkMJrktXqOzm9iG4liFkxOdFQJOy1x4fu+3xe1U6EEGawGP1HJuItCKI1zf9Ir4y8QhT
 YXV+n8UjbXhDa2YkVaGxLOuhaeVp6Ab1QjlweDTWYn9+q4Zko57zDPZ4HZSSH+PTmQ+J8M3uLyu
 sJfPXcufHKIRSbwX45Bss6TXp2rPFEg4dAFSf0KgoNWbWAT+tFFwum2oR/ZRNPtU4LkfHGF67b2
 tqR3fZUfk5rBOlSbZMvXBwvTdvmX1721qpYo4uejXr33Zla05GvbViplczlWGKv6pP+kr6G5N69
 ECbPj94LFYgl3dhkyJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXw/Ip8BiSy5YD
 MtnAAbh+V1yrXkmBZW01uZuIpMB6jI86WY3JX0JOCJLrQZp5TpG2uCotVJH339tJGnGhe7LxKt7
 ne9f91R/7r8Cmr3ZWHCsYi6ax1LZ6Ks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054

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
 .../net/ethernet/ti/icssg/icssg_classifier.c  | 340 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  48 +++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  27 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  32 ++
 4 files changed, 446 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 87a8577093dbb..f11539611df75 100644
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
@@ -532,3 +540,335 @@ void icssg_ft3_hsr_configurations(struct regmap *miig_rt, int slice,
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
+		if (cls < ICSSG_NUM_CLASSIFIERS)
+			or_table[cls] |= RX_CLASS_FT_FT3_MATCH(rule->ft3_slot);
+	}
+
+	/* Write OR tables for user-rule classifiers; skip classifier 0 (default flow).
+	 * Use RX_CLASS_N_REG with RX_CLASS_OR_EN — NOT RX_CLASS_OR_REG which uses
+	 * rx_class_or_base (= rx_class_base + 4), causing an off-by-4 that lands on
+	 * AND_EN of classifier n+1 instead of OR_EN of classifier n.
+	 */
+	for (n = 1; n < ICSSG_NUM_CLASSIFIERS; n++) {
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
+	/* Only ETHER_FLOW supported for Phase 1 */
+	if (fs->flow_type != ETHER_FLOW)
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
+	/* Clear all user-rule classifier OR tables (classifier 0 = default, skip) */
+	for (n = 1; n < ICSSG_NUM_CLASSIFIERS; n++)
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
+	mutex_lock(&emac->rxnfc.rxnfc_lock);
+
+	/* Check max rules */
+	if (emac->rxnfc.rxnfc_rule_count >= ICSSG_RXNFC_MAX_RULES) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	/* Check for duplicate */
+	if (rule_exists(emac, fs)) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	/* Allocate FT3 slot */
+	ft3_slot = allocate_ft3_slot(emac);
+	if (ft3_slot < 0) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	/* Auto-assign location from FT3 slot if RX_CLS_LOC_ANY requested */
+	if (fs->location == RX_CLS_LOC_ANY)
+		fs->location = ft3_slot;
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
+			     u32 *rule_cnt)
+{
+	struct icssg_rxnfc_rule *rule;
+	u32 count = 0;
+
+	mutex_lock(&emac->rxnfc.rxnfc_lock);
+
+	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
+		rule_locs[count++] = rule->location;
+	}
+
+	*rule_cnt = count;
+
+	mutex_unlock(&emac->rxnfc.rxnfc_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_get_all);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 5c2936ecd595c..9f0a1116e530c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -299,6 +299,52 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static int emac_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *info,
+			  u32 *rule_locs)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret = 0;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXRINGS:
+		info->data = emac->rx_flow_num;
+		break;
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
+		ret = icssg_rxnfc_rule_get_all(emac, rule_locs, &rule_cnt);
+		if (!ret)
+			info->rule_cnt = rule_cnt;
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
@@ -322,5 +368,7 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_rxnfc = emac_get_rxnfc,
+	.set_rxnfc = emac_set_rxnfc,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 8338402597b21..f234198d4cc42 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -874,10 +874,29 @@ static void prueth_destroy_rxq(struct prueth_emac *emac, int qid)
 {
 	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
 	struct prueth_rx_flow *flow = &rx_chn->flows[qid];
+	dma_addr_t desc_dma;
 
-	/* reset napi and hrtimer, and free all pending buffers */
 	napi_disable(&flow->napi_rx);
 	hrtimer_cancel(&flow->rx_hrtimer);
+
+	/* Drain the UDMA completion ring for this flow before resetting
+	 * the free ring.  k3_udma_glue_reset_rx_chn() only drains the
+	 * free ring (descriptors pushed as empty receive buffers).  Any
+	 * frames that the hardware already DMA-completed but NAPI hadn't
+	 * popped yet remain in the completion ring with their pages still
+	 * counted as "inflight" in the page pool.  Draining them here
+	 * ensures page_pool_destroy() finds zero inflight pages and
+	 * completes immediately instead of stalling for 60+ seconds.
+	 *
+	 * The caller must have stopped new frames from arriving (e.g. via
+	 * icssg_set_port_state(ICSSG_EMAC_PORT_DISABLE)) before calling
+	 * prueth_destroy_rxq() so this loop terminates.
+	 */
+	while (!k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, qid, &desc_dma)) {
+		if (!cppi5_desc_is_tdcm(desc_dma))
+			prueth_rx_cleanup(rx_chn, desc_dma);
+	}
+
 	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, flow->id, rx_chn,
 				  prueth_rx_cleanup);
 
@@ -1160,6 +1179,9 @@ static int emac_ndo_stop(struct net_device *ndev)
 	prueth_cleanup_rx_chns(emac);
 	prueth_cleanup_tx_chns(emac);
 
+	/* Cleanup RX flow classification rules */
+	icssg_rxnfc_rule_cleanup(emac);
+
 	prueth->emacs_initialized--;
 
 	return 0;
@@ -1676,6 +1698,9 @@ static int prueth_netdev_init(struct prueth *prueth,
 	emac->ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
 
+	/* Initialize RX flow classification */
+	icssg_rxnfc_rule_init(emac);
+
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
 	ret = pruss_request_mem_region(prueth->pruss,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 509b9cbda58cf..7a316184aee32 100644
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
@@ -192,6 +193,19 @@ struct prueth_swdata {
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
 /* data for each emac port */
 struct prueth_emac {
 	bool is_sr1;
@@ -255,6 +269,14 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	unsigned long *xsk_queues;
+
+	/* RX flow classification via ethtool */
+	struct {
+		struct list_head rules;              /* List of active RXNFC rules */
+		struct mutex rxnfc_lock;             /* Protect rule list */
+		unsigned int rxnfc_rule_count;       /* Number of active rules */
+		u16 ft3_slots_used;                  /* Bitmask of allocated FT3 slots */
+	} rxnfc;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
@@ -399,6 +421,16 @@ static inline int prueth_emac_slice(struct prueth_emac *emac)
 	}
 }
 
+/* RX flow classification functions */
+void icssg_rxnfc_rule_init(struct prueth_emac *emac);
+void icssg_rxnfc_rule_cleanup(struct prueth_emac *emac);
+int icssg_rxnfc_rule_add(struct prueth_emac *emac, struct ethtool_rxnfc *info);
+int icssg_rxnfc_rule_del(struct prueth_emac *emac, u32 location);
+int icssg_rxnfc_rule_get(struct prueth_emac *emac, u32 location,
+			 struct ethtool_rx_flow_spec *fs);
+int icssg_rxnfc_rule_get_all(struct prueth_emac *emac, u32 *rule_locs,
+			     u32 *rule_cnt);
+
 extern const struct ethtool_ops icssg_ethtool_ops;
 extern const struct dev_pm_ops prueth_dev_pm_ops;
 
-- 
2.43.0

