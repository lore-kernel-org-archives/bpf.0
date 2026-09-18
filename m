Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC43655E7
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694001; cv=none; b=prjDYiarKRG9zIHiO7/ntKIfyb7hHwseqyr6YFI06SmiW8XHpCmq0gdGaEDgqKUtRaS0BitedYirjJr1TcjDJc/0FoyyTL1OGggKAwL8oQh+SZP5PxK8lOZpbRl3dY03S5qIhczyc/jax0Vy5mIOW9OmzQKtizAJQ1sehhrtuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694001; c=relaxed/simple;
	bh=NWFU+xGwNx1poSIbWTjh5UaoNlkQsKvkA8Ru3tOJfXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlD8L05Wtnp5MBELazoPhZ+jGMyRHUobzrLwo63af9+QlMj1uqO4+I0d8Wi+g+E3aBB7AioMuZAbLycvtng5q79pBsB0tYATYT8IaK8XQNSU5xOczJ4LYcVjfKDyqTwKZAb7LmRaB23kG+7dakL74yxWpOdT5N+T8fBlENfl5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWaNodF2; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWaNodF2"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484349b1961so89822f8f.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789693997; x=1790298797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fz+wsbGUCi12fq1Y50jW/v5SCKSLtLw9yYTP1mgJtFw=;
        b=PWaNodF2iLeUTMGwHw+EkhCT6MVvm6vqTPuRiWNpPCyZ5PoY8qz7jHU/0ug/XBb5nx
         f6gZwwvakO0+B2WYDHnqUbSxh85Cb7a0FBf8s96p/l5gyogAApPV1HlwI3wy0M+IX3Lj
         wwj9tynBDGq0gd2DQj/Ft4tk28S++eozi9yaTI2EBsYS3cMsHViCENlFhJO77YE7fgKS
         hRIR0yafPudyTlBRAv/VLcl08psUgQrwvaa/FCTShqG9bgU1b6En15Xp0MZY1hjtKrb9
         HJCfUhx5uJ33vQUQQikvp+jJE89jNjA/8MNKqjCAXgryRRLUk79LfOCWDi2dPtXsoEkZ
         4u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789693997; x=1790298797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fz+wsbGUCi12fq1Y50jW/v5SCKSLtLw9yYTP1mgJtFw=;
        b=f0Dh/am1HlXdKNFhqhhjLKZZOQgkDvz12G1ZZ7jwEjpjOIApUvmGdK/DbgPFvi1MiL
         u8aH0vepKNIDjSjtQHjymIjXgyO77xHyYryP+CmhVW/iHICzNRFlRMOtjKArQBss4N7M
         PyBxpv5zu0Nz/jcySztkyvVEz2RRN5iY/vkubbygrwfkDjLsi7Lj9njznvqUBigpxCBD
         JW6SjpcIQV+tKDUpraxdakpl08GIkfBOmBfxuoJHWobqMBozjpA4iEcnemihytDjBimF
         pSwVxX6JbVtsaZL+19390owv0g+rMvwVelJYNbG0+IWwm1s9gnN4xZygimaNIANAu2G1
         F/7w==
X-Gm-Message-State: AFuF++mvoNm4EUfIsBudfB2kRpy4B3AjPISQiZI57tG5fQg+TP03H5t8
	fFMVZ4uWT9YtbftE2T45OOR8lnJD74eqYNb6LqAdYtTzJuA3dP3ZYiKYjqxZgGpG
X-Gm-Gg: AYBFou34c00FVtZnQoczDBm18FeEx2VX6cCwPFtBaiACuuJNxZNZrRXPE9hvUVhR4hd
	6ijJ7s+OYZ6FtXcymHxKTTQ4PvvSAtHIMzZ56y6B/qAyCvletl0+P3IMqOcSuEode3+GNIw37MX
	5CGf9QXzEFJeCixItoFJDGHA3+qNffmXG768IPEoz61kqB+ryPQFRX9FPbZuAxW1vGrnceRO6P8
	Qzzxq1iQDtaVcRklm5F9Cu9i1WWavN2s6aseqxzs0FzL0LqtWsgQH0any02hgPBvRLTQwmi9/Q1
	CERwgBUvoP3WNqsnc5Q6QROoT6gInSLnu1z3IakLc1q9mhZ846e2fLPDCCJnl9Z9ApzOWf/jFmE
	i+ers0p8U9t+hXxoGV3p/GfTPs4AnI98tYpixHNilMfAPeuW/zBkuFvziBU0CdCAc0fQlNmmKmZ
	xq2t35w/8PrtXcVEu0GuiMp9JBnSZ0gZh0Tf1Qnp31nCuoJDOL/FLSFTkM5iODeEv38g9unCoFP
	aVIn63P0DtOWBn2hq+BNw97DikzAZgwm+VkOwcSasmEoRkSzDlKHRlOh+ZjJ8lk4ZTJRxXMcyLB
	05JMCbmZKdGv+LsDDiO/qpLCZjZIihIOel/3etzgra3ArtOm
X-Received: by 2002:a05:600c:1c09:b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-49fc57479c9mr9683485e9.31.1789693997368;
        Thu, 17 Sep 2026 18:13:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd232d5bsm115482895e9.12.2026.09.17.18.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:13:16 -0700 (PDT)
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
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover frame changes in bounded loops
Date: Fri, 18 Sep 2026 03:13:11 +0200
Message-ID: <20260918011313.3053497-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918011313.3053497-1-memxor@gmail.com>
References: <20260918011313.3053497-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; i=memxor@gmail.com; h=from:subject; bh=NWFU+xGwNx1poSIbWTjh5UaoNlkQsKvkA8Ru3tOJfXw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvNBLkV3opagXYz3V783qR4govt+YY23jO5VUnX1l5u3 +SybFNoRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYiocTwP8z8c8gNu6gdmnEL RN2mcev/4hXNzbCwq+D8E6MtrCI3jeGftt6K2pKZTg9SI7LsVrx1zioIXvUuY3lsofui113l8uv YAQ==
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
 .../selftests/bpf/progs/verifier_loops1.c     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index d248ce877f14..ada7e1105a95 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -303,4 +303,74 @@ __naked void maybe_exit_scc_bug1(void)
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
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 1;"
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
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
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
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 1;"
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
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
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

