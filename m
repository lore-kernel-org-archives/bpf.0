Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013033.outbound.protection.outlook.com [40.107.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703D1C5D72
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787195997; cv=fail; b=DOjh2hHfkxrwjrhrN64vgBG8yFCK7NXaJ9S5Lzsgm6sUS24L9GgeqVAapFfRgo8W76amjwOW8CllIt/UQ6aSDsp9i6CM3Ao4pm+aAqZ/KippSI6g2YNf16H3iKfNxISsMmL/6MltAw0Dn2s/JAhzJUSa1qzgWzT6HZBxTNLnoLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787195997; c=relaxed/simple;
	bh=Q61efY7/F6DpaSoKIa//B7/rp+98+VrS7hCqdolopW0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q237moUnvMgC1FjBStU5y9Rs3m6rTTplJXXBqGkmt6M0iyU/uXfLvNhwU2cotkYjNjCXnnbNwiksCCOEzLz3LhDWLJe4lvFZhWrgUB65gwXqsyD5H8uc5iRaOnaKmsqWW2SSZPsIRPwzVbaZXfgySZWkiKLCASNjh8OAbF91pXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ohM2Q6vc; arc=fail smtp.client-ip=40.107.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ohM2Q6vc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6xPJXDIz8m6jAzdXqHNpKyGOtpfcvMSEE28DBBx7hI0JhkZyWyZb5s/xsvFQZk0KwEYHIe8nG6kL6++NfSO9x1x1/TFBDh79lK17mqnRa1UcTh8+9m4vYFJC/s/nzIclS8b+KCrpp3tJ2DfId2LEhE/KiFajGc6Z6B1F9hOh3zXXEUV34wEzuVmCAf/dRNJp8bEvtjoKkmfBh9tjKshKUR+sTlIQDE2ovZ5KxCG9v2VhtYRT801riJhYZ3FGFbfaIdJZwHWEJ9OE8ni9SDx1XsKoL41Jmy3bJGSMinrDmHhxqbiwoszkqdf9bxL+VeC7Ohx0YGhwsi5wo2oWZbF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gI2kSjV/g+W5H9v+dNhY1Zom3z3YqWc0iFJhHZ7gB0=;
 b=tNLlP2KWXpFYAAnY8jN8XHsG7ZFzvAtB9Nn4R/6eqdHhNJg/DjqGGkroluztS5XPnFHn9vbv/zxqHO25YW1dEdiU1T4JVfTiGZTcOsw2ZK7jyGGFst4CGoNIR+QuzKs7bMntezkTDhf5zqYEEbP4jkE8hLEl7oa17miE6ACwX5yyTtdBxAWh7IDxrqvfCtN96fQkOGk9YKP9H+R/lrDL8oXRAYazBxYm+7scgz2Sx1bkv10IEQ6vjlvCYqJpJr+gv/lDaudje0adRGk978AyP+ROhhUhfxmbTFLFrWs4t97lUDMDn4RHRjobkqtD8hNDLMJ5d7ZhT4iR9xg2VDNHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gI2kSjV/g+W5H9v+dNhY1Zom3z3YqWc0iFJhHZ7gB0=;
 b=ohM2Q6vcKZMLaBVn3zhSzEYrd+oT6Nkc5YghuhS91VwJfgDP3N1t7KxSK/8t7dpdQZaVa4EOIhtY5b03E9b/TZ8jJ5rGLXaWCzmNsAMz3lyT7J6Qauu0WlWsD2WeWEne8MbhRFVcFeaiiv/t9490iF7nop8SAtnCQKm8+mL+UGsgCrIJJa8AE/gSIg9NvuxHkntB+P3k9c0cKLlEooNZyGx3noTDr5LPP1QXBv0ECjHFuZKQLFDUV3kPrCq7xrP9gQpEcFRHX8RhLmrUdJOFfL0FfrM74GC80nLNH/FJwmplncWeTPL2Pq3gt6qyyVFQx6JEm1OWPhoXXzIUe6oUxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYSPR06MB7308.apcprd06.prod.outlook.com (2603:1096:405:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 03:19:51 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 03:19:51 +0000
Message-ID: <5cae2afc-35e7-404c-b943-6ed7cfc4c71d@vivo.com>
Date: Thu, 20 Aug 2026 11:19:48 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel
 module BTF loading via bpf_object_open_opts
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260819090426.267-1-zhaofuyu@vivo.com>
 <20260819090426.267-2-zhaofuyu@vivo.com>
 <20260819091250.76CAD1F000E9@smtp.kernel.org>
In-Reply-To: <20260819091250.76CAD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYSPR06MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: cadde8c1-838c-4bc0-d8aa-08defe69e586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/EgpXbFEUlUEUz9rLGTge65j3iqqMEqs7ckEZeNW7FxdrToktiWVaq9zdF0luHGtFpSPvnnIqAprcyfMyX736ztLeHuEEwzFUbL3YvuyxB2EI96uup1asLEaemfJLdgC1qmv4ucoNlSgXNBHsM1EhOxGZ3ncybd9X0Njl74fbMMLQ9KZrNHz5HpUVXZjTryGPB79dKOD3tsA/oBLV6qncS9mQixMt1Sx3nFuzhdiN2ysREStdviiAP1JSGiqcZ7Vegu/nXOHhAfxSsjGpgu/po+YDMAe9P38UHzQrkdzifYi99qFwbmJpNHaAiynxyBxebaYq+OL3xmIyJ4Mg1qqTa3vtGzQlVRqgjR/4Wl2HJqNuAj8HzWzbA/c7RtsmhbCLgEB8iUHKcGzdPd0tDkVoXHEGh8p7YVxRqkR+JUCI7zgKVaM2lg5GHzr/Mui+2Ro70ypfJcXFxGatZGBZG/w2BoLtEPg5KbB7GxJG2ZaBfDkFGSIW+hdGJ6PwbiNZwDqXK5pzTJv6nlt+a8M8lZuP1B5Dsf2cqfLEeMIlvAyApmPvRui7xOk5VZ5Ki18OZt80HkBldIH0NX4X9nwcKq0FEIKkfBfxLtsuCb2LPJL2rOY11k2lXVtnk35TKLRGmCksBQQsaOhGS5e/vhuQnde9WIZK+pqH0PVF0Gk4pEExNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czBhNzNqQ2RSMU1vVzd4UG83MXc4QytoYXVyc3RDRXV2Zld3bExGOVlUbVB5?=
 =?utf-8?B?UEFKKytuL1JGdlloMkNMZTVGc28rZkgyYXR5MmcrSldGL3VQSmhwc0lHNGdh?=
 =?utf-8?B?MGN6VG4ycVpHbzJ0b2NlbnI4NmkyREszQXR6dzZnRWUxOEdaWEZIMWlDUk1G?=
 =?utf-8?B?clR2UDRJdWdqTjNQZGFaTXcrVVVRbjZzK0N5U0tIVmcvSUM5d3VoYktYRlJH?=
 =?utf-8?B?V3pPdXJTRUVZSFFNdHRTQkpQczFRbko1SklEbXVMb2R1Y0diMG9zRTc4Rld3?=
 =?utf-8?B?QTFuMnhZSlN1cnI1SllPVVRaNC9GOUZ0SkhZZDl6aElOVGYzM2Z4WWtEelU2?=
 =?utf-8?B?eWVNTHRsOEcrMVFNR00xejVVWi80bndpZmxPS2JaQUNjTTFUWTdNcENNeWlW?=
 =?utf-8?B?K0RuLzdBYXdBL0U2cFUySGx3elJHQVFnblBwemlZRm5ERjZZUDV5NjBPY2Fk?=
 =?utf-8?B?RmVyZlo1d2xzTzczcXJtMTg3dEM4L3hkZG1XVnVySnNjam1OQ256c1VZakxT?=
 =?utf-8?B?ZEk0ZE91NmxoVjk2VGdKNWtIOTczWVNZanAzMC9GUzZjSTM1QzhyTC9MNnFW?=
 =?utf-8?B?aURLRzc2QXhpWCt5MG1XenpGOFdENDZiZEdWWlJYSG9tRHdaL3JFeXhxc1lV?=
 =?utf-8?B?N3c5c2gzOFlOTjNVTkxrQm9KNnFXWU91dDcxNi8ycDA5b0lrdWNiMEVYSi9k?=
 =?utf-8?B?ZVdKWlJhUEczbUJNQXNLeUFIbmNCTDVIWDZrUlBEWDlzbUhzWEYzeEZEdDk1?=
 =?utf-8?B?YmFaamFCWE1ueXdXako3Vm9mOEpGN3Z2RHpoS2wrSXBtY2NwckZGTE16dmZr?=
 =?utf-8?B?K1NDRFhMbzU4emp5ZS9zSGFxRmJyL3lZOUM4NzVxUlE4ZXpySlFyQlJMa3lt?=
 =?utf-8?B?RzI0aUgvcDBNMzZxd3hiblE1VzloQzlzSzlOK3J4aXVJQnBPQ1V5Q2dVTkhy?=
 =?utf-8?B?b0krRFlwcHI2K05HVDJjc0VoRXFGa0Zwb1luTUI5SjFCMm02L3VzN1BjV1Ey?=
 =?utf-8?B?S2ZES000OHp1Y1Z2ZlhvYU5aUTlJd3R6Ukp1TFdpdk5xMjVqVHZsamZtczAx?=
 =?utf-8?B?bmQ3S2FNYnMweFp5cGNtZTlNalJpR2FoYUswaXdhVjUyN1pxUnNseFhJalV4?=
 =?utf-8?B?dFBFVWV2OUdmM3RreTg2ZGVsbllmVDVuVk0zdXJVWUVzVjNEdGZVUEQ2YWlN?=
 =?utf-8?B?bFBmSnNoRUN2ejBMYWd1QlpGT2dzUitubnhPd2doQTM3Q0VrdE9mTHJrdk9v?=
 =?utf-8?B?bHRWR09UUDA2TlJXZ1BpYTJaQlJaRmN3SXlkUGE3KzMzcEh3N3ZDbEhEV3Ju?=
 =?utf-8?B?WnJBOFNhVXJobW5DeDNmUlBaTCtLbk85TDM2dnJ5ektnTC80VjV1NHZkVERo?=
 =?utf-8?B?VFZLOWZmWTB5RDV5NzNvUEI4ZmMrZURPOURVUnhiR25SUFVMM0FzaENVdFZF?=
 =?utf-8?B?cko0RURFVGpYeDdzekFqd1VlV0pJNG0yMUFvUWsySWEyb0x3Z3Q2ZlVxT3Y0?=
 =?utf-8?B?MVUrU1ZFVjNvWnljaVRtVkR2eFgyekJHWEM0VUkwWnQra0E1Ti9KNEFOeUhD?=
 =?utf-8?B?RUp0bW84T1d3Y2xoTkxWVUNzSW5sSVhBRVpaR3RndUZ3RGViZFpwSUw3bUlo?=
 =?utf-8?B?MWt3WDBpVjFzUHMwemxoL2FyZHFwa0hZeGhSNEtadlFBeFBrazlIR3FzNjNa?=
 =?utf-8?B?Q3ZIUUR0VG5tdjd1Z0NmU1Mxa2R2NGNTRnN2S1AyOTRJSDMzOGhEcCs1T0hn?=
 =?utf-8?B?NVFSZlZibTdXcmZURWdNaVQxZEFJSWF3b3FGeWlQL3l6N1BvbEFKeGROUlp0?=
 =?utf-8?B?Zjk4em5DK2N1RjRkdEJtd1o5N3hocW4zZmNWUHpQOEFPbW1Yb3VScFJTSjNU?=
 =?utf-8?B?Wk1XYXJySmh1VGhIL0xLc0tmYVZLQnRsU0IremhxdmxlTWgvaFZ2bWhkSUVF?=
 =?utf-8?B?aWZwVGRIUG1QRHRVUk00alJkZ04zbE1WNjFSTGJ5VDdHSWdsVnd3dW44Y3k5?=
 =?utf-8?B?bHBKL1FEL2tZeCt4MUVJN29RTGE5Q0k1enROM2RmVHBJeFp6ZnpIN2VQVDRt?=
 =?utf-8?B?MUdjUTN5SkNsekpLQjFrVEpVcXlKMmNnSHNVa2pEbjd4TmcvaFlwZnNMc0Jt?=
 =?utf-8?B?T0R0bUl5czlpMHMyMWJVSHZZd2o0YlZiOERDTG9qNVQwRUtJamZHNDVpa25v?=
 =?utf-8?B?TEFQLzZieHdoNURyaEI4NmxIT2RDRFc4QW9ZNnprNTA3ZFJWelRmanlmVE9X?=
 =?utf-8?B?SERCaDd0WnZtSFFQc00vV3dwOEhGT2pNTXdHVDlNUFhVNGIyK08yUGFEaEkx?=
 =?utf-8?B?UTNleXBRQ3Y1K1RrQ2g2MXpUdTdQWVUxRXFHSXlGbjROVkwyM3kwQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadde8c1-838c-4bc0-d8aa-08defe69e586
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 03:19:51.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMW7/wmUzuyhXLnUErwbXLG0ZM9BOrlzxjOUdivvoxhXBbg8x7DTZZbmo+fW92hUQBdRRBkYhjBFTQQ0hNdPzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7308



On 8/19/2026 5:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Premature loop termination in load_module_btfs when kernel contains multiple BTF objects for the same module.
> - [Low] API design prevents users from explicitly skipping all kernel module BTFs without providing a dummy name.
> --
> 
> --- Patch [1]: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts ---
> commit 627a7f9dbb55055d6c4d1331859084b6d2f56792
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> libbpf: support selective kernel module BTF loading via bpf_object_open_opts
> 
> Add kmod_btf_names and kmod_btf_names_cnt fields to bpf_object_open_opts
> to support selective kernel module BTF loading. This allows libbpf to
> load only specified module BTFs and skip others.
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b749c01742ee0..957415341caf1 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -5851,6 +5858,121 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>  	return 0;
>>  }
> 
> [ ... ]
> 
>> +static int bpf_object__init_kmod_btfs(struct bpf_object *obj,
>> +				      const struct bpf_object_open_opts *opts)
>> +{
>> +	const char **kmod_btf_names;
>> +	size_t i, kmod_btf_names_cnt;
>> +	int err;
>> +
>> +	kmod_btf_names = OPTS_GET(opts, kmod_btf_names, NULL);
>> +	if (!kmod_btf_names)
>> +		return 0;
>> +
>> +	kmod_btf_names_cnt = OPTS_GET(opts, kmod_btf_names_cnt, 0);
>> +	if (!kmod_btf_names_cnt) {
>> +		pr_warn("kmod_btf_names_cnt must be set when kmod_btf_names is provided\n");
>> +		return -EINVAL;
>> +	}
> 
> [Severity: Low]
> If a user wants to optimize BPF object loading by skipping all module BTFs
> (for instance, when only vmlinux BTF is needed), setting kmod_btf_names to NULL
> falls back to the default behavior of loading all modules, but providing a
> valid pointer with kmod_btf_names_cnt = 0 returns -EINVAL.
> 
> Does this API design force users to allocate and pass a dummy module name just
> to skip loading module BTFs entirely?
> 

The API is not intended to explicitly skip all module BTF loading.

A NULL kmod_btf_names means no module filter is specified, so libbpf
preserves the existing behavior.

When kmod_btf_names is provided, kmod_btf_names_cnt must specify the
number of entries. A non-NULL list with a zero count is therefore treated
as invalid API usage, rather than a request to skip all module BTFs.

>> +
>> +	obj->kmod_btfs = calloc(1, sizeof(*obj->kmod_btfs));
> 
> [ ... ]
> 
>> +static bool all_needed_kmod_btfs_loaded(const struct bpf_object *obj)
>> +{
>> +	return obj->kmod_btfs &&
>> +	       obj->kmod_btfs->nr_names > 0 &&
>> +	       obj->kmod_btfs->nr_names == obj->btf_module_cnt;
>> +}
> 
> [Severity: Medium]
> If a kernel module is unloaded but its BTF object is kept alive by an open file
> descriptor, and the module is then reloaded, the kernel will contain multiple
> BTF objects with the same module name.
> 
> Because btf_module_cnt increments for every loaded BTF object, but nr_names
> tracks the number of unique requested module names, can duplicate BTF objects
> inflate btf_module_cnt?
> 
> If a user requests BTFs for multiple modules via kmod_btf_names, would this
> condition evaluate to true prematurely and skip the remaining requested modules?
> 

I don't think this can cause premature termination. `load_module_btfs()`
iterates BTFs in ascending ID order, so a reloaded module gets a higher
BTF ID and is encountered later. We stop as soon as all requested module
BTFs are loaded, before reaching such duplicate BTFs.

>> +
>>  static int load_module_btfs(struct bpf_object *obj)
>>  {
> 
> [ ... ]
> 
>> @@ -5939,6 +6066,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>  			break;
>>  		}
>>  		obj->btf_module_cnt++;
>> +
>> +		if (all_needed_kmod_btfs_loaded(obj))
>> +			break;
>>  	}
>>  
>>  	if (err) {
> 

