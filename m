Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633521;
	b=texo6oyhSu0Eg6Z8TbKz0nMM/7JUXpI/OTitkp7NJM5URtSGosXOR5ZTxI+oHJDzrnMc
	 Ii0KdqpkfATDV+MHJAdzrYCDrfNBK3dAW231oRHb7wP6o9JN0jnEW+qxRRonD3qLXGM5V
	 8gu2sQdq3jxl7kbN9hPVUjc0Y3AfQ/QgTX0t6jj9K5IXATB0de2erSlKF1CpSgdus4F8r
	 08XH8e/LvN/PZAHrMlaFFxCv9aq6d3v9NQMf+1XJaOehC43dLDD652OC+Q2TyIE8JPbTP
	 6OCJF7HnzPlLYqW3XIBcxIPu3ZtEnFiY0IVsUNS51Mu7LIMcXzJ+bZOoqSpzjjZcLiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uownxxlc/OxsG2uE67UEpzl/p5NCMPeOz9JctVFhrsg=;
	b=E4sq5z/5iofqtMgm8iBP6ZwjyAm7d74VXCBq2GQXxVCO2sOSTDimMMlF96TXhYgFy6wk
	 AnBMHySydzOqno1nzC7fAuisDF/jdv8ngI5l4ERJa4eFi5g9ZCtI98SyKkz5EfLKKQJuN
	 375He4URQqqoh8OJmN6NuWMQXDXWcoDCFqctU0SigHRknUE353XgocK+tZpYbUFQNk+ZE
	 Yly97HMcs58Cu67v61H4YYwfECDZ3k/cykqKP4kf1bBFqkXIsM1sD2eMXWi1SspTzQYmA
	 yBQnPQyMJM1dcSraqClNG1fkLslewcRImXmacEQzplocYRwCNIlBxwyS7x7n7wMn3aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IYwsZgeJ;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498F606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0498F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IYwsZgeJ
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1120318b3a.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633520; x=1795238320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uownxxlc/OxsG2uE67UEpzl/p5NCMPeOz9JctVFhrsg=;
        b=IYwsZgeJMagLkPUO9pMF9qx/UBsicPFPmFpYebsTRV+Tzrb3tmRH/g02VBBReay6T4
         lUR/osQC3ae8Rv8ykxwNEyIEgEpaE7ji5deALMZF2CkHkK825H88H1ke18CqDepyp+p1
         51lSuOuB4oHY1z9Wczxf3qyb+hzT7gh4H6spKXUhV+qCl8yRtQl4STCWplxq2erm35HT
         xu+CWbpuV5y18mi1EyU68unKUjsKONn+/N6+j7EFlVt27nlbwh7Q78GH+W/PQjqCWh+5
         vOYI1kfw4/h1QPOIgKk2dmp0+mzfwJQBtWqqfuv3tMJTw6/C6WRDS+X+0EoaPa+heh74
         kEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633520; x=1795238320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uownxxlc/OxsG2uE67UEpzl/p5NCMPeOz9JctVFhrsg=;
        b=kmGWnFm8u54J/hiZIRDD0ll1QogbU2CoC9BmKPm0vdl+Hu/SsF1R/K8OwNrN5MrUFp
         fsNmgTTJiUJRbMg26unlXJWAYaZ6O8FlyyUaBhQjB0FyrvmJOFiTbyDODwI+V4pe8qyQ
         xNUHtkrXeaFD5v9pU3+oAvH3H3aB0LuifX9FmuNcr7b0dzUQMWF1k6E9jD4yxfNmXZVx
         DtDdUrOr24KnkGQ5LyuvpjAUjOps2gltHdO47tYoANtC+n0UKs12KAgap1tfxpwp0Grp
         ul+H8KNFveu5cwxaMO+TkHqM4GVVHltkUlAtRqJCBEGRCVItbCB1entQ4PgQGktCN4XD
         RJEQ==
X-Gm-Message-State: APuU4Z+/sMC0JGDbPoS/HKXFM6N71k7XuXBVfHkMEOfJGe9W1trqqcba
	wswEy13kuLXauuRQSK+Q0CIoaA98+BGfTVaHdm6xAbSI5009vN651gLgttmyWA==
X-Gm-Gg: AYBFou2UfsJfVJXNSvDjZEd6Ik/9TFmyAEvJfOdDhXQO67y9WFilPv1xqyQlay17LDX
	uZNykludIxheDTYgOXS2Nv3JV5ymfKyksCFjtRCsrAU2a2myduAc2Hr5aLQVIFWibLV+8gT3jfo
	FO+N47+2G3k9tbYJmogJcZYOM6aySWnGK1sOlPc1531A9fQPBmniDWypMkDtacx8yDK9rJjZu1c
	gWJo7Z+mgVP/rAW0xstdEmUC1J6e36/EZjlfHr/vWdOHbkQ4f7yu5t1bv20ipP1cnZRTUz1Q/VW
	/T1XKEIQDhY1ZPaH0KQvuODZvBTex1WkzSNLD+DrsXW4rbzApixMNSFZHj04d0HAPw6xdI623nI
	iWwKbKl8F5V0jsVti+OGyJVWJGXiQiE9Fn1/UJ1oQLizh4zB00FYxtZi1GZOaHIkplSckAJL2Cw
	RF7Z1cdKTDxZ/N8obRpWi6xzrO3yPEw3nOgnVeuBC5NwvSqTieYvDAZiAXQqg3fsigzhKSE2iOi
	JND2+6aeiTjsJmIx7bh8dBxNMMa2u3kRaR9Nts385jHUkZDh/UhMGORYmNmRLbOH2yFPVbXcGmf
	Svs7y6bw6TdEYlJNEm6blqNmEt4MUeqStTfS5Pdfr12kA8UBn5LhrnvDxiNXOlsC4MYqhTqiKhx
	bz2yYMeW2sOrDDfFCpWddYVUD25MC8DdzCWeS295hRfjHgxmnUqtMinhNS1cX7AA/UVy8mUkVJg
	==
X-Received: by 2002:a05:6a00:981:b0:8a0:7dc4:95c0 with SMTP id d2e1a72fcca58-8beb7055ed1mr5004038b3a.15.1794633519908;
        Fri, 13 Nov 2026 21:18:39 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8682sm1869357b3a.10.2026.11.13.21.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:18:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 05/11] resolve_btfids: Tag the functions that return errors
Date: Sat, 14 Nov 2026 05:17:59 +0000
Message-ID: <20261114051805.683966-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Protopopov <a.s.protopopov@gmail.com>

	SEC("fmod_ret/vfs_fallocate")
	int BPF_PROG(no_collapse, struct file *file, int mode,
		     loff_t offset, loff_t len, int ret)
	{
		return mode & FALLOC_FL_COLLAPSE_RANGE ? -EOPNOTSUPP : 0;
	}

This program keeps user space away from a bug in one mode of fallocate()
until the fixed kernel runs. It does not load: "vfs_fallocate() is not
modifiable". The declared targets are the security hooks, the error
injection list (1000 syscall entries and 16 functions) and five more
functions.

vfs_fallocate() returns -EOPNOTSUPP itself, so its callers can get that
error today. The build can find such functions, and their errors. With
--fmodret_scan resolve_btfids does that for each FUNC of BTF:

	FUNC -> image_func() -> decode -> data flow -> constants -4095..-1
	                                                  |
	DECL_TAG 'bpf_fmodret_retval:-95,-29,-27,-26,-22,-21,-19,-9,-1'
	         type_id=<vfs_fallocate>

It reads the file that pahole has just read. So it sees the code after
inlining and after the link, of GCC and of clang, of vmlinux and modules.

	A function gets a tag only if
	  return type   BTF says: integer or enum of 4 or 8 bytes
	  name          one ELF function has the name of the FUNC
	and a program can attach to it
	  parameters    BTF says: at most 12 of at most 16 bytes, no "..."
	  section       it is not .init.text
	  entry         it has the nop, or "call __fentry__", that ftrace
	                patches. A notrace function has none
	An error is left out of the list if
	  8 bytes       the constant is zero extended: 0xffffffea
	  meaning       -512 and below, -EAGAIN, -EMSGSIZE, -EINPROGRESS:
	                these tell the caller to retry, to go on, to wait
	  -1 alone      it is -1 and the only error. -1 is also "less" or
	                "not found": the machine code cannot tell

CONFIG_BPF_FMODRET_SCAN turns it on, for x86-64 and arm64. The default is
off. At this patch an x86-64 build with GCC prints

  FMODRET 12076 of 78350 functions are tagged,
	  0 of the 35445 which were scanned cannot be decoded

A function that cannot be decoded gets no tag. The link fails if that is
more than 1 % of the scanned functions, or if vmlinux gets no tag. BTF
grows by 3 %, and resolve_btfids takes 0.4 s more for vmlinux.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/Kconfig                       |  19 ++
 scripts/Makefile.btf                     |   1 +
 tools/bpf/resolve_btfids/Build           |   3 +
 tools/bpf/resolve_btfids/fmodret.c       | 166 +++++++++++++++++
 tools/bpf/resolve_btfids/fmodret.h       |  12 ++
 tools/bpf/resolve_btfids/fmodret_scan.c  | 219 +++++++++++++++++++++++
 tools/bpf/resolve_btfids/fmodret_scan.h  |  22 +++
 tools/bpf/resolve_btfids/main.c          |  11 ++
 tools/bpf/resolve_btfids/text_insn.h     |   6 +
 tools/bpf/resolve_btfids/text_mc.cpp     |   6 +
 tools/bpf/resolve_btfids/text_mc.h       |   2 +
 tools/bpf/resolve_btfids/text_mc_arm64.c |   2 +
 tools/bpf/resolve_btfids/text_mc_x86.c   |   3 +
 13 files changed, 472 insertions(+)
 create mode 100644 tools/bpf/resolve_btfids/fmodret.c
 create mode 100644 tools/bpf/resolve_btfids/fmodret.h
 create mode 100644 tools/bpf/resolve_btfids/fmodret_scan.c
 create mode 100644 tools/bpf/resolve_btfids/fmodret_scan.h

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 2b7bbb9bd5f8..d705d7b38b5f 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -110,6 +110,25 @@ config BPF_CRYPTO
 
 source "kernel/bpf/preload/Kconfig"
 
+config BPF_FMODRET_SCAN
+	bool "Find the functions which fmod_ret programs can attach to"
+	depends on BPF_SYSCALL && DEBUG_INFO_BTF
+	depends on X86_64 || ARM64
+	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	depends on $(success,$(srctree)/tools/bpf/resolve_btfids/llvm-mc.sh $(SRCARCH))
+	help
+	  Let resolve_btfids read the machine code of the kernel and of the
+	  modules, and tag the functions which return errors in BTF. An
+	  fmod_ret program can attach to such a function and return one of
+	  its errors instead of running it, for example to keep user space
+	  away from a bug until the kernel is updated.
+
+	  The build host needs a C++17 compiler and the headers and libraries
+	  of LLVM 17 or later with the target of the kernel, whatever compiles
+	  the kernel. tools/bpf/resolve_btfids/llvm-mc.sh tells what is missing.
+	  It only looks whether they are installed. The build stops if
+	  resolve_btfids cannot be built with them.
+
 config BPF_LSM
 	bool "Enable BPF LSM Instrumentation"
 	depends on BPF_EVENTS
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 98012344a81e..02ff1702e1e8 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -35,5 +35,6 @@ resolve-btfids-flags-y :=
 resolve-btfids-flags-$(CONFIG_WERROR) += --fatal_warnings
 resolve-btfids-flags-$(if $(KBUILD_EXTMOD),y) += --distill_base
 resolve-btfids-flags-$(if $(KBUILD_VERBOSE),y) += --verbose
+resolve-btfids-flags-$(CONFIG_BPF_FMODRET_SCAN) += --fmodret_scan
 
 export RESOLVE_BTFIDS_FLAGS := $(resolve-btfids-flags-y)
diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
index cd42283bb929..bfbde4c49dde 100644
--- a/tools/bpf/resolve_btfids/Build
+++ b/tools/bpf/resolve_btfids/Build
@@ -2,6 +2,8 @@ hostprogs := resolve_btfids
 
 resolve_btfids-y += main.o
 resolve_btfids-y += btf_colors.o
+resolve_btfids-y += fmodret.o
+resolve_btfids-y += fmodret_scan.o
 resolve_btfids-y += image.o
 resolve_btfids-y += text_flow.o
 resolve_btfids-$(LLVM_MC) += text_mc.o
@@ -13,6 +15,7 @@ resolve_btfids-y += ctype.o
 resolve_btfids-y += str_error_r.o
 
 # The inner loops of --fmodret_scan
+HOSTCFLAGS_fmodret_scan.o += -O2
 HOSTCFLAGS_text_flow.o += -O2
 
 # LLVM's C++ API may have moved on, see Makefile
diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
new file mode 100644
index 000000000000..8f43e92f32bf
--- /dev/null
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Tag the functions which fmod_ret programs can attach to, because they return
+ * errors: "bpf_fmodret_retval:-22,-12". fmodret_scan.c finds the errors in the
+ * machine code. This file decides which functions it looks at, and which of the
+ * errors count.
+ *
+ * A function which no program can attach to gets no tag: ftrace has to find a nop
+ * at its entry, see scan_func(), and a BPF trampoline has to take its parameters.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <bpf/btf.h>
+
+#include "fmodret.h"
+#include "fmodret_scan.h"
+#include "image.h"
+
+#define TAG	"bpf_fmodret_retval:"
+
+/* Return the size of the integer which FUNC returns, or 0 */
+static __u32 int_return_size(const struct btf *btf, const struct btf_type *func)
+{
+	const struct btf_type *t = btf__type_by_id(btf, func->type);
+	int ret = t->type ? btf__resolve_type(btf, t->type) : -1;
+
+	if (ret < 0)
+		return 0;
+	t = btf__type_by_id(btf, ret);
+	return btf_is_int(t) || btf_is_any_enum(t) ? t->size : 0;
+}
+
+/* As btf_distill_func_proto(): at most 12 parameters of at most 16 bytes, and no "..." */
+static bool fits_trampoline(const struct btf *btf, const struct btf_type *func)
+{
+	const struct btf_type *t = btf__type_by_id(btf, func->type);
+	unsigned int i;
+
+	for (i = 0; i < btf_vlen(t); i++) {
+		__u32 type = btf_params(t)[i].type;
+
+		if (!type || btf__resolve_size(btf, type) > 16)
+			return false;
+	}
+	return btf_vlen(t) <= 12;
+}
+
+/*
+ * The codes of include/linux/errno.h, 512 and up, never reach user space. They,
+ * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go on or to
+ * wait, not that the function failed. Their numbers are those of the kernel, in
+ * asm-generic/errno.h. The errno.h of the build host can have other numbers.
+ */
+static bool means_failure(int error)
+{
+	return error > -512 && error != -11 && error != -90 && error != -115;
+}
+
+static int cmp_error(const void *va, const void *vb)
+{
+	return *(const int *)va - *(const int *)vb;
+}
+
+/*
+ * Write the tag for a function which returns SIZE bytes, and in them one of the
+ * NR VALUES of the return value register. In 8 bytes an error is sign extended.
+ * Return false if there is nothing to tag.
+ *
+ * The machine code cannot tell the -EPERM of a permission check from the -1 of a
+ * comparator or of "no such index": a function whose only error is -1 has none.
+ */
+static bool format_tag(char *tag, const int64_t *values, size_t nr, __u32 size)
+{
+	size_t i, n = 0;
+	int errors[nr];
+
+	for (i = 0; i < nr; i++) {
+		int error = values[i];
+
+		if ((size == 4 || values[i] == error) && means_failure(error))
+			errors[n++] = error;
+	}
+	qsort(errors, n, sizeof(*errors), cmp_error);
+	tag += sprintf(tag, TAG);
+	for (i = 0; i < n; i++)
+		if (!i || errors[i] != errors[i - 1])
+			tag += sprintf(tag, "%s%d", i ? "," : "", errors[i]);
+	return n && errors[0] < -1;
+}
+
+int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
+{
+	size_t nr_funcs = 0, nr_scanned = 0, nr_undecodable = 0, nr_tags = 0;
+	const struct btf *base = btf__base_btf(btf);
+	__u32 id, nr_types = btf__type_cnt(btf);
+	struct scan *scan = NULL;
+	struct image img;
+	char counts[200];
+	int err;
+
+	err = image_open(&img, elf);
+	if (err)
+		goto out;
+	err = -EINVAL;
+	scan = scan_open(&img);
+	if (!scan)
+		goto out;
+
+	for (id = base ? btf__type_cnt(base) : 1, err = 0; id < nr_types && err >= 0; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const struct image_func *func;
+		const int64_t *values;
+		const char *name;
+		__u32 size;
+
+		if (!btf_is_func(t))
+			continue;
+		nr_funcs++;
+		size = int_return_size(btf, t);
+		if ((size != 4 && size != 8) || !fits_trampoline(btf, t))
+			continue;
+		/* Init code is gone before a program can attach */
+		name = btf__name_by_offset(btf, t->name_off);
+		func = image_func(&img, name);
+		if (!func || !strcmp(func->section, ".init.text"))
+			continue;
+		nr_scanned++;
+		err = scan_func(scan, func, &values);
+		if (err == -EINVAL) {
+			nr_undecodable++;
+			err = 0;
+		}
+		if (err > 0) {
+			char tag[sizeof(TAG) + 6 * err];
+
+			if (!format_tag(tag, values, err, size))
+				continue;
+			if (verbose > 1)
+				fprintf(stderr, "fmodret: %s %s\n", name, tag + strlen(TAG));
+			err = btf__add_decl_tag(btf, tag, id, -1);
+			nr_tags++;
+		}
+	}
+	snprintf(counts, sizeof(counts),
+		 "%zu of %zu functions are tagged, %zu of the %zu which were scanned cannot be decoded",
+		 nr_tags, nr_funcs, nr_undecodable, nr_scanned);
+	/*
+	 * A function which cannot be decoded costs a target, not the build. But
+	 * if the decoder is lost in the code of vmlinux, don't leave that to be
+	 * found out by a program which does not load.
+	 */
+	if (err >= 0 && !base && (!nr_tags || nr_undecodable > nr_scanned / 100)) {
+		fprintf(stderr, "FAILED: --fmodret_scan: %s\n", counts);
+		err = -EINVAL;
+	} else if (!base || verbose) {
+		printf("  FMODRET %s\n", counts);
+	}
+out:
+	scan_close(scan);
+	image_close(&img);
+	return err < 0 ? err : 0;
+}
diff --git a/tools/bpf/resolve_btfids/fmodret.h b/tools/bpf/resolve_btfids/fmodret.h
new file mode 100644
index 000000000000..d61a9de026df
--- /dev/null
+++ b/tools/bpf/resolve_btfids/fmodret.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __RESOLVE_BTFIDS_FMODRET_H
+#define __RESOLVE_BTFIDS_FMODRET_H
+
+#include <libelf.h>
+
+struct btf;
+
+/* Tag the functions of ELF which return errors in BTF */
+int fmodret_tag(Elf *elf, struct btf *btf, int verbose);
+
+#endif
diff --git a/tools/bpf/resolve_btfids/fmodret_scan.c b/tools/bpf/resolve_btfids/fmodret_scan.c
new file mode 100644
index 000000000000..6df10be92610
--- /dev/null
+++ b/tools/bpf/resolve_btfids/fmodret_scan.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Find the errors which a function of an image returns, in the machine code:
+ * the constants -MAX_ERRNO..-1 which an instruction loads into a register and
+ * which copies may carry from there to the return value register at a return.
+ *
+ * This file brings the function into the form which the analysis in text_flow.c
+ * takes, and collects the results.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/bits.h>
+
+#include "fmodret_scan.h"
+#include "text_flow.h"
+
+#define MAX_ERRNO	4095
+#define MAX_SUBFUNCS	3
+
+struct scan {
+	const struct image *img;
+	uint64_t return_thunk;
+	uint64_t entry_hook;
+	/* The function which is being looked at */
+	struct text_flow flow;
+	size_t max_insns;
+	int64_t *values;
+	size_t nr_values, max_values;
+};
+
+/* Append the instructions of SIZE bytes at ADDR */
+static int decode(struct scan *s, uint64_t addr, uint64_t size)
+{
+	struct text_flow *flow = &s->flow;
+	const unsigned char *code;
+	uint64_t off;
+	size_t avail;
+
+	code = image_bytes(s->img, addr, &avail);
+	if (!code || avail < size)
+		return -EINVAL;
+	for (off = 0; off < size; off += flow->insns[flow->nr_insns++].len) {
+		const struct image_reloc *reloc;
+		struct text_insn *insn;
+
+		if (flow->nr_insns == s->max_insns) {
+			size_t max = s->max_insns ? 2 * s->max_insns : 1024;
+			struct text_facts *facts = realloc(flow->facts, max * sizeof(*facts));
+
+			if (!facts)
+				return -ENOMEM;
+			flow->facts = facts;
+			insn = realloc(flow->insns, max * sizeof(*insn));
+			if (!insn)
+				return -ENOMEM;
+			flow->insns = insn;
+			s->max_insns = max;
+		}
+		insn = &flow->insns[flow->nr_insns];
+		if (flow->arch->decode(code + off, size - off, addr + off, insn) < 0)
+			return -EINVAL;
+		insn->addr = addr + off;
+
+		if (insn->kind < TEXT_BRANCH || !insn->imm)
+			continue;
+		/* The field is relative to its own address, and 0 in a relocatable file */
+		reloc = image_reloc(s->img, insn->addr, insn->len);
+		if (reloc)
+			insn->imm += reloc->target - reloc->addr;
+		if (insn->kind == TEXT_BRANCH && insn->imm == s->return_thunk)
+			insn->kind = TEXT_RETURN;
+		/* ftrace makes it a nop when the kernel boots */
+		if (insn->kind == TEXT_CALL && insn->imm == s->entry_hook) {
+			insn->kind = TEXT_OTHER;
+			insn->nop = true;
+		}
+	}
+	return 0;
+}
+
+static int cmp_addr(const void *va, const void *vb)
+{
+	const struct image_func * const *a = va, * const *b = vb;
+
+	return (*a)->addr > (*b)->addr ? 1 : (*a)->addr < (*b)->addr ? -1 : 0;
+}
+
+/*
+ * Decode F and its cold subfunctions: compilers move unlikely blocks of F to a
+ * symbol of their own, F.cold or F.__part.1. By name they follow F.
+ */
+static int decode_func(struct scan *s, const struct image_func *f)
+{
+	const struct image_func *funcs[1 + MAX_SUBFUNCS] = { f }, *g;
+	const struct image_func *end = s->img->funcs + s->img->nr_funcs;
+	size_t len = strlen(f->name);
+	unsigned int nr = 1, i;
+	int err = 0;
+
+	for (g = f + 1; g < end && !strncmp(g->name, f->name, len) && g->name[len] == '.'; g++)
+		if (nr <= MAX_SUBFUNCS &&
+		    (!strncmp(g->name + len, ".cold", 5) || !strncmp(g->name + len, ".__part.", 8)))
+			funcs[nr++] = g;
+	qsort(funcs, nr, sizeof(*funcs), cmp_addr);
+	s->flow.nr_insns = 0;
+	for (i = 0; !err && i < nr; i++)
+		err = decode(s, funcs[i]->addr, funcs[i]->size);
+	return err;
+}
+
+/*
+ * ftrace, and with it a BPF trampoline, attaches to a function through the nop
+ * which the compiler leaves at ENTRY, or behind a landing pad: endbr64 and bti c
+ * have 4 bytes.
+ */
+static bool has_entry_nop(const struct text_flow *flow, uint64_t entry)
+{
+	u32 i;
+
+	for (i = 0; i < flow->nr_insns; i++)
+		if (flow->insns[i].nop && flow->insns[i].addr - entry <= 4)
+			return true;
+	return false;
+}
+
+/* The return value register may hold V */
+static int add_value(struct scan *s, int64_t v)
+{
+	size_t i;
+
+	if ((int32_t)v < -MAX_ERRNO || (int32_t)v >= 0)
+		return 0;
+	for (i = 0; i < s->nr_values; i++)
+		if (s->values[i] == v)
+			return 0;
+	if (s->nr_values == s->max_values) {
+		size_t max = s->max_values ? 2 * s->max_values : 16;
+		int64_t *values = realloc(s->values, max * sizeof(*values));
+
+		if (!values)
+			return -ENOMEM;
+		s->values = values;
+		s->max_values = max;
+	}
+	s->values[s->nr_values++] = v;
+	return 0;
+}
+
+int scan_func(struct scan *s, const struct image_func *f, const int64_t **values)
+{
+	const struct text_flow *flow = &s->flow;
+	int err = decode_func(s, f);
+	u32 i;
+
+	if (err)
+		return err;
+	if (!has_entry_nop(flow, f->addr))
+		return 0;
+	text_flow_solve(&s->flow);
+
+	s->nr_values = 0;
+	for (i = 0; i < flow->nr_insns && !err; i++) {
+		const struct text_insn *insn = &flow->insns[i];
+		uint64_t imm[2] = { insn->imm, insn->imm2 };
+		struct text_facts out;
+		unsigned int n;
+
+		if (insn->kind != TEXT_MOV_IMM && insn->kind != TEXT_SELECT_IMM)
+			continue;
+		out = text_flow_out(flow, i);
+		for (n = 0; n < 2 && !err; n++) {
+			if (out.same & BIT(insn->dst))
+				err = add_value(s, imm[n]);
+			if (!err && out.zext & BIT(insn->dst))
+				err = add_value(s, (uint32_t)imm[n]);
+			if (!err && out.sext & BIT(insn->dst))
+				err = add_value(s, (int32_t)imm[n]);
+		}
+	}
+	*values = s->values;
+	return err ?: s->nr_values;
+}
+
+struct scan *scan_open(const struct image *img)
+{
+	struct scan *s = calloc(1, sizeof(*s));
+	GElf_Ehdr ehdr;
+
+	if (!s || !gelf_getehdr(img->elf, &ehdr))
+		goto err;
+	s->flow.arch = text_arch_init(ehdr.e_machine);
+	if (!s->flow.arch) {
+		fprintf(stderr, "FAILED: no decoder for the code of ELF machine %u\n", ehdr.e_machine);
+		goto err;
+	}
+	s->img = img;
+	if (s->flow.arch->return_thunk)
+		s->return_thunk = image_symbol(img, s->flow.arch->return_thunk);
+	if (s->flow.arch->entry_hook)
+		s->entry_hook = image_symbol(img, s->flow.arch->entry_hook);
+	return s;
+err:
+	free(s);
+	return NULL;
+}
+
+void scan_close(struct scan *s)
+{
+	if (!s)
+		return;
+	free(s->flow.insns);
+	free(s->flow.facts);
+	free(s->values);
+	free(s);
+}
diff --git a/tools/bpf/resolve_btfids/fmodret_scan.h b/tools/bpf/resolve_btfids/fmodret_scan.h
new file mode 100644
index 000000000000..ef3b4ed4d189
--- /dev/null
+++ b/tools/bpf/resolve_btfids/fmodret_scan.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __RESOLVE_BTFIDS_FMODRET_SCAN_H
+#define __RESOLVE_BTFIDS_FMODRET_SCAN_H
+
+#include <stdint.h>
+
+#include "image.h"
+
+struct scan;
+
+/* Return NULL, after a message, if the code of IMG cannot be read */
+struct scan *scan_open(const struct image *img);
+void scan_close(struct scan *scan);
+/*
+ * Find the constants which FUNC returns and whose low 32 bits are an error. Set
+ * VALUES to what the return value register holds then, until the next call.
+ * A function which ftrace cannot patch has none: no program can attach to it.
+ * Return how many there are, or -EINVAL if the code cannot be decoded.
+ */
+int scan_func(struct scan *scan, const struct image_func *func, const int64_t **values);
+
+#endif
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index c16dd93fa6d4..0ac895222a14 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -69,6 +69,10 @@
  *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
  *
  * These kfunc annotations were historically produced by pahole.
+ *
+ * With --fmodret_scan it also reads the machine code, and emits a
+ * "bpf_fmodret_retval:<errors>" decl tag for each function which returns errors,
+ * see fmodret.c.
  */
 
 #define  _GNU_SOURCE
@@ -90,6 +94,7 @@
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include "btf_colors.h"
+#include "fmodret.h"
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
@@ -2098,6 +2103,7 @@ int main(int argc, const char **argv)
 	struct btf_links btf_links = {};
 	bool fatal_warnings = false;
 	bool resolve_btfids = true;
+	bool fmodret_scan = false;
 	char out_path[PATH_MAX];
 
 	struct option btfid_options[] = {
@@ -2113,6 +2119,8 @@ int main(int argc, const char **argv)
 			    "distill --btf_base and emit .BTF.base section data"),
 		OPT_BOOLEAN(0, "inline", &obj.extract_inline,
 			    "extract location BTF into a .BTF.inline file"),
+		OPT_BOOLEAN(0, "fmodret_scan", &fmodret_scan,
+			    "tag the functions which return errors as fmod_ret targets"),
 		OPT_CALLBACK(0, "btf_link", &btf_links, "section:module:btf-file",
 			     "patch a BTF link with --patch_btfids", parse_btf_link),
 		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
@@ -2174,6 +2182,9 @@ int main(int argc, const char **argv)
 	if (btf2btf(&obj))
 		goto out;
 
+	if (fmodret_scan && fmodret_tag(obj.efile.elf, obj.btf, verbose))
+		goto out;
+
 	if (finalize_btf(&obj))
 		goto out;
 
diff --git a/tools/bpf/resolve_btfids/text_insn.h b/tools/bpf/resolve_btfids/text_insn.h
index 210d749439e7..0ead445f5442 100644
--- a/tools/bpf/resolve_btfids/text_insn.h
+++ b/tools/bpf/resolve_btfids/text_insn.h
@@ -38,6 +38,7 @@ struct text_insn {
 	u8 len;
 	u8 dst, src, src2;
 	bool is32;	/* It works on the low 32 bits and zero extends the result */
+	bool nop;	/* It does nothing */
 	/* The registers which it writes, but for dst */
 	u32 defs;
 	u64 imm, imm2;
@@ -51,6 +52,11 @@ struct text_arch {
 	u32 caller_saved;	/* the registers which a call may write */
 	/* A branch to this symbol is a return */
 	const char *return_thunk;
+	/*
+	 * The build may leave a call of this symbol where ftrace patches a nop, at
+	 * the entry of a function. It writes no register.
+	 */
+	const char *entry_hook;
 	/*
 	 * Describe the instruction at ADDR, whose bytes are at CODE. At most LEN
 	 * bytes can be read. Return a negative value if it is not an instruction.
diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
index e7166ad4b871..cb57f9db9f9d 100644
--- a/tools/bpf/resolve_btfids/text_mc.cpp
+++ b/tools/bpf/resolve_btfids/text_mc.cpp
@@ -61,6 +61,7 @@ struct Opcode {
 	u32 implicit_defs = 0;
 	unsigned int implicit_def = 0, implicit_use = 0;	/* the first ones, LLVM registers */
 	bool unmodeled = false, is_return = false;
+	const mc_pattern *nop = nullptr;
 	std::vector<const mc_pattern *> patterns;
 };
 
@@ -198,6 +199,8 @@ bool read_opcodes()
 		} else {
 			it->second->unmodeled = false;
 			it->second->implicit_defs |= pattern->defs;
+			if (pattern->nop)
+				it->second->nop = pattern;
 		}
 	}
 	return ok;
@@ -340,6 +343,7 @@ int decode(const void *code, unsigned int len, u64 addr, text_insn *ti)
 
 	const Opcode &o = d.opcodes[inst.getOpcode()];
 
+	ti->nop = o.nop && holds(inst, o.nop->predicates[0]);
 	ti->defs = defs_of(inst, o);
 	for (const mc_pattern *pattern : o.patterns) {
 		if (match(inst, o, *pattern, ti)) {
@@ -353,6 +357,7 @@ int decode(const void *code, unsigned int len, u64 addr, text_insn *ti)
 
 void print(raw_ostream &os, const text_insn &ti)
 {
+	os << "nop " << ti.nop << " ";
 	os << "kind " << (int)ti.kind << " is32 " << ti.is32 << " dst " << (int)ti.dst
 	   << " src " << (int)ti.src << " src2 " << (int)ti.src2
 	   << " defs " << format_hex(ti.defs, 1) << " imm " << format_hex(ti.imm, 1)
@@ -373,6 +378,7 @@ bool run_tests()
 		while (in >> std::hex >> byte)
 			code.push_back(byte);
 		if (!decode(code.data(), code.size(), MC_TEST_ADDR, &ti) && ti.len == code.size() &&
+		    ti.nop == want.nop &&
 		    ti.kind == want.kind && ti.is32 == want.is32 && ti.dst == want.dst &&
 		    ti.src == want.src && ti.src2 == want.src2 &&
 		    ti.defs == want.defs && ti.imm == want.imm && ti.imm2 == want.imm2)
diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
index 9d39095aab20..8eef0860aa1c 100644
--- a/tools/bpf/resolve_btfids/text_mc.h
+++ b/tools/bpf/resolve_btfids/text_mc.h
@@ -48,6 +48,7 @@ struct mc_predicate {
  * how LLVM says that MCInstrDesc does not tell all about an opcode: it writes
  * TEXT_ALL_REGS, unless such a pattern says that it writes what MCInstrDesc
  * has, and DEFS.
+ * With NOP the instruction is a nop if the first predicate holds.
  *
  * A pattern of kind TEXT_RETURN names a return to the caller. isReturn() holds
  * for a return from an exception as well, which does not hand the return value
@@ -68,6 +69,7 @@ struct mc_pattern {
 	bool fixed;		/* the immediate is VALUE, not an operand */
 	s64 value;
 	u32 defs;		/* of TEXT_OTHER */
+	bool nop;		/* of TEXT_OTHER */
 	struct mc_predicate predicates[2];
 };
 
diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
index 9cc44281242b..546a9d319126 100644
--- a/tools/bpf/resolve_btfids/text_mc_arm64.c
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -24,6 +24,7 @@ static const struct mc_pattern arm64_patterns[] = {
 	{ "ANDWrs",	 TEXT_SELECT, .src = 1, .src2 = 1, .predicates = { IMM(3, 2 << 6 | 31) } },
 	/* HINT: nop, bti, yield, wfe ... */
 	{ "HINT", TEXT_OTHER }, { "AUTIASP", TEXT_OTHER }, { "PRFMui", TEXT_OTHER },
+	{ "HINT", TEXT_OTHER, .nop = true, .predicates = { IMM(0, 0) } },	/* nop */
 	{ "DMB", TEXT_OTHER }, { "MRS", TEXT_OTHER }, { "MSR", TEXT_OTHER },
 	{ "STLRB", TEXT_OTHER }, { "STLRW", TEXT_OTHER },
 	WX("LDXR", "", TEXT_OTHER), WX("STXR", "", TEXT_OTHER), WX("STLXR", "", TEXT_OTHER),
@@ -56,6 +57,7 @@ static const struct mc_test arm64_tests[] = {
 	T("00 05 89 1a", TEXT_SELECT, .is32 = true, SRC(8)),		/* csinc w0, w8, w9, eq */
 	T("00 7d 89 0a", TEXT_SELECT, .is32 = true, SRC(8)),		/* and w0, w8, w9, asr #31 */
 	T("00 01 09 0a", TEXT_OTHER, .defs = BIT(0)),			/* and w0, w8, w9 */
+	T("1f 20 03 d5", TEXT_OTHER, .nop = true),			/* nop */
 	T("5f 24 03 d5", TEXT_OTHER),					/* bti c */
 	T("bf 23 03 d5", TEXT_OTHER, .defs = BIT(30)),			/* autiasp */
 	T("20 00 80 f9", TEXT_OTHER),					/* prfm pldl1keep, [x1] */
diff --git a/tools/bpf/resolve_btfids/text_mc_x86.c b/tools/bpf/resolve_btfids/text_mc_x86.c
index 11223cd1c077..d907fac001c8 100644
--- a/tools/bpf/resolve_btfids/text_mc_x86.c
+++ b/tools/bpf/resolve_btfids/text_mc_x86.c
@@ -27,6 +27,7 @@ static const struct mc_pattern x86_patterns[] = {
 	{ "SBB64rr",		TEXT_MOV_IMM, VALUE(-1), .or_zero = true, .predicates = { SAME_REG(1, 2) } },
 	{ "SAR32ri",		TEXT_MOV_IMM, VALUE(-1), .or_zero = true, .predicates = { IMM(2, 31) } },
 	{ "LOCK_PREFIX",	TEXT_OTHER },
+	{ "NOOPL",		TEXT_OTHER, .nop = true },
 	/* A rep prefix is not a part of the MCInst */
 	{ "STOSQ",		TEXT_OTHER, .defs = BIT(RCX) },
 	{ "RET64",		TEXT_RETURN },
@@ -58,6 +59,7 @@ static const struct mc_test x86_tests[] = {
 	T("0f 44 c3",		  TEXT_SELECT, .is32 = true, .src = RBX, .src2 = RAX),	/* cmove %ebx, %eax */
 	T("48 0f 44 c3",	  TEXT_SELECT, .src = RBX, .src2 = RAX),	/* cmove %rbx, %rax */
 	T("f0",			  TEXT_OTHER),					/* lock */
+	T("0f 1f 44 00 00",	  TEXT_OTHER, .nop = true),			/* nopl 0x0(%rax,%rax,1) */
 	T("f3 48 ab",		  TEXT_OTHER, .defs = BIT(RCX) | BIT(RDI)),	/* rep stosq */
 	/* hasUnmodeledSideEffects() */
 	T("f3 48 a5",		  TEXT_OTHER, .defs = TEXT_ALL_REGS),		/* rep movsq */
@@ -107,6 +109,7 @@ const struct mc_arch mc_arch = {
 		.caller_saved = BIT(RAX) | BIT(RCX) | BIT(RDX) | BIT(RSI) | BIT(RDI) |
 				BIT(R8) | BIT(R9) | BIT(R10) | BIT(R11),
 		.return_thunk = "__x86_return_thunk",
+		.entry_hook = "__fentry__",
 	},
 	.machine = EM_X86_64,
 	.triple = "x86_64-unknown-linux-gnu",
-- 
2.55.0

