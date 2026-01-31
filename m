Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55A33122A
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836175; cv=none; b=VZirho1onEbAY37a3fI9V7ZdoMCfJ+LPDJPA4jTb+o8A8RG2oe/EeLUB4Fg6fjIcFvlnXDwvFgRD1wavSt5F8/c40b8mAjOFp+NDmgPebaIf8y0EVQ/t+r4tO9sc0y8swLpx9yn7bTqQGcA9YoGyCcOFRfNjaLt3MwwapFCkbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836175; c=relaxed/simple;
	bh=z1l6O2fj41AeAdTHfoNQOt2bbLvIyZnVxJVetECkZuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/HSAJ7iooaflaa6q9wX1lgT6q/1mKt13yhSir5tJJfAnZ/NNAgW+SHJYZKtPwR+Nu/hNJl+dF/RGYsxFk+qBhN9GJxSNApP0g9doxNn6n1Ca2j5y4YzyKbD9gSSv0/UlFW56OPnlcpYTNoZWmP+0N6ONE49V4WjZJTxDkzn5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfp50GZO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfp50GZO"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso1639643a12.2
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836171; x=1770440971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZj4Qq6gWipb61NsG4bbowbgKrqyJjAoChPF9p+stok=;
        b=Yfp50GZObJmcohr2QLEjQvPzbYcVgXoepziFqalADdFeNnTDDaxIN82by/758bHreh
         DRjiS2i4zgyoDRlhl4mUazBIKfk/idiX/Jub94DFS2SdYkN8GWYcPjAwHigPDBSVqrsw
         ovh3sN8UtHZq8yV/UeHdRnDk6OEPzH04zIfRBlXRQMfZTQoaxw1ymqfHzTm7YgP/zePq
         uv/PGxGazNc+HIQ6zWU+A2ZkzKLObi41Uwxp5zVjpPB/xcs4hGaTVxd4DLQ46GWWwylO
         UlLkqTWBG9b8Pqups1yx4oT8qv5+l77cDh8ICFWRlAGhr/zWxq4WErgvFzLahqi274ve
         dBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836171; x=1770440971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZj4Qq6gWipb61NsG4bbowbgKrqyJjAoChPF9p+stok=;
        b=CQKQIiSGznkORF2HtEffzEgRYazXhETzZKGvH6u4jqho36if0YiVJlzeAootzuGwo5
         5/vnqORWYMxb0WoAmTXDocLQIB/KE6jBML6yvFGVjdpivx2XT1gj/BmUUZuuUH6EniYy
         26FSCBncq+odLxM+n67mAdceAlCQyaotCVHmWeYFQEAExvJRTCHDEQAUrsG/w1T8yYqR
         h1EmL0BkGU9PCA2lVO94ijSCPCyygpElbyskRYdVivl4Oj6w1y+T2MVN3GOCcLfym8rF
         q47dPW8MzyQTV+xMgnBQGq9Es5/QY9uhVvStemkDQeGgFgqEtiCDS24Euw8BubMdGBiS
         RpZQ==
X-Gm-Message-State: AOJu0YxM5hBvqoO1r6WzLCBkJVMamDfOlTbXsyPitd/M3o7Cy36v2zT9
	ZzOcF3UTvnyAP5ncUKcKsSxuPRFHycsG0qO1nk8YiL0GNjAoEqLhe81H2l/saA==
X-Gm-Gg: AZuq6aLi8E/iZF/0OQp8/DNz8+tj7iXjssmrGcMni7ImGtjI4xRQ1FojNu5xy6w7/Tt
	gMRP7rL8yJpwInRFQ9eu+412FJkYLsScjDe5ppVxdtEJF06K3GiAGXs7t+5wJ2YejlacO7vNrZD
	gnZ3SC0+d5QlN0rjncxK5uYd0ABKF8ORB/PGS+krqUym63sz4zZKIwLXlE1vhGeHWvit1k2SR+D
	7TGwCNl17Mhz4ToHs9YKqn2tURkrpoc34HnrmB1aidP9/MddZt1WMm8yR7dgObiNbaL5xJw3uxy
	vlhVoS1zHGX2g541N0HRacD+ug8RI2d1W5TTb4MuLcxiU8MwRmXGYANhUQ8tk4NrKZItJ7nbS3k
	vnPyWWyy7+/h5paPbdMPtvoehik9mVZwXzX/eoeFMf9LrSZJZZhiDE05NmXqqGIyfp/Xiq2Xy5z
	V+PaZN2hoOVJV0
X-Received: by 2002:a05:6a21:3991:b0:366:5d1a:c737 with SMTP id adf61e73a8af0-392dfff921cmr4624583637.16.1769836171300;
        Fri, 30 Jan 2026 21:09:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd7654dasm62484665ad.81.2026.01.30.21.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:30 -0800 (PST)
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
Subject: [PATCH bpf-next v4 08/16] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Fri, 30 Jan 2026 21:09:11 -0800
Message-ID: <20260131050920.2574084-9-ameryhung@gmail.com>
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
index 903559e2ca91..70b35dfc01c9 100644
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
index 7661319ad2e3..fbf41e00be8a 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -809,8 +809,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -843,11 +842,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
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
index 78e936288879..7ec8a74e7ce5 100644
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

