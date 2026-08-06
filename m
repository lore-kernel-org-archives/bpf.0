Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013042.outbound.protection.outlook.com [40.107.44.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE68413D9C
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005589; cv=fail; b=qDmci1M82+1lQZgrdLuK/TuP0IDGKopt+ryoWOk0nkAbfPbUGzurLkzuW0dagXjAMnnbcrhvM+Z6hLkUKktBWotQVgWAdJKb7KRmQlKlsmDzMcxF96fI4E9/WMZ/pVkxzb9BemGddH6aQ8t/4+qsl9twfdZiZDF5tmAi0iOSAAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005589; c=relaxed/simple;
	bh=AWIa3JAxGBWP6I1Q16Ue34HJAyjiqT6q5aLUOjNJBKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kD+AIacThtk7wLXn1zIz2RqgTxfTxBrwNBdgtkOhvvn2SFOgccUvN1j8EutjK2I6AsYVyZiTw4V46RIWAQn94PtfMpBcgondSzl9PWoCwrKBvE0Dmt4CGA1RMNWww3S41PL+eflGJXJM3raSQa8Qd/Dvb+mFkwKWL5oVPm5fkrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hxZi3L4W; arc=fail smtp.client-ip=40.107.44.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hxZi3L4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmgD8y5pqxTyDEachBQPNWDNZB/NvhGnrK4BKLSROJHnUq2zxJwA06NFSF8F7D8IyfNAtTRK3jqXLu33ObtMckRVD0O4hrG7w7RrKUyEe9BqNSdRUAno1aAW6TYqPYGGvd3shyLFH34Wd7m8jm7p93Gwu2ed2+AFjO/HYTi/xwq0522LHK9f+k8hFPhc6whddsFhkVZG0zfJEeL5wfBQW0c7tQ6fEBGPYNGSKStu9om55Fs9lI5w7V3xFcAqbnwFuu++71LoMI1mCm8AeU97EdALCeB50j3KgzpaTDMWrDg24uzMHQ11PeHfwYT0nG1EPGTzIj5DhSE5yXFDag6ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7G0/a3Lt3djwhQnX43NsxMFBYMXg2b7jHHYAeb0MOo=;
 b=wN2l322baGyDdFUAMj5cgZTNHqU0M1Md1MtfuWppsL1T30draLTYJBoOyFTdTrYpzRpABlLEwxQAVY0Ai1PuimfRAXsLCHrcmMaTCOJHKfa+WTOyoalIjDmvYXJ9sBU33XvHYLP3zAIJ7RK8SbvlaZASBeM9jm69ni2jMph0LTjuq4i7df0HqGdi30jDJBELUXfubt82GohVJk5ka4HJUL3KAAIiYJ52eZAalMjuy/Q5IeBBPrq0xOcZAWp8JgRJSaNYuttFjwvcJzGY43UFMZVVZO8NdWufZECiDrtO7gylYLcNY1bY8T6Eu7Qq+1AbCWIbH8FvvfaY86zaec4aDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7G0/a3Lt3djwhQnX43NsxMFBYMXg2b7jHHYAeb0MOo=;
 b=hxZi3L4W3XijO0qw0/dbfXENQEVrMjYk0jYy/MUExHAxuMZNLUkCa7tfYjxyb5L2jLueN0E/9HkmxQ3ctTR4/JSsaF4IKpV+foCL/oVgi1Plh1Ev0mHKaBM6Ju75NA/lUbYC8Cq5djeGe1Pd125kdJP9FLEKEQxiZ+b83Iw9HgyWzmg/9q5UKdNDuZthbu21e6/KmtX/ooOOdVjhStk0jY2zKiUMJYpzNgErnUcStWHoO/32lGob+jTGy23Z30d7WVeLhE4RNcQLZnzhwqFIYfU/VETgzXdesJcOymq/HhBkOtVUW3rwrG2FimEtkP5w2mB+4GJDQtvkY9jP4qoQ1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by PUZPR06MB5497.apcprd06.prod.outlook.com (2603:1096:301:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 08:39:35 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 08:39:35 +0000
Message-ID: <3f3284ef-5f9b-43ca-83df-a4097f8d976d@vivo.com>
Date: Thu, 6 Aug 2026 16:39:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/bpf: add tests for selective
 kmod BTF loading
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
 <20260806042042.3239428-3-zhaofuyu@vivo.com>
 <20260806042938.3B3A81F000E9@smtp.kernel.org>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <20260806042938.3B3A81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|PUZPR06MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 763e811c-4709-41ee-81e4-08def3963e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|5023799004|56012099006|4143699003|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	UiQ46vj4P9nvalaGE0GiAX6sJoWiXw4u9YdGc1QlTWQwUiN/n2MnjI/0H1rVG52AxW/ioN3/qQTPz6ePq2FPmmlijL3Ck+SXJdnDpMGpSkB6mqvN2O7z9n97G+x5BwaFOwr5NIt3Z5ZxHfD2hFx9GRhFSCAWEZ9hJjh1DcOJAZnk3eVQBwuWRdLtU2qJy558gCUCzkHlj7idAw78+gkhbUYRR/OCu6KZaN68wsJRbB/6xDaRYJFXeFPihkVbSsKnO7IY/8vTLnJ1mDyAbaCYLnlWn8MUFYwZzTAShcoU/x7c6s4TQk5YPmU+4Z1XKjl8NYR848gyRBv9Hum6icYRFDjzr09hu7qATXAbX2Q3YlfAYc6j3yeANcLECMMaU3TDA/XZ7GkTvUL1r+aWURVFYnbUe4xQ9Unh+xALoChhPfCjsKdlPHWY1jejU9YL0jYUw2DLWacBQKwgt6QRxh3i91eMER9yn1GgkvpZgWbVNTFfAUTwi1RYdroFAw7U63rHnB24iYt81sDLAaesd3IYlTNQFjLGJCV12VwIcMVTY83Q5KGBcG4oEmeGSN0f+5u8jxrEzIJ4cA0bdyLGFzXn8zLlGFGWVEowQf11KiFe48wBXPIYtDyxaDQpPrLTkJkGUUvv1Lml1XzGwY0W/3ONjHh7Zrcedg6mb5pETLfn/BA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(5023799004)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1owcEFBMTRjTFpMTkhNb2ZvVjNiU2U1ZXYxNGxvVUowTmRHdFFIdWJhTmVD?=
 =?utf-8?B?N1Y2dENPcVlZbHRaUko1ZTZEZm9ONi94VHBmQWViSm4rcEdRNHdCZXBYRm9X?=
 =?utf-8?B?UGJ3R2hHREVadEVpV0VpakRTcjhVS0wyZk05RjF4Zms0SFR6V0lPVXFUN0Vj?=
 =?utf-8?B?TmU3U2R1aXJpQzk5RXkva2JmV3VXRGtlOXJERkVJeFhJcFVwUXdFMFNoczNv?=
 =?utf-8?B?eUEwOTlSOWVHb2ZiQ1dGYWlvMktjdkoyYXRveGhaa0M5d2ttNGl5aGljenZL?=
 =?utf-8?B?NktDQS9mcDBaM1l6RkQveXlnQnoxZTRMaWViRU1Nek1wYXd5d0pxZkpPaXBM?=
 =?utf-8?B?MEczNWFURWhUYTh2Mk5sMzJEZWtKM2tpQnpFVTlIZUtrb2F2amM4SlROK04r?=
 =?utf-8?B?cjhGbHR2T1ErVDczTFlhb084V1FCbkJIMlkwa3NjV0htL25vYzRTbmd3eHdX?=
 =?utf-8?B?MjB1cXc5UXVwUUtTSXIyOStEVGdQWTZ3QUFPdkV4Y0huWjdveFRzUE1UMGdm?=
 =?utf-8?B?SFg1SnZQcytsNGFQTFJXOVR6YW5DM1Byd2xaMDJ2NVh6cHF3UUltN0N5TzdH?=
 =?utf-8?B?Q2RHeEVxdnBhMzNObm9YbmU0MC9ab1dhb282YXJUanRmV0FaV2k4OEhNTDBz?=
 =?utf-8?B?VzRZZGpGeWF3Zms2VGdaTXpZMEJjRmVFU3d0S2RlUDg5am1OOVQ2a3d6Lys3?=
 =?utf-8?B?VUtpRjU2Q0RMQUdsRWl0aXZIMHJzWjUvUk1jNFZ3VzJRbEMrSElxTDRvM0Jj?=
 =?utf-8?B?VHBPNnRSb0lxL2R2NndHNGlvYUJBMTlLdmtMWGpERDdiR3pwSy85U3VvSmd1?=
 =?utf-8?B?MzE2aHF1SmRRc3JjVkc1dmEreFJuclZjeGhHcnRKL1hBTkhqWmRjdkZPMjQ2?=
 =?utf-8?B?TmJXOUdUUlA2cDQraUd5V0gvbngyMnpNL2hEdjhyYkd2d1lZc1o3RXFSRUs3?=
 =?utf-8?B?clRqRGs3ZktiOXdTTVlUNStBamJUazhHdlhQSHY3TVZ2T0Q2elpnbGhiandi?=
 =?utf-8?B?Q1R6YXE0Z2VQQVR1eXNVbEJZd3MzOGxZbFE2bUQwMXJkT0UzMU1JVUpYc3Ju?=
 =?utf-8?B?MkJsdGc3dUJzOXh6SkRjVjlBeExjK3RLWnBkbnR3YkF3cllRRThFeTlhZGhE?=
 =?utf-8?B?bG5pMEpHdWZST3Z4dzk5QlZSNUtubTZQYmc4NnNUcHoxc01uYjlxSmdQNXp4?=
 =?utf-8?B?SXZSVDNkbEdUSzBEMEFCRktnaVc0RGY1Q2Jpb0ptTmNNVmJkbkRwcW1keXlY?=
 =?utf-8?B?clUzQ2pXTDUzcDhuaFQxeW9aeW9oYnM1Ry9xc2tBUGpBeHY5d3U1WHZvN2hM?=
 =?utf-8?B?SU5PL3Q2bGRRV3cxSGRCaGkxQjNQb0tuMjJEbzc3dmdTZ0RycmdoSVpneW1T?=
 =?utf-8?B?bUJ2N3VUbmxuaFIvRjRBQ1c2dUhCWjNESjltdDY3Q29wcG5hSTUvLzVVOFM3?=
 =?utf-8?B?eVJ4L0xYbGNqTlhFZTllOXZkZjRUSVVxRXJVSlRKRk5ienZpcENmZ0ZaYURW?=
 =?utf-8?B?ckExeVRoeW5Yc1h6Y1NJN0pzM1BvL2pNYkRIT3VWYmoyODZEY1dtQi9FbVpV?=
 =?utf-8?B?cm1RbElGbGlFdU80dzl3THRlSytJMDV3d0VnbXJtM2YyVSswUFgwUmc4SEtF?=
 =?utf-8?B?SXUrMW80R0gyeVdvRkxuaEpCY3Z4dndlbjZCb3B2WThSbUNSeU9wcGI5c1BP?=
 =?utf-8?B?VnlkakpKNXlkaUxycUovYlZnclZBMVlKS2N0S2VtZXppZ2lXcUhVLzZJSmRq?=
 =?utf-8?B?azN1Tm1ka0tYbWs0TTh5eGI5SGhMUTdyMzdoYW5uRVZpcDNQOW1WeEN4S2M0?=
 =?utf-8?B?cGdkRmdXdXhscVhoSHh6dWxoMkVpOFFRdyt3TnBLb3FwSWdBQUtkdkl2amdU?=
 =?utf-8?B?WmVxVmRjbW9CbS9sU3FOSUMyVGVMRlljdUZ2TVAvbVlIZ1BSN0ljZDhCNjJv?=
 =?utf-8?B?Y2twdzR1NDBDOHRkR0tSbGt3WUZjcDAvZFVOZVh4YzVmY3BQRmFkenpBZ0NO?=
 =?utf-8?B?WWZiMnFFRE50QXc5cEZBRWZyVUNrdVFyeGVXVjlkRmR5WEpFQmc5M3ZNQ01E?=
 =?utf-8?B?bTFUYWprVDdleUtIS0JpOVJJUENTK0Rpc3JLOU9ISndmaUYzazRzVytvQU5t?=
 =?utf-8?B?YmNwRFFTdThtMGVNMlVWSFpzTzdtZzU3anVISWtrTnBMSmFQWUU5ZGlyUXB3?=
 =?utf-8?B?azAwaTByZUlDSmRmWG9IWmU4a3RuSnlBc0tkeGtScmFEMTQxMFRYcW1JQ2I3?=
 =?utf-8?B?ZC8xOXlMREVIQmZLYTkvSzRJZHRCVUVUM1lGNXpudGR5b2FmUStQNy9hSVZ1?=
 =?utf-8?B?MkNMT3c3cVl1RlNMR2pad2JGLzB6dW5ZMUxBdlpHU2VOOE45UTZtZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763e811c-4709-41ee-81e4-08def3963e67
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:39:35.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6OOCimcQAK7nO/7hmeOBpDATfNbWYm0PCD7gt5ITTCj9369djQhNpgJl7twiuV+KsxrQOLm/xw4ac0pgRPtGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5497



On 8/6/2026 12:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The test `test_kmod_btfs` depends on the `bpf_testmod` kernel module being available, but does not check `env.has_testmod` before running.
> - [Low] Multi-line comment does not follow BPF subsystem style guidelines.
> --
> 
> --- Patch [2]: [RFC PATCH bpf-next 2/2] selftests/bpf: add tests for selective kmod BTF loading ---
> commit 35262af12350c47550b117d06e881e0de422cb5d
> Author: Fuyu Zhao <zhaofuyu@vivo.com>
> 
> selftests/bpf: add tests for selective kmod BTF loading
> 
> This commit adds test cases to verify the new .kmod_btfs section logic in
> libbpf. It covers scenarios with valid, non-existent, and duplicated module
> BTF targets to ensure robust loading and parsing.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> [ ... ]
>> +static void kmod_btfs_mix(void)
>> +{
>> +	struct kmod_btfs_mix *kmod_btfs_mix_skel;
>> +
>> +	kmod_btfs_mix_skel = kmod_btfs_mix__open_and_load();
>> +	if (!ASSERT_OK_PTR(kmod_btfs_mix_skel, "kmod_btfs_mix__open_and_load"))
>> +		return;
>> +
>> +	kmod_btfs_mix__destroy(kmod_btfs_mix_skel);
>> +}
>> +
>> +void test_kmod_btfs(void)
>> +{
>> +	if (test__start_subtest("kmod_btfs_pass"))
> 
> [Severity: Medium]
> Since this test depends on bpf_testmod being available, should we check
> env.has_testmod at the start of the test and skip it if not found?
> 
> Without it, running the selftests on a system where the test module is not
> built or fails to load might cause erroneous test failures instead of being
> gracefully skipped.
> 

Good point. I will add an `if (!env.has_testmod)` check in v2 to gracefully
skip the test when `bpf_testmod` is unavailable.

Thanks for the feedback.

>> +		kmod_btfs_pass();
>> +
>> +	if (test__start_subtest("kmod_btfs_nonexist"))
>> +		kmod_btfs_nonexist();
>> +
>> +	if (test__start_subtest("kmod_btfs_mix"))
>> +		kmod_btfs_mix();
>> +}
> 
>> diff --git a/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c b/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
> [ ... ]
>> +SEC("fexit/bpf_testmod_loop_test")
>> +int test_kmod_btfs_nonexist(void *ctx)
>> +{
>> +	return 0;
>> +}
>> +
>> +/* This should fail to load, because .kmod_btfs does not contain
>> + * the needed module 'bpf_testmod'.
>> + */
> 
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the BPF
> subsystem style guidelines?
> 
> The BPF guidelines usually require the opening /* to be on its own line.
> 

Thanks for the feedback. I will update the comment style in v2.

>> +DEFINE_KMOD_BTFS(_needed_kmods) = { "module_nonexist" };
>> +
>> +char _license[] SEC("license") = "GPL";
> 

