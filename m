Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496680;
	b=q9/rzvm52nngq554bSXhl4Q1XzXKtphpV/fLtbe/ZrI8NqKJtKR6E9GM0lc1E6uB1qIo
	 f+k+WJ1uuV8Sp/LFVN/KqX+I5roUjNI/iYzhHFo48vtFcgRwUUrTxSFipPDiEgBixReJl
	 UB7F4A/yaMYVWFQ/4qR5adaDqtBy8BT2WZ/ACcgTDfsIm3VZbFjeSro+eCY+j0Y19YhoH
	 iGBn3J2B96RxiTj84yBMX5hj7DH+A3FeFKNwZaZq9z3g9v01tLFPJHV1LpGA2cQ9sgHTi
	 uKS1mu1ugoREI269yOQqZdBVTFN8AK62ayso8qGDe76NpYIp40P9EBHbzKUlf3rmpIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496680;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=QgdEOgj5DO6aO92lXMWuugu+LCn/lcYayg1XM5OwHcY=;
	b=oaaNaRkM73JW/JYCuNnCmzpjk7GYQF+nSTR82UlV5rdcAZmv3RW6e7KMHloGjbSSrjpI
	 DQhqEeXQl8i1RVnEjNKdB0WoqlAvh7ZEd08T9gcAqQtXwwea/+NxO13RhEjg4WthcqqPm
	 WaVjR3/9QJo9yuc8K1/LDbe0OAj84x3cRGw18fpQAOWN7BQNusaaxy++MkW7+U6AemASh
	 EKoZYwoHjVQE3BJGjwQxctmGMk4WAVAauKvUZ78iA1fovCjyeRbRng4mu3lydUl7Wyag9
	 g4Q2944I9seOzuVISdRauAuBumiZtFxfZuQ+kxTM4HaBsQBeKcyA+UZktlBcfP7xNDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKvJIUbW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833B606A31A
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKvJIUbW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A5D1F000C1;
	Sun,  1 Nov 2026 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793496679;
	bh=QgdEOgj5DO6aO92lXMWuugu+LCn/lcYayg1XM5OwHcY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kKvJIUbWr3H5WDMm27L+KudNgjAE3F6mB9TOYTnn0UzivvuKBQGC7PuSo4mt9Em1R
	 n5NfO0BTAkld3sol2iGGsHTQ8do7Pvs1BaQpI7j2HdtRBfdf7uGAd9rKTJFLqktoAt
	 2VJbkCM4uQbHDeDGRw+Un12RvarscH8VB9CB5h0Kqnk/qoxV6L9tkcoU1VmshwDB5C
	 YIjDsmi80osqjjVFyUyB1IOQiGfHIGlSHsoxSAl8Ro0wq+TNe/KunzUGO9J8foTOiJ
	 6qH7MZDQHqi+nbMWptHf02oK1RXWttwnxVU3az4gPktsWMbKTj6QShsoxfPGNOAw9G
	 TyejjbgfMFMfA==
Content-Type: multipart/mixed; boundary="===============6958672853171962060=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b1947ab81fda5aa875d2c81e9df76bc2e7746a30a9941997635709e48e5f7e34@mail.kernel.org>
In-Reply-To: <20261101004657.3406576-2-alexei.starovoitov@gmail.com>
References: <20261101004657.3406576-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Don't trust pointers spilled in slots that a callee can write
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 01:31:19 +0000 (UTC)

--===============6958672853171962060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Don't trust pointers spilled in slots that a callee can write

TL;DR: The new join may leave a spilled r10 (fp+0) slot unchanged, since the
fp+0 join fix isn't in the tree. A valid program may be rejected, or an
out-of-bounds map access missed. Needs the fix first or folded in?

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -1443,21 +1466,22 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		*dst = none;
>  	} else if (class == BPF_JMP && code == BPF_CALL) {
>  		/*

[ ... ]

> +		 * Static subprogs and callbacks can't store an FP-derived pointer into the frame of
> +		 * the caller, but they can store any other pointer there. The caller can fill it
> +		 * and store through it. With the stale spill that store would be a definite write
> +		 * to a stack slot, and it doesn't touch the stack. Callees are analyzed after the
> +		 * caller, and they reach the whole frame from one pointer to it. So after the call
> +		 * every slot holds what it held before or a value that is not FP-derived.
>  		 */
> +		if (subprog_gets_local_fp(env, insn, insn_idx, at_out, depth))
> +			for (slot = 0; slot < nslots; slot++)
> +				at_stack_out[slot] = __arg_track_join(at_stack_out[slot], none);
>  		for (r = BPF_REG_0; r <= BPF_REG_5; r++)
>  			at_out[r] = none;
>  	} else if (class == BPF_LDX) {

Does this join leave a spilled copy of r10 unchanged?

In __arg_track_join(), a slot holding fp+0 joined with ARG_NONE takes this
path:

    if (a.frame >= 0 && b.frame == ARG_NONE) {
        if (a.off_cnt == 1)
            return arg_merge_offsets(a, arg_single(a.frame, 0));
        return a;
    }

arg_merge_offsets() dedups {fp+0} with {fp+0}, so the result is still
{fp+0} with off_cnt == 1, and at_stack_out[slot] comes out of the call
unchanged.

The commit message says "For a spilled copy of r10 this needs 'bpf: Fix the
join of fp+0 with a value that is not a pointer to stack'", but that
commit is not in the base tree, and the series range
753751ee76c8..82224cfc9354 contains only this patch and the selftest.

With only this series applied, a sequence like this still goes wrong:

    *(u64 *)(r10 - 16) = r10        ; fp-16 = fp0+0
    r1 = r10; r1 += -16; r2 = map_value; r2 += 8
    call sub                        ; *(u64 *)(r1 + 0) = r2
    r7 = *(u64 *)(r10 - 16)         ; verifier: map_value+8, arg_track: fp0+0
    *(u64 *)(r7 - 8) = 0            ; off_cnt == 1 -> must_write fp-8

sub stores a PTR_TO_MAP_VALUE, so the "cannot spill pointers to stack into
stack frame of the caller" check in check_stack_write_fixed_off() does not
fire, and r7 - 8 is map_value+0.

Two outcomes follow from arg_track still seeing fp-8 as a certain write.
A later read of fp-8 can fail with "slot poisoned by dead code elimination",
which rejects a valid program.  And with the hidden-store pattern from the
commit message, spill_to_stack() with cnt == 1 overwrites fp-8 with
ARG_NONE, so a later store through a pointer filled from fp-8 drops out of
the may_write mask.  reset_scevs_at_indirect_writes() then misses it, which
is the out-of-bounds map access this patch is meant to close.

The new comment says "So after the call every slot holds what it held before
or a value that is not FP-derived", but the join does not encode that for
fp+0 slots.

This is not a new regression, since the r10 case behaved the same before
the patch.  Should the fp+0 join fix be applied before this patch, or
folded into it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41259422626
--===============6958672853171962060==--
