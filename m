Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08E3B6BE8
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107602; cv=pass; b=RUsr1M3YM30oAJBgxngpmgUZwba/ECrRlaOscDTmmDENPME7KBJuERPqUnYhiLnROgL0fllJHdtP864p1FNp7iCn4usyb+4ETFjJyJuFWqVZIellqS/tnfJocYRor24592noQ+XtWGCuLGG8W/I1/mDdsKvxbBg/UfNQEdb8ioY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107602; c=relaxed/simple;
	bh=oopxYa8TuCfAuUvcsqnK/5H6pNeWJdkEIzvH4dGsKAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5pzyCfplnVb53u8HrVmtV8zv8Zn7R/W/KR9RCiANUT9B9Cl7JGL80A+8GlY3ZEdgEzQuGEu93Bqqp0835+pa4TiVwsVkPgqb9j8NutrEeKKdYk3rIg7fIpXbzR1qtq6AQlqQ7u7V/l+1ayvl4EQ7x+TtXVUHCKgJV2LGiN4oS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZMxZKzO; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZMxZKzO"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6bcc0c495efso134222eaf.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790107590; cv=none;
        d=google.com; s=arc-20260327;
        b=ZA2uaUqniR+03U3Cf5SMlgJsa/qdF8MJqUGR3ywSSPkSTGML9KNRtwHxuWqvfTMvuQ
         tKKYwn8H1NPzFNzXAizkV3/zOQoWQorr7QVkYW2laV+CQbIZNdps3ohn1IdSBQeyq4ND
         00PLDBLjm4FE+YRsq3hiRXvYmYIBSnZoFX9ejanjA3VS6aYKZP2NVv3Yhg8KYB+VtOKR
         m2HpcHl56RZ6R2+g+0YBfSoX3DmQLj3iVnuPERybcq/8WcnVZwI6sjutLVFO0FkT2MSu
         Nc8mPv/x1FQTrBlT6GxW5mqSkIX+NXd2RTFvZQtPo5Aq22nmCPzUzvo0pNR1mwazggOi
         4OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yZYtLMrY/lz/UHlJvfGuuEXI7lAfV+4zqb2W/SZyXtg=;
        fh=Ihki2uHo2+n7gLJjZD0E7m9aHmSrh6klQEbS31s+Ewg=;
        b=AXocYITnOZhOIFrTmTZ5Esy+6F0fOyFWaih5eiqpEZrFGY/+4jUmkOmL7hJSe+Wgzb
         O2jrtDw8vbKGOwQph4+810EN1wJV7nAHTqE8mRZXD88Nb+UazF9CEbAQ2gLcE9+iMV16
         4doOWN01jl+8zJbG//hTEKddymT6hIxOqaPVUa1RLbzxrfI84x+druOymW4MxWC2Tyvq
         PbVx1R5Jb7WqLzcjjIO8jUR4SetAF5jGz1f6zVQZ2vISxyMuWTxe5+kIqLEPImNIXaag
         rqfrEAxq+6oBzYMdk4WCU27Yc6ZRTxBS4P8gti7LnQ4JyI9ZXdSI6K09A6xDdJb0wUrD
         G42Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107590; x=1790712390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yZYtLMrY/lz/UHlJvfGuuEXI7lAfV+4zqb2W/SZyXtg=;
        b=ZZMxZKzO77KpwPSkFZi82nmn1Oo8V4s2X9Pc6+T9nk/ablgEl3V8P2lBJasvhQbV5X
         jCz5EfVdKdxiHDOJ11uDbBEjY8lWhtBM/LVQ7bNFufGqC4DiUm4hCA2CRtazLV+vcDYd
         pvLkJ7iLBcZQbusF5vLAPDG/dbWYYFjz/eASbHaleeJXH4yj+welt2esc6Khekugz0dL
         3YgBxWm+uRW/m0/aNGmLP3WGirLEvGuqipYnQDnhm0eJcj5QM1rexd9GHdtJ0/DEkSx2
         AQEIaZherzNFh4uvMumQOQNktIhbyuVfCUFaAk1XwH2xczG/6gGtmhLXxGqe+T1JUANt
         loqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107590; x=1790712390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZYtLMrY/lz/UHlJvfGuuEXI7lAfV+4zqb2W/SZyXtg=;
        b=LC2F6Mn4/Ev+P1r/H13p2e4RBba9Z7+tS4xGvVxKJWcjo4wuZahagY5GetP6W168Mf
         y61VbNP7hEmpN5WY5hNU43nNiCfISiuCA2pbtptfM+IiUoK5J3qiViMYC73dsVOKugYd
         wiMjDELiEzfx1bRScGnHlCQPsf1vvEdg59L7bnlPEC68JM3ENa6VExtxa9EdofgskAY7
         MTkU1EtwdMBFgKWqZYneSfSXW53i7BoVAwV8aUEbbu7/O/H6kz/FGW/mUXxxnCPhmnVr
         HuDwTs7jij+DL6Lw4QhyB8CuhkWJWHwhV6jCvXJHrNYaU1p3RfeKuKAck+5TYQQkzrGm
         ftDw==
X-Gm-Message-State: AFuF++lWyRXtdctd7FN0Y42xxFD/RZ1WEe8JDvBzFSKVaSc2IB5++eTp
	/hV0ogmjnT+SvJpXB2ykXjjtgz4kYSmOrj0i2Grsfe31gPLTckrlXXUSiGkfSEdX/vzWX1Af32T
	gG8UIlQJEsceHhosRHYsFnIGofFJUeFY=
X-Gm-Gg: AYBFou2CCRfyOeXoITRGnc7LUaz/1wJCPPURTsFmd4af1oova3PZc0aqANw+krIo3n+
	VhJqsK9M4BIbJWnTFVSMnJGvT7eIej2/svS39fopUA0b/wBTIxJnF0Jr5AwLpLfdeEKlmlB+lsn
	OGi5hXADCnxicWTEDRBHKfQZha4x33uHVilp7T148ksmhxq2Ao1Zsv2kuxEkhnOk30HAveZGiHZ
	ydd19U51P1fg8dLSw2KdVijiyAkW0lq6lzj0uKDtghRRTeM9kvpIy7n2F7gXSm7BvcIo+dQIZSV
	lZvtK8oOECyY35KMOLwKA1GzY9xunbO1Ma9Hb1CMCcXvbqdtfgvN38Hd5B2i9GEvPT8KQwg=
X-Received: by 2002:a05:6820:2909:b0:6bf:70ee:7e85 with SMTP id
 006d021491bc7-6d2d0a2f30cmr384754eaf.27.1790107589712; Tue, 22 Sep 2026
 13:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-11-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-11-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:06:15 -0700
X-Gm-Features: AcwNN1V6t4UlnptBc42tKTteOzivco_IF7aLcikzvu8F_5C3XhpW1GSKAhvgCTs
Message-ID: <CAMB2axMWU469XKFGEkvp46R7y+Uw0p4gAK8nT9-o2zdFGu0Vng@mail.gmail.com>
Subject: Re: [PATCH bpf v2 10/11] bpf: Track skb memory invalidation by
 packet-backed dynptrs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:24=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> A dynptr can be backed by skb memory, and kfuncs that
> write but also read the underlying area may reallocate
> the backing memory in the process of pulling the skb.
> However, the verifier does not track these calls as
> possibly invalidating packet pointers, and does not
> do so after their call site.
>
> Expand the verifier to track dynptr kfuncs for packet
> invalidation.
>
> Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
> Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
> Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/cfg.c             | 10 +++++--
>  kernel/bpf/verifier.c        | 51 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f57730d1d..8a9b7a2f2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1589,6 +1589,7 @@ struct bpf_call_arg_meta {
>
>         /* Only set by kfunc */
>         bool r0_rdonly;
> +       bool dynptr_may_clobber_pkt_ptr;

I would suggest making it common to helper and kfunc and not specific to dy=
nptr:

bool pkt_changed;

Then, helper and kfunc and all share this following block:

        if (meta->pkt_changed)
                clear_all_pkt_pointers(env);

This also matches the existing changes_pkt_data terminology.

>         u32 kfunc_flags;
>         const struct btf_type *func_proto;
>         const char *func_name;
> @@ -1642,6 +1643,7 @@ static inline bool bpf_is_kfunc_sleepable(struct bp=
f_call_arg_meta *meta)
>         return meta->kfunc_flags & KF_SLEEPABLE;
>  }
>  bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
> +bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta);
>  struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_e=
lem);
>  int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u3=
2 *off);
>  bool bpf_insn_is_cond_jump(u8 code);
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 842c7d1ea..cb499d19d 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -73,6 +73,12 @@ static void mark_subprog_might_throw(struct bpf_verifi=
er_env *env, int off)
>         subprog->might_throw =3D true;
>  }
>
> +static bool bpf_helper_maybe_changes_pkt_data(enum bpf_func_id func_id)
> +{
> +       return bpf_helper_changes_pkt_data(func_id) ||
> +              func_id =3D=3D BPF_FUNC_dynptr_write;
> +}
> +
>  /* 't' is an index of a call-site.
>   * 'w' is a callee entry point.
>   * Eventually this function would be called when env->cfg.insn_state[w] =
=3D=3D EXPLORED.
> @@ -510,7 +516,7 @@ static int visit_insn(int t, struct bpf_verifier_env =
*env)
>                          */
>                         if (ret =3D=3D 0 && fp->might_sleep)
>                                 mark_subprog_might_sleep(env, t);
> -                       if (bpf_helper_changes_pkt_data(insn->imm))
> +                       if (bpf_helper_maybe_changes_pkt_data(insn->imm))
>                                 mark_subprog_changes_pkt_data(env, t);
>                         if (insn->imm =3D=3D BPF_FUNC_tail_call) {
>                                 ret =3D visit_abnormal_return_insn(env, t=
);
> @@ -543,7 +549,7 @@ static int visit_insn(int t, struct bpf_verifier_env =
*env)
>                          */
>                         if (ret =3D=3D 0 && bpf_is_kfunc_sleepable(&meta)=
)
>                                 mark_subprog_might_sleep(env, t);
> -                       if (ret =3D=3D 0 && bpf_is_kfunc_pkt_changing(&me=
ta))
> +                       if (ret =3D=3D 0 && bpf_is_kfunc_maybe_pkt_changi=
ng(&meta))
>                                 mark_subprog_changes_pkt_data(env, t);
>                         if (ret =3D=3D 0 && bpf_is_throw_kfunc(insn))
>                                 mark_subprog_might_throw(env, t);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index da110cdbc..e916ce89c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8278,6 +8278,7 @@ static bool is_kfunc_arg_scalar_with_name(const str=
uct btf *btf,
>                                           const char *name);
>  static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta=
 *meta);
>  static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *me=
ta);
> +static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_meta=
 *meta);
>  static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_met=
a *meta);
>  static bool is_bpf_obj_drop_kfunc(u32 func_id);
>  static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
> @@ -9320,6 +9321,15 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg, u32 slot, u32 p
>                 err =3D process_dynptr_func(env, reg, argno, insn_idx, ar=
g_type, meta);
>                 if (err)
>                         return err;
> +               /*
> +                * These kfuncs only clobber packet pointers when their
> +                * destination dynptr, argument 0, is backed by skb packe=
t data.
> +                */
> +               if (arg =3D=3D 0 && is_kfunc_dynptr_may_clobber_pkt_ptr(m=
eta) &&
> +                   (meta->dynptr.type_unknown ||
> +                    meta->dynptr.type =3D=3D BPF_DYNPTR_TYPE_SKB ||
> +                    meta->dynptr.type =3D=3D BPF_DYNPTR_TYPE_SKB_META))
> +                       meta->dynptr_may_clobber_pkt_ptr =3D true;
>                 break;
>         }
>         case ARG_PTR_TO_ITER:
> @@ -11759,7 +11769,8 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                 if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_INVALID)
>                         return -EFAULT;
>
> -               if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB ||
> +               if (meta.dynptr.type_unknown ||
> +                   dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB ||
>                     dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB_META)
>                         /* this will trigger clear_all_pkt_pointers(), wh=
ich will
>                          * invalidate all dynptr slices associated with t=
he skb
> @@ -12787,9 +12798,45 @@ static bool is_kfunc_bpf_preempt_enable(struct b=
pf_call_arg_meta *meta)
>         return is_kfunc_call(meta, special_kfunc_list[KF_bpf_preempt_enab=
le]);
>  }
>
> +/*
> + * Dynptr kfuncs that may clobber packet pointers when called with an sk=
b or
> + * skb_meta backed destination dynptr by pulling the packet.
> + */
> +BTF_SET_START(dynptr_may_clobber_pkt_ptr_kfuncs)

This set identifies kfuncs that write to dynptr-backed memory. Whether
such a write can invalidate packet pointers is determined separately
from the destination dynptr type. How about:

  BTF_SET_START(dynptr_memory_write_kfuncs)

> +BTF_ID(func, bpf_dynptr_memset)
> +BTF_ID(func, bpf_dynptr_copy)
> +#ifdef CONFIG_BPF_EVENTS
> +BTF_ID(func, bpf_probe_read_user_dynptr)
> +BTF_ID(func, bpf_probe_read_kernel_dynptr)
> +BTF_ID(func, bpf_probe_read_user_str_dynptr)
> +BTF_ID(func, bpf_probe_read_kernel_str_dynptr)
> +BTF_ID(func, bpf_copy_from_user_dynptr)
> +BTF_ID(func, bpf_copy_from_user_str_dynptr)
> +BTF_ID(func, bpf_copy_from_user_task_dynptr)
> +BTF_ID(func, bpf_copy_from_user_task_str_dynptr)
> +#endif
> +BTF_SET_END(dynptr_may_clobber_pkt_ptr_kfuncs)
> +
> +static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_meta=
 *meta)

Likewise, perhaps:

  static bool is_kfunc_dynptr_memory_write(...)

This keeps the two concepts separate: the set classifies the
operation, while meta.changes_pkt_data records the effect for this
particular call.

> +{
> +       return meta->btf && btf_id_set_contains(&dynptr_may_clobber_pkt_p=
tr_kfuncs,
> +                                               meta->func_id);
> +}
> +
>  bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
>  {
> -       return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_dat=
a]);
> +       return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_dat=
a]) ||
> +              meta->dynptr_may_clobber_pkt_ptr;
> +}
> +
> +/*
> + * More conservative version of the above used in check_cfg(),
> + * where no register state exists and the dynptr type is unknown.
> + */
> +bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta)
> +{
> +       return bpf_is_kfunc_pkt_changing(meta) ||
> +              is_kfunc_dynptr_may_clobber_pkt_ptr(meta);
>  }
>
>  static u32 kfunc_abi_slots(const struct btf_func_model *fm)
> --
> 2.54.0
>
>
