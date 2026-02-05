Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CD33890A
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330567; cv=none; b=Hq6K2MC3XY7SH63RhB2S+YcWcD2tHW4bnNe2UWYRo5IjE7daPY4fMDEPyo+AaONYQfN2eeppL+7h5P3/6EperLvP1T6ZUTV2k8OmUI2fL/iNcWvgzNRaCaLf5NI1ICg2TKaBNl9ghlOI/VQu9Mmg8OOux8E6HGCi0vGKEpqFLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330567; c=relaxed/simple;
	bh=4ZRqKZRpFWHRWXqqOpasvMmt7XX//hviM4bONBumJQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flik6nczLkrg1VGX8ppunzCYT6YMSktEwRD38N0K4FPqB491OHMF3llDa4fWwvPpkLelrdsIeSpi5y9/QdP23LlFwrmtYqQzuh2uxgR6zUJxfK8I7N4bWC8w3MAVI0BvEb1MnkVwSfq5RdCRJjJ6kK6hDyVir7LF1xlEogypGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO17YGkT; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO17YGkT"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c56188aef06so638196a12.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330567; x=1770935367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojZk2Pbcm+yeGedLeAgty91yUK/ZM6gZe51po3g6YyQ=;
        b=VO17YGkTFNM5It6t5TcQ5/cwYXbF2wdLNAh5hgFL93jkws1hY55G5BCoffFWKJS6dT
         7tTIOICdXRoPfelSXhr9IKL8dq0oqIqDA9gY76jMKcIgVS/2c/PRcuV697FqLA3v38M6
         BKSVGTAsoWZPL6SN5Esfo2HIE/fEApLsnG5N8WGnbhG6vFERMIX9Th3UjXnwOc4ZBEFx
         CQhEeiWN/cZyTd2oqQabQsrdM3PIggTDnD8LoRkVpG/pZ62fwlvFKhQNwrlrhNV4ZX0C
         gZAxm06oPiuBbxphGZ328wKUlzS9A4sfqglQYcl7lO9/gzoVGqiw+baiye23KDXxxSk8
         NK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330567; x=1770935367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojZk2Pbcm+yeGedLeAgty91yUK/ZM6gZe51po3g6YyQ=;
        b=beOnft89NyGdgcm1yvn9D28/zHGLgk+tJtRLIp0AkWsvrP64pJEc94OZ5ANx8xrLUl
         HHBslWY29bEke3by78ywXeIWo1r5I/KxUNUxm71GPATIEgK9nlzmxb0ceI8vKCyAVJra
         M67d6bpX7mxidT95HMoEMtshOfdHTGpw0fkxX1CZSh4jdOL4TT6MU6o/0bpi0mo1jaGb
         Dk3EpvZ521JTrzOCXpajzBQo8RrdTmcowoI9UcT40Gm162d/MqRxsWa/qLGNeZZ/O5wy
         JbAavQdTSUPbOJZRFFV85jGWnEnoBVPNLJidPdMPQqz0K6iXJQ7CzsyCsXhloOFDCme5
         LK9g==
X-Gm-Message-State: AOJu0YxmHZ8coP8XVuOhLbIr9PuEOxptYz7s5nOTDs8KFsz/wSgKRgvc
	ZK1fFheAnSDVY/4CuUgwEIbtxH4XhyoS+eQ6TwzNgzTMN8gDSHiN2w3+KYritg==
X-Gm-Gg: AZuq6aKR94/ZMz6oz/WFyafmCEA4IvoAgq5xAozy2kM6bfGMY1rIsFMO1vGT2BeS6LM
	JtyUB7g9nPWznNDGWx7/Rh9S0mg5uMUkCt7N6TdlYjgr/ymQhBM1qib0ZT5PiAtcBbvML2NPCAp
	sddYeSZBYqI4i4Md/CkcKdzES9JFAESkPXU6Fo70yLu4nbEhApzTd3Y6eRF9z2/PGozNqOIupQk
	bxCSb4WzAB9YZImJ8jYySZ0DYDn8/0sTDeWt3dtjJaO+TP4OaQUO3hsnmrXNKqFRiEI8lBg6azK
	zba22G/FJTrgzyn26xuYTeN+NhSBZ3SmLeaDevSAfAyT/s4Yt7tC/Y5A353HXUzVqM/Y2ilnXiV
	bAcQUP7VDDvK1f+UqaGcoLfQhGDx8/FIjRuRIRXEuoEBgeE3ZYI1AVS1E4XERiT9rzPhWUlofrt
	iESe/dO6WgQwyV
X-Received: by 2002:a17:90b:2fc4:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-354b3c6b553mr378932a91.13.1770330566744;
        Thu, 05 Feb 2026 14:29:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b1e3d056sm505595a91.3.2026.02.05.14.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:26 -0800 (PST)
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
Subject: [PATCH bpf-next v7 08/17] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Thu,  5 Feb 2026 14:29:06 -0800
Message-ID: <20260205222916.1788211-9-ameryhung@gmail.com>
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
index 1138e2293b50..76e812a40380 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -807,8 +807,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -841,11 +840,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
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

