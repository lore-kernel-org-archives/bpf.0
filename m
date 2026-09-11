Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387C4BEE3A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164265; cv=none; b=exJ764GURkzv4uXBIQFSQSk3yr6RRQjXrfmCk5gq/rO4JQmhky9bS2gnRUaPGM1y+IrnClIEACncQf23Hd/OG7ofLdgb4pDDNMXNPihn285ecOpuiWBy3CmOfTN+j5KHPuEIthsLISg4ThCUYK+zCSTFwOBaj9nB7d/+LXo3NTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164265; c=relaxed/simple;
	bh=AHI0652UnU63u/JUlscJ2ckNRDnte1v7KcZRO+RIOOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2tlPxBBsAtsPa2kw+Djse+iRQDW7na+rsZV5DfKPIpQaNhA64LNbOx5ovdRu+tSKKX0inYSKtKVyrHQJ7UpepDjKSlenHBjfhh5lnyau55dKj8GQvWDw4rhqIrzhgdi6R+9h7xqPIkOLootYCjOsT0ko8jZbBvO56vwjNXLco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew/kRncv; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew/kRncv"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0d298caso28162a34.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164262; x=1789769062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GUVG7Pm4GAz5IXewalYnZKrXV7OVwpUdUWuBSnnT/Ok=;
        b=Ew/kRncvP4GvGX6OFnML4JV52K5D5fPPDbAyL0GrMFzSqFYlOb9Zkqt1gnvP2XFMMu
         ED8iYOK4Rpzb3iJW1mNEEVurcW5kGdEzr8yGKrdyau3+PoODdTMoNzioG+o7sMF5jrMK
         APHdVs5xWeytNBHUDhy+++RRio0tb9pEjJzUDvYFNWenN5bCrbaXU6U7dGTaeBvwhrlw
         tmbXbON8Zeh5CmsPWI5A1QmFA7WWxUW9y2rBSlBgk2gim7wYmnkGerhMuNPjDuJKyLE1
         IDb03i3Rb3tFgid+PL2qZqUJHhbFQR8DnKjA03TRQJt9y2evXeFMcBukLRJk2GEaAvVe
         Qmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164262; x=1789769062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GUVG7Pm4GAz5IXewalYnZKrXV7OVwpUdUWuBSnnT/Ok=;
        b=QREPeuxrmbZT7CVSZTadrkdBqZYQUA4+cxsxHyeRtJN1yJu8mgIjsvGkPwItvMXf7z
         FAUhbtoagyaY8+ewvttQ4EFdlisB1qy01Di3oK8w/3u2vs07LcE8IcuQhrYG0lOoKR14
         CXM7rM5hk0F1dc2U1Dhv9fMsZDmGpyzQD3gzZObGjYuutTTGgNW1zDyY0TA8ErqAnUs1
         OArtTNeYl+VSW10V0fHxQT36yUuMiMEkeCHUPq+TRSha8gbdqew94sbGURdU86bOifDa
         R3Ti9eQh12/V+CixsPj+1BNwzzXb9f7c0Ms7Usp5D42mrfHL7Pyndsye09Fxcd1s8831
         27jQ==
X-Gm-Message-State: AFuF++m1M5FsjQeEQFQarRbNW2TXG5LLWg+epcziOAxX01c1E3ieTfV3
	jAK39lcANlrMDObbDswGHh0tCw3rAOxRkR2+S/D5GlDEkHxSZ/rQx4fW4JsSKQ==
X-Gm-Gg: AYBFou3YT4vZ5qm5FBWfxkzAxW6ospapP7EmRLRAHYKw3/1nHojBsnXth4idhLVm8fB
	5n4dCM++gOLgVIT123uAWblZYJkCtbSyMsvx+NKPfsaOb4xPPcLbJxMdE/wSsZzbCDLjleBPvhK
	KKT/3dPbFPjlPPqIKBwaxDkgDLdWuusuPGcctetDMolo4r3L0YFQ3VGliak8NnuK7HCSK4zOdPG
	OHqTXnuk5C5cbCV1GlydFFIESGdke7aoF7iX2qOEkWA8jp7tOv1dHwTiBloJ88w5JKz2WCgTOe0
	edbXziSCMIYPp0ywY1H1SZxamvlsK8lcTZbTSybpGGZ4I+wuf3XopsuQSSh3r/Bg7UU177vgJjZ
	ICV2nVf8cwPQBY02YVN/P2Pfc/qyHE3YoEMSuOpWvybjqOMpB+8ceifL5QzPJmqIaaM+8nZ5BVX
	EQZBvbrNsvkGDzQz4MJ4AwJvQBuK/9BlNwGUNGQ0ch6g7uOQl5Zx0r6F4RoGjy6w==
X-Received: by 2002:a05:6830:6f8c:b0:7eb:9464:ac2e with SMTP id 46e09a7af769-8059e8504bdmr195583a34.11.1789164262454;
        Fri, 11 Sep 2026 15:04:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f3b16ee7sm3732186a34.3.2026.09.11.15.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 03/23] bpf: Only compare func_id against BPF_FUNC_* for helper calls
Date: Fri, 11 Sep 2026 15:03:55 -0700
Message-ID: <20260911220415.1396439-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helpers are identified by enum bpf_func_id, while kfuncs are identified
by a BTF ID. Both values are stored in bpf_call_arg_meta::func_id, and
a kfunc BTF ID can have the same numeric value as a BPF_FUNC_* constant.

Later patches extend check_reg_type() and check_func_arg() to kfuncs.
A bare func_id comparison in those common paths could then mistake a
kfunc for a helper.

Introduce is_helper_call(), which first excludes kfunc metadata through
meta->btf, and use it for every BPF_FUNC_* comparison. This keeps
helper-specific behavior out of the shared path from the start.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5e885435bb6..5bf31fbdaac1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8176,6 +8176,16 @@ static bool arg_type_is_dynptr(enum bpf_arg_type type)
 	return base_type(type) == ARG_PTR_TO_DYNPTR;
 }
 
+/*
+ * A kfunc is named by a BTF ID, which can take the same numeric value as an
+ * enum bpf_func_id. Only test meta->func_id against a BPF_FUNC_* once the call
+ * is known to be to a helper; meta->btf is set only for a kfunc.
+ */
+static bool is_helper_call(const struct bpf_call_arg_meta *meta, enum bpf_func_id func_id)
+{
+	return !meta->btf && meta->func_id == func_id;
+}
+
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
 				 const struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type)
@@ -8197,7 +8207,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 		}
 		break;
 	case BPF_MAP_TYPE_BLOOM_FILTER:
-		if (meta->func_id == BPF_FUNC_map_peek_elem)
+		if (is_helper_call(meta, BPF_FUNC_map_peek_elem))
 			*arg_type = ARG_PTR_TO_MAP_VALUE;
 		break;
 	default:
@@ -8413,7 +8423,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
 	/* Local kptr types are allowed as the source argument of bpf_kptr_xchg */
-	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type) && reg_from_argno(argno) == BPF_REG_2) {
+	if (is_helper_call(meta, BPF_FUNC_kptr_xchg) && type_is_alloc(type) &&
+	    reg_from_argno(argno) == BPF_REG_2) {
 		type &= ~MEM_ALLOC;
 		type &= ~MEM_PERCPU;
 	}
@@ -8467,7 +8478,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		 * allows bpf_sk_release to work for multiple socket types.
 		 */
 		bool strict_type_match = arg_type_is_release(arg_type) &&
-					 meta->func_id != BPF_FUNC_sk_release;
+					 !is_helper_call(meta, BPF_FUNC_sk_release);
 
 		if (type_may_be_null(reg->type) &&
 		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
@@ -8488,7 +8499,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 			arg_btf_id = compatible->btf_id;
 		}
 
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		if (is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
 			if (map_kptr_match_type(env, meta->kptr_field, reg, reg_from_argno(argno)))
 				return -EACCES;
 		} else {
@@ -8519,13 +8530,14 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
-		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
-		    meta->func_id != BPF_FUNC_kptr_xchg) {
+		if (!is_helper_call(meta, BPF_FUNC_spin_lock) &&
+		    !is_helper_call(meta, BPF_FUNC_spin_unlock) &&
+		    !is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
 			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
 			return -EFAULT;
 		}
 		/* Check if local kptr in src arg matches kptr in dst arg */
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		if (is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
 			int regno = reg_from_argno(argno);
 
 			if (regno == BPF_REG_2 &&
@@ -8948,7 +8960,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 * Disable raw mode for bpf_map_peek_elem() on a bloom filter. The helper reads
 		 * the value buffer as an input rather than filling it.
 		 */
-		if (meta->func_id == BPF_FUNC_map_peek_elem &&
+		if (is_helper_call(meta, BPF_FUNC_map_peek_elem) &&
 		    meta->map.ptr->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
 			meta->arg_raw_mem.regno = 0;
 
@@ -8969,11 +8981,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "can't spin_{lock,unlock} in rbtree cb\n");
 			return -EACCES;
 		}
-		if (meta->func_id == BPF_FUNC_spin_lock) {
+		if (is_helper_call(meta, BPF_FUNC_spin_lock)) {
 			err = process_spin_lock(env, reg, argno, PROCESS_SPIN_LOCK);
 			if (err)
 				return err;
-		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
+		} else if (is_helper_call(meta, BPF_FUNC_spin_unlock)) {
 			err = process_spin_lock(env, reg, argno, 0);
 			if (err)
 				return err;
-- 
2.52.0

