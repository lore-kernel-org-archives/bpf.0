Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013065.outbound.protection.outlook.com [52.101.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6232F8EBC
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629369; cv=fail; b=hQKoQdw8lUYE4dUzU4qGl73SPD6wOyoRcLHM25s/V4yIWQ72ljfg5vGAGIjn+kDWIS60ijUxSv+nC0Y7rbHyEnvVe+OpheaQaZALRhycupWZluhCfuaddMG5PcMPw9+vAb8KXSO7pj1LvXIix4erepgqCbrii3bwE9vsuw4YtOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629369; c=relaxed/simple;
	bh=a2n17Ucos+vBs8dxznO7PANhL322dnOts33/HVcoi7M=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lclkl11QtYWhRtorRhKFT9DTC32QhYSsuTj+Byp+T6qNSNh3sTnwc6pavrbcqbJShscE2HcWTv06VFORPmKGvylAopdlnSR84GUWE5Xfb201+u/5D6bpMnYsgyf3raIVQ3E/aB3Z2CCm+3UFo5cx4NweUkiQOnvlHdqYVoLc9Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YIkrdDcJ; arc=fail smtp.client-ip=52.101.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YIkrdDcJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3okSsCf9UslzCQDXblZHG3fHh75dOpfIsY5TJiXdrLF8fvY6BRNaWPudbIgKPnzfkbAon4KkT0IDApeXPfDr8Bbjtblb12eLIjohL911LSvecGvQyVEZ4oNyJBQ5MLGlOVV0yQA/RkRY5BBAltUbV0gBM3AtkM7x9XPUJ+fA5tC+dijtgT2L4L85vybswnKBOwsYmas0qrO/DgW9qD5uhdJZDh79l/17BYhP0GRajjTMVYzisF25TMr8xkUB5ce2tXY5dKN3Ey1EnL6QK0p9byuz+5vkMt6fxoUkufX9QfvXLx1BCYVzyirKj0BL5WclKQQFaBp0ZhxkqtXjE8I1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIQyOPvhewrGcdr6tJ1e5rryeddwVETqa5sh1epp2Nw=;
 b=rnDoCT8lA+ttDgv5h2teiqh9gfcayMEoqezjT55pAAQa8BRMI7pJ5f2f5iD92fBzkEw33njt7P9Gpxng1Q2ncUGyVoXP444BBkturnYb1wtfL77oxYTJZo1/8mnaJmkCZeUh+hPoZ7SCcU/RTQJTN7p16RVO93IVYUd210M1PkZ0YKoPpa9vgxv3AP+A6H2+wQGSKpnu1Gq+7U6i/Ut9d6dEoH30cYxgszGDfQxBAk8cdH56zGe8OymKrf8TtI97pHnGhli9ZAxcdl0Okpg6qKefrUIbULFqbaYEIeZPyCHa8AvkRd+WUFbo/NYqM/YGlYHL7MhuOKC3FHEa7Xvs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIQyOPvhewrGcdr6tJ1e5rryeddwVETqa5sh1epp2Nw=;
 b=YIkrdDcJL8K7ntapmcL4Oj1pqTFoMLKu6N/sVoQADHK6ULXN94Xy1txg58J72abQTarJJs5XWgHKfRalp0OGsW2qg5IKZ48vnDlUmwS/PRJNLkFD2z/YVjxmr53pTqDlsF7+0v+eV4OoMjls407US9bYJCe4WcXB7EmAJiBI/H5+GejaZHwCbsx0J+HNHlV0eba81w4VIH6OUpAaqmMjv7303cu/Wpaczu4C4POeuptZc/1IcbShrHKRdeGnaJhl8t8AqaDWNS+7JOr6dBMBOGG7bN3/tPqTT6AvgtIZbO8Dl//um2fbwaYIzda9RdDynq25aG6uIbT1T4W/NM/XYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KUZPR06MB8967.apcprd06.prod.outlook.com (2603:1096:d10:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 03:42:44 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 03:42:44 +0000
Message-ID: <d2b58551-dce5-4295-aa65-7b85d8dbd8e6@vivo.com>
Date: Tue, 25 Aug 2026 11:42:41 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v4 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org
References: <20260824125310.1384-2-zhaofuyu@vivo.com>
 <8b583f9deb409bec43e97f558b1e3197f2cd54ca4e5121eacada28b04749f812@mail.kernel.org>
In-Reply-To: <8b583f9deb409bec43e97f558b1e3197f2cd54ca4e5121eacada28b04749f812@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|KUZPR06MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d17f5a-644a-4334-ce23-08df025aec4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hRy3GHKskKlYwVIg/Y1nTfmylXNvC8YbMgfyxpZ0Abonq4esmkVYTGsB8S1liLsyYTFOwT7G3GPY2e4g1BxGqC52oy8KqR4UyMVv6Mu28SZIlR+f/UDfZA01eYyDvBOAWrTf2Cu8R/JFwlv5hj4qUQlj7i0X2aTGnLvTfl4cXVgtKj3ZI4G8DCxhtuaiLfQM49YYO/nptCg5Dr4mSitOHfgWg1IGApuRU6TVdWfQ5rNcWpbSRiPR9Gnwn7ouvDzUqXZMMzoZrEc4lKmfsWnxGDCOcvK0Pfe63tO77LzcuByA7x3Q4yN7W/HXR++My77zozFoKcuVsU6wUTIpwxRm/cl/9J2OU+R81AoiM7fDRNhWjrI6z0FZ4IyTPBzzfv0OdJWthmrbZzFht1o08R7M6udsxR94wEA4leHaVID8xu7LwPwWPzV4P24ejsHkLrO5shBa/G8NDRX5wYzS5UAFVtYKY0RpLcpajne8+OqHOc0Z3SATuFUZrlFtr72aCP4acCqFb44NBsQTcbc/y/kioAGJqwWAAiBQH+9wYsJtkzY0/Mn1Qa1l/jV6F6cz1U9w7cn7dQwywUKXNwncA0JxgO9SH94196LxnhH/Oo1BAT3M6Zx3SqFOzB50fDsEA8wM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2c0L05kOGduN1NaaUpmaUVmUzU1TEJ6WTVia0FobjF4OGxDeEdxY2ZvS3ls?=
 =?utf-8?B?dlV3bG1HbkFXNHZVZ1IzYmYwUGs2VnhxamNWZ2F1QkNIRk9Ja1piWXEwNFlS?=
 =?utf-8?B?bUtEeDR2Uk1EbnVjd0U3NkJQZldWRnJHVW93QzNpemxXSmVnUEx0RmhUZDg4?=
 =?utf-8?B?YkM5N3Z5OWorU29xejFva1hWd0Z6emlHNXg0TkJJOFl6Z0J5d3FLOEhZMVRR?=
 =?utf-8?B?WlNqaTI3dm01VnBISE5uRjFUcUhNV1IwN0w0K3ArYjVkWGFtbHZTemZMaUNK?=
 =?utf-8?B?WDlUb1grWjc5K0J3MzZqUFJxYmNFdGgrUFF2SUxZZ0haRUhYSkVBSWNOWGVr?=
 =?utf-8?B?T3NIcWVIdm5oYSs5d3owM2xIdDF5aUF2RFpGZWVXSlV1dm5wdjEraTYvOWtU?=
 =?utf-8?B?TGozckh1SERXb25SM3lweHdwUWFFNkwzckwxOWsvTW5BVzliMDlFekliMnZx?=
 =?utf-8?B?RlFaajY5TUpuZzlUV3NKUXB3Nnk3SXo3OE1MOEMxcElqc05OOGNCaXYzTUgz?=
 =?utf-8?B?WUNTV2JKcFd5c2gxaEFPc2dVQlFFZkpmcHlMVGZYUklNY2xQTnp1bXpIR0NP?=
 =?utf-8?B?K3VBNWhuOWZrTWNXa2ZaeHZxQUJXWFZON09YYmRucTRoR0hkWjkwTUFuSUNJ?=
 =?utf-8?B?OHlqUUpzaGNjZlh2Y25OSjZ2S1JzSjY0cm1sVXI1eWRRUzU3RmF6c1I0RkNQ?=
 =?utf-8?B?ZmRGQ1QxQzVoZytnRElMR2RJYS9ub2NmRkE4M0VKVVJxU3d0RmVKNkVINC9r?=
 =?utf-8?B?eTF1UTRUWnZHaG9vUjRNU0l4RGRYOGpURDhtSDNnNDR4RVFGT3VZclZrL1U5?=
 =?utf-8?B?c0trRVZQMTlIZnBPcUNOWlFHb0JqNGRURkVOY3pKZXVwd3VaVHdGVWh5Wk0v?=
 =?utf-8?B?VUs1U1lveTF1Wk9kVmdsQXFacHZBTkkzbTgvSHZ1MXVPcm96aHc0VjBJWXY4?=
 =?utf-8?B?NzgvMUZtYXFNeWhNcjZ4cFBSd1pUTTJPUVlQZHZwdk83c0pqMXhMSXJ5RnhV?=
 =?utf-8?B?OTFENWlsVUtXUTR1R3JIbCtPdDJEekRiNHNNMHVsRlFQeW5CbFhPajR1TEp0?=
 =?utf-8?B?RjhkR1MrY2dadlZGZDRqbEEvb09VSVBFb1NZVjFyV3oxZ0FFL0xYZUpqRStR?=
 =?utf-8?B?NnNuNWVYVU9OT3JNTjVLL3JscGdDSUIrRUc3WVJMKzUxRmE3enBXUkwwZTBn?=
 =?utf-8?B?UDBjamszNEhGT3UwUGdwMVJCWDZ0NVVXQzhGSExweFIyRnQwT3hldHluQ0lr?=
 =?utf-8?B?WURrYUZtVTBWTEpESERiS3hVOHE5bmRyTExhZjhad01YVHNiaHB3R1RDS1My?=
 =?utf-8?B?M0RKR204WkJrRnppUlpYMVhYNnQ2aWpKN2w2NkVaK1pRajREVmZhalZ0allY?=
 =?utf-8?B?VFpxVUV2VFQ0MlBXZzBmdDJRLzNpR3hibVhjTzBRV1JqSTJESDVRbml3dkNq?=
 =?utf-8?B?RzE0dU1qK3JnS2dQVDN1WWpGVVVHTGl2WkZGamhtY0FqdTd2alk4Y2JBREdJ?=
 =?utf-8?B?WnBXZEFqUDAxY28vQjhKaXM0SW5kek1OQmFzcWlCMERZV3g2ZXUwVllXT0hV?=
 =?utf-8?B?K3pybW13RGNLRzk5TWJjYW5mUTFEVmIyQXprbWpPTTBmUHQ3TUpFZ1hWMXFa?=
 =?utf-8?B?aG1BRjYxR0lsVWxMWEtUd2xaRTF5bmw3OThZbnNhbzIwcm0wZVc5dldxOG9r?=
 =?utf-8?B?WG1XbzdSUVYvK2lTOHRYWWZzenNmTE1POUJIOUxNcWM2cG1YWjJwSGJ3TUZU?=
 =?utf-8?B?eEJhRTZPUWcxdi8wMEZrZStHQmlYcSs4cHI0YURhMENUMkJtSThONXlrU2J1?=
 =?utf-8?B?NFpGcEtrNlhFVkxtemU5TkxDNlZ2eGIwOC93bEN5S0dOMERYVFgxaC9EV01u?=
 =?utf-8?B?MjNBZ3RuMlJ2bHZ1d3RpRzZpTmluVUFSc3hrMENQaXNxQlFrd1ZoUFZzaVdx?=
 =?utf-8?B?cURlZTdNUWZ1Ujcra2tHb3lMWmJOd3lUZmsvR1N1YWJLaHVSaUcwVDNHbnU3?=
 =?utf-8?B?d0NDajhZNE11bFpjendBU0JyQ2NUU2hJVklEU2ZIN0V5Wi85NVN2Mk9scTZO?=
 =?utf-8?B?NEk1azVHSGhuL1UwWEN6cFhRSXZoZ1dDWFQyVkZJQTZzSU9TT0NWbjVGU2E3?=
 =?utf-8?B?SnRab0xsY1doMnFiSGNMdUEwdXpXZkIvMmxISkovOCtQOHBsMGRoODNOdG5j?=
 =?utf-8?B?MDE4SHAwOUtQc3U0QjdUd3BUaVlONDJRamxKc3cyMXVMZG9LNVYvRUIxTVlN?=
 =?utf-8?B?MzJJOHJicTYxWGRIdDlmZUtjLzk2ZmZGVVR1TUJyenRJNmhiY0V0dXdBVDZi?=
 =?utf-8?B?UGlJM29WdDJaTnZObTQyMlNLV0MxQzFuZzE0QTEvZXJjSUxoMERwUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d17f5a-644a-4334-ce23-08df025aec4d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 03:42:44.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt8LP3/4HfMUPDwwR6mcH1K+9B40PshK0w2EBqF+Uag6sz0NONJOlKExm9bKX/IhgJ5xx6TWuQfBgg78sp1GRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8967



On 8/24/2026 9:31 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index b965ad571540..838602319da8 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
> 
> [ ... ]
> 
>> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>>  	 */
>>  	const char *bpf_token_path;
>> +	/*
>> +	 * Optional list of kernel module names whose BTFs should be loaded.
>> +	 * nr_btf_module_names specifies the number of entries in
>> +	 * btf_module_names.
>> +	 *
>> +	 * If btf_module_names is NULL, all module BTFs are loaded,
>> +	 * preserving the default behavior. Otherwise, only the BTFs of
>> +	 * the listed modules are loaded. A non-NULL btf_module_names
>> +	 * with nr_btf_module_names equal to zero means that no module
>> +	 * BTFs are loaded.
>> +	 *
>> +	 * The list must not contain duplicate entries; otherwise
>> +	 * -EINVAL is returned.
>> +	 *
>> +	 * This affects:
>> +	 * - BPF CO-RE relocations against types defined in modules;
>> +	 * - BTF-based resolution of function attach targets for
>> +	 *   fentry/fexit/fmod_ret/freplace/LSM programs;
>> +	 * - extern (ksym) resolution for kernel symbols defined in modules.
>                    ^^^^
> 
> This isn't a bug, but would it be worth adding struct_ops kernel-type
> resolution to the "This affects:" list?
> 
> find_struct_ops_kern_types() (tools/lib/bpf/libbpf.c:1049) looks up
> 'bpf_struct_ops_<name>' via find_ksym_btf_id(), which falls back to
> obj->btf_modules[] after load_module_btfs().
> 
> A struct_ops implementation whose kernel type lives in a module (e.g. a
> module-provided tcp_congestion_ops or sched_ext-style struct_ops) will
> therefore stop resolving once a filter that omits that module is supplied.
> 

Good point. I'll add struct_ops kernel type resolution to the
documentation.

>> +	 */
>> +	const char **btf_module_names;
>> +	size_t nr_btf_module_names;
>>
>>  	size_t :0;
>>  };
>> -#define bpf_object_open_opts__last_field bpf_token_path
>> +#define bpf_object_open_opts__last_field nr_btf_module_names
> 
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32730521630

