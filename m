Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C255C34
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879237; cv=none; b=hAIEhL6tpZicDDaqK+1YL0tELta1t0T1UfQX5DbBjAjnMeF9WRUu+zOnSZbQAD4noSw/vyn6wvil/JAaHpj+ByxJ1X6dnEFtzfyfDb9nU5RWO4RddAEkx8R6Hydajyp8GVfOuZ+BuypANpwn+TkCqDqCGsjmC09ai5nD3Hfc3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879237; c=relaxed/simple;
	bh=uZCQaEoj7DBqTwSa8W2rmwPm1buaza/6/nImi1P0gLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkILaTU6J872zj+sMd4YbgF3HveTYVctvUO6xdRBcm3/3Hcie1QzSc8wnJJZ0x68XYez4G0SuNk6r+uaTs3x5TniHeX/JxTGFATwVKkjdwzSeX4a+1GlccWuVcWKkErx4eoFJFQ2ggXXln71DZafQng7L7nPLtpRaotg1ro7I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETOInXOF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETOInXOF"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3372278a12.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710879235; x=1711484035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNTdFGn3O7HKSXHPI0i5BRAKzOTciKn6BI4TQC6X0hA=;
        b=ETOInXOFLLZN+NZbeBLkQ4IWqCLOfnBjlHjxXWUkZVnjUt05GjnPN5Ttn/gN5+v3LQ
         HxelNx2y5Jr1bdNsOrnQgiHLgtdbwtVkH6GpDlWoQBUA4N+VSCXnERpoi8Kl+fskIHXN
         oewXwhW2rdXGgDQXF+f3lCYFYWyrBeLFOct4typay3iiOLo3S/1cldy+utOmyR5qXAt4
         J71TIeScy+y7toqLeoLH/iSWSKH89SiN2YaBOXxjCSMjAKRkoOOQ8LVvDF4p2w0IS4hj
         uyMFGVRIQeUouLZ8QTCnLscRzKpDUPwS9y14WCeniLiH23VsiMXUeHyGjlfUnKBSoLFN
         muIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710879235; x=1711484035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNTdFGn3O7HKSXHPI0i5BRAKzOTciKn6BI4TQC6X0hA=;
        b=ologg1W37Diz95JBvkL5xDY+TznQQdijK2IK6shlJ6bgZJJuTQE/Z7xC9XBJnuXvy9
         rFOBGIP0bn0ymRBtqyLY8EbxJ+l550qVIluQLuc8uzmiqh/80tcUC5ea1aZH06akfE+m
         3UtMnzf1NqloHp6qq2Hu3N1jSm1U1sf/VADrt5HnrzvPRUROfKBeAk5xDfa8QyMNJO5Q
         QcYdXBifM2DtxUpzgZ/6vm8tMrMOzLUOCxEqfQic+CdYGVawi1J6+22m8NqLwj1ZWuxU
         1oEYDMB9WI9F3P1P691n9jDigen3QDdzsVIwZ6eK54Io9l4WC4t+bMtSVs70O6S5KZSI
         rZYw==
X-Forwarded-Encrypted: i=1; AJvYcCXhtWypczaRGflCUKdkmu267u83ohbtk+LNmfVBhUsSv7yLxPNf6x4cKo07jJpG6rSuvZiFMysLpM+LhumYzEtOY45x
X-Gm-Message-State: AOJu0YzbDjy63WDKWEldPqlxlHwaF55ww44sGzME27I9nWiVsgiwC8sp
	v/fY7dUyqVX9pIvrwJzkURkCr28pt+2OKiMESdbg3mpcYfXIQtrTyHw5iLheTyzlEjn5g7uCBsZ
	NnRANe5eysGV9x0k4MVZfguFmulw=
X-Google-Smtp-Source: AGHT+IFN4GIl7rr7UQpqu8/BEIVICeV+fzVQ58H1oZ66enY4ooSJa4FbBI/NMFApH+D+wnvkcdNSkuK/fSNM+UYXPzY=
X-Received: by 2002:a17:90a:d917:b0:29c:3c5e:cc80 with SMTP id
 c23-20020a17090ad91700b0029c3c5ecc80mr206713pjv.33.1710879235322; Tue, 19 Mar
 2024 13:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318093139.293497-1-jolsa@kernel.org> <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava> <ZfnoK8aQDJMgOYfY@krava>
In-Reply-To: <ZfnoK8aQDJMgOYfY@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 13:13:42 -0700
Message-ID: <CAEf4BzZTWcUS8ik9be-DJrSUVRpZzpOoP_uLmZvie2UO15Qu3A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 12:32=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Tue, Mar 19, 2024 at 12:08:35PM +0100, Jiri Olsa wrote:
> > On Tue, Mar 19, 2024 at 11:25:24AM +0100, Oleg Nesterov wrote:
> > > Obviously not for inclusion yet ;) untested, lacks the comments, and =
I am not
> > > sure it makes sense.
> > >
> > > But I am wondering if this change can speedup uretprobes a bit more. =
Any chance
> > > you can test it?
> > >
> > > With 1/3 sys_uretprobe() changes regs->r11/cx, this is correct but im=
plies iret.
> > > See the /* SYSRET requires RCX =3D=3D RIP and R11 =3D=3D EFLAGS */ co=
de in do_syscall_64().
> >
> > nice idea, looks like sysexit should be faster
> >
> > >
> > > With this patch uretprobe_syscall_entry restores rcx/r11 itself and d=
oes retq,
> > > sys_uretprobe() needs to hijack regs->ip after uprobe_handle_trampoli=
ne() to
> > > make it possible.
> > >
> > > Comments?
> > >
> > > Oleg.
> > > ---
> > >
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index 069371e86180..b99f1d80a8c8 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -319,6 +319,9 @@ asm (
> > >     "pushq %r11\n"
> > >     "movq $462, %rax\n"
> > >     "syscall\n"
> > > +   "popq %r11\n"
> > > +   "popq %rcx\n"
> > > +   "retq\n"
> >
> > using rax space on stack for return pointer, cool :)
> >
> > I'll run the test with this change
>
> I got bigger speed up on intel, amd stays the same (I'll double check tha=
t)
>
> current:
>   base           :   16.133 =C2=B1 0.035M/s
>   uprobe-nop     :    3.003 =C2=B1 0.002M/s
>   uprobe-push    :    2.829 =C2=B1 0.001M/s
>   uprobe-ret     :    1.101 =C2=B1 0.001M/s
>   uretprobe-nop  :    1.485 =C2=B1 0.001M/s
>   uretprobe-push :    1.447 =C2=B1 0.000M/s
>   uretprobe-ret  :    0.812 =C2=B1 0.000M/s
>
> fix:
>   base           :   16.522 =C2=B1 0.103M/s
>   uprobe-nop     :    2.920 =C2=B1 0.034M/s
>   uprobe-push    :    2.749 =C2=B1 0.047M/s
>   uprobe-ret     :    1.094 =C2=B1 0.003M/s
>   uretprobe-nop  :    2.004 =C2=B1 0.006M/s  < ~34% speed up
>   uretprobe-push :    1.940 =C2=B1 0.003M/s  < ~34% speed up
>   uretprobe-ret  :    0.921 =C2=B1 0.050M/s  < ~13% speed up
>
> original fix:
>   base           :   15.704 =C2=B1 0.076M/s
>   uprobe-nop     :    2.841 =C2=B1 0.008M/s
>   uprobe-push    :    2.666 =C2=B1 0.029M/s
>   uprobe-ret     :    1.037 =C2=B1 0.008M/s
>   uretprobe-nop  :    1.718 =C2=B1 0.010M/s  < ~25% speed up
>   uretprobe-push :    1.658 =C2=B1 0.008M/s  < ~23% speed up
>   uretprobe-ret  :    0.853 =C2=B1 0.004M/s  < ~14% speed up
>

My machine is slower, even though I turned out mitigations and stuff
like that, I feel like there are still some slow downs. But either
way, data is at least consistent as far as baseline goes (it's called
syscall-count now in my local changes I'm yet to submit), and yes,
Oleg's change does produce a noticeable speed up:

baseline
=3D=3D=3D=3D=3D=3D=3D=3D
usermode-count :   79.509 =C2=B1 0.038M/s
syscall-count  :    9.550 =C2=B1 0.002M/s
uprobe-nop     :    1.530 =C2=B1 0.000M/s
uprobe-push    :    1.457 =C2=B1 0.000M/s
uprobe-ret     :    0.642 =C2=B1 0.000M/s
uretprobe-nop  :    0.777 =C2=B1 0.000M/s
uretprobe-push :    0.761 =C2=B1 0.000M/s
uretprobe-ret  :    0.459 =C2=B1 0.000M/s

Jiri
=3D=3D=3D=3D
usermode-count :   79.515 =C2=B1 0.014M/s
syscall-count  :    9.439 =C2=B1 0.006M/s
uprobe-nop     :    1.520 =C2=B1 0.001M/s
uprobe-push    :    1.464 =C2=B1 0.000M/s
uprobe-ret     :    0.640 =C2=B1 0.000M/s
uretprobe-nop  :    0.893 =C2=B1 0.000M/s (+15%)
uretprobe-push :    0.867 =C2=B1 0.000M/s (+14%)
uretprobe-ret  :    0.498 =C2=B1 0.000M/s (+8.5%)

Oleg+Jiri
=3D=3D=3D=3D=3D=3D=3D=3D=3D
usermode-count :   79.471 =C2=B1 0.078M/s
syscall-count  :    9.434 =C2=B1 0.007M/s
uprobe-nop     :    1.516 =C2=B1 0.003M/s
uprobe-push    :    1.463 =C2=B1 0.000M/s
uprobe-ret     :    0.640 =C2=B1 0.001M/s
uretprobe-nop  :    1.020 =C2=B1 0.001M/s (+31%)
uretprobe-push :    0.998 =C2=B1 0.001M/s (+31%)
uretprobe-ret  :    0.537 =C2=B1 0.000M/s (+17%)

So it's 2x of just Jiri's changes, which is a very nice boost! I only
tested on Intel CPU.


>
> jirka
