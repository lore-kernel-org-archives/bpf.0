Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013006.outbound.protection.outlook.com [40.107.44.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568613D967A
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963211; cv=fail; b=Qhh/oY/iO2W6GicFP66gOtOlwPP2yzG6qQ/Qqj9tfeWvWl0JNtvFZs9NeIaX5zEq8hdJg69AQ0CwV0S/h8TL8KHcZKNkh+Q2uHB+O4FuPUfFfM04Oftyl0Jmx65+PD6kp6yIO6gSOrjQ0l86CsxavOjHHq0PlaBzLrDEKhwcG9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963211; c=relaxed/simple;
	bh=1kvgMIqL7vUeaSv5+qfG5O/U6kUJmzTNBCfGo/wTdvw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fqjorerMMWAkEnT4V3xUPfqaHAprgNGbT1i5aMOxNrvpHym58wwcnLyico8mZb32reYVmN/tIrUVkVzw8X5t8kQ0j6VVHN1rVJ0LINKpONIJxd1YwIugqBfdv96/XkLoYAX9+/ZrH78j+2dWqKAvl0kGmmYSr+2n4uh+5EulfNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CIj8QCHE; arc=fail smtp.client-ip=40.107.44.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CIj8QCHE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPh/CkqOgF/CEMzQIldvmgp9rrJYXn/FKipXAtKfShsmv14xCJ07nOdcqdvNzEMpFNTP8uOsesGtIqF8l9kxe04M30isXcqHPtUlWl9JpN6LvhM/zZvemV7DdH3IdOZXcbCOf25meCDVLC6Bxdn8sq9RIZxZQRNCghemJCrgFBSUogzU8mRYj3z0T3fbmLcI9vJLGpVZl3V/0W90xDUvvq3jCkmkPeI7u76xEcNerUQeTj6hv4iLbPGQkGzBsWSNKmvwjBKj6THhM4wo9hUQtI2zSIQAFcw/2cAW/kMqt/f4Ko8i/5Bj5U/o5hm5fkfde7phDwrEBi9OVkBUuhYeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtpofXTJbgqk7MGBW4Y0ikFOYHQX74c8nmRb8Bozq04=;
 b=uDyTKEhtyAjFm6DiIDd7WKL04eNMaTwWMsz7yBe2jC/t9ABpwKSd3bYsqn0vbYQDCnkKO2O6Jq4VdoM3XRqLtVqRkHhVuY0vc7feN79XZYznzH6CILrLmNM3vVuTiErlEhhNeVp9GHZ+1tZbEUcVvnBpavUjchRa681CrkFM8x98HPDZmRPerN8WJv6QUAH84fE2t9DR9UMkl9AtNDMmUSbPB6PgNlzWfQK0Dg2yS8R5C0/w/NjUo9imFLq7qKaJpmnf/39y1nmiLftDhON+QXVo31mIqhip9AW5SkW5t4csNFm7eq3d97AZsyvharVCasZLwGX3Nq0s2hFA/IDKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtpofXTJbgqk7MGBW4Y0ikFOYHQX74c8nmRb8Bozq04=;
 b=CIj8QCHElXapkHABo6VuNODVushuJ9gFpQGImObAREOVR6r7PbronPcNrwROZlSBC6u7U0Doy4XNi3/ITwCeZU+CK/PLbFCyb8F0djTjWQFdAaNacJ4bsP98803NK7Fm6bo9ZwBN9taha8J65EMwSEPMgXXu0m6m5Y2enWYs9yfiHfHRUgN+9fcnRXnwoGI8jKiw07QHqiyD2Xq029RfKlrn7eWnxkMHXmyPFwGV4S93a39kY/8y5T1d7r4qp0JATOyXjd44x2zPPlgy+BQ+PY0jcXPN21aLsRqsy2UENFv+r8SihfRUlMjmee0j366rOYnUUUvgHZpyqVg0hJznEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB7312.apcprd06.prod.outlook.com (2603:1096:101:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 9 Sep 2026
 14:13:27 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 14:13:27 +0000
Message-ID: <6c7a594a-12a7-4871-930d-253f6afccceb@vivo.com>
Date: Wed, 9 Sep 2026 22:13:24 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com,
 alan.maguire@oracle.com
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
 <20260907053847.1115-3-zhaofuyu@vivo.com> <ap53Ac6p_DVybHi0@krava>
In-Reply-To: <ap53Ac6p_DVybHi0@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 349cfba7-48cd-4125-911c-08df0e7c849c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hKrWC6BvjlpskIBl6KgZNaXJCqR696qxMYnneqQMvkzRMKw47Soy4C3+keiuiQNrAQhum5oO90AboDfCvQYnwvX+cgOvC2RLQORVY9EbCR1t+df/KVxHOUkClZCmVJj46LOK88YunOxUcclQtpXkkcMLqt1rLEZHKHCl0epUj6oc6G4tHQIUKmqDw3a7+2wFgJMPDc9pMWstElfIOs/7jkcFs8znG/W1R8Hhl4zQh4EiTlDlqd+AKMrO/JYfTCecCso0Hl9I/zsGz4yCqpVNdjq5qlHgCrp4l8lbXV47i4bz5yCkahY5oRZMwDMHZ/YaNTtM7VZrZ+zlHNOXzyBMBCv+sPoQWIIu31NWy6AyHfoKKTB1g5GIiRRCCAaKhn2gYgoWpb1MX77cs6Be6sUz8IttN1QWQAi+lz8WqBjnF9RWRvrUKDLY4UvBDSaOJvaWVaX2FKQarzAiPlhZDiNoRu+ZcUH0CcFzVlJJVkB/eQAqcovsvIuIFQh8X+bpfnRr7/Ay12jIpJFpZlMH2OyIj/f2nicJkzxFgs8sG5NOw5W4VRpX8FDKXXxEjPsvt5moELSSbXwVH1/1S/qvftkWPGcYiuUfn4Ldi7CjbbQmaILE4aam9bX01uLAySOJEM56RlyIcrVy44yKKqsxFJuWBMbIwE05quWuST5KKqZB1Ag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlY5UXpDNWovU2x0QWs5SURONmNWUU9OLzd2QktDUTdSZmtaSzlyUDVma0dh?=
 =?utf-8?B?VzdodHdRRU84NGtxTTRpeDIzQTloWUlsV2Z1MEZLV0M0SHBYSFkvdjBLZDlH?=
 =?utf-8?B?R1pPQlNQcTF1SlZ1VmVJME82M0FPVE5hVG9PODVJT2gwaUhXdStIR1QvWFBE?=
 =?utf-8?B?TFJ5bk14aHhUb3lmSk0veXZyQ01lb3pJbm1HS3c1TXMrY1F2VUYrSXZ1M0dK?=
 =?utf-8?B?Ny9JSlIxVWZUcTAyVlExNEVEaStUTjNiWWNnWHZqQTc3SE5UYnd2ckhiSzFu?=
 =?utf-8?B?WmpTUlV0d2tmTnloOTN1Q1NnVFRyY2FQWU9oODlrZFFKQW96eG9ka3c3YWpv?=
 =?utf-8?B?UmFFekxFM1cwaWgrZjBtUnFham5kVE9FNHk4WjZFUkhOMlBGd1F4NktlSlA4?=
 =?utf-8?B?SVlMVVRlcTBzNVF4ZVozb2RWT2hERUU4TUFubGdQRmR5ZDFFWEJlZXBPSjAz?=
 =?utf-8?B?ak5XcFhwaE9hNDNCZ3QxaHVOVmJudXV0M0Q2dnFJQmFhSHE5ZGY3Y0FUR2pR?=
 =?utf-8?B?M2VQK0wySGxQKzJoRFAxY2hmRXlyQnl1MEhzTFhic3NDemRoQWRkNWRrc3Z4?=
 =?utf-8?B?Y2cxZnJBN1pZalVjdTh6b2dMRkg4bzhJaktUSUhrUkg1TkdhUjkvMjVEd0Yw?=
 =?utf-8?B?WTE5Y2Zqc1hPcytWL09PV1BReXZCeEVhbGpoaHF1d3JsZXQrSEFaWmdJVWh0?=
 =?utf-8?B?SnFNT2tQcVJDUjBuUDdjZit6RGxBNzFlRFpzc3d5TXc2ckNIQWNvU1RMdjcw?=
 =?utf-8?B?VU5KMU0wWmxYMlJZS2ZuUVExMmsvMTc2OW9vMkJrOXVaL2tvMG9TTjdndWIv?=
 =?utf-8?B?Mkc4OUNxZzAwR1RIb1RCME5DOGRqVmg3c3lrL3NHYTUrUi9xOVFQTWlOc3J1?=
 =?utf-8?B?ZVZPa1lpR1FOK3RkcXI2a2tQaS9aanJHa0IrZi92OU1rSWtUZFNVKzVWMHdZ?=
 =?utf-8?B?MkpPQ1I4bll3bEF3Ynp0NkRSb1hjaWxnMTBMdldPRU1ORWJyejRKVmNJRU52?=
 =?utf-8?B?bHZIeEF4WVBzS2pCVkFma1VnVWc0V0pweEpCSEZ3UUNMTnVtNnIvbDA5VVdF?=
 =?utf-8?B?QUNqQUJMNlc1S3cweVBab3ZMdklTK052d1haTkFVL0czWlAyM3pJaExiaHkv?=
 =?utf-8?B?UGwzZE4wZHRLWnJIWThaU0JCN01ZZ2ViSVd1dHA2N0JUUU95bVpldGpSeFNp?=
 =?utf-8?B?RHFEVnIvNW5sRlV4WDdyNVBTMytNVXp4c28za0g3VThvWlE4WXI1UkRLUXRi?=
 =?utf-8?B?aE1zNGllNm5aTlBtazVieWdUYTZOcjF0b3d6cjgvRGx2c0RJZTM5d1pjSzRD?=
 =?utf-8?B?bHRiaEZNcFpSNEtieVExb2RTYW9kVmxFN3A0Q1M4RHRFcGYwUm5DeSs1WEsy?=
 =?utf-8?B?V25CR0FRZFc1N0dUZmVtWmtUU25KMVJLc2Y2V2RSZDdZVGpVbld5U21XTzNj?=
 =?utf-8?B?dzJwTytDM3E5bUdxdU9aREdtV3QzMVJhbVJlNWJyZVUxTm9hQllmY2dsMWZh?=
 =?utf-8?B?aUxnU1p2dDNUeVhSVnNLNFptN0JTdGN4Tm9OTmNVejA4TkZVK1huMzVZUVl2?=
 =?utf-8?B?R244YjJUTnJIbGc5T2pIOThaa2RMZGhQSW9lbnhBRFdKTXU2YUllOWdNNS8z?=
 =?utf-8?B?dTd0RlBaZ2JZWDBpQzJ1ckt5S1daanF6bTQxRHhqMDRoajRGVjA5MUlxeWQv?=
 =?utf-8?B?c3lMRDV4QWJMS1Y1ck9HVEtqWmhMSjczU0JuOTdtTnlrdDZFYlQvUG0xNFVR?=
 =?utf-8?B?eTVuZmVwOG4xRXV2V1hVZjRvYmt2YTJQclZraUV2NjBwZUx3SksveUcyTVJa?=
 =?utf-8?B?RlZSSTJoN25vMW5JY0phdUMxZ2F3OFBvRWZFNzdvQUhMUHNwY0RubUQ0dFMw?=
 =?utf-8?B?MXlCRCtNMlpONU1vMUEwSUlCWVB0N3hlVnNVT0wzUWFEMUs4R2xXa1FjZ3Rj?=
 =?utf-8?B?aTJITUZROW5PRXVyVXFjSGduUjYzUWxaWmlMUTZQdmtDNklsSnk1Z2dNWG04?=
 =?utf-8?B?ZGJUN1VPaThPU292dUVxckNWWk5oWHY2OFhNbG9SNkZVRW9rNGlWOVc1WUZT?=
 =?utf-8?B?T0dPUk5PaVNpSENCYzZPNktYZUhZc1V1YUlUTnhnREZHWmVTT2tjMzduRUFW?=
 =?utf-8?B?UFhBbmxUay9aM2xmako3TFNZRHpMcnBMaDhvWDllbVpDVUlmMUhmK0hudFBN?=
 =?utf-8?B?ZkNYWHRZT0xtNm1xWGorWEd3RVBmZzN5YUtWM3kyQW9lWldrN2FURjZzQmQ3?=
 =?utf-8?B?YU1LaEtNYXdyOTQ3Z2grdEtnRSt2YjQ4eDJBdTRGMXJmYnNWRm96aDFiQWtZ?=
 =?utf-8?B?UU1oRkxGQjFia0xEVTFJMGdacFVmZmdHcnFWb1EwdkhKY3FIb1RYZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349cfba7-48cd-4125-911c-08df0e7c849c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:13:27.6223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6YmvLiJ8qC8fyr6aU3CVXjfMKl4+ZcJolPj9BZf6Re+cq9SH+kEv9yiBuMQXbX3FZLTLzBwlAfn4Qf9c6KShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7312



On 9/7/2026 4:34 PM, Jiri Olsa wrote:
> On Mon, Sep 07, 2026 at 01:38:47PM +0800, Fuyu Zhao wrote:
> 
> SNIP
> 
>> +static void btf_module_allowlist_default(void)
>> +{
>> +	struct btf_module_allowlist *skel;
>> +	int ret;
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts);
>> +
>> +	skel = btf_module_allowlist__open();
>> +	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open"))
>> +		return;
>> +
>> +	ret = btf_module_allowlist__load(skel);
>> +	ASSERT_OK(ret, "btf_module_allowlist__load");
>> +
>> +	btf_module_allowlist__destroy(skel);
>> +	skel = NULL;
>> +
>> +	skel = btf_module_allowlist__open_opts(&opts);
>> +	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open_opts"))
>> +		return;
>> +
>> +	ret = btf_module_allowlist__load(skel);
>> +	ASSERT_OK(ret, "btf_module_allowlist__load opts");
>> +
>> +	btf_module_allowlist__destroy(skel);
> 
> ^^^ seems redundant, I don't think we need to test that
> 

Agreed, the second case is redundant. I originally included it to
explicitly cover the default values of the new fields when opts is
provided without setting them. I'll take another look at simplifying
this test.

> SNIP
> 
>> +void test_btf_module_allowlist(void)
>> +{
>> +	struct btf *vmlinux_btf = NULL;
>> +	struct btf *module_btf = NULL;
>> +
>> +	if (!env.has_testmod) {
>> +		printf("%s:SKIP: bpf_testmod is not available\n", __func__);
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	vmlinux_btf = btf__load_vmlinux_btf();
>> +	if (libbpf_get_error(vmlinux_btf)) {
>> +		printf("%s:SKIP: vmlinux_btf is not available\n", __func__);
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	/* Ensure bpf_testmod BTF is available. */
>> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
>> +	if (libbpf_get_error(module_btf)) {
>> +		printf("%s:SKIP: bpf_testmod's BTF is not available\n", __func__);
>> +		btf__free(vmlinux_btf);
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	btf__free(module_btf);
>> +	btf__free(vmlinux_btf);
>> +
>> +	if (test__start_subtest("default"))
>> +		btf_module_allowlist_default();
>> +
>> +	if (test__start_subtest("allowlist"))
>> +		btf_module_allowlist_allow();
>> +
>> +	if (test__start_subtest("skip_unlisted"))
>> +		btf_module_allowlist_skip();
>> +
>> +	if (test__start_subtest("emptylist"))
>> +		btf_module_allowlist_empty();
>> +
>> +	if (test__start_subtest("invalid_input"))
>> +		btf_module_allowlist_invalid();
> 
> could you add test that verifies the module's BTF did not get
> load because of the allow list setup, something like:
> 
>   bpf_program__set_attach_target(prog, 0, "bpf_testmod:bpf_fentry_test1")
> 
> would fail, or some other way that uses obj->btf_modules
> 

Sure, I'll add a test using bpf_program__set_attach_target(prog, 0,
"bpf_testmod:bpf_fentry_test1") to verify that the allow list correctly
prevents the module BTF from being loaded. This makes the verification
more clear and explicit.

Thanks,
Fuyu

> thanks,
> jirka

