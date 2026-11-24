Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500249;
	b=2K8gvfV5fZN0dXkGA3dCgSsOvUeGQh/3FYNr2CgXaiCpMEqY/m4gQoSuXWfrbeU8AoOR
	 0fDrsga+zaHdoBbkDnukXsKxoHrQOYTxTtLzQDFxbdnrqLsQ8NlyjoSucb4JJhFh55CJu
	 43qFQJrSY5cPj7E8mjeOIPa6OchuS0CxsL/e0ZnQIgnleZuE0PG3PtXQt8ZhOembDiU5p
	 r+6Lj35WrmF/XlX1JXbAkWpxRYPc0x96C5g/af3vuCgtK0cmosV3+3oVSHZeM+TwkRHWi
	 /6yttABCokPWMvjXeaXG7ms3xpcqbbHe4Lj5vJAxSzq6tnE8HV3yLAdICkFm3/EBVdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YXyEYISBsdF8P95U7v4N9WEHaaXU0reUiPvTUsQRX54=;
	b=ZiAUT52xJeDAEVzJ1tU30Bmxo+rKUKBXfwppnouph5WE8i7uUFcIcsJCbbrtP25g33Jz
	 xlBQGThtQajlGvAMHBi4p7Noz1Pkvcj3ZZ9gqVxAP/xMpOLUDMSoWL5Wt6ImDCZN1P8uw
	 nlgL1nvA5A3bLyNSw5d7dqu22Yd/0GdOUECQO9FJrMb4Bb3AbTrdSFFkbZVKoQL/kJtE9
	 sjdbcJAQyKAQmmAE3t1tIYi6J3a27sSGcvXgXHwHPfq4uuIaifdR+aqy6dpY6le5Sy+NU
	 yBsgCU8bjvKmShOlqkBFJNTXc3SKf1gq69VjhoKqWkfPJ9r9NCDaOSH7jXFeU/Is3EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=ErBor5Ss;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03860606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03860606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=ErBor5Ss
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0426a65e0so26589355ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1795500248; x=1796105048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXyEYISBsdF8P95U7v4N9WEHaaXU0reUiPvTUsQRX54=;
        b=ErBor5SsJBe4oWkYN88hePftosjMTDBR+zy3rRVaiNeLJ+AszFNbzbiuKGuK3aIjcx
         4v6Gp6o1Rv29X3dF8KGshKwqZK7NKFbXpV8W0WTdo01ptCXRjUddAjqsJ6BNZD25RgOe
         A1xiwaClKComrnsqTbnXMRmP6TW70jcejKpUrijnRS65VO+/Hiiaut5/btV2mtEKTNwV
         KCud5Pzrw0GnQHOKzJ+fQcRGlxqcSQF0tT+71Dw2y1qz1LpY+iMPyJHFQm70PEENnwmq
         mFlN5jYT5mb7fOSvDVbvNOsq2lyY/aDQj2kBdquerzbHzL4v+PSerxFf8a3+m3Xt6/La
         bGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500248; x=1796105048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXyEYISBsdF8P95U7v4N9WEHaaXU0reUiPvTUsQRX54=;
        b=RltD7v4BKufRQZbBkDuOAHrwjwalvgteNCTYTVOMWN3O+bOYy5mN5lkOgWK3tbTd/5
         6VCYO2uXx32kEGvFm+QuGxHplPlNUIqCWnUpy6rWIgiCmJ+e9VH3dxcmJ4zfFScLvrdm
         XEzmBaU8K7Meq86Is5egPwUAViOUu905qwy2I2Lc95wjcs25mJx/PhQDmrX5Ss+sUn7P
         WGvUQ+Rsi3istkYFij54czjlxZ3I6wv2IVBicvXZTb+i+rxjZrQtcdILgsoUJWbi2hL+
         VPyONAMk5vc1qKnsbWxyfa15VSHxy9xkTo2+3VHxT0KrhqrHkpZTizpeHdCWEAvkI0pu
         RVtA==
X-Gm-Message-State: APuU4Z/iS2gUuo2jW9WMxmY9hStzc3Ll9EH2PFdNFUyh348dmclERq2m
	lvCI0Im55POm2K3gdwwg4jmFHcUlKqTiGdTfgoPkluzCxR2FWYFocTT4ttAwsh8tCo41KRPa/TG
	DTFwp98g=
X-Gm-Gg: AZFdTZdcarJVohTqonq2NThKIoMbsRrLOYuLCoD2kGJN4Brxt1PFPdK7O0Y5w4SCq7/
	vif1X5UmKzX/p8x2sqk4gLIDfiiMzUKjmWhZGR6FMtW9/tk277GOrJjkhQ1zo6qatvGEG5lljLP
	pT5I2Z6AHRF2c0cVWcqByL4HV94uorAMsNsUdRHd2z3Zx/U9CWVgUalMFiNc0FIuWMyWAyU96TC
	Yhticrb9Aqp4+Pv1Nt+Bfpq9jU7FqbSJz05O5Y6nLeTNSindVNy6DgpoGZFqpnK0uofV7hYbK6n
	GkV362fwZ162QMMgReQL9P7HZlNlz4+U4WrxVpMEmYS1LKwJrDJynsZhHR4lbJdcaTKmQqQsw2s
	u1EgtQ7Nq694wnu/AkCJA2eSVXYsD11moupESdKBCvgQCFtZXRYspDBmAYLTbbpxRsZRJsa4X/2
	k8EU/CVw9HcXws9UTTSN5RyRN0ft4i6W9bm8SQpytcrCfo/4GhPOMcn1z+FVPbAj7OEtFHUYHG7
	HG8aQ4+mKAmnbVxbUf9Do+M2/qu3PJSCmgdkg0A79PRK+76jdRv6dXrU2RNuAQ+UqSFmnEcywiU
	4uHc8XqkzPxCVvURyfeNnVKIU8zNC4tAE8n7ExgN+XfdXtVkPp0Dhs/h/qVE5jgMXRHpA6Pw05L
	6aTVKSzTX2dXM3Nzp0Gg/9IuZSvs=
X-Received: by 2002:a17:902:f708:b0:2ef:fb5c:36d8 with SMTP id d9443c01a7336-2f03f2020f5mr111854125ad.29.1795500248159;
        Mon, 23 Nov 2026 22:04:08 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42a6sm64215985ad.23.2026.11.23.22.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:04:07 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 2/4] bpf: Plumb local storage context
Date: Tue, 24 Nov 2026 06:03:55 +0000
Message-ID: <20261124060357.11700-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124060357.11700-1-emil@etsalapatis.com>
References: <20261124060357.11700-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Local-storage allocation lacks context about the calling program.
Pass the program through the hidden helper argument and share the
allocation path for new elements and storage containers.

Non-functional change, will be used to decide whether context
allocation should be sleepable.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_local_storage.h |  3 +-
 kernel/bpf/bpf_cgrp_storage.c     |  9 +++---
 kernel/bpf/bpf_inode_storage.c    |  9 +++---
 kernel/bpf/bpf_local_storage.c    | 47 +++++++++++++++++++++++--------
 kernel/bpf/bpf_task_storage.c     |  9 +++---
 net/core/bpf_sk_storage.c         | 17 ++++++-----
 6 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6c643ac510799..28f6ffbd75741 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -213,7 +213,8 @@ bpf_local_storage_alloc(void *owner,
 
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags, bool swap_uptrs);
+			 void *value, u64 map_flags, bool swap_uptrs,
+			 const struct bpf_prog_aux *aux);
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map);
 
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c76e9b0fabba8..8a6b38b51ea2f 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -76,7 +76,7 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 		return PTR_ERR(cgroup);
 
 	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
-					 value, map_flags, false);
+					 value, map_flags, false, NULL);
 	cgroup_put(cgroup);
 	return PTR_ERR_OR_ZERO(sdata);
 }
@@ -122,8 +122,8 @@ static void cgroup_storage_map_free(struct bpf_map *map)
 	bpf_local_storage_map_free(map, &cgroup_cache);
 }
 
-BPF_CALL_4(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
-	   void *, value, u64, flags)
+BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
+	   void *, value, u64, flags, struct bpf_prog_aux *, aux)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -142,7 +142,7 @@ BPF_CALL_4(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
-						 value, BPF_NOEXIST, false);
+						 value, BPF_NOEXIST, false, aux);
 
 out:
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
@@ -181,6 +181,7 @@ const struct bpf_func_proto bpf_cgrp_storage_get_proto = {
 	.arg2_btf_id	= &bpf_cgroup_btf_id[0],
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_PTR_TO_PROG_AUX,
 };
 
 const struct bpf_func_proto bpf_cgrp_storage_delete_proto = {
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index f9e81060c1f45..c979e841ec130 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -98,7 +98,7 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
-					 value, map_flags, false);
+					 value, map_flags, false, NULL);
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
@@ -122,8 +122,8 @@ static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 	return inode_storage_delete(file_inode(fd_file(f)), map);
 }
 
-BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
-	   void *, value, u64, flags)
+BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
+	   void *, value, u64, flags, struct bpf_prog_aux *, aux)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -149,7 +149,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
 		sdata = bpf_local_storage_update(
 			inode, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false);
+			BPF_NOEXIST, false, aux);
 		return IS_ERR(sdata) ? (unsigned long)NULL :
 					     (unsigned long)sdata->data;
 	}
@@ -221,6 +221,7 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
 	.arg2_btf_id	= &bpf_inode_storage_btf_ids[0],
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_PTR_TO_PROG_AUX,
 };
 
 const struct bpf_func_proto bpf_inode_storage_delete_proto = {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index bd79754a1e2fd..28eaee5c66ce8 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -66,16 +66,22 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 	return !hlist_unhashed(&selem->map_node);
 }
 
-struct bpf_local_storage_elem *
-bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool swap_uptrs)
+static void *bpf_local_storage_alloc_mem(struct bpf_local_storage_map *smap,
+					size_t size, bool sleepable)
+{
+	return bpf_map_kmalloc_maylock(&smap->map, size, __GFP_ZERO);
+}
+
+static struct bpf_local_storage_elem *
+__bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
+		  void *value, bool swap_uptrs, bool sleepable)
 {
 	struct bpf_local_storage_elem *selem;
 
 	if (mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
-	selem = bpf_map_kmalloc_maylock(&smap->map, smap->elem_size, __GFP_ZERO);
+	selem = bpf_local_storage_alloc_mem(smap, smap->elem_size, sleepable);
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
@@ -95,6 +101,13 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
+struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
+		void *value, bool swap_uptrs)
+{
+	return __bpf_selem_alloc(smap, owner, value, swap_uptrs, false);
+}
+
 static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
@@ -497,9 +510,10 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
 	return 0;
 }
 
-int bpf_local_storage_alloc(void *owner,
-			    struct bpf_local_storage_map *smap,
-			    struct bpf_local_storage_elem *first_selem)
+static int __bpf_local_storage_alloc(void *owner,
+				     struct bpf_local_storage_map *smap,
+				     struct bpf_local_storage_elem *first_selem,
+				     bool sleepable)
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
@@ -511,7 +525,7 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	storage = bpf_map_kmalloc_maylock(&smap->map, sizeof(*storage), __GFP_ZERO);
+	storage = bpf_local_storage_alloc_mem(smap, sizeof(*storage), sleepable);
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
@@ -565,6 +579,13 @@ int bpf_local_storage_alloc(void *owner,
 	return err;
 }
 
+int bpf_local_storage_alloc(void *owner,
+			    struct bpf_local_storage_map *smap,
+			    struct bpf_local_storage_elem *first_selem)
+{
+	return __bpf_local_storage_alloc(owner, smap, first_selem, false);
+}
+
 /* sk cannot be going away because it is linking new elem
  * to sk->sk_bpf_storage. (i.e. sk->sk_refcnt cannot be 0).
  * Otherwise, it will become a leak (and other memory issues
@@ -572,10 +593,12 @@ int bpf_local_storage_alloc(void *owner,
  */
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags, bool swap_uptrs)
+			 void *value, u64 map_flags, bool swap_uptrs,
+			 const struct bpf_prog_aux *aux)
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
+	bool sleepable = false;
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map_bucket *b;
 	HLIST_HEAD(old_selem_free_list);
@@ -597,11 +620,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 
-		selem = bpf_selem_alloc(smap, owner, value, swap_uptrs);
+		selem = __bpf_selem_alloc(smap, owner, value, swap_uptrs, sleepable);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
-		err = bpf_local_storage_alloc(owner, smap, selem);
+		err = __bpf_local_storage_alloc(owner, smap, selem, sleepable);
 		if (err) {
 			bpf_selem_free(selem, true);
 			mem_uncharge(smap, owner, smap->elem_size);
@@ -631,7 +654,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	/* A lookup has just been done before and concluded a new selem is
 	 * needed. The chance of an unnecessary alloc is unlikely.
 	 */
-	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, swap_uptrs);
+	alloc_selem = selem = __bpf_selem_alloc(smap, owner, value, swap_uptrs, sleepable);
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 4b342be29eac7..b081e8799eef1 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -118,7 +118,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 
 	sdata = bpf_local_storage_update(
 		task, (struct bpf_local_storage_map *)map, value, map_flags,
-		true);
+		true, NULL);
 
 	err = PTR_ERR_OR_ZERO(sdata);
 out:
@@ -165,8 +165,8 @@ static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
-BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags)
+BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *, task,
+	   void *, value, u64, flags, struct bpf_prog_aux *, aux)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -183,7 +183,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE)) {
 		sdata = bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false);
+			BPF_NOEXIST, false, aux);
 		return IS_ERR(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 	}
 
@@ -244,6 +244,7 @@ const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
 	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type = ARG_ANYTHING,
+	.arg5_type = ARG_PTR_TO_PROG_AUX,
 };
 
 const struct bpf_func_proto bpf_task_storage_delete_proto = {
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1c59300af05c7..5a013b81d161a 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -106,7 +106,7 @@ static long bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	if (sock) {
 		sdata = bpf_local_storage_update(
 			sock->sk, (struct bpf_local_storage_map *)map, value,
-			map_flags, false);
+			map_flags, false, NULL);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -232,8 +232,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	return ret;
 }
 
-BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
-	   void *, value, u64, flags)
+BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags, struct bpf_prog_aux *, aux)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -254,7 +254,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
 		sdata = bpf_local_storage_update(
 			sk, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false);
+			BPF_NOEXIST, false, aux);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
@@ -341,6 +341,7 @@ const struct bpf_func_proto bpf_sk_storage_get_proto = {
 	.arg2_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_PTR_TO_PROG_AUX,
 };
 
 const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto = {
@@ -351,6 +352,7 @@ const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto = {
 	.arg2_type	= ARG_PTR_TO_CTX, /* context is 'struct sock' */
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_PTR_TO_PROG_AUX,
 };
 
 const struct bpf_func_proto bpf_sk_storage_delete_proto = {
@@ -387,14 +389,14 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 	return false;
 }
 
-BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
-	   void *, value, u64, flags)
+BPF_CALL_5(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags, struct bpf_prog_aux *, aux)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return (unsigned long)NULL;
 
-	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
+	return ____bpf_sk_storage_get(map, sk, value, flags, aux);
 }
 
 BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
@@ -416,6 +418,7 @@ const struct bpf_func_proto bpf_sk_storage_get_tracing_proto = {
 	.arg2_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_PTR_TO_PROG_AUX,
 	.allowed	= bpf_sk_storage_tracing_allowed,
 };
 
-- 
2.52.1

