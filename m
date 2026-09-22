Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216726AC5;
	Tue, 22 Sep 2026 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042464; cv=none; b=Q/nlxK93lbFdS4WQQNTiV08VvMzLZjtWd+weKEITxaeGnlCTKzJv6t0py9av8a6trQwrk9pED/iyIC7f65kAG2Djzd8aSgRFwXFEQLGd1HDAsJqCn374G3ANmq8LqoxsGgJPDuIXqJK9U9n2kAJaX+gYWeIcpGSkD5nyIv+4+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042464; c=relaxed/simple;
	bh=WCRs7ejeS4giGn0fvrZZeUNMbrOSdSUDWOlBA0hY4m4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IOJtLYUgfbNstwbDHMdJd7pSC8YaT0osoggNGCPkgkE1k8CJRg/5FwYj13BV4fWwzWQYtcDf3LFPwaB2SJRSwfbFxJ60LQT9+B5YIRG7NfcsBcm0Vi9UgNHQr6cdDX3EjxkQUTXFlWiyiARaBTNS6D0fClOiBlFNnI4bEUi15rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/X7vedm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/X7vedm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5041F000FF;
	Tue, 22 Sep 2026 02:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042462;
	bh=DKiDSbEutL1thLxpMz8sz6c1GFZHAsepLT7a4mabHYA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l/X7vedmYSLChizVKN5Du0Ax7XFqDnp/TiRqUHaRSiSwMD0D/Ac/nFTfoHikg/pto
	 O3nY+d3NwhEHhbIMy6K/IGYgHveiDrk3+VDNMuEvMGj2wfx0XH8FELtymy3Zt8YWO4
	 3hdtj8r4HmEw+96cWx/ReUCWxdSW8gKP9/zwypQSm2L4JoGD96xzcFYgs6wgMgakWF
	 PcfZbzL9437XogwmUgTLF1EO+IXvN0vuLIL7K3G9YiYTfa2wWh4LmIfwIqUMs0kgJk
	 CBCQKXIcUNtur/4EgvIkvk6QnRuwxAt4Ki5zOooFxfPFpJp+LvyMGvXTdnwhat3OD6
	 IAhhMUfe9dtag==
Content-Type: multipart/mixed; boundary="===============6506076589035665679=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bae4c16d68a135c2c698704f4632a6ce15de67cabf5cb42978746072f3b6fcd0@mail.kernel.org>
In-Reply-To: <20260922010333.1226537-2-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-2-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: Introduce REF_TYPE_FRAME in the verifier
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: ameryhung@gmail.com,emil@etsalapatis.com,npc@anthropic.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 02:01:00 +0000 (UTC)

--===============6506076589035665679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit d7733bc00f8457babb8d4c38adaf2babe3427069
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> Date:   Mon Sep 21 18:03:28 2026 -0700
>
>     bpf: Introduce REF_TYPE_FRAME in the verifier
>
>     A callback-calling helper can pass its callback a pointer that is only
>     valid for the duration of the call. The verifier just gives such an
>     argument a register type, which allows the callback to park the value,
>     or something derived from it, and make it outlive the frame. The BPF
>     program then can reuse it after the helper returns.
>
>     Invalidating a value together with everything derived from it is what
>     release_reference() already does, walking reg->parent_id across every
>     frame and stack slot. What is missing is a type of reference that is
>     not an object the program acquired and releases.
>
>     Introduce REF_TYPE_FRAME: a reference owned by a callee frame.
>     A set_callee_state_fn can declare an argument frame-scoped, and
>     setup_func_entry() turns the declaration into a reference, and
>     prepare_func_exit() drops it when the frame is popped, invalidating
>     the argument and everything derived from it through the existing walk.
>
>     Keep the new type invisible to find_reference_state(). release_reg()
>     and ref_convert_owning_non_owning() look up purely by id and could
>     otherwise destroy the anchor.
>
>     Fix up a few pre-existing comments while at it.
>
>     Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

This isn't a bug, but the changelog says release_reference() "already
does" this walk, though the patch also adds "&& reg->id != id" to it.
Would it be worth a sentence saying why - that the frame anchor has
reg->id == reg->parent_id and the DFS would otherwise re-push the same
id forever?

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index fd22db8bc6c5..d849e4873417 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3118,6 +3118,7 @@ int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
>  int map_set_for_each_callback_args(struct bpf_verifier_env *env,
>  				   struct bpf_func_state *caller,
>  				   struct bpf_func_state *callee);
> +void mark_frame_scoped_arg(struct bpf_func_state *callee, u32 regno);
>
>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
>  int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 92f528c45605..51c310ea4e82 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -387,6 +387,11 @@ struct bpf_func_state {
>  	u32 callback_depth;
>  	/* Instructions processed in this frame and callees on the current path. */
>  	u32 insns_subtotal;
> +	/*
> +	 * Set for arguments valid until the frame is popped.
> +	 * Consumed by setup_func_entry().
> +	 */
> +	u16 frame_scoped_args;
>
>  	/* The following fields should be last. See copy_func_state() */
>  	/* The state of the stack. Each element of the array describes BPF_REG_SIZE

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d62c0f74cff5..a0a9d3d18f63 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1474,14 +1474,13 @@ static int grow_stack_arg_slots(struct bpf_verifier_env *env,
>  	return 0;
>  }
>
> -/* Acquire a pointer id from the env and update the state->refs to include
> - * this new pointer reference.
> - * On success, returns a valid pointer id to associate with the register
> - * On failure, returns a negative errno.
> +/* Append an entry to @state->refs and record the instruction that created it.
> + * The caller fills in the type and the id.
> + * On success, returns the new entry. On failure, returns NULL.
>   */
> -static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
> +static struct bpf_reference_state *__acquire_reference_state(struct bpf_verifier_state *state,
> +							     int insn_idx)
>  {
> -	struct bpf_verifier_state *state = env->cur_state;
>  	int new_ofs = state->acquired_refs;
>  	int err;
>

This isn't a bug, but the comment is rewritten in the patch with
multi-line text starting on the same line as the opening "/*", while the
other three multi-line comments added by this commit use the modern
kernel style with "/*" alone on the first line. Could this one match the
others for consistency?

> @@ -1493,6 +1492,12 @@ static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_e
>  	return &state->refs[new_ofs];
>  }
>
> +static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_env *env,
> +							   int insn_idx)
> +{
> +	return __acquire_reference_state(env->cur_state, insn_idx);
> +}
> +
>  static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id)
>  {
>  	struct bpf_reference_state *s;
> @@ -1507,6 +1512,31 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
>  	return s->id;
>  }
>
> +/* Acquire a reference owned by frame @frameno of @state */
> +static int acquire_frame_reference(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
> +				   int insn_idx, u32 frameno)
> +{
> +	struct bpf_reference_state *s;
> +
> +	s = __acquire_reference_state(state, insn_idx);
> +	if (!s)
> +		return -ENOMEM;
> +	s->type = REF_TYPE_FRAME;
> +	s->id = ++env->id_gen;
> +	s->frameno = frameno;
> +	return s->id;
> +}
> +
> +/*
> + * Declare that @regno in @callee holds a value that stops being valid once the
> + * frame is popped. setup_func_entry() turns each declaration into a frame-owned
> + * reference.
> + */
> +void mark_frame_scoped_arg(struct bpf_func_state *callee, u32 regno)
> +{
> +	callee->frame_scoped_args |= BIT(regno);
> +}
> +

[ ... ]

> @@ -10175,7 +10205,7 @@ static int release_reference(struct bpf_verifier_env *env, int id)
>  				continue;
>
>  			/* Free objects derived from the current object */
> -			if (reg->parent_id == id) {
> +			if (reg->parent_id == id && reg->id != id) {
>  				err = idstack_push(idstack, reg->id);
>  				if (err)
>  					return err;

[ ... ]

> @@ -10333,6 +10392,30 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
>  	if (err)
>  		goto err_out;
>
> +	scoped_args = callee->frame_scoped_args;
> +	callee->frame_scoped_args = 0;
> +	for (regno = 0; regno < MAX_BPF_REG; regno++) {
> +		int id;
> +
> +		if (!(scoped_args & BIT(regno)))
> +			continue;
> +
> +		id = acquire_frame_reference(env, state, callsite, callee->frameno);
> +		if (id < 0) {
> +			err = id;
> +			goto err_out;
> +		}
> +		/*
> +		 * The value is its own lifetime anchor: there is no associated
> +		 * object to borrow from, only the frame. parent_id = id here
> +		 * covers both possible derived references:
> +		 *  - through the id (e.g. dynptr slice)
> +		 *  - through parent_id (e.g. dynptr clone)
> +		 */
> +		callee->regs[regno].id = id;
> +		callee->regs[regno].parent_id = id;
> +	}
> +
>  	/* only increment it after check_reg_arg() finished */
>  	state->curframe++;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35674974944
--===============6506076589035665679==--
