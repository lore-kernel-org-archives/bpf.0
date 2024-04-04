Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A71E86F
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221873; cv=fail; b=T+opMWAiYf3RIYtGBjUQTWl85I+wz/M9AMBC1yUCoNQ166JjxDOkYIeWcYiU4RI7QA3tD9gUhsTQlXJBMq5qDkBcrMxdyBZm12x8+Lx7+NrmWZw7o9pJDUIJelbpSbfGeFlZO1XpjTMZlOR/q65uR7+49VFSdmbJHO1dPOZGanw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221873; c=relaxed/simple;
	bh=Yi6U2cigSyV0WwVT70b9EdeZXgwo6L5/Sdk1Fqa+16o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvP8NqO3FF7Pl149j4o4Zva5otkGkxCDaPcZVTqpYM2JYRW46G3V16I8eNLyu7zDAj1vRA5oQRVueAO2tLrUMNv9rmeXkVfQ5ZiQlgGAyGlqO7pJLsZQZy4dArLBRW1t1Re3kCnDnAwkO3zWqDghkHv0U0u+IQwgtUKSx+eGJSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqfac26u; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqfac26u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712221870; x=1743757870;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yi6U2cigSyV0WwVT70b9EdeZXgwo6L5/Sdk1Fqa+16o=;
  b=lqfac26ueedOm9YF+NpSNs4lFlKE8D+qxviSWmXhevOGDmCK4ZbqTBkQ
   /JiF4cL2QgyLBiyuXXNEVb/1SXY1fIT0OaEJMS8P53QQoZc8D8Jua7+KW
   ZfLYfXaJzfptxPGkhAKCMMH7Nv0CLJRmwBQ+U8SSjSBltu2VJJNCK9Wh5
   r6Euj4BuWccAIS4BzxsTcTNmyQPGmDx3rP99vO1CN2CPWoXG8FtdqOOLM
   udlNMoC618KlCWEPD19uYEO6+h92WgcmREDzlyzCcbItj1xjfcDNdxF/p
   NYeFM7vH4VWLV9/+i0LJDirURrAW/0jdRd/YfKdgBZhXjO8iArFHk1UR6
   Q==;
X-CSE-ConnectionGUID: 7P7cJfOgS1i7vuAhKuT5RA==
X-CSE-MsgGUID: ShEtFOxvRuyDnAVeeT2Pkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7622753"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7622753"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:05:35 -0700
X-CSE-ConnectionGUID: ibrQQgAaSFK56cJQag3Org==
X-CSE-MsgGUID: O7X5EDhHROmhH7lj2u3/OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="19150909"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 02:05:36 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 02:05:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 02:05:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 02:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+3v38ly1HuplTfAMynZ0TvecXoCuAUclt3ySWjYFc371QGG7ykXDiaWk6pqHe2bbjkyRE+la5vco+HeWLr5tT9Cw3ZeHtHfF/X4H8leBsf/SffgwrTHX25gA5AH7aD3E9y54ArHoroOXPKRWYiwZAF+bEhVeFvFqMr844XmLIvQg45M37QH8CJxUvlhxBRNlOZDlxqUMH+GzDUfcIrUDrseaMu86MN6tMO1t8NZXGcv9t/UI/MwwyllSY/DLZ3b77df1+DdYOmb6ammJvO9q8OW4KTSE2maKOntfiCy5219yiJQ4/2rer9pMto4TyiAiuuEdtlJcNKjiYbLIWnJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9YktEhC+oxomEp3j/0skjdvNTz7N0UiE+doHCZX8HM=;
 b=fJERtT+IkJNRMCB0gBhRgSbiXyCNcLVaYF55iucgw+6M0IQ20uKpJ8KY8HSHwPpSw/ijhKXGhdvV6EaSELmS2nbsYLb9JUujGqnh00jBZYHvTIlFFVjLm87XmqX97txkYX18mvAv259seeQQXpODMS0IOY4x/tvXzyHW7O8taoM6rrPChxVMg30VoyLg3O5Wu/BHsRNLhlz6o9S+MLmaGpgPpPv70yVfqcEXw5Sts6HHxG1LuzKtfq7UGiybRTtc7rUIt/OBDaNYA5DP5DTGhvILeQWiz37ixDb0W5AXWXp9mur6hrAUbWaOOHCuWvakHWEvKU3MJjQbJLOwItBilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6453.namprd11.prod.outlook.com (2603:10b6:8:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 09:05:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 09:05:33 +0000
Message-ID: <ada87880-4bf4-4528-98ab-d09d39c515c3@intel.com>
Date: Thu, 4 Apr 2024 11:04:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
To: Anton Protopopov <aspsk@isovalent.com>, Arnd Bergmann <arnd@arndb.de>
CC: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa
	<jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Stanislav
 Fomichev" <sdf@google.com>, <bpf@vger.kernel.org>, Naresh Kamboju
	<naresh.kamboju@linaro.org>
References: <20240403123303.1452184-1-aspsk@isovalent.com>
 <18d8417d-835c-4279-9f84-abdc56fa19fb@app.fastmail.com>
 <728951fe-ccd5-49d2-1584-fc97e2c2266e@iogearbox.net>
 <1c3d3079-e1f7-4420-b542-c3c451038963@app.fastmail.com>
 <Zg5dQ6KYqVWA2Iia@lavr>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Zg5dQ6KYqVWA2Iia@lavr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0025.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6453:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxPsdTeM/OI3SSXmshXgBEhtY+o7sHT7W3nfmDgs5xGLla16MJzIlZEEUAYafWo4M8qMcKsgDZ9GR6+zHdQrz+B94IDpyAinPxk6f0tQdIGdtNVzGU5LV3vfmdX4osTDHCctZkg+d/huwEHGo9QoLfnaOm4vYT9MFF4iT51MkhyeZRVuA+nBPqmkdLb97XdtcjD363ARHAMsV6zwrbVrmgFMZMXbt/ORanFIUOk1SrHsZix/JfcX0uoNF0868cOpB2ojGCkor3rfuIHUXafEKmD2pTeuhKrlwm0/LuXiEQzXYOcJ5mHfKFTNIlYnsXbqrlyYO2eS3ndbA3I3A8vmaQtk40PAenPmor3U2tq8ifscNbXN14mfV7/Ae2Bd9TTEQFrxl+PdrwY0/+qiSNrbAp/5GtZxUTDCi+Gc7FwCY3IYt4qMQtyu9DBZ8bMl/BaXPVWzuvN8nsvNLX4OvaHmcMWcucF/RxvHBHRCmH5O0nBkKEk4eWFBDEKlQ55kVuYORonjQtuuhXLvz2Frw1uTxlPPnWhmwF7L3t6MrEwx2cF/4D3gPZ2mVyeNqnn7/WWEhkeUEt2NSdRRPxQ4Zs0liBXcJV9xdRJf7wo3pBB4eY0smbUSqJczGkq8hqmXeKblK5az2jM9BFD91JFVJHEqTeoI3lOpcTNsa7rnfDsO+OM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFxbXcvci9XdFBvWWVZaU9Yc0xJK2Y3b3JUNDZaaW0zMFZBdmdIU1pRWmxm?=
 =?utf-8?B?S0wzV3ZuS1didVVjeVhlZG1xbEYyUEQ4Vk55NkZmdlpaUExoK2oxQXl1MFN3?=
 =?utf-8?B?T3lEaFFOQ0kyay9FU3BpNTRDaWNOOUZuSDVLYzJYMERtaHRaY0V6Q09tMWZ2?=
 =?utf-8?B?djIyK2JJRG4ydVYvanU3cVBMdUthTE9iWVN3T3pBa0luV3RHV3ZuZDRoY2lz?=
 =?utf-8?B?c0JmMDdObzhUeEttU0FWTk5KdkY4cHFPMERQZDRnQ3ZjSHppOU9HVWZzZGhw?=
 =?utf-8?B?TWpPZDl2bTNsb0VZb3hvQ01NaTg4UlJJc2lWSzlNaUdQTzIrNFcrOCsza0p6?=
 =?utf-8?B?L3hNejlReHdjNGZKcDZMQjc4RFdDd0g2MlZvdTdzOWtLcUV1V3BsTUFZVHRI?=
 =?utf-8?B?NW1LRHFxRm9BTlo2QXV3S1hRU3Fta0VSUmJKa2VjZEZOL2FWcnlaTzRnY2cr?=
 =?utf-8?B?Nmhhb09BQnZOUTd3cnNQL3llcFFSTXJJRjh3RWkrVjlyWnN3WE9SODNmYTF5?=
 =?utf-8?B?S0tKWC9JVzV0Q2Z4YVpFNDJLK0loM0JmYlZwOU1UQ052U2NUVTBTTVNKM2x1?=
 =?utf-8?B?bHdCVFJKMDRpczhyald6NzNST2pHZ3hzNmVDOEhhc3RYM0RDOThtQXhvbDJt?=
 =?utf-8?B?MTFEMUdCSDRUbUVsV05DWHllMU5PVThLOHBuRE9aM1pNeU1DVllxYXR0Njd6?=
 =?utf-8?B?dVI1cWltL05pck9SclB3UnFRMXk1Tm5kWHZscGpCUnU3REFGK2FHZWY5UytL?=
 =?utf-8?B?MWlMRzFCOU02WFBUd01TS3dLVkJYS0tQMFo3SjJhQ3FqMWxBaUFFSW5PcWdV?=
 =?utf-8?B?SUJ3cThsZUZBQk0rNVViMXNMODNGZzYxS2FHNVdmQTF5M0UrKytTZkhJNW9r?=
 =?utf-8?B?aUcxRDUxb2hrS3ZiVS9hUFVzMTB4R1NXQ1NDZnQzK0F3S2pHN3lsMGFvQXhX?=
 =?utf-8?B?bllRVEpGeTJIRDhsYVp5bFpINUdCQ2VvZEdqZ0ZoUUxPWTJhZlMvZ1dTTlZk?=
 =?utf-8?B?WmNCS1ByQzZ5bnlVeVNpNURHSFZ5US9nYy9iVThDNG9TT0lKVis0Zks4RjN3?=
 =?utf-8?B?VURBYm1DR25jRFdLU1hSNTJCanVvT29xME9QNnpTTXFvS3c2S3A0Q05idUhp?=
 =?utf-8?B?bk1WSFhCNVpMbDBORzQ0VmoxVHZpemMvUGp5MlNadWg2ZjJDN2NDTUJsQUl2?=
 =?utf-8?B?MmY2bTZnSnJNZWQ2cmRHc1Z3YmY3ekZvd0hHMWUzQlZHMWQvVDZ6UDg0cjlM?=
 =?utf-8?B?RXFKamlFMTRrSEdFMTNnZHI4ZFN6MTZtM3JDNlczZU83VmJZWmMxZUxHTEoz?=
 =?utf-8?B?RHJHSk5HeGxmZmFMS3lGcGF4SGVWQWlkUnZrbUlWQ01ZZTNsUnZIN3hZL1hH?=
 =?utf-8?B?RW1LS2VHczZlS25YbnhXWHUyTEhCc1BnVDFaWXk2Z2MzNHNsMHlLQ28vOG5l?=
 =?utf-8?B?alE0ckVjUTNJZFRURm9VSGRBSHJ2aVMwU0V5TzMxUjg3SDNHTURUVjc2MGtL?=
 =?utf-8?B?MlBTR0w1b0tzcWcwdFR0YmpBc0hVOEVpVE5BbVo5Q3V6c0NiZjh6bThVbjh0?=
 =?utf-8?B?MjRhRnBZRzNsOThXaHBJM0ltM05CbW90aVAvM2diRmhPUDNLTDdTWXU5TUl0?=
 =?utf-8?B?cVdyWG1GZ3BkVGFLTytlS1VxeXJYSHFMRjRmNnR0MEI4NE9FRDE2QVR4dmhY?=
 =?utf-8?B?NlF6R0FGMHBjcHhEQlZ3K2M0am16R3JwZkQ1d3FUczlyckVid3AyWDJOK09N?=
 =?utf-8?B?TzhkbGtjTS9wNForYmZ4eHpyMGlIQWhUcHRGUkpTeGJzcEhxVm5kN1dJdlpU?=
 =?utf-8?B?ekUwQVJEUUJvRDJmMmxTaE1XbDZ0LzBJdDNuN2wwRTFQUEF5RUFvd3UrM1Jq?=
 =?utf-8?B?K3QvcUhkblBXWjZVL1cvWkg5NUt4cmI2dGE0UElSRjUzRW83SG51MzNoNGsz?=
 =?utf-8?B?am91eFFTTjRKSElpWm5nSHRoVTBLcWhTUlBBaWNScS9PVlc5TU5ZclR6SHM1?=
 =?utf-8?B?SU1nMVp5R0ErOSswUWROa2twMUUvL3ZleWkrcHdDNVNlUnMxQnZJNmZNZ2ZZ?=
 =?utf-8?B?dHU4YWhaOUhGazJNa0MrUHhua0xaNkR4S3d3dmRTa0dlN0lVUFBGMWNmNFp5?=
 =?utf-8?B?aGpxbWI0RXJaZjdpOUNCTmtmU3JteUFKenpxNW12dC96ajBLK0dvSG1VZVJG?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a826757-8dd1-4896-6891-08dc5486623a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 09:05:33.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWVHLJENGj+lbieA+7wOgRMS24VunWNW6NrnCRAHGttDnMTg4omgu+JokqPto8m5/99VFwP+OzP1ZVGPKTKL2fy8eqBfnTmxyZuGAQcQKXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6453
X-OriginatorOrg: intel.com

From: Anton Protopopov <aspsk@isovalent.com>
Date: Thu, 4 Apr 2024 09:56:51 +0200

> On 24/04/04 12:31, Arnd Bergmann wrote:
>> On Wed, Apr 3, 2024, at 23:00, Daniel Borkmann wrote:
>>> On 4/3/24 10:09 PM, Arnd Bergmann wrote:
>>>> On Wed, Apr 3, 2024, at 14:33, Anton Protopopov wrote:
>>>>>
>>>>> Declare this inner union as __attribute__((packed, aligned(2))) such
>>>>> that it always is of size 2 and is aligned to 16 bits.
>>>>
>>>> I think you probably want 32-bit alignment for the structure,
>>>> to keep the ABI unchanged on all other architectures.
>>>
>>> Fwiw, on x86 nothing should change on this regard, see below pahole dump
>>> before/after. I think similar might be true for other archs as otherwise
>>> we should have seen a kbuild bot complaint on hitting the size assert.
>>
>> It's not the structure layout that changes, just its alignment.
>> Of course this is unlikely to cause actual bugs, but if there there
>> is no real need to change it, I would leave the alignment the same
>> as before.
> 
> I think the struct will now be automatically 4-byte aligned, as it
> has the following layout:
> 
>     struct {
>             u8 a;
>             u8 b;
>             u16 c;
>             u16 d;
>             union { u16 e; u16 f; } __aligned__(2);
>             ...
>     };
> 
> So if the union is 2-byte aligned, then the struct is automatically
> 4-byte aligned, because its address is 6 bytes less than the address
> of the union. In fact, as Daniel posted above, pahole shows that the
> struct actually has __aligned__(4) attribute in the patched version.
> I can add explicit __aligned__(4) to make this clear.

I think it would be fine to not introduce an explicit attribute as long
as pahole shows the structure is already 4-byte aligned.

Regarding aligning it to 32 or 64 bytes -- the actual benefit can be
checked via scripts/bloat-o-meter. Usually alignment bigger than 8 bytes
don't change anything in the object code, at least on x86_64.

> 
>>         Arnd

Thanks,
Olek
