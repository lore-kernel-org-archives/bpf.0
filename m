Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641439;
	b=J8izJG66s4g/0xAua4UrXCwRvGrc3P6LCJ3l/Lc1rV4nzi2L0k1dp9mdIuYn7EFnCYp7
	 vISMKtdm5IZbfy5VVwmnifWIeXJ/h1qaUkE7sfXlu2rvgtLa76Zi15pSa+WLfNof2HymI
	 vd8szmZ5PqN3fLjCZvndOIXul6IU+/4DIbLLrpOYAxu3xW7IdB/1o0su3Q75fPPtSuq5t
	 UYmv1laZOYS91CuBl3ijv2vnTn20vqTMezpYgsOfaCwa1VD0YlaaflN6aPjSGIcpnyTkk
	 /s9o+Va4dHQFccGWwWbL022PA5KBlPjDN8X/CVzbKrKxHEV8kSO3tWc5iciPq9BhQ0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+EJNolFkcyMayTjVz0D0mCGnaGEcUcJjZMC3XRXziEI=;
	b=QUhweHwL84KiTM2kWAqSNXEtyIcXBwtvF38rik8XBW86+ZgeBR5T6N4XQqrTqpAYriwJ
	 65bnUHlo/ENnjm3hMzMyVFjQbzTvU/oofmEuWQhvtqm2FTpRYX3k/U5VPTXeUpQf2jI6n
	 Opu/t2IrFZu71xU4ujSgOS4GV3eO3OsuVWzFLwbMcwfyOgoEzq1NBxTLV0hN5TWb3S3kc
	 UznpdEy1JoB/fbD4G6VMy0OIE+4qJ0pX6c8B4Nt1lWURS08NplLw5fxLLGLbArGCKUjAd
	 f//AKAXnPcXdYNk+b/YjozBMl96f+GBXrBMdZAKaY3rfZ0h8Oj7XemXMg9dGneKP0Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VTPOtcbf;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844C606A33A
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1844C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VTPOtcbf
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso62780245e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641437; x=1796246237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+EJNolFkcyMayTjVz0D0mCGnaGEcUcJjZMC3XRXziEI=;
        b=VTPOtcbfQYoj1pSpmrc0yBzRiFbJNnh1cLXoMUE41yFNXIoxd5+fiJMsLSR9BemO8P
         nOKAZE2S8kyRm9lO18oTprb7nLoGnBQEjcPDL17aBLmHu0/yZVEgNL9xTms+ENPg/kqx
         18hAjSrIxHGOT3VEAoAI47sLaGFxwcIsIAEld4oXpqaLAZSpc99fvEzbnTG6Cxfuf04J
         Yrdq+oGSgQc/wqTwYxX8XSooLeCM2OwMMHniVZDWZjmG98ysfxE82CVcC7GhWgYYbKEZ
         GxbaTY33YpNMEjIK0Jj0gr4zLauG/Q2rbbZ35Klm0TNX4c3eEXiYu3b4Hzh5vTWi5BbB
         sq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641437; x=1796246237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+EJNolFkcyMayTjVz0D0mCGnaGEcUcJjZMC3XRXziEI=;
        b=tV6dXcowf6R0dPWWUSUBoZdOsDoQMMJhU1CWY0NglsUGOrwCCUfyCS5lnjUK6ms6oH
         5cNGAjP1ENtvGT/fh9r5jRByy2Rv/5l8iJbzEzbVnW3CFeH8RnIYrifSd/7Ut5pjpyth
         L9XDWCuo112TI8xwPD0rxIdNLV5qhRxSBwCD4FyKFYzr4Hs5uyjYwHh4ruj39Yf0ixnb
         jRtj801j/tBltH+CW1WA0b/3l5VRFD2crOZMCMLP+v9bSMpSoOMIXiKFn6paBBjfR8Jw
         G8Yy0oYT27RyFq+Z1iFnZ4p4h333vChfgjFJTUIrsM9bnXQB3bWHhtEXhgrubweMwNPg
         y5tw==
X-Forwarded-Encrypted: i=1; AL+hErEzg8EiN4wvFxq08rBcKmsLPXW9reHLHGwazcb8PNxnVZNPJHSxPoIFsetcm1LE4fbiiNk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fRFDesWYF4AI1XeGE+05Lh9zHhnolnQPg1n9Edp6Li6v1AtbT
	fUd3kjKPHXAPxmSpjj6fmNPgyDBfRS5Uq/Yhb8Xvax8iW/Rf8CmdgRM2
X-Gm-Gg: AZFdTZd1qOQwkRmr5KdqYqctd1VvuxfyEeGlOSbRM4Y0ubFkuRpVAZ0zIE/aHdlc4V4
	BIkhgt/+hfFN+TMQamUzKTG97+1A4GbJU6QlEmCFyzuN/I+i7oST+nIBm8QkRL3+qS3y/IEr5BT
	OJ5avwUOW0jxq9LOT+xQ/nSGR6n6ilXi/NFRV6sFP9KX193fhTBYSXmS/NEYkwHMDWdnuDXEx2E
	OgunwGSTvI1zZAtXF9ozz/iTIfiBxIglApheF8IhquU0mNXjLEhDYXkHucUQldt+Thp/9iqNGnb
	+7t+lLJiowaX+QL6glxPfpvLarxugEMF0o+3Ix/meDoIVnjLJOHcFRDNKTkHzTnIQT1YZqEQrj5
	fTN/fpgRH4iU5E3dMiwnZWVyR8Xn61lrDTQKUolWU7xzEGQ1jHjq0ZrNEA0eAqandfjEAgbCRMx
	SNZ1HSRqlLjJWB/uFezL5yOrLb5/dGDDGut69hLuuXG5KYZx1CiPXUFdeYFo3cmoDBjiCtrN8B/
	GgXx076o7XXzR0QiYV19IzCTAYbpMY1oxvqW8mhAPOo2qNi1b+IGrcdRhZDpyu33hs6aC01O0rA
	NY1lvv69Zny4YRRPcEwblN59Mga8hAsa7vnqfDcCqqtgGTUz
X-Received: by 2002:a05:600c:483:b0:4bb:a9f7:681 with SMTP id 5b1f17b1804b1-4bba9f70685mr18237615e9.3.1795641437409;
        Wed, 25 Nov 2026 13:17:17 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm41840507f8f.24.2026.11.25.13.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:17:17 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 4/5] resolve_btfids: Exclude the code of kernel/bpf and of the JIT
Date: Wed, 25 Nov 2026 21:28:37 +0000
Message-ID: <20261125212849.868523-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125212849.868523-1-a.s.protopopov@gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com>
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

Not every function of kernel/bpf and of the JIT has a BPF type in its
prototype, e.g. check_attach_modify_return() of the verifier,
bpf_tramp_ftrace_ops_func() and bpf_arch_text_invalidate(). Read the
symbols of kernel/bpf/built-in.a and arch/<arch>/net/built-in.a with
the llvm-nm of llvm-config, which reads ELF objects and LTO bitcode,
and do not tag these functions.

Weak symbols count too, for the bpf_lsm_* stubs. Only one tagged
function outside BPF has a weak copy in kernel/bpf, skb_copy_bits(),
and it loses its tag. BPF helpers call it, so this is acceptable.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/Makefile   |  1 +
 tools/bpf/resolve_btfids/fmodret.c  | 80 ++++++++++++++++++++++++++++-
 tools/bpf/resolve_btfids/llvm-mc.sh |  8 ++-
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 38b7caa98776..6d2a2b3582cb 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -93,6 +93,7 @@ LLVM_MC_HELP := CONFIG_BPF_FMODRET_SCAN=y needs a C++17 compiler (HOSTCXX=$(HOST
 		llvm-dev, llvm-devel). See above what is wrong, or switch the option off
 or_llvm_mc_help := || { echo '$(LLVM_MC_HELP)' >&2; false; }
 HOSTCFLAGS_resolve_btfids += -DHAVE_LLVM_MC
+HOSTCFLAGS_resolve_btfids += -DLLVM_NM='"$(shell $(LLVM_MC_SH) nm)"'
 CXX := $(HOSTCXX)
 CXXFLAGS := $(filter-out -Werror,$(HOSTCFLAGS_resolve_btfids)) -O2 \
 	    $(or $(shell $(LLVM_MC_SH) cxxflags),$(error $(LLVM_MC_HELP)))
diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index 5a392452471e..384efb5307ab 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 
 #include <bpf/btf.h>
 
@@ -103,6 +104,71 @@ static bool excluded_by_name(const char *name)
 	return false;
 }
 
+#ifndef LLVM_NM
+#define LLVM_NM "llvm-nm"
+#endif
+
+/* The code of BPF itself, in the build directory of vmlinux */
+static const char * const bpf_archives[] = {
+	"kernel/bpf/built-in.a",
+	"arch/x86/net/built-in.a",
+	"arch/arm64/net/built-in.a",
+};
+
+static int cmp_name(const void *a, const void *b)
+{
+	return strcmp(*(char * const *)a, *(char * const *)b);
+}
+
+/* Read the symbols of bpf_archives[] into NAMES, sorted */
+static int read_bpf_code(char ***names, size_t *nr)
+{
+	char cmd[sizeof(LLVM_NM) + 256] = LLVM_NM " --defined-only -j", *line = NULL;
+	size_t i, size = 0;
+	int err = 0;
+	FILE *f;
+
+	if (access(bpf_archives[0], F_OK)) {
+		fprintf(stderr, "FAILED: --fmodret_scan: no %s\n", bpf_archives[0]);
+		return -ENOENT;
+	}
+	for (i = 0; i < sizeof(bpf_archives) / sizeof(bpf_archives[0]); i++)
+		if (!access(bpf_archives[i], F_OK))
+			strcat(strcat(cmd, " "), bpf_archives[i]);
+	f = popen(cmd, "r");
+	if (!f)
+		return -errno;
+	while (getline(&line, &size, f) > 0) {
+		char **p = *nr % 4096 ? *names : realloc(*names, (*nr + 4096) * sizeof(*p));
+
+		if (!p) {
+			err = -ENOMEM;
+			break;
+		}
+		*names = p;
+		line[strcspn(line, "\n")] = 0;
+		p[(*nr)++] = line;
+		line = NULL;
+		size = 0;
+	}
+	free(line);
+	if (!feof(f) && !err)
+		err = -EIO;
+	if (pclose(f) && !err)
+		err = -EINVAL;
+	if (err) {
+		fprintf(stderr, "FAILED: --fmodret_scan: %s\n", cmd);
+		return err;
+	}
+	qsort(*names, *nr, sizeof(**names), cmp_name);
+	return 0;
+}
+
+static bool is_bpf_code(char **names, size_t nr, const char *name)
+{
+	return bsearch(&name, names, nr, sizeof(*names), cmp_name);
+}
+
 /* Find kfuncs and helpers */
 static bool *find_bpf_funcs(const struct btf *btf)
 {
@@ -260,11 +326,12 @@ static void set_protos(struct scan *scan, const struct image *img, const struct
 
 int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 {
-	size_t nr_funcs = 0, nr_scanned = 0, nr_undecodable = 0, nr_tags = 0;
+	size_t nr_funcs = 0, nr_scanned = 0, nr_undecodable = 0, nr_tags = 0, nr_bpf_code = 0, i;
 	const struct btf *base = btf__base_btf(btf);
 	__u32 id, nr_types = btf__type_cnt(btf);
 	struct scan *scan = NULL;
 	bool *bpf_funcs = NULL;
+	char **bpf_code = NULL;
 	struct image img;
 	char counts[200];
 	int err;
@@ -281,6 +348,11 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 	bpf_funcs = find_bpf_funcs(btf);
 	if (!bpf_funcs)
 		goto out;
+	if (!base) {
+		err = read_bpf_code(&bpf_code, &nr_bpf_code);
+		if (err)
+			goto out;
+	}
 
 	for (id = base ? btf__type_cnt(base) : 1, err = 0; id < nr_types && err >= 0; id++) {
 		const struct btf_type *t = btf__type_by_id(btf, id);
@@ -308,6 +380,9 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 			continue;
 		if (excluded_by_name(name))
 			continue;
+		/* Skip the code of kernel/bpf and of the JIT */
+		if (is_bpf_code(bpf_code, nr_bpf_code, name))
+			continue;
 		nr_scanned++;
 		err = scan_func(scan, func, &values);
 		if (err == -EINVAL) {
@@ -340,6 +415,9 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		printf("  FMODRET %s\n", counts);
 	}
 out:
+	for (i = 0; i < nr_bpf_code; i++)
+		free(bpf_code[i]);
+	free(bpf_code);
 	free(bpf_funcs);
 	scan_close(scan);
 	image_close(&img);
diff --git a/tools/bpf/resolve_btfids/llvm-mc.sh b/tools/bpf/resolve_btfids/llvm-mc.sh
index bc62c4e43406..919cf9480250 100755
--- a/tools/bpf/resolve_btfids/llvm-mc.sh
+++ b/tools/bpf/resolve_btfids/llvm-mc.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# usage: llvm-mc.sh SRCARCH [cxxflags | libs]
+# usage: llvm-mc.sh SRCARCH [cxxflags | libs | nm]
 #
 # text_mc.cpp reads the machine code of the kernel arch SRCARCH with LLVM's MC
 # layer. Fail, and say why, if this host lacks what it takes to build it.
@@ -9,7 +9,8 @@
 # one run of llvm-config. Whether text_mc.cpp works with this LLVM shows when the
 # tool is built, and in text_arch_init() when it starts.
 #
-# For the Makefile print the flags to compile text_mc.cpp, or the libraries.
+# For the Makefile print the flags to compile text_mc.cpp, the libraries, or
+# llvm-nm, which reads kbuild's objects for fmodret.c.
 #
 # The host's LLVM need not be the one which compiles the kernel, if any does.
 
@@ -56,4 +57,7 @@ libs)
 	libs=$($LLVM_CONFIG --link-shared "$@") || die "no libraries of LLVM"
 	echo $libs -lstdc++ -lm
 	;;
+nm)
+	echo "$($LLVM_CONFIG --bindir)/llvm-nm"
+	;;
 esac
-- 
2.43.0

