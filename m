Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3D4BB28E
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819968; cv=none; b=cUcRu+TInHXIVwb61l7Kv3ZjSNn0jv7hxH39mqRKYazz/Q2TldNfsGjBbvrAh+m02RcS9w7tMbaBNPuThkKe4fpsW6/L/CMIgJ0QxVeiKfscvaqE631IM6cj/MpS6iCV46zADxR4eEgerm55R75bHMpwOfoqcPDLHMtd/mRRybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819968; c=relaxed/simple;
	bh=KvRZvRz3NhpBkGwqE7ktqm26nu6cQsva4SgdJGpByuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV7gKrZYSVGJ7PXMn8H5MawZB1mgg90vJxYlVwgttd4zt7h4cmIem5Jm1ack74Qin/BB6dJ23CvnBCDKID/qZbPZfvWUd7Lb7YquFPuJ8kz685vEDxsNTixlYkEmBw2c2PQhs4zJJUznldo5PkXAgqZnbAXj9l8mZWwcLcYqrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m1QCQGEj; arc=none smtp.client-ip=91.218.175.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m1QCQGEj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KvRZvRz3NhpBkGwqE7ktqm26nu6cQsva4SgdJGpByuc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819964; v=1; x=1792424764;
 b=m1QCQGEjbWdqoB4CBTtFOaGtLR6t0gKlDZH13S7iu6m+Ie/G6syucTqPTBs/o6mz9E1NYgJh
 HE3rMkoVksIGeCYub1Z1DQ7/8vXSoFVS5IvzJVBjdgKnOqbDMR/GJpAvKH2WgfYcDtmQe22Nlv6
 ttFtWIug0dsyJtZfZ5A/kFHE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e51c42e85681683;
	Mon, 12 Oct 2026 15:46:04 +0000
X-Mizu-Trace-ID: 2e51c42e85681683
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 21/21] selftests/bpf: Benchmark tracing_multi bpf progs attachment
Date: Mon, 12 Oct 2026 23:40:23 +0800
Message-ID: <20261012154024.29423-22-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an x86-64 one-shot generic benchmark comparing 1000 individual
fentry link creations with one fentry.multi link creation for the same
1000 bpf prog targets.

fentry.multi is much faster than fentry when attaching to 1000 targets
on a 16c16g QEMU VM on an AMD EPYC 9745 server.

./bench tracing-multi-attach-progs
Setting up benchmark 'tracing-multi-attach-progs'...
tracing-multi-attach-progs: prepared 1000 identical BPF program targets
tracing-multi-attach-progs: fentry created and attached 1000 programs/links in 338.171ms
tracing-multi-attach-progs: fentry.multi created one program and attached one 1000-target link in 47.345ms
tracing-multi-attach-progs: fentry.multi creation/attachment speedup is 7.14x

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/bench.c           |   5 +
 .../benchs/bench_tracing_multi_attach_progs.c | 193 ++++++++++++++++++
 .../bpf/progs/tracing_multi_attach_progs.c    |  24 +++
 4 files changed, 223 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_progs.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 80d8bbbc3084..23bed732d1bd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -625,6 +625,7 @@ $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
 $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench_bpf_for.o: $(OUTPUT)/bpf_for_bench.skel.h
 $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
+$(OUTPUT)/bench_tracing_multi_attach_progs.o: $(OUTPUT)/tracing_multi_attach_progs.skel.h
 $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_update_bench.skel.h
 $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index d5f494184f9d..c7502187e654 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -529,6 +529,9 @@ extern const struct bench bench_trig_fmodret;
 extern const struct bench bench_trig_tp;
 extern const struct bench bench_trig_rawtp;
 
+/* tracing_multi link attachment benchmark */
+extern const struct bench bench_tracing_multi_attach_progs;
+
 /* uprobe/uretprobe benchmarks */
 extern const struct bench bench_trig_uprobe_nop;
 extern const struct bench bench_trig_uretprobe_nop;
@@ -615,6 +618,8 @@ static const struct bench *benchs[] = {
 	&bench_trig_fmodret,
 	&bench_trig_tp,
 	&bench_trig_rawtp,
+	/* tracing_multi */
+	&bench_tracing_multi_attach_progs,
 	/* uprobes */
 	&bench_trig_uprobe_nop,
 	&bench_trig_uretprobe_nop,
diff --git a/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs.c b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs.c
new file mode 100644
index 000000000000..6cc6851eb488
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include "bench.h"
+#include "testing_helpers.h"
+#include "tracing_multi_attach_progs.skel.h"
+#include "bpf/libbpf_internal.h"
+
+#define TARGET_CNT 1000
+
+static struct ctx {
+	struct tracing_multi_attach_progs *targets[TARGET_CNT];
+	struct tracing_multi_attach_progs *fentries[TARGET_CNT];
+	struct tracing_multi_attach_progs *fentry_multi;
+	int target_fds[TARGET_CNT];
+	__u32 target_btf_ids[TARGET_CNT];
+	int fentry_prog_fds[TARGET_CNT];
+	int fentry_multi_prog_fd;
+} ctx;
+
+static void prepare(void)
+{
+	int err, i;
+
+	setup_libbpf();
+
+	for (i = 0; i < TARGET_CNT; i++) {
+		struct tracing_multi_attach_progs *target;
+		int btf_id, fd, obj_token_fd;
+
+		target = tracing_multi_attach_progs__open();
+		if (!target) {
+			fprintf(stderr, "failed to open target program %d\n", i);
+			exit(1);
+		}
+
+		bpf_program__set_autoload(target->progs.dummy_fentry, false);
+		bpf_program__set_autoload(target->progs.dummy_fentry_multi, false);
+		err = tracing_multi_attach_progs__load(target);
+		if (err) {
+			fprintf(stderr, "failed to load target program %d: %s\n",
+				i, strerror(-err));
+			exit(1);
+		}
+
+		fd = bpf_program__fd(target->progs.target);
+		obj_token_fd = bpf_object__token_fd(target->obj);
+		obj_token_fd = obj_token_fd < 0 ? 0 : obj_token_fd;
+		btf_id = libbpf_find_prog_btf_id("target", fd, obj_token_fd);
+		if (btf_id <= 0) {
+			fprintf(stderr, "failed to find target BTF ID: %s\n",
+				strerror(-btf_id));
+			exit(1);
+		}
+
+		ctx.targets[i] = target;
+		ctx.target_fds[i] = fd;
+		ctx.target_btf_ids[i] = btf_id;
+	}
+}
+
+static long create_and_attach_fentry(void)
+{
+	int link_fds[TARGET_CNT];
+	long start_ns, end_ns;
+	int err, i, j;
+
+	start_ns = get_time_ns();
+
+	/* An ordinary fentry program is bound to one target when it is loaded. */
+	for (i = 0; i < TARGET_CNT; i++) {
+		struct tracing_multi_attach_progs *fentry;
+
+		fentry = tracing_multi_attach_progs__open();
+		if (!fentry) {
+			fprintf(stderr, "failed to open fentry program %d\n", i);
+			exit(1);
+		}
+
+		bpf_program__set_autoload(fentry->progs.target, false);
+		bpf_program__set_autoload(fentry->progs.dummy_fentry_multi, false);
+		err = bpf_program__set_attach_target(fentry->progs.dummy_fentry, ctx.target_fds[i],
+						     "target");
+		err = err ?: tracing_multi_attach_progs__load(fentry);
+		if (err) {
+			fprintf(stderr, "failed to load fentry program %d: %s\n",
+				i, strerror(-err));
+			exit(1);
+		}
+
+		ctx.fentries[i] = fentry;
+		ctx.fentry_prog_fds[i] = bpf_program__fd(fentry->progs.dummy_fentry);
+	}
+
+	for (i = 0; i < TARGET_CNT; i++) {
+		link_fds[i] = bpf_link_create(ctx.fentry_prog_fds[i], 0, BPF_TRACE_FENTRY, NULL);
+		if (link_fds[i] < 0) {
+			err = errno;
+			for (j = 0; j < i; j++)
+				close(link_fds[j]);
+			fprintf(stderr, "failed to create fentry link %d: %s\n",
+				i, strerror(err));
+			exit(1);
+		}
+	}
+	end_ns = get_time_ns();
+
+	for (i = 0; i < TARGET_CNT; i++)
+		close(link_fds[i]);
+
+	return end_ns - start_ns;
+}
+
+static long create_and_attach_fentry_multi(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	long start_ns, end_ns;
+	int err, link_fd;
+
+	opts.tracing_multi.ids = ctx.target_btf_ids;
+	opts.tracing_multi.fds = ctx.target_fds;
+	opts.tracing_multi.cnt = TARGET_CNT;
+
+	start_ns = get_time_ns();
+
+	ctx.fentry_multi = tracing_multi_attach_progs__open();
+	if (!ctx.fentry_multi) {
+		fprintf(stderr, "failed to open fentry.multi program\n");
+		exit(1);
+	}
+
+	bpf_program__set_autoload(ctx.fentry_multi->progs.target, false);
+	bpf_program__set_autoload(ctx.fentry_multi->progs.dummy_fentry, false);
+	err = tracing_multi_attach_progs__load(ctx.fentry_multi);
+	if (err) {
+		fprintf(stderr, "failed to load fentry.multi program: %s\n",
+			strerror(-err));
+		exit(1);
+	}
+
+	ctx.fentry_multi_prog_fd = bpf_program__fd(ctx.fentry_multi->progs.dummy_fentry_multi);
+	link_fd = bpf_link_create(ctx.fentry_multi_prog_fd, 0, BPF_TRACE_FENTRY_MULTI, &opts);
+	end_ns = get_time_ns();
+	if (link_fd < 0) {
+		err = errno;
+		fprintf(stderr, "failed to create fentry.multi link: %s\n",
+			strerror(err));
+		exit(1);
+	}
+
+	close(link_fd);
+	return end_ns - start_ns;
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	tracing_multi_attach_progs__destroy(ctx.fentry_multi);
+	for (i = 0; i < TARGET_CNT; i++) {
+		tracing_multi_attach_progs__destroy(ctx.fentries[i]);
+		tracing_multi_attach_progs__destroy(ctx.targets[i]);
+	}
+}
+
+static void setup(void)
+{
+	double fentry_multi_ms, fentry_ms;
+	long fentry_multi_ns, fentry_ns;
+
+	prepare();
+	fentry_ns = create_and_attach_fentry();
+	fentry_multi_ns = create_and_attach_fentry_multi();
+	fentry_ms = fentry_ns / 1000000.0;
+	fentry_multi_ms = fentry_multi_ns / 1000000.0;
+
+	printf("%s: prepared %d identical BPF program targets\n",
+	       bench->name, TARGET_CNT);
+	printf("%s: fentry created and attached %d programs/links in %-.3lfms\n",
+	       bench->name, TARGET_CNT, fentry_ms);
+	printf("%s: fentry.multi created one program and attached one %d-target link in %-.3lfms\n",
+	       bench->name, TARGET_CNT, fentry_multi_ms);
+	printf("%s: fentry.multi creation/attachment speedup is %-.2lfx\n",
+	       bench->name, fentry_ms / fentry_multi_ms);
+
+	cleanup();
+	exit(0);
+}
+
+const struct bench bench_tracing_multi_attach_progs = {
+	.name = "tracing-multi-attach-progs",
+	.setup = setup,
+};
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_attach_progs.c b/tools/testing/selftests/bpf/progs/tracing_multi_attach_progs.c
new file mode 100644
index 000000000000..0ea4513904cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_attach_progs.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+int target(void *ctx)
+{
+	return 0;
+}
+
+SEC("fentry")
+int BPF_PROG(dummy_fentry)
+{
+	return 0;
+}
+
+SEC("fentry.multi")
+int BPF_PROG(dummy_fentry_multi)
+{
+	return 0;
+}
-- 
2.55.0

