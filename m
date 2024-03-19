Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50A839F9
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865571; cv=none; b=JyqdQfgVTpDUpiewnn7sUoYnykzI0FfoAoTfo/b8pPcC5Fwb6vdeccDeySTMCrqvobkMFpB1Q+jMWTgn4sRgSMtl0mg1FacH5EHqaG35GjYjwudnz5Ia6tCGBVNeZVDmN2shnJ01al2tA2E2VGl2CBCDqHFMBe/lLE+dSQyeZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865571; c=relaxed/simple;
	bh=KCblTgWje0ra4NildKKMelMwiwKwr6sJEkZHkAXfhmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQ+FIvxs8iLPNONyY19nvw2Ij6U9KJhd65R29yyKX+KqbXUyizXpYzLUI5bOl+T0dq1OQwdBYvyRC/IM1Qh7Ko1BEnkleqvXyy2KQ0q9Pa45qvqgA42rOFKnFvhG/pgiXPZ3GmNIfd7BoRpHJchesHPx1+r8bYC6HeQK3ueoXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFukWR8O; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFukWR8O"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dee5ef2a7bso39504025ad.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865569; x=1711470369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUYVfwVzFDjLKHszuUrtGHA4bD3XHmeCuCHK9UxxbR8=;
        b=HFukWR8Ovenf2lmLnqnb3nVYmF+LPeT06/HtSddXr4Z04E86ieE5z1jRmI5hVaTOC0
         s34hJTv0eZW1qta0PXyH88o6e4PUDtppQav0mZeu/JqMkDynaqBTa9DyoY79zRCC7vFW
         FjREFavUeqGLEhQmMqKtZL4hYyKfb9sdd+f+7MVZYpvfjZ9YqDsv4ZJDJMwwrSVAfrUh
         WVE8mEf0Z68fe1JZxQ1Q7LJYV32PgHOCm1S9fUP0OF/7HH4X+hKioe6sZ/ON9M/N6xvg
         1f/6GWMKBDSEX1oKXZHyPnVVyMDLcsj9Il6n4hW5JuDesqu6SJ3naLV1RReF0JAKcnYG
         AJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865569; x=1711470369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUYVfwVzFDjLKHszuUrtGHA4bD3XHmeCuCHK9UxxbR8=;
        b=Jvq841bBoUgBktAVGDnJhTOgYACbWtGv+BcRPXaSLvTktdJ0lOScPAbzRFqVA4pWs1
         dDGLA9bUuHDtl/DSxKidPDutC5I+d2+0cNFin3uGuxpI6uQO9Ppg6SvtJIRRqNQoYrki
         aVyMxHemqOEdeKjbQQXLzSZrY5Pp1vnd3tagXwExSid+59n3gmJ50uW2MhQP4tYNzgxg
         IeiJcNR4YeH/vCI2RPzpml1owxKGcy79L70Vlj3Lradz7ozhk3nRs+jMvTBzRYEvF8JB
         mhdHRxjl/tcmqVtAkdEh+0DqP4EDLzr4KmVZ/hLm2CAcYIVkHUtQOXWfofkp3gKsxiKw
         kZAg==
X-Forwarded-Encrypted: i=1; AJvYcCXbiLIhqjxdWgWcfZbSz5luf4u/3Ua4TZwIpM4ybKzsjb0355y8DAnJx+2inak3FKnlSwS5/aqK3Qpo7CRIuJllCWwb
X-Gm-Message-State: AOJu0YzyFoQZZLBrHlx9Zx2/Tcr1NSERzK6QwfjgeIy4MgPzgCxzqD5O
	dZZNv2axEPIeGDxB6Ad6h2or2M/KoH23jpOon9A2l9t/do51IqmGZCDjuYV2bqufXaX8HrUi6mE
	p21QkWAKDGXSbWEH8Jg4gGb3g5qg=
X-Google-Smtp-Source: AGHT+IHpKVGH50yLhLGqltMZvxnpqOyurKEmH7pSBs6Uy99kaC8JQAMJ6s3hEXnaoDYi3Di8dzi690QcWDSduumFATQ=
X-Received: by 2002:a17:902:e883:b0:1e0:115e:bae1 with SMTP id
 w3-20020a170902e88300b001e0115ebae1mr9505232plg.56.1710865569545; Tue, 19 Mar
 2024 09:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318093139.293497-1-jolsa@kernel.org> <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
In-Reply-To: <ZflyM5U67c47i4Oo@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 09:25:57 -0700
Message-ID: <CAEf4BzZ-cAByJq8FmgxJgMt7WKAsDME6K00hYJpcS6XiwYO=-w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 4:08=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Mar 19, 2024 at 11:25:24AM +0100, Oleg Nesterov wrote:
> > Obviously not for inclusion yet ;) untested, lacks the comments, and I =
am not
> > sure it makes sense.
> >
> > But I am wondering if this change can speedup uretprobes a bit more. An=
y chance
> > you can test it?
> >
> > With 1/3 sys_uretprobe() changes regs->r11/cx, this is correct but impl=
ies iret.
> > See the /* SYSRET requires RCX =3D=3D RIP and R11 =3D=3D EFLAGS */ code=
 in do_syscall_64().
>
> nice idea, looks like sysexit should be faster
>
> >
> > With this patch uretprobe_syscall_entry restores rcx/r11 itself and doe=
s retq,
> > sys_uretprobe() needs to hijack regs->ip after uprobe_handle_trampoline=
() to
> > make it possible.
> >
> > Comments?
> >
> > Oleg.
> > ---
> >
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 069371e86180..b99f1d80a8c8 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -319,6 +319,9 @@ asm (
> >       "pushq %r11\n"
> >       "movq $462, %rax\n"
> >       "syscall\n"
> > +     "popq %r11\n"
> > +     "popq %rcx\n"
> > +     "retq\n"
>
> using rax space on stack for return pointer, cool :)
>
> I'll run the test with this change
>

I can do some benchmarking on my side as well, given I have everything
set up for this anyways. Thanks for the help with speeding all this
up!

BTW, Jiri, what are you plans regarding sys_uprobe (entry probe
optimization through syscall), while we are on the topic?


> thanks,
> jirka
>
> >       ".global uretprobe_syscall_end\n"
> >       "uretprobe_syscall_end:\n"
> >       ".popsection\n"
> > @@ -336,23 +339,20 @@ void *arch_uprobe_trampoline(unsigned long *psize=
)
> >  SYSCALL_DEFINE0(uretprobe)
> >  {
> >       struct pt_regs *regs =3D task_pt_regs(current);
> > -     unsigned long sregs[3], err;
> > +     unsigned long __user *ax_and_ret =3D (unsigned long __user *)regs=
->sp + 2;
> > +     unsigned long ip, err;
> >
> > -     /*
> > -      * We set rax and syscall itself changes rcx and r11, so the sysc=
all
> > -      * trampoline saves their original values on stack. We need to re=
ad
> > -      * them and set original register values and fix the rsp pointer =
back.
> > -      */
> > -     err =3D copy_from_user((void *) &sregs, (void *) regs->sp, sizeof=
(sregs));
> > -     WARN_ON_ONCE(err);
> > -
> > -     regs->r11 =3D sregs[0];
> > -     regs->cx =3D sregs[1];
> > -     regs->ax =3D sregs[2];
> > +     ip =3D regs->ip;
> >       regs->orig_ax =3D -1;
> > -     regs->sp +=3D sizeof(sregs);
> > +     err =3D get_user(regs->ax, ax_and_ret);
> > +     WARN_ON_ONCE(err);
> >
> >       uprobe_handle_trampoline(regs);
> > +
> > +     err =3D put_user(regs->ip, ax_and_ret);
> > +     WARN_ON_ONCE(err);
> > +     regs->ip =3D ip;
> > +
> >       return regs->ax;
> >  }
> >
> >
