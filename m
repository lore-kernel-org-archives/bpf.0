Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE338BF97
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642904; cv=pass; b=HDvWWJLt5dHGaTPHgWjmT0UP69cqe2RNQkpOlV2yw/6hmM/42Cmcl7/PEbt8e2rLZnl1vEkIGgZrW0omolRAzeSe8bFLmC88CTrdASu8lf95RYYhuJxT2C/mrBZrH3iCChEbvmUMFZyS23H77GhVvPfi3GnGQXhZjBShm8PyXQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642904; c=relaxed/simple;
	bh=HaP3ICo6akmVnkqzweOOKfFAXd5JlmoBnPd5EHGBvuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU3tC50oG+L4lJg6ukwCCm2xoLNNu5HFXTp0Ao4+L/bRHz/YevUHX11tf7aWhCQPrUt7YczM91DN/j/0N0j/t+ks2qHxGeBZiT7uqXjMbdnPlDO1UFTaZxCTvJCkPmoYYa89Jwp84t2W62cW/QX8E5lZ6IlS2GM/qbaoqzACH1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4KWMJcN; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4KWMJcN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d0407aedd6so2843395ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786642902; cv=none;
        d=google.com; s=arc-20260327;
        b=ppiE/WqfnmXzWSZrDfAWjdgyMTbzZTyBbLxLlYk0WLqE3RjitI+5DF5uCxEVJn7ivZ
         AT+8JXv3SYcNGnX1kGVcJygXxKRvqzaeURRL8lXOMbJHENWHgOtSh9VQxu5yQ+bTIlX4
         ZJAMDdaVwMXTbQOKzvu/rqDRI0igywIcXW1YXsg/KZ9sOphuaHhsYJ9r4JVY0dzNh0Av
         RQfygaHDXK08cxR7WwOeBljzlvtJVu0+sgUBY90ZDDnT64EL6t+p2nt33A9DRo+EBtOF
         6hz3/EtvAQAlRR/fhDd/HskyIxtXqNMCM4QUaLD+JxYLaPQpBlscyHyl+wtf+seiCy9N
         SjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TbNfG4eGfwxgP1hsK4IvQRSXBfAkWQ+qf6LaMQZKBYQ=;
        fh=lrRs+27IvoRkJsxMFa2fum+DfD7KfZZ2DbGBg3BD/z0=;
        b=Y5MeLPcWktcRR11KLX9uzNbTi1O3aa2AxG8DwvBqBQORW/17+coXf100gCGW4De5h4
         dXWEWfRP4MVmgexytnH9L5CYxi08ZdFsE85yx5iAnRH9QDMiM6Yim5NP/h0yCVsnY8PI
         0CgWnnzMB0Mg1k1/ehgweF3N09oE9b7ks9bYzIQakxp2v7Vl29/QaTC1CBiLYyNAg1hG
         VbYbUtjAFe5hMgqyPnkJcLfw1C7AuMYiS+CdfdOaW6XDhuuUVMIpN4BGF4l9b3V7Jflb
         56ig287fObRQlMMVkcG4CJe45YpfbCTg+5CmasKihlE5gLAeJ/pIaf3R5bkCpFdW8A6b
         239w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642902; x=1787247702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TbNfG4eGfwxgP1hsK4IvQRSXBfAkWQ+qf6LaMQZKBYQ=;
        b=Z4KWMJcNEJ5mf152YXWj+JV1f+piwIDYk+9TD4ODoIQntFD0TfLh9cEx7PVdPPTjU7
         K8HseRVhDLF88R6dfrEscmfLjLJ7jkD3eEAt0vFkhjeyaKIFnM5/yQDHQg7fcGb/9JOG
         +DbQiJg4MZMDXJfLTWm5yU+RruobLSBbU0I7v+az1vVwqDcBAta91FPT271uh0zsZ73q
         uNii+kwLtz1H4LKxpilh0uXfTI98P6RhxChryy6YBdkJN4BijMP6biIkB9EU8XyIFOPo
         WrSeVq2l3OxFd2hyHIl1Id369BEWzpIwiSCyqIm3NetVI8UmhVu0DzBN0TKXneZ6izUN
         2FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642902; x=1787247702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbNfG4eGfwxgP1hsK4IvQRSXBfAkWQ+qf6LaMQZKBYQ=;
        b=o17Fh9eCMW2pHThw6XNXzrkXOCaKH0pbpXuG5HRqbVvrMRvMNql3pxGvy0TH9tnZEY
         8KsvXeR74X5a8gCVv6Vt/hly+uZXi1YxvqexED1pSN+4vy7SxG8FO/2XkaFVi6lQamWz
         f45GWcvhbfneRRGkScgCCkK33Szn8Nj7923Q0sa8+nnUBZ5b2x9m9ZxtZzTgmqV7o3/E
         358yx5zaDR6fHwabbZjRNIuofAiZ2mf3EDjGAy+NtCfxswuj+T1OBo5xdvyvlYYOm36S
         HGiv8R3kk4mRQ9Pwa7hHvqWr1tcQz9g4iuWPNKqkhBIXml3obOfxzfsKwzm73VRM3E7X
         yCyw==
X-Forwarded-Encrypted: i=1; AHgh+Rrso2llQW03r7BrPQm00t2R5OEaHeD+AVBOKdlcbs8FuDwP2n+8iP2l/E9IMX9gkdvUAqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3meSMZJk8aLndbpZRpgD2khXPl+Kv1cBNZ8k7QbyvCzFodz4p
	VGEcnmQ38i3WOV+oHwUvk+ozzpXYPVVxkREAYv0dfHAOBib/s2LP/Egpvfy1FYSyWBRi31RYz2d
	REqfXJsFUGW5v447gpphl7tYklLeXfXk=
X-Gm-Gg: AR+sD12EpJnFh/qsr5DSolwMcpFRRX8OU1SDQM+DoZQ160Vm+upo5h6VG24kFT96JS9
	0RFhFMK5TzTxRHm2UlMtn4f6d0BjkX6vPxdo9OCyACyw1Gn+ukEBUKddFiLLk908nt01ImXqPVG
	Hk1GdptN8MDrq4xMZI4YV2H1vnamYz+ldoSDOKC3y8QFGS5r2WpAx0dR4OEYbBjR4GAPp2rULMc
	qj/yT3nL3IMOxm7qnclXuc6kY6ureV3nhZybcx1q81A76jIhrDVaVFC1wIkxbCekn0efnqUlO8W
	rwyTdpX9ty64t+fRbjMOIcGHe5Lz4mSTquvFghcHHY8MxCxcyStbkA/cwK9ZU3kK2GejKrBpL6n
	LCy4eAM72vc7SWgpYm7OSIMo7RHypgvxC/HbHMhFZO6A7GzJgEZtP
X-Received: by 2002:a05:6a20:2587:b0:3bf:983d:e9b4 with SMTP id
 adf61e73a8af0-3cc55321b6fmr9108682637.33.1786642901470; Thu, 13 Aug 2026
 10:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813152324.97937-6-leon.hwang@linux.dev> <501ee3521cfb2843d9dd1b8bc1823c3816f010e08274099664137b5989c3bed2@mail.kernel.org>
In-Reply-To: <501ee3521cfb2843d9dd1b8bc1823c3816f010e08274099664137b5989c3bed2@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 10:41:26 -0700
X-Gm-Features: AUfX_myoePsipu-KdvoHqZKBu9Dg7zbZTLKChm_OPi5N3-SJxIGoCDI0EA4KQDM
Message-ID: <CAEf4BzZ3OeeOd5mBke4vp6JFNd5YRL5xK7a9h8fZ+4dwDRXnpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 05/10] libbpf: Add support for global percpu data
To: bot+bpf-ci@kernel.org
Cc: leon.hwang@linux.dev, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, qmo@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:26=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_i=
nternal.h
> > index 0425691877521..6c5ad6c55e8a6 100644
> > --- a/tools/lib/bpf/bpf_gen_internal.h
> > +++ b/tools/lib/bpf/bpf_gen_internal.h
>
> [ ... ]
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 514e4e9daa825..e574870fb7169 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
> > @@ -1839,6 +1842,8 @@ static size_t bpf_map_mmap_sz(const struct bpf_ma=
p *map)
> >       switch (map->def.type) {
> >       case BPF_MAP_TYPE_ARRAY:
> >               return array_map_mmap_sz(map->def.value_size, map->def.ma=
x_entries);
> > +     case BPF_MAP_TYPE_PERCPU_ARRAY:
> > +             return map->def.value_size;
> >       case BPF_MAP_TYPE_ARENA:
> >               return page_sz * map->def.max_entries;
>
> This isn't a bug, but bpf_map_mmap_sz() is documented as returning the
> length to pass to mmap()/munmap()/mprotect(), and both other arms return
> page-granular lengths (array_map_mmap_sz() rounds up to page_sz, ARENA
> multiplies by page_sz).
>
> The new PERCPU_ARRAY arm returns the raw, unrounded value_size. This
> creates an asymmetry visible in bpf_map__set_value_size(), which compares
> mmap_old_sz =3D bpf_map_mmap_sz(map) (unrounded for percpu) against
> mmap_new_sz =3D array_map_mmap_sz(size, max_entries) (page-rounded), so e=
ven
> a no-op resize performs a redundant mmap() + memcpy() + munmap() cycle.
>
> Would using array_map_mmap_sz(map->def.value_size, map->def.max_entries)
> for the PERCPU_ARRAY case be more consistent with the ARRAY case?
>
> [ ... ]
>
> > @@ -1866,7 +1871,8 @@ static int bpf_map_mmap_resize(struct bpf_map *ma=
p, size_t old_sz, size_t new_sz
> >       return 0;
> >  }
> >
> > -static char *internal_map_name(struct bpf_object *obj, const char *rea=
l_name)
> > +static char *internal_map_name(struct bpf_object *obj, const char *rea=
l_name,
> > +                            enum libbpf_map_type type)
> >  {
> >       char map_name[BPF_OBJ_NAME_LEN], *p;
> >       int pfx_len, sfx_len =3D max((size_t)7, strlen(real_name));
> > @@ -1907,8 +1913,11 @@ static char *internal_map_name(struct bpf_object=
 *obj, const char *real_name)
> >       if (sfx_len >=3D BPF_OBJ_NAME_LEN)
> >               sfx_len =3D BPF_OBJ_NAME_LEN - 1;
> >
> > -     /* if there are two or more dots in map name, it's a custom dot m=
ap */
> > -     if (strchr(real_name + 1, '.') !=3D NULL)
> > +     /*
> > +      * Don't prefix the bpf_object name if this is a custom dot map
> > +      * (containing two or more dots) or a percpu data map.
> > +      */
> > +     if (strchr(real_name + 1, '.') !=3D NULL || type =3D=3D LIBBPF_MA=
P_PERCPU)
> >               pfx_len =3D 0;
> >       else
> >               pfx_len =3D min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1, s=
trlen(obj->name));
>
> Emil Tsalapatis raised a design question in v10: Why does .percpu get
> special treatment in internal_map_name() instead of following the same
> prefixing logic as .data and .rodata?
>
> He noted "it seems like we're singling out the .percpu section for highly
> nonbvious reasons" and asked "@Andrii Wdyt?" You responded that you prefe=
r
> excluding PERCPU "to avoid the legacy naming convention for new internal
> maps" but said "Let us wait for Andrii's comment."
>
> Andrii didn't publicly respond to this design question in the lore thread=
s,

ok, wow, being shamed by AI... I did respond on v10, and yes, I think
passing type and basing decisions on that is better going forward, no
need for name-based checks.

> and v11/v12 proceeded with the same special treatment. The related
> map_uses_real_name() function also treats PERCPU differently (always
> returns true for PERCPU, while DATA/RODATA check against their base secti=
on
> names).
>
> Should this naming convention uniformity concern be addressed, or is ther=
e
> a technical reason for .percpu's special handling that could be documente=
d
> in the comment?
>
> [ ... ]
>
> > @@ -1941,6 +1950,13 @@ static bool map_is_mmapable(struct bpf_object *o=
bj, struct bpf_map *map)
> >       if (!map->btf_value_type_id)
> >               return false;
> >
> > +     /*
> > +      * The internal PERCPU maps are not mmapble because the underlyin=
g
> > +      * percpu_array maps do not have mmap support.
> > +      */
> > +     if (map->libbpf_type =3D=3D LIBBPF_MAP_PERCPU)
> > +             return false;
> > +
>
> This isn't a bug, but there's a typo: "mmapble" should be "mmappable".
>
> [ ... ]
>
> > @@ -5293,18 +5326,20 @@ static int
> >  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_m=
ap *map)
> >  {
> >       enum libbpf_map_type map_type =3D map->libbpf_type;
> > +     bool is_percpu =3D map_type =3D=3D LIBBPF_MAP_PERCPU;
> > +     const __u64 update_flags =3D is_percpu ? BPF_F_ALL_CPUS : 0;
> >       int err, zero =3D 0;
> >       size_t mmap_sz;
> >
> >       if (obj->gen_loader) {
> >               bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps=
,
> > -                                      map->mmaped, map->def.value_size=
);
> > +                                      map->mmaped, map->def.value_size=
, update_flags);
> >               if (map_type =3D=3D LIBBPF_MAP_RODATA || map_type =3D=3D =
LIBBPF_MAP_KCONFIG)
> >                       bpf_gen__map_freeze(obj->gen_loader, map - obj->m=
aps);
> >               return 0;
> >       }
> >
> > -     err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
> > +     err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, update_f=
lags);
> >       if (err) {
> >               err =3D -errno;
> >               pr_warn("map '%s': failed to set initial contents: %s\n",
>
> [ ... ]
>
> > @@ -5349,6 +5384,13 @@ bpf_object__populate_internal_map(struct bpf_obj=
ect *obj, struct bpf_map *map)
> >                       return err;
> >               }
> >               map->mmaped =3D mmaped;
> > +     } else if (is_percpu) {
> > +             if (mprotect(map->mmaped, mmap_sz, PROT_READ)) {
> > +                     err =3D -errno;
> > +                     pr_warn("map '%s': failed to mprotect() contents:=
 %s\n",
> > +                             bpf_map__name(map), errstr(err));
> > +                     return err;
> > +             }
> > +     } else if (map->mmaped) {
> >               munmap(map->mmaped, mmap_sz);
> >               map->mmaped =3D NULL;
>
> This isn't a bug, but unlike every other internal map, the percpu
> initialization image is deliberately kept mapped and turned read-only wit=
h
> mprotect() instead of being munmap()ed.
>
> The skeleton pointer that bpftool generates for this map is a plain,
> non-const 'struct <obj>__percpu *', so a perfectly ordinary post-load
> assignment such as 'skel->percpu->var =3D 1;' now faults with SIGSEGV in =
the
> user process rather than failing in a diagnosable way.
>
> The behaviour is intentional and described in the commit message, but wou=
ld
> a const-qualified generated pointer (as is done for .rodata) express the

Is it done for .rodata, really?... As far as I can see, .rodata are
still non-const because they are expected to be set before load. Eh,
AI...

> restriction at compile time instead of at runtime?
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/317164=
47858
