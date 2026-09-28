Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9993806DA
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619276; cv=none; b=kfFz+R+5qaHDN8xvFQ90S0UobGT0l++KZt/aWDDC0/mplo32+Fo5cFEeHIvXObT+n3lPzrW+M0rw2rCdVhsC61WLtCZ8dJs3BiVjJWD+XvIEXMjc7ZHsJ8Zsz4TyGe5vaBI3HpEONoWvdPpFfp3yWUqNDqYPDy/0NToUjYcEcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619276; c=relaxed/simple;
	bh=3YDg4l0JWWTbLH2NoXWB6f0Ii+ycuR1jMDTsKuC+UpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ua/tRyy9fOHQPbznR/8CzKtU/LLvc2JPtKD7dPcnRe09pnPHDlB5bRZBGljD1NE3mZK0v4RoryVSY/0L+WtsuL62Egw1UBxLt7UJba57HlS64fjmxkiEUF9wFIWgyN+3d+N8bg3v3U47BK5nTHT4Nl6oEYAIKrPJQVEtoQodDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjLDpdAv; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjLDpdAv"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b36a8d5b5so1066776a34.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619273; x=1791224073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rdr3hrajNCNGvGIt2ANCUJ5gEv8FXDJLqeHM2IrevMw=;
        b=ZjLDpdAvfyAEVfQ7/ngFIml5rgOCAXLqPc9eSW+82+YXQhbHAjtpvfVbP3m3eTBfhI
         uF41tsg3tshm4+ScIkFOaaHI/KLp0OIhZqPisgRMbK5H7zm6JfDlmppHoKUaAwtIIRQK
         wH8e8TwA65Cc/39vRWa/5ZcpJwALToPJxGPh2DP2ck3KE4zVWrNsRKwM0M31amwoglaE
         yxO95sZO4qmagok3lyLX7x5kNE5Qa47sctNYjbcYj2QJlL4g8GuLzNpuos2HBDoP78vw
         opAW5DkAdrqpVfqFa+lPKhTVzfFG+i5TgIhpyrkOgEMouA73l6Qj3IAwQKNhL34bmqso
         0mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619273; x=1791224073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rdr3hrajNCNGvGIt2ANCUJ5gEv8FXDJLqeHM2IrevMw=;
        b=mCpfvvsNj9fa/NILR6MbPjL5JEkHhhKadei8t4tEhLV9QpSunNBBj9QujUw9lcVJWA
         MrJBIi1LoIMs+hjg907bqU8Yo7CkfWWPvxo/1Lyttr7evNx5SXkhWWOXbomGe1Rfx07U
         av7ia9Vh5licqBb7TimWAFa4KeFJpqqQpgbue/ifW/cVxyWtZf0Sec9uMsvp9i+zxHhD
         XiTyiBOGTkVu9l9dzJgIeupVlGouOFSP52VtEFknxTC/KWF4x2FXHqM5+5o41n7lz8MG
         5Pf8/QPRRjJzCGVFzE7JgENwOjX9FhhCWTouGbJE1smmqmgWg8nLtdMmr13fn6aaaxuW
         2wcQ==
X-Gm-Message-State: AFuF++lLoVMoeuu+i68nezGMaiN8jHBq2RGA40KcwGYUduFGEo1vZrL3
	Gv8bcPBZqku52ARKM8pwuuo54H/fHiKbBX5m6NdOThwZQszS8l62pSnQCOAuzw==
X-Gm-Gg: AYBFou1+/CQUPv7x04QgPDWwNpU28XajRIjJtinf93nqEV4+DJUMu8ChZqqFUmfzR/o
	AVbRd2mF9v5txsb2XgzchSrHQEG+JsBzsDLsSn+z1b2BJE1R3BWMbIdnGrKROmCxQ1+/R81Qxyk
	pAQBxj0Ov52H6hpsGb/oqna3v80djKHXaaB5v5pW51ghZ+RL8STQO4stxNq2Hte13yLElFo6WfZ
	IahZ96+MQQm1EEWaVYITmI+KJFCrUW1s7avy0bO3Bl1VSa3jS9ch/S2AlflQv8fE94IYXOxfYp5
	WEoTm+KAdU4xHBdag7ELUZkadLGphSWMSs2QMv6CJ266RnmYHRlb3LRTMryyojoRKM5ZsCpK08A
	CscM+6I+djRsBcJpyFwtttrIP6knqVOee4X4WiFwQSpH3JCqgHhwIwS73LzYIjk9UdmXbiWYKh/
	hywlKH2MdltpCtUF4hsIZY3IBAzeX57hjWtlE4pSSnBLRQ5wCBqiP6bajLifGI9w==
X-Received: by 2002:a05:6830:81f8:b0:816:b03e:f9dc with SMTP id 46e09a7af769-81914e4d2d3mr10670082a34.5.1790619273058;
        Mon, 28 Sep 2026 11:14:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d583f8a58sm2365542a34.10.2026.09.28.11.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:32 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 10/11] bpf: Check global subprog memory arguments in the common path
Date: Mon, 28 Sep 2026 11:14:12 -0700
Message-ID: <20260928181414.644158-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
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
index 144da990ee8c..385a63edc095 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1649,6 +1649,9 @@ struct bpf_call_arg_meta {
 	struct ret_mem_desc ret_mem;
 	struct arg_raw_mem_desc arg_raw_mem;
 
+	/* Only set by subprog */
+	bool subprog_may_change_pkt;
+
 	/* Only set by kfunc */
 	bool r0_rdonly;
 	u32 kfunc_flags;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a39b23864878..2142610ce503 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7702,6 +7702,11 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
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
@@ -7720,10 +7725,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
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
@@ -9047,8 +9053,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		type &= ~PTR_MAYBE_NULL;
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
-	/* Allow allocated memory for kfunc ARG_PTR_TO_MEM but not helper. */
-	if (is_kfunc(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
+	/* Allow allocated memory for BTF-defined ARG_PTR_TO_MEM but not helpers. */
+	if (!is_helper(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
 	    type_is_ptr_alloc_obj(type))
 		type = PTR_TO_MEM;
 
@@ -9678,6 +9684,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
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
@@ -10817,6 +10834,9 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 			arg_type = ARG_IGNORE;
 		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			arg_type |= PTR_MAYBE_NULL;
+		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
+			proto->arg_size[arg] = sub->args[slot].mem_size;
+			arg_type |= MEM_FIXED_SIZE | MEM_WRITE;
 		} else if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
 			proto->arg_btf_id[arg] = &sub->args[slot].btf_id;
 		}
@@ -10832,7 +10852,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
-	struct bpf_verifier_log *log = &env->log;
 	const struct btf_param *args, *stack_args;
 	const struct btf_type *func, *func_proto;
 	struct bpf_call_arg_meta meta;
@@ -10842,6 +10861,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
 	memset(&meta, 0, sizeof(meta));
 	meta.btf = btf;
+	meta.subprog_may_change_pkt = sub->changes_pkt_data;
 	meta.func_name = bpf_subprog_name(env, subprog);
 
 	ret = btf_prepare_func_args(env, subprog);
@@ -10874,7 +10894,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	 * verifier sees.
 	 */
 	for (arg = 0, slot = 0; arg < btf_type_vlen(func_proto); arg++, slot += nslots) {
-		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, slot);
 		enum bpf_arg_type arg_type = fn->arg_type[arg];
 		argno_t argno = argno_from_arg(slot + 1);
 		const struct btf_type *t;
@@ -10886,34 +10905,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
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

