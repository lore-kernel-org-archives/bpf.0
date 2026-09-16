Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7546407CD3
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586830; cv=none; b=OkbuvVQUBnXFp2jXxI2X3yXEG1x2HaRgpN6KZ8/Z/Y7m5YxbWqxpeBANAxwAbnQJGKPx4+1piDqc33vorSZuH/u9wpjgppuIjHzLnOj6PNkL/nqoL0/CYcjb0YjXQRnaafhb8NBpvZVfCRZiKnSlGzm7sR1m4LZeoK8ZvRr/AMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586830; c=relaxed/simple;
	bh=jDhA0970Yy89/0wrmcLFQ358tDm07icJS9C7Sj0kGhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u64E7WEu6HfYNgUK9zdOC0Ekx64IlfbaTje+K0j+vjwIOLDtkqvu8YkBh9zZyVZu3vR7o4fpA00x1z6+f4il3z/fPvTGvolDxDfuq2kO5JP6WQ7dXiRyoBTS9kV+wNpV1VIj1EnPw0gZ/2+UVvW+AMcNc4M/xW52Z3YF8LcP8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObSDt+AN; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObSDt+AN"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2ffee6so33477b6e.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586817; x=1790191617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GwB8jYYkFlpmrcBzZzY3+o2wnkHwG/8nMgSXGP2y9Zc=;
        b=ObSDt+ANEsZNY9SOoN+RaSt+Kr2dTQwVT1Rk6y2HqOEOm++QPyw2rp3kZNmCEiLRW0
         bdlaxRcAznwwzBpB6gAcAQTCJH6BHnkK+RMbcrpI3KJEtJlniCIhz07It1JlGEXgAzZM
         9OpKBWXnXY/ezcAFs2u+hBG2f3pzlzU5ixnYvVuxVfC3wKsFxanOXo0sWPutr13sTCdu
         GIaebOWfrYHF1JdIxI7GLm/+Jd2KjEHe9fxcIc2OYYN0JrWVOpIiVSgg5eUYW3PAE7Q9
         Mt2BjNBkRNHqrQFM2LBvDl1oaANcNocEGOkWpep1mARaJunDlgqUIu5Keu0r2RMxLcqC
         NjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586817; x=1790191617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwB8jYYkFlpmrcBzZzY3+o2wnkHwG/8nMgSXGP2y9Zc=;
        b=uXZS8eq78q6i59hZvgKBt1EYhEWSEovcewQIGpWMNSrxPrSDLPJr38B0FKpofWIk6e
         W8FLcmGsu//8pyvhGB8lRUB1Hy5UDE2+lOMR33nDx09wqu4FuYpRvIUqtLLVSuiO5ACV
         +ycrBUjlmS4f6sdUj/2/HTOBVYv5fyYOj6cz+5L4JrAxk0n89iK/ZWNWGfxxWHTyNgBb
         QrprziclWaTHrw3Id1LHwlqDQEHD6hwHvAshYasKkdFf8n+ZoYXysY65wgyLcgEVpqg5
         qbLjO82rKqlTts5wUHCaYcPSNaf4fkghkIyRK8IPABkLGsnheSNSbRuwMfVzRUMw5ioX
         hZ1w==
X-Gm-Message-State: AFuF++l0THYTwKQHlkl9uSun5cQFVU+oIh0iC5d/Iex7GuQWpixdc5g7
	SVkCO6YDDJXF7CBU8v0UN2aCRrTkwCOzcfq+Av2ZlHmoTslT9ti/xf1b
X-Gm-Gg: AYBFou3FoYk4bzHIHP77TOje7keDcyXHZoGrs2ZRVFtww/DJFbtibyKO6CtyjU+AH+1
	3A7n4BtH/1J0bnkv0c5VetPp+ZC6SNCCo53rUZigxuvR2lOSfEVFblPXmzQ57FpzbikGn60zFSt
	MpfFfJbPHW5ZmoBWNersuQeoUtKifR+Yd7n/wcwiqkudt9VRIQeb2buDkg4rBdH3KJ0b3m/O2F5
	8AeyHEwBpD5eGllNFjZYx0lUYI8IqhnqyiaZTuFz7RG9Xd8cNTqj/GbWuzjr55NBJuvBGjkacD8
	ILwnlbccfMrRczDRzbAEl0ICsP+CoPGTH67O1SvorCRcifONfV/4myn/zcNglmBkL/6C6I5vcWJ
	0Bfll8gUOGaF3Jhd/YOXrINtwyqzURPlwHbG6U9sO93JNJsLou8aGvfh7QvcBVKp8/fQntI2Kw1
	Cm14HZ8lLBr5fgb6fyHUtU+3NBfAsaoTOL9tZL0psWz9IfGJ/Jf4YsyniZo1MH9g==
X-Received: by 2002:a05:6808:5088:b0:4c3:d087:4446 with SMTP id 5614622812f47-4ca4d0fb1bemr4295043b6e.42.1789586817431;
        Wed, 16 Sep 2026 12:26:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb676cb8b8sm751511b6e.0.2026.09.16.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:26:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 16 Sep 2026 12:26:41 -0700
Subject: [PATCH bpf-next v4 2/3] bpftool: Group profile events by CPU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-bpftool_cyles_per_run-v4-2-f2de02c480d5@meta.com>
References: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
In-Reply-To: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789586810; l=4707;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=xRYRhm7NkNQb63U3CUu4LNXYEpiDFKuBY0X1e/IQGog=;
 b=4Qii+vI6s/5eoqP6w8yZy7AljCMTs/16w+R+93eLQIxQTfUcGHV0ewW6/TNB9KLDByxDwEe7X
 J9SMJMDR8VVBuQGqDPumQ+NJ+XPe/7+Qw6d/Um/88Qfg9j0GWQKeowz
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Independently scheduled perf events can cover different intervals,
making derived ratios inconsistent.

Open one event group per CPU and enable it only after all selected
metrics have joined.

Fail the profile setup when a selected event cannot join its group.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/prog.c | 87 +++++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 6ab911e82155..a14a1a9601bd 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2350,7 +2350,7 @@ static char *profile_tgt_name;
 static int *profile_perf_events;
 static int profile_perf_event_cnt;
 
-static void profile_close_perf_events(struct profiler_bpf *obj)
+static void profile_close_perf_events(void)
 {
 	int i;
 
@@ -2361,61 +2361,78 @@ static void profile_close_perf_events(struct profiler_bpf *obj)
 	profile_perf_event_cnt = 0;
 }
 
-static int profile_open_perf_event(int mid, int cpu, int map_fd)
+static int profile_open_perf_event(int mid, int cpu,
+				   int map_fd, int group_fd, __u32 map_key)
 {
+	struct perf_event_attr attr = metrics[mid].attr;
+	bool group_leader = group_fd < 0;
 	int pmu_fd;
+	int err;
 
-	pmu_fd = syscall(__NR_perf_event_open, &metrics[mid].attr,
-			 -1 /*pid*/, cpu, -1 /*group_fd*/, 0);
+	attr.disabled = group_leader;
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */, cpu,
+			 group_fd, 0);
 	if (pmu_fd < 0) {
-		if (errno == ENODEV) {
-			p_info("cpu %d may be offline, skip %s profiling.",
-				cpu, metrics[mid].name);
-			profile_perf_event_cnt++;
-			return 0;
-		}
-		return -1;
+		err = -errno;
+		if (errno == ENODEV && group_leader)
+			p_info("cpu %d may be offline, skip profiling.", cpu);
+		return err;
 	}
 
-	if (bpf_map_update_elem(map_fd,
-				&profile_perf_event_cnt,
-				&pmu_fd, BPF_ANY) ||
-	    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0)) {
+	if (bpf_map_update_elem(map_fd, &map_key, &pmu_fd, BPF_ANY)) {
+		err = -errno;
 		close(pmu_fd);
-		return -1;
+		return err;
 	}
 
 	profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
-	return 0;
+	return pmu_fd;
 }
 
 static int profile_open_perf_events(struct profiler_bpf *obj)
 {
+	__u32 num_cpu = obj->rodata->num_cpu;
+	__u32 map_key;
 	unsigned int cpu, m;
-	int map_fd;
+	int group_fd, map_fd, pmu_fd;
+	int err;
 
-	profile_perf_events = calloc(
-		obj->rodata->num_cpu * obj->rodata->num_metric, sizeof(int));
+	profile_perf_events = calloc(num_cpu * obj->rodata->num_metric,
+				     sizeof(*profile_perf_events));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
 		      strerror(errno));
-		return -1;
+		return -ENOMEM;
 	}
+
 	map_fd = bpf_map__fd(obj->maps.events);
-	if (map_fd < 0) {
-		p_err("failed to get fd for events map");
-		return -1;
-	}
+	for (cpu = 0; cpu < num_cpu; cpu++) {
+		group_fd = -1;
+		map_key = cpu;
+		for (m = 0; m < ARRAY_SIZE(metrics); m++) {
+			if (!metrics[m].selected)
+				continue;
 
-	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
-		if (!metrics[m].selected)
-			continue;
-		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
-			if (profile_open_perf_event(m, cpu, map_fd)) {
-				p_err("failed to create event %s on cpu %u",
-				      metrics[m].name, cpu);
-				return -1;
+			pmu_fd = profile_open_perf_event(m, cpu, map_fd, group_fd,
+						     map_key);
+			if (pmu_fd == -ENODEV && group_fd < 0)
+				break;
+			if (pmu_fd < 0) {
+				p_err("failed to add event %s to group on CPU %u: %s",
+				      metrics[m].name, cpu, strerror(-pmu_fd));
+				return pmu_fd;
 			}
+			if (group_fd < 0)
+				group_fd = pmu_fd;
+			map_key += num_cpu;
+		}
+		if (group_fd < 0)
+			continue;
+		if (ioctl(group_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP)) {
+			err = -errno;
+			p_err("failed to enable perf event group on CPU %u: %s",
+			      cpu, strerror(-err));
+			return err;
 		}
 	}
 	return 0;
@@ -2423,7 +2440,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 
 static void profile_print_and_cleanup(void)
 {
-	profile_close_perf_events(profile_obj);
+	profile_close_perf_events();
 	profile_read_values(profile_obj);
 	profile_print_readings();
 	profiler_bpf__destroy(profile_obj);
@@ -2529,7 +2546,7 @@ static int do_profile(int argc, char **argv)
 	return 0;
 
 out:
-	profile_close_perf_events(profile_obj);
+	profile_close_perf_events();
 	if (profile_obj)
 		profiler_bpf__destroy(profile_obj);
 	close(profile_tgt_fd);

-- 
2.53.0-Meta

