Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C413B14D8;
	Mon, 10 Aug 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355255; cv=none; b=uSyCGsnP/jXixr8Zf+phQL6wVoOdFiCSVSM/4ubujpwzAo5IfYHiQ5kQPr1xpcitNO0gsPm1VttPfcygW1ST8SWBK26lJZ7V1cTYocg/C7ZenrlWJnuQIsexq6vZlI/WruFLuHprXkKeOPRwSEc+CuvcFijsMgcbv/gKjGwTD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355255; c=relaxed/simple;
	bh=I6s2kDHV5NNzxPQuLAUizQd6I7qHgorTT+1ejRTgt9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKSAAfw+0SD69AuECvwpZZtJAROjA7HyqKwLSWWA6WEkCtYKzVfysH+BCp7qEu02PWzwIvHGtDyxWud9numBQwGU/x1E4oiBrYTqGGQM4DPgWwyXyfRQQfR7/Eesz41xm+1CCOAzwlKyQ0QKnlIwzeFWXccpcVvAufHrbTiTR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=buruPEEV; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="buruPEEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GW
	kY9gXXbMY/41WEf65U1kuHVxZQljY30qphw6Dd+ug=; b=buruPEEVXhP8NYvtX3
	xhVLfSLhLGhBd19IamCvN9KazCpTadvRE4hUW3IRoVfqaGmNbnfweygfIO7UaOw0
	RIzQ0QfVlRq0QWlPNfM2d2lGSNTWjux17sffbVvR8f9kQIzIlCENwiY48v2Ytqpa
	U+kqk9eMn6WSzdBRrcMk/4NmA=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3EocEnnlqAlAcOg--.9113S5;
	Mon, 10 Aug 2026 17:46:50 +0800 (CST)
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
Subject: [PATCH bpf-next v2 3/3] bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
Date: Mon, 10 Aug 2026 17:46:34 +0800
Message-ID: <20260810094634.2723213-4-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810094634.2723213-1-chenyuan_fl@163.com>
References: <20260810094634.2723213-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3EocEnnlqAlAcOg--.9113S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWDtr1DAF1rJr4DGrykKrg_yoW8CF17pF
	4DGa90yrs5Jw4xZrsxJrWkWF15G39Yqw48GrW8K3WfZ3s0v3sxtr48AF1UuFyUGrW8Xr4Y
	kF48Xw1FkrWDXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9pnPUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5guiYGp5ngv+KwAA38

From: Yuan Chen <chenyuan@kylinos.cn>

arena_free_pages() and arena_free_worker() now handle range_tree_set()
errors. arena_free_pages() aborts the free on error, and
arena_free_worker() moves range_tree_set() before PTE clearing so that a
failed tree update leaves the PTEs intact instead of freeing pages that
the arena free tree does not track.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/arena.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 555ee2531ef9..b374ebf2a4de 100644
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
@@ -1004,11 +1009,18 @@ static void arena_free_worker(struct work_struct *work)
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

