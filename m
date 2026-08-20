Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013028.outbound.protection.outlook.com [40.107.44.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59921256C
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196015; cv=fail; b=CcR14u8/Jl/BQ+X44fg9F9alBXuYgfyz894r8BvIS7nFfQdiaLeStWFYH29ORX/85iCGUfKgsUO4fMKjoxJBc5RwwQL3Blue8J1dl1v61FnjjElgRrzyvMonJ1HpDSuqNcoofkZdfOKQ02fbxThRjhQ2/6Q77E4MXLzfbuzFFHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196015; c=relaxed/simple;
	bh=KXeB9SjkIrShNPmEkLyXtTvaQsf9QBvZC1L2JILi0sQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umkSR0swezOxh8dP/fjAHaBG3IeHgVA+QG7NfTZxODu4DulmnxabH+eWyIEb5zb8cX6De0vU6CnIVOpfBZDSREoihsykGpZj67tgxDWbOM85b6topyTN0tBvi7x8vdnYJYUlPXeozCw2JhPfJs3VjbF1MX+idAdkJF0rY0Afa5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QXhG6m8G; arc=fail smtp.client-ip=40.107.44.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QXhG6m8G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvAZKnHGRfOQPBxqRcEfcA05Dgday4CikolPYkHi62CcI8Pvbawjo+rLfuaMXOFqiEIS8przdrvUJ/VWB8n+hpqFoSVypXrst+8iOvFFLSwFPaVwlsoaSOaJtgO5VkAT6GrQYcfltrzh9LxEvirAXVN9Amfxhr6P92pQfuk/ZwvmfP4610fWzCfdAqxLiPIBBTtkJVwrQ4WsaWfVr2XZxyc4/pG0O7QNWndieVBDnOvkp3kNF6VVeK7YE+3d2iB156puFq+Xee8FKPg9nhIJHAep18mJhCr384fU9rk5l/5UE4eKlrdqWtsOOv5G8y8dd45/dgq1JJmRpUUC3jolNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuknOMfTVrp5XxwnxmOvIWIdxxIjDQAXrmpcclc/FeY=;
 b=TPqsF3sN0KLYjII4IzZjzbOPTgzX8qg87eFQKwRBv+sldw9vkhrLBYD1RxL3J3Ko9zFXrq1drbtvgTeX5Eu3vTXTkBBLmCCnoekO3oPnTBRd/2eR95cNqUBgLxOstGlTs/O0hqyA1FZtQQCS7CbLmulwm1WgO2Qk7IyV3fiiGlPAXpVco4rl2qfQxU3nG1QlLUcq9/4fvqSkPg8c1Y5xbF48bauT7pPe1wu/1nf0Z9TozeyUQDJW4VMtD4MUNEpaHlCbnKdkfSKEmvKbC7BIuQo+a2gkPTTHRhck12poBfKp1TpM1p56IhkFJ7upu66FT+sqo3t/ULAdIMi38x0h1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuknOMfTVrp5XxwnxmOvIWIdxxIjDQAXrmpcclc/FeY=;
 b=QXhG6m8GMslsb6JyZNE1nJCUh/pKHtYddu117LT5PfLBwcZIdd+B4K/VUkMmmmCkjSS6U1d9jgtZracl0VBgSjM/Aps9trkfYqyO0vCtmGIVStp3AdBzQc2Xi9aPg5YVySCLo/Suft5v5B1ETaQC/6zvVTnVchIlKVxH13KCCQ9ISvQY7XmDRlgXmXym1evPbrW4kOtBCDKkTZuZuzJ64pSEA1lvUNfFJz5tfbz2kBT6UjcQ62I9ArANq/yRKu7eb1COkQAkRJNpfzq7lRKtprpCOha5YsIxEuulrzrvqu81cJ9IokrPN/XOKXGDxiIP+uFbSiy3rLty75Q9cROLDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYSPR06MB7308.apcprd06.prod.outlook.com (2603:1096:405:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 03:20:10 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 03:20:10 +0000
Message-ID: <d20e4b9f-5974-4a42-9e95-0a0cc98e2957@vivo.com>
Date: Thu, 20 Aug 2026 11:20:07 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260819090426.267-1-zhaofuyu@vivo.com>
 <20260819090426.267-3-zhaofuyu@vivo.com>
 <20260819091224.ED5CB1F00A3D@smtp.kernel.org>
In-Reply-To: <20260819091224.ED5CB1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYSPR06MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ffac81-fef8-4a9c-4291-08defe69f114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	NgW7Ii28/k6OlAk/pglkXHbfesjsDGnqYNcnJ47LAYGYeX77Ypna6EE7piU2JIsLkADzl7/uIdRdGF7XqpLTWYnSWTKzf8vsolFuvon+0OoFe1ZQLgTRHduvUfhzLIkY0VNdEwUFTL1CKZmrcrHB4Xf6w3iZlIrqipYA/6p/26FNz/VvLvAtbkCqSL5ww9TILMcDBpq6H5KjcM+io88G3yguUBY23hrdGnt9AvZ4G5rHG+BxJjdNPtNgvuA8XoByA0JSayCw/vVvrcKQeBqpxP5bnCaz9334LE6amh14FoskKJ17phgmelri0yIyAqi0xAE3GXVUgD61y+huwAKtAOoPcvdCsLyJemY4MN7KDfRBaCe2ZvvzX/VxvENt1MS1SP4/3a6XYUYeH/YlIHBXhlze2IymgK3CPeA9pOFf239IuGN8fs2/Tx5onZdOQuyKU1AJ53CI0qAP5z5w7BgteFOpqpHMB+huY4nVgtvRtjEvOiYu00B3EM4yBrpiGaMID7Uv0U1HiQXfR5Y00BAzMYYq5tqaivXz+X4q301+NmHKpCAr/vVK4tC5dDpZPCTUMbW9F7FBeXk7tpPVMtTmU/sIj0ehEO8GtOSutYDKVRve41vh8+fCvoaBAcioWVwMjOcqQKWZOfuVXBC/RBLiZ0uGn9McCNeNa3XgPy+AOws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M21wVDVGYmkvQytRSkI5UTdmL3ViR2dOeEZmV2VrMTJVeUU3MWI1dkZScnor?=
 =?utf-8?B?ZVpVOE5hb3NVNmJOYWVEQm1la3FsUncwZ1Rxb3dQSC9vZTh3UWdwSFdDTzlE?=
 =?utf-8?B?eURMWFI3NlVISkNZLy9JMlFoWkE1M1dPYzVEd2p1VUtsWWFZcmZGUFlPbTlj?=
 =?utf-8?B?K3loTmdjRXVjUWVyNGFVd3NVSnFmd0dmM0VUWTdmRHpiejVWUXVZQk81MUlC?=
 =?utf-8?B?VnpwWXdmM21lQVplUERtOXZEK1hIVXZ1LzVPN2tNTGdzeVNETi9zNUE1TXJJ?=
 =?utf-8?B?WWRUU0Q1WnN6cTFVa2JXRlJUbjdkd2srbkRoRUxRWHBKZXN6K1V1Ny9XcFMv?=
 =?utf-8?B?QmRLVmVHQnVnamtnUHVDVkVRMVovZ3oyZWxlS3ZFQVQ4R2FOSUV4UHVrY0VH?=
 =?utf-8?B?MmpwZ1RlRW5Oazk0MjR6Q3c1WnRCcTQ2NmV0VGtUTUowY2hoZnZCdVdMdXdt?=
 =?utf-8?B?K2hYT3RnMWtaYitvR2V6TGZGY1VvUHJmS05pUm1xbEh6K1FMUFZmUXoyNFJs?=
 =?utf-8?B?QkV3cXJnaFA3VUhtOWxubDV1MkRzU3JVc1QzOHlyTEtiSDZwNDRMM2FhamxY?=
 =?utf-8?B?bTJqNFZkSVpZOWdKQWpvNVgvT2g3SmRRb3dvUStkV1d1YlJnZC9Dd1Fxd0hF?=
 =?utf-8?B?dnBIdDloQnozR0ZYUURLZ3RQR29aa2ltTlZwYWVlRVZmcDkvNzJLRGlOQ3ZK?=
 =?utf-8?B?ZjcyTW84akh0eDlTKzlOQnRzTG5GeWFtb0tJcEgvMldSc3BwMmpoSldDRE0z?=
 =?utf-8?B?b0hsSXpqTDdMWnUxL0NiQXFtME5EU2N1UjNFWXByYi9NNkJlazU5ZUZid0x0?=
 =?utf-8?B?WXJTMWh5Q1FDREJqa0lrdXU2Q044Z0hDaW5ORE1BVURyeHNKMGwrMHV2TitG?=
 =?utf-8?B?VGVVck15bFh1WWw0WUVkb3pCY3dWTGUrNjlQaDVQYXVMZDd1QWhlQ3dKN2ln?=
 =?utf-8?B?NDBHVEd0Q2JEVzFkM2pVZDFvYjVZOUx0T0RCcmlNdzUrZ0IrM3krU3Z0bFR6?=
 =?utf-8?B?eGpCMkhLTkZmbks3SldicCtBRHNBOC90V01xZzQvYjlCM2V4Q2RPYnJ3dHQv?=
 =?utf-8?B?ZWYxbVhtL2Z0WWh3dlBVY2cyN1pzMllybzY3SXQ2NE83TzJNVWZGSDlsb3VC?=
 =?utf-8?B?T1BKOVZvZ3dQU3R5VkErZlU0N0hNN1RSSnRBZjBXcFNnVzFLZUVQY0J0SVpM?=
 =?utf-8?B?dTAwY2dvUk1SbUhDc0VkeGxMZHpZUVVySFZFNWQ3OHlRdTNsMGhSeW5qL3lx?=
 =?utf-8?B?K0IrdThaVjRXRndZbitnZktMQytVd3ZUalJ0STV0QTYzY2NjU0R6dmFjZnd0?=
 =?utf-8?B?cUp1a3lacUwxZWFMWmtRTERpRU1WRXNmODBsbDFSL0RWc1F1L0dGMHJTWWJn?=
 =?utf-8?B?R3Z5RDN3bm5LbGVBUkdPd05BRGQ4WVRyQTVabk9BQ1YzZTRUczVJOVA0YzhS?=
 =?utf-8?B?aEUxcVZka0UzYmJvaS82UGozSU1BUGp4a1IxYVRSWkYwZUFBbEMzS3hjbU02?=
 =?utf-8?B?UFQ1NUEyVFVhOHN3NVFSc1NUMGRWWlZEdG5pSk5HcGJPVnJXd0pEa1FhOHBy?=
 =?utf-8?B?a1cvUFV4S2lzZjZ2TUpMdmVEM1RtVXlCSDFoTUpCNXlEU3VDSXJmYW56L0sz?=
 =?utf-8?B?SnNQOStPS0daRG0rRUtFYlZLdHc2eVNSQXZXMVVTOXRUZGZWa0VrKzVBbmJr?=
 =?utf-8?B?ZUx3R204aVV4dTRWQTBWVS84MUN4bzNUd1N1VWQ2bFJaM0RKL1FjSkNySHVP?=
 =?utf-8?B?S2taMU9jVTBFcmNKckw1TFJGNDc2U3lXZnR3NXJRYzMwME04Z3Y1OHRQMUJC?=
 =?utf-8?B?eVQ1SmZycmdZTlhVbEtwRkRnSnAvVHo5Z1JuRUNzMGNJT3o1akx1RytaKytL?=
 =?utf-8?B?SE1hM3NVREpIQzM1Q3I3MTE2NG1JUVU4YkFqcGx5bnBmQmVzckN0Ky9CTHph?=
 =?utf-8?B?TTIzVkU2T0F0NHF5RC9NdzJmbXUveDBscklNRTZ3YmdRMFhGZzNaVkorV2RF?=
 =?utf-8?B?U0ZrWktId3RuTThQR3BITUNISmNJSzBKSXB5ck5ONGFNT3hsZ2RWMVNXUnVM?=
 =?utf-8?B?NWoxZ3lOSTAxZ1pBZDZxa05SMlZBczdoL1dTbEZtQXBRNEQvOHZHM0l1eGZF?=
 =?utf-8?B?OXBWRWhkck1NZkNIZUxRaWFjYm1pemhmSCs3N0hVVmM1TnJRMlZNTGxmZmI0?=
 =?utf-8?B?Tnd4ZURMcTlIcFRZaHJoVGx2S1FVZG1YNEJkNWxXd09iR0lmT05JOTc1Nmxr?=
 =?utf-8?B?SzFwWm53WTdUWXpKSm9PakJOZmZpUVZoemZXck9icVFXRGRnemN2cFRIR1dm?=
 =?utf-8?B?Uk5sdUthK3VBTXVEZlRONFFMRFZtYlBBbnM3TGNHUUdmWXFTczlLQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ffac81-fef8-4a9c-4291-08defe69f114
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 03:20:10.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUSos/4AHYWzSFQ5jvqP3f/G6+L/GFEwCT4NRmEBm9Cxl4MxWw+NG5E3MA+CS//6pJkHafowLRraMoCNFNGfNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7308



On 8/19/2026 5:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The custom libbpf print callback silently drops all non-matching libbpf logs, hiding crucial diagnostic information if the test fails.
> --
> 
> --- Patch [2]: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for selective kmod BTF loading ---
> commit 17f3a2340dd7be0947e3baabf30a8c7722ec91fe
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> selftests/bpf: add tests for selective kmod BTF loading
> 
> This commit adds tests for the selective kmod BTF loading feature. It
> covers scenarios such as valid modules, non-existent modules, duplicate
> names, unneeded modules, and missing count properties.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> new file mode 100644
>> index 0000000000000..61d2845a731ff
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> @@ -0,0 +1,196 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include "kmod_btfs.skel.h"
> 
> [ ... ]
> 
>> +static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
>> +			   va_list args)
>> +{
>> +	if (!strcmp(fmt, btf_skip_fmt)) {
>> +		if (!strcmp(va_arg(args, char *), "bpf_test_no_cfi"))
>> +			btf_skipped = true;
>> +	} else if (!strcmp(fmt, dup_ignore_fmt)) {
>> +		if (!strcmp(va_arg(args, char *), "bpf_testmod"))
>> +			dup_ignored = true;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Does this unconditionally swallow all other libbpf debug, info, and error logs?
> 
> Since old_print_cb is stored as a local variable in the subtests (like
> kmod_btfs_dup and kmod_btfs_skip) rather than globally, this callback has no
> way to forward unmatched logs to the original handler. If a BPF program fails
> to load during these tests, will the underlying verifier or libbpf errors be
> completely hidden, making CI failures harder to debug?
> 

I don't consider this a problem since the test runs serially and the callback
only affects the kmod_btfs test.

However, I can forward unmatched logs to the original callback through
old_print_cb to preserve the original logging behavior.


