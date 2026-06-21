Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5DB36F439
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782053003; cv=none; b=okgrqpDilzlf+vVhsMWv+8y/2NqyC3/uAu/PPP0YKbxuYv/q7LS3WN38Sy/IcJ4cGfyFSHS0VWSATCDT2nx4fqnO153qTBcN3D8b83YqMsVPKAgI6KXNh3+erbpa42ZSBmEdpdi3GDQj+r8Czj5pzBlf2Ar6kBx3bc01DQMS+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782053003; c=relaxed/simple;
	bh=LuZmuPo7NBI49qfo5dqm9dDda3AwTNdLDnJ+voAMLbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIZQlhOONOTQTD8Khx1HSm1/++nn/vDI0Wx3nDsf3HARm8uHiX6iz+6K4X79qhJmzyf50cQ8xyvuezTlLpJD2nkAB7vYZOPZleKOL80O0PESt1ya1DHYSM5KABvo9QEJ4NzeC5smw/rBm4mgirPZjGTMzsIfIJq/p4AJEdoPnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f33McxTw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f33McxTw"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84232e83ca9so1442149b3a.2
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782053002; x=1782657802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNsH4BL2x48/RDSlyC16c618fm7E62DwUpEzysGk8xY=;
        b=f33McxTw2X556JPGTtT7uSrLeOmeX+99wZ7eTzR3sKnU3cZjClY/exb+TqmtJsMNoP
         58GDAAMX3fll32q+DMxNf/EDQQ7RE7jAsSrt3I+O/D34AuGTA81hDzpsXuQyrI3azSu1
         RN6V+W5EC1tZfGz+TTZ/irHmyMITYev0Wmy7/zMESBD/mOAWI55PsBdDZ2jKgC7eKKL2
         LA8gmNDuoYVdHKCI9gfKAnUtR5rm87pTUaNoXQCS9wm1vdWI5IjIcSL0MpH2AlO9YKxB
         w+uX29pE/vkpzEblbSydjsJlb92sCXudVVwD77xrHXPEwBRxO7kzLKco+Yw4QwWctN//
         Ky9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782053002; x=1782657802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNsH4BL2x48/RDSlyC16c618fm7E62DwUpEzysGk8xY=;
        b=awvncRM0SwO/s6uO2wyw756KFoBgVVoLmXJgrdJCNjGQq4bEgANvHmfaAlHjkv5fZN
         pG8WuGAYMGXxuJZDb4WxBhwaMNXNOHYt9nt8fGBJIuPjpl+gB1bRiwprKkUH4Hecv2zn
         jYjlwD4zaz5f4NlFReGBVZhLR7ml+Tfluh3kGNWug0fXUs8w+vDW8YEu3O4OfteYcy+k
         lrQjHrre2r+7NSxqwiAVm3GWbg/gIQahChZcjwRgN+y9J+WZKV97IJkfGBRjOKC6287q
         VxkwXfBhvnxP5kbnSHBwOLWPvRYEswW7AOhV3ipE8bARq+1aZSnwsSeM54Vzl5HSF17Z
         zm7A==
X-Forwarded-Encrypted: i=1; AFNElJ+YnkSIigDpRaMfKnIajG9v52yHvUnj4/oY+o6W4O6AW264yY3rNN8nk4+bg2WQehgErB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2Mgtgolpy0k4jDVU435wxt83mU/CtK/hKGD0aPWxGChPNisu
	Ta+8LlXDSOGMHzy0OrNdreNl5J+LG86kiZBO2Yb7w/anFHWRlJmLn9ye
X-Gm-Gg: AfdE7cnc6fwt6Eomx/xxWUvpiTL24jybCn2Cj2Q4t2PorPTbi7pu/8IwRxQGvDthvyl
	WnEOtji4Pw2LQGU93oLxkhYPU42Xz86rptKFmnGO3jCRRSxfdOKE96q9LDz+RG3XvNzT3M0BivM
	8nYv8Oq651Zns870rk+GnGTGlfhebVJgPcWWHF/myXR3lbu2/7BqtT0QJ1TGAOjAnCcN39lYPjb
	2/N0H9PaW99ElQfhrFH5A1MIfHe28gXTDEnfvqkyRLQTA8sGtP5LCaT4qI4pWRxcuncafHiMibb
	E7SvVrARizRSpF6BD09lyAtmJieFuF2fEF2TSg98xBQlHty/lE38ZJuN8aSLEZyH3Bndf4dyeW7
	dUE15vUZ2p391q8SBlUSgM4rwxL5Y8BxjCdRG6OzX6FnwLnbHtEQM0u3Rwy2d8jZ+avAbtunIIO
	KKTgEilKEzU05glAepsA/Bjk+lLLG9
X-Received: by 2002:a05:6a00:993:b0:845:44c7:5e1a with SMTP id d2e1a72fcca58-845561140c0mr10722477b3a.25.1782053002122;
        Sun, 21 Jun 2026 07:43:22 -0700 (PDT)
Received: from computer ([2a09:bac5:3b4a:8aa::dd:17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7687csm4963254b3a.35.2026.06.21.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 07:43:20 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	puranjay@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next 1/3] riscv: stacktrace: Implement arch_bpf_stack_walk() for BPF
Date: Sun, 21 Jun 2026 20:12:57 +0530
Message-ID: <20260621144259.288135-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621144259.288135-1-varunrmallya@gmail.com>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used by bpf_throw() to unwind till the program marked as
exception boundary and run the callback with the stack of the main
program.
This is required for supporting BPF exceptions on RISC-V.
This depends on the frame pointer unwinder, so it is only built under
CONFIG_FRAME_POINTER, else falls back to the weak no-op.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 arch/riscv/kernel/stacktrace.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index b41b6255751c..a4c2411f4038 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/filter.h>
 #include <linux/kallsyms.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -102,6 +103,33 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+void notrace arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp),
+				 void *cookie)
+{
+	unsigned long fp, sp, pc;
+
+	fp = (unsigned long)__builtin_frame_address(0);
+	sp = current_stack_pointer;
+	pc = (unsigned long)arch_bpf_stack_walk;
+
+	for (;;) {
+		struct stackframe *frame;
+
+		if (unlikely(!__kernel_text_address(pc)))
+			break;
+		/* pc belongs to the function whose frame pointer is fp */
+		if (!consume_fn(cookie, pc, sp, fp))
+			break;
+		if (unlikely(!fp_is_valid(fp, sp)))
+			break;
+
+		frame = (struct stackframe *)fp - 1;
+		sp = fp;
+		fp = READ_ONCE_TASK_STACK(current, frame->fp);
+		pc = READ_ONCE_TASK_STACK(current, frame->ra);
+	}
+}
+
 #else /* !CONFIG_FRAME_POINTER */
 
 void notrace walk_stackframe(struct task_struct *task,
-- 
2.54.0

