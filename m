Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012016.outbound.protection.outlook.com [40.107.75.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B032468C3D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622690; cv=fail; b=diIRxX6bCwBaHs9Zde9yayC0LjkYSzaW1ZRHyeq+K9nX0WlP/mk1ynt7EjbMgRs7mH5PTT+obDF0KlppEYgNavg/JQ87s97v1gChyIXp70Uel5e3CqDgH5vexzMoYaGQJZnyDd3YsDa8NfRULSamrjnWK14ewXq3wOHDjhZmQB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622690; c=relaxed/simple;
	bh=xGMxdIMvR1vMnsDB5cjdA3YcZBgoIlcXeZXaswh/bko=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJDnKU1W9JXPUEW56DqY/YaLTRmBjLfBUR8TzsnrmhHT0Qlatb0ybUIOuxfIPg6dEreL+e+u0OQJSLdXh/TLFzXwavGrdkfe0C7lwTnTivcgFXiN7KYu4GtIAYcRGkp/MHroW2Fy6/4BlxmiyppwfKxg8Kc4QYxyQ3ug9P6HXIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ePeveb13; arc=fail smtp.client-ip=40.107.75.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ePeveb13"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjCXz1ftF73yaJbSeInWiSQM5RSBBI4vs4BfdEi7q8gnAWOwlBC+VmNplgjt9pPr/U6xi/e4ayDNAXom+to0rQXooRGu7drmwniEBubNgGG7XmYcTbWV0bx5UGmW6H9UbLM7l3+g702232NXvydeKUTW2CpbB0yl8ikENM9I3WhEMD3dvIikb1jDDgnbkuOInEFlJX5B3/f4mJBsGqm+oCYKqv8TS2u/xFxUaNvXFak4QJ1YxGjaELa4Bk6WhGeTfx6T6NgYx8Xp/nUtqrLwx6apqEj0MLycVlTO/o2L6n4g4yV58S5CmE0CchH42z1kdB6VuLJBuuWwNHGS4HHPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tWknptWV3whV7NIAoYPnM6mUvBo4gfAeoQpxQEh0Lw=;
 b=qr6+sjVFq3Ky/+qMvm4FNHLBtccjxGYQ7wtn2DrcIpu4LS7qbS+RFun+aMB6q2Fj5iYrMx1CzzjRPg7xkrfLjzp9mIDR4q7hb+ppkqNtFjF+5dgZ7lS2P9o13/Hy6I7BwFEDFPg5DAh4RNxXyY3G34QADTnCeCP1HVA9/PAfri8FM7xgd8lAN+KkhKr+Ck4sn+aIv+DURWdjfYcu5N/1VjmR1Jta0woTrU3mWDbgvIkxfIx2DVTjQggH/XJQwCYhlCRvCUehgGieqsuY2VSVEyRxg83QO+pRXOg9xBIx2Hbh+gSsWIyTtffFzb4XdrHKt2xpCSLUS2FSYdzQ6qrlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tWknptWV3whV7NIAoYPnM6mUvBo4gfAeoQpxQEh0Lw=;
 b=ePeveb131cIlD3o/TSB3Jc21hR+xO5SMoZlLTwxQm1lM25gqCMg+5/EQveOzIKqCRX0kp+BLGPNWv/cD2vny5HsRiKVoBLotmwQkuc8wK5L8aOG/f934g8TmO16lFneFi4B09gD56GSkqbGHIgjxBRwMZmkgqUBsur73QUWw5RPNDxI0UsWepEs13TZrEAmhsPssxVFxTjpNtA+LOCXc/UE0e3wQX0K/YU/pKU+GEkQID/7MjR+KeYKtZBsD3QSHzrQwYpzrJ+EmwW86qjLnlSJxI8L6PAj+Hv1N3zaK61DdxgMV94ouJyp5BdtnPsV7TTK2r6saa9Ce4NeGvB8L7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by JH0PR06MB6655.apcprd06.prod.outlook.com (2603:1096:990:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:04:44 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 12:04:44 +0000
Message-ID: <8fd1a91a-cbad-4118-9972-fc0ec1098f7f@vivo.com>
Date: Thu, 13 Aug 2026 20:04:42 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel
 module BTF loading via .kmod_btfs section
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org
References: <20260813032613.2755-2-zhaofuyu@vivo.com>
 <f368863dfa10ec5402f0a45feaa11f6bcddccc87385a4dde88a8ce8b478598b1@mail.kernel.org>
In-Reply-To: <f368863dfa10ec5402f0a45feaa11f6bcddccc87385a4dde88a8ce8b478598b1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|JH0PR06MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ff0e9e-3a1d-4ea0-538d-08def933103d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	85vnXRKraZMBsF+PXRNnwHpvxMyiyeW5UlF9lln2XQzapze/TyL9EVRJqteOLq/ZcG/Ey9yzNw9y4m0mp49obFBnLcO8Qo8UUzDwEp5LMVp3ZpjddBOqbg2f7E1/oQPXqYwf2Tl2RvbGHGf890J0x3OuoQ97XfOPI2uVFGcOBj7WAXRbOk7HAiTKAuhgMPE0DLZ8MPJencDLUUVvZWm0SNXE05D00fXYoUPmUOLKnIC1tBQIQ/xL0OcJBG3ePnuZwNXWu21V4u8ZXIlIuAhPzDnmC2bKU3L9XRbZ3oDU44lzMJwpUjdCc4x3a4zzfr5pYTWJ1QwAfH/PmyzGhD+pscpMhUWFGgKVmyh5kacMruN7GbSm89BsZOEFtvDRrCZ3MfbTfO5aOxTPWoa594ASkjuHkgDGGkxoobf1RUeNpqYJYK5WA+ueyUJCfGYzaj2DFvoifkUIqgfQYS8zwlbcLqgYoVZ0najzgIaUQDa/TWevCwxMbLH3ylpGt5Hinb52n7x2WnXpAXFwFWlkBTW3eUpLXjWrKTTtyUCC4kSC4MbhjmVyIlNDrPQ/2cyb0LsZl32I3sxIf6bfWrDBAyd+aUp/fhgLcBzD6Ob3TQvQ7g5q2Pctxmah0WPbPOECRQz4rEl3GMrcXN7aonBU9Xe4Jnl2irtxKykukGH7FtnrahQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW4zMXRtWWJVVEExWGxaOGdXWVRQdzNRdEFuU2NpeVBBUEY1cHpqV1VaYTFT?=
 =?utf-8?B?S0toUTZyM3ZTajkyUnF0aTZzdjBCWkR3U1lZU3NodStaU09QVU44T21IdFZG?=
 =?utf-8?B?dnV1a0JaWWFEOXE0bjhwbGp1UUtvN1psSGFETndTVEpQWEw1YWRZeTVyOEtG?=
 =?utf-8?B?V0RsQTh1RGtPdEVrWjFXWU9nREdTSk90YTUwaUJ0enNabldEd3JqQkpNV2NU?=
 =?utf-8?B?WkdVYkdlNm1Nc1l3cmlsekNHMnI1aWQ2Tm1aK0VGRkdUNnJ0Slk3L2VFQVNh?=
 =?utf-8?B?TWM1b0RZbEhmQlo3Y1ZaaThxK205dnQ5ckxPZC9wNXBmcXE4dno0dTJRNzFt?=
 =?utf-8?B?N1lUUFgzSzRRSGlpaGczSTc1VXFXOHRIVkk4UkROWFV6T3BvYUpJWnVyODdE?=
 =?utf-8?B?blVQbEx3OUFWQXVuS2h2b1laYlF3Tjg3Z0I0RGtncWpFbmQ5N1hteW9jbWRh?=
 =?utf-8?B?RXhya0xQdjJaKzJzSWhTVEhPeGZPZHBhc0x3U3c0LzVVWE8zalpkKytUckpt?=
 =?utf-8?B?OHoydnljZWxITC9OMFlLY0RZM21YUDVnR2tQVk14NGt2a05Oa0pkdlBONnRZ?=
 =?utf-8?B?SjJBSVFhVW93eUdvbzZqb2ErYUNmTFI5OUplTzN2UlRkcng5QXc0Q0JZU2xu?=
 =?utf-8?B?a2ZOV2s0OTFNTG8zTFp0cHRYY05BMTRsOERuNGdjamtVWU9rR1NKWHk0MHRa?=
 =?utf-8?B?WlkrOG9naTJhalJ2TnRRR0VSOFl3TjVUR2RwOXk3NGlyZEcyeHJlc2gvQkcw?=
 =?utf-8?B?OU9ZZDhweVlHODBScHlFZkVPbENSUGNVdkFkS0loZDhFVkNPT1ZCVDd0Smxm?=
 =?utf-8?B?YkxzeDhyZHduZWRZaHZlUzZ4bERvZXoxdEVJdTBKN2IvWVVzMG4xTlZIbzVi?=
 =?utf-8?B?VS81VXdwRHllL1B5NDNLUGhqRkNRSmFDMnNZRjdaZ1ZPc09YR2lRL0R3eTA4?=
 =?utf-8?B?ckxDRWdESklGa3VZR3JHYm52UXR3TDNqTHBZSFRJQS9YdTRRREpsVTQyOTZF?=
 =?utf-8?B?aDczb3dzN1lCM3JTc1V2WktFdTliN1FJMmd2dEZVdUlvWWZPU2hKQ2QrNlBr?=
 =?utf-8?B?VmJwbnQrMDBPM0ZWQmFkQ3VOVU1xMDFuamhEMWs0TWhtVC91TDZETVBKZUxa?=
 =?utf-8?B?aTMwQ0d1OFpUMWFnNHlwbVVYellJa0p3Y0Y3Wk91OFBXQmdpOEpkQW8rZ09G?=
 =?utf-8?B?aHlqRHVEWDd3U2pxRkdwVU1XQ09lUllLREowR0hFSENIeVArZzFFUjUzaDFB?=
 =?utf-8?B?WmpLR3pWZDU1SnBHQ1B4aEFWa1pWOU4zQ2FVVXJsSUt4T244dTNibkRlZ3Av?=
 =?utf-8?B?b0lhSzBRbVJaZTQ3ayt3RjY2QlhYY0s1UVEvWklXaWxxQk1wYnpyUUdzVDNp?=
 =?utf-8?B?dlVMVzJ2WWxFYXE3NWI1azI1WjVzdHp2c0ZuRUxFd0p1SHl1ajVSbFNhbkJj?=
 =?utf-8?B?bGh3N29oVkE4NTVSeW1xUmZ4bDYxSUYvY1QrN2pZUFdqbDNpSHlUQWU3MHFE?=
 =?utf-8?B?TzcxclFRKzRxNXRJaHVBQ0RLSTNGVE9vTnVPNERtaFVma3I0bGlTMWlkOTFu?=
 =?utf-8?B?YVNNbzJzcHVoNGVGYWlZU0FJWWhMTkRuT3lVN0wrcnBMUXMxVWtoc3JUaXhF?=
 =?utf-8?B?dzUzalc3VGk1QUd2QzVLMjcySTVhcXdQNHVXV3FsL1FKNjRreUtBWGtubFNs?=
 =?utf-8?B?Z3J1MXZSeHJRWHdvQ3RyNmtRdFp4aTNMaEhWZldIRGZKQTBySkV6bVBtcCtR?=
 =?utf-8?B?U0E1OE5CS0F3QTIwTEpTZU1acXE2WWtYbGkvWG55U3Z6Mks4cG5PRzFwU0VY?=
 =?utf-8?B?a3NHOWlwdDdIL0E1Ymp0Z2xMemdCTmpKMk16K2dyS1VqRjNUeGQrS2hJeGNP?=
 =?utf-8?B?TnJUeW5FMGdCaHFKKzdXcEJuOFYrcVo1MmpGdUJkdnVlQUlPWU41MGRrUFl5?=
 =?utf-8?B?NU9wNGh6ODVhUTM5cEVLbTR0VkFQeis5aytJTUZlMG8zU0prZ0grNGF1eUl3?=
 =?utf-8?B?dmc3WHc5eU1jVWJzN2NyaC9RUEsvQ3luWmcxdW5sSU1qTlk1WmdUM2lYRm12?=
 =?utf-8?B?YlNiUlRoZU9HSTRhNW5mNHFtRWQyeHI3S1Y4S2J6V0pvQjZRQWlmOHI0ekNV?=
 =?utf-8?B?dDRmWnErblN4bkkrSDhSR3c3ZlFORG90cU00cTFCUXl5c3VGV1dyUGdXa1ZV?=
 =?utf-8?B?YkFhM1VsMTN1SW0ydmsvLzRvejJhUnR4Si9STnp1TURMRlU5aWgyRXhubjAr?=
 =?utf-8?B?am9aRTRxaXQ0UTVqSGFKM2JmSCtxaFk1QXpoUnNUTjV3L2RDTVlOWUpnbzA1?=
 =?utf-8?B?TVFUdG84dFdXV09aQnJkVGVXN2JPR3VnTXh0UENudzhteHREalRHdz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ff0e9e-3a1d-4ea0-538d-08def933103d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:04:44.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgFHZRWhpqHmF3YlybUnj5HANkrn5fdmD04jS6SJrBz4PplZpeFuzZANisPoBDPywXtpTlaFstt470u6R65bgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6655



On 8/13/2026 12:22 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index 9d160b5b9c0ee..171ea055cd323 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -188,6 +188,20 @@ enum libbpf_tristate {
>>  	TRI_MODULE = 2,
>>  };
>>
>> +/* Helper typedef for declaring kernel module names that need BTF loading.
>> + *
>> + * Usage: define an array in the ".kmod_btfs" ELF section to specify
>> + * which modules need BTF loading:
>> + *
>> + *   DEFINE_KMOD_BTFS(_needed_kmods)= { "module1", "module2", ... };
>> + *
>> + * This avoids unnecessary BTF loading and speeds up the BPF program
>> + * load process.
>> + */
>> +#define KMOD_NAME_LEN 64
>> +#define DEFINE_KMOD_BTFS(name) \
>> +	SEC(".kmod_btfs") char name[][KMOD_NAME_LEN]
> 
> KMOD_NAME_LEN establishes the on-disk record size for the .kmod_btfs section
> format, yet it's duplicated in two files with only a prose comment connecting
> them:
> 
>   tools/lib/bpf/bpf_helpers.h:201   #define KMOD_NAME_LEN 64
>   tools/lib/bpf/libbpf.c:707-708    /* Should match the definition in ... */
>                                     #define KMOD_NAME_LEN 64
> 
> If the two ever diverge, bpf_object__collect_kmod_btf_names() will silently
> mis-slice the section. The d_size % KMOD_NAME_LEN check only catches
> non-multiples, not a mismatch between the two values. Could this use a shared
> header or a static assert to ensure they stay in sync?
> 
> Also, the new macro has no #ifndef guard. This header is included by nearly
> every BPF program alongside vmlinux.h and user headers. Other unprefixed
> names this header exports (NULL at lines 78-80, KERNEL_VERSION at 82-84) all
> have #ifndef wrappers. Should KMOD_NAME_LEN follow that pattern?
> 

Thanks, I agree this is worth addressing. I'm not sure there is a
suitable shared header for this definition, and a static assertion
cannot directly ensure that the two definitions stay in sync. I'll keep
looking for a better solution. Suggestions are welcome.

>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa825..9fe8a653e8b6b 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -5803,6 +5888,11 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>  	return 0;
>>  }
>>
>> +static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
>> +{
>> +	return hashmap_find(obj->kmod_btfs->hashmap, (long)name, NULL);
>> +}
> 
> This calls the raw hashmap_find() with a manual (long) cast, rather than
> the hashmap__find() wrapper that hashmap.h provides:
> 
>   hashmap.h:159
>   #define hashmap__find(map, key, value) \
>       hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
> 
> The header comments at lines 50 and 54 say the intent is to use the wrapper
> ("behind auxiliary macros") so that the _Static_assert on the value pointer
> runs. Bypassing the macro also bypasses that check.
> 
> This is the only direct caller of the unversioned function in the whole
> library. The other function added by this same patch does use the wrapper
> (bpf_object__collect_kmod_btf_names at libbpf.c:964 uses hashmap__find), so
> the two halves of the change are inconsistent. Should this use the wrapper
> too?
> 
> [ ... ]
> 

Agreed. I'll use hashmap__find() here for consistency.

>> @@ -9030,6 +9130,12 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
>>  	/* clean up vmlinux BTF */
>>  	btf__free(obj->btf_vmlinux);
>>  	obj->btf_vmlinux = NULL;
>> +
>> +	if (obj->kmod_btfs) {
>> +		hashmap__free(obj->kmod_btfs->hashmap);
>> +		zfree(&obj->kmod_btfs->data);
>> +		zfree(&obj->kmod_btfs);
>> +	}
>>  }
> 
> The .kmod_btfs filter list is ELF open-time data, but it's freed from
> bpf_object_cleanup_btf(), which runs while the bpf_object is still alive and
> load_module_btfs() can still be called. The filter therefore stops applying
> part-way through the object's lifetime. Concrete path:
> 
>   bpf_object_load()                       libbpf.c:9182
>     ... -> bpf_object_post_load_cleanup() libbpf.c:9229
>              -> bpf_object_cleanup_btf()  libbpf.c:9147
>                   obj->btf_modules_loaded = false;   (libbpf.c:9128)
>                   zfree(&obj->kmod_btfs);            (libbpf.c:9137)
> 
>   bpf_program__attach_tracing_multi()     libbpf.c:12791
>     -> collect_func_ids_by_glob()         libbpf.c:12752
>          -> find_attach_module()          libbpf.c:7877
>               -> load_module_btfs()       libbpf.c:5896
> 
> At this second entry into load_module_btfs(), btf_modules_loaded is false so
> the full scan re-runs, but obj->kmod_btfs is NULL. The filter at
> libbpf.c:5960 is skipped and every module BTF in the system is loaded,
> exactly what the section is supposed to prevent. collect_func_ids_by_glob()
> also calls bpf_object_cleanup_btf(obj) unconditionally at its cleanup: label
> (libbpf.c:12786), so the list is destroyed again on every attach.
> 
> The other open-time members with the same lifetime (obj->jumptables_data,
> obj->arena_data, obj->kconfig) are freed in bpf_object__close()
> (libbpf.c:9720-9733), not in the BTF cleanup helper. Should obj->kmod_btfs
> be freed there instead?
> 

Thanks, this makes sense. I'll look into this more carefully and check
the appropriate lifetime for kmod_btfs.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31664172915

