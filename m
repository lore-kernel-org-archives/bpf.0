Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012070.outbound.protection.outlook.com [52.101.126.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406A2F12DA;
	Sat, 22 Aug 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399844; cv=fail; b=NPEihTfuIE2itsLo66rucCe/D5DzMhrilX6jdfUS9xZ47X5C2JJidKBOf0l4luDUe0QIqOjR+XPa76zC5l1aPNE1W+vySWKczwWrriDYMZ5DGNMfZcpap0jxGYu/Qoh3+IT2sqaajijanze4twrJJAEVAV92ONal6/nPfXBB8uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399844; c=relaxed/simple;
	bh=UceC47BSOeMr6X6iJceq2bVd86bpRR8Mxb8F8ICs0AQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MPMcZeyue/AQ12Re5u/6Ax24z3kjzB/rj/1VN2wanPvN66stLblvtNJ4rtqzXuLAYd/j6K81tRjmj0UKtcegid2xIzqzRHG+penEW4FWIIqsg+8g3+RaS2cXltmDd8+kxtGrOFh9hCciTaTZwHSuXFURosrki4J8coYlCf5t5ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Tilw8nV+; arc=fail smtp.client-ip=52.101.126.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Tilw8nV+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbImc3U7xjMcer0kOShxwZkRtbE8SWGRpLNblRudv7yAdcsCob3dwCLIFC+yTA6Q1ZlPDWT480OMwzxHgAwO2go9v7/ZAEKA+UtW1KllCpY7aGBykYA9jEKhl1be3lwKITn898LHQCZ3yI2Ksk4WprlG0NQEkFFxHRLxW80PI42V0jfXNnD+r6ElmfczDWx/FvwPHJTpOsHxWjJY39Hc/cBa10ZNVLqPdJFOvnVVtJTDp6AIPD6jKe+Iu3OMs09ol4Kg9Td8+BIRrQeUeBmbls6IMqAObo+vHlNDMxAiWJ8OqMtUNDqHfZ7qbl1GIyaCECw3IMZz5GwP26Z/WU1kIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo7Lvy9URRlxATaZAYmPiKEzVQMJU96M6160M9E/Nio=;
 b=aG8krNggd2CwaqeIMO3bpzxqJCPdudUqyqltqVOlspldoDvxhcHokSPuvt5ALW7NyhVlqo9mSbbBSYHQ0Em8BOBBE4g5K1iEXy55OSyhjyPQk+2vxt0g3PUVzh3XawNBDWGD2joWNHrh4CytzvTI8rZ35y3lKUwQvn6qh2+6MOKOfqeEHEhUKIwEn+cIIJcoCtSbkCPR6morKZqIVPF62N75P+b/CUstGwayevCMcTYcKJ0UzSsbz5Bk9WP8tITODTylfGxh6lFYO8+FoRCnw4GpiwA8woYS82EJBg+gQvH+7amXgLbirY22H8hP61U2HiAd3+kmr9yN6ES2B0aXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo7Lvy9URRlxATaZAYmPiKEzVQMJU96M6160M9E/Nio=;
 b=Tilw8nV+tJP3KwTlBxDUXK4OGBdwUQCmANF1gjRzxtU0eN75DxGAU2pnuLvwGr5/g6e158c44Gc/fKmSix61rpm7uxnZo1aqg+sJhf8PjnzKHUIRPnKJQSD4d+/5D/Qb6huF7S5OSgoEY7Cbug/fPL0DFRYZdu0ux43Dy+gHKYFRJzE/BQ7V2ObvdKtVfN6N5j71nW+zv2UhnWpM7VQSzvUsoP4LSpkMGeW5fOTuv8D5t3n8MhJDRCOHDJq4mXD1sVihXAGO0DOGnhWvEjzdzrQxtO5qZIuhMN06mcKgRNqFLQe2Ab6BOrhhm1owmvcfiFD7jCnixgJAcT+LqyH58w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TY8PR06MB9101.apcprd06.prod.outlook.com (2603:1096:405:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 11:57:19 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 11:57:19 +0000
Message-ID: <11d4eb92-aa42-4fcf-97d9-b8c155873d68@vivo.com>
Date: Sat, 22 Aug 2026 19:57:13 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel
 module BTF loading via bpf_object_open_opts
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 alan.maguire@oracle.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 yatsenko@meta.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260819090426.267-1-zhaofuyu@vivo.com>
 <20260819090426.267-2-zhaofuyu@vivo.com>
 <5efea1c6d5feb9bfc4ffe3eedde9ab98c2613776.camel@gmail.com>
 <7fcd1b5f-dc15-486d-a56f-4961a25b133a@vivo.com>
 <CAEf4BzbbdjeSW88EEk2xRvAxq-HWUJ7qTw4BYnL3kLH0f0uhwg@mail.gmail.com>
In-Reply-To: <CAEf4BzbbdjeSW88EEk2xRvAxq-HWUJ7qTw4BYnL3kLH0f0uhwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:295::10) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TY8PR06MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a352a05-404b-4746-fc3d-08df00448439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6IWpstoSFtCeF5fK+VkVVi6dTfn2/t7E5ujdeNbSAbxKRKYnjnYwjFhdidQyHWqxZ+S0u//Evk0atgCnIox63IBwW/eubuXZv8STEq9wu9r04LGq8cBlg2Zp7Oow2OwGextchNJsHPbdnnvwSQVvdEtoXoO022ZzwMFRUScuU/lU3I3kG8/J5i0FfX0l+lFroDGwhYWQPGVJ4pwjybCZAAQkKwKmMMmPTRMtyhGE4SzuMIhz9odyw9e9WN489MrH1fhR90iocspfbEGM2F3q8Mx91DrF0WZo8R5jtVaErcNlWacUx/Vxv4egjJaaVi+inYjVOh/bNoZ4DSF4rltopJLRZDViGAlKtvqF08mTXuD3OfPoMcM9jLSw5tYn9gYq6jodsyrObxGjZN81NHTV5jRtRJOFbva8Q3coH2ZKcdeCucDY6VFQvgHISqwbza9RewDX4KYequAwR/cVFgvQtT2S0OhSEZcflk4AHqVThI70G6CzjP4i4sf94kRb9AkR5jSz7M1gGbH7gr5fUwMFU2Zxnw/KkwhRMrX93QEARIUVZh+MwJK7nBGKurmUCfKY+YVBKPctw0grYn7M5Ul6CfDbnjxywA4h5V9ENe9zEouWOnfIjnbWHw+BFyT6XwKrrvryDg7bXpGlp4dmNVlIR9GJGvzcUH25CCxd6QDj0Gk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW5tZjN4OGtiQmVDQWFURVJWaEEyYVFaNGNrV0VEWmtWSUp1dk5KRnM2dWJ3?=
 =?utf-8?B?aC84SG03RGplVTJUWFo1SlhXQUdiK0ZtcEV2bzJ5ZXl0TFFpSEhBMGRWRW9r?=
 =?utf-8?B?ZklBaVhZMkZaL3RwNTZ0Nlo4SVBiYUhEMmhLcTg1Z1c5L0NMZVZhaGdlRyts?=
 =?utf-8?B?eEgvK2VKQVR1d3dIL2loS2xoUlhKN2xtS1JXRlZuREFSaGFuUHRUQ3lUMXpS?=
 =?utf-8?B?Zk1Ia09sN080N2JZTVRhQlliOHEvMUhUd0NJeFFxUG52c0orMHF6R05McGh3?=
 =?utf-8?B?OTR6ZjJML1BMMWR0V1J3QjY3STRsS2pia21ZVDgva3VwMndadjFockk0VmdC?=
 =?utf-8?B?V0IwRGp0M2l0eUV0enpXQUZoUjZYbXhzWG41RW01WUtqTVFRdVRITkpab21O?=
 =?utf-8?B?eUhWc215UDNmM0NmZ2FuRFhNSzFGWHNnMGtGZWtzaWV2b1N1YXNUNndIRFQy?=
 =?utf-8?B?TWVnOStGcWdDeFVBRmV5SkFNSEJ5UkZUcDFvQmdMK1ZUU3BjMkFBaXJML1k0?=
 =?utf-8?B?SEVxNnphUnNqVUNqWE9vT0hhWHFuajRpbENvTTZTaHZIZGZvdlBmdTU2RHdW?=
 =?utf-8?B?dTV0RlBQZ3ZrcW5BOTRMc0pkMTAwYVAwR3JsbGp3K0I1SDFtaW01NktQc1VR?=
 =?utf-8?B?djZicDRKVWo2RWJHWFFURlFvR3A3OE9sWWIzVCtCQUsweENJeWlEZ2RIZVZu?=
 =?utf-8?B?alc1d2JoMlVJaGRwUVYzMHRCVGllb3NrK3Zsak1YdGtqNmd3TkhUNU0vRGtQ?=
 =?utf-8?B?VjlzUWNxWHZtZWRpVnFoUlJqR0paWG4xY0ZrS0xTWnU1UXhhUmIwdExMOUFm?=
 =?utf-8?B?cENPT3QwY05QUXdSanQzVm9QQ3VLeEVpTmoxcEdaNlVnN2lrK0xYWUk3LzNK?=
 =?utf-8?B?YXlOc0I2R1JLNElUeUF6dFVEczFqUXpvZHBrMFVRQkF2WHFpcHplK3ZrV2d4?=
 =?utf-8?B?cTUyWW9oaGh6TDJJVlRtK3Y1TnJ2eVZHcFN3cHpBTnZiK25NeVh1WERwZFE1?=
 =?utf-8?B?WENxQktNUVBVSXg3V3pTdDlaeWEydVJHbGZBS1lUcXFtekNMejl5bVFVbGtQ?=
 =?utf-8?B?Q2hrd215bWFsTTg5U2pqRTBFaUc5eHFKK2RLaDhoS2dQdnUxbFpQRjVuZWh4?=
 =?utf-8?B?QlFIYnNhOTR2TDlJWGpwT21QRGMrcHhxYTYycStqNGhKbU1ZQmpEK1pJRnhv?=
 =?utf-8?B?ZkdsRnZueUFKcWR4VmlJZFV0L1hTdGZBRTJKZ1J3QWN0ZUwrdEFQV1ZSVVYx?=
 =?utf-8?B?R1BLdFo0dmhnSHJTa2NrY2lQM0hRQk5DamxYdnhGcThBYU5SOW9HQ2c4T3Ni?=
 =?utf-8?B?emZOaDE0bm1ObGxJWGY2T3lSUXhQdGNJTlRtTlRWVVFrYkRFL2xCSGxJeis4?=
 =?utf-8?B?RDN2czhsUnM5TWJiRGt1NVlqc2Yxb001bU94RE5ZZmNsanZiT05MUHN6blZv?=
 =?utf-8?B?UUdiblVpM3R1c0Fkd1NWeCtDOTBobnBhUWJTbXFKRUxDZXd1YXVRUHZyM25l?=
 =?utf-8?B?R2Evb0JSZ283aVlGdnVYUDFNYzZjbVNuR0NrdWxvanFja05qUWMyMzNIU1pO?=
 =?utf-8?B?RUh3dEVlQWlMTGczRXRhc3pHWFFtc29oeHd3RzVhQzdValBxeGgwQ09WUTc0?=
 =?utf-8?B?YlhtcCt4ZWttYTJqNENFVmdueEhmNjEzY0hieHhiY3oraFRBQTh3MDZIQ2dm?=
 =?utf-8?B?U1FQTFk0clk2c3Q1eTVWNCsxL2taQ2NjaDhrUTlPUVY0UmpYRThOdnRDSWdT?=
 =?utf-8?B?dW52M2cyYW9VYU9JaHVscWtCaDNucUJnbjF4NU5haEE2UjlVS0x2NkpkK2VI?=
 =?utf-8?B?WnR2REFtWXNkRE9jYUl1eXJ2ZCtyME9yalpFa25vSml0a3krMDVFS0tuS1h1?=
 =?utf-8?B?dGF0eTB4R1pyaDhsdk80THdNWXprOXJWbnFtWlRheE5iMmtLWksvNGw0UUVi?=
 =?utf-8?B?Y1FKUFJjaEZQdnNEbDRjRWVqSUJEbVd2K3lodTVsR1R3UEg2RDlBM2xmTVNF?=
 =?utf-8?B?aEdWMW82NzZoMlNuanZYWFRhUGlrNnNrSW5zMWdvdTc1WG5odFVSc3VrOC91?=
 =?utf-8?B?SGFZVkdsOGRveTdOQ2luTFkzL0N3UWlnSEc4eTZWYldEaEd2RjlqTzRlT0ds?=
 =?utf-8?B?aUczZXI3QW9Rc2daS0F2T1hVYlN0TDAyZTF5eGRZb1JUMXgzbmNPSmtwRXBJ?=
 =?utf-8?B?blVaTXBSbm5Oa09OcUN4eit4a2JHODlwRVdtNVhCd0llN2F0VWpkaytCdUdz?=
 =?utf-8?B?SGtGOE1UUXdSbVRhQ2lrT3R1U0lZTlpkaUZZaEgrWkhoaTBaMDFEVHlkWjhS?=
 =?utf-8?B?ZXQ4aFQ4K1FJMUFuakdRajBXUVhsYjNRSTYyc3d0UllGLzB5UFh0UT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a352a05-404b-4746-fc3d-08df00448439
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 11:57:18.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRa1jJa8lthnfLwF/1G1I0SsNEYfMX3aaaj3OKd987ds1ou+CA6wsRTCfl/1WkXLOAMr3RL0g1zYjuIosThzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9101



On 8/22/2026 2:51 AM, Andrii Nakryiko wrote:
> On Thu, Aug 20, 2026 at 8:51 PM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>> Hi Eduard,
>>
>> Thanks for the suggestions. Please see my responses inline below.
>>
>> On 8/21/2026 7:58 AM, Eduard Zingerman wrote:
>>> On Wed, 2026-08-19 at 17:04 +0800, Fuyu Zhao wrote:
>>>
>>> Overall the logic seem to be fine for me, please find a few comments below.
>>>
>>> ...
>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 514e4e9daa82..37934ca49dd7 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -779,6 +779,13 @@ struct bpf_object {
>>>>      char *token_path;
>>>>      int token_fd;
>>>>
>>>> +    /* kernel module BTFs to load, as specified via bpf_object_open_opts */
>>>> +    struct {
>>>> +            char **names;
>>>> +            size_t nr_names;
>>>> +            struct hashmap *names_map;
>>>
>>> We already have a strset type, please use it instead of a direct
>>> hashmap reference. This would remove the need for `names` field
>>> and simplify the bpf_object__init_kmod_btfs() function.
>>>
>>> Also, do you expect `nr_names` to be high?
>>> If not, wouldn't plain array search be simpler/faster here?
>>>
>>
>> I initially used a hashmap to avoid repeatedly walking the requested
>> module name list. But I don't expect nr_names to be high in practice, so
>> a plain array search should be sufficient and simpler. I'll change this
>> in the next version.
>>
>>>> +    } *kmod_btfs;
>>>
>>> Why indirection?
>>>
>>
>> I followed the existing pattern in bpf_object and used an anonymous
>> structure with indirection here. I don't have a strong reason to keep
>> the indirection, though. I'll simplify it.
>>
>>> Also, I agree with the bot here, prior fields use "module" in the name,
>>> so something like "btf_module_names" or similar is a better fit.
>>> Same for publicly visible 'opts' name.
>>>
>>
>> I think `btf_module_names` is a much better name than my original choice.
>> I'll change that in `opts`, too.
>>
>>> ...
>>>
>>>> +static int bpf_object__init_kmod_btfs(struct bpf_object *obj,
>>>> +                                  const struct bpf_object_open_opts *opts)
>>>> +{
>>>> +    const char **kmod_btf_names;
>>>> +    size_t i, kmod_btf_names_cnt;
>>>> +    int err;
>>>> +
>>>> +    kmod_btf_names = OPTS_GET(opts, kmod_btf_names, NULL);
>>>> +    if (!kmod_btf_names)
>>>> +            return 0;
>>>> +
>>>> +    kmod_btf_names_cnt = OPTS_GET(opts, kmod_btf_names_cnt, 0);
>>>> +    if (!kmod_btf_names_cnt) {
>>>> +            pr_warn("kmod_btf_names_cnt must be set when kmod_btf_names is provided\n");
>>>> +            return -EINVAL;
>>>
>>> I kinda agree with the bot here, why disallow an empty filter here?
>>>
>>
>> I understand the point now. I hadn't considered the use case of
>> explicitly skipping all module BTFs. A non-NULL `kmod_btf_names` with a
>> zero count is a way to represent this case, so I'll support it in the
>> next version.
>>
> 
> besides all Eduard's suggestions, one naming nit: don't use double
> underscore naming, those are reserved for extern method-like APIs,
> while you are adding internal helpers
> 

Got it. I'll rename it and keep this in mind going forward. Thanks.

> 
>>>> +    }
>>>> +
>>>> +    obj->kmod_btfs = calloc(1, sizeof(*obj->kmod_btfs));
>>>> +    if (!obj->kmod_btfs)
>>>> +            return -ENOMEM;
>>>> +
>>>> +    obj->kmod_btfs->names = calloc(kmod_btf_names_cnt, sizeof(char *));
>>>> +    if (!obj->kmod_btfs->names) {
>>>> +            err = -ENOMEM;
>>>> +            goto err_out;
>>>> +    }
>>>> +
>>>> +    obj->kmod_btfs->names_map = hashmap__new(mod_name_hash_fn,
>>>> +                                             mod_name_equal_fn, NULL);
>>>> +    if (IS_ERR(obj->kmod_btfs->names_map)) {
>>>> +            err = PTR_ERR(obj->kmod_btfs->names_map);
>>>> +            obj->kmod_btfs->names_map = NULL;
>>>> +            goto err_out;
>>>> +    }
>>>> +
>>>> +    for (i = 0; i < kmod_btf_names_cnt; i++) {
>>>> +            size_t idx = obj->kmod_btfs->nr_names;
>>>> +
>>>> +            if (!kmod_btf_names[i] || !kmod_btf_names[i][0]) {
>>>> +                    pr_warn("invalid kernel module BTF name at index %zu\n", i);
>>>> +                    err = -EINVAL;
>>>> +                    goto err_out;
>>>> +            }
>>>> +
>>>> +            obj->kmod_btfs->names[idx] = strdup(kmod_btf_names[i]);
>>>> +            if (!obj->kmod_btfs->names[idx]) {
>>>> +                    err = -ENOMEM;
>>>> +                    goto err_out;
>>>> +            }
>>>> +
>>>> +            err = hashmap__add(obj->kmod_btfs->names_map,
>>>> +                               obj->kmod_btfs->names[idx], 0);
>>>> +            if (err) {
>>>> +                    zfree(&obj->kmod_btfs->names[idx]);
>>>> +                    if (err == -EEXIST) {
>>>> +                            pr_warn("duplicate kmod BTF name '%s' ignored\n",
>>>> +                                    kmod_btf_names[i]);
>>>
>>> Nit: I'd downgrade this to debug level, if at all.
>>>
>>
>> Agreed. I'll downgrade this to debug level in the next version.
>>
> 
> when you copy over a list of kernel module names, sort it, and do a
> pass to detect duplicates. if there are any -- just error out, specify
> in the documentation that the list of kernel modules names should not
> contain duplicates. It's not a particularly limiting restriction, is
> it?
> 

I agree. I'll simplify this and reject duplicate module names, and update
the documentation accordingly. Thanks for the suggestion.

>>>> +                            continue;
>>>> +                    }
>>>> +                    goto err_out;
>>>> +            }
>>>> +            obj->kmod_btfs->nr_names++;
>>>> +    }
>>>> +    return 0;
>>>> +
>>>> +err_out:
>>>> +    bpf_object__free_kmod_btfs(obj);
>>>> +    return err;
>>>> +}
>>>
>>> ...
>>>
>>>> @@ -8515,6 +8645,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>>>>      err = err ? : bpf_object__init_maps(obj, opts);
>>>>      err = err ? : bpf_object_init_progs(obj, opts);
>>>>      err = err ? : bpf_object__collect_relos(obj);
>>>> +    err = err ? : bpf_object__init_kmod_btfs(obj, opts);
>>>
>>> Nit: all other options are collected before bpf_object__elf_init()
>>>      call just above.
>>>
>>
>> Agreed. I'll change it in the next version.
>>
>>>>      if (err)
>>>>              goto out;
>>>>
>>>
>>> ...
>>>
>>>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>>> index b965ad571540..2f8ff6d2d3df 100644
>>>> --- a/tools/lib/bpf/libbpf.h
>>>> +++ b/tools/lib/bpf/libbpf.h
>>>> @@ -224,10 +224,24 @@ struct bpf_object_open_opts {
>>>>       * point (/sys/fs/bpf), in case this default behavior is undesirable.
>>>>       */
>>>>      const char *bpf_token_path;
>>>> +    /*
>>>> +     * Optional list of kernel module names whose BTFs should be loaded.
>>>> +     * kmod_btf_names_cnt specifies the number of entries in
>>>> +     * kmod_btf_names.
>>>> +     *
>>>> +     * If kmod_btf_names is NULL, all module BTFs are loaded, preserving
>>>> +     * the default behavior. Otherwise, only the specified module BTFs
>>>> +     * are loaded.
>>>> +     *
>>>> +     * kmod_btf_names_cnt must be non-zero when kmod_btf_names is
>>>> +     * non-NULL; otherwise -EINVAL is returned.
>>>
>>> Nit: please add a complete list of behaviors this affects, e.g. CO-RE,
>>>      fentry/fexit resolution, etc.
>>>
>>
>> I'll expand the comment to cover the affected behaviors in the next version.
>>
>>>> +     */
>>>> +    const char **kmod_btf_names;
>>>> +    size_t kmod_btf_names_cnt;
>>>>
>>>>      size_t :0;
>>>>  };
>>>> -#define bpf_object_open_opts__last_field bpf_token_path
>>>> +#define bpf_object_open_opts__last_field kmod_btf_names_cnt
>>>>
>>>>  /**
>>>>   * @brief **bpf_object__open()** creates a bpf_object by opening
>>

