Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074583E168A;
	Mon, 10 Aug 2026 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369764; cv=none; b=JY4VpxOUXkS+swwsHWKM5nWm/D92+5kGOeQ3K71n7GHoaEUJLlz2O0hqozp3O249lCXAbp14amarAp+INHQSnbinUWNtUnKpX9Ts/ZpZ92n7b2bPJ5qEbimeg4qh2/U/KhONuMGNwgN8VxuEcVOEXtQwpronryf7VkNt4MwnVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369764; c=relaxed/simple;
	bh=Ow+GUhBa0rYrOzu+TOd8Giv7ZdKkyrHqBi7vdrmrpak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6078q5rQEaNFxgV8DEFMbnZ+eIglmhd7OPqUyqLSdqdxOFXG0RolxgNV0D3Hrx/9PKDsLKr7vhUsqeGbl2D3spOpMNG8Kt1dZ/gIIa6nvPZ+zuIRpDbfiwZATU+6GJbUm6zbNDYT3aDNWTlYBhApfUIQsnDHDHSfEnJZx3JAYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kpj/rklD; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kpj/rklD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9Y
	Og8U53lS/fw3psYdBRrJ5Kb6g8ticHNZVmkoqWgo0=; b=kpj/rklDl1H/PMA4sj
	bR77oTDdkjXdyTmVX7KFZ1b4LVu294Q7MJKVlAxQFGITlphlop29vw3WILDoxqpe
	X/00dISTuy82bpDlCbvm8zYGI8pMfgFkeNZL/Lz2mpQZrPCB7BuJ3orhvkMTimXZ
	qEij/6yoMN7E3R3Bj/cslubqA=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnJImg1nlqBKwLPA--.27752S5;
	Mon, 10 Aug 2026 21:48:23 +0800 (CST)
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
Subject: [PATCH bpf-next v3 3/3] bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
Date: Mon, 10 Aug 2026 21:48:00 +0800
Message-ID: <20260810134800.2875487-4-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810134800.2875487-1-chenyuan_fl@163.com>
References: <20260810134800.2875487-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnJImg1nlqBKwLPA--.27752S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWrCFy7CF17Gr47Xw1rCrg_yoW5Xw1fpF
	4UJa9Yyrs5Jw4xAr43GrWv9rn8G39Yqa18G34UK3WrZ34av3srtF48AF1UuFyUGFW8Xr4U
	KF4UXw1YkrWDZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9pnPUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gjYlmp51qjLVgAA3Q

From: Yuan Chen <chenyuan@kylinos.cn>

arena_free_pages() and arena_free_worker() now handle range_tree_set()
errors. arena_free_pages() aborts the free on error, and
arena_free_worker() moves range_tree_set() before PTE clearing so that a
failed tree update leaves the PTEs intact instead of freeing pages that
the arena free tree does not track.

Also check the range_tree_set() return value in arena_alloc_pages()'s
error path, which restores the unpopulated tail of a partially allocated
range; log a warning instead of silently leaking the virtual range when
the tree update fails.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/arena.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 555ee2531ef9..d57a0b617525 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -766,7 +766,9 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	if (range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped))
+		pr_warn_ratelimited("bpf_arena: failed to restore free range %ld+%ld after partial alloc\n",
+				    pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped) {
 		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
@@ -881,7 +883,12 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
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
@@ -1004,11 +1011,18 @@ static void arena_free_worker(struct work_struct *work)
 		kaddr = arena_vm_start + s->uaddr;
 		pgoff = compute_pgoff(arena, s->uaddr);
 
+		/*
+		 * Mark the range as free before clearing PTEs so that
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

