Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009429DB65
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836172; cv=none; b=kV33Z6FdCmXjxT58rcmefrIprVaBGH/64FtrfZG99oBfN1SncTFTnVyXokkgL7WAWTgi5o+jBscYpPXD/+bGiiaARhgeZgzdYTzXXD1L0Hz8n+fjgGSvZvafrD/aQEUOala3ZadjYixW3FrBrwSdSb0IFgTkAkUwLglugkmpcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836172; c=relaxed/simple;
	bh=+VqL2Tt3DZfEzJCZumYRh3TB8bCtCTtoeuVGc7k8YZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RReQnpaQU3ndn/yGRDJfIqpcJYLuD9o3jxO18s4N4J+FV2uPUQZgxdQ8j6S1Jd54XdffplQUdcG0na0wR1lkmco7QqCBIxZRprU9GBp5Ash8PCsu1jMAgaIROrt4V0eDSligDj2QDi+Km9ui29YGTGvVobvWO3ZTYWHz09NwDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEtGHPhu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEtGHPhu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7786d7895so20060315ad.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836170; x=1770440970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=NEtGHPhu+x1E4FBD2gMr1V9K1CUzNRIjjjaCQBllzghhIiBy1Ou2ayAudO3iGH8S/G
         cSwYhnZlVlvVTkow2p5n1pwUWSbs4mFt/9COu+PCTPtIc5o3ettrUzE3lAIcgtZ7NnGD
         i6JNVxR42xL25lXnJLWcjv3/45K24QO9ZfQd9eeTakOfShDQi2oeWoNPqNQTNQFjZ04a
         aIraxuknyKO6xgBR+OQDp/dWx7mdSwpZukr9+8MnbtsGXSAru66Xcwb9KyuILMJONTJ+
         CS7q64W82wDPXvzG2smbhMhbZoVCBnFm7Mk/7PNxvAbHKRVXDVRAlam167X5Arozg8dw
         Iq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836170; x=1770440970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=QWlSPdQpLdfcXzpnpXyHM/xjQnbYMk7xLUAyjBPpfXoL+dRtcP5zFJudmqgF3qonfJ
         itYIymgrnXN2gvwg5OZZAKeV27q8dzXi+oJXKb7lgOrsungV8LqZsKo7rEsLffYkaBno
         UmgJEngEziiR8IrroEgaJXcxo4tztHRRZ30Bs6VjN75XNbOkk5UnRo9jS+V3iKocJdMQ
         nEPvzAgfyaTQH2qTaJWWmNUEVTJANuvEJI3tvQsCXLizX8Gb7UQh9xjtv8k9gN5Oe9Kt
         Hz/qmDqqry6jS27e8Gi8w/jcZgFZrBRGvUYiVlVT0NpN8jrRzVbGeZ3kjaqaH4/+2jnp
         VeqQ==
X-Gm-Message-State: AOJu0Yxl1id6RlI7RN/6KhfYn4anWn4jjZHgEK9LgPLQWwQhqFLXU0lc
	uLjP+t2lRcwkb4rVaeRqXUyuYIYr/K2vSekOZyFY0BNo6d0QVwb8Dd/YKuhzlg==
X-Gm-Gg: AZuq6aKkVUiDDgJCcrp9PcT8bQDuammrxO3u8/81D2ANnw1thi45VqFk4p+Jb2wkUyh
	INUgvQkWdg8yqzSx0RnhPcRXKN5Y2GkHYB3XtwY/joFUeCtAEbZMPXI50eOA7xFMv7/Pp5vyrfA
	NFs5zzL/is78PiWNxTtXv298NywBstzcmOZBeepuuvD9//7HrqSxQwyT3QBgGma/++Zgqy8gfsa
	JRNGhL0ETTGcqEfD9H7u/iGIvCXoq7TNSSstywrG21gSBG6okcK0LJRnVVsSNpUjdZ7ZupixtJe
	YAy+y19nclmZsH2EEdILPFZ27+meLgON7EOsjARFJpDFUSYmlG3BL0T6xA1YVu5BLC8ffyGTxJV
	DQArSoSUkeL7HIM55tSDl20uo1CC3KnJF5WqHM0pmNI78mh0gTooSj7i1q4URVvSBsNfD/cZWBk
	RlWw==
X-Received: by 2002:a17:902:e88a:b0:2a7:a9b8:ebae with SMTP id d9443c01a7336-2a8d99531eemr49478515ad.58.1769836170341;
        Fri, 30 Jan 2026 21:09:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a7bsm89219475ad.79.2026.01.30.21.09.29
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
Subject: [PATCH bpf-next v4 07/16] bpf: Remove cgroup local storage percpu counter
Date: Fri, 30 Jan 2026 21:09:10 -0800
Message-ID: <20260131050920.2574084-8-ameryhung@gmail.com>
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

