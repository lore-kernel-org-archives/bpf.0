Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8C230270
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775938142; cv=none; b=XLEwdb1rSYAx8bOwveh5Qme1l053hXPMFF07GAmEhRXDUnNbf+OOSa49GUonwc3nuK3JIAnHks37qUZ1AiH9KXrV+Pyc/ThvKkz/9eO+NwsuboOnZAhOsHi3hroU/YT1TIELNdrr/lJw1ovCPmDYJ5hd+hjJZbFrMZIYdPmOh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775938142; c=relaxed/simple;
	bh=qNQTCbF6ZdNupTrt/rVsMMULWcHdTQuUZ2+4I70JBbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYXC1Ww37fHUAo8VZ1UPttBkdRzUmibu72UojSiCTaS1AwfbYDLC6h9TiZKRDf9TqblQN3XOcJOTywnLXN+AQZuddNzaDZbfNZxNUks6zIkTbn1ZmsHJsgOzGBpbEWj9HDKVsuhS3DQ7yGsQMGj4j1906wAZ+K9unk6oYBmivNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3vXO7j6; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3vXO7j6"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c25b90264so2654792c88.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 13:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775938140; x=1776542940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjoSCu5EBqI8aZ76ZupScoYRyeFikULbinAyPSlzywI=;
        b=L3vXO7j6Aj6ljbJFp7osDARKNkvBWSqCrEtF2JA8aFpg93SA7cLYEfDCka4BS0FRA/
         JWZweI6xF71HNl+lWoLrp6AhCqVEoZyqX1CB9GoiAH4vtf8POK8/deGboR7DHHKnwtYO
         4U9zulUwcRAbrz4PuO+4D8GJCSbmF4ju92WzsshVzGzSYuPKyQ+gN8Woth5QOeyd96Ol
         GFuGYzAoXfpmvdjYT3/q1FaXU+OGLGS986Am1ayJU53Wg2YNr8CN7+Vd5rF1fvMsJUMi
         vUM1bnoiW6OO0Dm9T/wpFJaFz8Ts64pMRzHPPrK7+8TpG+05F5eDJuImZ7gsTRZi18iz
         1Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775938140; x=1776542940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjoSCu5EBqI8aZ76ZupScoYRyeFikULbinAyPSlzywI=;
        b=FFwzekxjxVulMnRywdD5h1tJ7fmsQ8ayaW57MYrD8FjA86z1jU2FYRd44NYG8q8dkl
         Gebeta0QUIyYgu0e3w+3Ct+qt7P1SpOon83R1Y6ESJ7xksLHMcHFMmP6W6cVkLHuPndM
         DqjHtG4VUHmUiCBNAPxE4rHohDtScG+egkNkYyl54FYeRo74j3nLr/1irUDRnRsDQarn
         ENMnF/1Drkn4zhkU7MtXEZ8Si7lLX/opmwrJ5CA6UnRvF2Q1DffuOXpwd/CzQ9gc3B7z
         vOGQvzVvRvjiapK4cFtr6KIopJumwOwZ6i56Lkc0G6DVDWru3eQqfHqUIJ1KrJxIS8fy
         qNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK4ttAhrROHzxpQTrZgh4PmA/2IOrZyeZrT0ef4j2p9HK8R4x79/YYOPQ7lFXQtobvtyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSFc5YhQEBO3e9PdCmSnE+p6gxFSEoJz2Xk/uaY/CLlXPqwPq
	7m68eqhF7Rj2xdOGTpngLXOIvW8NLTNABau/PLmNU8uOahvfNz1D2G7t
X-Gm-Gg: AeBDieu9KyM4KoX2s4WDqNPauV0WRU74TFE0aLcTNcL2lZcVwC1+kKSljRCoOMjEBi3
	9xeBdUUJ8W+K1rWA+9spZHpe5kQbFLg7hLvQ3fPYOczRu1uMxFjeKWRR5YL6UUKtCFTyheW5eRE
	4NFx+f/Zr+QjmE3Z6PwWyDqjqEiydlvwmoonyduiqV9dHk6V2wl1fALiUawwJCp+UQzG2JT23lz
	Sa4R/hIUS5N0DJ3u65CoBboCJ8SquCF3Ggvk3TdsUdG4sGhrDGIRDowgyR0s+ec0bplrAhmghgI
	4rH0O/VHqOGlLWFdQqW4H/rhfXpir55PO/Brjj3qrHLjUue/ymGZlxL+UAxdqalxRfMFNb8oM4S
	yPGwaF19ndvKC+8n1wHkkAXv3zmTdvWboxubyL+sHcUXD00F9gKORMfB1yTF6tQBPUYjRkzFdOj
	AC/EZb79AiElvA4tdyEnf4qiU7YziEdlatRWGclVa3S4i94RA23HutbLMBw9I7TtJDpMJORZ6Sl
	41m1x04Sw==
X-Received: by 2002:a05:7022:1e02:b0:127:9c10:446c with SMTP id a92af1059eb24-12c34e396ccmr3907697c88.7.1775938140274;
        Sat, 11 Apr 2026 13:09:00 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459f7ffsm8078325c88.3.2026.04.11.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 13:08:59 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: Fix use-after-free of arena VMA on fork
Date: Sat, 11 Apr 2026 13:08:40 -0700
Message-ID: <20260411200840.1793567-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411200840.1793567-2-bestswngs@gmail.com>
References: <20260411200840.1793567-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_open() only increments a refcount on the shared vma_list entry
but never registers the new VMA or updates the stored vma pointer. When
the original VMA is unmapped while a forked copy still exists,
arena_vm_close() drops the refcount without freeing the vma_list entry.
The entry's vma pointer now refers to a freed vm_area_struct. A
subsequent bpf_arena_free_pages() call iterates vma_list and passes
the dangling pointer to zap_page_range_single(), causing a
use-after-free.

The bug is reachable by any process with CAP_BPF and CAP_PERFMON that
can create a BPF_MAP_TYPE_ARENA, mmap it, and fork. It triggers
deterministically -- no race condition is involved.

 BUG: KASAN: slab-use-after-free in zap_page_range_single (mm/memory.c:2234)
 Call Trace:
  <TASK>
  zap_page_range_single+0x101/0x110   mm/memory.c:2234
  zap_pages+0x80/0xf0                 kernel/bpf/arena.c:658
  arena_free_pages+0x67a/0x860        kernel/bpf/arena.c:712
  bpf_prog_test_run_syscall+0x3da     net/bpf/test_run.c:1640
  __sys_bpf+0x1662/0x50b0             kernel/bpf/syscall.c:6267
  __x64_sys_bpf+0x73/0xb0             kernel/bpf/syscall.c:6360
  do_syscall_64+0xf1/0x530            arch/x86/entry/syscall_64.c:63
  entry_SYSCALL_64_after_hwframe+0x77  arch/x86/entry/entry_64.S:130
  </TASK>

Fix this by tracking each child VMA separately. arena_vm_open() now
clears the inherited vm_private_data and calls remember_vma() to
register a fresh vma_list entry for the new VMA. arena_vm_close()
unconditionally removes and frees the entry. The shared refcount is
no longer needed and is removed.

Also add arena_vm_may_split() returning -EINVAL to prevent VMA
splitting, which would break the pgoff arithmetic in arena_vm_fault().

Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/bpf/arena.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f355cf1c1a16..3462c4463617 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -317,7 +317,6 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
 struct vma_list {
 	struct vm_area_struct *vma;
 	struct list_head head;
-	refcount_t mmap_count;
 };
 
 static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
@@ -327,7 +326,6 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 	vml = kmalloc_obj(*vml);
 	if (!vml)
 		return -ENOMEM;
-	refcount_set(&vml->mmap_count, 1);
 	vma->vm_private_data = vml;
 	vml->vma = vma;
 	list_add(&vml->head, &arena->vma_list);
@@ -336,9 +334,17 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 
 static void arena_vm_open(struct vm_area_struct *vma)
 {
-	struct vma_list *vml = vma->vm_private_data;
+	struct bpf_map *map = vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
-	refcount_inc(&vml->mmap_count);
+	/*
+	 * vm_private_data points to the parent's vma_list entry after fork.
+	 * Clear it and register this VMA separately.
+	 */
+	vma->vm_private_data = NULL;
+	guard(mutex)(&arena->lock);
+	/* OOM is silently ignored; arena_vm_close() handles NULL. */
+	remember_vma(arena, vma);
 }
 
 static void arena_vm_close(struct vm_area_struct *vma)
@@ -347,10 +353,9 @@ static void arena_vm_close(struct vm_area_struct *vma)
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct vma_list *vml = vma->vm_private_data;
 
-	if (!refcount_dec_and_test(&vml->mmap_count))
+	if (!vml)
 		return;
 	guard(mutex)(&arena->lock);
-	/* update link list under lock */
 	list_del(&vml->head);
 	vma->vm_private_data = NULL;
 	kfree(vml);
@@ -415,9 +420,15 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	return VM_FAULT_SIGSEGV;
 }
 
+static int arena_vm_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct arena_vm_ops = {
 	.open		= arena_vm_open,
 	.close		= arena_vm_close,
+	.may_split	= arena_vm_may_split,
 	.fault          = arena_vm_fault,
 };
 
-- 
2.43.0

