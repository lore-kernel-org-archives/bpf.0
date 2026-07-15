Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B448A2C7;
	Wed, 15 Jul 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129595; cv=none; b=h+SA5EmwbY4RwLdhjB6FJKiw6Z9cJZsM86kkilLVL3RA6WmKdCQxh6ErnmijVYQMLVxZfHnkHmuveftx5W5TmnmC31dGEXw5XnD+rPyiJ4Xy989b7BF7Mj8PnJ1VVrO75J3SnV4YgA0/alpKtzJnL7RvdL8prf9r2Y2hVHd4/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129595; c=relaxed/simple;
	bh=9NFtk8ipM5KJ5OP1JBTOlxmN1Tzjs3giweNqKYb9Idc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGkoCImyWxPl81APW+lBjUfmEsozu6gQzxi9/OMlx7AZDSx+z0Uds5ASz8noyFXLSBgbbUwaRjX5pL7BgfLFkpNMjdKrsBdanqyoRXDkhMKMlIR4AycAKjnP256Y/fNxjCFrcHeiskzMGp5QaV1yJ6euo9wDzPlBbuAnndEym3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TwX+kbk8; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TwX+kbk8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784129590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/0uouHnf4tZaE4/pH0JenhlmSOjwRyz40UPt6Vw/Yk=;
	b=TwX+kbk83qvTkC9W6LNi6sN+s7Dor42B2Ej60WBM5hqD2qUNRqCOkMkXF1pFZlGv2ld0/z
	HKKOrAT8SSdcC/WFfbE473zDm/ikJxUBTj1v84RFeupclEurykpefZMkRk/ofOXiaIkHMp
	Rqv06BtAhBpqV3GaAAMPRmPKtvxMdf0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v10 1/9] bpf: Drop duplicate blank lines in verifier
Date: Wed, 15 Jul 2026 23:32:45 +0800
Message-ID: <20260715153254.92010-2-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-1-leon.hwang@linux.dev>
References: <20260715153254.92010-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are many adjacent blank lines in the verifier that have accumulated
over time.

Drop them for cleanup.

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de816063ae63..e1244a721194 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -634,7 +634,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
 			      bool first_slot, int id, int parent_id);
 
-
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
@@ -1671,7 +1670,6 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
 	return true;
 }
 
-
 void bpf_free_backedges(struct bpf_scc_visit *visit)
 {
 	struct bpf_scc_backedge *backedge, *next;
@@ -2291,7 +2289,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	return &elem->st;
 }
 
-
 static int cmp_subprogs(const void *a, const void *b)
 {
 	return ((struct bpf_subprog_info *)a)->start -
@@ -4044,7 +4041,6 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	return err;
 }
 
-
 /* check_stack_write dispatches to check_stack_write_fixed_off or
  * check_stack_write_var_off.
  *
@@ -4840,7 +4836,6 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
 		valid = false;
 	}
 
-
 	if (valid) {
 		env->insn_aux_data[insn_idx].ctx_field_size =
 			info.ctx_field_size;
@@ -6683,7 +6678,6 @@ static int check_stack_range_initialized(
 	if (err)
 		return err;
 
-
 	if (tnum_is_const(reg->var_off)) {
 		min_off = max_off = reg->var_off.value + off;
 	} else {
@@ -7404,7 +7398,6 @@ static bool is_iter_new_kfunc(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_NEW;
 }
 
-
 static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ITER_DESTROY;
@@ -11539,7 +11532,6 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 	return 0;
 }
 
-
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct btf_record *rec = reg_btf_record(reg);
@@ -16421,7 +16413,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-
 static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
@@ -18363,8 +18354,6 @@ static void release_insn_arrays(struct bpf_verifier_env *env)
 		bpf_insn_array_release(env->insn_array_maps[i]);
 }
 
-
-
 /* The verifier does more data flow analysis than llvm and will not
  * explore branches that are dead at run time. Malicious programs can
  * have dead code too. Therefore replace all dead at-run-time code
@@ -18392,8 +18381,6 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 	}
 }
 
-
-
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl;
@@ -18675,7 +18662,6 @@ static int do_check_main(struct bpf_verifier_env *env)
 	return ret;
 }
 
-
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	/* Skip over hidden subprogs which are not verified. */
-- 
2.55.0

