Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792542180;
	b=0yb/4UQuLXC25cchm+qVaPtmwalbK5ksxarutglYFc3oBfTY6zuAfe8Y0BAGNX9ZNSLG
	 2799dxkCHhrVbY24LzSr/9YhbsPCJfuTXetWPiH8lRexXFE7q4s38SwbFH2skmpdiyN2h
	 vqaQLh+PEdYFjznO+NHwYc01+v/Tg68LDljA5LV3xd//zpHoLifpvNQGTEO/hzQ6CT2ja
	 OGtcElshq4ug+oS2LG9BemdJeLZaRJcxQrGHqyWzAb8vxftSvgY1vK1rxlDSxIjomwu42
	 GXU1/rmRb3k7q7omdtmLqmIDdIC7iZgndzq1J4JKKea2TpdDwJFuw1iqUFp/bFWma6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792542180;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=WrrxxKnfQUuHQqe82tN/03zvH7dU5UtA51dgC4/xS0I=;
	b=lWzuaAtesgAmCX8j6o3enxN++Ilt85lBnunYM89ioN1abyI2izRzFriCgUoKiD2ftcdg
	 KqORWol49G5hnQYzWNf9mCsAyGdRrMFQ4rXHSMY3yzpI2RUgtogBIaWgPxLiUhhr/WqT7
	 BUffeHNkcJfvXK0Qtamvn3s7/3iU4AarWPraHW3u5df33bmLjpynzCWYkq279KVeONsld
	 Qot8kiEOPiQ2FwfjYsh/EV+eyVH0aFotLMAkgrEF5zVNbV5xXwtEmsj3tps5zE05ZnQZB
	 0UdYPQcw9yGEEVDw0qPIExoyuzzPbB2bv5usZ1ElqmFIK7645jEXXtkhcLwv4JsSmiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DWA+PNNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DA606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DWA+PNNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19461F000C9;
	Wed, 21 Oct 2026 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792542179;
	bh=WrrxxKnfQUuHQqe82tN/03zvH7dU5UtA51dgC4/xS0I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DWA+PNNTSK7QG6RJUMxYfk4dt+FONjuJp66qtfiRdAS0CQNhY9D6qk6qqkefW6fVS
	 fF4Y++1dKRBDOTB4XEr2eaPMIo03Md2hZ+9y2EEx0AfsmpwuifYvPvSOVGqw5arPLY
	 U7IZiXbhutmoqVMEg2X95Dxz1Te0BCOXFqLshVdTJEYsfsm99JTisEBdM84hIjUEiK
	 zJ23lQF0I/UIu+I4ZsFUCvNYl09yzr6sXe9vUYy4vEJ6NH42x/tiUajF8oZqk8vf1H
	 FRHR9PnNy90ZYZBcEFIlK0HFZee4ENgXuRi2MbSdX60UdkPIHbny7TcxQj/YKJpDtZ
	 n3B8FW7o9p4wQ==
Content-Type: multipart/mixed; boundary="===============0239104791452413268=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7c6dc88385abb15de1e5ef89f34a38ad16691f3d580999dd72d896716355e7d2@mail.kernel.org>
In-Reply-To: <20261020234705.375067-1-eddyz87@gmail.com>
References: <20261020234705.375067-1-eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: reject pointer operands for 32-bit recurrences/latches
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 00:22:58 +0000 (UTC)

--===============0239104791452413268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: reject pointer operands for 32-bit recurrences/latches

TL;DR:
- Pointer with 32-bit recurrence still gets widened/clamped, so the verifier
  may accept an unsafe scalar-address load
- Commit message example "w1 += 8" on a pointer can't pass verification

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index fea77772ca96..44916071c16b 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -2035,7 +2036,7 @@ static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_
>  	}
>  	ra = scev_reg_for_read(env, st, a->ptr_reg);
>  	rb = scev_reg_for_read(env, st, b->ptr_reg);
> -	if (ra && rb && bpf_same_memory_origin(ra, rb))
> +	if (ra && rb && bpf_same_memory_origin(ra, rb) && !latch->zext32 && !latch->jmp32)
>  		return true;
>  
>  incompatible:

[ ... ]

Does this leave the 32-bit recurrence case open for a pointer register that
is not one of the latch operands?

bpf_compute_loop_iters() accepts a register whose SCEV is a simple linear
form as long as is_widenable_reg_type() allows its type:

    reg = scev_reg_for_linear(cur_func, r);
    /* If SCEV for r is (linear <reg> <slope>) */
    if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {

is_simple_linear() accepts (zext32 (linear rX imm)), and
is_widenable_reg_type() accepts PTR_TO_MAP_VALUE and similar types.  So a
pointer with a 32-bit recurrence is still reported as bounded by
bpf_compute_loop_iters(), and bpf_widen_scev_regs() and
bpf_clamp_scev_regs() then apply linear_bounds() to it.  The new check only
looks at the latch operands (initial/bound), not at the recurrence register.

Here is an example (needs CAP_BPF and CAP_PERFMON, i.e. allow_ptr_leaks and
allow_uninit_stack).  r1 is a map value pointer at offset 0 and value_size
is at least 73:

    r0 = 0
  l: if r1 s> 72 goto C   // exit; latch fails: ptr vs scalar
     w1 = w1              // verifier: ptr -> unknown scalar
     w1 += 8              // SCEV: r1 = (zext32 (linear r1 8))
     r0 += 1
     if r0 < 10 goto l    // scalar latch, 10 header executions
     exit
  C: r3 = *(u8 *)(r1 + 0)
     exit

On the first pass, after bpf_widen_scev_regs(), r1 is a PTR_TO_MAP_VALUE
with offsets [0,72].  is_branch_taken() returns -1 for pointer vs 72, so C
is checked with r1 as a pointer, which is valid.

On the backedge, handle_loop_entry_exit() calls maybe_clamp_scev_regs() and
bpf_clamp_scev_regs().  The latter only checks for NOT_INIT, not that the
register types match.  It computes linear_bounds(entry_reg, ...) from the
entry pointer's offsets and intersects the result with the now-scalar r1,
so r1 becomes a scalar in [0,72] with step 8.

On the second pass, 'if r1 s> 72' is never taken, so C is never checked
with r1 as a scalar.  The next backedge prunes.

At runtime, r1 on the second iteration is zext32(lo32(map_addr) + 8).  That
value is almost always s> 72, so execution jumps to C and loads from a
scalar address.  The clamp is unsound here because the register's value
depends on the runtime base address and not only on the tracked offset,
which is the same reasoning the commit message gives for the latch
operands.

Should the widenability check in bpf_compute_loop_iters() also refuse
zext32 coefficients for non-SCALAR_VALUE registers, or should widening and
clamping be refused when the entry and current register types differ?

Is this case meant to be covered by this patch?  None of the later commits
in this series appear to address it.

Also, quoting the commit message:

>     Avoid inferring loop bounds for the following program shapes:
>          32-bit latch          |    32-bit recurrence
>       -------------------------+--------------------------
>          r1 = ... pointer ...  |    r1 = ... pointer ...
>          r2 = ... pointer ...  |    r2 = ... pointer ...
>       l: r1 += 8               | l: w1 += 8
>          ...                   |    ...
>          if w1 < w2 goto l     |    if r1 < r2 goto l

This isn't a bug, but the 32-bit recurrence example ("w1 += 8" on the
pointer r1) cannot pass verification as written, because
adjust_ptr_min_max_vals() rejects it with "32-bit pointer arithmetic
prohibited".

The reachable form uses 'w1 = w1' (allowed under allow_ptr_leaks) followed
by a scalar 'w1 += 8'.  Could the example be changed to show that form?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39518152729
--===============0239104791452413268==--
