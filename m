Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14E175A62
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996790; cv=none; b=acPwuiEdsWe1IPk34dg2gPy1jpvJRTThfqtz09wJKPH+Rth6aUSfb2gcX8T2xEh8NjXcHyxa1j1qxo8xT8mjUG0nwWazBxrM9Ooc5lvwegtbXoRKwyAHVFAPt8CN9G5yExRY1z0Nl0pj9nyInwnWgsvcmzOIymPCdcbAsH0lJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996790; c=relaxed/simple;
	bh=wBqZfJGdU4msOJEWrL9VNeL2WxnfC6q8Zt4sZiaQGqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nGF+lo/n+5mROEPOx0vrl+CLFFJGX1ti85xF8BcjrQixoMJGgwDRZ2iqCVo+WxxHKdYRyCBX0Tdk3KJ5YY46oYW4i4pB7m8WGnKSaZV0EkVznwGwsZseBP9QLDP7G5I+f5PQQrUuIlSQaB2nn3fxYBE72K2k2FKYa4rWpJau2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYmgifKn; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYmgifKn"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9305a2121a1so61856185a.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 19:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783996788; x=1784601588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3rc1RXStiYqZtPaUc3S6izdfojmabIL7opn10dwqM0=;
        b=fYmgifKnwUuSRNKOSfcDkM+g8YgqiO2scHDEJuFS54dVopXBimC0FnIEn13htfisZP
         HABTA/8IdpKUdEb/ECp6OjCM1IbifmNQulYfZ3FHSPKIpOvgNSEV6+h16mqiuSnWw4/i
         /AAzUrx7E0byJWABUXY3d7IaGDbzN8uvlABDOPNioamX8N9hqN2KPB++zWUuZQ4ZDZkn
         38nJeOaRRrvur23bWDVnF3ZBXJ3Ijvfy82cE+QJfukpgxs/yl2sTBZ8B2uMQPuBeXUkG
         1XHA56B1BirhPYgbdML0pv1US+nWlIP9Zu/IKCzkYL3lFgnHzSWNduTNy8kZ7rU4F7wE
         hNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783996788; x=1784601588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3rc1RXStiYqZtPaUc3S6izdfojmabIL7opn10dwqM0=;
        b=UnzfaZk3z7k8U4PZLJv9p0PLqP2pK6oKaPSAYSKQf1pmfAhaFRVVQo6YWeFNjrJSzq
         L0+SPRpPVCSfkdTj8Bad1qxemokFsEbb5J4EHwi1VZpL9FWHPxl1nvSBtko1YARkP6Gi
         801HejIsxNTqSDDdjWDtP+lZp1oqPPT3RcR2Q9c5yAES8kL952M1nbY/caujgCSG18Vn
         yMqcQZaUOxoBjxl8zAzFEJMQjhsNkxeqoftaZJwSgjmk9YYhiOmb/5Lq/w6AlSPTR91q
         dAhhBHfB2JSlN6UbUHTf4/RUpCKHkHmM6qLSMhOTPXy0LvT3B1/aXZpiuIepGsSHo97G
         GKgg==
X-Gm-Message-State: AOJu0YwKX20oa6dSv1x1cmEuFj10tBJL2BX/B6cBvLUZyoWP+3ofiiRB
	fA0u0JTbyyIM94dPUZ5gr0jgVJFlPsChCKDGo17+ns0TckoEBzuULPdD9VVGumc3
X-Gm-Gg: AfdE7clqjguMjURYqO6a4k+vWR3w1oSu4UnciL0bTKdMCEvh+peQhZ/dpkWN/K3Rha7
	4mtbf2ndS1gAX7GtnPjnsaXPl410MiAaauUwm7z8rPeed6uoi0wLLhrXxzzrdlmEaB8OO02hN32
	SWeuPo41xhZ9wY7C/qGA6cgShg5znM5pfOf+bYOZ4a1TvnBw15RvcigJuDzID6fnt7UsGd/cAzo
	y1tjEjgXVJr50bkRmFFHu9A4mTMahqQyInzPHGHd697zMPRbLUj7KkGSITjimbMPV6Lz4/ax6Vu
	ZYUyP1zEJwnhBdXbBfyYIAckC6QkQZSEADepmQNJil5PPZIFjYexuzsBuuQ9SxpOoo577A3moY6
	Ta+JJmovzSbZlfwjEzCSXYnMrAAEiXvsZ2GAEJ24TrkiaPMKU+9jCC/qLtlhBM1rSgRQTRuBpre
	XYXE7UR43l6y+gSfA8
X-Received: by 2002:a05:620a:40cb:b0:92e:f379:3119 with SMTP id af79cd13be357-92ef37940d8mr1225572385a.30.1783996788177;
        Mon, 13 Jul 2026 19:39:48 -0700 (PDT)
Received: from TurinLinux.. ([37.19.213.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b88a38sm1260926085a.12.2026.07.13.19.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 19:39:47 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org,
	udknight@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	visitorckw@gmail.com
Subject: [PATCH bpf-next v2] bpf, x86: Add support for BPF_SDIV and BPF_SMOD in the i386 JIT
Date: Mon, 13 Jul 2026 22:39:39 -0400
Message-Id: <20260714023939.616686-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

emit_ia32_div_mod_r() emits an unsigned divide (xor edx,edx + div ecx)
for BPF_DIV and BPF_MOD regardless of the instruction's signedness, so
the i386 JIT does not implement signed BPF_SDIV and BPF_SMOD (off == 1),
which get an unsigned quotient and remainder rather than the verifier's
and the interpreter's signed result for negative operands.

Add signed support. Pass the instruction to emit_ia32_div_mod_r() and,
on the signed path (off == 1), emit cdq + idiv ecx instead of
xor edx,edx + div ecx, mirroring the cdq/idiv-vs-xor/div split the
x86_64 JIT uses. bpf_do_misc_fixups() rewrites the zero-divisor and
INT_MIN/-1 cases out of the instruction stream before the JIT runs.

The RV32 JIT has the same gap.

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
v2:
- Frame as adding support and drop the Fixes tag, per Pu Lehui [1].
- Pass struct bpf_insn * to emit_ia32_div_mod_r() rather than separate
  op and is_signed parameters, per Kuan-Wei Chiu.

v1: https://lore.kernel.org/bpf/20260713185848.120137-1-main.kalliope@gmail.com/
[1]: https://lore.kernel.org/bpf/fa8a040f-64c4-484f-9538-fb0ec287639f@huawei.com/

 arch/x86/net/bpf_jit_comp32.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 852baf2e4db4..012161da3e82 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -432,11 +432,13 @@ static inline void emit_ia32_to_be_r64(const u8 dst[], s32 val,
  * ALU operation (32 bit)
  * dst = dst (div|mod) src
  */
-static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
-				       bool dstk, bool sstk, u8 **pprog)
+static inline void emit_ia32_div_mod_r(const struct bpf_insn *insn, const u8 dst,
+				       const u8 src, bool dstk, bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
 	int cnt = 0;
+	const u8 op = BPF_OP(insn->code);
+	const bool is_signed = (insn->off == 1);
 
 	if (sstk)
 		/* mov ecx,dword ptr [ebp+off] */
@@ -454,10 +456,17 @@ static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
 		/* mov eax,dst */
 		EMIT2(0x8B, add_2reg(0xC0, dst, IA32_EAX));
 
-	/* xor edx,edx */
-	EMIT2(0x31, add_2reg(0xC0, IA32_EDX, IA32_EDX));
-	/* div ecx */
-	EMIT2(0xF7, add_1reg(0xF0, IA32_ECX));
+	if (is_signed) {
+		/* cdq */
+		EMIT1(0x99);
+		/* idiv ecx */
+		EMIT2(0xF7, add_1reg(0xF8, IA32_ECX));
+	} else {
+		/* xor edx,edx */
+		EMIT2(0x31, add_2reg(0xC0, IA32_EDX, IA32_EDX));
+		/* div ecx */
+		EMIT2(0xF7, add_1reg(0xF0, IA32_ECX));
+	}
 
 	if (op == BPF_MOD) {
 		if (dstk)
@@ -1795,14 +1804,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_ALU | BPF_MOD | BPF_X:
 			switch (BPF_SRC(code)) {
 			case BPF_X:
-				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
+				emit_ia32_div_mod_r(insn, dst_lo,
 						    src_lo, dstk, sstk, &prog);
 				break;
 			case BPF_K:
 				/* mov ecx,imm32*/
 				EMIT2_off32(0xC7, add_1reg(0xC0, IA32_ECX),
 					    imm32);
-				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
+				emit_ia32_div_mod_r(insn, dst_lo,
 						    IA32_ECX, dstk, false,
 						    &prog);
 				break;

base-commit: 9a3a07d06e7d74f4aecc51396c771149336ac55d
-- 
2.34.1

