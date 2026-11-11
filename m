Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403991;
	b=U4XpOzW8LU3H/opCjjhTMNcW5irx+kbIQa794umnVDiHr4mvLWZl/Rsw0rSvXM1C2NlU
	 MtvkOubMlzb0qUnMIyqsQ8WOtUQdw0Gm0d1UWWk9PurnQs0liverKlOHTT4QJuLAdU7zC
	 uCYO+llN8PF/4CweTxYjmuBONO1LVZepls9ZXodCjQtR2xUZd0svQQc3UqCtP7g8l4pFo
	 n4uYSYTQb/jlXMLGiYJCZJVm3fATFXl96pJObDgNqPZ7Qirr3eIuYaCzn3f6ejMyiATm9
	 8/ux+2RriNFbOHA+/J4914WNF5GH3PkkTHzlN7B5NLM923Gpzat4Dp+h9Vc3XW02xSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403991;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Plxo1yGphv/ixoaAaDnR26Ljo6BCiJ0s27jl/IT/8ZU=;
	b=vYrRGe7VUE0BFx4ws7cTD8Vk/ME+qDJNvn2N+1c9+iJBZ2ZdpDrfCM3SK1DYKWC08ZRd
	 DvECzdQkzNQuaCyPjsJUaCgHKPDFGUo4rxhAFHP5BvcB6ueUjbptwXUlnl/bKujo4i/MC
	 +XKWZ6OQcQmLx9o0++ucWphiWjRq/8DH4Y33SSv97gpqnZK7MVUC9s4epAGAWpUgoHhW7
	 HcrjqEIzepcuMUSUjD42N4mNqn1TNtwHvm95VLZZ4OiY+hiFcOl5PV5nKGe7JxDeDE/9k
	 Eq+VYV1B5R1zOK5qWbwPZXLMqLR8Zu0i2SpeU484tQPiqST2ZEWt3NUY9xeTEgtPNHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ncrt2Dy5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACD606A32E
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ncrt2Dy5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79521F00A09;
	Wed, 11 Nov 2026 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403991;
	bh=Plxo1yGphv/ixoaAaDnR26Ljo6BCiJ0s27jl/IT/8ZU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ncrt2Dy5nbxwJiCRig+wPo3gGMe8cfjpBbSaTl91ciD7SiGXgyJdvsfoKML6cFfDi
	 4ZfvTQDqVVBufmDqGM+yIusiQJGXL0v6gCTLQXVV/nKcuGf94nAAoOojM1G86m9JwD
	 4yk7H0SR1DVdh/2JAZWxUGPOcrykGAUfwRMi8KaSQVUAGFnoJOB7zoBPMnWuPM42Ec
	 eiaiUfD44gVflGSnv55Y7lbGUdASjb0myO1Uc1A1+2r4mKAGnRcARV9QQVLsMFA9Pd
	 HuxCalfM/diAYxSkVqLe4kWOzT7UHcUQtOOleMgJXHj+kJb5o4KYHCH0RYxHnCLaYc
	 pVrxMHtGbs7Gg==
Content-Type: multipart/mixed; boundary="===============4887617662354651281=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b9135e2110157ca4f60e48d324348b7abe57f12f911bdf701971c323fab53bd1@mail.kernel.org>
In-Reply-To: <d69e383da887f124f305006c9c0c2d56b39c7145.1794399387.git.memxor@gmail.com>
References: <d69e383da887f124f305006c9c0c2d56b39c7145.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/29] bpf: Give every reference an owner frame
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 13:33:10 +0000 (UTC)

--===============4887617662354651281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Give every reference an owner frame

TL;DR: Commit message only: the claim that callbacks release everything they
acquire may be inaccurate, since IRQ or lock references acquired in a callback
seem to pass to the caller in prepare_func_exit().

> bpf: Give every reference an owner frame
>
> The unwinder will release the resources of each frame from that frame's
> own stack slots. Each reference in the verifier state must therefore
> belong to exactly one frame. The verifier has no such notion today: the
> state holds the references, and a frame only knows how many of the
> references held at its entry are still held.
>
> [ ... ]
>
> Callbacks release everything they acquire, so nothing changes owner when
> a callback returns, and the transfer in prepare_func_exit() has nothing
> to do for them.
>
> [ ... ]
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Is the statement that callbacks release everything they acquire accurate
for every reference type?

At a callback's BPF_EXIT, process_bpf_exit_full() calls check_resource_leak()
with check_lock = exception_exit || !curframe, which is false in a callback
frame.  So active_locks and active_irq_id are not checked there, and
check_reference_leak() returns 0 for frameno != 0.

The only callback-specific check in prepare_func_exit() skips everything
that is not REF_TYPE_PTR:

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12688,6 +12701,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  		return err;
>  	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
>
> +	/* What the frame holds when it returns is the caller's to release. */
> +	for (i = 0; i < state->acquired_refs; i++)
> +		if (state->refs[i].frameno == callee->frameno)
> +			state->refs[i].frameno = caller->frameno;
> +

A REF_TYPE_IRQ, REF_TYPE_LOCK or REF_TYPE_RES_LOCK* entry acquired by a
callback survives the callback's exit with frameno == callee->frameno, and
this loop then reassigns it to the caller.

For example, a bpf_loop() callback can call bpf_local_irq_save() on a flag
that lives in the caller's stack, since bpf_loop() passes ctx as a
PTR_TO_STACK of the caller and process_irq_flag()/mark_stack_slot_irq_flag()
accept a slot in any frame.  The callback returns with IRQs still saved, and
the caller restores them after the loop.

For a bpf_spin_lock taken in a callback, the transfer runs too, although
the re-simulated helper call at the callsite later rejects the program.

Handing the IRQ reference to the frame whose stack holds the flag looks like
a sensible owner.  But the sentence in the changelog does not seem to match
this, and later patches rely on the ownership model it describes (for
example, prepare_func_exit() later calls bpf_frame_desc_record_return() for
every handed reference, including those of callbacks).

Could the changelog say that only REF_TYPE_PTR references are guaranteed to
be released by a callback, and that IRQ/lock entries can still pass to the
caller here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============4887617662354651281==--
