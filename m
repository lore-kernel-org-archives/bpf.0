Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7B4BC02C
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097725; cv=none; b=d2utAD3kHuSNUael/th9gh+kwOxZS4rjnIQzTIGB51jjKxr3g3Xe4RSY9iggR5h42G7VGV7G/N6qjO3WUWL1+ADOvgVPbCd2ubl8k6WA0HbwcB1IsM1tw2mfjQ8XrdGZArEgO+W7+Cr12Sqg/nj8FbO7iLsfM6uKwAOQbVFsS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097725; c=relaxed/simple;
	bh=Fz303jPZUUb/jNg+7ecA7o1BDBL4v7rVe/PpeeY9GHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gid5Oip+SmeSzDpPbnpkf2UaPjBDvXdmeDRCdLTnLPl2+lkrJso2D+4O4i5o3Fnf2uXBZvZoGNesLbENAAqXexP2bvxUgAxNBZmj4E/hLPBRCkNg+H0zzvZ76rav5K19xmx5If7esPHRx3Iacfi/sVReQUFhhdrZCeP4EOV7SHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LydBLoXD; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LydBLoXD"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MFL41Y1684967
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=js1p0Bf61ItCCGXO6N5fhfKlWRwtxjbFKo1xX69y5iU=; b=LydBLoXDDtN3
	hgAfsHS70x5AfJ6ODVzLnlpgpZ2skRnpfjuvX0jND7LHRBzyMO9LoZct1jDj7FYK
	qKFnXCQ/wO8ppeppiI9Wb4vOG9+SEajHRpEGn9UUsQPFwT1+KS32yE4WPxi8eSPE
	M3DGpcns+Ao92qRiI0WUATP9Iy09G/tsXxWONVvcbkQTDzcU0LWiScE1Xcn8YQXk
	XsQHvjaPYPlyDIBvGKibGbQZahfkasr9RobzE3BBlV1I7Z8ZgeBl8m8PB5QCqpUJ
	p0Q8RctGltP5zXY7R/Wo6VqSaOy4NijAwbYdSkaoK9RUSigxoS79EGdexHsBqpzh
	IZv7p/enLw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bupf50atm-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:58 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:49 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id D20AA10A69EA9; Thu, 22 Jan 2026 08:01:45 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 07/13] selftests: bpf: Add ASAN support for libarena selftests
Date: Thu, 22 Jan 2026 08:01:25 -0800
Message-ID: <20260122160131.2238331-8-etsal@meta.com>
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
X-Proofpoint-ORIG-GUID: pkew0Na7eTTHdfbjxCcT4alNVZHzwLEe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfXyiHDLIB5JPeq
 o/UJRU03fLTsKDWT3wHEht3e8ZriXvCSAF6F418CEghfhuEfmuNiAJOrJUYCcu0leCniMOVwToR
 mvjlAACVuYhRqU7HLxBfhoYxgsCCZbC9qXEuo237vjE1LcWP7bl/d28KUyftVfT/r7gFp/WXbum
 yFJp6+tk1lLxaEeYSnYxs0+dwP1pyFzZ1eU9Kvk9tA6O0/Ko+J5auF6H/EjpLToVDA/+wvMI/In
 XA9+L16y8jHhBbWsIVIs647cpT+ee4BVEyPpHjFwYXlCSdW/sv2Isx7FT8ChKgILp8MxE6AsZSR
 Uf7mwufkm0yxxSYl4K1XzZz5Xh9h0m7EXnv+GbfBohgb0CzgaIlXZLFkYRkJTcS35ClJro9FHxD
 tIf+St+rogauQ0UhYQf3O/8p0gDda3GG8nu5F4a86JWxE9UV+x2Vf7sqGYQTtwKKli8aSv50ZOu
 Cbbf9/2+K/1e76cvJzA==
X-Authority-Analysis: v=2.4 cv=cPntc1eN c=1 sm=1 tr=0 ts=697249f6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8 a=VabnemYjAAAA:8
 a=Z78Y0O2lu1pjOn387KsA:9 a=I-g_0vLIplkVOQ0FYkeP:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: pkew0Na7eTTHdfbjxCcT4alNVZHzwLEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Expand the arena library selftest infrastructure to support
address sanitization. Add the compiler flags necessary to
compile the library under ASAN when supported.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/Makefile          | 14 +++-
 tools/testing/selftests/bpf/libarena/Makefile | 26 ++++++-
 .../selftests/bpf/libarena/include/userapi.h  |  1 +
 .../bpf/libarena/selftests/selftest.c         | 69 ++++++++++++++++++-
 .../bpf/libarena/selftests/st_asan_common.h   | 49 +++++++++++++
 5 files changed, 155 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_common.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 931153ae7a22..8774c31cbf21 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -917,7 +917,19 @@ override define INSTALL_RULE
 endef
=20
 test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
-	+$(MAKE) -C libarena all \
+	+$(MAKE) -C libarena $@ \
+		BPFTOOL=3D"$(BPFTOOL)" \
+		INCLUDE_DIR=3D"$(HOST_INCLUDE_DIR)" \
+		LIBBPF_INCLUDE=3D"$(HOST_INCLUDE_DIR)" \
+		BPFOBJ=3D"$(BPFOBJ)" \
+		LDLIBS=3D"$(LDLIBS)" \
+		CLANG=3D"$(CLANG)" \
+		BPF_CFLAGS=3D"$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
+		BPF_TARGET_ENDIAN=3D"$(BPF_TARGET_ENDIAN)" \
+		Q=3D"$(Q)"
+
+test_libarena_asan: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena $@ \
 		BPFTOOL=3D"$(BPFTOOL)" \
 		INCLUDE_DIR=3D"$(HOST_INCLUDE_DIR)" \
 		LIBBPF_INCLUDE=3D"$(HOST_INCLUDE_DIR)" \
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
index 70901bb5237f..1ec1a83c0c04 100644
--- a/tools/testing/selftests/bpf/libarena/Makefile
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -5,6 +5,7 @@ LIBARENA=3D$(abspath .)
=20
 LIBARENA_SOURCES =3D $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LI=
BARENA)/selftests/*.bpf.c)
 LIBARENA_OBJECTS =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D.bpf.o))
+LIBARENA_OBJECTS_ASAN =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D_asan.bpf=
.o))
=20
 INCLUDES =3D -I$(LIBARENA)/include -I$(LIBARENA)/..
 ifneq ($(INCLUDE_DIR),)
@@ -14,6 +15,13 @@ ifneq ($(LIBBPF_INCLUDE),)
 INCLUDES +=3D -I$(LIBBPF_INCLUDE)
 endif
=20
+ASAN_FLAGS =3D -fsanitize=3Dkernel-address -fno-stack-protector -fno-bui=
ltin
+ASAN_FLAGS +=3D -mllvm -asan-instrument-address-spaces=3D1 -mllvm -asan-=
shadow-addr-space=3D1
+ASAN_FLAGS +=3D -mllvm -asan-use-stack-safety=3D0 -mllvm -asan-stack=3D0
+ASAN_FLAGS +=3D -mllvm -asan-kernel=3D1
+ASAN_FLAGS +=3D -mllvm -asan-constructor-kind=3Dnone
+ASAN_FLAGS +=3D -mllvm -asan-destructor-kind=3Dnone
+
 # ENABLE_ATOMICS_TESTS required because we use arena spinlocks
 override BPF_CFLAGS +=3D -DENABLE_ATOMICS_TESTS
 override BPF_CFLAGS +=3D -O2 -Wno-incompatible-pointer-types-discards-qu=
alifiers
@@ -25,23 +33,37 @@ CFLAGS +=3D $(INCLUDES)
 vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
 vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
=20
-all: test_libarena
+test_libarena_asan: selftest.c $(BPFOBJ) selftest_asan.skel.h
+	$(call msg,BINARY,libarena,$@)
+	$(Q)$(CLANG) $(LDLIBS) $(CFLAGS) -DBPF_ARENA_ASAN $< $(BPFOBJ) -o $@
=20
 test_libarena: selftest.c $(BPFOBJ) selftest.skel.h
 	$(call msg,BINARY,libarena,$@)
 	$(Q)$(CLANG) $(LDLIBS) $(CFLAGS) $< $(BPFOBJ) -o $@
=20
+selftest_asan.skel.h: main_asan.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "selftest_asan" > $@
+
 selftest.skel.h: main.bpf.o
 	$(call msg,GEN-SKEL,libarena,$@)
 	$(Q)$(BPFTOOL) gen skeleton $< name "selftest" > $@
=20
+main_asan.bpf.o: $(LIBARENA_OBJECTS_ASAN)
+	$(call msg,GEN-OBJ,libarena,$@)
+	$(Q)$(BPFTOOL) gen object $@ $^
+
 main.bpf.o: $(LIBARENA_OBJECTS)
 	$(call msg,GEN-OBJ,libarena,$@)
 	$(Q)$(BPFTOOL) gen object $@ $^
=20
+%_asan.bpf.o: %.bpf.c
+	$(call msg,CLNG-BPF,libarena,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) $(ASAN_FLAGS) -DBPF_ARENA_ASAN $(BPF_TARGET_=
ENDIAN) -c $< -mcpu=3Dv3 -o $@
+
 %.bpf.o: %.bpf.c
 	$(call msg,CLNG-BPF,libarena,$@)
 	$(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
=20
 clean:
-	$(Q)rm -f *.skel.h *.bpf.o test_libarena
+	$(Q)rm -f *.skel.h *.bpf.o test_libarena test_libarena_asan
diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/too=
ls/testing/selftests/bpf/libarena/include/userapi.h
index bd5e7042a44f..c294b6818bed 100644
--- a/tools/testing/selftests/bpf/libarena/include/userapi.h
+++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
@@ -20,3 +20,4 @@ typedef int64_t s64;
 #define arena_spinlock_t u64
=20
 #include "common.h"
+#include "asan.h"
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 2e4c0830fed9..4d7db66e75ed 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -22,8 +22,20 @@
=20
 #include "selftest.h"
=20
+#include <asan.h>
+
+#ifdef BPF_ARENA_ASAN
+#include "../selftest_asan.skel.h"
+typedef struct selftest_asan selftest;
+#define selftest__open selftest_asan__open
+#define selftest__open_and_load selftest_asan__open_and_load
+#define selftest__load selftest_asan__load
+#define selftest__attach selftest_asan__attach
+#define selftest__destroy selftest_asan__destroy
+#else
 #include "../selftest.skel.h"
 typedef struct selftest selftest;
+#endif
=20
 static bool verbose =3D false;
 static int testno =3D 1;
@@ -155,6 +167,48 @@ selftest_globals_pages(selftest *skel, size_t arena_=
all_pages, u64 *globals_page
 	return 0;
 }
=20
+#if BPF_ARENA_ASAN
+static int
+selftest_asan_init(selftest *skel)
+{
+	struct bpf_test_run_opts opts;
+	size_t arena_all_pages =3D 1ULL << 20;
+	struct asan_init_args args;
+	u64 globals_pages;
+	int prog_fd;
+	int ret;
+
+	ret =3D selftest_globals_pages(skel, arena_all_pages, &globals_pages);
+	if (ret)
+		return ret;
+
+	/* Taken from the arena map header. */
+	args =3D (struct asan_init_args) {
+		.arena_all_pages =3D arena_all_pages,
+		.arena_globals_pages =3D globals_pages,
+	};
+
+	opts =3D (struct bpf_test_run_opts) {
+		.sz =3D sizeof(opts),
+		.ctx_in =3D &args,
+		.ctx_size_in =3D sizeof(args),
+	};
+
+	prog_fd =3D bpf_program__fd(skel->progs.asan_init);
+	assert(prog_fd >=3D 0 && "no program found");
+	return selftest_fd(prog_fd, &opts);
+}
+
+#else /* BPF_ARENA_ASAN */
+
+static int
+selftest_asan_init(selftest *skel)
+{
+	return 0;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 		const char *format, va_list args)
 {
@@ -172,6 +226,10 @@ int run_test(selftest *skel, const struct bpf_progra=
m *prog)
 	if (ret)
 		return ret;
=20
+	ret =3D selftest_asan_init(skel);
+	if (ret)
+		return ret;
+
 	prog_fd =3D bpf_program__fd(prog);
 	if (!prog_fd)
 		return -ENOENT;
@@ -211,8 +269,17 @@ static void
 banner(const char *progpath)
 {
 	char *name =3D basename(progpath);
+	bool is_asan;
+
+	/*=20
+	 * Check if our BPF programs are ASAN-capable by inspecting the prog na=
me.
+	 * Command line arguments are guaranteed to be NULL-terminated, use str=
len.=20
+	 * Calculate the hardcoded name's length at compile time.
+	 */
+	printf("%s\n", name);
+	is_asan =3D strlen(name) > (sizeof("selftest") - 1);
=20
-	printf("=3D=3D=3D %s =3D=3D=3D\n", "libarena selftests");
+	printf("=3D=3D=3D %s %s=3D=3D=3D\n", "libarena selftests", is_asan ? "(=
asan) " : "");
 }
=20
 int main(int argc, char *argv[])
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_commo=
n.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
new file mode 100644
index 000000000000..d8a6316bba47
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
@@ -0,0 +1,49 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#pragma once
+
+#define ST_PAGES 64
+
+#define ASAN_MAP_STATE(addr)                                            =
     \
+	do {                                                                 \
+		bpf_printk("%s:%d ASAN %lx -> (val: %x gran: %x set: [%s])", \
+			   __func__, __LINE__, addr,                         \
+			   asan_shadow_value((addr)), ASAN_GRANULE(addr),    \
+			   asan_shadow_set((addr)) ? "yes" : "no");          \
+	} while (0)
+
+/*
+ * Emit an error and force the current function to exit if the ASAN
+ * violation state is unexpected. Reset the violation state after.
+ */
+#define ASAN_VALIDATE_ADDR(cond, addr)                                  =
     \
+	do {                                                                 \
+		asm volatile("" ::: "memory");                               \
+		if ((asan_violated !=3D 0) !=3D (cond)) {                        \
+			bpf_printk("%s:%d ASAN asan_violated %lx", __func__, \
+				   __LINE__, (u64)asan_violated);            \
+			ASAN_MAP_STATE((addr));                              \
+			return -EINVAL;                                      \
+		}                                                            \
+		asan_violated =3D 0;                                           \
+	} while (0)
+
+#define ASAN_VALIDATE()                                                 =
\
+	do {                                                            \
+		if ((asan_violated)) {                                  \
+			bpf_printk("%s:%d Found ASAN violation at %lx", \
+				   __func__, __LINE__, asan_violated);  \
+			return -EINVAL;                                 \
+		}                                                       \
+	} while (0)
+
+struct blob {
+	volatile u8 mem[59];
+	u8 oob;
+};
+
+
--=20
2.47.3

