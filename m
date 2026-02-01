Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BF276050
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914453; cv=none; b=BdlJRiQwzpl3gd2sgPKR3wXXDo66390qjJuAr4H6bB3UwrsNJzjffSiWweByuAZihCVj6FNm3dJNa46sPOKnKy/5ki2mBm6cf8J+PYZvqSxpAB+ySYIBsOudnsxdYyjxicGFWPhcpFqkjDyhMyUrMzGk+n7kxWuZBe/iAwnsEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914453; c=relaxed/simple;
	bh=6LTBvKLaHv+qV5l/xl7vz67/3ij6kJc62NkVIdhGLbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsB/J1YL14jcpOY+ZApRDhkH4s3X0Vjdbug9pNj/9CojlODEHlZyrd50HDrpbHW5Jged3nhBZhyp/sgcZbPMq3DDDmxUM55Itx8PdgenJThiRdhsDEiz7UHP5d0a+32BdT8YLs3138gr1YUAj2pv/BhEh+OxZWwdkzDaWCSGVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds3zwWRZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds3zwWRZ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so2037738a12.0
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914451; x=1770519251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIoyt6roaN0MQ4Jp9PockhGMCiab9xI7/EVMcvkq6mQ=;
        b=Ds3zwWRZYD03spBMHk3AxA707WV+blkqVD9UX3JsUfee72vMWzIEVtidj858vOZj/L
         4VkIgs3+XLVLmJNidaLTygpXnYwlYM6noi3aVP+ibP+1paob5ChSYhBAmfq+NURqQ2zR
         KU/5IX/A7wXaQN6NprBfcDpSwVeX8+rz5zc3iaf0DXKLWPYRH5cICfX2fiAoYlDGlcLH
         10NZPKnbRqV/NiPrNDOvYpEfgY00eJNxe2PpzA2BTaJOuvupQfqCSodBIJ3fx8KCY2g0
         +D1Xen9iK3/9xzStoYnDVkYCnPbYJuXoxkg83JP/HiMsnrHdcU5eyZbtUfur8QRkueuw
         jLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914451; x=1770519251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DIoyt6roaN0MQ4Jp9PockhGMCiab9xI7/EVMcvkq6mQ=;
        b=XayeSQr1NzTvlPoBbVoRge2aUsY4skARRk9lKR6gx7gMne+NN6zO+SKNF+ZyIvACCU
         /xepB518j4W2ldmZNlCeyb0dcOOWXbX6ND5SeZTJYFeXiS7OHGAynvYi2u83ib+148c8
         8LMgQJsGZCQ0dIFuW7rYfCMpPxfF3Op/hKTp3XnaCWO2GJH3v3VrpKXo9DfAtqU7bDCQ
         CAimbT4YK4oQChdUrzXdrrC0fF4AdPTL4R7ymWmPpacxZ9Ke4EupvFmlLKYYeYRE7KHO
         o5wfrOdCViQuJvbwPo5KC6j2F6uVVar/U/h7GXdVQ33LxPqHaL6l+P+K6uvbjAFJ9eNm
         YoNQ==
X-Gm-Message-State: AOJu0Yys4FMfsYqsXKnkyJu1mZ7xnWh2CfdnUzRLQaIB0/uSFwc71xU5
	E1zW0uf9u8e+EPoKfuTh6UVzmb+K4FRcJTK3omMdjxd+ZuRU5T+5lqNFxHOkiQ==
X-Gm-Gg: AZuq6aJCgu6ianlSKx48f0u/a7utvkyFMJ9Onuw0eGsu+40dsZJeXGiYV02FC+QqIBX
	S94xoNTHN3Jlg+mhNmCYdhNz2RGt5/H1TPF0N9t90VZ25TjsL7x78Tf5nTt9SPl4/vfPGNY5PpJ
	3ylawZbd3th58uYGJUBwl3biWbO43mzZcWWa+TX4rjaqMsPKaQNg778TyHLG5hsOZ+vDknNjK5I
	V250gRNBXWhHLC4LJa3iCS5bMTrq9EgAakloSeTESSxdz0zAlJOjPsybsopScIeVRkYSBdJ+j+d
	ZVX6cbWwh4bMAami+V8n2KImOtDnWDyPJOTy3kjY0X1R4AoWd16Bl7hOmxrPVUW/g12WHXwae3I
	bLlnv7ZqD7ubHnlVnn2zY49xmeAstq1egDe1OAk34A4n+Ld20y2B0XXywJi+vhmhvpH1iEG7yYG
	Q9WaY+JXkK3schsJVEdFyazhT/SiZQG9srLdkwceAhgC2occ77zum9bTrJWA7wCCv0JX0D3eLQG
	2ecguMZ5sIzvTd4hI+xs/H1VyR32Ji9+BnRrwjh0kRnmsqkxrtmFWwtgyvM
X-Received: by 2002:a17:903:1984:b0:2a7:63dd:3496 with SMTP id d9443c01a7336-2a8d993fc15mr66576915ad.46.1769914451168;
        Sat, 31 Jan 2026 18:54:11 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f9a9esm112184545ad.102.2026.01.31.18.54.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 2/9] bpf: Add verifier support for bpf_timer argument in kfuncs
Date: Sat, 31 Jan 2026 18:53:56 -0800
Message-ID: <20260201025403.66625-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend the verifier to recognize struct bpf_timer as a valid kfunc
argument type. Previously, bpf_timer was only supported in BPF helpers.

This prepares for adding timer-related kfuncs in subsequent patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b62b6d57175..9b1853fec730 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8664,13 +8664,25 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 }
 
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+			      struct bpf_map_desc *map)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
-	return check_map_field_pointer(env, regno, BPF_TIMER, &meta->map);
+	return check_map_field_pointer(env, regno, BPF_TIMER, map);
+}
+
+static int process_timer_helper(struct bpf_verifier_env *env, int regno,
+				struct bpf_call_arg_meta *meta)
+{
+	return process_timer_func(env, regno, &meta->map);
+}
+
+static int process_timer_kfunc(struct bpf_verifier_env *env, int regno,
+			       struct bpf_kfunc_call_arg_meta *meta)
+{
+	return process_timer_func(env, regno, &meta->map);
 }
 
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
@@ -9956,7 +9968,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err = process_timer_func(env, regno, meta);
+		err = process_timer_helper(env, regno, meta);
 		if (err)
 			return err;
 		break;
@@ -12221,7 +12233,8 @@ enum {
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
-	KF_ARG_PROG_AUX_ID
+	KF_ARG_PROG_AUX_ID,
+	KF_ARG_TIMER_ID
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12234,6 +12247,7 @@ BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
 BTF_ID(struct, bpf_prog_aux)
+BTF_ID(struct, bpf_timer)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12277,6 +12291,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
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
@@ -12376,6 +12395,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
+	KF_ARG_PTR_TO_TIMER,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
@@ -12625,6 +12645,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TIMER;
+
 	if (is_kfunc_arg_task_work(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_TASK_WORK;
 
@@ -13411,6 +13434,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_TIMER:
 		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
@@ -13710,6 +13734,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -21294,20 +21327,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
2.47.3

