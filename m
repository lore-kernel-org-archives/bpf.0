Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF446405C30
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014769; cv=fail; b=Lhf/Keyd2/TnNcoj/LxgYjYmjQzoLXpkxTJ7yb0Scz8kxv+4AosRxC5Ief1/JIy8GiCryExP0dvQVnoWE3xUaBs3CMo2APj7nXgsdUYT99kOY9dsIsKT4HPIUXoeDPeThvb/3I7jfIG+LGBWHcGiIB+TCrnWoex3gB7IEn/VIkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014769; c=relaxed/simple;
	bh=40pZOdC0MImcEAuWGNb1jATMz+FhUZ/5XVG3wqqAFGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fwOFHGj11ES6cJaVkm+QeFD1p0DQG9J0nq1uGO127SjWLlvRV7qiaL+d6NOLZBwFzl6a4rnrVHpeOZOJHpBHP0oqt47QYQLdUWJmV987qvbg7J50zOBdtyg6I25XCGsQz5t5BSSIuDFYoMEQmff4FHjbaljBPaszImljf/RwzAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XDOqLqaV; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XDOqLqaV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ge6VULKw/iUtInYNkvZInG4QLBNiLdZjwSKYfZVA4Hj15enQaeiJBdRwgPh1AS7WTlAnxxzQKb21faT70196pjfV2s3NAT7ZrdYg+FeKKcWl+m2coE6rNubBqM69ao1g3M2XFnQOrASM2oTF698WoeIg27UzG/CZbOI6dZ4NPxGg4Um9r/78IQ6BPe9OeiIZozNe5LptFstwTjnKIm5FZQ+ikt2H3eoV2GphaPo1JZqyjSG9sYvDFk0XxxRz5Y/oW7SxMQDxjDNOcwk5IH40rlxRnaakp3iTA4l2mCTSGu9w11RP3z6Yoa2sGDtpg32lDEA0cHd7FLZ9MaOyZEOIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/WyEdJWPFUM4jhlmXm7mAYAz2jA+QuX96bB1Vu5GSc=;
 b=m9Kx3zQywHIT/I4vqgCndqBVN+KHwcmYcj/D2kEwKjRCY8eK4eop0rTpp8PhRGjUe6mPn/ChJ2Ci0QF6uPhtKQIv1DkoloABMKFiM+U2ZTP+uhRCJGPyNXpcc2y4UTD3+zKJsrgsLHe1EiAqvEVJk3DzriQMilPxLWfsTY7G8i9k3WtHSZTw7EeWrd4UNWd6LqwUvKi1C5V0LmSIAIFYSk975ZKVgszjZkIqAQiYxUQ9JPBRPQ8a1oyb8nFzmVMc54XdoZ1oWJUFrfJxwJyJFfcfQ1MbQiOeNvkYf5CsV5gBl5IEXox6GUtK5BVPrqLeXBCtG+8059Hb4jlGEhNFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/WyEdJWPFUM4jhlmXm7mAYAz2jA+QuX96bB1Vu5GSc=;
 b=XDOqLqaVFJZhxzTxsRGYzQcUbpc16ItJRct9c/Tjt+OCSy12RogFCbDVFQST9ZT6rTWsPzJETINS1nIbAFdqTDdZ1+SHDNeC6N4FxyhI6fzrVFHAToth3IifPd5j83+SknDCA+Q+QC8NCkZjBNM8YNEdg7CoxOm3vd53eyNnP6RYXCTo45Z3tUfcsR5EHPBxYohOe27BmuoNxYzloTEHpDSl8pi57BipTttEwaJH5Zkn2AJo07vtnHEOCeRzFCrsQCu4pBxzWXyhjlD1XFNsP4+9YrvI+VNEcDcOZOzxH/CDGzMx8/aOvJe1sp1FT5+Fc2Zfx9L04uVkQ8O7U4N7Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 10:46:02 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%5]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 10:46:02 +0000
Message-ID: <cfe55dae-df61-42ea-87b8-5fb2ea0d480b@nvidia.com>
Date: Sun, 17 May 2026 13:45:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: Fix checksums in xdp_native
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20260513072355.1083381-1-noren@nvidia.com>
 <20260514074959.C0A5FC2BCB7@smtp.kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260514074959.C0A5FC2BCB7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 79010453-2061-4181-d9a1-08deb4017d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	sL/sQd7V8832nkn2gJkkttGF49a0YXyimNoSvj+hP2plh5ZQ/XrnLIJgDA+70A324WQeuvywc5DjpQIB+7Y5plKGapS9dPxfFv0UmCoeHCumMAh8P7pkTLmzsC0h+7hd4NJbuaVdhjvhWeLSwql1k5Z/ZtLMIrx0fY9b9Dqqk2z0Bn1Xxm6RgyQExHC7TtBjtu9OisulZbYBfXVvOZNwgbWUSXzv/gR2z7VzJHUei9QWjTWaQIanN3BXPxNOk5AgX3lDg/5bVAzwZx4QUdTphjvEpxF99gSkWE+n3fBEGx/3c3LcEeTGSBZwsnknVVzcOZsOHYBG/aNiNL6OTy/6+daPNTv29dz75qg8Idk9PpbGlAA5uTop5wjsKmj4rvz95iNFsXzeITWNDwtHrjMM3fnFgg/JIjWGMVAvt7LAbV6jyki3vVZbY56AVD7ESDCloFouGh/KiyPnmgrRtqaocFqBbZRZ4L1tc10nbv4IpkS4wcCpXyGV+N2QlXX7P0xpQJHek8KvdcHQU2kdblr1KhxUGUFX2Iy29uvoeIDLmbe58Ma4oNnQSvqOUPPxFYJANT9awVpUQQf56vxz98a4Uvn+nmXkIBJMr/wf2umwlcamM+6sbwiqpAalALVAYT/P5kUkiR7kRunmGTCzrmQh93d7QJPDzOGJLtX0fdAbrExrBfE1AAp0Fnk1kgv44Cdy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UitQOGR4TExONG1tc2g0ZzJoQWl3cm1iUzY1dzZpZUliWjlITEtHY2NsemRQ?=
 =?utf-8?B?c1lZYUFzTmZheFhBbkoxN2RQQkhITTZtMGcvWkdOY3VKaTVLN2poNnAxYzFz?=
 =?utf-8?B?ZXVGZm9HU2RQczZSVzZSZE91TUVERGdCOVNoeEYvZ2FzUG45VXVKUWlKbkpa?=
 =?utf-8?B?UGhFdXQ3VzRxMld4Qkc3V09JQS8wU1JEY3NtVWcxUXA5WitwVlcranFMREQ0?=
 =?utf-8?B?cHp6b2VzWlptbXJ5andRR3N6eVJsbXBMOG1WOE5nZEdkZTZSa25uYjIrbitW?=
 =?utf-8?B?TUtDeWhlZ2UzK2FGMzRpQ2JSc1A2QVR4UzUwbnl1WWNLRkNTQmY0aE9qMjRk?=
 =?utf-8?B?am9wUTEwU1ZnbGtXb0hNajdNMDNhd1g0c29ud0N1NTZGaFJGVmdYWi90bTlW?=
 =?utf-8?B?aDNwWUNBaTZCQVJqRVgzcFhKMVk4NUxxaGUxWDRoQ3NFYjNEVC9DeEtnKzZR?=
 =?utf-8?B?dUZHL1R5UFBuMkVmeWRpNVZuQjN3cHJXcEdGK1A4cnd4UGMxWEpTV1cyWUNJ?=
 =?utf-8?B?MUdQSnpoZjRKQ2FnbW9icVcraTRQQjc1d0cxUmVQbTlrRVNGbkl0MWFJRlpW?=
 =?utf-8?B?WVJLaWhGSWM0VDlVTm95S0E5NWJiNWkwa0RCRUpWL2R5eDdmcU9KMVUzVDM0?=
 =?utf-8?B?bjJCbk1YeEU4S2VscUxOcFlkclpzdHk4L3JkNmFnYXFqc1FpZVNOQTRTUXIy?=
 =?utf-8?B?SlZGNFVxVnhBTS90YXF4WlJFc3pVU3gyOG4rMU40RFpqTEVqMjJvUlZYR3h5?=
 =?utf-8?B?NGUvaDNjU1VVRW1VRDNyYldoS3Zra2tEQm1Zb1JFRGUzLzF4M2JvOERFVGw0?=
 =?utf-8?B?NnlPQ3B5bWdWV1pGdzlKY2xrNUdCUDVRNlFtUVY0bi9CM1IybDZ2YVZCWVE5?=
 =?utf-8?B?cWpvbHNyZGw3L2htL1hCYXBkY2Z1YUtmMm5SOE9yVDNGS3dCR1dzeVhURzBQ?=
 =?utf-8?B?MjVSTzdqS3h5bk9kR1g0S1djSXRDM0JiQUlVQnV4VGFyTC9QNzluN1lOTkVw?=
 =?utf-8?B?YlgrK3IyOUdnWmJJenRBb2dadHNlM1lpWDdKaHA2QytHTmJuSHg0NmNYUFVw?=
 =?utf-8?B?U0xodTRpVlRxSmNqWElmSkFDbFEwUkxHWm1uYzN4RjdkcmNHRnNDeHgwMUYy?=
 =?utf-8?B?UjA2OWNrNnI0UlAwRG1qNlNBdm9Ea1BwMEtGTkRYWVR0ZVphZnV6UE1ZRzho?=
 =?utf-8?B?ZDhtRXRHMWFsdjcrYzBIbjRGbXorcHg5L1IzYUEyVSsyYnRtV2NiSnpQOFBV?=
 =?utf-8?B?bnNDZmhVVElTSHcydUpmN1JvbDFXK2h4VDhnT2tpOHpVMGQ3b25VaFpZVld4?=
 =?utf-8?B?WTlUSVZSYmNCeFlRVVlYN3pFdUZJZXdvR2Z6YUFTcEllM3c4TVBkendVME9M?=
 =?utf-8?B?WEl1cXRZQlNGSWhldmJMT05PUDdKbllscjN6TTg1V21tcVJxcVBJdDJXRWFB?=
 =?utf-8?B?RTFNVUwrazRWQWRqMXp4bkVJd3hESHk0OGFNRDBJblBpMHFLWGxMRnNRcFlv?=
 =?utf-8?B?ZUJ2UWtJRVl5MEpIaFBQNlFrUVVWeG04MVVvVUk1VTUyTlpXSjIzRzB3WHgx?=
 =?utf-8?B?MnJEMXdVb2h2c05NVjNFU2J4U3FWVCtGZ243bGRlUUpDbTFaVDZEa2ZpTjNN?=
 =?utf-8?B?cElMa2l2YmNtRUl6RStWK3I0RUQ0ZGprMkpHR2dueUFLUm4yS3FmNEhxbGdB?=
 =?utf-8?B?SlVoK3o1MDVVWFVjRDYvZ3NLY3FxcnlldU8vcnZWcTlWdlkxQlQwcDF0OHFF?=
 =?utf-8?B?NG1Tb1BHRU5Xam45RDg4SkI0cFZUM2RCZnlNYUgwSGtSV1UxcW9PaUZDMnVP?=
 =?utf-8?B?YVNoS1cwanlmdkg1czVsak9Ja3NaRVhxVFc1czFFb2hiaGl2VVZDclNJaThy?=
 =?utf-8?B?UTdMbGZkcHNzYTRBbThVLzFPcWYwMUFuQTdlRzZaaFRxS2NxYnFGTFNtbTQ4?=
 =?utf-8?B?TnpDVkZzQm83V2ZDV0thaUhua1FnNGhwZkFOVUNaRmE3b2lMamYzUXJiQ2sx?=
 =?utf-8?B?M0J6UHFybE1MNFMwLzhxdnU4elJrc21wNlJmYnFWVXhWemxsT1hWaitMR24x?=
 =?utf-8?B?QVFJRG5Zckw0NjdMbENkNk5FQ1oxT1RjN1Y4eGZNcjR1K3BBM2ZrZzJzME1q?=
 =?utf-8?B?dU90Z0hYUnRHbnltME0vaklXcGlzU3Jod3doKzBPWTZIYUhBaVJad3VaaGFF?=
 =?utf-8?B?bkFkcDQ3SnZCc3owMDNPV2lqUFh4OS9TT1JJUHJzNG5PY1ZwMEY5N2I4Q2No?=
 =?utf-8?B?UjBodHNXV0tRZ1ZKWmhYU3cydStHL3FBUzV5U3Bvb28zVFhMc0RaKzM2VTda?=
 =?utf-8?Q?UIdlfjyBSgCXUgpCww?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79010453-2061-4181-d9a1-08deb4017d39
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 10:46:02.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lm6SKpb+iTvsiEOiNhTsOv9BNXQwjB+4hSu4dMj41DM6zqtGQRt09+HZafvx5f9NiUqbYSpWzNgKcUTehycY9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324



On 14/05/2026 10:49, sashiko-bot@kernel.org wrote:
>> +static __always_inline __u16 csum_fold_helper(__u32 csum)
>> +{
>> +	return ~((csum & 0xffff) + (csum >> 16));
>> +}
> 
> Does this folding function handle the carry bit completely? Standard 1's
> complement checksum folding usually requires a second addition to handle
> the carry from the first addition.
> 
> Since the 32-bit seed passed to bpf_csum_diff for iph->check is constructed
> via ~((__u32)iph->check), the upper 16 bits are 0xFFFF. This guarantees the
> intermediate 32-bit sum will exceed 0xFFFF, producing a carry that might
> be discarded here, resulting in an off-by-one checksum.

The single-fold form is pre-existing; this patch only renames the
helper. It is safe since all callers feed it the return value of
bpf_csum_diff(), which already folds to 16 bits.

>> @@ -281,21 +291,22 @@ static void *update_pkt(struct xdp_md *ctx, __s16 offset, __u32 *udp_csum)
>>  
>>  	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
>>  		struct iphdr *iph = data + sizeof(*eth);
> [ ... ]
>> +		len = iph->tot_len;
>> +		len_new = bpf_htons(bpf_ntohs(len) + offset);
>> +		iph->tot_len = len_new;
>> +		iph->check = csum_fold_helper(
>> +			bpf_csum_diff(&len, sizeof(len), &len_new,
>> +				      sizeof(len_new), ~((__u32)iph->check)));
>>  	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
> [ ... ]
>> +	len = udph->len;
>> +	len_new = bpf_htons(bpf_ntohs(len) + offset);
>> +
>> +	*udp_csum = ~((__u32)udph->check);
>> +	*udp_csum = bpf_csum_diff(&len, sizeof(len), &len_new,
>> +				  sizeof(len_new), *udp_csum);
>> +	*udp_csum = bpf_csum_diff(&len, sizeof(len), &len_new,
>> +				  sizeof(len_new), *udp_csum);
>> +
>>  	udph->len = len_new;
> 
> If this is an IPv4 packet and the original UDP checksum is 0 (meaning no
> checksum was generated by the transmitter), will this differential update
> produce a non-zero, invalid checksum?
> 
> The receiver might then attempt to validate this new checksum against the
> unchecksummed payload, causing the packet to be dropped. Should we skip the
> UDP checksum update entirely for IPv4 when udph->check == 0?

This mirrors the pre-existing IPv6 branch, which also updates the UDP
checksum unconditionally. It is safe since the test doesn't generate
packets with udph->check == 0.

>> @@ -359,7 +364,7 @@ static int xdp_adjst_tail_shrnk_data(struct xdp_md *ctx, __u16 offset,
>>  		return -1;
>>  
>>  	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
>> -	udph->check = (__u16)csum_fold_helper(udp_csum);
>> +	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
> 
> Is it safe that the raw offset parameter is directly passed to update_pkt
> (which modifies iph->tot_len and udph->len) before the offset is clamped
> to MAX_ADJST_OFFSET (256) in this caller and others?
> 
> If the raw offset is larger than 256, the packet headers will be reduced by
> the full offset amount, but the actual packet length adjustment via
> bpf_xdp_adjust_tail will only use the clamped amount.
> 
> Could this result in packets with mismatched logical header lengths and
> physical payload sizes?

Also pre-existing. update_pkt() was already invoked with the raw offset
prior to clamping, and this patch does not change that flow. It is safe
since xdp.py caps offsets at MAX_ADJST_OFFSET (256).

