Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584343446AB
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775906488; cv=none; b=anTXsCB4PKZmidDF2f8SbhyRBfrbCNl7ktgXvJuN3D3B+4oprreaUenM3lM65FjSgrmNtKUnqGQ75cwjfRCGIYXoJao9bDYFiagXensBUBMa3BLAhr3QzJ8O5YWzOAuTR/uQSwqRGV9IwpxxUqj0Tq8xRr5WE2xfA1s8iEAWcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775906488; c=relaxed/simple;
	bh=9QlHGdkTLeV9V00JRc0JOW6i7+Q0aVko8DuLbBYPo4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFw/pP9j8y6hBsJIxJtXbxCTayCknZJswtrKQ0qMZAZ3CJtiW4Ehqq6fXIsK2mwcsVohCtwSwjfqjwFt5l+Sag79T29++wSJFVIuNnavs7EsWe28P7tdA4k+ZoxlJ/Cxf3U6cYlDgtkKjJHUy3jCuYlPtxmrR2sJokA7yvmgZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX8HYexk; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX8HYexk"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c54c68db4dso5180540eec.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775906485; x=1776511285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3ZPcIa5OvWR2yiUKd/+yp0eIrmzRtU8HCVYMTSVr1M=;
        b=hX8HYexkyUvLcWyGgcBsgEGdbuFKzy/o/9PuIHS0L7wPfBPifaGs/UIvfv0Dfnj7GC
         zaRxX7wmX+Nr2gKxQoNsKOd5YH8lw2Gf9YMF+AnxuXEAIkuuOEdRL7BKEDLokRF6qsFJ
         mtUXAg+Y96apufmdmOfyLeH8mYBG1eIMBZbJb8Z52i+2fAjzsnCXlZWsc0qsvMmo9A1a
         tuUEgypwpwksvTzAYxJouDFmt4lAyFCJJZnKHGVZdwSjrhbak5tnGkZBTb6XGnwEGod6
         TH+AOnjjvhPAmb+mfT8KIt7gwQCKd0cXgbqSLdKm7iawjBxb1nZ9VMT9X0YtUux1+Tke
         hdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775906485; x=1776511285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3ZPcIa5OvWR2yiUKd/+yp0eIrmzRtU8HCVYMTSVr1M=;
        b=JZRKgajiOX4p38QEx5yKxkj2E5ivds79kpzRh4rm3W2sVX4fZPTkA49y95jq3OvYn9
         BGaCx9NqiS0GuGXlFy+B4W6lj6dL1LYx2wObnQLatYRf9swyEEaTL3EoHgUvPIQxhggl
         gmOL2wnRvi7CTqjSO/3mzJJa9V8P/ew1Std7kDcLGSuxWWVC8J6Yuim8zWuutNHEyUHE
         lF8XTqtzW1fKUREWLOVNQlXYghFJmhSSO0zs3FXfvxZPCvF7xN7Tc36SPI3gqpaeUlj6
         mvHN2LzFDT1N1uqrKfhK7x54hQQ0kH8FfYytiI7naGAKaR2cMOKuS2GnwPtjtgmo96+Z
         ThQg==
X-Forwarded-Encrypted: i=1; AJvYcCWM16HVe/AcBM0zbhRqKB0aq1S8iQfizTwX2zUlpUhZ3YIcgY0Q8UAXrlatkP74EheMC8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiM8831mQYnFeKy48esKECiGOqRLL3YmP0p8bJeO7QBzNxJqm
	3wUQZIUW1eLQphM2+VLbErQR5AjWCmssnf9oWHsSYwrurR4iyU6O5hpN
X-Gm-Gg: AeBDieuY8dlpQcFJqjC3wXt2PkebMfq2MH6h4HZx0ycha0+rvtTBSUF+lqXRxedebn7
	hWV7P2Hxmh7GYXLJLZGvR4cwPxHucV1sXgCv3mFSyOv+MqrgD+xhLnJph9ftIUrCEuKG0xLNo23
	jtUHOXfT+/JLxCZDvqTAMYMnF2kDq5ZimbRqQm58aIKWyngvSz/KK2KyHFDcB1PemI7+w2I1JF3
	4a+deo3eF3Ab615iGJznLkE33kTr56/5AHFOILrqynBn+8fol2MgB6HQLji//eoSX76PXXTOy54
	xbL2xA7ZDOGMBLuXki6jkVE/JTi1kHRxaiqbbwjKCg8Wj/EatcSRuvZAATjkLSmdXpe/LAshJE0
	S/lBXVgGmzJVm6pFHnuPvAQedH0w9wHcblun26mpvNedHGyXk5Gl3QVkQNkMb1jHk6E+ywJz5c1
	uZ052gKW7S1KgxCEZhdy9tXBDnG2t8luWUETaKp1O+B8+6xsHggpZDkMEzKnn4WF6lpi66rJHGn
	csUbGIDgg==
X-Received: by 2002:a05:7300:8c14:b0:2c4:ec89:bd3 with SMTP id 5a478bee46e88-2d5898aa893mr3717101eec.24.1775906485373;
        Sat, 11 Apr 2026 04:21:25 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm8224984eec.27.2026.04.11.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:21:24 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Fix use-after-free of arena VMA on fork
Date: Sat, 11 Apr 2026 04:20:50 -0700
Message-ID: <20260411112050.1454548-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411112050.1454548-2-bestswngs@gmail.com>
References: <20260411112050.1454548-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_open() only increments a refcount on the shared vma_list entry
but never registers the new VMA or updates the stored vma pointer. When
the original VMA is unmapped while a forked/split copy still exists,
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

Fix this by giving each VMA its own vma_list entry, following the
HugeTLB vma_lock pattern (hugetlb_vm_op_open). arena_vm_open() now
detects an inherited vm_private_data pointer via the vma_lock->vma !=
vma check, clears it, and allocates a fresh entry for the new VMA.
arena_vm_close() unconditionally removes and frees the entry. The
shared refcount is no longer needed and is removed.

Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/bpf/arena.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f355cf1c1a16..3a156ec473a8 100644
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
@@ -336,9 +334,28 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 
 static void arena_vm_open(struct vm_area_struct *vma)
 {
+	struct bpf_map *map = vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct vma_list *vml = vma->vm_private_data;
 
-	refcount_inc(&vml->mmap_count);
+	/*
+	 * If vm_private_data points to a vma_list for a different VMA, it was
+	 * inherited via vm_area_dup (fork or split). Clear it and allocate a
+	 * fresh entry for this VMA, following the HugeTLB vma_lock pattern.
+	 */
+	if (vml && vml->vma != vma)
+		vma->vm_private_data = NULL;
+
+	if (vma->vm_private_data)
+		return;
+
+	vml = kmalloc_obj(*vml);
+	if (!vml)
+		return;
+	vml->vma = vma;
+	vma->vm_private_data = vml;
+	guard(mutex)(&arena->lock);
+	list_add(&vml->head, &arena->vma_list);
 }
 
 static void arena_vm_close(struct vm_area_struct *vma)
@@ -347,10 +364,9 @@ static void arena_vm_close(struct vm_area_struct *vma)
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
-- 
2.43.0

