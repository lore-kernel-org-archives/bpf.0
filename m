Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D935379ED2
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789186351; cv=none; b=jZgDq3I6IitOAv2R53lX7BpUugbeQ5a8ioUFcvearbLVsjCTdVVN6ibfGRC4OiCcdWgou+1yZ8GjqOs50xddbms0k2rJ6phSM3Q/i3VD1vQ0FPwJD1z+455UVDVAyg+jROJ+aTUAGPXRcQOgxBWT/Xot/EGdWKsFqavgcRdIDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789186351; c=relaxed/simple;
	bh=FTjXA3TBiauYcavGMjOWcd8aZNsdDcfGUuaYmTOojcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVrVq0RyNaYMNhfNUO2tzWhKKw8Pfey3bxz3tZ7Fx8mBK2iR9Y7TYPThvwYEtLh4C6A5tGj41hpRgu6MuA7aTm91JJ1A31UIHRBYo2lMW9U/akCN683RiSWxVNV2P2PLkG7JgsUTLe7pxAl+8E+ExCG9XTohuziG3G+AuPajZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTN24/r1; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTN24/r1"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa8so57444385a.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 21:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789186348; x=1789791148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQqTNSIAsap/auW6qIkBQ2H9Ak1kO35tQi3igQ6YFqY=;
        b=YTN24/r1xkZQZ87xVkBC3gyifgxOCGm9Kfs7coxu7v63H1Kn8mj8Egp63vzoY3NMwP
         mSzXZK9uAiTmehOw3lCEEkG7wEYtwQevZSktD+so+wgGy9kN1stIujfJnGvJK0Ksq51L
         WhHLKtFO4MbcviW8qEqBeBKLESSyCtE1BrhTEcaHYZCQ5bsJPwa6QoITUfLF89THuHTz
         A2Xq/9zDp8x4e8q47BeL+/0kjQTiNQsuc379/R6qm8jR911FB9LYiPzgl4VfJSwC/khv
         CbtP/Ls2oVMDB0xrw5FwIBr9mI29COhunymTRDLe4nYHxCmmZI9LbznVtvM3e5tuplnF
         5UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789186348; x=1789791148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gQqTNSIAsap/auW6qIkBQ2H9Ak1kO35tQi3igQ6YFqY=;
        b=nXFI2A+eFkZGq+kcXx0dxFFg/lKGvHPfXLoL8NSf/yejF+EQXKr21mCYO/WNXbKwkQ
         /5qeOv55TOhJsJUzU8IlVO2ZUNY1BREGMTUbvgTglBJov4OGDpyr0zSz7UIV8AKVkNhh
         cXDi91gfnEuReENr2OG7a/+0Cw7avymRDCmguOoMdrdWy6359zJ3ml7YK31c12Gvc6vd
         hqKV24Mi5Vj1ZYFyy7IaZO3zLnmGva3/lgLz2CEgKJn/ol3zuUMRy2q7pr5vInVSU3hJ
         E8HT8XfX8hujLw0GQPdp/i24YdlTFOGvYB4ekXHQLlwQw0L7C7nsyTM+jYErq1eiGTBg
         QHPA==
X-Forwarded-Encrypted: i=1; AKwUvBwheQKis3bkilitK1fJ5m0tNx5wFm1vSVErQsFa8lXnB/0t+064/gbdDk8gKe3f8vvIvYw=@vger.kernel.org
X-Gm-Message-State: AFuF++mNjH5bnuC4hhxquhwa0ju+IljmCA9so96PAn6oEC+7Ae2pR636
	Tef40TWaVfI4T5WYLQFF4xTQoeZTuRPhhGkn2SFmgSFk7NDlKAhoB32L
X-Gm-Gg: AYBFou2J+p7c1LvXLJC3VS1X2HrmMpBKylMFlwsljMyrRsrCzN69VbFqPd4jCVMXCGZ
	V6joHsza38bxmYUSjCdph2OP3ZPsrot962s3i6NyOuP5VlEJlx8xJI3RWuRuc9U3Bjt1Gb7341+
	VoFh/tVUW9sq6ccur2xQ9NDHUkU6szBSIG5A2F4UVOUILOhPV9Six11zZQpnXUntCtlXhrjsmXj
	DGcx1Ohas1SNfK3oC/wH7ikuWpeEA7UDIZ6SwwRFeniGQe3MrzS1nNHxT/sAUJPig6ZudsmwcTk
	xZlgMBbC9O3e6XW0R7gklTSc+LOnjP+DAS6N2be/Ar2DlxjrMT/3dglNNmW6MYbj6vsnvcytnq4
	vZdJZrorHmKcSqY6S2PSj+3zjwB5ltPWxrKg6iReAFVyo9vUgG1h1Oul63N49fPv1NwW943tEkU
	eerMc5obJ8gFkzvAl9PiXfpAfUP8qwQJQlD31bN21Jjul+OfFbUCCXAAKLGhgCd2LG
X-Received: by 2002:a05:620a:4688:b0:939:1459:efb2 with SMTP id af79cd13be357-939ea21278fmr1067694685a.24.1789186348330;
        Fri, 11 Sep 2026 21:12:28 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a09b85dadsm18463485a.34.2026.09.11.21.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 21:12:27 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf, mips: Factor register moves into helpers
Date: Sat, 12 Sep 2026 00:12:19 -0400
Message-ID: <20260912041220.444715-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912041220.444715-1-main.kalliope@gmail.com>
References: <20260912041220.444715-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor ALU32 and ALU64 register moves into backend-local helpers,
keeping register-pair handling and zero extension with the move.
This prepares for decoding the MOVSX width in those helpers.

Keep the verifier-inserted zero-extension marker on its existing path.
No functional change intended.

Assisted-by: Codex:gpt-6
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp32.c | 22 ++++++++++++++++++----
 arch/mips/net/bpf_jit_comp64.c | 18 +++++++++++++++---
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 6619182b5ef..6d603d9eeb1 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -190,6 +190,22 @@ static void emit_zext_ver(struct jit_context *ctx, const u8 dst[])
 	}
 }
 
+/* Register move operation (32-bit) */
+static void emit_mov_r32(struct jit_context *ctx, const u8 dst[],
+			 const u8 src[])
+{
+	emit_mov_r(ctx, lo(dst), lo(src));
+	emit_zext_ver(ctx, dst);
+}
+
+/* Register move operation (64-bit) */
+static void emit_mov_r64(struct jit_context *ctx, const u8 dst[],
+			 const u8 src[])
+{
+	emit_mov_r(ctx, lo(dst), lo(src));
+	emit_mov_r(ctx, hi(dst), hi(src));
+}
+
 /* Load delay slot, if ISA mandates it */
 static void emit_load_delay(struct jit_context *ctx)
 {
@@ -1494,8 +1510,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_mov_i(ctx, hi(dst), 0);
 		} else {
-			emit_mov_r(ctx, lo(dst), lo(src));
-			emit_zext_ver(ctx, dst);
+			emit_mov_r32(ctx, dst, src);
 		}
 		break;
 	/* dst = -dst */
@@ -1564,8 +1579,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r(ctx, lo(dst), lo(src));
-		emit_mov_r(ctx, hi(dst), hi(src));
+		emit_mov_r64(ctx, dst, src);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index db027c2d922..92df2eba139 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -120,6 +120,19 @@ static void emit_zext_ver(struct jit_context *ctx, u8 dst)
 		emit_zext(ctx, dst);
 }
 
+/* Register move operation (32-bit) */
+static void emit_mov_r32(struct jit_context *ctx, u8 dst, u8 src)
+{
+	emit_mov_r(ctx, dst, src);
+	emit_zext_ver(ctx, dst);
+}
+
+/* Register move operation (64-bit) */
+static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src)
+{
+	emit_mov_r(ctx, dst, src);
+}
+
 /* dst = imm (64-bit) */
 static void emit_mov_i64(struct jit_context *ctx, u8 dst, u64 imm64)
 {
@@ -681,8 +694,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_zext(ctx, dst);
 		} else {
-			emit_mov_r(ctx, dst, src);
-			emit_zext_ver(ctx, dst);
+			emit_mov_r32(ctx, dst, src);
 		}
 		break;
 	/* dst = -dst */
@@ -767,7 +779,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
