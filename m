Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670706;
	b=geB1/i6bI5tSJnb1aljRSJ3y0R0W8e/p5bRah1i1ttYZJc2Y2WBnxploUI1ppcv3fxPN
	 gzmvX0e2w1fMUH4yC3oIwLnSm1cmh6ypD3Ac7PS/STqtLiVxg1JEVI+bKdsZDnn3ScOAn
	 0pfMFxYxiLlJ+L2uaIFUlEY0WCYk/4mV0Pwblm/5ZJ0bTRxURRb2YYbINt8P4/cGYCCd3
	 Pa4BOfHTApXibaPF3xChFItn9ygpvmhqzgx33NVH/etIgKbDcuSlG/CkPcPrc8UbvzICJ
	 gOa4baqy2x7btre2IDOj619pvDOyO4NPylsH20cBYQuscxzRmCZnOSIFClGKfw7P/Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=miA0f75ACzWtEEMhhTsHwxUCwoc9Fd2Yha7gnSXIZtM=;
	b=rhX1z1Yt/j8Na5NwvWbT31G6Oi1x0XXn75qTVkaa/FufZ9dRiPkavPCdeM1J6myz/LIX
	 XkscNNdydEsGzN6076+COPTVvGEifZHNffUCmJucOIQznA2eXWn3Mi0n70LQYC4RKOqJp
	 HI9MmxV5i8ItxvRJv0HXZJR0ZZY3ykiYbk3QURBBMk0ONo2OY++9fSlrkUC5MVJXPmZIs
	 unLTfQexvRPThlxzSTGpSWcPttvyTmEHAYL7ji8B5jLBDXWbJh+7x3AhyTEJKlkV3wiYa
	 BBd4jDLKmI/Kr/BW5uLCUfkCePln+ETojRzSWlhD80uJEiV3iFd8T52G8TsaexBwhMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VCzV1HAx;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7B606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 12:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A7B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VCzV1HAx
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6768403e9bbso1801450d50.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670705; x=1793275505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miA0f75ACzWtEEMhhTsHwxUCwoc9Fd2Yha7gnSXIZtM=;
        b=VCzV1HAxP6nmRHwdDR3io0owtAhxu5ew3lmgfRDuN+VfYvAOMrEdHxowbzomQG4sPb
         yqhZJBcVTLbw5MMmUoRWX/9EOEyS6JsG02GJvyef5RmlNsC3X47RLhW/6THGdJBYzmXo
         BUIxd16Ndgz/JaUBcLjNM9WccVVlPoisXfPbfMTvzhfjJyhagGCg6EqTxHI4UcrF6oKR
         zcdnW33tDrdXCyxq6Rq8N4fcJbPZ0Xpqr+OWfJkxKXM5wz2I+yQPC8E1v/fOziULgNyf
         +GBpJyeuKu9IsLOpmK8+Wp/4FRkMsFDixjGrPWVnG1rsJJCZxMcNwFhJu8mcmyk+pXAb
         9BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670705; x=1793275505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miA0f75ACzWtEEMhhTsHwxUCwoc9Fd2Yha7gnSXIZtM=;
        b=Dno6JPMU8UseaOWO8Im502RRtCGuu3l+tJEHftDQjNmiuZlsSV1uz46Lm0eNo3OpPH
         T10nO8L1e/EcsZxvwiMvowgxYSgs4EZjIAmUIvozoht+waQsdtEanAWw4bAg5NyLh5pU
         hUYAQfOfPpUGrd6Qi8Rk0XxtrtKunXrMdoAKQMFKCEALlzTr2uO/Ekvg1zMnzpABWLj0
         rHhognnO+PJqjhjEuX7NrKEXs4WXV/mkgoG9lEWnFOFPhbDTPuFYCwBGx0ApBRRfQIGi
         GVMolVe2QXLmhWd14V8EVOzg8XYE7B5MBK+kGF68BsFON8b657H6OCC7iymDYOBsucdq
         12Rw==
X-Gm-Message-State: AFq9FYICRAOjOyDM3bapQ1LkULta0Z/oksLfTY5DfmILPu1BZvqQC7S1
	aTi//aPrkUqwGF6JvAX9qL97yDxXagmxhZdwzKc5HOeP3fZOVkAKoget
X-Gm-Gg: AYBFou0ngw3Lpbsg3eUf/MeiUA/KMFxZccTfaBCL68ioSyEwRtNE2wnzvkng3wuWBbj
	KmlGIAW0wv2cDKhRl4JSSCuBm0bks2dwB80MZ2/2U6QgEuq+vFyTb5RThR9vRIJHHRdWUPCjLqQ
	6i7kfUG/iLQk8lNdqh2ekAkk2mQiSiB1yll6SQkZiSR2ghcDp/2dIYETFWxeMrStE5hLAth4tRO
	KJBoUfy5KtOpJ2p5YLTTx68xPc+04/YvdG443sUc1ELqa4dqk4NAMQVtCYVtcbC4Xush6xvHhbh
	cvoTRm8XZlAZsRuK0lAbY9PHA7RJ1FVNIsqOvKtNqqhoddzInQ62h3JInUYu/5UT3bn/L8lLScM
	Hsb47SGd+FOvn+fhd0AnqQoxu+4GSEq98qRwYkXzvYKcWaaiEw9k7tw02W7IHCfuRo+oPDmeRAx
	i3JUBD2mFpQzXxcjutmFaKErqyGCXvgKd9gJkVp/NCCHDkJ1gURwmXrQZKwOTT7Ji4yWDkHW35R
	5Kj5dXeqRaiELyJIeUNoDk5X48XF3F35fs4TTIFlTn8aOBafCi4XYntSbf6YPSnnSzb
X-Received: by 2002:a05:690e:151a:b0:677:d034:8987 with SMTP id 956f58d0204a3-67a0e4ad76fmr2808319d50.50.1792670705042;
        Thu, 22 Oct 2026 05:05:05 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1301c5f50sm24739247b3.31.2026.10.22.05.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:05:04 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Oct 2026 05:04:56 -0700
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test JIT jumps which change
 at a repeated image length
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
Message-Id: <20261022-jit_size_fix-v2-2-4bee6921b218@meta.com>
References: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
In-Reply-To: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792670698; l=3232;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=10lCMRHO7pgkRbBWvoXV7NypAOAu4EP3nw7Vb1HNa6A=;
 b=tQmyU7xxO/VHRvIfVz5HLVqNr49ZZ/7xL+uEGmLvr9osmNpsk7ijOuQr9fT8qDzpVwR7caxV3
 1Vyh7x5kSD3ALe1IRHDCz5hq3qkPHmDKJQslu3GTXpJegW3xTul9fhZ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Cover the case where two JIT passes give the same image length while
jumps still change size, which used to fail with -ENOTSUPP on x86-64.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/jit_insns.c | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index dabefdb8a353..52bffe27199b 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -2881,6 +2881,63 @@ static void test_convergence(void)
 	}
 }
 
+/*
+ * On x86-64 a backward jump sized from its own previous-pass address grew
+ * here while others shrank, so two passes gave the same image length with
+ * jumps still changing. The fillers are 7 and 2 bytes of native code, the
+ * conditional jumps are never taken.
+ */
+static void test_same_len_not_converged(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, IN0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, IN1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 29),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 20),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, -3),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 22),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 2),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 23),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_JMP_IMM(BPF_JA, 0, 0, -22),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 3),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 2),
+		BPF_JMP_IMM(BPF_JA, 0, 0, -22),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 10),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, RES),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int fd;
+
+	fd = load_prog(insns, ARRAY_SIZE(insns), "same len not converged");
+	if (fd < 0)
+		return;
+	ASSERT_GT(jited_len(fd), 0, "same len not converged jited");
+	prog_run(fd, 1, 2, 11, "same len not converged");
+	close(fd);
+}
+
 /*
  * Calls into a subprogram with all five arguments, which clobbers a subset
  * of r6-r9 and uses the deepest stack slot the budget leaves, directly or
@@ -3087,6 +3144,8 @@ void test_jit_insns(void)
 		test_max_jmp();
 	if (test__start_subtest("convergence"))
 		test_convergence();
+	if (test__start_subtest("same_len_not_converged"))
+		test_same_len_not_converged();
 	if (test__start_subtest("calls"))
 		test_calls();
 	if (test__start_subtest("helper_calls"))

-- 
2.53.0-Meta

