Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CE44E038;
	Wed,  3 Jun 2026 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487537; cv=none; b=EhDxtWthMwnh4hbq7BTHBzv6E7lpnkBBQ5l+ZDZj7e9ZKoC9VW0m8wSd/2FvU6C+vWfD53QEtA7K8aYrNi1s5di0dnnero1YF3EN9WUajrpK7lqU2aaDkn+WqHIGrfYZGzICGffjP28Yh9p0xxqEnvzEQmDSfCqSQwdSlh1YvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487537; c=relaxed/simple;
	bh=iKknOBccX45OSIiOLBf/YaJM6AG+5ON9quLA6N7HAk8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=j4s/XsEzKjdSLBSJUeUPUUjBt/3ucGoPDwP0MNuMGb45an1CnVx8sxmS/vAH05k4G1v/AuqBys7MerdnCJ1Grpyc1NaVfh9QctFtxgrCcL1EX+qBegha5diVth9xMMTHuphpMMhJce+hC/aKtgyiU1qSbcVfGBbYrgZqF9JQtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYEc4NtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYEc4NtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604E61F00893;
	Wed,  3 Jun 2026 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780487535;
	bh=+vVAQjWdAZ7b5pjeVclzChLnm6PM8vcxG7W6WA8m/vQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CYEc4NtTI3x4URHjNr4Lp2WmQosICBTwakkKd0ucg2FxSwxKNTaLNNobiYGiRA6EZ
	 FhQANZJp0GWpOnCVh0dOD2w8qNm6fwKKmd4DVnO178eYm1RaP00fRn/xcF5PrKuTQp
	 YIcMLviyuvABQjNwDNbxQFd49RuJmB9woAmjc2/ulUz8H6Xw/bUiu6GalimuawzaLK
	 3wrUkBeyexCN9eBN3bleMw7gXgOcdrP6HZ3KJJevoHzyADuqWfA7DpZKzYLhyKMTKG
	 QM3t7qg6jZQIXWTak2QtmBaotYOQAv7JrMHqL/upeNKq18G8iNyxmNvScZqS7pzfD/
	 i3WrdFa2dNGKQ==
Content-Type: multipart/mixed; boundary="===============7684683026492318525=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1768a26a92d5a82305d79fa5835330f4708492cc6c032aca8e6566ff8f17ee0@mail.kernel.org>
In-Reply-To: <20260603110554.29590-11-jolsa@kernel.org>
References: <20260603110554.29590-11-jolsa@kernel.org>
Subject: Re: [PATCHv7 bpf-next 10/29] bpf: Add multi tracing attach types
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 11:52:15 +0000 (UTC)

--===============7684683026492318525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4764b4aa7081..bc5a57a9faee 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2094,6 +2094,11 @@ static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
>  #endif
>  }
>
> +static inline bool is_tracing_multi(enum bpf_attach_type type)
> +{
> +	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI;
> +}
> +
>  #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>  /* This macro helps developer to register a struct_ops type and generate
>   * type information correctly. Developers should use this macro to register

[ ... ]

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index aec171ccb6ef..0cde0e2f3d4b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1155,6 +1155,8 @@ enum bpf_attach_type {
>  	BPF_TRACE_KPROBE_SESSION,
>  	BPF_TRACE_UPROBE_SESSION,
>  	BPF_TRACE_FSESSION,
> +	BPF_TRACE_FENTRY_MULTI,
> +	BPF_TRACE_FEXIT_MULTI,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a..521ec2a9051e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18699,6 +18701,11 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
>
>  #endif /* CONFIG_FUNCTION_ERROR_INJECTION */
>
> +static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
> +{
> +	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
> +}
> +
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
>  			    const struct bpf_prog *tgt_prog,
> @@ -18821,6 +18828,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		    prog_extension &&
>  		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
>  		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
> +		     tgt_prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
> +		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
>  		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
>  			/* Program extensions can extend all program types
>  			 * except fentry/fexit. The reason is the following.

[ ... ]

> @@ -18956,7 +18967,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		if (ret < 0)
>  			return ret;
>
> -		if (tgt_prog) {
> +		/*
> +		 * *.multi programs don't need an address during program
> +		 * verification, we just take the module ref if needed.
> +		 */
> +		if (is_tracing_multi_id(prog, btf_id)) {
> +			if (btf_is_module(btf)) {
> +				mod = btf_try_get_module(btf);
> +				if (!mod)
> +					return -ENOENT;
> +			}
> +			addr = 0;
> +		} else if (tgt_prog) {
>  			if (subprog == 0)
>  				addr = (long) tgt_prog->bpf_func;
>  			else

Should BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI be added to the
validation list in btf_validate_prog_ctx_type() in kernel/bpf/btf.c?

This concern was raised in v6 by bot+bpf-ci@kernel.org (message-id
23ab5817f619274a252b35119e760817c383e3c20f9ce9facccbf4b4fec9dd58
at mail.kernel.org, dated Wed, 27 May 2026):

  "The multi types are not included in btf_validate_prog_ctx_type()
  in kernel/bpf/btf.c. That function validates which attach types
  allow u64* as their ctx parameter... Since BPF_TRACE_FENTRY_MULTI
  and BPF_TRACE_FEXIT_MULTI also use u64* context, do they need to
  be added to that validation list?"

The author acknowledged this in the v6 discussion but the change has
not been included in v7. Since these multi types use the same u64*
context layout as BPF_TRACE_FENTRY and BPF_TRACE_FEXIT, should they
be added alongside those types in btf_validate_prog_ctx_type()?

Lore reference:
https://lore.kernel.org/bpf/23ab5817f619274a252b35119e760817c383e3c20f9ce9facccbf4b4fec9dd58@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26881310426
--===============7684683026492318525==--
