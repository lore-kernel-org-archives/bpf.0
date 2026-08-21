Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13C3DC4C2
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338303; cv=pass; b=D8dqTmD5+WDWpGVGv3WPZEhHtdURY6c+KnoophBX4lesOQrQkPPBk7rp2Agie0+C2ZdXJGhMeSoMR+33f0cvsdRhzoji6Z4tdBcKu7zVh/IzIlyjn45eZZC8Bpc+qD6RwNVi5+wXlC+PaTRUxk1eKv19JawxTmLDY17A4mINrRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338303; c=relaxed/simple;
	bh=NIWMkIUbvXPAl6EKgLhdrXX7S7LGSTaIhRjSJEMIXxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dG5j+/FEuRu8Btk5DGjOrdGyBx8V5ChPmFriprfb0CXUL5xShqTgOwpUOuBjuRC4fpw3BkkX3+6hZzWTkKZp3vFrER3DKQvyhVCj9hKU/cvGlRmwIFmcAohGZEkV6OIlF0oRk/BUQt2PaZe4PY9LLZS8pM2+zRbT4Qudvy2thYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rU7g80wD; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU7g80wD"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a2c90e383so1815324b3a.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787338301; cv=none;
        d=google.com; s=arc-20260327;
        b=PWMLXBz6uxLtMEh1lZArUw+XIRQSaKzr66m14+4iz5X6YavDPkmrF8kDRasfI3oNK8
         1Y+uuD5i3NLxgXie8+FRMHIrAYX6QKJCE8gdf4I0s5tW5SzIcxjV3HquhoDXRJDqEwJF
         VIkXv8m7sGL8cuN7kSQGAlhY+Lxh78MjTz1Xef2CjbEiMGnNTpODdz8anZIdDsVjX85R
         LzeN+nZLYFItuZOpptOdIr44D/luJEs+zycpYg3bbTEqh4iQtvOu/Oaf4JABUSpWNDOO
         9n3EH/T/u/Xw8TUz9keIBiznkfOpqHEvEgwo0omYb3tQVok1f6xyAIEwd82Z9Rr+hawu
         FJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oWZLGtODBbyXHduHG3YdRMHM3iRLVvqAMmx1MHvzdFc=;
        fh=fonSHgHYE5ZJPr5anOjD7Kwz5jQXZ8wUKHVTw3oaAa4=;
        b=d3IBiLWdQwFuOMtJAxYcOwQRPCt9C70y27gjjX6XovdjRfkMkyL+f24fzQr76SgARI
         JsPPSbw2vO1P8i0VOe6FNg+2LNDiD/X/Y/X/rze13R8//RWwmoP01SVcmJnddg75bbF8
         HEgaFOudUTGuWLp3n0IoRUVOIDL+g/vI2CH3dRc6nL9s8VAskWwJeC/V9Q64z/DGQ3/N
         eQcz0q6NR6JCozQsH3DbE5FCYLNe2XU9yMslIrGSqTeppmj+djBMS/0UDO943IWUpbR7
         mOo4CqgU//mL3VqvVFvDeINr8611XTdI0yuaTOPrDoCRYFiKNeiZ0Ok8Z4BoJQ3yttwz
         7nUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787338301; x=1787943101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oWZLGtODBbyXHduHG3YdRMHM3iRLVvqAMmx1MHvzdFc=;
        b=rU7g80wDOXaAb4jBhHV9An+67bgu3DLz0OjQ5iNWcMu7Wfy+gIDfVBEjU/kJzTv/Z/
         1IQuC/TFt9ZNj1eqi21RYgnckcBukFR/oWKcTrHMwxZMSTBu93sjhUZr25hSEsP4pYK+
         gRpZ1GLLfOTiSmhqVFY5ogzFqasxy0jloyQ0o/0Y7mlZQsArnZiF7tfIzeYI6QaYcqry
         M4JzB4vNh066h2DHsEIqnHWW+X2Vg7QPpp5WjH+60KZ7OeMIK1ojPLYCbl6+GyXh5Zlj
         A4mAqvikRInLwRUU3HPzMDbqOvAT5cV2kh3C2PLtqz7qjdudtd13QERh9sLqwm0Gh67e
         x34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787338301; x=1787943101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oWZLGtODBbyXHduHG3YdRMHM3iRLVvqAMmx1MHvzdFc=;
        b=AFGqnKKFftWoNEKDGmR+s3kdLvsbWRXsrYhHbwo96rsBDKpanb02EC+lKcHV1wFUqO
         l1ftbTi/sAArnXKQocxKblduVSc9toqDVLR2RhTfc4h075jOdFEXce0cSDn8z01ds9K9
         fEy7OCyB5lOoZ9vaDQFWWrCg4Jv8id7JCezLXLFIv/VVdCZGwOTx2i04lnwyUxItq5qQ
         kTWKlmR4lKBhoJz0uucsfS0wkxfsZTjyLpNwRvDjjnD/46XZKtzeeIhJoIvmxp98OTMa
         gFTj6TVpZiOKfm4Dla/zO6OzuH28rT61ulvH6PLK09p15U9CIX/FYXicBd3KJxeIIHwy
         mubQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbcK/KzF/mI6iI+sPTrmhqzOUVwP2jo8OJY7lb33F3bjFXm/e1+M+nFXecaCKMFcIyQNg=@vger.kernel.org
X-Gm-Message-State: AFuF++mWNTNyB2SlldTXI1MQrwgTsPuJvfwNVHxQepHqci0PUdvZcRv+
	lEpngk/7EV39xy+LLv/Kv9xuLqXH4uIl0hEHR2mVVsDvv3YPqGYGr5hzcnw7vIWRsexYbhkkpIO
	zGBJY7mp29rJof6C3+gRHXTiEmcOKigc=
X-Gm-Gg: AR+sD10O0JXBbncgB57ZANbfrWW3KSNko/AlGVTuBfkvZpOYQSVtwOty7yqew5PsGo2
	dGFiYIw8MldLdmF9zNb+gB0x7yI0fbjTq0JauUPorKOZACrV4woP+w4fYxJHe0KBDKX2UHJAKhz
	FgMNwG0nXUVWNeiTOeuTI0whZOYYKslOaKeG7v2DwidJ6TLrMjo5i6k/aaB5bcjq7Oqjheumdmr
	VOU0s79eheOuv+SwhlDE7XpiHOnDLU1RoLaRnGhiZkHnBgv4d5BMHlXmSRxxkfJx1LNYfOeGZjY
	GJeyfVHMyNGQSwnoLcZ76yqpFnZZDtUw9Wlr6Z25gkJt6VWSXOWQDOkDJfH4KEIDq9XF2MBK8TH
	b/miHYowpYqqZ9J6/c7xGvwxbLg==
X-Received: by 2002:a05:6a20:d805:b0:39c:4e62:b843 with SMTP id
 adf61e73a8af0-3cd31b9c813mr9418948637.10.1787338301310; Fri, 21 Aug 2026
 11:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819090426.267-1-zhaofuyu@vivo.com> <20260819090426.267-2-zhaofuyu@vivo.com>
 <5efea1c6d5feb9bfc4ffe3eedde9ab98c2613776.camel@gmail.com> <7fcd1b5f-dc15-486d-a56f-4961a25b133a@vivo.com>
In-Reply-To: <7fcd1b5f-dc15-486d-a56f-4961a25b133a@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 11:51:29 -0700
X-Gm-Features: AcwNN1XkOXrewpBSkANR7_Y5df-c4uXL2CXnt-IDty4MWVZudHFMenfRjr9_y8E
Message-ID: <CAEf4BzbbdjeSW88EEk2xRvAxq-HWUJ7qTw4BYnL3kLH0f0uhwg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel
 module BTF loading via bpf_object_open_opts
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	shuah@kernel.org, yatsenko@meta.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:51=E2=80=AFPM Fuyu Zhao <zhaofuyu@vivo.com> wrote=
:
>
> Hi Eduard,
>
> Thanks for the suggestions. Please see my responses inline below.
>
> On 8/21/2026 7:58 AM, Eduard Zingerman wrote:
> > On Wed, 2026-08-19 at 17:04 +0800, Fuyu Zhao wrote:
> >
> > Overall the logic seem to be fine for me, please find a few comments be=
low.
> >
> > ...
> >
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 514e4e9daa82..37934ca49dd7 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -779,6 +779,13 @@ struct bpf_object {
> >>      char *token_path;
> >>      int token_fd;
> >>
> >> +    /* kernel module BTFs to load, as specified via bpf_object_open_o=
pts */
> >> +    struct {
> >> +            char **names;
> >> +            size_t nr_names;
> >> +            struct hashmap *names_map;
> >
> > We already have a strset type, please use it instead of a direct
> > hashmap reference. This would remove the need for `names` field
> > and simplify the bpf_object__init_kmod_btfs() function.
> >
> > Also, do you expect `nr_names` to be high?
> > If not, wouldn't plain array search be simpler/faster here?
> >
>
> I initially used a hashmap to avoid repeatedly walking the requested
> module name list. But I don't expect nr_names to be high in practice, so
> a plain array search should be sufficient and simpler. I'll change this
> in the next version.
>
> >> +    } *kmod_btfs;
> >
> > Why indirection?
> >
>
> I followed the existing pattern in bpf_object and used an anonymous
> structure with indirection here. I don't have a strong reason to keep
> the indirection, though. I'll simplify it.
>
> > Also, I agree with the bot here, prior fields use "module" in the name,
> > so something like "btf_module_names" or similar is a better fit.
> > Same for publicly visible 'opts' name.
> >
>
> I think `btf_module_names` is a much better name than my original choice.
> I'll change that in `opts`, too.
>
> > ...
> >
> >> +static int bpf_object__init_kmod_btfs(struct bpf_object *obj,
> >> +                                  const struct bpf_object_open_opts *=
opts)
> >> +{
> >> +    const char **kmod_btf_names;
> >> +    size_t i, kmod_btf_names_cnt;
> >> +    int err;
> >> +
> >> +    kmod_btf_names =3D OPTS_GET(opts, kmod_btf_names, NULL);
> >> +    if (!kmod_btf_names)
> >> +            return 0;
> >> +
> >> +    kmod_btf_names_cnt =3D OPTS_GET(opts, kmod_btf_names_cnt, 0);
> >> +    if (!kmod_btf_names_cnt) {
> >> +            pr_warn("kmod_btf_names_cnt must be set when kmod_btf_nam=
es is provided\n");
> >> +            return -EINVAL;
> >
> > I kinda agree with the bot here, why disallow an empty filter here?
> >
>
> I understand the point now. I hadn't considered the use case of
> explicitly skipping all module BTFs. A non-NULL `kmod_btf_names` with a
> zero count is a way to represent this case, so I'll support it in the
> next version.
>

besides all Eduard's suggestions, one naming nit: don't use double
underscore naming, those are reserved for extern method-like APIs,
while you are adding internal helpers


> >> +    }
> >> +
> >> +    obj->kmod_btfs =3D calloc(1, sizeof(*obj->kmod_btfs));
> >> +    if (!obj->kmod_btfs)
> >> +            return -ENOMEM;
> >> +
> >> +    obj->kmod_btfs->names =3D calloc(kmod_btf_names_cnt, sizeof(char =
*));
> >> +    if (!obj->kmod_btfs->names) {
> >> +            err =3D -ENOMEM;
> >> +            goto err_out;
> >> +    }
> >> +
> >> +    obj->kmod_btfs->names_map =3D hashmap__new(mod_name_hash_fn,
> >> +                                             mod_name_equal_fn, NULL)=
;
> >> +    if (IS_ERR(obj->kmod_btfs->names_map)) {
> >> +            err =3D PTR_ERR(obj->kmod_btfs->names_map);
> >> +            obj->kmod_btfs->names_map =3D NULL;
> >> +            goto err_out;
> >> +    }
> >> +
> >> +    for (i =3D 0; i < kmod_btf_names_cnt; i++) {
> >> +            size_t idx =3D obj->kmod_btfs->nr_names;
> >> +
> >> +            if (!kmod_btf_names[i] || !kmod_btf_names[i][0]) {
> >> +                    pr_warn("invalid kernel module BTF name at index =
%zu\n", i);
> >> +                    err =3D -EINVAL;
> >> +                    goto err_out;
> >> +            }
> >> +
> >> +            obj->kmod_btfs->names[idx] =3D strdup(kmod_btf_names[i]);
> >> +            if (!obj->kmod_btfs->names[idx]) {
> >> +                    err =3D -ENOMEM;
> >> +                    goto err_out;
> >> +            }
> >> +
> >> +            err =3D hashmap__add(obj->kmod_btfs->names_map,
> >> +                               obj->kmod_btfs->names[idx], 0);
> >> +            if (err) {
> >> +                    zfree(&obj->kmod_btfs->names[idx]);
> >> +                    if (err =3D=3D -EEXIST) {
> >> +                            pr_warn("duplicate kmod BTF name '%s' ign=
ored\n",
> >> +                                    kmod_btf_names[i]);
> >
> > Nit: I'd downgrade this to debug level, if at all.
> >
>
> Agreed. I'll downgrade this to debug level in the next version.
>

when you copy over a list of kernel module names, sort it, and do a
pass to detect duplicates. if there are any -- just error out, specify
in the documentation that the list of kernel modules names should not
contain duplicates. It's not a particularly limiting restriction, is
it?

> >> +                            continue;
> >> +                    }
> >> +                    goto err_out;
> >> +            }
> >> +            obj->kmod_btfs->nr_names++;
> >> +    }
> >> +    return 0;
> >> +
> >> +err_out:
> >> +    bpf_object__free_kmod_btfs(obj);
> >> +    return err;
> >> +}
> >
> > ...
> >
> >> @@ -8515,6 +8645,7 @@ static struct bpf_object *bpf_object_open(const =
char *path, const void *obj_buf,
> >>      err =3D err ? : bpf_object__init_maps(obj, opts);
> >>      err =3D err ? : bpf_object_init_progs(obj, opts);
> >>      err =3D err ? : bpf_object__collect_relos(obj);
> >> +    err =3D err ? : bpf_object__init_kmod_btfs(obj, opts);
> >
> > Nit: all other options are collected before bpf_object__elf_init()
> >      call just above.
> >
>
> Agreed. I'll change it in the next version.
>
> >>      if (err)
> >>              goto out;
> >>
> >
> > ...
> >
> >> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> index b965ad571540..2f8ff6d2d3df 100644
> >> --- a/tools/lib/bpf/libbpf.h
> >> +++ b/tools/lib/bpf/libbpf.h
> >> @@ -224,10 +224,24 @@ struct bpf_object_open_opts {
> >>       * point (/sys/fs/bpf), in case this default behavior is undesira=
ble.
> >>       */
> >>      const char *bpf_token_path;
> >> +    /*
> >> +     * Optional list of kernel module names whose BTFs should be load=
ed.
> >> +     * kmod_btf_names_cnt specifies the number of entries in
> >> +     * kmod_btf_names.
> >> +     *
> >> +     * If kmod_btf_names is NULL, all module BTFs are loaded, preserv=
ing
> >> +     * the default behavior. Otherwise, only the specified module BTF=
s
> >> +     * are loaded.
> >> +     *
> >> +     * kmod_btf_names_cnt must be non-zero when kmod_btf_names is
> >> +     * non-NULL; otherwise -EINVAL is returned.
> >
> > Nit: please add a complete list of behaviors this affects, e.g. CO-RE,
> >      fentry/fexit resolution, etc.
> >
>
> I'll expand the comment to cover the affected behaviors in the next versi=
on.
>
> >> +     */
> >> +    const char **kmod_btf_names;
> >> +    size_t kmod_btf_names_cnt;
> >>
> >>      size_t :0;
> >>  };
> >> -#define bpf_object_open_opts__last_field bpf_token_path
> >> +#define bpf_object_open_opts__last_field kmod_btf_names_cnt
> >>
> >>  /**
> >>   * @brief **bpf_object__open()** creates a bpf_object by opening
>
