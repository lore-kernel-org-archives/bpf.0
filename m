Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7727281D
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907001; cv=none; b=EMMZGxn5QtAcmGG4S91KddytOMTo2GjfkjZbw5R4GslZGMvZXpbilAoh4c3hj7XVe23eTwfy0TLi3jqS1g/vraJqDoL4axhn29QIeDve7C3SR02xs/Ch57XbhXqYSxWkN+5mlb0ZWcYiPgJcE+CaItyI7xbq5p72szVCB2IuNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907001; c=relaxed/simple;
	bh=p/0+/JZQwv4wJ39jH2zw0BkU4gicdGKUOgCT8OUCIdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhpWdUfdYjrMpBYJuBmBStUByeb/wh2gS9Q8OaElAQTY6AU9zQ4cTp7sJFTm+TBqbmBHoY7VWgETnO3NFcOQMIbddDvnmJYFomjzrgpG53iN3mdTuRkiNvCxmSsqM3wnw/yIaNHIxlUm/10QtItWpl5/dEvcrrnhmK4UZdeFq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkzsmKiE; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkzsmKiE"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c25b90264so2071578c88.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 04:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775906999; x=1776511799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu5MvI3I+D33wSeU5wH1n4j4aGdkJrM4ZATUTkJFOpc=;
        b=hkzsmKiEj76oUBYS3ecqsjD+aeOmA9HiHb797bYWYaxxSogmp+dfW90Cl6OB6NMd6V
         F0ElYR0EcEE8kT6vtirUyITpVXZPeGA0Wn1QLV+qKwLdctxzB2DB+g8lTKpuIuATb87S
         LSqCiCJ7CQd3esu18L2bYdz2UoMrX0zf+zKZds3JWU94AGR7RmA8oyM5boN7Q0Npcc1d
         +I8Y+GHm6IdkkyRhQI+wtebwIY7riF/BRwZrkF+PAUCJvoOojgGDsTx5HU6V/pw1enRh
         0S9gQAJ7uPPB++3jVkc73Dz8DWgpI1FzkRrfKOFreotadhfQTmk8XdtgA1AntjMBmKpX
         mYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775906999; x=1776511799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zu5MvI3I+D33wSeU5wH1n4j4aGdkJrM4ZATUTkJFOpc=;
        b=I76f1xMIwfX/20wBywoNqeKf31ejI+SNzJBDslEElMTwzTXJAOsckycMXEz37Sl7Ip
         l2aPTV1dS+S632jWYrVZJLYY4a1TxIR7Vn/a2grt2iSU1/26q4sGTUJFNPDhmsPKx/b2
         CnHkOtUpkRTDqknKvqseeRGLoFGWK9IJDlZuWlPwh+xW5Fdopw3AChTPKK2Og6gGs1MU
         nCVwJBo48yLRh4kUOPjENzfALWdeftKIFFYKf2Ps0Ifc0awkX87HiwohB482c/jszjSs
         X4Ua1Mt1539UsVzxZelAhOL1STaGaHIVyZjo/cLeaWUhnEUd4JoLWYZbsjHMK+f8RmaW
         8UyA==
X-Forwarded-Encrypted: i=1; AJvYcCVaBM3qw6nvAKwgSPwKZaSYxCQQRUJ29KCCgQlHKNK8/qTmIUlb6iInTSLZfoNas7idfZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxER6NCPbzVXEB0XyJEiWbe5enHO76WzRslCfK0G2SsvPSRtJAW
	qZpx7zWs/Ey1VDnyDAcuUomp15qoYzL2BC4T0MgucwUZVoA8KDjiAour
X-Gm-Gg: AeBDieuAfHHaOqmC83MyeL6UW4nCJD+3INQWoWETm3+ykFi3+h+apKRrR5SWbqhofGB
	jD3XCu240HSif562JUac/GraGQxiigWWVyHZNu397mptGxivTTFLWi4R3KPu2YMvyCeiv7HHp8k
	Js3FitPzLyHeXR8eCGMFmmDVKL3MUO9OX2YbxKMlVrCCsE0xaS4ZzA0yEOxcHxIko8jm5ZBQccU
	JlfQFosfxyAfbhe7cJh5xGQI4ohSDr6p2kNq7D9gUrtFPViaO+tUXj+PIEptH75Z7z8FBrcvcNf
	K1IZ3u+XKFKMryMuH+EQXXgttzR7hCUoJbVsARQ65yn1hWdKCqIHNoUOA+1cUESsvcRcWetr/6Q
	uxJ8tNY+y1tMRS7c1K8mYItlZthO+Tahl03XtI1Z25fQhQWJOxdV0OgeY/GvXgsiJsxeJsdlYJG
	vGWcKq1eE47nAyED4XC8C3WeJ4XjxxhPpntbb62t4mgq2o2wUSxMGgED45QgRyAspktHtr40LX8
	A69U6H40g==
X-Received: by 2002:a05:7022:6b8d:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-12c34edee56mr4145640c88.26.1775906999329;
        Sat, 11 Apr 2026 04:29:59 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b5b9dsm6379097c88.7.2026.04.11.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:29:58 -0700 (PDT)
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
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: Fix use-after-free of arena VMA on fork
Date: Sat, 11 Apr 2026 04:29:43 -0700
Message-ID: <20260411112944.1455470-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411112944.1455470-1-bestswngs@gmail.com>
References: <20260411112944.1455470-1-bestswngs@gmail.com>
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
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes since v1:
- Added missing Reported-by tag

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

