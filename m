Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012070.outbound.protection.outlook.com [40.107.75.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B33630AD
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622450; cv=fail; b=N9u5gv+kVzCHTQHLxzGHEtJgwOsMRjCwT97z6x3ZMRolZdFovF6CUKNffAmYEWprQsgzN6SQfwpOA5YPWliK/dx2nAmMW1AXKIb6TRidCWiO/AWHLc4oafjGYIMOqTng7hAx6V3U7FRyjBfuJs+I3E0//+Rhm+9qO22uSLj3MKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622450; c=relaxed/simple;
	bh=mC3+m7xFWluL2PLyNXBDDeUaVP27deg7bYU9eBabFV4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZmJZXd3rQF0fmKc9Z9+cK3eUIXpCIfYOeM7VZH6a1mvifWBYBpGmYx6+I2K6Nm7rn2wLsa6srBhxMv4J4EWPpB/3gWYTUQRl+EJK9hcG/0fKZbTQfS/FtCVeF0p7wEAcXqRLvEUjBdbzHt1Blzk21K9IsKC5p52sh2FZm+MF9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YOp7NASj; arc=fail smtp.client-ip=40.107.75.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YOp7NASj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEbqd27Nn80QFLJoKm+r4csC30LFXqwbXjDgyjadVaWwpFpNNE34CUpwZFxUOGMAna/6j1KdOJX0Q6Vr8xLdUMx4AFnIlaJRBTsna92d0RjdNodjd8AZ5o62/6vetvEbNwtTtmFKt36urjAVR1ln3vUF4Mx5I1JsuEDe+aLU3IBHPhyluvxWZvz7O1NPrqBYWsRZhQVhkfjb86QTuqEivJSPpToSZp8XHXr0x0CSNfablp/7akmenWEg7asenHXggshjfHqD79EIw8x95CFYI3pzr/7frRvLsGT9B4EOpEm2/3Rw6eXXm2PFOphw+hjg1qcDJQHwBmntgpWGk+Dnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRo2rQAX6w6S9D9fb/ZnKC3i3GsHAgxSw5hKcENYguA=;
 b=Xb2uMMvRGnTBOMwBVX8ZNpUnitAxwZHVcLFWWuj9TdZEKFBJvVONjDmqcBYLynwwTcDrafEo39HOf6qL9HQqm7G7EVS9y0uc3V5IfIOsLPV/zL5v6hje8lUeTiCxL5itk8mOuiZI9QLdslmRYhHV/6lQYGmALB2EmcUQ4vb9iM8EDzv0Ioe8o1IR3BMG6RBYthm9+zfm6QmVhlTZlR5zsYv5vT+51uJdm1O9m5OvvAyRMj0P+zqTQ9JXlSvHVsxsdBb+XOnouYoDfj2JH0p5ffDnL2+/e2i9CnlwHuoMmALKeV6QO8AeF3e1mUnWdkg4bSeafwWXKNVa2/E2UsVtdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRo2rQAX6w6S9D9fb/ZnKC3i3GsHAgxSw5hKcENYguA=;
 b=YOp7NASj38/FcrWo4BIskadfwsXW1caTDTH5f/vE/h4fJvlTfEsHkYXRSsP0arThw1zNwUVXmp/n/9+Te/8SLS+n4HSnley/E8eycvvEMdPxh783GZeRfiXH0VJl2/NNA+9P5RELMM+3GuOAOsvKLFEt2fScMrfDnKYa69EvmrFlaiY4TdkN3FT59kNmPQ87I6iis6XHlX0f6mgOrm8RaOmL/2uPDgwmJXYJNHxImhrB+Y9kcxr2aeqdj/wei2Pb7uxlRucaO+xDsKx71E4ncWq0QQuWwV7oPXMg5b6yb3HN3YfXTgfQ7vllQSOU8XJANPTkApAJDWehwYsWkE8Ybw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by JH0PR06MB6655.apcprd06.prod.outlook.com (2603:1096:990:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:00:45 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 12:00:44 +0000
Message-ID: <b83c28cc-94ce-466b-aa25-f86ffc3be512@vivo.com>
Date: Thu, 13 Aug 2026 20:00:42 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813032613.2755-1-zhaofuyu@vivo.com>
 <20260813032613.2755-3-zhaofuyu@vivo.com>
 <20260813033743.102F91F000E9@smtp.kernel.org>
In-Reply-To: <20260813033743.102F91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|JH0PR06MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c032ad1-f945-4149-b4b0-08def9328106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	lMVOgmrmGAa8ZWNqg2ZZs1Hf3K+5ObVi9kEG9G4IlTFuNU+RXWBIkWlLNFkluCCgIWAUZ0LfsU7nyFq6ecPeKB9Uc3ClHiLYqgH3oKCvt69EQeSXQG1RB0QGJfKAgLSBGcBnrCmo/soYzgpF8ku5tdof5v6Vv2Cx8ZaKtUixirjGM9U8lZX34WxNEbQ6hk5SC0NnT5sskhOwLn4fRFmRRwDb8n2bb4u6oGS14emv7zWituX+nFefOfgQhQMB5vBlHpEdiUSf7rh1N4LmWYAHmZ46DhHqacoFp0BssGMgFyaRNhl4iCO8H3wc3DQF2ZfvXFEcutFxoYEQlDGf9MYFGyf5yRrTcEY3GjuhNxuaNBLKNK8XfBB2a5ldhJn9FnHGIfRFqp2P7Ae5u4xrBTBUMvmRpwxp9r6+BP0Vjw+q+ymPra8+5oDnj/FpZMyt4cOYfMRHrQyg0MW6D439PxzlQzgu4jFIachgtB9HM4ka8OXdwzQ0x7kHBXFovPNM/MdVwoV8ZgFQ5419KtiSkVv2gCFOIb4/LkKKG+kN50LZzI8qkYN7OZ9+zjHokHl8shNmF/V+bVeD+VW0daqNK1WXpkJn3uubt0YLjYXhQXX6W+KvMNQsxsdwQdrIBYeOXwrIPfmPxkVqI0y82pigPuFILUXvailYnkHLwlvfCODNXfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1lUUzlRVWZTYWE4M2QweVhmbU1WMEQrbXZXaDRaWjlSMWp4VXZ2MnJ1MFJE?=
 =?utf-8?B?MDlLQjNvM1BIbXF6K0RkVjNXTVNRazhlaFY3cHdPV1ExWTJPbldsVmFrK0FP?=
 =?utf-8?B?akFIWnRlc0laYzFGRXdqNktSU3JPR0xPcVovMWxoNWs2TjlSWGdvSDNLSDJJ?=
 =?utf-8?B?UHlZVldSN0E3VU50OTVLMXY3eWVFNEVvY1hIeUU0VTVGYzZpa0RLSVdkZWVM?=
 =?utf-8?B?YUR0RDJMQWlzQ1AwWkdnYzh2dStGWVV1Qk5WcWZQOUl1bjAwN3dNdTRxcUZr?=
 =?utf-8?B?NVpibGNqRVAwbEpOVzRZOWhBdjhWTkY1TlB2cWo5Sld2TmFmR1czbTZXb3hG?=
 =?utf-8?B?VmtIbnM0NUNlMytEMm5QUFNkUGI1WTluZjhYV1hXQVA4N1BTa3FtSW5kQWls?=
 =?utf-8?B?aEdTV1R1Qkw4bjFVK096OCtwVHpFUUdINUxMRjNZY0hDMW1mTCt2UXhPOFYr?=
 =?utf-8?B?aUpETENLSGN1YWFNVnJRQjQyaTRWQVl6bXN4VmRseUwyUHBzM044bjA1Ky90?=
 =?utf-8?B?WWtaV3c1ZTE2UFB0TWZyTEFxei9HdTNsd0xpNWlYRW1ic3VhbUN1Yytlb05j?=
 =?utf-8?B?TGpYc2dXdHBmNTloS3IwWjNES1lxN0luVE1ZSEFOOXZ3ZHFPQVVvWEN4LzJH?=
 =?utf-8?B?VTZDUzgwdWF3SlFMRVBaVkh6R0kzNThKODlmU005cnM5Zmt6WjJQelUrUGxY?=
 =?utf-8?B?TnRFRGZWUUtJSE9xZnIreWt2RzJMZnpuUXhmS0dHMVUxbWdIcnFlU1NBelNS?=
 =?utf-8?B?TjRsb2xCS3FYMGRvdHhyQ3VrOUhkOEtXK3owQmVKT2UyYnE4UUdUbWRudTRJ?=
 =?utf-8?B?K2FKYkl5cXpkdTBlTjA3NklvRVpnbE1lanVnbjUvajVMaHhYa3hGK0RubVU2?=
 =?utf-8?B?VHFDZjNHcVhqb3NFRTd1L0NUQTNGOGZUZWlRM3NZUGpDdWtNbWxiVmd2YVFl?=
 =?utf-8?B?SEJFaGIzb29TYUdnY1hDQ1ZxVlVaQWRLME9tZVF2MnY0Ujg5MWlHQlNIN3oy?=
 =?utf-8?B?TDA3Z1JaK2tvZUlVYzRhb0JXTllRRWZzei9hN2RRcWEwdWFTeVFIT2YvMVdu?=
 =?utf-8?B?VUFieC9kNUIwb1lJWW9tdUsxbHpTU01kNFF4NUlTQmxsWnp5UEt2YUlDM0V0?=
 =?utf-8?B?MTRUaFhkNkkyYmRiS3FUNmc5Y05vb3RIMStrOXBzb1BsTjZvcTl1ZFBrdHpP?=
 =?utf-8?B?cER2YTl4TmJPckREOTlQNkk0aGZhcC9vUmhtalBxbXJhV2U0enc5eFoySU9L?=
 =?utf-8?B?NVdQRnIwdFlPMHpGQlFIbWlrUDZkWnJpUjl2Um1zaEhpVDdQWHh0OVB3M2Jm?=
 =?utf-8?B?V05Jd1ExVjZobldzRnI5TXo1WFNWNVl1RkVZclVVRVBCS1VaNzVrS2ltV1RS?=
 =?utf-8?B?SnJzYTY3QitwS0lDcHRER05sVzhxUTRRMnIyelNmRC9EaGZ1RCt6T3A1a21x?=
 =?utf-8?B?bk5aN2NSM2gySEFGbVhkT3VkSnljKzJyT0ZLMWIyUTJQakFZMmNzUjVOTXdt?=
 =?utf-8?B?a1Bkd010RXZnOXY2elVJNmZFMTZ4bHNVUUo2OWpBWktIbHpEbjNtUzhHTXgw?=
 =?utf-8?B?RncyUkdmUFJsZ002RmRCdDJUaHhTcEdCSnV3SXhOR25BdU9HempuT042eDZC?=
 =?utf-8?B?WEZmT0gvTXdPbEVvSktGYXozK0ZYSnVRNFZ0MlNCNEhjd3dGeDd3S2pxb1Jj?=
 =?utf-8?B?V3VnNFF4dW4wb1h4SVVLRlpFUEYvL2Z1WC8zNmJ5TStqamtVL3FST1ZEazhP?=
 =?utf-8?B?bHdINUpuOFdRREF1NXQ4VGNKQU93dHI5cXRXUzhVYkZ5QXV4bzRvWC9DNHdk?=
 =?utf-8?B?ZjhPYlN1d1pWY05TNFZxbDJtUnFGUEU4SEtKWUtvc3VKcEZEWERLZ0MzNTk4?=
 =?utf-8?B?SVRJaGZ1UDE5N1VDUUpjNm16eDdwNitEMStVOUc0eVRDMmU0TzRwK3BkUk1h?=
 =?utf-8?B?Y1NVVDVJOEdYZnE2cU1EQWlWY0ZrRGxmUHE5dEo4VFpRVVFXZytHWU5VQ3I3?=
 =?utf-8?B?SjhHdFdrRW9ncXBKUkIyZkdXUnV6aVNJWlhhVGJpd2VBQk9pZTlQdy9ua3k2?=
 =?utf-8?B?N3RqbmNPNzNEUjZDZFFsS0dwM2FIbWVQY0QralU4dkNKd0IvVDBBTHBWbGFs?=
 =?utf-8?B?NTNKZjR5UGp6UFpyYlVuMDhvOEJOL29lanpzYlppVlZSb1pOS3BlN3RUOXND?=
 =?utf-8?B?WU4xWlB6emxPblRGUmN0dzd0RkJlaWlVUGpPSUFneXNvSmVWbWUycmVzekZv?=
 =?utf-8?B?RDVISk9CK3lDWElWSXkxemNOb0VYakRlYmt0THkxbDBzVUNSalA5eFhzZnpK?=
 =?utf-8?B?QWVqZnovMWdsNmtMNUlvNVE4M0dVK1plbjhsUWZZdXM3VHlkYkFQdz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c032ad1-f945-4149-b4b0-08def9328106
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:00:44.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfsRjQUiWhwS8QdGmHfUj08Lk527ZV70SwF7FJVLIQXsh5VdvaW4bvTppoAGZiUdSKIBNHH6d4cSCmLKrwSfag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6655



On 8/13/2026 11:37 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The tracking counter `obj->kmod_btfs->nr_loaded` is never updated, rendering the early termination optimization for BTF loading completely ineffective.
> --
> 
> --- Patch [2]: [RFC PATCH bpf-next v2 2/2] selftests/bpf: add tests for selective kmod BTF loading ---
> commit 506359525a106f517e013e060ee2c6feb17720c8
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> selftests/bpf: add tests for selective kmod BTF loading
> 
> Add test cases to verify the new ".kmod_btfs" section logic in libbpf.
> The added test cases cover three main scenarios: valid module, non-existent
> module, and duplicates/unneeded modules.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> index 0000000000000..d875fcce6681d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> @@ -0,0 +1,52 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include "kmod_btfs.skel.h"
>> +#include "kmod_btfs_nonexist.skel.h"
>> +#include "kmod_btfs_mix.skel.h"
>> +
> 
> [ ... ]
> 
> [Severity: Medium]
> While reviewing these tests, I noticed a potential regression in the libbpf
> code they exercise. In load_module_btfs():
> 
> tools/lib/bpf/libbpf.c:load_module_btfs() {
> ...
> 		if (obj->kmod_btfs &&
> 		    obj->kmod_btfs->nr_names == obj->kmod_btfs->nr_loaded)
> 			break;
> ...
> }
> 
> Is obj->kmod_btfs->nr_loaded ever incremented when a module BTF is
> successfully loaded?
> 
> If it is not incremented, will this early termination condition ever be
> met? It appears this might unnecessarily iterate over all remaining
> system BTFs, which would bypass the intended performance optimization
> of the .kmod_btfs section.
> 

Thanks for catching this. This is the same oversight mentioned above.
I'll fix the nr_loaded accounting in v3.


