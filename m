Received: from mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED415221D6
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058832; cv=none; b=B3bsapGIebOxKj6Pq1k1l+YasnzORMBTMb+9U9pKiqmlW3g1gvValq2CH/LCSpeLQsAzvVq6DSFhg+ZgykBFvd+WBSt/6fmhO9ywJnqHCwdPBB8Fep3iUItaAIKXTt+c17Ej47LM+Bm7TP8za4lzxzwi0XVN4AqKtiyrZYLmsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058832; c=relaxed/simple;
	bh=jcdTnpz3K2nPgGTSv8fwyNJKhwmW5PkbJFINKVaj1Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2ZM/PQP3VokVw6DQnBASsSsCjVBA1KvJ98ZRYQyRwe5PNvb0iH+fJ8H/kKdONvXKuY9+wiS8V1kEc3JXKLInC08jMdRyCG30ovy+t2g46wqdBvbzyfLOordZ3FPvZ+2J5lmog11cxalX4okFR50pgz3OGG4xSpyv1mM53t6dZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qqVF3r4q; arc=none smtp.client-ip=91.218.175.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qqVF3r4q"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jcdTnpz3K2nPgGTSv8fwyNJKhwmW5PkbJFINKVaj1Uk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058826; v=1; x=1789663626;
 b=qqVF3r4qLOcDrf9mpmqwaD2zH6hMLm+IyNLmGq8uBWS3wUuX/62AdG1+vAa+V/jv5XntyR9h
 H0qd+xmqcXeaHwxaRuMGqEoMZwlibCVthU1fCXHW038I0fudI7LsZPB5vJa/VnVYmPkbT+lC+nx
 pOeiyA6nNS29bAflyR3f8h/8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 23043581737f34db;
	Thu, 10 Sep 2026 16:47:06 +0000
X-Mizu-Trace-ID: 23043581737f34db
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality across zero-extending movs
Date: Thu, 10 Sep 2026 22:16:25 +0530
Message-ID: <20260910164635.459558-4-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910164635.459558-1-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linked-scalar equality is full-64-bit only. A 32-bit mov from a source
with unknown high bits therefore has to drop the relationship, and a later
narrowing of the source never reaches the destination:

  r6 = ...              /* full 64-bit unknown */
  w7 = w6               /* 32-bit zero-extending mov */
  if w6 != 0 goto ...   /* not taken: r6's low 32 bits are 0 */
  if w7 == 0 goto ...   /* not deduced today */

Record a low-32-only link instead: dst shares src's low 32 bits and its
high half is zero. On a later narrowing, sync_linked_regs() rebuilds such
a register from the base rather than copying it, by re-applying the same
zext_32_to_64() the mov used. The reverse direction is skipped: a ->subreg
base knows nothing about a full register's high half.

The link is not modelled together with an ADD_CONST delta, so forming one
costs the source its delta: assign_scalar_id_before_mov() clears it, as it
already does for a narrow source. That loses tracking a wide source used
to keep, but the two cannot both be held -- a link the sync path skips
would be inert.

bpf-gcc hits this by reusing "w0 = idx" for "return 0" on the idx == 0
path of a bpf_loop callback.

regs_exact() and regsafe() compare the new kind, for the reasons given in
the previous patch. As with the pre-existing add_const comparison, no
selftest isolates it: when the kinds differ in a way a program can build,
the ranges differ too and the range checks reject first.

Two existing tests move with the behaviour. verifier_reg_equal's "w reg
not equal if r reg upper32 bits not 0" is this exact case and becomes
__success; verifier_bounds' sub32_partial_overflow pins a register dump
that now carries the link.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: was RFC 3/6.
 - no longer excludes an ADD_CONST source, for symmetry with the narrow
   path (Eduard). The cost is spelled out in the changelog
 - reconstruct_zext32() instead of an open-coded block (Eduard)
 - saved_id dropped: reg->id == known_reg->id already holds (Eduard)
 - flattened the if-nesting (Eduard)
 - log.c prints the kind (Eduard)
 - changelog and comments trimmed (Eduard)

 include/linux/bpf_verifier.h                  | 10 +++
 kernel/bpf/log.c                              |  2 +
 kernel/bpf/states.c                           |  4 +-
 kernel/bpf/verifier.c                         | 61 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_bounds.c     |  2 +-
 .../selftests/bpf/progs/verifier_reg_equal.c  | 14 ++---
 6 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index afb1e5628698..f1b01059c5da 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -46,6 +46,15 @@ enum bpf_add_const {
 	ADD_CONST_64,		/* ... with a 64-bit ALU op */
 };
 
+/*
+ * Records that a register shares only the low 32 bits of the base of its
+ * ->id set, and how its high bits follow from them.
+ */
+enum bpf_subreg {
+	SUBREG_NONE = 0,
+	SUBREG_ZEXT,		/* high bits are zero (32-bit zero-extending mov) */
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -173,6 +182,7 @@ struct bpf_reg_state {
 	 * Non-zero only if ->id is.
 	 */
 	enum bpf_add_const add_const:2;
+	enum bpf_subreg subreg:2;
 };
 
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index f8d7a5c8052f..4047cfb0a698 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -654,6 +654,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose_a("id=%d", reg->id);
 	if (reg->add_const)
 		verbose(env, "%+d", reg->delta);
+	if (reg->subreg == SUBREG_ZEXT)
+		verbose(env, ".lo32");
 	if (reg->parent_id)
 		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5505d7aaeed0..1618c77105ab 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -476,6 +476,7 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       rold->add_const == rcur->add_const &&
+	       rold->subreg == rcur->subreg &&
 	       check_ids(rold->id, rcur->id, idmap) &&
 	       check_ids(rold->parent_id, rcur->parent_id, idmap);
 }
@@ -577,7 +578,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * linking semantics in sync_linked_regs() (alu32 zero-extends,
 		 * alu64 does not), so pruning across them is unsafe.
 		 */
-		if (rold->id && rold->add_const != rcur->add_const)
+		if (rold->id && (rold->add_const != rcur->add_const ||
+				 rold->subreg != rcur->subreg))
 			return false;
 
 		/* Both have offset linkage: offsets must match */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0ca229f6e7ac..58e788f53ae5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1908,6 +1908,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	reg->id = 0;
 	reg->parent_id = 0;
 	reg->add_const = ADD_CONST_NONE;
+	reg->subreg = SUBREG_NONE;
 	___mark_reg_known(reg, imm);
 }
 
@@ -3482,6 +3483,7 @@ static void clear_scalar_id(struct bpf_reg_state *reg)
 	reg->id = 0;
 	reg->delta = 0;
 	reg->add_const = ADD_CONST_NONE;
+	reg->subreg = SUBREG_NONE;
 }
 
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
@@ -3493,6 +3495,8 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 	 * The verifier is processing rX = rY insn and
 	 * rY->id has special linked register already.
 	 * Cleared it, since multiple rX += const are not supported.
+	 * A ->subreg link can be shared: it describes src's own relationship
+	 * to the set, not a delta to unwind.
 	 */
 	if (src_reg->add_const)
 		clear_scalar_id(src_reg);
@@ -16244,15 +16248,22 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				} else if (src_reg->type == SCALAR_VALUE) {
 					if (insn->off == 0) {
 						bool is_src_reg_u32 = get_reg_width(src_reg) <= 32;
+						/*
+						 * A wide src shares only its low 32 bits. A
+						 * full link would let dst's [0, U32_MAX]
+						 * propagate onto src's unknown high bits, so
+						 * record a low-32-only link instead. A
+						 * self-mov has nothing to link.
+						 */
+						bool subreg_link = !is_src_reg_u32 &&
+								   src_reg != dst_reg;
 
-						if (is_src_reg_u32)
+						if (is_src_reg_u32 || subreg_link)
 							assign_scalar_id_before_mov(env, src_reg);
 						*dst_reg = *src_reg;
-						/* Make sure ID is cleared if src_reg is not in u32
-						 * range otherwise dst_reg min/max could be incorrectly
-						 * propagated into src_reg by sync_linked_regs()
-						 */
-						if (!is_src_reg_u32)
+						if (subreg_link && src_reg->id)
+							dst_reg->subreg = SUBREG_ZEXT;
+						else if (!is_src_reg_u32)
 							clear_scalar_id(dst_reg);
 					} else {
 						/* case: W1 = (s8, s16)W2 */
@@ -17115,6 +17126,23 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
 	}
 }
 
+/*
+ * Set @reg to the zero-extension of @known_reg's low 32 bits: it shares those
+ * bits and its high half is zero. Copy the base to keep its precise low-32
+ * tnum, then re-apply the zext_32_to_64() the 32-bit mov itself used.
+ * @reg->id and ->delta already equal @known_reg's; only ->subreg is its own.
+ */
+static void reconstruct_zext32(struct bpf_reg_state *reg,
+			       struct bpf_reg_state *known_reg)
+{
+	enum bpf_subreg subreg = reg->subreg;
+
+	*reg = *known_reg;
+	reg->subreg = subreg;
+	zext_32_to_64(reg);
+	reg_bounds_sync(reg);
+}
+
 /* For all R in linked_regs, copy known_reg range into R
  * if R->id == known_reg->id.
  */
@@ -17134,6 +17162,27 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			continue;
 		if (reg->id != known_reg->id)
 			continue;
+		/*
+		 * A ->subreg register shares only the base's low 32 bits, so it
+		 * is rebuilt rather than copied. Not modelled together with a
+		 * delta, so skip if either side has one (sound, less precise).
+		 */
+		if (reg->subreg) {
+			if (reg->add_const || known_reg->add_const)
+				continue;
+			reconstruct_zext32(reg, known_reg);
+			if (e->is_reg)
+				mark_reg_scratched(env, e->regno);
+			else
+				mark_stack_slot_scratched(env, e->spi);
+			continue;
+		}
+		/*
+		 * The reverse: known_reg knows only its low 32 bits, which say
+		 * nothing about reg's high half.
+		 */
+		if (known_reg->subreg)
+			continue;
 		/*
 		 * Skip mixed 32/64-bit links: the delta relationship doesn't
 		 * hold across different ALU widths.
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index df8d5309657e..b4eadbd88357 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1516,7 +1516,7 @@ __naked void sub32_full_overflow(void)
 SEC("socket")
 __description("32-bit subtraction, partial overflow, result in unbounded u32 bounds")
 __success __log_level(2)
-__msg("3: (1c) w3 -= w2 {{.*}} R3=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__msg("3: (1c) w3 -= w2 {{.*}} R3=scalar(id={{[0-9]+}}-1.lo32,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __retval(0)
 __naked void sub32_partial_overflow(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
index dc1d8c30fb0e..34214ec92670 100644
--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -31,23 +31,23 @@ l1_%=:	exit;						\
 }
 
 SEC("socket")
-__description("check w reg not equal if r reg upper32 bits not 0")
-__failure __msg("R1 !read_ok")
+__description("check w reg equal if r reg upper32 bits not 0")
+__success
 __naked void subreg_equality_2(void)
 {
 	asm volatile ("					\
 	call %[bpf_ktime_get_ns];			\
 	r2 = r0;					\
-	/* Upper 4-bytes of r2 may not be 0, thus insn	\
-	 * w3 = w2 should not propagate reg id,	and	\
-	 * w2 < 9 comparison should not propagate	\
-	 * the range for r3 either.			\
+	/* Upper 4-bytes of r2 may not be 0, so r3 does	\
+	 * not equal r2. It does share r2's low 32 bits	\
+	 * though, so w2 < 9 still bounds r3: the	\
+	 * zero-extending mov leaves nothing above them.\
 	 */						\
 	w3 = w2;					\
 	if w2 < 9 goto l0_%=;				\
 	exit;						\
 l0_%=:	if r3 < 9 goto l1_%=;				\
-	/* r1 read is illegal at this point */		\
+	/* unreachable, so the r1 read is never made */	\
 	r0 -= r1;					\
 l1_%=:	exit;						\
 "	:
-- 
2.53.0-Meta

