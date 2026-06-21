Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E326980F
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782053820; cv=none; b=SnGm8xN3aQpMIpUux8HeiiRhYnvKNR6PYNIXXQRuSF6EB0F4rcpGdXtssNdvi3ur5MhL5lDfx8vQWCjYv7QcDTDeLpdP7m8KJ8qYWZEf+UIBLoq9S2E0nhgdaS/Xpm8hZ1yPkHJ7BRfESC3AQp5B6vD7u4Gqy6ds1zoPfb4TgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782053820; c=relaxed/simple;
	bh=V9s7De55ejIuxpcxzHMxr70y0w0gccvxM88ltWUQB9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pSNyJjuu1d/uEipF23nOHG/+cdRl0s0q2yn5WwpHd3XlNi7YkwoAQfLO/JnmhF7wv/+JkvPj/vR6oXGST5Oe1ccUM31msfh1c9alQ68iNo615c09+W0O9ipT+NJvpp2s6ibTnaUJGTqfCZR9OhUA58s6C0UGdFbbnHdbmHJot+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuShWB2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuShWB2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CBD1F000E9;
	Sun, 21 Jun 2026 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782053818;
	bh=ewfK1ZbwQ65/nt7XiE0QfVfrGzi6IwCZkfc1jxeSfdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AuShWB2ICQflHU15KP8IhPyjiQKKzEYTa0+gTys7e+cWu2SaWnMCJkXL1tUqDTF/s
	 W0QtqgngCTyoiCPZlgcOqRzE4kGhnBzn5ELPeEytEt6STUNHuXpSOGJMnDj4qwTbIE
	 QJ2LBIFuXFBXD9Q4Vu/feWQle+HYRnuNteBF8VNwKGgxaoOxCrEhR7orDbeQOl4ffl
	 EkNEgvvDUOfRa3POQl0CSSXCbBsJZASjGhzyc4wRw6kRzXVVQemBt4fuRQIxHXjysz
	 CMQvwalQNdjb18qpn0JfWik4ReP0qFigrZNfSdhzcLPOdkaXyzCoJ/OU+wAIpvjMTp
	 +JDUGohGrtBnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/3] riscv: stacktrace: Implement
 arch_bpf_stack_walk() for BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Varun R Mallya" <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260621144259.288135-2-varunrmallya@gmail.com>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
 <20260621144259.288135-2-varunrmallya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 14:56:58 +0000
Message-Id: <20260621145658.C8CBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `ftrace_graph_ret_addr()` resolution in `arch_bpf_stack_wa=
lk()` breaks BPF exception unwinding when the ftrace function graph tracer =
is enabled.
--

commit 18f97d2c8c3fdcb52341a066f5cdbb33e67828f4
Author: Varun R Mallya <varunrmallya@gmail.com>

riscv: stacktrace: Implement arch_bpf_stack_walk() for BPF
   =20
This commit implements arch_bpf_stack_walk() for RISC-V when
CONFIG_FRAME_POINTER is enabled. It allows unwinding the stack up to the
program marked as the exception boundary, which is required to support BPF
exceptions on this architecture.

> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index b41b6255751cb..a4c2411f4038b 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c

[ ... ]

> @@ -102,6 +103,33 @@ void notrace walk_stackframe(struct task_struct *tas=
k, struct pt_regs *regs,
>  	}
>  }
> =20
> +void notrace arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip=
, u64 sp, u64 bp),
> +				 void *cookie)
> +{
> +	unsigned long fp, sp, pc;
> +
> +	fp =3D (unsigned long)__builtin_frame_address(0);
> +	sp =3D current_stack_pointer;
> +	pc =3D (unsigned long)arch_bpf_stack_walk;
> +
> +	for (;;) {
> +		struct stackframe *frame;
> +
> +		if (unlikely(!__kernel_text_address(pc)))
> +			break;
> +		/* pc belongs to the function whose frame pointer is fp */
> +		if (!consume_fn(cookie, pc, sp, fp))
> +			break;
> +		if (unlikely(!fp_is_valid(fp, sp)))
> +			break;
> +
> +		frame =3D (struct stackframe *)fp - 1;
> +		sp =3D fp;
> +		fp =3D READ_ONCE_TASK_STACK(current, frame->fp);
> +		pc =3D READ_ONCE_TASK_STACK(current, frame->ra);

[Severity: High]
Does this code need to resolve the ftrace trampoline address?

Looking at the generic unwinder walk_stackframe() in the same file, it uses
ftrace_graph_ret_addr() to recover the real instruction pointer when the
ftrace function graph tracer is active.

If a kernel function in the unwinding chain is traced by ftrace, frame->ra
will point to return_to_handler on the stack. Because return_to_handler is a
core kernel text address rather than a BPF program address, the stack walker
might silently skip the caller's frame and miss the BPF exception boundary.
This would leave the context uninitialized and trigger a kernel panic in
bpf_throw() when it validates the missing boundary.

Could pc be passed through ftrace_graph_ret_addr() here to ensure the real
return address is consumed?

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621144259.2881=
35-1-varunrmallya@gmail.com?part=3D1
