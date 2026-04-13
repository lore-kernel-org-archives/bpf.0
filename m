Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF53B6C03
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109369; cv=none; b=HrfbQKPobvII7AOSTsGH2xgaK0nQQCmFHUJCy09uelQkEegLKaXcPLGUw4UmCJ1gSrO8hRP3vDr408mt+GXeQLh8G1G/pb/mWTGWhtq7O8wVcaWGUNcYNqOAcAidaP1TGKMCGlY999Fdg3OBrggj3AaZQonmj1DapWXfYQ7I0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109369; c=relaxed/simple;
	bh=ZjQxxdWoDs5rUyUet0rWex6exCFUsQSn3/vVzz2rpYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idCsWVV2uEghwywsAIM0wrAhHDCTIIJpczSJrYkqkIbbYDwvip2kkDuvk5PXYYKLdaioi7+HMUJ2U7VIDj7SkrK9BHZCu0EWObIzzG/fklFMTuejpfMz0zXMasNFk6y9Rmi4gQA4mfXDaiI0HqQR88sp8or7XYJfi6va2KqUUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+Nx+j58; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+Nx+j58"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so1906106a12.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776109368; x=1776714168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6uPd4TLPfyUeBCUcLJdyMEl7RrGpH4C8YGUUbVMvao=;
        b=J+Nx+j58ZtgUDZH1rkPE6HycNNAyhk3OwHQt/VJL5j0FpjkAhLgnoaBY4uQs6pkiZY
         s5/GQ1BJoOLduiiD5WnvC+kcZtG+R2ydg9uEOQUUq0qq4kk4yq162TakA2wDDy0NDUYa
         sl3JtWzbPsXyw2GZ6JVbPvdH0YroETRXxfa+jHD69slp8rilwlNX0yQNsRnEbShobsak
         TonYhK3L4eNV6NZxLyzrlPJRzQyyIs9f9M/qTpsf+1Y9JpDu90R0F48NRTP1z1IM0eyk
         oNoxGb7xWK2DuRfjpOPnJKQqie7pb5sioZ4UIF1kXGCPhuGaoD4XTwvf7DTHWY1gqoEk
         5lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109368; x=1776714168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6uPd4TLPfyUeBCUcLJdyMEl7RrGpH4C8YGUUbVMvao=;
        b=kT7BfrsnpJr54v4kgUVOL0eQ03Ek2aAGfzdcGfY1bYTz70eIMeeNv00RRArt58APLf
         yYOA6/5ppsms0WqcyKMhAyDAfX/97YY1GMIkqYoeIbJZRtJFMKGI9O1vArqBfwHK6Zwe
         gKHiYMxuCcXQ8Of/OqXKPK2qQdVnOs2Y+k60TIH/80P1MGduCaJr3TxH+Ex3W+MldS5x
         TapQbMQu9boHO3MeoZgWzOpqU2ygcfmIpNLA9bAzHo9XMHvSMKF8xKNPQMbImpuaQEKV
         MkkkNJ0BmIX40N/8F61wGUfLu9mhHA4I9JtEVtl77msPDanFjYMYOue2zEzgm5yixY7K
         3X9Q==
X-Gm-Message-State: AOJu0Yyw4dPzJOItyg4gFhU0L1c7QS78hTp4t4JIxP3p2xi7t7qf2JN5
	N4qwjx0XtWw86XZ1I7MKhAR6YmJ63FgOiW7OI/6Z7yNTC7+OSd6ktaQKa6qSew==
X-Gm-Gg: AeBDiet+jg4uEM9MEuP9zrEJkgrqeJw00vVj8H0oTXpHyPxncXeaTpS80Kx/cBTDoch
	YSuhMhnN8RKkC3MzBobn39uUB3c5zrzxqWWsqouc+rTsc1RJJQGZQFyjOPL1smlYt+lNVVBuW4S
	ouaU2bNgpFIMfk/R4q7Uc+SAr4NW7zhOx4DcKY9t/aR98JqZ7Eo4MQEC2qfF2LWrIOhRqNamQGs
	ZGj841x4JJLaLgwzXuGVLwhbazzgj/pBk0HU5Abfn0OXrjkY3X5yDWalLxbUC9PR9yqtHjdhbWJ
	WRACWuJdPMkUdiwfWuxdIjYuOhDNBVCoSGLmmxkRSUJZvtPl45+IYpQNtGdFwrZnUjy9vKiaVuQ
	fuAuTqyuAqSIhl83DC3iMK+0EsTn+EjcFfDheg/GgfF9MTjETZwM1j9SEWpo8h0Ew2+5PBy6Zn4
	YrnezIYqnKJRxK3UuVE5Ti9C7VUgy94TPN6S6Ur5jTujjm+SWEnmGIwk3KnQjFXQvsksgIjD7lN
	x6BaENNji3Ecjbo21d3TXmeoGIV+22SUm46E/gSXNpux0iUsxol0eCP7wqAycVMP+I=
X-Received: by 2002:a05:6a00:808c:b0:829:8942:2ca4 with SMTP id d2e1a72fcca58-82f0c281379mr13702533b3a.19.1776109367495;
        Mon, 13 Apr 2026 12:42:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4df7f5sm14882361b3a.43.2026.04.13.12.42.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 12:42:47 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next] bpf: Fix use-after-free in arena_vm_close on fork
Date: Mon, 13 Apr 2026 12:42:45 -0700
Message-ID: <20260413194245.21449-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

arena_vm_open() only bumps vml->mmap_count but never registers the
child VMA in arena->vma_list. The vml->vma always points at the
parent VMA, so after parent munmap the pointer dangles. If the child
then calls bpf_arena_free_pages(), zap_pages() reads the stale
vml->vma triggering use-after-free.

Fix this by preventing the arena VMA from being inherited across
fork with VM_DONTCOPY, and preventing VMA splits via the may_split
callback.

Also reject mremap with a .mremap callback returning -EINVAL. A
same-size mremap(MREMAP_FIXED) on the full arena VMA reaches
copy_vma() through the following path:

  check_prep_vma()       - returns 0 early: new_len == old_len
                           skips VM_DONTEXPAND check
  prep_move_vma()        - vm_start == old_addr and
                           vm_end == old_addr + old_len
                           so may_split is never called
  move_vma()
    copy_vma_and_data()
      copy_vma()
        vm_area_dup()    - copies vm_private_data (vml pointer)
        vm_ops->open()   - bumps vml->mmap_count
      vm_ops->mremap()   - returns -EINVAL, rollback unmaps new VMA

The refcount ensures the rollback's arena_vm_close does not free
the vml shared with the original VMA.

Reported-by: Weiming Shi <bestswngs@gmail.com>
Reported-by: Xiang Mei <xmei5@asu.edu>
Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f355cf1c1a16..9c68c9b0b24a 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -341,6 +341,16 @@ static void arena_vm_open(struct vm_area_struct *vma)
 	refcount_inc(&vml->mmap_count);
 }
 
+static int arena_vm_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
+static int arena_vm_mremap(struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
 static void arena_vm_close(struct vm_area_struct *vma)
 {
 	struct bpf_map *map = vma->vm_file->private_data;
@@ -417,6 +427,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 
 static const struct vm_operations_struct arena_vm_ops = {
 	.open		= arena_vm_open,
+	.may_split	= arena_vm_may_split,
+	.mremap		= arena_vm_mremap,
 	.close		= arena_vm_close,
 	.fault          = arena_vm_fault,
 };
@@ -486,10 +498,11 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 	arena->user_vm_end = vma->vm_end;
 	/*
 	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
-	 * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
-	 * potential change of user_vm_start.
+	 * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
+	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
+	 * being copied into the child process on fork.
 	 */
-	vm_flags_set(vma, VM_DONTEXPAND);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
 	vma->vm_ops = &arena_vm_ops;
 	return 0;
 }
-- 
2.52.0

