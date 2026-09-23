Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7B30B53A;
	Wed, 23 Sep 2026 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124215; cv=none; b=qaZAQQkSfJQ+6O6qa0JQqcI7ooYxYkY5EciIaYAJcMQ9cOe7QyzDohD9xEA3ns+ZupOWQo+yI/V/hLuh2OGcFxxlx+btGkHlK/xgRzUp4Ex8H+wrpJC5Lo5WgSBDmvXZz9QZxw4dhUEVWaZxdnFeZEaiCrzL+aEE6rkt9gIGmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124215; c=relaxed/simple;
	bh=sUIRsKaSeZ0yMKl2kn5zDUwFjtlPdvHl5YNSViE/ooA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLSLa8xPLK0eukVd8v7qyT9XAcUp/xucy8jEqWZowdhNaBkEQtPBG+AS0I3xE0+c3qYqQjzT46mKCNhI6wj9ahC9QuYIwLCwfHQccaQC99lLoGJ/9mNxknkE7zpFbM7cdhnZC9kxHS46zSkqgPwboBr2ZI6fu9F5wI6IqETuCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AtKmiQYh; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AtKmiQYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7/
	z1GBdPU5aCuCWbgvYDJmkmcp4UL85NMhRsCDEt3KI=; b=AtKmiQYh4tuaiJezzL
	0356v1mayEbYufYGhG6dCVMQG9va5AVuRT9/wW4kUFJ6/0R4LXenFBWltNIBXmiv
	1a+5eJjQGuFjm9cRMx2V7iAgSKsopITUVaJSympkYnZ13lnYzjXLv5u/64aTB+lc
	QqMUfRuDheZRhnyLtTL7dbtY4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3dzGGILNqClfQAA--.40798S2;
	Wed, 23 Sep 2026 08:42:47 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf-next v3 2/2] bpftool: Fix sparse CPU IDs in prog profile
Date: Wed, 23 Sep 2026 09:42:43 +0900
Message-ID: <20260923004243.969919-3-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923004243.969919-1-sh_def@163.com>
References: <20260923004243.969919-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3dzGGILNqClfQAA--.40798S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw48Zw1xXFy8WryDXw18Zrb_yoW3Gw47pa
	n5GFy3KF1kXryqkw13Ca1UWFs8GryxXw1DX34vg3yrZFWUXr93XF48XFWrKF1rWr4kZFy7
	J3WqkrW7AayUX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piXyCJUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6gewEGqzIIdujQAA3Q

bpftool prog profile currently treats the number of possible CPUs as
both the logical CPU ID range and the stride of the perf event array.
That misses valid logical CPUs when the possible CPU mask is sparse,
such as 0,2-3, and can use incorrect PERF_EVENT_ARRAY keys.

Keep the compact possible CPU count for per-CPU result buffers, while
enumerating the actual logical CPU IDs when creating per-CPU perf event
groups. Use the maximum logical CPU ID plus one as the metric stride in
the PERF_EVENT_ARRAY.

This keeps the current per-CPU event grouping intact while separating
the compact per-CPU buffer index from the logical CPU ID and event-array
key. Report the logical CPU ID when a per-CPU event was not counted.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Link: https://lore.kernel.org/bpf/20260813160858.1042834-3-sh_def@163.com/
Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/bpf/bpftool/prog.c                  | 51 +++++++++++++++--------
 tools/bpf/bpftool/skeleton/profiler.bpf.c |  8 ++--
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 000774835b10..24e40dfab469 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2164,6 +2164,9 @@ struct profile_metric {
 };
 
 static __u64 profile_total_count;
+static int profile_cpu_cnt;
+static int *profile_cpu_ids;
+static int profile_cpu_id_span;
 
 #define MAX_NUM_PROFILE_METRICS 4
 
@@ -2200,7 +2203,7 @@ static int profile_parse_metrics(int argc, char **argv)
 
 static int profile_read_values(struct profiler_bpf *obj)
 {
-	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
+	__u32 m, cpu, num_cpu = profile_cpu_cnt;
 	int reading_map_fd, count_map_fd;
 	__u64 counts[num_cpu];
 	__u32 key = 0;
@@ -2235,8 +2238,8 @@ static int profile_read_values(struct profiler_bpf *obj)
 		for (cpu = 0; cpu < num_cpu; cpu++) {
 			val = &values[cpu];
 			if (counts[cpu] && !val->running) {
-				p_err("perf event %s was not counted on CPU %u",
-				      metrics[m].name, cpu);
+				p_err("perf event %s was not counted on CPU %d",
+				      metrics[m].name, profile_cpu_ids[cpu]);
 				return -EAGAIN;
 			}
 			metrics[m].val.enabled += val->enabled;
@@ -2394,6 +2397,7 @@ static void profile_close_perf_events(void)
 		close(profile_perf_events[i]);
 
 	free(profile_perf_events);
+	profile_perf_events = NULL;
 	profile_perf_event_cnt = 0;
 }
 
@@ -2427,13 +2431,12 @@ static int profile_open_perf_event(int mid, int cpu,
 
 static int profile_open_perf_events(struct profiler_bpf *obj)
 {
-	__u32 num_cpu = obj->rodata->num_cpu;
 	__u32 map_key;
 	unsigned int cpu, m;
 	int group_fd, map_fd, pmu_fd;
 	int err;
 
-	profile_perf_events = calloc(num_cpu * obj->rodata->num_metric,
+	profile_perf_events = calloc(profile_cpu_cnt * obj->rodata->num_metric,
 				     sizeof(*profile_perf_events));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
@@ -2442,32 +2445,34 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	}
 
 	map_fd = bpf_map__fd(obj->maps.events);
-	for (cpu = 0; cpu < num_cpu; cpu++) {
+	for (cpu = 0; cpu < (unsigned int)profile_cpu_cnt; cpu++) {
+		int cpu_id = profile_cpu_ids[cpu];
+
 		group_fd = -1;
-		map_key = cpu;
+		map_key = cpu_id;
 		for (m = 0; m < ARRAY_SIZE(metrics); m++) {
 			if (!metrics[m].selected)
 				continue;
 
-			pmu_fd = profile_open_perf_event(m, cpu, map_fd, group_fd,
+			pmu_fd = profile_open_perf_event(m, cpu_id, map_fd, group_fd,
 						     map_key);
 			if (pmu_fd == -ENODEV && group_fd < 0)
 				break;
 			if (pmu_fd < 0) {
-				p_err("failed to add event %s to group on CPU %u: %s",
-				      metrics[m].name, cpu, strerror(-pmu_fd));
+				p_err("failed to add event %s to group on CPU %d: %s",
+				      metrics[m].name, cpu_id, strerror(-pmu_fd));
 				return pmu_fd;
 			}
 			if (group_fd < 0)
 				group_fd = pmu_fd;
-			map_key += num_cpu;
+			map_key += profile_cpu_id_span;
 		}
 		if (group_fd < 0)
 			continue;
 		if (ioctl(group_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP)) {
 			err = -errno;
-			p_err("failed to enable perf event group on CPU %u: %s",
-			      cpu, strerror(-err));
+			p_err("failed to enable perf event group on CPU %d: %s",
+			      cpu_id, strerror(-err));
 			return err;
 		}
 	}
@@ -2486,6 +2491,10 @@ static int profile_print_and_cleanup(void)
 
 	close(profile_tgt_fd);
 	free(profile_tgt_name);
+	free(profile_cpu_ids);
+	profile_cpu_ids = NULL;
+	profile_cpu_cnt = 0;
+	profile_cpu_id_span = 0;
 	return err;
 }
 
@@ -2496,7 +2505,7 @@ static void int_exit(int signo)
 
 static int do_profile(int argc, char **argv)
 {
-	int num_metric, num_cpu, err = -1;
+	int num_metric, err = -1;
 	struct bpf_program *prog;
 	unsigned long duration;
 	char *endptr;
@@ -2527,11 +2536,12 @@ static int do_profile(int argc, char **argv)
 	if (num_metric <= 0)
 		goto out;
 
-	num_cpu = libbpf_num_possible_cpus();
-	if (num_cpu <= 0) {
+	profile_cpu_cnt = get_possible_cpu_ids(&profile_cpu_ids);
+	if (profile_cpu_cnt <= 0) {
 		p_err("failed to identify number of CPUs");
 		goto out;
 	}
+	profile_cpu_id_span = profile_cpu_ids[profile_cpu_cnt - 1] + 1;
 
 	profile_obj = profiler_bpf__open();
 	if (!profile_obj) {
@@ -2539,11 +2549,12 @@ static int do_profile(int argc, char **argv)
 		goto out;
 	}
 
-	profile_obj->rodata->num_cpu = num_cpu;
 	profile_obj->rodata->num_metric = num_metric;
+	profile_obj->rodata->cpu_id_span = profile_cpu_id_span;
 
 	/* adjust map sizes */
-	bpf_map__set_max_entries(profile_obj->maps.events, num_metric * num_cpu);
+	bpf_map__set_max_entries(profile_obj->maps.events,
+				 num_metric * profile_cpu_id_span);
 	bpf_map__set_max_entries(profile_obj->maps.fentry_readings, num_metric);
 	bpf_map__set_max_entries(profile_obj->maps.accum_readings, num_metric);
 	bpf_map__set_max_entries(profile_obj->maps.counts, 1);
@@ -2589,6 +2600,10 @@ static int do_profile(int argc, char **argv)
 		profiler_bpf__destroy(profile_obj);
 	close(profile_tgt_fd);
 	free(profile_tgt_name);
+	free(profile_cpu_ids);
+	profile_cpu_ids = NULL;
+	profile_cpu_cnt = 0;
+	profile_cpu_id_span = 0;
 	return err;
 }
 
diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index 6685e7252fb5..0d47a9bdc5b4 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -10,7 +10,7 @@ struct bpf_perf_event_value___local {
 	__u64 running;
 } __attribute__((preserve_access_index));
 
-/* map of perf event fds, num_cpu * num_metric entries */
+/* map of perf event fds, cpu_id_span * num_metric entries */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__uint(key_size, sizeof(u32));
@@ -38,8 +38,8 @@ struct {
 	__uint(value_size, sizeof(u64));
 } counts SEC(".maps");
 
-const volatile __u32 num_cpu = 1;
 const volatile __u32 num_metric = 1;
+const volatile __u32 cpu_id_span = 1;
 #define MAX_NUM_METRICS 4
 
 SEC("fentry/XXX")
@@ -60,7 +60,7 @@ int BPF_PROG(fentry_XXX)
 						sizeof(*reading));
 		if (err)
 			return 0;
-		key += num_cpu;
+		key += cpu_id_span;
 	}
 
 	return 0;
@@ -100,7 +100,7 @@ int BPF_PROG(fexit_XXX)
 
 	/* read all events before updating the maps, to reduce error */
 	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
-		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
+		err = bpf_perf_event_read_value(&events, cpu + i * cpu_id_span,
 						(void *)(readings + i),
 						sizeof(*readings));
 		if (err)
-- 
2.55.0

