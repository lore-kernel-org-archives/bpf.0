Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87541DF748
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075089; cv=none; b=D9o7sgH2ttxe/vwFcUylgqCvhZ9TTFT4fnQdBur01KriU6iulppAfaiKRYjMhYOjiH6p15eszwYpi0NG6NOo+SyBabWvNAF3lSCzaGZBTxTRhZs91pH1iR4EEVgQqHo6WKxA3gmBzbgSwPyeZbVvMUWxK5OE2GhK9XHVURrcFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075089; c=relaxed/simple;
	bh=6FEyrZBIuVHZXVa/Wty2A5DfY3a/3p+vm66ecYG7lRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJwJfV1dVSe7vvDmEhITwMVaffm7oxRFoAmwzgiL7CipMvrpzKJtbm8ib0msCaq3MLw4C07TJP++5DYgBIg4Z2DAxq/9PUGylDhDCHkHszK7vI2vSX7Zwl07mAontxysGVGAnBT9lV9XC/Y2a+PsmpjCs9LIlUykM8l9JBCR1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzzPYlix; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzzPYlix"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d53197d8b5so19522765ad.3
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788075087; x=1788679887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/v9tcQvggZcMvbz4eSzuyF8rA/Hv+diNOSutqEXrUg=;
        b=bzzPYlixTZKs4BwaiJfAWObYJov6H1zpzx+7OzW2sY5zLR9WIyNNVZbHznYirhnwrJ
         faOkCF0q4HDGCdPm6hkiApc0/9n1k5HLyDv9KdwuEdBCpMNG3EXaM+jYAvGPeyD9poci
         G8at7NlCmGe/spwyZy6Q9y37skrCGJjYrf6uDZj3JUl6fQ93Z89uLqbIrNjVyfUtbMxm
         y15nu16DflFP/iIto0AkRHhapgTHUC035JDuUlDgLzq9+cQKO3XoMRLby1TBE1Qb8Gik
         p+sFstItUbpi/JJ+ezKRHIP4GHtkVDrZRIv8p7MoOu88wEfWDAXgGCEvl1hsyuxrke5n
         +Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788075087; x=1788679887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/v9tcQvggZcMvbz4eSzuyF8rA/Hv+diNOSutqEXrUg=;
        b=DCdRTezbcIs1HMTEedzyUilK5iveMPTHQ1cFmG2DZh/AsE/rS7m63M7F3EV3FjoJRe
         OS4OfGFWmDTtt3HlmA5GxiXH8WFFFCP3khKYRlfIkZFQx56/FaTWpCUm++NCJiNhz/m2
         c07e51NK/+5YpVZsQQgOrmgcPr31SrzjyPRmcNZkGw3I9IMAcKphVB19gWtWGm7CWkJT
         AjUi9wDk2GdyY6Qj07bjJ4OAyoFwggypVumtIfQr4kX3qFY44dLkgM5VvWLuhncdgqHZ
         V7hXqH/GQcRGOLMtkvhjgnU3DZ0C22FXSAf00xotB3xenqVCTjHb6w02P5QolonPDTZp
         XMFQ==
X-Gm-Message-State: AFuF++kR5nhRF3Xk6FyBGAHhVmMN8re3fpBd/t7qVkUs5cz5BMsHQBOn
	yLZG4wrPr7AF/ivwbBO5na+cR9r2CX+Iqm/TszDKl6v1YzInvRltlhxmzb4Tf43K
X-Gm-Gg: AYBFou0uY2WXGp6+r3/F04TXbrHljuT8m03wVodXngio3/OVQ5bsvWEgTW/GiWrusuA
	9ucASpzJn2VEncwewNe9eYRsDGF3tCOxEtkUtQ02t4Ls/UTlYWC7SGw62oY2AkGNPv9VQMAA0Vv
	VM2j67WxR0kbk9MfzlINgCfHCXtIuNKFNuy8gt73sGVR8eVmNhmum/smOJwn0EctP0xwxuu62vH
	f3+kyndOLYoKFCiE75D2x3mscqt7BiWOmpcLYW66MPA+Gq/D79OMLd1Wu6PEnIVjqfGlYmDbU/8
	mazRm27cLUFwHJ0w6B0D9QOXFGdkYfj6+V4VU8VnEHePVEZGJN6VvNESGdEF15UF1HZoajW3TxR
	X+PEdMvzsBw9MiLLnXPWKk2sPydHUJour7TEfXgiGuk4m/1xjZ03IMHgLuI/2ogv2acbqH7tk6K
	OO4N+gJa4mQsqDjlnny8cijq7ue0NdDvaRCv3KGafc3jvM4/qDP/tJ9b2DAUHYBd76h5b6Qd9qC
	33TkRgtVWO+AKNvpfxVyz0IUbDfQbOqrW0NKy/NraZ9gzn5QYv5G7UThJDKhd+HYe3eADdCw8ov
	LMoTBnMt0HouJQzZp7Y6soMLx7G+12Fv3zY3q0Z2x4g0ZqshVT5DIZ08xXsUW0xDiu0nNtHPaOi
	T
X-Received: by 2002:a17:90b:1dcb:b0:38f:57f0:1f5d with SMTP id 98e67ed59e1d1-396d0f3df80mr32189338a91.15.1788075087268;
        Sun, 30 Aug 2026 00:31:27 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc0c703sm10327082a91.9.2026.08.30.00.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:31:26 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rachelmenge@gmail.com,
	hargar@microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add compiler-layout terminal gotox test
Date: Sun, 30 Aug 2026 07:31:25 +0000
Message-ID: <20260830073125.360934-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830073125.360934-1-sidchintamaneni@gmail.com>
References: <20260830073125.360934-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add coverage for the instruction layout emitted by LLVM for a computed
goto. The jump-table targets precede the dispatch block and gotox is the
final instruction in the subprogram.

An equivalent unoptimized C source is:

    int bpf_prog_trigger_syscall_prog(void *ctx)
    {
            __label__ l1, l2;
            void *tgt;
            int ret = 0;

            if (ctx)
                    tgt = &&l1;
            else
                    tgt = &&l2;
            goto *tgt;
    l1:
            ret += 1;
    l2:
            ret += 2;
            return 0;
    }

Tested:

    #646/5 verifier_gotox/jump_table_compiler_layout:OK
    #646 verifier_gotox:OK
    Summary: 1/28 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../selftests/bpf/progs/verifier_gotox.c      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 5b18c9a27717..0ea445287175 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -47,6 +47,61 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
 DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
 DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
 
+SEC("socket")
+__success __retval(0)
+__naked void jump_table_compiler_layout(void)
+{
+	asm volatile ("						        \
+	.pushsection .jumptables,\"\",@progbits;			\
+jt_l1_%=:								\
+	.quad l1_%= - socket;						\
+	.size jt_l1_%=, 8;						\
+	.global jt_l1_%=;						\
+jt_l2_%=:								\
+	.quad l2_%= - socket;						\
+	.size jt_l2_%=, 8;						\
+	.global jt_l2_%=;						\
+	.popsection;							\
+									\
+	*(u64 *)(r10 - 8) = r1;						\
+	*(u32 *)(r10 - 20) = 0;						\
+	r1 = *(u64 *)(r10 - 8);						\
+	if r1 == 0 goto select_l2_%=;					\
+	goto select_l1_%=;						\
+select_l1_%=:								\
+	r1 = jt_l1_%= ll;						\
+	r1 = *(u64 *)(r1 + 0);						\
+	*(u64 *)(r10 - 16) = r1;					\
+	goto selected_%=;						\
+select_l2_%=:								\
+	r1 = jt_l2_%= ll;						\
+	r1 = *(u64 *)(r1 + 0);						\
+	*(u64 *)(r10 - 16) = r1;					\
+	goto selected_%=;						\
+selected_%=:								\
+	r1 = *(u64 *)(r10 - 16);					\
+	*(u64 *)(r10 - 32) = r1;					\
+	goto dispatch_%=;						\
+l1_%=:									\
+	w1 = *(u32 *)(r10 - 20);					\
+	w1 += 1;							\
+	*(u32 *)(r10 - 20) = w1;					\
+	goto l2_%=;							\
+l2_%=:									\
+	w1 = *(u32 *)(r10 - 20);					\
+	w1 += 2;							\
+	*(u32 *)(r10 - 20) = w1;					\
+	w0 = 0;								\
+	exit;								\
+dispatch_%=:								\
+	r1 = *(u64 *)(r10 - 32);					\
+	.8byte %[gotox_r1];						\
+"	:
+	: __imm_insn(gotox_r1, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
+					    BPF_REG_1, 0, 0, 0))
+	: __clobber_all);
+}
+
 /*
  * Gotox is forbidden when there is no jump table loaded
  * which points to the sub-function where the gotox is used
-- 
2.43.0

