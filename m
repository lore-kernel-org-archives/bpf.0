Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F48C1F
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293180; cv=none; b=CL4TYTI1bJTg+SvsV+QIfQPCMIExf596rJRFhs/qf38W9aBgVZvNdQbW+SjacW+6CHFKqYUh2Fj4FJvv7wT/EWr0Z+sQvMRlNcuZBQ0lrBJdg3mRy4hIZqEhYDmjvbuVvFMIg+eDUj/AIVhpdbI7/vARPChpSoTWGs+tRiiyDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293180; c=relaxed/simple;
	bh=cfX4ycBAIo8SXAnKJED11lFJ5Xa9Uh5/YJvZ0jMwpU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AvlyRlOkfVC6pnVokO9B/RIjCYp/oDHMU4mJ+iSqf5Dxgl2OOQ7AvpSu5t4o9R7JDauTRWqTHO8uYaT8on6Kb3+04qLwtf5z2sIHjXCTMkXenO+OgRyQ5JCNTvXaaTDZEh752vIbc0bFHODkOAE+wA9SbskPDlizqBUUq4uo4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+qg5sMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+qg5sMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680C0C2BCB0;
	Sat,  9 May 2026 02:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778293180;
	bh=cfX4ycBAIo8SXAnKJED11lFJ5Xa9Uh5/YJvZ0jMwpU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M+qg5sMYVU9R1A3XutH6gqsBP/Zgq3embGlPt5roNCIBHzTb5spYf5PgsRpkjFPJ0
	 splV8fkne05zEJNNnKhsZ3XkTHOWD2CmxDZECaugEvrQiC8ht4LyWaH3Dun1GEMnfD
	 stwzqvAuKh6oowGjFJBi5025a+OgIMVaX5iRc1F0X8ovs2tntLnHtZn9r3kxl2O0+w
	 6YiOJxqkQj7iAlM5ue3SzsArlj8rHz1bkFQP2wz4xu+uoxPKs62jF+aKWvQ6EVlaqG
	 Oi5tJHeg6vI6VOSjrChKehM2DITH3nWhivbK24mu5ec2WqDUt0RfyoRfJ4H+g8BmHZ
	 dCAoaYnboO5Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 11/23] bpf: Prepare architecture JIT support
 for stack arguments
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213039.1130658-1-yonghong.song@linux.dev>
References: <20260507213039.1130658-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 02:19:39 +0000
Message-Id: <20260509021940.680C0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Static functions with more than 5 parameters are not actually =
rejected when the JIT does not support stack arguments. This bypasses verif=
ier stack initialization checks and allows the program to run, leading to a=
rbitrary kernel memory access at runtime.
- [Low] The patch returns the kernel-internal error code -ENOTSUPP instead =
of the standard -EOPNOTSUPP, causing generic 'Unknown error 524' messages i=
n user-space.
--

commit e571d76e56fcb6ad5c6cc343d3221d66e6aec024
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Prepare architecture JIT support for stack arguments

This commit introduces a weak function bpf_jit_supports_stack_args() to all=
ow
architectures to indicate support for BPF stack arguments. It also updates
the BTF preparation code to reject functions with more than 5 arguments if
the JIT does not support stack arguments.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ec3fb8c8f4eef..bf83b737d55cb 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -7886,8 +7886,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>  			MAX_BPF_FUNC_ARGS, tname, nargs);
>  		return -EFAULT;
>  	}
> -	if (nargs > MAX_BPF_FUNC_REG_ARGS)
> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +		if (!bpf_jit_supports_stack_args()) {
> +			bpf_log(log, "JIT does not support function %s() with %d args\n",
> +				tname, nargs);
> +			return -ENOTSUPP;

Should this return -EOPNOTSUPP instead of -ENOTSUPP?

-ENOTSUPP is a kernel-internal error code (524). If this error bubbles up
to user-space (for example, when loading a global BPF program), it might
result in a confusing "Unknown error 524" message rather than a standard
error.

Also, does returning an error here actually reject static functions with
more than 5 arguments?

Looking at the code just above this diff, sub->arg_cnt is set to nargs
before the check:

kernel/bpf/btf.c:btf_prepare_func_args() {
	...
	sub->arg_cnt =3D nargs;
	...
	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
		if (!bpf_jit_supports_stack_args()) {
			...
			return -ENOTSUPP;
		}
	...
}

If this returns -ENOTSUPP, it propagates to btf_check_subprog_call(),
which returns the error. However, check_func_call() ignores non-EFAULT
errors for static functions:

kernel/bpf/verifier.c:check_func_call() {
	...
	err =3D btf_check_subprog_call(env, subprog, caller, ...);
	if (err =3D=3D -EFAULT)
		return err;
	...
}

Since the error is ignored, verification continues without rejecting the
program. Because the error was returned early, btf_check_func_arg_match()
skips check_outgoing_stack_args(), meaning the caller is never forced to
properly initialize the stack slots according to BTF types.

Since sub->arg_cnt was already set to nargs, bpf_in_stack_arg_cnt() will
calculate that the function takes stack arguments. If the caller manually
initializes the stack argument slots by writing to r11, the verifier tracks
the register types and might accept the program.

At runtime, since the JIT does not support stack arguments, BPF_REG_PARAMS
(r11) is likely missing from the JIT's register translation maps.
Uninitialized entries default to 0, which often maps to the return value
register (like rax on x86 or x0 on arm64).

Could this cause reads or writes against r11 + offset to be translated
into memory operations against rax/x0 + offset? Since the return register
is easily controllable by the BPF program, might this allow arbitrary
kernel memory reads and writes?

> +		}
>  		sub->stack_arg_cnt =3D nargs - MAX_BPF_FUNC_REG_ARGS;
> +	}
> =20
>  	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
>  		bpf_log(log, "global function %s has %d > %d args, stack args not supp=
orted\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D11
