Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2BE554
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781167; cv=none; b=OPF3MvE+Vg/dMIGcfdOcbNiCuRT1/QUIbWxoldzOz79KbSLqHji8NOrm2DkNzBIrDcP0HLvDWzKEZ1pCWd3mmqImSu2coC67BWQNP6waotK3zbUUUrKNj5HOcaLWlSuy8zMKxsIpz5oW/L7Mwbab/i9pH8EzhFsMzD4WmnY5UFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781167; c=relaxed/simple;
	bh=8u5FwGZOQvGWs13SGw8hCJZUOeF4oULonqwyw5IBvts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evlK2KfxW3kDlRn8xkcDVxDsbKhe+Nlc4Fqr1GNBZPLjhBQHRwagLE/3GOMzuQfofqgPfMOVXJuKsTjq+NCydZbXLcoyO4KGG6UkOI2x1djes4KSCJ7t0WAe0J3/2pqR/bx6h9PZRNvMV4d/0atpOcht12oPG+VwEBaRRVbLi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlbDHL8P; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlbDHL8P"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b276979aso315274a12.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 19:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781165; x=1710385965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f6GYPJ364QpWqK3mIvywnvJQ658PEM/p0C7UMLLVdE=;
        b=KlbDHL8P4aq7fpZbLmGoaf93+E/wnBHp7LgdCBTu6lHt8fjVfjPjvoGbBGZhGFjnea
         sN43n0keRtcgZr4+6EWIc9nRov5XY2qYJ1raHZgLxbG/+RTkYPEDGHSHZhekQPuy7BNP
         Fm84TBKEcERwZFb/oBS0GV4N4wAp0e8bOsirnVfkU95M/Irq+JrXfjZ/X9I6l+Ha1YHn
         HZHgJBt4cydHVznUO+4LcKgSorS50nRUKEBbijHnp89iFqge7bXMNT5NC5ormTmmoPOS
         zbikMsPFhJxVEEFrkB4pXvzg+vKzvuHAxivhpd8RZjms8OEbeEtJT6hf+Xd3VmqL9EBb
         2RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781165; x=1710385965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f6GYPJ364QpWqK3mIvywnvJQ658PEM/p0C7UMLLVdE=;
        b=APiunSeVhsl/ARffxwHJc0ViLzCyi2U1ie3qLAKPfgQgUOvkUbIcqqC82Jeqskb84s
         drsyvroM/Q3ZOKxFJsC3byMOlsyuj7xhsL3/E5m4S5ZLsqMtLwY12UP0Lr46rZPq7//y
         XzfqcsyRydKNJSIWK0dpY9JHCijCDp87/ojUB85fEl5RqY56ZdM+bXWupnz/05Q/BYpB
         AnAfDcHVl3dueCgT74qMEBg3dPRswuGrY/SRKUv3nMTTerR6UA4v+Pyi8FqJSr14dy8y
         deaXuk0VE2CMZPzY8k1YPhNDeV9hRS9M+GjJhX08OXm7+pvcsB3V0fcUdhn6a6onZLsa
         2nsg==
X-Gm-Message-State: AOJu0Yw6AO90H6BmK0b+eeLCkJuXXRlhf0eRFIVtXRmAu0NszI5jkyPS
	trNPMvqfbNc7b/6w4nujy7bFHefg+MYp0oFX3fhHc1HNS3myXHfAS6stlglJ
X-Google-Smtp-Source: AGHT+IGEdQLU7AekXaYHt/M4zx4G9I9NyuyA+kUeaRbBsIixDI2dAELIbyrcKtfsrQiv5EjR7PbEjg==
X-Received: by 2002:a05:6a20:e10e:b0:1a1:6a75:1442 with SMTP id kr14-20020a056a20e10e00b001a16a751442mr3048769pzb.11.1709781164771;
        Wed, 06 Mar 2024 19:12:44 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:dd40])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001dd3ea391f4sm2001199plx.177.2024.03.06.19.12.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 19:12:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 3/6] bpf: Plumb get_unmapped_area() callback into bpf_map_ops
Date: Wed,  6 Mar 2024 19:12:25 -0800
Message-Id: <20240307031228.42896-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
References: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Subsequent patches introduce bpf_arena that imposes special alignment
requirements on address selection.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  |  3 +++
 kernel/bpf/syscall.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 785660810e6a..95e07673cdc1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -139,6 +139,9 @@ struct bpf_map_ops {
 	int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
+	unsigned long (*map_get_unmapped_area)(struct file *filep, unsigned long addr,
+					       unsigned long len, unsigned long pgoff,
+					       unsigned long flags);
 
 	/* Functions called by bpf_local_storage maps */
 	int (*map_local_storage_charge)(struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b2750b79ac80..f63f4da4db5e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -937,6 +937,21 @@ static __poll_t bpf_map_poll(struct file *filp, struct poll_table_struct *pts)
 	return EPOLLERR;
 }
 
+static unsigned long bpf_get_unmapped_area(struct file *filp, unsigned long addr,
+					   unsigned long len, unsigned long pgoff,
+					   unsigned long flags)
+{
+	struct bpf_map *map = filp->private_data;
+
+	if (map->ops->map_get_unmapped_area)
+		return map->ops->map_get_unmapped_area(filp, addr, len, pgoff, flags);
+#ifdef CONFIG_MMU
+	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+#else
+	return addr;
+#endif
+}
+
 const struct file_operations bpf_map_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= bpf_map_show_fdinfo,
@@ -946,6 +961,7 @@ const struct file_operations bpf_map_fops = {
 	.write		= bpf_dummy_write,
 	.mmap		= bpf_map_mmap,
 	.poll		= bpf_map_poll,
+	.get_unmapped_area = bpf_get_unmapped_area,
 };
 
 int bpf_map_new_fd(struct bpf_map *map, int flags)
-- 
2.43.0

