Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487A361DC3
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105026; cv=none; b=aOKig28KitxIGtQlxuHJfzDRpbS9CYkkk64dmfOP437RPky+XTDZpqp/aO+nejkD2sG3RbWP3Ba+W1MUViS1+Ifo5YlxCk6VWUaNK9fTdQ8fLU2HSUlNdlH4K9lLLHtBzHLzO3QnPIqhtcLDKSITvRgnIemAJRP4NVflqShJYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105026; c=relaxed/simple;
	bh=ZMC06OvUjrky7+hFivvF4jPgav/bmWLaXr24aq13RlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oI/7+UX83onSBZgnDUbotiCknlaBuLSnwzWxRLMqY7Jinhzcg25Ro20tf1q2BX4Z9J4XtMKGvvZvr1G8ILsv6fznPvVur1lutMJaGU7Hb6M4arAPnWISfG5ixsUxDFdIDovbywhFeF6nY0wxUvsln+79gNA5Pw9zWN1IWgEROeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt7FX/U3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt7FX/U3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432755545fcso966206f8f.1
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105020; x=1769709820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwsOyD8U5PPeNpfOGRUmm74I2EB4pl7dmu7ipT5un3A=;
        b=Rt7FX/U3GTJNl0s7eLQK5oM9/Gr8N+hG6AxF+9sWiwYTlLvbbVLsf5JUbFca5nG5ej
         fAnGWYDswtDjPOPD+7YMb7vHcvKbfKah/GRKGUjdyb0upbnUunbk77YSx9YB+TJDAPtf
         kz/sPaSiy3z4Hom+SBJ4u6aMiIZMLl4O3DjAFaj5ERbm3L4i67TNIv5G3FgxlzxyMSsJ
         p5hUX61EYx7cgan1KcsK8skXHem091DIjqhQvU9GAEmIi+6CwXmb8AuE+NljLGUG7qj+
         Fb3TgS4MwEhCDX7Yuvii15Bf2CbHFN6pIAPejysPse6TF5L6qfRjwz+vLou+OmuItzUT
         4XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105020; x=1769709820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fwsOyD8U5PPeNpfOGRUmm74I2EB4pl7dmu7ipT5un3A=;
        b=HBaz2/RuW1UD68ji67UwYXweUMTfQsAHLFudouV6Rg6oM6iub0/DkAquLE6TiSACfg
         cWrh2yq89et5SkFqWg4GKPiIU3EN2QAHw8bwPQnS/Fin2Bzs8hUmpfrxSXb7C2NQIDbz
         jDpx7c/qVwML0zkXgs4nljgXj8HiUFgKUpZa5Wp1WoLh25Uw2JN/ZQhzMh5t5QnYzr1g
         47vIFNLxrPu9yoAAJgBx8TafSPhzzKpUvs3ESbtGqAPLjBAt4V0jKQ9RKMnUXlnuf3sw
         pCZ+Bgb3gpj/Y8ZIVkT3A1lrXqWPp5/6DYgo9pLnOP0Ucq2lGCb989Gk5oriD//M1r9q
         twrQ==
X-Gm-Message-State: AOJu0Ywg62XPWpCcDgZ3cW6cbneQ3+BDCfFpmblJte6nZYCr0jVKzcuC
	K+LSqQxZnf+fFJg/7Eqi5rMeQxOBucegj0NuiFgSPXpPSAl4hNx7JItN
X-Gm-Gg: AZuq6aKVJHxvcGtmXQNN/sv0uA7SM4e5mQmK5MNKiAR6cQITAEIanLrUgxB/Lu+84wi
	4MEDyOWQNzZH6TuYs6eVo0q73alZw2A8gnT7DxdisZi+ws7XI+bEcXsQ9orgT9KbAFvDDTOc9u0
	Ib3rainKTQ9PmknyYM3l6UNbBwTN7KwsnTQUvHEnwX9wRuVbM2fKonLJcQIgamEJRvIpB4PRRAV
	n04eqtkBp+FryA3cRsUdm0Ld6ECfOfRwcqhxzW/3P8SxtTAaCV8IbLTqWoTTpZ+tUjuv7BUb3En
	A3Fj2Ws9rTudh8HvqDRlKYn6jDRIvo0gKBLvYj7N0NEWI/T+apm/bpUZZvh049Ms5q0B9wFN4S+
	MoK8VtZ+Yuvz9/dNmlCSBPV+ZmnV3fMQwDKqdITVrsM+wgqLsBurEt5PWgHYU+CywvZAy/I7iYV
	sleUoAaytvd0+p
X-Received: by 2002:a5d:5d02:0:b0:435:a370:2d71 with SMTP id ffacd0b85a97d-435b15fb1dcmr655528f8f.33.1769105019491;
        Thu, 22 Jan 2026 10:03:39 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24bedsm370177f8f.17.2026.01.22.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:38 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Jan 2026 18:03:15 +0000
Subject: [PATCH bpf-next v7 2/8] bpf: Add verifier support for bpf_timer
 argument in kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-timer_nolock-v7-2-04a45c55c2e2@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105012; l=5667;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=WzrWmXmO/eNcY0H7M1SqcOqAKweEAxNCUEXeRoQo1LE=;
 b=Qbuu77piZ+TEbmfSd7uoaMHZ0kBV4MBJT3DjM0FnTqIBiQEabKu4XOtMolDaiko9EJyTfQWFr
 9f02fqbS1MhDm+QoJyxAdXzcjfWP8FLUTDvxOqAcwzi7ptj60hnXLlw
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend the verifier to recognize struct bpf_timer as a valid kfunc
argument type. Previously, bpf_timer was only supported in BPF helpers.

This prepares for adding timer-related kfuncs in subsequent patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 75 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9905ad40f4d365c4b393106f52c617b1e0d0fcf3..179b1bd1b34ff53af7206ec62188bb14e6d0d321 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8656,17 +8656,15 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 }
 
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+			      struct bpf_map *map)
 {
-	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_map *map = reg->map_ptr;
 	int err;
 
 	err = check_map_field_pointer(env, regno, BPF_TIMER);
 	if (err)
 		return err;
 
-	if (meta->map_ptr) {
+	if (map) {
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
@@ -8674,8 +8672,36 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
+	return 0;
+}
+
+static int process_timer_helper(struct bpf_verifier_env *env, int regno,
+				struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	int err;
+
+	err = process_timer_func(env, regno, meta->map_ptr);
+	if (err)
+		return err;
+
 	meta->map_uid = reg->map_uid;
-	meta->map_ptr = map;
+	meta->map_ptr = reg->map_ptr;
+	return 0;
+}
+
+static int process_timer_kfunc(struct bpf_verifier_env *env, int regno,
+			       struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	int err;
+
+	err = process_timer_func(env, regno, meta->map.ptr);
+	if (err)
+		return err;
+
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = reg->map_ptr;
 	return 0;
 }
 
@@ -10003,7 +10029,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err = process_timer_func(env, regno, meta);
+		err = process_timer_helper(env, regno, meta);
 		if (err)
 			return err;
 		break;
@@ -12268,7 +12294,8 @@ enum {
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
-	KF_ARG_PROG_AUX_ID
+	KF_ARG_PROG_AUX_ID,
+	KF_ARG_TIMER_ID
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12281,6 +12308,7 @@ BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
 BTF_ID(struct, bpf_prog_aux)
+BTF_ID(struct, bpf_timer)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12324,6 +12352,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
 }
 
+static bool is_kfunc_arg_timer(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER_ID);
+}
+
 static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
 {
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_WORKQUEUE_ID);
@@ -12423,6 +12456,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
+	KF_ARG_PTR_TO_TIMER,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
@@ -12668,6 +12702,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TIMER;
+
 	if (is_kfunc_arg_task_work(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_TASK_WORK;
 
@@ -13454,6 +13491,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_TIMER:
 		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
@@ -13753,6 +13791,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_TIMER:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				return -EINVAL;
+			}
+			ret = process_timer_kfunc(env, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_TASK_WORK:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
@@ -21331,20 +21378,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
-	if (btf_record_has_field(map->record, BPF_TIMER)) {
-		if (is_tracing_prog_type(prog_type)) {
-			verbose(env, "tracing progs cannot use bpf_timer yet\n");
-			return -EINVAL;
-		}
-	}
-
-	if (btf_record_has_field(map->record, BPF_WORKQUEUE)) {
-		if (is_tracing_prog_type(prog_type)) {
-			verbose(env, "tracing progs cannot use bpf_wq yet\n");
-			return -EINVAL;
-		}
-	}
-
 	if ((bpf_prog_is_offloaded(prog->aux) || bpf_map_is_offloaded(map)) &&
 	    !bpf_offload_prog_map_match(prog, map)) {
 		verbose(env, "offload device mismatch between prog and map\n");

-- 
2.52.0

