Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B143C069
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938282; cv=none; b=F35oUCzOE0HSrphK9N8ETCOX3qWbYHLGI4WIOxyOxvn546X9aLwmdNdNa9ldgCtRIxLTxMonxNa1rDrSViuKJP5oBr9dS7S2chnNq41mPAWjwxLkYvBoqh7oe8YjeyGzIDrv6QrdCts8qtg+AtIJKD4LmqWEFEv4PYzkwP/kPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938282; c=relaxed/simple;
	bh=S6UnhimCtX7R+FxQ5a/+F0qr/QC7/1DBBbdjZtu5z6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2AOID3LVgIbwxWEJLgTqEtKXtU/S/Wxvk3RU9bwGsWlDzajlRRgZOy5Jxic8VcgNhzx1q4d2OS9x4L3eVNXtK3DRb1Yk75djLLCBpY5VJvwCX8IvD8FjmrMVV0Xpg3osrbU+8337Pg5/eqeajPYfsrT832XvJHBeP4W8kGVnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=KphC0Rjm; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="KphC0Rjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=4MUbcv8KpMly/4g74TDkVso+HNwkELAWpp
	4pMnJWOxA=; b=KphC0RjmF401B8VcpEqaddUzsV4gHny+CyX0OISt0RUoW6B1DT
	GjWihYF3U1aS0mx5pkhHHJTgZIbQT47/U0LeKo/cZ6jkc/u95K6j1G+Ue+0EOJCo
	E40E3og1fVNt9BpofMskiGv/sCF0JwOyta84RIdVTIzRh28WnMtjCHHYs=
Received: from localhost (unknown [222.195.81.68])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBXWzJeSrBq5jBAAQ--.2211S2;
	Mon, 21 Sep 2026 05:04:30 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	sun.jian.kdev@gmail.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Reject iterator destruction through fp+0
Date: Mon, 21 Sep 2026 05:04:22 +0800
Message-ID: <20260920210423.345636-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920210423.345636-1-xyx2021@mail.ustc.edu.cn>
References: <20260920210423.345636-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBXWzJeSrBq5jBAAQ--.2211S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWfCF1rAF1xXFyDJFyxXwb_yoW8Ar45pF
	s7uasxKryrJr47JwsrAw48Wa1FgFWkXFyUtan2kFyFyF1rJrn7GF1vkFWDJr9xJrWrAwsI
	v3WYkwsxGr1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF
	1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_CwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jxF4_UUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add a verifier regression test that initializes a numeric iterator at fp-8
and attempts to destroy it through fp+0. The verifier must reject the
non-negative offset instead of treating it as the initialized stack slot.

Check the offset diagnostic to ensure rejection happens at the stack
object address check. The numeric iterator destroy operation is a no-op;
this test checks verifier rejection and does not run the program.

Assisted-by: LLM
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/progs/iters_state_safety.c  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index 646026430e9b5..e5bb9fe6d5e53 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -52,6 +52,28 @@ int create_and_destroy(void *ctx)
 	return 0;
 }
 
+/* fp+0 is not a stack slot. bpf_get_spi(0) used to alias spi 0 (fp-8). */
+SEC("?raw_tp")
+__failure __msg("cannot pass in iter at an offset=0")
+int destroy_fp0_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile ("r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* r10 is fp+0, one byte above the top of the BPF stack */
+		"r1 = r10;"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
 SEC("?raw_tp")
 __failure __msg("Unreleased reference id=1")
 int create_and_forget_to_destroy_fail(void *ctx)
-- 
2.43.0

