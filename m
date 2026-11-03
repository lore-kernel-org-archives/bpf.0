Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793713563;
	b=nwE/spQqJcdhLiAnbY8ly/Rf+fmNyWvu+oMRga7Oahh6MOmYvTu6PbUx0CApvvTRI5W2
	 k4cMMzjfqmwJ+SOeJORmxN4g/saaQHSFrf0buHAw3jhxGXlqNkvCTUXb1fZJSzZIr1YkD
	 YXk0YAO3thjD6S46ui5NJJi6yvKz6tgp8SSzsL0JeERcotfdA05srhFElxX3xLJt/8o89
	 qJDNYwxdPWqk9iE6gd2+PaLiAbFuIuI2fzF0+yQKTpMS1kkB2og6mkUCugoyReZ/m8wFC
	 IZodrvSzy3LcM246W87wLkwYWeN7tovFRwpncDNkJoRgnOrjyZctY312HUBrv61pfUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713563;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=xb3TI4BU8RSDM96PMtdbdoBHgbicVKKJIVxE607jmJw=;
	b=UwqkLE9RIEBRFdR22DpcfQ8na1cZ9Wi+VSFtodIi01PgnQqVT5pDPWZyoGQ3aZmIXfQ8
	 9TSZC+4qLZYIUTtpJtpB+35MfaEIEoO6HsgfJoUi6svj4PWQ2tJQWg8/5PRZ10h0LqMi+
	 OJHXTefkhBxehdc03+RvEwfquu1gx1iHxvKGnYteBs0NeNedfslPracNOw1aXVZVVdRAy
	 bULzUy8wT1MiuuS8iHqc7y9zwzsyd8qsHC54AeILrd2LbfLnROpnby0zzaCaBhZfp8ySO
	 EC9NgqjRIXNzThy3a6rdDb4AQDRbKsfGclWTbAoK95iGxGU0TkflRYzJwL4wflwkUpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fRpjKk6+;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=LTeYXivr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD67606A324;
	Tue,  3 Nov 2026 13:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD67606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fRpjKk6+;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=LTeYXivr
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DcEWW3942216;
	Tue, 3 Nov 2026 07:45:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=xb3TI4BU8RSDM
	96PMtdbdoBHgbicVKKJIVxE607jmJw=; b=fRpjKk6+AUrUPUH0FMlIEgamBRj5E
	ByAiZNXlIWc/jej6DIckflYCGQH3fu6Xwv1nq1e4lqpcyu6gIbbujHBgz1LvZICA
	g2ZR8VHWW09MzKbwLi64XLxphMAR+A+UBHKMiCJSNwFO+liOIxdrD5wR+pdwmXcO
	I3lPg6Iyu/yecU4Ktv2W3KZDLho8QUlW49KLwfm4ATFfFrSMdahs2S18Vw3McqWz
	79hN8aQqsMrFrXTZEh+4E5qIkzUERIG1MnbeeGuGhbNbjPSW2H2Rd928lFv8s8cN
	un8CCh4h17AKkGv3CbSap5fmDchZcQFMY2E9sct+CwzR0pqGWbfsgxBnw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hqcuq98e1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:45:26 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/7+CXKD12ZQ46sWXHv/0HzMUow4pK48Y/zg7iNG4yxxaIWhCLW8T/jT6EkiMm1I6aBc5SievKGg4w6v60jUHPA4EBuYHfHhSC0DkbkIxNmTZQvXN9m+DjS+N1lEhQxUnYP97CZYfRqfwzj8v1y/WZf/h/xfjahixhLW7c5RcpCzMJk4gjPYiahJNWzvN+izh0jTcTJYBOc1QRxE3TCjYEt1OHnPmfaN+KckOu2POvmvLZ3D2np9K+AV03MILNQAHtwy166f3T9z7iioMlZB8cKzLK6CAtTd+SMlcgtBdk84anDBAqpBLcAKcrmWO7gA7dNeKo59NvzgV5ZzkBfOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb3TI4BU8RSDM96PMtdbdoBHgbicVKKJIVxE607jmJw=;
 b=OaI8qw5aSZxPGG71JyOn3emEVKuu1pDWcRpRJTg/fr2nciRWlOo5uZrE8lWfWtVJFFhQ1M2BjclQ9BVM8pXXuTTFeuzyHZSYVxqINSdKHaz6/SqY6sqh65JgUzaNz7L0X5yfpvvcWw5ffEIBXQ3S7tVOvxdA5df9RMaGF++N6SjK9g3qPoLSCj6DWWmYu44BqKGAYutlTw5j7TjDnbUD8J5ngLEKG/RvObn/bA3l0omHjFsqFCqyGYqOhTqIf1jhTRwJCHM7cQA9pZsMMyNu6226YAd1WbqEp3/3PP+XnNyR47qLI+Dk/MD/opbrKOlNVtXkt4tpiHuNzuONF8xGFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb3TI4BU8RSDM96PMtdbdoBHgbicVKKJIVxE607jmJw=;
 b=LTeYXivrAYyNRu4omUTRr/KdkSYjGR1BZdemCjiI0tOFK64JIwHy7b+/cO1pOD6GtJ3Q6ZUaeGibv3yBztZfAxj3qeZZcslRhGobACYRcd3/ru+T4x5/IWVI3gDQMWQYl9FHZr75i+yz0J2sBs09FAs09RYG3MJ3QY/jqgl2lGk=
Received: from CH0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:610:11a::26)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:45:23 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::3e) by CH0PR03CA0347.outlook.office365.com
 (2603:10b6:610:11a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 13:45:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 13:45:22 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:45:05 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:45:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 3 Nov 2026 07:45:05 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A3Dj5ao3292267;
	Tue, 3 Nov 2026 07:45:05 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6A3Dj3a2022219;
	Tue, 3 Nov 2026 07:45:04 -0600
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
Subject: [RFC PATCH net-next 0/2] net: ti: icssg: Multi-flow RX and ethtool RX flow classification
Date: Tue, 3 Nov 2026 19:14:55 +0530
Message-ID: <20261103134501.4123194-1-m-malladi@ti.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: b9591d1c-7ff2-4ef6-b107-08df39b0b4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|1800799024|376014|3023799007|6133799003|10067099003|18002099003|261102123227099003|56012099006|921020|261026140227099003|261022105027099003|261021123027099003|261009223027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	MBh1nBkT4JZcM3kADGjZO3Ok2U2nB1pgYa3tBzJr0geBkNnWXdC12nBAouhZGMugolahCPl1u06F0OrfyMR0NKgQk4PjKfToLw924YG8zr7C0W11T1Bo1BbRRycIe2v5r/0vMw24NALdBepeHGC18ypnoSKcPHTJLdDRR5BGU41AMqizDrlf6KgVnMCA2u0NzHv7NTMvd8RwIE1vvWsbOVuZ4E+3Jku0gC4uYLhvqY0pxXT3StToxeOVrzmatV2ezW4Bj/qpMmxxHNEQPQqEuxTDurtkjC65wvMqwiphLHGtuJi0PS9voHnmGCIYGvJpx1SYZZDm81zZFanDXekooAGYLFIzv2Qu8CYKl882Bsny4QOv9aF99dao8ejk87gT9e1dRZ8W8M/B4u6zWvf4E2i0GUjJXvNwRnbbHfEdknAycXxf/ZdlW8fRechLw0tPmmgMBeYy5SWPAM+RxYChunHlSg31mE3sIlVUdSwimf3DPn/4b2osk5uOHSNwob5vgZl1f5TyTdP9RXlb5OYX8zrAXVQ9icG/ek4pDLJUCxBvggvHwPoWfF/dAojbVBNfazMuiHlWhmJE34fDDHRLE5ePVJ2XsTvjv5dpT1cnwQC2YhwAKetGfOhBah0HJbb2V/yrUbRyoonwag8y8TaFpL4stbPylu8qJSCBCqXayMxAA2DQxpONiJXpww2vW2yxO1VMLnf9ZuIoK7fZi4t0DCLQO4ijTphakol7efCB9eHc6PnGFiU/oiqTlyarjB6b
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(1800799024)(376014)(3023799007)(6133799003)(10067099003)(18002099003)(261102123227099003)(56012099006)(921020)(261026140227099003)(261022105027099003)(261021123027099003)(261009223027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2REq38T7pP7QHls/BZZXz3eiISkY/gWw3fsA1JgrLyHXgq90yE1cvtyNkWWJq5/fCdhurBKwk24ACJI7cLo6ftupVx8hBTSZ6f8DU2Hgf48YWCJ3PiwbEe2Itx8wOLeAurtdmdY5iXtpeWBJPdN0+Oxv0eJP/hbWZUsiXz1BHB2CniyY/paqFX1RaNMoi8eqfL6QMHNCTdItu8Jo3oNBq9BNJBJjLXwL3GBSzJ4ApwrTVGib3p2WgXsz5li4Zgs2ANRfhbOYfjkfJhojbf9nfLkWUGogAiCXgxS4/OVLySZfkPFOm2WeZ2sp0b5oVkfhKAZhi4oBvuH/RZMrUHDsfW2CrkMosk4i0XecG/KdHFmkCJ80/zUQA7SmUJKszoIkBINPRZ6oVwBBYAOW18YYDtZBdqfl4MeJc+rQh0PVaDKeuOTpI9xuvS0iBPHk51gf
X-Exchange-RoutingPolicyChecked:
	0ozheny1NrHxKD6sAJ5fU7avM3TYXK2hyABYDLn8tEIrYMTqFD/hB6I23KXbydtpW8IlxwwhDbOSNzj15PCX5fqX7h/rM8bN/d8LbJpKzYyp+jGTENX/0fLE4r74GYu0JUUx7lG0GDHdQksozEv/V+0n0J6FvPILxNr/zZKIgT7vD7UDUePXSCTUxEoys9+nW4+iInr6UC9vGqCwmiOEpq0vfLzLviQJLd5xx+nAllYYqQ57Fn3Ig+lx2VKgPvFgTCBOOaLp11SwHwe1Sg3jX7def+XiQkO0IXun4rLfLz960XO4HPTOL0QkrLG/rFyN2Y5paJRK4a+I+KEYKp8I9Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:45:22.1280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9591d1c-7ff2-4ef6-b107-08df39b0b4ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Authority-Analysis: v=2.4 cv=fc84WEQF c=1 sm=1 tr=0 ts=6ae9e576 cx=c_pps
 a=cvmpvQQCsZncHh92cDAFKQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=aIMHsmKe8IOObArol7sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8KxOa3Jj580jP_bQhZgPHHga9YfSvtO5
X-Proofpoint-ORIG-GUID: 8KxOa3Jj580jP_bQhZgPHHga9YfSvtO5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXyB7aCkbToJQD
 rnMM58YJyW6tpuf+ZDHz0LudKfPG0bKlyBbavMA0LMaK+Tc0Kd/AVp4PfTSiOYp5w48FO5bKz3G
 vOKkpht+WPlzMNcpHNrB6MUo4x7RKT3NR2cTys6pwQnXYXgJdKnYteAVNbQAQI3RNvv248IN1XJ
 S8BPDwtZvd5BsEJP5Wei9f/86GW6sKBYw7I1qb2rGrbW4JU0YbutJEbgdzCFBgl9c/W9fKdhWAf
 L2B+u4KmEhJZF+/tjUt/w5R2Vm46yAj0cEiPkS+sQbcLGMOKwo234BLuUHxc1tlOygQOyoybFyY
 CwcSBhwW/BfNzbcsSy82jhY9RAWWq8RboFjLqgCw4io5bLTyvn5kssRqrHu48SUjGnU4ZQMxKcf
 0WWhnhZLUlWFVF/jtWToV59zi8mmSrlhhv64UmrooO1jVT7K5rcZmtLCLHSLmbZz7ON/dj/Jp7b
 Mn0nmJYQ8PAsDezv4Kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX6/1LRd0EzJvD
 ZO2ntSFjiUSsxuXOiRC4YMMRvWNozk0cTPnyQWRzq81ZE1n9nHD+xp8vAx+4vgMc9zKIBYAB/Yo
 z3K+KC5nBbLc4jOT8GxY/tGzvwbdUWw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054

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
(PRU1/slice1) with 8 RX flows. Verified via /proc/interrupts IRQ deltas:
  ethtool -N eth2 flow-type ether proto 0x0800 action 2  â†’ flow2 +123 frames
  ethtool -N eth2 flow-type ether proto 0x0806 action 3  â†’ flow3 +26 frames
  default flow0 leakage: +2

Meghana Malladi (2):
  icssg: Add multi-flow RX support with per-flow NAPI and classification
  icssg: Add ethtool RX flow classification support

 .../net/ethernet/ti/icssg/icssg_classifier.c  | 340 +++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 359 ++++++++++--------
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  65 +++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 281 +++++++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  93 +++--
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |   4 +-
 7 files changed, 831 insertions(+), 318 deletions(-)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.43.0

