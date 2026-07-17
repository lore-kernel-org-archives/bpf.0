Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8853A7F60
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288600; cv=none; b=m6zlDFZBzwOJSOGypeUz0gAEW2rVk4QE0AOKGnIliR1X9KA7cnxKuFtgwwe2SUf/f4be4W2mB8JCkMTboNc1svfadIaE5/j4GVlQEPeeMDOY1T3XX7kTkVdYiEplgpHsapGAwueDKY2HDgYio2VanHO7rUhCxBKhScNghLQ7Gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288600; c=relaxed/simple;
	bh=R/PjILtLGH0Og7Z6ijXBQuX230HRVp0zhLQ4KuBkfpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcmOSGgviigRiC9V3mujY7lTsvJ7SNAYu4EEhE4FEuebzweNEt9S/iqdI3YLBFwAaKlqouz3fYnUn3DXZQL1V03NlD1/GQXBIp9LheJ1+bwbKVENk9MSAhZGuh36ody9WIVO5fOJHm3i60Q80tfaznWcGft4kfHSykNL1/yUXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FCBIpIbe; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FCBIpIbe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784288596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EG3yfFOxHkF+iZYHcUrq5joNhYwWSGYUc8Ed1Yg5oiw=;
	b=FCBIpIbef36YErJZJuOhzh740U/sqWq1Yxm6O2i4n8no89kAd/UcrcgsJHokA+cQTcand1
	nW8OIYKXNC0lxedyHuPNeBNeaXgDf2JzAp8cQH6Ez19vYFw2jpuiQMYugz8EHo/gVOTp/s
	q6PiqkUav9/EsOsjTOFVlAWV/Rj2b24=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Woojin Ji <random6.xyz@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/4] bpf: Add memory usage for arena
Date: Fri, 17 Jul 2026 19:37:02 +0800
Message-ID: <20260717114117.350851-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260717114117.350851-1-jiayuan.chen@linux.dev>
References: <20260717114117.350851-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

arena is the only map type whose map_mem_usage() still returns 0, so
"bpftool map show" and fdinfo always showed 0 memlock for an arena no
matter how many pages it had.

Count the pages that are actually mapped into the arena: bump a counter in
apply_range_set_cb() when a page goes in and drop it in
apply_range_clear_cb() when a page goes out, both under the arena spinlock.
map_mem_usage() then just returns nr_pages << PAGE_SHIFT.

Only real data pages are counted, not the scratch page.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
To sashiko:
1. __bpf_alloc_page::can_alloc_pages already check whether we are under lock.
2. apply_to_page_range() does not allocate page tables here. arena_map_alloc() already did it.
---
 kernel/bpf/arena.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 8dbc24460890..f046e878f7ae 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -55,8 +55,10 @@ struct bpf_arena {
 	struct vm_struct *kern_vm;
 	struct page *scratch_page;
 	struct range_tree rt;
-	/* protects rt */
+	/* protects rt and nr_pages */
 	rqspinlock_t spinlock;
+	/* number of pages currently populated in the arena */
+	u64 nr_pages;
 	struct list_head vma_list;
 	/* protects vma_list */
 	struct mutex lock;
@@ -196,6 +198,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 	set_pte_at(&init_mm, addr, pte, pteval);
 #endif
 	d->i++;
+	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages + 1);
 	return 0;
 }
 
@@ -231,6 +234,7 @@ static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
 		return 0;
 
 	__llist_add(&page->pcp_llist, d->free_pages);
+	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages - 1);
 	return 0;
 }
 
@@ -413,7 +417,9 @@ static int arena_map_check_btf(struct bpf_map *map, const struct btf *btf,
 
 static u64 arena_map_mem_usage(const struct bpf_map *map)
 {
-	return 0;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	return (u64)READ_ONCE(arena->nr_pages) << PAGE_SHIFT;
 }
 
 struct vma_list {
-- 
2.43.0

