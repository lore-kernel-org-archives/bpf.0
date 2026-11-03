Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694484;
	b=uB+ZmMrtb1hMcYFy82lG+gfM7V6qmLmr0jBA6jVfqHTAL8oG1XS8///++AIIOqrsW+Ns
	 aH36SdNJeOIrPA2oOzjdFWsAWNSRwFC5FvfQstQupqoACONPSXh99uqdbIJ+fpfn5QztP
	 qMVefOoYMZzqGuZjCaRLQoc8g9y2kmDHozIvvogfsSQFb1Ac/2U7DSq4s2xcHGOY3piGL
	 lybPhG6wGWyKf/tjNGKXtqVEfULWvUrskre6jjJ5fPvwolhaDlJGPx9KSIhHZ5rEdVuCX
	 fEi/OdQE/K3UlF8Usqj3DTgUiGFDkZMpl5zDx86xmZQ3QYEv2eHl4qwGL0wsgYtPjdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694484;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Fsirq8b1tOF7xGnt9JKmVFznOcgYPeH7MNBVIQjnYAw=;
	b=s/VN+Nyk838q4Kq+bgapyI+huSx66CR+IIWezV+WR1eMzjuqGsQ8qsq90n4t5fz+PNdT
	 7RP8TbRCJ9ol+J96udkktyEdXuDxIlJQBh29DANKGnvFzm4QtNNCfr/deTVLqh3mxTiOq
	 +/zwyyguVZralX59RLXjCBq8JzUEC23F6doBPI2wOsigYwG1t9dk5ULkMZMP/C1kA6EHl
	 3viTI7nHzx7CQVbWHijtjyPGDT8vhXIA88xnYrC6jFcmLSi+QbwuKav/A+dag/tuIEeqb
	 UlVVYkOhdji1qxKx/K6ORAdJhsEPOmVq48P/fQu7k6gOs2OcV2LiniLBJ4N2/WuoypQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZ9GBgE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA5606A327;
	Tue,  3 Nov 2026 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZ9GBgE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555311F0093A;
	Tue,  3 Nov 2026 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694484;
	bh=Fsirq8b1tOF7xGnt9JKmVFznOcgYPeH7MNBVIQjnYAw=;
	h=From:Subject:Date:To:Cc;
	b=LZ9GBgE+6z1dxJNlGmIEYbLWgU8h2E5PEdgyN9NKIA0VaGVcncEmxMrB5iadlM0Nn
	 lsxYS0s1MojLzCDJY9sOIFOIJt/X+v8MKTTZWds8jgIGWH8h2Ju5yHVQidwK1mFeMR
	 rXY/zje18Dsq4xDwAicEhbhn3NgIwuQ6pkbID6UUZ4WhIsiuRJbihFd3AFGx/rTi1N
	 OcrV0rXbke+zBcKyezsU2LFhsgS70ul3cwXf90UCjYrNFT9bs8x4SCBx8Ntwz74mVD
	 nW00LouKPe+96bRnfEQYDH4NAdlTxzOweBU2JDDAv47nmuKo0RdRIbdUXefB4m1wFt
	 2NEGdQbb6sFIQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/5] mm/khugepaged: bound mmap_lock hold time when walking
 an mm's VMAs
Date: Tue, 03 Nov 2026 08:27:41 +0000
Message-Id: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QqEIBQFfyXucxdMSmh/JXoQPdmlxUIriujfV
 /ZxBmYeykiCTJ/qoYRTsqyxQFNX5GYbA1h8YdJKm0bpnpf5CNhsgOev3RHdzZNc3Kq277wxsJ2
 iEm8JRf/Hw/i+P04JZmRoAAAA
X-Change-ID: 20261029-khugepaged-latency-fix-40495d66ea50
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=ljs@kernel.org;
 h=from:subject:message-id; bh=XXzzroOk3JzB70Kjl+zLo7wwLJmwdmiu+XnhF/h0hi0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJezub07jtZPs3hZ101N694fbdfzVdvDfXOirsP7zjdK
 Ty/fTdXRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACay4SfDH45qsUkXUpPyPOuV
 hQ8qTPq0ym/p2gu71rXsvLd35p77DlWMDKcOPHCefaTv0bWucqn0xLC23xmPc37VS0ztSUpYUio
 wkxEA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

This series introduces a couple small changes to khugepaged to improve its
behaviour both in the face of mm->mmap_lock contention and to reduce that
lock contention when possible.

It also updates other places which release the mmap read lock to allow mmap
contended mmap write locks a chance to make progress (BPF iterators and
/proc/$pid/maps + friends).

Looking at the first change - if the mmap lock is contended, an attempted
mmap trylock in collapse_scan_mm_slot() will result in the scan being
aborted wherever it happens to be, and when next the mm is processed it
starts from the beginning again.

If an mm has a lot of ineligible VMAs and is undergoing significant
mmap_lock contention, collapsing the eligible VMAs there can take a very
long time.

Patch 2 of the series fixes this (patch 1 is a prerequisite) by keeping
track of where khugepaged was in the mm before aborting the scan.

This issue was noticed during some work in which an mm was instantiated
with a large number of small VMAs under significant mmap_lock contention,
during which collapse was observed to take 10.8s. With this patch applied
it took 3.6s to collapse the same mm.

Patch 3 introduces new rwsem primitives - down_read_nosteal() and
down_read_killable_nosteal() - to allow for read locks to be taken without
stealing them from a queued write lock.

Patch 4 adds mmap lock wrappers for this - mmap_read_lock_nosteal() and
mmap_read_lock_killable_nosteal() and updates callers which release the mmap
read lock on contention - BPF iterators + /proc/$pid/maps et al.

Finally, patch 5 uses this to have khugepaged release + reacquire the mmap
read lock in the face of a large number of ineligible VMAs.

This was also observed as part of the previously mentioned work in the form
of mmap lock stalls, which patch 5 resolves.

Importantly, none of the changes introduces any regressions for khugepaged
anywhere. It is all upside, and implemented conservatively.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (5):
      Revert "mm/khugepaged: remove definition of struct khugepaged_mm_slot"
      mm/khugepaged: scan mm's more efficiently under mmap_lock contention
      locking/rwsem: add down_read[_killable]_nosteal()
      mm: add and use mmap_read_lock[_killable]_nosteal() on contention
      mm/khugepaged: drop/reacquire mmap read lock if skipped enough VMAs

 include/linux/mmap_lock.h |  44 +++++++++++++++++++
 include/linux/rwsem.h     |   2 +
 kernel/bpf/task_iter.c    |   2 +-
 kernel/locking/rwsem.c    |  71 ++++++++++++++++++++++++------
 mm/khugepaged.c           | 108 ++++++++++++++++++++++++++++++----------------
 mm/mmap_lock.c            |   2 +-
 6 files changed, 178 insertions(+), 51 deletions(-)
---
base-commit: 34f88a114888c9dba49e45f2b0c2a3e83c4c871c
change-id: 20261029-khugepaged-latency-fix-40495d66ea50

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

