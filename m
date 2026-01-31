Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF33370EB
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836176; cv=none; b=ht9O7SmqEiG9Xov1Tljw5oUiBrgi4MRBTB+1KTMTQAWWW3kGEdn6BHPuVsimP5J3YxJCz4vfbD/OgalyuJPOzrA+FDOTdTheoohMS2aLxZVRp7/t8PkSlFQBsMWQ0v6ZZwv/hOWV6HSihUJ5F013y5m23xWsjeAd2SwmOqWI8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836176; c=relaxed/simple;
	bh=7G76bSoQmX1Hi/VvKi6UReL/Zsyk3cYD6d7hNbP7K5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFixn1Prtfm8nZQQ9t2kRfeBEMnEaXr+dgaaeUusoZ3+/AQAPK03QdWXHBvIOhv6kEz+6aVOtYtWqN32pN5UlSkbwJe8UIgIDa7X2fzgv/PblC5kt6AoDVB19Wl2J669bbdpuaw6P/pxUb+6WpEny/Dbu1VXL4UGfRBtqGFlDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbFlR0Qn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbFlR0Qn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c21417781so1432908a91.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836172; x=1770440972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTC2NAeUBpSoxfV1jyI9ihzRy5Gdcws7bJcw730/KGs=;
        b=CbFlR0Qn/F0C2Ki3C5DmIqbJtmPXOt3p2pyOnwPq2EtaRuHXgZ3bOfan8IA1cJp/4F
         K1AcYsXCYqJ9W+X0785ejO9RTDDH66dkF0t5nUSka5HC1zudxPgyF8suZoUWsv4SlZzq
         HS8B8wgV70MTnwAeRqS8hvPzKVRRudQItXc6fpASpHGMo1CAl+KhoDpdBSWsBWMZOtmf
         wqqb1KgfR+kx7ijDc8S0xtlP43OtX2TTm5BtnSe6r7ug7sn4GKSfSdLVWCz8Oe0QWZpF
         RhxpA7o7SZRWJo+14xWR4np32c0BD0TNF/6HYiw2WLtJSrV0dnwmT9pxOSezZMXS0a/B
         ckiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836172; x=1770440972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTC2NAeUBpSoxfV1jyI9ihzRy5Gdcws7bJcw730/KGs=;
        b=CQApr/MLMAUAUN6JAny52whZ+mulXWKX+QNMtt8z2XGF+YwjCy4LpHqvVd3nNPSi30
         ppxdhbxgHBxJ5JCodhME1Rz4qjvV1pwJpbBDs15JIAnrzD6g5t2ztl1hNqm5b1Dosnm8
         7qMolxYS4BmQJ6zJKkM6mQhDEiZ1s9YLtZQHkL2a+uH/5A9n6DqjeIFXiTeA9QW5x6v4
         yZ9NjFrjgkCzZTMIKPf7T7sNIwadH4iRMs5oS2tr83QM2MQ18FUrCIrlz+xtLTEMUj5J
         bnORwsjMlhI4NAeiSPIb3QmFyzWCSoomwcMPfRMSdG3x/uXuae9dK6ZQbO+SFiqd7nur
         O+qA==
X-Gm-Message-State: AOJu0YzbQ4dAwolFqABOCGKJs/Bs0eAzHNJCGyC8R2ElQApHfHsToRTF
	VmhNWKGLGTNepjY0LbwRI2M9kjUHcFAnp4uhIIGnSNSoOiuJAfRuprL7FIiliw==
X-Gm-Gg: AZuq6aLz3xSD12vphUujLczboJIpMiHrv7xuABU9osUZqSvqMsEGLX9ZEEspkza2ONe
	MHE2anyQJHgV+xOmgp8PwWgyNuaNsvFU6DCzRU0UFlvOV0WebgNkOFnPDxU0A0fH1o9B9RRe44M
	2FdMkBnc9EqeBw014B2+zEetEDe1ZY7NlG5i5H5Z8hFw7xtxRs9K1jKTjFACjy9DOv4Z8E6Vn4P
	mpW1YFfCveI8mVZ2nwQBy104YDYQ09VCNjeWGT3/daWHGFdkpJzVJkuRNcUYfxzV9p8QBHJxESN
	5/rS5L07pmUE2M6EKTn/fa9+tiy0KDeQLJUTD+Yvp1xdGNECi6Dwk1okJIj6bHmY6Cd3pZjMcy6
	m+E2Ki4ouUrK0iYgy/UgytohzRW8huVHSaKA7zseTf8D/ru8qEkv8nM7rYtZS8pUzWlL2/gBOHS
	cQPZRWFMUS+Apa
X-Received: by 2002:a17:90b:1343:b0:352:c9c9:75b8 with SMTP id 98e67ed59e1d1-3543b41d89bmr5015894a91.36.1769836172256;
        Fri, 30 Jan 2026 21:09:32 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d72cccbsm1552887a91.13.2026.01.30.21.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:31 -0800 (PST)
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
Subject: [PATCH bpf-next v4 09/16] bpf: Prepare for bpf_selem_unlink_nofail()
Date: Fri, 30 Jan 2026 21:09:12 -0800
Message-ID: <20260131050920.2574084-10-ameryhung@gmail.com>
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

The next patch will introduce bpf_selem_unlink_nofail() to handle
rqspinlock errors. bpf_selem_unlink_nofail() will allow an selem to be
partially unlinked from map or local storage. Save memory allocation
method in selem so that later an selem can be correctly freed even when
SDATA(selem)->smap is init to NULL.

In addition, keep track of memory charge to the owner in local storage
so that later bpf_selem_unlink_nofail() can return the correct memory
charge to the owner. Updating selems_size is protected by
local_storage->lock.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  4 +++-
 kernel/bpf/bpf_local_storage.c    | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 70b35dfc01c9..ece32f756d86 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -80,7 +80,8 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
-	/* 8 bytes hole */
+	bool use_kmalloc_nolock;
+	/* 7 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -96,6 +97,7 @@ struct bpf_local_storage {
 				 */
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
+	u64 selems_size;	/* Total selem size. Protected by "lock" */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index fbf41e00be8a..b8f146d41ffe 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
@@ -214,7 +215,7 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
-	if (!smap->use_kmalloc_nolock) {
+	if (!selem->use_kmalloc_nolock) {
 		/*
 		 * No uptr will be unpin even when reuse_now == false since uptr
 		 * is only supported in task local storage, where
@@ -305,12 +306,19 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	if (rcu_access_pointer(local_storage->smap) == smap)
 		RCU_INIT_POINTER(local_storage->smap, NULL);
 
+	local_storage->selems_size -= smap->elem_size;
+
 	return free_local_storage;
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+	local_storage->selems_size += smap->elem_size;
+
 	RCU_INIT_POINTER(selem->local_storage, local_storage);
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
-- 
2.47.3

