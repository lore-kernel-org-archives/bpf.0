Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B07495029
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107727; cv=none; b=CKts6n1eTuJvQKy2VtkSKZlEIVCekmZFrH7hFW3adAj1avXGF/agox0JarIEiJAQxe/JLEIWrjhVhBGnCFTnhYkx6BdgqhDJ2RTZJoXhLkzS61zMeDkjG0geqWmcqBRkg5x1qne6dODujfV4WkhTHEqLGPp5zwaHWwPW/hp3TQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107727; c=relaxed/simple;
	bh=GAU8soK/soIgxIPJa40VL+WIbNoKOxxllpQZSMNrvVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AdJTsAKC3oB3i+P1mbjhDCerJh1UqJIYoQnI7nxZD8zmoknIGx0GCjxzCebvGvOGWwZwcqAAn0bVTDsKfgk6G6S3GUF4n/aQlfNoxAwCFskUyoWMEdMiL/2sVIRYfaXddJHYrVqrGY2yMEpxFYX1rBkcvzoM1N+m6pY2i1QKTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AileT8pK; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AileT8pK"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-482620dc91bso227664fac.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107711; x=1790712511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbNl4k+W1q7yiAA0aGRbWPBqZ/1TEL1hl7cPMNaYBEs=;
        b=AileT8pKyvMXhY/8nsz6ACGn5o0cwbihSHu8M5o6JwcyW2yuu06K3+C8SKA5rRqLeO
         Rzv1Xysp4Vb9rNBRNwt6w2qf9pdnEyveQ/Oqotx1wKKcDHnNnbmO14Fo+RkoWoEeoB/c
         ENcfw5UarsBOje5tx82MJ0bdvjTiaVvPPnhOUxxg11GWuCCfWx1Hddm8JtftdiONgokb
         3MFX1tYLneu8IrixlUla3V1BU9otaEnWVItlCIqNaEH4WAEtSBnVcmfpfdIGZfubmyot
         8V/iFZnZTrdjqAQA9sCsJcSLhyuCscQSHF/iUBxNIfRh7fqVDHLy3iA8qTOOuh9eXKw8
         33Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107711; x=1790712511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sbNl4k+W1q7yiAA0aGRbWPBqZ/1TEL1hl7cPMNaYBEs=;
        b=abXlVahCDrWvRIv7XuvqGlJxdzbk82i9dbkytBNqjIQJ9UVgtOejIXk+bPgJa56PGo
         IP/NHme+mmqu0PMUkk0TBrmzvoacE1RRL8UqNOMR5QA6SXFh0z2Mpgub6RD0cCTmUXfT
         JNamkNCIsAzoZkt/WRr3RCfnWD7Rz0dfZASu9tN+yiwSDN5Td6M1GlhcyZ0AqZnjKob0
         WDzalxn9QRT5v4Lo+KYGd3MQn5PRjlL43YKf2AWLJ9ctD8TjUZixg0PYKhsn4WtZLzCq
         d2zOvSdPl02pks5W7T6kS3YgglSOgMIZaYdQ+4fIiByEL/LT/ENo7OTxGfY2KGTIklTU
         71/w==
X-Forwarded-Encrypted: i=1; AKwUvBxHB62CGMWbMu2WX5zhP8l3aH4n9xq5ARl8/3NHiObWlp6ZkfTBKYIeJRSa+e+Jh/LnUVY=@vger.kernel.org
X-Gm-Message-State: AFuF++nrWanYQpJWC4ApluO5utx4Md9BS+gyGjORY73kUoUIGtwSRNvf
	qk6BaYH3FotvdgeqHeH70PIE7/mUGoiWNsKtA4f7KkNrXxspNG5WJHSleocmkg==
X-Gm-Gg: AYBFou1Mpp9HfBmwpQCih7GwkmabCQRwGox+9DZ7enwmHk4PfxgTECoDPJ3qAxC229b
	PdYKW+b7molC9CGVUYYQ/fywI4HkgCSt1fLZM8UOotbiEITMT01TYDSFJVfSG+MHq77SEay4Oqm
	4MIXTccX/gie5UKGq4ZtdLcIRL4ot2lu5EEUlqk14LdGoaVUKEJz7tQM9P4qKOL2MBZYxe1wUfO
	j4uZoGlSUxYJ1C0p/jhCoNohGN2fC4wW7z1KY3KPGGHGoNYCHBi9tMGW6dxT9Rph0YdLDOGxXMX
	SCk2agMs044rry8fwRng2sKkHMlvK44/6wZ+0DWxvvPmbyJV88U5be7OkT12LGCmmI/0ngBAcwh
	LEk/Zw3llZ7lCqdPA+7WJqcu17P8PdAtVC58wZC5dkF161TKt9DwStxSQdGtTRNJNiMQCr0OsY2
	cxULVSjUF+mVndnNfJXH5DPH2LIfkY0123ynjwfZ2sf15qTV0aW+H3ui5RvhhgoIV71txkNJYAx
	uCIh5PZiveg7EyLtcq24of9BiZaCE4YJZT38ZZ1pjoGvHnVe2RQzw7v4jnV8Q3rRgPCP3BWmV8G
	98IpBeP3DsQHr5F10vQgC/1uy8Jn6g==
X-Received: by 2002:a05:6871:340c:b0:48f:e363:5cc9 with SMTP id 586e51a60fabf-4908c5fc720mr685685fac.55.1790107710505;
        Tue, 22 Sep 2026 13:08:30 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4908eb9237asm564087fac.12.2026.09.22.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:08:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 14:08:20 -0600
Subject: [PATCH v4 3/4] kallsyms: Add dynamic lookup index for batch
 resolution
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v4-3-92acea84b911@gmail.com>
References: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790107704; l=13772;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=GAU8soK/soIgxIPJa40VL+WIbNoKOxxllpQZSMNrvVo=;
 b=fTsqZWFey3zeLGk8mlnrfpOeY4sMTsFvBW4VUCETSnZEzwPTWrX9UXMVYOpDOqd9cwXnciyPD
 tWdDJI6RBSgA59X376C7eN2KRgTvK8tWzCl6XbVVu8LEzkfziycyfwV
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

kallsyms_lookup_names() resolves symbol names to addresses using a
binary search over kallsyms_seqs_of_names[].  In baseline, each step
invokes get_symbol_offset(), which scans sequentially from the nearest
256-symbol marker in kallsyms_names[] (averaging ~128 ULEB128 header
decodes per probe, ~2,176 decodes per lookup).

During bulk symbol resolution workloads (e.g. BPF multi-kprobe / fprobe
tracing attaching across tens of thousands of functions), this linear
scan compounds into substantial kernel attach latency (~3.3 us per
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
   offsets[pos] directly as an O(1) array access with 0 hops, bracketed
   by rcu_read_lock() and rcu_read_unlock().

2. If the dynamic table is unallocated (refcount 0), fall back to the
   legacy kallsyms_markers[] scan, preserving 100% safety for oops,
   panic, NMI, and low-memory environments without any .rodata bloat.

3. Wrap kallsyms_lookup_names() in rcu_read_lock() / rcu_read_unlock()
   to ensure lockless lifetime safety across multi-probe searches.

4. Update test_kallsyms_perf and kallsyms_selftest to benchmark both
   unindexed marker scans and the dynamic batch index side by side,
   reporting batch lookup performance alongside query amortization
   break-even points.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v4:
- Annotate dyn_kallsyms_offsets declaration with __rcu to satisfy sparse
  type checking and prevent address-space warnings across
  rcu_assign_pointer() and rcu_dereference() (addresses Sashiko AI review).
- Use rcu_replace_pointer() with lockdep_is_held(&dyn_kallsyms_mutex)
  during batch teardown to atomically read and clear the pointer while
  satisfying sparse address-space constraints (addresses Sashiko AI review).

Changes in v3:
- Reorder patch after on-the-fly token matching (patch 2) to cleanly
  isolate and measure the impact of the O(1) dynamic table on top of
  fast string matching (addresses David Laight review).
- Consume get_symbol_data() helper introduced in patch 2 to preserve
  clean git bisectability (addresses Sashiko AI review).
- Fix use-after-free race on dyn_kallsyms_offsets: bracket table
  dereference and array read with rcu_read_lock() and replace
  rcu_dereference_raw() with rcu_dereference() inside
  get_symbol_offset() to protect external readers (lookup_symbol_name,
  kallsyms_lookup_buildid, reset_iter) against concurrent batch
  teardown (addresses Sashiko AI review).
- In kallsyms_selftest, add a second lookup pass bracketed by
  kallsyms_lookup_batch_start() and kallsyms_lookup_batch_end() to
  validate batch resolution in the in-tree selftest.
- Move 24-bit loop unrolling in get_symbol_seq() to standalone patch 4
  (addresses David Laight review).
- Move David Laight to series-wide Cc on cover letter, dropping trailer
  from this patch.

Changes in v2:
- Rework from static build-time 3-byte table to dynamic u32 index
  allocated in transient RAM during batch sessions, dropping +573 KiB
  from .rodata to 0 bytes (addresses Kees Cook review).
- Use native u32 indexing to eliminate 24-bit big-endian shifts and
  unaligned loads (addresses David Laight review).
- Revert changes to scripts/kallsyms.c and kernel/kallsyms_internal.h,
  retaining legacy kallsyms_markers[] as fallback.
---
 include/linux/kallsyms.h   |  13 ++++++
 kernel/kallsyms.c          | 111 ++++++++++++++++++++++++++++++++++++++++++---
 kernel/kallsyms_selftest.c |  16 +++++++
 lib/test_kallsyms_perf.c   |  51 ++++++++++++++++++---
 4 files changed, 179 insertions(+), 12 deletions(-)

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
index d18d78e626db..bb34b4c0f690 100644
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
@@ -90,7 +93,7 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
 	if (maxlen)
 		*result = '\0';
 
-	/* Return to offset to the next symbol. */
+	/* Return offset to the next symbol. */
 	return off;
 }
 
@@ -139,12 +142,11 @@ static int kallsyms_strcmp_symbol(unsigned int off, const char *name)
 	return (unsigned char)*name;
 }
 
-
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
@@ -177,6 +179,99 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	return name - kallsyms_names;
 }
 
+/*
+ * Dynamic symbol offset table.
+ * Allocated on demand during high-volume lookup batches and reclaimed after.
+ */
+static u32 __rcu *dyn_kallsyms_offsets __read_mostly;
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
+	if (--dyn_kallsyms_refcnt == 0)
+		offsets = rcu_replace_pointer(dyn_kallsyms_offsets, NULL,
+					      lockdep_is_held(&dyn_kallsyms_mutex));
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
+	unsigned int off;
+	u32 *offsets;
+
+	rcu_read_lock();
+	offsets = rcu_dereference(dyn_kallsyms_offsets);
+	if (offsets) {
+		off = offsets[pos];
+		rcu_read_unlock();
+		return off;
+	}
+	rcu_read_unlock();
+
+	return get_symbol_offset_marker(pos);
+}
+
 unsigned long kallsyms_sym_address(int idx)
 {
 	/* non-relocatable 32-bit kernels just embed the value directly */
@@ -206,6 +301,7 @@ static int kallsyms_lookup_names(const char *name,
 	low = 0;
 	high = kallsyms_num_syms - 1;
 
+	rcu_read_lock();
 	while (low <= high) {
 		mid = low + (high - low) / 2;
 		seq = get_symbol_seq(mid);
@@ -219,8 +315,10 @@ static int kallsyms_lookup_names(const char *name,
 			break;
 	}
 
-	if (low > high)
+	if (low > high) {
+		rcu_read_unlock();
 		return -ESRCH;
+	}
 
 	low = mid;
 	while (low) {
@@ -243,6 +341,7 @@ static int kallsyms_lookup_names(const char *name,
 		}
 		*end = high;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index 8f6c4e9b3a1c..aedffc058c0e 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -178,6 +178,7 @@ static int lookup_name(void *data, const char *name, unsigned long addr)
 static void test_perf_kallsyms_lookup_name(void)
 {
 	struct test_stat stat;
+	int ret;
 
 	memset(&stat, 0, sizeof(stat));
 	stat.min = INT_MAX;
@@ -185,6 +186,21 @@ static void test_perf_kallsyms_lookup_name(void)
 	pr_info("kallsyms_lookup_name() looked up %d symbols\n", stat.real_cnt);
 	pr_info("The time spent on each symbol is (ns): min=%d, max=%d, avg=%lld\n",
 		stat.min, stat.max, div_u64(stat.sum, stat.real_cnt));
+
+	ret = kallsyms_lookup_batch_start();
+	if (ret) {
+		pr_err("kallsyms_lookup_batch_start() failed: %d\n", ret);
+		return;
+	}
+
+	memset(&stat, 0, sizeof(stat));
+	stat.min = INT_MAX;
+	kallsyms_on_each_symbol(lookup_name, &stat);
+	kallsyms_lookup_batch_end();
+
+	pr_info("kallsyms_lookup_name() (batch) looked up %d symbols\n", stat.real_cnt);
+	pr_info("The time spent on each symbol is (ns): min=%d, max=%d, avg=%lld\n",
+		stat.min, stat.max, div_u64(stat.sum, stat.real_cnt));
 }
 
 static int find_symbol(void *data, const char *name, unsigned long addr)
diff --git a/lib/test_kallsyms_perf.c b/lib/test_kallsyms_perf.c
index 03ff5f1d51c5..f6c3d5d82e5d 100644
--- a/lib/test_kallsyms_perf.c
+++ b/lib/test_kallsyms_perf.c
@@ -91,7 +91,8 @@ static int count_cb(void *data, const char *name, unsigned long addr)
 	return 0;
 }
 
-static void run_name_lookup_bench(unsigned int iters)
+static void run_name_lookup_bench(const char *mode, unsigned int iters,
+				  u64 *avg_hit_ns, u64 *avg_miss_ns)
 {
 	u64 t0, t1, dt_hit = 0, dt_miss = 0;
 	unsigned long addr = 0;
@@ -153,10 +154,15 @@ static void run_name_lookup_bench(unsigned int iters)
 		dt_miss += t1 - t0;
 	}
 
-	pr_info("Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
-		div_u64(dt_hit, iters), div_u64(dt_hit, 1000000), iters);
-	pr_info("Name Search Miss: %llu ns/lookup (%llu ms total, %u iters)\n",
-		div_u64(dt_miss, iters), div_u64(dt_miss, 1000000), iters);
+	if (avg_hit_ns)
+		*avg_hit_ns = div_u64(dt_hit, iters);
+	if (avg_miss_ns)
+		*avg_miss_ns = div_u64(dt_miss, iters);
+
+	pr_info("[%s] Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
+		mode, div_u64(dt_hit, iters), div_u64(dt_hit, 1000000), iters);
+	pr_info("[%s] Name Search Miss: %llu ns/lookup (%llu ms total, %u iters)\n",
+		mode, div_u64(dt_miss, iters), div_u64(dt_miss, 1000000), iters);
 }
 
 static void run_address_lookup_bench(unsigned int iters)
@@ -243,6 +249,9 @@ static void run_table_walk_bench(void)
 static int run_kallsyms_benchmark(void)
 {
 	unsigned int iters;
+	u64 unindexed_hit = 0, unindexed_miss = 0;
+	u64 dyn_hit = 0, dyn_miss = 0;
+	u64 t0, t1, dt_start = 0, dt_end = 0;
 	int ret = 0;
 
 	if (!mutex_trylock(&bench_lock)) {
@@ -261,7 +270,37 @@ static int run_kallsyms_benchmark(void)
 	pr_info("Starting kallsyms performance benchmark (iters=%u)\n", iters);
 	pr_info("==================================================\n");
 
-	run_name_lookup_bench(iters);
+	/* 1. Benchmark baseline unindexed marker scan */
+	run_name_lookup_bench("Unindexed (markers)", iters, &unindexed_hit, &unindexed_miss);
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
+		run_name_lookup_bench("Dynamic Index", iters, &dyn_hit, &dyn_miss);
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
 	run_address_lookup_bench(iters);
 	run_table_walk_bench();
 

-- 
2.55.0

