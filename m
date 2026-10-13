Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5CF52843E
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913042; cv=none; b=Z73UhRs8x7EShk0dpqjCNk2ZAJngOGSTx7dtdv/A4Ox2ybtdm375mpE5V7HKLJLzuvO2f3BBXRE/ME1/qVQ55WImZWAkk1JHoPMCvmdEjB13nBSwUixR9QmBPga7eFQ8LhQUAo1wPbj8zG4efj431m6HsMn9SyaBxRztMFxGGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913042; c=relaxed/simple;
	bh=yXvpEgG8Z++Ll6jhuVtsw9KadB2VxgJrszc1RiEKZJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7GtU6CJ+izXDhpkBfiZAibmkvWEnoZMyANGHiRZW5RGCtV+moXj4LYuO2CIcS7KuNIe0voqHYYJGhSND8SV9TcXI04SwgzLsmYK2dmJtTzqrAh6tgWu0YYGi+E32nfUSwH9SVWFHEJ/wyd1OvC/9dZia9jzm8B/IGVKsgoRZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=K1ctI+Lk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="K1ctI+Lk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MgUDraXPZuh98PWYXKrs+kKtagFYqIixOLlLYQaU2r4=; b=K1ctI+LktxjRgnws/T2cY97XBg
	xa3gxHe2aQ94jGdRjBYQ3lLq3GSaqEEvKExwn1kC1tgB/9PZynfRvQVi+xi7fabh4BwovOMSrOGy+
	IuPVk9oldlXppOqLQAuIbLabSfuyGlC2PIKz3yy7lQu26yTfKvnXjxpK0bhKlBcKEggtL5Q0P0CFg
	+PBVMAGLnKOlkE803ZOTWj8WXhk4O9/dhOANJMJ80hQBRhWRGBSpLEWVc5eAeZRoKk9yz6+zoHRGo
	L9tMJE/NQd7hJK8mI1ZA9Q4Ozo9FqlQSFIEoTCo4KLfMu7kBVzfgVw8C5jVlUAYyWM6Wsq62Rg3+i
	b/sDEvgA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3G-000PQV-0x;
	Tue, 13 Oct 2026 19:12:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 05/18] bpf, x86: Compare against 0, 127 and -128 with the adjusted condition
Date: Tue, 13 Oct 2026 19:12:17 +0200
Message-ID: <20261013171230.523677-6-daniel@iogearbox.net>
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

A strict compare against 1 or 128 is the non-strict compare against 0
or 127, and a strict compare against -129 or, with a signed condition,
-1 the non-strict compare against -128 or 0. LLVM canonicalizes x <= 0
to x < 1, x >= 0 to x > -1 and x <= 127 to x < 128, so these reach the
JIT as compares against 1, -1 and 128. Adjust the condition and the
immediate, so that the compare against 0 becomes the test without an
immediate already emitted for it and 127 and -128 fit into an imm8.

Before, for if r1 s> -1 goto ... and if r1 < 128 goto ...:

  48 83 ff ff           cmpq $-0x1,%rdi
  7f xx                 jg ...
  48 81 ff 80 00 00 00  cmpq $0x80,%rdi
  72 xx                 jb ...

After:

  48 85 ff              testq %rdi,%rdi
  7d xx                 jge ...
  48 83 ff 7f           cmpq $0x7f,%rdi
  76 xx                 jbe ...

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 65 +++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 079703c173a5..70473cd43aa8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2011,6 +2011,54 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
 	return prog - start;
 }
 
+/*
+ * A strict compare against 1 or 128 is the non-strict one against 0 or
+ * 127, a strict one against -129 or, with a signed condition, -1 the
+ * non-strict one against -128 or 0: the compare against 0 is a test
+ * without immediate, 127 and -128 fit into an imm8.
+ */
+static void adjust_cmp_imm(u32 *op, s32 *imm)
+{
+	if (*imm == 1 || *imm == 128) {
+		switch (*op) {
+		case BPF_JLT:
+			*op = BPF_JLE;
+			break;
+		case BPF_JGE:
+			*op = BPF_JGT;
+			break;
+		case BPF_JSLT:
+			*op = BPF_JSLE;
+			break;
+		case BPF_JSGE:
+			*op = BPF_JSGT;
+			break;
+		default:
+			return;
+		}
+		*imm -= 1;
+	} else if (*imm == -1 || *imm == -129) {
+		switch (*op) {
+		case BPF_JGT:
+		case BPF_JLE:
+			/* -1 is the largest unsigned value */
+			if (*imm == -1)
+				return;
+			*op = *op == BPF_JGT ? BPF_JGE : BPF_JLT;
+			break;
+		case BPF_JSGT:
+			*op = BPF_JSGE;
+			break;
+		case BPF_JSLE:
+			*op = BPF_JSLT;
+			break;
+		default:
+			return;
+		}
+		*imm += 1;
+	}
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2153,6 +2201,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		u8 jmp_cond;
 		u8 *func;
 		int nops;
+		u32 jmp_op = BPF_OP(insn->code);
+		s32 cmp_imm;
 
 		if (priv_frame_ptr) {
 			if (src_reg == BPF_REG_FP)
@@ -3122,8 +3172,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_JMP32 | BPF_JSLT | BPF_K:
 		case BPF_JMP32 | BPF_JSGE | BPF_K:
 		case BPF_JMP32 | BPF_JSLE | BPF_K:
+			cmp_imm = imm32;
+			adjust_cmp_imm(&jmp_op, &cmp_imm);
+
 			/* test dst_reg, dst_reg to save one extra byte */
-			if (imm32 == 0) {
+			if (cmp_imm == 0) {
 				maybe_emit_mod(&prog, dst_reg, dst_reg,
 					       BPF_CLASS(insn->code) == BPF_JMP);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
@@ -3134,15 +3187,15 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			maybe_emit_1mod(&prog, dst_reg,
 					BPF_CLASS(insn->code) == BPF_JMP);
 
-			if (is_imm8(imm32))
-				EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
+			if (is_imm8(cmp_imm))
+				EMIT3(0x83, add_1reg(0xF8, dst_reg), cmp_imm);
 			else if (is_axreg(dst_reg))
-				EMIT1_off32(0x3D, imm32);
+				EMIT1_off32(0x3D, cmp_imm);
 			else
-				EMIT2_off32(0x81, add_1reg(0xF8, dst_reg), imm32);
+				EMIT2_off32(0x81, add_1reg(0xF8, dst_reg), cmp_imm);
 
 emit_cond_jmp:		/* Convert BPF opcode to x86 */
-			switch (BPF_OP(insn->code)) {
+			switch (jmp_op) {
 			case BPF_JEQ:
 				jmp_cond = X86_JE;
 				break;
-- 
2.43.0

