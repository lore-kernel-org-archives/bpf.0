Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099F1E5B7A
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771550963; cv=none; b=QwjrEUy7vmS2LVWk1u1aR+Dd5EOeubb37j5ilVqE7jT/Ve5Rj4Bb7ADMgtQxgumRbV0o90VqhHau/sr9HBVP4pUSH2mUmx9tfdjqC+Ovs+9w2uWioMRZvfQhDHlcjeyAKvZ8D7wT6H+7517jrzVS0ehoUHwexPy5dVsuCi+RtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771550963; c=relaxed/simple;
	bh=IbY/oQ621o/cWvg1s9HGNVxbXfODWXbvzFNpzy2PkpU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmLaf7hfZ+WbOSyc7+AYO6KbPWGGxLjtQANiqrdRzp1P9kfs10aZ75S9k9aHdgsdHysyYsV3TUsqzJR4HVNGsn6LXn8RoX2icDFxOPF+/KDQRnAoP+pfkShCQXRlcHYnK29ZK5kXgsv0YZoX+QzOQUvjtBo3iXoZPcIv7OgLDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB8D/3dQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB8D/3dQ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so801094a91.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771550962; x=1772155762; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LK55KW6nvdDoUkgeO/XCLk9QNEnyqBleKMeXNXa/jfo=;
        b=XB8D/3dQbxNHzQd1c2GpIPG/wXVOZY1SlpfmGq4S9+MIhes+iLOtKglYf1eoubNL3V
         IXA7Th0OQ6OlS+cYuINOuc2NxDUQs14NNWJOrtL7/5aKS5HjsbPaZShZvKIudCkdMpAf
         XRjukPLmujGMDZaPz1e5dZvLU212ZW7ArhLRd28UX287ws4h8wLfTYok6ywg2qMFB2Sh
         wjlF49ouxWrQcm+J6vllG1aCUMUPg0N5jgymXIMkwfbCsRWYTULC5FNMwHWtHy3gtlQA
         F9nUnNE//r2mUIbnXSsbrJ29FnM2XvIbgb6hIR2DRgAFNjLMx3kY85y8KAWqH/ZIYeT/
         +/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771550962; x=1772155762;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LK55KW6nvdDoUkgeO/XCLk9QNEnyqBleKMeXNXa/jfo=;
        b=gdB8P7bR92sqqfsIG04fA1gThgVh0Xa0rUtyF81Wi9XFqFBJgv5O4qoWoZGrMKC6Ez
         ip8qDT6/0HLjX2NJ4NiGsryJrD3FVGsprP2pT4mmwvy4sZdGQay/H0inX0R6U6oB7QMk
         Urv1iK4W85ZkjEWKFkkjvaE5zRdQkYNFV2smHsPlKpIjvOYtpW7/JXxaXXg/fkQkWwYe
         qC1OvHcYfvkI9BurdnM0Mr0d871LYDCIUio6q031nMUKCvgElK9ijlTSUk8rISUMQ/xa
         y41ChtncATgvtPTkGIgylJJL2wJQ00/qmj/vgG5ZwCP3HGJoB/smIzJyPlIoZnJKI+5A
         uJAA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Y80Y3aIZn7ihhqzobeFW2JmU8V6yJR5uucAXBL2DRuVUtNMC5fuW6/HfgeMYaYZa0IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVEUiQ7WQ+TZ/yKiM1zH/CUsVX8yjtneKZB/8QgVSYRXMQMMis
	ZE/VBLASW7n9fCcFGU3GEPQYABznttKM+YkN21J1PjARIYgMQ3CEsabzzEhPnw5e
X-Gm-Gg: AZuq6aLFfb4mU57VCEnqaHNjykur7NFTHseUUBwk+dl7Xs5e2tnXiQ+RcCHu3vt8Q8V
	6Sf3atWrcowNeXCJuFFxtPpWN86CKRSY1RoP1RM4Ct3bBdtsYKxMVaI0b//nhILZ9hQn3PyLKdU
	vjxTav0as12hHoEkpevFrQ2H+DyLzWv9Rl0X8d8XWwEJ8ZnR1OaV26WSYKtEW7vlys53e57ruzM
	ro3AJc8+actA0rwmrfwHFmRsg0jRKt8NKfLYKohKWxvnRUrNroC0ZDEb+bEZ19K5Eu9jakwydUe
	6Vjxji+Dj2Qg0WlI5aK5sfa+id1qN1D4Y/vvxy/+RVzwk+zwbiYuNDhF2MoeKa1brYtXtgIL7sw
	miIPiNs/qJlI6rSZ1l0pJpeOnwhvi6dHVGgmIsmUubdEZw9FnDBHx20TIB70kOcsqnpHVgyAKoE
	5f95sfq9rNL2ShemkMgSvKi+obw6xbRGzd+6hjP4qVPehBh43B9dg=
X-Received: by 2002:a17:90b:4b05:b0:354:c3a4:3a2 with SMTP id 98e67ed59e1d1-3588916d1c6mr5883767a91.29.1771550961426;
        Thu, 19 Feb 2026 17:29:21 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3589d811f3fsm1215894a91.8.2026.02.19.17.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:29:21 -0800 (PST)
Message-ID: <7b696c92e56dc560154818484cb35def2639cbf2.camel@gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Srinivas
 Narayana	 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte	
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 19 Feb 2026 17:29:18 -0800
In-Reply-To: <aZenQb3H5g73Bhz9@mail.gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
	 <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
	 <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
	 <CAM=Ch06Vg-faG9ukU4DAsF9FRG2PeUtYHh3BkG0dOzYi=WDCyg@mail.gmail.com>
	 <5044b1d83c3c916c0754eb5556008316c36c15ae.camel@gmail.com>
	 <aZdcoaH9ERUNpln1@mail.gmail.com> <aZenQb3H5g73Bhz9@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 01:13 +0100, Paul Chaignon wrote:
> On Thu, Feb 19, 2026 at 07:55:33PM +0100, Paul Chaignon wrote:
> > On Thu, Feb 19, 2026 at 10:32:19AM -0800, Eduard Zingerman wrote:
> > > On Wed, 2026-02-18 at 01:06 -0500, Harishankar Vishwanathan wrote:
> > > > On Tue, Feb 17, 2026 at 5:58=E2=80=AFPM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> > > > [...]
> > > > > > 1. The u64 range and the tnum only overlap in umin.
> > > > > > =C2=A0=C2=A0 u64:=C2=A0 ---[xxxxxx]-----
> > > > > > =C2=A0=C2=A0 tnum: --xx----------x-
> > > > > I think this hunk should be rewritten as follows:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tnum_next =3D tnum_ste=
p(reg->var_off, reg->umin_value);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tnum_max =3D reg->var_=
off.value | reg->var_off.mask;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tnum_min =3D reg->var_=
off.value;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tnum_next > reg->u=
max_value) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The only overlap is umin */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___mark_reg_known(reg, tnum_min);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (tnum_min < =
reg->umin_value && tnum_next =3D=3D tnum_max) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The only overlap is tmax */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___mark_reg_known(reg, tnum_next);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (tnum_next <=
=3D reg->umax_value &&
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tnum_step(reg->var_off, tnum_=
next) > reg->umax_value) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___mark_reg_known(reg, tnum_next);
>=20
> Actually, that last condition is not enough. In the original patch we
> also would check that umin is not part of the tnum. That's needed for
> example if we have R3=3D(u64=3D[0; 1], var_off=3Dunknown) (a case possibl=
e
> because __update_reg_bounds is the first refinement step in
> reg_bounds_sync). With those values, we would match the third condition
> and set R3=3D1.
>=20
> Checking that tmin < reg->umin_value in the third condition would also
> not work. For example R3=3D(u64=3D[0xffff; 0x10000], var_off=3D(0; 0x1fff=
f))
> would be incorrectly simplified to R3=3D0x10000 because tmin=3D0,
> umin=3D0xffff.
>=20
> What we really want is to check that umin is not already part of the
> tnum, as in the original patch. I think we can however improve
> readability as you did. Here's what I have in mind:
>=20
> =C2=A0=C2=A0=C2=A0 tnum_next =3D tnum_step(reg->var_off, reg->umin_value)=
;
> =C2=A0=C2=A0=C2=A0 umin_in_tnum =3D (reg->umin_value & ~reg->var_off.mask=
) =3D=3D reg->var_off.value;
> =C2=A0=C2=A0=C2=A0 tmax =3D reg->var_off.value | reg->var_off.mask;
> =C2=A0=C2=A0=C2=A0 if (tnum_next > reg->umax_value) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The u64 range and the tnum =
only overlap in umin.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * u64:=C2=A0 ---[xxxxxx]=
-----
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * tnum: --xx----------x-
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */        ^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___mark_reg_known(reg, reg->um=
in_value);
> =C2=A0=C2=A0=C2=A0 } else if (!umin_in_tnum && tnum_next =3D=3D tmax) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The u64 range and the tnum =
only overlap in the maximum value
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * represented by the tnu=
m, called tmax.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * u64:=C2=A0 ---[xxxxxx]=
-----
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * tnum: xx-----x--------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___mark_reg_known(reg, tmax);
> =C2=A0=C2=A0=C2=A0 } else if (!umin_in_tnum && tnum_next <=3D reg->umax_v=
alue &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tnum_step(reg->var_off, tnum_next) >=
 reg->umax_value) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The u64 range and the tnum =
only overlap once in between umin
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (excluded) and umax.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * u64:=C2=A0 ---[xxxxxx]=
-----
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * tnum: xx----x-------x-
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___mark_reg_known(reg, tnum_ne=
xt);
> =C2=A0=C2=A0=C2=A0 }
>=20
> Wdyt?

This makes sense, I missed this nuance in the original patch.
Maybe keep the first check as 'umin_in_tnum && tnum_next > reg->umax_value'=
,
then?
