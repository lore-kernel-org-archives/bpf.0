Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D736EA85
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542311; cv=none; b=Iww/u3Tsr5pAabCvsjMUEPoZBuAs/ipu0rudx2Bq2y2QrDn3RC6OVgxRfxiOdLTf0mTI7KxIH1bB1PRyQkg46tF+AKq5LJzCxoF2//RDdcWzgeLjd2TGlu8X7XJjH+ePZVt1eI7efdJoCo7OktIG7O57ST7NR54/5gkzyx6Ru/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542311; c=relaxed/simple;
	bh=ZMC06OvUjrky7+hFivvF4jPgav/bmWLaXr24aq13RlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMIQXhLXP+KqxWsWH5FqogHaq3SR0DJ0TlhEO4iuStoWiFKKo3DIsqABZWu0jI0Ld66djb2k1w0gPsWXNfmWLyHpJ6Rp2DcanBjTXAovXaXn9b/Lt7zyNz4+2KH0oyxa4txF8n43YMIW8K52FcdbOGhZHZJB3WFrCPi1jhOHB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3QiblGq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3QiblGq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-480142406b3so41605515e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542308; x=1770147108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwsOyD8U5PPeNpfOGRUmm74I2EB4pl7dmu7ipT5un3A=;
        b=B3QiblGqxWHrLUAq92GNv5xWCXUv19OD0ByYexytPyHR+9oXmNu7+n3zuOmVsM7i3s
         qIaN6t7pCKTIBw6GUn07BPmU5hCkaYF4cHr04aWYzfX8z+MRp6ItCL0TFz1aiT73r1Un
         tohEsHCmTwmPXrncvMdIfBPXRmrpQkOrzKZf4p4/tr0+rIgOAiC+/ex0ZHZQov/i0I9e
         DSpDX79dbwE0ZWomOZUuUF3I3Vcn++xyAoQirEEfyAKHC5su7SDyWhXuPjynyLinIeld
         9BLMPBhDOT+B+2OL3ZToUAxhsRxvE6Ga84i5mlPEek88/L/MU/G2OV5BPjFthiA9xDat
         NSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542308; x=1770147108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fwsOyD8U5PPeNpfOGRUmm74I2EB4pl7dmu7ipT5un3A=;
        b=vH/etvBuGRC84UdBFUvMMXwEUKepFBQer7mNQG743O6S/Trmi40pR47n1qetA8wjNR
         N+HD1OCgNsBUJJfWpbmMT3/L7dNdvqhQEBHJdBqcPu0jXSWXFwuaeRssc5y/fLDF7N64
         Qd7CgCNQa4Izu6YGGb7ySPXVEqfHTAiZlTPV6AE6tZKRyjkIyn1eU2wSWFQWsQjdhrRt
         dVUBI8vaYpSxkpDHE0O7q6cN2Ns9XcIzDjUWpot2g+ywP95FZeiH+dgFnBJc6ahNF1mO
         f7tvLL6++05q58gM0f+7UiU+q/FQRkOZ0iWOiv6wucXfLR6pTqaCDNnE8nN4Pbbkov7D
         cQHw==
X-Gm-Message-State: AOJu0YzPM988oX3ksR1S//z6H9H5lyKkpoaUFV/0PzYvuJLtbys5B0+6
	LRKOYVgrcdZB8fxmhnNhaz+gZmu7qrpshAl13rq2i1my/6DTyv5MRRhvir56MTtE
X-Gm-Gg: AZuq6aJR//ni20G1NR9r9nSWLwWNr6c6rLNkap6bL35Js7p4guf3rnEsfxVOPtRjSWr
	F0wZx6eQM0VDcC3bMr3rhfIfIpfzYpez7katzlsXnsxXHqUQ+2e/3yxFhnqVAHCLlkSGd/MNL8/
	5fZ6u21lOw9TKdRdcnn5UHGpRbQ7O9s+FRcuKZKgb8vVCwDkxRMtpgRm/gKuvW4UXYEJgU37aF6
	QK6kU8SqqbYCk2LzpirDXp6ywRH/5mnQp464uZtyugWvjuKKR5Fx+ptoHQ/PgpvEJcyvlcPqM8I
	uQZRHtyKh62/ZQLZTJyM/4uhm/spGNA2g7B9PAlGhHfAbw77VOhFX+gh6RmTRB8rSwehvJhpWI7
	EFXMq6PffA/oOg5T9t1pZuWydXrY5Ph5Zv8g6jhHzHttmCzShk1gsNr2o349V0aEoipbdn86XvK
	JLmU/bGXl1j4Dcdenp0rS9GbeR0XqHaQ==
X-Received: by 2002:a05:600c:530e:b0:480:4d37:e742 with SMTP id 5b1f17b1804b1-48069c0deb8mr37814505e9.10.1769542308322;
        Tue, 27 Jan 2026 11:31:48 -0800 (PST)
Received: from localhost (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323034sm970789f8f.35.2026.01.27.11.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:31:47 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 27 Jan 2026 19:31:19 +0000
Subject: [PATCH bpf-next v8 2/8] bpf: Add verifier support for bpf_timer
 argument in kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-timer_nolock-v8-2-5a29a9571059@meta.com>
References: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
In-Reply-To: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542292; l=5667;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=WzrWmXmO/eNcY0H7M1SqcOqAKweEAxNCUEXeRoQo1LE=;
 b=sz6OpftZY8VBOARvWP2cBXG6XsyiJt3pl8yTFpHkjmGp+xrfQ5KLFiWYTJdSdmbYBc1cqOpt4
 4clIX6JqrtlBVe/nM8Yq+UABAfYQPRcubRQOcIEDMDJBSydqX2keMk2
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

