Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2736EA88
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097741; cv=none; b=djFu2Nb0ZijxX6+zgAURRxw/B5wHVbKqsuT/lcmrXsDmwB8c+GtLekyWtVDuBHkmDi9PnCVhn2Ddq3tRZtfKgT2Z2ywaD3BtFi1tzaOij6DLZJx7G7ySrePk5G3AB3fdxGpQQRwcpqxtTPA/bhcI0YaHn1JAX/ochAgcrNwbRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097741; c=relaxed/simple;
	bh=A+muRuUg8kHIQmhwqa2J4qkjn3VJy6dEI2bf7zXoO7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjVPicdAtZ6rAtBDh2hVL8TCnrodu5gw6+CA5Lgxyv3G3RjZN27lShy7kuLrUxdCw/vaKp1vsQ6rhDW9K0dClWyt5CmiAPRxwQdBFIhzCL8XGIWNIojVOZ2VU7RZpW09BFuUmj2Llta5vx4sBYWQgE1L/WgXaqtS4uJa+s0e8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nQQ2i7xc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nQQ2i7xc"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7v5PX998765
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=id3KzqTffMqF8x46TnCLhpqhJOPQaPlfX3tL7YYdxwE=; b=nQQ2i7xcmMg1
	NdxgaVsXr8Gqy3ZTBDl838LoB2V+TfP+O/fqGhrag9exBQneeHoNZYNV011Yg32f
	HadWQB/ro7FJkEoERfhccwI4Y+F+ZV+r8B/UYj1vhiL3xJYRzANCL5T7wWgBAavz
	NO7k3DFlnTBSrSbEu8GvlwwXCr03OjT8Ns0tYq1sIHsUFINmsncKziYbf+kDo/ee
	p/uz7Y0Yuyit7LAYP9u+vt2Cejh4o5wDcKkmj7jOZZxMfJzOU1DUM6TTtThrmh7a
	YMaNIvD7gz0Jxv/bDMRagYXnMCmIX9HGdIGgv+nIQdb9UdvNN8TZX9tK1qndKY0S
	FyuG7xvbqg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bufy3ay60-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:09 -0800 (PST)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:56 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id AAA2510A69E9F; Thu, 22 Jan 2026 08:01:44 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 05/13] selftests: bpf: Add basic libarena scaffolding
Date: Thu, 22 Jan 2026 08:01:23 -0800
Message-ID: <20260122160131.2238331-6-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122160131.2238331-1-etsal@meta.com>
References: <20260122160131.2238331-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ja6xbEKV c=1 sm=1 tr=0 ts=69724a01 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=zp8KgX7CWlN_CVdQNMoA:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-GUID: dLH9yO9_526OBqQY0VbyFwx_wl5Rm7R8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX4PodleEuneGU
 OqoU4IwW3G9BiWaoyEpBD6cwyuENd52Q1KjAv0Hns8LixU3MriLwhNkz2Mz2WxMoexNRBhQ7Lok
 /wSwS2+sgitNr1Zh7Gdn2BM/N4jPGRMBWuxMRh/Kb8W5Jk0waUsQi44xEEqPjg/icjTWRNpbMbZ
 wRi8m0j1zST29UZGOWCpCoJStqOu2Wbr3DoSbsM9ACg34HpHEuSxa4D66+lWUG0jA5+vizFU0Au
 BXBY6DxWL/7azRMCW3kvT2ObTL0W+RCfL1xWBw4q+mz7aH86vcPSNzcL1YO3tKIrP/5IpJMNn1N
 ahbIwQHuF4tXToXCJOH+ixo4WIeb8rpt7YjIMmTG1/BDCyFvI12Q+fnYZRuw962Lzu7iZt4Vxd+
 irOzFJzRVJuoDJhHIU953F6X256uXZqqkUrW4GY5v5HnTFSg+aRowzBwOrSNyx4msp0WIdMEprt
 fNA0Y7XC8wlQXUKVa2g==
X-Proofpoint-ORIG-GUID: dLH9yO9_526OBqQY0VbyFwx_wl5Rm7R8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add initial code for an arena-based BPF library. The current commit
introduces a test runner and Makefile for the library. Library code
can be added just by including the source file in the library's src/
subdirectory. Future commits will introduce the library code itself.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  12 +
 tools/testing/selftests/bpf/libarena/Makefile |  47 ++++
 .../selftests/bpf/libarena/include/common.h   | 118 +++++++++
 .../selftests/bpf/libarena/include/userapi.h  |  22 ++
 .../bpf/libarena/selftests/selftest.c         | 243 ++++++++++++++++++
 .../bpf/libarena/selftests/selftest.h         |  17 ++
 7 files changed, 460 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi.=
h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selfte=
st.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selfte=
st.h

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
index b8bf51b7a0b0..96b4a7e37427 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -48,3 +48,4 @@ verification_cert.h
 *.BTF
 *.BTF_ids
 *.BTF.base
+libarena/test_libarena
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 9488d076c740..931153ae7a22 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -915,3 +915,15 @@ override define INSTALL_RULE
 		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
 	done
 endef
+
+test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena all \
+		BPFTOOL=3D"$(BPFTOOL)" \
+		INCLUDE_DIR=3D"$(HOST_INCLUDE_DIR)" \
+		LIBBPF_INCLUDE=3D"$(HOST_INCLUDE_DIR)" \
+		BPFOBJ=3D"$(BPFOBJ)" \
+		LDLIBS=3D"$(LDLIBS)" \
+		CLANG=3D"$(CLANG)" \
+		BPF_CFLAGS=3D"$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
+		BPF_TARGET_ENDIAN=3D"$(BPF_TARGET_ENDIAN)" \
+		Q=3D"$(Q)"
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
new file mode 100644
index 000000000000..70901bb5237f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -0,0 +1,47 @@
+.PHONY: clean
+
+LIBARENA=3D$(abspath .)
+
+
+LIBARENA_SOURCES =3D $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LI=
BARENA)/selftests/*.bpf.c)
+LIBARENA_OBJECTS =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D.bpf.o))
+
+INCLUDES =3D -I$(LIBARENA)/include -I$(LIBARENA)/..
+ifneq ($(INCLUDE_DIR),)
+INCLUDES +=3D -I$(INCLUDE_DIR)
+endif
+ifneq ($(LIBBPF_INCLUDE),)
+INCLUDES +=3D -I$(LIBBPF_INCLUDE)
+endif
+
+# ENABLE_ATOMICS_TESTS required because we use arena spinlocks
+override BPF_CFLAGS +=3D -DENABLE_ATOMICS_TESTS
+override BPF_CFLAGS +=3D -O2 -Wno-incompatible-pointer-types-discards-qu=
alifiers
+override BPF_CFLAGS +=3D $(INCLUDES)
+
+CFLAGS =3D -O2 -no-pie
+CFLAGS +=3D $(INCLUDES)
+
+vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
+vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
+
+all: test_libarena
+
+test_libarena: selftest.c $(BPFOBJ) selftest.skel.h
+	$(call msg,BINARY,libarena,$@)
+	$(Q)$(CLANG) $(LDLIBS) $(CFLAGS) $< $(BPFOBJ) -o $@
+
+selftest.skel.h: main.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "selftest" > $@
+
+main.bpf.o: $(LIBARENA_OBJECTS)
+	$(call msg,GEN-OBJ,libarena,$@)
+	$(Q)$(BPFTOOL) gen object $@ $^
+
+%.bpf.o: %.bpf.c
+	$(call msg,CLNG-BPF,libarena,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
+
+clean:
+	$(Q)rm -f *.skel.h *.bpf.o test_libarena
diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tool=
s/testing/selftests/bpf/libarena/include/common.h
new file mode 100644
index 000000000000..12fab01d60f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -0,0 +1,118 @@
+#pragma once
+
+#ifdef __BPF__
+
+/* Suppresses definition conflicts between bpf_experimental.h and vmlinu=
x.h. */
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+#include "bpf_arena_spin_lock.h"
+
+#include <asm-generic/errno.h>
+
+#ifndef __BPF_FEATURE_ADDR_SPACE_CAST
+#error "Arena allocators require bpf_addr_space_cast feature"
+#endif
+
+#define arena_stdout(fmt, ...) bpf_stream_printk(1, (fmt), ##__VA_ARGS__=
)
+#define arena_stderr(fmt, ...) bpf_stream_printk(2, (fmt), ##__VA_ARGS__=
)
+
+extern volatile u64 asan_violated;
+
+#ifndef div_round_up
+#define div_round_up(a, b) (((a) + (b) - 1) / (b))
+#endif
+
+#ifndef round_up
+#define round_up(a, b) ((((a) + (b) - 1) / (b)) * b)
+#endif
+
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((__unused__))
+#endif
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
+
+/* How many pages do we reserve at the beginning of the arena segment? *=
/
+#define RESERVE_ALLOC (8)
+
+#define ARENA_PAGES (1UL << (32 - __builtin_ffs(__PAGE_SIZE) + 1))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_PAGES); /* number of pages */
+#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+        __ulong(map_extra, (1ull << 32)); /* start of mmap() region */
+#else
+        __ulong(map_extra, (1ull << 44)); /* start of mmap() region */
+#endif
+} arena __weak SEC(".maps");
+
+#endif /* __BPF__ */
+
+struct arena_get_base_args {
+	void __arena *arena_base;
+};
+
+#ifdef __BPF__
+
+static inline
+int arena_fls(__u64 word)
+{
+	unsigned int num =3D 0;
+
+	if (word & 0xffffffff00000000ULL) {
+		num +=3D 32;
+		word >>=3D 32;
+	}
+
+	if (word & 0xffff0000) {
+		num +=3D 16;
+		word >>=3D 16;
+	}
+
+	if (word & 0xff00) {
+		num +=3D 8;
+		word >>=3D 8;
+	}
+
+	if (word & 0xf0) {
+		num +=3D 4;
+		word >>=3D 4;
+	}
+
+	if (word & 0xc) {
+		num +=3D 2;
+		word >>=3D 2;
+	}
+
+	if (word & 0x2) {
+		num +=3D 1;
+	}
+
+	return num;
+}
+
+/*
+ * Userspace API, required for setting up the arena=20
+ * address space before starting the allocator.
+ */
+
+SEC("syscall") __weak
+int arena_get_base(struct arena_get_base_args *args)
+{
+	args->arena_base =3D arena_base(&arena);
+
+	return 0;
+}
+
+SEC("syscall") __weak
+int arena_alloc_reserve(void)
+{
+	return bpf_arena_reserve_pages(&arena, NULL, RESERVE_ALLOC);
+}
+
+#endif /* __BPF__ */
diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/too=
ls/testing/selftests/bpf/libarena/include/userapi.h
new file mode 100644
index 000000000000..bd5e7042a44f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
@@ -0,0 +1,22 @@
+#pragma once
+
+/*=20
+ * Header for the userspace C programs that load
+ * and initialize the BPF code.
+ */
+
+#define __arena
+
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+typedef int8_t s8;
+typedef int16_t s16;
+typedef int32_t s32;
+typedef int64_t s64;
+
+/* Dummy "definition" for userspace. */
+#define arena_spinlock_t u64
+
+#include "common.h"
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
new file mode 100644
index 000000000000..2e4c0830fed9
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -0,0 +1,243 @@
+/*
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ *
+ * This software may be used and distributed according to the terms of t=
he
+ * GNU General Public License version 2.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <sys/sysinfo.h>
+
+#include <userapi.h>
+
+#include "selftest.h"
+
+#include "../selftest.skel.h"
+typedef struct selftest selftest;
+
+static bool verbose =3D false;
+static int testno =3D 1;
+
+typedef int (*selftest_func)(selftest *);
+
+static int
+selftest_fd(int prog_fd, struct bpf_test_run_opts *calleropts)
+{
+	struct bpf_test_run_opts opts, *argopts;
+	char buf[1024];
+	int progret;
+	int ret;
+
+	argopts =3D calleropts;
+	if (!argopts) {
+		memset(&opts, 0, sizeof(opts));
+		opts.sz =3D sizeof(opts);
+		argopts =3D &opts;
+	}
+
+	ret =3D bpf_prog_test_run_opts(prog_fd, argopts);
+	if (ret)
+		return ret;
+
+	if (argopts->retval)
+		fprintf(stderr, "error %d in %s\n", argopts->retval, __func__);
+
+	if (verbose) {
+	printf("BPF stdout:\n");
+		while ((ret =3D bpf_prog_stream_read(prog_fd, 1, buf, 1024, NULL)) > 0=
)
+			printf("%.*s", ret, buf);
+
+		if (ret)
+			return ret;
+
+		printf("BPF stderr:\n");
+		while ((ret =3D bpf_prog_stream_read(prog_fd, 2, buf, 1024, NULL)) > 0=
)
+			printf("%.*s", ret, buf);
+	}
+
+	return 0;
+}
+
+static int
+selftest_arena_alloc_reserve(selftest *skel)
+{
+	int prog_fd;
+	int ret;
+
+	prog_fd =3D bpf_program__fd(skel->progs.arena_alloc_reserve);
+	if (!prog_fd)
+		return -ENOENT;
+
+	return selftest_fd(prog_fd, NULL);
+}
+
+static int
+selftest_arena_base(selftest *skel, void **arena_base)
+{
+	struct bpf_test_run_opts opts;
+	struct arena_get_base_args args;
+	u64 globals_pages;
+	int prog_fd;
+	int ret;
+
+	args =3D (struct arena_get_base_args) {
+		.arena_base =3D NULL
+	};
+
+	opts =3D (struct bpf_test_run_opts) {
+		.sz =3D sizeof(opts),
+		.ctx_in =3D &args,
+		.ctx_size_in =3D sizeof(args),
+	};
+
+	prog_fd =3D bpf_program__fd(skel->progs.arena_get_base);
+	assert(prog_fd >=3D 0 && "no program found");
+
+	ret =3D selftest_fd(prog_fd, &opts);
+	if (ret)
+		return ret;
+
+	*arena_base =3D args.arena_base;
+
+	return 0;
+}
+
+static int
+selftest_globals_pages(selftest *skel, size_t arena_all_pages, u64 *glob=
als_pages)
+{
+	size_t pgsize =3D sysconf(_SC_PAGESIZE);
+	void *arena_base;
+	u64 pages;
+	u8 *vec;
+	int ret;
+	int i;
+
+	ret =3D selftest_arena_base(skel, &arena_base);
+	if (ret)
+		return ret;
+
+	if (!arena_base)
+		return -EINVAL;
+
+	vec =3D calloc(arena_all_pages, sizeof(*vec));
+	if (!vec)
+		return -ENOMEM;
+
+	if (mincore(arena_base, arena_all_pages * pgsize, vec)) {
+		perror("mincore");
+		free(vec);
+		return -1;
+	}
+
+	/* Find the first nonresident page. */
+	pages =3D 0;
+	for (i =3D arena_all_pages - 1; i >=3D 0; i--) {
+		if (!(vec[i] & 0x1))
+			break;
+
+		pages +=3D 1;
+	}
+
+	free(vec);
+
+	*globals_pages =3D pages;
+
+	return 0;
+}
+
+static int libbpf_print_fn(enum libbpf_print_level level,
+		const char *format, va_list args)
+{
+	if (level =3D=3D LIBBPF_DEBUG)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+int run_test(selftest *skel, const struct bpf_program *prog)
+{
+	int prog_fd;
+	int ret;
+
+	ret =3D selftest_arena_alloc_reserve(skel);
+	if (ret)
+		return ret;
+
+	prog_fd =3D bpf_program__fd(prog);
+	if (!prog_fd)
+		return -ENOENT;
+
+	return selftest_fd(prog_fd, NULL);
+}
+
+#define TEST(__test)					\
+int run_##__test(void)					\
+{							\
+	selftest *skel;					\
+	int ret;					\
+							\
+	skel =3D selftest__open_and_load();		\
+	if (!skel)					\
+		goto error;				\
+							\
+	ret =3D selftest__attach(skel);			\
+	if (ret)					\
+		goto error;				\
+							\
+	ret =3D run_test(skel, skel->progs.__test);	\
+	if (ret)					\
+		goto error;				\
+							\
+	selftest__destroy(skel);			\
+							\
+	printf("ok %d - %s\n", testno++, #__test);	\
+	return 0;					\
+							\
+error:							\
+	printf("not ok %d - %s\n", testno++, #__test);	\
+	return ret;					\
+}
+
+static void
+banner(const char *progpath)
+{
+	char *name =3D basename(progpath);
+
+	printf("=3D=3D=3D %s =3D=3D=3D\n", "libarena selftests");
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+	struct rlimit rlim =3D {
+		.rlim_cur =3D RLIM_INFINITY,
+		.rlim_max =3D RLIM_INFINITY,
+	};
+
+	banner(argv[0]);
+
+	for (int i =3D 1; i < argc; i++) {
+		if (strcmp(argv[i], "-v") =3D=3D 0 || strcmp(argv[i], "--verbose") =3D=
=3D 0)
+			verbose =3D true;
+	}
+
+	ret =3D setrlimit(RLIMIT_MEMLOCK, &rlim);
+	if (ret) {
+		perror("setrlimit");
+		return ret;
+	}
+
+	libbpf_set_print(libbpf_print_fn);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.h b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.h
new file mode 100644
index 000000000000..6580b23355d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.h
@@ -0,0 +1,17 @@
+#pragma once
+
+#define ALLOC_SELFTEST(func, ...)		\
+	do {				\
+		int ret =3D func(__VA_ARGS__);	\
+		if (ret) {		\
+			bpf_printk("SELFTEST %s FAIL: %d", #func, ret);	\
+			return ret;	\
+		}			\
+	} while (0)
+
+#ifndef __BPF__
+
+/* Dummy "definition" for userspace. */
+#define arena_spinlock_t u64
+
+#endif /* __BPF__ */
--=20
2.47.3

