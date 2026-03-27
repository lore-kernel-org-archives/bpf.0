Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB97D388E67;
	Fri, 27 Mar 2026 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640950; cv=none; b=BRaOx5IXZt/JrcfLXXORMvbqY3K+ehw4nlG/boz+cDtc1wgc8ZW5f4vWtncEPi3QXQ5ySEPWa+h8D9T3vyhQakVnxW3SqE4xYyW4dZgiKM667Zk1BGz+p/+4bZSPwah3/M3WXNLUhm7ffe5oOcnpvFEhL7NWFhCg2+H3PcDGXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640950; c=relaxed/simple;
	bh=xGrbC5F4b04ONwJEomxQGx5rA9AY/2JimpC5ZSKk+Yw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JHjzyOGClYIjrTqV6Ghn/A7twrCeLi8/LCzFyS2/41deg5qUnQUkorjQdeiH9uKfLuGu0btSsXl6Y1kDaBACPwJm+l7KNpdbXhycoDlcXND8soXs+DK5WKhry86neYYxiVbfpEaaofQed80nPvBwuvvc52+mpVAvvMURsnoJdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gqQXGWSx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gqQXGWSx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HEcEMSdAtcSoh2KSyJwTVX69amc/NpQLVgQSqsTXIYs=; b=gqQXGWSxiX3V8T1ZcmRi98k83l
	joXxyZcyVuGAdUiCQLhn7i8sFOKbAvsnP++jtk6/2d/fn40b/V5oHr1tEp+uXpYxE8aWn8HWCbCp8
	vFeudNXa4oMMNecs2PTvq7yqZJzUiYhI2yD4yxbnS2yo63yqcNPVOp4gELLFmNFoJlkhkDK4kfNqK
	RsXOcdgz/rMSK+4TPNMaaE1fsUKZVGrTXkito5TQskthmSczPLxs2zV/eGxQ/9eJkZ0WQZjIyGLBt
	U2rP9vyY1ftxaMXkefE7kMjuHn8QzdTwX9iH88EVWxMn45VfE2AN9E6jLxGYupecDsuJ17fkTWMWr
	mtZOY+MQ==;
Received: from [179.221.50.217] (helo=toolbx)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w6DAt-007M01-Ph; Fri, 27 Mar 2026 20:48:56 +0100
From: Helen Koike <koike@igalia.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	yonghong.song@linux.dev,
	ast@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	koike@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH] bpf: fix umin/umax when lower bits fall outside u32 range
Date: Fri, 27 Mar 2026 16:48:33 -0300
Message-ID: <20260327194849.855397-1-koike@igalia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the case where min/max adjustments on a conditional statement cross
u32 boundaries.

The case where this bug was found has the following scenario (see full
bpf prog below):

  insn 2: (bf) r0 = r2
  ...
  insn 4: (3d) if r3 >= r0 goto pc+1
  ...
  insn 9: (67) r2 <<= 7
  ...
  insn 13: (65) if r7 s> 2 goto pc-12 # back to insn 2

Since this is a loop, at some later iteration, both
u32_min_value/u32_max_value of r0 converge to 0 due to the shift of r2
on insn 9 and later the assignment to r0 on insn 2.

When evaluating the branch FALSE on the conditional jump of insn 4,
since it needs to respect r0 > r3, it elevates umin of r0 by 1:

  r0.umin = r3.umin + 1

This is done by this part of the code:

  static void regs_refine_cond_op(...) {
	...
	case BPF_JLT:
		...
		u64 new_umin = max(reg1->umin_value + 1, reg2->umin_value);

But the problem is that u32_min_value/u32_max_value are zero, so it
needs to be adjusted by reg_bounds_sync(), which calls
__reg_deduce_mixed_bounds() that performs the following tightening:

  new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
  ...
  reg->umin_value = max_t(u64, reg->umin_value, new_umin);

Here it was hitting the situation of: u64=[0x1,0xfffffff800000000] u32=[0x0,0x0]
Leading to:
	new_umin = 0
	reg->umin_value = max(1, 0) = 1

Which is inconsistent because: (u32)reg->umin_value > reg->u32_max_value.

That propagates until it reaches a:

  verifier bug: REG INVARIANTS VIOLATION (true_reg2): range bounds violation
    u64=[0x0, 0x7800000000] s64=[0x0, 0xffffffffffffffff]
    u32=[0x80000000, 0x0] s32=[0x0, 0xffffffff] var_off=(0x0, 0x7800000000)


Fix __reg_deduce_mixed_bounds() to detect the case when the u32
boundaries are crossed and advance umin to the next 32-bit block (or
retreat umax to the previous one).

Example:

  If we have:
        u64=[0x1,0xfffffff800000000] u32=[0x0,0x0]
  Go to the next 32-bit block:
        u64=[0x100000000,0xfffffff800000000] u32=[0x0,0x0]

This way we keep the consistency on the lower 32 bits boundaries.
The same applies for the max value, but go to the previous 32-bit block.


Full BPF prog for reference:
============================

NOTE: this was extracted from a reproducer of Syzbot from another bug
report.

  insn 0: (61) r2 = *(u32 *)(r1 + 48)
  insn 1: (61) r3 = *(u32 *)(r1 + 76)
  insn 2: (bf) r0 = r2
  insn 3: (16) if w0 == 21502727 goto pc+16
  insn 4: (3d) if r3 >= r0 goto pc+1
  insn 5: (0f) r2 += r0
  insn 6: (bc) w6 = (s16)w2
  insn 7: (bf) r7 = (s32)r6
  insn 8: (16) if w2 == 524047 goto pc+0
  insn 9: (67) r2 <<= 7
  insn 10: (36) if w6 >= -268376562 goto pc+0
  insn 11: (bf) r5 = r0
  insn 12: (0f) r5 += r6
  insn 13: (65) if r7 s> 2 goto pc-12
  insn 14: (07) r7 += 4194380
  insn 15: (1f) r5 -= r7
  insn 16: (bf) r4 = r5
  insn 17: (07) r5 += -458749
  insn 18: (ad) if r3 < r4 goto pc+1
  insn 19: (95) exit
  insn 20: (05) goto pc+0
  insn 21: (95) exit
  insn 22: (4d) if r11 & r9 goto pc-28203
  insn 23: (99) if w3 >= -2094934247 goto pc-30763

The reproducer can be found at:
  https://syzkaller.appspot.com/text?tag=ReproC&x=16773406580000

Fixes: c51d5ad6543c ("bpf: improve deduction of 64-bit bounds from 32-bit bounds")
Signed-off-by: Helen Koike <koike@igalia.com>

---

Hi all,

I'm not familiar with the verifier code base or discussions around it,
but I tried to do my best, I searched a bit if this was already
discussed, but the discussions I found didn't seem related.

Please let me know if this case was already discussed and/or if I should
follow a different path into solving this.

Tested on bpf/master branch.

Thanks in advance.
---
 kernel/bpf/verifier.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a965b2c45bbe..ddac09c8a9e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2702,9 +2702,29 @@ static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
 	__u64 new_umin, new_umax;
 	__s64 new_smin, new_smax;
 
-	/* u32 -> u64 tightening, it's always well-formed */
-	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
-	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
+	/*
+	 * If (u32)umin > u32_max, no value in the current upper-32-bit block
+	 * satisfies [u32_min, u32_max] while being >= umin; advance umin to
+	 * the next block. Otherwise apply standard u32->u64 tightening.
+	 */
+	if ((u32)reg->umin_value > reg->u32_max_value)
+		new_umin = (reg->umin_value & ~0xffffffffULL) + (1ULL << 32) |
+			   reg->u32_min_value;
+	else
+		new_umin = (reg->umin_value & ~0xffffffffULL) |
+			   reg->u32_min_value;
+
+	/*
+	 * Symmetrically, if (u32)umax < u32_min, retreat umax to the
+	 * previous block. Otherwise apply standard u32->u64 tightening.
+	 */
+	if ((u32)reg->umax_value < reg->u32_min_value)
+		new_umax = (reg->umax_value & ~0xffffffffULL) - (1ULL << 32) |
+			   reg->u32_max_value;
+	else
+		new_umax = (reg->umax_value & ~0xffffffffULL) |
+			   reg->u32_max_value;
+
 	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
 	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
 	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
-- 
2.53.0

