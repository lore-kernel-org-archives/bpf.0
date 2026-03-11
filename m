Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4436C580
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268545; cv=pass; b=HO0WSwW8zxWh63B4Tp8x0XYxR665Lb2kEiZwcZHl4M5N9uIyKXOkt3UR+2ztJrgsf3uygZKaD4mCMzq3W5JEWpdJDfIdKkp/JnGzquS3UQh1MCvJPNCXRXj3A5e9pQZK1oRiyvt2LyayRAhnyT+WxyFSEVErxGEjdFALmU7TV2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268545; c=relaxed/simple;
	bh=67PSG/tWHcIbZD4vOkiJyiLFwy7uv6FrDYqiVkErixw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwtOewLmEN1yr8ZL8is/XRADuQrjGtFHmYLvZQEWM2TrRHFJNOiB1M4fDyInpoXfq+gucqEd/tF5CE5Vs0Mkrj+11Hz+Q9blKs9+6NwjRyBCHpMrG6XxsRnWicpKLw0IP9PJMdi/FM/fYadNfEk97NB2o7PRxa3drpQeulfh40Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBhcKjeE; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBhcKjeE"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79901821bb0so4357767b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268543; cv=none;
        d=google.com; s=arc-20240605;
        b=ELJDHQ45q75msL65UB9Q6Dcmv/tQudVgUQ5+KZ+V6DwWhLSWznZBTNwoflRo4ypj7T
         3/3Y2ItyFgxHQGh+Emw0GSWs/m3NDW/qjqg4sZeDqIVo3owsVbLd3LA6XpLO4Aa7zpoF
         G0HFsXpSsYOct8A67MoYXOburSgKgeuDVfvWxhbZ7YfMHYh/Gb1SouBABA2P4km3J+dC
         /Cqkv+SOBHJ1lowsS9CoTgcvLcvXoq5LhiST6Q7BlfKEJ3j6J3s3cv06uqQp3HxwNy17
         Q3s3krsdwM7JzbHRlie9i9DsbvweenPE4N/exiqXz/MbAnpUzYWnKvJ82RzuwCJCXTpU
         nyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9f5zqwvBPaGmSqwRuC9Wz/sZWDcUA3Gh/ijMN/0svI=;
        fh=reLytoccIbymnfxd0qOWViuC44C/L+sUMs8tM0wQ/L0=;
        b=id9TUe5Gu5gTQ0AdjKTUYzOZFC1HLquzhlnvjuKYUYzpf0QaoAHJn+GZthBFtBI3Hi
         +9VDehEhG8YT55Y26e9zp3OdNnGjDJjiGQcXq2IWX6TVqkFlC27RyzaCeaJjysW44obS
         zk1ZGnfy4gBQHhZOZ5P3pRmXooiR3tC5QnSGDoFn7efBEtdqfoG2gQi3m+jT0qf9v+4c
         2gLyDHHb9jHqXPufl/bPb8kOa0qo4zifDoJOKaacamEHeeh3rWqGceLUA2WTfELxOHHf
         /e6n0BE9ou4XmNUHO2pRcLfGZ/y0QewVBDvMfVZnhRRltBk9Ax5zLI71I3fq9pcEXbql
         imQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268543; x=1773873343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9f5zqwvBPaGmSqwRuC9Wz/sZWDcUA3Gh/ijMN/0svI=;
        b=DBhcKjeEfJ0hoA0vNGJe+P9kKTAaMHhbophciMXd5FcV9zJMzB1XvbRUxbZEYLVojV
         XCIY1Q62X2eiTFsGRy8HfUCBa7EcWGoltwDEWXOG8DjxUokcMyWXtnMcAzegvSuH9Xxa
         Mkl2LV6PfUWY4bn9V9Ac4nlyLhbyJybdbcwqQcGSIRx0eMbh+8OZ3vdWUpWFKPEDQNwa
         UcW4hbRGC+G34b1Mnggr4ryeJ7AZaiJBrmp0vD/GoGph/2Ag2Oa5dHD5YrhsLmElZ0OC
         CmifYsS2L61Z2WVn7Uc8bB/QiqfZhfkqkLyp7xG5MxCTFr3VyWqIyksVGz+kTmDaWi6n
         0oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268543; x=1773873343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9f5zqwvBPaGmSqwRuC9Wz/sZWDcUA3Gh/ijMN/0svI=;
        b=mwgHZ9F82eEKNYEn27JvwLofufbp3jHT5xz3XTmZ1BA/2JgNLSelUGI1P+GL618kx8
         CNRXB69bmnxLAXAyU6O+3l35/fivW4oPLcyLYCbQRgn1ILD00NsM+9JlaVlcoz/0uqDE
         tiWH3LkfijBoyedeg6BfkpDvs9UiHNYC+hbdJmCIVzXziv5FsI5z8cotwTfqxr0LdF65
         kMUhYR3y+qvYauMLJM7W4Si1De1y8HzIRoU98cGn0fnmShF0rx6zRrR7YkqhE9K53w9I
         gHF0KdsvyfciFV4oIQGsDeBhyA4cJldiz7JXexAhWS1wLklnqWf3L9Xs8n2jmaXvWLaB
         13jQ==
X-Gm-Message-State: AOJu0YwItao05RKtVDjwLYYTb7/JKpFRxIYLXgX/9UEwD8oYhPFqW/SD
	tm58v6IDbEqB/r5jZ8dJ+skEM9L2JRHDT/Rfynv9oJ3zf/pbkx8EMhf/sobjGmjwxMIR2z16X/o
	obOKOmcbJfG/x8iUpSscy1uBT4f0JEa0=
X-Gm-Gg: ATEYQzzQQpUY2PEtHkGQmAIu3x57otZLSiACXu46/9QpQ52+HT5iduu7pMOslRfCv4e
	JgV77lNA1IE/yCkxkL7ukkfTGX92n48vqmtdq3P94YzKw0806eBAR68Kc8oQ+0ehqYZL2M4tkda
	eMcdgt311SUsqLaB1dFJ+wII5aHMJ9Rjc8vFUmTEGJPf0nxhE7TeF2nDbDBrtCvxYXLYm25XOWb
	lI0FHz20y9Qudv7TxHWx4lRUgOdMy5ECGBTPGnui1ZeyyVS8pNlH0hmo/aLOwUt83yrwknLHL8T
	JM+I6g48RBy4y0b2yA==
X-Received: by 2002:a05:690c:6081:b0:798:980f:670e with SMTP id
 00721157ae682-79917fb08c8mr41417637b3.62.1773268542863; Wed, 11 Mar 2026
 15:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-4-ameryhung@gmail.com>
 <87ikb2tkta.fsf@gmail.com> <CAMB2axOuQGzb0ekbS6-5K_cTcDta+sUk3NjZtzSaYvbXT1EOcw@mail.gmail.com>
 <87fr66t3a7.fsf@gmail.com>
In-Reply-To: <87fr66t3a7.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 15:35:32 -0700
X-Gm-Features: AaiRm50QV7C9RHpJUUpVECsszu2UUAVyaUB411aOYM5KPBo3A60txAtoc7fyKEA
Message-ID: <CAMB2axN_NmWS2rW+rwuETnFHX-opMT3J8Tu5YhvQ_tyAqsTNYA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the verifier
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:22=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > On Wed, Mar 11, 2026 at 9:03=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> Amery Hung <ameryhung@gmail.com> writes:
> >>
> >> > Simplify dynptr checking for helper and kfunc by unifying it. Rememb=
er
> >> > initialized dynptr in process_dynptr_func() so that we can easily
> >> > retrieve the information for verification later.
> >> >
> >> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> >> > ---
> >> >  kernel/bpf/verifier.c | 179 +++++++++------------------------------=
---
> >> >  1 file changed, 36 insertions(+), 143 deletions(-)
> >> >
> >> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> > index 0f77c4c5b510..d52780962adb 100644
> >> > --- a/kernel/bpf/verifier.c
> >> > +++ b/kernel/bpf/verifier.c
> >> > @@ -277,8 +277,15 @@ struct bpf_map_desc {
> >> >       int uid;
> >> >  };
> >> >
> >> > +struct bpf_dynptr_desc {
> >> > +     enum bpf_dynptr_type type;
> >> > +     u32 id;
> >> > +     u32 ref_obj_id;
> >> nit: let's add a comment here explaining what this field is for.
> >
> > We are about to change the meaning of id and ref_obj_id. I can add
> > comments explaining id, ref_obj_id and parent_id in the refactor patch
> > (#6). That said, the meaning of these fields will apply to all objects
> > tracked by the verifier, not just limited to dynptr, and is already
> > documented when we define bpf_reg_state in
> > include/linux/bpf_verifier.h. Can you share a bit what info you are
> > looking for?
> >
> >
> the description from commit message would help:
> /* id of the referenced object; objects with same ref_obj_id have the sam=
e lifetime */
>
> Oftentimes when I work on verifier, it's difficult to understand what
> some data field is for. It's easier now with the AI, but still I see a
> lot of value to have that inline. Essentially ref_obj_id does not have
> obvious meaning (at least to me).

I see. bpf_reg_state->ref_obj_id is already explained in
bpf_verifier.h, but only mentioned how it is used in tracking
referenced socket and casted socket pointers. I will update the
comment in patch 6 in the next respin.

> >> > +};
> >> > +
> >> >  struct bpf_call_arg_meta {
> >> >       struct bpf_map_desc map;
> >> > +     struct bpf_dynptr_desc initialized_dynptr;
> >> >       bool raw_mode;
> >> >       bool pkt_access;
> >> >       u8 release_regno;
> >> > @@ -287,7 +294,6 @@ struct bpf_call_arg_meta {
> >> >       int mem_size;
> >> >       u64 msize_max_value;
> >> >       int ref_obj_id;
> >> > -     int dynptr_id;
> >> >       int func_id;
> >> >       struct btf *btf;
> >> >       u32 btf_id;
> >> > @@ -346,16 +352,12 @@ struct bpf_kfunc_call_arg_meta {
> >> >       struct {
> >> >               struct btf_field *field;
> >> >       } arg_rbtree_root;
> >> > -     struct {
> >> > -             enum bpf_dynptr_type type;
> >> > -             u32 id;
> >> > -             u32 ref_obj_id;
> >> > -     } initialized_dynptr;
> >> >       struct {
> >> >               u8 spi;
> >> >               u8 frameno;
> >> >       } iter;
> >> >       struct bpf_map_desc map;
> >> > +     struct bpf_dynptr_desc initialized_dynptr;
> >> >       u64 mem_size;
> >> >  };
> >> >
> >> > @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_=
id func_id)
> >> >               func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
> >> >  }
> >> >
> >> > -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> >> > -{
> >> > -     return func_id =3D=3D BPF_FUNC_dynptr_data;
> >> > -}
> >> > -
> >> >  static bool is_sync_callback_calling_kfunc(u32 btf_id);
> >> >  static bool is_async_callback_calling_kfunc(u32 btf_id);
> >> >  static bool is_callback_calling_kfunc(u32 btf_id);
> >> > @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf=
_func_id func_id,
> >> >               ref_obj_uses++;
> >> >       if (is_acquire_function(func_id, map))
> >> >               ref_obj_uses++;
> >> > -     if (is_dynptr_ref_function(func_id))
> >> > -             ref_obj_uses++;
> >> >
> >> >       return ref_obj_uses > 1;
> >> >  }
> >> > @@ -8750,7 +8745,8 @@ static int process_kptr_func(struct bpf_verifi=
er_env *env, int regno,
> >> >   * type, and declare it as 'const struct bpf_dynptr *' in their pro=
totype.
> >> >   */
> >> >  static int process_dynptr_func(struct bpf_verifier_env *env, int re=
gno, int insn_idx,
> >> > -                            enum bpf_arg_type arg_type, int clone_r=
ef_obj_id)
> >> > +                            enum bpf_arg_type arg_type, int clone_r=
ef_obj_id,
> >> > +                            struct bpf_dynptr_desc *initialized_dyn=
ptr)
> >> >  {
> >> >       struct bpf_reg_state *reg =3D reg_state(env, regno);
> >> >       int err;
> >> > @@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_ver=
ifier_env *env, int regno, int insn
> >> >               }
> >> >
> >> >               err =3D mark_dynptr_read(env, reg);
> >> > +
> >> > +             if (initialized_dynptr) {
> >> > +                     struct bpf_func_state *state =3D func(env, reg=
);
> >> state is only used if reg->type !=3D CONST_PTR_TO_DYNPTR, does it make
> >> sense to move state =3D func(env, reg); to the corresponding if block?
> >
> > I think this is fine. It looks less cluttered this way.
> >
> >> > +                     int spi;
> >> > +
> >> > +                     if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> >> > +                             spi =3D dynptr_get_spi(env, reg);
> >> looking at the deleted dynptr_id() and dynptr_ref_obj_id() spi can be
> >> negative, what changed here that we no longer need this check?
> >
> > is_dynptr_reg_valid_init() above already makes sure reg points to a
> > valid dynptr so we don't need to check it again.
> >
> >> > +                             reg =3D &state->stack[spi].spilled_ptr=
;
> >> > +                     }
> >> > +
> >> > +                     initialized_dynptr->id =3D reg->id;
> >> > +                     initialized_dynptr->type =3D reg->dynptr.type;
> >> > +                     initialized_dynptr->ref_obj_id =3D reg->ref_ob=
j_id;
> >> > +             }
> >> >       }
> >> >       return err;
> >> >  }
> >> > @@ -9587,72 +9597,6 @@ static int check_func_arg_reg_off(struct bpf_=
verifier_env *env,
> >> >       }
> >> >  }
> >> >
> >> > -static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier=
_env *env,
> >> > -                                             const struct bpf_func_=
proto *fn,
> >> > -                                             struct bpf_reg_state *=
regs)
> >> > -{
> >> > -     struct bpf_reg_state *state =3D NULL;
> >> > -     int i;
> >> > -
> >> > -     for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
> >> > -             if (arg_type_is_dynptr(fn->arg_type[i])) {
> >> > -                     if (state) {
> >> > -                             verbose(env, "verifier internal error:=
 multiple dynptr args\n");
> >> > -                             return NULL;
> >> > -                     }
> >> > -                     state =3D &regs[BPF_REG_1 + i];
> >> > -             }
> >> > -
> >> > -     if (!state)
> >> > -             verbose(env, "verifier internal error: no dynptr arg f=
ound\n");
> >> > -
> >> > -     return state;
> >> > -}
> >> > -
> >> > -static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_s=
tate *reg)
> >> > -{
> >> > -     struct bpf_func_state *state =3D func(env, reg);
> >> > -     int spi;
> >> > -
> >> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> >> > -             return reg->id;
> >> > -     spi =3D dynptr_get_spi(env, reg);
> >> > -     if (spi < 0)
> >> > -             return spi;
> >> > -     return state->stack[spi].spilled_ptr.id;
> >> > -}
> >> > -
> >> > -static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct b=
pf_reg_state *reg)
> >> > -{
> >> > -     struct bpf_func_state *state =3D func(env, reg);
> >> > -     int spi;
> >> > -
> >> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> >> > -             return reg->ref_obj_id;
> >> > -     spi =3D dynptr_get_spi(env, reg);
> >> > -     if (spi < 0)
> >> > -             return spi;
> >> > -     return state->stack[spi].spilled_ptr.ref_obj_id;
> >> > -}
> >> > -
> >> > -static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env=
 *env,
> >> > -                                         struct bpf_reg_state *reg)
> >> > -{
> >> > -     struct bpf_func_state *state =3D func(env, reg);
> >> > -     int spi;
> >> > -
> >> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> >> > -             return reg->dynptr.type;
> >> > -
> >> > -     spi =3D __get_spi(reg->var_off.value);
> >> > -     if (spi < 0) {
> >> > -             verbose(env, "verifier internal error: invalid spi whe=
n querying dynptr type\n");
> >> > -             return BPF_DYNPTR_TYPE_INVALID;
> >> > -     }
> >> > -
> >> > -     return state->stack[spi].spilled_ptr.dynptr.type;
> >> > -}
> >> > -
> >> >  static int check_reg_const_str(struct bpf_verifier_env *env,
> >> >                              struct bpf_reg_state *reg, u32 regno)
> >> >  {
> >> > @@ -10007,7 +9951,8 @@ static int check_func_arg(struct bpf_verifier=
_env *env, u32 arg,
> >> >                                        true, meta);
> >> >               break;
> >> >       case ARG_PTR_TO_DYNPTR:
> >> > -             err =3D process_dynptr_func(env, regno, insn_idx, arg_=
type, 0);
> >> > +             err =3D process_dynptr_func(env, regno, insn_idx, arg_=
type, 0,
> >> > +                                       &meta->initialized_dynptr);
> >> >               if (err)
> >> >                       return err;
> >> >               break;
> >> > @@ -10666,7 +10611,7 @@ static int btf_check_func_arg_match(struct b=
pf_verifier_env *env, int subprog,
> >> >                       if (ret)
> >> >                               return ret;
> >> >
> >> > -                     ret =3D process_dynptr_func(env, regno, -1, ar=
g->arg_type, 0);
> >> > +                     ret =3D process_dynptr_func(env, regno, -1, ar=
g->arg_type, 0, NULL);
> >> >                       if (ret)
> >> >                               return ret;
> >> >               } else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_=
BTF_ID) {
> >> > @@ -11771,52 +11716,10 @@ static int check_helper_call(struct bpf_ve=
rifier_env *env, struct bpf_insn *insn
> >> >                       }
> >> >               }
> >> >               break;
> >> > -     case BPF_FUNC_dynptr_data:
> >> > -     {
> >> > -             struct bpf_reg_state *reg;
> >> > -             int id, ref_obj_id;
> >> > -
> >> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
> >> > -             if (!reg)
> >> > -                     return -EFAULT;
> >> > -
> >> > -
> >> > -             if (meta.dynptr_id) {
> >> > -                     verifier_bug(env, "meta.dynptr_id already set"=
);
> >> > -                     return -EFAULT;
> >> > -             }
> >> > -             if (meta.ref_obj_id) {
> >> > -                     verifier_bug(env, "meta.ref_obj_id already set=
");
> >> > -                     return -EFAULT;
> >> > -             }
> >> > -
> >> > -             id =3D dynptr_id(env, reg);
> >> > -             if (id < 0) {
> >> > -                     verifier_bug(env, "failed to obtain dynptr id"=
);
> >> > -                     return id;
> >> > -             }
> >> > -
> >> > -             ref_obj_id =3D dynptr_ref_obj_id(env, reg);
> >> > -             if (ref_obj_id < 0) {
> >> > -                     verifier_bug(env, "failed to obtain dynptr ref=
_obj_id");
> >> > -                     return ref_obj_id;
> >> > -             }
> >> > -
> >> > -             meta.dynptr_id =3D id;
> >> > -             meta.ref_obj_id =3D ref_obj_id;
> >> > -
> >> > -             break;
> >> > -     }
> >> >       case BPF_FUNC_dynptr_write:
> >> >       {
> >> > -             enum bpf_dynptr_type dynptr_type;
> >> > -             struct bpf_reg_state *reg;
> >> > -
> >> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
> >> > -             if (!reg)
> >> > -                     return -EFAULT;
> >> > +             enum bpf_dynptr_type dynptr_type =3D meta.initialized_=
dynptr.type;
> >> >
> >> > -             dynptr_type =3D dynptr_get_type(env, reg);
> >> >               if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_INVALID)
> >> >                       return -EFAULT;
> >> >
> >> > @@ -12007,10 +11910,7 @@ static int check_helper_call(struct bpf_ver=
ifier_env *env, struct bpf_insn *insn
> >> >               return -EFAULT;
> >> >       }
> >> >
> >> > -     if (is_dynptr_ref_function(func_id))
> >> > -             regs[BPF_REG_0].dynptr_id =3D meta.dynptr_id;
> >> > -
> >> > -     if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(fu=
nc_id)) {
> >> > +     if (is_ptr_cast_function(func_id)) {
> >> >               /* For release_reference() */
> >> >               regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
> >> >       } else if (is_acquire_function(func_id, meta.map.ptr)) {
> >> > @@ -12024,6 +11924,11 @@ static int check_helper_call(struct bpf_ver=
ifier_env *env, struct bpf_insn *insn
> >> >               regs[BPF_REG_0].ref_obj_id =3D id;
> >> >       }
> >> >
> >> > +     if (func_id =3D=3D BPF_FUNC_dynptr_data) {
> >> > +             regs[BPF_REG_0].dynptr_id =3D meta.initialized_dynptr.=
id;
> >> > +             regs[BPF_REG_0].ref_obj_id =3D meta.initialized_dynptr=
.ref_obj_id;
> >> > +     }
> >> > +
> >> >       err =3D do_refine_retval_range(env, regs, fn->ret_type, func_i=
d, &meta);
> >> >       if (err)
> >> >               return err;
> >> > @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_ver=
ifier_env *env, struct bpf_kfunc_call_
> >> >                               }
> >> >                       }
> >> >
> >> > -                     ret =3D process_dynptr_func(env, regno, insn_i=
dx, dynptr_arg_type, clone_ref_obj_id);
> >> > +                     ret =3D process_dynptr_func(env, regno, insn_i=
dx, dynptr_arg_type, clone_ref_obj_id,
> >> > +                                               &meta->initialized_d=
ynptr);
> >> >                       if (ret < 0)
> >> >                               return ret;
> >> > -
> >> > -                     if (!(dynptr_arg_type & MEM_UNINIT)) {
> >> > -                             int id =3D dynptr_id(env, reg);
> >> > -
> >> > -                             if (id < 0) {
> >> > -                                     verifier_bug(env, "failed to o=
btain dynptr id");
> >> > -                                     return id;
> >> > -                             }
> >> > -                             meta->initialized_dynptr.id =3D id;
> >> > -                             meta->initialized_dynptr.type =3D dynp=
tr_get_type(env, reg);
> >> > -                             meta->initialized_dynptr.ref_obj_id =
=3D dynptr_ref_obj_id(env, reg);
> >> > -                     }
> >> > -
> >> >                       break;
> >> >               }
> >> >               case KF_ARG_PTR_TO_ITER:
> >> > --
> >> > 2.47.3
