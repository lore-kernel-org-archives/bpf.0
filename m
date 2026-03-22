Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE42BCF45
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774144031; cv=none; b=VhS9KZT0VY8trd8GEpR9Vn7VfzmEPoFOM5xjDne2MAyxo3cM0+wa/i6M2JSEkMltR0mxFTGfjyLZ98yC1q6hNo8dy1eCSmeuygyMpfkKKVBRNeXZBnXgIhFg71HiQX7eJA+MkNIsWN6103r3RxxnqEClVW+f61OhoU+bEiLLkaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774144031; c=relaxed/simple;
	bh=847v99Xg8escEA9StT0Cvn7kNsbxecQGSWfm3Mvaplg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhFAb1FVq3ULkiaNaBu4uBsChU02wtEM3xP1pdzxBjGeewEWJjR8DVuxDVn/RGnWudGS2RiSn23JdfFFcvt7BF2rNPTHlVW2aaPX2cQK8YdLbBwzj38rWPh4vyeDdB5q5or9ZPiZnfVAoOxJ9Yg993BH1c2DQUmGLGpAOrghbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1Mqa8sf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1Mqa8sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774144028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PptI0EZ3v1cDZRQzhYiPLVw5pozAx5EwgN2XH6wjJnI=;
	b=X1Mqa8sfmln/y0f8alRzqz7eSjCSVq1gJ4/7Ez/JfT/XLUuC5zf1E0hKk9WYB6tamYUSDi
	pLPoWOn0yWFz/XdCTU0ImS3JYIVgxtl2hQpUQD2h+P1LusOvjdua2CNvIK7WCRBpq/Avig
	Wi7VfB5oSeiZpMg/VXPkqitTbwWsWII=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-6FAuPjxBNuuEhuC8Jl-sDQ-1; Sat,
 21 Mar 2026 21:47:03 -0400
X-MC-Unique: 6FAuPjxBNuuEhuC8Jl-sDQ-1
X-Mimecast-MFC-AGG-ID: 6FAuPjxBNuuEhuC8Jl-sDQ_1774144021
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B0751955D84;
	Sun, 22 Mar 2026 01:47:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18A7130001A2;
	Sun, 22 Mar 2026 01:46:46 +0000 (UTC)
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
Subject: [PATCHv7 11/13] tools/kexec: Introduce a bpf-prog to handle zboot image
Date: Sun, 22 Mar 2026 09:44:00 +0800
Message-ID: <20260322014402.8815-12-piliu@redhat.com>
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

This BPF program aligns with the convention defined in the kernel file
kexec_pe_parser_bpf.lskel.h. This can be easily achieved by include
"template.c", which includes:
    four maps:
                    struct bpf_map_desc ringbuf_1;
                    struct bpf_map_desc ringbuf_2;
                    struct bpf_map_desc ringbuf_3;
                    struct bpf_map_desc ringbuf_4;
    four sections:
                    struct bpf_map_desc rodata;
                    struct bpf_map_desc data;
                    struct bpf_map_desc bss;
                    struct bpf_map_desc rodata_str1_1;

The only left thing is to implement a prog
SEC("fentry.s/kexec_image_parser_anchor")
int BPF_PROG(parse_pe, struct kexec_context *context, unsigned long parser_id)

This bpf-prog can handle two kinds of formats:
-1. vmlinuz.efi, the zboot format, it can be derived from UKI's .linux
section.
-2. an envelop format, which is a ELF file holding three key sections:
.kernel, .initrd, .cmdline.

This BPF program only uses ringbuf_1, so it minimizes the size of the
other three ringbufs to one byte.  The size of ringbuf_1 is derived from
the combined size of vmlinuz.efi, initramfs, and cmdline, which
typically totals less than 128MB.  With the help of the BPF kfunc
bpf_buffer_parser(), the BPF program passes instructions to the kexec
BPF component to perform the appropriate actions.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 tools/kexec/Makefile           | 162 +++++++++++++++
 tools/kexec/template.c         |  72 +++++++
 tools/kexec/zboot_parser_bpf.c | 347 +++++++++++++++++++++++++++++++++
 3 files changed, 581 insertions(+)
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/template.c
 create mode 100644 tools/kexec/zboot_parser_bpf.c

diff --git a/tools/kexec/Makefile b/tools/kexec/Makefile
new file mode 100644
index 0000000000000..a404a1453c888
--- /dev/null
+++ b/tools/kexec/Makefile
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Ensure Kbuild variables are available
+include ../scripts/Makefile.include
+
+srctree := $(patsubst %/tools/kexec,%,$(CURDIR))
+VMLINUX = $(srctree)/vmlinux
+TOOLSDIR := $(srctree)/tools
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+ARCH ?= $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/ -e s/riscv64/riscv/ -e s/loongarch.*/loongarch/)
+# At present, zboot image format is used by arm64, riscv, loongarch
+# And arch/$(ARCH)/boot/vmlinux.bin is the uncompressed file instead of arch/$(ARCH)/boot/Image
+ifeq ($(ARCH),$(filter $(ARCH),arm64 riscv loongarch))
+	EFI_IMAGE := $(srctree)/arch/$(ARCH)/boot/vmlinuz.efi
+	KERNEL_IMAGE := $(srctree)/arch/$(ARCH)/boot/vmlinux.bin
+else
+	@echo "Unsupported architecture: $(ARCH)"
+	@exit 1
+endif
+
+CC = clang
+CFLAGS = -O2
+BPF_PROG_CFLAGS = -g -fno-merge-all-constants -O2 -target bpf -Wall -I $(BPFDIR) -I .
+BPFTOOL = bpftool
+
+# ---------------------------------------------------------------------------
+# Shared generated headers (common to all targets)
+# ---------------------------------------------------------------------------
+HEADERS = vmlinux.h bpf_helper_defs.h image_size.h
+
+# ---------------------------------------------------------------------------
+# Per-target artifact lists
+# To add a new target (e.g. uki), append to BPF_TARGETS and define a
+# <name>: phony rule below.  All build rules are driven by pattern rules
+# and require no further changes.
+#
+# Artifacts produced per prefix <P>:
+#   <P>_parser_bpf.o       - compiled BPF object
+#   <P>_parser_bpf.lskel.h - light skeleton header
+#   <P>_bytecode.c         - extracted opts_data / opts_insn arrays
+#   <P>_bytecode.o         - compiled bytecode object
+#   <P>.bpf                - final ELF wrapper with .bpf.1 section
+# ---------------------------------------------------------------------------
+BPF_TARGETS = zboot
+
+define BPF_ARTIFACTS
+$(1)_parser_bpf.o $(1)_parser_bpf.lskel.h $(1)_bytecode.c $(1)_bytecode.o $(1).bpf
+endef
+
+ALL_BPF_ARTIFACTS = $(foreach t,$(BPF_TARGETS),$(call BPF_ARTIFACTS,$(t)))
+
+# ---------------------------------------------------------------------------
+# Top-level phony targets
+# ---------------------------------------------------------------------------
+zboot: $(HEADERS) $(call BPF_ARTIFACTS,zboot) build_zboot_image
+
+.PHONY: zboot clean
+
+# ---------------------------------------------------------------------------
+# Shared header rules
+# ---------------------------------------------------------------------------
+
+# Rule to generate vmlinux.h from vmlinux
+vmlinux.h: $(VMLINUX)
+	@command -v $(BPFTOOL) >/dev/null 2>&1 || { echo >&2 "$(BPFTOOL) is required but not found. Please install it."; exit 1; }
+	@$(BPFTOOL) btf dump file $(VMLINUX) format c > vmlinux.h
+
+bpf_helper_defs.h: $(srctree)/tools/include/uapi/linux/bpf.h
+	@$(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
+		--file $(srctree)/tools/include/uapi/linux/bpf.h > bpf_helper_defs.h
+
+# Default estimated size for initramfs (can be overridden by user)
+INITRD_ESTIMATE_SIZE ?= 67108864   # 64MB
+
+# In worst case, this image includes vmlinuz.efi, initramfs and cmdline
+image_size.h: $(KERNEL_IMAGE)
+	@{ \
+		if [ ! -f "$(KERNEL_IMAGE)" ]; then \
+			echo "Error: File '$(KERNEL_IMAGE)' does not exist"; \
+			exit 1; \
+		fi; \
+		KERNEL_SIZE=$$(stat -c '%s' "$(KERNEL_IMAGE)" 2>/dev/null); \
+		ELF_OVERHEAD=4096; \
+		TOTAL_SIZE=$$((KERNEL_SIZE + $(INITRD_ESTIMATE_SIZE) + ELF_OVERHEAD)); \
+		POWER=4096; \
+		while [ $$POWER -le $$TOTAL_SIZE ]; do \
+			POWER=$$((POWER * 2)); \
+		done; \
+		RINGBUF_SIZE=$$POWER; \
+		echo "#define IMAGE_SIZE_POWER2_ALIGN $$RINGBUF_SIZE" > $@; \
+		echo "#define IMAGE_SIZE $$TOTAL_SIZE" >> $@; \
+		echo "#define KERNEL_SIZE $$KERNEL_SIZE" >> $@; \
+		echo "#define INITRD_SIZE $(INITRD_ESTIMATE_SIZE)" >> $@; \
+	}
+
+# ---------------------------------------------------------------------------
+# Pattern rules: BPF build pipeline
+# All rules below are prefix-agnostic; % matches zboot, uki, etc.
+# ---------------------------------------------------------------------------
+
+%_parser_bpf.o: %_parser_bpf.c vmlinux.h bpf_helper_defs.h
+	@$(CC) $(BPF_PROG_CFLAGS) -c $< -o $@
+
+%_parser_bpf.lskel.h: %_parser_bpf.o
+	@$(BPFTOOL) gen skeleton -L $< > $@
+
+# Extract opts_data[] and opts_insn[] arrays from the skeleton header,
+# stripping 'static' so the symbols are not optimized away by the compiler.
+# This rule is intentionally generic: all parsers expose the same symbol names.
+%_bytecode.c: %_parser_bpf.lskel.h
+	@sed -n '/static const char opts_data\[\]/,/;/p' $< | sed 's/static const/const/' > $@
+	@sed -n '/static const char opts_insn\[\]/,/;/p' $< | sed 's/static const/const/' >> $@
+
+%_bytecode.o: %_bytecode.c
+	@$(CC) $(CFLAGS) -c $< -o $@
+
+
+# Wrap the bytecode ELF object into a new ELF container as section .bpf.1
+# ---------------------------------------------------------------------------
+# Per-target BPF section definitions
+# Format: space-separated "sectionname:sourcefile" pairs
+# ---------------------------------------------------------------------------
+ZBOOT_BPF_MAPS := .bpf.1:zboot_bytecode.o
+
+# ---------------------------------------------------------------------------
+# Helpers to build objcopy flags from a BPF_MAPS list
+# ---------------------------------------------------------------------------
+section_name       = $(firstword $(subst :, ,$(1)))
+source_file        = $(lastword  $(subst :, ,$(1)))
+
+only_section_flags = $(foreach m,$(1),--only-section=$(call section_name,$(m)))
+
+# ---------------------------------------------------------------------------
+# Template: generates the %.bpf rule for a given target
+# $(1) = lowercase target name, e.g. zboot
+# $(2) = UPPER prefix for _BPF_MAPS variable, e.g. ZBOOT
+#
+# Sections are added one at a time in the order defined in $(2)_BPF_MAPS.
+# objcopy does not guarantee section order when all --add-section flags are
+# given in a single invocation, so we chain N calls through a .work.o file
+# to preserve the declared order.
+# ---------------------------------------------------------------------------
+define BPF_WRAPPER_RULE
+$(1).bpf: $(foreach m,$($(2)_BPF_MAPS),$(call source_file,$(m)))
+	@echo '' | $(CC) -x c - -c -o $$@.work.o
+	$(foreach m,$($(2)_BPF_MAPS),\
+	@objcopy --add-section $(call section_name,$(m))=$(call source_file,$(m)) \
+	         --set-section-flags $(call section_name,$(m))=readonly,data \
+	         $$@.work.o $$@.next.o && mv $$@.next.o $$@.work.o
+	)
+	@objcopy $(call only_section_flags,$($(2)_BPF_MAPS)) $$@.work.o $$@
+	@rm -f $$@.work.o
+endef
+
+$(eval $(call BPF_WRAPPER_RULE,zboot,ZBOOT))
+
+# ---------------------------------------------------------------------------
+# Clean
+# ---------------------------------------------------------------------------
+clean:
+	@rm -f $(HEADERS) $(ALL_BPF_ARTIFACTS) *.base.o
diff --git a/tools/kexec/template.c b/tools/kexec/template.c
new file mode 100644
index 0000000000000..7f1557cb38223
--- /dev/null
+++ b/tools/kexec/template.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2026 Red Hat, Inc
+//
+// Original file: kernel/kexec_bpf/template.c
+//
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+
+/* Mark the bpf parser success */
+#define KEXEC_BPF_CMD_DONE		0x1
+#define KEXEC_BPF_CMD_DECOMPRESS	0x2
+#define KEXEC_BPF_CMD_COPY		0x3
+#define KEXEC_BPF_CMD_VERIFY_SIG	0x4
+
+#define KEXEC_BPF_SUBCMD_KERNEL		0x1
+#define KEXEC_BPF_SUBCMD_INITRD		0x2
+#define KEXEC_BPF_SUBCMD_CMDLINE	0x3
+
+#define KEXEC_BPF_PIPELINE_FILL		0x1
+
+/*
+ * The ringbufs can have different capacity. But only four ringbuf are provided.
+ */
+#ifndef RINGBUF1_SIZE
+#define RINGBUF1_SIZE	4
+#endif
+#ifndef RINGBUF2_SIZE
+#define RINGBUF2_SIZE	4
+#endif
+#ifndef RINGBUF3_SIZE
+#define RINGBUF3_SIZE	4
+#endif
+#ifndef RINGBUF4_SIZE
+#define RINGBUF4_SIZE	4
+#endif
+
+/* ringbuf is safe since the user space has no write access to them */
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF1_SIZE);
+} ringbuf_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF2_SIZE);
+} ringbuf_2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF3_SIZE);
+} ringbuf_3 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF4_SIZE);
+} ringbuf_4 SEC(".maps");
+
+char LICENSE[] SEC("license") = "GPL";
+
+/*
+ * This function ensures that the sections .rodata, .data, .rodata.str1.1 and .bss
+ * are created for a bpf prog.
+ */
+static const char dummy_rodata[16] __attribute__((used)) = "rodata";
+static char dummy_data[16] __attribute__((used)) = "data";
+static char *dummy_mergeable_str  __attribute__((used)) = ".rodata.str1.1";
+static char dummy_bss[16] __attribute__((used));
+
diff --git a/tools/kexec/zboot_parser_bpf.c b/tools/kexec/zboot_parser_bpf.c
new file mode 100644
index 0000000000000..10098dca2a27a
--- /dev/null
+++ b/tools/kexec/zboot_parser_bpf.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2025, 2026 Red Hat, Inc
+//
+#include "vmlinux.h"
+#include <bpf_helpers.h>
+#include <bpf_tracing.h>
+#include "image_size.h"
+
+/* ringbuf 2,3,4 are useless */
+#define MIN_BUF_SIZE    1
+#define MAX_RECORD_SIZE (IMAGE_SIZE + 40960)
+#define RINGBUF1_SIZE   IMAGE_SIZE_POWER2_ALIGN
+#define RINGBUF2_SIZE   MIN_BUF_SIZE
+#define RINGBUF3_SIZE   MIN_BUF_SIZE
+#define RINGBUF4_SIZE   MIN_BUF_SIZE
+
+#include "template.c"
+
+#define ELF_SCAN_MAX 8
+
+/* SHN_UNDEF is a uapi macro not exported via BTF/vmlinux.h */
+#ifndef SHN_UNDEF
+#define SHN_UNDEF 0
+#endif
+
+#ifndef EIO
+#define EIO 5
+#endif
+#ifndef EINVAL
+#define EINVAL 22
+#endif
+
+/* see drivers/firmware/efi/libstub/zboot-header.S */
+struct linux_pe_zboot_header {
+	unsigned int mz_magic;
+	char image_type[4];
+	unsigned int payload_offset;
+	unsigned int payload_size;
+	unsigned int reserved[2];
+	char comp_type[4];
+	unsigned int linux_pe_magic;
+	unsigned int pe_header_offset;
+} __attribute__((packed));
+
+static const char linux_sect_name[]   = ".kernel";
+static const char initrd_sect_name[]   = ".initrd";
+static const char cmdline_sect_name[]   = ".cmdline";
+
+/*
+ * fill_cmd - overwrite the cmd_hdr at the start of @buf and copy @data_len
+ *            bytes from @src into the payload area.
+ *
+ * num_chunks is reserved for future use and always set to 0.
+ * payload_len directly describes the raw data length.
+ *
+ * Returns the total byte count to pass to bpf_buffer_parser().
+ */
+static int fill_cmd(char *buf, __u16 cmd, __u16 subcmd,
+				    const char *src, __u32 data_len)
+{
+	struct cmd_hdr *hdr;
+	char *payload;
+
+	hdr              = (struct cmd_hdr *)buf;
+	hdr->cmd         = cmd;
+	hdr->subcmd      = subcmd;
+	hdr->payload_len = data_len;
+	hdr->num_chunks  = 0;
+
+	payload = (char *)(hdr + 1);
+	/* Only cmd, no payload */
+	if (!src || !data_len)
+		return sizeof(*hdr);
+	if (data_len > MAX_RECORD_SIZE - sizeof(struct cmd_hdr))
+		return 0;
+	bpf_probe_read_kernel(payload, data_len, src);
+
+	return sizeof(*hdr) + data_len;
+}
+
+/*
+ * do_zboot_decompress - verify (if required) and decompress an arm64 zboot
+ *                       PE image.
+ *
+ * @ringbuf:      preallocated ringbuf to use for commands
+ * @pe_buf:       pointer to the start of the PE blob
+ * @pe_sz:        size of the PE blob
+ * @sig_mode: signature enforcement policy from kexec_context
+ * @bpf:          parser context
+ *
+ * Returns 0 on success, negative errno otherwise.
+ */
+static int do_zboot_decompress(char *ringbuf, const char *pe_buf,
+			       __u32 pe_sz,
+			       kexec_sig_enforced sig_mode,
+			       struct bpf_parser_context *bpf)
+{
+	struct linux_pe_zboot_header zboot_header;
+	unsigned int payload_offset, payload_size, max_payload;
+	int total, ret;
+
+	if (pe_sz > MAX_RECORD_SIZE) {
+		bpf_printk("do_zboot_decompress: PE image too large\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Verify PE signature before any further processing if
+	 * signature enforcement is requested.
+	 */
+	if (sig_mode != SIG_ENFORCE_NONE) {
+		total = fill_cmd(ringbuf,
+				 KEXEC_BPF_CMD_VERIFY_SIG,
+				 0,
+				 pe_buf,
+				 pe_sz);
+		ret = bpf_buffer_parser(ringbuf, total, bpf);
+		if (ret < 0) {
+			bpf_printk("do_zboot_decompress: VERIFY_SIG failed: %d\n",
+				   ret);
+			return ret;
+		}
+	}
+
+	/* Read and validate zboot header */
+	if (bpf_probe_read_kernel(&zboot_header, sizeof(zboot_header),
+				  pe_buf) < 0) {
+		bpf_printk("do_zboot_decompress: failed to read zboot header\n");
+		return -EIO;
+	}
+
+	if (__builtin_memcmp(&zboot_header.image_type, "zimg",
+			     sizeof(zboot_header.image_type))) {
+		bpf_printk("do_zboot_decompress: not a zboot image\n");
+		return -EINVAL;
+	}
+
+	payload_offset = zboot_header.payload_offset;
+	payload_size   = zboot_header.payload_size;
+	bpf_printk("do_zboot_decompress: payload offset=0x%x size=0x%x\n",
+		   payload_offset, payload_size);
+
+	if (payload_size < 4) {
+		bpf_printk("do_zboot_decompress: zboot payload too small\n");
+		return -EINVAL;
+	}
+	if (payload_offset > pe_sz ||
+	    payload_size   > pe_sz ||
+	    payload_offset > pe_sz - payload_size) {
+		bpf_printk("do_zboot_decompress: zboot payload out of bounds\n");
+		return -EINVAL;
+	}
+
+	max_payload = MAX_RECORD_SIZE - sizeof(struct cmd_hdr);
+	if (payload_size - 4 >= max_payload) {
+		bpf_printk("do_zboot_decompress: zboot payload exceeds MAX_RECORD_SIZE\n");
+		return -EINVAL;
+	}
+
+	/* 4 bytes original size is appended after vmlinuz.bin, strip them */
+	total = fill_cmd(ringbuf,
+			 KEXEC_BPF_CMD_DECOMPRESS,
+			 KEXEC_BPF_SUBCMD_KERNEL,
+			 pe_buf + payload_offset,
+			 payload_size - 4);
+
+	bpf_printk("do_zboot_decompress: calling bpf_buffer_parser() for DECOMPRESS\n");
+	ret = bpf_buffer_parser(ringbuf, total, bpf);
+	if (ret < 0) {
+		bpf_printk("do_zboot_decompress: decompression failed: %d\n",
+			   ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+SEC("fentry.s/kexec_image_parser_anchor")
+int BPF_PROG(parse_zboot, struct kexec_context *context, unsigned long parser_id)
+{
+	kexec_sig_enforced sig_mode;
+	struct bpf_parser_context *bpf = NULL;
+	Elf64_Ehdr ehdr;
+	Elf64_Shdr shstr_shdr;
+	__u64 shstrtab_off, shstrtab_sz;
+	unsigned long buf_sz;
+	char *buf_elf;
+	char *ringbuf;
+	__u8 magic[4];
+	int total, ret, i;
+
+	buf_elf      = BPF_CORE_READ(context, parsing_buf[0]);
+	buf_sz       = BPF_CORE_READ(context, parsing_buf_sz[0]);
+	sig_mode = BPF_CORE_READ(context, sig_mode);
+
+	if (!buf_elf || buf_sz < 4) {
+		bpf_printk("parse_zboot: invalid parsing_buf[0]\n");
+		return 0;
+	}
+
+	if (bpf_probe_read_kernel(magic, sizeof(magic), buf_elf) < 0) {
+		bpf_printk("parse_zboot: failed to read magic\n");
+		return 0;
+	}
+
+	ringbuf = (char *)bpf_ringbuf_reserve(&ringbuf_1, MAX_RECORD_SIZE, 0);
+	if (!ringbuf) {
+		bpf_printk("parse_zboot: failed to reserve ringbuf\n");
+		return 0;
+	}
+
+	bpf = bpf_get_parser_context(parser_id);
+	if (!bpf) {
+		bpf_printk("parse_zboot: no parser context\n");
+		goto discard;
+	}
+
+	/*
+	 * Plain PE (zboot) path: parsing_buf[0] is a PE image directly.
+	 * Mirrors the original parse_zboot behaviour.
+	 */
+	if (magic[0] == 'M' && magic[1] == 'Z') {
+		ret = do_zboot_decompress(ringbuf, buf_elf, (__u32)buf_sz,
+					  sig_mode, bpf);
+		if (ret < 0)
+			goto discard;
+
+		goto done;
+	}
+
+	/*
+	 * ELF container path: parsing_buf[0] is an ELF with .kernel,
+	 * .initrd, .cmdline sections.  .kernel contains a PE zboot image.
+	 */
+	if (magic[0] != 0x7f || magic[1] != 'E' ||
+	    magic[2] != 'L'  || magic[3] != 'F') {
+		bpf_printk("parse_zboot: unrecognized format\n");
+		goto discard;
+	}
+
+	if (buf_sz < sizeof(Elf64_Ehdr)) {
+		bpf_printk("parse_zboot: ELF too small\n");
+		goto discard;
+	}
+
+	if (bpf_probe_read_kernel(&ehdr, sizeof(ehdr), buf_elf) < 0) {
+		bpf_printk("parse_zboot: failed to read ELF header\n");
+		goto discard;
+	}
+	if (ehdr.e_shoff == 0 || ehdr.e_shnum == 0 ||
+	    ehdr.e_shstrndx == SHN_UNDEF) {
+		bpf_printk("parse_zboot: invalid ELF section info\n");
+		goto discard;
+	}
+
+	if (bpf_probe_read_kernel(&shstr_shdr, sizeof(shstr_shdr),
+				  buf_elf + ehdr.e_shoff +
+				  ehdr.e_shstrndx * sizeof(Elf64_Shdr)) < 0) {
+		bpf_printk("parse_zboot: failed to read shstrtab shdr\n");
+		goto discard;
+	}
+	shstrtab_off = shstr_shdr.sh_offset;
+	shstrtab_sz  = shstr_shdr.sh_size;
+
+	for (i = 1; i < ELF_SCAN_MAX; i++) {
+		Elf64_Shdr shdr;
+		char sec_name[16];
+		__u64 name_off;
+
+		if (i >= ehdr.e_shnum)
+			break;
+
+		if (bpf_probe_read_kernel(&shdr, sizeof(shdr),
+					  buf_elf + ehdr.e_shoff +
+					  i * sizeof(Elf64_Shdr)) < 0)
+			continue;
+
+		name_off = shstrtab_off + shdr.sh_name;
+		if (name_off + sizeof(sec_name) > shstrtab_off + shstrtab_sz)
+			continue;
+		if (bpf_probe_read_kernel(sec_name, sizeof(sec_name),
+					  buf_elf + name_off) < 0)
+			continue;
+
+		if (!shdr.sh_size || shdr.sh_offset + shdr.sh_size > buf_sz)
+			continue;
+
+		/* .initrd */
+		if (__builtin_memcmp(sec_name, initrd_sect_name, sizeof(initrd_sect_name)) == 0) {
+			total = fill_cmd(ringbuf,
+					 KEXEC_BPF_CMD_COPY,
+					 KEXEC_BPF_SUBCMD_INITRD,
+					 buf_elf + shdr.sh_offset,
+					 (__u32)shdr.sh_size);
+			ret = bpf_buffer_parser(ringbuf, total, bpf);
+			if (ret < 0) {
+				bpf_printk("parse_zboot: COPY initrd failed: %d\n",
+					   ret);
+				goto discard;
+			}
+			continue;
+		}
+
+		/* .cmdline */
+		if (__builtin_memcmp(sec_name, cmdline_sect_name, sizeof(cmdline_sect_name)) == 0) {
+			total = fill_cmd(ringbuf,
+					 KEXEC_BPF_CMD_COPY,
+					 KEXEC_BPF_SUBCMD_CMDLINE,
+					 buf_elf + shdr.sh_offset,
+					 (__u32)shdr.sh_size);
+			ret = bpf_buffer_parser(ringbuf, total, bpf);
+			if (ret < 0) {
+				bpf_printk("parse_zboot: COPY cmdline failed: %d\n",
+					   ret);
+				goto discard;
+			}
+			continue;
+		}
+
+		/* .kernel: vmlinuz.efi PE zboot image */
+		if (__builtin_memcmp(sec_name, linux_sect_name, sizeof(linux_sect_name)) != 0)
+			continue;
+
+		ret = do_zboot_decompress(ringbuf,
+					  buf_elf + shdr.sh_offset,
+					  (__u32)shdr.sh_size,
+					  sig_mode, bpf);
+		if (ret < 0)
+			goto discard;
+	}
+
+done:
+	/* Notify kernel that this BPF prog completed successfully */
+	total = fill_cmd(ringbuf, KEXEC_BPF_CMD_DONE, 0, NULL, 0);
+	ret = bpf_buffer_parser(ringbuf, total, bpf);
+	if (ret < 0) {
+		bpf_printk("parse_zboot: KEXEC_BPF_CMD_DONE, failed: %d\n", ret);
+		goto discard;
+	}
+
+discard:
+	bpf_ringbuf_discard(ringbuf, BPF_RB_NO_WAKEUP);
+	if (bpf)
+		bpf_put_parser_context(bpf);
+	return 0;
+}
-- 
2.49.0

