Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6019D8BC
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212262; cv=none; b=M/gI67ypuPusBCLMe5Xf6gs8JKhhx4c0P702Lzv56rvVG0vegGXU3wND6SaHeDP++brH8Zr1g261jtX9vIgPpKMN0pvrUAi3PN/+lMvUou5CoZLJpojae89kOM2ph26wrTGRqMRX0qLE1d0pCZddogU2BxlJkn6nN9MDKGsnucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212262; c=relaxed/simple;
	bh=O4BijoK3zbfcZup0VXmkuLjVpCYgtAjmdgFJ7QOkxYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rt1Iq1v4qgRa14ajPthbYfjKFhMGUi0l0t15vTO79hmWxUqlfTxkkk7JkIyVgMtRnenhUHbqqHrGe0CC5SAeqcFl5M1SHVz2fsOVLWv284xRfyglq9ZfGMwro06nNdTchsNSHvoWxVFEkeaTaMMp8II/XoZSTXPN49yIVgekBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEyxAYtx; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEyxAYtx"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c287eb77fso9508467c88.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212260; x=1776817060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OH5yOwt0WmQ49babyt5RSfFlSHNcQL84uj3POx4g38A=;
        b=DEyxAYtxo5f9P5HUbye085Fxw62DVb5RQl6Y+Po5Jag1zWyHKM2qkYrXWwbzbnntPA
         IZEKH479qZuDNK1lRnuuRpQUd/+P/eWKMJnXkCNH8kk6IBLTthoagdlf6f6oGnlhJDsQ
         Fw3/t557DTqcQVnkodb/84CLDNDiPuD/hxv2IHccUCMGr/HCvyNWFr6FoF+LMKVqNFXY
         sMxV8gGZvdvQZEW1jxj0Yi8VX6Gp6FY2T9+1Zf3/9v37mxHoHJM+JgwUwqBXeI2Zpn9u
         IaHxO0NWHylt5eYswnqoSTXqoB0hO3jZrOKWGPCMNjieGL+gNfjHWwNTeJ94cK+kwbSI
         ia/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212260; x=1776817060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OH5yOwt0WmQ49babyt5RSfFlSHNcQL84uj3POx4g38A=;
        b=OSstCyGz3mv6oJUkfirM+On5Lb+ogHE4XlB/OyRNE+ox08bsDoJJ4CmXzx7dxbNG2K
         i/O0Gf2CwXK8vEBq3nBjO8MS2ZLxayCGkBMNrrRIEFsnzTQ+XAVBcUBjcMDVbAmuDgiS
         EyE4OwGNdA5OBgI61tD2xlhShQvAibPApEA0LkBl4uYTPQqgPw/zIlvwVQv/BWaVADok
         KWc3U9/vJFhFMvaZ2+k6ha2u+bIXt97uAyZEj2zj0I8/2qrx/teMAzB8I+XQgFK0i1uF
         /inJeUN13L52mDQlCelrB3+b4ZB7zUPWcPNK26DFd7ihiqoi43DpAKD9Goh3jdCe0V/q
         A16g==
X-Gm-Message-State: AOJu0Yxh9d92ua4Pl14eK3IXSSC9fn95RRTj8jhUX3skZcRjHS8CZOEQ
	wY8ORP3MC5ugh1bq1SFpzC+h6y/4CTSvPtquvIJYRQe1kW3qVgj6ZsSdaANtMnQt
X-Gm-Gg: AeBDievLZdJLMwc6T3KNuzT13DJHjDO2/jFv6Pw1yWhLol+/e+cdbDkIFsy+9EUjogz
	RZx0YbLJOXJZs95IP3mzYF05DuYIf43nvCO6nMyPxO0T8+N47pFQcnFnS5X87IyoRMUMrLotYbe
	UhrTSlaNO7yoCaX8PxA0rMF6K4tCiqS44V+WB5RdwPk+6iyvI+IzjKufpBU8qu34u4zUmR3EvX9
	Bo7fTCSj0F25Afdqdi7L78EbSHZObDYU9GVIBSmTkA8a5z70LM+Kwbj2bs3fxNjLJitm334k8Ba
	nL01k7fQQSLUciQ56KhdJSk+pqIdK2/+Eojj7UbePpxovXsTx2GMO2erVNfzUaTzcLG/yrdG11u
	pldRxEb7DNNmsizf/MogP6qqpe3eLrIbYt9Pze4eoGBIrEXqTU6TSZFhUJo9gJnB8IjHPPUWxhb
	ibce75JJGlR4lPjS6HuN/jN5AojY7DaZVSeBzwcjBY+x/3wUry/NFI5dNEblJNWf4jd5gz5KdXa
	ums
X-Received: by 2002:a05:7022:389:b0:124:9acd:328d with SMTP id a92af1059eb24-12c34eedc50mr11109303c88.22.1776212260266;
        Tue, 14 Apr 2026 17:17:40 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::d8d4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm20171978c88.15.2026.04.14.17.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:17:40 -0700 (PDT)
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
Subject: [PATCH bpf 2/2] selftests/bpf: verify kallsyms entries for token-loaded subprograms
Date: Tue, 14 Apr 2026 17:17:27 -0700
Message-ID: <20260414-subprog-token-fix-v1-2-5b1a38e01546@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com>
References: <20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile               |  1 +
 tools/testing/selftests/bpf/prog_tests/token.c     | 81 +++++++++++++++++++++-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 21 +-----
 tools/testing/selftests/bpf/progs/token_kallsyms.c | 19 +++++
 tools/testing/selftests/bpf/sysctl_helpers.c       | 26 +++++++
 tools/testing/selftests/bpf/sysctl_helpers.h       |  7 ++
 6 files changed, 133 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 65485967c968..e546ae014629 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -744,6 +744,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 btf_helpers.c		\
 			 cap_helpers.c		\
 			 unpriv_helpers.c 	\
+			 sysctl_helpers.c	\
 			 netlink_helpers.c	\
 			 jit_disasm_helpers.c	\
 			 io_helpers.c		\
diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index b81dde283052..89da527ed930 100644
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
