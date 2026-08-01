Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A939FCD7
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570406; cv=none; b=tYRlor6ATHVrLtNjU2toRJ5ronWTBBshja7ScLA7jw8gYhitA9FdFnZbtUNlFBRnM+Z1nNBj5a6k26naotnUzrJVnZhl+flPJCA5E5LO5epVayitEFQ4CDOKo14jP1T1iYHdEtU18VSy9wsqdnVhQQ8baZlvodd9vqhpqtJ9Tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570406; c=relaxed/simple;
	bh=5qX38dkMna0th6gsb85TPsiK3c4qiCTpPLjZIeAygOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUMc5H1MBra6jhm+l9bie0dNJQxDcuqwuwKw1vssdMVhINbA3P0nHNQ51ImozlIJquztT4Xl4Jz6KdFrHf74rZpbY1C3ho9hmM3UA7fqtDZBNqq2j3ObkN2Kj0cUWE7F+rEJxDEXxffF2ZGNx2deJ8kJNWX+YurP3IJN3r33Rr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBCcnam/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBCcnam/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf50c6f235so20068625ad.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570404; x=1786175204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Mjf7nMCgcFHEht059qt4NzCFRGHal3PTBBdCHVIyjI=;
        b=KBCcnam/kzprtbuioE/PDjcV7rO1HR7jaY+MBdVwlTZ0dM/cF3cqM8UiQpggqI+qiX
         WERkmcxUOehYRUkcqrAm3Cd5Rd2tlBK8gwf0ha5loU0NgjPxYLPUqFXHAUwYIC+AqJPx
         c5XkRgku9QNtc85thZZGrfJe1/plR7OkJYR+Yj63GjXKLIOiZnX3wf/4XaqHc5hUkQT7
         CP6+RjCXKY5ZP11ry+HEE1KZVRCNnZMZ8qlgCT8BYClfArOaYWq8MhtdgjgcF0Srs8TM
         Hx2E5r/5X4gBNxu9+eIjLfusMX7EjmVC2GTIxvF6qraneoGN2QpxOjzQ37BasDOJ4q63
         54rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570404; x=1786175204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Mjf7nMCgcFHEht059qt4NzCFRGHal3PTBBdCHVIyjI=;
        b=r4r6JS33hlTdB6EcmjM+fKnJimusgperQFVZK4IPPdEKNIoCyYyqlGwm6tKuEMv3lD
         9k+jakG+kqxa+EaPpFstqHFN7MBgCEjDRPbbQZi9Smz28JrLL8/VVn/7LwaaCqZvgWnq
         56pCLoOH7RPA9+I5U2V3GuaxiNouGeMAykn3Bz206bKYfwD3mXHB9XHyfSj7D9Ij6MWK
         tt6246Nri26ECat+0ZeQMT5iLqXzMSC2lv+Wzqa78VrZa1fqv/0V9fnP+QuXNe7/SarI
         IC+RBy2dP71h4vh6izJlKAMydBMq8k5QOFTf0Vqd8QBC+EcwuQCVhTSp986Z5fF+hOav
         a1Wg==
X-Gm-Message-State: AOJu0YxY8oR6WvArSlRzP8Y5IPmKLUzf7COO0luxLuBbfn3E+OphqL2N
	0m4AiHjn/1oM+E4SBK7Y950Pt1D6WYIlarFNFrRlZgt8mxg9ZjyqQCH6H0eZKA==
X-Gm-Gg: AR+sD12LKkudJ35HEUvoOvpoMwDOYgpKccf0AksQ7SPBKElyoflgxf9wdyeDto2XSWy
	XSUDatx83/uBFtfNf23nPgBQxwHgZkUuQkBrAbWF7naJFjEwafovGKfAcYF9tLml3u4hW5QNjKC
	Xvd+f7jTPIzQxJD6WHOD556Ko4iap5wJigw9okM2qtyPLUcMn1I+NYwqkX+UmhegLTM7h5zMKTi
	pruNTYTfw1xV9Te+Y4yfJ8T1xZDAh0VffcAnhx7E2H+i/CpDUwwY9lwF6TG8GKqxSdsBp3l0ldD
	nPgBH2Nsp5BOBEO7+i2VzZl91FFYyutZ8Ve8Es42fw3rzzBrsZaH8A9vjnPFXpcXZ3nU0HsA98l
	bU9HT2TXG9UTAF/7QgP5KyiqGA22fZ5vjT4wgUEI6Zbbt0V8V8uPyAdIUV79QRzuPsCNNal4nZJ
	ecow0RklojLnT2O0Re5FJ7uQpObWbddhAhh/ahIjpTigmmU6a/LgM=
X-Received: by 2002:a17:902:ebd2:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2d0521ea576mr27686965ad.1.1785570403980;
        Sat, 01 Aug 2026 00:46:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae68cf7sm15016215ad.31.2026.08.01.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:42 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/18] bpf: Resolve map lookup result type at lookup time
Date: Sat,  1 Aug 2026 00:46:20 -0700
Message-ID: <20260801074633.1595644-6-ameryhung@gmail.com>
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

From: Eduard Zingerman <eddyz87@gmail.com>

bpf_map_lookup_elem() is typed to return PTR_TO_MAP_VALUE for every
map, but for some map kinds the looked up value is actually a
different object: an inner map, a socket or an xsk socket.
Until now this reinterpretation happened once the pointer was
converted from its NULL-able form to a concrete value.

Such reinterpretation logic placement led to mark_ptr_not_null_reg()
being called for a temporary register copy in check_mem_reg() and
check_kfunc_mem_size_reg() (check_mem_size_reg() was buggy because of
not calling it). The temporary copy was necessary to pass
reinterpreted parameters as nullable helper and kfunc arguments.

Avoid this complication by refining map lookup result type right away.

The test case verifier_map_in_map/on_the_inner_map_pointer needs an
update because the verifier now prints a concrete NULL-able type for
the lookup.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 79 +++++++------------
 .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
 2 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d10b2dc2d628..1d9e48cbf517 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1854,32 +1854,34 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	reg->dynptr.first_slot = first_slot;
 }
 
-static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
+/*
+ * Refine the return type of the bpf_map_lookup_elem() for special map types:
+ * map-in-map, xskmap, sockmap and sockhash.
+ */
+static void refine_map_lookup_value(struct bpf_reg_state *reg)
 {
-	if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
-		const struct bpf_map *map = reg->map_ptr;
+	enum bpf_type_flag maybe_null = reg->type & PTR_MAYBE_NULL;
+	const struct bpf_map *map = reg->map_ptr;
 
-		if (map->inner_map_meta) {
-			reg->type = CONST_PTR_TO_MAP;
-			reg->map_ptr = map->inner_map_meta;
-			/* transfer reg's id which is unique for every map_lookup_elem
-			 * as UID of the inner map.
-			 */
-			if (btf_record_has_field(map->inner_map_meta->record,
-						 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
-				reg->map_uid = reg->id;
-			}
-		} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
-			reg->type = PTR_TO_XDP_SOCK;
-		} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
-			   map->map_type == BPF_MAP_TYPE_SOCKHASH) {
-			reg->type = PTR_TO_SOCKET;
-		} else {
-			reg->type = PTR_TO_MAP_VALUE;
-		}
-		return;
+	if (map->inner_map_meta) {
+		reg->type = CONST_PTR_TO_MAP | maybe_null;
+		reg->map_ptr = map->inner_map_meta;
+		/* transfer reg's id which is unique for every map_lookup_elem
+		 * as UID of the inner map.
+		 */
+		if (btf_record_has_field(map->inner_map_meta->record,
+					 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK))
+			reg->map_uid = reg->id;
+	} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
+		reg->type = PTR_TO_XDP_SOCK | maybe_null;
+	} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
+		   map->map_type == BPF_MAP_TYPE_SOCKHASH) {
+		reg->type = PTR_TO_SOCKET | maybe_null;
 	}
+}
 
+static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
+{
 	reg->type &= ~PTR_MAYBE_NULL;
 }
 
@@ -6926,8 +6928,6 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			 argno_t argno, u32 mem_size, struct bpf_call_arg_meta *meta)
 {
-	bool may_be_null = type_may_be_null(reg->type);
-	struct bpf_reg_state saved_reg;
 	int err;
 
 	if (bpf_register_is_null(reg))
@@ -6939,23 +6939,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		return -EACCES;
 	}
 
-	/* Assuming that the register contains a value check if the memory
-	 * access is safe. Temporarily save and restore the register's state as
-	 * the conversion shouldn't be visible to a caller.
-	 */
-	if (may_be_null) {
-		saved_reg = *reg;
-		mark_ptr_not_null_reg(reg);
-	}
-
 	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
 
 	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
 	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
 
-	if (may_be_null)
-		*reg = saved_reg;
-
 	return err;
 }
 
@@ -6997,21 +6985,11 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
 				    struct bpf_reg_state *size_reg, argno_t mem_argno,
 				    argno_t size_argno, struct bpf_call_arg_meta *meta)
 {
-	bool may_be_null = type_may_be_null(mem_reg->type);
-	struct bpf_reg_state saved_reg;
 	int err;
 
-	if (may_be_null) {
-		saved_reg = *mem_reg;
-		mark_ptr_not_null_reg(mem_reg);
-	}
-
 	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, meta);
 	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, meta);
 
-	if (may_be_null)
-		*mem_reg = saved_reg;
-
 	return err;
 }
 
@@ -10522,10 +10500,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].map_ptr = meta.map.ptr;
 		regs[BPF_REG_0].map_uid = meta.map.uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
-		if (!type_may_be_null(ret_flag) &&
+		if (type_may_be_null(ret_flag) ||
 		    btf_record_has_field(meta.map.ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
+		/* requires regs[BPF_REG_0].id to be set because of the map-in-map case */
+		refine_map_lookup_value(&regs[BPF_REG_0]);
 		break;
 	case RET_PTR_TO_SOCKET:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -10623,7 +10603,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
 
-	if (type_may_be_null(regs[BPF_REG_0].type))
+	if (type_may_be_null(regs[BPF_REG_0].type) && !regs[BPF_REG_0].id)
 		regs[BPF_REG_0].id = ++env->id_gen;
 
 	if (is_ptr_cast_function(func_id) &&
@@ -12370,7 +12350,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			break;
 		case KF_ARG_CONST_MAP_PTR:
-			if (base_type(reg->type) != CONST_PTR_TO_MAP) {
+			if (base_type(reg->type) != CONST_PTR_TO_MAP ||
+			    type_may_be_null(reg->type)) {
 				verbose(env, "pointer in %s isn't map pointer\n",
 					reg_arg_name(env, argno));
 				return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
index b606b5dca734..7918646e5bfc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -154,7 +154,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("forgot null checking on the inner map pointer")
-__failure __msg("R1 type=map_value_or_null expected=map_ptr")
+__failure __msg("R1 type=map_ptr_or_null expected=map_ptr")
 __failure_unpriv
 __naked void on_the_inner_map_pointer(void)
 {
-- 
2.52.0

