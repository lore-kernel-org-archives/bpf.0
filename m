Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0790357A20
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274938; cv=none; b=ppBFv+RpGqRs7WvWO66p9LNP1572pTjR3lj0mVEgW6qRrWVjVqtBRPvoxqosZyceeTScTTwAcUbxxzWNMKwIPWTePvo8u3CfdLsHmuFLloOpKtSSCwszi7GhkAyYosyofgvVqdpQQxhy13RnFw7iCdV1RPo7ZEnLToZIWKbpXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274938; c=relaxed/simple;
	bh=+VqL2Tt3DZfEzJCZumYRh3TB8bCtCTtoeuVGc7k8YZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqY03N4zBJv9EBBZ72xP2hgagX7IIDd88zhKPVPdSfDpNJ0YC1fVWAIhr3QZow6BVGPst6b8+gbX50rK5/ZqdQHDhU7KYqar/Vszdm16IPT9d4GQTKS9+e9PgMLukrMAnBlzDmoCxHjYdYkr306lEpMdkHBIay0Md+MHUMcnd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da7fuRpR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da7fuRpR"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso291773b3a.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274938; x=1770879738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=Da7fuRpRFk4JooszeJvMjIPAH4M8H2t/UWS9xw7MoKbr9jlBMy89IbosO8Uuq1Jebt
         xenAKONeadHealxkDKjgg+Tmzw0KUO59LxQoiuihSctPeIZ/YFV9EdvxTpNeoY79rsQk
         09JbZxxsYe1v1HeMy9A17OUgKXzlEzTV7loPGmWY+rG+PtVsjIIfSUnAdyz/895Lq97g
         ErpFpykGnziNX28KD+K8fF5V2F8Rkyj5HMGS54/4oqFLzsSFkJ2QZZfAtXXj1+xBEvPg
         PbFz8jbPDe9JIgajqdVwuZoOOqXqPxj6F503UakHmlWyEtgb1CBwpCFWWXJ+nEbNo0yk
         dyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274938; x=1770879738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=YZr2n3XVl9+4ecJ8BH+7r+ATMJJh+Ghoam3VPeSRpziYHaU4BQpkYr56+zs4jRPxam
         ihyfkOmVTrkxseMBlxzMAIYs1w2bvgMuYnl3QaqW41guzwrcPe5d2NMAo6rfHBPGC66O
         aCao3cQ5hOt0kUx089NvAxpg+568hUPoKAzNK5g+VqULK10h9daQZ8CS9PWbP5Ifm4mn
         AtKVi+k/U4TPsh+21M8AZs7woLZulZITKYmyAdqBOON/ihX5ApB/SjWSMk+O3+tTBcYw
         WZXMJMY+yJPlbxzfc0Jmt0q5hLEFEWuiWnTwOTZ85T3tyTcIhi1mAZL77L5DImlxC3NT
         cfBg==
X-Gm-Message-State: AOJu0Yzyys2BdsA1UoLfSXHHuSo/NUGKNEHJgAkjzed0bsqmyZknhM6A
	iVXIjEIxN8uQ2kh1Ws01ebgtf56brQ3b+89KO35Dsz+hGm1jAIC0lGuhhGcUjg==
X-Gm-Gg: AZuq6aKMDMF0kuy3spBINyQu4pG17G7wV7VZeX6jkE97gMmeiaAVm6gNs6u+6+4lPJQ
	J/M/oFhJIydBwhkXIvJejAWdbvWK2AnuMrzEqE3OY5iqJnch5ReLPQVxqRrwyYWGh1De9iNbp4i
	tSJmTS+PcwWUFVduPNxQz6DaNrpiqQvQpfaqAzxzBijmSonVLfB+3ruxWFdm/ya5u4vUD+wR4G+
	pcWN5fs66OEIQ+THq+rVLT/IECQ6n0fpn0iAY/cODzcu0Mvcxj1KYLmMBRghM+9iY+T8sxVUVno
	mPZF4KAvVuc45x5GqXwye+KecHXr+FUoqLKNTSXgCKE+TG+yqip+ET21CirekkDzVWHohoDwKqC
	uPVKN3Bx6perAPnlDskHj0xJbHuiPX2z4bgnfMvqt0Tsf3MRmuqkDFa3M/pe5hY84MAM4Kiws08
	KtAw==
X-Received: by 2002:a05:6a20:2447:b0:392:e5eb:f0b with SMTP id adf61e73a8af0-3937248b80fmr5807159637.64.1770274937858;
        Wed, 04 Feb 2026 23:02:17 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e387sm41482815ad.48.2026.02.04.23.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:17 -0800 (PST)
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
Subject: [PATCH bpf-next v6 07/17] bpf: Remove cgroup local storage percpu counter
Date: Wed,  4 Feb 2026 23:01:56 -0800
Message-ID: <20260205070208.186382-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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

