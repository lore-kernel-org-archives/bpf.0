Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012056.outbound.protection.outlook.com [40.107.75.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5F43803F
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234926; cv=fail; b=eNzE/QmuD4OaWFzben+139Yq73DSQE6H0/1ZEgr+k2Sdp9gZvOQDXhyQUNPcREK47eryo3ytOLDLNUN8LA2WaDv5kdqyqmayTgeJqsoBv5lPe/FjZGiahuR9O6I1XqALh6Jt4HhjkhC5eXJDoqnTigRNLxyjIJkyo/jd3DnNE2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234926; c=relaxed/simple;
	bh=IOnIler0k8h/6LXaTaiaxoU+GT9o3zhbiGcPeY4EYdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQ75KYpBU7A85ZnHHakXEqUjFGbv3Lp2XKvL05SKyEy6uaovvbKUHVzWQ32YikVNZjmuenoqdPG0DRdU0VRQpDg35v1WC3E4WvcLgy0ziW4HOFlCCjydpysvK2+LcHFQSy77KcCLLASZHK2zbvPOPEQw5k+iVsv/hDOVex7iEng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=K2F0zyn9; arc=fail smtp.client-ip=40.107.75.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="K2F0zyn9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BY4JDVvjbTy4VJAcj/by5J8KhwSfX5j9RQacVog/05uVsbE9J+3fGTMSO7mMd74gSqIdXAamL7BmCZH/T/PqIqzOc0tAreJFV5c8SYIYqIJ4mJidxhZCQyZ7OFwn3eQItYQcLHH2ArIWugY2LOSxvk6ZZ028+e9maj2J4UnC79WEJTQ5wVZWINECv/H/MYKcLjdcegUmYTDw/tyqcxlPvJPAPr6c/e9tr/ROwREmF1J5amHhWyVg+gQV9JOq/hKP0PW467kTh9Yh3/0aQ94VvgrJx7GEdY5vJ+hjS4mGFM947AcYKWsxXyxJ7P6Ca8cd+X/Umv+OQJp9YJxh+n+xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY8D8YB4jpxbXAlQRi4aWaEhcdATdz2eFnLm4/SYYjY=;
 b=u2UAbpSPN+PAJope4AeZwP470mmTvxMGFRyW0Yg3U+h9ab5bvHdFTwzUtj6c0Ftw1RZGPmlLmCVQu2Br+xmW+mLWxkwtCHytttsc2dwBb9o5US2KdFfXH4fqodDHZhCn6/1leqzxsxazCBayIPooX2sW3TBphT3Ks9uWYBnR3JaYee0/zOm9LeEGyqCElGXSsbiV+lJWp2JyyE+VqotQzQjXMji0aIaxHN+WeDIkgJYSPoXYzHPYzpO0cvQ5hBLmQL0gR4g8M4iUEV6xpr6iVY6qBgqDXznfA+GadR3HG/qZWAIdj8oLfSH1uZJMHLE6W7wzaO+ZX8tzpheKt2s4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY8D8YB4jpxbXAlQRi4aWaEhcdATdz2eFnLm4/SYYjY=;
 b=K2F0zyn9cSGY5YJL/1eyxtqZlbtn4e4q/GnTHQ589/CHIlUnOh4ko1UCywgl1KQ4u3DcUwpw6SRRiwnYouUS/hBEdTOJCVUNLCdw60qIYSzbXIU8o9VsEBIUQi87KQBiM5WeBXXRhOgYDsMxpcwsg7At0Ubi6+UDv5eF6K/ucqdU/VzOe9lZ10zV4WKNdikWEA7bnXvhuogstEzc+vzABQl6ZfJrpaIA6xmAnkdKfT0WHZsN9qYKQN53209qDaG5aKY46m4OEO5jYI7X6wjBOuBvV008YkUAnT2NfcR3jrujuGNDtJdV4cWLgdFLeAGBHejxdjXhWTJpk8Cl2glRAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYSPR06MB6673.apcprd06.prod.outlook.com (2603:1096:400:47f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:55:19 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:55:19 +0000
Message-ID: <93a27872-13fc-4032-9a2d-895a03455025@vivo.com>
Date: Tue, 1 Sep 2026 11:55:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, andrii.nakryiko@gmail.com, alan.maguire@oracle.com,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20260831133809.1161-2-zhaofuyu@vivo.com>
 <0d8168d43d5376a1f7cd9cff27658ce299e03993b3c5181883e647ccdc7b506b@mail.kernel.org>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <0d8168d43d5376a1f7cd9cff27658ce299e03993b3c5181883e647ccdc7b506b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYSPR06MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 816c5e50-655b-4506-a16d-08df07dcd73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bMCmfvy9j3iZXKtzhjM6WIvUJ5Gm8MTnXY3yMxl83jQ1eKCeGfNiysHQY1Sbe1hHeEm87Dor1zetWVSqm4Qr4gItC+8xwSMK6rLW1t7CnGlv0KCVdllisVbFeUFCzTzLRXwGhc6dOBysH3BYiX3sB+XKNyCliQYaDa4UsRnFVaW2ukw8jnQpwYKTPVYN2cNchlr2ehT9J6+Hv7kHcbr70v1plGx05c3Pl5/HWjninXByDVVnHXCSoq4+0EZq1TfzfepurxBrEV8rhRaEeWbapNpAlTf0LUl5cmxMgoL6DnhxHxM9eVIcsT/2gJfAEMwI5WrEjh6q/qA04VV+/TKeeRCTekRHaciHCXxkj//2ZzSJo5Qvlqi/V4q/e3mpO9xNXoOgIKZlJghM0TDdMyCvL3Z+cpCFWYAovD8Hcvbbl7wX9NRgmN5lwrWXgIYoQIpwTA8oPBbrlMBNhsBoHMdbSHNzUUinMjIVkUjRSRWSQnL/ilFP/nkm9WuOPWRAwW/33emIYEQuWyXvP4T6r4eamJ4KGi9aB7CUNFP0+4dk8AHz1Pf7q4Z3GChG5KjXG2lSieDhUX5cmJtR9hUpfDtCabmdz7rYTjlXq1BswYafk7S95qV7UC60JRw35IInZT9V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emlxSWVoWFhPYVVaU3k0ZnR5Yzlyck1pd0NTSEcrVmU4a04vRzkwMldSdTJQ?=
 =?utf-8?B?QW9xbSt4QUdiSnZrd0Z0MjhnZHowRnpkOFlWUFFuSHlMNXByKzNTaC8xNFRB?=
 =?utf-8?B?MWZhdE1yVXRnSDVCVHpQazFGY3JvRklKVkRRTHgrRlhFNWxwdW5uOHQ2ZUdk?=
 =?utf-8?B?bkJoV0NlTjl0aE52T3hDZDUrRUIwSWcxYXR0RlROc1h3dUVQNkRiRjFQNUdp?=
 =?utf-8?B?UHlHeEN4bzlaK0ZqOUN2Ky9sSnlIeUNEY05uRG52NzE2NE5ZR0pjdmxFeXZN?=
 =?utf-8?B?dlVsWC9nWXRIYVQvU2taQ1FQUGdWUHZ5YkcyMTlYNUtZM1I3eFNtY2VmYjc1?=
 =?utf-8?B?bmlnUlVrWSs0bVlia0xuY21lRlJ3RnlONFgxVzhSajJjU1JuSVI5V2RZMTRW?=
 =?utf-8?B?V0F0R0c0dnVVN3lZRSt3bG91YTZrWjZSY0NoQmVRUnVNZ0krY2ZQdXd0RFN5?=
 =?utf-8?B?ODdsak56RmNrZVRZQ2F6VC9DRDM2Y201ckFod1lSV0RGS211UzZkN3FIQ1M3?=
 =?utf-8?B?dVB6cFM0aDZkWWNzL1BXTW85ekhnRVU3OTZ1UXQ1UEJUU2hra3gxNEdyMFpJ?=
 =?utf-8?B?OFlocEJEaXlOUkpYWXBqa0t4Z0NLMjFUcm0wM2IzUkxPL1JQVUZGZWNnYWly?=
 =?utf-8?B?N2tmT0VySXJWWmVhaW1ndmNFU0RoUUgxS3pmMTkyOGEvSGlQVFVaOWJUQlI5?=
 =?utf-8?B?MWdrcFQ0VU04c0w5SXVUcHR3TnQ1Uks1VHVUd1luOGlGZkdMOUZTQk12Mm9V?=
 =?utf-8?B?RTF5djF1eGZGckpQbU1aZUhpaU93azFIR1VEcE1vaHNsRm1LSmU5TUNRVnhH?=
 =?utf-8?B?Qy9Vck5YcmowOUtGMWl5enJ5blk4SXFuVFY4T3ltc3lhQXNNRllzR1ZCK1pT?=
 =?utf-8?B?ejdkcmVBOURKaGluRnJyTFVTSE4xLzVHUk05b2toMVQ4VVNEb0RyUnBPeWJt?=
 =?utf-8?B?clAyTEVHcmwyTEFWVms0SnY5Y0dtYzh5bXh0a3FnSnFFbUNKa0RYWWlqTHAr?=
 =?utf-8?B?NnVHdThKckVESUY2Y2NKdXVZT29EVjAwdGU4cTh1aUdXa2hFc1hFNzFIcDlK?=
 =?utf-8?B?Y3NQM0FrZjdlTHU2SFNrNEFBWHB3VzY0NEUyalpOOFJ6TXhLSkdIMWNzL09o?=
 =?utf-8?B?ZkRHaEFDNmcrSjJiQU8xeEdLUWVhYkZ2SURPWkZpQVJ1eHN4MWZnbWl4Ukx5?=
 =?utf-8?B?RE52NDFjMTQ0bnhrd3FVaVphaWNNdE1HTERVY3R6NUtNRmdnUHFPZWdHSHV2?=
 =?utf-8?B?MjdLb05EOXdxakJHbjd2TDNIZDRMZTJYaGFRQS9TV3pXSDc3MzVIOW1RL1NG?=
 =?utf-8?B?WGZUK2NGN2I2SFRPaFp6UnNLdGZoOHZlbjhuL1l5dW9OVXZ6RlE1WXlnT0Uy?=
 =?utf-8?B?T2hZNXdPcUhzVUVuTmNSUkxkMnJZempjbUpEc0xSbFppUkFSVmtCeFB4L0Ni?=
 =?utf-8?B?bklFbi9lbDFMYTA5bFZNSzc1d013VFYxZEpOeEYyYkF5ZCsxUTV5eTlCUUZE?=
 =?utf-8?B?Vm9mM0NYaEZidmUxRUp3VExVRzRXbW9ZdlhCUGNOd3hpcHYrOUtsUlJzRlJx?=
 =?utf-8?B?eThpSVBpQk5VelhhTmtReElON3lKYTcrZC93RU9MaVFsajF0NXBTbHI5a3B5?=
 =?utf-8?B?WFgxZWE5N3d0QmNSWi9PZ1c0NzJCY0ZkSSswOHhXeGpRSjdUVXRCUUVQTkp2?=
 =?utf-8?B?VUdGUzNWbWVpZzJoWDlUM0NWaVFHU1ZKZVdvMXpReEZ5TXlvdXJ3NkVFY09C?=
 =?utf-8?B?RWxDZjhOaSs3ZHBYQ1hIdHJHT1llemowalZIdXQ2THlDbS9HZ0EydEpHSXYz?=
 =?utf-8?B?WGQ5TVd5RnVwT3l3ekgydWltbTlmZVdzZHQ0a0dzcHJaRlFmZnl4SG5iM2x1?=
 =?utf-8?B?MzNDcVd1YkJVREJZNWQ4cTRlRW05MUxkWEtkaXpFeEVKV0V2WXdaQVFOOUF6?=
 =?utf-8?B?TGNwNHdHWllsbS9PUVFRUEs5RW44QXhnclN3THJvbXVwOXhHMUNLTWdqeExR?=
 =?utf-8?B?bTBCZTloQmJITzdhdTdPMUlOVW9wSGhVMitBWVYrRUZ0ejhPNUF6SjB0TGNU?=
 =?utf-8?B?S0lNU3AyS1NET2x0RVpZUVpwZjErTFlsZzl2THNuZ0dlQ1ZHMmVIeGFXOXVo?=
 =?utf-8?B?Ym5qVW1hQjJHOWhhQ3E5QzQwOWw1WGpHVXlhemVsbzlzay90Rk1jWktvNGxj?=
 =?utf-8?B?RU9PRjQ1aGdPdW9hWWZKTkJGcm5EYUNQMVE0TzRiVWI4bDhuN3hjVjI2Y0ky?=
 =?utf-8?B?WDBCVjkzbkNBdUhWMCtkazc0QWFPN2x5aWN5dnA1WTY3ZXF1QnI1T3U2WEJ2?=
 =?utf-8?B?OWlGL0FiOXZIRDhKYk1RK2tPQzhSSUxDcWxzYjloUTRNZFRnZkVsZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816c5e50-655b-4506-a16d-08df07dcd73d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:55:19.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu9wBao6eXXtdfYciCOcJnCzP7K9iWUU1RNgd/whBZJn/htGSJSlrQWrtww5iwIAyobFXVpWxrSmD03INPwXrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6673



On 8/31/2026 10:46 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index b965ad5715403..1cabf7e465546 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>>  	 */
>>  	const char *bpf_token_path;
> 
> [ ... ]
> 
>> +	/*
>> +	 * Optional list of kernel module names whose BTFs should be loaded.
>> +	 * nr_btf_module_names specifies the number of entries in
>> +	 * btf_module_names.
>> +	 *
>> +	 * With btf_module_names:
>> +	 * - when provided, only the BTFs of the specified modules are loaded;
>> +	 * - when an empty list is provided, no module BTFs are loaded;
>> +	 * - when NULL, all module BTFs are loaded as before.
>> +	 *
>> +	 * The list must contain valid, non-empty module names and must not
>> +	 * contain duplicate entries; otherwise -EINVAL is returned.
>> +	 *
>> +	 * This affects:
>> +	 * - BPF CO-RE relocations against types defined in modules;
>> +	 * - BTF-based resolution of attach targets;
>> +	 * - module-qualified tracing multi-attach targets;
>> +	 * - struct_ops kernel type resolution;
>> +	 * - extern (ksym) resolution for kernel symbols defined in modules.
>> +	 */
>> +	const char **btf_module_names;
>> +	size_t nr_btf_module_names;
>                       ^^
> This isn't a bug, but would btf_module_cnt (or just cnt-style naming) fit
> better here? The other opts structs in libbpf.h pair their arrays with a
> cnt field: bpf_kprobe_multi_opts uses cnt, bpf_uprobe_multi_opts uses
> cnt, and bpf_tracing_multi_opts uses cnt. This looks like the only nr_*
> field in the public header, and the field name becomes part of the stable
> public API once it ships.
> 

I agree that a cnt-style name is more consistent here. I won't use
`btf_module_cnt`, though, as it could be confused with
`obj->btf_module_cnt`. I'll use `btf_module_names_cnt` instead to keep
the distinction clear.

>>
>>  	size_t :0;
>>  };
>> -#define bpf_object_open_opts__last_field bpf_token_path
>> +#define bpf_object_open_opts__last_field nr_btf_module_names
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33399468751

