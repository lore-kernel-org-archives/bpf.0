Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B221F427C
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191872; cv=none; b=ZxtOpy6Z0wO0Wz+LL1WvTqhwdwcwsXWkwOfHzd6yW85dm1MvrBghUJGwe2rrdKXQ+Zxbz9XTlZxNKGAKUgB3QStabvEki1OhbV54+6kqhQpcs2CyfgCd0WQ8AOTEaQkFayymoJzYD9IlfdDsQkT9UxiJeGTaIpZWxuP0TNa4fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191872; c=relaxed/simple;
	bh=EkBNF412wAbaEV6c1Hr0B2o571w8XX8SI6awEW/XFm8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DjUs7RrJI4/WvhSt+w1hjiZ1LJQU82qi1WOdn0DfxH+idolvq5XeXz2GNuRmZecwU6K8imXbLBk4YWGz4nwIjGDVRDuiStmpZtOi5Ol3QOYxuNIHEbtevRwW0jyMIdcJf1CSL6N2/9Yxw0RT5yrVIrTio5D/hMM7Mb2WlVLAxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOkGmIqA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOkGmIqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9914C2BCB2;
	Thu,  7 May 2026 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191872;
	bh=EkBNF412wAbaEV6c1Hr0B2o571w8XX8SI6awEW/XFm8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cOkGmIqA05ucB9g4UJgo6qS1JYNTaXI8wbF0HqthOLtIiGSL43wV7XqXJAx1eAyuQ
	 /gIZXOM4hzxqFsRWmKUnKw25wr9R4A2lqeGBlY91JWcXaiQhN4GR9E+9doHqhKPmnN
	 ZmI5j1Wq1muXiiF/OtwSCcK7MQgxVfl/NodqEl8+dn9e0mV4UxVRhorQHJ7zSB3KTV
	 orMzgt2Ki7p/Y1XnGUxe4Ohpl1Ub5P6v3Q07OXd9yuku0inHXvnSHqn7nALSxSpcpM
	 u+Z11VIqe6TmRa7FOuob7TfeyLJY5Zgy9bM1HzmZG1JXGAakHeeiPlrTKwKFm4JmOA
	 tOIwbO+xubIjw==
Content-Type: multipart/mixed; boundary="===============4801505717308782364=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4c0af08f7e1cf2ec96f8d6658168eae3c04c2b5dbd4b6ae42ac50f5f2aebcc85@mail.kernel.org>
In-Reply-To: <20260507213034.1130443-1-yonghong.song@linux.dev>
References: <20260507213034.1130443-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 10/23] bpf: Reject stack arguments in non-JITed programs
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 22:11:11 +0000 (UTC)

--===============4801505717308782364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ae10b9ca018d..6f94b0ef3659 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>  		goto finalize;
>
>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> +	    bpf_prog_has_kfunc_call(fp) || fp->aux->stack_arg_cnt)
>  		jit_needed = true;
>
>  	if (!bpf_prog_select_interpreter(fp))
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 0ff8cdf4394f..4c630d97eaad 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1412,6 +1412,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>  		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
>  		return -EINVAL;
>  	}
> +	for (i = 1; i < env->subprog_cnt; i++) {
> +		if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
> +			verbose(env, "stack args are not supported in non-JITed programs\n");
> +			return -EINVAL;
> +		}
> +	}
>  	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
>  		/* When JIT fails the progs with bpf2bpf calls and tail_calls
>  		 * have to be rejected, since interpreter doesn't support them yet.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323
--===============4801505717308782364==--
