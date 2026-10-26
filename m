Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983986;
	b=AZrFcNSeGzsfFLpQp7ilmkfMIYI+7hWdV3V2w/wl5XwNRnocD5HQX3pcPiJreAgQRfXG
	 d+T+/2zXHp6AF0ki+mVra9ojpJ87IxJKotRNETGUJ06Ufa2cJ3hSErxd39FOSdixezTsf
	 gv4Ln/HMDGGkFj3qoy07wglrOJ/YdAzXRQZBOg9Mf4n75B3SmQQi44mWZ/6JYxlQXzjop
	 5lc44o9Rz41MqTVawuuJyiyeQ2+lnnGwQOnRnNCWJnXJ/+awm8aiDWSAFwKwmd89B7Ftr
	 /VJbaBTd4tvAcr8BgmGbUTrhBO6nwWlLnH7dbutK9DwGM3sbYqJvVfnPcfkNwd294kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sGzv3R1j6EFLJeeGgiQmOVPKP9XVxq7VnIee8kXCifQ=;
	b=hFuHKnZW9Lze9r9w38r2ipX6vctcuOsm4ptjVYR/bvimEe2qM/bVRvpdcgPuCyfEoZHP
	 CdOfJJJEmXv/+SGTE95PajtphTUTR5aVVdj8PILCB0se7L1jdzsUSMcjysKKrcO2XxD2F
	 SoSovFAav5YVUTiTOpwnuu26c0BeWkiwtUrEkP4nny//yKyG6F7kFCywnhTdx25AUcF+w
	 Z1znIY697Jay/cw/gSoGnuafh2ExZeIAZJWgbHfm8Vea7DqHk3CrvNE8MsVbQDUmqxErf
	 Q8xz0TQtTlx6LdAtgic055pmibgrPYgwdt8uzsg3TaJXUU1bpYoGjslus3uc3C/F6UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fB7YuyM3;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF27606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF27606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fB7YuyM3
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc758830601so1502654a12.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983985; x=1793588785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sGzv3R1j6EFLJeeGgiQmOVPKP9XVxq7VnIee8kXCifQ=;
        b=fB7YuyM3EWyD9mUxR+W2FETpdbYdiyNIJjjGUJjD973ZNiXtwE3uEWGLf0voJ/KfyU
         xHifMQfhYLLfBnhUFaw3aTx7oDRy+TvT5GkJ5zQ09MynhhZIRagQH0lz3fqbUoIb3bNc
         u7S6HDCHB1Hq+VoBgHPK/wzbgvkR7CJ/S7N5p9b2076Lvy50+UWHrZSCRpYroaS7erui
         ZnO62hO/rjpNF+hVuvzIeNk5BxB0ORRBBtz34ZB4+2TndqRsiRa8Z9sZicfw5dESuWjz
         i/900Ki6SJkz4dW/RWy90KeNYdtyW3Vo/xGsbDJsKqI5QAGFrZL1P3+pZIyQXVx70w40
         mZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983985; x=1793588785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sGzv3R1j6EFLJeeGgiQmOVPKP9XVxq7VnIee8kXCifQ=;
        b=DDbhQEzASmO4vHwWnULZ2HCLyaeZGkIXvL/HejCTpQa6/VJeWv4FWHbENY523rM+Cs
         5ye7Fsfe1Znimm59JwLz8nDvFBEYFtuXQzJ9c9tRTFxeVZ9IDIcoU1eBTnGIS+ogtAnk
         X5tCy+F9ulTT8NBno7CwlHQelFn+LK0jU1l5GUO5IchShhAEmq33CfboX41zlBh4oAhW
         IqQspRmBSa3+QoXTkERIQEtkGEYWtCawFOOidjZGIMkH5r/+73pCS1dnWp08upQ+tPN5
         2LI1NInMpAbn1SiKFRwSDBpw+n6ZYhrAzAQ6UBNZyZbijLZMXDatdKGNIgEFGBqB1WeV
         Za/w==
X-Gm-Message-State: AFq9FYJq8UIzMiH2oVuDfQ2QNxOXMeGeLWkvH4LbPO3cxDtG1EHIBIk1
	gOcLPCnkozBkpwiG0JEO2daCOMsAtPJ8h57vu3yIa7/oi1Q4/bN38V18TWF0FA==
X-Gm-Gg: AYBFou3jddO9+gBnwurqQ4VWQMxN+/3kVUQqq31Mgjko27OsOVj+45WTKEwTj1atgmW
	yeWWNrLC1nmqo29inXDYI7JnWumOIlF8HrekTKSUGksxE3h8TQgqkuOeeMSBFSjsPm+MxRK3ZNg
	CuuuSLqFTJMOXryd3Eo45EoyiKD3aeNQvdVeS8K1/QJqJHv7++Nb/AjIWJJjK8cIdnXZB6WrSdM
	j5HJRJ1LHUwnGntjNgq8GL/8JQnoO3yLcy8xbDG5s3U1RsX0ahAYbH5RL/71VsjGXvi3CII2soI
	MYLRJPg1LLoFIF1+DEsj0r3xuSlfXtwf0UbOWpjavG99/qUO94ebZsiMw2AQHzeCC8L38ZgUOBK
	P9X/N4RFf0RM1YM/NPOjo0CJB5Av/JQXRZTXretS/cx4BmKzYyaARpXAyPZms3FpRa00/w6lSII
	EPdgqigbh44xA/p3OaeS6VNkS9TM6s82e8qlWVtv+LSCAzyRSpUDmth4j9l6tIIgd7Mm13XQGkp
	MWnLmul/oVPy+/mcaaCeIPu1qXcI5KJZPOpyfn6mLTcuRzHl0Hq+sy2i1ETwVZEGFZvMfMwCB40
	8tQANmtRERUVhejVe5R804PzLV9DcOhY2qkutxUZAS7fFHbu/mMpcrqnVbNuied/GjdKu1ft7dx
	YIMT3RPA4Am2+utWGBbi1K3/S
X-Received: by 2002:a17:90b:1dc7:b0:3ad:183f:5e3a with SMTP id 98e67ed59e1d1-3ade9b2edcemr4941249a91.4.1792983984805;
        Sun, 25 Oct 2026 20:06:24 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacc885sm6428881a91.5.2026.10.25.20.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:24 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 68/81] bpf: Track a pointer to one of a set of functions
Date: Mon, 26 Oct 2026 02:59:29 +0000
Message-ID: <20261026025943.404450-69-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

'ops[i](x)' in C compiles to a load from a table of functions at a variable
offset and then callx. A call of a method of a trait object in Rust
compiles to the same code. At the load the verifier splits the state into N
states, one for each function that the load can return. The states differ
only in this register, but the verifier verifies the code from the load to
callx N times.

The states also count against the limit of 1024 states at one insn
(BPF_FLOW_MAX_STATES). In a prog of rust-bpf (Rust compiled to BPF) fmt()
of a trait object has 245 implementations. 3 states get to the load, and
each adds 244 states. The result is 732 states at one insn.

Do not split the state at the load. The register holds a pointer to one of
N functions until an insn must know the function.

             before                             this patch

     r3 = *(u64 *)(r3 + 8)                r3 = *(u64 *)(r3 + 8)
      /        |        \                           |
   r3=f1     r3=f2 ...  r3=fN               r3 = one of f1 .. fN
     |         |          |                         |
    ...       ...        ...                       ...
     |         |          |                         |
  callx r3  callx r3   callx r3                 callx r3
     |         |          |                    /    |    \
    f1        f2         fN                  f1    f2 ... fN

callx verifies each function of the set. Thus the verifier verifies the
same calls as before. The verifier log shows the register in this way:

  r3 = *(u64 *)(r3 +8)          ; R3=func(one_of=245)

The register holds the number of a set (func_set), and equal sets have the
same number. Thus the code that compares states does not change.

  insn that must know the function  what the verifier does
  --------------------------------  ---------------------------------------
  callx, func_is_on_its_own()       A copy of the state of the caller waits
                                    for the exit states of the function.
  callx, other functions            Each function gets a state at callx.
  call of a helper or a kfunc,      Each function gets a state at the call.
  the pointer is an argument        A callback is one function.

func_is_on_its_own() is true for most functions. The verifier verifies such
a function for the states at its entry, and not again for each caller. The
copy that waits is not a state at an insn. Thus it does not count against
the limit.

Limitations:
 - Only the load makes a set. Two pointers to functions that come from two
   branches of a prog continue to be two states.
 - The verifier does not know that two copies of the pointer are equal.
   After 'r6 = r2; callx r2' a subsequent 'callx r6' verifies all N
   functions. Code that is dead only when the two calls go to the same
   function stays in the prog.

In the prog above the largest number of states at one insn changes from 732
to 159.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  15 +++-
 kernel/bpf/log.c             |   2 +
 kernel/bpf/verifier.c        | 168 +++++++++++++++++++++++++++++------
 3 files changed, 158 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0cd7fa277fe5..3bd2965e531e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -121,7 +121,11 @@ struct bpf_reg_state {
 			unsigned long raw2;
 		} raw;
 
-		u32 subprogno; /* for PTR_TO_FUNC */
+		struct { /* for PTR_TO_FUNC */
+			u32 subprogno;
+			/* if not 0: one of env->func_sets[func_set - 1], subprogno is 0 */
+			u32 func_set;
+		};
 	};
 	/* For scalar types (SCALAR_VALUE), this represents our knowledge of
 	 * the actual value.
@@ -1036,6 +1040,9 @@ struct bpf_verifier_env {
 	 */
 	struct bpf_func_ptr *func_ptrs;
 	u32 func_ptr_cnt;
+	/* What a pointer that was read from a table of functions may point to. */
+	struct bpf_func_set **func_sets;
+	u32 func_set_cnt;
 	bool has_callx;
 	/*
 	 * Call graph edges created by callx instructions. A bitmap of
@@ -1402,6 +1409,12 @@ static inline bool bpf_register_is_null(struct bpf_reg_state *reg)
 }
 
 bool bpf_map_is_rdonly(const struct bpf_map *map);
+/* Sorted, no function is there twice */
+struct bpf_func_set {
+	u16 cnt;
+	u16 subprog[] __counted_by(cnt);
+};
+
 struct bpf_func_ptr *bpf_map_func_ptrs(struct bpf_verifier_env *env,
 				       const struct bpf_map *map, u32 *cnt);
 struct bpf_func_ptr *bpf_map_range_func_ptrs(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 0013ab01e72d..3d26b0b7ed46 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -656,6 +656,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
 		verbose_a("%s", "non_own_ref");
+	if (t == PTR_TO_FUNC && reg->func_set)
+		verbose_a("one_of=%d", env->func_sets[reg->func_set - 1]->cnt);
 	if (type_is_map_ptr(t)) {
 		if (reg->map_ptr->name[0])
 			verbose_a("map=%s", reg->map_ptr->name);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21ea43422133..6c6980d74fd6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6935,7 +6935,52 @@ static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state
 	regs[regno].subprogno = subprog;
 }
 
-/* a read from a table of functions branches into that many states at most */
+static int cmp_u16(const void *a, const void *b)
+{
+	return *(const u16 *)a - *(const u16 *)b;
+}
+
+/*
+ * Pointers to functions have a join: the set of the functions. The states would differ in
+ * nothing else up to the call, and there every function of the set is verified.
+ * Equal sets have the same number, so registers are compared as they are.
+ */
+static int mark_reg_func_set(struct bpf_verifier_env *env, struct bpf_reg_state *regs, int regno,
+			     u16 *subprogs, u32 cnt)
+{
+	struct bpf_func_set **sets, *set;
+	u32 i, n = 0;
+
+	sort(subprogs, cnt, sizeof(*subprogs), cmp_u16, NULL);
+	for (i = 0; i < cnt; i++)
+		if (!n || subprogs[n - 1] != subprogs[i])
+			subprogs[n++] = subprogs[i];
+	mark_reg_func_ptr(env, regs, regno, n == 1 ? subprogs[0] : 0);
+	if (n == 1)
+		return 0;
+
+	for (i = 0; i < env->func_set_cnt; i++) {
+		set = env->func_sets[i];
+		if (set->cnt == n && !memcmp(set->subprog, subprogs, n * sizeof(*subprogs)))
+			break;
+	}
+	if (i == env->func_set_cnt) {
+		sets = krealloc_array(env->func_sets, i + 1, sizeof(*sets), GFP_KERNEL_ACCOUNT);
+		if (!sets)
+			return -ENOMEM;
+		env->func_sets = sets;
+		set = kzalloc_flex(*set, subprog, n, GFP_KERNEL_ACCOUNT);
+		if (!set)
+			return -ENOMEM;
+		set->cnt = n;
+		memcpy(set->subprog, subprogs, n * sizeof(*subprogs));
+		sets[env->func_set_cnt++] = set;
+	}
+	regs[regno].func_set = i + 1;
+	return 0;
+}
+
+/* a read from a table of functions yields one of that many at most */
 #define BPF_MAX_FUNC_PTR_TARGETS BPF_MAX_SUBPROGS
 /* and that many pointers at most are next to what is read at variable offset */
 #define BPF_MAX_FUNC_PTR_RANGE 4096
@@ -6968,7 +7013,7 @@ static u32 count_read_offsets(struct tnum offs, u64 min_off, u64 max_off, u32 li
  * is possible at, e.g. var_off is the stride of the elements of an array.
  * A read of exactly one pointer yields PTR_TO_FUNC. When the offset is variable
  * and only pointers can be read, which is how an element of a table of
- * functions is loaded, the verification continues with each of them. Other
+ * functions is loaded, it is one of them, see mark_reg_func_set(). Other
  * reads that overlap with a pointer are rejected, because their result is not
  * known until the program is jitted.
  *
@@ -6981,7 +7026,6 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	struct tnum offs = tnum_add(reg->var_off, tnum_const(off));
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = reg->map_ptr;
-	struct bpf_verifier_state *branch;
 	u16 *targets __free(kfree) = NULL;
 	struct bpf_func_ptr *ptrs;
 	u32 i, cnt, n = 0;
@@ -7032,16 +7076,7 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	if (err)
 		return err;
 
-	for (i = 0; i < n - 1; i++) {
-		branch = push_stack(env, env->insn_idx + 1, env->insn_idx,
-				    env->cur_state->speculative);
-		if (IS_ERR(branch))
-			return PTR_ERR(branch);
-		mark_reg_func_ptr(env, branch->frame[branch->curframe]->regs, value_regno,
-				  targets[i]);
-	}
-	mark_reg_func_ptr(env, regs, value_regno, targets[n - 1]);
-	return 0;
+	return mark_reg_func_set(env, regs, value_regno, targets, n);
 
 overlap:
 	verbose(env, "read of %d bytes at offset [%llu,%llu] of map '%s' overlaps with a pointer to a function\n",
@@ -11757,13 +11792,92 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
  * PTR_TO_FUNC register identifies the callee, so from here on callx is verified
  * as a direct call of that static subprog.
  */
+static int check_func_callx_one(struct bpf_verifier_env *env, int subprog, int *insn_idx)
+{
+	int err;
+
+	err = btf_check_subprog_call(env, subprog);
+	if (err == -EFAULT)
+		return err;
+
+	err = record_callx_edge(env, cur_func(env)->subprogno, subprog);
+	if (err)
+		return err;
+
+	return check_static_func_call(env, subprog, insn_idx);
+}
+
+/* The insn needs to know the function: go on with each function of the set. */
+static int split_func_set(struct bpf_verifier_env *env, int regno)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_verifier_state *branch;
+	struct bpf_func_set *set;
+	u32 i;
+
+	if (reg->type != PTR_TO_FUNC || !reg->func_set)
+		return 0;
+	set = env->func_sets[reg->func_set - 1];
+	reg->func_set = 0;
+	for (i = 0; i < set->cnt; i++) {
+		reg->subprogno = set->subprog[i];
+		if (i == set->cnt - 1)
+			break;
+		branch = push_stack(env, env->insn_idx, env->insn_idx, false);
+		if (IS_ERR(branch))
+			return PTR_ERR(branch);
+	}
+	return 0;
+}
+
+/*
+ * callx of one of the functions of a set. A function that is verified on its own
+ * gets a copy of the state that waits for it. Nothing meets at an insn.
+ */
+static int check_func_callx_set(struct bpf_verifier_env *env, int regno, int *insn_idx)
+{
+	struct bpf_verifier_state *cur = env->cur_state, *copy, *branch;
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_func_set *set = env->func_sets[reg->func_set - 1];
+	int err = 0;
+	u32 i;
+
+	/* once, and not in every copy */
+	account_current_path(env);
+	reg->func_set = 0;
+	for (i = 0; i < set->cnt && !err; i++) {
+		reg->subprogno = set->subprog[i];
+		if (!func_is_on_its_own(env, cur, set->subprog[i])) {
+			branch = push_stack(env, *insn_idx, *insn_idx, false);
+			if (IS_ERR(branch))
+				return PTR_ERR(branch);
+			continue;
+		}
+		copy = kzalloc_obj(*copy, GFP_KERNEL_ACCOUNT);
+		if (!copy)
+			return -ENOMEM;
+		err = bpf_copy_verifier_state(copy, cur);
+		if (!err) {
+			env->cur_state = copy;
+			err = check_func_callx_one(env, set->subprog[i], insn_idx);
+			env->cur_state = cur;
+		}
+		bpf_free_verifier_state(copy, true);
+		if (err == PROCESS_BPF_EXIT)
+			err = 0;
+		else if (verifier_bug_if(!err, env, "callx: func#%d doesn't wait", set->subprog[i]))
+			err = -EFAULT;
+	}
+	/* all that is to be done has a state of its own */
+	return err ?: PROCESS_BPF_EXIT;
+}
+
 static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx)
 {
-	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_reg_state *reg;
 	const char *reason;
-	int err, subprog;
+	int err;
 
 	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 	if (err)
@@ -11796,16 +11910,9 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 
 	/* PTR_TO_FUNC is a pointer to a static subprog */
-	subprog = reg->subprogno;
-	err = btf_check_subprog_call(env, subprog);
-	if (err == -EFAULT)
-		return err;
-
-	err = record_callx_edge(env, caller->subprogno, subprog);
-	if (err)
-		return err;
-
-	return check_static_func_call(env, subprog, insn_idx);
+	if (reg->func_set)
+		return check_func_callx_set(env, insn->dst_reg, insn_idx);
+	return check_func_callx_one(env, reg->subprogno, insn_idx);
 }
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
@@ -20484,7 +20591,7 @@ static void null_to_arena(struct bpf_verifier_env *env, int regno)
 
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
-	int err;
+	int err, i;
 	struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
 	u8 class = BPF_CLASS(insn->code);
 
@@ -20566,6 +20673,12 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				return check_func_callx(env, insn, &env->insn_idx);
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				return check_func_call(env, insn, &env->insn_idx);
+			/* a callback is one function */
+			for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
+				err = split_func_set(env, i);
+				if (err)
+					return err;
+			}
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
 				return check_kfunc_call(env, insn, &env->insn_idx);
 			return check_helper_call(env, insn, &env->insn_idx);
@@ -24878,6 +24991,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->gotox_tmp_buf);
 	kvfree(env->callx_edges);
 	kvfree(env->func_ptrs);
+	for (i = 0; i < env->func_set_cnt; i++)
+		kfree(env->func_sets[i]);
+	kfree(env->func_sets);
 	bpf_diag_free(env);
 	kvfree(env->idoms);
 	kvfree(env);
-- 
2.55.0

