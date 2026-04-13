Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C339020C
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119758; cv=pass; b=Q3XgAkEABZKMRNz3LlVSS0TtJZRyDu7443HOQSm31miCc/Ch/+BctK8gxgZUtpX6D0rTbbFa2wKJkybS9tY1tr+qxalt2APMEgGW3lVsqA7RHq+cJdgBVr2MvjLfHaDLXVCgknouK63gPP/ey9uzEwoew47RzFgQscg5peK0JKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119758; c=relaxed/simple;
	bh=tlM/UqpzwAkG4897Z9KkIFpRqSA94khz+tUFrWPsFzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFxrKl0ZDx7ztaRCodRVtKmBVu93TMNQXEtBG9q//o2flOyz/blxAyk3wtxS3skDhrSTzNo3f7XAm0Sf4lBTZuTuc46/9p8MBKABByGrNw7csmLxcB5o1px2Nm/lkrQpiVtcKAC6kXRey4uyaOqjMnY+HlJm/WY2Hnc61oLTH7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZmb/lT4; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZmb/lT4"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-794719afcd4so47816097b3.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776119756; cv=none;
        d=google.com; s=arc-20240605;
        b=ROJCWyFLLqcRLxtPUj6zxmHKQtAQjANONnaeR7KCUOYA2VDOpQ2olS5CkecV9Xg0LI
         eIwrONW+RrZfrIVyy35QbMaWNkBzFX+KG+2s7/84XzlyS9fQ2yR2L2fJATfkTlLZoyPX
         nsJpKL7ZM3Pf6wIVfjlcP8d39qAgc8ipbKyUZmQK1uqDyt6nLIDX/T02ZWtDILcbKdCw
         X8ElX76ZX3ZpFsFL4mp9gXW7RWABWtL+0JEawvfDdrZlKPWbu2jY5Nom/DSmQmphlPP/
         6pMF5Ps7dSMjP9G9eDqDYzAf0tTBm6VWOKcDopiC/eEgelujerFWqtpd86XZV2Mz7QVU
         CrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LAtnQ5/+5avspTyva2/r2vMsULn41s5x0aE/zBra4io=;
        fh=OsbCF22GexGLt3+uqD+ikWxnU+1g5mD0XDuGYM81Hb4=;
        b=E72bXH1MqTqtBkKvrulwb12+uBvwkaKObQK9lV/ipK9tIVRZbG6T69djsSyCJ6wkig
         WGXDv9p+UI7hjJ0Q/tgIJFa8usUS/kXPehpBVfDTZDhab30OE6l0WOOiQdfo7on3lNJH
         GHkZqGHmKPqLUyGmPi2G2aNoNwDL0RaYnrRhCC0b78BVFYimuiEh6DTf39ZAVbO/hqcr
         ur8K8kkSIJQpWTTaqk4A4kIRMRroRdn/OwL0qHVHnm5pcbSl6ax4REf2lBKQHT8fOVyK
         W8VrUbYnyyGy6bE7Ysg9LB1S2XA85KPO1hn7zCIQ2X0+YYql4Es6Tf8vjhJwqt4zyaBU
         hl+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776119756; x=1776724556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAtnQ5/+5avspTyva2/r2vMsULn41s5x0aE/zBra4io=;
        b=hZmb/lT4BuO6Q8cM78TxlJ0bT7AEbFo3WqrGmv35+c4vNeOz7Ta4zqh+NFGAPUZJoZ
         9TEHF544ZO6rKyVg6ndJ8MZ3GVtDuCDHBJyUAP+c8eONNHUnO3pEiNKJEkw0zysHEFSW
         5wJ846a3McWFgYfFTpeEXMksIbY5LgEbvXu/bAnFN5GGT2X5Q34F41Y2Fya596356qjg
         DDKEecljd4iCsk5UeNRoFrAhuZh6uXnQssIidfQ0Hj3bH4GWx1q84AP0ZRe4lwFtNV6K
         YqErIlySmCU4aMSr0SHMFHgnEY4TuzWv1m3dA4ad0++632K4Qmri05iTODIHlvzkckEW
         D/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776119756; x=1776724556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAtnQ5/+5avspTyva2/r2vMsULn41s5x0aE/zBra4io=;
        b=fqEhds6AhGOMAPAtaoy35qieY21pY0YSiZyPxDozDrfD6SLGW9tvVC7f6qns4sAuLv
         7dm975oDsh8q65AuV4LszpCWk9/6ncgFimCS3tNeLosFICQNLkYJDe/M4PDHdhIrKHn6
         W4KWeLSbFKXEvXNxy38XcuzvJU3nhwfqirJrhfI74Pzwosx68Lx5qCBUGY8EKaj+P54C
         bZRHxosh9xSBkPft1hX43nkcprd8iQuCnMbwayq/KCbZrMhY9vrIcZfzeUGSPM7l2WvA
         p5BG2kHdiMyjvJb5VbLmW2GctE7wbNrWe8iRaBe6eOBEch2Tnxq+a64bScjYwTrF8nbE
         hgQA==
X-Gm-Message-State: AOJu0YyVFTZBmLks706diUzcTh01zp1xrfeBzpRHxpfhaOHrYpsd4Hwn
	o3mHgzFJZBdXO7rMeI2sPsGspBtpktgt+AX0Dq4p9MjbzwLaXYgu8GGleBEEdEfnlJW4669bGJt
	xZm5B5NUW92ATIhZnrTkWqi21Lf3p4g8=
X-Gm-Gg: AeBDiesT/AI+VoZZjIx6E/2jZ97LTemA32HA+vrOnhfMfrl2ViQY3Lv/xZwLXZIngj1
	X2H9jwOomJhUXRDjFXKhbm+iQJQam1AO1xhNFc4ZdJsUbqClw9cgw3CQZSLeEMHegYu0+aiGGYd
	0LM5Vj3yz6b9nsw+ypPobd8wvs8DkX+q8VEmG9vJakLkbGCjoGsg+z30qTLuqVyw8cJpylp+cOp
	Q7SYMOy084g/tKJ6zBWniFFMLEflwqPRHgAyf0wo8++QT5Hq0DTA/7ezqllCoGUl9PVvWJuZUjo
	OxJKMzY=
X-Received: by 2002:a05:690c:8:b0:7b2:6b19:df2b with SMTP id
 00721157ae682-7b26b19ec84mr77916157b3.17.1776119756463; Mon, 13 Apr 2026
 15:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402065013.884228-1-ameryhung@gmail.com> <20260402065013.884228-2-ameryhung@gmail.com>
 <123ccf9c-a6ec-496a-872d-965e46d07d51@gmail.com>
In-Reply-To: <123ccf9c-a6ec-496a-872d-965e46d07d51@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 13 Apr 2026 15:35:44 -0700
X-Gm-Features: AQROBzCw9vgbGeZQLc5RlQC3MjwVA40A0NB8aiUJTHHOHriGRGrMCK771PsmiNs
Message-ID: <CAMB2axME=jJ2=0E0wSVLbCFpH4FeGFHvCugij-ZzYNw2L2rWCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Refactor dynptr mutability tracking
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com, 
	yatsenko@meta.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 9:05=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:

> > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_=
dynptr *digest_p)
> > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struc=
t bpf_dynptr *digest_p)
> >   {
> >       struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_kern *)=
digest_p;
>
> maybe we can make this digest_ptr const as well, otherwise it's a little
> bit strange to introduce const, but cast to non-const kernel struct
> immediately. I think we can apply this in other kfuncs.

Good catch. Will double check other instances.

>
> >       const struct inode *inode =3D file_inode(file);
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 05b34a6355b0..329b78940b79 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3621,8 +3621,8 @@ static inline int bpf_fd_reuseport_array_update_e=
lem(struct bpf_map *map,
> >   struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
> >   struct bpf_key *bpf_lookup_system_key(u64 id);
> >   void bpf_key_put(struct bpf_key *bkey);
> > -int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> > -                            struct bpf_dynptr *sig_p,
> > +int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
> > +                            const struct bpf_dynptr *sig_p,
> >                              struct bpf_key *trusted_keyring);
> >
> >   #else
>
> ...
>
> >               err =3D mark_stack_slots_dynptr(env, reg, arg_type, insn_=
idx, clone_ref_obj_id);
> > -     } else /* MEM_RDONLY and None case from above */ {
> > +     } else /* OBJ_RELEASE and None case from above */ {
> >               /* For the reg->type =3D=3D PTR_TO_STACK case, bpf_dynptr=
 is never const */
> > -             if (reg->type =3D=3D CONST_PTR_TO_DYNPTR && !(arg_type & =
MEM_RDONLY)) {
> > -                     verbose(env, "cannot pass pointer to const bpf_dy=
nptr, the helper mutates it\n");
> > +             if (reg->type =3D=3D CONST_PTR_TO_DYNPTR && (arg_type & O=
BJ_RELEASE)) {
> > +                     verbose(env, "CONST_PTR_TO_DYNPTR cannot be relea=
sed");
>
> \n is missing in the verbose.

Ack.

>
> >                       return -EINVAL;
> >               }
> >
> > @@ -8958,7 +8929,7 @@ static int process_dynptr_func(struct bpf_verifie=
r_env *env, int regno, int insn
> >                       return -EINVAL;
> >               }
> >
> > -             /* Fold modifiers (in this case, MEM_RDONLY) when checkin=
g expected type */
> > +             /* Fold modifiers (in this case, OBJ_RELEASE) when checki=
ng expected type */
> >               if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RD=
ONLY)) {
>
> Do we need to update the `is_dynptr_type_expected(env, reg, arg_type &
> ~MEM_RDONLY)` as MEM_RDONLY is no longer applied to the dynptr?

Ah yes. AI review bot didn't find it but sashiko did.

>
> >                       verbose(env,
> >                               "Expected a dynptr of type %s as arg #%d\=
n",
> > @@ -10803,7 +10774,7 @@ static int btf_check_func_arg_match(struct bpf_=
verifier_env *env, int subprog,
> >                               bpf_log(log, "R%d is not a pointer to are=
na or scalar.\n", regno);
> >                               return -EINVAL;
> >                       }
> > -             } else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_=
RDONLY)) {
> > +             } else if (arg->arg_type =3D=3D ARG_PTR_TO_DYNPTR) {
> >                       ret =3D check_func_arg_reg_off(env, reg, regno, A=
RG_PTR_TO_DYNPTR);
> >                       if (ret)
> >                               return ret;
> > @@ -13718,9 +13689,6 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                       enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_TO_=
DYNPTR;
> >                       int clone_ref_obj_id =3D 0;
> >
> > -                     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > -                             dynptr_arg_type |=3D MEM_RDONLY;
> > -
> >                       if (is_kfunc_arg_uninit(btf, &args[i]))
> >                               dynptr_arg_type |=3D MEM_UNINIT;
