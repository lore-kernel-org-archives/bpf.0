Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8A3A1AC
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154783; cv=none; b=QkvZB5WFHTOzPai1erUAULzXsGp+dfaxZzN2QC0bhm3pZzMajWsFP2ZEu+9R2qYHOcuSA+2uI30F3r4SieVDi651UCQFpA0dSDM4iypmEoDl0gGubO2OFFZLcInII3zapYDKFXpcAv6xKYoA4dOpkFSTt6qLqlZCCdahqalcte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154783; c=relaxed/simple;
	bh=W28S6EkM3u06ChHy8efTv5u2wxxoFMabB3kcY4Pr3W0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHo7IK2Ytfbn9JgfvxvSPCczI8JhplRuHPAZIDceH7ZPWGEFsDDm8huurDmarpNMlrWRZ8y3PpxA5XMTFJ3d6lMLrf3qazJIbyadC5/l8jqyYgrlFe4ONMioWP39fMHqRigpsawfqYCUAHkkGJgfT6szhBsuZKtW/CfOsSXCAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K97CRSPA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K97CRSPA"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51381021af1so3704275e87.0
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 03:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710154779; x=1710759579; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fw26Rp+kVSC6QWQUZpAycK3bZlaLwLUI7470fZOQGZI=;
        b=K97CRSPA+WZOs8TiSd/Y1PXFsS56Aj+q2XLG2aITfwML2KATxT5vEfvZ168m05km6v
         3JWhPLv8nlxRhExoH7uLfcJ5qRnZj4zRl9BQ8AjAaaj51XtxmrsjN/VY9tc/eeCzJWQF
         Yklp4vBNCRk3cuSFAGy0joThwMhwnLBkgOb2c5eZYVLZn/ikluLhZzxvssMk+OTIhAR5
         oVrAGecy+QLpWwX+uqfNMinDqtDp8vx3rPCmaSP8FBcC10hLVvPnv39fqZusr2S5g0uy
         SnrxFnNrV0vUAFwfKr+9zuQrkeby0qiVbdxgY/UMVbJ0Yg1cJsa4+U6Oph8nxBeP0AGm
         uaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154779; x=1710759579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw26Rp+kVSC6QWQUZpAycK3bZlaLwLUI7470fZOQGZI=;
        b=MyoEX8piI3DlSXSdRh19Be/CRwcwHb55LbFwS1IuIMTpMx8CfM8VAcUlXpil6mv2WB
         JlFgnPWyxf3XNI0Wons1meu6z57QD+U6nR/uMXf0bsY+UuNpk60J6NCptF9EfjiISaqc
         HkJEG8E4bksqy9m4dIC46/lTC3vzLf47b4csk6i7xuzUKB7ZdNmuLMzecR4Ew3hAjhXD
         bzTvUPTOp6c0Qa7joQu94kRLifRmyRZzUm4rAI6+7FS1c92ejHgeDlZnOUffkIU620qj
         kvcczpSEaSnQju2gW/JcBXTKELBy4ro801jxY2naUrPy89WcxDqDmciKT8EVTQdaHM2e
         2lcw==
X-Forwarded-Encrypted: i=1; AJvYcCXnWCL3KFINyBcCZKrfL+D2YIB53EN3bROYCX9XMnhKA5DnwhliqdXEK8iIuxOZy9PKxd84+2+gf0nTecWSN3VRRA6h
X-Gm-Message-State: AOJu0Yyv6mfNnNLpps8GoGZpYodMEY8o+v7NGUMN7Rru7Y98JuYMjo+p
	ecpCE4wk/MnmKraTmeQg945sBmNTwpPvUfU3mztMsZ42pNJqoV0QIyyX53sl
X-Google-Smtp-Source: AGHT+IFRD+gpG/vo9D6f05wwrQYz66HJLoz/JeYhuY4tCq016eDZ+rdd/m4qQ1+cHcl83ZPnC8Qp7g==
X-Received: by 2002:a05:6512:281e:b0:512:fe1f:d3c1 with SMTP id cf30-20020a056512281e00b00512fe1fd3c1mr5495013lfb.58.1710154778613;
        Mon, 11 Mar 2024 03:59:38 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r13-20020adff10d000000b0033b278cf5fesm6122241wro.102.2024.03.11.03.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 03:59:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Mar 2024 11:59:36 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	yunwei356@gmail.com, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <Ze7kGP5aAYGseRuM@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava>
 <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
 <ZebWqIgABbk8dQXT@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZebWqIgABbk8dQXT@krava>

On Tue, Mar 05, 2024 at 09:24:08AM +0100, Jiri Olsa wrote:
> On Mon, Mar 04, 2024 at 04:55:33PM -0800, Andrii Nakryiko wrote:
> > On Sun, Mar 3, 2024 at 2:20 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Fri, Mar 01, 2024 at 09:26:57AM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Mar 1, 2024 at 9:01 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Mar 1, 2024 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > > > > > On Thu, Feb 29, 2024 at 6:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > > > >
> > > > > > > > One of uprobe pain points is having slow execution that involves
> > > > > > > > two traps in worst case scenario or single trap if the original
> > > > > > > > instruction can be emulated. For return uprobes there's one extra
> > > > > > > > trap on top of that.
> > > > > > > >
> > > > > > > > My current idea on how to make this faster is to follow the optimized
> > > > > > > > kprobes and replace the normal uprobe trap instruction with jump to
> > > > > > > > user space trampoline that:
> > > > > > > >
> > > > > > > >   - executes syscall to call uprobe consumers callbacks
> > > > > > >
> > > > > > > Did you get a chance to measure relative performance of syscall vs
> > > > > > > int3 interrupt handling? If not, do you think you'll be able to get
> > > > > > > some numbers by the time the conference starts? This should inform the
> > > > > > > decision whether it even makes sense to go through all the trouble.
> > > > > >
> > > > > > right, will do that
> > > > >
> > > > > I believe Yusheng measured syscall vs uprobe performance
> > > > > difference during LPC. iirc it was something like 3x.
> > > >
> > > > Do you have a link to slides? Was it actual uprobe vs just some fast
> > > > syscall (not doing BPF program execution) comparison? Or comparing the
> > > > performance of int3 handling vs equivalent syscall handling.
> > > >
> > > > I suspect it's the former, and so probably not that representative.
> > > > I'm curious about the performance of going
> > > > userspace->kernel->userspace through int3 vs syscall (all other things
> > > > being equal).
> > >
> > > I have a simple test [1] comparing:
> > >   - uprobe with 2 traps
> > >   - uprobe with 1 trap
> > >   - syscall executing uprobe
> > >
> > > the syscall takes uprobe address as argument, finds the uprobe and executes
> > > its consumers, which should be comparable to what the trampoline will do
> > >
> > > test does same amount of loops triggering each uprobe type and measures
> > > the time it took
> > >
> > >   # ./test_progs -t uprobe_syscall_bench -v
> > >   bpf_testmod.ko is already unloaded.
> > >   Loading bpf_testmod.ko...
> > >   Successfully loaded bpf_testmod.ko.
> > >   test_bench_1:PASS:uprobe_bench__open_and_load 0 nsec
> > >   test_bench_1:PASS:uprobe_bench__attach 0 nsec
> > >   test_bench_1:PASS:uprobe1_cnt 0 nsec
> > >   test_bench_1:PASS:syscalls_uprobe1_cnt 0 nsec
> > >   test_bench_1:PASS:uprobe2_cnt 0 nsec
> > >   test_bench_1: uprobes (1 trap) in  36.439s
> > >   test_bench_1: uprobes (2 trap) in  91.960s
> > >   test_bench_1: syscalls         in  17.872s
> > >   #395/1   uprobe_syscall_bench/bench_1:OK
> > >   #395     uprobe_syscall_bench:OK
> > >   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > syscall uprobe execution seems to be ~2x faster than 1 trap uprobe
> > > and ~5x faster than 2 traps uprobe
> > >
> > 
> > Thanks for running benchmarks! I quickly looked at the selftest and
> > noticed this:
> > 
> > +/*
> > + * Assuming following prolog:
> > + *
> > + * 6984ac:       55                      push   %rbp
> > + * 6984ad:       48 89 e5                mov    %rsp,%rbp
> > + */
> > +noinline void uprobe2_bench_trigger(void)
> > +{
> > +        asm volatile ("");
> > +}
> > 
> > This actually will be optimized out to just ret in -O2 mode (make
> > RELEASE=1 for selftests):
> > 
> > 00000000005a0ce0 <uprobe2_bench_trigger>:
> >   5a0ce0: c3                            retq
> >   5a0ce1: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
> >   5a0cec: 0f 1f 40 00                   nopl    (%rax)
> > 
> > So be careful with that.
> 
> right, I did not mean for this to be checked in, just wanted to get the
> numbers quickly
> 
> > 
> > Also, I just updated our existing set of uprobe benchmarks (see [0]),
> > do you mind adding your syscall-based one as another one there and
> > running all of them and sharing the numbers with us? Very curious to
> > see both absolute and relative numbers from that benchmark. (and
> > please do build with RELEASE=1)
> > 
> > You should be able to just run benchs/run_bench_uprobes.sh (also don't
> > forget to add your syscall-based benchmark to the list of benchmarks
> > in that shell script).
> 
> yes, saw it and was going to run/compare it.. it's good idea to add
> the syscall one and get all numbers together, will do that
> 
> > 
> > Thank you!
> > 
> > 
> > BTW, while I think patching multiple instructions for syscall-based
> > uprobe is going to be extremely tricky, I think at least u*ret*probe's
> > int3 can be pretty easily optimized away with syscall, given that the
> > kernel controls code generation there. If anything, it will get the
> > uretprobe case a bit closer to the performance of uprobe. Give it some
> > thought.
> 
> hm, right.. the trampoline is there already, but at the moment is global
> and used by all uretprobes.. and int3 code moves userspace (changes rip)
> to the original return address.. maybe we can do that through syscall
> as well

it seems like good idea, I tried change below (use syscall on return
trampoline) and got some speedup:

current:
  base           :   15.817 ± 0.009M/s
  uprobe-nop     :    2.901 ± 0.000M/s
  uprobe-push    :    2.743 ± 0.002M/s
  uprobe-ret     :    1.089 ± 0.001M/s
  uretprobe-nop  :    1.448 ± 0.001M/s
  uretprobe-push :    1.407 ± 0.001M/s
  uretprobe-ret  :    0.792 ± 0.001M/s

with syscall:
  base           :   15.831 ± 0.026M/s
  uprobe-nop     :    2.904 ± 0.001M/s
  uprobe-push    :    2.764 ± 0.002M/s
  uprobe-ret     :    1.082 ± 0.001M/s
  uretprobe-nop  :    1.785 ± 0.000M/s
  uretprobe-push :    1.733 ± 0.001M/s
  uretprobe-ret  :    0.885 ± 0.004M/s

~23% for nop/push (emulated) cases, ~11% for ret (sstep) case

jirka


---
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..fa5f8a058bc2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -383,6 +383,7 @@
 459	common	lsm_get_self_attr	sys_lsm_get_self_attr
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
+462	64	uprobe			sys_uprobe
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6c07f6daaa22..fceef2b4e243 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -12,11 +12,13 @@
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <linux/uaccess.h>
+#include <linux/syscalls.h>
 
 #include <linux/kdebug.h>
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/mmu_context.h>
+#include <asm/syscalls.h>
 
 /* Post-execution fixups. */
 
@@ -308,6 +310,53 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 }
 
 #ifdef CONFIG_X86_64
+
+asm (
+       ".pushsection .rodata\n"
+       ".global uretprobe_syscall_entry\n"
+       "uretprobe_syscall_entry:\n"
+       "push %rax\n"
+       "mov $462, %rax\n"
+       "syscall\n"
+       ".global uretprobe_syscall_end\n"
+       "uretprobe_syscall_end:\n"
+       ".popsection\n"
+);
+
+extern __visible u8 uretprobe_syscall_entry[];
+extern __visible u8 uretprobe_syscall_end[];
+
+uprobe_opcode_t* arch_uprobe_trampoline(unsigned long *psize)
+{
+	*psize = uretprobe_syscall_end - uretprobe_syscall_entry;
+	return uretprobe_syscall_entry;
+}
+
+SYSCALL_DEFINE1(uprobe, unsigned long, cmd)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long ax, err;
+
+	/*
+	 * We get invoked from the trampoline that pushed rax
+	 * value on stack, read and restore the value.
+	 */
+	err = copy_from_user((void*) &ax, (void *) regs->sp, sizeof(ax));
+	WARN_ON_ONCE(err);
+
+	regs->ax = ax;
+	regs->orig_ax = ax;
+
+	/*
+	 * And pop the stack back, because we jump to original
+	 * return value.
+	 */
+	regs->sp = regs->sp + sizeof(regs->sp);
+
+	uprobe_handle_trampoline(regs);
+	return ax;
+}
+
 /*
  * If arch_uprobe->insn doesn't use rip-relative addressing, return
  * immediately.  Otherwise, rewrite the instruction so that it accesses
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77eb9b0e7685..4f7d5b41b718 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -987,6 +987,8 @@ asmlinkage long sys_spu_run(int fd, __u32 __user *unpc,
 asmlinkage long sys_spu_create(const char __user *name,
 		unsigned int flags, umode_t mode, int fd);
 
+asmlinkage long sys_uprobe(unsigned long cmd);
+
 
 /*
  * Deprecated system calls which are still defined in
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..9ef244c8ff19 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -138,6 +138,8 @@ extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern void uprobe_handle_trampoline(struct pt_regs *regs);
+uprobe_opcode_t* arch_uprobe_trampoline(unsigned long *psize);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 75f00965ab15..2702799648e6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+#define __NR_uprobe 462
+__SYSCALL(__NR_uprobe, sys_uprobe)
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 929e98c62965..fefaf4804e1f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1474,10 +1474,19 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
+uprobe_opcode_t* __weak arch_uprobe_trampoline(unsigned long *psize)
+{
+	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+
+	*psize = UPROBE_SWBP_INSN_SIZE;
+	return &insn;
+}
+
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	unsigned long insns_size;
+	uprobe_opcode_t *insns;
 	struct xol_area *area;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
@@ -1502,7 +1511,8 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
 	atomic_set(&area->slot_count, 1);
-	arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SIZE);
+	insns = arch_uprobe_trampoline(&insns_size);
+	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
 		return area;
@@ -2123,7 +2133,7 @@ static struct return_instance *find_next_ret_chain(struct return_instance *ri)
 	return ri;
 }
 
-static void handle_trampoline(struct pt_regs *regs)
+void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
 	struct return_instance *ri, *next;
@@ -2188,7 +2198,7 @@ static void handle_swbp(struct pt_regs *regs)
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == get_trampoline_vaddr())
-		return handle_trampoline(regs);
+		return uprobe_handle_trampoline(regs);
 
 	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
 	if (!uprobe) {
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index faad00cce269..ddc954f28317 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -391,3 +391,5 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+
+COND_SYSCALL(uprobe);
