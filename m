Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52643B4A0
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122575; cv=none; b=GDzG5v1l262cjoUueCqjgir0pqSMvqPi2F6Q9HXD8iBGyaYIerU7Hb4t2Qif2m6twnm2joHqh5WctBe4vFAzyYPHFsTPmr2oaA9BZVNBObx3BPDKBbsi17utnNmP8J/n/H1SUq9MmyAr5MyNlWMMl7Dc3gsHMlJkYnqPfT6PUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122575; c=relaxed/simple;
	bh=ZDyGeQ3aZTLAS1yJl33xLfqk9M3FWL4T367VaFyMEYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dRRPM4vyoroPKOY3N/xx7gQncJmmw7W1le4BwEPWAV1bmo6XpHkVQp+xQc2DBXsExpGgI81eihKGywhl0EJR0FO69fL4MBHnsKg5abo2Ev/p5yiD9iSqbDkeYvfBWLYay46pnj9+cO91h9lvJy/YXTUgeFtb6iw+KWkIarolusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol+w9t0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol+w9t0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A20C1F000FF;
	Sun,  4 Oct 2026 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791122573;
	bh=SCrSTdJY96ncFUonWp+8oh/bj7kjkteSAf06nYwBs3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ol+w9t0VB2gryvQNun+fjqo+r/G62YhZMjQkjWrxQuun9wcJ82t2/2Ixyzekd16kS
	 yxE/DSt+32nlLwRDYDOuza6FmvjmAx2zlUkWlp9Cw6f73kpeFw8px60jdhNZ+tw99i
	 mMa4ke/zBIPSGzsSYFE9rIFRr9YjZ5Vigtdt3iibQwEqsb/L4bVmlNvwitFulIg8YM
	 dqzYZx1T3GDSqIaYITnfgeaoVDkhKxEucqCbDYqX4iM8dt0kRl8O1eY6MY9nYd79x2
	 iCdLZHXbvWuUFDK3yMCILaQz2k3iuufDNQFf0QJqib9WFT3vjuwB1xPIWY+c1+mpMz
	 1P2BcOlz7h3lA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 30/43] bpf: avoid widening registers that
 hinder exact stack-slot tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-scev-minimal-rebase-v2-30-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
 <20261004-scev-minimal-rebase-v2-30-f6254e29fdf2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 14:02:52 +0000
Message-Id: <20261004140253.5A20C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: call_params_mask() overflows register mask for kfuncs with =
> 5 args
--

commit 2a8074d95fbbe20d412b57ca9a7f732dfbfaa51d
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: avoid widening registers that hinder exact stack-slot tracking

This commit adds logic to avoid widening registers used to compute stack
addresses for varying-offset stack accesses during SCEV loop bounds
computations. It collects base registers at loop entry and propagates
them to ensure accurate stack-slot tracking.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index a98f3fea52ec0..a093e9bf84b9d 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -1060,6 +1060,70 @@ static void reset_scevs_at_indirect_writes(struct =
bpf_verifier_env *env, struct
>  	}
>  }
> =20
> +/*
> + * Collect loop-entry registers referenced by expr 'id', best effort.
> + * DEPTH_LIMIT may leave dependencies unrecorded. This mask only avoids
> + * widening that would lose stack-access precision; missing dependencies
> + * may cause false rejections, but this is not a soundness issue.
> + */
> +static void or_expr_regs(struct bpf_verifier_env *env, u32 id, unsigned =
long *mask)
> +{
> +	struct scev *scev =3D env->scev;
> +	u32 order;
> +
> +	scev->stack_sz =3D 0;
> +	expr_stack_push(scev, id);
> +	while (expr_next(scev, &id, &order)) {
> +		if ((order & PRE) && scev->exprs[id].op =3D=3D REG)
> +			__set_bit(scev->exprs[id].params[0], mask);
> +	}
> +}
> +
> +/* Mask of argument registers (R1..R5) a call at 'idx' passes by registe=
r. */
> +static u16 call_params_mask(struct bpf_verifier_env *env, int idx)
> +{
> +	struct bpf_insn *insn =3D &env->prog->insnsi[idx];
> +	struct bpf_call_summary cs;
> +	int n =3D bpf_get_call_summary(env, insn, &cs) ? cs.arg_slot_cnt : MAX_=
BPF_FUNC_REG_ARGS;
> +
> +	return n ? GENMASK(BPF_REG_1 + n - 1, BPF_REG_1) : 0;
> +}

[Severity: Medium]
Can this regression generate an incorrect register mask if a kfunc takes
more than 5 argument slots?

If bpf_get_call_summary() returns a kfunc with cs.arg_slot_cnt > 5 (since
extra arguments are passed on the stack), n will exceed MAX_BPF_FUNC_REG_AR=
GS.
Using GENMASK() with n > 5 will overflow into callee-saved registers like
BPF_REG_6 through BPF_REG_10, incorrectly treating them as argument
registers.

Could this pollute base_regs in collect_store_base_regs() and lead to the
verifier falsely rejecting valid BPF programs due to erroneous stack address
dependency tracking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-scev-minim=
al-rebase-v2-0-f6254e29fdf2@gmail.com?part=3D30
