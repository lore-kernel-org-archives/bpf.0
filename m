Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8138655F
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283450; cv=none; b=blCsquufCtvLndxFq+KvXVgKlBS0whlbNelfsCnBv8XIt0VuuZDmL4K/u2os0ZieMeZ+8zKmRLvHoPtjUdLdPais7Ivs7pvmc42q+6PoIe6V9V5WLiLW4taOGJUeSJWa9iuClQqkgsjLOul8UVibgq7GM9f1PwUEZ1M3Y7hLlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283450; c=relaxed/simple;
	bh=P1B62J61oXGyetrf9sD2pdNCsKDR9LBvtqWd7vQ2f7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJEvOjdxx7m0VZkpvwp9jNgM6wb73LIH0o5lmAl9qP11wj29hmokHfqhtvxtHbRsdb0oLLgp9w7cBI1wRr6uPrOkv9JiZihKLcnzcucAi5db5pLKOwtMU2h1BvbpyPZJ5BZX591VkkVtVTuBoDR4BDALBABxVxpYLVLjrzeyyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7ALfrR4; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7ALfrR4"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1274204434bso4471962c88.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776283448; x=1776888248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwllGzLDN441v7bvJtdg6SUsMePjoeq9h+eSkFDH67E=;
        b=k7ALfrR4JvGRECAT7iKT2qRsjd3ciQ8FBCpxRWb7ji3V8KCEKdYV1oJ/Jt1AUxSKbO
         kPc+aO+33NQ0ooC4e7VH0+wQPtvz/m7imnkCu4aDzdtS6aedpMbuRzpju7p/awUeTq6U
         cS7RstJjP/+8amJ7Q5PsrQz6Inkx9hKpKM2QNANBdHz/cCXUBZ9ippgAOonQ4JvBK596
         gJVJNGB3ezrrzjLaz0BVoP1NcwtF0zw7eRwa/mtf336N0vaZR9QzHcqgnI21C1wQTAcq
         puE9TEXsF5whBCeEH5i4deI7Fs5VksbISvibHzDgpPbtuVzR8m/qaaW8IL5fgtL2xGgb
         VObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776283448; x=1776888248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwllGzLDN441v7bvJtdg6SUsMePjoeq9h+eSkFDH67E=;
        b=D0jmNZiEvTCLJAc67R0a28QRrLdAIMXuJZ7COYWlbhhIE5xhBi99JNvtrUc08IejR3
         TMH0ni/XbTuxlSlZFYuP+iev3FP4vWwCWWPyjRJ0l0g6v+meaXSqpY1nJkfjhJKFgUjI
         wL88Q0wSXKyvwg7izsh68koW38zpLUjqnwvkeAZdimcl+lMUZltQHB3YfO8B3fTCoc21
         Na0yV55IU6O9X2OmXpvYFMaF4XEfGJ9m7Efzz+qB/CZl4gushoL+xedq6DfRJM8ayXUT
         0ScoqM3P8tKyDDwfjYflRTXSZpSPJ9pW7JOBBFLWe8+aQafdJZC5ltfk5VeOD+c+FMNr
         +7hw==
X-Gm-Message-State: AOJu0YwlRWeLfczuHAVZZVtPRyUm6nR10jSt5BP3Ka+MyihzzvBAhjQv
	AdAxdqzhYOctdKaIhY611/iKfx09zEsvZuxKnfyNYDF9DwsWbOFduwAE444n6NqK
X-Gm-Gg: AeBDieuiv9kfdORRK/zOgsoLvfQCMbaRz99DTU+zr88puhkxVLV+9jsP+6+vJM+6Np2
	gVa83G3Y18CrrmydLyt1tA0DjkbRNm6u/r9m9bNZrffD+cOEXhgVBFLYEvTXKiIOj2gZ4Eg7agM
	Zd6a7fXzZQxOi/Cp3tlvmUUAHXPLDzOvdyossLi5HmNmf2p1utsxuD/fXxv7wxov0872VXULdcX
	ytLhGba62EUxAlLXyY1J2Tmf1AUaTS1RZFYJU18CXJ3aSLzqqZ4pt0nrzONea76PZVLGVchi0WU
	ohfPG29O56fshu4ynEadBJVMd93UUVxWrN5uhDuuSRzshsBzSvdHkXhwR4FW5HgbhaWqBqLgPpj
	hRZZKvD+2d++nlpHxyNhvdAsUhraeHI3464v4Za6CLN2vwRWCg0IsQNLhqQmzKoDyYNdZJqumAY
	SXTE7E2/jatS0NkJ1Q7r00DI4Tv08BENcX3huPCNzEx7KYFoW9v0C136yQarX1ZUX9kTx2WNbfy
	EhE
X-Received: by 2002:a05:693c:3018:b0:2ca:bd22:6102 with SMTP id 5a478bee46e88-2df7f465eeamr446949eec.14.1776283447998;
        Wed, 15 Apr 2026 13:04:07 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c605851sm4163518eec.9.2026.04.15.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:04:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ctao@meta.com
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: verify kallsyms entries for token-loaded subprograms
Date: Wed, 15 Apr 2026 13:03:56 -0700
Message-ID: <20260415-subprog-token-fix-v4-2-9bd000e8b068@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415-subprog-token-fix-v4-0-9bd000e8b068@gmail.com>
References: <20260415-subprog-token-fix-v4-0-9bd000e8b068@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add a test that loads an XDP program with a global subprogram using a
BPF token from a user namespace, then verifies that both the main
program and the subprogram appear in /proc/kallsyms.

This exercises the bpf_prog_kallsyms_add() path for subprograms and
would have caught the missing aux->token copy in bpf_jit_subprogs().

load_kallsyms_local() filters out kallsyms with zero addresses.
For a process with limited capabilities to read kallsym addresses the
following sysctl variables have to be set to zero:
- /proc/sys/kernel/perf_event_paranoid
- /proc/sys/kernel/kptr_restrict
Set these variables using sysctl_set() utility function extracted from
unpriv_bpf_disabled.c to a separate c/header.
Since the test modifies global system state, mark it as serial.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile               |  1 +
 tools/testing/selftests/bpf/prog_tests/token.c     | 86 +++++++++++++++++++++-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 21 +-----
 tools/testing/selftests/bpf/progs/token_kallsyms.c | 19 +++++
 tools/testing/selftests/bpf/sysctl_helpers.c       | 37 ++++++++++
 tools/testing/selftests/bpf/sysctl_helpers.h       |  8 ++
 6 files changed, 149 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c028..da81a1853cfd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -750,6 +750,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 btf_helpers.c		\
 			 cap_helpers.c		\
 			 unpriv_helpers.c 	\
+			 sysctl_helpers.c	\
 			 netlink_helpers.c	\
 			 jit_disasm_helpers.c	\
 			 io_helpers.c		\
diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index b81dde283052..f2f5d36ae00a 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 #define _GNU_SOURCE
-#include <test_progs.h>
 #include <bpf/btf.h>
-#include "cap_helpers.h"
 #include <fcntl.h>
 #include <sched.h>
 #include <signal.h>
@@ -15,9 +13,17 @@
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/un.h>
+
+#include "bpf_util.h"
+#include "cap_helpers.h"
+#include "sysctl_helpers.h"
+#include "test_progs.h"
+#include "trace_helpers.h"
+
 #include "priv_map.skel.h"
 #include "priv_prog.skel.h"
 #include "dummy_st_ops_success.skel.h"
+#include "token_kallsyms.skel.h"
 #include "token_lsm.skel.h"
 #include "priv_freplace_prog.skel.h"
 
@@ -1045,6 +1051,58 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 	return -EINVAL;
 }
 
+static bool kallsyms_has_bpf_func(struct ksyms *ksyms, const char *func_name)
+{
+	char name[256];
+	int i;
+
+	for (i = 0; i < ksyms->sym_cnt; i++) {
+		if (sscanf(ksyms->syms[i].name, "bpf_prog_%*[^_]_%255s", name) == 1 &&
+		    strcmp(name, func_name) == 0)
+			return true;
+	}
+	return false;
+}
+
+static int userns_obj_priv_prog_kallsyms(int mnt_fd, struct token_lsm *lsm_skel)
+{
+	const char *func_names[] = { "xdp_main", "token_ksym_subprog" };
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct token_kallsyms *skel;
+	struct ksyms *ksyms = NULL;
+	char buf[256];
+	int i, err;
+
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path = buf;
+	skel = token_kallsyms__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "token_kallsyms__open_opts"))
+		return -EINVAL;
+
+	err = token_kallsyms__load(skel);
+	if (!ASSERT_OK(err, "token_kallsyms__load"))
+		goto cleanup;
+
+	ksyms = load_kallsyms_local();
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_local")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(func_names); i++) {
+		if (!ASSERT_TRUE(kallsyms_has_bpf_func(ksyms, func_names[i]),
+				 func_names[i])) {
+			err = -EINVAL;
+			break;
+		}
+	}
+
+cleanup:
+	free_kallsyms_local(ksyms);
+	token_kallsyms__destroy(skel);
+	return err;
+}
+
 #define bit(n) (1ULL << (n))
 
 static int userns_bpf_token_info(int mnt_fd, struct token_lsm *lsm_skel)
@@ -1082,7 +1140,7 @@ static int userns_bpf_token_info(int mnt_fd, struct token_lsm *lsm_skel)
 	return err;
 }
 
-void test_token(void)
+void serial_test_token(void)
 {
 	if (test__start_subtest("map_token")) {
 		struct bpffs_opts opts = {
@@ -1194,4 +1252,26 @@ void test_token(void)
 
 		subtest_userns(&opts, userns_bpf_token_info);
 	}
+	if (test__start_subtest("obj_priv_prog_kallsyms")) {
+		char perf_paranoid_orig[32] = {};
+		char kptr_restrict_orig[32] = {};
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD),
+			.progs = bit(BPF_PROG_TYPE_XDP),
+			.attachs = ~0ULL,
+		};
+
+		if (sysctl_set_or_fail("/proc/sys/kernel/perf_event_paranoid", perf_paranoid_orig, "0"))
+			goto cleanup;
+		if (sysctl_set_or_fail("/proc/sys/kernel/kptr_restrict", kptr_restrict_orig, "0"))
+			goto cleanup;
+
+		subtest_userns(&opts, userns_obj_priv_prog_kallsyms);
+
+cleanup:
+		if (perf_paranoid_orig[0])
+			sysctl_set_or_fail("/proc/sys/kernel/perf_event_paranoid", NULL, perf_paranoid_orig);
+		if (kptr_restrict_orig[0])
+			sysctl_set_or_fail("/proc/sys/kernel/kptr_restrict", NULL, kptr_restrict_orig);
+	}
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
index 472f4f9fa95f..64404602b9ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -8,6 +8,7 @@
 
 #include "cap_helpers.h"
 #include "bpf_util.h"
+#include "sysctl_helpers.h"
 
 /* Using CAP_LAST_CAP is risky here, since it can get pulled in from
  * an old /usr/include/linux/capability.h and be < CAP_BPF; as a result
@@ -36,26 +37,6 @@ static void process_perfbuf(void *ctx, int cpu, void *data, __u32 len)
 		got_perfbuf_val = *(__u32 *)data;
 }
 
-static int sysctl_set(const char *sysctl_path, char *old_val, const char *new_val)
-{
-	int ret = 0;
-	FILE *fp;
-
-	fp = fopen(sysctl_path, "r+");
-	if (!fp)
-		return -errno;
-	if (old_val && fscanf(fp, "%s", old_val) <= 0) {
-		ret = -ENOENT;
-	} else if (!old_val || strcmp(old_val, new_val) != 0) {
-		fseek(fp, 0, SEEK_SET);
-		if (fprintf(fp, "%s", new_val) < 0)
-			ret = -errno;
-	}
-	fclose(fp);
-
-	return ret;
-}
-
 static void test_unpriv_bpf_disabled_positive(struct test_unpriv_bpf_disabled *skel,
 					      __u32 prog_id, int prog_fd, int perf_fd,
 					      char **map_paths, int *map_fds)
diff --git a/tools/testing/selftests/bpf/progs/token_kallsyms.c b/tools/testing/selftests/bpf/progs/token_kallsyms.c
new file mode 100644
index 000000000000..c9f9344f3eb2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/token_kallsyms.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+__weak
+int token_ksym_subprog(void)
+{
+	return 0;
+}
+
+SEC("xdp")
+int xdp_main(struct xdp_md *xdp)
+{
+	return token_ksym_subprog();
+}
diff --git a/tools/testing/selftests/bpf/sysctl_helpers.c b/tools/testing/selftests/bpf/sysctl_helpers.c
new file mode 100644
index 000000000000..e2bd824f12d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/sysctl_helpers.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include "sysctl_helpers.h"
+#include "test_progs.h"
+
+int sysctl_set(const char *sysctl_path, char *old_val, const char *new_val)
+{
+	int ret = 0;
+	FILE *fp;
+
+	fp = fopen(sysctl_path, "r+");
+	if (!fp)
+		return -errno;
+	if (old_val && fscanf(fp, "%s", old_val) <= 0) {
+		ret = -ENOENT;
+	} else if (!old_val || strcmp(old_val, new_val) != 0) {
+		fseek(fp, 0, SEEK_SET);
+		if (fprintf(fp, "%s", new_val) < 0)
+			ret = -errno;
+	}
+	fclose(fp);
+
+	return ret;
+}
+
+int sysctl_set_or_fail(const char *sysctl_path, char *old_val, const char *new_val)
+{
+	int err;
+
+	err = sysctl_set(sysctl_path, old_val, new_val);
+	if (err)
+		PRINT_FAIL("failed to set %s to %s: %s\n", sysctl_path, new_val, strerror(-err));
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/sysctl_helpers.h b/tools/testing/selftests/bpf/sysctl_helpers.h
new file mode 100644
index 000000000000..35e37bfe1b3b
--- /dev/null
+++ b/tools/testing/selftests/bpf/sysctl_helpers.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SYSCTL_HELPERS_H
+#define __SYSCTL_HELPERS_H
+
+int sysctl_set(const char *sysctl_path, char *old_val, const char *new_val);
+int sysctl_set_or_fail(const char *sysctl_path, char *old_val, const char *new_val);
+
+#endif

-- 
2.53.0
