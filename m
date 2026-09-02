Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFF3B2FE7
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369260; cv=none; b=o/ghcekDPEBzOGInAXBcUcnEfHZgNlAQxe+r2EK5xBMCnX9n20lBSsTN6BaDEVFvdsHIus201o06S2aM2tpNx8engxFdXyJEsVMZtSmM0FnYtpVtwrL1o/UAHI7Oa8uCB/2RpA1QCHuVFHFKLivEugIS2zdAGvfVdUDC60ByT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369260; c=relaxed/simple;
	bh=n6n87mIgat62GJ3urm+Hj+uoeQJA6xnzQtKm7dOb3Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWivWCAV3P362JkeVCMs6dL836SAMpH5Uod6tZSbYk+NP8h06DceARI/iZjOT8DJp19lzbepHWygv/6w1nb0N24yDjcob2XmFQ/6evbfh/Mw5qYUVzaCPTw/KDGW+kXF4gNDZlJzyouDi0bVui5YbRbfuVb2Tr7hFEG1j9Hz7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLEP0lru; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLEP0lru"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39682983a0fso1730814a91.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788369259; x=1788974059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwB+H4WOXSOlBJ694qI9RqSZG/yVRnBWY2eGsKDn274=;
        b=qLEP0lruZcl8+nFUpXrNjqeV1uYVBuOvhOzpYcyxbg/e7w6zDhrCVksYF4xl5CHf1N
         YoAgxamR3w5OfKS9Ri2gr2vmYgKNK3MXSZEuDuxtxUVF+zPXJiO7MVO7owiLxd5aJrdg
         WuFzK8F50AWJLl/8QtgBah66TPFYYZMnGxn1+qzCNJhlDIguLoAAHx4gUXXtBjAtrDRK
         oAhJzgX1fSdaVAVhso7e0D7oF2Mzb+EZSihb2yF6um6gsTKgrdPKs3f4GYVr+hQbzkjh
         HAstca5yGITD8Qx3rsM5G8waGuX1LDNEMVDMFclwzPh5PSYGMSJbuG2iNt+co0E4uUcU
         KXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369259; x=1788974059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FwB+H4WOXSOlBJ694qI9RqSZG/yVRnBWY2eGsKDn274=;
        b=dUt8OIvCeHZpmk0b+qOcCGl2ZxO6iF8HEGqqX5Dass5HdK5DAS9ObJeRVWyWIyoO4q
         m40iCtn9XbTBp/DNy94DeP/utCR5hEv9Xt1WujeUmrB3eMl4EW1RFVD52YDUxQZdW5tI
         eoK3Vcj8sN3xrI22Q9KWOpVgg1Ff94ftY1v1uk53XyE7//rUrq9PYDnZ/fYlp0EkkqHI
         Gsb7taofPUuvOm77qVKaOy2LVFhU04GauMuLt5M7d0Olg7bY1en0AHndZazOar2bJNEW
         mFIUGCe0dKRqbJcI5EyD3xfxGIVFBj6dv6NA5KyypJLnaZIwz5d4oP+kCz1B97chd+Qm
         HIpw==
X-Gm-Message-State: AFuF++l2NUgLD3BjClyF9D9e3863o5s5kaEItKwhl6ZGz19ilPbKHvTW
	GVUKStGbkTMtNFrXj5FOkM28H3yRLQrOHrrmWFKSoyydGV/9Nzk9w7rE5NapeA==
X-Gm-Gg: AYBFou07rBGDLnkOP1FMCRcLJo/hT80MUzk7tDY9JCLOabIbfIFtfZ35WyFycR6cwm+
	e3QEshV/F1A8+CZC+4K/WIlp4DtjGct3rV7hzjRY8BBajw17fKdGoS5xYeXD0k7BQIXXijEJeQY
	4JgSqNbOp4QJZ1+votEIs/Tya5oMOWfCfDG//KzZvuHITG1IHO8rviL6lRzmJFZx/zWpLjRVQfj
	/X29y+bBe0R0Czit8UxgmEiF0fks56DNzIqE7Lt1Vl4GT5yvb/I+vo5wjd1BGDnjYn09s1sqMLq
	3a3T3pt6k9ukLfWOGRAyS7MSw7tG6HhFyp+Xj0Lj2kGPoy3TKE/Z1diq+S+DCyNLRKk3XO0Jp4u
	sE57MLvxqAAdpvoVHXPBn9uk717ZR0eXoWn0nI7Kgn0ZW4pRKnU3Y5bLR+DaMlHPpAYGV7+TjPz
	B5kYaqXH5FydSXs8YrYeMvmVQew34PwnxWDq8v1ApCHu2hIwH4+tZMJlayANkQ7G3kgmhIxkxwp
	rVnZZ4wzNzufJlnMLyfmOa0HCJ2i5LXPaO9ZdX1pZy1L+vMeEwh8swJyPWmO98fr8/LHiX/x4EZ
	OMIR84jU2I9XZN3E7Y05bwSByMnlo+CwBXC4BmE/11wU2AeZ6uAAlCP6LyOuEhAapSfb07eAwXM
	=
X-Received: by 2002:a17:90b:2b45:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-39aee048952mr9688977a91.13.1788369258168;
        Wed, 02 Sep 2026 10:14:18 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d7e8sm343070a91.16.2026.09.02.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:14:17 -0700 (PDT)
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
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Test terminal gotox instructions
Date: Wed,  2 Sep 2026 17:14:14 +0000
Message-ID: <20260902171414.96165-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902171414.96165-1-sidchintamaneni@gmail.com>
References: <20260902171414.96165-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that place gotox at the end of the main program and a
subprogram, with each jump-table target preceding the gotox instruction.
This tests gotox as a valid non-fallthrough terminal instruction.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../selftests/bpf/progs/verifier_gotox.c      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 5b18c9a27717..0e27c2c79c57 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -47,6 +47,54 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
 DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
 DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
 
+#define DEFINE_TERMINAL_GOTOX_PROG(NAME, BASE)			\
+	__naked void NAME(void)					\
+	{							\
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:							\
+	.quad ret0_%= - " BASE ";				\
+	.size jt0_%=, 8;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	goto end_%=;						\
+ret0_%=:							\
+	r0 = 0;							\
+	exit;							\
+end_%=:							\
+	.8byte %[gotox_r0];					\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,	\
+					    BPF_REG_0, 0, 0, 0))	\
+	: __clobber_all);					\
+	}
+
+SEC("socket")
+__success __retval(0)
+DEFINE_TERMINAL_GOTOX_PROG(jump_table_terminal_gotox, "socket")
+
+static __noinline __used
+DEFINE_TERMINAL_GOTOX_PROG(terminal_gotox_subprog1, ".text")
+
+static __noinline __used int terminal_gotox_subprog2(void)
+{
+	return 0;
+}
+
+SEC("socket")
+__success __retval(0)
+__naked void jump_table_terminal_gotox_subprog(void)
+{
+	asm volatile ("						\
+	call terminal_gotox_subprog1;				\
+	call terminal_gotox_subprog2;				\
+	exit;							\
+"	::: __clobber_all);
+}
+
 /*
  * Gotox is forbidden when there is no jump table loaded
  * which points to the sub-function where the gotox is used
-- 
2.43.0

