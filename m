Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA143DEA3
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122403; cv=none; b=h/UAGDVIR8t24YZoBhKvqsKwPYpHPptai2Y82Nei+uda09PKUYeRJ6hA3FbXBb7vH6xnJ5BT25z7Xr4JciKKNVBcWdNMqqCfK+BwcxA8MCfe2KKRKvLB2fucvtCfc8l4Lv2bbsvN2I0LYiyjbmYcpSuFsb1jVew9VqAMRtYVBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122403; c=relaxed/simple;
	bh=Srf1qnVBW+wO38VLwEQyFeco0Ayi5YXhy4Nmsb5B/Bo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WU+rNJe3ZVufc/y2U4P0H7WnEDmxCvsFTM9JIEPB3dyMbVlpin7FZJnQ+igYatny636z35l636cFXXdqeZJVK+xLBQDwt52VUWm0hTp7t9XO5NPXyVETAqa8gW8vWdvCFlqkg9AN1JdGsLSNPZzCPZ/vBLYb7/ko/WSXOi5L+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0jiynJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0jiynJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D51F000FF;
	Sun,  4 Oct 2026 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791122401;
	bh=ZUi+nrnT/Gmx5xfvsmZfFl4T9LIc0BWLxEsdNk7Jw+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0jiynJDHzhhSvGPK7MRdam3g9mWCagE3TB+E7nsrWIQNHQ131XlbmHPRJBOHUNyB
	 29j0Xxan/8R2AuEAnS/8AioSi62+yGBKhLg1wwSwd1+Tko012NKHmx4TVaFR9SYyRo
	 J7i6MJFhzjNLPkvvlMBNxHwpFIUf4VUU6glGSqK9HPLRq1ubJobu1GLWDoPIyqsT1O
	 HPd+CZxLgeJYzFY0IMblf/ZbarQzrR9SKcuykuMsCvx1IbvrtbJZxolySfAll2hFTX
	 eVcJUP1umTYCbOfNuXNEkYK5mXgmbA82RrWCqSvk5+JpKJekdvKXO66MppI4qG1eIO
	 l524MSrQpJfRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 28/43] bpf: compute scalar evolution
 expressions for loops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-scev-minimal-rebase-v2-28-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
 <20261004-scev-minimal-rebase-v2-28-f6254e29fdf2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 14:00:00 +0000
Message-Id: <20261004140000.E54D51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] bpf: SCEV analysis overwrites initial state, bypassing bounds =
checks on early exits
- [High] bpf: NULL pointer dereference in compute_insn_scevs for irreducibl=
e nested loops
- [Medium] bpf: log_scevs incorrectly rejects valid programs with nested la=
tches under BPF_LOG_LEVEL2
--

commit 2d2f1f9c2cfacacbaf91e31cf373b1ae40a400ea
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: compute scalar evolution expressions for loops

This commit assigns algebraic expressions to loop variables to describe how
their values evolve across iterations without unrolling the loops. The anal=
ysis
proceeds in two phases, analyzing innermost loops first and treating nested
loops as opaque operations.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> new file mode 100644
> index 0000000000000..9ef28e0d8d481
> --- /dev/null
> +++ b/kernel/bpf/scev.c
[ ... ]
> +static struct env *get_loop_env(struct scev *scev, int loop_header, int =
insn_idx)
> +{
[ ... ]
> +	e->empty =3D true;
> +	tmp->entries[cnt].loop_header =3D loop_header;
> +	tmp->entries[cnt].env =3D e;
> +	tmp->cnt =3D cnt + 1;
> +	scev->envs[insn_idx] =3D tmp;
> +	return e;
> +}
[ ... ]
> +static int setup_initial_loop_env(struct bpf_verifier_env *env, struct e=
nv *e, int insn_idx)
> +{
> +	struct scev *scev =3D env->scev;
> +	int i, err;
> +
> +	for (i =3D 0; i < REGS_NUM; i++) {
> +		err =3D replace_reg(scev, e, i, expr1(scev, REG, i));
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}

[Severity: Critical]
Could this leave the loop environment marked as empty even after it has been
populated with the initial register state?

When get_loop_env() initializes the environment, it sets e->empty to true.
Since setup_initial_loop_env() does not set e->empty to false after filling
the registers, a subsequent call to join() on the backedge might completely
overwrite this initial state:

	if (acc->empty) {
		memcpy(acc, cur, sizeof(*acc));
		acc->empty =3D false;
		return 0;
	}

If the loop exits on the first iteration, could the verifier mistakenly
assume a constant from the backedge instead of the actual entry value,
potentially bypassing bounds checks?

[ ... ]
> +static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_h=
eader)
> +{
[ ... ]
> +	/*
> +	 * For irreducible loops, and for loops nesting a loop with a truncated
> +	 * exit list, just assume that everything is clobbered for now.
> +	 */
> +	if (!can_compute_loop_scev(cur_loop)) {
> +		header_env =3D get_loop_env(scev, cur_header, cur_header);
> +		if (!header_env)
> +			return -ENOMEM;
> +		/* The freshly allocated environment has all expressions unknown. */
> +		header_env->empty =3D false;
> +		return 0;
> +	}
[ ... ]
> +static int compute_insn_scevs(struct bpf_verifier_env *env, struct env *=
eheader, struct env *einsn)
> +{
> +	struct scev *scev =3D env->scev;
> +	int id, reg;
> +
> +	for (reg =3D 0; reg < REGS_NUM; reg++) {
> +		id =3D einsn->reg2expr[reg];

[Severity: High]
Is it possible for einsn to be NULL here?

If a reducible outer loop has an exit instruction that is physically located
inside a nested irreducible loop, compute_scev_for_loop() will skip
allocating body environments for the inner loop.

When bpf_compute_scev() iterates over instructions and calls find_loop_env()
for this instruction, it might return NULL. This would result in passing a
NULL pointer into compute_insn_scevs(), leading to a dereference here.

> +		id =3D transform_expr_once(scev, 0, id, eheader->reg2scev, instantiate=
_header_scevs);
> +		if (id < 0)
> +			return id;
[ ... ]
> +static int log_scevs(struct bpf_verifier_env *env)
> +{
[ ... ]
> +		if (!can_compute_loop_scev(loop))
> +			continue;
> +		for (j =3D 0; j < loop->backedges_cnt; j++) {
> +			latch =3D loop->backedges[j].latch;
> +			if (latch < 0)
> +				continue;
> +			bpf_log(log, " scev at latch %d:\n", latch);
> +			latch_env =3D find_loop_env(scev, i, latch);
> +			if (verifier_bug_if(!latch_env, env, "i=3D%d, latch=3D%d", i, latch))
> +				return -EFAULT;

[Severity: Medium]
Could this trigger a verifier bug for valid programs when log level 2 is
enabled?

If an outer loop's latch is located inside a nested loop, its environment
might not be allocated since the nested loop's body is skipped during
evaluation. If so, find_loop_env() will return NULL, causing this check to
fail and abort verification for otherwise valid code.

> +			print_env(env, latch_env, latch, PRINT_SCEV);
> +		}
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-scev-minim=
al-rebase-v2-0-f6254e29fdf2@gmail.com?part=3D28
