Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789BE1350CC
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744047; cv=none; b=R/iHGCDxoMZYIqBPdxWLFY+uF2hunWRDmCyg5l6eY4QshkWbL/oXwyN3LZkvXELAUOTE4YjUExveuAP0KHUHedMHH4dC9XfODJNcPa7biatbFwJumpTqIqyQt1a5fZcwBNNU+jmbTgCJ/hrrojBAjixaVs0eVy8N75ujASl4ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744047; c=relaxed/simple;
	bh=McwZU4c2Sl+z0GuvkLcYT+tvKQHp48oJn4Z8E/M9d6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7Vj6uBxXGMeYX36q0AMzG4uXu8bLSkzdOTHloGMVF7mEQofAFM6R+6UhRzo1PU/9nXF3sq3rmaAUC1NaQGjtle59Ptafb+S88hziqHRtuW0f8v1QLJe3GnSGx2nQqOxIFdDqzkc2jG7kmLJN8Up7YkH3Yd7wH3/8HrAhDTZduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkVpVxqp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkVpVxqp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e4f15710aso1052474f8f.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709744044; x=1710348844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se4GiN1HXTq1m+cMhZb5UFy+KTnynNTSn98tlX/0SLw=;
        b=DkVpVxqpi81z8gvT2RU2qgdzX01RAf4S5IkJ70KcTh/VnbWVoeUWTF4enZQ4WMkdOp
         7guJlIopbTLUiGjrRc9+Qz+kpcZuBNmDqqoVZmyV+PgmOzSkfm9wJIZJGJejm8Ea/Ca8
         0EdEpp1IMZDGgtqLVRa2aUgdxjZnQ/SwdkKqtwyAjN962sH3nOmVo7ZNCtw1FSkevVpF
         Ns//p7E385qJ7BhlhTbS53ymHgB8gXz6sktMhf2mwxb6uOqbFK/XhstTJsYr/BFZmxNj
         fZTpzxGLdtRcP5ll5KANz8ZcIj9Mdnnrh7d1CqbVIWfwoyl13IGrIdUWbe94Ye/b6KHy
         h31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709744044; x=1710348844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Se4GiN1HXTq1m+cMhZb5UFy+KTnynNTSn98tlX/0SLw=;
        b=woQl61cxHcIwOQJWeEKqkNW41RHXt2gf+Pmls7SYGc1M2cQkr1SSc1CH0C3ylUQniE
         0Cd9iZcbPDdJRu6uGOCLW/ujuCWxLrRNgo/PRQwgqpy08+fZc+eJQhR4vBAEhAPK7Irq
         aCcVLMGzwIsYKuDdM3cGhvL9i2gMcrV3saCZjU4tqZ1Xt283sHTNy8qF/RaWOtNbtsGO
         CVd5iyAxQLzeS+A6UhxGBnPEjKalCHicWJRQ+rh+qZ+i1iEGM0bMFsUgLWw1SX4g56L8
         YkJzOIH+pA3yOgC4tnY9u/nnLSB5To+9cBUEimuxlnhHk60/3mwpnENWJHWpOwlOWh00
         6zXg==
X-Forwarded-Encrypted: i=1; AJvYcCXsnJlrRfur9q/BFLLybMSql3ziLs5C5D9U7/izptL72rrettKS47SMXGMlwj8+498gG8tZKazxw1vQ2nRiJWizUsWP
X-Gm-Message-State: AOJu0YwELCdd6UdW1ATy0PYFwRRLygN3G5cA7Y1AwwfSKyv45J7sZpd1
	xaot9oPAE0m++tKck3E3DVeFkvZT/IFEemqx4Jj9TNw7lDF+F4h8uSjMdoFnTyYGkfILXkgq53j
	6KgUJNhs03LUl2i0TruzQ1pAPQPE=
X-Google-Smtp-Source: AGHT+IHwANhvvTzlrsEeRIrICdvn3DIp1tfbzcIe6nMqHiaMCwE5+5daJP2bz48fSVJe/zno4jPY3LfN9Ph2OyIooeU=
X-Received: by 2002:adf:e045:0:b0:33e:cc6:8485 with SMTP id
 w5-20020adfe045000000b0033e0cc68485mr10677706wrh.47.1709744043595; Wed, 06
 Mar 2024 08:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229112250.13723-1-toke@redhat.com> <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
 <65e10367cb393_33719208c2@john.notmuch> <878r32b04u.fsf@toke.dk>
 <CAADnVQLzVJRut0v2dQPbBUDW971Fd-EjkOf0pyLh5-W7wYwiYA@mail.gmail.com>
 <87plwa6tgv.fsf@toke.dk> <CAADnVQJ=NGbdQXOo=Eu4AG2m=AMJLYF+Gyqh99_YHGy8=EL_Nw@mail.gmail.com>
 <87ttljtzuo.fsf@toke.dk>
In-Reply-To: <87ttljtzuo.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 08:53:52 -0800
Message-ID: <CAADnVQJgk7oHnwH5qmbKFchpTQSTAc8ByMyx_iA_XYmkL-YNmw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit arches
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Mon, Mar 4, 2024 at 5:02=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> >>
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >>
> >> > On Fri, Mar 1, 2024 at 4:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> >> >>
> >> >> John Fastabend <john.fastabend@gmail.com> writes:
> >> >>
> >> >> > Alexei Starovoitov wrote:
> >> >> >> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=
=B8rgensen <toke@redhat.com> wrote:
> >> >> >> >
> >> >> >> > The hashtab code relies on roundup_pow_of_two() to compute the=
 number of
> >> >> >> > hash buckets, and contains an overflow check by checking if th=
e resulting
> >> >> >> > value is 0. However, on 32-bit arches, the roundup code itself=
 can overflow
> >> >> >> > by doing a 32-bit left-shift of an unsigned long value, which =
is undefined
> >> >> >> > behaviour, so it is not guaranteed to truncate neatly. This wa=
s triggered
> >> >> >> > by syzbot on the DEVMAP_HASH type, which contains the same che=
ck, copied
> >> >> >> > from the hashtab code. So apply the same fix to hashtab, by mo=
ving the
> >> >> >> > overflow check to before the roundup.
> >> >> >> >
> >> >> >> > The hashtab code also contained a check that prevents the tota=
l allocation
> >> >> >> > size for the buckets from overflowing a 32-bit value, but sinc=
e all the
> >> >> >> > allocation code uses u64s, this does not really seem to be nec=
essary, so
> >> >> >> > drop it and keep only the strict overflow check of the n_bucke=
ts variable.
> >> >> >> >
> >> >> >> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing=
 overflow and zero size checks")
> >> >> >> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.c=
om>
> >> >> >> > ---
> >> >> >> >  kernel/bpf/hashtab.c | 10 +++++-----
> >> >> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >> >> >> >
> >> >> >> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> >> >> > index 03a6a2500b6a..4caf8dab18b0 100644
> >> >> >> > --- a/kernel/bpf/hashtab.c
> >> >> >> > +++ b/kernel/bpf/hashtab.c
> >> >> >> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(unio=
n bpf_attr *attr)
> >> >> >> >                                                           num_=
possible_cpus());
> >> >> >> >         }
> >> >> >> >
> >> >> >> > -       /* hash table size must be power of 2 */
> >> >> >> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_e=
ntries);
> >> >> >> >
> >> >> >> >         htab->elem_size =3D sizeof(struct htab_elem) +
> >> >> >> >                           round_up(htab->map.key_size, 8);
> >> >> >> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(un=
ion bpf_attr *attr)
> >> >> >> >                 htab->elem_size +=3D round_up(htab->map.value_=
size, 8);
> >> >> >> >
> >> >> >> >         err =3D -E2BIG;
> >> >> >> > -       /* prevent zero size kmalloc and check for u32 overflo=
w */
> >> >> >> > -       if (htab->n_buckets =3D=3D 0 ||
> >> >> >> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
> >> >> >> > +       /* prevent overflow in roundup below */
> >> >> >> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
> >> >> >> >                 goto free_htab;
> >> >> >>
> >> >> >> No. We cannot artificially reduce max_entries that will break re=
al users.
> >> >> >> Hash table with 4B elements is not that uncommon.
> >> >>
> >> >> Erm, huh? The existing code has the n_buckets > U32_MAX / sizeof(st=
ruct
> >> >> bucket) check, which limits max_entries to 134M (0x8000000). This p=
atch
> >> >> is *increasing* the maximum allowable size by a factor of 16 (to 2.=
1B or
> >> >> 0x80000000).
> >> >>
> >> >> > Agree how about return E2BIG in these cases (32bit arch and overf=
low) and
> >> >> > let user figure it out. That makes more sense to me.
> >> >>
> >> >> Isn't that exactly what this patch does? What am I missing here?
> >> >
> >> > I see. Then what are you fixing?
> >> > roundup_pow_of_two() will return 0 and existing code is fine as-is.
> >>
> >> On 64-bit arches it will, yes. On 32-bit arches it ends up doing a
> >> 32-bit left-shift (1UL << 32) of a 32-bit type (unsigned long), which =
is
> >> UB, so there's no guarantee that it truncates down to 0. And it seems =
at
> >> least on arm32 it does not: syzbot managed to trigger a crash in the
> >> DEVMAP_HASH code by creating a map with more than 0x80000000 entries:
> >>
> >> https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
> >>
> >> This patch just preemptively applies the same fix to the hashtab code,
> >> since I could not find any reason why it shouldn't be possible to hit
> >> the same issue there. I haven't actually managed to trigger a crash
> >> there, though (I don't have any arm32 hardware to test this on), so in
> >> that sense it's a bit theoretical for hashtab. So up to you if you wan=
t
> >> to take this, but even if you don't, could you please apply the first
> >> patch? That does fix the issue reported by syzbot (cf the
> >> reported-and-tested-by tag).
> >
> > I see.
> > Since roundup_pow_of_two() is non deterministic on 32-bit archs,
> > let's fix them all.
> >
> > We have at least 5 to fix:
> > bloom_filter.c:                 nr_bits =3D roundup_pow_of_two(nr_bits)=
;
> > devmap.c:               dtab->n_buckets =3D
> > roundup_pow_of_two(dtab->map.max_entries);
> > hashtab.c:      htab->n_buckets =3D roundup_pow_of_two(htab->map.max_en=
tries);
> > stackmap.c:     n_buckets =3D roundup_pow_of_two(attr->max_entries);
> >
> > hashtab.c:           htab->map.max_entries =3D roundup(attr->max_entrie=
s,
> >                                                 num_possible_cpus());
> >
> > bloom_filter looks ok as-is,
> > but stack_map has the same issue as devmap and hashtab.
> >
> > Let's check for
> > if (max_entries > (1u << 31))
> > in 3 maps and that should be enough to cover all 5 cases?
> >
> > imo 1u << 31 is much easier to visualize than U32_MAX/2+1
> >
> > and don't touch other checks.
> > This patch is removing U32_MAX / sizeof(struct bucket) check
> > and with that introduces overflow just few lines below in bpf_map_area_=
alloc.
>
> Are you sure there's an overflow there? I did look at that and concluded
> that since bpf_map_area_alloc() uses a u64 for the size that it would
> not actually overflow even with n_buckets =3D=3D 1<<31. There's a check i=
n
> __bpf_map_area_alloc() for the size:
>
>         if (size >=3D SIZE_MAX)
>                 return NULL;
>
> with
>
> #define SIZE_MAX        (~(size_t)0)
>
> in limits.h. So if sizeof(size_t) =3D=3D 4, that check against SIZE_MAX
> should trip and the allocation will just fail; but there's no overflow
> anywhere AFAICT?

There is an overflow _before_ it calls into bpf_map_area_alloc().
Here is the line:
        htab->buckets =3D bpf_map_area_alloc(htab->n_buckets *
                                           sizeof(struct bucket),
                                           htab->map.numa_node);
that's why we have:
if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
before that.


> Anyway, I'm OK with keeping the check; I'll respin with the changed
> constant and add the check to stackmap.c as well.

Thanks!
