Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE0411FB3
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586825; cv=none; b=o7Si2vU4Dtczk3vL96mSBp52aHOtXCWBE1E34xi8pRugll4N/hLZ2PV9JakMwpk5cwS32mEQ/sQn4ZvVa7XL+524sJ8uIQ8A4IfKLVJMhYpQTqGJixaNHoimmH2vfhJ+ff1QYVE8Sq1VjLMeZ5psfd72QoEoqWbfNEl565avWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586825; c=relaxed/simple;
	bh=nFE6J1CKKnwOE+mVYybKj5/u4IX7kDiTGlQ6XsjxYHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIfn0vYjw3FYD9DbSgBQWDJPPYfqAeHBWDPNuqkGtkBqifhy+1VnB1E1UgQH3Yrf4N7xLJJn6YOWHZd5mt5PEGE8ei8LIzi8+1dnsqK+l9xsbCqdblnEemIlMbfPOkCa2jIU8SO520dvLMMMdQoZcKK4M7hebk8ohUTbBjqu20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE2voqFb; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE2voqFb"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6bc475ffcbfso677eaf.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586815; x=1790191615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9tmVIvr7xPfv0seaBbrxDE9G49dlPW4Mh9RJl2qJQc=;
        b=NE2voqFbTZG39X1N+1qZUZP5bha+Q26BG42Suz1FYdsXDapdwY1bzJJOE60F4dQ1uV
         9ItVXxtdR9yzti1qamLKq0e//56viJjQUjG/YlkYuNFxMN573vuiVYhFSO0uDVB4iXy2
         ysmzxK+aA+0NxV6KB5izIFoXyyjFTAZ9qu4JqiCfUW/t+0C5kZnCjPJe3vfp9OKMB1Wd
         TXGunq2pTebJDkk0Dl16qV/lfhaRmGg9AdZiLZqe+adsp3frmaDZqIg8KyV++ovN3k9Z
         6jG/HcWmV9TjDKqVJ0Pk5k9xK3dURLR5U0Cvm6p4vczmHX3LDk0YxLg7QQb8Ayb17L5H
         xjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586815; x=1790191615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9tmVIvr7xPfv0seaBbrxDE9G49dlPW4Mh9RJl2qJQc=;
        b=A7ABfHgHcZ3eYmFpCzLGHNDKh4J0AcpBvgdLkHW5R37IGuf5SwU6246KF8mps3SlIq
         oeyM4Xg/pxlI8L7BtMon6gCx1GZS0Ie6MBgC2pO5u1AGsOR5oYntIsN8qzjKmmKwQ5u2
         kHGkS4QbTcmJDlLEkjN5pf5D+TVN5ENChs/50VNGf++E5bavStry4XJBiXz7jK5CTtug
         0ehLAB+uEZ1zLDM5OZfp9b3ysiUOgCqne0QZY6x5M5ThJy8aIeT94sS0YoOW5j6DjsRY
         jQciIbuFFOr9yy5jgeHc4cAYJzh8EYiPpmQVLPUeUjmy6+nOskoaLpJQxVQG8HN/lgxw
         WnFQ==
X-Gm-Message-State: AFuF++mSQJpaAoqVlhnuVMB/unaKja2HkE4Z+eNdGIg1wYwJjy0CmM1j
	qgYIEujwMJyHLQ8vBfLnIESKgjJlWsEpzT/iWl6FAQfA2s04pnF9PdMF
X-Gm-Gg: AYBFou0v4ZlXtGUP6DL9Ft9G46aYg6PhP6UKaD3zqyuUDZ6hhT5APwNhR93T3kKRJrT
	k61jaYgdfBYBt0pFQiOqj38i1UtWG5gO3ZoUPOO8389RfkCOcobwtk3DnCjaWUu2D7oX+MYJYPK
	FoEYTsqCbfzTcofza8D0/2yPiLCSAKjT9l5Z+tSwz/+aDdW3lio/+BNQofcbxqKB/nm3UTDqpIA
	Q4yz0c+srKSnzFos7/x+1oKkgIoaa0w+25R9CCrK0BkQMLeNoHFY5ohi5f6n7mABPUyNaULi+gj
	Q31wf0oaX7jMh+krK0QEp9FqwlRWvs/M5l1MZ9UYShHltybytjs1c8bsBBUOXMaWlb3IQuDnpdQ
	wrK21Nm7v0B+mrz9Nqh2za1Gde4IkusMQU1eB0Sp+xfVxTOkX+qg9bSl32LIac3vCqqk8yy3mw6
	yg6DdEhYKQlKFfeM3arKFsoUG/R3sXk57i4jA0yUYNru4naNG05QLNi/Illi6E8w==
X-Received: by 2002:a05:6820:208a:b0:6b7:46e9:9703 with SMTP id 006d021491bc7-6c7d45e21b8mr3913901eaf.51.1789586815067;
        Wed, 16 Sep 2026 12:26:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c410c804asm845829a34.0.2026.09.16.12.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:26:54 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 16 Sep 2026 12:26:40 -0700
Subject: [PATCH bpf-next v4 1/3] bpftool: Accept zero perf counter
 snapshots
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-bpftool_cyles_per_run-v4-1-f2de02c480d5@meta.com>
References: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
In-Reply-To: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789586810; l=2039;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=N6cBiuyCtJEvTX4BNTZ2xv2mUw7flba3vtF6Gw7gIhw=;
 b=VAKU+dx0xX+tIIS5h3g6TV46e9NMcOGb5e2SoLny26GKhYf2xUhvqK2jdfv4jAAcit5jYdphM
 u0YkJLLVQUyCi3BTn7QCLCMq+OY6Y8/IvtkOc2678JZqnuMSxkZLe+1
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A perf counter can be zero at fentry when PMU multiplexing has
not scheduled the event. Do not reject that sample.

Use enabled time to distinguish a successful snapshot. Read
directly into the per-CPU map value.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/skeleton/profiler.bpf.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index f48c783cb9f7..6685e7252fb5 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -45,28 +45,21 @@ const volatile __u32 num_metric = 1;
 SEC("fentry/XXX")
 int BPF_PROG(fentry_XXX)
 {
-	struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
 	u32 key = bpf_get_smp_processor_id();
 	u32 i;
 
-	/* look up before reading, to reduce error */
 	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
+		struct bpf_perf_event_value___local *reading;
 		u32 flag = i;
-
-		ptrs[i] = bpf_map_lookup_elem(&fentry_readings, &flag);
-		if (!ptrs[i])
-			return 0;
-	}
-
-	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
-		struct bpf_perf_event_value___local reading;
 		int err;
 
-		err = bpf_perf_event_read_value(&events, key, (void *)&reading,
-						sizeof(reading));
+		reading = bpf_map_lookup_elem(&fentry_readings, &flag);
+		if (!reading)
+			return 0;
+		err = bpf_perf_event_read_value(&events, key, (void *)reading,
+						sizeof(*reading));
 		if (err)
 			return 0;
-		*(ptrs[i]) = reading;
 		key += num_cpu;
 	}
 
@@ -80,7 +73,7 @@ fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
 
 	before = bpf_map_lookup_elem(&fentry_readings, &id);
 	/* only account samples with a valid fentry_reading */
-	if (before && before->counter) {
+	if (before && before->enabled) {
 		struct bpf_perf_event_value___local *accum;
 
 		diff.counter = after->counter - before->counter;

-- 
2.53.0-Meta

