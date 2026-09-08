Received: from mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70A204C31
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788842133; cv=none; b=vCmhPO6PbBV7SejruaKtMF2ucXQCuSPFMHjJWj2ofmbd27JdlyyiGulI0AFEJretgP2ftcw2I64xVy3iytkXp0WDmGUze7SvE8416ghdSWAeFXUNCv8EFldQioTphAUEvqPAmIiagxE8XIac2nVZYZQHQb0BNYHbbq15VGWI7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788842133; c=relaxed/simple;
	bh=+v85Hv6eIQJboIJPWC1UrT/3kXV6uqiufPVbJWqrAUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsoB4F65Swo+PgWZza7zOWFpOvymp579VGMb0wFVGRTNPE2oTIOjHfNFbUDtgbJtnPHnnzECRXczAHsyV7tr7FonVHeR+EqFiDg0TpEhbNw5DBO2a4CBiDyxcTXqH4Zj5cuPhewntEHd5tJTGfFE9c9gs3q/7a6BJod6pNmIDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F3kvDi64; arc=none smtp.client-ip=91.218.175.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F3kvDi64"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+v85Hv6eIQJboIJPWC1UrT/3kXV6uqiufPVbJWqrAUk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788842129; v=1; x=1789446929;
 b=F3kvDi64U0gb7bSHOpRMVXmL/Oxic/mbvPAGifHHzLxtuzvYcwvqMqXXQW52ogyWrHIOsZlB
 I3Q7m3sjYFgpTyVS6qhWSCQJ65rnRjFTgaXInFShq+hLnmN5mKLBb9qYTsLNvuw0IS9lt7TB86e
 Cvr1L+5DiYk3ejtaPFQhuP6c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 65bde11ceaf14748;
	Tue, 08 Sep 2026 04:35:29 +0000
X-Mizu-Trace-ID: 65bde11ceaf14748
X-Migadu-Flow: FLOW_OUT
Message-ID: <ad07b17e-4933-4324-ad35-e95b0dacbb55@linux.dev>
Date: Mon, 7 Sep 2026 21:35:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 11/12] selftests/bpf: Add inline-asm tests for
 by-value arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260904051054.3983495-1-yonghong.song@linux.dev>
 <f3466f8c3246d1abb06f2651a539c2697670246105f2b4664cba6455fe9199c0@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f3466f8c3246d1abb06f2651a539c2697670246105f2b4664cba6455fe9199c0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/26 11:09 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c b/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
>> new file mode 100644
>> index 000000000000..b230f3bd3b2a
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
>> @@ -0,0 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <test_progs.h>
>> +#include "aggregate_arg_func.skel.h"
>> +
>> +void test_aggregate_arg(void)
>> +{
>> +	RUN_TESTS(aggregate_arg_func);
>> +}
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
> [ ... ]
>
>> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)
>> +
>> +__noinline __u64 global_arg_split(int a, int b, int c, int d, struct pair p)
>> +{
>> +	return (__u64)a + b + c + d + p.lo + p.hi;
>> +}
>> +
>> +SEC("tc")
>> +__failure __msg("global function global_arg_split() needs 6 > 5 argument slots")
>> +__naked int aggregate_arg_split_fail(void)
> [ ... ]
>
>> +SEC("tc")
>> +__failure __msg("global function global_arg_past_regs() needs 7 > 5 argument slots")
>> +__naked int aggregate_arg_past_regs_fail(void)
> [ ... ]
>
>> +SEC("tc")
>> +__failure __msg("global function global_arg_i128_slots() needs 6 > 5 argument slots")
>> +__naked int aggregate_arg_i128_slots_fail(void)
> [ ... ]
>
> A subsystem pattern flags this as potentially concerning: this commit
> creates a new BPF prog file (progs/aggregate_arg_func.c) plus a new
> test_progs entry point (prog_tests/aggregate_arg.c) for by-value
> argument tests, while the immediately preceding commit in the same series
> (7bdde6e0b83d) added by-value aggregate argument tests to the existing
> progs/verifier_int128_arg.c, which is already run by
> prog_tests/verifier.c.
>
> This means coverage for one feature is now split across two test runners
> in the same directory, and struct pair is defined twice
> (progs/verifier_int128_arg.c and progs/aggregate_arg_func.c).
>
> Three of the six new subtests (aggregate_arg_split_fail,
> aggregate_arg_past_regs_fail, aggregate_arg_i128_slots_fail) are pure
> __failure/__msg verifier tests that need no hand-written register layout,
> so they could fit as cases in the existing file. The same is true of
> aggregate_arg_pair_ptr_fail.
>
> Is there a reason to create a separate test file rather than adding these
> tests to the existing progs/verifier_int128_arg.c, which already covers
> by-value aggregate arguments and would consolidate the feature's tests in
> one place?
>
> (For context: the pattern is motivated by the fact that aggregate_arg_pair_asm
> and aggregate_arg_pair_ptr_fail need hand-written register placement that
> C cannot express, and this layout mirrors the existing aggregate_ret
> structure with prog_tests/aggregate_ret.c + progs/aggregate_ret_func.c.
> A following commit extends the test with kfunc cases, so the new entry
> point is reused rather than single-purpose. The question is whether the
> C tests in verifier_int128_arg.c should move here too, so the feature's
> tests live in one place and struct pair is defined once.)

I think it is okay.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551

