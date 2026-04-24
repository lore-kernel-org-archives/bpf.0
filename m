Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B13E6DD4
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052890; cv=none; b=gYE14NPXcPbpkdt9ogaVcaJluzo2YzMKZrH4ZRCMCjv7Bl/h3FBPAebs9vUVvbnixut9XDlPn5M1E9fpDlNAn4IkAoMpofx9t6GRdETw8cK1Js2FLxxqqQoIW9+wc2rDvYyMgNkaaKu/g8pXaSwIxe4o4SizZBLlUS5Fen9GXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052890; c=relaxed/simple;
	bh=Oc8h0/380/Sw4uffJmnRGsZF0wEWfcOYUVESED7sYcA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=j75O4peHjfPoQSZuEZZM9msiAVoH1vIUqxUXO0FzdOiGjBPdK4bnMOuWpoVZZs//hy5x+0jTFMh/LgA13f1dk/hFQKpeCMd0bd2R1LSEhhvc1M1LWZeZfWivsBAzAVQKYIi3JohHj37tYyEnPHPXpAEKdJFjYTU5LcEVwWnOUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfO9IR8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfO9IR8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10531C19425;
	Fri, 24 Apr 2026 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052890;
	bh=Oc8h0/380/Sw4uffJmnRGsZF0wEWfcOYUVESED7sYcA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VfO9IR8voXpb1OHrRqNzMLXs/tsl7W9fpcFQftT9LE/guaqnuZv18jnBqBzuzZh0D
	 71GqgIj9gUXaSTGBXm2DegsdSpOFyQOeBEDTrmMyCWboATFdcJpvIhaJYWvXdGooWT
	 RMemBCqneGM6K2I8z2AjW1pFehYIFhq4s6KyQjvOkAM41o0VaNARvWHd7CljXQqgbE
	 j/RjPLKebVTmFv9h6FHApNYS/k7DofJ4hV7oBhN4saS3cWxGxV1vo/RUv05o3RDg1R
	 lycw+id9C3+z3g3249L1SHgurdGaCepG9eQSVgxX7BjSqJ9SfJYbLmrQCiub3w+3gW
	 WJtvmqm+IIJFQ==
Content-Type: multipart/mixed; boundary="===============8198986770197717316=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <040596e7a15775a0a56f0acefecd21dc43ff423e157324315f7a4b36c8b51e82@mail.kernel.org>
In-Reply-To: <20260424171504.2039094-1-yonghong.song@linux.dev>
References: <20260424171504.2039094-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 06/18] bpf: Prepare architecture JIT support for stack arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 17:48:10 +0000 (UTC)

--===============8198986770197717316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index b77d0b06db6e..911205dd670e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index cfb35a2decf6..fa4b971c5289 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ec8523e6e4eb..7522b3d7b267 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e041c182c614..0ba140dabe93 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12254,6 +12254,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			MAX_BPF_FUNC_REG_ARGS);
>  		return -EINVAL;
>  	}
> +	if (nargs > MAX_BPF_FUNC_REG_ARGS && !bpf_jit_supports_stack_args()) {
> +		verbose(env, "JIT does not support kfunc %s() with %d args\n",
> +			func_name, nargs);
> +		return -ENOTSUPP;
> +	}

Can this new check ever execute? The existing check immediately above already
rejects all kfuncs with nargs > MAX_BPF_FUNC_REG_ARGS by returning -EINVAL.

Since control only reaches the new if statement when the previous check
passes, nargs must be <= MAX_BPF_FUNC_REG_ARGS. The condition
'nargs > MAX_BPF_FUNC_REG_ARGS' in the new check is therefore always false
at this point.

Looking at the commit message's statement "Reject BPF functions and kfuncs
with more than 5 parameters at verification time if the architecture does not
support stack arguments," it appears the intention was to conditionally reject
based on JIT support. However, for kfuncs, the unconditional rejection
happens first.

The btf_prepare_func_args() change does work as intended because its earlier
guards allow nargs up to MAX_BPF_FUNC_ARGS for certain subprogs before
reaching the stack-args check.

A later commit in this series (73a990fcc429) raises the first check in
check_kfunc_args() from MAX_BPF_FUNC_REG_ARGS to MAX_BPF_FUNC_ARGS, which
would make the new branch reachable. Should this hunk be combined with that
change to avoid introducing unreachable code?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
--===============8198986770197717316==--
