Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C617D2;
	Fri,  6 Mar 2026 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782347; cv=none; b=FXfJBBKP4eFmVEEDwvO0ZAk6k2EtS7UIhNd5fK1uG7r/w7f+OJQLF7WVjV2B0F/ZVfJnMAWlzAUOl9/0zFDG8dcLxwBxEFPeM/ga2s4YIWyiGFV4RdEfRAnIOVyMrVhly1HgmQbO3wyMXvBjHN8itJcVPI0Bx7PTXsXrLj72JfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782347; c=relaxed/simple;
	bh=/1tjs1txaxspQo84xrzGcDbG3nJgdeSmSFC0uzTi9Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rh9iKwoaHutFqWRP3zKtI17t/mFMhtuiwRke9NvuhyLsIR5tNga6zJ6Efx7sAdNMplBGA2w7Iv226ZSOcpXyhI1fu8F6KRO/Fg/a+nt+/kMlk1titspqmqP/IOu9b+0i8CBi2jAfSRPso8/M1saoNPauNQF9nd90BuFMeTI8/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZfRUoi+m; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZfRUoi+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=UZ
	gWiBAvLd+YXyCRU//RkZvAYeiAPrFvirUav+rFLbE=; b=ZfRUoi+md3s6mp4s6+
	8nNFGzXr2KgLXB4HsHzJKoUucQifHKdj3LofN2r+qJUlR/d1UTWZxorCp7+/ur7A
	HOyoOspnejQ8ufWF0uwkQgMDekXJlc3hLa+W6h8i6+AHDd16QQkwWLGJ7bUeRsd0
	NHCsvlEmQCMwdwVkNvuK8HZ2U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCHt9PNgqppuc55BQ--.55212S5;
	Fri, 06 Mar 2026 15:31:27 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	emil@etsalapatis.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 3/3] tools/sched_ext: scx_sdt: Fix BPF verifier rejection on older LLVMs
Date: Fri,  6 Mar 2026 15:31:10 +0800
Message-ID: <20260306073110.229595-4-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306073110.229595-1-zhaomzhao@126.com>
References: <20260306073110.229595-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgCHt9PNgqppuc55BQ--.55212S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw45WFW7Jw1xXF1UuFyDJrb_yoW7XFW7pF
	WUJFyDXF1Utrn3Arn7t3ZYyrs3CanrXr1UWayrKrn7Z3sI9wnrX34Ikw1Fvr4qyrWSyay3
	ZFZrC3Z2qF15JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5wIDUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlhDZUWmqgtDojAAA37

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Under Clang 17/18, when running scx_sdt scheduler, it fails with:

libbpf: prog 'sdt_init_task': BPF program load failed: -EACCES
libbpf: prog 'sdt_init_task': -- BEGIN PROG LOAD LOG --
...
; desc = desc_find_empty(alloc->root, &idx); @ scx_sdt.bpf.c:479
43: (79) r8 = *(u64 *)(r6 +32)        ; frame1: R6=map_value(map=scx_sdt.bss,ks=4,vs=200,off=120) R8=scalar()
; for (level = zero; level < SDT_TASK_LEVELS && can_loop; level++) { @ scx_sdt.bpf.c:407
44: (e5) may_goto pc+51
; idx |= pos; @ scx_sdt.bpf.c:418
96: (bf) r7 = r2                      ; frame1: R2=0 R7=0
97: (bf) r1 = r10                     ; frame1: R1=fp0 R10=fp0
;  @ scx_sdt.bpf.c:0
98: (07) r1 += -56                    ; frame1: R1=fp-56
; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
99: (b4) w2 = 0                       ; frame1: R2=0
100: (b4) w3 = 3                      ; frame1: R3=3
101: (85) call bpf_iter_num_new#82234         ; frame1: R0=scalar() fp-56=iter_num(ref_id=2,state=active,depth=0)
102: (18) r9 = 0x1ffffffffffffff8     ; frame1: R9=0x1ffffffffffffff8
104: (bf) r1 = r10                    ; frame1: R1=fp0 R10=fp0
;  @ scx_sdt.bpf.c:0
105: (07) r1 += -56                   ; frame1: R1=fp-56
; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
106: (85) call bpf_iter_num_next#82235        ; frame1: R0=0 fp-56=iter_num(ref_id=2,state=drained,depth=0)
107: (15) if r0 == 0x0 goto pc+29     ; frame1: R0=0
; if (tmp->nr_free > 0) @ scx_sdt.bpf.c:456
137: (bf) r1 = r10                    ; frame1: R1=fp0 R10=fp0
; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
138: (07) r1 += -56                   ; frame1: R1=fp-56
139: (85) call bpf_iter_num_destroy#82232     ; frame1:
140: (b7) r9 = 0                      ; frame1: R9=0
; if (unlikely(desc == NULL)) { @ scx_sdt.bpf.c:480
141: (15) if r8 == 0x0 goto pc+15     ; frame1: R8=scalar(umin=1)
; chunk = desc->chunk; @ scx_sdt.bpf.c:485
142: (79) r4 = *(u64 *)(r8 +72)
R8 invalid mem access 'scalar'

The reason is these older compilers lacks native support for
__BPF_FEATURE_ADDR_SPACE_CAST, __arena macro is defined as empty.

Fix it by adding cast_kern when dereferencing variables with __arena tag.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/sched_ext/scx_sdt.bpf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
index 31b09958e8d5..caacc55bd7a5 100644
--- a/tools/sched_ext/scx_sdt.bpf.c
+++ b/tools/sched_ext/scx_sdt.bpf.c
@@ -148,6 +148,7 @@ static sdt_desc_t *scx_alloc_chunk(void)
 
 	out = desc;
 
+	cast_kern(desc);
 	desc->nr_free = SDT_TASK_ENTS_PER_CHUNK;
 	desc->chunk = chunk;
 
@@ -244,6 +245,7 @@ int mark_nodes_avail(sdt_desc_t *lv_desc[SDT_TASK_LEVELS], __u64 lv_pos[SDT_TASK
 		/* Only propagate upwards if we are the parent's only free chunk. */
 		desc = lv_desc[level];
 
+		cast_kern(desc);
 		ret = set_idx_state(desc, lv_pos[level], false);
 		if (unlikely(ret != 0))
 			return ret;
@@ -298,20 +300,26 @@ int scx_alloc_free_idx(struct scx_allocator *alloc, __u64 idx)
 		if (level == SDT_TASK_LEVELS - 1)
 			break;
 
+		cast_kern(desc);
 		chunk = desc->chunk;
 
+		cast_kern(chunk);
 		desc_children = (sdt_desc_t * __arena *)chunk->descs;
+		cast_kern(desc_children);
 		desc = desc_children[pos];
 
 		if (unlikely(!desc))
 			return -EINVAL;
 	}
 
+	cast_kern(desc);
 	chunk = desc->chunk;
 
 	pos = idx & mask;
+	cast_kern(chunk);
 	data = chunk->data[pos];
 	if (likely(data)) {
+		cast_kern(data);
 		*data = (struct sdt_data) {
 			.tid.genn = data->tid.genn + 1,
 		};
@@ -378,6 +386,7 @@ __u64 chunk_find_empty(sdt_desc_t __arg_arena *desc)
 	__u64 freeslots;
 	__u64 i;
 
+	cast_kern(desc);
 	for (i = 0; i < SDT_TASK_CHUNK_BITMAP_U64S; i++) {
 		freeslots = ~desc->allocated[i];
 		if (freeslots == (__u64)0)
@@ -426,9 +435,12 @@ static sdt_desc_t * desc_find_empty(sdt_desc_t *desc, __u64 *idxp)
 			break;
 
 		/* Allocate an internal node if necessary. */
+		cast_kern(desc);
 		chunk = desc->chunk;
+		cast_kern(chunk);
 		desc_children = (sdt_desc_t * __arena *)chunk->descs;
 
+		cast_kern(desc_children);
 		desc = desc_children[pos];
 		if (!desc) {
 			desc = scx_alloc_chunk();
@@ -448,6 +460,7 @@ static sdt_desc_t * desc_find_empty(sdt_desc_t *desc, __u64 *idxp)
 		level = SDT_TASK_LEVELS - 1 - u;
 		tmp = lv_desc[level];
 
+		cast_kern(tmp);
 		ret = set_idx_state(tmp, lv_pos[level], true);
 		if (ret != 0)
 			break;
@@ -482,10 +495,12 @@ void __arena *scx_alloc(struct scx_allocator *alloc)
 		return NULL;
 	}
 
+	cast_kern(desc);
 	chunk = desc->chunk;
 
 	/* Populate the leaf node if necessary. */
 	pos = idx & (SDT_TASK_ENTS_PER_CHUNK - 1);
+	cast_kern(chunk);
 	data = chunk->data[pos];
 	if (!data) {
 		data = scx_alloc_from_pool(&alloc->pool);
@@ -503,10 +518,12 @@ void __arena *scx_alloc(struct scx_allocator *alloc)
 	alloc_stats.alloc_ops += 1;
 	alloc_stats.active_allocs += 1;
 
+	cast_kern(data);
 	data->tid.idx = idx;
 
 	bpf_spin_unlock(&alloc_lock);
 
+	cast_user(data);
 	return data;
 }
 
@@ -544,9 +561,10 @@ void __arena *scx_task_alloc(struct task_struct *p)
 	if (unlikely(!data))
 		return NULL;
 
+	mval->data = data;
+	cast_kern(data);
 	mval->tid = data->tid;
 	mval->tptr = (__u64) p;
-	mval->data = data;
 
 	return (void __arena *)data->payload;
 }
-- 
2.43.0

