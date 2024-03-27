Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139F74BE8
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540815; cv=none; b=Lm6dHAqHiGVDpPZcxt2VKDEPShzeRliy8gKCDKK9BxrhLS1gtvQ05SDG84zmkxo51c1ZOY8Ls4246kNOd/TSTPzZ9Memkt56yCOLfiWhBEdm6H0UI1p1kg33vTL+ck942y6VGxSN8A5Fa1qbJW8coLmn4+7+ISaOik8Dhd9j1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540815; c=relaxed/simple;
	bh=yLjW5rCXwB7sRVJivKLXR9ozM8e318MFwzeHOiPmlCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIgRUMVCP8a9C83i+1BOzQHBAWCPXH+eXWeGJkbVsgWATxozwB3t4qVAPZSIuw2+i3E39Z6yC0WACiacC1cRdooR6E1ejBj+aDDNok39jHpttasRUEyhPaCfoaB5bXfBI7lkeAIhaVR29HXAYo+RrcLRfUWGGYTjpYm0r+oZKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3XLi1cM; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3XLi1cM"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-221a9e5484aso4011622fac.0
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711540813; x=1712145613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9QJQrBqCWHPJ3fd8MBbTx/85A6Ik1GzdbQ8sHqi6oY=;
        b=g3XLi1cMq1GwL02Tru57+RWAXaZ9FSrZ/E4HeRYWJjXNwTiaUwD1Ei7QA1WwK7PUJk
         kvTvuvNVfl/uhN4uQVgvOeM11HsMYCo/1PjTr03m2DwT87LWilu5GLxK6XMqIWk5hBB8
         /DPK+Opa3vQPMwZMdvbG0APlGUDqlJrcqlPJHC9PGuVRxyExdWkRMixFwov66y87excJ
         rTsl/i1NhW5TU1PN7dgLD9nQO7RezObKYPgXl0z+4aFVNRTLL+Z+9WpS1LalfRiPFs8l
         O6ez8sjuR0uO8L0KnG+QR00vnSB2cHbPPrW9Mo/IDVoML9moaDFm9oXSxl59ij4vr+ot
         gzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540813; x=1712145613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9QJQrBqCWHPJ3fd8MBbTx/85A6Ik1GzdbQ8sHqi6oY=;
        b=mQ8paj89umz02fPwf7Nuxml0k+QFWRVJPYRa6fQZRss4hMabdG3I3JeQwz8j+PHcgq
         Na5zYWDoSevvF5T3qRK6RHo+5mOBrJANRpPrPGpouq+4uPkSjbYNSZ8W2J4T+9FyeYmK
         4l3/8S7pUnJiBiGSgfxp2yuvyPYmUZotKFyTvIknKLGfIuAOg5l0xXGWBL1/QsmgBFDL
         xMh4Z20mLePQKy5G2QUku4sNCd0JZQB96qzsOqxQZ0mGeuWZLpgWZDhvJn8uBrKF2z6A
         Z7NqtUyygkodAsnNC+MPGzLo6oM7Ij7pmth8ATTqyxQzSW771Vl5CicKfIOa8jhKdGkx
         s8pg==
X-Gm-Message-State: AOJu0Yxb7R74xfHg5CHGMfMYFO5fsFec11aOQTDFBpUlJn7cIrWYu8qZ
	9ocjw1EgTC90Q0xVBlNfokDvkHt45rQdnRhjFdzSPaWJIYotuyVywugXKNeF/h+FLw==
X-Google-Smtp-Source: AGHT+IGXwhdDBiuceakeQS//Ag8vD1mUNDWJ/BcjqB5QP5BC1jRxjCp155v5cFZGkLdlvO9ThR9QeA==
X-Received: by 2002:a05:6870:96ac:b0:22a:828b:57ea with SMTP id o44-20020a05687096ac00b0022a828b57eamr1645273oaq.53.1711540812892;
        Wed, 27 Mar 2024 05:00:12 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.203])
        by smtp.gmail.com with ESMTPSA id fa26-20020a056a002d1a00b006ea7b343877sm7675695pfb.9.2024.03.27.04.59.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2024 05:00:12 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add selftest for bits iter
Date: Wed, 27 Mar 2024 19:58:48 +0800
Message-Id: <20240327115848.84695-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240327115848.84695-1-laoar.shao@gmail.com>
References: <20240327115848.84695-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the newly added bits iter.
- bits_iter_success
  - percpu data extracted from the percpu struct should be expected
  - RCU lock is not required
  - It is fine without calling bpf_iter_cpumask_next()
  - It can work as expected when invalid arguments are passed

- bits_iter_failure
  - bpf_iter_bits_destroy() is required after calling
    bpf_iter_bits_new()
  - bpf_iter_bits_destroy() can only destroy an initialized iter
  - bpf_iter_bits_next() must use an initialized iter

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/bits_iter.c      | 139 +++++++++++++++++
 .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
 .../bpf/progs/test_bits_iter_success.c        | 146 ++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bits_iter.c b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
new file mode 100644
index 000000000000..0e2520a9dc62
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <test_progs.h>
+#include "test_bits_iter_success.skel.h"
+#include "test_bits_iter_failure.skel.h"
+#include "cgroup_helpers.h"
+
+static const char * const positive_testcases[] = {
+	"cpumask_memalloc",
+	"cpumask_copy",
+};
+
+static const char * const negative_testcases[] = {
+	"null_pointer",
+	"zero_bit",
+	"no_mem",
+	"invalid_bits",
+};
+
+static int read_percpu_data(struct bpf_link *link)
+{
+	int iter_fd, len;
+	char buf[128];
+	size_t left;
+	char *p;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
+		return -1;
+
+	memset(buf, 0, sizeof(buf));
+	left = ARRAY_SIZE(buf);
+	p = buf;
+	while ((len = read(iter_fd, p, left)) > 0) {
+		p += len;
+		left -= len;
+	}
+
+	close(iter_fd);
+	return 0;
+}
+
+static void verify_iter_success(const char *prog_name, bool negative)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct test_bits_iter_success *skel;
+	union bpf_iter_link_info linfo;
+	int cgrp_fd, err, i, nr_cpus;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	cpu_set_t set;
+
+	if (setup_cgroup_environment())
+		return;
+
+	/* Utilize the cgroup iter */
+	cgrp_fd = get_root_cgroup();
+	if (!ASSERT_GE(cgrp_fd, 0, "create_cgrp"))
+		goto cleanup;
+
+	skel = test_bits_iter_success__open();
+	if (!ASSERT_OK_PTR(skel, "cpumask_iter_success__open"))
+		goto close_fd;
+
+	skel->bss->pid = getpid();
+	nr_cpus = libbpf_num_possible_cpus();
+	skel->bss->total_nr_cpus = nr_cpus;
+
+	err = test_bits_iter_success__load(skel);
+	if (!ASSERT_OK(err, "cpumask_iter_success__load"))
+		goto destroy;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto destroy;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = cgrp_fd;
+	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(prog, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto destroy;
+
+	if (negative)
+		goto negative;
+
+	CPU_ZERO(&set);
+	/* To guarantee the success of "cpumask_copy" at all times */
+	if (nr_cpus > 16)
+		nr_cpus = 16;
+	for (i = 0; i < nr_cpus; i++)
+		CPU_SET(i, &set);
+	err = sched_setaffinity(skel->bss->pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity_all_cpus"))
+		goto free_link;
+	err = read_percpu_data(link);
+	if (!ASSERT_OK(err, "read_percpu_data"))
+		goto free_link;
+
+negative:
+	ASSERT_OK(skel->bss->err, "task_running");
+
+free_link:
+	bpf_link__destroy(link);
+destroy:
+	test_bits_iter_success__destroy(skel);
+close_fd:
+	close(cgrp_fd);
+cleanup:
+	cleanup_cgroup_environment();
+}
+
+void test_bits_iter(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(positive_testcases); i++) {
+		if (!test__start_subtest(positive_testcases[i]))
+			continue;
+
+		verify_iter_success(positive_testcases[i], false);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(negative_testcases); i++) {
+		if (!test__start_subtest(negative_testcases[i]))
+			continue;
+
+		verify_iter_success(negative_testcases[i], true);
+	}
+
+	RUN_TESTS(test_bits_iter_success);
+	RUN_TESTS(test_bits_iter_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c b/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
new file mode 100644
index 000000000000..974d0b7a540e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,
+		      u32 nr_bits) __ksym __weak;
+int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
+void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
+
+SEC("iter.s/cgroup")
+__failure __msg("Unreleased reference id=3 alloc_insn=10")
+int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
+
+	bpf_iter_bits_next(&it);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits *it = NULL;
+
+	bpf_iter_bits_next(it);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it = {};
+
+	bpf_iter_bits_destroy(&it);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_bits_iter_success.c b/tools/testing/selftests/bpf/progs/test_bits_iter_success.c
new file mode 100644
index 000000000000..67f4e810e1d2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bits_iter_success.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <linux/const.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern const struct rq runqueues __ksym __weak;
+
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,
+		      u32 nr_bits) __ksym __weak;
+int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
+void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
+
+int pid, err, total_nr_cpus;
+
+static int cpumask_iter(struct bpf_iter_meta *meta, struct cgroup *cgrp, u32 nr_cpus)
+{
+	struct task_struct *p;
+	u32 nr_running = 0;
+	struct rq *rq;
+	int *cpu;
+
+	/* epilogue */
+	if (!cgrp)
+		return 0;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	bpf_for_each(bits, cpu, p->cpus_ptr, nr_cpus) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		/* Every valid CPU should possess a runqueue, even in the event of being offline */
+		if (!rq)
+			break;
+		nr_running += rq->nr_running;
+	}
+	if (nr_running == 0)
+		err = 1;
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(cpumask_memalloc, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	return cpumask_iter(meta, cgrp, 128);
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(cpumask_copy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	return cpumask_iter(meta, cgrp, 16);
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(null_pointer, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	int *cpu;
+
+	bpf_for_each(bits, cpu, NULL, 8192)
+		err++;
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(zero_bit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+	int *cpu;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	bpf_for_each(bits, cpu, p->cpus_ptr, 0)
+		err++;
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(no_mem, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+	int *cpu;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	/* The max number of memalloc is 4096, thus it will fail to allocate (8192 * 8) */
+	bpf_for_each(bits, cpu, p->cpus_ptr, 8192 * 8)
+		err++;
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(no_next, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
+
+	/* It functions properly without invoking bpf_iter_bits_next(). */
+
+	bpf_iter_bits_destroy(&it);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(invalid_bits, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct task_struct *p;
+	struct rq *rq;
+	int *cpu;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return 1;
+
+	bpf_for_each(bits, cpu, p->cpus_ptr, 8192) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		/* For invalid CPU IDs, the rq must be NULL. */
+		if (!rq)
+			err++;
+	}
+	bpf_task_release(p);
+
+	if (err)
+		err -= 8192 - total_nr_cpus;
+	return 0;
+}
-- 
2.39.1

