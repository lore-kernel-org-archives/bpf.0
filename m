Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897B37C113;
	Mon, 30 Mar 2026 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870119; cv=fail; b=aCf/nBEGUm7SeLkZ11j9LZvaamX/zuRVxoeg26xNDkgopg1N4c5tZeZBMAJKUPWC5vyxktrGf6Qz59yL2TbUNx0fBgstqu7wRfY74w+gTGf4reWitvtr1vqLg4O0h0YmupaNIaGipKeuoKfbAHlD6Yr6IaYJZPB93mDB4uMaM24=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870119; c=relaxed/simple;
	bh=DaALN+Ra6wPkKkWMyctqufLeFNZxXInW+2cm+nS98P8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HHZjKriyrFbFmyfMnb5mB3MHgqQGLOa6bHNhPhc0NPCJ+OWGJbz3KHhwPLhf0DaqkrKc3ZBNFglQVB6jb4QKCfxfNQvTyyvHM1fbCS8nP/HSQ1gLIlSsc3Ggx+G945wnDLDUjQZNPUNTodwH8oglzrJ/+k+glqscvqXVbKi8ZHE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f9DfSpg9; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f9DfSpg9; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f9DfSpg9";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f9DfSpg9"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GLklLBZUCurHUwuEWmi8xk0ElcU81S8aVzq4muV5wHQunES14kYmWclyeYb3WDkg69QQbIK3w16w+Q5PVvJQpwyDmO+ggbxhLL1cosL6DJEGNZzCctw4CXXL07Oyuwvx6s8muew/8DlHQwaZ3TaUCUj9ac0PgIMreWE8nPEO72MPof4hI4430QQwtt79Z1WIEOQytu72SRqw5BHJZRCUk39w37BOfSfPsHpDzyo2GnOGVvZnXr/2y3kAmNPzTAybyDPb4iN89lAgR6zCaIP5GbHFknTlhvZhzsEz2+gdfgmIS24kYKenc+q7xi6EHMECgeddxIXmOqZ9VWwfKVykVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VePiXHT+bXiX2+1kXjfUmyOtdyP+0aliWn7ccyDjRbo=;
 b=v/sMpLOjZaVWzd6Z1qAM0yqcC3z8Q8J/YR+EgLnDyuOg899HlHskY+nWDUJwSrxZAPkJynlAPfCDITEe0uMZwnZYH+SbfFdOqVHK1KjHvunmO/DAxbsciaT2k9/SprY6NBKYIWAdItmC94A8CrjxKctaVbxdqiZJSxgjwW5a26wZD3XIR1vK9N8XSGJww9P46CdJGlsS5jA2Q6J6JOADFzEEncjXeCBwyty2VqyXilausBgqfNQgXMz8ZEFDT6pYme6fPcf7L+a1BtRBhkccSyofMsHnnetgOKQalIOwFy60fax6U5TXVgQ9NKxBjRtz8JiPj2cr/GLT52AQlvPBYA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VePiXHT+bXiX2+1kXjfUmyOtdyP+0aliWn7ccyDjRbo=;
 b=f9DfSpg9Oz/IbyYmVvyI0ssTshoZlFAP4vcjAhM23/z7TxwFOEVd0W4RJvWfYrmfVAUkZeeHSAlVw2F/SX8AB/L42RkAsLeFN+9H4jsAstdg81lkGX3J6ntw4jK5E3gebWJ3KoIHLXvuLi3bvq0RjrutrNSV7Cn5e0FD7S5etZs=
Received: from CWLP123CA0187.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::6)
 by DU0PR08MB9051.eurprd08.prod.outlook.com (2603:10a6:10:470::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:28:31 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:400:19c:cafe::1) by CWLP123CA0187.outlook.office365.com
 (2603:10a6:400:19c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 11:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIlpJQaqeufT4lF5hksmBwK5COYfndSYNQ8dL5TjJUgypDxnylBlN2m+04ncCl6Gdqgjmp3r87UU2ie42nf73UVPWVfsqI4FX5kehQjNUBMIO2lDPKilNM0cLOBBn65gPALgnwZIkZ3nKZN3x36SDVJDkA+jM3dEQdpyyCJaafOTshBvDTRQAA82byFOHD9MonfUfIZBM1mHA4eUGbSHCW1b/mlCMcgBNP9TrAS/D0Qe3y2cocqUzgRxt0W+Y+idU+QxdAGVoGj8jUjd2kf6THr+Hpg9Ytha9qvGRMTecD45NniAmmbPXXW7ClW18i4prj9MB5CpOJisqvE0PYu7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VePiXHT+bXiX2+1kXjfUmyOtdyP+0aliWn7ccyDjRbo=;
 b=uxeZ/DDgJUddudY0yBhtATEfYJBCcawzNW4mMW2tAtpvgVN9iZ/kPAJbvVLwSFqvYJPkkiUnAhWduXTj3hlLhcU7KCxdRrtzxq95Kkhp5uXV6WwphFoxp9mpBbl3KNEb3ubmPSEIGdFp3uVgPX0+YojMHPqcDwnO3fcllzbJEHQXY/YMDNzUMwQz6MXHiAWkTxZN6Zv/zDtcYAMrWfz+OFTmyV6S+zBkkCtTTOYpFjax665KALzc18IkxXXHcLHntydesCnybelz8AWmwEh8Oawqy2JLbbDVxr+NU5+8yz2QwZY1AC3urN+JYYybvFXajeA4ao4wu5uJEOLHVKR9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VePiXHT+bXiX2+1kXjfUmyOtdyP+0aliWn7ccyDjRbo=;
 b=f9DfSpg9Oz/IbyYmVvyI0ssTshoZlFAP4vcjAhM23/z7TxwFOEVd0W4RJvWfYrmfVAUkZeeHSAlVw2F/SX8AB/L42RkAsLeFN+9H4jsAstdg81lkGX3J6ntw4jK5E3gebWJ3KoIHLXvuLi3bvq0RjrutrNSV7Cn5e0FD7S5etZs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by VI0PR08MB11198.eurprd08.prod.outlook.com (2603:10a6:800:252::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:27:26 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%4]) with mapi id 15.20.9745.019; Mon, 30 Mar 2026
 11:27:26 +0000
Message-ID: <4c1c705e-503c-41f0-aaba-002ee5c69614@arm.com>
Date: Mon, 30 Mar 2026 12:27:24 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Vishal Moola <vishal.moola@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v4 0/3] mm: Free contiguous order-0 pages efficiently
To: Andrew Morton <akpm@linux-foundation.org>
References: <20260327125720.2270651-1-usama.anjum@arm.com>
 <20260327124249.a8de2259cf3438c5f4216894@linux-foundation.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <20260327124249.a8de2259cf3438c5f4216894@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0342.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::12) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|VI0PR08MB11198:EE_|AMS0EPF000001A8:EE_|DU0PR08MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5e2c3a-ef4e-45f4-483b-08de8e4f78a4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 jKBzTILhF8cEjz6gFJ7dYUCoBdQf7cnP7pEicyFHnpW0ITZVzNRzOtOTyLNwiP0C/KsrfG18QhnUv19xZLtorHuOcKl4j5o7EOchygHMqW/RZKVMJYU0IuJq4hNC4hJpC9zAiOb3NP+aMEUdBapZK10bigieKvuS9kcD02EeAQhimqpDDMb2o1sd5j+Fj3zlgAroQIJJzKFf88kli3mvLI4XvFSERMu/o3/N6VoSOX57PixpnJuXsJ7nWZfjaVK8lLm/hzfxbco/kp/BrN+hYBRgrgk5KxAymZ3nTLBrH5AQQIApTa1S1q+RZ3Znjq/ezvnw4Yq2TIbXDsq4nRgSl6e7M2b7IuY1v6FtMtDYqi4Ngh6qRNUM83QsxEd5HGdKQf9AW0DWmly1oTpeaZtVj4dM3U4xT9J16uKbOBgnRzMauLmzqfogHiyMF8ZtWvB8/0w8T5bdbS4XE24c73LtbMYgwcLkJXXWUD0Y4Lr1QDbzLpSsFTwT4o/jLz9KqtCFG3/fsb9xN3mdpvigJ+yUApL+MOzUsR5p2caMTzx852BfXCslTkFXFJDBleRiX7tD1I66PuNo4k3lmQM5d6tpZgS9R0U83OTS/MVTzlqOK6y/BwPI6s9H/S96cP5lvzik2PxMb8dOORorb8OOsySKdNQRIF0hRHl5EWMmsRv3vF5k3tIqWKWqPU8d3G3pJOKT
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 SV+jJHtZMNGUpYat/7L9xIny2DbGQlVaCJ1zDJfs7Zy4wPQDWeYeQx1lMmjg74FCYyvWMssgp7V4Wy3QwHuoK1+0k/n1yPJs3eWgXONO88QyCzxjMgAGwexE0fAkB2ADYXlaVWlWrKV5uiEjpb2Cv62hIWu+XREFYsLDkUx0o4WvygwoIREHWyCByhrmqa26b4c3fdEsBMudZ2RLUZ/DnrxYarGsgOrkhyQGHsr848kz8yNPd9bkM7r7zuLVB5wg/Qo5Bdc/lM2XL2Se+fjHBO4E1LpJ7UMj2p+CgD9xqwG1qEEYgXWQjJaTbZFN6F8kA8oew7ZTIUcZ490d4JvrJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11198
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2813e4d7-4b3b-4125-61f7-08de8e4f51c2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|35042699022|82310400026|7416014|1800799024|376014|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZTdd1WQKBOLBvIOfBYQ5UAhA0HXh79Pob0q630+u2d31lQkhmyW/9QZNqmI5GuBFJx3hpqddCSV5a5S8zMaeUEYzMZUfgDNAaxSRyPYMVYB3evg0u6vU4zVmCur43rip5MHRG/xcNqSHe+SU11FwFhssJd+InNatDHeK4iqg/0uMb9KUHJ/7E9ZIbPH1CF7QnvxL9P1GiVZjWRcbTB76vaXcJPSEtz+/4tMXUTOEth2Pnf/W6V0EBP7VvbWAtepY8xNhpomFb4D/bdTuVHpbsEcTr7GG4bGSl7Y4PRCjr0ki4kNTVMHCzU260FrILMpUCAHcE7kfJVl6PtIeDSjgC5PQPan+ELQ/zD3gxHYaVPuRcfPuWbRTai6lmcE4IiH8gSpfQpSXEL1lvYmYXsGrC8AzEebO0HDg76Pczt0mywv9bTQl/ejGlTAVXEXMpdQ/yesQXKXwivqhwJu1Gm0GFopOrcKn8Bb5p1d50edeE+hFN1NGU8QqN5q05W70WYS84XeGZYrQOOIMJ5AfO/geQrbJgICBsuywxinz5SqhzRF/EIs2g6tgjDNMSUMJrYqzC3u+VRSl16SZ/1mlPHniuZPOdMlScXddYpOLMk0w1j3gqgWTviIvM2PE8ZRSJ9Un44yKpCd7e5nqMYGWK2tOU1TjnHYypm4dD8eh83FaN0JgDJFV1ThHEGOVqB5QySBHC8+7iIG2wEYCwHYt3c33/g==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(35042699022)(82310400026)(7416014)(1800799024)(376014)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tw6vs8JEGCJJt0fiLumpxEekoIe5FMoNfgOVKVxR9c+QPoHI1XJRPeiFKNiQy2ZZaSiBFzasgBsii9bd8dfDzPx7N/ozHk8lZzoI+QVkWGbw53WKfIa6Uxd2oufpKCxzEOKD7i5Dq2fuUadnZF0a6zTbgpnHQ8+LeZp2gkcmAfrzWxTGPZ3CF7+NVhdCshfOSPE5jqN4Akl9tE66vCuSlpxNy70TX74RfAFVBH/MFmoGKwwAdk6urZMPBDpK5nWT3S2MMlxMTzlTK4PecFF5LxJH7wE1dIoPf31ZmFjSiu2tz+69m/chYdxTe0PuN81H69O8DqxNL5uoI/7sEsrzkn5x0QGcpRI0kr7hZDA3Bu9fbGHt3sCmOeFTihvrL+cDnjN9twsHO5sjV1oF+RgyGclKFfVrKQxXlYSXVsxes/6HDpRg8iKAG+znEgCbsDuz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:28:30.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5e2c3a-ef4e-45f4-483b-08de8e4f78a4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9051

Hi Andrew,

Thank you for reviewing.

On 27/03/2026 7:42 pm, Andrew Morton wrote:
> On Fri, 27 Mar 2026 12:57:12 +0000 Muhammad Usama Anjum <usama.anjum@arm.com> wrote:
> 
>> A recent change to vmalloc caused some performance benchmark regressions (see
>> [1]). I'm attempting to fix that (and at the same time significantly improve
>> beyond the baseline) by freeing a contiguous set of order-0 pages as a batch.
>>
>> At the same time I observed that free_contig_range() was essentially doing the
>> same thing as vfree() so I've fixed it there too. While at it, optimize the
>> __free_contig_frozen_range() as well.
>>
>> Check that the contiguous range falls in the same section. If they aren't enabled,
>> the if conditions get optimized out by the compiler as memdesc_section() returns 0.
>> See num_pages_contiguous() for more details about it.
> 
> Thanks.  I'm seeing impressive speedups for microbenchmarks.  The
> speedup in [3/3] may be a bit more real-worldy.
Yeah, we are getting natural speedup as the vmalloc() allocated higher order
page blocks and vfree() starts freeing into higher order blocks instead
of order-0 blocks.

> 
> Do you have a feeling for how much difference these changes will make
> for any real-world workload?
I've not run any real world benchmarks. Considering these benchmarks
we'll surely get speedups.

> 
> Also, AI review said things:
> 	https://sashiko.dev/#/patchset/20260327125720.2270651-1-usama.anjum@arm.com
> 
> The can_free one (at least) seems legit.  I suggest that can_free be
> made local to that for() loop - this would clear things up a bit.
Other than unrelated things in the AI's review, this is the only real
problem highlighted. I'll fix it.

Thanks,
Usama


