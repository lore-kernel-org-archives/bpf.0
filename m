Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F3353ECE
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708322; cv=none; b=jHdpb/bGgQu0RJtWm0f+enBRECHjVTBKPjmQwRZusw8QzTIxPZdL3SyxrGGyhtPDm/pC/wNhVaikTqageRkvaI0vG3uinhdNIHpy45oVxvXMGE2E1zYQvcTPMGdvDw9P2V7izUJ+1hG6wLrmtiWx5NfN8Fat7uWBCdpsg6YQEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708322; c=relaxed/simple;
	bh=EUEHjzGlLXon0ojv0myoPTR4g3nCT5wT8HcOxUeYzkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ma6E7LlmaqpSHkLoCz/5OYK5xRINTShb+CYvXSsLlPX0x/oAhV879dXGr4NhRGE30CeJ+ncKCZ3kQ8T47xFPSarhSrq/gK8fCrhxuUobxCdOAmgXDDHtPG4REks1DQBAQiJsP8fXMwdXq/m2ythmC9MmnGL9EorPgmDcWlhtd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFEzNm7B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFEzNm7B"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edffe5540so15638675e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 09:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769708319; x=1770313119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqYdn8YurIiK/TKezRpM6f3KJhoDKmXWsbNloABZMzQ=;
        b=kFEzNm7B6D9O7W+de8VF4bhjvqylnnm+ItzGrftUkKwSOQN5pw5oVQOm2XJI77G/+7
         BaWUIjG8Sga7XWs+Gt0Osar1TW73FLewH3z0XNnRKZBCxs4wHKHh7Xk0cGAWkFocZOY2
         AKZuCcSnANpsmxIxXiZacwaP704/K+OcToVRCnrSULvPoQ2a2eX5E72basWB7byk7AAo
         eSP47Zjeaaty1WL5d4AIv48YdfBV6qdUaWA8LDcPFEmEoM/QhDx2JMKZ5mvnXMEUMspH
         GWAbwyCAObqmNdBz4B3u3Fxap6DsZgv7dkvGyZiyRCpXvu+MRF9zhBKR+iLzp1wCmSJh
         YZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708319; x=1770313119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FqYdn8YurIiK/TKezRpM6f3KJhoDKmXWsbNloABZMzQ=;
        b=VTbC0GuTCGNDzQ6Kvbg2vCQKxi7NoYHCTRKLqVL0kclkaPvdQywdCyOjz0VQMEJF6H
         BFdZ3hTqQXWO+hPVGozksHbValL9kVq4AwFN5wVIuJ19O3mGp3fbMbrZ278u2Ny4wIcL
         +mlvL83UwycrWSCvH/8QkPBOTOR9DzCndLj9vNyNJS+Ii6NlPneY6HO28yVnoYU/Tz5X
         rX5ogJrctCneg0We8bcJyBQsaZlM5WdpvrakL5iKJOLy608bS4q/XlgoFLnEO6Yg+xCD
         wY/qhvkz8EBFYZY+RbLxqWzJX/vQyF+mq4LlFSGtcSqLwMTrlG5RgTx38e5zy6h9eYfQ
         TaPA==
X-Gm-Message-State: AOJu0YzDCH1/eqYq7QkmHrvcVCG0XGqUx5ZpJWPx1nXvOIi1DYoONmYX
	nZwvoUopea/ADjl9r9cW1tUfvK+BLDkXHLkR0fDrx8u/C3/JC/Q8cqlS
X-Gm-Gg: AZuq6aID7Fg+Nny2CA6WchAo9bVUf0ns2v11pqiVSv9hpUDXVHTKBhVRG7a4e25aIWi
	3jtjKpnd76QeC0BF9sLMxwlIzERSoYRV5J5Ka+wbotr2aTDnX+vSe2vUhgG6L+qUGZAMg5fz4vd
	KRZiVNTsviGhi8wLuUoiOZ/jZl7jrFj/p4eB8CuxlDJ9HbzZYTzdZh6LFA9vmqWYPSveP/ig3zF
	J6ekFO/W3/fQR0F2KV5aU5f/JYD8z/j/iPzxApcKfqW11wAj80EaPXqiCrvC6k1IwwIdE4ew489
	v+r87pUpNtzRCNhq07ewstdTQWW58vPXV3RlSQLCiT2goJMQNgny0IhTa4nHjDXhBgbwigyOifY
	eZFLdX5yi6Qi5h14P3t8FOcwZWVMsPUXMqc/NhajNThUITiO4TAwsINewVMv8T+yigLqY4No=
X-Received: by 2002:a05:600c:608e:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-48069c163e3mr133821295e9.2.1769708319262;
        Thu, 29 Jan 2026 09:38:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:48a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da6bcae2sm525905e9.1.2026.01.29.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:38:38 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 29 Jan 2026 17:38:25 +0000
Subject: [PATCH bpf-next 2/2] bpf: Consolidate special map field validation
 in verifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-verif_special_fields-v1-2-d310b7f146c8@meta.com>
References: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
In-Reply-To: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769708316; l=3885;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=nhAlTP/rlJlekUiGAyjEHZRpY/hh6HlaAELYRGcRf3A=;
 b=8MPiAZMghDX/GKPjFCz7cmDAg5cgDSN2EhtMYmsnaVtaq1tuISmtFQHYHJhKxGf2BzO2YM733
 fV1MeeLQbYeDGUbCII4XNErRYQo2vE3A5+J+drGq7SANDJMUMDkkhPk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Consolidate all logic for verifying special map fields in the single
function check_map_field_pointer().
---
 kernel/bpf/verifier.c | 70 ++++++++-------------------------------------------
 1 file changed, 11 insertions(+), 59 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c5fb7be73923b9f8395a6fae53209f002c48fd1..ace423da871d8afce880bec71085e8b8887f7799 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8610,7 +8610,8 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 
 /* Check if @regno is a pointer to a specific field in a map value */
 static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
-				   enum btf_field_type field_type)
+				   enum btf_field_type field_type,
+				   struct bpf_map_desc *map_desc)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	bool is_const = tnum_is_const(reg->var_off);
@@ -8653,72 +8654,23 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 			val + reg->off, struct_name, field_off);
 		return -EINVAL;
 	}
+	if (map_desc->ptr) {
+		verifier_bug(env, "Two map pointers in a %s helper", struct_name);
+		return -EFAULT;
+	}
+	map_desc->uid = reg->map_uid;
+	map_desc->ptr = map;
 	return 0;
 }
 
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
 			      struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_map *map = reg->map_ptr;
-	int err;
-
-	err = check_map_field_pointer(env, regno, BPF_TIMER);
-	if (err)
-		return err;
-
-	if (meta->map.ptr) {
-		verifier_bug(env, "Two map pointers in a timer helper");
-		return -EFAULT;
-	}
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
-	meta->map.uid = reg->map_uid;
-	meta->map.ptr = map;
-	return 0;
-}
-
-static int process_wq_func(struct bpf_verifier_env *env, int regno,
-			   struct bpf_kfunc_call_arg_meta *meta)
-{
-	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_map *map = reg->map_ptr;
-	int err;
-
-	err = check_map_field_pointer(env, regno, BPF_WORKQUEUE);
-	if (err)
-		return err;
-
-	if (meta->map.ptr) {
-		verifier_bug(env, "Two map pointers in a bpf_wq helper");
-		return -EFAULT;
-	}
-
-	meta->map.uid = reg->map_uid;
-	meta->map.ptr = map;
-	return 0;
-}
-
-static int process_task_work_func(struct bpf_verifier_env *env, int regno,
-				  struct bpf_kfunc_call_arg_meta *meta)
-{
-	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_map *map = reg->map_ptr;
-	int err;
-
-	err = check_map_field_pointer(env, regno, BPF_TASK_WORK);
-	if (err)
-		return err;
-
-	if (meta->map.ptr) {
-		verifier_bug(env, "Two map pointers in a bpf_task_work helper");
-		return -EFAULT;
-	}
-	meta->map.uid = reg->map_uid;
-	meta->map.ptr = map;
-	return 0;
+	return check_map_field_pointer(env, regno, BPF_TIMER, &meta->map);
 }
 
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
@@ -13754,7 +13706,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
 				return -EINVAL;
 			}
-			ret = process_wq_func(env, regno, meta);
+			ret = check_map_field_pointer(env, regno, BPF_WORKQUEUE, &meta->map);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13763,7 +13715,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
 				return -EINVAL;
 			}
-			ret = process_task_work_func(env, regno, meta);
+			ret = check_map_field_pointer(env, regno, BPF_TASK_WORK, &meta->map);
 			if (ret < 0)
 				return ret;
 			break;

-- 
2.52.0

