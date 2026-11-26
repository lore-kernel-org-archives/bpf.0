Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795672865;
	b=EKHGcTzPkfAGSW2RS7qi2Ff6Og8xYhXxg2PX0MD3f/l7I3GYvj+9CtNKpXsn/5tudKNW
	 hWJ0/TmmF0SuhT3dku6dFOJD7rjrVmcAIcrMGtjXi7yVk/YP73hautL7ljMbVasWe2L7G
	 km7UQzM2bJHGHdC3EFTB7wlp0tfsPXpL5jDBjNFAp3qpZcZ1KYWK4f4BFOxmmetEV+JGK
	 Zt/ruXW5WTlYOL5zSi+ZuZaA2zK/09HJyo9CpTLqoyWW3jfIXlVR0fpj4suEhHY0DHSjr
	 Nkq2QoYHatj4RCE3fKK8W3T7cQKtIFAcNpjfy3+d//5Ymphiysyf2DJlS17R2N9CCgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672865;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0DyxIL7XbOTcYqGjuYKgABHwHoXRMQxyNCyqOqzP0dU=;
	b=iq1dqfiQ5wsVTptYsUr1wATXY65yHK6nFvb5HI/n/9PVXlVpOskSr62ghzy9orcNDHu3
	 P0/ZT9zGWMxxFxL+wqivp1NZ5k6ZaMP4dceqBFQ0BU6kVQOkmkU7geDEq/Na4KzWAP+qK
	 hlrKUlbZmJLpaULf+bcH2ZLVxnZ56nvmvCW/3fwEQmoBXC60BibF7udqnOPQkOxpVzWNU
	 bmsbcpeqpfjY/P6iakhf6EVQyi9aE+9LFTvjCrCVyi/OdN0eL9X9N7ZSk7wMrVUKM0O7i
	 GfiC0a+s/4wejX+wv7VmaNk1SKToFoaNUSHYIQBDGxPW4Ut4PhB7YKvKVzahflWK5VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=jfAIb5ew;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Wlir2Wjc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EE606A31C;
	Thu, 26 Nov 2026 06:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=jfAIb5ew;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Wlir2Wjc
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ5WSZ82391188;
	Wed, 25 Nov 2026 23:59:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=0DyxIL7XbOTcYqGjuYKgABHwHoXRMQxyNCyqOqzP0
	dU=; b=jfAIb5ewrwFw/PqM0YHQ1apl8B8cFLB7IX9Y2gZPlKN8qs4xmormrUO99
	IAHbPtN1tPQOTbDn8JNEWZDYXAjDxtimDFw7SsupRmRsaUTFdVb1qpzBoxI+YQqG
	OOD5f+obJpU4B4J5Qinur4Wav8O33l8IFfWI0dykP3uAs8sYFWwRkcIWGUrix/nq
	rKjfLmbFzN0nlnjKfGHB9nN7ENKdIb3tI2ToAFdE8sr8Si6mq0Ju0w8tfY2wdjyJ
	MsNgv/BnFogcyWUPkynGTt5AFjXtsgntWW9oQ8aIu7TBx+LPKQpHweTkYM+KDaRG
	6Fqs1boWg4t3mNNtEvVz4rJ5h4M6Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j6eq9r36s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 23:59:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxvH5eo7RU95Pd9gaYtnwc7OGmdjIsuRh/Fi70D9/tRd4bqo3zXLAdDVNGBXtTcK/BqO2tAdBqwp3TCrtRHJdFHDT1n+yJ+hWSu68NzX9SdshJrCXpev5F8eyNS4ugsDT7ZP8yQpWvmN3Wog9PUtkbUHAQh1dQViGZ1McKlAbaI9u84oc9UD/4+zHIAJ0GI7dn2t9Rq83qZYMc4T5zUMjzQ4PLIdMZ/NCEq7Ltw4xKbVtgI4lBlinqQ02trjitY77ZVGSTnoB8zryxxm/zrc92Un3AMDdlpIj+9ZQguwL2C4w8HEgrJV6eLzeueM0BPHN3P5f8X9LckoeXU/p4fMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DyxIL7XbOTcYqGjuYKgABHwHoXRMQxyNCyqOqzP0dU=;
 b=w6kT8BxPufsXeSHfZD2V251bi7LaSULfDbuDSyLZpQLNZ6OOFF2OsPgE+4xm3CPoi0Ep7xtfnG38JR1fH0M2kNCqvL/W/uthlzg3dxjKdMIalZAfpTnCVoLrwP6U4nJMNm7Vio30sOIrlTisAR1luvxATv6Ahc7IxbEJZAQI84BXbvSba78vOTeCIi5l5hYlF4tRy8m26YKc3tHrs4tuPVvgN3Agsq/GyjSerfSE4zHznwk259fRpZdfm/R8kR9kArOKtC0+0JMo6ClSYsgWEbtzzKMDfEIEbiqW/F9aS+8aCa9uhK5PGlt6U7CHyO2KGJ3/oIyeOr+RM8P5PQVT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=suse.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DyxIL7XbOTcYqGjuYKgABHwHoXRMQxyNCyqOqzP0dU=;
 b=Wlir2WjcqswofrJAszbqmKAtzSwU0RjjBq2yN7FVIoUGNkxwKCAy1jSUZqyHtLOQoN6vkhkyrVm3hMj0URA0eQUm7v6D5PGt7oIM0vkVOOufC9c1tDCnIeJtCQ+txXEO80x4q5DHo78IQdPjYicNifWR8UDrB2slxtxlc16WHew=
Received: from BL1PR13CA0420.namprd13.prod.outlook.com (2603:10b6:208:2c2::35)
 by CC6PR10MB614384.namprd10.prod.outlook.com (2603:10b6:170:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 05:59:52 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::4d) by BL1PR13CA0420.outlook.office365.com
 (2603:10b6:208:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Thu, 26
 Nov 2026 05:59:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 05:59:52 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 25 Nov
 2026 23:59:52 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 25 Nov
 2026 23:59:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 25 Nov 2026 23:59:52 -0600
Received: from [172.24.231.93] (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AQ5xjap1069302;
	Wed, 25 Nov 2026 23:59:45 -0600
Message-ID: <0eed48e6-c525-4274-afd9-c42d99d860d5@ti.com>
Date: Thu, 26 Nov 2026 11:29:43 +0530
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
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add multi-flow RX
 support with per-flow NAPI
To: Simon Horman <horms@kernel.org>, <netdev-bot+sashiko@kernel.org>
CC: <marco.crivellari@suse.com>, <kees+treewide@kernel.org>,
        <laixiangwu@cmss.chinamobile.com>, <philippe.schenker@impulsing.ch>,
        <haokexin@gmail.com>, <devnexen@gmail.com>, <jacob.e.keller@intel.com>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@kernel.org>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <danishanwar@ti.com>
References: <20261118184729.2302130-2-m-malladi@ti.com>
 <179537406410.3135.5804903978186343042@kernel.org>
 <20261125121153.GU31322@horms.kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20261125121153.GU31322@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|CC6PR10MB614384:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a9e83e-c71a-406b-47f6-08df4b827d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|7416014|82310400026|376014|10067099003|5023799004|56012099006|261022115727099003|261026140227099003|261026130827099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021123027099003|261021130227099003|261021135927099003|261021121427099003|261022113327099003|261102123227099003|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	c0aL0RUI98L/z4hIGfFoaxRLbBh2pVEoYR0nH8OGoRqpskCmDE5MjsMRU5KqQBRn9pyFPuPKDWloVBBeRSql9NS7Lf3Rd1XKkylf39l4kkJ7t2RB8C05OEOxKEfyO6naJtO6Lb+c9KUFEirDR/5FlhrfThPG2ipJctPDD2yNgNfZOLqEnES3R4P3ZsmQj5zr0xZONKtOITHImHJOP1BLVjUiyBlu+SbJn5H7wJp4GxawAw0yDWeRKpDteI9q0O8zRwtZVNnpD3g+vVgy9M2D4WZlQXUsf6wTdmX7RAM83S4rS5GK8sIowU9J+GRMF9ZvkOnBqNSnh3s0UhS3fWliEWh7lCLaDruCh8Rhi9teF3B+MLnEDQGajmcPYFh2cUyM/2Xf9sb0JB7/lW/oVtyFTOR5yb9oz/A+50rU+abTixMS9m65fWwQ39guN8jjr5mMllI43PO/Rr4YhfdS+GVTsGtZcr9hNdfj2fvYtbIWtk68o94QdRO3mpNJ758XRaB6lsYQDEPge8NXmHIfcU9tuK990EF7zByufPYjgDU1cEXt5ttgk9CorXZv/ahM+W2piinhSBGThpbwMlKk0d4PGtThlAMA+0V9nka4yxtarzuLcvyvLQUW6Su0dro2sD0kO7aFSa9WukK2h46xLSz7Q1pGZxoGo8+XUbKQ5ezoO17sJHpkHH2uaBfZVB7OLxTejhCMW4iU/lvaGt9NwNd6TQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(82310400026)(376014)(10067099003)(5023799004)(56012099006)(261022115727099003)(261026140227099003)(261026130827099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021130227099003)(261021135927099003)(261021121427099003)(261022113327099003)(261102123227099003)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yGrT/JhaLOdiLu9RIjAO+ApnFfheYWHxS+qO9JlWVh9SwFgT5YYW3rfNBdWujX/Scg1+hvqczoUQUf2VmU96Y44QuHjBp4hpe2kYI53XB1cMnf6dAnmHupTWeCJRPnoKDeMy2PXsZdj/iJSTSGJCl64DjVa4oXhoVj7gWIC2RO9nHJeBShtr5nrO3nsF6dAtruIwNMR8N+enzg2mtyiMi+trWsbZP+/bomJ3kT6E4kaHbuwh0V+pEAMR8AocPT1SkWCQZ6t0eJVt6YUMkH4+fIlkZte+6iYih1rl0sQq6lcjYOdFwTX7C7tTSKPWvi1aCvtNZGG9AfHSWGsnjUoVS7y4+CPgYuoEJTX8IoipzOxACp9u5xzePMBdL815B4J5AD6KKS2IC0b160alDoLGZh39chN/IPGtXlehLwrXxm5abZKQuw8lZV0oVYL3pbnI
X-Exchange-RoutingPolicyChecked:
	Zil9kPJf222E7rVnGuHqhRlwToRVLh1VeHRCTR4Bl8O5883dup3qHGIQAAO4J1hgSJ7brV5Heyu36ysVEIobOq6oKSxS0eFUD9tWU1UIhqMo6Xk/8QcLtaxRuQhPEK5y+TC36yNmgQ/TP27H7BUnLUvX8xUmOKih8jzN53xnFYKIUGU1F+JEiQNGnHUA+h0f3gjJz4DMZ94wzluIKaynbQHOjgEX0/Ig63bxcbdG9+irlM/qkBXjBCIBfm8AgKGFC1BAQgnIxLd7PE393Ib4afIr6vQNfO1JRoUwXu5/yHvJ9n/JqmX4jryGT8z3I4uCpmXGEoCYMSm7VSQk5hJgFg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 05:59:52.4857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a9e83e-c71a-406b-47f6-08df4b827d11
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR10MB614384
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMiBTYWx0ZWRfX+miq8rVDJuPN
 dBdpEL0poqWJWMrN8Wt74CaGTWE+8LmcKqKtFrCTMkNp2+BvEXZWaqaeIDNwgQwY+7uwT+YXkvC
 yYT3EbMR6fGFGh4L4homK8IjRLvk97Y=
X-Proofpoint-GUID: hphkDoXT9-s6ViAX3F_q0eutK7m6d177
X-Proofpoint-ORIG-GUID: hphkDoXT9-s6ViAX3F_q0eutK7m6d177
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMiBTYWx0ZWRfX7b794huegTrz
 Y0XdTH8q8/LM3KiOY6g7hDDNIKK9lZmwPMUJNXe0W6IPgWlXeMKjDXastKUtElBAZ1kv1/F2+bX
 QuLyZyrBM9A5zIG943m01A+OXZ2YDHlaRiODDUJ0wOPFu20piY15XUvjcYRV9V83XPLBUwsnsV/
 EsM1W5TEarOJeJ9rS65DUDdjlLdO+csjFZD7EergPrAGLGMBsGlxfvnnOL7eu+7j4zFVJMQ7hEA
 OOuAd3DaGgk9l+voCDL073wOahn712JK4eVuPU1GdWJGgwo3VF2Q5fC/E+0SDCQc5jc3q1ySNBR
 4Il9ud5fnkCLOsFQlPm12JNGwtbqpv+Al6ZCcQDJCAS/qJq244n7Q0fwY8nWmQNRgJDcXnb47og
 vglxG6O0qHn+k3vbmdFKiToxmkeRUzolc51Tv5lRVhJJwggff8uzXYEOGwjF9kxcKXevcNGRiWd
 MsnExBykrOXcKShJVEA==
X-Authority-Analysis: v=2.4 cv=d7JgWhjE c=1 sm=1 tr=0 ts=6b07cadb cx=c_pps
 a=5XLVA79qUcMA6Bnn+7FYtQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=dsVAeoVb478x5P5_Tl0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260022

Hi Simon,

On 11/25/26 17:41, Simon Horman wrote:
> On Sun, Nov 22, 2026 at 07:01:04PM +0000, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 19 potential
>> issue(s) to consider.
>>
>> Critical: 2 · High: 1 · Medium: 12 · Low: 4
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Critical] SR1 data RX path is out of bounds.
>> - [Critical] SR1 management-channel buffers get invalid DMA addresses.
>> - [High] On a running interface, a failed XSK enable/disable leaves the
>>    flow half torn down, and the next ndo_stop then hangs or the driver…
>> - [Medium] Multi-flow RX does not work on AM65x SR2 ('ti,am654-icssg-
>>    prueth'), which uses NAVSS UDMA rather than PKTDMA, but the driver…
>> - [Medium] SR1 management-channel teardown is incomplete compared with
>>    before the patch.
>> - [Medium] Misplaced error label in SR1 emac_ndo_open().
>> - [Medium] An AF_XDP pool bound while the interface is down silently
>>    stops working after ndo_open.
>> - [Medium] All flows share one desc_pool, and the XSK runtime refill
>>    budget comes from the pool-wide free count, which other CPUs change…
>> - [Medium] The SR1 data-flow page pool is never destroyed.
>> - [Medium] SR1 now gets an RX coalescing hrtimer but never cancels it.
>> - [Medium] prueth_xsk_pool_disable() can return an uninitialised value.
>> - [Medium] On a running interface, XSK enable/disable now reconfigures a
>>    single flow while the shared UDMA RX channel stays enabled.
>> - [Medium] Racy irq_disabled handling in prueth_destroy_rxq() and the
>>    prueth_create_rxq() error path.
>> - [Medium] RX drop and error counters can lose updates now that RX runs
>>    in several NAPIs at once.
>> - [Medium] A coalesce setting is not applied to RX flows added later.
>> - [Low] The ethtool channel range does not match what SR1 implements.
>> - [Low] In the SR1 mgm flow setup in emac_ndo_open(), the IRQ check is
>>    wrong for the signed field.
>> - [Low] Leftover field and mixed-in cleanups.
>> - [Low] net: ti: icssg: missing skb_record_rx_queue() in RX packet paths
> 
> This is quite a list of issues. And I would appreciate if you could
> respond to them as requested above. For patch 1/2, the four that look most
> likely to require a respin are:
> 
>    - [Critical] SR1 data RX path is out of bounds.
>    - [Critical] SR1 management-channel buffers get invalid DMA addresses.
>    - [High] On a running interface, a failed XSK enable/disable leaves the
>      flow half torn down, and the next ndo_stop then hangs or the driver...
>    - [Medium] Multi-flow RX does not work on AM65x SR2 ('ti,am654-icssg-
>      prueth'), which uses NAVSS UDMA rather than PKTDMA, but the driver...
> 
> Patch 2/2 likely needs attention as well, but I have not reviewed it.
> 

Yes, I am working on addressing the issues for both patches. There's 
been a gap in my upstreaming work and I've gotten a bit rusty, so I'm 
picking things back up slowly.

I am a bit confused about the bot reviews here. I receive reviews from 
two bots—sashiko-bot and netdev-bot_sashiko—and both provide a different 
set of comments. For every patch series I post, should I wait for 
reviews from both of them before posting the next version? Also, one 
expects a response while the other doesn't. Should I respond only to the 
one that asks, or to both?

Additionally, how do I ensure that any comments I skip (false positives) 
are not flagged by Sashiko again?

Thanks for the review; I will address these and respin soon.

