Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77273A8384
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966557; cv=none; b=GcIU2xzmZUn8oAyI/HTZWFwqi2LWA1V7c6wBl18ZX8hrHmu8U4SNhZYvwFeTKa31t28JmPSmejo/eOOt8s+aAeWsfGFcJPyGZvV1VM5Emu8b2x+1PASXDyyWfa/SmvwKbWBG9oEXO6Y9P5GoellOQh7XdHzsOSgEfx4/wHWKmvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966557; c=relaxed/simple;
	bh=MGWpvqLVcCAw/vYsM3XzBJkqBV1vwE8BELoYIw7qxQ4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PXj17fwBDMGrUArrOx5uKdx5R6XrQg4rBJB7GrYfqSJkP72JEjWy4SKJnobvYLY+oo/WhhbYCgscG4fy77/VfOhcQbRKyhhRArsRbj+QZDGaLvQDAoq993vJRt0bg3hV4YciDB+cbTvKYycrO3LpvdXCHqtqu58JdbBbys20ec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+jM+dYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+jM+dYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8EF1F000E9;
	Wed,  5 Aug 2026 21:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966556;
	bh=2aBl3ksnk2W+h7aznZBf7dfpg8YEfpoxYYB1a+mL9rw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=N+jM+dYgOWCVthmB2h8tzWRqvTXq1/88twqi5JXUHpY4eo993zHpJyziN3KutNDXq
	 nYtVIZBkuDMXlSGCPoMe+2KvsdrbHWvx1IPkg02E7hsuqv4ptBEjIx0Jjzz/DrkYsz
	 W8QvtvGuWzfiSXyGUP2qZ39dBe7lRD6rvHCJcPEdbUkHVLqpvEaWSFeE6L13YXqQ54
	 fLoESa1KQc/hzkKRh3gvKeQYO9ZsJqX4IalOp3NnGa0dWtou6Tu6peI16PJw69FaXR
	 M658TSmJ1uBG0BFlpR9W2lFaWDd+v8ExMuCfX8Wk+Z64Tav2A/ULlLF1WQvgkDh91t
	 zZgLPKYbhMmPg==
Content-Type: multipart/mixed; boundary="===============8469776519458857496=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93b2dd2580a153431de9ccddf0c26d37b889cd91f01ba651f8ba4c8efc5a7cfc@mail.kernel.org>
In-Reply-To: <20260805210427.3218326-3-memxor@gmail.com>
References: <20260805210427.3218326-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 02/13] bpf: Split subprogram and kfunc collection
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 21:49:15 +0000 (UTC)

--===============8469776519458857496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 129e50888b90..24b163c2bd63 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2842,7 +2842,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
>  	return 0;
>  }
>
> -static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
> +static int add_subprogs(struct bpf_verifier_env *env)

The rename of add_subprog_and_kfunc() leaves a dangling reference in
kernel/sched/ext/ext.c. The comment in scx_kfunc_filter() still says:

	/*
	 * add_subprog_and_kfunc() collects all kfunc calls, including dead code
	 * guarded by bpf_ksym_exists(), before check_attach_btf_id() sets
	 * prog->aux->st_ops. Allow all kfuncs when st_ops is not yet set;
	 * do_check_main() re-runs the filter with st_ops set and enforces the
	 * actual restrictions.
	 */

Should this be updated to reference add_kfuncs() instead?

>  {
>  	struct bpf_subprog_info *subprog = env->subprog_info;
>  	int i, ret, insn_cnt = env->prog->len, ex_cb_insn;

[ ... ]

> @@ -2905,6 +2900,28 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
>  	return 0;
>  }
>
> +static int add_kfuncs(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn *insn = env->prog->insnsi;
> +	int i, ret, insn_cnt = env->prog->len;
> +
> +	for (i = 0; i < insn_cnt; i++, insn++) {
> +		if (!bpf_pseudo_kfunc_call(insn))
> +			continue;
> +
> +		if (!env->bpf_capable) {
> +			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
> +			return -EPERM;
> +		}
> +
> +		ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -20322,7 +20339,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
>
> -	ret = add_subprog_and_kfunc(env);
> +	/* Discover all subprograms before validating their layout and BTF. */
> +	ret = add_subprogs(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
> +	/* Collect the kfunc descriptors used during verification. */
> +	ret = add_kfuncs(env);
>  	if (ret < 0)
>  		goto skip_full_check;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31047716344
--===============8469776519458857496==--
