Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD03A7F66
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520670; cv=none; b=GXUt0tfHkLyjGKNQgBnGvuKUUcdFYnnSLgK3tQf9toKYi4bPkjcGmEwnGPf/h7uE8iFUOQyUOw/a5cQ/us9udpSCT65WcmfZ1JWpC+z+tvuM+WgXQzQPyQTdEDuCeDy4rmKRGjO01cJ94lBIlzLhpXZfGF9ZlWs0eCoWQbgI+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520670; c=relaxed/simple;
	bh=zTBizNpKtLSPwFZHxtHy4hNNKWWCzaj01cIzBDvTbX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UihFBfPIL5+4mX1Deq8UrJFSWG4uETbp3zrMUUavR1EMdmMzqU+li2Ms6+oaLzqdRn8wpUuCON4eEuZojvAXeHl/d7fRScf5Ua7nSStYu9wm5675K64C4j5KuhDg6MbhFK42lrmI5DC0cMqSkBw1wWtBKOCfQYEQ54slRVWxjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmlD2FUT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmlD2FUT"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52ff0b7c98aso10149721cf.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520667; x=1789125467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zfFWJk7PUW5CrjR05hNpDl61wr3Ggr/JyLicmdvD02M=;
        b=pmlD2FUT6C9OtuQeDRP82EDckNrrO7ndxIhp9tX8/4EyJhTj6UHvYzDZZri2KNMVIw
         gIstLQTB67yCTXsWrIS473nEU0D4zsytuZl6cIGvF1dQPIH19Ti6HnlWdWy50c/PFbAV
         n06OQXfITjQjeF6HQqQsAAIKqz6tC3143HQu4L5RcQWoiieKOsqecH49IvtWoTXPwJgt
         qxzcub3yrd/zX+VHq+R/pj7x1AHBThEPN6gE0+dDR3UsqUlhWPkUOUryUPWTTV7io1HO
         5A1zv+b27aGU766D/GsMzbAjRDcrcBayF60W0ZHIPhJxDP5rNpqWFx+XeqU3uhEi2IYr
         sV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520667; x=1789125467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zfFWJk7PUW5CrjR05hNpDl61wr3Ggr/JyLicmdvD02M=;
        b=bPGassXwTxGGuM4++uCpjYTZiCB7frJofwY86BHy/rmeFj0rJfhweWYYJofJMeAMN3
         dy9aOoBQv/iT3jK56y3zZRgd5+Z+67FtUPWIbB6dAVrn4iD++80fOISz0RvJIy0iVtoD
         yquzbJjCPs+vqayUUM5J/K+MyVJrM7PZ057MWKWnx1kgE7O+rvnq+r/RgqXC+9s0dTNl
         MHGmALwQSBZ3/Jd2FNcQAYSMYIgeLAlFDnhOvXb+gsLiZJITH3OLFMS2UylltS5KGU3a
         e2KVbziEQMI69BTd3ilfyemNvpQptBoGlR0LzgtVdg92X9ZKdQ7IulQgU7oGFMaHX+08
         psjg==
X-Forwarded-Encrypted: i=1; AKwUvBykb3BlxafWsoCU7MEUsne35hpsRznpPJCQP3oVIM+2Yhjif/9SXeyAQDGX1h6lnjG36tU=@vger.kernel.org
X-Gm-Message-State: AFuF++likX878WCENvWnOG8fELIQQYq2X9xOu3vOzfMzSdDwdlD70ftC
	SFdlSiFGbh2elnh9z7edBwLVRBlCu4nyCZH1reM5Jh5p94ZgYOPhEOrH
X-Gm-Gg: AYBFou28tIDrOPcPZkXV/LYJX9js2QY8jEygqeAUwqIIkzH1u+3EhSGhAPE0Z9aT/dQ
	gnN98hZUYRMzDDlvew/z+HDTuozrl/lOyK++Bcayc6x7slxEtQZ+I7bMhwb2eljO2Vl4ts/qBBo
	WHumX729LryQ75jlu0FGd8V5p8lVY5yYtV1BabCnv4OpYgx7ya9wb0Aj3XV3a0iG67czbT3wExS
	VMSLElKq+3ZYFeCZO6PDMBJlSIqJaIZ4EIthPyP8ONEWJLSb/+NiMQCsSWkl+Z49s5R0In50BaX
	828ng1GVOpn6o/oxxI75uiG4z8gxzPpj46pfm0Gk22+0lNyy7AACfJSLCNqGDMFj25lZ1TdZ0D2
	hpngcnbRUY93pVZMHtC0raREjESDB0wsCWofNDqhwagEUNftLB1GUPB1wgjKeBYf5H+Q25WxZ3J
	zBsf1HsdU2WQOt4w6eZ/1FtRPrL2uReXIP1OBOL/mMGlyisoFBZTUmfTcC
X-Received: by 2002:a05:622a:c88:b0:530:42f6:82a7 with SMTP id d75a77b69052e-53054a16543mr56198681cf.47.1788520667203;
        Fri, 04 Sep 2026 04:17:47 -0700 (PDT)
Received: from Turin ([187.15.144.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305402a8fcsm18350171cf.1.2026.09.04.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:17:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf, mips: Factor register moves into helpers
Date: Fri,  4 Sep 2026 07:17:30 -0400
Message-ID: <20260904111731.673341-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904111731.673341-1-main.kalliope@gmail.com>
References: <20260904111731.673341-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_MOVSX carries its source width in insn->off. Both MIPS JITs
currently lower register MOV instructions directly in build_insn().
Keeping the forthcoming MOVSX width switch there would split the move
operation between dispatcher cases and backend emitters.

Factor ALU32 and ALU64 register moves into helpers for each backend and
route the existing MOV paths through them. The helpers own the complete
move operation, including MIPS32 register-pair handling and the ALU32
upper-half state. This keeps the following MOVSX width decoding inside
one per-backend, per-width-class move emitter rather than in dispatcher
case arms or generic primitives.

Keep the verifier-inserted zero-extension marker on its dedicated path.
No functional change is intended.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp32.c | 22 ++++++++++++++++++----
 arch/mips/net/bpf_jit_comp64.c | 18 +++++++++++++++---
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 40a878b672f5..bfe73b023983 100644
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
@@ -1485,8 +1501,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_mov_i(ctx, hi(dst), 0);
 		} else {
-			emit_mov_r(ctx, lo(dst), lo(src));
-			emit_zext_ver(ctx, dst);
+			emit_mov_r32(ctx, dst, src);
 		}
 		break;
 	/* dst = -dst */
@@ -1555,8 +1570,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
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
index fa7e9aa37f49..45fee6f6b87e 100644
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
@@ -656,8 +669,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_zext(ctx, dst);
 		} else {
-			emit_mov_r(ctx, dst, src);
-			emit_zext_ver(ctx, dst);
+			emit_mov_r32(ctx, dst, src);
 		}
 		break;
 	/* dst = -dst */
@@ -742,7 +754,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
