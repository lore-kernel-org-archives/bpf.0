Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125493;
	b=woK1uWfGVXXk3OZzkkifZ+mtm/o2Sc/xk3XjoAvJVIf3LzBLUn1c+wKgoc7w7qrVKi8V
	 coJUAfryiIKb9rMYSU2VXUAVeIWu5PX6uWZTJPh15k3TxLMGZ8TMXldJbhTzlWOwDL1NV
	 C5xoMD2GZKP9PHXIH+8H4VOI+ynALcDz1bJYjGS6XyT+zSsOiV0zucvAUe5mjU5cxlduM
	 PRVL4RnPCUzTvABtHjAH48FZh4lXy4WTNQxQiimqGGPxdW2l1svCxySNkop8dNfdH9LIW
	 7NTZT/6vcg//mBdL+t3Qeu1HGURq4eLNGDfoZcVgP5Ay4lwle9WZ06+VGkFuIccyURQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125493;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=ZDT6pr2h3s1B1FyymCuiejrVzZdWcUxVZz4JCdtxmPY=;
	b=29eIDH/3oXgVxn1ArEG0gVzztcasp9WzLe5MR+5pIK9iWb0RPCZf3hUfncH2NP8ZTWgm
	 DVoBmSyiPiI1CVgyrqmKBQUqxU5kclBmphF/yd+q662MJGkm9RSpvbM8eK/RktA3OHS+e
	 ruS9KO0/4ka+UiVz/vL6WMBbUpYtpDHZDnovn+OONB37RSGfe4l5imvaz/9LfSryJps98
	 qMp//SuwOpvmVvw/KjQSsBHsRFNK/KtMAYkirVVCPOm6qUWwi+btlguRxSY2LLSEv5IP9
	 uhZx6LzvDtFmkXSMMopZbdYGRuVpNVmqyaAPZPGRmD0LLGjMIyRvPFZWcKQhXZnF8LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="qvhtWD/d";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E49606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E49606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=qvhtWD/d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZDT6pr2h3s1B1FyymCuiejrVzZdWcUxVZz4JCdtxmPY=; b=qvhtWD/d+9USUe7ZC79Ca3bOaD
	bEaksx7acMc3BcG3D57C88nqVPwzS9lZ8Q2KmNe8VwkKuYCoIA25KYihIFx7Dqw18Kgn7YBZcaiYk
	TYcZ14+rT++vMNVQEBZ+3zttVluF+k3WfO62SeKiHVrbYuULF9frXyptp6/tXOSQk4c6Tswv2B/7d
	ptW57jkt6J1kDm/TcoZaUHPjeA8utTH8jRWKkEoSbDvzOpsFYaFQ587RShMZ+N751sh89sy5MHrfa
	02Zqlc2lEIUf4ulbTeTHG87amM3JKLeDU7dGoqCuyamr3e54ZCBZYh0v85710WwHUz/kSY6kwWpmT
	3QUdIlaQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqs-000IkR-2v;
	Tue, 27 Oct 2026 19:24:50 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 07/21] bpf: Move the division magic number computation out of the x86 JIT
Date: Tue, 27 Oct 2026 19:24:31 +0100
Message-ID: <20261027182445.1156335-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

bpf_magic_udiv() and bpf_magic_sdiv() compute the multiplier and shift
for the division by a constant and have nothing x86 specific, so move
them to the core for the other JITs to use. They divide 64-bit values by
a divisor only known at run time, which a 32-bit kernel has no inline
form for, so they come under CONFIG_64BIT like the JITs which can use
them. No functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 97 -------------------------------------
 include/linux/filter.h      | 11 +++++
 kernel/bpf/core.c           | 93 +++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 97 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d0039d..8eeeefbde0cb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2066,103 +2066,6 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 	*pprog = prog;
 }
 
-struct bpf_div_magic {
-	u64 m;		/* multiplier, sign extended for signed division */
-	int s;		/* shift of the high half of the product */
-	bool add;	/* multiplier has 65 bits, use the add sequence */
-};
-
-/*
- * Multiplier and shift for an unsigned division by the constant d, with
- * 2 <= d < 2^64 and a dividend below 2^(64 - lz): n / d == (mulhu(n, m)
- * >> s), or with the add sequence when m needs 65 bits, (((n - t) >> 1)
- * + t) >> (s - 1) with t = mulhu(n, m). Hacker's Delight, 2nd ed., figure
- * 10-2.
- */
-static void bpf_magic_udiv(u64 d, int lz, struct bpf_div_magic *mag)
-{
-	u64 mask = ~0ULL >> (lz & 63);
-	u64 nc, delta, q1, r1, q2, r2;
-	int p;
-
-	mag->add = false;
-	/* Largest value with nc mod d == d - 1 */
-	nc = mask - (mask % d + 1) % d;
-	p = 63;
-	q1 = (1ULL << 63) / nc;			/* 2^p / nc */
-	r1 = (1ULL << 63) - q1 * nc;		/* 2^p mod nc */
-	q2 = (~0ULL >> 1) / d;			/* (2^p - 1) / d */
-	r2 = (~0ULL >> 1) - q2 * d;		/* (2^p - 1) mod d */
-	do {
-		p++;
-		if (r1 >= nc - r1) {
-			q1 = 2 * q1 + 1;
-			r1 = 2 * r1 - nc;
-		} else {
-			q1 = 2 * q1;
-			r1 = 2 * r1;
-		}
-		if (r2 + 1 >= d - r2) {
-			if (q2 >= (~0ULL >> 1))
-				mag->add = true;
-			q2 = 2 * q2 + 1;
-			r2 = 2 * r2 + 1 - d;
-		} else {
-			if (q2 >= (1ULL << 63))
-				mag->add = true;
-			q2 = 2 * q2;
-			r2 = 2 * r2 + 1;
-		}
-		delta = d - 1 - r2;
-	} while (p < 128 && (q1 < delta || (q1 == delta && r1 == 0)));
-
-	mag->m = q2 + 1;
-	mag->s = p - 64;
-}
-
-/*
- * Multiplier and shift for a signed division by the constant d, with
- * 2 <= |d| < 2^63: q = mulhs(n, m), q += n if d > 0 and m < 0, q -= n
- * if d < 0 and m > 0, q >>= s (arithmetic), n / d == q + (q >>> 63).
- * Hacker's Delight, 2nd ed., figure 10-1.
- */
-static void bpf_magic_sdiv(s64 d, struct bpf_div_magic *mag)
-{
-	u64 ad = d < 0 ? -(u64)d : (u64)d;
-	u64 t, anc, delta, q1, r1, q2, r2;
-	int p;
-
-	t = (1ULL << 63) + (d < 0);
-	anc = t - 1 - t % ad;			/* |nc| */
-	p = 63;
-	q1 = (1ULL << 63) / anc;		/* 2^p / |nc| */
-	r1 = (1ULL << 63) - q1 * anc;		/* 2^p mod |nc| */
-	q2 = (1ULL << 63) / ad;			/* 2^p / |d| */
-	r2 = (1ULL << 63) - q2 * ad;		/* 2^p mod |d| */
-	do {
-		p++;
-		q1 = 2 * q1;
-		r1 = 2 * r1;
-		if (r1 >= anc) {
-			q1++;
-			r1 -= anc;
-		}
-		q2 = 2 * q2;
-		r2 = 2 * r2;
-		if (r2 >= ad) {
-			q2++;
-			r2 -= ad;
-		}
-		delta = ad - r2;
-	} while (q1 < delta || (q1 == delta && r1 == 0));
-
-	mag->m = q2 + 1;
-	if (d < 0)
-		mag->m = -mag->m;
-	mag->s = p - 64;
-	mag->add = false;
-}
-
 /*
  * Divide dst_reg by the constant in insn->imm of a 64-bit division through
  * a multiplication with the magic number from bpf_magic_udiv() or
diff --git a/include/linux/filter.h b/include/linux/filter.h
index e0218e677a1d..f2e5e70c0aff 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1483,6 +1483,17 @@ void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
 int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 				struct bpf_jit_poke_descriptor *poke);
 
+#ifdef CONFIG_64BIT
+struct bpf_div_magic {
+	u64 m;		/* multiplier, sign extended for signed division */
+	int s;		/* shift of the high half of the product */
+	bool add;	/* multiplier has 65 bits, use the add sequence */
+};
+
+void bpf_magic_udiv(u64 d, int lz, struct bpf_div_magic *mag);
+void bpf_magic_sdiv(s64 d, struct bpf_div_magic *mag);
+#endif
+
 int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3030beb531d9..14f643c49d84 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1312,6 +1312,99 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 	bpf_prog_unlock_free(fp);
 }
 
+#ifdef CONFIG_64BIT
+/*
+ * Multiplier and shift for an unsigned division by the constant d, with
+ * 2 <= d < 2^64 and a dividend below 2^(64 - lz): n / d == (mulhu(n, m)
+ * >> s), or with the add sequence when m needs 65 bits, (((n - t) >> 1)
+ * + t) >> (s - 1) with t = mulhu(n, m). Hacker's Delight, 2nd ed., figure
+ * 10-2.
+ */
+void bpf_magic_udiv(u64 d, int lz, struct bpf_div_magic *mag)
+{
+	u64 mask = ~0ULL >> (lz & 63);
+	u64 nc, delta, q1, r1, q2, r2;
+	int p;
+
+	mag->add = false;
+	/* Largest value with nc mod d == d - 1 */
+	nc = mask - (mask % d + 1) % d;
+	p = 63;
+	q1 = (1ULL << 63) / nc;			/* 2^p / nc */
+	r1 = (1ULL << 63) - q1 * nc;		/* 2^p mod nc */
+	q2 = (~0ULL >> 1) / d;			/* (2^p - 1) / d */
+	r2 = (~0ULL >> 1) - q2 * d;		/* (2^p - 1) mod d */
+	do {
+		p++;
+		if (r1 >= nc - r1) {
+			q1 = 2 * q1 + 1;
+			r1 = 2 * r1 - nc;
+		} else {
+			q1 = 2 * q1;
+			r1 = 2 * r1;
+		}
+		if (r2 + 1 >= d - r2) {
+			if (q2 >= (~0ULL >> 1))
+				mag->add = true;
+			q2 = 2 * q2 + 1;
+			r2 = 2 * r2 + 1 - d;
+		} else {
+			if (q2 >= (1ULL << 63))
+				mag->add = true;
+			q2 = 2 * q2;
+			r2 = 2 * r2 + 1;
+		}
+		delta = d - 1 - r2;
+	} while (p < 128 && (q1 < delta || (q1 == delta && r1 == 0)));
+
+	mag->m = q2 + 1;
+	mag->s = p - 64;
+}
+
+/*
+ * Multiplier and shift for a signed division by the constant d, with
+ * 2 <= |d| < 2^63: q = mulhs(n, m), q += n if d > 0 and m < 0, q -= n
+ * if d < 0 and m > 0, q >>= s (arithmetic), n / d == q + (q >>> 63).
+ * Hacker's Delight, 2nd ed., figure 10-1.
+ */
+void bpf_magic_sdiv(s64 d, struct bpf_div_magic *mag)
+{
+	u64 ad = d < 0 ? -(u64)d : (u64)d;
+	u64 t, anc, delta, q1, r1, q2, r2;
+	int p;
+
+	t = (1ULL << 63) + (d < 0);
+	anc = t - 1 - t % ad;			/* |nc| */
+	p = 63;
+	q1 = (1ULL << 63) / anc;		/* 2^p / |nc| */
+	r1 = (1ULL << 63) - q1 * anc;		/* 2^p mod |nc| */
+	q2 = (1ULL << 63) / ad;			/* 2^p / |d| */
+	r2 = (1ULL << 63) - q2 * ad;		/* 2^p mod |d| */
+	do {
+		p++;
+		q1 = 2 * q1;
+		r1 = 2 * r1;
+		if (r1 >= anc) {
+			q1++;
+			r1 -= anc;
+		}
+		q2 = 2 * q2;
+		r2 = 2 * r2;
+		if (r2 >= ad) {
+			q2++;
+			r2 -= ad;
+		}
+		delta = ad - r2;
+	} while (q1 < delta || (q1 == delta && r1 == 0));
+
+	mag->m = q2 + 1;
+	if (d < 0)
+		mag->m = -mag->m;
+	mag->s = p - 64;
+	mag->add = false;
+}
+#endif /* CONFIG_64BIT */
+
 int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed)
-- 
2.43.0

