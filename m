Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496A456E0F
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250756; cv=none; b=ccZzKpCwQqiH1l7RiHMPadyyT+082zmVKs99p9IoMFrMhHU1PEBBBDheorybwRU6XTOqIH06j2Y5G6xP+lPTRX+mVTF3v0+uAtMgkzptdFdD2rfJ+1n96C3FqF/UxhSW32/tE1iazRkXpekSDtglC6OskeWqK7tJbi1da3dhGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250756; c=relaxed/simple;
	bh=9eEn0qEJRnR/5cn70Fh6aQ7RFYTLSGZ74e1LDz7h24k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAukgGCy4H3/g6VE4RdPF+QdEvpJN0RoPe+t3hH+aZ0CzwOqxAKDgXLJ7olGKZSyJ8YVfsdIt7xg8j2PXM6WlEOSKUrdYbB/G2UnPnVjDKC7ru8Wefjvi3hKnSDPof/Zl+91ZZNfsszpO1SnTk4OFnLLGJprImlPNgHoC/Ks0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rWbPVZs3; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rWbPVZs3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785250752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgCQjppLRFp0IsBtPlXOxKWBKQJfQOiCE2ljdTP+yl0=;
	b=rWbPVZs3kX2UQRxwfJD5nrvtbPgWw/6sWNHPbxgHUL75K4TXsgDaeS5u89tMJXRWPokIkq
	8vfqTai63iYquQPO/cek7mkhu/l7uDgEQqiExIbffdOmSlTlnNLEoFh+v8bCaZGHrnUpeg
	QFmMBL0+xTprxWWr0kgseikuHYPe1UU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Rong Tao <rongtao@cestc.cn>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 6/6] selftests/bpf: Benchmark string kfuncs
Date: Tue, 28 Jul 2026 22:57:27 +0800
Message-ID: <20260728145727.45153-7-leon.hwang@linux.dev>
In-Reply-To: <20260728145727.45153-1-leon.hwang@linux.dev>
References: <20260728145727.45153-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a kfunc-only benchmark covering one representative from each string
family: bpf_strnchr(), bpf_strcmp(), bpf_strcspn(), and bpf_strnstr().

Userspace populates aligned .data buffers once per scenario, before the
timed program runs. Each BPF program reads those buffers and calls the
selected kfunc directly.

Run the programs through BPF_PROG_TEST_RUN with first, middle, late, and
terminal scenarios, and report median kernel execution times. Always run
the complete matrix with fixed repetitions, trials, and warmup settings.

Extend the generic benchmark framework with a synchronous run callback
and register the string kfunc benchmark with it. This keeps the finite
trial matrix out of the producer and consumer timing loop.

Have the runner save its first result as a temporary baseline and compare
subsequent runs against it, reporting baseline and current timings with
their speedup.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  11 +
 tools/testing/selftests/bpf/bench.h           |   2 +
 .../bpf/benchs/bench_bpf_str_kfuncs.c         | 228 ++++++++++++++++++
 .../bpf/benchs/run_bench_bpf_str_kfuncs.sh    |  98 ++++++++
 .../bpf/progs/bpf_str_kfuncs_bench.c          |  48 ++++
 6 files changed, 389 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_str_kfuncs.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_str_kfuncs.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_str_kfuncs_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55d394438705..e1e9d7ae7cb7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -977,6 +977,7 @@ $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
 $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_trie_map.skel.h
 $(OUTPUT)/bench_bpf_nop.o: $(OUTPUT)/bpf_nop_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_xdp_lb.o: $(OUTPUT)/xdp_lb_bench.skel.h bench_bpf_timing.h
+$(OUTPUT)/bench_bpf_str_kfuncs.o: $(OUTPUT)/bpf_str_kfuncs_bench.skel.h
 $(OUTPUT)/bench_bpf_timing.o: bench_bpf_timing.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
@@ -1003,6 +1004,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_timing.o \
 		 $(OUTPUT)/bench_bpf_nop.o \
 		 $(OUTPUT)/bench_xdp_lb.o \
+		 $(OUTPUT)/bench_bpf_str_kfuncs.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 3d9d2cd7764b..c355f824b8ba 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -582,6 +582,7 @@ extern const struct bench bench_lpm_trie_delete;
 extern const struct bench bench_lpm_trie_free;
 extern const struct bench bench_bpf_nop;
 extern const struct bench bench_xdp_lb;
+extern const struct bench bench_bpf_str_kfuncs;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -665,6 +666,7 @@ static const struct bench *benchs[] = {
 	&bench_lpm_trie_free,
 	&bench_bpf_nop,
 	&bench_xdp_lb,
+	&bench_bpf_str_kfuncs,
 };
 
 static void find_benchmark(void)
@@ -791,6 +793,15 @@ int main(int argc, char **argv)
 	find_benchmark();
 	parse_cmdline_args_final(argc, argv);
 
+	if (bench->run) {
+		if (bench->validate)
+			bench->validate();
+		if (bench->setup)
+			bench->setup();
+		bench->run();
+		return 0;
+	}
+
 	setup_benchmark();
 
 	setup_timer();
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 89a3fc72f70e..9351b472d5e4 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -55,6 +55,8 @@ struct bench {
 	const struct argp *argp;
 	void (*validate)(void);
 	void (*setup)(void);
+	/* Run a synchronous benchmark without producer or consumer threads. */
+	void (*run)(void);
 	void *(*producer_thread)(void *ctx);
 	void *(*consumer_thread)(void *ctx);
 	void (*measure)(struct bench_res* res);
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_str_kfuncs.c b/tools/testing/selftests/bpf/benchs/bench_bpf_str_kfuncs.c
new file mode 100644
index 000000000000..12139054bed5
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_str_kfuncs.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/utsname.h>
+
+#include "bench.h"
+#include "bpf_str_kfuncs_bench.skel.h"
+
+#define STR_BENCH_CAP		2048
+#define STR_BENCH_SCENARIOS	4
+#define STR_BENCH_REPEAT	100000
+#define STR_BENCH_TRIALS	9
+#define STR_BENCH_WARMUP	1000
+
+enum benchmark_kind {
+	BENCH_SCAN,
+	BENCH_COMPARISON,
+	BENCH_SPAN,
+	BENCH_SUBSTRING,
+	BENCH_COUNT,
+};
+
+struct scenario {
+	const char *name;
+	unsigned char payload[STR_BENCH_CAP];
+	size_t length;
+	int position;
+	__u32 want;
+};
+
+struct sample {
+	double ns_per_op;
+};
+
+struct benchmark {
+	const char *name;
+	const char *kfunc;
+	struct bpf_program *prog;
+	struct bpf_str_kfuncs_bench *skel;
+	enum benchmark_kind kind;
+};
+
+struct scenario_spec {
+	const char *name;
+	size_t length;
+	int position;
+};
+
+static const struct scenario_spec scenario_specs[STR_BENCH_SCENARIOS] = {
+	{ "first",  64,   0    },
+	{ "middle", 512,  240  },
+	{ "late",   1536, 1200 },
+	{ "absent", 2048, -1   },
+};
+
+static const char substring_needle[] = "Host: benchmark.example.com";
+static const unsigned char dummy_packet[64];
+
+static void make_scenario(enum benchmark_kind kind, struct scenario *scenario,
+			  const struct scenario_spec *spec)
+{
+	scenario->name = spec->name;
+	scenario->length = spec->length;
+	scenario->position = spec->position;
+
+	switch (kind) {
+	case BENCH_SCAN:
+		memset(scenario->payload, 'x', scenario->length);
+		if (spec->position >= 0)
+			scenario->payload[spec->position] = 'H';
+		scenario->want = spec->position < 0 ? (__u32)-ENOENT : spec->position;
+		break;
+	case BENCH_COMPARISON:
+		scenario->name = spec->position < 0 ? "equal" : spec->name;
+		memset(scenario->payload, 'a', scenario->length);
+		scenario->want = spec->position < 0 ? 0 : (__u32)-1;
+		break;
+	case BENCH_SPAN:
+		memset(scenario->payload, 'a', scenario->length);
+		if (spec->position >= 0)
+			scenario->payload[spec->position] = ':';
+		scenario->want = spec->position < 0 ? scenario->length : spec->position;
+		break;
+	case BENCH_SUBSTRING:
+		memset(scenario->payload, 'x', scenario->length);
+		if (spec->position >= 0)
+			memcpy(scenario->payload + spec->position, substring_needle,
+			       sizeof(substring_needle) - 1);
+		scenario->want = spec->position < 0 ? (__u32)-ENOENT : spec->position;
+		break;
+	case BENCH_COUNT:
+		break;
+	}
+}
+
+static void prepare_program_input(const struct benchmark *benchmark,
+				  const struct scenario *scenario)
+{
+	unsigned char *lhs = (unsigned char *)benchmark->skel->data->buffers.lhs.words;
+	unsigned char *rhs = (unsigned char *)benchmark->skel->data->buffers.rhs.words;
+
+	memcpy(lhs, scenario->payload, scenario->length);
+	lhs[scenario->length] = '\0';
+
+	if (benchmark->kind == BENCH_COMPARISON) {
+		memcpy(rhs, scenario->payload, scenario->length);
+		if (scenario->position >= 0)
+			rhs[scenario->position] = 'b';
+		rhs[scenario->length] = '\0';
+	}
+
+	benchmark->skel->data->payload_length = scenario->length;
+}
+
+static void run_program(const struct benchmark *benchmark, const struct scenario *scenario,
+			int repeat, struct sample *sample)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err;
+
+	topts.data_in = dummy_packet;
+	topts.data_size_in = sizeof(dummy_packet);
+	topts.repeat = repeat;
+	err = bpf_prog_test_run_opts(bpf_program__fd(benchmark->prog), &topts);
+	if (err || topts.retval != scenario->want) {
+		fprintf(stderr, "%s/%s failed: err=%d retval=%u want=%u\n",
+			benchmark->name, scenario->name, err, topts.retval, scenario->want);
+		exit(1);
+	}
+	if (sample)
+		sample->ns_per_op = topts.duration;
+}
+
+static int compare_samples(const void *a, const void *b)
+{
+	const struct sample *sa = a;
+	const struct sample *sb = b;
+
+	if (sa->ns_per_op < sb->ns_per_op)
+		return -1;
+	if (sa->ns_per_op > sb->ns_per_op)
+		return 1;
+	return 0;
+}
+
+static void benchmark_scenario(const struct benchmark *benchmark, const struct scenario *scenario)
+{
+	struct sample samples[STR_BENCH_TRIALS];
+	int i;
+
+	prepare_program_input(benchmark, scenario);
+	run_program(benchmark, scenario, STR_BENCH_WARMUP, NULL);
+	for (i = 0; i < STR_BENCH_TRIALS; i++)
+		run_program(benchmark, scenario, STR_BENCH_REPEAT, &samples[i]);
+
+	qsort(samples, STR_BENCH_TRIALS, sizeof(*samples), compare_samples);
+	printf("%-9s %5zu %13.1f\n", scenario->name, scenario->length,
+	       samples[STR_BENCH_TRIALS / 2].ns_per_op);
+}
+
+static void str_kfuncs_run(void)
+{
+	struct benchmark benchmarks[BENCH_COUNT];
+	struct bpf_str_kfuncs_bench *skel;
+	struct scenario scenario;
+	struct utsname uts = {};
+	int i, j;
+
+	setup_libbpf();
+	skel = bpf_str_kfuncs_bench__open_and_load();
+	if (!skel) {
+		fprintf(stderr, "Failed to load BPF skeleton\n");
+		exit(1);
+	}
+
+	benchmarks[BENCH_SCAN] = (struct benchmark) {
+		.name = "scan",
+		.kfunc = "bpf_strnchr",
+		.prog = skel->progs.scan_kfunc,
+		.skel = skel,
+		.kind = BENCH_SCAN,
+	};
+	benchmarks[BENCH_COMPARISON] = (struct benchmark) {
+		.name = "comparison",
+		.kfunc = "bpf_strcmp",
+		.prog = skel->progs.compare_kfunc,
+		.skel = skel,
+		.kind = BENCH_COMPARISON,
+	};
+	benchmarks[BENCH_SPAN] = (struct benchmark) {
+		.name = "span",
+		.kfunc = "bpf_strcspn",
+		.prog = skel->progs.span_kfunc,
+		.skel = skel,
+		.kind = BENCH_SPAN,
+	};
+	benchmarks[BENCH_SUBSTRING] = (struct benchmark) {
+		.name = "substring",
+		.kfunc = "bpf_strnstr",
+		.prog = skel->progs.substring_kfunc,
+		.skel = skel,
+		.kind = BENCH_SUBSTRING,
+	};
+
+	uname(&uts);
+	printf("BPF string kfunc benchmark\n");
+	printf("kernel=%s arch=%s repeat=%d trials=%d warmup=%d\n",
+	       uts.release, uts.machine, STR_BENCH_REPEAT, STR_BENCH_TRIALS, STR_BENCH_WARMUP);
+
+	for (i = 0; i < BENCH_COUNT; i++) {
+		printf("\n%s (%s)\n", benchmarks[i].name, benchmarks[i].kfunc);
+		printf("%-9s %5s %13s\n", "Scenario", "Bytes", "Kfunc ns/op");
+
+		for (j = 0; j < STR_BENCH_SCENARIOS; j++) {
+			make_scenario(benchmarks[i].kind, &scenario, &scenario_specs[j]);
+			benchmark_scenario(&benchmarks[i], &scenario);
+		}
+	}
+
+	bpf_str_kfuncs_bench__destroy(skel);
+}
+
+const struct bench bench_bpf_str_kfuncs = {
+	.name = "bpf-str-kfuncs",
+	.run = str_kfuncs_run,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bpf_str_kfuncs.sh b/tools/testing/selftests/bpf/benchs/run_bench_bpf_str_kfuncs.sh
new file mode 100755
index 000000000000..4787176e7717
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_bpf_str_kfuncs.sh
@@ -0,0 +1,98 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -euo pipefail
+
+cpu=${CPU:-1}
+report=${REPORT:-bench_bpf_str_kfuncs.tmp}
+
+if [[ -z "$report" ]]; then
+	echo "Report file must not be empty" >&2
+	exit 2
+fi
+
+tmp=$(mktemp "${report}.tmp.XXXXXX")
+trap 'rm -f "$tmp"' EXIT
+
+sudo taskset -c "$cpu" ./bench bpf-str-kfuncs "$@" > "$tmp"
+
+if [[ ! -e "$report" ]]; then
+	mv "$tmp" "$report"
+	trap - EXIT
+	cat "$report"
+	printf '\nSaved baseline report to %s\n' "$report"
+	exit
+fi
+
+awk '
+function fail(message)
+{
+	print "Invalid benchmark comparison: " message > "/dev/stderr"
+	failed = 1
+	exit 1
+}
+
+FNR == 1 {
+	file++
+	kind = ""
+}
+
+$1 ~ /^kernel=/ {
+	if (file == 1) {
+		baseline_kernel = $0
+		baseline_params = $2 " " $3 " " $4 " " $5
+	} else {
+		current_kernel = $0
+		current_params = $2 " " $3 " " $4 " " $5
+		if (baseline_params != current_params)
+			fail("architecture or run parameters differ")
+		print "BPF string kfunc benchmark comparison"
+		print "baseline " baseline_kernel
+		print "current  " current_kernel
+	}
+	next
+}
+
+$0 ~ /^[[:alpha:]]+ \(bpf_[[:alnum:]_]+\)$/ {
+	kind = $1
+	kfunc = $2
+	gsub(/[()]/, "", kfunc)
+	next
+}
+
+$1 ~ /^(first|middle|late|absent|equal)$/ && $2 ~ /^[0-9]+$/ {
+	key = kind SUBSEP $1
+	if (!kind)
+		fail("result row without benchmark name")
+
+	if (file == 1) {
+		baseline[key] = $3
+		baseline_bytes[key] = $2
+		baseline_count++
+	} else {
+		if (!(key in baseline))
+			fail("baseline is missing " kind "/" $1)
+		if (baseline_bytes[key] != $2)
+			fail("byte count differs for " kind "/" $1)
+		if (kind != last_kind) {
+			last_kind = kind
+			printf "\n%s (%s)\n", kind, kfunc
+			printf "%-9s %5s %15s %14s %9s\n", "Scenario",
+			       "Bytes", "Baseline ns/op", "Current ns/op",
+			       "Speedup"
+		}
+		printf "%-9s %5d %15.1f %14.1f %8.2fx\n",
+		       $1, $2, baseline[key], $3, baseline[key] / $3
+		current_count++
+	}
+}
+
+END {
+	if (failed)
+		exit 1
+	if (!baseline_kernel || !current_kernel)
+		fail("missing benchmark metadata")
+	if (baseline_count != current_count)
+		fail("different number of result rows")
+}
+' "$report" "$tmp"
diff --git a/tools/testing/selftests/bpf/progs/bpf_str_kfuncs_bench.c b/tools/testing/selftests/bpf/progs/bpf_str_kfuncs_bench.c
new file mode 100644
index 000000000000..44a40e42cafa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_str_kfuncs_bench.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define STR_BENCH_CAP 2048
+
+static const char span_reject[] __aligned(8) = ":";
+static const char substring_needle[] __aligned(8) =
+	"Host: benchmark.example.com";
+
+/* Populated by userspace once per scenario, outside the timed program run. */
+struct {
+	struct {
+		__u64 words[(STR_BENCH_CAP + sizeof(__u64)) / sizeof(__u64)];
+	} lhs;
+	struct {
+		__u64 words[(STR_BENCH_CAP + sizeof(__u64)) / sizeof(__u64)];
+	} rhs;
+} buffers SEC(".data");
+
+__u32 payload_length SEC(".data");
+
+SEC("tc")
+int scan_kfunc(struct __sk_buff *skb)
+{
+	return bpf_strnchr((const char *)buffers.lhs.words, payload_length, 'H');
+}
+
+SEC("tc")
+int compare_kfunc(struct __sk_buff *skb)
+{
+	return bpf_strcmp((const char *)buffers.lhs.words, (const char *)buffers.rhs.words);
+}
+
+SEC("tc")
+int span_kfunc(struct __sk_buff *skb)
+{
+	return bpf_strcspn((const char *)buffers.lhs.words, span_reject);
+}
+
+SEC("tc")
+int substring_kfunc(struct __sk_buff *skb)
+{
+	return bpf_strnstr((const char *)buffers.lhs.words, substring_needle, payload_length);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

