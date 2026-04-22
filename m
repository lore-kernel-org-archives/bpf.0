Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0418DB01
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816963; cv=fail; b=Xc9gCR+UxNjo/kbODxlo5lTzgHfsXOZX7h0MQaBcO3xPKa7Znoi3/oqJVpgQBajHXw1ttOHeTEB+nIaQrzhTzIdDkZqlgCCZJgu+dxmyLoLEjWP71Yae5tcCnB2Xy8gc/eKtoQXGs9wDkwfXQjG6cGyw7ntbHGLUzqmx78EePf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816963; c=relaxed/simple;
	bh=jMC4Pb+OLmx0IE+10uPjOeUrpbSUIdcM06ZKLhlKVtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kfdOWYDyWkhkyzQXIjLYjkf1mcLGfDu0wfAWjBQ4DFOkV2Zf1MWP3VtrxQrsDsWkaGs+SWUBPVM3pSHzjQ/CrFLBJMEL3zoiONwOFmLe10J0HS3UI5qSXCr/yjHRU1gRCeHn5PwEVirACCtqsh9ULg5RnFcLgXL1Ui6kLDTdXqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dARrCKVT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cbmu7Y5O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dARrCKVT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cbmu7Y5O"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIanjU4136602;
	Wed, 22 Apr 2026 00:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tUqavp2oXYYp7bOYNM9bPBA9ziEpIxU63Xy3rrQp/eE=; b=
	dARrCKVTBs/6C3ScoLqpRW4vFriLG7C+KiWVQF3IKa7G7tDgGeqD0FS8oUUNLK8T
	IEiyLEH5Zt6u5b6BiLLg1MaX4UB9koQBqiS6iXjTn1P0kupGTaQ/k4CRiDUHSP2o
	HQ/KmZ/oLdo/eMu9PmGTotevDlLUaGByClSox30lQZPC2qo3+bknP4EQNO1bccRe
	AyzflpqlFHbQ/94NVC1voDNFEnU4LdV49pQtwL41aV87jkcYQ8hjGQYFnG6EewoG
	E+9JSqO+uwvsr5DxOhGCKNNHvcAa36pgFJ4GcbvGE5QyJb2V85KWYTGjVPbSCB2h
	+sLsIhJ0DBkjldb0QwTbeg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenmgdgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 00:15:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63M0BH1U032039;
	Wed, 22 Apr 2026 00:15:49 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dpjjphsmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 00:15:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcs4GxI+h+k0MaB0Ex8saoSQgxz8WDC5MG7Zw3EH2vkG/upa+8oBXcD1gRWKxuRs3EqYi3ei9xlhsY2IvtQ1+nTKLfpREjds0SaIup7TdaPn7jTTOwZLpK5c7PnMiHnM+UQYWDNQ0GqYV/MXIp6fdmq7K+jawY73ubSN3m8zT6tu2f+B9m+Cts9nIq1KINPNnYY7Crbrqv1OlMOCo2DJHD13bPP+G9UH+LeUSszOYrTjqAgE8et78GpULW1BQwMF3L1/A1uau8nnWtkskHQlpPoa99H9U0awDFKyUzpnJZpImklUl5eC5Z8yIwW0SEdrXdrHUUSblNiHZc2gwAqFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUqavp2oXYYp7bOYNM9bPBA9ziEpIxU63Xy3rrQp/eE=;
 b=BHuloXjicyt/G2oKRXwJ38nFugEFd6CvHjgd8hX8RyyJadZGNYL6u4729XT1D9EXqs6IRFqpnhjKiTM9Mli9IYpnFUveX/NFfinkT6fElmy1sNmNXfE6g0L7cVpWaST6ab6yGkZx8nu7mswWlsakEq+HWz3R2or2YVthgSndKQiZw6BR5C4tm27eP0iUUv50pXHz7EZcWBj79W0epKJHq3bnfMxv5FYNn2S/BzmHRvo3N+s7EYERpGyEd2lqqhUYw65PesoHBENepmJYVLdMziRqM/8yX81lsxDbiOVYrAIPsYiRJr58y5O8ahTDUrMQpsl5Fw7AU3ndHI4hvjmfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUqavp2oXYYp7bOYNM9bPBA9ziEpIxU63Xy3rrQp/eE=;
 b=cbmu7Y5OO6e9LUAiWW2qBa0gas02AgWvvceqFsquTPHFquxj6FbTf+0Qh6LFoiID2YuywQnZFwRgkiCgs+wPvYB66U0OI/PAMng6S/KS5FyS4ILKGJtPMlM1pBqafmU0H/jMzckhnoshlaB1FHpr0z6Dh67AvrIE4taWCkxO3KQ=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 00:15:46 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad%5]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 00:15:45 +0000
Message-ID: <20a84543-8e42-4d54-96da-29754ed1cd39@oracle.com>
Date: Tue, 21 Apr 2026 17:15:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: remove string.h includes in bpf
 progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev,
        eddyz87@gmail.com, jose.marchesi@oracle.com,
        cupertino.miranda@oracle.com, vineet.gupta@linux.dev
References: <20260421202233.528128-1-david.faust@oracle.com>
 <DHZ51LAF3MRD.20EUP6N4BB5P@gmail.com>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
In-Reply-To: <DHZ51LAF3MRD.20EUP6N4BB5P@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::8) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: a490d63d-7344-4234-67af-08dea0044c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2LzMiVCKrfgUkVSWVGgwKx8VyxMcQikXZsdqhnTMwCu8CXxy0dpl6kHBNwnm05lbpbN044sd2wKm6WEZQ8gYouW8lkrV+KIszZgCTQ5oC7Pvv39rnV+BG8gLwWCtoEDjsguqu1nam/4fGoPSCwpGL5INegZmjBdTv/YXKWusho/nqpgcA9ElPwhtKBgImLqmirZfGaJbVXCRJhSYtc3fNEa/ZB2RZkTvhRId40eiCn+tmA3S4gSd4oqO2qkwYPxz9PEUAtvnd6Iq22cdqwB4pSbEr/epzrOFN/6rKs2XP4UQ6eOAc1s4mEBxWHa+/qoH2O8Vw9UqFOeZtP5yanlGryxVEllIIPxNFxSQfBGNtg0LdrGKulMDdkq6SclRaFyo/fLQuBXg8bUCCdfKXL3pYUywuceHgRf2L85MLqCQCElS6j8vosMZRw4P0qAed+Oacm2+1UPy5RwwERgU6Ck3Ai8wm/89ZT29jqLzshp08F6vl8+eP/JPoaKmF7DPYgt1rsf6q4VlSx9NJtHEGQhRYA4B2jbufFmIPfUHmy4P2rAxehWf3n7hapbDi3u0D71gr0xHfr3LUOfSmMAXOqYPWWJLnhXsDD4CpMCIvoVHWIT5iNS9f+rY0RTWIxQtZDS1D1ffnd7xe0WX7AGsVpActSwW+TA88a/VYKLAAkeEKqH5Lj/10Xi7lpXYnu/mXnm59AxFKi2P2isndGChMP6ak8uJH3YQgK858RUqzCLPCks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTJZei9jNWNNNU5WV1k5eWlhUE1WN0M1MTgyS0dpemE1N1VIWDhjZlI4WGFF?=
 =?utf-8?B?VVR3c1M4bERKRkc2Q1VFRWJiN2JXY2JpWStRRjdYVEFVUVcwTS9oUE9NNG5H?=
 =?utf-8?B?Qi9uZG1pejh6WGFyeFc5VGdmVXhUa1QzMllyRFRuRHZGcitHdVR6aWZrR1BS?=
 =?utf-8?B?VENhL29aTjBKcXdKOU4vVkxuMmJhaFIvYk43WjZDV0M3RTlmbFdkRi9mSmd2?=
 =?utf-8?B?dW9zbktvbGFoaTc1VFIrZm1JUHoxajFrR0FCb2lkSC9tYTRtYnh4amw3VmJI?=
 =?utf-8?B?akVkWXU3Mk9WT3Y3ZERYeGtYeWlxNUxWY3BnbmVOTjAzTjRsbXNScm9hei9L?=
 =?utf-8?B?MXd1S0ZMaEVIcXMva2R3cnhNSkNQV2RqKzZsNmdFZ05heWVXais2TnVnWW5F?=
 =?utf-8?B?UkZOMEkydnBQc1VRUE5jbEoyU0NHRW11VXJyRzUzYVNVZGd5UVVTRnd4cm1y?=
 =?utf-8?B?UWExSXJ3VllHekFjRklRc1huRW5DSisrdmNST2xmbGVXTlhCMXBNM2hrOFFV?=
 =?utf-8?B?VHVpcFNrWmxOTzMrK1VMTU5IZ1lyS21keTNEWTdOek1iQkdsR1pWQURyMkJD?=
 =?utf-8?B?TEtNUmpjRGQydlRELzNpSVdOalJ4TVI2NW9jTFR3NHVURWhrdHAweFBZNVJw?=
 =?utf-8?B?TG5JMkZrZjcyK3pJNmdsdGd5Vit0SFhMUnQ1RG1EMGpjQS95WjNlOUd1RE8w?=
 =?utf-8?B?QWdDTkJPR1RpK0N6M2kvcUMwT09PTGxKcWQ1bEdrcElmUHdHdmFqYjlkOGJ6?=
 =?utf-8?B?MElyTWlQVnBTeERLMWVOd2pTSTJnYkV2UGtNTU5MYXJMOHV4K21WNHdaMFk3?=
 =?utf-8?B?V2ZwSUJQZHhiR1B1VndDbjl1TkNOUC8vVUJzMjBaNW5hTm1ld2c2RHNmMjF0?=
 =?utf-8?B?SEQ3ZTZBbG44QTY5aVJaQXJWNVc1RW9BMXk2eGdiUDE0ZnlBV2pSaUdxaTZD?=
 =?utf-8?B?a1A4Nk41OHdaODBXVE9hcmtyYU5Zcm5Nc0cvWVA1MllEanE3S2REQ2p4aVpz?=
 =?utf-8?B?eGx6elVUWm96NWRkb2dyV0FSaGg3N3Zsd0FBaW5rb1M3Z09XSjBtblJuTWdM?=
 =?utf-8?B?eHFwK0tydlg4bG1BRm0zRWMzNkVlWjF1NWlzcjhiT2lCd3JNRCtKSzRRSTJX?=
 =?utf-8?B?N1htSEliRXVYdnRmVXQ4ZVdGakZ5bHRmakE5U2JhZ2srcXU4cnNwU0laQzlW?=
 =?utf-8?B?TVhzTDBFT0hlSnRvZHVWMkVXaWhEUEhBWGJjL2llTzVMTk1DMEdrdU93R2N3?=
 =?utf-8?B?aGdOS1ZFT0FsZGpiUGR5clhMTnhnd0s1a1N2Q0haa2VGMDJhczhMOEkxeTlq?=
 =?utf-8?B?YkdFR0JrYTlvcTNGU2tuR0lwQUFpYVgzMWJaSTN6N3Z0NStDQjV5eVY1ZnMw?=
 =?utf-8?B?Y1JBTnRQWnplYTFEdXBMRTNQLzk4ei9aV3lLNmprUkxNVEkzakZHais2WFFM?=
 =?utf-8?B?cXJURUJrVTc2TUdDdVZ6VU9JZEU0dno5MzZLYzByMy9YOU9tS2ZjL0VyMjkr?=
 =?utf-8?B?dlNodmp6V3dsU2h4NEZSTHd1aDVFTkN0cFBsTkVkMjNRSXZTR0ZhYU5VSDFO?=
 =?utf-8?B?R3UrVS8wVkpBTHVLVGxaRHBPaVFsNElqcHdxZlVrRm5FR2pMODMrMWliM2FL?=
 =?utf-8?B?V1RmZkVJSnNyZHlUbzVCcUhZck5WMVpjaGpwMUJld1dqdWlOc2lOREVmazBm?=
 =?utf-8?B?MFE1ckNyVk9aVGtyN1JMTUI1WlBHNy9YTVlxK3VuSTA5aHd2dTNScm9rRlZW?=
 =?utf-8?B?RWJUSXVmbXExMzdkQXZGSWtGQmhnQjZQekRWd3BSQ0FFU3lSNmQ2VXpCcHMr?=
 =?utf-8?B?VlozcmZuZmtkS0R4bjNYdmx3bHF6Um1GVjVpVjgrUEtrK3h5WDNXNmc5Q2Z4?=
 =?utf-8?B?RHBBeERFbzFTOGNjS3JpN3Q3MWREemdjZzNUeVVLc3drSm84RERTR3BPL0Zl?=
 =?utf-8?B?ZUNTMnZReXpMR3U5WEhZYVg4YVFnMDJrSFBaYzM1dUdxcXgxL1lDZWc0MEFl?=
 =?utf-8?B?VXNTa2ZkU0lVOWV6NWpHQ2FZN2R3MWxMaDFxWWJVVWRoc2xPZS95dHA1MEp0?=
 =?utf-8?B?Nkx6ZXM3cWpndFVPRUVMQjI2cjVFeXdQeTB0ZTFsZWljYVZOTGF3YmRmL1pD?=
 =?utf-8?B?VGFxQ0VjZjFSUHRTd3Z2VWthS0tZbGVvM1dQb0IyR3A1Z0tDZkFNeGY2NnJX?=
 =?utf-8?B?WThHak1BaCttcEJ4RE5QWnZSZkxFakZSVGRqbnZiVnhWWE1oU3JPa0hQcmFU?=
 =?utf-8?B?V2RrdnRTenBFNmIwdVFPNmNaMjNTaVFsL1lIbUtiL2UrMFdMWHl4cjRuMXRx?=
 =?utf-8?B?YmhzRTlxeXlleVVad3lNZ0tYaGJlMTdJZUJPVGFvazlWZGJxZG5tZz09?=
X-Exchange-RoutingPolicyChecked:
	mp1/EcMDBkk2Sy2tCLpcRNEVviVBvnoQrt/xkiN9XdFxbwfhZBUd56rUSfpam+v2/u2LYXLvZ+o760vpsiHd9b/0s/Gt3cu2iFfVXprfcvan+SLgXS44AoPEkvgs4XmSBhczv2fKEqe/kwZCx+nwHo6mPpoqYFcc/TFMcdXh6WUFWxS7lcevz6mXpmaHmCRDIQn7srxAd5dE3vmEWizHdm7CmvtGZRcwVgESmsP1FC65jlGFA8mPMUFZBC3FrWNo/w4SgEK6H11zjxYDAni96MInxFPIuWrH+yvjlL+tbK7rQr0DNxrd6Y7PVmJE1BC7h+amOUOz3zX1DwHUjvZ3Wg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1D7td/bR6wkLp1RGGBm8rxTk251IrAiD9jl4MzuVwBOB1KCQTB2xSkrrNg79KOc+NlkVqwqjlPgsCvhY7FrKHwdIKhdbGpgCYJbh5yIRznyBixpSnfp1XVtAt90o95feBiovdUtj+nku0xP2vnhLVGTbebds9uTh5eqJt0pQVc8W0jwD67bOwO26JnoyrtEVUW+bTXBJp7F+ORgyowZC2jJ31qZ1FrLnU1MKh3Hm/aktuPWim2H/vi23OKDhBOTDmJJQjw8YkmhagAD0SRiG4aBJXkjnAMjaW4UhPebH7ln0shXAPm/SNiMg+3tiOKxaKqb6Sj1IIypnNd/w4d0B1UAEELvqK6rmFSa2mYU6Y7KywLyrbzfVyUH5ygT1w6E3mxE5u2SdkwwlrdQbgu3NGF72Gi2Fa+BszxAZBLfKBIxFYj2vzoHHjKXwOaoJb2l7UOaYq2LpHVr0hVhKIeYpmqS21L+vEhEEATy/fcYr9ODv6yCqqKSU9LgwSchpZDlmkoj/NGbKsLo8fqXU2YlWV9uYhXz53k6OFde4/klusc+SZv73w9HPqNzcPea1xyxByF+rg2fxvX6Lq93+C+09iFAAAx2Lwhm2OK4lwQm9/Hk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a490d63d-7344-4234-67af-08dea0044c5b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 00:15:45.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uI1X3OVMnILEME/O0tnZCdj5xxtlZsuI1us27zth9vKjY7sHCFDlLt91QFH+xPNSFCoRYLPytANGyWEmoqxdHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604220000
X-Authority-Analysis: v=2.4 cv=PsSjqQM3 c=1 sm=1 tr=0 ts=69e81336 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=8wZpwPL0w0VyUpojFbkA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12291
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAwMCBTYWx0ZWRfX33/R3DtK7uuS
 B763dUFy0fJT5y/oB5sFvd5HXRxJ+6ldpBHMAnrnqekOL3zgU9b9OeWwK5YUifUpiG39kPdbxIm
 cQr9TSXzcb+8ADIQm1dJgY0szxi1O6f+RcvzEY3qoHhad13nEsjfRVAX0IQk/QEZotdVnv2a61F
 LkN+f+ageZtYgPgfPs0BF766aTILal+Zu6qjdeJ7zvgZ5Yv4iP5BW2HhRm53icD6zsVZGlRIevD
 6eYeBXzYDaBG9/jZxASBdU0QHnHFd25D7bTlUmmd4yIgF31oypaPS6Xc+KmckYIdrLGNq2h2RMF
 rFE1EhJ6CXZhC8M5SErk4Vd2N0GL5E4P82jmgBC43ri/G/i/tNY/MVtJQT2ty5MfZSsAPV62uPa
 rgsLhD7cFImK9/6hFicxiU1emKGR2a/nl1QBTvqoe0W8qr/bW07Qcbaw8oH9ReroYuGiRjB2bdr
 uYAq1iz2yoCw4EcX4CQwUNnHlRws4lUvW/g8PiSk=
X-Proofpoint-GUID: X2kABOHh1vwpkkefHjhPH3CILVEX7IwO
X-Proofpoint-ORIG-GUID: X2kABOHh1vwpkkefHjhPH3CILVEX7IwO



On 4/21/26 14:07, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 1:22 PM PDT, David Faust wrote:
>> Sources for some BPF test programs currently include string.h, which
>> is a glibc header and not a toolchain header.  Since there is no BPF
>> glibc, this means it is the native system glibc string.h which gets
>> included when building the test programs.
>>
>> In all cases the include is only necessary for the prototypes of
>> non-builtin versions of memset, memcpy, etc., and in every case both
>> clang and gcc already replace these with the compiler built-in versions
>> and expand them inline.
>>
>> In the case of gcc this replacement happens after initial debuginfo is
>> generated, which includes the calls to the glibc routines.  This means a
>> BTF record for e.g. 'extern memset' is emitted, resulting in load
>> failures like:
>>
>>   libbpf: BTF loading error: -22
>>   ...
>>   [26] FUNC memset type_id=1 Invalid func linkage
> 
> ...
> 
>> -	memcpy(&val, keys, sizeof(val));
>> +	__builtin_memcpy(&val, keys, sizeof(val));
> 
> This is not an option. It works for llvm because it inlines it for small sizes.
> GCC should do the same.

GCC does the same inlining for small sizes.
It is a bug in GCC that the FUNC record for the original is still emitted
in this case, that shall be fixed.

> For large sizes llvm will emit libcall to memset
> that libbpf will error with "FUNC memset type_id=1 Invalid func linkage"
> and that's a separate issue to deal with.

It works now in both compilers (modulo above gcc bug) because at -O1 and above
they recognize the memset/memcpy/etc. calls and attempt to replace them with
builtin versions and expand inline.
If the size is too big or non-constant, they will both fall back on libcalls.

My point is that it is essentially working by chance, only because the compilers
do this optimization. The progs as written are including a libc header, using
routines from that header, but not linking to any actual implementation of
those routines that they use.

Changing to __builtin versions makes the current behavior explicit.
Functionally it's exactly the same because both gcc and clang  still fall
back to libcalls when they cannot inline.

> 
> pw-bot: cr

