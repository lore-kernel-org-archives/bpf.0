Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFC23E33D
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814283; cv=none; b=dEiJquyDMc9FoM0cIxj1eowLY+WxUkuUTtLezHRJso9nscf9tEw4/ctPcmK+R+9ujHMsNtinht6JTCJQd+BlBh57SC4r/0zP89UnwVbrmZkS+es+Q9xMm8xpw67JtpE72WjoWS9VvGsnTt3a8ksqRfKOqPdpgww3whsCNEHFkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814283; c=relaxed/simple;
	bh=39tMhDKJd5qOYzIcolk2B0pHuBTBorzpVTdqrmI+6L4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mywpsDFMaQ8MSBeJVc+03b63dDJ88FrUjMF8tL/5PVTYNzFxHkAplMHD+xOMl/M1ynBfp9q79bA8JT95dIilW4nTz5w0o9GDd8UvkM2Gcqzb9pXLtGswdb2A8GLl8JfETSrviY2hGw027EnwdkSruBHun5AZyeSlHwguRMNi4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOx5BOsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOx5BOsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1251F000E9;
	Thu, 27 Aug 2026 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814281;
	bh=UDX52KRcNS24S+X+lGSusTxami0NFurZYstxHrrmqzI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hOx5BOsp5pLTkdh/4t6J8ff++dVjLqEuy3ogkTN/KyuqRIATATNSQ41ak+AFN22q2
	 oBpWqJhxDh7F6frGlMgY6V6TNMIPIm+ThQeGxzB/FZXxuMqwmS4sQU6rPDRARi4zdg
	 RORpDeNMbleqdF3gPiFGZ6DWuAa1hWnNszMTfWi4A9elipc/O+K6ey/rygmqQX1TLc
	 Fvakw81bEo2IDVMT1qUbfnbyKLCgl2G7N5TGNvjpsNOqghlkfQm629J7iRVRx6VN0m
	 GKTcLIPOGs4si4hHudaVVYkD3EXnKm8L4p5HJnm4S6pyH5/nBXhD9a3sMTY3jYoobD
	 lkEBRvD3dzeWw==
Content-Type: multipart/mixed; boundary="===============0788247258769171962=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a9b017abf99b3c4062bdb77e8fbbfbb7dff502ddf0b6f0b4bc459cb28a4cac8e@mail.kernel.org>
In-Reply-To: <20260827061140.2516974-1-yonghong.song@linux.dev>
References: <20260827061140.2516974-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 05/11] bpf: Report which member makes a kfunc return type unsupported
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 07:04:41 +0000 (UTC)

--===============0788247258769171962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 90139f1b78d10..967ad010b3222 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11646,6 +11646,15 @@ static bool is_kfunc_arg_implicit(const struct bpf_call_arg_meta *meta, u32 arg_
>  	return argn <= arg_idx;
>  }
>
> +#define BTF_MEMBER_MAX_DEPTH	4
> +#define BTF_MEMBER_PATH_LEN	64
> +
> +struct btf_member_path {
> +	const struct btf_member *member[BTF_MEMBER_MAX_DEPTH];
> +	int depth;
> +	bool too_deep;
> +};
> +

[ ... ]

> @@ -11676,31 +11686,42 @@ static bool btf_struct_member_walk(struct bpf_verifier_env *env, const struct bt
>
>  		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
>  		if (btf_type_is_struct(member_type)) {
> -			if (rec >= 3) {
> +			if (rec >= BTF_MEMBER_MAX_DEPTH - 1) {
>  				verbose(env, "max struct nesting depth exceeded\n");
> +				if (path)
> +					path->too_deep = true;
>  				return false;
>  			}
> -			if (!btf_struct_member_walk(env, btf, member_type, member_kinds, rec + 1))
> -				return false;
> +			if (!btf_struct_member_walk(env, btf, member_type, member_kinds,
> +						    rec + 1, path))
> +				goto bad_path;
>  			continue;
>  		}
>  		if (btf_type_is_array(member_type)) {
>  			array = btf_array(member_type);
>  			if (!array->nelems)
> -				return false;
> +				goto bad_member;
>  			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
>  		}
>  		if (!btf_member_kind_allowed(btf, member_type, member_kinds))
> -			return false;
> +			goto bad_member;
>  	}
>  	return true;
> +
> +bad_member:
> +	if (path)
> +		path->depth = rec + 1;
> +bad_path:
> +	if (path && path->depth)
> +		path->member[rec] = member;
> +	return false;
>  }

[ ... ]

> @@ -14077,17 +14114,46 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
>  			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
>  	} else if (btf_type_is_struct(t)) {
> +		struct btf_member_path path = {};
> +		const char *member_note = "";
> +
>  		/*
>  		 * The returned struct comes back as raw register bits modeled
>  		 * as an unknown scalar, so it must contain only scalars:
>  		 * otherwise a pointer field would be laundered into a scalar
>  		 * and escape provenance and reference tracking.
>  		 */
> -		if (!btf_type_is_scalar_struct(env, desc_btf, t)) {
> +		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &path)) {
>  			verbose(env,
>  				"kernel function %s returns %s %s that is not composed of scalars\n",
>  				func_name, btf_type_str(t),
>  				btf_name_by_offset(desc_btf, t->name_off));
> +			if (path.too_deep) {
> +				member_note = bpf_diag_fmt(
> +					env, " It nests structs more than %d levels deep.",
> +					BTF_MEMBER_MAX_DEPTH);
> +			} else if (path.depth) {
> +				const struct btf_member *bad = path.member[path.depth - 1];
> +				char bad_name[BTF_MEMBER_PATH_LEN];
> +				const struct btf_type *bad_type;
> +
> +				btf_member_path_str(desc_btf, &path, bad_name, sizeof(bad_name));
> +				bad_type = btf_type_skip_modifiers(desc_btf, bad->type, NULL);
> +				verbose(env, "member '%s' has type %s\n", bad_name,
> +					btf_type_str(bad_type));

For an array member, does this report the type that the walk actually
rejected?

Looking at btf_struct_member_walk(), when the member is an array it
resolves the element type before testing it:

    if (btf_type_is_array(member_type)) {
        array = btf_array(member_type);
        if (!array->nelems)
            goto bad_member;
        member_type = btf_type_skip_modifiers(btf, array->type, NULL);
    }
    if (!btf_member_kind_allowed(btf, member_type, member_kinds))
        goto bad_member;

The walk stores only the struct member itself in the path, discarding
the resolved element type. So for a kfunc returning:

    struct s { void *p[2]; };

the walk rejects the element type PTR, but this diagnostic derives
bad_type from bad->type (the array type), printing:

    member 'p' has type ARRAY
    ... Its member 'p' is ARRAY, not a scalar.

That contradicts the rule documented earlier ("An array member counts
as its element type") and the accepted behaviour of __u64 a[2], which
passes. The same issue affects struct inner arr[2] (reported as ARRAY,
real reason is the element is a non-scalar struct) and zero-length
arrays, whose rejection has nothing to do with type at all.

This is confined to verifier log text - the accept/reject decision is
unchanged - but the message the patch exists to add is inaccurate for
array members.

> +				member_note = bpf_diag_fmt(
> +					env, " Its member '%s' is %s, not a scalar.", bad_name,
> +					btf_type_str(bad_type));
> +			}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525
--===============0788247258769171962==--
