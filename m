Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCD33FE33
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706865; cv=none; b=B0eTtsIgU1pQCSIv6QRY/pUoI4U4EmO7m9H28X813FbMl9U1DKdOd61GmC3LVc2okIdTP3G70Myk8fgCMOD4sttqcDAX8ZAxCELLaFjC8KgWIkEG76Oe8TBl8163ugSFjcu7k7OEnJhzqaecuDb6MIbFQSaPNwOwNpzeL4IZpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706865; c=relaxed/simple;
	bh=bCXNjXX0avt03pnSKeFnS+FeRIoVIWYVEuLEN25JckU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XcnxWGNDQLyBzDTHByrY5jEaHNaY8Z19hO65tv7H/+p6JR6lEoOxTDrCPhKVDV1Sb8n9UyFZkB9vTsNQOx0dAESTuKC/RxAzyf08xktByJd33MRkx3fLwvgkAg3k2YWKVgfs4/l2CDZ0tlT6fPUeJ6jY3DIbUEYbyOtx/k1m4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+cgYUuv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+cgYUuv"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso2269189b3a.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785706863; x=1786311663; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+gUf7+fY5UlM4xOtPRiTooHEsPXbpqsZ+m9BdccM8yQ=;
        b=E+cgYUuvYHnZbbaBtnggvzR9rhD7BLGpTvul7owlTXzBAqi8R4gY+/msgSYQK6AQnx
         PAnIqW/yJMRrzSDaVIfSvi0cPfC+LqzyUCwRfjI4rVShkflaqd2LP84BU2DZeoyXrX9+
         hQi9K6Y2przu614jTPSzVep+mFMjiB5h2Iu9S3ZugyezrVSXVkkYdfMze0xvw0U+zcWh
         ezLOeOKxe45ky0koxbmxXHrx6hvrGabf3krNu6TBWMehAjkBELnPlGz7xLXZ0ZJ/23iu
         DKlbM2dzyapZN6/OClVGXWiI9Fy1T6dvz9s4n/KI8Rw7/IIsGnlnepgdmwMwx2gFUofQ
         edCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785706863; x=1786311663;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gUf7+fY5UlM4xOtPRiTooHEsPXbpqsZ+m9BdccM8yQ=;
        b=CjLswt7ViDlBElqRSyHcENirdl4vaKmu/pNYGHHl6EljrdZdpRnm6uMkwSu5LqrMJU
         O2XiMBA7lmgcZdd3GyJeRzTyFvLvX/vlWhdQjcOBE3Rr610Q+1pIRMl4TbzIkowczEqE
         pGkq0cPtNnBiwjvpzR2vEQ8pf+Nv2gdifKLNLamAdvhS/+b11pzPnKQJFNoYZ108gFNA
         DesWtPn1xl2aklSbKLjWY827VeS6meKMI0UGSlySut0r5cBNqSrO9T/BZzrZ/L5/GRML
         y+Ho6f/G06uXTh8w6/zAUKUvTPOldjyrt6oeM6EzR6cZUFYUFOBrmJRiQvRv+jaUlCO5
         LPRg==
X-Gm-Message-State: AOJu0YwvHiyb//+ohFHgZ5GCz0Lqx9Km3O16AyodvS7IOhT6zUq5yXTE
	0KXEHCKBEjkmBBKE6uZy4H7eradXVBuzMGYL3TIQvHir49cfF9ZAYTSzffl7eA==
X-Gm-Gg: AR+sD1303JcnElnwyEKrJGu2snu3V+p1mGJBcZUts7xwlGim+R2FEu9w3U/j3R4YGqW
	SSbzFRu1gqCXUz5SHVB+0euoWblDO/7A3Ngh5TJMmtVNkRnK5Jzb3uOMzdhfozXPguK5LGNtYvd
	08ziN5RuR3osYEPu70LnHWMgL8HM7c8a27aHrUTt6TwgalMDcFK+06BrjhEwNCifQhopM2K6y6u
	vKpbinNcBTKGCD1IPhdeN9I7m+3q0kNM0E98G1j9ipvHwMuho6zgzGX1OstgtJ4tq2eaE8Bp5Q0
	oOZyWXFIWHzjmwe9xeFD2NAlMHaatTCzwn0iNfOyXT1vWjnHNYhBlyFtPaImqFCZiTnNZ3Ey6gR
	wmUuQIVW0fqYMFxBzfUFeg/qoxrCWqJyfbAcdha9zPzgzm8V8igo5Y3XjigsKmuxXFekQI6i0xE
	J0nmvlVmbnR/jpaMlDrhIaYKiFJnE6r34ciBgOABq0Env8sDr38vg4N3uFM6SSlEYgOIAbTJOLm
	ry74My6UTwHPe25
X-Received: by 2002:a05:6a00:2d0c:b0:848:55a6:fbe with SMTP id d2e1a72fcca58-84ee499d324mr6616437b3a.35.1785706863118;
        Sun, 02 Aug 2026 14:41:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc3d88b9sm2755821b3a.51.2026.08.02.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:41:02 -0700 (PDT)
Message-ID: <20e990a0389bea4acb526dd7756699a95b0779b9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpf: simplify the bpf_is_reg64()
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Sun, 02 Aug 2026 14:40:59 -0700
In-Reply-To: <20260802212700.A46CF1F000E9@smtp.kernel.org>
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
	 <20260802-static-zext-v3-4-3456b2604574@gmail.com>
	 <20260802212700.A46CF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-02 at 21:26 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] bpf_is_reg64() fails to identify BPF_ADDR_SPACE_CAST operati=
ons with imm =3D=3D 1U << 16 as 32-bit when the arena has BPF_F_NO_USER_CON=
V set, leading to missing zero-extension and possible sandbox escape.
> - [Critical] Unconditional overwrite of `zext_dst` destroys manual overri=
des for `PTR_TO_ARENA` arithmetic, leading to missing zero-extensions and a=
rbitrary kernel memory access.
> --
>=20
> --- Patch [4]: [PATCH bpf-next v3 4/5] bpf: simplify the bpf_is_reg64() -=
--
> commit 4ece654ab9bc1fb0f5d2f2cc247cae7c94f2cb89
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: simplify the bpf_is_reg64()
>=20
> This commit simplifies bpf_is_reg64() by removing unused parameters,
> removing BPF_JMP instructions handling, and streamlining conditions. It
> also moves the function to kernel/bpf/fixups.c.
>=20
> > diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> > index 6125598d16a84..7b3510d46b377 100644
> > --- a/kernel/bpf/fixups.c
> > +++ b/kernel/bpf/fixups.c
>=20
> [ ... ]
>=20
> > @@ -44,6 +44,49 @@ static int insn_def_regno(const struct bpf_insn *ins=
n)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +/*
> > + * For use only in combination with insn_def_regno() >=3D 0.
> > + * Returns TRUE if the destination register operates on 64-bit,
> > + * otherwise return FALSE.
> > + */
> > +static bool bpf_is_reg64(struct bpf_insn *insn)
> > +{
> > +	u8 class =3D BPF_CLASS(insn->code);
> > +	u8 mode =3D BPF_MODE(insn->code);
> > +	u8 size =3D BPF_SIZE(insn->code);
> > +	u8 op =3D BPF_OP(insn->code);
> > +	bool mode_mem;
> > +
> > +	/* subregister endiness swap */
> > +	if ((class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) && op =3D=3D BPF=
_END && insn->imm !=3D 64)
> > +		return false;
> > +
> > +	/* w0 +=3D 1 */
> > +	if (class =3D=3D BPF_ALU && op !=3D BPF_END)
> > +		return false;
> > +
> > +	/* cast from as(1) to as(0), PTR_TO_ARENA is 32-bit */
> > +	if (insn->code =3D=3D (BPF_ALU64 | BPF_MOV | BPF_X) &&
> > +	=C2=A0=C2=A0=C2=A0 insn->off =3D=3D BPF_ADDR_SPACE_CAST && insn->imm =
=3D=3D 1)
> > +		return false;
>=20
> [Severity: Critical]
> Does this logic miss identifying BPF_ADDR_SPACE_CAST operations with
> imm =3D=3D 1U << 16 as 32-bit?
>=20
> If the arena has BPF_F_NO_USER_CONV set, bpf_do_misc_fixups() rewrites
> all BPF_ADDR_SPACE_CAST instructions (including imm =3D=3D 1U << 16) into
> a 32-bit MOV to explicitly clear the upper 32 bits.

I think this is a pre-existing bug.
I'll add a test.

...

> > +/*
> > + * Return the 32-bit subregister defined by INSN, or -1 if INSN does n=
ot
> > + * explicitly define a 32-bit value.
> > + */
> > +int bpf_insn_def32(struct bpf_insn *insn)
> > +{
> > +	int dst_reg =3D insn_def_regno(insn);
> > +
> > +	if (dst_reg < 0 || bpf_is_reg64(insn))
> > +		return -1;
>=20
> [Severity: Critical]
> Would this unconditional behavior inadvertently overwrite manual override=
s
> for PTR_TO_ARENA arithmetic?

No it won't.
convert_ctx_access() downgrades those operations to BPF_ALU.
There is also a test to check this.

...
