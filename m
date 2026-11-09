Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210336;
	b=DEU5qqM+MBBWUjl1aNujNGrbIEezSgjCgwUVUjMWDubcnovnBA7H8QbzRcwV9+qiudwX
	 MDGSsGaDSPjgD+qir8WNoKRrwa4WE+Uj9+l1gCMwjF8mXkv6GDohuyej7xmzsi75Xz2mm
	 orGLibPeOcCpA6vxXmmXadxmt/eJ2f8iGehbyH2lRd5A5v5M4JgRNBIimi3wt9OOI43W8
	 sjG0DfjGqRufAIIkNz41Xp0mMXmhM0d/e/au8aQv11QGWPPNUdLZBnNMv35wi38PWKXrm
	 W29eVCRuCpSWU3fMMCRVRnevorAgUT9QK44Dq46xKqzjN1VJ22F950OIwe+Z0JJtz+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210336;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mQiRmGiF8PMhpMrZ48ZYZrWpSaElWCNANH3Hbqdb80Y=;
	b=sZDIVOxtPPUvV33sciD+wWsYzLueT1jL1JMm5djowrpU+EMevz9hi+L6jKoa4dtv6gEj
	 9MAXeKXeXv79YER64sQ0BVcQNqjgmXfKxVJiZQdsFQMibQedlFYSn11e2YRvbmDKW+l49
	 5p1AYWP1L0O+I9a6jTv07qympoZYUYxm4fWB+B5VjpoTavrciCNJFqFu+g4IhwKyUB+l/
	 KAwZFXAweO+AHZV0crnLfY06Ou/pumwwylL/IlJhWAouXsRMM0ULbWKRiuhOyjxLhrk1S
	 Ax9jQNKbly4Qe3hB1UKDZounOa1bx6YcB3NzCthuWpJvYwwHqD9HVxGmrl6ElcfY86w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnBwDXJx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15516606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnBwDXJx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA04C1F0089F;
	Mon,  9 Nov 2026 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794210335;
	bh=mQiRmGiF8PMhpMrZ48ZYZrWpSaElWCNANH3Hbqdb80Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SnBwDXJxhhmb2BNYVDC/OiotFv1Z5EVFCpyNdcUiozCINU3yhb1wAuKnA9nFsS1JE
	 /2pGzS6jJP095fz7l6rIRFwLMXHXKlJKqpYA5p1HsKnpW2DgprnVGg9KNPTnL2dIwy
	 R/eYlIGhzJEepXqFvkuaC7WtL6MnytPM7j+G/Zq+F2+0ypKh3Yz/xbpdNCdPdCjBIk
	 XJrcFsTCl8753rYtal3pEAhYz9K9TPYWGMng/Zip2FLDfINUjdi+IqX8SwlazXNy5w
	 GvOd90Pzqg/pxM2opIJkSe+f/K9BphG7KUzO2OWbEjZVfjoh7X49top144oMpT3CA5
	 DQLlbJWEQ+CLA==
Content-Type: multipart/mixed; boundary="===============3238441288265326375=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e66de86420674857f51a844d16fe0a4dcb344446353d69c2e255dcc5209d2765@mail.kernel.org>
In-Reply-To: <20261109064715.2382452-13-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-13-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 12/26] bpf: Refine registers linked by scalar evolution at conditional jumps
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 07:45:35 +0000 (UTC)

--===============3238441288265326375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Refine registers linked by scalar evolution at conditional jumps

TL;DR: The new verifier_bug_if() slice_slots check may wrongly reject a valid
privileged program (with a WARN splat) when a bpf_dynptr_slice_rdwr() buffer
has a variable stack offset with gaps between tracked offsets.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -16054,6 +16060,12 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
>  		regs[BPF_REG_0].buf = meta->slice_buf;
>  		if (meta->slice_buf.size)
>  			env->seen_stack_slice = true;
> +		if (verifier_bug_if(meta->slice_buf.size &&
> +				    !type_is_rdonly_mem(regs[BPF_REG_0].type) &&
> +				    !bpf_scev_in_slice_slots(env, meta->slice_buf.off,
> +							     meta->slice_buf.size),
> +				    env, "slice buffer is not in scev slice_slots"))
> +			return -EFAULT;

Can this verifier_bug_if() fire for a valid privileged program whose
bpf_dynptr_slice_rdwr() buffer has a variable stack offset?

bpf_scev_in_slice_slots() requires every slot in [off, off + size) to be
set in scev->slice_slots:

    for (spi = bpf_get_spi(off + size - 1); spi <= bpf_get_spi(off); spi++)
            if (!test_bit(spi, env->scev->slice_slots))
                    return false;

check_kfunc_call() passes the hull of a variable-offset buffer:

    meta.slice_buf.off = reg_smin(buf);
    meta.slice_buf.size = reg_smax(buf) - reg_smin(buf) + meta.arg_constant.value;

find_slice_slots() builds slice_slots only from bpf_may_write_mask() of the
call insns.  Liveness keeps up to MAX_ARG_OFFSETS exact offsets for a stack
pointer, and record_stack_access_off() marks may_write only for the slots
those offsets cover, not for the gaps between them.  The existing
check_may_write_mask() accepts this on purpose ("Without @fixed_off the range
can be wider than the mask: two offsets become a range at a join point"), so
for a variable offset it needs only one set bit, while
bpf_scev_in_slice_slots() needs all of them.

A privileged program can get such a range, since is_widenable_reg_type()
accepts PTR_TO_STACK and union_any_reg() widens at a loop header:

    r6 = r10 - 32; r7 = r10 - 16;      // fp-32..fp-8 initialized
    loop (counted by r8):
      r1 = &dynptr; r2 = 0; r3 = r7; r4 = 8;
      call bpf_dynptr_slice_rdwr
      r7 = r6

At the header r7 is widened to fp-32..fp-16 with var_off (0x..e0; 0x10).
Liveness sees r3 in {-16, -32}, so the call's may_write_mask has the slots
for fp-32 and fp-16 but not the one for fp-24.  check_stack_range_initialized()
passes, then bpf_scev_in_slice_slots(env, -32, 24) finds the fp-24 slot clear
and the program is rejected with "verifier bug: slice buffer is not in scev
slice_slots" (plus a WARN_ONCE splat on CONFIG_DEBUG_KERNEL).

The gap slot cannot actually be written through the slice, since the buffer
is at one of the offsets liveness tracked, so scev stays sound without this
check.

Should this test only the offsets the call could write, the way
check_may_write_mask() does for !fixed_off, or only run when the buffer
offset is a constant (tnum_is_const())?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42577197491
--===============3238441288265326375==--
