Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD830568B
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105056; cv=none; b=EnRg+wCsIYAUMq5Erb/pWjFDsKW8CMxDemcK2t+kFP7F7euWggkBSF2tKPTJ2texp4BarxG5lYXYmyExLx2KrdGSIzZ7cm49cvyXYAT/ZmoeEy66zJO7pnToOyXENSWvA4MhhLIylN3t/JVfHe/YGpVvuomwHXwoD/YnmVpimRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105056; c=relaxed/simple;
	bh=uamY+EXaVHr/3FC04Ra4Clq8F5JpZVLPHVRmXkkkLak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s31wri4U9Y+lD0m88WebJllvcnd/O4/ETyxcYmr4hxECkBO1sggByjX0pgCCTAUNrLbhXbnrB4+t2skQafnPr2H3gSbzJBv87VPi2C/7dGoDTNPVcn24Lxp+4DYAfZLPU2xvrTftD3rKdoUo4DMtqvxqLiUrEgjJ/lzcbVCe3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JBPTOHe6; arc=none smtp.client-ip=91.218.175.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JBPTOHe6"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uamY+EXaVHr/3FC04Ra4Clq8F5JpZVLPHVRmXkkkLak=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789105052; v=1; x=1789709852;
 b=JBPTOHe6vnQnrJec+xU8pNUV1HG3AW+EslaqyU0Xd7C2K122PeYU5sXCZAmcFaNRA2ctu5S+
 MHADL6CMU5AjxolC43lX/dempFNfyA33T8m/Z7q7j8SRYUdzL9mVLIKGaWk1RLDeHd+ZgteJyNR
 AVEjSffYb1Dw1Sbp6gGdi44Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b7a8002dbb4ef931;
	Fri, 11 Sep 2026 05:37:32 +0000
X-Mizu-Trace-ID: b7a8002dbb4ef931
X-Migadu-Flow: FLOW_OUT
Message-ID: <f4454509-b84c-4923-9983-11bc1518a4f8@linux.dev>
Date: Thu, 10 Sep 2026 22:37:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 11/12] selftests/bpf: Add inline-asm tests for
 by-value arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260909062621.4009625-1-yonghong.song@linux.dev>
 <14888dbc8203cddca1f5affa396a0620902c0104604e6eb8dfd9d4a0470b78fc@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <14888dbc8203cddca1f5affa396a0620902c0104604e6eb8dfd9d4a0470b78fc@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/26 12:30 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c b/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
>> new file mode 100644
>> index 000000000000..61dd5f86c3a4
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
>> @@ -0,0 +1,155 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +typedef unsigned __int128 u128;
>> +
>> +struct pair {
>> +	__u64 lo;
>> +	__u64 hi;
>> +};
>> +
>> +struct too_big {
>> +	__u64 a;
>> +	__u64 b;
>> +	__u64 c;
>> +};
>> +
>> +#if defined(__clang__)
>> +
>> +__noinline __u64 global_arg_pair(int a, struct pair p, int c)
>> +{
>> +	return (__u64)a + p.lo + p.hi + c;
>> +}
> [ ... ]
>
>> +#endif
>> +
>> +__noinline __u64 global_arg_too_big(struct too_big s)
>> +{
>> +	return s.a + s.b + s.c;
>> +}
> [ ... ]
>
>> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)
>> +
>> +__noinline __u64 global_arg_split(int a, int b, int c, int d, struct pair p)
>> +{
>> +	return (__u64)a + b + c + d + p.lo + p.hi;
>> +}
> [ ... ]
>
>> +#endif
> This isn't a bug, but would it help a later reader to carry the
> changelog's gcc-invisible-reference rationale into a short comment above
> the #if defined(__clang__), and to note why the last three cases need
> __BPF_FEATURE_STACK_ARGUMENT (and maybe label the two #endif closures)?

stack argument is implemented in llvm23, and that is why we want this
feature gating.

>
> The sibling file aggregate_ret_func.c documents its equivalent gate:
>
>    /*
>     * gcc returns a by-value struct through a hidden pointer, and emits the
>     * 'r0 = r1' returning it after the __naked body's exit, leaving the
>     * subprogram falling through. Build these with clang only.
>     */
>    #if defined(__clang__)
>
> and other progs files label the closing directive, for example
> verifier_ldsx.c uses #endif /* __BPF_FEATURE_ADDR_SPACE_CAST */.

This is fine. We do not want to have this comment in many places.
The commit message should explain this.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441

