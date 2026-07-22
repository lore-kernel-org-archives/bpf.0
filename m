Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2135CB81
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729909; cv=none; b=fMnPizUTm2H9sAxzV2SamYyGTTYj6gxxY/1sVRgsOXCOf9/Xxn4ldIOa4V5OVjMSl8x4KXrTGDmzCKxVhM5PihRQNByseJdY/s85R/wIlI8Vt0si/XJNvvTS5opImFMJa/qw3I4UJM9llGpYwvNudkLI1tFUJlGXOUccdiJyc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729909; c=relaxed/simple;
	bh=AEdeAvsmvqiDdz/F7y4LlFYzA84UKNqj/j6r4qGJ08k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OMJHZEb6qk3tdZsy970Jw4JggLFTwk6lWF2ol1YkKj+JOh/XE6GPXJX27eWEHORrx/OeLIsnu0qlvib6EL/nXZrzdttqg7AEEqFD3imb2vlLwWD5xp2MOd4nza9azUak1VkDCfeeNNEv4xzHJB90gWd2HFDS7ZsBiNBGigk3k1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIHu1GoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIHu1GoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2333F1F000E9;
	Wed, 22 Jul 2026 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784729908;
	bh=+rWViQ5GyoPXTCI8XsAeyZGyuIeULUI3gGrYL8uGYbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mIHu1GoNOp1AZxmXzLRIjrjuyjSL2bCtqjV8ItzI3V/oSDzSykHkzRAuTl3r4ryYZ
	 PphrnueaDW3l2cGmBpP9wi9i2dAXKOqg4DF5/OvoooRtCnLsZ15hhm7NhhPxkFx/GM
	 SDnB3266x1lQsXEwqxs08KPdvQEZJVB2VAkzzMjeSP6exKqMFl7hhdn0WT/WCu+YB5
	 5y6vsJHLvbh7FOhQr97O32dibJbmgd6MRyJZD2vmfav4Oam71xpQ57RMv0CZZrPsO6
	 zdE5yZAOkp8or5T2g/5iincQ9mzvRbgwTkv883AL04nC0JHFW18yAavg6e7ujg/c3I
	 L3LRigRpjMIhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] riscv, stacktrace: Pass sp and fp to
 the walk_stackframe() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Varun R Mallya" <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722140015.1982158-3-varunrmallya@gmail.com>
References: <20260722140015.1982158-1-varunrmallya@gmail.com>
 <20260722140015.1982158-3-varunrmallya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:18:27 +0000
Message-Id: <20260722141828.2333F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly added wrapper callback `walk_stackframe_consume_entry` l=
acks the `notrace` (and `noinstr`) attribute, leading to ftrace instrumenta=
tion escaping the `noinstr` context.
- [High] The stack pointer (`sp`) passed to the callback for interrupted fu=
nctions is stale; it points to the exception frame (`pt_regs`) rather than =
the actual stack pointer of the interrupted function.

Pre-existing issues:
- [High] The exception unwinding logic reads from `pt_regs` without verifyi=
ng that the large structure fits entirely within the remaining stack bounds=
, causing an out-of-bounds read.
--

--- Patch [2]: [PATCH bpf-next v3 2/6] riscv, stacktrace: Pass sp and fp to=
 the walk_stackframe() callback ---
commit 546502e11288943b2cf30f9608406a872a42ffb2
Author: Varun R Mallya <varunrmallya@gmail.com>

riscv, stacktrace: Pass sp and fp to the walk_stackframe() callback

This commit updates RISC-V's walk_stackframe() and related callbacks to pass
the stack and frame pointers along with the PC. This enables the BPF
exceptions machinery to retrieve the required context for unwinding the
stack. It introduces walk_stackframe_consume_entry() as a wrapper to adapt
the generic stack trace API.

> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index c7555447149bf..30b369dd28151 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
[ ... ]
> @@ -91,7 +93,7 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>  						   &frame->ra);
>  			if (pc >=3D (unsigned long)handle_exception &&
>  			    pc < (unsigned long)&ret_from_exception_end) {
> -				if (unlikely(!fn(arg, pc)))
> +				if (unlikely(!fn(arg, pc, sp, fp)))
>  					break;
> =20
>  				pc =3D ((struct pt_regs *)sp)->epc;
>  				fp =3D ((struct pt_regs *)sp)->s0;

[Severity: High]
This is a pre-existing issue, but this exception unwinding logic reads from
pt_regs without verifying that the large structure fits entirely within the
remaining stack bounds.

If unwinding a concurrently running task, an inconsistent read can result in
sp being close to the top of the stack bounds. Because s0 is at a significa=
nt
offset within pt_regs, could this blind cast and dereference read past the
top of the stack into the unmapped guard page and cause a panic?

[Severity: High]
When updating the state for the interrupted frame here, pc and fp are updat=
ed,
but sp is not. Should sp also be updated to the interrupted function's stack
pointer (e.g., sp =3D ((struct pt_regs *)sp)->sp)?

Because this patch specifically introduces sp and fp to the callback for BPF
exceptions, passing the exception frame pointer instead of the interrupted
function's sp might corrupt the stack when BPF attempts to restore state.

[ ... ]
> @@ -176,10 +181,28 @@ unsigned long __get_wchan(struct task_struct *task)
>  	return pc;
>  }
> =20
> +struct walk_stackframe_consume_entry_data {
> +	stack_trace_consume_fn consume_entry;
> +	void *cookie;
> +};
> +
> +static bool walk_stackframe_consume_entry(void *arg, unsigned long pc,
> +					  unsigned long sp, unsigned long fp)
> +{
> +	struct walk_stackframe_consume_entry_data *data =3D arg;
> +
> +	return data->consume_entry(data->cookie, pc);
> +}
> +
>  noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_ent=
ry, void *cookie,
>  		     struct task_struct *task, struct pt_regs *regs)
>  {
> -	walk_stackframe(task, regs, consume_entry, cookie);
> +	struct walk_stackframe_consume_entry_data data =3D {
> +		.consume_entry =3D consume_entry,
> +		.cookie =3D cookie,
> +	};
> +
> +	walk_stackframe(task, regs, walk_stackframe_consume_entry, &data);
>  }

[Severity: High]
Does walk_stackframe_consume_entry() need a notrace annotation?

It is invoked directly from the noinstr function arch_stack_walk().
Without notrace, this allows ftrace instrumentation to escape the noinstr
context, which can lead to infinite recursion or crashes if triggered from
highly restricted contexts like NMIs or exception entries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722140015.1982=
158-1-varunrmallya@gmail.com?part=3D2
