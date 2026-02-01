Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7164284693
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968262; cv=none; b=ddD1gPgehCWv6Ztpt7MwhgzMJnCeJO+zYlBU8C9sz45EdIlyzET1YstE06UjeXn6ehfrnddZM4kOuslJSP6jZ5GbbSmWi69cD9++ceJ5EeXqg2cGCGak8w1DOdzZPQN2ONISzVU28qEQA7Mr4HThUiEiZ9uvvlwI7Ibo0wT9WM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968262; c=relaxed/simple;
	bh=+VqL2Tt3DZfEzJCZumYRh3TB8bCtCTtoeuVGc7k8YZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvHvSelgFQkzt7NjyLN/RM1SfXTypd9z55IxNUUVYrmLFZIAj28vTa7hC0vo0/y1mNxovxIkSV6TawIfD7L9GdcZnOMWk8bfS1fIziAZq0mpFG274pe8HxqdFbQ5eXfwm7ucNmEU2fuBvhdHNL7tTOnwIzDa+z9HfxyI9LpoNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPDN4FXV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPDN4FXV"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-823075fed75so2267835b3a.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968260; x=1770573060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=MPDN4FXVw0BlCemoD6xZOflQEr+RjeG3DbjMwz4xEka1OjCNygdY5JjHyopV9vPJGp
         Eb2k8tvapW6C3iwPAh75sw5JdNwmhhhJxJJPEA2C5IAeZYiYMa4m/IVjeF/U9dvYQpyJ
         SvlLKRzTxS/UE2P7XUPHSGuqI1RYFk4kA7rmJScAiNZFcC41wdA9Y0QvdLSOGqXhTa2E
         da67CSriyZHRB8i9lw21vX/HkOZC1JRNyQS462NtXOz3lEfmvXTuTa6jNgIVAznlo2xE
         olnb4geSuxhh8tu6lrqePK6+WoLdUHyFOFraBnruHdeI2dsxJM20NJn5ZJkq8vav6XfU
         ZNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968260; x=1770573060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=pJYePkUqa/ihUgp1W3N6k2k5epizkIn07ssNEYqnSFpA3p+Qm8WLjkNMuv+/tveHnd
         jxsTIhIp22btdk1EyN+hK8F7BEHfXYoVVqPzcsTnxw7qvWNi0+Tz58F/QwK2Ffa6aHOX
         4J9ORwG8c1D2YhL1Sux9ZyXhWhgD2xnzE5Zz6mqvLvhktyvEZcKMDGQfGFijocf+vph1
         yqgz7nAnc9VQxtxjf4T3iQP7L3J/XhNbwT+XNLSmiJJq8dKeRfPV+ODFtk/qZmxPUhx0
         p8FsS748lSHGDdia/WqMioMFoi8OzG4vRCxhtKIfywCaQ7bRx+jhjPMv5v5eZQCMZlP9
         SP9w==
X-Gm-Message-State: AOJu0YwwdDIUJ7EY7bRTCP2mnyQYWQ22Wfbv2sPCbomoYnC/l3G+XtF+
	ULH+uIHXWkhFAA73BPSCsHI9Mq+wd2F4ZIph/4qI3DdRb3GqsjOfZTrwG/QCmw==
X-Gm-Gg: AZuq6aJr18Bl3qrW84/jKd0SSvpK8eYZI+wEQ/eQ1tQ4BEMtGg/fdopo3zD0oZQvCxm
	LDhcsR6B0zh9RVfwJpvRzZ/TjihNlZv0+77+cE8m3IBLOErdml4bizTYuGXYIBNIHOGKEbGlGrd
	0bi2P1KZCjbwi7mOIUaiCF4uFs7FdTZ4Gj6XdRqolry29ZJ3DArMzONCoX0lXs3yELHKa0CUkUL
	CNnf9cDXGdmYCHRyNW1XRAYYmbdPlilqnQP6P66PdGsDGtoj9Sctrr1OaQEPZKrheICCt/ueX6Q
	mcIFuWpInsbkTj1QlX0kHLmSYW03Dd7YvzGtR3982/QjPSzqdKpJz+Ls/IZ/wm+8X+Ea+ftghtv
	A0DhSaPtjaRQIvnKoKaRAgaYWgGlin/KTSv5CZpILxwDFysO8/bZhREMKf6D+sCtxpUed5ldk0F
	6ZURakC2da0uLK
X-Received: by 2002:a05:6a20:7484:b0:37d:e26a:bff2 with SMTP id adf61e73a8af0-392cc6b24a7mr13520491637.20.1769968259946;
        Sun, 01 Feb 2026 09:50:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64276efbb7sm11517742a12.2.2026.02.01.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:50:59 -0800 (PST)
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
Subject: [PATCH bpf-next v5 07/16] bpf: Remove cgroup local storage percpu counter
Date: Sun,  1 Feb 2026 09:50:40 -0800
Message-ID: <20260201175050.468601-8-ameryhung@gmail.com>
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

