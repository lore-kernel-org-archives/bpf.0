Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362435;
	b=Si6HMxJVKZtvqPgPLzwNqsM/qzEUDl1ZgOk8NvgckHtw7C+dbV/9kEwxCtoXphJZsvjk
	 xZgQg6RQIui6lt5HR7f+afl/LVLJYI42uOlG3z+aiFB1qUAFk8W8zciUuVqO56hcaSqIT
	 57KDAeEUZcFJAtm3knDMyHGNf1W3GoARzWG6PqK6Sa/iZNyijNVAvw23of/NSe7NAZ6Io
	 VZ/ag9kJ9oiW7CPWyflFExpzaALja2NvniQr8m6vob5QUzbWX/yQ5YN3iPzVlU+oz2SvV
	 ruG3X2HGGcQdWlfudCYnQieQKkHbRfgozBgZgFQdJFEAacAtdKeOM8JHUodWZ3xUqFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4GAN534RqG0FV8SetC12YV5qfuNjerRyuKCDXjaj53w=;
	b=Y4DZ7MFY6NXE551Qrt2qYTUGiPEk4Bv0oILBZ96FAHj6VGal3bfHUq6WHEHJYyOllOFG
	 wpfqQaz02GSg5aeCdiUPZkqgwd/E+PGCq/b1ma0iUGN7V84v4W8Tv0oWBYPGt+z+seBiC
	 haLbjrjwZwUyxu5hV1eAbUaT8GL0Xf6NACGoWujSt6aesoRrGo2uazBtnyuxp5jJ66yY1
	 Z9IX6PDif96VAWwQ93QiDmswuIW/eZRbifI0oy6wAUD1/XQ04Vs76yYrqhZDkjEyVVFzg
	 ldaH0pDY5ftbbq7mIpuWNfyfQBquXY8oxQiRobfRjsA1V0KujJaU3nrM6qTpGM//PPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1qKGrO6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F9606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1qKGrO6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AF61F000C1;
	Fri, 30 Oct 2026 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793362435;
	bh=4GAN534RqG0FV8SetC12YV5qfuNjerRyuKCDXjaj53w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z1qKGrO66gDDOH3o1+QpJa+FnYA8XwM+qtIPHHtNdsOzhAQbE2oAp+N/x1wcTExGi
	 veF4WpCuk54rzmSjZkzha7gB4i3qkFhkkzW4lrZ4RpNqIYJxKS6iNLxf/tYHlGry6F
	 IZ7z50lwV2ypzWCTpLxfBVn+juQoMfDGu5luhasOhmdQK2PkPFzonwAfFegvQ5nsPH
	 FVrt1St6JbEMEgAk6qAmajSu4TO8UULcHBkIIHdy1OI2yowQ0HBQeh9noc5EVaezTY
	 hGPrbVVSwEJ4TYaxmTiHiDN+rF+RtEpAahibtGxpBZ0kclMNeUHguCCQxBOgrNZZ5L
	 Yag3D07FC67gg==
Message-ID: <sashiko-outbox-191003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 22/22] selftests/bpf: Cover a backward
 may_goto pushed out of range by patches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-22-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
 <20261030-bpf-verifier-patch-batch-v2-22-55cd43439f7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:13:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: unguarded may_goto mnemonic in patch_list_may_got=
o_gotol()
--

commit eca3890b39b8864add1de9d7c74a0378b21864ca
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Cover a backward may_goto pushed out of range by patches

This commit adds a BPF verifier selftest checking that a backward may_goto
instruction pushed out of the 16-bit offset range by instruction patches is
expanded to gotol.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/to=
ols/testing/selftests/bpf/progs/verifier_patch_list.c
> index 1370cdd5e5836..302e739caf83c 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
> @@ -172,4 +172,39 @@ l0_%=3D:							\
>  }
>  #endif
> =20
> +/*
> + * may_goto jumps back by 8195 insns, by 32768 once each of the 8191
> + * divisions is guarded by a patch of 4 insns. That still fits the 16 bi=
ts of
> + * may_goto, but not the jump it expands to, which has to become gotol. =
Once
> + * the budget runs out, may_goto jumps back with r6 set and the program =
exits.
> + */
> +SEC("raw_tp")
> +__description("patch list: backward may_goto expanded to gotol")
> +__arch_x86_64
> +__success
> +__xlated("...")
> +__xlated("{{[0-9]+}}: gotol pc-{{[0-9]+}}")
> +__naked void patch_list_may_goto_gotol(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r1 =3D r0;					\
> +	r6 =3D 0;						\
> +	goto 0f;					\
> +1:	r0 =3D 0;						\
> +	exit;						\
> +0:	if r6 !=3D 0 goto 1b;				\
> +	.rept 8191;					\
> +	r0 /=3D r1;					\
> +	.endr;						\
> +	r2 =3D 0;						\
> +	r6 =3D 1;						\
> +	may_goto 0b;					\

[Severity: Medium]
Will this break the selftest build on toolchains whose assembler does not
support the literal may_goto mnemonic (such as Clang prior to 19 or bpf-gcc
when building test_progs-bpf_gcc)?

Other tests that emit the literal may_goto mnemonic in inline assembly guard
it with #ifdef __BPF_FEATURE_MAY_GOTO, while the sibling test
patch_list_may_goto() in this same file encodes the instruction directly:

tools/testing/selftests/bpf/progs/verifier_patch_list.c:patch_list_may_goto=
() {
	...
	".8byte %[may_goto];"
	"r0 /=3D r1;"
	"exit;"
	:
	: __imm(bpf_get_prandom_u32),
	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1 /* offset=
 */, 0))
	...
}

Should patch_list_may_goto_gotol() either encode the instruction via
.8byte %[may_goto] with __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCO=
ND,
0, 0, -8195, 0)) or be guarded with #ifdef __BPF_FEATURE_MAY_GOTO?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-bpf-verifi=
er-patch-batch-v2-0-55cd43439f7c@gmail.com?part=3D22
