Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008904;
	b=YNbU/71mlXvpmq3U9mbVlLfUD9nq16X9VzVxadGH1vBANrcbJa26mr2+x8DkibuuN7qj
	 g1DDSPBVcb1GFXpjsxE648EE8cOLXlTiYU0xLfle8g3crwWbfF3UqMoVy1teqlMiD68/a
	 tE0Y6Wuj0TjxSOlSPMR0I7RFtsDHE/rjTdpWhrw8Mdop/smFPVtPYEcJsZPKjboyzHasF
	 LugM5ebBXjgg2+luUp0C5N6OCYKx1I9v3fGevFrqZ7IOzbv2g7GG35+VjeAwwqZa2uDVj
	 ncFrHtX+kk/9IzRn70ba8rLtYXR6mDrEdjUjY2vRxyePggkNzC3eJXjGN28R9eieHAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fkhiwzjq6tTnUNfhVS7G+yzPvYlfj3npjXysyXhl7xE=;
	b=GGUjBS/2q7XLAK3Lw/7Zo0dDAcolLoqPIGJW2oaaOK8ePlxZk7hapf/ah1lml1wntlGS
	 QDakrO9J5mcMiIj7DPXwTKB/ImSWoUaGIu4j450FFdJ3SpXYlAVIJOcXDejVvsJNPYHvU
	 eBHI3ywEQE8QOzbhyE3xlBnMuABkC9uzlKx+RusBQj3ZCu0x3QrGbgZ4zYXTIJ6fGx5sO
	 ZG+j2pwPqRg6EAaRP5Am8WGyXQJZJbHddaxEVwqdGJKltNy6S+fmh1jEoTZ/MQ234KDIF
	 4l0Ug3OnTSAcY0N+AO9PjL3ZuJuimbz4OOmkT2YeCFJyrUc8gG6cfYaPATimISPuQtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j413AkXO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE97606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j413AkXO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6A91F0089F;
	Fri,  6 Nov 2026 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794008903;
	bh=Fkhiwzjq6tTnUNfhVS7G+yzPvYlfj3npjXysyXhl7xE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j413AkXOfoyQpGU8h8A8EbnCXF6z7JS8FzXfTtUU2WvxQzT0rnEXWROwffbYmzC2f
	 oU+4S/SMFYVXlFC4ZJJeENLJrz8Z3Oo+rltAJaNN0S4GZOhROfElBqRjMlXE+n6J25
	 oPqx/u3lveRQLIj7zTwTYNrqQs0zrNhCd5ORbrFGoErRLyrg08MNrAVV/melC+bX7e
	 s4OSH8Chj2Bj1AU4WB55qjdBeommUkWsBSiRSFD2oVZ5Y/wRky29kHNDDUcf7fWAPk
	 I/J16PyGXlJhkuj48HVSiwyNlIdZZM2mTfAlJkHyylk9ZK8g1pijGlaF6bUGlNuBUK
	 9Lzdws/+XTsEw==
Message-ID: <sashiko-outbox-202390@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Rely on callback frame
 initialization defaults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106232110.2867412-2-ihor.solodrai@linux.dev>
References: <20261106232110.2867412-1-ihor.solodrai@linux.dev>
 <20261106232110.2867412-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 23:48:22 +0000
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
- [Critical] bpf: missing callback dynptr invalidation in
  prepare_func_exit() [1]
--

commit 468e6b1f0288b436ee1abb6fdbf7f6a231d967b2
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Rely on callback frame initialization defaults

This commit removes redundant NOT_INIT register resets and default return
range assignments from BPF verifier callback state setters, relying on the
defaults already set by init_func_state().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 389488e4e7a74..831a9c0f8c458 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12126,15 +12110,9 @@ static int set_user_ringbuf_callback_state(struc=
t bpf_verifier_env *env,
>  	 *			  callback_ctx, u64 flags);
>  	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
>  	 */
> -	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
>  	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL=
);
>  	callee->regs[BPF_REG_2] =3D caller->regs[BPF_REG_3];
> =20
> -	/* unused */
> -	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
> -	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> -	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> -
>  	callee->in_callback_fn =3D true;
>  	callee->callback_ret_range =3D retval_range(0, 1);
>  	return 0;

[Severity: Critical]
This problem wasn't introduced by this patch [1], but can the
callback dynptr in R1 or a slice derived from it escape into a caller's
stack frame via R2 (callback_ctx)?

mark_dynptr_cb_reg() initializes R1 as a CONST_PTR_TO_DYNPTR with a fresh
id and parent_id set to 0.  When callback_ctx points into an outer stack
frame, check_stack_write_fixed_off() only blocks spilling PTR_TO_STACK
into a caller's frame, so the callback can spill R1, spill a PTR_TO_MEM
slice derived from R1, or clone R1 into the caller's stack via
bpf_dynptr_clone().

On callback return, prepare_func_exit() calls
destroy_dynptrs_in_stack_slots() only on the callee's own stack frame and
never invalidates references tied to R1's id in outer frames.  Because the
underlying struct bpf_dynptr_kern lives on the kernel C stack of
bpf_user_ringbuf_drain() and the sample is released after each callback
invocation, the escaped dynptr or slice remains accessible in the caller
after bpf_user_ringbuf_drain() returns, leading to kernel stack
use-after-return and use-after-release of user ring buffer samples.

[1] https://sashiko.dev/#/bug/linux-05b65197-996a-40dd-bf7b-7710de2720b4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106232110.2867=
412-1-ihor.solodrai@linux.dev?part=3D2
