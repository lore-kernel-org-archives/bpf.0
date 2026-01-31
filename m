Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD012FD69E
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836165; cv=none; b=BcXoUWg39w5b6KmcBuTcTvxiE1+p3uwrwExdq2J+Jq1Zw99gvLdjqlxVv5xJY3s3zWtvoZnRm9+XBFXA/UUvWBu7KAoA4LoYjzpGNTn3HN5tC7KQ9Y4UZPSIlgKwNDiO5Wc9heS8sUAzcoZlGRsCbvZb5MOgsAq9HlVhPjGHnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836165; c=relaxed/simple;
	bh=0cYFFL4ID+Ke5t+JDsj3nW6hrFD01KscY+HnJgGkoRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6JHR3Z/8AcsZC/PmbbYPmefCWehfTAKeEl3M4ge0HYRa8pROYkhpBZEn5DJ3ylKBoWVP1v38kyM6nCm+gRiLx8CS2lyMk9Ch154thOhgOjUAVSq8aO/rkhystnVsMcQ1r723TVNKkPXm+nqgob2K8bdI/ubngF8tCO6M+pqfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU94hfZg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU94hfZg"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4e36512aso2669070b3a.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836163; x=1770440963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o3cyyoBy24EAM1iNpTtyNRMAxUSkdC0pE7Ue9M7MyE=;
        b=RU94hfZgf+ypXCDWveYTdKoAlcz1aSQlIe3GziAq1gcANaHuHkvsQcQgBbf0iTc97a
         Mcbek7h7x1XodaaXw6t35LhhmPQsNsi0RT9TrxjeDLbsiOHmAmj55keVqZA3GmxxH/+y
         DJi3y0Sahsozk38P1Fs11KXbLaJgIo6w0zw7MHatj0Uqzs0SlSV7y1qersZ0s4u9QgNm
         Aj5nTZIS7zrprW9j8L631zfJyZDopISx6gHp/NepZItKm/I85LlYi+j4vTDNuOwel+Oi
         lk74bsuxYD1JXdwkmDVM4botDt9+7UqD6IgQZE4/yuw0pef5UkS+EKfkO/PyWj3RCGET
         Mtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836163; x=1770440963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6o3cyyoBy24EAM1iNpTtyNRMAxUSkdC0pE7Ue9M7MyE=;
        b=eSQd5geBrphMMvkLGTBlybvD/1o5sCRqlwJDoK0Jtl0QB+D4j0c2kwPu6XkgwDtyVD
         6yVIO9hpI1VFdSbwfMmsUrTZFXNDpRMYGvs1SR40eLFA9U4JhRR+XXnCdclOVAb3xyA9
         9wISyXjRhbqdEJsPm2XCzAZGE9bcZSxy/z+dWycHkm+DiGn/Fd7/5KR3ivjqzH/JYiXg
         1yvYYDw2wHs0tQxHNkl8dhUWEc8yU9R+3xHHPg5hIGSTlby0SH72ShGrqjhNj8fYvKXo
         1ojlhOQqMc/G9Vyt572Z2lPFZx4YyvC9B4xr7VkMobZP7duD/DzzehoPBQhREnb7jmIU
         a2lA==
X-Gm-Message-State: AOJu0YyRwyvUPlztBBvEGKEBnqfYtE0eumdpTkq2yVvnSLDGcaoxSviw
	uw9DvCw6e5FYs4gxq2GGbIHaS2BlXROdVe+oitjg73Io1FC1YdejcvAWFsEHdQ==
X-Gm-Gg: AZuq6aLRYqAMZp++e+zovAR1+O4QpCXzd7tjPDgtnihkHxe3Mo3TE5f0H4axf+ZA1ys
	V7R3hr5kxrKI1VuQtxcbXRKMl2+hqU0Hh4pzkh/68llS9ldUzLODB4p7C38aalM2eYIAsw7m8Oa
	nwJBRpNeq6iKkdTH8RwryOgIrWizrBQjK++PjcfYfDVFdujTNsTwEgWU1/memQOzqtwkxHj3mi2
	c6kOaBIYODZrpRTECUsy/0AZnqMIwXwI2aIFpU7NtXXi/u3zkOiooMfjCdIsm76ge7mMmBpmHHy
	sGf2KJMes6g3oC7+9VGlAbbVZVlhyFuXSgWoky2ZImBUVxnlFXij69H05xDUw5cOk5fp7vhiST4
	6/5Cbe/SNjklb7axWdSQUx1vVCUWrrl4V2M8OApgV9p4jepLeaXjhzOPpPBW00OFgeIM96Qit4w
	QxFg==
X-Received: by 2002:a05:6a00:94f3:b0:823:a0d:b745 with SMTP id d2e1a72fcca58-823ab74b9cbmr4954567b3a.56.1769836163006;
        Fri, 30 Jan 2026 21:09:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c1fc6esm9525808b3a.47.2026.01.30.21.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:22 -0800 (PST)
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
Subject: [PATCH bpf-next v4 01/16] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
Date: Fri, 30 Jan 2026 21:09:04 -0800
Message-ID: <20260131050920.2574084-2-ameryhung@gmail.com>
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

A later bpf_local_storage refactor will acquire all locks before
performing any update. To simplified the number of locks needed to take
in bpf_local_storage_map_update(), determine the bucket based on the
local_storage an selem belongs to instead of the selem pointer.

Currently, when a new selem needs to be created to replace the old selem
in bpf_local_storage_map_update(), locks of both buckets need to be
acquired to prevent racing. This can be simplified if the two selem
belongs to the same bucket so that only one bucket needs to be locked.
Therefore, instead of hashing selem, hashing the local_storage pointer
the selem belongs.

This is safe since a selem is always linked to local_storage before
linked to map and unlinked from local_storage after unlinked from map.
Performance wise, this is slightly better as update now requires locking
one bucket. It should not change the level of contention on one bucket
as the pointers to local storages of selems in a map are just as unique
as pointers to selems.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index e2fe6c32822b..6615091dd0e5 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -19,9 +19,9 @@
 
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
-	      struct bpf_local_storage_elem *selem)
+	      struct bpf_local_storage *local_storage)
 {
-	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
+	return &smap->buckets[hash_ptr(local_storage, smap->bucket_log)];
 }
 
 static int mem_charge(struct bpf_local_storage_map *smap, void *owner, u32 size)
@@ -349,6 +349,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
@@ -357,8 +358,10 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 		/* selem has already be unlinked from smap */
 		return;
 
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-	b = select_bucket(smap, selem);
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
@@ -368,9 +371,13 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 			struct bpf_local_storage_elem *selem)
 {
-	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
-- 
2.47.3

