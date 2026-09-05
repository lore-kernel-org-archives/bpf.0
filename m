Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B373264DD
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649714; cv=none; b=Sis2qAfCGZ2+ma5v1sy3Uxee7ZGsA4xPT4MvBt/PmNxoiLMelAWwlX/awZWCveykES9xh3zZ8lAV54i+x64AMtCZH2OVsW6hmdPZT1fv+MjyqDtvkXC6Dua9zv65eltxFi4Kuhr+iUQzqMgJk3+bZGnRCdj+eWGxLt9gpcyj78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649714; c=relaxed/simple;
	bh=4W1o8arDmyP0XN6ysoqC3TJ8N/OWG8ExHbUuTttuhNs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rX6YtGlLu0inXJ+YzR3yR98nJvAx+C4s/82vjdw7OONAx8bVjNdywWxazuXmZgc8/U1D0/cRXHZE6ebkG4Qb/SwNp4R1rhNPY2Yg9S/RL6Dr18TJLFQU8npzo976R7UKZWrDNa+/SVkP8+nSfAxG4v1oDzOY0kRIDtd520N0EkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e92jqQB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e92jqQB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6961F00A3D;
	Sat,  5 Sep 2026 23:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649712;
	bh=yV4tWkoS7ILsao87flOcpKs1OtiwSJGCOV+4iz8w7pc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e92jqQB7ZjnZrfu8SCjBHI8npW0jUYmeg//svblgv511KEaU8THdg3BYBpnnHDHJ/
	 9/4aX5ABw0CbMjaKWrPtedZ3Y1BRKg3ZdBb8lylBRSATnOzx/YdIwh40VlD1sdV0ee
	 qxtd7z/ikSOH34fVVO6RuJa4CmBjAwhxEyouYv8B5M64ySY/b8IyLU5zaFPhDudXIZ
	 muH3QJNdTx86vcgSDsEEQhtw4/BfU37y2u6T/OYsgZG6CxRQhaMYGPAOptA6in6Ctt
	 F6TqrZi4cGyznqL4n9utQWQMVza1dHypcXlHhn+Z1L0BtHy/0ilrXFWAgbIVnzWHBo
	 velcsB3GlamQg==
Content-Type: multipart/mixed; boundary="===============6641046982242341562=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <340e5dbc173faa706ec7029f44c75431cced19fe03e2d18f9ebdbe418ec021ef@mail.kernel.org>
In-Reply-To: <20260905220117.922028-13-ameryhung@gmail.com>
References: <20260905220117.922028-13-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/22] bpf: Resolve BTF ID of ARG_PTR_TO_BTF_ID in kfunc bpf_func_proto
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 23:08:32 +0000 (UTC)

--===============6641046982242341562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1f78746e0601..fe6ab92ceeff 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1020,13 +1020,13 @@ struct bpf_func_proto {
>  	};
>  	union {
>  		struct {
> -			u32 *arg1_btf_id;
> -			u32 *arg2_btf_id;
> -			u32 *arg3_btf_id;
> -			u32 *arg4_btf_id;
> -			u32 *arg5_btf_id;
> +			const u32 *arg1_btf_id;
> +			const u32 *arg2_btf_id;
> +			const u32 *arg3_btf_id;
> +			const u32 *arg4_btf_id;
> +			const u32 *arg5_btf_id;
>  		};
> -		u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
> +		const u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
>  		struct {
>  			size_t arg1_size;
>  			size_t arg2_size;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c5b394e847e6..b6e36df72d13 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12082,13 +12082,18 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
>
>  static int
>  get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
> -		   const struct btf_param *args, int arg, int nargs)
> +		   const struct btf_param *args, int arg, int nargs,
> +		   struct bpf_func_proto *proto)
>  {
>  	const struct btf_type *t, *ref_t = NULL;
> +	const u32 *ref_id_ptr = NULL;
>  	argno_t argno = argno_from_arg(arg + 1);
>  	const char *ref_tname = NULL;
> +	u32 ref_id;
>  	int arg_type;
>
> +	proto->arg_btf_id[arg] = NULL;
> +
>  	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
>  		return ARG_PTR_TO_PROG_AUX;
>
> @@ -12116,7 +12121,11 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  			reg_arg_name(env, argno), btf_type_str(t));
>  		return -EINVAL;
>  	}
> -	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
> +	/* Keep a pointer to the BTF field containing the resolved referent ID. */
> +	ref_id_ptr = &t->type;
> +	ref_t = btf_type_skip_modifiers(meta->btf, *ref_id_ptr, &ref_id);
> +	while (*ref_id_ptr != ref_id)
> +		ref_id_ptr = &btf_type_by_id(meta->btf, *ref_id_ptr)->type;
>  	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
>
>  	/* In this function, we verify the kfunc's BTF as per the argument type,

[ ... ]

> @@ -12239,13 +12248,21 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  	if (is_kfunc_release(meta) && arg == 0)
>  		arg_type |= OBJ_RELEASE;
>
> -	/*
> -	 * A KF_RCU kfunc accepts an RCU-protected pointer where it would
> -	 * otherwise demand a referenced or trusted one. Only ARG_PTR_TO_BTF_ID
> -	 * looks at where its register came from, so leave the other kinds alone.
> -	 */
> -	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID && is_kfunc_rcu(meta))
> -		arg_type |= MEM_RCU;
> +	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
> +		/* A __map argument names a vmlinux type rather than one from
> +		 * the kfunc's own BTF.
> +		 */
                   ^^^^

This isn't a bug, but both multi-line comments added in this block start
their text on the same line as the opening '/*'. The BPF subsystem's
comment style puts the opening '/*' on its own line. The second comment
below rewrites one that was previously in the preferred style (with '/*'
on its own line), and another comment added by this patch in
check_kfunc_args() does follow the standard. Could these two be
reformatted to match?

> +		if (is_kfunc_arg_map(meta->btf, &args[arg]))
> +			proto->arg_btf_id[arg] = reg2btf_ids[CONST_PTR_TO_MAP];
> +		else
> +			proto->arg_btf_id[arg] = ref_id_ptr;
> +
> +		/* A KF_RCU kfunc accepts an RCU-protected pointer where it would
> +		 * otherwise demand a referenced or trusted one.
> +		 */
                   ^^^^

> +		if (is_kfunc_rcu(meta))
> +			arg_type |= MEM_RCU;
> +	}
>
>  	return arg_type;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============6641046982242341562==--
