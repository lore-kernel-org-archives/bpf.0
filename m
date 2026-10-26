Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986808;
	b=SH1BfE4a+6Yxmw0gzbblwpYBqNpXlp56Cjv0orac3l728YZ9NKSvdYvA6lQU18lXSCDc
	 vqYASTY5epc2Ed7KnlzIhPF4nGWyd9UcDt6MXMPt0L3toPcxACEgCaUaN89h/gVTWjCL/
	 JgLr4473cLfegyDctqpqpAZq5HX9ZOxwLT0NDOsXEb7iFt+0BbaB2BzeiyuGVjBnJnh8n
	 52YjLMadZgf9umIvKq68HTlQ5/4Jj44mfgaTRKZLb4uyKViVHlXKmXSasBtwT3hRGZEIR
	 unEWCLCmEXTHUim9wn57i0o5B96Sq8a4q1FUFxTCvaFiD7zt99oWTvQtz4bhGCllCzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986808;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mu/8MBry/zWpkDI7jHHr6uGxmrq8+ALSg/iyxGvlNRM=;
	b=LGccrwttx9CN2DpavGeeD3B9Qu1hIk/5p773mEuVnlsgcYuuHNQTJnSZZsFX2YlTCbFj
	 DmLBUyvsX8kPZBNqIOUiJK2iRU8Ey4gMwjj2b8yfmzMDotspBTPZsJq9ckn9sr2q24Gby
	 qFx8AOq3DTqUqpirJM4zejcDKaJvzuMRYw2MW3cjK4OnSyLFDonm4hhsLYVQ4p8aqJ7Le
	 MQQaCG9WrkMffsJGIEA1dwO/ivuZUgVvE2LSdbIlJQcZPhU3WDIIz+t2gCFdMIKTf/X77
	 a8ZZ2s2u3M7sqIVjo5QwEAXh5ZeggbCeYD93dQOXP8C5hSdPbmIUjQCxV0UC1/e+7MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYVvUb96;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52608606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYVvUb96
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6F11F01825;
	Mon, 26 Oct 2026 03:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986807;
	bh=mu/8MBry/zWpkDI7jHHr6uGxmrq8+ALSg/iyxGvlNRM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hYVvUb96odAJqByEhzBvmH43rO/pRPHBU885a2Tl/zVXRqCVs1Tq9ai31CHO+THMo
	 uCLbIrfiYpzbOBLGJM0UYjbV1PNMwaZtB5bce+W3n9GEgFdxX6CDU11KlL3rZwX/rh
	 CaAFuOPYUym7s2xEhwalmPvRVPY8sA4Iq802UMubuRN+OX8l6JMt24vZ+QXfFYWCf0
	 NDfJlqPxjwATz82f4zVaimF9sUb0IfmzliUd5G63pvy2DYdAKK54DjDWKUlV3yjjHV
	 YlLk7RWq6ANQnDtKWsZ1psPCpd/RewGAOUAAAbQJOr4fXcOlXK1F5Z/ldEEgNNtnYp
	 P6efRPU9W5YXQ==
Content-Type: multipart/mixed; boundary="===============4763334453890846221=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <17e2d5bac9b276ed93500fb6e09ec66618711e724137c4c011db5cea8f6ed549@mail.kernel.org>
In-Reply-To: <20261026025943.404450-69-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-69-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 68/81] bpf: Track a pointer to one of a set of functions
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:27 +0000 (UTC)

--===============4763334453890846221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Track a pointer to one of a set of functions

TL;DR: Nit, not a bug: the explicit account_current_path() in
check_func_callx_set() seems redundant, since process_bpf_exit accounts the
path anyway; the comment's rationale doesn't match, so drop the call or
explain it.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 21ea43422133..6c6980d74fd6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11757,13 +11792,92 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,

[ ... ]

> +/*
> + * callx of one of the functions of a set. A function that is verified on its own
> + * gets a copy of the state that waits for it. Nothing meets at an insn.
> + */
> +static int check_func_callx_set(struct bpf_verifier_env *env, int regno, int *insn_idx)
> +{
> +	struct bpf_verifier_state *cur = env->cur_state, *copy, *branch;
> +	struct bpf_reg_state *reg = reg_state(env, regno);
> +	struct bpf_func_set *set = env->func_sets[reg->func_set - 1];
> +	int err = 0;
> +	u32 i;
> +
> +	/* once, and not in every copy */
> +	account_current_path(env);
> +	reg->func_set = 0;
> +	for (i = 0; i < set->cnt && !err; i++) {

[ ... ]

this isn't a bug, but is the explicit account_current_path() call needed in
check_func_callx_set()?

The copies made with bpf_copy_verifier_state() start with insns_subtotal at
0, since copy_func_state() sets dst->insns_subtotal = 0 (its comment says
"Instruction accounting is path-local, not part of verifier state."), so
the account_current_path() that runs on each copy adds nothing, and the
states from push_stack() do not carry the count either.

check_func_callx_set() then returns PROCESS_BPF_EXIT, and do_check_block()
goes to process_bpf_exit:, which calls account_current_path(env) on the same
cur state:

    check_func_callx_set()
        account_current_path(env);
        ...
        return err ?: PROCESS_BPF_EXIT;
    do_check_block()
        process_bpf_exit:
            account_current_path(env);

That call would account the path exactly once even without the one in
check_func_callx_set(), so the explicit call does not seem to change any
total, and the reason given in the comment ("once, and not in every copy")
does not match how the copies behave.

If the call stays, could the comment say why?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============4763334453890846221==--
