Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960E18859B
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836167; cv=none; b=mzLTtQ3qJ4GOCvGhX0lmfVMw+UZfIq6l6IF6tlRwbqtRQ0rEpdZkPhG2/dvFONy4ffQ+8hBv3ma2MccBOQk5/JvfqEeM6U5qgvaF2JflE9UNX2YKo0PCJskUcEIvcRPrdPK+V7F4HBSRaMx3wkgUwXJhDnoBsJR3mKDKAkjquPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836167; c=relaxed/simple;
	bh=dVNhRFCoPz5fB8oJTj1ik4DZXJTyctpy0fizmsGyqXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DC+S09Vc82eyFUglnhbKYWGqMPvrivalckizdOsz3XT915u5VL2YKmajQ4AfL+Kb6fQSOY3r0f1gYEZy5hEl4+07FWJgsoI+BC7eyPgKcCuW67aO1QtvhW2id9ulYcXaeZfD8FONwhPPp4+SudkUc+wcO4V4T9bO0Akc5SQN/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4ZRygRf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4ZRygRf"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so1455550b3a.2
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836165; x=1770440965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeEFnOPDg+WkhPNJeXKtuF2o+yucGCuayjkKqgFaEc0=;
        b=V4ZRygRffZPkZ32LQA99Xt/9vyH5x7sYQOqmgHSCZ56J9z7HYVgCp7ZEQ4XUiXS4jw
         /jvJR5k1/4KiZbSQjws4no66xIogLKWKwxBElerTDy2ZuyXfo3CyUSfcdHtREopGN/z+
         Y14EHb1UAkp4NUI4vXRkZ42X9VxMXguqSig66GYwGNytzG0ZQtsk/b3qXIpguOCt/xZQ
         3R8949KqhY/sq4yfehA2pOw6SfKCxpMkI1e+tYdl+wA4x3LL4/jKywLSEtjHwAUiS12/
         dS9WddBG532M7X5q4meDS3kL8ghUnE3kaWfNOHH3tSt9FOZqj9ak6I9+o2zWnBjGCGp3
         WJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836165; x=1770440965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XeEFnOPDg+WkhPNJeXKtuF2o+yucGCuayjkKqgFaEc0=;
        b=aRGWuTffVQJ9YOXguydsh/vRntf9xbOXp/a9eojI0OeCVqmVMGPkMlwprie3Gj83g6
         BRYKsbLeCFsZpALrXrlaTEiTTxrQbvdCclWwVk7HdBl74gLil0eoZ0pNZk6/E5d6RGII
         I9YoReuB8PvQ/Phabir/ZKcYqzHgmTVNqrF9JuUdwXmu9vFsVvzxKhwaA7853k5Q371S
         jKwElgQLZKxTNcq9vqKsnL73kC1yd5UsPXfKiyzEkRjcvTMx6oJjhpmJWp4cQI7qCQli
         iajK4HNvZUHKmy7cq4D0bXs1yYMvDrb24/9o4ee+TaVHawdQRH419oaB5M6/KA00F034
         FQYw==
X-Gm-Message-State: AOJu0YymLdOl+efRFPkRtC0qOa5zCMep+u9m/hFB06kAwfUdHviZVAfW
	rN4eETHe58G4MC1ygrXp9OBtxS73AMs0lPlb2mhojywmv+TIwK5baViDnD4cvg==
X-Gm-Gg: AZuq6aKxVIlA1hcuI08SBllhRGmeYsLudtmXQCXsz3rrFKB1Dg9NUBeWb9HUyOPfuem
	VZYkTKyEXy2wJmQ6+PfMShZS19V5YxWMRTZ71yB1iEQsra8g6YNgznzEYOzdu4z4+jfNWDv1xmd
	TVoCtDOcq60jO+ZWkOIzYm/qRJRrbNJ2L85X4bflUiXkvvM3gAsecYfb3XiMvUvKNz/eIItkMRg
	jnh+oT494GtJucKsyVbb0G/5oAfYvFfdA0TLjB58TilVtWMvvTA1FHJNqGu6je9bUY4kdUx2rcA
	JSR+DiyPt7qz65/StI7dZ7f//aA6TCRnrjW+yGwBuEoCiPCpVN0E/fyETt6c+G9f0TLZVfElJN2
	bR4Mj0m2VdDdLSlQdtkkAX2PPWXpUWLjQX9+y1x+wgFqOfu84XMep2VETCqwI/sD39DrcsgvVAI
	xTow==
X-Received: by 2002:a05:6a00:94db:b0:81f:99a4:190 with SMTP id d2e1a72fcca58-823ab643c11mr5135635b3a.7.1769836165134;
        Fri, 30 Jan 2026 21:09:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c21112sm9418473b3a.54.2026.01.30.21.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:24 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 03/16] bpf: Convert bpf_selem_link_map to failable
Date: Fri, 30 Jan 2026 21:09:06 -0800
Message-ID: <20260131050920.2574084-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_link_map() to failable. It still always succeeds and
returns 0 until the change happens. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 4 ++--
 kernel/bpf/bpf_local_storage.c    | 6 ++++--
 net/core/bpf_sk_storage.c         | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 66432248cd81..6cabf5154cf6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -178,8 +178,8 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem);
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 1916ea2aee4b..939102a5f4f7 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -366,8 +366,8 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
 	hlist_del_init_rcu(&selem->map_node);
 }
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem)
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map_bucket *b;
@@ -379,6 +379,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
 }
 
 static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index de111818f3a0..9da11a53109b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,7 +191,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, copy_selem);
+			ret = bpf_selem_link_map(smap, copy_selem);
+			if (ret)
+				goto out;
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3

