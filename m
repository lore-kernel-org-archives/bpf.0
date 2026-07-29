Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F93ABD83
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306154; cv=pass; b=TgNirGw3IrwXhotUAvTx3EgZbustStqt/n6Ho7QDqeMYf6RsMq0HTrcQPsq3/nByCCSEZY/hjcXf7o4b769iMAbIH2LNQv6Pt8HO4yYYNUxB1010Dzw5Y8vyVzgaZhcsSxS4+k5r4tI2Qxpq6X/jViRx+ujE57DHuoVoQAmzVqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306154; c=relaxed/simple;
	bh=hFu/XwzUX2K/nXmfocwGv/Y8dSg4XMPXfFEQvzpPSNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmzTeFPullqLVyuRzP6TpQmJOvfHxDkkWejk0yUvSMqKeot4945tLUxDH467R/GZ7bhw0khkK4Bu63CyLCW8sgW3kUblO6L1NKpy+Ravg0yzDUQ9vbzzVIoohWouwj8+LD066WdDLCFAdy/5tkcEU1rOrg4GTSXvEPZp8dNyfp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ro7j55OA; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro7j55OA"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80814edb536so10733947b3.2
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 23:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785306152; cv=none;
        d=google.com; s=arc-20260327;
        b=XAslxUz2fKNQ0Ot0K+wZn9SYDp8Olr/tVOVzom8OM54Ij76yI7qmitWTxrtuLIjdXA
         iNRg6Gd7E7V17oan7lpvMD6n1nm+ij+95Ijag+nmcTC0Uu7otL6JdMrWok0A97taLmQ7
         8OEwXbjE7Rbu61Vea9VaG71D+lXxcmbm9+mSa/DBb+UBwJhj0C1f9JoGa35uQ+wOWd7e
         NFhT7tgWV5Xhp4yfcwmf0lZhBMXJl4v85qB5rxRSER2xaqxf/d2TLRVhB7yMZwBZVIUS
         osxHCo+MT9yO+y2fLjtSZQtdBEqYC+UEgw88ZwCwoUNUczeX7GJ0vC+oaVQjSrWiYdsz
         dTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xjF0MXT1gUl+dRlaBklzTaqGM2klTATCOJQqEPYFWT0=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=pAh01/lhuao+OT+sLZLVqOR45IvTmtwsoxq4AH+NVvVUNiLoweC8hE4JeGclHbr8HN
         gxNxygCmU8tjGoVxu51MP2L3wGqAUENpXo6bgmeoVLiWChvZ0zbOwy3CAPLsqy9CDOsN
         LCnoNv6Ty9kug6yeoNHFI6Jf3IuRSoCyku+YSLKPBHGlm/eP5wIIVD1A+L0Uz3Lk2SnJ
         XSypWPVT5ph0AkwKwQmS8X5AwkMHoaWwI4ZMNdvSdmbrVonI+vFfraa2f+HKifHnDUVK
         ZvX0r56Q/k472KgMOg7eVu3ZisGthjUSjId4EMwqSk+/ri8zDB8493ihirbbiaUPgAcG
         rWNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785306152; x=1785910952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xjF0MXT1gUl+dRlaBklzTaqGM2klTATCOJQqEPYFWT0=;
        b=ro7j55OAw+xVD/N3e2NjHwnAaPXqOgsabjAgwuiZyqIo5HRxksEOhIwTNUODGvxoz8
         dQl3Xm2w87s0FMY28k5IHeOiKCWZS4i8zm2j6edf4bb+VUVr9yt1dQlAumFPm6EknRfi
         +rM7DvEW+27ISFG6lRmex/dvmNrUEhgiiixC08tQGpJLwPXJhgJJf14b5ktszzxDDshj
         eQbUKfoCwxaKVaA+kl3jCqbbtn8jn79nLfnYjY79AM5FAW5gOtnvMNN/MqgoqZi8t6O+
         c+bg7u3fl4z4Lm8FWDdw3tNI3RWRFUYNnCgVVxCdsJj5pPYpg45fJJrnZ/LUScpyZR4B
         GBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785306152; x=1785910952;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xjF0MXT1gUl+dRlaBklzTaqGM2klTATCOJQqEPYFWT0=;
        b=opM+6vNfMUfzc9QHButE8UuA/NGT+EP45T8zzyqkhmfrJeKXLfw/mobefhuPA2Lu7b
         kWGAMMUZWhhbpyRZY4rClpkbJfTr+xQydZzYSkwKvpD5ckcgSl/8DmXsVBsFT1fgeJIb
         oSJZtyZcUhNxb42O1cVoM0Bbv5gk7xMtcpDvHipXiYuF1oiQBVD6qeUgj3DMq98x4dpU
         vBLV8UL3d+Nrv4mUvbNFhns2PYPd2oxL/cDj1ePnpPiW0zlvhF7BzSTpxWdb+H6+9Q3R
         c0qXhUrC0SOzncGgg7iYkN4Eg2YzEAraoUGnOZZowaIqkWl1Dw+fEPnprzjaNVzml59l
         iT6g==
X-Gm-Message-State: AOJu0YyJzfGpI5e1P2S0TUnpHauBuw1zAe6W/6mmxwWVKpBjM1cbMMJf
	rMiemLcDBHXd2ygqL0ciRnCH9vamFMQs5hbhWl1QWYogbxr18eL2SCuKLGZ/lzDkQ4DeyIEihrM
	O1sccNJcPWLDRFkjRgZ94OIke9Rx+XkPCGQ==
X-Gm-Gg: AR+sD10WuhrJeiojkUwIUbWVTT56XzWjhCn/v2KygbshVsUrD38VQRz4AMxvbn8OJoZ
	5FAY8A5RqlKB4bsuM4y9vS03kIuqbTf/CKny4uSgrMyewR4E3RIbBUmAjt24PHW/eGQ5NT5KOkx
	8RmzUezEPBcPiPeGUgTcU1GjqkIcTwCLxPIbniy2Ur46zOXF3ESh5Bt94W6CtZ1eaMDDmDZnJQU
	x2s/cUDJCV9YX01QLjnnKFQbzKARKp9VrBM1mAW3/FjlCCuWh1jZWzMYhsQ5eR0aWyt1s1g2AY1
	0f+Z8yappx/tlRLO65X9NU1A5ApiMQQNvx59glRquQ1d
X-Received: by 2002:a05:690c:488a:b0:80d:78bd:7a37 with SMTP id
 00721157ae682-81f9939148bmr28447907b3.49.1785306151764; Tue, 28 Jul 2026
 23:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-16-ameryhung@gmail.com>
 <cc7d59269cbe0fb24f9cf0f0ae40d555d050e07a.camel@gmail.com>
In-Reply-To: <cc7d59269cbe0fb24f9cf0f0ae40d555d050e07a.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 28 Jul 2026 23:22:20 -0700
X-Gm-Features: AUfX_myHg4qorgtDdOMawndboHAMgO_gWzZZTqogUwdJTJB5Hw5v8IqZVfiBzFE
Message-ID: <CAMB2axNb0m7svf=9X5xTidyqpKMup8akeL+2tGy6J5eMGDcQPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/18] bpf: Classify kfunc pointer arguments
 from BTF, resolve type against the register
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
>
> ...
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2326b12a1531..76a84574b23e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4924,6 +4924,19 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] =3D =
{
> >       [CONST_PTR_TO_MAP] =3D btf_bpf_map_id,
> >  };
> >
> > +static enum bpf_reg_type lookup_reg2btf_ids(const struct btf_type *ref=
_t)
>
> Nit: the function would be a bit simpler, if ref_id is passed as a
>      parameter instead of ref_t.

Ack. will change.

>
> > +{
> > +     enum bpf_reg_type type;
> > +
> > +     for (type =3D 0; type < __BPF_REG_TYPE_MAX; type++) {
> > +             if (reg2btf_ids[type] &&
> > +                 btf_type_by_id(btf_vmlinux, *reg2btf_ids[type]) =3D=
=3D ref_t)
> > +                     return type;
> > +     }
> > +
> > +     return NOT_INIT;
> > +}
>
> ...
>
> > @@ -11429,10 +11431,14 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_en=
v *env,
> >            is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
> >               arg_mem_size =3D true;
> >
> > -     /* This is the catch all argument type of register types supporte=
d by
> > -      * check_helper_mem_access. However, we only allow when argument =
type is
> > -      * pointer to scalar, or struct composed (recursively) of scalars=
. When
> > -      * arg_mem_size is true, the pointer can be void *.
> > +     /* A pointer to a struct without a size argument is classified as=
 KF_ARG_PTR_TO_BTF_ID */
> > +     if (btf_type_is_struct(ref_t) && !arg_mem_size)
> > +             return KF_ARG_PTR_TO_BTF_ID;
> > +
> > +     /*
> > +      * Otherwise this is a memory buffer supported by check_helper_me=
m_access(): a pointer
> > +      * to a scalar, or to void when paired with a size argument. The =
access size is derived
> > +      * from the pointed-to BTF type unless a size argument follows.
>
> Nit: below conditions would be easier to read if the whole
>          thing was structured as:

I agree that your version reads better. Thanks for the suggestion!

>
>            if (arg_mem_size) {
>              if (!btf_type_is_void(ref_t)) {
>                    ...
>                    return -EINVAL;
>                  }
>              return KF_ARG_PTR_TO_MEM;
>            } else {
>              if (btf_type_is_struct(ref_t))
>                return KF_ARG_PTR_TO_BTF_ID;
>              if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_stru=
ct(ref_t)) {
>                    ...
>                return -EINVAL;
>              }
>              return KF_ARG_PTR_TO_MEM || MEM_FIXED_SIZE;
>            }
>
> >        */
> >       if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(en=
v, meta->btf, ref_t, 0) &&
> >           (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
>
> ...
>
> > @@ -12377,20 +12370,46 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >                       break;
> >               case KF_ARG_PTR_TO_BTF_ID:
> >                       /* Only base_type is checked, further checks are =
done here */
> > -                     if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
> > -                          (bpf_type_has_unsafe_modifiers(reg->type) &&=
 !is_rcu_reg(reg))) &&
> > -                         !reg2btf_ids[base_type(reg->type)]) {
> > -                             verbose(env, "%s is %s ", reg_arg_name(en=
v, argno),
> > -                                     reg_type_str(env, reg->type));
> > -                             verbose(env, "expected %s or socket\n",
> > -                                     reg_type_str(env, base_type(reg->=
type) |
> > -                                                       (type_flag(reg-=
>type) & BPF_REG_TRUSTED_MODIFIERS)));
> > +                     if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID ||
> > +                         reg2btf_ids[base_type(reg->type)]) {
> > +                             if (!is_trusted_reg(env, reg) ||
> > +                                 bpf_type_has_unsafe_modifiers(reg->ty=
pe)) {
> > +                                     if (!is_kfunc_rcu(meta)) {
> > +                                             verbose(env, "%s must be =
referenced or trusted\n",
> > +                                                     reg_arg_name(env,=
 argno));
> > +                                             return -EINVAL;
> > +                                     }
> > +                                     if (!is_rcu_reg(reg)) {
> > +                                             verbose(env, "%s must be =
a rcu pointer\n",
> > +                                                     reg_arg_name(env,=
 argno));
> > +                                             return -EINVAL;
> > +                                     }
> > +                             }
> > +
> > +                             ret =3D process_kf_arg_ptr_to_btf_id(env,=
 reg, ref_t, ref_tname, ref_id, meta, i, argno);
> > +                             if (ret < 0)
> > +                                     return ret;
> > +                             break;
> > +                     }
> > +
> > +                     if (!__btf_type_is_scalar_struct(env, meta->btf, =
ref_t, 0)) {
> > +                             enum bpf_reg_type reg2btf_type =3D lookup=
_reg2btf_ids(ref_t);
> > +
> > +                             verbose(env, "%s is %s expected %s %s",
> > +                                     reg_arg_name(env, argno), reg_typ=
e_str(env, reg->type),
> > +                                     btf_type_str(ref_t), ref_tname);
> > +                             if (reg2btf_type !=3D NOT_INIT)
> > +                                     verbose(env, " or %s", reg_type_s=
tr(env, reg2btf_type));
> > +                             verbose(env, "\n");
> >                               return -EINVAL;
> >                       }
> > -                     ret =3D process_kf_arg_ptr_to_btf_id(env, reg, re=
f_t, ref_tname, ref_id, meta, i, argno);
> > -                     if (ret < 0)
> > -                             return ret;
> > -                     break;
> > +
> > +                     /*
> > +                      * If the register does not contain btf id but th=
e argument type is a pointer to
> > +                      * scalar-only struct, allow verifying it as a fi=
xed size memory.
> > +                      */
> > +                     kf_arg_type =3D KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZ=
E;
> > +                     fallthrough;
>
> I think this now accepts one previously rejected case:
> - register being PTR_TO_BTF_ID, pointer to scalar
> - parameter being pointer to scalar w/o size register.
> Previously it was rejected by the following code in the
> get_kfunc_ptr_arg_type():
>
>   if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[base_type=
(reg->type)])) {
>           if (!btf_type_is_struct(ref_t)) {
>                   verbose(env, "kernel function %s %s pointer type %s %s =
is not supported\n",
>
> Is this intended?

Good catch. No, it was not intended, but it seems to be an acceptable
relaxation. The argument will be classified as KF_ARG_PTR_TO_MEM |
MEM_FIXED_SIZE. The PTR_TO_BTF_ID register will go through
check_mem_reg() -> check_helper_mem_access() ->
check_ptr_to_btf_access(), and by default only read is allowed.

>
> ...
