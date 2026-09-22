Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90724F30FD
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061579; cv=none; b=EH1RounD2rVmmtGjMum5R5z5ZCda65G6W43Cieb+ZS0BtlFcaAOlt5YOpFzvVZr69U/PSF48V/KII0YZvzmYlFG/iPKUYhE0QRB851JxgTJT8WzIUYzbPPez2lRFhJmU2lGdsumyaJZten0qFCAoo1RcL8vNLpfKWjEsOXBNgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061579; c=relaxed/simple;
	bh=VXF7SFbi3SiEc8w+AaV9LOPsYv26WbWeBrNzDMs66V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SiQSxahDc3lzNKa84+TwucaHbP5LMxw3JHjaF4GplAxX6k6xsr+cfLt3H4O8lXqHsECUEBW5JzekkhV8YOx73eoaHujVua6zp4MZedZVdjul9uGHZCCIFRBV8ZNB4pYV6iB2bCpe8mkXHkUWAuw1VrCK4WtSeo1V2oWPIQUKsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvsvsc8r; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvsvsc8r"
Received: by mail-oi2-f13.google.com with SMTP id 46e09a7af769-80a71781323so1715818a34.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061568; x=1790666368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gq4+tOf8JUQD9uEs0/FCCs0grSUtXcKgbtbsmVE9gz0=;
        b=Rvsvsc8rO8CPfB4au//cdaJaOTfQ8dtdLci6KdaD9HAJ1isZk/8PJHdX/60yup9mhh
         h5a/iRKFEbzE+KDkavQGZo9V2ZkQyc/QawdDRKX27kV/aUG3MtX4Kz+g0k/8m4SUzFK3
         RN9ZZRBxxAZ4aFmq83GXTwNlgeZTYXTsOgDgtEKLNKJFqdEe6biFF8gBV5JR/3ozH12B
         dU4/+MMUh7xqa7cMdNPfDL2MzFoumdIXOydSGvw617fVS2qC3SHMQ6XA1vsWbf7+dZem
         laFpkm0M0feUZGqEpaAQMXEyvcyjpmhvdX2ri/7rPWC2q/U+v4bVVHWeRV1nUlILkNBm
         3uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061568; x=1790666368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gq4+tOf8JUQD9uEs0/FCCs0grSUtXcKgbtbsmVE9gz0=;
        b=KVhiAYsDh053WDgw10371f2cdbNR7A6D146dqPfSsziZsbvwYsCLToM527NE/rG71b
         HerYzrv2Q4eNnKGPBCh4DhmoLILAHBPQQJd64u9KqhIIdDhqRdNkY036GQ29LrKtZCaz
         QQc19OACxU8s3ebYm8U1EKzKowbHWvl2Uyo7eWpQAyYS4Fx/jnmXC1wRVhruIrzACirW
         PBX1gYUMWTHHbKBlepNivdbq6MvX9Urs7v7YaVz+mvPczSBuWXWeXvBYeVksxL7YlXlc
         fhj55xg5fK56STnwkdWlmnUAsxOxD4oq4vPRx80iKnNewvkRPNQO9sC4zP2K2awrPSeA
         jPgg==
X-Forwarded-Encrypted: i=1; AKwUvBwSkD4XEnvlnZkBGwjn7+SvX2tl5jVypFf6sY/SXvxxNzDsVjiCLB5tFnVMlSi/30eQ5s8=@vger.kernel.org
X-Gm-Message-State: AFuF++lvPJRmicjvhA7WMuKz7B4JPXzC5esZ5n83LQboRFEY1CJn9nct
	kBDa4A7ykHJACJZbOSNTnzNQPQxnO6k0vich1dO6fCsIOT1EEk8i69S/
X-Gm-Gg: AYBFou0KdoM/bAHwayWRSIt7wZrSVkpZX/mRmLEAe6hVRibUKP+78N2SEw56+YiQSza
	xV6vZ5EXk/4OYfeRHSCw4bOSuy+a4uHFeuM9qPLpc+Hu7dJGBs10zeLstscgicF4SHBZqa5uzdZ
	toxkKe32Ibwem0kJABrlUYJ7/HnVJpMtts1h99nMyt8qzwUFdOZw2XMxaQ9vMDkw+okrDKPDqDd
	ZdQwkzyACcGWg13SGcBCCuo+Apyz5pR1kr8eMijGfx2v7dWABX5Ik63DXpIvBRGet0O58dSmuJy
	upFZ7q2UplrPB/HYyfLZHhkZBoOuQjrUZ25QRIMlVHsDKsEabHOS+04jFsgPkdcosfDkBoZcQEg
	OwAIc7VB9mzTQZsl6uMBVWsInXyXT2NG4EB8aHF3S7NtKIu1assjDzY7qbkVkAGFeTkEHH1UJ6j
	4GSH2rwYxKKSts+XC5AJqJPzzzZi9UMfhmMXh6+xJsBfiZmcyfAS+4Y6hn1smNqfRObeqS2tk/1
	nJZzhdDCNls1FLFEONSJzVqvdaDcsHr1uh1fUDiwLoD0Tb27Wjge5IepeduU610HEFuTd3lDDTS
	CKr8V21Y4T0Gbv4yZJM=
X-Received: by 2002:a05:6830:412a:b0:801:6bec:ff18 with SMTP id 46e09a7af769-80ddfd6c36fmr13455911a34.2.1790061567693;
        Tue, 22 Sep 2026 00:19:27 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-814e598483esm1116801a34.5.2026.09.22.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:19:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 01:19:20 -0600
Subject: [PATCH v2 2/3] kallsyms: Add dynamic lookup index for batch
 resolution
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v2-2-a333ee31eac7@gmail.com>
References: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790061561; l=10695;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=VXF7SFbi3SiEc8w+AaV9LOPsYv26WbWeBrNzDMs66V0=;
 b=nSSlD4vheC++KE48rvYgEv2c7psFBLMZmwygyCBjYwFTuSMDlhIMJ/YxA/L/5oSXJukaB7N0+
 vwl98g/UJVUDFi02h7cMvhWvDW0sIPPliyBPmjGeZFLv8QrFkEgSy01
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

kallsyms_lookup_names() resolves symbol names to addresses using a
binary search over kallsyms_seqs_of_names[].  In baseline, each step
invokes get_symbol_offset(), which scans sequentially from the nearest
256-symbol marker in kallsyms_names[] (averaging ~128 ULEB128 header
decodes per probe, ~2,176 decodes per lookup).

During bulk symbol resolution workloads (e.g. BPF multi-kprobe / fprobe
tracing attaching across tens of thousands of functions), this linear
scan compounds into substantial kernel attach latency (~4.5 us per
lookup).  Baking a permanent direct index into .rodata accelerates
lookups but consumes hundreds of KiB of unswappable kernel image memory,
which is unjustified when bulk lookups are infrequent.

Introduce a dynamic u32 lookup index populated on demand in transient
RAM and discarded when the batch workload completes:

0. Expose kallsyms_lookup_batch_start() and kallsyms_lookup_batch_end()
   bracketed by a mutex and refcount.  On the first caller, allocate a
   flat u32 table spanning all kallsyms_num_syms entries (~736 KiB in
   transient RAM for ~184k symbols) via kvmalloc_array() and populate
   the symbol offsets via a single sequential scan in ~150 us.

1. In get_symbol_offset(), when the dynamic table is active, return
   offsets[pos] directly as an O(1) array access with 0 hops.

2. If the dynamic table is unallocated (refcount 0), fall back to the
   legacy kallsyms_markers[] scan, preserving 100% safety for oops,
   panic, NMI, and low-memory environments without any .rodata bloat.

3. Wrap kallsyms_lookup_names() in rcu_read_lock() / rcu_read_unlock()
   to ensure lockless lifetime safety against concurrent batch teardown.

4. Unroll the 3-byte shift loop in get_symbol_seq() into straight-line
   shifts.

5. Update test_kallsyms_perf to benchmark unindexed marker scans and
   the dynamic batch index side by side, reporting batch setup and
   teardown latency alongside query amortization break-even points.

Cc: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/kallsyms.h |  13 ++++++
 kernel/kallsyms.c        | 111 ++++++++++++++++++++++++++++++++++++++++++-----
 lib/test_kallsyms_perf.c |  53 +++++++++++++++++++---
 3 files changed, 161 insertions(+), 16 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index d5dd54c53ace..6e39795ac509 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -74,6 +74,10 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
 int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 				  const char *name, void *data);
 
+/* Transient dynamic lookup index bracketing */
+int kallsyms_lookup_batch_start(void);
+void kallsyms_lookup_batch_end(void);
+
 /* Lookup the address for a symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name);
 
@@ -164,6 +168,15 @@ static inline int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int kallsyms_lookup_batch_start(void)
+{
+	return 0;
+}
+
+static inline void kallsyms_lookup_batch_end(void)
+{
+}
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index b9e573e9a10b..862a6b773ac5 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -22,6 +22,9 @@
 #include <linux/sched.h>	/* for cond_resched */
 #include <linux/ctype.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/mutex.h>
+#include <linux/rcupdate.h>
 #include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
@@ -113,10 +116,10 @@ static char kallsyms_get_symbol_type(unsigned int off)
 
 
 /*
- * Find the offset on the compressed stream given and index in the
- * kallsyms array.
+ * Find the offset on the compressed stream given an index in the
+ * kallsyms array using legacy markers.
  */
-static unsigned int get_symbol_offset(unsigned long pos)
+static unsigned int get_symbol_offset_marker(unsigned long pos)
 {
 	const u8 *name;
 	int i, len;
@@ -149,6 +152,93 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	return name - kallsyms_names;
 }
 
+/*
+ * Dynamic symbol offset table.
+ * Allocated on demand during high-volume lookup batches and reclaimed after.
+ */
+static u32 *dyn_kallsyms_offsets __read_mostly;
+static DEFINE_MUTEX(dyn_kallsyms_mutex);
+static unsigned int dyn_kallsyms_refcnt;
+
+static u32 *kallsyms_build_offsets(void)
+{
+	const u8 *name = kallsyms_names;
+	u32 *offsets;
+	unsigned int i;
+
+	offsets = kvmalloc_array(kallsyms_num_syms, sizeof(u32), GFP_KERNEL);
+	if (!offsets)
+		return NULL;
+
+	for (i = 0; i < kallsyms_num_syms; i++) {
+		unsigned int len;
+		const u8 *data;
+
+		offsets[i] = name - kallsyms_names;
+		data = get_symbol_data(offsets[i], &len);
+		name = data + len;
+	}
+
+	return offsets;
+}
+
+int kallsyms_lookup_batch_start(void)
+{
+	int ret = 0;
+
+	mutex_lock(&dyn_kallsyms_mutex);
+	if (!dyn_kallsyms_refcnt) {
+		u32 *offsets = kallsyms_build_offsets();
+
+		if (!offsets) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		rcu_assign_pointer(dyn_kallsyms_offsets, offsets);
+	}
+	dyn_kallsyms_refcnt++;
+out:
+	mutex_unlock(&dyn_kallsyms_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kallsyms_lookup_batch_start);
+
+void kallsyms_lookup_batch_end(void)
+{
+	u32 *offsets = NULL;
+
+	mutex_lock(&dyn_kallsyms_mutex);
+	if (WARN_ON(!dyn_kallsyms_refcnt))
+		goto out;
+
+	if (--dyn_kallsyms_refcnt == 0) {
+		offsets = dyn_kallsyms_offsets;
+		rcu_assign_pointer(dyn_kallsyms_offsets, NULL);
+	}
+out:
+	mutex_unlock(&dyn_kallsyms_mutex);
+
+	if (offsets) {
+		synchronize_rcu();
+		kvfree(offsets);
+	}
+}
+EXPORT_SYMBOL_GPL(kallsyms_lookup_batch_end);
+
+/*
+ * Find the offset on the compressed table given an index in the
+ * kallsyms array.
+ */
+static inline unsigned int get_symbol_offset(unsigned long pos)
+{
+	u32 *offsets = rcu_dereference_raw(dyn_kallsyms_offsets);
+
+	if (offsets)
+		return offsets[pos];
+
+	return get_symbol_offset_marker(pos);
+}
+
 unsigned long kallsyms_sym_address(int idx)
 {
 	/* non-relocatable 32-bit kernels just embed the value directly */
@@ -157,14 +247,11 @@ unsigned long kallsyms_sym_address(int idx)
 	return (unsigned long)offset_to_ptr(kallsyms_offsets + idx);
 }
 
-static unsigned int get_symbol_seq(int index)
+static inline unsigned int get_symbol_seq(int index)
 {
-	unsigned int i, seq = 0;
+	const u8 *p = &kallsyms_seqs_of_names[3 * index];
 
-	for (i = 0; i < 3; i++)
-		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
-
-	return seq;
+	return (p[0] << 16) | (p[1] << 8) | p[2];
 }
 
 static int kallsyms_lookup_names(const char *name,
@@ -179,6 +266,7 @@ static int kallsyms_lookup_names(const char *name,
 	low = 0;
 	high = kallsyms_num_syms - 1;
 
+	rcu_read_lock();
 	while (low <= high) {
 		mid = low + (high - low) / 2;
 		seq = get_symbol_seq(mid);
@@ -193,8 +281,10 @@ static int kallsyms_lookup_names(const char *name,
 			break;
 	}
 
-	if (low > high)
+	if (low > high) {
+		rcu_read_unlock();
 		return -ESRCH;
+	}
 
 	low = mid;
 	while (low) {
@@ -219,6 +309,7 @@ static int kallsyms_lookup_names(const char *name,
 		}
 		*end = high;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/lib/test_kallsyms_perf.c b/lib/test_kallsyms_perf.c
index c649e55dae3b..df7ee96bdafa 100644
--- a/lib/test_kallsyms_perf.c
+++ b/lib/test_kallsyms_perf.c
@@ -16,6 +16,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ktime.h>
 #include <linux/compiler.h>
+#include <linux/math.h>
 
 static unsigned int num_iters = 100000;
 module_param(num_iters, uint, 0644);
@@ -59,7 +60,7 @@ static int count_cb(void *data, const char *name, unsigned long addr)
 	return 0;
 }
 
-static void run_name_lookup_bench(void)
+static void run_name_lookup_bench(const char *mode, u64 *avg_hit_ns, u64 *avg_miss_ns)
 {
 	u64 t0, t1, dt_hit, dt_miss;
 	unsigned long addr = 0;
@@ -109,10 +110,15 @@ static void run_name_lookup_bench(void)
 	t1 = ktime_get_ns();
 	dt_miss = t1 - t0;
 
-	pr_info("Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
-		dt_hit / num_iters, dt_hit / 1000000, num_iters);
-	pr_info("Name Search Miss: %llu ns/lookup (%llu ms total, %u iters)\n",
-		dt_miss / num_iters, dt_miss / 1000000, num_iters);
+	if (avg_hit_ns)
+		*avg_hit_ns = div_u64(dt_hit, num_iters);
+	if (avg_miss_ns)
+		*avg_miss_ns = div_u64(dt_miss, num_iters);
+
+	pr_info("[%s] Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
+		mode, div_u64(dt_hit, num_iters), div_u64(dt_hit, 1000000), num_iters);
+	pr_info("[%s] Name Search Miss: %llu ns/lookup (%llu ms total, %u iters)\n",
+		mode, div_u64(dt_miss, num_iters), div_u64(dt_miss, 1000000), num_iters);
 }
 
 static void run_address_lookup_bench(void)
@@ -184,11 +190,46 @@ static void run_table_walk_bench(void)
 
 static int run_kallsyms_benchmark(void)
 {
+	u64 unindexed_hit = 0, unindexed_miss = 0;
+	u64 dyn_hit = 0, dyn_miss = 0;
+	u64 t0, t1, dt_start = 0, dt_end = 0;
+	int ret;
+
 	pr_info("==================================================\n");
 	pr_info("Starting kallsyms performance benchmark (iters=%u)\n", num_iters);
 	pr_info("==================================================\n");
 
-	run_name_lookup_bench();
+	/* 1. Benchmark baseline unindexed marker scan */
+	run_name_lookup_bench("Unindexed (markers)", &unindexed_hit, &unindexed_miss);
+
+	/* 2. Benchmark dynamic lookup index */
+	t0 = ktime_get_ns();
+	ret = kallsyms_lookup_batch_start();
+	t1 = ktime_get_ns();
+	dt_start = t1 - t0;
+
+	if (ret) {
+		pr_err("Failed to start kallsyms lookup batch: %d\n", ret);
+	} else {
+		run_name_lookup_bench("Dynamic Index", &dyn_hit, &dyn_miss);
+
+		t0 = ktime_get_ns();
+		kallsyms_lookup_batch_end();
+		t1 = ktime_get_ns();
+		dt_end = t1 - t0;
+
+		pr_info("[Dynamic Index] Batch setup: %llu us, teardown: %llu us\n",
+			div_u64(dt_start, 1000), div_u64(dt_end, 1000));
+
+		if (unindexed_hit > dyn_hit) {
+			u64 saved = unindexed_hit - dyn_hit;
+
+			pr_info("[Dynamic Index] Amortization break-even: %llu queries (setup), %llu queries (total)\n",
+				DIV_ROUND_UP_ULL(dt_start, saved),
+				DIV_ROUND_UP_ULL(dt_start + dt_end, saved));
+		}
+	}
+
 	run_address_lookup_bench();
 	run_table_walk_bench();
 

-- 
2.55.0

