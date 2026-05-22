Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA74389DEC;
	Fri, 22 May 2026 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448714; cv=none; b=db8+xwI9QboAN201UKy+YesSX0kbm6LYIxWISa0eHVoc0/nZMbOlFxLZmYGM2dXOIMII6r/Z47rN6aTcO3KfFm7TUPCQD8l2rX+RzLsRe3p/XuUyjYiepY3C2qVfLy1CZgjHjvTb1gDlEjQo3PqKp4nCGc6IOdWVH8yTYlYUfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448714; c=relaxed/simple;
	bh=ZvyUF/msBmFYhJSPVEJvo3csGbH17ivxprq74R09usc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inOB6RmNJ0bic0oKbVi8z/8BUGXTg+x4hVbf/AdLgD8ldmm7/BRu2oZUDW/Wbv9sNvwba2XsfjPy2GF1P0fyACFohgYBu8iTNiZwAMO0x9SLMBOtqd6//l78nrliCZT6h2idANHS2ia0z1EVxX49MUwoEj0SDsozMeU8gATS5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfOFPCIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfOFPCIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED50F1F000E9;
	Fri, 22 May 2026 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779448712;
	bh=r9fETLkcgjj3y2NVaHNr533D3/dfvmWbfEYNBFzpUA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JfOFPCIy9Hkc2JJ8UhDQafPqjwM3L0SleEStz+2XWsV41n4Ir6qe480iWPTSIzJYc
	 RpjXwQUX2SLjfOAihhkmV3Ojhk2I8drlzUQ/JY+bI6fBsV1HCrciWi/1LgqkE8CBfa
	 tIQYeExxNus9Pot/RWUpgTv6n+5Y1R0jYLmiv1QYX8XaGhdoHnobWURxQuGZG2oPWZ
	 F9OcMv2rtj81Q1JLXf6jtigh7Fp2MWr3PKBRkRjm7pXdWsirHOnJ085v/aIJdz8tvP
	 Xzf5O8KELy5IAxhozTZfg/Zzy6YYiQ9jJvkbEk0/TqbglXs5cFi0NlquFyn5gbGepE
	 sAUNHIfu2WJpg==
Date: Fri, 22 May 2026 07:18:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook
 <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James
 <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH] unwind: Add sframe_(un)register() system calls
Message-ID: <20260522071851.6a121c00@gandalf.local.home>
In-Reply-To: <d82ea328-758e-4e41-a58e-46f3137feca7@linux.ibm.com>
References: <20260521183532.7a145c8a@gandalf.local.home>
	<d82ea328-758e-4e41-a58e-46f3137feca7@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 11:43:06 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> On 5/22/2026 12:35 AM, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Add system calls to register and unregister sframes that can be used by
> > dynamic linkers to tell the kernel where the sframe section is in memory
> > for libraries it loads.  
> 
> Why two separate system calls?  Can't that be one single stacktracectl?
> Could they at least be non-sframe specific, e.g. stracktrace_register
> and stracktrace_unregister, so that if one would implement e.g. unwind
> user dwarf/eh_frame in the future one could pass ehframe_start and
> ehframe_end in addition to sframe_start and sframe_end?

Talking with everyone at LSF/MM/BPF the consensus was to avoid an ioctl
like system call. Everyone hates them. They told me that a system call
should do one thing. They wanted a separate system call to register and to
unregister.

Note this also helps to see what the user is doing via monitoring via
ftrace, strace, and security wise via LSMs and seccomp.

> 
> > 
> > Both system calls take a pointer to a new structure:
> > 
> >   struct sframe_setup {
> > 	unsigned long		sframe_start;
> > 	unsigned long		sframe_size;
> > 	unsigned long		text_start;
> > 	unsigned long		text_size;
> >   };
> > 
> > and a size of the passed in structure. If the system call needs to be
> > extended, then the structure could be changed and the size of that
> > structure will tell the kernel that it is the new version. If the kernel
> > does not recognize the structure size, it will return -EINVAL.
> > 
> >   sframe_start - The virtual address of the sframe section
> >   sframe_size  - The length of the sframe section
> >   text_start   - the text section the sframe represents
> >   test_size    - the length of the section
> > 
> > If other stack tracing functionality is added, it will require a new
> > system call.
> > 
> > The unregister only needs the sframe_start and requires all the rest of
> > the fields to be 0. In the future, if more can be done, then user space
> > can update the other values and check the return code to see if the kernel
> > supports it.
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> > 
> > Based on top of Jens patches here:
> > 
> >   https://lore.kernel.org/linux-trace-kernel/20260520154004.3845823-1-jremus@linux.ibm.com/
> > 
> > [ Note, I tested this with the same program from the RFC patch ]
> > 
> > Changes from RFC: https://patch.msgid.link/20260429114355.6c712e6a@gandalf.local.home
> > 
> > - Remove the ioctl() like system call for a unique system call for each
> >   functionality. Right now there's two functionalities:
> >    1. register sframe section
> >    2. unregister sframe sections
> > 
> > - Added taking a lock around the mtree logic in __sframe_remove_section()
> >   as Sashiko mentioned that there could be races from user space
> >   registering and unregistering sframe sections at the same time.  
> 
> Doesn't sframe_add_section() then also need likewise?

Ah, I saw the lock grabbed on the vma lookup. It should also be done for the
mtree_insert_range(). Thanks, will fix.

> 
> > 
> > - Removed [RFC] from subject as I believe this is more likely the way
> >   this system call will be done.  
> 
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h  
> 
> > @@ -999,6 +999,8 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *
> >  asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
> >  				      u32 size, u32 flags);
> >  asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
> > +asmlinkage long sys_sframe_register(void *data, unsigned int size);
> > +asmlinkage long sys_sframe_unregister(void *data, unsigned int size);
> >  
> >  /*
> >   * Architecture-specific system calls  
> 
> 
> > diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.h  
> 
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_SFRAME_H
> > +#define _UAPI_LINUX_SFRAME_H
> > +
> > +struct sframe_setup {
> > +	unsigned long		sframe_start;
> > +	unsigned long		sframe_size;
> > +	unsigned long		text_start;
> > +	unsigned long		text_size;
> > +};
> > +
> > +#endif /* _UAPI_LINUX_SFRAME_H */  
> 
> > diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c  
> 
> > @@ -842,9 +844,11 @@ static void sframe_free_srcu(struct rcu_head *rcu)
> >  static int __sframe_remove_section(struct mm_struct *mm,
> >  				   struct sframe_section *sec)
> >  {
> > -	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> > -		dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
> > -		return -EINVAL;
> > +	scoped_guard(mmap_read_lock, mm) {  
> 
> Why is a read lock sufficient? Doesn't that allow multiple readers?
> How does that prevent a concurrent modification of the mm->sframe_mt?

That was a cut and paste error. I meant to change it to a write lock, but
got distracted :-p Thanks, will fix.

> 
> > +		if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> > +			dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
> > +			return -EINVAL;
> > +		}  
> 
> Is (or why not) likewise required in sframe_add_section() for the
> mtree_insert_range()?
> 
> Wasn't the reported issue that while mt_for_each() in
> sframe_remove_section() there could be concurrent mtree_erase() in
> __sframe_remove_section() followed by mtree_insert_range() in
> sframe_add_section(), so that the mt_for_each() could get confused?

I'll take a closer look. But let me fix the obvious bugs first.

-- Steve

> 
> >  	}
> >  
> >  	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
> > @@ -936,3 +940,56 @@ void sframe_free_mm(struct mm_struct *mm)
> >  
> >  	mtree_destroy(&mm->sframe_mt);
> >  }
