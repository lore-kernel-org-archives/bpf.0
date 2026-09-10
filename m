Received: from mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EAD4CCDE7
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058879; cv=none; b=EbtZS5OQBQl5mWcY+oWoR231f4FvXdFP4TC1AMPKmWPo5IJZMJqVfpMebYzlEdcDCHWMSrJjg66cHlJ+dmy+Fni5rIXZQtkSpICldhBoKJ6buntQal8SvgCne+QqVTyHP0lUepyp0JEa6dThDhbxEydH/5cSTj6ZZeoz6SKSOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058879; c=relaxed/simple;
	bh=mrYY+8ju/CiFozDqUvghoNRZx9UJQJPLR3n4E5rpxG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdaSWlk+5tRUoPjYk6pbB3Pl7D0jxgZwfg7711C937oUyG3mfm7zCfUsggbJ+qLsxEpUwwSxaQRBU50BS4sw+9gj+IFD8Dan4QjTlMVqgpxshTItCF4SeBHIwo0kDGzDHT9g70KD5rR/2Gz20LE17XOTMyq2jVjF1nhl6S2VfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P7GAin1t; arc=none smtp.client-ip=91.218.175.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P7GAin1t"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mrYY+8ju/CiFozDqUvghoNRZx9UJQJPLR3n4E5rpxG0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058868; v=1; x=1789663668;
 b=P7GAin1tRTlmLb4kaETXGr1w3rXw6NrgusJIuYPsVaQz0OwWwKNbiOZaNukUQJNR7Y8gBsfF
 aOaZde1nzp2mzR504ZRBDJ70DBxky+fB7jWs3ARMkgBQD2ttco8aGu1MAyZNxNZ9N5as7tyl1ew
 4/tI1HQ8Hoz1R1mSm3h1FJYQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dc8a79c2cacc61c9;
	Thu, 10 Sep 2026 16:47:48 +0000
X-Mizu-Trace-ID: dc8a79c2cacc61c9
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
Subject: [PATCH bpf-next v2 12/13] bpf: track low-32 scalar equality across narrowing stack spills
Date: Thu, 10 Sep 2026 22:16:34 +0530
Message-ID: <20260910164635.459558-13-vineet.gupta@linux.dev>
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

A spill narrower than its source stores the source's low 32 bits, so the
slot is their zero-extension -- the same relation a 32-bit mov records, in
the store direction:

  r6 = ...                  /* full 64-bit unknown */
  *(u32 *)(r10 - 8) = r6;   /* slot holds r6's low 32 bits */
  r2 = *(u32 *)(r10 - 8);
  if w6 != 0 goto ...       /* not taken: r6's low 32 bits are 0 */
  if r2 == 0 goto ...       /* not deduced today */

Record a low-32 link instead of dropping the relation. A store never
sign-extends, so SUBREG_ZEXT is the only kind that arises here and no
is_ldsx equivalent is needed.

This composes with the fill side rather than stacking on it. The previous
patch left the slot recording exactly what memory holds, so its width is
already within 32 bits and the fill sees an ordinary narrow source: the
destination copies the slot's descriptor, staying one hop from the same
base rather than becoming a link to a link.

spill_subregs_preserve_stack_zero picks up the id on its 4-byte spill. The
16- and 8-bit spills in the same program do not, which is the size gate
working: a link can only describe the low 32 bits.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: new, with 11/13.

 kernel/bpf/verifier.c                         | 22 ++++++++++++++++---
 .../selftests/bpf/progs/verifier_spill_fill.c |  2 +-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6cb35fc0d0fb..9e63eddb9023 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3665,10 +3665,19 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
+		bool subreg_link;
 
 		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
+		/*
+		 * A narrowing spill stores the low 32 bits of the source, so
+		 * the slot is their zero-extension: record a low-32 link
+		 * rather than dropping the relation, as a 32-bit mov does.
+		 * A store never sign-extends, so there is only one kind here.
+		 */
+		subreg_link = !reg_value_fits && size == 4;
+
 		/* Make sure that reg had an ID to build a relation on spill. */
-		if (reg_value_fits)
+		if (reg_value_fits || subreg_link)
 			assign_scalar_id_before_mov(env, reg);
 		save_register_state(env, state, spi, reg, size);
 		if (!reg_value_fits) {
@@ -3678,8 +3687,15 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			 * it came from.
 			 */
 			coerce_reg_to_size(&state->stack[spi].spilled_ptr, size);
-			/* Break the relation on a narrowing spill. */
-			clear_scalar_id(&state->stack[spi].spilled_ptr);
+			if (subreg_link && reg->id)
+				state->stack[spi].spilled_ptr.subreg = SUBREG_ZEXT;
+			else
+				/*
+				 * Nothing to relate: either the source has no
+				 * id to share, or the store is narrower than
+				 * the 32 bits a link can describe.
+				 */
+				clear_scalar_id(&state->stack[spi].spilled_ptr);
 		}
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 487e0a1f395c..1042856b97c2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -468,7 +468,7 @@ __success
  * The slot records what the store put there, not the wider source it came
  * from, so each scalar is bounded by the size of its spill.
  */
-__msg("fp-8=0m??scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__msg("fp-8=0m??scalar(id={{[0-9]+}}.lo32,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __msg("fp-16=00mm??scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))")
 __msg("fp-24=00mm???scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))")
 __naked void spill_subregs_preserve_stack_zero(void)
-- 
2.53.0-Meta

