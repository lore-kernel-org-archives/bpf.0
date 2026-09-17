Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15E3B14AD
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675550; cv=none; b=amfaToA9yr2j5BJgRIJ1xjAZSAkQbWmjzmnuG6aUadVTQnY1pweIhRj6UGa99vWr2sDjnN1uJj35DwrBxHPEEndCCbyRxTBQaWMpWoSgPpbSCuGfQHsSnAdYmmvH77ZhrUS0+gss+G5MDJd1qJ9DwDqlHOSqGAotNLAoTR70LFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675550; c=relaxed/simple;
	bh=W39CY3kr7fhFQFp6WTT9JBaYk3Lyvi6uHhqD3oR06Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvIwgFnCWk0DasurtotpbL3eHjVYOrn0QVZoBlSpEAOyJGq4b/Rp7T0DuRDWL7MABJ8qfbehOtQ6TzPrcICMSiija9XIDwE/trihvJC8kWr3hynJfLtWi9jiXkXhKDNCDhVKGqgD08ZwjUjbjPPM2JjWEMWVfHJYb6heMFpkqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hun232Hq; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hun232Hq"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4be07e7c54dso753020b6e.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675547; x=1790280347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kb6uLLxCu6ZFXQCzjeBwxStR3KfLsPw/bx7DX0YHZo=;
        b=hun232Hq8jXTn86hW2p/w/xm36r6Tbd+ZYXb9gAeGMzNHyj8qFylexD1vEyksMWxEW
         +/UyG9gti33tNE3Nr1BW9h8ni5svRssick9RmWSmIUiYWCQv4MgpRUhPkt6s46poHMXV
         uEJgol/MuMEZE7F+0tpwD9sGET9bIXST7+xArxkpBRdBOgoKlqhNhkPn2qe5cAzv1Dz7
         rXB7aRfsUXNPB9kkfOPIBZ8QrOUGkFjY3hvMG9X3g6LC9TuQZF1ZwJMKk1v2apkFYE3t
         mC+N9lVAVnLqkix0pbzTx75RAstUdwhObrgMglDbYoXTrWRsNPJN+MfqogMhBcLIWtTE
         kgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675547; x=1790280347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kb6uLLxCu6ZFXQCzjeBwxStR3KfLsPw/bx7DX0YHZo=;
        b=J8wGnrYi4Osu5+eYYk67og/KTYr4rXRRBxb85O3k6mCusInowQG16tLd0EHYKH1IUK
         5WymwU2d6651Tm66Tj/u+Ysmpl5w8ixuo9vj1vRuQumkAICBgYiOOeQEhao9MAxfdMUl
         sn+oNWd5VFROgN+GWvLXrj1mMUggbUnqBBNjiolc3oZnmYnFnJ/U1de4tVHwNI5gEvrX
         EwoQgt2WZSRG+5SOEUm/dljkxxn6WOMln8yA1eWJWrjINYPnhww7ab7b+1as9RXRWVlU
         YIxjkaAvcJ/YZN6rCCLpDxng1BcT0Ddcg7dQxFEZhSOOG+BzMB9kzXlUk2VWqhQIBTxh
         i+/w==
X-Gm-Message-State: AFuF++mrbjGadOYlyDZTMBs2HY3Zht6bccSCZ36LBMKHRhvfFPxfPgX6
	5VeSZXWgzK0Pb8G6DhIbHw4qq+NOKZsgwquj8mrojqbGVr7ywO2274eJ6bReew==
X-Gm-Gg: AYBFou22xcFdqRO51S8j2DynNb5oeBtDQormPaEeBp3bu8rLryNV2vxDmG8zrOB8d0+
	P1DM+Nj+s8yf27fp7nPsJjr3ppYsJuoUAcbFCloxjZl1VfvaY6ssup11dXnudgkq5ZUwwI7UwtC
	+lTKy8taf6oYtAnIQ9mavD6hTDxauT4U5bYFjCuiNm37v3j+O+2LiXvYzgrn9ybbV0LWGTMsNrn
	o9Qhh5TYem98PDz/vNkkAe7jRUNAxIvWHGHK19UD1+oLANKsdoRx6rJ0czpWkz2z2nAfA5K5EY9
	Ys4rCL9wsJoVRmltf6GNxwxp/TqDiSfoF0ulgug9f38IvI1Hb1ri5t8eec+8utPr+vOF7wE/Ky5
	QuFOUFR4P/BDIj3r/8sFNFb41g1kuYAa69UrcT+CcluCm0zgpmWQ91NjuvPPBHsPrmZgicwpgbi
	jbbrOU3UJWRi8EVpTyhH3coCDPLqGbeV9MJYaeHmQPOg7ax2dIrfwAS5fvES+kQg==
X-Received: by 2002:a05:6808:1705:b0:4af:aaca:7be3 with SMTP id 5614622812f47-4cb6870a38dmr3588023b6e.12.1789675545929;
        Thu, 17 Sep 2026 13:05:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb6a3d9bf9sm3550621b6e.1.2026.09.17.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:45 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 01/15] bpf: Remove __rcu tagging in st_link->map
Date: Thu, 17 Sep 2026 13:05:27 -0700
Message-ID: <20260917200542.3689605-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

st_link->map is always written under update_mutex. The paths that read
st_link->map with rcu_read_lock() are not in the fast path, so they can
simply take update_mutex instead. Remove the __rcu annotation and replace
all RCU accessors with direct pointer reads under update_mutex. Use
READ_ONCE() in bpf_struct_ops_map_link_poll() which reads the pointer
without holding update_mutex.

It is a simplification change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d7c3030bc63b..3935bf35a423 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -57,7 +57,7 @@ struct bpf_struct_ops_map {
 
 struct bpf_struct_ops_link {
 	struct bpf_link link;
-	struct bpf_map __rcu *map;
+	struct bpf_map *map;
 	wait_queue_head_t wait_hup;
 };
 
@@ -1297,8 +1297,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	struct bpf_struct_ops_map *st_map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	st_map = (struct bpf_struct_ops_map *)
-		rcu_dereference_protected(st_link->map, true);
+	st_map = (struct bpf_struct_ops_map *)st_link->map;
 	if (st_map) {
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
@@ -1313,11 +1312,11 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 	struct bpf_map *map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	rcu_read_lock();
-	map = rcu_dereference(st_link->map);
+	mutex_lock(&update_mutex);
+	map = st_link->map;
 	if (map)
 		seq_printf(seq, "map_id:\t%d\n", map->id);
-	rcu_read_unlock();
+	mutex_unlock(&update_mutex);
 }
 
 static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
@@ -1327,11 +1326,11 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_map *map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	rcu_read_lock();
-	map = rcu_dereference(st_link->map);
+	mutex_lock(&update_mutex);
+	map = st_link->map;
 	if (map)
 		info->struct_ops.map_id = map->id;
-	rcu_read_unlock();
+	mutex_unlock(&update_mutex);
 	return 0;
 }
 
@@ -1354,7 +1353,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 
 	mutex_lock(&update_mutex);
 
-	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	old_map = st_link->map;
 	if (!old_map) {
 		err = -ENOLINK;
 		goto err_out;
@@ -1376,7 +1375,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 
 	bpf_map_inc(new_map);
-	rcu_assign_pointer(st_link->map, new_map);
+	WRITE_ONCE(st_link->map, new_map);
 	bpf_map_put(old_map);
 
 err_out:
@@ -1393,7 +1392,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	mutex_lock(&update_mutex);
 
-	map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	map = st_link->map;
 	if (!map) {
 		mutex_unlock(&update_mutex);
 		return 0;
@@ -1402,7 +1401,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 
-	RCU_INIT_POINTER(st_link->map, NULL);
+	WRITE_ONCE(st_link->map, NULL);
 	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
 	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
 	 */
@@ -1422,7 +1421,7 @@ static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
 
 	poll_wait(file, &st_link->wait_hup, pts);
 
-	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
+	return READ_ONCE(st_link->map) ? 0 : EPOLLHUP;
 }
 
 static const struct bpf_link_ops bpf_struct_ops_map_lops = {
@@ -1478,7 +1477,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 		link = NULL;
 		goto err_out;
 	}
-	RCU_INIT_POINTER(link->map, map);
+	link->map = map;
 	mutex_unlock(&update_mutex);
 
 	return bpf_link_settle(&link_primer);
-- 
2.52.0

