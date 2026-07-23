Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675141E7C18
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783292; cv=none; b=kAzn6L6Y3XKwWL9lKFDMb1rmY7gU8LAIQbexelciS5xhAwsONFbe70kgV2gy4GpFgMn59bw4YXTxbFZIKo0qppTRmow389XRmCcIKrK/u429gPzK9zptNTSSR/U2h3FH+2yWavt0px9IiAqYjRNd7Sk60pz1xAiGiHOu6I60t6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783292; c=relaxed/simple;
	bh=KerrcLLamwlbJApEYeZ2gLiOxh6SlLqHhenMoYGns8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqynGqpKQyVO/i6bLSBSlO7R5TydqBD3j2E16kyBRGaaD2GrwC17uFzIzkQaZDQLFohuX43R/wqAXYaJl5Dxm51MlTrOVnMlhud1wVuJbEHEZRF2WwDAxHv4UCcBQd3DHFXGr6lKkn2pZpMk6Q+0EkD/LkgM0FD2w3t462iPL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iat85rLU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iat85rLU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cace91f112so2891205ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783291; x=1785388091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oqj57u3QPmdKTrFTynY45yBhTZhNBDAEm/N4R7tvMyA=;
        b=iat85rLU1wO/RuVn4+0ld8TbZ7WFFEUkW/fzYEF7L79EWLJAtHWjAJMHuBmKJ1Hqoq
         2PTrLWLHhTJJR33oxlrnnAaDwXYNW5EAr4x0kPjzsA5lscqkAwAzM4cmOHNx157CWUnE
         DCIyVBH4pKb5Pax3gh+PehMFmyaPLfd8ozw58WBo3TINT6RNdxQ2xl5f5EVo8n09cubO
         ZPbyGxEYMNh5MTjOeoRUpjKQAYFYMR4nTzFY7GZNEi49cvNmdLjhIorRdFqlzcvND9LL
         yeKr0B4IRAz+KFJT5TutKNmup5BWpW8bw3OzCDizHO9rVzg7tXOrbMhkVhfWzweq2K10
         2sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783291; x=1785388091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oqj57u3QPmdKTrFTynY45yBhTZhNBDAEm/N4R7tvMyA=;
        b=XELJDIEK2JGhEb0/JDV2dWtUAFgarbUrY/rXGEZAD3i6z0ZWuka2Jrmg38NnsK0znt
         2OgC7UCuNRUcDoyObtmfUyCAc508qBRlKoZv6rFD1+Bt3gNhNK06/o0HGBD7UI0R3Yv/
         drrSzxrDmx4b6LfcfWR1h84WrugvaEwP1PACr6S2GkHEiYiHSA3L1ARJGFHAy8V4VPH1
         a5BArbpPRuIKUWu5LTq8Qr1vnyrlLzzQm/AbzGUZbOIJbFzGWy+fYR2VLEMYKI/WBQd8
         fUWv4bL+JNNDVNuMpRgskmF3wI+J+hxl0kVo+451R5/s0L445Deq+0/VwjpX+anNSmx4
         UlJg==
X-Gm-Message-State: AOJu0YzoJbBs87mWD0eJJky6UaYSIt8oqXz+ubtO85qM5PH4ipbEAy1l
	fFlUV+gHpAm8vC/jqwY6nSCWpeKxwDVAtTvViB6VosORkRbqQWOWbNND5Imtig==
X-Gm-Gg: AR+sD127uZXvFhj0Z5J2swwW1DaTxCl2kfW6gtVWs4CgPG5D4LdFAa94WQ3jMOTCmeJ
	dQMBRKIjVAzxRwuRcXyqI/8zJTx0BHvDH85TA2uMRJi2I67R7fA1YFsX8B7IwJaV+2QY9vdA5x+
	90o/FfsV886q7xrTP+ejdZ6jhoC8kgFDWxiCsjQ/qMe+0NFjjsfB79YsZJJRsnIjUvSowCH4nr4
	pSzoNlY6jZ/7P+F8af0tKZAB22qgRGUbRK89SG7zSKm9ogYAHZicdbJblyt6oxPrWDYGoZPyRUU
	57SCqCUAJPSj4P+tHXaNsXk0UtwWQJUSoPotu0MkXXegIkeMK/VPd4KsztczqE8zcVf9Xnpm0qf
	xo4t8/6JOZBX+ZXtzaGQW4BdqHpYLkF82RIsOZ96B0tHOvr/Khde9dLSyjy+jDVqDDqI=
X-Received: by 2002:a17:903:8c3:b0:2ca:bf68:2a54 with SMTP id d9443c01a7336-2cfa6c66729mr19911805ad.22.1784783290551;
        Wed, 22 Jul 2026 22:08:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f312c43sm26438825ad.56.2026.07.22.22.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:10 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/18] bpf: Unify const map ptr argument checking for helpers and kfuncs
Date: Wed, 22 Jul 2026 22:07:50 -0700
Message-ID: <20260723050806.1158442-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both the helper ARG_CONST_MAP_PTR and the kfunc KF_ARG_PTR_TO_MAP
recorded the map pointer in meta->map and, when a map was already
bound by a preceding timer/workqueue/task_work argument, rejected a
mismatching map.

Factor the logic into a single process_map_ptr_arg() used by both
paths. The bound-object name (timer, workqueue, or bpf_task_work) is
derived from the bound map's btf_record, and the register numbers in
the message are computed from the map argument position instead of
being hard-coded.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 103 ++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 53 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8c76abbf76a..bff51aff2557 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8274,6 +8274,50 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 
 static bool can_elide_value_nullness(const struct bpf_map *map);
 
+/* Record the bpf_map argument of a helper or kfunc call in meta->map.
+ *
+ * When meta->map is already set from an earlier argument (a timer, workqueue or
+ * task_work object that is bound to a map), reject a map pointer that does not
+ * match it. That object sits in the register right before the map argument, and
+ * its type is taken from the bound map's record for the diagnostic.
+ */
+static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			       argno_t argno, struct bpf_call_arg_meta *meta)
+{
+	int map_regno = reg_from_argno(argno);
+
+	/* Use map_uid (which is unique id of inner map) to reject:
+	 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
+	 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
+	 * if (inner_map1 && inner_map2) {
+	 *     timer = bpf_map_lookup_elem(inner_map1);
+	 *     if (timer)
+	 *         // mismatch would have been allowed
+	 *         bpf_timer_init(timer, inner_map2);
+	 * }
+	 *
+	 * Comparing map_ptr is enough to distinguish normal and outer maps.
+	 */
+	if (meta->map.ptr &&
+	    (meta->map.ptr != reg->map_ptr || meta->map.uid != reg->map_uid)) {
+		struct btf_record *rec = meta->map.ptr->record;
+		const char *obj_name = "workqueue";
+
+		if (rec->timer_off >= 0)
+			obj_name = "timer";
+		else if (rec->task_work_off >= 0)
+			obj_name = "bpf_task_work";
+
+		verbose(env, "%s pointer in R%d map_uid=%d doesn't match map pointer in R%d map_uid=%d\n",
+			obj_name, map_regno - 1, meta->map.uid, map_regno, reg->map_uid);
+		return -EINVAL;
+	}
+
+	meta->map.ptr = reg->map_ptr;
+	meta->map.uid = reg->map_uid;
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn,
@@ -8349,29 +8393,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	switch (base_type(arg_type)) {
 	case ARG_CONST_MAP_PTR:
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
-		if (meta->map.ptr) {
-			/* Use map_uid (which is unique id of inner map) to reject:
-			 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
-			 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
-			 * if (inner_map1 && inner_map2) {
-			 *     timer = bpf_map_lookup_elem(inner_map1);
-			 *     if (timer)
-			 *         // mismatch would have been allowed
-			 *         bpf_timer_init(timer, inner_map2);
-			 * }
-			 *
-			 * Comparing map_ptr is enough to distinguish normal and outer maps.
-			 */
-			if (meta->map.ptr != reg->map_ptr ||
-			    meta->map.uid != reg->map_uid) {
-				verbose(env,
-					"timer pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
-					meta->map.uid, reg->map_uid);
-				return -EINVAL;
-			}
-		}
-		meta->map.ptr = reg->map_ptr;
-		meta->map.uid = reg->map_uid;
+		err = process_map_ptr_arg(env, reg, argno, meta);
+		if (err)
+			return err;
 		break;
 	case ARG_PTR_TO_MAP_KEY:
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
@@ -12122,36 +12146,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (meta->map.ptr && (reg->map_ptr->record->wq_off >= 0 ||
-					      reg->map_ptr->record->task_work_off >= 0)) {
-				/* Use map_uid (which is unique id of inner map) to reject:
-				 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
-				 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
-				 * if (inner_map1 && inner_map2) {
-				 *     wq = bpf_map_lookup_elem(inner_map1);
-				 *     if (wq)
-				 *         // mismatch would have been allowed
-				 *         bpf_wq_init(wq, inner_map2);
-				 * }
-				 *
-				 * Comparing map_ptr is enough to distinguish normal and outer maps.
-				 */
-				if (meta->map.ptr != reg->map_ptr ||
-				    meta->map.uid != reg->map_uid) {
-					if (reg->map_ptr->record->task_work_off >= 0) {
-						verbose(env,
-							"bpf_task_work pointer in R2 map_uid=%d doesn't match map pointer in R3 map_uid=%d\n",
-							meta->map.uid, reg->map_uid);
-						return -EINVAL;
-					}
-					verbose(env,
-						"workqueue pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
-						meta->map.uid, reg->map_uid);
-					return -EINVAL;
-				}
-			}
-			meta->map.ptr = reg->map_ptr;
-			meta->map.uid = reg->map_uid;
+			ret = process_map_ptr_arg(env, reg, argno, meta);
+			if (ret < 0)
+				return ret;
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-- 
2.52.0

