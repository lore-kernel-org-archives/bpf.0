Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16063337699
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330560; cv=none; b=TxZCQPCv++vRIHaO3PxR24F5BgUJuawP+aX9m0t7OBXsUbgZYjGb7D3gM3LbsHlANIDj3rScKCKhyDuS0k8NA+EXN71nioQhlcyavmay0+z+sgyIZlVvYTjtWdLdnHbR++BV0fMPgUNp/U8qEt8jMFvHlNs4M1HbOkOTxemJJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330560; c=relaxed/simple;
	bh=a9mtm6JKnLQRSDyhS+B+EekIiklXj9fag9Oezhn2aVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJThcdccf4c43+z+nZs+IOy/PzKhSPszn9bxgOetdkoNK/p4HQW4LxI9MSPDbJe1fT7UJjZ5KA7dQqcsIYZJs3Tg7IDOjU/oscQWZT3iOM9nyV9XdYCQTUxSMxOkWB15J5Eav+QlhrWwLdpm06PMyElNsBLVMFfhIdHlKcO4ACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NslB/xwM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NslB/xwM"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c626bd75628so468256a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330559; x=1770935359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acngkvk/SJDpuSIXTzDxVJ6in1fJVE/cZK66EwuF7jA=;
        b=NslB/xwMtOX5n58yTIxR3TLuBsBjBhDvleB3/3nQpFuY4eAO0w7IISGbyZKy3PgFCE
         6YhIlyJvCXbBMWMs9iiSjrfnpUSxkfEq/O51jsEJhbhB1LShbWI32mNVDCNRNBd/qzn/
         OwVYRyWNWOUV5RHPKQHcsWvKZ5YP4r0rMfW1mUFTYR+WiuBH/C/4HVOqkNLlP+lN8n1C
         lRq078Yi2F/Be42s/r8y+gfak1fytKsvCU/LKKz0gutyjiq70VekGeYRf+azkj4T7YgI
         2TscByAaGbwydl+W3XdtSeBAFHnaurPddAWEadC9jRoX/DIDMobw3b66HMNpwNHMEyRe
         nXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330559; x=1770935359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Acngkvk/SJDpuSIXTzDxVJ6in1fJVE/cZK66EwuF7jA=;
        b=nL1ITPnEB6aMBxCH+0Qhr0EgGpvE4bRNwCbkDNcHHEa0oF1skK/TG0/dvTed/y4BGa
         MdMT9pWPCLGKdR1H3exy9BWXUq3ddJi+Dx+gWHIGAG7OCHxRSWLDV3MziQ8G43eBLlg4
         pfpUaG2hRROTWzL28wEN/5ptsZZujNl80NhpP9QaFKIVB47a8Di2KDnwP9Wb4nx16H0L
         IbrshFFz3C5ooFFsHFVUprm4gybiOarRa+M43SiS4c2Zn/YKwlCoertPrftglAROcpNe
         eWJiGmMVrwZoTolUXni1skCoVUlXTheMJ2cNMxdhqXxuERnAmrEyIE50N0pdfmzBxOYK
         nbDg==
X-Gm-Message-State: AOJu0YxryOg3zZq8I4vSUA06NUuu0K1WqIjSL6p8lZN03KgAmeANCVT+
	ktNUN37bbtJtme2cjrHUwQZJVW8QamkCs8drxLtLy3OZWmuXKXm2Qt3Zq4LXCw==
X-Gm-Gg: AZuq6aJ007LWcs5evnp+ISFuCOEa3SUoKTa/duzRc5kral2Bu54TUAcux1TFybBwuk/
	gIfszuvb5dysVigXzwBU1RfMiSABf4IXK0HQU3jT9Qe/zoqStYyJmtLb3hlTuZtvsIQeG8TZbxb
	84BOULY8XiLL2E/cSirOHiCKx+0hyk6g9Jly9/YIBHWCr+q0jPJIZX0ObdG2VsXtO78RBEJKWJx
	66exWUgX3Qu6t7VCCmkwbAbjUcg7FhmHWXn9hhL2LIb0O9K0w5o7dkR9H/078c/yhxEz87nlitU
	F+IDsYMwYL8mbbQWAsTdDVWLzGUqLDDYvfqV4yHvSqR1N40qLiHUYfzhJnNFGW5saf4mAP99NCR
	VFuX/Op62op4nG424wP4qtsjLn9Y8prjARfwUyOjFqqTt6DCpsRyS+RLurgCuD/W0L+O9M5oelt
	h54A==
X-Received: by 2002:a17:90b:38ce:b0:33b:bf8d:6172 with SMTP id 98e67ed59e1d1-354b3e6d619mr420030a91.34.1770330559125;
        Thu, 05 Feb 2026 14:29:19 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b45a2987sm143334a91.4.2026.02.05.14.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:18 -0800 (PST)
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
Subject: [PATCH bpf-next v7 01/17] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
Date: Thu,  5 Feb 2026 14:28:59 -0800
Message-ID: <20260205222916.1788211-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
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

Performance wise, this is slightly better as update now requires locking
one bucket. It should not change the level of contention on one bucket
as the pointers to local storages of selems in a map are just as unique
as pointers to selems.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  1 +
 kernel/bpf/bpf_local_storage.c    | 17 +++++++++++------
 net/core/bpf_sk_storage.c         |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 66432248cd81..2638487425b8 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -179,6 +179,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage *local_storage,
 			struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index e2fe6c32822b..91b28f4e3130 100644
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
@@ -366,11 +369,13 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 }
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage *local_storage,
 			struct bpf_local_storage_elem *selem)
 {
-	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
+	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
@@ -448,7 +453,7 @@ int bpf_local_storage_alloc(void *owner,
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, first_selem);
+	bpf_selem_link_map(smap, storage, first_selem);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -576,7 +581,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
-	bpf_selem_link_map(smap, selem);
+	bpf_selem_link_map(smap, local_storage, selem);
 
 	/* Second, link (and publish) the new selem to local_storage */
 	bpf_selem_link_storage_nolock(local_storage, selem);
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index de111818f3a0..e36273e4fcbd 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,7 +191,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, copy_selem);
+			bpf_selem_link_map(smap, new_sk_storage, copy_selem);
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3

