Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013008.outbound.protection.outlook.com [52.101.127.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF945C6F6
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622432; cv=fail; b=S6QMfeWO6TAud9PnZ07MBeMi8dbbYRk7gvL/76pCxeNEMt713w2RDhkgEfG6Nby00v7w+yb55izcBs2I5ixIwBPzMF5JSCBPmy2uCXu9SSLi1yb9L4gAVrpNHEfYcG9uBIzKM9B84qxWlYIb/95xX3jSbGWlLPbsiw+gXd0BlQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622432; c=relaxed/simple;
	bh=WzlWjXd+ITz5CGA+YV8mt/gPm4BaecoDkJkSrgcEnNs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h8sr+JAacKTJ4IC2EBrEV2rQMkglDJSV29kkhaiOt8HRBp0G5W8wc5966E2f7Nhg4EwqLOUosL3wyplIfcMgKdOU6lb9lIOZyk7PjIYRxUmkDHDs8lovdPSpg4EzKehf+AONJWKMJtLkHBdT4tQ/JdVXS/6TwVzE/Cz+mJBAoqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XvLv49lQ; arc=fail smtp.client-ip=52.101.127.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XvLv49lQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezztbCnBHuJ74NtLeZMbUbX6dNRuW3vJvbnAjvVW9M48GeN1Eust9z4upgSV8lQ6baLLFXAnYfoFqC0HCFRFUunqU3TQ24tQpUAGKyGWJCTqvxWAXMU9srfcVTXscmhxDsKpO4oqLUGqXFYGAsdyAtcG1I+f8KCDasQ4GNsyEZ6DILrk3Ww052NtIBTMteyunTQQ2uWOHl+jcjySIXjIcFh+C4Dmjn3vZ63Bq3P8fLbkCuMELr+J4Lv9XLwXtVJEr03eIlEVuXlWqmBItvE5UmuFQV3UQFU9Kky+Q3ilmE/aW5utkhK6gQMV/NxRpLtayA3PoHEkOt5v1LRuVVgmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKfjHeopNpfzde/ZrmQSGd2AZoUmJ6I5dJmzG1KdqaM=;
 b=D66qXcmNzV/wptZWxKx2D/iK4dyTx5WOLnfgN8I6/iQTMiO6ViifvomnPxmIvmfqa0zwHK6IlEW4BBS3cZzF7xS4pSNDtEWUTSt4dciWIZkSTb7tUsYhkCoCv6FCi4MU4yfOsknCyq0bXCKBXh4Ib01oL1thMlOREkcb9J400O5RWmWTRgCHsxLYNKMmGfPuhd69dysxUWNp7IBAsn1oxXNVYRvkG3Svr8kSqEjwRPiGfNtKFSGFpfI+6Sz69bkoeQcVfkFilfUGBbxzG2afrvpq1WBytlecAh1DfL+ZMbDVJkU7zWwAhFaxQbOplaSueiarcQkg4fxzM0CKzFWiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKfjHeopNpfzde/ZrmQSGd2AZoUmJ6I5dJmzG1KdqaM=;
 b=XvLv49lQ6uxDDPL80wGDpptQzxnj6iymEqDksabsr0bfM5gf2voSym0I0qyMX3OHvNlSx0/E82HbBCgL/YX6Ps6QpO9OcBeKFI7103jo7yjTGfMdqHu52OZpy2DgRi0ZkRo9nnQ4RHihMr7yKfJGqyyQso3AEhzgw6EZ4HVLDqanV93LPBBba5o1U02l/9vdEiDaSMvAGDR96MVu6QvxtIvPw+iRIkcKgcSvWeA7uZVVO/tIsJmh7AAReUZhogAZBMu6eOdGszbuVCxMWz88E9ezm/F3K4RMTb44VK9/KY1Db6xIeCssr55LUccoMe9GlVxaVGCu8pMkS+HQv90l5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB8092.apcprd06.prod.outlook.com (2603:1096:101:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:00:25 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 12:00:24 +0000
Message-ID: <aa3bb684-3eea-4478-9298-7c97f4f653ea@vivo.com>
Date: Thu, 13 Aug 2026 20:00:20 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel
 module BTF loading via .kmod_btfs section
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813032613.2755-1-zhaofuyu@vivo.com>
 <20260813032613.2755-2-zhaofuyu@vivo.com>
 <20260813033753.B09FA1F000E9@smtp.kernel.org>
In-Reply-To: <20260813033753.B09FA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEYPR06MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 34750cb3-718f-48b4-d65e-08def932750d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	hFi2EvumFdm1xG6NkWztVOIZ6qRGEdwk+xGYo1a7KJwPRHFvr4zG3Wc51ScZhe2HkJo5id788gRrbLsqRAKk2rFwGS9z32Ei7l6adEUPErQnb74BDBBgvylPvPoX8kvE2/IjOoBuWg84qXfn9vVjkeKOfLTyXZck3epts1eCKaMBQlHxmszRNNpvizcrT5MxXqXxCmMLW4mUJhAESWeCkm7D5TKhMq3auGwMobXvIT9NrzOuqOsPgJ7RCxbiAcniyeGKExVJKdxM7ezF+RHj7hj6HA5LABe48lAJewPTwJEplUVp7kMA0QQWDCP9Anht+LaH7BfpTHhCFn35EhHu2d3kMdz+D8nleku+LHgOYTzRByakYvlY4IukWnHv1zEWkBpFU/ErOl+8GDpw7o/MCMrQ2SZr3J3/sxfCLULPUmRrV0E6ZZk74vw2JujaHPwud2O7tVbHP+5Ai4mBnL0iZUlGTvObsMsRADB+6DjXHX8rBjF9uPP4M2/tD0Vz4zfZHo4XCRiXJar3MOg4lK372ggHHQFh7yHVEU6/lz3gUCAqGzCBegH+emUiuUK6RG9NubzmKyS9dFnDXF67Xf56pc9nSNSA6reIdI5KR1Ct5nAYWMTCsquk81aoRVr10fkCB5AhMiXqU5zmz53v94m2u7lWAz4l7PUn5QCmfmNZeJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFdZN3MrQkVpTjM1c3hzRWtxcGFTZDNJU0UrQndUTFZBSEF2TGZDZVlnVzNm?=
 =?utf-8?B?TUFUUHNGWGRrd3V5c3BidXM5S0RoK3FiNVV3TllVR2lvNUNOZDVoUnl2VkhJ?=
 =?utf-8?B?MW4rNWo3OTc1b3FTQlJPejJSOEZORmlRY1FSMmpiWEpYU2I5MnNRMjFDa3FH?=
 =?utf-8?B?VFA4a3MwaU1kYjJ0QVpPaUNBODB5V0NUQStMVUUzc25ZZ09Oa282UER0cmlE?=
 =?utf-8?B?OCtkTUdLVDR1KzF0SDZyQnRmUmsxcEUyYWI3dkxETFhxWlhzbmJCNjd1bkc5?=
 =?utf-8?B?N2VhTlJHUjVST0w5Nk4wUlVZaDNrbjQxUVdzMFRGanExKzc4dnB4TG0zSUxW?=
 =?utf-8?B?a1F1WFJPOUFNVmNQV29tZXVFSEo1V0hHckRYcWtqV1Vaa1E5ZWxNQlU3Rk13?=
 =?utf-8?B?L0YzcUFIZHlOcTBNN0ZPeVhHOVYwR2tZN1dWTnRqMnhTOWVMWkxlYk1iQi9u?=
 =?utf-8?B?SnJ5OXZyeVhYay9ieHRMd0xUNU9OdnhkdFVOZ1hQWHRtelltWitwbkpSWERP?=
 =?utf-8?B?Tk11V0lnYVpTYTVLNXhpY3QzY3NZVVREZGMrdnFYaXEzeS9ZMCtDeG5MMDJC?=
 =?utf-8?B?ME91WXk5YSt6Q0w3R2dudHdaWGlmS1BxTVFqeVRBRW1NZ1VLcFFJbWxxYlBP?=
 =?utf-8?B?SW9KNWZTTUdGRlV4RHZZV1ZtaTRxRkVQVFBqMnh2WkVEZ1FBUUxMTnMrdjRw?=
 =?utf-8?B?b1lNcGZrTDh0MWh2VFBaaTBCTWFiWnZkRC9zQXFpWXhYSHJ3Q3JiTEFSZjJv?=
 =?utf-8?B?UVBpbUJIUzFwNVNNOXB5SnhVVGl4cGlqQ2dwekw0RnhyTGRqbys2a0FYYUpl?=
 =?utf-8?B?WlpIM0NJYXlQcnh6UmNrVHYyMVkvOW0vMmJJeE5EN0xucDZFaFgweDNUYVRl?=
 =?utf-8?B?VGE2R0hEYXpyYS83VnFFRFNhNFh1VG5ZdGJieitnYXhFbVpMU2VXQktydThj?=
 =?utf-8?B?SEJFZmsyUW03S3pjWmpDQW5Odm12Y0ZTMkJZRlZnZ004VHFmeHNGTmhXVVRJ?=
 =?utf-8?B?OVIyQWFudW9qVlovc1hTZVRxTElFcVZNYjVWRzRCdmxJRTdVOHhhNWxjWm9C?=
 =?utf-8?B?bk84NVVxL3ZrSXZlYzNIOERVWTF2b2dHbm4xTEVhWEdGRHVzS01ZWEZJSVV3?=
 =?utf-8?B?R1dObGVwZzdIVDNCUW5NTmFwdm03bGE2N25CK3ZucnlXTVp4aWhZTmcyUVMr?=
 =?utf-8?B?dExiQ0NDSS93Qkk2Vk45SW56dXpwY3VyN0dyTkdsa2UxSEJPMmxtdGJMZjg0?=
 =?utf-8?B?MjhMUWlWVGZJWlJrNlhzVmtqK0RvUVZ0ODRmQUlycnZVV1lmaUIxeVBEUjJV?=
 =?utf-8?B?dHMyK2ZOTm1RTVJkN1Jjcll3Z0FzTm9OdFNPVVYveFVoL0lnWFpkWVFNVlJE?=
 =?utf-8?B?UnNrcVV5ZjBFYm5pZC9FMVMvTHhNbXFmakZUb3RyMEpzUUxHd2YwRkRjLy83?=
 =?utf-8?B?M3VVV3NiOENHcTcrQmdNeXVtb2E0dFBCWXZSbXcrVVNhclNQYU11YXNXWUVq?=
 =?utf-8?B?OG12NFpvQzNiWlRkL0J3N3JibzJQM1F4WkMyNUtMR0NqZlFqZzU2OXVBcWR3?=
 =?utf-8?B?clBvUUNoTXpFdVRyTHJaSjZpZTZ3OVdSUHBtcXllV25sZWJBK2ZYWTY0OGc4?=
 =?utf-8?B?a2RoRERKU0RhNWFreW5XdlM1UFBOdVc4dFZ5NlpWSHY1ci9uL1RNeGhDMDFn?=
 =?utf-8?B?b0ZLTm1lSWczWXhzMVRPUkYyMHZIS1YyZTJJTHFXbG9nK3Rvc2phWmtOS2xm?=
 =?utf-8?B?eG9MblJaWmwrZ2lCVTZnWW5ST3JsMU1nTkF0dUJETitEa1FUbkh2TEhPMkpq?=
 =?utf-8?B?VCtaWmx5cmV4djFhS1JWNzA5Wkg3UUxvMjNPcVNKOTBaZ0lkNWt3SFVSN0JG?=
 =?utf-8?B?bFVzYUFKTDlHcTNzaFhaQ08xakp0dUtUSXNuQmNGdjZhQTBMZVlCYytHNmxR?=
 =?utf-8?B?UTJ4OHRxK3N5akZDM3ViVmlkcUFBN3dYbTZ2ZGduNGZpNUxSL3RETzl5ekhJ?=
 =?utf-8?B?T05ZWURTQjhXUU1XV2tuOVFURGRsbzk4ODZzYWUzbHUzTEcwVDhRVmJ6ZFVX?=
 =?utf-8?B?TVpZbGRFMWU3eUIrR3I1L3JwbTZESGVVeWVvcG5nWWhvTXRnaWNoRUFHL1o2?=
 =?utf-8?B?dm9xNTZiQ3hBNVJuYlg1TG15cU92U01IVXBXeVpIOWMyRVJkRkRydFFDT3Qz?=
 =?utf-8?B?c0dEWVlFbGtYZ3N0TTZLNzk2bWgvdHRoaCsxV1QrZzdUM0VON1ZvbUVmNERZ?=
 =?utf-8?B?alh2dGQ0T042QlVEMHB5YS9yQnU4azd4MUxML05wSlR0V0hYTXB5Z0Zob25v?=
 =?utf-8?B?ZUNHWWpxaUlOMzBDTk5ZcVdBbXJJbVN3ek1BaWFoa1I4eVBjemVyQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34750cb3-718f-48b4-d65e-08def932750d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:00:24.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6l+F26AavQJPuYlbSnS/54acBtAaMKR/yuSHf0fg1tsz+mi3vQFhK5FZ3cjhRJVcQnuxYqPZXb2X3UDp6Zs8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8092



On 8/13/2026 11:37 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing increment of `nr_loaded` prevents early loop termination.
> - [Low] Multi-line comment formatting violation.
> --
> 
> --- Patch [1]: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel module BTF loading via .kmod_btfs section ---
> commit 3f4fb04bbfb95d7f7ea0012b5651135983af6e62
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> libbpf: support selective kernel module BTF loading via .kmod_btfs section
> 
> This patch adds support for a ".kmod_btfs" ELF section to allow BPF programs
> to specify which kernel modules need BTF loading. It introduces functions to
> collect the module names and filter the BTF loading process to avoid loading
> unneeded modules.
> 
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
> 
> [Severity: Low]
> This isn't a bug, but the BPF subsystem coding style expects multi-line
> comments to have the opening /* on its own line. Should this be reformatted
> to match the preferred kernel style?
> 

Thanks. I'll also fix the comment formatting.

>> + * Usage: define an array in the ".kmod_btfs" ELF section to specify
>> + * which modules need BTF loading:
>> + *
> 
> [ ... ]
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa825..9fe8a653e8b6b 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -5891,6 +5987,10 @@ static int load_module_btfs(struct bpf_object *obj)
>>  			break;
>>  		}
>>  		obj->btf_module_cnt++;
>> +
>> +		if (obj->kmod_btfs &&
>> +		    obj->kmod_btfs->nr_names == obj->kmod_btfs->nr_loaded)
>> +			break;
> 
> [Severity: Medium]
> Is obj->kmod_btfs->nr_loaded missing an increment?
> 
> Looking at the loop in load_module_btfs(), when a module BTF is successfully
> loaded and obj->btf_module_cnt is incremented, obj->kmod_btfs->nr_loaded
> doesn't appear to be updated anywhere.
> 
> Will this prevent the intended optimization of breaking out of the loop early,
> causing it to always scan all remaining kernel BTF IDs unnecessarily?
> 

My bad, this is a simple oversight. I forgot to preserve the
nr_loaded increment when removing KMODS_BTF_* and simplifying the
related logic. I'll fix it and pay closer attention to such changes
next time.

>>  	}
>>  
>>  	if (err) {
> 

