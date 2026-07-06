Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1243DD85B
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337328; cv=pass; b=TnlvfdjLhryTxmd3gebjkbK9Q/BoARWoM+MjGHaEN+EWK1wgI3xxNxNnOdurWpSHPpU7vifon4N0AOVYMet9fFJ4NdMDLo6CI+w6JrCUJ0wR4gN6eDM6ILgYK/x/B8uLTmt/gI7483ca1fjp3gZnA5mkKhLmqqt3s6Ai1UK/plo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337328; c=relaxed/simple;
	bh=UnVNq/wWWKvKlOrOF6g0ETJyq4yEhQX5Rgky1/KTcPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyDj31C6yqdO55kTS9oe0YI9XFVKZcchU38OiD9aoLA/NEPFQXHd3iqa7u/vXheMHM0vifAIMx3eNJOH+jVArSeX6ryfDuBb2mJqsi/pEysvDnGQRvrB66TSKPAyqqPa6wH48IzT6bC0HWpmNUgrMJOuAJkswEwXkuSQDDbX8w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTDuOYid; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTDuOYid"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c126b8118afso348407666b.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 04:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783337325; cv=none;
        d=google.com; s=arc-20260327;
        b=DZP5r6MhrqUiVaJ3GRlFbbBVPjAqpGYS5RX2T6VcAhZm/SCixW0aNi8cCOqlto3xs/
         azEBA0iwvLQn44ULulvEYcMyuAcu3EsDe8GwBZdVHqRzvwcSQMKqHS6BJqL364wUBVd/
         ZWRL0U+TNIsrZh4hBe76G49zuo5xhz+momltDmUU4F5y45z/GX/r+SVFU1fKfG2cnu8l
         SP2mwRNmZkR2JTBEaNw4xJTZpcdMfKMr7It3oqfQqcnXM2oohq15EwT1RGz5Nmp7QlKV
         pUAtPlg1UCxOORwE4YUQ/o/Ldqh+yXgoD2t+AtcZqr1O+t94EEx6GeD9XPLJKDcts1ap
         Y45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFOj79bWOnd0LS0wjSgsgRhf1+z7hwm6H+c6gNDl8fY=;
        fh=++llaMHPpNdcclvDlNvdn1k/420oxF/RHbHN1VCG4T0=;
        b=U/S9atX+3f8SXPRzkbkzGlvbkqiZ63xvdyi2eBOYFwrK76F9toTNLshN+v2snA26Gv
         KC0pRlCVW/KnkbKFAZZsupFg9QOzWAjAmfFgfYM/G+VxQFqtGXhLCr3I/tzt49BXasZH
         2CqVyFBegHTzWXB5HZz4z3kBg57sfSB5Lrj4nIYDKahVGkYnUY9GPaD9pHDsCP+Df5ZZ
         T4DqfT503LwKdoI9Dtff0npiIn2HEUN9AZ+XhnBfP6wHBpxNY1u9DuJ+n/edAdHrjDXx
         lhX8hYOaIfmy6YMQQb3+ir/6+xn8Gmdk5qv7+9EMHjyEIa/vhyldLqHPsWtGJGLtt/g/
         ObtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783337325; x=1783942125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wFOj79bWOnd0LS0wjSgsgRhf1+z7hwm6H+c6gNDl8fY=;
        b=RTDuOYidaS8IpkUIERhWc25/XU3u9bmNfiychQIFM64HjpmFnEV3oGDUMhNl2Ica0R
         rkZxPl2ceB8fk0heMmvQI2FP+S5LyP7gwm2Ddtg7SWc0eb4nkkerTF2HMQxbixaJWSgO
         ab8px22mlg3E4G1tohp94r8hTiWIo1q5+RVXZIM2fM8OKoaFgycwS6gWxvCETFUHiM9g
         EVMqhgjezo+XWGFCc9HdBBGP6vjPg1o0mtpbefTMUuXvwMzg7Tebihbv+1Lzo5Us5slS
         jnJpTZ66x+o6b3+Ih+Ywloe5ubjEbwXiA56SQynXi+XBVJF14diUJBMfhjY5t7yToCss
         tprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337325; x=1783942125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFOj79bWOnd0LS0wjSgsgRhf1+z7hwm6H+c6gNDl8fY=;
        b=OwCugEL4P7FRFt44lvgzmnDTnQTrs9V0uDTkk4WOxbeLMfUpie/3yaKL0UF6xn4pT+
         8Pge8xT1nhXFN28xWk5zDQTqdWL3iR1lls057T3lO69yXlBetDYOUFSXjYa0P9atxbOf
         U9Vk5itWpd5J8SS5a390y4MlradaY7Rb6FJ+ITYe1L5f5YvaJBMrRBTlqNi9493hKDjL
         xR+EXi2Ja9GYwlmCmrxttD5ixwgYnVANK/MYgF0wBqPTcXXFquMN9ccAnqN6kRYNqdP4
         U88JthOHNv5DRnjjIyZ0XzMlvCnYLjUBWutk/LLhxEbi1/drJvliiHQjpR8Oeb1l+v3y
         lMUA==
X-Forwarded-Encrypted: i=1; AHgh+Rqsdbj490qdhE8miKY6vlP9CtX6/6WMrajBN5kFDegyg7wVOJcw6bfzVcy6N67yZDGMcfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGZ7riHwWx5UNUutcHGE5rHe8BNAninOY9fXkQ2MHs90VkKaM
	NpEHkAaPvst3bO7zcSWJfYF5mgw0ZOidFJF/ojT7fxVryzyZq1+N46uZe8oOnhp7ZWEnUMkedN9
	cyyCsAWMA23DpAS/eqZPCXYVRtLPKcGbGVqvCQ2s=
X-Gm-Gg: AfdE7cmrAcvY7h1G+3G9DdVN+aRv7Rx+DgkDHYe1y+CJUpsyb60FD1qhGazhTMNsYXh
	XiZthCWGwa4OlYGu39X4pgCehnTLqm4Cq5P49qfYriHb4w+PyjVJUjxqZLgnbwmuBGUl5iKHzLr
	VKfvbqL3IlUbA+W3m/I3JMwXrQLL6jAO17OnzTfq7b/uWmJj5IdiXJ4rMCw6B3B4YbxJK1hKaHF
	Cw+6SqM/eDhRt2j/oLUPBav5V7yeFyTRnO2DKCECgiRJB0DIp5XSqBcbGM0ex/ta8mKe/AUjEp1
	ONjY4XPYK9fN
X-Received: by 2002:a17:907:787:b0:c12:525b:4e84 with SMTP id
 a640c23a62f3a-c15a67d60edmr7635666b.9.1783337324905; Mon, 06 Jul 2026
 04:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com> <CAEf4Bzby1M8OPRomzEq-xvciK-Zq2zoL0AoSn=iSR02t=wdNOg@mail.gmail.com>
In-Reply-To: <CAEf4Bzby1M8OPRomzEq-xvciK-Zq2zoL0AoSn=iSR02t=wdNOg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 6 Jul 2026 12:28:31 +0100
X-Gm-Features: AVVi8CetW9gw2hBN3-LImrQOVIhuWsQfo_rzbdkuFO_gKpVT2HD5VfQD2dz4NE8
Message-ID: <CANk7y0g+tk_C9jF6c0420NDEyeM7LYgYyoCkKxy1utB46GnDUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 29, 2026 at 8:25=E2=80=AFPM Sanghyun Park
> <sanghyun.park.cnu@gmail.com> wrote:
> >
> > bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
> > holding a reference on the mm. On a foreign task, a concurrent exit_mm(=
)
> > can free the mm_struct between the lockless read and the trylock,
> > resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.
> >
> > For the current task, task->mm is stable. For a foreign task, pin the m=
m
> > under task->alloc_lock and release it with mmput_async(), mirroring com=
mit
> > d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator").
> > Use spin_trylock() instead of get_task_mm() so BPF context does not blo=
ck
> > on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
> > foreign-task path because dropping the mm reference is not safe there.
> >
> > Race:
> >
> >   CPU0 (BPF program)                  CPU1 (exiting task)
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   bpf_find_vma(foreign_task):
> >     mm =3D task->mm
> >                                       exit_mm():
> >                                         task->mm =3D NULL
> >                                         mmput(mm) -> frees mm_struct
> >     mmap_read_trylock(mm)
> >         // UAF on mm
> >
> > Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> > ---
>
> Puranjay, PTAL, I think you've been fixing similar issue in
> bpf_iter_task_vma_new(), would be nice for you to check this fix as
> well. Thanks!
>
> > v6:
> >  - Restore bpf_iter_mmput_async() because bpf_iter_task_vma_destroy()
> >    still uses it.
> >  - Keep the direct mmput_async() call in bpf_find_vma(), but guard it w=
ith
> >    CONFIG_MMU because mmput_async() is declared only for CONFIG_MMU bui=
lds.
> > v5: https://lore.kernel.org/bpf/20260630023443.3026627-2-sanghyun.park.=
cnu@gmail.com/
> >  - Replace bpf_iter_mmput_async() with mmput_async() directly as sugges=
ted
> >    by Yonghong.
> >  - Add Yonghong's Acked-by.
> > v4: https://lore.kernel.org/bpf/20260610024637.343364-1-sanghyun.park.c=
nu@gmail.com/
> >  - Use [PATCH bpf-next] subject as requested by Alexei.
> >  - Add the missing BPF maintainers/reviewers to Cc.
> > v3: https://lore.kernel.org/bpf/20260609105216.3536839-1-sanghyun.park.=
cnu@gmail.com/
> >  - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
> >    trylock + mmput_async(). (Yonghong Song)
> >  - Reject irqs-disabled contexts on the foreign-task path.
> >  - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async()
> >    falls back to mmput() which may sleep, and bpf_find_vma() can run
> >    in non-sleepable context.
> >  - Shorten the foreign-task rationale comment and trim the changelog bo=
dy.
> >  - Fix the v2's whitespace damage.
> > v2: https://lore.kernel.org/bpf/CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGVKO=
Aa3_ZenPOFkA@mail.gmail.com/
> >
> >  kernel/bpf/task_iter.c | 36 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index fc5f463ca529a..1d56193caf5e4 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -760,6 +760,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task=
, u64, start,
> >         struct mmap_unlock_irq_work *work =3D NULL;
> >         struct vm_area_struct *vma;
> >         bool irq_work_busy =3D false;
> > +       bool mmput_needed =3D false;
> >         struct mm_struct *mm;
> >         int ret =3D -ENOENT;
> >
> > @@ -769,14 +770,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, ta=
sk, u64, start,
> >         if (!task)
> >                 return -ENOENT;
> >
> > -       mm =3D task->mm;
> > +       if (task =3D=3D current) {
> > +               mm =3D task->mm;
> > +       } else {
> > +               /*
> > +                * Foreign task: pin task->mm against a concurrent exit=
_mm().
> > +                * Use trylock on alloc_lock instead of get_task_mm()'s
> > +                * blocking task_lock() to avoid deadlocking the target=
 task.
> > +                */
> > +               if (!IS_ENABLED(CONFIG_MMU))
> > +                       return -EOPNOTSUPP;
> > +               if (irqs_disabled())
> > +                       return -EBUSY;
> > +               if (!spin_trylock(&task->alloc_lock))
> > +                       return -EBUSY;
> > +               mm =3D task->mm;
> > +               if (mm && !(task->flags & PF_KTHREAD)) {
> > +                       mmget(mm);
> > +                       mmput_needed =3D true;
> > +               } else {
> > +                       mm =3D NULL;
> > +               }
> > +               spin_unlock(&task->alloc_lock);
> > +       }
> >         if (!mm)
> >                 return -ENOENT;
> >
> >         irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
> >
> > -       if (irq_work_busy || !mmap_read_trylock(mm))
> > -               return -EBUSY;
> > +       if (irq_work_busy || !mmap_read_trylock(mm)) {
> > +               ret =3D -EBUSY;
> > +               goto out;
> > +       }
> >
> >         vma =3D find_vma(mm, start);
> >
> > @@ -786,6 +811,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, tas=
k, u64, start,
> >                 ret =3D 0;
> >         }
> >         bpf_mmap_unlock_mm(work, mm);
> > +out:
> > +#ifdef CONFIG_MMU
> > +       if (mmput_needed)
> > +               mmput_async(mm);
> > +#endif
> >         return ret;
> >  }
> >
> > --
> > 2.48.1

Thanks for this, it looks good to me.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
