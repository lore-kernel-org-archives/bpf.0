Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3203A1E8C
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098060; cv=none; b=cckbhPFtkgS2fKtfHIxyc/qc1AleCfi+Q7FbZXadAnCOGlk7trB/KGPJrm0WExF9EKh5yTk5VZ7w3n2Q+RydIg6y8f1B9GWzp6qw9587W2D2f+liNHcdkTQtgX7DIIhy8VufGocMnKlMrG74F0eN2zWg8YQSBwQuYJgKZThn3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098060; c=relaxed/simple;
	bh=PwgRgVpBuVb7D8j1gOFR2F9/esWCr6jV0RE4ftKLmcs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQFGE9WWNYcsOBVrYJzDTLD0LQy0/6ydVNeadtEluFCtro14G/LWGqA0TFpLlbAIxPVWt1IEuktKpFU6gnw1meWWGh9vwVApuZ9YbEcBAYnUraTVV37G/+dOmhtG8rojhuzjVwntqyKvCBClQeitdhidDiI29Mila07b15rLAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt6ZcsPj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt6ZcsPj"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3562e98d533so325724a91.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098047; x=1772702847; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lLFLi9l2Hdvi7pm+JcOZ/2x84nitwjcy+NplJLwNZlA=;
        b=Gt6ZcsPjOqyjvV9kSj1TacZqMKk0STs+K/B1atrG8y1djMqDyXMEai+SXRon5LKKuW
         Xe5bkz6vTI6YKHVeWih9Lw4dwisEeyo59294I/CZj7dbekFsevV0bjtnAjCwWO4IMEz1
         nFZ4+ltlldL/AHUWaOjvhwYNLZPfr8R30WnEb+mVBPnqYAiStZaUYQrbaoR4Z7hZMV48
         +FtiL8Qib5PKGU6QNVaN8xVXChHBL+MUl2EIeolF4qMTq7I7py9e3U05QWNzNYGc8xbi
         mTjyMkr1zz7AslMByRLs8KOKKegKYqEXnr+k7x6evVsGIHspIxuNWjBqe19mxkLkt2Hh
         bxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098047; x=1772702847;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLFLi9l2Hdvi7pm+JcOZ/2x84nitwjcy+NplJLwNZlA=;
        b=qyYuAeOnhiDf8bpYtCloyOijW9WMhLS+zSpidhC++5eJZ1LV8+IXL7WbkcG8/+Ou5Y
         egIgGrVKegyJw7qKu1gRDG63Y62idxqGbBIvTHmX3zXQJewsmYriKkQRu2st97T0MtSP
         3/kOxIs7eNszzbQiRJdCyQkTilGFaQ6I2pnYWmMro1bvc25UcVZVO/re85IDGdMppfvg
         b6XpTvpYDre1tr3SNHKIi+6PU3SNhcMA6UN9ArDTnIx5n/L6FE5S0Dr+P57DxspNCgeH
         PgumfoVAVNbZV7k7nCD0GlLJn/aW9+GNZbQrbd9cWyFvacHr2AD+5xb++GVQoTJxFt4E
         UZMQ==
X-Gm-Message-State: AOJu0YzlRgzNJQ0Hgp+NE3iMdeWEsAH5rakhchYr0CRD3NcGIaWnoCo/
	6MjLSJ7xCJGH2FZYZPyRKvGN1zWXM1Tj3zxePSFJTknoFnsBPxAsTthg
X-Gm-Gg: ATEYQzzZQlEWBclVsSmzdNx7IBaRRqdePGuFY3pKrfqO61MIZ0BofPFwj+dgr7nKmFr
	GTds+353iQ6TW2SPO7V9wIunQZljnqCvPJBRSWr+YYagmoLXjDkIbIP9XsNkdwgI21mTKBkklMs
	Fkx4CHaiJc9Y8ai+5EEmV3dklNuflf8peP1jLO1xYC8d1JwzIRTa32o4eff6z9WbY2Eg1I1TA+o
	sD2CNc08ykS/qvkaJVtWERnx7iZvATTF520yr++ckKQ5JyKpm/7XsjptC/S816fDK3P3qHPmQ+7
	wAuyzy2ldQg606zti4luiCVHF3KuIh0+oxvD8pR9iTQKPUfHbKpDKd0EFCKyT4WRq1sCqRBZrP3
	tItcYGP5vEObP3c1/ij2toaH12P1UoMrSvpDk0n2kwDOzQqA3oEqc2TSPpBkNoTRfZRrlNO1keW
	cl+NA1AEqKVMSFwfITtpxotP7RS6zPs/SEx/b78YQqhKfX1KiFWZxF+NlJ+0TsEg==
X-Received: by 2002:a17:90b:498f:b0:354:a76e:7f08 with SMTP id 98e67ed59e1d1-358ae6a4304mr15860770a91.0.1772098046951;
        Thu, 26 Feb 2026 01:27:26 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fe1040sm1841971a91.4.2026.02.26.01.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:27:26 -0800 (PST)
Message-ID: <da102d447848a34cf13b2f490eded8d6afa056aa.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 3/4] selftests/bpf: Test refinement of
 single-value tnum
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Srinivas
 Narayana <srinivas.narayana@rutgers.edu>,  Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 26 Feb 2026 01:27:23 -0800
In-Reply-To: <aZ7NOlhsG5RZIhIl@Tunnel>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
	 <1bd78db44bef27d9d7fb549ed3eb8811ee2a5e5e.1771594636.git.paul.chaignon@gmail.com>
	 <c0ed78441523309a84ac93e962d73f202337fbb4.camel@gmail.com>
	 <aZ7NOlhsG5RZIhIl@Tunnel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-25 at 11:21 +0100, Paul Chaignon wrote:
> On Fri, Feb 20, 2026 at 04:20:55PM -0800, Eduard Zingerman wrote:
> > On Fri, 2026-02-20 at 14:57 +0100, Paul Chaignon wrote:
> > > This patch introduces selftests to cover the new bounds refinement
> > > logic introduced in the previous patch. Without the previous patch,
> > > the first two tests fail because of the invariant violation they
> > > trigger. The last test fails because the R10 access is not detected a=
s
> > > dead code. In addition, all tests fail because of R0 having a
> > > non-constant value in the verifier logs.
> > >=20
> > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > ---
> >=20
> > Hi Paul,
>=20
> Hi Eduard,
>=20
> Sorry for the late answer, I've been travelling.
>=20
> >=20
> > I have a few nitpicks, sorry for not commenting about it in v1.
>=20
> No worries. The AI bot also found a new small thing :')
>=20
> I noticed you haven't acked the first patch. I think it's a bit thougher
> to follow, so is there anything we could do to ease review?

It made sense on the first pass, comments help.
Let me re-read it tomorrow, but I assume this patch works.

> >=20
> > > =C2=A0.../selftests/bpf/progs/verifier_bounds.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 91 +++++++++++++++++++
> > > =C2=A01 file changed, 91 insertions(+)
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > > b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > > index 560531404bce..41dd249faadd 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > > @@ -1863,4 +1863,95 @@ l1_%=3D:	r0 =3D 1;				\
> > > =C2=A0	: __clobber_all);
> > > =C2=A0}
> > >=20
> > > +/* This test covers the bounds deduction when the u64 range and the =
tnum
> > > + * overlap only at umax. After instruction 3, the ranges look as fol=
lows:
> > > + *
> > > + * 0=C2=A0=C2=A0=C2=A0 umin=3D0xe01=C2=A0=C2=A0=C2=A0=C2=A0 umax=3D0=
xf00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U64_MAX
> > > + * |=C2=A0=C2=A0=C2=A0 [xxxxxxxxxxxxxx]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > + * |----------------------------|------------------------------|
> > > + * |=C2=A0=C2=A0 x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | tnum values
> > > + *
> > > + * The verifier can therefore deduce that the R0=3D0xf00=3D3840.
> > > + */
> > > +SEC("socket")
> > > +__description("bounds refinement with single-value tnum on umax")
> > > +__msg("3: (15) if r0 =3D=3D 0xe00 {{.*}} R0=3D3840")
> > > +__success __log_level(2)
> > > +__flag(BPF_F_TEST_REG_INVARIANTS)
> > > +__naked void bounds_refinement_tnum_umax(void *ctx)
> > > +{
> > > +	asm volatile("			\
> > > +	call %[bpf_get_prandom_u32];	\
> > > +	r0 |=3D 0xe00;			\
> > > +	r0 &=3D 0xf00;			\
> > > +	if r0 =3D=3D 0xe00 goto +2;		\
> > > +	if r0 =3D=3D 0xf00 goto +1;		\
> > > +	r0 =3D 0;				\
> >=20
> > Nit: make this `r10 =3D 0;`, just like in the last test?
> > =C2=A0=C2=A0=C2=A0=C2=A0 (and in the next test).
> >=20
> > Also, the test works the same if I replace 0xe00 -> 0xe, 0xf00 -> 0xf.
> > Maybe pick the smaller constants to ease the readability?
>=20
> If we switch to 0xe and 0xf, the test won't validate the changes
> anymore: it will pass regardless of the second patch. That's because
> the range would only contain two values. We can however change it to
> 0xe0 and 0xf0.

You mean that min/max logic for 'r0 =3D=3D 0xe' will adjust the range, righ=
t?
Makes sense, no changes necessary then.

>=20
> [...]
>=20
> > Also, I think a few more tests are necessary, there are three cases:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (umin_in_tnum && tn=
um_next > reg->umax_value) {=C2=A0 // A
> > 	=C2=A0	...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!umin_in_tn=
um && tnum_next =3D=3D tmax) {=C2=A0=C2=A0=C2=A0 // B
> > 	=C2=A0	...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!umin_in_tn=
um && tnum_next <=3D reg->umax_value && // C
> > 	=C2=A0	...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > If I remove 'umin_in_tnum &&' from A no tests fail.
>=20
> That would be expected. As you pointed out in the v1, this part of the
> condition is not strictly necessary because it should be implied by the
> second part. We ended up adding it just for readability.

Wellp, that's a bit embarrassing, sorry for the noise.

> > If I remove '!umin_in_tnum &&' from B or C test cases
> > 'verifier_bounds/verifier_bounds/bounds check based on reg_off + var_of=
f + insn_off. test{1,2}'
> > fail,
> > but these seem unrelated.
> > Maybe craft a few test cases covering these conditions?
>=20
> Ack. I'll include the two cases I mentioned when discussing this in the
> v1.
>=20
> Thanks for the review!
