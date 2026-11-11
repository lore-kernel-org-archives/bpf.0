Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408097;
	b=xNN2+w0rw1Zu43bBirl4t4G1SwLCBmmekciT5EwLijp1M0qT3vt/G0Wvi7/PGw8Zqg4K
	 a7pEY1HFf2qF9x+uFVqzmV4vUs/0/0q2Ap44VwKX9MVOl28PiP4Vls/oDtOyqFN2LS7Xg
	 6fZs7yZ4VTrIDOFOM1v9b4PXl0LEX3Vtbb/5VWDSFXZRdkmsZliNIUT/mVYeLez2hxbvt
	 qzZ0/fiUsaHnN0uOmJMyBX6higH3umKsIeUo4U37Is1F4hD/hc5INKD9h5nrl+U0yu7gG
	 Ze1PPKyYwj7i1cT16++DpkQkrXZWoRejmt406x7r6mJuB5oeE4f/9ZNPk/KBjKkGIYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408097;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5Xuc2CRVPr9R3ogkAqIis8h5mqdFPnQQ6NHFF0cDOUE=;
	b=NXhHdcrJVgUKRbZa2vrxR6v5xhGk/OW/STIUixRki52r1a0VSpJ6HmVvxVeyHK6oVsbq
	 SlDtxSVF/qa0E7hAPNgapjBC+iRnLYVHMP0qI3ZaGUuF2IMz9DzpaF647E4ZazG5Kz1LD
	 9YJUKPOXY5nb1tTDiCGX2LG0eiLMpUKKusoIJhkfdKnQpktUAbdNuphupx3VgSxOG9ndn
	 ZiaTw158/ZMk5rho7lHFcrgh4v//Dyb4BQ3NW36qKIdq6B7+hYgWwZHUh9H00wS2jog+1
	 xf1UXB+G1+ryUjtOcA4L1mGCj+AaBuUEdrFbUGwHAygtrcRnIDSI/z6+zCaijzL3vLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrNbvgmu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48F606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrNbvgmu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E071F00A06;
	Wed, 11 Nov 2026 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408097;
	bh=5Xuc2CRVPr9R3ogkAqIis8h5mqdFPnQQ6NHFF0cDOUE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GrNbvgmuG/fCPOMB73jgTTzQ8Lqc6F6+QshNrkhdTkiuccz6TBdPZozAVaqne93Kv
	 DBOd8oF6X6XvQD4vxLYNSP6N+ICQl5BNu5E7NZS5ocbDefXXE47Wh36TetkDRValFY
	 gGCLI1zjmqLVJKnQTK1vrxsHsQyLP/dptSeS2vr4BCnVDzt+jxb39GBb9EY948nhcr
	 f3++eRKhRviGkxdnxsWAAeCCOfMf/Uf59YhnSJ6IUY0vB+TfRnfePgdtMxe4l5yFyh
	 0hBcMZOg/yuCCSdqsOwz3fA6wK+Dl9L76m+QaWqbgsQL0bCYPpIQ5kKK5okH42u854
	 xfAzi70Mo+csQ==
Message-ID: <sashiko-outbox-209179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 05/29] bpf: Restore callee-saved registers
 from unwound frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <34d17f4e59939c2afb427a69d9f34f61e3dc3343.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <34d17f4e59939c2afb427a69d9f34f61e3dc3343.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 14:41:36 +0000
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
- [Critical] bpf: NULL pointer dereference in bpf_throw() [1]
--

commit 1abcf2f1b7a0733f9332d1db13a62945d7715633
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Restore callee-saved registers from unwound frames

This commit restores callee-saved registers from unwound frames during
bpf_throw() unwinding and passes them to the exception callback instead of
saving and popping all callee-saved registers in the exception boundary
prologue.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index de31fdd18411e..0164f183aade2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -3461,15 +3474,24 @@ static bool bpf_stack_walker(void *cookie, u64 ip=
, u64 sp, u64 bp)
>  }
> =20
>  /*
> - * Unwind the stack to the exception callback of the main program. @regs=
 holds
> - * the callee-saved registers of the throw site, or is NULL when the
> - * architecture has no native entry and the kfunc was called directly.
> + * Unwind the stack to the exception callback of the main program. @regs=
 is the
> + * register file of the throw site, which the entry of the architecture
> + * captured: the callee-saved registers of the frames unwound are restor=
ed from
> + * it for the callback. It is NULL when the architecture has no native e=
ntry
> + * and the kfunc was called directly.
>   */
>  __bpf_unwind_entry
>  notrace void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
>  {
>  	struct bpf_throw_ctx ctx =3D {};
> =20
> +	/*
> +	 * Without the file, on an architecture that has no native entry, the
> +	 * prologue of the main program has saved every callee-saved register
> +	 * and the callback restores them from its frame, not from @saved.
> +	 */
> +	if (regs)
> +		memcpy(ctx.saved, &regs->r[BPF_REG_6], sizeof(ctx.saved));
>  	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
>  	WARN_ON_ONCE(!ctx.aux);
>  	if (ctx.aux)
> @@ -3483,7 +3505,7 @@ notrace void bpf_throw_unwind(struct bpf_throw_regs=
 *regs, u64 cookie)
>  	 * architectures cannot recover sp while unwinding, so fall back to bp.
>  	 */
>  	kasan_unpoison_task_stack_below((void *)(long)(ctx.sp ?: ctx.bp));
> -	ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust=
, ctx.bp, 0, 0);
> +	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, (u64)(long)ctx.saved,=
 0);

[Severity: Critical]
This problem wasn't introduced by this patch, but can this cause a NULL
pointer dereference [1] on ctx.aux if arch_bpf_stack_walk() fails to
locate the main BPF program frame?

Although the code checks whether ctx.aux is non-NULL before testing
ctx.aux->exception_boundary above, it then dereferences ctx.aux
unconditionally when invoking bpf_exception_cb().

[1] https://sashiko.dev/#/bug/linux-ba8dbe22-2e39-4c7e-90bf-e30065ad3c90

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D5
