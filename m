Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012066.outbound.protection.outlook.com [52.101.126.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E241A56F
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005521; cv=fail; b=Q8YHiuhi28cz5q1DfxN6YxZcC1gg86ZaPSyhZM/SE48EKbAlAa9544JG20nAECut8OrtLTVul9AGLwXSGP4v/dPRecpsrYAiIZ5Pg7JEMFmKGVEZ7Yup3IJLutgzong8d9oVzY6rtN8ByWKgjh341oWjUzLTqcsGpITLVArGcoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005521; c=relaxed/simple;
	bh=CzCzFJ4ejSu05qLsAVM7hEQgb348LuYRa5bEsvBwrds=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l+Zl/YApnoHfjB6oHV25zUmHynyV1hnkIWG2CYCdSG/JSh4Mt368QKe8lJt11pUHlTc836rk3y3qejQQtPiloKcL8WkhTuxR4cLEj6o10s3BlmKQVWKezfE66J34Ap0oW6wTNCrWqhRhyGgfLH+A8H/PsHiyLBSN/qVjtcFVnI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JDoHs5am; arc=fail smtp.client-ip=52.101.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JDoHs5am"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp1XARjMRvx2abFDfdrCaPwdQzVaEARO3vxZOTWpRpTtOgXC9Iyy22n+IbUvUL22lhTnROn1dJfRD7rbS+YL/q4LCSpwgMx+2eYswMN7iwKOWTAdMv66QpeiJkrsJ2PfMpnhjyG9oSoXtPSKi/TeSMOfodzigYJ+8mmVz0H5vI69EIRc+UoJLpSGz26XI6lMQq4lgPuXLPf1SzziJZLvzhDFwEdWe+tTfK3XJ3tJpENJEFaXhy2IFCUJmYtK41kdKiYX9BPVcib/X1EIPhznxGJscuFSvqlmTRhHeViIR9t8KaQYC1oXmc5hjHbwhw7GGu0+FFnI1fWnr4xO0aiCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElUlVvXwy4Jsu93s6B8eSSLQyFUl8/aEp5XBzBMfauY=;
 b=w55hIVyYW4TmuiGhnwhBK/rh6kqaxjXF0qT8QM/kPvuvtUSv3J/+UGPGk3vbh+GopE8eV3C+cdgnAL2mbDGRwyRcR+QvnQOh/qYrO94ousHfY/cbAEK2IAO+xjvr+Yf0WV4kdTwJz/n8C3bJlWF56AdeN1Nv/PIoY1hdby5eIItCkDzHk+hv+XJaAIVFePFzQccSf026T0J4bpFzJJkZ3cM3ENSK4yk6Bu7GRD6JN/Ru3pkxGW1icVOgML3kb4YjnzIFyvYiYifh3JEhcJ4pMzL3x/a1Rkxs4JU+s9H8/dYzgkgr4Ryhwv/ffUtYwPWO+kN9jRtTHskFMvFBnbo6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElUlVvXwy4Jsu93s6B8eSSLQyFUl8/aEp5XBzBMfauY=;
 b=JDoHs5amBus4MhGjfd4MC/wqT046wq3GqtPR6IRJ+1WEKz0hvN8Jp60S/LZcJqHHryKrcJ80b/jg/TNrQYwqaPNhqM+H6ofUpEFBz16nALaEBD425DVkm7b8VZaBTKyJxzidSk22yLDE4sNVAYR4yzCA+VJmHyotRHOHk0N0i1XqH+UondLQGFybPUD6HVrWAeCiu36PgPzSXIXXWvT0m97DknmajNrfbrD2suaARB54HMc/jF8nUidrUBZnS594bhy1zlu3OSAhuo2oA7vH+MD3zh6XOhKLjWyGgg6NLFHs5M6Fj9xMUirPmZcUwp+rvz0gh/vXh+T8lBSSPVlApw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by PUZPR06MB5497.apcprd06.prod.outlook.com (2603:1096:301:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 08:38:29 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 08:38:29 +0000
Message-ID: <cf05f1ed-8590-44a2-8706-470f5cada481@vivo.com>
Date: Thu, 6 Aug 2026 16:38:25 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: support selective kernel module
 BTF loading via .kmod_btfs section
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
 <20260806042042.3239428-2-zhaofuyu@vivo.com>
 <20260806043305.D488B1F000E9@smtp.kernel.org>
In-Reply-To: <20260806043305.D488B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|PUZPR06MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: eeec5ed7-cfa5-4caa-45d1-08def39616ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zAddyUGU1rpMcc+IxfZHlHuMG7esx6u+//cf0hJ51pLtfT6ubIAa3w3dxQicLJyJZEY8UBQL9U22rYXBy7eOTy0vufszoSSi9AaINnXnBi8v6GyB4K5x+gSXuD5s83ke/NPRfxgOrULvWFqXqaic9r+xb9Bt52HQDt9O/xuiwmvBv+5Eb3Ebiby7vtaQVMXVULWQ1QWkaRVc1Z+5xhjWTOEfuyzq14tYQ0+r4tOC/A2d6DjfD8/13kqcxWbGrE8sDtzuU9Q0Cnua+fY4JNamMDeLDl5rQGXcI822nZM0ctqmkwz6wNGmVCXIyGziReaytduZ/1y5bIbUsdazRsDAe7UrTaZ0Wh+i2CwQP/WBrlWF5HXG5taF/rt7ndIOWJGYX1N8JU5CC5xOAnenLZZw1rlvRbABIHDxGcRel6i3xOnmU9GDFygdS8UWP9pExBpD6WdlWAZZ5aoVTJndNFNWKAwmH+6Qln7CpO03SuRR1DVXcWTW6h9uDJbJF5OnWQhoNjnyqz3mrBPQxIlajZaJSpG063Qtk0UaV6M+6Mh1WKCvmLifWvPL/fOcyVNqxHP8wX9TWsju4h+ATbtpjwUCdS+0dHZMCOSu38O3wIAMgwYz0bLa1m2sZ4QJwK3tK+YSP0r4Ax2iSQSy3FrVeIo+InpEViDiJT+sAfquDPxaUGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VldOaEl5R1l3YzE2MzN3U2dHL0RFQUZrbFBwWGw3VC9HSDN3UlZncXFidXM2?=
 =?utf-8?B?RkRMSCsvN2tOOWovWmRjbDV2WmM0QzNkVXlrNjUzYmkxZ0JxNTdPVk1TU05n?=
 =?utf-8?B?cUVuUC9jODExQS90KzdTa3d1VDFiQm9vKzRiMGVjYmJvK054Zk9SYUFRZHNt?=
 =?utf-8?B?NXpTaGlObnJMRk0xbFV6M2J3M3M5bmJsK2YvQzIwZFJma1pxdDZyUEtSV1o3?=
 =?utf-8?B?TzkwMTAxejJUZ21HblI1dVBJME9wUWVZbURiUW5QMlRuSEhFYjQrbG1hYjRC?=
 =?utf-8?B?OEVtUlNBUGVTV1JaK0s5QjVseUQxRGpQZXFKbXNPVENjM2RRSWNjQVBOYWRQ?=
 =?utf-8?B?Y29scmloY0Q0cFJBZmxFZnAwSFI3UmJaaEVhTmhKY1FMcjlveGFVendKNC9F?=
 =?utf-8?B?RDVxN1NGSFJaWkpYMHZLS2lSd0JOMUxETWRWeTZYRHRsdlY2TzdOTC9ac0VS?=
 =?utf-8?B?RWY4Smw4UmdBcHdJNG5IbGxiOXNEOEY0elZFQ20xd2xiMVFBQ2xEYThTMGVm?=
 =?utf-8?B?dElnQ3pUWmFDdm1MUlk5enRSc0FTSUxyc1ZZZit3MEFpcVdtcS9EWUVFWkVY?=
 =?utf-8?B?dmlac2szWVd4Y1FKbTlxSWVZdDRWSU9ZMFJPMXhUaUdFWHJYbkZBdlNYS2p1?=
 =?utf-8?B?V242cGNIVUFjNXVXNG80ekU5VXY1QXo2emhXaStIenR4V2xKZXhOaFZWSldn?=
 =?utf-8?B?MnJoUElLVytMcVNrNE1RYmJLVjJEOGdERnRuYTEyUVVQaGxDQTdhc09nQUZt?=
 =?utf-8?B?TDJUQ2tQUHVybW9GdmRTMDQ5amo4dkxDcFlWa0w1N3hZQlhMZGU3eDdSVnp0?=
 =?utf-8?B?VlhqSWxlS1owZGZyOWEvMWxHUzJwWUNlb28rK1hFWm5pUlVFS2paWlNFYk0v?=
 =?utf-8?B?ZVF4QlF6V1JhaFVXSWlrZFhxY3N4ZzMrVmQ2eVZERnpmNGV1SlhuY1YxR2pj?=
 =?utf-8?B?aTZlSy8raDlNNXpieHVvRjBpM0JscE10bzQxaGwxaUVSU2pXZVhCNFljN0ZB?=
 =?utf-8?B?ZWRCSEpxb2lpSWRYOWZ3V25kVHZRZy9JYStmRjRseW5kRkRVdFZYTG9zWk1D?=
 =?utf-8?B?QzR2MXZqN0htWUZwajVSUUlFamVMNnRzQWZDOXRJc2l3dlpPQWRPYUduOE1u?=
 =?utf-8?B?OXgrbnY2UHhZUUFWemJ5SE14UW04WEVVSThwdFBCdWwzM2Z3ejNtbE9BQW9s?=
 =?utf-8?B?bVFYS1h0WUNLTnlHdUJNWXFVZU8rN3Zqd0cyc3F0cVNYTklhSWZYTGN5cnE1?=
 =?utf-8?B?WXd5QWp0bHdSVkNGYnY3dWx2d20zY1BZOVR3MXE3R3lWUzV1aVhhUXAySk9n?=
 =?utf-8?B?ZGN2TDVQTklYOXhyRlhLcFA1MjBFU2pHYm9nYjJTMWVNREFpaWwvZzNqMmRG?=
 =?utf-8?B?UTErY1ZqN0NKbGtidW1mMlVUVUk1Qy8zWDZDK09iQlBnN3FIbGtLckZIcGNo?=
 =?utf-8?B?K0xUZmZJenlIejlRR2M0VjIxT0s5ZEthTUdrVTl6KzI2QVhFbzBvUm8xYTNV?=
 =?utf-8?B?NVNlbU1zQzZVSHNsOTh6L0lZVEdqenZCZzdUaS9tMDV6KzJDTDZZYW9HaEhw?=
 =?utf-8?B?ZU4zSzhPL1Y2SkVwRnY4d1NTd0lteTZmQkJudHhGWFRMOU1LcU5rTzRtQWwz?=
 =?utf-8?B?VnRmRUZIY3J4ZmNsWHZ3bmlsaDBnaXl0YXRqU2ZIMzNuM3FDbjRhbVMrMVBE?=
 =?utf-8?B?KzlEUmdqZTRlT2F3VWdIMVE4OXlrQ0g3bThnZjl0S0lBMGtoQ250K0VNZnlS?=
 =?utf-8?B?ZWJvZXE0aDBNVkhzREE3cVBhZzdWeDVNWDNGTFBvY05ENTNYbFR2VTk4NDZh?=
 =?utf-8?B?NHRtOUt2enFrNnpMRk16WFhzb2tIQ0Zla1drK3dVdXBpMTBudzZCVjlYMCtG?=
 =?utf-8?B?M3QzRDRMdlpzV0JINFc0cytmY29UTVhrQlIrTnF6RmFNTXU3ZzVqUVErMWp4?=
 =?utf-8?B?ZmtZbGZzVCs0WmdWMzJoUkFIR0RBNDBpRk1ZcDVhSHZvS0haY09OUjZrZkth?=
 =?utf-8?B?THdkT3B3N2lMTkVCRmpINkcxNnR1RlVoeDBSOFBPT2ZmTzdobTNaZ3lrODZr?=
 =?utf-8?B?R1U3V0NrTG9hR0NRemMrdGhDaWVWVDNMMFd2dzV3T3BqNG9IR2RtaG9hTUlM?=
 =?utf-8?B?dXpFd1hHemR2ZEU5MWRzb0s2bjczcXRyTWhuK096dElPc3J2SXJuMVIwQmFv?=
 =?utf-8?B?ZW9FOVJYNkdIaEhrZnBvTGJpN1ZmZ1J0REk5M05XUStSanBrQnB2Q1JCZ25u?=
 =?utf-8?B?cjdKVllxMVhkd1c2RzA5M3lFMUNCZUY5OEpibTNqeE5iUFF4ZFIzUmJVYnlK?=
 =?utf-8?B?YmZtWXVJaW9JMDV2WXRFVldCdjNMcVdRU2YzQUlLMjJEZ2gvS1ZNUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeec5ed7-cfa5-4caa-45d1-08def39616ef
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:38:29.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J62oXZu6BJMAfdrD+jC3UK6daB0X8QkCz0CuGTMzoTTJuRh62eD/yoRBBH+FTf7w3TrrSuPXJdDZ8kToBUtXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5497



On 8/6/2026 12:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Transient stack pointer overwrites persistent hashmap key in is_kmod_btf_needed(), breaking hashmap integrity on bucket collisions.
> - [Medium] Memory allocation failure for `obj->kmod_btfs->data` silently returns success (0), masking the error and corrupting intended behavior.
> - [Medium] Processing multiple `.kmod_btfs` sections overwrites previous allocations without freeing them.
> --
> 
> --- Patch [1]: [RFC PATCH bpf-next 1/2] libbpf: support selective kernel module BTF loading via .kmod_btfs section ---
> commit 5306ac18160e3a8c2a0f3dd2eda202169f998df6
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> libbpf: support selective kernel module BTF loading via .kmod_btfs section
> 
> Add support for a new ELF section ".kmod_btfs" that allows BPF programs
> to declare which kernel modules need BTF loading. This avoids loading
> all module BTFs and speeds up program load when only a subset of modules
> is needed.
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa825..5cefe82e4a679 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -901,6 +916,68 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>>  	return -ENOMEM;
>>  }
>>  
>> +static size_t mod_name_hash_fn(long key, void *ctx)
>> +{
>> +	return str_hash((char *)key);
>> +}
>> +
>> +static bool mod_name_equal_fn(long key1, long key2, void *ctx)
>> +{
>> +	return strcmp((char *)key1, (char *)key2) == 0;
>> +}
>> +
>> +static int
>> +bpf_object__collect_kmod_btf_names(struct bpf_object *obj, Elf_Data *sec_data,
>> +				   const char *sec_name)
>> +{
>> +	int module_cnt, i, err = 0;
>> +
>> +	if (sec_data->d_size % KMOD_NAME_LEN != 0) {
>> +		pr_warn("sec '%s': size %zu should be multiple of %d\n",
>> +			sec_name, sec_data->d_size, KMOD_NAME_LEN);
>> +		return -EINVAL;
>> +	}
>> +
>> +	module_cnt = sec_data->d_size / KMOD_NAME_LEN;
>> +	obj->kmod_btfs = calloc(1, sizeof(*obj->kmod_btfs));
> 
> [Severity: Medium]
> If a crafted ELF file contains multiple .kmod_btfs sections, could this calloc
> overwrite a previously allocated obj->kmod_btfs and cause a memory leak of
> the hashmap and data arrays?
> 

Good catch, thanks! I missed the sanity check for duplicate sections.
I will add a check `if (obj->kmod_btfs) return -EEXIST;` to prevent duplicate
section parsing and fix this potential memory leak in v2.

>> +	if (!obj->kmod_btfs)
>> +		return -ENOMEM;
>> +
>> +	obj->kmod_btfs->data = calloc(module_cnt, KMOD_NAME_LEN);
>> +	if (!obj->kmod_btfs->data)
>> +		goto err_out;
> 
> [Severity: Medium]
> Does this error path silently return success?
> 
> Because err is initialized to 0, this goto err_out will return 0 instead of
> -ENOMEM. This causes obj->kmod_btfs to be freed in the cleanup path while
> the function signals success, making load_module_btfs() fall back to loading
> all module BTFs.
> 

My apologies for this careless oversight in error handling. Leaving `err` as 0
here indeed creates a dangerous silent error.

I will assign `err = -ENOMEM;` right before jumping to `err_out` and thoroughly
re-check every error path in the patch series for v2. Thanks again

>> +	memcpy(obj->kmod_btfs->data, sec_data->d_buf, sec_data->d_size);
> 
> [ ... ]
> 
>> @@ -5803,6 +5884,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>  	return 0;
>>  }
>>  
>> +static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
>> +{
>> +	uintptr_t val;
>> +
>> +	if (!hashmap__find(obj->kmod_btfs->hashmap, name, &val))
>> +		return false;
>> +
>> +	if (val == KMODS_BTF_LOADED)
>> +		return false;
>> +
>> +	hashmap__set(obj->kmod_btfs->hashmap, name, KMODS_BTF_LOADED, NULL, NULL);
> 
> [Severity: Medium]
> Can this hashmap__set() corrupt the hashmap by storing a transient stack
> pointer as the key?
> 
> Looking at load_module_btfs(), name is a local stack array passed to
> is_kmod_btf_needed() on every iteration:
> 
> load_module_btfs() {
>     char name[64];
>     ...
>         if (obj->kmod_btfs && obj->kmod_btfs->hashmap &&
>             !is_kmod_btf_needed(obj, name)) {
>     ...
> }
> 
> Since hashmap__set() only stores the pointer address, all entries will
> share the same pointer to the local name array. If a bucket collision
> occurs, strcmp(key1, key2) will evaluate to 0 since both point to the
> same stack address, falsely matching existing entries and skipping the
> requested module.
> 

This is a valid point regarding pointer lifetime.

In v2, I will update `is_kmod_btf_needed()` to store persistent string
pointers from the pre-parsed ELF section instead of the stack buffer.

Thanks for pointing this out.

>> +	obj->kmod_btfs->nr_loaded++;
>> +	return true;
>> +}
>> +
> 

