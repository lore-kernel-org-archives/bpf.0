Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986780;
	b=JEk9377ftRq5yp0Z5+NW0iUrGun1rZ/cS2mmvyb09hYDbATbFCFIznkxCZV43cqK8RDh
	 2gatTSfWRPb1ENznqGzeRbir/SPMQetR6jnqtsumfAq92nm7K/qy8rX2fcXRkkVTCvqDU
	 Rtz+t5mLBy1jdkNin7BWS2yAVNH8J/QKl2YsXgjkh2ylOJ/wqkf2k9wQ7cg8Iha2CtbfG
	 LTpUnLGwkWTno+UYPUgkbZHcyxGS67OpsDXPv73Ylxgp2Jjf6Gq6PmhupeZlcFcngnLUS
	 7UJFeRI+IDR/vP50mQpQAW5yPd57btocKI40PKIbfzOc9agvYgEzUuHc6QW3ac/Rwbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986780;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=9g5c9qF7njx6heBO9wiG9YqKuFpTp2nYwH01f9hQkDQ=;
	b=ljEiDkRq9/E0mvXLEI4JTLGJ42tD1gzcYHx5jRxhTAygqG5lejO6DDGjCVt9HRteXXJF
	 T55Bm0Vq89FIGk897qVuFTkG5/91a3SmqNE1jlErLsYOHidF7JxaPc6iuAqn5p0yOPQmN
	 sijdo0i7arsTEliU/aKF4EMQsF+C+YyWZJMGcfqzwK3myvUXSkm/9o0FGlraTsxIaOju6
	 G/eTePxvh2aGwu4HSXdZaCIyZpYzoOeamCnVDctWMfiqFEMjmluYyRYuls2iZ4lnwmM12
	 uy+/y82a93HIgFsWCvOgpAZl0LKtx90cOyKgIHVYbBGlOaFgJbADF2j9kQSper8SyHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+sbxV5a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C7606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+sbxV5a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658F31F01825;
	Mon, 26 Oct 2026 03:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986779;
	bh=9g5c9qF7njx6heBO9wiG9YqKuFpTp2nYwH01f9hQkDQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m+sbxV5anavnlEMegTAQZ+Til8ZxxV7c954P7y2vuYy/KK7e6JWnFm+dWBtRbR/L5
	 2oMQXScZ7Ar7WyJ1AMYpbgjDpH9eMWs1Tu4lkl0vkD5S0P1w6dUmjkf3Iv6PzGGwZc
	 9FxwICpUZiS+O0z6SupvEOSpfx2qHZ88c2RZGUcIPErmvhPYa+9YJjJ6MxPwQ1PHNK
	 BJSDA+MJW4yRAdko3LG/mC25s3XK8XNaSz6VN166jTdwpl0cvRg5XgUlx35Kjizh+0
	 Q7lmHgNVc5x91Kp3NXq05e319Yugr2vCk+SHmhm9pn04vKAUpuIaSKriVhXvDUGu9P
	 jsA145y9Ltomg==
Content-Type: multipart/mixed; boundary="===============2371380106680057312=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b83032257cbc9e1683bbcabeffb3d010374e9dffdb625ad957bdeafe95ed4e10@mail.kernel.org>
In-Reply-To: <20261026025943.404450-45-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-45-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 44/81] bpf: Mask the count of a 32-bit shift in scalar evolution
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:52:59 +0000 (UTC)

--===============2371380106680057312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Mask the count of a 32-bit shift in scalar evolution

TL;DR: Scalar evolution's 32-bit shift expression still shifts the full 64-bit
dst, so it may not match what the cpu does for w1 >>= w2 or s>>=. No program
is affected today.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index d0ba709694db..46ccce4ab130 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -731,6 +731,14 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
>  			else
>  				goto mark_dst_unknown;
>
> +			/*
> +			 * The cpu takes the low 5 bits of the count: 'w1 >>= w2' with 32 in w2
> +			 * shifts by 0. It must not look like 'r1 >>= 32'.
> +			 */
> +			if (class == BPF_ALU && x_or_k == BPF_X &&
> +			    (op == BPF_LSH || op == BPF_RSH || op == BPF_ARSH))
> +				id = expr2(scev, BPF_AND, id, imm_expr(scev, 31));
> +
>  			id = expr2(scev, op, reg2expr[dst], id);
                        ^^^^

Is (zext32 (>> r1 (& r2 31))) really what the cpu does for 'w1 >>= w2' and
'w1 s>>= w2'?

The interpreter in kernel/bpf/core.c truncates the destination before it
shifts:

    ALU_##OPCODE##_X:
        DST = (u32) DST OP ((u32) SRC & 31);
    ...
    ALU_ARSH_X:
        DST = (u64) (u32) (((s32) DST) >> (SRC & 31));

transfer() still uses the full 64-bit reg2expr[dst] as the operand that gets
shifted, and the ZEXT32 applied afterwards only keeps the low 32 bits of the
result.  So the upper 32 bits of r1 can shift into the result:

    r1 = 0x1_0000_0000, w2 = 1, 'w1 >>= w2'
        cpu:        0
        expression: 0x8000_0000

    r1 = 0x8000_0000, w2 = 1, 'w1 s>>= w2'
        cpu:        0xc000_0000
        expression: 0x4000_0000

The same gap exists for 32-bit right shifts by an immediate, (zext32 (>> r1
K)), and for 32-bit BPF_DIV/BPF_MOD including the signed variants.  BPF_ARSH
would additionally need a sign extension of w1.  BPF_LSH is fine, since the
low 32 bits of a left shift depend only on the low 32 bits of the input.

No rule in this commit or later in the series evaluates a 32-bit right
shift (af2fd429b9f6 adds only the 64-bit rule (>> (<< x 32) 32) -> (zext32
x)), so no program is affected today.  But a rule that trusts (zext32 (>> a
b)) to describe 'w1 >>= w2' would still be unsound for the dst operand after
this patch.

Should the 32-bit RSH/ARSH description use the 32-bit dst, for example
(zext32 (>> (zext32 r1) (& r2 31))), with a sign-extended operand for
ARSH?  Otherwise, should the commit message stop saying that the expression
describes what the cpu does?

>
>  			if (class == BPF_ALU)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============2371380106680057312==--
