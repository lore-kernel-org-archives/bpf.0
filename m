Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5843C1977;
	Wed, 23 Sep 2026 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142085; cv=none; b=pRs6hQKa6VWid9C/csApg4I+EIsQ4IAXb8il/izCsTzl/m1CejNwxtpXtgl2qeQn/cQNMDnwfu2THLK6HRq7UMzrim8/3XfoP5PohKUvikpC05+Uk0/7iayDOPCVRXsWJ/sidfHWP6Id6VY8YK+XsJKoNWR53ToaD5KQ8C3ZJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142085; c=relaxed/simple;
	bh=Ojy5qHrjikKKwR93jbWNyZrhvbt0Jp+kI1q/xVRg37I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4l0R4Kks6GaV3ba5dOHrEdoBjocRnOCcOVAvje9JyV4iSndcMKP6Gu/oT8DRi7JaTgcqZ/1vkOWj+n4rPyNnJAkSkN0ld9nyLYqqB33JjjonU3Oeza8dfju8GTO1b5Pv5Y+AypADCtWZwS7hpcj9zMjC+X0++BlkpAIOsYXhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MbM9kgi0; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MbM9kgi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790142083; x=1821678083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=usAUkm2oNPIPlWlGTUyS8j3XcpVsC1Gdc0Kkt71uYak=;
  b=MbM9kgi0E5Gh5t9XkygXGDFAQmlz2GJhUjkHz/N6UDrwbeC34Ttapd+U
   ewPSYbx1SpumyJr4VvmgxJ28lKNDD+GBCMjKI9UVfOpk6S+GoTU2jHb20
   i45Nte1T73xlDUPHzaIAETz+8EfaZLJRIKLa8BX/2AEmn+ycEou8J/vXj
   CNF5UfZ1YeJwMIFlVPbzGaby7V+JUGlLAklVTbEvpIp773yc80KPunN+F
   pfDnZWZzx9NM+pEezITTPjuwLTMvgKFLxjd6r6c5lAQ2cRIV1He+4FP3v
   DGw9G2mbMvlpcRv0WrNU3MyuB/BGbeuIeFQNOaQLbbnAEZGraUc64owWD
   Q==;
X-CSE-ConnectionGUID: Fi1O6+OPSgaMM6ONJ4F+Hg==
X-CSE-MsgGUID: nrxdIa+MQm6Fcrsm3xloQA==
X-IronPort-AV: E=Sophos;i="6.27,117,1787011200"; 
   d="scan'208";a="29398036"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:41:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:25629]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.120:2525] with esmtp (Farcaster)
 id 36533df6-7c9e-4377-a345-731bd5588139; Wed, 23 Sep 2026 05:41:23 +0000 (UTC)
X-Farcaster-Flow-ID: 36533df6-7c9e-4377-a345-731bd5588139
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:41:22 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:41:22 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, "Nathan
 Chancellor" <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	<linux-kbuild@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, <linux-modules@vger.kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, <linux-kernel@vger.kernel.org>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 6/6] kbuild, bpf: allow building the vmlinux BTF as a module
Date: Wed, 23 Sep 2026 05:39:48 +0000
Message-ID: <20260923053948.30617-7-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923053948.30617-1-wanjay@amazon.com>
References: <20260923053948.30617-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Make CONFIG_DEBUG_INFO_BTF a tristate.  With =m the vmlinux BTF is not
part of the kernel image: it is carried by a new module, btf_vmlinux, and
loaded the first time something needs it.  Nothing that works with =y
stops working; the 5.4 MiB of read-only data (distribution config) is
simply not there on systems where nothing uses it.

The only way to save that memory today is CONFIG_DEBUG_INFO_BTF=n, which
a distribution cannot ship: one binary goes to every user, and off takes
BTF away from the users of CO-RE, fentry/fexit, kfuncs, struct_ops,
sched_ext or bpf-lsm.  Whether BTF is used is a property of the
workload, not of the build, so let the first user decide.

The BTF is generated as before, but with =m the .BTF section is linked
into vmlinux as a non-loadable section (like .comment), so the vmlinux
ELF still carries it for module BTF generation and tooling while the
image does not.  .BTF_ids stays loadable, the verifier needs it once the
BTF is loaded.  The object that carries .BTF also carries .BTF.meta, the
size and SHA-256 of the BTF (struct btf_vmlinux_meta, checked by the
module notifier); the first link, which the BTF is generated from, gets a
zeroed .BTF.meta of the same size.  kernel/bpf/btf_vmlinux.c is an empty
carrier module; scripts/gen-btf.sh gives it the vmlinux .BTF as its own
.BTF section instead of generating split BTF for it, so modules depend
on vmlinux with =m as they do with CONFIG_DEBUG_INFO_BTF_MODULES.

Makefiles that compiled kfunc objects with obj-$(CONFIG_DEBUG_INFO_BTF)
now treat m as y, and the #ifdef CONFIG_DEBUG_INFO_BTF sites that must
also apply with =m (the .BTF_ids tables, type tags, tracepoint and
syscall BTF ids) use IS_ENABLED(): the generated BTF and its id tables
are the same for =y and =m, only the delivery of the blob differs.

CONFIG_BPF_PRELOAD is not selectable with =m: its iterator programs
attach through the vmlinux BTF, so every bpffs mount (systemd does one
at boot) would load it and defeat the point.

The module has no exit: once loaded the BTF stays, as with =y.  The
runtime side -- loading the module on first use, checking it against
.BTF.meta, deferring kfunc and struct_ops registrations and module BTF
until it arrives -- is in the preceding patches; this one makes it
selectable.

Tested with 1 GiB of memory, same tree, =y vs =m, both with
CONFIG_DEBUG_INFO_BTF_MODULES=y:

 - MemTotal is ~5.4 MB higher with =m while the BTF is unused: the size
   of the .BTF section.
 - stat() of /sys/kernel/btf/vmlinux reports the BTF size before it is
   loaded, as the btf_sysfs selftest expects.
 - With BTF in use, MemFree is the same within run-to-run noise.
 - Modules loaded before the trigger (ext4, nf_conntrack and its kfuncs,
   xfrm_interface) appear in /sys/kernel/btf immediately and get BTF ids
   once the BTF is loaded; a socket filter loads without loading the
   module; a kprobe program calling bpf_get_current_task_btf(), opening
   /sys/kernel/btf/vmlinux or BPF_BTF_GET_NEXT_ID each load it.
 - A carrier module with one byte of its .BTF changed is refused with
   "BTF does not match this kernel" and leaves no state behind.
 - After the load: fstat/read/mmap of /sys/kernel/btf/vmlinux, a
   struct_ops map for tcp_congestion_ops, a syscall program calling the
   bpf_task_from_pid()/bpf_task_release() kfuncs, and modules loaded
   afterwards (nf_nat) all work as with =y.
 - =m without DEBUG_INFO_BTF_MODULES, and =y, build and pass the same
   tests.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 Documentation/bpf/btf.rst         | 35 ++++++++++++
 Makefile                          |  8 ++-
 include/asm-generic/vmlinux.lds.h | 30 +++++++++-
 include/linux/btf_ids.h           |  2 +-
 include/linux/compiler_types.h    |  2 +-
 include/trace/trace_events.h      |  2 +-
 kernel/bpf/Makefile               |  6 +-
 kernel/bpf/btf_vmlinux.c          | 23 ++++++++
 kernel/bpf/preload/Kconfig        |  4 ++
 kernel/trace/trace_syscalls.c     |  6 +-
 lib/Kconfig.debug                 | 13 ++++-
 net/netfilter/Makefile            |  6 +-
 net/xfrm/Makefile                 |  4 +-
 scripts/Makefile.modfinal         | 14 +++--
 scripts/gen-btf.sh                | 93 +++++++++++++++++++++++++++++--
 scripts/link-vmlinux.sh           | 25 +++++++--
 16 files changed, 244 insertions(+), 29 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux.c

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 004aa1058d85..a835231187ef 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1197,6 +1197,41 @@ format.::
             .long   58
             .long   8206                    # Line 8 Col 14
 
+6.1 Kernel BTF
+--------------
+
+With CONFIG_DEBUG_INFO_BTF=y the BTF of the kernel is generated at link time
+from its DWARF and placed in the .BTF section of vmlinux, which is read-only
+data of the kernel image. It is available as /sys/kernel/btf/vmlinux and, if
+CONFIG_DEBUG_INFO_BTF_MODULES is set, module BTF is generated as split BTF
+against it and available as /sys/kernel/btf/<module>.
+
+With CONFIG_DEBUG_INFO_BTF=m the same BTF is generated, but it is not part of
+the kernel image (the vmlinux ELF file still carries it in a non-loadable .BTF
+section for tooling and module BTF generation). It is delivered by the
+btf_vmlinux module, which the kernel loads on demand the first time the BTF is
+needed: when /sys/kernel/btf/vmlinux is read or mmap()ed, when kernel BTF
+objects are enumerated (BPF_BTF_GET_NEXT_ID), or when a BPF program needs
+kernel type information (an attach_btf_id, a kfunc call, a ksym, a map pointer
+or a helper that takes or returns a kernel BTF pointer). Until then no memory
+is used for it, and afterwards nothing differs from =y. In particular:
+
+  * /sys/kernel/btf/vmlinux exists from boot with its final size.
+  * Modules loaded before the vmlinux BTF are exposed in /sys/kernel/btf right
+    away, their BTF is parsed and gets a BTF id once the vmlinux BTF is
+    loaded, together with their kfunc and struct_ops registrations.
+  * kfunc, dtor kfunc and struct_ops registrations of the kernel itself are
+    applied before the BTF becomes visible.
+  * The kernel only accepts the BTF it was built with: the size and SHA-256 of
+    the BTF are linked into the kernel and checked against the module.
+  * Once loaded the BTF stays; the module cannot be unloaded.
+
+If the module is not available (not installed, or the root file system is not
+mounted yet), the kernel behaves as one built without BTF and retries next
+time. CONFIG_BPF_PRELOAD is not available with =m: its iterators attach through
+the vmlinux BTF, so mounting bpffs would load it. bpf_snprintf_btf() and bpf_seq_printf_btf() only use the BTF if it has
+already been parsed, as they run in program context.
+
 7. Testing
 ==========
 
diff --git a/Makefile b/Makefile
index 66654fa71655..0a37decd9d01 100644
--- a/Makefile
+++ b/Makefile
@@ -1208,7 +1208,8 @@ endif
 # include additional Makefiles when needed
 include-y			:= scripts/Makefile.warn
 include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
-include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf
+# CONFIG_DEBUG_INFO_BTF is a tristate; BTF is generated for both y and m
+include-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += scripts/Makefile.btf
 include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
 include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
 include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
@@ -1744,8 +1745,9 @@ endif
 #
 
 # *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFO_BTF_MODULES
-# is an exception.
-ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+# is an exception, and so is the btf_vmlinux module with CONFIG_DEBUG_INFO_BTF=m,
+# which carries the vmlinux BTF.
+ifneq ($(CONFIG_DEBUG_INFO_BTF_MODULES)$(filter m,$(CONFIG_DEBUG_INFO_BTF)),)
 KBUILD_BUILTIN := y
 modules: vmlinux
 endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..9e2f4861fef2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -674,8 +674,17 @@
 
 /*
  * .BTF
+ *
+ * With CONFIG_DEBUG_INFO_BTF=y the vmlinux BTF is loaded as read-only data and
+ * bounded by __start_BTF/__stop_BTF.  With CONFIG_DEBUG_INFO_BTF=m it is still
+ * emitted into the vmlinux ELF file so that module BTF generation and tooling
+ * can read it, but as a non-loadable section (see BTF_NOLOAD in ELF_DETAILS):
+ * the btf_vmlinux module carries a copy and provides it on demand at runtime.
+ * What is loaded instead is .BTF.meta, the size and hash of that BTF (see
+ * scripts/gen-btf.sh), empty in the first link that the BTF is generated
+ * from.  .BTF_ids is needed by the kernel in both cases.
  */
-#ifdef CONFIG_DEBUG_INFO_BTF
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
 #define BTF								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
@@ -685,10 +694,28 @@
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
 	}
+#elif IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+#define BTF								\
+	. = ALIGN(8);							\
+	.BTF.meta : AT(ADDR(.BTF.meta) - LOAD_OFFSET) {			\
+		BOUNDED_SECTION_BY(.BTF.meta, _BTF_meta)		\
+	}								\
+	. = ALIGN(PAGE_SIZE);						\
+	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
+		*(.BTF_ids)						\
+	}
 #else
 #define BTF
 #endif
 
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/* quoted: BTF is a macro, an unquoted .BTF here would expand it */
+#define BTF_NOLOAD							\
+		".BTF" 0 : { *(".BTF") }
+#else
+#define BTF_NOLOAD
+#endif
+
 /*
  * Init task
  */
@@ -849,6 +876,7 @@
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
 		.comment 0 : { *(.comment) }				\
+		BTF_NOLOAD						\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
 		.shstrtab 0 : { *(.shstrtab) }				\
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 8b5a9ee92513..c665afff100e 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -22,7 +22,7 @@ struct btf_id_set8 {
 	} pairs[];
 };
 
-#ifdef CONFIG_DEBUG_INFO_BTF
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 
 #include <linux/compiler.h> /* for __PASTE */
 #include <linux/compiler_attributes.h> /* for __maybe_unused */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..a90a99849cee 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -34,7 +34,7 @@
  * Skipped when running bindgen due to a libclang issue;
  * see https://github.com/rust-lang/rust-bindgen/issues/2244.
  */
-#if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
 	__has_attribute(btf_type_tag) && !defined(__BINDGEN__)
 # define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
 #else
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 93011f800d0f..2a0098929771 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -398,7 +398,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define _TRACE_PERF_INIT(call)
 #endif /* CONFIG_PERF_EVENTS */
 
-#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 /*
  * Per-template BTF id list, populated at link time by resolve_btfids:
  *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 9a92c348bbda..8ab46f496fa4 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -41,7 +41,11 @@ ifeq ($(CONFIG_INET),y)
 obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
 endif
 ifeq ($(CONFIG_SYSFS),y)
-obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
+obj-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += sysfs_btf.o
+endif
+# With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is carried by this module
+ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
+obj-m += btf_vmlinux.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
diff --git a/kernel/bpf/btf_vmlinux.c b/kernel/bpf/btf_vmlinux.c
new file mode 100644
index 000000000000..8d89b4bb3c43
--- /dev/null
+++ b/kernel/bpf/btf_vmlinux.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Carrier module for the vmlinux BTF when CONFIG_DEBUG_INFO_BTF=m.
+ *
+ * This module has no code of its own.  Its .BTF section is a copy of the
+ * vmlinux BTF (see scripts/gen-btf.sh), which the BTF module notifier in
+ * kernel/bpf/btf.c recognizes by module name and installs as the vmlinux BTF.
+ * The kernel loads it on demand, the first time the vmlinux BTF is needed.
+ *
+ * There is deliberately no module_exit(): once the BTF is in use it cannot
+ * be taken away again, exactly as with CONFIG_DEBUG_INFO_BTF=y.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+
+static int __init btf_vmlinux_init(void)
+{
+	return 0;
+}
+module_init(btf_vmlinux_init);
+
+MODULE_DESCRIPTION("BTF type information for vmlinux");
+MODULE_LICENSE("GPL");
diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index aef7b0bc96d6..b1600bdce7a0 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -6,6 +6,10 @@ menuconfig BPF_PRELOAD
 	# The dependency on !COMPILE_TEST prevents it from being enabled
 	# in allmodconfig or allyesconfig configurations
 	depends on !COMPILE_TEST
+	# The preloaded iterators attach through the vmlinux BTF, so with
+	# CONFIG_DEBUG_INFO_BTF=m every bpffs mount would load the BTF, which
+	# defeats the point of =m on any system that mounts bpffs at boot.
+	depends on DEBUG_INFO_BTF!=m
 	help
 	  This builds kernel module with several embedded BPF programs that are
 	  pinned into BPF FS mount point as human readable files that are
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e35744049e3f..7a0d59c308c2 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1304,7 +1304,7 @@ struct trace_event_functions exit_syscall_print_funcs = {
 	.trace		= print_syscall_exit,
 };
 
-#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 /* BTF id lists for the shared sys_enter/sys_exit dispatcher tracepoints. */
 BTF_ID_LIST(syscall_enter_btf_ids)
 BTF_ID(func,   __bpf_trace_sys_enter)
@@ -1321,7 +1321,7 @@ struct trace_event_class __refdata event_class_syscall_enter = {
 	.fields_array	= syscall_enter_fields_array,
 	.get_fields	= syscall_get_enter_fields,
 	.raw_init	= init_syscall_trace,
-#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 	.btf_ids	= syscall_enter_btf_ids,
 #endif
 };
@@ -1336,7 +1336,7 @@ struct trace_event_class __refdata event_class_syscall_exit = {
 	},
 	.fields		= LIST_HEAD_INIT(event_class_syscall_exit.fields),
 	.raw_init	= init_syscall_trace,
-#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 	.btf_ids	= syscall_exit_btf_ids,
 #endif
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..5307caa39176 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -396,7 +396,7 @@ config DEBUG_INFO_SPLIT
 	  Incompatible with older versions of ccache.
 
 config DEBUG_INFO_BTF
-	bool "Generate BTF type information"
+	tristate "Generate BTF type information"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
@@ -408,6 +408,17 @@ config DEBUG_INFO_BTF
 	  Turning this on requires pahole v1.22 or later, which will convert
 	  DWARF type info into equivalent deduplicated BTF type info.
 
+	  If built as a module (=m), the vmlinux BTF is not part of the
+	  kernel image.  It is carried by the btf_vmlinux module, which is
+	  loaded on demand the first time the BTF is needed: when a BPF
+	  program requires kernel type information, or when
+	  /sys/kernel/btf/vmlinux is opened.  Until then, no memory is
+	  spent on it.  The BTF is still emitted into the vmlinux ELF file
+	  (as a non-loadable section) so tooling and module BTF generation
+	  work as before.  Module BTF (DEBUG_INFO_BTF_MODULES) is registered
+	  when the vmlinux BTF becomes available.  Not compatible with
+	  BPF_PRELOAD, whose iterators would load the BTF at every bpffs mount.
+
 config PAHOLE_HAS_BTF_TAG
 	def_bool PAHOLE_VERSION >= 123
 	depends on CC_IS_CLANG
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 6bf74d488a29..a2c7f00794d2 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -18,7 +18,7 @@ nf_conntrack-$(CONFIG_NF_CT_PROTO_GRE) += nf_conntrack_proto_gre.o
 ifeq ($(CONFIG_NF_CONNTRACK),m)
 nf_conntrack-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_conntrack_bpf.o
 else ifeq ($(CONFIG_NF_CONNTRACK),y)
-nf_conntrack-$(CONFIG_DEBUG_INFO_BTF) += nf_conntrack_bpf.o
+nf_conntrack-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += nf_conntrack_bpf.o
 endif
 
 obj-$(CONFIG_NETFILTER) = netfilter.o
@@ -65,7 +65,7 @@ nf_nat-$(CONFIG_NF_NAT_OVS) += nf_nat_ovs.o
 ifeq ($(CONFIG_NF_NAT),m)
 nf_nat-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_nat_bpf.o
 else ifeq ($(CONFIG_NF_NAT),y)
-nf_nat-$(CONFIG_DEBUG_INFO_BTF) += nf_nat_bpf.o
+nf_nat-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += nf_nat_bpf.o
 endif
 
 # NAT helpers
@@ -147,7 +147,7 @@ nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
 ifeq ($(CONFIG_NF_FLOW_TABLE),m)
 nf_flow_table-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_flow_table_bpf.o
 else ifeq ($(CONFIG_NF_FLOW_TABLE),y)
-nf_flow_table-$(CONFIG_DEBUG_INFO_BTF) += nf_flow_table_bpf.o
+nf_flow_table-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += nf_flow_table_bpf.o
 endif
 
 obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index 5a1787587cb3..b7f6e5046a0e 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -8,7 +8,7 @@ xfrm_interface-$(CONFIG_XFRM_INTERFACE) += xfrm_interface_core.o
 ifeq ($(CONFIG_XFRM_INTERFACE),m)
 xfrm_interface-$(CONFIG_DEBUG_INFO_BTF_MODULES) += xfrm_interface_bpf.o
 else ifeq ($(CONFIG_XFRM_INTERFACE),y)
-xfrm_interface-$(CONFIG_DEBUG_INFO_BTF) += xfrm_interface_bpf.o
+xfrm_interface-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += xfrm_interface_bpf.o
 endif
 
 obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
@@ -23,4 +23,4 @@ obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
 obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
 obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
 obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
-obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
+obj-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += xfrm_state_bpf.o
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 01a37ec872b9..ad182f84b5fc 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -46,12 +46,18 @@ quiet_cmd_btf_ko = BTF [M] $@
 		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
 	fi;
 
-# Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
-	+$(call if_changed,ld_ko_o)
+# Modules that get a .BTF section: all of them with CONFIG_DEBUG_INFO_BTF_MODULES,
+# otherwise only the vmlinux BTF carrier module with CONFIG_DEBUG_INFO_BTF=m.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-	+$(if $(newer-prereqs),$(call cmd,btf_ko))
+btf-modules := $(modules:%.o=%.ko)
+else ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
+btf-modules := $(filter %/btf_vmlinux.ko,$(modules:%.o=%.ko))
 endif
+
+# Re-generate module BTFs if either module's .ko or vmlinux changed
+%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(btf-modules),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
+	+$(call if_changed,ld_ko_o)
+	+$(if $(and $(filter $@,$(btf-modules)),$(newer-prereqs)),$(call cmd,btf_ko))
 	+$(call cmd,check_tracepoint)
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index 8ca96eb10a69..7fa3189a3ded 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -22,16 +22,26 @@
 #   - ${1}.btf.o ready for linking into vmlinux
 #   - ${1}.BTF_ids with .BTF_ids data blob
 # This output is consumed by scripts/link-vmlinux.sh
+#
+# With CONFIG_DEBUG_INFO_BTF=m the .BTF section in ${1}.btf.o is not
+# allocatable, so the vmlinux ELF file carries the BTF but the kernel image
+# does not.  ${1}.btf.o then also carries .BTF.meta, the size and SHA-256 of
+# the BTF for the kernel (struct btf_vmlinux_meta); "--placeholder ${1}"
+# produces a ${1}.btf.o with a zeroed .BTF.meta and no .BTF for the first
+# vmlinux link, which the BTF is generated from.  The btf_vmlinux module gets
+# no BTF of its own; its .BTF section is a copy of the vmlinux BTF, extracted
+# from --btf_base.
 
 set -e
 
 usage()
 {
-	echo "Usage: $0 [--btf_base <file>] <target ELF file>"
+	echo "Usage: $0 [--btf_base <file>] [--placeholder] <target ELF file>"
 	exit 1
 }
 
 BTF_BASE=""
+PLACEHOLDER=""
 
 while [ $# -gt 0 ]; do
 	case "$1" in
@@ -39,6 +49,10 @@ while [ $# -gt 0 ]; do
 		BTF_BASE="$2"
 		shift 2
 		;;
+	--placeholder)
+		PLACEHOLDER=1
+		shift
+		;;
 	-*)
 		echo "Unknown option: $1" >&2
 		usage
@@ -60,6 +74,10 @@ is_enabled() {
 	grep -q "^$1=y" ${objtree}/include/config/auto.conf
 }
 
+is_module() {
+	grep -q "^$1=m" ${objtree}/include/config/auto.conf
+}
+
 case "${KBUILD_VERBOSE}" in
 *1*)
 	set -x
@@ -79,6 +97,30 @@ gen_btf_data()
 		--btf ${btf1} "${ELF_FILE}"
 }
 
+# Write one byte with value $1 (0..255)
+put_byte()
+{
+	printf "\\$(printf '%03o' "$1")"
+}
+
+# CONFIG_DEBUG_INFO_BTF=m: write struct btf_vmlinux_meta { u32 size; u8
+# sha256[32]; } for the BTF in $1 to $2, in the target's byte order.
+gen_btf_meta()
+{
+	size=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" "$1")
+	sha256=$(sha256sum < "$1" | cut -d' ' -f1)
+	{
+		if is_enabled CONFIG_CPU_BIG_ENDIAN; then
+			for shift in 24 16 8 0; do put_byte $(( (size >> shift) & 255 )); done
+		else
+			for shift in 0 8 16 24; do put_byte $(( (size >> shift) & 255 )); done
+		fi
+		for byte in $(echo "${sha256}" | sed 's/../& /g'); do
+			put_byte $(( 0x${byte} ))
+		done
+	} > "$2"
+}
+
 gen_btf_o()
 {
 	btf_data=${ELF_FILE}.btf.o
@@ -88,9 +130,23 @@ gen_btf_o()
 	# deletes all symbols including __start_BTF and __stop_BTF, which will
 	# be redefined in the linker script.
 	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
-	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
-		--set-section-flags .BTF=alloc,readonly ${btf_data}
-	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
+	if is_module CONFIG_DEBUG_INFO_BTF; then
+		# CONFIG_DEBUG_INFO_BTF=m: .BTF stays non-allocatable, kept in the
+		# vmlinux ELF file for tooling but not loaded; the btf_vmlinux
+		# module provides it at runtime.  What is loaded is .BTF.meta,
+		# its size and hash, so that /sys/kernel/btf/vmlinux has the right
+		# size from boot and only the matching BTF is accepted.
+		gen_btf_meta ${ELF_FILE}.BTF ${ELF_FILE}.BTF.meta
+		${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
+			--set-section-flags .BTF=readonly \
+			--add-section .BTF.meta=${ELF_FILE}.BTF.meta \
+			--set-section-flags .BTF.meta=alloc,readonly ${btf_data}
+		${OBJCOPY} --only-section=.BTF --only-section=.BTF.meta --strip-all ${btf_data}
+	else
+		${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
+			--set-section-flags .BTF=alloc,readonly ${btf_data}
+		${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
+	fi
 
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
 	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
@@ -121,6 +177,7 @@ cleanup()
 {
 	rm -f "${ELF_FILE}.BTF.1"
 	rm -f "${ELF_FILE}.BTF"
+	rm -f "${ELF_FILE}.BTF.meta"
 	if [ "${BTFGEN_MODE}" = "module" ]; then
 		rm -f "${ELF_FILE}.BTF.base"
 		rm -f "${ELF_FILE}.BTF_ids"
@@ -133,6 +190,34 @@ if [ -n "${BTF_BASE}" ]; then
 	BTFGEN_MODE="module"
 fi
 
+if [ -n "${PLACEHOLDER}" ]; then
+	btf_data=${ELF_FILE}.btf.o
+	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
+	head -c 36 /dev/zero > ${ELF_FILE}.BTF.meta
+	${OBJCOPY} --add-section .BTF.meta=${ELF_FILE}.BTF.meta \
+		--set-section-flags .BTF.meta=alloc,readonly ${btf_data}
+	${OBJCOPY} --only-section=.BTF.meta --strip-all ${btf_data}
+	exit 0
+fi
+
+# CONFIG_DEBUG_INFO_BTF=m: the btf_vmlinux module carries the vmlinux BTF
+# itself.  Its own types are of no interest, so instead of generating split
+# BTF for it, copy the (non-loadable) .BTF section of vmlinux into the module.
+# The kernel recognizes the module by name and treats its .BTF as base BTF.
+case "${BTFGEN_MODE}:${ELF_FILE}" in
+module:*/btf_vmlinux.ko)
+	if is_module CONFIG_DEBUG_INFO_BTF; then
+		# -O binary only emits allocatable sections; make .BTF one for
+		# the extraction.  ${BTF_BASE} itself is not modified.
+		${OBJCOPY} -O binary --only-section=.BTF			\
+			--set-section-flags .BTF=alloc,load,readonly	\
+			"${BTF_BASE}" "${ELF_FILE}.BTF"
+		${OBJCOPY} --add-section .BTF="${ELF_FILE}.BTF" "${ELF_FILE}"
+		exit 0
+	fi
+	;;
+esac
+
 gen_btf_data
 
 case "${BTFGEN_MODE}" in
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ab0b8125c8cb..a9a066267ef6 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -37,6 +37,15 @@ is_enabled() {
 	grep -q "^$1=y" include/config/auto.conf
 }
 
+is_module() {
+	grep -q "^$1=m" include/config/auto.conf
+}
+
+# =y or =m
+is_set() {
+	grep -q "^$1=[ym]" include/config/auto.conf
+}
+
 # Nice output in kbuild format
 # Will be suppressed by "make -s"
 info()
@@ -211,17 +220,25 @@ if is_enabled CONFIG_KALLSYMS; then
 	kallsyms .tmp_vmlinux0.syms .tmp_vmlinux0.kallsyms
 fi
 
-if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
+if is_module CONFIG_DEBUG_INFO_BTF; then
+	# The kernel refers to the size and hash of its BTF, which only the
+	# BTF generated from the first link can provide; link a placeholder
+	# of the same layout until then.
+	${CONFIG_SHELL} ${srctree}/scripts/gen-btf.sh --placeholder .tmp_vmlinux0
+	btf_vmlinux_bin_o=.tmp_vmlinux0.btf.o
+fi
+
+if is_enabled CONFIG_KALLSYMS || is_set CONFIG_DEBUG_INFO_BTF; then
 
 	# The kallsyms linking does not need debug symbols, but the BTF does.
-	if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
+	if ! is_set CONFIG_DEBUG_INFO_BTF; then
 		strip_debug=1
 	fi
 
 	vmlinux_link .tmp_vmlinux1
 fi
 
-if is_enabled CONFIG_DEBUG_INFO_BTF; then
+if is_set CONFIG_DEBUG_INFO_BTF; then
 	info BTF .tmp_vmlinux1
 	if ! ${CONFIG_SHELL} ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then
 		echo >&2 "Failed to generate BTF for vmlinux"
@@ -287,7 +304,7 @@ fi
 
 vmlinux_link "${VMLINUX}"
 
-if is_enabled CONFIG_DEBUG_INFO_BTF; then
+if is_set CONFIG_DEBUG_INFO_BTF; then
 	info BTFIDS ${VMLINUX}
 	${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} ${VMLINUX}
 fi
-- 
2.47.3

