Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE230DD2F
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357267; cv=none; b=rUVEdoelSOfnatoy/sN2eVKBuEWVMVdSCZTSb0CTaXQSv4qkvq90Wf+huMiT+wKp1hNl+835AiFi3gPG4ju3B+VG9XglulCV50/FNcvzpfTMNm/lwsUSBmTUWoE06LrubGfaGUrhHrhKJkkbWMB3lsYXJE5ZksxpjnW6ScL9FB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357267; c=relaxed/simple;
	bh=DWNFUIFVEDe57sdHK0WXzlWlGFKeeKNO2QfrvAuL+rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mmtY4G5oB5tSnQ0HdHt/2pnbV05S9jbIJcfs+eLZumaKhf3ZWX7vAGyyDn8EH85pE+woh1L2ibDUw/YPfStjsUXAOni1x71IiVXk6XKIHPZuzq0LbBwaur8q3daoodlY7ibHXM2NrG/wrGlkqFtb1+rIZph48LW3eyYjuarJtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNrN4Nuc; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNrN4Nuc"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b381337e1fso744447b6e.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357264; x=1788962064; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Q/oFPzhFI+3aZnJajZaxDmoj+RJucLnC80uNjxDDJM=;
        b=sNrN4NucMLhVzNu1lizSnRgSFQFV8jmOSwYntvXKHgxIQ8TCCRjoxyoW8bCJOZomMq
         NC2goahMvcOMp74l/OC8JI3dFwQQJcjs1/EIr8ryhBJI6DAY3JPGJayKjwZAssLIUDMY
         bymWNHDgRQh0+8r84QC05ak088s1pW+ZaXkju3jeZbQfL94mYhjf2/94/lAP4GLiT6Lt
         8oEn0/DIkaP5MUBP/yxbzmX9PleHTC+tOIm912+Uhk6YgB4yNjLXtLmHtvlGfZJLDKyd
         GMd3f6tX2sBXUVF6rx4fe2e7tvNNATG7r67oErGLwYyBnEzCimUzLNaE0JfKI+Pep1wT
         uPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357264; x=1788962064;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Q/oFPzhFI+3aZnJajZaxDmoj+RJucLnC80uNjxDDJM=;
        b=n7lPVfwhTcZkdXH79Jp5QJc2kYx+bbB2bKOgAcwFWF2a7xaaar0MBstnhSTW9/cUQM
         4yH7LZ7Q9kqiLUiv/afTtw8I9AXW9rIsxSuzdABZ65vhtXKeyJi3gI5PePd3KclGy3X8
         wPve6qRPHsn9yURxeGTKCJPflvS18l2pyRZIusln7J3m1ejON3CMIwAkzd69sA0eVe2v
         v4JfLc3S90gf/2+TfYltLCwEJYPxmYJ1vO3nmrsCowdKdLT4D02zDEUH9EIpEdfgo+yO
         +62Uy1naDZSXkThaMwbNUUc3m3Yi4SxufY4RAxU+S3dXjUxKOj9hqxKHekI8IVKgT0zi
         Fj8A==
X-Gm-Message-State: AFuF++lbrTLnqjGESQssADG2ElIQyZm5hiZEzXnXC19Oe84oUxOP03gi
	B8UQC4nStJooBiVjyz6f7k/YHphvAXTFWS0jTkQnspy9VWnWk10lA3ax
X-Gm-Gg: AR+sD11CwYv/Dp/V9BCnXcIUeksDNGYFG1QAvw5yhTBaBXKYVS3DtSBWz7Ytbix7jqo
	yfl21Ya0AeqJZHk4LvTApgQgvetLYE8ipNuMFjC3dlRU5hq6TUxyY6oORsca8VXT0TxhFHwBXWZ
	hH4bNUrKU6T/vBG5qXGdGO3fbvZe0YEgBysntGisJScSpdW01kuQCSl40WTC3Ew3hLoxamCvodK
	l1V3CNjgDJZT+Q/k5YqGvA5jJs3iiHKQWmb/rgVE4ZkDdDtDtTD0yGoS4S8vZLcsMDFBvaRV3d+
	+Hqj5GL/LsiIjyeyqlV2r98SzlvzF2r3ls0VtA5Nlp60eM2d7QXIG6ZH75UETTIHY5IMJUfWkdT
	RhVP38LhNm+zKsNPTrwu+8P+87Wbc1ibDQRpf/qCgiS5X4EYpks09c7G1z4NwVPtrqtM4OfUkcE
	MZlROQFQ9haiAzJ4GGN/xpxrNu5iqn3uiaVAJn3aU/Zg2reOHAaryT276AuyYlXA==
X-Received: by 2002:a05:6808:4fce:b0:4a4:c623:4c0b with SMTP id 5614622812f47-4b6bc445157mr5113481b6e.4.1788357264509;
        Wed, 02 Sep 2026 06:54:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b69851db91sm1889974b6e.3.2026.09.02.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:54:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 02 Sep 2026 06:53:48 -0700
Subject: [PATCH bpf-next v2] bpftool: Scale multiplexed perf counters
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com>
X-B4-Tracking: v=1; b=H4sIAGsqmGoC/4XNXQqEIBRA4a3Ifc7BHyanntrHEJF2nYRSUSeKa
 O8DbWCeD3znhIzJYYaWnJBwc9kFDy0RFQEzj/6D1E3QEhBM1OwlFNXRlhCWwRwL5iFiGtLX00b
 yurFGS6YVVARiQuv2232DjpZ63Av0FYHZ5RLScQ83fvc/9sYpp0pNSlsjDauf3YplfJiwQn9d1
 w+Tvm0zwwAAAA==
X-Change-ID: 20260827-bpftool_cyles_per_run-93169fcb30b7
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com, qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788357261; l=7619;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=KD3uv1hEh7PXfb69cCRBt11rutTtXatBOuPANQmHJuM=;
 b=6VVEq5ULjkNdc2biJuTQEgBxEFEV+U6p4Y5Ig0N6vaud8JXBbWThsnq9gevOtXIkLk3PsyshE
 xLhSjMkF25IBgc9FgEHetPdbYhIIigE1GMbWtuzp+EH7RUNNoOVnAiN
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Perf counters values may be underreported when PMU multiplexing
takes place. Scale resulting values similar to how perf does it:

scaled_count = raw_count*time_enabled/time_running;

Report cycles per run to expose the per-invocation cost.

Example:
sudo ./bpftool prog profile name mprog duration 15 cycles instructions

            423256 run_cnt
         947413975 cycles              #  2238.39 cycles per run
         333965846 instructions        #     0.35 insns per cycle

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- Added scaling for all counters to address PMU multiplexing (Suchit, Andrii)
- Introduce an enum for metric indexes (Andrii)
- Link to v1: https://patch.msgid.link/20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 +-
 tools/bpf/bpftool/prog.c                         | 77 ++++++++++++++++++------
 2 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 90fa2a48cc26..2280dc4492c0 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
 bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
     Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
     user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
-    the profiling will run up to **UINT_MAX** seconds.
+    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
+    selected, plain output also reports the average number of cycles per
+    program run.
 
 bpftool prog help
     Print short help message.
@@ -360,7 +362,7 @@ EXAMPLES
 ::
 
          51397 run_cnt
-      40176203 cycles                                                 (83.05%)
+      40176203 cycles          # 781.68 cycles per run                (83.05%)
       42518139 instructions    #   1.06 insns per cycle               (83.39%)
            123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a9f730d407a9..ad6d33f838e3 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2062,6 +2062,17 @@ static int do_profile(int argc, char **argv)
 
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
@@ -2069,30 +2080,33 @@ struct profile_metric {
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
@@ -2102,8 +2116,9 @@ struct profile_metric {
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
@@ -2113,11 +2128,11 @@ struct profile_metric {
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
@@ -2127,11 +2142,11 @@ struct profile_metric {
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
@@ -2141,7 +2156,7 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
 			.exclude_user = 1
 		},
-		.ratio_metric = 2,
+		.ratio_metric = METRIC_INSTRUCTIONS,
 		.ratio_desc = "dtlb misses per million insns",
 		.ratio_mul = 1e6,
 	},
@@ -2185,6 +2200,7 @@ static int profile_parse_metrics(int argc, char **argv)
 static void profile_read_values(struct profiler_bpf *obj)
 {
 	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
+	struct bpf_perf_event_value *val;
 	int reading_map_fd, count_map_fd;
 	__u64 counts[num_cpu];
 	__u32 key = 0;
@@ -2209,6 +2225,7 @@ static void profile_read_values(struct profiler_bpf *obj)
 
 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
 		struct bpf_perf_event_value values[num_cpu];
+		double scale;
 
 		if (!metrics[m].selected)
 			continue;
@@ -2220,9 +2237,22 @@ static void profile_read_values(struct profiler_bpf *obj)
 			return;
 		}
 		for (cpu = 0; cpu < num_cpu; cpu++) {
-			metrics[m].val.counter += values[cpu].counter;
-			metrics[m].val.enabled += values[cpu].enabled;
-			metrics[m].val.running += values[cpu].running;
+			val = &values[cpu];
+
+			metrics[m].val.enabled += val->enabled;
+			metrics[m].val.running += val->running;
+
+			/* This counter has never been scheduled */
+			if (!val->running) {
+				if (counts[cpu])
+					p_info("%s not scheduled on CPU %u; results may be inaccurate",
+					       metrics[m].name, cpu);
+				continue;
+			}
+
+			/* Scale counter values to account for perf event multiplexing. */
+			scale = (double)val->enabled / val->running;
+			metrics[m].val.counter += val->counter * scale;
 		}
 		key++;
 	}
@@ -2256,17 +2286,26 @@ static void profile_print_readings_plain(void)
 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
 		struct bpf_perf_event_value *val = &metrics[m].val;
 		int r;
+		__u64 ratio;
 
 		if (!metrics[m].selected)
 			continue;
 		printf("%18llu %-20s", val->counter, metrics[m].name);
 
-		r = metrics[m].ratio_metric - 1;
-		if (r >= 0 && metrics[r].selected &&
-		    metrics[r].val.counter > 0) {
+		r = metrics[m].ratio_metric;
+		switch (r) {
+		case METRIC_RUN_CNT:
+			ratio = profile_total_count;
+			break;
+		case METRIC_NONE:
+			ratio = 0;
+			break;
+		default:
+			ratio = metrics[r].val.counter;
+		}
+		if (ratio) {
 			printf("# %8.2f %-30s",
-			       val->counter * metrics[m].ratio_mul /
-			       metrics[r].val.counter,
+			       val->counter * metrics[m].ratio_mul / ratio,
 			       metrics[m].ratio_desc);
 		} else {
 			printf("%-41s", "");

---
base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

