Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158957;
	b=AQpd4CSj2D4CnPAUNeZlODV9azXL3e2LA0SY7W090OFvV7KPha0m94B9+WAW/q4kjZ14
	 GUDFX/oMwZaBSKLttNjO6c9/7e1HEqYOkVkCsGkzm0eyZ8letGoetXIABZyEJ/6F0Yuiq
	 lkgwLTmMhDwc6DE+fSnKPs1TjbcWm96CZEFB37d3r39vpVLvyKopdqkIhg6tJM80Qd9wC
	 XpN5P2ckZr0Mc8zS8VjOs6JbSSDQjW1PHZpJmjXLHg+0lAX9Scg0TzVOeaUYnhJw/nwbW
	 qm+bXfYGbMegD/fqhMz3jYtl6lgnbK7dNGIBiTu5SsnPfnW3p4Y4mtaoT2QqapmigNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158957;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=qjn/r2tOQN0KO+WEJ4JmqGDx3OUGngjuS2AhUfso05s=;
	b=toHSzMZZ7EAfNqq2c5+AbfHwqKHIpRMrL7MrZdoEGnEBdoeU8EHdpu+tWZqPKnaaTAVZ
	 8CDzAlsM+JguAVCh0KqGaZTWp3XdDhb1f3fGebeDg7mE6VRohzbJTrKc+Ug4G4NvJSGub
	 mVteTLd5Sis+hFJozxKSgj7/sDaSvV091jv5nmDGCA/DmZiyWFM+22YUPuRwKgCdZBzLP
	 n+PfQhS+/pelh9lOTKPcCK6+6vbD2/CWQjuV62nQWcbh7V+v8Nc6nAmKwkI0KIZGlH/i5
	 SSOiLAHHeUOl4ESg24I138JLJSQPO/c38eJ9bzdkwE+7Ipkq1Em2K1f0vrb1xBinfkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A93606A332;
	Fri, 20 Nov 2026 07:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75A93606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jW66S2LGsz1rrJ2;
	Fri, 20 Nov 2026 15:14:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DE73F4056B;
	Fri, 20 Nov 2026 15:15:51 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgA3dfSm8_9qDM9HFA--.40246S5;
	Fri, 20 Nov 2026 15:15:51 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH 3/3] selftests/bpf: Add benchmark for seccomp filter install
Date: Fri, 20 Nov 2026 06:48:52 +0000
Message-ID: <23962b56d36f05c2176053d772cc9739e2e48ba5.1795139109.git.xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795139109.git.xukuohai@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA3dfSm8_9qDM9HFA--.40246S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr43Jr13Jr1kAF4DCw4DArb_yoWfZr4fpF
	Z3Cw15Jr48XF4Ygwn5J3y7AFWfCrs3W3y5Xr1rG342vr47Jr98Ka1IqrW7CFnxArWDtw15
	ursFvayj9rs8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UA
	CztUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add a benchmark to measure the cost of installing seccomp filter. Each
producer spawns one worker thread per burst. The worker installs a
batch of filters and exits. The benchmark reports the number of filters
installed per second.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../bpf/benchs/bench_seccomp_install.c        | 249 ++++++++++++++++++
 2 files changed, 253 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_seccomp_install.c

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index fbbd55399019..b8f81868edc9 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -289,6 +289,7 @@ extern struct argp bench_sockmap_argp;
 extern struct argp bench_lpm_trie_map_argp;
 extern struct argp bench_xdp_lb_argp;
 extern struct argp bench_libarena_argp;
+extern struct argp bench_seccomp_install_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -308,6 +309,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_lpm_trie_map_argp, 0, "LPM trie map benchmark", 0 },
 	{ &bench_xdp_lb_argp, 0, "XDP load-balancer benchmark", 0 },
 	{ &bench_libarena_argp, 0, "libarena allocator benchmark", 0 },
+	{ &bench_seccomp_install_argp, 0, "seccomp install benchmark", 0 },
 	{},
 };
 
@@ -578,6 +580,7 @@ extern const struct bench bench_rhtab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
 extern const struct bench bench_sockmap;
+extern const struct bench bench_seccomp_install;
 extern const struct bench bench_lpm_trie_noop;
 extern const struct bench bench_lpm_trie_baseline;
 extern const struct bench bench_lpm_trie_lookup;
@@ -666,6 +669,7 @@ static const struct bench *benchs[] = {
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
 	&bench_sockmap,
+	&bench_seccomp_install,
 	&bench_lpm_trie_noop,
 	&bench_lpm_trie_baseline,
 	&bench_lpm_trie_lookup,
diff --git a/tools/testing/selftests/bpf/benchs/bench_seccomp_install.c b/tools/testing/selftests/bpf/benchs/bench_seccomp_install.c
new file mode 100644
index 000000000000..5044d786bdf4
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_seccomp_install.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+
+/*
+ * seccomp-install benchmark: measures the cost of installing seccomp filters
+ *
+ * Every producer spawns one worker thread per burst. The worker installs a batch of filters,
+ * then exits. The throughput is collected from the completed worker batches.
+ *
+ * Options:
+ *
+ *   --sync-mode yes  Every worker waits until all workers of the burst are created, then all
+ *                    of them start installing at the same time. This models many tasks
+ *                    installing filters at once.
+ *
+ *   --sync-mode no   Each worker starts installing right away when it is created. This models
+ *                    sequential installs.
+ *
+ *   --filter-len N   Number of instructions per filter, valid range is 4..4096, default is 128
+ *
+ *   --same-filter    Whether to install the same filter every time, yes or no, default yes. No
+ *                    installs a unique filter every time.
+ *
+ *   --batch N        Install N filters per batch, default 8
+ */
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+#include <argp.h>
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include "bench.h"
+
+/* per-task budget employed by kernel, a bigger batch fails the install */
+#define SECCOMP_MAX_INSNS_PER_PATH	32768
+
+static struct {
+	struct counter hits;
+	struct counter drops;
+	pthread_barrier_t barrier;
+	bool sync;
+	bool distinct;
+	unsigned int filter_len;
+	unsigned int batch;
+	/* unique filter id, its own cacheline, all workers bump it */
+	unsigned int uniq __attribute__((aligned(128)));
+} ctx;
+
+static struct {
+	unsigned int filter_len;
+	unsigned int batch;
+	unsigned int mode;
+	unsigned int same_filter;
+} args = {
+	.filter_len = 128,
+	.batch = 8,
+	.mode = 1, /* sync */
+	.same_filter = 1,
+};
+
+enum {
+	ARG_SYNC_MODE = 12500,
+	ARG_FILTER_LEN,
+	ARG_BATCH,
+	ARG_SAME_FILTER,
+};
+
+static const struct argp_option opts[] = {
+	{ "sync-mode", ARG_SYNC_MODE, "SYNC_MODE", 0,
+	  "Start every burst of workers at the same time: yes|no (default yes)" },
+	{ "filter-len", ARG_FILTER_LEN, "FILTER_LEN", 0,
+	  "Number of instructions per filter, within 4..4096 (default 128)" },
+	{ "batch", ARG_BATCH, "BATCH", 0, "Filters installed per batch (default 8)" },
+	{ "same-filter", ARG_SAME_FILTER, "SAME_FILTER", 0,
+	  "Install the same filter every time or a unique one: yes|no (default yes)" },
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_SYNC_MODE:
+		if (strcmp(arg, "yes") && strcmp(arg, "no")) {
+			fprintf(stderr, "sync-mode must be yes or no\n");
+			argp_usage(state);
+		}
+		args.mode = !strcmp(arg, "yes");
+		break;
+	case ARG_FILTER_LEN:
+		args.filter_len = strtoul(arg, NULL, 10);
+		if (args.filter_len < 4 || args.filter_len > BPF_MAXINSNS) {
+			fprintf(stderr, "filter-len must be within 4..%d\n", BPF_MAXINSNS);
+			argp_usage(state);
+		}
+		break;
+	case ARG_BATCH:
+		args.batch = strtoul(arg, NULL, 10);
+		if (!args.batch) {
+			fprintf(stderr, "batch must be positive\n");
+			argp_usage(state);
+		}
+		break;
+	case ARG_SAME_FILTER:
+		if (strcmp(arg, "yes") && strcmp(arg, "no")) {
+			fprintf(stderr, "same-filter must be yes or no\n");
+			argp_usage(state);
+		}
+		args.same_filter = !strcmp(arg, "yes");
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+};
+
+const struct argp bench_seccomp_install_argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
+
+/*
+ * Fill a filter of len instructions:
+ *
+ *	A += 0
+ *	A += 1
+ *	...
+ *	A += len - 3
+ *	A += uniq
+ *	RET ALLOW
+ *
+ * The plain ALU body exercises the per instruction translation cost of the pipeline without any
+ * filter logic. The k field of the second to last instruction carries the uniq value, a worker
+ * installing unique filters patches it in place for every install, the rest of the image never
+ * changes.
+ */
+static void fill_filter(struct sock_filter *insns, unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < len - 2; i++)
+		insns[i] = (struct sock_filter)
+			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, i);
+	insns[i++] = (struct sock_filter)
+		BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0);
+	insns[i++] = (struct sock_filter)
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW);
+}
+
+static void *install_batch(void *arg)
+{
+	struct sock_filter *insns = arg;
+	struct sock_fprog prog = { .len = ctx.filter_len, .filter = insns };
+	sigset_t mask;
+	int i, err = 0;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGALRM);
+	pthread_sigmask(SIG_BLOCK, &mask, NULL);
+
+	if (ctx.sync)
+		pthread_barrier_wait(&ctx.barrier);
+
+	for (i = 0; i < ctx.batch; i++) {
+		if (ctx.distinct)
+			insns[ctx.filter_len - 2].k = __atomic_fetch_add(&ctx.uniq, 1, __ATOMIC_RELAXED);
+		if (syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog)) {
+			err = 1;
+			break;
+		}
+	}
+
+	return err ? (void *)1 : NULL;
+}
+
+static void *producer(void *input)
+{
+	struct sock_filter *insns;
+	pthread_t thread;
+	void *ret;
+
+	insns = malloc(ctx.filter_len * sizeof(*insns));
+	if (!insns) {
+		atomic_inc(&ctx.drops.value);
+		return NULL;
+	}
+	fill_filter(insns, ctx.filter_len);
+
+	while (true) {
+		if (pthread_create(&thread, NULL, install_batch, insns)) {
+			atomic_inc(&ctx.drops.value);
+			continue;
+		}
+		pthread_join(thread, &ret);
+		if (ret)
+			atomic_inc(&ctx.drops.value);
+		else
+			atomic_add(&ctx.hits.value, ctx.batch);
+	}
+
+	return NULL;
+}
+
+static void measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.hits.value, 0);
+	res->drops = atomic_swap(&ctx.drops.value, 0);
+}
+
+/*
+ * Installing a seccomp filter needs no_new_privs or CAP_SYS_ADMIN, set it here so the whole bench
+ * runs unprivileged.
+ */
+static void setup(void)
+{
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+		fprintf(stderr, "PR_SET_NO_NEW_PRIVS failed: %d\n", -errno);
+		exit(1);
+	}
+
+	if ((args.filter_len + 4) * args.batch > SECCOMP_MAX_INSNS_PER_PATH) {
+		fprintf(stderr, "the batch exceeds the seccomp insns budget of one task\n");
+		exit(1);
+	}
+
+	ctx.sync = args.mode;
+	ctx.distinct = !args.same_filter;
+	ctx.filter_len = args.filter_len;
+	ctx.batch = args.batch;
+
+	if (ctx.sync)
+		pthread_barrier_init(&ctx.barrier, NULL, env.producer_cnt);
+}
+
+const struct bench bench_seccomp_install = {
+	.name = "seccomp-install",
+	.argp = &bench_seccomp_install_argp,
+	.setup = setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
-- 
2.43.0

