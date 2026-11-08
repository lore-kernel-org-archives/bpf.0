Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166721;
	b=yaVzARdFmpiWHYcZBWLRfIziezFeyexV7gbyeJkcCwapF2L4cXJq9ypgYjPVP2n0Kwy3
	 bBk08MNWYhFGNcvV/F7SDdKuwL6ziMkoqWSCHuo3toqY9tRc+T1un+uQj7jGkvD3ezXse
	 kXf0GufhGGOG0WpgZk7PDTtDaRrpTUt6axpLqN56OiAnYgcUS0bFzql5nYZdXCpdfGNCl
	 7Sf8gXA+OJfwXWrTrHmdo9cBihAzLG7Qkq9NogVFk72nJG1Ea/JDKUoevv69V4fAI3e+D
	 RrRBc3MHwposUwQC84fe9nBJ7a8EzXVeLFQLqaZtr7rdafx2wl7IBC/EHpnooMmHTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ybY0KqU9isYMv1n4RxzS5PmWPtfhbzGgLlzPXeABNXQ=;
	b=o/ZL6PLCoCvHIp05fMMZIg7YsQFsEQbU6KCGPODjFQFsvGXMAY7g7/+FmJwl5LrFWnvF
	 yrENeSTcKakcYlkbfI0xL9075lvL3u8QSKbGWpePgYmn7p7jA1v7G33uqsPg0zXZreopj
	 ZBnjl2cTxBVT+pMvc4TZp+fRo/IDyHWsfgGLN03rJ34AdDfGB57sCFGbvlfX3LUvtyOYp
	 peTRCs/7alJUBfbYCeceW79bwMLcQm784nM70M6guhKZP9fdwS09L7+QWQA2OBpJ6E6Wg
	 dQIVQUztTWT4oiPKaGdD2gPLnYRXcQKJHFAhlMI4wbokOtD8gwYbICFbz6SOCzGA/pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6v9d+Gk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D8606A337
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6v9d+Gk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853D11F008A4;
	Sun,  8 Nov 2026 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166720;
	bh=ybY0KqU9isYMv1n4RxzS5PmWPtfhbzGgLlzPXeABNXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O6v9d+GkDs2RLELY+29yQ9wWUterQfdzvZi30bri0nez9EwXbPGFwdbTnHCKoDK2S
	 u7JXXy1xOpqgbaCubPafhLCDbm9NIkJ6cox8gC8cJYdTCWIOs45tpWS845Asv3Xjq4
	 aFCmD5qi5OBOAhmmYXyNJE9CM+ineWC9kbFIRYRVfXODsi0gOtPz8dErjSXymR8qg9
	 lOD0LmnJkkJdGsbBsViFCmIC4kjC1E6xKdVCL+Zv6DpX5PB7hjCHKz5ryHryAaBtiU
	 +UNwNlDmLp8TVLu+BTiCBIeCqQMrLxSG1qFnMtiHfwbnbBT9v+CNdy6hoL7HxIUi0O
	 hVUC2Ufp//+zA==
Message-ID: <sashiko-outbox-203981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 08/24] arm64, insn: Reject invalid and
 unpredictable operands in the encoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <a039fe7efc077061852c80b14b6ebcc81cdef75d.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
 <a039fe7efc077061852c80b14b6ebcc81cdef75d.1794165614.git.daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:38:40 +0000
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
- [Low] arm64, insn: s32 offset truncation in aarch64_insn_gen_adr() for
  ADRP
--

commit cecf5be8cc096127beade0ea92a07c5f62e297a6
Author: Daniel Borkmann <daniel@iogearbox.net>

arm64, insn: Reject invalid and unpredictable operands in the encoders

This commit rejects out-of-range and CONSTRAINED UNPREDICTABLE operands in
several arm64 instruction encoders so they return AARCH64_BREAK_FAULT.

> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
> index 48a481aa9656c..87a06bd088115 100644
> --- a/arch/arm64/lib/insn.c
> +++ b/arch/arm64/lib/insn.c

[ ... ]

> @@ -1293,6 +1320,9 @@ u32 aarch64_insn_gen_adr(unsigned long pc, unsigned=
 long addr,
>  	switch (type) {
>  	case AARCH64_INSN_ADR_TYPE_ADR:
>  		insn =3D aarch64_insn_get_adr_value();
> +		/* The s32 offset would truncate a difference beyond 4GB */
> +		if ((long)(addr - pc) !=3D (s32)(addr - pc))
> +			return AARCH64_BREAK_FAULT;
>  		offset =3D addr - pc;
>  		break;
>  	case AARCH64_INSN_ADR_TYPE_ADRP:

[Severity: Low]
Can the AARCH64_INSN_ADR_TYPE_ADRP branch right below still truncate into
range when storing the shifted page difference into s32 offset?

arch/arm64/lib/insn.c:aarch64_insn_gen_adr() {
	u32 insn;
	s32 offset;
    ...
	case AARCH64_INSN_ADR_TYPE_ADRP:
		insn =3D aarch64_insn_get_adrp_value();
		offset =3D (addr - ALIGN_DOWN(pc, SZ_4K)) >> 12;
		break;
    ...
	if (offset < -SZ_1M || offset >=3D SZ_1M)
		return AARCH64_BREAK_FAULT;
}

When addr and pc are 16 TiB or more apart, bits [51:32] of the shifted page
offset are dropped before the [-SZ_1M, SZ_1M) range check.  Declaring offset
as long (like label_imm_common()) and casting the difference to long before
shifting in the ADRP case would avoid 32-bit truncation in both branches
without needing the separate s32 comparison.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794165614.gi=
t.daniel@iogearbox.net?part=3D8
