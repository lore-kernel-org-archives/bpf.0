Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0603101A5
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249842; cv=pass; b=i+jrnoQbwaUSgFCqQwSvYI7P7a8kFply6fmpDaWEQtT6mw69Ci6IVNl1jY3P+TpdEtNZelb5DEz4AHDPBa3RUKnDbs3Fnt6coTcjgpABy1uZJxCArqk9Q0MX2nC4NM2WLO+ZGyT1ue+a0TMBuUdhzII1Gcrvfq/+QJdCPbNPj44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249842; c=relaxed/simple;
	bh=XrHXjlptHkjlZOxUlvkXZTubb9BWdYNy53Fpgx0LNIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZSd8wLLa2ng50LBI2MKgnY0gAhkXTcK0rYnqrpN7AvFU9Z+G+xrR4crqW95fvO7NBBTVqyRUdW57zfG/t1NidFj2ousw5WUlvYh//p4nmVvQEocwZz9LyMGeQrvWLFUKtnJ+QDgW7EMlhQhyDkJiENXu7Z61jEeuuIZdGIPkFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdFcC59W; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdFcC59W"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79827d28fc4so903177b3.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 10:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773249840; cv=none;
        d=google.com; s=arc-20240605;
        b=Fep5MaIscWzAUnkdlEHqEc0B+1Sh/fGzd/R/78h4GT65bVfP1TrUjsP9q8iI0XI5N5
         eeYkMXYBer2iWiPcEcHbrmKXgqv9GfU1H8PUtKtii917U+JXjFBryS2Dknv8h66iAEgz
         KVXOSpM2XnQUNA7zPuIxZoTQyo4VACbkyyoPBT4mjZ4gUJ84EYT+qJON6fKKpoKRwB1k
         I5+QsqzPm9Tl5724/8vgGBH928k6Sd1tGIaTl+kSGrnS+2Ju6OIyP1BaFuFNUdmviK1o
         ykF/1MkYVbdH4egEi4tIXtNBpLJctq0Hcfvf4h8HlplmL5rXrhh8RzPtV1jdNNuS9NXR
         QYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MfiA7UUuKbDnIQiMEl+5EvA5pBbt4xaYzihYVrz2S9M=;
        fh=reLytoccIbymnfxd0qOWViuC44C/L+sUMs8tM0wQ/L0=;
        b=c7La3AA8sjKM3QNTC0WFmNduNEUHp7ods09HgGHeNrT7tIetf/54b+L/9+pOKUvbeW
         UXldAEgPzlw4BJe4IObr7pYnjnMVu4R1ggEX8c4Z0PAu04SCVBKmnjJwfVu9B6gZlM3U
         6bNqZ67uKF9NB1jHH5zxOpitKktIc4tAobJ9EO4DGlB6Y4SrfUJCU3FBWNKZZERiqR2z
         NBiCpqSZAVv3MelpKyBIznjq2BJcbNP48Z+8cR4uDCYPvFORpjbf8vfszDtZyOhv8jBw
         ptmMij0/jF1vto0qSobPKgfpfTSWiOzprWqWcFnOng/lokBO2SeaOrs3fZPiqBrbl2xC
         z5BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773249840; x=1773854640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfiA7UUuKbDnIQiMEl+5EvA5pBbt4xaYzihYVrz2S9M=;
        b=EdFcC59Wl1JPxmPt9TG8BZRun9RyQiu0ObkKkyuiQOFByv/S6omI83MnkruRmcaKju
         9SislCg6P+dKNqk2rniee5AHbEtmbDPPr0wIND3bEsgOsYie/1ZE8WHdWPGLB6fGNNrz
         rGwRDFt8CkLIpRKtPhJVk2Q0sPUP+uPtP271aSUaRH0fv7p6cFmI/VnlHKE1OUbNA7G9
         SkpsLU79anNmI3Y1p7kP/xmpHpznP3t5apUqNAVI7lAlcGS2I4DyhJL/fpWYTXOFBeDV
         JGcNPqcvQSXSrh+zmr05yRcCPBghJ7u7BhCQtIsRai1wMNOZ04Ukia7PqhqYHtlOJeTq
         R9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773249840; x=1773854640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfiA7UUuKbDnIQiMEl+5EvA5pBbt4xaYzihYVrz2S9M=;
        b=TDVKO+ZkXaj0QIknWofzxS6gGD7hu21pqS4mOV9sJdjSUXi78fJkLtX5/NbzqfJdxx
         UQPH/xV7xUBESvaniObYwLS3Yu1qwRoHyOpittVZfUDOTNzitQq2S6gVILuW2R3ESJwq
         SBXYzkdDFt0UnKyJD7+RXcxp/3neDGH3jG2Ngh7nqkN5ukC2V3u+qKouDyRZfdhVuWOt
         cdWqRLxCRXHrAz6BNBnODHFhcKu5G7SFnudnoN9nsdPQkcDrH9dSukvs0F1T1dDzmlJK
         2XsWhkG10Er3OtrL0M6b+suDEU6ybLODB3CWlIlxcRpDpzkLLuUYVQvKWPu9fDGa/KAQ
         /MDA==
X-Gm-Message-State: AOJu0YzyyNBGeFQBTVaLOmQalNErM1Mf8ur9BGHsJ4jTdbuaAR7MFTas
	jaQZrxWw3OSZPKrCVLcmNWrRNJAnGQ0z1aHoul39tFRfTUMLLLMePsL11lfyjKUqg780r1UzhDB
	l5zlUy5BIF28sHCQORYpA3AYBgapoh7m+Nh2Bq8M=
X-Gm-Gg: ATEYQzwMbOGGKa3jrbfGd44Sxx4AnbXjG05zcYnbhunvR89U4I2WdDc5YQIQja4YBMA
	HBVxvSTCFURNS7tOjWb2ORuLjtbPFhZF8tJjqxt0oEhJxX4WsU0lM/QNfZDOfve/5YHvGkwRD0x
	WAW7OcZxnd3m5UbOu/cQtROAYVVc9g02EjCOfKAfCuipDJJweg9AUa5PSDLCcDaU2PqaDc5rhPR
	KA7YRWFcEsjPwwhBHxj4XCpfrW1MKNZ6epjeyvjuAlXpADTRwu3yMOw9jhUCPrz85VZuB8R2JXj
	B9wdZF8=
X-Received: by 2002:a05:690c:e694:20b0:798:980f:66f0 with SMTP id
 00721157ae682-79917f69fd8mr24689587b3.33.1773249840201; Wed, 11 Mar 2026
 10:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-4-ameryhung@gmail.com>
 <87ikb2tkta.fsf@gmail.com>
In-Reply-To: <87ikb2tkta.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 10:23:49 -0700
X-Gm-Features: AaiRm52s_sbz6BqGdUQ9tQg_tjoI3Gti4Ez7Mqw-B1DqJ6sCr9sviFDkl9d1iXw
Message-ID: <CAMB2axOuQGzb0ekbS6-5K_cTcDta+sUk3NjZtzSaYvbXT1EOcw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the verifier
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 9:03=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > Simplify dynptr checking for helper and kfunc by unifying it. Remember
> > initialized dynptr in process_dynptr_func() so that we can easily
> > retrieve the information for verification later.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 179 +++++++++---------------------------------
> >  1 file changed, 36 insertions(+), 143 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0f77c4c5b510..d52780962adb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -277,8 +277,15 @@ struct bpf_map_desc {
> >       int uid;
> >  };
> >
> > +struct bpf_dynptr_desc {
> > +     enum bpf_dynptr_type type;
> > +     u32 id;
> > +     u32 ref_obj_id;
> nit: let's add a comment here explaining what this field is for.

We are about to change the meaning of id and ref_obj_id. I can add
comments explaining id, ref_obj_id and parent_id in the refactor patch
(#6). That said, the meaning of these fields will apply to all objects
tracked by the verifier, not just limited to dynptr, and is already
documented when we define bpf_reg_state in
include/linux/bpf_verifier.h. Can you share a bit what info you are
looking for?

> > +};
> > +
> >  struct bpf_call_arg_meta {
> >       struct bpf_map_desc map;
> > +     struct bpf_dynptr_desc initialized_dynptr;
> >       bool raw_mode;
> >       bool pkt_access;
> >       u8 release_regno;
> > @@ -287,7 +294,6 @@ struct bpf_call_arg_meta {
> >       int mem_size;
> >       u64 msize_max_value;
> >       int ref_obj_id;
> > -     int dynptr_id;
> >       int func_id;
> >       struct btf *btf;
> >       u32 btf_id;
> > @@ -346,16 +352,12 @@ struct bpf_kfunc_call_arg_meta {
> >       struct {
> >               struct btf_field *field;
> >       } arg_rbtree_root;
> > -     struct {
> > -             enum bpf_dynptr_type type;
> > -             u32 id;
> > -             u32 ref_obj_id;
> > -     } initialized_dynptr;
> >       struct {
> >               u8 spi;
> >               u8 frameno;
> >       } iter;
> >       struct bpf_map_desc map;
> > +     struct bpf_dynptr_desc initialized_dynptr;
> >       u64 mem_size;
> >  };
> >
> > @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id =
func_id)
> >               func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
> >  }
> >
> > -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> > -{
> > -     return func_id =3D=3D BPF_FUNC_dynptr_data;
> > -}
> > -
> >  static bool is_sync_callback_calling_kfunc(u32 btf_id);
> >  static bool is_async_callback_calling_kfunc(u32 btf_id);
> >  static bool is_callback_calling_kfunc(u32 btf_id);
> > @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_fu=
nc_id func_id,
> >               ref_obj_uses++;
> >       if (is_acquire_function(func_id, map))
> >               ref_obj_uses++;
> > -     if (is_dynptr_ref_function(func_id))
> > -             ref_obj_uses++;
> >
> >       return ref_obj_uses > 1;
> >  }
> > @@ -8750,7 +8745,8 @@ static int process_kptr_func(struct bpf_verifier_=
env *env, int regno,
> >   * type, and declare it as 'const struct bpf_dynptr *' in their protot=
ype.
> >   */
> >  static int process_dynptr_func(struct bpf_verifier_env *env, int regno=
, int insn_idx,
> > -                            enum bpf_arg_type arg_type, int clone_ref_=
obj_id)
> > +                            enum bpf_arg_type arg_type, int clone_ref_=
obj_id,
> > +                            struct bpf_dynptr_desc *initialized_dynptr=
)
> >  {
> >       struct bpf_reg_state *reg =3D reg_state(env, regno);
> >       int err;
> > @@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_verifi=
er_env *env, int regno, int insn
> >               }
> >
> >               err =3D mark_dynptr_read(env, reg);
> > +
> > +             if (initialized_dynptr) {
> > +                     struct bpf_func_state *state =3D func(env, reg);
> state is only used if reg->type !=3D CONST_PTR_TO_DYNPTR, does it make
> sense to move state =3D func(env, reg); to the corresponding if block?

I think this is fine. It looks less cluttered this way.

> > +                     int spi;
> > +
> > +                     if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> > +                             spi =3D dynptr_get_spi(env, reg);
> looking at the deleted dynptr_id() and dynptr_ref_obj_id() spi can be
> negative, what changed here that we no longer need this check?

is_dynptr_reg_valid_init() above already makes sure reg points to a
valid dynptr so we don't need to check it again.

> > +                             reg =3D &state->stack[spi].spilled_ptr;
> > +                     }
> > +
> > +                     initialized_dynptr->id =3D reg->id;
> > +                     initialized_dynptr->type =3D reg->dynptr.type;
> > +                     initialized_dynptr->ref_obj_id =3D reg->ref_obj_i=
d;
> > +             }
> >       }
> >       return err;
> >  }
> > @@ -9587,72 +9597,6 @@ static int check_func_arg_reg_off(struct bpf_ver=
ifier_env *env,
> >       }
> >  }
> >
> > -static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_en=
v *env,
> > -                                             const struct bpf_func_pro=
to *fn,
> > -                                             struct bpf_reg_state *reg=
s)
> > -{
> > -     struct bpf_reg_state *state =3D NULL;
> > -     int i;
> > -
> > -     for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
> > -             if (arg_type_is_dynptr(fn->arg_type[i])) {
> > -                     if (state) {
> > -                             verbose(env, "verifier internal error: mu=
ltiple dynptr args\n");
> > -                             return NULL;
> > -                     }
> > -                     state =3D &regs[BPF_REG_1 + i];
> > -             }
> > -
> > -     if (!state)
> > -             verbose(env, "verifier internal error: no dynptr arg foun=
d\n");
> > -
> > -     return state;
> > -}
> > -
> > -static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_stat=
e *reg)
> > -{
> > -     struct bpf_func_state *state =3D func(env, reg);
> > -     int spi;
> > -
> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > -             return reg->id;
> > -     spi =3D dynptr_get_spi(env, reg);
> > -     if (spi < 0)
> > -             return spi;
> > -     return state->stack[spi].spilled_ptr.id;
> > -}
> > -
> > -static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg)
> > -{
> > -     struct bpf_func_state *state =3D func(env, reg);
> > -     int spi;
> > -
> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > -             return reg->ref_obj_id;
> > -     spi =3D dynptr_get_spi(env, reg);
> > -     if (spi < 0)
> > -             return spi;
> > -     return state->stack[spi].spilled_ptr.ref_obj_id;
> > -}
> > -
> > -static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *e=
nv,
> > -                                         struct bpf_reg_state *reg)
> > -{
> > -     struct bpf_func_state *state =3D func(env, reg);
> > -     int spi;
> > -
> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > -             return reg->dynptr.type;
> > -
> > -     spi =3D __get_spi(reg->var_off.value);
> > -     if (spi < 0) {
> > -             verbose(env, "verifier internal error: invalid spi when q=
uerying dynptr type\n");
> > -             return BPF_DYNPTR_TYPE_INVALID;
> > -     }
> > -
> > -     return state->stack[spi].spilled_ptr.dynptr.type;
> > -}
> > -
> >  static int check_reg_const_str(struct bpf_verifier_env *env,
> >                              struct bpf_reg_state *reg, u32 regno)
> >  {
> > @@ -10007,7 +9951,8 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg,
> >                                        true, meta);
> >               break;
> >       case ARG_PTR_TO_DYNPTR:
> > -             err =3D process_dynptr_func(env, regno, insn_idx, arg_typ=
e, 0);
> > +             err =3D process_dynptr_func(env, regno, insn_idx, arg_typ=
e, 0,
> > +                                       &meta->initialized_dynptr);
> >               if (err)
> >                       return err;
> >               break;
> > @@ -10666,7 +10611,7 @@ static int btf_check_func_arg_match(struct bpf_=
verifier_env *env, int subprog,
> >                       if (ret)
> >                               return ret;
> >
> > -                     ret =3D process_dynptr_func(env, regno, -1, arg->=
arg_type, 0);
> > +                     ret =3D process_dynptr_func(env, regno, -1, arg->=
arg_type, 0, NULL);
> >                       if (ret)
> >                               return ret;
> >               } else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_BTF=
_ID) {
> > @@ -11771,52 +11716,10 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
> >                       }
> >               }
> >               break;
> > -     case BPF_FUNC_dynptr_data:
> > -     {
> > -             struct bpf_reg_state *reg;
> > -             int id, ref_obj_id;
> > -
> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
> > -             if (!reg)
> > -                     return -EFAULT;
> > -
> > -
> > -             if (meta.dynptr_id) {
> > -                     verifier_bug(env, "meta.dynptr_id already set");
> > -                     return -EFAULT;
> > -             }
> > -             if (meta.ref_obj_id) {
> > -                     verifier_bug(env, "meta.ref_obj_id already set");
> > -                     return -EFAULT;
> > -             }
> > -
> > -             id =3D dynptr_id(env, reg);
> > -             if (id < 0) {
> > -                     verifier_bug(env, "failed to obtain dynptr id");
> > -                     return id;
> > -             }
> > -
> > -             ref_obj_id =3D dynptr_ref_obj_id(env, reg);
> > -             if (ref_obj_id < 0) {
> > -                     verifier_bug(env, "failed to obtain dynptr ref_ob=
j_id");
> > -                     return ref_obj_id;
> > -             }
> > -
> > -             meta.dynptr_id =3D id;
> > -             meta.ref_obj_id =3D ref_obj_id;
> > -
> > -             break;
> > -     }
> >       case BPF_FUNC_dynptr_write:
> >       {
> > -             enum bpf_dynptr_type dynptr_type;
> > -             struct bpf_reg_state *reg;
> > -
> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
> > -             if (!reg)
> > -                     return -EFAULT;
> > +             enum bpf_dynptr_type dynptr_type =3D meta.initialized_dyn=
ptr.type;
> >
> > -             dynptr_type =3D dynptr_get_type(env, reg);
> >               if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_INVALID)
> >                       return -EFAULT;
> >
> > @@ -12007,10 +11910,7 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >               return -EFAULT;
> >       }
> >
> > -     if (is_dynptr_ref_function(func_id))
> > -             regs[BPF_REG_0].dynptr_id =3D meta.dynptr_id;
> > -
> > -     if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_=
id)) {
> > +     if (is_ptr_cast_function(func_id)) {
> >               /* For release_reference() */
> >               regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
> >       } else if (is_acquire_function(func_id, meta.map.ptr)) {
> > @@ -12024,6 +11924,11 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >               regs[BPF_REG_0].ref_obj_id =3D id;
> >       }
> >
> > +     if (func_id =3D=3D BPF_FUNC_dynptr_data) {
> > +             regs[BPF_REG_0].dynptr_id =3D meta.initialized_dynptr.id;
> > +             regs[BPF_REG_0].ref_obj_id =3D meta.initialized_dynptr.re=
f_obj_id;
> > +     }
> > +
> >       err =3D do_refine_retval_range(env, regs, fn->ret_type, func_id, =
&meta);
> >       if (err)
> >               return err;
> > @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                               }
> >                       }
> >
> > -                     ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id);
> > +                     ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id,
> > +                                               &meta->initialized_dynp=
tr);
> >                       if (ret < 0)
> >                               return ret;
> > -
> > -                     if (!(dynptr_arg_type & MEM_UNINIT)) {
> > -                             int id =3D dynptr_id(env, reg);
> > -
> > -                             if (id < 0) {
> > -                                     verifier_bug(env, "failed to obta=
in dynptr id");
> > -                                     return id;
> > -                             }
> > -                             meta->initialized_dynptr.id =3D id;
> > -                             meta->initialized_dynptr.type =3D dynptr_=
get_type(env, reg);
> > -                             meta->initialized_dynptr.ref_obj_id =3D d=
ynptr_ref_obj_id(env, reg);
> > -                     }
> > -
> >                       break;
> >               }
> >               case KF_ARG_PTR_TO_ITER:
> > --
> > 2.47.3
