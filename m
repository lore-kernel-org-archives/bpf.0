Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013023.outbound.protection.outlook.com [52.101.127.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF45305680
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629349; cv=fail; b=fWiUBMSTdLzcfSVkBZ/IdCLP3litmDudqlRrnyN07byO0GLyXb53LQSFxXUEhqWNX4NApIafWsMTbeSy2Lgne+1mf6Jo8Pyj3Nc6Ai8yPcKTUaz914NlBXcumGn+GFNM2/VigGFXPItY8ZH4rLjzHIWbekNfwEdATjUSuvwd4BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629349; c=relaxed/simple;
	bh=t6uKGfZLEoAfsKYuc7CHHph6a0xiyKZvr75SWejqqzo=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hs1GQdj1jx4txbZE6PLmpsaV1aJTSAlw0aVfVoIAk3b2sE7dAgj60zlk50GzVJAlz+ZaEFNFHj19o7M4CCmj/+jyfckHktsuizR2WjejwusxqduWiSFCGyDd63Lgba752ZbbsmbgCLqgqzf1kWUci4+OIBArS5gb9QamjhInSlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T4K7iZet; arc=fail smtp.client-ip=52.101.127.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T4K7iZet"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/NnG0hnSKxGFKFHjrfk2/DuDabSwxNW6luYBDIeRUZMipPhe4FFog4hlrwR+vAqu4z8FBF0I1E0RDlup2y11qafGK3bj288qdmdeuVTGkPaXJ36mBgDYjg8UBJnalPsxOHTmkx6Tf+p8q9ib3H4d4AHhGLBUXxZtlhEmbv3JY9MLu9B64D2i/MWiKUfe4HWZWPtMgDmfPVlMP3nBIPRDxnNL7PKQOOVn9HfYt1HPx0ukMe9UA8caRuusrVJCLBrF2mGxFw4oWfhsyOHYm3Uy71A/JLuCNCFro2OTsnQWcDN+DenHQoR48294VNqWjgfrSFwdKnfE0uq/V8ZsgyM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU9zVG43/+BjZXme8wiL+oDFGPr5j37iNjnxlaa1srk=;
 b=H4R5e+gHCym1PsCxgSnvFzwpASQvK97Std9fSpavu0uaoEAEhDilu7a4sqdf07c225qUbsz1htix0Sb51V4bfr/AMnsSzVoWnyDnFk+0mOGrk5Nvk+CLnQ5/N4qxDV8dPs8s2vv9MqgEhvWLaxB4FQi3NOh/BHT5d+E/60lz/TBOE9+ixymxp56qpUCx+4Dc9dcs6Q7rgn3UW8iLkQ0QhXggi4sXf1oClnzNOMCO/y2hwGcfkAUWFvLz165MbBmmHKVxjDjIYCUpsRyS14Z3j80UYqmsuK1l62RWMtImknKTpEpQRfih/rzrHwHjQPoo6re8kczpzys9HDT+P0HNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU9zVG43/+BjZXme8wiL+oDFGPr5j37iNjnxlaa1srk=;
 b=T4K7iZet3Ny1Lli4A8KKe/wJYE6212mndlY4CTawf7Y+Y9dLADIW1Udd6LEwI2Eh+BFZdtFeyFvzmPN9OIKIozLJ0J6MemHpx/H/Kqh7SObwBcvPJ5ceC0ZxKHetBaReaPxq37ykilyWz2X2kCIETaah7zNg5+KlLCOXlaLVyuIK/QbzhROiYcnKjpHQEpOu6LK3htbdMeDncyB9KmFPpeb9n/9rUZlKq3ZbE5K0D9mf9LBzdV0YPOTHtLjwnNUJKhy7nhK3iyFfjbQ03OJw3Zzf3I9aoj2gYlHKlavBsRsjjEO9Feaz+6QLJiidoW4eebiSy+pj90qNZv5tMq1FkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KUZPR06MB8967.apcprd06.prod.outlook.com (2603:1096:d10:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 03:42:23 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 03:42:23 +0000
Message-ID: <507d54af-a50a-4370-b0ee-ea80c87b1a45@vivo.com>
Date: Tue, 25 Aug 2026 11:42:18 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v4 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260824125310.1384-1-zhaofuyu@vivo.com>
 <20260824125310.1384-2-zhaofuyu@vivo.com>
 <20260824130806.51B591F000E9@smtp.kernel.org>
In-Reply-To: <20260824130806.51B591F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|KUZPR06MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 341259d2-b408-455c-3baa-08df025adf44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	yBLiUnURVm7V0Dud2IPIhgMbbQthv4zRToL7RKLDGxhdRzaPCb0kZ/kIY/SxpAqJx1gyWB0tpIjrhSCEHxdQvJSWHf5FUzWlQzGP0/IovgivXrABI/Y9X9o4nL/X3inLdlCkbQwzKaIyvyhoiXX9gg8eCGQGhBFknv7ryDTRGD4Y0ylfgIHdat20j1hKDnvRUewDqfYkQXLD12LzVn+/xyocTbu4DtdZA1jPHn9La3xXT5ECqrT28QdYgJiSC+24CV7AnqT5queXH0OFBhIZVSJaatIg94JigGyMFrQqgr0R4qfKdVWcGj6YGQDDa3HceUYan/A7vqogHF9I/yfi5gLGBAP/25I5z0Kg18jc8V+yhr4LyISjZaYkFV841zqKkTxaz44L3tCibhMUdB2WPISmLk3KiorlE1cd80X3vdXPmP/w7Uab2Qdo8uC3zfOWAqOH7b1qhRawIWl6TxX7mp2qRQxpT32RjLHYUUsFWU39q5Uo1oN53f1ZfME2lz+myMZSLQdJHbokwGSMCv+Dy9AeVgZwmvp10Xocvy03uRpdfgoKsX0gUXdYNYb0Hlf//xCjsUyPwf1AMjhreVgm+ttZeLuXIArDPQ7uwcubi8Z/363riYkphmHQkH6j921MQ+PpIF4nH0D7GaN3n1whSV6wbFsQSAKZbjl7t+4Lbuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEw0QStMY0VtalFFc25GYjFWT2pKOXljYTk0ZDJpY0RNaERNK2k3VTRubXhY?=
 =?utf-8?B?Q1M1QUYyUmp3YklkRkkzOTdlMVJDdGc4c2FOclNBM2ZpSUw2TXJ1ekZ0ZWNu?=
 =?utf-8?B?Tzl3YkZJemtQcExTUEtmcU1sRzdDcmgyR05OQjlQTEkrNTFncDhSTzRvUTRJ?=
 =?utf-8?B?dGhZYzBJN0lKRHhaTTh4U1pHcVJJYmU4RGNjMzU1N2J3NkZrNG94NlI5UzMr?=
 =?utf-8?B?VCtCMGIxb2hYRHAvSFlsbGU3TlZSVzZOcENGOTlQbjJYdDVobHE5WUYxZDdi?=
 =?utf-8?B?MytVWWgvR0xhVHhwVGF0NVAwLzM2WjlNd0h6Zyt0ODhRRG12MjdEd3NoS0xW?=
 =?utf-8?B?MkFhc3ZiYzNFT3drZWhHV0pzSmVkWWducVRvT0RLZ0k4UnNJcEROeTNQQ0Jz?=
 =?utf-8?B?WFVGK1BsWXJSUjVDMEZBSG9mK3AzVjk5aEFzU2hwd1BMNFcrNnMrUDlDcndw?=
 =?utf-8?B?ZnZiUzhmODJubWdPbGZrODE4aGxhdGdIZTNXR1REeGhtUlRkZjk4OG9Wam5C?=
 =?utf-8?B?MHE4VFFlQ0UzWGkwdGVDcFYxUG5IT3lIRk5sNEJEdGNkNHo0T3hyUlJCTENV?=
 =?utf-8?B?SGsyeFZSYUthYTN0RzJ5TFVYbzVyWVhkUVVFcmp0MTlnd2Y5bzAvYkxZN041?=
 =?utf-8?B?dnROUnp6OURkRUU0cnRDdDl5QS9FUXdaZm1BdmJJMU01Sm5NNnlJTktpUWxL?=
 =?utf-8?B?YkgyemNQQ2JqOGx0VnJLa0pxSlcvd1Fzb3VzWk9KNWZDQmgreWttV2NQUFNN?=
 =?utf-8?B?Uy9HR1AzTzY3cTJQWWFoZmtDVm5GdWJHQ0FiWFNaYXZiTnlaWnNoUGtiMTFr?=
 =?utf-8?B?Q2YySnNONnU4WWszVWFXamlmaHlMdldVWWI0U3dwbnIyMTQwRU1oSlYwQmNy?=
 =?utf-8?B?ZU5aN3EzMWE1ZXQ0NFFJUE0zWThSZUE0VFN0am5NZHFaR2dBTnRiU05OUGFL?=
 =?utf-8?B?U21lUzF6SHRrMVlkRjBrVXFlTzBYczNKYWpmdVlWWGxmNXVsRlIxL25oeDl1?=
 =?utf-8?B?M2R1dVJSaHJmZmpyUWdPbDRma2U3MkRNQ1RiWmsrS2hqRjBHU0FRenU5WGwv?=
 =?utf-8?B?aDBuS2duNVRETnpkUllaTGxHNmMwUldiT09qQVRsa0UyZ0pST2FqRjAyRVJn?=
 =?utf-8?B?dVNNRGtFUWhTemFNT2g2SWFjbkY2SnVJNVBjZ1M2SHZtVVJ3STJIUzc2TXNH?=
 =?utf-8?B?VnFwL043OWQ5UElFZUhqWlVOemlLMEJDaDZrZlZnTVhEajdwVzdwVzk4ZlBm?=
 =?utf-8?B?Z1ROdzRORTZFTUlJdVppZ1BwMEVDcXNKREZXVy9idGdqV0U3c1dWSU03QkVh?=
 =?utf-8?B?VmY2QVlyMXZGZS80Q3Y5ZzI1SWJTSzhGNHAvOTg4UUFVbWpiQS8vQVJBWVM0?=
 =?utf-8?B?ZHNmU0JiZmphWVh4dUxFNmZhUVZHTUJEaG1Ud3ZNU25NQzJaZnNrVWwzZVh5?=
 =?utf-8?B?cWQzSTN4MHo0bmhLYUJhSGdtbk9QeWxud3JvZE4zQmdhVkloeGRlR2hWNTJq?=
 =?utf-8?B?OVFhMWRaeVlXMWZPL2h6TkhZYWVIcmFEcjFxcGF6bXRGYk9ubThWeC8xb05m?=
 =?utf-8?B?N3gvc25ZZnJJcGxYTTNWRTdlQ1IyN2ZOOUdHSjgwWi9TWi9KOVE1cnNGRStw?=
 =?utf-8?B?WHVTQ1R4ZXkyYzIwNHRyZDczUTJzeGx3OS9ZUmczTVBiZEZ1K2ZDYzVrelJD?=
 =?utf-8?B?b21Xd0ZZdkFrMFJtUWxSR2NLWlcvRitkOU52RXVvNEVHVG1wNFFvYjYvbDhM?=
 =?utf-8?B?Ui9jVFlWUm9memc0bW1QenRyd3k5QUUrUDJmSEg5TlVOSFVwNk9XNnBrN2lz?=
 =?utf-8?B?K2NLRHhPdE0vajNpVjVBdEVhWXJUeHNzSFRmY2s3KzVjdStpZE5FeUx1dnVs?=
 =?utf-8?B?eFJpL2NzQU0rdlNKR0kxcVhjZVRGYXI5N3FMdFRhajhrNllkdmJnS0g3SWNE?=
 =?utf-8?B?UWRtZ3BmK3I1UE1vb0REQVo4UXYyV3cwMFdaMHo1dHN6MEtxdTBKeU9yWldB?=
 =?utf-8?B?L1p2MmdaRW92S2R5TDFxQkRNeERSUHdwY0l6T0orNUx0Vm1kaHRsV3NuTUcv?=
 =?utf-8?B?ZmNKY3A4Y2ZnM0hzZktrM2U1MklTTVF4dXFWaXdMeVFuY3hVN3lnNk5GR1kx?=
 =?utf-8?B?QXVlMm9HWHJ0ZUE4MkRRaGhmMllpVWVteFRrQWtIMGdXTE42cjRsOHBTR0NK?=
 =?utf-8?B?N1pTRCs0akZjVjZNY2tvNVBCbGhKNnBCbm9Ldk41WHI2THJaOVNEWmMwZUZY?=
 =?utf-8?B?YW5xK2dxdTBDWHVqSkdPby9vUzNoZjU0RnowTzUwZC9hMVh3WWtDaTR6Znpk?=
 =?utf-8?B?U2ZBaEt5TG1NdGlzbExSckFnVUJHYWZsSlVZMkZoSUUzTlBFOVZQUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341259d2-b408-455c-3baa-08df025adf44
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 03:42:22.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjTvJrK3R54MeFxKpwye+gbCi4tU7qy7cgt/Yy75l2I60QjnKq1eLldZNsdHGhGAFm2Yu4lAXBXw4SMsJ6oFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8967



On 8/24/2026 9:08 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Failure to short-circuit BTF loading when the requested module list is empty.
> --
> 
> --- Patch [1]: [PATCH bpf-next v4 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts ---
> commit 45ee1cea8b0fa604bfa594a065030f18301877c5
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> libbpf: support selective kernel module BTF loading via bpf_object_open_opts
> 
> This commit adds btf_module_names and nr_btf_module_names to
> bpf_object_open_opts, allowing selective loading of kernel module BTFs. When a
> list is provided, libbpf will skip module BTFs not in the list to reduce BPF
> object loading time.
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b749c01742ee0..d8ef6ecc6f5dd 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -5851,6 +5854,94 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
> 
> [ ... ]
> 
>> +static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
>> +{
>> +	return obj->btf_module_names &&
>> +	       obj->nr_btf_module_names == obj->btf_module_cnt;
>> +}
>> +
>>  static int load_module_btfs(struct bpf_object *obj)
>>  {
> 
> [Severity: Medium]
> Could we short-circuit this function earlier when the requested module list is
> empty?
> 
> If a user passes a non-NULL btf_module_names with nr_btf_module_names = 0
> (meaning no module BTFs should be loaded), this function still proceeds into
> the while (true) loop, issuing system calls for every BTF object on the
> system.
> 
> [ ... ]
> 
>> @@ -5915,6 +6006,11 @@ static int load_module_btfs(struct bpf_object *obj)
>>  			continue;
>>  		}
>>  
>> +		if (!is_module_btf_needed(obj, name)) {
>> +			close(fd);
>> +			continue;
>> +		}
>> +
> 
> [Severity: Medium]
> Does this continue bypass the early exit check when nr_btf_module_names is 0?
> 
> When the requested list is empty, is_module_btf_needed() always returns false,
> triggering this continue on every iteration. This skips the
> all_needed_module_btfs_loaded() check at the bottom of the loop entirely,
> causing the loop to exhaustively iterate all BTFs unnecessarily.
> 
>>  		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>>  		err = libbpf_get_error(btf);
> 

This makes sense. Passing an empty list currently causes unnecessary
iterations. I'll add a `no_module_btfs_requested()` helper before entering
the `while (true)` loop to handle this case and exit the loop early in the
next version.


