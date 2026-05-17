Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0970830
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979547; cv=none; b=Xut7/uDDXs91UR4Jg6y5l9EJ73q5lRGBVaQkOUn/puZlg5tdpi7qTB4N9Bot6nnVVgyPpBg4Y0f122d4vJWZdARyt9svbb9PYQXjejWT8q/qbicQbKX4ZNrt36JQH7Zy2ahmPcIj/Qk+hjEFRsKmKZozdbnkfOYk+2uckxa9UUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979547; c=relaxed/simple;
	bh=Lb/SfeDFYpVwTNJ/E60o7gi5bXsoSbEEmfWcrC/ZJDg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rg4oAYn0KDgD3o5KPamvKHqtPu1Uo6VdQrRWXtyzplUPjPltJjJ6ZsvN4trPd2oO+d4luz9s7eZyoe3HYLgGtbhvnsMZtPN9uhmknSgSwHW74uFs3okZarsAZCpvzCq9hU+Nz37JFOGcTGus2KmAwL/DXiTs5xA/31x21gJmLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkFic2qr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkFic2qr"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bdc947aaa3so5021547b3.0
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 17:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778979544; x=1779584344; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6CfZ/uw+5Q+U5blZhNEXD0QUEm+sIPhiQ6Y/wUeQH0=;
        b=EkFic2qr6WK/imuQm7Oc347J5nxRehOORqe2SAmYn2deJcbNFbjmZYquNe5ZmwLcUH
         DH5KUjYk8B9aLxrrdDqFMSm+hWxduZlmKSO4j2fDweG0RviW2kU8L+3LPqZOi2cnHU6s
         5X6LMzQE71JM1jW+rXODhBiJhfnq5WB4cIxLfk6uy7CGYpBh400SrS1J90DmDbVs0EFs
         LYK6Qnk62/EbXsjvaipjzgWxrJomrdfx/TFOXtmSlrdztmh9tGsVcQuy2TiPYyfu2dII
         22phEusHqSWVsvzCC2VtEACkrZddNd+FRRZMue36MUFbW7MYsrJSi1s8ZYfv/AA781bs
         2Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778979544; x=1779584344;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6CfZ/uw+5Q+U5blZhNEXD0QUEm+sIPhiQ6Y/wUeQH0=;
        b=rY3Dfv5zx1IdV5TVKkqnkE+hKQEPI24GRmTNWerWd1yJZkjgWKzxSPpGFyjAOr2vY0
         Kj9MynhZ4oAaOxtpuUteRkkKBXbEtEVrRHhj8D0IXhKXiQ1L5ocJA2J+fp45iZ1Z6Z09
         jx+6LOGHB6OxWStWru1ChV/7xH5daZyWMgMzqSsgieQ0zrW4CfnPQbk2VQ5CjjrvOH85
         EnLtC27v/E09Ldk/lnIOabizTS1WoVmpLkHUg+jXlMxGsWaZqhWh8xgeTE+uYey5rpL6
         seF2QY5+YMQEdKE7RS1/OFR2+rwMckf5mjAjFLPOMHGWXMKbtGFQiqRfGp5wG1TgfLmY
         4PPg==
X-Forwarded-Encrypted: i=1; AFNElJ/ZmVhrDqp7m9nwJyU7Q1BUjsbmn0CTrYAO7K6/DGosbI+8izGxvZcceRHrb49MzhMpW6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNjRw77MCUCCE4V4+NSPK7Jpys5u6IB8RyyWyhkIp9Gjmshct
	4xaNx/Wnyv1d+bl0/U8UQXZ/SnLeQK7d0RxvgQWEi2AZPePfNFfcEx1V
X-Gm-Gg: Acq92OGQEGYABQY+jcalMQOvEcAEHM7R7pe5ROHG2VY03bKu2wraAa6LecKrw0pvkBe
	I33qdts8reUY/R1xBC98yxJDDTgkrmcWmWo1LV6/m8Xg84oeqYsDLajDBmqMwzE4WyMSI1TTwGX
	W69Q8ia1NnHShHtkpyDyWts5CYu6lBEKsHSwzUURO7oSUZdDqwmIEcCjus0CGHnKMja3DPuaec9
	Bdj9qCCCRyv7NV/jUj2S355xPyhlAtaIA5fWOrXDshALJGx9k1F1A6DGNy6KpCriU9NsFmt62rP
	H1jkbwuIO17PmD2iaiJa/Lyvt4QY0sl5TO1FZdr6fffZhkMwxrvTxeye7DDxwKOTlvcw7B0sE8j
	Q+0tuVwIjUwvq8bmhxnASEVMot3/i08z+x/oOw6AuoLQQgKq/ma44K5RTzYnDfp5G76guxgxiQ3
	ahY3c3q3vT1Y9bMmnUW71FxqoOA6YbjCzvZcb48oXPj3xzPhLP1ttpdWmx6yhQwF89SzW9WJ2Dh
	wTmkPxu0YX78Cyt1g==
X-Received: by 2002:a05:690c:c18f:b0:7b7:5f48:d9ae with SMTP id 00721157ae682-7c95bf10229mr90150707b3.24.1778979544546;
        Sat, 16 May 2026 17:59:04 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc997b26a8sm2119217b3.15.2026.05.16.17.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 17:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 17:59:02 -0700
Message-Id: <DIKJM7FYGJ9K.2H5U2EPKDENME@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>, "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 6/7] bpf,x86: Fix exception unwinding with
 outgoing stack arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260515225035.821178-1-yonghong.song@linux.dev>
 <20260515225106.824804-1-yonghong.song@linux.dev>
In-Reply-To: <20260515225106.824804-1-yonghong.song@linux.dev>

On Fri May 15, 2026 at 3:51 PM PDT, Yonghong Song wrote:
> When a main program with exception_boundary has outgoing stack
> arguments (e.g. from calling subprogs with >5 args), bpf_throw() fails
> to correctly restore callee-saved registers, causing a kernel crash.
>
> The x86 JIT allocates the outgoing stack arg area below the
> callee-saved registers via 'sub rsp, outgoing_rsp' in the prologue.
> When bpf_throw() unwinds, it captures the main program's sp (which
> includes this outgoing area) and passes it to the exception callback.
> The callback gets rsp and rbp, followed by pop_callee_regs, but rsp
> points into the outgoing arg area rather than the callee-saved
> registers, so the pops restore garbage values. Returning to the
> kernel with corrupted callee-saved registers causes a crash.
>
> Fix this by passing the main program's outgoing_rsp as the 4th
> argument to the exception callback. The callback adjusts rsp with
> 'add rsp, rcx' before popping callee-saved registers, correctly
> skipping the outgoing arg area. When outgoing_rsp is 0 (the common
> case), this is a no-op.
>
> Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments"=
)
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 9 ++++++++-
>  include/linux/bpf.h         | 3 ++-
>  kernel/bpf/fixups.c         | 1 +
>  kernel/bpf/helpers.c        | 2 +-
>  4 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ceefefb4da21..f4fdceedaad7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -557,10 +557,15 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 s=
tack_depth, bool ebpf_from_cb
>  			/* Keep the same instruction layout. */
>  			emit_nops(&prog, 3);     /* nop3 */
>  	}
> -	/* Exception callback receives FP as third parameter */
> +	/*
> +	 * Exception callback receives:
> +	 *   rsi =3D main program's SP, rdx =3D main program's FP,
> +	 *   rcx =3D main program's outgoing stack arg area size
> +	 */
>  	if (is_exception_cb) {
>  		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
>  		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
> +		EMIT3(0x48, 0x01, 0xCC); /* add rsp, rcx */

Maybe let's do it on C side like:
bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_adjust, ctx.bp, 0);
Avoids the need to use 'rcx'.

>  		/* The main frame must have exception_boundary as true, so we
>  		 * first restore those callee-saved regs from stack, before
>  		 * reusing the stack frame.
> @@ -1789,6 +1794,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
>  	 * Arg 6 goes into r9 register, not on stack.
>  	 */
>  	outgoing_rsp =3D out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : =
0;
> +	if (bpf_prog->aux->exception_boundary)
> +		bpf_prog->aux->stack_arg_adjust =3D outgoing_rsp;
>  	emit_sub_rsp(&prog, outgoing_rsp);
> =20
>  	if (arena_vm_start)
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 242f9597d9ab..2a1616c769a9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1735,7 +1735,8 @@ struct bpf_prog_aux {
>  	int cgroup_atype; /* enum cgroup_bpf_attach_type */
>  	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>  	char name[BPF_OBJ_NAME_LEN];
> -	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
> +	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64 stack_arg_adjus=
t, u64);

no need to change this.

> +	u16 stack_arg_adjust;

this one is still needed, but maybe let's call it stack_arg_sp_adjust?

Looking at arch/arm64/net/bpf_jit_comp.c:590
it doesn't use SP, so should it fine.

and arm64 seems to work already?

and the field x86 specific? not sure about other archs.

