Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013063.outbound.protection.outlook.com [40.107.44.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A156B87D
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962928; cv=fail; b=EVzYzx8gBISpcIODkYyNBrWvNL93iInrieMGSTNUhHY9kt9grUN1z5eQ16YxYFXh3JfTE+SMw2tbArnFANek+miGVXd6whNxrHWq065hdpdf1QqGza0YEg57hheY9UtlK/eQPwh5epgYbQCJR/LBWz3rwEbyzMtuan+JbS4OpzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962928; c=relaxed/simple;
	bh=SBQKWAVFq72Clyp5QNLTNInzPn23DrqI0L4t0at4EVg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKhs/nPkQi7ueB6EK//JTchHTadvALYWANktiq+5vz86Ph9gbrqH2oJ4Gw9aeBVL2JyAI1k99dcZyYBOsOqir/i1Xv650/wq9/AqYPXyRdDZAZQ+PxAeXg6V+6tnKxYs44zT80DlVyYl+TB3jzmQ8qtJ2rsqb5BBcvhaoZ3r2vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eUJPSk3n; arc=fail smtp.client-ip=40.107.44.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eUJPSk3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/nbdjT5O0w8bRkIEG/z2P2Jm3wZZ5JndKKz2+/xIKkYaD47+dUC4q8FimbzcWDOQrG0lanX7q8OnsxsdoiprfSanFNCaEzVueyzOg4bZArZwubO7fTG/tMb120exIeLrBlAi6U5yDxe/ik+3ovNOXmDkPl6R1VJ3aYaaCJKYk9mZsNMrfQcTP5UAEgVqf3vvKDDLmK6uXQGsIlS74vcCjlNQoSnCeZhbVh2B6PaySAcWgjAWJc798E8B7TDxYhsZ6N5msKXuebXzP/8zEtwKjf/Orad5ZvdhgdjvaBoEHG7wnH2WF6IUTMEAUToum8RAC8u7PvPehONgAsm1JSyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q4yQw4lr3nwo2D9WH4uwEhglBmvXDxC2DZv+2zVzCU=;
 b=fYv3prfIzWA1dXHjaD4+VhlzbGlUGEXXOsb/24kXzDliWHreuFkbesdnu7MS7yCqK/VjaeMhTl3bACW30zV+l4ltPdt37Gjf6/Cy++GoZU4+4oN9xlVpaQ3zu/OaeUWDAe4F4XpwN6+o1GwsVJoIVanX8vX/LSHwMJf5gW4DtjUmBPRERsk+aZb5kZr3E2pBNQtZmCGWLlMqPC8F/oUN21696ybs/+PLoCwaS+s4yOUL+ebZM+DXqpEaLR8nk+JHbZVENh7ElKQaN1FSdREBfG+2Lq3JdY8MqP6okahhz81C+M+0GEmHbNbB7a7nMRPUHR1N2gUaYUNzKEsTvrn0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q4yQw4lr3nwo2D9WH4uwEhglBmvXDxC2DZv+2zVzCU=;
 b=eUJPSk3nHz18pdMcmDM2pTAMItW61GrcwJ1oaKk5WrhJ5YbWJp/BpFhfT8+bB+BLG1+aeBeM7USEXrUHH73O8WtljXcewN19jL3goz+P56pmxPrJ/w2lhD0QUe1Ps6Sn/InGzaGS0qgXyglzJGxBwbR1I96QaeZZ+4VyMsKCjPSJCYfnlPxczGJkVeCjUpwSfyT1XTeAmsxiw4SkPvyuZT9beCzqMQ6W27sfw0kHxAqBV7elFYCn8lB2t3yqD9ae0CywKu746MM+V44c5T3IBEeGDlw4jOGxAAEumigOR6biO41aZBz7p6jl4b2hYOHr/1LBqmmvD7BTzxUkqAO82g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB7312.apcprd06.prod.outlook.com (2603:1096:101:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 9 Sep 2026
 14:08:37 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 14:08:37 +0000
Message-ID: <c1cb32c2-47ee-44d9-8d95-0d7aa074139f@vivo.com>
Date: Wed, 9 Sep 2026 22:08:34 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v7 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
 <20260907053847.1115-2-zhaofuyu@vivo.com>
 <20260907054907.7DEB51F00A3A@smtp.kernel.org>
In-Reply-To: <20260907054907.7DEB51F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: b3aa5613-7bc4-4afa-8363-08df0e7bd764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	11WoXU22jiPawxltreHBBz+wFj9ImI7hL7WkbgWMmxxC085HtI0gYJ8lwGHdm9WaEOnuqfokmSePAVOWWSU3yDd0BIte89VtC7GZmlhWw7yuqCx2mqdAQuO3CF/oDNGtLK77MsY8RfQiaolBUTLruMiddjq7rKMF6DhMcIFuPdIQr2SCmWK3vEHC7FlHY7k0ycstT0FDrXyZnJCtN9Sw2Hd0kleG+XZv+2mMWDCJft/xrDCLaJk7Vu7NwPhpaGTrBvAu24u2IAyZczQ0PbyYjoxeUistXqboZNrN5YAzC7kn4pQR8f5nUpNtUFnoPLKn2JlNyMWahYohFUk+e5nH36+MaYKrvWyayXUI35YHfuefhqqRUyMLj6xi85chqIJ8Lg687T5khCEQzQ1eqrrAyIha2q6w/sdj2Pmujup3Zb1T4PM4ox0zcdctVs+dPbpU5XHjK//l+elLkDe4WI4MIYV6E+IAqD1Z8onNO3Ad4tSe7p4P21NoVK1dC2ChmZO6GJ+20j3aUke7afUg6JproIw3AJ3mt1AQ8KK9ac87WUrWnYuyRJSEHD6oYzwQ8wS9TrbulEjxz35exj0D+idMN0hz10jG8bHtzUk5lv8FxWuEpZoV05CZX2xhUA7m4lAh9tsHw9kSI+7ureMfxItsqwQ+PJYnbEzIpn5djA+PnIw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L21lMVdnZzU5UVRGMXpFWGZmQXhYcCtQT01ROEhVZzNpbWdMQkY2bjFabGtX?=
 =?utf-8?B?M1IxRnFCaTNEWGFKNjlaTFVaM204U3pWOGhrbVViQkFyek9BemJqMTI0azRL?=
 =?utf-8?B?SldFbk9NZ0FwMGQyKzNmSFhZNzFlMVg1ZEhQSFIyRkFJYXlkSVFiL1RKNm9i?=
 =?utf-8?B?N1NmVmRnc2YwNU9mNE9ZeXBRVkhFREw4dGs3WFlzR0ZFL1JEUXRoYmgxQW9u?=
 =?utf-8?B?Rnp5RGxnZDREQWpEbUFCcW5zNTJtSHFHWjk4MlRNeFZZV2NmVStCZWpRNnFl?=
 =?utf-8?B?VDBpT21Vc0ZLTHgwSVZHdkIrZVpFZkZUSzZtZW9zQlZrK2xFeSszYllKcUNz?=
 =?utf-8?B?V2JCWnN0cGNhMWN4ZG9qdzZNQVZvcGhkM0RwTXJGOTJsS3RidVVueFczZUlP?=
 =?utf-8?B?a3hneDUyMEZlTjFrUG9QUUxpK0NTQ1ZxZmVlRG9JNk14b2xPMGlqeXdTR1BK?=
 =?utf-8?B?c0R3WkZRK2hIUWVKSUJ6SWxSVGd5RzdKWkZCNEp2VmxtN0pEQ2d5UVJvMzJr?=
 =?utf-8?B?aFZRVERiUi9iUUtNYlE2VE1oVFhpZWFkcXAyU21wbzlBWnR2S2ZZMk5mQ01S?=
 =?utf-8?B?bXBTWmhzajVUaE1qaytRaGs2dXEwOFVRQWs1UUZ0L2Zxazc3aGY0Q2wySGRr?=
 =?utf-8?B?WmJGdFpLQ0lPVW9saDZtR0pGcnRGVjFxd0RMcG5mWGRZdXdlLy9IaGtRM29P?=
 =?utf-8?B?d3BjWUY2TkRTcEpyVC9KVEp3dmpseWZFM2Mvc2NqZEQ3VUhBcjVUUFgyL0Q3?=
 =?utf-8?B?akxPR21IVklxdHN6ZHhhYmFZOHJQeVcxWHVvRVhnTHV4clQ3ZWtIVmtKcHRQ?=
 =?utf-8?B?Ymk0OE5sWDRieW9TK3NhSThmMmFRS1EzVHZKYUtLR3ozRGFmbU1DN3g1Ni9P?=
 =?utf-8?B?d3F6eFMxNDV6K2NqN3diblkxQjZKc0owZUpPVVhtbmdpVVpPRGpyVnM3cC96?=
 =?utf-8?B?cHpUR2FoajRGb2pWOEpudW4zZnpSUWpmNzVlUWtTUlV6M3VWbnlnZUQzQURj?=
 =?utf-8?B?VlA1ZzdkekRiMm9VeFJJcEFkelNBRnI5dTN2K1AwNEN3SFd4QkpwQVNEU25m?=
 =?utf-8?B?YUtkREhRRjdlNDhlMEpqZy9BQ3drMnVZbUJHY2c4N3o1elZwZVRoVHdpYlVy?=
 =?utf-8?B?cDcyckp0d3pFdi9ib0s2QmovanJJU09rekdrdGY0eVhUam5Od1liM3hKQTMw?=
 =?utf-8?B?RzBLQTh1aGRza1Q0OEllVGJhTms0OGt6WkFlaTZWTkErR24vK3F1WWgvNGFE?=
 =?utf-8?B?MVFXejNJNERrQm5vMjR0UDNLNlhRZ2V1cXM3MkllVXVKME83TkN0N3hFODJy?=
 =?utf-8?B?OXBhM3dsL0l1ZnFsMXJ3ZnJ2QWV0MDloNkQrTnA1emtNcGNuQ1p6UDJEWStv?=
 =?utf-8?B?em1GSHM0MkJwMjFlTkUrQmxXelFjWExSM1g2YTBXbVhBKzdMdFNldEcrUDNL?=
 =?utf-8?B?S0ZnM3lnb0dSWVJFQ3RCckg0RlUyWkxma2hGY1hhNGYrNDlseHRQZUt5cEsy?=
 =?utf-8?B?UGt0eGFZNzJGN0NwT0tialJhdS8rNzVlazBIbDB1em92anRwSkFndi9taFJI?=
 =?utf-8?B?K1laNEtrQklldmora1ZnSEdDbk1nUStnazJPRlRnVU1ob29Ldi8yZW5zVVBV?=
 =?utf-8?B?VERqS0RkbXJ2bEpEWE9wdncxQ1l4RzVIU2EzV2ttVUc3VE5VblBCVFY0WEc1?=
 =?utf-8?B?RDZLZVJZeUFFd255VTJvZFM0YlhxMlNhUTVVajV1ZFdFMXE4KzUyYXpYTTIw?=
 =?utf-8?B?L0hjSUdBMWlNZ2RaZUpPNmlrelRqR3UwRlV1SWFqK1NFTTZTa3FpVUFQMHBY?=
 =?utf-8?B?T1RoK3lSNkI3Q0lZWHNzVUdCa2Q3OGdIRFlwdldyL2JzQ2szaXRHNHdwdXhr?=
 =?utf-8?B?b3hEUUcwMzRwUDI5RDZpMkszTzZQcU5KRDM5VUZLTVYvdE5ZTVhMSDRYWXFh?=
 =?utf-8?B?WVVCUmlmcEJOMlNvZkcwWld0UDF4UkxHOGNnUURiNk03cUJKT3ZkSzJYOHRq?=
 =?utf-8?B?L3JHdXMwZzIwZmFqVUFEUGEyS1E2aFpDMHZhVHVoMnAvdlhRZWYzUzNCZzBn?=
 =?utf-8?B?dmtzbmRmMkwxcDhKblZkV3Z5TkFHMEd6OWxLUlhUMFlXMEtnTmVCaWJyZDNt?=
 =?utf-8?B?RTczNDdFTDY3SlFMMlpaYlk1THpyc3BBQW0vdUc1OVNvY3RPdnAzcnFwemhK?=
 =?utf-8?B?MDVsTEhYM1BSMktmdjlSY1FWOXdOVDVubVR2WVp5WnQySklnYlZ0MjltSHlI?=
 =?utf-8?B?dVVWeDNVcXZmRDhSa1ovejRlVU1DYlQrRDI4RFhVM24yZWpJajl5T2FLWVBR?=
 =?utf-8?B?cWxVZGxDaFdXK210c0ZmOW44VXVEQ3c5UndJMEZMaEY0QXRTSCszQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aa5613-7bc4-4afa-8363-08df0e7bd764
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:08:36.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGIDKIYw95dc1IpQZBzo5JCR2EblI15SuKgsFyl9jfKG0KaxZnooNp9ZhQmemXKiO2cfGlSuCGifWk9fVXmQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7312



On 9/7/2026 1:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] If `calloc` fails when allocating `btf_module_allowlist`, a NULL pointer dereference occurs during cleanup in `bpf_object__close()`.
> --
> 
> commit 2653ece25005f3595512126454652c2d89f17f3d
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> libbpf: support selective kernel module BTF loading via bpf_object_open_opts
> 
> This commit adds a btf_module_allowlist field to bpf_object_open_opts to
> limit which kernel module BTFs libbpf is allowed to load. When the option is
> unspecified, behavior remains unchanged, while an explicitly empty list
> prevents consulting any module BTFs.
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index c036e8a91ed88..d49e48c5c1417 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> [ ... ]
>> @@ -8563,6 +8610,24 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>>  		}
>>  	}
>>  
>> +	obj->btf_module_allowlist_cnt = mod_allow ? mod_allow_cnt : -1;
>> +	if (obj->btf_module_allowlist_cnt > 0) {
>> +		obj->btf_module_allowlist = calloc(obj->btf_module_allowlist_cnt,
>> +						   sizeof(*obj->btf_module_allowlist));
>> +		if (!obj->btf_module_allowlist) {
>> +			err = -ENOMEM;
>> +			goto out;
> 
> [Severity: High]
> If this calloc fails, obj->btf_module_allowlist_cnt is left > 0 while
> obj->btf_module_allowlist remains NULL. The goto out path will then call
> bpf_object__close() to clean up the object.
> 

Nice catch. You're right, this can leave the object in an invalid state
when calloc() fails. I'll fix it.

>> +		}
>> +
>> +		for (i = 0; i < obj->btf_module_allowlist_cnt; i++) {
>> +			obj->btf_module_allowlist[i] = strdup(mod_allow[i]);
>> +			if (!obj->btf_module_allowlist[i]) {
>> +				err = -ENOMEM;
>> +				goto out;
>> +			}
>> +		}
>> +	}
> [ ... ]
>> @@ -9684,6 +9750,10 @@ void bpf_object__close(struct bpf_object *obj)
>>  		close(obj->jumptable_maps[i].fd);
>>  	zfree(&obj->jumptable_maps);
>>  
>> +	for (j = 0; j < obj->btf_module_allowlist_cnt; j++)
>> +		zfree(&obj->btf_module_allowlist[j]);
> 
> [Severity: High]
> Will this crash if the initial calloc failed in bpf_object_open()?
> 
> Because obj->btf_module_allowlist_cnt is > 0 but obj->btf_module_allowlist
> is NULL, the loop will attempt to access &obj->btf_module_allowlist[j],
> which evaluates to an offset from NULL. When zfree() tries to dereference
> this pointer to free it, it will result in a NULL pointer dereference.
> 
> Should obj->btf_module_allowlist_cnt be cleared when calloc fails, or
> should this loop check if obj->btf_module_allowlist is valid before looping?
> 

Same issue as above.


>> +	zfree(&obj->btf_module_allowlist);
>> +
>>  	free(obj);
>>  }
>>
> 

