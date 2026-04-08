Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77353A6EE4;
	Wed,  8 Apr 2026 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637402; cv=fail; b=FUx1JNmrD+uyk/HdiAEA4z4LVM85hLyeLLKZ29io9CyTJKixYlRPilzodhjL4tF2e/37DFXYvoRofJ2VYk7eEw1dya26qSPNDNSsCw8wRY7Qh3qDJo1lOZEPXwCzbtW+Qc0D4xYd60ZThbgYaCZzdvegQwXdWqFEiCM6sDehwlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637402; c=relaxed/simple;
	bh=hBKNVr22aElDaWMsszQwhTO66VH2RmOx0i1g/zr7u0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I3zLurZPp0DI9BENQnmk6sMjeGX4jfBVEgr3f5Cy/tJrUO2/f/CmVHHEYwwm95lJBmR8OXj0jAYyT0d/8TwjHiQLl9pGjjD8IpEEeGptx5cgMggtxaZiIDgk/dAaU73nO+qrabf3RIcGArl48t4mm7i7AiQiWQtfhAQkp6Mk/KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o/rUEB5b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EQ82gSOs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o/rUEB5b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EQ82gSOs"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6382cUJ73385281;
	Wed, 8 Apr 2026 08:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0JaJHG+4K0q170D9nI9mhk5zdN3LVIlnmzmCqYZUrFQ=; b=
	o/rUEB5btEnUZKMO387VfqH81oTRAwh1lMjPnczWcw0h7GSpKZpeZrO5WrJffswZ
	1EXVCdZ444bsiLxYQvRPAXHZW77A81HgZquIQ245GQDj7+ezWGHTDEbRRt7XUB7O
	b4K4n4bQm5TIX85DuPc83W90NxFYvBPP13kZlZp5WqExbtMp4HiSbljpYeiQ1dXN
	ipZ6aTiVf8FGwyOYDLwk3cL089IGWq2Y6/nccun5cMM5loeiJx3BOmRm9J6416So
	A44Qn2vAQQfokeKK+0piaajyNRxLsABV2erKvDKXNCYMuEs94JgYQMM0q/5jqEF3
	aKCY2ODj2PrEWU8Ez9CvhQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa36bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 08:36:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6387EODt006967;
	Wed, 8 Apr 2026 08:36:26 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmejgffy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 08:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHmvRGbYXTTCWyBxLXvxcDvArFcdIgeaTYCfB4Cc0mqY2wXyxbPQuxTo4ePH/q4LKHchKrkAeJjBkxV2DCrxG517bKhboOivXMLJ328EU7kBi0nIgbfuzseJQGkAjqtkBmt+V9zWPSWbovXxHFyB7GHo5RqbUJXN7aoU9H8/dufK2aopMNSThMFHnyyNP6WEZNSFf6vjtJMDuJVMm+PirYNxqJDsWanW/JftlhZf66/Xz+mlNrttNC3FuJcBITNt62XXlJFN65lmFLdA38cKVsukiRwc3fjv3j/Z6o79YbPGZ2Vq4QFhuknRO4wqLiN5AKl84zLMLobyMjOXibV56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JaJHG+4K0q170D9nI9mhk5zdN3LVIlnmzmCqYZUrFQ=;
 b=lj7kxp1pIu1V+LPePlHx+FUQLtG+G8G27Z1kEPe3/HNZmItuy/r0Yr3/PXOFIy+e9QlaZgSaJSDebTkd1E2QnUcU7hXgXcp4BrQhVGGLHRwN5le5nfHa2QeZZnzEFgpazf8Gal0Vkg27wpsGzuQ4owgzN6//8rM19CjJIAbuOYA9iKsa/zn/H/PodEU8CLjn3M3ho5OAamtl216dd/tea4ZV7fXfEl+Gxv1vaAUjt/H0Ehy0RfXK5gfPicaX6nSZ6mMTfpCQI26D2B2qSmFLxfLS0ZIYz2pcH8T9lQSO0sbwJnuiLThiePV5TqNzL45+GJN6Rr0f3LObY5HTuFdk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JaJHG+4K0q170D9nI9mhk5zdN3LVIlnmzmCqYZUrFQ=;
 b=EQ82gSOsnYS4K8kNitDMRoQNL2wlFrLjRjFE/49p1yY4swk+WMitNrCP3TpEGtFsOpmf+yPRZgylIswjH60ecbEtV+uOD7mPSjD2Sm44EKTXB35xAd4TmFHhaQGAxR3OYJqUnz1HRSLjUg24b0Okysv+eIGAQMqu3EyOZp4B/S0=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 08:36:23 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 08:36:23 +0000
Message-ID: <a4048e68-35fb-4c6e-a92e-89499c9cd460@oracle.com>
Date: Wed, 8 Apr 2026 09:36:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: bpf/selftests: test_access_variable_array breaks due to
 sched_domain::span removal
To: Peter Zijlstra <peterz@infradead.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
        Abhishek Dubey
 <adubey@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
References: <3e129be5-d61e-4bc4-b691-8d69e2f58de6@linux.ibm.com>
 <CAADnVQ+wZgucXKf5ZFNeSMcgARQVsQ7knVctf5R2GOGDRSEagA@mail.gmail.com>
 <adXe4gNBihTOyIjQ@linux.ibm.com>
 <20260408075620.GJ3738010@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260408075620.GJ3738010@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 558cb4c0-01a4-47e6-2573-08de9549ea43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nB/CRkw9ssqDLJNgeJ0IGZ5xGvG7nTAabZY0ygdAkLvJQ0PNUmPLhqwGkjf4lQPHoCgI+HrS2ynlVz+zdKY0jgKBVowupE1h77D1/ZgqZOlYXgkDM5W1fOdy32j3P4+AF9NrgVLiqp1ll514S/5Hin9YmbhHg6mvbOzyfN3N492aRkyyZshB1LzdL/UbKxKRYEK+wfPcUP00y4+TDjNW7twEra35cL+HOnIemjpTnE3h/u17bb5ww8LLJvuPuNhDIr8mi/+G24jGXqblk1WQ0YeYnMbHaYty1zoqtQYaayonD63Pu341agLPkaXnA2oi4MSKr7C8Hi/u2HDlovgUflKP96VZ0p0c0LnydD7TGVXEO+H0z1JChJ6uAyEm57fPcPpRe3QQE2aWjVrFrBA46QOL0xY3SGXjpQ2ruSgXgpJi/khUvpmSuIAXKZlLQKtVvl/8zKquRL2dT6zGw9nOzqxiyv60sJ+h/fIu5E6lS3wT1t5HSUe0W1GZmFnph2hSZCrVBvzPsmKyYWXNnnztZVtoc8nskCoWZuSvDK/+U6FgOCyTL8RAdtuvapbVLC2RDvrAYwVsQ7+Vvudc8zm0TCJ86soKZnYpGMutV+Lzb/0AN/3KiFVIsFsUTJtbheiuxe0mXdHXsNDfijraTfVQ12n/2M0nNCZ7HV6tQurx+sHykX0r6Zw/Isws+qqMkHyWzy2d9eew7erqtVDWSyRa+MymSYS/FRn8diosAYaEyb0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU9XcUh2dVFURzlLK2V4MzdQK0k3N1dIZ0hpZ0lERC9SYlNoY0Fha1VVL25X?=
 =?utf-8?B?amEzSVFLWHY0WklwRUxhUGQ5Z0JjdEdFeEZzZ2lFWDZUeFJnOWlzakNGWWty?=
 =?utf-8?B?REFOL0ZJb2hPL2QxS3lwYTFodEU1bHZ1bUNPVUVKN2pRVHROcGVIdFFUOEZS?=
 =?utf-8?B?T0Evc3RzK0gweHk1ZlppRno2LzA3d1Rjbk1DWGRPUyt3OW5ZUXU3K0RwSGd2?=
 =?utf-8?B?UnNQdTV4REpDcEsxUEtaeHNaS1VBL2lrbENRNGdrNEg4YmhGTDRCNDNPdFk2?=
 =?utf-8?B?Nk1YSDNqVHdsNHFkeDFrcXIyTkNKeVNDVVNjT3J1Wk9YN2pBd2lUZXNtdzJV?=
 =?utf-8?B?UTJQdjF1ditVZ0daWno1WmlxWVhTZVBoVWpoQ3ZUSEpQcWNHZkU2Q29waVNH?=
 =?utf-8?B?eDNPUmhvVVZ5bk51NThlMVczSExhd2psdHczOGlwamtEbjJXNjFOeXV6T2I2?=
 =?utf-8?B?LzJYbXkxcUtBc2VzVG5zT2hTaW1Ea3R2ZEtwVDl6b3FSVkpoNEJrYU50My9N?=
 =?utf-8?B?ZGl1OEhUU2ZqQkZFUXhvRG53OU1EZ3NrWDljTzVzcWpQODBGeU5tMUJFOFR0?=
 =?utf-8?B?TVBZYktSSTZtNkxrN1llNldUMDFFemJOZjZGdlRMS1ZOM1BUY25wK0NLSUsz?=
 =?utf-8?B?ai9yNFd2dUswZTJkRVVjS1FuMmRKUGdDdHh1SGVXU1Z3TjlPMlZBTHp6Vlkx?=
 =?utf-8?B?TEpNRGhnVjFYb2NsUW52Nm51eHZrL2llUlM1WTNjK1FlRzZsdDRqVUx1T0s2?=
 =?utf-8?B?amEwdGZucTFncGdtMVM3SnYrZHJFZGsydk1oczJxZ1MrcWRiakd2U3hBaGVq?=
 =?utf-8?B?Nk5Sa1B6U0tvS3pvRDcxa2lSWVVHUEx5VG50d2pCSUg3a0ltMGtSc0ZoVXlP?=
 =?utf-8?B?djVlRzZMMWd2YTM4czExRzhpQWhnckhQOXZUSGlpZWFXREJZOHNBWi9pZEpN?=
 =?utf-8?B?Q002Umh3MXZuSHZnSDFSOEhCQzZYS3RMbFFNYTA1NTU3dk9ScjJCR3dIOHg3?=
 =?utf-8?B?S0ZxVUh5eS9jWTByS29xT0p0TDR1YWE0bUlJNlFOdWVpV005QmVETUhSdkNx?=
 =?utf-8?B?NjFsTlpnSnViR29GdlIvUk4yLzdRR0tPUlNoOCs2b2w5OXM5SFhQTlNoTlR1?=
 =?utf-8?B?R1ZSem5UNzRHNlA3NERMK1FqRGVpS3F1WHIxb1NYZFd3dVc5eVdDUzdlYXFj?=
 =?utf-8?B?eVFqNlgxcGJZdGRiTVNSUGpiNnM1bTBkYzdqTnBabzkzRkl0dENqa09nUjNG?=
 =?utf-8?B?cjFyMzJRRTNxZ0I1dGpQU3ZkY2dCQzR3dmo5ZjRCNFpyUnhFSnBxUkJBY0lH?=
 =?utf-8?B?cDc5VUlPN0JGRUI5azk0bURZb3c1R01TaHdubTJLUnIyejdCNmQxSnkxZEdX?=
 =?utf-8?B?dG9lWkR6ZEJsSTBwaFVKL0M5b2tlbjhkeCtlc3ZxcHlJWFVzOFdueEJoclpm?=
 =?utf-8?B?UXdIKzF6S3hBSm83OU5GeVRrUnJiYVgwcFVteHk5UjVmL2sySVllcHR1WjFL?=
 =?utf-8?B?Z1dmVWlEOStKTEwzRzBBcTIvZ0hHQUpYb0NxYTVlTmdsSzRNQ2laWHU4SUpK?=
 =?utf-8?B?TnpnQXBEWi9YZGVjSW1UNlNmYkFRazNOME1IbXIzN3A5Rzg2YlVkZEZHVlEz?=
 =?utf-8?B?dzR1UzVsRTF3QXBPS2NDOFVEamg3bWtoaXBuMzBxKzZBQVVTWjBIQy8waElX?=
 =?utf-8?B?MEdHdWI4NFdwY0JMQ0hBYjdsamJCSzNqNWhPWHdJdWRBSnYxN21ONWNmWkgz?=
 =?utf-8?B?d2I2aWVGdWNWWGgrZC83Z0pZUXpBT2MvMDFrWnBoc283RjI0RTNVZnY3dWEz?=
 =?utf-8?B?RXVFQ21VUDRueGxCYnJwL2hMbFJKUFRycmVOeURCNUo0bmZNcGU4U2tqY0dN?=
 =?utf-8?B?VEI1ZGgwKzQ0NEtVN0xyblYvbC83bHNNZ1J1cnZCUTd5OHhLSWNpQ0tMcWlQ?=
 =?utf-8?B?d3VkS1B3eTYzOGdKUDhDMU1PaC9CV1E5dFpqSjJmbjQyczV6cWNzYU5uYVhS?=
 =?utf-8?B?K1JhOFJtWU9FNHpBZnRZWUdhWmduTHVjOFd4ZHREcC94ZXlkanB2eFRMMDlX?=
 =?utf-8?B?MDdjTVpsNXl3RUpaK0RDUjZGcU80aFE4Qk1KOUFKOHQxR3k3Qlg5RG5wbjFO?=
 =?utf-8?B?dVJuWUE1UXFyNnpnWEpyTGw2SSs0ckM0dWlrY0x2K2xhVGY0YXN1TTZWbk13?=
 =?utf-8?B?TnJuS1RVNlhCVmdjU0VpbkpYTThaQ1JnZ0dRWERsOWp3cWM4NmZCVk1zQi9z?=
 =?utf-8?B?VlVmZTJraXJaYmV6NWtCL2ZtU3UxTWlLRGlSaWZrTWhwWDNrQ210U1NPcUll?=
 =?utf-8?B?eFlnb2lNVVRjOGF3TXRyZzJxQ3hUcWVzWHU1dlBEb1ErbTUrK0E3UT09?=
X-Exchange-RoutingPolicyChecked:
	hSKjznCqBQHcPAQccTrHB6QdC/KUuWxE9mNa8+/S82+Jpr6xoTK35Yf92r8l/MF3bnrRPwwoEWIvXZsxco27G5TMdDnQ9iXDtDppOGIqzsRtmpkJOdMndXpw9OrL6GFgJmMwMHWlpLJSmasJqBo4Xgbk6FNHRQchEIfxKvTzzNUVQ5kSxtZIp6IndaC6x4MlK+ERzM9NrrebhvqplJEGdzYnkxlqsgoY5CEFbMnQOWqXorUtVboazTtkqN0Bo5NxSOCtRSHMl4ZYTWIZBowE0TB26Et7oxEQpHjZ0LjduOBYZilu09Dwzzf06bEjCEBBVKTkHEUpV0zgGP7r4/y0+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FjfpWDkshfBoS1puIl1bX7J03T66S2W/9Z/ExF1qqUUGCIDPK5sYNbYYAzFQk1riEimhPqHkvSb/2kKhPAofLExWvRnkKto28/yRzPpB9PwF7QwR7AHhTUKkdjOOO1kbvoAthne2GvfBZ6xJdnFmNc3+Hs7hOUWHm5HhLsjpdrYOmKBqQQOOExfxQKSLsVO2aGpwYyV1VJY5UhXsfEGGZoQr+dOvk9ZZ0fii/slmuVOEafkP4+Zi6gv8/CB6O+R/6hozcWGUUKNPnDZx+GQbMCWlYj4B6z/kdSTjEA7A1v2tOY+gh1lPstF5SQhRGAKMnjaATf+M1g4qt9k8i/BaK1ePqGM9/dz2JWzpnLcq861w3xjD4m0fbeIKMQq5hk54nHf8DnQNxdW1BcxG3qRAzwunLDkVgmpc84GbxE02wiYqwSBa05MgXlAb/HFhtUhJU7GbOaqs2aanqGs66mCxVWtuWhjekHmy0yuVOaDG267pJxud1QPyUTDxoeCNS+3/NPfnD7qxw78V+eXIUmi77BZhHlFWxs1bVH6uqmFrC52a9J0GXGxKcWC0GqlRTTEVJZA/APZkpoV75eEYyIyBM+1ySuXyGs0EnXlohxVTxDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558cb4c0-01a4-47e6-2573-08de9549ea43
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:36:23.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDTnf7OGbiB6/D6EYj2zChS9iGblfQaJI/k+FeZFYYk6fNbvCc1TgZ8viC+pukrrTQzywZ3gyC4OCIrMIxRLcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080077
X-Proofpoint-GUID: JeY8IV_qfXTMTWqC8wIslcFY5vlfcBN_
X-Proofpoint-ORIG-GUID: JeY8IV_qfXTMTWqC8wIslcFY5vlfcBN_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA3NyBTYWx0ZWRfXxo5MPKm9jQwt
 AIWJNIoN2w0s7pPM2AbhfQTdCXFOgsoXgOft/kxQQ3FRXPCOEHMApX0xVlgKATsYiLd0CTgQ0MT
 Sb+w7Dy1hHit55YU7Ug/VG1jUuVUWhLUDW/tlIvyiYNTyu00EzqRMqO3Py302bTRKTb3xOT9J/2
 3J01Ta+zZNe2ZijsUPckiuKGUlyyixWI4r1OkB3FB04hhVi/RRJz72qD4HQyyjU+yqVHHfehcS5
 SHUnN3P/8JrWKjwbJqdvXnrRdN0sw7nCIRSwQluhSWz9i/4cNdF+trWG3e7YQkmeY7De+WvDybk
 ITNiTw2o5UhQ4IeO6RPdE0ozIkjfDkLgbKMIwxfrx2Y0qjoaQ5xUD6aeO9WYrr0OWQrSfu8S9JB
 ODdGfVPfZQNEpreNfshFL1CAfTV9HajnXTc7GldJM4yAlBhxNQ8qnaY+ciwUDBsvVX87La92gQR
 JMrE3JVfvlE6cIlSkDhFP0BW26L9w1soYREq5fwg=
X-Authority-Analysis: v=2.4 cv=DLS/JSNb c=1 sm=1 tr=0 ts=69d6138b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=jVLHy76CvqKIwRIF2s0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13825

On 08/04/2026 08:56, Peter Zijlstra wrote:
> On Wed, Apr 08, 2026 at 10:21:46AM +0530, Saket Kumar Bhaskar wrote:
> 
>> We do have cpumask as [] array in sched_group:
>>
>> struct sched_group {
>> 	struct sched_group	*next;			/* Must be a circular list */
>> 	atomic_t		ref;
>>
>> 	unsigned int		group_weight;
>> 	unsigned int		cores;
>> 	struct sched_group_capacity *sgc;
>> 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
>> 	int			flags;
>>
>> 	/*
>> 	 * The CPUs this group covers.
>> 	 *
>> 	 * NOTE: this field is variable length. (Allocated dynamically
>> 	 * by attaching extra space to the end of the structure,
>> 	 * depending on how many CPUs the kernel has booted up with)
>> 	 */
>> 	unsigned long		cpumask[];
>> };
> 
> For now. But given how utterly broken flex arrays are, this thing will
> be gone the second we run into that same thing again.
> 
>> Wouldn't be good if it is used as:
>>
>> cpumask0 = sg->cpumask[0];
> 
> I'm thinking Alexei's point is that this test should not rely on random
> kernel code.
> 

looks like we already have

struct bpf_testmod_struct_arg_3 {
        int a;
        int b[];
};

and function 

int bpf_testmod_test_struct_arg_3(int a, int b, struct bpf_testmod_struct_arg_2 c);

...in selftests/bpf/test_kmods/bpf_testmod.c so we could potentially use that instead.

Alan
