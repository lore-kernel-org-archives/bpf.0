Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339AF3F7A9B
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510827; cv=none; b=kEBKJ8dEGKra16eCNpwnjWiJFDt+DOytiyLMxlb0ULluyd1WL1ajdW+F56xqXi22SHBgn5iFUrs0/nMgUy4tUP5NAxZr1cP4I5NqUzcNMCSwLcReBIYW5T/mBXAqOYx0vGC7fHqdNNS1KcJkLxbUf+Kn4ZJ04IyWJxqxQlf74Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510827; c=relaxed/simple;
	bh=Kbq/5Y6/K0I38/VGWvmCrHZVYXA61WnjmQbU+4aDfzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJFX3HWTdLoO5jP9Wu5/g2z3aAk+rWS9FrioayfL9WJekF0CjZjSbq1ohICbjMWNfbq28umJS9mkcjwb7vWQpdvfssxdhcTvyShXWWH6B9FVlb4U4R3d6Pp31h7qaIOap/NGfumtniLuaSppRB7BkLR47ibdmIB07KT4lEX/Uzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAI24Mt+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAI24Mt+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so1779414a91.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510825; x=1789115625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVR3wWJmEZHGLx0diAbkmeNaZxYOBSxuiyZgplyz7gI=;
        b=pAI24Mt+rdth7753JNOuJkP2d/k3oLBFHd4ITfScP9WU91IaDR0UprF7c1k46skLqQ
         cZaXhG7qF8M/SvdZ3WJOTqjDAgbqx7d1g3SrPNXEyrLOgDOjI6g+sZyZH0t9cAVvrEaO
         4QehMmLcOlgS6I4xZmnMxG5V0UzGkVZmTBdfyV6dmN1wBE/c/zm2wW7hEjZ5HXZUNuam
         AMsWOYSaT7AHNcft1R/e5nLZXdoPXwrBJzpXnl+RuCCvQS4alo7JuoOBwFzygTZ825Df
         gDYpaWdB+05N/vUL6QcCI6x7sj4dpore2eHxo2dj5wMWDmJnW4XXvD1X//dZ0sMiFoJ1
         RQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510825; x=1789115625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVR3wWJmEZHGLx0diAbkmeNaZxYOBSxuiyZgplyz7gI=;
        b=hoKilKuJ3aW8cEqDbwdE9h/w7IbqNtf4uDpZz0Q2Z20Gku7j/fUuEMIuvJyKSQxO1N
         uENfzXto2ZT4nTvu8FUD5ZyoBXV74Hu0XKcMr8A6TA9rptDU3XVeOdlumfuqMEOp2sfI
         ImtWpUiE1ek66m6+dBlyTu5L3sltIrJp7Uf4yQWxOIc/QVUkKUSezFVovMv6C+H5HQXO
         gUPmPF/BdwMuNU2SXFLH9X1WspeTfAvshSArPesnH+SUwhMhTn4QpCL3C50+d6JdLFFr
         kc91AD87RuG0VFU6s9biB+mEplks04mrD/RKW86W4zLUXD9SreRNFRIaFZM9vKIVfiif
         Qu9g==
X-Gm-Message-State: AFuF++niTXbyC/KDYhO1+17su2tWeYFAKC6Q3cfPXJH2oMnhS/XNFD4U
	9G+X3Ab69KFzST2R52hBTAFuSGTDyQxRdG8xWhYFohj5kooWYrnZRyHFNj1UTkWEbpQ=
X-Gm-Gg: AYBFou2onPO2j5iDhYga4hdqvCGzEYDSoE4hMi2CUrQzxik/F5vsHgI9jgJbNmvT/yK
	5dc/8X2TnDIIRUgpZWGFgJ3gQPh/7nmUGxED6wlFxIO80I/+udcTCm7eEGze/mqucYLYkWPxVjE
	TKoDLO1B751R0TPpuJb6Z4WX41wQv/SJzbZTd1H63ftmQvroALLttpVVrIwMFc+W5JrwpO1mwjR
	CX3ra2IjZYWfJuR8acvxIjEaWFbU3Ul4istoIZNm1So9gf1J0livdOfz1StCER3eXvPwJP3ostZ
	T0u79MqAE3oALte1oddUsWKQvkVPu0Zxk03oVCYMRQP/ydTkR4afa+l3xKL+1pdipm37EoRPslk
	c06gTtM5OQTuGynqo1lr94oRGvGgM7evUG+JLTDRSWvjrbKvfunHnUU1bmmdGuxRccfIoifW0ps
	rBe7isEMPtInUKAkcNcvDru/l0C+3OILFp96NI60p2vOzoF2eYL87fIEIah6+5/Q6XqiOOoGsDy
	7tM6JQ8eZsqmVvn/KogBl2BkFO6+q2iFYwVVge4KmY=
X-Received: by 2002:a17:90b:5585:b0:390:84db:888e with SMTP id 98e67ed59e1d1-39b27c8ebdcmr3009205a91.7.1788510825409;
        Fri, 04 Sep 2026 01:33:45 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm9628057a91.1.2026.09.04.01.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:33:44 -0700 (PDT)
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
Subject: [PATCH bpf 8/8] selftests/bpf: no non-NULL inference from an imprecise zero register
Date: Fri,  4 Sep 2026 01:33:25 -0700
Message-ID: <20260904083325.2083493-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904083325.2083493-1-eddyz87@gmail.com>
References: <20260904083325.2083493-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that a register-form NULL check does not lift PTR_MAYBE_NULL on
a path where the compared register is non-zero. W/o the previous patch
the program is accepted.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index 410acbf658c7..3c789c565b18 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -418,6 +418,40 @@ __naked void jmp32_ptr_vs_zero_jne(void)
 	: __clobber_all);
 }
 
+/*
+ * The below program is explored in two paths: r6 == 0 and r6 == 1.
+ * On the first path comparison "if r0 == r6 goto 2f" should mark r6 as precise,
+ * otherwise unsafe path with r6 == 1 would be incorrectly pruned.
+ */
+SEC("socket")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("error: invalid dereference of R0 (a nullable map value pointer)")
+__naked void imprecise_zero_does_not_infer_map_value_non_null(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	/* r6 is 0 on the path explored first, 1 on the other */\
+	r6 = 1;						\
+	if r0 == 0 goto 1f;				\
+	r6 = 0;						\
+	/* r0 = bpf_map_lookup_elem(map_hash, &0); */	\
+1:	*(u64 *)(r10 - 8) = 0;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == r6 goto 2f;				\
+	r0 = *(u8 *)(r0 + 0);				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
 void kfunc_root(void)
 {
 	bpf_rdonly_cast(0, 0);
-- 
2.55.0

