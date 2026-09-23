Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDF4A0138
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190737; cv=none; b=MZLI3Lzmj0REuLM0+lZJcz3UZslSFTnnMGVf2a9Ue1I8rVQ0VezgCngJvUWcRuQ9w1NdDm/2LkRpzulBq/WLhKteoVV0fsCcgBFZqkFDaRRqNGp+qkoNwxCgvdCIRaGwXWUVpVF9zDE1SHQo6oJauhjrPxWbFL5ynEwt7+XhC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190737; c=relaxed/simple;
	bh=Bf0+qIXi0CViVa3lhJxGQ1bciOsau9fqzcgiOoUDWek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm3mKZ/T/n/NuV9Ej2DioVptGQoI+3NrkHDq6DQAakGUo2SspiSsUoBWHECjdqhfPye1mQDhscu/Zjzdop35LKnWGtJXcPSz39rt1MR+Z94ojAZsPEzu1pEzRXKCRjTyHeOD4WR+OWAD/2pnpotefrZiKi5NQCn8OkUMLXS4vAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhanwLCn; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhanwLCn"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so4402955e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190734; x=1790795534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fj98NFi+GQFAbe7aeYOK+YPQ1Gu47rvrcQNGVXCfrdw=;
        b=hhanwLCn7dL2ynpK2I2KxAqaIva4/YU6yCww3DARuxi6fYEjmaNeFkObOM1/5taqPp
         A/XTcQ8b+MJkoAYMxOeiSx25OL6JHn2ZPCuQ48Rlu72RSpUgKyvYTRZXG5MU44Om15IB
         K8MQf0y+9R2erxPZT5A5yTtGtxmeU4Q4al0fPe0Rv1U2poU+rb1hdRw5oOQyCoxV02pH
         4d7i8AbQ98sz5gqsqAdFN093wVqmaZi5h3/S9JnkKZqeBLXKVcdPVYVSrF/mPFKfngiY
         sCKIPGNd8/yF+wJT9ccc7gpEyKNw9pkkx8saYOwXDwXcn/gVa4Ny7gC0tmvKa4mnSVFw
         91Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190734; x=1790795534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fj98NFi+GQFAbe7aeYOK+YPQ1Gu47rvrcQNGVXCfrdw=;
        b=h41e1gIHlTjAwGiCBUTHFZfidQEiRR6Swt7uKeYsdZzlEgXJiEYAdG2wFxH0qpGgFt
         ZXdBloFiPOZwXiGA8FZilguHjNZBdwRKbz2tbD+bZTE7eLkxCc0nx9UOTozW4ilrK1yA
         u/k+kFUS3igwkXJ0bUoPUWRxFlv3b/MIze3CRnExLikZ9z1WCQo6Hf9Ztp7f5ZsLlfyJ
         1aHhX7tdnDjWAtRju8PDzmYltXyll2zwLMDpKLPgr1ZDlvnNMQI4Ww67OxNQsqZOOBhq
         E9HGevdtauRmQW+0K1jls+tEI4Lu/2HIjoUH/QxP9D3/D0h4eIxSgt4j0ixQ7Jwbrr4v
         FxEw==
X-Gm-Message-State: AFuF++mZLJz6u1wQlFQ1GfTD4H2fkyYIFCaZAsGEqhE4RvR45SoE5WZL
	3Mpc+Kz2KauLK1aMX5v7YwUi9mtmJggxRlq0w4jV2ZgbHMj1++fIlKYEvdv1He+2
X-Gm-Gg: AYBFou3moFikfFncpI6OWsIxTVB3BbHgkS9c3W3w8uXT8YKF0k98oIO7aJ4iqWgjmG6
	AY/JpV+5OAtWuG/SFzj1ntbgdTgkaAjf+xsYJSI/K9IUn0CGkauZdMQtqzaEqyIe69N8xp/ErH7
	pvaRWh8nlj5c41ejVUcPcKzr8gNqKOeruJHkr/3XfRaVeleuH+QMecEn9ovom1IArPxT9eT1Cd9
	I8hQLnzlgMT+VdeJfpu39yyHM7Q6XGm4IbGQ9a8WsvCZntr/D5/hglNmQkqkyW+JHAt88sXlNuv
	UNx32SQ6JQMBIVE4mBMQyXeqxOYDX/3k4/qD80xJKFLH9W7O7bhEKosQajg9MgDxoSRCxQeh4Vm
	qHPT3baVuqHv5w5w4pqBKP3A/h0HQal3LewMBN+zHVV+TQCALcKvVhJUuziWKs/cg2gdvj3ZJ6I
	pcutqBQMF2GN1KtWGh+F/L3LrKafdrg8vPDe7eKJ+UigRUq6ivn8y4fsm/KCKliT7196E5Tkh33
	laDsdr7UCeApOROl7hVyjUVZmSIF/pc56aNEKnzWqu67EQpBRyeP19d17b9L87I+mGdEFHdjp/1
	LNlFHLArHkXbdIVS+631sIt00LJTfMUk5zWQAg==
X-Received: by 2002:a05:600c:4e93:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49fe66d1097mr3254325e9.8.1790190733795;
        Wed, 23 Sep 2026 12:12:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm10371185e9.12.2026.09.23.12.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 16/18] bpf, x86: Allow programs 2 KiB of stack
Date: Wed, 23 Sep 2026 21:11:23 +0200
Message-ID: <20260923191139.2816206-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=memxor@gmail.com; h=from:subject; bh=Bf0+qIXi0CViVa3lhJxGQ1bciOsau9fqzcgiOoUDWek=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4s869oIlMW9Wlyn/uKsafF3k/rtX9qbdvOzbI2f79 rwvW5HdUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIn01TH8d5gnYei755iveu+H 2T8mSmXezs9dcVuzX58tqkfsU7FwLsP/oMU2m0vfrxCRNnx532D//0UTP7Pv69lS1G62XCxGvpC fGwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The x86-64 JIT encodes frame sizes as 32-bit immediates in its
prologue, epilogue and tail call sequences, a tail call pops the frame
of the program making it and lands in the target's prologue before the
target allocates its own frame, and private stacks are allocated from
each program's depth, so nothing in it depends on frames staying within
512 bytes. Report bpf_jit_supports_large_stack(), which raises the
budget of JITed programs to MAX_BPF_STACK_JIT: 2 KiB combined over a
call chain, or per frame on a private stack, with no separate limit on
a single frame. Interpreted programs keep 512 bytes.

The worst case kernel stack use of a chain of tail calls grows
accordingly: the callers of a tail call may still leave at most 256
bytes on the stack, so 33 programs can accumulate 8 KiB of dead frames
below the last one, which may now use 2 KiB instead of 512 bytes, for
a little over 10 KiB in total on a 16 KiB kernel stack. The per-cpu
memory behind a private stack grows in proportion to the frames a
program asks for, up to 2 KiB plus guards per frame.

The budget does not depend on the privileges of the loader: an
unprivileged program cannot call other BPF functions, so a tail call
from one leaves no frame behind and its worst case is a single 2 KiB
frame. Programs nested through helpers or attach points, such as a
tracing program entered from a helper of a networking program, are not
accounted against each other before or after this change; each level
of nesting may now add up to 1.5 KiB more.

The verifier state of a frame grows with the stack it uses, up to four
times as many stack slots as before; the allocation is on demand, so
only programs using deep frames pay for them.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/bpf_design_QA.rst | 10 +++++++---
 arch/x86/net/bpf_jit_comp.c         | 12 ++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index eb19c945f4d5..be5fc4ac00d6 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -221,9 +221,13 @@ newer kernels. BPF programs need to change accordingly when this happens.
 
 Q: How much stack space a BPF program uses?
 -------------------------------------------
-A: Currently all program types are limited to 512 bytes of stack
-space, but the verifier computes the actual amount of stack used
-and both interpreter and most JITed code consume necessary amount.
+A: A program may use up to 2 KiB of stack, combined over its call
+chain, when the JIT of the architecture reports support for large
+stacks (currently x86-64); a single function may use all of it, and
+every frame of a program running on a private stack gets the whole
+amount. Elsewhere, and whenever the interpreter is used, the limit is
+512 bytes. The verifier computes the actual amount of stack used and
+both interpreter and most JITed code consume necessary amount.
 
 Q: Can BPF be offloaded to HW?
 ------------------------------
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4a980140b48..d6998c909754 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -4452,6 +4452,18 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+/*
+ * Frame sizes are 32-bit immediates in the prologue, epilogue and tail call
+ * sequences, a tail call pops the caller's frame and lands in the target's
+ * prologue before the target allocates its own, and private stacks are
+ * allocated from the program's own depth, so MAX_BPF_STACK_JIT frames need
+ * nothing special.
+ */
+bool bpf_jit_supports_large_stack(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_percpu_insn(void)
 {
 	return true;
-- 
2.53.0

