Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF83A254D
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883154; cv=pass; b=IEfFekU5xQovOCncXz6juLem+Zsaiw7QRiVnyMkUffFEpGnHzTIIoZ5R2rZNsdb378lvzxbKdCibaIm+i8POh//9RcQFvzWY+AOVZ/PmahvQpwVwzv+AywDxkxg84DgUI384oUTj0fXbPtFcWJbD4uGzPTQna4P8kPmJUzg00TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883154; c=relaxed/simple;
	bh=JlZEjqsfLVq1gnw4VpMnsuKskwu6dlc+rhxlhpUB8ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lydUMdV7/5XosB1QNb9EhGUSaNKfatv366aDgcWbHl97NXvScLFDBRinqrrfGvq3xfOsfLPTbAsilu1l6dvEX1/hHizYylzXPm3fjcNnY67ayG2w/sUpiQAh+mZyqvvG+AXEyl6sBIeAsv4aayjym54UdLkkE7h1rOT3DuNlZPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHDqvn/T; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHDqvn/T"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84867f07d63so378011b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 15:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785883152; cv=none;
        d=google.com; s=arc-20260327;
        b=BhU6mOa6+TJKvEY3fpLVCoUBh+s7xvrWrzrQ/WDbec0kyqcSC8xRO7MCfNS0DUxjnI
         d+6JRim4sXK4vVsqSLyY1u9wCRZMbGn6pveq3JvPZzU9ybjLfMYFfxNWWozS3PCdcqAP
         U6InXZh6AvrUbWeJQGBcqNhur91CDCx9M3EArPuZCpN6rVk1lvVj+0GRxIZ6Ljo49YMk
         gOFBnBRe/lf0miUW2a+YnjTOHKBXK9y0w4rHS0yquUgsY5nCVwaMHZt8B6jGiyxPSeGM
         kuP5CjI6W6hwFi+DnuuUKvWlOuG85cPewnIeydz+6hsWo1o52tgEDkhhjAejE9p9u9M4
         Sdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LUdbwLBXMVcF6uR607tn8gFkqF+y7kOdZBcVEgFeZ1g=;
        fh=yzqaIh6w6QHZGm7NH7kiIWoSpnlp6P3ng4jzt4Pb8l4=;
        b=Z7oqR0IT4X+eIVAxx9kNcvps5wfwfRTVEOPrJHt4frF1jRfMxYCtDBddE98bXUmBWv
         3JcfyDXavTz9UcchVG0cNSpp7MvcpFOi9WIHbC/5b6Kmt/5T7QD39LBKydIrUU5d1AcL
         nv6LYP9Y3P0dqq0LvliMVnstOJsYJYbeaWZCy4QhH869wjcRXzbzZULEgkEDZRGZM8V5
         b4o3s3/U+Soi7xttMeuKhh4RXiDpp2iaNLnjeT5Ua4rOGWpdufePWbt8hzboKNXzg2PE
         fL/TI0FQ0FoIWgVG2rWpLfLhDq5sWJ29vBb77wezPa6tKG9VcyHYJluRiZgQKQYYqnHi
         qxTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785883152; x=1786487952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LUdbwLBXMVcF6uR607tn8gFkqF+y7kOdZBcVEgFeZ1g=;
        b=AHDqvn/Tdazy2DR3RpUJFudyjapWH+wXRxWH6Ft7J6UXCr4R95IKiSLJ70dl+Lnd5A
         ExbSDznt/tj7jcrk4QZ0eNiaJLV1wC9N7C/tANHoTKDonpbsC1emehO0qLQvf3Q7dWcR
         EVUoKWJEhiZG8msQ6uhdrQeEvM9NW03q4o7P7+SUDusWiZ7DV+ELRKQ8Gk6mz/mYv4H4
         BTdHia7fhzCThE8awTL77ng3RuxpThLSHdOxP0wSPH7FLPX252+6jRr3JuBRg06cdvDy
         0KbxW6AI9dKXwUVHkX+zfv78IibRZozMtqxdBLCW+4J+I6fGxz6y2aWHZ/JgATnn3V0C
         c2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785883152; x=1786487952;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUdbwLBXMVcF6uR607tn8gFkqF+y7kOdZBcVEgFeZ1g=;
        b=ml4KDF0WhAQ/7Qc9gj/5XJ7uJAIuHGSHTRi51f/B+hvLNHvm8qK3Gk1SH3jDfW8q9T
         UDiZET/gXN+lJ7/nilYZqZq/GdEI1HG8MPsd45tTgcVEj2b4peYVtBDJeLzws13RrwBF
         dOIHMLo07LbeCoc2ukaEKLqckie7Yh8GVdHKzF8hw1V1BsQHKowvU5rAOnbV6f79IbSP
         SpvtjJtlcdA3bxkMWEZ9bm2RqdtObw0kitIlkESAdk4KdqUjy6WI+PFuDUpfepPs4p/y
         AnoVlWMEG3QFwl2c6ldoghU18TGQGJ0vJ+Iz4x6B6pynI+W6JdmkwUjTsXcyhcTypWx5
         alFw==
X-Forwarded-Encrypted: i=1; AHgh+RoWKcMJgRIfAWCkQcgUpcaAC8D6jEQo+e/6FyJT/4SzBKsQLoQ82sJoiJ3Ri3fX2RgnRFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QLoOUaBG6KFGW7f9U0iIYH4sc0+pO9/GuXC6IeaRo5rPJxZq
	1Lgs6flVI7C4Xs/wtggBNvgDti2nG7HZ1QQwm5d9T17/7NcdrzDRF24kft/SFa5l3DlhLPHPHeq
	iEM/rRj4qetvzuTjFUIUadd3QpmAd2gS5QA==
X-Gm-Gg: AR+sD11l4Lh/r8zuLEhLkmjEQnTDiUYFku2fr3Osx4GI/1m9nf3AqsmPxz73Zrxzu/J
	7Dkighl8VxrofhljrOmSMFSH+kV+GBYF5r98fsvkaHurxNp+iSi3vBvOZy6PyCBoRHlBzs3MDaz
	m2MD12OgRmk+gReb4yneJ/51/lxUzep7Aan1qTRG5TDchXEp8B2y4+9RFy4a2i2gaametfgWyGs
	hLIk7jbn6MDGZeiTOJBhWqIkjYNXE8GrwxkH2eTebSuywoDIeYVFOOZkFqBy2CjEZF40Pz6eqpT
	LSPZsuXMnIAC+qM9YBpdI1JuY2O3dye8RPJk1zq0aThQc68O/fZqmikk1U8ZyDD4FG/9N3bPL1y
	bAw0qQhTWWUBZ9o5DgaA/MgFZPiUfa130256V0nyubg==
X-Received: by 2002:a05:6a00:12ca:b0:845:e8b9:347 with SMTP id
 d2e1a72fcca58-84f2dfc5b61mr1942283b3a.13.1785883151828; Tue, 04 Aug 2026
 15:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715153254.92010-1-leon.hwang@linux.dev> <20260715153254.92010-5-leon.hwang@linux.dev>
 <DK167GCPUAJE.3GGIPEE5MIX3G@etsalapatis.com> <39e09b62-53b4-4f3a-928a-1fdeac8c7dc4@linux.dev>
In-Reply-To: <39e09b62-53b4-4f3a-928a-1fdeac8c7dc4@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Aug 2026 15:38:57 -0700
X-Gm-Features: AUfX_mwjaukr5y4EtOpVncveiSyKWnlvIRQQJrJCqYL5tHOXcu-Pz67lPbswVBk
Message-ID: <CAEf4BzaNo4y4ZhLT9ZAcOGx3UOtiTRZkHXy0-TGJjvAV39w82g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 4/9] libbpf: Add support for global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 10:00=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 18/7/26 05:39, Emil Tsalapatis wrote:
> > On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
>
> [...]
>
> >>
> >>  struct elf_sec_desc {
> >> @@ -1839,6 +1842,8 @@ static size_t bpf_map_mmap_sz(const struct bpf_m=
ap *map)
> >>      switch (map->def.type) {
> >>      case BPF_MAP_TYPE_ARRAY:
> >>              return array_map_mmap_sz(map->def.value_size, map->def.ma=
x_entries);
> >> +    case BPF_MAP_TYPE_PERCPU_ARRAY:
> >> +            return map->def.value_size;
> >>      case BPF_MAP_TYPE_ARENA:
> >>              return page_sz * map->def.max_entries;
> >>      default:
> >> @@ -1866,7 +1871,8 @@ static int bpf_map_mmap_resize(struct bpf_map *m=
ap, size_t old_sz, size_t new_sz
> >>      return 0;
> >>  }
> >>
> >> -static char *internal_map_name(struct bpf_object *obj, const char *re=
al_name)
> >> +static char *internal_map_name(struct bpf_object *obj, const char *re=
al_name,
> >> +                           enum libbpf_map_type type)
> >
> > We can avoid passing the type here by testing against ".percpu" since
> > that's how we are deriving the map type in the first place. But more
> > importantly:
> >

I think type is cleaner, because it's not just .percpu, but also
.percpu.whateveryouwant, so having type is cleaner, IMO.

> >>  {
> >>      char map_name[BPF_OBJ_NAME_LEN], *p;
> >>      int pfx_len, sfx_len =3D max((size_t)7, strlen(real_name));
> >> @@ -1907,8 +1913,11 @@ static char *internal_map_name(struct bpf_objec=
t *obj, const char *real_name)
> >>      if (sfx_len >=3D BPF_OBJ_NAME_LEN)
> >>              sfx_len =3D BPF_OBJ_NAME_LEN - 1;
> >>
> >> -    /* if there are two or more dots in map name, it's a custom dot m=
ap */
> >> -    if (strchr(real_name + 1, '.') !=3D NULL)
> >> +    /*
> >> +     * Don't prefix the bpf_object name if this is a custom dot map
> >> +     * (containing two or more dots) or a percpu data map.
> >> +     */
> >> +    if (strchr(real_name + 1, '.') !=3D NULL || type =3D=3D LIBBPF_MA=
P_PERCPU)
> >
> > Is there a reason we don't use the exact same logic as the other
> > internal maps here? I understand that a lot of the conventions around
> > the naming are there for legacy reasons, but it seems like we're
> > singling out the .percpu section for highly nonbvious reasons. Imo we
> > should consider doing the same prefixing for a bare ".percpu" section
> > that we do for the other internal ones. At the very least, there needs
> > to be some explanation as to why .percpu gets special treatment.
>
>
> I prefer passing 'type'. Excluding _PERCPU here is to avoid the legacy
> naming convention for new internal maps.


+1

and it's not that .percpu gets special treatment, it's all the legacy
maps that have special treatment

>
> >
> > @Andrii Wdyt?
> >
> >>              pfx_len =3D 0;
> >>      else
> >>              pfx_len =3D min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1, s=
trlen(obj->name));
> >> @@ -1938,7 +1947,7 @@ static bool map_is_mmapable(struct bpf_object *o=
bj, struct bpf_map *map)
> >>      struct btf_var_secinfo *vsi;
> >>      int i, n;
> >>
> >> -    if (!map->btf_value_type_id)
> >> +    if (!map->btf_value_type_id || map->libbpf_type =3D=3D LIBBPF_MAP=
_PERCPU)
> >>              return false;
> >
> > Nit: These are two separate checks rolled into one, and each one checks
> > a different thing. THe type check against MAP_PERCPU merits a comment a=
s
> > well: It's the only internal section that is not really mappable becaus=
e
> > there's no way to represent it as userspace state.
>
>
> Ack.
>
> Will add a new iff for libbpf_type check with a comment.

yep, but don't overdo comments, it's not that hard to understand why
per-cpu map is not mmapable

>
> >
> >>
> >>      t =3D btf__type_by_id(obj->btf, map->btf_value_type_id);
> >> @@ -1962,6 +1971,7 @@ static int
> >>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map=
_type type,
> >>                            const char *real_name, int sec_idx, void *d=
ata, size_t data_sz)
> >>  {
> >> +    bool is_percpu =3D type =3D=3D LIBBPF_MAP_PERCPU;
> >>      struct bpf_map_def *def;
> >>      struct bpf_map *map;
> >>      size_t mmap_sz;
> [...]
>
> >> @@ -4944,7 +4970,7 @@ static int map_fill_btf_type_info(struct bpf_obj=
ect *obj, struct bpf_map *map)
> >>
> >>      /*
> >>       * LLVM annotates global data differently in BTF, that is,
> >> -     * only as '.data', '.bss' or '.rodata'.
> >> +     * only as '.data', '.bss', '.percpu' or '.rodata'.
> >>       */
> >>      if (!bpf_map__is_internal(map))
> >>              return -ENOENT;
> >> @@ -5293,18 +5319,30 @@ static int
> >>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_=
map *map)
> >>  {
> >>      enum libbpf_map_type map_type =3D map->libbpf_type;
> >> +    bool is_percpu =3D map_type =3D=3D LIBBPF_MAP_PERCPU;
> >
> > Nit: If we do
> >       __u64 update_flags =3D is_percpu ? BPF_F_ALL_CPUS : 0;
> >
> > we can declare the variable as const and ...
> >
> >> +    __u64 update_flags =3D 0;
> >>      int err, zero =3D 0;
> >>      size_t mmap_sz;
> >>
> >> +    if (is_percpu) {
> >> +            if (!obj->gen_loader && !kernel_supports(obj, FEAT_PERCPU=
_DATA)) {
> >> +                    pr_warn("map '%s': kernel does not support percpu=
 data.\n",
> >> +                            bpf_map__name(map));
> >> +                    return -EOPNOTSUPP;
> >> +            }
> >> +
> >> +            update_flags =3D BPF_F_ALL_CPUS;
> >> +    }
> >
> > ... we can collapse the above into a single nested level:
> >
> >       if (is_percpu && !obj->gen_loader && !kernel_supports(obj, FEAT_P=
ERCPU_DATA)) {
> >               ...
> >       }
>
> Good point.
>
> >
> >> +
> >>      if (obj->gen_loader) {
> >>              bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps=
,
> >> -                                     map->mmaped, map->def.value_size=
);
> >> +                                     map->mmaped, map->def.value_size=
, update_flags);
> >>              if (map_type =3D=3D LIBBPF_MAP_RODATA || map_type =3D=3D =
LIBBPF_MAP_KCONFIG)
> >>                      bpf_gen__map_freeze(obj->gen_loader, map - obj->m=
aps);
> >>              return 0;
> >>      }
> >>
> >> -    err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
> >> +    err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, update_f=
lags);
> >>      if (err) {
> >>              err =3D -errno;
> >>              pr_warn("map '%s': failed to set initial contents: %s\n",
> >> @@ -5349,6 +5387,13 @@ bpf_object__populate_internal_map(struct bpf_ob=
ject *obj, struct bpf_map *map)
> >>                      return err;
> >>              }
> >>              map->mmaped =3D mmaped;
> >> +    } else if (is_percpu) {
> >> +            if (mprotect(map->mmaped, mmap_sz, PROT_READ)) {
> >> +                    err =3D -errno;
> >> +                    pr_warn("map '%s': failed to mprotect() contents:=
 %s\n",
> >> +                            bpf_map__name(map), errstr(err));
> >> +                    return err;
> >> +            }
> >>      } else if (map->mmaped) {
> >>              munmap(map->mmaped, mmap_sz);
> >>              map->mmaped =3D NULL;
> >> @@ -10807,11 +10852,16 @@ static bool map_uses_real_name(const struct =
bpf_map *map)
> >>       * such map's corresponding ELF section name as a map name.
> >>       * This check distinguishes .data/.rodata from .data.* and .rodat=
a.*
> >>       * maps to know which name has to be returned to the user.
> >> +     * Map name of the custom .percpu.* maps might be truncated to
> >> +     * BPF_OBJ_NAME_LEN-1 chars in internal_map_name(). Hence, percpu=
 data
> >> +     * maps must use real name for their user-visible name.
> >>       */
> >>      if (map->libbpf_type =3D=3D LIBBPF_MAP_DATA && strcmp(map->real_n=
ame, DATA_SEC) !=3D 0)
> >>              return true;
> >>      if (map->libbpf_type =3D=3D LIBBPF_MAP_RODATA && strcmp(map->real=
_name, RODATA_SEC) !=3D 0)
> >>              return true;
> >> +    if (map->libbpf_type =3D=3D LIBBPF_MAP_PERCPU)
> >> +            return true;
> >
> > Same comment as above here wrt uniformity. This is the part that
> > requires us to check agianst the map type in __init_internal_map().
>
>
> Let us wait for Andrii's comment.
>

I think it's fine and basically inevitable

> Thanks,
> Leon
>
> >
> >>      return false;
> >>  }
> >>
> >
>
