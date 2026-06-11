Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5E2D5932
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148793; cv=none; b=m22YyH70xED0mqPTe4XGAVfAefbil80u42YV8UVtwfpuuRFEK9x8va/4IXV/p3Kk1xz9SSyhsfg57//+HoowGjN9T3A6MekF7LdfK6SyUXwRlHte0HIK1NQEVkiQ1Bbh9sbmVp4UacW4o730h658I3wxAiSYF1bQBWE6E3kTLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148793; c=relaxed/simple;
	bh=toeZvYdfErHe376NZ3GtBH9qfIBD7CllINz2dXO7tag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/cScMzWJRoeYqscd9YYpILHVqDA1sBUaK3WBSb9v32nre87FPM4/YoisVRHzso9rXg0FhgmH4xANASnpq2Wf0qkHSKQnmGQK5hkq4X2iNIE8f4sFFsosPkPySq8SJupBrJN+1eTVDX5A6uUu41bsVV/PPPRrR/t1VN9b1CpCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm7H0nRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm7H0nRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069491F00899
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 03:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781148791;
	bh=A5QT4L3kGSrTYOelY5QfhP36GHrZByoeuqy37PkoBAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fm7H0nRUpUjW968kvoft6NmPFytubnMTvf3u+EQK/ZzQz3w3R64uwvw72eFBT+VGc
	 5cOkz1bZtKMJnWal2oXRBrXu0E7HV7IQM3dEuKnsO4LI2OqJfvA2jmLKIgi+2OQmVY
	 f7acH6JIH7UuooQcvQT2Ytsp84kLPlGWLtAdj6FWDF7w6F6fM0tscC5+ZBXFZPpOQG
	 xXjHEWLWHTXHqPBHM9tbEQnWg7RyLjXLjArJkjqX+BCYXzx/LU6GxphCWS9hG5NXc1
	 ulCi6IC/8gyawN/MIHRdPN54Y2QgA4TVzLk5VBo98yiN2xcyPhTtALglhbb4cAZSm4
	 xF9fEWwj2HfGg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so5946082a12.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 20:33:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/vJ+AcsayyPU9RbG0kifV9kM+yHZtnwv1lUpzdiZtjYRCUYMjoHkKZh5elpDqERbJdWnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+X4N78inhrhJCDDrLH4oB192Ky4dMCQ3aMoC6CLWlr+9QUoS
	64UgJVrxE/tW31VskvbMyLK7XECv80zQilDyGyor0nYZE+cMO+BSqDKvFm7lGe+JECxiaJ1dxO8
	gE3Yb2ZxLfePfKeKXiG7s4ry+GFJMBbA=
X-Received: by 2002:a05:6402:2b89:b0:68c:33e9:bf71 with SMTP id
 4fb4d7f45d1cf-6930e29274fmr314249a12.11.1781148789721; Wed, 10 Jun 2026
 20:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611015327.12108-2-yangtiezhu@loongson.cn>
 <20260611020820.1F18B1F00893@smtp.kernel.org> <b22f3a7f-4d23-a3be-73de-a30be745b444@loongson.cn>
In-Reply-To: <b22f3a7f-4d23-a3be-73de-a30be745b444@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 11 Jun 2026 11:33:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6tJWPrHoCf9XX+8Qz7mtqP6pQkb-i_zRV7NDP3VSRcOw@mail.gmail.com>
X-Gm-Features: AVVi8CcvDFw4yc37I4_xewvSabhvl81xBQ3Cv86VtZ3tMyFKIU1s7e2HiNfRbEk
Message-ID: <CAAhV-H6tJWPrHoCf9XX+8Qz7mtqP6pQkb-i_zRV7NDP3VSRcOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 11:23=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> On 2026/6/11 =E4=B8=8A=E5=8D=8810:08, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [High] In 32-bit kernels, the `$tp` (current task pointer) holds a bi=
ased pointer during `__switch_to()`, exposing the kernel to memory corrupti=
on or crashes if a synchronous exception occurs.
> > - [High] Missing `try_get_task_stack()` in `show_stacktrace()` allows a=
 use-after-free read of kernel stack memory, causing an information leak.
> > --
> >
> > commit a68f9b2fc34ae06149cefb44ef7146643d52f85f
> > Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> >
> > LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
> >
> > Select THREAD_INFO_IN_TASK for LoongArch to move thread_info off the
> > stack into task_struct. Initialize a per-CPU cpu_tasks variable, update
> > assembly paths to restore the $tp register from it, and adjust stack
> > accesses and unwinding to account for the new configuration.
> >
> >> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/sw=
itch.S
> >> index f377d8f5c51a6..d6e0d05d6fd39 100644
> >> --- a/arch/loongarch/kernel/switch.S
> >> +++ b/arch/loongarch/kernel/switch.S
> >
> > [ ... ]
> >
> >> @@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
> >>      LONG_SPTR       t8, t7, 0
> >>   #endif
> >>
> >> -    move    tp, a2
> >> +    move            tp, a1
> >>      cpu_restore_nonscratch a1
> >>
> >> -    li.w            t0, _THREAD_SIZE
> >> -    PTR_ADD         t0, t0, tp
> >> +    LONG_LPTR       t0, a1, (TASK_STACK - TASK_STRUCT_OFFSET)
> >> +    PTR_LI          t1, _THREAD_SIZE
> >> +    PTR_ADD         t0, t0, t1
> >>      set_saved_sp    t0, t1, t2
> >>
> >>      LONG_LPTR       t1, a1, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)
> >> @@ -45,6 +46,7 @@ SYM_FUNC_START(__switch_to)
> >>
> >>   #ifdef CONFIG_32BIT
> >>      PTR_ADDI        a0, a0, -TASK_STRUCT_OFFSET
> >> +    PTR_ADDI        tp, tp, -TASK_STRUCT_OFFSET
> >
> > [Severity: High]
> > Could the delayed removal of the bias from the thread pointer cause
> > issues if a synchronous exception occurs?
> >
> > For 32-bit kernels, a1 is biased by TASK_STRUCT_OFFSET at the start
> > of __switch_to(). The code copies this biased pointer directly into tp
> > and only removes the bias at the end of the function.
> >
> > While local interrupts are disabled during this window, synchronous
> > exceptions such as hardware data watchpoints might still trigger. If
> > do_watch() executes during this window, it would use the biased tp
> > (pointing to next_task + 2000), potentially causing out-of-bounds
> > memory accesses or kernel panics.
>
> I used "PTR_ADDI        tp, a1, -TASK_STRUCT_OFFSET" rather than
> "move           tp, a1" before sending v2, but Huacai suggested
> the current code.
>
> @Huacai, what is your opinion?
As I said before, even if you use "PTR_ADDI        tp, a1,
-TASK_STRUCT_OFFSET", it is impossible to handle exceptions in
__switch_to().

It is a type of "double fault" if exceptions really happen, "double
fault" means to die. So just keep it.

Huacai

>
>
> >>   #endif
> >>      jr      ra
> >>   SYM_FUNC_END(__switch_to)
> >
> >> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/tra=
ps.c
> >> index 5d49b742e3bf6..7e4206da4876b 100644
> >> --- a/arch/loongarch/kernel/traps.c
> >> +++ b/arch/loongarch/kernel/traps.c
> >> @@ -90,6 +90,9 @@ static void show_backtrace(struct task_struct *task,=
 const struct pt_regs *regs,
> >>      if (!task)
> >>              task =3D current;
> >>
> >> +    if (!try_get_task_stack(task))
> >> +            return;
> >> +
> >
> > [Severity: High]
> > Is there a similar use-after-free risk in show_stacktrace() when
> > reading from the stack pointer?
> >
> > While try_get_task_stack() correctly protects show_backtrace(),
> > show_stacktrace() appears to read directly from the task's stack
> > pointer via __get_addr() without acquiring a reference.
> >
> > With THREAD_INFO_IN_TASK enabled, the stack can be freed before the
> > task_struct. If show_stacktrace() is called on an exiting task
> > (for example, via SysRq-T iterating over all tasks), could it read
> > from a freed and reallocated stack, leaking memory contents?
> >
>
> I will do the following changes:
>
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.=
c
> index 7e4206da4876..776523747ea3 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -90,9 +90,6 @@ static void show_backtrace(struct task_struct *task,
> const struct pt_regs *regs,
>          if (!task)
>                  task =3D current;
>
> -       if (!try_get_task_stack(task))
> -               return;
> -
>          printk("%sCall Trace:", loglvl);
>          for (unwind_start(&state, task, pregs);
>                !unwind_done(&state); unwind_next_frame(&state)) {
> @@ -100,8 +97,6 @@ static void show_backtrace(struct task_struct *task,
> const struct pt_regs *regs,
>                  print_ip_sym(loglvl, addr);
>          }
>          printk("%s\n", loglvl);
> -
> -       put_task_stack(task);
>   }
>
>   static void show_stacktrace(struct task_struct *task,
> @@ -112,6 +107,12 @@ static void show_stacktrace(struct task_struct *task=
,
>          unsigned long stackdata;
>          unsigned long *sp =3D (unsigned long *)regs->regs[3];
>
> +       if (!task)
> +               task =3D current;
> +
> +       if (!try_get_task_stack(task))
> +               return;
> +
>          printk("%sStack :", loglvl);
>          i =3D 0;
>          while ((unsigned long) sp & (PAGE_SIZE - 1)) {
> @@ -134,6 +135,8 @@ static void show_stacktrace(struct task_struct *task,
>          }
>          pr_cont("\n");
>          show_backtrace(task, regs, loglvl, user);
> +
> +       put_task_stack(task);
>   }
>
>   void show_stack(struct task_struct *task, unsigned long *sp, const
> char *loglvl)
>
> Thanks,
> Tiezhu
>
