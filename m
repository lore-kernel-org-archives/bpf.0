Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674683;
	b=2dWC1lsHaJsBw8PUPXi/fgSIabIbdswBilXdYap7adS5uzyygVdPp7tTeo0D8WSLxNqR
	 oBhchz7YFn9OKVfkcF79SfNspAlz79rEONH6hHeWsc8DQhV+nfGYgmyMy5OCgXRXtaJWZ
	 advuloGuXcWIXnK2Y5dEh08Br3Uv+y0ls20Y2Wa5l3lAE4IAeivqpFsb5su+t1ONqKzrL
	 pwYvEVEaLqh1lQOB5p19y/aWIvrLf5RKS2XsZsVE/S62kQJIlf5Eo6S5x6UIzj2+f2ozU
	 d/P/X7/iqrtqVMYwrSEuNvt0OsWkPLSzjbEIw+ou3DBUU8sQrabtbsSbMv2IOb8YczA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674683;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4IRpsKB31ZWOQ5n/UsohIDOoT7iKXviBSO161ss/1dE=;
	b=mw/DL+TNi0bKQkVNz3G7fKP9JM/z44eChbr0snPmsfo1Ez8MZDFNxaifnXYdW/GubnPI
	 Zwd8nLiiA8Vs+/lPpj5908W6FtwTb2VMZCxKKs+jLkO0DxR6EFQc+BAXfyWAQNTlsKZSM
	 ychlq8ItUJQFBcdRu4S9Bxiw0IWgIqtuF9pk941d4ABli21QEeQ19Onme7KleLY6ZrEvp
	 ZYtbRnXyH0o3gE/RzbL+I5qvSYPm15SCPoHXm6NReWUMlXyvvxsLSFYnd3e8LeNx4YMbB
	 3Oc4yvDo1eQJ4Fsl40ts7y+Wy6PIje7Xs1B/wwLUWcITnCrDKsxXxHyMowbEZ75j3Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ymnes9hU;
	arc=none smtp.remote-ip=95.215.58.250
Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5F606A329
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C5F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ymnes9hU
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lyrb92uDQUPbkiBltZi1bjdhjSGbJYzJNmN2CpAeRBY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793674680; v=1; x=1794279480;
 b=Ymnes9hUueYcoUxGz5QwDS5GUw1Qmnr7X/K2zXmtGUWjBAqldu6yJuJArKlNuSWuC36/5Kw5
 BCkiEyv5qn7dI9NQNbJMqcVEVyyNlWsdwcoMUU9VOtgUcRweQ7FNGpdbwVe7hR2frOOLJNuqDOu
 ValsYvN1tCUXXv1UX2u6Uwn8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 595423ef5b9c1195;
	Tue, 03 Nov 2026 02:57:59 +0000
X-Mizu-Trace-ID: 595423ef5b9c1195
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Dave Chinner <david@fromorbit.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_)),
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH v6 7/7] mm/mglru: add tracepoint for inc_max_seq()
Date: Tue,  3 Nov 2026 10:56:10 +0800
Message-Id: <20261103025610.3738894-8-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103025610.3738894-1-ridong.chen@linux.dev>
References: <20261103025610.3738894-1-ridong.chen@linux.dev>
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

Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
youngest generation. There is currently no tracepoint on this path, so
the moment a new generation is created, and how the min_seq of each type
trails behind it, cannot be observed as it happens.

Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped while
the lruvec lock is still held, with the node id, memcg id, the new
max_seq, the anon and file min_seq, and the number of pages in each
generation for both types, as computed by lruvec_gen_size().

The nr_anon/nr_file arrays are ordered by seq rather than by generation
slot: entry i holds the generation max_seq - MAX_NR_GENS + 1 + i, i.e.
they go from the oldest generation to the newest, the same order as the
debugfs lru_gen file, so the output can be read directly without mapping
slots back to seqs. Entries for seqs below the corresponding min_seq are
not in use and normally read as 0. The arrays are printed with
__print_array(), so the output is hex and its length follows
MAX_NR_GENS automatically.

Only the lruvec is passed in; all of the above is collected in
TP_fast_assign(), so inc_max_seq() does no extra work when the event is
disabled. Paired with mm_mglru_scan_folios it makes the full
aging-to-eviction window observable per memcg.

Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 mm/trace_vmscan.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c       |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/mm/trace_vmscan.h b/mm/trace_vmscan.h
index 8148b8224422..40d6d90f1d7a 100644
--- a/mm/trace_vmscan.h
+++ b/mm/trace_vmscan.h
@@ -456,6 +456,52 @@ TRACE_EVENT(mm_mglru_scan_folios,
 		__entry->min_seq)
 );
 
+TRACE_EVENT(mm_mglru_inc_max_seq,
+
+	TP_PROTO(struct lruvec *lruvec),
+
+	TP_ARGS(lruvec),
+
+	TP_STRUCT__entry(
+		__field(u64, memcg_id)
+		__field(unsigned long, max_seq)
+		__field(unsigned long, anon_min_seq)
+		__field(unsigned long, file_min_seq)
+		__array(unsigned long, nr_anon, MAX_NR_GENS)
+		__array(unsigned long, nr_file, MAX_NR_GENS)
+		__field(int, nid)
+	),
+
+	TP_fast_assign(
+		struct lru_gen_folio *lrugen = &lruvec->lrugen;
+		unsigned long max_seq = lrugen->max_seq;
+		int i;
+
+		__entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
+		__entry->max_seq = max_seq;
+		__entry->anon_min_seq = lrugen->min_seq[LRU_GEN_ANON];
+		__entry->file_min_seq = lrugen->min_seq[LRU_GEN_FILE];
+		/* from the oldest generation to the newest, as debugfs lru_gen does */
+		for (i = 0; i < MAX_NR_GENS; i++) {
+			unsigned long seq = max_seq - MAX_NR_GENS + 1 + i;
+
+			__entry->nr_anon[i] =
+				lruvec_gen_size(lrugen, LRU_GEN_ANON, seq);
+			__entry->nr_file[i] =
+				lruvec_gen_size(lrugen, LRU_GEN_FILE, seq);
+		}
+		__entry->nid = lruvec_pgdat(lruvec)->node_id;
+	),
+
+	TP_printk("nid=%d memcg_id=%llu max_seq=%lu anon_min_seq=%lu file_min_seq=%lu nr_anon=%s nr_file=%s",
+		__entry->nid,
+		__entry->memcg_id,
+		__entry->max_seq,
+		__entry->anon_min_seq,
+		__entry->file_min_seq,
+		__print_array(__entry->nr_anon, MAX_NR_GENS, sizeof(unsigned long)),
+		__print_array(__entry->nr_file, MAX_NR_GENS, sizeof(unsigned long)))
+);
 #endif /* CONFIG_LRU_GEN */
 
 TRACE_EVENT(mm_vmscan_write_folio,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1581b73aec56..841fefa68d1f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4115,6 +4115,8 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
+
+	trace_mm_mglru_inc_max_seq(lruvec);
 unlock:
 	lruvec_unlock_irq(lruvec);
 
-- 
2.34.1

