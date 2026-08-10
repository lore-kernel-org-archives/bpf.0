Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882113DD51A
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386064; cv=none; b=dx5ruYp3v3tv94una/wJ3hwd4IN2zaRmqk2jKGC3GzDcdNbzLSKWNlIsWjy7qjOBhC2aVCitkDbfMUrIp08a0TXFSQCFXUhoPnzsrjGVYDbVgZ3tocVGJro1G2ZRSwEzREQW9GRiPqUYsN95B1i0VC4ijWEgLbvLhTbJ/f3OiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386064; c=relaxed/simple;
	bh=aPIZO08bsNYjen49/Zqc7WgA/2FnGp4gU+6n59B/g0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OqB48FXck8yvHBsPqg8cyYkFQyMfQ8qAUYAB+3vVOvBrsKI+t1uklcknaNAbnY8KHqo8QQXp3BzMzmibIlNviX1wecdCMI8s6oNiyVX8Ctx2T2XZYcUUUYmxFTJv2EBWx4coHcBOjg70krhJbt/dpvIP1Utzmxs2B4bUmXtR+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee4vbi/8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee4vbi/8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceaf8a1265so34606745ad.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386063; x=1786990863; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YRfWrUAWy4Vi+ro8FIwgSzrb1lxGati9kChsa6OdP2g=;
        b=Ee4vbi/8ugquHmti/89hbGfqbCN96LjEj2Mbh4acSx6U9acflfop67VPlE0ksP9u57
         xP2b2ZrqhhxP4tgFv0TfKnx3ldsh9R1Bm7qWz1mSoivqQkIIALf1cTzN0I3DAfr/2eww
         /FmKs+DdcJX7/VmyHpTh+hrmvIYgLutoEHxxjffsd3KvWGdvwjTz9bu/I04tccO6o0Ti
         WXgkbky4iw5EY824AjxgE1x1ApgIV9q2rs/vyNokKSk3RQ0UpkZCIASje1jePK9onl3H
         tWefvHiRG4fQwLklSLkeWW+f3UA5fR/2FIUSFdBGynZdMZteRgZ3G2khGPHMYHv/Tzw8
         kgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386063; x=1786990863;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRfWrUAWy4Vi+ro8FIwgSzrb1lxGati9kChsa6OdP2g=;
        b=Xckcgm/gdZQkOAEwiaDaq0uLF5pjwWADQswdH89VQ5Auuq9CoQmIASTfqcwuMh/eG6
         irMTqOdCAD+XZzUhJDJvsRiF/w9gFQFZJRvRWSipd7nUvfEtEeH17b7bLCISV3pHbdSn
         sgivOXA/r2mcEgWTfGeJ57/SQ6ld2MpckdK/otC3VMyg39sM08Kdnt1yhhUok/Rt0t+k
         e9dH13VvSWVn29u6ZqbMi4kDCZ4vYUK/g1+23xqOOXSYvoFuh5kiU9F95z1BV1TnBsnI
         SrbipQLMVzlw1gHC0KigOxSRUZlZ7N/NFkt5cFkPmyxSSZp1UlFaRvMzfWPNCOvSgCLl
         b/Pg==
X-Forwarded-Encrypted: i=1; AHgh+RpAhejr4Ohv9w9gRIaoq7CuQShCQJUWDDiezUNwS1klENFcEbQGVze2dYMmqO0PtJ+A428=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqdz62BZNRmEQkcm/Gvg8hQvVatHFtFglKTO2yPaci7iZAAvkW
	bOvMSXagQuFex84b1RZ33W6WHT4axo8efBRSDxrZz3dS8KqXH/zYPR4f
X-Gm-Gg: AR+sD13asiTVg+5sOKjndaqtl+mcCKE2a40D4pHCU4k1Ydp23J5ljVJDpOhbKRlB/iP
	v0TNx0a9IfuZnLRvDfLgYGGU0t2hP7ECOHff/4xeQGcLhJXSCmn9/kff5z6k3kvbeNGv9AFtFc6
	fg8fvYqjPzDwnmGkWk7qBGf6YtP+XcTq1cH4mvn8W7iCxfdfzC+PVQzaNSN7xCB19fKLeFZsppv
	VWlDx/JFtgSwQTVycJVcCr/FJ70BqYHJKEvgjInzbOw5uwkpI2ukfALyYNJrHoCNPh72ky58IR9
	OO9CEaxbEjVsNFC+BgupwVSBaZNymaiM0eOIiw+S+R3ddjadqjnFaCrCJgYpXmxlRyXrK/lMJcH
	azLzGhmKNvrAT8ycDaQRm/pPiGyufiFCAn/v2cDPveyrpr4mHBgRKvEXntsDL78+uJbzlyUJ8+r
	DtDRsvzWY06Z53e/U1GW7rjvOsMdleZK8kiGp4FuUeDKn/uJgv/KfaTSlPa9L1MIvwnl+t4Qmxr
	zlGxtddnq4yv5gR
X-Received: by 2002:a17:902:d4ce:b0:2cc:aa38:4df3 with SMTP id d9443c01a7336-2d3003427fbmr35006885ad.13.1786386062676;
        Mon, 10 Aug 2026 11:21:02 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4d31a5sm41332635ad.71.2026.08.10.11.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:21:02 -0700 (PDT)
Message-ID: <7778fb7a81005f982f4073472f0435bc63a9287c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf, arm64: Clear fetch destination on
 faulting arena atomic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, bpf@vger.kernel.org
Date: Mon, 10 Aug 2026 11:20:59 -0700
In-Reply-To: <20260810134346.466004-4-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
	 <20260810134346.466004-4-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 15:43 +0200, Daniel Borkmann wrote:
> Same problem as on x86-64: add_exception_handler() folds "there is no
> destination register to clear" and "this is a store" into one DONT_CLEAR
> value ...
>=20
> =C2=A0 if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(=
insn))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dst_reg =3D DONT_C=
LEAR;
>=20
> ... which ex_handler_bpf() then reads back as the access direction:
>=20
> =C2=A0 bool is_write =3D (dst_reg =3D=3D DONT_CLEAR);
>=20
> A RMW carrying BPF_FETCH is both. emit_lse_atomic() reads the old value
> into src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and into
> r0 for BPF_CMPXCHG, so a fault over an unmapped arena page is correctly
> reported as a WRITE but leaves that register holding a stale value instea=
d
> of the 0 that every other BPF_PROBE_* access delivers. Same as on x86-64,
> add a separate ARENA_WRITE bit for the direction and fill FIXUP_REG in
> from bpf_atomic_load_reg().
>=20
> Fixes: e612b5c1d3ee ("bpf, arm64: Add support for lse atomics in bpf_aren=
a")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> =C2=A0arch/arm64/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++-------=
---
> =C2=A01 file changed, 26 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index d14d297ebb96..796ff9193cfb 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

...

> @@ -1183,13 +1187,25 @@ static int add_exception_handler(const struct bpf=
_insn *insn,
> =C2=A0	 * dst_reg like a BPF_LDX does, hence it must not be treated as a =
store
> =C2=A0	 * here.
> =C2=A0	 */
> -	if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(insn)=
)
> -		dst_reg =3D DONT_CLEAR;
> +	if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(insn)=
) {
> +		/*
> +		 * A store has no destination register to clear, except for a
> +		 * read-modify-write with BPF_FETCH, which also reads the old
> +		 * value into src_reg, or into r0 for a BPF_CMPXCHG. Either way
> +		 * the access is still reported as a write.
> +		 */
> +		int load_reg =3D bpf_atomic_load_reg(insn);

Nit: I think it would be more in line with the current arm64 jit organizati=
on
     if bpf_atomic_load_reg() call is moved to the add_exception_handler()
     callsite in the build_insn(), where it handles BPF_PROBE_ATOMIC.

> +
> +		dst_reg =3D load_reg < 0 ? DONT_CLEAR : bpf2a64[load_reg];
> +		is_write =3D true;
> +	}
> =C2=A0
> =C2=A0	ex->fixup =3D FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
> =C2=A0
> =C2=A0	if (is_arena) {
> =C2=A0		ex->fixup |=3D BPF_ARENA_ACCESS;
> +		if (is_write)
> +			ex->fixup |=3D BPF_ARENA_WRITE;
> =C2=A0		/*
> =C2=A0		 * insn->src_reg/dst_reg holds the address in the arena region wi=
th upper 32-bits
> =C2=A0		 * being zero because of a preceding addr_space_cast(r<n>, 0x0, 0=
x1) instruction.
