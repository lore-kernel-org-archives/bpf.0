Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048AF3FD13E;
	Tue, 24 Mar 2026 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359360; cv=none; b=cD93+tMz7or1WKMmaEnLjhaniahuy1nlbXGnanFkGSx8B/XBAkmISsGlteQWQ87w6RnTtCbmifKJmosK8+St4/2Y2WvApf3w2F/3p2fuWm5KyIk0gvLLZ9p/QFuMRiRIkLZmrMOL+lvBAF3qJ0+0AncHm+J8fTFebY9yC4OK33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359360; c=relaxed/simple;
	bh=xADP0rm/5A6J86K27uPWY5WPSf6+n4q5BYJIGjghh64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tdk7TJVxxA3+ZUJHQB82y0tGPv/zsOg0kV+eVFxllR63sxhVqAm3pwXWpTtOj0y+FMVIoGQrQig2xFfOixxKSJ2M33RRaeu6p74NryaFjwttHN1B8YZE1TrmGb+QsQV29gQaB0r05QXBYUxJya/TGI2XhY8DtaSQwwe0PCgFPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sJeqMj4O; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sJeqMj4O"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6612E153B;
	Tue, 24 Mar 2026 06:35:52 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.1.194.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF4D53F836;
	Tue, 24 Mar 2026 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774359358; bh=xADP0rm/5A6J86K27uPWY5WPSf6+n4q5BYJIGjghh64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJeqMj4O98zAEbsTjrVz5tXtlZVYLL4LLuISN8B/lwdt6aWMYBYphHrjL2uArrIyR
	 LloZr+APg0KxpiW113TjXa47nKksNUMIvwhu5ezfLD83yNX8pvq9lu4zA1vSkEBc1O
	 A6YXrN6qCwkkQhwT6Gyi/p9DjKxmpuW1cEbaOT5A=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Ryan.Roberts@arm.com,
	david.hildenbrand@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: [PATCH v3 3/3] mm/page_alloc: Optimize __free_contig_frozen_range()
Date: Tue, 24 Mar 2026 13:35:34 +0000
Message-ID: <20260324133538.497616-4-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324133538.497616-1-usama.anjum@arm.com>
References: <20260324133538.497616-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply the same batch-freeing optimization from free_contig_range() to the
frozen page path. The previous __free_contig_frozen_range() freed each
order-0 page individually via free_frozen_pages(), which is slow for the
same reason the old free_contig_range() was: each page goes to the
order-0 pcp list rather than being coalesced into higher-order blocks.

Rewrite __free_contig_frozen_range() to call free_pages_prepare() for
each order-0 page, then batch the prepared pages into the largest
possible power-of-2 aligned chunks via free_prepared_contig_range().
If free_pages_prepare() fails (e.g. HWPoison, bad page) the page is
deliberately not freed; it should not be returned to the allocator.

I've tested CMA through debugfs. The test allocates 16384 pages per
allocation for several iterations. There is 3.5x improvement.

Before: 1406 usec per iteration
After:   402 usec per iteration

Before:

    70.89%     0.69%  cma              [kernel.kallsyms]      [.] free_contig_frozen_range
            |
            |--70.20%--free_contig_frozen_range
            |          |
            |          |--46.41%--__free_frozen_pages
            |          |          |
            |          |           --36.18%--free_frozen_page_commit
            |          |                     |
            |          |                      --29.63%--_raw_spin_unlock_irqrestore
            |          |
            |          |--8.76%--_raw_spin_trylock
            |          |
            |          |--7.03%--__preempt_count_dec_and_test
            |          |
            |          |--4.57%--_raw_spin_unlock
            |          |
            |          |--1.96%--__get_pfnblock_flags_mask.isra.0
            |          |
            |           --1.15%--free_frozen_page_commit
            |
             --0.69%--el0t_64_sync

After:

    23.57%     0.00%  cma              [kernel.kallsyms]      [.] free_contig_frozen_range
            |
            ---free_contig_frozen_range
               |
               |--20.45%--__free_contig_frozen_range
               |          |
               |          |--17.77%--free_pages_prepare
               |          |
               |           --0.72%--free_prepared_contig_range
               |                     |
               |                      --0.55%--__free_frozen_pages
               |
                --3.12%--free_pages_prepare

Suggested-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
Changes since v2:
- Rework the loop to check for memory sections just like __free_contig_range()
- Didn't add reviewed-by tags because of rework
---
 mm/page_alloc.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 250cc07e547b8..26eac35ef73bd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7038,8 +7038,30 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
 
 static void __free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages)
 {
-	for (; nr_pages--; pfn++)
-		free_frozen_pages(pfn_to_page(pfn), 0);
+	struct page *page = pfn_to_page(pfn);
+	struct page *start = NULL;
+	unsigned long start_sec;
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++, page++) {
+		if (!free_pages_prepare(page, 0)) {
+			if (start) {
+				free_prepared_contig_range(start, page - start);
+				start = NULL;
+			}
+		} else if (start &&
+			   memdesc_section(page->flags) != start_sec) {
+			free_prepared_contig_range(start, page - start);
+			start = page;
+			start_sec = memdesc_section(page->flags);
+		} else if (!start) {
+			start = page;
+			start_sec = memdesc_section(page->flags);
+		}
+	}
+
+	if (start)
+		free_prepared_contig_range(start, page - start);
 }
 
 /**
-- 
2.47.3

