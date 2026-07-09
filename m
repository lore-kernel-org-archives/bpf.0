Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6E4499A1
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638976; cv=none; b=nz+BNc1sUHREVwQGjkXdPll88PTB3nOxXoLOjDflpgWir9i9T2GgU4Jnr2SBMSex6W479fjKGMlEDv82HwlvE6sBbeEHpmvh4GMWnArDYudqDJSBTNqBCJbDoPrxtlBfkaWGuHUW+R999eB6VaWSLzUf4MnbVqm96i/hYHfktpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638976; c=relaxed/simple;
	bh=hNfjj2Fa1QCBn6YE+JASbVmhu3V2AXCNc1UDkd64WW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lqhD0OQ9GmdVO79Kf8AR4H3B33Pp6UJF61I2AAR6P3jVPWewE9bOg5fvIl1g2NAulv/ZofgugWB52yZ7/4W/aStKRJyz1mP6T5Y78BbzOI/kAiCEAIeqCso0AhaWs7qTwotJXdFce0i3EFYL126l1aFUTYL1BMe8zRMaUQ5m1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc0VMCXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc0VMCXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0519D1F000E9;
	Thu,  9 Jul 2026 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783638975;
	bh=45wyXJVodmCNChUIkzhIAU2xScXx3oubOfmCnhM9WLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tc0VMCXIbyKwy4Pd2WDlxJVDHLWzIayQO35DeJ7NpCjpYU2M0aeVgLy2eH4vYfCjO
	 5aM3zKLv1FnhXvBq5m53IKTXGJhIFDNzgTFR16TrGEPscnoZXSYl3KwTM4AdUuIH1s
	 sUzcSrLn9rUKGFZNBNWgaPMo8SRAgyRlANNNaJp80j5Qa+3z9g6OTfYCYSPxaCIu9K
	 9GutlqSVaL8rBgacTbqsBXRBo2AsQRTO62GP1iboFTYI09bVKpFHUlXZfcV+rsTCJU
	 6JR+L9H3aSePfdlqNor+8Gy3t6yGMm6SuNs3pje4QzcZqOtli9w6SKArG8sKLtuSgi
	 X9l19mcTViXXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 4/4] bpf: Unify helper and kfunc call
 argument meta
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709230242.2003459-5-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
 <20260709230242.2003459-5-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 23:16:14 +0000
Message-Id: <20260709231615.0519D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack memory read in `check_kfunc_call` when handlin=
g kfunc calls in signed BPF programs.
--

--- Patch [4]: [PATCH bpf-next v1 4/4] bpf: Unify helper and kfunc call arg=
ument meta ---
commit b1105689a4b2bf6e2532e6d414d410ef55c0694b
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify helper and kfunc call argument meta
   =20
Helper and kfunc argument checking carried two separate meta structs: the
verifier-local struct bpf_call_arg_meta and bpf_kfunc_call_arg_meta.
Merge them into a single struct bpf_call_arg_meta. This is groundwork for
sharing argument checking between helpers and kfuncs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fcd9715eff017..5ccb00a8c84ce 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12972,7 +12953,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  	struct bpf_reg_state *regs =3D cur_regs(env);
>  	const char *func_name, *ptr_type_name;
>  	const struct btf_type *t, *ptr_type;
> -	struct bpf_kfunc_call_arg_meta meta;
> +	struct bpf_call_arg_meta meta;
>  	struct bpf_insn_aux_data *insn_aux;
>  	int err, insn_idx =3D *insn_idx_p;
>  	const struct btf_param *args;

[Severity: High]
This is a pre-existing issue, but does this lead to reading an uninitialized
pointer if bpf_fetch_kfunc_arg_meta() returns early?

In check_kfunc_call() in kernel/bpf/verifier.c, the local variable meta is
declared without initialization and passed to bpf_fetch_kfunc_arg_meta().
If the call to fetch_kfunc_meta() inside it returns an error like -EACCES,
it returns early before initializing meta:

kernel/bpf/verifier.c:bpf_fetch_kfunc_arg_meta() {
	struct bpf_kfunc_meta kfunc;
	int err;

	err =3D fetch_kfunc_meta(env, func_id, offset, &kfunc);
	if (err)
		return err;
    ...
}

Back in check_kfunc_call(), the error path evaluates meta.func_name:

	err =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
	if (err =3D=3D -EACCES && meta.func_name)
		verbose(env, "calling kernel function %s is not allowed\n", meta.func_nam=
e);

If the stack memory is uninitialized, could meta.func_name contain a garbage
pointer that leads to a crash or an info leak when dereferenced by vsnprintf
during the verbose() call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709230242.2003=
459-1-ameryhung@gmail.com?part=3D4
