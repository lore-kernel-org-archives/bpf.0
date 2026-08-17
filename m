Received: from mta1.migadu.com (out-153.mta1.migadu.com [95.215.58.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACEC4B04A3
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939192; cv=none; b=P5ZUe86g1rqCQgx8HWqNcTlIdfBrJG60Et522dU4BwzT+8J7PQsVtPBQEfnsOFNAFtAWwZtPjtY2WHI9iR5HiJDbB1G9DuC7LEauRGqOSjyQkoEgt4TpAxe4GYP3elARVrZIxCQvW0IuJXi3LAie1vv6P/Nh1iOzXXNLtnbnY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939192; c=relaxed/simple;
	bh=fLRNTWNklq+ozKzNQo8RlsPT0lomv0kOHXfs9G73gjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdXFItx3Sw6WnK+UDnkvue7ZzFa22Hgy2cogFIrgldne4qs8reZNkgd4lvKh9mA5nUIy7BUK6YpXjplXtvLWHKit+lunG91yyrLkbzt75XTVaXgJKEoNXCNNkiIkfxIjC/lEJsFBg5D2D0HuCjYTOJhf9F7lDVwXQ2mD0M8y6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DAXMO9et; arc=none smtp.client-ip=95.215.58.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DAXMO9et"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fLRNTWNklq+ozKzNQo8RlsPT0lomv0kOHXfs9G73gjo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786939188; v=1; x=1787543988;
 b=DAXMO9etbt6vGzj3LSBzhodVLA/1B9D+B4QMhOuB7aVaE/F4ZNVICmXhDsWB02/Ka2WdBNG9
 M7uDc4+19+ugeVd2UIdgLTRt/joQfhHCNqC4N4vWERuvKb688ubuUlwhm4PDu4+V9AYX6dRBsn0
 zU0qdbxAPj7atoNL9kbyxIV4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id e28beba596f10f98;
	Mon, 17 Aug 2026 03:59:48 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e8b343d3-0bdc-43ba-b5a3-774c8d4dea10@linux.dev>
Date: Sun, 16 Aug 2026 20:59:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 10/11] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813200302.1997359-1-yonghong.song@linux.dev>
 <2d1e5764032f4f6e060a1a22d50531d330a603e668f98efaf5320b545ebfad99@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2d1e5764032f4f6e060a1a22d50531d330a603e668f98efaf5320b545ebfad99@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 2:11 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> index 979536f3c89c..c295adedbae8 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> @@ -4,10 +4,14 @@
>>   #include "aggregate_ret_int128_c.skel.h"
>>   #include "aggregate_ret_struct_c.skel.h"
>>   #include "aggregate_ret_kfunc_c.skel.h"
>> +#include "aggregate_ret_func.skel.h"
>> +#include "aggregate_ret_kfunc.skel.h"
>>
>>   void test_aggregate_ret(void)
>>   {
>>   	RUN_TESTS(aggregate_ret_int128_c);
>>   	RUN_TESTS(aggregate_ret_struct_c);
>>   	RUN_TESTS(aggregate_ret_kfunc_c);
>> +	RUN_TESTS(aggregate_ret_func);
>> +	RUN_TESTS(aggregate_ret_kfunc);
>>   }
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> new file mode 100644
>> index 000000000000..cfb21bcf704b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> @@ -0,0 +1,260 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
> [ ... ]
>
>> +SEC("tc")
>> +__load_if_JITed()
>> +__success __retval(0)
>> +__log_level(2)
>> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
>> +__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
>> +__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
>> +__msg("mark_precise: frame0: regs=r6 stack= before 2: (57) r6 &= 7")
>> +__msg("mark_precise: frame0: regs=r6 stack= before 1: (bf) r6 = r2")
>> +__msg("mark_precise: frame0: regs=r2 stack= before 12: (95) exit")
>> +__msg("mark_precise: frame1: regs=r2 stack= before 11: (b7) r2 = 4")
>> +__naked int aggregate_ret_static_precise(void)
> [ ... ]
>
>> +SEC("tc")
>> +__load_if_JITed()
>> +__success __retval(0)
>> +__log_level(2)
>> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
>> +__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
>> +__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
>> +__msg("mark_precise: frame0: regs=r6 stack= before 2: (57) r6 &= 7")
>> +__msg("mark_precise: frame0: regs=r6 stack= before 1: (bf) r6 = r2")
>> +__msg("mark_precise: frame0: regs=r2 stack= before 0: (85) call pc+9")
>> +__naked int aggregate_ret_global_precise(void)
> A subsystem pattern flags these two tests as potentially concerning.
> The aggregate_ret_static_precise() and aggregate_ret_global_precise()
> tests in the new aggregate_ret_func.c file are the R2 variant of
> behavior that tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> already covers: subprog_result_precise() and global_subprog_result_precise()
> in that file assert the same mark_precise log shape across the call/exit
> boundary for static and global subprogs. The two new tests differ only in
> which register (R2 vs R0) is being tracked, and in the final one or two
> __msg lines.
>
> This same commit did extend an existing file for its liveness test case
> rather than adding a new one (it added aux2() and subprog_ret_reg_pair()
> to compute_live_registers.c).
>
> Would it be more natural to add these two precision tests as new cases
> in verifier_subprog_precision.c, where a reader looks for precision-
> backtracking coverage? The rest of aggregate_ret_func.c (the __failure
> cases and the accepted pointer-pair case) is genuinely new-feature
> coverage with no existing home, so perhaps that part stays separate.

I don't have a strong opinion. But current file aggregate_ret_func.c
seems okay as well since there are some other returning R0:R1 tests.

>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
>> index d055fc7b3b95..0be9441ec273 100644
>> --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
>> +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
>> @@ -431,6 +431,36 @@ __naked void subprog1(void)
>>   		::: __clobber_all);
>>   }
>>
>> +static __used __naked unsigned __int128 aux2(void)
>> +{
>> +	asm volatile (
>> +		"r0 = 1;"
>> +		"r2 = 2;"
>> +		"exit;"
>> +		::: __clobber_all);
>> +}
>> +
>> +SEC("socket")
>> +/* A program observing the pair needs the JIT; see bpf_compute_subprog_ret_regs(). */
>> +__load_if_JITed()
>> +__log_level(2)
>> +__msg("0: .12345.... (85) call pc+2")
>> +__msg("1: ..2....... (bf) r0 = r2")
>> +/* R2 is not read at the exit of this program, which returns an int, ... */
>> +__msg("2: 0......... (95) exit")
>> +__msg("3: .......... (b7) r0 = 1")
>> +__msg("4: 0......... (b7) r2 = 2")
>> +/* ... but it is at the exit of aux2(), which returns a register pair. */
>> +__msg("5: 0.2....... (95) exit")
>> +__naked void subprog_ret_reg_pair(void)
> The changelog describes aggregate_ret_func.c covering "liveness at the exit
> of a subprogram returning a pair," but that test is not in that file.
> aggregate_ret_func.c has no liveness test at all - its only __log_level(2)
> tests match "mark_precise: ..." lines.
>
> The liveness-at-exit test is here, in compute_live_registers.c: aux2() and
> subprog_ret_reg_pair(), with the register-mask __msg expectations like
> "0: .12345.... (85) call pc+2" and "5: 0.2....... (95) exit".
>
> Conversely, the changelog does not mention the accepted-case test
> aggregate_ret_static_ptr_pair() in aggregate_ret_func.c (a static subprog
> legitimately returning a pointer in R2, whose result is then dereferenced),
> and it never mentions the aggregate_ret_kfunc.c / aggregate_ret_kfunc_c.c
> additions that make up roughly 180 of the commit's added lines. New kfuncs
> in the test module are the kind of addition a reviewer looks for in the
> changelog.
>
> Could the message be adjusted so that aggregate_ret_func.c's description
> matches what the file actually contains, the liveness test is attributed to
> compute_live_registers.c, and the kfunc side of the patch gets a sentence?

I think this is unnecessary. The code itself will show which files have
which tests.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277

