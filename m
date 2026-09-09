Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A336F8EA
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978467; cv=pass; b=tq7KIlCloInPWDdfsQGLocIHYMY0q/dAQGHjaFutuTuq2o5i796U9y4FmAu/Z7l2BLvcSFoorKCdS33YwOEo9XWIEMuzsngKGI2iJg3sx9+7FiT+iKCU9XGvsZiMzuN0Rm4U4A9eXcJ82JJdIhvY1QHbgbe2VfxBfFa2EpwvxPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978467; c=relaxed/simple;
	bh=DwPJMMDCMmoKojSIVSrs25fGSMDVJCM9nCRN+YEfTWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TB+LI/6CYlBE94RQhyNLFiz/LCSB+ODerRu5KQ78xmHsYElxL6y8GigZZjlDgN5scyoGdeFkrcaBge+xwxVX+R6o1IupFtFDAToSjEJluERHZtO3JFeZwPxZqIxePMCQIk00pr0bDU5sfHAmWpmLzZ+g+pLGNjXWgcQ/eomqpW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud/f6RZs; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud/f6RZs"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-470417e5b52so580759fac.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 11:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788978464; cv=none;
        d=google.com; s=arc-20260327;
        b=SEH8Cz9/FodG01HxrFRjSHBuv/WhG8IjwBZNCtl2pnIMRJNt1HiP6ETBv+lsXYWwmz
         3lSxz3z7g5lMd1oBnQO1KSnRyAqnajrKEovH4km6edhlPADThwqh9yiQMBBaM5m9Ta1L
         eNdpTGagPPh9Yf46QSvDmP3AQSwqG9Y8rTtOYye9JDb6ZyGTl04YMnToKxKKA549g8Gq
         IZz0vR7m2WbSvUmP3pg6ZDqlUZ1LSWLAf8S/ytUIeX5VkI2opf/eVIx7hoZ2c6X+Z9Cr
         fe+DPD3Dj663n/Dpx1Ji4T3+NbYMhTdR9SoPJ+/gHXV9BIB2oJYyE/FzytkyqdmTe8gH
         D9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1LIEzqucH1kOamoSg4sazedLcjClsbh8h7OFjapkHcY=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=YB5N1cK76sCcNZ5qunlcmSHVW0I9sG9aaxemmde/9LlZW+0sxGFq/ul7J+ThrVC9DC
         9TixafCaOMsQUC/DZ6sF8ThnhfBuEwZ5qlkhbzRwOwyI4B8c9PShupNzCsMwiWYFN9Ab
         7VzqxH0KvE7FSNAkE51n4HOHu2HuBS5ThMfjl/OMlcLMjjGddE6Jo5YzRVhFV7Zb+yx0
         peMj5RQM8mtHUU1jT+moFcTUQZ7GfHD+al4srNqHxS5emxB4jbezdJbqyIGWEFhSxg4d
         hngwTfrvPbFLS/fM9IoeYSN0uMy0Eq9lqWvDJMsi+ptYPuGCCIvL5ESAyDU060PhT95r
         We+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978464; x=1789583264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1LIEzqucH1kOamoSg4sazedLcjClsbh8h7OFjapkHcY=;
        b=Ud/f6RZsooc/aoTV3EE38bnBScDpG9afQr7MenOanVggeh6jzWzqQi95rmMDii8mfd
         0QS0glAOOuKvbkKjgor5r8v5HLWT1Ej22VU3x8ymM9Rne4MvLNpsoJrhb8IKGBrFcfwM
         g1lvhgJ9LFTT9rHsyN8WGi0OxG6+8yodsJeFHLTSn/SnS3d+edeKSfN+zumGCVlQRbiB
         og51v2HRkgXBALv8Ki16KpmbUPUjCs+YaG7eRrYmsZswz7L0kPOBKKtUhFGY5doHbt3j
         lk26S8oluAeYuTEKYpcnUPPsH9Ma9Nx8xUcvYwdridGjKoOnYiOpY7bSib0W7VF0h7ZM
         t67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978464; x=1789583264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1LIEzqucH1kOamoSg4sazedLcjClsbh8h7OFjapkHcY=;
        b=sAZXQSxMwzIW8ukDrrf84gdpcUsu4pYkTmjIxuc4AoHG3ZN7mtoHPrEXadQ/UOgnTY
         PEMgHJH5/FAhvBOVKUM85eTwRphgl+4/BXYXOHWi+TYAfjJXcIFKbI0d+K70AGdZnEA1
         z04j31hAz9IZlyIN4YRiXhaZbhW8tWKckfxjJ/GIuHdrl1medM8+i7cgyc/QA64+prYL
         8XwO94zO5nNuP7JbvN5qgDt8mg3EH7UOtE4RiselQOzr27oWwAXsqxaCsZok/kb3gpdm
         HAOzgoeL2lEsfFedJb1BeGWykcWOOZVm/WHQ6E5xrMqnev/oVyRqfKaDn1x5O6F062tm
         3UaQ==
X-Gm-Message-State: AFuF++kvvqNlMYc0x7o9Nud/Ob74GmcsNKawmCEsTY3FBdgGPO/Gz21V
	XSepr6MIsYaNYbMfBRBKsQZNVU2ywbX5D0tly51IStH5y6zS9/rkILJ8kykyxFE25y0E5Y1HeXR
	Up3UyYQC9ymwmbe5DHL4K6KYtzlpbojM=
X-Gm-Gg: AYBFou0oiD6X+ZRFFCXUaj+BKrwPbtTUIWYevkAAR+8Woh35xijAv8ynR4Ipz3U9Ke+
	icMgZzixKmiXwbInrimgpubINklPlOeiuT6I/TNI6FdybYE6cBpnQgRkiAEPs9zn/HywxxJqauD
	GMSihxs0hD3vAABwKfE+VJCA+68qVKcd52qlvrO95yOD+PAnnJvVo7SysuTkwTd04P0dfJNC4qm
	21c3T0Mrg/950893ZUiOEArdXnTzJsxhRMbmDXE3nLSWlOfe0hJsFtowBezCv5vVl2hNeIPJIW5
	Rt6AzqbSwjwKdo7bA92JoQUZSJPqSkX8TaE86Q64P4S5alFLNjrbkxhWEMaSEdUYlmo31w==
X-Received: by 2002:a05:6820:2084:b0:6a3:1dc5:3570 with SMTP id
 006d021491bc7-6bee715a47dmr1537491eaf.31.1788978464397; Wed, 09 Sep 2026
 11:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-9-ameryhung@gmail.com> <fb717f148b0a06cb1d66b10fb395a233be362c2989dcbaab918e05e781c435c8@mail.kernel.org>
In-Reply-To: <fb717f148b0a06cb1d66b10fb395a233be362c2989dcbaab918e05e781c435c8@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 11:27:32 -0700
X-Gm-Features: AcwNN1Uxck75wllbZgTcpSJwfoZkhHHyQzp78yKbml73C7xSNKq4OWOLAN2YKls
Message-ID: <CAMB2axO1rfN8DhVeznirQA_JPRpx5GABxQn+uGbYf2ztfXAZAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/22] bpf: Classify kfunc arguments the
 verifier ignores
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:44=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> >     bpf: Classify kfunc arguments the verifier ignores
> >
> >     The verifier does not inspect __ign arguments or the implicit
> >     arguments of a KF_IMPLICIT_ARGS kfunc. get_kfunc_arg_type() leaves
> >     them unclassified, so gen_kfunc_arg_proto() skips them and
> >     check_kfunc_args() repeats the same BTF predicates for every call.
> >
> >     Add ARG_IGNORE and classify both cases in get_kfunc_arg_type(). The
> >     generated prototype can then record every argument, and the call si=
te
> >     can consume the recorded type without deriving the classification
> >     again.
> >
> >     No functional change.
> >
> >     Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Does the "No functional change." line accurately describe this patch?
>
> Looking at the parent commit 654bdd813138, the gen_kfunc_arg_proto() loop
> began with:
>
> kernel/bpf/verifier.c (at 654bdd813138):
>     for (i =3D 0; i < nargs; i++) {
>         if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(m=
eta, i))
>             continue;
>
>         arg_type =3D get_kfunc_arg_type(env, meta, args, i, nargs);
>         ...
>     }
>
> So get_kfunc_arg_type() was never called for any prog_aux argument, since
> prog_aux arguments are always implicit. The proto->arg_type[aux_idx] stay=
ed
> ARG_UNUSED (0) and could never become ARG_PTR_TO_PROG_AUX.
>
> Then check_kfunc_args() reads this proto:
>
> kernel/bpf/verifier.c (at 654bdd813138):
>     enum bpf_arg_type arg_type =3D meta->fn->arg_type[i];
>     ...
>     if (arg_type =3D=3D ARG_PTR_TO_PROG_AUX) {
>         cur_aux(env)->arg_prog =3D regno;
>         continue;
>     }
>
> With ARG_UNUSED recorded, arg_prog stayed 0.
>
> The fixup in kernel/bpf/fixups.c is gated on aux->arg_prog:
>
> kernel/bpf/fixups.c:
>     if (aux->arg_prog) {
>         insn_buf[0] =3D BPF_LD_IMM64(aux->arg_prog, (long)prog->aux);
>         ...
>     }
>
> So no BPF_LD_IMM64 was emitted and the kfunc was called with an uninitial=
ized
> register in place of prog->aux.
>
> This patch fixes that by testing is_kfunc_arg_prog_aux() before the new
> ARG_IGNORE test in get_kfunc_arg_type():
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 22f5aff76b40..7416f1e16aa9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12086,6 +12088,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env=
, struct bpf_call_arg_meta *meta,
> >       if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
> >               return ARG_PTR_TO_PROG_AUX;
> >
> > +     if (is_kfunc_arg_ignore(meta->btf, &args[arg]) || is_kfunc_arg_im=
plicit(meta, arg))
> > +             return ARG_IGNORE;
> > +
> >       t =3D btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
>
> and dropping the continue from gen_kfunc_arg_proto():
>
> > @@ -12215,7 +12220,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *env=
, struct bpf_call_arg_meta *meta,
> >  static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bp=
f_call_arg_meta *meta,
> >                              struct bpf_func_proto *proto)
> >  {
> > -     const struct btf *btf =3D meta->btf;
> >       const struct btf_param *args;
> >       u32 i, nargs;
> >       int arg_type;
> > @@ -12234,9 +12238,6 @@ static int gen_kfunc_arg_proto(struct bpf_verif=
ier_env *env, struct bpf_call_arg
> >       }
> >
> >       for (i =3D 0; i < nargs; i++) {
> > -             if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_im=
plicit(meta, i))
> > -                     continue;
> > -
> >               arg_type =3D get_kfunc_arg_type(env, meta, args, i, nargs=
);
> >               if (arg_type < 0)
> >                       return arg_type;
>
> so ARG_PTR_TO_PROG_AUX is again recorded in the generated prototype and
> arg_prog/BPF_LD_IMM64 are emitted.
>
> This affects bpf_wq_set_callback(), bpf_task_work_schedule_signal()/_resu=
me(),
> bpf_stream_vprintk(), bpf_stream_print_stack() and all scx_bpf_* sched_ex=
t
> kfuncs.
>
> Should this patch either be squashed with 654bdd813138 or have the "No
> functional change." line qualified, since it repairs a bug where kfuncs w=
ith a
> prog_aux argument were called with an uninitialized register?
>
> Also, the ordering is load-bearing: swapping the two tests in
> get_kfunc_arg_type() would silently reintroduce the broken code generatio=
n,
> since prog_aux arguments are always implicit. Should a comment note that =
the
> prog_aux test must stay ahead of the ARG_IGNORE test?

Will reorder patch 7 and 8.

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
