Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B241514773
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027741; cv=none; b=Tf1a24ChCMnfQey1cVkcD5d/UmnO5zlaHgQcPejkswgADq4xH7QU7tqO/0acm2RCYLM+8WkfI+qgP2OZLDeOQ/uI0Ty+lD4mKdrOJ/+MCWr2e98zWv9OTdmqaoNchPLeAzHUhDPoqoawkotVEC1qmhyfy9C1Jln735x0JAT9qcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027741; c=relaxed/simple;
	bh=HCdxYoKJS4JXP84pYdyR7ipBqIPncIEkdtGfKAzM21A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OP+BS6Qmz7HFE0RvwZghCuvE1+fwRgpvLIqcTHUY/x1pIpLzcs8GHW18rS45iOwXdviB3CsqgzSpPa5XzCqDwhjX4Nwu8A1+TfojW9Ow1qA+0yWYBTvmjL79Y5aYSa7Oqois2xJe+WHD7H2UUfHhzwvJntY5K2aU0LhkVt4l22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at+3b0JI; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at+3b0JI"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so3053093a91.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790027740; x=1790632540; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JR/I8dSNLWX0oO0TxgyXU1KNRLBlNCoS227EjBBu2Z0=;
        b=at+3b0JIil/2xgXzEBxyhfV7aqGwE4aK81Ne5s4I2/YA4HlkxJ3KflJfq9ExkDNf4O
         8X0wJeVliAlGeV9j9+GJ1KveSGtg+j1Y5RWFy81NaZ3MHjcpRGV0h0Eqd3HCQbUEl+cu
         vpmrgc/yFOZzGRIqYipoGVqAUfJ4Fb9EIelikwhY+aWRXiQ0zdX1E6Wf2dgKrHtGWYtT
         qJqwWKKOgJ6Qdt46zXN+kIaHJjdACVsjgkVfLaLCyR/gCgxLzWI5ep16SzlK7gYubLxp
         fk1DUWRJk3WoDG6wCLLsmaFxJtZtP2ap9YiGKZ0Lm6/kHuI543nZzeeuuwR5Ja/iq8QI
         inQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027740; x=1790632540;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JR/I8dSNLWX0oO0TxgyXU1KNRLBlNCoS227EjBBu2Z0=;
        b=wRoty2WyNpNAQeSH9M7V6M26pIVFPuzG6CsxLj+cOUJzeJCQhfQ7crB5lVB6SAaGg3
         fM6x5AbGgaJweABEpXjXZeNNkMmXzl4Tq194jV9x11KgNzfwpACHT6rh7J6jCIzYaPYP
         KuVrAjcizLXx8VXMCm1a3ycx9DfOesmB/so3g1jGOlDKGrphHqnl+oqyTUn+SNzuFIoj
         y0d0GAxFw/wOIUAN4TqDrBoMzJqx6TzrBg2YmvWzFLfqPLZb2V9SF3X6WSt52JG5Zlhh
         Y6alPd5atlBiP3Tcsgd2PgEGLFes9s+XVSFknL2wIrkhD/v7G/E4XmQ+gDJBwxAqrFfi
         AatA==
X-Forwarded-Encrypted: i=1; AKwUvByE/AQrkRkCHBM8E6akCC4VErwJAFGHRWFJcjgG/pbnL50a90mN7u4QwJnmABkLedKa57g=@vger.kernel.org
X-Gm-Message-State: AFuF++kHkNO3g+Ex9csawwlKONBVY5npGpWI7rG2aGOMiEAoVS82iVU4
	I0SyxmKJFIkgPxXcC5CdhRSVnPdkYmCEM4ppydJx8f/RJqsW42CfOK/z
X-Gm-Gg: AYBFou1H14nPRNJOxqe2CfbNHH/bi7DQN9e6VfTUV8qWL73jp4vD+7upeu2iA9irnv/
	Fw7dlBgmL+Noi0RhV7oeQ7TWNkrlL1pW3zgNQzbR+42mqPh3h7oL+Qhm68NH1hWlpc5YqCWdYiw
	LxLU78G/7GPRLq2qTVStzG7VA3uN3mQpsy9ivAdbH6ANvhoeL14vpPTrs6YTcjTvj1uk8BCocR5
	Oznjm1m40fVkzx06oV4f/gcRERpGU87wd4/yXeC+Fu0oaRtfe9+8PeUigyhSR7ruvzugwBbvywl
	oeRC8ZFGVFs7aICBUdY7uwt84u5H+UPUuuJwLgp58tXLBg58Zf7Sn7kgXBW8Cp5kepU6MUjjCjc
	Ja9p7xbHztW1s9NjiHeH9pdrfoVEp2UM5XtP46j1SDj1DOFWlAT9Se7EqYfPiZS6oO1O2RTUsnd
	k6Nv7pY1VDd6AH46AFLE5lm52t617wuZ/TyRsqm/OUjVJdYGrnaQxbPn6+u2F4w/8n0ODdJWUc3
	P4R5xJL8WONcyocgOlgjKKysn9x0gPJIvx98H0FaNVzGXA9Fw75wPFywSy8OzIx1SP930UUcaHf
	IhE=
X-Received: by 2002:a17:90b:3909:b0:39e:3558:f925 with SMTP id 98e67ed59e1d1-39e54d86a97mr17008107a91.24.1790027739732;
        Mon, 21 Sep 2026 14:55:39 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0699c5486sm640851a91.14.2026.09.21.14.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 14:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 21:55:38 +0000
Message-Id: <DLLBVIU33MLC.ITFPYGMFKWUT@gmail.com>
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
 <DLL8Q69N7BUD.1HI0MKU2M2UGE@gmail.com>
 <951923920747d8dcba3d56ca8858e106d9c7ba4e.camel@gmail.com>
In-Reply-To: <951923920747d8dcba3d56ca8858e106d9c7ba4e.camel@gmail.com>

On Mon Sep 21, 2026 at 7:44 PM UTC, Eduard Zingerman wrote:
> > > > >=20
> > > > > Where:
> > > > > - id =3D=3D 0 =3D> no id link
> > > > > - full =3D> all 64-bits of the register are identical to
> > > > >           all 64-bits of a scalar value `id' (let's call it X).
> > > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D full}, rB{X,ful=
l} =3D> rA =3D=3D rB
> > > > > - zext =3D> lower 32-bits of the register are identical to
> > > > >           lower 32-bits of a scalar value X,
> > > > >           upper 32-bits of the register are null.
> > > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,zext} =
=3D> rA % 32 =3D=3D rB % 32
> > > > > - sext =3D> lower 32-bits of the register are identical to
> > > > >           lower 32-bits of a scalar value X,
> > > > >           upper 32-bits of the register are either 0 or 1,
> > > > >           depending on the bit 31 value.
> > > > >           =E2=88=80 rA{.id =3D=3D X, .link =3D=3D ?}, rB{X,sext} =
=3D> sext(rA % 32) =3D=3D sext(rB % 32)
> > > >=20
> > > > hmm.
> > > > there is also 32-bit link with delta, right?
> > >=20
> > > My point is that delta is independent of 32-bit/64-bit property.
> > > `delta' can be used to propagate in both directions:
> > > - full 64 bit -> 32 bit sign/zero-extened
> > > - 32 bit sign/zero-extened -> full 64-bit
> >=20
> > both? how ?
> > I was under impression that in 32-bit domain delta is one way.
> > rX =3D ...
> > wY =3D wX
> > wY +=3D 5
> >=20
> > if wY =3D=3D 10
> > We cannot do -5 to rX
>
> Why?
> It is still valid to transfer r32 and tnum_subreg knowledge from wY to rX=
.
>
>   wY + 5 =3D=3D rX % 32 + 5 =3D> hence rX % 32 knowledge can be recovered=
.
>
> If rX itself had some delta, e.g.:
>
>   rX =3D ...
>   rX +=3D 7
>   wY =3D wX
>   wY +=3D 5
>
> Then it would still be possible:
>
>   wY + 5 =3D=3D (rX - 7) % 32 + 5 =3D rX % 32 - 2.
>
> Again, in case of this direction, only lower 32-bits of the 'full'
> register can be inferred.

Ok, so we're argeeing that it's not 'full' in your above definition.
Your enum id_link_kind needs a 4th category : apply-delta-to-lower-32bit-..=
.
and it's not bi-directional.

rX =3D ...
wY =3D wX
wY +=3D 5
if wY =3D=3D 10
here can apply -5 to lower 32-bit of rX only.

rX =3D ...
wY =3D wX
wY +=3D 5
if rX =3D=3D 10
here can apply +5 to lower 32-bit of wY _and_ do zero extend into full rY.

I don't see a value of 'zext' kind alone that doesn't do 'add delta'.
