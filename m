Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F799344DBD
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789232846; cv=none; b=eyaPeqmok5tnKIF+2eXk12CTtw8CH0dxxPIeCHnnhY6tcW4bnB38rrR/2s+ILk+78Nq5yo3+5cisC+3tFpykKbcOhxfbec1CctBRb2IQnEMtLS2TfR6y4BCjZ2/jPqUvlfjmS1EH/UGJAEZfoJO6mAVwwneayJMTEUYhXD6sI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789232846; c=relaxed/simple;
	bh=oY44/fejyNqCEamb5L+LP/THGG5yIDG+mSfjlPh3E7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZBnlD+GE4NC7GWuVvlya6pnafkoh1xhzqtDouCBN1LB8XFs8To23HHVPxlh65f2wPvUnlkm7vIoRFmW6Mmuk3W5t4Nzv8uyupnEjTF8oJqNraoNVeZ8LsB2yGYiT4G13N3rljGTw95mvnvLicWne6MKALExDUxDW51+jXFXk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Og2v8nwa; arc=none smtp.client-ip=91.218.175.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Og2v8nwa"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oY44/fejyNqCEamb5L+LP/THGG5yIDG+mSfjlPh3E7s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789232840; v=1; x=1789837640;
 b=Og2v8nwaaFargKK9w5VzkZfYJNou52X32rBIbtJpdmNE6VbzyD/zqQ1S+CbyQB/fIjAyazQN
 NnGvZ9FDZXbu7cG9BQlloayQZFJpf5jMDam5FYaiWsgflJnFS2ULi/VZjRRydzG4uRFROLWg5Hd
 K4AOOjYLQ7ZtwfkLoEwQQ/8A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 21a51625be3e3dea;
	Sat, 12 Sep 2026 17:07:10 +0000
X-Mizu-Trace-ID: 21a51625be3e3dea
X-Migadu-Flow: FLOW_OUT
Message-ID: <b2ad4fe4-6c25-4614-b07c-8f078d81e455@linux.dev>
Date: Sat, 12 Sep 2026 10:07:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 02/15] selftests/bpf: Add a test for an
 __int128 by-value argument
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260911154924.2005771-1-yonghong.song@linux.dev>
 <034515b18553e09288479d75768b362839532503a5ca15889c035acdcdf41b06@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <034515b18553e09288479d75768b362839532503a5ca15889c035acdcdf41b06@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 9:47 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> index f7f94ccebce2..3c7ded537314 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> @@ -5,6 +5,7 @@
>>   #include "arena_kfunc.skel.h"
>>   #include "arena_kfunc_jit.skel.h"
>>   #include "cap_helpers.h"
>> +#include "verifier_aggregate_arg.skel.h"
>>   #include "verifier_aggregate_ret.skel.h"
>>   #include "verifier_align.skel.h"
>>   #include "verifier_and.skel.h"
>> @@ -171,6 +172,7 @@ void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
>>
>>   void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
>>
>> +void test_verifier_aggregate_arg(void)        { RUN_TESTS(verifier_aggregate_arg); }
>>   void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret); }
>>   void test_verifier_align(void)                { RUN(verifier_align); }
>>   void test_verifier_and(void)                  { RUN(verifier_and); }
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c b/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
>> new file mode 100644
>> index 000000000000..d90f754396d0
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
>> @@ -0,0 +1,40 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +#define MIX_A	0xdeadbeefcafef00dULL
>> +#define MIX_B	0x0123456789abcdefULL
>> +
>> +#ifdef __SIZEOF_INT128__
>> +
>> +typedef unsigned __int128 u128;
>> +
>> +__noinline __u64 take_i128_global(int a, u128 v, int c)
>> +{
>> +	return (__u64)a + (__u64)(v >> 64) + (__u64)v + c;
>> +}
>> +
>> +SEC("tc")
>> +/*
>> + * The verifier counts one argument register for the __int128 and marks only
>> + * R1 through R3 at the entry of take_i128_global(), while the compiler passed
>> + * a in R1, v in R2:R3 and c in R4.
>> + */
>> +__failure __msg("R4 !read_ok")
>> +int aggregate_arg_int128_c_test(struct __sk_buff *skb)
>> +{
>> +	__u64 a = skb->len ^ MIX_A;
>> +	__u64 b = skb->len ^ MIX_B;
>> +	u128 v = ((u128)a << 64) | b;
>> +
>> +	if (take_i128_global(1, v, 2) != a + b + 3)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +#endif /* __SIZEOF_INT128__ */
>> +
>> +char _license[] SEC("license") = "GPL";
> A subsystem pattern flags this as potentially concerning: every program
> in the new file is wrapped in '#ifdef __SIZEOF_INT128__' with no '#else'
> branch.
>
> When a BPF compiler does not define __SIZEOF_INT128__ (for example, when
> building with bpf-gcc via BPF_GCC=1), the generated verifier_aggregate_arg.bpf.o
> contains no programs at all. The skeleton still compiles because bpftool
> guards maps/progs/links members on their counts, but test_loader__run_subtests()
> then iterates zero programs and test_progs.c reports the test as passing with
> no indication that the __int128 coverage was compiled out.
>
> Every sibling prog file in progs/ that wraps all of its tests in a feature
> #ifdef adds an '#else' dummy carrying __description()/__skip() so the result
> is a visible SKIP instead. For instance, verifier_aggregate_ret.c (from the
> same series) includes such a dummy at lines 167-175 with the message "needs
> LLVM 23, dummy test". The same pattern appears in verifier_gotol.c,
> verifier_bswap.c, verifier_ldsx.c, verifier_movsx.c, verifier_sdiv.c,
> verifier_private_stack.c, verifier_stack_arg_order.c, verifier_load_acquire.c,
> verifier_store_release.c, arena_kfunc.c, stack_arg_precision.c, and
> stack_arg_fail.c.
>
> Should this file include an '#else' dummy with __skip() to match the
> pattern used by its sibling tests, so that builds without __SIZEOF_INT128__
> report SKIP rather than silently passing?
>
> Note: __SIZEOF_INT128__ is defined by every clang for the bpf target, so
> the normal CI matrix (clang test_progs, no_alu32, cpuv4) does compile and
> run the test. Only the optional bpf-gcc flavor would be affected.

This should be okay. Later selftest will have more contents in file verifier_aggregate_arg.c
which has some not-guarded bpf programs.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527

