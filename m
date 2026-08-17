Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A82FE042
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 05:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943849; cv=none; b=bAzdLAs2x4G6849Efdz5w6+5CqhvG1cw2Qi/weY2MTvuTfDslP6YnDgiFW+dj9wHnvBNYOh/ypCqYYRvJHklWdtukZtOLgW0zC83bRVIPZxjOcnoc2httHX7yaR511miNlRgDWBl+ABQS4BE0MUd2Nkg0TOT90JJ68qGHGEyh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943849; c=relaxed/simple;
	bh=Q1WpyzRwhhFbFgkChidOQQC6QzwpsDQu1hPxCwYfHbw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uFXQ66p/IiZLSClsS0SqzwPzD173F1U94Eilrr+Hw5IO3BCAXNtCExesfL1WC4KnywmStzX1tGW2osK/hz1k2rMqpAsmLdOQFyoQUo8dOZjUgRBgSLzH5EX58eAeZl4CLXhrCCtlMX1+tdEwAz5q/hehhZ1fIrxPyElAvEf+SPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijzWDOeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijzWDOeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AEA1F000E9;
	Mon, 17 Aug 2026 05:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786943848;
	bh=k4fg+0YnkVxNGLhQhuUbGKDokHvHZF4MCAEUP9f5XxE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ijzWDOeQGQFdrKaCb0FfXHJCuzLLRYrWIGQLe9EbQp0mZMZjqCd2gNiR3n6Alzaqb
	 vigcDiH0E4QGN13JnYEWgMBettbggcO1hPbREfGwiJzFbUPf2O+HMznvDWE/UdUQRB
	 6gei8OALv6fk/tTThB4HG1VmtvYCb8D5eERhElGW2HigEFO115o8Lk+hdXOazuSIho
	 UHXkgd/fKaeqw7cYo6YF88th1lD+OqOm+ueJ3xRQQdPNrnin+eamVtCBFmPaokKf64
	 gmQjQB9tlTaeN+7TVnBh+R1kPyxvSmoGPf75rFEXIiUUcfmxY7p21bE+8KoM2GHNyg
	 GNIh6nVATIvow==
Content-Type: multipart/mixed; boundary="===============7062803518114845764=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <39fd72ee111c2f2a329c7bc32fe889598efc9e274bebb10c7aae0e09820da37e@mail.kernel.org>
In-Reply-To: <20260817042151.2286855-1-yonghong.song@linux.dev>
References: <20260817042151.2286855-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 02/10] bpf: Add helpers to describe the R0:R2 return register pair
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 05:17:27 +0000 (UTC)

--===============7062803518114845764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>8 but <=16 bytes). It introduces bpf_compute_subprog_ret_regs() to
derive this from BTF prototypes.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index bc2af02547fe..f70d5878fbff 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -819,6 +819,8 @@ struct bpf_subprog_info {
>  	bool is_async_cb: 1;
>  	bool is_exception_cb: 1;
>  	bool args_cached: 1;
> +	/* true if the return value is passed in the R0:R2 register pair */
> +	bool ret_reg_pair: 1;
>  	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
>  	bool keep_fastcall_stack: 1;
>  	bool changes_pkt_data: 1;
> @@ -1055,6 +1057,11 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env
>  	return &env->subprog_info[subprog];
>  }
>
> +static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
> +{
> +	return subprog_info(env, subprog)->ret_reg_pair;
> +}
> +

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b3c474ba7140..f1f1268d29c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -385,27 +385,70 @@ bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog)
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
> +}
> +
> +static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
> +{
> +	const struct btf *btf = env->prog->aux->btf;
> +	const struct btf_type *type;
> +	int subprog;
> +	u32 size;
> +
> +	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
> +		return 0;
> +
> +	/*
> +	 * Skip the main program: its return value is the program's exit code,
> +	 * read out of R0, so it never uses the register pair. An extension does
> +	 * have a real prototype for subprog 0, but bpf_check_attach_target()
> +	 * refuses to replace a function returning more than 8 bytes.
> +	 */
> +	for (subprog = 1; subprog < env->subprog_cnt; subprog++) {
> +		type = subprog_ret_type(env, subprog);
> +		/*
> +		 * This runs before btf_validate_return_type(), so apply the same
> +		 * type filter here.
> +		 */
> +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
> +			continue;

Does the comment's claim about applying "the same type filter" hold?

btf_validate_return_type() accepts void, int, or enum types via:

kernel/bpf/btf.c:btf_validate_return_type() {
    /* We always accept void or scalars. */
    if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
        return 0;

    return -EOPNOTSUPP;
}

The new filter instead accepts struct/union or scalar (int or enum, but
not ENUM64):

    if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))

btf_type_is_scalar() is defined as btf_type_is_int() || btf_type_is_enum(),
and btf_type_is_enum() excludes BTF_KIND_ENUM64.

The filters differ in several ways. btf_validate_return_type() accepts
void and ENUM64 (via btf_is_any_enum()) but rejects struct/union at this
commit. The new filter accepts struct/union but filters out void and
ENUM64.

The divergence is harmless since every dropped type is at most 8 bytes and
would need only one register anyway. But the comment implies an equivalence
that does not exist, and specifically suggests structs are validated
elsewhere when btf_validate_return_type() at this commit still rejects
them with -EOPNOTSUPP.

Would describing what the filter actually needs be clearer? Something like
"only struct/union and integer/enum returns can exceed 8 bytes and need
sizing" rather than claiming parity with btf_validate_return_type()?

> +		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
> +				    "cannot size return type of subprog %d", subprog))
> +			return -EFAULT;
> +		if (ret_regs_cnt(size) > 1) {
> +			subprog_info(env, subprog)->ret_reg_pair = true;
> +			env->prog->jit_required = 1;
> +		}
> +	}
> +
> +	return 0;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31995069373
--===============7062803518114845764==--
