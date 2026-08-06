Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A603016FB;
	Thu,  6 Aug 2026 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785985509; cv=none; b=lSWbjW7OWhd+oPC/dxFAgiBHDNiuNfTGpiAiul8xZhc1SWvQ9I6Z5MDEu3jv5hrxc3ObrMxOxEczaAzRT0MSqfWnllTDpd/bhlm1bOtBfJMcUko2bR4Xy/EdJ69jaozod1YH1xJAoBYwROaW5W2FibCsIQKnZ5KvLAG015jYevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785985509; c=relaxed/simple;
	bh=59Jw3zRm9TCTH/ukrmOHqZ57qnnUVNuotPA4gPymJ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ielrdpDgny+kqc3QKkSM4yeWDmSjPqQsVfAOFxueBbrEco+5p5uzovkrZBQs9bmTVIC6Xnj7AnFC43qhK801HQUf0PMVLQCVb7LNFODymULs8dM4YpUWwlz99NqgfEqNjtXvv+EI9pQ7remLsdf55lFpmW7z7cdiTj8V8cH1A44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IYv6XsyP; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IYv6XsyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=v8
	WBXXWmoYVKo7s1GdOHkU5Kf+aDiIZqc1bD6CJmRFA=; b=IYv6XsyPRk2wyKE2ro
	N7HcmKT2nvxtD/NAQrxq99Hw5GE83Z0aGunzI89Z+i1zBEvAY16Yj6AUUYlTn5CA
	BiUO4nEsZWbj3zXq5lrJRcLaHu+j6AhxUv8xTq5CbBUdtEDXCqr3gHHa/bzdkzeI
	7CEppsXvGT1FhCGLvRvpWc57Y=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3Xy2m+XNqWvt+Kw--.33251S5;
	Thu, 06 Aug 2026 11:04:16 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v1 3/3] bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
Date: Thu,  6 Aug 2026 11:03:59 +0800
Message-ID: <20260806030359.299480-4-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806030359.299480-1-chenyuan_fl@163.com>
References: <20260806030359.299480-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3Xy2m+XNqWvt+Kw--.33251S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr48ZF1fGrW5Wry8Cr4UArb_yoW8Zw1DpF
	4UGa90yr4kX3y7ZrZxJrWkWr15Cwsaqw48GFy8G3Z5Z34avr9IyF48AF1UuFyUGFW8Xr1Y
	kF4Yqw1jkrWDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9ku7UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RAi32pz+bBJXQAA3M

From: Yuan Chen <chenyuan@kylinos.cn>

arena_free_pages() and arena_free_worker() ignore range_tree_set()
errors and proceed to clear PTEs and free pages, even though the range
tree still considers the range allocated.  The range then becomes
permanently unavailable.

Check the return value: in arena_free_pages() abort the free on error;
in arena_free_worker() move range_tree_set() before PTE clearing and
skip the span on error.

Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/arena.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 555ee2531ef9..30745da9277b 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -881,7 +881,12 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	ret = range_tree_set(&arena->rt, pgoff, page_cnt);
+	if (ret) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		return;
+	}
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -1004,11 +1009,17 @@ static void arena_free_worker(struct work_struct *work)
 		kaddr = arena_vm_start + s->uaddr;
 		pgoff = compute_pgoff(arena, s->uaddr);
 
+		/* Mark the range as free before clearing PTEs so that
+		 * if the range tree update fails we leave the PTEs
+		 * intact, avoiding an unrecoverable state where pages
+		 * are freed but the arena free tree does not track them.
+		 */
+		if (range_tree_set(&arena->rt, pgoff, page_cnt))
+			continue;
+
 		/* clear ptes and collect pages in free_pages llist */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
-
-		range_tree_set(&arena->rt, pgoff, page_cnt);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
-- 
2.54.0

