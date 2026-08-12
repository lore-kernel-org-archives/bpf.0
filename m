Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099142AF9E
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578834; cv=none; b=n8yvVv4wb9W/9phNyftwECKK5k1GhXIkCHwpmQ3hEHWCBnarFKoPPxyOuskQ4sJ9gWEr6jGjP+b6I8eryzf5FctfF4fYi9zH31PUO+5+4NDehA6mrHmgJoPdOVag6cgDgH7b5b0i8/R1z87NdZp0CQgOfh+O9rNnfyq+Jaeza0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578834; c=relaxed/simple;
	bh=6QzBJF4E4ebUZgqacqYt1fwiFr+AQbcYqvu7J6LJxUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePpJ1ZS3kUMcvKxMwvwvZrlvvuqWzlOfsjGQnsuhqypJwuE9DOU3cwUXSY+/TPS0FK5dKc+MZ1w26LltkqCio0jZEsyf9UPSD0X3kkcGHf2NPCoHl98/GqAuaz1AqeIS49yeEccPMIDMjWLRWuQDZEiMGoKc4tnlpeOACQVDhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzOgM/oT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzOgM/oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40161F00A3D;
	Wed, 12 Aug 2026 23:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786578832;
	bh=ghxA5zXr9qqLeZYnxBxpZ9XrKc0qjDjLHxoY3kdjH4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SzOgM/oTNzikEAYvaoEP/OKY5liT3WRX9XLLDzNpRuCg0SH2Yw9WgFlQYSoamiMRF
	 TpXCNUTWXsChKJakQVHbS44rYnmsEp/noMFZ8/2Nipf6zZBmmX51vAE7Zhq0yR6TDl
	 uPKC5CcW0VzqRgYZRmeWWAIV+DgphAwhLZKF4VypdvBtEopWXwFunJv2VnzUAVvDtZ
	 XR1NkbaM+kaVeouVIGr4XV+IlG5U+Yl16qaSNdBhZLjWmpmycQoLZAPNPQYG20xI4R
	 duap+YE8OqAJP6FOAYF8h91nyPdvtnYPhmEhoUHiXzlKwQvH/iSkJn3HNJs8C3rrvq
	 wSmRiq0Y9pJvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 05/16] bpf: Track verifier register
 diagnostic events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812233326.3575958-6-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
 <20260812233326.3575958-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:53:52 +0000
Message-Id: <20260812235352.A40161F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing diagnostic event tracking for BPF_LD_IMM64 and BPF_ATOMI=
C (with BPF_FETCH) operations.
--

--- Patch [5]: [PATCH bpf-next v4 05/16] bpf: Track verifier register diagn=
ostic events ---
commit 7db736a554444e8ded5ae93ab09a9f7f17a9c87b
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

    bpf: Track verifier register diagnostic events

This commit introduces verifier register diagnostic events to track how a
value reached its current state. It records register modifications, stack
spills, reference invalidations, and other events in the diagnostic history.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2e915292265b0..ed8a239a964d9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6391,15 +6421,19 @@ static int check_load_mem(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
> =20
>  	src_reg_type =3D regs[insn->src_reg].type;
> =20
> -	/* Check if (src_reg + off) is readable. The state of dst_reg will be
> -	 * updated by this call.
> +	/*
> +	 * check_stack_read_fixed_off() may refine the modification's origin to
> +	 * the source stack slot.
>  	 */
> +	bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
>  	err =3D check_mem_access(env, env->insn_idx, regs + insn->src_reg, argn=
o_from_reg(insn->src_reg), insn->off,
>  			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
>  			       strict_alignment_once, is_ldsx);
>  	err =3D err ?: save_aux_ptr_type(env, src_reg_type,
>  				       allow_trust_mismatch);
>  	err =3D err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
> +	if (!err)
> +		bpf_diag_mod_end(env);
> =20
>  	return err;
>  }

[Severity: Medium]
Are we missing similar diagnostic event tracking for BPF_LD_IMM64 and
BPF_ATOMIC (with BPF_FETCH) operations?

For example, in check_ld_imm(), we directly modify the destination register
without calling bpf_diag_mod_begin() or bpf_diag_mod_end(), which prevents
the origin of the value from being recorded:

	dst_reg =3D &regs[insn->dst_reg];
	if (insn->src_reg =3D=3D 0) {
		u64 imm =3D ((u64)(insn + 1)->imm << 32) | (u32)insn->imm;

		dst_reg->type =3D SCALAR_VALUE;
		__mark_reg_known(&regs[insn->dst_reg], imm);
		return 0;
	}

Additionally, in check_atomic_rmw(), we modify load_reg but lack diagnostic
event tracing. If stack memory is fetched, check_stack_read_fixed_off() cal=
ls
bpf_diag_mod_begin(), but bpf_diag_mod_end() is never called afterwards.=20

	load_reg =3D bpf_atomic_load_reg(insn);
	if (load_reg >=3D 0) {
		/* check and record load of old value */
		err =3D check_reg_arg(env, load_reg, DST_OP);
		if (err)
			return err;
	}

	dst_reg =3D cur_regs(env) + insn->dst_reg;

	/* Check whether we can read the memory, with second call for fetch
	 * case to simulate the register fill.
	 */
	err =3D check_mem_access(env, env->insn_idx, dst_reg, argno_from_reg(insn-=
>dst_reg), insn->off,
			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
	if (!err && load_reg >=3D 0)
		err =3D check_mem_access(env, env->insn_idx, dst_reg, argno_from_reg(insn=
->dst_reg),
				       insn->off, BPF_SIZE(insn->code),
				       BPF_READ, load_reg, true, false);

Does this leak the active modification state and cause the stack fetch event
to be permanently lost? Should these paths also be instrumented to track
value origins correctly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812233326.3575=
958-1-memxor@gmail.com?part=3D5
