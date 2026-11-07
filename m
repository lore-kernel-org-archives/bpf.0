Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022847;
	b=BCPNdukD2GJ06PQkCGr+0RjMZ9Sk9U6QsQYSH/6DhEeZM4Zyb4FVYrZ6FDjsjTClmz3D
	 n6Nm/H5bGDbKXfDMhTGQoVN7hjWiflPPRI6a6/dK65sxluxB/hgFlHlKtFxCTELNNFxjQ
	 vngBZa7QJgvnSrdLmV/f3wqEbbTBT5dJXdWpPhCBSn6zR4rXwxBLIrptFQVdE4dxVDV4b
	 ThsLAuDLHvBQoB9aIkZkpC3z471m0q5PRrICE499uvTMWN2kXW58CFimVl4xKJsxBAxqB
	 dJSSEIjDDt4Z6yAbJo9WtUZsnUN1a9xOSYBingI4UjUrTXXfKTl0rACkpQaJYOQzM2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9I+ZTWxUdfAPl03hnVJjzs7iAtRLAyb0DeGAxN1+5xs=;
	b=Q/8RTeWuDxYHNNQhd2XSH0BqUi0c923CBz5IWdboNrzJ8TWXcunNdGk7L5zzNWPfjX5p
	 H806MAVtsIWElQ0UJ1x6Lvzk4+xqEh+1pJxMp1BQqB8HbkV6Bf4noclHdVSKIppGuCsKG
	 yYmCS6230nj0nllZPfW5og/mhX2scHyEGuCP8gvnd0cK0+WFDBerNA/cPMOJH9C24fVx2
	 eaGnzEfOv4KyiCmm+Oua5YUOAjecEMfPREHUFnVBFgMTmD4ULfgLLkl7oIu6Jl/7DLKg8
	 aXgh8xNOoPpA3I798vo6a246kP8zi5vux43JFyxGDLFEYFZv3EMGNcHIpOHsQ2amhpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yI+PxKCq;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B4606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB3B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yI+PxKCq
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so718840a91.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022846; x=1794627646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9I+ZTWxUdfAPl03hnVJjzs7iAtRLAyb0DeGAxN1+5xs=;
        b=yI+PxKCqQiRvbgcrwCdtBcm9zpRKDM3lBsejXVQyFym886MEHms3UhbgU9X3+tr9xA
         3NcOuXwmkrN2JNkglXYWaxK4ftCfOQkeVpOvV/MSPzsWQ629aovrB4VV0CV+cs6F9vKl
         VueGRuJ4HhKK4uZ/8jGL5jIJMsKXgLYUgLnOcJB3Lde5kc1y8MTHhMIBakTUqDid87yP
         PJ6mpxV0heL3YwLDSRugwkw2tSrqt27tvRITWUY0n0d+uP3Ed6r/C7Jai1PAph2jPWrP
         KmGecO/Ku2FqtsWO+9fMai/1P33CH4+wzYfG0KugJZfHuvZKs55KkK6x64HUPDYUMMUB
         yVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022846; x=1794627646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9I+ZTWxUdfAPl03hnVJjzs7iAtRLAyb0DeGAxN1+5xs=;
        b=cgzGnpGL6oDPH4k3w0GHhAJ/JMZoZmTkYABCqKfe0BvxOfCqBzKnJd7Tr2U/SGuwju
         dDzK3Jrw1stUT0X+2CZLCmhP728El+Srtgo9SQQT7ozsqXve37Q0dmUc4S2QxtAa0qDV
         RKHYH0qT5e8SuKpom1hzh2EpdGh7j3FNew9oORBRMbuO9DKS62AdtWysiYJw83IMKRIq
         e9o4JdQpWLg7+2N2E37VxzCZXwPXBIVOpplx2yWvTNG5vM/+/R64g4nD+loFcNZ4Ti7p
         xgtzcO2BvmfvaJnJ7pQkNGHNWw17Yp0YQVvISluL0b9Ok8UhTY6HzeoAkU0WFP+aqQMX
         5QNw==
X-Gm-Message-State: APuU4Z+vTvsuST9jQoi+SeUJcP52/uaVMl/5vubpljoz2Dk4wzOmNrVC
	yKZN0UEye2lR9pPLPamCSMcV3pISMZkyWSy6L87VviAwFRtWExtAGcDr18Apmg==
X-Gm-Gg: AYBFou2YnsLGZyxpEaGkeYc5waCVo7FnqejAzKOMieEoOh0CDQxzYqPwLRlO5ZW9VTX
	io3EEjztQkA1aMM4fIcxbcDajoRsTf9j2sPYel8a6Yes5XM1ZN5M5dyNOiKadLjQowDY/uNXqLm
	AjrvunsETbx2s7vleB5KcumeEr+rBJYKgpsjmVDLNWHVWmJUI33e0rWdbnTuVgxW5e5AozBJ7KK
	Awo2J/s/DbwoYC2cN0s6T6esgTkICe9zRkEN+4ZfTaA4mKe+il2pFdNJczPAHRzzrxQNTxGacZ0
	A6okxN0LXnyltQtYxNZbU3OmFkaPVJaq9aJ6ik+GTqcNdN9Qr0aOP+79UrshWLWwuPuKDvyL4HG
	XYQMvMxVCAGomAvVc8m1UQv3Wt/6W4p/j2lBD8e6/I2sexEjbtJl4jgCNQ6nPT7YNfkhidNYRGE
	XdPqi+GtHBnccUDvw7ULvMrhJpx/QOB8yvriHQWE59xKU5IK9VhU04uymT1qXD6Y0QI5S0x80pO
	rOVwrBVKrnj8Mm5kR6xcQJMq3rZQttr6h8amb5JNYX42VtfNGBrqnwyyW3ydq2QrZZZQb3kOhl0
	ZPBixZlIJzZfF3JWQ72R0Akmy85jExR6RXcopJ6YCJhyPsbpgm/A0majg8/djXbID2TYAZHUYIx
	EpoZ96FNj9ezX5+Y5+rRNPAn+51XKFzJQYp0HNW9aOpaPjd8gCiKu3S9qx44vssa9dYFamXn2CB
	xFQk6912RVbH8TSRYJOaHo
X-Received: by 2002:a17:90b:3951:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3b0db6e53e2mr4387756a91.25.1794022845825;
        Fri, 06 Nov 2026 19:40:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058d2faesm1554159a91.14.2026.11.06.19.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 27/46] bpf: Track a pointer to one of a set of functions
Date: Sat,  7 Nov 2026 03:37:35 +0000
Message-ID: <20261107033758.1547725-28-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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
index 6e855ef0b6e6..098b3c30c8b2 100644
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
@@ -1228,6 +1232,9 @@ struct bpf_verifier_env {
 	 */
 	struct bpf_func_ptr *func_ptrs;
 	u32 func_ptr_cnt;
+	/* What a pointer that was read from a table of functions may point to. */
+	struct bpf_func_set **func_sets;
+	u32 func_set_cnt;
 	bool has_callx;
 	/*
 	 * Call graph edges created by callx instructions. A bitmap of
@@ -1610,6 +1617,12 @@ static inline bool bpf_register_is_null(struct bpf_reg_state *reg)
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
index 7769b4bd1467..a5c3e86f3f87 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7207,7 +7207,60 @@ static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state
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
@@ -7240,7 +7293,7 @@ static u32 count_read_offsets(struct tnum offs, u64 min_off, u64 max_off, u32 li
  * is possible at, e.g. var_off is the stride of the elements of an array.
  * A read of exactly one pointer yields PTR_TO_FUNC. When the offset is variable
  * and only pointers can be read, which is how an element of a table of
- * functions is loaded, the verification continues with each of them. Other
+ * functions is loaded, it is one of them, see mark_reg_func_set(). Other
  * reads that overlap with a pointer are rejected, because their result is not
  * known until the program is jitted.
  *
@@ -7253,7 +7306,6 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	struct tnum offs = tnum_add(reg->var_off, tnum_const(off));
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = reg->map_ptr;
-	struct bpf_verifier_state *branch;
 	u16 *targets __free(kfree) = NULL;
 	struct bpf_func_ptr *ptrs;
 	u32 i, cnt, n = 0;
@@ -7304,16 +7356,7 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -11609,7 +11652,8 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 		if (arg_needs_caller(env, state, sub, &caller->regs[i]))
 			return false;
 	}
-	for (i = 0; i < bpf_in_stack_arg_cnt(sub); i++) {
+	/* callx of one function of a set asks before it is checked that the arguments are there */
+	for (i = 0; i < bpf_in_stack_arg_cnt(sub) && i < caller->out_stack_arg_cnt; i++) {
 		if (caller->stack_arg_regs[i].type == PTR_TO_STACK ||
 		    base_type(caller->stack_arg_regs[i].type) == CONST_PTR_TO_DYNPTR)
 			return false;
@@ -12044,13 +12088,93 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -12083,17 +12207,9 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -20932,7 +21048,7 @@ static int check_arena_sp_insn(struct bpf_verifier_env *env, struct bpf_insn *in
 
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
-	int err;
+	int err, i;
 	struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
 	u8 class = BPF_CLASS(insn->code);
 
@@ -21009,6 +21125,12 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
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
@@ -25519,6 +25641,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

