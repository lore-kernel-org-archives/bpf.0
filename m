Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2032E7F39
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102773; cv=none; b=gvKZyZ2fao/XNhpCelEkWSzR8MuAOdLxmOc/dTsw6n8Yr5AoO88Iy6X93I21BKYy2bV+jTemBcIJQ5QocZwxOLEQWS1DdjobGIwXyuIMvuGityHQ7BCSl5yBjjFLXaogFmy6FPLnXKYpsug7St+amrLKsQ5E8AmVYS/0WdhHa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102773; c=relaxed/simple;
	bh=wMu9e2ocAIssLOg8yDp9YiXF/7/EC3BwAFjUqD8eS08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBbgrVxesfihEXKbbiE3k+hY7rOKNHTtFTkbI1pYPyszgCvmPpK6p0faEtpN7jFM2PGFB2wOPkmXeww0JhHt4ePziTi1Qi7EwPSZ33manG4Hnki2YKBIT6suZect/Rcv1ddhiwdsxXm9Etsmc3UNht1F+na9tbVeqHT+a+mXSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny3lPyLs; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny3lPyLs"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2c0356so157401b6e.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790102764; x=1790707564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GUJfe26E2BoMxoZiIjfByPcanmFJtFYPWZqrgkocTRg=;
        b=Ny3lPyLsaOCDGV+uc4qfWUtwEnIWV3WOES+T8UkwcEPdhBdGo3ALdmqC+1O19A99fA
         +nEH2ant3HW0FfdUgrHWZMAnpGtEQTP40pBLaYWpGHA9p9NJXEoMwvsXQOtWx54U/Bii
         MGfCPnu1oUXJk2wilHdvklBwnsXdF8fsywS2wavRzEe1/umHTFtmC+UgfRseuuZDA5X8
         e5uihT0EmhFDTjEZk8bKs4I7NlgmDuVWf4Rnb9kw/nZSJHEN3CA47E1uR3COyJ5nNGY7
         Dd7Gnurdd6VJVizHAPwcJHx4oAAvwNirP7mEBMgi6grRQ2UAJVHl6EjVCtAGzr17yjza
         vq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102764; x=1790707564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GUJfe26E2BoMxoZiIjfByPcanmFJtFYPWZqrgkocTRg=;
        b=RDA+P8lbRPI8XZOiUystvXJpROWhCPD79i61VEY6SH4D66SEMU005SVnCvOmeHT1Z8
         YCoAkDdWA2qfHlLqa9wQPQG+aIlx6Hr/CbfN++2/gm79JLQsYpg299IYg0tu4KvLNe5J
         Mo675bZjacsYo2vqbJNug0zULsBKkl2vvVbPap+II4RFiC3LEX6Pt/0rrk40XkaAc/LQ
         E8CFdorattZ+oFU7DJT91mJDnKM7ajR7vC50f/dlZ4o/BS2JFKZcyFrGB//R6XLFSuMz
         AvLaiHXTm5wNVb3v/rgBnWN1Fia0vAHb+XfbX6ju7ZPeYMi29KsfQfgzO/RigkjX5KO+
         LoqA==
X-Forwarded-Encrypted: i=1; AKwUvBxiI49SxkBkXXl2dz/P2rhzKMVMtz8hfyhzjZrMMN3zxmN2ehNrEF5RXq9Csklf22ehMnU=@vger.kernel.org
X-Gm-Message-State: AFuF++lSRVpddeFtPlBYa4ExKLwr3ZEoZmw8ZKq42vV+BDCEa74NfqHp
	ZShlT7kmoLW51I847QCrmMrKbVeodCVuAfp5kp3utlIQLpw8kqLv2cmc
X-Gm-Gg: AYBFou11Bp5S3lQX6YH1HbWkzGCC6jB8YJ1YXDF1RHDJiyVpkE1M4aBK5bFc6PF+h/F
	lJqfiCKi8rMkL4jZpcKZlYSQtuKKIZfUwGrfZYPFCi/l5OQjdY/5t1e28TibMJqpYjswyVTgyYq
	iM0GLwxWfBEEKp+FOSTTWj7a7Nch72chq8Lpy30niU+Zs0WoSBBv8MkzbiciHWp4iRrqXnTzKWp
	f50CZJ/fZZEqgdZoEBWxhY6CGVe4sNM9vHO6xOMZamZ0LparZONsM7hFRZ/LvoiLIxG2oYt23gz
	Khnu1OouJOM5VfKZnLsuvQfe3u+Pgk56VM5FSlCQBVeBMOxKFjKy1EBGy6WIWCZnuZ/XSPII3YD
	1j42Cmk40iIh9CHpaAtsA4WQdfZRLlb1g7SjGQ8WBD8VxhVAc4/mOGZp+CDcoLmYJNRzF8bnD+j
	rEQDEATxCwSNrLyS2FkaeuSaUtf26HUm5rCP2XsUoc7XmeOnNHFSXVKVm3PgRbd6XChjkBMo0Wy
	iJj+zxlsOSVU6GRD//YT4y38TPttg0ar9IiEiwR/TslxP3gc9jZjndb7dZ3bJ82LOnE0fQ5U9Pe
	Sd50zyCtIlu8Rlx1eLY=
X-Received: by 2002:a05:6808:3c4e:b0:4bd:c9fa:b1b1 with SMTP id 5614622812f47-4d5b940da4fmr263959b6e.40.1790102764236;
        Tue, 22 Sep 2026 11:46:04 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4d5c43a24bbsm147545b6e.7.2026.09.22.11.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:46:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 12:45:55 -0600
Subject: [PATCH v3 1/4] kallsyms: Add test_kallsyms_perf module to
 benchmark lookup latency
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v3-1-681a34ea05d9@gmail.com>
References: <20260922-ksyms-tune-v3-0-681a34ea05d9@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v3-0-681a34ea05d9@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790102761; l=9990;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=wMu9e2ocAIssLOg8yDp9YiXF/7/EC3BwAFjUqD8eS08=;
 b=woZjuWDZnG/RH2ZnaizqyzADKXsGtbr+LDFN10w9+WJn0UpEFO+GTOu+gyrx+3b85W5vdhiVK
 kiI5f9jNsuICBkgh/omz/HgL1/3ssbu/2DhT+htkq4kieHAIxJdiM4s
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
 lib/test_kallsyms_perf.c | 241 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)

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
index 000000000000..4d0c39c0a94f
--- /dev/null
+++ b/lib/test_kallsyms_perf.c
@@ -0,0 +1,241 @@
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
+
+static unsigned int num_iters = 100000;
+module_param(num_iters, uint, 0644);
+MODULE_PARM_DESC(num_iters, "Number of iterations per microbenchmark");
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
+static void run_name_lookup_bench(void)
+{
+	u64 t0, t1, dt_hit, dt_miss;
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
+	t0 = ktime_get_ns();
+	for (i = 0; i < num_iters; i++) {
+		const char *sym = hit_symbols[i % nr_hits];
+
+		if (unlikely(!(i & 0x3fff)))
+			cond_resched();
+
+		kallsyms_on_each_match_symbol(match_cb, sym, &addr);
+		OPTIMIZER_HIDE_VAR(addr);
+	}
+	t1 = ktime_get_ns();
+	dt_hit = t1 - t0;
+
+	/* 2. Name search: Non-existent symbols (Misses - 17 bsearch probes) */
+	t0 = ktime_get_ns();
+	for (i = 0; i < num_iters; i++) {
+		const char *sym = miss_symbols[i % nr_misses];
+
+		if (unlikely(!(i & 0x3fff)))
+			cond_resched();
+
+		kallsyms_on_each_match_symbol(match_cb, sym, &addr);
+		OPTIMIZER_HIDE_VAR(addr);
+	}
+	t1 = ktime_get_ns();
+	dt_miss = t1 - t0;
+
+	pr_info("Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
+		div_u64(dt_hit, num_iters), div_u64(dt_hit, 1000000), num_iters);
+	pr_info("Name Search Miss: %llu ns/lookup (%llu ms total, %u iters)\n",
+		div_u64(dt_miss, num_iters), div_u64(dt_miss, 1000000), num_iters);
+}
+
+static void run_address_lookup_bench(void)
+{
+	u64 t0, t1, dt_sprint, dt_bldid;
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
+	t0 = ktime_get_ns();
+	for (i = 0; i < num_iters; i++) {
+		unsigned long addr = addrs[i % nr_addrs];
+
+		if (unlikely(!(i & 0x3fff)))
+			cond_resched();
+
+		sprint_symbol(symname, addr);
+		barrier_data(symname);
+	}
+	t1 = ktime_get_ns();
+	dt_sprint = t1 - t0;
+
+	/* 2. Address without offset (sprint_symbol_no_offset) */
+	t0 = ktime_get_ns();
+	for (i = 0; i < num_iters; i++) {
+		unsigned long addr = addrs[i % nr_addrs];
+
+		if (unlikely(!(i & 0x3fff)))
+			cond_resched();
+
+		sprint_symbol_no_offset(symname, addr);
+		barrier_data(symname);
+	}
+	t1 = ktime_get_ns();
+	dt_bldid = t1 - t0;
+
+	pr_info("sprint_symbol:           %llu ns/lookup (%llu ms total, %u iters)\n",
+		div_u64(dt_sprint, num_iters), div_u64(dt_sprint, 1000000), num_iters);
+	pr_info("sprint_symbol_no_offset: %llu ns/lookup (%llu ms total, %u iters)\n",
+		div_u64(dt_bldid, num_iters), div_u64(dt_bldid, 1000000), num_iters);
+}
+
+static void run_table_walk_bench(void)
+{
+	u64 t0, t1, dt_walk;
+	unsigned long total_symbols = 0;
+	int iter = 50;
+	int i;
+
+	t0 = ktime_get_ns();
+	for (i = 0; i < iter; i++) {
+		total_symbols = 0;
+		kallsyms_on_each_symbol(count_cb, &total_symbols);
+	}
+	t1 = ktime_get_ns();
+	dt_walk = t1 - t0;
+
+	pr_info("Table Full Walk:  %llu ns/sym (%llu us/pass, %lu symbols scanned, %d passes)\n",
+		div_u64(div_u64(dt_walk, iter), total_symbols ? total_symbols : 1),
+		div_u64(div_u64(dt_walk, iter), 1000), total_symbols, iter);
+}
+
+static int run_kallsyms_benchmark(void)
+{
+	if (!num_iters) {
+		pr_err("num_iters must be non-zero\n");
+		return -EINVAL;
+	}
+
+	pr_info("==================================================\n");
+	pr_info("Starting kallsyms performance benchmark (iters=%u)\n", num_iters);
+	pr_info("==================================================\n");
+
+	run_name_lookup_bench();
+	run_address_lookup_bench();
+	run_table_walk_bench();
+
+	pr_info("==================================================\n");
+	pr_info("kallsyms benchmark complete\n");
+	pr_info("==================================================\n");
+
+	return 0;
+}
+
+static int param_set_trigger(const char *val, const struct kernel_param *kp)
+{
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
+	return run_kallsyms_benchmark();
+}
+late_initcall(test_kallsyms_init);
+
+MODULE_DESCRIPTION("Microbenchmark test module for kallsyms subsystem");
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_LICENSE("GPL");

-- 
2.55.0

