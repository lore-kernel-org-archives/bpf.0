Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C83264C7;
	Thu, 28 May 2026 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995754; cv=none; b=EozAkD/dLA7EjlNjBW+xvIsDgLvbGEyKbz652T4MypPwsCEeSqHbwPzFPPnNkLlf2aEBA8tYPj1fSC8Lt71vh6rm8iKG9hL/pbgKhbSA8LXobslB+9rQFlasr/rL9aTAQmTROHerNgSH+UkQ59Pxo9e8QtwcJwdl/wJHpiyBsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995754; c=relaxed/simple;
	bh=NLPnLrO/IC1awmKVWQagnSjbb7Jy2da+dkucEkF8i34=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KqEsJLVgGKxlIe/AK3BjbRxnsEMG5P8NHIwftuBBvgplGcd/LwjWGJinZg6H7mcm3eGvNwvp7Ri+SFh7oM3j94Xab6DakPwHwyDWDIdikjCqltzJiOhMIlrLEhcEzuSM9/1ChXt2UzIswLlHN9Ky0M8/En791K1I9au1qLRenJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ7Slyvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ7Slyvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36F71F000E9;
	Thu, 28 May 2026 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779995753;
	bh=Fr7nSz+aMp6yRnLa5d8RVpaBRc6sa5uAVAIA3owfSfo=;
	h=Date:From:To:Cc:Subject;
	b=iJ7Slyvzm5jR69t4C22azkmq9GVCOzsljBEa/7BFkKIjDAWtxZKaUuKW0cA8POS0z
	 UF7MnVgqkbpha004BR6r0pyppYSf6/YTvN37h5uVNqRPn9Xq8LvM0+joGf7j3U4wg9
	 j3TihmnQPSWIFJ+tEka3PFHoTH9qXJO4G90HpNCy40/BFShWsgR8ZPowAayxQoVlc1
	 P004GA493kiOjmKhLC+HknXo5aDFuaSe6G3CvAZlT9yj6QR1ekvP8zJSxXFycQIIZS
	 o9+LRddgaEc2JI1sLtjbbj8GtR4hhGn/zTli+/qZI7n1p2S7ITICY1R4FUXDvhe0mR
	 W0Kuv71mNc2PQ==
Date: Thu, 28 May 2026 15:16:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel 
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers 
 <mathieu.desnoyers@efficios.com>, Jens Remus <jremus@linux.ibm.com>, Josh 
 Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo 
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <ibhagatgnu@gmail.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds 
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
Subject: [RESEND][PATCH v2] unwind: Add sframe_(un)register() system calls
Message-ID: <20260528151626.4573592d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Steven Rostedt <rostedt@goodmis.org>

Add system calls to register and unregister sframes that can be used by
dynamic linkers to tell the kernel where the sframe section is in memory
for libraries it loads.

Both system calls take a pointer to a new structure:

  struct sframe_setup {
	__u64			sframe_start;
	__u64			sframe_size;
	__u64			text_start;
	__u64			text_size;
  };

and a size of the passed in structure. If the system call needs to be
extended, then the structure could be changed and the size of that
structure will tell the kernel that it is the new version. If the kernel
does not recognize the structure size, it will return -EINVAL.

  sframe_start - The virtual address of the sframe section
  sframe_size  - The length of the sframe section
  text_start   - the text section the sframe represents
  test_size    - the length of the section

If other stack tracing functionality is added, it will require a new
system call.

The unregister only needs the sframe_start and requires all the rest of
the fields to be 0. In the future, if more can be done, then user space
can update the other values and check the return code to see if the kernel
supports it.

Also added a DEFINE_GUARD() for mmap_write_lock. There was one for
mmap_read_lock but not for mmap_write_lock.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---

[ Resend with Indu's current email address. ]

Changes since v1: https://patch.msgid.link/20260521183532.7a145c8a@gandalf.=
local.home

- Use mmap_write_lock() instead of mmap_read_lock() for mutual
  exclusiveness. (Jens Remus)

- Guard mtree_insert_range() with mmap_write_lock. (Jens Remus)

- Added a guard for mmap_write_lock() similar to the one for mmap_read_lock.

- Have syscall prototype use structure pointer instead of void (Thomas Wei=
=C3=9Fschuh)

- Use __u64 instead of unsigned long for struct members (Thomas Wei=C3=9Fsc=
huh)

- Use size_t instead of int for structure size in syscall argument.
 (Thomas Wei=C3=9Fschuh)

 arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
 arch/arm/tools/syscall.tbl                  |  2 +
 arch/arm64/tools/syscall_32.tbl             |  2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
 arch/s390/kernel/syscalls/syscall.tbl       |  3 +
 arch/sh/kernel/syscalls/syscall.tbl         |  2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
 include/linux/mmap_lock.h                   |  3 +
 include/linux/syscalls.h                    |  3 +
 include/uapi/asm-generic/unistd.h           |  7 ++-
 include/uapi/linux/sframe.h                 | 12 ++++
 kernel/sys_ni.c                             |  3 +
 kernel/unwind/sframe.c                      | 69 +++++++++++++++++++--
 scripts/syscall.tbl                         |  2 +
 23 files changed, 126 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/sframe.h

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/sys=
calls/syscall.tbl
index f31b7afffc34..f0639b831f2a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -511,3 +511,5 @@
 579	common	file_setattr			sys_file_setattr
 580	common	listns				sys_listns
 581	common	rseq_slice_yield		sys_rseq_slice_yield
+582	common	sframe_register			sys_sframe_register
+583	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 94351e22bfcf..887b242ffb25 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -486,3 +486,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.=
tbl
index 62d93d88e0fe..c820f1ff718c 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -483,3 +483,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/sysca=
lls/syscall.tbl
index 248934257101..4c7f17f0364b 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -471,3 +471,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/=
kernel/syscalls/syscall.tbl
index 223d26303627..e8dc2cc149f4 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -477,3 +477,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/s=
yscalls/syscall_n32.tbl
index 7430714e2b8f..d0bae05d16af 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -410,3 +410,5 @@
 469	n32	file_setattr			sys_file_setattr
 470	n32	listns				sys_listns
 471	n32	rseq_slice_yield		sys_rseq_slice_yield
+472	n32	sframe_register			sys_sframe_register
+473	n32	sframe_unregister		sys_sframe_unregister
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/s=
yscalls/syscall_n64.tbl
index 630aab9e5425..2e200de6a58c 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -386,3 +386,5 @@
 469	n64	file_setattr			sys_file_setattr
 470	n64	listns				sys_listns
 471	n64	rseq_slice_yield		sys_rseq_slice_yield
+472	n64	sframe_register			sys_sframe_register
+473	n64	sframe_unregister		sys_sframe_unregister
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/s=
yscalls/syscall_o32.tbl
index 128653112284..0e3b82011ae2 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -459,3 +459,5 @@
 469	o32	file_setattr			sys_file_setattr
 470	o32	listns				sys_listns
 471	o32	rseq_slice_yield		sys_rseq_slice_yield
+472	o32	sframe_register			sys_sframe_register
+473	o32	sframe_unregister		sys_sframe_unregister
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/s=
yscalls/syscall.tbl
index c6331dad9461..e0758ef8667d 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel=
/syscalls/syscall.tbl
index 4fcc7c58a105..eda40c4f4f2f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -562,3 +562,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	nospu	rseq_slice_yield		sys_rseq_slice_yield
+472	nospu	sframe_register			sys_sframe_register
+473	nospu	sframe_unregister		sys_sframe_unregister
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/sysca=
lls/syscall.tbl
index 09a7ef04d979..52519e2acdc8 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -398,3 +398,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/=
syscall.tbl
index 70b315cbe710..62ac7b1b4dd4 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -475,3 +475,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/sys=
calls/syscall.tbl
index 7e71bf7fcd14..f92273ae608a 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscal=
ls/syscall_32.tbl
index f832ebd2d79b..409a50df3b21 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -477,3 +477,5 @@
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
 471	i386	rseq_slice_yield	sys_rseq_slice_yield
+472	i386	sframe_register		sys_sframe_register
+473	i386	sframe_unregister	sys_sframe_unregister
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscal=
ls/syscall_64.tbl
index 524155d655da..9b7c5a449751 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -396,6 +396,8 @@
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
 471	common	rseq_slice_yield	sys_rseq_slice_yield
+472	common	sframe_register		sys_sframe_register
+473	common	sframe_unregister	sys_sframe_unregister
=20
 #
 # Due to a historical design error, certain syscalls are numbered differen=
tly
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/s=
yscalls/syscall.tbl
index a9bca4e484de..037b8040f69d 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -442,3 +442,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register'		sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 04b8f61ece5d..6650c89a13ab 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -579,6 +579,9 @@ static inline void mmap_write_unlock(struct mm_struct *=
mm)
 	up_write(&mm->mmap_lock);
 }
=20
+DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
+	     mmap_write_lock(_T), mmap_write_unlock(_T))
+
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 	__mmap_lock_trace_acquire_returned(mm, false, true);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f5639d5ac331..ad3c8d6b6471 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -79,6 +79,7 @@ struct mnt_id_req;
 struct ns_id_req;
 struct xattr_args;
 struct file_attr;
+struct sframe_setup;
=20
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -999,6 +1000,8 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int att=
r, struct lsm_ctx __user *
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __=
user *ctx,
 				      u32 size, u32 flags);
 asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u3=
2 flags);
+asmlinkage long sys_sframe_register(struct sframe_setup *data,  size_t siz=
e);
+asmlinkage long sys_sframe_unregister(struct sframe_setup *data, size_t si=
ze);
=20
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/u=
nistd.h
index a627acc8fb5f..17042d7e5e87 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,13 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
=20
+#define __NR_sframe_register 472
+__SYSCALL(__NR_sframe_register, sys_sframe_register)
+#define __NR_sframe_unregister 473
+__SYSCALL(__NR_sframe_unregister, sys_sframe_unregister)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 474
=20
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.h
new file mode 100644
index 000000000000..d3c9f88b024b
--- /dev/null
+++ b/include/uapi/linux/sframe.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_SFRAME_H
+#define _UAPI_LINUX_SFRAME_H
+
+struct sframe_setup {
+	__u64			sframe_start;
+	__u64			sframe_size;
+	__u64			text_start;
+	__u64			text_size;
+};
+
+#endif /* _UAPI_LINUX_SFRAME_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index add3032da16f..eca5293f5d40 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -394,3 +394,6 @@ COND_SYSCALL(rseq_slice_yield);
=20
 COND_SYSCALL(uretprobe);
 COND_SYSCALL(uprobe);
+
+COND_SYSCALL(sframe_register);
+COND_SYSCALL(sframe_unregister);
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index db88d993dff1..84bd762a1080 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -12,8 +12,10 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
+#include <linux/syscalls.h>
 #include <asm/unwind_user_sframe.h>
 #include <linux/unwind_user_types.h>
+#include <uapi/linux/sframe.h>
=20
 #include "sframe.h"
 #include "sframe_debug.h"
@@ -817,8 +819,10 @@ int sframe_add_section(unsigned long sframe_start, uns=
igned long sframe_end,
 	if (ret)
 		goto err_free;
=20
-	ret =3D mtree_insert_range(sframe_mt, sec->text_start, sec->text_end - 1,
-				 sec, GFP_KERNEL_ACCOUNT);
+	scoped_guard(mmap_write_lock, mm) {
+		ret =3D mtree_insert_range(sframe_mt, sec->text_start, sec->text_end - 1,
+					 sec, GFP_KERNEL_ACCOUNT);
+	}
 	if (ret) {
 		dbg_sec("mtree_insert_range failed: text=3D%lx-%lx\n",
 			sec->text_start, sec->text_end);
@@ -842,9 +846,11 @@ static void sframe_free_srcu(struct rcu_head *rcu)
 static int __sframe_remove_section(struct mm_struct *mm,
 				   struct sframe_section *sec)
 {
-	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
-		dbg_sec("mtree_erase failed: text=3D%lx\n", sec->text_start);
-		return -EINVAL;
+	scoped_guard(mmap_write_lock, mm) {
+		if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
+			dbg_sec("mtree_erase failed: text=3D%lx\n", sec->text_start);
+			return -EINVAL;
+		}
 	}
=20
 	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
@@ -936,3 +942,56 @@ void sframe_free_mm(struct mm_struct *mm)
=20
 	mtree_destroy(&mm->sframe_mt);
 }
+
+/**
+ * sys_sframe_register - register an address for user space stacktrace wal=
king.
+ * @data: Structure of sframe data used to register the sframe section
+ * @size: The size of the given structure.
+ *
+ * This system call is used by dynamic library utilities to inform the ker=
nel
+ * of meta data that it loaded that can be used by the kernel to know how
+ * to stack walk the given text locations.
+ *
+ * Return: 0 if successful, otherwise a negative error.
+ */
+SYSCALL_DEFINE2(sframe_register, struct sframe_setup __user *, data, size_=
t, size)
+{
+	struct sframe_setup sframe;
+
+	if (sizeof(sframe) !=3D size)
+		return -EINVAL;
+
+	if (copy_from_user(&sframe, data, size))
+		return -EFAULT;
+
+	return sframe_add_section(sframe.sframe_start,
+				  sframe.sframe_start + sframe.sframe_size,
+				  sframe.text_start,
+				  sframe.text_start + sframe.text_size);
+}
+
+/**
+ * sys_sframe_unregister - unregister an sframe address
+ * @data: Structure of sframe data used to register the sframe section
+ * @size: The size of the given structure.
+ *
+ * The data->sframe_start is the only value that is used. The rest must
+ * be zero.
+ *
+ * Return: 0 if successful, otherwise a negative error.
+ */
+SYSCALL_DEFINE2(sframe_unregister, struct sframe_setup __user *, data, siz=
e_t, size)
+{
+	struct sframe_setup sframe;
+
+	if (sizeof(sframe) !=3D size)
+		return -EINVAL;
+
+	if (copy_from_user(&sframe, data, size))
+		return -EFAULT;
+
+	if (sframe.sframe_size || sframe.text_start || sframe.text_size)
+		return -EINVAL;
+
+	return sframe_remove_section(sframe.sframe_start);
+}
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..46ec22b50042 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	sframe_register			sys_sframe_register
+473	common	sframe_unregister		sys_sframe_unregister
--=20
2.53.0

