Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012066.outbound.protection.outlook.com [52.101.126.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8D33F5A8;
	Sat, 15 Aug 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786808132; cv=fail; b=RfI0Aaq5ajblzIvnBWvAOJ9DyAKRW3/z/loALDpAvJM6kU4AQ18VsYo5+a5pxrLZ6Q5peM15hlWQKBzbrHEPlZDeNuHWWtbYkcKkLmIvbisfVnfXt3SxGepX/CyjvP+Fhwa092zZd9IfsN8dPkfVxuYAmpQcqWIU4f+KUeCOMbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786808132; c=relaxed/simple;
	bh=eS/WFfy4vWnq2KsK0q4vgTbBFUAt5okL8o6P7uCK21Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RriuFCCZt9wl10tDYM+lK5QpLrQqSVEKDg77DMO4zsWEUHrjSlhFnH4wG+WY8OgnTYeANmhrUHH61tFIOvhnxwHc99gXsBJJlANxR5vPkelVITSnmOrsWG3YpWhGRg71f5qA8/iR1yZmkfuKTe6j34WFI6RYwTFyAyZNTfZUp0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nuAM2FqU; arc=fail smtp.client-ip=52.101.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nuAM2FqU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x45ZLgtPWAZUD5jJTob36RfBuHTGPH53WT8JJ+TGs1WQwbjU3RpVObyfhZkUzN7w9G12NSGv9CT2qroSPkAWb0qefyQRf1hRfow6jdDA7qTFywdnsREhauKGHWZJzv6fmmt66f05MqB+576AP6h6RrlFVZtJviPKGehhDbmX/2ZaTupYvIaxQagaNhlOVJAZIhC/3SjnsLaMv77tRCQfjNsrDtabgt3EnVQyyX1ckAIPF6GG52obxeQqUsez0DAK4wboLhCr8svBaBiaWkVzAJ6u3cjA7CgIDDNXOisjPFi/CnI1eSDPjoqSAKbOJvy1jG6Yx+bgiblPatT8613kxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01W5VnhsTSo0wvA5newNrop7SxqP1qlhFjRm54W+bhA=;
 b=kheBQ6Tn3WdAB08Lt0XQMWL5YLGwI0859E+72iOlnocANdDXGIaPh+o5Gpo76GHtBMFa28JpcWRqjM2fJ3VszdIov02B3sBvrNlGPUWOygTwc0UpC0qN5L9mszDupq+8c3g0c2CMpfuS7JHsxxSP5ae1HunbEyBI7Qp1oRQo5906nRJGK98Dqtb1+5i3LhOkDyTlSWG3iTan0vUmOVrgfUSSaOHUQeiBK9AJ83L2HkIOm9gU4Qx/+cWLyZzOElhO2i2+6436yNseJGFWBh694npi1uSExIxckLdETgcG7Dha3EdjYfKqNaBAP8kfzBadYImT6spnFMD4rgeq+Jf+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01W5VnhsTSo0wvA5newNrop7SxqP1qlhFjRm54W+bhA=;
 b=nuAM2FqUfKpdr5mTTuf885iP/UjKLEG/+OJeDTa+tuRtrWmZ6AzdGKzoRtt/5M+hbojdvlEPLp8QL0CJt47gKzFMSUvBbpthcwg1osp/lmRCeF0Z4dclU671AviBtoIcjRylJ4ZfseQ4sF4ON9NNbJJG2gbOHvqtJLFMHOA4TuNCD/lgEUwQGFoVOvT+cd5aUNuPOKIWPO3jkUivtpy4FOocY8eA6OiTseotOItvDF3tTYcj2hxnu4kGXyf1Iw3Mkkk2GocmllkOSFni38a8YCraUFXzAlnteEAMNZf58ZNygTOMKkIdp8hs4KBmyZ2ATSXN+dOxB4rZd7mdcff+qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB5352.apcprd06.prod.outlook.com (2603:1096:101:68::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sat, 15 Aug
 2026 15:35:24 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0315.016; Sat, 15 Aug 2026
 15:35:24 +0000
Message-ID: <1dd5fa0a-02a8-41f3-a29c-a6c49f825140@vivo.com>
Date: Sat, 15 Aug 2026 23:35:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel
 module BTF loading via .kmod_btfs section
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, alan.maguire@oracle.com,
 ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 shuah@kernel.org, yatsenko@meta.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260813032613.2755-1-zhaofuyu@vivo.com>
 <20260813032613.2755-2-zhaofuyu@vivo.com>
 <CAEf4Bza54yCwkOte77jkwCM3W+Oo2eH4bL0xqHmvYg5kZnXbxw@mail.gmail.com>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <CAEf4Bza54yCwkOte77jkwCM3W+Oo2eH4bL0xqHmvYg5kZnXbxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEYPR06MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: aefc2241-3dc8-4fd1-5ffb-08defae2d220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iplDdWjqRvlXFUZZSXnRyr8jDqHHg3IkePlDtARafKaZnyYmXBSRzvTgZ1bPeUqgb1bhdXzTSGtQjjx6V5zxafe4WCu/ln8MBm6H0TaVXOtK+B9ePrA9+D8qp+HvkmLV4dhrHHaS7tLOoJUWpfg/IQUBVut6S6lvlXdSNZn8dg3UO6Ly2iPs0nC9sDQSxRaS9Rk/6GsRbxp7kJFCNKI1oDHGsQ6OhOEHIaKc87LL1f6zJ3E7q7Kjrp6LFx60VDXD8bysApbCSS7zdt+avdTOgcqr41rMdFVSq33MSHjhh4NnNIIprdXsMyfOyGt53iClM4IZr8TzbUy07vDTBYqYwStyfieeuhpiDoHv7rMeTfC3NragLUN3tYpK1ZusAC8NcpZ6eB0fKZpb38l/OmQoAfsamtlPMki3TSpQuVwg4mSxxROo1DZkMUra+gch+xPhMtema/jhtIVLSB88tDcPflNQo++m5Ae3eQGbccY1U/J1nijkklB9tExdPtwjICYzHgbJW+rEOBu5suEZJ2C6Q+Q+7EAL3QJLKzNZb3MxvT+8o5oXOXyu153IWjSJW0kmnbeChO03VIbqoofkU1m1x2HGcjeLyk4YV0nrjN7rLmfWh9kbsGTJwMr58egfRGCLWTqKSvl1ar/kvkkKM+1zv3yv/nT7oNBYVYNgoycLkDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU1WZWY4b3RYbVZjUnZ6akVlVDdtL000Qi91VlBxU1hiNWcrM1VNSXBBRVlI?=
 =?utf-8?B?dytGRkpzSWlGaWtheUJuQ0lZWlRXWER4ZE5veFo3SGYrVkVLQ2UyL2hLWkJu?=
 =?utf-8?B?Z2x4WGFlZ0RDdE5JeFFtZ2tXRGRJS0FhUnpUU3FSbVV5ODQ4dTkxckFNaHNy?=
 =?utf-8?B?c0NNN2hTT3cvUm0ydWFnRmM2MFRiZVpLc3hiVTNvaGxOS3g0SFpTeSs3d0hM?=
 =?utf-8?B?cVBFd2tzNWFDSEVVVzkycFVpY3JmZWorWU0zbzhWRzQxN1BRcUFTcHo0SEsr?=
 =?utf-8?B?dldPRjVqT2FZeXpDUmRGd2xydFdzVHNYY2U4VDdRZnF4VCtZalBJSGNNbFFw?=
 =?utf-8?B?MTdSbEN2eUFnOHc0dklwaTFzeWtSRGFQbTZBR2tTQVJSWHpQZlFlZ1JPdmR4?=
 =?utf-8?B?YTZrMHBnZTdJT1VXTmVxSFFKSzdmREhPT1ltRzBUUUljb1VrVXZLdCtCT0I0?=
 =?utf-8?B?cFpZZlQvL2Vid1Z5aVpHT0pma2tTZDUvbTZUNFg4MzRkZnlwaGhnOE9XSDNH?=
 =?utf-8?B?eHNzL08rbm9IdzVKWXVhMkJNdlRaVU5YS0I3NWVZcFhtL1EyaWNWT1B6cEhi?=
 =?utf-8?B?VHZLMk0ySHAyV1lnMGo4YmNPd0toSG5ENkozek1oSnJ6Rnd4c084MTNaYzF6?=
 =?utf-8?B?SU1kOC9leUpGUVRqUzdnQ2dvVTJ5Q0M0M1RwdndaWmlCVHdLSUVnL29ycXFO?=
 =?utf-8?B?U3Z3S2F5TzRBWnFiQXhxK1ovZGc2K3JNUm1UQXdmSU9pR0dRUlRsUnlCQ3VM?=
 =?utf-8?B?a2ExT3l2akdOZXpwRmhETDZ6bUtHNEFCNmtRV2lqVnJVMEdnVFZwQ1dNallU?=
 =?utf-8?B?OUg5V0gxb0ErYTdRejhQN1EwY0V0eURxazVKaHJDNVZDdnJZWmNIbk1DYjJQ?=
 =?utf-8?B?QXJBakd6Q2w5ZklqRkpQb0Y5bUx3UC84enpCaUVWTEJ4aG80VHNUYy9IR3ZJ?=
 =?utf-8?B?ME5sR0pjOUYvT2NseThuTkM5Q1ZBeDV3SDJqSVY0V0xkc0g5c0c4Vk1iRlNu?=
 =?utf-8?B?a0U5YU9abXdxc1p6TGhGYmE4NFIzSDIvbVIxcFpJVkQ5bjdXTUdpcHRneG05?=
 =?utf-8?B?eUwvdUFuenVVaUhMdlhmRWxmUGtWaVh0MVlLZWFVY0JLNThmcTdlYWNEbE9l?=
 =?utf-8?B?aVBLU0grOUxPRVIvcU5XSVdqQTlXL3Y5L2RoYzhFa3J6RVNvbEVNWUVieWxC?=
 =?utf-8?B?NVdoK0MvU0NVc2RCRnMwMzhZcmo2VTJGSmFNM20zalV4MDJJdnNzZ3JnUGZK?=
 =?utf-8?B?ak9WcW9pVVBna2twT2l3MmNQdnc1OCs4NXVtSERDMTczenRDYWVoODVtUDEy?=
 =?utf-8?B?MVJPaWt5QVQxTlJ3VlNXVkRLRGJGdXRwVlliYWZlclBZSnE0YnZxa0d5YUlX?=
 =?utf-8?B?WmZsZVRmUjlOMU5RQTBZd1ZYTW9NOHNieTV5M2lLcVp5VG5FMEVBU1BUdGZ6?=
 =?utf-8?B?czlwT2ZqclAvSkFNaHVYTXVhYUNXMDVaaUdlWVhWNFlPZUxldkZJK1hGQXU3?=
 =?utf-8?B?eVR3WVRwK2lLRFpqNXRBY0kvcWQ5c1huUWtxTFVUb3JiYk4zd1c1SUNKTG1Y?=
 =?utf-8?B?NEZiMmw4Y05EeWtyaUJ1d0tIR3VzMnlXZEVqeVkzaEhqMWtZZnMyaGZUdTRF?=
 =?utf-8?B?d3Q4aFNJenJWa0ViMUNVTnNoODF0NkhXbXVoSllBQndjU3VHeFIrck9NQ2tt?=
 =?utf-8?B?KzIyR3hYTkpQdXNycGlKbHovRUM0OTFPU2xpRUVialBkSWxaYUlrLzFXNUhz?=
 =?utf-8?B?QlUxREg3RWNCWng2U3pzMWYvTjdtSUlUall5T2ozUFIrU0phWi9lS04wZjRw?=
 =?utf-8?B?dHVlRVZ0NFRwS1JjdnVpWEtBaXZrQVBDaEpwbEt3U0FlZTRkTGZObmNuclVp?=
 =?utf-8?B?N2QrZEFMN1ZzRndEaVNEaExua2V5SEdZOWlmcVE5RTFhODJxdVJ4YWZsajJC?=
 =?utf-8?B?S3NqTFZuclo3TU0xaGVmN0l3b0JaU3Z6ZU85UWNsREF4ZEpZcUVMT0pCdmJ1?=
 =?utf-8?B?NmdncllTWnd0QzlzOHVDVlVsaVZWYWl1RVF5UWlXTjQ3WVhlU09KY2FDQTlj?=
 =?utf-8?B?Ykxwc1RTZTdLM0Q3YzdpVHE4MENiSFZqb3A3ZXI2VlJQVGVpUnV3VWhSV0VL?=
 =?utf-8?B?WklzTithTGtQZFQyUjZLenBQdmYwQmVJYzgrT0Y5NWtzYVNKU0t2bndDS3pM?=
 =?utf-8?B?c09PTUk1N3FmTmVveW54bzIwa0NEWE9KZXNxMUpDUzBBUnJFNlVoUVI0Y2ZE?=
 =?utf-8?B?SytJeU5iN290RmlEelNva1R5OG9XektzMUorVFR5NmNvMmNWZ1NBUXEzQ2t2?=
 =?utf-8?B?ZEp2UDVCYk5uc2Ntamt6azNib05yUHplV04wVmdwc1hwMEg1Tlo4QT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefc2241-3dc8-4fd1-5ffb-08defae2d220
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 15:35:23.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8JK9OaUM++TpbREmaMs0u5mBOiq9wbO5fRHFy1qM3XavJeJrqshnvQrZxJOfvI+sN6K85lS2jCsVImckvyT2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5352



On 8/15/2026 3:57 AM, Andrii Nakryiko wrote:
> On Wed, Aug 12, 2026 at 8:26 PM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>> Add support for a new ELF section ".kmod_btfs" that allows BPF programs
>> to declare which kernel modules need BTF loading. This avoids loading
>> all module BTFs and speeds up program load when only a subset of modules
>> is needed.
>>
>> Specifically, this patch introduces two internal functions:
>>   - bpf_object__collect_kmod_btf_names(): parses the ".kmod_btfs"
>>     section and collects the declared module names.
>>   - is_kmod_btf_needed(): determines whether a given module's BTF
>>     should be loaded, allowing libbpf to skip unneeded modules.
>>
>> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
>> ---
>>  tools/lib/bpf/bpf_helpers.h |  14 +++++
>>  tools/lib/bpf/libbpf.c      | 106 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 120 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index 9d160b5b9c0e..171ea055cd32 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -188,6 +188,20 @@ enum libbpf_tristate {
>>         TRI_MODULE = 2,
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
>> +       SEC(".kmod_btfs") char name[][KMOD_NAME_LEN]
>> +
> 
> I don't really like another special ELF section just to provide a
> custom list of modules.
> 
> If we have to do a customization of BTF searching behavior of libbpf,
> let's do this through bpf_object_open_opts struct and pass NULL or a
> empty/non-empty list of kernel modules, or whatever other appropriate
> way to specify this.
> 
> But in any case, extending ELF format for BPF object file for this
> seems like an overkill and overcomplication.
> 
> pw-bot: cr
> 

Hi Andrii,

Thanks for the feedback. I also considered passing the module list through
bpf_object_open_opts.

The main reason for using an ELF section is that it keeps the module
dependency information together with the BPF object and requires minimal
changes for existing users.

However, I understand the concern that extending the ELF format introduces
additional complexity. I'll explore bpf_object_open_opts or other more
suitable approaches.

Best regards,
Fuyu

>>  #define __kconfig __attribute__((section(".kconfig")))
>>  #define __ksym __attribute__((section(".ksyms")))
>>  #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa82..9fe8a653e8b6 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -548,6 +548,7 @@ struct bpf_struct_ops {
>>  #define STRUCT_OPS_SEC ".struct_ops"
>>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>>  #define ARENA_SEC ".addr_space.1"
>> +#define KMODS_BTFS_SEC ".kmod_btfs"
>>
>>  enum libbpf_map_type {
>>         LIBBPF_MAP_UNSPEC,
>> @@ -703,6 +704,9 @@ enum bpf_object_state {
>>         OBJ_LOADED,
>>  };
>>
>> +/* Should match the definition in bpf_helpers.h */
>> +#define KMOD_NAME_LEN 64
>> +
>>  struct bpf_object {
>>         char name[BPF_OBJ_NAME_LEN];
>>         char license[64];
>> @@ -779,6 +783,14 @@ struct bpf_object {
>>         char *token_path;
>>         int token_fd;
>>
>> +       /* kernel module BTFs to load, declared in ".kmod_btfs" ELF section */
>> +       struct {
>> +               char (*data)[KMOD_NAME_LEN];
>> +               size_t nr_names;
>> +               size_t nr_loaded;
>> +               struct hashmap *hashmap;
>> +       } *kmod_btfs;
>> +
>>         char path[];
>>  };
>>
>> @@ -901,6 +913,75 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>>         return -ENOMEM;
>>  }
>>
>> +static size_t mod_name_hash_fn(long key, void *ctx)
>> +{
>> +       return str_hash((char *)key);
>> +}
>> +
>> +static bool mod_name_equal_fn(long key1, long key2, void *ctx)
>> +{
>> +       return strcmp((char *)key1, (char *)key2) == 0;
>> +}
>> +
>> +static int
>> +bpf_object__collect_kmod_btf_names(struct bpf_object *obj, Elf_Data *sec_data,
>> +                                  const char *sec_name)
>> +{
>> +       int module_cnt, i, err = 0;
>> +
>> +       if (obj->kmod_btfs) {
>> +               pr_warn("sec '%s': duplicate sections detected\n", sec_name);
>> +               return -EEXIST;
>> +       }
>> +
>> +       if (sec_data->d_size % KMOD_NAME_LEN != 0) {
>> +               pr_warn("sec '%s': size %zu should be multiple of %d\n",
>> +                       sec_name, sec_data->d_size, KMOD_NAME_LEN);
>> +               return -EINVAL;
>> +       }
>> +
>> +       module_cnt = sec_data->d_size / KMOD_NAME_LEN;
>> +       obj->kmod_btfs = calloc(1, sizeof(*obj->kmod_btfs));
>> +       if (!obj->kmod_btfs)
>> +               return -ENOMEM;
>> +
>> +       obj->kmod_btfs->data = calloc(module_cnt, KMOD_NAME_LEN);
>> +       if (!obj->kmod_btfs->data) {
>> +               err = -ENOMEM;
>> +               goto err_out;
>> +       }
>> +       memcpy(obj->kmod_btfs->data, sec_data->d_buf, sec_data->d_size);
>> +
>> +       obj->kmod_btfs->hashmap = hashmap__new(mod_name_hash_fn,
>> +                                              mod_name_equal_fn, NULL);
>> +       if (IS_ERR(obj->kmod_btfs->hashmap)) {
>> +               err = PTR_ERR(obj->kmod_btfs->hashmap);
>> +               goto err_out;
>> +       }
>> +
>> +       for (i = 0; i < module_cnt; i++) {
>> +               obj->kmod_btfs->data[i][KMOD_NAME_LEN - 1] = '\0';
>> +               if (hashmap__find(obj->kmod_btfs->hashmap,
>> +                                 obj->kmod_btfs->data[i], NULL)) {
>> +                       pr_warn("sec '%s': ignored duplicate module '%s'\n",
>> +                               sec_name, obj->kmod_btfs->data[i]);
>> +                       continue;
>> +               }
>> +               err = hashmap__set(obj->kmod_btfs->hashmap, obj->kmod_btfs->data[i],
>> +                                  0, NULL, NULL);
>> +               if (err)
>> +                       goto err_out;
>> +               obj->kmod_btfs->nr_names++;
>> +       }
>> +       return 0;
>> +
>> +err_out:
>> +       hashmap__free(obj->kmod_btfs->hashmap);
>> +       zfree(&obj->kmod_btfs->data);
>> +       zfree(&obj->kmod_btfs);
>> +       return err;
>> +}
>> +
>>  static int
>>  bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>>                          const char *sec_name, int sec_idx)
>> @@ -4034,6 +4115,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>>                                 memcpy(obj->jumptables_data, data->d_buf, data->d_size);
>>                                 obj->jumptables_data_sz = data->d_size;
>>                                 obj->efile.jumptables_data_shndx = idx;
>> +                       } else if (strcmp(name, KMODS_BTFS_SEC) == 0) {
>> +                               err = bpf_object__collect_kmod_btf_names(obj, data, name);
>> +                               if (err)
>> +                                       return err;
>>                         } else {
>>                                 pr_info("elf: skipping unrecognized data section(%d) %s\n",
>>                                         idx, name);
>> @@ -5803,6 +5888,11 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>         return 0;
>>  }
>>
>> +static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
>> +{
>> +       return hashmap_find(obj->kmod_btfs->hashmap, (long)name, NULL);
>> +}
>> +
>>  static int load_module_btfs(struct bpf_object *obj)
>>  {
>>         struct bpf_btf_info info;
>> @@ -5867,6 +5957,12 @@ static int load_module_btfs(struct bpf_object *obj)
>>                         continue;
>>                 }
>>
>> +               if (obj->kmod_btfs && obj->kmod_btfs->hashmap &&
>> +                   !is_kmod_btf_needed(obj, name)) {
>> +                       close(fd);
>> +                       continue;
>> +               }
>> +
>>                 btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>>                 err = libbpf_get_error(btf);
>>                 if (err) {
>> @@ -5891,6 +5987,10 @@ static int load_module_btfs(struct bpf_object *obj)
>>                         break;
>>                 }
>>                 obj->btf_module_cnt++;
>> +
>> +               if (obj->kmod_btfs &&
>> +                   obj->kmod_btfs->nr_names == obj->kmod_btfs->nr_loaded)
>> +                       break;
>>         }
>>
>>         if (err) {
>> @@ -9030,6 +9130,12 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
>>         /* clean up vmlinux BTF */
>>         btf__free(obj->btf_vmlinux);
>>         obj->btf_vmlinux = NULL;
>> +
>> +       if (obj->kmod_btfs) {
>> +               hashmap__free(obj->kmod_btfs->hashmap);
>> +               zfree(&obj->kmod_btfs->data);
>> +               zfree(&obj->kmod_btfs);
>> +       }
>>  }
>>
>>  static void bpf_object_post_load_cleanup(struct bpf_object *obj)
>> --
>> 2.34.1
>>

