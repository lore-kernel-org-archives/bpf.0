Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059745;
	b=i2dUCMvFxTDgEs9znccXobbWNdFAyQZCwhVyybfgLRtlC6jFuMonjuNs5fn/T2fEpYZu
	 fC0GGs97LK2s9MTza4e+9BPcGrcwr0WC7XexneP4JVHvc703ny/Ds1zK99Zs6d9+FxOPF
	 Mp45pp/qxEJmd613WqB0MkYwtxiz3216JavxjeezmhZgwxKz9T+M4L759GoXdWOiNuZvZ
	 elgU+ICqp2smKiCY5R89A59b7zCdT0VGkov/5ZHzGAIyVmuZ7/PFRz0GMRowmIj2Ib8hN
	 wyfBqOODIhX5MQyQE8VpIZXOYpcQyZEFwwQzNYk5KJee8Cn+psXIXnKWV9xiOQsPIiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059745;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=RorH4zu2dR20S8Fc3CJxjNXj0kqbdBc/7LYcmfZDYuA=;
	b=eYxtRp9onl1ptPIOig6ocRppd+H+7JdD63u0svgw0AGgtmKdB3gvCCzD5QyXzUQ5VNN+
	 +C+H1H+spY5wUAraAnbAyg15CHrLv3PJsM5tNajESYamUsksKQF5DSrxJnDKV7zb/0kWs
	 hvvYfgg+foaV3b1yD1QAHfy385XFY7jShfYWZqnbQOJhjDGt3e2CcGcikdehB23YYIrog
	 aqpujRikFNKM3ED53IiBzKQh4xfGUGfCRZnRMWUzwSkAgqx21/k77reTLrHffFJ3F8Qix
	 Nv8AIy4ELb62zvmjW+E1DOHoFvMaTOQm6Z9uc2Uz0MBuvjcGehIfyAiJeZUrlyai/jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN6ArdLk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACE606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN6ArdLk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA5B1F01829;
	Tue, 27 Oct 2026 00:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059744;
	bh=RorH4zu2dR20S8Fc3CJxjNXj0kqbdBc/7LYcmfZDYuA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eN6ArdLkMHRlnADawpHfeg5HHkFwJvcaVl1jNQUR3KSQPk2GdBix4n4hIutmjBken
	 U72hyqqXlC/9tCcxWcC55lWMctSYcelaXH/x2tAXXUg7w6eutRvCxsgN9b1fDaZraI
	 27YNA7cNt61vF6lmAvhVJw6sAKNnz1o0xTTdXb/+URMXMEwAR/bulGT29JZcCsmrYq
	 gxndqOXC6MQbVSrJDnzXWVfUa42LNSba2JQo+kDI8ZzThmgVoAF9nx8YoAeT5ZtU3G
	 6xsaKimtvMN/RjyUHiObSx/F7mNfRSbCzeewQYqbAg3vFxWomP6yKTIy+Ij/PTcPDP
	 TDTdeyRmFuWkA==
Content-Type: multipart/mixed; boundary="===============7231796188864996388=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4896d56c7c52fa0a354c9b78f139bde55fec229791cfb49524f411ccce841f8f@mail.kernel.org>
In-Reply-To: <20261026-scev-simpler-clamp-v2-3-f373aec9825f@gmail.com>
References: <20261026-scev-simpler-clamp-v2-3-f373aec9825f@gmail.com>
Subject: Re: [PATCH bpf v2 03/11] bpf: avoid false infinite loop reports after changes in SCEV clamping
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 00:09:04 +0000 (UTC)

--===============7231796188864996388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: avoid false infinite loop reports after changes in SCEV clamping

TL;DR: Nit only: the comment above in_a_terminating_loop() is hard to parse
and may be missing words; a clearer rewording is suggested. No functional
issues raised.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index d7df6632a5c4..a6ae86f973e3 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -1358,13 +1358,33 @@ static bool need_loop_checkpoint(struct bpf_verifier_env *env, int insn_idx)
>  	return top->loop_id == insn_idx && top->terminates;
>  }
>

[ ... ]

> +/* True if any of the loops call chain is currently in terminates. */
> +static bool in_a_terminating_loop(struct bpf_verifier_state *st)
> +{
> +	struct bpf_func_state *frame;
> +	int l, fr;
> +
> +	for (fr = st->curframe; fr >= 0; fr--) {
> +		frame = st->frame[fr];
> +		for (l = frame->loop_stack_cnt - 1; l >= 0; l--)
> +			if (frame->loop_stack[l].terminates)
> +				return true;
> +	}
> +	return false;
>  }

this isn't a bug, but is the comment above in_a_terminating_loop() missing
a word or two?  "True if any of the loops call chain is currently in
terminates" is hard to parse.

The function returns true when any loop_stack entry, in any frame from
st->curframe down to frame 0, has ->terminates set.  Would something like
the following describe that more directly?

  /* True if any loop @st is currently in, in any frame, terminates. */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40421781646
--===============7231796188864996388==--
