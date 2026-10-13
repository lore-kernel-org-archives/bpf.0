Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7D526A84
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913030; cv=none; b=ZgUQVJr6Epjec9YmlAzw4UgO5o5AR7Ctr9jvDhmG7agZMDVKBxBUrApOm1EugLOFHhHF4cqsayvcPR0i/QTgYc+w+LckWyAo05r6FFrzKDM1lomuqxWdl6DIrgURh2Y6CHYlvEN16vb5zxE4cS4WLp6rkxWCFl05BAx1+v9dr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913030; c=relaxed/simple;
	bh=yJclfqFT76F0nVltHDUwQcCe2Nl9o9fIm59BdcFZcmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNFXRblH/SIgravOGnNRUQURVy576OvX03vooukI+szjU2JgYdG2kuNTV91A4FsySb0gaCfPat7oZw4KsjFzoka7ildlzY90FPU54siDS2DR/dNu+qjf+sYfpTqy0zflJ868dWPwlQNVycpzVfV3MZMoKeZlPBTUZT8Up0pZuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rj6BIKFG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rj6BIKFG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YNhfGxA4XJJHnuZK8FzZFfLiB4pYwflWe5bTMABEWJs=; b=rj6BIKFGO89SGTlInzWbqK/Tm9
	HrVnUCbBxibLArPVlvD2/71v+gUK2tiV0W1us6GYNuQSqT56gSM/sXqPd3XLs0suNL+VhJTVmdmbn
	bDHS+2MYkLo6aL3xzXMW+loUxV8eNm2X5NswxS0Ibb7doHxP/jwz1M4qETK0l/ysUB6lcuQRo030r
	wA41pitgeiM8GZT8lCm3R7iBgReYBqy1GgBrVozKIVsQjadVu0WKIiDNE0/lZmetDGUXjylPF8q0y
	ihNsBdFzrm5ME3cM8tKKlyFpvU/ftMmtVSV1qkMM1HGl6MF8jnapq8N/t8oaG5LurfldnqEMp8/aR
	QPMuLT/w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3J-000PRb-1r;
	Tue, 13 Oct 2026 19:12:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 11/18] bpf, x86: Fold the PROBE_MEM address computation into a lea
Date: Tue, 13 Oct 2026 19:12:23 +0200
Message-ID: <20261013171230.523677-12-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

The kernel address check in front of a BPF_PROBE_MEM load computed
src_reg + off - VSYSCALL_ADDR with a mov of VSYSCALL_ADDR, a mov of
the base register, an add of the offset in imm32 form and a sub, that
is 20 bytes and 4 uops. VSYSCALL_ADDR is -10 MiB, so together with
the 16-bit instruction offset it fits into a 32-bit displacement and
a single lea does the same in 7 bytes and 1 uop on Intel and AMD.

Before, for the check on r0 = *(u64 *)(r1 + 16):

  49 c7 c2 00 00 60 ff           movq $0xffffffffff600000,%r10
  49 89 fb                       movq %rdi,%r11
  49 81 c3 10 00 00 00           addq $0x10,%r11
  4d 29 d3                       subq %r10,%r11

After:

  4c 8d 9f 10 00 a0 00           leaq 0xa00010(%rdi),%r11

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index de49d7f51a54..75194f9caa5a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2853,22 +2853,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				u64 limit = TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR;
 				u8 *end_of_jmp;
 
-				/* movabsq r10, VSYSCALL_ADDR */
-				emit_mov_imm64(&prog, BPF_REG_AX, (long)VSYSCALL_ADDR >> 32,
-					       (u32)(long)VSYSCALL_ADDR);
-
-				/* mov src_reg, r11 */
-				EMIT_mov(AUX_REG, src_reg);
-
-				if (insn->off) {
-					/* add r11, insn->off */
-					maybe_emit_1mod(&prog, AUX_REG, true);
-					EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
-				}
-
-				/* sub r11, r10 */
-				maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
-				EMIT2(0x29, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
+				/*
+				 * lea r11, [src_reg + insn->off - VSYSCALL_ADDR]
+				 *
+				 * VSYSCALL_ADDR is a small negative number, so the
+				 * whole offset fits into the 32-bit displacement.
+				 */
+				BUILD_BUG_ON((long)(s32)VSYSCALL_ADDR != (long)VSYSCALL_ADDR);
+				EMIT2(add_2mod(0x48, src_reg, AUX_REG), 0x8D);
+				emit_insn_suffix(&prog, src_reg, AUX_REG,
+						 insn->off - (s32)VSYSCALL_ADDR);
 
 				/* movabsq r10, limit */
 				emit_mov_imm64(&prog, BPF_REG_AX, (long)limit >> 32,
-- 
2.43.0

