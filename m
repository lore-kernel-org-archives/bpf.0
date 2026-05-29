Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B53B52E3
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045101; cv=none; b=IV7xhs88c7LjRxVfLPDgOKjOF5MhNKoPxGTBtABUqljfdL3hXEEzbVt9dbKcysCC371pv6mdrMdZhZWcIJ61dZ8JRYXVcI21vX5onoOCGvxYAH4Ly1GlVVDDKH8G43/LjhfwLOnBXeWW9yt5YjnIT8pbvt7MaXiRaE+biYO46eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045101; c=relaxed/simple;
	bh=3MxogfZ/OvaQrXMPQm2xOj5GbhTZvBkkJxl8dCoGuwA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XlnmEk+FrhZ+ckx6HEs0wJaci3fhrGnsQtTi+3j1Ykdc/InDfuIpNJfCVIc47MHJTwOBBRS9XDDkb/YohdN21RzbWHJhD/hvJmyXTmGHJID5r+eSvPDC9qYPKJ4E6RDoadeeyhmKkKRXqgLHO2jjsvxT51HoBeZou5ZwtH9W8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NULQ/Qg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NULQ/Qg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D0F1F00893;
	Fri, 29 May 2026 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780045100;
	bh=GOspi2egkAjQzsF3tRvGju5/yyvyzf4u/KO+85CiQDQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NULQ/Qg/e3GSsjgIaz1N2YQ4CZXe8FtQ5jv5eh8Zy5cfJL5aLd4kdI4a8dytVrZCg
	 DyhEb85g190yy0Tq0jPMucigZ9NZDMeIcLA4YPWvB+FCEBX8Id0kzYK0zi1gcMTwvS
	 YBAPiA7K8/teEcMKCE8xMKZskGa6fIKRaDuw9XfBwFLh0p/nkYzSU4qM0NZ3tnA3y1
	 iFFH8h99nDwb1BmvYeJiL9zLCdYCkCJJpSnN1HAMPB8b6msVxqaL0jcLUcxm1TOGdu
	 z/JRqOjXch/5qfx/Jw9xFQItK2ikS46dZA8gMkHoYShZCTm98pVs2n+8ZHKMxUPNbP
	 mPlokacRvEMUA==
Content-Type: multipart/mixed; boundary="===============4512208004376240867=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9a2d5c2e5819a7f4fa39521922b5320f79a61d4117a7da77fc266002e8db7df0@mail.kernel.org>
In-Reply-To: <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>
References: <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fork state when comparing sign crossing ranges with zero
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,zhuyifei@google.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 08:58:19 +0000 (UTC)

--===============4512208004376240867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..a2ee316f7ec0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16297,6 +16297,73 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s

[ ... ]

> +static int maybe_fork_cmp_with_zero(struct bpf_verifier_env *env,
> +				    struct bpf_insn *insn,
> +				    struct bpf_reg_state *src_reg,
> +				    struct bpf_reg_state *dst_reg)
> +{
> +	struct bpf_verifier_state *fork, *cur = env->cur_state;
> +	struct bpf_reg_state *fork_dst_reg;

[ ... ]

> +	fork = push_stack(env, env->insn_idx, env->insn_idx, cur->speculative);
> +	if (!fork)
> +		return -ENOMEM;

Can this catch a push_stack() failure?  push_stack() returns an
ERR_PTR() on every failure path rather than NULL:

kernel/bpf/verifier.c:push_stack() {
	...
	elem = kzalloc_obj(elem, GFP_KERNEL);
	if (!elem)
		goto err;
	...
	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
		...
		return ERR_PTR(-E2BIG);
	}
	...
err:
	...
	return ERR_PTR(-ENOMEM);
}

Since an ERR_PTR is non-NULL, would 'if (!fork)' be false on failure,
letting execution continue with an error value in fork?

> +	fork_dst_regno = swapped ? insn->src_reg : insn->dst_reg;
> +	fork_dst_reg = &fork->frame[fork->curframe]->regs[fork_dst_regno];

If fork holds an ERR_PTR here, does this dereference an invalid pointer
such as (void *)-12, for example under memory pressure or when the
BPF_COMPLEXITY_LIMIT_JMP_SEQ limit is hit?

The other push_stack() callers test with IS_ERR() and return
PTR_ERR(), including the other_branch push in check_cond_jmp_op()
itself:

	other_branch = push_stack(env, *insn_idx + insn->off + 1,
				  *insn_idx, false);
	if (IS_ERR(other_branch))
		return PTR_ERR(other_branch);

Would the same IS_ERR()/PTR_ERR() pattern be more appropriate here, so
that the -E2BIG complexity limit is also honored?

> +	if (is_jmp32) {
> +		cnum32_intersect_with_srange(&dst_reg->r32, S32_MIN, -1);
> +		cnum32_intersect_with_srange(&fork_dst_reg->r32, 0, S32_MAX);
> +	} else {
> +		cnum64_intersect_with_srange(&dst_reg->r64, S64_MIN, -1);
> +		cnum64_intersect_with_srange(&fork_dst_reg->r64, 0, S64_MAX);
> +	}
> +	return 0;
> +}
> +
>  static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  			     struct bpf_insn *insn, int *insn_idx)
>  {

I could not find a later commit in this range that changes this check.

On the commit message:

There does not appear to be a Fixes: tag.  The commit message describes
this as a "verifier regression after switch to cnum based scalar
representation", where cnum{32,64}_intersect() over approximates a
[negative, positive] range when comparing with zero.

Commit bbc631085503 ("bpf: replace min/max fields with struct
cnum{32,64}") introduced the cnum based scalar representation and the
cnum{32,64}_intersect() helpers, and is an ancestor of this fix.

Should this include:

  Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,64}")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26626969604
--===============4512208004376240867==--
