Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937233;
	b=svqbYJrERKB45ZP412teiI6PA+tOYn+roOgas4+zuUQaEMHoUH+1Xr4Ga4eQyWo0LWA9
	 j67mn1lahIqlIfLIhL+ufDDUcg/59mnUmM7F4XyermCYK3vlPF7ud05E8Zhp0/mi1JTll
	 7FODy+ymmcAObII42UPNd6FBlHScJGI4fMy9Rp2llpuT3Qcfj0aawERHWN2iuZfyyXBVS
	 t1FUuTaGPF4G5RjGjsVhMseyfy5zDfluWfedGhONYPU9SsNu8/vcE0teO7VZ80XZpTVdZ
	 4SDWBhqJ3rCoXesDBcVGolakn1E68ETiAfSYCSTpc8ZPMZaHnkkfPbnYQft93Qb9wuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qa7JKlky6HawhWWt43uc1tRTj4J6KjKgscH3f65iB+Y=;
	b=AnlKO+v/YcP4ExivCV/UF4lg70FkQWtjKdn+/dpk3SpzT0KyIZfjVXNgcwimlPxk9QPh
	 vnJYmGJRazGRcf53pwAP8meuJkycGyoAV8lP4sGbnNTlVbaew6AM+E8KX04DGpOXcrOhT
	 wQ9uU5mmW7/8DZNxuDeIJJJDbrReEUIE7tER1Kp0GDjfpoePLJlIF7TZyiWJIiSdv4ma7
	 KydNW2NmaEfV3GtuvoVwXn93LHwve7+bdfhX1e0lZsdyPF4jLVU718Z08ES4uyiwmh5FV
	 DR64q3gqSstHZ6FNn//d8OnqGfthER8eVh4Wk3tN1aDRekPhH/tojvuXr0zLaiyEjUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8MoncF2;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29001606A328
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29001606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8MoncF2
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so68890b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937232; x=1794542032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qa7JKlky6HawhWWt43uc1tRTj4J6KjKgscH3f65iB+Y=;
        b=g8MoncF2rN8HpEqr57ruHA2sUVVyfBDeKPpH1rr7PvCtuaItMRDsZxNV1Bx0vzeNfd
         cF9C7OMT951qd0hiUyi2ltDjKsVtOrdqDR9lzI+FHCouYwaibv4DOYXT+hdQOumamIRl
         dAIeV8oRxrOlDGjtTnw4h48vdhjrnH5hd8WtF58dg9SWEQHgr65fxnAKHJG+wktpXzqn
         pgj0dUirV9Pv5Y6XcUGox1YnfvaibzIxS4LcopnKGVJPSCjG7S7lzRsFyWulCyhAUhos
         kNdBA+zcew5eYkGVNzbM5v8ZAiFpp3+O+b68AAl4pvbAX2nZI5ilYMOraH0ZlMoRWwQG
         tmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937232; x=1794542032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qa7JKlky6HawhWWt43uc1tRTj4J6KjKgscH3f65iB+Y=;
        b=WRVU2n49wjGjlgf1zmKHxiwLADJ/6Ge5KCqApsreZdW4WgiZnrERjS5q2TA3Ysz2XF
         8/U/qhVRo9Y0+4uC6oXiu14KB+y+V61tEhMz2FhrPxfOQzlbzyAzYsLq+pzQQ4qZfzrb
         pdVDVosV3Y3Rq1+KxjToPBbYmrcvMT5+OpteVjmY3LhXivBa+z06+VSAr430YINwnSlm
         hrKRKwduUsMmkdu8XWRLvkHUZZ22pmJSmrpjLePepXGksvxqA+wxOrY8bubqus+rFXDb
         ad4QHaLPY7JWMM24zN+nRfsvnlQr81AAsIPrnBlG0P8m4h6mbGogPWI9J1DhjIte+tCA
         FNzA==
X-Gm-Message-State: APuU4Z/fXX5Dtf5qZFsGjOG47nY4HdZniP1OzFbEX/TPd4ynJ7oPWQWt
	Lh141y7CH+XgnsWzVP6exLdov6YMcdYh3rLetUjlVofSmR7Jb6zamDRBpqZ1Og==
X-Gm-Gg: AYBFou3OE9DN4yyph20jncfMyyZ9Bx6YwqFDo+FK+0TGxto0A412OR2ZS/yolK+PuN8
	LElqUdtsGLFRV0JuzAGFgfezfN7Fpx59TeATBEP5VP4TMtdI5/zYFS1sPOw1Wkyv3MTn8iPuV+M
	0yxVmC/Jrhz8O9kP8MgxeFRr9w5XMgWVWXN7R2KgcMJXTUMuS8c8czvudp7ZKzha2bpBombEda/
	UpmwhfKeqIiat05LRovFhBMfjAlLYdHLBm29UG8oWrBgT7X3IupaKnU51YthEmxyR/jzuLT1Nuf
	DWQ3FB+g3q4t1JYWfkoj3eoqSBD4v7bHcXOB2N3xSJZMvZJBa+r+ZFly9JDeF8pcdd9cjtaDOaG
	By9GGzp9z1GC71O/d8KBryz/YheoDTburIPFHNk8HW1pEUoe81+AOQnur0AIuLbbJKAjOGWTpxm
	GGZ170t5d46dYQ8qp77nB9jSBU3iNpcTjjKQWGKfMHWfzTZqSSvfimAjgeeU55ZwwnkDhi2jSjb
	G1TPoboP7VxSswabnWemKI3eSmdWuFaF6KeyIH8vUbEhdkegGmj0Lf9ynToBKIp3rKnIwMvGs/8
	tSmtwhF84gkfkLuu7AWCNup0MA2PfAiMN5qsOoq+MZXEYnvBf+v07HpWW6jLDR1ujZXbcS4pEbF
	PUGFWCzPoi+s8JH//94VBxYuVPR+C1qFZ7E6fZSOGcFpjUhFWoAyoNDecwELhEXkdKdjuF+ZAow
	==
X-Received: by 2002:a05:6a00:2e17:b0:881:fffd:26ab with SMTP id d2e1a72fcca58-8b37aca15eemr1285219b3a.24.1793937232220;
        Thu, 05 Nov 2026 19:53:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b35a3b3a2dsm206633b3a.45.2026.11.05.19.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:53:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 27/45] bpf: Track a pointer to one of a set of functions
Date: Fri,  6 Nov 2026 03:50:51 +0000
Message-ID: <20261106035111.3315285-28-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

Each '{}' of a format string in Rust ends in core::fmt::write(), which
calls the fmt() function of the argument through a pointer:

  ArgumentType::Placeholder { formatter, value, .. } => formatter(value, f)

rust-bpf compiles it to a load from the table of all fmt() functions of the
object, and callx. k2_text.o of its corpus, with serde_json, uuid, semver,
ryu and regex-automata, has 245. At the load the verifier goes on with one
function and makes a state for each of the other 244. 3 states get to the
load: 732 states that differ only in r3 meet at the next insn. The limit is
1024. Each more type with Display or Debug adds 3 states, and 100 more
types give "more than 1024 states that cannot be joined at insn N".

  if r2 < 244 goto +1
  r2 = 244
  r2 <<= 3
  r2 += r3                 ; the table, in a read-only map
  r3 = *(u64 *)(r2 + 8)
  ...
  callx r3

Do not split the state at the load. r3 is a pointer to one of a set of
functions until an insn must know the function.

     r3 = *(u64 *)(r2 + 8)              r3 = *(u64 *)(r2 + 8)
      /        |        \                         |
   r3=f1     r3=f2 ...  r3=fN             r3 = one of f1 .. fN
     |         |          |                       |
  callx r3  callx r3   callx r3               callx r3
     |         |          |                  /    |    \
    f1        f2         fN                f1    f2 ... fN

The register holds the number of the set, and equal sets have the same
number. Thus the code that compares and joins registers does not change.
The log shows R3=func(one_of=245).

callx verifies each function of the set, as before. For a function that is
verified on its own, a copy of the state of the caller waits for its exit
states. The copy is not a state at an insn. Other functions, and a helper
or a kfunc that gets the pointer as a callback, get one state for each
function. uuid_semver of k2_text.o: 732 -> 257 states at an insn and
-19 % insns.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  15 ++-
 kernel/bpf/log.c             |   2 +
 kernel/bpf/verifier.c        | 181 +++++++++++++++++++++++++++++------
 3 files changed, 169 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6d385819bcf5..9b7c31fefe72 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -140,7 +140,11 @@ struct bpf_reg_state {
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
@@ -1209,6 +1213,9 @@ struct bpf_verifier_env {
 	 */
 	struct bpf_func_ptr *func_ptrs;
 	u32 func_ptr_cnt;
+	/* What a pointer that was read from a table of functions may point to. */
+	struct bpf_func_set **func_sets;
+	u32 func_set_cnt;
 	bool has_callx;
 	/*
 	 * Call graph edges created by callx instructions. A bitmap of
@@ -1588,6 +1595,12 @@ static inline bool bpf_register_is_null(struct bpf_reg_state *reg)
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
index db496253bf62..1253118dfd05 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -664,6 +664,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
 		verbose_a("%s", "non_own_ref");
+	if (t == PTR_TO_FUNC && reg->func_set)
+		verbose_a("one_of=%d", env->func_sets[reg->func_set - 1]->cnt);
 	if (type_is_map_ptr(t)) {
 		if (reg->map_ptr->name[0])
 			verbose_a("map=%s", reg->map_ptr->name);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 437a3fc03d0b..41500f03b41b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7196,7 +7196,60 @@ static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state
 	regs[regno].subprogno = subprog;
 }
 
-/* a read from a table of functions branches into that many states at most */
+static int cmp_u16(const void *a, const void *b)
+{
+	return *(const u16 *)a - *(const u16 *)b;
+}
+
+/* that many different sets at most: each load from a table looks through all of them */
+#define BPF_MAX_FUNC_SETS 4096
+
+/*
+ * A load from a table of functions gives one register: a pointer to one of a set of functions.
+ * One state for each function would differ in nothing else up to the call, and there every
+ * function of the set is verified.
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
+		if (i == BPF_MAX_FUNC_SETS) {
+			verbose(env, "more than %d sets of functions\n", BPF_MAX_FUNC_SETS);
+			return -E2BIG;
+		}
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
@@ -7229,7 +7282,7 @@ static u32 count_read_offsets(struct tnum offs, u64 min_off, u64 max_off, u32 li
  * is possible at, e.g. var_off is the stride of the elements of an array.
  * A read of exactly one pointer yields PTR_TO_FUNC. When the offset is variable
  * and only pointers can be read, which is how an element of a table of
- * functions is loaded, the verification continues with each of them. Other
+ * functions is loaded, it is one of them, see mark_reg_func_set(). Other
  * reads that overlap with a pointer are rejected, because their result is not
  * known until the program is jitted.
  *
@@ -7242,7 +7295,6 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	struct tnum offs = tnum_add(reg->var_off, tnum_const(off));
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = reg->map_ptr;
-	struct bpf_verifier_state *branch;
 	u16 *targets __free(kfree) = NULL;
 	struct bpf_func_ptr *ptrs;
 	u32 i, cnt, n = 0;
@@ -7293,16 +7345,7 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -11593,7 +11636,8 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 		if (arg_needs_caller(state, sub, &caller->regs[i]))
 			return false;
 	}
-	for (i = 0; i < bpf_in_stack_arg_cnt(sub); i++) {
+	/* callx of one function of a set asks before it is checked that the arguments are there */
+	for (i = 0; i < bpf_in_stack_arg_cnt(sub) && i < caller->out_stack_arg_cnt; i++) {
 		if (caller->stack_arg_regs[i].type == PTR_TO_STACK ||
 		    base_type(caller->stack_arg_regs[i].type) == CONST_PTR_TO_DYNPTR)
 			return false;
@@ -12028,13 +12072,93 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
+	env->subprog_info[subprog].via_callx = true;
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
@@ -12067,17 +12191,9 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
-	env->subprog_info[subprog].via_callx = true;
-
-	return check_static_func_call(env, subprog, insn_idx);
+	if (reg->func_set)
+		return check_func_callx_set(env, insn->dst_reg, insn_idx);
+	return check_func_callx_one(env, reg->subprogno, insn_idx);
 }
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
@@ -20875,7 +20991,7 @@ static int check_arena_sp_insn(struct bpf_verifier_env *env, struct bpf_insn *in
 
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
-	int err;
+	int err, i;
 	struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
 	u8 class = BPF_CLASS(insn->code);
 
@@ -20952,6 +21068,12 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
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
@@ -25432,6 +25554,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

