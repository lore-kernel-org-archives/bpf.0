Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402C3812FE
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896263; cv=pass; b=fZzCqrXVjuP9/CKbsOpX9fTZUp+M9KDm66XU5326XiXHojvO5J7+kkaaRrdVqS1za3A4xiHlW2BklmfIJSkYeSWbjOoIUAr+GLTKUWxblsiUzyMXf7cc9y9m1hd9qPC2d5pW/E4MuJhSN11JQ2ZrShzhbc4X2eVMN5pVcz/dqW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896263; c=relaxed/simple;
	bh=sJc8G8NoF3PHLU3jBDNVJQKRyt8Y3GvXm02uKfzV1Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcTHUIwp1ARRFvt6tA9u446mQPSumw8x0zn4HPjDIv74RM2mMDNH+shNUiHXauIFEfXxuU4O+ApB0xMqFV/rfhXZL4F1XtWEuXZCFLfAGuSX2IxAUDJGfMEYV13qOutEYwlzf62oLlXZBqQ7+fHcvW2/jBLIfw/T+FRshk2jySA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=JsuI5Zby; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="JsuI5Zby"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-87ab6e5f91eso21453747b3.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 12:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788896261; cv=none;
        d=google.com; s=arc-20260327;
        b=N2k2m4zdiGmOvigK5m1QqJLpMJiEoAaMtC/zTVkSAl8izMwGX0MG4XHH118mkjAaIc
         nWaeHYREwSvROZml1fL4HQ566JKM04tT29dM7CvF+cPgN/nZFjji3uF9LsGDXD4uLycq
         5kA2oyaMYjOyS++qARhddcqdTzlMetWm0ZsKgE5sSF+Z008eZ3aSTzEZgBseZGGgP2mo
         en/cHgoXsrLyQNIbxye1sG5XglwP1jr5+FYWmkDYCCpHoc83nkqzxMTMPAUQqxi7KY+Y
         d8jBD5F0ZwRspsZsmrkSNge0YbZ6XDz2m3rVgA5mnIyXALTlHjUp4lyJq9zlreOFsGc7
         AGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oJjcl8kY+Gc0483BJxK08SYm6L9/2rjfUFtY+LWeJ3g=;
        fh=lZntEtKbfM3fuzuBJDrYJZWuXmxgjwfIF77rvmOhujw=;
        b=K+f/Goi7RTtUyjycsQK2SL45btTpg6HakhmjqMXQdF2mYOuHj8+N3g6qMxfmhptVc4
         HMZdz5lDVYlfTPuMbBa93qSQk0N7RLbWDjR0XQjcKeYLbX06DY1FIYKAjGHpCfgT7DBK
         BT2K8SVPPW6LxMkaB5riDYDUsSL2EooEYcqOnIqBmWhaILfapG6JquEncaqtihEKt+q0
         K8KeWSSxK6cpLSnbri3EvMLn4Wb4fswoK0WoJOw5uets0D+iTD+u7S/RWc7TwzjBVRIr
         UshZpmyesfvq0TsmyNuiNQso7gOvneHDBWa/3+l3KuvDotxtefeSZqpIU8SXSp9WX6dk
         9gUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788896261; x=1789501061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oJjcl8kY+Gc0483BJxK08SYm6L9/2rjfUFtY+LWeJ3g=;
        b=JsuI5Zby6/QnmwwygBGEeDIHTgzVVjAbAeLoh2HZuD7VYKj17yTxAddIig53CQT6IO
         4Dfo6+I5f94ZosFCHlX0Zv/954eMn1+nydlqAn/6uYr+PLRiioIAVGZ3PuygbPW/pHUO
         gXmqbrjueDboOMbeUNqBshMEHbTC6Rnuk/GbIJXQiP1BJ72/LSjMMhqPstl1qrhZllYl
         qO3D+JAy3alaW1wXcFCL15rdaFAm1c1Vg7Q5QHvlN4/CoAtZwZ192kCHMKvkZUy3fCpf
         VaYmWT43VvakEsSJYNOZMo1BPqMjt1IW5DMNVcKdXFLGYHqi8TjhbDhm2HvNLlu4ew9L
         Qfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788896261; x=1789501061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJjcl8kY+Gc0483BJxK08SYm6L9/2rjfUFtY+LWeJ3g=;
        b=LLe9/VI4wlXv7fXN2D1SxD0vkHj16yJE7p20QB1F7rVQm3mty1PEWE6FPY16RqetjB
         7MYtc6CB3gVeGnFBNomHv9w9M3Fn70lUyXgEfx/N8y/40TzQTm7xzIGpwquI69yLPRif
         ilIVVYwMIJIn378v2e8B4ZcoZuuq/obGAtnh4tQDGHCBXH0jAgczgs/7KEu697Vzacw4
         X/XB4eFsP/dBO/7wFyEYgOVlREQZSayE8AoCBsuI2JMtl3iQCBrgc9aILhqjJ4PRLKEb
         fmSTUT46OiU57vBALdFYOvatBWvOV6OXDo5BR6LJzi3CpuxiHtKWPmWv8/VjBtiPGRcP
         O6Yg==
X-Gm-Message-State: AFuF++k2WJdtzAkSXLQNW0jQsqrSBt1zOVsa3AnNnEgA/LDITII82cXb
	224yh5fy6hckm2GhZ89IdUUxTWnEKA8srMWglVw59VUOkk206yB2QEBKqUoAqCwPbZKAWxaha+U
	cj8Aer89bGevxrwW4zGQMSoQl+w1Gnlx8IrtthTR3Dg==
X-Gm-Gg: AYBFou2zdCapIfKhuw5lBJrq9F0jNRKy/3KiaCgKWMHdIB1Ilhk2OQd0FjbOM57CaQ5
	/8RyoS1TNd6YxilO7lWE1GCalnW2HzayFFpyJ7kASillKAHiIHqedWwRklcw+q07w06yxJNpJGt
	fnsZorfWLcUSSmS9NHk06SCnbVLlqdHIsL4+P8tPzZNyTacOz0u/lgRl0y2FVkGN0WhbAYe11dc
	dwOIG/3BOpgcKqtG706edPTioUfSmQBikTN0Lt4mH5oA3JJuIzRP64YxSCuolzOWbNorzAOUZj9
	YB3ay8MX8OiHo5qxBOvoZMmHABtc5nIkmA4soPVCijLM
X-Received: by 2002:a05:690c:a785:b0:855:f387:98c0 with SMTP id
 00721157ae682-87127d27776mr100496437b3.29.1788896260803; Tue, 08 Sep 2026
 12:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-libbpf_arena_thing-v1-1-0092c0e0d91b@meta.com>
In-Reply-To: <20260908-libbpf_arena_thing-v1-1-0092c0e0d91b@meta.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 15:37:28 -0400
X-Gm-Features: AcwNN1VC7_sy8GNpqVMftJc7alvolcVEPApn9QYXmBj9xTdY9kVTS7Q_F_naopw
Message-ID: <CABFh=a6J9Wq6WEi9YFDFYDYuiovVL8soGH=LS8R_DOSNgaWxkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: defer arena map size check to load time
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 3:33=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> init_arena_map_data() used the build-host page size while it opened an
> object. This could reject skeleton generation when the build host and
> target use different page sizes.
>
> Validate the size during load, before libbpf calculates the arena data
> offset. This uses the running kernel page size and rejects an
> undersized map before relocation.
>
> This problem manifested when cross compiling BPF selftests for
> arm64 (64K page) on x86 (4K page). In this setup skeleton generation
> fails.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The bots have a point about the unnecesary check, but not about the
NOBITS section.

> ---
>  tools/lib/bpf/libbpf.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed8..413b8b305194 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3018,20 +3018,8 @@ static int bpf_object__init_user_btf_map(struct bp=
f_object *obj,
>  }
>
>  static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *m=
ap,
> -                              const char *sec_name, int sec_idx,
>                                void *data, size_t data_sz)
>  {
> -       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> -       const size_t data_alloc_sz =3D roundup(data_sz, page_sz);
> -       size_t mmap_sz;
> -
> -       mmap_sz =3D bpf_map_mmap_sz(map);
> -       if (data_alloc_sz > mmap_sz) {
> -               pr_warn("elf: sec '%s': declared ARENA map size (%zu) is =
too small to hold global __arena variables of size %zu\n",
> -                       sec_name, mmap_sz, data_sz);
> -               return -E2BIG;
> -       }
> -
>         obj->arena_data =3D malloc(data_sz);
>         if (!obj->arena_data)
>                 return -ENOMEM;
> @@ -3107,8 +3095,7 @@ static int bpf_object__init_user_btf_maps(struct bp=
f_object *obj, bool strict,
>                 obj->arena_map_idx =3D i;
>
>                 if (obj->efile.arena_data) {
> -                       err =3D init_arena_map_data(obj, map, ARENA_SEC, =
obj->efile.arena_data_shndx,
> -                                                 obj->efile.arena_data->=
d_buf,
> +                       err =3D init_arena_map_data(obj, map, obj->efile.=
arena_data->d_buf,
>                                                   obj->efile.arena_data->=
d_size);
>                         if (err)
>                                 return err;
> @@ -7489,12 +7476,20 @@ static int bpf_object__relocate(struct bpf_object=
 *obj, const char *targ_btf_pat
>                 bpf_object__sort_relos(obj);
>         }
>
> -       /* place globals at the end of the arena (if supported) */
> -       if (obj->arena_map_idx >=3D 0 && kernel_supports(obj, FEAT_LDIMM6=
4_FULL_RANGE_OFF)) {
> +       if (obj->arena_map_idx >=3D 0) {
>                 struct bpf_map *arena_map =3D &obj->maps[obj->arena_map_i=
dx];
> +               size_t data_sz =3D roundup(obj->arena_data_sz, sysconf(_S=
C_PAGE_SIZE));
> +               size_t mmap_sz =3D bpf_map_mmap_sz(arena_map);
> +
> +               if (obj->arena_data && data_sz > mmap_sz) {
> +                       pr_warn("map '%s': declared ARENA map size (%zu) =
is too small to hold global __arena variables of size %zu\n",
> +                               arena_map->name, mmap_sz, obj->arena_data=
_sz);
> +                       return -E2BIG;
> +               }
>
> -               obj->arena_data_off =3D bpf_map_mmap_sz(arena_map) -
> -                                     roundup(obj->arena_data_sz, sysconf=
(_SC_PAGE_SIZE));
> +               /* place globals at the end of the arena (if supported) *=
/
> +               if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
> +                       obj->arena_data_off =3D mmap_sz - data_sz;
>         }
>
>         /* Before relocating calls pre-process relocations and mark
>
> ---
> base-commit: 3fa3128887a4df6057c543aae7c5c7fd2ed41f12
> change-id: 20260908-libbpf_arena_thing-0d63a985f4f3
>
> Best regards,
> --
> Mykyta Yatsenko <yatsenko@meta.com>
>
>
