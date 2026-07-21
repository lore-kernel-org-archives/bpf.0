Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A039281B;
	Tue, 21 Jul 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643291; cv=none; b=QwQpuBOboMpN5scmH2WBtWLNa8qf11jWDb0QNt00ExOAS1xTRjCgQMfjd/5MWxF4hk5pAhvJ5sxP7748vwxvM2O1EfxtSuRmcCPpr7hkE48o0GL/DJfIGcXc1iSXhe7x7allatgJ9jKMUxASuiU118pz51GhoL3xVaFBadly600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643291; c=relaxed/simple;
	bh=7o/5BMO6JYZ0oqkpFGxIC6d/xEAQ0CM3eQa812WTGD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqQR+l6qy35vUKImFLuGuQX1Kjdi2xhnT7FDRWIvX+kTDfJRSXAueLMlW75hMDOB9mxHdmyz80uFcoYdsi9x9Cs+jj9wVknsMdYPa/m0r7euAptdXWvt0DZQnF6IVD62L8AImOxw6YlgScKx/LFEalSn3MMbRoT+3epHROd9oQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k131fIvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k131fIvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0BE1F00A3A;
	Tue, 21 Jul 2026 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643289;
	bh=qM/oQXYnHm4e/LGvExJxLTkk1pN5nLwXCm6fuvDcb4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k131fIvXg5ObA2Z3TXFqd6vSraxXu6gkXk+0Z2UzTguTfpxZks1h/Pn4JcB9lfn17
	 ISmOCwH97EI5mzwZbe48MN1/yuOjD61tqI1tuWR22L0pjWJWA9kfynjadn9Ir2NpHK
	 To2MizsEE4xjTGPl0DJD+X9JFm+qt8a3nSYRzd5j4gjAxo/7x0CplZnmaQTwRpop30
	 q6ZdcxLQj/hI9qzgBNBhHW3l/nDaMAJMmzFAxsNRCsyeNqo/q3FoiL8hd8L9TN307Z
	 BXfI05u7czjDqolsQwUejAmK7JegW38AiMey0KKs+w/Vqx/loaPTvoZBhSeK/U7nwu
	 5pEtJfFE3j0Gg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:49 +0200
Subject: [PATCH v2 07/21] selftests/exec: convert the binfmt_misc bpf test
 to the kselftest harness
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-7-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=13248; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7o/5BMO6JYZ0oqkpFGxIC6d/xEAQ0CM3eQa812WTGD4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+2XKPZ17so4PblKfoKcJcf9woj0g+wrPj6ecsUlI
 6lWOd6lo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK7ExgZ/sy6bONgsM9gqrdf
 dX1p/pPbui9fL1nBMznbxlxYocK3nJHh+Tut+fpeikYlKx7HL3wspeqXYtEz7Xev1PpDpv5s/K4
 sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The test reports its own pass and fail lines, returns a bare 4 for
KSFT_SKIP and runs both cases in one process, so a failure in the first
takes the second with it. It also open-codes the register, unregister,
file-copy and mount helpers that the tests for the upcoming transparent
and loader dispatch modes need again.

Convert it to the kselftest harness: a fixture for the common setup and
teardown, one TEST_F per case so each is reported and isolated
separately, and SKIP() for the root, BTF and binfmt_misc preconditions.
Move the helpers to a shared header on the way, with the register
helper preserving the write's errno so a caller can tell a rejected
flag combination (EINVAL) from a kernel that does not know the flag at
all. The synthetic ELF header gains an e_machine argument and uses the
elf.h constants instead of open-coded numbers.

No change in what is tested.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/Makefile             |   6 +-
 tools/testing/selftests/exec/binfmt_misc_bpf.c    | 195 ++++++++--------------
 tools/testing/selftests/exec/binfmt_misc_common.h |  98 +++++++++++
 3 files changed, 168 insertions(+), 131 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index ec66c1fecfc0..fb5ca59af51d 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -44,6 +44,8 @@ endif
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
 
+LOCAL_HDRS += binfmt_misc_common.h
+
 include ../lib.mk
 
 CHECK_EXEC_SAMPLES := $(top_srcdir)/samples/check-exec
@@ -91,7 +93,7 @@ $(OUTPUT)/vmlinux.h:
 $(OUTPUT)/%.bpf.o: %.bpf.c $(OUTPUT)/vmlinux.h
 	$(CLANG) -g -O2 -target bpf -mcpu=v3 $(BPF_CFLAGS) $(LIBBPF_CFLAGS) -c $< -o $@
 
-$(OUTPUT)/binfmt_misc_bpf: binfmt_misc_bpf.c
+$(OUTPUT)/binfmt_misc_bpf: binfmt_misc_bpf.c binfmt_misc_common.h
 	$(CC) $(CFLAGS) $(LIBBPF_CFLAGS) $(LDFLAGS) $< $(LIBBPF_LDLIBS) -o $@
 
 $(OUTPUT)/binfmt_bpf_interp: binfmt_bpf_interp.c
@@ -102,4 +104,4 @@ $(OUTPUT)/binfmt_bpf_interp: binfmt_bpf_interp.c
 $(OUTPUT)/binfmt_bpf_app: binfmt_bpf_app.c
 	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,--dynamic-linker,'$$ORIGIN/binfmt_bpf_interp' $< -o $@
 
-EXTRA_CLEAN += $(OUTPUT)/vmlinux.h $(OUTPUT)/bpf_interp.bpf.o $(OUTPUT)/nix_origin.bpf.o
+EXTRA_CLEAN += $(OUTPUT)/vmlinux.h $(OUTPUT)/*.bpf.o
diff --git a/tools/testing/selftests/exec/binfmt_misc_bpf.c b/tools/testing/selftests/exec/binfmt_misc_bpf.c
index cb89d2766fe2..dd541c0a464d 100644
--- a/tools/testing/selftests/exec/binfmt_misc_bpf.c
+++ b/tools/testing/selftests/exec/binfmt_misc_bpf.c
@@ -23,66 +23,40 @@
  * program's chosen interpreter actually ran.
  */
 #define _GNU_SOURCE
+#include <elf.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <libgen.h>
-#include <sys/mount.h>
 #include <sys/stat.h>
 
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 
+#include "binfmt_misc_common.h"
+#include "kselftest_harness.h"
+
 #define INTERP_PATH	"/tmp/binfmt_bpf_interp"
 #define AARCH64_PATH	"/tmp/binfmt_bpf_aarch64"
 #define RELOC_DIR	"/tmp/binfmt_reloc"
-#define BINFMT_REG	"/proc/sys/fs/binfmt_misc/register"
 #define EXPECT		"BPF_INTERP_RAN"
 
-static char testdir[512]; /* directory holding this test's built artifacts */
-
-static int copy_file(const char *src, const char *dst)
-{
-	char buf[4096];
-	int in, out;
-	ssize_t n;
-
-	in = open(src, O_RDONLY);
-	if (in < 0)
-		return -1;
-	out = open(dst, O_WRONLY | O_CREAT | O_TRUNC, 0755);
-	if (out < 0) {
-		close(in);
-		return -1;
-	}
-	while ((n = read(in, buf, sizeof(buf))) > 0) {
-		if (write(out, buf, n) != n) {
-			close(in);
-			close(out);
-			return -1;
-		}
-	}
-	close(in);
-	close(out);
-	return n < 0 ? -1 : 0;
-}
-
-/* A minimal 64-bit little-endian aarch64 ELF header, padded to the read size. */
-static int create_fake_aarch64(const char *path)
+/* A minimal 64-bit little-endian ELF header, padded to the read size. */
+static int create_fake_elf(const char *path, unsigned short machine)
 {
 	unsigned char hdr[256] = {0};
 	int fd;
 
 	hdr[0] = 0x7f; hdr[1] = 'E'; hdr[2] = 'L'; hdr[3] = 'F';
-	hdr[4] = 2;			/* ELFCLASS64 */
-	hdr[5] = 1;			/* ELFDATA2LSB */
-	hdr[6] = 1;			/* EV_CURRENT */
-	hdr[16] = 2;			/* e_type = ET_EXEC */
-	hdr[18] = 183 & 0xff;		/* e_machine = EM_AARCH64 */
-	hdr[19] = (183 >> 8) & 0xff;
-	hdr[20] = 1;			/* e_version */
+	hdr[4] = ELFCLASS64;
+	hdr[5] = ELFDATA2LSB;
+	hdr[6] = EV_CURRENT;
+	hdr[16] = ET_EXEC;
+	hdr[18] = machine & 0xff;	/* e_machine, little-endian */
+	hdr[19] = machine >> 8;
+	hdr[20] = EV_CURRENT;
 
 	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0755);
 	if (fd < 0)
@@ -97,31 +71,10 @@ static int create_fake_aarch64(const char *path)
 
 static int register_entry(const char *name, const char *handler)
 {
-	char rule[128];
-	int fd;
-	ssize_t n;
+	char rule[PATH_MAX];
 
 	snprintf(rule, sizeof(rule), ":%s:B::::%s:", name, handler);
-	fd = open(BINFMT_REG, O_WRONLY);
-	if (fd < 0)
-		return -1;
-	n = write(fd, rule, strlen(rule));
-	close(fd);
-	return n < 0 ? -1 : 0;
-}
-
-static void unregister_entry(const char *name)
-{
-	char path[128];
-	int fd;
-
-	snprintf(path, sizeof(path), "/proc/sys/fs/binfmt_misc/%s", name);
-	fd = open(path, O_WRONLY);
-	if (fd >= 0) {
-		if (write(fd, "-1", 2) < 0)
-			; /* best effort */
-		close(fd);
-	}
+	return write_reg(rule);
 }
 
 static int check_output(const char *cmd, const char *expected)
@@ -178,7 +131,7 @@ static int run_case(const char *objfile, const char *handler,
 		goto detach;
 	}
 	ret = check_output(target, expect);
-	unregister_entry(entry);
+	unregister(entry);
 detach:
 	bpf_link__destroy(link);
 close:
@@ -186,92 +139,76 @@ static int run_case(const char *objfile, const char *handler,
 	return ret;
 }
 
-int main(void)
+FIXTURE(bpf_handler) {
+	char obj[PATH_MAX];	/* struct_ops object of the case under test */
+};
+
+FIXTURE_SETUP(bpf_handler)
 {
-	char src[600], obj[600], appdst[600], interpdst[600];
-	char exe[512];
-	ssize_t n;
-	int fail = 0;
+	char src[PATH_MAX];
 	struct stat st;
 	struct btf *btf;
 
-	if (getuid() != 0) {
-		fprintf(stderr, "Skipping: test must be run as root\n");
-		return 4; /* KSFT_SKIP */
-	}
+	if (getuid() != 0)
+		SKIP(return, "test must be run as root");
 
 	/* The kernel must know struct binfmt_misc_ops (CONFIG_BINFMT_MISC_BPF). */
 	btf = btf__load_vmlinux_btf();
 	if (!btf || btf__find_by_name_kind(btf, "binfmt_misc_ops",
 					   BTF_KIND_STRUCT) < 0) {
-		fprintf(stderr,
-			"Skipping: no struct binfmt_misc_ops in the kernel BTF (CONFIG_BINFMT_MISC_BPF)\n");
 		btf__free(btf);
-		return 4; /* KSFT_SKIP */
+		SKIP(return,
+		     "no struct binfmt_misc_ops in the kernel BTF (CONFIG_BINFMT_MISC_BPF)");
 	}
 	btf__free(btf);
 
-	n = readlink("/proc/self/exe", exe, sizeof(exe) - 1);
-	if (n < 0) {
-		perror("readlink");
-		return 1;
-	}
-	exe[n] = '\0';
-	snprintf(testdir, sizeof(testdir), "%s", dirname(exe));
-
 	if (stat("/sys/fs/bpf", &st) < 0)
 		mkdir("/sys/fs/bpf", 0755);
 	mount("bpf", "/sys/fs/bpf", "bpf", 0, NULL);
-	if (access(BINFMT_REG, F_OK) < 0)
-		mount("binfmt_misc", "/proc/sys/fs/binfmt_misc", "binfmt_misc", 0, NULL);
+	if (!binfmt_misc_available())
+		SKIP(return, "no binfmt_misc");
 
 	/* Shared test interpreter. */
-	snprintf(src, sizeof(src), "%s/binfmt_bpf_interp", testdir);
-	if (copy_file(src, INTERP_PATH)) {
-		fprintf(stderr, "cannot install %s\n", INTERP_PATH);
-		return 1;
-	}
+	ASSERT_EQ(artifact_path(src, sizeof(src), "binfmt_bpf_interp"), 0);
+	ASSERT_EQ(copy_file(src, INTERP_PATH), 0);
+}
 
-	/* Case 1: match a synthetic aarch64 header -> fixed interpreter. */
-	printf("[*] case 1: match aarch64 header -> program-chosen interpreter\n");
-	if (create_fake_aarch64(AARCH64_PATH)) {
-		fprintf(stderr, "cannot create %s\n", AARCH64_PATH);
-		return 1;
-	}
-	snprintf(obj, sizeof(obj), "%s/bpf_interp.bpf.o", testdir);
-	if (run_case(obj, "bpf_interp", "test_bpf_interp", AARCH64_PATH, EXPECT) == 0)
-		printf("[+] case 1 passed\n");
-	else {
-		printf("[-] case 1 FAILED\n");
-		fail = 1;
-	}
+FIXTURE_TEARDOWN(bpf_handler)
+{
+	unlink(INTERP_PATH);
+}
+
+/* The match program matches a synthetic header, the load program routes it. */
+TEST_F(bpf_handler, fixed_interpreter)
+{
+	ASSERT_EQ(create_fake_elf(AARCH64_PATH, EM_AARCH64), 0);
+	ASSERT_EQ(artifact_path(self->obj, sizeof(self->obj),
+				"bpf_interp.bpf.o"), 0);
+	EXPECT_EQ(run_case(self->obj, "bpf_interp", "test_bpf_interp",
+			   AARCH64_PATH, EXPECT), 0);
 	unlink(AARCH64_PATH);
+}
+
+/* A "$ORIGIN/..." PT_INTERP resolved to an interpreter next to the binary. */
+TEST_F(bpf_handler, origin_relative_interpreter)
+{
+	char src[PATH_MAX], app[PATH_MAX], interp[PATH_MAX];
 
-	/* Case 2: $ORIGIN-relative PT_INTERP -> co-located interpreter. */
-	printf("[*] case 2: $ORIGIN interpreter resolved relative to the binary\n");
 	mkdir(RELOC_DIR, 0755);
-	snprintf(appdst, sizeof(appdst), "%s/app", RELOC_DIR);
-	snprintf(interpdst, sizeof(interpdst), "%s/binfmt_bpf_interp", RELOC_DIR);
-	snprintf(src, sizeof(src), "%s/binfmt_bpf_app", testdir);
-	if (copy_file(src, appdst) ||
-	    copy_file(INTERP_PATH, interpdst)) {
-		fprintf(stderr, "cannot set up %s\n", RELOC_DIR);
-		fail = 1;
-	} else {
-		snprintf(obj, sizeof(obj), "%s/nix_origin.bpf.o", testdir);
-		if (run_case(obj, "nix_origin", "test_bpf_origin", appdst, EXPECT) == 0)
-			printf("[+] case 2 passed\n");
-		else {
-			printf("[-] case 2 FAILED\n");
-			fail = 1;
-		}
-	}
-	unlink(appdst);
-	unlink(interpdst);
-	rmdir(RELOC_DIR);
-	unlink(INTERP_PATH);
+	snprintf(app, sizeof(app), "%s/app", RELOC_DIR);
+	snprintf(interp, sizeof(interp), "%s/binfmt_bpf_interp", RELOC_DIR);
+	ASSERT_EQ(artifact_path(src, sizeof(src), "binfmt_bpf_app"), 0);
+	ASSERT_EQ(copy_file(src, app), 0);
+	ASSERT_EQ(copy_file(INTERP_PATH, interp), 0);
+
+	ASSERT_EQ(artifact_path(self->obj, sizeof(self->obj),
+				"nix_origin.bpf.o"), 0);
+	EXPECT_EQ(run_case(self->obj, "nix_origin", "test_bpf_origin",
+			   app, EXPECT), 0);
 
-	if (!fail)
-		printf("[*] all binfmt_misc bpf cases passed\n");
-	return fail;
+	unlink(app);
+	unlink(interp);
+	rmdir(RELOC_DIR);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/exec/binfmt_misc_common.h b/tools/testing/selftests/exec/binfmt_misc_common.h
new file mode 100644
index 000000000000..854c7a6d34e1
--- /dev/null
+++ b/tools/testing/selftests/exec/binfmt_misc_common.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Helpers shared by the binfmt_misc selftests. */
+#ifndef __SELFTESTS_EXEC_BINFMT_MISC_COMMON_H
+#define __SELFTESTS_EXEC_BINFMT_MISC_COMMON_H
+
+#include <errno.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <unistd.h>
+
+#define BINFMT_DIR	"/proc/sys/fs/binfmt_misc"
+#define BINFMT_REG	BINFMT_DIR "/register"
+
+static inline int copy_file(const char *src, const char *dst)
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
+/* Write @rule to the register file, preserving the write's errno. */
+static inline int write_reg(const char *rule)
+{
+	int fd, saved;
+	ssize_t n;
+
+	fd = open(BINFMT_REG, O_WRONLY);
+	if (fd < 0)
+		return -1;
+	n = write(fd, rule, strlen(rule));
+	saved = errno;
+	close(fd);
+	errno = saved;
+	return n < 0 ? -1 : 0;
+}
+
+static inline void unregister(const char *name)
+{
+	char path[PATH_MAX];
+	int fd;
+
+	snprintf(path, sizeof(path), BINFMT_DIR "/%s", name);
+	fd = open(path, O_WRONLY);
+	if (fd >= 0) {
+		if (write(fd, "-1", 2) < 0)
+			; /* best effort */
+		close(fd);
+	}
+}
+
+/* Mount binfmt_misc unless it already is, and report whether it is usable. */
+static inline bool binfmt_misc_available(void)
+{
+	if (access(BINFMT_REG, F_OK) < 0)
+		mount("binfmt_misc", BINFMT_DIR, "binfmt_misc", 0, NULL);
+	return access(BINFMT_REG, F_OK) == 0;
+}
+
+/* Absolute path of @name in the directory this test was built into. */
+static inline int artifact_path(char *out, size_t sz, const char *name)
+{
+	char exe[PATH_MAX];
+	ssize_t n;
+
+	n = readlink("/proc/self/exe", exe, sizeof(exe) - 1);
+	if (n < 0)
+		return -1;
+	exe[n] = '\0';
+	if ((size_t)snprintf(out, sz, "%s/%s", dirname(exe), name) >= sz)
+		return -1;
+	return 0;
+}
+
+#endif /* __SELFTESTS_EXEC_BINFMT_MISC_COMMON_H */

-- 
2.53.0

