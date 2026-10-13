Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95C489FD2
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913234; cv=none; b=sXtVdBMph+wLLXItY4wD3vrUGLNrYCtdqBmQVDb8wAhFC4K1tn9nBGXrq84ah7WgXieI76uG1Av3Ca3PmsGIkb0aG8tsUnXl5y2p+AzFZgHKDYqft3QkbFW3iGdmX/YupxfNqhnFFVGp7zKiZOdS1qn5ojAvmQgeaWSodmWOZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913234; c=relaxed/simple;
	bh=31I4zDkBr04od7on9RFrW77hw/hUPerkFGkBrDSofng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKeRkG0S9R+qbU849DSDttcnfdmhfxfX7aH26HfcNTb90mnrBPqQ2p51w/aefwJG9laM7MDqro6WxTG+TWLKv7KhzSa6yJl1cn4ssdcxzoYRATV6ENlEwrcSKdDGoxydRI6hBSKQKXHvbaLhYu1bqxjedJlbyf4y+CPexqtFOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XWwv4qR+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XWwv4qR+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uNqtZIZi/ACo2a3Cf2/ACK6Y5caiF+dG+k+HZQAPEyg=; b=XWwv4qR+p18/UEA+2VxIHD/EGi
	j2hoA4WQ2kEdjTcBnv9Szp3+XGrAncYalR342yokIurGThirJ7+m7cIHJZg+wsspbPoJkdocUmITJ
	hTwRfWB6uwdLmoXZCQesMeznQgSQY/dtSEokL6HysPqxST/H12+L3jWCPcgTC47xOIe08DrBxtWLa
	mWYKljLKwqEZYCmESf2XnfW4VhxCDkGEbuYchEpK6E3QntzA0WUJBO+aIVwhqO3xIWsudZHBFfMvp
	LG8QEYMk32uWvm0N8AaHxIn5a4PTRpT0S43pqWig5kdonCIUQu+TBUMBRU068n2C7YhiAw5tvXBvs
	JC21JH0Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3K-000PRg-0G;
	Tue, 13 Oct 2026 19:12:38 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 12/18] bpf, x86: Compare the PROBE_MEM address range with a shift
Date: Tue, 13 Oct 2026 19:12:24 +0200
Message-ID: <20261013171230.523677-13-daniel@iogearbox.net>
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

The PROBE_MEM check rejects src_reg + off - VSYSCALL_ADDR up to a limit
of TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR, which does not fit into a
32-bit immediate and therefore needed a movabs into r10 and a register
compare. Compare against the next power of two above the limit instead,
which is a shift by fls64(limit) followed by a jne on the result. The
addresses between the limit and that power of two are non-canonical on
every x86-64 layout, since user space ends at TASK_SIZE_MAX and the
kernel half starts far above 2^57, so they faulted and had the register
zeroed by the exception handler before. Now they are zeroed by the check
without taking the fault. The compare and branch stay two uops on Intel
and AMD, while the sequence shrinks from 15 to 6 bytes.

Before, for the compare of a 4-level paging kernel:

  49 ba 00 00 a0 00 00 80 00 00  movabsq $0x800000a00000,%r10
  4d 39 d3                       cmpq %r10,%r11
  77 05                          ja 0x...

After:

  49 c1 eb 30                    shrq $0x30,%r11
  75 05                          jne 0x...

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 75194f9caa5a..564cead6eab7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2848,6 +2848,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
 				 *   and
 				 *   src_reg + insn->off < VSYSCALL_ADDR
+				 *
+				 * The check is done on src_reg + insn->off - VSYSCALL_ADDR
+				 * against the next power of two above the limit. Addresses
+				 * between the limit and that power of two are non-canonical
+				 * and would fault anyway, so they get zeroed a bit earlier.
 				 */
 
 				u64 limit = TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR;
@@ -2864,16 +2869,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				emit_insn_suffix(&prog, src_reg, AUX_REG,
 						 insn->off - (s32)VSYSCALL_ADDR);
 
-				/* movabsq r10, limit */
-				emit_mov_imm64(&prog, BPF_REG_AX, (long)limit >> 32,
-					       (u32)(long)limit);
-
-				/* cmp r10, r11 */
-				maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
-				EMIT2(0x39, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
+				/* shr r11, fls64(limit) */
+				emit_shift_imm(&prog, BPF_RSH, AUX_REG, fls64(limit), true);
 
-				/* if unsigned '>', goto load */
-				EMIT2(X86_JA, 0);
+				/* if not zero, goto load */
+				EMIT2(X86_JNE, 0);
 				end_of_jmp = prog;
 
 				/* xor dst_reg, dst_reg */
@@ -2881,7 +2881,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				/* jmp byte_after_ldx */
 				EMIT2(0xEB, 0);
 
-				/* populate jmp_offset for JAE above to jump to start_of_ldx */
+				/* populate jmp_offset for JNE above to jump to start_of_ldx */
 				start_of_ldx = prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
 			} else if (!accesses_stack_only) {
-- 
2.43.0

