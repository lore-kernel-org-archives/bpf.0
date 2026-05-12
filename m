Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4C23815F2
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621367; cv=none; b=WSpr0Ec9q/+YsnZTQyBrjxVbIFCsziCLbyQHcv9eVNrzzZbC4degd7rnNsIKBd4e0asNfWjZX3kGulZ4ulI+zL1RzXjNujJhyWpPDJgDUIHTkzFeF+iotCCh2L6S2v+fSCYq1E76GOJXlg5aQn6RW77jbgEomk3kePG0ivKaqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621367; c=relaxed/simple;
	bh=TtDr2in+DcEaaN4EBs2I542LVM/WW3zR0M6EH1I3nq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uemCIM3Pt5/QiLqqo2GMZtJqrdpWT/H7hzUMicsC8EmPrTz9Sl4Xi8ox+yiYN6ktUq5Flpii3tJlr//X4i2IWeD+9OerLYr7t0pKNl+FPn8l5mp1XayDN+U+0GD0KUYljcFEs3GnX/cGrzUPQ962gmXBKA5yUB/wkqJUWo/CyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2zFekzq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2zFekzq"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-838d0b7c950so4176731b3a.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621366; x=1779226166; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xcIGRYfY0KEc/4dSgMtJtnr1ER8sLsZiDBFTGwIcLKw=;
        b=I2zFekzqndQ0k0nii2KD6lnG7wxZC/WD11lrNrnx+jER1DGCOjtszfTzygL3f2qIJF
         53gdkV0xQ0vILe+30RliKHeYbZc7G+yY07kbwopOF325DlFSz5PKGU1XIYwPpaicU2dI
         veDl32aJ8ZtWLc+JEdlS28KSrgw5pfah7CzCaNk4Br+P63U3/2ae7BNqNlNAqkyvCc9f
         Cl0T+erkrxUqECwNGCNkugNMpWQgihfsoDqf27Ptt1qQ7OBmGNguU4CTAsQF6PcMe3tt
         +gKWIK3L5FLaSrjWkbQukFxR6a0NKLL8uX2zGKQEXSBv+gQKmU/LkCh/QM3+R6pcfBFy
         /a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621366; x=1779226166;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcIGRYfY0KEc/4dSgMtJtnr1ER8sLsZiDBFTGwIcLKw=;
        b=Umx8mUxvlYs3Z5dhw8ywUCM+wJvxZJPtOHOW3Pt/6NLIjA01swfZVC7Ugvfn1tLPdA
         6RB60ItShxbaVFyC92a2w8NEh/Ch5e2U0cO4ET9x1g3dnlE0A1foRfZFMT19qOuNNLTc
         SEW9zmKNNciDW/zdWmj8pdjPeRARSk6yC3uL25+Q33KUA5/9AREDO4/Hme+T5hS8R7KY
         /2dGBu0CMezI2i18RdoxKzoapO71g6DxjCAOHkwV8EJCPgUNfsWZKJipy8BTrY065dd8
         V757cIRR+QfLpVEMDPHvtZ6VkkcVrL2JtsWNtnRqSqwntM2CkywrtTW3eSBPtI10arCB
         sxgA==
X-Gm-Message-State: AOJu0YxP3eFKeDMpbWyLYvj7Nf8+PiN7Wg1ar2/JyJ7s4l2ef2eeNLVx
	TWYYgZ4S8TqNBVcAAaOEb+O9MF1hu+WnmgTZU9UMT7iuZjlPgAGXSl8G
X-Gm-Gg: Acq92OHukP3WluZA9jpsPh7j3q8NZO6HpW3ZKwgsBnR3TVqZWXcQeETMUOOMzERmONb
	qWdaWcZU33FfDYIQtv2Iu+a887us06I2gr5DuxTOUlb4XBS4CQEfrfPkofy8ITodnZo30rtfOBB
	j6d4H8YdsY3uYHJW3DUtwFBkpuRHujZoHVqf55b+rp3a9x+hKb0yA1jurHBc7wUPwTkOOKSvIn2
	sQakbQAZpGNgd9cD/+Is8HPHQfYD2YoMHTaLHYsO11ktmvmpEkLlyO9oOSIGV34TkQmi5qBd0kS
	O9JNNe8XOGubi8tZjXF7sk7UdYHB4RsLHVdJmS2f37LO7pubfdKO+rGFcaSQBAFhOUnbIQnc1Sg
	Mt3bV96skwZn7ag4RbkIqnnZqRoJEZAzuwIM9kS9dWsLyQed3StsVolymDC/mnN05XU5CcLQeUu
	u4yH2Q/pG8Pr5M/vlX7lpWVn66sWf1F4YyqwowHrJmZVc+Pl57+Q36
X-Received: by 2002:a05:6a00:1c94:b0:838:1ece:9716 with SMTP id d2e1a72fcca58-83f0548bb4dmr54663b3a.22.1778621365629;
        Tue, 12 May 2026 14:29:25 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c00sm22912429b3a.32.2026.05.12.14.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:29:25 -0700 (PDT)
Message-ID: <073fd24d1220adccec5248b094f4f80fd5e66f93.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Tue, 12 May 2026 14:28:50 -0700
In-Reply-To: <CAMB2axOsnVj=PBuMU8utqKsSj7DsVhWNi9Vddytx6BKfFGs0JQ@mail.gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-8-ameryhung@gmail.com>
	 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
	 <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
	 <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
	 <CAMB2axOsnVj=PBuMU8utqKsSj7DsVhWNi9Vddytx6BKfFGs0JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 23:27 +0200, Amery Hung wrote:
> On Tue, May 12, 2026 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2026-05-12 at 22:37 +0200, Amery Hung wrote:
> > > On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > >=20
> > > > On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> > > >=20
> > > > LGTM, a nit below.
> > > >=20
> > > > [...]
> > > >=20
> > > > > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_veri=
fier_env *env, u32 arg,
> > > > >       }
> > > > >=20
> > > > >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XC=
HG_DEST) {
> > > > > -             if (meta->ref_obj_id) {
> > > > > -                     verbose(env, "more than one arg with ref_ob=
j_id R%d %u %u",
> > > > > -                             regno, reg->ref_obj_id,
> > > > > -                             meta->ref_obj_id);
> > > > > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > > > > +                     verbose(env, "more than one arg with ref_ob=
j_id %s %u %u",
> > > > > +                             reg_arg_name(env, argno), reg->ref_=
obj_id,
> > > > > +                             meta->ref_obj.ref_obj_id);
> > > >=20
> > > > I think this should be reported from update_ref_obj() itself,
> > > > it is more consistent logically and also avoids reporting code
> > > > duplication in check_kfunc_args() and check_kfunc_call().
> > > > Also, technically the reg_arg_name() is an independent fix.
> > >=20
> > > We have kfuncs that have more than one ref_obj. This is not a problem
> > > unless ref_obj is referenced in the verification and is ambiguous
> > > (e.g., used it to tie the lifetime of the allocated memory with
> > > ref_obj). Therefore, it is kept at the location of use instead of
> > > update_ref_obj() to prevent breaking existing kfuncs.
> >=20
> > Ack, thank you for explaining.
> >=20
> > > >=20
> > > > > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/=
bpf: Negative
> > > > > test case for ref_obj_id in args=E2=80=9D) since the verifier no =
longer
> > > > > complains about ambiguous ref_obj if it is not used.
> > > >=20
> > > > On the other hand, if you think that this property is worth having,
> > > > then maybe wrap the check with in some utility function?
> > >=20
> > > A utility function like below makes sense if we fold ref_obj_id into
> > > id. It would be too cumbersome for v3 as we may need two of this for
> > > ref_obj->ref_obj_id and ref_obj->id.
> > >=20
> > > static int get_ref_obj_id()
> > > {
> > >         if (ref_obj->cnt > 1) {
> > >                 verifier_bug(env, "function expects only one
> > > referenced object but got %d\n", ref_obj->cnt);
> > >                 return -EFAULT;
> > >         }
> > >         return ref_obj->id;
> > > }
> >=20
> > Maybe just like this:
> >=20
> >   static void validate_ref_obj(struct ref_obj_desc *d) { ... }
> >=20
>=20
> Do you mean:
> static int validate_ref_obj(struct ref_obj_desc *d) { ... }
>=20
> Then to use it:
> err =3D validate_ref_obj(meta.ref_obj);
> if (err)
>         return err;
>=20
> regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj.ref_obj_id;
>=20
> > ?

Yes, like that, sorry.
