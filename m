Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831434B19A
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805741; cv=none; b=UvYLEHLY3xEFY0STe703jkESXb4cXmkvqQW9LwNd7g58IVOk907hH3BrKlxGwGbCYYfo4PWXtxjuWM4vqNt1KtjOy/ALsifIs0NJVd6CtZzHYuPGrsiajeaH5pz3x/18hQ4zbATXuf3YMBgInCoEqqL4XVAz6mxeqr3OIxLYCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805741; c=relaxed/simple;
	bh=DfbkPP0uPZRVUG2xk1E/fQOzmrih0Mrfqj4hjY5lt4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7hm0GFLr3aI4CqyKnmdlyf1871PXEQzGWpnufQkVHOJW9EyX/GLo/8nBcFTTjaBOFqgM8LZ5hJwYAplWXLUrBs2mPnZCsuld2JaN/nQrdHKC2T5O6qrQ0KcjelATaH9gbMzyOb7dvnNFR8DqDnD1xR0JJAN+x8HSUdYGsjReOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzdOQQ9x; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzdOQQ9x"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-435903c4040so1736775f8f.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769805739; x=1770410539; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ak8+oDop/ywUtNr46SlHayW+/ZRHODJS6ywhW8pT2a4=;
        b=HzdOQQ9x2bCx/xKyXDGYHlcX325z+Udak8JJw/oLyyuEjCh/klS+RGSZeOB9u9VUht
         cfbxOBAHhq3pzXvbX9/XQtqB4SNP1SG4qLJa6dcOHA+PZXOCCVMzJxXwEvsteLgGNznL
         HEbZGrz2veenpGSVBBIy8ftgziZe00vT4ma5I55h1Z2sXE3+R1x7o6uCb+jDXj1yjhhr
         9iZGu622/TnIS6+6Bq5TXuKOBwfKK+R+JDVzIeFcBE30ZQi3rk9aVj/lXJDOkg6d2h/u
         TjEbHRNAr8wmgiA+n/ZZAUiC2dbEDMyIum/sTCvr2zazpOjhUz1+ZSd9ggY0Gkv7BFkI
         MQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769805739; x=1770410539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ak8+oDop/ywUtNr46SlHayW+/ZRHODJS6ywhW8pT2a4=;
        b=ncE95tIGkVgCFzSUMNFcmnivtfkNZ5ATcAdjbYwUfXVgdTKiLi2fjFNrG5EJKGkYlr
         fPAd5iVktrcvqK4xI29rjOW656ZBI8NcB7kF385glw9JGY0J4pvS5y6Miui4/C7Kr4IG
         ifDV+i4IkWfn1SOUfCehiR0jV1VmESGg+GCAjTzBCmokJ4up57rip2RoX8vhOWtcW3Gt
         mi7AFaAesupUUJXJmvU3oMSGYB2o4V2OuFz7XQ8Ua9tvbsZzuFJuRfhX90WRRrT18X5L
         bSV4wJhl/6xNj8AR7faD3nGhotwQAXDSpE95szSO7KBb1aFo7D8AOOrn0RgzY9QLpE5+
         z5jg==
X-Gm-Message-State: AOJu0Yz/dfd+2KDE/qboj+m8ndv4SY42ZSiqWbI4y7LVOTDrrOP/MmLJ
	MGhzEsyuTCZtxjsOleZCzpO48b7Pzu4E3EjnyXahl+POedbbFm+sAz8i
X-Gm-Gg: AZuq6aLNlhZccWvPpL9rxmy5vxWcut2rmabTwXZpjWbDej2BFDTQP5/cu3wNbowAAmZ
	8/6nodsPdpM4XaTkjts8HaMItMTkbaQ+KS83yfnDphnqykn+eEdqjyU287NPqzdc2dGrDakNmtH
	NTDoAEy77OtK+Bw+GQ53fUKpvS4WtoC26d9UmEONI3bI/nlRwQyG8lXqoZv1h48Ma6p0R+7yweq
	6POLCCoTXBgw2tRPbsIWI9/dHi1nyjS6vOKeaTFx4tJK46nt48W5MTdDkMeoYCMW87I+bWTaa4/
	JTRTC9SzHs+VGwI9VFy+KiZytQtUfYjtTXdqXYv4dBxch2dsiVXF3P0uDtbhYsl9EWx2HnewtA+
	TLNHZ4n1yId+3ltlHySQzOO36OlXnuyDVVpZ7FfVKtYFW7iPOFwD8YR3D7htQaexnQZKplg==
X-Received: by 2002:a05:6000:240e:b0:435:a8e7:62de with SMTP id ffacd0b85a97d-435f3ad23e1mr6414965f8f.58.1769805738385;
        Fri, 30 Jan 2026 12:42:18 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:cab1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm23575637f8f.3.2026.01.30.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:42:18 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 30 Jan 2026 20:42:11 +0000
Subject: [PATCH bpf-next v2 2/2] bpf: Consolidate special map field
 validation in verifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-verif_special_fields-v2-2-2c59e637da7d@meta.com>
References: <20260130-verif_special_fields-v2-0-2c59e637da7d@meta.com>
In-Reply-To: <20260130-verif_special_fields-v2-0-2c59e637da7d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769805735; l=3987;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=7MHiRfJTxbn3f0cP46rlKq7r0wwGdTtGRfUPh8OYlRE=;
 b=8VeeN2rLJk5VT71F/DHChSpAqYRXt0GuH88IPRyM36FbDsIWPnxHUYWr6CXy2a/6Fm64raGn8
 I6tZggGJKL/BJEFsbFFUMtWQXnjKDGIXaftcE4PJ0TduT7XWGhRT5rY
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Consolidate all logic for verifying special map fields in the single
function check_map_field_pointer().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
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

