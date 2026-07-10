Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D68834
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661761; cv=none; b=EXy8MdKCPNkiHdzyyXtOQEhsA5Rd/c3k8pfJXEIx4Cn+ZT0N5VcIIsoWaF+cHRjI5pHmsQ5AsPDBUduzQiqpog0+wJT/HhPFHv0yeOeAQczyQP8f+cMIrqwt+8eqI7VR75jeDU4I7jLBPCgww1qXfs5VpgQsbL/gGK0EJAVMRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661761; c=relaxed/simple;
	bh=qCxYpJMeJom+AbeYdLN3H8/0rt9pVsbaDX88VKLgb14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSOpYoBucT9ESWoePV9Y61StTdKeVdSACTpxlWG1QQajTX2uTGx1g8M6zPvtbdb790GD7rns9dCsWbgIioiLWq4VxCIBe/VOFANqt+Oqc8VFmSElsDz0GviZuJhpR1/wdK8dtGXMDNxcJF5epC1cEjKeSRBAYzn1N6/S/kjU02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rEyYMu7s; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rEyYMu7s"
Message-ID: <9ea6b6be-b368-4631-84e2-509c445df0cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783661757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHAOCS3Y1ojvrwUZYiZanpvDwGvEmv4DzJ80vsQc7Xk=;
	b=rEyYMu7sGWomlcADe5FoooF8UTjNzSfyqGrA56TdqeTC+G1cIGhJQ6PTSGM4WGHM9+fD9o
	Cd4e7+drkQGPCAtHuJeCpAPMDYV67a1qo4jRjED97Smz5hy8Y8gAZQHTxuY58PhBPPQapS
	O2HV84K2OW7mHa9LiX/yCC+uNYVhRwE=
Date: Thu, 9 Jul 2026 22:35:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: Add inline-asm and subprog
 tests for R0:R2 returns
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201030.2161016-1-yonghong.song@linux.dev>
 <6e8a7e39e2823970e7045585e6eed37bae3acf89.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6e8a7e39e2823970e7045585e6eed37bae3acf89.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 6:38 PM, Eduard Zingerman wrote:
> On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
>> Add inline-asm and subprogram tests for more coverage, including
>> BPF-to-BPF cases, kfunc cases, backtracking and liveness. Both positive
>> and negative tests are added.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> [...]
>
>> @@ -93,4 +97,25 @@ void test_aggregate_ret(void)
>>   		run_prog(skel_union_c->progs.aggregate_ret_union_c_test, true);
>>   
>>   	aggregate_ret_union_c__destroy(skel_union_c);
>> +
>> +	skel_run = aggregate_ret_run__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel_run, "skel_run_open_load"))
>> +		return;
>> +
>> +	/* Inline-asm variant: compiler-version independent, always runs. */
>> +	if (test__start_subtest("asm"))
>> +		run_prog(skel_run->progs.aggregate_ret_asm_test, false);
>> +
>> +	/* Struct-by-value kfunc returns, also compiler-version independent. */
>> +	if (test__start_subtest("struct"))
>> +		run_prog(skel_run->progs.aggregate_ret_struct_test, false);
>> +
>> +	/* Union-by-value kfunc return, compiler-version independent. */
>> +	if (test__start_subtest("union"))
>> +		run_prog(skel_run->progs.aggregate_ret_union_test, false);
>> +
>> +	aggregate_ret_run__destroy(skel_run);
>> +
>> +	RUN_TESTS(aggregate_ret_func);
>> +	RUN_TESTS(aggregate_ret_kfunc);
> This can be folded into tools/testing/selftests/bpf/prog_tests/verifier.c.
>
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> new file mode 100644
>> index 000000000000..31e176103374
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> @@ -0,0 +1,361 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +typedef unsigned __int128 u128;
>> +
>> +__naked u128 global_agg_good(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0x1234;"	/* low 64 bits */
>> +	"r2 = 0x5678;"	/* high 64 bits */
>> +	"exit;"
>> +	);
>> +}
>> +
>> +__naked u128 global_agg_bad(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"exit;"
>> +	);
>> +}
> C version of tests from a previous patch already checks global vs.
> local functions. I suggest dropping that version from C tests and keep
> in assembly only to reduce the duplication.
>
> [...]
>
>> +SEC("tc")
>> +__success __retval(0)
>> +int aggregate_ret_global_union(void *ctx)
>> +{
>> +	__u64 lo, hi;
>> +
>> +	asm volatile (
>> +	"call %[global_ret_union];"
>> +	"%[lo] = r0;"
>> +	"%[hi] = r2;"
>> +	: [lo]"=r"(lo), [hi]"=r"(hi)
>> +	: __imm(global_ret_union)
>> +	: "r0", "r1", "r2", "r3", "r4", "r5");
>> +	if (lo != 0x1234)
>> +		return 1;
>> +	if (hi != 0x5678)
>> +		return 2;
>> +	return 0;
>> +}
> And here I'd only keep the C version.
>
>> +__naked struct with_ptr global_ret_struct_ptr(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"r2 = 0;"
>> +	"exit;"
>> +	);
>> +}
> [...]
>
>> +static __naked u128 agg_callee(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 1;"
>> +	"r2 = 2;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__log_level(2)
>> +__msg("Live regs before insn:")
>> +__msg("0: .12345.... (85) call pc+2")
>> +__msg("1: ..2....... (bf) r0 = r2")
>> +__msg("2: 0......... (95) exit")
>> +__msg("3: .......... (b7) r0 = 1")
>> +__msg("4: 0......... (b7) r2 = 2")
>> +__msg("5: 0.2....... (95) exit")
>> +__naked int aggregate_ret_live(void)
>> +{
>> +	asm volatile (
>> +	"call %[agg_callee];"
>> +	"r0 = r2;"
>> +	"exit;"
>> +	:
>> +	: [agg_callee]"i"(agg_callee)
>> +	: __clobber_all);
>> +}
> Nit: usually we add such tests to compute_live_registers.c.

I can move the test to compute_live_registers.c.

>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
> I think the test cases in this file are by a large degree redundant.
> A single test case calling a kfunc returning a small struct and
> checking returned values would suffice.

Ack. I tried to test for both C and asm test cases. They are indeed some duplicates.
I will try to remove the redundant ones in next revision.

>
> [...]

