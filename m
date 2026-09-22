Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7BF39A80E
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107725; cv=none; b=sMLtVFhyJgd56Rif1k9Cxz0cQcwgPfPLJxX0Mkd5YHSXhsD8Bhe3PgyYJ/o20XWmTBKTqlZXvTz2GZ0HVRNepS/HzAzvXQmPFRwfmF91nxwb6O2uFP/1h3xiQ4wVSfZMxYA3BB2dD7J4SPGshxzh6667ULW674QP3EdKZkwJNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107725; c=relaxed/simple;
	bh=oV2R0UvbYfIVB77jCAXauJRFelOAEdJiPFl6JJAX4x8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0gqFjUW3y/4/IzQ3twyR9CnLQWICenV1LUG2EIFtsrnvkOMnRUD5+qi0/ilxt5CXb/QVu3+vx5rhxlZvcA3pCFGf5bCc6SU+mb0XYuHXwgKNbk5x2l4SkxKZ8eIl48TG2l8ZwaM/pze+CkOuFTNGDyN+U8ZPyQawdW9sI+eHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCRgEqE4; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCRgEqE4"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfc20so243283fac.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107707; x=1790712507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBg7HSnbebtbldS1DMZtF5kZINYwBocaor4sCHxt5Tc=;
        b=pCRgEqE4khEDpdPRa3ou3l33bl7/a+DblSU+2/H144HfKfaOlc3cPdpzVaXtD8IZfp
         tVhJ/j+UfkjmLUiCtEC9C6GwKMkEZtxhV39AW583WJQLim/fdgeTWCinUEXgBpOw5FJ/
         j0C0QXFIr2djUyp3zr64Fu0dzOESwKhp9Q8Mgml3jnbbVXBER6mYfbz9HJ9kvVvouJOc
         pUgXTRqTNy9O4uNFlg1hPhvvYTZcuWc1q9s67sldmbC0osoVi7FgDUzVKuqJvGaIrLeW
         hQC+azg+v3pgmoyvd+1LU0vw86b+rzZUhZyr2tM6liH/w1FxlT1OaEclEbAW2DMyp5Ej
         ft9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107707; x=1790712507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBg7HSnbebtbldS1DMZtF5kZINYwBocaor4sCHxt5Tc=;
        b=fUgtGUI/fdS4ROtsR5JxncuUqnoa6UnT6CGUH6KQpUY685wLUYQ0wS/VEActJKD12m
         Bbv+MJWFKnFTzYMXFKUTPzLGTMZS7XmfMNYk7AQLEhNZcJl0iFbny5+zyokVE9y0eCD7
         54KWiWCu1GAG+Z2Z1/pDw2BnaqOU6v3FryTQwF94E03xFcHu00/BizuaVMGB8L0bAOvy
         4GMhkCj0d36QexoddPNLzdAC2Vq4OFESdjyutUOXfE+B/VUoJBY6hhjBl7iSnYTIDK/l
         aepIYpy3xg8EQnH4BwQ9MOvL4RuUmdfJq4ZwRXDYgriF2e0/f1molGltGHTllL+R83ch
         kPbA==
X-Forwarded-Encrypted: i=1; AKwUvBySlgul/CLginTDzgs1NKGl3dVAmN3Y2LzZPfWc5zTFNlJ5KiGrSxq5/uAEIIB9Y2E6qt0=@vger.kernel.org
X-Gm-Message-State: AFuF++ndApnQtsfQOZFc57QKixSEKVdIV47ifml/54Xmn0UStaLBoy+f
	aDb8qpO3dT16d2aF9v1xx21rkcoza6jnXobSS6Xx5vvVeX6YYCC8JbMQ
X-Gm-Gg: AYBFou3pYIN+F6Dk7BXJa+wMv5+0BA+krADlpUSZM1M+V8PQQAmVeMnuWn6kFA8Unzu
	fvfcK2jpOSudpo5R3pS4wXbp6u99OSzBFGB6s90/msx3VgW8yEjGHSY4krO7Qk+oCxGpXRD/oz5
	8GsnMWBsE7JsNB5Cp+kLzUpzLREZjUi6bBW105dhU8YXee/tVG8PyovtnGjUzM5Fh69Wutv3EFy
	8H2ye6DCD2Q/oUrIlkkuYze8Gxup8L0hkHKkHPx/lnKcLNJDBybxDaLISfif3HQvX9FUmi+zLt1
	M+FiXUtDgCVyk6PKjeS426d6Wp8WX/1FZ7aVqcGLeWKohJ2YeLPBXhZNRs4X7c7mqOR/ubmbE9t
	AAEehNdqxWPfV4TZQqYNfXdDIrN+LpA7vWmpkzu16mzitwLSWqn+k5fPJHkN7A++NP4UTF9jG+T
	DiPHfxbAu+NC5Gzh8QvKNP9MOtwuSRUT0HvJZJaY42ea7M83D4WRBN8PtuBx8Qr4M9JgbgZoOLG
	YaK5v9qIgTSLrcElktT8aNcIHzHJuUAos4andjDnYWF9RJMxmjnYzzoGv3TNcExf3WR4MJht2Vm
	7AoWxcimqY2G5Dhi4U9bv1c9NNlj/A==
X-Received: by 2002:a05:6870:239b:b0:485:d31b:775f with SMTP id 586e51a60fabf-4908ab4a750mr780817fac.29.1790107707408;
        Tue, 22 Sep 2026 13:08:27 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4908eb9237asm564087fac.12.2026.09.22.13.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:08:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 14:08:18 -0600
Subject: [PATCH v4 1/4] kallsyms: Add test_kallsyms_perf module to
 benchmark lookup latency
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v4-1-92acea84b911@gmail.com>
References: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790107704; l=12494;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=oV2R0UvbYfIVB77jCAXauJRFelOAEdJiPFl6JJAX4x8=;
 b=4RC9VqdWCoHfhnvqxQjqjGuKtFE8tpMesrUk8A7+J44QEhTnOF5OBqOU8fJOYC7+dIna2lG1N
 ZoOQW0suFA+BWYKk4EhY44KSQ0Za8f9KWsWJtmaG2uND9w5tKqmshhW
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

To evaluate optimizations and measure performance regressions across
kallsyms lookups, add a lightweight microbenchmark module in lib/.

Configure CONFIG_TEST_KALLSYMS_PERF as a built-in test (bool) rather
than a loadable module (tristate). Building the test directly into
vmlinux allows exercising internal kallsyms traversal APIs without
exporting internal symbol iterators (EXPORT_SYMBOL_GPL) to modules,
preserving kernel symbol table encapsulation.

The module exercises the primary kallsyms resolution paths:
0. Name-to-Address binary search: Benchmarks lookups across common
   kernel functions (hits) and non-existent symbol strings (misses,
   exercising the full binary search tree depth).

1. Address-to-Name resolution: Benchmarks address decoding latency
   via sprint_symbol() and sprint_symbol_no_offset().

2. Sequential table scan: Measures complete table iteration latency
   via kallsyms_on_each_symbol().

The module exposes a num_iters parameter (default: 100,000) and a
sysfs trigger to repeat benchmark runs on demand.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v4:
- Ignore early boot invocations in param_set_trigger() when system_state
  < SYSTEM_RUNNING to prevent NULL pointer dereference in ktime_get_ns()
  prior to timekeeping_init() (addresses Sashiko AI review).
- Prevent sysfs TOCTOU divide-by-zero panic: reject num_iters == 0 in
  param setter, snapshot iters locally via READ_ONCE, and serialize runs
  with bench_lock mutex (addresses Sashiko AI review).
- Eliminate multi-second boot stall: add run_on_boot parameter (default
  false) so late_initcall only runs benchmark when explicitly requested
  (addresses Sashiko AI review).
- Chunk lookup loops in 4096-iter batches with cond_resched() outside
  the timing bracket to prevent preemption sleep time from inflating
  reported latency (addresses Sashiko AI review).

Changes in v3:
- Convert CONFIG_TEST_KALLSYMS_PERF from tristate to bool and drop
  kallsyms iterator EXPORT_SYMBOL_GPL exports to preserve security
  encapsulation (addresses Sashiko AI review).
- Drop 'default m' from lib/Kconfig.debug.
- Add cond_resched() every 16k iterations to avoid soft lockups.
- Replace direct 64-bit division with div_u64() to fix 32-bit builds.
- Guard against divide-by-zero when num_iters=0.
- Replace tcp_v4_rcv with panic in hit_symbols to prevent failures wo
  CONFIG_INET.
- Switch to late_initcall for built-in invocation.
---
 lib/Kconfig.debug        |  10 ++
 lib/Makefile             |   1 +
 lib/test_kallsyms_perf.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..4b9669e64db9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3122,6 +3122,16 @@ config TEST_STATIC_KEYS
 
 	  If unsure, say N.
 
+config TEST_KALLSYMS_PERF
+	bool "kallsyms performance benchmark test module"
+	depends on KALLSYMS
+	help
+	  This builds test_kallsyms_perf to benchmark latency across
+	  Name-to-Address binary search, Address-to-Name resolution,
+	  and full table walks.
+
+	  If unsure, say N.
+
 config TEST_DYNAMIC_DEBUG
 	tristate "Test DYNAMIC_DEBUG"
 	depends on DYNAMIC_DEBUG
diff --git a/lib/Makefile b/lib/Makefile
index dfab958327c5..149968ff3f6b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
+obj-$(CONFIG_TEST_KALLSYMS_PERF) += test_kallsyms_perf.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
diff --git a/lib/test_kallsyms_perf.c b/lib/test_kallsyms_perf.c
new file mode 100644
index 000000000000..03ff5f1d51c5
--- /dev/null
+++ b/lib/test_kallsyms_perf.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Microbenchmark and correctness test module for kallsyms subsystem
+ *
+ * Measures CPU latency across:
+ *  - Name-to-Address binary search (hits & misses)
+ *  - Address-to-Name symbol resolution (sprint_symbol, buildid)
+ *  - Full kernel symbol iteration (kallsyms_on_each_symbol)
+ */
+
+#define pr_fmt(fmt) "test_kallsyms: " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kallsyms.h>
+#include <linux/ktime.h>
+#include <linux/compiler.h>
+#include <linux/sched.h>
+#include <linux/math.h>
+#include <linux/mutex.h>
+#include <linux/minmax.h>
+
+#define BENCH_CHUNK_SIZE 4096
+
+static unsigned int num_iters = 100000;
+
+static int param_set_num_iters(const char *val, const struct kernel_param *kp)
+{
+	unsigned int n;
+	int ret;
+
+	ret = kstrtouint(val, 0, &n);
+	if (ret)
+		return ret;
+	if (!n)
+		return -EINVAL;
+
+	*((unsigned int *)kp->arg) = n;
+	return 0;
+}
+
+static const struct kernel_param_ops param_ops_num_iters = {
+	.set = param_set_num_iters,
+	.get = param_get_uint,
+};
+module_param_cb(num_iters, &param_ops_num_iters, &num_iters, 0644);
+MODULE_PARM_DESC(num_iters, "Number of iterations per microbenchmark (must be > 0)");
+
+static bool run_on_boot;
+module_param(run_on_boot, bool, 0444);
+MODULE_PARM_DESC(run_on_boot, "Run benchmark during boot (default: false)");
+
+static DEFINE_MUTEX(bench_lock);
+
+static const char * const hit_symbols[] = {
+	"_printk",
+	"schedule",
+	"vfs_read",
+	"do_sys_openat2",
+	"kernel_clone",
+	"panic",
+	"kallsyms_lookup_names",
+	"vm_area_alloc",
+};
+
+static const char * const miss_symbols[] = {
+	"nonexistent_symbol_0001",
+	"xyz_dummy_missing_symbol",
+	"__never_compiled_in_kernel",
+	"ext4_nonexistent_func_xyz",
+	"bpf_not_real_helper_stub",
+	"vfs_missing_handler_probe",
+	"tcp_v4_unimplemented_path",
+	"driver_fake_init_routine",
+};
+
+static int match_cb(void *data, unsigned long addr)
+{
+	unsigned long *out = data;
+
+	*out = addr;
+	return 1;
+}
+
+static int count_cb(void *data, const char *name, unsigned long addr)
+{
+	unsigned long *cnt = data;
+
+	(*cnt)++;
+	return 0;
+}
+
+static void run_name_lookup_bench(unsigned int iters)
+{
+	u64 t0, t1, dt_hit = 0, dt_miss = 0;
+	unsigned long addr = 0;
+	unsigned int i, nr_hits, nr_misses;
+
+	nr_hits = ARRAY_SIZE(hit_symbols);
+	nr_misses = ARRAY_SIZE(miss_symbols);
+
+	/* 0. Correctness validation */
+	for (i = 0; i < nr_hits; i++) {
+		const char *sym = hit_symbols[i];
+		unsigned long a1 = 0;
+
+		kallsyms_on_each_match_symbol(match_cb, sym, &a1);
+		if (!a1)
+			pr_err("CORRECTNESS FAILURE: hit sym '%s' not found\n", sym);
+	}
+	for (i = 0; i < nr_misses; i++) {
+		const char *sym = miss_symbols[i];
+		unsigned long a1 = 0;
+
+		kallsyms_on_each_match_symbol(match_cb, sym, &a1);
+		if (a1)
+			pr_err("CORRECTNESS FAILURE: miss sym '%s' unexpectedly found a1=%lx\n",
+			       sym, a1);
+	}
+
+	/* 1. Name search: Existing symbols (Hits) */
+	for (i = 0; i < iters; i += BENCH_CHUNK_SIZE) {
+		unsigned int chunk = min_t(unsigned int, BENCH_CHUNK_SIZE, iters - i);
+		unsigned int j;
+
+		cond_resched();
+		t0 = ktime_get_ns();
+		for (j = 0; j < chunk; j++) {
+			const char *sym = hit_symbols[(i + j) % nr_hits];
+
+			kallsyms_on_each_match_symbol(match_cb, sym, &addr);
+			OPTIMIZER_HIDE_VAR(addr);
+		}
+		t1 = ktime_get_ns();
+		dt_hit += t1 - t0;
+	}
+
+	/* 2. Name search: Non-existent symbols (Misses - 17 bsearch probes) */
+	for (i = 0; i < iters; i += BENCH_CHUNK_SIZE) {
+		unsigned int chunk = min_t(unsigned int, BENCH_CHUNK_SIZE, iters - i);
+		unsigned int j;
+
+		cond_resched();
+		t0 = ktime_get_ns();
+		for (j = 0; j < chunk; j++) {
+			const char *sym = miss_symbols[(i + j) % nr_misses];
+
+			kallsyms_on_each_match_symbol(match_cb, sym, &addr);
+			OPTIMIZER_HIDE_VAR(addr);
+		}
+		t1 = ktime_get_ns();
+		dt_miss += t1 - t0;
+	}
+
+	pr_info("Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
+		div_u64(dt_hit, iters), div_u64(dt_hit, 1000000), iters);
+	pr_info("Name Search Miss: %llu ns/lookup (%llu ms total, %u iters)\n",
+		div_u64(dt_miss, iters), div_u64(dt_miss, 1000000), iters);
+}
+
+static void run_address_lookup_bench(unsigned int iters)
+{
+	u64 t0, t1, dt_sprint = 0, dt_bldid = 0;
+	char symname[KSYM_SYMBOL_LEN];
+	unsigned long addrs[ARRAY_SIZE(hit_symbols)];
+	unsigned int i, nr_addrs = 0;
+
+	for (i = 0; i < ARRAY_SIZE(hit_symbols); i++) {
+		unsigned long addr = 0;
+
+		kallsyms_on_each_match_symbol(match_cb, hit_symbols[i], &addr);
+		if (addr)
+			addrs[nr_addrs++] = addr;
+	}
+
+	if (!nr_addrs) {
+		pr_warn("Address benchmark skipped: no test addresses resolved\n");
+		return;
+	}
+
+	/* 1. Address-to-name resolution (sprint_symbol) */
+	for (i = 0; i < iters; i += BENCH_CHUNK_SIZE) {
+		unsigned int chunk = min_t(unsigned int, BENCH_CHUNK_SIZE, iters - i);
+		unsigned int j;
+
+		cond_resched();
+		t0 = ktime_get_ns();
+		for (j = 0; j < chunk; j++) {
+			unsigned long addr = addrs[(i + j) % nr_addrs];
+
+			sprint_symbol(symname, addr);
+			barrier_data(symname);
+		}
+		t1 = ktime_get_ns();
+		dt_sprint += t1 - t0;
+	}
+
+	/* 2. Address without offset (sprint_symbol_no_offset) */
+	for (i = 0; i < iters; i += BENCH_CHUNK_SIZE) {
+		unsigned int chunk = min_t(unsigned int, BENCH_CHUNK_SIZE, iters - i);
+		unsigned int j;
+
+		cond_resched();
+		t0 = ktime_get_ns();
+		for (j = 0; j < chunk; j++) {
+			unsigned long addr = addrs[(i + j) % nr_addrs];
+
+			sprint_symbol_no_offset(symname, addr);
+			barrier_data(symname);
+		}
+		t1 = ktime_get_ns();
+		dt_bldid += t1 - t0;
+	}
+
+	pr_info("sprint_symbol:           %llu ns/lookup (%llu ms total, %u iters)\n",
+		div_u64(dt_sprint, iters), div_u64(dt_sprint, 1000000), iters);
+	pr_info("sprint_symbol_no_offset: %llu ns/lookup (%llu ms total, %u iters)\n",
+		div_u64(dt_bldid, iters), div_u64(dt_bldid, 1000000), iters);
+}
+
+static void run_table_walk_bench(void)
+{
+	u64 t0, t1, dt_walk = 0;
+	unsigned long total_symbols = 0;
+	int iter = 50;
+	int i;
+
+	for (i = 0; i < iter; i++) {
+		total_symbols = 0;
+		cond_resched();
+		t0 = ktime_get_ns();
+		kallsyms_on_each_symbol(count_cb, &total_symbols);
+		t1 = ktime_get_ns();
+		dt_walk += t1 - t0;
+	}
+
+	pr_info("Table Full Walk:  %llu ns/sym (%llu us/pass, %lu symbols scanned, %d passes)\n",
+		div_u64(div_u64(dt_walk, iter), total_symbols ? total_symbols : 1),
+		div_u64(div_u64(dt_walk, iter), 1000), total_symbols, iter);
+}
+
+static int run_kallsyms_benchmark(void)
+{
+	unsigned int iters;
+	int ret = 0;
+
+	if (!mutex_trylock(&bench_lock)) {
+		pr_warn("Benchmark already running\n");
+		return -EBUSY;
+	}
+
+	iters = READ_ONCE(num_iters);
+	if (!iters) {
+		pr_err("num_iters must be non-zero\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pr_info("==================================================\n");
+	pr_info("Starting kallsyms performance benchmark (iters=%u)\n", iters);
+	pr_info("==================================================\n");
+
+	run_name_lookup_bench(iters);
+	run_address_lookup_bench(iters);
+	run_table_walk_bench();
+
+	pr_info("==================================================\n");
+	pr_info("kallsyms benchmark complete\n");
+	pr_info("==================================================\n");
+
+out:
+	mutex_unlock(&bench_lock);
+	return ret;
+}
+
+static int param_set_trigger(const char *val, const struct kernel_param *kp)
+{
+	if (system_state < SYSTEM_RUNNING) {
+		pr_warn("Early boot run ignored; use test_kallsyms_perf.run_on_boot=1 or trigger via sysfs\n");
+		return 0;
+	}
+	return run_kallsyms_benchmark();
+}
+
+static const struct kernel_param_ops param_ops_trigger = {
+	.set = param_set_trigger,
+};
+module_param_cb(run_test, &param_ops_trigger, NULL, 0200);
+MODULE_PARM_DESC(run_test, "Write 1 to trigger kallsyms benchmark run");
+
+static int __init test_kallsyms_init(void)
+{
+	if (run_on_boot)
+		return run_kallsyms_benchmark();
+	return 0;
+}
+late_initcall(test_kallsyms_init);
+
+MODULE_DESCRIPTION("Microbenchmark test module for kallsyms subsystem");
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_LICENSE("GPL");

-- 
2.55.0

