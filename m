Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401899;
	b=SFTWplQAyurZAObbUpi6zLEnzxwfgE3TNjQYsC1ozYEaLIet54J+WcqSlUyMH7D/NF+B
	 A5p7IzcRItAptJJH4ulEVwg6Lz6Jg8dfZ03kXJuH2s+VlcWYiUB9Z6YdtYvTXFwpjjFZS
	 bV5yhVyb96mL0xnbcs3ZHLcX0vydynQj/sHgqiOVKGKpjpgNT8nE+6SI11LxhUo+8G/dP
	 VJhmLQBbKLsZ7G+MuoBLHz1o2DdASBbunaoyGXJ7oPzuE0+0kKIbK3rhnqV0AtOfNpHos
	 tLm0eu8AS6QN4ZdHGic/ikJAlvZsvsN/jQ+K/KXclxHOjM/XSx4kEg1WJvdD2CcXBew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=2/TV/FJfcgR36II/jBfRgBHTG+gIro3b5Ad/rPOLJ2g=;
	b=0Sz1LcQ9jDPwpQAYOvY0v3iNdKFneWnCyxDx74vKSQZRuEDqKUi34IAzjuOaYHQuSefb
	 qEBl/UXgOlPwe1darpM/Bjxvwy+vnJy+I5Qrqqn7M8Y1V3dBOrKRY4gCPCBWMWuwsObzh
	 MLhyPZ2aDqJ7JbNeQzEBymowLzRaOYzcJZdeQ5DnQXFn1ubyX7t9vR4FMjzX5QEm+K966
	 9HQdbRhrTlyKL78aOssD2YIupIofVLtSZvGNyV7QWVGH07RTkSFdj8Ywa4VtXd8Me7KDn
	 Y6+izRyK60cQD+UnWQ2KfxzE5epsFen+OsXmy8iM43CaC4+WLocp1NP80ucZDIr7c9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cu/wdEqd";
	arc=none smtp.remote-ip=74.125.225.65
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27C606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC27C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cu/wdEqd
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-48e345608cfso928033f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401897; x=1795006697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2/TV/FJfcgR36II/jBfRgBHTG+gIro3b5Ad/rPOLJ2g=;
        b=cu/wdEqdsI7V0qf/XJ1KZMJXowwWDR7j+JrvJVaA4P+eWeofrHJ6uY18yIc2rSXmJG
         bUrEBF+LM87T/hYe4unDpvyHG6vjM5/r7rsjsvEPxzt3HBK13wjpyD1ogX8deK8cLev1
         g6Bdt+uUynueYTeIPrAroR8XYItOQPOJ6nLVgm43tTtk6g1D6OUnUj2xlmdCgcJyt1Gu
         JamyNc2TWJGltQsXUCLO6g9GndInQOexRAbqlL2lqiTMtd+LufM5axq0GjAub1nGplGt
         39rOf/muyUoDVEmbVCeodzsBmEaT4AmEbyKWUQ/uyTgR3g52OL/x+sSdHl8nKNmgWdcq
         B5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401897; x=1795006697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/TV/FJfcgR36II/jBfRgBHTG+gIro3b5Ad/rPOLJ2g=;
        b=bXe9ynlpoEWQ30VD1677hfi3BqLOx0n9R5XDS2YPM4RxxcQJ5l/n6wtoGU7iHWloB7
         THchphVD5u/YZgeNn+cSAWRevKW+SkmsNHkBejYhDYfoKcF8opoxyD6MUUj7RrA0SuQ5
         i9DwR2YHkhrQ10RAfhh/NV/du6yTz5Icrg2kdjtDp85t8ymwc2ty2wvb76UpSxhx24U4
         5wRjmIGNbs6qtlaBoTnI17Xcuk2zbECWMkuIq9KtN2tDSX5Jr2C3RYus7dJwNPOMrS7V
         IBHFrgHuVAI96zmWxt1MM0KuNRM8aUlCI6KAMJc3iIoOSbq5vgvPbUsjBZxEwCCZErTm
         6vKA==
X-Gm-Message-State: APuU4Z/CI89xqCjciUz9xhlp3k/+u8TBHTpRUN+Dif/YxEy6MFFQ8z0/
	FSC0bF/dz5u4rx2fSM0CgB1J2HnqwCMHDmJt0eVcd+FHcEzyft3s6EFBV6q44sUPxnc=
X-Gm-Gg: AYBFou3OILj62Tn9Aq3xAyqRKePFfMaTOb2GsT8do3JOnbAEKkk+6gqQOYi76t2BvRN
	fH5H1psvBgnzNTj0b007mZjqZkgsF3dqSM4diKtKa2d7dh+vmMCtUkPqzQlDcn+0dZCGBoaDmah
	/EI+LlyzDsNDNUstqmS59M/B5QcvHNBYhAzF27K/0IXGmTzvttateXsAPuIgb1drIqeGmKcEMnb
	9fobVAVaj7Mezs2E3SXowvIneKDLZrW+WLF5pdHGH5jMHXVnJQXlnLM4kKwWM8n3DC8VA363n3N
	4oqXrVZH2YhABKE5YcFwksfaOUwZ1xNCrP2v3ZM88DJJUdEtqXIWSLFSjrdopHaNJ03S019IBZV
	HrIzyZ6HnRAVX1bIJy208zS8J3IEBZlT78I7KQSpcSFyrMTZ3Nx4Q9gcHif4V7N+HClV8vbmZ5M
	M8EDGBtwN+QazmdbLBemmmb6rhcN0x1vffr2KFK+BhVAMJHN9VwB1zZ8UdBw46IIzXiGNTYWsxs
	QsykedY39i1rVtgwMndp8kn1Neb7KTh5HK7c0CDu/cnoh1PVSXjZ7k8EU8c1Epv+979WkoJYdOB
	eka1l1QPRspSXTk3YUedAir9CAgYNyWdgIhBqutWA2solBK63taJn7imKmjVn3+DZ9W+WrMcs8V
	lpl5yvKb7fvN6EPRy5lTWT0JexCfuzzwQrhdDOFcpvQBlWN+tWBpzf17jfTwG1SMzf6O0
X-Received: by 2002:a5d:5d09:0:b0:499:81db:47a3 with SMTP id ffacd0b85a97d-499c7271480mr4362225f8f.11.1794401896966;
        Wed, 11 Nov 2026 04:58:16 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-499823761f5sm5858297f8f.2.2026.11.11.04.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:16 -0800 (PST)
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
Subject: [PATCH bpf-next v1 29/29] selftests/bpf: Test callee releases through callx
Date: Wed, 11 Nov 2026 13:57:27 +0100
Message-ID: <276f6604b7a03c60f723420be77963572472a982.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8719; i=memxor@gmail.com; h=from:subject:message-id; bh=NfDwBjx9nL6W69PR2yV2AZAr7niYlQF51VnRZFp6VhY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzNKHNztnBvK51rO96uook4xan2jnE6Hh3J3+1dtlc X/5fuOOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATET8GCPDBZ9rp+afPVa6p/sj U7Pa3F6J0xlhM9O4/KN8vW7tDL+tysjwXPFh6YWE1M29/e9Tf0lLZUpaGrlaTg5mNJIMPWLy6So LAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a program to exceptions_cleanup that keeps a record in a hidden slot
and passes it to a callee through a function pointer. The caller throws
with the record in its slot, and the callee throws before and after its
discard, when the slot of the caller is already cleared.

Check in verifier_frame_desc the slots and instructions that this takes,
and that the caller clears the hidden slot of a lock before a callx to a
subprog that unlocks.

Add a program to exceptions_fail in which a callx can call one subprog
that discards the record and another that leaves it with the caller,
which keeps it in a hidden slot.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/exceptions_cleanup.c       |  9 ++
 .../selftests/bpf/progs/exceptions_cleanup.c  | 44 ++++++++++
 .../selftests/bpf/progs/exceptions_fail.c     | 70 ++++++++++++++++
 .../selftests/bpf/progs/verifier_frame_desc.c | 83 +++++++++++++++++++
 4 files changed, 206 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index 5ef5f01a6be1..07d3e8cd7046 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -253,6 +253,15 @@ static void run_suite(const char *prefix)
 	       1, "", .param = 10);
 	RUN_AS(throw_callee_consumes_from_slot, "throw_callee_consumes_from_slot_return", 0,
 	       1, "", .param = 8);
+	/* a callx hands over like a call, and its caller empties the slot in front of it */
+	RUN_AS(throw_callx_consumes_from_slot, "throw_callx_consumes_from_slot_caller", THROWN,
+	       1, "0", .param = 3);
+	RUN_AS(throw_callx_consumes_from_slot, "throw_callx_consumes_from_slot_callee", THROWN,
+	       1, "0", .param = 1);
+	RUN_AS(throw_callx_consumes_from_slot, "throw_callx_consumes_from_slot_after", THROWN,
+	       1, "", .param = 2);
+	RUN_AS(throw_callx_consumes_from_slot, "throw_callx_consumes_from_slot_return", 0,
+	       1, "", .param = 0);
 	/* the callee has it nowhere at its throw and keeps it in a slot of its own */
 	RUN_AS(throw_callee_consumes_slot, "throw_callee_consumes_slot_throw", THROWN, 1, "0",
 	       .param = 1);
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
index d6bb893f9da2..13cb476dffe6 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -1730,6 +1730,50 @@ __naked int throw_callee_consumes_from_slot(void)
 	: __clobber_all);
 }
 
+/*
+ * The same through the address of the callee, with the record in no register
+ * at the throw of the caller: the insns in front of the callx empty the slot
+ * of the caller, so a throw of the callee in front of its discard releases
+ * the record once.
+ */
+SEC("tc")
+__naked int throw_callx_consumes_from_slot(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"r8 = %[param] ll;"
+	"r8 = *(u32 *)(r8 + 0);"
+	"if r8 != 3 goto 1f;"
+	"r6 = 0;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"r2 = %[consume_in_callee] ll;"
+	"callx r2;"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm_addr(param),
+	  __imm_addr(consume_in_callee),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
 /*
  * Discards the record its caller hands it. When it throws instead the record
  * is in no register: the cookie has taken its place in R1.
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 9b47345d5fd0..630ae7b9e857 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -561,6 +561,76 @@ __naked int reject_callee_releases_sometimes(void)
 	: __clobber_all);
 }
 
+/* Discards the record in R1. */
+__used __naked static __noinline int discard_rec(void)
+{
+	asm volatile (
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ringbuf_discard)
+	: __clobber_all);
+}
+
+/* Leaves the record in R1 with its caller. */
+__used __naked static __noinline int keep_rec(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * The record is in no register at the throw, so it is in a slot. The insns in
+ * front of the callx empty the slot for the subprog that is handed the
+ * record, and would for the one that leaves it with the caller as well, which
+ * discards it after the call.
+ */
+SEC("?tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("to a subprog that releases it and to one that does not")
+__naked int reject_callx_releases_sometimes(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[len]);"
+	"r1 = %[fail_ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 3f;"
+	"r6 = r0;"
+	"r0 = 0;"
+	"if r7 != 3 goto 1f;"
+	"r6 = 0;"
+	"r1 = 0;"
+	"call %[bpf_throw];"
+	"1: r2 = %[discard_rec] ll;"
+	"r8 = 0;"
+	"if r7 != 1 goto 2f;"
+	"r2 = %[keep_rec] ll;"
+	"r8 = 1;"
+	"2: r1 = r6;"
+	"callx r2;"
+	"if r8 == 0 goto 3f;"
+	"r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"3: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(fail_ringbuf),
+	  __imm_addr(discard_rec),
+	  __imm_addr(keep_rec),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
 __used static __noinline void leave_rcu(void)
 {
 	bpf_rcu_read_unlock();
diff --git a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
index e0456a929126..489cdd897c6c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
+++ b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
@@ -799,6 +799,89 @@ __naked int callee_unlocks_slot(void)
 	: __clobber_all);
 }
 
+/*
+ * The same through the address of the callee: the callx finds the slot of the
+ * caller emptied as the call does, since the only subprog it calls unlocks.
+ */
+SEC("tc")
+__description("frame_desc: the caller empties the slot of a lock in front of a callx")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 3 sites 0 classes 1")
+__naked int callx_unlocks_slot(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + %[len]);"
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r1 = %[lock_values] ll;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 2f;"
+	"r7 = r0;"
+	"r1 = r7;"
+	"r1 += %[lock_off];"
+	"call %[bpf_spin_lock];"
+	"if r6 != 1 goto 1f;"
+	"r7 = 0;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r7;"
+	"r2 = %[unlock_value] ll;"
+	"callx r2;"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(lock_values),
+	  __imm_addr(unlock_value),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len)),
+	  [lock_off]"i"(offsetof(struct lock_value, lock))
+	: __clobber_all);
+}
+
+/*
+ * The caller has the record nowhere at its throw, so it keeps it in a slot:
+ * filled after the reserve, empty at the entry, and emptied in front of the
+ * callx that hands the record to the callee, which holds it in R6.
+ */
+SEC("tc")
+__description("frame_desc: a callx hands a record over from the slot of the caller")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 5 sites 1 classes 1")
+__naked int callx_consumes_record(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[len]);"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"r0 = 0;"
+	"if r7 != 3 goto 1f;"
+	"r6 = 0;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"r2 = %[consume_record] ll;"
+	"callx r2;"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(consume_record),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
 static __noinline void take_slock(void)
 {
 	bpf_spin_lock(&slock);
-- 
2.53.0

