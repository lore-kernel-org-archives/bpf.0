Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013032.outbound.protection.outlook.com [40.107.44.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F935E1A3
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 04:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789359753; cv=fail; b=dMIon3tD2S2Oaey/VNz+fqZExCJVm/3CXfFs89KZdUkbcRFVJlENHrBMMaAm/u5Lmhi8b0VmZVzcSVZa8aJCHeI5DLwG/tZ1sklGX8gLzpBdFPptmJdlX+767ZccPOZk3y5rFxio2v5be6+TZol2bmtPyu8RW2hChMuDQNHMPuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789359753; c=relaxed/simple;
	bh=kOTHyWF8MuW84FiNm1wOpfVEPxt0Bcyeq5NqiUmvz3c=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQLK1oCWU2QeH5DfBw19ezLglJD2Tks5o4EjcoQAFK85a/gvcpu3FtHzbt8mH0+popjaxdDRy1O1KAR7RxyrFwEIJQ+ZHD2T+U32qvo2/cLSnbirU+RQJymUPyN8mhxBigsXdpjKjAVhGYlIcuu+xYmG3hlIuZf//aWB2FZw8n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JluO/vqU; arc=fail smtp.client-ip=40.107.44.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JluO/vqU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8oGlESuKr4GfHVpnwpxB9sewE3FvlQyHZNifmuvjmXP/wfbV9Lm+kUgbDGkoxwhETnxABxHpZ0bpUjB9fzobAxnIJUOCDFfhsf53pLz0a/NBDkuGzGRluL7d/ZN3G6muAj6dvbmEIs/GuMxFxrvq2vW9C6UrMGQeSfQD9ng1jOb43F9kbZmJcZnb4tJVLzG9+UpwYlg18DoQOqR3xeMCp5ggcic/VdqUvB/azLdNKXeWwwrBmzjmoYhhYMzdRrWx2BbyRwmtWV0X4UAtH/dyyv59BuitY0q9R9dXqE1fUCr4V+w3EWCCwsWCigcNfiBLdHWh0RHSpLHD4l0VdFWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mGh5f1+SWrL1D3GHLBgsk9yKZ38cT4c1R++JL/lLOY=;
 b=kiboGSmRfEq6tgwfWw5mQoKoZOEqCmmeeRrrDJiPjR61Jysr7cUUaA9qj75hzSw7Rw9Uy3mf1AKID58B7BUvbCN4T4i5bLFejDf77SzvhwjkUzZ1TQEaj4BOTz2+a94w627DMA4/grUYeCUdu1DhnjeOgx8t+C+uALx73Xz+x3NA78Ib9faF5nMsfG86lj118JA7/FFYi/EfHszWIKJ4s7ADwIHcBfcqHuNirKH5EBPzgmWpFE89Cf9JT+UE7mpxP9t80cxnHflS7lXv7nLboHTUcSVVXU5BvM3O90p6PL+aiRsb+Ai0ur8FVSzK6MXXnGhQ6X8t04R20fGgJoFicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mGh5f1+SWrL1D3GHLBgsk9yKZ38cT4c1R++JL/lLOY=;
 b=JluO/vqUvI6SpaU+Qt59GgCmkMLhpCzrrRCAesQTYpOJvd8tCmUc2BhNHaFGDFXxxpq9i8okXC3UTYJb2wVIwqSui4If/cDv+koBKNPlgMt+Wphz5+FYil2yxR5fxZ8XiMKnKpff/yxbJQPrdb57szniYFsu0tBQTcliXgBAh7meRVZrSO4XBkuycS/ezz+NJKYMZiuMUNg3MWhYoGBmcWV6dUUk1vMSSWfEUNQB61r7Vgzvfd/s9DiSEupuEqIanipnqlIRvVUtPed1rkwDYQh7LCNZwHInkxrifF8VeIqbJZd0wGPOjc4h5iqzI//Ov6yW9gGwz2CP3lGm9tD89w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KUXPR06MB8413.apcprd06.prod.outlook.com (2603:1096:d10:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 04:22:27 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 04:22:27 +0000
Message-ID: <0eb56403-6782-4126-b660-c5504ec35232@vivo.com>
Date: Mon, 14 Sep 2026 12:22:22 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v8 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, alan.maguire@oracle.com,
 olsajiri@gmail.com, Andrii Nakryiko <andrii@kernel.org>
References: <20260911120820.46900-1-zhaofuyu@vivo.com>
 <20260911120820.46900-2-zhaofuyu@vivo.com>
 <CAEf4BzYkY3ehPGei5Ra2xUJZHu-JcKLfPOuKeo3Ckks8w=OrEQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYkY3ehPGei5Ra2xUJZHu-JcKLfPOuKeo3Ckks8w=OrEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|KUXPR06MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 84739a0e-233d-41c0-c738-08df1217c87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jorNH2I4vIrpy+HNPPcdP0BzqfPIKPQ+N8HfsbDb2QzQKGeruay/hZF57+u1DORJVA4rBBYlsyeCim5SZlm4O6ynQQocif9GxMnhdQ+9viJTz+O6pI/+9xEjb58QbSQJQMdiP8nQo/VZpTSV4vSWfFUq0Vcf4g4EoDLFOPL+Go6aTvE0NbUn5+PY602+GLp4Om1hj3lMvs9hcl/p5H0CG6tPq/kUW3LNPharCVT48SbeJWZQ7BhVP43l2w4bJpvgMiTh+yUQGzYcB0kH4I+B3atK0fJDAvOfC3wUs7KvXKMTKLW33JfiAiSMea0BU00DYUxDOqJLR0Eqv7ZcdvwoBHNMr6w2yFQGDSHIAzHBIrwR+SEAaPd081ZRqFRQdAHc15Vl8uQ5ALGBXMM6ewmVp+Qn0IwMXYzrdonkoU97dKWCSvvvHTD1BeuKi/6dBwk22A+40oD1gJlS6EhqzyAXl719mmWAuxPde1CM32gKm67LJ78GfMgxGrI1wAYHipc/+hwYPTM69Dsuz4tufe2xU39rJzvZ0rUMxF6HTx/FxLJXZbQwqgKdn5nIENl1KNQgFlIqD9Ce4Gwpw5m5b/1eEMeBshL1dtYvIgX00n7q31iT/AHd0Wp2DFN3NfyEUB0p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEF4d2RqTXBoS2V0OVQ5bTk1ZGZoWWcrbFAvSGNkUHo0cnJBRFhyK0hIeFRN?=
 =?utf-8?B?dVVnbll5MGtodXd5dWZVL21sdTBQWGxOb05NZXlub00yRFpmWkZyTXZJM0xo?=
 =?utf-8?B?QnE4VTNVbEJQNHRqQXplV2pjYjVMOU1ETS8yOHZ0MFY0TURMQU5Nb2M3WElz?=
 =?utf-8?B?LzZadVhaV0Nzb2Z3VzJIOXlPbmFTc24xYlA2ZWdtdHRnejZxeUUwUGttU2g0?=
 =?utf-8?B?UmltVGVRMlh3QlVMM2I3YWxqOXNjY2dscHFrb1IzWjRQVmdRcmlacStGY0Q5?=
 =?utf-8?B?bDBqRDl3VHRUdTBYYnphamVJUU9lYWtZOVpjdUQreFl0dDhhMFUwVzVpVnBZ?=
 =?utf-8?B?MHVJY1MyeTFFZkdhK253WkJDWmpqT0p6QVZhQ3RqRWRMUVJTTE13UGxvNzc5?=
 =?utf-8?B?SWNJa3lZbVdMdUh6K1NKcHdDMXRZU0ZUZ2pyMUQyWUU1clRiNWpPdnRPWjht?=
 =?utf-8?B?Q0pHc1E5ekZabjdmdm53dXV5N1hlVFB1bUFwelVmVHVKcEg0dFVERUhIWkRL?=
 =?utf-8?B?WG1wUGRDc1ZxSnVsK1BZYUlrcXF2WVBwejFqSmNCV3VZeThHVjJDbThHUi91?=
 =?utf-8?B?MllmTjQ1ZWt5TWZyQThOY0QrWElxRm5VeWRtQzJVS0JhcmVyVGpHK1REVnBW?=
 =?utf-8?B?NXd4SmM0VzdPb0FmN2FSNVFOTFQ0SWlYSHM5eXBNL0dSMnJRYWhSc3MrZFRk?=
 =?utf-8?B?bFAyTXplUmdpYncwMkN4TW9nbTYrQVhFbmh2YUlldWZGYkg4QThFYXMyaHk3?=
 =?utf-8?B?VjZkUWozLzRONjNxR2dtZFZGR1ZnQ2NwcWdBVHBIdVZNS1luUTl3dkdKTDN6?=
 =?utf-8?B?eU8xMjBEY09PMHNHOVBFck13Y2hlcWpxVkFiR09oWE1qWlh5YjNOMUtoS0NU?=
 =?utf-8?B?V2V1cmVRN1NYWW9tYlBtSHhORHJIcWRLSXdoMDBHc0JjY24xWC94b3RFUDUy?=
 =?utf-8?B?eFpXRi9aeUg4Mmk3VWNSQ0FzYW45ZUs4OG80aHdWVEVsckdrL1lBZU9CeGUz?=
 =?utf-8?B?MWoyNkM2NmZqSGlzcjFFQkVNVzVNVFJNY2tLL3AySDJ2ODRTTjJWR0lkRkh0?=
 =?utf-8?B?OEx3WDNpcS9LcWw2eEt3eGF3emZuZFd1TndKV0ZpYVp1TFYvQVFoZEE4cFEy?=
 =?utf-8?B?cGNJWk9iR25LZS96R2RUQVFLWFp4d2VjVjRoYjlyYlNsVWZUTXJZaS9SR2Nx?=
 =?utf-8?B?Qmg0RXNXYnRCalVaaDYreklvTTJ6OVEraEhvYWl6NmFZb0VTYWdvY2g2c2Nz?=
 =?utf-8?B?TENCa2xtS1I1YjV2czNCcVhSenRJQ1lRejdvenNLOEUrd1cwZEhuVnRYS1BS?=
 =?utf-8?B?eGpkdENEbUhuTEc0d1J5UTRWdldwa1N4bW1nc3U5Y1BmWUNEeWdIL3BRcHRD?=
 =?utf-8?B?UEdsMEJscitwNE1nMEkwQVVpYTFWNEM2WFd3NW5IK1hYdzdoS3hUdFRpMkRl?=
 =?utf-8?B?R1ZFc2JYZFMzbnE0U0FENDl3SEV0RmtGNHIzUHRyTGxtN2VCYUcrY1U4cy9a?=
 =?utf-8?B?R2I0SGJodlFNeGFETWM5N3JVbmIyRk03dVZaRVJTdGNmQ1Bzay9WRDZ5V0xV?=
 =?utf-8?B?TnhGN1dqMjRsRUdHTlB2dHMySEg5V2ZXaWk3ZkJQeFhMQndMN1FuV1NmRVVV?=
 =?utf-8?B?b3duMEt6RGQ2WitFSWF0dlV3OCtHa082VUhWUFlDWmE5aXZybEY5bUE0Mjdp?=
 =?utf-8?B?Q1BCdG03emxkQThvbUJFaGZKbWlwNmFpQVROWEdFUFgvd0YxU1pUTDJnRHho?=
 =?utf-8?B?L24xUzB4bW96QWUzZHVNT1dJcE5WZjRURDg0Tjg4NzcyUVZGcXdoc1lpeGJV?=
 =?utf-8?B?QVljUk5qY0d0ajVrUlQzcnBPZVcvSHNwYW5aN2RvUG53UGhKMHpiWkRML0cr?=
 =?utf-8?B?NzlZVVlNck0rNjBPOWVkVjBCdXJlM3JZMjE3N0FCVGhDMVlSRjZWczcvS1li?=
 =?utf-8?B?UzdIRFB1OVV6MGIzSTlOdDZwdnNlTTJMWDBPcDQwbW8zTFliL2FSRGhEZHpJ?=
 =?utf-8?B?UWxMQTl5MnZHZlJtcVoycVgvMzIxYXd4RTRmOEQ3Szd2VlRWcVY0OEVCdEps?=
 =?utf-8?B?LzN5SGdQZjIrZjB3T2RacHdJYk5RelBrM0liYmNlU1pDRHBlcWEzTzQwVXdh?=
 =?utf-8?B?cjNCWG9IN3hTZ0RkNkVQMEd1OG1YOGM4blZiUmxUZ1h3bzlFUEFzRG9hWnZJ?=
 =?utf-8?B?SFM1SUphN000VXZkeUttZGxtN3pkV1lhdEhjWmhYVzBrVG9mNVpvVERkTmdy?=
 =?utf-8?B?TVNIbTRZcUJnektMUCs3a2pFbFl4aHFUeGhxTklyaEdicDRVYmcvOEl3eDJO?=
 =?utf-8?B?TmJJQlhiQ1NUMWw4VGFIM1l3T1cya0tCbVd2Rkd5VmlzUjZqK3ZIUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84739a0e-233d-41c0-c738-08df1217c87e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 04:22:26.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4wIUyIJXHBq3uP9c97zvLMhhUiX7mC6n0lMn7N91pBGpieebQFB2/cnqZLep1IzGbCvK9MNPSRJwhROPsdU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8413



On 9/12/2026 3:18 AM, Andrii Nakryiko wrote:
> On Fri, Sep 11, 2026 at 5:08 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>> Add btf_module_allowlist and btf_module_allowlist_cnt fields to
>> bpf_object_open_opts to limit which kernel module BTFs libbpf is
>> allowed to load.
>>
>> When the option is not specified, the existing behavior remains
>> unchanged. An explicitly specified empty allowlist prevents libbpf from
>> consulting any kernel module BTFs.
>>
>> The allowlist limits which kernel module BTFs libbpf will consult
>> wherever module BTF might be needed.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 72 +++++++++++++++++++++++++++++++++++++++++-
>>  tools/lib/bpf/libbpf.h | 16 +++++++++-
>>  2 files changed, 86 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index c036e8a91ed8..4ab7ddc3b4cc 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -751,6 +751,8 @@ struct bpf_object {
>>         bool btf_modules_loaded;
>>         size_t btf_module_cnt;
>>         size_t btf_module_cap;
>> +       char **btf_module_allowlist;
>> +       int btf_module_allowlist_cnt;
> 
> please use size_T for this count, just like other counts (both
> internally in bpf_object and in public UAPI opts struct)
> 
> 
> other than that, looks good, I was about to apply before that `int j`
> in bpf_object__close() caught my attention
> 
> pw-bot: cr
> 

Hi Andrii,

I also felt that using `int` for `btf_module_allowlist_cnt` looked a bit
out of place. But it does allow us to cleanly represent the three
states -1, 0, and >0 for no list, an empty list, and a specified list,
respectively, as we discussed previously [1]. An additional benefit is
that all subsequent checks can rely only on `btf_module_allowlist_cnt`,
which keeps the code more consistent.

With `size_t`, maybe we could use `SIZE_MAX` to represent the no-list
case. But I'm not sure if that's preferable, as the count would then
carry both the list size and the state of whether the option was
specified. Or is there a better way?

[1] https://lore.kernel.org/bpf/CAEf4BzaHTTEob-vmhmcRt1pmED+eBBLWnehEDUk=t7O7GUyyFg@mail.gmail.com/

Thanks,
Fuyu

>>
>>         /* optional log settings passed to BPF_BTF_LOAD and BPF_PROG_LOAD commands */
>>         char *log_buf;
> 
> [...]
> 
>>         err = bpf_object__elf_init(obj);
>>         err = err ? : bpf_object__elf_collect(obj);
>>         err = err ? : bpf_object__collect_externs(obj);
>> @@ -9626,6 +9691,7 @@ static void bpf_map__destroy(struct bpf_map *map)
>>  void bpf_object__close(struct bpf_object *obj)
>>  {
>>         size_t i;
>> +       int j;
> 
> you don't need j with count defined as size_t
> 
>>
>>         if (IS_ERR_OR_NULL(obj))
>>                 return;
> 
> [...]

