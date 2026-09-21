Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B351CF64
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029040; cv=none; b=h1kzlSdaRtzTM+cL1/yNbwoKgytr1ra9KhSqXR2QovuvgatUomXLfD9BYQCzbWwAwjNE3VQEzpH3Bf3yNKGLHV0UAA62TZexBUPdY7BbG859ERrgyYK5UlAbOTDG5zE8MIUPyugE3KAYpbWMRqXMAt8ddMMqa6R5XmNfKiHMPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029040; c=relaxed/simple;
	bh=i+nL9jSpz0eRtAS0Q2BIMZbPF3IYP2ss12701pXlPRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ALcqC7fZiEKJhZRpcNBjUI56MDUVrPgPCwV9amMSHw861ZUxlEacuGQ6IdBh3Ci3kkMZUM7AJXHM/8SWxGl0NrzabF1Bj/lVcF2Amewu+BFHzZZl2r/vy/j+zCYH0CDPJ/nivEhIKLiIT+Ow86SmTb5Kl9+/UKUxXcM8jKYaRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfGBWrrh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfGBWrrh"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso3344601a91.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790029029; x=1790633829; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=46Oxsbf5zuDUQc7C52Kj3PElaB6G7AgxwRfexhKeRrA=;
        b=gfGBWrrhU5uuGuFxNWyuGynNfWPrfyRn5x0YnYf/N8k1886oqpFz03EwjxeK3rSqtD
         WEeWry1jwFvcTdoWBEy0RhPlcntFzD00ingg/6m56zh8i07JKu+sNyj4jmu+uRjmQUBg
         J8ZybOJknIQ5c4bshhNWkXbm/mhVjnAbJeY+vKImVbofXG65Iiy18XRI5jVHkGLDhNoL
         ohk9fiX0zSdY+Q4/gwqVvPTl4A8JN4I9eK9aF3o0hErNXJ6T43h4bi55aRuRejlbCRig
         CC9DX/PXGbjr3jtqHUPzqJnennSAlY/JKPRh1Oicxs5DQuzUDLqahg5kXZA1xwTA6dC/
         btPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790029029; x=1790633829;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46Oxsbf5zuDUQc7C52Kj3PElaB6G7AgxwRfexhKeRrA=;
        b=HDq1G2ESnh8VBSQji9N0u68ngr6w/DXVf+KdjmXmjkEDJE9F1BGa3sQKdI/15mx6vK
         5tifnabGBC004bdlZg6U0dAezqvX8t7hIm7a0S7/y+Wl1Jnc0WY3jmmD8zFCF3E5nat3
         /TOPsX79575t7sSRHTdn+etPUM1vxK6zT5pv8OhNt8aEaYK0RTmPORq1fP15k+mHQheq
         L/FDBXGdzNKY3Pg0Yy9E+sh7QCq0apjw/bzSzvldypcJS9iNBavFzSAb9cmqJjmRfayp
         JRHijj14OMCkvkqsHlHqfR7xytFjlNrfbnUTubdr4zq8UJTj1Vi9jDozv7XFP+r8pL4e
         KeFQ==
X-Forwarded-Encrypted: i=1; AKwUvBw12vqcDSp0Q8nOFFJ3MDujWlOx72OSQ9WFYqq316UzEorn0vFSSjLVdD5+dYHUjwO3YJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++k2cU76P/Z46AaW6nTOZgBFLFiF+XrgK/IbYsfV4zLRZzpcqq4Q
	kBE9v/M9YPh8Dg5QNopQ2cKBht5YwpXii7Lbx65fGRvSvZrLkm0E9wtC
X-Gm-Gg: AYBFou21IKqHOLDqUjNfx7z6XziOXWQSzjBJighVf7BAj7+OpY7OlZu3o8tq3MLtw97
	j9Ny++2PsZQ9x6e8QvmKrg7M268u8l4qXJamyKv86QRCTEdZVWFHUUVG/kr47g7BmeCTj2f1VoY
	LkyYsxZGZQAxy4lqN3GiRVnd1E1G1v+pCWSnA9YGcbV/yM/mcdFDoNI4smaebqeWeSf2F5Lf1pk
	QqMjqO3SORIupNZQHfSbpEpmzjEePE8cMmdfrv+YeBH+aOq/uD+hk1s1TBpqWA+dhJH9NN9i5zy
	xEcMMTvus1D/VQUQVjNzsI1JvgCCkyjggDwXvjNepOzLwhBPCZ59pvLB8UFrNST/ixa+QysfIGe
	1xgNdQe+mWL+PSrB29sA4jCbQ36yRaZEUzI+roh1hWg95bcB5KKGNDtMVrhMhxvFxEaeiC+KLQI
	dXNYUE2ISAHBYr5AJxCG8RLE0A8bvo81ZIcibY7Uwwx+DaD0vZJmGqwoosfJikcNfR7z7tDCM6U
	DQFLUxKrmi16hfhp8wD1rtAx1uImgoV9HxRf1SkLdrpok+aIEcHU/qaWw==
X-Received: by 2002:a17:90b:38cc:b0:3a0:41ad:6b9b with SMTP id 98e67ed59e1d1-3a041ad747dmr5731325a91.34.1790029029157;
        Mon, 21 Sep 2026 15:17:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f0bfc7fdsm571510c88.3.2026.09.21.15.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 15:17:08 -0700 (PDT)
Message-ID: <f4a616cf9241589fd093bbd0b34e8c8a162d579a.camel@gmail.com>
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
Date: Mon, 21 Sep 2026 15:17:06 -0700
In-Reply-To: <DLLBVIU33MLC.ITFPYGMFKWUT@gmail.com>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
	 <20260910164635.459558-4-vineet.gupta@linux.dev>
	 <DLDKI0ZXYI7H.1XQZZE2RCU7IF@gmail.com>
	 <4ab75099-0e95-4fee-81da-6f4198e3e6a0@linux.dev>
	 <CAADnVQ+N9tzBJ0Bbvp8_8QvR+QcCP4ej5CgV_kRHt=iw4BANSQ@mail.gmail.com>
	 <202c45e2-58ba-4ad5-a234-c90703031f91@linux.dev>
	 <CAADnVQ+Si9Au8J_j2nt+ZzFq6WPaz8hpmh0n=_dFysZmSOeipA@mail.gmail.com>
	 <ff18ccb77a554000a030199e8c1fbb7d8d298e18.camel@gmail.com>
	 <DLL84IMPTRQF.3DOQQTN2KCAEW@gmail.com>
	 <e9aad352ba82dadd97a17867108b5db1865fa38d.camel@gmail.com>
	 <DLL8Q69N7BUD.1HI0MKU2M2UGE@gmail.com>
	 <951923920747d8dcba3d56ca8858e106d9c7ba4e.camel@gmail.com>
	 <DLLBVIU33MLC.ITFPYGMFKWUT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 21:55 +0000, Alexei Starovoitov wrote:
> On Mon Sep 21, 2026 at 7:44 PM UTC, Eduard Zingerman wrote:
> > > > > >=20
> > > > > > Where:
> > > > > > - id =3D=3D 0 =3D> no id link
> > > > > > - full =3D> all 64-bits of the register are identical to
> > > > > >           all 64-bits of a scalar value `id' (let's call it X).
> > > > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D full}, rB{X,f=
ull} =3D> rA =3D=3D rB
> > > > > > - zext =3D> lower 32-bits of the register are identical to
> > > > > >           lower 32-bits of a scalar value X,
> > > > > >           upper 32-bits of the register are null.
> > > > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,zext=
} =3D> rA % 32 =3D=3D rB % 32
> > > > > > - sext =3D> lower 32-bits of the register are identical to
> > > > > >           lower 32-bits of a scalar value X,
> > > > > >           upper 32-bits of the register are either 0 or 1,
> > > > > >           depending on the bit 31 value.
> > > > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,sext=
} =3D> sext(rA % 32) =3D=3D sext(rB % 32)
> > > > >=20
> > > > > hmm.
> > > > > there is also 32-bit link with delta, right?
> > > >=20
> > > > My point is that delta is independent of 32-bit/64-bit property.
> > > > `delta' can be used to propagate in both directions:
> > > > - full 64 bit -> 32 bit sign/zero-extened
> > > > - 32 bit sign/zero-extened -> full 64-bit
> > >=20
> > > both? how ?
> > > I was under impression that in 32-bit domain delta is one way.
> > > rX =3D ...
> > > wY =3D wX
> > > wY +=3D 5
> > >=20
> > > if wY =3D=3D 10
> > > We cannot do -5 to rX
> >=20
> > Why?
> > It is still valid to transfer r32 and tnum_subreg knowledge from wY to =
rX.
> >=20
> >   wY + 5 =3D=3D rX % 32 + 5 =3D> hence rX % 32 knowledge can be recover=
ed.
> >=20
> > If rX itself had some delta, e.g.:
> >=20
> >   rX =3D ...
> >   rX +=3D 7
> >   wY =3D wX
> >   wY +=3D 5
> >=20
> > Then it would still be possible:
> >=20
> >   wY + 5 =3D=3D (rX - 7) % 32 + 5 =3D rX % 32 - 2.
> >=20
> > Again, in case of this direction, only lower 32-bits of the 'full'
> > register can be inferred.
>=20
> Ok, so we're argeeing that it's not 'full' in your above definition.
> Your enum id_link_kind needs a 4th category : apply-delta-to-lower-32bit-=
...
> and it's not bi-directional.

It's not really a category, it's just a direction in a sync function:
- if known_reg is 'full' -> sync to sext/zext register recovers lower
  32-bits and infers upper
- if known_reg is sext/zext -> sync to 'full' register recovers only
  lower 32-bits and keeps upper untouched (counting on cross-domain
  bounds sync logic).
- 'full' -> 'full' and 'sext/zext' -> 'sext/zext' syncs are trivial.

> rX =3D ...
> wY =3D wX
> wY +=3D 5
> if wY =3D=3D 10
> here can apply -5 to lower 32-bit of rX only.
>=20
> rX =3D ...
> wY =3D wX
> wY +=3D 5
> if rX =3D=3D 10
> here can apply +5 to lower 32-bit of wY _and_ do zero extend into full rY=
.
>=20
> I don't see a value of 'zext' kind alone that doesn't do 'add delta'.

Exactly, that's why I suggest this as a completely orthogonal encoding.
Effectively for an abstract scalar value X it would encode whether
the particular register is:
- X + delta
- zext(X + delta)
- sext(X + delta)
