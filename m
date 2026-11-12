Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502005;
	b=Xn1lRrmClNTLoF5Qv581bpF5rziLjNiCn0H0xy+omIZoYXzFh52FqmYtw2M4PgCB7D9H
	 ZKtA6dwBaMDsx6xtauyIhfXzF1fS1gKPkIvP2GKqx+nKyxmKj/hOkE26YJAfPYug26OYW
	 FHqBoPO2g/EZkjwjQOmTPwEY0zRcUibEQww46aj1Je8xeKZjAuPI7Cu87MWGHY57QE7qn
	 C6qbLSaG9MJEJyq+85bbr2Ws7wj+FZzCT71jZTaoD2FJx2nJIwW1pOOIlIxyA7Aa1VHXU
	 TuWIMzzYx0SDzxKYpAcHQf4h9v66UInnJU4j84SFoie20zW0EzwZg8+TF1LNMWdtSCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8O3ixvjqLAE7T+nOgcTT7GAGOf4Py8RawbEQhUKmaYE=;
	b=djY5PrpwgPQZhGUG+GbvruvMSbuv8lCFTM3apUi2KHHNbZNatC8t0Y9Esly7IwRuXQb2
	 xO/dq7fTcBB+nu2V2ikzkDYPTZCRlkeiQboO+/e5Sh0rnZeNyOvOXLuiGCpDEE2sGlekn
	 kfol6kKcm1U/dUFaSq/xJOuRFBRWOjUSlSkpRIbbB/kcwj1Xn2DjYIPs622byWb34QPB7
	 0wXcLQhfbdkiTOcCocC6LSYdXoPnDaRSwfj6v3x1sK3auzZO0nwDvjcPI9VYq7IdaZ2wu
	 TIDtnDc5vYRbqsk6Cpduq8D2IDFKZAbmVhVz+OQwaltQ/UOn9yya6CVfVX6tAP5pjHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjcBdyMc;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BF7606A88A
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7BF7606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjcBdyMc
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso3075789a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794502004; x=1795106804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8O3ixvjqLAE7T+nOgcTT7GAGOf4Py8RawbEQhUKmaYE=;
        b=wjcBdyMcLzviZ8qopbAEFroCa5Ldl7a97IW2o4FBHjnva9F6ih3i0p7Y2Kvbo/tUbf
         GQ66HHSstlDjbpZzL4lMUyGVgVQlqpBjR+P2opQQr/idOeSuJZEIfxs8LL6RGmX5HrIH
         BwzpdU/SkYf1S10Cog0QdlYqGIxXvWCiFcT2Jlve5ULplOen+JU5cZL+m3PQ/z0UIr0h
         AKe5ZzM0qG5tdBk6sf5zqpXCeJA7q5tl4O8W9ilpNmKPkehspCdDdsLLrjZeczbBRNnj
         1CGurVkuNHYfQPlNynaiP+u222T7sobgaHQAu3Xo2SfwvNEoX8lI1brUIltlZvyRjs0s
         WqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502004; x=1795106804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8O3ixvjqLAE7T+nOgcTT7GAGOf4Py8RawbEQhUKmaYE=;
        b=o9Ja58PPpJBi0v7cIw+G/I8/V4y7d0Mi3yDL4VUGQFAAncyvKvJSFcpSUlfP3IWkGE
         DR1Az868IXh4YvAOHo9sIXbQ4LRPlPC0HPYiqdFuCIS0qFRw45JJoMH5iocWObMbWhCs
         fuvd+T0520GlJywy0xXLvJsYIbuOr+ArO0O2YFPZYhAb0bJMHrkB4B7nHVrg7iCkoE9r
         L39alOT6Xm1WJoRFsT5QoVYgfdErB/OFFpGG58Aoo7PVjeqnfqCk/vHfdLU2cjuPD1yo
         gc22InWzqdlGVcWAiN/hGw5qM4nvVeiczaGE1hyM9AFAF9d2e/9CFR986zugqIp9+8ix
         MpQg==
X-Gm-Message-State: APuU4Z9O9LV1BYb2VCGyNcRGjPgTcKizCcKvIx1AtTeI4jvIyc9neN+g
	gqEeZPreUD/utAMdQTx7EZXf50IzF9tz8gBY+xtaCwktajekES16X4j+TniYLw==
X-Gm-Gg: AYBFou2MkhbpFplvJBowGQCUw9AqyONWzMJUP1dRHuNYBwQyEVQamAocNOraSIHjM2s
	bi38HgQ372jbbRu5CPbFOetXv1aQwtDZx4N/I0WmnkO5/oKqZTVzUKklqqo4gRHhXkxKt7kXrtD
	J/kVTdC+eYoWn0oaQtTg3PKrMLiT7DwCCJ3QxcfKT1oFGHjjBpR1fctfsT0zHcMAWsWIHvT/FAs
	3y3W57Se/M8DOHZOx57ERPAblEcP3rma6kyQ0sru/urrNhcyPOQHSlpoPUiuNTvisRnJDF0bFOZ
	ayUyxdL1uaubUc/DbcMYFZ4mE3I4HE7fmNJ+8NDzyqjGtQeyDnOHMcwg22I3kdUq0VmtEJYWM7W
	BZyKmoEYxpPFYCvxaT3LQ5tCfK7S9dqxKaKzWNnx08MTC79maQsa58D3ynylXxlf5hRvp/9G85j
	1DpzsijiduqDGSbVhhmXhUAmqPz/7eCyrg6DjI1Nxxs/T1N/eGsz3bpip+Kj/XAILbTLeu2CnMX
	npudl2ZLJ5R6RxEoRmWEM7wjVaJL8cYOY8vFLRRYkJvBO/ldJ/j4o0J2I8rzEwqVxeVFcD3i16h
	TFLNz/e1AyOOWJLjSXX0Qd/1MeoLMXX9ZnpOkobUUJLhOxawQ4gf/qPgHDTcsNXxS+6HgUqY10i
	onAbYS3eQQZz1lK0Xbm706D6B1cmeqt/muztqLu58oEB2Im28+lff584ufH6M8kN+9xUomp7qzw
	==
X-Received: by 2002:a17:90a:dfcf:b0:3ab:884b:65b4 with SMTP id 98e67ed59e1d1-3b182f61ec2mr6284139a91.59.1794502003891;
        Thu, 12 Nov 2026 08:46:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec642d1sm121016a91.13.2026.11.12.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:46:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 05/10] resolve_btfids: Tag the functions that return errors
Date: Thu, 12 Nov 2026 16:46:05 +0000
Message-ID: <20261112164610.1917256-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
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

	A function is scanned if
	  return type   BTF says: integer or enum of 4 or 8 bytes
	  name          one ELF function has the name of the FUNC
	  section       it is not .init.text
	An error is left out of the list if
	  8 bytes       the constant is zero extended: 0xffffffea
	  meaning       -512 and below, -EAGAIN, -EMSGSIZE, -EINPROGRESS:
	                these tell the caller to retry, to go on, to wait
	  -1 alone      it is -1 and the only error. -1 is also "less" or
	                "not found": the machine code cannot tell

The tool does not look for an ftrace call site. The attach to a function
that is not traceable fails, as for fentry.

CONFIG_BPF_FMODRET_SCAN turns it on, for x86-64 and arm64. The default is
off. At this patch an x86-64 build with GCC prints

  FMODRET 12633 of 78350 functions are tagged,
          0 of the 35502 which were scanned cannot be decoded

A function that cannot be decoded gets no tag. The link fails if that is
more than 1 % of the scanned functions, or if vmlinux gets no tag. BTF
grows by 3 %, and resolve_btfids takes 0.4 s more for vmlinux.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/Kconfig                      |  19 +++
 scripts/Makefile.btf                    |   1 +
 tools/bpf/resolve_btfids/Build          |   3 +
 tools/bpf/resolve_btfids/fmodret.c      | 150 ++++++++++++++++++
 tools/bpf/resolve_btfids/fmodret.h      |  12 ++
 tools/bpf/resolve_btfids/fmodret_scan.c | 194 ++++++++++++++++++++++++
 tools/bpf/resolve_btfids/fmodret_scan.h |  21 +++
 tools/bpf/resolve_btfids/main.c         |  11 ++
 8 files changed, 411 insertions(+)
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
index 000000000000..89254538ec09
--- /dev/null
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Tag the functions which fmod_ret programs can attach to, because they return
+ * errors: "bpf_fmodret_retval:-22,-12". fmodret_scan.c finds the errors in the
+ * machine code. This file decides which functions it looks at, and which of the
+ * errors count.
+ *
+ * Whether ftrace can attach a program to the function is not looked at: as for
+ * fentry, that is found out when it is tried.
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
+/*
+ * The codes of include/linux/errno.h, 512 and up, never reach user space. They,
+ * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go on or to
+ * wait, not that the function failed.
+ */
+static bool means_failure(int error)
+{
+	return error > -512 && error != -EAGAIN && error != -EMSGSIZE && error != -EINPROGRESS;
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
+		if (size != 4 && size != 8)
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
index 000000000000..9cf8883322cf
--- /dev/null
+++ b/tools/bpf/resolve_btfids/fmodret_scan.c
@@ -0,0 +1,194 @@
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
index 000000000000..a8906fe0f694
--- /dev/null
+++ b/tools/bpf/resolve_btfids/fmodret_scan.h
@@ -0,0 +1,21 @@
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
 
-- 
2.55.0

