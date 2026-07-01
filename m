Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF60349CC2
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931192; cv=pass; b=Oze8paZW+dTkQKtmgTMixl//kjhiaPErGKD6ZsmZTXCIL5mu0XGDf9svsok024C26eIqUR0BpXslyjzPEHmi2yhsSZsZmmuq+zENQpI7lik97OJRWsPzotMRN3eXJ7rFz8ehQRzP+FhNoDvX0d1yu5vDVZ6WSw1sff6sCuqM/xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931192; c=relaxed/simple;
	bh=pyx/uJvyjkFXNg5E/FFHBRsEGjYq3wYQ0SJpYk782vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDIgosihk19g8BvK+He3xEco0gvIFA3PPxmRtVufyw7/PpUZEyIla8hvFhAGDmmsxvHSyBqzZpy3VQpQ5sCYz+9fg9MLCnKPff6lAmYBbgbMGCq3KRpOv6OO0upyQhpBGjZaEEE3mEhZf1DBbYE5g696UOhZM7Psz92G5F/P7M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhKba6R5; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhKba6R5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ca64989e64so8051115ad.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782931190; cv=none;
        d=google.com; s=arc-20260327;
        b=ee7MlbcCkrDgtmDcXI+AgSMZxPBWnSnKGYcBhOpZXdOfwhpUEr41sr/sEEWYzUWJLg
         HgPi2FXtXygA8tLxA67wTJHSgf/6qTeutlaRujuC6INZcKcMqwX5PN8Q0P2ld6q5vnmu
         iq+vB+RB4pOw2Aq4F7elVx13NHYvWFUtDNUEmC4zFbG3yhUchsxXZxfHaCZhFJXctH21
         5wXSNX5nKmkPNrUmjhnjAiCWMyK2h3aU1Rsof7E12KGfxXOGiAAadUBnVkjmC5e+0cvN
         rohhDGCISXOZICP0jW7degBT8THWalfT5I/e79aHFRDlZ0Ktjx6xV2ctQdOap6VE+gIJ
         LIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OcJ1T40T7OqbMLRfoUFAcB69NPd6V8TpoLlcNTqSeCk=;
        fh=lVTZS21qiTifbYaXu+fLr7xdUR7Vev8dLip6M5xMv6Q=;
        b=ehD7A80EaJICfKT5gKVsGjVeE13YwR90BDi/LkoJ2LKfwWiNz/V79WF+DWWPsGildg
         tOCagY2a43ks1fDTMITPeKC83C7dwUHpCCLMxq6hOoLnvGJOyMKgkoo0llgRcyopByUP
         mB+kFmGNl5sST+ajRQR1ddxD28i3lO9Yk2Qu4GH+zmqRC8uBOFKW+YfRBCrmyY5KqrhS
         VbEpajSkZhgQYeEJVu/5WyIVE6QAxwHs9t3BbOwP8k7uQKBpnGGauVNDN0Slp7O8hOz+
         V6IKI6Bk08NQbLD8kJsChuagOA3xUUdUktb+oE0iiBopKhjLqyobEVNt2x1MtgvVZ9en
         4egA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782931190; x=1783535990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcJ1T40T7OqbMLRfoUFAcB69NPd6V8TpoLlcNTqSeCk=;
        b=HhKba6R5BhaJRKBnKNeX1UNV15Hg3Vdk4iA4QqJSC4VSbP04vnFsK6eo+MQQCIaXvH
         4FyduR5StSvUevdEOGXpFdd2NA0yTbSRecg8nw3j4vjZDWfv5978VszILqa1mIeu0IKV
         5/+gYCd9Cv5hqVAW6dZ56gdcKj/AxOojrNeStrn/8tXtL4H/34pvXIn1DeyCyj2kUNqz
         5eliMq4DLBqMGGulM77bfjMImjoDXE9tJ40qxZA3+UHdIJDn76YoCb4ud35WNnGPTbRw
         bQfXjrVKQHuXzYR/02B1bqpxDmN+aolPl4S2RCyLPzrnTDmdheDCjGvAih2ExKRPQua2
         QUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931190; x=1783535990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OcJ1T40T7OqbMLRfoUFAcB69NPd6V8TpoLlcNTqSeCk=;
        b=eaf4Yt9jDPwPQb/iUWnIgvptQQbM3dPQQlpdk9mpn0l+QaKBlvOjgd5kGApdUhaG31
         YJFjcRPeW1ppFfrRP3s6TN5YeSuR6n4KhIXPikGC9dz7EVvHqp7hgbcYXP41rqes8zEs
         jITTj2NFHuL4tFQDrFv0iNVh4VLUjch0O+bSX3NMLDAoZ2sBjd+z6I02pPkRDlhiD1lI
         Tts0FyQPXoDuNIVDizGz7vpl++wZmtvW7t6kNjUx/FOLtreyyB0uT5JucTzAnPKelqpH
         PaCN7E7ZbwVl76IYk08ftomlVFgDwARKAqF5vpRogXHRorKZmyvOs/MbHz2K4hlXKAv0
         Z65w==
X-Gm-Message-State: AOJu0Yx9mUeVJIIIH454eHIBFJhPaGPtMm4c7fKt8CgBGBDggoadFusS
	gWYxyZ633ofY4MSHe00h114WADLfupiIBS+iBp/4590N25/BKBAza2dcsnw5s9FjraViNjG3JeU
	KHWMrWyysRc21ZC7s+n//1jUbl/MDcPtUfqMf
X-Gm-Gg: AfdE7ckWKZ/FSEtQQ5XrBazK58qayLtsFhfNa4w0gnWSsmpXnKCdwA2bQ7xEv7HstWp
	6LDz0ZGtXmiUNDwDamyFvexX3jvwSPmFkyW9EJDsoncJgQc0qFC+gcAajUPrSU57/pA2R71TuZi
	jl6jRIFnE/6FAg+CPELVDaQufHWH6hQJcwJebld4R+FbI0lAxvIlvRSaI2ArDltLMa51J0L4yxf
	DVdlbZMAMw9c7JLfMETBgjSSSA3q7mzneyDpEVNq/v0gzdnVgRTnWXtnfKrlNNfrD/dsZGoyTeg
	3ajR7f4qcYKWbLpT+FTdktKg3OGPiBQ/66Ynt5YKmsGJ1LJ2YRLDgQ==
X-Received: by 2002:a17:902:f745:b0:2c7:ef3b:e18d with SMTP id
 d9443c01a7336-2ca7e75b2damr31649785ad.28.1782931190294; Wed, 01 Jul 2026
 11:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626215113.52273-1-john.fastabend@gmail.com>
In-Reply-To: <20260626215113.52273-1-john.fastabend@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 11:39:37 -0700
X-Gm-Features: AVVi8Cdat2UJnhj5mFT5fkBzQk_tTjPEZksq8oo2ETx8pf3KHK3-gy9CJbNgIoo
Message-ID: <CAEf4BzazLB50iNEX9vzEzXyO8LfJh7ErxuvZmw_wG+dPrvbCDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add bpf_map__reuse_fd_from_loader_ctx()
 to allow shared maps
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 2:51=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> This lets the gen_loader use a map that may already be loaded/pinned on
> the target system. When we are loading many signed programs on the target
> we often need them to share maps to communicate/pass data between the
> programs.
>
> Note it is slightly complicated by needing to ensure on error/close that
> we only emit_sys_close_blob() for map ids that are not these shared
> type otherwise we could close a shared map unintentionally. To track this
> we added a borrowed_fd_array.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |  2 ++
>  tools/lib/bpf/gen_loader.c       | 50 ++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.c           | 11 +++++++
>  tools/lib/bpf/libbpf.h           |  1 +
>  tools/lib/bpf/libbpf.map         |  1 +
>  5 files changed, 63 insertions(+), 2 deletions(-)
>

[...]

>
> +void bpf_gen__map_reuse_fd(struct bpf_gen *gen, int map_idx)
> +{
> +       int idx;
> +
> +       if (map_idx !=3D gen->nr_maps) {
> +               gen->error =3D -EDOM;
> +               return;
> +       }
> +
> +       idx =3D add_map_fd(gen);
> +       if (gen->error)
> +               return;
> +
> +       set_blob_borrowed_fd_array_off(gen, idx);
> +       move_ctx2blob(gen, blob_fd_array_off(gen, idx), 4,
> +                     sizeof(struct bpf_loader_ctx) +
> +                     sizeof(struct bpf_map_desc) * map_idx +
> +                     offsetof(struct bpf_map_desc, map_fd),
> +                     false);
> +       pr_debug("gen: map_reuse_fd idx %d\n", map_idx);
> +}
> +
>  static void emit_signature_match(struct bpf_gen *gen)
>  {
>         __s64 off;
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7162146280a8..af1553e9d4df 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5085,6 +5085,15 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>         return libbpf_err(err);
>  }
>
> +int bpf_map__reuse_fd_from_loader_ctx(struct bpf_map *map)
> +{
> +       if (map_is_created(map))
> +               return libbpf_err(-EBUSY);
> +
> +       map->reused =3D true;
> +       return 0;
> +}
> +

Can you please give a small example on how this is going to be used?
E.g., who calls this API and at which point?

Generally speaking, I'm not a fan of such specific narrow-purpose
APIs. Why can't we just teach bpf_map__reuse_fd() to do this if
gen_loader is set for the object?.. Sure, fd would be ignored and/or
can be -1 or something, but that's a gen_loader situation, that's
fine, right?

pw-bot: cr


>  __u32 bpf_map__max_entries(const struct bpf_map *map)
>  {
>         return map->def.max_entries;
> @@ -5659,6 +5668,8 @@ bpf_object__create_maps(struct bpf_object *obj)
>                 }
>
>                 if (map->reused) {
> +                       if (obj->gen_loader)
> +                               bpf_gen__map_reuse_fd(obj->gen_loader, ma=
p - obj->maps);
>                         pr_debug("map '%s': skipping creation (preset fd=
=3D%d)\n",
>                                  map->name, map->fd);
>                 } else {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..4145a16c8963 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1135,6 +1135,7 @@ LIBBPF_API bool bpf_map__autoattach(const struct bp=
f_map *map);
>   */
>  LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
> +LIBBPF_API int bpf_map__reuse_fd_from_loader_ctx(struct bpf_map *map);
>  /* get map name */
>  LIBBPF_API const char *bpf_map__name(const struct bpf_map *map);
>  /* get/set map type */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b731df19ae69..d6c2f1d75cda 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
>
>  LIBBPF_1.8.0 {
>         global:
> +               bpf_map__reuse_fd_from_loader_ctx;
>                 bpf_program__attach_tracing_multi;
>                 bpf_program__clone;
>                 btf__new_empty_opts;
> --
> 2.53.0
>
>
