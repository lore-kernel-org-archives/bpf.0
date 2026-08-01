Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3133911C1
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570400; cv=none; b=rje/DYB4f+/d1QmT7k9zBHCgCpD3eiXZ8PP7xKYSPNBJdRISukcW5DIkJZJpEaxRFC9MbrJpZt0B5Oj950jI1Qhesrh3qK6JWSL57ECRTfIortZuMdl6x1u4UkL0RKYCSjOMCt4KWSgX9SjrJCazHzpVVZoqOFz78I2zz7Y6u1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570400; c=relaxed/simple;
	bh=JsK2BL7j5qQj/lIODyVhf9zcndwLxyT+rs0E3GEIQb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDXf0EQgzbJtUwaK+jLHT9wI6rBh+GtdTgzbauIGFpf1p3aI3B1juSX0fivAz/W8boOj64N1V1bysOTyP6PjUkS327TN1tdi5Ae75YYMsths8Y5sVZDT3J5ml8vLgr+MaFGiEMParx0W8hkoqpMv8BZGH5wd89ZBbFoOGq0JumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2QAiusU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2QAiusU"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso1165375a12.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570399; x=1786175199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxbPdMQYo6DuIMuz5rnt/gP1Y+iDp0uCd1Lacak8p54=;
        b=h2QAiusUYyThDsLaYls1LSjCDODnpUw9D99tFw0TNErY+ykLpcqRpVqu7sMqhC8WVC
         Gu0nB+h+Y3wIwP+JgB4RppxaXGVfINWc/MoIVaFv5uq42bbqsJgd3zvFWmPaA1Ql5At8
         YxnNJgtYFEyhbwXqICe2VwHQXovYTziEpT83j7M1xF503rPMnf+S3jpK0XCRuvHdgJyt
         MjvW4OWS0avGQvF97Ub16GR4aalu0QjmUm1O7sFt3701n6lDBTVnfqik3n0YVnGxVz82
         7QXXd/OtcP+FTbIZXQDYfam/uQXOTxfZXX11AJkDXKRsrJPXQ7u10PlnJXHgJTy8cCVB
         Rj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570399; x=1786175199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxbPdMQYo6DuIMuz5rnt/gP1Y+iDp0uCd1Lacak8p54=;
        b=Nor4tsUDiCWk1pvhE9JLPXm12FUvQYFUohuAJFkaCiGkqEwDnFLFO1+2mUgngB69XZ
         8VczzePa0HSnt37zcI9tiNzE9BW6WP26iCzDk/o2f/xS3vTTpY0KL0CaEiSnQHTghTUr
         74iV1d0MPzTPl3QNX71qSzzj/alxpxTFZfWd5sKbrtesuPp0LCiXPWIctsg5IwsUOWQp
         LBYdm1EABJft8SOV2AyqTuDE/HwJ46MTqyEcjp7pZZfAdn41MRjz+KCOeJgevExMBJVm
         u9GMgMA9/iGT7SlLEDK+fvjnx5ETaOKQ6/KsFQsWVH5a2jepaEefx08KEpReqJOBHrfw
         PR/g==
X-Gm-Message-State: AOJu0Yyr9p6GPwC11iFO4ZPj6ypzfHE+LMu/uA9E8NHCKosCQHxgH5qR
	kWKpgiPZeXzLxUrzK3lyav1R31dh2fs60S+ME7Bik1mK3dbNUBwexAqDf4vTVA==
X-Gm-Gg: AR+sD12yacNVFw1QMFKmA4Tlmj/8YyVZTmyR0zHUThqZvigINp491WBU6AwAmHzz5Vx
	jT7tsepNLkrhNx6KDBDeW9KK7cHvq6jP88y82/m58NIgeK4z/sRg1lAgeZzZhxvDoaDETxLqDFa
	amtyjPuXx/5lsR5s2lQL7+uaZFqd460lnx7WiVk8QmtXNeENTiQMineoQzb2pQv0miQzv/Dwq8i
	hnT6mH5JlqlhDN+Vu5Tpbu66TRyjoG4Km0wHR/K1booJA25CwQj5lBD3Da941IkDDTdXYK2q++6
	exPrHSCrVbIk+sfVR+4gqSEOTgBNancwbdhQVFCTw4W0PSpzXgQjWczGwDUwPlweE7h3DPazaUw
	BrVC3y7NZKqyLY0NNluKiWir7TE9p/a8UbwocSw8PuXmGz7kA0to7sbJNZM9irzJLY0p+cBK9Eo
	CRGUTm9/KAmeXDQl9NjYrCb30ZvKiEsSLBfL6i+NxOFiyWXnxK8V+R/Vswjjqht3o=
X-Received: by 2002:a05:6a20:729d:b0:3bf:d1f9:b1df with SMTP id adf61e73a8af0-3c92a8ff1f9mr2673679637.54.1785570398676;
        Sat, 01 Aug 2026 00:46:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd31639sm1429037b3a.9.2026.08.01.00.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:37 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 02/18] bpf: Unify const map ptr argument checking for helpers and kfuncs
Date: Sat,  1 Aug 2026 00:46:17 -0700
Message-ID: <20260801074633.1595644-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
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

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 97 ++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 53 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c1257f7e8d43..cbc727cc84e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8274,6 +8274,44 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 
 static bool can_elide_value_nullness(const struct bpf_map *map);
 
+static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			       argno_t argno, struct bpf_call_arg_meta *meta)
+{
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
+		argno_t obj_argno = argno_from_reg(reg_from_argno(argno) - 1);
+		struct btf_record *rec = meta->map.ptr->record;
+		const char *obj_name = "workqueue";
+
+		if (rec->timer_off >= 0)
+			obj_name = "timer";
+		else if (rec->task_work_off >= 0)
+			obj_name = "bpf_task_work";
+
+		verbose(env, "%s pointer in %s map_uid=%d ",
+			obj_name, reg_arg_name(env, obj_argno), meta->map.uid);
+		verbose(env, "doesn't match map pointer in %s map_uid=%d\n",
+			reg_arg_name(env, argno), reg->map_uid);
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
@@ -8349,29 +8387,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -12123,36 +12141,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

