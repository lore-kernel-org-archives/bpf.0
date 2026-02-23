Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340D27C162
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855855; cv=none; b=sJCDI75ACO44+NxFMtj0RDGEsCNNIvfymEq54ATR1BhVZMgWL9AidylNwhvNZmkOrtkTMk2+cLx87oWEPrdqvAagbV07AYJkH8jRqWJNbVaa9GTzqkEZJmkNJa5Ji2t8gDLkEPH72nmnotxhMOj3ig153AGRNSyRRwgSJYRpQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855855; c=relaxed/simple;
	bh=kEHbVbyrSkLyqhYtGG+PCan9kAUGjKg35gx26Tbb0lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcNUkllzXpSM0jtG/wxsbWiTTFgaxtfHHdpcS+FgSexe0ya/mCwTY9Zuavp0Hryzbb6kIo7EU3GawrhluHJBsMr0pPNhwc50ncZzbjRUs7L1oh0K/SGl7HIrcyQb9LF+8jp9yqt6iA2sKVoCjdSDjm+0NBDIJ6PBsarh9NiG8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgUuYz4s; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgUuYz4s"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso38445025e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855852; x=1772460652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqpUDBcLX02krC/ue6jN5j4sibBt3jzK5Gds4i7ADg0=;
        b=WgUuYz4sN72l4XA7MPzZxaDCOVddgDV+jqHkbxSn3JS3fwr4wfS3omZLm3Kvp8j0Yq
         TJC7mDectlnTzas5nTakdesQYnglu7XIuSpoNm+rkgqH8f0MKfH4iP8LqadAoxwf4e6z
         vziR/i7lSix7EbePpy62h2wnrbYuZO4fJgacDOy6fuO4uQJYqyLg4q9MqTdJO3ExPZlN
         x8HoyL4IgSqySJsgM03ULuETiuxUQNvcHbseyF9wlI5337AgDdKoM/Rohr4zWe7Qqi2z
         RV7xE7PVUNQh4el4JaZm+ATqaPX00Ly7jiCdDh0FN6uYjo98BWuUvcpmYg+mHfFgWBrf
         Et+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855852; x=1772460652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqpUDBcLX02krC/ue6jN5j4sibBt3jzK5Gds4i7ADg0=;
        b=q9B62ai/HLqYOFrPO8PWDSZX+PX/OONVuo0I1dYBRh2+ktaDjp1l8yhqoTD1uQj1QS
         Qpt/N+HHrvZAkiaYhR2yGKcr7gtYzmM9FLm9xuUFnxhpYzLnqdnWGN5m4y5ampUNAbJj
         42qbhOBJiY4W4nH5rtk/JImwoV0aiZ5pbSPcWsD0oxm9yX5z47bkcIeI3Jog8+fnu2Ig
         Yx6kokAyeMLP/Scn6yNfc1d0GMQzTN8p4nmAgsuBRICDujiWLOcK88n+inFOZYb46Svd
         nPFrbjdgFqFrN9FNVGkD10XWkBVWjJ7raPtK49a7N4I8GKQenjdbQqh9tQocAvsdOZrt
         zvUA==
X-Forwarded-Encrypted: i=1; AJvYcCWQlVG49bvHvc+rzj3w2vVRqFDdCS7JDSBaE2i3CBUdzNFbBftq+dcy04NWXf/Q92pC/DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9eGl6uBcGrCiDOq3N7nTs+DnyIcDoN2MJx8hmbLFjw92rVsGS
	UkL0tt2/awVZg2JZNHxeiqRzz/Cr+HkKF269OQquhVE2YifCFBkl3poy
X-Gm-Gg: AZuq6aJtH5msbaSnLv2yp/8ymlP+grGD9KkTMnP/JPw4NTwvoQ7YmJWx2IbhPLpS3BM
	Dk8beRP53sinSdcfUNZFpryVDWiXhyWEUhQt064lj69oMd03R1A0T9ZiErXxzEv++RRyS7JFtNG
	1nfTY53dqurbreu5s3cw/cYI1ze5kxqucfcY8aSJY5BfkO5HVu2T8Wu8uYPVz7AmarvQs+r6nPQ
	FjRrmM8N9cMGBZQdVAO3bvke9zxIDeROu8KsYRdOAUSRbc0QjiQLq5FuWk9ip06cjbtELJ6eVtT
	QLultq3aMb+X5nAUtYcmfPP+nfhueBtKrsmpyNnrZtKTJiWFe+WcZ4S8H9NDEoYJIZHvdv6j3Cx
	CWPZfKuEcWq6XoHHLF4plJlxmrdQojUDWevBCowmfG2jHD605nNs9675qZTxHF8/VwWFitaadMt
	vhJn72SiTBr+VIGR+TBAM2Hod1AKTwG4mqQeJ2SRpK8xUDMrYi3SbbYNx5mUkJg8jWhJioF0vFy
	BgH6h0ktA==
X-Received: by 2002:a05:600c:6206:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-483a962d586mr142346275e9.21.1771855851935;
        Mon, 23 Feb 2026 06:10:51 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:51 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 08/10] selftests/io_uring: add BPF event loop example
Date: Mon, 23 Feb 2026 14:10:19 +0000
Message-ID: <b06828523c384ff4a6193bc390ee208b55c07fc2.1771855761.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771855760.git.asml.silence@gmail.com>
References: <cover.1771855760.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple io_uring BPF selftests, which emulates a typical event
loop but with NOP requests. It maintains a given QD, submits requests
and reaps completions until it processes a pre-determined number of
requests.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 tools/testing/selftests/Makefile              |   3 +-
 tools/testing/selftests/io_uring/Makefile     | 162 ++++++++++++++++++
 .../testing/selftests/io_uring/common-defs.h  |  27 +++
 tools/testing/selftests/io_uring/helpers.h    |  95 ++++++++++
 .../selftests/io_uring/nops_loop.bpf.c        | 108 ++++++++++++
 tools/testing/selftests/io_uring/nops_loop.c  |  89 ++++++++++
 6 files changed, 483 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/io_uring/Makefile
 create mode 100644 tools/testing/selftests/io_uring/common-defs.h
 create mode 100644 tools/testing/selftests/io_uring/helpers.h
 create mode 100644 tools/testing/selftests/io_uring/nops_loop.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/nops_loop.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 450f13ba4cca..f618efaaf684 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -131,6 +131,7 @@ TARGETS += vfio
 TARGETS += x86
 TARGETS += x86/bugs
 TARGETS += zram
+TARGETS += io_uring
 #Please keep the TARGETS list alphabetically sorted
 # Run "make quicktest=1 run_tests" or
 # "make quicktest=1 kselftest" from top level Makefile
@@ -148,7 +149,7 @@ endif
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
index 000000000000..5b9518140f4c
--- /dev/null
+++ b/tools/testing/selftests/io_uring/Makefile
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+
+TEST_GEN_PROGS := nops_loop
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
+	$(Q)$(CLANG) $(BPF_CFLAGS) -Wno-missing-declarations -target bpf -c $< -o $@
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
+$(OUTPUT)/%: $(IOUOBJ_DIR)/%.o $(BPFOBJ)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+
+$(IOUOBJ_DIR)/%.o: %.c $(all_test_bpfprogs) | $(IOUOBJ_DIR) $(BPFOBJ)
+	$(CC) $(CFLAGS) -c $< -o $@
+
+.DEFAULT_GOAL := all
+
+.DELETE_ON_ERROR:
+
+.SECONDARY:
diff --git a/tools/testing/selftests/io_uring/common-defs.h b/tools/testing/selftests/io_uring/common-defs.h
new file mode 100644
index 000000000000..948453c90375
--- /dev/null
+++ b/tools/testing/selftests/io_uring/common-defs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef IOU_TOOLS_COMMON_DEFS_H
+#define IOU_TOOLS_COMMON_DEFS_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+
+struct ring_info {
+	unsigned	cq_hdr_offset;
+	unsigned	sq_hdr_offset;
+	unsigned	cqes_offset;
+	unsigned	sq_entries;
+	unsigned	cq_entries;
+
+	void		*region_uaddr;
+	unsigned	region_size;
+};
+
+struct nops_state {
+	unsigned	stat_nr_cqes;
+	unsigned	stat_nr_sqes;
+	int		result;
+	int		reqs_inflight;
+	int		reqs_left;
+};
+
+#endif /* IOU_TOOLS_COMMON_DEFS_H */
diff --git a/tools/testing/selftests/io_uring/helpers.h b/tools/testing/selftests/io_uring/helpers.h
new file mode 100644
index 000000000000..b6d1b8ca64b8
--- /dev/null
+++ b/tools/testing/selftests/io_uring/helpers.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef IOU_TOOLS_HELPERS_H
+#define IOU_TOOLS_HELPERS_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/errno.h>
+#include <signal.h>
+#include <stdlib.h>
+
+#include <io_uring/mini_liburing.h>
+#include "common-defs.h"
+
+struct ring_ctx {
+	struct io_uring ring;
+	struct ring_info ri;
+
+	void *region;
+	size_t region_size;
+};
+
+static inline int ring_ctx_run(struct ring_ctx *ctx)
+{
+	return io_uring_enter(ctx->ring.ring_fd, 0, 0,
+			      IORING_ENTER_GETEVENTS, NULL);
+}
+
+static inline void ring_ctx_destroy(struct ring_ctx *ctx)
+{
+	io_uring_queue_exit(&ctx->ring);
+	free(ctx->region);
+}
+
+static inline void ring_ctx_create(struct ring_ctx *ctx, size_t region_size)
+{
+	struct io_uring_mem_region_reg mr;
+	struct io_uring_region_desc rd;
+	struct io_uring_params params;
+	unsigned cq_entries = 128;
+	unsigned sq_entries = 32;
+	struct ring_info *ri;
+	long page_size;
+	void *buffer;
+	int ret;
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+
+	memset(&params, 0, sizeof(params));
+	params.cq_entries = cq_entries;
+	params.flags = IORING_SETUP_SINGLE_ISSUER |
+			IORING_SETUP_DEFER_TASKRUN |
+			IORING_SETUP_NO_SQARRAY |
+			IORING_SETUP_CQSIZE |
+			IORING_SETUP_SQ_REWIND;
+
+	ret = io_uring_queue_init_params(sq_entries, &ctx->ring, &params);
+	if (ret) {
+		fprintf(stderr, "ring init failed\n");
+		exit(1);
+	}
+
+	region_size = (region_size + page_size + 1) & ~(page_size - 1);
+	buffer = aligned_alloc(page_size, region_size);
+	if (!buffer) {
+		fprintf(stderr, "Can't allocate memory for mem region\n");
+		exit(1);
+	}
+	memset(buffer, 0, region_size);
+
+	memset(&rd, 0, sizeof(rd));
+	rd.user_addr = (__u64)(unsigned long)buffer;
+	rd.size = region_size;
+	rd.flags = IORING_MEM_REGION_TYPE_USER;
+	memset(&mr, 0, sizeof(mr));
+	mr.region_uptr = (__u64)(unsigned long)&rd;
+
+	ret = io_uring_register(ctx->ring.ring_fd, IORING_REGISTER_MEM_REGION,
+				&mr, 1);
+	if (ret) {
+		fprintf(stderr, "Can't register region %i\n", ret);
+		exit(1);
+	}
+
+	ctx->region = buffer;
+	ctx->region_size = region_size;
+
+	ri = &ctx->ri;
+	ri->cq_hdr_offset = params.cq_off.head;
+	ri->sq_hdr_offset = params.sq_off.head;
+	ri->cqes_offset = params.cq_off.cqes;
+	ri->sq_entries = sq_entries;
+	ri->cq_entries = cq_entries;
+}
+
+#endif /* IOU_TOOLS_HELPERS_H */
diff --git a/tools/testing/selftests/io_uring/nops_loop.bpf.c b/tools/testing/selftests/io_uring/nops_loop.bpf.c
new file mode 100644
index 000000000000..99d8b4b69163
--- /dev/null
+++ b/tools/testing/selftests/io_uring/nops_loop.bpf.c
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "vmlinux.h"
+#include "common-defs.h"
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+const volatile struct ring_info ri;
+const unsigned max_inflight = 32;
+
+#define REQ_TOKEN 0xabba1741
+
+#define t_min(a, b) ((a) < (b) ? (a) : (b))
+
+static unsigned nr_to_submit(struct nops_state *ns)
+{
+	unsigned to_submit = 0;
+	unsigned inflight = ns->reqs_inflight;
+
+	if (inflight < max_inflight) {
+		to_submit = max_inflight - inflight;
+		to_submit = t_min(to_submit, ns->reqs_left - inflight);
+	}
+	return to_submit;
+}
+
+SEC("struct_ops.s/nops_loop_step")
+int BPF_PROG(nops_loop_step, struct io_ring_ctx *ring, struct iou_loop_params *ls)
+{
+	struct io_uring_sqe *sqes;
+	struct io_uring_cqe *cqes;
+	struct io_uring *cq_hdr;
+	struct nops_state *ns;
+	unsigned to_submit;
+	unsigned to_wait;
+	unsigned nr_cqes;
+	void *rings;
+	int ret, i;
+
+	sqes = (void *)bpf_io_uring_get_region(ring, IOU_REGION_SQ,
+				ri.sq_entries * sizeof(struct io_uring_sqe));
+	rings = (void *)bpf_io_uring_get_region(ring, IOU_REGION_CQ,
+				ri.cqes_offset + ri.cq_entries * sizeof(struct io_uring_cqe));
+	ns = (void *)bpf_io_uring_get_region(ring, IOU_REGION_MEM,
+				sizeof(*ns));
+	if (!rings || !sqes || !ns)
+		return IOU_LOOP_STOP;
+	cq_hdr = rings + ri.cq_hdr_offset;
+	cqes = rings + ri.cqes_offset;
+
+	to_submit = nr_to_submit(ns);
+	if (to_submit) {
+		for (i = 0; i < to_submit; i++) {
+			struct io_uring_sqe *sqe = &sqes[i];
+
+			*sqe = (struct io_uring_sqe){};
+			sqe->opcode = IORING_OP_NOP;
+			sqe->user_data = REQ_TOKEN;
+		}
+
+		ret = bpf_io_uring_submit_sqes(ring, to_submit);
+		if (ret != to_submit) {
+			ns->result = ret;
+			return IOU_LOOP_STOP;
+		}
+
+		ns->reqs_inflight += to_submit;
+		ns->stat_nr_sqes += to_submit;
+	}
+
+	nr_cqes = cq_hdr->tail - cq_hdr->head;
+	nr_cqes = t_min(nr_cqes, max_inflight);
+	for (i = 0; i < nr_cqes; i++) {
+		struct io_uring_cqe *cqe = &cqes[cq_hdr->head & (ri.cq_entries - 1)];
+
+		if (cqe->user_data != REQ_TOKEN) {
+			ns->result = -EINVAL;
+			return IOU_LOOP_STOP;
+		}
+		cq_hdr->head++;
+	}
+
+	ns->reqs_inflight -= nr_cqes;
+	ns->reqs_left -= nr_cqes;
+	ns->stat_nr_cqes += nr_cqes;
+
+	if (ns->reqs_left <= 0 && !ns->reqs_inflight) {
+		ns->result = 0;
+		if (ns->reqs_left)
+			ns->result = -ERANGE;
+		return IOU_LOOP_STOP;
+	}
+
+	to_wait = ns->reqs_inflight;
+	/* Don't sleep if there are still CQEs left */
+	if (cq_hdr->tail != cq_hdr->head)
+		to_wait = 0;
+	ls->cq_wait_idx = cq_hdr->head + to_wait;
+	return IOU_LOOP_CONTINUE;
+}
+
+SEC(".struct_ops.link")
+struct io_uring_bpf_ops nops_ops = {
+	.loop_step = (void *)nops_loop_step,
+};
diff --git a/tools/testing/selftests/io_uring/nops_loop.c b/tools/testing/selftests/io_uring/nops_loop.c
new file mode 100644
index 000000000000..03490fd498fb
--- /dev/null
+++ b/tools/testing/selftests/io_uring/nops_loop.c
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/stddef.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdlib.h>
+
+#include <bpf/libbpf.h>
+#include <io_uring/mini_liburing.h>
+
+#include "common-defs.h"
+#include "helpers.h"
+#include "nops_loop.bpf.skel.h"
+
+static struct nops_loop *skel;
+static struct bpf_link *nops_loop_link;
+
+struct ring_ctx {
+	struct io_uring ring;
+	struct ring_info ri;
+
+	void *region;
+	size_t region_size;
+};
+
+#define NR_ITERS 1000
+
+static void setup_bpf_prog(struct ring_ctx *ctx)
+{
+	int ret;
+
+	skel = nops_loop__open();
+	if (!skel) {
+		fprintf(stderr, "can't generate skeleton\n");
+		exit(1);
+	}
+
+	skel->struct_ops.nops_ops->ring_fd = ctx->ring.ring_fd;
+	skel->rodata->ri = ctx->ri;
+
+	ret = nops_loop__load(skel);
+	if (ret) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	nops_loop_link = bpf_map__attach_struct_ops(skel->maps.nops_ops);
+	if (!nops_loop_link) {
+		fprintf(stderr, "failed to attach ops\n");
+		exit(1);
+	}
+}
+
+static void run_ring(struct ring_ctx *ctx)
+{
+	struct nops_state *ns = ctx->region;
+	int ret;
+
+	ns->reqs_left = NR_ITERS;
+
+	ret = ring_ctx_run(ctx);
+	if (ret) {
+		fprintf(stderr, "run failed %i\n", ret);
+		exit(1);
+	}
+
+	if (ns->result)
+		fprintf(stderr, "run failed: %i\n", ns->result);
+	if (ns->stat_nr_cqes != NR_ITERS)
+		fprintf(stderr, "unexpected number of CQEs: %u\n",
+				ns->stat_nr_cqes);
+	if (ns->stat_nr_sqes != NR_ITERS)
+		fprintf(stderr, "unexpected submitted number: %u\n",
+				ns->stat_nr_sqes);
+}
+
+int main()
+{
+	struct ring_ctx ctx;
+
+	ring_ctx_create(&ctx, sizeof(struct nops_state));
+	setup_bpf_prog(&ctx);
+
+	run_ring(&ctx);
+
+	bpf_link__destroy(nops_loop_link);
+	nops_loop__destroy(skel);
+	ring_ctx_destroy(&ctx);
+	return 0;
+}
-- 
2.53.0

