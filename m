Received: from mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526C3264E7
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 03:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567362; cv=none; b=bpvSmTEwTIcwDovb6SJ5qW0F+PKQihqJEgdFvMKDTh0U0vK1YveBZl+VrJUjMphe6U90HmGRNW7NAcQ0aeRIiVRF8s4ae5+OeCL9TlGntR2zWX/+Tm9kBxhSyy5wo1iFfQEpMFVSmzBpApzSb7CmU9dIihBPTzNAYZpw7ea2dHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567362; c=relaxed/simple;
	bh=Yo/VcYLp4bbr08J+bHs3739Ca0M3LK+rLS/Dh7LQJGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io634Rka7viFs+ACTQ8p7pojbnr21QCVI+3V7a8+rVfhTrQgAa27SpIiCZs3281UPjWLgxQmYejgd2x8A0JDjkFsT8PG6ZNqDrEiwohItmJs+Y86ryVuoj55bdbs3UHqLac88yikZiJN5ABQnPYhoOiV+ng1zYj+ZTD0Zv+HVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mCiS+Fgc; arc=none smtp.client-ip=95.215.58.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mCiS+Fgc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Yo/VcYLp4bbr08J+bHs3739Ca0M3LK+rLS/Dh7LQJGU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790567357; v=1; x=1791172157;
 b=mCiS+FgcxaRd5DZlv+rknCQBRoNKI9/8qw27Fu/SvmuwKbjj7yvZpM1q4kWil87uzYr9Pn+c
 fL4k0aE9YbRzosfXiCLFgG/DNRz3YNNwFEwr4zYNSBspVe3ylYAS2cTaEnRT8kQrd5zsGD8zpNk
 6e788GMRdShaTtxAFMEBHBPM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a3cb099de9170291;
	Mon, 28 Sep 2026 03:49:17 +0000
X-Mizu-Trace-ID: a3cb099de9170291
X-Migadu-Flow: FLOW_OUT
Message-ID: <6018bb70-ed67-4ad3-a448-a06af1677f56@linux.dev>
Date: Sun, 27 Sep 2026 20:49:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 20/21] selftests/bpf: Cover the exception
 cleanup shapes the chain does not reach
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260926050148.2222810-1-yonghong.song@linux.dev>
 <5c23637cc1ccedfd0f1487b3a623608ca1356f4569c8bb5d0bd91a59c2a30cff@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5c23637cc1ccedfd0f1487b3a623608ca1356f4569c8bb5d0bd91a59c2a30cff@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/27/26 1:40 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/testing/selftests/bpf/exceptions_cleanup.h
>> index d1d40314035e..49b6806cde82 100644
>> --- a/tools/testing/selftests/bpf/exceptions_cleanup.h
>> +++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
>> new file mode 100644
>> index 000000000000..37a78e035a50
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
>> @@ -0,0 +1,665 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +#include "exceptions_cleanup.h"
> [ ... ]
>
>> +/* The callee most of the shapes below unwind out of. */
>> +static __used __noinline __u64 pc_unwinder(__u64 x)
>> +{
>> +	if (x > 100)
>> +		bpf_unwind();
>> +	return x + 1;
>> +}
> [ ... ]
>
>> +/* A callee on both a covered and an uncovered call: the pad is the site's. */
>> +static __used __noinline __u64 shared_callee(__u64 x)
>> +{
>> +	if (x > 100)
>> +		bpf_unwind();
>> +	return x + 1;
>> +}
> This isn't a bug, but shared_callee() looks the same as pc_unwinder().
> Could the shared-callee shape call pc_unwinder() from both sites, or
> could wide_rec_frame() use pc_unwinder() so that shared_callee() is left
> to the one shape its comment describes? And should the 'most of the
> shapes' comment on pc_unwinder() be narrowed to match its three callers?

Okay, will remore shared_callee and just use pc_unwinder() then.

>
> [ ... ]
>
>> +/*
>> + * A covered bpf_unwind() the sweep leaves last, behind the exception callback
>> + * patchlet, which has to carry the marks with it.
>> + */
>> +SEC("?syscall")
>> +__success __set_global(input, 101) __retval(0)
>> +__ret_global(pads_ran, RAN_PAD_FIRST)
>> +__naked int entry_pad_first(void)
>> +{
> This isn't a bug, but is 'exception callback patchlet' meant to be the
> exit that bpf_exc_keep_exits() puts back after bpf_unwind()? If so,
> could the comment name that instead? This program never sets up an
> exception callback.

This is a mistake for comments. Will fix.

>
> [ ... ]
>
>> +/* A pad that indexes its frame by a register set before the unwinding call. */
>> +
>> +/* An unwinder that touches none of r6-r9, so the walk leaves this frame. */
>> +static __used __naked __noinline __u64 var_unwinder(void)
>> +{
>> +	asm volatile (
>> +	"if r1 < 101 goto 1f;"
>> +	"call bpf_unwind;"
>> +"1:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	::: __clobber_all);
>> +}
>> +
>> +static __used __naked __noinline __u64 var_stack_frame(void)
>> +{
>> +	asm volatile (
>> +	"r1 = %[magic] ll;"
>> +	"r1 = *(u64 *)(r1 + 0);"
>> +	"*(u64 *)(r10 - 8) = r1;"	/* the slot the pad will read... */
>> +	"*(u64 *)(r10 - 16) = r1;"	/* ...whichever of the two it is */
>> +	"r1 = %[input] ll;"
>> +	"r6 = *(u64 *)(r1 + 0);"
>> +	"r6 &= 1;"			/* an unknown slot number... */
>> +	"r6 <<= 3;"			/* ...as an aligned byte offset */
>> +	"r1 = %[input] ll;"
>> +	"r1 = *(u64 *)(r1 + 0);"
>> +"1:"	"call var_unwinder;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"r7 = r0;"
>> +	"r1 = r10;"
>> +	"r1 += r6;"			/* variable offset into the frame */
>> +	"r2 = *(u64 *)(r1 - 16);"
>> +	"r3 = %[magic] ll;"
>> +	"r3 = *(u64 *)(r3 + 0);"
>> +	"if r2 != r3 goto 9f;"
>> +	PAD_RAN("%[ran]")
>> +"9:"
>> +	"r1 = r7;"
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	:
>> +	: [ran]"i"(RAN_VAR_STACK), __imm_addr(input), __imm_addr(magic),
>> +	  __imm_addr(pads_ran)
>> +	: __clobber_all);
>> +}
> [ ... ]
>
>> +/* The same over a global subprogram, which the verifier enters no frame for. */
>> +__noinline __u64 global_unwinder(__u64 x)
>> +{
>> +	if (x > 100)
>> +		bpf_unwind();
>> +	return x + 1;
>> +}
>> +
>> +static __used __naked __noinline __u64 global_pad_frame(void)
>> +{
>> +	asm volatile (
>> +	"r1 = %[magic] ll;"
>> +	"r1 = *(u64 *)(r1 + 0);"
>> +	"*(u64 *)(r10 - 8) = r1;"
>> +	"*(u64 *)(r10 - 16) = r1;"
>> +	"r1 = %[input] ll;"
>> +	"r6 = *(u64 *)(r1 + 0);"
>> +	"r6 &= 1;"
>> +	"r6 <<= 3;"
>> +	"r1 = %[input] ll;"
>> +	"r1 = *(u64 *)(r1 + 0);"
>> +"1:"	"call global_unwinder;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"r7 = r0;"
>> +	"r1 = r10;"
>> +	"r1 += r6;"
>> +	"r2 = *(u64 *)(r1 - 16);"
>> +	"r3 = %[magic] ll;"
>> +	"r3 = *(u64 *)(r3 + 0);"
>> +	"if r2 != r3 goto 9f;"
>> +	PAD_RAN("%[ran]")
>> +"9:"
>> +	"r1 = r7;"
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	:
>> +	: [ran]"i"(RAN_GLOBAL_PAD), __imm_addr(input), __imm_addr(magic),
>> +	  __imm_addr(pads_ran)
>> +	: __clobber_all);
>> +}
> This isn't a bug, but global_pad_frame() looks nearly identical to
> var_stack_frame(), and pad_r0_frame() repeats the same pad body. Could
> these share a macro, the way LOAD_MAGIC_REGS/CHECK_MAGIC_REGS are shared
> earlier in the file, so each variant only spells out the part it is
> testing?

Yes, it is better indeed.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430

