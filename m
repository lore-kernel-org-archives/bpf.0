Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB162E414
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004053; cv=none; b=SHhTcu8tEhY9KXifVfLGZURwSaOhNvAB7qlXLYhHjrtH5bgQ4SFcNfhicSor8EJ3ndAotbUZ91i9jJNpVU4X02KxDiD4U8p1AwR5/Yo6LE9pFKl3bZbX6DxrIqzxAqvFzrnXoZGQrhMp/RkO489U0Mu4SlDxMnjI6hGmOps7Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004053; c=relaxed/simple;
	bh=DcaQAvyTv+B0bzkQ71JQZ9CCPRMCIstVRIyuOQa2hZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HapZrhh6vqBCSQdge1fuxOeoienD1bpO2H9+FRIoCxugvNMwSo1VgkxaXO/NAvbjA+lxJidATRxDa1+68Dev7qmekqwQ5OYZDo2CJN9/+nI75ij94zIyoPtjIqUDAUZhvEeGnFmpNiPRZocyz6aYSyNambtxPuTSig8GwXxisJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1iKEco/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1iKEco/"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso1916335a12.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779004050; x=1779608850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lq35AOf8XMoPBRf51zQYzOvH5l4HY+x3jHyuSK93u4=;
        b=L1iKEco/74W7rrNvrGy5b++L/SSv0YyXcopfZb+Gfmsl34BOPdzBRKcrud4nLBgWiu
         SygN9s8qqADHtv1cYbSOxeTURGQjxOtD3173hhmipGJgsBgBC2VlvDtwekCN4pSkBOIq
         8eV8gOZ0wPUZNsU/5dYJWd0smqZFeQRQ5eUhsTdxg6H31yZHSkZfyGW8hAEOpVeczi0b
         kYhYWNK5x+pi877lf/vxCMoOsZiNrikMHN9Ub8h+O4Oj+0b4jJScvFZ10uRDE/AwjetC
         swUZdgwZfmAQvxyAwLQqjFeBRBWVsOuFi59kHn6PmypvFUYK4F89JT498ay5NCZvlZvW
         2Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779004050; x=1779608850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lq35AOf8XMoPBRf51zQYzOvH5l4HY+x3jHyuSK93u4=;
        b=lcmT1yywScpwxMheYb+QLsfdWdp3EcxYFbuImWbngyH+Di4myGgDHnEuxo2X+jMfUJ
         y7+PC4fr/dEtQbJBnjXP3cqUZ4i5yM8dej5gWMdPEdNX5ffqp/r3p0g+s418xvdEC47v
         KjTIYMdsAqjEuBY0Un8nSHcVHglGRDTmKF2TUxFYnN/Mm6IC4CuilkwBUv3wZRZmZG9R
         admgHrbMCEl0qUwO8BsBIhYI+3wxJ75gTmeBjp6bSWDFOTf77YgMwXeFfw4+AmzXY9dv
         Mu4MS/wt2P2jui0aMkrNz20VVNRDdHl/7jpy8/oLvucgpXN1StK32C+SEe8aMs0/pqeg
         cflg==
X-Gm-Message-State: AOJu0YziMSZoM+FgQ3/wtR5TlNCNZcevaU77rBm8p8+lwUc/L9INQ0i6
	+HFKdqyZRsO22iB5EUbUUoeGjMIUJ0qqFA1oh2/n0dJkm+GtkqfFnnwIcMha5ruh
X-Gm-Gg: Acq92OF+rXcnLiN9vOMjgRkF+gMENLfovxnEGt+YJF8/EwCarYxKsEzdCdVnb/ZLy+U
	Mfn0bHn2R8i+wTR7idKLA/vBOV9pNfp/APaYr1rN7fIsWnt8ZYSwHWX0RhqWsfkzcvIiOjAnevS
	Hzq+I9TEnvFWNuq1jyEllMfNbPCUQBqzGkXjPO68KaOirVRwQO94dBXO9POzvLoaF0Z2aXfTQJK
	3Z2JkpL5pWNpQNE+kOulpJnzZyqPQbY1kTEo/9aZn9PTXd18bG0dkdFNWgNWh0qootF9sTcQaOq
	Nnc2qubphiBXsenDA3nIlgsxCmPRNIW/xcfPwlpmwvexJKQ6bH3Qa2boDHbyD1trR+9/RNaxRMy
	BkPn2YJM4KnPpYviBlvVDkf6DlKnENnpqHxbF1fLEZPWrzFhSUjoAMQ2+u+C1kZ31nLjyloOaah
	pUlzwgViWztHI3RXTZoJ4jJnRaChqD/w==
X-Received: by 2002:a05:6402:46d6:b0:683:1cc8:84ae with SMTP id 4fb4d7f45d1cf-683bc6b76e8mr5153525a12.7.1779004050379;
        Sun, 17 May 2026 00:47:30 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b50a34sm3925355a12.7.2026.05.17.00.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:47:30 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bpf: arena: fix TOCTOU race in arena_vm_fault()
Date: Sun, 17 May 2026 10:47:25 +0300
Message-ID: <20260517074725.7516-1-capyenglishlite@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmalloc_to_page() check and range_tree_clear() in arena_vm_fault()
are not protected by a common critical section. A concurrent
bpf_arena_free_pages() call on the same pgoff can return the physical
page to the allocator between these two operations. arena_vm_fault()
then inserts a stale or already-freed page into the user PTE, resulting
in a SIGSEGV on next access or a silent use-after-free.

Fix: acquire arena->lock before vmalloc_to_page() and hold it through
range_tree_clear(), making the check-and-claim atomic with respect to
concurrent allocators and free operations.

arena->lock is a mutex already used by arena_vm_open() and
arena_vm_close() for vma_list serialization. Reusing it here is
consistent with the existing locking model and avoids introducing a
new lock. arena_vm_fault() runs in page fault context with
mmap_read_lock held and is sleepable, so taking a mutex is safe.

The pte_none() check inside apply_range_set_cb() is not a sufficient
guard: it prevents double-mapping but does not prevent the range tree
desynchronization that occurs when the race is lost, leaving pgoff
marked free while the PTE remains populated.

Fixes: a7d032218a53 ("bpf: Introduce bpf_arena")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
---
 kernel/bpf/arena.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index a1b2c3d..e4f5c6d 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -XXX,7 +XXX,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct page *page;
-	long kbase, kaddr;
+	long kbase, kaddr;
 	int ret;
 
 	kbase = bpf_arena_get_kern_vm_start(arena);
@@ -XXX,12 +XXX,24 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
+	/*
+	 * Acquire arena->lock before vmalloc_to_page() and hold it through
+	 * range_tree_clear() to close the TOCTOU window.
+	 *
+	 * Without this lock, a concurrent bpf_arena_free_pages() on the
+	 * same pgoff can run between vmalloc_to_page() returning NULL and
+	 * range_tree_clear() completing:
+	 *
+	 *   arena_vm_fault()              bpf_arena_free_pages()
+	 *   vmalloc_to_page() = NULL
+	 *   [window]                      page freed, PTE zeroed in kern vma
+	 *   range_tree_clear(pgoff)
+	 *   alloc_page() + vm_insert_page() -> stale PTE in user vma
+	 *
+	 * The user VMA then holds a reference to a freed physical page.
+	 * Next access produces SIGSEGV or silent use-after-free.
+	 */
+	guard(mutex)(&arena->lock);
+
 	page = vmalloc_to_page((void *)kaddr);
 	if (page)
 		goto out;
-
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
 	if (ret)
 		return VM_FAULT_SIGBUS;
-- 
2.39.0
