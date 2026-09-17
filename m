Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148681B4138;
	Thu, 17 Sep 2026 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603330; cv=none; b=qpfeEkgz8VN/NOv0gBthY0DThuYe3sKZzdXq4brCI1rR28z/WXPiAHI0PTPLytAmu2aYWp7zw2NDIFEvom4XCavrp2cgaFJ3hZxOFrAQu7Zdm0bzj0SLycUISj+3t4yvSw/7CmA9OKM6zQc1TuNhHpftxIdwzX1d3C8DLETH9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603330; c=relaxed/simple;
	bh=P1P7sOmKKmdUYKswWsxptTlYlB42YMyPAmerl9dgMbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0k2plKv/watjx0hJDywrDF+VEhB+1vcqH5JwZSpT+sa8G+fhihRX6qhIQrcU/vXkN2zvxQ7/hdw4PkYhGOa+fJ3Ry4yoEN63KUi2O8kOQoE7i4aStV7Y8tdyYwPVng761FEOD/1bSH/dc02NEHqmdo+e/wC7vJA0naLxD+svQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DtSpS5g0; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DtSpS5g0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789603326; x=1821139326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bksx6K3cmM73t/29KfLQtb5oBI9M5XKHzJ7/TruFdoo=;
  b=DtSpS5g04Ai+8v7GLV0ENpvJQZoj0FYuyY55KeFdqwBhppxVvEQLBVMS
   Mwp6wkGN1ff1ZickVf+Xl1I9vmPExe6FEOf9ldV27dmQxUgDAZMrXlh4+
   1sUcgk9K/6pZ72ca4qgqnYXcf9f/G12FBg7VnL9WGMGFr3TBMobTsM00w
   OTR+C7MAXW5BA0yqAzRN5DX4ALm5EdVDuWZVINdTw5w8eJhT8ge+kEu6J
   hN0US9H5HmpLEzY3bYdpoHOmENZdYcHokNnQ0ePIcMG69Q5+dYGMzCU6G
   2csvBGInkVIo3sVkVolo+pA9fsko84BUrabzouOD3uSyrlK8MhqOuETu2
   g==;
X-CSE-ConnectionGUID: oTNplX2vSO2yqQ+Y58O5jQ==
X-CSE-MsgGUID: irk2PvgxQd2420ohdPjEIA==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28776422"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:02:02 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:14888]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.232:2525] with esmtp (Farcaster)
 id 3940299e-7074-4eae-87f7-0ca5e7e47c02; Thu, 17 Sep 2026 00:02:02 +0000 (UTC)
X-Farcaster-Flow-ID: 3940299e-7074-4eae-87f7-0ca5e7e47c02
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 17 Sep 2026 00:02:02 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 17 Sep 2026 00:02:01 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>
CC: <yonghong.song@linux.dev>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<x86@kernel.org>, <dave.hansen@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <abuehaze@amazon.com>, <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 1/1] bpf: btf: add btf=off boot parameter to disable and free vmlinux BTF
Date: Thu, 17 Sep 2026 00:02:01 +0000
Message-ID: <20260917000201.25581-2-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917000201.25581-1-wanjay@amazon.com>
References: <20260917000201.25581-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

CONFIG_DEBUG_INFO_BTF puts the kernel's BTF type information in the
vmlinux .BTF section, which stays in rodata for the whole boot: 5.2 MiB on
x86-64 and 5.3 MiB on arm64 with a distribution config.  On a 1 GiB VM, a
common cloud instance size, that is a visible part of total memory.

The only way to drop it today is to build with CONFIG_DEBUG_INFO_BTF=n,
which a distribution cannot do: it ships one binary to every user, so the
choice applies to all of them.  Off takes BTF away from the users who need
it (CO-RE programs, fentry/fexit, kfunc calls, struct_ops, bpftrace); on
charges the users who never touch it.  Whether BTF is used depends on the
workload, not on the build.

Add a "btf=off" early boot parameter, similar to the existing "selinux=0"
parameter, so users who do not want BTF can turn it off at boot; the
section is then freed to save memory.

By default btf=off is not set and the kernel behaves as before: BTF stays
resident and read-only.

With btf=off the kernel behaves as if CONFIG_DEBUG_INFO_BTF were not set:

 - bpf_get_btf_vmlinux() never parses the section and returns NULL, the
   same handled state as a config-off build; all call sites already
   tolerate NULL.
 - /sys/kernel/btf is not created, so the section cannot be read or
   mapped from userspace.
 - btf_module_notify() skips module BTF parsing.  This is mandatory:
   parsing would fail against the missing vmlinux BTF and, without
   CONFIG_MODULE_ALLOW_BTF_MISMATCH, veto every module load.
 - check_btf_kconfigs() returns success, so boot-time kfunc, dtor-kfunc
   and struct_ops registration stays silent as it does with the config
   off.

Nothing can then reference the section, so the architecture frees it.

On x86-64, mark_rodata_ro() hands the range to free_kernel_image_pages(),
alongside the existing text/rodata and rodata/data gap frees.  The range
is excluded from the rodata pinning in protect_rodata(), or the RW flip in
free_init_pages() is silently refused and the poison write faults.

On arm64 the pages are freed and reused through the linear alias of the
kernel image, which is block-mapped and cannot be split live without
BBML2.  map_mem() therefore maps the page-aligned interior of the section
as a separate region of the alias and mark_linear_text_alias_ro() keeps
those boundaries, so mark_rodata_ro() can flip the whole region back to
PAGE_KERNEL - permissions only, legal at any granularity - and free it
with free_reserved_area(), which also drops it from memblock.reserved as
free_initmem() does.  No memblock_free() pairing: memblock_free() itself
releases to the buddy allocator once it is up, so the pair would
double-free.  The image mapping stays read-only in place; removing it
would require splitting block mappings.

__start_BTF is PAGE_SIZE-aligned by the linker script; __stop_BTF is not,
so a trailing partial page stays resident and read-only.

btf=off is currently supported on x86-64 and arm64 only.  On other
architectures it is ignored with a warning, rather than disabling BTF
without recovering any memory.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 .../admin-guide/kernel-parameters.txt         |  14 +++
 arch/arm64/mm/mmu.c                           | 108 +++++++++++++++++-
 arch/x86/mm/init_64.c                         |  30 +++++
 arch/x86/mm/pat/set_memory.c                  |  28 ++++-
 include/linux/btf.h                           |   9 ++
 kernel/bpf/btf.c                              |  51 ++++++++-
 kernel/bpf/sysfs_btf.c                        |   7 ++
 kernel/bpf/verifier.c                         |   2 +-
 8 files changed, 241 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..9ab9638b2840 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -669,6 +669,20 @@ Kernel parameters
 
 			See Documentation/admin-guide/bootconfig.rst
 
+	btf=		[KNL,EARLY]
+			Format: { off }
+			Disable use of the kernel's BTF type information
+			(CONFIG_DEBUG_INFO_BTF), making the kernel behave
+			as if it were built without it: /sys/kernel/btf is
+			not created, module BTF is not registered, and BPF
+			features that require kernel type information
+			(CO-RE, fentry/fexit, kfunc calls, struct_ops) are
+			unavailable.  The memory backing the .BTF section
+			is freed after init, reducing the kernel's
+			resident memory footprint.  Only supported on
+			x86-64 and arm64; other architectures ignore this
+			parameter.
+
 	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
 	bttv.radio=	Most important insmod options are available as
 			kernel args too.
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 79d90226fd5d..16c853d9640e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -30,6 +30,8 @@
 #include <linux/mm_inline.h>
 #include <linux/pagewalk.h>
 #include <linux/stop_machine.h>
+#include <linux/btf.h>
+#include <linux/poison.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -1054,6 +1056,39 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 	flush_tlb_kernel_range(virt, virt + size);
 }
 
+#if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_BPF_SYSCALL)
+extern char __start_BTF[], __stop_BTF[];
+
+/*
+ * With btf=off the pages backing the vmlinux .BTF section are freed by
+ * mark_rodata_ro() and later reused through the linear alias of the
+ * kernel image.  Block mappings cannot be split live without BBML2,
+ * which not all CPUs provide, so map_mem() maps the page-aligned
+ * interior of the section as a separate region of the alias: mapping
+ * boundaries then coincide with its edges, and its permissions can be
+ * changed as a whole without ever splitting a block mapping.
+ *
+ * Returns true and the region's kernel image virtual bounds when the
+ * free is pending.  early_param() is parsed before map_mem(), so the
+ * decision is stable by the time it is first needed.  __stop_BTF is
+ * not necessarily page-aligned; a trailing partial page stays
+ * resident (and read-only).
+ */
+static bool btf_free_range(unsigned long *start, unsigned long *end)
+{
+	*start = PAGE_ALIGN((unsigned long)__start_BTF);
+	*end = (unsigned long)__stop_BTF & PAGE_MASK;
+
+	return btf_is_disabled() && *start < *end;
+}
+#else
+static bool btf_free_range(unsigned long *start, unsigned long *end)
+{
+	*start = *end = 0;
+	return false;
+}
+#endif
+
 static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
 				  pgprot_t prot, int flags)
 {
@@ -1086,12 +1121,33 @@ static int arm64_hibernate_pm_notify(struct notifier_block *nb,
 
 void __init mark_linear_text_alias_ro(void)
 {
+	unsigned long btf_start, btf_end;
+
 	/*
 	 * Remove the write permissions from the linear alias of .text/.rodata
+	 *
+	 * With btf=off the alias consists of three regions (see map_mem());
+	 * remap it with the same boundaries so that every entry keeps its
+	 * granularity and only the permissions change.
 	 */
-	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
-			    (unsigned long)__init_begin - (unsigned long)_text,
-			    PAGE_KERNEL_RO);
+	if (btf_free_range(&btf_start, &btf_end)) {
+		update_mapping_prot(__pa_symbol(_text),
+				    (unsigned long)lm_alias(_text),
+				    btf_start - (unsigned long)_text,
+				    PAGE_KERNEL_RO);
+		update_mapping_prot(__pa_symbol(btf_start),
+				    (unsigned long)lm_alias(btf_start),
+				    btf_end - btf_start, PAGE_KERNEL_RO);
+		update_mapping_prot(__pa_symbol(btf_end),
+				    (unsigned long)lm_alias(btf_end),
+				    (unsigned long)__init_begin - btf_end,
+				    PAGE_KERNEL_RO);
+	} else {
+		update_mapping_prot(__pa_symbol(_text),
+				    (unsigned long)lm_alias(_text),
+				    (unsigned long)__init_begin - (unsigned long)_text,
+				    PAGE_KERNEL_RO);
+	}
 
 	/*
 	 * Register a PM notifier to remap the linear alias of data/bss as
@@ -1185,6 +1241,7 @@ static void __init map_mem(void)
 	phys_addr_t init_end = __pa_symbol(__init_end);
 	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
 	phys_addr_t start, end;
+	unsigned long btf_start, btf_end;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
 
@@ -1217,9 +1274,23 @@ static void __init map_mem(void)
 	 * removed later by mark_linear_text_alias_ro() above. This makes the
 	 * contents of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
+	 *
+	 * With btf=off the .BTF section becomes a separate region of the
+	 * alias, so that mark_rodata_ro() can change its permissions and free
+	 * it as a whole without splitting any block mapping (see
+	 * btf_free_range()).
 	 */
-	__map_memblock(kernel_start, init_begin, pgprot_tagged(PAGE_KERNEL),
-		       flags);
+	if (btf_free_range(&btf_start, &btf_end)) {
+		__map_memblock(kernel_start, __pa_symbol(btf_start),
+			       pgprot_tagged(PAGE_KERNEL), flags);
+		__map_memblock(__pa_symbol(btf_start), __pa_symbol(btf_end),
+			       pgprot_tagged(PAGE_KERNEL), flags);
+		__map_memblock(__pa_symbol(btf_end), init_begin,
+			       pgprot_tagged(PAGE_KERNEL), flags);
+	} else {
+		__map_memblock(kernel_start, init_begin,
+			       pgprot_tagged(PAGE_KERNEL), flags);
+	}
 
 	/* Map the kernel data/bss so it can be remapped later */
 	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
@@ -1254,6 +1325,7 @@ static void __init map_mem(void)
 void mark_rodata_ro(void)
 {
 	unsigned long section_size;
+	unsigned long btf_start, btf_end;
 
 	/*
 	 * mark .rodata as read only. Use __init_begin rather than __end_rodata
@@ -1270,6 +1342,32 @@ void mark_rodata_ro(void)
 
 	/* Map the kernel data/bss as invalid in the linear map */
 	mark_linear_data_alias_valid(false);
+
+	/*
+	 * btf=off: nothing has parsed or exported the vmlinux BTF - no
+	 * sysfs attribute exists (so no mmap can exist) and no BTF
+	 * pointer has been handed out - so the pages backing the .BTF
+	 * section can be returned to the page allocator.
+	 *
+	 * The pages are freed, poisoned and later reused through their
+	 * linear alias, which map_mem() mapped as a separate region and
+	 * mark_linear_text_alias_ro() made read-only: flip the whole
+	 * region back to PAGE_KERNEL - a permission-only change - and
+	 * hand the pages over, mirroring free_initmem().  The kernel
+	 * image mapping of the section (made read-only just above) is
+	 * left in place: it cannot be written through, and removing it
+	 * would require splitting live block mappings.
+	 */
+	if (btf_free_range(&btf_start, &btf_end)) {
+		void *lm_start = lm_alias((void *)btf_start);
+		void *lm_end = lm_alias((void *)btf_end);
+
+		update_mapping_prot(__pa_symbol(btf_start),
+				    (unsigned long)lm_start,
+				    btf_end - btf_start, PAGE_KERNEL);
+		free_reserved_area(lm_start, lm_end, POISON_FREE_INITMEM,
+				   "unused BTF (btf=off)");
+	}
 }
 
 static void __init declare_vma(struct vm_struct *vma,
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 70e682180291..83a3b478202d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/btf.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1400,6 +1401,35 @@ void mark_rodata_ro(void)
 				(void *)text_end, (void *)rodata_start);
 	free_kernel_image_pages("unused kernel image (rodata/data gap)",
 				(void *)rodata_end, (void *)_sdata);
+
+#if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_BPF_SYSCALL)
+	/*
+	 * With btf=off nothing has parsed or exported the vmlinux BTF:
+	 * no sysfs attribute exists (so no mmap can exist) and no BTF
+	 * pointer has been handed out, so the pages backing the .BTF
+	 * section can be freed like the gaps above.
+	 *
+	 * .BTF lies inside __start_rodata..__end_rodata, which
+	 * protect_rodata() pins read-only now that
+	 * kernel_set_to_readonly is set.  The freed page range is
+	 * excluded from that pinning (see protect_rodata() in
+	 * arch/x86/mm/pat/set_memory.c); without the exclusion the RW
+	 * flip in free_init_pages() is silently refused and the poison
+	 * write faults.  __start_BTF is PAGE_SIZE-aligned by the linker
+	 * script; __stop_BTF is not, so the trailing partial page is
+	 * left in place (and stays protected rodata).
+	 */
+	if (btf_is_disabled()) {
+		extern char __start_BTF[], __stop_BTF[];
+		unsigned long btf_start = PAGE_ALIGN((unsigned long)__start_BTF);
+		unsigned long btf_end = (unsigned long)__stop_BTF & PAGE_MASK;
+
+		if (btf_start < btf_end)
+			free_kernel_image_pages("unused BTF (btf=off)",
+						(void *)btf_start,
+						(void *)btf_end);
+	}
+#endif
 }
 
 /*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 4652487b5572..932e85dad394 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
+#include <linux/btf.h>
 #include <linux/memregion.h>
 #include <linux/cleanup.h>
 
@@ -547,7 +548,32 @@ static pgprotval_t protect_rodata(unsigned long spfn, unsigned long epfn)
 	 */
 	epfn_ro = PFN_DOWN(__pa_symbol(__end_rodata)) - 1;
 
-	if (kernel_set_to_readonly && overlaps(spfn, epfn, spfn_ro, epfn_ro))
+	if (!kernel_set_to_readonly)
+		return 0;
+
+#if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_BPF_SYSCALL)
+	/*
+	 * btf=off: the pages backing the .BTF section are freed to the
+	 * page allocator at the end of mark_rodata_ro() and are then
+	 * ordinary pages that must not be pinned read-only - both for
+	 * the freeing itself (free_reserved_area() writes the poison
+	 * pattern through the direct map) and for any later CPA call on
+	 * whatever gets allocated from them.  Only the fully-freed page
+	 * range is excluded; a trailing partial page stays protected
+	 * rodata.
+	 */
+	if (btf_is_disabled()) {
+		extern char __start_BTF[], __stop_BTF[];
+		unsigned long spfn_btf = PFN_UP(__pa_symbol(__start_BTF));
+		unsigned long epfn_btf = PFN_DOWN(__pa_symbol(__stop_BTF));
+
+		if (spfn_btf < epfn_btf &&
+		    spfn >= spfn_btf && epfn <= epfn_btf - 1)
+			return 0;
+	}
+#endif
+
+	if (overlaps(spfn, epfn, spfn_ro, epfn_ro))
 		return _PAGE_RW;
 	return 0;
 }
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 89d5a5c4f117..dd23d9b567e4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -11,6 +11,15 @@
 #include <uapi/linux/btf.h>
 #include <uapi/linux/bpf.h>
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_DEBUG_INFO_BTF)
+bool btf_is_disabled(void);
+#else
+static inline bool btf_is_disabled(void)
+{
+	return false;
+}
+#endif
+
 #define BTF_TYPE_EMIT(type) ((void)(type *)0)
 #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9f33e95d5741..bc9b2e57eb23 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6072,6 +6072,46 @@ extern char __start_BTF[];
 extern char __stop_BTF[];
 extern struct btf *btf_vmlinux;
 
+#ifdef CONFIG_DEBUG_INFO_BTF
+/*
+ * Boot-time opt out of vmlinux and module BTF.
+ *
+ * "btf=off" makes the kernel behave as if CONFIG_DEBUG_INFO_BTF were not
+ * set: vmlinux BTF is never parsed, /sys/kernel/btf is not created (so
+ * the .BTF section can never be read or mapped), and module BTF is not
+ * registered.  Since nothing can then reference the .BTF section, the
+ * architecture frees the pages backing it at free_initmem() time,
+ * recovering its memory.
+ */
+static bool btf_disabled __ro_after_init;
+
+static int __init btf_param(char *str)
+{
+	if (str && !strcmp(str, "off")) {
+		/*
+		 * Only architectures that implement freeing of the .BTF
+		 * section honour btf=off: x86-64 (mark_rodata_ro() in
+		 * arch/x86/mm/init_64.c) and arm64 (mark_rodata_ro() in
+		 * arch/arm64/mm/mmu.c).  On any other architecture
+		 * btf_disabled must never be set - disabling BTF without
+		 * freeing the section would lose the functionality while
+		 * recovering no memory.
+		 */
+		if (IS_ENABLED(CONFIG_X86_64) || IS_ENABLED(CONFIG_ARM64))
+			btf_disabled = true;
+		else
+			pr_warn("btf=off is not supported on this architecture, ignoring\n");
+	}
+	return 0;
+}
+early_param("btf", btf_param);
+
+bool btf_is_disabled(void)
+{
+	return btf_disabled;
+}
+#endif
+
 #define BPF_MAP_TYPE(_id, _ops)
 #define BPF_LINK_TYPE(_id, _name)
 static union {
@@ -8530,7 +8570,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	struct btf *btf;
 	int err = 0;
 
-	if (mod->btf_data_size == 0 ||
+	/*
+	 * btf=off: module BTF must not be parsed or registered; parsing
+	 * would fail against the missing vmlinux BTF and (without
+	 * CONFIG_MODULE_ALLOW_BTF_MISMATCH) veto the module load.
+	 */
+	if (btf_is_disabled() || mod->btf_data_size == 0 ||
 	    (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
 	     op != MODULE_STATE_GOING))
 		goto out;
@@ -8711,6 +8756,10 @@ struct btf *btf_get_module_btf(const struct module *module)
 
 static int check_btf_kconfigs(const struct module *module, const char *feature)
 {
+	/* btf=off: behave as if CONFIG_DEBUG_INFO_BTF were not set */
+	if (btf_is_disabled())
+		return 0;
+
 	if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
 		pr_err("missing vmlinux BTF, cannot register %s\n", feature);
 		return -ENOENT;
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 9cbe15ce3540..bab6f8db6cdd 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -53,6 +53,13 @@ struct kobject *btf_kobj;
 
 static int __init btf_vmlinux_init(void)
 {
+	/*
+	 * btf=off: never expose the .BTF section; its backing pages are
+	 * freed at free_initmem() time.
+	 */
+	if (btf_is_disabled())
+		return 0;
+
 	bin_attr_btf_vmlinux.private = __start_BTF;
 	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd2..d61479b681f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20619,7 +20619,7 @@ struct btf *bpf_get_btf_vmlinux(void)
 	/* Pairs with the smp_store_release() on the parse path below. */
 	struct btf *btf = smp_load_acquire(&btf_vmlinux);
 
-	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF) && !btf_is_disabled()) {
 		mutex_lock(&btf_vmlinux_lock);
 		btf = btf_vmlinux;
 		if (!btf) {
-- 
2.47.3

