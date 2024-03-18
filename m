Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8C250EC
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795041; cv=none; b=TWjZqDKDU9JFlTmc/aYJLm0fBCTaigZpzu3JZcCv3Sx7iGT2QlgytFrKFNOBhwnZBIxrqsaeVaE61ElGj47BLX8/2ffSLGuAm8DqJF+fV0o56MqkeXub29+HyktU50KNXIRYpj/ZvPtZuj95gHm8skvPV0rmhPC66BXApGK52tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795041; c=relaxed/simple;
	bh=Y2Ktp03k4M4BL4hNqLy1bzRgT4KFxGR6SM79ehngwps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJh/xY0rKGpe/9O4UNwVFxdcJ73yVPMMG7TjhtGx9Xc2XZF3Kbeq2biVw3DkkOmiH+yITHxIphrg8zUsd4ENkkOHER2vMwTX88pBsTqDQ9NbCGAHD1R385j47C6oVMz7spX2vhhvMY78gptQlP4EdoFSqWR689vC7LLQsbqBgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxWm3+v8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxWm3+v8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd10a37d68so39141735ad.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710795039; x=1711399839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X0Lnyz5OPcRRj5EsLiPKv0i4aH046pg5cWM0rXZZoY=;
        b=dxWm3+v8r32uYX7lGXvI+O9LfEWRBwd3rGixUwDZwOX6bTiKQeORLoWI+y/HndI70R
         fris9DFGErVwQcRZz2DjtjWm3P+ML8Avcu19/NbxdGYh7iyy5+e253YvJV4aC8mkKGFa
         OMRZC5dtNjx2X9tRR9hfzkBlVmbfkVd5bR8rKhS+QprTWdWYbiOkj/0SxLQbSmJ6RULM
         mcBFQWyAi1Y1S4kOyr22iNuc3wTsds70/LUQdise5VTA/0nCpgFM+6cRO6m4LccOq0Ss
         aP8YgZp3voC1bfs6uBR4sJZ4E2Rx8m7/JrexGwWU2lp3IRC4/ZUbugs7VPwqFnyUgn2F
         3sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710795039; x=1711399839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X0Lnyz5OPcRRj5EsLiPKv0i4aH046pg5cWM0rXZZoY=;
        b=w/8iTv1J7Hv3Mj1Kxg99khhBatwR7RPNL+lYB3IFciPV4i8TlTb732OaeFLX4rivfn
         YxrzreDG/sc8moHY1lz+v9QtS3pkUTc2hPJ+es0/ru+B1J5fuzRq+p33rjfWxdICmM6M
         nhoCF8tJtJRMTj0HdvbRcXRE2iNs37o1yYgM27AQdX0/Ex4BK9AQWI4SKV/oYrXJrwPY
         c1glHJ8jwErXf9kF2Q6LMr/si0WCPsilFHfQatJJZNE+HGdpNToTDuGP58YWTfyRyaHS
         RaVeQJB1AGF163j7dLr++vA+lZgY1rX8Yds7F0qQ9ZbGQTdo0ZRtL7sT54ke8J0g4XIY
         z9yA==
X-Gm-Message-State: AOJu0YxT0XH95U6GZiUDelfB2+4tjqjLTeIeBoXl2z0Rgw3xWKP06ku4
	d1ppKSpIEm//npNyeLkHy26y2pAHYzLhDBYiu7BmRZWuW6DE0NbRVCa+Zk/QkQlP43/9EOAT2n1
	WNe7hh4a6kbTrlO8W7+GVTkhjJ5g=
X-Google-Smtp-Source: AGHT+IHD/d6H5Rzd52m3uWDspDyuDDaESyugxaqty6kHlqDq46If/U1xJJD+Uwh5MFas4DHrEd6gscUDMrzJGGNrAdY=
X-Received: by 2002:a17:902:a3c5:b0:1de:eac5:9294 with SMTP id
 q5-20020a170902a3c500b001deeac59294mr10468368plb.13.1710795038822; Mon, 18
 Mar 2024 13:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318131808.95959-1-yatsenko@meta.com>
In-Reply-To: <20240318131808.95959-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Mar 2024 13:50:26 -0700
Message-ID: <CAEf4BzYwo5K4pWxR+S7=n8tRqF_ATQeXUbAJ4EHE97WNfo_GrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: check bpf_map/bpf_program fd validity
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 6:18=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>

We generally use "libbpf: " prefix for patch subject if changes are
related to libbpf code base. I fixed it up while applying.

> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> libbpf creates bpf_program/bpf_map structs for each program/map that
> user defines, but it allows to disable creating/loading those objects in
> kernel, in that case they won't have associated file descriptor
> (fd < 0). Such functionality is used for backward compatibility
> with some older kernels.
>
> Nothing prevents users from passing these maps or programs with no
> kernel counterpart to libbpf APIs. This change introduces explicit
> checks for kernel objects existence, aiming to improve visibility of
> those edge cases and provide meaningful warnings to users.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 56 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 5 deletions(-)
>

See nits below. I fixed all that up while applying, as it was just
some text adjustment, so it didn't seem worth another version. Thanks
for the patch, it will help users!

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 604368cfbf02..d1febdb036de 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8572,6 +8572,12 @@ int bpf_map__pin(struct bpf_map *map, const char *=
path)
>                 return libbpf_err(-EINVAL);
>         }
>
> +       if (map->fd < 0) {
> +               pr_warn("map '%s': can't pin BPF map without FD (was it c=
reated?)\n",
> +                       bpf_map__name(map));
> +               return libbpf_err(-EINVAL);
> +       }
> +
>         if (map->pin_path) {
>                 if (path && strcmp(path, map->pin_path)) {
>                         pr_warn("map '%s' already has pin path '%s' diffe=
rent from '%s'\n",
> @@ -10316,6 +10322,11 @@ static int validate_map_op(const struct bpf_map =
*map, size_t key_sz,
>                 return -EINVAL;
>         }
>
> +       if (map->fd < 0) {
> +               pr_warn("map '%s': can't use BPF map without FD (was it c=
reated?)\n", map->name);
> +               return -EINVAL;
> +       }
> +
>         if (!check_value_sz)
>                 return 0;
>
> @@ -10428,8 +10439,15 @@ long libbpf_get_error(const void *ptr)
>  int bpf_link__update_program(struct bpf_link *link, struct bpf_program *=
prog)
>  {
>         int ret;
> +       int prog_fd =3D bpf_program__fd(prog);
>
> -       ret =3D bpf_link_update(bpf_link__fd(link), bpf_program__fd(prog)=
, NULL);
> +       if (prog_fd < 0) {
> +               pr_warn("prog '%s': can't use BPF program without FD (was=
 it created?)\n",

maps are created, programs are loaded, so "was it loaded?"?

> +                       prog->name);
> +               return libbpf_err(-EINVAL);
> +       }
> +
> +       ret =3D bpf_link_update(bpf_link__fd(link), prog_fd, NULL);
>         return libbpf_err_errno(ret);
>  }
>
> @@ -11347,6 +11365,13 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
>         if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       prog_fd =3D bpf_program__fd(prog);
> +       if (prog_fd < 0) {
> +               pr_warn("prog '%s': can't attach BPF program without FD (=
was it created?)\n",

ditto

> +                       prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
>         syms    =3D OPTS_GET(opts, syms, false);
>         addrs   =3D OPTS_GET(opts, addrs, false);
>         cnt     =3D OPTS_GET(opts, cnt, false);
> @@ -11387,7 +11412,6 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>         }
>         link->detach =3D &bpf_link__detach_fd;
>
> -       prog_fd =3D bpf_program__fd(prog);
>         link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, &=
lopts);
>         if (link_fd < 0) {
>                 err =3D -errno;
> @@ -11770,6 +11794,13 @@ bpf_program__attach_uprobe_multi(const struct bp=
f_program *prog,
>         if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       prog_fd =3D bpf_program__fd(prog);
> +       if (prog_fd < 0) {
> +               pr_warn("prog '%s': can't attach BPF program without FD (=
was it created?)\n",

loaded

> +                       prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
>         syms =3D OPTS_GET(opts, syms, NULL);
>         offsets =3D OPTS_GET(opts, offsets, NULL);
>         ref_ctr_offsets =3D OPTS_GET(opts, ref_ctr_offsets, NULL);
> @@ -11845,7 +11876,6 @@ bpf_program__attach_uprobe_multi(const struct bpf=
_program *prog,
>         }
>         link->detach =3D &bpf_link__detach_fd;
>
> -       prog_fd =3D bpf_program__fd(prog);
>         link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &=
lopts);
>         if (link_fd < 0) {
>                 err =3D -errno;
> @@ -12671,6 +12701,12 @@ struct bpf_link *bpf_program__attach(const struc=
t bpf_program *prog)
>         if (!prog->sec_def || !prog->sec_def->prog_attach_fn)
>                 return libbpf_err_ptr(-EOPNOTSUPP);
>
> +       if (bpf_program__fd(prog) < 0) {
> +               pr_warn("prog '%s': can't attach BPF program w/o FD (did =
you load it?)\n",

I normalized w/o to without

> +                       prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
>         err =3D prog->sec_def->prog_attach_fn(prog, prog->sec_def->cookie=
, &link);
>         if (err)
>                 return libbpf_err_ptr(err);
> @@ -12711,9 +12747,14 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
>         __u32 zero =3D 0;
>         int err, fd;
>
> -       if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
> +       if (!bpf_map__is_struct_ops(map))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       if (map->fd < 0) {
> +               pr_warn("map '%s': can't attach BPF map w/o FD (did you l=
oad it?)\n", map->name);

without, "was it created?"

> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
>         link =3D calloc(1, sizeof(*link));
>         if (!link)
>                 return libbpf_err_ptr(-EINVAL);
> @@ -12760,8 +12801,13 @@ int bpf_link__update_map(struct bpf_link *link, =
const struct bpf_map *map)
>         __u32 zero =3D 0;
>         int err;
>
> -       if (!bpf_map__is_struct_ops(map) || !map_is_created(map))
> +       if (!bpf_map__is_struct_ops(map))
> +               return -EINVAL;
> +
> +       if (map->fd < 0) {
> +               pr_warn("map '%s': can't use BPF map w/o FD (did you load=
 it?)\n", map->name);

same about create vs load

>                 return -EINVAL;
> +       }
>
>         st_ops_link =3D container_of(link, struct bpf_link_struct_ops, li=
nk);
>         /* Ensure the type of a link is correct */
> --
> 2.42.0
>
