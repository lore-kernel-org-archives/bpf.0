Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDC175A79
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776897964; cv=pass; b=Wmpu29yP8yaMdd2jgKLvLj8/416qCUIIqmTplCCvDM73wBuAPTyPFhyRfTMZuXdglL+Ff/uihrMfWqC1EyJ8RYv47M9eBd99qvOv5fZaE9qgFMhcyb2sqPGmZBmbRJTxsud+LdI1X3F2jgKKF1t3SsKb3rbgGSdJgIcbsxzWhtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776897964; c=relaxed/simple;
	bh=A/Qoxx4G2gmi5Rql7zyl/GJMT37HnSL/uR/rJUOHfos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brItgcE35NPmXPkPobwA9BL0dc5TvNcwLW3NSU5beaQh6v5OKyAvsqu2c9HzbBhfyWRCG8cXqEAKAgWLfA45txum8MKPBv19E1Ddg0pwcGDSa//CTys9OpTqaVOPrz2ic/mT+R07MtI+2sCC0manzoYIabxxwiDxOnTwBEIRLBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9XqroqH; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9XqroqH"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bb0d18c7f9so16078027b3.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776897954; cv=none;
        d=google.com; s=arc-20240605;
        b=g/SOTc2NmlTeFBco4R87OIjrwEHWKsiy5GlCku8id+z/OExiilGJpUmKA5eVOrjW9U
         SzzbK2MWPoopnhYklRfd47FW/HNwkhANrnw65EvjOnH4Lq/RHp3LcucsyGwfzGJkFh/0
         rPINEcsPzV1aVbNgFw/mrHKtk8NKLjkxh4bkQDc9Kg4L5B+gk+pyIfSeTNpzLekV9dMP
         HAYDfgkXlhKv9075junRetKFWFfC3e5jifHe1IlvI8nIvm4YjP0O+QfBEniuIVKCO3TI
         xfYBTZnzU7v4FWqkTpNRx7m51MaOFU6tr0FV11z59OhKt1Yn1naxS5OUxDagBAJ6qU/f
         2j1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=072Izvm4+mNTHXaNnuS5DC7zjKMyy2O2f09dKfQvUGE=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=IPfMynf9pjsE26V8fUqCQGC89qYwa6C5w8LKFpGeEa5LfDaEwhHLnp5PO3iDLXIdLy
         92RhPzZqH+Rh+Uf/Pw5fMQ0Y4lpLjqQVc1WC0S+qPMG1Bg3X8PoolaIwqGM+2JZTIwQ9
         YaOD6ggz8RN2CuKg78W0wOMWvIX4yucVIKDklCYjG1exRfQ8IM4jULQ8RCoxOwNPocBF
         rCXF/YGCHW6JhaFme/k6lkVWn1qJk+woYcY/YFJJzMlJYBBIoBGDdKP78wjkjb8CpMaC
         gFkVI9/TyigPiNng++mqCdLfAbafiFxUawE3ZF7hN6xCuTV5eHxejKQcUHw8epHpI3HJ
         dEJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776897954; x=1777502754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=072Izvm4+mNTHXaNnuS5DC7zjKMyy2O2f09dKfQvUGE=;
        b=S9XqroqHMVacfdMnxlqDC15ZoxmMG201vrP74+zA4vhqLevtyHnj9rXLlSnh++AJcE
         UnrZiiy+LJvke/Hba2lbLyci9Q3sP4D6xewcjKCESXLw3OVmo7dqvEXwD5ZkUUzGJvtq
         2b0hkUvWAvNyJ0sDo1hk1qeb1C/mqyNhZyTCcsZV+YszNHI6ejVG4NOOssBVOCuCoZxM
         0u9XuRQhHT3VeqSYykOvgIcmG3pr12olys/QUYAJY2R0G/XP9uquXwbbSrIkuCXgd4CY
         zzeRXqfihsWdBGTe7VLDot3+Axfu8WUCQvJbEU9dESowCz5HhfahZjr7v5vgPS/vh+vw
         A/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776897954; x=1777502754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=072Izvm4+mNTHXaNnuS5DC7zjKMyy2O2f09dKfQvUGE=;
        b=fhNvWloMSv2m6Vy7DogYNBhs/2ZaWB+qKMSmRtzQJlt5bvPJjOnMSFcuw02ACCpojW
         K3R+sVepsj2Ye1ktL38D/fVW2F4YDRMuoQtZ8XFFjwPk2cydkEzYus2jPUWzCUclLNPY
         GaNEKdM4nJitFE956Q2NU6r/s93TiktC0yuPMFtXWWaKhkPoVVTIoUqbYoLAvdXwzLxX
         51SqEH/VzGm3ZJMUICHyGbxg0hua9LudeozzEGHM477A3NrdQA5Yu9EakjDJpeRHLBGN
         JFuI7aA9RLrTMqYa8nPiX1vKe4r+1n+dtu16sKDx68NcZPDiwQlcg8rCUdM1yxV2fv9O
         Z7jQ==
X-Gm-Message-State: AOJu0YxUXtj2WvLp6zdbs2uVhp4t13AyS8D9Z48N534JuTxKpbZCkGl5
	7SqPrEQL5+nUzAPCH80TSzIwk2P2adoPDKQggxlgNIQH35FL1zAkoE+Doe3Rywj1Y6u49kNDIHq
	Vp/zxpaoOqBsaC/BBRcRSXqTNtkuh9mE=
X-Gm-Gg: AeBDiesUwEcL7I41KxKoEEglq5L+hA6L8N2FQhwL77AjbSkLqNm+gSKH8vGOkHOXxbm
	omutQkX+QpXLuHAQk+A/uhD3kJCc+yyrIWnke4+mrZO7Xm7RZ2AaPbFYjI8g+GmkPrHY95Xjxch
	gI+xCvPvU+dx0nR7xnyr2Gh9Wyv5J9SF6/87xl6psCFTZzjdwCYAdZd1ogN84umceX/3f2PRlzx
	6A+Rn29VdZj+1KR3vv7MwhrQXoruzbmZb9g0YZQnNl9fI7LUG8zla+tY192lE5vDp70TtrxE/7o
	pZ3ed4NAPOwyVevcat4a6gbqUysn
X-Received: by 2002:a05:690c:4d0a:b0:7b7:29e4:7dcc with SMTP id
 00721157ae682-7b9ecfdc8d4mr268661087b3.39.1776897954202; Wed, 22 Apr 2026
 15:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-3-ameryhung@gmail.com>
 <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
In-Reply-To: <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 22 Apr 2026 15:45:43 -0700
X-Gm-Features: AQROBzAXsM892ROEM1DlXvqbk7JLvZJKqyM159SJgbzOPsMyx6s4VJcBDmdaM9Q
Message-ID: <CAMB2axMzeQs3WzFd1PZFB=DgR6d2ye4qzHKhATK2895ryzAEog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 2:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> > Assign reg->id when getting referenced kptr from read program context
> > to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> > referenced skb in qdisc programs using a new field reg->parent_id in
> > a later patch.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 41e4ea41c72e..93003a2a96b0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
> >                       } else {
> >                               mark_reg_known_zero(env, regs,
> >                                                   value_regno);
> > -                             if (type_may_be_null(info.reg_type))
> > -                                     regs[value_regno].id =3D ++env->i=
d_gen;
> >                               /* A load of ctx field could have differe=
nt
> >                                * actual load size with the one encoded =
in the
> >                                * insn. When the dst is PTR, it is for s=
ure not
> > @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, u32 regn
> >                               if (base_type(info.reg_type) =3D=3D PTR_T=
O_BTF_ID) {
> >                                       regs[value_regno].btf =3D info.bt=
f;
> >                                       regs[value_regno].btf_id =3D info=
.btf_id;
> > +                                     regs[value_regno].id =3D info.ref=
_obj_id;
> >                                       regs[value_regno].ref_obj_id =3D =
info.ref_obj_id;
> >                               }
>
> Hi Amery,
>
> Could you please help me double-check my understanding of this change?
>
> It adds a new behavior, if struct_ops method parameter is annotated
> with __ref, then if a field is read from such struct_ops context
> the destination register would now have it's .id =3D=3D ref_obj_id
> allocated for the parameter at the beginning of do_check().
> E.g. for `rB =3D *(T *)(rA + off)`, if `rA` is a pointer to struct_ops
> context and parameter corresponding to `off` has `__ref` annotation
> the `rB.id` will be assigned, contrary to old behavior, when it remained =
0.
>

Right

> This change in behavior, however, becomes visible only after the
> changes to release_reference() later in the series.
> There the `rB.id` is used to initiate `mark_reg_invalid(env, reg)` for
> the `rB`.
>

I probably should mention it in the commit message. The purpose of the
patch is to make the implementation consistent with the design:
parent_id tracks the id of the parent objects.

Without this patch, it should still work since in this case ref_obj_id
always equals to id. When release_reference() is called on a
KF_RELEASE kfunc, the children objects will still be invalidated
correctly.

> Are the above observations correct?
>
> > +                             if (type_may_be_null(info.reg_type) && !r=
egs[value_regno].id)
> > +                                     regs[value_regno].id =3D ++env->i=
d_gen;
> >                       }
> >                       regs[value_regno].type =3D info.reg_type;
> >               }
