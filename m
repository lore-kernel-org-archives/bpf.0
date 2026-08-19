Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451BC1AB6F1
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787102172; cv=none; b=CrCjsQ/DT94IrxWuLEVp5h8ehcBMEIP0OLeRRmVjIKayowyu2tI4LgCAHGUCiKpe/FCzt9qOFy9TfM/Tmic8eUdWnCcfmSr0FweEdNyqeRwBl50IxtsFcQmX3NSAHFQ3TnoAYA+DbEzbHgfaqTY1adj+BlCTj9bdENHVsWOM4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787102172; c=relaxed/simple;
	bh=XgXcFcK9K90wh/091Gc4/kaim3OfedS6mk7mYSHHjYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fld4JxuDCKzjnjhYrPtdpi87UE6lcTlEbgHcqvCeWtZggLygk9r+sfpRnsQu5Twar87WcnGsuKk1OGT7CXvUVh4aYErc07CwQ4N72c9lrdarE4EqcBzIs/xbBVr5jdaskkVb7KaS6RylD+cS3/j4mo6jafK1avOT1Vi2kRST+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS06LUJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS06LUJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014451F000E9;
	Wed, 19 Aug 2026 01:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787102171;
	bh=wW3CQA59bwP264jOFAQxUzdlVVJ1Xs7AcLf2pB/AVAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HS06LUJSaJg5Mqr/cETgfR7cBuNUfQeTFNr4st68oHTm1BjUOntaC+FQqUDsMpjaL
	 XAy1E8DH0i0+4dP5bNW9yrRUShzA6pPJblZDIWCizgivmQz65WAGQAY0xywxHMavMh
	 9yK9ef53a0zmU9J0qW1B9yleGWxwio/6FHAqrt2k9qEUgQhFulFW2t0i+u4DYkYG54
	 0WsxlCZxQW2qhRPvY1Zl4aPzidvOviAsWYPeJLXZebivgyg1a1EQGIPA2ZlL+wGU6g
	 vItpa3VPmD2iVykK2hbbrKXjmFsXtbJxYuL6yTLASpq9kNdcYcgsehJLb4Hor81nH8
	 UaoSvpaQ/Dtdw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 1/2] bpf, mips: Factor register moves into
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicholas Dudar" <main.kalliope@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819010523.1057789-2-main.kalliope@gmail.com>
References: <20260819010523.1057789-1-main.kalliope@gmail.com>
 <20260819010523.1057789-2-main.kalliope@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 01:16:10 +0000
Message-Id: <20260819011611.014451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The MIPS BPF JIT silently miscompiles `BPF_MOVSX` (move with s=
ign extension) instructions as standard zero-extended or 64-bit copies.
--

--- Patch [1]: [RFC bpf-next 1/2] bpf, mips: Factor register moves into hel=
pers ---
commit a341e9c2445aa10a781c4264cc9b57117f7c9711
Author: Nicholas Dudar <main.kalliope@gmail.com>

bpf, mips: Factor register moves into helpers

This patch refactors the MIPS BPF JIT by introducing 32-bit and 64-bit
register-move helpers to remove duplicated backend-specific handling for
MOV instructions. It preserves the verifier-inserted zero-extension marker
behavior.

> diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp3=
2.c
> index 40a878b672f5d..bfe73b023983e 100644
> --- a/arch/mips/net/bpf_jit_comp32.c
> +++ b/arch/mips/net/bpf_jit_comp32.c

[ ... ]

> @@ -1485,8 +1501,7 @@ int build_insn(const struct bpf_insn *insn, struct =
jit_context *ctx)
>  			/* Special mov32 for zext */
>  			emit_mov_i(ctx, hi(dst), 0);
>  		} else {
> -			emit_mov_r(ctx, lo(dst), lo(src));
> -			emit_zext_ver(ctx, dst);
> +			emit_mov_r32(ctx, dst, src);

[Severity: Critical]
This is a pre-existing issue, but does this switch case in build_insn()
silently miscompile BPF_MOVSX (move with sign extension) instructions?

When the BPF program uses a move with sign extension (insn->off !=3D 0), th=
is
code generation appears to perform a standard zero-extended copy instead.
Since the verifier tracks bounds assuming the value was sign-extended,
could this discrepancy allow a program to bypass verifier bounds checks
and perform out-of-bounds memory accesses?

Since you are refactoring the MOV handlers here, should emit_mov_r32() be
updated to take insn->off and implement the proper sign extension logic?

>  		}
>  		break;
>  	/* dst =3D -dst */

[ ... ]

> diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp6=
4.c
> index fa7e9aa37f498..45fee6f6b87e9 100644
> --- a/arch/mips/net/bpf_jit_comp64.c
> +++ b/arch/mips/net/bpf_jit_comp64.c

[ ... ]

> @@ -742,7 +754,7 @@ int build_insn(const struct bpf_insn *insn, struct ji=
t_context *ctx)
>  		break;
>  	/* dst =3D src (64-bit) */
>  	case BPF_ALU64 | BPF_MOV | BPF_X:
> -		emit_mov_r(ctx, dst, src);
> +		emit_mov_r64(ctx, dst, src);

[Severity: Critical]
This is also a pre-existing issue, but does the 64-bit MOV handler similarly
ignore insn->off in build_insn()?

Like the 32-bit case, if a program uses a BPF_MOVSX instruction, does this
result in a standard 64-bit copy instead of the required sign extension?

>  		break;
>  	/* dst =3D -dst (64-bit) */
>  	case BPF_ALU64 | BPF_NEG:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819010523.1057=
789-1-main.kalliope@gmail.com?part=3D1
