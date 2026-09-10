Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0C48AE10
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058867; cv=none; b=UIyKkb1a3CLn1cLHlmjvZbszN4hH153v2HfrjinBG/l0I73xiOpT9Ij3FX9UWT70IuDxSW7CNImfoOFjYbl650/qOinyqvAWEAHsV9RDmaD8j0AXw73p52bN+tG2JKxOZMkbruU7L/+IiQzXXIdJBCbOpyUCPDyOOguW3LLFh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058867; c=relaxed/simple;
	bh=VR1yaMEw1CjP6Rj29hwF41luwN/ydtgEvpkD8dmD2sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiccH8whipUMZhTHZYGZdwV/dxtTasw1EEcS4OkC4tENykN0RwBrXeMaEjsYZeaf6Jhxk9h6pdxRwZG4C7hMbLb73zPvuiOYzA7j2bp03BZLf6puUqX2y5B3B76a72Cg8VvKA2YeHtIvjWGOSdOS2Yk4gUQVS8l7AFdfoKMcpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=faPOX+ZI; arc=none smtp.client-ip=91.218.175.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="faPOX+ZI"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VR1yaMEw1CjP6Rj29hwF41luwN/ydtgEvpkD8dmD2sw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058856; v=1; x=1789663656;
 b=faPOX+ZIOIL9EF3xtlY4gm4gD5Fbfr6eTfMvm9NVqJdyKSSKzaYKMmXj4/UNkYt8A7OdwbmJ
 xZLVtJzwVj5uBmP0n6GaHRVLIVDJLUFxJgy9A2CVDqmo7X3CXrRAJ4oMpcEB5IKKe0iHtlqTMv+
 TuAn7ma4ARiDIrcfcAzlLmZY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9c02b38f9a68efa5;
	Thu, 10 Sep 2026 16:47:36 +0000
X-Mizu-Trace-ID: 9c02b38f9a68efa5
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
Subject: [PATCH bpf-next v2 09/13] bpf: track low-32 scalar equality across narrowing stack fills
Date: Thu, 10 Sep 2026 22:16:31 +0530
Message-ID: <20260910164635.459558-10-vineet.gupta@linux.dev>
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

A 32-bit fill from a wider spilled scalar has the same shape as a 32-bit
mov from a wider source: the destination shares the slot's low 32 bits and
nothing else. The relation was dropped instead of recorded, so a later
narrowing of the spilled value never reached the filled register:

  r6 = ...                  /* full 64-bit unknown */
  *(u64 *)(r10 - 8) = r6;   /* slot linked to r6 */
  r2 = *(u32 *)(r10 - 8);   /* narrowing fill */
  if w6 != 0 goto ...       /* not taken: r6's low 32 bits are 0 */
  if r2 == 0 goto ...       /* not deduced today */

Record a low-32 link, as the mov arm does. Stack slots are already
first-class members of an ->id set, so sync_linked_regs() and the
reconstruction helpers apply unchanged. A fill narrower than 32 bits has
no expressible relation and still drops it.

Which kind to record depends on how the load fills the high half, so
check_stack_read() takes is_ldsx. Doing it there rather than correcting
afterwards in check_mem_access() keeps a single assignment.

check_mem_access() in turn no longer clears the id of a ->subreg register
on a sign-extending load: the link already records how the high half
follows, which is what that sign extension produced.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: new. Loads were asked for on the RFC cover letter; the fill is the
only load whose destination inherits an id.

 kernel/bpf/verifier.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 308ff53232f0..89be1240c99a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3927,7 +3927,8 @@ static void bpf_diag_stack_read_uninit(struct bpf_verifier_env *env, int off, in
 static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				      /* func where src register points to */
 				      struct bpf_func_state *reg_state,
-				      int off, int size, int dst_regno)
+				      int off, int size, int dst_regno,
+				      bool is_ldsx)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
@@ -3968,18 +3969,34 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 			if (size <= spill_size &&
 			    bpf_stack_narrow_access_ok(off, size, spill_size)) {
-				if (env->bpf_capable && size == 4 && spill_size == 4 &&
-				    get_reg_width(reg) <= 32)
+				bool narrowing = get_reg_width(reg) > size * BITS_PER_BYTE;
+				/*
+				 * A narrowing fill keeps only the slot's low 32 bits,
+				 * so record a low-32 link rather than dropping the
+				 * relation, as a 32-bit mov from a wide source does.
+				 * Which kind depends on how the load fills the high
+				 * half, hence is_ldsx.
+				 */
+				bool subreg_link = narrowing && size == 4;
+
+				if (env->bpf_capable && size == 4 &&
+				    (subreg_link || (spill_size == 4 && !narrowing)))
 					/* Ensure stack slot has an ID to build a relation
 					 * with the destination register on fill.
 					 */
 					assign_scalar_id_before_mov(env, reg);
 				state->regs[dst_regno] = *reg;
 
-				/* Break the relation on a narrowing fill.
-				 * coerce_reg_to_size will adjust the boundaries.
-				 */
-				if (get_reg_width(reg) > size * BITS_PER_BYTE)
+				if (subreg_link && reg->id)
+					state->regs[dst_regno].subreg =
+						is_ldsx ? SUBREG_SEXT : SUBREG_ZEXT;
+				else if (narrowing)
+					/*
+					 * Nothing to relate: either the slot has
+					 * no id to share, or the fill is narrower
+					 * than the 32 bits a link can describe.
+					 * coerce_reg_to_size adjusts the bounds.
+					 */
 					clear_scalar_id(&state->regs[dst_regno]);
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
@@ -4144,7 +4161,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg
  */
 static int check_stack_read(struct bpf_verifier_env *env,
 			    struct bpf_reg_state *reg, argno_t ptr_argno, int off, int size,
-			    int dst_regno)
+			    int dst_regno, bool is_ldsx)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	int err;
@@ -4183,7 +4200,7 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	if (!var_off) {
 		off += reg->var_off.value;
 		err = check_stack_read_fixed_off(env, state, off, size,
-						 dst_regno);
+						 dst_regno, is_ldsx);
 	} else {
 		/* Variable offset stack reads need more conservative handling
 		 * than fixed offset ones. Note that dst_regno >= 0 on this
@@ -6639,7 +6656,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 
 		if (t == BPF_READ)
 			err = check_stack_read(env, reg, argno, off, size,
-					       value_regno);
+					       value_regno, is_ldsx);
 		else
 			err = check_stack_write(env, reg, off, size,
 						value_regno, insn_idx);
@@ -6736,13 +6753,15 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			 * Sign-extension can change the register value relative
 			 * to a scalar it is linked with by id (e.g. a zero-
 			 * extending fill of the same spilled stack slot), thus
-			 * drop the shared id in that case.
+			 * drop the shared id in that case. A ->subreg link is
+			 * the exception: it already records that only the low
+			 * 32 bits are shared, and how the high half follows.
 			 */
 			bool no_sext = reg_umax(&regs[value_regno]) <
 					(1ULL << (size * BITS_PER_BYTE - 1));
 
 			coerce_reg_to_size_sx(&regs[value_regno], size);
-			if (!no_sext)
+			if (!no_sext && !regs[value_regno].subreg)
 				clear_scalar_id(&regs[value_regno]);
 		}
 	}
-- 
2.53.0-Meta

