Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209451;
	b=GeYbNbjIzMtH6UZgKUStM+9+NBjrJqgBV9B5FVj0sDNdlIU9N8a56NNuEGWMmHqriNn7
	 rd6cyOBKRtlJA+ao3q3aXXChth61TJTFO9JkFYgYgzH7uPhbvUZ4Tvv4waU+3IZPu7095
	 xYaeibtiTVKSyPJsxCWNhCjVBI7uQx2vRPSuUXFBndXS64MXqk4ijtltv2hQFWFSoB+ZB
	 0QU78Ahx+EZkwFZ3yrq1rZWpf3Tj1RyWzYbhQK3oy4ea3JJvdjTSddWKWMqZvsUTBFZrW
	 ALXgT9ZDvQBax4WLUrz/LcOqGmLkpzxgx6hNLo4L9cTNbbAYuhO8cffmP0jyNH3keIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209451;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=XjYZiQCsN+vArYJ9fAw9GxjYemxdjO3TJVGkQ6sNgs8=;
	b=iA1SrcMTiLr0ULS6dZMoXYeHG4kzNH///qVuX10ilQrtUL0TASS5rPcMsdEbwtDaU4nH
	 Wu/bU4S0qX09QNEvPtMODZwpc3wWeVJlCGHT6S80h3WXJKvxB2lFTTw7mEcGLWEbARJ7C
	 WejLH1JONss0o/e1Ujetzu6OLkH0YSvTkF9SnvH0qBtjwuNsu4T8ZasAgFusrA4I5vPDO
	 1VrwwV+M9e9QDxj1KWcwFBGT8Uyfmjc+LF/8wSDMlTGXo04hKlpoZHN1nicqIUcieFUVn
	 LaHV/e5i4IYVuSlcJyNepFQvnUpelVa/UyevPlD8TjyQf0HK8hPmgJEPbHLgLjIRRQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZ1bJJQX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCC0606A32A
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZ1bJJQX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039D21F008A1;
	Mon,  9 Nov 2026 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209451;
	bh=XjYZiQCsN+vArYJ9fAw9GxjYemxdjO3TJVGkQ6sNgs8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fZ1bJJQXSKGW/cXTH4c7g6ygTcS39k/nr9Pl/9oetr//Dg9Gfh+cOeh1ha72T7SqF
	 7VtqaOH28t1KWfddZRApQPhtmr5DefTwf9DfFS44TEe9lV1JdvGC8Py5uScBBLSDN3
	 UtWzX8/M/DGR7Dh1tdNqybhEKbQIZ9voBp5d2don8P0RxdvIyE/WVaHc3Nj8QtVkxw
	 oCWhTkwbEvd45vUpqtn+f5hqU4qNosHWvowa4TLGP0vdCGxSx8/yPKGL1mmAeOvlbZ
	 Qq0S0RaIe++IaE6YIIVXGuMLnYXwrax1lpx55a3K1VGY8mC+SN0D6lcq1z2FVGTbEg
	 YLELAbpqAvryw==
Content-Type: multipart/mixed; boundary="===============8027913311485467301=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f56425d1faf7df833bf9835adf4811b2972ddb82b8ce1cf0d17d172b3d449bb6@mail.kernel.org>
In-Reply-To: <20261109064715.2382452-18-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-18-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 17/26] bpf: Find a copy of an induction variable without scalar ids
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 07:30:50 +0000 (UTC)

--===============8027913311485467301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Find a copy of an induction variable without scalar ids

TL;DR: The new copy check in scev.c may recognize more than before (pointer
induction variable copies, equal-by-expression scalars), contradicting the "no
new ability" changelog. No soundness bug found; no pointer tests.

> bpf: Find a copy of an induction variable without scalar ids
>
> A prerequisite of the removal of scalar ids, no new ability. scev.c has two
> users of them: scev_regs_equal() reads them, link_copies() assigns them.
> Both are for a loop like this one. It has an iteration count
> (header_count: how often the header is executed) before and after the
> patch:
>
> 	u32 i = 0;
> 	while (buf[i++] && i < 1023)
> 		;
> 	return buf[i];
>
> clang keeps the value of i from before the increment in r2, and the linear
> latch tests r2:
>
> 	     r2 = 0
> 	     r1 = 0
> 	l:   r1 += 1
> 	     if r2 > 1021 goto out
> 	     r2 += r0
> 	     w3 = *(u8 *)(r2 + 0)
> 	     r2 = r1
> 	     if w3 != 0 goto l
> 	out: r0 += r1
>
> r1 and r2 have the same backedge value. r2 is a copy of the induction
> variable r1 if their entry values are equal too (at the header the two are
> congruent induction variables, LLVM: replaceCongruentIVs()). scev.c used to
> analyze loops only, so (copy r2 (linear r1 1)), COPY_SCEV, leaves the entry
> values to the main pass: scev_regs_equal() accepts the same constant or the
> same scalar id in the state at loop entry.
>
> By now scev.c computes expressions for whole subprogs, the code before the
> loop included. const_diff_at_header() decides if r2 == r1 holds at the
> header in every iteration: it holds at loop entry and every backedge
> preserves it. Then r2 is an induction variable of its own, (linear r2 1),
> and no code after compute_header_scevs() has to know that it is a copy.
>
> link_copies() assigns one scalar id to r1 and r2 at the header, so that the
> test of r2 bounds r1 at 'out'. The linked registers of a conditional jump
> do that without an id: the live registers and stack slots that are a tested
> register + a constant on every path to the jump. At the header, the latches
> and the exits of a loop they include what const_diff_at_header() finds.
>
> Remove COPY_SCEV, is_copy(), copy_reg, scev_regs_equal(), link_copies().
>
> Precision that is lost:
>  - Two registers enter the loop with the same constant, and only the state
>    knows it, not scev.c. The loop has no iteration count.
>  - At a jump of the loop that is no latch and no exit a test of r1 does not
>    refine r2: const_diff_at_header() is not used there. copy_less and
>    copy_more of verifier_loop_latch.c stored at the copy - 1 and + 1 after
>    such a test. They store at the copy now.
> No other verdict changes in the selftests, Cilium, sched_ext, katran,
> bpfjailer and the programs in Rust.
>
> The new test copy_ahead enters the loop with 0 in the induction variable
> and 1 in the copy: no iteration count.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The changelog says "A prerequisite of the removal of scalar ids, no new
ability", but is the new copy check broader than the one it replaces?

The removed scev_regs_equal() only accepted two SCALAR_VALUE registers that
were the same constant or had the same scalar id in the entry state:

    if (!ra || !rb || ra->type != SCALAR_VALUE || rb->type != SCALAR_VALUE)
        return false;
    if (tnum_is_const(ra->var_off) && tnum_is_const(rb->var_off))
        return ra->var_off.value == rb->var_off.value;
    return ra->id && ra->id == rb->id && ra->delta == rb->delta;

The same SCALAR_VALUE test guarded link_copies().  The new check in
compute_header_scevs() is:

    !is_reg(scev, l, &t) || t != rb ||
    !const_diff_at_header(env, h, rb, ra, &imm) || imm)
        id = expr2(scev, LINEAR_SCEV, expr1(scev, REG, ra), r);

const_diff_at_header() compares expressions and does not know register
types.  So the copy of a pointer induction variable, such as a packet
pointer kept from before the increment:

    r2 = r1; l: r1 += 1; ... *(u8 *)(r2 + 0) ...; r2 = r1; if .. goto l

now gets (linear (reg rA) step), where before it was an inexact COPY_SCEV.
The same goes for two non-constant scalars that hold the same value number
but share no id, such as r1 = r0 & 0xff; r2 = r0 & 0xff.

As a result, bpf_compute_loop_iters() and bpf_widen_scev_regs() can now
widen such a pointer copy as an induction variable through
linear_bounds()/bpf_set_reg_range(), where before it went to cant_widen.
A latch that tests such a copy can also give an iteration count in
compute_max_iters(), where the old scev_regs_equal() check returned false.

I did not find a soundness problem, but none of the copy tests in
verifier_loop_latch.c cover pointers.

Could the changelog mention that copies of pointer induction variables, and
copies equal by expression only, are now recognized?  Or could the check be
limited to the old cases if no new ability is the intent?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42577197491
--===============8027913311485467301==--
