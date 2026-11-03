Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709405;
	b=mdRsdVVkSoHZEARFkuslLCDBZ/q6ho3LErl4hXexgc35ZeaIKYf3ITusNTRlmBE5vsFq
	 hZU5IZc7SdP/ItfGq5rLfhA4fwBlcqVEDI488KacauWDxz+MQqrE9+zcY+N/yFeFUrCRh
	 Z5egEPNE21A5c0R/oOkpDrW3x6SK/tmCC3XdHZEoqcrIkXiusP+7tGFeprr0rufeOEs2r
	 ItsT1ntAZXoA+ng9abHAApU30Kd614iC2nFyroLVPxY8mnFswEwy5zrtAKnb+txR5KHtX
	 RVepS1XTatM4op+ATpUU5fbDuPDvzhsyJZm63lAfetp7hUl1YsmpZCTMtg7MiGkLsZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709405;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BCs3GTAOCfyjiTFzkkEkNqNmIoHwWm4lHFeqsBnb9D8=;
	b=HNe4Woo7fltlMtyMRxYZMgGh8A2GhJFgaAlzmBkQnbOSxWnkNLgfG5fIvoLG8lY6lUEF
	 Rt3VNhgDK+5GBbRCvqpASUH1E+w/f0QTf0qR8NZBiZLSefOzSS/hCGFd9SJRyQw/adhBo
	 4YKn01/bcqLPeEuHi9u5mC5J9csq73bEJ0/3eD6HpgZ0LvDRxplw5+OilSnk13tMlSqOd
	 YL29Vj80GoNQ9LpVpWhJ56jFrjLnNc0HEl0/lD9jpXQtK4ZJh4B70ILgsZyC2DuPpz1J5
	 p1MtFe2WalOGww+bIpkRZYmO7GagjlTxkie0MyMV4eTF2CZqCpjVN8mYAwLOlwgDspQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bsjpr/tN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81343606A327
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsjpr/tN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4097B1F000C1;
	Tue,  3 Nov 2026 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709405;
	bh=BCs3GTAOCfyjiTFzkkEkNqNmIoHwWm4lHFeqsBnb9D8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bsjpr/tN7bnNvZfVFXhjY2KjDhC/we2ItVUk2K9jZXM2HHdnJcjqQZvqV+Wd9cBwn
	 HAK6ixMXvsxa+TENCziEy+h/xaQHhG+JBnwlKy0pJsnP3Y7CKJjWn7x8NBOJj3YE4o
	 9gJYAKKhuTtNgfNx6Ud4jjp41/uqWMHWQ2vd1voYHlb3cRoGd+Xq7whKTy388d7eLc
	 jQXFUbclvNPOEBEvYK9IXfJjAIR1KiU8D0h7ElMmyr7n2ORgqSuBt3dszXhvDALS8G
	 iT1jdX09ruCgfHBs+EIhHO7dAJ1aDsvGr1cCz4PFo1qu0nte1qOo2A9ItsSudBrh1J
	 zweY/vTvlTZvw==
Message-ID: <sashiko-outbox-195256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 14/20] bpf, arm64: Shorten the tail call
 sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261103122733.1383002-15-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
 <20261103122733.1383002-15-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 12:36:44 +0000
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
- [Low] bpf, arm64: multi-line comment style violation in emit_bpf_tail_cal=
l()
--

commit 4fbf9f6098933836065a7c888c2383cfd6d009d7
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf, arm64: Shorten the tail call sequence

This commit shortens the arm64 BPF tail call sequence by six instructions by
using immediate offset forms for struct member accesses and tail call count
comparison, along with an extended and scaled register offset load for the
program array lookup.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a327c90fe2c78..bc1ec8b179b2e 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -905,13 +905,19 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>  	__le32 *branch2 =3D NULL;
>  	__le32 *branch3 =3D NULL;
> =20
> -	/* if (index >=3D array->map.max_entries)
> +	/* The struct offsets fit the immediate forms, the count fits cmp */
> +	BUILD_BUG_ON(offsetof(struct bpf_array, map.max_entries) % 4 ||
> +		     offsetof(struct bpf_array, map.max_entries) > 0xfff * 4);
> +	BUILD_BUG_ON(offsetof(struct bpf_array, ptrs) > 0xfff);
> +	BUILD_BUG_ON(offsetof(struct bpf_prog, bpf_func) % 8 ||
> +		     offsetof(struct bpf_prog, bpf_func) > 0xfff * 8);
> +	BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xfff);
> +
> +	/* if ((u32)index >=3D array->map.max_entries)
>  	 *     goto out;
>  	 */

[Severity: Low]
This isn't a bug, but in emit_bpf_tail_call() in arch/arm64/net/bpf_jit_com=
p.c,
should the modified multi-line comment place the opening /* on its own line
to follow the BPF coding style?

	/*
	 * if ((u32)index >=3D array->map.max_entries)
	 *     goto out;
	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103122733.1383=
002-1-daniel@iogearbox.net?part=3D14
