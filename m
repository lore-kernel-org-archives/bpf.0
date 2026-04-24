Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A33358CA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053635; cv=none; b=nzbUlgXQIuoDkx+Hdo47ENuEakOZDyp2HttTIzM+Pi/nx44dKliSP8zhG/nlbYrTTtCLPtyahEP18sjw7Wyl9FB5WOA2e/y/lmGd7wHsQ4ZAwLcc0qBYgtQ6dkwOoaIfWxpmNs6aGK5Qn0ZZAtxFsszeYpmbx423pQTh0xifn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053635; c=relaxed/simple;
	bh=6zbOn0QpXCxgk4FetNx8xULheudErwqkxJqWUBRHEUg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sEuiJHKtHhThUpYlMD9CxC1/kSI4mcjkiuBmv8tSCpzkgiL5mjOgli2eCN1aGhouubFDkOtOLktpn7RA2fTmRV3Ab9UYvbGm73u/E7I8lqubBUlWNL+FfdKmRRqh29UYLw7kGuEt/AO4j/1Cd2IYMX9EgukRpLR4ql+lA0cuqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy4DPqQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy4DPqQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC26FC19425;
	Fri, 24 Apr 2026 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053635;
	bh=6zbOn0QpXCxgk4FetNx8xULheudErwqkxJqWUBRHEUg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Gy4DPqQg/lFA1ho6VpI/I1yHGBQej2xVoX73xJic/RReJKzbE6Z5JNpztqc84ojDN
	 LYjlvj4c5YG1i/a8d7Run3faCspyOiPRvWcnHU03EjdjTTQwkgXX+qNNL1EfkS9Mqw
	 O/DCM00seL8cSb3xSSA2ePvuNpuRPHk3lXFrGWNU+7P2/ZPc3qk0Ec7P/fo+vH9mKg
	 HmJlg9h4EV7TYbbUfL4Dryx2qBusQ1G/+NPtNQw56KwgT6SjHeuKwDHZrrHU4i2y6C
	 /bj33Mxk0r8kUX/+DB2rGkemrBQImvT1h2pc7IybFAx11DL/13lDa6SzjHC+/zk2UI
	 Ojjt601vke4mQ==
Content-Type: multipart/mixed; boundary="===============2364100487952684374=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <48cff737f2ae3dc5351760beb27d0638f245bd92c9d1a8bb71340a7de0c6798b@mail.kernel.org>
In-Reply-To: <20260424171459.2036024-1-yonghong.song@linux.dev>
References: <20260424171459.2036024-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 05/18] bpf: Reject stack arguments in non-JITed programs
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 18:00:34 +0000 (UTC)

--===============2364100487952684374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ae10b9ca018d..ec8523e6e4eb 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>  		goto finalize;
>
>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> +	    bpf_prog_has_kfunc_call(fp) || fp->aux->stack_arg_depth)
>  		jit_needed = true;
>
>  	if (!bpf_prog_select_interpreter(fp))
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 7d276208f3cc..86576f5cfe82 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1411,6 +1411,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>  		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
>  		return -EINVAL;
>  	}
> +	for (i = 1; i < env->subprog_cnt; i++) {
> +		if (env->subprog_info[i].incoming_stack_arg_depth) {
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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
--===============2364100487952684374==--
