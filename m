Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7B318140;
	Wed, 25 Mar 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447935; cv=fail; b=Oy2QiNyqGcAW8fcjuHUp6I6jNec1+vTpK8eEUM/yMbBaS525woPme0fkkqLb2M0okmmo6Lf/eAn5NjiN2pWdeQ548BDmu4wgrNMxMkyS0iYW+y43IAC1wXTs3SyGd7xWg3r4zzjQ3oT3E/YofWUFS6bNkWd+0p+7mJCzmHl+py4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447935; c=relaxed/simple;
	bh=2NVYy0iQpV+7cQUqIapLPz69FbVm8Zfwrv2OpfxyBlE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A+LpzK2By6AuAsoQztquKtsBRQ7rBGKWPnRMSm0EjrGC4YePns9A9ZsYsPAP12m0kREik/IJ6ZFw7anpiM7FEbgqARLVkCECSGbXkj6/uasLVQalhsWzAaD0w9WTOSnARrlNewYjOhg526Le0O8Pcyh8NwwVTTUG8FQSXyo0bsU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qjw7QNUB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qjw7QNUB; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qjw7QNUB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qjw7QNUB"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bGzOlaNXmXuIoygiNsSPL5+WyRyUBH59ImyodMeqGxD80WuybUfw3/68ZqHRJzp+zed/jH8B1tF2Rdr8+9CfCmCOYFndEYGKiozFub6d2/RLS2FJ0Bu9kPS9uEBa9La26mxBeAO+U+laYPS9jWGq38inU2IVFRHqmYdoKDXyaO9wT/P9y63oR3b+vGa5AsrDojIRyr81QUJXw32zQMoBwYoiZuYM/8MVE8PHMz0kHp589YlI5TbhM3ZCVvcEKcEjDztBI8sxXtiFf3BXkmEfat9QFrPtERH+a7oAupCk2cM7eB0Rq2sTMWPpg6/rA5Znvz0B8vC+OGxr1sWm/RJWSA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBDVhOjifwpRiAck7PVguDC40k7zDBj2sbtoDpWgUbA=;
 b=F9/rGIYo6AF1qMft5CCBWTp2NGKhyUzGigNE/R7p1JD67y8r4J8Ns+sU4zwdIdugRIPdqfAkWwAdK81BnC0NRX3SGNZcyPzaFSvIrVFgMlwW+TAVzO+TOLqm1Tjnr1atyp7eQP/EVLw3anRBP+ahXxggqRYUv0y6o6VnGaTBVv0GmxwSUvMf09zUNdn9IO7R7ECWlPWmcN7/+PMGWR7bSNWCTDD54vGrHvZBX/Nx01KB655L7ExDS/4NJXILyCMoqqeQAWy/uUdWP+935brMCWPV0H4UViFXW83FLnUkShTOKG8S19z7j2M9yjrZWcJQzndnUDI6gUaar8Qlsp8kMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBDVhOjifwpRiAck7PVguDC40k7zDBj2sbtoDpWgUbA=;
 b=qjw7QNUBvxo5/HHkOwDmAqlgrfDwkVPm2C30kDyD5+b26AIcSjonfq3tqzWHWZh1ZKQ8iyoV0+CVZuVkP99QsN3VGiEWN/h2r1X1NcakJCo6y+0ShpED4M8SPpn1npKB+MQqOlRIwiD9pQItjXEy97+uxiiXsBDHr6RGTjYQ60k=
Received: from DB8PR04CA0007.eurprd04.prod.outlook.com (2603:10a6:10:110::17)
 by AS8PR08MB6024.eurprd08.prod.outlook.com (2603:10a6:20b:23d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 14:12:07 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::10) by DB8PR04CA0007.outlook.office365.com
 (2603:10a6:10:110::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Wed, 25 Mar 2026 14:12:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMsoIFpW0LHWMkvWZjaCEGMiyR9pd0P2URKXAGVLwaATffPmqLRONlkZvZ1MOXUMfBrb5arPq5Xj6NfiZUm4o6mdmJ1QPciZOu0Lgt/UhyAaafuS/7nUVJ3+ugm96wCdMeIOhy68u58G3RcCx1qWUUA5iyEPFwTIexYmAqf53krhdhk+7TXHwCnIFGs0Hd6fllOvjJHonvde7rcmMaGKNuMbRt3bbxcxxnwUZcfee1Qlll1jB+47/hg+3QRoLO1nzApMrvZxY+EMSzjP6CekFC6t/XYzFnBOW+b5PzrZ2Yxa3GKFNmfgCWM07teso8pgfRGdUL1nc2xk9tLJBcrNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBDVhOjifwpRiAck7PVguDC40k7zDBj2sbtoDpWgUbA=;
 b=HzPhsIkiHhwyRjAtH7P2Q+o5fnrKQQcjabwAnabqhsgcfnwE135qfSh+s72yUgJkWK+fBq+KsYfKZ+8RF4VE20tnaruh+pis2L/Vvobrm+t8VBJFiP/+hnRHm4BDrAmpD1W2khCBpn0FBaiJ3QL3ya2zLFAuVzJ/3gBUde9O1Xlhpc94i3OQvvRh29iod/K36r7gNsitBlAC3j0fBK6z8NJKM/3Lmc37RB4pCtEaQ5sFVb3/HJreY8kiWws4wJr4n7aBW2TRHYAq5Zqn29RZb+Rn+Woa+UvsZuLLkU4K53eBawWyRisZl5KatCWIK0dkk/DRUIKdLaRQStjbLvr4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBDVhOjifwpRiAck7PVguDC40k7zDBj2sbtoDpWgUbA=;
 b=qjw7QNUBvxo5/HHkOwDmAqlgrfDwkVPm2C30kDyD5+b26AIcSjonfq3tqzWHWZh1ZKQ8iyoV0+CVZuVkP99QsN3VGiEWN/h2r1X1NcakJCo6y+0ShpED4M8SPpn1npKB+MQqOlRIwiD9pQItjXEy97+uxiiXsBDHr6RGTjYQ60k=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com (2603:10a6:20b:49::10)
 by PAXPR08MB6654.eurprd08.prod.outlook.com (2603:10a6:102:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 14:11:03 +0000
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2]) by AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2%4]) with mapi id 15.20.9632.017; Wed, 25 Mar 2026
 14:11:03 +0000
Message-ID: <a5689d05-018c-4a21-aff2-c03157f592be@arm.com>
Date: Wed, 25 Mar 2026 14:11:02 +0000
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com
Subject: Re: [PATCH v3 1/3] mm/page_alloc: Optimize free_contig_range()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Ryan.Roberts@arm.com,
 david.hildenbrand@arm.com
References: <20260324133538.497616-1-usama.anjum@arm.com>
 <20260324133538.497616-2-usama.anjum@arm.com>
 <cd26436b-539d-44bf-87a6-0109eb8e26f2@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <cd26436b-539d-44bf-87a6-0109eb8e26f2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0473.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::10) To AM6PR08MB3414.eurprd08.prod.outlook.com
 (2603:10a6:20b:49::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3414:EE_|PAXPR08MB6654:EE_|DB3PEPF0000885B:EE_|AS8PR08MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c88052-f90e-4237-6d09-08de8a787f51
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 e3pSu3NrfQiyPTkZJQeNTIG1+IehDsxE5U9iGRtcI+8f4Y2blpk8n/MmlTa7aPkJyew5GUbA9d2SIaGWsseHZwXQfdhHAs2X/CuTpudRtt2QeQiFpisVIapz6CK9E2WO7yM8rdiMmW1MisJmAszMJFlJudbtDwm1oLsiLkdm1dNWzFQvDs//2aYrBH3nIL3ACo8TTHlf10uVjiCWZQgVHhjcLTuPeheIN2rmHIfem/bFqiuo5MHuelUfpScNpfjzSU3RXmlArr/YMRjCrrOjFhkOEQtcXJjqExEziBw06FQNLU5pbSh8J8zDWfzaSHHig8buUNQKFeM8OIeXtJK1UP5rW3HlvV3iohY/Dfk3zccHH7bq51PcKKfmZmmK4WmfsIsj4lyqOrJt9ZU3fwZ0iDWHMnSIIKJeiMhcwaw4SAtiNmLZwivJL7/MABQj5hYH2f6QL9oLjZoEL4/sr8SI0gpVtexEpUtorYIO/BkfPcCT2tz5PXX9fVCfJRD+5gUJrcNiiGbmtjB49ho9iOifjlWkShaO62C4Z+xSbmb7I2HPtc0scfGAC+aOS0G5q6s95hikfuZTRjqvRLLbaFK00xY3UFCsMrMMftoE0tLEa9wO2sbeGjhc9ciVrKd+O+vnWZqgMOO9WqCbkWiTBluMiElhAgu+s0t9A/ZxbtUQIBo/qmRVBUpca6aH/7SbVLNfvxU5n9sN8QE218RpSYH97EqDReWWyz2Ln22npE92+Lr3nSgvwSet0JhMjRXxvVZwLQ22RSvyi8buxMnxj7jTPw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3414.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 P1U6/pYdO3OzbPRujPQ32YApKllnIkwgQp/5r66v6lGG5J2je9P39oojftkUZVRnAb/HVVU46zQe2LhtVErd+o0hR79durrC1VWLjetU+/6/JV2U68hwcAN1tvJj38glvPAV4JKi+H/WIe81ni6cRmoA9U5DZH6QexplCRNJKjNR8LCvtUSlg/EtouNzfXqfdihN6h2mx0NxhZHYT/88NzRu52KBQFxuoyof37PU5H8MAJuIis2G//OaROazE+F4Z87PDIQFG7UMH5tjKANdJiQ3c1PIm/7jRM36YRw9P9NGb3hMekOw9Vai+9/cEyN/6W5pucFX8bUkYO5YEauxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6654
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fec1a1ed-f7b7-4d26-2ffa-08de8a785947
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|14060799003|82310400026|35042699022|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fIy+bYgaskPC5/KJYz53+LvUbEXKDNVLFrFpaNbrXAQYM6sBttdh6mWrQvo1cmJt7kXtHHb1KwTAJjUTd//cXddfIfuy2tltI6oolJO74o7hCFesHYCh4dG2xsUO1XEZCgj/RpquihJfI8cyR0c7qRl60ki7VtGyRim/e9gaJUfVRRijw/rO3DEcrpl5X8HDQAroW5QpYKE/5sZnw+h2bk+ADrmp0iPIwIkbnlPExpcA0Ccqf+qeX0/XuLrQyOYOMtdEm7WFaMxCIlO5ZauyzbDssXAxxepJEWipfCtnPqVZwkQ23yHb232Y68vqnJgRp2RDDst8b+cxCb3Cosx3n/X8+aBD9yx3RS2tovcE/3XrgGaDQ7mZAbDjfJbGGgL8Z1E3ZIGu4o+nYYfNOUao0cGT88051RzSYIroqKukigq2GzQOOs9IgphIvxigStffenag+vHXzo9z6ESZSI0llMb1/vt5PUU4RG3OGDFFCetIgbJCMQl/rcK1S7Y/TEKbPkQYaw4I7BmsEnrvUOy+d2tcCZfH3lFa0nNzEy8Qch7qOp7svtu6m1A+TKG3K93xCLppc5RrGOXI40z+3aqe6ZW2aYYocOFuQuUS3ot1cu0GgxOo+Xxkun2MAAxGtzvS0f6UsUByeVh9ryxONI4XZC1KbeqoffgQSlT2svmDpSbc+PyB8o7Wo661M8y+dSUwssNDm/aOoOIvhOVsnLzdxTzSlcRslI9DyCiUmpDwWaVnWMZVnNx3HBPvyq5dKFKBh5CIqvW8D1AxJPlg2QQ+CkslhmGJ37th/k8gyJlV3iTCSuldiqhSL3U4OT0AVOgN
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(14060799003)(82310400026)(35042699022)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oWaexPmX9Pv7Oty/dxqq9Z7Ee9uPWYAG2uEXq/KKEM/0zJbyAxzpH3nGpQEPxIerzMbu07cR2MbJdbYhE4iFUDbdPYlXiVswFFYSEIMZt4dxSzznWQYH++GV/IDWp0NbN5UchvxscFok6jcb51SUyVcU43Cr9lKgPjjQV1J3kdTigKFvr1bJQAzwwipAH4qj0nLXAilfmW0D/33owWmLWwE+wiGhzB8m8HbA8i/9dI3xtfH5JHC5tjOmyoO+sa48JpYeUIJ7UCAELWJgUzjazOIULjd45tjgRJbkYE2NSoWrIfpmw0NNUZ1/HozbqQDCoJX9LUWfN80LEeG3unhIwwPSfJBFxovKSydhLboY99WOWHb5Y7mVXzYxZyGiwL1sumFJTAXnh3mBl4I27+KA/LjgCnvF23SUXSk8lJDvRv7Gsdh3VkkQRxUNNgl/6omq
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:12:06.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c88052-f90e-4237-6d09-08de8a787f51
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6024

On 24/03/2026 8:56 pm, David Hildenbrand (Arm) wrote:
> 
>> +void __free_contig_range(unsigned long pfn, unsigned long nr_pages)
>> +{
>> +	struct page *page = pfn_to_page(pfn);
>> +	struct page *start = NULL;
>> +	unsigned long start_sec;
>> +	unsigned long i;
>> +	bool can_free;
>> +
>> +	/*
>> +	 * Chunk the range into contiguous runs of pages for which the refcount
>> +	 * went to zero and for which free_pages_prepare() succeeded. If
>> +	 * free_pages_prepare() fails we consider the page to have been freed;
>> +	 * deliberately leak it.
>> +	 *
>> +	 * Code assumes contiguous PFNs have contiguous struct pages, but not
>> +	 * vice versa. Break batches at section boundaries since pages from
>> +	 * different sections must not be coalesced into a single high-order
>> +	 * block.
> 
> The comment is not completely accurate: section boundary only applies to
> some kernel configs.
> 
> Maybe rewrite the whole paragraph into
> 
> "Contiguous PFNs might not have a contiguous "struct pages" in some
> kernel config. Therefore, check memdesc_section(), and stop batching
> once it changes, see num_pages_contiguous()."
Agreed, I'll update.

> 
>> +	 */
>> +	for (i = 0; i < nr_pages; i++, page++) {
>> +		VM_WARN_ON_ONCE(PageHead(page));
>> +		VM_WARN_ON_ONCE(PageTail(page));
>> +
>> +		can_free = put_page_testzero(page);
>> +		if (can_free && !free_pages_prepare(page, 0))
>> +			can_free = false;
>> +
>> +		if (can_free && start &&
>> +		    memdesc_section(page->flags) != start_sec) {
>> +			free_prepared_contig_range(start, page - start);
>> +			start = page;
>> +			start_sec = memdesc_section(page->flags);
>> +		} else if (!can_free && start) {
>> +			free_prepared_contig_range(start, page - start);
>> +			start = NULL;
>> +		} else if (can_free && !start) {
>> +			start = page;
>> +			start_sec = memdesc_section(page->flags);
>> +		}
>> +	}
> 
> Simplification a proposed by Zi make sense to me!
I've added it.

Thanks,
Usama

