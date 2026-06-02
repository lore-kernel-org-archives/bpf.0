Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C8395D8E
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433965; cv=none; b=uW4lxQs7dZnKrwF272L9+GDiMwlIQgef6xTW1ciLX7hNAJh4c4FkoHS9jPNZXyOLAf2vwHLN+yH/CgefnirFRA9CWKyjma/COK7UlDL9uWmnLxHjpU5l/ENYkhxLHZuCT7Rf8bLMR6mXPAvpT7gBMmcq3gWEm9NTS3BjjEJA4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433965; c=relaxed/simple;
	bh=OIL4u1059wQePR4fBxdtuuk+4+q2KWiT2f5tiuzz13M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHkpkTBjMUB7T0OzBVW89TPmERcGI0CcFEZTfSn+cY5J1u+q3QFDjil8gvgVB+4uLVhQajHA00ep4kkmbhwLPQy5ei59Y2eloIRuFvYUWhlDC2pkpwEOog42qX5+BLcw8mwxlH41ammMTfb8vmMnSXoEjroZZPfd/qI1A6rBjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3rnsinv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3rnsinv"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so2730102a91.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433963; x=1781038763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea3yw5dmVH/Wal3jfG05beYzbzDpKpyYIVD2MX/4oR4=;
        b=X3rnsinvLeEIbf83NUNYYy7Bw6LQVHa4Gzuz18eiLNaRBPAOb0hxcZRtAxMmS82VoW
         VNt5SI0rXyKiZ8TzkU26gzdKqQt9zNCuVuiE1ohrQiLz45y5M8J6ow2CIOnFnaag8NIv
         idNygrWig9WQQQE8e+kJLtkXnjG6qTIvoq6kSzL3U1fan1UWimk5L8XlnD+9vUQurT75
         LCrdFnZk8CDksdgOFEkYsmSdbJqowzHsWa7ZLzLQCwtDhCvUAV8aEwnmXmt3LkUhsUyP
         Zj3q5FP1eRY7plChpcPolE56iUyDNYvDt7J8haU54C9rjAV23qywgk9/iBL2/vozY2pC
         GN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433963; x=1781038763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ea3yw5dmVH/Wal3jfG05beYzbzDpKpyYIVD2MX/4oR4=;
        b=Ze3Y3je/FFtXdA4HABTpDCjZVtLjxGrOsmq2BcFsch1USDvLq4SST5KtGot5HUHyaF
         UIxZJNrPLA62bnB9Ucn6Lubn9Z9NdO6zTneqC2xAUyHYI5/l/mUtR0efU1VumwzyPnDK
         QyQmUqqqt24XWB3CG/8rKKupWo6IfhDbxi9gU4ATldywjfjTDsGiFaCd8/NkDHQXPfYF
         O4F1I1d1FlAcijB70n++dWg+sLmqJMULsXSTK8lPFRzBI52HuANiByb52VjUycrl47AX
         TQS7t1we0rj4u1xPbQx2+eeGDd2B6/sAp4O/gjhSaDHfiXoXvCUglbtGyebdGIHHcxFH
         hFkQ==
X-Gm-Message-State: AOJu0Yx9XnfgcOfDwAlat/XI10MfyoD1KVua+D8rYsVpqmh3TCgdrsbo
	MRS+xyf/VgisuuXqtfgcs41+hqi1xmhb4cx0foEjrjLAWK+cIVmYs6+XNDgB4Das
X-Gm-Gg: Acq92OGHN9VUPHmKs+rsaD5ydp4zDT3y7ucKpfSIwrQnUoq7zlr79kQk3CRsodVpdEX
	aH5uP5/AO0nE/gbpuFI/8Kff9G94kgUgbMP3YIRFB/7cyh2/K5TKWLep/oi+J4nqLLtZDAEU0kF
	koyzN6oaAg0F5tyokMIFqLkPzDULg/TrBV1/9p6zTcnp+OOfRQf0ebt5nQshXwa6AeDI/4YA9/V
	UOi4UsaL/HQO5eIdShJEDuaJLebbkxgCiwwyrHO4g8cnhqehNQjp1monBxDmwdUvARHelKfojsD
	X+Ao7VARUvXxoa5q07dIUd2SlhuKEc/Go0ZbMfZnxhabkNNAMucV/cuGI1KlqEIi7c2KiQ69XGM
	b5Vy0AzrbSuy9mxd6NCzdpF80Ij2TYyYqiuXumPx+0Ts14axRXRcMhFvoXpS26830e7G9TltT4S
	+BD8VaqEZrOR7LA9COAuPSISYYf7Ue8VwtUrbZwz0WSoDP+E7TTSjV4sTVrrQD7DH4E8VrtB9Lk
	0kVuUyzCvRbQ5Tb
X-Received: by 2002:a17:90a:b401:b0:36b:5b82:4834 with SMTP id 98e67ed59e1d1-36e30c213bfmr311928a91.7.1780433963026;
        Tue, 02 Jun 2026 13:59:23 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:3b4a:11cd::1c6:2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df043223sm157354a12.8.2026.06.02.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:59:22 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] selftests/bpf: use host CPU features in JIT disassembler
Date: Wed,  3 Jun 2026 02:28:46 +0530
Message-ID: <20260602205847.102825-2-varunrmallya@gmail.com>
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

Pass the host CPU name and feature string to
LLVMCreateDisasmCPUFeatures() instead of using LLVMCreateDisasm(), so
the disassembler correctly decodes CPU-specific instructions and
extensions such as RISC-V compressed and vector instructions.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/testing/selftests/bpf/jit_disasm_helpers.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 364c557c5115..3558fe10e28c 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -96,10 +96,19 @@ static int disasm_one_func(FILE *text_out, uint8_t *image, __u32 len)
 	__u32 *label_pc, pc;
 	int i, cnt, err = 0;
 	char buf[64];
+	char *cpu, *features;
 
 	triple = LLVMGetDefaultTargetTriple();
-	ctx = LLVMCreateDisasm(triple, &labels, 0, NULL, lookup_symbol);
-	if (!ASSERT_OK_PTR(ctx, "LLVMCreateDisasm")) {
+
+	cpu = LLVMGetHostCPUName();
+	features = LLVMGetHostCPUFeatures();
+
+	ctx = LLVMCreateDisasmCPUFeatures(triple, cpu, features, &labels, 0, NULL, lookup_symbol);
+
+	LLVMDisposeMessage(cpu);
+	LLVMDisposeMessage(features);
+
+	if (!ASSERT_OK_PTR(ctx, "LLVMCreateDisasmCPUFeatures")) {
 		err = -EINVAL;
 		goto out;
 	}
-- 
2.54.0

