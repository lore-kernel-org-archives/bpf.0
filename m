Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D7400967
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586828; cv=none; b=GapUK9Dh5kqht4+X4y/nrjKMbQcgbwFoYb21I3IsmfhO3lB+vp9wHq5e6Q/da/vKjbqczIcR6Gj9pUI9xxkSSBalYvgoaVLQoZaVPt3PrnhNpX/egrCq/SZ2Kelh682BhR8BBIo/y1I3l/g+FiY5tSVlY3V53AdoXXjkKxObAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586828; c=relaxed/simple;
	bh=vaSQO80XIeAhu9tT9u+IniUrZHnKnafcw6bulltwM3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvgR8AmK5FTm3pdjnqecKPhRQBpY7HZoQ/evrbRKOK+oYFWmo6cZPLe8C5hG6sgS2pqw5S17TwyMRor7bTMd9aihpXlAQcjuMPZWx4hf0oCcBH+2VgdRnepD8prcpR2jzwvaaKM+2+RlztpcuaD3aVPCo2bjXSbEAIIS3cHSYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH16SFXB; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH16SFXB"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c17f382ff5so38747b6e.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586820; x=1790191620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BgGRmrj9oKDACrt9gfRMb6bPZ4bFgwAyhWlQC+YVu2Y=;
        b=hH16SFXBRDSljqB5p41CZidRCQyIkH33TL4JNTbaQomRlgdNrSqeaZ4UztqSP+Fkbi
         fgduFfZycab3y3ErwSn+Ey/D8Ied0PjAYeyL3Ad7xaryMjk4xW6/N/3t0dNbdkO7/tZc
         63HAaJfJ3gdTkOc/B/GQAM/L8FJ4PfzxHCuEB95w59WRQpCuhA82Of0/Sdf1bbiOVpBU
         7ra5SAg1twyMDRNieRM7CFxDWJY5TcvJBqwyE6muxxBnuPUbsKk5nL4sj1lvAD/0cupz
         KUtugUjAwV6tOtnr+Jcg7KLZG0NITwvMlB9j7In1mwCu1BktLBmMEoj4vOah0m2s8SOk
         YiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586820; x=1790191620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BgGRmrj9oKDACrt9gfRMb6bPZ4bFgwAyhWlQC+YVu2Y=;
        b=NJSBFA20Bajb4z7UY9fAGRO656T/YDHxEfvvQPBAf4yYNmkGBvQ4xa/06L6ogJ4pmR
         XTo2Egl/flgn8K9aVQhM9H7+x/1nELJ1SIES8adUUuBkkxHohfYNwkE0I2Uh9K9HoWkg
         0WHPfGzLFfmc6ouRT9lNKGoNMZ5h/+0t6V3dTOU/h3zOFdE9owY6kJdZGQ5AJRn2F39r
         wu4OYUaBdkwjjr15JBkzVBCiuLUZM17LpkbE1ETJ6DGu/fMotSDTO9uukhhQMnMIscbF
         5/SwbeSAgxnpJVChsU8bicbjjpx0Iths3W1Tm2/4ao3hGeDdxrSsRvnKuHimcXX9kXO3
         /HmA==
X-Gm-Message-State: AFuF++nv9rao6B2+imMq5AFQ/cRESsivQcVDDaw+UprAZlDtROkMw+F0
	gzim5zHUJQSFeDgLWakns71pz2oTVXQQ4mnIObzGUia/s0cCljHWstPE
X-Gm-Gg: AYBFou0uOkLOOC9ElxnZy2G5JCIFrD1lJTmaNC7jkO43Wc9qrpCNQZCflzuBNU0xCRC
	PRNbmTcYIjoEknYAjAqkMAIvPF8EXkWsaRtsuyw5uvr+ZdxtDGBYjqYPrEypPGRCv2qiPTxIV3J
	Qh1wZLqQ9gEniJXu7uQvgWFHxIbDWlX4qWfA6JtfnRT5icAq3kr9rzeanS0HKJ25xt6fhSiiXU2
	9U1mI7Wcyg/2yt86d97YMAz+qehhMIcycbSamcc0pIiezJCX7o0Cv4c/FodIAtCjgs8ko4HxnZf
	ZQbkVvus8el2+a+FavjSitG9RojET4kplQ4LviuxRn6ktJupjvZ21eT9ODORUz7Lhdrc9GBhFLc
	kLrTG+rhv62SroN/fCxwYhi+Fqgxi1DmdB1oI5GM8VO4aZ3h04hbDKZ8hsMGp74GdN8erTpX1Oz
	FlLbEvRsOMRXurRvnZMKbt7Gb+WO5GX6nhDcF+rt7lQmu+8Nu34/tAymZRs9p1+Q==
X-Received: by 2002:a05:6808:1706:b0:4c1:2512:ee84 with SMTP id 5614622812f47-4ca4be66e81mr4003049b6e.23.1789586820146;
        Wed, 16 Sep 2026 12:27:00 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb6d99ae78sm661327b6e.18.2026.09.16.12.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:26:59 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 16 Sep 2026 12:26:42 -0700
Subject: [PATCH bpf-next v4 3/3] bpftool: Scale counters and report cycles
 per run
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-bpftool_cyles_per_run-v4-3-f2de02c480d5@meta.com>
References: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
In-Reply-To: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789586810; l=9924;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Dq6riL+hn7QsQ/ulHsUZcf3hvD02EWJFTtWk4u2VFks=;
 b=e9YtkDMHGY3ytjTL7Z5dpAcmD+Ixo+K6jYPSBDgYvScF/Dtx6jxVgcr6jpmZ7NE2WWkljMxy2
 xNA4/8UKHlsCOmldrO/G65+Kel/u6q6T4B38q/twfUnUc+DqNuC3EvA
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Perf counters undercount when the PMU multiplexes them. Scale each
per-CPU value before aggregation. Per-CPU event groups make PMU ratios
use matching scheduling intervals.

Keep run_cnt as the total number of program executions, independent of
counter scheduling.

Keep JSON value raw, report the scaled value in value_scaled, and
document the output.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  11 +-
 tools/bpf/bpftool/prog.c                         | 122 +++++++++++++++--------
 2 files changed, 89 insertions(+), 44 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 90fa2a48cc26..90fe8c61bf42 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -217,7 +217,14 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
 bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
     Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
     user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
-    the profiling will run up to **UINT_MAX** seconds.
+    the profiling will run up to **UINT_MAX** seconds. Selected metrics form a
+    perf event group on each CPU so that ratios use counters scheduled over the
+    same intervals. Plain output scales each per-CPU metric value to correct
+    for perf event multiplexing. When **cycles** is selected, it also reports
+    cycles per program run.
+
+    In JSON output, **value** is raw, **value_scaled** is scaled, and
+    **run_cnt** is the total number of program runs.
 
 bpftool prog help
     Print short help message.
@@ -360,7 +367,7 @@ EXAMPLES
 ::
 
          51397 run_cnt
-      40176203 cycles                                                 (83.05%)
+      40176203 cycles          # 781.68 cycles per run                (83.05%)
       42518139 instructions    #   1.06 insns per cycle               (83.39%)
            123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a14a1a9601bd..000774835b10 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2062,37 +2062,52 @@ static int do_profile(int argc, char **argv)
 
 #include "profiler.skel.h"
 
+enum ratio_metric {
+	METRIC_NONE = -2,
+	METRIC_RUN_CNT = -1,
+	METRIC_CYCLES = 0,
+	METRIC_INSTRUCTIONS = 1,
+	METRIC_L1D_LOADS = 2,
+	METRIC_LLC_MISSES = 3,
+	METRIC_ITLB_MISSES = 4,
+	METRIC_DTLB_MISSES = 5,
+};
+
 struct profile_metric {
 	const char *name;
 	struct bpf_perf_event_value val;
+	__u64 scaled_val;
 	struct perf_event_attr attr;
 	bool selected;
 
 	/* calculate ratios like instructions per cycle */
-	const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
+	const enum ratio_metric ratio_metric;
 	const char *ratio_desc;
 	const float ratio_mul;
 } metrics[] = {
-	{
+	[METRIC_CYCLES] = {
 		.name = "cycles",
 		.attr = {
 			.type = PERF_TYPE_HARDWARE,
 			.config = PERF_COUNT_HW_CPU_CYCLES,
 			.exclude_user = 1,
 		},
+		.ratio_metric = METRIC_RUN_CNT,
+		.ratio_desc = "cycles per run",
+		.ratio_mul = 1.0,
 	},
-	{
+	[METRIC_INSTRUCTIONS] = {
 		.name = "instructions",
 		.attr = {
 			.type = PERF_TYPE_HARDWARE,
 			.config = PERF_COUNT_HW_INSTRUCTIONS,
 			.exclude_user = 1,
 		},
-		.ratio_metric = 1,
+		.ratio_metric = METRIC_CYCLES,
 		.ratio_desc = "insns per cycle",
 		.ratio_mul = 1.0,
 	},
-	{
+	[METRIC_L1D_LOADS] = {
 		.name = "l1d_loads",
 		.attr = {
 			.type = PERF_TYPE_HW_CACHE,
@@ -2102,8 +2117,9 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_ACCESS << 16),
 			.exclude_user = 1,
 		},
+		.ratio_metric = METRIC_NONE,
 	},
-	{
+	[METRIC_LLC_MISSES] = {
 		.name = "llc_misses",
 		.attr = {
 			.type = PERF_TYPE_HW_CACHE,
@@ -2113,11 +2129,11 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
 			.exclude_user = 1
 		},
-		.ratio_metric = 2,
+		.ratio_metric = METRIC_INSTRUCTIONS,
 		.ratio_desc = "LLC misses per million insns",
 		.ratio_mul = 1e6,
 	},
-	{
+	[METRIC_ITLB_MISSES] = {
 		.name = "itlb_misses",
 		.attr = {
 			.type = PERF_TYPE_HW_CACHE,
@@ -2127,11 +2143,11 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
 			.exclude_user = 1
 		},
-		.ratio_metric = 2,
+		.ratio_metric = METRIC_INSTRUCTIONS,
 		.ratio_desc = "itlb misses per million insns",
 		.ratio_mul = 1e6,
 	},
-	{
+	[METRIC_DTLB_MISSES] = {
 		.name = "dtlb_misses",
 		.attr = {
 			.type = PERF_TYPE_HW_CACHE,
@@ -2141,7 +2157,7 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
 			.exclude_user = 1
 		},
-		.ratio_metric = 2,
+		.ratio_metric = METRIC_INSTRUCTIONS,
 		.ratio_desc = "dtlb misses per million insns",
 		.ratio_mul = 1e6,
 	},
@@ -2182,7 +2198,7 @@ static int profile_parse_metrics(int argc, char **argv)
 	return selected_cnt;
 }
 
-static void profile_read_values(struct profiler_bpf *obj)
+static int profile_read_values(struct profiler_bpf *obj)
 {
 	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
 	int reading_map_fd, count_map_fd;
@@ -2192,15 +2208,11 @@ static void profile_read_values(struct profiler_bpf *obj)
 
 	reading_map_fd = bpf_map__fd(obj->maps.accum_readings);
 	count_map_fd = bpf_map__fd(obj->maps.counts);
-	if (reading_map_fd < 0 || count_map_fd < 0) {
-		p_err("failed to get fd for map");
-		return;
-	}
 
 	err = bpf_map_lookup_elem(count_map_fd, &key, counts);
 	if (err) {
 		p_err("failed to read count_map: %s", strerror(errno));
-		return;
+		return err;
 	}
 
 	profile_total_count = 0;
@@ -2208,24 +2220,37 @@ static void profile_read_values(struct profiler_bpf *obj)
 		profile_total_count += counts[cpu];
 
 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
-		struct bpf_perf_event_value values[num_cpu];
+		struct bpf_perf_event_value values[num_cpu], *val;
+		double scale;
 
 		if (!metrics[m].selected)
 			continue;
 
 		err = bpf_map_lookup_elem(reading_map_fd, &key, values);
 		if (err) {
-			p_err("failed to read reading_map: %s",
-			      strerror(errno));
-			return;
+			p_err("failed to read reading_map: %s", strerror(errno));
+			return err;
 		}
+
 		for (cpu = 0; cpu < num_cpu; cpu++) {
-			metrics[m].val.counter += values[cpu].counter;
-			metrics[m].val.enabled += values[cpu].enabled;
-			metrics[m].val.running += values[cpu].running;
+			val = &values[cpu];
+			if (counts[cpu] && !val->running) {
+				p_err("perf event %s was not counted on CPU %u",
+				      metrics[m].name, cpu);
+				return -EAGAIN;
+			}
+			metrics[m].val.enabled += val->enabled;
+			metrics[m].val.running += val->running;
+			metrics[m].val.counter += val->counter;
+			if (val->running) {
+				/* Scale values to account for perf event multiplexing. */
+				scale = (double)val->enabled / val->running;
+				metrics[m].scaled_val += val->counter * scale;
+			}
 		}
 		key++;
 	}
+	return 0;
 }
 
 static void profile_print_readings_json(void)
@@ -2242,6 +2267,7 @@ static void profile_print_readings_json(void)
 		jsonw_lluint_field(json_wtr, "value", metrics[m].val.counter);
 		jsonw_lluint_field(json_wtr, "enabled", metrics[m].val.enabled);
 		jsonw_lluint_field(json_wtr, "running", metrics[m].val.running);
+		jsonw_lluint_field(json_wtr, "value_scaled", metrics[m].scaled_val);
 
 		jsonw_end_object(json_wtr);
 	}
@@ -2250,24 +2276,34 @@ static void profile_print_readings_json(void)
 
 static void profile_print_readings_plain(void)
 {
-	__u32 m;
+	__u32 i;
 
 	printf("\n%18llu %-20s\n", profile_total_count, "run_cnt");
-	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
-		struct bpf_perf_event_value *val = &metrics[m].val;
+	for (i = 0; i < ARRAY_SIZE(metrics); i++) {
+		struct profile_metric *m = &metrics[i];
+		struct bpf_perf_event_value *val = &m->val;
 		int r;
+		__u64 ratio;
 
-		if (!metrics[m].selected)
+		if (!m->selected)
 			continue;
-		printf("%18llu %-20s", val->counter, metrics[m].name);
+		printf("%18llu %-20s", m->scaled_val, m->name);
 
-		r = metrics[m].ratio_metric - 1;
-		if (r >= 0 && metrics[r].selected &&
-		    metrics[r].val.counter > 0) {
+		r = m->ratio_metric;
+		switch (r) {
+		case METRIC_RUN_CNT:
+			ratio = profile_total_count;
+			break;
+		case METRIC_NONE:
+			ratio = 0;
+			break;
+		default:
+			ratio = metrics[r].scaled_val;
+		}
+		if (ratio) {
 			printf("# %8.2f %-30s",
-			       val->counter * metrics[m].ratio_mul /
-			       metrics[r].val.counter,
-			       metrics[m].ratio_desc);
+			       m->scaled_val * m->ratio_mul / ratio,
+			       m->ratio_desc);
 		} else {
 			printf("%-41s", "");
 		}
@@ -2438,21 +2474,24 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	return 0;
 }
 
-static void profile_print_and_cleanup(void)
+static int profile_print_and_cleanup(void)
 {
+	int err;
+
 	profile_close_perf_events();
-	profile_read_values(profile_obj);
-	profile_print_readings();
+	err = profile_read_values(profile_obj);
+	if (!err)
+		profile_print_readings();
 	profiler_bpf__destroy(profile_obj);
 
 	close(profile_tgt_fd);
 	free(profile_tgt_name);
+	return err;
 }
 
 static void int_exit(int signo)
 {
-	profile_print_and_cleanup();
-	exit(0);
+	exit(!!profile_print_and_cleanup());
 }
 
 static int do_profile(int argc, char **argv)
@@ -2542,8 +2581,7 @@ static int do_profile(int argc, char **argv)
 	signal(SIGINT, int_exit);
 
 	sleep(duration);
-	profile_print_and_cleanup();
-	return 0;
+	return profile_print_and_cleanup();
 
 out:
 	profile_close_perf_events();

-- 
2.53.0-Meta

