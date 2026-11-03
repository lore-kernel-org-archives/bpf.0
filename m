Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694521;
	b=4ep93E4dcqsLaabUTURm/zQej+7u0DsTwfpUnRakeo+Ajy63FHP/T+kskJdoZERUgpb7
	 oF1Dz2JdyTq9u8ZZx8hmtHou6DwO6eBq3+zgioDGpBkkY9jOezGlCl+VhSKb9YNxuPN7G
	 0Bh/BSleSKT0gHXYa1RmlW+iy5x3/+tpJ3jwTiD9gdpHTtAFE1/W90mE/AzhFeB06aEUh
	 VxO/9fAkKLScw4KsONROsJZ31YTD3NWsgCcUfPSfJLwv+5mhQkOY3lngLykhUSBaf54S9
	 H9fiVg+zGDMHcg0P65d6c7d/FPyEpfKqB1HsAuQg0SQG6ZniPD6wYpPgbQxeGp9PnEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694521;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+r8pnwhMHB5jLX3oATZwY65Zu2eC59JDXV4HC2urFtw=;
	b=X6D5lib0PCEXdOygkiJq5Cwk2kYxld3WCGXCeq3FbfCKxrpJ+JiK6LOR3UqQ/DcmuUi9
	 JZk0XH/Hds1RFwS6y8og3YorMTfdj5a0TdACKAgw1et1Qk5iC96E72KeZ495W3SgGam71
	 Ua38QstzjEdQ2HqSrW2Hp3bRco/SV861lanAa2iI5VUJ9oOBNViqcWfkvVJBYPpM958aP
	 zRr07mUYnaC0F2yt4dkkBfQvitmW2+5Joha6+f/NcyAaDhmU7haqfDQPgvyijEX2R/GLy
	 ZghpCydrz/FNn0eIeWDRy3FfMf8QodEi9ZhHGEhEqKW5GRtbhabKj+c0vKTmpe/5V4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9Ml+7XL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D8606A324;
	Tue,  3 Nov 2026 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9Ml+7XL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246291F00919;
	Tue,  3 Nov 2026 08:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694521;
	bh=+r8pnwhMHB5jLX3oATZwY65Zu2eC59JDXV4HC2urFtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q9Ml+7XL7Kuk3GUTX3YwuXtB84wQiQO212b9iapqYfTrZMxSxUD9870E4QjPxde7Z
	 +VBXPp2BK4psoSYwtPWPFT0lNNU5ZOfRj1/xsEtAJVXdO6Yl1K8ZqHSXE9REXO8T+O
	 flqv7GTIsCyTzpdfyOaCRz40r5ihfxv0RwZ50H/Dr/CMH0JCUEfazP8VPnRYp3xBm+
	 uoQqlp/wXSp/ulahJmYjE4RLhwo6Nv06EtnyIcosgU8Tctx76oAEKSpZMiwvj/YQ6b
	 rMu9iK7DbIvjNFY4qzFi0F6Abd80x9PzgoqsmkT97vq3vp+xz4K82f6T7dEWLq3cO9
	 HteKyHxjiGzkA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 03 Nov 2026 08:27:46 +0000
Subject: [PATCH 5/5] mm/khugepaged: drop/reacquire mmap read lock if
 skipped enough VMAs
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-khugepaged-latency-fix-v1-5-a07ab16ac860@kernel.org>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
In-Reply-To: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
To: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Waiman Long <longman@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038; i=ljs@kernel.org;
 h=from:subject:message-id; bh=7szhW9anHqn+tjJY4eGPLfmwS6rN78UkiZRvp6JyL8E=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJezub5E/2p1nzGvw2RC0/PE9vdXPljkpbzJDbPr2eLw
 x1/n/10taOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATWefPyLCsRGvj9/87Q+ON
 +JuWvbHUvszw8+Zn+4x4771vXJxDSiYyMlw0E30iNvGZe2Vzo2Vi4cx5afFFmneO+J/RuPjGyi3
 QigcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

khugepaged walks an mm's VMAs under the mmap read lock in
collapse_scan_mm_slot(), checking for ineligible VMAs first, and skipping
them if encountered.

It charges cc->progress 1 page against the 8 * HPAGE_PMD_NR budget when
these are encountered, however only checking this budget once an eligible
PMD-spanning VMA is encountered.

It can therefore hold the mmap read lock for a long time if there are a
large number of ineligible VMAs present in an mm, over which time no mmap
write locks (and thus no VMA write locks) can be acquired.

Address this by dropping + re-acquiring the mmap read lock after
KHUGEPAGED_MAX_SKIP_BATCH VMAs have been processed. Use the newly
introduced mmap_read_lock_nosteal() to ensure queued writers take
precedence when doing so.

This was tested locally with ~1M ineligible VMAs mapped ahead of a
collapsible region of memory, and resulted in a reduced mmap_lock hold time
of 170us down from 95ms.

This was also observed to reduce mmap_lock stalls in concurrent threads of
a similar duration.

KHUGEPAGED_MAX_SKIP_BATCH was derived empirically to a conservative value
of 1024 VMAs, which should not interfere with mm's that have an ordinary
number of VMAs.

Local measurements indicated no change for ordinary use cases, so this is
all upside.

This work came out of investigations into mmap stalls when getting latency
numbers for an unrelated patch series.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/khugepaged.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 216c4b8d28c4..b9c72ee8b421 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -66,6 +66,12 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct kmem_cache *mm_slot_cache __ro_after_init;
 
+/*
+ * The number of VMAs with nothing to scan to walk before dropping and
+ * reacquiring the mmap_lock to relieve lock contention.
+ */
+#define KHUGEPAGED_MAX_SKIP_BATCH 1024
+
 /**
  * struct khugepaged_mm_slot - khugepaged information per mm that is being scanned
  * @slot: hash lookup from mm to mm_slot
@@ -2910,6 +2916,7 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	unsigned int progress_prev = cc->progress;
+	unsigned int skipped = 0;
 
 	lockdep_assert_held(&khugepaged_mm_lock);
 	*result = SCAN_FAIL;
@@ -2951,6 +2958,14 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 			/* Unable to collapse, skip to the next candidate. */
 			mm_slot->address = ALIGN(vma->vm_end, HPAGE_PMD_SIZE);
 			cc->progress++;
+			if (++skipped >= KHUGEPAGED_MAX_SKIP_BATCH) {
+				/* Skipped a lot of VMAs, so wait for writers. */
+				mmap_read_unlock(mm);
+				cond_resched();
+				mmap_read_lock_nosteal(mm);
+				vma_iter_set(&vmi, mm_slot->address);
+				skipped = 0;
+			}
 			continue;
 		}
 		hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);

-- 
2.56.0

