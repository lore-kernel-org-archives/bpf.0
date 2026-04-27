Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FC30F94D;
	Mon, 27 Apr 2026 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290224; cv=none; b=cGp4jVudY01Y8ajXOEVH/8eoBv4n7WtDuKSy65Gbkftopx0CcrqOkYnJGUPFEEMWkUoeIsvgI7N1rkbfS4d9bMJl7KfWs3cKb5W3ych3BCbCyR8uohvsjrbWiw+JzogXBRJhK1Z6YWFWJoqb0EZJ/2ZYOkl0zj1P49bipIpi3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290224; c=relaxed/simple;
	bh=CGNwjR6rvJ+68NLhj05y2pTfObzjJ51LITNuN7MEmD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=perlYE1WqMTCd2figEWWk8XmbQe0pvNXX1UTgW9cH60x8hjJaaK2ZiVK/ybwuFbKA4/u2xZ42gYXEyoZPu+RazU7v5XSUwg541cHaPQuVYvr1zL7bw/5ZfMPky1Tf0YEDJN6D+g11x+3ofjiq2FH5/25lHvK3bWFwJXRna/RdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdf9Pqyw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdf9Pqyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260D6C19425;
	Mon, 27 Apr 2026 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777290224;
	bh=CGNwjR6rvJ+68NLhj05y2pTfObzjJ51LITNuN7MEmD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rdf9PqywdjIWMAOYCFItX9wgSiEVvzPRQJIb7JuPPyrVeuryos8ETgMjPe3mI1Y4r
	 dlzVy0Qfg3wmeeD4HTJU1B3cP1xzYhxi+azF8gG75wSP10LxRD3qP3sAv0/nzamAjO
	 xEal3l0SDC4SPsFZen9s4yVBMa7Y5ULbBb5bUskvD8jJWzGx2lkifkpekak+RpZI+p
	 jg5MPKQS7nrv69MYABY1dDtBQSkOGy4U4YpaIB6qsbPQNkrkhB+MOvwQ0y7N+w75yx
	 HVLrEvfJ445QJZwAEM3X9raDthB94WoG4XVEo4jtvdxMWad88njd52wjvkAyRboxPi
	 ZxuEFJ5rvaPQw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 27 Apr 2026 13:43:15 +0200
Subject: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>
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

Pages that BPF arena code maps are allocated through
bpf_map_alloc_pages(), which does not allocate folios but pages.

In the future, pages will not have a mapcount, only folios will.
Converting the code to use folios and rely on folio_mapped() sounds like
the wrong approach.

Should BPF arena code allocate folios and use folio_mapped() here? But
likely we would not want to use folios here longterm, as we don't really
need folio information.

Hard to tell. But in the meantime, we can simply use the page refcount
instead, as a heuristic whether the page might be mapped to user space
and we would want to try zapping it, so we can get rid of page_mapped().

Page allocation will give us a page with a refcount of 1. Any user space
mapping adds a page reference. While there can be references from other
subsystems (e.g., GUP), in the common case for this test here relying on
the page count is good enough.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 kernel/bpf/arena.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 802656c6fd3c..608c55c260bc 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -729,7 +729,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 
 	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
 		page = llist_entry(pos, struct page, pcp_llist);
-		if (page_cnt == 1 && page_mapped(page)) /* mapped by some user process */
+		if (page_cnt == 1 && page_ref_count(page) > 1) /* maybe mapped by user space */
 			/* Optimization for the common case of page_cnt==1:
 			 * If page wasn't mapped into some user vma there
 			 * is no need to call zap_pages which is slow. When

-- 
2.43.0

