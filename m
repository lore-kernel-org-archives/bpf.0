Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627370;
	b=LIoqA/W9tFhKUvTCTwISCY4aFufNRT+A79zf9un44rVrnoebyGhWKLUpM5Tlbk/boDBr
	 lDML9Z5YxVTDSBJLmU0DCEAccCRq6Dpd/8WkD8TTgrwAtebCz8wmjFkbZUnJILSJcQPnQ
	 vkZsE56dYYKG3xdvZMAkhrkmkZ+oiEo8+n22it/pRPPfuhev/r1No0hFxK+UmJDKfk189
	 88Bz+7OXT4yCPN9LXAVNBBUfUnO1M2A+lLDe010K6HVaWjG71Ka8x77F7vNdwhnofZcv2
	 HtF0WvojxX2ZPJRj31+APjFiL7IX2RDjkZ7fwHdcxLQTYQLxuo6BvQzBzphnZ+dY6Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627370;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gUxq9Qb9h7W3hDiXAWQ6RwOi7OEQQdgTN1rTz7OGSJI=;
	b=tGJZ++LYpMBd2GgTsDEVHFmHxPch7KUesG0o0/575oOoDmcs73GSL1tnSjRl3zP83kEm
	 dNB4TXJm5dbhI564zIhaOJyMqn5Itq9fq2Rfd6JATD3y5Uke6RCbuvAcFA/Wc7QwUiwLJ
	 1IK0tIJzbl19Ftd2119Nn7n1KOwIQFrfFoZv4/FfqkXIkm58hes0OqyayBvwggd3M9Y1z
	 9C1X/3o/xN5G1h3UBoQO677sZb3Uai+WCFcg5wH13od23ncoSEJUFLMLdn7tLplAH3T1k
	 Sq3lUOGdx7/QkAu5+Kp7Hrq9bWkgsocbt4HFtj4vubOobVMJCdfsK2zZmvcWhoqDt+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=onLgvloj;
	arc=none smtp.remote-ip=131.188.11.22
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB21606A321;
	Wed, 25 Nov 2026 17:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AB21606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=onLgvloj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1795627368; bh=gUxq9Qb9h7W3hDiXAWQ6RwOi7OEQQdgTN1rTz7OGSJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=onLgvlojbAj3GSH8W6ZkJ3k8l04GoZ9MBCxOUXPAoIiA+CeAE5dgqGiZ0VKyeB2N4
	 C5ocosJA4DtBbiu9pYqVuNTvIYw2isU1akc/2fu0Pu2PYp+0tgziqUjcZ6CaxmjkYC
	 wM86Fgj9PCjEbjO9zycMQ2sHq9vCtUQHDT3GAcxjSomxnSzGXgycJnrGdFGbjDk12h
	 5EwiRdMgC1peNMJ6iB9oDhdFaB46PaK0Ibork+XTsrap402y6Xzv11OuWFfgqQJ7av
	 mnDErfSYIA9+XGcVUGygi4HxNKSjdtKRcy14J/U26Vo+GxAfTz2pg3cA7RCMPerFAM
	 jFj/kQhJtDTMQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jZRMX1Zjjz1y7J;
	Wed, 25 Nov 2026 18:22:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:59e
Received: from luis-tp.epfl.ch (unknown [IPv6:2001:620:618:5b8:2:80b3:0:59e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19K8cTl5+ZNAHlT1RFppwze0RFCliPN2Yo=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jZRMT2b7Jz1yp7;
	Wed, 25 Nov 2026 18:22:45 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Henriette Herzog <henriette.herzog@rub.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/4] selftests/bpf: Test the insns that bpf_insert_insns() inserts
Date: Wed, 25 Nov 2026 18:12:50 +0100
Message-ID: <009289699441bb2f2f7d05ade781e8644b23d04e.1795625597.git.luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795625597.git.luis.gerhorst@fau.de>
References: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de> <cover.1795625597.git.luis.gerhorst@fau.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover the cases of the callers of bpf_insert_insns() that no test
reaches:

- The randomization of the upper 32 bits with BPF_F_TEST_RND_HI32. The
  existing tests that set the flag check that it is not emitted.
- A zext and a per-CPU address that do not fit, because they are
  inserted between a jump with the smallest offset and its target. The
  programs are valid, they are only rejected because the verifier can
  not widen a jump when it patches a program.

Assisted-by: Claude:claude-mythos-5-2
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 .../bpf/progs/verifier_percpu_addr.c          | 31 ++++++++++
 .../selftests/bpf/progs/verifier_zext.c       | 57 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
index fd418f27996f..d7fbaa21359f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
@@ -57,6 +57,37 @@ __naked void percpu_addr(void)
 	: __clobber_all);
 }
 
+/*
+ * The mov_percpu_addr is inserted behind the ld_imm64, between a jump with the
+ * smallest offset and its target. The program is valid, it is only rejected
+ * because the verifier can not widen a jump when it patches a program.
+ */
+SEC("raw_tp")
+__description("per-CPU address does not fit behind a ld_imm64")
+__failure __msg("cannot be patched due to 16-bit range")
+__arch_x86_64
+__naked void percpu_addr_jump_out_of_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r7 = 0;						\
+	goto l1_%=;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r1 = %[percpu_data] ll;				\
+	.rept 32763;					\
+	r2 = 0;						\
+	.endr;						\
+	if r7 != r6 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_addr(percpu_data)
+	: __clobber_all);
+}
+
 #else
 
 SEC("raw_tp")
diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/testing/selftests/bpf/progs/verifier_zext.c
index 572017fe28fb..d06a02242c55 100644
--- a/tools/testing/selftests/bpf/progs/verifier_zext.c
+++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
@@ -415,4 +415,61 @@ __naked void probe_mem(void)
 	: __clobber_all);
 }
 
+/* 32-bit def whose upper half is never read -> upper half is randomized */
+SEC("socket")
+__flag(BPF_F_TEST_RND_HI32)
+__success __retval(0)
+__xlated("w1 = w0")
+__xlated("r12 = {{.*}}")
+__xlated("r12 <<= 32")
+__xlated("r1 |= r12")
+__xlated("r0 = 0")
+__naked void rnd_hi32_alu32_hi_unused(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The zext is inserted behind the cmpxchg, between a jump with the smallest
+ * offset and its target. The program is valid, it is only rejected because the
+ * verifier can not widen a jump when it patches a program.
+ */
+SEC("tc")
+__description("zext does not fit behind a cmpxchg")
+__failure __msg("cannot be patched due to 16-bit range")
+__naked void zext_cmpxchg32_jump_out_of_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r7 = 0;						\
+	goto l1_%=;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	w0 = 0;						\
+	w1 = 1;						\
+	.8byte %[cmpxchg32];				\
+	r2 = r0;					\
+	.rept 32759;					\
+	r1 = 0;						\
+	.endr;						\
+	if r7 != r6 goto l0_%=;				\
+	r0 = r2;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(cmpxchg32,
+		     BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.56.1

