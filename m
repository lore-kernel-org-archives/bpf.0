Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0779ED
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710810681; cv=none; b=VEFzbBeRtzVmdZZy2j4GBKq/Ew/6CazbTYzWbCBuJuoj5Sq8X93FsQQql7M9knwVNBjvIaUdLL7iKuyWawTcujbkMLrFOUF0D7SuAQm6LDK5JPUZoz2LtdP6QcBc3BUB5DQ8jDhbcVou6ZGrG8S8RV1OUuJSS7s8tsEHEiiM0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710810681; c=relaxed/simple;
	bh=alvrNomkq3/Kj00uW6H6F+UI5EAVxdyRbULkiQERQ3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m80DHiGgUlPymHGCkIzg+UR19ZJCCmYkh2jexnZf2t15+/Vrnd0WMQWG0P1mdcmNyhkLqt1P9iOJQFnhC3GbPEeDgfDAnMklVlGr/ftrjKtTrzTLtH/wqvykAJ68/2b/S6bxXhRYT5BFEv2zoq/HO8icUFjVkk9brgdu9vx07cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXt6mfCI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXt6mfCI"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso3353493a91.3
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 18:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710810679; x=1711415479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq2mydvp6darxTWP0pomUmeseVD5gRyQ5UUWy7EnL2A=;
        b=HXt6mfCIv6NZuZryHxBr3xp4bFVGq9kvVhjc/VUMeXLRoTUMQt/BtsSDtWwDWNCHUT
         5SvRyE7v9kJg1J4anOvPcLOo9HlMZzeqvKHfBbTSWWzkdX08grz6Xrg0y/+7CovElP4O
         PoRhtBGROPKz9iRzdH6hVKhIZNIt9cZlBCuSoV4Fd/aPqLsLfKxkSdg3QV1LgrnpMN5o
         WLeke/YsP5lHtGXHRff/75IeSJdJOsZMDUGz7qPIvBKon8pPxYLc/pt4GXrbj7AZMkaV
         kI+uw8Zqm5/4Rp0yQrwybGxccyqXLOqsdGoOPWsQcjy7DkXfqWgebBMjKmVOzy0OPulv
         nAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710810679; x=1711415479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq2mydvp6darxTWP0pomUmeseVD5gRyQ5UUWy7EnL2A=;
        b=BL5NkHumvnG9oOLeiDCjj7/E6lPCqtsIvhTgCvUNxBgTT2C7Dvtf/p6ssO6nSnKrqx
         8pbOmsSg4fvgij43o5ypHDjBNPB8HG7KGa5C1fwc8Ik0/4lB3x0HiOl6imEMd1AO7mn+
         75PVz34NRYjY4nxdQ8iLYE7it9wh+/wk9V6b8ciLnXOOvvymLE2s9dBqjI5PaVySNEeK
         Xp0usH6Xqa+cqk4TzTdRc+TyA0dfW55nAerEenAXvCXXL1s1/9glgH1RjuhqhwnyMJtu
         ydEGlsZbNazC3SLQN1p9GpUdSaBqxav2KpmskfWFW3dH0WQfjPVGVl1n4O4uqj19ZbQ3
         4d2w==
X-Forwarded-Encrypted: i=1; AJvYcCXEDB1AjJCHJdrJFgkk9R0FC+YVxHwOb5+PL1J0RcqAX7en7quRZ48Vay5BnRjiO3NPP7KLsLS4FNT4DShZuJQyCPaj
X-Gm-Message-State: AOJu0Yxa+OKqBvMWTaxGY0GWYGBT1H5ueJMi5/JzWeE8krNnggFPxyt0
	raX/6Y9rUMLZHgNDxSebuqAKi0wGkKjGwMQ21Ikhgj+0TS5ugivpEqJ76Kw0lUHSKMMnuGRaxFb
	9/cDPzNmC7d0qyJmbceruXQY2iKs=
X-Google-Smtp-Source: AGHT+IFf3BXIKFAN7tRqUvNOjU+CMvi6Sy1SXuboizA/6RM956S0yfoNUWhWp2u+UFglpeNd/jDtpS9WRd4XIxOjqIc=
X-Received: by 2002:a17:90a:f3c5:b0:29d:e75b:e73a with SMTP id
 ha5-20020a17090af3c500b0029de75be73amr1120543pjb.49.1710810678998; Mon, 18
 Mar 2024 18:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318093139.293497-1-jolsa@kernel.org> <20240318093139.293497-2-jolsa@kernel.org>
In-Reply-To: <20240318093139.293497-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Mar 2024 18:11:06 -0700
Message-ID: <CAEf4BzaKDz-2Tavkb+Uu3zugZHcfVLqO-09F=bEJkWFre747eg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] uprobe: Add uretprobe syscall to speed
 up return probe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:31=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uretprobe syscall instead of trap to speed up return probe.
>
> At the moment the uretprobe setup/path is:
>
>   - install entry uprobe
>
>   - when the uprobe is hit overwrite probed function's return address on =
stack
>     with address of the trampoline that contains breakpoint instruction
>
>   - the breakpoint trap code handles the uretprobe consumers execution an=
d
>     jumps back to original return address
>
> This patch changes the above trampoline's breakpoint instruction to new
> ureprobe syscall call. This syscall does exactly the same job as the trap
> with some extra work:
>
>   - syscall trampoline must save original value for rax/r11/rcx registers
>     on stack - rax is set to syscall number and r11/rcx are changed and
>     used by syscall instruction
>
>   - the syscall code reads the original values of those registers and res=
tore
>     those values in task's pt_regs area
>
> Even with the extra registers handling code the having uretprobes handled
> by syscalls shows speed improvement.
>
>   On Intel (11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz)
>
>   current:
>
>     base           :   15.173 =C2=B1 0.052M/s
>     uprobe-nop     :    2.797 =C2=B1 0.090M/s
>     uprobe-push    :    2.580 =C2=B1 0.007M/s
>     uprobe-ret     :    1.001 =C2=B1 0.003M/s
>     uretprobe-nop  :    1.373 =C2=B1 0.002M/s
>     uretprobe-push :    1.346 =C2=B1 0.002M/s
>     uretprobe-ret  :    0.747 =C2=B1 0.001M/s
>
>   with the fix:
>
>     base           :   15.704 =C2=B1 0.076M/s
>     uprobe-nop     :    2.841 =C2=B1 0.008M/s
>     uprobe-push    :    2.666 =C2=B1 0.029M/s
>     uprobe-ret     :    1.037 =C2=B1 0.008M/s
>     uretprobe-nop  :    1.718 =C2=B1 0.010M/s  < ~25% speed up
>     uretprobe-push :    1.658 =C2=B1 0.008M/s  < ~23% speed up
>     uretprobe-ret  :    0.853 =C2=B1 0.004M/s  < ~14% speed up
>
>   On Amd (AMD Ryzen 7 5700U)
>
>   current:
>
>     base           :    5.702 =C2=B1 0.003M/s
>     uprobe-nop     :    1.505 =C2=B1 0.011M/s
>     uprobe-push    :    1.388 =C2=B1 0.008M/s
>     uprobe-ret     :    0.825 =C2=B1 0.001M/s
>     uretprobe-nop  :    0.782 =C2=B1 0.001M/s
>     uretprobe-push :    0.750 =C2=B1 0.001M/s
>     uretprobe-ret  :    0.544 =C2=B1 0.001M/s
>
>   with the fix:
>
>     base           :    5.669 =C2=B1 0.004M/s
>     uprobe-nop     :    1.539 =C2=B1 0.001M/s
>     uprobe-push    :    1.385 =C2=B1 0.003M/s
>     uprobe-ret     :    0.819 =C2=B1 0.001M/s
>     uretprobe-nop  :    0.889 =C2=B1 0.001M/s < ~13% speed up
>     uretprobe-push :    0.846 =C2=B1 0.001M/s < ~12% speed up
>     uretprobe-ret  :    0.594 =C2=B1 0.000M/s <  ~9% speed up
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  arch/x86/kernel/uprobes.c              | 48 ++++++++++++++++++++++++++
>  include/linux/syscalls.h               |  2 ++
>  include/linux/uprobes.h                |  2 ++
>  include/uapi/asm-generic/unistd.h      |  5 ++-
>  kernel/events/uprobes.c                | 18 +++++++---
>  kernel/sys_ni.c                        |  2 ++
>  7 files changed, 73 insertions(+), 5 deletions(-)
>

LGTM, but see some questions and nits below:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index 7e8d46f4147f..af0a33ab06ee 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -383,6 +383,7 @@
>  459    common  lsm_get_self_attr       sys_lsm_get_self_attr
>  460    common  lsm_set_self_attr       sys_lsm_set_self_attr
>  461    common  lsm_list_modules        sys_lsm_list_modules
> +462    64      uretprobe               sys_uretprobe
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differ=
ently
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 6c07f6daaa22..069371e86180 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -12,6 +12,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/uprobes.h>
>  #include <linux/uaccess.h>
> +#include <linux/syscalls.h>
>
>  #include <linux/kdebug.h>
>  #include <asm/processor.h>
> @@ -308,6 +309,53 @@ static int uprobe_init_insn(struct arch_uprobe *aupr=
obe, struct insn *insn, bool
>  }
>
>  #ifdef CONFIG_X86_64
> +
> +asm (
> +       ".pushsection .rodata\n"
> +       ".global uretprobe_syscall_entry\n"
> +       "uretprobe_syscall_entry:\n"
> +       "pushq %rax\n"
> +       "pushq %rcx\n"
> +       "pushq %r11\n"
> +       "movq $462, %rax\n"

nit: is it possible to avoid hardcoding 462 here? Can we use
__NR_uretprobe instead?

> +       "syscall\n"

oh, btw, do we need to save flags register as well or it's handled
somehow? I think according to manual syscall instruction does
something to rflags register. So do we need pushfq before syscall?

> +       ".global uretprobe_syscall_end\n"
> +       "uretprobe_syscall_end:\n"
> +       ".popsection\n"
> +);
> +
> +extern u8 uretprobe_syscall_entry[];
> +extern u8 uretprobe_syscall_end[];
> +
> +void *arch_uprobe_trampoline(unsigned long *psize)
> +{
> +       *psize =3D uretprobe_syscall_end - uretprobe_syscall_entry;
> +       return uretprobe_syscall_entry;
> +}
> +
> +SYSCALL_DEFINE0(uretprobe)
> +{
> +       struct pt_regs *regs =3D task_pt_regs(current);
> +       unsigned long sregs[3], err;
> +
> +       /*
> +        * We set rax and syscall itself changes rcx and r11, so the sysc=
all
> +        * trampoline saves their original values on stack. We need to re=
ad
> +        * them and set original register values and fix the rsp pointer =
back.
> +        */
> +       err =3D copy_from_user((void *) &sregs, (void *) regs->sp, sizeof=
(sregs));
> +       WARN_ON_ONCE(err);
> +
> +       regs->r11 =3D sregs[0];
> +       regs->cx =3D sregs[1];
> +       regs->ax =3D sregs[2];
> +       regs->orig_ax =3D -1;
> +       regs->sp +=3D sizeof(sregs);
> +
> +       uprobe_handle_trampoline(regs);

probably worth leaving a comment that uprobe_handle_trampoline() is
rewriting userspace RIP and so syscall "returns" to the original
caller.

> +       return regs->ax;

and this is making sure that caller function gets the correct function
return value, right? It's all a bit magical, so worth leaving a
comment here, IMO.

> +}
> +
>  /*
>   * If arch_uprobe->insn doesn't use rip-relative addressing, return
>   * immediately.  Otherwise, rewrite the instruction so that it accesses
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 77eb9b0e7685..db150794f89d 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -972,6 +972,8 @@ asmlinkage long sys_lsm_list_modules(u64 *ids, size_t=
 *size, u32 flags);
>  /* x86 */
>  asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on=
);
>
> +asmlinkage long sys_uretprobe(void);
> +
>  /* pciconfig: alpha, arm, arm64, ia64, sparc */
>  asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
>                                 unsigned long off, unsigned long len,
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f46e0ca0169c..a490146ad89d 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -138,6 +138,8 @@ extern bool arch_uretprobe_is_alive(struct return_ins=
tance *ret, enum rp_check c
>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *=
regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr=
,
>                                          void *src, unsigned long len);
> +extern void uprobe_handle_trampoline(struct pt_regs *regs);
> +extern void *arch_uprobe_trampoline(unsigned long *psize);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 75f00965ab15..8a747cd1d735 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_a=
ttr)
>  #define __NR_lsm_list_modules 461
>  __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>
> +#define __NR_uretprobe 462
> +__SYSCALL(__NR_uretprobe, sys_uretprobe)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 462
> +#define __NR_syscalls 463
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 929e98c62965..90395b16bde0 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1474,11 +1474,20 @@ static int xol_add_vma(struct mm_struct *mm, stru=
ct xol_area *area)
>         return ret;
>  }
>
> +void * __weak arch_uprobe_trampoline(unsigned long *psize)
> +{
> +       static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
> +
> +       *psize =3D UPROBE_SWBP_INSN_SIZE;
> +       return &insn;
> +}
> +
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>         struct mm_struct *mm =3D current->mm;
> -       uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
> +       unsigned long insns_size;
>         struct xol_area *area;
> +       void *insns;
>
>         area =3D kmalloc(sizeof(*area), GFP_KERNEL);
>         if (unlikely(!area))
> @@ -1502,7 +1511,8 @@ static struct xol_area *__create_xol_area(unsigned =
long vaddr)
>         /* Reserve the 1st slot for get_trampoline_vaddr() */
>         set_bit(0, area->bitmap);
>         atomic_set(&area->slot_count, 1);
> -       arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_=
SIZE);
> +       insns =3D arch_uprobe_trampoline(&insns_size);
> +       arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
>
>         if (!xol_add_vma(mm, area))
>                 return area;
> @@ -2123,7 +2133,7 @@ static struct return_instance *find_next_ret_chain(=
struct return_instance *ri)
>         return ri;
>  }
>
> -static void handle_trampoline(struct pt_regs *regs)
> +void uprobe_handle_trampoline(struct pt_regs *regs)
>  {
>         struct uprobe_task *utask;
>         struct return_instance *ri, *next;
> @@ -2188,7 +2198,7 @@ static void handle_swbp(struct pt_regs *regs)
>
>         bp_vaddr =3D uprobe_get_swbp_addr(regs);
>         if (bp_vaddr =3D=3D get_trampoline_vaddr())
> -               return handle_trampoline(regs);
> +               return uprobe_handle_trampoline(regs);
>
>         uprobe =3D find_active_uprobe(bp_vaddr, &is_swbp);
>         if (!uprobe) {
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index faad00cce269..be6195e0d078 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -391,3 +391,5 @@ COND_SYSCALL(setuid16);
>
>  /* restartable sequence */
>  COND_SYSCALL(rseq);
> +
> +COND_SYSCALL(uretprobe);
> --
> 2.44.0
>
