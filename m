Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522213F1665
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466142; cv=none; b=ZbBsrx5IFVn7oM6kz01sbViJ7zcBjQoiF3PBV9fqRwmLJJl8QjCBKwocYJKlW0oM2F0LbVU6UjktqdURb7s3Ogk4FbE8X0MRNqucuy8KIsUuISksw7ZxcdPKZm3C6m9/D6EHB2nEfEAi72haLiLtzYOxCw1347oZwaOHfCq1R74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466142; c=relaxed/simple;
	bh=AjTYGwgBOQtOfYmN09UgbPmmji9Klyu9h3CWG62A8jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNIWX2X5CjtsTy4bje8j5/u+49Wu3zbXwcuLouHCeN6/GzicMloIyFBPLxODvNWgHKDs3u0WA9uZm+vP/MGefIz3W4RJYaUZfPNypcwdPmZp+mApvnwGwrVdbVymTW0K9uYHKLb9fPBU7Vpi95NGGqef3CjqH9tYZ4iiQukIBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Ijf5PN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Ijf5PN"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so429240a91.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466139; x=1778070939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ednz/cghQpogB1tCla7fjN5pIBUu1nziwhwuKFzLoEk=;
        b=L9Ijf5PNO8FX43PIIaHshmbKi0ZLbVaVyCAUc9bHm1OudFV1kME1G0Hlt7TsJyi3DI
         kbSN1Xb/SpbUX63fFv0EaZ5QZkTXbKA0DGnZvFT5FiN1OHCVWtWbtWPEyh1uZ0PR1DqH
         qKs4O/2tVXDU7ZQw8WUqL63A+DHrbvZtYsFUfuGJoReul5CtsvZ4jPQ1Fjf/Vs3xT/6w
         ZNeBn7q+5MEiwp29XiqrSOOoVwhtHmePxLtTXVFq6wkPOhscg9iIp4E1/oz+tJSynfWC
         B0YMLQQyZfMRVGpeEugB1pFBryq7jjxZNZauKz79+HyqYvMo+3Z0uUTJ/27FGaYuamV9
         bCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466139; x=1778070939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ednz/cghQpogB1tCla7fjN5pIBUu1nziwhwuKFzLoEk=;
        b=bGRUbndJIBaJkgVjKnxW33stvie3bTiBZAIcZyWoxNays6/Ebl+uIv5oxgN9NtqYoc
         7T56/s9GKxBb6Lq3ezTNG6lXmouGuxLUqBlUGSiU8UCBg/dnXmP4r4uqBB1mUgK2kfCW
         Hqyj+8ATMN5u42IpRA9ApgVK7GRlteIGBKyczrfmizL2Vo+AVgmP1SCPGhmDbxRmsut7
         8w3vFsJf2fd1o7LP+NH2yMO8wZ34BOrPauB9a0uKuaGYECWXUjoADNiHX2IlCpwX6RB/
         myXRy4kobu8Ft6zeC9lbTqJqS77r24xpf4pBW+preAfG4fjSZneMYX0VKOMV7dqRnLMa
         L5aw==
X-Forwarded-Encrypted: i=1; AFNElJ+aHfdkJw26a7mMo9quDRgeacxz44Ruc3JtdsGcL4ffWQNdjNDMLsB2fSzzMwHpq8ajpoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9FZl1yh8K0Gs7ZXC7BHXh8ZIcE31Wa6W5LzK55SAsVyCMDWmN
	XZD3RUqYV0rAVWY8zslO79z+/okgfsJLhqwypZu4TZ1sD9ShJz4IHl9V
X-Gm-Gg: AeBDies+pEB5/iANEsQMnQFhLii/TRLwtLQiF9ygv9Qvlrs2QGyn5VGh+h8WQplpxGE
	p9F6ATM5PQwl05xx0VJDh+Jh7ImVFIbbnm6VVazYvr4/DcqbkT0J8R10X1a5JOQUK+uIFyBtLfm
	v6xTh8PK1SdEInTWgip2Lbnqj69FHk/hVrb/EYWwAOwjDpzvJZTyS7fG0LYpdk176R9vugSnq6t
	o8C/qqvlag8ga/Jn4ZPmNqXLIFQKN0npgbqwS6xuyaHzops3e3rnt7Ce8kwdTKXgUlDv/X7f8dK
	1wzTb9qk87tIlLx/jU/n3g+F2CxfiM4faSdmpNMRtlCjOf3oCfWYLv6eLXBG/jgNqbcogIPLFkb
	LJmS5TghzuOM47/53/E7srBeiveHoVElSvuPkAtzp64Kv6v1LHG17T3ALVD5dTyJLrhDiXRdswE
	BAY2tMG23VOKxYOeYUEC8gs/wgN7smISaQElOON079DxnilnXqwB80aylIJNJCWEn7lEQ1h/Da5
	Fuwbl6nTBBIBF/mbCo1ASwvOVvt5uRyCSykCglo7rF7kf+X9QFZIIE=
X-Received: by 2002:a17:90b:394d:b0:35f:b1ae:d0ee with SMTP id 98e67ed59e1d1-364a1e69c83mr2946890a91.5.1777466139351;
        Wed, 29 Apr 2026 05:35:39 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a419c9a6sm2261855a91.7.2026.04.29.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:35:39 -0700 (PDT)
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
	aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next 2/3] riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT
Date: Wed, 29 Apr 2026 12:35:12 +0000
Message-ID: <20260429123513.3477780-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429123513.3477780-1-visitorckw@gmail.com>
References: <20260429123513.3477780-1-visitorckw@gmail.com>
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
---
 arch/riscv/net/bpf_jit_comp32.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 7396899ea276..f8509950fed4 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -974,6 +974,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
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
@@ -1024,6 +1042,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
2.54.0.545.g6539524ca2-goog

