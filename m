Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372F418346
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319049; cv=none; b=C9XLT+2Xj07s3vF+5gvp+OzQQWYJavsc3d8uNznl2bcqhxMGgrAOAaWtyeK7PZ++IUakFFWYQtgwGKJXEBHomRAun80ggnzfP84yWmKeo15B8lwcVbVOdDq0svWXhiXYHkMo4DiLf12lBuO/R5ZrxNaYCSKexRZtyEOXgAxFVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319049; c=relaxed/simple;
	bh=FeczuV+9ClcSnOncLxw3rRRba2sQCUM4ISB+vlYw/Kk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cMD9GacIODjVDIfc/bf82ssrEsYtIMVrYVGpjnED/NuGS+zz4+ls/h/Gy1oNxzqExVcOnmqFHUAD0MU10PU2EVsbJ19egmf5ZHf2Hb42AaSxFqICFyAbFgtPDUUdORnSbwCLJh1proPBtfL5EPlo1KwpwTo11ajdjOLFYCufhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=k/YALPvV; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="k/YALPvV"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5g7Vk2889391
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:50:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=SoLl4/2lVJBvPujHbLJtwbrkfRJZIRRFViiE1
	2Jz6H4=; b=k/YALPvVgR/TKxq144tgRcN8g9UNo2A6PNmF2T1jvz/0tcK7k2QC7
	A8z7Xyabqyb0E1yRLJjpo1RW2SB3DP5EX197AT5h57HgXAUTqKvgZh5Vtcizu67z
	A7tmC2qlcU0bZTbxFnajaubK4Lu4C8M2s56PHS/32CyaxP6h5isJRhc5rWpEphr+
	8ydQ6DkBfwTdQhjQgBN4p32LWbQmlEpRH9NR/GcBs1jUsEQgExzVkiSXYy3BDHNT
	6/CgpForpfyOkPC6znAWbki5TBlADlGjfL9PrRUvw+gQJxsn2CgQaHVsGRMdLBj5
	JzgI3qoCT4wf9CEAL5sr27As4AqcAqIeQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gwchftqhc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:50:45 -0700 (PDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-342138eeff2so219843eec.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790319045; x=1790923845;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:newsgroups:cc:to:subject:user-agent:mime-version:date
         :message-id:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SoLl4/2lVJBvPujHbLJtwbrkfRJZIRRFViiE12Jz6H4=;
        b=rcD/AIKX1SiJrOfv7EAXbbfogMs2ujrUXqMUbwJ8TndyVYLUvR8boXjG81Xs/v4JMs
         lfvN2tiO0uMawoYlll4881V5uTzr1DgOGdavJ5hsaKeCkmCRdrCNJbDA2iVBb4HRV1Le
         BjRMWoEnNABJAISANvVhf8LeUKldCe4BRo+OpDLI7KqEDOXf3RrIpAOlVk+++KFt6W3A
         QNbF0DHfe40qJoDBt3ERpcsDAoP4nYrckyENkxQu2paKO0CZtE+HQWIDw9BvQMYpIRXX
         IwCmwxXCNAW/MpYMcE1PB5kGzdsfbLgK1STJ1dHqGmGoBTHqhFZu1daJDNDbDRtHzkNx
         kJDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdAhYGffCkpqoPBxz9EDyCXR+kBsQTy5VQouL9zp2KcQMWsNVCX7TnYG9naF1B3KhVXN8=@vger.kernel.org
X-Gm-Message-State: AFuF++lHWqyYznNDRCj5Yi6GvWCyph+RhisLnljsyOZ5rR4LW+urx6aA
	AYTM7NiQY/P3qZnPJwQFuhrs3B8n80jKF3MzTOHgImIkGW4vKzKJruhZGUaEzaMuJQ7mgM1hXYK
	nW0sUc8el0QzXb8SWkCZkybiJFMzFju3LRnAjydU11CGR5KxPBfvX
X-Gm-Gg: AYBFou1J+Ycg1ykeRTWClqJbZszra2zGHX8WY6uZqe/GQhzs3DPEYNPKCv1dVdLGb4e
	dfZwFyvYbEscN3e7AGLqdLwhWUu4b4/vPkbuwYj8PZDrxdLyIrSuHOosvzEF9YLfKS8QczRQAmq
	Nqa+GAkUxbLS+7O9c3XqLjiPecmpRr1TdWowecuK3bV+TODZvFs0t9+9Nxs5B8bdcY8OyS5o7O2
	3xSNo55C/q868WTONSNjpBrA/s7Teb1yMrpbLqSkwWekiXvztiHSwltMVAz0CHpngXHgvoW4YgZ
	6IHZ0wACs57P8qqxk4a4yr627jFoWl2x86B+nZ2kfFCr7VlLK0H83baEzhfE8PvjI7MwrU/XTzF
	W5DsYwuze22ImJ8YNFQd9MnHM6pu3D9vLC33NGxcCFtj1PBl4
X-Received: by 2002:a05:693c:6205:b0:338:5bf5:d005 with SMTP id 5a478bee46e88-3400687e8ddmr4118593eec.28.1790319044631;
        Thu, 24 Sep 2026 23:50:44 -0700 (PDT)
X-Received: by 2002:a05:693c:6205:b0:338:5bf5:d005 with SMTP id 5a478bee46e88-3400687e8ddmr4118563eec.28.1790319043816;
        Thu, 24 Sep 2026 23:50:43 -0700 (PDT)
Received: from [192.168.50.189] (c-67-169-75-212.hsd1.ca.comcast.net. [67.169.75.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141d2fe4bsm4388392eec.4.2026.09.24.23.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 23:50:43 -0700 (PDT)
From: Vineet Gupta <gvineet@meta.com>
X-Google-Original-From: Vineet Gupta <vineet.gupta@linux.dev>
Message-ID: <19cc4e99-2351-4d8c-8edd-918eaf857d5f@linux.dev>
Date: Thu, 24 Sep 2026 23:50:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of callx tests with GCC
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com
Newsgroups: gmane.linux.kernel.bpf
References: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
Content-Language: en-US
In-Reply-To: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LshvPE_GqTs4HEtOCVlO3JugL3-5IdBl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX1zbExlEbOGhy
 ipj+ylmOk7d2G94O8lv19Pr2D6F9jkIVGaG+dG/uanhjO0FswIA50PKONNuFfmZML9LJ+mW7wi9
 T7/ro/1KShraynITDnlb/2xWuke1fwY=
X-Authority-Analysis: v=2.4 cv=Ccedd7rl c=1 sm=1 tr=0 ts=6ab619c5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=SXzd9FIucRRoOwGiyxtD8g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8
 a=L9PcOtYBBTW8Szr461wA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX2fy/W5n37VDh
 XuO1zZI6gaHFgAuhOWttpVEmOxVNidDGnackQZ6HuWlecy1SQdNOv7Erdk5N6PCIVVE2Aszn3gz
 Qwp8KBbb5E/l+ntfD04MDFQFOiMGXpbQhkRcbbgMEkhZXmUo+oCziMclvz7ZOu34HHRfGcEIw3p
 KFyiIXbHtiea5Cb+iSEOk4kHKAIApFoLYGo95UHhVGgzh9ZN8dJSofXBZ8sl3thbQpcAh3cfVhI
 iRzQOOGZfKH1Yw08xaMTFaewjDBGxjoppJtZ+9ZCvCVTkbQrVXVO4bGtx+pEW1T/LJ5rPPDLJ05
 Vet9igfA9jjkBrbH02QCKBi5EuS8rnfEP9cbrUlyaoIAGwzggeUTPX/rf5IR+Abn9r5skVlOS0Z
 ovvvGKOvoxgL3RO43k0gmWMlBtQNNgEQIVsJ47JFptbLIVlOaW8rRB+OtN7gF0/vP16SU8rAorl
 Je1blSUfWYYS0woRS2w==
X-Proofpoint-GUID: LshvPE_GqTs4HEtOCVlO3JugL3-5IdBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01

On 9/24/26 11:21 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> GCC doesn't support indirect calls in BPF:
> 
>    progs/verifier_callx.c: In function 'apply_op':
>    progs/verifier_callx.c:977:1: error: indirect call in function, which are not supported by eBPF
>    progs/verifier_callx_rodata.c: In function 'use_shape':
>    progs/verifier_callx_rodata.c:746:1: error: indirect call in function, which are not supported by eBPF

GCC supports them under -mxbpf but unfortunately even that is broken.


> Build verifier_callx, verifier_callx_rodata and callx_rodata progs
> with clang only. Skip callx_rodata_lskel test when progs are built
> with GCC.

Can we do this slightly differently.
Following on same theme have been queued up in bpf-next

2026-08-24 48b69cc8825d selftests/bpf: Enable some of the blocked cpuv4 
instruction tests for bpf-gcc
2026-08-24 8928f5ffdb65 selftests/bpf: Report placeholder tests as SKIP, 
not OK
2026-08-24 b0eeb9e0f548 selftests/bpf: Name the remaining placeholder 
programs dummy_test

> 
> Fixes: e9b22d50796d ("selftests/bpf: Add tests for callx")
> Fixes: b018e998e645 ("selftests/bpf: Add tests for callx through pointers in read-only data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   .../bpf/prog_tests/callx_rodata_lskel.c       |  6 ++++
>   .../selftests/bpf/progs/callx_rodata.c        | 28 +++++++++++++++++--
>   .../selftests/bpf/progs/verifier_callx.c      |  3 +-
>   .../bpf/progs/verifier_callx_rodata.c         |  3 +-
>   4 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> index 96f6179f0492..6a43b880d730 100644
> --- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> @@ -35,6 +35,12 @@ void test_callx_rodata_lskel(void)
>   	if (!ASSERT_OK_PTR(skel, "open"))
>   		return;
>   
> +	/* gcc doesn't support indirect calls */
> +	if (skel->rodata->skip) {
> +		test__skip();
> +		goto out;
> +	}
> +

We now have common skipping machinery using __skip, see further below.

>   	skel->rodata->bias = 7;
>   
>   	if (!ASSERT_OK(callx_rodata_lskel__load(skel), "load"))
> diff --git a/tools/testing/selftests/bpf/progs/callx_rodata.c b/tools/testing/selftests/bpf/progs/callx_rodata.c
> index 07ae2d1b6b8e..e3f8335f80f8 100644
> --- a/tools/testing/selftests/bpf/progs/callx_rodata.c
> +++ b/tools/testing/selftests/bpf/progs/callx_rodata.c
> @@ -1,16 +1,21 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* callx through pointers to functions in .rodata, loaded by light skeleton */
>   
> +#include <stdbool.h>
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
>   
> -typedef int (*op_fn)(int);
> -
>   /* set by user space before the programs are loaded, it's in .rodata too */
>   const volatile int bias = 1;
>   
>   int op_idx;
>   
> +#ifdef __clang__

It unfortunatete that this doesn't have a compiler feature test macro 
__BPF_FEATURE_* in clang or gcc. It seems we have existing 
CAN_USE_BPF_ST and CAN_USE_GOTOL, maybe we can define CAN_USE_CALLX in 
bpf_misc.h and use that as a gate, keeps one place for all such 
__clang/gcc workaround definitions instead of them scattered all over. I 
have a few pending patches which clean things up.

> +
> +const volatile bool skip = false;
> +
> +typedef int (*op_fn)(int);
> +
>   static __noinline int add_bias(int x)
>   {
>   	return x + bias;
> @@ -41,6 +46,25 @@ int both_ops(void *ctx)
>   	return ops[1](ops[0](4));
>   }
>   
> +#else
> +
> +/* gcc doesn't support indirect calls */
> +const volatile bool skip = true;
> +
> +SEC("socket")
> +int select_op(void *ctx)
> +{
> +	return 0;
> +}
> +
> +SEC("socket")
> +int both_ops(void *ctx)
> +{
> +	return 0;
> +}
> +
> +#endif
> +

This can be rewritten using exising skipping machinery as shown in 
bpf-next patch: 8928f5ffdb65 ("selftests/bpf: Report placeholder tests 
as SKIP, not OK")

#ifdef CAN_USE_CALLX

llvm_code

#else
__skip("gcc doesnt support callx")
int dummy_test(void *ctx)
{
     return 0;
}
#endif

This avoids the explicit skipping logic.

>   /* no callx here */
>   SEC("socket")
>   int read_bias(void *ctx)
> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
> index ea3d3f97da31..bc31d0221f6a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_callx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
> @@ -6,7 +6,8 @@
>   #include "bpf_misc.h"
>   #include "../../../include/linux/filter.h"
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +/* gcc doesn't support indirect calls */
> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && defined(__clang__)
>   
>   #define CALLX_INSN(DST, SRC, OFF, IMM) \
>   	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, DST, SRC, OFF, IMM)
> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> index 65d34769c8bf..db3169a1ddf6 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> @@ -6,7 +6,8 @@
>   #include "bpf_misc.h"
>   #include "../../../include/linux/filter.h"
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +/* gcc doesn't support indirect calls */
> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && defined(__clang__)

Instead of __clang scattered all over, CAN_USE_CALLX in bpf_misc.h so 
its one stop shop to clean things up in future.

BTW this is

Thx,
-Vineet
