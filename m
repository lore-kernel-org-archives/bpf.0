Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117031;
	b=BjnhJ+kgBtsxKMGq0m/MsiGClp1QLa8+pPQBh/GYHvQr+3GESvUE5a7miFY2TcDzsoq1
	 YzYsjDOVRSjRdfdJwkb0GX26iYuePtQClUqk7B04Ykp2/YVTD+m/ahhTaCi8NUjJySS9Q
	 uB6yeDdcLN6UCaB1vab0GR8EvO77YU37Le/4oKU5jTNeeHBMijbX8IY2Y6Zv/F5b4+1rl
	 XqRnat/j/SXN99el09dSap4VLzWqwh8GYC+1hNIodTCa9G2DJgFFu58Ot3tR71fFS8foi
	 XCT/O9iBbjC1/r/iPhi7Z3lqxK822mk5N6pJLTontBvciPEKaMr0UbhrLZ4COL5xFLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117031;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k9o3Q/4W9c8yfnPaVLDdH/jZEfeF6/ERdOdIStNDpqU=;
	b=aOm1mi7PTRAMOXA89IJmqWCZBq6OvBPcvbA+TnGjWxOqzSnkonQlww2QZBUJWojda1Kw
	 FnzvCbDrh/0VZX3qtDwKpV60qBTRfnaD9q+YqAAsuyl050GV6zeS0rwm9sw10B8J35GwZ
	 c8hxJlqbh0eWGmoI6VrqURKeoriGWULCmzGzssHHgZNLoofjU4082OlqJbOhe2U3rqzuK
	 M2EFz7PBdWa1KOpNLZDzl7TVpuvxUeyAmmaJSLa8/vc9JyfmCm05Zh6uuB08imWpu8myN
	 Olne4gL/vCN79SR29iKdc0zzh290zVa3pWEi329gUlx0D3m3Lg+IUpI4aAfqYpdR6SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEZn7Qt5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B5606A32C
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEZn7Qt5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED671F01825;
	Tue, 27 Oct 2026 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117031;
	bh=k9o3Q/4W9c8yfnPaVLDdH/jZEfeF6/ERdOdIStNDpqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MEZn7Qt5kmNnONroexhO48MrBw/rEZQd2TrhwljqHv8TuKLMRJj9lkEzZDAldK0N9
	 oA4TjkrfOsyMtgkp3bpGzd4c2XOfRyCFvooD1K0p8CExQegKQxMC4eXuuYBvlIjVxW
	 Xd4lESOQ6rfWT2w5qVPwW+vJ3r10tgeUvy+LBY67nmCNkKjSE+qFfdLyPYh5rQyrbo
	 hAxVsAtLbmbGbN2nZv44Xbq7w69S8gVPGU6WUQ/ob+QscjFMRrSUKL8VN00hanlUpR
	 n3P021Jb/Uuny8trSWlxKjF0QNI8VJzLEK6sbt1Nf3PLqN7GRVDwdzL8YLfenCVOyW
	 qpJtLm52zXFuw==
Message-ID: <sashiko-outbox-186872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: fix out-of-bounds frame access for async
 callback stack args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261027154553.1043567-1-bsdhenrymartin@gmail.com>
References: <20261027154553.1043567-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:03:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: NULL or OOB read of stack_arg_regs in check_stack_arg_read()
--

commit 8bf4e754c411e80ff88d77c6c807380a3c5428eb
Author: Henry Martin <bsdhenrymartin@gmail.com>

bpf: fix out-of-bounds frame access for async callback stack args

This commit rejects r11-based incoming stack argument loads in
check_stack_arg_read() when the current frame has curframe =3D=3D 0 or
state->in_callback_fn set. This prevents async and synchronous callback
frames from reading unvalidated or out-of-bounds caller frame and stack
argument state.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d20562186..c02776c396bc2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4653,6 +4653,11 @@ static int check_stack_arg_read(struct bpf_verifie=
r_env *env, struct bpf_func_st
>  		return -EACCES;
>  	}
> =20
> +	if (vstate->curframe =3D=3D 0 || state->in_callback_fn) {
> +		verbose(env, "stack arg read from a callback frame\n");
> +		return -EINVAL;
> +	}
> +
>  	caller =3D vstate->frame[vstate->curframe - 1];
>  	arg =3D &caller->stack_arg_regs[spi];
>  	cur =3D vstate->frame[vstate->curframe];

[Severity: High]
Can check_stack_arg_read() in kernel/bpf/verifier.c still dereference a NULL
or out-of-bounds caller->stack_arg_regs[spi] (or copy an invalidated NOT_IN=
IT
slot) during a non-callback static subprogram call?

For static subprograms, both check_func_call() and check_func_callx() ignore
all errors from btf_check_subprog_call() except -EFAULT and proceed into
check_static_func_call() with vstate->curframe >=3D 1 and
state->in_callback_fn =3D=3D false:

kernel/bpf/verifier.c:check_func_call() {
	...
	caller =3D state->frame[state->curframe];
	err =3D btf_check_subprog_call(env, subprog);
	if (err =3D=3D -EFAULT)
		return err;
	...
}

kernel/bpf/verifier.c:check_func_callx() {
	...
	subprog =3D reg->subprogno;
	err =3D btf_check_subprog_call(env, subprog);
	if (err =3D=3D -EFAULT)
		return err;

	err =3D record_callx_edge(env, caller->subprogno, subprog);
	if (err)
		return err;

	return check_static_func_call(env, subprog, insn_idx);
}

When a static subprogram has more than five BTF argument slots
(sub->arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS, so bpf_in_stack_arg_cnt(subprog)
is non-zero), btf_check_subprog_call() can return -EINVAL before
check_func_args() -> check_outgoing_stack_args() validates and prepares
caller->stack_arg_regs in two ways:

1. In btf_check_func_arg_match(), after btf_prepare_func_args() succeeds and
populates sub->arg_slot_cnt and sub->stack_arg_cnt, if any register in
caller->regs[BPF_REG_1 .. BPF_REG_5] has type =3D=3D NOT_INIT, it returns
-EINVAL before calling check_func_args():

kernel/bpf/verifier.c:btf_check_func_arg_match() {
	...
	if (!bpf_subprog_is_global(env, subprog)) {
		for (i =3D 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS); i=
++)
			if (caller->regs[BPF_REG_1 + i].type =3D=3D NOT_INIT)
				return -EINVAL;
	}
	return check_func_args(env, &meta, env->insn_idx);
}

2. In btf_check_subprog_call(), once
prog->aux->func_info_aux[subprog].unreliable is set to true by an earlier
call or callback registration that failed BTF validation, any subsequent ca=
ll
to that static subprogram returns -EINVAL immediately without calling
btf_check_func_arg_match() or check_outgoing_stack_args():

kernel/bpf/verifier.c:btf_check_subprog_call() {
	...
	if (prog->aux->func_info_aux[subprog].unreliable)
		return -EINVAL;

	err =3D btf_check_func_arg_match(env, subprog, btf);
	if (err)
		prog->aux->func_info_aux[subprog].unreliable =3D true;
	return err;
}

When that static subprogram then executes an r11-based incoming stack
argument load, check_stack_arg_read() passes the spi + 1 <=3D
bpf_in_stack_arg_cnt(subprog) bound check and the new curframe =3D=3D 0 ||
state->in_callback_fn check, and then reads caller->stack_arg_regs[spi].

If the caller never allocated stack_arg_regs (caller->out_stack_arg_cnt =3D=
=3D 0),
this dereferences NULL; if caller->out_stack_arg_cnt <=3D spi, it reads past
the end of caller->stack_arg_regs; and if a prior call left invalidated slo=
ts
behind, it copies a NOT_INIT register state into cur->regs[dst_regno].

Should check_stack_arg_read() also verify that spi < caller->out_stack_arg_=
cnt
and that caller->stack_arg_regs[spi].type !=3D NOT_INIT (or reject the call
when btf_check_subprog_call() fails for a subprogram with incoming stack
arguments)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027154553.1043=
567-1-bsdhenrymartin@gmail.com?part=3D1
