Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9534E9C17
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675551; cv=none; b=HUJq+g/xZDyqWkeIdqt4u1HjszZP3wB9vSbqKQX2CTldthNqQEGXBLjYddi+CQDo1FNmazkBv8c9AWqQD8LyIo0hRis0ShWrTwQLBm+X4OyD8CEIF9OwC52sPKNgQozRPjo6ZT9vk+elBVXU7MbrBUV1o6W3lgEX5v0EiJ0w02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675551; c=relaxed/simple;
	bh=51ac+Vg1/cfjx/8XZ4g0wF5pv8rVZrwzTpqc6URdDJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkwVFFpfCOtqphVsIl+s+Ui/Q2x3UzVH3V+dE0/8Y/ytwP5Ay8Z3FzVTDCL7qcUQ4ijhPk9vsIPDld5KLlfaEjxJUWl+A4OILeyUfzJ0ZlE1RU+8jjJPTyTa0orHFH8cuhI0ySmKVshuylnFHyXf8xLvXkvtO4llBrsCx9VPF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXQSIanm; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXQSIanm"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-80a854e5b3cso653026a34.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675548; x=1790280348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QheH0cwJ4f6+zK5Im6E2DdV5SRCbfGfGNXI2nbs+6m4=;
        b=dXQSIanmT7hqoD7oul2NfuSivHKfTwcVpb74IagEXW1cJ2fh+XKkzwRGlub7iJPXlE
         VTN5kBQEohklNYVQQCUCuKZjliEq90YEwuHUaEn+EXVvJ9dh5TswspjWVrJ5FEgq57iU
         J3NF+l7MOtG29Bb1YT8HYlS0LpJUbg9fyc1o18ConRDHNCN/8BD93SAiVfcb3ZkIQ4Aa
         eQa5j8wIfSP+EbCQqmJjEjrYN0AgUb45OJ0H2Dzn4P4rmsLQB8l8iSc9lmU36XAbenOW
         tD3xNBN6xkl6RrhD4LxbnXLOzv04NsePjlNFtzuqU05x0diEtM/hN0WQcYbqgXNAs1zY
         6MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675548; x=1790280348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QheH0cwJ4f6+zK5Im6E2DdV5SRCbfGfGNXI2nbs+6m4=;
        b=Ial2OgRY5xZMB2LfsLq9fn24tP6XwM1qIuEHmawP3b8AAn9dKPhdSN0R0X2sd7FONN
         jr7E1q4VWVEnEOGbmnvGJPl1z14paWLFZJQ8h3Rp2z2aO3LHKau2YFmVgmAqJmSbVINH
         FVuKL6IqEOxmdzVKGMrYuDVh4wlX1ngzXp3BTcenQyyV3Ts3gdFkCEqjSw5U5gZ5u3BL
         ++FMHA1AwQZobp0nac8+5k/5EgzvQjDAl5Z57a06bTZ2c3Dz2+142fSU2yIGr61ObKwt
         8q21FA5VkhjwWOzWfxBsX78MGfD8Wy1CN/1crV+q8PoMXiv4aRrJhzS65E+V4GdOrNHY
         Pp0w==
X-Gm-Message-State: AFuF++kfeJkWNYG40d1xQhNJV67L5iqtQpmNmF7GN5Wlljr49QVfJK2D
	c4b2YJ9Ma+PtU6fztLmRzElSTtRh/E8MFKYDgQsY1TQW/tYe4shHe7b1rj2Tdw==
X-Gm-Gg: AYBFou0K82zad5MV+wtqk1HSySbn5kHE1BiyRFXYD9g6paocJgJDa+HL+PdkTjQ6YrV
	TmpDT1BueXzzK77fnTFu5b5lbFR/n7DOt78HbPPGR4IDS+ZalO8xwNy77qiu1ii6J0OM8E5mzd1
	VvOTeDTQHKnfLMfXurnzh0unt2diV10GD9J5T+3wtgN/tA2uJnfPbYud2xefg5qaPT33opL17Lt
	3vlQiymNkEOiB95goFB8vGhXY+FLoGlUAym4lTRJmvsBLUQCd3Da6cKkAukIVRId2pQhooDUaDo
	/A2zWBF2GJRUqzJLZjuIr/Bbl6EgXbjSIzPBXoqiNO9m/kP5ZuImNVc9+GvREFQgIBnk9QCqR9h
	gcHRUwNHFZtc0ZiZgBSmPCHToGdU4F62jxf9eombgcwyuHzXTE0fr3xT9MbQp0dlNgkmb018XTQ
	XnvC3c+G4gOh9Z+eOZqhn62QUml7XVY4CNqrIr+828pQYJfI2GICQzRWUZlbK+Fg==
X-Received: by 2002:a05:6830:2116:b0:80c:d30f:971 with SMTP id 46e09a7af769-80de199fae9mr252068a34.18.1789675547784;
        Thu, 17 Sep 2026 13:05:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c477cc3d3sm3957887a34.27.2026.09.17.13.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 02/15] bpf: Make struct_ops tasks_rcu grace period optional
Date: Thu, 17 Sep 2026 13:05:28 -0700
Message-ID: <20260917200542.3689605-3-ameryhung@gmail.com>
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

bpf_struct_ops_map_free() currently waits for both a regular RCU grace
period and a tasks RCU grace period for every struct_ops map through
synchronize_rcu_mult(call_rcu, call_rcu_tasks).

A regular RCU grace period is still required for all struct_ops maps
because the struct_ops trampoline ksyms requires a rcu grace period
(take a look at the list_del_rcu in __bpf_ksym_del).
Add a map_free_pre_rcu() callback so the struct_ops map can remove
ksyms before bpf_map_put() wait for the regular rcu grace period.

The tasks RCU grace period is only needed by tcp_congestion_ops.
Add free_after_tasks_rcu_gp only to struct bpf_struct_ops instead
of the bpf_map.

When CONFIG_TASKS_RCU=n, synchronize_rcu_tasks() is the same as
synchronize_rcu(). Since all struct_ops maps now complete a regular RCU
grace period before bpf_struct_ops_map_free() runs, skip the extra
synchronize_rcu_tasks() call in this case.

This cleanup prepares for a later patch that needs to support
free_after_mult_rcu_gp.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         |  7 +++++++
 kernel/bpf/bpf_struct_ops.c | 31 +++++++++++++------------------
 kernel/bpf/syscall.c        |  3 +++
 net/ipv4/bpf_tcp_ca.c       | 16 ++++++++++++++++
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2a5fa346aada..1198404885c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -90,6 +90,7 @@ struct bpf_map_ops {
 	struct bpf_map *(*map_alloc)(union bpf_attr *attr);
 	void (*map_release)(struct bpf_map *map, struct file *map_file);
 	void (*map_free)(struct bpf_map *map);
+	void (*map_free_pre_rcu)(struct bpf_map *map);
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
 	void (*map_release_uref)(struct bpf_map *map);
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
@@ -2131,6 +2132,11 @@ struct btf_member;
  *	   unloaded while in use.
  * @name: The name of the struct bpf_struct_ops object.
  * @func_models: Func models
+ * @free_after_tasks_rcu_gp: Set to true if it needs the bpf core to wait for
+ *                           a tasks_rcu gp before freeing the struct_ops map
+ *                           and its progs. It is unnecessary if the @unreg
+ *                           has waited for the correct rcu gp or the @unreg
+ *                           has ensured all struct_ops prog has finished running.
  */
 struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
@@ -2149,6 +2155,7 @@ struct bpf_struct_ops {
 	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
+	bool free_after_tasks_rcu_gp;
 };
 
 /* Every member of a struct_ops type has an instance even a member is not
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 3935bf35a423..7802859eac1e 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1024,9 +1024,18 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 	bpf_map_area_free(st_map);
 }
 
+static void bpf_struct_ops_map_free_pre_rcu(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
+	bpf_struct_ops_map_del_ksyms(st_map);
+}
+
 static void bpf_struct_ops_map_free(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	struct bpf_struct_ops *st_ops = st_map->st_ops_desc->st_ops;
+	bool tasks_rcu = st_ops->free_after_tasks_rcu_gp;
 
 	/* st_ops->owner was acquired during map_alloc to implicitly holds
 	 * the btf's refcnt. The acquire was only done when btf_is_module()
@@ -1037,24 +1046,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 
 	bpf_struct_ops_map_dissoc_progs(st_map);
 
-	bpf_struct_ops_map_del_ksyms(st_map);
-
-	/* The struct_ops's function may switch to another struct_ops.
-	 *
-	 * For example, bpf_tcp_cc_x->init() may switch to
-	 * another tcp_cc_y by calling
-	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
-	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
-	 * and its refcount may reach 0 which then free its
-	 * trampoline image while tcp_cc_x is still running.
-	 *
-	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
-	 * to finish. bpf-tcp-cc prog is non sleepable.
-	 * A rcu_tasks gp is to wait for the last few insn
-	 * in the tramopline image to finish before releasing
-	 * the trampoline image.
-	 */
-	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
+	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
+		synchronize_rcu_tasks();
 
 	__bpf_struct_ops_map_free(map);
 }
@@ -1163,6 +1156,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
+	map->free_after_rcu_gp = true;
 
 	return map;
 
@@ -1195,6 +1189,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
 	.map_alloc_check = bpf_struct_ops_map_alloc_check,
 	.map_alloc = bpf_struct_ops_map_alloc,
 	.map_free = bpf_struct_ops_map_free,
+	.map_free_pre_rcu = bpf_struct_ops_map_free_pre_rcu,
 	.map_get_next_key = bpf_struct_ops_map_get_next_key,
 	.map_lookup_elem = bpf_struct_ops_map_lookup_elem,
 	.map_delete_elem = bpf_struct_ops_map_delete_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index def57bddb092..01a1f1dd3b67 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -954,6 +954,9 @@ void bpf_map_put(struct bpf_map *map)
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map);
 
+		if (map->ops->map_free_pre_rcu)
+			map->ops->map_free_pre_rcu(map);
+
 		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
 		/* RCU tasks trace grace period implies RCU grace period. */
 		if (READ_ONCE(map->free_after_mult_rcu_gp))
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..e224ecafbd69 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -339,6 +339,22 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.validate = bpf_tcp_ca_validate,
 	.name = "tcp_congestion_ops",
 	.cfi_stubs = &__bpf_ops_tcp_congestion_ops,
+	/* The struct_ops's function may switch to another struct_ops.
+	 *
+	 * For example, bpf_tcp_cc_x->init() may switch to
+	 * another tcp_cc_y by calling
+	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
+	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
+	 * and its refcount may reach 0 which then free its
+	 * trampoline image while tcp_cc_x is still running.
+	 *
+	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
+	 * to finish. bpf-tcp-cc prog is non sleepable.
+	 * A rcu_tasks gp is to wait for the last few insn
+	 * in the tramopline image to finish before releasing
+	 * the trampoline image.
+	 */
+	.free_after_tasks_rcu_gp = true,
 	.owner = THIS_MODULE,
 };
 
-- 
2.52.0

