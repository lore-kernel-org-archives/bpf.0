Received: from mail-ej2-f9.google.com (mail-ej2-f9.google.com [74.125.228.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06C4028F2
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402428; cv=none; b=gNQ8KOFuiE5Jl8N2YoT//Y1JZH3yCBI89c67MfdNPGoP7GD0GOifkLzws2r32ioSH5T0qbiEkVR58erxx+EzIcwT4FaSCcNH8g00xsZxHDthdIQtkLeh1LQm3gznmoHBmed9y4C7+8kyHp23bYQFT1x3Vo6a0UZVfVVTgFlYFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402428; c=relaxed/simple;
	bh=i1BCVUMUegIE2FpzIVV4AW3zVYMJT+2JCdkA+tqNM6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZGN1xvk40tR5rps8kvTWLs/4y0e3WYF45M92BUEh4MBwCveCOM7XaiWLcHXwERkLqG/8C+SzT5d7MSxKWbmudM2EInrCniEq35e3nzi0uGpnQqKd/5HgOGOML9NZQUAJiaHnK3dl3YgBa0rdDLQ1tKKpYa/w11aLIRgZlX4/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiZh0ngD; arc=none smtp.client-ip=74.125.228.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiZh0ngD"
Received: by mail-ej2-f9.google.com with SMTP id a640c23a62f3a-c2630e38cffso208494466b.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789402425; x=1790007225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSx+lGXUemg9oTuBHvdbjcBwszRorSqIQH/RKl6XdGw=;
        b=LiZh0ngDqAArEnfeK4sAUqiec0VNohs8ajbQbvfPnMcGwZG75dLxpaHKv1N7VrQZdE
         rPCbzgqbNaxAJSFl3S/nGJ9iPitV66uQpi7H+JDXMgCqETsvRb0ePShlsk3X+e8i1jN0
         Chx2T1viRFGI3ndEig9VckvLoySlU0BiCwD0uCelmAOnAjmV3pIqKkvNVYjSphx4NEjV
         0KzqSiknQ9lBRVkMPKGL93NdAvZwFs1r6/fCPgNLqeUN4zLzgAYYve0aXVB2fcdOXaME
         xl/f1kCEizH7ZVuuyyuiFiDJ4XifvtmMAuTD3RmtDf4Ri62iNtiRpBLXD+o2Gu4iFjYw
         A2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789402425; x=1790007225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSx+lGXUemg9oTuBHvdbjcBwszRorSqIQH/RKl6XdGw=;
        b=LsEIjSgXqpUtqPjgqDuQJvd4cULYsh5OTFjQWgAhZN8lMKGdWHZKjVy4D3M0/XKrNn
         BaC6AfTK7V3hMwwMNBCBjF/U7JfVa2jfb7p5lgq5d40VlMYPHMCNXW7vZj5JiJ9iTcgf
         YtqJmGpU96jIEYCeAmG6l0KF95RjavSriP+0hEOtWnlmujJY/GHu+BG1G2fiIpO5ZWwE
         hlLvHUASen9Ricx96Z/SN5jsB31LD47IIjzyliHrAw3qURXAnyjQeJdEZigqRi5JDMsV
         s83q/zIng8asYK7yGJgWAFF5ki9VP67KDQIUeiRKCARHK2UuTouy9/f8D+TFhgErQGL2
         pwfQ==
X-Gm-Message-State: AFuF++kJG+wiZwct/rJR+XDJf8xFe2huJcHdlEh/zSiaetVEKZ0odjn5
	ajeBYEK2MZRdpvr6eSl2HPtt8N9/TtFyg1n0QCLqZ9aMEVjkY1WaKa6GZLmd8jUa
X-Gm-Gg: AYBFou21Q1uM5bQAypuPuh1SISX7yIfYx8RZt8O7+4eDltTmWEbm6HrRh/3Un6aZm6h
	4lf5db4InQEJFQ4O/fGM7lZgOPrIV8vAABQS4dCpwvPULkfmlsb6CDUIb7oAiGh4YF+re3V3h4J
	BXVpAOdphb9OU4AOcCLHnBfzm26tF8TsgFnoqng6shI5qQdoH4kpRNB4vdhjobPCWJUpMbjtWDn
	K4yloOK3MMwcHe7VA5JeXZmrsKUmZ5YQT8kTaD3HeWplG0pH+55AUD9F9x7Ni19E5SqQG9Xgumf
	jUVdQGg+lOMaaxRypyDdPjLGN6gyXOhfJA++OlNFtnLIfCNibrcvphXS/HgRTulX1aYaUs+YkIp
	w+of4YlE1N1vOT+djgAJ9ibADAX8L70Z3woyKaF6o3eZMHADjVHqW2S0TLL968UOojV5eQoURTB
	3fe3RdhUTnd6XAm5gs8OL8PMa3NOM3iGRUXdnvv8MhyRMQuVhfA1ZWS7G057PE7GoR6qGxpzyio
	QKgpwwmo1n9V0VtIYmtv8I9+WcFSkGu2vEoQOtUes2/P+z3cTDi8L9SRst9gBXHNQlNpFJN9rDw
	U+jR6n3SKmxnsQGwmyjtQ1+cWeSKyNDr1q8B8g==
X-Received: by 2002:a17:907:9806:b0:c29:4503:35a9 with SMTP id a640c23a62f3a-c29b874b239mr214204766b.44.1789402425206;
        Mon, 14 Sep 2026 09:13:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966026e2esm454190366b.19.2026.09.14.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:13:44 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: Cover frame changes in bounded loops
Date: Mon, 14 Sep 2026 18:13:38 +0200
Message-ID: <20260914161340.3419141-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914161340.3419141-1-memxor@gmail.com>
References: <20260914161340.3419141-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=memxor@gmail.com; h=from:subject; bh=i1BCVUMUegIE2FpzIVV4AW3zVYMJT+2JCdkA+tqNM6g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuFyL+t6j7eXg8jyuYt7WJVaNF/8jLZsSbX+4tEQ6ttU UWrxfaOEhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATMQyhuF7xI9IMbUJm36mCEmy 34tcmOQ7n3vadhkONsPKtekiF8sY/heJMnLLPOybO+/MdKdHwus54y9uqtT55f19ovii1DCFUFY A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add two finite loops whose progress is represented only by changing the
frame number of a stack pointer. Each loop first reads zero from the
caller's stack, switches to the same offset in the callee's stack, and
exits after reading one on its next iteration.

Keep the pointer in a register in one test and spill it in the other to
exercise both regsafe() and stacksafe() during exact state comparison.
Force frequent checkpoints so the tests exercise infinite-loop detection,
and check that both programs return one when run.

Without the frameno comparison in regs_exact(), both programs are
rejected with an "infinite loop detected" diagnostic instead of loading
successfully.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_loops1.c     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index d248ce877f14..f8b7ba1bf6b8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -303,4 +303,70 @@ __naked void maybe_exit_scc_bug1(void)
 	::: __clobber_all);
 }
 
+/*
+ * The loop reads zero from the caller's stack on its first iteration and
+ * one from the callee's stack on its second iteration. At the loop header,
+ * only the frame number of the pointer in r1 changes.
+ */
+static __naked __noinline __used
+void loop_stack_frames_reg(void)
+{
+	asm volatile ("*(u64 *)(r10 - 8) = 1;"
+	"1: r0 = *(u64 *)(r1 + 0);"
+	"if r0 != 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"goto 1b;"
+	"2: exit;"
+	::: __clobber_all);
+}
+
+SEC("xdp")
+__description("bounded loop changing stack frame in a register")
+__success __retval(1)
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void bounded_loop_stack_frames_reg(void)
+{
+	asm volatile ("*(u64 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call loop_stack_frames_reg;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * Exercise the same frame change through a spilled pointer. All registers
+ * at the loop header are identical, while fp-16 points to a different frame.
+ */
+static __naked __noinline __used
+void loop_stack_frames_spill(void)
+{
+	asm volatile ("*(u64 *)(r10 - 8) = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"1: r1 = *(u64 *)(r10 - 16);"
+	"r0 = *(u64 *)(r1 + 0);"
+	"if r0 != 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"goto 1b;"
+	"2: exit;"
+	::: __clobber_all);
+}
+
+SEC("xdp")
+__description("bounded loop changing stack frame in a spill")
+__success __retval(1)
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void bounded_loop_stack_frames_spill(void)
+{
+	asm volatile ("*(u64 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call loop_stack_frames_spill;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

