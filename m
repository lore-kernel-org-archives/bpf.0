Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C392236FD
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480388; cv=none; b=PHSe50sT+2bKymgkcptdrVVBdi23OlTiimlKP0CB2Bes5HpP2YRadfokT7z8ReJSNPN3d1RDDd3cpwliRVSY7ayprECPipCI18EbTkiDw8f8WSWa+n68bcJAE71ydykwseAgAxPFS+FVTqy2gJNZvCNlRoB5OqQOUfu3dq2wZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480388; c=relaxed/simple;
	bh=FyWBS7Nu+mylYwJFqqBIRfHYFxzPmQ79LKCl5im6iJ0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TR8wZPjopt32uVw1h3CyxHECp2mJpNTLjHxOcfh8Dp/GHht4zz2pSCugvIRLZaKsYY/1tI8mKqPquqF8UUSA65RILBtIcnuUopat0cJEo8PsJQbY3O0ZX9Yo59lyxL/5OElvIXsu1Qf1dlvS8sWEX21B8qrIwQJi4/KHPQ8azJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie+nH+Jy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie+nH+Jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E42C2BCB0;
	Mon, 11 May 2026 06:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778480387;
	bh=FyWBS7Nu+mylYwJFqqBIRfHYFxzPmQ79LKCl5im6iJ0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ie+nH+JyyaX+HnfB/pKlkUkdwhVz7OqGRniMiqQJ/OS6p1V7YGlteRdWEQQW/ikCC
	 uDVgMeylgJM5GA6hcTESV2WF2EK8k0murTL2F79kQdbEkLqvgSsITQpMW2EyDYH7NJ
	 XnPkqlJ0wjnGCgQKteWB42doreetMtP9yEpAHiIXwxg/Eiz7nEGOmi5XrXCcWblm3H
	 Q2MCrexmp5BbmM0vE8ShrytGvn1YM5MEjM5ZQTAEAb/Avdj1mZyL/s41/BicU5jr69
	 MeQEVSpuT3maAF8rKlNg1l0fChkNgjEzW5HEfmEiINrPxkdXrDDzZcMt6qwU1CDU37
	 B2Weipz7EtL+w==
Content-Type: multipart/mixed; boundary="===============3579394313629818839=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7cbf61dc320a82fb5fa7e60ca9422b59c2d679468a17288ca0d35c0e8e5fc11a@mail.kernel.org>
In-Reply-To: <20260511053353.1885466-1-yonghong.song@linux.dev>
References: <20260511053353.1885466-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 10/24] bpf: Reject stack arguments in non-JITed programs
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 06:19:47 +0000 (UTC)

--===============3579394313629818839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject stack arguments in non-JITed programs

This isn't a bug, but should this commit include a Fixes: tag? This
appears to be fixing an issue introduced by commit 3330ee8db989
("bpf: Support stack arguments for bpf functions").

> The interpreter does not understand the bpf register r11
> (BPF_REG_PARAMS) used for stack arguments. So reject interpreter
> usage if stack arguments are used either in the main program or
> any subprogram.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ae10b9ca018d..958d86f0beac 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>  		goto finalize;
>
>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> +	    bpf_prog_has_kfunc_call(fp) || (env && env->subprog_info[0].stack_arg_cnt))
>  		jit_needed = true;
>
>  	if (!bpf_prog_select_interpreter(fp))
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index ba86039789fd..19056016eed8 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1407,6 +1407,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893
--===============3579394313629818839==--
