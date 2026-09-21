Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F03B1034
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019880; cv=none; b=DjgfTjOqIAfjaB44z7evq1kLUUPvVy5QGoR+fNZ+AkILdengi+rW6pZvzRWyFfZlOYYtdSyUUHYZhZKdIVavrHT822DXebcXsTNm44DE1N61NNrW0KMORwlSHsVlu5M4N6jB8pWaRZIc80Ln/NWeNalfcbDaV5r+MsgMtjzLPdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019880; c=relaxed/simple;
	bh=97s/8iT6zoeWzj5BFrEjbnzOOXlWZdXh//bjwqi4OXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6zS9OjFdLhHJ+xuvyuy2TsC4iB2LBgsGeQ9woXFWMBNF49C3GHoAuETIdJLGIl6Zsn0H6utluQreEk1l0c93+cs3tmYSawAD8/qJrUUd6FwWz8qJCIRe5NKnnKehRV5YjsGr9ZnDpgpbprYex6Sv0+TcfBtRq+PObDvZdEy8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNjUD6Wb; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNjUD6Wb"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so31734025ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790019878; x=1790624678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7EWfsQUamIev2TGG4Ye/VRFYZNi1syArJoSYx9L81TM=;
        b=pNjUD6WbURdMR1fZMclQZgtrt94TDEAOLFI7lzTW/a8PfejEZgaOqczn5ROLbxm64e
         7Wzg+dATmgk0mxrdJj60ldJJsPCzAcwt5j6IqkqwhB05vOdRJyrEO536CpfgKmlY5csG
         PWcGmzldT/W97HuHJKV1yX3h8dr6E/r6obifnxWwVFWMWSVTp35AIvj2VRXRjzpGt3+c
         g1JXFWKjuDTItGGMnIjpyHk2ztRuGfMlolIW7q4Ya/YyksOUfzNmeYWSxx/3gwCYKZJS
         YKxKxYOFK/cntQgzywYL/XPwhNpQwmRPQyKINfzQytEpFKDK5m+W4y4+8+RvE91yz9O0
         scHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019878; x=1790624678;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EWfsQUamIev2TGG4Ye/VRFYZNi1syArJoSYx9L81TM=;
        b=JvRLjm7FGFu1LXhsDa1P6fP+JNsYGfmVy1hRrpo42w5sftcWs8Q6RckBZqBaMu0fjB
         oMyj6gLaSrj2jGtR7k98XkXTJiwLi6E9Q8ukg+gspDo0RHFJbGOKH5Eva7Htp2LsBfNi
         cBBZCm4p/Fd2+XO1oZddIyS18RSrImMYSKfj9PzrtIhLYvpb1NkJ1ToGrYhyFN1w5lee
         Q61EWqsjZuVdDUyUiOgKS1WpQVtQbl8J8JZ13mO1ptBb4C0ne1rIk6NbjvBECePVBhZS
         1y5LvoX03j8QbGgbg/4ICpyYPziIcBDKEcgcQ5uIqiQ79Qi8Akn4X6x0AgO0Zz81dOM4
         pd9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzArG7IEWXIzwbdFJqOJlmG6uN6LvavsQO3v3WEUxZBHbmLn4gGGCmKJfdmJ/njJFPSKJk=@vger.kernel.org
X-Gm-Message-State: AFuF++kWW+l/6MvWiF2mf9hLjrp1iveLLHb/KB8GDQM0Iab8z36A/GrW
	svvwry582Vz5OHxzsGnvKa5RTw8CXsvPth9XYhFihAbQ61l2CrvZWaaR
X-Gm-Gg: AYBFou2AWevrmYFzabc92FAUcUrjLOxutTvaO92nkFNolKwI+vE1imy8SrCTNb7dpA1
	uOQ8nvLC4D7JCZqPDgdwwpjcBtGNOwI13xJ760jrxGkUNvuKdsiAhT5MomDWCherxzykWYB5Eyq
	onaZcYqsTz2gI1I+M4WC6Xrbz9xTpaY5Rptl2BjQY+p568vcEcrPg5TePYbo+vdTtjFd+CDLPPm
	h3gBQZwtI0Rmsv52nOBdTFSoBGM5y8pKVOkW5zOXLH0K0AdS79C18Ot8r/uvTHdjPLK7ZnBoYKk
	1UTNO7IUKXI67OptqJxpkMRUn4XhxyJfYTF0f//DA7rXmoepNjlE0LRQiDkZUsKiUOYx8P+wXbX
	YjqkAt5Naq9WSVM1DTWTW4PxVrQjnrA7Lt2dCAVsY4DBXSleG3neJt0s6PaeaTtzfcEBwxP76n4
	P7jRPlTSTPI6X7jj0oz2DYeK8KkZHoCmyqMnliLwdoJjp0NaGL1Kzj1Yh8XSpbF+0PngLBA7tNy
	jplTdyDYcRoy42+tZzwH91wFcXJSfc+hFs2MznRDH/R7X0j05CTzTOQBn0tVlCGqpUX
X-Received: by 2002:a17:903:1448:b0:2dd:c100:943f with SMTP id d9443c01a7336-2ddc1009c5fmr105596185ad.61.1790019877522;
        Mon, 21 Sep 2026 12:44:37 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5eabe0b5sm261383eec.1.2026.09.21.12.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:44:37 -0700 (PDT)
Message-ID: <951923920747d8dcba3d56ca8858e106d9c7ba4e.camel@gmail.com>
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
Date: Mon, 21 Sep 2026 12:44:34 -0700
In-Reply-To: <DLL8Q69N7BUD.1HI0MKU2M2UGE@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 19:27 +0000, Alexei Starovoitov wrote:
> On Mon Sep 21, 2026 at 7:10 PM UTC, Eduard Zingerman wrote:
> > On Mon, 2026-09-21 at 18:59 +0000, Alexei Starovoitov wrote:
> > > On Mon Sep 21, 2026 at 5:28 PM UTC, Eduard Zingerman wrote:
> > > > On Wed, 2026-09-16 at 17:30 -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Sep 16, 2026 at 5:08=E2=80=AFPM Vineet Gupta <vineet.gupt=
a@linux.dev> wrote:
> > > > > >=20
> > > > > > It ended up with full testsuite run parity - after 4 incrementa=
l patches.
> > > > > > But the pattern of all those patches was adding some predicate =
/
> > > > > > special-casing to reg->add_const
> > > > > >=20
> > > > > > hunk 1
> > > > > >=20
> > > > > > -       if (src_reg->add_const)
> > > > > > +       if (src_reg->add_const && src_reg->delta)
> > > > >=20
> > > > > why? It should not.
> > > > > My point is that zero is not special.
> > > > > It should be handled within the current framework.
> > > > > All these extra hunks are not correct.
> > > > > ADD_CONST_32 logic should work for delta =3D=3D 0 just like
> > > > > it works for delta =3D=3D 1.
> > > >=20
> > > > After thinking about it some more, I agree that having an orthogona=
l
> > > > encoding would be nice. However, it appears that the split should b=
e
> > > > somewhat different:
> > > >=20
> > > >   struct bpf_reg_state {
> > > >     ...
> > > >     s32 delta;
> > > >     u32 id;
> > > >     enum id_link_kind { full, zext, sext } link_kind;
> > > >     ...
> > > >   }
> > > >=20
> > > > Where:
> > > > - id =3D=3D 0 =3D> no id link
> > > > - full =3D> all 64-bits of the register are identical to
> > > >           all 64-bits of a scalar value `id' (let's call it X).
> > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D full}, rB{X,full}=
 =3D> rA =3D=3D rB
> > > > - zext =3D> lower 32-bits of the register are identical to
> > > >           lower 32-bits of a scalar value X,
> > > >           upper 32-bits of the register are null.
> > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,zext} =
=3D> rA % 32 =3D=3D rB % 32
> > > > - sext =3D> lower 32-bits of the register are identical to
> > > >           lower 32-bits of a scalar value X,
> > > >           upper 32-bits of the register are either 0 or 1,
> > > >           depending on the bit 31 value.
> > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,sext} =
=3D> sext(rA % 32) =3D=3D sext(rB % 32)
> > >=20
> > > hmm.
> > > there is also 32-bit link with delta, right?
> >=20
> > My point is that delta is independent of 32-bit/64-bit property.
> > `delta' can be used to propagate in both directions:
> > - full 64 bit -> 32 bit sign/zero-extened
> > - 32 bit sign/zero-extened -> full 64-bit
>=20
> both? how ?
> I was under impression that in 32-bit domain delta is one way.
> rX =3D ...
> wY =3D wX
> wY +=3D 5
>=20
> if wY =3D=3D 10
> We cannot do -5 to rX

Why?
It is still valid to transfer r32 and tnum_subreg knowledge from wY to rX.

  wY + 5 =3D=3D rX % 32 + 5 =3D> hence rX % 32 knowledge can be recovered.

If rX itself had some delta, e.g.:

  rX =3D ...
  rX +=3D 7
  wY =3D wX
  wY +=3D 5

Then it would still be possible:

  wY + 5 =3D=3D (rX - 7) % 32 + 5 =3D rX % 32 - 2.

Again, in case of this direction, only lower 32-bits of the 'full'
register can be inferred.

> and we cannot use your above 'full' encoding for wY +=3D 5.
> Currently we use BPF_ADD_CONST32 for wY +=3D 5
> I don't see how 'full' can work.
