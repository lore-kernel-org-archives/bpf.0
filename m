Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403E4A206A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147685; cv=pass; b=mxUKBtD2ImxFICqnFBRO81Q2OHDuuLXuX53koMRE/lIttIPi6zK++3pIAZ3725P+9Yvlrq0F3GcB3P3KlJf6hvRxI6dS+KF7yV5Uq7KfKCiybB3ITvdNlFhMYly4BOoSwjy5aEbb3EAkuw9U0VTZSQ4YB6EB58pGQRK42dd5o8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147685; c=relaxed/simple;
	bh=Zwwd3UFTp964bFzq6/FfB2ZFUv8ysrzvFGQbRcyX48A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4ocmnJl7MuMf9CDBUlsr632C38Ora4vg3XHQtGtWGEMJqDNVHGljF9gwE304Luocpe1DSXVMQiL/1rKV6V/drrm1EkGPdPi3mPrbdkO6OORRh/3x/RCPOWjsuMQrZj58ZH2rLMTlP0cpWSJvwNSqY4ICLyI3nb1olLB1ldiwBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgfWDX7n; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgfWDX7n"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d715f4a587so14971215ad.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 10:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789147683; cv=none;
        d=google.com; s=arc-20260327;
        b=dUNjCvG50oi3cHywi37quwhcG147DPX04evJ0MEzW4NanqkYIIwKYALempsrdUdBc2
         XM3f+ODaKql70chA+QNU4BFHbwwA5UQkdHuUq/DXcKA3x9ev7DDsBto3bSlDF/7MBtw2
         NYPOG5L1uTbNStEoW4DaFv7wP1MFl186Q02uABjqaIgyW+uf+Z36exrhO8veYldW477G
         xxL46pmWu6K30+uj38ppfteHqO7ciUi2EWgLmUMybdNmZySwfjjIWM7+/pmXOdOHBzv3
         82pKxucgCgrWuj9jjmoTbl3KL3L63DRWvnTmhd9rnFTzso4SvSPJIMCq3QORA83PI5zG
         SJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6rxwcQcl6E77JpjcsT8vzlwPAJvHh/FqOYkIqmUstgU=;
        fh=udYsN1oF09PmY/lnu1++F0xQpGRw1vhm+d4SCjWtxmE=;
        b=jj2SWq8+pJZYh242Vuy98PodlOKE1vGSvyruVreHc53LNXBt4HHawMhQb0uopTupC7
         2p9XhYSbpcREZ1LLQIvgOe3b4jxnxU5mBL8GDVdh8VTG4sj61M+w5qy0gIFkwwORvet9
         TGZlQzEOzmNugt2NuGvZLQA6GaM+xplaxWAPcjvTR+j1yK0tH19L53G15p4klKZfVopI
         vaOepfHnvARzGXwVU5KKWKUyzxdR2Afatutfg16YzLbPaxmPYqDxYZTeKFBlGa2E8mNd
         EbFZIUQMTSmTyTubtvLggGok/DnLikeMkThO3c7AoAwtlWICJawzCViEVH1lWdZzZ+6i
         dk/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789147683; x=1789752483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6rxwcQcl6E77JpjcsT8vzlwPAJvHh/FqOYkIqmUstgU=;
        b=kgfWDX7nO5N400D+HOFHnminnM9HRzH3edl5ssITBgDZRi5U6803//1kUmoDl4JWie
         HjEhFVbKxYKaBbnHoRL1oCH7P7EnXTgdZzWaB6plJI1JmQTEbX7rGVdfZztqmIX1IukZ
         2nRD3FxumQFoDVRS8tFeFtuJNxrLBZQ5uQC17omJ5+8JB2dzvZZs/dUOIoQkncM+MDbV
         ilVBJrSpPDbEURr0XMwzsj1V6tLpX8NneW40AD3ZQfvXEcEBp9Qkh8pVKJy9v8FS6dil
         Ty+t3Ngm4oGAAA62V1VtdnibRW/Lc87K6EhRzh1TTThb5HLBNa/kM5LVnseyv249hVA1
         AQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147683; x=1789752483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6rxwcQcl6E77JpjcsT8vzlwPAJvHh/FqOYkIqmUstgU=;
        b=V81zWZqgn7EaH2POjExBzvy5u9Em0sKbbGWWE/0mL0SH3hQXQHFYrXgmuThSflOg3P
         xO329LylOU1/fBxIsOIvnVRfwGTjU4neO7hxr4TDxDYIM03HfOPuBfXXpmJgRY+oFxa2
         Fh5kMWFC9LvjY+z9fl7o8I/mYfPwL19gfiCK0QYbSPtTPpPyulw4zGg510G7YXXG2wUq
         E5Ug0f30PBnTEHqdPnBHPcyX2UNZtNOzqNxhQhWL5g9vaymzADtgJDLSjzCTwFRAkDs5
         s1mbmqySoPushu0Bza8Jb0M0Fi4UpbDSKhy3dO6bRrNCiaY1IKHroefvYufq3ZnLj10v
         LxmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGxRZP+6MKac9HXtEIsU0Odxo3tH0VvkCocrHvlp9MasxA1GFClSSr5eT86E/mOQTX9vc=@vger.kernel.org
X-Gm-Message-State: AFuF++ly9ioJofCY292/qRm8kjl2uEoA9H5W4pp1qX14+QodTcu0YXE6
	+rp/migYgt8x43WRZ58a3WBwknOr+zU495FN67i2btBu/Io1lSWskYviTOQtZXJjeor/vT/62LD
	KQgK0z9upP8UkPCYcsnlBZZk+BJlnsh9Xnw==
X-Gm-Gg: AYBFou2yWmBXskn7mk2SEJptrPmt5kDPn74TKFJeDEnDd74YUFuWWiCZvYBOqcyjqjP
	opHXEmk4xtb0NxE92epBelTUjrkPz+qQblOor6irgRhOgf5bVrKNk0aFpHM2odOdaKZnVqOGbnj
	4GTHo8GagbekGY2VB2ft0CmyIb9k55ZjUvCGs057/fONlMbJy75RbSVf+RXEwYLfeaAwWUyM7Ib
	1ftsbdFbs0VIwQGqcssq0oOJEQKFaSZ+5+ODSP3uA0BsaEivnLGiHIHe98Kz3WL24ahhzNd4wZb
	YUG+LuKTuGU0CTJhJ2BBZx7DLoVkjX4N3sO8fnkkUXmimdxnbiPplOd59cabz8A7tiKoRFiYAFC
	bpgsC0C83sUG5NyW5T7QCFWIYmO1jThIUnkbw
X-Received: by 2002:a17:90a:e710:b0:398:d843:cad9 with SMTP id
 98e67ed59e1d1-39d9c202f33mr9867220a91.19.1789147683326; Fri, 11 Sep 2026
 10:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-libbpf_arena_thing-v1-1-0092c0e0d91b@meta.com> <CABFh=a6J9Wq6WEi9YFDFYDYuiovVL8soGH=LS8R_DOSNgaWxkQ@mail.gmail.com>
In-Reply-To: <CABFh=a6J9Wq6WEi9YFDFYDYuiovVL8soGH=LS8R_DOSNgaWxkQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 10:27:50 -0700
X-Gm-Features: AcwNN1UYrEs-QLIj9CKjRBGVO0OGxFH4WyU_8d7szsJrHeBYYLoNYt4xeXttnJM
Message-ID: <CAEf4BzYkgXj4UDyf-85paTZ-k-Q4yt0Loe3aOCJBs7NijN9_4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: defer arena map size check to load time
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com, 
	eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 12:37=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Tue, Sep 8, 2026 at 3:33=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > init_arena_map_data() used the build-host page size while it opened an
> > object. This could reject skeleton generation when the build host and
> > target use different page sizes.
> >
> > Validate the size during load, before libbpf calculates the arena data
> > offset. This uses the running kernel page size and rejects an
> > undersized map before relocation.
> >
> > This problem manifested when cross compiling BPF selftests for
> > arm64 (64K page) on x86 (4K page). In this setup skeleton generation
> > fails.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> The bots have a point about the unnecesary check, but not about the
> NOBITS section.
>
> > ---
> >  tools/lib/bpf/libbpf.c | 31 +++++++++++++------------------
> >  1 file changed, 13 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index c036e8a91ed8..413b8b305194 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -3018,20 +3018,8 @@ static int bpf_object__init_user_btf_map(struct =
bpf_object *obj,
> >  }
> >
> >  static int init_arena_map_data(struct bpf_object *obj, struct bpf_map =
*map,
> > -                              const char *sec_name, int sec_idx,
> >                                void *data, size_t data_sz)
> >  {
> > -       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> > -       const size_t data_alloc_sz =3D roundup(data_sz, page_sz);
> > -       size_t mmap_sz;
> > -
> > -       mmap_sz =3D bpf_map_mmap_sz(map);
> > -       if (data_alloc_sz > mmap_sz) {
> > -               pr_warn("elf: sec '%s': declared ARENA map size (%zu) i=
s too small to hold global __arena variables of size %zu\n",
> > -                       sec_name, mmap_sz, data_sz);
> > -               return -E2BIG;
> > -       }
> > -
> >         obj->arena_data =3D malloc(data_sz);
> >         if (!obj->arena_data)
> >                 return -ENOMEM;
> > @@ -3107,8 +3095,7 @@ static int bpf_object__init_user_btf_maps(struct =
bpf_object *obj, bool strict,
> >                 obj->arena_map_idx =3D i;
> >
> >                 if (obj->efile.arena_data) {
> > -                       err =3D init_arena_map_data(obj, map, ARENA_SEC=
, obj->efile.arena_data_shndx,
> > -                                                 obj->efile.arena_data=
->d_buf,
> > +                       err =3D init_arena_map_data(obj, map, obj->efil=
e.arena_data->d_buf,
> >                                                   obj->efile.arena_data=
->d_size);
> >                         if (err)
> >                                 return err;
> > @@ -7489,12 +7476,20 @@ static int bpf_object__relocate(struct bpf_obje=
ct *obj, const char *targ_btf_pat
> >                 bpf_object__sort_relos(obj);
> >         }
> >
> > -       /* place globals at the end of the arena (if supported) */
> > -       if (obj->arena_map_idx >=3D 0 && kernel_supports(obj, FEAT_LDIM=
M64_FULL_RANGE_OFF)) {
> > +       if (obj->arena_map_idx >=3D 0) {
> >                 struct bpf_map *arena_map =3D &obj->maps[obj->arena_map=
_idx];
> > +               size_t data_sz =3D roundup(obj->arena_data_sz, sysconf(=
_SC_PAGE_SIZE));
> > +               size_t mmap_sz =3D bpf_map_mmap_sz(arena_map);
> > +
> > +               if (obj->arena_data && data_sz > mmap_sz) {

dropped arena_data check while applying

> > +                       pr_warn("map '%s': declared ARENA map size (%zu=
) is too small to hold global __arena variables of size %zu\n",
> > +                               arena_map->name, mmap_sz, obj->arena_da=
ta_sz);
> > +                       return -E2BIG;
> > +               }
> >
> > -               obj->arena_data_off =3D bpf_map_mmap_sz(arena_map) -
> > -                                     roundup(obj->arena_data_sz, sysco=
nf(_SC_PAGE_SIZE));
> > +               /* place globals at the end of the arena (if supported)=
 */
> > +               if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
> > +                       obj->arena_data_off =3D mmap_sz - data_sz;
> >         }
> >
> >         /* Before relocating calls pre-process relocations and mark
> >
> > ---
> > base-commit: 3fa3128887a4df6057c543aae7c5c7fd2ed41f12
> > change-id: 20260908-libbpf_arena_thing-0d63a985f4f3
> >
> > Best regards,
> > --
> > Mykyta Yatsenko <yatsenko@meta.com>
> >
> >
