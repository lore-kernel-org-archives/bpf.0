Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC8489894
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355577; cv=pass; b=jWe4XXF5ps3Owqk1fBN0peJCQQiH8Y3YVO+vHtL3yFeLSa/hkUfyWoemxpH2C0jAggerq7cXsRqBsRPfYfHTFiF0ltvvGa0QPREW8G50eVUhf6dfHkB8RAIqHYtYW0F4QiZkEj91E/Dfzw099U102NTXIk1bWp/o5rYy2VMjpz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355577; c=relaxed/simple;
	bh=tTU6JZGZOvue0kDFn6nYR2jIwOQbF8oGNO2Mg4+Pvi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArmNAEAi3BOaZ+SIhUx+gNCCWB/IccjV3zIDXnWohgroJ18uB4bU9sP46RTL+ntf0JPF0bf4GLWDPi48zOlgBRwrr+26e+89ZsumBwwVUT4Iem5u2ko7XpdXhNIj0YLwpZ4KfbKseARy+ZS8Qbb7J/N8zCPwbP498nY+nisaWVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwux1EpF; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwux1EpF"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ec29f1d07so21054077b3.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 13:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785355575; cv=none;
        d=google.com; s=arc-20260327;
        b=M+3vlLi/Lptj56JQQIy7Y2ekHnLvhRBO5QzfWb8jXaIFdKv/3mv3hAqnNfDh9JuU9v
         Kaam2bmQCBt4lmssS1398CG0V/scGvIUjvNMO4rQzfaBITV2kgXNbg7Et04WrTmKWfob
         64G3s5wH78wZ4/nLcNtfzx0COi008vu+8FyOXLqT+vTp2xSLVqzfzclgGa68DTzABpoX
         /IE8jieLWumrbR6/YHXInwk7kUKNjdGvSHtb65hUgHrAbAzciUj9eLUwgV410uIX4Ii5
         zZRaRYDn0/UCDetwnExxIlm+882rvkscaQcrstHTyoPAKeZRQO8sEjEwDoKsgfgAPZY/
         MsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xsU6muzSAhhb0AtlUgD5PIcLLiXxDebY1d1TtQRW1C4=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=L0RDnwKVCQ/KD4Ea21SB3kqO8NW9ShwdH1EtOCiKcp/0iolGHyGH2nD6G5Y5cv1vgS
         IsBlLX9vRV/WeV2dQpS1ECfWApOrISRgefB45EgrW/+7R6tk6MOC7cvAAF38vP1fUEal
         LGLczlhVVJUr1mpFQuJ8inNDJOX/Tk/5QswmyZZIuAY5p03hk/mv+rCDsZN4SHV4ahB9
         3Tv00iYmlJ54EUiKwRDFU00XMkcvRWpxPGAeHdpNIn46t/r0ISf336XF8JdsRaF52kpU
         Pd5eftSO+MBhLL4j79Aoq4HGIa0+XJxeRjuESrOC6WdXm2YNYFitzzcehufu9IKw0Fuc
         Bxqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785355575; x=1785960375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xsU6muzSAhhb0AtlUgD5PIcLLiXxDebY1d1TtQRW1C4=;
        b=mwux1EpFdZqLzExVrM7PkanxF9kKErDmjuFeZ1EqGKrhcrOv4fugdeaN+O/a9OnbQu
         qAd8GVvJT9dWdkyK9Yn8BNEqaUnrAhYEMLffd+RpMxxOME4/OgwqoQApt/37PBwqcpe8
         Vj+vYLqwD2ADuVIhtsJYAec1nItHoWMzAU5l7qVTFM6xHMvvRY6MzQsuy+TY4qjs9qMj
         F1eZ9B+0obgvP9yC22QygX2G3nagFuj+rF+SGzDywGrgaLn58Xj333LYgkVu6SrnCy5u
         a7OWSweJs66pf2io1IgUZOUmx6rp7wNaT5CferJjr3xNf6FnHlgP+oJrQCoWldnW09Da
         VNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785355575; x=1785960375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xsU6muzSAhhb0AtlUgD5PIcLLiXxDebY1d1TtQRW1C4=;
        b=rGsTqbVkYFk/Yo/GQnqU+5qUL21ITgrL+kZzcKaDOJW8QF3OAhj3y/m9wWJ+22w65L
         RhlQF4V5AiSA0EGuoC0rU1yf8ujyrZnjuUtNEXQ3dHU4qVasV4hSH25bEUuKclyM5Cor
         ancMfQvgUWNqgiBEkmk1ZDeDR+1WxzGYq92qf5szZ1kqtJ8XskgnslQJWXwKtAJzIDfC
         F+4TT1SA4lNvrjwv62vbgZ/uAiaKb6SMiRkgWuHS2rihO7u0av+AnkHK/g8UvzcSCXZV
         /gBFyeDa1FZnH1UkJIdFM4rHzNU5jPu6QUQxsnFixrSn8WfCkuyOGBfRiTOojZUjpKG0
         OEXw==
X-Gm-Message-State: AOJu0YwfpapjFRxMwVBM3+5G7FavhMrSId3qmZgmUOoAFpLX7e+D/WG2
	s4ySbsfE4QDUgm/l/hy2DGMCHXGIYudptVV0WyZR9JH7yGnRxqdn+bAbya84S0D6lbjOrNVkQ6o
	VH9aXZga0VCfO8U9FKPFZhl3mVf08uWI=
X-Gm-Gg: AR+sD11HMKn5Zd9/xI9uveuhuV0vZYcyQrzfcgEx/nJ507HJUxJXxqJEY0Kgnoi1oF7
	5XpdDJra78CwjCYs/+qeQka0R8mjXm/Xd8IOKQ03hv1nsbTU1g9NfZJD+ZQSmz9NZ/xO4T8G7mY
	IemjreX3eYJ7FAIkGkCFEzfGayOQ/61aoNAP0s6hncpgHge54819p1YCkcWA8FhbLzjVTZnuYEb
	yrdWtumO5ouHA8VZ2lSsWq2Vr1/+JQrVYzHGWdJ8MFITdZEX0W8pmvP/k3ccQGpN11qmBGOU4Wt
	KdnpX9Q+n75uKffe49eo9MNhHCPZm5QR79J6Whrcul0Ksrt8XSHrwuhs
X-Received: by 2002:a05:690c:6903:b0:81e:7075:e2e3 with SMTP id
 00721157ae682-81fb5d538d4mr2193387b3.35.1785355575275; Wed, 29 Jul 2026
 13:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-19-ameryhung@gmail.com>
 <40ad8565f90619452bde3800cb246bf23b0e95e2.camel@gmail.com>
In-Reply-To: <40ad8565f90619452bde3800cb246bf23b0e95e2.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 29 Jul 2026 13:06:04 -0700
X-Gm-Features: AUfX_mziu0qIIbt_7Z9ebe1SoiTkZHQwbaTQWnhkRDkwmilv6dn0KnClwZlsYAA
Message-ID: <CAMB2axP22ryKt8HYuTffFWjbCYMKXgcB_eg9pJsuyFqLQMKoVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 18/18] bpf: Generate kfunc argument prototype
 at add-call time
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 2:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
>
> ...
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index b54c1a5c9b11..0655164e6af2 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>
> ...
>
> > @@ -1305,8 +1306,19 @@ static inline u32 type_flag(u32 type)
> >  /* only use after check_attach_btf_id() */
> >  static inline enum bpf_prog_type resolve_prog_type(const struct bpf_pr=
og *prog)
> >  {
> > -     return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->saved_d=
st_prog_type) ?
> > -             prog->aux->saved_dst_prog_type : prog->type;
> > +     if (prog->type =3D=3D BPF_PROG_TYPE_EXT) {
> > +             /*
> > +              * saved_dst_prog_type is only set once check_attach_btf_=
id()
> > +              * runs. Before that -- e.g. when generating kfunc protot=
ypes at
> > +              * add-call time -- fall back to the attach target's type=
, which
> > +              * is available from load time and holds the same value.
> > +              */
> > +             if (prog->aux->saved_dst_prog_type)
> > +                     return prog->aux->saved_dst_prog_type;
> > +             if (prog->aux->dst_prog)
> > +                     return prog->aux->dst_prog->type;
>
> Let's avoid this fallback and set saved_dst_prog_type
> in syscallc:bpf_prog_load() in the same place where
> `prog->aux->dst_prog =3D dst_prog` is set up.

Makes sense. This looks better now.

>
> ...
>
> >  static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e44fc7296d0c..1ca8779ab59a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> ...
>
> > @@ -2806,11 +2823,29 @@ int bpf_add_kfunc_call(struct bpf_verifier_env =
*env, u32 func_id, u16 offset)
> >       if (err)
> >               return err;
> >
> > +     proto =3D kzalloc_obj(*proto, GFP_KERNEL_ACCOUNT);
> > +     if (!proto)
> > +             return -ENOMEM;
>
> Nit: since `proto` is allocated for each kfunc object I'd embed the
>      structure directly into the struct bpf_kfunc_desc and make the
>      struct bpf_kfunc_desc_tab dynamically allocated by bpf_add_kfunc_cal=
l().
>      As a side-effect, there would be no need in bpf_free_kfunc_desc_tab(=
).

Ack. Will change.

>
> > +
> > +     memset(&meta, 0, sizeof(meta));
> > +     meta.btf =3D kfunc.btf;
> > +     meta.func_id =3D kfunc.id;
> > +     meta.func_proto =3D kfunc.proto;
> > +     meta.func_name =3D kfunc.name;
> > +     meta.kfunc_flags =3D kfunc.flags ? *kfunc.flags : 0;
> > +
> > +     err =3D gen_kfunc_arg_proto(env, &meta, proto);
> > +     if (err) {
> > +             kfree(proto);
> > +             return err;
> > +     }
> > +
> >       desc =3D &tab->descs[tab->nr_descs++];
> >       desc->func_id =3D func_id;
> >       desc->offset =3D offset;
> >       desc->addr =3D addr;
> >       desc->func_model =3D func_model;
> > +     desc->proto =3D proto;
> >       sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> >            kfunc_desc_cmp_by_id_off, NULL);
> >       return 0;
>
> ...
>
> > @@ -8858,7 +8893,7 @@ static bool check_raw_mode_ok(const struct bpf_fu=
nc_proto *fn, struct bpf_call_a
> >  {
> >       int i;
> >
> > -     for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> > +     for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>
> Nit: here and in other places I'd keep the ARRAY_SIZE for uniformity
>      (and if 5->12 move is bothering, one can break at ARG_DONTCARE).

I will revert and add ARG_DONTCARE break. Going through all 12 args
adds an observable slowdown in the verification time.

>
> >               if (!arg_type_is_raw_mem(fn->arg_type[i]))
> >                       continue;
> >               if (meta->arg_raw_mem.regno)
>
> ...
