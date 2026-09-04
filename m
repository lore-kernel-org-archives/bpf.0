Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512DE471264
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520675; cv=none; b=tq0EHlit2Ziywn0qzW2Ai8jdS6rI/IOWycsZ015E3BtDzXEspnxBRRDfU2zvaIs3jqy56pkSmWsxUOAMNvQxpQx+xbaZAYAkFUXn1nSgh/crjBY55I4lBoxmFfkO0U9Eeceh4e6YATiAKUV0gFuGIZSygMGCGlBhDDbKQEmnJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520675; c=relaxed/simple;
	bh=4DIUolQj5K7s0LXB5mQXEoJFCJfRS2EJ6t4V8xTTHv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm3BNrLoCSe4fPiTiLrHv7qnEk8h+numudR6lk5sgzJBxeMK8IGZYbgPd2qCxTEsLyhy8XzmVOUrutPTzlIjfMnFh2CF/WV5wgy5mbCbzWdqlaxWrL2V18mEPFv+iqXqYAlnnSUNUMWWf5juzn/cYgM5QSl/pf5OJD8xoU/poA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTXY7njk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTXY7njk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517dc520840so12302651cf.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520671; x=1789125471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a8aI67v2qHq2F9XuFlZJpkBUyR2T964WRJn0GOGoYgs=;
        b=MTXY7njk0OvkwDvPY2MVXvq/rHzM5p9XFSgqGtmkie0CGgIwXYzH1LgBEHoe1qXniS
         n8THd91ssV5KYCiDlSdMVLaXFcnzhFyu5zU61JL82uB+Lyv3lkEancp2/Nq1xWYcE5q+
         HQG8P2NC5a7FhbFluIVDhLh3oSsK4B+oZwdV2fJHp/8rXZNG9fQj025ypYPATZryiMnP
         iVHf9al8Fptpkp2rGvDNMGA4D5cq8E9yiDGu9XbbffxNXFUHo30KVQwAO4b9EW4oFpzx
         srcB9GXYy2vjgFnGsoIebL7T9UH0MwYClOR478zY/bqft2UJypiNZPFWT94PnxkJhtbh
         WIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520671; x=1789125471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a8aI67v2qHq2F9XuFlZJpkBUyR2T964WRJn0GOGoYgs=;
        b=pF0qShmLwdm7fgaBl5bqg+UH3XsmgBsxrzZrP2ho3OsOSiLJIyJABKUrxfSiHQpDyR
         5ylOzdlCnpBI5w4c/+VcNndZn+E82ctBxW+MDOtMzo/IBytgPCC35A7xuOKY9uDEAFP2
         /sFEj7bPK50JyKVnMmgrmaF/rv2b2X6Pt38A95O+y3aGLuQUQvArbrCKWyTRnrjmyDHM
         XmWUCESXSGf4Wyg3KHX7G5PX2ykk1BnaRJJnYAHy5xlpnuZaok+DuvBX6WsCGxoCp+7h
         wCe02eoNDz8RQ+oBtsY3QQhN2l8f0mRk1r6QyZrP7CzNLgj07v64Nby/oI49Hlyhd8eP
         M3CQ==
X-Forwarded-Encrypted: i=1; AKwUvBwr21QAExMKD13O9o6mVH4PZlpxUyCMcb302AE/kYiY9W/scaSkDEv+SzA9nQDxNxUseLo=@vger.kernel.org
X-Gm-Message-State: AFuF++mdyTozUNw5pgiHAQaZ9Y2CgERFOWgIUP59Yovc8SpwGtTJcBRR
	WdlKgKk9xzopiqE3O3A898sHjuKdAARM/vuW2EUuz45ViGjdCa33jWzZ
X-Gm-Gg: AYBFou2hpQKz45xMnb52QU4GxYrocxuGMwNn/7VdALx2fVJ7ahn0LP9sgEeK8eSroRM
	GHXhD8yatargdAfq4woz4AdA1d/a/gMWpDdM6wjnWRwxl5EqwVttrEgHc2aJy7cnAan3sugnR+b
	b0LFi2EJDLf3XycngksqaaUt5GO3l8NOutfYovoQ/+NCdRLeNxj0hNcY2Uag8F9MpkE0sJ0fK7L
	4uerQr8qcVmLzfUUiHqL1IA0OEeE30eFvYGGMzgaIimt67ZT5Ib2phM+E+NYrK29vrSPyMPpXbT
	z8VseajbCYw/U7dS5DvUYMKCt2m6TL5/1VSFHcHp6t+NQJdeaeNGqzEGKJIHLItfwqRbvgYMUZu
	QgYkhFvHzscRUd4cTP3/3z2meg+uGubVCbnWLWKW2Oykpb7YuGcVdAXgjO3hOUTqA/puPOYcYvA
	DX9P3s9LKyDeY6P8hMewZFBtfBXnf+7XR7j7RG5UlPDixsqcDIWxcfBg/nE2DWi/lDc3A=
X-Received: by 2002:ac8:6108:0:b0:530:42e4:f003 with SMTP id d75a77b69052e-530549bb544mr68480221cf.48.1788520671204;
        Fri, 04 Sep 2026 04:17:51 -0700 (PDT)
Received: from Turin ([187.15.144.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305402a8fcsm18350171cf.1.2026.09.04.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:17:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] bpf, mips: Add support for BPF_MOVSX in the JITs
Date: Fri,  4 Sep 2026 07:17:31 -0400
Message-ID: <20260904111731.673341-3-main.kalliope@gmail.com>
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

Both MIPS JITs ignore insn->off when lowering register MOV
instructions, so BPF_MOVSX is emitted as an ordinary move. Since
build_insn() accepts it, affected programs are silently miscompiled
instead of falling back to the interpreter.

Decode insn->off in the register-move helpers and sign-extend 8- and
16-bit ALU32 operands and 8-, 16-, and 32-bit ALU64 operands. On
MIPS32, propagate the sign into the high word for ALU64 while
preserving the existing ALU32 zero-extension handling.

Use shift pairs rather than seb/seh so the lowering works on every CPU
supported by these JITs. seb/seh would save one instruction on
R2-or-newer CPUs but would require adding those opcodes to uasm.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp32.c | 56 ++++++++++++++++++++++++++++------
 arch/mips/net/bpf_jit_comp64.c | 54 +++++++++++++++++++++++++++-----
 2 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index bfe73b023983..885da0d0d74b 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -190,20 +190,58 @@ static void emit_zext_ver(struct jit_context *ctx, const u8 dst[])
 	}
 }
 
-/* Register move operation (32-bit) */
+/* Register move operation (32-bit), optionally with sign extension */
 static void emit_mov_r32(struct jit_context *ctx, const u8 dst[],
-			 const u8 src[])
+			 const u8 src[], s16 off)
 {
-	emit_mov_r(ctx, lo(dst), lo(src));
+	int shift;
+
+	switch (off) {
+	case 8:
+	case 16:
+		shift = 32 - off;
+		emit(ctx, sll, lo(dst), lo(src), shift);
+		emit(ctx, sra, lo(dst), lo(dst), shift);
+		break;
+	default:
+		/* off == 0 is MOV; the verifier rejects other offsets. */
+		emit_mov_r(ctx, lo(dst), lo(src));
+		break;
+	}
+	clobber_reg(ctx, lo(dst));
 	emit_zext_ver(ctx, dst);
 }
 
-/* Register move operation (64-bit) */
+/* Register move operation (64-bit), optionally with sign extension */
 static void emit_mov_r64(struct jit_context *ctx, const u8 dst[],
-			 const u8 src[])
+			 const u8 src[], s16 off)
 {
-	emit_mov_r(ctx, lo(dst), lo(src));
-	emit_mov_r(ctx, hi(dst), hi(src));
+	int shift;
+
+	switch (off) {
+	case 8:
+	case 16:
+		shift = 32 - off;
+		emit(ctx, sll, lo(dst), lo(src), shift);
+		emit(ctx, sra, lo(dst), lo(dst), shift);
+		emit(ctx, sra, hi(dst), lo(dst), 31);
+		break;
+	case 32:
+		emit(ctx, move, lo(dst), lo(src));
+		emit(ctx, sra, hi(dst), lo(dst), 31);
+		break;
+	default:
+		/*
+		 * off == 0 is ordinary MOV. The verifier rejects other
+		 * offsets; defined exceptions require
+		 * bpf_jit_supports_percpu_insn() or bpf_jit_supports_arena(),
+		 * neither implemented by MIPS.
+		 */
+		emit_mov_r(ctx, lo(dst), lo(src));
+		emit_mov_r(ctx, hi(dst), hi(src));
+		break;
+	}
+	clobber_reg64(ctx, dst);
 }
 
 /* Load delay slot, if ISA mandates it */
@@ -1501,7 +1539,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_mov_i(ctx, hi(dst), 0);
 		} else {
-			emit_mov_r32(ctx, dst, src);
+			emit_mov_r32(ctx, dst, src, off);
 		}
 		break;
 	/* dst = -dst */
@@ -1570,7 +1608,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r64(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src, off);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 45fee6f6b87e..a1dfb7492a9c 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -120,17 +120,55 @@ static void emit_zext_ver(struct jit_context *ctx, u8 dst)
 		emit_zext(ctx, dst);
 }
 
-/* Register move operation (32-bit) */
-static void emit_mov_r32(struct jit_context *ctx, u8 dst, u8 src)
+/* Register move operation (32-bit), optionally with sign extension */
+static void emit_mov_r32(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
-	emit_mov_r(ctx, dst, src);
+	int shift;
+
+	switch (off) {
+	case 8:
+	case 16:
+		shift = 32 - off;
+		/* dsll32 and dsra32 add 32 to the shift argument. */
+		emit(ctx, dsll32, dst, src, shift);
+		emit(ctx, dsra32, dst, dst, shift);
+		break;
+	default:
+		/* off == 0 is MOV; the verifier rejects other offsets. */
+		emit_mov_r(ctx, dst, src);
+		break;
+	}
+	clobber_reg(ctx, dst);
 	emit_zext_ver(ctx, dst);
 }
 
-/* Register move operation (64-bit) */
-static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src)
+/* Register move operation (64-bit), optionally with sign extension */
+static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
-	emit_mov_r(ctx, dst, src);
+	int shift;
+
+	switch (off) {
+	case 8:
+	case 16:
+		shift = 32 - off;
+		/* dsll32 and dsra32 add 32 to the shift argument. */
+		emit(ctx, dsll32, dst, src, shift);
+		emit(ctx, dsra32, dst, dst, shift);
+		break;
+	case 32:
+		emit_sext(ctx, dst, src);
+		break;
+	default:
+		/*
+		 * off == 0 is ordinary MOV. The verifier rejects other
+		 * offsets; defined exceptions require
+		 * bpf_jit_supports_percpu_insn() or bpf_jit_supports_arena(),
+		 * neither implemented by MIPS.
+		 */
+		emit_mov_r(ctx, dst, src);
+		break;
+	}
+	clobber_reg(ctx, dst);
 }
 
 /* dst = imm (64-bit) */
@@ -669,7 +707,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_zext(ctx, dst);
 		} else {
-			emit_mov_r32(ctx, dst, src);
+			emit_mov_r32(ctx, dst, src, off);
 		}
 		break;
 	/* dst = -dst */
@@ -754,7 +792,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r64(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src, off);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
