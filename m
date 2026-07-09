Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218C2F549F
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783640209; cv=pass; b=eJgXvlnF0WF5Mhe8/fu//rbuJ584SVW2DhcuU4YeXG5G1y+9H6bfiC1tnXuyq/AE8ALCo7LKE7txsmK3ZjTOI679zKJr9KJNB4oasJDZ+cuRMfbj4jUD1dZaBD9YKSHv6yJ30XpHQCGzBap2ddJMf1sVsfL6IQm02GxF+ANiXuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783640209; c=relaxed/simple;
	bh=hqF49w0o9Y3pxIUlyHXKNxY20CM50UR0Kra4XyEh7q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfmdJCxl915guklFil95RdfqEW+taQxYWpokJFQrvTJ7PsXt85d8o9mHPUlsKOe3lXKOUmi0w549Sz99hjP83J7LkgGCIgXC30fbVOBweMMN9jp5zijm5n/Mt9F1HdS/aeLtUQfthpAUhpKKwy/dqcFw+lIMXUZDbhbfVWP6ZWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGNKaEAJ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGNKaEAJ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664bb15d05dso482265d50.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 16:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783640207; cv=none;
        d=google.com; s=arc-20260327;
        b=lq4wjkLsq7ULZRSKdpHro0AlHJUr/a9Mdw1kjvgf/wQfNjmz+tjU/fKPLiYRO52wUx
         m2jkjReiAxSY8aKpi3Tozj2d58B0Vg5S32P7hbvIjuIxY2dC/NW44AWbGBy0/bEzyY8U
         ODJh+vX2JAO0tQ4IPwvgdBluValFSDdeXoPiQO3HrDwC8Rl1tHvDPIM7JyrEA3vUSkRv
         ukDgNYOMvm/qGfwdrSBH9p1olcE/s8nNLwpN6TVezr9cGiRdGYnpeuiVQoaOJZ6EjqBJ
         +0OQxVgmaLzGeY5WEO17jmRGuZyjDodVHbuE1H3koMzWorehijbMsx1q1nxpCK9re5d/
         ew/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2JEFYM+Nd275OKVdEeBkO+9cqRAM0g5bLueXNaKqV8=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Q6LssIoZ12GSONdOc9eJg6oB3knBOmw4B7yjyhzY15xoueLa5yCkkQjMVLb64A2nhT
         Vsmzs7Gd3Waz8bxAOM/qljXjHWR3/KOyfnvSAO6cM6zOQ95zWMtprhi3bfV4uXs9gNbO
         OL7lvTL8pW4n0dny3usYWbGoiy+ipM1HZdawkcogT5/+ciHP36ypqQomWChJaYohpGiZ
         M16mfroTtdzrHNrHB6keWtz0ftOu6mIrO/WBqbEW+oQsFVoqydKw86pfGKWR7mLDCfLy
         JYQ1DtPaAlDCYN2KiS+q9WMZ1QlAD5FXkFmuRCDu6fkRPlcI7I2C2Ai755wSyf6BckZ+
         6f9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783640207; x=1784245007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2JEFYM+Nd275OKVdEeBkO+9cqRAM0g5bLueXNaKqV8=;
        b=tGNKaEAJCmZpYmVnPUEOR5LLbQR3kMp9CnpA0HotLXQVy9VDZMOM449EtlRy810Sx7
         WwnrQ9VFfky89xC5kep+VyfS4CjEx0z67KNE4WO+zLKPhha5k+UYkEBZ9Dy+3epG/frY
         yZxzi0Q0NiPII+fxlH892xqu09AXu/S36rFkVYzrlS3AQR5arhYbrF4OHWz+zEwW6/Cs
         paWJm8GhfB7qJWboYJR+LDOwkYA0XlB6TI4OCD3YfaXLyfO4vQbMVNc6mN/5JgfPPdCH
         MxnF3+hjTl72tSAA0rpMc7sPgTay+PicYxrt3IxDz4qK+c8QyCq3i5LUTuVOqVAFtBVR
         xc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783640207; x=1784245007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2JEFYM+Nd275OKVdEeBkO+9cqRAM0g5bLueXNaKqV8=;
        b=BApBtF7obU4Ht4MIRD/LSRVqIhquOcn2r3dej6Q/KQ9xWbv3hs/83FYEVk5QGPWMgb
         32Ik3NaVOvKn+OVJooKFbXZZxtDnFEMKi+v8pMia5qa7aoPoR6A5oxdF8enrYGOb0YZk
         t2e4epWY7OoKBh1zsjP+zbwxBkukhxvLxWb4nieIGZ0fjCF5wf7DqvHz8XfXXTQf8gTj
         PrTvE5ywFTJwHpaG6ZQUlcrGsCK43+J/WRIJCDOv0bo1QSEsR949Tj8rcwFaDuQRV7WO
         rWJJSDeHxRPhZ5Jg3JQShY6f90/Y5Kffnpc6Phqby2jHuYgKlkZCaxbJ4WDom3bxgk4q
         VKEg==
X-Gm-Message-State: AOJu0YwjFrsZOz/9DYA7548L1s65wVPOUfK4ARs8oMp+bzIJcvqi7k0+
	s0u3zwj0zkHgj0zR97HG147mgs/2v3ot9FhJ+EzIALUJ/BgSyrVMxxIX6pZzZzJiOXkE1Kwbvvi
	o3rNbuGpuQ/VJc+QYRDREZgl7iXE58nvF287N
X-Gm-Gg: AfdE7ckLk/LRYk29XqBJngg7vOeILGROY6fYkjWAJeMEzOWN3SGybcpzIL7XOuf9nyY
	vSEG3BCgwB4IfZq4dXmDwe5Mma/Zetei5TPQPiea1IHYicOcBXQ3oOkbQ5fmzTVIzF3bm7EIuEg
	6Vfh/92VN+3e0vSJpgut9fZhKvM/rD+0Cw70dTAaT2A638cqOm/sExfXjqP3wI6mGhDV1SYlOmC
	kAef0Ek8WF2bKUAxdTQ3p4WcRBOjbxcvqQ+NgaSY0BF1nNyDBMFkfuWHvqt4COui0QCgaxj
X-Received: by 2002:a53:a490:0:b0:667:546a:e624 with SMTP id
 956f58d0204a3-6679f26cdb7mr4983143d50.79.1783640206745; Thu, 09 Jul 2026
 16:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709230242.2003459-1-ameryhung@gmail.com> <20260709230242.2003459-3-ameryhung@gmail.com>
 <20260709231732.AAA701F000E9@smtp.kernel.org>
In-Reply-To: <20260709231732.AAA701F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 9 Jul 2026 16:36:34 -0700
X-Gm-Features: AVVi8Cfaiv0Nb5dLVXosUOmMYLoDtUBrkn6voSCtmKAgDMCTdizmGJG6UmULS34
Message-ID: <CAMB2axPf0=YPMD4br-zd+-tjLRAQa890PRJAKStSwZyAAef-PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Factor out raw_mode-related fields
 in bpf_call_arg_meta
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:17=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The patch drops the detection of `MEM_UNINIT` raw memory argumen=
ts for `ARG_PTR_TO_MAP_VALUE`, which incorrectly breaks valid BPF programs =
that pass uninitialized stack buffers to helpers like `bpf_map_pop_elem` an=
d `bpf_map_peek_elem`.
> --
>
> --- Patch [2]: [PATCH bpf-next v1 2/4] bpf: Factor out raw_mode-related f=
ields in bpf_call_arg_meta ---
> commit bbac2673fbeb11bb9179553dc669702134b2c290
> Author: Amery Hung <ameryhung@gmail.com>
>
>     bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
>
>     To prepare for unifying the helper and kfunc call_arg_meta, group the
>     scattered MEM_UNINIT ("raw") memory argument fields (raw_mode, regno =
and
>     access_size) into a new struct arg_raw_mem_desc.
>
> >     Also drop the bogus raw_mode assignment in the ARG_PTR_TO_MAP_VALUE=
 case:
> >     arg_type_is_raw_mem() only matches ARG_PTR_TO_MEM | MEM_UNINIT, and=
 a map
> >     value pointer is handled by check_map_access(), never reaching
> >     check_stack_range_initialized(), so tagging it raw mode had no effe=
ct.
>
> [Severity: High]
> Is this assumption accurate? If a BPF program calls a helper like
> bpf_map_pop_elem() and passes a stack buffer (PTR_TO_STACK) as the map
> value buffer, wouldn't check_helper_mem_access() call
> check_stack_range_initialized() to validate the stack access?

I was wrong. This patch will cause a regression. raw_mode should not
be dropped for ARG_PTR_TO_MAP_VALUE.

>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7dd961ede88df..e2a3ed67d2eb5 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6690,6 +6688,8 @@ static int check_stack_range_initialized(
> >        * but BTF based global subprog validation isn't accurate enough.
> >        */
> >       bool allow_poison =3D access_size < 0 || clobber;
> > +     /* The call will initialize the memory; uninitialized stack allow=
ed */
> > +     bool raw_mode =3D meta && meta->arg_raw_mem.regno =3D=3D reg_from=
_argno(argno);
> >
> >       access_size =3D abs(access_size);
>
> [Severity: High]
> Because arg_type_is_raw_mem() only checks ARG_PTR_TO_MEM, arg_raw_mem.reg=
no
> will not be set for ARG_PTR_TO_MAP_VALUE arguments.
>
> Consequently, raw_mode will evaluate to false here. Does this cause the
> verifier to fail to bypass the uninitialized read checks, rejecting valid
> unprivileged programs with an 'invalid read from stack' error?
>
> [ ... ]
>
> > @@ -8403,7 +8401,6 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >                       verifier_bug(env, "invalid map_ptr to access map-=
>value");
> >                       return -EFAULT;
> >               }
> > -             meta->raw_mode =3D arg_type & MEM_UNINIT;
> >               err =3D check_helper_mem_access(env, reg, argno_from_reg(=
regno), meta->map.ptr->value_size,
> >                                             arg_type & MEM_WRITE ? BPF_=
WRITE : BPF_READ,
> >                                             false, meta);
>
> [Severity: High]
> Without this MEM_UNINIT assignment for ARG_PTR_TO_MAP_VALUE, does the
> verifier incorrectly reject valid programs passing uninitialized stack
> memory?
>
> [ ... ]
>
> > @@ -10303,8 +10292,9 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
> >       /* Mark slots with STACK_MISC in case of raw mode, stack offset
> >        * is inferred from register state.
> >        */
> > -     for (i =3D 0; i < meta.access_size; i++) {
> > -             err =3D check_mem_access(env, insn_idx, regs + meta.regno=
, argno_from_reg(meta.regno), i, BPF_B,
> > +     for (i =3D 0; i < meta.arg_raw_mem.size; i++) {
> > +             err =3D check_mem_access(env, insn_idx, regs + meta.arg_r=
aw_mem.regno,
> > +                                    argno_from_reg(meta.arg_raw_mem.re=
gno), i, BPF_B,
> >                                      BPF_WRITE, -1, false, false);
>
> [Severity: High]
> Since meta.arg_raw_mem.size remains 0 for ARG_PTR_TO_MAP_VALUE, does this
> cause check_helper_call() to skip this post-processing loop entirely?
>
> Skipping this could miss crucial state scrubbing when a privileged progra=
m
> uses special slots like STACK_DYNPTR as a map value buffer.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709230242.20=
03459-1-ameryhung@gmail.com?part=3D2
