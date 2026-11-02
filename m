Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601802;
	b=twbpPQY1w3if2GK3QWBK++oeRD4D4QmZCTapMcUeXLBPkV8q0PbzNYNi64ta6wpYJr8M
	 +eqlwqKssxNb9Frc1vnb7KkNHCzXUO8cbS99C626w0L2FbQkXjWYBIoKohRR+KB0/aNYq
	 laBZu43JiO5whDwAoxruQW/sP+dCWy/tGJMuiTZmm8eMYehRyohpcuPmwEs7Mi8N14z8A
	 uE2zXQyuahVrO3xyBOdGUcO+z7T+BYEvSCqWKD3RXBlFkwIdI/y5lSKXOzkwlHqXZ2Gkf
	 WKg98GZc8vnwzv9ObqgzFh2Yr+q5dSKK/3jmwcFNVvtatilVrxTgRk3lqCH2FUo+YEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601802;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=YVF6x0dCXBKBpluQRo8vvrlQF6C7fW2jryqX6c/2+9c=;
	b=jn5fTBN4EOQcAmqQNIfiNDcA35wkjDbC6k8ukT0gkdnT9lFmULnuIGUk8t8R5COTWZ9b
	 yBi/rCWqj9JnJrzLUuwVSuwiXXs6sP+ckD9I4yU/9uY+YELt0C+Js3e37Q20l8dbSxygL
	 z9ABVosl9AOD1dLXwZ74zgsgAE9OHqaan9XzSj93/DOTPAAR25PedB3hKHAfjiraYk7uN
	 hFTDVhup8QTPhDm4ncqB2Y3jFC8qo89cXfMAxQ6lAbXRNlPUTEHJOftK4HNQW/rl+kNrC
	 R2aQO+Ba0gQnGWlQVo67iwsSz5FWS/5DRnTcygJNDhXDAoud/1eBMu77XyNEMAEGuFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4L2zQ3Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBD606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4L2zQ3Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C41F000C1;
	Mon,  2 Nov 2026 06:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793601802;
	bh=YVF6x0dCXBKBpluQRo8vvrlQF6C7fW2jryqX6c/2+9c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H4L2zQ3QsKZJmXne4NsYpNUyOBP0L3iNJZd2rfj4bZw6KZipYJJ+EmnhCuhyExJvq
	 mJ8wRevG+dnTCLPYE8grrhMZGytVED20nKhhcXqv+ZsL4W+WBkKSpCxtbYodCY6l7p
	 pFmy8aJ5d/UKNjyrF5NDvwaHiOIXoAs+zI/erDiqr30R3kPj/kTvaDLvJbblV6LjLf
	 lkoOwtx9Pz5KSkP3tOx+CfOv8qDKPnRCV4tRyN1XdSVuIPYi0116fS80FlfsqAoVM8
	 Swy+xnd/OB3bXzhnUiXAJlVAYMo/7CR86yZibx/3BcDchX38qlnqqVlpTGXYE1QaCO
	 UcoSEpRodQfdQ==
Content-Type: multipart/mixed; boundary="===============6336502206671463158=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1275c51d5954f120687a687210afcb97fb7736e48864a031767a3930e20024e7@mail.kernel.org>
In-Reply-To: <20261102055543.3584718-2-alexei.starovoitov@gmail.com>
References: <20261102055543.3584718-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Invalidate a dynptr slice when its stack buffer is written
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 06:43:21 +0000 (UTC)

--===============6336502206671463158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Invalidate a dynptr slice when its stack buffer is written

TL;DR: Nit-level hardening, no bug today: check_kfunc_call() compares
buf->type == PTR_TO_STACK exactly, so a future flagged stack pointer type
might skip slice invalidation; base_type() would fail closed.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -15668,6 +15711,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		ref_convert_owning_non_owning(env, id);
>  	}
>
> +	if (is_kfunc_call(&meta, special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) &&
> +	    dynptr_slice_may_be_buffer(meta.dynptr.type)) {
> +		struct bpf_reg_state *buf = &regs[BPF_REG_3];
> +
> +		if (buf->type == PTR_TO_STACK) {
> +			meta.slice_buf.frameno = buf->frameno;
> +			meta.slice_buf.off = reg_smin(buf);
> +			meta.slice_buf.size = reg_smax(buf) - reg_smin(buf) +
> +					      meta.arg_constant.value;
> +		} else if (base_type(buf->type) == PTR_TO_MEM) {
> +			/* a slice is the buffer of the next one */
> +			meta.slice_buf = buf->buf;
> +		}
> +	}
> +

This isn't a bug today, but a subsystem pattern flags this as potentially
concerning: the exact compare buf->type == PTR_TO_STACK.

Here a match turns on the buffer-range restriction, and a non-match is
accepted with no range recorded, so invalidate_stack_slices() never
invalidates that slice when the stack buffer is written.

The other two checks added by this patch use base_type():

    } else if (base_type(buf->type) == PTR_TO_MEM) {

and, in invalidate_stack_slices():

    if (base_type(reg->type) != PTR_TO_MEM || !reg->buf.size || ...

I could not find a way to reach the non-match case with the current tree.
A grep of kernel/bpf/*.c and include/linux/bpf*.h finds no code that ORs a
flag into PTR_TO_STACK, and the buffer argument (ARG_PTR_TO_MEM |
MEM_WRITE | PTR_MAYBE_NULL) is matched by check_reg_type() against the
flagless PTR_TO_STACK entry, so a stack buffer always matches today.

If a flagged stack pointer type is ever added, would this fail open?
Would base_type(buf->type) == PTR_TO_STACK be the safer compare, so that
it fails closed in the same way as the other two checks?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41398067075
--===============6336502206671463158==--
