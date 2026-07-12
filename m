Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C6370D63
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829341; cv=none; b=F6evlJjleR1jHRNEhmBsnx06nLMxVAcsfQNTx3L2At7uxRwHEuCjZdgqaUHB7QMhly8uaZZFc0S95im039R7FUTpte7B5MJip0Jg3ZU9vDxDh2hMk3LEjn86TTdNLHCUvhQWus7p0epasHZwDIH89/+VQD/cUb8wYI5Ov1EOMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829341; c=relaxed/simple;
	bh=UwONQdSIR58AzteSQrmv9kMXhoLqyKx9woojMAMVUUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFTCFsAJNz6fi3unXOc4TPQ+nV/jxkXieMqDQroT+xRBWaGAK2967L15QT73p70+iW7ReGRmgs3D7YWpFgxIDs9C3OfGACHH0GiG1WCBgOuwgC7Xnh9JtB1xCZsG80oOG9xWmgboNOfyTlTCuAsGhY5qK1/E+UtutJNBNp6W/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USdSJQm+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USdSJQm+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dcbade417so555595a91.1
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783829338; x=1784434138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNMnN6PRNArZolS5V8JiE9hnU6pWFtcLrBR1+3UF0vs=;
        b=USdSJQm+ZaSXWnLEkdgAN3JwEpOQLBgXgvOrpyo9cVscUsdSTzureuKDaIUbc/KQWM
         dVMCvNBxtADz/+wsWceW2uXWtyYnU4RHPa4fkJgIPB7WKcK3MPbVy8AmUqwViYklovXS
         X1GH8ZV+7ijOH53cl1dXCB+36oSL/KfLXOqgplrqPKd3Yu+u9BnCHSU8MCTg9vVDhL3Q
         vaPNqClixUdWO64mjfQ8aso64bRSjclvhwPvoP8zBbLyrfc11sqXcX64cck0of7hry0o
         JZuvRIHZ07ba7peHwu3FLSQwzxWhOLZmDuH6v+wav0E9jYdBvZ5t8UaQs8QrP1Vtn3cj
         arjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783829338; x=1784434138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SNMnN6PRNArZolS5V8JiE9hnU6pWFtcLrBR1+3UF0vs=;
        b=VhUUoEXDY1a/XgRyKqnZ8wnFMCjw92k4iz1f/37aUNd42r6tdBkv6oConlii23H8jQ
         t3wjB+kzb8i1X12FbzgZH3l8AJmjJK1+676zJ4v2XeQzJmstmqhl9CG9rF+T1YZdsHdL
         x8jGtQ2ecYNaWBigE39D8lHD7H2EMBspCJ1HshdDGEcUlVzkhzi3m3CdGsweWUHVMsoJ
         6F4DLRjCuVj/I1ob2O2U6iQvve5x4FUNatgY0EVqa1156VyU4wj6jCFuSPHW6BbfzvNa
         RubBzvbU0a746yjgXRjOEQSh9IRrrcVeqxnaxtaHkZIrqxuOzezSH1tKoinPn+cH10WH
         89VA==
X-Forwarded-Encrypted: i=1; AHgh+RrJBhFmgS190bKBID29opTvWlcbg9ekewWkUwUbp9omkHjUYhz47jDF/ulM4q8SVuvCcIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhlUgsnsQSlvsYODwurUdPCvrstxJFIHvwgvnBu2eIa41ZaJM
	8w2qWVAms/G0He/p02pLsbd0jWUOI3Rkm5kCxbWk8Uq6g8B+PFWjyyKU
X-Gm-Gg: AfdE7ckb7Ohnac6Y3X54CPk9Kpi1vIq7XkPCxw4A8hpUD6rQYi2CezqWs19I0kLL/Jd
	xnzdZNZaBblTp4kLnBvOQZkddIQKQaFxLdNKPXJEum8wCLzOYD/ro+wVpOrnGriQ4iCiAXWAM1s
	8ly4jdf6mXluf2i4OgG/u8av5AFdbkVWf8ob9gT2/+6rMjj9aLx4GQEzTjwwUbVRjjWcALhTFZq
	EWgOG8Ud/+lHnppHe/hLPP2oCjz/RKOe8ip9g3udRrrVQCBnhVf98RmdeyYAUl93DIvBF7JMYTN
	MdensX6CGZZrtNVC2eE3xfZW7bQaJphWVKnNtGFJHqxmvzuGxIw2T30RioFOpGOOR6gQPshZdCn
	QoOfBJxs5R2GHRk6908SwjHKhCfRwPJ9+uD1R0P4ZEC9bLTPf3saVJxX0soBeHBlHhpqkqUAfKH
	6bCuZQ9UoW+kXeskjV
X-Received: by 2002:a17:90a:e70f:b0:387:e0cb:7ee with SMTP id 98e67ed59e1d1-38dc781ce28mr3727842a91.34.1783829337465;
        Sat, 11 Jul 2026 21:08:57 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm56808928eec.10.2026.07.11.21.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:08:56 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Sat, 11 Jul 2026 21:08:18 -0700
Subject: [PATCH v2 5/5] selftests/exec: add binfmt_misc bpf-backed handler
 test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-binfmt-misc-bpf-v2-v2-5-d6591ceaf207@gmail.com>
References: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
In-Reply-To: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
To: Christian Brauner <brauner@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Jann Horn <jannh@google.com>, 
 John Ericson <mail@johnericson.me>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.14.3

Exercise the bpf-backed ('B') binfmt_misc handlers end to end. A handler
is a struct binfmt_misc_ops struct_ops map; the test loads and attaches
it (which publishes it by name), activates it with a 'B' entry, and
checks that a matched binary is routed to the interpreter the program
selected via bpf_binprm_set_interp().

Two self-contained cases are covered:

  - bpf_interp: match a synthetic aarch64 ELF header from bprm->buf and
    route it to a fixed interpreter chosen by the program.
  - nix_origin: resolve a "$ORIGIN/..."-relative PT_INTERP to an
    interpreter co-located with the binary -- the relocatable-loader
    case the kernel ELF loader cannot express. The relocatable binary is
    linked with PT_INTERP set to the literal "$ORIGIN/binfmt_bpf_interp"
    (-Wl,--dynamic-linker), which the kernel cannot resolve on its own.

Both route to a small test interpreter that prints a marker, proving the
program-selected interpreter actually ran.

The bpf objects are compiled against the running kernel's BTF: the
Makefile generates vmlinux.h with bpftool and the harness links libbpf.
Override CLANG/BPFTOOL/VMLINUX_BTF/LIBBPF_CFLAGS/LIBBPF_LDLIBS as needed.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
Assisted-by: Claude:Opus-4.8
---
 tools/testing/selftests/exec/Makefile            |  37 ++++
 tools/testing/selftests/exec/binfmt_bpf_app.c    |  12 ++
 tools/testing/selftests/exec/binfmt_bpf_interp.c |  15 ++
 tools/testing/selftests/exec/binfmt_misc_bpf.c   | 260 +++++++++++++++++++++++
 tools/testing/selftests/exec/bpf_interp.bpf.c    |  52 +++++
 tools/testing/selftests/exec/nix_origin.bpf.c    | 179 ++++++++++++++++
 6 files changed, 555 insertions(+)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 45a3cfc43..5423e3f7f 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -21,6 +21,12 @@ TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
 
+# binfmt_misc bpf-backed ('B') handler test: a libbpf harness plus its
+# struct_ops objects and the test interpreter/app it routes between.
+TEST_GEN_PROGS += binfmt_misc_bpf
+TEST_GEN_FILES += bpf_interp.bpf.o nix_origin.bpf.o
+TEST_GEN_FILES += binfmt_bpf_interp binfmt_bpf_app
+
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
 
@@ -55,3 +61,34 @@ $(OUTPUT)/script-exec.inc: $(CHECK_EXEC_SAMPLES)/script-exec.inc
 	cp $< $@
 $(OUTPUT)/script-noexec.inc: $(CHECK_EXEC_SAMPLES)/script-noexec.inc
 	cp $< $@
+
+# --- binfmt_misc bpf ('B') handler test ---------------------------------
+# The struct_ops bpf objects are compiled against the running kernel's BTF.
+# Override CLANG/BPFTOOL/VMLINUX_BTF if they aren't on PATH or the vmlinux
+# BTF lives elsewhere, and LIBBPF_CFLAGS/LDLIBS to point at a libbpf install.
+CLANG ?= clang
+BPFTOOL ?= bpftool
+VMLINUX_BTF ?= /sys/kernel/btf/vmlinux
+BPF_CFLAGS ?= -I$(OUTPUT)
+LIBBPF_CFLAGS ?=
+LIBBPF_LDLIBS ?= -lbpf -lelf -lz
+
+$(OUTPUT)/vmlinux.h:
+	$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+	sed -i '/__ksym;$$/d' $@
+
+$(OUTPUT)/%.bpf.o: %.bpf.c $(OUTPUT)/vmlinux.h
+	$(CLANG) -g -O2 -target bpf -mcpu=v3 $(BPF_CFLAGS) -c $< -o $@
+
+$(OUTPUT)/binfmt_misc_bpf: binfmt_misc_bpf.c
+	$(CC) $(CFLAGS) $(LIBBPF_CFLAGS) $(LDFLAGS) $< $(LIBBPF_LDLIBS) -o $@
+
+$(OUTPUT)/binfmt_bpf_interp: binfmt_bpf_interp.c
+	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+# PT_INTERP is set to the literal "$ORIGIN/binfmt_bpf_interp"; the nix_origin
+# handler resolves it relative to the binary at run time.
+$(OUTPUT)/binfmt_bpf_app: binfmt_bpf_app.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,--dynamic-linker,'$$ORIGIN/binfmt_bpf_interp' $< -o $@
+
+EXTRA_CLEAN += $(OUTPUT)/vmlinux.h $(OUTPUT)/bpf_interp.bpf.o $(OUTPUT)/nix_origin.bpf.o
diff --git a/tools/testing/selftests/exec/binfmt_bpf_app.c b/tools/testing/selftests/exec/binfmt_bpf_app.c
new file mode 100644
index 000000000..472270f14
--- /dev/null
+++ b/tools/testing/selftests/exec/binfmt_bpf_app.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A relocatable binary for the binfmt_misc_bpf $ORIGIN case. The Makefile
+ * links it with PT_INTERP set to the literal "$ORIGIN/binfmt_bpf_interp"
+ * (-Wl,--dynamic-linker), which the kernel ELF loader cannot resolve. The
+ * nix_origin bpf handler resolves it relative to this binary's directory and
+ * routes execution to the co-located interpreter.
+ */
+int main(void)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/exec/binfmt_bpf_interp.c b/tools/testing/selftests/exec/binfmt_bpf_interp.c
new file mode 100644
index 000000000..2db205f09
--- /dev/null
+++ b/tools/testing/selftests/exec/binfmt_bpf_interp.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test interpreter for the binfmt_misc_bpf selftest. A bpf-backed 'B' handler
+ * routes a matched binary here; printing this marker proves the program's
+ * chosen interpreter actually ran.
+ */
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	(void)argc;
+	(void)argv;
+	write(1, "BPF_INTERP_RAN\n", 15);
+	return 0;
+}
diff --git a/tools/testing/selftests/exec/binfmt_misc_bpf.c b/tools/testing/selftests/exec/binfmt_misc_bpf.c
new file mode 100644
index 000000000..b3e017ade
--- /dev/null
+++ b/tools/testing/selftests/exec/binfmt_misc_bpf.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Selftest for binfmt_misc bpf-backed ('B') handlers.
+ *
+ * A handler is a struct binfmt_misc_ops struct_ops map. Attaching it publishes
+ * it by name in the caller's user namespace; a 'B' entry activates it:
+ *
+ *     echo ':name:B:<handler>::::' > /proc/sys/fs/binfmt_misc/register
+ *
+ * Two self-contained cases are exercised:
+ *
+ *   1. bpf_interp: the handler matches a synthetic aarch64 ELF header and
+ *      routes it to a fixed interpreter chosen by the program.
+ *   2. nix_origin: the handler resolves a "$ORIGIN/..."-relative PT_INTERP to
+ *      an interpreter co-located with the binary (the relocatable-loader case
+ *      the kernel ELF loader cannot express).
+ *
+ * Both route to a test interpreter that prints BPF_INTERP_RAN, proving the
+ * program's chosen interpreter actually ran.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+
+#include <bpf/libbpf.h>
+
+#define INTERP_PATH	"/tmp/binfmt_bpf_interp"
+#define AARCH64_PATH	"/tmp/binfmt_bpf_aarch64"
+#define RELOC_DIR	"/tmp/binfmt_reloc"
+#define BINFMT_REG	"/proc/sys/fs/binfmt_misc/register"
+#define EXPECT		"BPF_INTERP_RAN"
+
+static char testdir[512]; /* directory holding this test's built artifacts */
+
+static int copy_file(const char *src, const char *dst)
+{
+	char buf[4096];
+	int in, out;
+	ssize_t n;
+
+	in = open(src, O_RDONLY);
+	if (in < 0)
+		return -1;
+	out = open(dst, O_WRONLY | O_CREAT | O_TRUNC, 0755);
+	if (out < 0) {
+		close(in);
+		return -1;
+	}
+	while ((n = read(in, buf, sizeof(buf))) > 0) {
+		if (write(out, buf, n) != n) {
+			close(in);
+			close(out);
+			return -1;
+		}
+	}
+	close(in);
+	close(out);
+	return n < 0 ? -1 : 0;
+}
+
+/* A minimal 64-bit little-endian aarch64 ELF header, padded to the read size. */
+static int create_fake_aarch64(const char *path)
+{
+	unsigned char hdr[256] = {0};
+	int fd;
+
+	hdr[0] = 0x7f; hdr[1] = 'E'; hdr[2] = 'L'; hdr[3] = 'F';
+	hdr[4] = 2;			/* ELFCLASS64 */
+	hdr[5] = 1;			/* ELFDATA2LSB */
+	hdr[6] = 1;			/* EV_CURRENT */
+	hdr[16] = 2;			/* e_type = ET_EXEC */
+	hdr[18] = 183 & 0xff;		/* e_machine = EM_AARCH64 */
+	hdr[19] = (183 >> 8) & 0xff;
+	hdr[20] = 1;			/* e_version */
+
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0755);
+	if (fd < 0)
+		return -1;
+	if (write(fd, hdr, sizeof(hdr)) != (ssize_t)sizeof(hdr)) {
+		close(fd);
+		return -1;
+	}
+	close(fd);
+	return 0;
+}
+
+static int register_entry(const char *name, const char *handler)
+{
+	char rule[128];
+	int fd;
+	ssize_t n;
+
+	snprintf(rule, sizeof(rule), ":%s:B:%s::::", name, handler);
+	fd = open(BINFMT_REG, O_WRONLY);
+	if (fd < 0)
+		return -1;
+	n = write(fd, rule, strlen(rule));
+	close(fd);
+	return n < 0 ? -1 : 0;
+}
+
+static void unregister_entry(const char *name)
+{
+	char path[128];
+	int fd;
+
+	snprintf(path, sizeof(path), "/proc/sys/fs/binfmt_misc/%s", name);
+	fd = open(path, O_WRONLY);
+	if (fd >= 0) {
+		if (write(fd, "-1", 2) < 0)
+			; /* best effort */
+		close(fd);
+	}
+}
+
+static int check_output(const char *cmd, const char *expected)
+{
+	char buf[128];
+	FILE *fp;
+
+	fp = popen(cmd, "r");
+	if (!fp)
+		return -1;
+	if (!fgets(buf, sizeof(buf), fp)) {
+		pclose(fp);
+		return -1;
+	}
+	pclose(fp);
+	return strncmp(buf, expected, strlen(expected)) ? -1 : 0;
+}
+
+/*
+ * Load @objfile, attach its struct_ops map @handler (which publishes the
+ * handler), activate a 'B' entry named @entry that references it, run @target
+ * and check it produced @expect.
+ */
+static int run_case(const char *objfile, const char *handler,
+		    const char *entry, const char *target, const char *expect)
+{
+	struct bpf_object *obj;
+	struct bpf_map *map;
+	struct bpf_link *link;
+	int ret = -1;
+
+	obj = bpf_object__open_file(objfile, NULL);
+	if (!obj || libbpf_get_error(obj)) {
+		fprintf(stderr, "open %s failed\n", objfile);
+		return -1;
+	}
+	if (bpf_object__load(obj)) {
+		fprintf(stderr, "load %s failed (check dmesg for the verifier log)\n",
+			objfile);
+		goto close;
+	}
+	map = bpf_object__find_map_by_name(obj, handler);
+	if (!map) {
+		fprintf(stderr, "no struct_ops map '%s' in %s\n", handler, objfile);
+		goto close;
+	}
+	link = bpf_map__attach_struct_ops(map);
+	if (!link || libbpf_get_error(link)) {
+		fprintf(stderr, "attach struct_ops '%s' failed\n", handler);
+		goto close;
+	}
+	if (register_entry(entry, handler)) {
+		fprintf(stderr, "register 'B' entry '%s' failed\n", entry);
+		goto detach;
+	}
+	ret = check_output(target, expect);
+	unregister_entry(entry);
+detach:
+	bpf_link__destroy(link);
+close:
+	bpf_object__close(obj);
+	return ret;
+}
+
+int main(void)
+{
+	char src[600], obj[600], appdst[600], interpdst[600];
+	char exe[512];
+	ssize_t n;
+	int fail = 0;
+	struct stat st;
+
+	if (getuid() != 0) {
+		fprintf(stderr, "Skipping: test must be run as root\n");
+		return 4; /* KSFT_SKIP */
+	}
+
+	n = readlink("/proc/self/exe", exe, sizeof(exe) - 1);
+	if (n < 0) {
+		perror("readlink");
+		return 1;
+	}
+	exe[n] = '\0';
+	snprintf(testdir, sizeof(testdir), "%s", dirname(exe));
+
+	if (stat("/sys/fs/bpf", &st) < 0)
+		mkdir("/sys/fs/bpf", 0755);
+	mount("bpf", "/sys/fs/bpf", "bpf", 0, NULL);
+	if (access(BINFMT_REG, F_OK) < 0)
+		mount("binfmt_misc", "/proc/sys/fs/binfmt_misc", "binfmt_misc", 0, NULL);
+
+	/* Shared test interpreter. */
+	snprintf(src, sizeof(src), "%s/binfmt_bpf_interp", testdir);
+	if (copy_file(src, INTERP_PATH)) {
+		fprintf(stderr, "cannot install %s\n", INTERP_PATH);
+		return 1;
+	}
+
+	/* Case 1: match a synthetic aarch64 header -> fixed interpreter. */
+	printf("[*] case 1: match aarch64 header -> program-chosen interpreter\n");
+	if (create_fake_aarch64(AARCH64_PATH)) {
+		fprintf(stderr, "cannot create %s\n", AARCH64_PATH);
+		return 1;
+	}
+	snprintf(obj, sizeof(obj), "%s/bpf_interp.bpf.o", testdir);
+	if (run_case(obj, "bpf_interp", "test_bpf_interp", AARCH64_PATH, EXPECT) == 0)
+		printf("[+] case 1 passed\n");
+	else {
+		printf("[-] case 1 FAILED\n");
+		fail = 1;
+	}
+	unlink(AARCH64_PATH);
+
+	/* Case 2: $ORIGIN-relative PT_INTERP -> co-located interpreter. */
+	printf("[*] case 2: $ORIGIN interpreter resolved relative to the binary\n");
+	mkdir(RELOC_DIR, 0755);
+	snprintf(appdst, sizeof(appdst), "%s/app", RELOC_DIR);
+	snprintf(interpdst, sizeof(interpdst), "%s/binfmt_bpf_interp", RELOC_DIR);
+	snprintf(src, sizeof(src), "%s/binfmt_bpf_app", testdir);
+	if (copy_file(src, appdst) ||
+	    copy_file(INTERP_PATH, interpdst)) {
+		fprintf(stderr, "cannot set up %s\n", RELOC_DIR);
+		fail = 1;
+	} else {
+		snprintf(obj, sizeof(obj), "%s/nix_origin.bpf.o", testdir);
+		if (run_case(obj, "nix_origin", "test_bpf_origin", appdst, EXPECT) == 0)
+			printf("[+] case 2 passed\n");
+		else {
+			printf("[-] case 2 FAILED\n");
+			fail = 1;
+		}
+	}
+	unlink(appdst);
+	unlink(interpdst);
+	rmdir(RELOC_DIR);
+	unlink(INTERP_PATH);
+
+	if (!fail)
+		printf("[*] all binfmt_misc bpf cases passed\n");
+	return fail;
+}
diff --git a/tools/testing/selftests/exec/bpf_interp.bpf.c b/tools/testing/selftests/exec/bpf_interp.bpf.c
new file mode 100644
index 000000000..ca98c3716
--- /dev/null
+++ b/tools/testing/selftests/exec/bpf_interp.bpf.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * binfmt_misc_ops handler for the selftest's fixed-interpreter case: match a
+ * 64-bit aarch64 ELF header from the prefetched buffer and route it to a fixed
+ * interpreter chosen by the program. This is the portable, self-contained
+ * equivalent of routing a foreign binary to an emulator: it matches
+ * programmatically and computes the interpreter, but points at a test binary
+ * the harness installs rather than a system emulator.
+ */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define EI_CLASS	4
+#define ELFCLASS64	2
+#define EM_AARCH64	183
+
+extern int bpf_binprm_set_interp(struct linux_binprm *bprm, const char *path,
+				 size_t path__sz) __ksym;
+
+SEC("struct_ops.s/load")
+int BPF_PROG(bpf_interp_load, struct linux_binprm *bprm)
+{
+	/*
+	 * Keep the path on the (writable) stack: bpf_binprm_set_interp() takes
+	 * a sized memory arg and the verifier rejects a read-only .rodata
+	 * buffer for it. The harness installs the interpreter at this path.
+	 */
+	char interp[] = "/tmp/binfmt_bpf_interp";
+	__u16 machine;
+
+	if (bprm->buf[0] != 0x7f || bprm->buf[1] != 'E' ||
+	    bprm->buf[2] != 'L' || bprm->buf[3] != 'F' ||
+	    bprm->buf[EI_CLASS] != ELFCLASS64)
+		return 0;
+
+	/* e_machine is a 16-bit little-endian field at offset 18. */
+	machine = (__u8)bprm->buf[18] | ((__u16)(__u8)bprm->buf[19] << 8);
+	if (machine != EM_AARCH64)
+		return 0;
+
+	/* @path__sz includes the terminating NUL. */
+	return bpf_binprm_set_interp(bprm, interp, sizeof(interp)) ?: 1;
+}
+
+SEC(".struct_ops.link")
+struct binfmt_misc_ops bpf_interp = {
+	.load = (void *)bpf_interp_load,
+	.name = "bpf_interp",
+};
diff --git a/tools/testing/selftests/exec/nix_origin.bpf.c b/tools/testing/selftests/exec/nix_origin.bpf.c
new file mode 100644
index 000000000..a853d64f4
--- /dev/null
+++ b/tools/testing/selftests/exec/nix_origin.bpf.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * nix_origin.bpf.c - $ORIGIN-relative PT_INTERP resolution
+ *
+ * A binfmt_misc_ops handler that makes relocatable (Nix-style) ELF
+ * binaries work: if PT_INTERP starts with "$ORIGIN/", the loader is
+ * resolved relative to the directory of the binary being executed and
+ * selected via bpf_binprm_set_interp(). Anything else is declined so
+ * regular binaries pass through untouched.
+ *
+ * Activate with:
+ *   bpftool struct_ops register nix_origin.bpf.o /sys/fs/bpf
+ *   echo ':nix-origin:B:nix_origin::::' > /proc/sys/fs/binfmt_misc/register
+ */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define PATH_MAX	4096
+#define EI_CLASS	4
+#define ELFCLASSXX	2	/* ELFCLASS64; flip to 1 for 32-bit */
+#define PT_INTERP	3
+#define MAX_PHDRS	64
+
+#define ORIGIN		"$ORIGIN"
+#define ORIGIN_LEN	(sizeof(ORIGIN) - 1)
+
+#define ENOENT		2
+#define ENAMETOOLONG	36
+
+extern int bpf_dynptr_from_file(struct file *file, __u32 flags,
+				struct bpf_dynptr *ptr__uninit) __ksym;
+extern int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr) __ksym;
+extern int bpf_path_d_path(const struct path *path, char *buf,
+			   size_t buf__sz) __ksym;
+extern int bpf_binprm_set_interp(struct linux_binprm *bprm, const char *path,
+				 size_t path__sz) __ksym;
+
+struct scratch {
+	char interp[PATH_MAX];	/* PT_INTERP as embedded in the binary */
+	char path[PATH_MAX];	/* d_path of the binary, becomes the result */
+};
+
+/* Keyed by pid: execs run concurrently and the program can sleep. */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 512);
+	__type(key, __u64);
+	__type(value, struct scratch);
+} scratch_map SEC(".maps");
+
+static const struct scratch zero_scratch;
+
+SEC("struct_ops.s/load")
+int BPF_PROG(nix_origin_load, struct linux_binprm *bprm)
+{
+	__u32 isz, sfx, rsz, slash;
+	struct elf64_phdr phdr;
+	struct elf64_hdr ehdr;
+	struct bpf_dynptr dp;
+	struct scratch *sc;
+	bool found = false;
+	__u64 id;
+	int ret = 0, len, i;
+
+	/* Cheap reject from the prefetched header. */
+	if (bprm->buf[0] != 0x7f || bprm->buf[1] != 'E' ||
+	    bprm->buf[2] != 'L' || bprm->buf[3] != 'F' ||
+	    bprm->buf[EI_CLASS] != ELFCLASSXX)
+		return 0;
+
+	if (bpf_dynptr_from_file(bprm->file, 0, &dp))
+		goto out;
+
+	if (bpf_dynptr_read(&ehdr, sizeof(ehdr), &dp, 0, 0))
+		goto out;
+	if (ehdr.e_phentsize != sizeof(struct elf64_phdr))
+		goto out;
+
+	bpf_for(i, 0, ehdr.e_phnum) {
+		if (i >= MAX_PHDRS)
+			break;
+		if (bpf_dynptr_read(&phdr, sizeof(phdr), &dp,
+				    ehdr.e_phoff + i * sizeof(phdr), 0))
+			goto out;
+		if (phdr.p_type == PT_INTERP) {
+			found = true;
+			break;
+		}
+	}
+	if (!found)
+		goto out;
+
+	isz = phdr.p_filesz;
+	if (isz <= ORIGIN_LEN + 1 || isz >= sizeof(sc->interp))
+		goto out;
+	/*
+	 * The range check above compiles to a test on a zero-extended copy of
+	 * the u64 p_filesz, so the verifier does not carry the bound to the
+	 * dynptr_read() length below ("unbounded memory access"). Mask isz to
+	 * the buffer size (a power of two) and force the masked value to be
+	 * materialized with a barrier so the read uses the bounded register.
+	 */
+	isz &= sizeof(sc->interp) - 1;
+	barrier_var(isz);
+
+	id = bpf_get_current_pid_tgid();
+	if (bpf_map_update_elem(&scratch_map, &id, &zero_scratch, BPF_ANY))
+		goto out;
+	sc = bpf_map_lookup_elem(&scratch_map, &id);
+	if (!sc)
+		goto out_del;
+
+	if (bpf_dynptr_read(sc->interp, isz, &dp, phdr.p_offset, 0))
+		goto out_del;
+	if (sc->interp[isz - 1] != '\0')
+		goto out_del;
+
+	/* Not "$ORIGIN/..."? Decline, the elf loader owns it. */
+	if (sc->interp[0] != '$' || sc->interp[1] != 'O' ||
+	    sc->interp[2] != 'R' || sc->interp[3] != 'I' ||
+	    sc->interp[4] != 'G' || sc->interp[5] != 'I' ||
+	    sc->interp[6] != 'N' || sc->interp[7] != '/')
+		goto out_del;
+
+	/*
+	 * From here on the binary is ours: resolution failures fail the
+	 * exec instead of falling back to binfmt_elf, which would resolve
+	 * the literal "$ORIGIN/..." relative to the caller's cwd.
+	 */
+	ret = -ENOENT;
+	len = bpf_path_d_path(&bprm->file->f_path, sc->path, sizeof(sc->path));
+	if (len <= 0 || len > sizeof(sc->path))
+		goto out_del;
+	/* Unreachable or unlinked ("... (deleted)") binaries can't resolve. */
+	if (sc->path[0] != '/')
+		goto out_del;
+
+	/* $ORIGIN = dirname of the binary. */
+	slash = 0;
+	bpf_for(i, 1, len - 1) {
+		if (i >= sizeof(sc->path))
+			break;
+		if (sc->path[i] == '/')
+			slash = i;
+	}
+
+	/* Splice the suffix (leading '/' and NUL included) onto the dir. */
+	sfx = isz - ORIGIN_LEN;
+	rsz = slash + sfx;
+	if (rsz > sizeof(sc->path)) {
+		ret = -ENAMETOOLONG;
+		goto out_del;
+	}
+	bpf_for(i, 0, sfx) {
+		__u32 s = ORIGIN_LEN + i, d = slash + i;
+
+		if (s >= sizeof(sc->interp) || d >= sizeof(sc->path))
+			break;
+		sc->path[d] = sc->interp[s];
+	}
+
+	ret = bpf_binprm_set_interp(bprm, sc->path, rsz);
+	if (!ret)
+		ret = 1;
+out_del:
+	bpf_map_delete_elem(&scratch_map, &id);
+out:
+	bpf_dynptr_file_discard(&dp);
+	return ret;
+}
+
+SEC(".struct_ops.link")
+struct binfmt_misc_ops nix_origin = {
+	.load = (void *)nix_origin_load,
+	.name = "nix_origin",
+};

-- 
2.51.2

