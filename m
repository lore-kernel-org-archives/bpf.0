Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC650EBFC
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796698; cv=none; b=lZecx5MtPNKdptpmiOOPxqEOMSZvH1tIesusHGnuDsCS3uTprxKjRtsVzaG79MkJxcWNzw+4Q1Kq1OX96GsuyWqgLY722T29N95eq0RV4LpfDJqBKEcfwB4cPFpEnT6fUAn4OXfu/86W+5rGrCUj6IgFDQYbLarad7nUFlZaRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796698; c=relaxed/simple;
	bh=qZ0jPtyTR6Io6zNvj/OoaPn4pGWFbk88VIzYJIwg8cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMr0Yu34JOhpQHXhi/GfHp6RIXIKJ9Qw3/xPm1AX6HoM4/XqFNCcLhlzPjv5+Ju/iiZ5CEvhCoP2flFjZFmmWxgvdyAv2XlN2fSaSBPQOQMduPc4WW1IskcMSLJjW6PI+f5GJqgFZI+CpwzXD2EFmsa3N3ye2bGJSoum1sOd5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FjqHIiQa; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FjqHIiQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+k
	REk8V020jP3NcunTybl19+mLva6CkjjQ8Rdvt5ykM=; b=FjqHIiQaz254130mBY
	7HD1HgX7vdhCrjVU/xI5hnwjKbWV/2EGVHoaIkohhDbvk5NHVOj7fupsdZBXulgx
	RomB+3wKv+0lFp4nMBXumto26dv1EFuTxdAZ+6Ljx+KqZjhoa0HgQA3new/7gC6Z
	kGVHSzFquRFGObn34Pn/qE98o=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHe9by3p5qxPRgBA--.1054S2;
	Mon, 07 Sep 2026 23:57:38 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf 2/2] bpftool: Fix sparse CPU IDs in prog profile
Date: Tue,  8 Sep 2026 00:57:35 +0900
Message-ID: <20260907155735.2929529-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907155735.2929529-1-sh_def@163.com>
References: <20260907155735.2929529-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHe9by3p5qxPRgBA--.1054S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw48Zw1xWw18ZF4UXrW7twb_yoWxuryDpa
	95GF98KF1kJF9rKw15Ca1UGF43KryxXr4DZ34vg3yrZFyUXr93XF40gFWrKF1rWrWkZFy7
	Jw1jkrWxZFWUZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWlk7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hI2lWqe3vLs1gAA35

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
Signed-off-by: Hui Su <sh_def@163.com>
Link: https://lore.kernel.org/bpf/20260813160858.1042834-3-sh_def@163.com/
---
 tools/bpf/bpftool/prog.c                  | 35 ++++++++++++++++-------
 tools/bpf/bpftool/skeleton/profiler.bpf.c |  7 +++--
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a9f730d407a9..b1f3d1ce5f0f 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2349,6 +2349,8 @@ static int profile_tgt_fd = -1;
 static char *profile_tgt_name;
 static int *profile_perf_events;
 static int profile_perf_event_cnt;
+static int *profile_cpu_ids;
+static int profile_cpu_id_span;
 
 static void profile_close_perf_events(struct profiler_bpf *obj)
 {
@@ -2358,10 +2360,11 @@ static void profile_close_perf_events(struct profiler_bpf *obj)
 		close(profile_perf_events[i]);
 
 	free(profile_perf_events);
+	profile_perf_events = NULL;
 	profile_perf_event_cnt = 0;
 }
 
-static int profile_open_perf_event(int mid, int cpu, int map_fd)
+static int profile_open_perf_event(int mid, int cpu, int map_key, int map_fd)
 {
 	int pmu_fd;
 
@@ -2371,15 +2374,12 @@ static int profile_open_perf_event(int mid, int cpu, int map_fd)
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
@@ -2391,7 +2391,7 @@ static int profile_open_perf_event(int mid, int cpu, int map_fd)
 
 static int profile_open_perf_events(struct profiler_bpf *obj)
 {
-	unsigned int cpu, m;
+	unsigned int cpu, m, metric_idx = 0;
 	int map_fd;
 
 	profile_perf_events = calloc(
@@ -2411,12 +2411,16 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 		if (!metrics[m].selected)
 			continue;
 		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
-			if (profile_open_perf_event(m, cpu, map_fd)) {
-				p_err("failed to create event %s on cpu %u",
-				      metrics[m].name, cpu);
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
@@ -2430,6 +2434,8 @@ static void profile_print_and_cleanup(void)
 
 	close(profile_tgt_fd);
 	free(profile_tgt_name);
+	free(profile_cpu_ids);
+	profile_cpu_ids = NULL;
 }
 
 static void int_exit(int signo)
@@ -2441,6 +2447,7 @@ static void int_exit(int signo)
 static int do_profile(int argc, char **argv)
 {
 	int num_metric, num_cpu, err = -1;
+	int *cpu_ids = NULL;
 	struct bpf_program *prog;
 	unsigned long duration;
 	char *endptr;
@@ -2471,11 +2478,13 @@ static int do_profile(int argc, char **argv)
 	if (num_metric <= 0)
 		goto out;
 
-	num_cpu = libbpf_num_possible_cpus();
+	num_cpu = get_possible_cpu_ids(&cpu_ids);
 	if (num_cpu <= 0) {
 		p_err("failed to identify number of CPUs");
 		goto out;
 	}
+	profile_cpu_ids = cpu_ids;
+	profile_cpu_id_span = cpu_ids[num_cpu - 1] + 1;
 
 	profile_obj = profiler_bpf__open();
 	if (!profile_obj) {
@@ -2485,9 +2494,11 @@ static int do_profile(int argc, char **argv)
 
 	profile_obj->rodata->num_cpu = num_cpu;
 	profile_obj->rodata->num_metric = num_metric;
+	profile_obj->rodata->cpu_id_span = profile_cpu_id_span;
 
 	/* adjust map sizes */
-	bpf_map__set_max_entries(profile_obj->maps.events, num_metric * num_cpu);
+	bpf_map__set_max_entries(profile_obj->maps.events,
+				 num_metric * profile_cpu_id_span);
 	bpf_map__set_max_entries(profile_obj->maps.fentry_readings, num_metric);
 	bpf_map__set_max_entries(profile_obj->maps.accum_readings, num_metric);
 	bpf_map__set_max_entries(profile_obj->maps.counts, 1);
@@ -2534,6 +2545,8 @@ static int do_profile(int argc, char **argv)
 		profiler_bpf__destroy(profile_obj);
 	close(profile_tgt_fd);
 	free(profile_tgt_name);
+	free(profile_cpu_ids);
+	profile_cpu_ids = NULL;
 	return err;
 }
 
diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index f48c783cb9f7..9486498f7605 100644
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
@@ -40,6 +40,7 @@ struct {
 
 const volatile __u32 num_cpu = 1;
 const volatile __u32 num_metric = 1;
+const volatile __u32 cpu_id_span = 1;
 #define MAX_NUM_METRICS 4
 
 SEC("fentry/XXX")
@@ -67,7 +68,7 @@ int BPF_PROG(fentry_XXX)
 		if (err)
 			return 0;
 		*(ptrs[i]) = reading;
-		key += num_cpu;
+		key += cpu_id_span;
 	}
 
 	return 0;
@@ -107,7 +108,7 @@ int BPF_PROG(fexit_XXX)
 
 	/* read all events before updating the maps, to reduce error */
 	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
-		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
+		err = bpf_perf_event_read_value(&events, cpu + i * cpu_id_span,
 						(void *)(readings + i),
 						sizeof(*readings));
 		if (err)
-- 
2.54.0

