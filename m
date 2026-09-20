Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18923CB550
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876747; cv=none; b=d707Kfvy9S6+ZHpBps72MNYxksG+sjwR2TM8lE7Z5cpj4JJnEC+JsAtGa4M++tGZ3Nb3lAJTsQhNA+s215uUt1yYDMcdzVxmELxhJn2aaB07Dw3KNQrImNRoxGpl41YIGzI2Jt0v2ajjM4xGnlKPNZoIwzbjl4CJm4dcINn6rrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876747; c=relaxed/simple;
	bh=nSVguYsya202ycWnyh7LvZPegeG4xaW8+imMMxZ/vE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1gxqugdh+SHXDvM85AkoXDFsL3gBPT2qQfAfgj/Xd2+sBYMddwLNRqEUboXuowxOHgwILJOx1icPTZgBmgXGCtEvJ3ibFn0ZyzYrqEFzT+RYm5arBeMmAudC/XElZ9CD3STFP3ug4YDwvVjO4aCNTyFGynTIv5Tx7MO0nnNVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqwa5UZL; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqwa5UZL"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccdd76a9so1724639fac.0
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789876743; x=1790481543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bmJ/GHOMUIczVGv6/n/Tv9sle3osoP7bDLoj2krszHI=;
        b=hqwa5UZLRCNHzZPVYLStvFu8dHDLkRsCWq65YsbiqxXREAZjGmYK+gz9pMIQLyPwc0
         8NEXtSWWYhCZdPG3H2cct89bsGH16hAzGntucqMXA9mckqDgUUZV42M5yU74bqjA/bd0
         4NqfxVGZAOnkqTbduKuwL5BuxsQyKzidznAY/ai1ktiutvsknwOfribdjh9amVno8Rsv
         zjbE2trv82OdWpVvzYjjy0FmGZGfCLj2IC0RmibxXY7kOR4Y6Kli1YeuIF111Ujr+V22
         oBopSQFuxZXzPzTQUjFlZRAgFEZs+wiN5bO2qVKTXS0KlgitNQDIvY5ybT6to0fnB0Zi
         rDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789876743; x=1790481543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmJ/GHOMUIczVGv6/n/Tv9sle3osoP7bDLoj2krszHI=;
        b=h33jkZ4+s3HnDtA0YCB9X0gMTbFkU2q+nHQpNpTdJkK/3GKl/oLbeUzxc0WaLDRAWe
         SY+ejwHDb6fAqKUxt07YjP2cyMJaKXto1q/kqO+qkrDxAWnAXEiHh6FNREgQaFgGDNuf
         tSXKbHQ/pw21qKbk/yjAj4qAJ6nCEUe0WCtmbpadyxcBwi592vekUho5OkuYTZyMpBMC
         IqpgfTYXSjjKFQKfq5Ad33yQWO1MSnmuPZA/sndofMdZzSsD/DzBf+pqH59c15x8Regd
         iQgiYWLaJ/1lC0LmrCHjAkQEs109mQD8q5aKKjHxa4fTuSWlGVe37cWib5Cr+nBQyPAj
         p6Mw==
X-Forwarded-Encrypted: i=1; AKwUvBxf+aRA0ks/9o2Uayk7YULrpgoo7o3QDwCZRA9u3GfCpqMSMwY9PfGkI0UGvuK+q6t8MUg=@vger.kernel.org
X-Gm-Message-State: AFuF++nK+G/uzdKvxbG7zD31dlcahtVH7cvJ7K1BZqEUne0QE45VQw5i
	l90jlg+bWaKIq7wex4Az5kN1rlinY7/Jwstj9OPw5sW9TOQN+pBEA+8d
X-Gm-Gg: AYBFou3tVuD3gpW75+tnUlcHuuBrXEo6K0eDbxtdI8FWZF6AGNW0x5jtQFZREyqVPB0
	6q+4102PHUglrOoi56vu+rx3XkiOEgFjIHdf9zvGUxux2xxyvUPeQcsMj3U/pL8aHaaINT2Wsct
	PbbNNuHuBgN50yB1gsWdCzgmZkxKmd2tD/HH4W1VYCeW2fQQMQcJcTpli5JTrEc0ejdZ3bEmGqR
	IpYhWVta9BgcMKwnkIOb57enfloqFlvCKLCS6iDtI5Wl7lytirl4ARYH8TP/TQvEQfDn7ZSho2Z
	5Yss1K/xF3qf2ARjCoxv8JcHd1iQS+dypPr0+BYxlivLSpvNwq3heAW7JkYxrJUGTvevlT9cugT
	acnoPKkYgIg71ihUASMz1Zprx9/dihsVhWQcU8w3ciOc0wRLcV7SLboZwm1feZsLpo0LXQVD8aq
	gf5ZG616aKI1fdmXgCz2YbP18lD/xNq8zaYUjass70E9oJHsNFu12iTUb7awumsCcvIRNULBDMN
	w7bVRI0vr+jqn9ZCFKg+fa0PcO/pZruuSL09ZRp0q9NoDCVfdXiOAe+dp3xJulwr9bYDXjAiJ4R
	kUaH639sRC8GfkBl1oOp
X-Received: by 2002:a05:6820:1c9a:b0:6cd:3fdc:a933 with SMTP id 006d021491bc7-6cd3fecc3e5mr3449090eaf.80.1789876743558;
        Sat, 19 Sep 2026 20:59:03 -0700 (PDT)
Received: from [192.168.0.197] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm4146915fac.1.2026.09.19.20.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 20:59:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 19 Sep 2026 21:58:55 -0600
Subject: [PATCH 1/3] kallsyms: Add test_kallsyms_perf module to benchmark
 lookup latency
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-ksyms-tune-v1-1-d85c97da1a32@gmail.com>
References: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>
In-Reply-To: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789876740; l=9420;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=nSVguYsya202ycWnyh7LvZPegeG4xaW8+imMMxZ/vE0=;
 b=a7B9miUPH8gTO/u2Uk31hK0exxzWkLBwVe5iAlQATS4u4hLAGfj1phiyt7a60rP7m6PxAYp+R
 GLR8d9sBTB+ANEnD36U56DdWK3Ujl/PicYimkjnIEGlfpuf5uQhievV
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

