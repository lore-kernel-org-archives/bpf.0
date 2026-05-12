Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC332381B0D
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620956; cv=pass; b=cwghMuEdo2SEIPlChXFdb6wHBeYxcKRAgb94nncrkENqgtXzT/tOO3AGSk1nYnfZWcUWM52FBXlJM6lcEdac7SdkQGESNu+GRvR0iEhi1DdQkEtNvqcRcadgrNH7ewfe0bLxhMPw0084/MPWzs/Y7D2b2x6GxVk1tXRTAq4tRlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620956; c=relaxed/simple;
	bh=PiDYevi2kgVcvyRTmr06usMvTBl/SGOPbnIPQRlvqb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeLxivplUgvr/rY0+7LyTbea9lSQI2uHkaTVmrKLCmBwz6DHX8VUk+NMJIwRH535hkpNes5CC3WbNebAyZJMU9uB1YVzftlJjYqcOM8/vOwKLx24X5RnBkQhCS/3QyOHN/SF76cXe59ciWB/KrQuhgvzA640g8qC3+/p9gkDH6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1PvxHyi; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1PvxHyi"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bb0d18c7f9so56965607b3.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778620953; cv=none;
        d=google.com; s=arc-20240605;
        b=fH8q5QVX+si07Xz9dpxfQDKhDZXeK/9ixNkMbsk+lZ7HldOI4IBbYwectEvx7z8esX
         mogkSO/ZN+kiuG6rLqJTs39MAwCPtxRKEhhgk471SjqXThvEEnW++NvNZwosBi/WHOi7
         7JT2C21iUQF+FzGnrz39EaXqZ+bi/QkyWpqMtTlAatuylXFWL0gws5sxCOVeysOhBKTf
         SJgOwmZiwCkbOvNlCn0getBO4Vg6pM5jhOqJ9IP+MDPdJZUul5h+XlmMjFuOzqJ3b+W5
         XkvFObWgbsIQK0i8fjb7hMtBmp52SO9YmHLmXpVjcOOjrwld4dkRVrcEAaVQkFH99TWk
         m5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3KuydEKLLJrXqUzzkqH1Oq4poBO4K1OP1ji2kRqJ9uI=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=bGhyxZqcHZJYbwOIlsMJuoKI0DeqZoc/fGwn8piqMOD4fyC4tZjARxdDOFtZ+dRPbe
         Q4YobrxfD93VIrCtp5rxJjal06ya+/N6E96D07xDR8iK0rl2eM7WHvJPzoI0ePCXEgvL
         IY0tbE1Ys14uIrevhfAdj3w4nCDXucuDAwodxgn3DVyLEda31HTgWuu/bNvWaPaggFWB
         A+tl0fbEo4oczZiP529+1jeWp4wt9GcDhO1UgEbc52Z0jESD/h+Q00+geSgxkpwdaEa8
         84JIRDUvbAwJLzwEVBLWNeQ6pcm4f8xpIq4Eq/c4Jq1N0spo+XQ15mzx2foV0IhwbgX5
         TZZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778620953; x=1779225753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KuydEKLLJrXqUzzkqH1Oq4poBO4K1OP1ji2kRqJ9uI=;
        b=s1PvxHyiAacYS+SqmWtq0dqNrDJnHfhs6NH1lQ6Bjx51gHrgAlSNIhkd9Djcy9PdgX
         pVj/FGBfk6EC7zXiORaL5hzwkwhMc60gLd42DorXVC1/IT9XbKcS0bvlZNjz0cSsN86s
         HW8T0hdplYXuI8VocEgnH63KG9uG9f5MJvIh63D+F9DvgtDwigVhmW2P1Y9oDWvvyqLX
         RQf3AB7QN86vgLVN0W6C4O5IwQzdnKuna/WVvDlcMr3mgUxpTiZ1hkVRVqgNRf7LEc2x
         hE60ft1n7WlrF9hpocG0ZNu5eJZ0E6WV11akcPTQ/3dg9SQ1MA8MRHoA4fPVd8DuhQ/4
         j32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620953; x=1779225753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KuydEKLLJrXqUzzkqH1Oq4poBO4K1OP1ji2kRqJ9uI=;
        b=OLo621s6lGtnYHEUzvnM9dQ26oPGZ2mqVimUkjwZHypruIsTaRH+jhgOF0DC9OJN0O
         z7Igi2gp7CvX3zL6gNaTnRWAo86P/gemmgtnSbpackA9OPSjPYlFvvLTNf/jNRF3Bck4
         Qf20jQf6D5iWWFmvYPnpohrzvKyi57Fs0uEpILnOIod/ywukkFef10U2KRsC7AOImgIQ
         oWeTGHmfEHstFxd0lBtNkXHXe9N/Dtxr8ibjSNds0KPMJfsdp8Cc3C9dNH4uFRq1b7GF
         knem5VWUQ9ujr+U7+UWMaUSPIKHNNHlel5yZQGjcerSoCThRZL03fBscRtUygNZlIMzL
         El3A==
X-Gm-Message-State: AOJu0YwM6PdyeT6phzvit9BEmN0hupnDJea0dkprNbf418g+SYXIkhcf
	7WXkAQOp+ndE18YYnIuKu8YQmfC3aUqM38CuVXlxwdhjkRUOF358vlRaUrTW+RtK3w7nk3MsWps
	LcHXF7oAeaY8V1HWZ8SsYS0HH2Mwz/9k=
X-Gm-Gg: Acq92OG27emOT3KwzNO7sy6G2d3qt/wtI0sUMkTXy0q6MG37rLCJ+1SdKBIdTdcfllF
	X9LZQMEmPcwOyVTDeDfx1UeZvi4WvBkdjUPxtgR2QuKjxq5Tcgc5niyi6FiENEtTd8pInlVxWBV
	1O4dwxnmh/f3p1uM2803XQttcMqW/tjansTwyS8V+9Y7lkXZucxNp+NwUOJi7IvzsmIy97upan5
	9+fuS2zLysDlC7lhtvQCqktU0zKaxnl7oN4y6cFexmbGi9fKHW93XZC4WIFfUx2c+bfgAGrA9XG
	dgDME5KsQF6BBnK/iBrEBUg=
X-Received: by 2002:a05:690c:e1d8:20b0:7bf:424:bf6b with SMTP id
 00721157ae682-7c6a9f2df4dmr5357877b3.14.1778620953441; Tue, 12 May 2026
 14:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-9-ameryhung@gmail.com>
 <cfdb2d4af893d70bcb15bcc22d6467f800b7291f.camel@gmail.com>
In-Reply-To: <cfdb2d4af893d70bcb15bcc22d6467f800b7291f.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 23:22:20 +0200
X-Gm-Features: AVHnY4KL5O_WnB5HWg9pGPB5V8Psv_hjQSNaVwa-FNe_x5m6XeUyNhDo48F-8aQ
Message-ID: <CAMB2axO3pL5uCLL-=Ov7Nnyf7_=8tL+j0vUNHRV=Z8EFg66hyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: Unify release handling for helpers
 and kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 1:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
>
> LGTM, one question below.
>
> > @@ -8010,28 +8010,15 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
> >               return err;
> >
> >  skip_type_check:
> > -     if (arg_type_is_release(arg_type)) {
> > -             if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && =
!bpf_register_is_null(reg)) {
> > -                     verbose(env, "R%d must be referenced when passed =
to release function\n",
> > -                             regno);
> > -                     return -EINVAL;
> > -             }
> > -             if (meta->release_regno) {
> > -                     verifier_bug(env, "more than one release argument=
");
> > -                     return -EFAULT;
> > -             }
> > -             meta->release_regno =3D regno;
> > +     if (arg_type_is_release(arg_type) && !arg_type_is_dynptr(arg_type=
) &&
> > +         !reg->ref_obj_id && !bpf_register_is_null(reg)) {
> > +             verbose(env, "release helper %s expects referenced PTR_TO=
_BTF_ID passed to %s\n",
> > +                     func_id_name(meta->func_id), reg_arg_name(env, ar=
gno));
> > +             return -EINVAL;
>
> Nit: a similar check is added in check_kfunc_args(),
>      can these be wrapped in some utility function?

Make sense.

>
> >       }
> >
> > -     if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_DES=
T) {
> > -             if (meta->release_regno && meta->ref_obj.cnt) {
> > -                     verbose(env, "more than one arg with ref_obj_id %=
s %u %u",
> > -                             reg_arg_name(env, argno), reg->ref_obj_id=
,
> > -                             meta->ref_obj.ref_obj_id);
> > -                     return -EACCES;
> > -             }
> > +     if (reg->ref_obj_id)
> >               update_ref_obj(&meta->ref_obj, reg);
> > -     }
> >
> >       switch (base_type(arg_type)) {
> >       case ARG_CONST_MAP_PTR:
>
> [...]
>
> > @@ -9825,7 +9883,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
> >       memset(&meta, 0, sizeof(meta));
> >       meta.pkt_access =3D fn->pkt_access;
> >
> > -     err =3D check_func_proto(fn);
> > +     err =3D check_func_proto(fn, &meta);
> >       if (err) {
> >               verifier_bug(env, "incorrect func proto %s#%d", func_id_n=
ame(func_id), func_id);
> >               return err;
> > @@ -9870,37 +9928,11 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
> >       }
> >
> >       if (meta.release_regno) {
> > -             err =3D -EINVAL;
> > -             if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - =
BPF_REG_1])) {
> > -                     err =3D unmark_stack_slots_dynptr(env, &regs[meta=
.release_regno]);
> > -             } else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.ref_=
obj.ref_obj_id) {
> > -                     u32 ref_obj_id =3D meta.ref_obj.ref_obj_id;
> > -                     bool in_rcu =3D in_rcu_cs(env);
> > -                     struct bpf_func_state *state;
> > -                     struct bpf_reg_state *reg;
> > -
> > -                     err =3D release_reference_nomark(env->cur_state, =
ref_obj_id);
> > -                     if (!err) {
> > -                             bpf_for_each_reg_in_vstate(env->cur_state=
, state, reg, ({
> > -                                     if (reg->ref_obj_id =3D=3D ref_ob=
j_id) {
> > -                                             if (in_rcu && (reg->type =
& MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
> > -                                                     reg->ref_obj_id =
=3D 0;
> > -                                                     reg->type &=3D ~M=
EM_ALLOC;
> > -                                                     reg->type |=3D ME=
M_RCU;
> > -                                             } else {
> > -                                                     mark_reg_invalid(=
env, reg);
>
> Note: release_reg() does not have this 'else' path, but it seem to be not=
 a problem,
>       assuming that MEM_ALLOC | MEM_PERCPU registers are generated only f=
rom some
>       other cmp_xchg call. Is that the case?

AFAIK, percpu allocated objects (i.e., MEM_ALLOC | MEM_PERCPU
registers) only come from bpf_kptr_xchg() and bpf_percpu_obj_new(). We
don't have a mechanism to derive registers from percpu allocated
objects such that we need to mark_reg_invalid when calling
bpf_kptr_xchg().

If there is such case in the future, maybe we can do the following in
release_reg() then

        if (convert_rcu)
                err =3D ref_convert_alloc_rcu_protected(env, reg->ref_obj_i=
d);

        if (release_dynptr)
                err =3D unmark_stack_slots_dynptr(env, reg);
        else if (reg->ref_obj_id)
                err =3D release_reference(env, reg->ref_obj_id);
        else if (bpf_register_is_null(reg))
                err =3D 0;


>
> > -                                             }
> > -                                     }
> > -                             }));
> > -                     }
> > -             } else if (meta.ref_obj.ref_obj_id) {
> > -                     err =3D release_reference(env, meta.ref_obj.ref_o=
bj_id);
> > -             } else if (bpf_register_is_null(&regs[meta.release_regno]=
)) {
> > -                     /* meta.ref_obj.ref_obj_id can only be 0 if regis=
ter that is meant to be
> > -                      * released is NULL, which must be > R0.
> > -                      */
> > -                     err =3D 0;
> > -             }
> > +             struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> > +             bool convert_rcu =3D (func_id =3D=3D BPF_FUNC_kptr_xchg) =
&& in_rcu_cs(env) &&
> > +                                (reg->type & MEM_ALLOC) && (reg->type =
& MEM_PERCPU);
> > +
> > +             err =3D release_reg(env, reg, convert_rcu, !!meta.dynptr.=
ref_obj_id);
> >               if (err)
> >                       return err;
> >       }
>
> [...]
>
> > @@ -11609,18 +11640,16 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                       return -EACCES;
> >               }
> >
> > -             if (reg->ref_obj_id) {
> > -                     if (is_kfunc_release(meta) && meta->ref_obj.cnt) =
{
> > -                             verbose(env, "more than one arg with ref_=
obj_id %s %u %u",
> > -                                     reg_arg_name(env, argno), reg->re=
f_obj_id,
> > -                                     meta->ref_obj.ref_obj_id);
> > -                             return -EFAULT;
> > -                     }
> > -                     update_ref_obj(&meta->ref_obj, reg);
> > -                     if (is_kfunc_release(meta))
> > -                             meta->release_regno =3D regno;
> > +             if (regno =3D=3D meta->release_regno && !is_kfunc_arg_dyn=
ptr(meta->btf, &args[i]) &&
> > +                 !reg->ref_obj_id && !bpf_register_is_null(reg)) {
> > +                     verbose(env, "release kfunc %s expects referenced=
 PTR_TO_BTF_ID passed to %s\n",
> > +                             func_name, reg_arg_name(env, argno));
> > +                     return -EINVAL;
> >               }
> >
> > +             if (reg->ref_obj_id)
> > +                     update_ref_obj(&meta->ref_obj, reg);
> > +
> >               ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
> >               ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> >
>
> [...]
