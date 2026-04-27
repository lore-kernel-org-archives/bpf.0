Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661E313E36;
	Mon, 27 Apr 2026 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290233; cv=none; b=l7h9iIC9nDd1enxi/FgWaN5bw7tJL2iWvMU0Ykx31RnvndhIBO5abqIQkIrEHg9/CL41Zzy9g42qtuj8XLhhmXTbz8Yrsoj0oaIP5oViS18QmbUCB7PYX5rMswv3d6ZjYKNxTlZlCFw9bGTWw5zfywmJztPSCFJKhPuiEJxBKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290233; c=relaxed/simple;
	bh=pUuKH5IboberfrNDLhIOBfcC/4kG/ZkfQ05hwuIAsi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpmflXyEykROaRKPArtrZ0fl4MlKPO4iVPB4cvy44MluOI2ODiJQPjxdCyNm8Titc88u8O6gzneUhOzs9HcEDaq97CzjhLLqAoyKv5Mco9DmeQJl4CM9x/9U9keWI/Vg9jovNJBmcErbaohncts5VJyceb+ULs7usab/dXhHt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQW9hfF6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQW9hfF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9269C2BCB4;
	Mon, 27 Apr 2026 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777290232;
	bh=pUuKH5IboberfrNDLhIOBfcC/4kG/ZkfQ05hwuIAsi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DQW9hfF6jbPLDZeRU55aAhUUCT+ODmFhcz+2ZZizkNRvhXKvkqWrj2dXV0dCgyT6W
	 WmHOUn7XStj9o+DVmnTv9Wt9Zuky4P03OyheRANyJvSyV6Nn0sfDb6nFmAY4pf7Vhs
	 xdIH43SfcwV/iFb1pUqd3/tkCNUlwR1iB80R9wYWRb871lwJGAkb1nqcsYSU9PqGoS
	 kDpNwk8LJ4Y7KiS5Lfaq7zig8wnCe9GcbvkfrYJ3OcafuKDgfhqvDU/R1HACev+TFT
	 p8om3koW4hnwmMScX8R5DXYYF896On9OeeQBo8nKhJWIF0pdQjGYbiLfAKZrNXunWg
	 RloiRLMR5QZQw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 27 Apr 2026 13:43:16 +0200
Subject: [PATCH 3/3] mm: remove page_mapped()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-page_mapped-v1-3-e89c3592c74c@kernel.org>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
In-Reply-To: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-mm@kvack.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

Let's replace the last user of page_mapped() by folio_mapped() so we
can get rid of page_mapped().

Replace the remaining occurrences of page_mapped() in rmap documentation
by folio_mapped().

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h | 10 ----------
 mm/memory.c        |  2 +-
 mm/rmap.c          |  8 ++++----
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index af23453e9dbd..87fcd068303a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1888,16 +1888,6 @@ static inline bool folio_mapped(const struct folio *folio)
 	return folio_mapcount(folio) >= 1;
 }
 
-/*
- * Return true if this page is mapped into pagetables.
- * For compound page it returns true if any sub-page of compound page is mapped,
- * even if this particular sub-page is not itself mapped by any PTE or PMD.
- */
-static inline bool page_mapped(const struct page *page)
-{
-	return folio_mapped(page_folio(page));
-}
-
 static inline struct page *virt_to_head_page(const void *x)
 {
 	struct page *page = virt_to_page(x);
diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..99854e6a2793 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5464,7 +5464,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	if (unlikely(PageHWPoison(vmf->page))) {
 		vm_fault_t poisonret = VM_FAULT_HWPOISON;
 		if (ret & VM_FAULT_LOCKED) {
-			if (page_mapped(vmf->page))
+			if (folio_mapped(folio))
 				unmap_mapping_folio(folio);
 			/* Retry if a clean folio was removed from the cache. */
 			if (mapping_evict_folio(folio->mapping, folio))
diff --git a/mm/rmap.c b/mm/rmap.c
index 78b7fb5f367c..fb3c351f8c45 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -571,7 +571,7 @@ void __init anon_vma_init(void)
  * In case it was remapped to a different anon_vma, the new anon_vma will be a
  * child of the old anon_vma, and the anon_vma lifetime rules will therefore
  * ensure that any anon_vma obtained from the page will still be valid for as
- * long as we observe page_mapped() [ hence all those page_mapped() tests ].
+ * long as we observe folio_mapped() [ hence all those folio_mapped() tests ].
  *
  * All users of this function must be very careful when walking the anon_vma
  * chain and verify that the page in question is indeed mapped in it
@@ -1999,7 +1999,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
-	 * try_to_unmap() may return before page_mapped() has become false,
+	 * try_to_unmap() may return before folio_mapped() has become false,
 	 * if page table locking is skipped: use TTU_SYNC to wait for that.
 	 */
 	if (flags & TTU_SYNC)
@@ -2426,7 +2426,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
-	 * try_to_migrate() may return before page_mapped() has become false,
+	 * try_to_migrate() may return before folio_mapped() has become false,
 	 * if page table locking is skipped: use TTU_SYNC to wait for that.
 	 */
 	if (flags & TTU_SYNC)
@@ -2927,7 +2927,7 @@ static struct anon_vma *rmap_walk_anon_lock(const struct folio *folio,
 
 	/*
 	 * Note: remove_migration_ptes() cannot use folio_lock_anon_vma_read()
-	 * because that depends on page_mapped(); but not all its usages
+	 * because that depends on folio_mapped(); but not all its usages
 	 * are holding mmap_lock. Users without mmap_lock are required to
 	 * take a reference count to prevent the anon_vma disappearing
 	 */

-- 
2.43.0

