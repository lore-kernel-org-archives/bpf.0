Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF64C9554
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934352; cv=pass; b=kyfnTt6BFXqHGNu9yntGR4sDG4QPfH+ekMuxo7Kl5e1TWIo3ggUc8pi98XUELsb3lxSvVXGHiCY2w3a0bF2rMnaZN8B1yyAPdxNQ2HF2uP8PACatgSsNV02THFV8OVPyFtCguKXkjdUt0m7lgqNf4IEzlzaxInj8m+V0GqDT6ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934352; c=relaxed/simple;
	bh=EyLLaXb9YvmlFZo/5AJiUAadFkjuIh2boXQbjRWgni8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IygfGkbRvVSd/8t8Zy3AIWuGmQsJef4N6ZSYhOqlYz7QavS+szVyvSgNTWLA+8Xg6zC9+WmngiHuy8mWaaT6VZilAnVXnECaJo9USlD1OiHMmip4R0+/8PYj0LtnPmrDODYkxEYg9++CtaHAQ+tlPCdHLx5GqixWpeiWy1p3U5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/7SFpmb; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/7SFpmb"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37e0fb87b75so823162a91.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782934349; cv=none;
        d=google.com; s=arc-20260327;
        b=Wn/NVz6LEEpHeicnpgSOpHuZWMvkBIkJEE8hMinTDScmNNC+eh8Dn/mzoojjClmpic
         evZnUvWHYA0LsFvMyqMy7AvAzhP5Tqw4HPHr658LmmMPpY5DkmgKvMnEVx/bUB0NS/yF
         asUXTQvK0KPEopA0lVFIzcQoT09PVxvE7uI0hIPd4VTQksNsVuVYlCLnig+RZl5uw2F0
         AEwkXa1dsxoE4g/1HInimXzxRMvK3Sl87unlElhv5XpykOsylGb+IGOx1Uc6Egn79IoN
         FCBlFFRz3vVrUXbpaetKioTxu1Q3nfuo2Q74w+36f2/p0N8p0YEMbx+bbYzP8ZNwCIAW
         51SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JzvANgXQEq0OEJ8TDGIUnErwic4f3K/wVGZYeMokZaM=;
        fh=yKV4TpZpWqHKiocU3c+TpAVy6kysn+E+PepoJERhUbQ=;
        b=ZjOWMGPP048MuMOTjIzpdhbb6QEOO/NtHWtXqZ17rWuIIg5Cmap7elbfUAI9xD+V/B
         AuScxJZjZX6a4JYS6yjR3enfout8bA8EEzh+VelD7jiwFwjVUOGkA8WtVwwJ5AG7pPJp
         bOFfVn7Ho5SGW4AIEE8hDotMaN3jVPKJYHScchpLXG5RKv323D2t7pm0De1tmChAAwnt
         2OV8sLNKhELki4mqUiRmr4pLZ9bn4uyuUoU9IN2k9l/4LoXpZkJQ07Dmet5I8xxN44Fe
         1EGHHYSGrWi7LXxB6UOU+FikevQPY0w3oGkrX3sJgsJFZ6lE9zOvp/1d8RsXrDXbud2R
         9PKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782934349; x=1783539149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzvANgXQEq0OEJ8TDGIUnErwic4f3K/wVGZYeMokZaM=;
        b=s/7SFpmbrEGmh7TLp0elBuBqXpQmHetQcLdK+hmDYYUeeCouDGE6mL2nxWVcm8tgpP
         ClcD2bLhlK8ciRbgLSyG8lvRK1ZwQYre3Bbf/wnA/EOb0yQeeAQGaXnYIl26Jk08AU2O
         plKfV2MBh8RAp9CknPrZ1KwromQ2LJ4cy4ftlxuPqYAakvizbrQzEPRlhiqBeG8qu6Ag
         G0TvrP4JBFCOc5hoKfC+b5kVdXJY6QQHXDwTuPgxrZlVjhVt5U+INNqHQgTXXZWr5aDT
         GNmPtdkqkJRp4qr/DoLiHXiaYE4wbrdJunQ7AksNY2shp37KTr0XKgsBv4WTD+u4zVc9
         rJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934349; x=1783539149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JzvANgXQEq0OEJ8TDGIUnErwic4f3K/wVGZYeMokZaM=;
        b=mJ+1vcsAtWK+kgGYVtv7THI+8RItxR+GDFalj3nlV7F0OEPC0FvqivDyP4N5+NKpk/
         41FihZddpiBWGe9nE/2ZteAtmpQ6JymQSoG5wzXfXd9pqZX0QjvSl+d5MQvBu72CW/5+
         ArCZ8jK8VJNv481a7Fo2Uxe/4nV/wEEr/g8V+OyR6O9DTHGqfRqaHhA1DEKhvKYmG4Dl
         vmTEX+KfeFhgZKQJXUG43L91Dw+L3w1T0srbUGFAmGJRV4RxqEIjPRvzViNZ/TmWw+To
         +ndDqJHDiS8Jl2ykFQWniKJ9EHlB5AlL2yeOuzJuyMK/y6nqH1etNNYr11H5X1D3L9IX
         S1Yw==
X-Forwarded-Encrypted: i=1; AHgh+RrCYgcqAF2Xm/qdpKDli8cmtsUys7GFPJCmyXVY94/qOK4hWNm+kcb4ekWrzKauZS2kR80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhtEOwFuJ2ttRzUMjAPJWOJp7S8XhyoK61Toj/ry+X3TJ3gQB
	12DiHk3KlBVxuNT0rUKlU/0QUR9SyI+8BQ97E2bQ5OqAeiyLnZ5p9OqsaPZ7w/t2VcmZ8Zxu0Ff
	Jmlv7wL89Ue2+qYgPxxDBsEWXLZtfcAk=
X-Gm-Gg: AfdE7cm3SfjCiEAXc9oPdIrSX4e5gSNeJqGLbBq1QZCp99Jtt1N2Io7cwXgo1GHwqlR
	dHDA3NtOroEPbJEingnmMiTBGTuXZ6tWvQGsuUk8jGAf5MLg0nxXqxh2p7AisjggJLBSmmZg+sQ
	yQVqGhxUA/iGiGz3RMFtAWfIbK6r3v0wPSLnfuqvgRgq10ypFdDi+e0y/Q0eNx4tuRzVi3uOnre
	yQG5uAlWUHviTuE55lOf/QG/bkLzrchtn+aGKdQkM+wA7uw9GWiqKiWz+wNJSzwRW/5J41vDe83
	vjjtNU2kMD5IOGcRtB2qMo7r7sS3drhXgdo8gAeKNWoA8NRK+OSEnQ==
X-Received: by 2002:a17:90b:570c:b0:37f:c683:e643 with SMTP id
 98e67ed59e1d1-380aa1d4cbbmr2678626a91.24.1782934349278; Wed, 01 Jul 2026
 12:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629152406.52582-1-leon.hwang@linux.dev> <20260629152406.52582-6-leon.hwang@linux.dev>
 <a4e4adfe-4b2e-49c4-a708-89276514f930@kernel.org>
In-Reply-To: <a4e4adfe-4b2e-49c4-a708-89276514f930@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 12:32:17 -0700
X-Gm-Features: AVVi8Cf26mExkF685IWBbEX3UhJ6IsWEmNK3NaBgDEocbc3NJEfCJeRdHdqrSLQ
Message-ID: <CAEf4BzbfA2nySpf3Oh6KVBRjDKMOOYN-NC279Sj73KwH32cGGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 5/9] bpftool: Generate skeleton for global
 percpu data
To: Quentin Monnet <qmo@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:49=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2026-06-29 23:24 UTC+0800 ~ Leon Hwang <leon.hwang@linux.dev>
> > Enhance bpftool to generate skeletons that properly handle global percp=
u
> > variables. The generated skeleton now includes a dedicated structure fo=
r
> > percpu data, allowing users to initialize and access percpu variables m=
ore
> > efficiently.
> >
> > For global percpu variables, the skeleton now includes a nested
> > structure, e.g.:
> >
> > struct test_global_percpu_data {
> >       struct bpf_object_skeleton *skeleton;
> >       struct bpf_object *obj;
> >       struct {
> >               struct bpf_map *percpu;
> >       } maps;
> >       // ...
> >       struct test_global_percpu_data__percpu {
> >               int data;
> >               char run;
> >               struct {
> >                       char set;
> >                       int i;
> >                       int nums[7];
> >               } struct_data;
> >               int nums[7];
> >       } *percpu;
> >
> >       // ...
> > };
> >
> >   * The "struct test_global_percpu_data__percpu *percpu" points to
> >     initialized data, which is actually "maps.percpu->mmaped".
> >   * Before loading the skeleton, updating the
> >     "struct test_global_percpu_data__percpu *percpu" modifies the initi=
al
> >     value of the corresponding global percpu variables.
> >   * After loading the skeleton, "maps.percpu->mmaped" has been marked a=
s
> >     read-only in libbpf. If users want to update the global percpu
> >     variables, they have to update the "maps.percpu" map instead.
> >   * For lightweight skeleton, "lskel->percpu" will be protected by
> >     "mprotect(p, sz, PROT_READ)".
> >   * For subskeleton, those variables of global percpu data will be
> >     skipped.
> >
> > Assisted-by: Codex:gpt-5.5-xhigh
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  tools/bpf/bpftool/gen.c       | 49 +++++++++++++++++++++++++++++++----
> >  tools/lib/bpf/skel_internal.h | 24 +++++++++++++++--
> >  2 files changed, 66 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 6ae7262ebe0c..2e60296358db 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char =
*obj_name, const char *suff
> >
> >  static bool get_map_ident(const struct bpf_map *map, char *buf, size_t=
 buf_sz)
> >  {
> > -     static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".kco=
nfig" };
> > +     static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".per=
cpu", ".kconfig" };
> >       const char *name =3D bpf_map__name(map);
> >       int i, n;
> >
> > @@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map=
, char *buf, size_t buf_sz)
> >
> >  static bool get_datasec_ident(const char *sec_name, char *buf, size_t =
buf_sz)
> >  {
> > -     static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".kco=
nfig" };
> > +     static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".per=
cpu", ".kconfig" };
> >       int i, n;
> >
> >       /* recognize hard coded LLVM section name */
> > @@ -254,6 +254,20 @@ static const struct btf_type *find_type_for_map(st=
ruct btf *btf, const char *map
> >       return NULL;
> >  }
> >
> > +static bool bpf_map_is_skel_data(const struct bpf_map *map)
> > +{
> > +     if (!bpf_map__is_internal(map))
> > +             return false;
> > +
> > +     if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
> > +             return true;
> > +
> > +     if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  static bool is_mmapable_map(const struct bpf_map *map, char *buf, size=
_t sz)
> >  {
> >       size_t tmp_sz;
> > @@ -263,7 +277,7 @@ static bool is_mmapable_map(const struct bpf_map *m=
ap, char *buf, size_t sz)
> >               return true;
> >       }
> >
> > -     if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF=
_F_MMAPABLE))
> > +     if (!bpf_map_is_skel_data(map))
> >               return false;
> >
> >       if (!get_map_ident(map, buf, sz))
>
>
> Thanks! The bpftool patch looks good, with one reservation: after this
> patch, I believe "is_mmapable_map(map, ...)" will return true if map is
> a percpu map, although percpu maps aren't mmap-able, so we should
> probably update the name of that function to avoid any confusion?
>

Great observation, Quentin!

bpf_map_is_skel_data() I think was supposed to be exactly that generic
name. But it seems like Leon went half-way through with unification.
Unless there are some subtle situations where per-cpu array shouldn't
be handled where is_mmapable_map() is handled, we should rename
is_mmapable_map() and add BPF_MAP_TYPE_PERCPU_ARRAY check (assuming
it's internal map, of course) there.

Leon, can you please check?

pw-bot: cr


> Quentin
