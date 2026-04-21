Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82D31D362
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793526; cv=none; b=VFiJCrYLG4ey0/ssPjIt166PUxrBerZCNvxoQvFQxlYaNpcgxNJPrFF8Ec4UCiHz8GpnW7tymFWDkqU148wQQodOceAv5GJNcQwGmd2neRqiAKc6YrX7R2Hdr+Bwm/jUQ3vlG2DbcqYqAqnYc6nYxdR4HD7DajVXLfDd9xf0SiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793526; c=relaxed/simple;
	bh=07D5qQ3MlVLPTytT7je/PastuYKfwOSM10P5ukGmRlw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRu6dXCZ4AX3gl5xgsqB2SX/pVBg7i5TOvXzQI11CoaWpkVSFVjvEz4SikjasuRAQnzEnqYmcVil9UoJH3OXCxoxPrAPqy2MzD/Mp/1YDcES29sH3Ix8z2w/585YXQpfAmw9i2hq9w7Wk/3+J3ulset9IFMyqyD9VyaoPp++hw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7K0wu1I; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7K0wu1I"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso3269930a91.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776793523; x=1777398323; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NwpF8t+abMZj+EQm51CmZvoY6FlIKBZ/iPBcnwzM688=;
        b=O7K0wu1IGR+INhvT2/9sab78HDBY2mkQamEnMyV0rLMgYPGoIGZFzVim2d3DnPCpQl
         X5LIPKM7Bv7CXOMAM+btGzABuWujtoH5pDqZHwihkKNFrTyzSOvKuZWo+A9LzW0jZGRG
         yY18Z1WZnqe0SINd4wO+yRotvzB6dDiTyud85N6YOH022rFUx5xoYW5Z6JTT89Qi/KR9
         DCTngPR1AcH+JJH+Su529pPlBpMdrsnNzf1vNDgVKKcVc7UDL88OIvJ1wM8Y/GITB8FZ
         SvH0OKcNP7mdeupcvn+2ga26j2f3nm/+yfwUbBefYPlQieGhGd1LCYFY9j4OUZIAf0qo
         KQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793523; x=1777398323;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwpF8t+abMZj+EQm51CmZvoY6FlIKBZ/iPBcnwzM688=;
        b=BRW3gU9cP5st2yu66I2oAPKRJrKRctpmYzFFrseclKUYTII70IuP6k38szmJPxXuut
         6Nh+zySadB3hAc5BB3MrIpXk6e98WB3sR1qgOt4JY6MvWZhJUKt89eiJzUNXGiGzjdS5
         cwu+2rzQIv4zoJQjci/KRtpipJA4T7FomBWziUpSAlkTCVwD0ph1bPHswooWx5UDNl+w
         wmifG6+RHfcazDNVG1UxorxgTwUJCa5/67burwVpOwt2nKQpwqX1bZkDBH5HqfJKzxyi
         O28JtLmZjQxc1VjpEZ0cc1vrcMqdko1IiyOn23Emc/Q13ZjhuwGFPd6guX6yX1/CRiYN
         waxw==
X-Gm-Message-State: AOJu0YwOGL6MupbN3aPMRhk2/YrmM08HuhoLFLBTysnmwnxd8iULE/rM
	dMDgHRBsybV3RdfDYei7coUDlFQyWHTXukvWKViQ1USrWOJN6mmpk6CvjVkzaumV
X-Gm-Gg: AeBDieuX4yuN8dXOZ8lAvPMoO5/6D2AMf79KvghLqnZDYe/yFfxH2E/msIzXYyNUQcp
	2tijAoU6Kb9WdXhYmFb3MqqjxJhNzHSiszJknf/jiOdfhWnbQy/K/b5hO5Di/mLvaImwHaLTOOB
	zWMQq+SE3JePlTQk67+YjK3ugdlrTEiBhm0p0BX8kRb03v9H8rUfnMuiHbxqt3f6MPpu38TQt/w
	HLSu827r5Zj2bWfO8y6z4Fk2UDtO9ToZRvONSHqXUovOpeRQslF6rpsbcQGYpVpOMJ0SB8+hUyT
	7UXzhySJbEA+G76/hH4lksJJdgliIxjLX2BBp2vVGdEgZ4p1AZFYCvMaSMBR0Dw7pszSq/ClPZb
	noxa3+NWF7gjthpk8jdpMJuuMUklVHtE+wb8IUP6oYqcRtnt4eNlsKoQ2A+1TN+i+Zk4R66NsrO
	SrYzzENLF44CtcrcFWPu0h/nuA3l35GF0Kh9WcXKaVobHa9bBouQFwp5FSGuc9Amc=
X-Received: by 2002:a17:90a:da8c:b0:35e:581c:6bca with SMTP id 98e67ed59e1d1-361403ca597mr19610737a91.3.1776793522488;
        Tue, 21 Apr 2026 10:45:22 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc575bsm14409277a91.4.2026.04.21.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:45:22 -0700 (PDT)
Message-ID: <c8eca067d7cc8a3c514d41591a5ff2ab766cbe1e.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: representation and basic
 operations on circular numbers
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Tue, 21 Apr 2026 10:45:19 -0700
In-Reply-To: <20260421171830.3881BC2BCB5@smtp.kernel.org>
References: <20260421-cnums-everywhere-rfc-v1-v1-1-8f8e98537f48@gmail.com>
	 <20260421171830.3881BC2BCB5@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 17:18 +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 4 potential issue(s):
> - [Critical] `FN(cut)` emits wrapped chunks causing `FN(mk_mul_u)` to com=
pute unsound narrow bounds.
> - [Critical] `cnum32_from_cnum64()` can return a struct mathematically eq=
uivalent to the `CNUM32_EMPTY` sentinel.
> - [High] Unconditional use of `__int128` breaks compilation on 32-bit arc=
hitectures.
> - [Medium] Missing emptiness checks in `cnum64_cnum32_intersect` and `cnu=
m32_from_cnum64` resurrect unreachable states.
> --
>=20
> commit 5ab536543671bb2cd6865196d88e96f87d1e7888
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: representation and basic operations on circular numbers
>=20
> This commit introduces cnum32 and cnum64 representations for unified
> signed and unsigned numeric ranges in the BPF verifier. It includes
> functions for intersection, multiplication, and range conversion to
> refine bounds deductions.
>=20
> Link: https://lore.kernel.org/all/ZTZxoDJJbX9mrQ9w@u94a/
> Link: https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
> Link: https://github.com/eddyz87/cnum-verif/tree/master
>=20
> > diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
> > new file mode 100644
> > index 0000000000000..38a805a6fc2a9
> > --- /dev/null
> > +++ b/kernel/bpf/cnum.c
> [ ... ]
> > +struct cnum32 cnum32_from_cnum64(struct cnum64 cnum)
> > +{
>=20
> Are we missing a check for empty inputs here? If an empty 64-bit range is
> passed, does this code convert it directly into an unbounded 32-bit range=
?
>=20
> > +	if (cnum.size > U32_MAX)
> > +		return (struct cnum32){ .base =3D 0, .size =3D U32_MAX };
> > +	else
> > +		return (struct cnum32){ .base =3D (u32)cnum.base, .size =3D cnum.siz=
e };
> > +}
>=20
> Could this else branch return a value mathematically identical to the
> CNUM32_EMPTY sentinel?

This is a valid point, but it won't be hit in practice:
the function is called in reg_bounds_sync() and empty inputs are
short-circuited there.

>=20
> If a valid 64-bit range has a size of U32_MAX and a base ending in
> 0xFFFFFFFF, this would return { .base =3D 0xFFFFFFFF, .size =3D 0xFFFFFFF=
F }.
> Would the verifier then incorrectly assume this code path is dead and
> prune it?
>=20
> [ ... ]
> > +struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b=
)
> > +{
>=20
> Does this function need to verify if the input ranges are empty before
> operating on them? If the variable a is empty, could the arithmetic below
> return a non-empty, garbage range, effectively resurrecting dead code pat=
hs?

Here as well, a valid point, but does not happen with current verifier
structure.

> > +	/*
> > +	 * To simplify reasoning, rotate the circles so that [virtual] a1 sta=
rts
> > +	 * at u32 boundary, b1 represents b in this new frame of reference.
> > +	 */
> > +	struct cnum32 b1 =3D { b.base - (u32)a.base, b.size };
> [ ... ]
> > diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> > new file mode 100644
> > index 0000000000000..28dcb79ba6950
> > --- /dev/null
> > +++ b/kernel/bpf/cnum_defs.h
> [ ... ]
> > +#if T =3D=3D 32
> > +#define ut2 u64
> > +#define st2 s64
> > +#define utt u32
> > +#define stt s32
> > +#define EMPTY CNUM32_EMPTY
> > +#elif T =3D=3D 64
> > +#define ut2 unsigned __int128
> > +#define st2 signed __int128
>=20
> Will the unconditional use of unsigned __int128 and signed __int128 break
> compilation on 32-bit architectures? Since the BPF subsystem and verifier
> are built on 32-bit kernels when CONFIG_BPF_SYSCALL is enabled, this
> might cause widespread build failures.
>=20
> > +#define utt u64
> > +#define stt s64
> > +#define EMPTY CNUM64_EMPTY
> > +#else
> > +#error "Unsupported T value, cannot define ut2/st2"
> > +#endif
> [ ... ]
> > +static int FN(cut)(struct cnum_t a, struct cnum_t chunks[3])
> > +{
> > +	int ncuts =3D 0;
> > +
> > +	if (FN(srange_overflow)(a)) {
> > +		chunks[ncuts++] =3D FN(from_urange)(a.base, ST_MAX);
> > +		a =3D FN(from_urange)(ST_MIN, a.base + a.size);
> > +	}
>=20
> Can this splitting logic emit wrapped chunks that cause bound deductions
> to underflow?
>=20
> When an arc crosses both boundaries, this splits it first at ST_MAX. The
> resulting first chunk crosses the unsigned boundary 0.
>=20
> When passed to FN(mul_chunk) with a multiplier, it falls into the fallbac=
k
> branch utilizing FN(mk_mul_u):
>=20
> static struct cnum_t FN(mk_mul_u)(utt a, utt b, utt c, utt d)
> {
>         ut2 size =3D (ut2)c * d - (ut2)a * b;
>=20
> Because the chunk wraps, its unsigned start is mathematically greater tha=
n
> its end. Does this cause the subtraction to severely underflow in unsigne=
d
> arithmetic, producing an artificially tight size that misses valid
> runtime products?

This might be an issue. However, it does not lead to unsound results,
at-least in u8 domain [1,2].

[1] https://github.com/eddyz87/cnum-verif/blob/arithm-ops/cbmc_helpers8.c
[2] https://github.com/eddyz87/cnum-verif/blob/arithm-ops/main.c

I'll this and post updated veristat results.

>=20
> > +	if (FN(urange_overflow)(a)) {
> > +		chunks[ncuts++] =3D FN(from_urange)(a.base, UT_MAX);
> > +		a =3D FN(from_urange)(0, a.base + a.size);
> > +	}
> > +	chunks[ncuts++] =3D a;
> > +	return ncuts;
> > +}
> [ ... ]
