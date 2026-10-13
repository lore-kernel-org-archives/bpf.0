Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D63F326A
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913063; cv=none; b=pn9saiWTzWhhksY+AkTTgaEZMK8YDA3MCBnkN+40riCrSGyg1Pp/PAv1cTjGviupXFVppdlE/BqpRclj9vDFETlj+4PbbO4lOu7R01e64I5LRS+S/ChEopWJ9tJZmXkp1Yey+3wFrT6azWOMtpyc+sa5z2lMOJk8qluw7rjZ+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913063; c=relaxed/simple;
	bh=AGJTGfUZWmxlTEAstcLsOXIBNWpPIJr+TBhu1iBYaI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LD7ShNymHykXMhhege2EhbfZ7VaXL0202lpBoNccV3VCn66gMwWtDoEtlK1B1uFJApSJ7L+ZRq5/hP0AjyeLmEsrzyCTO+9tq3U4C0ZiJ6EdIigbwQj6dx8tP862u3vwgSa2NDVQUIFt8Tx19yby9t3NKuryXegP5PhRIbALx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Up7BZTDS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Up7BZTDS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=d9DQm347euNbmdzy3ybs8WhBXAt8pFTRze0mO0VVIDM=; b=Up7BZTDSZBoINOI3aIEjHF2ChV
	4nOrAYjhnVOcGdnaOONLzpS8QdhYRPvC+QYOCpRwZyZqNcjfNeQHoJDfib8/HzTj8w81KsCjHq2Bp
	Ejr06/GVl4y6jOy3Exre/JeABHBqrPsdRDumW9yg6GtdmUnbmm8JJMbBEYNqX5d96Kp9jG9tTLzvA
	UeXLsEJzRqxxiCZ/MmHapdwNiLYP0esh9hTxSAeQlYgUxR7qYapFSLjPN2UBe4Re940AtjiWyWubd
	8UDVX8uRCXrN6d6O76tCk7OpslSXe89fJrlCPVQJ+2VOSpTX2AnbOt1KJw+NXTK3Os75sgoxBq6e0
	wMzP9RHg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3M-000PS1-0K;
	Tue, 13 Oct 2026 19:12:40 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 16/18] bpf, x86: Shorten the cast to a user address
Date: Tue, 13 Oct 2026 19:12:28 +0200
Message-ID: <20261013171230.523677-17-daniel@iogearbox.net>
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

The cast of an arena pointer to its user address zero extended the low
half, shifted it up, or'ed the user base in, rotated it back down and
replaced the result with zero from a cleared r11 through a cmove for a
NULL pointer: seven instructions with a dependency chain of six. Or the
user base into r11 instead and pick it with a cmovne when the low half
is not zero, five instructions with a chain of three. LLVM emits the
cast for every arena pointer handed back to user space.

Before, for r1 = addr_space_cast(r7, 1, 0) with a user base of
0x7f1200000000:

  44 89 ef                       movl %r13d,%edi
  48 c1 e7 20                    shlq $0x20,%rdi
  48 81 cf 12 7f 00 00           orq $0x7f12,%rdi
  48 c1 c7 20                    rolq $0x20,%rdi
  4d 31 db                       xorq %r11,%r11
  85 ff                          testl %edi,%edi
  49 0f 44 fb                    cmoveq %r11,%rdi

After:

  44 89 ef                       movl %r13d,%edi
  49 bb 00 00 00 00 12 7f 00 00  movabsq $0x7f1200000000,%r11
  49 09 fb                       orq %rdi,%r11
  85 ff                          testl %edi,%edi
  49 0f 45 fb                    cmovneq %r11,%rdi

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c2fe72fa0bed..3975a94ac812 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2544,35 +2544,18 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU64 | BPF_MOV | BPF_X:
 			if (insn_is_cast_user(insn)) {
-				if (dst_reg != src_reg)
-					/* 32-bit mov */
-					emit_mov_reg(&prog, false, dst_reg, src_reg);
-				/* shl dst_reg, 32 */
-				maybe_emit_1mod(&prog, dst_reg, true);
-				EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
-
-				/* or dst_reg, user_vm_start */
-				maybe_emit_1mod(&prog, dst_reg, true);
-				if (is_axreg(dst_reg))
-					EMIT1_off32(0x0D,  user_vm_start >> 32);
-				else
-					EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
-
-				/* rol dst_reg, 32 */
-				maybe_emit_1mod(&prog, dst_reg, true);
-				EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
-
-				/* xor r11, r11 */
-				EMIT3(0x4D, 0x31, 0xDB);
-
-				/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
+				/* mov dst_reg32, src_reg32 to zero extend the low half */
+				emit_mov_reg(&prog, false, dst_reg, src_reg);
+				/* mov r11, the high half of user_vm_start; or r11, dst_reg */
+				emit_mov_imm64(&prog, AUX_REG, user_vm_start >> 32, 0);
+				emit_alu_reg(&prog, BPF_OR, AUX_REG, dst_reg, true);
+				/* test dst_reg32, dst_reg32; a NULL pointer stays NULL */
 				maybe_emit_mod(&prog, dst_reg, dst_reg, false);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
-
-				/* cmove r11, dst_reg; if so, set dst_reg to zero */
+				/* cmovne dst_reg, r11 */
 				/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
 				maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
-				EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
+				EMIT3(0x0F, 0x45, add_2reg(0xC0, AUX_REG, dst_reg));
 				break;
 			} else if (insn_is_mov_percpu_addr(insn)) {
 				/* mov <dst>, <src> (if necessary) */
-- 
2.43.0

