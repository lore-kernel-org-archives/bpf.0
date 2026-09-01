Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013067.outbound.protection.outlook.com [40.107.44.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9532B12C
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234977; cv=fail; b=Rg662CrUqeB6PzDBebP3HoWliJkpqTC8xI+8PEUhtjlcOrt3h+Rr2YVvcziK0KEauYHS5wBP2hYjqfGYln3GCZxwmsho4r2Zm6j1Gdt4uoc3BxelDNvRJlVbu0NGDecUrG+Qy3CIpPsemYgJVq/vs67UalA57QfBVSafC9QpxRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234977; c=relaxed/simple;
	bh=xVTa/4ZeSgcpF/r1vslrMMxcA2vcT97guGFWoDPXLN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D3R80oJ7aRCiTOgbXLjWBy9bmTcUqYELfn9MqarW4JgmT/OIc69phu0PC5dFrHjEE5A5LLt4Ys2c2puP8P/kPH82BGSFqQk5+yAbHD5GkIHIrLEywEFyy+Gzax69QkHGj6pvWQdJ4BnUD/gDN0KjY8grv5vXTDHXeUdLFchM0lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ViJhiEC/; arc=fail smtp.client-ip=40.107.44.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ViJhiEC/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8hBMFREY6ShHTe0/shBKooRrYuuMuSqvZmXMXc6BtHQC6+l6UtVaPafO2J67Wb1XNh6EmfujvmK4FpKIu6xIrGQdd/kJ8KdbksxCn9DelN9MhRl0tkPsKKTA9WqEqKVt6QfwHpHd/qonUyFCMiwjcacxGq5OKpHvLVuhxT6mAY7o45nP3haJvzVLoK5jVs1Ikt3BoQWT9SMvRebFmtGLlbJk5lY4XNQFm0Q0ogF1ayRGWSx1kXolnX0epDwrMa7kHE8EtgmTUDUmzQU7cSLoB/7EaL9CrwLHMaWJFYXVsYcpya2xqDuzrIwc0l6XjCqvYG7mO5NZfxyq4dwq1kD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97C0hx6SCSyh1nsFqC3dNMAosQmqcu9qf4uNaQbFzI8=;
 b=hUkxP+p5l6s1kDjNxbc2P5sdi4VjCIcIJBzThGuTbGzeUbs4DAzCe3jfrFupoqJB8GsDs54/ucM1fsNHt3+geNlHeCm6cpw1+AP1Fbm4jkxaRs9Y9WHO0Adljsg9235ZomXFqR1DkqMl2zo/mmXGNdJCkrP8+Ru4YVXlAO3245ruv8UVah0fbk9yQwtOfZ5s8hLehs8YtwHFRYXjvNjiEavte4gJp3eaSMfTz7zY6nPRGp9ZXwnhiWUWLR+/qXtQFn1+a7z3MW4yswUW2xQfDiqzSScxBCrxQ/KGr1zCJAqeOnbl8w2xUZVzqJ9ggVWvRBYqk4wGMoGSbeqcdAeTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97C0hx6SCSyh1nsFqC3dNMAosQmqcu9qf4uNaQbFzI8=;
 b=ViJhiEC/eSKTaJmqx/+E2pyV7QpVQ84sXcryxxcg3tNa6by0bSGDIv2FDGnD3AKUQ4cBcJOo5Rbg7MUbIShYShe/fYEGTU4uVNpU/zL0DnpVoS+yMpSizPQlcsmAsrW0Tg3HbZK/07PlPWqtK839iQiYjmk4SCH87xxgF2vN3vWtkmRj+t/CkiQUo61R7olAuGrhNyyoWpLBDpRcU8+PpXeGUmH6smUPgo3RgsNwV03pifdmiV7G/XZCpfMjhAvaKNVh0o+3idpmfVHxiQpz1y96h8Qiij3WEb5L9oiredvFQ+OhQl7n+3Nd8C+psjwVGEXCgRjkxHYroCShXQWd9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYSPR06MB6673.apcprd06.prod.outlook.com (2603:1096:400:47f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:56:11 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:56:11 +0000
Message-ID: <8c0f94b2-5566-482b-bdbf-6637eb201ab4@vivo.com>
Date: Tue, 1 Sep 2026 11:56:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, andrii.nakryiko@gmail.com, alan.maguire@oracle.com,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20260831133809.1161-3-zhaofuyu@vivo.com>
 <d7e644a42a6bdc2ce95e361ad66ab18e00e688e7e1fa4f8a51b37b38cc108204@mail.kernel.org>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <d7e644a42a6bdc2ce95e361ad66ab18e00e688e7e1fa4f8a51b37b38cc108204@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYSPR06MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2e1079-a762-496a-a1d2-08df07dcf64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KSuCAmwhgWKRuv6fhzv2r80kxrUYKGb5KnyWP8PuaBvT6qIP9p6M8ZA2+uZeliIT6P1KOuKHiOe3twI47gH4aDOvYyg19jZF6jF9ArM/Q7UXrX1XdE3hi82clfS30cS0+Fr28HCo5nOKIGxXgqwQ+NAAfe4w59D9ZtmmCz1HM2YhNj7i0g50Mb9/tDyhxWCRxuvW038vOdjLymXUaQ3TVoFuhKXrJwKSB/w4svVFneI0JWnp5fg34xvcley8H93wSuDVt+ZqshTA8hMUo1XlLrqfwFhyIERXr2ypCDQgPNS2uqWP39oajTw45AovQn9H6NQaeHseznr6sFoPFrNj/r/GkPWqAD6Dr3wF6WPLCtlwE1flVfElplrYnQ+IkggheMEsbA6MCn5ZxdOit8Z7e9qMpciiHiqytCwlPTBmzQ8+9Fe5CgXmNvG4cXHcGcgD59gr7QWUH/z/9cd7tWK1TAd22f/PVeJJyaZLq1JykwaCi1OGMtqijeX5Vc96yDuYXWLbVoq1E9KmsQ9i5Nc4UtmlSU9SBj6yStQhLmMbobiI0UbUFDokrpV4mrWmYery1doOewZI7zuZ5qW6940Qwe8Vami0dPKXnET9TI2i10Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGx1Qjg4dGMvNzVEKzdVTWtXKzFZNk1QSnF0WEFKMFkvMlQ3NmhpUXpnVTFN?=
 =?utf-8?B?NFFndUc4T1FGdi9pKzRWdnZLY1dUeUxrMHlBUmE4Q3JnczlDd3ZhSFhqOHZR?=
 =?utf-8?B?VXZ4azBPbTRIanFLRnRxUFZCVnk3bytBelJ0UVpyLzhGelRCVXBlLyt1c0pz?=
 =?utf-8?B?SXdmWWROVFZkQjIybGluemoxUStnWnNNTExVbXlKL1U3ZmRiTzRzN25XU1Bs?=
 =?utf-8?B?b3hFbmZVcW85eXUzakovR2M1N3FTMzM3b2RyYkN4WjVIVFFHQ1lVdGFreDNB?=
 =?utf-8?B?cTIra0tuNHd6MzJyNlVHMC9JdTNIeXl3UzArdjk1cTYrQ1RkV25wUDhPN2dV?=
 =?utf-8?B?dW5YZVErWmp6RmRUZ21FcG5GaFhQNjRoTHpPMmpHT1BSUVdpeEZXOS9sOG9W?=
 =?utf-8?B?RXFEQ3RORzY4Q0U3UElveTQ5ellyRTFWZGNkNG1FVHJQdUZGN0dJZDhOektQ?=
 =?utf-8?B?dGk3UTFlenhQOEdidWE1dTZKd1hmQSt2SXl6MllBT1kvcDAzSWQ2d3BaSk4r?=
 =?utf-8?B?QkpWcUxrS0U0QUlZMkNCNFdnMHdqMkFnTEtzV0s4K3QrRmtWUDhRYUp1cmsr?=
 =?utf-8?B?MGV2YXN1UUhYSUF0dzVmcWR1RGFHSkQ0T3FWZmJDZlUrOHNPY1g3bSt4Z1JC?=
 =?utf-8?B?TVcveTRwV0FVbHBsQjV0b2N2RHpEZDBYbjdrNkc1bUFpaTdZY2lJU0pqb3Jy?=
 =?utf-8?B?WTZlK2Y5OHFaTE41ZDNsUENUYjVzNzNmQjYxMGxSU21xSGREZWF6cVVGZWdO?=
 =?utf-8?B?dGE5bWNZSkg3a2VhRHFTSGxrbitpUEdnWmlzdmtVTDZGNzdlbXg1MEVEcHV3?=
 =?utf-8?B?dndXeWxxdU9mMGw5Ly9BMVZ6bkNNbW5RNVZKRW9xc05oTTdrcy82TThBcy9u?=
 =?utf-8?B?QUJKSmFRQ1RGZmlqZVBhbzRBZFdiVTcraHBmK0ZKVkNpZ3BYdWFwUnY0Q2g3?=
 =?utf-8?B?dGFta3VsTXRzSE5FT2pOSVB6MDVtUE5iWTlZRmNSQVpXcVNuV0VNWmlXWWVF?=
 =?utf-8?B?VmNGZjJxbHdSR0RteUoyYkRvVDlpdm1zTXVpWldmSU9SWEp1SWk5SnZ6WkVr?=
 =?utf-8?B?RHp0N2cyWHJ4eU04UEFNMk5YRmlpZ1YzRE9GYWNKQ01tbVRZRzQ0cS9LK0wr?=
 =?utf-8?B?bVZXMjl4UnBOdlNDNGRNR2RhcEdEckRUaUtSQ0NLYlUzSFVDRnMzc0Y0VVRK?=
 =?utf-8?B?elFIcGFDTUtHcEVDTmk2Q3JRN0pINDJZZU5Lc1JiU05iR3RVT3Uwdncxd2Uy?=
 =?utf-8?B?eGtBWi9Vbkl4bHM5c2ZUMkZyRWZINXEra1c2bjR5azltbldZVDJZM0xXNzRP?=
 =?utf-8?B?NW9GZk9CODVjYmt5K2FFbVhaQ08wSWNhQ3QxZkZEeUpDK0VBV3NpeUhkcmpM?=
 =?utf-8?B?L3hlN2pQbnVQcytQZlFRaVFWK1VFL3dFci9FNGwya2U1QklISk1PMUk1Sy9Y?=
 =?utf-8?B?dDZrZXVVWlVETjI1S3ViWWJ4bThMR3lOSUU5ZC85UXhZT0pCdU5BNEJKQWMy?=
 =?utf-8?B?RXJhUEV3WG85b28zV3JFR3FEc21nOWxyL3dEV2pnS05qem1LNjYwMHhmQW9T?=
 =?utf-8?B?dVJ1V09nVzlBMWVWT3pLV1FjZ2pwcHhVcXpELytJL1NQdE5nR1Q0SGJwYXBQ?=
 =?utf-8?B?Ujc5TW9nTGkrVDdNNFBHOUFrcTh3TlVmS0lHVnN6M25IYk5HMXIxSHlKMWdJ?=
 =?utf-8?B?SXpiMXRCTVJxS0s1N2NoMG9NRFhqZnl0dU16bmFEdkoyanVwVHErdU91RDQ4?=
 =?utf-8?B?UngwNnF6Qm9Ra2F1OWJVWkFBQ2pyVm5FYUE4QUo0TnAzSWpXTFgvSjB2ZG1p?=
 =?utf-8?B?WnRITXJ2WFFRL0x1TTVMdW80Q3FJS3FJTWwzL2xuQ3ZwWnNUMVF1R0Y2UEUy?=
 =?utf-8?B?SkRKZzJJN3Bvc0lucEM0VE92Q3RUek9SVUdMeGkvcVVjcUpKSmU1cDE5b1Rk?=
 =?utf-8?B?V083alQxQmZROHFvQXE4SlhHWXM1a1p0T1Z4L29pTklzOXI4TGh4VDFZYW0w?=
 =?utf-8?B?aXAycG1lNnVmbTlFUms4eElvbWM0aEFvb1Z5VHpOYjZoWWtqeFhxNC9FS2sv?=
 =?utf-8?B?bE82YWFWMFNKclU2bzhyL0dlL1ZDS0p4N2RFL0hhZ1FjbzBQUjNQT0dkbVhB?=
 =?utf-8?B?dk5DYnNvaDFJRHpFYU0rQmlZUHhrNy9HM3p3aG02YnpZRWh3QldOeDVGK2Vl?=
 =?utf-8?B?dTlCYVF6VkJLT1N2QXVTUml0Y3VJd1RIWWsyQXF4aDR5Q3lwL0JtdEo5UkhZ?=
 =?utf-8?B?WGRFYS9lMlNVU21CREl0SWJMenZBOVR5NWJJZXZXVHJGejZ0NGp1c0hoTXM1?=
 =?utf-8?B?SzVrakhKbWVNQ3RvVEJ0YTNhVDBoTnJ4cWQ5U1RLTEpGdnUzakxmUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2e1079-a762-496a-a1d2-08df07dcf64d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:56:11.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42uEcdsFbxLPSCYEmjFr8WnIl+PnCgm9fD4H5fv5JRFqIsvkZQS97kstDRud49/7EzyDy9EAsJ097YSHxqCHsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6673



On 8/31/2026 10:46 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>> new file mode 100644
>> index 0000000000000..68f4a8d735608
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>> @@ -0,0 +1,162 @@
> 
> [ ... ]
> 
>> +/*
>> + * Verify that an unrequested module BTF is skipped. The BPF program
>> + * requires the BTF of bpf_testmod, but bpf_testmod is not specified in
>> + * btf_module_names, so its BTF is skipped and the BPF program fails to load.
>> + */
>> +static void btf_module_names_skip(void)
>> +{
>> +	struct btf_module_names *skel = NULL;
>> +	int ret;
>> +	const char *mod_names[] = { "module_nonexist" };
>> +
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +		.btf_module_names = mod_names,
>> +		.nr_btf_module_names = 1,
>> +	);
>> +
>> +	skel = btf_module_names__open_opts(&opts);
>> +	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
>> +		goto out;
>> +
>> +	ret = btf_module_names__load(skel);
>> +	ASSERT_EQ(ret, -ESRCH, "btf_module_names__load");
>> +
>> +out:
>> +	btf_module_names__destroy(skel);
>> +}
>> +
>> +/*
>> + * Verify that an empty filter skips loading all module BTFs. The BPF
>> + * program requires bpf_testmod BTF, so it fails to load.
>> + */
>> +static void btf_module_names_empty(void)
>> +{
>> +	struct btf_module_names *skel = NULL;
>> +	int ret;
>> +	const char *mod_names[] = { NULL };
>> +
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +		/* Non-NULL pointer with zero entries represents an empty list. */
>> +		.btf_module_names = mod_names,
>> +		.nr_btf_module_names = 0,
>> +	);
>> +
>> +	skel = btf_module_names__open_opts(&opts);
>> +	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts empty"))
>> +		goto out;
>> +
>> +	ret = btf_module_names__load(skel);
>> +	ASSERT_EQ(ret, -ESRCH, "btf_module_names__load empty");
>> +
>> +out:
>> +	btf_module_names__destroy(skel);
>> +}
> 
> This isn't a bug, but btf_module_names_skip() and btf_module_names_empty()
> look like the same body with two initializer values changed. Would a small
> helper taking (names, nr, expected_ret) read better and keep the subtests
> to a line apiece?
> 

This makes sense. I'll add a small helper to share the common test
logic between these subtests.

> [ ... ]
> 
>> +void test_btf_module_names(void)
>> +{
>> +	struct btf *vmlinux_btf = NULL;
>> +	struct btf *module_btf = NULL;
>> +
>> +	if (!env.has_testmod) {
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	vmlinux_btf = btf__load_vmlinux_btf();
>> +	if (libbpf_get_error(vmlinux_btf)) {
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	/* Ensure bpf_testmod BTF is available. */
>> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
>> +	if (libbpf_get_error(module_btf)) {
>> +		btf__free(vmlinux_btf);
>> +		test__skip();
>> +		return;
>> +	}
> 
> A subsystem pattern flags this as potentially concerning: test_btf_module_names()
> has three distinct prerequisite failures and all three collapse into a bare
> test__skip() with no reason emitted.
> 
> The resulting log line is identical in all three cases, so a reader of a CI
> result cannot tell which prerequisite was missing, and cannot distinguish
> "module BTF support is not built in" from "bpf_testmod failed to load".
> 
> test__skip() takes no arguments in the BPF test framework, so the idiom for
> conveying a skip reason is an adjacent printf("%s:SKIP:...", __func__) or a
> trailing comment. The `if (!env.has_testmod) { test__skip(); return; }` form
> is universally idiomatic in prog_tests/ and would not normally be raised.
> 
> The escalation is really about the two BTF-availability skips:
> 
> 	vmlinux_btf = btf__load_vmlinux_btf();
> 	if (libbpf_get_error(vmlinux_btf)) {
> 		test__skip();
> 		return;
> 	}
> 
> 	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
> 	if (libbpf_get_error(module_btf)) {
> 		btf__free(vmlinux_btf);
> 		test__skip();
> 		return;
> 	}
> 
> Neighbouring tests like prog_tests/btf_tag.c annotate these conditions:
> 
> 	printf("%s:SKIP: btf_type_tag attribute not in vmlinux btf", __func__);
> 	printf("%s:SKIP: btf_type_tag attribute not in %s", __func__, module_name);
> 
> This matters more here than in a typical test because two of the four
> subtests assert a *failure* code (-ESRCH), so silently skipping on a machine
> without module BTF is the same observable outcome as the feature working.
> 
> Would adding skip reason strings for the BTF-availability checks help
> distinguish which prerequisite was missing?
> 

Good point. I'll add skip reasons for the vmlinux and bpf_testmod BTF
availability checks.

Thanks,
Fuyu

> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33399468751

