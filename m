Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A7126C03
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622909; cv=none; b=q7YpiOAOFa+XZ21u4flDAaf5w1Hh4piFpkblvWnQug5a2vk5WgQKrnQ6Y+lAVICdBkXNYwkZ5TOagjY1KlXZqYMTibIL1hGo4iyeVJOx4vWZaK+aSjbJLCaUAO/N2Z5zpIZiBU60n6G7anZx6pfnq5+KOxWa1Pv2XVuq22BvlSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622909; c=relaxed/simple;
	bh=dcNMSJTr0MZZ4U3WUBV+ANSTD9nOeoiwx2IOtU5RSg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k2vRGDGz/vWZpkDgutIYSAFKak+nSfpmviczr6x3JiX2oX6xWBIjhrkDZ+KV8NcY+4k2jPLf0vQCmyoRnaO52dU0Cw/oAL4tNVEInmmsd5D7IuA6e9XJWACh/EssWvtGQ75ZEyyL3LFXIzWuZUUJCfCzapPBgV9989q88zdpHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXF9Gn7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXF9Gn7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD42FC2BCAF;
	Sun, 19 Apr 2026 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776622908;
	bh=dcNMSJTr0MZZ4U3WUBV+ANSTD9nOeoiwx2IOtU5RSg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SXF9Gn7BAUwqkhATM/xlQ8j0MlPN0pVeChazOGUuo3zGMG7zdODBxMd5+pIgEQzzl
	 TB2f3+6HZ2aRiVMd9qjsIMqLpzAaNbyrAdchdySATqFHlKvc7mYDsqG656tVDM2D1g
	 NCy+C2ItN2UDdIkSTYD0bscLxDqEWWA24M8W7bkhjrmO72ezPOH8pfZhks1vIhJN6g
	 vcKneb1Bo5vh4tDVfTShb8K9xUbq1i6xNh2rLSnfdV0N+G3/CvpUt5hZqkug6ACyiu
	 WkfU3XX45mHWxYyo41we/Z/7cf94LyWO44Z09YsoY0kS5btzjQ4RU2L9LTpKBNbntu
	 +SiNvxkq3euMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 08/17] bpf: Reject stack arguments in
 non-JITed programs
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163357.734345-1-yonghong.song@linux.dev>
References: <20260419163357.734345-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 18:21:48 +0000
Message-Id: <20260419182148.BD42FC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The loop in `bpf_fixup_call_args()` incorrectly rejects main BPF p=
rograms with >5 arguments in their BTF signature when JIT is disabled, even=
 though main programs do not actually use stack arguments.
- [High] Standalone global functions with stack arguments can incorrectly f=
all back to the interpreter if JIT compilation fails, leading to a kernel p=
anic.
--

commit f56b0fedf39a845476910805e073f6b2d3a4ad82
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject stack arguments in non-JITed programs

The interpreter does not understand the bpf register r11 (BPF_REG_PARAMS)
used for stack argument addressing. So reject interpreter usage if stack
arguments are used either in the main program or any subprogram.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ae10b9ca018df..ec8523e6e4eb4 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
>  		goto finalize;
> =20
>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> +	    bpf_prog_has_kfunc_call(fp) || fp->aux->stack_arg_depth)
>  		jit_needed =3D true;

When loading a standalone global function (env->subprog_cnt <=3D 1) with >5
arguments, bpf_jit_subprogs() sets fp->aux->stack_arg_depth to 0 (the
outgoing_stack_arg_depth). If JIT is requested, bpf_fixup_call_args() will
exit early, bypassing the newly added loop that checks
incoming_stack_arg_depth.

Because fp->aux->stack_arg_depth has been cleared to 0, jit_needed evaluates
to false here.=20

If JIT compilation subsequently fails (e.g., due to memory limits or
unsupported instructions), does the kernel silently fall back to the
interpreter instead of rejecting the program?

If executed, the interpreter encounters instructions utilizing BPF_REG_PARA=
MS
(r11, mapped to regs[11]), which is initialized to 0 in the interpreter's
stack frame. Could dereferencing this register to read stack arguments
result in a NULL pointer dereference and cause a kernel panic?

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index c4e0224ad2f2e..3c9a82823913e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1411,6 +1411,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
>  		verbose(env, "calling kernel functions are not allowed in non-JITed pr=
ograms\n");
>  		return -EINVAL;
>  	}
> +	for (i =3D 0; i < env->subprog_cnt; i++) {
> +		if (env->subprog_info[i].incoming_stack_arg_depth) {

When verifying the main BPF program (i =3D 0), if the provided BTF signature
has >5 arguments, the verifier sets
env->subprog_info[0].incoming_stack_arg_depth > 0.

Although the verifier subsequently realizes this signature doesn't match the
expected single ctx argument and marks the BTF info as unreliable, it never
clears the incoming_stack_arg_depth.

Because this loop starts at i =3D 0 and unconditionally checks
incoming_stack_arg_depth, will it reject the entire program if JIT is
disabled (e.g., via sysctl net.core.bpf_jit_enable=3D0), even though main
programs do not actually use stack arguments?

Does this break backwards compatibility for existing valid BPF programs with
6+ argument BTF signatures that used to load successfully?

> +			verbose(env, "stack args are not supported in non-JITed programs\n");
> +			return -EINVAL;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D8
