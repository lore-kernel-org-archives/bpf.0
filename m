Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9235DA60
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877275; cv=none; b=Ng890nOskRtgncVwI+dDghwGgrFzFjEoJ2GTzIsnsOXaP281pZQLCeX+ASMiCWivStK5kF8YoLFl4N6pcHCF4UTScQgAD4DeH9EdbcVGPe4DIZ9AdTIx8bSiaG4ydjEwMbdVHq85/iE4spepQjBDhK+0YHZehhy5Az3hLmhtutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877275; c=relaxed/simple;
	bh=tt8zMUSJG8L/+EekZNkmHtB+L8WdgnGQSqB5HboLnvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jtCUjpwwIWYJCgHSDOLNjg913EbAaotkti3yVUKiqnrI+KTnowjobdaxfrPTaTbD+8nkiE8DPyR8fdoWdVepmABbhVcu2V4mI4gB6wTWm19RPvIqsp0CN/MLo02G7S/MW/kBnQ/O11xUIxDkm6bv+Qi3wx3cwvoAMlTIRn/toek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Ahc7v586; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ahc7v586"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=q3NxgrtIPmeUTTCVEYwgYJROGXa6m8pnQgBEDBZDk4Y=; b=Ahc7v586eYIE4EBnQZ5sX8jq5D
	SBJo0p4pHiWltH1HAob0Vspn8trb6yphJjyWAOiCsLShxqs5dAQR+Pip/W8+2rNVyfEaAEbLKMoQk
	STCswDDqeK6Ddb30Hdqnx15IwNpR6thxCqUctY+fYhVfDv7aceDjMmZUilSTIT8N7qktnmBDfEq/O
	dGPSmthHECiNAYV8dOhdra2JlcU4Ybo/nzZLtySYRVHvjKisKjlD6aQsLHtdRRPjhU4cYrnoicAgK
	17eJlephcmfVexS9otZ9iuP5CiJ/76lAibqbhT0aPCc8Ool/GJdkKL+SbhfxJzCceuwKQI/l75DtP
	qhBHu3cw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w7Cel-000Hrt-0P;
	Mon, 30 Mar 2026 15:27:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	STAR Labs SG <info@starlabs.sg>
Subject: [PATCH bpf 1/2] bpf: Fix incorrect pruning due to atomic fetch precision tracking
Date: Mon, 30 Mar 2026 15:27:49 +0200
Message-ID: <20260330132750.377862-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27956/Mon Mar 30 08:24:32 2026)

When backtrack_insn encounters a BPF_STX instruction with BPF_ATOMIC
and BPF_FETCH, the src register (or r0 for BPF_CMPXCHG) also acts as
a destination, thus receiving the old value from the memory location.

The current backtracking logic does not account for this. It treats
atomic fetch operations the same as regular stores where the src
register is only an input. This leads the backtrack_insn to fail to
propagate precision to the stack location, which is then not marked
as precise!

Later, the verifier's path pruning can incorrectly consider two states
equivalent when they differ in terms of stack state. Meaning, two
branches can be treated as equivalent and thus get pruned when they
should not be seen as such.

Fix it as follows: When the fetch dst register is being tracked for
precision, clear it and propagate precision over to the stack slot.
This is similar to how BPF_LDX handles loads from the stack.

Before:

  0: (b7) r1 = 8                        ; R1=8
  1: (7b) *(u64 *)(r10 -8) = r1         ; R1=8 R10=fp0 fp-8=8
  2: (b7) r2 = 0                        ; R2=0
  3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=8 R10=fp0 fp-8=mmmmmmmm
  4: (bf) r3 = r10                      ; R3=fp0 R10=fp0
  5: (0f) r3 += r2
  mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10
  mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)
  mark_precise: frame0: regs=r2 stack= before 2: (b7) r2 = 0
  6: R2=8 R3=fp8
  6: (b7) r0 = 0                        ; R0=0
  7: (95) exit

After:

  0: (b7) r1 = 8                        ; R1=8
  1: (7b) *(u64 *)(r10 -8) = r1         ; R1=8 R10=fp0 fp-8=8
  2: (b7) r2 = 0                        ; R2=0
  3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=8 R10=fp0 fp-8=mmmmmmmm
  4: (bf) r3 = r10                      ; R3=fp0 R10=fp0
  5: (0f) r3 += r2
  mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10
  mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)
  mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0
  mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1
  mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8
  6: R2=8 R3=fp8
  6: (b7) r0 = 0                        ; R0=0
  7: (95) exit

Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
Fixes: 5ca419f2864a ("bpf: Add BPF_FETCH field / create atomic_fetch_add instruction")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f108c01ff6d0..293aa957a5ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4474,6 +4474,31 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * encountered a case of pointer subtraction.
 			 */
 			return -ENOTSUPP;
+
+		/* atomic fetch operation writes the old value into a
+		 * register (sreg or r0) and if it was tracked for
+		 * precision, propagate to the stack slot like we do
+		 * in ldx.
+		 */
+		if (class == BPF_STX && mode == BPF_ATOMIC &&
+		    (insn->imm & BPF_FETCH)) {
+			u32 load_reg = insn->imm == BPF_CMPXCHG ?
+				       BPF_REG_0 : sreg;
+
+			if (bt_is_reg_set(bt, load_reg)) {
+				bt_clear_reg(bt, load_reg);
+				/* atomic fetch from non-stack memory
+				 * can't be further backtracked, same
+				 * as for ldx.
+				 */
+				if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
+					return 0;
+				spi = insn_stack_access_spi(hist->flags);
+				fr = insn_stack_access_frameno(hist->flags);
+				bt_set_frame_slot(bt, fr, spi);
+				return 0;
+			}
+		}
 		/* scalars can only be spilled into stack */
 		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
 			return 0;
-- 
2.43.0

