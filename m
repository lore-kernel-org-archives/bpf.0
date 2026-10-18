Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357B3BFE4C;
	Sun, 18 Oct 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338790; cv=none; b=oQVThZFd7oa845f4HdqryCKou3kQ/04hmWGsxKmOypxkVmV0oq0iFBJJxJg5sAtbjJorD6wF5O7/tTJfMq6W6POAGLwgdXWMfYaPwvt0FOkduGixm/YV5W/ejKKFUjGbx26t0W6s00VwRTuNj/YBzU1am740ZQfSrqpPRJWVspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338790; c=relaxed/simple;
	bh=Rml9MYXsr/6tFjtQ62qZFuqAxvrNRb/EfuakjDjKMTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nh2N4qTPVVn57lxXDy8YeCc+cNd3jZB20VJGT6iLstgvzxveO3fquBqdBojhc6F0BPBQevsdImuaW387wnXYch3ljAJOfePfNNHfRyM9Dq5BxncmyvsFgOh4X9uXwRz3/lgmPzbj5/Ou1gLMWm+UlhSdwN+hNg1x7AltG7KTUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=SGx0k382; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="SGx0k382"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC2-000Ic0-TE; Sun, 18 Oct 2026 17:53:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=B7W50HzfEtTYoFlPorZ56JD0MRdF3AifMRwslpL7QiY=; b=SGx0k382n2f4n0b1r8w0++TS0v
	Jb/gZnm5YEF/MSMiDG8j83SZtsFceMWy2s6Ze0PEVx1oPELtJ31RP6FNQNVYsNSGRZx1NUMDoIs6U
	U+hhb/FEeUjpsHuXYLINQLbFtJniN/JtjNSePh9a22jYRqvaKXxyjHNeUjjAxzfRyqDDrG+1hSZg7
	lAnxvUSUlMIYeIDjKeTFyt331jT2mtF7Kr8gvzjWWU4tYRMU/zm/viJnOHB7tI+jIVCvHWTBDeiw+
	iBYMvWvmPHGbwCPbJTx4uhvJuiR6+q0aLIMeS5bnuUfO/nmgCse3GcgEvRcdBCbL/bXTCQ/gX/m7P
	o+A6wyqQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBx-0001oT-KN; Sun, 18 Oct 2026 17:52:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBf-004q3U-1Z;
	Sun, 18 Oct 2026 17:52:39 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 next 03/15] kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output
Date: Sun, 18 Oct 2026 16:51:54 +0100
Message-Id: <20261018155206.132411-4-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261018155206.132411-1-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Improve the test stability/reproducability by taking the faster of
  two calls to kallsyms_lookup_name().
- Check that kallsyms_lookup_name() returns the expected address
  unless the symbol is duplicated.
- Report the names of the min/max symbols.
- Output an 8 line 64 entry histogram of the times taken.
- This shows there is a reasonably normal distribution with a small
  number of much slower outliers that don't really affect the average.

Additionally:
- Add a very long symbol to check the handling of two byte lengths.
- Do the test_perf_kallsyms_lookup_name() last because it can take long
  enough that the CPU frequency changes and the times reported by the
  other tests can change.
- Mark the 4 test functions noinline_for_stack since they all have a
  quite large on-stack structure.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/kallsyms_selftest.c | 165 ++++++++++++++++++++++++++++---------
 1 file changed, 125 insertions(+), 40 deletions(-)

diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index 0db79237fe54..9072bd91c318 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -22,6 +22,8 @@
 
 
 #define MAX_NUM_OF_RECORDS		64
+#define HISTOGRAM_BUCKETS		64
+#define HISTOGRAM_RESOLUTION		10
 
 struct test_stat {
 	int min;
@@ -29,35 +31,56 @@ struct test_stat {
 	int save_cnt;
 	int real_cnt;
 	int perf;
-	u64 sum;
 	char *name;
 	unsigned long addr;
 	unsigned long addrs[MAX_NUM_OF_RECORDS];
 };
 
+struct lookup_name_info {
+	unsigned int count;
+	unsigned int min;
+	unsigned int max;
+	u64 sum;
+	char min_name[64];
+	char max_name[64];
+	unsigned int histogram[HISTOGRAM_BUCKETS];
+	unsigned int scale;
+};
+
 struct test_item {
 	char *name;
 	unsigned long addr;
 };
 
-#define ITEM_FUNC(s)				\
-	{					\
-		.name = #s,			\
-		.addr = (unsigned long)s,	\
-	}
-
-#define ITEM_DATA(s)				\
+#define _TEST_ITEM(s)				\
 	{					\
 		.name = #s,			\
 		.addr = (unsigned long)&s,	\
 	}
 
+#define TEST_ITEM(s) _TEST_ITEM(s)
 
 static int kallsyms_test_var_bss_static;
 static int kallsyms_test_var_data_static = 1;
 int kallsyms_test_var_bss;
 int kallsyms_test_var_data = 1;
 
+/* This is 509 characters, compresses to about 330 */
+#define kallsyms_very_long_name \
+The_time_has_come_the_Walrus_said_To_talk_of_many_things\
+_Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings\
+_And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings\
+\
+_O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run\
+_Shall_we_be_trotting_home_again_But_answer_came_there_none\
+_And_this_was_scarcely_odd_because_Theyd_eaten_every_one\
+\
+_The_moon_was_shining_sulkily_Because_she_thought_the_sun\
+_Had_got_no_business_to_be_there_After_the_day_was_done\
+_Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun
+
+static int kallsyms_very_long_name = 1;
+
 static int kallsyms_test_func_static(void)
 {
 	kallsyms_test_var_bss_static++;
@@ -79,16 +102,17 @@ __weak int kallsyms_test_func_weak(void)
 }
 
 static struct test_item test_items[] = {
-	ITEM_FUNC(kallsyms_test_func_static),
-	ITEM_FUNC(kallsyms_test_func),
-	ITEM_FUNC(kallsyms_test_func_weak),
-	ITEM_FUNC(vmalloc_noprof),
-	ITEM_FUNC(vfree),
+	TEST_ITEM(kallsyms_test_func_static),
+	TEST_ITEM(kallsyms_test_func),
+	TEST_ITEM(kallsyms_test_func_weak),
+	TEST_ITEM(vmalloc_noprof),
+	TEST_ITEM(vfree),
 #ifdef CONFIG_KALLSYMS_ALL
-	ITEM_DATA(kallsyms_test_var_bss_static),
-	ITEM_DATA(kallsyms_test_var_data_static),
-	ITEM_DATA(kallsyms_test_var_bss),
-	ITEM_DATA(kallsyms_test_var_data),
+	TEST_ITEM(kallsyms_test_var_bss_static),
+	TEST_ITEM(kallsyms_test_var_data_static),
+	TEST_ITEM(kallsyms_very_long_name),
+	TEST_ITEM(kallsyms_test_var_bss),
+	TEST_ITEM(kallsyms_test_var_data),
 #endif
 };
 
@@ -101,7 +125,7 @@ static int stat_symbol_len(void *data, const char *name, unsigned long addr)
 	return 0;
 }
 
-static void test_kallsyms_compression_ratio(void)
+static noinline_for_stack void test_kallsyms_compression_ratio(void)
 {
 	u32 pos, off, len, num;
 	u32 ratio, total_size, total_len = 0;
@@ -153,38 +177,99 @@ static void test_kallsyms_compression_ratio(void)
 	pr_info(" ---------------------------------------------------------\n");
 }
 
+static int is_duplicate(void *data, unsigned long addr)
+{
+	return (*(int *)data)++;
+}
+
 static int lookup_name(void *data, const char *name, unsigned long addr)
 {
-	u64 t0, t1, t;
-	struct test_stat *stat = (struct test_stat *)data;
+	struct lookup_name_info *info = data;
+	unsigned int i, t0, t1, t;
+	unsigned long got_addr;
 
+	/* Improve the stability by taking the fastest of two calls. */
 	t0 = ktime_get_ns();
 	(void)kallsyms_lookup_name(name);
 	t1 = ktime_get_ns();
-
 	t = t1 - t0;
-	if (t < stat->min)
-		stat->min = t;
+	got_addr = kallsyms_lookup_name(name);
+	t0 = ktime_get_ns();
+	if (t0 - t1 < t)
+		t = t0 - t1;
 
-	if (t > stat->max)
-		stat->max = t;
+	if (addr != got_addr) {
+		int c = 0;
 
-	stat->real_cnt++;
-	stat->sum += t;
+		if (!kallsyms_on_each_match_symbol(is_duplicate, name, &c)) {
+			pr_info("got %ld not %ld for %s\n", got_addr, addr, name);
+			return 1;
+		}
+	}
+
+	info->count++;
+	info->sum += t;
+
+	if (t < info->min) {
+		info->min = t;
+		strscpy(info->min_name, name);
+	}
+
+	if (t > info->max) {
+		info->max = t;
+		strscpy(info->max_name, name);
+	}
+
+	/* Create a histogram of the times */
+	t = (t / HISTOGRAM_RESOLUTION) >> info->scale;
+	while (t >= HISTOGRAM_BUCKETS) {
+		t >>= 1;
+		info->scale++;
+		for (i = 0; i < HISTOGRAM_BUCKETS / 2; i++)
+			info->histogram[i] = info->histogram[2 * i] + info->histogram[2 * i + 1];
+		for (; i < HISTOGRAM_BUCKETS; i++)
+			info->histogram[i] = 0;
+	}
+	info->histogram[t]++;
 
 	return 0;
 }
 
-static void test_perf_kallsyms_lookup_name(void)
+static noinline_for_stack void test_perf_kallsyms_lookup_name(void)
 {
-	struct test_stat stat;
-
-	memset(&stat, 0, sizeof(stat));
-	stat.min = INT_MAX;
-	kallsyms_on_each_symbol(lookup_name, &stat);
-	pr_info("kallsyms_lookup_name() looked up %d symbols\n", stat.real_cnt);
-	pr_info("The time spent on each symbol is (ns): min=%d, max=%d, avg=%lld\n",
-		stat.min, stat.max, div_u64(stat.sum, stat.real_cnt));
+	struct lookup_name_info info;
+	unsigned int idx, scale, row;
+	char line[HISTOGRAM_BUCKETS];
+	int len;
+
+	memset(&info, 0, sizeof(info));
+	info.min = ~0u;
+	kallsyms_on_each_symbol(lookup_name, &info);
+	pr_info("kallsyms_lookup_name() looked up %d symbols, average %lld ns\n",
+		info.count, div_u64(info.sum, info.count));
+	pr_info("\tfastest %u ns (%s)\n", info.min, info.min_name);
+	pr_info("\tslowest %u ns (%s)\n", info.max, info.max_name);
+
+	scale = 0;
+	for (idx = 0; idx < HISTOGRAM_BUCKETS; idx++) {
+		if (scale < info.histogram[idx])
+			scale = info.histogram[idx];
+	}
+	row = 8;
+	scale /= row;
+	pr_info("\tDistribution, %uns per column, %u counts per *:\n",
+		HISTOGRAM_RESOLUTION << info.scale, scale);
+	while (row--) {
+		memset(line, ' ', sizeof(line));
+		len = 0;
+		for (idx = 0; idx < HISTOGRAM_BUCKETS; idx++) {
+			if (info.histogram[idx] > row * scale) {
+				len = idx + 1;
+				line[idx] = '*';
+			}
+		}
+		pr_info("\t|%.*s\n", len, line);
+	}
 }
 
 static int find_symbol(void *data, const char *name, unsigned long addr)
@@ -207,7 +292,7 @@ static int find_symbol(void *data, const char *name, unsigned long addr)
 	return 0;
 }
 
-static void test_perf_kallsyms_on_each_symbol(void)
+static noinline_for_stack void test_perf_kallsyms_on_each_symbol(void)
 {
 	u64 t0, t1;
 	struct test_stat stat;
@@ -240,7 +325,7 @@ static int match_symbol(void *data, unsigned long addr)
 	return 0;
 }
 
-static void test_perf_kallsyms_on_each_match_symbol(void)
+static noinline_for_stack void test_perf_kallsyms_on_each_match_symbol(void)
 {
 	u64 t0, t1;
 	struct test_stat stat;
@@ -254,7 +339,7 @@ static void test_perf_kallsyms_on_each_match_symbol(void)
 	pr_info("kallsyms_on_each_match_symbol() traverse all: %lld ns\n", t1 - t0);
 }
 
-static int test_kallsyms_basic_function(void)
+static noinline_for_stack int test_kallsyms_basic_function(void)
 {
 	int i, j, ret;
 	int next = 0, nr_failed = 0;
@@ -425,9 +510,9 @@ static int test_entry(void *p)
 	}
 
 	test_kallsyms_compression_ratio();
-	test_perf_kallsyms_lookup_name();
 	test_perf_kallsyms_on_each_symbol();
 	test_perf_kallsyms_on_each_match_symbol();
+	test_perf_kallsyms_lookup_name();
 	pr_info("finish\n");
 
 	return 0;
-- 
2.39.5

