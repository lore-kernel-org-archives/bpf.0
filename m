Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012021.outbound.protection.outlook.com [52.101.126.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208D3630AD
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622753; cv=fail; b=Pk0xmzjMZ+vcdare+noTemej1Xpw8q0Df02pTG75T2eoX/m//hhg93tUUpHKzWI7idMJIUIxT92MiSbPvyLIAZ3BRY+yasSjFqUCIrjBe3BXoCTgFv2FPLKlwHyF4hyK2wD9CopC6OALkPnUkTHMk403x067JhK6KXpPfU4KbdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622753; c=relaxed/simple;
	bh=TlmKbpcsDJ6qXKkUCoRuM3TARuAya0xE/Bmj9PxeC3s=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+Rb8ULuxlSUHJIt1vFoeZlNo8c5z7Jm2DJ1zPi7OYqMx/GRm9lkqsjRw5ZiIHX4ryP9FPumrZC9G8mUbsSmFVuJq/T2LoYeHbFqf4BQKS+wet8jZBS7svmErlke2isP7JqzEcxdzAKOKn9OHTW74mC7f5uZ9Wb8nkoon9oosEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XULAMoq8; arc=fail smtp.client-ip=52.101.126.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XULAMoq8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY7fziOszedMW9cp9u5RTv2Y9SMwBh/EVA1uE8d4aK96yZdMTHJTDpkQ/Xs4fv8AZA0fkyfpIbL4xtBf7SGSn8wiJFO5qBWH1jWFGIffqi782frYg/VsLiPZ/9Cty1Yic64fCgBL9gqYfoaGkTJ/+ZnrBlc002m8eTcBncXVkHEc2+hPEZZihI754f02KEqNc6RYOInQ71lNbopgdP5vZ6NhhXiXVSeCI7vzzB8+uB00GXf3YcTF4nFAC0lk+ri7QfQVh4+6V5bMfSou1WmPeWX81zjK/yEAwyoZxjCOknJD7bilFnMpAiEOoyGVtrCRIhU/dahD+UgQ0VLKo//e/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/0Jr5NmNbMMKsRXZUfZCpi86VORNR9hNkbKx4ajeVQ=;
 b=KBnCvejnYXqEYIAH19hNLvkfJ+YgFbj0shF8+ccjLYA+WPW4RBaP86+365Khc1Wv8Ac7Z/fwv4atpFr+ZLo9I9Ft+/KTjW30mDHEdFYgzr/EW0+SCvIrtPEBEQKtIkET4wPU4ort6781IjKqxOGuN7SF7wIZyWou/cApOV8VcJ0WZsKqeBzef/IuY0jzIeD/TCVotB3PbKV+GCcpxc2QbFz5scTgqoiY1sUamRX0IRkQFHtoXbJYYb6Eg2IGLfwMwFsIIvAFi3sA8/4Cu3EDCGYbNC5x60wi8TcnZdyC8TGKBIQTntIGO4d2CWE26uW3IgzOkRp8KPs0CH2kbvVhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/0Jr5NmNbMMKsRXZUfZCpi86VORNR9hNkbKx4ajeVQ=;
 b=XULAMoq8IH1IbWOjhpuB4JFLlNXACsWwRmgeEyFnpdaRlWZJeFNghRGHs9R+W4TUr/MRgnohzJHcNORkzwxaO1wEa3WtPug680rwPkTtA/k5XADgCFclwOILTyEUETJX47P5Tg1OQgGIvnCtosQqhXafpTBxI7fM/QNhT1YaDZOW7pps1njmXcS3bg2Ko+cIvV7YSlYKEHpeuORpVyu1oo4+wUSbuBTeLuwjgrCaX47imRHzSPFaBtHuYHBAuNAgkHrM/4Cpq4PRRGmb3SWucTBwcCirSYfLETLFlED9tEcMKVuslEYuh3uSyBWK9WVR33z4evJ/Z3HxkOvIzBRgqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by JH0PR06MB6655.apcprd06.prod.outlook.com (2603:1096:990:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:05:48 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 12:05:48 +0000
Message-ID: <8a3b02fb-01cf-4893-89f8-234a2d30fb17@vivo.com>
Date: Thu, 13 Aug 2026 20:05:45 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org
References: <20260813032613.2755-3-zhaofuyu@vivo.com>
 <e4db83128d3bcfecbccffcc5da7a3634df4566e3b4af1d6c178d9f3468a99ef0@mail.kernel.org>
In-Reply-To: <e4db83128d3bcfecbccffcc5da7a3634df4566e3b4af1d6c178d9f3468a99ef0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|JH0PR06MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 03926481-d0bb-48a5-b315-08def9333668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	FPo3c2xzCA3gYGMkNf/N8fBwcBIRAwI5CJm4aZb+zt8gWJ6QfU7wL68YHSseHRq32ixgwV4HRN6QFxDiiLLzP++kaJSXxncWCylZI+wPTMfXtPOnkuJWebB3i42365fkyjphR8RSNA+l7d9dVXGRVkvtgbuEwWDP6EggqlKFSqfNqnapBsvHia4gdWEdm5sY4UwB2nQqp42rI9wuoqtBrFDpIC+7ScTCxzdXTs35fgkCLvFA88nZ9hol7c57JEdDE3/n7bQ31KCI5ynycK6+3q5atECI/c2tn2sKgo5t/jkNv3FiQ0SPe/+du8GvhGBPHSv39L1DO5m/BjB+2WyBRop0+xzwm9EONgG3Ns0AXdO9nRbari0bZwxWf7vJ769njH1iX1vZiixErFomXNAnxPP3Ld71043sMYK+AEqqiZ7eNtjJSX97Fr14Eyf1IE87BzxZdVmKM6YHIPiF/Yw/ExM6vAkUqDJsTwJOxf/lUHdoOLYV61OlPQ9DHZ2gd+6/8WTXX8LB7OjHCjNbCWhEM8gaZjVhSspbNRuC4lLfiUsJduqdPzNHFvRh8qvMjxHylymgrRv+W+12FwS7gUNSPpJM2joBxr+S5URV5UqGm+BaMlTKiuThzMW8oEzXVw0MLXtuaVaf4lyiiMf3aegjBzzdAj/gGCXlCnd94pDE0hw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1g0R2llSWQzbUhxUVJCZ0czRW9pOWhNQjFrMU1MUmtNZVVJWlBSdE9pb1dP?=
 =?utf-8?B?cmxRSmRPZXdod3BaZFhtVWp0dG95WjJuQXY1SE9CWkdoWElDZExkd000ZW1l?=
 =?utf-8?B?dUhBV1JqejJscS92RFdOUXhtQTdKQ2c4Z2hEbkRTWHpYL1VxRzMvMWFDK2Zl?=
 =?utf-8?B?ZHVieUFGR3B0aitId0RRS2xaZUI2bWpZOWN5bUpZaWVhWGZYMm9NTVhydDhE?=
 =?utf-8?B?MlRYVTlMb1ZxUTJFdkZta1l2R1crcUhUSFE5SzFTaFBjWGFYdFdNU2RNbXNK?=
 =?utf-8?B?SzdvMVE0WUtQWndSRUhQN0psQzd2dHRHSjExZ1JvQVlPR2sxdVZHU204OFlW?=
 =?utf-8?B?SmVJTEFIKys5TkJpczgwdUFiT2xReHNGRjRuWmRqV2ZpaHJVci8zNVZnK1Jw?=
 =?utf-8?B?YXR1ZG9pOUhCT29jRFBHMVpQQnV6VEd2eTlzeXBkYU9BMFdJRFVGVWNPRE1H?=
 =?utf-8?B?M1RvUy9lTGZCbVp1b25WTnpIbncvbGRlYmROdFBGazBCVWR4VEJjM3N6Si80?=
 =?utf-8?B?ODVBK1YzZFdxVWNNUHVVa2xWRXFHUHdjNDhyWXAvNjlyTzNhNnJ4NlZiSEJu?=
 =?utf-8?B?enBqRXpzMVNxdTRaZzdjclhtdDNOdE12Y0t5MmJOLzN2bVJ5VXUraUE2MkR4?=
 =?utf-8?B?aTdhRHh2WGIrQ1I3QUEzWWkweUx4cUp5NHB5aDVvZ1RGZ3FBN0RTQy9RdVg5?=
 =?utf-8?B?QnJFUXpTSUdoZVJJVEU3cXVqMzhMNEJsZVRpenFuSG1DeFBOR3IxYk1tS1pX?=
 =?utf-8?B?V205L2RxY3NxNERRL3o0UFZqb1c0SG9adXdmM2lHck9Ua3RuWjIvbXhTUUkw?=
 =?utf-8?B?SjZUMm5RRTZSam4zMXVkWFdueHJOWC8zWE4zQll2dnA2c0FzNGp4WGVUVlBJ?=
 =?utf-8?B?cXRoQzh4K3QrZjcvMktRbmtwc29IMWZna2svOEdjWGZBdGNBWEMxb0hoanFQ?=
 =?utf-8?B?a25UWHdWRk16QnVTTmc1ZzFuWGdwNFBwTTNTcDROakxhd0tlcVlFYlBvdHFT?=
 =?utf-8?B?dUZvOTZmN25PRnhwZFZ6cExLRSs4Q29nSEthWTZOU2loc0dlalplWGdCL24z?=
 =?utf-8?B?MVNRWmg4YlI4dEd6cTB0YWh2T2tqcXlhdzRsS3RERnlYaUxSYm52ZmNodEZn?=
 =?utf-8?B?M2RxRko1YTNGclY4RS9xMSticUVVUUkrTlUyb1A2UmZKN2Z2TFlDWEJBcEIz?=
 =?utf-8?B?SzZ3QzBWbjEzV05DK0F0Z1JnZCtDQk9YdzQydFpEeUcxRDFKWHNrR0lLb3BK?=
 =?utf-8?B?bHB3SER3amp3M1NBVjVibjE5ci9uQVFNUjhwcWIzZm1oOHNNaG9TUCttTlFq?=
 =?utf-8?B?Z2NseG5sNnFVR2dRN0xWdC9STWRwMkptVDRGZDR0alNNTkROVDZOdExaVktH?=
 =?utf-8?B?RUdVQVRsQnBPS0VIMmpiWExCWTBuRno4TjRKQ0gwaEcwY0RSNFVBUUlGRTVS?=
 =?utf-8?B?MCtFR0lmd1ZPSXFHdm1CNGhoTW1wb05FUlNSM1RpVmo0Z29nLzhyRXhOdHEv?=
 =?utf-8?B?ZlFzbWVJdWtTYjVKanI1S01NVFRGR2RVNnlqT3M1OHNIaXZJdVRabGUwaTBI?=
 =?utf-8?B?MHBXQjd5L2VVU1VmTmJQQnhvd3pPUzNvbFNlc2RhMWswOWZKL2E2RWRSZzZs?=
 =?utf-8?B?eUJwMHZvbkMwQ2U5MEU1MC9oU24wRFovYVgvdklUQkNOQ0dwdTFzQ2RqV0l6?=
 =?utf-8?B?UGpLeis5cTdOMjMrOTZaT1cwVmxKQjZVRlVjVjN0UEdpOEFvRWl4SXJRdElt?=
 =?utf-8?B?K2tZaEsvR0h4Sy9WbDR4Lzl1bHFWUGpZc3VYVmR1dmxiUkF3dW5jTHBDZFhi?=
 =?utf-8?B?Y0NJbU9iYUNseG9iNVR4U2pLZVVMMkJBZVk4eVpzeXlMOTlvRFRZaHpaQTRG?=
 =?utf-8?B?MW5VWEttSlgyYmhzTHZhWUFBNEREZDc4TVRuNFdKb1ZzMDRDQWs3eW40ZUxG?=
 =?utf-8?B?SjJBQ1NqMHM2c1hvNXJlbCsyYzR4bE9DNjUydEpUekNaNnp2VUo4QTJYTkpW?=
 =?utf-8?B?U1ZBcmd0dlk3NWNobUNWbHYwdVNRZ3JOSGVEYWFjM1hITHpuVnBMOElpSDRS?=
 =?utf-8?B?Si90MzhpczRsbUY5Q3htaGFlclpXV0tTT3luTGhGWm5ocHFCSTBIVE1ZRHJv?=
 =?utf-8?B?bTJsNUpkei9Gc2czZzdhdk9YWnc4T3B5T2ZyR0NNdkZJYjBqU1daUGpLWDI3?=
 =?utf-8?B?d3dYQTd5SGgrRGV3UnQrWTBIK3R1ZGEyNFQvZ3ZnVitKME53UXBoZkRUbnRU?=
 =?utf-8?B?bmVWV1labXkyUGl2N2VXUVFEWGlldlNyaExIbGdDdGZldnJoQXVQZ3YxV1dL?=
 =?utf-8?B?MWY5NnFUQXFHelQ2Tnkxb1kwOWhPcGFFWWwzaHNGbld3dm5uVTF6UT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03926481-d0bb-48a5-b315-08def9333668
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:05:48.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WV7W1YLdsaEAHK8SZT2FkLrIUGcpW2w/LhEOB8qxNHCaFthilcjoo8xE1Y8tu2tWLHsbuUIEMuvgFZ0SK3krgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6655



On 8/13/2026 12:22 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> new file mode 100644
>> index 0000000000000..d875fcce6681d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> @@ -0,0 +1,52 @@
> 
> [ ... ]
> 
>> +static void kmod_btfs_nonexist(void)
>> +{
>> +	struct kmod_btfs_nonexist *kmod_btfs_nonexist_skel;
>> +
>> +	kmod_btfs_nonexist_skel = kmod_btfs_nonexist__open_and_load();
>> +	ASSERT_NULL(kmod_btfs_nonexist_skel, "kmod_btfs_nonexist__open_and_load");
>> +}
> 
> On the path where this assertion unexpectedly fails (i.e. the skeleton
> loads when it should not), does the bpf_object leak?  There is no
> 'kmod_btfs_nonexist__destroy()' call before the function returns.
> 
> The other two subtests (kmod_btfs_pass and kmod_btfs_mix) call
> '__destroy()'.  Test_progs runs hundreds of subtests in one process,
> so leaked fds stay open for the rest of the run.  The usual pattern is:
> 
> 	if (!ASSERT_NULL(skel, "kmod_btfs_nonexist__open_and_load"))
> 		kmod_btfs_nonexist__destroy(skel);
> 
> Also, the ASSERT_NULL check accepts any load failure at all.  Without
> privileges, load_module_btfs() returns 0 early ('skipping module BTFs
> loading, missing privileges'), so '__open_and_load()' returns NULL and
> this subtest passes without exercising '.kmod_btfs' handling.  The same
> is true if vmlinux BTF is unavailable, ftrace cannot hook the target,
> or there is a typo in the SEC() name.
> 
> The positive baseline that rules those out lives in kmod_btfs_pass, but
> test_progs subtests are individually selectable:
> 
> 	./test_progs -t kmod_btfs/kmod_btfs_nonexist
> 
> so running this subtest alone gives green with no baseline.  Would it
> be clearer to check the error more precisely (find_kernel_btf_id()
> returns -ESRCH here), or load a known-good variant inside the same
> subtest?
> 

Thanks, good points. I'll fix the leak and make the test distinguish
the expected failure from unrelated load failures.

> [ ... ]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c b/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
>> new file mode 100644
>> index 0000000000000..f445cf56ab161
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
>> @@ -0,0 +1,15 @@
> 
> [ ... ]
> 
>> +/* mix of duplicated and unneeded modules */
>> +DEFINE_KMOD_BTFS(_needed_kmods) = { "bpf_testmod", "bpf_testmod", "bpf_test_no_cfi" };
> 
> Is 'bpf_test_no_cfi' loaded when this subtest runs?  Looking at
> test_progs.c, load_bpf_testmod() at lines 2083-2092 loads only
> bpf_testmod.ko.  The bpf_test_no_cfi.ko module is inserted and
> immediately removed by prog_tests/test_struct_ops_no_cfi.c via
> open()/finit_module()/delete_module().
> 
> That means the third entry has no module BTF in the system and exercises
> the same path as the 'module_nonexist' entry in kmod_btfs_nonexist.c:
> the name is simply never matched in load_module_btfs().
> 
> That leaves the interesting case untested: a module whose BTF is present
> but which the program does not need, which would prove libbpf actually
> skips it as the commit message advertises ('providing a mix of repeated
> and extra module names').  Would naming a module that is guaranteed
> loaded exercise that path?
> 

Thanks for pointing this out. I'll use a guaranteed loaded module to
test the unneeded module BTF case.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31664172915

