Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139EE4436E
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956705; cv=none; b=WkYE68wcF93hez5dlUGWC2XLkBPjswo1aVo6mzCCMHiZ7tHJxB+BvNHJ84OyIrhiN5sh7G4Bw0XMfeGdSC5jiUyOy7M9GYOqxBqkxnaI8MXWTwAGxMMfQjmjMLxSNbptmIcAciuhTL/PeqO0RCJQ092DDeeFfjrdGW4Yz8jYodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956705; c=relaxed/simple;
	bh=ierB0wRBCcEb6KDaQmeTkk4OjaokYQkWNlMfUHhA6oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOzxRi5Wd32z0OPrIEM6GiiEotSqONlBIWULXDfnm839DpMf0ulCw2wWVSNQmTFPVHWd71Tppb63e6FOaKbXEWGrtQV0Ct2an0vK1qa8XHbniUBa3OdCRGRuLQ87IL0LQ8bnIOi72bPwxm9w9bKFO4YhCvITCk2sZ6FThh+Hyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjxXnn6u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjxXnn6u"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dde26f7e1dso359155ad.1
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710956703; x=1711561503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/jeas4NTUodWyFBOqngXxSYLoKa5KYJ5WEFf1wN9kM=;
        b=AjxXnn6uharIbVz49q3we/pM4hDony5Irzh9dV/Iyvh/JQSUaUJefZBVUHkkaxRvXJ
         oc0xEPdEKtEHIRYNb2dxt0N17PlFxLOWy/a9Hkr+jxgoMIcmFioBkaiMTjN2gAt7IcQm
         wO+EGsGFwZ4fHF9odGfEg3Moz/BMj2+Cdg0n/9mZ0yfGhqhNUztdXQvPIHWniZj5keTp
         iZ+OOpFXWQFqunX03iairlDaYpe99gH2n2WfWoPUvz4mnPEXWDPhHjZ2+hz7UfThU2Xa
         iLwRFbBr9omiqvPw0yD/w9TpN0KwaOhcgxVBuYjIOPXtpzxn4LTGZM71QHQJ04FUPKk/
         jTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710956703; x=1711561503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/jeas4NTUodWyFBOqngXxSYLoKa5KYJ5WEFf1wN9kM=;
        b=BqPi8uv+H+gpeUEUDoF23kroZX7XTKWmssO7WIc3sI+vvKPShqUxgveZofPbrasRfb
         dHPt2nnaoLcv01GJi2IvBf7NljlwBc0glaOkN4cUvuKOR1D9SaXKwC/FXa8mC0N8wKna
         TuZJT7rr8y6Ko7uDdh4/wnGu5zbq6ildsMShBCcV64grfvW+6IAcbsbQkW1nCLRpdwCm
         o6j0yxK7AN81sBGITXeUIqpxsrrta74SL3R/T7wsfTgUl7SS9Ac80gsSVJAx23wrJtg1
         fO/lTL1/jiNmSNH9ajD2xctYt+50svBQG6K9R57kP3g1It0lKPKtYtgd7/LkwiV+a0af
         UIAw==
X-Forwarded-Encrypted: i=1; AJvYcCXVBFA2p/vgvQEaoEErMNoHeaITCljR99EeI8Z4ik5jSJ5Zi7PXcyTiNCiAtAybgvl61sLtP88QoPBgDwvVWOwK86Ye
X-Gm-Message-State: AOJu0Yx3MNomIyzNYIEDYp+IkIOcrc8PtlQPBT3yBJ1fS9IXZY6S/TST
	AmifyqHusPsZfJD2//nOL6hJmlizJh6B6Gm7AsUzZa4Xpj/3/8lMzbCe/5/n8w6KDsb67RhiU+4
	5z5FPBixVcSQ3/VFX5NuqbfMfwQHvqIR4
X-Google-Smtp-Source: AGHT+IHXkZuAJZ+2Q5QPaarekEoY/VxNJpOCTTmBixWA+JvGQwIO7pliT6jZr0pU1bRQEtgYbHDoAXZdHMGBYnVMUNg=
X-Received: by 2002:a17:90a:d084:b0:29b:ab0e:4f03 with SMTP id
 k4-20020a17090ad08400b0029bab0e4f03mr14696854pju.37.1710956682822; Wed, 20
 Mar 2024 10:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318093139.293497-1-jolsa@kernel.org> <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava> <ZfnoK8aQDJMgOYfY@krava> <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com> <20240320152848.GA7613@redhat.com>
In-Reply-To: <20240320152848.GA7613@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Mar 2024 10:44:30 -0700
Message-ID: <CAEf4Bzbw4CGCptxi7tXoZEEkm_wcBzkaJgTN_tYE5K7sSUgMhw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:30=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 03/20, Oleg Nesterov wrote:
> >
> > On 03/20, Jiri Olsa wrote:
> > >
> > > are you ok if I squash the patches together
> >
> > Yes, thanks, I am fine.
> >
> > But lets discuss this change a bit more. So, with this poc we have the
> > (intentionally) oversimplified
> >
> >       SYSCALL_DEFINE0(uretprobe)
> >       {
> >               struct pt_regs *regs =3D task_pt_regs(current);
> >               unsigned long __user *ax_and_ret =3D (unsigned long __use=
r *)regs->sp + 2;
> >               unsigned long ip, err;
> >
> >               ip =3D regs->ip;
> >               regs->orig_ax =3D -1;
> >               err =3D get_user(regs->ax, ax_and_ret);
> >               WARN_ON_ONCE(err);
> >
> >               uprobe_handle_trampoline(regs);
> >
> >               err =3D put_user(regs->ip, ax_and_ret);
> >               WARN_ON_ONCE(err);
> >               regs->ip =3D ip;
> >
> >               return regs->ax;
> >       }
> >
> > I have no idea what uprobe consumers / bpf programs can do, so let me a=
sk:
> >
> >       - uprobe_consumer's will see the "wrong" values of regs->cx/r11/s=
p
> >         Is it OK? If not - easy to fix.
> >
> >       - can uprobe_consumer change regs->cx/r11 ? If yes - easy to fix.
> >
> >       - can uprobe_consumer change regs->sp ? If yes - easy to fix too,
> >         but needs a separate check/code.
>
> IOW. If answer is "yes" to all the questions above, then we probably need
> something like

yes to first, so ideally we fix registers to "correct" values
(especially sp), but no to the last two (at least as far as BPF is
concerned)

>
>         SYSCALL_DEFINE0(uretprobe)
>         {
>                 struct pt_regs *regs =3D task_pt_regs(current);
>                 unsigned long err, ip, sp, r11_cx_ax[3];
>
>                 err =3D copy_from_user(r11_cx_ax, (void __user*)regs->sp,=
 sizeof(r11_cx_ax));
>                 WARN_ON_ONCE(err);
>
>                 // Q1: apart from ax, do we really care?
>                 // expose the "right" values of r11/cx/ax/sp to uprobe_co=
nsumer's
>                 regs->r11 =3D r11_cx_ax[0];
>                 regs->cx  =3D r11_cx_ax[1];
>                 regs->ax  =3D r11_cx_ax[2];
>                 regs->sp +=3D sizeof(r11_cx_ax);
>                 regs->orig_ax =3D -1;
>
>                 ip =3D regs->ip;
>                 sp =3D regs->sp;
>
>                 uprobe_handle_trampoline(regs);
>
>                 // Q2: is it possible? do we care?
>                 // uprobe_consumer has changed sp, we can do nothing,
>                 // just return via iret.
>                 if (regs->sp !=3D sp)
>                         return regs->ax;
>                 regs->sp -=3D sizeof(r11_cx_ax);
>
>                 // Q3: is it possible? do we care?
>                 // for the case uprobe_consumer has changed r11/cx
>                 r11_cx_ax[0] =3D regs->r11;
>                 r11_cx_ax[1] =3D regs->cx;
>
>                 // comment to explain this hack
>                 r11_cx_ax[2] =3D regs->ip;
>                 regs->ip =3D ip;
>
>                 err =3D copy_to_user((void __user*)regs->sp, r11_cx_ax, s=
izeof(r11_cx_ax));
>                 WARN_ON_ONCE(err);
>
>                 // ensure sysret, see do_syscall_64()
>                 regs->r11 =3D regs->flags;
>                 regs->cx  =3D regs->ip;
>
>                 return regs->ax;
>         }
>
> Oleg.
>
