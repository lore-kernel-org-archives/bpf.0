Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000A3E1231
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336682; cv=pass; b=OCZRo5YVaI0ipyuRvmc1pnpcMU7PwhZRVXqrO8YxMTbv/EWr61MTjy0MI0jKmNKcMlX4X+T8XRyXRLaAgtBaodYrOAocycwwpisHHT8QoRwQf4HSEVU6UbhBl6VAbpiK+SGBl/u84m2d3JLAFADRt8ikra1xVVxSichIff0Pf+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336682; c=relaxed/simple;
	bh=V0AyIuBAvJoYwSEB1n+sM0KY82YDtCldie3vhEDiiIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ejhbipm1cWuOTHnmIemUBrtmEnerR7v9Inp36ZsnlBHe4SODZGSrCduw/6jhWkqqOfegTZpvd5m8Ks3qs8cCAh6e56+AP5wk1ih8/cXFWrQgD9XUgyRoH0Mjyh7eWceFqtj+x6Ksheb4DzK7IgXPBQzdThLxLEffEH1M2NBN9oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWqHT1s1; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWqHT1s1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so2019091a91.3
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 10:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336680; cv=none;
        d=google.com; s=arc-20240605;
        b=BbqQmxPS+5UeFjL/HqWpkMdkBN1YkMM2oKQto/GjqmrLT/XuPKGJKG9pUkWTjMhSUI
         Awzac5a7IvYjkgSQ8ROZuMWRp3wXNbkXbiXBw0AftMJZIoMofNNtS43FndDKRmyJxOsF
         W7i4zCZEOtDeFNSBM4dAEuoHLq1eH+dOED7brJEzZMCnLacWnV8Akfe54ZJEmBlYTjG0
         3XPdc0ivg3A3OZ+5tKZdjeZGrUbEzqw3rwLuuzFmAWsK1GjdXUY+CONXQAGHonbx/8iE
         /NzCWqE8yRWMYBuCAaMUIa/JRJ83qYf3yWksHlysu8rhabX+x3SX2857vocCH8s02u7v
         Qm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p9cunrKbhPBEEg6xrZRc0ad56PnSPNo22kcqhPhkQOY=;
        fh=qEKqbHGP5tiaxI9iFAUBKdCmMefB3HXVQADjrnWhCIo=;
        b=JsmTST0/5+XZAKGT7GqMZxnUMJNF7tLQlw4sw1cMPKTbs3Q+4gXVaSaLJZUHqsccWn
         IxFekIl4M7SZ59vQG4NLmuprKXy9r1yJVE1wdxaY/WUo2b5iDOeSsDZRpL1V4Qi14Tae
         OHBfsYm4VROxbnqXO6hnCIfflIy/4cllYW3IEeiiWGORiyWOawxkTzZPJEIswvvOGtvV
         Z8m6/0KtZ6wF2sNpI/suWyXgtU30BbC96FpFdmWpgOffvnPI74AsV/U2PsmmgPLaRpuw
         sucVtIhf8ajwjHkU/0TFlLPkO2SPYukyQBmpcSiMkgmwZeJ+tsKuMvpc7uRBHUa+PPxT
         +Wfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336680; x=1780941480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9cunrKbhPBEEg6xrZRc0ad56PnSPNo22kcqhPhkQOY=;
        b=SWqHT1s1xG1I8rnYMZ9jGassWeVYA2354+MVVoellgAu4vXEopaXS1zU3nmb5P4Bns
         4PhfXFmCWqb4mrd4yewHJxaZxwqO++fLi30hOeBgXJpjpf/XlC1dbE+bDVzF2tt3/qGb
         qZFTnKcRcvJY3ddsS96an+8dZRJdPvrsJoLhmIL6EbFL0Nfh2cjuWEHK4a810b3q9PNj
         NM60OTAnWGlau+aNd6ftxroI0oVbYz/BiYH2AzHCFMLkKKia9tM1VNDh6VwmYnLDEBAJ
         CoDhyJ60pS4qCGs6WJ1nem9HjGPCfbXes6NKtW//8+qxj+p4e+Mandkm+ams/91Y/w8V
         Bn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336680; x=1780941480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p9cunrKbhPBEEg6xrZRc0ad56PnSPNo22kcqhPhkQOY=;
        b=lRV8fTOTE97ZiegUGIRqT7IRewxsUlm9g7DZch2leoRufDnw60BIb/RVmupeXGecYo
         6FsEDuf2gQwJWCQMi/NM+6UvQLVGWMJswGNBTwaui5QepS0PBtM6QlkdbkN/ng92aTrF
         1JaODaG+sRV/o5Ln8P3vJ4kXHeK2q9gUoulVQVm53E1bQtYrxnklryIIrFtOlxvyROL0
         MlZZPc1Idx2qHih/5PnIeafADrTx0qUQMXrQKkptJSs/w6TLYLq6X33ADHW+pdsmEsmo
         5JIsYRd+21ls58F5vcB4PNYVDPElDtPt43FkyOafL5G5qWJOJ1Klu+D0PDdQhJPGcgs/
         WiMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eTCltjmsFhlFkqRSQHhvg7eiCc7oNDH6SyZOHYc7pBaGPOI8SGU44OhrRk6uPHsfQp44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7B39E+rAcz1m9dDhSVJlQ7NPJdeSjvG4caalnoKbkX57VC6ft
	a2637lyi8IZtztovSdAvHUWlwVuhJhLy4iqpBkTBkLJ082768br0SllqJcNjMX/8IqUqFIdQi/J
	IoE3UDKyUlBFkrP0H81JCyBYuy5kFy5c=
X-Gm-Gg: Acq92OENtd73VFnUKd8k2TSTL8V/k5X0ozOBllhCAIuArsCgX4LfL2KVmH4Vs00MIpU
	dRZqww7ezLjCzS2QYK28s0an5TT/P8AfxxqZmydJAGf8E+9K8rH3SzXeFQsE3JsisLhk9ZQ4kul
	jtAj41vcWuKCbjdppP04MHTET9MuhZN2JnVslVHkChEWh8C5MO/5WDI2zxCpOr/F3hdtK2DToW6
	MCgsEBb+UaZBJnjN3kSUrVmJPwObuyY8gxdGKWbN7XALJu9wgbBKKf1Aw2nD0GTQVnTQZMqH9mN
	LR9xdKBsfk3scK5DgB5Um2a4/W3HruFcLQ==
X-Received: by 2002:a17:90b:57e7:b0:36d:70c8:3a1 with SMTP id
 98e67ed59e1d1-36d70c8067cmr10789372a91.13.1780336680330; Mon, 01 Jun 2026
 10:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528151023.00f5ec4e@gandalf.local.home> <CAEf4BzZh4qyPiMbpZPeVGx+HFNjBjAHTsNOx5wE7RWidM-iphA@mail.gmail.com>
 <20260528222051.60b38433@fedora>
In-Reply-To: <20260528222051.60b38433@fedora>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jun 2026 10:57:46 -0700
X-Gm-Features: AVHnY4IgzIUtaFJjFD6GEDfSr9bqs8NyIuJyZe8rVOr1umdD7w4Drge0QkU3Wlk
Message-ID: <CAEf4BzYu+eRC9Q3msOOVPeqtoi++P_gCsPqVS6=aC+dvAW40Qw@mail.gmail.com>
Subject: Re: [PATCH v2] unwind: Add sframe_(un)register() system calls
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, 
	Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 7:20=E2=80=AFPM Steven Rostedt <rostedt@kernel.org>=
 wrote:
>
> On Thu, 28 May 2026 16:01:06 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> >
> > [...]
> >
> > >   * Architecture-specific system calls
> > > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-gen=
eric/unistd.h
> > > index a627acc8fb5f..17042d7e5e87 100644
> > > --- a/include/uapi/asm-generic/unistd.h
> > > +++ b/include/uapi/asm-generic/unistd.h
> > > @@ -863,8 +863,13 @@ __SYSCALL(__NR_listns, sys_listns)
> > >  #define __NR_rseq_slice_yield 471
> > >  __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
> > >
> > > +#define __NR_sframe_register 472
> > > +__SYSCALL(__NR_sframe_register, sys_sframe_register)
> > > +#define __NR_sframe_unregister 473
> > > +__SYSCALL(__NR_sframe_unregister, sys_sframe_unregister)
> > > +
> > >  #undef __NR_syscalls
> > > -#define __NR_syscalls 472
> > > +#define __NR_syscalls 474
> > >
> > >  /*
> > >   * 32 bit systems traditionally used different
> > > diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.=
h
> > > new file mode 100644
> > > index 000000000000..d3c9f88b024b
> > > --- /dev/null
> > > +++ b/include/uapi/linux/sframe.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > > +#ifndef _UAPI_LINUX_SFRAME_H
> > > +#define _UAPI_LINUX_SFRAME_H
> > > +
> > > +struct sframe_setup {
> >
> > I'd add `u64 flags;` field for easier and nicer extensibility. Check
> > in the kernel that it is set to zero, future kernels will allow some
> > of the bits to be set.
>
> That sounds reasonable.
>
> >
> > And I still think that prctl() instead of a separate sframe-specific
> > syscall is the way to go. I see no reason for sframe-specific set of
> > syscalls just to set a bit of extra metadata for the entire process.
> > That seems to be the job of prctl().
>
> I personally do not have a preference. I've just heard a lot from
> others where they want to avoid extending an ioctl() like system call
> or even create a new multiplexer syscall.
>
> If we can get a consensus of using prctl() or adding a separate system
> call, I'll go with whatever that is.

prctl() is an already existing multiplexing syscall used to provide
some per-process (of per-thread sometimes, it seems) hints and
options. Please consider sending prctl() extension, please CC me, and
let's see what arguments do people have against extending an already
existing syscall.

>
> >
> > > +       __u64                   sframe_start;
> > > +       __u64                   sframe_size;
> > > +       __u64                   text_start;
> > > +       __u64                   text_size;
> > > +};
> > > +
> >
> > [...]
> >
> > > +
> > > +/**
> > > + * sys_sframe_register - register an address for user space stacktra=
ce walking.
> > > + * @data: Structure of sframe data used to register the sframe secti=
on
> > > + * @size: The size of the given structure.
> > > + *
> > > + * This system call is used by dynamic library utilities to inform t=
he kernel
> > > + * of meta data that it loaded that can be used by the kernel to kno=
w how
> > > + * to stack walk the given text locations.
> > > + *
> > > + * Return: 0 if successful, otherwise a negative error.
> > > + */
> > > +SYSCALL_DEFINE2(sframe_register, struct sframe_setup __user *, data,=
 size_t, size)
> > > +{
> > > +       struct sframe_setup sframe;
> > > +
> > > +       if (sizeof(sframe) !=3D size)
> > > +               return -EINVAL;
> >
> > This seems overly aggressive. It seems like the pattern is to allow
> > sizes both smaller and bigger:
> >   - if user-provided size is smaller than what kernel knows about,
> > treat missing fields as zeroes
>
> Well, that could work with unregister, but for register that isn't
> quite useful, as all fields should be filled (well, if we add flags,
> that may not be 100% true).
>

This is a question of API design. If newly added fields are optional
by default, this works great. And even if you are adding some fields
that in the future will be mandatory (or it could be mandatory based
on flags), then it's super easy to error out if they are not set.
We've been doing this for years now in bpf() syscall and it works
pretty well overall, while also keeping user-space (libbpf, for
instance) side *much* simpler. I don't want to imagine bpf() syscall
which in each kernel version enforces a different size of bpf_attr
union...

> >   - if user-provided size is bigger, then check that space after
> > fields that kernel recognizes are all zeroes.
>
> That is dangerous. A zero with greater size could mean something. If
> the size is greater than expected it should simply fail and let user
> space call it again with the older version.
>

Could, but it shouldn't if we extend API reasonably. And if it so
happens that zero will be meaningful, then you add a new flag that has
to be set if that field is present. This is a solved problem.
Requiring user space to use differently-sized structs for different
kernel versions is much-much worse.

> >
> > This allows extensibility without having to change user space code all
> > the time. Old code will provide smaller struct without new (presumably
> > optional) fields, while newer code can use newer and larger struct
> > size, but as long as it clears extra fields old kernel will be fine
> > with that.
>
> The old size will always work, thus old code will always continue to
> work. If we extend the system call, then it must handle both the older
> size as well as the newer size. User space would not need to change. It
> would only change if it wanted to use a new feature, and if it wants to
> work with older kernels it would need to try the bigger size first and
> if that fails, it knows the kernel doesn't support that new feature and
> then user space can figure out what to do. Either use the old system
> call or abort.

See above, many added features are typically optional (e.g., imagine
some extra bits of information that goes along with currently existing
mandatory sframe data). And it's easy to code user space code that can
automatically and gracefully "downgrade" by detecting that kernel
doesn't support some feature and thus just not setting the field,
leaving it zero. But you won't have to track what should be the right
size of the struct which in your API headers is already larger because
you compiled something on newer kernel headers.

Believe me, this is the right way to go with this kind of extendable binary=
 API.

>
> -- Steve
>
> >
> > > +
> > > +       if (copy_from_user(&sframe, data, size))
> > > +               return -EFAULT;
> > > +
> > > +       return sframe_add_section(sframe.sframe_start,
> > > +                                 sframe.sframe_start + sframe.sframe=
_size,
> > > +                                 sframe.text_start,
> > > +                                 sframe.text_start + sframe.text_siz=
e);
> > > +}
> > > +
> >
> > [...]
>
