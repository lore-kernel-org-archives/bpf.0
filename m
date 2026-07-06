Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC03BA244
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358964; cv=none; b=oKnxEWFAyZCd/liGDvVoJkhcuZObny9UpjLU69n6NSY0PCaJWTmSms8FBPtIIKp6zNIdqco80PfIpEYGUT3kuk5JW1CHHcu0pv9LfTLYd6yehKUK5TjILSoEhji8gaehYHsVr3o3wduoaM6OKAYjfQ4b8lejfzS9YutxuBaoPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358964; c=relaxed/simple;
	bh=XUGBNDhkxSdoWA8s3b6xvXl2QEAYsziYUpQlKSLMWlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BudqrVMe8htd++W50T2JGy4hgZN1ranaw/Kr63GIghkkPViBCDmB0dSMMZyEs9DYsyF7mBJj6OLQ7qvNVUfwtRUpaHWoNVSByHPC8Mw1hwtesUNspkdZYNGrVUUQVBOWd9ZLY3xlmqKRjlqWnejMsKoRkzapnehTtHsaWmDe2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/g978Gx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/g978Gx"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cace7da66eso30892025ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358962; x=1783963762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6EpkLMFszm/nPT49Xmg8gx0H7X2O/Rvk7vOoUDq2KHI=;
        b=L/g978GxwSoOPrPG9RJA2OjumU37Vj9Zt2tvT5GG6arcEtDNjst2gEmz8AO56UbeL8
         XlBL+M+tz+6KAdxD24EAExRdrPCX6FLQQvJNGL/aF7Y1WBsmpfMlCPnpHkwucVHC+FJH
         G3mvde9q3+4Z3QSjWhNmGRM5PFDLkXGYzsH1zbhgI9hfA/w7HAOYCyM/S65wS93NwlOn
         3MQSEg9yNCbCuVrUsU4sRyU3Fn/fSc9u8eEYWPI3U6gqIvvhvbAS/faO9sqHIA0PXQ/6
         sw/UlIPrvW3efjSkNyV6r+m1ilVfWMrgxUNocJmEdLezkxiE3hVoRO8RAaSz4eTWUywd
         XwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358962; x=1783963762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6EpkLMFszm/nPT49Xmg8gx0H7X2O/Rvk7vOoUDq2KHI=;
        b=tBaZ7cC5fO8YSqqry+O08KsHnrpsE+SR2NDkj3QKWjUi1xbud837/TXgNLK4s3AGsv
         ZxIabzddhXAUbQUVzL+Jjfth6t62JTp/tdWOJz3qAc4uPq8dQY+IGdixVh7arc+FXISG
         hVt9HkrsUILE+kuIxsV/SpSOQlS9nuoX4cWjM+afyL/WxNRSwQnjDTlOkLtqfckHQAWe
         f/761U9w3JnVd5rl868R/xDKvxCWvfuRCh/wxZ653jLeHo7YQPBDj2PaqFauLuQEzazC
         TUaEPXhcE8KmN2Tz5e0tyM0fppq2CpPk1B/POD+DApGMqqSyqx7s7Q9lCRh2yzHjUvON
         TdHA==
X-Forwarded-Encrypted: i=1; AHgh+Rqf9b+V0jKOqOZPYxShm/ctfcj9qUiQ5E6s3tfBnNAvQOHrGIDtVWjmfvVjckho9QHqPuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+hWT8riv5wto5COmqVO7dX7PkmGaT00JRC6iZPkar0KzngzB
	vF1T7NnfuGkPQ44vOdmIyvcCsVEiHARDqth2GX4ufvP5NgAQRPpwCfGy
X-Gm-Gg: AfdE7ckdzBfdis9ApTjrhz88aXkTk+ztK+q0vk0HdSu1tztw0tdD0SdK8UF0eCkzw3B
	n/eSAaUa6jebLoZerU4Plaqq0IiLTb9ebV1jNUVnE/hVCJDYtSoFaEUAsPjnmcwnMIGz2wm4sYo
	QUGEzZJLcWvM5puBtIxFeAYsFrCeDccb3DtwptDJuj0BnloO0a/yxrWApfiipDhbg96kSkUvOV2
	ccppoWTPhiv8JiRDcBTD8516bKa5d8cczpgIHwHX3yi8LL3fX1eqOkR+Mzl7E4OT0XcScMvaqyR
	CglHf0lsLa9JBqwDyvYT3D4NX6S+l4p6cXl9tMtUN7qWtQhvQIyYs5MsYcvH0vwD7YPzqdzyBRa
	pHvSSdNtgdSp6OC2hPL07mbrw5CC9KVRqY3HXmMlBKv8TXQHiU54z+NWqbaFFBqEhv+S5+k6aaS
	06RnZPjxXVDZY/B/YfaJ1sJIvvpF7JxpVkF4odG/bZ2+pQ5dITDQ6pKtkYwa2daR2XfnuXYPXnn
	6o0zIQq12Zh8EnDMOZR+Cw=
X-Received: by 2002:a17:902:cf0b:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2ccbe7297fbmr15392495ad.20.1783358962288;
        Mon, 06 Jul 2026 10:29:22 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e54sm54667005ad.2.2026.07.06.10.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:29:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/3] riscv, bpf: Add support for BPF_MOVSX in RV32 JIT
Date: Mon,  6 Jul 2026 17:28:45 +0000
Message-ID: <20260706172846.3876436-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706172846.3876436-1-visitorckw@gmail.com>
References: <20260706172846.3876436-1-visitorckw@gmail.com>
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
2.55.0.rc2.803.g1fd1e6609c-goog

