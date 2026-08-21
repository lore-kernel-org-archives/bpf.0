Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013007.outbound.protection.outlook.com [40.107.44.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D8361977;
	Fri, 21 Aug 2026 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284297; cv=fail; b=Ri6WOnCLC2by0aP4TEVcDC/lHGnOUVrc7Ymi1TmNufVrlVBS2poSGigHtDCv1m7fSt4cBv7NlF+1NKUlmMKkcCMu63eV5EbPDHvtUZiqvMdWyL2QI1G9pOApLzZVJ6qKwQEE8mkeQ9wPfD2CO4wQHhMdaILXfSTDg1zLtanA/kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284297; c=relaxed/simple;
	bh=LTqg7+Sapzivfep4gOlQ78vvRG2a/8/5m1fQtnrQEmk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=if5L4AsreAWPXqSUPX5NLRd8JaXBRJF6RkJ2PuWvvq4k/CkKBgf7EQLs34zL5CURQhqV7gbiOrtHtf6CzZe0VZIYEKCwvtY6Nm+dRStK9O2Z1qgq+Vh1/uVwWtJEp67WLtdtFPNSOwtBxw7mzfuQ0Doi6m6Z9Kz2NmCPT4UsO9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LHaK3gNY; arc=fail smtp.client-ip=40.107.44.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LHaK3gNY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNW8pm2Q884SX8InJx3uJXbJqkQWEptkqOryuS3QRncTDeCsZ9AHH7YBK5AS96XkDVniF1C14kNUTrllptSIL0Tf6MwsM1Fv35w9VzsyKmfr7U2psg7r0D/LWvcBbU57raxsXiO1vqfXGkrPL1rbsNI6WW9nrmIUDuW11SluYCJsja2ZcTOkcg++r4GbAYumlJ5vPEQMa5Na9g1HSIBHSxxGB6pEgwGYiXH9thQ09Y8UEEyQxDjABEO8WWbSMHML9RYIRhxgdz+mB3TEu027OP+atoU9R/dveyTQYhD6aulkevnJSlCqI069WgcNnDuXI4dRJlZGVa+lSDigmhJT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAs5y5XVXI6A0/RtOkDA0OzJbnLaWR/aRoNzrilx73k=;
 b=tqT3Q2/cShrH6NkcM/umQIWXWqxl8tR96LUcEhzPfIs6CkoJNQQwJU9pA8Dyb4sBWZV7jta1YTCGopIihlvnNlIiSK5HbLqEjMgskNkFwcyW/cAth7HuaTLSeGC2CWcfAxZZP0UA7LdQEufOd+wlkdKn0OREuZlIGmCLxRMV5VJd507k1JaQHxOST+u64iXXDFydkoohxnUEvqqeM3nvhBhazceQ8gnzp11tO1lMIIQFcUVT2T3ZVOCQRo5Z6axG5H3msIu8g6tCITmXRcRHvbevtFHZl2nC+lAMIC7BqCh0hDzhpSoD6R+3dmFbXSofI++QO1/hA4ecTsQLXdyipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAs5y5XVXI6A0/RtOkDA0OzJbnLaWR/aRoNzrilx73k=;
 b=LHaK3gNYbuqCTGFqV3YQzRbj4Im6pPktFkFRmwAcGH+aQIEVemm024XujXm4XbDtErcsxg0MSqJHnmXmxsH+PM7ZntYKhtdPnfCurycF2fG7kpdWE+vvVOZqScpHx6lc9iT2WHe1JABE9YfLUNA2Mc1iQlqJ0NxShtzaGxy1q+3lzd2it51H1b7jD9gYDew858oXMz1x+VSKE0K7dBdipUIaJcbGJI7ztdnxXpI7T5JYgty/QMB58FK1Dl0d0wFL5jAZiXWlcAr6Nz6O3XF5JBWvOVszbrM937gGOESUsKPW6nyU09+3ktAraYDBSZBwsEpYGqKAbiJHBbNptgR1dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SE1PPF3B12CE932.apcprd06.prod.outlook.com (2603:1096:108:1::410) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 03:51:30 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:51:30 +0000
Message-ID: <d94fdb54-09b6-4d70-bfac-8483024e94ea@vivo.com>
Date: Fri, 21 Aug 2026 11:51:25 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260819090426.267-1-zhaofuyu@vivo.com>
 <20260819090426.267-3-zhaofuyu@vivo.com>
 <67d62b1943b093ac1eb16c9cc1ff38e0d5eda72b.camel@gmail.com>
In-Reply-To: <67d62b1943b093ac1eb16c9cc1ff38e0d5eda72b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SE1PPF3B12CE932:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca678a8-1ad5-426f-13f4-08deff377c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|10067099003|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sZn+HQFkL1UHG3dVx57wSMO9hLe79GjxLQWuUAw/2in0M8ZvI1r5hfrJuitkU/HopA8O9syoCyD6lUiuj9LiOcw5JLieBjTh9BvTYH8/Ave3NRl9RTUsSWvPJFDWpI7z1FVktjletODl6SrJBQobrYLATzHokxGEPiBXoodIM0dTDAvMRi1+OiD1koQQkoitHt0idZR9kVl6yeXzQVTnZY4D4nVJSJHxZSDdyBGGLt99gi6+kFO70uvqH7MXVbtqDCGrhjnwhJk0BreUE39F7/NaC+3KcHXUWqFApiwmvgzm9AnGaYvbypfAOcJPXNOtdzaS7IjJj/a7mdNxN0GEYSpWfK5z3H7/lePB1T1tS9qemIR5fiSkLyfQMnfJyA1S/bSlDD56/Qn0qsL3pYPEoPk2KpcOvwpVbWHi92bsMdTts/sWcDUwMb+wn+apimEbZNbP2JYx+uNUvbkoqWd+RQs5DmaU/YS5fDmqlAfCxHmn+YCEnbfSlfMuSeiquTLT/G6X8FiBc59wYkOU+Lf8LNii2KA0NXMNmeUMPFmrBKg594rAaiNcyeQy8r4pyBlw8iyk8UwZzZ+//iEOh4QJluUvVfW27u0o7yHdMhgMH7mk8d8rIWGp6AWGGwXtDPCtljvVTpqF9G5BhlU0Wgq5grGm32Lvh2d2dwzSdOxi2vo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDV3WThqN0l0MEpaY2t1YlowVmtSN2NyOEpOS09mWGl0c0RJOVRGRlR2V2hL?=
 =?utf-8?B?ZHVFa3p6YVhZTG9WOEdWTkxKaGhnSUFtd1ZIanFtdG1TK1JwZ2xrRTduUXgy?=
 =?utf-8?B?VFcxY1YxQy9zTU02TFYrenRZT1NyeEdlRlhzcDV0RksvTjMrR0FVeW41TU9S?=
 =?utf-8?B?STNhQm5MSTMvbm1LVHFCMVU2RDkzZ0Q4U3BDS2wxRFdqRUJsSTdsd2dMMjRk?=
 =?utf-8?B?N0hkeHBBdDZvSThEUEJIaW15LytvejB3b1FqVVFkTGNRTWMyM24rYjY2cFdW?=
 =?utf-8?B?UjBoNXZDbUdOZVB4am0zRE91bmRuVWh1dU8zblpsUDd4d2IwakRzN1NsUjM2?=
 =?utf-8?B?U09OdS9vT29reHVEZEhDM0dGaVhLR2JaRC9KVzAyQnVhM2VWV0tiNVl1QndC?=
 =?utf-8?B?bWdxQTlXaHpxdStCU3lYSFJtQmYwWnNCYzJqT0o5S2JKSjNKeVhFZzJtdWlt?=
 =?utf-8?B?Yyt6TnUwclNITGFjeFV1L1Z1NjZNbEJBZFVabzNkQW1yNGcwbndkRi8vUmFI?=
 =?utf-8?B?UmRoc3lIYlpKK0orTklWQWJMKzVjbDRadnBhQ0xxUVZKVzUveGlHL05lZ2tO?=
 =?utf-8?B?QmxJa2hHWmhhTGNWTGZvM1lXa1F6TGlFRnRTWHVJdGtuaUJ6OWF2d1NIWXQy?=
 =?utf-8?B?ZXN5K0o2NWJMRHZFRDNRTGd2RVFMT1dUSlNaeEFxc251dHdPdEJZeDdndFRw?=
 =?utf-8?B?N3huZ1NHR3gwRUhqSnBLTlJtZC9uNlZqRzVkZC9VaFcvR2VmSVpKWmZTcnhB?=
 =?utf-8?B?Y1BWYkxMaUhvRVJ3MEwyWnc4aSt2VTJYUDFIc1NNclNFdHJFTWdUVlNHa05D?=
 =?utf-8?B?akFuNTVBd3BCZ0V5azU5d0R4NWNvd2JlRVFJbFF0eDZFT09sdFc5L0xOY1F4?=
 =?utf-8?B?VE1mVzlWUGpIRzVKZjBCT2VNK3E1Nm1xeTNRRm9FbVpnVUU1NG50ejBoeHBI?=
 =?utf-8?B?RFdBY21Xc2JpNFFMc3UyM2ZEZ0N0bnBucVBDdm5VOFVTd1JBcTFhVmQzZnQw?=
 =?utf-8?B?WWJHaTROeHJWcG1WYThzcXhCWlY5a3pJZUNzdCtUR1IvcFFKb0hObHRrUDdV?=
 =?utf-8?B?TzA1TzRGUXl1Y0RQamtvN1k4TVNqTDZEVyszR2IydmNYbDJFV1lKRk5wc0Zs?=
 =?utf-8?B?ZXdhVjFYMHVDYXE0dEE2ajdFTDMxeWZjMUJVTXc3L205dGtPOHlJelBqQzBa?=
 =?utf-8?B?K2FDYkVsTUZIVnNoUjE0TVlzZWFXYjBLU1hOZE1vWEZ2dFdJelVPZHRZMitE?=
 =?utf-8?B?QmpLbmloaUhSMklRQTVOcWJRMTZoWFZJeU9SWTFoeVR5WDA2THh1U0oxSUJF?=
 =?utf-8?B?OUtzUFViMjNBV3lQUnZzc1lycEtlc3EvUW84NE5LR0VTSEVuaENveDBRUWtx?=
 =?utf-8?B?aG9YdnNkZkl3Mk1nOHpZVytTMjRmSS9pNC9GRDJockwybE1MbGlTZkRxc0ZI?=
 =?utf-8?B?RTdvekIvNEJzM0FpZzcwVGNmQlo5MHI3NElJbHRKd0M0S3dEOGwyL0hhZCta?=
 =?utf-8?B?Ynh2WGxtTEs5ZWJ5M3NNeXk3NTI0QVdoTEQvcTZja2JwUzcxMkorRlZnNDNz?=
 =?utf-8?B?azlkZ3psVWFGdnp3cmpJeHpFbkZ3VE5Ga0NMbnJXMTRqajFmdko4OWxqQmNj?=
 =?utf-8?B?UDh0cXVuUHphNEsxN3BJV1pRQis0U20rZ0w2eEZyNmYzZVhxQ3BFUUJIK2hM?=
 =?utf-8?B?azJjeXdERC80VDhoK3ZKU09uZ1hxMGdqdUdLUkM3QUVRcDRHQjFlaGpiRGRS?=
 =?utf-8?B?VU1lUEJQckpRdW9HelkrTVQ4NUJCVG1ETURtUWprTmphYWxMMEJjbVR0VTI1?=
 =?utf-8?B?UWpJVHRzbU5mQndBT013bWRVZ1NxSncyeEpnOWN6SmRNTGFHT2VjWitmWEhC?=
 =?utf-8?B?MDBhcmkzZGhIbFhTWU94dmR6NXhLWWdZVW5TbCttVFplV3Y5OUMzTFlpbXYy?=
 =?utf-8?B?czRTQk5wclIvZG9WTG82aXhJRkE3TjRaS09SdHROeVJOUENieUxOeFk0ZWd5?=
 =?utf-8?B?Zyt4dlB5azE5V0N6VVpFTHp3NmdES3BRVC82TGlWMzhUYkZPYXAzVEp2OS9r?=
 =?utf-8?B?NDNDcEF6MzA4d1FVdjJZMWRrRDM4RG00YTNjb3Q1NlRZd0VwOUE2Y0dUcWov?=
 =?utf-8?B?OHF0SzRvRHl1cmtaZmh0RHB3bmZ3ZWllb3g1RFlYOVV2Y0NRZ3JEeVdNY05u?=
 =?utf-8?B?YytxdmYvR3RMR242U1BWVmljeHF2R0lBR3hxSGRPRGRxd2w2Q052YTIzTWlI?=
 =?utf-8?B?WVlyaDhTVFB2a2dZK2ViZ1ZWN3BiOGcwM3Y1L01BVVk2dDR4K29qdUpWM1ZR?=
 =?utf-8?B?MTNtRGZmS1ZmTzJXUm9xeFpNbUd5a1VKM1NSd2tkSnFSb1MxdHNkZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca678a8-1ad5-426f-13f4-08deff377c44
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 03:51:30.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IYQBjvnEjqoT/ShEs80euPH0+N/CFBG9DJkDznl/5tEGYy3fjBsVN4/NtQOxxeNXQdUuC1nKGm/DS2Kbrn2+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF3B12CE932



On 8/21/2026 8:10 AM, Eduard Zingerman wrote:
> On Wed, 2026-08-19 at 17:04 +0800, Fuyu Zhao wrote:
> 
> ...
> 
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
> 
> Idk what Andrii would say about this, but I'd rather add an internal
> function akin to:
> 
>   size_t bpf_object_btf_module_cnt(const struct bpf_object *obj);
> 
> in libbpf.c and expose it via libbpf_internal.h (*not* via API),
> instead of intercepting log messages.
> 
> ...

I think your suggestion is better. It also addresses the issue raised by
the bot about potentially hiding other libbpf logs. I'll wait for Andrii's
feedback on this.

Thanks,
Fuyu

