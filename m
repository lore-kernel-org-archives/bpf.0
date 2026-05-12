Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBAC3815D1
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621178; cv=none; b=SSvwkVaMIOebNqn3yTOxLv/0NjfM8oe612PjZFMcO7QJ/K9ZDzpFb9mPiBI2OREu+v42ANi7gEZaZznI10kn0KcZAq/VAK58vYBNLgalQuP5QxC5wxghwSqU9LockhQz3kGF+ms7d5uEe8fK7qpOJHLBF5krjAu0bQ71WNY2cwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621178; c=relaxed/simple;
	bh=0NnGB74299b/skLTU67JZ1C13Xu21n9gXPYZYo5UcjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWdyGwpNwd9Ft9zTRdnVQU4znF9CaLBXsirZ9enz6cLYVrEWgQWcUq+l3GYhClMWehMSuXC9RgOO9RVLYVk3TFWcFU1rIrIg4wDBUmFaCUW2Zq/hN6sEwOYQCKKjdnGVPds3G3/Oas7kSy7ykbndHuI4XCalavfjEZHMg54V4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDfes/kB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDfes/kB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366330b6751so3983786a91.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621176; x=1779225976; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=igrrJH3+RzgjjQHoddHP3/cpPqYFpMoTRiqFmA0zyY0=;
        b=FDfes/kB8FiJjFegMR1fDNGQ0dTk2sz0L4vl3wiDPVgyJ+jPDMo+fItXulNHft//zQ
         UUa3x/ayRasmeGPabPGqhaOunZaYgOGpZsLKgjg7J8D4xEkqfOR46HFKvo+ALaCEqJ0I
         pof90RHSeWpbdPRmPAmZKhC8aG1p4zKfpJRCHhoWI04gfhXiTZIqthHwgmz06tgcg/2x
         w6jt5YQ+Qvyls/Mj5xaB8WbNoX59b6PH/fhaqqLfyL8cH5JMDPZmjtWUtLrEtB7ZQUx1
         8CHqUcDeXp5TZ1D3rR5N403frBC//DPKRPU68B4bmZsl88Tlq0pGSt6S/n32JisUKMVT
         ZcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621176; x=1779225976;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igrrJH3+RzgjjQHoddHP3/cpPqYFpMoTRiqFmA0zyY0=;
        b=IYadhSfK0lewBnna0C8NH6FE74gKigcX4NPglG3/HgSZASjYeodBUmlwWfbEvw2QA4
         h3IhbDMtzaGtSk2DzRIhKmLSqQyALFn8xtba49MIj9qk7OQudc9vfyBIaLCSc/U6b9AR
         3XAgDVjohZVhbHGYY6wIHJvixMGPAi2yFxBEnqupfFhv96BaaFRU4X+dTF4w1hcOu77C
         TiXqlpSz/w/9/c7jD2aYD9GM8HhfymeRLZQ2/Cp9WUNBBKlQ9STzG0GeUEFUgG4m4wDJ
         UBWQnsfxt9dhPm1xigLgWoMdSelCECcWOd4QgfW1rXwOY3EdmWVgfIFpbadeOJYQl5qf
         sVLg==
X-Gm-Message-State: AOJu0YwpFPsR53FzCBqHvrn93WOU/SAcUxMVtFwN9jqj2mMS4dP0fVJL
	53JQu4c7HIni3GTuZ5Cl8aixMosUwqPfPFBWOCK9XUU2fGEMg3ZOyB7z
X-Gm-Gg: Acq92OFPrb0TtKmUXALi7dtt3g1cnOzDBwa05olQxrgR/R/Ppiz5wblEGIoKC0rU/hN
	0uAvlttqf+5iPUUrCqAZ1mOKKPgQdaV6NYJFeag0WSreqSndb8K65zW9hBBIJPHT7UDAVLMSZ2S
	ZQU/i12aotSDZqr/ovGT3n0kPyjvObKr+Qvf3vAjFX1l5F0MlD8O6QeL2N7TyRDS8RdZSaNDQ7Z
	adsteUBtEaKxFu9qDDd44n3ig3n8+QzZaxXU1YLnGwYraofQSGr2svARX9oO1Ck3Gzo4cssmaXa
	1fKq15IjWqgGjhfEIvga7b+eRMCZZsyOFirYo9b+iNl2RNAclvJ1XucsmycLMm/v4/iDu1CTWXA
	mLWaTdqhJsQBXoFlZgiS/gnSVOuEBMKfv0dbv/+YVbDkKXhmMHNYBAyyUDfch5Cuwa9whDIaR11
	7oII+JZPiAifdJeD6IOB/8ZX+YmVnzQm9+uIMRYlWSWJ8ZzURb0c/Y
X-Received: by 2002:a17:90b:4a11:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-368f79ce5b0mr39976a91.23.1778621176192;
        Tue, 12 May 2026 14:26:16 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ad853a86sm1629622a91.6.2026.05.12.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:26:15 -0700 (PDT)
Message-ID: <9f6923ed86fcaf228000f7a83ace638ae523161e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: Unify release handling for
 helpers and kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Tue, 12 May 2026 14:25:41 -0700
In-Reply-To: <CAMB2axO3pL5uCLL-=Ov7Nnyf7_=8tL+j0vUNHRV=Z8EFg66hyQ@mail.gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-9-ameryhung@gmail.com>
	 <cfdb2d4af893d70bcb15bcc22d6467f800b7291f.camel@gmail.com>
	 <CAMB2axO3pL5uCLL-=Ov7Nnyf7_=8tL+j0vUNHRV=Z8EFg66hyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 23:22 +0200, Amery Hung wrote:

[...]

> > > @@ -9870,37 +9928,11 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
> > >       }
> > >=20
> > >       if (meta.release_regno) {
> > > -             err =3D -EINVAL;
> > > -             if (arg_type_is_dynptr(fn->arg_type[meta.release_regno =
- BPF_REG_1])) {
> > > -                     err =3D unmark_stack_slots_dynptr(env, &regs[me=
ta.release_regno]);
> > > -             } else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.re=
f_obj.ref_obj_id) {
> > > -                     u32 ref_obj_id =3D meta.ref_obj.ref_obj_id;
> > > -                     bool in_rcu =3D in_rcu_cs(env);
> > > -                     struct bpf_func_state *state;
> > > -                     struct bpf_reg_state *reg;
> > > -
> > > -                     err =3D release_reference_nomark(env->cur_state=
, ref_obj_id);
> > > -                     if (!err) {
> > > -                             bpf_for_each_reg_in_vstate(env->cur_sta=
te, state, reg, ({
> > > -                                     if (reg->ref_obj_id =3D=3D ref_=
obj_id) {
> > > -                                             if (in_rcu && (reg->typ=
e & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
> > > -                                                     reg->ref_obj_id=
 =3D 0;
> > > -                                                     reg->type &=3D =
~MEM_ALLOC;
> > > -                                                     reg->type |=3D =
MEM_RCU;
> > > -                                             } else {
> > > -                                                     mark_reg_invali=
d(env, reg);
> >=20
> > Note: release_reg() does not have this 'else' path, but it seem to be n=
ot a problem,
> >       assuming that MEM_ALLOC | MEM_PERCPU registers are generated only=
 from some
> >       other cmp_xchg call. Is that the case?
>=20
> AFAIK, percpu allocated objects (i.e., MEM_ALLOC | MEM_PERCPU
> registers) only come from bpf_kptr_xchg() and bpf_percpu_obj_new(). We
> don't have a mechanism to derive registers from percpu allocated
> objects such that we need to mark_reg_invalid when calling
> bpf_kptr_xchg().
>=20
> If there is such case in the future, maybe we can do the following in
> release_reg() then
>=20
>         if (convert_rcu)
>                 err =3D ref_convert_alloc_rcu_protected(env, reg->ref_obj=
_id);
>=20
>         if (release_dynptr)
>                 err =3D unmark_stack_slots_dynptr(env, reg);
>         else if (reg->ref_obj_id)
>                 err =3D release_reference(env, reg->ref_obj_id);
>         else if (bpf_register_is_null(reg))
>                 err =3D 0;

Thank you for explaining, in such case I think the code is good as it is.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
