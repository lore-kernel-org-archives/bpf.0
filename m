Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977522D5A19
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774144043; cv=none; b=F2Apd7oM1EqssLnpkjMXb5/j2mULFNfiEBr4uQIkyvY8PgshF1pmtgPZy1RJj9C4KtTLF7rS97WXeTwIHSyxlW+hq/axbrW8NJHcRS8CAG9Vn22p/yRwSFleGb7hJHrSE8edJ1zjmRP5xBXcxl6oBB9k8d3JnudSQ4BOz1/hwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774144043; c=relaxed/simple;
	bh=STlGzMGeEeiUitGF7IFp6nDs8a4NZLF8OIdOxzt6Los=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqhJ8UanzPgOYfl6RP/p9w27oQhfo4cnsF8XGOSRT8j88IRncIdIVxuN+R9OEJxI+PdAHHscTu/XUcnukKeXXNfXW+Nm5RA2p2oXggkh0ubcKrbPyF5X1w4IDaOXhtKh/g38vKl1wwmXOjDcqc6Dvfd8ecrdn1rjMzkmbJyjaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSLJ4bHC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSLJ4bHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774144040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSe22gQ7YSBoSx0BRUyY4Y8cXier6OyQlbQMTQ/OwNI=;
	b=SSLJ4bHCuhNF4HQw104wOrOZnC7wV4TYDCH2GWqpCnw/uu9e+rIQg5Tef2tkwoV/I3tUDY
	3ssYFHaSSfr07Sj0flX6jAdXEB9/mQJenp91GnwcdozDz3meCH/YTXRmAVyz2O/RD7vWbE
	gapUB5eiLE6EeXNYjoaGrlBos/ManUk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-SdzToAr3PPGCkDDcyaTQFQ-1; Sat,
 21 Mar 2026 21:47:17 -0400
X-MC-Unique: SdzToAr3PPGCkDDcyaTQFQ-1
X-Mimecast-MFC-AGG-ID: SdzToAr3PPGCkDDcyaTQFQ_1774144034
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93B8B19560A6;
	Sun, 22 Mar 2026 01:47:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2ECFE300019F;
	Sun, 22 Mar 2026 01:47:01 +0000 (UTC)
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
Subject: [PATCHv7 12/13] tools/kexec: Introduce a bpf-prog to handle UKI image
Date: Sun, 22 Mar 2026 09:44:01 +0800
Message-ID: <20260322014402.8815-13-piliu@redhat.com>
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

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 tools/kexec/Makefile         |  18 ++-
 tools/kexec/uki_parser_bpf.c | 235 +++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 tools/kexec/uki_parser_bpf.c

diff --git a/tools/kexec/Makefile b/tools/kexec/Makefile
index a404a1453c888..c0e2ad44658e3 100644
--- a/tools/kexec/Makefile
+++ b/tools/kexec/Makefile
@@ -43,6 +43,7 @@ HEADERS = vmlinux.h bpf_helper_defs.h image_size.h
 #   <P>.bpf                - final ELF wrapper with .bpf.1 section
 # ---------------------------------------------------------------------------
 BPF_TARGETS = zboot
+BPF_TARGETS += uki
 
 define BPF_ARTIFACTS
 $(1)_parser_bpf.o $(1)_parser_bpf.lskel.h $(1)_bytecode.c $(1)_bytecode.o $(1).bpf
@@ -54,8 +55,13 @@ ALL_BPF_ARTIFACTS = $(foreach t,$(BPF_TARGETS),$(call BPF_ARTIFACTS,$(t)))
 # Top-level phony targets
 # ---------------------------------------------------------------------------
 zboot: $(HEADERS) $(call BPF_ARTIFACTS,zboot) build_zboot_image
+ifeq ($(ARCH),$(filter $(ARCH),arm64 riscv loongarch))
+uki: $(HEADERS) zboot.bpf $(call BPF_ARTIFACTS,uki)
+else
+uki: $(HEADERS) $(call BPF_ARTIFACTS,uki)
+endif
 
-.PHONY: zboot clean
+.PHONY: zboot uki clean
 
 # ---------------------------------------------------------------------------
 # Shared header rules
@@ -123,6 +129,15 @@ image_size.h: $(KERNEL_IMAGE)
 # ---------------------------------------------------------------------------
 ZBOOT_BPF_MAPS := .bpf.1:zboot_bytecode.o
 
+# uki.bpf sections depend on architecture:
+#   arm64/riscv/loongarch: .bpf.1 (uki bytecode) + .bpf.nested (zboot.bpf ELF)
+#   x86: .bpf.1 only.  zboot format does not exist on x86
+ifeq ($(ARCH),$(filter $(ARCH),arm64 riscv loongarch))
+UKI_BPF_MAPS   := .bpf.1:uki_bytecode.o .bpf.nested:zboot.bpf
+else
+UKI_BPF_MAPS   := .bpf.1:uki_bytecode.o
+endif
+
 # ---------------------------------------------------------------------------
 # Helpers to build objcopy flags from a BPF_MAPS list
 # ---------------------------------------------------------------------------
@@ -154,6 +169,7 @@ $(1).bpf: $(foreach m,$($(2)_BPF_MAPS),$(call source_file,$(m)))
 endef
 
 $(eval $(call BPF_WRAPPER_RULE,zboot,ZBOOT))
+$(eval $(call BPF_WRAPPER_RULE,uki,UKI))
 
 # ---------------------------------------------------------------------------
 # Clean
diff --git a/tools/kexec/uki_parser_bpf.c b/tools/kexec/uki_parser_bpf.c
new file mode 100644
index 0000000000000..1eb542d8acd4c
--- /dev/null
+++ b/tools/kexec/uki_parser_bpf.c
@@ -0,0 +1,235 @@
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
+#define MIN_BUF_SIZE 1
+#define MAX_RECORD_SIZE (IMAGE_SIZE + 40960)
+#define RINGBUF1_SIZE IMAGE_SIZE_POWER2_ALIGN
+#define RINGBUF2_SIZE MIN_BUF_SIZE
+#define RINGBUF3_SIZE MIN_BUF_SIZE
+#define RINGBUF4_SIZE MIN_BUF_SIZE
+
+#include "template.c"
+
+#define MAX_PARSING_BUFS 16
+#define PE_SCAN_MAX      16
+#define ELF_SCAN_MAX     16
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
+static const char linux_sect_name[]   = ".linux";
+static const char initrd_sect_name[]   = ".initrd";
+static const char cmdline_sect_name[]   = ".cmdline";
+
+
+#define MAKE_CMD(cmd, subcmd)  ((__u32)(cmd) | ((__u32)(subcmd) << 16))
+
+static int fill_cmd(char *buf, __u32 cmd_word, __u32 pipeline_flag,
+			const char *src, __u32 data_len)
+{
+	struct cmd_hdr *hdr;
+	char *payload;
+
+	__u16 cmd = (__u16)(cmd_word & 0xffff);
+	__u16 subcmd = (__u16)(cmd_word >> 16);
+
+	hdr = (struct cmd_hdr *)buf;
+	hdr->cmd = cmd;
+	hdr->subcmd = subcmd;
+	hdr->pipeline_flag = pipeline_flag;
+	hdr->payload_len = data_len;
+	hdr->num_chunks = 0;
+
+	payload = (char *)(hdr + 1);
+	/* Only cmd, no payload */
+	if (!src || !data_len)
+		return sizeof(*hdr);
+	if (data_len > MAX_RECORD_SIZE - sizeof(struct cmd_hdr))
+		return -EINVAL;
+	bpf_probe_read_kernel(payload, data_len, src);
+
+	return sizeof(*hdr) + data_len;
+}
+
+static int process_uki_pe(const char *pe_buf, __u32 pe_sz, char *scratch,
+			  struct bpf_parser_context *bpf_ctx)
+{
+	__u32 pe_offset, pe_sig, section_table_off;
+	__u16 dos_magic, num_sections, opt_hdr_sz;
+	__u16 pipeline_flag = 0;
+	int i, ret;
+
+	if (pe_sz < 64)
+		return -EINVAL;
+	if (pe_sz > MAX_RECORD_SIZE)
+		return -EINVAL;
+
+	if (bpf_probe_read_kernel(&dos_magic, sizeof(dos_magic), pe_buf) < 0)
+		return -EIO;
+	if (dos_magic != 0x5A4D)
+		return -EINVAL;
+
+	if (bpf_probe_read_kernel(&pe_offset, sizeof(pe_offset),
+				  pe_buf + 0x3c) < 0)
+		return -EIO;
+	if (pe_offset + 24 > pe_sz)
+		return -EINVAL;
+
+	if (bpf_probe_read_kernel(&pe_sig, sizeof(pe_sig),
+				  pe_buf + pe_offset) < 0)
+		return -EIO;
+	if (pe_sig != 0x00004550)
+		return -EINVAL;
+
+	if (bpf_probe_read_kernel(&num_sections, sizeof(num_sections),
+				  pe_buf + pe_offset + 6) < 0)
+		return -EIO;
+	if (bpf_probe_read_kernel(&opt_hdr_sz, sizeof(opt_hdr_sz),
+				  pe_buf + pe_offset + 20) < 0)
+		return -EIO;
+
+	section_table_off = pe_offset + 4 + 20 + opt_hdr_sz;
+	if (section_table_off >= pe_sz)
+		return -EINVAL;
+
+	for (i = 0; i < PE_SCAN_MAX; i++) {
+		__u32 raw_size, raw_off, shdr_off;
+		char sec_name[8];
+		__u16 subcmd;
+
+		if (i >= num_sections)
+			break;
+
+		shdr_off = section_table_off + i * 40;
+		if (shdr_off + 40 > pe_sz)
+			break;
+
+		if (bpf_probe_read_kernel(sec_name, sizeof(sec_name),
+					  pe_buf + shdr_off) < 0)
+			continue;
+
+		pipeline_flag = 0;
+		if (__builtin_memcmp(sec_name, linux_sect_name, sizeof(linux_sect_name)) == 0) {
+			subcmd = KEXEC_BPF_SUBCMD_KERNEL;
+			/*
+			 * .linux section may contain different format kernel, which should be
+			 * passed to the next stage to handle
+			 */
+			pipeline_flag = KEXEC_BPF_PIPELINE_FILL;
+		}
+		else if (__builtin_memcmp(sec_name, initrd_sect_name, sizeof(initrd_sect_name)) == 0)
+			subcmd = KEXEC_BPF_SUBCMD_INITRD;
+		else if (__builtin_memcmp(sec_name, cmdline_sect_name, sizeof(cmdline_sect_name)) == 0)
+			subcmd = KEXEC_BPF_SUBCMD_CMDLINE;
+		else
+			continue;
+
+		if (bpf_probe_read_kernel(&raw_size, sizeof(raw_size),
+					  pe_buf + shdr_off + 16) < 0)
+			continue;
+		if (bpf_probe_read_kernel(&raw_off, sizeof(raw_off),
+					  pe_buf + shdr_off + 20) < 0)
+			continue;
+
+		if (!raw_size || raw_off + raw_size > pe_sz)
+			continue;
+
+		ret = fill_cmd(scratch,
+				MAKE_CMD(KEXEC_BPF_CMD_COPY, subcmd),
+				pipeline_flag,
+				pe_buf + raw_off,
+				raw_size);
+		ret = bpf_buffer_parser(scratch, ret, bpf_ctx);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+SEC("fentry.s/kexec_image_parser_anchor")
+int BPF_PROG(parse_uki, struct kexec_context *context, unsigned long parser_id)
+{
+	struct bpf_parser_context *bpf_ctx;
+	char *buf0, *buf1, *scratch;
+	__u8 magic[4];
+	int ret;
+
+	bpf_printk("parse_uki: start\n");
+	buf0 = BPF_CORE_READ(context, parsing_buf[0]);
+	if (!buf0)
+		return 0;
+
+	bpf_ctx = bpf_get_parser_context(parser_id);
+	if (!bpf_ctx) {
+		bpf_printk("parse_uki: no parser context for id %lu\n",
+			   parser_id);
+		return 0;
+	}
+
+	buf1 = BPF_CORE_READ(context, parsing_buf[1]);
+
+	/*
+	 * Single-buffer path: original parse_uki behaviour.
+	 * parsing_buf[0] is either a plain PE UKI or an ELF container
+	 * with embedded .uki / .addon sections.
+	 */
+	if (!buf1) {
+		unsigned long sz = BPF_CORE_READ(context, parsing_buf_sz[0]);
+
+		if (sz < 4)
+			goto out;
+
+		if (bpf_probe_read_kernel(magic, sizeof(magic), buf0) < 0)
+			goto out;
+
+		scratch = bpf_ringbuf_reserve(&ringbuf_1, MAX_RECORD_SIZE, 0);
+		if (!scratch) {
+			bpf_printk("ringbuf reserve failed\n");
+			goto out;
+		}
+
+		if (magic[0] == 'M' && magic[1] == 'Z') {
+			bpf_printk("call process_uki_pe\n");
+			ret = process_uki_pe(buf0, (__u32)sz, scratch, bpf_ctx);
+			if (ret) {
+				bpf_printk("parse_uki: PE path failed: %d\n",
+					   ret);
+			}
+			else {
+				bpf_printk("fill KEXEC_BPF_CMD_DONE \n");
+				ret = fill_cmd(scratch, MAKE_CMD(KEXEC_BPF_CMD_DONE, 0),
+						0, NULL, 0);
+				ret = bpf_buffer_parser(scratch, ret, bpf_ctx);
+				if (ret)
+					bpf_printk("parse_uki: inject KEXEC_BPF_CMD_DONE failed: %d\n",
+					   ret);
+			}
+		} else {
+			bpf_printk("parse_uki: unrecognized format\n");
+		}
+
+		bpf_ringbuf_discard(scratch, BPF_RB_NO_WAKEUP);
+		goto out;
+	}
+
+out:
+	bpf_put_parser_context(bpf_ctx);
+	return 0;
+}
-- 
2.49.0

