Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AD40243D
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954919; cv=none; b=aAaCGFwk1gd59Kv2H9PRcFg7qK5/uPolt4EJ6o4eGsa26mXvQ3RjDgeDDKHj7AXU3t5V4LjEIv361MYneo+8XXIE4mwgifQ8rTgfZz7KunCNIl75J8bonjrvzR1ISOhk2ti15aMYt633KCBOfYi3nOJdTr0ELoeyQdPG7ubzxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954919; c=relaxed/simple;
	bh=dbvPdm3CpyYpcGW0VHsk3JS7Ic9Sz5Q6osgs1WjzDSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9k3LYPONUTtHd01KB28tBOdeWirA+A72vrFAuHTk2CQ3wSptGat5xmuWpE/BcRqgMFO75fcNPWzwGOm6PNCiLAAJb8IscPjCNNcEoyMcaAENwsIg46C1+4lYrbYHHxPMgQjw1tMnoYmDhBGiywpcb4zbwnxUxYA2J5O1O1mP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=f5H4KjAH; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="f5H4KjAH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=LYGFkg9Wf8fY4xWjTQ3WZeodKksSz2vCmUEma6JR8gk=; b=f5H4KjAH1pMlrpgyzXdotj32Np
	FcnTFgiDQY0XeqYSNXV/yHaOKcxee9yNd7+Hy9Z539Hemoha3Pw8L1tNOylkjpm8hHCSdB6XiFOEg
	Esm/YTo/ZX6X8SkS+x/lZW6Hs1wDBUzsI0JekZyxogD7qTKT/1962SM5F2SB60qaDxVxq9HItTMi2
	4jJWa8ocswd5w3pSeKQfSNmZIN4XhstUkrHBONjJ83FBwhggSUXW4S/VTdJwJ/Cg3sBR5noOwFEZ/
	ermBmQ4zoGgDCECXSbyC3rdQ+mE8vzy+XoOhTjI8L/No/aOu1kxXKGRX3XSVZjOj3lcOCdAo100LF
	ebAhRSqg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3Khw-0000CA-1f;
	Thu, 19 Mar 2026 22:15:08 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	puranjay12@gmail.com,
	qguanni@gmail.com,
	ast@kernel.org,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf 1/2] bpf: Fix sync_linked_regs regarding BPF_ADD_CONST32 zext propagation
Date: Thu, 19 Mar 2026 22:15:06 +0100
Message-ID: <20260319211507.213816-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27945/Thu Mar 19 07:24:38 2026)

Jenny reported that in sync_linked_regs() the BPF_ADD_CONST32 flag is
checked on known_reg (the register narrowed by a conditional branch)
instead of reg (the linked target register created by an alu32 operation).

Example case with reg:

  1. r6 = bpf_get_prandom_u32()
  2. r7 = r6 (linked, same id)
  3. w7 += 5 (alu32 -- r7 gets BPF_ADD_CONST32, zero-extended by CPU)
  4. if w6 < 0xFFFFFFFC goto safe (narrows r6 to [0xFFFFFFFC, 0xFFFFFFFF])
  5. sync_linked_regs() propagates to r7 but does NOT call zext_32_to_64()
  6. Verifier thinks r7 is [0x100000001, 0x100000004] instead of [1, 4]

Since known_reg above does not have BPF_ADD_CONST32 set above, zext_32_to_64()
is never called on alu32-derived linked registers. This causes the verifier
to track incorrect 64-bit bounds, while the CPU correctly zero-extends the
32-bit result.

The code checking known_reg->id was correct however (see scalars_alu32_wrap
selftest case), but the real fix needs to handle both directions - zext
propagation should be done when either register has BPF_ADD_CONST32, since
the linked relationship involves a 32-bit operation regardless of which
side has the flag.

Example case with known_reg (exercised also by scalars_alu32_wrap):

  1. r1 = r0; w1 += 0x100 (alu32 -- r1 gets BPF_ADD_CONST32)
  2. if r1 > 0x80 - known_reg = r1 (has BPF_ADD_CONST32), reg = r0 (doesn't)

Hence, fix it by checking for (reg->id | known_reg->id) & BPF_ADD_CONST32.

Moreover, sync_linked_regs() also has a soundness issue when two linked
registers used different ALU widths: one with BPF_ADD_CONST32 and the
other with BPF_ADD_CONST64. The delta relationship between linked registers
assumes the same arithmetic width though. When one register went through
alu32 (CPU zero-extends the 32-bit result) and the other went through
alu64 (no zero-extension), the propagation produces incorrect bounds.

Example:

  r6 = bpf_get_prandom_u32()     // fully unknown
  if r6 >= 0x100000000 goto out  // constrain r6 to [0, U32_MAX]
  r7 = r6
  w7 += 1                        // alu32: r7.id = N | BPF_ADD_CONST32
  r8 = r6
  r8 += 2                        // alu64: r8.id = N | BPF_ADD_CONST64
  if r7 < 0xFFFFFFFF goto out    // narrows r7 to [0xFFFFFFFF, 0xFFFFFFFF]

At the branch on r7, sync_linked_regs() runs with known_reg=r7
(BPF_ADD_CONST32) and reg=r8 (BPF_ADD_CONST64). The delta path
computes:

  r8 = r7 + (delta_r8 - delta_r7) = 0xFFFFFFFF + (2 - 1) = 0x100000000

Then, because known_reg->id has BPF_ADD_CONST32, zext_32_to_64(r8) is
called, truncating r8 to [0, 0]. But r8 used a 64-bit ALU op -- the
CPU does NOT zero-extend it. The actual CPU value of r8 is
0xFFFFFFFE + 2 = 0x100000000, not 0. The verifier now underestimates
r8's 64-bit bounds, which is a soundness violation.

Fix sync_linked_regs() by skipping propagation when the two registers
have mixed ALU widths (one BPF_ADD_CONST32, the other BPF_ADD_CONST64).

Lastly, fix regsafe() used for path pruning: the existing checks used
"& BPF_ADD_CONST" to test for offset linkage, which treated
BPF_ADD_CONST32 and BPF_ADD_CONST64 as equivalent.

Fixes: 7a433e519364 ("bpf: Support negative offsets, BPF_SUB, and alu32 for linked register tracking")
Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
Co-developed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df22bfc572e2..770b2f4eb781 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17415,6 +17415,12 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			continue;
 		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
 			continue;
+		/*
+		 * Skip mixed 32/64-bit links: the delta relationship doesn't
+		 * hold across different ALU widths.
+		 */
+		if (((reg->id ^ known_reg->id) & BPF_ADD_CONST) == BPF_ADD_CONST)
+			continue;
 		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
 		    reg->off == known_reg->off) {
 			s32 saved_subreg_def = reg->subreg_def;
@@ -17442,7 +17448,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
-			if (known_reg->id & BPF_ADD_CONST32)
+			if ((reg->id | known_reg->id) & BPF_ADD_CONST32)
 				zext_32_to_64(reg);
 			reg_bounds_sync(reg);
 		}
@@ -19870,11 +19876,14 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * Also verify that new value satisfies old value range knowledge.
 		 */
 
-		/* ADD_CONST mismatch: different linking semantics */
-		if ((rold->id & BPF_ADD_CONST) && !(rcur->id & BPF_ADD_CONST))
-			return false;
-
-		if (rold->id && !(rold->id & BPF_ADD_CONST) && (rcur->id & BPF_ADD_CONST))
+		/*
+		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
+		 * BPF_ADD_CONST64 have different linking semantics in
+		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
+		 * so pruning across different flag types is unsafe.
+		 */
+		if (rold->id &&
+		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
 			return false;
 
 		/* Both have offset linkage: offsets must match */
-- 
2.43.0

