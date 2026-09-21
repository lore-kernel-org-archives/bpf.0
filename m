Received: from mail-pj2-f19.google.com (mail-pj2-f19.google.com [74.125.227.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221050E582
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017822; cv=none; b=RLjY/qy8w+0TGGZwbt1HOs3EmVliA0MTLpP5YIvVoqXOGvCILvKWpV8W+7dN+6qwllCvsNYp3YrEnYL0tRCpn2ByVJXhJKMU7vu/l2jZjDkSm+642xULkfAkF0rzyfd9r24b3D8EcsBxC4XA3i2RwTr4x44NLTA8Hrr9aYBFci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017822; c=relaxed/simple;
	bh=fLE4kBRgNTrXXygiginl/GXPxW8+G8PbmvTmG7jemJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnAAeqMNzfUsrQg/QtKFLYajEBel+RZPlH/kBKJ6GXrLhCm5Llm192kML6oUfWWrvTXXsQzWbQLczheQ4sGq0G2Wsmw/i9eEG49iPm1LLeRSlcOb8tL6ro5V9hgZEATrzVdnzX6q4HcbSILFDKk/c0you7+kAg/W2P7u3NmVvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSRshtni; arc=none smtp.client-ip=74.125.227.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSRshtni"
Received: by mail-pj2-f19.google.com with SMTP id d9443c01a7336-2db18fe433fso29716195ad.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790017820; x=1790622620; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9GQz6TWkhxOvlxYTvUXGyKqMCgFXGx1b0EjZiCciSS0=;
        b=nSRshtniGviRrXdBvwF+UMm2ClEQCd0Y16dWJaLBAvuvIsgknQ97fLAp+5z9mWoLRL
         +S6GAJBwHBb/flHbslHM/vD5XaphH1t1W2KWJ56mX2xuOq/lZC+ojq5E2LHnSxsAazT7
         x3ijNRVPDPeCPNyfF0QdGQ7NTKwwGIqdFcKqipMHRzXcwCedG2benIy8+f7sj2PaZ7ji
         ePb2leZhMmRVlcwzybSbCIRPRlItMt/hEPG14ijJ1Q2thVIAVR8b1GCpsLxRN9ts3NW2
         QKWYXbBgBgHysv4t3/kGHZ8PTj6ZYPeIUOPNXz8WuqjQifWfTJGE8YihM7DLfhmiDRve
         43+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790017820; x=1790622620;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9GQz6TWkhxOvlxYTvUXGyKqMCgFXGx1b0EjZiCciSS0=;
        b=arfnTw6vA7SKqDcGunXUp12pHslUmvjfXtRLf3u/Az733SyVf3kAeD/DnmnNb649B3
         g7bvIQPsn9oC9Nn8RAeEL56r7+ZrcQG6bE7vswjP8qlqghs+/Wc2Me8Ax5uTDU+lh/Oa
         UWmWBob/A8mJPBL76BAjwcajNvXBFhmKPKd9aujfjegXrpZtBHyTyLlwC4A1ll5jvq75
         mfPgV1WIzxTXJIDRy11nQD7holVQ8/l4AXVoYi/SSRkmklJ2+yftfY/tnA6/8ODOAyj/
         n1dtKjDhYWKWX+64ZIWJppf3SZQEOqOpS5eZ7LRYxWFpXICX+hYxtxAW0miF25T0JNpb
         8uaw==
X-Forwarded-Encrypted: i=1; AKwUvBygTmSl4mG4GxORyQH8450jcHkCah4cwh6Env0Kf5AHBy3bk/WiItfkcB8BJ0PMLwGM5jU=@vger.kernel.org
X-Gm-Message-State: AFuF++ksmmxPhZ9QPKKd3hXcpBlL3dxObCaz8kVNji80W/NUTS5rsy6C
	YFQ2Xm5SZVHdm8GPP1HyR2XKfKWZfdDVf4kWhLFya/mP9XsXmbtue6Tn
X-Gm-Gg: AYBFou24/TPD+ZETEsF5/vox2Z9jgCimX+KE8N+l0PAaOLDrkzQ3BlRY07xdsIRI1Nb
	AzZKPgEBEJ4SdMCstoHasbktZ/AQ/uW9BBvR9Iv7pVBmC5Dtq+8OorNZ700Nc54D/LzuHN0WsZp
	ZBjFOGIqf/6E3qrzJZ+udVCqNKRG+CIt06G7Nna3RU+67tNQgjKJ+7mIa3wmxq39aGkiS0M5iqf
	+cjv2qZl+yRIZgx7/VcwIFGP9LPyqODCBeCpELVW9zBkl36HErQNEnsV6dwXnhVIXLstb1UxfHB
	/gLm3gYK4bZrNOxRzWFRh+eKizJy+It75XNzpM3xunpEKZyOi5G18ekYahsMeO1gayLk+YDn1CJ
	f0TFJWS9BGBzw5mFpAFUnk1hk7upSquBrFQR57tMydvMVWfN/C7KkIj56tGzq5NZIAyFHZqO2QW
	ZQ305DGztn92PMLdKfn6fXy3rLnS6VqDPxMb/bYtWoYSGVwCofx4ZDMc/PpttR1dFAXA1GjXMe9
	IjSCu8pVkt8Bt5yFPnzKjHHOsRI4a+6PqeqKkGrwhE05nfmEME0X/D+mg==
X-Received: by 2002:a17:903:f90:b0:2dd:ad74:6d17 with SMTP id d9443c01a7336-2df5b26afa5mr982235ad.29.1790017820525;
        Mon, 21 Sep 2026 12:10:20 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ec0d55esm46896eec.20.2026.09.21.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:10:20 -0700 (PDT)
Message-ID: <e9aad352ba82dadd97a17867108b5db1865fa38d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality
 across zero-extending movs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Vineet Gupta
	 <vineet.gupta@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John
 Fastabend	 <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf	
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>
Date: Mon, 21 Sep 2026 12:10:17 -0700
In-Reply-To: <DLL84IMPTRQF.3DOQQTN2KCAEW@gmail.com>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
	 <20260910164635.459558-4-vineet.gupta@linux.dev>
	 <DLDKI0ZXYI7H.1XQZZE2RCU7IF@gmail.com>
	 <4ab75099-0e95-4fee-81da-6f4198e3e6a0@linux.dev>
	 <CAADnVQ+N9tzBJ0Bbvp8_8QvR+QcCP4ej5CgV_kRHt=iw4BANSQ@mail.gmail.com>
	 <202c45e2-58ba-4ad5-a234-c90703031f91@linux.dev>
	 <CAADnVQ+Si9Au8J_j2nt+ZzFq6WPaz8hpmh0n=_dFysZmSOeipA@mail.gmail.com>
	 <ff18ccb77a554000a030199e8c1fbb7d8d298e18.camel@gmail.com>
	 <DLL84IMPTRQF.3DOQQTN2KCAEW@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 18:59 +0000, Alexei Starovoitov wrote:
> On Mon Sep 21, 2026 at 5:28 PM UTC, Eduard Zingerman wrote:
> > On Wed, 2026-09-16 at 17:30 -0700, Alexei Starovoitov wrote:
> > > On Wed, Sep 16, 2026 at 5:08=E2=80=AFPM Vineet Gupta <vineet.gupta@li=
nux.dev> wrote:
> > > >=20
> > > > It ended up with full testsuite run parity - after 4 incremental pa=
tches.
> > > > But the pattern of all those patches was adding some predicate /
> > > > special-casing to reg->add_const
> > > >=20
> > > > hunk 1
> > > >=20
> > > > -       if (src_reg->add_const)
> > > > +       if (src_reg->add_const && src_reg->delta)
> > >=20
> > > why? It should not.
> > > My point is that zero is not special.
> > > It should be handled within the current framework.
> > > All these extra hunks are not correct.
> > > ADD_CONST_32 logic should work for delta =3D=3D 0 just like
> > > it works for delta =3D=3D 1.
> >=20
> > After thinking about it some more, I agree that having an orthogonal
> > encoding would be nice. However, it appears that the split should be
> > somewhat different:
> >=20
> >   struct bpf_reg_state {
> >     ...
> >     s32 delta;
> >     u32 id;
> >     enum id_link_kind { full, zext, sext } link_kind;
> >     ...
> >   }
> >=20
> > Where:
> > - id =3D=3D 0 =3D> no id link
> > - full =3D> all 64-bits of the register are identical to
> >           all 64-bits of a scalar value `id' (let's call it X).
> >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D full}, rB{X,full} =3D=
> rA =3D=3D rB
> > - zext =3D> lower 32-bits of the register are identical to
> >           lower 32-bits of a scalar value X,
> >           upper 32-bits of the register are null.
> >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,zext} =3D> r=
A % 32 =3D=3D rB % 32
> > - sext =3D> lower 32-bits of the register are identical to
> >           lower 32-bits of a scalar value X,
> >           upper 32-bits of the register are either 0 or 1,
> >           depending on the bit 31 value.
> >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,sext} =3D> s=
ext(rA % 32) =3D=3D sext(rB % 32)
>=20
> hmm.
> there is also 32-bit link with delta, right?

My point is that delta is independent of 32-bit/64-bit property.
`delta' can be used to propagate in both directions:
- full 64 bit -> 32 bit sign/zero-extened
- 32 bit sign/zero-extened -> full 64-bit

> > The reason for such subdivision is that:
> >=20
> >   (X + delta) % 32 =3D=3D X % 32 + delta % 32 =3D=3D X % 32 + delta iff=
 delta < 2^32
> >=20
> > Meaning that a non-zero delta can still be used to infer the state of
> > the lower 32-bits, e.g.:
> > - if  r1 =3D (X + delta) % 32
> > - and r2 =3D X
> > - and there is a comparison `if r1 < 42 goto ...`
> >=20
> > This comparison adds constraints on lower bits of r1,
> > and it is correct to transfer these constraints to lower bits of r2
> > by subtracting delta from r1 and using lower bits of the result.
>=20
> Not sure what you're arguing about.
> My only point is that 32-bit link with delta makes special
> handling of zext unnecessary.
> I still don't hear a strong reason why it needs to be handled
> outside of 32-bit-link-with-delta.

I'm arguing that the following encoding:
- ADD_CONST_32 (delta is valid, sign extend flag invalid)
- ADD_CONST_64 (delta is valid, sign extend flag invalid)
- sign extend flag (delta is invalid)

I strictly worse.
