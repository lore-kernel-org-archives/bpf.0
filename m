Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFE383987
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333774; cv=none; b=q4Gdn2UOT24q1yy4CNc3+FR3IH+7Uzi9qEH2KUsmnMW90yjk5I7IieK968rPnwLvgGlcD9hxF4isxAfmhckzFJLy/frekseIOc3AZ76vf1DVDVAIk/Lgq+hNVvKJReXiLeJDAoXvGfZdRz74PbHav+Sh+hCEYLtxOlGnfsUBTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333774; c=relaxed/simple;
	bh=JPcoi5saOBHcu4nsG91gm8rcW51gGL8+/lBu6F2822c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NqWVfzba3EEsovwdbTbvdPm0bTbwucmE+1cFjYCloXmyUQnM/Ede5wvg1PgvXlDgBh9wBtmohFB6K0jsY8IOrGBOLc6WuZMGdhCuhvL/x1AU+vrgTaNd445w4tjJ898GwDzZOHoOlm20Oaw7YyWxuKn0IGR8bI0A/4xxghXjeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhWJgqZq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhWJgqZq"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1093159a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787333770; x=1787938570; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/7XAKgq4vNvdGZHJh3eTmjhy9qLeNGXR8tI6Jinfx3Y=;
        b=KhWJgqZqxy1ExD+9ZYt4uvMwd4HKs6rZHGNeZxxkdsN2S26I46j5c2gTDG71HFXRYX
         1FxMVAfiu9pkoYCGj7mj1jz0Yu8+9Eg4PzjIgV1yTBKrXi2XVuyTDvHbkg7ntaO5hHdy
         L0fnB1Yyd0jlkveZMWMFRn0pGePAviDoph9cmRAcacooDr4JexuNm+Tsc5fkV/WR8aj7
         5JR9iFR24imUViJSgc+Rl6lZvuxwDW0cqCjw8tN/e0Q56m4ca8ayMaek2yNPRv1h63f/
         +ZGvWEL9wd9N3mZL6IWdhC06hBHz+euI8tZavi2iEcWdHANcz/5IKMvjtAHcYzHig36c
         k6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787333770; x=1787938570;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/7XAKgq4vNvdGZHJh3eTmjhy9qLeNGXR8tI6Jinfx3Y=;
        b=VILje3+hmAQOfkEFxM/QUd3x7p/E7mMPSc38v22Eo8gJ39d0F00DU07kvwKSVI9PiT
         OVtKdXVbXqt/xU98U+CFNr2Zq40DSd0Iq9/H5n0hvRwQqUTrXqpL0+4EElwf4Le2EZ3b
         3iPcIpO3Roe86CtUx3yacmgk8Wv7GQBr/ORkAer17Wta0AISeKVUxImQzrauycs3nMyA
         XBWuWU4x1BBYllkAhI5cKmHsxtfqmf9tH32kal6kauXfJqEtLippgKsDxLUmaWwD9eBr
         op+1JzeGEocf6Lkg8k5rS/s9b0LA9PBPNrS+eD/3vU5P4wVHn5QctaUFXp6ijfqTesSn
         fHEw==
X-Forwarded-Encrypted: i=1; AHgh+RrcbjVmXKiRtkXcNqDOaKP9n5XW4pxlurclZnxJZBwpDVxFRfSDDCEd6Z6Ig48Fml/WZKU=@vger.kernel.org
X-Gm-Message-State: AFuF++l9Y1Y51OLXiojeLO6dwWNqfLuYBUNxK12sr6yKC69jYX6pyVTn
	LVFLiwReoNQlWlrOAVytphN64oovIoMkZV4cJM53SVnUaNolHXZAOEOx
X-Gm-Gg: AR+sD13cE2PwRloXDESvcaQneOqtXQpSfifZYm8smcyl55x//lUSDHhkO9yjGrfKVvy
	WlK6Btq+9TaOKsjt1pMht4qrJuH2xum8DPjutJeW4nWaFtKnwWj3/KXyZJ7utTYvThRHxemVe0S
	Sn4ahtqr0n8BvEHPp5wphMm0YbMuyRJYCObKcfFTXL/71p70wTzDQ2XVSCEPC+HTcExba+EkZoC
	XsNyu63mFS+bEO6f2tEAaUjWzHSWID0s88uFzqLP0j78k1wQxSc0FHJ9IjYmPhZ8LBOOWUodL8q
	P+6N09u0AO9K0eciwDNwICH5VjX6kRhJZGZN+QTjDW9zt9IgieihuHTfb9RVksDt9onJs7cvP4i
	UUfeOyPuH4mJoDMq+4MAshS+jFFih1V//pCu5fm5kFo3i+QgBohLMpB6WV2wnCRxneWLxG+FfVt
	wA1pWfCNd7317HilwUAC9TMb3mhAAuXcZ7DguYyHJuyYTgHY0kbEX2KChRbBxUyPX5FUtF1687O
	CamLdoTi4NOpeUq
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395df4dcdbcmr319265a91.15.1787333769859;
        Fri, 21 Aug 2026 10:36:09 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c46b88e9sm3985209a91.7.2026.08.21.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:36:09 -0700 (PDT)
Message-ID: <f97bb12895dea33aa8f79b0468b5ada81510cc9d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Rewrite "rX <<= 32; rX >>= 32" into
 "wX = wX" to keep linked scalars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Fri, 21 Aug 2026 10:36:06 -0700
In-Reply-To: <20260821042837.2786719-1-yonghong.song@linux.dev>
References: <20260821042837.2786719-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-20 at 21:28 -0700, Yonghong Song wrote:
> For the following test in
> tools/testing/selftests/bpf/progs/verifier_linked_scalars.c:
>=20
> 	void alu32_negative_offset(void)
> 	{
> 		volatile char path[5];
> 		volatile int offset =3D bpf_get_prandom_u32();
> 		int off =3D offset;
>=20
> 		if (off >=3D 5 && off < 10)
> 			path[off - 5] =3D '.';
>=20
> 		/* So compiler doesn't say: error: variable 'path' set but not used */
> 		__sink(path[0]);
> 	}
>=20
> Without alu32 (-mcpu=3Dv2), the test
> verifier_linked_scalars/alu32_negative_offset will fail with llvm22 and
> llvm23 like below.
>=20
> =C2=A0 3: (bf) r2 =3D r1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R1=3Dscalar(id=3D1,...) R2=3Dscalar(=
id=3D1,...)

Does r1 fit into 32-bit range at this point?
I assume it does, otherwise it won't be possible to infer information
about r1 range through zero extended r2.

> =C2=A0 4: (07) r2 +=3D -5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R2=3Dscalar(id=3D1-5,smin=3D-5,smax=3D0xff=
fffffa)
> =C2=A0 5: (67) r2 <<=3D 32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R2=3Dscalar(smax=3D0x7fffffff00000000,...)
> =C2=A0 6: (77) r2 >>=3D 32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R2=3Dscalar(smin=3D0,umax=3D0xffffffff,...)
> =C2=A0 7: (25) if r2 > 0x4 goto pc+5 ; R2=3Dscalar(smin=3D0,smax=3Dumax=
=3D4,...)
> =C2=A0 8: (bf) r2 =3D r10
> =C2=A0 9: (07) r2 +=3D -5
> =C2=A010: (0f) r2 +=3D r1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R1=3Dscalar(id=3D1,smin=3D0,umax=3D0xfffff=
fff)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R2=3Dfp(smin=3D-5,smax=3D0xffffff=
fa)
> =C2=A011: (b7) r1 =3D 46=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R1=3D46
> =C2=A012: (73) *(u8 *)(r2 -5) =3D r1
> =C2=A0invalid unbounded variable-offset write to stack R2
>=20
> R1 is never narrowed down, so the address stays unbounded and the store
> is rejected.

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 821b47ac75c5..e1de442801d9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15610,6 +15610,14 @@ static int adjust_scalar_min_max_vals(struct bpf=
_verifier_env *env,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static bool linked_base_fits_u32(const struct bpf_reg_state *reg)
> +{
> +	if (reg->id & BPF_ADD_CONST32)
> +		return true;
> +	return reg_smin(reg) >=3D (s64)reg->delta &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_smax(reg) <=3D (s64)U32_MAX + =
(s64)reg->delta;
> +}
> +
> =C2=A0/* Handles ALU ops other than BPF_END, BPF_NEG and BPF_MOV: compute=
s new min/max
> =C2=A0 * and var_off.
> =C2=A0 */
> @@ -15878,7 +15886,12 @@ static int check_alu_op(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
> =C2=A0						insn->src_reg);
> =C2=A0					return -EACCES;
> =C2=A0				} else if (src_reg->type =3D=3D SCALAR_VALUE) {
> -					if (insn->off =3D=3D 0) {
> +					if (insn->off =3D=3D 0 && insn->src_reg =3D=3D insn->dst_reg &&
> +					=C2=A0=C2=A0=C2=A0 (dst_reg->id & BPF_ADD_CONST) &&
> +					=C2=A0=C2=A0=C2=A0 linked_base_fits_u32(dst_reg)) {
> +						dst_reg->id =3D (dst_reg->id & ~BPF_ADD_CONST64) |
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_ADD_CONST32;

This commit consists of two parts:
- a special case for wA =3D wA assignment
- a rewrite for `rA <<=3D 32; rA >>=3D 32;` pair

Could you please split it in two with separate selftest for each.
Also, could you please comment why the special case for `wA =3D wA` is nece=
ssary?
Is it because assign_scalar_id_before_mov() destroys the link:

  static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
					  struct bpf_reg_state *src_reg)
	...
	if (src_reg->id & BPF_ADD_CONST)
		clear_scalar_id(src_reg);

?

If that's the only reason, is it possible to extend existing wA =3D wB
logic instead of adding a special case?

Also note that this overlaps with Vineet's series [1].
Representing zero extension as a combination of BPF_ADD_CONST32 and
delta =3D=3D 0 is a valid alternative for one of the patches there,
but it also handles the value reconstruction on sync.

[1] https://lore.kernel.org/bpf/20260814231945.3884596-1-vineet.gupta@linux=
.dev/

> +					} else if (insn->off =3D=3D 0) {
> =C2=A0						bool is_src_reg_u32 =3D get_reg_width(src_reg) <=3D 32;
> =C2=A0
> =C2=A0						if (is_src_reg_u32)

...
