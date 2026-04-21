Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EC2E1F0E
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792043; cv=none; b=WOPusfiladT5EVvkT1o0we4VUCkaHRhYS+0cvSc7Hay60hTMCXKaQgjx3TZSovhHy9xPBmhwTVu+7Y9UTiHfeAzdr+Hgpv/zji3H5IN0PiNWdt3Mu+PEFwebz41JBnKaA2/qgYlrmgyw+oXdiRODtOSy0WrsC3phxmNIGYnE7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792043; c=relaxed/simple;
	bh=ChHJjf/H9l1fqjeiH5duw1rSGWPaRjS96Fl1lFz9dV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dscED6JkB6TuQCaoUrn8MwsY9n5a6G7laVKlOYOyW5m0N+GZ1wVJmlmi/+Q5innrWdm8TMHr24n2ER0PzthBr2iXrZsPlHjIHR94OHh7iNnQN38S7ZtruYwyzi0Ii5gqQJDFRRYXOibhIdulLPMqWY1BwSjat0IDfc7VRyqMSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaNFrkh7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaNFrkh7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2429f98d0so25788805ad.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792042; x=1777396842; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QyQmmWvtf/qNxQSax/Qi3IXbkQGJLIZj4V3/4U0Cr3E=;
        b=HaNFrkh7EF7z0S6M5zvivCFO4H4mbDj1tCxBR3cwJQXk+We624TUMcbztuFZ1bc/Oy
         3Yjz0fwWvX7j6uoZ/1jvEUfa+9eFq/JVO0Nk7Fsba3d9FTKz5p/NPODVMh1Hm4is9akv
         wtIJQq0+GMEZtZ/wI3Vu4R+HvQw06T+uTl17LzxM75Ug3/6uXc2t0pTtvuMM0XimUCZE
         MmW4XxwwSeSjrOyz4V0h3fcbKB+K0+dXRZyRgqV4v4wXO9HxzoBNKoJ0mYQVBhgRaHyz
         yl2WT2Ti88ndX66Ntb91vP+xhcF07m4Q3mpCfbUW2heZF5xeL5WxAQIYqkYsqG0/jVcm
         XCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792042; x=1777396842;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyQmmWvtf/qNxQSax/Qi3IXbkQGJLIZj4V3/4U0Cr3E=;
        b=OOYmZTgcP0DRvcJkIksNI+PYY6rlRXh5K7eVAP/TDkxIRcXA5f0N8J0WZj2ozb/gmI
         asgQkeA+gXbauvC14ZhUrP3q2yuPtNrfY/xjyMUvI1qpBMgN6u5nHbZV9gQeIQE8adlR
         PcXEGx7tRkqnzo2ivOC0LZ/Gg6gkOsjgUfm7/nZSAgk2xd7UYiDP0Z1AYRg1ltu5WO+p
         obECy+vZlU1ZcAjjqDGwY7OKpjybRXT+QcS4hwe2Dd02a09LQZRS8a6mAjSK8cnPhhVA
         Y4mEcN6p2cy0VdHvFXIwkOywzRdfFyzQV22DXpsDPF6fpsEoWPkFatvtDvFxbHEsct7D
         RpeA==
X-Forwarded-Encrypted: i=1; AFNElJ9ekoCQKfT75QG7AhbjEA6A4vNEoeui++vXVS7nwUMLg6IBOSJDc1EPDTT7Ch5fSq7u7qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytxtAIv11Ng3s9gghmLWok7l4PykGo/MnSLh8nqPMQEdaCnouO
	44Ukj9I4UlYcMVANzmIpqEedfWhyox3QS1hPkyFzhOzERCefcZQcM4/y
X-Gm-Gg: AeBDietC1Ks+tUKUMaB+1eCu1btDAQEw5h1RhsuXC2OIXnRcVF5HV5ncljoyKR9xCls
	fS0gITpVcGVxF8ULoXUvmPosrD8IMkesFimQgOW9rM5NVyW8VeINRirVE4h0mM3f40vheNvD+be
	jURJgswFI8EMu9kTm8eJmRawF1gtBFbS0ECOQW7bq0IAz7/r/stUAys5ad4C/NseGEoU9rvXJ7g
	vOggeH3Vgr686sw6k7gisUoA5aSGS34801JBWRtNaZfeG4grrxCKJ9KJthW+9rVy9RcTvpRKBj9
	0P6TRM8PQxDy48qizMtU1s5ccxp/T/b13cuJgPMAUtfavzuDgKBZwqbdLmkie+k4SgzrstFCERz
	jf05sV53vytmxBsxfj6vP9Yx63xhJ2U+PREoZKUjgfZRrLyx4OWGVGzxoClXOGr0T+BQIbVaEIf
	IA3bYtZAK9o6jCsO3ayGCNxqxBCvdI6PY6/gg8U9iwe5MjjipeXqU1a1GhIAjicrqyIAOsL9KhE
	A==
X-Received: by 2002:a17:903:3e34:b0:2b0:62dd:3a93 with SMTP id d9443c01a7336-2b5f9e771c9mr129542465ad.7.1776792041108;
        Tue, 21 Apr 2026 10:20:41 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa33486sm170463785ad.33.2026.04.21.10.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:20:40 -0700 (PDT)
Message-ID: <b74aadc5d26466a4558bed01e0e1e8a1d9b96ae1.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com, 
	harishankar.vishwanathan@gmail.com
Date: Tue, 21 Apr 2026 10:20:37 -0700
In-Reply-To: <DHZ04PGE9D6Y.356RPW2LMPPIT@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
	 <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
	 <DHYYZHXEVG03.VESM7HY6A8ON@gmail.com>
	 <3b97c3523aa50ac1b5cab89c817dda3e07e22190.camel@gmail.com>
	 <DHZ04PGE9D6Y.356RPW2LMPPIT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 10:16 -0700, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 9:48 AM PDT, Eduard Zingerman wrote:
> > On Tue, 2026-04-21 at 09:23 -0700, Alexei Starovoitov wrote:
> > > On Tue Apr 21, 2026 at 3:28 AM PDT, Eduard Zingerman wrote:
> > > > =20
> > > >  static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
> > > > @@ -14119,7 +13548,6 @@ static void scalar32_min_max_udiv(struct bp=
f_reg_state *dst_reg,
> > > >  			 reg_u32_max(dst_reg) / src_val);
> > > > =20
> > > >  	/* Reset other ranges/tnum to unbounded/unknown. */
> > > > -	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
> > > >  	reset_reg64_and_tnum(dst_reg);
> > > >  }
> > >=20
> > > div/mod don't need special cnum_div ?
> >=20
> > There is an algorithm for that in the paper, but it turned out to be
> > unnecessary for our verification purposes. At-least for the corpora of
> > programs I used for testing. I didn't try the "dumb" multiplication
> > version, expect it to fail for cross sign-domains cases.
> >=20
> > >=20
> > > > @@ -15861,38 +15209,54 @@ static void regs_refine_cond_op(struct bp=
f_reg_state *reg1, struct bpf_reg_state
> > > >  		break;
> > > >  	case BPF_JLE:
> > > >  		if (is_jmp32) {
> > > > -			reg_set_urange32(reg1, reg_u32_min(reg1), min(reg_u32_max(reg1)=
, reg_u32_max(reg2)));
> > > > -			reg_set_urange32(reg2, max(reg_u32_min(reg1), reg_u32_min(reg2)=
), reg_u32_max(reg2));
> > > > +			lo32 =3D cnum32_from_urange(0, reg_u32_max(reg2));
> > > > +			hi32 =3D cnum32_from_urange(reg_u32_min(reg1), U32_MAX);
> > > > +			reg1->r32 =3D cnum32_intersect(reg1->r32, lo32);
> > > > +			reg2->r32 =3D cnum32_intersect(reg2->r32, hi32);
> > > >  		} else {
> > > > -			reg_set_urange64(reg1, reg_umin(reg1), min(reg_umax(reg1), reg_=
umax(reg2)));
> > > > -			reg_set_urange64(reg2, max(reg_umin(reg1), reg_umin(reg2)), reg=
_umax(reg2));
> > > > +			lo =3D cnum64_from_urange(0, reg_umax(reg2));
> > > > +			hi =3D cnum64_from_urange(reg_umin(reg1), U64_MAX);
> > > > +			reg1->r64 =3D cnum64_intersect(reg1->r64, lo);
> > > > +			reg2->r64 =3D cnum64_intersect(reg2->r64, hi);
> > >=20
> > > Maybe a helper like:
> > > cnum64_intersect_with_range(&reg1->r64, 0, reg_umax(reg2));
> > > ?
> > >=20
> > > Also I found only one case:
> > > dst_reg->r64 =3D cnum64_intersect(u, s);
> > >=20
> > > all others dst and src are the same.
> > > So maybe:
> > > cnum64_intersect(&dst_reg->r64, ..);
> > > as a main helper and __cnum64_intersect(r->r64, ...) as a subhelper t=
hat returns cnum?
> >=20
> > Are you concerned about machine code inefficiencies from struct cnum
> > being passed around as a temporary/parameter/return value? Since cnum
> > functions are in a separate compilation unit, I'd guess there won't be
> > much optimization outside LTO builds.
> > Or do you just like the &r->r64 notation more?
>=20
> The latter. Just less verbose and less error prone.
> While looking at the diff I kept comparing both sides of '=3D'.
> Just unnecessary mental overhead.

Funny thing is, I find the explicit '=3D' style easier to read :)
Anyway, can change to &r->r64 if people like it more.
