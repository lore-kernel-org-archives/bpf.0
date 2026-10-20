Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513249;
	b=rB3AGT+GIWRkHsy7cLRepLjjvKvLpgWj+ezlQQ4G8jDzkmL+hRrXg+c1CAplIMehke59
	 D2Kei1XuCQhqHa2LkerOR87q2hR2zM4BKmqxKqKn4DykCAt5fSqHT8dbITJBzXbcbgmse
	 lPs6ahxYVcqiGxTdP6KJ7y70bSYLabs+TyQiikBQn5jGzRC8YlK3iET98HnLhySMWgxHX
	 29oQN2bwMMAeZJwzXFAgLZyKOOWlgbYnaO5ixBvJGHoQZ315RXTMfcaJLXicBjuUPEm7F
	 pFAXP249QSBGe7BmuCfSPl8IS1lWVfYlbiuFPJVkTQDkQMfw9Zc7lqdYw/PEBtfsE2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513249;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OC8vve1fiqKE1c9n/UcGr0mLlnRlWEjB+BSGAgi53F8=;
	b=n/omiwKBk3FWdq+cEPQDghdUO9L7s/3JQ4sgdM1GOdJCzfJXBcOYXCsBPw6eo5Zt53Ir
	 zslzcGWQGTPK29iB47K2ppEuh+ev1iR9fUaeihYdkXKpDp/NSY+4j06hdcuX3TK8AXKTx
	 c0V+TOSgavedUSuUmXaVqbjBrrCclHowJALnAAFhCt7RRHHQX9WofmnitIfWZBBxXsghz
	 hY9WbJ0BCX4o6gorQfEUThYzPdM3TtqUJ+MRK+kx2Kq8lP2FWfI/8K6X/uDMtipZ7RyZs
	 7kx/5JuCdlDD6j8eN468ntej4L2/0i6LjrD/tCV9a2ZcyhvEJNsMw9iyfuahJ3d4zzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mkRkUypN;
	arc=none smtp.remote-ip=95.215.58.228
Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86920606A31D
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86920606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mkRkUypN
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZMLOfQ7Ig4uyCPp/b+t9vYpCNzduUcOXbnHFJaKcnwI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513246; v=1; x=1793118046;
 b=mkRkUypNqHMho+uBzef/fYTac3De3nlI11/1DCYwvnNQ7sgegQDsRKs7c+OaTsu8G5ooczkQ
 /eA6o7dfHF4bP/uWc53G7iY1C9PDZCI97jC1e2SF7unPaZ7ZQZ0yHZB1TNbT08WG7u9RFKh9478
 bzXVAMfaIJiDK+bk5Y3OoleE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e1b8357c1f15603;
	Tue, 20 Oct 2026 16:20:46 +0000
X-Mizu-Trace-ID: 2e1b8357c1f15603
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
Subject: [PATCH bpf-next v3 11/12] [do not merge] bpf: Track low-32 scalar equality across narrowing stack spills
Date: Tue, 20 Oct 2026 09:19:06 -0700
Message-ID: <20261020161907.2115379-12-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020161907.2115379-1-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
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

A spill narrower than its source stores the source's low 32 bits, so the
slot is their zero-extension -- the mov relation, in the store direction:

  r6 = ...                  /* full 64-bit unknown */
  *(u32 *)(r10 - 8) = r6;   /* slot holds r6's low 32 bits */
  if w6 != 0 goto ...       /* not taken: r6's low 32 bits are 0 */
  r2 = *(u32 *)(r10 - 8);
  if r2 == 0 goto ...       /* not deduced today */

A store never sign-extends, so BPF_REG_LINK_ZEXT is the only kind that
arises. save_register_state() copies the source whole, including bounds
for bits the store did not write, so the slot must be truncated before
the kind goes on it -- otherwise the first sync_linked_regs() intersects
the correctly rebuilt low half against those stale bounds and empties
the slot.

Only one order pays. sync_linked_regs() walks spilled slots, so narrowing
while the value is still on the stack narrows the slot and the fill copies
an already narrowed value. Filling first does not benefit: the fill is a
mov, and a mov drops a zero-extending link.

Posted, not proposed. This is the direction asked for, implemented and
measured, and the measurement says do not take it. Against the ten patches
before it, on 441 cilium/katran/fb/sched_ext objects, 1467 programs:

  verdicts      no change at all
  total_insns   102 changed, 63 worse, +84,450 (+0.34%)
                  +59,616 (+57.2%)  104,160 -> 163,776  test_file_open
                  +19,784 (+89.7%)   22,053 ->  41,837  rusty_enqueue
                   +2,688 (+40.6%)    6,626 ->   9,314  layered_enqueue
  total_states   64 changed, 63 worse

Nothing is gained for it, and both selftest corpora hide it completely --
bpf-gcc shows no changed program at all. Nothing in
tools/testing/selftests/bpf is shaped like a sched_ext scheduler.

The mechanism, from rusty_enqueue's verifier log at the patch before this
one and at this one. The walks are identical for 17,043 steps, then:

  before   1969: (c7) r6 s>>= 32
           1970: safe                     <- pruned here

  after    1969: (c7) r6 s>>= 32
           frame 0: propagating fp-24     <- not pruned

One slot accounts for all of it. fp-24 is written by a narrowing spill 354
times in the walk, and "propagating fp-24" goes 0 -> 1034 while the other
slots are unchanged. The slot itself goes from

  fp-24=ppppscalar()

to

  fp-24=ppppscalar(id=11+0,smin=0,smax=umax=0xffffffff,...)

An opaque scalar() matches every candidate state; one carrying an id, a
kind and a range that sync_linked_regs() narrows further on each compare
matches far fewer. Three things tighten at once: check_scalar_ids()
returns true unconditionally for old_id == 0 and the slot now has an id;
regsafe() gains two rejects that need a kind to be reachable; and
bpf_bt_sync_linked_regs() makes precision all-or-nothing across a set, so
marking any member precise now reaches the slot. rusty_enqueue uses the
value as an array index, which forces mark_chain_precision constantly.

That is the relation working as designed. Recording true information about
a slot necessarily narrows its equivalence class, and a narrower class
prunes against fewer predecessors. The narrowing-fill patch earlier in the
series is the half that pays: the fill is where the value is wanted, and
it is free on every corpus.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: was v2 12/13, now tagged [do not merge].
 - v2's 11/13, "bpf: record what a narrowing spill actually stores", is
   dropped: it cost big_alloc2 2956 -> 3095 insns for no verdict.
 - v2's worked example had the fill before the narrowing, which is the
   one order this link cannot serve. Replaced with the order that works.
 - the slot is truncated to the bits the store actually wrote before
   the kind goes on it, and inherits the source's delta.
 - NOT PROPOSED FOR MERGE. Against the ten patches before it, on 441
   cilium/katran/fb/sched_ext objects: 102 programs changed, 63 worse,
   test_file_open +57% and rusty_enqueue +90%, for no verdict change
   anywhere. Both selftest corpora hide this completely -- bpf-gcc
   shows no changed program at all. The message carries the mechanism
   from the verifier log.

 kernel/bpf/verifier.c                         | 40 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_spill_fill.c |  6 ++-
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index feefa5733fd7..3607c032df5f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -222,6 +222,7 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
+static void zext_32_to_64(struct bpf_reg_state *reg);
 
 static void bpf_map_ptr_store(struct bpf_insn_aux_data *aux,
 			      struct bpf_map *map,
@@ -3908,15 +3909,46 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
+		bool subreg_link;
 
 		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
+		/*
+		 * A narrowing spill stores the low 32 bits of the source, so
+		 * the slot is their zero-extension: record a low-32 link
+		 * rather than dropping the relation, as a 32-bit mov does.
+		 * A store never sign-extends, so there is only one link kind here.
+		 */
+		subreg_link = !reg_value_fits && size == 4;
+
 		/* Make sure that reg had an ID to build a relation on spill. */
-		if (reg_value_fits)
+		if (reg_value_fits || subreg_link)
 			assign_scalar_id_before_mov(env, reg);
 		save_register_state(env, state, spi, reg, size);
-		/* Break the relation on a narrowing spill. */
-		if (!reg_value_fits)
-			bpf_clear_scalar_id(&ss->spilled_ptr);
+		if (!reg_value_fits) {
+			if (subreg_link && reg->id) {
+				/*
+				 * save_register_state() copies the source
+				 * whole, but the store only wrote its low 32
+				 * bits, so truncate to those before recording
+				 * the kind: a slot asserting BPF_REG_LINK_ZEXT
+				 * over the source's wider bounds is a register
+				 * state that contradicts itself.
+				 *
+				 * Keep the source's delta, though: the slot
+				 * holds (u32)(base + delta), so resetting it to
+				 * 0 would record a relation off by that delta.
+				 */
+				zext_32_to_64(&ss->spilled_ptr);
+				ss->spilled_ptr.link_kind = BPF_REG_LINK_ZEXT;
+			} else {
+				/*
+				 * Nothing to relate: either the source has no
+				 * id to share, or the store is narrower than
+				 * the 32 bits a link can describe.
+				 */
+				bpf_clear_scalar_id(&ss->spilled_ptr);
+			}
+		}
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
 		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 4d1374885f6d..081b0fe0d70a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -464,7 +464,11 @@ l0_%=:	r1 >>= 16;					\
 SEC("raw_tp")
 __log_level(2)
 __success
-__msg("fp-8=0m??scalar()")
+/*
+ * The 4-byte spill carries the low-32 link, and the slot is truncated to
+ * the bits the store wrote; the narrower spills do neither.
+ */
+__msg("fp-8=0m??scalar(id={{[0-9]+}}+0,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __msg("fp-16=00mm??scalar()")
 __msg("fp-24=00mm???scalar()")
 __naked void spill_subregs_preserve_stack_zero(void)
-- 
2.53.0-Meta

