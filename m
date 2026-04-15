Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C683803F5
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278129; cv=none; b=V7k2TV5v6s22gCr9VgeyzgEcjGKXLlIHWz1uLcR/ucQhlMHmpXTs8mQ+5iKW6k4v9JjMcpYDLOiuSWnoKJsCprr9/lUPDp1zJu+nnfWwV7EuGX9ausY65jsKj4TllEM3AF1hiknwiCKyEkXeLhVGPuKbkX7NGIJieaGBu0pGxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278129; c=relaxed/simple;
	bh=UUXJ9rgYRhxBNoctNZA1rfdM05pY4KMQdacXwbpQ63k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAAlIrNWZn/im5nmV6yMa4Ig6Pfaod//BHLPaVkf4X+FCihWqDvGIIFQ3kOAjHy8NJofvH1MIich9C2ZS/4cdzzh1cXTh34wT9wjyih9fCbPMp1OMhZ+Xo7yKAwIe/BGXG5H8HChYtspw6U3GQUj8y3ToF/jtlRLid5leyqEw5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCi6HFtL; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCi6HFtL"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2dbb4ad19a5so981822eec.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278127; x=1776882927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLBjzOG+srjBbZtELHISfuU2qJuDbOTqGUjOeR9PV7U=;
        b=UCi6HFtL3YpXFMyKr1bhFblTA8RctxotjBzgVuSaSHrr1m7XQ1ESETaWSHHNqZ8oaw
         NuwNvflpaBI6+8wakzVdcpPKuRlVn/+/Aukaf0u7ilEU2P4qVJgxHL24scGtym30hFBs
         GkiS1/fYRE/MZd0Mb6AujXk/8VF4N3n8XvO8IAuQErIWMZvFv66RkI/emZ4rITQWf3/M
         l25N7kcUkpFIEoyaGtLOnrQlBEgJ5M2Jeu4li87Gt6D2VtcUjT6iY+wlUDky93ImN9ms
         xzlLMtM4O5nn0ezOsQFJ/n0k+gw/KWzhLlgqY2+yYQ7p8+ANCJC0O96B0TJfT4et5doZ
         sLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278127; x=1776882927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLBjzOG+srjBbZtELHISfuU2qJuDbOTqGUjOeR9PV7U=;
        b=D4K6w+S8aq0Qr3hQ300mvzDar8Es4bRvJV3AbNG8ttx34GbAWd0OQ0TXy1Oh7d9GOy
         iymzcHRIGc2TPm0OeL4yPQ/sb7RYSC68OVJ990NAgF2B/5PHYHWExAf1Bg4FTx6zOFua
         DgriHhyGVIZ/48ZBbkQCe94TRwobpEf1Bg7Vj6wMh4ngk9fZTsE7r7FYYgVsw0njGrJK
         dTU1613QIVMr/haosuVQhslKUi7XJZRCeJUv4Pr+69kw6FPliMhbM6ldX+IrwKaTmBr3
         bqIWmKzgB+VuTwB5V8AOqmZByR5nQNw2+88HvLH6MbWddsUcY3xif9LMG1FjdEdssCIH
         w2Ng==
X-Gm-Message-State: AOJu0YySBa+TNHtbGNsJuIhTBbVoEriMQTrC8IL2BZpBZzeCNQCQQZo+
	BLOKFSd6fEbm1mZO0emYaKR36BUyni5kW/gTlIyCelxblbGmPZwC3POQCIPkeVBG
X-Gm-Gg: AeBDieuuciRhrZ39LKdqOOLTMuWsEPiIcVxWule4SnxpqbrYbCL8p97lOde6b1zhZW+
	56ctbGK5uoihZ5IKdoRDEKAKzf0/avMiuK3WCiGGiZw708XRuaRXu2pS0Gc/WzoJtnCaiWl4+z+
	HsNCzHO4bJwqSDX3fa30vNlJXCjmbKHtWnCBXY+QNKO9Erm+yweJrhdrv0n/xpVjPFfRI6Uw7Cr
	+VYYIrT6aNplAXF2ubjercFcrlckY5CMzjKKAgJjVpv9aQ/51MiC3OZOthYP5cZvF7cqf0BkJCu
	31zagDjfNN30IrMT1AJptE6KVvHJGijkCXgiRhix3rPrxl//92MXI2hlLl2fp2/eJ59wDT5GC9x
	n2nXIT/yDAWeV9LwZ0YTruGIa8ZfgCcL/1cZYYRo8KPKNwP5yAq3JTyyJE9VqzgUMM0pT+Wy+cu
	mM2XJMFPaDo73JZGPozXzwe2E4ah79L883G+shqx34cQuafLvq7aBZj1y4k9hoS6bKGqjn3aRZH
	YFu
X-Received: by 2002:a05:7300:dc8e:b0:2df:919f:ce59 with SMTP id 5a478bee46e88-2df919fd26dmr283904eec.19.1776278126522;
        Wed, 15 Apr 2026 11:35:26 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f960dd1sm3759720eec.25.2026.04.15.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:35:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: verify kallsyms entries for token-loaded subprograms
Date: Wed, 15 Apr 2026 11:35:14 -0700
Message-ID: <20260415-subprog-token-fix-v3-2-6fefe1d51646@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415-subprog-token-fix-v3-0-6fefe1d51646@gmail.com>
References: <20260415-subprog-token-fix-v3-0-6fefe1d51646@gmail.com>
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
 tools/testing/selftests/bpf/prog_tests/token.c     | 83 +++++++++++++++++++++-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 21 +-----
 tools/testing/selftests/bpf/progs/token_kallsyms.c | 19 +++++
 tools/testing/selftests/bpf/sysctl_helpers.c       | 26 +++++++
 tools/testing/selftests/bpf/sysctl_helpers.h       |  7 ++
 6 files changed, 134 insertions(+), 23 deletions(-)

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
index b81dde283052..cf5b94512cff 100644
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
@@ -1194,4 +1252,23 @@ void test_token(void)
 
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
+		sysctl_set("/proc/sys/kernel/perf_event_paranoid", perf_paranoid_orig, "0");
+		sysctl_set("/proc/sys/kernel/kptr_restrict", kptr_restrict_orig, "0");
+
+		subtest_userns(&opts, userns_obj_priv_prog_kallsyms);
+
+		if (perf_paranoid_orig[0])
+			sysctl_set("/proc/sys/kernel/perf_event_paranoid", NULL, perf_paranoid_orig);
+		if (kptr_restrict_orig[0])
+			sysctl_set("/proc/sys/kernel/kptr_restrict", NULL, kptr_restrict_orig);
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
index 000000000000..e58c23adaa3e
--- /dev/null
+++ b/tools/testing/selftests/bpf/sysctl_helpers.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include "sysctl_helpers.h"
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
diff --git a/tools/testing/selftests/bpf/sysctl_helpers.h b/tools/testing/selftests/bpf/sysctl_helpers.h
new file mode 100644
index 000000000000..28d7e209df72
--- /dev/null
+++ b/tools/testing/selftests/bpf/sysctl_helpers.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SYSCTL_HELPERS_H
+#define __SYSCTL_HELPERS_H
+
+int sysctl_set(const char *sysctl_path, char *old_val, const char *new_val);
+
+#endif

-- 
2.53.0
