Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14D5C90D
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710830; cv=none; b=G4T6rLEjCJCOXDtz8bLKhoLNnmHYDnA6WpGavW73XBio2kx0JnNfZorv/XVELjGQiAMR4u2NN5JyNNCi4JdnIx1RN7eidWgTj4eAJgvepG6D8C9/VPjF9ErpnFiqWkRkLpDu9XcvyPn1CSAWO00JL4w/V3qvc4VtEE34N2s06Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710830; c=relaxed/simple;
	bh=iLwHbf1oA5JxBnipUArq42l7X5KO0sj3Xs/LCM1ozFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRJTQXUXMjClWo7qsIfNgaWDW5lq6S1uyvWbBZ5JPAF83URQ5AfrTau+J6cXpPRQF/UhmAYZ86AIO/zkVBaZbCTDhb8Sqv6Q72NA0MB8ocbe3rmdu5EHYJJ372ITcSd7m6Q92PgKz5bqrAD+oTdOZlTZQ6iIzT9hKKpbDwHLO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3U7IjL4; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3U7IjL4"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1e992f060so1957032b6e.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 23:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710827; x=1710315627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4298WmfQQE8gZH7rXnLK/a7brfP51MJX0hKZlrVvaHE=;
        b=B3U7IjL4ZRu4xEROnDLt1qZdriNC1IS6TKGWioMXq8AsDJ9WOS/rAd2Iudvu5amDmc
         uHW1tPqNCC6vMTHL/j5W81O2OUsLEggF4useMqR9nuoijbaD2sqvoHcXgro+3L9wmlI4
         ppKmE6sH2+WRqWL0bPnZIai9zanGnYzmwy6IfLt4SIq/7XyIsp8zMYfBQmiiCd+nskQq
         7PNg4py/ufAKFukAO7rnUkT75lG3MtzmEXonYVJD2/AY562+KBKCCAyWUYklY1lGEb4e
         2HENmACGfq5pFmNKOd0MNc7eahVF9lYcAunGXrt9mjPCxe/5iXL1VAUtfM5GIab+Hs+E
         qVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710827; x=1710315627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4298WmfQQE8gZH7rXnLK/a7brfP51MJX0hKZlrVvaHE=;
        b=c839f4zUhKJuNjiQeO91VQ1GMsr5duaWeFmQXlKiLs66kQyOX5VYsKDiieso26xoqO
         YYsG2FpGezVqma8hm+khz/rs/a8EU2SxUyOQzNdHT+WFwY1XucdusnwRJJEgNSUTauVd
         BeOxpxUjo3LbJFsLtli+xhfsQflGrrMaaAa8uhgWaMWodWxkuXgaoZquyGzx0B7B7Zxk
         SPSMBaKojRH9uu1N4n0GFuDkBIhb1I7KEyFKkRF3oymW6f8kEVK7pVLS+dFv/Rmeu+1n
         FF/xteIYP+1PSO7m+2tneaIbigNIk35fP7qsW+05Hm3eN0cBMl7dUgwOKaiLUUWdvhtt
         PCJA==
X-Gm-Message-State: AOJu0YxosCTCCJD0Zv1CgFT2xRtPdYRNfbR0gx3lZDKZER/rEwqg8JEO
	EUEbzujvQD0xpuaSNz1etPNKIZdTUxuXvNhWl0ESawVbM2uioabJQ331vbWeehe4JK8ZhFmVQ6v
	rZw==
X-Google-Smtp-Source: AGHT+IH1U4Q9kPYH7jD7X3wue28RHo6quR1tW4i0OCfLWlq2VwwtJ4Wz34z03CLCwuJbGB3bvEGeKg==
X-Received: by 2002:a05:6808:1a91:b0:3c1:f46c:e71f with SMTP id bm17-20020a0568081a9100b003c1f46ce71fmr3586316oib.46.1709710827080;
        Tue, 05 Mar 2024 23:40:27 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id n30-20020a0568080a1e00b003c1973dbca6sm1317273oij.2.2024.03.05.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:40:26 -0800 (PST)
Date: Wed, 6 Mar 2024 07:40:21 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 7/9] bpf/selftests: add selftests for root/pwd
 path based BPF kfuncs
Message-ID: <1c7cdcb02209b99b92b1b006bad452c11d7ddd53.1709675979.git.mattbobrowski@google.com>
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

Add a new path_kfunc test suite that is responsible for verifiying the
operability of the newly added root/pwd path based BPF kfuncs. This
test suite covers the following BPF kfuncs:

struct path *bpf_get_task_fs_root(struct task_struct *task);
struct path *bpf_get_task_fs_pwd(struct task_struct *task);
void bpf_put_path(struct path *path);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/path_kfunc.c     |  48 ++++++++
 .../selftests/bpf/progs/path_kfunc_common.h   |  20 +++
 .../selftests/bpf/progs/path_kfunc_failure.c  | 114 ++++++++++++++++++
 .../selftests/bpf/progs/path_kfunc_success.c  |  30 +++++
 4 files changed, 212 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/path_kfunc.c b/tools/testing/selftests/bpf/prog_tests/path_kfunc.c
new file mode 100644
index 000000000000..9a8701a7999c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/path_kfunc.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+
+#include "path_kfunc_failure.skel.h"
+#include "path_kfunc_success.skel.h"
+
+static void run_test(const char *prog_name)
+{
+	struct bpf_link *link;
+	struct bpf_program *prog;
+	struct path_kfunc_success *skel;
+
+	skel = path_kfunc_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "path_kfunc_success__open_and_load"))
+		return;
+
+	link = NULL;
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	ASSERT_OK_PTR(link, "bpf_program__attach");
+cleanup:
+	bpf_link__destroy(link);
+	path_kfunc_success__destroy(skel);
+}
+
+static const char * const success_tests[] = {
+	"get_task_fs_root_and_put_from_current",
+	"get_task_fs_pwd_and_put_from_current",
+};
+
+void test_path_kfunc(void)
+{
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(success_tests); i++) {
+		if (!test__start_subtest(success_tests[i]))
+			continue;
+		run_test(success_tests[i]);
+	}
+
+	RUN_TESTS(path_kfunc_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/path_kfunc_common.h b/tools/testing/selftests/bpf/progs/path_kfunc_common.h
new file mode 100644
index 000000000000..837dc03c136d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_kfunc_common.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#ifndef _PATH_KFUNC_COMMON_H
+#define _PATH_KFUNC_COMMON_H
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct path *bpf_get_task_fs_root(struct task_struct *task) __ksym;
+struct path *bpf_get_task_fs_pwd(struct task_struct *task) __ksym;
+void bpf_put_path(struct path *path) __ksym;
+
+#endif /* _PATH_KFUNC_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/path_kfunc_failure.c b/tools/testing/selftests/bpf/progs/path_kfunc_failure.c
new file mode 100644
index 000000000000..a28797e245e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_kfunc_failure.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "path_kfunc_common.h"
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(get_task_fs_root_kfunc_null)
+{
+	struct path *acquired;
+
+	/* Can't pass a NULL pointer to bpf_get_task_fs_root(). */
+	acquired = bpf_get_task_fs_root(NULL);
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(get_task_fs_pwd_kfunc_null)
+{
+	struct path *acquired;
+
+	/* Can't pass a NULL pointer to bpf_get_task_fs_pwd(). */
+	acquired = bpf_get_task_fs_pwd(NULL);
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(get_task_fs_root_kfunc_untrusted, struct task_struct *task)
+{
+	struct path *acquired;
+	struct task_struct *parent;
+
+	/* Walking the struct task_struct will yield an untrusted pointer. */
+	parent = task->parent;
+	if (!parent)
+		return 0;
+
+	acquired = bpf_get_task_fs_root(parent);
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(get_task_fs_pwd_kfunc_untrusted, struct task_struct *task)
+{
+	struct path *acquired;
+	struct task_struct *parent;
+
+	/* Walking the struct task_struct will yield an untrusted pointer. */
+	parent = task->parent;
+	if (!parent)
+		return 0;
+
+	acquired = bpf_get_task_fs_pwd(parent);
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(get_task_fs_root_kfunc_unreleased)
+{
+	struct path *acquired;
+
+	acquired = bpf_get_task_fs_root(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	__sink(acquired);
+
+	/* Acquired but never released. */
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(get_task_fs_pwd_kfunc_unreleased)
+{
+	struct path *acquired;
+
+	acquired = bpf_get_task_fs_pwd(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	__sink(acquired);
+
+	/* Acquired but never released. */
+	return 0;
+}
+
+SEC("lsm.s/inode_getattr")
+__failure __msg("release kernel function bpf_put_path expects refcounted PTR_TO_BTF_ID")
+int BPF_PROG(put_path_kfunc_unacquired, struct path *path)
+{
+	/* Can't release an unacquired pointer. */
+	bpf_put_path(path);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/path_kfunc_success.c b/tools/testing/selftests/bpf/progs/path_kfunc_success.c
new file mode 100644
index 000000000000..8fc8e3c51405
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_kfunc_success.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "path_kfunc_common.h"
+
+SEC("lsm.s/file_open")
+int BPF_PROG(get_task_fs_root_and_put_from_current)
+{
+	struct path *acquired;
+
+	acquired = bpf_get_task_fs_root(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+int BPF_PROG(get_task_fs_pwd_and_put_from_current)
+{
+	struct path *acquired;
+
+	acquired = bpf_get_task_fs_pwd(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
-- 
2.44.0.278.ge034bb2e1d-goog

/M
