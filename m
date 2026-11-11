Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399827;
	b=HrcqvOVzcbc01kck10WJ7eR/ckF65kZmt7cQElVOWLeYdgj0pHbMNNc2pX6EcngJYsXL
	 F1tgB5HhQRmCQzeFQqsfOWBMDAAR3U2uVMfnPPsbIfhOqbPqKnyryQ/RRKYAoHzw7EBZ8
	 MDecUm6y4AusQiWZm3Zi3AawvDmuCd2TH+W3sAx3Ah2JkyZup1Oj7llPW4VNWX7uLYa73
	 5dxWTBoUrv9rZlLAk5FFmb/e6LvbhiorBXoVVf7y4/XvUFdpb3dBK1Tu8xGAZYnVe7+iY
	 Wa5pojPesEmYqlYX4BMucqEJEK2o3VUZnyAqZB14HOsneWLxFdS/B7jeWCjDgj/STYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399827;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EKhNvnqzPZNXveCLpzlJs+ib4Dylr9jyxyMai4yJUsg=;
	b=CJbEy6Upb1PDrQ8lXjD6xQhpAUyBTG5aVAht07IKnR0SwY7+kykD+gZty09Y++RQ1EJx
	 VYdDTDrVyPbmcyazRCD6mKDi/elYM7CNngNmbEqOk6/DdFTN2DLTfoK3XaNMHKAK+AMZY
	 HgGZNUywOCpJLgPNL4noHMw1ioQ4xzRBHM5lUunPNzmZjIAnRVe6CLn2mY7AAZ2BOw0Sj
	 Zyik05bol3vG0PpBhA4TagIPowD2j3Y7jP+EdqAFUF88T/Z2Zw3jIXjB+lYmxhFnf3hvL
	 QAaYwYs+tQZdkmvP1IGOD8tKqrydw9CM3Rdkq6PMge0+VVf6dlLmy5RYusABpWL95Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kilZk2ga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A855606A32D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kilZk2ga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18621F00A05;
	Wed, 11 Nov 2026 12:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399827;
	bh=EKhNvnqzPZNXveCLpzlJs+ib4Dylr9jyxyMai4yJUsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kilZk2gaw8Dy9FNWHDLSy6Pu8P71MNb+jyQ+c2k14j7kBD0MMPz/CcHSgyVwIdO5a
	 71Uu/S48pBLce1rBGAK7gGSF6X1CyHo/cPEt23egT7YT8wmHu/tA29TbHltizu1FTr
	 KsoUlxQCrV0Xjijcmb8tpJw/6zZYBX+/ILQa0GYrR0UTG7u5g+SJLSc/johnUqU5up
	 ZbHpxzQjM2GCJFwhQAc1IyajV7g3XzKGNs31ut1b6q6+233aNG89m4HxXDYzpr1Msn
	 Y+Xzw4mrkdOPtCOAAm30J4giQ0+fCggk9v2I9z2IyN3UhAJwX9D2Ed27ZxXmjsDGFv
	 L1S6ABq+RdxCg==
Message-ID: <sashiko-outbox-208972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf, arm32: build constants inline instead of
 using a literal pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramin Moussavi" <ramin.moussavi@yacoub.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261111121621.665533-1-ramin.moussavi@yacoub.de>
References: <20261111121621.665533-1-ramin.moussavi@yacoub.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:23:46 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] bpf, arm32: non-standard multi-line comment style in
  emit_mov_i_no8m()
- [Low] bpf, arm32: unused flags field left in struct jit_ctx
--

commit 04b7597139a2756fa5ffbad42747333b65860a8c
Author: Ramin Moussavi <ramin.moussavi@yacoub.de>

bpf, arm32: build constants inline instead of using a literal pool

This commit replaces the literal pool used for non-imm8m constants on
ARMv5 and ARMv6 with inline MVN/MOV/ORR instruction sequences and removes
the literal pool tracking fields and overflow fallback.

> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index 9ede81afbc50e..d3b5d77450687 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -130,8 +130,6 @@ enum {
>  #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)	/* TEMP Register 2 */
>  #define TCALL_CNT	(MAX_BPF_JIT_REG + 2)	/* Tail Call Count */
> =20
> -#define FLAG_IMM_OVERFLOW	(1 << 0)
> -

[ ... ]

> @@ -209,11 +203,6 @@ struct jit_ctx {
>  	u32 *offsets;
>  	u32 *target;
>  	u32 stack_size;
> -#if __LINUX_ARM_ARCH__ < 7
> -	u16 epilogue_bytes;
> -	u16 imm_count;
> -	u32 *imms;
> -#endif
>  };

[Severity: Low]
With FLAG_IMM_OVERFLOW removed, is struct jit_ctx's flags member now
unused as well?  Nothing else in arch/arm/net/bpf_jit_32.c reads or writes
ctx->flags, so it can be dropped alongside epilogue_bytes, imm_count, and
imms.

[ ... ]

> @@ -469,7 +411,30 @@ static inline int bpf2a32_offset(int bpf_to, int bpf=
_from,
>  static inline void emit_mov_i_no8m(const u8 rd, u32 val, struct jit_ctx =
*ctx)
>  {
>  #if __LINUX_ARM_ARCH__ < 7
> -	emit(ARM_LDR_I(rd, ARM_PC, imm_offset(val, ctx)), ctx);
> +	/* A single MVN if the inverted value is an imm8m, else one
> +	 * MOV/ORR per non-zero byte -- a byte is always an imm8m.
> +	 */

[Severity: Low]
This isn't a bug, but BPF code uses the multi-line comment style where
the opening /* sits on its own line and the comment text starts on the
next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111121621.6655=
33-1-ramin.moussavi@yacoub.de?part=3D1
