Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207856;
	b=XV0a7pU7DOoOJzgEyx1pq1OMT7DcGzl9H0E0/GpPDlBiVEFUiQ4ubspOqxvPWx+qj9xw
	 76l8MIuxEF3sXPr166YBlsvhvrjAsq3D67wDZKRQNtxSGO+d9zhr/NjRmMyfXyBmT3WcI
	 7tWRCxmNfXhT6LkvA9U1RYvngBcfmUmqlj7xcVzCDDVR7E9T88teLAZ9uL4dSrhCMhmrz
	 M5hc5PTsfRxLwviEKCIC6XgeLACDlpwTWXA59gg7BwpSqY95hf+Tl7bINH8j3D5jdjDzE
	 P4U4oI0RsATs/gzwc2J+bnCPOXJYGNQL/Egt8uwnuG0xNfAXogziUjrlSOG/lBcxnuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CqvczTtuJYjb5DdfqtFuDw9f009Q1ww78+RHEoMbIh8=;
	b=MJuwCe+C+h+08YJXsEPMB4fpYNqIxp+mfXtrbjI8zjBbVo7VboFas4zd4lhW2hgGtTQ0
	 mq4ovHOlW7EIEd/kvwiaVgcF5XTO6summcyjPq8MJUcVxdWnAKYIWSrvh96dyA5jJVG79
	 kqRcfPKbHnoBoJstLBW5HSFUmaCpegAVfvPUSLn59aaRnFQecTzc0BZLhkjMPnfOZ6Jwy
	 6+uOppMX1RKJY0c3etmo5puOioRaiLYvuJZOzYeeLJxH4chIQ1bdjwL1s8gRb1EljUrcK
	 lcvNlsF56mKi/94iKuhIBJMCI7en3x6i4BLxabomxAQEsYOrOXh6Lm6qmyWMHYwktKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IOzD9pvB;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE1606A697
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BE1606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IOzD9pvB
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b2382bf051so785544b3a.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207851; x=1795812651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CqvczTtuJYjb5DdfqtFuDw9f009Q1ww78+RHEoMbIh8=;
        b=IOzD9pvBHlHGoICn77tCmUCEsXUqQjH5/054x3WKwNcOObxINoXHUO+s5dEgf3sPSl
         Z+xLsP/bTRorUAo352NlEDeyfUIJWNEm7DQl3lEnijYmx7zL3mYgOS0261SB02XVwzJV
         VvniFyyyIt9yEHo/76dtK4B0CnOZywryEQ6lEF9PK9PUoXBaoxXQ0uaWCdLnYOy6b83U
         ADJCKj93nDpYZZHYtGSxRw7JhNkxH9hcxkfp66kBJcuMveKG8V96Kafoya7FZ56cEFbV
         vkKVqJ0om80BD/ISYLUgpUsfpZEgh/JIjpwJT6kzvHlTspYIoJpou0obIb1kAw+yYdGu
         1n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207851; x=1795812651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CqvczTtuJYjb5DdfqtFuDw9f009Q1ww78+RHEoMbIh8=;
        b=mSa2QJB0MZaiEUGpZVK1YxTUYnHQgMnAVc7a9sLmCjwk11g+aJ/Z8Yg1O1+l9VLFC2
         0AquF6svTspmtAczUsQOJsq6Fas3WvaUhg62iojCGPHQ3w3AL5116R11FXxFRmd3mt6i
         Ef3dPjyhe8OfhjZ5Fhuv60LGTok5kaAfIvswBhRKZpr8dyy6PbRtBbGROMaqp1a0oiBw
         OCpbrtX5xO2dxbvDMFOYiNkOzGcFPYAEC1nv48kt6LF9vAqS4w3j5qjKQyRbKNG/e0FB
         3k9MSvPMdRixGQbDscGRDwrGYS6SQegb6fsWfkveWuUxXJ+5E6/7G4JoUMVANX2Ns0mA
         vvyQ==
X-Gm-Message-State: APuU4Z9lcv2dUsxHVhuhx00HMGk0BqoN6Ip369vWiGepbKwgFZLxbXj9
	pIWGdsFDpIVey7K7VdTLi5hvpyAuH2KcRVv63ud2iBRsVyHq1Kb4yVmo6yXc5A==
X-Gm-Gg: AYBFou2OA7jZN7wWiiu83qUoDkt3Sz2DHYRC88OSKHh3jvERYP0hqbpk0383LUsFoRB
	isLpHkAPlL0IT6N8H4NT/g30x3yrqs6HclktHH0v9IxZPsxnid90v/87HAEMWyOFT+DPRJOS83U
	T+5jWHBZAmAGIyESMjJxS4FbVSUW4JWXiPD85+oYjjS7s+TVs3K2TDXRH88vpvwBv+OzaWmhdMj
	tvL2U6wkHxTr78Ba6mm7ZAUjpS4rzCv+3DYnjKxzp/7nd5YDg4hhPsAIVx59JsN+7+kL89wG1xJ
	PhrOhNkRqTde6oyKgP9czcySENwVKiR2TN6mDeJXNe+1gQY2YbEO7lkmywclgPyHO95M99PhToU
	HBsfhaBUIWgHnFKlMlyVPI091VExnYCGnEQ1mv+5xMnyEKO/Ray3UUDE8RGOuQz3HwSfnkYHRIf
	812+gEnU2Jw/onfKebBvxGm8mS264j9QHCQ3v9r7yuegCj70GdJVGRW9S5UI57qJgbM/at0bCHU
	lW8kIsgbUNI6ANqHfLMEXGGcMnQnIVpmAp1u1o/MMJFh5ZFXkFZKeokMNchuwLkSHNWbdj+oKQD
	QLLXVtm/w9Z4wrxvb7dQrGju2TwvBZ4tKKc1kzFUdeipMAdR86D3ugiLoIuVH/yNLp/rwQZWlwk
	x1GIhI8pfe4Akf8wcVHEA+JfrhVt0agjki11EGOhtOZp1xmDCC9ayeK6Gx9fuWw8uPNDlrP8j2L
	7dkvBKtDvRB0rbsRmVobE=
X-Received: by 2002:a05:6a00:14c3:b0:87d:ee98:606 with SMTP id d2e1a72fcca58-8c87bfa8121mr4506784b3a.23.1795207850781;
        Fri, 20 Nov 2026 12:50:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077fe3fsm2048150b3a.4.2026.11.20.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:50:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 08/49] bpf: Do not fail a check because a state has fewer values
Date: Fri, 20 Nov 2026 20:49:16 +0000
Message-ID: <20261120204959.614908-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

More precision must not make the result worse. If an insn is proven in
a state, it has to be proven in a state with fewer values too. Else it
is proven after a join and unproven without the join. Three checks do
not work that way.

1. Pointer arithmetic looks at the smallest offset:

     r1 = 1 << 30            r1 = 0 .. 1 << 30
     r0 += r1   fails        r0 += r1   ok

   Allow the add. bpf_blur_far_offset() extends the range of the
   offset down to BPF_MAX_VAR_OFF - 1. So the offset is not a constant
   that overflows an int, and an access fails. The same holds far below
   the object. The number still needs a lower bound.

   A flexible array of a BTF object has no end. If a far load from it
   passes, it gets a fault handler. A far load-acquire fails.

2. A jump can cut a range in two:

                         r8 = -4..3            r8 = any number
     if r8 < 3 goto L    -4..-1, 3 -> -4..3    3..U64_MAX
     if r8 s< 0 goto L   0..3                  3..S64_MAX

   The small state has 0..2, the large state does not. cut_range() does
   the jump two times: for -4..-1 and for 0..3. It does that only if
   an error depends on the register, see bpf_xreg_in_deps() in a later
   patch.
   'x != 0' is 'x u> 0', so it cuts a range too.

3. A load takes a part of a spilled pointer:

     *(u64 *)(r10 - 16) = ptr
     r1 = r10 - 16 + (0..7)       r1 = r10 - 16 + 3
     r0 = *(u8 *)(r1 + 0)  ok     r0 = *(u8 *)(r1 + 0)  fails

   With allow_ptr_leaks the constant offset takes the path of the
   variable offset: the result is an unknown number. An atomic
   read-modify-write still needs the whole slot.

do_check() has only a range for a far offset. So const_fold.c does not
follow a far pointer to a map value.

A far pointer to the packet can wrap around:
- It gets a new id and loses its range.
  bpf_blur_far_offset() looks at the source and the result of the add.
- A compare with the end of the packet leaks the address. Without
  allow_ptr_leaks, compare only offsets from -MAX_PACKET_OFF to
  2 * MAX_PACKET_OFF. A header and a 16-bit length fit.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  27 ++++++
 kernel/bpf/const_fold.c      |   3 +
 kernel/bpf/liveness.c        |   6 +-
 kernel/bpf/states.c          |   4 +-
 kernel/bpf/verifier.c        | 182 ++++++++++++++++++++++++-----------
 5 files changed, 163 insertions(+), 59 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d63a522b465..87b4e01cda2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1227,10 +1227,13 @@ struct bpf_verifier_env {
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
+	bool path_sensitive;		/* no joins, see run_path_sensitive() */
 	u64 cost, mem;			/* see bpf_check_limits() */
 	u64 max_cost, max_mem;
 	u64 pass_max_cost;		/* see bpf_undo_precision() */
 	bool aborted;			/* a thaw does not take it back */
+	int err;			/* the first error */
+	bool imprecise;			/* a state before the first error is imprecise */
 	bool over_limit;		/* see bpf_check_limits() */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
 	bool guards_late;		/* see bpf_flow_loop_gets_guards() */
@@ -1531,6 +1534,8 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
 
 int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
+bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+		      u32 fr, u32 xregno);
 /*
  * The two limits of the verifier, for the whole load. The unit of cost is one step of a scan,
  * about a dozen insns of the CPU. Memory is the bytes of states and tables at a time.
@@ -1796,6 +1801,27 @@ static inline bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
 
+/* A number, or a pointer that stands for the offsets in its range */
+static inline bool bpf_reg_has_range(const struct bpf_reg_state *reg)
+{
+	switch (base_type(reg->type)) {
+	case SCALAR_VALUE:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_STACK:
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+	case PTR_TO_TP_BUFFER:
+	case PTR_TO_BTF_ID:
+	case PTR_TO_INSN:
+		return !type_may_be_null(reg->type);
+	default:
+		return false;
+	}
+}
+
 static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 {
 	env->scratched_regs |= 1U << regno;
@@ -2079,6 +2105,7 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env,
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
 			    const struct bpf_reg_state *reg_b);
+void bpf_blur_far_offset(struct bpf_verifier_env *env, struct bpf_reg_state *reg);
 void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax);
 void scalar_set_unknown(struct scalar *s);
 void scalar_set_const(struct scalar *s, u64 imm);
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 50179edbf34..61e22636ff8 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -214,6 +214,9 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
 			ci_out[r] = unknown;
 		break;
 	}
+	/* do_check() has only a range for a far offset */
+	if (ci_is_map_value(dst) && abs((s64)dst->val) >= BPF_MAX_VAR_OFF)
+		*dst = unknown;
 }
 
 /* Join function: merge output state into a successor's input state. */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 6e6b2c6d88c..78acb620aa7 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -596,9 +596,9 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
  * fill a pointer, and a helper, a kfunc or a global subprog that gets a pointer to the stack reads
  * memory. Such a read keeps the bytes of the slot alive, not what the verifier knows about them.
  *
- * A short load at an offset that is known here counts as a fill: the main pass rejects it when it
- * finds a pointer. If only the main pass knows the offset, the load doesn't count. It is rejected
- * too, or it reads unknown bytes if the state was cleaned between the spill and the load.
+ * A short load at an offset that is known here counts as a fill. A NULL check can make the
+ * pointer the number 0, and the load gets a part of it. If only the main pass knows the offset,
+ * the load doesn't count.
  */
 bool bpf_stack_slot_filled(struct bpf_verifier_env *env, u32 frameno, u32 half_spi)
 {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 854db8ee6a2..c05dcab5216 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -224,8 +224,8 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 			/*
 			 * Only scalar spills can be degraded to raw stack bytes
 			 * when their high half is dead. Pointer spills need the
-			 * saved spilled_ptr metadata so partial fills keep
-			 * rejecting as non-scalar register fills.
+			 * saved spilled_ptr metadata: without allow_ptr_leaks
+			 * a partial fill is rejected.
 			 * The code above replaces only pointers that no insn ahead can fill.
 			 */
 			if (!hi_live) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d43009b41bf..7410707ae12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -197,6 +197,7 @@ struct bpf_verifier_stack_elem {
 	int prev_insn_idx;
 	/* it goes there only if may_goto in front of prev_insn_idx does, see check_loop_guard() */
 	enum bpf_guard_edge guard_edge;
+	bool again;	/* see bpf_flow_deliver() */
 	struct bpf_verifier_stack_elem *next;
 };
 
@@ -346,6 +347,11 @@ static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 	verbose(env, " should have been in [%d, %d]\n", range.minval, range.maxval);
 }
 
+static bool offset_is_far(const struct bpf_reg_state *reg)
+{
+	return reg_smin(reg) <= -BPF_MAX_VAR_OFF || reg_smax(reg) >= BPF_MAX_VAR_OFF;
+}
+
 static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
 {
 	enum bpf_reg_type type;
@@ -358,7 +364,7 @@ static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_stat
 	 * The types below guarantee a non-NULL base, an unbounded offset can
 	 * still wrap base + offset to zero.
 	 */
-	if (reg_smin(reg) <= -BPF_MAX_VAR_OFF || reg_smax(reg) >= BPF_MAX_VAR_OFF)
+	if (offset_is_far(reg))
 		return false;
 
 	type = base_type(type);
@@ -4093,9 +4099,8 @@ static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
  * As opposed to check_stack_read_fixed_off, this function doesn't deal with
  * filling registers (i.e. reads of spilled register cannot be detected when
  * the offset is not fixed). We conservatively mark 'dst_regno' as containing
- * SCALAR_VALUE. That's why we assert that the 'reg' has a variable
- * offset; for a fixed offset check_stack_read_fixed_off should be used
- * instead.
+ * SCALAR_VALUE. A fixed offset gets here only for a part of a spilled
+ * pointer, see check_stack_read().
  */
 static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    argno_t ptr_argno, int off, int size, int dst_regno)
@@ -4131,6 +4136,7 @@ static int check_stack_read(struct bpf_verifier_env *env,
 			    int dst_regno)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
+	struct bpf_stack_state *ss;
 	int err;
 	/* Some accesses are only permitted with a static offset. */
 	bool var_off = !tnum_is_const(reg->var_off);
@@ -4164,6 +4170,11 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	 * just checking it here would be insufficient as speculative stack
 	 * writes could still lead to unsafe speculative behaviour.
 	 */
+	if (!var_off && dst_regno >= 0 && size != BPF_REG_SIZE && env->allow_ptr_leaks) {
+		ss = bpf_stack_slot(state, (-off - reg->var_off.value - 1) / BPF_REG_SIZE);
+		/* a part of a pointer is a number, as with a variable offset */
+		var_off = bpf_is_spilled_reg(ss) && !bpf_is_spilled_scalar_reg(ss);
+	}
 	if (!var_off) {
 		off += reg->var_off.value;
 		err = check_stack_read_fixed_off(env, state, off, size,
@@ -6940,8 +6951,7 @@ static int check_stack_access_within_bounds(
 		min_off = (s64)reg->var_off.value + off;
 		max_off = min_off + access_size;
 	} else {
-		if (reg_smax(reg) >= BPF_MAX_VAR_OFF ||
-		    reg_smin(reg) <= -BPF_MAX_VAR_OFF) {
+		if (offset_is_far(reg)) {
 			verbose(env, "invalid unbounded variable-offset%s stack %s\n",
 				err_extra, reg_arg_name(env, argno));
 			return -EACCES;
@@ -7523,6 +7533,15 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 
 	src_reg_type = regs[insn->src_reg].type;
+	/* A flexible array has no end, see btf_struct_access(). A far load from it can fault. */
+	if (base_type(src_reg_type) == PTR_TO_BTF_ID && offset_is_far(&regs[insn->src_reg])) {
+		if (BPF_CLASS(insn->code) != BPF_LDX) {
+			verbose(env, "BPF_ATOMIC loads from R%d with a far offset is not allowed\n",
+				insn->src_reg);
+			return -EACCES;
+		}
+		src_reg_type |= PTR_UNTRUSTED;
+	}
 
 	/*
 	 * check_stack_read_fixed_off() may refine the modification's origin to
@@ -16030,7 +16049,7 @@ static bool check_reg_sane_offset_scalar(struct bpf_verifier_env *env,
 	s64 val = reg->var_off.value;
 	s64 smin = reg_smin(reg);
 
-	if (known && (val >= BPF_MAX_VAR_OFF || val <= -BPF_MAX_VAR_OFF)) {
+	if (known && val <= -BPF_MAX_VAR_OFF) {
 		verbose(env, "math between %s pointer and %lld is not allowed\n",
 			reg_type_str(env, type), val);
 		return false;
@@ -16042,7 +16061,7 @@ static bool check_reg_sane_offset_scalar(struct bpf_verifier_env *env,
 		return false;
 	}
 
-	if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
+	if (smin <= -BPF_MAX_VAR_OFF) {
 		verbose(env, "value %lld makes %s pointer be out of bounds\n",
 			smin, reg_type_str(env, type));
 		return false;
@@ -16051,29 +16070,6 @@ static bool check_reg_sane_offset_scalar(struct bpf_verifier_env *env,
 	return true;
 }
 
-static bool check_reg_sane_offset_ptr(struct bpf_verifier_env *env,
-				      const struct bpf_reg_state *reg,
-				      enum bpf_reg_type type)
-{
-	bool known = tnum_is_const(reg->var_off);
-	s64 val = reg->var_off.value;
-	s64 smin = reg_smin(reg);
-
-	if (known && (val >= BPF_MAX_VAR_OFF || val <= -BPF_MAX_VAR_OFF)) {
-		verbose(env, "%s pointer offset %lld is not allowed\n",
-			reg_type_str(env, type), val);
-		return false;
-	}
-
-	if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
-		verbose(env, "%s pointer offset %lld is not allowed\n",
-			reg_type_str(env, type), smin);
-		return false;
-	}
-
-	return true;
-}
-
 enum {
 	REASON_BOUNDS	= -1,
 	REASON_TYPE	= -2,
@@ -16082,6 +16078,28 @@ enum {
 	REASON_STACK	= -5,
 };
 
+/*
+ * A far pointer is no error: a state with near offsets gets here, so this one does too.
+ * An access through it is unproven or gets a fault handler, see check_load_mem().
+ * But a constant offset has to fit in an int.
+ */
+void bpf_blur_far_offset(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	s64 smin = reg_smin(reg), smax = reg_smax(reg);
+
+	/* an id and a range need an offset that does not wrap around */
+	if (reg_is_pkt_pointer(reg) && offset_is_far(reg)) {
+		reg->id = bpf_new_id(env);
+		reg->range = 0;
+	}
+	if (reg->type == SCALAR_VALUE || (smin < BPF_MAX_VAR_OFF && smax > -BPF_MAX_VAR_OFF))
+		return;
+	scalar_set_unknown(scalar_of(reg));
+	reg->r64 = cnum64_from_srange(min(smin, BPF_MAX_VAR_OFF - 1),
+				      max(smax, 1 - BPF_MAX_VAR_OFF));
+	reg_bounds_sync(reg);
+}
+
 static int retrieve_ptr_limit(const struct bpf_verifier_env *env,
 			      const struct bpf_reg_state *ptr_reg,
 			      u32 *alu_limit, bool mask_to_left)
@@ -16521,6 +16539,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	 */
 	if (dst_reg != ptr_reg)
 		*dst_reg = *ptr_reg;
+	/* a far pointer that comes back leaves its copies */
+	bpf_blur_far_offset(env, dst_reg);
 
 	/*
 	 * Accesses to untrusted PTR_TO_MEM are done through probe
@@ -16531,23 +16551,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 
 	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type)) {
 		reason = bpf_diag_fmt(
-			env, "The scalar offset used with R%d is unbounded or outside the verifier's safe pointer-offset range [-%u, %u].",
-			ptr_regno, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF);
+			env, "The scalar offset used with R%d can be -%u or less.",
+			ptr_regno, BPF_MAX_VAR_OFF);
 		bpf_diag_register_type(
 			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
 			"Clamp or bounds-check the scalar offset before applying it to the pointer.");
 		return -EINVAL;
 	}
-	if (!check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type)) {
-		reason = bpf_diag_fmt(
-			env, "R%d already has an offset outside the verifier's safe range [-%u, %u] for %s.",
-			ptr_regno, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF,
-			bpf_diag_reg_type_plain(env, ptr_reg->type));
-		bpf_diag_register_type(
-			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
-			"Keep the base pointer within the verifier's allowed offset range before applying more arithmetic.");
-		return -EINVAL;
-	}
 
 	if (sanitize_needed(opcode)) {
 		ret = sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
@@ -16670,16 +16680,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		return -EACCES;
 	}
 
-	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type)) {
-		reason = bpf_diag_fmt(
-			env, "After this arithmetic, R%d would be outside the verifier's safe offset range [-%u, %u] for %s.",
-			dst, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF,
-			bpf_diag_reg_type_plain(env, ptr_reg->type));
-		bpf_diag_register_type(
-			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
-			"Tighten the scalar bounds before the arithmetic so the resulting pointer remains within the allowed range.");
-		return -EINVAL;
-	}
 	/*
 	 * A packet pointer that keeps its id or range is checked against a
 	 * range set from the checked pointer's umax, so var_off must not tighten
@@ -16696,6 +16696,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		reg_bounds_sync(dst_reg);
 		bpf_trim_pkt_range(dst_reg, smax);
 	}
+	bpf_blur_far_offset(env, dst_reg);
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
 	if (bounds_ret == -EACCES)
 		return bounds_ret;
@@ -18934,9 +18935,70 @@ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return 0;
 }
 
+/* How many values of @reg are before the end of the order of @insn? 0 if all of them are. */
+static u64 values_to_end(const struct bpf_insn *insn, const struct bpf_reg_state *reg)
+{
+	u8 op = BPF_OP(insn->code);
+	bool sign = op == BPF_JSGT || op == BPF_JSGE || op == BPF_JSLT || op == BPF_JSLE;
+	u64 first = sign ? S64_MIN : 0;
+	u32 cnt32 = (first >> 32) - reg->r32.base;
+	u64 cnt = first - reg->r64.base;
+
+	if (BPF_CLASS(insn->code) == BPF_JMP32)
+		return cnt32 <= reg->r32.size && reg->r32.size != U32_MAX ? cnt32 : 0;
+	return cnt <= reg->r64.size && reg->r64.size != U64_MAX ? cnt : 0;
+}
+
+/*
+ * A jump can cut a range in two: 'x u>= 3' leaves -4..-1 and 3 of -4..3. One range has both and
+ * all values between them. So a state that knows less is proven where this one is not.
+ * Do the jump for the values before the end of the order, then again for the values after it.
+ * Returns 1 if the current state has fewer values now.
+ */
+static int cut_range(struct bpf_verifier_env *env, const struct bpf_insn *insn, u32 regno,
+		     const struct bpf_reg_state *taken, const struct bpf_reg_state *not_taken)
+{
+	struct bpf_verifier_state *st = env->cur_state, *other;
+	struct bpf_reg_state *reg = &cur_regs(env)[regno], front = *reg, back = *reg;
+	u64 cnt = values_to_end(insn, reg);
+	u8 op = BPF_OP(insn->code);
+	const struct bpf_reg_state *equal = op == BPF_JEQ ? taken : not_taken;
+
+	/* 'x != 0' is 'x u> 0' */
+	if ((op == BPF_JEQ || op == BPF_JNE) && !tnum_equals_const(tnum_subreg(equal->var_off), 0))
+		return 0;
+	if (op == BPF_JSET || reg->type != SCALAR_VALUE || !cnt ||
+	    !(values_to_end(insn, taken) || values_to_end(insn, not_taken)))
+		return 0;
+	env->imprecise |= !env->err;
+	if (!env->path_sensitive && !bpf_xreg_in_deps(env, st, st->curframe, regno))
+		return 0;
+	if (BPF_CLASS(insn->code) == BPF_JMP32) {
+		front.r32.size = cnt - 1;
+		back.r32.base += cnt;
+		back.r32.size -= cnt;
+	} else {
+		front.r64.size = cnt - 1;
+		back.r64.base += cnt;
+		back.r64.size -= cnt;
+	}
+	reg_bounds_sync(&front);
+	reg_bounds_sync(&back);
+	if (reg_is_empty(&front) || reg_is_empty(&back))
+		return 0;
+	other = push_stack(env, env->insn_idx, env->insn_idx, false);
+	if (IS_ERR(other))
+		return PTR_ERR(other);
+	env->head->again = true;
+	other->frame[other->curframe]->regs[regno] = back;
+	*reg = front;
+	return 1;
+}
+
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int *insn_idx)
 {
+	struct cnum64 near = cnum64_from_srange(-MAX_PACKET_OFF, 2 * MAX_PACKET_OFF);
 	struct bpf_verifier_state *this_branch = env->cur_state;
 	struct bpf_verifier_state *other_branch;
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
@@ -18996,7 +19058,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return err;
 
 		src_reg = &regs[insn->src_reg];
-		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
+		/* A header and a 16-bit length fit. If a pointer wraps, it leaks the address. */
+		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg) &&
+		      cnum64_is_subset(near, dst_reg->r64) &&
+		      cnum64_is_subset(near, src_reg->r64)) &&
 		    is_pointer_value(env, insn->src_reg)) {
 			verbose(env, "R%d pointer comparison prohibited\n",
 				insn->src_reg);
@@ -19011,6 +19076,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+again:
 	env->false_reg1 = *dst_reg;
 	env->false_reg2 = *src_reg;
 	env->true_reg1 = *dst_reg;
@@ -19052,6 +19118,14 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return 0;
 	}
 
+	err = cut_range(env, insn, insn->dst_reg, &env->true_reg1, &env->false_reg1);
+	if (!err && BPF_SRC(insn->code) == BPF_X)
+		err = cut_range(env, insn, insn->src_reg, &env->true_reg2, &env->false_reg2);
+	if (err > 0)
+		goto again;
+	if (err)
+		return err;
+
 	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx, false);
 	if (IS_ERR(other_branch))
 		return PTR_ERR(other_branch);
-- 
2.55.0

