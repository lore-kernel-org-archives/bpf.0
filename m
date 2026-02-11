Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F132BE643
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820387; cv=none; b=LFQeBGMtINSaYUwJcw0gGcOj6y2nmc+w5ZrHaC+Vt9qy4b5jthMZfZ9yaCEEDPPNyXA/AcnpeJL3R1GJ6D9FLdHGEsW8ZGNu4UawB0GUcS2lxBl3ULwScmV9ytyrL9P30tf97ZMYncBwCTGNziZYunSYdak7DYDjCQfLKaDtaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820387; c=relaxed/simple;
	bh=aNzFudzQK5tGnXC0ZbNNOc8AyLJqpWwwbWMmFF2KeSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kH+r6k50txJYFBQ8zUl+Z2bfIyvOWKtBrMpGVoFEXa2bbSezAPjPG8e+gPEERIP9RZB1m0YftRpykGBp2HD/dRjKjLzYGSWYt//32ZzzV8fm7gkI3WnPZ7GN+N+OnUtC4+IpTZknove+KbWOo1rzeACQQU2sWgDO210I9zEVpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfgCfs7X; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfgCfs7X"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43767807cf3so2699387f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770820384; x=1771425184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpbA0GcFew4HF8OvK40+MRhrkR3DXNpjHJcCmsEnR9M=;
        b=GfgCfs7XRzEdFaIZYMvnZ0mFTmHLCOu22VIbvQLv0QAZGumxCX9DjuwM/eEZAwEf20
         M6bG+zVCbxBXCzLwzJJzYXm7I4NPDMWxi/X/DD54yjmah0O3AQCQRtgNIdjlTU9+rgBj
         RK6aC+ePr+Ib5yq2eHoe948QPdkzHxQHDTSd8/p7zQ9eZn1X5EugpG0OP5vRgh5/XrlQ
         SOsPZ6aAWcUjW2j1hHuvgFfxfKBws/TIZLJGlzm6pGcSmxE9hZ3S3fAtUuOEAL9dSIAs
         Cp1yHx7Z5BHfLm81qqc0QjbyV3+vtK+Omv2hMqlFXnb4LkS1NjWASjwDplRIpTriWfeD
         RUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770820384; x=1771425184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpbA0GcFew4HF8OvK40+MRhrkR3DXNpjHJcCmsEnR9M=;
        b=qSmYz2KK0TqW4ep7KadIW2FgTQUu37b9THyJnyqTx2nill5OTb9ZmE1rvhQaNwcSdS
         oDI3FLui2XQaVHikp/xPJ3QzdwHnXW884BTLhbE+Mt15jstIwifF6FPHLwgh3ZmwzwM5
         1T1ixr2ZTolP2q+xrRLNqclhE2bCjhDea6tljmRsmtLfPTD/EdPUFs2XXHj4vz7E3M5y
         AVtfC290RdtY4sXaBKWMQy3x0iRtk2eXudD85eKJW+7DVAuil/RKh9z3v06KGW3db87V
         FX9kzvjPfQUWSdbibo8nDqZOsEfsMiR1tYhuGx25/MrN5BrrDYOmoXFlaH8i9h7h+Qoq
         b/mw==
X-Forwarded-Encrypted: i=1; AJvYcCWE6l7jhac0WUHVpawiXRiXoUroHpoC2fOK2EOLMrs5R8EMidMBHESG+yiJf28xHSGQd9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxkStkAQ2GDFsjKxNFLUg6AFfkJVJcJ8Ijxd/oIHH5/e/Yzdl
	/Ygq4LDHhNyqs7rpgydEKqzmAfZ5GSy0BK3N7XLcCGdrC8i9UDEU4lWE
X-Gm-Gg: AZuq6aKLSOr4HqdJ6E5FalV1+JfILPZyxCfw+yxjHalKFhZw9cZhxD0Tx4DGdurH7ld
	CSaQ+XEms5cMtdUg+ahgh8bITkLgelKnQHUY0dLatUPsGof1zjmMIWOeQiGbTRgOELOF9UdIuoj
	+AOoLKP4rLNG42MVj7jEhdz6rjqzzcFsD6t7PMJZ71s8zjHu17dtNno/GhgMKj3bf1JXMgSbjl1
	8SLSOL+Dd1iMdskeU9WcP6S5jfh1gjF0gsjQ/q5kWhdffMzoP1yCoFn9dKwr+K3MaTHMOI19Chl
	mRd6pqe3LJkGoa+vIteXH9e+hwvmBQNB+mrW3j+z4oc2Cv+81v++9G0oP7RtBU1vapnbQNjcA2q
	zSWEwYMDh84V0dkh3kHHM1M/i7G1bIFQjI6EWiQdw8KX/Kgt2B+mRbC34eGgxvh2ekc4pUo4yVJ
	FwWJtrNuPYdrIy32kdP9yNnLYrSNIkMgXxqF5O0AyhEMASDcCm0pNjzNG5kIFpglOxUyzcjpHJd
	g4hKn4pe2mALc5XfhAT
X-Received: by 2002:a05:6000:248a:b0:436:d824:6218 with SMTP id ffacd0b85a97d-43782cc0d98mr3936123f8f.55.1770820383667;
        Wed, 11 Feb 2026 06:33:03 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:b997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e39c75sm4973747f8f.29.2026.02.11.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 06:33:03 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v5 5/5] selftests/io_uring: add a bpf io_uring selftest
Date: Wed, 11 Feb 2026 14:32:44 +0000
Message-ID: <52d39c60d06ee9d02ddb04521382045a6b1d543d.1770818588.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770818588.git.asml.silence@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple io_uring BPF selftest, where the BPF program implemented in
basic.bpf.c executes a given number of NOP requests with QD=1, writes
some stats and returns back. The makefile is borrowed from sched_ext
tests.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 tools/testing/selftests/Makefile             |   3 +-
 tools/testing/selftests/io_uring/Makefile    | 162 +++++++++++++++++++
 tools/testing/selftests/io_uring/basic.bpf.c | 131 +++++++++++++++
 tools/testing/selftests/io_uring/common.h    |   6 +
 tools/testing/selftests/io_uring/runner.c    | 107 ++++++++++++
 5 files changed, 408 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/io_uring/Makefile
 create mode 100644 tools/testing/selftests/io_uring/basic.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/common.h
 create mode 100644 tools/testing/selftests/io_uring/runner.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 56e44a98d6a5..5e965ba3697c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -130,6 +130,7 @@ TARGETS += vfio
 TARGETS += x86
 TARGETS += x86/bugs
 TARGETS += zram
+TARGETS += io_uring
 #Please keep the TARGETS list alphabetically sorted
 # Run "make quicktest=1 run_tests" or
 # "make quicktest=1 kselftest" from top level Makefile
@@ -147,7 +148,7 @@ endif
 # User can optionally provide a TARGETS skiplist. By default we skip
 # targets using BPF since it has cutting edge build time dependencies
 # which require more effort to install.
-SKIP_TARGETS ?= bpf sched_ext
+SKIP_TARGETS ?= bpf sched_ext io_uring
 ifneq ($(SKIP_TARGETS),)
 	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
 	override TARGETS := $(TMP)
diff --git a/tools/testing/selftests/io_uring/Makefile b/tools/testing/selftests/io_uring/Makefile
new file mode 100644
index 000000000000..f3b9fb653973
--- /dev/null
+++ b/tools/testing/selftests/io_uring/Makefile
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+
+TEST_GEN_PROGS := runner
+
+# override lib.mk's default rules
+OVERRIDE_TARGETS := 1
+include ../lib.mk
+
+CURDIR := $(abspath .)
+REPOROOT := $(abspath ../../../..)
+TOOLSDIR := $(REPOROOT)/tools
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+APIDIR := $(TOOLSINCDIR)/uapi
+GENDIR := $(REPOROOT)/include/generated
+GENHDR := $(GENDIR)/autoconf.h
+
+OUTPUT_DIR := $(OUTPUT)/build
+OBJ_DIR := $(OUTPUT_DIR)/obj
+INCLUDE_DIR := $(OUTPUT_DIR)/include
+BPFOBJ_DIR := $(OBJ_DIR)/libbpf
+IOUOBJ_DIR := $(OBJ_DIR)/io_uring
+LIBBPF_OUTPUT := $(OBJ_DIR)/libbpf/libbpf.a
+BPFOBJ := $(BPFOBJ_DIR)/libbpf.a
+
+DEFAULT_BPFTOOL := $(OUTPUT_DIR)/host/sbin/bpftool
+HOST_OBJ_DIR := $(OBJ_DIR)/host/bpftool
+HOST_LIBBPF_OUTPUT := $(OBJ_DIR)/host/libbpf/
+HOST_LIBBPF_DESTDIR := $(OUTPUT_DIR)/host/
+HOST_DESTDIR := $(OUTPUT_DIR)/host/
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../../../vmlinux					\
+		     /sys/kernel/btf/vmlinux					\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+
+ifneq ($(wildcard $(GENHDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
+	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include
+
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+LDFLAGS = -lelf -lz -lpthread -lzstd
+
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+
+BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
+	     $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)		\
+	     -I$(CURDIR)/include -I$(CURDIR)/include/bpf-compat			\
+	     -I$(INCLUDE_DIR) -I$(APIDIR) 	\
+	     -I$(REPOROOT)/include						\
+	     $(CLANG_SYS_INCLUDES) 						\
+	     -Wall -Wno-compare-distinct-pointer-types				\
+	     -Wno-incompatible-function-pointer-types				\
+	     -O2 -mcpu=v3
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(OBJ_DIR)/libbpf				\
+	       $(OBJ_DIR)/bpftool $(OBJ_DIR)/resolve_btfids			\
+	       $(HOST_OBJ_DIR) $(INCLUDE_DIR) $(IOUOBJ_DIR))
+
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
+	   $(APIDIR)/linux/bpf.h						\
+	   | $(OBJ_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(OBJ_DIR)/libbpf/	\
+		    ARCH=$(ARCH) CC="$(CC)" CROSS_COMPILE=$(CROSS_COMPILE)	\
+		    EXTRA_CFLAGS='-g -O0 -fPIC'					\
+		    DESTDIR=$(OUTPUT_DIR) prefix= all install_headers
+
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
+		    $(LIBBPF_OUTPUT) | $(HOST_OBJ_DIR)
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)		\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    OUTPUT=$(HOST_OBJ_DIR)/					\
+		    LIBBPF_OUTPUT=$(HOST_LIBBPF_OUTPUT)				\
+		    LIBBPF_DESTDIR=$(HOST_LIBBPF_DESTDIR)			\
+		    prefix= DESTDIR=$(HOST_DESTDIR) install-bin
+
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
+ifeq ($(VMLINUX_H),)
+	$(call msg,GEN,,$@)
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(call msg,CP,,$@)
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(IOUOBJ_DIR)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h | $(BPFOBJ) $(IOUOBJ_DIR)
+	$(call msg,CLNG-BPF,,$(notdir $@))
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+$(INCLUDE_DIR)/%.bpf.skel.h: $(IOUOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BPFTOOL) | $(INCLUDE_DIR)
+	$(eval sched=$(notdir $@))
+	$(call msg,GEN-SKEL,,$(sched))
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o)
+	$(Q)diff $(<:.o=.linked2.o) $(<:.o=.linked3.o)
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $@
+	$(Q)$(BPFTOOL) gen subskeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $(@:.skel.h=.subskel.h)
+
+override define CLEAN
+	rm -rf $(OUTPUT_DIR)
+	rm -f $(TEST_GEN_PROGS)
+endef
+
+all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
+
+$(IOUOBJ_DIR)/runner.o: runner.c $(all_test_bpfprogs) | $(IOUOBJ_DIR) $(BPFOBJ)
+	$(CC) $(CFLAGS) -c $< -o $@
+
+$(OUTPUT)/runner: $(IOUOBJ_DIR)/runner.o $(BPFOBJ)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+
+.DEFAULT_GOAL := all
+
+.DELETE_ON_ERROR:
+
+.SECONDARY:
diff --git a/tools/testing/selftests/io_uring/basic.bpf.c b/tools/testing/selftests/io_uring/basic.bpf.c
new file mode 100644
index 000000000000..f1bccf3b5f42
--- /dev/null
+++ b/tools/testing/selftests/io_uring/basic.bpf.c
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "vmlinux.h"
+#include "common.h"
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+#define REQ_TOKEN 0xabba1741
+
+const unsigned max_inflight = 8;
+const volatile unsigned cq_hdr_offset;
+const volatile unsigned sq_hdr_offset;
+const volatile unsigned cqes_offset;
+
+int reqs_to_run;
+unsigned inflight;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, u32);
+	__type(value, s64);
+} res_map SEC(".maps");
+
+#define t_min(a, b) ((a) < (b) ? (a) : (b))
+
+static inline void set_cq_wait(struct iou_loop_params *lp,
+			       struct io_uring *cq_hdr, unsigned to_wait)
+{
+	lp->cq_wait_idx = cq_hdr->head + to_wait;
+}
+
+static inline void write_result(int res)
+{
+	u32 key = SLOT_RES;
+	u64 *val;
+
+	val = bpf_map_lookup_elem(&res_map, &key);
+	if (val)
+		*val = res;
+}
+
+static inline void write_stats(int idx, unsigned int v)
+{
+	u32 key = idx;
+	u64 *val;
+
+	val = bpf_map_lookup_elem(&res_map, &key);
+	if (val)
+		*val += v;
+}
+
+SEC("struct_ops.s/link_loop")
+int BPF_PROG(link_loop, struct io_ring_ctx *ring, struct iou_loop_params *ls)
+{
+	struct io_uring *sq_hdr, *cq_hdr;
+	struct io_uring_sqe *sqes;
+	struct io_uring_cqe *cqes;
+	void *rings;
+	int ret;
+
+	sqes = (void *)bpf_io_uring_get_region(ring, IOU_REGION_SQ,
+				SQ_ENTRIES * sizeof(struct io_uring_sqe));
+	rings = (void *)bpf_io_uring_get_region(ring, IOU_REGION_CQ,
+				cqes_offset + CQ_ENTRIES * sizeof(struct io_uring_cqe));
+	if (!rings || !sqes) {
+		write_result(-1);
+		return IOU_LOOP_STOP;
+	}
+
+	sq_hdr = rings + (sq_hdr_offset & 63);
+	cq_hdr = rings + (cq_hdr_offset & 63);
+	cqes = rings + cqes_offset;
+
+	unsigned to_wait = cq_hdr->tail - cq_hdr->head;
+	to_wait = t_min(to_wait, CQ_ENTRIES);
+	for (int i = 0; i < to_wait; i++) {
+		struct io_uring_cqe *cqe = &cqes[cq_hdr->head & (CQ_ENTRIES - 1)];
+
+		if (cqe->user_data != REQ_TOKEN) {
+			write_result(-3);
+			return IOU_LOOP_STOP;
+		}
+		cq_hdr->head++;
+	}
+
+	reqs_to_run -= to_wait;
+	inflight -= to_wait;
+	write_stats(SLOT_NR_CQES, to_wait);
+
+	if (reqs_to_run <= 0) {
+		write_result(1);
+		return IOU_LOOP_STOP;
+	}
+
+	if (inflight < max_inflight) {
+		unsigned to_submit = max_inflight - inflight;
+
+		to_submit = t_min(to_submit, reqs_to_run);
+
+		for (int i = 0; i < to_submit; i++) {
+			struct io_uring_sqe *sqe = sqes + i;
+
+			sqe = &sqes[sq_hdr->tail & (SQ_ENTRIES - 1)];
+			*sqe = (struct io_uring_sqe){};
+			sqe->opcode = IORING_OP_NOP;
+			sqe->user_data = REQ_TOKEN;
+			sq_hdr->tail++;
+		}
+
+		ret = bpf_io_uring_submit_sqes(ring, to_submit);
+		if (ret != to_submit) {
+			write_result(-2);
+			return IOU_LOOP_STOP;
+		}
+
+		inflight += to_submit;
+		write_stats(SLOT_NR_SQES, to_submit);
+	}
+
+	set_cq_wait(ls, cq_hdr, 1);
+	return IOU_LOOP_CONTINUE;
+}
+
+SEC(".struct_ops.link")
+struct io_uring_bpf_ops basic_ops = {
+	.loop_step = (void *)link_loop,
+};
diff --git a/tools/testing/selftests/io_uring/common.h b/tools/testing/selftests/io_uring/common.h
new file mode 100644
index 000000000000..40e3182b8e5a
--- /dev/null
+++ b/tools/testing/selftests/io_uring/common.h
@@ -0,0 +1,6 @@
+#define CQ_ENTRIES 8
+#define SQ_ENTRIES 8
+
+#define SLOT_RES	0
+#define SLOT_NR_CQES	1
+#define SLOT_NR_SQES	2
diff --git a/tools/testing/selftests/io_uring/runner.c b/tools/testing/selftests/io_uring/runner.c
new file mode 100644
index 000000000000..5fc25ddc20e8
--- /dev/null
+++ b/tools/testing/selftests/io_uring/runner.c
@@ -0,0 +1,107 @@
+#include <linux/stddef.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdlib.h>
+
+#include <bpf/libbpf.h>
+#include <io_uring/mini_liburing.h>
+
+#include "basic.bpf.skel.h"
+#include "common.h"
+
+static struct io_uring_params params;
+static struct basic *skel;
+static struct bpf_link *basic_link;
+
+#define NR_ITERS 10
+
+static void setup_ring(struct io_uring *ring)
+{
+	int ret;
+
+	memset(&params, 0, sizeof(params));
+	params.cq_entries = CQ_ENTRIES;
+	params.flags = IORING_SETUP_SINGLE_ISSUER |
+			IORING_SETUP_DEFER_TASKRUN |
+			IORING_SETUP_NO_SQARRAY |
+			IORING_SETUP_CQSIZE;
+
+	ret = io_uring_queue_init_params(SQ_ENTRIES, ring, &params);
+	if (ret) {
+		fprintf(stderr, "ring init failed\n");
+		exit(1);
+	}
+}
+
+static void setup_bpf_ops(struct io_uring *ring)
+{
+	int ret;
+
+	skel = basic__open();
+	if (!skel) {
+		fprintf(stderr, "can't generate skeleton\n");
+		exit(1);
+	}
+
+	skel->struct_ops.basic_ops->ring_fd = ring->ring_fd;
+	skel->bss->reqs_to_run = NR_ITERS;
+	skel->rodata->sq_hdr_offset = params.sq_off.head;
+	skel->rodata->cq_hdr_offset = params.cq_off.head;
+	skel->rodata->cqes_offset = params.cq_off.cqes;
+
+	ret = basic__load(skel);
+	if (ret) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	basic_link = bpf_map__attach_struct_ops(skel->maps.basic_ops);
+	if (!basic_link) {
+		fprintf(stderr, "failed to attach ops\n");
+		exit(1);
+	}
+}
+
+static void run_ring(struct io_uring *ring)
+{
+	__s64 res[3] = {};
+	int i, ret;
+
+	ret = io_uring_enter(ring->ring_fd, 0, 0, IORING_ENTER_GETEVENTS, NULL);
+	if (ret) {
+		fprintf(stderr, "run failed\n");
+		exit(1);
+	}
+
+	for (i = 0; i < 3; i++) {
+		__u32 key = i;
+
+		ret = bpf_map__lookup_elem(skel->maps.res_map,
+					&key, sizeof(key),
+					&res[i], sizeof(res[i]), 0);
+		if (ret)
+			fprintf(stderr, "can't read map idx %i: %i\n", i, ret);
+	}
+
+	if (res[SLOT_RES] != 1)
+		fprintf(stderr, "run failed: %i\n", (int)res[SLOT_RES]);
+	if (res[SLOT_NR_CQES] != NR_ITERS)
+		fprintf(stderr, "unexpected number of CQEs: %i\n",
+			(int)res[SLOT_NR_CQES]);
+	if (res[SLOT_NR_SQES] != NR_ITERS)
+		fprintf(stderr, "unexpected submitted number: %i\n",
+			(int)res[SLOT_NR_SQES]);
+}
+
+int main() {
+	struct io_uring ring;
+
+	setup_ring(&ring);
+	setup_bpf_ops(&ring);
+
+	run_ring(&ring);
+
+	bpf_link__destroy(basic_link);
+	basic__destroy(skel);
+	return 0;
+}
-- 
2.52.0

