Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011A440A1D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655467; cv=none; b=D7wBAsCseP1NBhPxGR/ql0PXd2YSapsA7dopIi3ZJlGd5V09yq2a34P5ogfgGsKjIbRpk0kJXpHG1k61reetFABxEb4ycDk+yS4ygiZwi0sLzSesS7fnGzDzGIfFn2exuFzhs9BIDFoZloZF8fjOF3TRkom/mrBD/Jl9oSYuuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655467; c=relaxed/simple;
	bh=hz+BF5k0l6P2X/cPRF0BWJ52e6znaiHiXlJEJhrGZKs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NVsiWQ1A1SGBmUTaghLIexkj3mJ3lYqTt2kax7bdI6szm51LgtDD9qqa0udc76bpYaEGYFIccKbidJvP1T7TUebO3ZhcD3FWbtKPn+mTUz6vFE5poRnQocwzC18L7sBh8QVozS83yHYzSof69m62du/QGicfY0epZZcJJlpsR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGyKNIl/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGyKNIl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7641F000E9;
	Thu, 13 Aug 2026 21:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786655465;
	bh=nrArOQP36zF3BsuxkPymKq0b12uLuVnTXPP6yYQvemc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NGyKNIl/19vV3Pjihi9L2aJCg9FuL0bzGtrbZFuB0iYigtccVIO44R2ErVkbp0jPY
	 b1VaAksTJaMEfafAWHObTe1W0aFWcJVp4b1gGohFu39ER4eNyrfmmq2i/WrefTMLvJ
	 FBme8O9AKb1uamLjWyjQMOp2tznRsOpEkV7L3PmuqOj2MQZIsCIz2qdy4MXIQ7a9Wt
	 PCJVaLQLvyiTOq5PmLbC+3Qgzo0k2xa300LO7JzXQbeKRS0FcLuijWMm1OJDTmp1y/
	 EEIrEuHNdezjojNR75eLxVWLeKQ5YHVGSiJ486p8BibxGK4nBsvROpE1CzthwngX1K
	 +DAaDPSvoQ1bw==
Content-Type: multipart/mixed; boundary="===============5255353453515706374=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d1e5764032f4f6e060a1a22d50531d330a603e668f98efaf5320b545ebfad99@mail.kernel.org>
In-Reply-To: <20260813200302.1997359-1-yonghong.song@linux.dev>
References: <20260813200302.1997359-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 10/11] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 21:11:05 +0000 (UTC)

--===============5255353453515706374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> index 979536f3c89c..c295adedbae8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> @@ -4,10 +4,14 @@
>  #include "aggregate_ret_int128_c.skel.h"
>  #include "aggregate_ret_struct_c.skel.h"
>  #include "aggregate_ret_kfunc_c.skel.h"
> +#include "aggregate_ret_func.skel.h"
> +#include "aggregate_ret_kfunc.skel.h"
>
>  void test_aggregate_ret(void)
>  {
>  	RUN_TESTS(aggregate_ret_int128_c);
>  	RUN_TESTS(aggregate_ret_struct_c);
>  	RUN_TESTS(aggregate_ret_kfunc_c);
> +	RUN_TESTS(aggregate_ret_func);
> +	RUN_TESTS(aggregate_ret_kfunc);
>  }

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> new file mode 100644
> index 000000000000..cfb21bcf704b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"

[ ... ]

> +SEC("tc")
> +__load_if_JITed()
> +__success __retval(0)
> +__log_level(2)
> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
> +__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
> +__msg("mark_precise: frame0: regs=r6 stack= before 2: (57) r6 &= 7")
> +__msg("mark_precise: frame0: regs=r6 stack= before 1: (bf) r6 = r2")
> +__msg("mark_precise: frame0: regs=r2 stack= before 12: (95) exit")
> +__msg("mark_precise: frame1: regs=r2 stack= before 11: (b7) r2 = 4")
> +__naked int aggregate_ret_static_precise(void)

[ ... ]

> +SEC("tc")
> +__load_if_JITed()
> +__success __retval(0)
> +__log_level(2)
> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
> +__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
> +__msg("mark_precise: frame0: regs=r6 stack= before 2: (57) r6 &= 7")
> +__msg("mark_precise: frame0: regs=r6 stack= before 1: (bf) r6 = r2")
> +__msg("mark_precise: frame0: regs=r2 stack= before 0: (85) call pc+9")
> +__naked int aggregate_ret_global_precise(void)

A subsystem pattern flags these two tests as potentially concerning.
The aggregate_ret_static_precise() and aggregate_ret_global_precise()
tests in the new aggregate_ret_func.c file are the R2 variant of
behavior that tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
already covers: subprog_result_precise() and global_subprog_result_precise()
in that file assert the same mark_precise log shape across the call/exit
boundary for static and global subprogs. The two new tests differ only in
which register (R2 vs R0) is being tracked, and in the final one or two
__msg lines.

This same commit did extend an existing file for its liveness test case
rather than adding a new one (it added aux2() and subprog_ret_reg_pair()
to compute_live_registers.c).

Would it be more natural to add these two precision tests as new cases
in verifier_subprog_precision.c, where a reader looks for precision-
backtracking coverage? The rest of aggregate_ret_func.c (the __failure
cases and the accepted pointer-pair case) is genuinely new-feature
coverage with no existing home, so perhaps that part stays separate.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> index d055fc7b3b95..0be9441ec273 100644
> --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
> +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> @@ -431,6 +431,36 @@ __naked void subprog1(void)
>  		::: __clobber_all);
>  }
>
> +static __used __naked unsigned __int128 aux2(void)
> +{
> +	asm volatile (
> +		"r0 = 1;"
> +		"r2 = 2;"
> +		"exit;"
> +		::: __clobber_all);
> +}
> +
> +SEC("socket")
> +/* A program observing the pair needs the JIT; see bpf_compute_subprog_ret_regs(). */
> +__load_if_JITed()
> +__log_level(2)
> +__msg("0: .12345.... (85) call pc+2")
> +__msg("1: ..2....... (bf) r0 = r2")
> +/* R2 is not read at the exit of this program, which returns an int, ... */
> +__msg("2: 0......... (95) exit")
> +__msg("3: .......... (b7) r0 = 1")
> +__msg("4: 0......... (b7) r2 = 2")
> +/* ... but it is at the exit of aux2(), which returns a register pair. */
> +__msg("5: 0.2....... (95) exit")
> +__naked void subprog_ret_reg_pair(void)

The changelog describes aggregate_ret_func.c covering "liveness at the exit
of a subprogram returning a pair," but that test is not in that file.
aggregate_ret_func.c has no liveness test at all - its only __log_level(2)
tests match "mark_precise: ..." lines.

The liveness-at-exit test is here, in compute_live_registers.c: aux2() and
subprog_ret_reg_pair(), with the register-mask __msg expectations like
"0: .12345.... (85) call pc+2" and "5: 0.2....... (95) exit".

Conversely, the changelog does not mention the accepted-case test
aggregate_ret_static_ptr_pair() in aggregate_ret_func.c (a static subprog
legitimately returning a pointer in R2, whose result is then dereferenced),
and it never mentions the aggregate_ret_kfunc.c / aggregate_ret_kfunc_c.c
additions that make up roughly 180 of the commit's added lines. New kfuncs
in the test module are the kind of addition a reviewer looks for in the
changelog.

Could the message be adjusted so that aggregate_ret_func.c's description
matches what the file actually contains, the liveness test is attributed to
compute_live_registers.c, and the kfunc side of the patch gets a sentence?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277
--===============5255353453515706374==--
