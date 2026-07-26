Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A9BA45
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785032581; cv=none; b=Eu8ma/kfkTDVtIHPs/r4WlKo1vmPS/GudC1T4TgVvpnI2GKDs6FBBLCyIQvsG/UV7kXpEuTIetUC61Qs7AfSpm4XGoGagM8lbUdxmvyKni6xll/B/qmBqO0QKlb4lAofzZ9uLDHtFitgRMxmpZC81r+styiJsOJ3HJf/KWdJvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785032581; c=relaxed/simple;
	bh=ODeaOobsXAf3SbvrknBilyY4/R6Q7jjDoHe7Jo5hL3I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EoPPep2CWWJ66UeNxTrRzlgJHaxeYy8zQxWkEBG7opzJXowe6Ti7OUpZsNnAkQ+qkKZ5zpO9tUvmzAxygG7fBDoarpIXH/jVXPpPR5HA20DsYC5HKJWLPN5JZEkwe0jalw2pL1o1o/qQ94tUZISI4cZdcoM3/VTWlMoHX8NzoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9296FZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9296FZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581DF1F000E9;
	Sun, 26 Jul 2026 02:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785032579;
	bh=D+Nj/wCFvW6gaCi+miJMoQq08g2FfXoTKO8RS0Tq4OM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n9296FZi+v7S7vFL3QoQgYAPtVvqAyrABVeYmzLHGerxoEDaCpQWjXZE7B8cxSoD2
	 U1uDLOkZnxFouGJ68kjNZvi8SMLpBtC8z2s2J12jzjQneOz3UGx/nlvLIL4wghSp5H
	 aHNTnOmJUqS+0GYDlIURchWVL/OJb1viVcGa2YXKQjY0VGg738zc9eIATEBWqNRf+/
	 k3S+QIVk4XCyFZDGN7wG4xn4/mL9A2YzrphuL0DglRUsZ+BRpZObAexgaDzUkox4mJ
	 W2icwhrO7JqKvyihlIgk2fsaE+Cvd2cx5E0Q6/QM0C0f9OWyPlcwV+COFsQvTulwHp
	 H0D9HY5jh6irQ==
Content-Type: multipart/mixed; boundary="===============2895980427197368209=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22f76e29c963794d5650486124e295ffc275c5e548dfc7fbae022f24c9d5d1ad@mail.kernel.org>
In-Reply-To: <20260726013105.3689867-4-memxor@gmail.com>
References: <20260726013105.3689867-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/9] bpf, x86: JIT __arena kfunc argument rebasing
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: tj@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 26 Jul 2026 02:22:58 +0000 (UTC)

--===============2895980427197368209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b2feec81e231..08013c2fcfaa 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1678,6 +1678,50 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
>  	return 0;
>  }
>
> +/*
> + * Rebase the __arena args of a kfunc call to arena kernel addresses,
> + * rN = kern_vm_start + (u32)rN, with R12 holding kern_vm_start. A nullable
> + * arg preserves NULL by skipping the add, tested on the truncated value as
> + * arena NULL is offset 0. Return the number of emitted bytes.
> + */
> +static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
> +				 const struct bpf_insn *insn, u8 **pprog)
> +{
> +	const struct btf_func_model *fm;
> +	u8 *prog = *pprog;
> +	u8 *start = prog;
> +	int i;
> +
> +	fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
> +	if (!fm)
> +		return -EINVAL;
> +
> +	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
> +		u8 flags = fm->arg_flags[i];
> +		u32 reg = BPF_REG_1 + i;
> +
> +		if (!(flags & BTF_FMODEL_ARENA_ARG))
> +			continue;
> +		if (WARN_ON_ONCE(!bpf_prog->aux->arena))
> +			return -EINVAL;
> +
> +		/* mov eN, eN: truncate and clear the upper 32 bits */
> +		emit_mov_reg(&prog, false, reg, reg);
> +		if (flags & BTF_FMODEL_NULLABLE_ARG) {
> +			/* test eN, eN; jz over the 3-byte add */
> +			maybe_emit_mod(&prog, reg, reg, false);
> +			EMIT2(0x85, add_2reg(0xC0, reg, reg));
> +			EMIT2(X86_JE, 3);
> +		}
> +		/* add rN, r12 */
> +		maybe_emit_mod(&prog, reg, X86_REG_R12, true);
> +		EMIT2(0x01, add_2reg(0xC0, reg, X86_REG_R12));
> +	}
> +
> +	*pprog = prog;
> +	return prog - start;
> +}

In v1 review, Eduard Zingerman raised a concern about the JIT-based
implementation approach, suggesting that it spreads complexity across
multiple JITs (verifier.c + 6 jits) instead of keeping the bulk of the
implementation in one place. He proposed an alternative using R0 by default
with a jit_has_dedicated_arena_register() predicate to avoid the
64-immediate move overhead while centralizing the logic in verifier.c.

Kumar responded that while this approach is reasonable for kfuncs, struct_ops
would require uglier code with reloading/translating/storing. The v2 patch
retained the JIT-based approach.

Given that this will eventually need implementation in 6 different JITs
(assuming all except s390 will gain arena support), would it be worth
reconsidering the centralized verifier.c approach? The optimization saves a
64-immediate move per callsite, but does that performance benefit justify the
increased maintenance burden of ensuring correct implementation across
multiple JIT backends?

Link: https://lore.kernel.org/bpf/bbf82d80eb0dc307d09a6c7cc33c23063a55a90f.camel@gmail.com/

> @@ -2583,6 +2627,12 @@ st:			insn_off = insn->off;
>  		}
>  		if (!imm32)
>  			return -EINVAL;
> +		if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
> +			err = emit_kfunc_arena_args(bpf_prog, insn, &prog);
> +			if (err < 0)
> +				return err;
> +			ip += err;
> +		}
>  		if (priv_frame_ptr) {
>  			push_r9(&prog);
>  			ip += 2;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30183383612
--===============2895980427197368209==--
