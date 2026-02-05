Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E8337BB2
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330562; cv=none; b=dIFM4Ac0JljwPT8FsAgl4lULeOl3Lvg2HoWRvMpuZ8t++0suL5UGURuzpDuM1bx2jgaqJC6ODKwTt52nH7Yk3NKoefl/MwSRDZBHoD5ItOF8AHbGkK66BQtbHeYYiptWtKQ/HutSHIVxDob0U1YxN79bdj/FMLY90mFOnajcS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330562; c=relaxed/simple;
	bh=9nZ6jpC7RDqDEJq2NNVLElMp/GWAaSXmG7B6xW+5CS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gE6giwPriid7cjOwAHJs55bbrvrqNw+4dujghLkEsmeMZaVmdmv01nS2pZC6fdxVMuAinlQd2zRTb8DjU6BLjNl9/34H0UGFAfbCeMjPeswgFtIKn2lIf/WMX1Fn/AX2BKUx4PF2+qSxTtPE4SXEhhaSoE1HSA+myr61Zy+SkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur1pz1uM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur1pz1uM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a9296b3926so11807805ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330561; x=1770935361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFAdrsbHgzRyyWJg1DcmckeIQG/iHVdwXXcQIChXPXA=;
        b=Ur1pz1uM9ECo+AqkibUJOjdiseK23MBsE7p/sJxK78RDcucAwwbcKKT3o5SA9M5eYs
         ZcyGgKMImRqNgovVZVliKAHtvb97ISKtyOnyjmw/nKuiTnGw7IPRr+HoCB9PRScpvcxs
         g9+t20PKYrs2bjznKn3BGn4nNfjwF7ss/QGOu/0gNXMFx4OsIJ/NPQXakvwzcZa1vp5r
         yD+SReT9uUQL28BpN3Nh/XiK5hkgMQ4ZuTLiYqRkk/ugsCppzCrZr3HDGwxpMcqQaXSH
         f0Sj0pLplYLUPr3mmnr4rCjhhBY/Jz5LisE8nUKTtSkh60Ks6kTsHbyNRAO0INSx0FMG
         DURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330561; x=1770935361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFAdrsbHgzRyyWJg1DcmckeIQG/iHVdwXXcQIChXPXA=;
        b=ccIWfQR1AN7BPpAgwVGP0a/oFJwmf5dcEGG5YziwMNyCPkffOtFH3DYZZZmPrjmqXt
         9z4rG7Y+XfucXhOrBUUpcaHy8RazF9pY4hIMOfVRsHhgPAPOiRIlrTZp/ZQI8H+S7o3S
         NlhMXMWR4DiKj4md6l0BxSD3xJ+8RUzA1iRssiepJMIocwvi6ec/5PQ4U0WBpPudoRsV
         TfS2v8xSiT5OwXa0bS+swMiUBEIO7+iL8sxeq8KulhcRQKxfb2iPB2tDCLniOzxCNj8C
         i0/kkFnRuW42+pDSAVMGYEqjt4BuCh9w4rthqHyCukj7AsuDpx4jag/np0A8yXf2X1sX
         B0Rg==
X-Gm-Message-State: AOJu0YyTZMvDyjquCpGiZNrrT3oqWM+w6+aFHTOFER/EkFA+XWTLpf7I
	Lugg5fq9kfvH2XDBygpjgLRpm2k3vUwrwmq9rLZKpivHS3iPkT7Oj4T/hILHBQ==
X-Gm-Gg: AZuq6aKK0Um618D9RL3YdleLP1phY2a0f2W4Oq2anvxWqzX1+/JDGmWQQsTkRqyyKml
	Pw8u6bDUlVOsOWb5zpuWsdx8KlMgZBl/mqhpml19oywrsJx5/V0aDGTXq0mbuZXlx1Ck2LrLCe/
	YiLIABtvMJhtPmhsnT1NOe/Y8K+KNICI2CuEZydRpacN5r0nOvpuWPWE6VDB4P4gMO/cEzWQb+O
	qK1Lbdr+HgsXQuVBxn80l7Wp4xcCws/qhxk4XrqM41VAAYTnV3jkdWlvRyVJNJ6tkixVRDpiUnL
	HWfluB90fAhASytW4iwC+UwrmlBOkTgPL7eFhSuDbGO5pcs/cZ0ac5rMe/H/tvKJlsYgZWPPqq2
	XOLPhOBeza1dVdNYE/XVfhYWuVfEG98E4skyhLzCXyKaUajtUUeVUQ4pI8dYRGd12gbQcSUsTfP
	dMZQ==
X-Received: by 2002:a17:903:298d:b0:2a9:4e8:ae45 with SMTP id d9443c01a7336-2a95167e079mr6135145ad.27.1770330561270;
        Thu, 05 Feb 2026 14:29:21 -0800 (PST)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b305f6efsm246562a91.2.2026.02.05.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:20 -0800 (PST)
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
Subject: [PATCH bpf-next v7 03/17] bpf: Convert bpf_selem_link_map to failable
Date: Thu,  5 Feb 2026 14:29:01 -0800
Message-ID: <20260205222916.1788211-4-ameryhung@gmail.com>
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

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_link_map() to failable. It still always succeeds and
returns 0 until the change happens. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 6 +++---
 kernel/bpf/bpf_local_storage.c    | 8 +++++---
 net/core/bpf_sk_storage.c         | 9 ++++++++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 2638487425b8..709506e982a6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -178,9 +178,9 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage *local_storage,
-			struct bpf_local_storage_elem *selem);
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage *local_storage,
+		       struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 6fa71502c7d7..2f94ca4a4475 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -365,9 +365,9 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
 	hlist_del_init_rcu(&selem->map_node);
 }
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage *local_storage,
-			struct bpf_local_storage_elem *selem)
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage *local_storage,
+		       struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
@@ -376,6 +376,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
 }
 
 static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index e36273e4fcbd..0b85d8f2c17e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,7 +191,14 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, new_sk_storage, copy_selem);
+			ret = bpf_selem_link_map(smap, new_sk_storage, copy_selem);
+			if (ret) {
+				bpf_selem_free(copy_selem, true);
+				atomic_sub(smap->elem_size,
+					   &newsk->sk_omem_alloc);
+				bpf_map_put(map);
+				goto out;
+			}
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3

