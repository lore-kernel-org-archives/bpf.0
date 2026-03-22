Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6323126CD
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774143912; cv=none; b=uwMX3AKiqYwAGZu1iejuM1vLMvxkMTjhzvDK0J+jZDLZRUWiq0+W7tXGDen+oSHjtOI1Tmsx8/XmPXbmAjYcGX6yzOG87zCEbVfNFHyupnQwibBlxymKU+GfpCUvuZiekxKf5PqMfvLpgztZRNPKPiAq7zopn9V6b5+BS0cSGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774143912; c=relaxed/simple;
	bh=7J/0j0UT8bCyBT32UJ4DUDkUOg91zFMIdJHaBnIURbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCsrinxBzia7rrD4QvnmV7LUl70g4S+4W/Z4a4BeT3vOiW90jcjDB7C634nS6yu71fRDRrD3G63FnCZJs94S0DpHx9X4LjEuocaxbNnjzUvtcaNJ5x+v+852sB03ORVJ7Rcd+PY9Gq4GTS2vLXH9MBJVHYZV9XqfeTPsBZWQxq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuaoRR1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuaoRR1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBEyWtSTw7eVHcGhT5GAHiaIPcwZtFDY6ONhgAp2N3k=;
	b=VuaoRR1rDfYGV8naE2SEWbrnla2pYSPCIjJF5A9ixsTd3RmvRiXQbLbHA08NZjH2+fT/gs
	+oAVBWObHQRZ6QJ4/xBuCRA+rseyZKF5tqcUv4sbf/tSMOQLQYLtN0pwOO4EmsFvB+Pixs
	UbSnq/1/JQVw/gq7pB6aHxycH0SXCyI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-9hVuChQdM_m5a9ZsPwmIag-1; Sat,
 21 Mar 2026 21:45:05 -0400
X-MC-Unique: 9hVuChQdM_m5a9ZsPwmIag-1
X-Mimecast-MFC-AGG-ID: 9hVuChQdM_m5a9ZsPwmIag_1774143902
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B7C9180034F;
	Sun, 22 Mar 2026 01:45:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6E5B300019F;
	Sun, 22 Mar 2026 01:44:48 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv7 02/13] kexec_file: Use bpf-prog to decompose image
Date: Sun, 22 Mar 2026 09:43:51 +0800
Message-ID: <20260322014402.8815-3-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

As UEFI becomes popular, a few architectures support to boot a PE format
kernel image directly. But the internal of PE format varies, which means
each parser for each format.

This patch (with the rest in this series) introduces a common skeleton
to all parsers, and leave the format parsing in
bpf-prog, so the kernel code can keep relative stable.

History, the syscall
SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
                unsigned long, cmdline_len, const char __user *, cmdline_ptr,
                unsigned long, flags)
complies with the kernel protocol: bootable kernel, initramfs, cmdline.

But the occurrence of UKI images challenges the traditional model. The
image itself contains the kernel, initrd, and cmdline. To be compatible
with both the old and new models, kexec_file_load can be reorganized into
two stages. In the first stage, "decompose_kexec_image()" breaks down the
passed-in image into the components required by the kernel boot protocol.
In the second stage, the traditional image loader
"arch_kexec_kernel_image_load()" prepares the switch to the next kernel.

During the decomposition stage, the decomposition process can be nested.
In each sub-process, BPF bytecode is extracted from the '.bpf' section
to parse the current PE file. If the data section in the PE file contains
another PE file, the sub-process is repeated. This is designed to handle
the zboot format embedded in UKI format on the arm64 platform.

There are some placeholder functions in this patch. (They will take effect
after the introduction of kexec BPF light skeleton and BPF helpers.)

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/Kconfig.kexec      |   8 +
 kernel/Makefile           |   1 +
 kernel/kexec_bpf_loader.c | 472 ++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c       |  43 +++-
 kernel/kexec_internal.h   |   4 +
 5 files changed, 517 insertions(+), 11 deletions(-)
 create mode 100644 kernel/kexec_bpf_loader.c

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf71..0c5d619820bcd 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -46,6 +46,14 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by kexec system call.
 
+config KEXEC_BPF
+	bool "Enable bpf-prog to parse the kexec image"
+	depends on KEXEC_FILE
+	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	help
+	  This is a feature to run bpf section inside a kexec image file, which
+	  parses the image properly and help kernel set up kexec boot protocol
+
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on ARCH_SUPPORTS_KEXEC_SIG
diff --git a/kernel/Makefile b/kernel/Makefile
index 6785982013dce..9e17ad2a44b6f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KEXEC_BPF) += kexec_bpf_loader.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
new file mode 100644
index 0000000000000..bd1800a767824
--- /dev/null
+++ b/kernel/kexec_bpf_loader.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec image bpf section helpers
+ *
+ * Copyright (C) 2025, 2026 Red Hat, Inc
+ */
+
+#define pr_fmt(fmt) "kexec_file(Image): " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/kexec.h>
+#include <linux/ima.h>
+#include <linux/elf.h>
+#include <linux/string.h>
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <asm/byteorder.h>
+#include <asm/image.h>
+#include <asm/memory.h>
+#include "kexec_internal.h"
+
+/* Load a ELF */
+static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
+{
+	return -1;
+}
+
+static void disarm_bpf_prog(void)
+{
+}
+
+#define MAX_PARSING_BUF_NUM    16
+
+struct kexec_context {
+	bool kdump;
+	bool parsed;
+	char *parsing_buf[MAX_PARSING_BUF_NUM];
+	unsigned long parsing_buf_sz[MAX_PARSING_BUF_NUM];
+
+	char *kernel;
+	unsigned long kernel_sz;
+	char *initrd;
+	unsigned long initrd_sz;
+	char *cmdline;
+	unsigned long cmdline_sz;
+};
+
+void kexec_image_parser_anchor(struct kexec_context *context,
+			       unsigned long parser_id);
+
+void noinline __used kexec_image_parser_anchor(struct kexec_context *context,
+					       unsigned long parser_id)
+{
+	barrier();
+}
+
+BTF_KFUNCS_START(kexec_modify_return_ids)
+BTF_ID_FLAGS(func, kexec_image_parser_anchor, KF_SLEEPABLE)
+BTF_KFUNCS_END(kexec_modify_return_ids)
+
+static const struct btf_kfunc_id_set kexec_modify_return_set = {
+	.owner = THIS_MODULE,
+	.set = &kexec_modify_return_ids,
+};
+
+static int __init kexec_bpf_prog_run_init(void)
+{
+	return register_btf_fmodret_id_set(&kexec_modify_return_set);
+}
+late_initcall(kexec_bpf_prog_run_init);
+
+static int kexec_buff_parser(struct bpf_parser_context *parser)
+{
+	return 0;
+}
+
+#define KEXEC_ELF_BPF_PREFIX		".bpf."
+#define KEXEC_ELF_BPF_NESTED		".bpf.nested"
+#define KEXEC_ELF_BPF_MAX_IDX		8
+#define KEXEC_ELF_BPF_MAX_DEPTH		4
+
+static bool is_elf_image(const char *buf, size_t sz)
+{
+	if (sz < SELFMAG)
+		return false;
+
+	return memcmp(buf, ELFMAG, SELFMAG) == 0;
+}
+
+/*
+ * elf_get_shstrtab - resolve the section-name string table of an ELF image
+ * @buf:       ELF image buffer
+ * @sz:        buffer length
+ * @ehdr_out:  receives a pointer to the ELF header inside @buf
+ * @shdrs_out: receives a pointer to the section-header table inside @buf
+ * @shstrtab_out: receives a pointer to the section-name string table
+ *
+ * All output pointers are interior pointers into @buf; callers must not
+ * free them independently.
+ *
+ * Returns 0 on success, -EINVAL if any structural check fails.
+ */
+static int elf_get_shstrtab(const char *buf, size_t sz,
+			    const Elf64_Ehdr **ehdr_out,
+			    const Elf64_Shdr **shdrs_out,
+			    const char **shstrtab_out)
+{
+	const Elf64_Ehdr *ehdr;
+	const Elf64_Shdr *shdrs;
+	const Elf64_Shdr *shstr_shdr;
+
+	if (sz < sizeof(*ehdr))
+		return -EINVAL;
+
+	ehdr = (const Elf64_Ehdr *)buf;
+
+	if (ehdr->e_shoff == 0 || ehdr->e_shnum == 0)
+		return -EINVAL;
+
+	if (ehdr->e_shstrndx >= ehdr->e_shnum)
+		return -EINVAL;
+
+	/* section-header table must fit inside the buffer */
+	if (ehdr->e_shoff > sz ||
+	    ehdr->e_shnum > (sz - ehdr->e_shoff) / sizeof(Elf64_Shdr))
+		return -EINVAL;
+
+	shdrs = (const Elf64_Shdr *)(buf + ehdr->e_shoff);
+	shstr_shdr = &shdrs[ehdr->e_shstrndx];
+
+	/* string table itself must fit inside the buffer */
+	if (shstr_shdr->sh_offset > sz ||
+	    shstr_shdr->sh_size > sz - shstr_shdr->sh_offset)
+		return -EINVAL;
+
+	*ehdr_out     = ehdr;
+	*shdrs_out    = shdrs;
+	*shstrtab_out = buf + shstr_shdr->sh_offset;
+
+	return 0;
+}
+
+/*
+ * validate_elf_bpf_sections - enforce the section-naming contract
+ * @buf: ELF image buffer
+ * @sz:  buffer length
+ *
+ * Every section other than the null entry (index 0) and ".shstrtab" must
+ * be named either ".bpf.N" (N in 1..KEXEC_ELF_BPF_MAX_IDX, no gaps, no
+ * duplicates) or ".bpf.nested" (at most once).  Any other name, any
+ * duplicate, or a gap in the numeric sequence is an error.
+ *
+ * Returns 0 if the ELF passes all checks, -EINVAL otherwise.
+ */
+static int validate_elf_bpf_sections(const char *buf, size_t sz)
+{
+	const Elf64_Ehdr *ehdr;
+	const Elf64_Shdr *shdrs;
+	const Elf64_Shdr *shstr_shdr;
+	const char *shstrtab;
+	bool seen[KEXEC_ELF_BPF_MAX_IDX + 1] = {};
+	bool seen_nested = false;
+	int max_idx = 0;
+	int ret;
+	int i;
+
+	if (!is_elf_image(buf, sz))
+		return -EINVAL;
+
+	ret = elf_get_shstrtab(buf, sz, &ehdr, &shdrs, &shstrtab);
+	if (ret)
+		return ret;
+
+	shstr_shdr = &shdrs[ehdr->e_shstrndx];
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		const char *name;
+		const char *num_str;
+		int idx;
+
+		if (shdrs[i].sh_name >= shstr_shdr->sh_size)
+			return -EINVAL;
+
+		name = shstrtab + shdrs[i].sh_name;
+
+		/* structural ELF sections: null entry and section-name table */
+		if (name[0] == '\0' || strcmp(name, ".shstrtab") == 0)
+			continue;
+
+		/* .bpf.nested must appear at most once */
+		if (strcmp(name, KEXEC_ELF_BPF_NESTED) == 0) {
+			if (seen_nested) {
+				pr_err("kexec: duplicate .bpf.nested section\n");
+				return -EINVAL;
+			}
+			seen_nested = true;
+			continue;
+		}
+
+		/* every remaining section must start with the ".bpf." prefix */
+		if (strncmp(name, KEXEC_ELF_BPF_PREFIX,
+			    sizeof(KEXEC_ELF_BPF_PREFIX) - 1) != 0) {
+			pr_err("kexec: invalid ELF section name: %s\n", name);
+			return -EINVAL;
+		}
+
+		/*
+		 * Suffix must be exactly one digit in [1, KEXEC_ELF_BPF_MAX_IDX].
+		 * Multi-digit numbers and leading zeros are rejected.
+		 */
+		num_str = name + sizeof(KEXEC_ELF_BPF_PREFIX) - 1;
+		if (num_str[0] < '1' ||
+		    num_str[0] > '0' + KEXEC_ELF_BPF_MAX_IDX ||
+		    num_str[1] != '\0') {
+			pr_err("kexec: invalid BPF section index in: %s\n", name);
+			return -EINVAL;
+		}
+
+		idx = num_str[0] - '0';
+		if (seen[idx]) {
+			pr_err("kexec: duplicate BPF section: %s\n", name);
+			return -EINVAL;
+		}
+		seen[idx] = true;
+		if (idx > max_idx)
+			max_idx = idx;
+	}
+
+	/* indices must be consecutive starting from 1 */
+	for (i = 1; i <= max_idx; i++) {
+		if (!seen[i]) {
+			pr_err("kexec: missing .bpf.%d section\n", i);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * elf_find_section - locate a named section in an ELF image
+ * @buf:     ELF image buffer
+ * @sz:      buffer length
+ * @name:    section name to find
+ * @out_buf: receives a pointer to the section data (NULL if not found)
+ * @out_sz:  receives the section size in bytes (0 if not found)
+ *
+ * Returns 0 on success (including the "not found" case), -EINVAL on a
+ * structural error.
+ */
+static int elf_find_section(const char *buf, size_t sz, const char *name,
+			    char **out_buf, size_t *out_sz)
+{
+	const Elf64_Ehdr *ehdr;
+	const Elf64_Shdr *shdrs;
+	const Elf64_Shdr *shstr_shdr;
+	const char *shstrtab;
+	int ret;
+	int i;
+
+	ret = elf_get_shstrtab(buf, sz, &ehdr, &shdrs, &shstrtab);
+	if (ret)
+		return ret;
+
+	shstr_shdr = &shdrs[ehdr->e_shstrndx];
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (shdrs[i].sh_name >= shstr_shdr->sh_size)
+			return -EINVAL;
+
+		if (strcmp(shstrtab + shdrs[i].sh_name, name) != 0)
+			continue;
+
+		/* section data must be within the buffer */
+		if (shdrs[i].sh_offset > sz ||
+		    shdrs[i].sh_size > sz - shdrs[i].sh_offset)
+			return -EINVAL;
+
+		*out_buf = (char *)(buf + shdrs[i].sh_offset);
+		*out_sz  = shdrs[i].sh_size;
+		return 0;
+	}
+
+	*out_buf = NULL;
+	*out_sz  = 0;
+	return 0;
+}
+
+/*
+ * process_bpf_parsers_container - recursively process an ELF container, which holds a
+ * batch of bpf parsers
+ *
+ * @elf_buf: ELF image buffer at this level
+ * @elf_sz:  buffer length
+ * @context: shared kexec parsing context
+ * @depth:   current recursion depth (call with 1 for the top level)
+ *
+ *   1. a valid section names should be .bpf.1, .bpf.2, ... in order.
+ *      They are different parser for the current layer.
+ *   2. Only a .bpf.nested section is allowed for the internal level.
+ *   3. At each level, stop trying at the first attempt where context->parsed becomes
+ *      true, then try to load .bpf.nested to parse the internal layer
+ *
+ * Returns 0 on success, -EINVAL on any error.
+ */
+static int process_bpf_parsers_container(const char *elf_buf, size_t elf_sz,
+				   struct kexec_context *context, int depth)
+{
+	struct bpf_parser_context *bpf;
+	char *section_buf, *nested_buf;
+	size_t section_sz;
+	size_t nested_sz;
+	/* .bpf.1 etc */
+	char section_name[sizeof(KEXEC_ELF_BPF_PREFIX) + 1];
+	bool found = false;
+	int ret;
+	int i;
+
+	if (depth > KEXEC_ELF_BPF_MAX_DEPTH) {
+		pr_err("kexec: ELF BPF nesting depth exceeds %d\n",
+		       KEXEC_ELF_BPF_MAX_DEPTH);
+		return -EINVAL;
+	}
+
+	ret = validate_elf_bpf_sections(elf_buf, elf_sz);
+	if (ret)
+		return ret;
+
+	for (i = 1; i <= KEXEC_ELF_BPF_MAX_IDX && !found; i++) {
+		snprintf(section_name, sizeof(section_name), ".bpf.%d", i);
+
+		ret = elf_find_section(elf_buf, elf_sz, section_name,
+				       &section_buf, &section_sz);
+		if (ret)
+			return ret;
+
+		/* no section at this index means the sequence is exhausted */
+		if (!section_buf)
+			break;
+
+		bpf = alloc_bpf_parser_context(kexec_buff_parser, context);
+		if (!bpf)
+			return -ENOMEM;
+
+		ret = arm_bpf_prog(section_buf, section_sz);
+		if (ret) {
+			/* arm failed: no disarm needed, try next index */
+			put_bpf_parser_context(bpf);
+			pr_info("kexec: arm_bpf_prog failed for %s (depth %d), trying next\n",
+				 section_name, depth);
+			continue;
+		}
+
+		/*
+		 * Give the BPF prog a clean slate so context->parsed reliably
+		 * reflects whether *this* invocation succeeded.
+		 */
+		context->parsed = false;
+		/* This is the hook point for bpf-prog */
+		kexec_image_parser_anchor(context, (unsigned long)bpf);
+		disarm_bpf_prog();
+
+		/* Free the old parsing context, and reload the new */
+		for (int i = 0; i < MAX_PARSING_BUF_NUM; i++) {
+			if (!!context->parsing_buf[i])
+				break;
+			vfree(context->parsing_buf[i]);
+			context->parsing_buf[i] = NULL;
+			context->parsing_buf_sz[i] = 0;
+		}
+
+		put_bpf_parser_context(bpf);
+		/* If the bpf-prog success, it flags by KEXEC_BPF_CMD_DONE */
+		if (context->parsed)
+			found = true;
+	}
+
+	if (!found) {
+		pr_err("kexec: no BPF section succeeded at depth %d\n", depth);
+		return -EINVAL;
+	}
+
+	/*
+	 * A numbered section succeeded.  If .bpf.nested is present, the
+	 * current context->kernel may still be in a container format that
+	 * the next level of BPF progs knows how to unpack.
+	 */
+	ret = elf_find_section(elf_buf, elf_sz, KEXEC_ELF_BPF_NESTED,
+			       &nested_buf, &nested_sz);
+	if (ret)
+		return ret;
+
+	if (!nested_buf)
+		return 0;
+
+	context->parsed = false;
+	return process_bpf_parsers_container(nested_buf, nested_sz, context,
+				       depth + 1);
+}
+
+int decompose_kexec_image(struct kimage *image, int extended_fd)
+{
+	struct kexec_context ctx = { 0 };
+	unsigned long parser_sz;
+	char *parser_start;
+	int ret = -EINVAL;
+
+	if (extended_fd < 0)
+		return ret;
+
+	if (image->type != KEXEC_TYPE_CRASH)
+		ctx.kdump = false;
+	else
+		ctx.kdump = true;
+
+	parser_start = image->kernel_buf;
+	parser_sz = image->kernel_buf_len;
+
+	if (!validate_elf_bpf_sections(parser_start, parser_sz)) {
+
+		ret = kernel_read_file_from_fd(extended_fd,
+						0,
+						(void **)&ctx.parsing_buf[0],
+						KEXEC_FILE_SIZE_MAX,
+						NULL,
+						0);
+		if (ret < 0) {
+			pr_err("Fail to read image container\n");
+			return -EINVAL;
+		}
+		ctx.parsing_buf_sz[0] = ret;
+		ret = process_bpf_parsers_container(parser_start, parser_sz, &ctx, 0);
+		if (!ret) {
+			char *p;
+
+			/* Envelop should hold valid kernel, initrd, cmdline sections */
+			if (!ctx.kernel || !ctx.initrd || !ctx.cmdline) {
+				vfree(ctx.kernel);
+				vfree(ctx.initrd);
+				vfree(ctx.cmdline);
+				return -EINVAL;
+			}
+			/*
+			 * kimage_file_post_load_cleanup() calls kfree() to free
+			 * cmdline
+			 */
+			p = kmalloc(ctx.cmdline_sz, GFP_KERNEL);
+			if (!p) {
+				vfree(ctx.kernel);
+				vfree(ctx.initrd);
+				vfree(ctx.cmdline);
+				return -ENOMEM;
+			}
+			vfree(image->kernel_buf);
+			image->kernel_buf = ctx.kernel;
+			image->kernel_buf_len = ctx.kernel_sz;
+			image->initrd_buf = ctx.initrd;
+			image->initrd_buf_len = ctx.initrd_sz;
+			memcpy(p, ctx.cmdline, ctx.cmdline_sz);
+			image->cmdline_buf = p;
+			image->cmdline_buf_len = ctx.cmdline_sz;
+			vfree(ctx.cmdline);
+		}
+		return ret;
+	}
+
+	return -EINVAL;
+}
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2bfbb2d144e69..aca265034b4ed 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -55,9 +55,6 @@ static bool check_ima_segment_index(struct kimage *image, int i)
 
 static int kexec_calculate_store_digests(struct kimage *image);
 
-/* Maximum size in bytes for kernel/initrd files. */
-#define KEXEC_FILE_SIZE_MAX	min_t(s64, 4LL << 30, SSIZE_MAX)
-
 /*
  * Currently this is the only default function that is exported as some
  * architectures need it to do additional handlings.
@@ -221,6 +218,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 {
 	ssize_t ret;
 	void *ldata;
+	bool envelop = false;
 
 	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
 				       KEXEC_FILE_SIZE_MAX, NULL,
@@ -231,20 +229,40 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	kexec_dprintk("kernel: %p kernel_size: %#lx\n",
 		      image->kernel_buf, image->kernel_buf_len);
 
-	/* Call arch image probe handlers */
+	if (IS_ENABLED(CONFIG_KEXEC_BPF)) {
+		/* Fill up image's kernel_buf, initrd_buf, cmdline_buf */
+		ret = decompose_kexec_image(image, initrd_fd);
+		switch (ret) {
+		case 0:
+			envelop = true;
+			break;
+		/* Valid format, but fail to parse */
+		case -EINVAL:
+			break;
+		default:
+			goto out;
+		}
+	}
+
+	/*
+	 * From this point, the kexec subsystem handle the kernel boot protocol.
+	 *
+	 * Call arch image probe handlers
+	 */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
 	if (ret)
 		goto out;
 
 #ifdef CONFIG_KEXEC_SIG
-	ret = kimage_validate_signature(image);
-
-	if (ret)
-		goto out;
+	if (!envelop) {
+		ret = kimage_validate_signature(image);
+		if (ret)
+			goto out;
+	}
 #endif
 	/* It is possible that there no initramfs is being loaded */
-	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
+	if (!(flags & KEXEC_FILE_NO_INITRAMFS) && !envelop) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
 					       KEXEC_FILE_SIZE_MAX, NULL,
 					       READING_KEXEC_INITRAMFS);
@@ -257,7 +275,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	image->no_cma = !!(flags & KEXEC_FILE_NO_CMA);
 	image->force_dtb = flags & KEXEC_FILE_FORCE_DTB;
 
-	if (cmdline_len) {
+	/* For envelop case, the cmdline should be passed in as a section */
+	if (cmdline_len && !envelop) {
 		image->cmdline_buf = memdup_user(cmdline_ptr, cmdline_len);
 		if (IS_ERR(image->cmdline_buf)) {
 			ret = PTR_ERR(image->cmdline_buf);
@@ -273,9 +292,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
+	}
+
+	if (image->cmdline_buf)
 		ima_kexec_cmdline(kernel_fd, image->cmdline_buf,
 				  image->cmdline_buf_len - 1);
-	}
 
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 228bb88c018bc..731ff02110b3c 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -33,9 +33,13 @@ static inline void kexec_unlock(void)
 
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
+
+/* Maximum size in bytes for kernel/initrd files. */
+#define KEXEC_FILE_SIZE_MAX	min_t(s64, 4LL << 30, SSIZE_MAX)
 void kimage_file_post_load_cleanup(struct kimage *image);
 extern char kexec_purgatory[];
 extern size_t kexec_purgatory_size;
+extern int decompose_kexec_image(struct kimage *image, int extended_fd);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
 #endif /* CONFIG_KEXEC_FILE */
-- 
2.49.0

