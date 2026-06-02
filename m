Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE3392C32
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433976; cv=none; b=DAi6Fk4UGb897MdyF0M0nAYxIy2AhzOpGlfWr3raoA77Ofgkxi+DtBGNpKutGBNhXTi/bUtEj9Q9Ik39YLffs3coY+D6f6O8Bc67aX3FXmThoh2NQwq7JJ9GVL/T6AJXELkNvu0kNlbVfuNAdbbDyMLxVT4M2uj5dpoTc4gxRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433976; c=relaxed/simple;
	bh=40YuMegnizHDre5rP/J67ecYybi5tbv7U9hYJ5stFqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIWxnoNGMByjc33X2q/jVlqN4NtVGPgiPLqKVRLy1Y1UVVTWeNDV5Lcne+t3ykeZ7u8vhaqF/28ztpPU7q8huPku/IgPIdkN/cp8rMS7VLCimf5x2cL8rArZg0GfFSMeW2/cLw4tyGyLeqSMqKgjAOtmvKVEmeb4o5LMhtGK/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBajUGmu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBajUGmu"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c858b5de728so2315316a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433974; x=1781038774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtyaF8m6RLOpOeiX8WoJduU1Pm23yBD2PG4I02qCKQE=;
        b=dBajUGmuXiduNnxYDigsK0NW+O8Y0gSoOAmVS3+WiUenfpr0m/M6EgXnWjAuEXMSze
         wvhmLXm0EpuZoCaNUut9lxp/bEN/iuHNxDDOcktz/V+Z1GrJHToBDWrAXEQJgvtgLZ4v
         R2liSxLhe0nXYad/K/tA2Sso0bBotJAE/AZIEbF9IKXxLCPjeDsLbmgIS1aFH+c7QbzV
         zLFlxTjvsuJCiJ0L6h0mM7uwdUMoXt+0FU/LvCbahl01MXA/TrQlVaeP7Gbqw9ooN/1D
         Xtw/ShTek/R/dcnrIumDF3X7BfakIIBsW/Tgxt7lmEhD/VkGWTsWv4Rvm1FAcGIs0OdV
         vF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433974; x=1781038774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtyaF8m6RLOpOeiX8WoJduU1Pm23yBD2PG4I02qCKQE=;
        b=e10zuk705SFK0eiaWU4uopW5F+TaqVRQ1OFEFsaLdx+08JF893PUagmy0SqgOEy0dM
         Cx5Uja9do7W0AOqOj26ti5ZurnpqMQq7BmT6dAOSazIe9QpzAQc2B1/F8KJPc0F0OES7
         L+0U2qkUsIKMCjXRTPBSm9XxhbJ4jnKImHDi4SEXjb0coEGVSaspNKdH8nm609bRQ8aR
         9iWLZz/70tk9q5SUMyU9/oO7+Qg9djgpop115A9nc8D6mRiQA4Jlbo1L3KOoyuD6+Dhd
         3PudLh7vvVA6g9gXu1mIHY2QV6yu9YXoCVfUgt8qMW/Vhek8xLc2Hl6jlHYfS8R+wfLo
         ELEQ==
X-Gm-Message-State: AOJu0Yw6pFZWAhxviwS2Czu44wVgF6hdLbA8gzNBIF+uAuGW+M7ZzCt9
	XWlXDyy6l27osmnjJ7boLFXL00Sy3R6GEy8ocIOJPwLfdLbDnj7kCBsgCzcVWrJf
X-Gm-Gg: Acq92OH765wwPWMO7MAz/9871JX6eDcMPzj76vgEAL5fllImUS5KE6ix0f5eGPPsZcu
	uFHhsd0AVtg7z4eLAxQWcwmRNAlR94dQIQs3N5JcME3CCg7jEQg3nwO8Zrh2GcyUvW1nYLReXe2
	EftnhcHOb4321MzMjNGuHLP8gSuDiYbl9jWmorgMRxf7Y/0bmCXN+QWvUyDWj7yhCruDW56zabe
	G8z8DLbxLGYFDykT7wRpkYuj6MVnZDuAPsfodmLbgRXDjiouz3JsLZ28Ghg6ZgFrhDW7j1puS3p
	GCkMv9Au90ZXBrnqKsDgUDLu9QMEw30Pj8Z+xRZFLEsybH/88y5BLpf9a118P9M5KqbjfiErjcJ
	uT+C7mYngHjHURbsAJefdaGvgJ85dcfO2xLmbCzZMgKkiyioZaHBsInNDZ0HMugI9fXGu3v7SIA
	jrEDWpiSHcV5GJwQoZRJEYOTRzbnbcpFOTLoBeW1l+Y5xcunEpAHb2UvcYzUEMf3UAXV6DGODfs
	pyjCQUWuFFu1y6P
X-Received: by 2002:a05:6a20:b598:b0:39c:126c:93b4 with SMTP id adf61e73a8af0-3b497449d82mr542621637.9.1780433973930;
        Tue, 02 Jun 2026 13:59:33 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:3b4a:11cd::1c6:2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df043223sm157354a12.8.2026.06.02.13.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:59:33 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	puranjay@kernel.org,
	menglong8.dong@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	pulehui@huawei.com,
	alex@ghiti.fr,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next 2/2] bpf, riscv: inline bpf_get_current_task() and bpf_get_current_task_btf()
Date: Wed,  3 Jun 2026 02:28:47 +0530
Message-ID: <20260602205847.102825-3-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602205847.102825-1-varunrmallya@gmail.com>
References: <20260602205847.102825-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On RISC-V, the current task pointer is stored in the thread pointer
register (tp). Emit a single `mv a5, tp` instead of a full helper
call for BPF_FUNC_get_current_task and BPF_FUNC_get_current_task_btf.

Register bpf_jit_inlines_helper_call() entries for both helpers so the
verifier treats them as inlined, and add the expected `mv a5, tp`
annotation to the riscv64 selftests.

The following show changes before and after this patch.

Before patch:

      auipc  t1,0x817a    # load upper PC-relative address
      jalr   -2004(t1)    # call bpf_get_current_task helper
      mv     a5,a0        # move return value to BPF_REG_0

After patch:

      mv     a5,tp        # directly: a5 = current (tp = thread pointer)

Benchmark (bpf_prog_test_run wrapping bpf_get_current_task in loop,
batch=100, 10s, QEMU RISC-V):

              | runs/sec  | helper-calls/sec | ns/call
 -------------+-----------+------------------+---------
 Before patch |   173,490 |       17,349,090 |      57
 After patch  |   320,497 |       32,049,780 |      31
 -------------+-----------+------------------+---------
 Improvement  |   +84.7%  |          +84.7%  |  -45.6%

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c                         | 9 +++++++++
 tools/testing/selftests/bpf/progs/verifier_jit_inline.c | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 2f1109dbf105..e2c70c70cca8 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1808,6 +1808,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 		}
 
+		/* Implement helper call to bpf_get_current_task/_btf() inline */
+		if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
+					   insn->imm == BPF_FUNC_get_current_task_btf)) {
+			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_TP, ctx);
+			break;
+		}
+
 		mark_call(ctx);
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &addr, &fixed_addr);
@@ -2138,6 +2145,8 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
 	case BPF_FUNC_get_smp_processor_id:
+	case BPF_FUNC_get_current_task:
+	case BPF_FUNC_get_current_task_btf:
 		return true;
 	default:
 		return false;
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
index 885ff69a3a62..76d80605ec7f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -10,6 +10,8 @@ __arch_x86_64
 __jited("	addq	%gs:{{.*}}, %rax")
 __arch_arm64
 __jited("	mrs	x8, SP_EL0")
+__arch_riscv64
+__jited("	mv	a5, tp")
 int inline_bpf_get_current_task(void)
 {
 	bpf_get_current_task();
-- 
2.54.0

