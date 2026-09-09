Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8643D3339
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986574; cv=pass; b=l3ZcBN33tFNk6T0NPoadCd4xc8HRJuwKE7BfOFx/HB60JG2vKMU8kDQNFO3qW/VkBNuP1n8ikCVfHBmOrsvVB7XtzDTdBIO3b01y4HEFccT3qnG8NY50U5GcBNmLeJf83SVEAUPpTfM59ZJ4mUoUPan095ceLhCS/7aJZ7N09i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986574; c=relaxed/simple;
	bh=VJ0O7F/5SYKKch2ApWBi8nerShoAoVYemeVpZIg91kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BefdPhagoSQl3f7sH3FuDn8Ax0TkUZTi5MfaBLnEr+a++PtTKiaMxkJapnJrrITKDYTAC9syIFHvxfqRvrtxYKpf5WMR6jNzGdftW8CI7ZJ29d5aZWct09lb/LL7ePnp/kg8LFBnfJufI3JEAvMsb6qRAal8T2tcK+HSXC2dPrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U187numU; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U187numU"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f48c750afcso5555945a34.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 13:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788986563; cv=none;
        d=google.com; s=arc-20260327;
        b=T8MPnddtkXL3sJOWy5h8+FzGzb4O5j7fAOumnAaOLLrUm5GoTUFrPcxTJEa/KLw11S
         fbYFgbvdQC3oTHjt9nZvTkZwtYGPJB0xpmmoWhCDUvSN44g1edeagLujVIgXqiqqB5nn
         9EHTZ4hl15fZ5Wq8HqvJb1ZdgxSZQkWx4L19vps/dU6gcA4ehDz8p79VOLmcokMs5me7
         m3u3vbkYJpDTbBDCr4Tm+aIZ7TRWOqFkVcvFIg+rkFR2V0CMEdcT+fw5eXtqbnTGgGuE
         JhcrUkIrEY7fao3u0vSDuHwGjz0hnIuHu3a7XfM+ZPVLosoxakjx3SeZ0LGBg4xlbrTB
         mj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOjsbIvurbqfkKdZ+bC57o2n3pKexvCsVcU5ZhuN9LY=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=XCqB5/sStOZisF1A6kaIz1czMkzpZTYQmSOj6VrLyGXpfIM7/aq5bw3P8imInslyMU
         dvcjFs6hloHANY1r25RmuLcVK3kUK6/twTjQmbKGPexZpO9iFPUYQ2Q64FNC+wogwzLZ
         gCK3Cf98s2kQfE5dzAD9QZ5d0aJmUY9ICp85O+hEG3eQ0rz1EfbQssTiyrCGTCjB9CCs
         H3ccQc4qTFE8413bJpEAjDi9JGjJyAABBBWXVcQ9z3a1gBR8qHLRA7XSNMddykD7R2Sr
         H+RVlaIZOJ0SEP9btTsEUn3G1Q4I0+sDiZyB2JU3dgi7T/aTZ5bAvj5/vKZoQfuOFX2t
         VuyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986563; x=1789591363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOjsbIvurbqfkKdZ+bC57o2n3pKexvCsVcU5ZhuN9LY=;
        b=U187numUMr4ROb+6X49e+DlLdi5OqsQXqk7NZU1DEn7cGvU8XHrs444CTk0oBSEq73
         66K2A3fa1Fo0JGEIh7BVgJm8hqLODYaT7JwakgUPs8IbaNeDLn6/8jEPnHgQd+eQ0zX6
         3KUPK6Yo7Sqh1/AJEWIBAZKSyXEOzWXalEYauWX4ScxhuvUclV92b3BYQo1KU+VqNi46
         Eqzbf0oBhQA3kETRQ4FT6rTUu2JEvc21MKbhbKhm4qPDXQVru9baXACb0oxLVZD8xaX9
         cLLi6Tzd66C+y1Ius9KUeQtgnNm3hobHuGmweBNwtNtK/7kwyAZ3NP9ct659mJtNv3cA
         z7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986563; x=1789591363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOjsbIvurbqfkKdZ+bC57o2n3pKexvCsVcU5ZhuN9LY=;
        b=WIA3/P+g9mEAR0G2ypUxDNmYLXe58oSQu1UwUwK92NjpvRIjLNON5rtJQt647ApSY+
         Hp/HLXkyMaJPoITD9fdZUEMuYWGg5g+/wakqnhMvYvgSQ9lDaSjpK4ej8k6yc+7+km7b
         9OZqpftJ7YaUkoASLerPTM1mqLCDIjG22OTbdhJIN3YG4n5EFcdGvZ8v7GVl0Sw4P6/n
         KxlWlg2kAd1jZDFgLziXqRPk4bqBrUXrJp9tVFUMPOTHKB+dE6rDUtLfI2F2fAVX58LK
         RmgGho8IzYkVy5XolvPGMbedptPutgFPA9QqXw/FNjqefJ2CkqoaAb57CcolSZ6NWUN0
         6RhQ==
X-Gm-Message-State: AFuF++mklMdiS5tfhSVKAA0I1OJ7jRj2f3hQ11lYh/d+HTiLFjsYbZ3b
	xfcHK4BWZ3d1KDeHNCM+VXBNfv7gJAJfAVHiuQIC04nVykj2bR89K2vCq5B0EwtLwV4AQitmlWN
	YNn8IsmrGTbsVHIIpYNkZzlWUaIzW2Tg=
X-Gm-Gg: AYBFou20OEqcmMGAxYbpFyUIzhpJVgkIBY6jEvU1Tn1HlhOATXwptZxKVwBeK4lyiMS
	K6xxFILy5B+fDK8TLfNHaUtayVvoWfUCJ9MQ23Xh+3d2eDUSI8rtycX6KGnk0pw0Xj4yFAdddNY
	ZhV0YFdHMQ+h/b+58ZiaFXQ87ttdDXRNJIQz0Xh+QnmjBfabpE01o/EXIgR1sJlT8zdkaRHZacC
	ZiZ9SnDuOGbxWCr334DN5DR1nHl2hEmQNsW0oH0HDlpw3WP+on1YuiM1FaYjufEe2lilyeNLOuZ
	4vEmNi8OhsIz6wsRDTO2rW0PDNzzU6LY9ACjk0LrQsY/ynzPF+r1sSe2kDGIjF7sX1QFLg==
X-Received: by 2002:a05:6820:1508:b0:6b7:83c5:fdf8 with SMTP id
 006d021491bc7-6b783c673f9mr20420563eaf.57.1788986562714; Wed, 09 Sep 2026
 13:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-13-ameryhung@gmail.com> <340e5dbc173faa706ec7029f44c75431cced19fe03e2d18f9ebdbe418ec021ef@mail.kernel.org>
In-Reply-To: <340e5dbc173faa706ec7029f44c75431cced19fe03e2d18f9ebdbe418ec021ef@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 13:42:29 -0700
X-Gm-Features: AcwNN1UfI7bzngeqNVx097GuRXhShHW3Pd1RPVIoICbbIdTbI6Btxzz1uFcx6V4
Message-ID: <CAMB2axM+4aKMRrjqp+ZrNKQ=mOo+e5=y3TNRAa0ZYe8oomc9Dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/22] bpf: Resolve BTF ID of
 ARG_PTR_TO_BTF_ID in kfunc bpf_func_proto
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:08=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 1f78746e0601..fe6ab92ceeff 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1020,13 +1020,13 @@ struct bpf_func_proto {
> >       };
> >       union {
> >               struct {
> > -                     u32 *arg1_btf_id;
> > -                     u32 *arg2_btf_id;
> > -                     u32 *arg3_btf_id;
> > -                     u32 *arg4_btf_id;
> > -                     u32 *arg5_btf_id;
> > +                     const u32 *arg1_btf_id;
> > +                     const u32 *arg2_btf_id;
> > +                     const u32 *arg3_btf_id;
> > +                     const u32 *arg4_btf_id;
> > +                     const u32 *arg5_btf_id;
> >               };
> > -             u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
> > +             const u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
> >               struct {
> >                       size_t arg1_size;
> >                       size_t arg2_size;
>
> [ ... ]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c5b394e847e6..b6e36df72d13 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -12082,13 +12082,18 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_cal=
l_arg_meta *meta)
> >
> >  static int
> >  get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_m=
eta *meta,
> > -                const struct btf_param *args, int arg, int nargs)
> > +                const struct btf_param *args, int arg, int nargs,
> > +                struct bpf_func_proto *proto)
> >  {
> >       const struct btf_type *t, *ref_t =3D NULL;
> > +     const u32 *ref_id_ptr =3D NULL;
> >       argno_t argno =3D argno_from_arg(arg + 1);
> >       const char *ref_tname =3D NULL;
> > +     u32 ref_id;
> >       int arg_type;
> >
> > +     proto->arg_btf_id[arg] =3D NULL;
> > +
> >       if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
> >               return ARG_PTR_TO_PROG_AUX;
> >
> > @@ -12116,7 +12121,11 @@ get_kfunc_arg_type(struct bpf_verifier_env *en=
v, struct bpf_call_arg_meta *meta,
> >                       reg_arg_name(env, argno), btf_type_str(t));
> >               return -EINVAL;
> >       }
> > -     ref_t =3D btf_type_skip_modifiers(meta->btf, t->type, NULL);
> > +     /* Keep a pointer to the BTF field containing the resolved refere=
nt ID. */
> > +     ref_id_ptr =3D &t->type;
> > +     ref_t =3D btf_type_skip_modifiers(meta->btf, *ref_id_ptr, &ref_id=
);
> > +     while (*ref_id_ptr !=3D ref_id)
> > +             ref_id_ptr =3D &btf_type_by_id(meta->btf, *ref_id_ptr)->t=
ype;
> >       ref_tname =3D btf_name_by_offset(meta->btf, ref_t->name_off);
> >
> >       /* In this function, we verify the kfunc's BTF as per the argumen=
t type,
>
> [ ... ]
>
> > @@ -12239,13 +12248,21 @@ get_kfunc_arg_type(struct bpf_verifier_env *e=
nv, struct bpf_call_arg_meta *meta,
> >       if (is_kfunc_release(meta) && arg =3D=3D 0)
> >               arg_type |=3D OBJ_RELEASE;
> >
> > -     /*
> > -      * A KF_RCU kfunc accepts an RCU-protected pointer where it would
> > -      * otherwise demand a referenced or trusted one. Only ARG_PTR_TO_=
BTF_ID
> > -      * looks at where its register came from, so leave the other kind=
s alone.
> > -      */
> > -     if (base_type(arg_type) =3D=3D ARG_PTR_TO_BTF_ID && is_kfunc_rcu(=
meta))
> > -             arg_type |=3D MEM_RCU;
> > +     if (base_type(arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
> > +             /* A __map argument names a vmlinux type rather than one =
from
> > +              * the kfunc's own BTF.
> > +              */
>                    ^^^^
>
> This isn't a bug, but both multi-line comments added in this block start
> their text on the same line as the opening '/*'. The BPF subsystem's
> comment style puts the opening '/*' on its own line. The second comment
> below rewrites one that was previously in the preferred style (with '/*'
> on its own line), and another comment added by this patch in
> check_kfunc_args() does follow the standard. Could these two be
> reformatted to match?

Will fix the comment style.

>
> > +             if (is_kfunc_arg_map(meta->btf, &args[arg]))
> > +                     proto->arg_btf_id[arg] =3D reg2btf_ids[CONST_PTR_=
TO_MAP];
> > +             else
> > +                     proto->arg_btf_id[arg] =3D ref_id_ptr;
> > +
> > +             /* A KF_RCU kfunc accepts an RCU-protected pointer where =
it would
> > +              * otherwise demand a referenced or trusted one.
> > +              */
>                    ^^^^
>
> > +             if (is_kfunc_rcu(meta))
> > +                     arg_type |=3D MEM_RCU;
> > +     }
> >
> >       return arg_type;
> >  }
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
