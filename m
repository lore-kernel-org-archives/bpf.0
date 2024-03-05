Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085021EA6F
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621053; cv=none; b=dsDD9Ko08AP2Lqk9bW6jnNGOgW+f6tw9gK3YqFSv0yuYUycY7JNlAJCRm1UuytBlqrOBOmUl2HNrcASSfxV+uM1yZ6PTIR7/Krm167yJ+vBURZsiNh+ccnz/FlCRf9bBYqJhTlBGVYJdbZeYKTGU83da4TOuKTpuH8tOkHdOWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621053; c=relaxed/simple;
	bh=2ZkgGcqwIJgKudIKhvY2dg+3OfK9dMOeN0Scc2VOwgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWMcl8vOyky5qq+WOCsYdcozaH8RrtRWxMIFGjwdYH9AFOjX8nYpk5ddMLscbJoaayYecbOttM2MKyq+23Obep/L15woEv/Ear8p3W4Z5hkt/Qg+slhPMEO2cXNH3WmdwNiI74e/2Z5jLRkeFKJ6GSZHF+rB++SpXt8/LqC/rAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/OZAhRl; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/OZAhRl"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c1a2f7e1d2so3013079b6e.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 22:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709621051; x=1710225851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhWCQLvNX/WDOpuHateipLaz7F1iVqsaFY5KACk/SZU=;
        b=f/OZAhRly6xNaxMDkvyrabqdj2sBNasVKUljrqRy2S9Bc9cGsKzjKjjHZKYOaKO/BW
         ydOT4LLRxcTQr+lDY7TRztpF4RwL+0Yd3YmdrlYOarJ10jquaV9ic9ljvHbsrYvwl0Xa
         W9fkqEYWt5RLeyfFaBGiqW8Gm7NhLgEurk+k0sSxpmMBb/CUsywG1g+579hcezVuZn53
         yLxvyBgHkAbmrAovaftm+OnmzYfR1ohgYINv2QKdCU3R7H43Mo7WmzptnohkwLR/m2hT
         0cyTO0JQHYKvlMmTnaVufhV45k85BJLFDSQTZ1p0JOCQD2FfBqF5tBchm4Z74LvBF7w7
         G5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709621051; x=1710225851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhWCQLvNX/WDOpuHateipLaz7F1iVqsaFY5KACk/SZU=;
        b=JoqFsYSpVjW4wKywfCsq8bWnf2tinZO7VR40BEAJ/0PuGK1d9qjHJPsYvQteoD/Dxc
         TF4MXFKiBUGrbv4w9UBNwD4V5yLCcNcNvT5sPzKXpyRDf+mvoLii8dsqaUBtLl2Mydn2
         ajXRrt3v/Cv1z9WVXDS54eaXKnRqfoWi8LfvI0eeQAiRCIj0VDOjVIo6pTw9whPFaA5c
         kRo8/c3Mymgpmo5IgKZXU91TfsZeVgOSQZ0VhPNsKMXGOBP9DRDRomr/5Wjm97K5QLcD
         DI0KRvo4ysXFxsjNcn0X2kUAEZgnz7ZTDYDDoxC0H2yUv0VBtRUR+suRU+1veO/6E0OO
         rjBA==
X-Gm-Message-State: AOJu0YzN/Ukv6onVGnwayOI1uIi8xOUy/pWQmEq6egIjXPEg4B2ipKHu
	5fU7Qnd9QQKkzs0RGLRdRUi18QgQMdWLu0GN3Bo3YD9dG2jQQW4J5FFIZUlihxVyjg==
X-Google-Smtp-Source: AGHT+IGmRCfx3ep362enrspTPx0PkrCc/NNJy55rZ9Jv4pDnIaAsgUfdJ5mNgnq2nRcCWZ+zCfAZag==
X-Received: by 2002:aca:1717:0:b0:3c1:c36e:9ec9 with SMTP id j23-20020aca1717000000b003c1c36e9ec9mr995277oii.17.1709621051150;
        Mon, 04 Mar 2024 22:44:11 -0800 (PST)
Received: from localhost.localdomain ([39.144.105.163])
        by smtp.gmail.com with ESMTPSA id j36-20020a63fc24000000b0059b2316be86sm8345831pgi.46.2024.03.04.22.44.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2024 22:44:10 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
Date: Tue,  5 Mar 2024 14:43:53 +0800
Message-Id: <20240305064353.69734-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240305064353.69734-1-laoar.shao@gmail.com>
References: <20240305064353.69734-1-laoar.shao@gmail.com>
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

This test case can't work correctly on s390x for unknonw reason, thus it
is added to DENYLIST.s390x.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   3 +-
 .../selftests/bpf/prog_tests/bits_iter.c      | 137 ++++++++++++++++++
 .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
 .../bpf/progs/test_bits_iter_success.c        | 122 ++++++++++++++++
 4 files changed, 315 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_success.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 1a63996c0304..0cd6d2bf1ff4 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,5 +1,6 @@
 # TEMPORARY
 # Alphabetical order
-exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
+bits_iter                                # cpumask iter can't work as expected                                         (?)
+exceptions                               # JIT does not support calling kfunc bpf_throw                                (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
diff --git a/tools/testing/selftests/bpf/prog_tests/bits_iter.c b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
new file mode 100644
index 000000000000..ff4f921c91c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
@@ -0,0 +1,137 @@
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
+	nr_cpus = libbpf_num_possible_cpus();
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
+	ASSERT_OK(skel->bss->err, "not_zero");
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
index 000000000000..77081204dec3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bits_iter_success.c
@@ -0,0 +1,122 @@
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
+int pid, err;
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
-- 
2.39.1

