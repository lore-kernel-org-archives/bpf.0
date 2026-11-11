Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410143;
	b=d2lXPay6+wIVoiC0coChi1GdaExAqyIOb+fqu46eEwvbMBk9EchUqQuGlmPL7u3vb7H3
	 IsnvfDQ2D0Be5YtkUyg5zTo+uX98mvXrq6CduhgVrO84+cK1xX/bwqhkrhWXe81S77CPa
	 xOxpHavYA7syVrVCh5lcUHmCWXP4fda52pnjxVBcSML6/KxblouDoosFXRbMPKpUEByGi
	 Ea4PedADmgQFVHbDzR7Z3bPhsqGu03ZaPphFcwtr89bfxUnSH+ESfhqzG7j6CnO2yXB+s
	 e9egRvosqzeND7meTT04ZGHNYMdd76plEoHGnLc1uHyERy4bSQdcHndHkZGqjss8gpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410143;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yszU1EvbjXdPx4rRPrHrlVm+GNbg3JhoaFT67bug0ic=;
	b=XCUqSFmmp/+3x3CqPQuVozDd6TYp1sv8rhI8hlHYtS7TGt/JMTyVaQhVra5x8aHxm9K7
	 ICl0X+iBhxl9bYyoLh3+yjXnhnzZW+2XOhI8SHda0synVqR2cfUy9Gwkt3bL/ZRp9XKiJ
	 0V5SPUMJBKqwHjyZWrZ3JiEPJvnjGFi89i+MDYU2/iDd3h93JE47Q3AUsvDi2H0wmiddV
	 nqJdy7gLHea28GOm47dVZiDFVoxjnLAaLLM8ZK6grzE9EOs14AK/bpgs13YCIxoW5PDTz
	 UhDuGk/+oM/E2dfXNf+pLgZ6f5Iw24aZp++ACWENh4enEZrSxizC/OTybx5CCAnBWFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X65JEqZF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB4606A33F
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X65JEqZF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F6C1F00A05;
	Wed, 11 Nov 2026 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410142;
	bh=yszU1EvbjXdPx4rRPrHrlVm+GNbg3JhoaFT67bug0ic=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=X65JEqZFS/1yvP6moUigIufrrdpmUFyOkEGSmIh52aXBvQ5ppVUVtAMja8C5U+UPf
	 sKXrT7WI9df2qeh7GyyT/ft2wUfJ7RkD+nQ0TMV5As/NQ3ekrFasYBJ390vLmfP2zJ
	 WKw0Pp1SO+aVlqYgvfOycxhG/6ASoQUzZOWzmfJ5fgEPqLlTvkDfEY838pKLG1At05
	 Pw9GGcFk+r+TUH4KwroxllOvRUAbxzQL8kZ+DUTL43fFSTqNBc39BjB/fq15gnhE9l
	 jd6wEF1kOOJrN7zGmRgHb0+gtW+H/DroPdNyWaH0iqfAHK4HdWOzoP4t9xa/1HqQRM
	 usWaxCPcHtQkw==
Message-ID: <sashiko-outbox-209218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 07/29] bpf: Add one allocator for hidden
 stack slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <9d074f026dcb520b11bb1365d7116b95e0b789c6.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <9d074f026dcb520b11bb1365d7116b95e0b789c6.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 15:15:42 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: stack buffer overflow in ___bpf_prog_run() [1]
--

commit 12562841fbd23150e8e97550f85ed29a199cd037
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add one allocator for hidden stack slots

This commit introduces a unified hidden stack slot allocator for
post-verification rewrites and converts may_goto, inlined bpf_loop(), and
epilogue context saving to use it.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 8597b443d5619..04d89113e5963 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -3512,9 +3596,15 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
>  	}
> =20
>  	ret =3D bpf_patch_list_commit(env);
> +	if (ret)
> +		return ret;
> +
> +	/* The hidden slots get their values in the prologues too. */
> +	ret =3D bpf_emit_stack_inits(env);
>  	if (ret)
>  		return ret;
>  	prog =3D env->prog;
> +	prog->aux->stack_depth =3D subprogs[0].stack_depth;

[Severity: Critical]
This problem wasn't introduced by this patch, but can a tail-calling program
that fails JIT compilation overflow the kernel stack in ___bpf_prog_run()
[1]?

In bpf_do_misc_fixups(), when a BPF_FUNC_tail_call instruction is seen, the
verifier only sets prog->aux->stack_depth to MAX_BPF_STACK when
!bpf_allow_tail_call_in_subprogs(env) (and then overwrites
prog->aux->stack_depth with subprogs[0].stack_depth at the end of the
function):

kernel/bpf/fixups.c:bpf_do_misc_fixups() {
	...
		if (insn->imm =3D=3D BPF_FUNC_tail_call) {
			prog->cb_access =3D 1;
			if (!bpf_allow_tail_call_in_subprogs(env))
				prog->aux->stack_depth =3D MAX_BPF_STACK;
	...
}

On architectures where bpf_allow_tail_call_in_subprogs() is true because
jit_requested is set, if JIT compilation later fails (for example, on memory
allocation failure) and falls back to the interpreter,
bpf_prog_select_interpreter() selects an interpreter function sized only for
the caller's unexpanded stack_depth.  When JMP_TAIL_CALL in
___bpf_prog_run() switches insn to a target program that uses a deeper stack
(up to MAX_BPF_STACK) without allocating a new C stack frame, the target
program writes past the caller's fixed-size stack array and corrupts the
kernel stack.

[1] https://sashiko.dev/#/bug/linux-57b05589-4ccc-4b7c-94c0-c3316f3932e4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D7
