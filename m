Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFB4DB540;
	Fri, 18 Sep 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726924; cv=none; b=PB6HEvjZzlEp2e8w1hk1dlGuPgQEJfYpG4oD/VVAmayg75GI9HXZZHU+9R42asrfQ93wGrZ8fgkc/EEaA5cc5b0N8MFYnHA62RFq411yzGWQezsv9AKojqXcYFl/Sv9QycZqwvVuY7f1VJKC+A2/G8nEvcj0UiPeuDqi7kqUSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726924; c=relaxed/simple;
	bh=IpmTmJPbWCCXzMxRFjlr3hZ39oPe1qTH63DD57wZHbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioX9G7W7W4gduSa1AxnsRdGNaf0oA998kX7kMa36KSo2tijGsI+8ZSXnKGRaFKAovkoR3Cks8vAVaVh9VWNanhZ3YYCtVNUndL0J6A4iO0fVEZzniKXksKuqXzRBwR9LZ75G0QiUzn8VR/Tw1KxEmR8lBuhTDNjMWW+RVX2C6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FUo00DHF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FUo00DHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sM
	d6B8rglyGSl5JeaOK6WajqLgMQS2WNO6Tr+IYzHCg=; b=FUo00DHFsWV1nOZAJf
	EH6Qm5WrLGnH0JWoeGOzFEEJZIDzd2AEUFpJFAQO+q0+/4Hwa4bHW+X/+fKhXb9K
	oXtjdlcNgbaejGD4+Lawe1Su6gHxAUMusxb+nxogwi4IiE42CeGGZy58m3rnbnn0
	eUF7luVMpWH6v1CqWDHl3C4Ts=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3BxCTEK1qCxUrBg--.58514S2;
	Fri, 18 Sep 2026 18:21:08 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf v2 2/2] bpftool: Fix sparse CPU IDs in prog profile
Date: Fri, 18 Sep 2026 19:20:52 +0900
Message-ID: <20260918102052.1247819-3-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918102052.1247819-1-sh_def@163.com>
References: <20260918102052.1247819-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3BxCTEK1qCxUrBg--.58514S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw48Zw1xWw18ZF4UXrW7twb_yoW3Zryfpa
	n5GF9xKF1kJF9rKw15Ca1DGF43GryxXr4kZ34vg3yrZFWUXr97JF48WFWrKF1FgrWkZFy7
	J3WjkrWxAFWUXFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi5l1kUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hQvjmqtEJT8LQAA3N

bpftool prog profile currently treats the number of possible CPUs as
both the logical CPU ID range and the stride of the perf event array.
That misses valid logical CPUs when the possible CPU mask is sparse, such
as 0,2-3, and can use incorrect PERF_EVENT_ARRAY keys.

Keep the compact possible CPU count for per-CPU result buffers, while
using the actual logical CPU IDs for perf events and the maximum logical
CPU ID plus one as the metric stride in the PERF_EVENT_ARRAY. Keep the
userspace perf file descriptor index separate from the BPF map key. Do
not advance profile_perf_event_cnt for CPUs that return ENODEV, since it
tracks opened userspace perf file descriptors rather than event-array
slots.

Tested:
- Built tools/bpf/bpftool successfully on the host.
- Booted an arm64 QEMU guest with a patched virt device tree reporting
  possible=0,2-3, present=0,2-3, and online=0,2-3.
- Ran both pre-fix and fixed bpftool with cycles and instructions against
  a BTF-enabled fentry target. The pre-fix binary faulted in
  perf_event_alloc(), while the fixed binary reached perf-event setup and
  reported failure to create the instructions event on CPU 0. QEMU did
  not provide a usable hardware PMU runtime result, so no profile counts
  are claimed.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Link: https://lore.kernel.org/bpf/20260813160858.1042834-3-sh_def@163.com/
Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/bpf/bpftool/prog.c                  | 51 +++++++++++++++--------
 tools/bpf/bpftool/skeleton/profiler.bpf.c |  8 ++--
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a9f730d407a9..bb969ffce453 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2148,6 +2148,7 @@ struct profile_metric {
 };
 
 static __u64 profile_total_count;
+static int profile_cpu_cnt;
 
 #define MAX_NUM_PROFILE_METRICS 4
 
@@ -2184,7 +2185,7 @@ static int profile_parse_metrics(int argc, char **argv)
 
 static void profile_read_values(struct profiler_bpf *obj)
 {
-	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
+	__u32 m, cpu, num_cpu = profile_cpu_cnt;
 	int reading_map_fd, count_map_fd;
 	__u64 counts[num_cpu];
 	__u32 key = 0;
@@ -2349,6 +2350,8 @@ static int profile_tgt_fd = -1;
 static char *profile_tgt_name;
 static int *profile_perf_events;
 static int profile_perf_event_cnt;
+static int *profile_cpu_ids;
+static int profile_cpu_id_span;
 
 static void profile_close_perf_events(struct profiler_bpf *obj)
 {
@@ -2358,10 +2361,11 @@ static void profile_close_perf_events(struct profiler_bpf *obj)
 		close(profile_perf_events[i]);
 
 	free(profile_perf_events);
+	profile_perf_events = NULL;
 	profile_perf_event_cnt = 0;
 }
 
-static int profile_open_perf_event(int mid, int cpu, int map_fd)
+static int profile_open_perf_event(int mid, int cpu, int map_key, int map_fd)
 {
 	int pmu_fd;
 
@@ -2371,15 +2375,12 @@ static int profile_open_perf_event(int mid, int cpu, int map_fd)
 		if (errno == ENODEV) {
 			p_info("cpu %d may be offline, skip %s profiling.",
 				cpu, metrics[mid].name);
-			profile_perf_event_cnt++;
 			return 0;
 		}
 		return -1;
 	}
 
-	if (bpf_map_update_elem(map_fd,
-				&profile_perf_event_cnt,
-				&pmu_fd, BPF_ANY) ||
+	if (bpf_map_update_elem(map_fd, &map_key, &pmu_fd, BPF_ANY) ||
 	    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0)) {
 		close(pmu_fd);
 		return -1;
@@ -2391,11 +2392,11 @@ static int profile_open_perf_event(int mid, int cpu, int map_fd)
 
 static int profile_open_perf_events(struct profiler_bpf *obj)
 {
-	unsigned int cpu, m;
+	unsigned int cpu, m, metric_idx = 0;
 	int map_fd;
 
 	profile_perf_events = calloc(
-		obj->rodata->num_cpu * obj->rodata->num_metric, sizeof(int));
+		profile_cpu_cnt * obj->rodata->num_metric, sizeof(int));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
 		      strerror(errno));
@@ -2410,13 +2411,17 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
 		if (!metrics[m].selected)
 			continue;
-		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
-			if (profile_open_perf_event(m, cpu, map_fd)) {
-				p_err("failed to create event %s on cpu %u",
-				      metrics[m].name, cpu);
+		for (cpu = 0; cpu < (unsigned int)profile_cpu_cnt; cpu++) {
+			int cpu_id = profile_cpu_ids[cpu];
+			int map_key = cpu_id + metric_idx * profile_cpu_id_span;
+
+			if (profile_open_perf_event(m, cpu_id, map_key, map_fd)) {
+				p_err("failed to create event %s on cpu %d",
+				      metrics[m].name, cpu_id);
 				return -1;
 			}
 		}
+		metric_idx++;
 	}
 	return 0;
 }
@@ -2430,6 +2435,10 @@ static void profile_print_and_cleanup(void)
 
 	close(profile_tgt_fd);
 	free(profile_tgt_name);
+	free(profile_cpu_ids);
+	profile_cpu_ids = NULL;
+	profile_cpu_cnt = 0;
+	profile_cpu_id_span = 0;
 }
 
 static void int_exit(int signo)
@@ -2440,7 +2449,8 @@ static void int_exit(int signo)
 
 static int do_profile(int argc, char **argv)
 {
-	int num_metric, num_cpu, err = -1;
+	int num_metric, err = -1;
+	int *cpu_ids = NULL;
 	struct bpf_program *prog;
 	unsigned long duration;
 	char *endptr;
@@ -2471,11 +2481,13 @@ static int do_profile(int argc, char **argv)
 	if (num_metric <= 0)
 		goto out;
 
-	num_cpu = libbpf_num_possible_cpus();
-	if (num_cpu <= 0) {
+	profile_cpu_cnt = get_possible_cpu_ids(&cpu_ids);
+	if (profile_cpu_cnt <= 0) {
 		p_err("failed to identify number of CPUs");
 		goto out;
 	}
+	profile_cpu_ids = cpu_ids;
+	profile_cpu_id_span = cpu_ids[profile_cpu_cnt - 1] + 1;
 
 	profile_obj = profiler_bpf__open();
 	if (!profile_obj) {
@@ -2483,11 +2495,12 @@ static int do_profile(int argc, char **argv)
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
@@ -2534,6 +2547,10 @@ static int do_profile(int argc, char **argv)
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
index f48c783cb9f7..2504c3a65bb9 100644
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
@@ -67,7 +67,7 @@ int BPF_PROG(fentry_XXX)
 		if (err)
 			return 0;
 		*(ptrs[i]) = reading;
-		key += num_cpu;
+		key += cpu_id_span;
 	}
 
 	return 0;
@@ -107,7 +107,7 @@ int BPF_PROG(fexit_XXX)
 
 	/* read all events before updating the maps, to reduce error */
 	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
-		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
+		err = bpf_perf_event_read_value(&events, cpu + i * cpu_id_span,
 						(void *)(readings + i),
 						sizeof(*readings));
 		if (err)
-- 
2.55.0

