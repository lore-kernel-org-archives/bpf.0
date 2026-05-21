Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC99399CE9
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347940; cv=pass; b=KP0sh4rOwcB6t4II4cMYIRfKI80zgrVs+ik/3QrVbjlJDS06HAKHgOqaIuLVBknB4yNsRvP/8ePJWKUZIA+wD2atqtdGzZT5VBYcZwI56xUWaXZ9+gFrooLXg1wZTzCJa79Tq6Gynxd6Mg0Mr9jZkltv6Vak6F6pFGsKPcN18BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347940; c=relaxed/simple;
	bh=jW/gikD/mkwuo0bE4loUOfe8sb4hZLarBqikB1e1WgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hx8kJaKQcqIacHrG2aDSXX7m3afXJKFe1Js8d+cvCsMcS5w+fEy/i9Hkc9+P0xNTsP0bE6/qvsYVDz97J17AMce7mYhcAYP3JIgAEm+rCxdQrWQ8GTKeuVjH1GFAUFzsGNaUap2L7je6m3ix7YrT7wuZbdJY4IUV/nsyZOOHz2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/zHVymI; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/zHVymI"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so6087360d50.3
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 00:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779347937; cv=none;
        d=google.com; s=arc-20240605;
        b=Xrb61NLEyCmRC5SexKQFxMOKkC+BT9bLxxqZU4UGISOAEfbG1qRY+D5m8CbcsB7796
         oA2Nz0TwMUxKSf+egn462Kgip2DtMf0VeqgiquwLvlWeHbRtg7TT3mmaz7I+rhW4vISf
         X8ToOR8Z3Q6P+WaKg/8F7sZeEvW6O2Sok7VdRuKkAFW1nenGMguQ/yBfV8tILkxWO2/G
         25+RY3F5sZfNE4SJnhAgVWHyigxEuhTlTMxOSNHhz10ikwEhXvQdni0UvUtwMPezc06W
         sCETn+U5kV0EqQMZikyOsfagvq2ax6DkxjJnW0tjR/TWtzUbWv0Gnp5PnX8W99Ym0RF8
         dWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ePspd7U4UdlqankRLQp3cgGuRazS46M0EpiAf1x5tpg=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=VXNsV6oEGWRqHejfMPnaXRJJPkgB3p+mGrITy+qlYQMHj50fyW90LsHNi4Fa4Dfe7L
         uWGSCegu31myO0+RtrEtMx5LJfdbLWaswBFzxaIanWy6UrHgRhdJVGBpnKWR0gqkVqs5
         CWPJJQQqPVtaZBvRvOxNgmRfPxO6eH91E7KVHudowtP6lHVii4wZw7lGDSNHn6nkGyKm
         lD4rF0nsqUIxOpWVvcB6j+98KNVrPuGTzwTlfaIZhEu2vOEDLlg9zxWWCRJvLbwr/XPH
         1acJnDnakK+9OPJZXzpY4qQBOFHk48blZiYLTGQ8sjamsZwjUpNa6b270vefmWOkmEDq
         HLmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779347937; x=1779952737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePspd7U4UdlqankRLQp3cgGuRazS46M0EpiAf1x5tpg=;
        b=C/zHVymIpo+u0q7LWI7ohsl3HmrZTb8VQMn+y8aq+of9HOtJeBJD4dmPdkbW97cQJJ
         EwJ5ZMctfQ6qBVRThhBwnGcKdHsuEwp0ymWyyJesxsaNM4ZXCXgvSRVp98jM6OuNT6ef
         xF7aLdkB3sYuMmq23bhhhCqBDjDB/Pa1ykonDblDGvrCP+/vxUtNFDGCcXbonVt7U45G
         QAC0xBWWvBPbrMMEeJ6r7HbgK0j/dopTrUnmi45TnYLi4ViMwZ+hdb8ZgFZpSo9yRTHC
         K5sRuQ1Q8UZVzdUmH/DMT/z2jS/nD6SvPXKKyit16aFtepLOx5PGDYa8lkAL8E9tCmpk
         ko5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779347937; x=1779952737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePspd7U4UdlqankRLQp3cgGuRazS46M0EpiAf1x5tpg=;
        b=rC/EIQPLZdxJepDM4cT01FImuCM+KvFV2UfBIFM0YzBML3vaWAk1HAsO7VkE4jdIoZ
         HRbJY9FSAERvCk1a8at2zxYNJAXxEkr8WyCkpn1TaKbRIOblXd5Qh4k9MOdtIT2lV113
         oxNtmwWDs05oJ7aumXOR0Tk67eko/pGuz1WDz+fA3b1SZBGjrlL8dxhM72IuRHGWAE2u
         H7JNbb7CCorMO6onoXoi+RHeNBPf2sqroksCeOdykN2SN0728vFO7eJ3ApCd/w79W/Z3
         cNpeQ50+NqIruwu8v4vMNPf3LtINgIXhENPa6soIB8luiU5Eg/9d8f6rvCJ9LxlQiw6C
         /8Lw==
X-Gm-Message-State: AOJu0YwCcWYOtAtT0AJnz/IQuTmoFKxv5nAbbcxojdzvcj257fDVFd4s
	tqEaLqAizMV35i5xS+Si4px44wgQo+yu/wUAPu+lMsGhrmtEcifMM20m61NGQpsWDXPNg7HmsGT
	OgWIt3KKQcVP1hz1nbECHY/ckc8kr+sI=
X-Gm-Gg: Acq92OHQ62uB6UE7j3ny1yUrxHj+2Ggz/J6WMmVoY8J55btonhAUEz7jNtNlpMOYEMP
	4A3qRf5T8Z6VKu6NnLMEat7Kyl2CFe6P8jGVwhyplJxbWbMgV22j9XX6y3kmz3AhFrWGR6eX26v
	aAny8Y1DZgBfg3sh35qUQBsobci1Iz50nzzOK9zExM3BcVQ8NEeGNEepKqo1Zbb3eKy+8m/49Q3
	Qt4Vm7Jbp2dR5wZDN79SId2N8tVqts9sKery42+DEmlzuaSmHOvoNFNndCBB3RDxwZOZCfC8mW0
	X7aNo0W1/oNySPqurJmsOZHuPFdzaibDqkC/ukL815Tr
X-Received: by 2002:a05:690e:1209:b0:651:9286:57a0 with SMTP id
 956f58d0204a3-65eadf0c771mr1239941d50.0.1779347937176; Thu, 21 May 2026
 00:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-1-ameryhung@gmail.com> <20260519181314.2731658-6-ameryhung@gmail.com>
 <02e6bb8e8b5e9e21e5b5f81adb9f440d556c83ed.camel@gmail.com>
In-Reply-To: <02e6bb8e8b5e9e21e5b5f81adb9f440d556c83ed.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 21 May 2026 00:18:45 -0700
X-Gm-Features: AVHnY4KCa9IE0cH3lJHiEmtf2_0vfOPyulsESyEQpce1C-Z3FSAar4cguindoFs
Message-ID: <CAMB2axNwk=QspYFFZkUPi12CC6Oy+UCwib7u-hbNK0N6HiMnzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 05/14] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 753681b0a987..89c219df6591 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -202,7 +202,7 @@ struct bpf_verifier_stack_elem {
> >
> >  static int acquire_reference(struct bpf_verifier_env *env, int insn_id=
x);
> >  static int release_reference_nomark(struct bpf_verifier_state *state, =
int ref_obj_id);
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id);
> > +static int release_reference(struct bpf_verifier_env *env, int id);
> >  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
> >  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
> >  static int ref_set_non_owning(struct bpf_verifier_env *env,
> > @@ -242,6 +242,7 @@ struct bpf_call_arg_meta {
> >       int mem_size;
> >       u64 msize_max_value;
> >       int ref_obj_id;
> > +     u32 id;
>
> Is this one used anywhere?

Yes. check_func_arg() will record meta->id and meta->ref_obj_id if reg
has ref_obj_id.

>
> >       int func_id;
> >       struct btf *btf;
> >       u32 btf_id;
>
> [...]
>
> > @@ -839,34 +806,20 @@ static int destroy_if_dynptr_stack_slot(struct bp=
f_verifier_env *env,
> >                       verbose(env, "cannot overwrite referenced dynptr\=
n");
> >                       return -EINVAL;
> >               }
> > -     }
> >
> > -     mark_stack_slot_scratched(env, spi);
> > -     mark_stack_slot_scratched(env, spi - 1);
>
> Nit: no need to move mark_stack_slot_scratched().

Ack.

>
> >
> > -     /* Writing partially to one dynptr stack slot destroys both. */
> > -     for (i =3D 0; i < BPF_REG_SIZE; i++) {
> > -             state->stack[spi].slot_type[i] =3D STACK_INVALID;
> > -             state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
> > +             invalidate_dynptr(env, &state->stack[spi - 1]);
> > +     } else {
> > +             /* Invalidate the dynptr and any derived slices */
> > +             err =3D release_reference(env, state->stack[spi].spilled_=
ptr.id);
> >       }
> >
> > -     dynptr_id =3D state->stack[spi].spilled_ptr.id;
> > -     /* Invalidate any slices associated with this dynptr */
> > -     bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
> > -             /* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_M=
EM */
> > -             if (dreg->type !=3D (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg=
->type !=3D PTR_TO_MEM)
> > -                     continue;
> > -             if (dreg->dynptr_id =3D=3D dynptr_id)
> > -                     mark_reg_invalid(env, dreg);
> > -     }));
> > -
> > -     /* Do not release reference state, we are destroying dynptr on st=
ack,
> > -      * not using some helper to release it. Just reset register.
> > -      */
> > -     bpf_mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > -     bpf_mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > +     if (!err) {
> > +             mark_stack_slot_scratched(env, spi);
> > +             mark_stack_slot_scratched(env, spi - 1);
> > +     }
> >
> > -     return 0;
> > +     return err;
> >  }
> >
> >  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg)
>
> [...]
>
> > @@ -8908,26 +8870,76 @@ static int release_reference_nomark(struct bpf_=
verifier_state *state, int ref_ob
> >       return -EINVAL;
> >  }
> >
> > -/* The pointer with the specified id has released its reference to ker=
nel
> > - * resources. Identify all copies of the same pointer and clear the re=
ference.
> > - *
> > - * This is the release function corresponding to acquire_reference(). =
Idempotent.
> > - */
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id)
> > +static int idstack_push(struct bpf_idmap *idmap, u32 id)
> > +{
> > +     int i;
> > +
> > +     if (!id)
> > +             return 0;
> > +
> > +     for (i =3D 0; i < idmap->cnt; i++)
> > +             if (idmap->map[i].old =3D=3D id)
> > +                     return 0;
> > +
> > +     if (WARN_ON_ONCE(idmap->cnt >=3D BPF_ID_MAP_SIZE))
> > +             return -EFAULT;
> > +
> > +     idmap->map[idmap->cnt++].old =3D id;
> > +     return 0;
> > +}
> > +
> > +static int idstack_pop(struct bpf_idmap *idmap)
> >  {
> > +     if (!idmap->cnt)
> > +             return 0;
> > +
> > +     return idmap->map[--idmap->cnt].old;
> > +}
> > +
> > +/* Release id and objects referencing the id iteratively in a DFS mann=
er */
> > +static int release_reference(struct bpf_verifier_env *env, int id)
> > +{
> > +     u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
> >       struct bpf_verifier_state *vstate =3D env->cur_state;
> > +     struct bpf_idmap *idstack =3D &env->idmap_scratch;
> > +     struct bpf_stack_state *stack;
> >       struct bpf_func_state *state;
> >       struct bpf_reg_state *reg;
> > -     int err;
> > +     int root_id =3D id, err;
> >
> > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > -     if (err)
> > -             return err;
> > +     idstack->cnt =3D 0;
> > +     idstack_push(idstack, id);
>
> Nit: check error code or drop error path from idstack_push?

Ack.

>
> >
> > -     bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > -             if (reg->ref_obj_id =3D=3D ref_obj_id)
> > -                     mark_reg_invalid(env, reg);
> > -     }));
> > +     if (find_reference_state(vstate, id))
> > +             WARN_ON_ONCE(release_reference_nomark(vstate, id));
> > +
> > +     while ((id =3D idstack_pop(idstack))) {
> > +             bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack=
, mask, ({
> > +                     if (reg->id !=3D id && reg->parent_id !=3D id && =
reg->ref_obj_id !=3D id)
> > +                             continue;
> > +
> > +                     if (reg->ref_obj_id && reg->ref_obj_id !=3D root_=
id) {
> > +                             struct bpf_reference_state *ref_state;
> > +
> > +                             ref_state =3D find_reference_state(env->c=
ur_state, reg->ref_obj_id);
> > +                             verbose(env, "Leaking reference id=3D%d a=
lloc_insn=3D%d. Release it first.\n",
> > +                                     ref_state->id, ref_state->insn_id=
x);
> > +                             return -EINVAL;
>
> Thinking some more about it, the mere presence of dangling objects
> with the same lifetime is not an error. The error would happen if such
> objects are accessed. Should the verifier invalidate such dangling
> objects instead of signaling an error immediately?

I think the verifier should not allow it. This could lead to resource
leak if there were kernel resources associated with the reference.

>
> > +                     }
> > +
> > +                     /* Free objects derived from the current object *=
/
> > +                     if (reg->id !=3D id) {
>
> I think this should be changed to `reg->parent_id =3D=3D id`,
> otherwise the reader has to infer that from the logical expression:
>
>   !(reg->id !=3D id && reg->parent_id !=3D id && reg->ref_obj_id !=3D id)=
 &&
>   !(reg->ref_obj_id && reg->ref_obj_id !=3D root_id) &&
>   (reg->id !=3D id)

Make sense. This is more straightforward to read.

>
> > +                             err =3D idstack_push(idstack, reg->id);
> > +                             if (err)
> > +                                     return err;
> > +                     }
> > +
> > +                     if (!stack || stack->slot_type[BPF_REG_SIZE - 1] =
=3D=3D STACK_SPILL)
> > +                             mark_reg_invalid(env, reg);
> > +                     else if (stack->slot_type[BPF_REG_SIZE - 1] =3D=
=3D STACK_DYNPTR)
> > +                             invalidate_dynptr(env, stack);
> > +             }));
> > +     }
> >
> >       return 0;
> >  }
>
> [...]
