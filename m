Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500254;
	b=mjwdMkPSQdIVbLzue56KpxbUltNV+UnIrYM0+T1sRx9dFoT7RQhJPXNUECHBh1jDyLcX
	 qOoYFIexhy67PJ0V8BSEBxbgrM6N291TBQX2uBUEqo4ivdzBQiZSquDveUFdNGo+XlkGS
	 lHtCZh9mCoPHutJ8ac4ejL+KeTpqtVPA53ncZcDsOpwbgoShXkfr5URv4L/4XD+WHi6or
	 y/YLGf4T+mtqxGlUAT9sRywCi8HSdcqMCs6RYZsmtiXPOCdFStymM+GCJZfRHTX32BV+0
	 DivCHTm6yfF0CMJ7rZLFOwHmoanCYDu7UXAtexku0UY8TdskGqDWmGP0ZFctx40fmzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5uvEeiKQpUi54322GkL0DRQXIw/UgaPZxmiBwn6Fy2w=;
	b=J3TZ5ouJFy00IIwz7mhIvD/ALfRtSfxlFTPDUP/pUuZrpjwdvsHJahCxPvP/XeQPGaeq
	 rezh1bNPEp7f/zawcO/n0fYo5nQWnBVGXeqDlwJFD8GMqjtv9Xi/DXnZBJf5QQTF+19nP
	 XUwf4gfMddcztQEU4wBv+jVY8n5/q5PULfHAoyTLPtTkLakvUwsG5RiyfVw0KGJMnJKvg
	 E1nnvdMmN0R/zwM9u0gJF8NUb7zqA1rwNROvabd3Ie7VKwkfWpaXko5G5KNo5jlg6vOT9
	 kN1jdoJufKc2pSqXwwoS/VvjKE31Uq1FRqCXiooxiO246//hc4fZ4U/YLClw7/wfovA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=puGJMCQk;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8E606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC8E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=puGJMCQk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f06ff94acfso13972505ad.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1795500254; x=1796105054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5uvEeiKQpUi54322GkL0DRQXIw/UgaPZxmiBwn6Fy2w=;
        b=puGJMCQkakB6uP6QX/7kBtClwLOEdSbdczNygroFQCDjDQ81ypDcTaPB/O1OMDdM1F
         /ADz/7i5SgJhAJE1t3K4ezbw6Cbz71QhpjmtwMmaEUbKi4jjm9cxmkYPbNi9YQAjKl/E
         oL0Gd+k2++a+L+N671wPO6nBZ3duLcqwfiGOxkDBwYTMlC+4RYhPUpPWah7SPHeAuxjn
         9bbWE11nCFW6e93OCdS2bUWtsYM3XtkIBxnnDdd9S90uKUBqU8qTvCy/EMNLGy+K7m71
         Z0jOr14quhztJJd18Z8XfB1HmPKQ6+uUHNXpjXw/rHq2I+IBPUsMfkmx6GJCBdwB920j
         5GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500254; x=1796105054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5uvEeiKQpUi54322GkL0DRQXIw/UgaPZxmiBwn6Fy2w=;
        b=SLuO/Lta7KI6kdvnVaHgD2TfJbRZyiTXnD/YOaaYhCdAIAK8EJqbDXgX108kfYO3qJ
         sF2Bkq07zDRJV7TnHqqUC9mn5B2DaR1tlaQ2EkZWwS+Eca0QwyMO9hV6+DM30muqb5uA
         5Glux2Ni6Q53OuwU9TnSSRLiq88uDFddbo6XkC8SO0qyaQwww3OGamb1IbtjLJpydLWj
         Lj7wD2/jWf1EXpelDwTiI6STOLBWS8RS3+oqY5XeTa4Z7VRZaGyKDwerEMM/VbRI50PV
         ZeKuDkvc6OE5XZWvyefIJBRtA5MEnjmP/X9a3OkUJ5B+oa2TAsl3+37jfQvL/7b7k5fn
         9DLg==
X-Gm-Message-State: APuU4Z/0oEInOI+P8Coebkd3whrApXeB5DSKcu73YMim6CaBm8Ieaejm
	7ZiMgd+aBgVs1FtNYI6bOOQiYg8Faqvu+ChOzKXs6l/j7Trti7PXWoR+kafklw7sk5+LT3G7rGt
	7D4oCp9k=
X-Gm-Gg: AZFdTZctkZ1DkuB+rfAVMYjEJCSQIG785nUdARj3BJo9/wZUVEIJJv6zrzsr6caWYI4
	32SuU1fMm1hw8/Yu95oStqbrVlxYmX3OsgkAFnA+sjDR09H3PObBxk3iQ7eNZ/fnN6/FIjxpzLX
	+hAzI9VP/lcRnh8k5zhgEmbcx2kVEnNOS/bVSHWkBGUKands4v3Hn3weSegVhlJGv+UO+IiiTQg
	kbeJn27KFTDikIncrUkRA14dWhBFHVj5mdfBgnvXsnkykXTU9i7a0bdGZFrR2jic1mfFTfTRBpI
	UlcbeXW2QxCkesxlvy/WAljXZRNeTQzj8q3uPNW9usaC48EPvhCgmhwzXcMfonyC7qiMSrBd96x
	jq+reQRwfUDFVosOj8HfhfPHcX6S+gOvNRtUyzbiWyAvcOhB2hcdw3E/T+eoVUNdJSwx9ZkFuF0
	lifUAlyelEz9MRXPNOudAC1PSPlpIP/RtdF3pWl5OUjUIQTaM/1ULREbrJaLaonMuadpbgdkbgL
	2sgDvE4IztpeNwLWXvBzamMkchpMEz/gnr1tN00gkocqbVpnXK3L8NMdco8iPwW7xigl4BuZpbb
	tFoRydQdnYOWrctGD3+qFlR7yKvFq02xAxbYsQkGL+V3SE+K7pJfw4WYRxR+qO+zrd15jTait7y
	F+peCajieqDaFdVQS2ofgAfxKi8/JhhrzizqjyLOtx6drkx7W
X-Received: by 2002:a17:902:d2cf:b0:2e9:4e83:1969 with SMTP id d9443c01a7336-2f03f146b90mr130210535ad.34.1795500253764;
        Mon, 23 Nov 2026 22:04:13 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42a6sm64215985ad.23.2026.11.23.22.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:04:13 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Test kmalloc variant selection for task storage
Date: Tue, 24 Nov 2026 06:03:57 +0000
Message-ID: <20261124060357.11700-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124060357.11700-1-emil@etsalapatis.com>
References: <20261124060357.11700-1-emil@etsalapatis.com>
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

Add testing to confirm that task-storage allocations
use the right sleepable vs maylock kmalloc variant for
an allocation given the context the call is made in.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/prog_tests/task_storage_sleepable.c   |  94 +++++++++++++
 .../bpf/progs/task_storage_sleepable.c        | 126 ++++++++++++++++++
 2 files changed, 220 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_storage_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c b/tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c
new file mode 100644
index 0000000000000..fa0818f63c6bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <pthread.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "task_storage_sleepable.skel.h"
+
+static void *run_storage(void *arg)
+{
+	struct task_storage_sleepable *skel = arg;
+
+	/* A new thread has no task storage from earlier tests. */
+	skel->bss->target_pid = syscall(SYS_gettid);
+	syscall(SYS_getpgid, 0);
+	skel->bss->target_pid = 0;
+	return NULL;
+}
+
+static void test_alloc(const char *prog_name, int regular_allocs, int nonsleepable_allocs)
+{
+	struct task_storage_sleepable *skel;
+	struct bpf_link *link = NULL;
+	struct bpf_program *regular_probe, *prog;
+	pthread_t thread;
+	int err;
+
+	skel = task_storage_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	regular_probe = skel->progs.on_regular_alloc;
+	err = bpf_program__set_attach_target(regular_probe, 0, "bpf_map_kzalloc");
+	if (err == -ESRCH) {
+		printf("%s: bpf_map_kzalloc missing from kernel BTF\n", __func__);
+		err = bpf_program__set_autoload(regular_probe, false);
+	}
+	if (!ASSERT_OK(err, "configure_regular_alloc_probe"))
+		goto out;
+
+	/* Task storage uses the nolock allocator until the fallback is added. */
+	prog = skel->progs.on_nonsleepable_alloc;
+	err = bpf_program__set_attach_target(prog, 0, "bpf_map_kmalloc_maylock");
+	if (err == -ESRCH)
+		err = bpf_program__set_attach_target(prog, 0, "bpf_map_kmalloc_nolock");
+	if (!ASSERT_OK(err, "set_nonsleepable_alloc_target"))
+		goto out;
+
+	err = task_storage_sleepable__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto out;
+
+	if (bpf_program__autoload(regular_probe)) {
+		skel->links.on_regular_alloc = bpf_program__attach(regular_probe);
+		if (!ASSERT_OK_PTR(skel->links.on_regular_alloc, "attach_regular_alloc"))
+			goto out;
+	}
+	skel->links.on_nonsleepable_alloc = bpf_program__attach(skel->progs.on_nonsleepable_alloc);
+	if (!ASSERT_OK_PTR(skel->links.on_nonsleepable_alloc, "attach_nonsleepable_alloc"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "find_program"))
+		goto out;
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "attach_program"))
+		goto out;
+
+	err = pthread_create(&thread, NULL, run_storage, skel);
+	if (!ASSERT_OK(err, "pthread_create"))
+		goto out;
+	err = pthread_join(thread, NULL);
+	ASSERT_OK(err, "pthread_join");
+	ASSERT_EQ(skel->bss->errors, 0, "storage_errors");
+	if (skel->links.on_regular_alloc)
+		ASSERT_EQ(skel->bss->regular_allocs, regular_allocs, "regular_allocs");
+	ASSERT_EQ(skel->bss->nonsleepable_allocs, nonsleepable_allocs, "nonsleepable_allocs");
+out:
+	bpf_link__destroy(link);
+	task_storage_sleepable__destroy(skel);
+}
+
+void test_task_storage_sleepable(void)
+{
+	if (test__start_subtest("sleepable"))
+		test_alloc("sleepable", 3, 0);
+	if (test__start_subtest("non_sleepable"))
+		test_alloc("non_sleepable", 0, 3);
+	if (test__start_subtest("sleepable_rcu"))
+		test_alloc("sleepable_rcu", 0, 3);
+	if (test__start_subtest("mixed_contexts"))
+		test_alloc("mixed_contexts", 2, 2);
+}
diff --git a/tools/testing/selftests/bpf/progs/task_storage_sleepable.c b/tools/testing/selftests/bpf/progs/task_storage_sleepable.c
new file mode 100644
index 0000000000000..f9851c5718916
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_storage_sleepable.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_a SEC(".maps"), map_b SEC(".maps");
+
+int target_pid;
+int errors;
+int regular_allocs;
+int nonsleepable_allocs;
+
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+static bool is_target(void)
+{
+	return target_pid && (__u32)bpf_get_current_pid_tgid() == target_pid;
+}
+
+SEC("fentry/bpf_map_kzalloc")
+int BPF_PROG(on_regular_alloc, struct bpf_map *map)
+{
+	if (is_target() && map->map_type == BPF_MAP_TYPE_TASK_STORAGE)
+		regular_allocs++;
+	return 0;
+}
+
+SEC("fentry")
+int BPF_PROG(on_nonsleepable_alloc, struct bpf_map *map)
+{
+	if (is_target() && map->map_type == BPF_MAP_TYPE_TASK_STORAGE)
+		nonsleepable_allocs++;
+	return 0;
+}
+
+static __always_inline void create_storage(void)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	long initial = 123, *value, *again;
+
+	/* The first map allocates both the element and the storage container. */
+	value = bpf_task_storage_get(&map_a, task, &initial,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value || *value != initial)
+		errors++;
+
+	again = bpf_task_storage_get(&map_a, task, NULL, 0);
+	if (!again || again != value)
+		errors++;
+
+	/* The second map allocates an element in the existing container. */
+	value = bpf_task_storage_get(&map_b, task, NULL,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value || *value)
+		errors++;
+
+	if (bpf_task_storage_get(&map_a, task, NULL, 1ULL << 63))
+		errors++;
+	if (bpf_task_storage_delete(&map_a, task))
+		errors++;
+	if (bpf_task_storage_delete(&map_b, task))
+		errors++;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int sleepable(void *ctx)
+{
+	if (is_target())
+		create_storage();
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int non_sleepable(void *ctx)
+{
+	if (is_target())
+		create_storage();
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int sleepable_rcu(void *ctx)
+{
+	if (!is_target())
+		return 0;
+	bpf_rcu_read_lock();
+	create_storage();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+static __noinline void shared_storage(void)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	long *value;
+
+	value = bpf_task_storage_get(&map_a, task, NULL,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value || *value)
+		errors++;
+	if (bpf_task_storage_delete(&map_a, task))
+		errors++;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int mixed_contexts(void *ctx)
+{
+	if (!is_target())
+		return 0;
+	shared_storage();
+	bpf_rcu_read_lock();
+	shared_storage();
+	bpf_rcu_read_unlock();
+	return 0;
+}
-- 
2.52.1

