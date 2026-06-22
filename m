Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0D32B106
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140881; cv=none; b=OJY+liYjfrlcIQ9DQtv/aldycu/vaFB3ifGQLgoo95pyUJ3TtOdr2BQauJUgDkIYTK0HSDXDFnvKtLuQ995ajDf96V1+lBxiTfFtIU/nVYVH+80qzVc/zRWWdQ3HlMBNUl5ZlxgRMIYW9c6W/dDefaNy4bV1RZyNIekYIwLLSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140881; c=relaxed/simple;
	bh=t7rx/IKYIcE0+QcJ8cuDbNeA0noN/liC7xENEH17zAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjQ8tVYU5SRjVUMZuHwCmkNoHIygN0mNu4hppTTzBVJmml4NVaShbgXV18vOtwuUyneG/6GpWcD2sROluD1+HB3U3U+c7JWBUl9aHTbAtiLyMnUI7pkjjqa11mK3ASK2FgtqRthxXQGn2mncrpZUTXgAJGCL+7QGrPKfNrKVWlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsVgzkxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsVgzkxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9071F000E9;
	Mon, 22 Jun 2026 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782140880;
	bh=pTAw76rSPy/fuK99DrzS0EUBsZ+kpi4+53UUfqwByuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NsVgzkxj8h6edyuGwltPwNamMt14E6MKzxY4Ihg3G/wV2hMAa2Yd2GIVUs0PDthF1
	 Zdktr1azljbFm23TxY7wmIA+Jy6O2z55kbVNsElFhs6BeZSrxEhI1N+KaMkT0ohJJ5
	 FXXC5b2D76GlEsmSGI+G2sn/DGYxcRy7ReEh7DfsvzU5UFuiDqPwMCJLdiXITllJ5h
	 /Rx30EiOOOboMfqEougtyQ90gnv/P+wm/0NwOiTw+M53GB8fLx7VblHccglYQuaVCl
	 nJ1OW2Gy4xMNTqNVHXKwFYcWItRePGxHwc1PhwNMQRVoNqUD3MQeRmka9Y02ELlm51
	 TJfiB27rZlUTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 02/11] bpf: Disallow interpreter fallback
 for user BPF_ADDR_SPACE_CAST insn
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622143557.22955-3-leon.hwang@linux.dev>
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 15:07:59 +0000
Message-Id: <20260622150759.EC9071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Missing verifier log message for non-JITed programs rejected due=
 to `has_addr_space_cast_insn`.

Pre-existing issues:
- [Critical] Incomplete fix allows BPF interpreter fallback for arena progr=
ams, leading to a kernel panic.
--

commit 37ba328d18b1ffa46e00f11cf84efa654fd229ec
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Disallow interpreter fallback for user BPF_ADDR_SPACE_CAST insn

Since interpreter is unable to handle the 'insn_is_cast_user()' insn,
require JIT in __bpf_prog_select_runtime() when the prog has the insn.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f3..49398b5bd172d 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2620,6 +2620,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
>  		goto finalize;
> =20
>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> +	    fp->aux->has_addr_space_cast_insn ||
>  	    bpf_prog_has_kfunc_call(fp))
>  		jit_needed =3D true;

[Severity: Medium]
If JIT is disabled or fails, returning -ENOTSUPP here will reject the
program load silently without a verifier log message. Unlike
bpf_prog_has_kfunc_call() which provides a helpful verbose() log in
bpf_fixup_call_args():

	if (has_kfunc_call) {
		verbose(env, "calling kernel functions are not allowed in non-JITed progr=
ams\n");
		return -EINVAL;
	}

Users encountering this for has_addr_space_cast_insn will not see an
explanation for the EOPNOTSUPP error. Could we add a verifier log message
explaining why JIT is required here?

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 3cf2cc6e3ab66..2d5958774b61b 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1523,6 +1523,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  				insn->off =3D 0;
>  				insn->imm =3D 0;
>  			} /* cast from as(0) to as(1) should be handled by JIT */
> +			if (insn_is_cast_user(insn))
> +				prog->aux->has_addr_space_cast_insn =3D true;

[Severity: Critical]
This is a pre-existing issue, but the patch attempts to fix interpreter
fallback for BPF_ADDR_SPACE_CAST and fails to address the underlying panic
with arena programs.

If a program uses an arena and obtains a PTR_TO_ARENA without a cast_user
instruction (for instance, using cast_kern), or if the arena map has
BPF_F_NO_USER_CONV set, has_addr_space_cast_insn will not be set.

In the case of BPF_F_NO_USER_CONV, the instruction is rewritten to
BPF_ALU | BPF_MOV | BPF_X right before the insn_is_cast_user() check.

Memory accesses using PTR_TO_ARENA are rewritten by bpf_do_misc_fixups()
to use BPF_PROBE_MEM32 or BPF_PROBE_MEM32SX. If these arena programs fall
back to the interpreter, wouldn't they hit the BUG_ON(1) in ___bpf_prog_run=
()
because it lacks handlers for these opcodes?

kernel/bpf/core.c:___bpf_prog_run() {
    ...
	default_label:
		pr_warn("BPF interpreter: unknown opcode %02x (imm: 0x%x)\n",
			insn->code, insn->imm);
		BUG_ON(1);
    ...
}

Should jit_needed be enforced in __bpf_prog_select_runtime() for all
programs using fp->aux->arena instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622143557.2295=
5-1-leon.hwang@linux.dev?part=3D2
