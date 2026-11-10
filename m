Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332305;
	b=NXOXxyn5duL7XpoPF/2Du6VfsrHZM4l+KQXyz5oOa49n2XyUKqJBfF+uwd0WfkZB4Z5j
	 /I/XEpUX0LO74lcksg+MjZzLv4U2uIK4a2TAKLETYjk/Xxy6HrT933Veynqtg6si9LDhX
	 IQDRrWodZaKEdJpzW3EuTXG1TvfViH2vtkW0bugRo0WlVV1x69Hq4xwF8BVyffsuThr2d
	 SCvDJDdA/c+9lNe32GC2Y9wWWzHOOGwslBnvBGF9foZt6ETXgVgYET2+1PBfBsR/W4Knn
	 I7RLlfTEkoXCCqoHFTk7dY2gHJLiWoOVaUDocTES5EaYmvN8Tkh8BHr6cJQnvAtm7zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332305;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b0Z8lLiYkQtsAhyqi5STn5oiVA9zJP+1BP74ZjyQBR4=;
	b=2Op5MAdpYYG4LsptKe6x2hnUNnSec2jQJOCooZFZA2Kozbr4BWPPGxW12NucN8xYe5jz
	 0oVsxx3N4YusyfMIod8xFZgnjGe3ljVVVx6ByDxrwG40WN3wwYTyi3tsIzgMxK+IZgFNV
	 JBSCFH392KWJWeE+Wu/RZA+iW6ehDRBeoSOeTvQspDgmAbq9BGqnfUczPDZ0lV4MBrr/v
	 SpebiS0yMybXss2hRgjoUKrsX0PCeCEj/usi4dT7elHJAHDwWC8qBtxPAFFBYNRNquBRF
	 ruuByDZyfSMmzNb1TZYdVzzNCrvmU32uSrgZ+vVknq+P3hriC6VDVtrp21hGyRAmopw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emEEL9aQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529C606A320
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emEEL9aQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628871F0089F;
	Tue, 10 Nov 2026 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332304;
	bh=b0Z8lLiYkQtsAhyqi5STn5oiVA9zJP+1BP74ZjyQBR4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=emEEL9aQBgWTPCoVAg/KD4ZJJqgqJ9V/zl5VEzCWWsgfWNPf1u3RX/Ztbt1wdHCMj
	 u6EfWpc3CppSkx0ryJiPLDeVtZvrrCMf5LcAtUl6RHMoUbrsed7RXvEAvItdFeAF9O
	 PinVGnmXteGVUKpJqa5e3zBWiD253EvEXVuJ/Qu+7bYahL1RpVhP8ZC27RJNhXgoEA
	 cDFLWXqtBg3XSsbuHPIOvTK+mZA410+GKGnzfC/clV52/clezON+4XfgElm04+fesL
	 6L73FSZXgO218+BMVmlI2e97QEWIZ3jUI8nExZpBVsL2xtucfR3g/+BJCEO5Bs7T3o
	 E4knE+R5+m+GQ==
Message-ID: <sashiko-outbox-207493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 14/18] bpf: Require the JIT for fmod_ret
 programs on found 64-bit targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261110164046.454431-15-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
 <20261110164046.454431-15-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 17:38:23 +0000
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
- [Medium] bpf: missing jit_required in fmodret_retval_init() for 32-bit
  int on ppc64
--

commit be8ba9e6d31af4b7ee8b1ec3bc7241dc8e6ff517
Author: Anton Protopopov <a.s.protopopov@gmail.com>

bpf: Require the JIT for fmod_ret programs on found 64-bit targets

This commit sets jit_required for fmod_ret programs attached to found
targets with 8-byte return types so the BPF interpreter does not truncate
64-bit return values to 32 bits.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b12b57c7403e4..920ff39aac429 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23883,6 +23883,9 @@ static int fmodret_retval_init(struct bpf_verifie=
r_env *env, u32 btf_id,
> =20
>  	aux->fmodret_retvals =3D retvals;
>  	aux->fmodret_retval_cnt =3D cnt;
> +	/* The interpreter returns only 32 bits */
> +	if (size =3D=3D 8)
> +		env->prog->jit_required =3D 1;

[Severity: Medium]
Does fmodret_retval_init() also need to set jit_required when size =3D=3D 4?

On 64-bit PowerPC (which supports BPF trampolines without selecting
ARCH_WANT_BPF_JIT_ALWAYS_ON), the ELF ABI requires a callee returning a
32-bit signed int to sign-extend r3 to 64 bits, and callers inspect all 64
bits of r3.  DEFINE_BPF_PROG_RUN() defines the interpreter entry points as
returning unsigned int, which zero-extends r3 to 64 bits.

In arch/powerpc/net/bpf_jit_comp.c, invoke_bpf_prog() and
__arch_prepare_bpf_trampoline() save and restore all 64 bits of r3 without
sign-extending 32-bit return values, so when the interpreter runs an
fmod_ret program on a target returning int, a negative error return value
is zero-extended to a positive 64-bit value in r3 while skipping the
target function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110164046.4544=
31-1-a.s.protopopov@gmail.com?part=3D14
