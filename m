Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AF3E51D6;
	Mon,  8 Jun 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930350; cv=none; b=IU4i2BBGEooWsIthDj6y3eKGNNatmnHjeNfvJrP/8JW7y9Cv9qDmns3amDUXOh72eQ/7v7+j1Idqo1k912fe6UoOdU8r9JkwAgniYogOEGMcmGRZ6vyElw0zg7MsKq/sfFTNCxpWn816uT4AfriMw63C/D2syDqTFkhd305wxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930350; c=relaxed/simple;
	bh=YNUl08cSxcjVsWLuSvU3PxzubPIadXLuXBY58EeSacA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dwy63ppdSQY2THpWW3PsstcysmFvGgvI6kqwJL9NFf0YXFVEvkG1IzgIHffhCDnnIts947l7Ci5hIZHLuWb3Gq7t6btCfCdv/EpBiPMYysuSP2W7EVXoweJuSpXTrBYUe/qMvObD5rCGZNdseNOsLX8F//xqH7+MTqLmTmopSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAhTdaM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAhTdaM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C491F00893;
	Mon,  8 Jun 2026 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780930349;
	bh=/aRdbTDWgO4ZgjDuHaWmLxrbMDFexbxjehVFQ8ilA/Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QAhTdaM+WEbXlzXG64C+G3drz3NpbEv0dsXjNYFKwkNKVhSQiewh4DS9ZrS7oYSNB
	 3FrdPoihqhM3uFauZEFQdiB1JvaymkPxRXtxry/vjPW8USbibw9sC4lgLvRrzzoQ28
	 fBk1lGslLDdiz+2UPMK59VC58Q/N8788zdMICrgdsM/eYU65Fa9W+ZwhMaCKTYEaGk
	 /6G0rN2vIsF3F0ehfQSo/Iil5Kpo39InS1yWEyU/GN+9l1FHG4WckiEA3IxtovuBX3
	 XP/rpNNXmUf1wGAlnqGwg2XoDZnqUYGHme3XT0deot2zZvAYA5se+YfR5NdwetmaSW
	 G5D76AlAjKtIA==
Content-Type: multipart/mixed; boundary="===============2294510373569180017=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa16ced177389eff6785bbcc871babac3f2119627c8f6b34633e5202b80153c0@mail.kernel.org>
In-Reply-To: <20260608142618.3064380-2-chenyuan_fl@163.com>
References: <20260608142618.3064380-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,chenyuan_fl@163.com
Cc: andrii@kernel.org,ast@kernel.org,bot+bpf-ci@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,clm@meta.com,daniel@iogearbox.net,eddyz87@gmail.com,ihor.solodrai@linux.dev,jolsa@kernel.org,linux-kernel@vger.kernel.org,martin.lau@kernel.org,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 14:52:28 +0000 (UTC)

--===============2294510373569180017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..7e5b68c31c34 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12082,9 +12082,27 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
>
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]))
>  			continue;
>
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* kfuncs with implicit args (e.g. 'off' parameter)
> +			 * handled during verification in bpf_fixup_kfunc_call():
> +			 * obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
> +			 * refcount_acquire, list_push, rbtree_add. Don't flag them. */
> +			if (is_bpf_obj_new_kfunc(meta->func_id) ||
> +			    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
> +			    is_bpf_obj_drop_kfunc(meta->func_id) ||
> +			    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
> +			    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
> +			    is_bpf_list_push_kfunc(meta->func_id) ||
> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
> +				reg_arg_name(env, argno));

Does this reference an undeclared 'argno'?  The for-loop in
check_kfunc_args() declares only 'i' and 'regno = i + 1', and there is no
'argno' in scope here.  The only 'argno' identifiers in this file are
parameters of get_kfunc_ptr_arg_type() and process_kf_arg_ptr_to_btf_id(),
neither of which is visible inside check_kfunc_args().

Would this fail to compile with "error: 'argno' undeclared (first use in
this function)" and break the build of kernel/bpf/verifier.c?

There is also a type concern.  reg_arg_name()'s second parameter has type
argno_t, which is a struct:

  typedef struct argno { int argno; } argno_t;

so substituting the in-scope u32 'regno' would be a type mismatch rather
than a fix.  The other diagnostics in this function pass the u32 'regno'
directly, for example:

  verbose(env, "R%d is not a scalar\n", regno);

Was 'regno' (with a matching format) the intended argument here, or is an
argno_t value needed?

The range b75a2e8e..687e2f6c was checked and no later commit corrects
this, so the build break does not appear to be fixed later in the series.

> +			return -EFAULT;
> +		}
> +
>  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>
>  		if (btf_type_is_scalar(t)) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27144762590
--===============2294510373569180017==--
