Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE253D75DE
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695194; cv=none; b=rEAhxGWByMohVW9kU27I67a05iSy8I0JxoCISfQkelFmPttwHUaBuJ4hhBmZ8RCCo8wsRksqHyhlwLYugPb5cETs98mSXYNXSM2MUxi9rsgyTJgQvm96psyn2tVr7gIer+MaBDEN+ySje0upGVmoVXg2Qjn3JfhJ3GTdqEUPS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695194; c=relaxed/simple;
	bh=n/Z6IaqNLvtMPNtInIWwqenxUj3B7WwEYAeyD4kj10U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aycWQD72MkXspcT37BGHPh3YjrlwhDWkD4vfnp996XSrbpBSv6fRXlLAZMfuzmerDmOS9DICnohjq8/dSfeRQqLuj06zfCTt1JXX/4ubDGDHGt8AtlMapkp0Qryaa5N15kwFWiZEU5mDmmCNq1/mRQ1R6H3aSJJOdHWlTlY0CAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB29TBry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB29TBry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E3E1F000E9;
	Tue, 25 Aug 2026 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695192;
	bh=Ae7BzpA8kbluyK7xI5FalG0Md1rEQDHoFS7bsZAPF3k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RB29TBryaCOP2P4pH9XET9pW1P/2Y40WlGOHNXd9bgfOUdb6Xi3Pxe3aPzIRGm6Vb
	 b+LowVGuJtKRD0ljmQvsXqLrcDF8Ts+/0zTpMIGxehs4ovDuOHMzAPC37vnv1C1t0I
	 Jt7ADpSCC9GLccjD7yMJaEBZcbENB849fwMY7hOAYK4u8aHsb+xmABHeGXykYMl2NP
	 rkbVuD+mQdf4TKKCvvR0PlgfKF2sqMgPJW7XXETXoNvUn9/v+6xdgfmAKjA6MFc6YX
	 ArRVP5/xWRndCr7GZlhDaVzTcJlty/u1K17cwJaJsFtZ1PFjuveS5gVT0WJ1LckBmk
	 82BQHB3WwhhRQ==
Content-Type: multipart/mixed; boundary="===============8737326787206615633=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c7418e1614ca78be0edb20a77ae33f1cf6b4a851b6e8b786d4bf70899caf131a@mail.kernel.org>
In-Reply-To: <20260825205438.1323042-1-yonghong.song@linux.dev>
References: <20260825205438.1323042-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 05/10] bpf: Report which member makes a kfunc return type unsupported
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 21:59:52 +0000 (UTC)

--===============8737326787206615633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A kfunc that returns a struct by value may only return scalars, and the
> message that rejects one names the type but not the member at fault:
>
>   kernel function bpf_kfunc_call_test_ret_ptr returns STRUCT
>   prog_test_ret_ptr that is not composed of scalars
>
> For a large struct that leaves the reader to find the offending member
> by inspection. Record the member that made the walk fail and name it, so
> the verifier also dumps:
>
>   member 'p' has type PTR
>
> What is recorded is a path rather than a single member, because the walk
> descends up to 4 levels. For
>
>   struct outer { struct inner { void *p; } in; __u64 tag; };
>
> naming 'p' alone would send the reader looking for a member struct outer
> does not have, so the message reads "member 'in.p' has type PTR".
>
> The detailed diagnostics for this failure:
>
>   Verification failed: Program Structure: Unsupported kernel function
>   return type
>
>   Reason:
>     bpf_kfunc_call_test_ret_ptr() returns STRUCT prog_test_ret_ptr by
>     value. Its member 'p' is PTR, not a scalar. Only scalar values, or
>     structs composed of scalar values, are supported as by-value kernel
>     function return types.

Does the Reason text shown here match what the verifier actually emits?

The code at verifier.c:14120-14128 uses this format string:

  "%s() returns %s %s by value.%s "
  "Only kfuncs returning scalar values, or "
  "structures composed of scalar values are "
  "supported."

which would produce "... Only kfuncs returning scalar values, or
structures composed of scalar values are supported." but the quoted
output says "... Only scalar values, or structs composed of scalar
values, are supported as by-value kernel function return types."

The first two sentences of the Reason and the Suggestion match what the
code emits, but the third sentence appears different. Looking at the
forward range through 6ab11e51f544, commit 37ffe60f491e5 changes it again
to "... or arena pointers, or structures composed of scalar values and
arena pointers are supported." but still not the wording above.

Could the changelog be updated with the actual verifier output?

>   ...
>   Suggestion:
>     Call a kernel function that returns only scalars by value.
>
> A type nested deeper than the walk descends has no single member to
> blame, so that case reports the depth instead:
>
>   Reason:
>     bpf_kfunc_call_test_ret_deep() returns STRUCT prog_test_ret_deep by
>     value. It nests structs more than 4 levels deep. ...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5ea95e75e726a..edbc48a1fdc8f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11635,10 +11644,11 @@ static bool btf_member_kind_allowed(const struct btf *btf, const struct btf_type
>
>  /*
>   * Returns true if every member of struct @t is of a kind listed in
> - * @member_kinds, 4 levels of nesting allowed.
> + * @member_kinds, BTF_MEMBER_MAX_DEPTH levels of nesting allowed.
>   */
>  static bool btf_struct_member_walk(struct bpf_verifier_env *env, const struct btf *btf,
> -				   const struct btf_type *t, u32 member_kinds, int rec)
> +				   const struct btf_type *t, u32 member_kinds, int rec,
> +				   struct btf_member_path *path)

All external callers (btf_struct_is_composed_of() and check_kfunc_call())
pass rec=0. Could the rec parameter be removed from the public API and
initialized internally?

This was raised by Eduard Zingerman in v1 and acknowledged with "Ack, will
do" but the parameter remains in v2.

>  {
>  	const struct btf_type *member_type;
>  	const struct btf_member *member;
> @@ -11652,31 +11662,42 @@ static bool btf_struct_member_walk(struct bpf_verifier_env *env, const struct bt
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

> @@ -11686,6 +11707,18 @@ static bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>  	return btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR);
>  }
>
> +static void btf_member_path_str(const struct btf *btf, const struct btf_member_path *path,
> +				char *buf, size_t buf_sz)
> +{
> +	size_t len = 0;
> +	int i;
> +
> +	buf[0] = '\0';
> +	for (i = 0; i < path->depth; i++)
> +		len += scnprintf(buf + len, buf_sz - len, "%s%s", i ? "." : "",
> +				 btf_name_by_offset(btf, path->member[i]->name_off));
> +}

Can this handle anonymous struct/union members correctly?

BTF allows struct members to have name_off == 0 for anonymous members.
When btf_name_by_offset() is called with name_off == 0, it returns the
empty string (the start of the string table). The walk descends into
anonymous struct/union members since btf_type_is_struct() at
verifier.c:11664 returns true for both BTF_KIND_STRUCT and BTF_KIND_UNION.

For a kfunc like:

  struct ret_anon {
          union { void *p; __u64 v; };  /* anonymous union */
          __u64 tag;
  };
  __bpf_kfunc struct ret_anon bpf_kfunc_ret_anon(void);

the walk would fail on 'p' at rec == 1, so path->depth == 2 with
path->member[0] being the unnamed union and path->member[1] being 'p'.
This would produce the path string ".p" since the first component is empty
but the separator "." is still emitted.

Would it make sense to skip empty components or substitute something like
"<anon>" to keep the path readable?

> +
>  enum kfunc_ptr_arg_type {
>  	KF_ARG_CONST_MEM_SIZE,
>  	KF_ARG_MEM_SIZE,

[ ... ]

> @@ -14053,17 +14086,46 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
> -			verbose(env,
> -				"kernel function %s returns %s %s that is not composed of scalars\n",
> +		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &path)) {
> +			if (path.too_deep) {
> +				member_note = bpf_diag_fmt(
> +					env, " It nests structs more than %d levels deep.",
> +					BTF_MEMBER_MAX_DEPTH);
> +			} else if (path.depth) {
> +				const struct btf_member *bad = path.member[path.depth - 1];
> +				char bad_name[BTF_MEMBER_PATH_LEN];
> +				const struct btf_type *bad_type;
> +
> +				verbose(env,
> +					"kernel function %s returns %s %s that is not composed of scalars\n",
> +					func_name, btf_type_str(t),
> +					btf_name_by_offset(desc_btf, t->name_off));
> +				btf_member_path_str(desc_btf, &path, bad_name, sizeof(bad_name));
> +				bad_type = btf_type_skip_modifiers(desc_btf, bad->type, NULL);
> +				verbose(env, "member '%s' has type %s\n", bad_name,
> +					btf_type_str(bad_type));
> +				member_note = bpf_diag_fmt(
> +					env, " Its member '%s' is %s, not a scalar.", bad_name,
> +					btf_type_str(bad_type));
> +			}
> +			bpf_diag_program_structure(
> +				env, insn_idx, "unsupported kernel function return type",
> +				"Call a kernel function that returns only scalars by value.",
> +				"%s() returns %s %s by value.%s "
> +				"Only kfuncs returning scalar values, or "
> +				"structures composed of scalar values are "
> +				"supported.",
>  				func_name, btf_type_str(t),
> -				btf_name_by_offset(desc_btf, t->name_off));
> +				btf_name_by_offset(desc_btf, t->name_off), member_note);
>  			return -EINVAL;
>  		}
>  		mark_kfunc_ret_regs(env, regs, t->size);

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405
--===============8737326787206615633==--
