Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E702DA759
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270196; cv=pass; b=oFnnw6tKfC04U+wqpTsPyPs/ASqsvcuk4w/n66iK+NwTs+rOWP1Rz15cQkyjgYi8F7DJEAM1jnGQaIDBQYv9+baSaJ4iJgXhjjVfnBW9O49kFBkPg1Fx72p6uRoTOLjVvBbz2k653Pzv54UB9qtmh/zt1Lj5D9WOB+WnOAhbWgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270196; c=relaxed/simple;
	bh=J2BzAUt05n/jQUFtmc1TlupJWF+4/koq5zZ9Fy6XhQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaiaVsiWI1gy9S4qtyBgZ6/3ZfKVe3vL+WI3i8F/mVoHFeFtiw8v7BjdPRBrCC2a3LNJkMAm7ojJU/7U3KIvDt6W4brRUDaBbYTpY6IjcDsVJ8QEEUMq1A3cRuyGNnQOMbdXtgFgWe1r7/s/8zJf/f9UM5jghEmxhg2jx5IzTnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI607PNC; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI607PNC"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986c7b8076so4540047b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773270194; cv=none;
        d=google.com; s=arc-20240605;
        b=B23uLPm6Ksif4cEoMBL5xS/DEF6ovIizCwnSnD5wJEYcaTiPuY+N5LwDEQVv4pshp7
         R8/wWMHmYjvHK2TUL22ELfrS/HuMiu9HU2JkpCvfvW7DjezKp8T0kc4hqqjrfL95I7in
         JWb58S6ciCMqM3OaPUTgx2Sl7Zs6/jq4O2Y2y13Uxzf9wJrc8bM89KVXC9ge+CFd4k0U
         vXOH1edjcbq23zN6823KICCJ83OdekpWXWkDqpjHdEPsGwJIw6gXu4YIXfTYAvUzD9+C
         SQIm0Lqpq83yzDqH4UCoigLEm/oLCOEG+UuA0r1qamH//S6Ny4rPmZPHzDmKwr4LXhLv
         G+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p1nL4RVoOG6FSE4X+rL71zaGJT8RA06evE5D7IZSb+4=;
        fh=6ElxuiIjr8MUw7uRyrqk6E+jhEPFMT0pHHkRrcSi3dU=;
        b=M54yO1Zi5SONauSEO6Pw6XTCf2q5FnKJG8Zl+Y0lLnC1EEFx7q7l5guio3q9Z2V12w
         oS05fFDvKcfCHAaeurLEZ0rj63IVImorgQjlk2rRJuQOC5XdG1GFhWOKqRskf7a80thC
         Zj7xbK2AC6pLBUDza+BsOd4bIYiN8bDL6rt7MCfjtPv4Nrpg9anx8wmh//v8u4SOS4G4
         dWcmKpWptmsdOC64X7wJGKpKSeSGASbeEU6d1FBkhSFIEQRb60z/D/o2dhNcHIuzoWmo
         N0eZs0sO8vfaxZUyOZBVb7X6o/GilweKQs4qoKPezHaCUyxD+Hpa26bc7rKYkls9Foho
         SlSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773270194; x=1773874994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1nL4RVoOG6FSE4X+rL71zaGJT8RA06evE5D7IZSb+4=;
        b=SI607PNCZjKM5J0PC0HQcoesj7tVYrSrqvSCl7W858mfWaUoAzl8ktUdNAM1wKztWn
         6j5OJtTwYbkaJIXnillXl5lLp9SM1cghr42ndR4YXIi20ibGq4sB8/9qmUjN2dxcaF1b
         jh/X2ZAU68gW3BZz/DX7zjX/9Xp8dcrxw70XGdYFSjv8lpZd0ubx/QXKbHfHC8v/KCPk
         jWoCVRgahLMXUhZAOpk1NAbrydllGAZQLTuJ6oSkGp7QYmc9Y58rs8xH/xrYGz01Fd8o
         hxjwrlxM2DqY13zmyg0+HCw91RcxKAYf67REeM8s3Tg+lU9K4F9LUBDY57QrWHcs3pbY
         7c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270194; x=1773874994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p1nL4RVoOG6FSE4X+rL71zaGJT8RA06evE5D7IZSb+4=;
        b=rtByoMsX4wZCrnwudMtZqOkKsagLa37UbRgJrT62pwmvu9JUgsgdtv83Dr3SL8YSnd
         aSFIh+3qabl/k5Bq9reOpZVS62AIIVBFtV7Ds3UhAQqA/VSUZP/K5643YKt7DMxFGRTw
         OLQuhAmlyHZ0UVmFGzCzGsKlMBG8BVBkN0UIk4wZxk1jDoi4zFA9cnF4r9cxlxGp/rX8
         pYq5hhAdqmtvGDy6V2RNW2cHWxAPtgW2/OaPIgWVkIQSo9TV1O+Rh9mHQ7DgU3ByO5tS
         7N4XXf3mfd0g6vB7618rZNQiiHf2pkc51nq1pN/RiPMYAj7ZmIomRk5HiRMWIVpEAPvH
         AK0Q==
X-Gm-Message-State: AOJu0YzazrGm/ySLlpygUN1l3SoEIdVZWQg1xzXeXjeAd///a056C9eV
	5FN10rQtk47Iqo1qr2onaieBloU5sQgiYb95EKVb2hf1Q6lrVraBMTJjlkzkGXbjSemgr/KvyIX
	xTbkl4BEaB7lKmE/HYzUtvrYl1XmSGM8=
X-Gm-Gg: ATEYQzwV3e0lzkUagCOvTTQAhmzXs30giOQyCGR7JlJiYCAaxUPVeXnSbtP4rCuEYLW
	Kpn9XO6JiPCs7splj+e+UQ9riBJ9N8xAExSLUO2Pubues7+LGN3kkRuaXwNXfSBeVIyYp1mRd6E
	M4lMBOkAWxczyjhJplY0onV+sIRFd6Wl9KJXlEkxP3RZ94XBtgnAO+cPl8+YB0hLe7gxqbPU8em
	CiRBDHXwE9ZiuE1houaJBMAAR8wgsn5eeJbbOqYW8ustDi+WHf3su4DXNcNDt052/HP0o+huN7+
	mw3R96c=
X-Received: by 2002:a05:690c:6e84:b0:794:78d0:9b57 with SMTP id
 00721157ae682-79917e9de17mr39016587b3.16.1773270194093; Wed, 11 Mar 2026
 16:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com> <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
In-Reply-To: <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 16:03:02 -0700
X-Gm-Features: AaiRm52aqQKm9IrpolvS8vKyhIuaxkmlqQ4ERAyf1ATinHmIsdtysTaU_QZQ0OY
Message-ID: <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:37=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.c=
om> wrote:
> > > >
> > > > The verifier should decide whether a dynptr argument is read-only
> > > > based on if the type is "const struct bpf_dynptr *", not the type o=
f
> > > > the register passed to the kfunc. This currently does not cause iss=
ues
> > > > because existing kfuncs that mutate struct bpf_dynptr are construct=
ors
> > > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> > > > additional check in process_dynptr_func() to make sure the stack sl=
ot
> > > > does not contain initialized dynptr. Nonetheless, this should still=
 be
> > > > fixed to avoid future issues when there is a non-constructor dynptr
> > > > kfunc that can mutate dynptr. This is also a small step toward unif=
ying
> > > > kfunc and helper handling in the verifier, where the first step is =
to
> > > > generate kfunc prototype similar to bpf_func_proto before the main
> > > > verification loop.
> > > >
> > > > We also need to correctly mark some kfunc arguments as "const struc=
t
> > > > bpf_dynptr *" to align with other kfuncs that take non-mutable dynp=
tr
> > > > argument and to not break their usage. Adding const qualifier does
> > > > not break backward compatibility.
> > > >
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > ---
> > > >  fs/verity/measure.c                            |  2 +-
> > > >  include/linux/bpf.h                            |  8 ++++----
> > > >  kernel/bpf/helpers.c                           | 10 +++++-----
> > > >  kernel/bpf/verifier.c                          | 18 ++++++++++++++=
+++-
> > > >  kernel/trace/bpf_trace.c                       | 18 +++++++++-----=
----
> > > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > > index 6a35623ebdf0..3840436e4510 100644
> > > > --- a/fs/verity/measure.c
> > > > +++ b/fs/verity/measure.c
> > > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > > >   *
> > > >   * Return: 0 on success, a negative value on error.
> > > >   */
> > > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct =
bpf_dynptr *digest_p)
> > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const s=
truct bpf_dynptr *digest_p)
> > >
> > > but kfunc is writing into digest_p, so that const is wrong?...
> > >
> > > >  {
> > > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_k=
ern *)digest_p;
> > > >         const struct inode *inode =3D file_inode(file);
> > >
> > > [...]
> > >
> > > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct=
 bpf_dynptr *p,
> > > >   * Copies data from source dynptr to destination dynptr.
> > > >   * Returns 0 on success; negative error, otherwise.
> > > >   */
> > > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 ds=
t_off,
> > > > -                               struct bpf_dynptr *src_ptr, u64 src=
_off, u64 size)
> > > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, =
u64 dst_off,
> > >
> > > again, dst_ptr clearly is modifiable because we are copying data into=
 it.
> > >
> > > What am I missing, why is this logically correct?
> > >
> > > (I understand that from purely C type system POV this is fine, becaus=
e
> > > we don't modify bpf_dynptr struct itself on the stack, but bpf_dynptr
> > > is a representation of some memory, and if we are modifying this
> > > memory, then I think it should be not marked as const)
> >
> > The patch is just to first make the arg type determination independent
> > from bpf_reg_state and make kfunc signature consistent based on what
> > commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.
> >
> > Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), the
> > flag means the dynptr struct on the stack is immutable. Currently,
> > there is no way (and maybe no need?) to specify read-only dynptr.
> >
>
> are you basically trying to determine if CONST_DYNPTR_PTR is allowed or n=
ot?

Yes.

>
> > > > The verifier should decide whether a dynptr argument is read-only
>
> can you please remind us what "read-only dynptr argument" means for verif=
ier?

Oh well... my apologies for the inconsistency in commit message and
comments. It should be "immutable" instead of "read-only" here.

>
> > >
> > > > +                               const struct bpf_dynptr *src_ptr, u=
64 src_off, u64 size)
> > > >  {
> > > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)d=
st_ptr;
> > > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)s=
rc_ptr;
> > >
> > > [...]
