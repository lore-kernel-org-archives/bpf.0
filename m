Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013037.outbound.protection.outlook.com [52.101.127.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832734A9D5E
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439971; cv=fail; b=ai0C+0BzmITlUIWfRXw58pwtmn4bIGJ23oBRkAoBX1pWsOZIGf5f23lnk1j9dADJNqzzXdGNDd6s71YjdUhbA+rubs83Tlsus37vGvaH8toqz9pycHekRw9cNY8wvVj5mcF7NJYOfLVftWJNgDBIVHxIGsT1lSwLXjgLZVagaBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439971; c=relaxed/simple;
	bh=YuDhJwGM8UoRyX6IeXgqGfMXBhTQMFLqNAD2xFzHPRI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vw7olq7h/9NJMI9f8tNLCQdM37CyWasXsYeY+wG3Mc12Sb+PT3ztZp4ravkhKTVC5SoERxWT8x9uWFnjD1lzqzQ8wfJdkwU2ffsJp5aetS8tO5016QI2oprCJINp69LP2O7Ewna0t4W5+ir0MAShuIAsQvYHk1KXjvtDPWMMdTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JxIS6hfQ; arc=fail smtp.client-ip=52.101.127.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JxIS6hfQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nItM2kbJU50UC6VhdFwJpHDrYm1lsy8z8JTVM1E7q2Oz2lkVU5uPDQujS9akMnoRLUfphG9nN1kmi0Bpf/N2bNo9wwXq0uzWg4v6nlSS/wT1ruwtqm2qviFDTNUEpDvmIkeUDX7sLWLyz55RHsDa5GdhQq6JJL647utgyLPN2ZkA+FnM8dK0WRLlkNzkFzCvkdhngKekM9WzLW598H8ksqRTc2jZrlbre8O9K40b6bLpQWO7zzbD2SVzAkcXVNMCeTXkXRIfiW8DprlE46I1TEIT2yE+rvb5Q9Fm02JxQqX+/rsB/y3fSepGQV7LxNBWYQC+YLiSzSmlTu+KdBa1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCB5cpWrJrmIZL1h+r0Gp+3+eb039rjZp5ph764fRf4=;
 b=XTnhn7L96dgYgEuUW/QEpU+kjKsAxVagVGonbDDCwpM91TGAeOCi3jgICxzToamNa01uvUKLFnT3xeRjq6GmG6lRs/WW57X1TDlxBtYft47qWNc79jZRM535VKvYX281KMxG5R+2mRUNnGNNhKSN2gVxwI+MfiD02kjgKzpk5ScrdXRBs7J6jxBT7HdtyWei/i8maqVd1MDEbJHbnnSfz7ao8/hRerl54XdLIlN7oiVL65/2k1pmWGV8XSS03VEQsfz71v6FB/UH5jsuGblmj6AfHVauVrATgkmMEuYzHkLQ/z9KknSsr7tge901+1jA0BCq3LcPtmE57o3xCaHL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCB5cpWrJrmIZL1h+r0Gp+3+eb039rjZp5ph764fRf4=;
 b=JxIS6hfQK61b+ZzLfHkIL6AHZZ+6tywFfmXg2PPzzOWtE0LyGJxQ+XL7+iXb++IcVuXAk3esSsEqAJdUlIv1+3ZZp8b23OIfC9JDRYsYz+ZJ6SVPOdO9uexqOe1/duLXOh7akymzjTfs7rUbDPGhMtLoXCYm32noUEg8NlmNag/NZvp5eQhv68tgShzKG2KtvVE95J6lo8YSpbQLIT6rwJkZGXhxejXVIGDZ07iAnnFJ4TLChoSnO3iFmLtvAbxWwo1xGyu2ONwWuejuV9Mul8rLBnV27QVj+YbrFEcFqzfbPRbMQBcRTGJ5vkhgZW3RSbmNn+Mf2lj0JXc7zSbDsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB5855.apcprd06.prod.outlook.com (2603:1096:101:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:52:43 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:52:43 +0000
Message-ID: <8506da55-e99b-4f23-93bb-e11229760917@vivo.com>
Date: Thu, 3 Sep 2026 20:52:39 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v6 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, alan.maguire@oracle.com
References: <20260831133809.1161-1-zhaofuyu@vivo.com>
 <20260831133809.1161-2-zhaofuyu@vivo.com>
 <CAEf4BzaHTTEob-vmhmcRt1pmED+eBBLWnehEDUk=t7O7GUyyFg@mail.gmail.com>
In-Reply-To: <CAEf4BzaHTTEob-vmhmcRt1pmED+eBBLWnehEDUk=t7O7GUyyFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2ca7de-702d-4d64-5f3d-08df09ba3e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|56012099006|10067099003|5023799004|11063799006|4143699003|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZVwv5/BCmaRirfkTYd5NUaA7TxV3sIFoXSdxQL5Y3NGgZxQzLU+scXIaGaArgCyz3RYSCVqYeF+94eOx3buxgcEXCQ5UCCPo2Rr53+o0KOGjOv3/m+oZpb7YuVlM9XeAPcLpEKNPyrEPPCtk5qjB/xZaaMo//LCk0YF/57C/mWDntIpb/TyFadLvW2n4rGcZOfBAa3Q/whAm9Li0xEryRtrgyMHozQ7EMdUB5KElh+BfjULGTLU3nOnIAK66lXP+tRy2fRkQsX+10Ee1nTF1C0KuJUuHajOxQV4nrElVUtVrGIwTBy52amVIs4qgxoBwKuUyMgY+VkpzAPN5CcReQoHEz31pNlXUa/X9jMHOqucXF5uOyMfNQz5r11THsVUiOc9DGw2V69njN/l+YpD9H3IHKDPmKs/VZgQidNHmI3f1r++3tVFZeFHkxQAiPtHH+1YKyoP/xQY6rf4rMhIycDb2CkxSmSmXsPUmoB+40QxHE1J9CGG2orRtkbRmc1/bBSLGvJZ/umG+gxSIieWIvH01aIoL/XQqZ3NFBSM5GjkS/v+XSfFNQhuaVihC2VAQo1l1FOCrGLsDXo/Rbu6cNwPEmTOUpKMoCs+rkywQqiKREb1pmBczHJ8G8uwSfmy0jOncIa997LXXOqM4l6urxtsfucYZJ+094+E88H4+BF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWpSRHE3SFdLaERmcHdoaHNvc3lVdFgvVTB6L2RiWFJzUUxYYWt4LzI0Tisx?=
 =?utf-8?B?YTA5TjBxbUl0YjhnODE5RmdWOXptZFZqbjg0TTJwNzR0aXh4dFIxaFBnU3RG?=
 =?utf-8?B?bVpwWWVhSncra1N0OE9VWUdzNy9tWWxiSEdJVjBRbldTNkczK25TU25nOVY4?=
 =?utf-8?B?SmtiVWNVTUpKOG5BWUg1R25tb0E4M1RsQk9jWVgzbzdrazZTVXNaSEVEbU5u?=
 =?utf-8?B?MWhkNDc5MG54WHFrSmM5a1BFOUV6c1ZpRGZaaTl6UmRpL3h2bk1ZS2xESVFk?=
 =?utf-8?B?VTFvQmFLYnc1U3FDMjNWQmdWYkpxUEdIZWZnWWdtVFBPWWFJN09MSGJwa0hH?=
 =?utf-8?B?UTVuRzdVQjVGZ1VJVFcyOVFRdUU2NHRqSThJak95OTRyZ1daMEdrNzJzYVBQ?=
 =?utf-8?B?TVhIcGdCeHRpbnFjak1KK1lIVEUwVFA5ME1LYXN0Vlkyd1VpaEdwM1duQUx0?=
 =?utf-8?B?RDNQNWVLbTk3RnFHZDByMlE4M2sycVQ2UzE4aWdxRnlUSUhlK2x0a0N3ZStR?=
 =?utf-8?B?RUtwZ1NkVTEzbVE2RDlUU0FaM3dtU05EMnIxdEJ3TlE0RUVnNHgvbjZMMkhm?=
 =?utf-8?B?aTUrRFdwTmRhVjJkOGdER2QvYWc5YXQ2VGVqa3h5ZEtiYnVvQTg1dk9BbFRx?=
 =?utf-8?B?UUoxT1VWdU5XZlhGT0VaL2Vtc1BkK0NQM0xYa0FqdDRTelhOT3d1VjFCNGlq?=
 =?utf-8?B?V1Q3Y3pZQUVTb3ZLWGEvNlh0bWZWWVN4VWUvcVJHMDBtakxmbWJHUmVKdEUx?=
 =?utf-8?B?K2Z1K3p2Y1hpSHBIQ0NZR3dYU1VUTXBOR1QxSWorSVBmbm1KMEphVDFsYldt?=
 =?utf-8?B?V053SWhSME1xcjJqR1hnbkREc0RPWE16MEVJdm1MeitGa1VmL2xYb2pZOVlv?=
 =?utf-8?B?K1M4SE1YSUVMajZkRTlnYU5SbGZaNWRWV2J1OEdkWE1xRldUNGIzL0FkM0F2?=
 =?utf-8?B?ZThPaERaUGEyMXZ6WGRyZ2h0NXNGR2pUYnhmK0ljN1V1MUgzYjZUKzdyTGdD?=
 =?utf-8?B?K3ZaQXVRczRFZjlqTTJ0QWhLY2FNVUErTXQ1WFZ1aDFBTEhwRlhEVkFlcDFN?=
 =?utf-8?B?NlhmM2g0aFhhZkZLWnJoK3FBYm1ldHJUTWl5V3pSUmJQUlBKYWk0RzRQRGNy?=
 =?utf-8?B?YVQ0RXVrWmJzUjk5ODJDR0g4MG5RQXpITndwMnU5MUZ0dzBubE8vR09rYW5Z?=
 =?utf-8?B?akRBTldsdGR3Nkk5ZHdqQ0xzNG5Ta2thYnc5WE5xUDhnNjB4ZlNwN2tpYWN1?=
 =?utf-8?B?UkozeG8wbnV3VmFLZGUwT0JvYU5XZndIVU1BNER5RVdHSUxsZVJZblhac09H?=
 =?utf-8?B?SGszMjllSkdXOWRLNmJqMHdPMGhpSnZhdkhkNEdCalFNRDVYSFdBU0krR0FC?=
 =?utf-8?B?WU8wdHZvcnJzRHlpbUpHcGhDKytKa29aWUdBK0Z3ZTd0UCsrNUFNaTBvKzMy?=
 =?utf-8?B?L2tyTEk0dlI4NTB0RkQ2dmgwSHlUeUpGdW5wdUNKVVlMV3R5cHBNMzhoZXZ6?=
 =?utf-8?B?eVRFMlplK0U5ZnpkVk5SS0Z1dCtIWmZtUGwrQlFPOUJyNlV6d0VURWg1bnlL?=
 =?utf-8?B?YXZFZG1mNnBNNzhOVkx2dHFpKzNpNUpxRXhvWC82a3pFT3ZtdDVMWGw1YlN2?=
 =?utf-8?B?Nk5zWld4NG1wc3Y3bkgzZW5YekNZUWtwNlZxR2pYam1rdFRtZTFmMHc2czU0?=
 =?utf-8?B?ZXFJZnd5bUpBLzJTNVNxUXUxeWIvTjVqV2dBTmVWZVgwWndRTnFBcUJWS3h3?=
 =?utf-8?B?aUtCOTNHUVFzZEtPWXlYRGMwRnZVTFJNUWJWeXhHSEdpaDRtQWwrVS84MEZ5?=
 =?utf-8?B?YVZXY1Qxd0hNbmVrdDhhZGxNTDdGZFdJTkZZbGpwYUlvZDhkUkc3dFZwY2pQ?=
 =?utf-8?B?MkFBOHpNajI3RHVYNWt3UE9NdlNOdnR6SGdEeG05NVdOTERZVTNUdTBvK05D?=
 =?utf-8?B?b1FrUkJhbFpjT1FZT3A2cjg3eGdXTTQ2R3JQSG5DV243YjFMSFZOVWlkQWRW?=
 =?utf-8?B?N3RNS2RRZnVkYVhlODl3L0ZnTUVnWmZCRzRHREJmSWNXMHFoQjdoK2tLT0Nz?=
 =?utf-8?B?QjlhcCtVcEJYRGE1REE3Y3JUU3R3OEcvL3IyaHg3VG9FbFpZUG9lNHNsTGs0?=
 =?utf-8?B?NVA3RXJFbzQ1L1VxKzM2T3R6QzRhVll0YnRhWjdkYXRZRTkzMnhtanpTUG0x?=
 =?utf-8?B?OFBWdnlhdGlTUFpzUDFvTHpwaHdFME1lOFVsV05sSFlSWFluaG1HNzVWV0hV?=
 =?utf-8?B?bWNXcU5NWDY2TUk1QU5tMXV1MWk1L1AvbXNGVmxvTjZLdWNsUlNGaEdGN3Rj?=
 =?utf-8?B?bXE1RUpXOVBKNC9YWWUrTTdQM0JZUTJBa0d4ckQvZ2N6cEJyMWIvQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2ca7de-702d-4d64-5f3d-08df09ba3e79
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:52:42.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKPoYpkZ9TPFkL7kaujzfmtXccU14E9Q4ELgC3ZMpSM9bw9yg6u+/TVg05gxAfiLPSw11N/Pkq57A3M9uKG4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5855



On 9/3/2026 8:12 AM, Andrii Nakryiko wrote:
> On Mon, Aug 31, 2026 at 6:38 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>> Add btf_module_names and nr_btf_module_names fields to
>> bpf_object_open_opts to support selective kernel module BTF loading.
>>
>> With btf_module_names:
>> - when provided, only the specified kernel module BTFs are loaded;
>> - when an empty list is provided, no module BTFs are loaded;
>> - when NULL, all module BTFs are loaded as before.
>>
>> This avoids unnecessary module BTF loading and reduces BPF object
>> loading time when only a subset of kernel module BTFs is needed.
>>
>> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> 
> nit: use andrii@kernel.org as my email, thanks
> 

Will do.

>> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 117 +++++++++++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.h |  24 ++++++++-
>>  2 files changed, 140 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa82..e19d0afd2592 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -779,6 +779,9 @@ struct bpf_object {
>>         char *token_path;
>>         int token_fd;
>>
>> +       char **btf_module_names;
>> +       size_t nr_btf_module_names;
> 
> there is entire module related set of fields higher up, put these new
> fields close to them
> 

Sure, I'll move them next to the existing module-related fields.

> but also naming-wise:
>   - use blah_cnt instead of nr_blah naming
>   - we should call this "btf_module_allowlist" and
> btf_module_allowlist_cnt, a bit verbose but explains what it is and
> leaves doors open for denylist, if we ever need it. Please use these
> names internally in bpf_object and in bpf_object_open_opts
> 

Makes sense. I'll rename them to btf_module_allowlist and
btf_module_allowlist_cnt.

> overall, the code as is super verbose and doesn't feel like libbpf
> code, please try to preserve naming/styling/succinct approach as much
> as possible
> 

Understood. I'll simplify the implementation and keep it closer to the
existing libbpf style.

>> +
>>         char path[];
>>  };
>>
>> @@ -5803,6 +5806,103 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>         return 0;
>>  }
>>
>> +static void bpf_object_free_btf_module_names(struct bpf_object *obj)
>> +{
>> +       size_t i;
>> +
>> +       if (!obj->btf_module_names)
>> +               return;
>> +
> 
> no need for this check, count should be zero and everything works as
> is without extra guard
> 

Right, I'll drop it.

>> +       for (i = 0; i < obj->nr_btf_module_names; i++)
>> +               zfree(&obj->btf_module_names[i]);
>> +       zfree(&obj->btf_module_names);
>> +       obj->nr_btf_module_names = 0;
> 
> just inline this logic in bpf_object__close()
> 

Sure.

>> +}
>> +
>> +static int bpf_object_init_btf_module_names(struct bpf_object *obj,
>> +                                           const struct bpf_object_open_opts *opts)
> 
> if you look at bpf_object_open(), all the opts processing is done
> inline , let's do the same here. we can do validation and duplicate
> detection before we even get to bpf_object__new. and alloc and strdup
> loop after obj is created
> 

Agreed.

> pw-bot: cr
> 
>> +{
>> +       const char **names;
>> +       size_t i, j, cnt;
>> +       int err;
>> +
>> +       names = OPTS_GET(opts, btf_module_names, NULL);
>> +       if (!names)
>> +               return 0;
> 
> don't exit early, we need to validate that if allowlist is not
> specified, corresponding count is zero and vice versa
> 

Understood.

>> +
>> +       cnt = OPTS_GET(opts, nr_btf_module_names, 0);
>> +
>> +       /*
>> +        * Allocate one entry for an empty list to distinguish it from the
>> +        * default behavior.
>> +        */
>> +       obj->btf_module_names = calloc(cnt ?: 1,
> 
> this count trick is kind of ugly... should we just set count to <0
> instead? we'll still be able to do for loop without any extra
> handling, but -1 vs 0 for count will be a sign of having no or empty
> allowlist
> 

Yes, setting count to -1 can better address this issue.

>> +                                      sizeof(*obj->btf_module_names));
>> +       if (!obj->btf_module_names)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < cnt; i++) {
>> +               if (!names[i] || !names[i][0]) {
>> +                       pr_warn("invalid kernel module BTF name at index %zu\n", i);
> 
> I don't think this will be some common mistake, let's drop all this
> verbosity with pt_warn and so on, just error out
> 

Sure, I'll remove the warning and return the error directly.

>> +                       err = -EINVAL;
>> +                       goto err_out;
>> +               }
>> +
>> +               /*
>> +                * The list is expected to be small, so a simple nested scan is
>> +                * sufficient for duplicate detection.
>> +                */
> 
> unnecessary comment, drop it
> 

Got it.

>> +               for (j = 0; j < i; j++) {
>> +                       if (strcmp(obj->btf_module_names[j], names[i]) == 0) {
>> +                               pr_warn("duplicate kernel module BTF name '%s'\n",
>> +                                       names[i]);
> 
> ditto, just error out, no pr_warn()
> 

Will do.

>> +                               err = -EINVAL;
>> +                               goto err_out;
>> +                       }
>> +               }
>> +
>> +               obj->btf_module_names[i] = strdup(names[i]);
>> +               if (!obj->btf_module_names[i]) {
>> +                       err = -ENOMEM;
>> +                       goto err_out;
>> +               }
>> +
>> +               obj->nr_btf_module_names++;
>> +       }
>> +       return 0;
>> +
>> +err_out:
>> +       bpf_object_free_btf_module_names(obj);
> 
> I don't think we need to clean up here, bpf_object__close() will be
> closed and will take care of this cleanup, keep the logic simple
> 

Agreed.

>> +       return err;
>> +}
>> +
>> +static bool is_module_btf_needed(const struct bpf_object *obj, const char *name)
> 
> let's call this is_btf_mod_allowed()
> 

Sure, I'll rename it to is_btf_mod_allowed().

>> +{
>> +       size_t i;
>> +
>> +       if (!obj->btf_module_names)
>> +               return true;
>> +
>> +       for (i = 0; i < obj->nr_btf_module_names; i++) {
>> +               if (strcmp(obj->btf_module_names[i], name) == 0)
>> +                       return true;
>> +       }
>> +
>> +       pr_debug("skipping module BTF '%s', not in btf_module_names\n", name);
> 
> drop this pr_debug(), do you think it will be very useful? this whole
> feature feels super niche, whoever is going to use it should know what
> they are doing, so I find it unlikely that they might be surprised by
> ignoring kernel module they explicitly excluded
> 

Makes sense. I'll remove it.

>> +       return false;
>> +}
>> +
>> +static bool no_module_btfs_needed(const struct bpf_object *obj)
>> +{
>> +       return obj->btf_module_names && !obj->nr_btf_module_names;
>> +}
>> +
>> +static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
>> +{
>> +       return obj->btf_module_names &&
>> +              obj->nr_btf_module_names == obj->btf_module_cnt;
>> +}
>> +
> 
> these two helpers are just verbosity, let's get rid of them and do
> corresponding checks inline
> 

Understood. I'll remove both helpers and inline the checks.

>>  static int load_module_btfs(struct bpf_object *obj)
>>  {
>>         struct bpf_btf_info info;
>> @@ -5825,6 +5925,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>         if (!kernel_supports(obj, FEAT_MODULE_BTF))
>>                 return 0;
>>
>> +       if (no_module_btfs_needed(obj))
>> +               return 0;
> 
> under new convention, it will be `if (btf_mod_allowlist_cnt == 0) return 0;`
> 

Right. I'll handle it with the new convention.

>> +
>>         while (true) {
>>                 err = bpf_btf_get_next_id(id, &id);
>>                 if (err && errno == ENOENT)
>> @@ -5867,6 +5970,11 @@ static int load_module_btfs(struct bpf_object *obj)
>>                         continue;
>>                 }
>>
>> +               if (!is_module_btf_needed(obj, name)) {
>> +                       close(fd);
>> +                       continue;
>> +               }
>> +
>>                 btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>>                 err = libbpf_get_error(btf);
>>                 if (err) {
>> @@ -5891,6 +5999,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>                         break;
>>                 }
>>                 obj->btf_module_cnt++;
>> +
>> +               if (all_needed_module_btfs_loaded(obj))
>> +                       break;
>>         }
>>
>>         if (err) {
>> @@ -8508,6 +8619,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>>                 }
>>         }
>>
>> +       err = bpf_object_init_btf_module_names(obj, opts);
>> +       if (err)
>> +               goto out;
>> +
>>         err = bpf_object__elf_init(obj);
>>         err = err ? : bpf_object__elf_collect(obj);
>>         err = err ? : bpf_object__collect_externs(obj);
>> @@ -9629,6 +9744,8 @@ void bpf_object__close(struct bpf_object *obj)
>>                 close(obj->jumptable_maps[i].fd);
>>         zfree(&obj->jumptable_maps);
>>
>> +       bpf_object_free_btf_module_names(obj);
>> +
> 
> just inline that simple clean up logic here without helper function
> 

Will do. I'll inline this.

>>         free(obj);
>>  }
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index b965ad571540..1cabf7e46554 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>>          * point (/sys/fs/bpf), in case this default behavior is undesirable.
>>          */
>>         const char *bpf_token_path;
>> +       /*
>> +        * Optional list of kernel module names whose BTFs should be loaded.
>> +        * nr_btf_module_names specifies the number of entries in
>> +        * btf_module_names.
> 
> not really, it's not "what should be loaded" but what is allowed to be
> loaded. quite a difference, because with "should be loaded" we should
> be failing if we don't find all those modules, but I don't think that
> was the intent, was it?
> 

Yes, exactly as you said.

>> +        *
>> +        * With btf_module_names:
>> +        * - when provided, only the BTFs of the specified modules are loaded;
>> +        * - when an empty list is provided, no module BTFs are loaded;
>> +        * - when NULL, all module BTFs are loaded as before.
>> +        *
> 
> also mention that count should be zero for empty or NULL list
> 

Sure, I'll clarify the count requirement in the documentation.

>> +        * The list must contain valid, non-empty module names and must not
>> +        * contain duplicate entries; otherwise -EINVAL is returned.
>> +        *
>> +        * This affects:
> 
> just say that this allowlist affects any place where kernel module BTF
> might be needed by limiting which kernel module BTFs libbpf will
> consult. no need to enumerate all the different places where we use
> BTF, it will get out of sync too easily.
> 

Makes sense. I'll simplify the documentation to describe the general
allowlist behavior.

>> +        * - BPF CO-RE relocations against types defined in modules;
>> +        * - BTF-based resolution of attach targets;
>> +        * - module-qualified tracing multi-attach targets;
>> +        * - struct_ops kernel type resolution;
>> +        * - extern (ksym) resolution for kernel symbols defined in modules.
>> +        */
>> +       const char **btf_module_names;
>> +       size_t nr_btf_module_names;
>>
>>         size_t :0;
>>  };
>> -#define bpf_object_open_opts__last_field bpf_token_path
>> +#define bpf_object_open_opts__last_field nr_btf_module_names
>>
>>  /**
>>   * @brief **bpf_object__open()** creates a bpf_object by opening
>> --
>> 2.34.1
>>

