Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012041.outbound.protection.outlook.com [52.101.126.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304414AA036
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439979; cv=fail; b=E8dra9aFKSu49him6TC+w3sSnQ2v+/m6vOQIMEVsJEsEFa1qvl1R6pCvtnmWA1ps9YXipiVACsuvirT3CJG1sHuwLR0OVu4+0aTYGkviuaKJOJGlEVGZi7PJWDksUEA86sbRC295ZFUhTLIbTUofbOarZFp0GTSX6XHu7yMCNXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439979; c=relaxed/simple;
	bh=xf7zQL40QdC+SKpXmuLdpsPqI6bBKryBTZkAAwTzro8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHubGbMcDzLxZBgQ9npQJNsjKX+knhIsGvRoxHn3Fes8gcwSy1gLb96fPkm7Q8ZoeXZld8t33S37BYlA/mGnltYQ91uOa/6f7g3DAp1QpLDJ/+ix88AZY+RWK5rpvT+SemUefOUtDwvhfXxNuaPr15DYd/FBZxTwjQG4qlk8oAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=c4Z3qTVQ; arc=fail smtp.client-ip=52.101.126.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="c4Z3qTVQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMdoJSCoWkObEYKhRAsuBCvtDwsVOLtzU8TlJFEbYQL+LpRupKBC/fHEgd8Vp50lEVkr7zCb/eLcOR90bPL23hn8TM4X+PU+y3/QSYQaKVWV4kwel6HQmFcAEGz3Z6YHgQfhN+68udLI4Y1Q0IV+HlHujucqWBU+9IsteN5E6qOSVlCARNcsvf7Zwxr2p917zJvg7SMdpxHnAQI9sWDnVW0qdqwZh9kYlXHY7d7aZDROZs7dXrZpBYNnKBUrA3wKu3Tb0+M5KO2CUrH3DANoy9dD8zuKMqVY2wpa0Gl5hKQR5RbzZaHaWAnDZeciPXiV2s063xM91Kh3CNOEQZioSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaUb1Zi7iFY4RrDFr+Fttah5nK1ycCOWIu1tsnkesOU=;
 b=d8wcg3VHqxw6phD2erzkyJ13ut6LL5BOmilfuM7VJTXJ3oF5gnOCXsSONfYzKMQxLVkkD8MAETFCScn/4Zb41ccIQUl/WSpzV4O+bGsocuJx6jnrjNL4eAMvUQTMO36qsk78ghTk77hAKw0qoEJyrnTWx4GSEkrK8PqcawKXYrSu7hAtvyYukpelQxw4/ArTQHEBoJ3Qg2QHSireKprhCQJdkKa/r9EKDDcfcr3QCnBN6rtGJNUIhFn+MVbl4cPDHlw8i89b6r5rUBG/DoZUpkeUABp1GTTIivn2TB0edTJQpXtID50an4V2Yn4AV3ZcGAQFK3epMZrUcxF/ajWn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaUb1Zi7iFY4RrDFr+Fttah5nK1ycCOWIu1tsnkesOU=;
 b=c4Z3qTVQvxfnHUYWPFP57uNBo6izofDzDw/IBCCEwc10ivQLeRx3IZ/P6BNBzgvdJgbGV1BpAQL/n4fvgBVHOjmPhXnnQfAsJZO1MnFhlxZzxleASsBvPPj+gE8nODGYfpHyOVGZg54v1w2Yjj027+RImKr1faYujhb9zkMHo+y+FKv18YdG6zgfForKz45P5SWv3qAFCfLAWulMJMcSi3FqdyIkfkwJLhfKV6UYLgm1XrCVvd5QQtmFJEIhxe7TbjxUKfa3vMV13RiNnXV+bP3wc6v/465FPqBSYxaiLDblMQsH0KIcBE3ZXpZ3dkFiO0AoiQ9v7rahaSd2xQxnGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB5855.apcprd06.prod.outlook.com (2603:1096:101:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:52:53 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:52:53 +0000
Message-ID: <36e76f62-139f-430d-bbe5-afc79f001b9f@vivo.com>
Date: Thu, 3 Sep 2026 20:52:50 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, alan.maguire@oracle.com
References: <20260831133809.1161-1-zhaofuyu@vivo.com>
 <20260831133809.1161-3-zhaofuyu@vivo.com>
 <CAEf4BzY_MJa-Eyd2iaE65B_jPVx07PU+ctCrQtLtHQK+PEzsXA@mail.gmail.com>
In-Reply-To: <CAEf4BzY_MJa-Eyd2iaE65B_jPVx07PU+ctCrQtLtHQK+PEzsXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ac18e7-2826-4203-2430-08df09ba44f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|56012099006|10067099003|11063799006|4143699003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	d2O5dwWYvwb6F+iSOK1MDWgGcaCSkTXL11mzD9fE9WW0sbh7VNUijI8fhwPzkKTEhgnd3vpkYf1nJLfFGMDWI46SD3F2kQNcDwvziPEOozWLxzlA1r+Jlx6WTrVO4QawHZmwbTeyxphalREWUzpq5b/0A8APi+AwLTDJd4vjyiLy9BKUhx3INanKY5ujIQ0CGxeDJ0+PNmEnhcxQKrjzbc8SjlLV8FzUxWMjm8K4savHvadqlR4+oEIdhUKPLrt150W9RetqUCJw++Es7XNJqO13wrFhxgHl/hMrrcAd8/FpJnXWrrkis95PGaM8JQYfFdA1ZNeJidhgtxUU9YoAH14QpjBOcVXaNF3KIBqcSIdeNntwQnAcSLyz4bj8dyjN714m0AFxb0PlalUUQNTt6Pk/RBhKfzuT15MySHWaEGKxSHY1EUMz/3b2elTcd0yDwk7WfVgkIz8M4ni4gmN58BbWg+oIvtGWmvKAbSoMUc6iQRdLWU3OoGiuLvO6mIPFcWRPogegMxs3MR2H9l7sBWWRDhJoYgrR6OiGEMLbeOi5+vEYGEvW/sNu5r2Sc3oGVx4vzrTn2DK1xrrFc5RsdLvxh1LiIGH1Y89DmsYj88wNPgWgwYf0BcZlLDEeYv768mVk9GE7GqXH769Uq3VsH+YVF1N9NJtw1Zknqs487EE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGlEMnlPNVZxMytGUnlTblRuVE1YbU5KdWxZOWFPRnVCWHRZQXVCSVd0dGFV?=
 =?utf-8?B?QzkreHV0T3JEeXlRcHdJQmovY3A2S25yajNCbDNWOGRtMlkwM2M1UnhlaGI2?=
 =?utf-8?B?bDJDTEprVS81djMyTDhrNnZQMEtvZXp0WXdHRCtOSkJXU0hsN3lnZE81ZnBx?=
 =?utf-8?B?cDRzbWNkOU5aNXgrWFU1azNRVkUwU3FSL2lUMkJtL3g2dThSUHNXaktNeGhD?=
 =?utf-8?B?d1NKZThqSFVSUU9DTWdTQ2NEYTRmRXBOYWN0eXRnOUs1NDIzaXdmVUdSSVJh?=
 =?utf-8?B?MHFlcTh2dlI1akt2dUV3LzVjb0NkUEZ0R1NtNkFMdVhkTnVadkRlYzFTUUU4?=
 =?utf-8?B?Q0lWemQxQXdZaUt0cXM3YThCcTlwMnBraGRhOXBCaTN5S0t6T1E2VlEyckgx?=
 =?utf-8?B?NHk0OUFNWnVnR3hJV29RWGlpSGhKRlI0VlQwd2x0cGY3RGlreGNQNWk5ZDR0?=
 =?utf-8?B?aHo1T0EzcXVPY3NHTUIwcHZUc3hLaFpiVGdkWjZVK0VGaFZtMDRuZVA1eitk?=
 =?utf-8?B?eG4yNHQ2dm5yVFA0cE56WkNKQ3RLQ1ArNVlxc2YwYWFRcDd5dzNlcTNKdCs2?=
 =?utf-8?B?aFpiZHFzNEsycHRxSmVWc0x5QUsvOC9LeCs3YVF3NkV5Q1hlQ3BJY1VvbE15?=
 =?utf-8?B?OWNZMlBqWndqd1lvZWpTbDI3TCs2eVc2VE94eEM3RzJlb295R1Fkb2tyVkda?=
 =?utf-8?B?TDkzRkIwK01pM1hVL0tSb3VuL1VWQ294SzNFU0pmaU91YTY5TkpaekhnaXdP?=
 =?utf-8?B?algwcGs2TnJSaXFQT3V5NGQwNTN4SmR0RWQvL2x1b1dFVlNEdEVMMVlwV3Nr?=
 =?utf-8?B?elBmenY4bytlWngyYkJVblRVY3hkYTVOaVlCRXFzVVpJdGErU1IzTEo5cmcw?=
 =?utf-8?B?L3dmV3pCcU9CN1NLK2FKSjEyVlpDNEVVSUx3NWZ5SWg0emZIS2o1TlVRZ2dp?=
 =?utf-8?B?N0hMYm9ZalpJQ2JLdVA1VCtwNTRzR2R4d0VYSisvNm5JN0lzNWlvekR0OHZp?=
 =?utf-8?B?MEhQMFppa2ZodU9XR25zSlNCZ3lGcGxjZWQ1Wi93VGVZQW13bk5JeUlaUWlT?=
 =?utf-8?B?U0FLbFR6bnpUQkZOV3EyM2FlNWJXa2lpUGVKSXBEM09jZEFaTXBiSUhzU3dp?=
 =?utf-8?B?U2ZQOHlQWTlIZXVKQldCRTVPRGpvRnRZbFpWSTlIUUhQajdOS29BaEIzNzVw?=
 =?utf-8?B?RllsZWVZL3VhRXpjN3FRdVZmeTE1Wm1Kcy9TWHh2b04zYnN3c3BUY3FEUmtG?=
 =?utf-8?B?YVVNUHB0MHdJVnNrZGZ3a2ZtK0ZEWVRLdTZSbTV0RWdHK3lzditodklDeGhU?=
 =?utf-8?B?c3FKRWQrakljaC80OHluaVVWRkpud0QvOXBnOUI4SHFkTHNncE16QjN3YzYv?=
 =?utf-8?B?VlROTmhac1ZONVVsRVY3QityNnZmUXJrdENDUDIvV3JSZmxWdkhPNzErSHhs?=
 =?utf-8?B?dXNrVnNHS09PWEE0cDVydjFJMlhTK0FlU2JsMk5SYUtMUW9uUWJMWVFYcGY0?=
 =?utf-8?B?VzFxWkhOVVh5T1dJMjdqTlM5SEU3T0pheFk0M1JEYStOR0tNeDEvUVRRSTJu?=
 =?utf-8?B?VWtRS0FHNk1INkRrZHpOTUh5dmdJQ0pieXNkS2laM2VCUGxlVFlpSDBLb0My?=
 =?utf-8?B?dVJucThOTzBRUlBnWUI0MndUNFM4bDVsb1QxUXU0U2ZDbXAvYndGQXh0UmZE?=
 =?utf-8?B?LzlnRWdDaHZvRmY1NnU0clh5dWNXZFRQdG8waGZHbEVONzRlVW45TGh1a0NT?=
 =?utf-8?B?NWdhVENFRWVjN3QwZVFLYms2cXpjRHR3TGp5Ti9RWENLTlFqajdSdnZWOE1E?=
 =?utf-8?B?SWFaQnlmdks5ZUo3dHpic2JMSFFnRmZYRE8xVGZtZitnd1I2V2poVmlBcGN0?=
 =?utf-8?B?Smd2NjI3QUI0ME92SSsxbDRQK0MyMXZvUTQ1ZEQvT1daaU1jaGthRWt4UjJG?=
 =?utf-8?B?N0NxT1JhWDVEdmhZTS9VUzZZNFZsQnlaeGRiOFN1VWtlYktiRUtyS2ZnM0t4?=
 =?utf-8?B?U0pLLzM0MWtxVWw0OXlPM0JXU3BGUzJUVTY4VHZqdEhoNEZKWHUzbGF2Z0Qv?=
 =?utf-8?B?bk9jTmdMcVRQRzRacWZ4MWovOG82WUc2alI0UUUvNVNJYll0WTdDNEFUcmVu?=
 =?utf-8?B?UUlJc0xkTDVUQ2MvZW1VNzFjUmV0b0R5ZC9hV3BJQytzdXJoSUZ0aDQ0NVFK?=
 =?utf-8?B?dWRhOUUxbzRsc1RwTkczUTduRHRTZk8rRkhWUGw2dElZUGpVQXozQUNhQTIw?=
 =?utf-8?B?cDluL2R6MnpCZ2tVa1F4aHpwSDYySncyUXhmSG1qWXlWaDZ5YWZ1dzVvTTNE?=
 =?utf-8?B?N1hPTERzYlJRWjlVSkN5a0h6Z2FKWUFqTHR2QnBPU0g0MDFCUUZxZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ac18e7-2826-4203-2430-08df09ba44f5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:52:53.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MT/x/CVC8fIWw9RtENxepHurMSEvGrnPqwnSeS7bqe210lqAdJRFShiiqHRf/RB8sz3GNgrteKmbNQstqr3VVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5855



On 9/3/2026 8:12 AM, Andrii Nakryiko wrote:
> On Mon, Aug 31, 2026 at 6:38 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>> Add selftests covering selective kernel module BTF loading through
>> bpf_object_open_opts.
>>
>> The tests verify that:
>> - the existing behavior is preserved when btf_module_names is not
>>   specified, and loading succeeds when the required module BTF is
>>   specified;
>> - a required module BTF is skipped when the module is not specified in
>>   btf_module_names;
>> - an empty btf_module_names list skips loading all module BTFs;
>> - invalid module BTF name lists are rejected.
>>
>> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
>> ---
>>  .../bpf/prog_tests/btf_module_names.c         | 162 ++++++++++++++++++
>>  .../selftests/bpf/progs/btf_module_names.c    |  13 ++
>>  2 files changed, 175 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/btf_module_names.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>> new file mode 100644
>> index 000000000000..68f4a8d73560
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
>> @@ -0,0 +1,162 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include <bpf/btf.h>
>> +#include "btf_module_names.skel.h"
>> +
>> +static void btf_module_names_load(void)
>> +{
>> +       struct btf_module_names *skel = NULL;
>> +       int ret;
>> +       const char *mod_names[] = { "bpf_testmod" };
>> +
>> +       LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +               .btf_module_names = mod_names,
>> +               .nr_btf_module_names = 1,
>> +       );
>> +
>> +       /* Verify backward compatibility. */
>> +       skel = btf_module_names__open_opts(NULL);
>> +       if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts default"))
>> +               goto out;
>> +
>> +       ret = btf_module_names__load(skel);
>> +       ASSERT_OK(ret, "btf_module_names__load default");
>> +
>> +       btf_module_names__destroy(skel);
>> +       skel = NULL;
>> +
>> +       skel = btf_module_names__open_opts(&opts);
>> +       if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
>> +               goto out;
>> +
>> +       ret = btf_module_names__load(skel);
>> +       ASSERT_OK(ret, "btf_module_names__load");
>> +out:
>> +       btf_module_names__destroy(skel);
>> +}
>> +
>> +/*
>> + * Verify that an unrequested module BTF is skipped. The BPF program
>> + * requires the BTF of bpf_testmod, but bpf_testmod is not specified in
>> + * btf_module_names, so its BTF is skipped and the BPF program fails to load.
>> + */
>> +static void btf_module_names_skip(void)
>> +{
>> +       struct btf_module_names *skel = NULL;
>> +       int ret;
>> +       const char *mod_names[] = { "module_nonexist" };
>> +
>> +       LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +               .btf_module_names = mod_names,
>> +               .nr_btf_module_names = 1,
>> +       );
>> +
>> +       skel = btf_module_names__open_opts(&opts);
>> +       if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
>> +               goto out;
>> +
>> +       ret = btf_module_names__load(skel);
>> +       ASSERT_EQ(ret, -ESRCH, "btf_module_names__load");
>> +
>> +out:
>> +       btf_module_names__destroy(skel);
>> +}
>> +
>> +/*
>> + * Verify that an empty filter skips loading all module BTFs. The BPF
>> + * program requires bpf_testmod BTF, so it fails to load.
>> + */
>> +static void btf_module_names_empty(void)
>> +{
>> +       struct btf_module_names *skel = NULL;
>> +       int ret;
>> +       const char *mod_names[] = { NULL };
>> +
>> +       LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +               /* Non-NULL pointer with zero entries represents an empty list. */
>> +               .btf_module_names = mod_names,
>> +               .nr_btf_module_names = 0,
>> +       );
>> +
>> +       skel = btf_module_names__open_opts(&opts);
>> +       if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts empty"))
>> +               goto out;
>> +
>> +       ret = btf_module_names__load(skel);
>> +       ASSERT_EQ(ret, -ESRCH, "btf_module_names__load empty");
>> +
>> +out:
>> +       btf_module_names__destroy(skel);
>> +}
>> +
>> +static void btf_module_names_invalid(void)
>> +{
>> +       struct btf_module_names *skel = NULL;
>> +       const char *names[] = { NULL };
>> +       const char *empty_names[] = { "" };
>> +       const char *duplicate_names[] = {
>> +               "bpf_testmod", "bpf_testmod",
>> +       };
>> +       LIBBPF_OPTS(bpf_object_open_opts, opts,
>> +               .btf_module_names = names,
>> +               .nr_btf_module_names = 1,
>> +       );
>> +
>> +       skel = btf_module_names__open_opts(&opts);
>> +       ASSERT_EQ(libbpf_get_error(skel), -EINVAL,
>> +                 "btf_module_names__open_opts null");
>> +       btf_module_names__destroy(skel);
>> +
>> +       opts.btf_module_names = empty_names;
>> +       skel = btf_module_names__open_opts(&opts);
>> +       ASSERT_EQ(libbpf_get_error(skel), -EINVAL,
> 
> please don't use libbpf_get_error(), this is legacy and is
> discouraged. check that skell is null and then look at errno
> 
> 

Sure, I'll switch to checking skel and errno instead.

Thanks for taking the time to review my code.
Fuyu

>> +                 "btf_module_names__open_opts empty");
>> +       btf_module_names__destroy(skel);
>> +
>> +       opts.btf_module_names = duplicate_names;
>> +       opts.nr_btf_module_names = 2;
>> +       skel = btf_module_names__open_opts(&opts);
>> +       ASSERT_EQ(libbpf_get_error(skel), -EINVAL,
>> +                 "btf_module_names__open_opts duplicate name");
>> +       btf_module_names__destroy(skel);
>> +}
>> +
>> +void test_btf_module_names(void)
>> +{
>> +       struct btf *vmlinux_btf = NULL;
>> +       struct btf *module_btf = NULL;
>> +
>> +       if (!env.has_testmod) {
>> +               test__skip();
>> +               return;
>> +       }
>> +
>> +       vmlinux_btf = btf__load_vmlinux_btf();
>> +       if (libbpf_get_error(vmlinux_btf)) {
>> +               test__skip();
>> +               return;
>> +       }
>> +
>> +       /* Ensure bpf_testmod BTF is available. */
>> +       module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
>> +       if (libbpf_get_error(module_btf)) {
>> +               btf__free(vmlinux_btf);
>> +               test__skip();
>> +               return;
>> +       }
>> +
>> +       btf__free(module_btf);
>> +       btf__free(vmlinux_btf);
>> +
>> +       if (test__start_subtest("btf_module_names_load"))
>> +               btf_module_names_load();
>> +
>> +       if (test__start_subtest("btf_module_names_skip"))
>> +               btf_module_names_skip();
>> +
>> +       if (test__start_subtest("btf_module_names_empty"))
>> +               btf_module_names_empty();
>> +
>> +       if (test__start_subtest("btf_module_names_invalid"))
>> +               btf_module_names_invalid();
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/btf_module_names.c b/tools/testing/selftests/bpf/progs/btf_module_names.c
>> new file mode 100644
>> index 000000000000..232adc0f33f6
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/btf_module_names.c
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +SEC("fentry/bpf_testmod_loop_test")
>> +int BPF_PROG(test_btf_module_names)
>> +{
>> +       return 0;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
>> --
>> 2.34.1
>>

