Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A0395AD2
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161224; cv=none; b=Q0kO8bIfkLH/NsHWEO0055wugt7E8d9qssmv3vnUtSDtKSQeWmrz8YqilGkxATQjw8JE7reMJM+iz0pfs6YQaKeIj4MqP5ISHogBbdwz596VV3AMEKfwOZ8GWhh1Er7Xl/958LOHL3hVqN3SBaLs5BTB0nOH/UVpJGTU3pedwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161224; c=relaxed/simple;
	bh=/JckXfb9SndZmmzw1OvELLCPJaUTORpcaFPbYeyaOQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk3WlPqYHk1m0nayVwFvgeVxcamuI/ipNUJif1obaacDBCmLhdtgmv2G43vKaxyfyfDI1lwMoHmvrqWnDX2QPDEbYL9/5/E2S8O5Xh2qd+ZVHrq92WQ4TmQ8JKnMSrU9mVV7uhQSP+piD3ETnQWwexlfyMKSTn6fVlYnR72/eo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137dd4cc208so460683c88.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 00:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161220; x=1781766020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+LYmH86pisJanuiGKPdqo/WtE+tsI3YAxnIs2VB4+U=;
        b=kAXllKBTxA0ZZpgaG9hD6gj3kKum+W6G9xp6muYTyhpDlbObwVBv85iWJZ7l3OHdWo
         jHAXTrXg0yrK2n2bFINr/wHE7ylXE0KHtxPcOtVCzty7LR82lWQK588qNMPFlb4dip9O
         RGQi2ygWy175k2zcu2AONqVx6PKuMeME8xsLwA9AV249z0dfodTEU65veXByxKizc9qz
         0cujLWx6C0870+s938bwzDQuz+oc9ZiCcyUAFcoOxmkK03Q4yonsrttuu8Eapi7SW9HO
         IYwHGsTDjrzu2K0Q3VLXT2aZ6AXjhY3oE51PlGXNwqlbX3Kpd1rId9aQ/KFnF/++rFeQ
         B9Og==
X-Forwarded-Encrypted: i=1; AFNElJ9tdOJr153q3rfvxMM60P6alO0tzTbEnH9Wz7NaV/J/k0sfi2sAZg/ijOd1VjukHhNSJ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNy6XBwlUVBBTPcPH1bTAONNDL6KFT8Sqirkmltqek56nrGhaU
	PwEcwIoCgoyOWCRwI5hOWq5LQfbjFEw0ZF6n3oHgq/wbpu6HMZ6weYts
X-Gm-Gg: Acq92OH5t1+RhHdOfHODfDqj0c6SSinJ4ubw0bLgiDiLCBuRzH6VnDgPFDuOhA5HBQp
	wsgZoK3QX/2D3frmT3TLnxAjzEASxzAeSxtPA3d9ffafjlL+PcRSdd+OvJGIdIm3MOs54cQIixc
	FxoF9eo51NPJf0zyqDEP58ym9EXsxznpRE2aWfxYA0lW63KL96UmsJvDuiZkrMTRTLtrcvML2jL
	pFjEHiPvFkVOabwQoOKn1NgZD+odTzY6+TWOf168+9qQREzLtcXArFT+VV/jqFbxwGUEMMFbRd5
	uMnNDlrBBhPdApDtvoWptb4Ic4dhtbHnKJFHQB58f/k5rxSwfKMXRWa2xiI33i3hhMBw6RsYYje
	dpbDOmf0xQjETjK2htQq1VbasawI9ZZYO2WpMVSHVGWEEuOeuM7tHmOogKcnB/7ZVnfOZp6c+zX
	lGn0m6b5uEZ8asn7/++XLgJOy3hhdeUISUX4PM4jd32jjl8ZKPIyY=
X-Received: by 2002:a05:701b:4586:20b0:136:4e2c:95a2 with SMTP id a92af1059eb24-13842f0b5c8mr487878c88.0.1781161215471;
        Thu, 11 Jun 2026 00:00:15 -0700 (PDT)
Received: from localhost ([2601:647:4101:bfe0::7ece])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13842fa5f9asm984043c88.8.2026.06.11.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:00:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 00:00:25 -0700
From: Fangrui Song <i@maskray.me>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jens Remus <jremus@linux.ibm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <ibhagatgnu@gmail.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [RESEND][PATCH v2] unwind: Add sframe_(un)register() system calls
Message-ID: <aipWtXVRqNmZY4gr@archer>
References: <20260528151626.4573592d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528151626.4573592d@gandalf.local.home>



On 2026-05-28, Steven Rostedt wrote:
>From: Steven Rostedt <rostedt@goodmis.org>
>
>Add system calls to register and unregister sframes that can be used by
>dynamic linkers to tell the kernel where the sframe section is in memory
>for libraries it loads.
>
>Both system calls take a pointer to a new structure:
>
>  struct sframe_setup {
>	__u64			sframe_start;
>	__u64			sframe_size;
>	__u64			text_start;
>	__u64			text_size;
>  };
>
>and a size of the passed in structure. If the system call needs to be
>extended, then the structure could be changed and the size of that
>structure will tell the kernel that it is the new version. If the kernel
>does not recognize the structure size, it will return -EINVAL.
>
>  sframe_start - The virtual address of the sframe section
>  sframe_size  - The length of the sframe section
>  text_start   - the text section the sframe represents
>  test_size    - the length of the section
>
>If other stack tracing functionality is added, it will require a new
>system call.
>
>The unregister only needs the sframe_start and requires all the rest of
>the fields to be 0. In the future, if more can be done, then user space
>can update the other values and check the return code to see if the kernel
>supports it.
>
>Also added a DEFINE_GUARD() for mmap_write_lock. There was one for
>mmap_read_lock but not for mmap_write_lock.
>
>Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>---
>
>[ Resend with Indu's current email address. ]
>
>Changes since v1: https://patch.msgid.link/20260521183532.7a145c8a@gandalf.local.home
>
>- Use mmap_write_lock() instead of mmap_read_lock() for mutual
>  exclusiveness. (Jens Remus)
>
>- Guard mtree_insert_range() with mmap_write_lock. (Jens Remus)
>
>- Added a guard for mmap_write_lock() similar to the one for mmap_read_lock.
>
>- Have syscall prototype use structure pointer instead of void (Thomas Weißschuh)
>
>- Use __u64 instead of unsigned long for struct members (Thomas Weißschuh)
>
>- Use size_t instead of int for structure size in syscall argument.
> (Thomas Weißschuh)
>
> arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
> arch/arm/tools/syscall.tbl                  |  2 +
> arch/arm64/tools/syscall_32.tbl             |  2 +
> arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
> arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
> arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
> arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
> arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
> arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
> arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
> arch/s390/kernel/syscalls/syscall.tbl       |  3 +
> arch/sh/kernel/syscalls/syscall.tbl         |  2 +
> arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
> arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
> arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
> arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
> include/linux/mmap_lock.h                   |  3 +
> include/linux/syscalls.h                    |  3 +
> include/uapi/asm-generic/unistd.h           |  7 ++-
> include/uapi/linux/sframe.h                 | 12 ++++
> kernel/sys_ni.c                             |  3 +
> kernel/unwind/sframe.c                      | 69 +++++++++++++++++++--
> scripts/syscall.tbl                         |  2 +
> 23 files changed, 126 insertions(+), 6 deletions(-)
> create mode 100644 include/uapi/linux/sframe.h
>
>diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
>index f31b7afffc34..f0639b831f2a 100644
>--- a/arch/alpha/kernel/syscalls/syscall.tbl
>+++ b/arch/alpha/kernel/syscalls/syscall.tbl
>@@ -511,3 +511,5 @@
> 579	common	file_setattr			sys_file_setattr
> 580	common	listns				sys_listns
> 581	common	rseq_slice_yield		sys_rseq_slice_yield
>+582	common	sframe_register			sys_sframe_register
>+583	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
>index 94351e22bfcf..887b242ffb25 100644
>--- a/arch/arm/tools/syscall.tbl
>+++ b/arch/arm/tools/syscall.tbl
>@@ -486,3 +486,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
>index 62d93d88e0fe..c820f1ff718c 100644
>--- a/arch/arm64/tools/syscall_32.tbl
>+++ b/arch/arm64/tools/syscall_32.tbl
>@@ -483,3 +483,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
>index 248934257101..4c7f17f0364b 100644
>--- a/arch/m68k/kernel/syscalls/syscall.tbl
>+++ b/arch/m68k/kernel/syscalls/syscall.tbl
>@@ -471,3 +471,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
>index 223d26303627..e8dc2cc149f4 100644
>--- a/arch/microblaze/kernel/syscalls/syscall.tbl
>+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
>@@ -477,3 +477,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
>index 7430714e2b8f..d0bae05d16af 100644
>--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
>+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
>@@ -410,3 +410,5 @@
> 469	n32	file_setattr			sys_file_setattr
> 470	n32	listns				sys_listns
> 471	n32	rseq_slice_yield		sys_rseq_slice_yield
>+472	n32	sframe_register			sys_sframe_register
>+473	n32	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
>index 630aab9e5425..2e200de6a58c 100644
>--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
>+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
>@@ -386,3 +386,5 @@
> 469	n64	file_setattr			sys_file_setattr
> 470	n64	listns				sys_listns
> 471	n64	rseq_slice_yield		sys_rseq_slice_yield
>+472	n64	sframe_register			sys_sframe_register
>+473	n64	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
>index 128653112284..0e3b82011ae2 100644
>--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
>+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
>@@ -459,3 +459,5 @@
> 469	o32	file_setattr			sys_file_setattr
> 470	o32	listns				sys_listns
> 471	o32	rseq_slice_yield		sys_rseq_slice_yield
>+472	o32	sframe_register			sys_sframe_register
>+473	o32	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
>index c6331dad9461..e0758ef8667d 100644
>--- a/arch/parisc/kernel/syscalls/syscall.tbl
>+++ b/arch/parisc/kernel/syscalls/syscall.tbl
>@@ -470,3 +470,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>index 4fcc7c58a105..eda40c4f4f2f 100644
>--- a/arch/powerpc/kernel/syscalls/syscall.tbl
>+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>@@ -562,3 +562,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	nospu	rseq_slice_yield		sys_rseq_slice_yield
>+472	nospu	sframe_register			sys_sframe_register
>+473	nospu	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
>index 09a7ef04d979..52519e2acdc8 100644
>--- a/arch/s390/kernel/syscalls/syscall.tbl
>+++ b/arch/s390/kernel/syscalls/syscall.tbl
>@@ -398,3 +398,6 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	stacktrace_setup		sys_stacktrace_setup
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
>index 70b315cbe710..62ac7b1b4dd4 100644
>--- a/arch/sh/kernel/syscalls/syscall.tbl
>+++ b/arch/sh/kernel/syscalls/syscall.tbl
>@@ -475,3 +475,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
>index 7e71bf7fcd14..f92273ae608a 100644
>--- a/arch/sparc/kernel/syscalls/syscall.tbl
>+++ b/arch/sparc/kernel/syscalls/syscall.tbl
>@@ -517,3 +517,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
>index f832ebd2d79b..409a50df3b21 100644
>--- a/arch/x86/entry/syscalls/syscall_32.tbl
>+++ b/arch/x86/entry/syscalls/syscall_32.tbl
>@@ -477,3 +477,5 @@
> 469	i386	file_setattr		sys_file_setattr
> 470	i386	listns			sys_listns
> 471	i386	rseq_slice_yield	sys_rseq_slice_yield
>+472	i386	sframe_register		sys_sframe_register
>+473	i386	sframe_unregister	sys_sframe_unregister
>diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>index 524155d655da..9b7c5a449751 100644
>--- a/arch/x86/entry/syscalls/syscall_64.tbl
>+++ b/arch/x86/entry/syscalls/syscall_64.tbl
>@@ -396,6 +396,8 @@
> 469	common	file_setattr		sys_file_setattr
> 470	common	listns			sys_listns
> 471	common	rseq_slice_yield	sys_rseq_slice_yield
>+472	common	sframe_register		sys_sframe_register
>+473	common	sframe_unregister	sys_sframe_unregister
>
> #
> # Due to a historical design error, certain syscalls are numbered differently
>diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
>index a9bca4e484de..037b8040f69d 100644
>--- a/arch/xtensa/kernel/syscalls/syscall.tbl
>+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
>@@ -442,3 +442,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register'		sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
>index 04b8f61ece5d..6650c89a13ab 100644
>--- a/include/linux/mmap_lock.h
>+++ b/include/linux/mmap_lock.h
>@@ -579,6 +579,9 @@ static inline void mmap_write_unlock(struct mm_struct *mm)
> 	up_write(&mm->mmap_lock);
> }
>
>+DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
>+	     mmap_write_lock(_T), mmap_write_unlock(_T))
>+
> static inline void mmap_write_downgrade(struct mm_struct *mm)
> {
> 	__mmap_lock_trace_acquire_returned(mm, false, true);
>diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>index f5639d5ac331..ad3c8d6b6471 100644
>--- a/include/linux/syscalls.h
>+++ b/include/linux/syscalls.h
>@@ -79,6 +79,7 @@ struct mnt_id_req;
> struct ns_id_req;
> struct xattr_args;
> struct file_attr;
>+struct sframe_setup;
>
> #include <linux/types.h>
> #include <linux/aio_abi.h>
>@@ -999,6 +1000,8 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *
> asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
> 				      u32 size, u32 flags);
> asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
>+asmlinkage long sys_sframe_register(struct sframe_setup *data,  size_t size);
>+asmlinkage long sys_sframe_unregister(struct sframe_setup *data, size_t size);
>
> /*
>  * Architecture-specific system calls
>diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
>index a627acc8fb5f..17042d7e5e87 100644
>--- a/include/uapi/asm-generic/unistd.h
>+++ b/include/uapi/asm-generic/unistd.h
>@@ -863,8 +863,13 @@ __SYSCALL(__NR_listns, sys_listns)
> #define __NR_rseq_slice_yield 471
> __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
>
>+#define __NR_sframe_register 472
>+__SYSCALL(__NR_sframe_register, sys_sframe_register)
>+#define __NR_sframe_unregister 473
>+__SYSCALL(__NR_sframe_unregister, sys_sframe_unregister)
>+
> #undef __NR_syscalls
>-#define __NR_syscalls 472
>+#define __NR_syscalls 474
>
> /*
>  * 32 bit systems traditionally used different
>diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.h
>new file mode 100644
>index 000000000000..d3c9f88b024b
>--- /dev/null
>+++ b/include/uapi/linux/sframe.h
>@@ -0,0 +1,12 @@
>+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>+#ifndef _UAPI_LINUX_SFRAME_H
>+#define _UAPI_LINUX_SFRAME_H
>+
>+struct sframe_setup {
>+	__u64			sframe_start;
>+	__u64			sframe_size;
>+	__u64			text_start;
>+	__u64			text_size;
>+};
>+
>+#endif /* _UAPI_LINUX_SFRAME_H */
>diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>index add3032da16f..eca5293f5d40 100644
>--- a/kernel/sys_ni.c
>+++ b/kernel/sys_ni.c
>@@ -394,3 +394,6 @@ COND_SYSCALL(rseq_slice_yield);
>
> COND_SYSCALL(uretprobe);
> COND_SYSCALL(uprobe);
>+
>+COND_SYSCALL(sframe_register);
>+COND_SYSCALL(sframe_unregister);
>diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>index db88d993dff1..84bd762a1080 100644
>--- a/kernel/unwind/sframe.c
>+++ b/kernel/unwind/sframe.c
>@@ -12,8 +12,10 @@
> #include <linux/mm.h>
> #include <linux/string_helpers.h>
> #include <linux/sframe.h>
>+#include <linux/syscalls.h>
> #include <asm/unwind_user_sframe.h>
> #include <linux/unwind_user_types.h>
>+#include <uapi/linux/sframe.h>
>
> #include "sframe.h"
> #include "sframe_debug.h"
>@@ -817,8 +819,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
> 	if (ret)
> 		goto err_free;
>
>-	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end - 1,
>-				 sec, GFP_KERNEL_ACCOUNT);
>+	scoped_guard(mmap_write_lock, mm) {
>+		ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end - 1,
>+					 sec, GFP_KERNEL_ACCOUNT);
>+	}
> 	if (ret) {
> 		dbg_sec("mtree_insert_range failed: text=%lx-%lx\n",
> 			sec->text_start, sec->text_end);
>@@ -842,9 +846,11 @@ static void sframe_free_srcu(struct rcu_head *rcu)
> static int __sframe_remove_section(struct mm_struct *mm,
> 				   struct sframe_section *sec)
> {
>-	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
>-		dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
>-		return -EINVAL;
>+	scoped_guard(mmap_write_lock, mm) {
>+		if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
>+			dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
>+			return -EINVAL;
>+		}
> 	}
>
> 	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
>@@ -936,3 +942,56 @@ void sframe_free_mm(struct mm_struct *mm)
>
> 	mtree_destroy(&mm->sframe_mt);
> }
>+
>+/**
>+ * sys_sframe_register - register an address for user space stacktrace walking.
>+ * @data: Structure of sframe data used to register the sframe section
>+ * @size: The size of the given structure.
>+ *
>+ * This system call is used by dynamic library utilities to inform the kernel
>+ * of meta data that it loaded that can be used by the kernel to know how
>+ * to stack walk the given text locations.
>+ *
>+ * Return: 0 if successful, otherwise a negative error.
>+ */
>+SYSCALL_DEFINE2(sframe_register, struct sframe_setup __user *, data, size_t, size)
>+{
>+	struct sframe_setup sframe;
>+
>+	if (sizeof(sframe) != size)
>+		return -EINVAL;
>+
>+	if (copy_from_user(&sframe, data, size))
>+		return -EFAULT;
>+
>+	return sframe_add_section(sframe.sframe_start,
>+				  sframe.sframe_start + sframe.sframe_size,
>+				  sframe.text_start,
>+				  sframe.text_start + sframe.text_size);
>+}
>+
>+/**
>+ * sys_sframe_unregister - unregister an sframe address
>+ * @data: Structure of sframe data used to register the sframe section
>+ * @size: The size of the given structure.
>+ *
>+ * The data->sframe_start is the only value that is used. The rest must
>+ * be zero.
>+ *
>+ * Return: 0 if successful, otherwise a negative error.
>+ */
>+SYSCALL_DEFINE2(sframe_unregister, struct sframe_setup __user *, data, size_t, size)
>+{
>+	struct sframe_setup sframe;
>+
>+	if (sizeof(sframe) != size)
>+		return -EINVAL;
>+
>+	if (copy_from_user(&sframe, data, size))
>+		return -EFAULT;
>+
>+	if (sframe.sframe_size || sframe.text_start || sframe.text_size)
>+		return -EINVAL;
>+
>+	return sframe_remove_section(sframe.sframe_start);
>+}
>diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
>index 7a42b32b6577..46ec22b50042 100644
>--- a/scripts/syscall.tbl
>+++ b/scripts/syscall.tbl
>@@ -412,3 +412,5 @@
> 469	common	file_setattr			sys_file_setattr
> 470	common	listns				sys_listns
> 471	common	rseq_slice_yield		sys_rseq_slice_yield
>+472	common	sframe_register			sys_sframe_register
>+473	common	sframe_unregister		sys_sframe_unregister
>-- 
>2.53.0
>


Hi Steven,

This is not an objection to deferred userspace unwinding itself -- my
concern is narrower: these syscalls permanently encode the kernel's
commitment to the SFrame format family at exactly the moment the
format's size trajectory is heading the wrong way, and while arguably
superior formats exist.

I raised related size concerns about SFrame's viability for userspace
stack walking earlier:
https://lore.kernel.org/all/3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr/
("Concerns about SFrame viability for userspace stack walking")

SFrame v3 is even larger than v2.

For comparison: Microsoft is currently upstreaming its Windows x64
Unwind V3 implementation to LLVM, which will make a side-by-side reading
of the two formats straightforward. Unwind V3 provides correct
exception-handling unwind -- full prologue replay, SEH handlers,
funclets -- and supports Intel APX. SFrame v3 provides stack tracing
only, no EH, yet comes out larger than .eh_frame. A format revision that
adds capability without adding bulk is demonstrably achievable; SFrame
v3 went the other way.

I understand IBM is doubling down on SFrame for their s390x and ppc64,
but I'm not convinced the size overhead of v3 will make it appealing on
x86-64. I have learned that the person driving their SFrame work at
Google had left and the SFrame at data center effort was being
reevaluated per a toolchain manager.
