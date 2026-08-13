Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23384440A1D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655465; cv=none; b=gr4WIdG8msFwKjK0nSUIJyOaMbhWaNYYBukiMmtAWaUeaGpKAl3WKa6rv2DXlzQhzaz7JLKf7Sfd9mf2MRGDaqUUjOFnSfdBK7vBSuC+RHNfduRqW1b+eg0iNdUpgfxqF0iKb6N2qQiiXR+eOlcva+MrGkfhFAKcyQ5oQXDT200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655465; c=relaxed/simple;
	bh=3TrlJozFIvu+ljlP7h3x+WrJq0Y//0HEZML+Fm5bQis=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Yn7IAth3Sp1ds7Zx42zKJ2hVM5hpWm7Njdred6L03l1ZUt5rSzeA2iIw+QkNg/oKcXcvfgNiOCeuF62uXmLxQeiZad88wP6HcEMrD8NcMOFG9tezDhOZYV4JSb/yD+t6AQd3NI1v9944OMrMYkpGyiRAzAq24x8inaEUeYoO7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHuDPKuU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHuDPKuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0B41F00A3A;
	Thu, 13 Aug 2026 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786655463;
	bh=mkvoYGLwteU3YSzuPslTFoIumYV02ZCutuaxmWjcAPk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZHuDPKuUTtMU/MK9YZesvitkkmXEJ9oFmnWsKV3DGUu9hGJTkylkT9bpZb9R/FpL3
	 WTbycVKE5DB2iO7Cdn+wscgAnPn14ZilKz4w9E8KQmrR5I9AEsoxGY6wQTyU3L1uO5
	 tYEjVgwmsNy4M/k7dmlqb4lMK7ebMPOPu8zUI+V5LUaVfHv7DbmLvRGH+2dhk/h4AV
	 nGCTrJqQI21RMxVuxwWgnp5jUwNGX+WbwuthOxg/jwI4EQygVxeUO95rEHLMJkkTUK
	 +M8iYytmY9GfKIjUtxTEuRNajLI8qtwJIdCbmnjKUm73mRHCADMuPBE4F2vyCAMX6b
	 94r1wE4dVD3PQ==
Content-Type: multipart/mixed; boundary="===============5686806011697072131=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53ea9e3097d059edd4ac58c59e33caffdce32e62674ddce7c6a94773d5723fe4@mail.kernel.org>
In-Reply-To: <20260813200220.1994468-1-yonghong.song@linux.dev>
References: <20260813200220.1994468-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 02/11] bpf: Add helpers to describe the R0:R2 return register pair
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 21:11:03 +0000 (UTC)

--===============5686806011697072131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -814,6 +814,8 @@ struct bpf_subprog_info {
>  	bool is_async_cb: 1;
>  	bool is_exception_cb: 1;
>  	bool args_cached: 1;
> +	/* true if the return value is passed in the R0:R2 register pair */
> +	bool ret_reg_pair: 1;
>  	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
>  	bool keep_fastcall_stack: 1;
>  	bool changes_pkt_data: 1;
> @@ -1048,6 +1050,13 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env, int subprog)
>  	return &env->subprog_info[subprog];
>  }
>
> +static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
> +{
> +	return subprog_info(env, subprog)->ret_reg_pair;
> +}
> +
> +bool bpf_kfunc_ret_reg_pair(struct bpf_verifier_env *env, struct bpf_insn *insn);
> +
>  struct bpf_call_summary {
>  	u8 num_params;
>  	bool is_void;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -382,29 +382,62 @@ bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog)
>  	return aux && aux[subprog].linkage == BTF_FUNC_GLOBAL;
>  }
>
> -static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
> +static const struct btf_type *subprog_ret_type(struct bpf_verifier_env *env, int subprog)
>  {
> -	const struct btf_type *type, *func, *func_proto;
> +	const struct btf_type *func, *func_proto;
>  	const struct btf *btf = env->prog->aux->btf;
>  	u32 btf_id;
>
> +	if (!btf || !env->prog->aux->func_info)
> +		return NULL;
> +
>  	btf_id = env->prog->aux->func_info[subprog].type_id;
>
> +	/* Both already validated by prepare_btf_func() at prog load. */
>  	func = btf_type_by_id(btf, btf_id);
> -	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
> -		return false;
> -
>  	func_proto = btf_type_by_id(btf, func->type);
> -	if (!func_proto)
> -		return false;
>
> -	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
> -	if (!type)
> -		return false;
> +	return btf_type_skip_modifiers(btf, func_proto->type, NULL);
> +}
>
> -	return btf_type_is_void(type);
> +static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
> +{
> +	const struct btf_type *type = subprog_ret_type(env, subprog);
> +
> +	return type && btf_type_is_void(type);
> +}
> +
> +static u32 ret_regs_cnt(u32 size)
> +{
> +	return size > 8 && size <= 16 ? 2 : 1;
>  }
>
> +static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
> +{
> +	const struct btf *btf = env->prog->aux->btf;
> +	const struct btf_type *type;
> +	int subprog;
> +	u32 size;
> +
> +	for (subprog = 0; subprog < env->subprog_cnt; subprog++) {

Does this loop need to start at subprog 0?  The main program (subprog 0)
delivers its exit code in R0 alone and never uses the R0:R2 calling
convention, so checking its BTF return type can incorrectly trigger
jit_required even though no R2 propagation is needed.

> +		type = subprog_ret_type(env, subprog);
> +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
> +			continue;
> +		if (IS_ERR(btf_resolve_size(btf, type, &size)))
> +			continue;
> +		if (ret_regs_cnt(size) > 1) {
> +			subprog_info(env, subprog)->ret_reg_pair = true;
> +			/*
> +			 * The R0:R2 return convention is only implemented in
> +			 * the JIT: the interpreter propagates BPF_R0 alone out
> +			 * of a subprogram, so a caller reading R2 would see a
> +			 * stale value.
> +			 */
> +			env->prog->jit_required = 1;
> +		}
> +	}
> +}

Additionally, should jit_required be set for subprogs whose BTF prototypes
are marked unreliable?  btf_check_subprog_call() can flag a mismatch with
prog->aux->func_info_aux[subprog].unreliable = true, and check_func_call()
only aborts on -EFAULT, so a static callee with an aggregate return can
load today without using the BTF return type. Subprogs subsequently deleted
by bpf_opt_remove_dead_code() (which runs after this pass) also don't need
jit_required set.

This changes behavior for existing programs: on CONFIG_BPF_JIT=n or
net.core.bpf_jit_enable=0, such programs would now fail in
bpf_fixup_call_args() with "program requires BPF JIT compiler but it is
not available", whereas they previously verified and ran on the
interpreter.

[ ... ]

> @@ -20333,6 +20381,9 @@
>  	if (ret < 0)
>  		goto skip_full_check;
>
> +	/* must precede the first bpf_ret_reg_pair() user below */
> +	bpf_compute_subprog_ret_regs(env);
> +
>  	ret = bpf_compute_live_registers(env);
>  	if (ret < 0)
>  		goto skip_full_check;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277
--===============5686806011697072131==--
