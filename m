Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781821;
	b=Kp2y5nqJKyW9Oefleb/wvfbTHSJBgo8w1yZ4ciA1V+/lEEwz9XR13vMgz/qPCDjHrJI2
	 bpDSSICIxlDfLUE3jbZuKTVJKFmML8A+6Dsh+h9XuPEmyG4EctW7hr/8G4FUAipbrnpah
	 GIO+qTpViZdrVsM+CCkDUJfJfRRbl2d8TgydLnfv8PmQF+x6Um206Tu6g9pdBQrsKfgG4
	 vvBO0aNbT9evs+oiF1Bq94IpaC+L2RZX7Eqjy910V8ER202GqKtYEhabUUUGecMaEVzHj
	 oIBRi9As3vJkMW1DN6iDecwWvqhvrnEIxZN3YuPIoK6WPg0Co9XuDl0M8ltoBLky+wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781821;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f2hk/rNUhdh8MzoGh+JB++bhZwGGGXc0fWWdJjx7Q34=;
	b=AMF2FkMWGXZRSGdqJ8O1SDziFiebkZwIEe1/zn3djoXKi99XOeMWTCkhpuZyrvWJl000
	 7BWwOebvPSYqfqaWhJ/Vf/o6roh89XmF0MzRUMOxA42JT2N6NU0kduAiOazac+A5y4G+i
	 KQfoK7+b1n9gzj+FUreJIj683sDvPfMBpBiSNDGzLH+J7zRfribqqTthBHA55Y1nHQVua
	 az4x411Qn0ZS0vhE52s94j8MzLc0v5+Vum7/5feXUvRn8GxhCM9KFdTsisuuxP04uh/AI
	 yXnFxm63ohMGaYYo+YBrbwSt/dWgfMOo/EOH/KFTiRSRVBh+dmRMs+y147mTOqcg2rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sp83wNpG;
	arc=none smtp.remote-ip=95.215.58.223
Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FAF606A335
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 08:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15FAF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sp83wNpG
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f2hk/rNUhdh8MzoGh+JB++bhZwGGGXc0fWWdJjx7Q34=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793781817; v=1; x=1794386617;
 b=sp83wNpGcg3gaaZ8Q1xR/9GuIAN39T9nU3daATAk0D3PyazINZZkLbge+C8jvkhlT/l1yMyQ
 z4PY8O3ch/eBLnfTIKoQOWvUBUqWReMoaFrNfi96CuAqZM2S8rXHR4UmnarPZPvmVgtfzb2K9u1
 F4JsYvveNIOBOxe1A0qJ86Lg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3c5b907775b29065;
	Wed, 04 Nov 2026 08:43:36 +0000
X-Mizu-Trace-ID: 3c5b907775b29065
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	surenb@google.com,
	vbabka@kernel.org,
	shakeel.butt@linux.dev,
	yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/5] mm/khugepaged: scan mm's more efficiently under mmap_lock contention
Date: Wed,  4 Nov 2026 16:43:26 +0800
Message-ID: <20261104084326.35457-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261103-khugepaged-latency-fix-v1-2-a07ab16ac860@kernel.org>
References: <20261103-khugepaged-latency-fix-v1-2-a07ab16ac860@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Nov 03, 2026 at 08:27:43AM +0000, Lorenzo Stoakes (ARM) wrote:
>Ostensibly khugepaged collapse traverses eligible mm's, scanning up to
>/sys/kernel/mm/transparent_hugepage/khugepaged/pages_to_scan eligible pages
>at a time, sleeping for /sys/.../scan_sleep_millisecs between each
>traversal.
>
>mm's are scanned in collapse_scan_mm_slot() under the mmap read lock,
>obtained using mmap_read_trylock(), skipping the mm if there is lock
>contention, and dropping the lock before allocation.
>
>khugepaged will keep scanning the same mm until it is about to be torn
>down, prctl(PR_SET_THP_DISABLE) disables THP for it, mm->mmap_lock
>contention occurs, or all its VMAs have been scanned.
>
>When any of these occur, khugepaged doesn't keep track of where it left
>off, as the current address is tracked in
>khugepaged_scan.address (essentially a global value), which is reset.
>
>This is a problem when lock contention occurs, as when the mm is next
>scanned, it starts from address 0 again.
>
>If there's a lot of mmap_lock contention this can significantly slow down
>collapse later in the mm, since the /sys/.../pages_to_scan budget can run
>out before the end of the mm is reached.
>
>The budget is incremented (as tracked in cc->progress) at a rate of 1 page
>per ineligible VMA, but the budget is only checked once eligible VMAs are
>encountered.
>
>Then, it only takes the combined total of ineligible VMAs and eligible but
>non-collapsible pages to exceed the /sys/.../pages_to_scan budget for the
>rest of the mm to be skipped.
>
>For a system with 4 KiB page size and default sysctl settings this only
>requires 4096 ineligible VMAs/uncollapsible pages to be skipped before this
>happens.
>
>Examples of eligible but uncollapsible ranges are those containing a large
>number of forked PTE entries (more than /sys/.../max_ptes_shared), swapped
>out PTE entries (more than /sys/.../max_ptes_swap) or none or zero-page PTE
>entries (more than /sys/.../max_ptes_none).
>
>The latter might seem unlikely to happen given /sys/.../max_ptes_none
>defaults to HPAGE_PMD_NR - 1 and CONFIG_PT_RECLAIM frees PTE page tables,
>however CONFIG_PT_RECLAIM only removes the page table if the zapped range
>spans at least a PMD size (see pte_table_reclaim_possible()).
>
>Thus, userland software that applies madvise(..., MADV_DONTNEED) across
>sub-PMD ranges can thwart this, which is quite feasible for memory
>allocators and GC heaps, for instance.
>
>Resolve the issue by simply tracking the last examined address in the
>khugepaged_mm_slot object, so when the mm is resumed, the scan starts from
>where it left off.
>
>Additionally, skip to the next candidate if a VMA cannot be collapsed.
>
>This issue was noticed during some work in which an mm was instantiated
>with a large number of small VMAs under significant mmap_lock contention,
>during which collapse was observed to take 10.8s. With this patch applied
>it took 3.6s to collapse the same mm.
>
>Also, while here, update a couple VM_BUG_ON()'s to VM_WARN_ON_ONCE()'s.
>
>This patch is also a pre-requisite for a later patch in this series.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Looks good on its own, since vmi isn't reset inside the loop yet. Patch
#05 will need to handle the ALIGN() overflow Sashiko reported before
adding that reset.

Reviewed-by: Lance Yang <lance.yang@linux.dev>
