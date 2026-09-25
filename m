Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A54BD378
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348409; cv=fail; b=DVULKiCYOMG/OxN9+IBMmWmT93i+uE4LkWNDrf1xAEkmz8QV0gmJvDtNlo6y+Jz37nVFJKJO1RX0RYwxn3EQLjw5FcZ9Qjw/rbXg+DT+09npfOjCHm0zX+nr+WXlk6Fr/eXdgGhdd5Msbu6RB1qqBoV7SfY9q5DmKaAu6kitb7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348409; c=relaxed/simple;
	bh=V+J7VNjkdu9O/O6y+MHYfJUkyAo876J9YcwWTRS0r9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hQpjzcjv/wshqJgIDAwm2QZyYlOQE//5ZISPR/op7eRCVU7Si8MZqP0g2ihhZof8ddq/d2BqTexdAoXG2IX05AEZZMNUX4/3WKJmZt+OjXcxWnoMKsNnzv+Wy7KZ6BE3Sh+hzWa8wPFTYKn4mgkip+1arDrwT4Ra/n7+yCKRq+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EN7fBfYk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DOC70cVH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EN7fBfYk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DOC70cVH"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PECMYL2933095;
	Fri, 25 Sep 2026 14:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fq6TyaO48G+3NT+AEWl0RWPhO6qW+CqIclLIAx0aFxg=; b=
	EN7fBfYkmYaiKToHAviOK8y7rJrSHhgC+I2Wa+m8jVNDTAZWa8hE60RABO4scqxt
	cZaenigvtkbvta02SaFGy/e30wcZC1FwTcBheCTpkklTdFrTUbD3sd6g96cX4v6w
	GBP6ZvqHWDeMixjQNgsLQDVK+hkC1ZQMRMEQ0e7vGbCgbRP+SeHyW9Ef9pv8Ixwz
	Vgu2iBlFZaVHUbQ8s4PjBpPfehiYsUPLWmv7dkZpZ7V1CWNLtPpEKiUag/hVYo7R
	DKMvAPwecS4NDmth7/tGhqwDDmgFGwmOOg6Dx+Zdb2XQZedI1u0pwPTk5AZvUXC8
	t3wVa8St9WT4cLZPsss9sA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk219g73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 14:58:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PEoRgB020056;
	Fri, 25 Sep 2026 14:58:54 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf12qcra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Sep 2026 14:58:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV83HZlwAj36ssLknXZfQ60Wc99iBWDmhVhM1ZLQl72RHFJURxsgx8F7K2E0B/WliyIiZQ2Gbe1cfBeup7WTgh4ax759BcRDsyVPwI3jEXxShBi6iWNiCeaIiVBCpuuPIPn7HqpxdLJuW/vt9Fmi8veDvwA65RFdZC+02eDe5rxJKLajMSnDMtEnq6NaDoIXSHuOEQm2Kt/V0pQscKE11DTYl0tryxMcssZnTFqasHrk3wKPRZv41bcZrgKmm/899kPMuZ/kxkZjLf6zdOWHtCi6veiktoxsSW1lGOpfe3vRbxqHgXoXmgnQJu9Aw7h6NM1rvqf1HGtYccATbz0Qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq6TyaO48G+3NT+AEWl0RWPhO6qW+CqIclLIAx0aFxg=;
 b=W9rLDZfEt4g8olm1LbJ7pr1emYMyB70yS+sF3/da/05WtsDEIklC5ocLo246D7ZM+bXcMXq5eKsYm0WL5dyPR9aQarlM5Vq+1FOcEbOzfkhm2tFj8MbUh/qbTRZKKlqbq/mg8axkEE6fc1WPj9gj40Zchggs7QGHwNPAvxvE1O0bRFfu4ntBxMIqmUfBMtq/Gba8bAW5JbufTbZGu/EAL66jo49BlQwaTLmDS9fS38+SOoAsL5g95qLuflcn77H1dxYvg+z66kMrw8CKtJ8VMaqsHOUI+1sDzkttE87ZpH+AADEdSPbLTJLZGVHcmiUJOdcQS4JuD4pb5fEnF4GArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq6TyaO48G+3NT+AEWl0RWPhO6qW+CqIclLIAx0aFxg=;
 b=DOC70cVHYaKorI6edDnMwFdbGIUerCGenq5KB378Zyi2+uvGsxjdYY6nMLB05+28yW1XDK6QkOOL8b48t84QdtWwXiArLT847IKtCMbAN1zljlKZJhAUYMwuDJ3MDM1jP6WKU6dooRbuNEBpg42fTC7rjzAHAzU/WwH+1wxqLTM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:58:49 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.005; Fri, 25 Sep 2026
 14:58:49 +0000
Message-ID: <dfcd3080-1d2e-4e04-8e26-dff60638061d@oracle.com>
Date: Fri, 25 Sep 2026 15:58:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpftool: Update func representation to
 include function signature
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, andrii@kernel.org,
        eddyz87@gmail.com
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com
References: <20260925095231.879708-1-alan.maguire@oracle.com>
 <20260925095231.879708-3-alan.maguire@oracle.com>
 <7d2f7cea-1055-4ba4-a44e-14078d6d5ef6@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <7d2f7cea-1055-4ba4-a44e-14078d6d5ef6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|BLAPR10MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b01f01-451e-478f-8a0a-08df1b15815a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|3023799007|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EkE2vV/p+QbmRZWRoPUE0t+4NKYLy0MaWwSEiraUEfoRy9lvPFB99QensJ9ssIMkTcWsecps4eAzJpQ3zly8F7ooVumvWzrTsu7Kitmvz0TQA/nusspXi0ylLbtxlQ2kXnuGxakCbySlRWze03BhuWLRY7XpqsaP62T/oYco/8N740pzbCM8R6PrPTmcT/+ABtK8M/BSZOjFVr7Qi1KIfqBBCgK8PaYt4uEbwOus0CBdnDsYY/k9PW7XRMxD5n0ZNW6jaR/I8XPDVGTf13GB10BEMjUJK7+Pv+3MwjGfwbIZ88MlM93zGguG0ffFdjXIVry4ai6CFvELDFIb84L+hkTZ5BLhFLlDjQJOFb21OU8fN3MScgoIamyranQ6SZScaNPxzQ33MqYeFSUVlxq8z0aFq/PCsKu+8m3I6pgusDOTuLASRohCWrfB4ONn7WTMEBFw2cgtiZkBrVTSzkc+EVMm8qqOUBwymaKt8XwGfnFFA01PgRBCLImkc8KxJGNJigOihzL/tw4SgAwp3pRMfvqelwantMltcqT0rhexdWwxPffuijXFUwKrFiWd1qy0S1GyfOMz60GlJYtrRLDafi5VuO8An82e+c5IP6PMZCJn9HFCFUOvdOdSxa7NZlGOWv8epp6NGLLdriu+juRdD8Jvq0usYxQJ+puvdEXEXXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGJXUG1YRlBlVVAxNi93bTcwVm43QjVIcE8yNjVHa0tMeEMzd09rUUJ3eHps?=
 =?utf-8?B?N3pBVk16L0x4RHZ6NjdVSWNpK3pndUpjM3pndlcrUHZFd2l6aFlHUkhiUFRD?=
 =?utf-8?B?dmE0Q2pQTndsVWwzSzJMTEtoM1M4anNEcFJITm9XVXEwSFh6UytDNTljUFVj?=
 =?utf-8?B?YkJKcFBENzRaamRSY0x5aXlObGJGd0psTGFzNTdzd3ZORDZiSVloUVFzWkgr?=
 =?utf-8?B?OXFKeldpTlY2VEdXTTB1TU1tcll4QlBMWFRCTmlSYUM2aU5mYTBWSHF0bG16?=
 =?utf-8?B?KzZvSG9HRnZSYXlLS0Zra1NzR2hyOTl2WHRRUXVQY2JjQloxYjVwMk9pZisr?=
 =?utf-8?B?S3haVXZRNU5BUW5IdzFITlFFL203NE0rYWR5a0tLRTJpR1k5WnRTUWw1QVFL?=
 =?utf-8?B?UEJBS3F2R3lXSXdtTklFK0MwUWxuaGd4Z2dHcTlSeWRKdlFrUklSeWZMd1Nw?=
 =?utf-8?B?V25jSmRkaFZ3aXlSZU5LTXdpWmNwVCt4Y1JId3pIK1JjZzBLTHlNeE90RExX?=
 =?utf-8?B?OVNjL2R0WFhIR3lFZE4yd3lkNkRoQkZOQVVGb056Vm4rVEFGVVhuRGttcHBR?=
 =?utf-8?B?Y2ZvMmI2VFVieUxYd3pOMjVha2plSWlzZ2paQnMwVXkvOU5lVkhYRnVUT1Fi?=
 =?utf-8?B?U0Zqd1JOWjdvWXdheG9HN1N0bFdqWlVzeldLK053WUdZQWlhOEY2UlFVY096?=
 =?utf-8?B?RmdlVFlzcmhpY0RENldGcWc0dE5HdGNxd3NWdllEWUNMMjZ4MVBzYUhpdXFH?=
 =?utf-8?B?cmpoOXZ0dlBiejk0ZDk2Q3FjTEwrUG5idFhOOGRjV1JRdmhodnYwRDNySjln?=
 =?utf-8?B?ZkJqNnBWTjJyZUpldXEwdzRQSGlONStXQTBPRjk5V2lTNC9HOXAxMXVHUTdR?=
 =?utf-8?B?NzZib0JNMENoeHhKb2hVQjNqL2JiTnBaT2hhYXh3SWpLd05XcGJWVHJ2QVdS?=
 =?utf-8?B?eVN2SEFNYURrbDhybEd5QndlUWVHV0JQdmc0bWZ0TE93QVd5QWNwK29lSmpU?=
 =?utf-8?B?M3BHako0M1RBYkhvZnJWbjFOeTNzbjQ0TjBkZk1sRnltNUJ2Ukd6SVduQUl6?=
 =?utf-8?B?SzJnVEJFWlhFc1V5cHhFcEMzUEpuUDF5OVVQcitxSFpOWGRpci9lREl2WDB5?=
 =?utf-8?B?RDVFVGw4bWYxTUppWlhzeFhRMmUrM1JrV2lPaEtuVHcxbDk5cEdnb3pYbW5n?=
 =?utf-8?B?SnBNeXRlNTBqVEFvTnZoZXFZcSs3dzI2T3QwMVNCRVM3Wjl0MkFleVdrdkRJ?=
 =?utf-8?B?YkQwTDVWUmwxcG9DODhaMEJiY3RCVnlhOTAzYU5CTnV6a2wxZVNDdXhTSUly?=
 =?utf-8?B?SXJYZU9NTEJyaFNaRTd5L2R0dnFtMEJnMVErYVBydVh3RlZ0ek12WUtHeHhO?=
 =?utf-8?B?Qkh5TVFRTHZvYm5IT2djVEhpcmxreVVnS21ZSkFtTWUzcFpTWnkyWmU2YStM?=
 =?utf-8?B?bHFsdGl3emNuT1BQS21BMWpaVVJwd29ENXRDL2twRFdsemNVMjRqUytIblVi?=
 =?utf-8?B?Nll3SkhCYXYwYzJWckV0d3ZTVGlBQlJxRTNKWENPWklxdDJUWXRVbFA2NEs4?=
 =?utf-8?B?M0RQQ0RYNnowZG45cVVHQUt1WlpkNnNtYWowYmVkTjBBaVJCUFFZbmZqRXNF?=
 =?utf-8?B?MFhENGVQbWhRT1FwZ29IcXczMWlsQk1EQ2dQK3Y0VVJNUkZvR2QvTGlWc0FL?=
 =?utf-8?B?U1pjUFJtSm1XQ3RNU3N2dnRVTjc4WEN1N3N1bkRRMWM0VE9VWkxudDBJbFU1?=
 =?utf-8?B?TXpYMTFhTE00ODBzZ0xKOXB4M3I5VlZJbGFUb21GaDU5MHh1THQ2MllCYmVN?=
 =?utf-8?B?UngyTnpNQzV1L0NqNmZzL0IvM0xzclo4cTZVOWZHaW9NR25DUmRnT1h5ZVha?=
 =?utf-8?B?Szg2UGpta3pCL0QrUDhYcDdlUWJhaUtBQk9MRXdkK1QvRlRPckRtVEIwaDBl?=
 =?utf-8?B?ZTVUd1VqRnRROUt6cSs2bjN4Q0lxSFJvR05zTThVMlp0MllISmFSS1JIYVAv?=
 =?utf-8?B?TVJHN3lvR0dCN1F5S0RkSms5QSswZkVKc2ZrMUgwa1Z1VExnNGQ1c0l0aWp6?=
 =?utf-8?B?YXdKTlZ0b3paTjg3UXVZRFRCTkdxaTdOM3VnL1pmUDA5NEIxQW4vQU5NeTVx?=
 =?utf-8?B?MStZL0t5U2JnQVVQaHlrUTdMU0pWMms0djljWm84dmMyd1QxblVxNGRzYkpF?=
 =?utf-8?B?S0dRU1d6dkprSUt3OFo0U3ZCeU1oellkZDFwa01GaUtuSXVRQjJ6MWtFcndJ?=
 =?utf-8?B?YUp5WW1HR3lpMm1seXU3Q3d6ZVc3L2hMMWVCL0k1WW1lL2xuaWdFalhxb0sr?=
 =?utf-8?B?SnpGZDVneWhYNmFYNXBySmZQUUNVQzFBNVd4QUNsUURFQ0xwZnVzdz09?=
X-Exchange-RoutingPolicyChecked:
	09RjXJoHwqCbvm1zvMjd5G3xzwMO0pNKvMuFlBiWps0R8Fb6sp/ORZaLT76H3GsdQJTJF132ybZ83wHUJC6qWau2tKR8VsVGtsMLDSzklU5YUv6ZR63V0zKQtbDlG/2DdG16cwqCC/ig4jiu3z8LEa6nYMkYJ2u+L2oyyk0o2MMkNcQBMUW7VNcXDDXTVPq6bvK4FKVkzadod79jvR/428XKBt9Ji4eLa2iwz8fMC7QFWPEH6uM3oUgHCAT26YwkIAVSERKyfGTYRRUFnjpEUA7wjXorBsNxHKiC+X86q6YPHeAbSiopO0+VF5Oax3t12BRr0ZZg9qTj9IiJ2owlvQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FEdL4qlh/W/NiOiJevMJDkguOwdH+Iho0EoRrrXloaMQ53BZ7VD10ndFfg87m8RBJfSMypmlKsuj9J6xRpBCMWIEpU5mitnQl1G+mowyJtAW6+CPcnm90uFtgMB/7w+aGxjYtaWoHJ7i6Kxtf2lYJdm72O3JKvfWvCV/G4bB+zx14+liH5oRMj0zccZmeDd7NCc4Yk1j9gR+mr+CdZWVp52s5LUPJ3oFGBjs5yGhsqlz9sPaZJPECT7lAc+nTLF9E3u1mH+X7PkRNfuEqNjrrFARpD38nAncFEzzMa+UuoQIx/jS0cBiqrKF4WI1xIiMZ3tV2LlIjLy0d7qrUjz2nbYnGRNDjfPnqMXjeRmP02dlNQ/jpgf7bDdGdhpIUbB640TkfBcjqYoWtUqcpXsvWJFpEQWeyIhaRh0BQrZoSFoR92FUbdTV4VNmuxXGhU3qLN5xewMRrp5lCE8EQgy1q8wzDukFtgdXykXLjcfxsNmnmrj0U67iFPbzHIVXb6T76bZU6OOz7HM4VTzxWBgANVSMsW0L/9qE60Jpd/RM32Oxd3t5mpX5p+NYRlPb6Fwa78GK+r8C4c2HuCtUNLfJ/tgBd85Ym6/vI9vMkeKFHX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b01f01-451e-478f-8a0a-08df1b15815a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:58:49.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bzl+LpWV5L34XBExbrMg7ntg3XX4YRDbKJ1LAIBLVbPk5B/C+6B1J5TN0US5aHp11anNVRmFyl1ZPqxbDrEN2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609250059
X-Authority-Analysis: v=2.4 cv=APP6TA4N c=1 sm=1 tr=0 ts=6ab68c2f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=3rytfVO9gtRwcicEPeIA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1OSBTYWx0ZWRfXzbMYx2F0QgQr
 7c1VSznFpeuj8GnTlUIRsuhPYGApTL3Dreull6tDCsZ9bMUcnMiNivLMGCcMJCmnSvgGtN7lK7e
 EsNXI4t2jSerFx+bF7aAZ/x39iGYOuR3uxehkBhKnGAEK5T4FrkG
X-Proofpoint-ORIG-GUID: 4krNo4DIyYgI9OiIKYBnGzmrKw65Cx0S
X-Proofpoint-GUID: 4krNo4DIyYgI9OiIKYBnGzmrKw65Cx0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1OSBTYWx0ZWRfX+OM/a1SMUaxV
 YMwlE1gfLVVrkkheo4Xq6+Ym4BjDLNCulGZaXxMpVndLLc/5VPhqgeKrA1De/5Xtt9CBd3iOi+K
 QtJmtmfV9WA8tV88yGYPSDcgLoBT3uwHDeAjAPA9KfUN0RqThWpOW91yFeUxzjxhxYtdPBZ5BnL
 YT6l1MJDKtrzNLDWXsS4eF7v8u1+CnR9I3C1p+jpE2tQLsKJvCROAKgPwqbR4qnEnIXOkzgNgTi
 EKj0pieXnn2z968fkY8f/EZvlq1wkYD9tZyosfmmFFFV2F/Cw1i8tfLuAi4klik3CW0vbUsYzYg
 cgNYKuPY0Ljk2NUHDstMK2ESa4SbEmMO8Xl2mHBbuoCcmm/PIjIuMo+ZTtmGFiHbSojz2WyWzLd
 YcABrWGnBD7SgGSLKvkv+IY/O5b7/3HKCoyv3757wURl1uYaVyT2OQYjB7kUvw7P6Mr4iP7SyER
 Nv9uG7aE4khxlG40wJCeueZ9qyN39muxQF7iebSI=

On 25/09/2026 13:07, Quentin Monnet wrote:
> 2026-09-25 10:52 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
>> Augment func= output for LOCSEC entries to include a mapping from
>> function signature to where parameters are stored; for example:
>>
>> [290179] LOCSEC 'inline.text' vlen=524941
>>         func='task_pid_nr(tsk [reg0])' func_type_id=136691 loc_proto_type_id=136693 offset=2097226
>>         func='get_current()' func_type_id=136694 loc_proto_type_id=136695 offset=2097247
>>         func='arch_static_branch(key [address 0x2e275e8], branch [const 0x0])' func_type_id=136697 loc_proto_type_id=136700 offset=2097296
>>
>> Fixes: 321562c34d5b ("bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC")
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/bpf/bpftool/btf.c | 100 ++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 91 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index e29c8a84e224..6e569ace6add 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -8,6 +8,7 @@
>>  #include <fcntl.h>
>>  #include <linux/err.h>
>>  #include <stdbool.h>
>> +#include <stdarg.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>> @@ -234,8 +235,10 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>>  						(1ULL << bits) - value;
>>  			}
>>  		}
>> -		snprintf(num, sizeof(num), "0x%llx%s", (unsigned long long)value,
>> -			 p->flags & BTF_LOC_PARAM_ADDR ? " (addr)" : "");
>> +		snprintf(num, sizeof(num), "%s0x%llx",
>> +			 p->flags & BTF_LOC_PARAM_ADDR ? "address " :
>> +			 p->flags & BTF_LOC_PARAM_CONST ? "const " : "",
>> +			 (unsigned long long)value);
>>  	}
>>  	if (i != vlen) {
>>  		btf_loc_param_raw_str(p, vlen, str, sz);
> 
> 
> Thanks Alan!
> 
> bpf-ci's comment about "-const 0x16" instead of "const -0x16" seems
> legit, please take a look.
>

Yep, will fix, thanks!
 
> 
>> @@ -252,6 +255,87 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>>  		 p->flags & BTF_LOC_PARAM_DEREF ? ")" : "");
>>  }
>>  
>> +static int btf_locsec_append(char *str, size_t sz, size_t *off,
>> +			      const char *fmt, ...)
>> +{
>> +	va_list args;
>> +	int ret;
>> +
>> +	if (!sz || *off >= sz - 1)
>> +		return -ENOSPC;
>> +
>> +	va_start(args, fmt);
>> +	ret = vsnprintf(str + *off, sz - *off, fmt, args);
> 
> 
> Nit: Do you really need vsnprintf()? It looks like you always
> concatenate, never format any number, so it's probably not the most
> efficient. I don't mind much, though.
>

Sure, I'll take a look, might require a few extra append()s but would
probably be simpler overall.
 
> 
>> +	va_end(args);
>> +	if (ret < 0 || (size_t)ret >= sz - *off) {
>> +		*off = sz - 1;
>> +		return -ENOSPC;
> 
> 
> It seems unlikely we'll hit this, but maybe warn that the string is
> truncated in that case, or replace the last characters with "..." or
> "[truncated]" or something like this??
> 

yeah we could replace last few chars with ...

> 
>> +	}
>> +	*off += ret;
>> +	return 0;
>> +}
>> +
>> +static void btf_locsec_func_str(const struct btf *btf,
>> +				const struct btf_loc *loc, char *str, size_t sz)
>> +{
>> +	const struct btf_type *func, *func_proto, *loc_proto;
>> +	const struct btf_param *params;
>> +	const __u32 *loc_params;
>> +	const char *name;
>> +	__u32 i, vlen;
>> +	size_t off = 0;
>> +
>> +	if (!sz)
>> +		return;
>> +
>> +	str[0] = '\0';
>> +	func = btf__type_by_id(btf, loc->func);
>> +	if (!func || !btf_is_func(func))
>> +		goto invalid;
>> +
>> +	name = btf_str(btf, func->name_off);
>> +	func_proto = btf__type_by_id(btf, func->type);
>> +	loc_proto = btf__type_by_id(btf, loc->loc_proto);
>> +	if (!func_proto || !btf_is_func_proto(func_proto) ||
>> +	    !loc_proto || !btf_is_loc_proto(loc_proto) ||
>> +	    btf_vlen(func_proto) != btf_vlen(loc_proto))
>> +		goto invalid;
>> +
>> +	params = (const void *)(func_proto + 1);
>> +	loc_params = btf_loc_proto_params(loc_proto);
>> +	vlen = btf_vlen(func_proto);
>> +	if (btf_locsec_append(str, sz, &off, "%s(", name))
>> +		return;
>> +	for (i = 0; i < vlen; i++) {
>> +		const struct btf_type *param_loc;
>> +		char param_str[256] = {};
>> +
>> +		if (!params[i].type) {
>> +			/* Handle varargs func proto, must be last parameter */
>> +			if (i != vlen - 1)
>> +				goto invalid;
>> +			if (btf_locsec_append(str, sz, &off, "%s...", i ? ", " : ""))
>> +				return;
>> +			break;
>> +		} else if (loc_params[i]) {
>> +			param_loc = btf__type_by_id(btf, loc_params[i]);
>> +			btf_loc_param_str(param_loc, param_str, sizeof(param_str));
>> +		} else {
>> +			snprintf(param_str, sizeof(param_str), "<unavailable>");
>> +		}
>> +
>> +		if (btf_locsec_append(str, sz, &off, "%s%s [%s]",
>> +				      i ? ", " : "", btf_str(btf, params[i].name_off),
>> +				      param_str))
>> +			return;
>> +	}
>> +	(void) btf_locsec_append(str, sz, &off, ")");
>> +	return;
>> +
>> +invalid:
>> +	snprintf(str, sz, "<invalid>");
>> +}
>> +
>>  static int dump_btf_type(const struct btf *btf, __u32 id,
>>  			 const struct btf_type *t)
>>  {
>> @@ -617,22 +701,20 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>>  		}
>>  
>>  		for (i = 0; i < vlen; i++, locs++) {
>> -			const struct btf_type *f = btf__type_by_id(btf, locs->func);
>> -			const char *name = "<invalid>";
>> +			char func_str[1024] = {};
>>  
>> -			if (f && btf_is_func(f))
>> -				name = btf_str(btf, f->name_off);
>> +			btf_locsec_func_str(btf, locs, func_str, sizeof(func_str));
>>  
>>  			if (json_output) {
>>  				jsonw_start_object(w);
>>  				jsonw_uint_field(w, "func_type_id", locs->func);
>> -				jsonw_string_field(w, "name", name);
>> +				jsonw_string_field(w, "func", func_str);
> 
> 
> Would it be worth keeping the name, too, in the JSON? So that if
> somebody wants the name only, they don't have to parse it from "func"?
>

good idea, will do.
 
> 
>>  				jsonw_uint_field(w, "loc_proto_type_id", locs->loc_proto);
>>  				jsonw_uint_field(w, "offset", locs->offset);
>>  				jsonw_end_object(w);
>>  			} else {
>> -				printf("\n\tname='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
>> -				       name, locs->func, locs->loc_proto, locs->offset);
>> +				printf("\n\tfunc='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
>> +				       func_str, locs->func, locs->loc_proto, locs->offset);
>>  			}
>>  		}
>>  		if (json_output)
> 

