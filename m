Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862713382C0
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330566; cv=none; b=NIxewwJsMyJsQ3GjZlm80Arw09dBT9qoBURreKdvZS967WC2/UjTGMKEXytmB9sZ2PVSCIQT0hs6TGuSfgItYS7K+Xh/SGDxQhaDBB8rsDudlZ93kQYunW08RxQPO6ttv+f/tJ3IP5ED+Pfwywbjm6Utz/1JOPJG52hCe3OqcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330566; c=relaxed/simple;
	bh=+VqL2Tt3DZfEzJCZumYRh3TB8bCtCTtoeuVGc7k8YZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVs/VDm60clovv43ONyRTsExS0dv10CScJBqSx3TDDY5Q5X4wBSLNSzKk/XgHhDPIBN6ZFkrOuIgNo22i+6LcLNKRZYKeV2CkQ0X04SdiYK+d0twBN2sVz3/Hz8UeG53GhHvZC/hC04v7eA3nSGgUGAWKKpTyu936CPm5Z1p7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMNpBcBR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMNpBcBR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81df6a302b1so126597b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330566; x=1770935366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=GMNpBcBRKtQilAegmk85PEsxVSva8MJmFWJL1pN/xA2ad2vdwNtaW8z6y41qrrADYY
         rRCljzD08rfGf0YFUcjUGZ+aWAX7VlcKSMV3uhebghVTpJlQRWrND1pBMzJtTFr0Uqlv
         6Z6MCgjtPDfe+1evurnAIajPwU66M9i1Ik1yWE1PYiKfJqdF74HuLeFuo55d6FGmVVbm
         N+1F6WkPGuuPoB08yat1h2Yf+SLXCn1BxZHJ7CkHES3Z88NJvBXxQMvvZoz5qBYUljTa
         a1bW0mkTtTYs4jH2DbQro3WQKmeBIxGb27CiBA5tVg3cp7BzijsZxSNTxPqVob76hFf1
         JwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330566; x=1770935366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=RKwpNHjvO5AdU/ItTvN8M+D7HsARYgu3QfiDqZgiiyYWwcdnYrkFvL8C4Z6QVJOMP8
         kB4ELl6TLtAI3rM2JJIZNp7bLqrrjqzv0jjmM8kPsdMan/UkKZGd3s5CCH+R8mugPUkt
         1EOaLw1OT7Vx5QGq5qiLB+2WYd3fNCAKsYfIoY8z8EBqzKIyr83niOZOkg89UkPdAL6v
         LoQRQ/u/DZ6xJk2BRFYBuZvaDgAoaMc/YgjmOQXP1xv6lMak8mDIg97x9WsqbwEL/qYp
         YZnmctaXLTwa47SoBzqCrHI0iBTzoKP/NHq1Wsaz29Ybp34SU2TqH1m7ezXea4S25bpY
         nkxw==
X-Gm-Message-State: AOJu0Yxl/zOrPA2U4AVo+jzfKcYenhpxfLVzjSm2fuxm5wASMtGILANg
	PKAb8FHZBBpNCy12EGGGF1XFsyZDSBCIj9ap0wHGLolu0uCJb6X8kJ70tnemDA==
X-Gm-Gg: AZuq6aI73CFz0R4zQsIAVCPkwGKp3RQ5YhWq5CWeIA+/bCWwJfUujxSnmY4M6Uae/K1
	ZtxhE5X+O8aSetJOKtTVoZTS9cwgKMYOCanKTkkufLru/Zwspd9t0GbG5eBVkrxm37eJyMzt64G
	oBTIZSjcdp8iwlVstmk4uHeQiq1VMDpO+sXCHJdS3WMw7P6dXrzSmn4oZG1AtjqLVqc1fCoJWql
	ZX9eaq6VB0YuCG0j+0g7h/Bf8KvsOZxI2T0tUY05BQOXNhwIYvGO/lCkM6poTVW+T482lx5ArUb
	Yym8uTS7PFBHEAzamr6gDgnrJv8V/DEI22Ia4T8vuXySD9TIn3Y+ee5DiqougiS7Ym8aLMwuyWz
	IOAvM9+p74LK1LCNtbxr/H/RLZeW+IOFgSXJOpmpHbzHiXgJHG+7EYuBKAvBLaABWCTXcPKLS3R
	psMg==
X-Received: by 2002:a05:6a00:13a3:b0:81f:852b:a921 with SMTP id d2e1a72fcca58-824417b77e4mr477857b3a.68.1770330565653;
        Thu, 05 Feb 2026 14:29:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418b7cc3sm261532b3a.51.2026.02.05.14.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:25 -0800 (PST)
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
Subject: [PATCH bpf-next v7 07/17] bpf: Remove cgroup local storage percpu counter
Date: Thu,  5 Feb 2026 14:29:05 -0800
Message-ID: <20260205222916.1788211-8-ameryhung@gmail.com>
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

The percpu counter in cgroup local storage is no longer needed as the
underlying bpf_local_storage can now handle deadlock with the help of
rqspinlock. Remove the percpu counter and related migrate_{disable,
enable}.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_cgrp_storage.c | 59 +++++------------------------------
 1 file changed, 8 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 8fef24fcac68..4d84611d8222 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -11,29 +11,6 @@
 
 DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
 
-static DEFINE_PER_CPU(int, bpf_cgrp_storage_busy);
-
-static void bpf_cgrp_storage_lock(void)
-{
-	cant_migrate();
-	this_cpu_inc(bpf_cgrp_storage_busy);
-}
-
-static void bpf_cgrp_storage_unlock(void)
-{
-	this_cpu_dec(bpf_cgrp_storage_busy);
-}
-
-static bool bpf_cgrp_storage_trylock(void)
-{
-	cant_migrate();
-	if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) != 1)) {
-		this_cpu_dec(bpf_cgrp_storage_busy);
-		return false;
-	}
-	return true;
-}
-
 static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
 {
 	struct cgroup *cg = owner;
@@ -45,16 +22,14 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
 
-	rcu_read_lock_dont_migrate();
+	rcu_read_lock();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
 	if (!local_storage)
 		goto out;
 
-	bpf_cgrp_storage_lock();
 	bpf_local_storage_destroy(local_storage);
-	bpf_cgrp_storage_unlock();
 out:
-	rcu_read_unlock_migrate();
+	rcu_read_unlock();
 }
 
 static struct bpf_local_storage_data *
@@ -83,9 +58,7 @@ static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
 	if (IS_ERR(cgroup))
 		return ERR_CAST(cgroup);
 
-	bpf_cgrp_storage_lock();
 	sdata = cgroup_storage_lookup(cgroup, map, true);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return sdata ? sdata->data : NULL;
 }
@@ -102,10 +75,8 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-	bpf_cgrp_storage_lock();
 	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 					 value, map_flags, false, GFP_ATOMIC);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return PTR_ERR_OR_ZERO(sdata);
 }
@@ -131,9 +102,7 @@ static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-	bpf_cgrp_storage_lock();
 	err = cgroup_storage_delete(cgroup, map);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return err;
 }
@@ -150,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
+	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
@@ -158,7 +127,6 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
-	bool nobusy;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
@@ -167,38 +135,27 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!cgroup)
 		return (unsigned long)NULL;
 
-	nobusy = bpf_cgrp_storage_trylock();
-
-	sdata = cgroup_storage_lookup(cgroup, map, nobusy);
+	sdata = cgroup_storage_lookup(cgroup, map, true);
 	if (sdata)
-		goto unlock;
+		goto out;
 
 	/* only allocate new storage, when the cgroup is refcounted */
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy)
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 						 value, BPF_NOEXIST, false, gfp_flags);
 
-unlock:
-	if (nobusy)
-		bpf_cgrp_storage_unlock();
+out:
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 }
 
 BPF_CALL_2(bpf_cgrp_storage_delete, struct bpf_map *, map, struct cgroup *, cgroup)
 {
-	int ret;
-
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!cgroup)
 		return -EINVAL;
 
-	if (!bpf_cgrp_storage_trylock())
-		return -EBUSY;
-
-	ret = cgroup_storage_delete(cgroup, map);
-	bpf_cgrp_storage_unlock();
-	return ret;
+	return cgroup_storage_delete(cgroup, map);
 }
 
 const struct bpf_map_ops cgrp_storage_map_ops = {
-- 
2.47.3

