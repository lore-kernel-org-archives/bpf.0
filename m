Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FA6FD1
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469124; cv=none; b=Rp3NtgE3+NkEnRdo9olOHWBxE7m/156IzwlD/NfXXeCcTKs4ikxAEmc15DOdzEcAB9yjXN9WGrrAsQOjgZTuRGoL6xgywvEJa2+Qw9Rj+COCwlyJ3lif+LazVs+oCcLbzG3JFOqQj2yGKOPOvIqNTkdYLhWC6+TjGvGi3APUvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469124; c=relaxed/simple;
	bh=d88y2F04DSKnoADFHmboH2wiThUSyoR+o38AjRueuto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krAlFzPmNz1Wzqi0GGUUYCg7u9co/7sYx6U0SYmWnTzzT8Q1iQjX4tEtqg9tHZONkp8lbjqI3QmoSsneyRurssBOEJM/ODTUxCeTMsEU2aTfPDBVqbaN4IQRsOqqC7fmeyeGTiJfU0+lpI8vnUtXyh+Ht8WNc69owCp8AW7Zl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lfc9TPxH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfc9TPxH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dddaa02d22so9918015ad.2
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710469121; x=1711073921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryZnmvBx3CZ9a33TjKjCtH+JryFtuyjLqRiWRXEiNMc=;
        b=Lfc9TPxHotfoeSWhTwhBC2DZl+szwZmzN432GPqWFJ0mKj/3hc8o11EU66rYXfVrif
         WYgrgWItBa/mLqU294lWOgzCM96HAg3T8Rx1itKdXNXAEEMTKNfA1umCjEsG3qUPCBIO
         imPsZFwU0JOlItP+mC8guI6i1fmsGqUYRvMNjMT24T4Qd7NjWryLBCmZX+oacoRmpgO7
         GALyfDjcX60Z+DLjMao/35NuUwdMQYOyZWYnNXXpCMJe5fgtnPfvf+9c5Nru6Z/Y9TWW
         MCvgjkybb49AWQpdXeGCNRKwpAR+BcOwHNdirbgtygEjWE15SmNZ5kmGsuDZIzoWY+r4
         /1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710469121; x=1711073921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryZnmvBx3CZ9a33TjKjCtH+JryFtuyjLqRiWRXEiNMc=;
        b=HO2M1y6zaxX18PDcYb2/+eOHR00zRGwlYnejGDXksRQKTVa9i+oTqcJpMZ8GEBPAHQ
         27ofizoaavB/rNGtH9doh/TEbZl4lXFCkNFbFB/JYI+ql5URXgNr86UdlxtGVt479lfc
         EEXNFKkXOH+mgBEaxUbx+lKxSjZcGVM5noBt3Jj0v1+eeD1alKdft/Olnr4iK/7BCjGY
         tbpbThj4/8y1BXM7zoY2/c6VY1oLGZzIysCk9zGLGKEHujEOu5u+g/QFkXVaDyxA+1Pk
         Cs5CgwUQPCDx75EMVUIBdOmwsj+3pEfwpOYeH2sqovrk+W3IJsBIIGunIJ2L6KMqpwf5
         I5Zw==
X-Gm-Message-State: AOJu0YxOjFNEZkfFNYcrLJc0wYsDy9j+DN2QlAidgFo48AiTrB/IPn0t
	O/oC5hHHlv9dihxPjuleXFGh8j3g3KpI+dDePEhQc2ZezvfYxwlzuJCx3nhm
X-Google-Smtp-Source: AGHT+IE9P9isnWik3MI63pTSR49o4wHdea/Q7GE65TBti6gV4omXFppc+XfK1iGqG5Cf0WVX/fWpeQ==
X-Received: by 2002:a17:902:f691:b0:1dc:3261:ab7 with SMTP id l17-20020a170902f69100b001dc32610ab7mr2150914plg.49.1710469121273;
        Thu, 14 Mar 2024 19:18:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:12e])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902dcca00b001dd621111e2sm2470843pll.194.2024.03.14.19.18.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Mar 2024 19:18:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 1/4] bpf: Clarify bpf_arena comments.
Date: Thu, 14 Mar 2024 19:18:31 -0700
Message-Id: <20240315021834.62988-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Clarify two bpf_arena comments, use existing SZ_4G #define,
improve page_cnt check.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 86571e760dd6..343c3456c8dd 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -38,7 +38,7 @@
 
 /* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
 #define GUARD_SZ (1ull << sizeof(((struct bpf_insn *)0)->off) * 8)
-#define KERN_VM_SZ ((1ull << 32) + GUARD_SZ)
+#define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
 struct bpf_arena {
 	struct bpf_map map;
@@ -110,7 +110,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-EINVAL);
 
 	vm_range = (u64)attr->max_entries * PAGE_SIZE;
-	if (vm_range > (1ull << 32))
+	if (vm_range > SZ_4G)
 		return ERR_PTR(-E2BIG);
 
 	if ((attr->map_extra >> 32) != ((attr->map_extra + vm_range - 1) >> 32))
@@ -301,7 +301,7 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 
 	if (pgoff)
 		return -EINVAL;
-	if (len > (1ull << 32))
+	if (len > SZ_4G)
 		return -E2BIG;
 
 	/* if user_vm_start was specified at arena creation time */
@@ -322,7 +322,7 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 	if (WARN_ON_ONCE(arena->user_vm_start))
 		/* checks at map creation time should prevent this */
 		return -EFAULT;
-	return round_up(ret, 1ull << 32);
+	return round_up(ret, SZ_4G);
 }
 
 static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
@@ -346,7 +346,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 		return -EBUSY;
 
 	/* Earlier checks should prevent this */
-	if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > (1ull << 32) || vma->vm_pgoff))
+	if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > SZ_4G || vma->vm_pgoff))
 		return -EFAULT;
 
 	if (remember_vma(arena, vma))
@@ -420,7 +420,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 		if (uaddr & ~PAGE_MASK)
 			return 0;
 		pgoff = compute_pgoff(arena, uaddr);
-		if (pgoff + page_cnt > page_cnt_max)
+		if (pgoff > page_cnt_max - page_cnt)
 			/* requested address will be outside of user VMA */
 			return 0;
 	}
@@ -447,7 +447,13 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 		goto out;
 
 	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
-	/* Earlier checks make sure that uaddr32 + page_cnt * PAGE_SIZE will not overflow 32-bit */
+	/* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
+	 * will not overflow 32-bit. Lower 32-bit need to represent
+	 * contiguous user address range.
+	 * Map these pages at kern_vm_start base.
+	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
+	 * lower 32-bit and it's ok.
+	 */
 	ret = vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32,
 				kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE, pages);
 	if (ret) {
@@ -510,6 +516,11 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 		if (!page)
 			continue;
 		if (page_cnt == 1 && page_mapped(page)) /* mapped by some user process */
+			/* Optimization for the common case of page_cnt==1:
+			 * If page wasn't mapped into some user vma there
+			 * is no need to call zap_pages which is slow. When
+			 * page_cnt is big it's faster to do the batched zap.
+			 */
 			zap_pages(arena, full_uaddr, 1);
 		vm_area_unmap_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE);
 		__free_page(page);
-- 
2.43.0

