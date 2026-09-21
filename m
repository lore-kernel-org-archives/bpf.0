Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B67394471
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018859; cv=none; b=ZiwuOafPtMgiWWmCHinpf2te55Uhnp0FpbbzyQ4KgSdJC9e2ix5cTcR374/cHqxXtAqiMgNNcpVmX3UDorekObSg2N8qyPUyt14PyrzamW2Z0uCMlHvpuI/3IQDxeWwwzWgMIGRf2PHhXuh2pdfw8xq49asNGHWCHjtNAiiyaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018859; c=relaxed/simple;
	bh=4on2XQCCKq79/vtxCsDoimfudfbqBXEbuHawU+G11pc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=LpV5Bft04fKLGkU+h/1xBIvEF4BfXjHh37c9bFiyCVzsXoxd2HDx9la6e6OGluDIgKQdxGQLxCZ/0CO+nkO+D7mXOoyWrCnpo62jGqIwey1tEqhP8jkv0e4Ux+Uf+QaS3qu7Uks8avBKt5IsVj/4BcHkAOpItNoPtyM7214K71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPE4PbSz; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPE4PbSz"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so3715052b3a.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 12:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790018857; x=1790623657; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+BuFRYJQioQsFKMrRoqK+vwHlNR8DMCln0kaU+pU5wk=;
        b=ZPE4PbSzVro93qo/gQkB40ESIYppDzFxJ9Cw5xxWAKZM0D1yeCeDAqezL5ns6dBxjy
         uZWUuijflIdYXihjLrA+VYfPfEXMnUwYj8fIDZ8qvH/WjdJoD9tLcCppsvKnV0CUCpEQ
         ciadN17WT/ntmg2CaPXiZ8cIS6RQHs2LJiAVXgFlmBciSDmjvY77pMMpHjAOYufxYGIx
         FcOfp+msRxwYIuMfIKT+RnEBVkpn16wA9WxH6uuWy9HLAsZHtSW8Vxe4ohdtKzASxu+z
         hQiE/wqhlPJKCMM7POOcwe5F/iXkigSuunZk3b+2KYmzsYsWXC0jMvXQCVrX/QAE4s9K
         Ns2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018857; x=1790623657;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+BuFRYJQioQsFKMrRoqK+vwHlNR8DMCln0kaU+pU5wk=;
        b=DG+5p3U8en5O7eC6c6rIPwnpMTXr2W10vQNF8vyKR1UVsUaPEpkUN20p1/7rc41wfK
         ibh2wYtNabfPSfJmyjx1zfxOPDGTYTjZueg8XXwwCLtXEiWqpWxtEhztn0iPCzWZGBhm
         UzWjzSFeeiGw0to9INmKk1rrVekBX/oYnk6/mmYlKpyY4wCBNPlahA8qUJjErMvuI60r
         SeBuGFIkG2V5VTJw80CHhGNJosKH/13fYhi6kKh+nUJ3AlMY5sRBX6Le32mmQnY3ydCR
         Z7gD/MJLuGNAoNRYJSwmfiBARegEF5dKhKlSm5vgXPvC1oVSIu000peRP1Lo11x/cgnN
         JTQw==
X-Forwarded-Encrypted: i=1; AKwUvBzDHkxRgWMr5+FOrSaSUjr7k+ZEwd8ItuuJ6yg8I8fwDvBZMKSmGJvIB7gEHuI4HwG1Oqs=@vger.kernel.org
X-Gm-Message-State: AFuF++nA24U6UfNHNiWrL+MRnCmR6eP5UTnVnyuULk0Z0xEtlW4gGupa
	zo4us6z0aEzw4VhWYVNTndJvQjsc+zhtzBqpnv1wNQdufQfP1fhZ1es2
X-Gm-Gg: AYBFou3HXFR7eQCcFAMEq4lyUn5PyzBhFAcNyioxp2qu5AQdLq+93SiNfgkh9gMJFdR
	M9hycbKXHF4+51Yalo2vG9Lrjzb6C75cJ2Jv7I5k8PcxKLtuUbErTBXxoouAV1Kt1HSTifWdK70
	i2o5qkJ5V2scvZFN9x+tnkDFeSDwkNKbd0c7+xLKYbthpxKeLfA0Q6Z1nd5og7rVcTaWL8GaqrS
	wZurc2DCxQx/faO6lTZpwOg+YohjBDQ8CMItepgYF+3XONFyw6aWTSdHWD6xQ1dBj3+nHWVZdA6
	ejF6plGn8bekyWMuiStvstDFBy+uS78BvRSRe3bgeXz9ZWhx7S41A9Y4ofpx6FoYPqju/6Dww5j
	2Lm9IjjK5ziDHbg3KBPxPoddvFdP2uWgf4Dlin6df3NhJ7iHOlESDGSjM2q7dThum2yd60PLvEJ
	tasgnZ0QQ69Qp/stgkztVtXDEnxxlcf41TmXqkMcgTyMy2bJIL5QXZs+ZTtdmnAoH0jn3qVTKcN
	VjFAAWiB3GU7e7DOoYYDgOFzI8FWUKj2cyLLz2ijBCG2XrRjA2JJEYrSnMCHoh5Qw4fbreFjtyk
	tgA=
X-Received: by 2002:a05:6a00:4655:b0:874:705d:f651 with SMTP id d2e1a72fcca58-874de60e6c9mr16128267b3a.31.1790018857181;
        Mon, 21 Sep 2026 12:27:37 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87bf7eb8574sm1309b3a.43.2026.09.21.12.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 12:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 19:27:36 +0000
Message-Id: <DLL8Q69N7BUD.1HI0MKU2M2UGE@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Vineet Gupta"
 <vineet.gupta@linux.dev>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Shuah Khan" <shuah@kernel.org>, "bpf" <bpf@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality
 across zero-extending movs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
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
In-Reply-To: <e9aad352ba82dadd97a17867108b5db1865fa38d.camel@gmail.com>

On Mon Sep 21, 2026 at 7:10 PM UTC, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 18:59 +0000, Alexei Starovoitov wrote:
> > On Mon Sep 21, 2026 at 5:28 PM UTC, Eduard Zingerman wrote:
> > > On Wed, 2026-09-16 at 17:30 -0700, Alexei Starovoitov wrote:
> > > > On Wed, Sep 16, 2026 at 5:08=E2=80=AFPM Vineet Gupta <vineet.gupta@=
linux.dev> wrote:
> > > > >=20
> > > > > It ended up with full testsuite run parity - after 4 incremental =
patches.
> > > > > But the pattern of all those patches was adding some predicate /
> > > > > special-casing to reg->add_const
> > > > >=20
> > > > > hunk 1
> > > > >=20
> > > > > -       if (src_reg->add_const)
> > > > > +       if (src_reg->add_const && src_reg->delta)
> > > >=20
> > > > why? It should not.
> > > > My point is that zero is not special.
> > > > It should be handled within the current framework.
> > > > All these extra hunks are not correct.
> > > > ADD_CONST_32 logic should work for delta =3D=3D 0 just like
> > > > it works for delta =3D=3D 1.
> > >=20
> > > After thinking about it some more, I agree that having an orthogonal
> > > encoding would be nice. However, it appears that the split should be
> > > somewhat different:
> > >=20
> > >   struct bpf_reg_state {
> > >     ...
> > >     s32 delta;
> > >     u32 id;
> > >     enum id_link_kind { full, zext, sext } link_kind;
> > >     ...
> > >   }
> > >=20
> > > Where:
> > > - id =3D=3D 0 =3D> no id link
> > > - full =3D> all 64-bits of the register are identical to
> > >           all 64-bits of a scalar value `id' (let's call it X).
> > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D full}, rB{X,full} =
=3D> rA =3D=3D rB
> > > - zext =3D> lower 32-bits of the register are identical to
> > >           lower 32-bits of a scalar value X,
> > >           upper 32-bits of the register are null.
> > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,zext} =3D>=
 rA % 32 =3D=3D rB % 32
> > > - sext =3D> lower 32-bits of the register are identical to
> > >           lower 32-bits of a scalar value X,
> > >           upper 32-bits of the register are either 0 or 1,
> > >           depending on the bit 31 value.
> > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,sext} =3D>=
 sext(rA % 32) =3D=3D sext(rB % 32)
> >=20
> > hmm.
> > there is also 32-bit link with delta, right?
>
> My point is that delta is independent of 32-bit/64-bit property.
> `delta' can be used to propagate in both directions:
> - full 64 bit -> 32 bit sign/zero-extened
> - 32 bit sign/zero-extened -> full 64-bit

both? how ?
I was under impression that in 32-bit domain delta is one way.
rX =3D ...
wY =3D wX
wY +=3D 5

if wY =3D=3D 10
We cannot do -5 to rX
and we cannot use your above 'full' encoding for wY +=3D 5.
Currently we use BPF_ADD_CONST32 for wY +=3D 5
I don't see how 'full' can work.

