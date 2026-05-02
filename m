Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B32AF00
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777733053; cv=fail; b=KPbAc9pYKIpRczHfldKV+7Eh7+CZqF0FiKRvi4NfGT+8FyiA76DOxfZJXVOQmJLswxBFsUvhqudv02WmXh2GSKdiBtmHA5mH2sQHsQNknTE3F/AdvznwyPeWFSZPYCtNobGxcNh6S273NWOgzWqxpbHPnS2dIwKBVNseDDuI7u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777733053; c=relaxed/simple;
	bh=GESzIjw0eJxNLewzFcf+1arOWghPjE/56K+UeFkaUUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JW8IbSXwrxWOtzvuOlIy2G759sI9lT55syAl+xEaLySmNnaAlDvpAxeRJQgymY3hEKG/9U1S4LCYUImYIqHhYlDByg/ZTDJIbFhvG9tDU4c0osDxX8ObsMWY3T60BSsB1b1EQy1ZSAugRxYn9Am3FQGzJ8tMhcwtjBfNdIbUNB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LkACUXJb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CMawNO0s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LkACUXJb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CMawNO0s"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 642DwDKh1415826;
	Sat, 2 May 2026 14:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5F69PJj875U6sJBfvnKFRcyYaND/1dJscMlORXHdxpo=; b=
	LkACUXJbATNvs0SgCX68rrneKGQV+RJUKasEeXCOIWchWAY0sE6bkh6JFbkpZOK/
	7ZS++2e2gficH+NmVBb7lEk8rWi00roLAjRzAYvVhHLDoemQBIah30oB7GI3dmtY
	FqpuTzfoWvs0Wdx8kA6QitsDhRH8W0ygz4GoYJ4LyvTUISnxTUXkYgKWGKRlkWwt
	DxfrufisLz/hA2peKSskfBQxzpjxVasCpORapZqTRSPSY2Uy7/PkoHwsi50B1Vt7
	Vxf4zFg72FOEWGgdKaVYvnwCpTcf+mbAjpUvuK2Pcc2CypGRjSJgVVZzeZYw4le9
	CQ7vxYOCLOwHG89gCmVlLA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9eprceb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 May 2026 14:43:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 642Eh6CL013538;
	Sat, 2 May 2026 14:43:52 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dw7q6nqmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 May 2026 14:43:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJejKafu5t42pQBiyLBLwllykXZXEL7zxX6nRDoLPQiOO6WSs9PGZ8zVP5EhWyVCO/YPMiepoIj8jqRm3MirD3RO2fabKjj93aHqH8GhnnMnJVoIt+JBMXFgmgEPWA3YS8c3kk7R7yhDJ8s+oTFo97sPUdTMSs0dc36pU1uENn4F0ZvFfQJRNrwH7ViSEq807rB/rwKPcEzVyT23Qu1+4IjArmbMHqCnTdzyhc5anS0Q2wNBvSILjkLCI5Xtm078TCGrrLRdz6XTW2TnipIKt3pHH4HHWiY12reefji7g1q51Mr2GmpG5Ah1kk9do6R1Gr+LPUCxKd83cFO6AbL5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F69PJj875U6sJBfvnKFRcyYaND/1dJscMlORXHdxpo=;
 b=mX6Mzehcat/dtUYoSB+ZAAYVlTEjwnldbkaJmusbOy5GvRGekJfSwsqmNPW+KRmO5Gr1JdV0E3Qm3UKa3zTBGLwOtq9vzzCUaQcT8bMkzdy/vsXqNIe+Cfb86vc4dNYe9pC0Okqa9r/WlE04WKuBH2Osu6H0M2e8P17umQm8lgHk3hDfPO8cLZMSh9NuGVqIUu7jqN2WqK7/65XOlK8k9p5SbkQXE1J5POFw+5UenEzH6NkJuwG6TpzNTVUppwARpxnxtvPhZ2LIpfCQMrJGbRIutv6oFBsexhNZHwk+A9aEz6ZGYiHyXrEBhIdo9ms0S37wbrMTkGcesJ/8hmn1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F69PJj875U6sJBfvnKFRcyYaND/1dJscMlORXHdxpo=;
 b=CMawNO0sogZcUgL1MnDew2cHSge00xqDLdSJ3hylzFYB9Yq2gnMunwiHshyRoFuMJUsnA4462U+Nt0YYivY/FsxpCrfbnhps43UWYmaBi5o9be/P1a/r5OsOVh3egLZE5JErlu7Fc53ps+Fc2O0ZzB82sZ9cnToM52YZS4HsKf0=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA6PR10MB997657.namprd10.prod.outlook.com (2603:10b6:208:5df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 14:43:50 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 14:43:50 +0000
Message-ID: <2ea5449d-70f8-4e7b-a7d9-d3cbcfdda5b7@oracle.com>
Date: Sat, 2 May 2026 15:43:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] tools/headers: Regenerate stddef.h to fix BPF
 selftests
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <8da8ef16055aa452d940668ed5359ce54adc6b0b.1777715500.git.paul.chaignon@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <8da8ef16055aa452d940668ed5359ce54adc6b0b.1777715500.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA6PR10MB997657:EE_
X-MS-Office365-Filtering-Correlation-Id: 0746ad17-cdae-470a-fab0-08dea859393a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fHibCmo/1P8CigUBfbfgEFxg38fkQOjcFhPMONAckjYUM+iF3y6eqm8kvG0wkOBc6TeCHv2hkF3OIh9ZPkPegmKZOy1RXSahDYiCC26uX5qJuqurwH6xPAQ3VafY5nN2g/V+mUJKLvzXYbQylEgf6gVFNHzk74ZYwoOIfLnFoUShR6pN8BJ2cT3vqrnnxHIxz/9pvp3vfwsvX6SYymex9ronj9PEZZVH+kz3bOP13DdJV1H0bg9EhhAlyPekgoL+L18RrOcqQUdqVuQ0cf3bFfajHdBDgeHEQIpa1E0SDilGbsl2/nKoS5A0pwDpjZc8VPtGP24zjOUE8IhCDY6XrwD3Z+UgRKesX9cA9VmGv/bedN/GhIl9kSxocUDyUxyPGhO4Bu3u6q64gdgLOCq321q9fRLXecmRf365vB+MMgc5KgmwtDKVJdx+5LfKNgdPpYKsQqEXG/wKtA/PsORxs5NZOUJu/24EJQESZ/8sW+wePE6s79sFf6LGAI7czG3IcrIwxlmx+QI7NrYFZfj3NqUjpO3skLMJdlnRlu/wVNyMuxM/YrK4PlKwlJ/SM+fVjSs6BFL0O2inJuyyNHQ97cVAiSjvsrDUM5lb6t0NCtarstI0ONKqbHC61lZsqnUE4qpgEz0asaruTNA0thSWCa2xBKcQnBV4ErPum0D5/3Xl9o5LDJQV06PjIs5UhjY7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRVRksvbDd0emN4dWkvSlZwYklKamJYMjhVWUpuVWZ2bTRtSHZoWUxYY2ox?=
 =?utf-8?B?S29RMnNka0d3V1Q3TUQzbTFqcFJZTHpUclZuTEs0ckUvcElzSFNObDBvMkp0?=
 =?utf-8?B?WTVVeVlTb2xZa0s2NDhJYVlJUDAraVR6MzBqUjhrOGxpV29QTWIzUXgwc0RT?=
 =?utf-8?B?RGRKQ3BUdFhJMkpZTVh0VWRmQ2lpUGxpTStkYUg4MUk2SzZCZnhrOGJFVmg1?=
 =?utf-8?B?ejV5WWllcUhWU2lJSU9iVVJtMG5GOWN3aGNSdVRlWFMzU2kzK0s4cHAvcGUr?=
 =?utf-8?B?NERuKys5L2lXc0EyYnkxWVZnYzh6RnpIbzZpUUlvNnV0c2xDVUl6K1JsRzd4?=
 =?utf-8?B?LzlzN1loMExXcW8vLytERkw1dkxZN3Q5TWVhY2FJdGZKTElZU3NkOUlSNTEr?=
 =?utf-8?B?RkMveGNxSDVFMHl5djAwRGFXTElzNHJGQmJhTlZPYm9GbjZuZGVVYmNHOG4w?=
 =?utf-8?B?QzFML2ZGQmZaZ1B0MVZ5NVgrZkVtWUEyL09kYmMvbHRrdUdDQ2FUS3daMTN3?=
 =?utf-8?B?UWhQdVhQRCt4NmZPMW1XaUErcUp1MlNxK2VwOHVmMnZtazBxY1IrTk93T1Fl?=
 =?utf-8?B?NGg0cU5MWUd1WG1YbGhkcjZjQTVoMWozcmNzQ3V2RnQ4bDUyK1EyUWM4NzAw?=
 =?utf-8?B?SStyTlRZV3pwbTM5cDg0WDAvYmJjbUx5bFpoUEdnNGpoZUh6Sko2WkJRWjNQ?=
 =?utf-8?B?QXNVODJYWUNERVc1WStOTlZpayt3WDdtMkF3clBXUCtZeHdWMDdjUXpUZndB?=
 =?utf-8?B?OXV3dzRPR2VMcGhkNUI3YW40ZjJBUVFYUnN3M0NtVVJISXY2MXJKS2FpN2R2?=
 =?utf-8?B?Nk04aXZYUWlIVzhiUHBmOTdlb243VjlvOWQwcjBRTTN4YWYwMmM5bHg3amND?=
 =?utf-8?B?em5raVFlcGxpSFVWYjF0bHh4SENvZjRBblhoZmtzYy9IYTBJWENOL05vcnVO?=
 =?utf-8?B?c21ZUnJ6QUJIakY3WXdzNEZhTWllMFFDQ1F5SGJkbnBXK05HdkswTVpYbmFU?=
 =?utf-8?B?Y2hTWis3TG5TcDJ0aEh0KzYyVmVHWVNWSFo1UkMrTnl1VTE4ZVVxd2paMnBQ?=
 =?utf-8?B?b2FjUUprVFlHWGNNaEk2eStjVG1FNld1Y09ad2doalBWem5Cdkdoam4yWm5B?=
 =?utf-8?B?c0dGVjlDU1pYWnFKTnRGNXI1SXZHYjkvb2g3QWhQdjN1MlQzL2VubDlZQjRp?=
 =?utf-8?B?WllndEwvaERFMHdldU45Z0FaUllFYnZSS1IrVHlhYUxXdHJDVFpRcENuWHV3?=
 =?utf-8?B?Z0ZoM1F2bFV6Z3lPV2NBUXJ3ZllONDJWS213cGZaZWxRSVZQS0NRYndjSHRM?=
 =?utf-8?B?UE1PS2oxUzgzOGl0QTU3cnZ0YXg1TkF0VUU4N2gweTRqRWVMMEJKaFhVSWlZ?=
 =?utf-8?B?Mkg4MnJlcjMxVGFnSXBUQXhqbG1OemZyWm05UkFiSFlOU1d6aUJCM0hNdFJG?=
 =?utf-8?B?MWpoZFF5WGdqZjVVY09pZGJ5cjd4eGNlOVZrZFpxYnoxQWZrTFJkejVMcWJz?=
 =?utf-8?B?V2lzYlVKYm9WZExDaXpqT043Q0tqQ3ZUeVNSeUZyRWVjcXRqWHlxbGVHSXVY?=
 =?utf-8?B?K1Rla3diMUJRbDg2UkM2cGUwRUVNWGNWbkNPbjRHNHNPUEhPWGtjb2tTcE9I?=
 =?utf-8?B?YndLQWRDUXp6ekNzektMSFJSVlF2YXBmRVhwK2pwM3VwSjBqNDl5M21qV3lr?=
 =?utf-8?B?YVZqclg2Uy9GTXpLSXpmdnFJdjFYdWhNUmVkU3RWNWg0YVVlOEZIYVVZR0NG?=
 =?utf-8?B?UW9QOVlNTEFzZEJ1QlhMUklrWU9rVUcwRDFnVUtwWlFrK2lqby9WbHJxNnUz?=
 =?utf-8?B?d2RGaWU2SWhydFZNR05rWFVOSFdxeWdXVDhoWkxNbW1BNGlyZi9qL3ZBMXhn?=
 =?utf-8?B?V1R6Q3Q5bFpHRVFRempkWTV1WENlYzVhQ2VnWG5EQ1A4K21HNm9JTDgvY0lR?=
 =?utf-8?B?bGoraGRnTjR0YXRnZkZxOG4rc1JReWp6WUNweThLeUJva0ZMdXhjeVdxNDJV?=
 =?utf-8?B?L3JGb0hCbkFnSndld0xRbXB0ei9memRjeW5ialNMYVBQbmVPWmRDMWt1Mng5?=
 =?utf-8?B?KzREelpoMHFiTHl6WjFNbXF2Z0F2Nk9yOXI5MjVRb09uMW02d0F1K2VVdWl6?=
 =?utf-8?B?UVZzZjNIUVVidUF5TGoyaGlselY4TVE5NHZBYlZoUWpsUEZMd0pUK1hvUVhX?=
 =?utf-8?B?UU8xb3E5a3ZONFNnL2sxZUo3Qmc1TG9pWVB6YTFyZHZKK2lvVnhFMWg3YXRV?=
 =?utf-8?B?bkpYRnhDbEZjS3ArYVVaMC9zcDRGcm9Vd252UTRIcW9qSG05bHduOUNhRVpR?=
 =?utf-8?B?Z2pTNFZBZmkzUXBJTHZaQkZYTDVOOGJibDdNZTltL3RVclRLbWljQT09?=
X-Exchange-RoutingPolicyChecked:
	Z64eO4oCiZ/bK9epihTfly03SfMyhTDwkY8Enl+G25uwERRgV6aHqp5coZcXOCctHlg2ClHyKTKHS7knu9weHyy6LO3N8dNH3I/7EV36yQOaqjB8rmkPOl0cnpJdHtL1TM6CCRUEUsrvtbZL/IiTwNNBKsrzsw//VBrY7CmO7hoFEmBFvgrfE8QiV5L/8Da8PU8SLRDIDoS1108XpAgASkNci5mxtmjUiSEfXvGDW9fYmnkX/52ZbTQ6gNK2e7D753NNICYw02dhFZvol1KXBe0xg94/dkjYd3comljUDePbUqlIshB0NFUoF6l9JuS1zTSUAyM5p16bU+xIQlnUEA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/vXwrRnCiRyIZyk+PceTHd0ymjSdPxh1wvBQZTe5ymJea40mhIQllyRxpGPiFFVKQRNhJen1yKKfeRPgWisPBNg/CWlPW+61Ww5l2UHfzQHLkX2Mwd+StiPsBC243ax1TCOyuW3HD/lVuxz/XVtEVcO1Y/Ijg6xIDFZyrQPxOrpJyVpkibaWxsDEXKVtZnkkkbnxov+2qOge46kbyXtLeNnDGiPjK7spLEhPN76uag4XWu6PZcBhR1/xo/q5gnEjUDMv23cCf4Ab1VnXsshYNmEiHu4K3T9pN57cbVhwUOa3OvsCO35b2JXTTADR+bClEqEYp6A/rZp4eiXQjFH4FDUIEOTBtOt/j4LOPwinhbE9ducpWIf01UINEoRZOTBimuuVix6WeBKEctNREYSX0iJHgAQTOOJqBTp2PyZS1ZDVKJOlcHgC0ctw7RfJoIzfuOOTVSJ/TBS7aOz4Hs7RdP9DXs2xdTgTazkrwMT36j66aN52MFgzmlgc4j3IbZpV8rJeu5SQmyZlxYNsaPXr9yE601IKxChI1tNyZD1ewnbKpHL/QRlb3XJ0RXfl16y9u4+NlY4qsET/I//VQ1HVXe+Iabf6zR4kNz2wBRWATEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0746ad17-cdae-470a-fab0-08dea859393a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 14:43:50.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPPUkQVoP0DlK8QtWnhxwXjYiZ/v0g8KOg8Rd4SGqfR2suDs7asbvT5YtN3Lw4rGMGJ2uJynieC1O2Mo2BbNXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605020147
X-Proofpoint-ORIG-GUID: SCqYefRzU6SSvtFfiZfJakcVxPjiOCOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDE0NyBTYWx0ZWRfX0PAvjXR6NoVf
 QpZlw3vmLOKJ7peaa+L4oViDSd/614x3Tif+Sg/O1fXb2nScIAe99BcrmQHq+doiPtZC5cPcsO0
 RSEg6+j//R1BQYdVh+5kXVMDE7iP5T1Mx+5XHX+DKjP0rZpIGL9viCSi5+5hlQbuUURbMjXFN1f
 ub5fUxkudKKWUYYxuG08NZs3RqKqZFjuJxvbEfrWgAt6yUUFvAtrLHtVLyQwMJjjm/TVs+3uGaa
 yPs4AYhbNoBvowba6iKs9jEL5STs42cuYCFyjtAkSK/0wxA0McjlYTp3Tb4ZebslFVA1Ztg257e
 ECtEX8lEC7rZ4Y1KeJud6oHwSRwTvgNy5ue/lADX+X94NitBLDLiEpEH+2INZ5Hw9TRkwbqbztp
 gd/nU1Dqh5wqhA9y/W7FKMLRRWjc66lVn5f7jkZTTdlvvCVW8/ztFO7UYzhNynJtdj4LJP8c4tQ
 juv9g2aiXKdz0Jh4BT1SLLI5Qfk/fUCGVdrNvSnk=
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=69f60da9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=_BMuhA2eDXCuXlRSM7kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13840
X-Proofpoint-GUID: SCqYefRzU6SSvtFfiZfJakcVxPjiOCOF

On 02/05/2026 11:12, Paul Chaignon wrote:
> With commit dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv
> with __counted_by"), two selftests, test_tag and crypto_sanity, now
> indirectly rely on the __counted_by macro. On systems with commit
> dacbfc167808 in the installed UAPI headers, the selftests build fails
> with:
> 
>   In file included from tools/testing/selftests/bpf/prog_tests/crypto_sanity.c:7:
>   /usr/include/linux/if_alg.h:45:22: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘__counted_by’
>      45 |         __u8    iv[] __counted_by(ivlen);
>         |                      ^~~~~~~~~~~~
> 
> This patch fixes it by regenerating stddef.h in tools/include using the
> instructions from commit a778f5d46b62 ("tools/headers: Pull in stddef.h
> to uapi to fix BPF selftests build in CI").
> 
> Fixes: dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv with __counted_by")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Thanks for the fix!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> I'm a bit unsure if this should go to bpf or bpf-next, but it currently
> applies cleanly to both.
> 
>  tools/include/uapi/linux/stddef.h | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
> index c53cde425406..457498259494 100644
> --- a/tools/include/uapi/linux/stddef.h
> +++ b/tools/include/uapi/linux/stddef.h
> @@ -3,7 +3,6 @@
>  #define _LINUX_STDDEF_H
>  
>  
> -
>  #ifndef __always_inline
>  #define __always_inline __inline__
>  #endif
> @@ -36,6 +35,11 @@
>  		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
>  	} ATTRS
>  
> +#ifdef __cplusplus
> +/* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
> +#define __DECLARE_FLEX_ARRAY(T, member)	\
> +	T member[0]
> +#else
>  /**
>   * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
>   *
> @@ -52,3 +56,23 @@
>  		TYPE NAME[]; \
>  	}
>  #endif
> +
> +#ifndef __counted_by
> +#define __counted_by(m)
> +#endif
> +
> +#ifndef __counted_by_le
> +#define __counted_by_le(m)
> +#endif
> +
> +#ifndef __counted_by_be
> +#define __counted_by_be(m)
> +#endif
> +
> +#ifndef __counted_by_ptr
> +#define __counted_by_ptr(m)
> +#endif
> +
> +#define __kernel_nonstring
> +
> +#endif /* _LINUX_STDDEF_H */

