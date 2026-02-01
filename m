Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B3278161
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968263; cv=none; b=nMlwGRbExTbd6a5eIRTOJi7PyRvOEmS3xzVlXM1avom9Q6Bh27iPHizbhISjsuIAxw5VbS6O96sxTaO0UIgzZvyXY67f9JrC53ULAt7Qr4EehN54LBrgBnRyUidz6GXd6gTjI52W1PlgRvxhvV3cE6q4QX0hU36dv9J7ZrN8n/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968263; c=relaxed/simple;
	bh=CBqTvdITmV4N+zgSeN68ivxwV9Bq9KzptzQRZ9/vtco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMbngsGAPYARTe68YPm8Ud361pKirZyeVD06GXZCxviSdFIT4ZocQ8vSj8p6HenK8IiNCymTsCTtEOtIM1hsh1EsJHDv+fp+67ZBso1LtMSruA3JR5pHz2wo2ERfXz3fls0pTcrfswXa2s+3ejVj3PEKfISLd2OdeC3btFOi77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePIEZY2+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePIEZY2+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso2057577b3a.2
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968261; x=1770573061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PjMDge0fA0s+oiOs2HnEWzWgjzoILNnSL9xL9THcxk=;
        b=ePIEZY2+o7+nqQ6BB/hNSSjoRJmDbnDpFW9rkF2TdM0piQ2wWfPiq9oYrsV8Rk2zKh
         atSMC+mQ97/uS3SoEikYtXhGi1eP3e5B0vQUaH7RFmES/X+ObvJ6vSVL4PGR5IcHGba8
         4O2UUYxfxzlzwr1JOzQVWNzROax9Thr8pqWYjGVIOyAPH4BpPL2/iIBikndqkZqy4Ofx
         NeaCTxyckvbmpNjb47cpoqRK6H+IWffPTPGw+KE6GbHEkCjg/O0tSPqi1utV7Sdj4Mjm
         0uKM6Nyq0hqfCGcbSSP0LuyVUXc9tNxHtqlr7aveCF5pWOXM9diHSHrIzf9gpPuobzX3
         CXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968261; x=1770573061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9PjMDge0fA0s+oiOs2HnEWzWgjzoILNnSL9xL9THcxk=;
        b=E0K7TIUeHSqnHpaYldWVU0VgKUEu4zeBpukJvg0k2zDH3gAeYTVWCLzmHy/4y8Fp1S
         EhlSo+H0MW9FYYrZHWcitIaMq3trHpSeSGO23xgaN60b7rafm2w8nTYkq3FeE+yTnRJJ
         nHYbdjt6cZheP6uAvz4WTHpP35QphPh3hDSwp4gkTWLWh37CHxqrn+mMsOgXxYW3TItM
         T1VwjaqwOOfPXhFzwnNvc9u/JsGr2EaTWJ4w5FTRHAZwoGeJG4johhx0R43CbVEbeWs+
         JM8j/q/yuOFiYxkUqoIVG4OAWxbSlhy5ZpcuQBUfAS7eZwsY47UKzt+M1ZGll5kZdq6n
         TnkQ==
X-Gm-Message-State: AOJu0Yw1T6odVEZJgAVku8TO5qokTj6w78UELhc827EOWVKEjgkGQAQn
	M9pOzt0tY/NTSL8VJruo4832LReilZdxopxykstxBKeYrmscsU8uKJ3DF1y9Ow==
X-Gm-Gg: AZuq6aK/sgsINJDEIc3lsNCQnN5dTA/S1s41ervgZrbtd0KwlPjT3pRnipoPB04LJTc
	nNPRm8TJf5mKMiFQxJ+MMmnaXY1xGppf3XdmZc9O+yPytZTIrPcYSHYSw3zysGC9RqxormTCtEv
	/ACyH3ntcFEQ1xHGl1hD5uHzwG1ATsNWf0UzKUZUPxAECv3X/BEV3by1WhX71jurjVwuquMtw0T
	HfiQW0z7xxPiUu6laOe6AqYTsFIf6gW5mz4X0OgwZGqtGTE1BIXWgqFT1Fky1K3evPYoBjAN7Cx
	sjxMK+F+SkDVzItVoPbDH1GZBZJbWWKUMNRwX4gZkqvbJPiLN7emvkJz3hYFUifs8hw+Gzw8q5s
	KxA0Vgf0vdZF+UGEZjMv2cbWmyizVMuHZUMSjVt12TO4ZVptVX6r/gHa56K7++mzJZ3sKl93p4G
	qUyOBiIX/QaHY=
X-Received: by 2002:a05:6a00:4b46:b0:821:70e7:b10a with SMTP id d2e1a72fcca58-823aa40d7e9mr10568626b3a.8.1769968261343;
        Sun, 01 Feb 2026 09:51:01 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c1fc6esm13366401b3a.47.2026.02.01.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:00 -0800 (PST)
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
Subject: [PATCH bpf-next v5 08/16] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Sun,  1 Feb 2026 09:50:41 -0800
Message-ID: <20260201175050.468601-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Percpu locks have been removed from cgroup and task local storage. Now
that all local storage no longer use percpu variables as locks preventing
recursion, there is no need to pass them to bpf_local_storage_map_free().
Remove the argument from the function.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 3 +--
 kernel/bpf/bpf_cgrp_storage.c     | 2 +-
 kernel/bpf/bpf_inode_storage.c    | 2 +-
 kernel/bpf/bpf_local_storage.c    | 7 +------
 kernel/bpf/bpf_task_storage.c     | 2 +-
 net/core/bpf_sk_storage.c         | 2 +-
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index fa50b7afee18..fba3354988d3 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -166,8 +166,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter);
+				struct bpf_local_storage_cache *cache);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf *btf,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 4d84611d8222..853183eead2c 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -119,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+	bpf_local_storage_map_free(map, &cgroup_cache);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index cedc99184dad..470f4b02c79e 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -184,7 +184,7 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &inode_cache, NULL);
+	bpf_local_storage_map_free(map, &inode_cache);
 }
 
 const struct bpf_map_ops inode_storage_map_ops = {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b33ef5fb5b49..3735f79a7b55 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -808,8 +808,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -842,11 +841,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter)
-				this_cpu_inc(*busy_counter);
 			bpf_selem_unlink(selem, true);
-			if (busy_counter)
-				this_cpu_dec(*busy_counter);
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index dd858226ada2..4d53aebe6784 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -217,7 +217,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, NULL);
+	bpf_local_storage_map_free(map, &task_cache);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d7b5c4551997..d2164165a994 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -60,7 +60,7 @@ void bpf_sk_storage_free(struct sock *sk)
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &sk_cache, NULL);
+	bpf_local_storage_map_free(map, &sk_cache);
 }
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
-- 
2.47.3

