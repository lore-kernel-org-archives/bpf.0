Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A83CB57E
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621639; cv=none; b=loJoYFNnVO/653lq/YFZr5a41MBfuSrQZAReHIfiNMlmSKd3BI2wAPpH2Zz16jqx5wVXjmLuBwWRjjCdVtFnT3SR4SyRlgyQdlapVeBni/1tzmIHMEnCqMGNNWOV5yqFA0ZyFZL7fu+VbtYtfvCxt4R9uG6kmd0hhEOkvodn2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621639; c=relaxed/simple;
	bh=SHY2XnQ94S4nO1DsJw9zjnSHxZ4djfWltxq9/571yc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARHiPUbbsMK72Gm71iUrVQU6JkDtYZ9wXHSb6UPWq+Ux4atRlMZDatGmg7wzUeqcojOZf5AfPCHuWA4pYfFk5WZ32qdV+hsIWFH4kzZqtWYckUmtE7WDo/+Jjpu1nGNfu/ElrMtQhGUfToSyBUaRYtr2aAqpZw8OGlvTQMXfExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5jI07BA; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5jI07BA"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-7f4f0c89e34so2234435a34.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621630; x=1791226430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u27IoS2qnlLHTlf4UJkOif7HkUxs4dq85F/mHyTdXP8=;
        b=r5jI07BACud6UvrnbjNWOkBiOOkMvRfGwhGHA202Ndfk6i0MifGV2iW1lN8fGxOHtF
         j9spBsY3OyEfm/nHEzLrgFkGXn4Kk8Mp/qPPxjv9KvyQdC70g5MLKlEK8Df7ORmeEf3F
         x31RWKZkASpC6WsOo81JZ3wVAON07YC5BDrYvUom2EW0ox2umaITW4WOzoNVg48AZQ46
         0Vh0cIeyK4MCwjJyduDZcjmSiKKw6R2kut/gUIZ4DmW7DISNz9la5bYzthE31I7Xb1g9
         vZ6q772WBdaRo8dynLvrfZUMCMU8gtRaZnDUyFjnnKERKf19XZvDLGKGN+K53Vv54yet
         ZViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621630; x=1791226430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u27IoS2qnlLHTlf4UJkOif7HkUxs4dq85F/mHyTdXP8=;
        b=PefufS1+FiHbUu9CJ4sCpWX/jeGxS0ECCeXgUcjcLbGorYO7T6qvfbE79BNKVnJZxu
         yE5+S7lV+cRfnjD3ub+K+6LxkHUr9gAPDPOER5WfTR1OlpUEvYd4msyqCKROCMjLndt6
         IO1Gtwpi9EbVPQOqepAZAROtAYxuD8J7+YeDXf2qOonjCw6TIvI/4ES/Y9raTOcE1G5E
         FoblmLvBvXhf7X7f4OppQVJFaRRP7z/cAWb0cubp4dzj4/MicWq5khC+/EgD9cO/Bz0o
         aWaDvGZzH2NlFmysjGwUfkVIm8lrwOhJHzxA/8ZCMTv3E6UW3E+yGpUx9O1T683KHgAA
         s60w==
X-Gm-Message-State: AFuF++mUAWwcCa8DufX96V5PWqHo3oW6Q3sEssbfIaf1VYi72ibT2CLj
	7t5fI+KasjJKRt+BXxrF1QK42aQyGaMUS4KFF/qdrTBbXgoPtgF5W7rsN7mdCA==
X-Gm-Gg: AYBFou0Oj8dFE+U8+cWc8lPMp6FX4NuMq8Rbi/nQqQxTR+wD3S4WbOtRstijCjqQoho
	wqDaCxirC/u9D75WAL6HDb4ldbO6ldf4nuKXmi13qaarNRfRXtm31zUsZ06R5zWf27Se+mOxftK
	Nc5iV1hsCRA6vwxTp02ZIJmvVdJyphkqZx3IMkrHyMO7oEiBhLc9qcXgwiW1UHD8brlBJMHFC2f
	uW2jkjNN9GiauOme4LMN/0s5QdGyBdO4swDG+zTCnk6ZCtzhyrdNG721an8k5rytUNQtqTbxiFy
	DEJbIpgb7jZdF/O+MzBSEpoxnKNFkCe7rhn78QIreXJXTvovuD4139Ugn7ggAHcCpUmn2Fshudf
	lpSBWDMUmQ47T+UTUwwB9qrIbMG/S+cBlFGTkGzJTDn2Xd5xDoQu1y80/CWYVV+cUM1XQMuL6Aj
	XBlGD/sDODoMGHeuVR3NQbJLavb17NHDUQ/RA/LkuzxYE/Nc/uCLb2Zfd08hLU0A==
X-Received: by 2002:a05:6820:4df2:b0:6d9:a810:9c42 with SMTP id 006d021491bc7-6d9a810ae48mr2682657eaf.25.1790621630232;
        Mon, 28 Sep 2026 11:53:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d8822199cbsm6188032eaf.5.2026.09.28.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:49 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/11] bpf: Check global subprog memory arguments in the common path
Date: Mon, 28 Sep 2026 11:53:33 -0700
Message-ID: <20260928185334.1004200-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
References: <20260928185334.1004200-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Route fixed-size global ARG_PTR_TO_MEM arguments through
check_func_arg(). Preserve their read-write access check, nullable
contract, and support for BTF-defined allocated memory.

Recognize subprog calls explicitly in the common checker. Global
subprog stack liveness can prove that bytes in an argument are unused
by the callee. Retain the existing allowance for those poisoned stack
bytes when call metadata is present, and update the nullability log
expectation.

The verifier also rejects packet pointers when the callee may change
packet data. The concrete packet-backed register state is only available
while checking the call site; the independently verified callee sees
generic PTR_TO_MEM. Record this property as subprog_may_change_pkt in
subprog-only call metadata and retain the packet-pointer rejection in the
common fixed-memory path.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h                  |  3 +
 kernel/bpf/verifier.c                         | 58 +++++++++----------
 .../bpf/progs/verifier_global_ptr_args.c      |  3 +-
 .../bpf/progs/verifier_global_subprogs.c      |  2 +-
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 183759f1e014..811342e3c041 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1656,6 +1656,9 @@ struct bpf_call_arg_meta {
 	struct ret_mem_desc ret_mem;
 	struct arg_raw_mem_desc arg_raw_mem;
 
+	/* Only set by subprog */
+	bool subprog_may_change_pkt;
+
 	/* Only set by kfunc */
 	bool r0_rdonly;
 	u32 kfunc_flags;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8aa1336453a4..ad18b6ab7e88 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7703,6 +7703,11 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	return err;
 }
 
+static bool is_subprog(const struct bpf_call_arg_meta *meta)
+{
+	return meta->btf && !meta->func_id;
+}
+
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			 argno_t argno, u32 mem_size, enum bpf_access_type access_type,
 			 struct bpf_call_arg_meta *meta, bool *known_memory)
@@ -7721,10 +7726,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	}
 
 	/*
-	 * Only a global subprog (meta == NULL) may read poisoned stack slots:
+	 * Only a global subprog may read poisoned stack slots:
 	 * its static stack liveness proved the callee body skips them.
 	 */
-	size = (!meta && base_type(reg->type) == PTR_TO_STACK) ? -(int)mem_size : mem_size;
+	size = (is_subprog(meta) &&
+		base_type(reg->type) == PTR_TO_STACK) ? -(int)mem_size : mem_size;
 
 	if (access_type & BPF_READ)
 		err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta,
@@ -9036,8 +9042,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		type &= ~PTR_MAYBE_NULL;
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
-	/* Allow allocated memory for kfunc ARG_PTR_TO_MEM but not helper. */
-	if (is_kfunc(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
+	/* Allow allocated memory for BTF-defined ARG_PTR_TO_MEM but not helpers. */
+	if (!is_helper(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
 	    type_is_ptr_alloc_obj(type))
 		type = PTR_TO_MEM;
 
@@ -9667,6 +9673,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 					bpf_diag_reg_type_plain(env, reg->type));
 			return err;
 		}
+		/*
+		 * PTR_TO_PACKET gets passed as PTR_TO_MEM, preventing us from adjusting
+		 * bounds tracking information.
+		 */
+		if (is_subprog(meta) && meta->subprog_may_change_pkt &&
+		    (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))) {
+			verbose(env,
+				"cannot pass packet pointer %s to %s(): function may change packet data\n",
+				reg_arg_name(env, argno), meta->func_name);
+			return -EINVAL;
+		}
 		if (arg_type & MEM_ALIGNED)
 			err = check_ptr_alignment(env, reg, 0, arg_size, true);
 		break;
@@ -10806,6 +10823,9 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 			arg_type = ARG_IGNORE;
 		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			arg_type |= PTR_MAYBE_NULL;
+		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
+			proto->arg_size[arg] = sub->args[slot].mem_size;
+			arg_type |= MEM_FIXED_SIZE | MEM_WRITE;
 		} else if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
 			proto->arg_btf_id[arg] = &sub->args[slot].btf_id;
 		}
@@ -10821,7 +10841,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
-	struct bpf_verifier_log *log = &env->log;
 	const struct btf_param *args, *stack_args;
 	const struct btf_type *func, *func_proto;
 	struct bpf_call_arg_meta meta;
@@ -10831,6 +10850,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
 	memset(&meta, 0, sizeof(meta));
 	meta.btf = btf;
+	meta.subprog_may_change_pkt = sub->changes_pkt_data;
 	meta.func_name = bpf_subprog_name(env, subprog);
 
 	ret = btf_prepare_func_args(env, subprog);
@@ -10863,7 +10883,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	 * verifier sees.
 	 */
 	for (arg = 0, slot = 0; arg < btf_type_vlen(func_proto); arg++, slot += nslots) {
-		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, slot);
 		enum bpf_arg_type arg_type = fn->arg_type[arg];
 		argno_t argno = argno_from_arg(slot + 1);
 		const struct btf_type *t;
@@ -10875,34 +10894,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
 		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
 		    base_type(arg_type) == ARG_PTR_TO_ARENA ||
-		    base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
+		    base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+		    base_type(arg_type) == ARG_PTR_TO_MEM) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
-		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
-			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
-			if (ret < 0)
-				return ret;
-			if (check_mem_reg(env, reg, argno, sub->args[slot].mem_size,
-					  BPF_READ | BPF_WRITE, NULL,
-					  NULL))
-				return -EINVAL;
-			/*
-			 * PTR_TO_PACKET get passed as PTR_TO_MEM, preventing
-			 * us from adjusting bounds tracking info.
-			 */
-			if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) &&
-			    sub->changes_pkt_data) {
-				bpf_log(log, "%s is a packet pointer, but func#%d may change packet data\n",
-						reg_arg_name(env, argno), subprog);
-				return -EINVAL;
-			}
-			if (!(arg_type & PTR_MAYBE_NULL) &&
-			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
-				bpf_log(log, "%s is expected to be non-NULL\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 		} else {
 			verifier_bug(env, "unrecognized %s type %d",
 				     reg_arg_name(env, argno), arg_type);
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index f639e2767e35..03507eeae3cb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -389,7 +389,8 @@ __weak int subprog_pkt_ptr_changes_data(struct __sk_buff *skb __arg_ctx,
 
 SEC("?tc")
 __failure __log_level(2)
-__msg("R2 is a packet pointer, but func#{{[0-9]+}} may change packet data")
+__msg("cannot pass packet pointer R2")
+__msg("function may change packet data")
 __msg("Caller passes invalid args into func#{{[0-9]+}} ('subprog_pkt_ptr_changes_data')")
 int pkt_ptr_to_global_mem_arg_changes_data(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 27fbe54e8795..574b26b5a7df 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -195,7 +195,7 @@ int arg_tag_nonnull_ptr_good(void *ctx)
 
 SEC("?raw_tp")
 __failure __log_level(2)
-__msg("R1 is expected to be non-NULL")
+__msg("Possibly NULL pointer passed to trusted R1")
 int arg_tag_nonnull_ptr_null_bad(void *ctx)
 {
 	int y = 74;
-- 
2.52.0

