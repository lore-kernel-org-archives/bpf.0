Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A790117C220
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932087; cv=none; b=vFyZzWjTfGtbXc4emkmflMeCZvMD+/qxXnTwnXXrgT19P5S3I7Px7/Zt0ppmCq4Q0sZ+SOBudpDYjFfA1mZZX3Dg4TX2ZM0+93hewVIHGWOdW+W0Fo9GcrpWGoJoKStxf+uV6kfKsU4gqwl5kiQ2CyXTCwCLKw6KFx690HoQEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932087; c=relaxed/simple;
	bh=K0J3KWlMw0hHCIesM9MKdKIiPkpiMvIlp1qVBNPuxWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7GCPQgZcUiNqJPj3EqR1HYMVye18yOWV8MIdCyn1rotf6iYGVoJGrnAPebhWKg01AqZ4lvXz/LspsUR/z9Gf3k9ShwGsxHk5nzmudIuGZPWSfbJPstVGmU1M6yQ1yy6y/QqMDCnExq0L+efEUMejzISP4AzwKrmFBMeQEC31nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm7ZFEC2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm7ZFEC2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso1321485ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770932083; x=1771536883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx4bKGta3kj8JRioLVnf+CiF9uc3rTwzVwoRdF0wE3k=;
        b=Zm7ZFEC2fM+uqwAqwnxKlNaBVl75epIdRMJHM8K1SUZtCBsfbkMJFfQ5oddOB3wsEs
         3x8IHFOO7IZ7tThqYVRdTJJTN4KM6JoEwaG7ns5by1nKQ8OB/Wnk2VePkAb6QpKVJa6B
         Dhic3kkrVWZJqH3eX5t5z6EEnEQ6I3uX5oQcxMxsxoGPtSxS4F8c/CihNqVq6gg3P7k4
         IDbkk8klaKag6iC4DFksqUJQJeCfM5aYM8dwoxh2LUUp4hXhibAgeoTYVu2BagXlR01C
         Z3/W07MZskpBXWieZUXrWnTLT+5ugWPyqFE5tq6sT1JZasAzS5h08SJAHzHgYB131plq
         gGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770932083; x=1771536883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bx4bKGta3kj8JRioLVnf+CiF9uc3rTwzVwoRdF0wE3k=;
        b=OoRJXH2ydNRToH+Z/wnKRC7hZ8RcqPhljj+hWCfFxiKjg0P8Bl6axN84230xzVVIGn
         ev7TS0Kj6QXjwJy4fMcFZQXma9qZiA9UVQf+jTOEsGe4JJQSwIYj3TiURzs9bRKOo0LX
         IzNMTTll6Xj0dDrl9lq0AdUXzdkqxEz79eBNa3iTbuZjmHov6T4zpWsfGdnBsZiOGB+f
         IvsmzThJnAPR8l+Pv5e9Y2KS5+qcfE16DIV5eNlPORXAKqxI4CCgozgwMI1wYQsXxuPS
         7KIa/utrtlm5l01NaLdd7EhSOUBrJajB6B3+o06oIUg4Ri5Gxa1h/Qiqfj1HvL8HsPts
         CTDQ==
X-Gm-Message-State: AOJu0YwzD5BYPd0hSD7Ju4K4Z0+RZ3ur6IPl3oWgzIig6TU4z/vBrKmJ
	DtMvrdtLL7MI+YXq1Ln7O9X9oqr6rhti63R83IZYATiHksQv5Na7Hn1cL5FTvLxB
X-Gm-Gg: AZuq6aIRNm5WMWryOJGIbO2ChIhDGCsecWEwfGEpJvqIcfHKaMj6uJYNbaA/HWQ8A+3
	tIDnfsBzHgceA1YBiRSMs3tkwf4AEnUzedsrK1GH3oX1Dw9SkXAhjn53IAgFu+vn8m442XZWf9e
	s3O90xFSHngNWZ/3Hnny9oLddizK9cVGVYi6ZPgJ5qedOclK0O6O1vL1xENlJtHeKe8TzK3mmqZ
	bVsusc8Xjv0DrqhhAIYRaoAyfU/sFo58c4P/XNm/15NMRWllThp1B3zZzXObZhTU4gwCftWAnZp
	ij8qy/fnW0AYon2LIS+Ty6CIMPDF3v4/NihDlfUIiAE0jYuJrpHmTCT3oBIGMasKpSA2EzIjQce
	o6THorb67T61RNqhhe+vMUkCj2MkB2s1ZByAhaBcfONKp0Rc1OId+rL8E8NLhYQVQLWihbjPSUP
	eAPqqQk4Bljdc05Nydnrbhv2JZ2KryAf7drv8rzHLhoyR3peN4
X-Received: by 2002:a17:903:2f84:b0:2a9:47d0:12cb with SMTP id d9443c01a7336-2ab4cf8e5e6mr3242605ad.22.1770932082072;
        Thu, 12 Feb 2026 13:34:42 -0800 (PST)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29979b13sm58728405ad.61.2026.02.12.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:34:41 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuba@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/4] bpf: use reg->var_off instead of reg->off for pointers
Date: Thu, 12 Feb 2026 13:34:22 -0800
Message-ID: <20260212-ptrs-off-migration-v2-2-00820e4d3438@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
References: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This commit consolidates static and varying pointer offset tracking
logic. All offsets are now represented solely using `.var_off` and
min/max fields. The reasons are twofold:
- This simplifies pointer tracking code, as each relevant function
  needs to check the `.var_off` field anyway.
- It makes it easier to widen pointer registers for the purpose of loop
  convergence checks, by forgoing the `regsafe()` logic demanding
  `.off` fields to be identical.

The changes are spread across many functions and are hard to group
into smaller patches. Some of the logical changes include:
- Checks in __check_ptr_off_reg() are reordered so that the
  tnum_is_const() check is done before operating on reg->var_off.value.
- check_packet_access() now uses check_mem_region_access() to handle
  possible 'off' overflow cases.
- In check_helper_mem_access() utility functions like
  check_packet_access() are now called with 'off=0', as these utility
  functions now account for the complete register offset range.
- In check_reg_type() a call to __check_ptr_off_reg() is added before
  a call to btf_struct_ids_match(). This prevents
  btf_struct_ids_match() from potentially working on non-constant
  reg->var_off.value.
- regsafe() is relaxed to avoid comparing '.off' field for pointers.

As a precaution, the changes are verified in [1] by adding a pass
checking that no pointer has non-zero '.off' field on each
do_check_insn() iteration.

[1] https://github.com/eddyz87/bpf/tree/ptrs-off-migration

Notable selftests changes:
- `.var_off` value changed because it now combines static and varying
  offsets. Affected tests:
  - linked_list/incorrect_node_var_off
  - linked_list/incorrect_head_var_off2
  - verifier_align/packet_variable_offset

- Overflowing `smax_value` bound leads to a pointer with big negative
  or positive offset to be rejected immediately (previously overflowing
  `rX += const` instruction updated `.off` field avoiding the overflow).
  Affected tests:
  - verifier_align/dubious_pointer_arithmetic
  - verifier_bounds/var_off_insn_off_test1

- Invalid access to packet now reports full offset inside a packet.
  Affected tests:
  - verifier_direct_packet_access/test23_x_pkt_ptr_4

- A change in check_mem_region_access() behavior:
  when register `.smin_value` is negative, it reports
  "rX min value is negative..." before calling into __check_mem_access()
  which reports "invalid access to ...".
  In the tests below, the `.off` field was negative, while `.smin_value`
  remained positive. This is no longer the case after the changes in
  this commit. Affected tests:
  - verifier_gotox/jump_table_invalid_mem_acceess_neg
  - verifier_helper_packet_access/test15_cls_helper_fail_sub
  - verifier_helper_value_access/imm_out_of_bound_2
  - verifier_helper_value_access/reg_out_of_bound_2
  - verifier_meta_access/meta_access_test2
  - verifier_value_ptr_arith/known_scalar_from_different_maps
  - lower_oob_arith_test_1
  - value_ptr_known_scalar_3
  - access_value_ptr_known_scalar

- Usage of check_mem_region_access() instead of __check_mem_access()
  in check_packet_access() changes the reported message from
  "rX offset is outside ..." to "rX min/max value is outside ...".
  Affected tests:
  - verifier_xdp_direct_packet_access/*

- In check_func_arg_reg_off() the check for zero offset now operates
  on `.var_off` field instead of `.off` field. For tests where the
  pattern looks like `kfunc(reg_with_var_off, ...)`, this changes the
  reported error:
  - previously the error "variable ... access ... disallowed"
    was reported by __check_ptr_off_reg();
  - now "R1 must have zero offset ..." is reported by
    check_func_arg_reg_off() itself.
  Affected tests:
  - verifier/calls.c
    "calls: invalid kfunc call: PTR_TO_BTF_ID with variable offset"

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                       |   3 +-
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/verifier.c                              | 317 ++++++++-------------
 .../testing/selftests/bpf/prog_tests/linked_list.c |   4 +-
 .../selftests/bpf/progs/exceptions_assert.c        |   2 +-
 tools/testing/selftests/bpf/progs/iters.c          |   6 +-
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |   2 +-
 tools/testing/selftests/bpf/progs/verifier_align.c |  40 ++-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   2 +-
 .../bpf/progs/verifier_direct_packet_access.c      |   4 +-
 tools/testing/selftests/bpf/progs/verifier_gotox.c |   4 +-
 .../bpf/progs/verifier_helper_packet_access.c      |   2 +-
 .../bpf/progs/verifier_helper_value_access.c       |   4 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c |   2 +-
 .../selftests/bpf/progs/verifier_meta_access.c     |   2 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |   8 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   4 +-
 .../selftests/bpf/progs/verifier_value_ptr_arith.c |  10 +-
 .../bpf/progs/verifier_xdp_direct_packet_access.c  |  64 ++---
 tools/testing/selftests/bpf/verifier/calls.c       |   2 +-
 20 files changed, 206 insertions(+), 278 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ef8e45a362d96701efbc1d24539501f339d41def..a97bdbf3a07b63246ebf2021816e81c147989381 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -38,8 +38,7 @@ struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
 	/*
-	 * Fixed part of pointer offset, pointer types only.
-	 * Or constant delta between "linked" scalars with the same ID.
+	 * Constant delta between "linked" scalars with the same ID.
 	 */
 	s32 off;
 	union {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a0c3b35de2ce65c488277c3c214f2a3c8185af5e..39a731392d6520a1345fc3d79e86fc43f63e426a 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -581,6 +581,8 @@ int tnum_strn(char *str, size_t size, struct tnum a)
 	if (a.mask == 0) {
 		if (is_unum_decimal(a.value))
 			return snprintf(str, size, "%llu", a.value);
+		if (is_snum_decimal(a.value))
+			return snprintf(str, size, "%lld", a.value);
 		else
 			return snprintf(str, size, "%#llx", a.value);
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3bf72eacbec2407fc79e22f62098755415bdf61c..2c5794dad66889b7f872aa9882652efae877ac1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -654,7 +654,7 @@ static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, struct bpf_reg_s
 		return -EINVAL;
 	}
 
-	off = reg->off + reg->var_off.value;
+	off = reg->var_off.value;
 	if (off % BPF_REG_SIZE) {
 		verbose(env, "cannot pass in %s at an offset=%d\n", obj_kind, off);
 		return -EINVAL;
@@ -2281,11 +2281,10 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 static void mark_reg_graph_node(struct bpf_reg_state *regs, u32 regno,
 				struct btf_field_graph_root *ds_head)
 {
-	__mark_reg_known_zero(&regs[regno]);
+	__mark_reg_known(&regs[regno], ds_head->node_offset);
 	regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC;
 	regs[regno].btf = ds_head->btf;
 	regs[regno].btf_id = ds_head->value_btf_id;
-	regs[regno].off = ds_head->node_offset;
 }
 
 static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
@@ -2316,7 +2315,6 @@ static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
 	 */
 	return reg->type == which &&
 	       reg->id == 0 &&
-	       reg->off == 0 &&
 	       tnum_equals_const(reg->var_off, 0);
 }
 
@@ -5302,7 +5300,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
  * tracks the effects of the write, considering that each stack slot in the
  * dynamic range is potentially written to.
  *
- * 'off' includes 'regno->off'.
  * 'value_regno' can be -1, meaning that an unknown value is being written to
  * the stack.
  *
@@ -5724,7 +5721,6 @@ static int check_stack_read(struct bpf_verifier_env *env,
  * check_stack_write_var_off.
  *
  * 'ptr_regno' is the register used as a pointer into the stack.
- * 'off' includes 'ptr_regno->off', but not its variable offset (if any).
  * 'value_regno' is the register whose value we're writing to the stack. It can
  * be -1, meaning that we're not writing from a register.
  *
@@ -5761,14 +5757,14 @@ static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
 	u32 cap = bpf_map_flags_to_cap(map);
 
 	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
-		verbose(env, "write into map forbidden, value_size=%d off=%d size=%d\n",
-			map->value_size, off, size);
+		verbose(env, "write into map forbidden, value_size=%d off=%lld size=%d\n",
+			map->value_size, reg->smin_value + off, size);
 		return -EACCES;
 	}
 
 	if (type == BPF_READ && !(cap & BPF_MAP_CAN_READ)) {
-		verbose(env, "read from map forbidden, value_size=%d off=%d size=%d\n",
-			map->value_size, off, size);
+		verbose(env, "read from map forbidden, value_size=%d off=%lld size=%d\n",
+			map->value_size, reg->smin_value + off, size);
 		return -EACCES;
 	}
 
@@ -5875,24 +5871,24 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	 * is only allowed in its original, unmodified form.
 	 */
 
-	if (reg->off < 0) {
-		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
-			reg_type_str(env, reg->type), regno, reg->off);
+	if (!tnum_is_const(reg->var_off)) {
+		char tn_buf[48];
+
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose(env, "variable %s access var_off=%s disallowed\n",
+			reg_type_str(env, reg->type), tn_buf);
 		return -EACCES;
 	}
 
-	if (!fixed_off_ok && reg->off) {
-		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
-			reg_type_str(env, reg->type), regno, reg->off);
+	if (reg->smin_value < 0) {
+		verbose(env, "negative offset %s ptr R%d off=%lld disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->var_off.value);
 		return -EACCES;
 	}
 
-	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
-		char tn_buf[48];
-
-		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "variable %s access var_off=%s disallowed\n",
-			reg_type_str(env, reg->type), tn_buf);
+	if (!fixed_off_ok && reg->var_off.value != 0) {
+		verbose(env, "dereference of modified %s ptr R%d off=%lld disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->var_off.value);
 		return -EACCES;
 	}
 
@@ -5934,14 +5930,14 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	/* For ref_ptr case, release function check should ensure we get one
 	 * referenced PTR_TO_BTF_ID, and that its fixed offset is 0. For the
 	 * normal store of unreferenced kptr, we must ensure var_off is zero.
-	 * Since ref_ptr cannot be accessed directly by BPF insns, checks for
-	 * reg->off and reg->ref_obj_id are not needed here.
+	 * Since ref_ptr cannot be accessed directly by BPF insns, check for
+	 * reg->ref_obj_id is not needed here.
 	 */
 	if (__check_ptr_off_reg(env, reg, regno, true))
 		return -EACCES;
 
 	/* A full type match is needed, as BTF can be vmlinux, module or prog BTF, and
-	 * we also need to take into account the reg->off.
+	 * we also need to take into account the reg->var_off.
 	 *
 	 * We want to support cases like:
 	 *
@@ -5952,19 +5948,19 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	 *
 	 * struct foo *v;
 	 * v = func();	      // PTR_TO_BTF_ID
-	 * val->foo = v;      // reg->off is zero, btf and btf_id match type
-	 * val->bar = &v->br; // reg->off is still zero, but we need to retry with
+	 * val->foo = v;      // reg->var_off is zero, btf and btf_id match type
+	 * val->bar = &v->br; // reg->var_off is still zero, but we need to retry with
 	 *                    // first member type of struct after comparison fails
-	 * val->baz = &v->bz; // reg->off is non-zero, so struct needs to be walked
+	 * val->baz = &v->bz; // reg->var_off is non-zero, so struct needs to be walked
 	 *                    // to match type
 	 *
-	 * In the kptr_ref case, check_func_arg_reg_off already ensures reg->off
+	 * In the kptr_ref case, check_func_arg_reg_off already ensures reg->var_off
 	 * is zero. We must also ensure that btf_struct_ids_match does not walk
 	 * the struct to match type against first member of struct, i.e. reject
 	 * second case from above. Hence, when type is BPF_KPTR_REF, we set
 	 * strict mode to true for type match.
 	 */
-	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
+	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->var_off.value,
 				  kptr_field->kptr.btf, kptr_field->kptr.btf_id,
 				  kptr_field->type != BPF_KPTR_UNREF))
 		goto bad_type;
@@ -6273,27 +6269,14 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
 
-	/* We may have added a variable offset to the packet pointer; but any
-	 * reg->range we have comes after that.  We are only checking the fixed
-	 * offset.
-	 */
-
-	/* We don't allow negative numbers, because we aren't tracking enough
-	 * detail to prove they're safe.
-	 */
-	if (reg->smin_value < 0) {
-		verbose(env, "R%d min value is negative, either use unsigned index or do a if (index >=0) check.\n",
-			regno);
-		return -EACCES;
+	if (reg->range < 0) {
+		verbose(env, "R%d offset is outside of the packet\n", regno);
+		return -EINVAL;
 	}
 
-	err = reg->range < 0 ? -EINVAL :
-	      __check_mem_access(env, regno, off, size, reg->range,
-				 zero_size_allowed);
-	if (err) {
-		verbose(env, "R%d offset is outside of the packet\n", regno);
+	err = check_mem_region_access(env, regno, off, size, reg->range, zero_size_allowed);
+	if (err)
 		return err;
-	}
 
 	/* __check_mem_access has made sure "off + size - 1" is within u16.
 	 * reg->umax_value can't be bigger than MAX_PACKET_OFF which is 0xffff,
@@ -6305,7 +6288,7 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 		max_t(u32, env->prog->aux->max_pkt_offset,
 		      off + reg->umax_value + size - 1);
 
-	return err;
+	return 0;
 }
 
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
@@ -6522,14 +6505,14 @@ static int check_pkt_ptr_alignment(struct bpf_verifier_env *env,
 	 */
 	ip_align = 2;
 
-	reg_off = tnum_add(reg->var_off, tnum_const(ip_align + reg->off + off));
+	reg_off = tnum_add(reg->var_off, tnum_const(ip_align + off));
 	if (!tnum_is_aligned(reg_off, size)) {
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env,
-			"misaligned packet access off %d+%s+%d+%d size %d\n",
-			ip_align, tn_buf, reg->off, off, size);
+			"misaligned packet access off %d+%s+%d size %d\n",
+			ip_align, tn_buf, off, size);
 		return -EACCES;
 	}
 
@@ -6547,13 +6530,13 @@ static int check_generic_ptr_alignment(struct bpf_verifier_env *env,
 	if (!strict || size == 1)
 		return 0;
 
-	reg_off = tnum_add(reg->var_off, tnum_const(reg->off + off));
+	reg_off = tnum_add(reg->var_off, tnum_const(off));
 	if (!tnum_is_aligned(reg_off, size)) {
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "misaligned %saccess off %s+%d+%d size %d\n",
-			pointer_desc, tn_buf, reg->off, off, size);
+		verbose(env, "misaligned %saccess off %s+%d size %d\n",
+			pointer_desc, tn_buf, off, size);
 		return -EACCES;
 	}
 
@@ -6891,7 +6874,7 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 			regno, buf_info, off, size);
 		return -EACCES;
 	}
-	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
+	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
@@ -6914,8 +6897,8 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	if (off + size > env->prog->aux->max_tp_access)
-		env->prog->aux->max_tp_access = off + size;
+	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
+					    env->prog->aux->max_tp_access);
 
 	return 0;
 }
@@ -6933,8 +6916,7 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	if (off + size > *max_access)
-		*max_access = off + size;
+	*max_access = max(reg->var_off.value + off + size, *max_access);
 
 	return 0;
 }
@@ -7327,13 +7309,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			tname);
 		return -EINVAL;
 	}
-	if (off < 0) {
-		verbose(env,
-			"R%d is ptr_%s invalid negative access: off=%d\n",
-			regno, tname, off);
-		return -EACCES;
-	}
-	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
+
+	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
@@ -7343,6 +7320,15 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	off += reg->var_off.value;
+
+	if (off < 0) {
+		verbose(env,
+			"R%d is ptr_%s invalid negative access: off=%d\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	if (reg->type & MEM_USER) {
 		verbose(env,
 			"R%d is ptr_%s access user memory: off=%d\n",
@@ -7589,8 +7575,8 @@ static int check_stack_access_within_bounds(
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
-			verbose(env, "invalid%s stack R%d off=%d size=%d\n",
-				err_extra, regno, off, access_size);
+			verbose(env, "invalid%s stack R%d off=%lld size=%d\n",
+				err_extra, regno, min_off, access_size);
 		} else {
 			char tn_buf[48];
 
@@ -7636,14 +7622,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	if (size < 0)
 		return size;
 
-	/* alignment checks will add in reg->off themselves */
 	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
 	if (err)
 		return err;
 
-	/* for access checks, reg->off is just part of off */
-	off += reg->off;
-
 	if (reg->type == PTR_TO_MAP_KEY) {
 		if (t == BPF_WRITE) {
 			verbose(env, "write to change key R%d not allowed\n", regno);
@@ -8122,8 +8104,6 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
  * on the access type and privileges, that all elements of the stack are
  * initialized.
  *
- * 'off' includes 'regno->off', but not its dynamic part (if any).
- *
  * All registers that have been spilled on the stack in the slots within the
  * read offsets are marked as read.
  */
@@ -8284,7 +8264,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	switch (base_type(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
-		return check_packet_access(env, regno, reg->off, access_size,
+		return check_packet_access(env, regno, 0, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
 		if (access_type == BPF_WRITE) {
@@ -8292,12 +8272,12 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				reg_type_str(env, reg->type));
 			return -EACCES;
 		}
-		return check_mem_region_access(env, regno, reg->off, access_size,
+		return check_mem_region_access(env, regno, 0, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access_type(env, regno, reg->off, access_size, access_type))
+		if (check_map_access_type(env, regno, 0, access_size, access_type))
 			return -EACCES;
-		return check_map_access(env, regno, reg->off, access_size,
+		return check_map_access(env, regno, 0, access_size,
 					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
@@ -8307,7 +8287,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				return -EACCES;
 			}
 		}
-		return check_mem_region_access(env, regno, reg->off,
+		return check_mem_region_access(env, regno, 0,
 					       access_size, reg->mem_size,
 					       zero_size_allowed);
 	case PTR_TO_BUF:
@@ -8322,16 +8302,16 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		} else {
 			max_access = &env->prog->aux->max_rdwr_access;
 		}
-		return check_buffer_access(env, reg, regno, reg->off,
+		return check_buffer_access(env, reg, regno, 0,
 					   access_size, zero_size_allowed,
 					   max_access);
 	case PTR_TO_STACK:
 		return check_stack_range_initialized(
 				env,
-				regno, reg->off, access_size,
+				regno, 0, access_size,
 				zero_size_allowed, access_type, meta);
 	case PTR_TO_BTF_ID:
-		return check_ptr_to_btf_access(env, regs, regno, reg->off,
+		return check_ptr_to_btf_access(env, regs, regno, 0,
 					       access_size, BPF_READ, -1);
 	case PTR_TO_CTX:
 		/* in case the function doesn't know how to access the context,
@@ -8543,9 +8523,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 		return -EINVAL;
 	}
 	spin_lock_off = is_res_lock ? rec->res_spin_lock_off : rec->spin_lock_off;
-	if (spin_lock_off != val + reg->off) {
+	if (spin_lock_off != val) {
 		verbose(env, "off %lld doesn't point to 'struct %s_lock' that is at %d\n",
-			val + reg->off, lock_str, spin_lock_off);
+			val, lock_str, spin_lock_off);
 		return -EINVAL;
 	}
 	if (is_lock) {
@@ -8660,9 +8640,9 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 		verifier_bug(env, "unsupported BTF field type: %s\n", struct_name);
 		return -EINVAL;
 	}
-	if (field_off != val + reg->off) {
+	if (field_off != val) {
 		verbose(env, "off %lld doesn't point to 'struct %s' that is at %d\n",
-			val + reg->off, struct_name, field_off);
+			val, struct_name, field_off);
 		return -EINVAL;
 	}
 	if (map_desc->ptr) {
@@ -8730,7 +8710,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 
-	kptr_off = reg->off + reg->var_off.value;
+	kptr_off = reg->var_off.value;
 	kptr_field = btf_record_find(rec, kptr_off, BPF_KPTR);
 	if (!kptr_field) {
 		verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
@@ -9373,7 +9353,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
-	int i, j;
+	int i, j, err;
 
 	compatible = compatible_reg_types[base_type(arg_type)];
 	if (!compatible) {
@@ -9476,8 +9456,12 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				return -EACCES;
 			}
 
-			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
-						  btf_vmlinux, *arg_btf_id,
+			err = __check_ptr_off_reg(env, reg, regno, true);
+			if (err)
+				return err;
+
+			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id,
+						  reg->var_off.value, btf_vmlinux, *arg_btf_id,
 						  strict_type_match)) {
 				verbose(env, "R%d is of type %s but %s is expected\n",
 					regno, btf_type_name(reg->btf, reg->btf_id),
@@ -9555,12 +9539,11 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		 * because fixed_off_ok is false, but checking here allows us
 		 * to give the user a better error message.
 		 */
-		if (reg->off) {
+		if (!tnum_is_const(reg->var_off) || reg->var_off.value != 0) {
 			verbose(env, "R%d must have zero offset when passed to release func or trusted arg to kfunc\n",
 				regno);
 			return -EINVAL;
 		}
-		return __check_ptr_off_reg(env, reg, regno, false);
 	}
 
 	switch (type) {
@@ -9657,7 +9640,7 @@ static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return reg->dynptr.type;
 
-	spi = __get_spi(reg->off);
+	spi = __get_spi(reg->var_off.value);
 	if (spi < 0) {
 		verbose(env, "verifier internal error: invalid spi when querying dynptr type\n");
 		return BPF_DYNPTR_TYPE_INVALID;
@@ -9698,13 +9681,13 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	err = check_map_access(env, regno, reg->off,
-			       map->value_size - reg->off, false,
+	err = check_map_access(env, regno, 0,
+			       map->value_size - reg->var_off.value, false,
 			       ACCESS_HELPER);
 	if (err)
 		return err;
 
-	map_off = reg->off + reg->var_off.value;
+	map_off = reg->var_off.value;
 	err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
 	if (err) {
 		verbose(env, "direct value access on string failed\n");
@@ -9741,7 +9724,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	if (!tnum_is_const(key->var_off))
 		return -EOPNOTSUPP;
 
-	stack_off = key->off + key->var_off.value;
+	stack_off = key->var_off.value;
 	slot = -stack_off - 1;
 	spi = slot / BPF_REG_SIZE;
 	off = slot % BPF_REG_SIZE;
@@ -11073,7 +11056,8 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 	 */
 	struct btf_field *field;
 
-	field = reg_find_field_offset(&caller->regs[BPF_REG_1], caller->regs[BPF_REG_1].off,
+	field = reg_find_field_offset(&caller->regs[BPF_REG_1],
+				      caller->regs[BPF_REG_1].var_off.value,
 				      BPF_RB_ROOT);
 	if (!field || !field->graph_root.value_btf_id)
 		return -EFAULT;
@@ -11449,7 +11433,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	/* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
 	 * and map_direct_value_addr is set.
 	 */
-	fmt_map_off = fmt_reg->off + fmt_reg->var_off.value;
+	fmt_map_off = fmt_reg->var_off.value;
 	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
 						  fmt_map_off);
 	if (err) {
@@ -12755,13 +12739,12 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
 		strict_type_match = true;
 
-	WARN_ON_ONCE(is_kfunc_release(meta) &&
-		     (reg->off || !tnum_is_const(reg->var_off) ||
-		      reg->var_off.value));
+	WARN_ON_ONCE(is_kfunc_release(meta) && !tnum_is_const(reg->var_off));
 
 	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
 	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
-	struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match);
+	struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->var_off.value,
+					   meta->btf, ref_id, strict_type_match);
 	/* If kfunc is accepting a projection type (ie. __sk_buff), it cannot
 	 * actually use it -- it must cast to the underlying type. So we allow
 	 * caller to pass in the underlying type.
@@ -13133,7 +13116,7 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
 	}
 
 	rec = reg_btf_record(reg);
-	head_off = reg->off + reg->var_off.value;
+	head_off = reg->var_off.value;
 	field = btf_record_find(rec, head_off, head_field_type);
 	if (!field) {
 		verbose(env, "%s not found at offset=%u\n", head_type_name, head_off);
@@ -13200,7 +13183,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	node_off = reg->off + reg->var_off.value;
+	node_off = reg->var_off.value;
 	field = reg_find_field_offset(reg, node_off, node_field_type);
 	if (!field) {
 		verbose(env, "%s not found at offset=%u\n", node_type_name, node_off);
@@ -14228,7 +14211,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
-		insn_aux->insert_off = regs[BPF_REG_2].off;
+		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
 		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
 		err = ref_convert_owning_non_owning(env, release_ref_obj_id);
 		if (err) {
@@ -14459,11 +14442,13 @@ static bool check_reg_sane_offset_ptr(struct bpf_verifier_env *env,
 				      const struct bpf_reg_state *reg,
 				      enum bpf_reg_type type)
 {
+	bool known = tnum_is_const(reg->var_off);
+	s64 val = reg->var_off.value;
 	s64 smin = reg->smin_value;
 
-	if (reg->off >= BPF_MAX_VAR_OFF || reg->off <= -BPF_MAX_VAR_OFF) {
-		verbose(env, "%s pointer offset %d is not allowed\n",
-			reg_type_str(env, type), reg->off);
+	if (known && (val >= BPF_MAX_VAR_OFF || val <= -BPF_MAX_VAR_OFF)) {
+		verbose(env, "%s pointer offset %lld is not allowed\n",
+			reg_type_str(env, type), val);
 		return false;
 	}
 
@@ -14497,13 +14482,11 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 		 * currently prohibited for unprivileged.
 		 */
 		max = MAX_BPF_STACK + mask_to_left;
-		ptr_limit = -(ptr_reg->var_off.value + ptr_reg->off);
+		ptr_limit = -ptr_reg->var_off.value;
 		break;
 	case PTR_TO_MAP_VALUE:
 		max = ptr_reg->map_ptr->value_size;
-		ptr_limit = (mask_to_left ?
-			     ptr_reg->smin_value :
-			     ptr_reg->umax_value) + ptr_reg->off;
+		ptr_limit = mask_to_left ? ptr_reg->smin_value : ptr_reg->umax_value;
 		break;
 	default:
 		return REASON_TYPE;
@@ -14734,9 +14717,6 @@ static int sanitize_err(struct bpf_verifier_env *env,
  * Variable offset is prohibited for unprivileged mode for simplicity since it
  * requires corresponding support in Spectre masking for stack ALU.  See also
  * retrieve_ptr_limit().
- *
- *
- * 'off' includes 'reg->off'.
  */
 static int check_stack_access_for_ptr_arithmetic(
 				struct bpf_verifier_env *env,
@@ -14777,11 +14757,11 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 	switch (dst_reg->type) {
 	case PTR_TO_STACK:
 		if (check_stack_access_for_ptr_arithmetic(env, dst, dst_reg,
-					dst_reg->off + dst_reg->var_off.value))
+							  dst_reg->var_off.value))
 			return -EACCES;
 		break;
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access(env, dst, dst_reg->off, 1, false, ACCESS_HELPER)) {
+		if (check_map_access(env, dst, 0, 1, false, ACCESS_HELPER)) {
 			verbose(env, "R%d pointer arithmetic of map value goes out of range, "
 				"prohibited for !root\n", dst);
 			return -EACCES;
@@ -14905,23 +14885,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 
 	switch (opcode) {
 	case BPF_ADD:
-		/* We can take a fixed offset as long as it doesn't overflow
-		 * the s32 'off' field
-		 */
-		if (known && (ptr_reg->off + smin_val ==
-			      (s64)(s32)(ptr_reg->off + smin_val))) {
-			/* pointer += K.  Accumulate it into fixed offset */
-			dst_reg->smin_value = smin_ptr;
-			dst_reg->smax_value = smax_ptr;
-			dst_reg->umin_value = umin_ptr;
-			dst_reg->umax_value = umax_ptr;
-			dst_reg->var_off = ptr_reg->var_off;
-			dst_reg->off = ptr_reg->off + smin_val;
-			dst_reg->raw = ptr_reg->raw;
-			break;
-		}
-		/* A new variable offset is created.  Note that off_reg->off
-		 * == 0, since it's a scalar.
+		/*
 		 * dst_reg gets the pointer type and since some positive
 		 * integer value was added to the pointer, give it a new 'id'
 		 * if it's a PTR_TO_PACKET.
@@ -14940,9 +14904,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->umax_value = U64_MAX;
 		}
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
-		dst_reg->off = ptr_reg->off;
 		dst_reg->raw = ptr_reg->raw;
-		if (reg_is_pkt_pointer(ptr_reg)) {
+		if (!known && reg_is_pkt_pointer(ptr_reg)) {
 			dst_reg->id = ++env->id_gen;
 			/* something was added to pkt_ptr, set range to zero */
 			memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
@@ -14964,19 +14927,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				dst);
 			return -EACCES;
 		}
-		if (known && (ptr_reg->off - smin_val ==
-			      (s64)(s32)(ptr_reg->off - smin_val))) {
-			/* pointer -= K.  Subtract it from fixed offset */
-			dst_reg->smin_value = smin_ptr;
-			dst_reg->smax_value = smax_ptr;
-			dst_reg->umin_value = umin_ptr;
-			dst_reg->umax_value = umax_ptr;
-			dst_reg->var_off = ptr_reg->var_off;
-			dst_reg->id = ptr_reg->id;
-			dst_reg->off = ptr_reg->off - smin_val;
-			dst_reg->raw = ptr_reg->raw;
-			break;
-		}
 		/* A new variable offset is created.  If the subtrahend is known
 		 * nonnegative, then any reg->range we had before is still good.
 		 */
@@ -14996,9 +14946,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->umax_value = umax_ptr - umin_val;
 		}
 		dst_reg->var_off = tnum_sub(ptr_reg->var_off, off_reg->var_off);
-		dst_reg->off = ptr_reg->off;
 		dst_reg->raw = ptr_reg->raw;
-		if (reg_is_pkt_pointer(ptr_reg)) {
+		if (!known && reg_is_pkt_pointer(ptr_reg)) {
 			dst_reg->id = ++env->id_gen;
 			/* something was added to pkt_ptr, set range to zero */
 			if (smin_val < 0)
@@ -16542,19 +16491,17 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	struct bpf_reg_state *reg;
 	int new_range;
 
-	if (dst_reg->off < 0 ||
-	    (dst_reg->off == 0 && range_right_open))
+	if (dst_reg->umax_value == 0 && range_right_open)
 		/* This doesn't give us any range */
 		return;
 
-	if (dst_reg->umax_value > MAX_PACKET_OFF ||
-	    dst_reg->umax_value + dst_reg->off > MAX_PACKET_OFF)
+	if (dst_reg->umax_value > MAX_PACKET_OFF)
 		/* Risk of overflow.  For instance, ptr + (1<<63) may be less
 		 * than pkt_end, but that's because it's also less than pkt.
 		 */
 		return;
 
-	new_range = dst_reg->off;
+	new_range = dst_reg->umax_value;
 	if (range_right_open)
 		new_range++;
 
@@ -16603,7 +16550,7 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	/* If our ids match, then we must have the same max_value.  And we
 	 * don't care about the other reg's fixed offset, since if it's too big
 	 * the range won't allow anything.
-	 * dst_reg->off is known < MAX_PACKET_OFF, therefore it fits in a u16.
+	 * dst_reg->umax_value is known < MAX_PACKET_OFF, therefore it fits in a u16.
 	 */
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		if (reg->type == type && reg->id == dst_reg->id)
@@ -17129,29 +17076,24 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    (is_rcu_reg(reg) || !WARN_ON_ONCE(!reg->id))) {
-		/* Old offset (both fixed and variable parts) should have been
-		 * known-zero, because we don't allow pointer arithmetic on
-		 * pointers that might be NULL. If we see this happening, don't
-		 * convert the register.
+		/* Old offset should have been known-zero, because we don't
+		 * allow pointer arithmetic on pointers that might be NULL.
+		 * If we see this happening, don't convert the register.
 		 *
 		 * But in some cases, some helpers that return local kptrs
-		 * advance offset for the returned pointer. In those cases, it
-		 * is fine to expect to see reg->off.
+		 * advance offset for the returned pointer. In those cases,
+		 * it is fine to expect to see reg->var_off.
 		 */
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
-			return;
 		if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->type)) &&
-		    WARN_ON_ONCE(reg->off))
+		    WARN_ON_ONCE(!tnum_equals_const(reg->var_off, 0)))
 			return;
-
 		if (is_null) {
-			reg->type = SCALAR_VALUE;
 			/* We don't need id and ref_obj_id from this point
 			 * onwards anymore, thus we should better reset it,
 			 * so that state pruning has chances to take effect.
 			 */
-			reg->id = 0;
-			reg->ref_obj_id = 0;
+			__mark_reg_known_zero(reg);
+			reg->type = SCALAR_VALUE;
 
 			return;
 		}
@@ -17731,22 +17673,24 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	}
 
 	map = env->used_maps[aux->map_index];
-	dst_reg->map_ptr = map;
 
 	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		if (map->map_type == BPF_MAP_TYPE_ARENA) {
 			__mark_reg_unknown(env, dst_reg);
+			dst_reg->map_ptr = map;
 			return 0;
 		}
+		__mark_reg_known(dst_reg, aux->map_off);
 		dst_reg->type = PTR_TO_MAP_VALUE;
-		dst_reg->off = aux->map_off;
+		dst_reg->map_ptr = map;
 		WARN_ON_ONCE(map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
 			     map->max_entries != 1);
 		/* We want reg->id to be same (0) as map_value is not distinct */
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type = CONST_PTR_TO_MAP;
+		dst_reg->map_ptr = map;
 	} else {
 		verifier_bug(env, "unexpected src reg value for ldimm64");
 		return -EFAULT;
@@ -19852,11 +19796,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 */
 		if (rold->range > rcur->range)
 			return false;
-		/* If the offsets don't match, we can't trust our alignment;
-		 * nor can we be sure that we won't fall out of range.
-		 */
-		if (rold->off != rcur->off)
-			return false;
 		/* id relations must be preserved */
 		if (!check_ids(rold->id, rcur->id, idmap))
 			return false;
@@ -19872,8 +19811,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return true;
 	case PTR_TO_INSN:
 		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
-			rold->off == rcur->off && range_within(rold, rcur) &&
-			tnum_in(rold->var_off, rcur->var_off);
+		       range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
 	default:
 		return regs_exact(rold, rcur, idmap);
 	}
@@ -20486,7 +20424,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					 * so we can assume valid iter and reg state,
 					 * no need for extra (re-)validations
 					 */
-					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
+					spi = __get_spi(iter_reg->var_off.value);
 					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
 						loop = true;
@@ -20892,19 +20830,16 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
 				       u32 *pmin_index, u32 *pmax_index)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
-	u64 min_index, max_index;
+	u64 min_index = reg->umin_value;
+	u64 max_index = reg->umax_value;
 	const u32 size = 8;
 
-	if (check_add_overflow(reg->umin_value, reg->off, &min_index) ||
-		(min_index > (u64) U32_MAX * size)) {
-		verbose(env, "the sum of R%u umin_value %llu and off %u is too big\n",
-			     regno, reg->umin_value, reg->off);
+	if (min_index > (u64) U32_MAX * size) {
+		verbose(env, "the sum of R%u umin_value %llu is too big\n", regno, reg->umin_value);
 		return -ERANGE;
 	}
-	if (check_add_overflow(reg->umax_value, reg->off, &max_index) ||
-		(max_index > (u64) U32_MAX * size)) {
-		verbose(env, "the sum of R%u umax_value %llu and off %u is too big\n",
-			     regno, reg->umax_value, reg->off);
+	if (max_index > (u64) U32_MAX * size) {
+		verbose(env, "the sum of R%u umax_value %llu is too big\n", regno, reg->umax_value);
 		return -ERANGE;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 14c5a7ef0e87d0c2cedf04a3b4fd7bd8419b9c43..6f25b5f39a79cd2e2547638a7726f444d81c1543 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -87,12 +87,12 @@ static struct {
 	{ "incorrect_value_type",
 	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=48 in struct foo, "
 	  "but arg is at offset=0 in struct bar" },
-	{ "incorrect_node_var_off", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
+	{ "incorrect_node_var_off", "variable ptr_ access var_off=(0x0; 0x1ffffffff) disallowed" },
 	{ "incorrect_node_off1", "bpf_list_node not found at offset=49" },
 	{ "incorrect_node_off2", "arg#1 offset=0, but expected bpf_list_node at offset=48 in struct foo" },
 	{ "no_head_type", "bpf_list_head not found at offset=0" },
 	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
-	{ "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
+	{ "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0x1ffffffff) disallowed" },
 	{ "incorrect_head_off1", "bpf_list_head not found at offset=25" },
 	{ "incorrect_head_off2", "bpf_list_head not found at offset=1" },
 	{ "pop_front_off", "off 48 doesn't point to 'struct bpf_spin_lock' that is at 40" },
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index a01c2736890f9482e5a16bc943e7d877600149c2..ed00dd551ffb290f05753b15ce1bbde71b3dc19d 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -114,7 +114,7 @@ int check_assert_single_range_u64(struct __sk_buff *ctx)
 
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R1=pkt(off=64,r=64) R2=pkt_end() R6=pkt(r=64) R10=fp0")
+__msg(": R1=pkt(r=64,imm=64) R2=pkt_end() R6=pkt(r=64) R10=fp0")
 int check_assert_generic(struct __sk_buff *ctx)
 {
 	u8 *data_end = (void *)(long)ctx->data_end;
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 7f27b517d5d5668a0d2204cb8f9a0632806c3959..86b74e3579d9d5f72b8634804becde22c491a452 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1651,7 +1651,7 @@ int clean_live_states(const void *ctx)
 
 SEC("?raw_tp")
 __flag(BPF_F_TEST_STATE_FREQ)
-__failure __msg("misaligned stack access off 0+-31+0 size 8")
+__failure __msg("misaligned stack access off -31+0 size 8")
 __naked int absent_mark_in_the_middle_state(void)
 {
 	/* This is equivalent to C program below.
@@ -1726,7 +1726,7 @@ static int noop(void)
 
 SEC("?raw_tp")
 __flag(BPF_F_TEST_STATE_FREQ)
-__failure __msg("misaligned stack access off 0+-31+0 size 8")
+__failure __msg("misaligned stack access off -31+0 size 8")
 __naked int absent_mark_in_the_middle_state2(void)
 {
 	/* This is equivalent to C program below.
@@ -1802,7 +1802,7 @@ __naked int absent_mark_in_the_middle_state2(void)
 
 SEC("?raw_tp")
 __flag(BPF_F_TEST_STATE_FREQ)
-__failure __msg("misaligned stack access off 0+-31+0 size 8")
+__failure __msg("misaligned stack access off -31+0 size 8")
 __naked int absent_mark_in_the_middle_state3(void)
 {
 	/*
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 3b984b6ae7c0b94a993470a3fe8185fce1214f4a..5b4453747c2308e871ffefd27123ac33a74abb71 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -8,7 +8,7 @@
 SEC("tp_btf/sys_enter")
 __success
 __log_level(2)
-__msg("r8 = *(u64 *)(r7 +0)          ; R7=ptr_nameidata(off={{[0-9]+}}) R8=rdonly_untrusted_mem(sz=0)")
+__msg("r8 = *(u64 *)(r7 +0)          ; R7=ptr_nameidata(imm={{[0-9]+}}) R8=rdonly_untrusted_mem(sz=0)")
 __msg("r9 = *(u8 *)(r8 +0)           ; R8=rdonly_untrusted_mem(sz=0) R9=scalar")
 int btf_id_to_ptr_mem(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_align.c b/tools/testing/selftests/bpf/progs/verifier_align.c
index 90362d61f1feda29a51999188f289dcf75d2761f..24553ce6288170aecd123fcc8e392406b4321759 100644
--- a/tools/testing/selftests/bpf/progs/verifier_align.c
+++ b/tools/testing/selftests/bpf/progs/verifier_align.c
@@ -131,7 +131,7 @@ LBL ":"							\
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("6: R0=pkt(off=8,r=8)")
+__msg("6: R0=pkt(r=8,imm=8)")
 __msg("6: {{.*}} R3={{[^)]*}}var_off=(0x0; 0xff)")
 __msg("7: {{.*}} R3={{[^)]*}}var_off=(0x0; 0x1fe)")
 __msg("8: {{.*}} R3={{[^)]*}}var_off=(0x0; 0x3fc)")
@@ -203,10 +203,10 @@ __naked void unknown_mul(void)
 SEC("tc")
 __success __log_level(2)
 __msg("2: {{.*}} R5=pkt(r=0)")
-__msg("4: {{.*}} R5=pkt(off=14,r=0)")
-__msg("5: {{.*}} R4=pkt(off=14,r=0)")
+__msg("4: {{.*}} R5=pkt(r=0,imm=14)")
+__msg("5: {{.*}} R4=pkt(r=0,imm=14)")
 __msg("9: {{.*}} R2=pkt(r=18)")
-__msg("10: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff){{.*}} R5=pkt(off=14,r=18)")
+__msg("10: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff){{.*}} R5=pkt(r=18,imm=14)")
 __msg("13: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xffff)")
 __msg("14: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xffff)")
 __naked void packet_const_offset(void)
@@ -247,14 +247,14 @@ __msg("7: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3fc)")
 /* Offset is added to packet pointer R5, resulting in
  * known fixed offset, and variable offset from R6.
  */
-__msg("11: {{.*}} R5=pkt(id=1,off=14,")
+__msg("11: {{.*}} R5=pkt(id=1,{{[^)]*}},var_off=(0x2; 0x7fc)")
 /* At the time the word size load is performed from R5,
  * it's total offset is NET_IP_ALIGN + reg->off (0) +
  * reg->aux_off (14) which is 16.  Then the variable
  * offset is considered using reg->aux_off_align which
  * is 4 and meets the load's requirements.
  */
-__msg("15: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x3fc)")
+__msg("15: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
 /* Variable offset is added to R5 packet pointer,
  * resulting in auxiliary alignment of 4. To avoid BPF
  * verifier's precision backtracking logging
@@ -266,37 +266,37 @@ __msg("18: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc){{.*}} R5={{[^)]*}}var_off=(0x
 /* Constant offset is added to R5, resulting in
  * reg->off of 14.
  */
-__msg("19: {{.*}} R5=pkt(id=2,off=14,")
+__msg("19: {{.*}} R5=pkt(id=2,{{[^)]*}}var_off=(0x2; 0x7fc)")
 /* At the time the word size load is performed from R5,
  * its total fixed offset is NET_IP_ALIGN + reg->off
  * (14) which is 16.  Then the variable offset is 4-byte
  * aligned, so the total offset is 4-byte aligned and
  * meets the load's requirements.
  */
-__msg("24: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x3fc)")
+__msg("24: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
 /* Constant offset is added to R5 packet pointer,
  * resulting in reg->off value of 14.
  */
-__msg("26: {{.*}} R5=pkt(off=14,r=8)")
+__msg("26: {{.*}} R5=pkt(r=8,imm=14)")
 /* Variable offset is added to R5, resulting in a
  * variable offset of (4n). See comment for insn #18
  * for R4 = R5 trick.
  */
-__msg("28: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x3fc)")
+__msg("28: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
 /* Constant is added to R5 again, setting reg->off to 18. */
-__msg("29: {{.*}} R5=pkt(id=3,off=18,")
+__msg("29: {{.*}} R5=pkt(id=3,{{[^)]*}}var_off=(0x2; 0x7fc)")
 /* And once more we add a variable; resulting {{[^)]*}}var_off
  * is still (4n), fixed offset is not changed.
  * Also, we create a new reg->id.
  */
-__msg("31: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x7fc)")
+__msg("31: {{.*}} R4={{[^)]*}}var_off=(0x2; 0xffc){{.*}} R5={{[^)]*}}var_off=(0x2; 0xffc)")
 /* At the time the word size load is performed from R5,
  * its total fixed offset is NET_IP_ALIGN + reg->off (18)
  * which is 20.  Then the variable offset is (4n), so
  * the total offset is 4-byte aligned and meets the
  * load's requirements.
  */
-__msg("35: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x7fc)")
+__msg("35: {{.*}} R4={{[^)]*}}var_off=(0x2; 0xffc){{.*}} R5={{[^)]*}}var_off=(0x2; 0xffc)")
 __naked void packet_variable_offset(void)
 {
 	asm volatile ("					\
@@ -430,16 +430,10 @@ __msg("6: {{.*}} R5={{[^)]*}}var_off=(0x2; 0xfffffffffffffffc)")
 /* Checked s>=0 */
 __msg("9: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
 /* packet pointer + nonnegative (4n+2) */
-__msg("11: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
-__msg("12: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
-/* NET_IP_ALIGN + (4n+2) == (4n), alignment is fine.
- * We checked the bounds, but it might have been able
- * to overflow if the packet pointer started in the
- * upper half of the address space.
- * So we did not get a 'range' on R6, and the access
- * attempt will fail.
- */
-__msg("15: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
+__msg("11: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc){{.*}} R6={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
+__msg("12: (07) r4 += 4")
+/* packet smax bound overflow */
+__msg("pkt pointer offset -9223372036854775808 is not allowed")
 __naked void dubious_pointer_arithmetic(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 560531404bcef88aed778b4dceeade03e086cfdb..d195eaa67d75ae3109d1281c68a0c9e316674fae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -202,7 +202,7 @@ l0_%=:	/* exit */					\
 
 SEC("tc")
 __description("bounds check based on reg_off + var_off + insn_off. test1")
-__failure __msg("value_size=8 off=1073741825")
+__failure __msg("map_value pointer offset 1073741822 is not allowed")
 __naked void var_off_insn_off_test1(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 911caa8fd1b759994177353afd6c79ad7eb6eba4..4ee3b7a708f7a47b9305139eed8e5ab733687b50 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -412,7 +412,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("direct packet access: test17 (pruning, alignment)")
-__failure __msg("misaligned packet access off 2+0+15+-4 size 4")
+__failure __msg("misaligned packet access off 2+15+-4 size 4")
 __flag(BPF_F_STRICT_ALIGNMENT)
 __naked void packet_access_test17_pruning_alignment(void)
 {
@@ -569,7 +569,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("direct packet access: test23 (x += pkt_ptr, 4)")
-__failure __msg("invalid access to packet, off=0 size=8, R5(id=3,off=0,r=0)")
+__failure __msg("invalid access to packet, off=31 size=8, R5(id=3,off=31,r=0)")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void test23_x_pkt_ptr_4(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 607dad058ca16be9b3e55c04afff9ee857b2a56d..548dce00f5fbacf1087f139c04d3a5e36d7a82e5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -131,7 +131,7 @@ DEFINE_INVALID_SIZE_PROG(u16, __failure __msg("Invalid read of 2 bytes from insn
 DEFINE_INVALID_SIZE_PROG(u8,  __failure __msg("Invalid read of 1 bytes from insn_array"))
 
 SEC("socket")
-__failure __msg("misaligned value access off 0+1+0 size 8")
+__failure __msg("misaligned value access off 1+0 size 8")
 __naked void jump_table_misaligned_access(void)
 {
 	asm volatile ("						\
@@ -187,7 +187,7 @@ jt0_%=:								\
 }
 
 SEC("socket")
-__failure __msg("invalid access to map value, value_size=16 off=-24 size=8")
+__failure __msg("R0 min value is negative")
 __naked void jump_table_invalid_mem_acceess_neg(void)
 {
 	asm volatile ("						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
index 74f5f9cd153d9103661ea07ed70615e6e35f0f6e..71cee3f583243f00c2a288915db69c3b1e581b1e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
@@ -360,7 +360,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("helper access to packet: test15, cls helper fail sub")
-__failure __msg("invalid access to packet")
+__failure __msg("R1 min value is negative")
 __naked void test15_cls_helper_fail_sub(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index 886498b5e6f34339161fc705f34e19dcb8f4ed03..6d2a38597c34f4135f9defe6bb6212e88d1a5542 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
@@ -1100,7 +1100,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("map helper access to adjusted map (via const imm): out-of-bound 2")
-__failure __msg("invalid access to map value, value_size=16 off=-4 size=8")
+__failure __msg("R2 min value is negative")
 __naked void imm_out_of_bound_2(void)
 {
 	asm volatile ("					\
@@ -1176,7 +1176,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("map helper access to adjusted map (via const reg): out-of-bound 2")
-__failure __msg("invalid access to map value, value_size=16 off=-4 size=8")
+__failure __msg("R2 min value is negative")
 __naked void reg_out_of_bound_2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
index 59e34d5586543e22de9d2d284ea0efb18d342dee..6627f44faf4bca7b8f11fb7dc3ae7b17c81bf440 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -65,7 +65,7 @@ __naked void ptr_to_long_half_uninitialized(void)
 
 SEC("cgroup/sysctl")
 __description("arg pointer to long misaligned")
-__failure __msg("misaligned stack access off 0+-20+0 size 8")
+__failure __msg("misaligned stack access off -20+0 size 8")
 __naked void arg_ptr_to_long_misaligned(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_meta_access.c b/tools/testing/selftests/bpf/progs/verifier_meta_access.c
index d81722fb5f19ff373ba63942972f71077f2d30ce..62235f032ffe7bb9ffb264f3cd96c3e8aececf44 100644
--- a/tools/testing/selftests/bpf/progs/verifier_meta_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_meta_access.c
@@ -27,7 +27,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("meta access, test2")
-__failure __msg("invalid access to packet, off=-8")
+__failure __msg("R0 min value is negative")
 __naked void meta_access_test2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 7a13dbd794b2fb88038b529f1a954bc8e09e1644..893d3bb024a0bdc39843ecd13a44fb8003ee79c1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -656,7 +656,7 @@ __msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -16) = r0")
 __msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
 __msg("mark_precise: frame0: regs= stack=-8 before 3: (7a) *(u64 *)(r10 -8) = 1")
-__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2=1")
+__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
 __msg("12: (79) r2 = *(u64 *)(r10 -16)       ; R2=1 R10=fp0 fp-16=1")
 __msg("13: (0f) r1 += r2")
@@ -673,7 +673,7 @@ __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-16 before 5: (7b) *(u64 *)(r10 -16) = r0")
 __msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
-__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2=1")
+__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 __naked void stack_load_preserves_const_precision(void)
 {
 	asm volatile (
@@ -732,7 +732,7 @@ __msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-8 before 5: (63) *(u32 *)(r10 -16) = r0")
 __msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
 __msg("mark_precise: frame0: regs= stack=-8 before 3: (62) *(u32 *)(r10 -8) = 1")
-__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2=1")
+__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
 __msg("12: (61) r2 = *(u32 *)(r10 -16)       ; R2=1 R10=fp0 fp-16=????1")
 __msg("13: (0f) r1 += r2")
@@ -748,7 +748,7 @@ __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-16 before 5: (63) *(u32 *)(r10 -16) = r0")
 __msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
-__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2=1")
+__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 __naked void stack_load_preserves_const_precision_subreg(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 24aabc6083fd9698ba22bf93f07db76c99bdd9ee..8e8cf8232255fed584bc977eb80a9ebd106faec8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -37,7 +37,7 @@ __naked void ptr_to_stack_store_load(void)
 
 SEC("socket")
 __description("PTR_TO_STACK store/load - bad alignment on off")
-__failure __msg("misaligned stack access off 0+-8+2 size 8")
+__failure __msg("misaligned stack access off -8+2 size 8")
 __failure_unpriv
 __naked void load_bad_alignment_on_off(void)
 {
@@ -53,7 +53,7 @@ __naked void load_bad_alignment_on_off(void)
 
 SEC("socket")
 __description("PTR_TO_STACK store/load - bad alignment on reg")
-__failure __msg("misaligned stack access off 0+-10+8 size 8")
+__failure __msg("misaligned stack access off -10+8 size 8")
 __failure_unpriv
 __naked void load_bad_alignment_on_reg(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index af7938ce56cb07a340470ce4629baea3753562ab..b3b701b445503ad38231c6908f5432226b79a63b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -346,7 +346,7 @@ l2_%=:	r0 = 1;						\
 SEC("socket")
 __description("map access: value_ptr -= known scalar from different maps")
 __success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__msg_unpriv("R0 min value is negative")
 __retval(1)
 __naked void known_scalar_from_different_maps(void)
 {
@@ -683,9 +683,7 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr -= known scalar, lower oob arith, test 1")
-__failure __msg("R0 min value is outside of the allowed memory range")
-__failure_unpriv
-__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__failure __msg("R0 min value is negative")
 __naked void lower_oob_arith_test_1(void)
 {
 	asm volatile ("					\
@@ -840,7 +838,7 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr += known scalar, 3")
-__failure __msg("invalid access to map value")
+__failure __msg("R0 min value is negative")
 __failure_unpriv
 __naked void value_ptr_known_scalar_3(void)
 {
@@ -1207,7 +1205,7 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr -= known scalar")
-__failure __msg("R0 min value is outside of the allowed memory range")
+__failure __msg("R0 min value is negative")
 __failure_unpriv
 __naked void access_value_ptr_known_scalar(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
index df2dfd1b15d131cda8e314fa207c8fe03074837f..0b86d95a41335983941fe8eb9e7d74d2ac56678c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
@@ -69,7 +69,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data' > pkt_end, bad access 1")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_end_bad_access_1_1(void)
 {
@@ -131,7 +131,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data' > pkt_end, corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_1(void)
 {
@@ -173,7 +173,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_end > pkt_data', corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_2(void)
 {
@@ -279,7 +279,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data' < pkt_end, corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_3(void)
 {
@@ -384,7 +384,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_end < pkt_data', bad access 1")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_data_bad_access_1_1(void)
 {
@@ -446,7 +446,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_end < pkt_data', corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_4(void)
 {
@@ -487,7 +487,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data' >= pkt_end, corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_5(void)
 {
@@ -590,7 +590,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_end >= pkt_data', bad access 1")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_data_bad_access_1_2(void)
 {
@@ -654,7 +654,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_end >= pkt_data', corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_6(void)
 {
@@ -697,7 +697,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data' <= pkt_end, bad access 1")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_end_bad_access_1_2(void)
 {
@@ -761,7 +761,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data' <= pkt_end, corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_7(void)
 {
@@ -803,7 +803,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_end <= pkt_data', corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_8(void)
 {
@@ -905,7 +905,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' > pkt_data, bad access 1")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_data_bad_access_1_3(void)
 {
@@ -926,7 +926,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' > pkt_data, bad access 2")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_data_bad_access_2_5(void)
 {
@@ -967,7 +967,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' > pkt_data, corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_9(void)
 {
@@ -1009,7 +1009,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data > pkt_meta', corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_10(void)
 {
@@ -1031,7 +1031,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data > pkt_meta', bad access 2")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_meta_bad_access_2_1(void)
 {
@@ -1115,7 +1115,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' < pkt_data, corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_11(void)
 {
@@ -1137,7 +1137,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' < pkt_data, bad access 2")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_data_bad_access_2_6(void)
 {
@@ -1220,7 +1220,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data < pkt_meta', bad access 1")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_meta_bad_access_1_1(void)
 {
@@ -1241,7 +1241,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data < pkt_meta', bad access 2")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_meta_bad_access_2_2(void)
 {
@@ -1282,7 +1282,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data < pkt_meta', corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_12(void)
 {
@@ -1323,7 +1323,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' >= pkt_data, corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_13(void)
 {
@@ -1344,7 +1344,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' >= pkt_data, bad access 2")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_data_bad_access_2_7(void)
 {
@@ -1426,7 +1426,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data >= pkt_meta', bad access 1")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_meta_bad_access_1_2(void)
 {
@@ -1448,7 +1448,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data >= pkt_meta', bad access 2")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_meta_bad_access_2_3(void)
 {
@@ -1490,7 +1490,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data >= pkt_meta', corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_14(void)
 {
@@ -1533,7 +1533,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' <= pkt_data, bad access 1")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_data_bad_access_1_4(void)
 {
@@ -1555,7 +1555,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' <= pkt_data, bad access 2")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_data_bad_access_2_8(void)
 {
@@ -1597,7 +1597,7 @@ l1_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_meta' <= pkt_data, corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_15(void)
 {
@@ -1639,7 +1639,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data <= pkt_meta', corner case -1, bad access")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void corner_case_1_bad_access_16(void)
 {
@@ -1660,7 +1660,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("XDP pkt read, pkt_data <= pkt_meta', bad access 2")
-__failure __msg("R1 offset is outside of the packet")
+__failure __msg("R1 {{min|max}} value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void pkt_meta_bad_access_2_4(void)
 {
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 9ca83dce100d4e13bbc46c9b6f7146766645d5b1..86887130a0efb5c4b6a29f70c7cba0abdde89825 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -220,7 +220,7 @@
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
-	.errstr = "variable trusted_ptr_ access var_off=(0x0; 0x7) disallowed",
+	.errstr = "R1 must have zero offset when passed to release func or trusted arg to kfunc",
 },
 {
 	"calls: invalid kfunc call: referenced arg needs refcounted PTR_TO_BTF_ID",

-- 
2.51.1
