Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A71DED40
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783988804; cv=none; b=FchHZDA1AzcGy/ECIBh5Hajw17H3i8r02At8RPHCGg+SqTPyV7SQwlm7LaPP3DrdaUTHjxxc+jkiFloWlK0VZbvWsAgsqdOE/qRrbn+Kq/Y7XCIPKD73e4mT+qapMI2sIzWIoen871lmIWQrQ4ekEyzXI2H+dNllIyRcag55bgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783988804; c=relaxed/simple;
	bh=r+kaBAfu+hKvqErDjZHt/uZYexn2mom/mH68FSlhKfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4RMqQ0N2/e+F9FPNu2syjFAGM8XVXRt7P8fpicNzj0Kf1xDLvXdaTTMGljum3tRcNi3zWIUNgAtIfjTB63546bR/ErKsjWwv5n1aTfmXk4gXi+FEozrtr4/8wbsQkDAZoUCveVbS/1HSPlxL0JkVPlaRYXVdA8Opl5JnIfIK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1rj5n9k; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1rj5n9k"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ce98cb8165so4515645ad.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783988803; x=1784593603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fcmn/mUzmVUL+DoQNyIpH9sLS8JVVLYSWdiiiJ0QKdQ=;
        b=p1rj5n9kTipY3utX52KDqvwrBl80/vdKDKGO/sHO2HdCp/d62n+ln7fUEUlpkN6R7X
         ZcBwIog2BlcDxky2YpoL6orfNanTyGGEIzjxohzk1Un46T3W4vyzZ3TdZpq1Tsde9TEt
         0sZ+v43Lsk38VS0p513p4vBjv7KqQSQXWpxIDjZ51h2DtMm6qta4TMVXahJFyWCb7ZRo
         7L9UyX3JbvlLS/5zfMvT53NGiKkrVF6LV60dC6TmI+d0diXg1xFKnjZcRK7Do9PAsc/d
         6ppHvLhLWHCGZyzpxt+tZUxBUd1vvIS9QCPuqp1uedrlGy6BelBf0Mm7ifJZF48ytwVo
         +bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783988803; x=1784593603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fcmn/mUzmVUL+DoQNyIpH9sLS8JVVLYSWdiiiJ0QKdQ=;
        b=EogYkhuIoTfcfMQEK+R3d9Lxrb+1tjCCxN+cvceB6FfvV2bpTbwzTnxfklcm8ljksU
         4PqwRC24aXpnCFd+plLxPAt+EqFpQLPcSbLBAj/A2mFntyspFuCYGuKhPkoIsnQtoau1
         BkHPN1M+hTR9Vr+v0MtUJbo6WVP1vuHnedRMhfuAefwQzzJBvGpVsyCxugl+yNuhNQ4w
         kt0JKToyu9s0RMWEyjBRYvwzFvDkS7p4yfDiw4D9JtSRg3fEWGCUtTpVyFF5hVw9oOgJ
         K6r6nVLtL+iQD7g1ZFdQI2VtWvH5ImgZu37rXlQLFwFzGZeB0GCYWekcVJSAbLo/Dw+9
         /YGg==
X-Forwarded-Encrypted: i=1; AHgh+RpEXsLPq+awV7iYta4FVKOCDlvnWTvv2hCRCywUvzuBZ8O/47r8bo/JR52rc2z/sIUIZiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJik3CVosTL+dlLvDQBwxM+bDOXcfo3Ylwn9E8qBubOhMrQZzb
	+HVbD/oadav65b6s+kpHZ6b48T2vA4yfnRIU6vZX6eGNO7ZoN3I062Ic
X-Gm-Gg: AfdE7cn9p3gAW5GiCw6VTUXZaqWB2yd060mSntk54JmMw2IR31zgaxFxZwwfrZJ3J8E
	3QdTVDJYoA+ckcyGjxNsfJ1hqRptwVTeUWwMBY/DC3QRtZdXhSdbQxl9fmvBm0CZJTdstG7HrcZ
	YF5jeEbLiajsU1i9FkUYK2BALGnKC7u5H2Q4j/uy62TTVwg5xSrBpMS/oSRjRTUxQLaEn2DArxw
	ychuvVSmrS8o0I0OpVzsFdWMyFDZGGQ+b+6k76tDmKydOFHAkYfhkV6N0aHmSaopblfRVTbMgYT
	iRyZ/BK9WZJgARWk8iY/758aQrQVjp7s3CXbbKiP+qT2joxeiwNQCvQOSYJ72rJ2FrDzheFwMRV
	OB1gCOaGYknTEOXyleDeonDhZe/7xMpK2LxZVfxmxCuLeVD48tQ8fs57UYOwG+CDvIcSENALvyg
	zGDn0cYZXcz6zG0O2AW8yngvefd7jeZAXhM7xNYmT0O158k5fIWqbOZ6XKN4YzyKI8MzT67lQ/t
	DimgTBhUWTWW04=
X-Received: by 2002:a17:903:2406:b0:2c7:c385:c5a7 with SMTP id d9443c01a7336-2ce8297869amr137544225ad.26.1783988802746;
        Mon, 13 Jul 2026 17:26:42 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (131.197.81.34.bc.googleusercontent.com. [34.81.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm105796545ad.53.2026.07.13.17.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:26:42 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	pulehui@huawei.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next v4 2/3] riscv, bpf: Add support for BPF_MOVSX in RV32 JIT
Date: Tue, 14 Jul 2026 00:24:50 +0000
Message-ID: <20260714002451.4091139-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260714002451.4091139-1-visitorckw@gmail.com>
References: <20260714002451.4091139-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current rv32 bpf jit compiler incorrectly treats BPF_MOVSX as a
standard zero-extended move operation. The bpf instruction set allows
sign-extension moves by reusing the BPF_MOV opcode with the instruction
offset set to 8, 16, or 32.

Update the bpf_jit_emit_insn() function to check the offset field for
both ALU and ALU64 MOV operations. If the offset is non-zero, emit the
correct slli and srai instructions to perform the sign extension.

Before this patch:
[   19.549705] test_bpf: #82 ALU_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
[   19.551354] test_bpf: #83 ALU_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
[   19.552576] test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
[   19.553542] test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
[   19.554807] test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)

After this patch:
[   17.931172] test_bpf: #82 ALU_MOVSX | BPF_B jited:1 125 PASS
[   17.932198] test_bpf: #83 ALU_MOVSX | BPF_H jited:1 124 PASS
[   17.933039] test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 124 PASS
[   17.933918] test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 124 PASS
[   17.934751] test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 122 PASS

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp32.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 89153946a4e4..39e2b0b907dc 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -972,6 +972,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 	switch (code) {
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (insn->off != 0) {
+			const s8 *rd = bpf_get_reg64(dst, tmp1, ctx);
+			const s8 *rs = bpf_get_reg64(src, tmp2, ctx);
+
+			if (insn->off == 8) {
+				emit(rv_slli(lo(rd), lo(rs), 24), ctx);
+				emit(rv_srai(lo(rd), lo(rd), 24), ctx);
+			} else if (insn->off == 16) {
+				emit(rv_slli(lo(rd), lo(rs), 16), ctx);
+				emit(rv_srai(lo(rd), lo(rd), 16), ctx);
+			} else {
+				emit(rv_addi(lo(rd), lo(rs), 0), ctx);
+			}
+			emit(rv_srai(hi(rd), lo(rd), 31), ctx);
+			bpf_put_reg64(dst, rd, ctx);
+			break;
+		}
+		fallthrough;
 
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
@@ -1022,6 +1040,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_zext64(dst, ctx);
 			break;
 		}
+		if (insn->off != 0) {
+			const s8 *rd = bpf_get_reg32(dst, tmp1, ctx);
+			const s8 *rs = bpf_get_reg32(src, tmp2, ctx);
+
+			if (insn->off == 8) {
+				emit(rv_slli(lo(rd), lo(rs), 24), ctx);
+				emit(rv_srai(lo(rd), lo(rd), 24), ctx);
+			} else if (insn->off == 16) {
+				emit(rv_slli(lo(rd), lo(rs), 16), ctx);
+				emit(rv_srai(lo(rd), lo(rd), 16), ctx);
+			}
+			bpf_put_reg32(dst, rd, ctx);
+			break;
+		}
 		fallthrough;
 
 	case BPF_ALU | BPF_ADD | BPF_X:
-- 
2.55.0.795.g602f6c329a-goog

