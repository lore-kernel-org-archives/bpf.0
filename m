Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2D4F646E
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455754; cv=none; b=QzNMWVbzVZBsjXncbufKOhi2B3+/AFG595OYlzF9TLE6PXBibUaulw0N4toXnIHLRnAyK3BH51Zsa6QpbWoISzCTqR8BRJD9504NAxtF4PNQXmGltCSDpu2awVJXqdqRmjkmgBOr+psQF/zjkXDjYSYqpHthheHDEfX1QbyFNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455754; c=relaxed/simple;
	bh=l2CGfBNvWSEttUmlHrBqiH4KzwCS2REfQpSoO/e4jzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjkXU2vJFWw6CARUZ/uUbiJbv9L+QeJSKhDKSFy+6DDw3++cnTGM6iFjnaVHjCPmmBhQnpfvwO3ndsQstrYVme6oRMZMeu7d9JBkLIcU4k2Z7I5GlYlFCx6yy6pEj4wk+1jT2J0Vtc9l9GiqHW5ed5+dsniHxNThGfyG1GvUIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m22JVwrw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m22JVwrw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d6d28aa26cso377425ad.2
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788455752; x=1789060552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgcvHo49DDR9j8F+h02S3pkiu0IBuCDcZgsdJ3yoDuQ=;
        b=m22JVwrwwBKfJj4xwV4t8j86Tu3mDE6Q72R3acnXV/Wf2wWhQRgEGpmnYiZS/TrGgQ
         X0VHlVpiFRbuyZJyvNqBCSdQatph2QNnxQgd3p54RuFA52jB8p0//qXJIkQVLyoPET2r
         ZRvvHPE9O+XxeHLTZKxbZQHX/y1WazBhDB4o4zqcQdu0KG5bUUL6uLB8SytkU3/J9H8T
         Q+tOUkvI+nDIYYdh3Bp/epaVEGjeIGFjkKSWqW/P9w1Oq4eXzDSuzuamokiSN5og+lOz
         4MKTaCHJDJN9AFxGFBVyFJExhGMXr+un25lLltnNW8FBacclJugDLG+ZPOSMWNvNwb4z
         lTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788455752; x=1789060552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BgcvHo49DDR9j8F+h02S3pkiu0IBuCDcZgsdJ3yoDuQ=;
        b=ITkmsqB2ZmDW4/IIvLZdQkxtKt7q1rOegtEWS0r7VauESYFfDBoKdJzp13oR7gtnND
         ZbxuMwRtdABE3f1dwQNPebjD21yjcFggREfDGjzl2ZzS9CmznWuJsyaiWppoEGNpY74s
         R24jzrOHTniPA5VVDs5iAJMHgDEkdqS3kVV0z339deXfHOE4lOSw3pNigIVVIQPPRkmM
         4snuucpfFWptrkpxlDOlx8IPI4tdJd7YysOJXWmXWfeYii91MNDmEH9qPwrqw1+zQNmO
         yEPwrh/FtHaXag1+G5t+udsw8kT41tZ78leT0/IkK++XdUEZBuMpSb4E0bGQL38oz2P8
         luvA==
X-Gm-Message-State: AFuF++mR455SlDQcUYXn/QBUexPUgYXCEwVMCr6G738944wIKvQQpjsw
	Xb38iIPou+AHAK2zzCwOFQO3+QS5K2B1HsNHNk3Bn/ZXh90JsY1L/d/Tq2G5r1nRwBk=
X-Gm-Gg: AYBFou2kFPS1iY4qmNEr57B7x3dKwrHheC/LpfeS5wtLtK0c3PbKOu45fMG7GwtlXAc
	Bk5W9+eRp/TRHy5CwmhwFwk1fCfTg+LDfkKfinfzHdzia8ZUwofnfFcJ34pnFLb5Vo/MsDGgycm
	a4ayhtXxxtYg0TjzThDW7reT6o74pZgPZFwN54HQScaADPCOYj1hms+YgfGSoXJTa57rnYuxyvH
	H/Xv6/yMjHmbyCzJoDqK4AyKNTsx86P0ukdd69Tb+kNvkB7LB6SC2mxpvwL3MT2lGCVcF0fJprb
	bxwisky+3ahRDWi3NNBxHG2w7OhHqRqSNu9Lkk23MyJmu31KTumPwMS3qVpH4Tk0UtCKBFdh7jb
	K2XhUKuy8jDJrFCVOEyIYi0OWhvUPHmdw23qLdl5VjcrWPk4pibgmFuEgw+FEHl1dntC6DrJ6LN
	MWLGgcV225zPqrxAGSJ1MxycBWO4Yc/y4SuITBwail3rqHNdn9zWsHVe7ZET29z1YIaPT+g1K9v
	YdhMY/IE1/+t5SOIumIcKhMUKA23PmPoOdXwQSctd6vuw==
X-Received: by 2002:a17:903:4685:b0:2ca:660:b1d with SMTP id d9443c01a7336-2db126d8c1bmr6413485ad.11.1788455752125;
        Thu, 03 Sep 2026 10:15:52 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d25sm354893eec.5.2026.09.03.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:15:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 1/3] bpf: zero extend the result of an arena 32-bit cmpxchg
Date: Thu,  3 Sep 2026 10:15:39 -0700
Message-ID: <20260903171542.1438050-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_convert_ctx_accesses() rewrites an atomic on an arena pointer from
BPF_STX | BPF_ATOMIC to BPF_STX | BPF_PROBE_ATOMIC, and it runs before
bpf_opt_subreg_zext_lo32_rnd_hi32().

That pass emits an explicit zero extension for a 32-bit cmpxchg even
when bpf_jit_needs_zext() is false. This is done because on some
architectures 32-bit cmpxchg requires explicit zero extension for the
dst register. E.g. on x86-64 'lock cmpxchg' does not change the %eax
if comparison is successful, while BPF semantics declare that each
operation on a 32-bit register zero extends it's upper half.

is_cmpxchg_insn() matches BPF_MODE == BPF_ATOMIC only, so an arena
cmpxchg misses said zero extension adjustment. This patch adjusts
is_cmpxchg_insn() to match BPF_PROBE_ATOMIC alongside BPF_ATOMIC.

Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/fixups.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 65b441e4a351..52d3cec33672 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -13,10 +13,15 @@
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
+/*
+ * Matches BPF_PROBE_ATOMIC too: bpf_convert_ctx_accesses() rewrites arena
+ * atomics before bpf_opt_subreg_zext_lo32_rnd_hi32() runs.
+ */
 static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 {
 	return BPF_CLASS(insn->code) == BPF_STX &&
-	       BPF_MODE(insn->code) == BPF_ATOMIC &&
+	       (BPF_MODE(insn->code) == BPF_ATOMIC ||
+		BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) &&
 	       insn->imm == BPF_CMPXCHG;
 }
 
-- 
2.55.0

