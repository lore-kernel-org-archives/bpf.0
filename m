Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4703DFC8A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269781; cv=none; b=oHGF1P/ky5uADO4IIbfFWiioRicMVCnCqh3mV/6+wyUCEqLsul7J+wgwRv3A6bQfd4EJ5cbrK0HZLn1oqHS1251Ki0GdZ9J1lMPuoY2K+wB34/LdCzXZZUZGx5EEFUXioq52SYVnUGRbyZChnDTPzBT+L2g30i/k5Ro1KRVhJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269781; c=relaxed/simple;
	bh=DHav5bQXEaaLQ+yTnyTTphZsFwbWgQX8AXpdYD3Y2cs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBbtVTlfaC6uzwFzUx0AUzHPNj7/8yvT837jbXO0fmkvquCAoRQMhhAQTGyKwUseMw6bOlQNUuNDcR5m09fMFQSY/sDwOkZQkBUulOFZ0Qs2aQHCRwPZEeo9PdV4KcrAiqkGzswS37Dk6hwazv+7+XSeGyx5SJPBFVbTfx2LkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaMYmUl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaMYmUl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C900A1F00893;
	Thu, 24 Sep 2026 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269780;
	bh=F0TJ6ylOSQEd3+ZQjBBbXCYVwAjymd2h46WyKnfX3uI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CaMYmUl0GsCp2A2v4SiErlqtMtKxL4h0CS9M9ql2FeHZxf6W5MtGuXVjzk7/YHj/u
	 q7CJnyKGXEg1BKgfQlnFAlrfhDLiwsqe6LEOaGkmyxzj+Aq0O65boFjeoWtVRu58Fw
	 n15uxqV0A0lRLqysFV2i6CPpvGkscNs+yQfeN5AyqGyJ0y7bVBMJ7qou+EbBgcPslF
	 0hbMhZAFaLAyqSfSEkFCFRJoPxj5ZVEq/ce/B+TmsnfdxfWz3DjjgEvbXixPntysST
	 7zXinL32qNFZIWKd9b3jtvVAhpVczTcB5YCdMeT6DJ5kVwO1GAVUR4XAxHrx+JUcLE
	 61xxC8bHUWemg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 13/18] bpf: Bound program stack use by a
 per-program limit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924163144.1945455-14-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
 <20260924163144.1945455-14-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:09:39 +0000
Message-Id: <20260924170939.C900A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: Kernel stack overflow via freplace and clone_redirect
--

commit 965b542914128f591e61e52c8dcea845af6187dc
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Bound program stack use by a per-program limit

This commit allows BPF programs to have larger stack limits up to
MAX_BPF_STACK_JIT when supported by the JIT. It also bounds liveness and
spill/fill tracking to the program's actual budget, falling back to 512
bytes for datapath re-entering programs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -22283,6 +22286,26 @@ static int bpf_prog_verify_signature(struct bpf_=
verifier_env *env,
>  	return err;
>  }
> =20
> +/*
> + * bpf_clone_redirect() transmits from inside the program, so a tc egres=
s or
> + * lwt_xmit program that redirects to its own device runs again on top o=
f its
> + * own frame, and again from there, until the datapath's recursion limit=
 drops
> + * the packet: ten frames deep. Ten MAX_BPF_STACK frames fit the kernel =
stack
> + * as they always did; ten MAX_BPF_STACK_JIT frames would not, so a prog=
ram
> + * calling it keeps the smaller budget. The redirect helpers that transm=
it
> + * after the program has returned leave no frame behind.
> + */
> +static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog)
> +{
> +	const struct bpf_insn *insn =3D prog->insnsi;
> +	int i;
> +
> +	for (i =3D 0; i < prog->len; i++, insn++)
> +		if (bpf_helper_call(insn) && insn->imm =3D=3D BPF_FUNC_clone_redirect)
> +			return true;
> +	return false;
> +}

[Severity: High]
Does this static scan miss BPF_FUNC_clone_redirect calls embedded in
subsequently attached freplace extensions or tail calls?

Since bpf_prog_reenters_datapath() only checks the target program's
instructions at load time, it might fail to detect when a program re-enters
the datapath through dynamic composition.

> +
>  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uat=
tr,
>  	      struct bpf_log_attr *attr_log)
>  {
> @@ -22307,6 +22330,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
>  	env->bt.env =3D env;
>  	env->prog =3D *prog;
>  	env->ops =3D bpf_verifier_ops[env->prog->type];
> +	env->stack_limit =3D bpf_prog_stack_limit(env->prog);
> +	if (bpf_prog_reenters_datapath(env->prog))
> +		env->stack_limit =3D MAX_BPF_STACK;

[Severity: High]
Is it possible for a privileged user to bypass this stack limit check via
freplace and cause a kernel stack overflow?

If a base TC program uses up to 2048 bytes of stack (no clone_redirect
present, so it receives the MAX_BPF_STACK_JIT budget) and an EXT (freplace)
program uses up to 512 bytes of stack and calls bpf_clone_redirect, the
user can attach the EXT program to a global function in the TC program.

When a packet triggers the TC program, the combined stack frame per
invocation is 2048 + 512 =3D 2560 bytes. The bpf_clone_redirect helper
synchronously re-enters the networking datapath via dev_queue_xmit(),
triggering the TC program again.

With the datapath recursion limit of 10, this results in 10 * (~2560 +
network overhead) bytes of stack usage, blowing past the standard 16KB
kernel stack limit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924163144.1945=
455-1-memxor@gmail.com?part=3D13
