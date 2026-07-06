Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB43ADBB4
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358366; cv=none; b=q3pAuLsfHncxj4vilMhI2AVckO8I2Qf0L/+fNwJH3Q4f/tf8cWci7iSgX7dRcK3xUDMjsvwGp2KdgestAT2Py5plKjFr2LOja38d5CDQX3yHmtDrnVcCdaKff2V5Y69l+eRxXQnk86Zf7hlzKcB54Jzb1a8WfhuzhIo0bBTJhok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358366; c=relaxed/simple;
	bh=2u9u9M0y/WP8pwtRIzdfcb4k3FrANEfZXFERXQR/BNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3tVz0lYshjzMTvwImu9hR0XiY9Kg5rACm5ceG/4ZB694iMKiwm5Y0y6VCIUy4XZ2GLlOTKo5J8NsmMlMP5yFcKFBzbdf5/ni6nVVTSgAD/rIjVACXeWqHSebisaP+JkzEomrhdBr6CUuowDv1S59MLsv0mhHMwhYH0KCmBgmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Rjya3f; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Rjya3f"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9f6b94a49so1840653a34.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358364; x=1783963164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwRyDDjkqydX4W22/IteivSWclQE9s95bjMvnW/tQ3M=;
        b=I2Rjya3fVwUZjQPsrxDJdACpSIDVVV/BCA0hGhPoCH9g3gJX9wFX/BpwqRuUSDtFAb
         1wa0DXVLMGO9cvKPrn4bCfPrZXVychDVpX95LQD1aF+eb/x5UYHQm2uyHSkDGoQzaMr7
         rVl6J8S9BBFF+Ou01kDfNPmNJmGXfBAuuBjJilNE6tLtvuPrfsXoeqaC8QqUNsFYAoBW
         XdB6rSfqjZ7hVRSnNc9osx9npbiDb16SzHG658H4teajjbwNujLILiK3lVXq9GD+6RwW
         WYhmTysDbkwNlyIplDIKmzUac7oZ4p+wrZj+nDLE70sAPVRM7hO7jkvotR2c6R2mpgnt
         18tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358364; x=1783963164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uwRyDDjkqydX4W22/IteivSWclQE9s95bjMvnW/tQ3M=;
        b=EJHAm/uvKA3KUFSBZBmiDer4u5a2F7hCTCd6ROVUyI14zXvzHAcFWfDdpjqqqUwinI
         Gj3Duzs+o51d6N4mqRPA60W7N1Cf5+t0vrHyZjrOL0XIwUlxhd/1CS1u0mG1Jc1kUUDl
         QQ1o/R6XRkqyiI4qhbHs6/PIYiIU50by2+nlqyJBavg30rVfTBtFaTtH/hMkOrRmmUP7
         j5/KDZ2WSLiHC3G1Dya+4uOM9ZG4fIxKQCGzVBJlK7x3F5NDzfj5hf6BI/lCRPVVwfu7
         mijpE3cmgicesNqQwSBJz5/zcZcdBiDyuDF698ZG6ot3mZXZVNuq2nO3ROfNOMR6RkYj
         E7tg==
X-Gm-Message-State: AOJu0YxQX6Anbw2nWSQKzRILKv6uZ0oK6+WvIyvBvR6mGtzUhSY1Vy74
	OuSm2RqHPzfeGNfweaPhwlok6haVfk2S9K/BnxWEDQP7KdVWdVPGFkKOteuMcA==
X-Gm-Gg: AfdE7cmtC32+v0v8CkYJn/lzqh+A1VhWAvJ+ExAUCdcEYvrfJhcA6SGwy5BtmdQiqmz
	Rw5Oy85SHhLkjz9xXeP+HSrpsymR101zIyISMd8MVce+0P2VUB5AWgKDlu57zpswNP1knTUoUe7
	ZsqkyS0zSYG7rQoSMme1LOv/eaVB1931tFkwDg4eBB88z1gA/fuQey2vwZcU+st40Pgm8SEnL72
	z8W7/iWlVjwNINGIrsnajOMGH0y6yVnFiJNRUsa4SC5FBgnuo/NCEiQ/++kSMOC/K+5pZJfAQoS
	0DUsEDbvRwp59Afsrz94uQZ7Xp3HYfxYrwf8KIIRr38ePzlNz0vIwMljRx/Ylt/SwDl9W61rxT2
	flOpRlnsYp6uFSooxG9Y37q2rreFeRNaO6ktTwfOzdFlAOzUd3V5bltQ6j0VEnEZamon6/oNzgN
	IwkSI=
X-Received: by 2002:a05:6830:660a:b0:7e9:e100:71df with SMTP id 46e09a7af769-7ebb23390edmr896567a34.17.1783358364229;
        Mon, 06 Jul 2026 10:19:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb55907dsm10414100fac.11.2026.07.06.10.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 01/15] bpf: Remove __rcu tagging in st_link->map
Date: Mon,  6 Jul 2026 10:19:03 -0700
Message-ID: <20260706171918.317102-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
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

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 51b16e5f5534..d06b3d9bcc13 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -57,7 +57,7 @@ struct bpf_struct_ops_map {
 
 struct bpf_struct_ops_link {
 	struct bpf_link link;
-	struct bpf_map __rcu *map;
+	struct bpf_map *map;
 	wait_queue_head_t wait_hup;
 };
 
@@ -1257,8 +1257,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	struct bpf_struct_ops_map *st_map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	st_map = (struct bpf_struct_ops_map *)
-		rcu_dereference_protected(st_link->map, true);
+	st_map = (struct bpf_struct_ops_map *)st_link->map;
 	if (st_map) {
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
@@ -1273,11 +1272,11 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
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
@@ -1287,11 +1286,11 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
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
 
@@ -1314,7 +1313,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 
 	mutex_lock(&update_mutex);
 
-	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	old_map = st_link->map;
 	if (!old_map) {
 		err = -ENOLINK;
 		goto err_out;
@@ -1336,7 +1335,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 
 	bpf_map_inc(new_map);
-	rcu_assign_pointer(st_link->map, new_map);
+	WRITE_ONCE(st_link->map, new_map);
 	bpf_map_put(old_map);
 
 err_out:
@@ -1353,7 +1352,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	mutex_lock(&update_mutex);
 
-	map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	map = st_link->map;
 	if (!map) {
 		mutex_unlock(&update_mutex);
 		return 0;
@@ -1362,7 +1361,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 
-	RCU_INIT_POINTER(st_link->map, NULL);
+	WRITE_ONCE(st_link->map, NULL);
 	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
 	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
 	 */
@@ -1382,7 +1381,7 @@ static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
 
 	poll_wait(file, &st_link->wait_hup, pts);
 
-	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
+	return READ_ONCE(st_link->map) ? 0 : EPOLLHUP;
 }
 
 static const struct bpf_link_ops bpf_struct_ops_map_lops = {
@@ -1438,7 +1437,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 		link = NULL;
 		goto err_out;
 	}
-	RCU_INIT_POINTER(link->map, map);
+	link->map = map;
 	mutex_unlock(&update_mutex);
 
 	return bpf_link_settle(&link_primer);
-- 
2.52.0

