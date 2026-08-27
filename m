Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733B242D6B
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787801181; cv=fail; b=dRnd11fIRmdRaK02Cp0tSdYUDBBkh6RMnle+FqrIC2C826HcP57bj4LZKbTXUSLgt5dyJeNBmo73neZtB0oA/4LmH2zxsL9zKRXMERL2X6KZJoYdhzZBtGYc0ah6IxhjG5ar79G8Lsg4xPQVgmiWgUOseu9dncJFMdfndz3E45c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787801181; c=relaxed/simple;
	bh=YipXabHQ+HjIwgmI8flmfVsSIC4FIl/1PtICC5vsvPc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pUY0Ca0riCUmHDG6QjvPt52/YxW3yd+b6y2mc8EzOoAJQIt5qogUojsLNUi8jtqqcfEN5bC+3LZl7yVKAZOcBzBFPcmNOfMZzX/vdMGonHRkHWKf4j7RWM8RVnYjIZGgpgj9xjssvAU/FTG5vHom4V24mcLkA1VwG99aKjinxjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Yk7FhGw+; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Yk7FhGw+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNOaD3D1DW3PsbysAhNTx7z6cEYuz9kx1xH8pmHLT8Rr5XtW5k7FCAynVqJ6JLxm71wX3L8ZiXytlAtgMapRZAKwVkjAyGvzgnBOHQm5QEG+LGPm4nNEXgxDt8TZKoIFkfIhNQF2EaU5fj8lLupEo+ieH4eEV1WNKfeTXxMBj7kXr10kNZBVqC7wuSlRZabYl9iQ0v90T1yviT0zIhHMcOxpndFKaW0hdehtkt95s5udjMU3sTRas47qoV0jFTj28joCLU2DjUznGlTGqidCLbWTbrUagkarJH1T2PYYApui5Dvki11Lmj4QdX6GTZA99Mca9UWGz/olSz1U/Yc6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfJpv/8KQzL46tfpTlMb5iYqhMilyTAXAReEcattt78=;
 b=lmGnVEwQIXJuN8lYElfNcXESL/gkXl0HCeOiu64djEsFNHql19xCGccbP/AQGDvslTr7FEh3uMtteNQgW58QPU7IE9X51FZ84msUnqOfwDfE6DP7nGy2cawzx6Um99IBczDHKQO3Yp2K84ZEAld7gyWypowbdP9CBqTOQMKdEHQn0fS9DHkTExWIh7RtEc7GTxq3ag5GmrzNn5GDlMLR1eiV1M6gloZ4o/AHBlIFoUARlbCSYo9o5Bbn5r5oPcXmxFSzzMIp+0yHqvDY7NS39WDBXIR6CkCrZSk/z4bZLI4Jk1nbueoPGekKOaHhQkRWQiyJ6P+x6M6m2Xl10Iomvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfJpv/8KQzL46tfpTlMb5iYqhMilyTAXAReEcattt78=;
 b=Yk7FhGw+laHkjft3fjMieK73SFcuQ/jSvgFH9RQ4jtOoUVpuYzp2ZN96vQkEdTIVoDUuhRmlBJxwBeOSJtjvfQlB16e2YgD3qPNvD11tyNCdXTDCv01QG95herft6PzCL/bIcXvOfad5sPMCOmo0HcbzG0WBk3bB3FpCpzrQhxbdhQVLsXXsxo6Y46FY9lyvHtXcXW6xQKQRLikSkmiMHN/xJ8Lk5pmHK+I9m4ehRJnF2pWL9yGUVMB7SQ7QjBTCwiJDVXdW323Uqf4oM/lIeTiAMdDUeXL8snUQM8gG3vmAlKITzcDsYopZDA1ZriKdTTWCPfupadQE1wnicES9mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by JH0PR06MB6601.apcprd06.prod.outlook.com (2603:1096:990:30::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 03:26:14 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 03:26:13 +0000
Message-ID: <af12430c-0e3e-4dd2-98b0-ba85fd05b822@vivo.com>
Date: Thu, 27 Aug 2026 11:26:09 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: bot+bpf-ci@kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com,
 alan.maguire@oracle.com
Cc: bpf@vger.kernel.org
References: <20260826131428.302-3-zhaofuyu@vivo.com>
 <e95579f6ec8d261f3a4303a5ca9e7111bde07ef2ee3fa48e487c1d33cbe3c3d6@mail.kernel.org>
In-Reply-To: <e95579f6ec8d261f3a4303a5ca9e7111bde07ef2ee3fa48e487c1d33cbe3c3d6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0210.apcprd04.prod.outlook.com
 (2603:1096:4:187::7) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|JH0PR06MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdedf4d-0907-407f-a123-08df03eaf210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|4143699003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zAfsAJeAXLCiLGlZfzzM/m1XPNlnJwWJSheNimBmRcrIXPdvn++jgT3NQiRup+hXjMM2MUo6BArym7eg9Mdir/DXPLPw1bfkChoH60ZGESDEDFVnWPuoyiDgjz3C6AVWuAdHN9rAVH7/+SMHkGvZfjvvPR3ASnZz7reMIMkBoXknHy28aLxrYFg/FYQSIRPEsRRj95ZqbvIKIYL4yDP1BkLW5CbqncD4euN0jRR4lThNy9cb/hnSfBZ8sNHD3yC1PE+3fujixhp9jKfu228IOaI4U4agmpu2PuBPq9zXOhvqC2PGTgwv6Q60G6F6RgIAHoHGkooWMsQLqTfKawkiLowQ6yvKHCS53wJ6KU4v25CBniO7VM+CKcQYFsxaT0ws1Qxs53cDuFBf+4ULQqKNkY1dGo+G7cYjr24glaT+aBHiHaXJesLsjizTPF56tl6vk8orFehPpNIRy9EEPbpvMso5tprpcUtfcg8NT53SXUeMYfaNJRAZojWxIZNeRss2lAEPMGxLp41DBN3TJG7YTL7p0sUQ9or4h56CvdfuWGiDW4uWG+iOEWdDNn/DhfghMGWzRWjUTgc28jminq3wX9x3AVVJ9eL2EdLgvDF3C1JuyjNbS5D5KmzAItXL9+Zi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXBwRE1uMytIU3p2M29XL3YzNG9HaERaeUpERlFPUVF6S0VuYi83OThqekJo?=
 =?utf-8?B?OVpHeUl4SjRNVWdIYnV6OVMvT3NZbnhjTkh3UkIvNXhMUWxZU3ZjNjZtcW1l?=
 =?utf-8?B?anlwc2MzdTBrd0xPa0h4L3YrbFlaTWZFNnpJNGJ5U3YrQ1ZEVEdFQXNkMDNh?=
 =?utf-8?B?U0Y0UWh4bXE0OVVKMi9oaEIzTDZ5Z0ptbzBiQWtMQWxhNzM4dzFBbEdjM0p1?=
 =?utf-8?B?dm5JUnlYRzJNTGwwN1NQdi9iSDI3VFJqZm1tUUJqS3BPMlFxT1FxMVcySG0x?=
 =?utf-8?B?bElrdEhhWHJZMWx2ZCs3RERqMjlQbnByZGEwNTJzcnY5SE82L2JQSzB5UXMv?=
 =?utf-8?B?T0ZFeTZjMjhhb3JieWFrZWdHWUZSZDhOWHY2RE56VzlWalZZWVY3eHhTOWU1?=
 =?utf-8?B?RGo0U0VOeEYySTJPSlpFZUVwa0gySEpwZmVUeFdqeTJkQk9BcXNlYml2bTVU?=
 =?utf-8?B?ZnpBL0ZRb1c4Q1B2S0Q4SDZxT0FOQURSRHc1cytKa3FGZVR4REFaUlYwOWN4?=
 =?utf-8?B?Z1ZqSWJiWUxNSk1YN0pMR3BKNlVaWElLN0MrVUE5b2VObGFrZmhKUjdvQnRy?=
 =?utf-8?B?TVZuVXhOUEhiZHgyMTZFck5nYThXSjl1TmRUTENMQktNOHhueFM4TGFwbWV0?=
 =?utf-8?B?ZjlHKzVXSWtMZU9hM0c2ZkpDU2dkS3RnUzlmQzhlazlvQnFlN2ljVHdtNVl1?=
 =?utf-8?B?ODJoN29vTnBWRVJxTlNCYzhMRncvZUhUeUJaSVUyZ0pvK29Jb1BFOHlXRDlu?=
 =?utf-8?B?dWhVQTRyTGtmSkw3RkFSSnhqZEVZekpIUGg5MUx4bzRLNUFUZ2lFby9VMWEx?=
 =?utf-8?B?S1RkamR1M2tWeUoycWp2eWxFTWNtMzd2c3QxNUZqVlVONkFwcHlFbWg1NzFm?=
 =?utf-8?B?L1hHc1dTaFFGbnVrVDZHMUhGdHBFWGtjcW5NVkhLNWxmM2FqMjVzM0JKdEdy?=
 =?utf-8?B?UW13RTBYVXFFbkJ6b08wNkFoYVBuRW9yY2lkQWVrckRzNjFyTTV0ZUkvYlpw?=
 =?utf-8?B?elNaQ0dTdzE5dmVWYWZkbnR4c0owOXZneDNqYkpRM3lwWTZ1T01Xb3NOZzNt?=
 =?utf-8?B?OFF1dVRYZUY1WXhDYnZsNDZCSng3aTFGMGpSS0NKd2xRVzJVbHhWSTlPTzFP?=
 =?utf-8?B?OWJxU2JCMTgrMGY1MXRmWjNhVDlMVk9sd0I3WUNZdmNsd0wzWkVRbHhLWm9M?=
 =?utf-8?B?SUt4cHY3WlpCSThadjFKbW9jN0g4WE95Q09MRnU5SmhiUUVJaVg4dVdSZTZS?=
 =?utf-8?B?QlE5c0Jnenh0MHd3eXI4VzYrbWtobFVSY3NVcExrZURVMWJ2T0VVTTJwam5q?=
 =?utf-8?B?TUluYnlTaVMwZkoyaUI0Rm95UDUvejNFYzdLM1VkVjVicmlHSGg5WXM4dTls?=
 =?utf-8?B?TFZzbnhWdmtmRWszSDhQY3hOelN3dnV5cGtnU04wa0ZmZUVtS1hNQW1CK1Nz?=
 =?utf-8?B?TDJCMWNTVTV3cWRKNExpWVIvVHU3M3pOU3NtdTVqWU0wdXdmOUJ6T0gwNXRJ?=
 =?utf-8?B?TFdHRGw5cFp0L2V4b2tUWW5qSXByS3N1L1hDTTI1bXpnZWVweDAyQ1haUXpE?=
 =?utf-8?B?dDhPbzRlTXMwdnJ4NzBkc0pJWDg5R1dET1JHQk9tYU9PVCswSUFhVGVhL2JJ?=
 =?utf-8?B?ZC9jV043Qjg5REFyZmJRV2NLdFZKK2pCMkRudHBLRlU4RGtJZnoyQWNCS2h5?=
 =?utf-8?B?RVVsNDVhSElLVzBBY2VyYVhJWTdOQmRqSEtqQnVPZWw1T1pjRlJTVjI3NFBw?=
 =?utf-8?B?QWluUTBjeUpZSzJSOXU3ckRUU09qUkhHZi83aHhLMDF0L2xQV0hMRTJpL3FT?=
 =?utf-8?B?RG5lbE92bXBTUlgyS3hHSnVRYXZqanQ2NXM2Qms1RWdJSTJHaDk5V0k0NEE5?=
 =?utf-8?B?d2ppT0lkY29OV0J3WXlsZFYwaHFPcE0va2c2SUtYV2d3dDFIMDgybld5WGhp?=
 =?utf-8?B?UklBUEcxc1pMTVBYTDRSZi9XQTAwdHdKdFBLeEw0U2xvc21IN0Z2QzJDOXFr?=
 =?utf-8?B?NXhJdGdHTHJNQ3E0ajVIL1lBZStlUXh4SzhsanREN1UyTFhyZmNKOEw2TkpK?=
 =?utf-8?B?NkVXTHd1RXZrSlRsbWdzbUdocE5kSzg4WUU5WkZDakt5RFpCNFBhYVFRTkRq?=
 =?utf-8?B?ZW1JUFNsSUhraVZhTzFoaFVmMFV2TkJNWGo2SU9jSFhJNndlQ1l1TnpHV0hV?=
 =?utf-8?B?MG9iNENKTXJyUXdtUGtRcEZuYjM4TDhEMVNteFFITzB0RkZCRUFHejkvMU1O?=
 =?utf-8?B?SG0xSDlPV0RpdHZ2K3BCSHVJTHhkbVc4Q1pqK1lrWEZVYjhnRTJWS2xmZlJh?=
 =?utf-8?B?WEt5SDFkNmdKdjNqMkhGTU12TnU5MTlCaXduc2hyNG9WR1g0SXFwQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdedf4d-0907-407f-a123-08df03eaf210
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 03:26:12.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bnfGLlbH1Q74gHBMlR+sLT+S8tSMwIeRKnmynOMJzmTmYhp2dQxQ5W86bnvI2zo+clnrT7NVNOWSeWctru6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6601



On 8/26/2026 10:13 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>> new file mode 100644
>> index 0000000000000..3dc72bef014c8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>> @@ -0,0 +1,139 @@
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
> 
> [ ... ]
> 
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
> 
> [ ... ]
> 
>> +static void btf_module_names_empty(void)
>> +{
>> +	struct btf_module_names *skel = NULL;
>> +	int ret;
>> +	static const char *mod_names[] = { "" };
>> +
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +		.btf_module_names = mod_names,
>> +	);
> 
> [ ... ]
> 
>> +static void btf_module_names_invalid(void)
>> +{
>> +	struct btf_module_names *skel = NULL;
>> +	const char *names[] = { NULL };
>> +	const char *empty_names[] = { "" };
>> +	const char *duplicate_names[] = {
>> +		"bpf_testmod", "bpf_testmod",
>> +	};
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +		.btf_module_names = names,
>> +		.nr_btf_module_names = 1,
>> +	);
> 
> This isn't a bug, but could the three static const char *mod_names[]
> declarations in btf_module_names_load(), btf_module_names_skip(), and
> btf_module_names_empty() just be automatic arrays, matching the non-static
> declarations in btf_module_names_invalid()? Since libbpf strdup()s the
> entries, the static storage doesn't add anything beyond inconsistency within
> this new file.
> 

This makes sense. The `static` qualifiers can be removed.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32974547426

