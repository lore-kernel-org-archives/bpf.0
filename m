Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6447DF84
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823582; cv=pass; b=TNNiN3jcsOX80UkhyXa369vKHxred17AHKmtuyn6x6DR/UdwzYs1CjRgUzQpcMFupEOl+dZZ2hoGitWtVQSfQZ0NjMNYE9W9m2U9okPDedIicNQr3Y6+U49DRJKEq9cCBL43/rwsmexQzSWYazaqxA81T8frv/aSWC4MX4ENh9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823582; c=relaxed/simple;
	bh=CGTehmPoZtpkgLUVZInj667j2ApkFO752c0wLjhRzDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDhnqTncrmz4GC17w10rtHZ/cYIKSTBH2lW2/IGgLWM7GAqQ/zd8WqMu/E+/e1xWeeglwW6qYaH/SSh45g35WIUaL3ZPjQfuy/wkzKi6bi4w6NNzQsVGBjHMjSyeY9cvQ5dzmStdaquEAlPUnl42oIcY7NZbadKFY+a5pybsSJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxYuVdgT; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxYuVdgT"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81ed073fed0so8360737b3.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 09:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784823566; cv=none;
        d=google.com; s=arc-20260327;
        b=QxbqaHHMsOkjd9IcJixf6dCJmFq468ORF2WnD7gRvXllvd0bDLFPNPP8r/CbPULJg3
         PgGsAHGVNDIwY4jH14Q5wZjLc2IEIb7IpeMmvXow22qrKVxEyYgJqkhp5fJwYaKJl4Dx
         udr2+Xa58ngvqAYigy/oj6azo7e2SvHpFifYD4FEW4jvelScByrLh2OgU31NII5oIc0N
         kluHvNb+l4JeVIRiFmq2zlz/Rf6wFdQd8QBD9VwrEEr86wYPG9bBZ0KG5nASfIlG9dAD
         48+ef/p4a5Yn3CCy2/poXtdjnEaRiunwX/ZkzUEGgU2t0cmCVay7/LIH0yVK7zL7yVt6
         NPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U7KT+w2KO22zzr4U0Av/AbpkMD4h2JR4x2ATdiLmsbY=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ptQ3o2rngg8ohDjp7BNHXQubEsxvFp2WToIPTiZa8ldnT6/xQMjuEANtVOUETEKpLD
         sg7Y4QYw0iSsx5GaJMprZn/HLCgz1MgutCGFbIgkz+wmxVPq676wqAbyOX4XgCSQWFGN
         JQtxnl74RDHsLy2A4KKY5j6D939+Oe/nXJ596mnA1fcP/qY6cYw5ZYAQKQrO06lJ/SKf
         GqbGWEPBRLed7JL+LhexFr8xL/K8PekB3DBjm/8LDA7l+jyr4rrkd/yU2+zjwA1FZLrg
         qyCIGP8zQri7ql/IVEFqUw9fEKh5rxyGxEZbO2eEQ6LaNQGXShN7UcgEl+MH0kloea5I
         Hmyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823566; x=1785428366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U7KT+w2KO22zzr4U0Av/AbpkMD4h2JR4x2ATdiLmsbY=;
        b=QxYuVdgTI7zt9b8p6AMmLWXc4pROgQ92ZR8jDtxGCk5GsjRJDXo6ler85X2GV3FzO+
         l3X1kFu4+ZYh1a0BYGtVUdN3wTRyQdgk/QVIitEruuufg03fCX3pasWuoDSubw1hNY/X
         /ACijPDhYjWIMZzpfCkP1knoL0WFkpdvR/i4+9L7/cCBEkq3JIU1KiWcLeXArZ0BAbvr
         Ii0zENah1dJ7OkuDY2VpLDOT0/GjZ52GnkfIdiWN11q6kOuY7Ow2EGVx1YfSz62BHzxn
         rV35AkCZXOYtK0lrkqSkXwNbhP0/6lYIgcR766VEjPvjd1LH1PLF4RtmbgkJcnq1uZw0
         amug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823566; x=1785428366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U7KT+w2KO22zzr4U0Av/AbpkMD4h2JR4x2ATdiLmsbY=;
        b=DMdI1FPClVDJgdOGZaQbEwzGHc/8EJB7ZDWAPrdfVFJmnxeJIUpZlL39H51Exmkfej
         P3g/wFiL9zdZafNRQz/+1wYAFIPGLo81el8516mnTIsw7wnAJiLSwJ40tp/w0wQmTIjC
         LhTK+JHSTf6ZNvk/NX0vxFlbcSWsCO4WoqOxl0/9FRrPcgV0h3VztiTpunzkCrIzVgsQ
         UG9PpmAokh2Bx9fvkNRBgYEoaneP4I8k4vXVFFtAyNTIi3Dq1B3EhiX0sVSAsCpPvHGG
         nTBJZf0kKaD6VJgFV9olPvl2itsrPNqHhqktI9a5aLPmaY4S2bkETgp8kSUit4CQK/Ly
         s0YA==
X-Gm-Message-State: AOJu0Yy6u07n4QHRjIpehr8kO8uDVLWSdHog3+xPlH4VKDILD5gEKdTp
	SrjgxbbbFoIyA0QaHfiKpGpuezhD0tSYSvtmLEjwdfU7wo52PJ4dW95D8GgOascCaDaH8Uf/m0a
	QLlp3C0IXQ1jJmVu1IfSOUHoVPfTzL8OvTq64
X-Gm-Gg: AR+sD1209SG91NNzp0552RbERFSL6+LfSXPHzqMrb9FEcRRIPUX6+QZRZzf6PiPJWhx
	ZtVe14lzYtShFt7mMXxKGdQdPck+QzbA6D2b5JbzuVk1//3f68+rIwMBZhYcUDIBXp1dLvx3f/g
	xuYUXOAjG0drSFTFWPnNIhpl9hacL/hHIFZTI8T9omXuA7nEkeWtfVBsI8dsp5sAuqSGiPmIyw4
	5/tX3Fm+DHtOtu0XZoU/cyycO6u23z3pO5BVEVBky84URAWd7A2azumDfM3/g==
X-Received: by 2002:a05:690c:3389:b0:81e:fd36:ff73 with SMTP id
 00721157ae682-81f4c15ffc8mr11121537b3.5.1784823566010; Thu, 23 Jul 2026
 09:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050806.1158442-1-ameryhung@gmail.com> <20260723050806.1158442-3-ameryhung@gmail.com>
 <20260723052519.261291F000E9@smtp.kernel.org>
In-Reply-To: <20260723052519.261291F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jul 2026 09:19:14 -0700
X-Gm-Features: AUfX_mzdbE453_9nXvQOeKy14QwV2Y8p0rPt5LClYeWV1TsjmoAvbVTiTLVMQdg
Message-ID: <CAMB2axObD03d9mVhXgZqsk3HiruW3tpdjJ-M_WofWZziDX=Rrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 02/18] bpf: Unify const map ptr argument
 checking for helpers and kfuncs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] NULL pointer dereference in `process_map_ptr_arg` when a BPF f=
unction accepts multiple map arguments.
> - [Low] Incorrect and misleading register numbers in `process_map_ptr_arg=
` verifier error message.
> --
>
> --- Patch [2]: [PATCH bpf-next v1 02/18] bpf: Unify const map ptr argumen=
t checking for helpers and kfuncs ---
> commit e4d2232623c3b71f4ec65054cb7cebf7737a4120
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Unify const map ptr argument checking for helpers and kfuncs
>
> This commit factors out the map pointer argument checking logic for both
> helpers and kfuncs into a single process_map_ptr_arg() function. It uses
> the bound map's btf_record to derive the object name (timer, workqueue,
> or bpf_task_work) for diagnostic messages.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e8c76abbf76a2..bff51aff25579 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -8274,6 +8274,50 @@ static int get_constant_map_key(struct bpf_verif=
ier_env *env,
> >
> >  static bool can_elide_value_nullness(const struct bpf_map *map);
> >
> > +/* Record the bpf_map argument of a helper or kfunc call in meta->map.
> > + *
> > + * When meta->map is already set from an earlier argument (a timer, wo=
rkqueue or
> > + * task_work object that is bound to a map), reject a map pointer that=
 does not
> > + * match it. That object sits in the register right before the map arg=
ument, and
> > + * its type is taken from the bound map's record for the diagnostic.
> > + */
> > +static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bp=
f_reg_state *reg,
> > +                            argno_t argno, struct bpf_call_arg_meta *m=
eta)
> > +{
> > +     int map_regno =3D reg_from_argno(argno);
> [ ... ]
> > +     if (meta->map.ptr &&
> > +         (meta->map.ptr !=3D reg->map_ptr || meta->map.uid !=3D reg->m=
ap_uid)) {
> > +             struct btf_record *rec =3D meta->map.ptr->record;
> > +             const char *obj_name =3D "workqueue";
> > +
> > +             if (rec->timer_off >=3D 0)
>
> [Severity: Medium]
> Will this cause a NULL pointer dereference in the verifier if a kfunc
> accepts multiple map pointers?
>
> If a custom kfunc or future helper takes two map pointers, such as
> void *a__map and void *b__map, process_map_ptr_arg() will process the
> second map and see meta->map.ptr already set by the first.
>
> If the first map was a standard map without special fields, its record
> pointer is NULL, causing rec->timer_off to crash.
>
> Should we check if rec is NULL before accessing its fields?

Probably not.

This isn't triggerable because no helper or kfunc takes two map arguments.

If the two-map use case ever appears, the logic would need reworking
first regardless since it currently rejects a second different map.

>
> > +                     obj_name =3D "timer";
> > +             else if (rec->task_work_off >=3D 0)
> > +                     obj_name =3D "bpf_task_work";
> > +
> > +             verbose(env, "%s pointer in R%d map_uid=3D%d doesn't matc=
h map pointer in R%d map_uid=3D%d\n",
> > +                     obj_name, map_regno - 1, meta->map.uid, map_regno=
, reg->map_uid);
>
> [Severity: Low]
> Can the hardcoded map_regno - 1 produce confusing or negative register
> numbers in the verifier error message?
>
> If the map argument is passed on the stack (e.g. more than 5 arguments),
> reg_from_argno() returns -1, making the printed registers -2 and -1.
>

I will use reg_arg_name() when printing the debug msg.

> Additionally, if a future kfunc separates the object and map arguments,
> map_regno - 1 will point to the wrong register.
>
> Could we retrieve the exact register or stack slot number for the
> bound object dynamically instead of assuming strict adjacency?

No need to change now. This block needs rewriting when that use case appear=
s.

>
> > +             return -EINVAL;
> > +     }
> > +
> > +     meta->map.ptr =3D reg->map_ptr;
> > +     meta->map.uid =3D reg->map_uid;
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.11=
58442-1-ameryhung@gmail.com?part=3D2
