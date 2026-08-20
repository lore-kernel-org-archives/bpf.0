Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012000.outbound.protection.outlook.com [52.101.126.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396B1ACEDE
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196496; cv=fail; b=hM/hwHUlc7PN+DfANbor3XYHn9Rr1ccerOXnPlHQ2GyvyBStLaCLSsWs45HskmfLEd816EMrCkrw0lDJUcwrisMD+fBWevEj+qHcwA3mGqbPQRrkHCZlwbIY89AETcGtcEvv6FqcqGPZ7xdI93CpkQGMhOK88Sg6i3NgOckxNM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196496; c=relaxed/simple;
	bh=hr89yN83hibJJYIyjbWHyNWgxabvtaaWaKQNY2jYQAE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tOAeGtHG92tw7uyuo97YiOZm3+l8Gnywh/4K7WEkposxprqcVN9gcUFxoyYcmZ95buMjpwxtywHwCFkogpZu4qmi68lOTsVXzcZOES1pc582s/PJ7X8CEzfaO17fD6+cLcivsMo+GyJE2MDGALntNxp77zt6cXwEGscbdUPzKSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VXIKewDQ; arc=fail smtp.client-ip=52.101.126.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VXIKewDQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lO8L+SW6S96zzRWdkGh5YGEKfO6O3wznCYC1H1pXuAIoqdc059MNnIZ+wkOxOWE3T9DxNa6O9+ztgUhiQOR8RrArGmpuRr7nW9Jvf317V63hIus0xw+wq5P+113Rw+t4UE34GUohQBFIC2pwx4mWyV105rE3ZiMhtabfoaDU5vVSgwXi/a7YL1VdXtmw0JEWpPf6mQDQhqfh3rzwRnC6/ixFhvZ4xuRIYfgrq+ODSaqG6f1a1sS4K0sSaCwYX29zeYoUrLppQgeSwOKZuLp0y8+Tt95umxwA21V+ZPzjjhsfnQ0H1nKKmrR94IzDD+tuc1o6l9G/WPaFYg9YJF3AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLpnexAg2oigSEsDILCMDbUfoGtfKXwBtSarw3DTTm0=;
 b=UbUW8ZoRaIaHu5FszD6YNPeSHkMlDDCUMxy+EwMml6c9zFuo2pk2yQ7jIVKwOK08Ne8Yp5QhxQgJvqKq6veaT7wEvh8N510/RUZ6/Z1EETmVQn/1Jwv1CkI4qHyleV6gcRcfCHaQpK5izGLwf0mpTRzjQuXHDxX5a/9ChdLkkwP/1mGELaSYPdF378P4FAsao3nLMQGxqaxfuAY2h70O1yBvGrgaBkp7/w7u/D5LmY5LG5cpfBbNTGsPbMjosoIHQLvBXyetev8AGBpaR9Y22zQsZnn6qY0oOLgnvgOw+JHMxFhtMmvJ4BFKf1f6/UdukK6FWS4lVQvWpiStFUF4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLpnexAg2oigSEsDILCMDbUfoGtfKXwBtSarw3DTTm0=;
 b=VXIKewDQWuL3X0gaz1JYQhyB+O6s3JfMgYCF3/JWOSwfjOvf4EG3L0RjyYgeExQV5502ZdY4bgQVTZSZhiZs64RMBKoDcttCRAj8V3lnSngtUujrLS1emFTiawajTkJDVa+uWff7/mAvUi9Mb5Tr1YmgbNZb4J2zDqXL1mlpIhKOozhNCm7oSNruxLDMLKENdcGO5GLR2BzSF42MYXg0s3c75D1cuHr1ZSNVeIWqx/8Q09NBsxhw3IpERwQ/CLFs2/w35CLqXxKhErvbOoCNk3AlIO61i6i3tj0c7qx6RNkfYNsdG+1JwI7+GF0gmvSQzalzmod6J4bURbnEZvIgIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SE2PPF4565C7005.apcprd06.prod.outlook.com (2603:1096:108:1::7cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 03:28:11 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 03:28:11 +0000
Message-ID: <4627d5c1-81b0-420c-bc43-36ad12348468@vivo.com>
Date: Thu, 20 Aug 2026 11:28:08 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org
References: <20260819090426.267-3-zhaofuyu@vivo.com>
 <5cec664e8218aab8a7304ab755e65410dfa07ff5ef4f19a48ee3ce1baed80aff@mail.kernel.org>
In-Reply-To: <5cec664e8218aab8a7304ab755e65410dfa07ff5ef4f19a48ee3ce1baed80aff@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SE2PPF4565C7005:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd0b08f-ce1f-491b-d38a-08defe6b1003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	hV6ilD6pcEHauToHTpLSXwLyTW764z4VBE7EhoN5n9yqsLa7MHXoApC1diaPWAMk18LNygqrhM128GjQgdbdKzI9qKuAVznMjCN3lA/tmO9jHZVtGqtKvlw43x5Z+FUHTM7Hs5jNOkz3SI5Hj/j0Qp7t0Znk6PkZn8SJm9pkAJ9cjI89Rwl9WUycrg1nP5SpQDApGEv2HSH9jcaGg2A96ebhPHMlT1VDSJVGqjOdL8wMYLRw2LZ6HHGQG/vyYlqarCrzHVArWvb5EklIEatWk/F3V0GOn0y7EVGO0FCplXK1WElRBorLiccPnDiPwMqjJ50IGKA4mypt9q7dBYSOIC81YyQFY/hRy3/OOx9Odv9hevt7cjWvxN9rcGj8MpuzE+M+lKPflIUqaMp2b9MbrZU9Ll9ovQtJdf22SLGRLma9kHhHR3mp1YOWaJRo/EESZLpfiFvJ5WDgQYHaWq9sAV9cqpCDwHAiS6LKwiRSNsnYnKe1fs2CkX9tWS/W5K/e8NkLqkMSO/ip6M+pgPP3VXzcLRLuIiYVxGDlXOiNnf5efa+VY1D2RY6BI81fW4zJaJSBsifkHZ0j24OKTnheO9eIf0zaNryIqsNg11LZ+ybhyQWQq4nXiPLLnFJSnaY2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHpkMkZ1alR4YTJjZmF6S3ZPc0hlWnBpUXprQmxIYUpjV1BlUm1aT2NQNUJs?=
 =?utf-8?B?dEJhSE9mbTZLeGY1L01lV1RhVTV5QWR5T0RldDQwY1J4aGg2NXFnbk9Yakk5?=
 =?utf-8?B?WkhWSFRucEFpRWorOVp5S01IcnVkai9yWkZqZi9QNmIwa1FrdVFVVFNmMytD?=
 =?utf-8?B?dzJVc1p5YUxLbGJaTVRGbjFpYmd0blIwSUpNSHpOc1VGMGxZSDNLcXpnTTZq?=
 =?utf-8?B?UTA3aEJyemRzOEN2elVEZk4wcHk2c0xHanFya1JJQVZVUTJmQWNyaHNMZ1VX?=
 =?utf-8?B?eGRwU2dNNjZzYTR4aEhLNjJpUmtENFBSTmh0dmVMcWZOd2tuNzhEN2R1OFV5?=
 =?utf-8?B?TENONlB1NG5HQStMaGcxUHVBVHVqb2xuTGxmRFZ4Rkh4VERXR0dWTHh4NkFy?=
 =?utf-8?B?YzF5NGRNZkxBRG9KYjByekErWHZNaFlocE5Lcm5jZ1ZOMmFpcjd6Zmtod1J4?=
 =?utf-8?B?MUh0SWkrbGZFeWNUbk1XejIyM3VtVW8wUk1lSk1adDB2ZjMvSWpsSDNydHp4?=
 =?utf-8?B?OWhaNjRraGROWUZvdlRaOWRyam5VNUM4MG1jN2xjenluc2doWEhwNGhKOUtt?=
 =?utf-8?B?cTJRVjlmdkp5SkgrRThqdWVlT3UxUk9ZYjRpUjE2ajJtQWw4OS9MUll0NnhQ?=
 =?utf-8?B?MFVpeHdxSFJwQldrajdpMmtSeStpZ3NPQWRTcFVXcWFmZXdLRlhIRTR6TUVs?=
 =?utf-8?B?ckVtM1NXOFM0ZUxCMGFKRUMvdXBpalp5ODUwdmpTL2VMNEgrWmxzVDZZU0hk?=
 =?utf-8?B?aTVqL2dCaU1mdHZGQ21OeWVhZy9FMGdURjlHYVhyYStxR3pWbU1MVHlwcjMv?=
 =?utf-8?B?SlhmZDdrMmt0dU95bEpGenF6VmkrN2hWRDBiSW5uY0xBeUE0dld0VGRxQjFN?=
 =?utf-8?B?WUhkZUhNdnZVeHk3QUJuS1Vac0daODVpSEJVRGh4MTJISC9ZR0pnZkpxL2NM?=
 =?utf-8?B?eXV4c0hNeit4R1NEK1Z3S0s1bEJsWmZ6RUFIbjhwVzFFK3YvOTNZbWdlSTQw?=
 =?utf-8?B?YXhvcUpnZXVaY0Ixalk4WVNwQitOUUVmVUprbFhtcGRnL1F6UXVJT1hJdjVU?=
 =?utf-8?B?aDFzNUpPaHdSSHFPRXpQdXhuQVQwVUI0ajQ2V1JrVTVKRlUxNmFWb2xaQ1R3?=
 =?utf-8?B?bFJndzNqSXpnZGdlSDVxT09SUHRHUG1scXA2ZktvMkNiVHZxUmExblZ6QlEw?=
 =?utf-8?B?a3NNQU14cXBCd1ZJNWwyNC9YWUxsZDhNY1IyNmdPcnl5RHM5QitqM1VxN0FP?=
 =?utf-8?B?UEZEYjZwZDhkNjdiMmw4ckQyYkVqeStaVUU3VmxJZEhTZEFyM3EyYWtsRHd5?=
 =?utf-8?B?NjViOFBZWlVyVXJZNEQzNHEyeWIyVlZ3YWcrTmQrckRyUllOS1lFNy9Pc053?=
 =?utf-8?B?MkNuZDBuZGJEelV4SFJ6ZzdDWCtKbWJqTmgvcjllaiswVDdkeitLMk15aEto?=
 =?utf-8?B?YXk5TVR5TmIyVURkNjZrYVF2encyUXVidVRhVGhKcjdncnhaZ055RzhvZngr?=
 =?utf-8?B?dE10YVVZOFY5b09lRmt6TnZqK0xmRnZmcU1JNjhQeHV3TVBudFM2ZCtrTTc0?=
 =?utf-8?B?S3h5RkNEb1BDL1ZweVcwY2ZUUHVDR1d2bmYzMDRnMk93dnhSNHlybkNUV2l5?=
 =?utf-8?B?M09SMnRDVWZ5M2xtb01iOGVBcHpFNWtsSkZtcHNZRzVsVm5zZElheW9mTGhV?=
 =?utf-8?B?ZjhNb042OEd6bEhpbk8velM1OFBOeDRxTm1WUlBlWHJjYit3dFpUT3NYd3lZ?=
 =?utf-8?B?TDUwb2Z0WlhSRU5YYjNQRnorMHpDMlF6UEViQUpnRWs0Y0tpYWNWNmczNlhl?=
 =?utf-8?B?SkxpS1NZVXNYckxEQkhmQTJ2cXRrZHNPc1JVMHkxVFU2eDExZkdVa01LbnQ1?=
 =?utf-8?B?dTAyT3JhWDFMWWhNY3VyS0dFY2M5OGJENkhmSmFWc2E3UG9hNTVlTVZ0ekhZ?=
 =?utf-8?B?UVN1eC9EUkNndlh4aTJXa1FkakFtWWxRKzl5OUlHd2JiU29oSWEyY1dVRThO?=
 =?utf-8?B?bTVXcGowUnJHc3NtaGQva0VNRElOL0twV3ZkdUdlZGhTcERraVY2am82K0Qv?=
 =?utf-8?B?T1ZvcFhJZGhRRHMyazVQN0tEdUJmKy80aWcxZ051dm8zbjlzUlZpZ2tuYjd5?=
 =?utf-8?B?a3NYRUVqQ1k0SHF4dUlaN0hSR2NzSkhPT3hrWEpTSTZjTk9KUXZ3ZnB1bUk0?=
 =?utf-8?B?Mm5hZW9oOXlPemRpZmZoeTJiQjZiK3V0ZlNRVnZDeERkeVZ3VVczcFM3UlVT?=
 =?utf-8?B?REJkYUVlRkhzeVl1bFFxbG1kQlpRUDB3UTZnbm5hNFI5TDh3RFVWMjRjMW0x?=
 =?utf-8?B?QW9sQUJpVjdLQmp5RmxVdzE3SXM4cU1PYUtMaDdQQkJJcDAweG9DZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd0b08f-ce1f-491b-d38a-08defe6b1003
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 03:28:11.7707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27bG22w6CV6ES0z7xEI43+ODS6JF0TJmXzlf+/tXhoh53w0GUTeeWQiVzkIejpH0FyI23NxMp/q5vOUcnE2yvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF4565C7005



On 8/19/2026 5:50 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> new file mode 100644
>> index 000000000000..61d2845a731f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>> @@ -0,0 +1,196 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include "kmod_btfs.skel.h"
>> +
>> +static bool btf_skipped;
>> +static bool dup_ignored;
>> +
>> +static const char btf_skip_fmt[] =
>> +	"libbpf: skipping module BTF '%s', not in kmod_btf_names\n";
>> +static const char dup_ignore_fmt[] =
>> +	"libbpf: duplicate kmod BTF name '%s' ignored\n";
>> +
>> +static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
>> +			   va_list args)
>> +{
>> +	if (!strcmp(fmt, btf_skip_fmt)) {
>> +		if (!strcmp(va_arg(args, char *), "bpf_test_no_cfi"))
>> +			btf_skipped = true;
>> +	} else if (!strcmp(fmt, dup_ignore_fmt)) {
>> +		if (!strcmp(va_arg(args, char *), "bpf_testmod"))
>> +			dup_ignored = true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void kmod_btfs_pass(void)
>> +{
>> +	struct kmod_btfs *skel = NULL;
>> +	int ret;
>> +	static const char *kmods[] = { "bpf_testmod" };
>> +
>> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +		.kmod_btf_names = kmods,
>> +		.kmod_btf_names_cnt = 1,
>> +	);
> 
> This isn't a bug, but would LIBBPF_OPTS() read better here than
> DECLARE_LIBBPF_OPTS()? The same pattern appears in all five subtests
> (kmod_btfs_pass, kmod_btfs_nonexist, kmod_btfs_dup, kmod_btfs_skip,
> kmod_btfs_no_cnt). DECLARE_LIBBPF_OPTS is defined in libbpf_legacy.h as a
> backwards-compatibility alias, and most of prog_tests/ uses LIBBPF_OPTS()
> directly.
> 

Agreed, I'll use LIBBPF_OPTS() instead.

> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32236360082

