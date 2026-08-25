Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6DE347BA7
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629520; cv=fail; b=HS0sSVgllEjdVM/wrs6WddhA9pldLwUWpZLp5EYVgEYLcyfO9fCwf3REwNqUVBq4YlhdZiT18zHxDQ7EXPCWH2rZk4e0/NofOz+wwtTnnZp9yKjERTHWdQtqfNcdo8WAt+SyB2HZ7jgYoyyTmEiwIwR5/QWUrek9kFkMVUHogLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629520; c=relaxed/simple;
	bh=1thkyYyRjFpUblr7Mv/PhvgbQI0XHD+mhnIpwKS5Uak=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fiPiPAl38HV+OfKi8mLWi3flIhQBrR/i2+rSGnOPY9lLR0BE15AAMQa3CVwWp47vRNlAtnTsLS00CxVrPUi/XIHHv2to4aJ+n4I3MS/wYc7C7bcIZrUrk5zb4QsDvyuAu4iKwpYqrSajVDcZeVUwQTw9Miz9rtbYEmFUeaGMX14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=K6LMt4f+; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="K6LMt4f+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjuCaAyNwoOAWVb7GaQupsrRooIEcG3LQYCgk7h/9QwXUiuiyOlcOw9VAxXSTZTsxAeZ5A2iDY5LUCMi4KtjeUU0X+DtKVUqISfCvB2JDqHaencFFNZQ2AigyXeCb1RMwI3LxFQDr78GLva9iiYviFB3gDNQMK8bo0fk0un3NyuSMvgD7/QWbmQDGcqFJEejqhx3SPqftDMIRB905bkVn/XNKxA37WBfHMxYJ4AZkv6bur/FnBNE50hlJQUuUd3ejJcRa7Nm4DF2aF/WpKE3DMzSayC0QKiQaapiZd+/DkmE55S2IA6QJO1annmmRcsv4lxiuzxl6Nr4aIsKj1E4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwyZ2no4Zl2gyw6WZ5i3C2hKMKaxL2uufmkYmQgwKXk=;
 b=uJi8fxMNWrkdzOcpg2fuKQEknGUP4PoCqNGg5te8LPTh4XPfkxd4FW+FQGMwTXbb3unCkuK/qg31ccg0abjfV4GYu3ab1yEowbyjnLNvY24hhewYr2lgql2u37CHULhS8yv1RITjaw3kwuKfrO/3+vMlUXIDqO30LQP7DXde6YcsJWYqgjkeqJD1aRvX3cDDcFI7IyDTdguDVlKPTttoYvuvdIlFFyf7q+LQXjectq+EztF+7f/diSgVfRGm5wvhntqAjmgSlCg9BEH1w6xEMLm7f8cJsjSK25pcu+irQzMDk+G2VYFV+jBR4gD9IpHpyMI0CEftbXxkpRgLm6JLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwyZ2no4Zl2gyw6WZ5i3C2hKMKaxL2uufmkYmQgwKXk=;
 b=K6LMt4f+tQ/mC5n1dYFJrLFkw36t/T1wRDpWsqPV/bZWYYAFkj8Y0xK+qKjp1EibDGWNBO6/HPG37Rqo1CMtdmAsnempDc4/eaf5ahhGkPadXsFDbcGe4gDYWyPkUpMgvmZiKV6uF9arRRAS2TgzX844s3Ou5jkcJjoIsGBRA+NSf6RZtbzWru561kOZ6tylHmgLqoQDvgDa9luMNvA8heaiAwR2zYdwbjftFPN9r79hgsDkR7I+oPlH8/jO9yKSNuL9FW9BKc6mUVnqe4a8RpDqb9Izajca0thVpODAkyG0vaYXQJjayJD67NW49oReK8TY6BKcCNYKjv54XQhZoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KUZPR06MB8967.apcprd06.prod.outlook.com (2603:1096:d10:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 03:45:16 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 03:45:16 +0000
Message-ID: <bb90f655-7a1a-4d29-9c38-ffd4454245cf@vivo.com>
Date: Tue, 25 Aug 2026 11:45:12 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org
References: <20260824125310.1384-3-zhaofuyu@vivo.com>
 <dc7224531e66a752eba5ac70daaab3a6401526d3003271c956ace42a0b04585d@mail.kernel.org>
In-Reply-To: <dc7224531e66a752eba5ac70daaab3a6401526d3003271c956ace42a0b04585d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0013.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::18) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|KUZPR06MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f7b521-3840-4453-7135-08df025b4673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|5023799004|11063799006|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BdVvgoq7OvgANcEkFTtIkZ8d1GYPuF986bzFfVhnpJtipEMNPPGZjmrGJrz+9NAAcxBpOPx+Ic1ROjf+98kjpL6JW4NHsMRXnExD/eUZ0wexCX0gupM6Ah082bCr080s7kG59RXrFA8DivZtnNa2/XWVCeskIo0+8+CdMeLqAG6NRr0a6//Eu62s2WJiuIY5YAmfgARDeLgyBbecL8iZLcfPo5jRt8Fw3g7z+gj0nLka1jbdMNLAnaXM7cgsJfGm4JcBl/LWQAVI5pr38ez/SmT3/EuRXShinCFnWqESMxsatqLn9C7zgjcvRC+bFhN0kMh1bEkEhz33S/N2GVsV5n8P0GPwYzvjjp51J+Fq4Pvp/UTyMbz+ol3o8Eqqaco5He4yF7lQqMLEN1UjSpkd9WNiHmqIfGXzX/u8HGDEAX+N9iWiJdRUEqs7F0Gj1c3iJym4K1m5E3wZuPQYqBL7b0601FpRt/wZy/mG8PE3Y+8nOOIisb9sbSIeLoomZSQOm35C2nLBSmWqTaBmOL8jdf53w1T1cBjDoDs7ZqPYiLAAGSIdLahQNQFSSRphvAytg02OVzGyJ6iG64IgVwUxBgeKhrW5VE3OKRogeVjG8+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEExb3VLTVZaKzZpdkVaekdCSjBxQlJteXRlY0VjWU9Ra3o1MGhxdWRTc1NU?=
 =?utf-8?B?RDJuMFp2QksyNG5IdGtYQ1BCRmJUa1NSOHgyODRqOURwcUxMTkk5aXhFTEwz?=
 =?utf-8?B?Y09Ic3p5Rmxxc2ZYeGFPUzN3VXdFZmU2cjNIR2tVYVB4NEtacjNmV2hsb0sw?=
 =?utf-8?B?ckhBWWRHZTlRWGtpTyt2TU1QWUI1TTF4ZTNiS09yei9IbTNpUjlQalFoTWxy?=
 =?utf-8?B?NEVZLzJSRmFORWpwVmNPU2pmV3ZCMlY5L3dVN1NaQTdyTVl6eW11L0FPSXJ5?=
 =?utf-8?B?MEN0OXNmZWg5bHV3TFJvZjdHNFBqWTgxSkc1TXVnY2xVM1FqSlJ3NU5OeEsr?=
 =?utf-8?B?WFJja203ZmF3SHdJVXk4cmowQ3lEL3ZOYmplQzVrOHkyaUJtMVFBc0RVaS9E?=
 =?utf-8?B?cXlTb2tOOTRrTFRKWHRUUUtGRDhwaUxNL2RSRkVsOU5TaXlrc09wYjZHUHgv?=
 =?utf-8?B?YkVmQlBCbFJMcnlRYVdWbHkzM29pZjd4Ty9SVytUR2FoaThEZjErLzNuS1lC?=
 =?utf-8?B?ODlZOENERkQxdkhaUVVTbUdLT1hSNzBhS2pIVldnMmpieFNPb2tHajhBODRO?=
 =?utf-8?B?U0RDbHRUdkg2OTZzV29DQzVJUGt6R2VwNHRSQ3J1cFlqck8vSXZLTGZaQUdW?=
 =?utf-8?B?VDJGZWZEcGFWU0hBNTk2MFc2dWpIMmYwUEtzYUZxa1pSUjF0SVh4ekQwYlB3?=
 =?utf-8?B?d3FGS01nbnJtRFREYnRZVlNCMDV3czg1M1dBOUZzUjI2bUhlVlg5NTJJdERz?=
 =?utf-8?B?WndRM1FrOXdhRmlEZ0FGNnpUVjRqbmVTQzd1Uk56MWIrZis0K3doRmtzS2VE?=
 =?utf-8?B?Z2FXMnRSMjJlWnVXaVBvWmdxWjBQU3AvR0VBR3ZPSExpemdUSG9aeWQ5clF3?=
 =?utf-8?B?MXBaV282aE1kS09jSE8vLzI4TEJEbHBIQ1A0Yzg5RTRDTEdpdzhBYWU4RnhX?=
 =?utf-8?B?aGsvSlBlTDV6UFVPbXhmeHQ3S3ZYUG9oTkZzaVFoZWE0VmoybDEzaUpQa3U3?=
 =?utf-8?B?SGVVZkVjbzZsRTdSWHBRMnRPWkIzOVNZYkNlaCt1VUgxRmgvY1diL3RoVXlu?=
 =?utf-8?B?UjIrYk5XeVBaY3ZuTytQUnZOWmpDOWEycHd2R09SSnBwZXhEZVcxVGRCd093?=
 =?utf-8?B?cE1kTkpGK1pnSVFGSHIyRjFMMUdRWm1LcHgxUm5OV29RV0VQVy9YNExZWEYw?=
 =?utf-8?B?aE8xQVlLWXQ5REovUUZnZ3RtTVJMWHhleHBjb1VPcDdJM2kvNGhMckREaERE?=
 =?utf-8?B?Vm9JZ0VWeDlRQkt4ZUFKNEhaSE4rdGxKNXdacU9xVFp1alNrWEorelI2NnhZ?=
 =?utf-8?B?THVhbDdaM2VHNEY3R2Q1NHloOG1QZTU2aVVsMHR3dnpTVVpYMGM2eG44dnh0?=
 =?utf-8?B?a2JnMGl3Q25MSUk0WUNpSEhjVldQWUVIZzhlVlRqU3JiNkVub3laWFVoWktM?=
 =?utf-8?B?akM4Y0NMdXBJQmEvek4rOU4wa2lDMHdBUTVKOVovcmUvU1plRWU3US9abEx3?=
 =?utf-8?B?Nm9UZWpRM2Y5OGwwMktGNDVkU01jTU9VZmtkc0dSYkpVY1RrU3FWYmZmbVhL?=
 =?utf-8?B?NHh6OXN6VjR3MS9CT0l0RDFhNzRIVk9qWWdaejJhYm5uZXpiUFpKbFNPMTd5?=
 =?utf-8?B?ZlU1R00zUUVNWTk2UnVoVFBhakZiZlgrK2R5V2l3U1hULytMWjF4QmE3ak9q?=
 =?utf-8?B?TWlQYlg3Sm94VGFiRWdlVkQwN1BrRUVkbk5BL01JY2syLy9ZZHhublZnNlVD?=
 =?utf-8?B?b0hBOFNjUEUyUjVEZGRleUZxcy9NQTFWQ2ZMMzBXQ0hlWE5WSUNKNkRJVG1N?=
 =?utf-8?B?ckFDQUFmUzdzK0JaSzhic2EzeGwvZENsT3RFVUlpdmo2TFJtemtEQ0Fma2du?=
 =?utf-8?B?Tm8xMDFQbjFldGZVT0NhMGw5d0xxd3V4ek1seThSd2xCK0s4N29ETmlwcW0w?=
 =?utf-8?B?Qk5VUVNWQ3BkMFBSN244Rkg3SkNXTjJNU1VkSWJTeGVobXZLMnBsck1iYk8r?=
 =?utf-8?B?QXBuMWNCR0gwTlhGTnIrYzNUWXo2TGtUK3lQQWxya29SbW5mbWlLbWNVS1lW?=
 =?utf-8?B?b0x1Z2tWc2J6QWgxbjlGRkdvb1JVbGI5a2ZneTJ5R1hxSm9CS1dqWVpzMURB?=
 =?utf-8?B?b2ZiWGpibmRRSDNDK1JxSHU2Vk9JcDlSYkxBcVhZeFpFbUcwbElLMjU4a3Jl?=
 =?utf-8?B?UFlydnJoNmdwSkJzeUcrdUhWeGlCdzdrS0x1VGZBSDAxdDVBNWdib0o2blBN?=
 =?utf-8?B?YThQZ2Qwd0puVWtmcG5uNDRVN044ZTNDTTY0QUw5WHhlZGtSR2FCR25LUkhP?=
 =?utf-8?B?djRnVlo4RGFkNlM0eHJ5emdRSTNDMGF2aHVUNkpBMmNnSUtwVWRxdz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f7b521-3840-4453-7135-08df025b4673
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 03:45:15.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56TzYr/IqblwqjirjFysDGaXdxw4CbN+amR/Ksa2/8vEhi+BY0aECO7vIgo1NFZH8tnlKXqZ1392ttMZ5CVavA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8967



On 8/24/2026 9:31 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>> new file mode 100644
>> index 000000000000..d5674cad0017
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>> @@ -0,0 +1,93 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include "btf_module_names.skel.h"
>> +
>> +static void btf_module_names_load(void)
>> +{
>> +	struct btf_module_names *skel = NULL;
>> +	int ret;
>> +	static const char *mod_names[] = { "bpf_testmod" };
>> +
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +		.btf_module_names = mod_names,
>> +		.nr_btf_module_names = 1,
>> +	);
>> +
>> +	skel = btf_module_names__open_opts(&opts);
>> +	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
>> +		goto out;
>> +
>> +	ret = btf_module_names__load(skel);
>> +	ASSERT_OK(ret, "btf_module_names__load");
> 
> The three subtests (btf_module_names_load, btf_module_names_skip, and
> btf_module_names_empty) leave the input-validation paths from the
> preceding commit completely unexercised.
> 
> That commit adds checks in bpf_object_init_btf_module_names() that are
> documented in libbpf.h as part of the API contract, particularly:
> "The list must not contain duplicate entries; otherwise -EINVAL is
> returned."
> 
> Uncovered paths in bpf_object_init_btf_module_names():
> - Empty or NULL entry detection (if (!names[i] || !names[i][0]))
> - Duplicate name detection (the for loop with strcmp checking all
>   previous entries)
> - Error cleanup path (err_out:) that calls
>   bpf_object_free_btf_module_names() after partial strdup() walk
> 
> Would it make sense to add subtests covering these validation paths? A
> single extra __open_opts() call checked with ASSERT_ERR_PTR() or
> ASSERT_NULL() would exercise each. The duplicate-detection loop is
> non-trivial enough to deserve one.
> 
> Also, nothing in the series asserts the default btf_module_names == NULL
> case (load everything, unchanged behaviour), so a regression that makes
> the option mandatory would pass undetected.
> 

Yes, I may have missed some scenarios. I'll add a simple subtest
using __open_opts() to cover these invalid cases. Thanks.

>> +out:
>> +	btf_module_names__destroy(skel);
>> +}
>> +
>> +/*
>> + * Verify that an unrequested module BTF is skipped. The BPF program
>> + * requires the BTF of bpf_testmod, but bpf_testmod is not specified in
>> + * btf_module_names, so its BTF is skipped and the BPF program fails to load.
>> + */
>> +static void btf_module_names_skip(void)
>> +{
>> +	struct btf_module_names *skel = NULL;
>> +	int ret;
>> +	static const char *mod_names[] = { "module_nonexist" };
>> +
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +		.btf_module_names = mod_names,
>> +		.nr_btf_module_names = 1,
>> +	);
>> +
>> +	skel = btf_module_names__open_opts(&opts);
>> +	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
>> +		goto out;
>> +
>> +	ret = btf_module_names__load(skel);
>> +	ASSERT_ERR(ret, "btf_module_names__load");
> 
> A subsystem pattern flags this as potentially concerning: both negative
> subtests assert only that the load failed, not the specific reason why.
> ASSERT_ERR expands to check ___res < 0, so btf_module_names_skip() and
> btf_module_names_empty() pass for any negative return from
> btf_module_names__load().
> 
> The intended error is specific: with bpf_testmod's BTF filtered out,
> find_kernel_btf_id() walks obj->btf_modules and falls through to return
> -ESRCH, which bpf_object_load() propagates to __load(). Asserting that
> value (for example, ASSERT_EQ(ret, -ESRCH, ...)) would pin the
> behaviour.
> 
> As written, several unrelated conditions make both subtests report
> success while proving nothing about the new filter:
> 
> - CONFIG_DEBUG_INFO_BTF_MODULES=n: bpf_testmod loads (so env.has_testmod
>   is true and the test is not skipped) but has no BTF at all.
>   Attach-target resolution then fails regardless of btf_module_names, so
>   both negative subtests pass vacuously.
> 
> - Unprivileged/EPERM: load_module_btfs() returns 0 early without loading
>   any module BTF (pr_debug skipping message), again yielding -ESRCH from
>   an unrelated cause.
> 
> - Any future validation of the new opts that rejects the list at load
>   time rather than at open time.
> 
> Would pinning the expected -ESRCH value make these subtests more robust?
> 

This is a good point. I'll check the expected -ESRCH error explicitly
in the negative subtests to make the tests more robust.

>> +
>> +out:
>> +	btf_module_names__destroy(skel);
>> +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32730521630

