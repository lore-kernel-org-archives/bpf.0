Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506558;
	b=Di53OPsEHZ5rTVSo/l6LWrh3EImIi8qyzq0TiTBRvptiqD+MkhvcwnmJisfyZ4lapsSD
	 j0dsKqVXE5tP6qxITD+iMNxYV+z9ZXA8D+ii/yAB1BEMV74BgwOXwMp3N07hkPhcZdZ9m
	 fvgBTnhcw0sS0UT0DkqYckCxlxwUEvLtwhtK23p6OW2PF/9p9xCCsI1flmuZyKs7FZN/U
	 M5ScyoVKnSKg1sUZ33AI2ABSYtUoWwdwK/IDXovNxA564sx8WiCDh3dP5NBQOP86KVRY0
	 h61DdfCrM3GYuSAHkSG0w7nfRp5CEfZVMuipmV/XKvVazSi2ia2JDm+mCEbCqG+32iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506558;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=loUzI+oZhdFjsW7+as3iN78js3idYn3mcBcB7RB6Dds=;
	b=XzlMgq9tZAIPwvAkepqUGGzjc9Tu4OQV6uLwPSKIXPso1pB6/U8UShQpHVxMVNC8wkV9
	 cCXytWiMI/R/Xy0R74844pOpz7qXnU/La2t1a8B33Djoj9RzIwhGA0zbDZ9PyLFuGutYl
	 QNCrS7GGIN+FiG/DPw9+J5bsLPM16LHqBhL+nNegPtpA78LGhijT84Uc2ZIhZwdku5TPG
	 ui96YHO6fqWJoS5nuTnSGE3bvRE0aLiZUXpwvFLUbDcwQjdDFqjDfWOxS3zLh3d4k4Axp
	 8DTIBR1F/0oWMZeusoqKRqsmuu8SDlIYwE+3MS4EcfoE4b/xK/WLVNfshfRGG0Nk1Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AigymW8J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDF606A31C;
	Tue, 20 Oct 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AigymW8J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50331F000C4;
	Tue, 20 Oct 2026 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792506558;
	bh=loUzI+oZhdFjsW7+as3iN78js3idYn3mcBcB7RB6Dds=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AigymW8JSo9T9QqUHXm3TG4dHMTB/hVv1VwTP4Kjjab/aBC9EPayDyejSBayx9+iK
	 u0/9Lth1IYvu/Ix/9NjedQtM4Ha3pZk00NmmlfqTfOe0X8EeYR7YelA09DaJZkPsbq
	 isTj0OOGz10V03RsvEHX8VhpQRHmbaK+4ENnZ9jK8au1H0pFw+SwXGovytkowagEh8
	 T1TXfhpU0jdJdMEuPICPhcCx0TBw6B3czNLAywoxYkhTAd0Z1EBkh+leERMoa41Jf0
	 z7RA27kSntasRmILJCRMv1dd2Xd+eR7LakMbs6JHOn6nN2+okHVrrDoSqi6fA1h3JA
	 3uT0gWK3cbObw==
Content-Type: multipart/mixed; boundary="===============7969852404286747253=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <296a3b9f4cb861d960d47efbb58a7dc9792f3038067be539326a5dd038854775@mail.kernel.org>
In-Reply-To: <bca6974a5064e05d9e62b8038147b26d8ecd8500.1792503001.git.xukuohai@huawei.com>
References: <bca6974a5064e05d9e62b8038147b26d8ecd8500.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 06/16] libbpf: Relocate arena percpu access instructions
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:29:17 +0000 (UTC)

--===============7969852404286747253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Relocate arena percpu access instructions

TL;DR: Nit only: the new BPF_PSEUDO_ARENA_PERCPU comment in bpf.h (and its
tools/ copy) starts text on the "/*" line instead of BPF comment style, though
it may match neighbouring comments.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6f70db7515dd..9e5fa52c9bc2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1418,6 +1418,19 @@ enum {
>   */
>  #define BPF_PSEUDO_FUNC		4
>  
> +/* insn[0].src_reg:  BPF_PSEUDO_ARENA_PERCPU
                ^^^^

This isn't a bug, but the text of this new multi-line comment starts on the
same line as the opening "/*".  Should it use the BPF comment style, with
"/*" on a line of its own?

/*
 * insn[0].src_reg:  BPF_PSEUDO_ARENA_PERCPU
 * insn[0].imm:      map fd
 * ...
 */

The same comment is duplicated in tools/include/uapi/linux/bpf.h.  The
neighbouring BPF_PSEUDO_* comments in these headers use the old format, so
this may have been done to keep that table consistent.

> + * insn[0].imm:      map fd
> + * insn[1].imm:      offset of the value in cpu 0's chunk, including the chunk's
> + *                   offset in the arena and the value's offset in the chunk
> + * insn[0].off:      0
> + * insn[1].off:      0
> + * ldimm64 rewrite:  address of the value in cpu 0's chunk. The JIT adds
> + *                   smp_processor_id() * chunk_sz to step it into the
> + *                   running cpu's replica
> + * verifier type:    PTR_TO_ARENA
> + */
> +#define BPF_PSEUDO_ARENA_PERCPU	7

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============7969852404286747253==--
