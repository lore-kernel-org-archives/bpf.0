Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26063F9264
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061576; cv=none; b=SkKYcBm2ERXxfYU4zgxmbZgJK/zR3ohGiQHOtwobOaRLRovc8rVvx+EobVM77YKHIABXeZ29gLGu9Zx485UlcVjjH3umLHOD9LbObWX30tKE3v8Kp4vqGhx4jCCZ86OUMrZmSEsBudkdtEWYJO9LOeB5iNFybrHpj54io7ZlAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061576; c=relaxed/simple;
	bh=nSVguYsya202ycWnyh7LvZPegeG4xaW8+imMMxZ/vE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhyjv1AeTwPKEt6Ee43FxlJSQJXbyuK8LLLpyoiQowWnVfaXNwe0Zl7qD5mlawsqIY6Ow/8fjxwB8/PLABBPNAykQPxWRJiyFVmbTAlHJfpQG9A+f7PPFgRjBIqJXlYXqW/C6ozlg0yYZzKDstT6Hf7yM8PE0dq/wPZ5oOll7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgBTw7oO; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgBTw7oO"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0d37dc4so2258632a34.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061566; x=1790666366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bmJ/GHOMUIczVGv6/n/Tv9sle3osoP7bDLoj2krszHI=;
        b=dgBTw7oOZA23iu4wXb7qc/iD57xlTBLOTnDzQWVURula1HwG6p5EQduJNQIXzl7YJc
         Ave/P23fsz37IQNzCh9t3rX5+5GWoJI+aK/+fatBoEyzEv5qIHvb3A+WtFhNCJjeNC/P
         +OJjW7gNfc9ZRKiLB/LCtlXPnjD2f/Do32yTCDW/JIzZ6QFJXyjPI1exhc7olfnl9KvB
         WTEf+OFmT2cMlABlHST/PkgwxvEcee2spbwA42UUoYjUR8o10yRagEvX7j1LreB60t1g
         APdqo+GYj8oGQaBbLdetZHcl9/0YxmI2UToVFu54S7bAgbJFeVIIJeDyBDgQCM34dG7k
         YyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061566; x=1790666366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmJ/GHOMUIczVGv6/n/Tv9sle3osoP7bDLoj2krszHI=;
        b=BYTBlQgAcilqxTC/44Ii86OplbW3EMpBtt94E2NLJVU0kzDGrGx+qVvFksjb2kBOdb
         ogtc51l69gZrootlocWDIhRxvdQwLhkn1CiKDe+/7EfNH89Lctu/jvbl6nboTnd1Ef+6
         vpRsl0vklLDD4W135kVY0Ulc+Wxfq5BFX/CAN6f/4zHjPyW8GySuhFkc8uRMK3S649jY
         OcJE6/V0V/FQ5mtq6rFMz2itn2NrKTv+21obFdTeVUphXO/fDYz7QZifc47VyzIfmF1s
         Mkpsr8soj104SeQLuTyvWmhypWqUX857GTjnqjXxCfrF5+xVVO7Npnqw0wjLpyxNGz2Z
         17CA==
X-Forwarded-Encrypted: i=1; AKwUvBzz+8QtQ6lJE8MRUvJ+e+0GL1d9Xpc3dyw+p4ja6ppnW/QviGEGSJf/a52i6fZ9/N2udUo=@vger.kernel.org
X-Gm-Message-State: AFuF++lhvRoyqw9UTOMOSTcbNCdIocQSmeNA0aGcxGoZQTct87Rn2ejx
	rZJ7PYnJALgloV9DThznCSEduBCBHg4mmNnnyetIbc7Ph1eA3jptFXT7
X-Gm-Gg: AYBFou3cd/zLs7gbd/kEqMoaSfKiBNQNC3zqKSm7DzCQu8T/4+lYvgS+xxZPayhQ10e
	DH4Eubic9GIwqcUNOAULdvF6M6CYOahgKXiw9G4KXxWNib011BpLzUyDJbn0pXy68cN03hOQlA4
	9cdajjpWE2vRHXCIyzIQrrKUESF/7ZbHgnljSuum9EWssTfTEpQVjGbeXFueidybG/CLvapRQod
	zzGQdoa3KNWr7KFwzHitqzGVCFN5o629LfC18SFBfUa0gxmX4wNOlESfjm2fh+lrGgtcojGVe9Y
	aOX1rNxvLBrMiOtAGsboS84FGW0APDIgHgmD+n+5KT/BCX01JRLUBHIWX+QT9oKrNaVGWhLc2Su
	uvQ3X2D6QPaaKfFiB4Q7QWJpKR3SV9BxG31i/KQ+tW6Ke6DY4EI8ofSdw9hdMwjTUnCCpj3CGoN
	cFqf+gaQ79CSkmRgguRJZ/pTUD0+qrQCKs+WuhwNP3YMkf3JFCJrdn2r8APyGe2R6G0NnfaKeP4
	hFAwSaYhZ7x6zlPT8No3dVcASut1b88xXt1kkUSpuSY9VjLSHSM+1aEyN8TF3UpzveTBbhwL2lG
	vgQT/JjS5X7WxLPA/mk=
X-Received: by 2002:a05:6830:640c:b0:806:14ab:a7b0 with SMTP id 46e09a7af769-80de34e4a1dmr15923768a34.30.1790061566127;
        Tue, 22 Sep 2026 00:19:26 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-814e598483esm1116801a34.5.2026.09.22.00.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:19:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 01:19:19 -0600
Subject: [PATCH v2 1/3] kallsyms: Add test_kallsyms_perf module to
 benchmark lookup latency
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v2-1-a333ee31eac7@gmail.com>
References: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790061561; l=9420;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=nSVguYsya202ycWnyh7LvZPegeG4xaW8+imMMxZ/vE0=;
 b=M40Tnq70kMCwXYdnlB38866DboPA2ZN1I1tZZ7qIKK8ql+u+rH/AbB7QCS0H1W+kD8zV6zlPb
 TS5W3545ZXRAQ91WdTj+rDYBi6+CJ2Rv8uUUNPYcqWeLSnNnFFr6HWx
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

To evaluate optimizations and measure performance regressions across
kallsyms lookups, add a lightweight microbenchmark module in lib/.

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
 kernel/kallsyms.c        |   2 +
 lib/Kconfig.debug        |  10 +++
 lib/Makefile             |   1 +
 lib/test_kallsyms_perf.c | 228 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aec2f06858af..b9e573e9a10b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -261,6 +261,7 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kallsyms_on_each_symbol);
 
 int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 				  const char *name, void *data)
@@ -279,6 +280,7 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kallsyms_on_each_match_symbol);
 
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..2a8b1aaee23b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3122,6 +3122,16 @@ config TEST_STATIC_KEYS
 
 	  If unsure, say N.
 
+config TEST_KALLSYMS_PERF
+	tristate "kallsyms performance benchmark test module"
+	default m
+	help
+	  This builds the test_kallsyms_perf module to benchmark latency
+	  across Name-to-Address binary search, Address-to-Name resolution,
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
index 000000000000..c649e55dae3b
--- /dev/null
+++ b/lib/test_kallsyms_perf.c
@@ -0,0 +1,228 @@
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
+	"tcp_v4_rcv",
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
+		kallsyms_on_each_match_symbol(match_cb, sym, &addr);
+		OPTIMIZER_HIDE_VAR(addr);
+	}
+	t1 = ktime_get_ns();
+	dt_miss = t1 - t0;
+
+	pr_info("Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
+		dt_hit / num_iters, dt_hit / 1000000, num_iters);
+	pr_info("Name Search Miss: %llu ns/lookup (%llu ms total, %u iters)\n",
+		dt_miss / num_iters, dt_miss / 1000000, num_iters);
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
+		sprint_symbol_no_offset(symname, addr);
+		barrier_data(symname);
+	}
+	t1 = ktime_get_ns();
+	dt_bldid = t1 - t0;
+
+	pr_info("sprint_symbol:           %llu ns/lookup (%llu ms total, %u iters)\n",
+		dt_sprint / num_iters, dt_sprint / 1000000, num_iters);
+	pr_info("sprint_symbol_no_offset: %llu ns/lookup (%llu ms total, %u iters)\n",
+		dt_bldid / num_iters, dt_bldid / 1000000, num_iters);
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
+	pr_info("Table Full Walk:  %llu us/pass (%lu symbols scanned, %d passes)\n",
+		(dt_walk / iter) / 1000, total_symbols, iter);
+}
+
+static int run_kallsyms_benchmark(void)
+{
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
+
+static void __exit test_kallsyms_exit(void)
+{
+	pr_info("test_kallsyms module unloaded\n");
+}
+
+module_init(test_kallsyms_init);
+module_exit(test_kallsyms_exit);
+
+MODULE_DESCRIPTION("Microbenchmark test module for kallsyms subsystem");
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_LICENSE("GPL");

-- 
2.55.0

