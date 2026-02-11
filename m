Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70187343D75
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833579; cv=none; b=NG+u25vEAOSnNXAhseCIwhUW2DbCLyXOBidWBFi/A1GCWb3uftwgtRANeeEa9ZOLhWh6mFOYnnq3BB8fsF4nu9Njj0ZtQrtFmnQfmwwvKPZszFonFwDNVx4o37ROlsTpm8emRqexFIoryVTFgzzraDnPoYibfn8TYbn2+PuBZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833579; c=relaxed/simple;
	bh=cEtHEZyBw/fQLAmpjBYj/GoNulJAkwIigOM7eVDQ8WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQSX7uPrpnKrbId/4f/xK7K8VTQNZ/lMRyKa2KIeM1Io5bns5RjWmslI7RADrCiUWdBVy3aZQna9rOtMUixLNoPnSr/ClcN3g4XlZ6qOgWLUl8NOFdlRSLV5mbwgOQRMrWTij6fkhcAbQIDjfjxOgfX+toQgavFIAt8v4neUtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R53PK9Kw; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R53PK9Kw"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d122733808so2346306a34.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833576; x=1771438376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCC+uVp2LT/TAkpQs4oUtzvvM7v4ITfswhYsSPuSGjY=;
        b=R53PK9KwSJ3HJG0Dh6Cm1Y8u79TqxKXzc+/JwskoHGBha/3/yjLU2Nk7lfeKht9AMJ
         nWTlFS0crS/F86t9xvjz+0dwDcqODjkhJrRJpouh5agt0h30+lx2XCTDZjk7CdygSYDo
         5b3ftv13M0Wyt9IIVRIYQPRd5UK88GC/cG0/OCmKcpn/GeblDTB4EwmGyIGz7ncd69Kn
         Nga0jw0e+3SiwkNiApst117e5bKw+PxoEm+jWXhGgnThZHLbZ+I5V1KjyqGvygoVn2V4
         GolCmiGNxDqhUTZBHr8JrNNBKEJJXWdzD0LYS+hSUnQAmvGcTGNAh7/bcw2VvhuNLk/1
         tP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833576; x=1771438376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCC+uVp2LT/TAkpQs4oUtzvvM7v4ITfswhYsSPuSGjY=;
        b=ILkgnhKPyVnkdYf/4n0vgHrJf+xpJA2vINNPyZLbJZqvRRc9GlC/y6T7EzAqFOCvw6
         B5/hmZxGB66Z4Qb7lC9Ngbkj2rDudiZUVvOw9Ng4ZRzAhluVab9P7T+1Aqb7t/LmVE90
         XKsL17tlhhIOmVgqfAjCgC/gM3eTZ3CBU2EN23hSJ1GvEG+phhAP5kU3CzR1OqKkAv4o
         v44VBz+nrLZmJ3wuHSO2elZ4rlibMbZM1nfnUNFwwR78Fo1oi9Xo5VGz7LsY/W4g3c8O
         XzVsmIGD4qfXVB1on3VvTpoGdltXm4eAPANZkmCwSEJXHlJcKYvD+9u+2VS9mTOH/A+a
         KeOA==
X-Gm-Message-State: AOJu0YxGWQalX8W7fJ8NonlsL6OkqHGoycSjuhpjg3O9+vRovLOl4GMJ
	GIFXJ98anH0Mrnd0UZ7eeAWZKPoEtR3LrWwdUnkdrqKFIcYJ7l+Vtxge/mkmlwkO4rh9iw==
X-Gm-Gg: AZuq6aK+9g6cMuF6NJ0iiLl4ogJicmv/yLAFv+dqk6JiE0wNqG712EoGO9oepw7j1rY
	L4k/jl2g0guQYgMF4y0x2IKeBEtflEzRppFwm7Uq7YWGn9J+g1Q51rZ0e+or6Hdli3474wJm8rD
	tpZui76QB1VHAEgnpFtv43QVChnWXXUMHcBh1vbOMnf0eFYCwa1T+/FF51HsT5lycX239OCHpqL
	eIonmWG+wUI534Q2EyDUZdQ7J4k8VLJ9Q9DscFzcbcc1pVGpnbHLOb5Q2V04KaNmST1HtKZrixg
	s9B4MuYBRpp0VA05fzNGuodOPZlZDJGG1i0uUc6mpx5hcWSJZIcrub5W5k8cwLUHBfPGK7F6Ycs
	jh4e3JUbx6bDFmOwJipoUMRxmkKUDNd8AtfjQt+SWg1WNRELuUi8DpQM82nST0GYeDfqERi7FBe
	3+LoWGK7leK0Fb9YUIv3kSjOkO/CXiJ27aZNQ/ikj9Puu4
X-Received: by 2002:a05:6830:81d8:b0:7c7:32d:975d with SMTP id 46e09a7af769-7d4a57ac266mr1478418a34.31.1770833575725;
        Wed, 11 Feb 2026 10:12:55 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7547ac1sm1687316a34.7.2026.02.11.10.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:12:55 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 4/6] selftests/bpf: Introduce concurrency testing tool
Date: Wed, 11 Feb 2026 10:12:44 -0800
Message-ID: <20260211181248.3040142-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211181248.3040142-1-memxor@gmail.com>
References: <20260211181248.3040142-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=31650; h=from:subject; bh=cEtHEZyBw/fQLAmpjBYj/GoNulJAkwIigOM7eVDQ8WE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpjMUemcpfGXMsGP65xFjzGz37L1imKId2X7dbtb58 Af5XVBmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYzFHgAKCRBM4MiGSL8RynVHEA CsMUW8wZXNkpW2zVX4H/zMx1Ik/pI8NF4Lb9JlJSAOF99XONfYIzGbyZUAanAP9P6sQPX9ICHA0Gix MzyTWolhvnzH8v2zKgYbm1IYj6cMCad1iFOEhqgtBBHZJobV6P2qYsw+CIVB5Y9TgcVCbFFL3O+Gul 0KV0Ptv7kRKxlTig4eQLfqJw77kdJhZwIWWcRWns35XFZhtrJDBX7fj9uVIHG54nSDP3i5DQNknTZq XCo7A/I8L50a/4V8EhCHQqcWNUbWPI32cZBqDiuui9TDvcLIfkvZnMc1Lp8w2lewtoqtLFBRg3JBd9 ALLdjJHFlTebqCL8gwGCvY2+u/3tIX7PxRc0IXwWVgdb53lP4mf3gh1jOu6TgdtGWv3KUL4dKksLdk mEZkJhjBs7mAcv6Uz4UB3Z3RV1ojvLu2k0ST4Ag/Z/tXYzvFD2Eyk7Btj9eZj+ROnrctCl9c9K8GlF 0QCfIC2PdjnQ2PNEORt7XGjKttu6QaQT6o8hiDcy8rbUAicoBjZMhosUW8WiDfZdf8Cv4bWyMKwpSM SbCSaZQrp011AIybm77pjy24XApHOlRWSvckTX6fjyOSRaQwcq627x4IioblMBWdQ4pDi2Qnhz9CI1 oOivKolmK5PpBBfS+NlecCSXt0ACHBsdgNtJ52MWj+jrez47OjKgTWHNx8XA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a scaffolding for concurrency testing tool with rqspinlock as
the first example. The main idea is to set up various permutations of
context reentrancy and parallel invocations to allow more exhaustive
testing of various concurrency-related primitives. Each operation also
supports specification of expected values (e.g. ABBA should always
-EDEADLK, never -ETIMEDOUT) and threshold values on maximum expected
delay. In case violations occur, the tests will fail and a histogram
with timing distribution will be printed. The timing information is
useful in general to observe various statistics of operation latency
from different contexts to notice potential anomalies.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/Makefile         |   6 +
 tools/testing/selftests/bpf/conctest.c       | 889 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/conctest.c | 289 ++++++
 3 files changed, 1184 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/conctest.c
 create mode 100644 tools/testing/selftests/bpf/progs/conctest.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c6bf4dfb1495..2e225d19f248 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -123,6 +123,7 @@ TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
 	bench \
+	conctest \
 	flow_dissector_load \
 	test_cpp \
 	test_lirc_mode2_user \
@@ -504,6 +505,7 @@ linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
 test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
 test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
 test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
+conctest.skel.h-deps := conctest.bpf.o
 xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
@@ -823,6 +825,10 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
+$(OUTPUT)/conctest: conctest.c $(OUTPUT)/conctest.skel.h $(BPFOBJ) | $(OUTPUT)
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -lm -o $@
+
 # Make sure we are able to include and link libbpf against c++.
 CXXFLAGS += $(CFLAGS)
 CXXFLAGS := $(subst -D_GNU_SOURCE=,,$(CXXFLAGS))
diff --git a/tools/testing/selftests/bpf/conctest.c b/tools/testing/selftests/bpf/conctest.c
new file mode 100644
index 000000000000..e4b333aff419
--- /dev/null
+++ b/tools/testing/selftests/bpf/conctest.c
@@ -0,0 +1,889 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <sched.h>
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <math.h>
+#include <time.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include "conctest.skel.h"
+
+#define MAX_FILTERS 64
+#define MAX_ATTACH_LINKS 1024
+#define NMI_SAMPLE_PERIOD 1000
+#define DEFAULT_DURATION 5
+#define DEFAULT_NR_CPUS 1
+
+#define CONCTEST_HIST_BUCKETS 28
+#define EDEADLK 35
+#define ETIMEDOUT 110
+#define HIST_BAR_WIDTH 40
+
+static int nmi_sample_period = NMI_SAMPLE_PERIOD;
+static volatile int stop;
+static int verbose;
+static __u32 delay_seed;
+static __u32 delay_max_us = 10;
+static __u32 delay_us;
+
+enum conctest_stat_id {
+	CONCTEST_STAT_SYSCALL = 0,
+	CONCTEST_STAT_NMI,
+	CONCTEST_STAT_MAX,
+};
+
+static const char *stat_names[CONCTEST_STAT_MAX] = {
+	[CONCTEST_STAT_SYSCALL] = "syscall",
+	[CONCTEST_STAT_NMI] = "nmi",
+};
+
+struct conctest_op_stats {
+	__u64 count;
+	__u64 success;
+	__u64 failure;
+	__u64 unexpected;
+	__u64 total_ns;
+	__u64 min_ns;
+	__u64 max_ns;
+	__u64 hist[CONCTEST_HIST_BUCKETS];
+};
+
+struct conctest_op_state {
+	__s64 expect_ret;
+	__u64 delay_thresh_ns;
+	__u64 failed_print_once;
+	__u64 delay_print_once;
+};
+
+/* Upper boundary (exclusive) of each histogram bucket, in ns */
+static const __u64 hist_upper[CONCTEST_HIST_BUCKETS] = {
+	1000, /* [0, 1us) */
+	100000, /* [1us, 100us) */
+	200000,	    300000,	400000,	   500000,    600000,
+	700000,	    800000,	900000,	   1000000, /* [900us, 1ms) */
+	10000000, /* [1ms, 10ms) */
+	20000000,   30000000,	40000000,  50000000,  60000000,
+	70000000,   80000000,	90000000,  100000000, /* [90ms, 100ms) */
+	150000000,  200000000,	250000000, 500000000, 750000000,
+	1000000000, UINT64_MAX, /* [1s, inf) */
+};
+
+static void format_ns(char *buf, size_t sz, __u64 ns)
+{
+	if (ns < 1000)
+		snprintf(buf, sz, "%lluns", (unsigned long long)ns);
+	else if (ns < 1000000)
+		snprintf(buf, sz, "%.1fus", ns / 1000.0);
+	else if (ns < 1000000000)
+		snprintf(buf, sz, "%.1fms", ns / 1000000.0);
+	else
+		snprintf(buf, sz, "%.2fs", ns / 1000000000.0);
+}
+
+static void format_bucket_range(char *buf, size_t sz, int i)
+{
+	__u64 lo = i > 0 ? hist_upper[i - 1] : 0;
+	__u64 hi = hist_upper[i];
+	char lo_s[32], hi_s[32];
+
+	format_ns(lo_s, sizeof(lo_s), lo);
+	if (hi == UINT64_MAX)
+		snprintf(buf, sz, "[%7s, inf)", lo_s);
+	else {
+		format_ns(hi_s, sizeof(hi_s), hi);
+		snprintf(buf, sz, "[%7s, %7s)", lo_s, hi_s);
+	}
+}
+
+static __u64 estimate_median(struct conctest_op_stats *s)
+{
+	__u64 half = s->count / 2;
+	__u64 cumulative = 0;
+	int i;
+
+	for (i = 0; i < CONCTEST_HIST_BUCKETS; i++) {
+		cumulative += s->hist[i];
+		if (cumulative >= half) {
+			__u64 lo = i > 0 ? hist_upper[i - 1] : 0;
+			__u64 hi = hist_upper[i];
+
+			if (hi == UINT64_MAX)
+				return lo;
+			return (lo + hi) / 2;
+		}
+	}
+	return 0;
+}
+
+static __u64 estimate_stddev(struct conctest_op_stats *s)
+{
+	double mean, sum_sq = 0;
+	int i;
+
+	if (s->count < 2)
+		return 0;
+
+	mean = (double)s->total_ns / s->count;
+
+	for (i = 0; i < CONCTEST_HIST_BUCKETS; i++) {
+		double lo, hi, mid, diff;
+
+		if (!s->hist[i])
+			continue;
+
+		lo = i > 0 ? (double)hist_upper[i - 1] : 0;
+		hi = hist_upper[i] == UINT64_MAX ? lo : (double)hist_upper[i];
+		mid = (lo + hi) / 2;
+		diff = mid - mean;
+		sum_sq += s->hist[i] * diff * diff;
+	}
+
+	return (__u64)sqrt(sum_sq / s->count);
+}
+
+static void print_histogram(struct conctest_op_stats *s)
+{
+	int i, j, len, last_printed = -1;
+	__u64 max_count = 0;
+
+	for (i = 0; i < CONCTEST_HIST_BUCKETS; i++)
+		if (s->hist[i] > max_count)
+			max_count = s->hist[i];
+
+	if (!max_count)
+		return;
+
+	printf("  Histogram:\n");
+	for (i = 0; i < CONCTEST_HIST_BUCKETS; i++) {
+		char range[48];
+
+		if (!s->hist[i])
+			continue;
+
+		if (last_printed >= 0 && i > last_printed + 1)
+			printf("           ...\n");
+		last_printed = i;
+
+		format_bucket_range(range, sizeof(range), i);
+		printf("    %s %8llu |", range, (unsigned long long)s->hist[i]);
+
+		len = max_count ? (int)(s->hist[i] * HIST_BAR_WIDTH / max_count) : 0;
+		for (j = 0; j < len; j++)
+			putchar('#');
+		printf("\n");
+	}
+}
+
+static int dump_test_stats(struct conctest *skel)
+{
+	char avg_str[32], min_str[32], max_str[32], med_str[32], stddev_str[32], thresh_str[32];
+	int ncpus = libbpf_num_possible_cpus();
+	struct conctest_op_stats *per_cpu;
+	struct conctest_op_state state;
+	struct conctest_op_stats agg;
+	int has_error = 0;
+	int id, cpu, b;
+
+	per_cpu = calloc(ncpus, sizeof(*per_cpu));
+	if (!per_cpu)
+		return -ENOMEM;
+
+	for (id = 0; id < CONCTEST_STAT_MAX; id++) {
+		int has_min = 0;
+		int key = id;
+
+		if (bpf_map__lookup_elem(skel->maps.perf_map, &key, sizeof(key),
+					 per_cpu, ncpus * sizeof(*per_cpu), 0))
+			continue;
+
+		memset(&agg, 0, sizeof(agg));
+		for (cpu = 0; cpu < ncpus; cpu++) {
+			struct conctest_op_stats *p = &per_cpu[cpu];
+
+			agg.count += p->count;
+			agg.success += p->success;
+			agg.failure += p->failure;
+			agg.unexpected += p->unexpected;
+			agg.total_ns += p->total_ns;
+
+			if (p->count > 0) {
+				if (!has_min || p->min_ns < agg.min_ns) {
+					agg.min_ns = p->min_ns;
+					has_min = 1;
+				}
+			}
+			if (p->max_ns > agg.max_ns)
+				agg.max_ns = p->max_ns;
+
+			for (b = 0; b < CONCTEST_HIST_BUCKETS; b++)
+				agg.hist[b] += p->hist[b];
+		}
+
+		if (!agg.count)
+			continue;
+
+		if (bpf_map__lookup_elem(skel->maps.state_map, &key,
+					 sizeof(key), &state, sizeof(state), 0))
+			memset(&state, 0, sizeof(state));
+
+		format_ns(avg_str, sizeof(avg_str), agg.total_ns / agg.count);
+		format_ns(min_str, sizeof(min_str), agg.min_ns);
+		format_ns(max_str, sizeof(max_str), agg.max_ns);
+		format_ns(med_str, sizeof(med_str), estimate_median(&agg));
+		format_ns(stddev_str, sizeof(stddev_str), estimate_stddev(&agg));
+
+		if (agg.unexpected || state.delay_print_once)
+			has_error = 1;
+
+		if (!verbose && !has_error)
+			continue;
+		printf("=== Stats: %s ===\n",
+		       stat_names[id] ? stat_names[id] : "unknown");
+		printf("  Count: %lu (success: %lu, failure: %lu, unexpected: %lu)\n",
+		       (unsigned long)agg.count,
+		       (unsigned long)agg.success,
+		       (unsigned long)agg.failure,
+		       (unsigned long)agg.unexpected);
+		printf("  Timing: avg=%s min=%s max=%s median=~%s stddev=~%s\n",
+		       avg_str, min_str, max_str, med_str, stddev_str);
+		if (state.delay_thresh_ns) {
+			format_ns(thresh_str, sizeof(thresh_str), state.delay_thresh_ns);
+			printf("  Delay threshold: %s (exceeded: %s)\n", thresh_str,
+			       state.delay_print_once ? "YES" : "no");
+		}
+		print_histogram(&agg);
+	}
+
+	free(per_cpu);
+	return has_error ? -1 : 0;
+}
+
+enum conctest_cfg_type {
+	CT_INVALID = 0,
+	CT_TASK_PROG,
+	CT_NMI_PROG,
+	CT_ATTACH_PROG,
+};
+
+struct conctest_cfg {
+	enum conctest_cfg_type type;
+	union {
+		struct {
+			const char *prog_name;
+		} task;
+		struct {
+			const char *prog_name;
+		} nmi;
+		struct {
+			struct bpf_program *(*get_prog)(struct conctest *skel,
+							struct conctest_cfg *cfg,
+							bool loaded);
+			const char *tp_category;
+			const char *tp_name;
+		} attach;
+	};
+};
+
+#define for_each_conctest_cfg(cfg, arr) \
+	for (struct conctest_cfg *cfg = (arr); cfg->type != CT_INVALID; cfg++)
+
+struct conctest_test {
+	const char *name;
+	struct conctest_cfg *cfgs;
+	void (*init)(struct conctest *skel);
+	int nr_cpus;
+};
+
+struct conctest_cfg rqspinlock[] = {
+	{
+		.type = CT_TASK_PROG,
+		.task = { "conctest_rqspinlock_task" },
+	},
+	{
+		.type = CT_NMI_PROG,
+		.nmi = { "conctest_rqspinlock_nmi" },
+	},
+	{}
+};
+
+struct conctest_cfg rqspinlock_shift[] = {
+	{
+		.type = CT_TASK_PROG,
+		.task = { "conctest_rqspinlock_task" },
+	},
+	{
+		.type = CT_NMI_PROG,
+		.nmi = { "conctest_rqspinlock_nmi_shift" },
+	},
+	{}
+};
+
+static void __rqspinlock_init(struct conctest *skel, int err, int delay)
+{
+	struct conctest_op_state state;
+	int key;
+
+	key = CONCTEST_STAT_SYSCALL;
+	memset(&state, 0, sizeof(state));
+	state.expect_ret = 0;
+	state.delay_thresh_ns = 1000000 * delay;
+	bpf_map__update_elem(skel->maps.state_map, &key, sizeof(key), &state,
+			     sizeof(state), 0);
+
+	key = CONCTEST_STAT_NMI;
+	memset(&state, 0, sizeof(state));
+	state.expect_ret = err;
+	state.delay_thresh_ns = 1000000 * delay;
+	bpf_map__update_elem(skel->maps.state_map, &key, sizeof(key), &state,
+			     sizeof(state), 0);
+}
+
+static void rqspinlock_init(struct conctest *skel)
+{
+	return __rqspinlock_init(skel, -EDEADLK, 2);
+}
+
+static void rqspinlock_init_delay(struct conctest *skel)
+{
+	return __rqspinlock_init(skel, -EDEADLK, 10);
+}
+
+static void rqspinlock_init_timeout(struct conctest *skel)
+{
+	return __rqspinlock_init(skel, -ETIMEDOUT, 300);
+}
+
+static struct conctest_test all_tests[] = {
+	{
+		.name = "rqspinlock:AA",
+		.cfgs = rqspinlock,
+		.init = rqspinlock_init,
+		.nr_cpus = 1
+	},
+	{
+		.name = "rqspinlock:ABBA",
+		.cfgs = rqspinlock_shift,
+		.init = rqspinlock_init_delay,
+		.nr_cpus = 2
+	},
+	{
+		.name = "rqspinlock:ABBCBA",
+		.cfgs = rqspinlock_shift,
+		.init = rqspinlock_init_timeout,
+		.nr_cpus = 3
+	},
+	{},
+};
+
+struct task_ctx {
+	int prog_fd;
+	int cpu;
+};
+
+static int pin_to_cpu(int cpu)
+{
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+	return pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
+}
+
+static void *worker(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .repeat = 1000);
+	struct task_ctx *ctx = arg;
+
+	if (pin_to_cpu(ctx->cpu)) {
+		fprintf(stderr, "Failed to pin to CPU %d\n", ctx->cpu);
+		return NULL;
+	}
+
+	while (!stop)
+		bpf_prog_test_run_opts(ctx->prog_fd, &opts);
+
+	return NULL;
+}
+
+static int open_perf_event(int cpu)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.size = sizeof(attr),
+		.sample_period = nmi_sample_period,
+		.pinned = 1,
+		.disabled = 0,
+	};
+
+	return syscall(__NR_perf_event_open, &attr, -1, cpu, -1, 0);
+}
+
+struct conctest_ctx {
+	pthread_t *threads;
+	struct task_ctx *task_ctxs;
+	int nr_threads;
+
+	int *nmi_link_fds;
+	int *nmi_pmu_fds;
+	int nr_nmis;
+
+	struct bpf_link **attach_links;
+	int nr_attach_links;
+	int max_attach_links;
+};
+
+static struct conctest_ctx *alloc_ctx(int nr_cpus, struct conctest_cfg *cfgs)
+{
+	int nr_task = 0, nr_nmi = 0, nr_attach = 0;
+	struct conctest_ctx *ctx;
+
+	for_each_conctest_cfg(cfg, cfgs) {
+		switch (cfg->type) {
+		case CT_TASK_PROG:
+			nr_task++;
+			break;
+		case CT_NMI_PROG:
+			nr_nmi++;
+			break;
+		case CT_ATTACH_PROG:
+			nr_attach++;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (nr_task > 1) {
+		fprintf(stderr, "Only one CT_TASK_PROG entry allowed\n");
+		return NULL;
+	}
+
+	if (nr_nmi > 1) {
+		fprintf(stderr, "Only one CT_NMI_PROG entry allowed\n");
+		return NULL;
+	}
+
+	if (nr_attach > MAX_ATTACH_LINKS) {
+		fprintf(stderr, "Too many attach links (%d > %d)\n", nr_attach,
+			MAX_ATTACH_LINKS);
+		return NULL;
+	}
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		return NULL;
+
+	if (nr_task) {
+		ctx->threads = calloc(nr_cpus, sizeof(*ctx->threads));
+		ctx->task_ctxs = calloc(nr_cpus, sizeof(*ctx->task_ctxs));
+		if (!ctx->threads || !ctx->task_ctxs)
+			goto err;
+	}
+
+	if (nr_nmi) {
+		ctx->nmi_link_fds = malloc(nr_cpus * sizeof(*ctx->nmi_link_fds));
+		ctx->nmi_pmu_fds = malloc(nr_cpus * sizeof(*ctx->nmi_pmu_fds));
+		if (!ctx->nmi_link_fds || !ctx->nmi_pmu_fds)
+			goto err;
+		memset(ctx->nmi_link_fds, -1, nr_cpus * sizeof(*ctx->nmi_link_fds));
+		memset(ctx->nmi_pmu_fds, -1, nr_cpus * sizeof(*ctx->nmi_pmu_fds));
+	}
+
+	if (nr_attach) {
+		ctx->attach_links = calloc(nr_attach, sizeof(*ctx->attach_links));
+		if (!ctx->attach_links)
+			goto err;
+		ctx->max_attach_links = nr_attach;
+	}
+
+	return ctx;
+
+err:
+	free(ctx->threads);
+	free(ctx->task_ctxs);
+	free(ctx->nmi_link_fds);
+	free(ctx->nmi_pmu_fds);
+	free(ctx->attach_links);
+	free(ctx);
+	return NULL;
+}
+
+static void free_ctx(struct conctest_ctx *ctx)
+{
+	int i;
+
+	if (!ctx)
+		return;
+
+	for (i = 0; i < ctx->nr_nmis; i++) {
+		if (ctx->nmi_link_fds[i] >= 0)
+			close(ctx->nmi_link_fds[i]);
+		if (ctx->nmi_pmu_fds[i] >= 0)
+			close(ctx->nmi_pmu_fds[i]);
+	}
+
+	for (i = 0; i < ctx->nr_attach_links; i++)
+		bpf_link__destroy(ctx->attach_links[i]);
+
+	for (i = 0; i < ctx->nr_threads; i++)
+		pthread_join(ctx->threads[i], NULL);
+
+	free(ctx->threads);
+	free(ctx->task_ctxs);
+	free(ctx->nmi_link_fds);
+	free(ctx->nmi_pmu_fds);
+	free(ctx->attach_links);
+	free(ctx);
+}
+
+static void dump_prog_stdout(struct conctest *skel)
+{
+	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
+	struct bpf_program *prog;
+	char buf[4096];
+	int fd, ret;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		int printed_header = 0;
+
+		fd = bpf_program__fd(prog);
+		if (fd < 0)
+			continue;
+
+		for (;;) {
+			ret = bpf_prog_stream_read(fd, BPF_STREAM_STDOUT, buf,
+						   sizeof(buf) - 1, &ropts);
+			if (ret <= 0)
+				break;
+
+			if (!printed_header) {
+				printf("\n=== %s stdout: ===\n", bpf_program__name(prog));
+				printed_header = 1;
+			}
+
+			buf[ret] = '\0';
+			printf("%s", buf);
+		}
+	}
+}
+
+static int find_prog_fd(struct conctest *skel, const char *prog_name)
+{
+	struct bpf_program *prog;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!prog)
+		return -1;
+	return bpf_program__fd(prog);
+}
+
+static int run_test(struct conctest_test *test, int nr_cpus, int duration)
+{
+	struct conctest_ctx *ctx;
+	struct conctest *skel;
+	int err = -1;
+
+	if (test->nr_cpus > 0)
+		nr_cpus = test->nr_cpus;
+
+	ctx = alloc_ctx(nr_cpus, test->cfgs);
+	if (!ctx)
+		return -ENOMEM;
+
+	printf("Running test '%s' on %d CPU(s) for %d seconds\n", test->name, nr_cpus, duration);
+
+	skel = conctest__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to open BPF skeleton\n");
+		goto free;
+	}
+
+	for_each_conctest_cfg(cfg, test->cfgs) {
+		struct bpf_program *prog;
+		const char *name = NULL;
+
+		switch (cfg->type) {
+		case CT_TASK_PROG:
+			name = cfg->task.prog_name;
+			break;
+		case CT_NMI_PROG:
+			name = cfg->nmi.prog_name;
+			break;
+		case CT_ATTACH_PROG:
+			cfg->attach.get_prog(skel, cfg, false);
+			break;
+		default:
+			break;
+		}
+
+		if (name) {
+			prog = bpf_object__find_program_by_name(skel->obj, name);
+			if (!prog) {
+				fprintf(stderr, "Program '%s' not found\n", name);
+				goto out;
+			}
+			bpf_program__set_autoload(prog, true);
+		}
+	}
+
+	err = conctest__load(skel);
+	if (err) {
+		fprintf(stderr, "Failed to load BPF skeleton: %d\n", err);
+		goto out;
+	}
+
+	stop = 0;
+
+	if (test->init)
+		test->init(skel);
+	/* Pass the test nr_cpus to rotate between objects, but use passed in nr_cpus otherwise. */
+	skel->bss->nr_cpus = test->nr_cpus;
+	skel->bss->delay_seed = delay_us;
+
+	for_each_conctest_cfg(cfg, test->cfgs) {
+		int cpu;
+
+		switch (cfg->type) {
+		case CT_TASK_PROG:
+			for (cpu = 0; cpu < nr_cpus; cpu++) {
+				struct task_ctx *tc;
+				int prog_fd;
+
+				prog_fd = find_prog_fd(skel, cfg->task.prog_name);
+				if (prog_fd < 0) {
+					fprintf(stderr,
+						"Failed to get task prog fd for CPU %d\n", cpu);
+					goto out;
+				}
+
+				tc = &ctx->task_ctxs[ctx->nr_threads];
+				tc->prog_fd = prog_fd;
+				tc->cpu = cpu;
+				err = pthread_create(&ctx->threads[ctx->nr_threads], NULL,
+						     worker, tc);
+				if (err) {
+					fprintf(stderr,
+						"Failed to create thread for CPU %d: %s\n",
+						cpu, strerror(err));
+					goto out;
+				}
+				ctx->nr_threads++;
+			}
+			break;
+		case CT_NMI_PROG:
+			for (cpu = 0; cpu < nr_cpus; cpu++) {
+				int prog_fd, pmu_fd, link_fd;
+				int idx = ctx->nr_nmis;
+
+				prog_fd = find_prog_fd(skel, cfg->nmi.prog_name);
+				if (prog_fd < 0) {
+					fprintf(stderr,
+						"Failed to get NMI prog fd for CPU %d\n", cpu);
+					goto out;
+				}
+
+				pmu_fd = open_perf_event(cpu);
+				if (pmu_fd < 0) {
+					fprintf(stderr,
+						"Failed to open perf event on CPU %d: %s\n",
+						cpu, strerror(errno));
+					goto out;
+				}
+				ctx->nmi_pmu_fds[idx] = pmu_fd;
+
+				link_fd = bpf_link_create(prog_fd, pmu_fd, BPF_PERF_EVENT, NULL);
+				if (link_fd < 0) {
+					fprintf(stderr,
+						"Failed to attach NMI prog on CPU %d: %s\n",
+						cpu, strerror(errno));
+					ctx->nr_nmis++;
+					goto out;
+				}
+				ctx->nmi_link_fds[idx] = link_fd;
+				ctx->nr_nmis++;
+			}
+			break;
+		case CT_ATTACH_PROG: {
+			struct bpf_program *prog;
+			struct bpf_link *link;
+
+			if (ctx->nr_attach_links >= ctx->max_attach_links) {
+				fprintf(stderr, "Too many attach links\n");
+				goto out;
+			}
+
+			prog = cfg->attach.get_prog(skel, cfg, true);
+			if (!prog) {
+				fprintf(stderr, "Failed to get attach prog\n");
+				goto out;
+			}
+
+			link = bpf_program__attach_tracepoint(prog, cfg->attach.tp_category,
+							      cfg->attach.tp_name);
+			if (!link) {
+				fprintf(stderr, "Failed to attach prog: %s\n",
+					strerror(errno));
+				goto out;
+			}
+			ctx->attach_links[ctx->nr_attach_links++] = link;
+			break;
+		}
+		default:
+			break;
+		}
+	}
+
+	sleep(duration);
+	printf("Test '%s' completed\n", test->name);
+	err = 0;
+out:
+	stop = 1;
+	if (dump_test_stats(skel))
+		err = -1;
+	dump_prog_stdout(skel);
+	printf("Test '%s': %s\n", test->name, err ? "FAIL" : "PASS");
+	conctest__destroy(skel);
+free:
+	free_ctx(ctx);
+	return err;
+}
+
+static const char *test_filter[MAX_FILTERS];
+static int nr_test_filters;
+
+static int parse_test_filter(char *arg)
+{
+	char *token;
+
+	token = strtok(arg, ",");
+	while (token) {
+		if (nr_test_filters >= MAX_FILTERS) {
+			fprintf(stderr, "Too many test filters (max %d)\n", MAX_FILTERS);
+			return -1;
+		}
+		test_filter[nr_test_filters++] = token;
+		token = strtok(NULL, ",");
+	}
+	return 0;
+}
+
+static int test_selected(const char *name)
+{
+	int i;
+
+	if (!nr_test_filters)
+		return 1;
+
+	for (i = 0; i < nr_test_filters; i++) {
+		if (strncmp(test_filter[i], name, strlen(test_filter[i])) == 0)
+			return 1;
+	}
+	return 0;
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"Usage: %s [OPTIONS]\n"
+		"  -h         Show this help message\n"
+		"  -t TESTS   Comma-separated list of test names to run\n"
+		"  -c CPUS    Number of CPUs/threads (default: %d)\n"
+		"  -d SECS    Duration per test in seconds (default: %d)\n"
+		"  -s PERIOD  NMI perf sample period (default: %d)\n"
+		"  -S SEED    Delay seed for reproducibility (default: random)\n"
+		"  -D USECS   Max critical section delay in us (default: 10)\n"
+		"  -v         Verbose output\n",
+		prog, DEFAULT_NR_CPUS, DEFAULT_DURATION, NMI_SAMPLE_PERIOD);
+}
+
+int main(int argc, char **argv)
+{
+	int max_cpus = libbpf_num_possible_cpus();
+	int duration = DEFAULT_DURATION;
+	int nr_cpus = DEFAULT_NR_CPUS;
+	int opt, ran = 0, failed = 0;
+	struct conctest_test *test;
+
+	if (max_cpus < 0) {
+		fprintf(stderr, "Failed to get number of possible CPUs\n");
+		return 1;
+	}
+
+	while ((opt = getopt(argc, argv, "ht:c:d:s:S:D:v")) != -1) {
+		switch (opt) {
+		case 't':
+			if (parse_test_filter(optarg))
+				return 1;
+			break;
+		case 'c':
+			nr_cpus = atoi(optarg);
+			if (nr_cpus < 1 || nr_cpus > max_cpus) {
+				fprintf(stderr, "Invalid CPU count (1-%d)\n", max_cpus);
+				return 1;
+			}
+			break;
+		case 'd':
+			duration = atoi(optarg);
+			if (duration < 1) {
+				fprintf(stderr, "Invalid duration\n");
+				return 1;
+			}
+			break;
+		case 's':
+			nmi_sample_period = atoi(optarg);
+			if (nmi_sample_period < 1) {
+				fprintf(stderr, "Invalid sample period\n");
+				return 1;
+			}
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 'D':
+			delay_max_us = (__u32)atoi(optarg);
+			break;
+		case 'S':
+			delay_seed = (__u32)strtoul(optarg, NULL, 0);
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+			return opt == 'h' ? 0 : 1;
+		}
+	}
+
+	if (!delay_seed)
+		delay_seed = (__u32)time(NULL);
+	delay_us = delay_seed % (delay_max_us + 1);
+	printf("Seed: %u, delay: %u us (max: %u us)\n", delay_seed, delay_us, delay_max_us);
+
+	for (test = all_tests; test->name; test++) {
+		if (!test_selected(test->name))
+			continue;
+
+		ran++;
+		if (run_test(test, nr_cpus, duration))
+			failed++;
+		fprintf(stderr, "\n\n\n");
+	}
+
+	if (!ran)
+		printf("No tests matched\n");
+	else
+		printf("\n%d/%d tests passed\n", ran - failed, ran);
+
+	return failed > 0 ? 1 : 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/conctest.c b/tools/testing/selftests/bpf/progs/conctest.c
new file mode 100644
index 000000000000..aca36320caf9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/conctest.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf_atomic.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf_experimental.h>
+
+#define EDEADLK		35
+#define ETIMEDOUT	110
+#define CONCTEST_HIST_BUCKETS 28
+
+int nr_cpus;
+__u32 delay_seed;
+
+enum conctest_stat_id {
+	CONCTEST_STAT_SYSCALL = 0,
+	CONCTEST_STAT_NMI,
+	CONCTEST_STAT_MAX,
+};
+
+struct conctest_op_stats {
+	__u64 count;
+	__u64 success;
+	__u64 failure;
+	__u64 unexpected;
+	__u64 total_ns;
+	__u64 min_ns;
+	__u64 max_ns;
+	__u64 hist[CONCTEST_HIST_BUCKETS];
+};
+
+struct conctest_op_state {
+	__s64 expect_ret;
+	__u64 delay_thresh_ns;
+	__u64 failed_print_once;
+	__u64 delay_print_once;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, CONCTEST_STAT_MAX);
+	__type(key, int);
+	__type(value, struct conctest_op_stats);
+} perf_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CONCTEST_STAT_MAX);
+	__type(key, int);
+	__type(value, struct conctest_op_state);
+} state_map SEC(".maps");
+
+enum ctx_level {
+	CTX_TASK = 0,
+	CTX_SOFTIRQ,
+	CTX_HARDIRQ,
+	CTX_NMI,
+	CTX_MAX,
+};
+
+struct ctx_time {
+	__u64 accumulated_ns[CTX_MAX];
+	__u64 start_ns[CTX_MAX];
+	__u64 snapshot[CTX_MAX];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct ctx_time);
+} ctx_time_map SEC(".maps");
+
+static __always_inline enum ctx_level get_ctx_level(void)
+{
+	int pcnt = get_preempt_count();
+
+	if (pcnt & NMI_MASK)
+		return CTX_NMI;
+	if (pcnt & HARDIRQ_MASK)
+		return CTX_HARDIRQ;
+	if (pcnt & SOFTIRQ_MASK)
+		return CTX_SOFTIRQ;
+	return CTX_TASK;
+}
+
+static __always_inline __u64 ctx_higher_sum(struct ctx_time *ct, enum ctx_level level)
+{
+	__u64 sum = 0;
+	int i;
+
+	for (i = level + 1; i < CTX_MAX; i++)
+		sum += ct->accumulated_ns[i];
+	return sum;
+}
+
+static __always_inline void conctest_begin(void)
+{
+	struct ctx_time *ct;
+	enum ctx_level level;
+	int key = 0;
+
+	ct = bpf_map_lookup_elem(&ctx_time_map, &key);
+	if (!ct)
+		return;
+
+	level = get_ctx_level();
+	ct->snapshot[level] = ctx_higher_sum(ct, level);
+	ct->start_ns[level] = bpf_ktime_get_ns();
+}
+
+/*
+ *   0: [0, 1µs)           1: [1µs, 100µs)
+ *   2: [100µs, 200µs) ... 10: [900µs, 1ms)
+ *  11: [1ms, 10ms)        12: [10ms, 20ms) ... 20: [90ms, 100ms)
+ *  21: [100ms, 150ms)     22: [150ms, 200ms)   23: [200ms, 250ms)
+ *  24: [250ms, 500ms)     25: [500ms, 750ms)   26: [750ms, 1s)
+ *  27: [1s, inf)
+ */
+static __always_inline __u32 hist_bucket(__u64 ns)
+{
+	if (ns < 1000)
+		return 0;
+	if (ns < 100000)
+		return 1;
+	if (ns < 1000000)
+		return 2 + (ns - 100000) / 100000;
+	if (ns < 10000000)
+		return 11;
+	if (ns < 100000000)
+		return 12 + (ns - 10000000) / 10000000;
+	if (ns < 250000000)
+		return 21 + (ns - 100000000) / 50000000;
+	if (ns < 1000000000)
+		return 24 + (ns - 250000000) / 250000000;
+	return 27;
+}
+
+static __always_inline void conctest_record(int stat_id, __s64 ret, bool ctx_adjust)
+{
+	__u64 raw, higher_ns, duration_ns;
+	struct conctest_op_state *state;
+	struct conctest_op_stats *stats;
+	struct ctx_time *ct;
+	enum ctx_level level;
+	__u32 bucket;
+	int key = 0;
+
+	ct = bpf_map_lookup_elem(&ctx_time_map, &key);
+	if (!ct)
+		return;
+
+	level = get_ctx_level();
+	raw = bpf_ktime_get_ns() - ct->start_ns[level];
+
+	if (ctx_adjust) {
+		higher_ns = ctx_higher_sum(ct, level) - ct->snapshot[level];
+		duration_ns = raw > higher_ns ? raw - higher_ns : 0;
+
+		ct->accumulated_ns[level] += raw;
+	} else {
+		duration_ns = raw;
+	}
+
+	stats = bpf_map_lookup_elem(&perf_map, &stat_id);
+	if (!stats)
+		return;
+
+	state = bpf_map_lookup_elem(&state_map, &stat_id);
+	if (!state)
+		return;
+
+	if (stats->count == 0 || duration_ns < stats->min_ns)
+		stats->min_ns = duration_ns;
+	if (duration_ns > stats->max_ns)
+		stats->max_ns = duration_ns;
+
+	stats->count++;
+	stats->total_ns += duration_ns;
+
+	bucket = hist_bucket(duration_ns);
+	if (bucket < CONCTEST_HIST_BUCKETS)
+		stats->hist[bucket]++;
+
+	if (ret == 0) {
+		stats->success++;
+	} else if (ret == state->expect_ret) {
+		stats->failure++;
+	} else {
+		stats->failure++;
+		stats->unexpected++;
+		if (!cmpxchg(&state->failed_print_once, 0, 1)) {
+			bpf_stream_printk(BPF_STDOUT,
+					  "UNEXPECTED ERROR: stat %d expected %lld got %lld\n",
+					  stat_id, state->expect_ret, ret);
+			bpf_stream_print_stack(BPF_STDOUT);
+		}
+	}
+
+	u64 delay_thresh_ns = state->delay_thresh_ns;
+	if (!delay_thresh_ns)
+		delay_thresh_ns = 10000000; /* 10ms */
+	if (delay_thresh_ns && duration_ns > delay_thresh_ns && !cmpxchg(&state->delay_print_once, 0, 1)) {
+		const char *unit = duration_ns >= 1000000 ? "ms" : "ns";
+		bpf_stream_printk(BPF_STDOUT,
+				  "DELAY EXCEEDED: stat %d duration %llu %s > threshold %llu %s\n",
+				  stat_id, duration_ns / 1000000, unit, delay_thresh_ns / 1000000,
+				  unit);
+		bpf_stream_print_stack(BPF_STDOUT);
+	}
+}
+
+static __always_inline void bpf_udelay(__u32 us)
+{
+	__u64 target = bpf_ktime_get_ns() + (__u64)us * 1000;
+
+	while (bpf_ktime_get_ns() < target && can_loop)
+		;
+}
+
+struct lock_val {
+	struct bpf_res_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, int);
+	__type(value, struct lock_val);
+} lock_map SEC(".maps");
+
+SEC("?syscall")
+int conctest_rqspinlock_task(void *ctx)
+{
+	struct lock_val *e;
+	__u32 key;
+	int ret;
+
+	key = bpf_get_smp_processor_id();
+	key %= (__u32)nr_cpus;
+	e = bpf_map_lookup_elem(&lock_map, &key);
+	if (!e)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_res_spin_lock(&e->lock);
+	if (ret == 0) {
+		bpf_udelay(delay_seed);
+		bpf_res_spin_unlock(&e->lock);
+	}
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+
+	return 0;
+}
+
+static int __conctest_rqspinlock_nmi(int start)
+{
+	struct lock_val *e;
+	__u32 key = start;
+	int ret;
+
+	key += bpf_get_smp_processor_id();
+	key %= (__u32)nr_cpus;
+	e = bpf_map_lookup_elem(&lock_map, &key);
+	if (!e)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_res_spin_lock(&e->lock);
+	if (ret == 0)
+		bpf_res_spin_unlock(&e->lock);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_rqspinlock_nmi(void *ctx)
+{
+	return __conctest_rqspinlock_nmi(0);
+}
+
+SEC("?perf_event")
+int conctest_rqspinlock_nmi_shift(void *ctx)
+{
+	return __conctest_rqspinlock_nmi(1);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3

