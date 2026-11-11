Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401859;
	b=vau0qV5zYkLSNAdfQrFAm2KlsagL6dpR0s5NeCWWWMry5whN03oRXQnq/SDz6mxVJeOB
	 h2FLoZ06PI72951ZynuxIzioAdR2Bngms+blhePqMvD5Sbyc9LgK8MVVxVZX+Yikjuif+
	 ci//f6Iz+7qQQQ0/Zu7hX06o8rtai5kfXhfps4lv5RoPxoB8fwZ/iZ+4qXNFJ9QSF1n1w
	 b6q/k8Dtn0ElZkHCWuW7rnvCxloYv9HWkVU50CbhX2Ou/lGfVAbuzoseokLUIoNi19Vv+
	 zEQzeBGCWJWfoGeCAqMOuOwnYDcnC1Fi5AnKxjhOH+E69NpasvvmzuwMbuwVonLtCzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=JcGOV06D89/ud3p6s/bUyFxLyMxtabg8bfvMcEnZYZs=;
	b=a5UggOat0Xac75ibsHkVWz8YOdZFG0MhNAxTa7cZhIbfkhb/0RXyqmv2d3EliI5lx2mX
	 oIEfPoTsJoF6HgsYFY+ofjY8VHPlyAdOGWco9Fs7Y92MdsBYMyB0XditRP6SnTBYkCXrW
	 BdAysMHmICz7benHhIRW1MPzEV7hcEl5JgNU9kngfJ01yMoqiaCPap/YPO1yTaRbZMrbY
	 /gkje7btj3dQ7De1foqKlWmZkNgifHXQl5Cicxeeabh6hd2EvUGXZ5mvpHQFop219JGVG
	 wuv7IAxbV413B8FeZk1clJhz1pBTCQ3zdMJUj5LIYGYkKx3YUQJrQEVaNrf09Wmwdnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cepFbt+8;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5FB606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E5FB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cepFbt+8
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-4a35e178418so12006195e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401857; x=1795006657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcGOV06D89/ud3p6s/bUyFxLyMxtabg8bfvMcEnZYZs=;
        b=cepFbt+8PaBZYHwaaofiyS5ndd0DTgdyzJdPIqdFYmEiTl708IdaWNpeM0AUmw3Ye/
         X2MatS80A7jrpMsimxyKbnmQQNyQZByP47TlrjiRsn/wW5hUytwbbleDFJOL2Iyq0Ha9
         2zhPN1AFtc0LR+JfCoVu1WBCDnlql0T1wyEkckGAVZAYntdRElgiPSiXgtwuIolhh2iM
         28QuSgVIEeaUhvB15xPDWU+TkBQN/Di98dm83/IFWH8xbiHEKFm3ZHqPrrBIyeIYpd5n
         Lwr4zNJ75jgF2tB6XeMPNo558YqDLQfp/mpBkJjcVTTEFRUN/tJB+e/g7ts++CD8Mrrd
         9ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401857; x=1795006657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcGOV06D89/ud3p6s/bUyFxLyMxtabg8bfvMcEnZYZs=;
        b=sf/Kd/RPKhtEJTrZkNmunQSSO2V2PAep0ec18/9jmvtGP1O1bK+IHuqIMUY1ZY/t2/
         Fv7tKJCacG+LuVQYBBobuhKi/rFO6luMiHbcrmW5aeghNFs51Ohz0EtWgxieLYlUCxrg
         IyS7otURiL2u+lFDyE0/V0C+q2bRNKODCp5/RrHjl/5tjo4bvPPGDsuimaqIjGSAjHfT
         9ui1pHPYB40YyrXPHOP5ai2Z5+6XigNQ6X5eExD7DposuzKZz2U57owtTUIdYuwTuv/u
         M1VcvRhtsbpQoEDNV66WENn4fcCWOaDmm73TuYL/1L/TzRlCgzeAo/2VewlQLKBV6VB/
         42nQ==
X-Gm-Message-State: APuU4Z+A4UJkYGnIj9oozHnCPQElv5/10785y7rUPnrh7zV2bvgwFRzQ
	mE0srm/jNvA8pNACAYpuu6/tmGu2ZYsu8fdRNQkqi27+cGv5NgpPKeRX+wOQArUDv0I=
X-Gm-Gg: AYBFou3YLIzO795WBg8TDqVS6uawggJShtd4ixMakcZBgQROYxqAJNrpfg81KKd8KKx
	LSJM1pEJ2qF5BgI2SbOiMvIkLI/8gQIZfM92ugLTMIa4f+ZHXt+7cHozwEaVNociu7EF0+UtUN4
	PGy2z2PbgE6JQa5QIgBKwIruK4AHR79e5vS3ALRx/EguFvNs4XQJSgwNPjXtXfuGNAUoVHHKBPo
	t6qcJanf9xJuv4PK2PbFySkoWUV3dEGlYILdJ4bTba7/nrW8pbIEgGZLASYsEQztjjWc5+DUmaE
	IJKeinkq7bBvl0elpT8MffGvCjUSCYgfhByGNc0aI5jl4aITjJ4SLzhvuYhjsY9jRU13QpZwAy3
	dAMl9F7TqzzlE7p+YW5pepa/9T5U3nIhBCcS4whPGAGr+/T0TvJ2dBMfOGIKPF+94pUzZ7ExE1M
	ava2E/mdZexcVANn98j+ukXNYIkHtFOkfVny2Yv9VFL1sH/W/E1qMrelX4cLNcyg1B3tuRtmsCt
	AU9YpmNrsTotpoUIqxAQ/L7yAY+xhN/QyscNJVndmueXw99ue+C5QXuzfsodm3SPPV+mInmSZUU
	1LabvoB/hZp+qt8Mca1VSw/ybpOkfJxqvQBthUnsFMNubNhMx+blY14SnnVABwPKKFVuEC31uMI
	wKC7wbto9q7aw8giMYkKgWrICBdSGUUMME3I5pELhNMRNCTkMu+tFgirAvuwifCYjcByo
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4ba093be225mr30023515e9.22.1794401857353;
        Wed, 11 Nov 2026 04:57:37 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0223c41csm142833655e9.14.2026.11.11.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/29] bpf, arm64: Capture registers in a native bpf_throw() entry
Date: Wed, 11 Nov 2026 13:57:02 +0100
Message-ID: <1f350666f818204822a237878cdaf572ac6c6b9b.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023; i=memxor@gmail.com; h=from:subject:message-id; bh=cOgafx8UBQV1aTUZ1nfcI4FVSAYnfz1eS5bREnPEDog=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzJyAA5+1dRbe+nws8cvRU9omycZTmme+UioK/PngQ cVk/0KXjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExkgwzDf1/HKReylLoO6Squ 6n3vwrxK6wNbbELsrJ76rapme+tWVDAy3I9cWnv2WmyTczEbM4Nh5t5ZZw7c/3X4ecaXSUWRsq/ deAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a native entry for bpf_throw() on arm64, as on x86-64. The verifier
redirects a call to bpf_throw() to bpf_throw_entry(), which:

 - pushes a frame record whose return address points into the program;
 - saves the BPF registers of the throw site next to it as a struct
   bpf_throw_regs: R0 from x8, R1-R5 from x0-x4, and R6-R9 from x19-x22;
 - calls bpf_throw_unwind() with it.

Nothing uses the registers yet.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/Makefile       |  1 +
 arch/arm64/net/bpf_jit_comp.c |  8 ++++++++
 arch/arm64/net/bpf_throw.S    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 arch/arm64/net/bpf_throw.S

diff --git a/arch/arm64/net/Makefile b/arch/arm64/net/Makefile
index 3ae382bfca87..70d18f067d01 100644
--- a/arch/arm64/net/Makefile
+++ b/arch/arm64/net/Makefile
@@ -3,3 +3,4 @@
 # ARM64 networking code
 #
 obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
+obj-$(CONFIG_BPF_SYSCALL) += bpf_throw.o
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 83a858c6d472..33cc50268f3a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/bpf_throw.h>
 #include <linux/cfi.h>
 #include <linux/extable.h>
 #include <linux/filter.h>
@@ -3965,6 +3966,13 @@ bool bpf_jit_supports_timed_may_goto(void)
 	return true;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+void *bpf_arch_throw_entry(void)
+{
+	return (void *)bpf_throw_entry;
+}
+#endif
+
 bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
diff --git a/arch/arm64/net/bpf_throw.S b/arch/arm64/net/bpf_throw.S
new file mode 100644
index 000000000000..93f2d208ccc8
--- /dev/null
+++ b/arch/arm64/net/bpf_throw.S
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/linkage.h>
+#include <linux/bpf_throw.h>
+
+/*
+ * Native entry of the bpf_throw() kfunc. The verifier retargets the call to
+ * bpf_throw() here, so the BPF register file of the throw site is still intact
+ * on entry and x30 is the return address into the program. Push a frame record
+ * whose link register is that address and save the file below it as a struct
+ * bpf_throw_regs: r[i] sits at [sp + 16 + 8 * i], with R0 in x8, R1-R5 in
+ * x0-x4 and R6-R9 in x19-x22. Then hand it to bpf_throw_unwind(), which never
+ * returns.
+ */
+SYM_FUNC_START(bpf_throw_entry)
+	stp	x29, x30, [sp, #-(16 + BPF_THROW_REGS_SIZE)]!
+	mov	x29, sp
+	stp	x8, x0, [sp, #16]
+	stp	x1, x2, [sp, #32]
+	stp	x3, x4, [sp, #48]
+	stp	x19, x20, [sp, #64]
+	stp	x21, x22, [sp, #80]
+
+	/* bpf_throw_unwind(regs, cookie); the cookie is R1 of the caller. */
+	mov	x1, x0
+	add	x0, sp, #16
+	bl	bpf_throw_unwind
+	brk	#0x1
+SYM_FUNC_END(bpf_throw_entry)
-- 
2.53.0

