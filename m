Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B43E5580
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051624; cv=none; b=FbXziKaUxEStczDP78FJM6qYwCAIV28z0Z7cmbVz9fTSzIkkHyoP2kbNsKMx0WandioSUiAtFLzcZgRRjfh6xKvLJmosrtiKHMya+gWdIVhUGIJPzC7t0uGgjBaNAVVPZLVFYT0JDf1GVCdSwOCl4zOcGY3Lg4W5FnpJOsvv+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051624; c=relaxed/simple;
	bh=yE3xqqi2oaa6XNdawWgnr2t0aIvadH3O2U/5ztfLFh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hG+inw8/EaC6V9sSKr/pjaX71v0GMUcmAkaj+ZbteQ07/P900QOKKW0pdk3qUkdTZGLIQVfZJqmK/Te4H0EvbIS2knTzIGphYiKe1nWW/CSVtlPoyT1bI3AYXSnhG6ArLj0QPH5RJL+c71IhlkPl3DM9Z+0e3ONXxSu+3cHnvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhWWRwcc; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhWWRwcc"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2e221a71e19so7961744eec.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 10:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777051616; x=1777656416; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1fueO2cqnBtFRoG5wCc3EfIWMf69NZKu7l1aHZyeTw=;
        b=fhWWRwccsxzD9jZ0tdBQXkJyS/muwfoVSvCorpx6j5GlWGEDMsiN0NoZPwL0EDupTe
         FaVIfsTn8Q3ipsxKy7W6oX/boI8tgsw0jlvBEAYGzy7nUBhpf8lbn2evtZ/yuT3zLTaF
         QvulIESvOLiWNFWqagwYvSFoAyTEIfh34Mw6v6IacStWc5OaMB6XybHqcM6Lv0kSNkgF
         7yQtlybFB1vgdbhJcESCVn4pHX37ExDAezQrgYGncXb2og92YSpYz1evwz8v90i6qCBO
         P/gVnd2SD/8aXjxLfeXn3pnkl2+BLD41REujfUT27vVPsFzJKUlHkR3ws9UcpJ51R6Vo
         EcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777051616; x=1777656416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1fueO2cqnBtFRoG5wCc3EfIWMf69NZKu7l1aHZyeTw=;
        b=Lyb/vfjno4Hsz+jvZJe/9fTpUxUpQ8Hje+aWqhyP1nSJ5FP3sv4AdOYKnHJPkWb+SW
         Qr5VtCqUM1DXyCHpGePrNCS6R0LhBgSDfmCK8D83IpKVtCDn50JpwuR9ckY0jdKDwH8M
         d46kEhz2Ftla0oHuS2Dq2K47AMgpPOcUcXvJfpHUQsuShSZGaDUcjSzSJoBqZOt2xyee
         PIdLRmAkuUcbuInUZDYasEW74a4Q/nPRfwt/+MLx+hrGIQZTwGkowoOjDNuQ8IadluN3
         OTEEvCtxywpb+fAg8wvx872pa4eEMNQbkBR2hRcgNPsPkOq7iBVcDw2WY+tVl3o3BOmc
         QG9w==
X-Forwarded-Encrypted: i=1; AFNElJ+oIrdB5PL50IcIhzd+5PllBXqhhwKBjQZ2/0GJmGvl/Yvj9Sjr/PpUEs+cacEBR4YWs6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/tRRk2KBK+8zE48zPiIIZS+pAO1Un/4qbDPUZXx2Bh914X8B
	ovwu+PgiXctRGReLqWmFJEXT8kql48hPvryICPSJWFgpUxKaDFD7hG9U
X-Gm-Gg: AeBDieuFRF567FxZxp6EdRCGv71+2AmF+/m+imJKPpDvmUS/S0R7rU4VxBoX/v+U6D9
	YRZuYsRWxK7Uqxn8B031EYnl+mmbiismIuem6PKOOUHmLPgwh483MqYSEgC1r3MStN3o9AcUOaq
	aGSnVgZEdb9u2ZD0DjGVAh8M36loYYPkK5nmfw3GTZLAZNitt4gHs2H647LHz9oMvQO7icev4SI
	cru0fgmzyemNn17RWhiRM5On5m7wBudg955szQyMztGl09FN9q+deEhwHzi3YdhKW5sKYrejWDy
	X+GIAxI1o08vx1IfyIxEj64/Bqn5lD3F6l7mwLI5A8OQC3WdkjBZnxJvRe7aV5jzLDvsjA2EUG3
	DEZOPNgMAzseMcHFNqBWb8kzohpEJA2p0fYbM+3iQbVtDXEX9Kj1KBvyRASKHLFT2OLgalL6rT1
	5G4zdpn+8rdl6AePOnRUGGp5iVOozVDDS9RbZzLEYaruW075vue7QTaz4Y1Kj9LzzksitbZNs4g
	B3koO9JDIvOiqOVUk+X
X-Received: by 2002:a05:693c:2b15:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-2e47a1027d4mr19728746eec.21.1777051616030;
        Fri, 24 Apr 2026 10:26:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:92a1:14f3:18de:3c64? ([2620:10d:c090:500::1:b6b2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e79c2954f6sm35771061eec.30.2026.04.24.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:26:55 -0700 (PDT)
Message-ID: <5d22e4ce0cca7860ccd42db8c221064d58964bd4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: representation and basic
 operations on circular numbers
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, shung-hsi.yu@suse.com, 
	paul.chaignon@gmail.com, harishankar.vishwanathan@gmail.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 10:26:53 -0700
In-Reply-To: <a42da1d14e01371ec3a05d5e1d43067428195d983703523e373497834bb70796@mail.kernel.org>
References: <20260424-cnums-everywhere-rfc-v1-v2-1-57091924c9d7@gmail.com>
	 <a42da1d14e01371ec3a05d5e1d43067428195d983703523e373497834bb70796@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 09:00 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
> > new file mode 100644
> > index 000000000000..86142cb2aee5
> > --- /dev/null
> > +++ b/kernel/bpf/cnum.c
>=20
> [ ... ]
>=20
> > @@ -0,0 +1,120 @@
>=20
> [ ... ]
>=20
> > +/*
> > + * Suppose 'a' and 'b' are laid out as follows:
> > + *
> > + *                                                          64-bit num=
ber axis --->
> > + *
> > + * N*2^32                   (N+1)*2^32                (N+2)*2^32      =
          (N+3)*2^32
> > + * ||------|---|=3D=3D=3D=3D=3D|-------||----------|=3D=3D=3D=3D=3D|--=
-----||----------|=3D=3D=3D=3D=3D|----|--||
> > + *         |   |< b >|                   |< b >|                   |< =
b >|    |
> > + *         |   |                                                      =
   |    |
> > + *         |<--+--------------------------- a ------------------------=
---+--->|
> > + *             |                                                      =
   |
> > + *             |<-------------------------- t ------------------------=
-->|
> > + *
> > + * In such a case it is possible to infer a more tight representation =
t
> > + * such that =E2=88=80 v =E2=88=88 a, (u32)v =E2=88=88 b: v =E2=88=88 =
t.
>=20
> The commit message describes this specification as "=E2=88=80 v =E2=88=88=
 a, (u32)v =E2=88=88 b:
> v =E2=88=88 t." This typo was identified by the CI bot and you acknowledg=
ed it
> in v1 review, and the code comment was fixed to use "(u32)v" correctly.
> However, the commit message still shows "(u32)v" instead of the
> incorrect "(u32)a" from v1. Is this inconsistency intentional, or should
> the commit message match the corrected specification?
>=20
> Note: The CI bot pointed out that "(u32)a =E2=88=88 b" doesn't depend on =
v,
> making the quantifier trivial. You agreed and the code was fixed, but the
> description in the commit message appears to already have the correct
> version.

This appears to be a word salad.
Both comment and commit message say: =E2=88=80 v =E2=88=88 a, (u32)v =E2=88=
=88 b: v =E2=88=88 t.

> > + */
> > +struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b=
)
>=20
> [ ... ]
>=20
> > diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> > new file mode 100644
> > index 000000000000..1aa0554bf19f
> > --- /dev/null
> > +++ b/kernel/bpf/cnum_defs.h
>=20
> [ ... ]
>=20
> > @@ -0,0 +1,233 @@
>=20
> [ ... ]
>=20
> > +/*
> > + * If there exists a cnum representing an intersection of cnums 'a' an=
d 'b',
> > + * returns this intersection in 'out' and returns true.
> > + * If such cnum does not exist:
> > + * - if intersection is empty, returns false.
> > + * - if intersection produces two ranges, returns smaller of
> > + *   'a' or 'b' in 'out'.
> > + */
> > +struct cnum_t FN(intersect)(struct cnum_t a, struct cnum_t b)
>=20
> Does this comment match the actual function signature? The comment
> describes returning "this intersection in 'out' and returns true" and
> "returns false" for empty intersection, which suggests an output paramete=
r
> 'out' and a bool return type. However, the function signature shows
> (struct cnum_t a, struct cnum_t b) with no 'out' parameter, and returns
> struct cnum_t by value. Should the comment be updated to describe the
> actual return convention where the intersection cnum is returned directly=
,
> EMPTY is returned for empty intersection, and the smaller range is return=
ed
> when the intersection produces two disjoint arcs?

The comment has to be fixed.
