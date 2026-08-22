Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013041.outbound.protection.outlook.com [40.107.44.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6FA3C0605;
	Sat, 22 Aug 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399867; cv=fail; b=RIktxnof0btBJulGL4LycSvwFJ2ayflVNco+XMKkciVfVaBcEuiI8gUDL50+oWtkyHc28Q4gHeoTq6RzUGuDbiGNSkeCidQAcizGf/b5MfanR2y2lrkGdYWl+DqT8pjClCxMw6bT6H9UI5LUoX/IEX83smKS18sO0/PwXY13Jyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399867; c=relaxed/simple;
	bh=S7ZxM4wOXrV3ELwgpgdFuZSUuRzi3m/YhmBuHDs0kn8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M3JPrDtaIB+PeIC2lwtTGZ904bNt9EM7qZcC3JL9ezAkbmBIVeF/bksE3xjstVylzthulPL6ExQAa6jvpnkevomzEsI5jo8FnIMDAojfHGZd9YTgdswfJ7YDRLInU9zlLMngOi3JtZw2krW588GiblnbvSSk4xMX7btzuihfTJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=coWHbkmx; arc=fail smtp.client-ip=40.107.44.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="coWHbkmx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjlO/dNk2o0xLF96HiOt1NTle/ExwumdfJuuWD5OXm+ylukl73BazA2M19jOcZuYNIMI1co/CsM23z6ljG492IgmghEbRitaUyrFuN3bVA85HjL/ZcG3K2T3mgQFXDXZ+ncYzGvh5fqwVmLOgv7cBNz0uRgAAtE/NkwDydmzPo69uCuBTMWFc1xRgRrLgWrJL3Fr5JbQCQyfIPUdfjeknxcZ5MBvZgrpkjnVFfCmmV/l/6ig95cJgkHcTX/9Ly3+HL4BDpZp3nN2gwAAPzFLvoziOR5NxISPqDydc5YJWWwHsz37KOQ6wSTCAaoE7N9At5ujtG74FrpjRT1Xmk1DaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y46gjbdZwHZZbYvo6n1IYsgxb2hBarC7ZPqzX/Ai1ZE=;
 b=Ix9hiZ5S1EI9EoRSxp+7Aj22ozFuPk+v6w1zHEMTqbGNKWV+p/8b9IDjJcyTluLUZIXH7UzNcGh4lQzj14TdtogLEY2XZdsI4ps+24pEd0A7c2isNureG+Hyd8UVJMzNmuKkLL3EKSxN4/S2HHbKVRm+C44iNUPMhMP4jCpbOrrsHpJlmMeaanV8Sf7UZYxu5DF0QSqbLQNbdsXqHiB59tYr48fnmrX5paOSJTYN8Ma5x0yrH0SjAL3AE+qMPjrRCkFO7f2Da6zlZXLUttY0cgLu3yIXIo8wSpFu/aeS07ETblL4U/hi96dEKuGHAwkbIgXdGlUGw8d1Hqofv1nPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y46gjbdZwHZZbYvo6n1IYsgxb2hBarC7ZPqzX/Ai1ZE=;
 b=coWHbkmxembQnCz1wr8jiVZg2G4fv1ZuWa44WQT6JwgTJ7LgnN63aU2Jkv8pWmfXzNaOOPKx6rlMr6aJWW51o3FHNDQLshKdWOIRULUp47msNsJisO2ioVWak9shQ5ol+Y9sEQ4Dr+kW6uUbiGqBE2N71q4H/ZlG3uqAfQMuaTPKGuopnV8cLgt98di60vYOuKgoF1YcOfN1eY9YP3tJl0/KnT7sOD9ToeTV8Wk0BuaQ410sGpof/3oTWxggb0BvjI/f1dlj50xfwuVQ/bkaMtv2WGV4eVvq7/MSyQ1Z4llqVSySPXW6uZfJ5vndjGTph9OCE226Hi9XK1xedm0cMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TY8PR06MB9101.apcprd06.prod.outlook.com (2603:1096:405:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 11:57:42 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 11:57:42 +0000
Message-ID: <bed1b548-7695-49b5-b2bd-84a218d1bcbf@vivo.com>
Date: Sat, 22 Aug 2026 19:57:37 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 alan.maguire@oracle.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 yatsenko@meta.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260819090426.267-1-zhaofuyu@vivo.com>
 <20260819090426.267-3-zhaofuyu@vivo.com>
 <67d62b1943b093ac1eb16c9cc1ff38e0d5eda72b.camel@gmail.com>
 <d94fdb54-09b6-4d70-bfac-8483024e94ea@vivo.com>
 <CAEf4BzYkFPK37zaW10RBX04un5xuWs42gJ2pAtE0_iy2+X=58g@mail.gmail.com>
In-Reply-To: <CAEf4BzYkFPK37zaW10RBX04un5xuWs42gJ2pAtE0_iy2+X=58g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:295::14) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TY8PR06MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9660ff-f5f1-44aa-a419-08df00449268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oJoeQOtm27mXk7M0QJhnutPL1/9v9Jw4K2A9qaErJgfvX99b3fBn8jrKJSCUFIb63zG8ZZSOkke4Wsu8AzxARtv9YgYN4KIHBc4wIYnq7mPM1cCzJ3ErBLwr7qOsUM0XCU2X7662HWDOTSlFisNmGLxCsfggAK4zEEKyU9KhfNgEEoMzZTi2F4XdQo6g15i0tIjYJOn2X7ouaN6+5nOO0TrBL/agqsFLAJr720lAH5tWmFVu9EA8X0RmEVzDnDAaXqthC9EX4uMAOEuOpVElzG6vCTYfsyUFqiA+0lQNubVB/OcUqaNrezDvt88bHFMF5FxIv/6QqnKu68EuBq4VKPkyrxD2FP7x+H+L6bqDYIcI/qVtoy85xzJskDq8tCnHY0sxfK/+K0DqM1XgfMchN6EuIAAyunFuSlU2AOThCx2hNHtKEUFHXBuXYf3HqGt3BCePghCTYZ8pXr8A45qsWEAfCvkdXIF8EaJ1vZgf9SJ+QvlZzlZNexuC06OMbweR2pHziWWjYR+/ztqvQMLzomjH8TF01bq43PsllnK3nXkWBGSHwDHm05x1zsU0D1Sp25QXhTMlkm+DKo3TSjlkt/fr0Oyg48B630gBVV5+SPZTxywGaSDpmhDFK4Y56ll9c9mbJ/wglsUS1qDEhb6A3XlTyJF5F8SPEeUtl8Foz+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVZadzhmWVd0QWFBY2U2WnR5Tk1YOTgrdXRRN2hzK2FVclBaeDF5bTdqbzZH?=
 =?utf-8?B?bjl6dkswaEIvMU1YVGkrc0lwT3h4bTdMS0lQVjJiazVZVFBON1owOTBSQ1o0?=
 =?utf-8?B?WTlHVm5SV2pRaEJCKzNmeExDSDA2aVZYcDFWWVhtaEVSNXg3RS80YTUzengw?=
 =?utf-8?B?UnluSlhPbmVTNE93VUxkZW9iZ042OVpPcXhQNVdKc1VvcGU1ZlVVcGpyeDVS?=
 =?utf-8?B?N2xkUDBkVnAwQW0vbXgzQU1adGJhTlJ4VnFlWDMrQ2gvL1F4OTVrREN1MGg0?=
 =?utf-8?B?SXIyeHNtd3pqQTM4OHNLL0xZam4xSVc0R3I1Y2JMMW5yMWZISUJVY0hvSENG?=
 =?utf-8?B?UlZSdFJ6SmNtZzBkWHZyd0JXYzk4VTEwb25IYUtWdHltcjQxdXllNW5FM2M3?=
 =?utf-8?B?S0F0dzNLVkRPODVmRWQ4bVNuK0RsTS9xVVFUMTJBZmpCMGxJODFtKzhBaFhQ?=
 =?utf-8?B?T2pQb0xXWFRqZVpuMXowWUVIR3c1WFRLZ0tobHk0c2YzZ0Jic1JxdGZMNm43?=
 =?utf-8?B?T00vUzg0TDBoalhaN3pGYVlDcVFkeDhsV2FlKzB1K2szYk8rWFAvNVhmY1Iz?=
 =?utf-8?B?ZSttZllpV1UyQS9YbjZjdXVKZ1NIMG1waXNER1Z3T0lrd0Ivd3lRM3V3UFh1?=
 =?utf-8?B?eXJublF3Y0IxVzcxcSs4YURURlJvRXZJNlN4SGp0QS9GZU1QbFNjSVZXM1Zh?=
 =?utf-8?B?R2pidjQ3Q0VKKzEvREtzc1dBd1VZUVpHSTQ0SUJTT3h4TDhGcExFVWo3akRL?=
 =?utf-8?B?VDRjMWhKWVV5Y0xYWE5QWjVjY2FlalRCd0M3RXh5NUdHdHFMajc2NGRveU9T?=
 =?utf-8?B?UlhUTnkrdFlSTGxvcnR6SWRxcjNoZ1pCdkl0YnBFRUtYSm16cWNJZzcwQjVs?=
 =?utf-8?B?azhPc01yY0FIYjlhbEdXQTZpYStwM2Z0M3BEallxQkVsbHNLZGx6elBnL0RT?=
 =?utf-8?B?K2JNUzJUQW1jc2wwamRhNlA1bGJaQ0JST0s2K3NhOEVMbTNjeCtUWVB1WEND?=
 =?utf-8?B?dmFaakhRVmFHd3B6dWRHenZJSi9Jb1A3Y1pBNkZ0bUNKL2MzM1M1WVJKeVZB?=
 =?utf-8?B?MXUzYlhIV3llZ05BWVVrd1dFT1U0clZzODVoc09ERWxWVStxT21YUXBtVWlV?=
 =?utf-8?B?Vnhsd3hDejdoeE05VjFCdElXMFJOM0IrSmF1ei9MMlBpdC9aRmVvTE1XSGIv?=
 =?utf-8?B?RjJ4YStaZCtSVVdyLytNTE5adkJsNGJDdWhrTWd1WGtZY2RLbzFwak5aZU5m?=
 =?utf-8?B?NjdGbTFJSE1hT29MZzc5ZldPQkZJSGx4ZE9najVxQ0pnRktBWkE3VGFZZXZa?=
 =?utf-8?B?Z3dxT05yQXdvNDFaeE1aU2Mwa2k1QUloQWdaa3hDVnh6azAzWXBONGk1ekJP?=
 =?utf-8?B?R00vaHZKeTJmTXpPdlNDdHhYQkRDeDBqdTlrSER2dlJoa2luWEsyRnBNOGVh?=
 =?utf-8?B?RjBTWldnNnU1R3l2eURzaHBCdG9hQnN0STVRUEhCTHNqcFh6aS9ibWdyZ1ov?=
 =?utf-8?B?RWtQSzFpdzhMK2c1S1pPbThUaHcrUGQvMk02WHpLQzJtWld2czBWQjN0ZUQv?=
 =?utf-8?B?cS9kVkpna243TmNrbWdCbGhvOVhjMGlHSGdyTk93T0NNRzhpS3Frb1A0Q0Qr?=
 =?utf-8?B?QlNnYjlDSFJmWU5FMWdGeEsweHNhcHZQRnlQNFdOS3dPRTQrNEp2UW5oeUtj?=
 =?utf-8?B?UG1QNGFtSmRHYXZNb1BFb0ZtL3R2VSswTHpUSUx3aWcyUkUyN2RKNFQzWlVB?=
 =?utf-8?B?SmpITHZPYVBJVkFMWFU5Q0NoU3hybEVzV1RVcERNM0ZJMitDU2VrMXZzZ3lK?=
 =?utf-8?B?dFhTaHhDVitJRzFTVTZuTEdPVzZWdFprSmFDeURrM0JQZnk5MjJDZ29RZlg3?=
 =?utf-8?B?Z0hJTWZOL2RISFNOZEpwWERHN3lKTk9iWnF5RmJub25FUnJWTGN2TEllcDhX?=
 =?utf-8?B?SWxrZlQxUWdCam9LTE5sY0ovTHNIOUF6TVdLUnNBMFV2Ujh1M2diOHNjV2pR?=
 =?utf-8?B?b0JuM3FyMUEwVmVLbld4R2NpcFJ4SDNoWm1iTU5OMktmWkVybmZmOUpCYmlV?=
 =?utf-8?B?REc3ZWFyQ0JrYWpFaDB2OCtsMEZaTjVRQTg5RThxY2plbGJOTGVtUC90UFZP?=
 =?utf-8?B?YUhYZkVQWCtuYjZ0S2tZQ2lTTll0QUxIWW5lcFhOb2RoNjMwYkFteEhONVJp?=
 =?utf-8?B?aUM5anVTdFB4UGQzZXZoTkV0V2xHblYzNFV0d2hXbG5sbEJMKzc4NmVyYXJs?=
 =?utf-8?B?eXNNSDNHekh4ZGZCTVI2Sk11SU9sMktQREJldWh4UVRSVnFSUnN1VDV3eEZn?=
 =?utf-8?B?dGJZWGw3VkV3dzRzMGk4cVBiU2t4TTVIbFFFT2JZaWt3YWt1L0YwUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9660ff-f5f1-44aa-a419-08df00449268
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 11:57:42.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayoeznN5jgdtwRSHDVBmnuKc3BoNIBVPGRwfsh8SIa5Yl0nANFDie/l6tjplLHOa/cjUrRNHcmtsKTkfR28qlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9101



On 8/22/2026 2:55 AM, Andrii Nakryiko wrote:
> On Thu, Aug 20, 2026 at 8:51 PM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>>
>>
>> On 8/21/2026 8:10 AM, Eduard Zingerman wrote:
>>> On Wed, 2026-08-19 at 17:04 +0800, Fuyu Zhao wrote:
>>>
>>> ...
>>>
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>>>> @@ -0,0 +1,196 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +#include <test_progs.h>
>>>> +#include "kmod_btfs.skel.h"
>>>> +
>>>> +static bool btf_skipped;
>>>> +static bool dup_ignored;
>>>> +
>>>> +static const char btf_skip_fmt[] =
>>>> +    "libbpf: skipping module BTF '%s', not in kmod_btf_names\n";
>>>> +static const char dup_ignore_fmt[] =
>>>> +    "libbpf: duplicate kmod BTF name '%s' ignored\n";
>>>> +
>>>> +static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
>>>> +                       va_list args)
>>>> +{
>>>> +    if (!strcmp(fmt, btf_skip_fmt)) {
>>>> +            if (!strcmp(va_arg(args, char *), "bpf_test_no_cfi"))
>>>> +                    btf_skipped = true;
>>>> +    } else if (!strcmp(fmt, dup_ignore_fmt)) {
>>>> +            if (!strcmp(va_arg(args, char *), "bpf_testmod"))
>>>> +                    dup_ignored = true;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>
>>> Idk what Andrii would say about this, but I'd rather add an internal
>>> function akin to:
>>>
>>>   size_t bpf_object_btf_module_cnt(const struct bpf_object *obj);
>>>
>>> in libbpf.c and expose it via libbpf_internal.h (*not* via API),
>>> instead of intercepting log messages.
>>>
>>> ...
>>
>> I think your suggestion is better. It also addresses the issue raised by
>> the bot about potentially hiding other libbpf logs. I'll wait for Andrii's
>> feedback on this.
>>
> 
> I would do neither and just not validate explicitly that we skipped
> (or not) some module. Instead, I'd see if it's simple and maintainable
> to do a functional test: try to attach to a func or have relocation
> fail against a type of a test module you explicitly do not allow to
> load. If that succeeds, bad. Also have positive and negative tests to
> show this custom kernel module list makes a difference as promised.
> 
> And try to keep the boilerplate to a minimum with all this, don't go overboard.
> 

Ah, this looks like a better approach. I'll follow your suggestion while
keeping the tests minimal.

Thanks,
Fuyu

>> Thanks,
>> Fuyu
>>

