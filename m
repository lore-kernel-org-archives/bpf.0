Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0F33E35B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480353; cv=pass; b=YiTQ9VAnQrePEQNK2jvOVsHw6bpgWbEi200hCfrAw4Z9UpzNszLor7diTUYXgviqy91Sf/+HHofNLAdIaPa55BtlK6+1XVZrbBM5dH13gFdoTeTHPGR07TReGoqiHZ5ShNs0u+HtMeUZYsayHOaL6SiEH96bPYO0o7FN4JLPw0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480353; c=relaxed/simple;
	bh=ILN8IqWlVii5tDTgoYcy1DZfpKUeUqRq4ICO9cvv4Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGGJR/qO7eSjlrTXxz0HUwNssj24JuAkKqFz0gHPhEj2NNLHFSsi5IvoCRzh7MR15H6iSP8/3QLpG2zImOm8BYSmp/F7IigTjuIu+fJFIeoR5WwnEh5J2s9ecH7YeFxCh+E3EroOaXYFljF7RUyLRAnm7LyGq1LC+0kCErunY40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwOIxEfY; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwOIxEfY"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66766d649fdso242334d50.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 20:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783480350; cv=none;
        d=google.com; s=arc-20260327;
        b=pfTTOWcuMVeMEd/WVMA4YThDIckl1xI0KQwDR6a3AK17O0iw0PQstrSnBEnJ56pYkB
         5UzDc/NVGc+1RAEaKLxxTKk3jDrivSNTFFAv+nbAtbKhjzsGBzToigbM9TNM+tx8KD4x
         756B1ILiqQPaMTANTCnctziSvVPO2kZcHAEA8lIsQyeQqh/ZEbgdONZ0JBN9emZ0X9im
         xXXBYp9ORZ/UN1A8slRg6kYozYqQQuqN78YU1tfDXM3+0RACg0jagGA61ccmr2XABs8w
         bF2O8Tg8IlLFwMdUz6qaOT0PURMg4NobMJ2VHV71po8vsejk37YBNk2xmDFz7ejch/03
         m6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oknk3tQlPfde8xc17K9qMsBqym5928PvQ8Kp/qRXs20=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=gR3yYE2EQ/EXvz714YganazyKSaU/2jZnXZZ9F3ftv+EFgFG0h4z4Qj6Db/DCxYhS1
         ynmx/lMd2elC3LOg68IKlqrlZLSUM106zinLAepab+b5x3CfuyWW0PSY4VoDZ6bDzCFj
         6qe2M0r5Qb0LariAW57W+uce1L22QaVBlBAfEhUb2+7gMGLIia9Lu7rsHqB1RPPk3Pkh
         fQBiXL+hthzELA2+fUojVyZ5VWYFkHyq8C6anrFVbJ4jj5FG1pTjzRSvY+TiCzOFhUWN
         c+U/kgs1TD+EaocLWK39FeDzBwZvpp59Rf3GiOXeGnKWE9XeLAD2CDwHiXjTIW5wmFSQ
         DEVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480350; x=1784085150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oknk3tQlPfde8xc17K9qMsBqym5928PvQ8Kp/qRXs20=;
        b=lwOIxEfY0+mufA4FKL6CUbYMFbuarNaZ3X7CdwDOil09TWxpPAUuj2AAY+hQFKhjY7
         FEM6HOrw4j2ttOX9GPcbtsz7O74cSPPfXT7+tYWL97pq0JCe1PZn6hfYKB7AA4Ebkbp2
         GxuSfsrapLQLUERgmB0dX+hZZsPauielIiQ7ZiXQO+LYc/fk1bV3TXe1USNb6lFVe0w8
         83BpAeyvYTD4XPjHt1NgHllAGMDhTIF7dg+eKZh1TCQeGiqL2YUWHucd/JPpHdhXOG54
         aO4SpyqSLK89Qjg7XUYXB/r37AwqclstndHBDskgxv+Dp4P135bs3+s1myWv0Xsb7Ibe
         ZFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480350; x=1784085150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oknk3tQlPfde8xc17K9qMsBqym5928PvQ8Kp/qRXs20=;
        b=oN2zUjT0+1k3jZl6Xm2EbQO+YOK6LkuByjvw6JthkU1owwjCIELOyg9o8gHnofFyxU
         4f/l7nLcoV0HuC6AdKk18PYF2I3QbI2DS5LxYFZG54VXuidrHBU9SKMEXZuekiaebJMN
         xb5fJ2sY2u+zfEzRbiMIrvL2l1SRv6xLDg1AnAjKs7PqWnzBiNji5y4wjDOBfgzpoaUn
         xhhC0FdMvdEk5w1dJ7UoAkwXsf7uWP1vhhH2Fdo6TojdCOJugWfEF59NK64mZxZ+fo43
         mpV38aqDpuiTU3RxGBWwbSbB0z/F8AdrHuQoT9Mpn29SCheZhvC6O5qOctWjndCrA6Nh
         F5RQ==
X-Gm-Message-State: AOJu0Yyi/zuieGa42ewWN0W6CEQiJOwRNc1aBaUl/+XfZiuhOd/erZ1/
	8czBwLA55B/imj/QrNAXYCSBE28+45Na894yhJAbn78JlETlA3L9+FqzS8s400BMMKlOPpcMpuk
	s153ahVhnP4yI4DBLHUma7HuD3G5oSKc2TpiYxZc=
X-Gm-Gg: AfdE7clCU3STZTEry1wib+RJ1oqC59mjSA5fF0zqfe3SamRklkBQR4iyFOC9ESa87Pf
	TuZThwYSjKgCE0bYXgChBVknpkAZJhqbJYKTJDvJNhe/YnQJWtvaDDUhBZlsisQumbhU1oyiqul
	JDv7LrRVwtJ3AoWj9J1d+Tl6zfFG4eZ55Qt5jCw8KfBTE+t3jE3oU1U725LH5fMKiYn0ikcENRH
	gkw0tkMjH2NqCtFkPpBMWhSiUAUAZesNvKOKPADYOJ7PQY+a4syLCDRm+GTT5iOTOpdOy6ebD0=
X-Received: by 2002:a05:690e:419a:b0:667:9d88:97d9 with SMTP id
 956f58d0204a3-6679f2b8499mr482158d50.92.1783480350407; Tue, 07 Jul 2026
 20:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708025807.702010-1-lgs201920130244@gmail.com> <20260708031033.9A4841F000E9@smtp.kernel.org>
In-Reply-To: <20260708031033.9A4841F000E9@smtp.kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 8 Jul 2026 11:12:18 +0800
X-Gm-Features: AVVi8CfMvikuhwz5NNgv52z_PV_C2pN5QQQp8tt_xNQqx5A8YCzihoOQ41MZ4sw
Message-ID: <CANUHTR9R23PRS0peRy5H=p9=HVi=CBoL+X8MDVe_C6EcG24Byw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Limit bitfield dump reads to checked bytes
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Sorry, this email was sent by mistake. Please ignore it.

On Wed, 8 Jul 2026 at 11:10, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The patch introduces data corruption and undefined behavior wh=
en reading unaligned enums on Little Endian architectures by shifting a 64-=
bit integer by 64 bits.
> --
>
> --- Patch [1]: [PATCH] libbpf: Limit bitfield dump reads to checked bytes=
 ---
> commit 128a41a5de9f0bf022f4b652bb58245609c3162a
> Author: Guangshuo Li <lgs201920130244@gmail.com>
> libbpf: Limit bitfield dump reads to checked bytes
>
> This commit updates btf_dump_get_bitfield_value() to limit the bitfield
> value-building loops to the same checked byte range instead of the full
> backing type size. It aims to prevent reading past the checked range for
> narrow bitfields.
>
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
>
> [ ... ]
>
> > @@ -1784,13 +1788,13 @@ static int btf_dump_get_bitfield_value(struct b=
tf_dump *d,
> >        * stored in num, then we left/right shift num to eliminate irrel=
evant bits.
> >        */
> >  #if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> > -     for (i =3D t->size - 1; i >=3D 0; i--)
> > +     for (i =3D nr_bytes - 1; i >=3D 0; i--)
> >               num =3D num * 256 + bytes[i];
> > -     nr_copy_bits =3D bit_sz + bits_offset;
> > +     nr_copy_bits =3D bit_sz ? bit_sz + bits_offset : nr_bytes * 8;
> >  #elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> > -     for (i =3D 0; i < t->size; i++)
> > +     for (i =3D 0; i < nr_bytes; i++)
> >               num =3D num * 256 + bytes[i];
> > -     nr_copy_bits =3D t->size * 8 - bits_offset;
> > +     nr_copy_bits =3D nr_bytes * 8 - bits_offset;
> >  #else
> >  # error "Unrecognized __BYTE_ORDER__"
> >  #endif
>
> [Severity: Medium]
> Does this change introduce data corruption for unaligned enums on Little
> Endian architectures?
>
> When bit_sz is 0 (for unaligned enums), nr_copy_bits now becomes
> nr_bytes * 8 (e.g., 32 for a 4-byte enum).
>
> The code immediately following this block in btf_dump_get_bitfield_value(=
)
> calculates:
>
>         left_shift_bits =3D 64 - nr_copy_bits;
>         right_shift_bits =3D 64 - bit_sz;
>
> This results in left_shift_bits =3D 32, and right_shift_bits =3D 64.
> The final shift evaluates to:
>
>         *value =3D (num << 32) >> 64;
>
> Shifting a 64-bit integer by 64 bits is undefined behavior. On architectu=
res
> like x86 and ARM64, the shift amount is masked (modulo 64), meaning >> 64
> executes as >> 0.
>
> This results in (num << 32) >> 0, returning a corrupted value instead
> of the expected unaligned enum value.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708025807.70=
2010-1-lgs201920130244@gmail.com?part=3D1

Best,
Guangshuo
