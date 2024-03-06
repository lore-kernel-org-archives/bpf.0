Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF755CDED
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710835; cv=none; b=LeGqYKTNlWJAuHDCmwon+vBU1W9MJK5leWbcKxGidqGQ7g622IMEgA8iC/tV1xVVx3BXP9QpPgFtFCZAT0JJFDPuYFsbF9bSgVCfgHON8BdUl1vYJV69kmYdSwv9W+pG7o/8WVaCQLzhuSVVIaYfH/9H2GMHxIvPdtevg2Pn3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710835; c=relaxed/simple;
	bh=Pj+o0wUiDrAZvuk8PrK4QBMqMvi5OoqumxrZvD4Kl9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdNKFjebWraP9V+JzWD3ea3ZHJp/P0BA02wDpDT2BYK9/l2OEJaL/Z4KeBhoEXS6QDqebh0HJ6+w6hGAefzI9m0Asmp2qHxLAaJ2Qa+E08Nw/hCXwf+3Zci0RYUTIY7E+vIPQAnh8aecKm4hWt43AnBoGegReKU9ToUaZ+NfomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5Z7Hivw; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5Z7Hivw"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-595aa5b1fe0so1008776eaf.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 23:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710832; x=1710315632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fH1k+SV/f0vvM8HD0mhAGfqzECUsbN8zTP2gm81qF5A=;
        b=e5Z7Hivw0M/ShryHD9fAt+sc97/QEoSKlPIAmS83+Z8nVaFogO8/38ipy41+1hNjrm
         SvfuHVP6vd8LhyoRU+H/wxRmcQFWyCwgwAgiS1U7bwHL5yXQE+wat15NUnZF4+dUPOW1
         cEwO0G2dxjHPxo06y9lKTXLFnIrETIwflqNrGhzfqq9glp7pISZaAnEF+MWCqdDxUUnN
         eSuUaTGD880aF5Xc4QVX7rkrNle7FSm5em3OWV1h+0QSgCGTIhL3BMxppFb5LBkJ5Y0E
         BhKHV2cAknYdotlGsaFR38QXCRNcuUdGtbNyxlaz8XFSXuZF8IL3kWyvPlsCHbB2heM4
         G8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710832; x=1710315632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH1k+SV/f0vvM8HD0mhAGfqzECUsbN8zTP2gm81qF5A=;
        b=krWHK4servHx2Q0OQcEyKWZAvBsn8LP75ezue6cpyBnBv8L2cT5VsPkgAb4Vzxm/sk
         Jijp7+x7CiHXNQYfmmP3OCbAtuxD+OalES3pN3kyWV9qlBYcqfNCIGtYvvtoPsysGVZH
         j/IYPGbnqstMwmsuAAC+51Qae3AXX53eTmLD2FSlnNqqVt4dz0fLXDJI1ZVEl2z6L257
         XznIhO5l/cpkVk6jf5jXmayP26/kKgQiCX+iEzUZlNNmo6kFp1Vv2rlgPVwlSZ+QiBwJ
         7FOF0Ajgy8/P2RME0cfu6IV2e6gmEerF7LaxQRYoMZmhKpjORSeu4TIFjQWnKMlZHKvU
         vptg==
X-Gm-Message-State: AOJu0YxMPiRSP+m2P0WAv4w3xzd6S/C9R9DUB/z2pLgffZfY7StAELxs
	qtfeflhN+/NtUrDpucS8RS4usE45PqCz1UKLtdvw5TADL9zdtjOU72z8fKyaQ7C+X+RY0CpARi6
	v0g==
X-Google-Smtp-Source: AGHT+IFslANPT783zPiQEmQCglAKToxQEC4ZXx0rG+iPYroD1+COb5i4MmK62W2unVaTgUg6mCsULw==
X-Received: by 2002:a05:6870:471f:b0:21f:a11a:e251 with SMTP id b31-20020a056870471f00b0021fa11ae251mr4336889oaq.5.1709710831768;
        Tue, 05 Mar 2024 23:40:31 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id gb8-20020a056870670800b00220db41819bsm2152952oab.2.2024.03.05.23.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:40:31 -0800 (PST)
Date: Wed, 6 Mar 2024 07:40:25 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 9/9] bpf/selftests: adapt selftests test_d_path
 for BPF kfunc bpf_path_d_path()
Message-ID: <9cf1f10d6f6f16095b8cea1d4291a54469542090.1709675979.git.mattbobrowski@google.com>
References: <cover.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709675979.git.mattbobrowski@google.com>

Adapt the existing test_d_path test suite to cover the operability of
the newly introduced trusted d_path() based BPF kfunc
bpf_path_d_path().

This new BPF kfunc is functionally identical with regards to its path
reconstruction based capabilities to that of its predecessor
bpf_d_path(), so it makes sense to recycle the existing test_d_path
suite.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../testing/selftests/bpf/prog_tests/d_path.c | 80 +++++++++++++++++++
 .../selftests/bpf/progs/d_path_common.h       | 35 ++++++++
 .../bpf/progs/d_path_kfunc_failure.c          | 66 +++++++++++++++
 .../bpf/progs/d_path_kfunc_success.c          | 25 ++++++
 .../testing/selftests/bpf/progs/test_d_path.c | 20 +----
 .../bpf/progs/test_d_path_check_rdonly_mem.c  |  8 +-
 .../bpf/progs/test_d_path_check_types.c       |  8 +-
 7 files changed, 209 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..cc5c886fe59b 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -11,6 +11,8 @@
 #include "test_d_path.skel.h"
 #include "test_d_path_check_rdonly_mem.skel.h"
 #include "test_d_path_check_types.skel.h"
+#include "d_path_kfunc_failure.skel.h"
+#include "d_path_kfunc_success.skel.h"
 
 /* sys_close_range is not around for long time, so let's
  * make sure we can call it on systems with older glibc
@@ -124,6 +126,13 @@ static void test_d_path_basic(void)
 	struct test_d_path *skel;
 	int err;
 
+	/*
+	 * Carrying global state across test function invocations is super
+	 * gross, but it was late and I was tired and I just wanted to get the
+	 * darn test working. Zero'ing this out was a simple no brainer.
+	 */
+	memset(&src, 0, sizeof(src));
+
 	skel = test_d_path__open_and_load();
 	if (CHECK(!skel, "setup", "d_path skeleton failed\n"))
 		goto cleanup;
@@ -195,8 +204,72 @@ static void test_d_path_check_types(void)
 	test_d_path_check_types__destroy(skel);
 }
 
+static struct bpf_path_d_path_t {
+	const char *prog_name;
+} success_test_cases[] = {
+	{
+		.prog_name = "path_d_path_from_path_argument",
+	},
+};
+
+static void test_bpf_path_d_path(struct bpf_path_d_path_t *t)
+{
+	int i, ret;
+	struct bpf_link *link;
+	struct bpf_program *prog;
+	struct d_path_kfunc_success__bss *bss;
+	struct d_path_kfunc_success *skel;
+
+	/*
+	 * Carrying global state across function invocations is super gross, but
+	 * it was late and I was tired and I just wanted to get the darn test
+	 * working. Zero'ing this out was a simple no brainer.
+	 */
+	memset(&src, 0, sizeof(src));
+
+	skel = d_path_kfunc_success__open();
+	if (!ASSERT_OK_PTR(skel, "d_path_kfunc_success__open"))
+		return;
+
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	ret = d_path_kfunc_success__load(skel);
+	if (CHECK(ret, "setup", "d_path_kfunc_success__load\n"))
+		goto cleanup;
+
+	link = NULL;
+	prog = bpf_object__find_program_by_name(skel->obj, t->prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto cleanup;
+
+	ret = trigger_fstat_events(bss->my_pid);
+	if (ret < 0)
+		goto cleanup;
+
+	for (i = 0; i < MAX_FILES; i++) {
+		CHECK(strncmp(src.paths[i], bss->paths_stat[i], MAX_PATH_LEN),
+		      "check", "failed to get stat path[%d]: %s vs %s\n", i,
+		      src.paths[i], bss->paths_stat[i]);
+		CHECK(bss->rets_stat[i] != strlen(bss->paths_stat[i]) + 1,
+		      "check",
+		      "failed to match stat return [%d]: %d vs %zd [%s]\n", i,
+		      bss->rets_stat[i], strlen(bss->paths_stat[i]) + 1,
+		      bss->paths_stat[i]);
+	}
+cleanup:
+	bpf_link__destroy(link);
+	d_path_kfunc_success__destroy(skel);
+}
+
 void test_d_path(void)
 {
+	int i = 0;
+
 	if (test__start_subtest("basic"))
 		test_d_path_basic();
 
@@ -205,4 +278,11 @@ void test_d_path(void)
 
 	if (test__start_subtest("check_alloc_mem"))
 		test_d_path_check_types();
+
+	for (; i < ARRAY_SIZE(success_test_cases); i++) {
+		if (!test__start_subtest(success_test_cases[i].prog_name))
+			continue;
+		test_bpf_path_d_path(&success_test_cases[i]);
+	}
+	RUN_TESTS(d_path_kfunc_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/d_path_common.h b/tools/testing/selftests/bpf/progs/d_path_common.h
new file mode 100644
index 000000000000..276331b5ff9f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_common.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#ifndef _D_PATH_COMMON_H
+#define _D_PATH_COMMON_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+#define MAX_PATH_LEN 128
+#define MAX_FILES 7
+
+extern const int bpf_prog_active __ksym;
+int bpf_path_d_path(struct path *path, char *buf, int buflen) __ksym;
+
+pid_t my_pid = 0;
+
+__u32 cnt_stat = 0;
+__u32 cnt_close = 0;
+
+char paths_stat[MAX_FILES][MAX_PATH_LEN] = {};
+char paths_close[MAX_FILES][MAX_PATH_LEN] = {};
+
+int rets_stat[MAX_FILES] = {};
+int rets_close[MAX_FILES] = {};
+
+int called_stat = 0;
+int called_close = 0;
+
+char _license[] SEC("license") = "GPL";
+
+#endif /* _D_PATH_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c b/tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c
new file mode 100644
index 000000000000..9da5f0d395c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "d_path_common.h"
+
+char buf[MAX_PATH_LEN] = {};
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(path_d_path_kfunc_null)
+{
+	/* Can't pass NULL value to bpf_path_d_path() kfunc. */
+	bpf_path_d_path(NULL, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("fentry/vfs_open")
+__failure __msg("calling kernel function bpf_path_d_path is not allowed")
+int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
+{
+	/* Calling bpf_path_d_path() kfunc from a non-sleepable and non-LSM
+	 * based program isn't permitted.
+	 */
+	bpf_path_d_path(path, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(path_d_path_kfunc_untrusted_from_argument, struct task_struct *task)
+{
+	struct path *root;
+
+	/* Walking a trusted argument yields an untrusted pointer. */
+	root = &task->fs->root;
+	bpf_path_d_path(root, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
+{
+	struct path *pwd;
+	struct task_struct *current;
+
+	current = bpf_get_current_task_btf();
+	/* Walking a trusted pointer returned from bpf_get_current_task_btf()
+	 * yields and untrusted pointer. */
+	pwd = &current->fs->pwd;
+	bpf_path_d_path(pwd, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 must have zero offset when passed to release func or trusted arg to kfunc")
+int BPF_PROG(path_d_path_kfunc_trusted_variable_offset, struct file *file)
+{
+	/* Passing variable offsets from a trusted aren't supported just yet,
+	 * despite being perfectly OK i.e. file->f_path. Once the BPF verifier
+	 * has been updated to handle this case, this test can be removed. For
+	 * now, ensure we reject the BPF program upon load if this is attempted.
+	 */
+	bpf_path_d_path(&file->f_path, buf, sizeof(buf));
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/d_path_kfunc_success.c b/tools/testing/selftests/bpf/progs/d_path_kfunc_success.c
new file mode 100644
index 000000000000..72d1a64618d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_kfunc_success.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "d_path_common.h"
+
+SEC("lsm.s/inode_getattr")
+int BPF_PROG(path_d_path_from_path_argument, struct path *path)
+{
+	u32 cnt = cnt_stat;
+	int ret;
+	pid_t pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != my_pid)
+		return 0;
+
+	if (cnt >= MAX_FILES)
+		return 0;
+
+	ret = bpf_path_d_path(path, paths_stat[cnt], MAX_PATH_LEN);
+	rets_stat[cnt] = ret;
+	cnt_stat++;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..5bdfa4abb5f6 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -1,22 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-#define MAX_PATH_LEN		128
-#define MAX_FILES		7
-
-pid_t my_pid = 0;
-__u32 cnt_stat = 0;
-__u32 cnt_close = 0;
-char paths_stat[MAX_FILES][MAX_PATH_LEN] = {};
-char paths_close[MAX_FILES][MAX_PATH_LEN] = {};
-int rets_stat[MAX_FILES] = {};
-int rets_close[MAX_FILES] = {};
-
-int called_stat = 0;
-int called_close = 0;
+#include "d_path_common.h"
 
 SEC("fentry/security_inode_getattr")
 int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
@@ -61,5 +45,3 @@ int BPF_PROG(prog_close, struct file *file, void *id)
 	cnt_close++;
 	return 0;
 }
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
index 27c27cff6a3a..6094a58321a4 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
@@ -1,11 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Google */
 
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-extern const int bpf_prog_active __ksym;
+#include "d_path_common.h"
 
 SEC("fentry/security_inode_getattr")
 int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
@@ -24,5 +20,3 @@ int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
 	}
 	return 0;
 }
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_d_path_check_types.c b/tools/testing/selftests/bpf/progs/test_d_path_check_types.c
index 7e02b7361307..6d4204136489 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path_check_types.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path_check_types.c
@@ -1,10 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-extern const int bpf_prog_active __ksym;
+#include "d_path_common.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
@@ -28,5 +24,3 @@ int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
 	}
 	return 0;
 }
-
-char _license[] SEC("license") = "GPL";
-- 
2.44.0.278.ge034bb2e1d-goog

/M
