Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022194;
	b=ok68zGS/pvNjnTs+FEAq5IQ3M3BOOX8W60UGKE4sFDHPgBMX1UqZTCTa69+xKUMgBp43
	 O2BwusA8ewTU/L496GZ40FBnJPoTGUAzm3iVIGd+4n8VVcjXF9z2Ytd/kEi6nQxwRcNPI
	 jjhR88MB53DIBPF65rLYCZ+Pf2/kBqQ8/vivcs3OJjzIim97se0XOjofzMZwecGyI7KQ0
	 iDHzuDtsk+jzMfFSpk163AY06h8uFy7JzYCJ0H6o7kQDlV0eAfP3nGuWgUgE08XuMi2Jn
	 poM9PsNIpzsAqTIgS0kmumTM4ql+iHb6Bcfd0d/jhofUMvJPaegcGcdVnxiYlJSzpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dty6FKfr0IY8i3C5r+x+Q1A5fbb3pT0Dh4qS07V3mdw=;
	b=zqYhWl3egm77kO2UL9ilkAqDOzIEykx7C7MyfxkFbrCzsKt5Zylw9qMY6DuTBLBL4Mpd
	 Ln3QKWQbJeJJb/8zBZT386LUcfOk1lTDD4hzL1WZVVlENhkVCDAHGTjW5LCGGgUdkHIKn
	 KskXorL0dSh2lk9ZLwQ2dfnRPm5YXdaGyNm9VykTu26Mbp52Jo2HPSQJiQzKgXRVty5Qx
	 wdG9Q9c5RF5uyeFVrmlLMIEOIRL4qC0PSyGbRXebWwmK7pTLsYcES0uXSieDN3+85uEDu
	 j0rwnBBjySxhBt80XKUyRokO/svnIpbw666v8dJQ/01gSH0H1q9q20LWqASPLz2WhPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAdhNx9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E1606A322;
	Mon, 26 Oct 2026 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAdhNx9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312851F031E4;
	Mon, 26 Oct 2026 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022193;
	bh=Dty6FKfr0IY8i3C5r+x+Q1A5fbb3pT0Dh4qS07V3mdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAdhNx9wx0bTqCXTdNGIv7DBHxaJyQAQBYfK3TibJgykCYMcFOTkpfuxEGZOAbTr5
	 4qMF71NkK/BNYVUa5FoTV+3pv87j2JjZRVWyF7A+DEAMfx/4Pf+NuCT2p3+UTugzuv
	 n3geqgtumIm3Crn7fY5RxQA2r1TPpj4xYqhaS4CXUWzLvbT7A718UNpTaTxcV9joBX
	 9wOEuTyngOxtgiXoYzt/3UqDQBcfRtxU196/ArVa5jF4d/TWWOWMadVw9lrkYNbQmR
	 XHR1CI09oMyRJGSXB5rhRgl0yHp4g+cOHqEBe7g6YH1gywsIFOIROOWNMASBJQAaag
	 bAzgAIYR7qzbg==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 5/5] bpf, mips: Follow the boot-time R10000 LL/SC choice
Date: Mon, 26 Oct 2026 14:41:45 +0100
Message-ID: <20261026134147.15988-6-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026134147.15988-1-kaloz@kernel.org>
References: <20261026134147.15988-1-kaloz@kernel.org>
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

Programs are JITed after the R10000 LL/SC workaround has been selected
at boot. Emit the branch-likely in the atomic and cmpxchg ll/sc loops
only when the workaround is in use.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/net/bpf_jit_comp.c   |  5 +++--
 arch/mips/net/bpf_jit_comp.h   | 12 +++++++-----
 arch/mips/net/bpf_jit_comp32.c |  1 +
 arch/mips/net/bpf_jit_comp64.c |  5 +++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index 6ee4abe6a1f7..11e50193e205 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -112,6 +112,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu-features.h>
 #include <asm/isa-rev.h>
+#include <asm/r10k-llsc.h>
 #include <asm/uasm.h>
 
 #include "bpf_jit_comp.h"
@@ -432,7 +433,7 @@ void emit_atomic_r(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 code)
 		break;
 	}
 	emit(ctx, sc, MIPS_R_T8, off, dst);
-	emit(ctx, LLSC_beqz, MIPS_R_T8, -16 - LLSC_offset);
+	emit_llsc_beqz(ctx, MIPS_R_T8, -16 - LLSC_offset);
 	emit(ctx, nop); /* Delay slot */
 
 	if (code & BPF_FETCH) {
@@ -449,7 +450,7 @@ void emit_cmpxchg_r(struct jit_context *ctx, u8 dst, u8 src, u8 res, s16 off)
 	emit(ctx, bne, MIPS_R_T9, res, 12);
 	emit(ctx, move, MIPS_R_T8, src);     /* Delay slot */
 	emit(ctx, sc, MIPS_R_T8, off, dst);
-	emit(ctx, LLSC_beqz, MIPS_R_T8, -20 - LLSC_offset);
+	emit_llsc_beqz(ctx, MIPS_R_T8, -20 - LLSC_offset);
 	emit(ctx, move, res, MIPS_R_T9);     /* Delay slot */
 	clobber_reg(ctx, res);
 }
diff --git a/arch/mips/net/bpf_jit_comp.h b/arch/mips/net/bpf_jit_comp.h
index a37fe20818eb..3129691bccde 100644
--- a/arch/mips/net/bpf_jit_comp.h
+++ b/arch/mips/net/bpf_jit_comp.h
@@ -98,11 +98,13 @@ do {								\
 #define emit(...) __emit(__VA_ARGS__)
 
 /* Workaround for R10000 ll/sc errata */
-#ifdef CONFIG_WAR_R10000_LLSC
-#define LLSC_beqz	beqzl
-#else
-#define LLSC_beqz	beqz
-#endif
+static inline void emit_llsc_beqz(struct jit_context *ctx, u8 rs, s16 off)
+{
+	if (r10k_llsc_war)
+		emit(ctx, beqzl, rs, off);
+	else
+		emit(ctx, beqz, rs, off);
+}
 
 /* Workaround for Loongson-3 ll/sc errata */
 #ifdef CONFIG_CPU_LOONGSON3_WORKAROUNDS
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 15a2a153dc87..07aece9edc8e 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -18,6 +18,7 @@
 #include <linux/bpf.h>
 #include <asm/cpu-features.h>
 #include <asm/isa-rev.h>
+#include <asm/r10k-llsc.h>
 #include <asm/uasm.h>
 
 #include "bpf_jit_comp.h"
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 6681ccac9dd9..fd10c8b0ece8 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -17,6 +17,7 @@
 #include <linux/bpf.h>
 #include <asm/cpu-features.h>
 #include <asm/isa-rev.h>
+#include <asm/r10k-llsc.h>
 #include <asm/uasm.h>
 
 #include "bpf_jit_comp.h"
@@ -407,7 +408,7 @@ static void emit_atomic_r64(struct jit_context *ctx,
 		break;
 	}
 	emit(ctx, scd, t2, off, dst);
-	emit(ctx, LLSC_beqz, t2, -16 - LLSC_offset);
+	emit_llsc_beqz(ctx, t2, -16 - LLSC_offset);
 	emit(ctx, nop); /* Delay slot */
 
 	if (code & BPF_FETCH) {
@@ -428,7 +429,7 @@ static void emit_cmpxchg_r64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 	emit(ctx, bne, t1, r0, 12);
 	emit(ctx, move, t2, src);      /* Delay slot */
 	emit(ctx, scd, t2, off, dst);
-	emit(ctx, LLSC_beqz, t2, -20 - LLSC_offset);
+	emit_llsc_beqz(ctx, t2, -20 - LLSC_offset);
 	emit(ctx, move, r0, t1);       /* Delay slot */
 
 	clobber_reg(ctx, r0);
-- 
2.47.3

