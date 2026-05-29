Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628A264FBD;
	Fri, 29 May 2026 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021258; cv=none; b=E3uwSZOuSqTm+ALz7NOhT5clvnuHflk3KkfAck4K0H2nif0+9cBBFPO+5sAkoSRip2YrQl6OV3TXR/dOc5rXbuCUrpBAdPw4TukTOkTrBjGF8W9qF4q5M1Ds+Zn9qVfwiiY0OXrZMXEFMmzUDsJ6FO3AL9wpkmlf+U2O0Ehp72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021258; c=relaxed/simple;
	bh=YdKWiJWPjar5twOk9oCjF33ZIbNQ87vMs5IzvlIDW34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3pSaNYDJjM7gaRA0Jy45UPe0v8qRR3XZvpyqmFDVqRuYHNlvLKT+jy+m754jLQy1PsXkcQHlrzcj9X79n/IM01cD+0TdJL9vVUwF8f7KzsMh4mDVsnBzNuGpvvSXKLE3vLrf9EnlGHgf45XNqcQgkmeTUCFtBplBiNnUqEWmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjhw6aYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjhw6aYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60B81F000E9;
	Fri, 29 May 2026 02:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780021257;
	bh=qAwYm7WzV+b4bL5HL2NSiFVi+HU/CKmigHmc3OJDjcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cjhw6aYizdU2KxFFG4gZmByc780zkm6wvSDfS77XEB2KsY/bKw7P2wD5KsOMjdd/7
	 YxnpvXI20o9iYk+ngjuWMEgJh/bNRjEwDXXY9K3z7dSy7Lgf+m5UsMeK1FILk95kEe
	 W6/L1DbJh0f+w3xzf0mrorKfdZA3VAktn/QiFL9ErktpGwLXP6eVJYLlzSJmoeF33o
	 AHOMFvBaOow/QoIvftktLRREk4gpDlW6WDkRRBS0R5Y1AbW7UDea+FYfNxjG1SXTDa
	 emFfYS6FiDF0QJgUpWpCoRqMuimTED4hOgNjR3y447Wb43TRkblpkqYiDUlDMZgQTS
	 xysvyoYwBCe9Q==
Date: Thu, 28 May 2026 22:20:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, "Carlos
 O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Subject: Re: [PATCH v2] unwind: Add sframe_(un)register() system calls
Message-ID: <20260528222051.60b38433@fedora>
In-Reply-To: <CAEf4BzZh4qyPiMbpZPeVGx+HFNjBjAHTsNOx5wE7RWidM-iphA@mail.gmail.com>
References: <20260528151023.00f5ec4e@gandalf.local.home>
	<CAEf4BzZh4qyPiMbpZPeVGx+HFNjBjAHTsNOx5wE7RWidM-iphA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 16:01:06 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> 
> [...]
> 
> >   * Architecture-specific system calls
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index a627acc8fb5f..17042d7e5e87 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -863,8 +863,13 @@ __SYSCALL(__NR_listns, sys_listns)
> >  #define __NR_rseq_slice_yield 471
> >  __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
> >
> > +#define __NR_sframe_register 472
> > +__SYSCALL(__NR_sframe_register, sys_sframe_register)
> > +#define __NR_sframe_unregister 473
> > +__SYSCALL(__NR_sframe_unregister, sys_sframe_unregister)
> > +
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 472
> > +#define __NR_syscalls 474
> >
> >  /*
> >   * 32 bit systems traditionally used different
> > diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.h
> > new file mode 100644
> > index 000000000000..d3c9f88b024b
> > --- /dev/null
> > +++ b/include/uapi/linux/sframe.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_SFRAME_H
> > +#define _UAPI_LINUX_SFRAME_H
> > +
> > +struct sframe_setup {  
> 
> I'd add `u64 flags;` field for easier and nicer extensibility. Check
> in the kernel that it is set to zero, future kernels will allow some
> of the bits to be set.

That sounds reasonable.

> 
> And I still think that prctl() instead of a separate sframe-specific
> syscall is the way to go. I see no reason for sframe-specific set of
> syscalls just to set a bit of extra metadata for the entire process.
> That seems to be the job of prctl().

I personally do not have a preference. I've just heard a lot from
others where they want to avoid extending an ioctl() like system call
or even create a new multiplexer syscall.

If we can get a consensus of using prctl() or adding a separate system
call, I'll go with whatever that is.

> 
> > +       __u64                   sframe_start;
> > +       __u64                   sframe_size;
> > +       __u64                   text_start;
> > +       __u64                   text_size;
> > +};
> > +  
> 
> [...]
> 
> > +
> > +/**
> > + * sys_sframe_register - register an address for user space stacktrace walking.
> > + * @data: Structure of sframe data used to register the sframe section
> > + * @size: The size of the given structure.
> > + *
> > + * This system call is used by dynamic library utilities to inform the kernel
> > + * of meta data that it loaded that can be used by the kernel to know how
> > + * to stack walk the given text locations.
> > + *
> > + * Return: 0 if successful, otherwise a negative error.
> > + */
> > +SYSCALL_DEFINE2(sframe_register, struct sframe_setup __user *, data, size_t, size)
> > +{
> > +       struct sframe_setup sframe;
> > +
> > +       if (sizeof(sframe) != size)
> > +               return -EINVAL;  
> 
> This seems overly aggressive. It seems like the pattern is to allow
> sizes both smaller and bigger:
>   - if user-provided size is smaller than what kernel knows about,
> treat missing fields as zeroes

Well, that could work with unregister, but for register that isn't
quite useful, as all fields should be filled (well, if we add flags,
that may not be 100% true).

>   - if user-provided size is bigger, then check that space after
> fields that kernel recognizes are all zeroes.

That is dangerous. A zero with greater size could mean something. If
the size is greater than expected it should simply fail and let user
space call it again with the older version.

> 
> This allows extensibility without having to change user space code all
> the time. Old code will provide smaller struct without new (presumably
> optional) fields, while newer code can use newer and larger struct
> size, but as long as it clears extra fields old kernel will be fine
> with that.

The old size will always work, thus old code will always continue to
work. If we extend the system call, then it must handle both the older
size as well as the newer size. User space would not need to change. It
would only change if it wanted to use a new feature, and if it wants to
work with older kernels it would need to try the bigger size first and
if that fails, it knows the kernel doesn't support that new feature and
then user space can figure out what to do. Either use the old system
call or abort.

-- Steve

> 
> > +
> > +       if (copy_from_user(&sframe, data, size))
> > +               return -EFAULT;
> > +
> > +       return sframe_add_section(sframe.sframe_start,
> > +                                 sframe.sframe_start + sframe.sframe_size,
> > +                                 sframe.text_start,
> > +                                 sframe.text_start + sframe.text_size);
> > +}
> > +  
> 
> [...]

