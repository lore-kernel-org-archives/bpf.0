Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605059;
	b=zHoiyMkrgrwCTkgaa2mMyymtLWeLCYDIz3DuHXZf/eb/lsQfDNZu1/26fxCzkIE9UdwZ
	 wqguVRK5fbww3lQPSKx6V+eGtzAAEAKTo7z1p2LbcUPAgo/7TvK5Ev3Z15XB+nhuoz97z
	 +0nsrKTLyfP5c9sMtqfzCK/Tj28JbWWgVuUfc8Dc6Uhin4NU5CpEyLzRvRYDqLE5NK4Gl
	 DQmCFaC3IHtY6Qy56+tg+zp+geFBeRUX9U62vHMupP+uXaZ2bFjIHpY+Hni3T6cO/7GZD
	 6kRHf+6mxo7hoYWOge4WhX0W373O6zB9VulJ4lmhsR6ccal+Q7feE8Ssz3rdIJ4djBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=IdFSo6JzzG9qQGdtD5ihKLoQ40g+bsnor4ELUYyg40E=;
	b=aDgltTqt/DirbPPRmB6r5YxnBITisEH0a5T3jWflliNWPUPl4NTXddAZ3S7UeZw2hnJS
	 ITzESNumtGwi1dPffZKpJJuxtRnjhru1KlOV8ULD9xHkmI2SfbSXOay7+4Ajn+VLJ3cc4
	 8CinZXnVIWIoGf//sH71Ux5H4ifQWw9MSDi+HhhXx8p01Yxr7vpmqz0FBhLZT2zFyDv1F
	 QtQvqkvGcTvth2n2ffMQ+QHWH5r9llag8+s+4VsDmPilQekaQ6jYXdWLjOWyTdjKXgxbx
	 ghB1TNSwcY9F3QyIIfI2EgUbzFRXR9FJfXrHT4AEMeDgWvwopQgxqTYIln/9OFjsW+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RIO3iS2R;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B7606A89F
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 345B7606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RIO3iS2R
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b4b2e52baaso6977327b3.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 13:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605057; x=1795209857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdFSo6JzzG9qQGdtD5ihKLoQ40g+bsnor4ELUYyg40E=;
        b=RIO3iS2RV7Tpg6eCUSLoRhHJjC8HOazmZ5idRahgh/6DI5mndK/odzajLwB5rXS2PB
         fO5JCXtYGxzIdmG5nIvtJwb4sUEuN71rlTc9poJIFgr0r7/vstHZMF9uwSG2u4JYwZxT
         Qfq7sXk0V3t0DGySNP+FYF7c5tQzLp89rLSJlV4s8cbn9PdIMPfKC4brIz1z8u4CahCx
         OrRo+rnTFuxrGIdaA4+J69IEh7d/YdQAaQ6QFxqpZGrmcYhwGCGyod9Gyc+mKS7WOmac
         2e9B9JTwqYgR39wbJw0wzEZLEIKZxVt6oShjzGylmejTQrKlIrcwHxbH6Qfb6hN7FjMX
         njBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605057; x=1795209857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IdFSo6JzzG9qQGdtD5ihKLoQ40g+bsnor4ELUYyg40E=;
        b=iaROU/RzWzhzNDqkWHnh8ljnAdqosG1NY3saKVjJ6R9BRBQpPlzqxqNSFu3xZ0P+Kb
         UqVAdV+ybwg3CP3TmNx/gYihkeMlVULsAlK+IcrTjAvn1NJz9NN+T1+SoR5RrFtVlYWZ
         RbZ0/7tFzLvn3bTmjrjfSyOlm+Nr97rSllPJQgbKxfRo+tzVL9qgrIhUoGnDvZGO9sCZ
         DTdtRa9ufAu5krouPyaJs+fNqUCZGqn14LShELpkkgNq6gZJeKMgwepOqOQCbRNcUNT2
         WsLPPckqDbVX2FG/Xq/AVn8IRev1RzYzX0jbd1+uBSwmC7BcYYOMwhXPpDNnRcNAVnBl
         tN0w==
X-Forwarded-Encrypted: i=1; AL+hErGPHNaoyy2jzHMMmsP7tpWbZNP40mEX/JMR+AlSPrsA9dPW7kx1L8HJdHG7yaaVd9UHRdA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VTHpwJA58EQYg5H2DRh9BwjDB1jafWLiHlJfp/xFYvGCXkRfh
	O9Jew9l/OPFKbmlSsDHCC7qirD+U/zA0v4rznaZ9y11YKj1hUj3dKf+b
X-Gm-Gg: AYBFou1O0wo54Rx2Uh19qFk7KpKJ9Ud4c9EK+K5nIZtaJivHLI5l7m9M79ZdCKUFpzy
	UqZwF0AIYHS7q9g2r7OM0y/Ev3yobkqxv4XcAv07s5dm4OVUqKL0P9Xm0xH69TF3nAGCXqEIS8o
	WQ2DHV3R2Gz+z/jntsgC6FJk/rMG1iqurKFP21iMaUOfAuJCxphi0CEDvWPBLsuCCJwGdHaNkzm
	OOkIIYjjdt/bKuNVEPdpw0Of0MnlURSZcHUwlbQ6aIQ7rtjA/UL0+7GqSWnQ5TT2DyPgLljiV5n
	ubb3G3doOO6Hy1HkuXpyUFYkSvNhtGRNAlfrW3iLdBV+w67i50xIUKhQyJ82Ns4oukYSuUJSIim
	bydTBqcw7586hVBceXOx4dLasNQdv7Lb0gqufYV+y1qZbRSU/kXOXGERuhbGLoKGhbZ1kbnVRom
	zCmfxnY01NWjudR+ipVOHlQwUGhS7V1dRyGTKkpRx9zxRgzlcYMolOIcrk800yy5VxLWDv6uS6u
	odibrg0L/BqwTCf9Lvrf1Ckvh9mF3zBko6K3RJU7MEJjyMjoDgEfosxY2ae9zi58f14bL8rzQYg
	Vbt3I1KNEWilGDA73M5suFnk1B8ERSvBUQ==
X-Received: by 2002:a05:690c:f85:b0:8b3:2af9:11f9 with SMTP id 00721157ae682-8b4aa2dd1a7mr23701777b3.26.1794605057150;
        Fri, 13 Nov 2026 13:24:17 -0800 (PST)
Received: from [127.0.1.1] ([187.15.141.223])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aaa1361fsm29539357b3.43.2026.11.13.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:24:16 -0800 (PST)
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 13 Nov 2026 16:24:11 -0500
Subject: [PATCH bpf-next 2/2] bpf, parisc: Add support for BPF_MOVSX in the
 parisc32 JIT
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-parisc_bpf_jit_movsx_20261112-v1-2-7ecc33cdf1b2@gmail.com>
References: <20261113-parisc_bpf_jit_movsx_20261112-v1-0-7ecc33cdf1b2@gmail.com>
In-Reply-To: <20261113-parisc_bpf_jit_movsx_20261112-v1-0-7ecc33cdf1b2@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicholas Dudar <main.kalliope@gmail.com>
X-Mailer: b4 0.16.0

RFC9669 defines BPF_MOV | BPF_X with an offset of 8, 16 or 32 as a
sign-extending move, dst = (s8,s16,s32)src. The parisc32 JIT handles it
like an ordinary register move, so r0 = (s8)r0 with 0x80 gives 128
instead of -128.

Add emit_movsx_r(). It sign-extends the low 8 or 16 bits of the source
low word with extrw,s, or copies the low word for a 32-bit extension,
and fills the high word with the sign for ALU64. For ALU32,
bpf_put_reg32() zeroes the high word unless the verifier inserts the
zero extension.

Under QEMU on a 32-bit kernel, with test_progs built as a static 32-bit
binary with jit_insns only:

  # ./test_progs -t jit_insns -w 0
  [...]
  #201/33  jit_insns/movsx:OK
  [...]
  Summary: 0/40 PASSED, 0 SKIPPED, 2/12 FAILED

Without this change jit_insns/movsx fails as well. The 12 failures left
fail without this change too.

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/parisc/net/bpf_jit_comp32.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/net/bpf_jit_comp32.c b/arch/parisc/net/bpf_jit_comp32.c
index eea0a34a3bfe..9cfbff3e58bb 100644
--- a/arch/parisc/net/bpf_jit_comp32.c
+++ b/arch/parisc/net/bpf_jit_comp32.c
@@ -705,6 +705,35 @@ static void emit_alu_r32(const s8 *dst, const s8 *src,
 	bpf_put_reg32(dst, rd, ctx);
 }
 
+/* dst = sign_extend(src, width) */
+static void emit_movsx_r(const s8 *dst, const s8 *src,
+			 struct hppa_jit_context *ctx, u8 width, bool is64)
+{
+	const s8 *tmp1 = regmap[TMP_REG_1];
+	const s8 *tmp2 = regmap[TMP_REG_2];
+	const s8 *rs = bpf_get_reg32(src, tmp2, ctx);
+	const s8 *rd;
+
+	if (is64)
+		rd = bpf_get_reg64_ref(dst, tmp1, false, ctx);
+	else
+		rd = bpf_get_reg32_ref(dst, tmp1, ctx);
+
+	/* Low word: sign-extend the field, or copy it for a 32-bit extension */
+	if (width == 32)
+		emit_hppa_copy(lo(rs), lo(rd), ctx);
+	else
+		emit(hppa_extrws(lo(rs), 31, 32 - width, lo(rd)), ctx);
+
+	if (is64) {
+		/* High word: copies of the sign bit */
+		emit(hppa_extrws(lo(rd), 0, 31, hi(rd)), ctx);
+		bpf_put_reg64(dst, rd, ctx);
+	} else {
+		bpf_put_reg32(dst, rd, ctx);
+	}
+}
+
 static int emit_branch_r64(const s8 *src1, const s8 *src2, s32 paoff,
 			   struct hppa_jit_context *ctx, const u8 op)
 {
@@ -1145,7 +1174,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-
+		if (off == 8 || off == 16 || off == 32) {
+			/* Sign-extending mov: dst = (s8,s16,s32)src */
+			emit_movsx_r(dst, src, ctx, off, true);
+			break;
+		}
+		fallthrough;
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
 
@@ -1196,6 +1230,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 			emit_zext64(dst, ctx);
 			break;
 		}
+		if (off == 8 || off == 16) {
+			/* Sign-extending mov32: dst = (s8,s16)src */
+			emit_movsx_r(dst, src, ctx, off, false);
+			break;
+		}
 		fallthrough;
 	/* dst = dst OP src */
 	case BPF_ALU | BPF_ADD | BPF_X:

-- 
2.53.0

