Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797795;
	b=ezn00bm4CwkB/JLjPWyjxd9HELMcpgmoYQxhKgrJ5ukNz64jUc2EmdK+akfOgX+0bXMC
	 XgOb9VzX44GEcFWvRQQG/d4dcs+clQBFeGSN/Xr418wz8LLJEGpb/a5D7WrJtRHf2dAYq
	 lel3rniSWrUcTzr8RBwxOwCYmZU8shaRypMHMHWtxr0NMCtcRSqCMq10I4otluSgBnKXm
	 B8aXtWSpHRZ/kGNiMIAX+mNLv89XJKC/Jl2vo1hKTdMX414oArzd31KnB4MaOg77p5o+N
	 pVfgwzacabvggHb6zofaqEpS6suIYsGaxKKE9O4x4apRFgy5CCBUWNuo8xtaJ5tYM4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797795;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eoW8AaaH7SuVML2GGh9qhcZQMupR/EpkYhtYLlwVTrQ=;
	b=WXRquml8nCHMyXC1tvsMoJktTjbaoPm8NArpdqJavSXci74IsMmC/y6aTWH9FocjNcbX
	 wZe5gQ/bTL4szk93dbVGtZjfA5oU4JNfg0lSq0CV3J94h4rCDsXuP8FpJQ8KFcm7z61IZ
	 R2Pcg0QrN+lBnQNfM6wH3kOTFA1L8ndz25dFOQVZIqi6uqy3zzVqC6Pm/AtT8nZ29iC/k
	 06hXJTYa8iamqWgxWtzpQPr8KHmzaLPx0m0VwbSXPEq4g+Zf/UXzU+pFyquM2P40CUAvU
	 3+sAkKUErNDJp8of2YH8ztoIW/YzRZPXm/ouowNVQ+ZgVwxLudUQSaER2DaQwNSd8BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WGk0gsBy;
	arc=none smtp.remote-ip=95.215.58.83
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAF606D80C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 13:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DAF606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WGk0gsBy
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k6t2SMCBubq6DQa12rUHkyNAtuRpSIKZLV979qtmD3g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793797793; v=1; x=1794402593;
 b=WGk0gsByCVg8HIOfmHpmV4/1nUJkMzwp78iGwmVfBesyI2X3Ci7UdmKkEwrWqk/KeVYj9lym
 aUkmcRHixGfk0iAebVLey/a7ZgAOHACN5JJGMohAwvAxNUS2EF75gFEX5EqXWI7Dw9Ndk3sJSxk
 RH54oIIdO4EgfdhIRlFDVpC8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b3114da408d4d2bc;
	Wed, 04 Nov 2026 13:09:52 +0000
X-Mizu-Trace-ID: b3114da408d4d2bc
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Dave Chinner <david@fromorbit.com>
Cc: David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_)),
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH v7 6/7] mm/mglru: add lruvec_gen_size() helper
Date: Wed,  4 Nov 2026 21:08:16 +0800
Message-Id: <20261104130817.849089-7-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104130817.849089-1-ridong.chen@linux.dev>
References: <20261104130817.849089-1-ridong.chen@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

The number of pages of a given type in a generation is computed by
summing lrugen->nr_pages[gen][type][] over all zones and clamping each
per-zone counter to >= 0, since the counters are updated locklessly and
can transiently go negative. This loop is open-coded in
lruvec_evictable_size() and in the debugfs lru_gen output.

Add lruvec_gen_size() to compute it from a seq, and convert both users.
Put it in mm/vmscan.h so that the vmscan tracepoints, which include that
header, can use it as well.
An upcoming tracepoint and the MGLRU swappiness rework will also use it.

No functional change.

Suggested-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baoquan He <baoquan.he@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 mm/vmscan.c | 18 ++++++------------
 mm/vmscan.h | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 379ac3b148e1..d05050ac49df 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4194,18 +4194,15 @@ static void set_initial_priority(struct pglist_data *pgdat, struct scan_control
 
 static unsigned long lruvec_evictable_size(struct lruvec *lruvec, int swappiness)
 {
-	int gen, type, zone;
+	int type;
 	unsigned long seq, total = 0;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
 	for_each_evictable_type(type, swappiness) {
-		for (seq = min_seq[type]; seq <= max_seq; seq++) {
-			gen = lru_gen_from_seq(seq);
-			for (zone = 0; zone < MAX_NR_ZONES; zone++)
-				total += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
-		}
+		for (seq = min_seq[type]; seq <= max_seq; seq++)
+			total += lruvec_gen_size(lrugen, type, seq);
 	}
 
 	return total;
@@ -5687,20 +5684,17 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 		seq = 0;
 
 	for (; seq <= max_seq; seq++) {
-		int type, zone;
+		int type;
 		int gen = lru_gen_from_seq(seq);
 		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
 
 		seq_printf(m, " %10lu %10u", seq, jiffies_to_msecs(jiffies - birth));
 
 		for (type = 0; type < ANON_AND_FILE; type++) {
-			unsigned long size = 0;
 			char mark = full && seq < min_seq[type] ? 'x' : ' ';
 
-			for (zone = 0; zone < MAX_NR_ZONES; zone++)
-				size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
-
-			seq_printf(m, " %10lu%c", size, mark);
+			seq_printf(m, " %10lu%c",
+				   lruvec_gen_size(lrugen, type, seq), mark);
 		}
 
 		seq_putc(m, '\n');
diff --git a/mm/vmscan.h b/mm/vmscan.h
index adb22e80d760..c6b583fc7493 100644
--- a/mm/vmscan.h
+++ b/mm/vmscan.h
@@ -3,6 +3,7 @@
 #define _MM_VMSCAN_H
 
 #include <linux/gfp_types.h>
+#include <linux/mm_inline.h>
 #include <linux/nodemask.h>
 #include <linux/swap.h>
 #include <linux/types.h>
@@ -115,4 +116,19 @@ struct scan_control {
 	struct reclaim_state reclaim_state;
 };
 
+#ifdef CONFIG_LRU_GEN
+/* The number of pages of @type in the generation @seq, summed over all zones */
+static inline unsigned long lruvec_gen_size(struct lru_gen_folio *lrugen,
+					    int type, unsigned long seq)
+{
+	int gen = lru_gen_from_seq(seq);
+	unsigned long size = 0;
+
+	for (int zone = 0; zone < MAX_NR_ZONES; zone++)
+		size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+
+	return size;
+}
+#endif /* CONFIG_LRU_GEN */
+
 #endif /* _MM_VMSCAN_H */
-- 
2.34.1

