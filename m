Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013062.outbound.protection.outlook.com [40.107.44.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D4356C62C
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962935; cv=fail; b=jVroZe+jlThjWov0EmopF0C/iZ5WBFH1b7yWlk79mF4ey80dLvrhvTVO3dV4i5B+kTSWCPUfAtYp7VjeBe48x3OmoKq4wpXcnmNurvgITMX+JSXZUccBjXl02oUaiJxHEHAKQhSf0+Bkrsv9u/n5Q59FYjIdspiEkdQxqMCe+1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962935; c=relaxed/simple;
	bh=mfEf3vNmIr/Fa0a/U/ZxSdCgAG89lL6AMn3xlCxrQrU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJ5BO/g+0DGN1h5qV0dCEJxlldqujnOJQpMU1TYiilYi4oUrR/bnRsw/pFYhboghJrJKJutu8V25Yl3OiogZHKNRZKp2or0EluXrkajsFpqOZ2vsRoRFxOUE+ZZBJV9tYIVtQNFMeIijtHIDRNIud4Liwcdad9AQ68bX7BIsDCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jHgeYX8l; arc=fail smtp.client-ip=40.107.44.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jHgeYX8l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmfHEwnnb5S5oMYheIas5FmJqTqplxqiWHasi4NHK0P1S47I0BA9gqqnWf90G2NIUCLOBgYReZ3v4fgFb39eZj/1XylgapZ5BoudjqqPYD8yMyaM4VQlt0raq2xUkG4aYvNxGy7vqfy3llJDZ1Pq8bLVh99bilh6b3eCKKoBjSXXlME/rZudLa/0mJ5VlO08UZA7kJ+kA2/WZSHz4P7WsHhU7ZkCY5K7Syb9B7iUWdbMkDiJetfgOTppnLr+JGskYkb0iu0+IzpKJp5MGLErNV2xAoqf3yx7oyuHdseDWE5USOGdIoksRpDw7TwAD476cxQ88U9Q0/XjNY3vQeAP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89eeW5CldVPjxSV9T2S4jm8WES51aZ8pEdRgAAVS0lE=;
 b=RQ0qqZptHuhAZMjJKQ2CAWfarSjas0o2EyQUjXYz3LSkCf2EWX25wXwPNp8OmYVkCdMkYriPiG0Sa0FbCRjjHjesIfjqRLD+uuURW7ie5UvBsgF1jPJFc0CEsSk4ZZBquo6vh/YOeO5i9Gu/W0fOZsHjcQ7rb62nrp9xT2SUOmsNoCXiQKiGz12V+CfhPD9ScxLiyHHzDBowJh8OTehuiF0M4LcTI5zbwnxxD5wzFocPObwAbL3RhFky56tcXhtpJ3vfYVHtFXMKsQTSkj/8Ai6/BIUslfo0c2ulpPSGOmc3diCzuunfSywYl8Qp9Dkv2VDFNmaAWwCWLoKIAh97dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89eeW5CldVPjxSV9T2S4jm8WES51aZ8pEdRgAAVS0lE=;
 b=jHgeYX8lklzFI/VxL+w5Xnce+XEsgmtwgNqHxX6Tu5N4iOPPVSsJdjzhAfSLqJH0XsnAh/zoKnpmfJ6HxcV1FikOKLWx0TWWSyRgtmldUnKyEENAHBIu/M0kY03F0dI9IVWFO+10VzoVDobFITM9Iv7JQQQ0iOXtYzAtGkIi/pJI7oxGZ7zMoyoY763/IqKg5ViiACv9qB2gL1hbPecafvVZLXsgXDyYv6mdOPJrVSQ8eFUpyeXahAsYWawUqENzyrZmLs1Zp4nONJnep7sDZU7kjtX4FQF+4OXVBII3/Cg0ROZyqlFcBTCX5h7hwG8YbFowc1YkWAdPxzjlPDp3NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SE1PPFF06F8354E.apcprd06.prod.outlook.com (2603:1096:108:1::42e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Wed, 9 Sep
 2026 14:08:49 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 14:08:49 +0000
Message-ID: <d4fb4bc7-54f0-44d9-be76-9fb92f3eafb6@vivo.com>
Date: Wed, 9 Sep 2026 22:08:46 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
 <20260907053847.1115-3-zhaofuyu@vivo.com>
 <20260907055149.C8FC71F00A3A@smtp.kernel.org>
In-Reply-To: <20260907055149.C8FC71F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SE1PPFF06F8354E:EE_
X-MS-Office365-Filtering-Correlation-Id: f39a25d0-b3b9-42e8-f2cb-08df0e7bde9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bxQoVZXx5BabsNcnPVgOwvdJcu9XtuCtOBjbIIhaG52Gcz/Fyt/apy72Aa1ozk5gkJa4ovzPs/pFG97HvdmpOrDOKuXfjWXn59zU/hzJ7SwkazVzMkJ4pu/YEOSkLYP+exuKhdmAxZj/RK2CzqIwBrI91ynTu+xdAe4JYZtNHz93Q9fzCoh/MnIJ6WKzXOonLpT9MPfpElur/lWIBYbY+3XFk67T+dmQRpaV35FBvtLplzJfU3JlVYksPptNMfs52RajYL1ws5WBmlkvcRJXAE+9n52WvzetY84OxEvG+qFtMamYwR+Cb/yWk+f35KW18wLtRFwoepJu+Pw2zD3VQtVfSfOZA10Si6T/HzkfTSUosMOlPKDkNx/ko6enMntcf/L3YDCOKM/3ZUKJtIjEZ4TxKjNEXkVZll+Vbw2QyHhk089O7MhJUUZAs1Xb1Jkv6Y3g5LstM9UXylOEVhSfEBcFOYRtZuccNxK2vrRkFIYSMMsBKh3/BOBF9k3mPTZTKykkeh/1GrkNlPxZ2NE5baG2Jn0dzCho/EngE4ErgttMtGtyr4/UTq4KGcK4qBUi8o6u1nZTRbAjHZ9aJRkD8YBXtt9TNHWELrU5+DEJ8x76McviapUQht/O04v93BZq17mUMOOMHcwUqT2b3luvOFsHgG8hKeruUqd9XYJIpYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1JvN09ZbGpHY2lsaFVCSXBYcW5BdDRmWjFDSm53V3gzM3dKcDVjb2diYzQw?=
 =?utf-8?B?MFdvME1Dak00VnNVRXlQRHEzV1E4NzUyV09Zd3ZQYWhWbGxLRkExdTAxZ2l4?=
 =?utf-8?B?dXdkRFFJZkg2dXV1ZEY2WXJOVnYwMGJPTVlmL2h3dTBzQnpOdlFCdEFZS2hO?=
 =?utf-8?B?RVB3MkhhRlV6UUNqWEpRcGtnQytSR2FacTB6QnV4SzZtRElOWmdxNFFYMFFv?=
 =?utf-8?B?MFd4RFJ1RVBSekgzZEVZcmpQY3UwR1M0aE5XRmMyNFl3OGhSQ2pOREtLMk80?=
 =?utf-8?B?WlFTVG5pVmlXR1IxYUVXNE4zU3dqMFdaa0N1dnd0Vi9DRm5DWVhUeERmaWZw?=
 =?utf-8?B?NHV1YTBCdlQrK1FLdk12SThaL3NqdEVDb1R4aXp5bkpRWnFUckx3SXFmNjVX?=
 =?utf-8?B?emVidEIzUFFkTzJmYlRzbnc1enQwd1NhdnlGZXl2TC8xeE9vYW42cHpQTk1N?=
 =?utf-8?B?UzliMGRkMVVuckR6R2puWUxqckNSalVtdFNRMXZPa3dyUS9DdVZpc01hMmxx?=
 =?utf-8?B?RWtyaUEzSTBnWEFoRXVEQm9DNTJNbmtOSDRtaWlaaERObEJiaDZUb3ZYL0hX?=
 =?utf-8?B?dnZzYllQYmxIdGIxbWdHZ2hqNnZ4SzJnb0x4VlozQlFuMjJsejdtZW1zSjlJ?=
 =?utf-8?B?VmdiTTlqbkg5b25zc0QvOG1SdkxwNG1Zd0hTU1p6WVVoemkrd1RBRkszbmgw?=
 =?utf-8?B?Q2NOc3lKTlJxWUVJVFNZd0xqWlBlUHByZEN5V1BoQjZGdUZHeGczRnIveFU4?=
 =?utf-8?B?M3IyUUQ1ZG1KNUk3N1FnREdiZ2x0L2pNaDZINXB0T2FmTWJodEFNV3h2Y1ly?=
 =?utf-8?B?WllRUzJFSTZpUlhxMmN2c1pWVGZFWHlXdW5WVDYxZ3JpVFZBR0dreHhXdU5t?=
 =?utf-8?B?MEQ3SzNVcUZUY1ZhZVhVSVJaaVJISFZsSTNsdSsvbXZ2Y1hpU3kzMW9sMUNZ?=
 =?utf-8?B?dUh6TEVDR2ltUTVoYklLOEtDMXhjYXZjbndlL3JqY04wQWtRVTA0eUNZQlhn?=
 =?utf-8?B?MnIwL1Jld0RleFJ1Ym1YRHduTGh3WjBCWkRubjRrY21qZ283QXkyR040bWk5?=
 =?utf-8?B?TUg5dTE4cjhNYTV0ZEpIUFVWWmxUdFlVbXVobUU0YkpJdmFjNXFDYmJhYlRo?=
 =?utf-8?B?bC9NZytGejR1NkxrSnRaUUlFNHA4TldzY0JvaW41MXN1bkdLZWp4Vlk2RTJW?=
 =?utf-8?B?ZHJrWldrcmNJaThQZmhSMTJ5SWoreHZ4UzlkZzNlVzBvdjNjaVgwL1NieVlm?=
 =?utf-8?B?K1NXcjlLU3k5V0w0RHZLMEwzWGVyZnpLZlpaTm0zZmR4ak5VeFN3TEdmdVJI?=
 =?utf-8?B?bCtjS1FhNlV5WDNvOHIzeEp1R2VWQmFQd09TU0JkRjVaaDM4VWRYSTBvUHE1?=
 =?utf-8?B?N0RGUFZKQnNGcGZ2dW94NlJ1bTI2aUoyUHRvOHpFVmJ5S1FKR1I5blZOemhu?=
 =?utf-8?B?anhMLy9sY0FpQllmazV4bHNwTkl1N2s2aDhlR3NsaWJqZXFpTFBNSEdMUjd1?=
 =?utf-8?B?b1VUOXNQQXg0VE9zcGxYY3gvNkxsUHRkUldGM3FGQVY4L0JUTnFiamxjVG43?=
 =?utf-8?B?M282TkFGQnN4N1Y1cmh4dVg1NURvV2ZSREN2WUNpeWxkUVRmQmdYYjlUaWMw?=
 =?utf-8?B?VmVnc2pZOEZIT25lODh6bU1RMUQ2ZkczSjFvYUg4K2EzVWw2dkZXSmFGNXdl?=
 =?utf-8?B?TTlNTUg2RFVnbWxpbVROdGdzbVI5YVNZdzlUeE13cUdmQXg1cjMwNk1BbDVI?=
 =?utf-8?B?OXVzaFptRXJmUXlleFZmQ2hyNGJBTGRCVFNUSHRmR2NtbC9PaXZmc083bllX?=
 =?utf-8?B?bmV1OXphMjE5dGhlOFN5ck1PMnZwNWE3Vi93VU5qOXdhTzlPa3NvQStsZ3Fp?=
 =?utf-8?B?cHpiNndKeksxMjFQSjRZZ2ErTWtwakc2QkVEbDBaYXczZWplVlRLbGpKR2Y0?=
 =?utf-8?B?WTZOcWJQcFM5emtITWg3b2M2TTF2cW85ZFUza1pCU0d6SVQycEMvUVpIK0wz?=
 =?utf-8?B?Sk1xSGxVd3FzZWZFN2ZrZEMwa2ozTVk1VGdmMkdiUzZUU0swSUFSRWxzanRF?=
 =?utf-8?B?dXR1QW5GMzVLU1FLaC81U3N5dk1XQ2Z2SEJXZlliOVh4R2p2MDhnSDRTUTlD?=
 =?utf-8?B?aEpwNzEwNjJJUW1lSy8zYjB5WVlheDBuemdiWDh4QUNId1QyVzN5cWVNNURv?=
 =?utf-8?B?VUJ0ZmZvSjVHaWlyazJNd2R1WG8vUWdqYmp0VUtDZTd1Mlc1TVQ1YlJvU1Zx?=
 =?utf-8?B?UlpvVk9lVGZxT1ZwQk5TdUtzSDVwQjVJeWpFeDZ6Z2NnWUZxbzBnenp3dEN4?=
 =?utf-8?B?OWFsZllSc25lUUxjVmtnY294bkZxUkpBanVpeHl3UHlpWkw5YzlTZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39a25d0-b3b9-42e8-f2cb-08df0e7bde9c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:08:48.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SMqsfjLh2OoIiLnjRPSNp8bnaQk2HzbK9y+/cEe7IcmLCA64rHcB+UOPkYBdgpq68IXlBoYladeqAjeXadLnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFF06F8354E



On 9/7/2026 1:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Flaky Test / errno Clobbering
> 
> Pre-existing issues:
> - [High] NULL Pointer Dereference in bpf_object__close() on allocation failure
> --
> 
> commit b3d2f975120fb1ef7382fad8983c653ebd2ae39c
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> selftests/bpf: add tests for selective module BTF loading
> 
> This commit adds selftests for selective kernel module BTF loading using
> bpf_object_open_opts. It verifies that valid allowlists succeed, module BTFs
> not listed are skipped, and invalid inputs are rejected.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
>> new file mode 100644
>> index 0000000000000..fb1b9ffb6c7aa
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
> 
> [ ... ]
> 
>> +static void test_invalid_input(const char **list, int count,
>> +			       const char *test_name)
>> +{
>> +	struct btf_module_allowlist *skel;
>> +	char assert_name[64];
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +		.btf_module_allowlist = list,
>> +		.btf_module_allowlist_cnt = count,
>> +	);
>> +
>> +	snprintf(assert_name, sizeof(assert_name), "%s: open_opts", test_name);
>> +	skel = btf_module_allowlist__open_opts(&opts);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does passing a negative count
> or encountering an allocation failure here lead to a crash inside libbpf?
> 
> When btf_module_allowlist__open_opts() calls into bpf_object_open(), if the
> count is huge (e.g., from passing -1 in the negative_count subtest) or calloc()
> fails with ENOMEM, the array remains NULL:
> 
> tools/lib/bpf/libbpf.c:bpf_object_open() {
>     ...
>         obj->btf_module_allowlist = calloc(obj->btf_module_allowlist_cnt,
>                                            sizeof(*obj->btf_module_allowlist));
>         if (!obj->btf_module_allowlist) {
>             err = -ENOMEM;
>             goto out; /* out calls bpf_object__close(obj) */
>         }
>     ...
> }
> 
> Then bpf_object__close() iterates over the unallocated array:
> 
> tools/lib/bpf/libbpf.c:bpf_object__close() {
>     ...
>     for (j = 0; j < obj->btf_module_allowlist_cnt; j++)
>         zfree(&obj->btf_module_allowlist[j]);
>     ...
> }
> 
> Since obj->btf_module_allowlist is NULL but obj->btf_module_allowlist_cnt is
> greater than 0 (or -1 cast to a large unsigned type), won't this blindly access
> memory and crash?
> 

The negative count is rejected by the validation check in patch 1/2:
if ((!mod_allow && mod_allow_cnt > 0) || mod_allow_cnt < 0). Therefore,
the negative count case you mentioned won't occur.

The calloc failure is the same issue as in patch 1/2. I'll fix it.

>> +	if (!ASSERT_NULL(skel, assert_name)) {
>> +		btf_module_allowlist__destroy(skel);
>> +		return;
>> +	}
>> +	snprintf(assert_name, sizeof(assert_name), "%s: open_opts err", test_name);
>> +	ASSERT_EQ(errno, EINVAL, assert_name);
> 
> [Severity: Medium]
> Can this cause test flakiness?
> 
> According to POSIX, standard library functions like snprintf() can clobber
> errno even on success.
> 
> Since snprintf() is called right before ASSERT_EQ(errno, EINVAL, assert_name),
> is it possible that errno gets modified here and causes the assertion to
> fail?
> 

Nice catch. There is indeed an errno clobbering issue here. I'll fix it.

Thanks,
Fuyu

>> +}
> 

