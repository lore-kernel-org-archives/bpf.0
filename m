Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582822;
	b=HdZOpZpEirVymstuN5eHyzKu1wTurU2ulhbeuzWqtenJh3lGFLUKLgL1gnOz5ReloGTj
	 qw6ypk76MVWhdEXjUqtsMyNFUR3z7UfcFs8Qe9jWISmH4Wls8WNqsz7VuidAjzKI8NfDG
	 0uSJYDwMV+coHHXO3G86RtzHYFafzPT0lF5SH7nexIqrd4l3vMygOv++iHUdc96UjMhN+
	 TuYZ33JbgtoztrkNAuXWmHShN/oHq1nUhnwEeQLSHf1775YSquosiuboqxNCBFdo2eZ8g
	 hff9LDI2FWSm9R6vkBmI9nFbmOCSLMJQ8gC3DOkDrMCYOCxuFMg5ypDWlprsYRMQwrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582822;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=X3L0VmDgmPRICk50lFiuNLDjaHmpK2yBrJ2BQaXUEw0=;
	b=UIiHRIoBDt1yFhKQmZEqeqTpuBAQzbk3rA5PWcbpgf/G8cp6GgdVK5/favoOspeIh+XH
	 Gt0JcEp0oeaCJxgRvsgAszDQ7nkVJ5+BOR5/ISZ1TvHgov0Gzp/8yhGev+1hRFTm+d69O
	 hXk2mVXhjT6vVE3fM8EGFhTIe9KPqTVgI6khalT4CjVWK0s8lBKHssqGcgWJ0NcbkIp2q
	 sVNjYB1zjw1DvnFhUktp1P8dL2dakg4cob6V6hWTNhCICPiLSUZ8ZA5BpUjWDKkMiyf+n
	 nqfR13bfcuDyCDVS1txt9G3p1xaV5ZGOZyG3z/fa9lovKYPu3ewZAwfc2TljA3yeaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4TDM0JX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E61606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4TDM0JX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE461F000C0;
	Wed, 25 Nov 2026 05:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795582821;
	bh=X3L0VmDgmPRICk50lFiuNLDjaHmpK2yBrJ2BQaXUEw0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l4TDM0JXUPaHV4Gl/7cugI5G+sh/Md/NXqqp9XGnXYL29EPPro8fKxaYi/B98M/hz
	 wkrcnySosvHP4kIsLTnpiuCS+dwHFMcBzLU7qSI1YAdMTmqgELQQ0oVb9Zv8KP4DPL
	 KWT87X2QW3mLgWJMZTIcKpM8FwE7cI/BKEA4P1Fxpi0TyxE1I8bgM1xY4Ude4ryaVg
	 UidrrTqDZCVV0txx7LZFBo+vvG3qUugp09uoZkTaT83tIyWAA/HnMSHVtFXEI5U24d
	 rxltZHG/3RT10rzHXY3Rh/PIbbLfmgQTWS6WIPjFkDbqbzc4omN4x6gIiO4tkHRfH3
	 8vU1bEmvIAwVg==
Content-Type: multipart/mixed; boundary="===============0218535690941067216=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6af2fcf30607f45a332ff4c7af2a0f9f51706f778f348e329d51420c2753e10b@mail.kernel.org>
In-Reply-To: <20261125040820.947816-6-alexei.starovoitov@gmail.com>
References: <20261125040820.947816-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 5/5] bpf: Do not end a speculative path at a call
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,luis.gerhorst@fau.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 05:00:20 +0000 (UTC)

--===============0218535690941067216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Do not end a speculative path at a call

TL;DR: Nit only, not a bug: the rewritten do_check() comment omits BPF_ATOMIC
stack writes, which also set nospec_result, and doesn't say why calls are
excluded.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -20808,13 +20808,14 @@ static int do_check(struct bpf_verifier_env *env)
> -		if (state->speculative && insn_aux->nospec_result) {
> +		if (state->speculative && insn_aux->nospec_result &&
> +		    (BPF_CLASS(insn->code) != BPF_JMP || BPF_OP(insn->code) != BPF_CALL)) {
>  			/* If we are on a path that performed a jump-op, this
>  			 * may skip a nospec patched-in after the jump. This can
>  			 * currently never happen because nospec_result is only
>  			 * used for the write-ops
> -			 * `*(size*)(dst_reg+off)=src_reg|imm32` and helper
> -			 * calls. These must never skip the following insn
> +			 * `*(size*)(dst_reg+off)=src_reg|imm32` here.
> +			 * These must never skip the following insn

This isn't a bug, but is the rewritten comment's list of write-ops
complete?

BPF_ATOMIC insns that write to the stack also set nospec_result:

do_check_insn()
  check_atomic()
    check_atomic_rmw()
      check_mem_access(..., BPF_WRITE, ...)
        check_stack_write()
          check_stack_write_fixed_off()
            env->insn_aux_data[insn_idx].nospec_result = true;

so an insn such as `lock *(u64 *)(r10 - 8) += r1` on a speculative path
reaches this block too.  The previous patch in the series, c53e99952fac
("bpf: Emit nospec after BPF_ATOMIC stores to the stack"), makes
bpf_convert_ctx_accesses() handle exactly these insns.

The conclusion of the comment still holds, since atomics also have a single
fall-through edge.  The comment also does not say why calls are excluded
from the condition (bpf_convert_ctx_accesses() emits no nospec after a
call); that reason currently appears only in the changelog.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45547596641
--===============0218535690941067216==--
