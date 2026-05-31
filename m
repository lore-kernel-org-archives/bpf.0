Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75C62809;
	Sun, 31 May 2026 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246734; cv=none; b=WvUx4IkY1FfXVFVgKaIxsmbB/s6R6q5A2fitBcc+blouptdLELKQvU4kILCfswXzmCHT0gK46+E/ZZNF/oqH9sg2BkIA/DEjWut9RhdizkPWMYwXoJl24P3Ki4Dp6vorATgikxSeT3euPVn57jyvfOdXjPpq+SdtOjq/hQuB0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246734; c=relaxed/simple;
	bh=1Ou7HJkO3L14grfGDZqMSEBhaKT6ODVQdK2XDogdUV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9J4hIuCSnue8coZcpKcn10ob8ddBhaRqkXQRupRw4gfAoy2Uo7wVYmbDbkeUd/mX/fx/38ZzKP9dXdd0TLo5wn3+xcgRg4yOTIRQSRaJYlDwKSWtioYu9wAb02PfDD7gIbL72d2J5b6yinKU3DfwNJK7F+ouxr+NQKv3hhyJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSN+OMvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSN+OMvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CCF1F00893;
	Sun, 31 May 2026 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780246733;
	bh=4XCt6KVwLzptQOI3wbHQqErOB18s5I0OOfXV/KA+Rts=;
	h=From:To:Cc:Subject:Date;
	b=aSN+OMvpJNWqfqcHCr3+rxFW6fn52kxKo091Ma3hITkd5j4S+WCVEGoecvFilaS1S
	 +Y2q4SpBBrK2I/cjUs9X4SaKpTQP8nEGxJ4ao4OFdolkwWfWGEwFJQlWPAzibxIvFU
	 6LoQptQYW7Oq6y2SY2TlONhz13QiO3AIf81H4siVcKGj2+yolg/40T4GrHpuKq11Tg
	 nwuSDj9PFhkcPDoR6BN25dYwPJmGYVFBvTligqcw5VcNxhSkZepy3TqgPMnK6jxPdZ
	 WZeE4p62xz7OmyHAej7Re/BXLyedapj8eK+HKugUtvIUg59gJxEuPdPdp4r7YTmP3T
	 XYGJHq1PMTeNw==
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev
Cc: memxor@gmail.com,
	david@kernel.org,
	emil@etsalapatis.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Overwrite scratch PTE when allocating arena pages
Date: Sun, 31 May 2026 06:58:52 -1000
Message-ID: <20260531165852.555930-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apply_range_set_cb() maps the pages for a new arena allocation. It returned
-EBUSY when the target PTE was already populated.

Kernel-fault recovery can leave the per-arena scratch page in an otherwise
unallocated arena PTE: a BPF program that touched an unallocated address
gets the scratch page installed there. A later bpf_arena_alloc_pages()
covering that page then finds the PTE populated, returns -EBUSY, and leaves
the scratch page in place. Every subsequent allocation of that page fails
the same way.

Drop the must-be-empty check so set_pte_at() installs the real page
unconditionally, overwriting a scratch (or empty) PTE.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
---
 kernel/bpf/arena.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -131,15 +131,13 @@ static int apply_range_set_cb(pte_t *pte
 
 	if (!data)
 		return 0;
-	/* sanity check */
-	if (unlikely(!pte_none(ptep_get(pte))))
-		return -EBUSY;
 
 	page = d->pages[d->i];
 	/* paranoia, similar to vmap_pages_pte_range() */
 	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
 		return -EINVAL;
 
+	/* May be none or the scratch page, overwrite either way */
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
 	d->i++;
 	return 0;
