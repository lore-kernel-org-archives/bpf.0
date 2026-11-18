Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990150;
	b=pIg+UyiLRAcWcb7SgEE3CHr5aSddQkSoMy11trDeM4YLsSH/wpQks1kX6x8s2Pl4ik+0
	 q5xkUpWI7Ma3aVLDOq9GPfRgXmCCYAmSyoN9vfC+h7IW50zVSJB+Uxxv1uPlrbWaCr/Rg
	 TK7PFrhgUG69+3bkhBbXQYpQ1Ucbf1Mijb0GHenWLbzVo5QlELSAAyIUjGM22qZ18V201
	 p4gSMMJ5pjFuICRmYTr1kNeoYg9oD+51KoViQ8oHo9o88k+qo3SzGhv6Gkno1nNFVxi1Q
	 Ulcio8fRB9jyVpy0vHq1PKihSR2h7+kFDcXp/RKV/zyU9LBtUVXtKIEPlmYxNn9EjSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YY7OhV17wHxskwjQGjuNIBBpGZWHtiDuvNk3SBEA90w=;
	b=ImRTiPkdLH6cA6ZDgq10l2yoZewh/K5sa1gLiwxBMVAm9oQJK0JnQXP8hpt13+nHhr7C
	 Q7e2zNDqmiRCH7sp3zzxISY1mwTRz+Qi85u8qJndYLXwIrEdikNiCKX6JrG3z7JLIGgJU
	 kerzCnNThbImMP66xT+OCr0JUd/X0bQXFUhYq3bUGM/gvYxKw4i1BXyz9l85bHvJsVC6T
	 8pj6ewfqzkd56RjteToX500RSCOO2dMM3cr3N7qvBp0iM7DtXAGK9DcZlWVYpyJ21xJoT
	 6hs/0Ez5axD2UdEvyX8mfwSwAh8/P6VywuqzjU35/Ypi1vL5XAcOFOBsNwzl03SURjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Uc/Ea46X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F0606A325
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uc/Ea46X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8EA1F000C4;
	Wed, 18 Nov 2026 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990150;
	bh=YY7OhV17wHxskwjQGjuNIBBpGZWHtiDuvNk3SBEA90w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uc/Ea46XGbh3Joa+xoXmCELIxVLiXqf4vCmLY5GU7x0gbIm8Hvi9sAwmBkaYRTafL
	 FCMijSW/OuwXSB4JsMv5muDkwx2gYk8Fqa1kj1lEelOsHJ2m6mh6K8o2etX/beqBi8
	 hQ7SbBVzXnQpUaIC5stK8JwWSBZBvqMXLH1bGzAv0R4De9w3on6168kpWfnsvdIWAF
	 4qoi3cDGB4NUfxlxF/vcv7ZFGbkTfLw4H+vt/5bl3zp6dZf+LeR4AjMx/8q/gL5T8p
	 sywrJiveAfQU/355CwWltXR4en9QX3B9N1A0r0EbA5Oe1sY2d5u+mFBTLqO0dDpUSR
	 bhtXZ0QI0Ox8A==
Message-ID: <sashiko-outbox-220432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: BPF: Optimize doubleword loads with ld.d and
 ldptr.d
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261118081201.10498-1-yangtiezhu@loongson.cn>
References: <20261118081201.10498-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:22:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] loongarch: bpf: call to undeclared is_aligned_signed_imm16() in
  build_insn()
--

commit 6d9b52d1b981a940a37fd81d368c20f9bfdc04fb
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: BPF: Optimize doubleword loads with ld.d and ldptr.d

This commit optimizes 64-bit BPF doubleword loads in the LoongArch JIT by
emitting ld.d or ldptr.d when the offset fits in a signed 12-bit or aligned
signed 16-bit immediate.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 15af1abb5cb69..15f40b570b9af 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1352,8 +1352,14 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx, bool ext
>  			}
>  			break;
>  		case BPF_DW:
> -			move_imm(ctx, t1, off);
> -			emit_insn(ctx, ldxd, dst, src, t1);
> +			if (is_signed_imm12(off)) {
> +				emit_insn(ctx, ldd, dst, src, off);
> +			} else if (is_aligned_signed_imm16(off)) {
> +				emit_insn(ctx, ldptrd, dst, src, off >> 2);

[Severity: High]
Does this break the build when CONFIG_BPF_JIT is enabled because
is_aligned_signed_imm16() is not defined in arch/loongarch/net/bpf_jit.h?
The prerequisite commit "LoongArch: BPF: Fix the offset of stptr.w and
stptr.d stores" noted below the --- separator is not applied in this tree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118081201.1049=
8-1-yangtiezhu@loongson.cn?part=3D1
