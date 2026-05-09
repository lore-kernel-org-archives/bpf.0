Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A124B28
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292620; cv=none; b=pKmgb4DFnM4Tz8IsxjLNfZBKK52VvrG2R4AFVGzbCFs0nOq9JGe/ORZ1laiy6vxzESgBem69FNRQ7mvx6AmJU2+7OojTclbCcMAuQ/+TWCeKS4y9vxe7ZMhrIUMOOc5S1bJ2rwd/R/p3emGGLOVOGA0zxhyPHFB+XT6kj4QJXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292620; c=relaxed/simple;
	bh=5MqL9blVwzlyowJgu3GjveMMNQOLPC5VCLZ3lBViHXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tO5wz4tuidNP6arXVJQ8+6mzKIfcj4E8JLy3gOz2mGBkEXIGlQm32ePtd1REAYogTtGIsiazOyfdWfo1Yfhe98h03pGCAQUHY/Hp+vsR4mNjo8O5p7XavHWtoKjBylPIP4lA1BmX5hxYh9PIR79EGpMCjkpKZnn31v+sl0TfM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyL2fmZL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyL2fmZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F580C2BCB0;
	Sat,  9 May 2026 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292619;
	bh=5MqL9blVwzlyowJgu3GjveMMNQOLPC5VCLZ3lBViHXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pyL2fmZLhx2/EiK7vcdj0wua4mPZfgyQvUh6KVItzoGCeyJ9mk/gQdfX/LEw8Zsvm
	 tevNI4WaokjXUpzLaVpmaRwipVbMLu+Vw4NOdEjQZ0sS2p8yKd4J/FiwuByeBALFuz
	 /GzDsOJuL+eYVJdrOOUkkWaqggKHmPfuxW8tWiyu4AtEyTbWqApJVs/tWkM/0tIm/n
	 Fpt+K3EL2DnAZCYs8GOGAIBTwVPYhJs8FvZTgSwE3N1QucGQ6WblEnKKuZ2BRkiqjN
	 dy92uU3YrlfazFDPYOIkKfxudnnKEWu3SyTZh3er+fI4PdwPSYnxOFIX5RVcgPwFa0
	 M2AW4dGxAe2zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 10/23] bpf: Reject stack arguments in
 non-JITed programs
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213034.1130443-1-yonghong.song@linux.dev>
References: <20260507213034.1130443-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 02:10:15 +0000
Message-Id: <20260509021019.9F580C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The BPF verifier fails to reject the interpreter for a main progra=
m (i =3D 0) with stack arguments, leading to an uninitialized memory read o=
f R11.
--

commit 4a48796d8e4e4607bc163fc6b59a84f3495c3d5c
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject stack arguments in non-JITed programs

This commit aims to prevent non-JITed programs from running if they use
stack arguments, since the BPF interpreter does not populate the register
used for stack arguments (R11). It updates the runtime selection and fixups
phases to reject such programs.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ae10b9ca018df..6f94b0ef3659f 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
>  		goto finalize;
> =20
>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> +	    bpf_prog_has_kfunc_call(fp) || fp->aux->stack_arg_cnt)

Is fp->aux->stack_arg_cnt guaranteed to be initialized at this stage?

If JIT is disabled system-wide (e.g. sysctl net.core.bpf_jit_enable=3D0),
bpf_jit_subprogs() is skipped, leaving the count at 0. Furthermore, even if
JIT is enabled but the program has multiple subprograms, bpf_jit_subprogs()
only populates the cloned subprograms' auxiliary data, leaving the main
program's prog->aux->stack_arg_cnt as 0.

Could this allow the check to be bypassed for the main program?

>  		jit_needed =3D true;
> =20
>  	if (!bpf_prog_select_interpreter(fp))
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 0ff8cdf4394f4..4c630d97eaade 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -1412,6 +1412,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
>  		verbose(env, "calling kernel functions are not allowed in non-JITed pr=
ograms\n");
>  		return -EINVAL;
>  	}
> +	for (i =3D 1; i < env->subprog_cnt; i++) {

This loop explicitly starts at i =3D 1, which skips checking the main progr=
am.

If an extension program (BPF_PROG_TYPE_EXT) attaches to a function with more
than 5 arguments and has BTF_FUNC_STATIC linkage, it will inherit the incom=
ing
stack arguments. Since the check in core.c might fail to catch the main
program due to the uninitialized stack_arg_cnt, can this extension program
bypass both rejection mechanisms and fall back to the interpreter?

> +		if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
> +			verbose(env, "stack args are not supported in non-JITed programs\n");
> +			return -EINVAL;
> +		}
> +	}

If the main program bypasses these checks and is run by the interpreter, it
will attempt to read incoming stack arguments from regs[11]. Because the
interpreter's setup in ___bpf_prog_run() only initializes R1-R5 and the fra=
me
pointer, would reading regs[11] leak uninitialized kernel stack memory or
cause a crash if the uninitialized value is dereferenced as a pointer?

>  	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
>  		/* When JIT fails the progs with bpf2bpf calls and tail_calls
>  		 * have to be rejected, since interpreter doesn't support them yet.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D10
