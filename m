Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D92F3C10
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881109; cv=none; b=LOWCRqEIUDQnjqVUx3VFZyh/E8ryyP0J8iq7OFmjWav0GBzrdW9F+2QNto5LGGRPWF3mc6pW4/BnxA7BDnjBWCqOwART2idPx+NbO7y6dYrpKF9LOmsmOVkjxi5OeJLWm+unjigjGnMNfUOEbmSU424Mtqo4emRZMbto42GLk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881109; c=relaxed/simple;
	bh=JWcv9o3RXQaCcYB936r5ywBnXBuPI91lbIkNB3OaIkk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JyEjkMIXwbfIyqC/iUKSsn9bd9CZPnZTzYe0DJabzanonsV4pNYd6jHMGyhVG8h1kqCYHdhoAnroSF1jQ1I4qq6ZEprAry/u/1YTkuD2K7w6zPaW/aNXRrtgOg+4FRZvaMD4bAVTtJCElLULT0saTWP9o98qVk18gIjgZuaOfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEh9RexF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEh9RexF"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-383cb94f742so309909a91.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785881107; x=1786485907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rOzAioLGGG++GJQkvk5B0jQols6BgWJDBStEvHLh5wU=;
        b=OEh9RexFaxDaF1n3zoqXUX2oIKTzkSjRplgGpFsN+yAFbpLqTVHxF+PCzDzzWTnZDF
         Qd9VDlZ5jkqeWo/G8GCdkNWWfWkhwB6avqV5QSSdPnzvHJyVIW99fnIIUXerhq1kqS9p
         I7bY4MvG8x84KcNJx9IfOJ4F1U95U7Yhd2nc4bJ3RLDCabG/n44RHlfOt8js542kQmZm
         chkEius4CnJKJHzzGJ6zetBl9e106B/Eiy3z8ghd4g/2PVmwx5K+kGWLC/smkJLFw/pY
         0mguoCuMnJXaBKBMdZmEZK446i+3+aKrwtorhutEAxN4op98y6+qArW8ODOpGZLm6SfD
         pEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785881107; x=1786485907;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOzAioLGGG++GJQkvk5B0jQols6BgWJDBStEvHLh5wU=;
        b=QkJg5WfQ1F5v5kWrFWMuKjhKTxFjb2NxIwq9uynsT2IR/x5xbvNYx/12lrMoRqLN1n
         25510SIeHwvsBSeTYyE+vsz7Vf0cgeCH1bWi4+8qs2Qybex6GSJwOG/nmIZNR1zf43cs
         trthu49952uUZ/yel07/C99icHRkOHwgdaeIF2QZU95iBjkB0a8RLLDqsVwtDuSGff41
         5TvcpjJFZRmy+Raw+C0+PgJrQbH4A44VRocuBBoqjVydA9FZ96e8CsSme9ISEuWoVl5M
         MY07WPFmh2hC6VEfSiWVFUIgKs1rjmS7Et6lU2Mf2JTD4gdb+Khpdu44hdpAqBwlvjbj
         Gwhg==
X-Gm-Message-State: AOJu0Yw0IdNkq3sXv3CCuFVs+UVsPGuuzGYumaFaE5oYxvHzRU2T9OZ3
	0DXpppx009i2zYWyrjP2kQbqM/ObdzxBYd/nrPiaaYz0SBRirxzMvRzY
X-Gm-Gg: AR+sD11qImJwVlPXnQoKsdNF8sXihDuZfmkvJppzjtGq4MaJsh5K58J10Pv6wt6Zsv+
	afKCky3y+14f0ip49sM7qfulzvt+JNZyBtKiK0gLswB1kjIYkO2CTfKchDUrbrqU7pXsaKP3Iia
	4DgMZs3gokMkBJ9J5Mm4+DdNDi3JoD9FBOUvXzJ7+fH5ZgpUhZPz2iacoXz/vkkSD/HcDfI/Gk0
	gITsc0RxqCKBR2b9KTFqblrppU9zFsezwJWnFmO1uPp+sCvts/KNfkOtFdtseG2EB6E+Io9hAiK
	BpZo/a/Sj1iVi9tfPaJkAlOAcW/BJKoufPxa4BSNn+vc05xTISKA66mSIpqrr25yLUEVtUfecOt
	q8SV5tAtA8U0HAgQ8mzy9jVBz3f666iN7PRVNBZeRgH5htu1bMmaaL4cA/Ag4XbwuzH9PTKz+qL
	oz7XlUufVftySryZoP6NlC69EdumwKpifWCt0+ccm3V1tcGpNKTU+QTXw0hUZzylX/4gZE6gtPW
	54sN50iqlfB8k0v
X-Received: by 2002:a17:90b:17c5:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-3903b9f3ee3mr1570609a91.0.1785881107065;
        Tue, 04 Aug 2026 15:05:07 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febffa549sm2096486a91.5.2026.08.04.15.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 15:05:06 -0700 (PDT)
Message-ID: <18a824b20c21a186687948133dc436f2852ce5f2.camel@gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi	
 <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Tejun Heo <tj@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>
Date: Tue, 04 Aug 2026 15:05:03 -0700
In-Reply-To: <4fefc832-b9b8-48d4-b472-82d6dea48354@linux.dev>
References: <20260803125518.2279340-1-memxor@gmail.com>
	 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
	 <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
	 <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
	 <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
	 <4d20aecf677f4aec3e8e70106d4bdbcb01902e69.camel@gmail.com>
	 <4fefc832-b9b8-48d4-b472-82d6dea48354@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 14:55 -0700, Ihor Solodrai wrote:
> On 8/4/26 2:34 PM, Eduard Zingerman wrote:
> > On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
> > > On 8/4/26 1:22 PM, Eduard Zingerman wrote:
> > > > On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
> > > > > > On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
> > > > > > > [...]
> > > > >=20
> > > > > >=20
> > > > > > So while I understand the reluctance to add KF_ARENA_ARG3..N, I=
 don't
> > > > > > think we want to introduce and support yet another mechanism fo=
r arena
> > > > > > argument annotations. If we do, we'll be stuck with a mess of
> > > > > > supporting two/three ways of doing the same thing for the fores=
eeable future.
> > > > >=20
> > > > > I think one major difference is that KF_ARENA_ARG* things were mo=
stly for
> > > > > annotating the vmlinux.h with the right address space label befor=
e, but didn't
> > > > > carry any semantic meaning for the kfunc's type checks.
> > > > >=20
> > > > > That changes with these suffixes though. The pointer will be tran=
slated when
> > > > > passed into the kfunc. IMO it would be odd to diverge for this pa=
rticular case,
> > > > > since we use suffixes for every other case where we constrain the=
 input type of
> > > > > the kfunc argument or give it special meaning.
> > > > >=20
> > > > > We also want to have similar annotation on struct_ops callbacks, =
where we also
> > > > > use suffixes, so it seemed better to keep it consistent.
> > > >=20
> > > > I agree that we should follow the principle of least surprise here =
and
> > > > use suffixes, as everything else uses suffixes as well.
> > >=20
> > > Ok, I understand the motivation. Let's say we use the suffixes.
> > >=20
> > > Should this enable getting rid of KF_ARENA* flags then? For the
> > > purposes of generating address_space(1), we can also just check the
> > > name suffix, no?
> >=20
> > That would be ideal, yes.
> >=20
> > > >=20
> > > > And yes, the __arena and KF_ARENA_ARG* annotations have different
> > > > semantics:
> > > > - __arena means that user space arena address is passed as is
> > > > - KF_ARENA_ARG* means that a user space address is converted
> > > > =C2=A0 to a kernel space address before passing.
> > >=20
> > > Also I am a little confused about whether we *need* to be able to
> > > express two distinct meanings of "arena pointer" or not?
> > >=20
> > > My understanding is that "arena pointer" is a feature of an arg type
> > > that has a single meaning: the pointer has one base in BPF world, and
> > > a different base when executed in the kernel.
> > >=20
> > > The things that are missing is auto-conversion (Tejun's RFC [1]) and =
more
> > > comprehensive support of PTR_TO_ARENA in the verifier.
> > >=20
> > > This is still only one "arena" annotation per arg. Do we actually nee=
d
> > > the proliferation of __arena, __arena__nullable and/or __arena_kern,
> > > __arena_user? Can't we have a single defined semantics of how arena
> > > pointers are supposed to work?
> > >=20
> > > I can imagine something like follows:
> > > =C2=A0 * arena pointers can not be null, check for nulls
> > > =C2=A0=C2=A0=C2=A0 before passing from BPF prog to the kernel
> >=20
> > We are deliberately lax when handling arena and don't do any kind of
> > value tracking there. So e.g. the following won't work:
> >=20
> > =C2=A0 if (foo->ptr) {
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 kfunc(foo->ptr);
> > =C2=A0 }
> >=20
> > Unless compiler decides to keep foo->ptr in a register. I'm not sure
> > whether enforcing non-null here from the verifier side is the right
> > call.
>=20
> I don't argue for this particular semantics, it's just an example.
>=20
> My point is to have unified defined rules for arena pointers, to allow
> making safe assumptions everywhere when working with them. Both as a user
> and in the kernel.
>=20
> >=20
> > > =C2=A0 * arena pointers are converted to the kernel space for
> > > =C2=A0=C2=A0=C2=A0 kfunc/struct_ops callback by the verifier
> > >=20
> > > With the documented and enforced semantics like this one way of
> > > annotating and one annotation should be enough.
> > >=20
> > > What am I missing?
> >=20
> > At the moment we have two consumers:
> > - Planned sched_ext related kfuncs that need kernel space pointers.
> > - Existing kfuncs with KF_ARENA_ARG:
> > =C2=A0 - bpf_arena_alloc_pages
> > =C2=A0 - bpf_arena_free_pages
> > =C2=A0 - bpf_arena_reserve_pages
> > =C2=A0 They, take a user space address. Looking at the code is appears =
that
> > =C2=A0 all three can be changed to handle kernel space address.
> > =C2=A0 On the other hand, neither of these *needs* the passed pointer t=
o be
> > =C2=A0 converted to a kernel side arena pointer. So that would be just =
some
> > =C2=A0 useless work.
> >=20
> > So there are two valid use cases.
>=20
> I think having more than one way of how to pass an arena pointer to
> the kernel will create more confusion than bring value.

That might be the case.

> It seems to me the existing bpf_arena_* kfuncs accept user space
> address for historical reasons (we just tried something that worked),
> not by design exactly.

What makes you think so?

> btw, Eduard, I get very confused by how you say "user space".. you
> mean the 32bit value representing the BPF arena pointer, right?

Nope:

  static long compute_pgoff(struct bpf_arena *arena, long uaddr)
  {
	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
  }

  static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 p=
age_cnt)
  {
	...
	if (uaddr & ~PAGE_MASK)
		return 0;

	pgoff =3D compute_pgoff(arena, uaddr);
	if (pgoff + page_cnt > page_cnt_max)
		return -EINVAL;
	...
   }

  __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32=
 page_cnt)
  {
	...
	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
  }

ptr__ign/uaddr is a 64-bit user space address.

>=20
> Anyways, I think we should converge on the approach to arena pointers
> handling before landing anything.
>=20
> Let's use __arena suffix as annotation mechanism, fine. But
> I really wouldn't like to end up with N annotations for each
> permutation of (non-)nullable and kern/user...
>=20
> I'll submit the resolve_btfids patches asap to not block on that.
>=20
>=20
> >=20
> > ...
