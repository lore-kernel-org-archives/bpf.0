Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911677;
	b=ngMB7WgF9X8vap2Ld6T9js0qNHToCoHzksmhwYm69OHKAaBJ40FcBzlk2ZLZyedxfVfW
	 I5FtUmCX5ILUvUxcx/oMJ+uR3L9udT266igRLduYDg0FHCa9lQJBs/iR1MwBDzOjwfmqb
	 4GazaaZuIyfelwMCsRRFT2IOvl1CSIJv72lkklwBeAiUmPqRtJSNi2BYKbToUD84Ln7o1
	 gNDcwOMGPkv208tMq8eAy90ULfUhK0ywOPV/fIt7NtF5S6zYL/ZvBD+/5xJyxMXBBHRfb
	 +xZNgEHrynkMDfdWtZ4DnU4BFXbOSEbKWoihEJfVRkpchGdCQ4624QfBa5rOJeqAv7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IGdicfj115Bt5c0PIOm37SzEQpuHXiQvfT/JKAV5VCY=;
	b=tf0ShkOJfTKv/RQey+zOEtIcASiC8eG3uX+W1EtB/DfjgjEIRw/2W1VXepa2PAKOVjxX
	 NuPaGS1gHVSZEE/D1Y10m1FM8+aCEwd8n9+PZaqrV0HyshN5QKThymcwFepJNTYvWx23n
	 dqH8YFfH6F+QKAAlPy3Hbse1jUlhXBUj+LyMVjERoFnhTnhETb9VhOdCnUd/sse+8rLV+
	 kMp9eX36Oy+vC2pw4RVjz1rMnbMmOpLIK+Y5QYk85e+oyOj5fHXzhjvyKu0ecyezl+pLF
	 mo3ygIlG+oV1QTSmU2Vf30bhzG1cjx0/tDKWyWov88Ecrt74ygYcwCJMbTdNOVAlOAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMkq22rL;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD07606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AD07606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMkq22rL
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1129782a91.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911677; x=1794516477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGdicfj115Bt5c0PIOm37SzEQpuHXiQvfT/JKAV5VCY=;
        b=AMkq22rLSjegDwMG/wY+PxaoTcfI9ZGE3no97bho9gycfLPTDV4DsjdJUT8ApQcLE9
         FaYl3AAolb216qoxbLq35IkQugXMUrmwp/8t/eW9ughEjAGrGhdoVFnZJhWLs/fU2/1c
         ar0FofKJFuAMXAO4wzHWs//IGrM5jtim0liZTGUegf8zwgOnVEoNavgXdiOIunNa81pg
         AWWpo34zHwGE5Qb0Z/BOlqECKpEPw85r2l/1TnAvKln8qPNIoq+XqdMucuOS1dMd1hWN
         xsYhHHH7po/a5upZwi+zjposzVIydJH85YOnGMWVctJikvw63gl6Ib8TAyQVjX08bklp
         RRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911677; x=1794516477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGdicfj115Bt5c0PIOm37SzEQpuHXiQvfT/JKAV5VCY=;
        b=Ef8Yr5/Fqq9cM3MigwEDS7DWUL+UtmcNm2vTfixVQIyRrB8OR9gKTuX9eZ0Pb+IHnD
         XtdxI0W4Sc5/TZcVoWOQIxiNcUaZKLH8GTsCiDcRk5NI3RbYrg2ykkkVW7SRNyGyl4/t
         f9TYB+YHj+gMw7hcoS8bQtoO+fKaBsJ7De9AFiCBnV3zmvItjXAExebgqEy1jnA86sIv
         o/Z95ERwnF5AQGi1Gc6ENJ/BrUEBNekXcPu1Ur3cnzbtYhOiVYGAIBohiACzfL6wFzIn
         1+00BAKNKtYl+XNi5fls5/hvNpIFnMkaU1ViEMuLFr/Y0INO4XkXe3dYQbysNUkfDlrY
         p96w==
X-Gm-Message-State: APuU4Z9qzTU5TrNusULwU/LSTDbkLHXF5/m0/VPyZ5IT0FRXDYhLanJ0
	Af+X5XmA+QiPFsf0Lur2U3uHLms4V3HwEs2VgFM5Fw/c4JwxSQXcM6oF8/ExcQ==
X-Gm-Gg: AYBFou1jVk+smt2ZHO3bcu3V8+ub1fsIIpfa5buVZ+xO6Dlv97qywVja095niNlfran
	gS6bFtQto7nmCxirP+3zEzPfBZRaSutTyoxH4SO2Qc+n3oNlQWXexuM/EH7Aw+KQT+0LGY2/wB8
	fDKTbCmeqMpu3f56NT06jKDPY5dG5YsUqzO4HgRdqV68l7OFwO2YaEVi/6avoGBxGMMecmzpr0q
	l0wlPUokweV8G/lPxLu5HB+4au4SZn8d2MyURthd/IJ3H6inwbwoH3TAquDTEIlSD8FiS1Wyd/c
	zzAlVWKC/+p8/dUB7OqaLWSPKX9U5P2quI8r36XRrPYsDx033/iK9d+pE4LbwlW1avUb7cjpGOq
	VgvcfIN99QxpFKrOUpRaJ3E9ejYAgaj70/Tup88lKjTDtNx+wNLoLPOrHMpOWPrG7CKH6PMLDio
	tcNIOydNOY1VCABWSx4LUeO9BLK5bw7tYL17ZvNLAcbEQvQeIt454+kLSYtwMrM8N5jW5lD6NUK
	ZE5Vj/4xRtnxfQd2IFHZWUHqIjrT8pTLJbYkNiZSQuFOXfr30rnIENo+zQ59AFA7s0HKZeW0wA1
	Jo1vD6jfutwOXgOaP03lgjxP16IdTO218UwND6s9m8AMWaKCM7zHsyGZ+G3pHSfJsq1yiaNkxkb
	W+Ka6ffgYSajJUK6FvJaeG9gfkANfPAhWNIlBePZ51khzMbeyR3S7MQXpKhO5MYlHKSRttY2ReQ
	==
X-Received: by 2002:a17:90b:5307:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3b0db6c9909mr196820a91.14.1793911676305;
        Thu, 05 Nov 2026 12:47:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7cb249fsm609578a91.15.2026.11.05.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:47:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 27/35] bpf: Track a pointer to one of a set of functions
Date: Thu,  5 Nov 2026 20:45:04 +0000
Message-ID: <20261105204513.2230344-28-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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
index 9b2ab76304c2..49c726521613 100644
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
@@ -1200,6 +1204,9 @@ struct bpf_verifier_env {
 	 */
 	struct bpf_func_ptr *func_ptrs;
 	u32 func_ptr_cnt;
+	/* What a pointer that was read from a table of functions may point to. */
+	struct bpf_func_set **func_sets;
+	u32 func_set_cnt;
 	bool has_callx;
 	/*
 	 * Call graph edges created by callx instructions. A bitmap of
@@ -1577,6 +1584,12 @@ static inline bool bpf_register_is_null(struct bpf_reg_state *reg)
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
index d6aab63b9a81..d9323a7a552f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7150,7 +7150,60 @@ static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state
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
@@ -7183,7 +7236,7 @@ static u32 count_read_offsets(struct tnum offs, u64 min_off, u64 max_off, u32 li
  * is possible at, e.g. var_off is the stride of the elements of an array.
  * A read of exactly one pointer yields PTR_TO_FUNC. When the offset is variable
  * and only pointers can be read, which is how an element of a table of
- * functions is loaded, the verification continues with each of them. Other
+ * functions is loaded, it is one of them, see mark_reg_func_set(). Other
  * reads that overlap with a pointer are rejected, because their result is not
  * known until the program is jitted.
  *
@@ -7196,7 +7249,6 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	struct tnum offs = tnum_add(reg->var_off, tnum_const(off));
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = reg->map_ptr;
-	struct bpf_verifier_state *branch;
 	u16 *targets __free(kfree) = NULL;
 	struct bpf_func_ptr *ptrs;
 	u32 i, cnt, n = 0;
@@ -7247,16 +7299,7 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -11547,7 +11590,8 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 		if (arg_needs_caller(state, sub, &caller->regs[i]))
 			return false;
 	}
-	for (i = 0; i < bpf_in_stack_arg_cnt(sub); i++) {
+	/* callx of one function of a set asks before it is checked that the arguments are there */
+	for (i = 0; i < bpf_in_stack_arg_cnt(sub) && i < caller->out_stack_arg_cnt; i++) {
 		if (caller->stack_arg_regs[i].type == PTR_TO_STACK ||
 		    base_type(caller->stack_arg_regs[i].type) == CONST_PTR_TO_DYNPTR)
 			return false;
@@ -11977,13 +12021,93 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -12016,17 +12140,9 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -20802,7 +20918,7 @@ static int check_arena_sp_insn(struct bpf_verifier_env *env, struct bpf_insn *in
 
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
-	int err;
+	int err, i;
 	struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
 	u8 class = BPF_CLASS(insn->code);
 
@@ -20879,6 +20995,12 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
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
@@ -25340,6 +25462,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

