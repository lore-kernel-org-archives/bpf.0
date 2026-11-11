Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401896;
	b=fPOsXr1/8OZd1Q0Qd2QlSeSU4IUwMCMstwHMh86zCmERGvNjb9zMI5euJsIbwBUMrkqi
	 bjIKv2rgEUQNNu5GBEWED1XIih4QaAIjshicsuaxm7Em5sLsevpxBBo8Seh15lLWzzwQO
	 o8pYa8wSEPARUwbBbvVwY5wIlzAIyLWSj0+7L87FClUVN1xNlAebgNqCogBE8mbBTMI/4
	 wyELdtMQgBhKTmqdWFuvYxA5rTeONZac8cvHdlLVVSEju84BHE5BZvu4oT2gdqcC1EVP0
	 Kd/XBT6iSmlFeE0Gajeya1RjxYKXOwQ5Yg+/iWzJuAdbhvwmjnjMd8a5yi9c70vpC3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=VphZZWM+WjkvL0+jroDxlNG1oqOGJ4FgaS/fS4tJTGQ=;
	b=ewLkWW8vU0fgWumwrRAxx5O3XxCaYnpZB//kME7m8M5a+HGaA0l+Mk1YKG/aQ7ROxSxM
	 tx3hYBgkhX3ed3rRefvrxBxCXFk69NallhqMV84yjBa72eQCub7E+OSZGZSfARE9kO/17
	 bujkAkYUlYFTvALq4XzqzZ6PX4wslJt5Cl1JHnSHKCqJf6PDnkaty/QTr7yUmDjF49EtR
	 PMgmx42VpyN8tNX4wSVOu60t8u3VeoCzu7gA8MrZuhiRo8vNA43HAtZ4KOusGgli0kFQ2
	 p2K8ZGgbrMgBSok8cczaqzsB/l8Qi4ydkT6jEu7N+p7hd8i+Q2EikJksaSu+qW4ssAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ME0GaxAl;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE1606A331
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFE1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ME0GaxAl
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-4a35e178418so12008165e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401894; x=1795006694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VphZZWM+WjkvL0+jroDxlNG1oqOGJ4FgaS/fS4tJTGQ=;
        b=ME0GaxAlnLV4yH5e0H8quZKgJa+SdVNn1V9Ulg7TSC5yTpr9Zvbn82v067HrmX6DNg
         Y/916zHCHrvvjewBeN0Wpuzz/ze7UulXDsfLfjQDzbudAqADdXSuZ4DWfAGLc0E/hmcf
         ZlAsmqicwJtz1EsiEe5Zts/aXjQtQwDMKhuFFy1LIZyHqDmiRvVp8ap38gGLaY3zpqe0
         J9H374QlVo6RLA1clHop0AgMb7rdeNxhmVQd0TGYyZ84OxA2L6c9rB+AnE9l1FY0gHrv
         hkJmf8sjNIq+EOYG8Hurbu6R6j/PrqSngSfgLxkCcKQ6x/wWNoWBYHFwJr4KGB1z+mvJ
         ULjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401894; x=1795006694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VphZZWM+WjkvL0+jroDxlNG1oqOGJ4FgaS/fS4tJTGQ=;
        b=hkV0Tfgd9QbA24vD07EHVXKQ0lQqLpzAVDPQZ209ek6ZTacch5+GtsNiFTY8s5fp0j
         +kp7MIXUx/XsmiqZaDL46Sqh5DaTQMyp96OGRx8xZvbBo3+8vOjMNw1Wb+ZmkNGMguCI
         LcB8CxUnJlDIs5xcRMWBrY6z+fpMUXowt0Jr7jnSrprFn//YtGCMZThq9tlFC+uE+QEv
         aetRN/5AofCOOLBuLhoDdaXtDvdOfA1QoQlyx2cxeCJgxWqb2udD2aavMQ4dCexioXvs
         xkq2csDDRAFvpLbaXDOwlMfQgZXlNKbANVQ9OdlIt/sr9VhYUuHbwzgYY/YtFg8AkUcV
         7o/Q==
X-Gm-Message-State: APuU4Z8Xmff+MfaXkBkzOUNvgRkR8V+7FPkBYD8kkBE5ZkS9dkjdZ7Up
	qjoSxKy9Hf80BtTK7ZLHcZDwBdDJQrhC+tTUihbpNdZj2CVTNO2Rac/2vxuaEc4Aw40=
X-Gm-Gg: AYBFou0FQ5gQ93ZDZZ5AOUw/dBshD5dyUGwefc/9fO7c4NKAS0v3JhwU3b4jqxGQgU5
	PuesL0KC2/GG00Cjj5hUD4DrwKLBAS31ErErQRQtFWdHd8121AcFNWvJ5yrGnVobZna3DEoZa/U
	q4XThPUfbsUNyR9e/qXLw5qbgVGCI5qK0xhDM7+iqK6SQO6TF/sp0gL4msDrmV//ackhnKIC1JW
	kALWYVViohwQdAEhgWVGtDeN+iHLaSuAij/2mJVTjeQ/WCTvST7I8d0NS96n7aHMFMbx8UmZcCM
	I8q+qFPoHgG1G0AeFTx7bPKzengKOILBOHUK2R9+UPuU73A1R8QmP2Ha0moXmE6p986G5UQZQwu
	OLEb2C/ssXIuvI/FyadgZnUsjFaw+QCYTheXbutuyK35EgTNLx/oJ3hkZpnncUvK6r6SFt1yjw4
	y+VvUNRRalUdV9PrrbDBNqrxRRYOq2o9Ph7sgQhjH3bJgex3CyJWkimYwmGS1/2n2fkA4sNS1+q
	DogbMWeLsjGJPB4mQZWb3YLFd/UpzsOgPvs3JvYuH0dMh26NJnWYH8TyUA4uCGsb02nsu/A4kOE
	/n4bHTZsvosZGpTCVW9vlRjqkoqgmaagCBEujnQ7rzs7N87iaqSHrnonzAxl9K7QCDrLo1MfgRk
	E/bjOYupDLCRLiZsJJ4iWFxZQKf6x9f1ueCrsf1jwd+/mN115TvOUEeWBvJ/nxaos0TAJGHqCTE
	uopVmqjjYCEdE6XA==
X-Received: by 2002:a05:600c:3baa:b0:4a2:1196:db0e with SMTP id 5b1f17b1804b1-4ba0938a445mr50457965e9.30.1794401894360;
        Wed, 11 Nov 2026 04:58:14 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a4238sm11359614f8f.54.2026.11.11.04.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:13 -0800 (PST)
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
Subject: [PATCH bpf-next v1 27/29] selftests/bpf: Test resources a callee leaves with its caller
Date: Wed, 11 Nov 2026 13:57:25 +0100
Message-ID: <caa9ab914f17420cd8c4bb5c960d18a75d30076b.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7357; i=memxor@gmail.com; h=from:subject:message-id; bh=8hhDTaecXd70XRvkts/3+TI4nGBEqPB6RWSMJA6R0NQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzNIzjW92LYqru2M35d1XB9U9USd2yMjKLQ0ukVR/1 lZq7L++o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPJ72dkmPRKfvvV90VreCc8 n2RvrbA9a+Lvnxu3SjJvXhq6LSTzyQGG/ylFDWuOL/PT5Nv7MHKPtViisl6xvoK2vP/JXw1Vn39 z8AMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add programs to exceptions_cleanup where the caller throws while holding
a resource that a callee acquired for it: an iterator that the callee
created on the caller's stack, and an RCU read section that the callee
returned in.

Check in verifier_frame_desc that nothing is kept for resources that no
throw finds held: a lock that one subprog takes and another drops, a
section that a subprog returns in, and two records that one instruction
reserves in a loop. An iterator that a callee creates on its caller's
stack takes a site descriptor and no slot.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/exceptions_cleanup.c       |   3 +
 .../selftests/bpf/progs/exceptions_cleanup.c  |  43 ++++++
 .../selftests/bpf/progs/verifier_frame_desc.c | 133 +++++++++++++++++-
 3 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index 55624ba4d992..9ba2cd9c8097 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -262,6 +262,9 @@ static void run_suite(const char *prefix)
 	RUN_AS(throw_callee_unlocks, "throw_callee_unlocks_before", THROWN, 1, "0", .param = 1);
 	RUN_AS(throw_callee_unlocks, "throw_callee_unlocks_after", THROWN, 1, "", .param = 2);
 	RUN_AS(throw_callee_unlocks, "throw_callee_unlocks_return", 0, 1, "", .param = 0);
+	/* What a frame holds that a callee acquired for it. */
+	THROW(throw_iter_from_callee, 1, "0");
+	THROW(throw_rcu_from_callee, 0, "s");
 	/* A file and the reader of its dynptr, which goes first. */
 	snprintf(name, sizeof(name), "%sthrow_file_dynptr_held", prefix);
 	if (test__start_subtest(name))
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
index 6e16caee66da..8700349a8f9c 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -1844,4 +1844,47 @@ __naked int throw_callee_unlocks(void)
 	: __clobber_all);
 }
 
+/* ---- what a frame holds that another frame acquired ---- */
+
+static __noinline void new_iter_in_caller(struct bpf_iter_num *it)
+{
+	bpf_iter_num_new(it, 0, 10);
+}
+
+/*
+ * The callee creates the iterator in the stack of its caller, which holds it
+ * from then on: the throw of the caller destroys it.
+ */
+SEC("tc")
+int throw_iter_from_callee(struct __sk_buff *ctx)
+{
+	struct bpf_iter_num it;
+	int *v;
+
+	new_iter_in_caller(&it);
+	mark_acquired(&it);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (*v == 3 && ctx->len)
+			bpf_throw(0xeB9F);
+	}
+	bpf_iter_num_destroy(&it);
+	return 0;
+}
+
+static __noinline void enter_rcu_in_callee(void)
+{
+	bpf_rcu_read_lock();
+}
+
+/* The callee returns in the section it entered, which the throw of its caller leaves. */
+SEC("tc")
+int throw_rcu_from_callee(struct __sk_buff *ctx)
+{
+	enter_rcu_in_callee();
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
index e98d1caf27f3..0faf464d113a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
+++ b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
@@ -799,10 +799,139 @@ __naked int callee_unlocks_slot(void)
 	: __clobber_all);
 }
 
+private(C) struct bpf_spin_lock wlock;
+
+static __noinline void take_wlock(void)
+{
+	bpf_spin_lock(&wlock);
+}
+
+static __noinline void drop_wlock(void)
+{
+	bpf_spin_unlock(&wlock);
+}
+
+/*
+ * One subprog takes the lock and returns holding it, another drops it, and no
+ * throw finds it held: nothing keeps track of it.
+ */
+SEC("tc")
+__description("frame_desc: a lock a subprog returns holding, away from the throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 0")
+int lock_wrappers(struct __sk_buff *skb)
+{
+	if (skb->len > 1000)
+		bpf_throw(0);
+	take_wlock();
+	drop_wlock();
+	return 0;
+}
+
+static __noinline void enter_rcu(void)
+{
+	bpf_rcu_read_lock();
+}
+
+/*
+ * The subprog returns in the RCU read section it entered, and no throw finds
+ * the program in it: nothing counts it.
+ */
+SEC("tc")
+__description("frame_desc: a section a subprog returns in, away from the throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 0")
+int rcu_wrapper(struct __sk_buff *skb)
+{
+	if (skb->len > 1000)
+		bpf_throw(0);
+	enter_rcu();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+static __noinline void new_iter_for_caller(struct bpf_iter_num *it)
+{
+	bpf_iter_num_new(it, 0, 10);
+}
+
+/*
+ * The callee creates the iterator in the stack of its caller, which holds it
+ * from then on: the descriptor of the caller's throw names it there.
+ */
+SEC("tc")
+__description("frame_desc: an iterator a callee creates in the stack of its caller")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1")
+int iter_from_callee(struct __sk_buff *skb)
+{
+	struct bpf_iter_num it;
+	int *v;
+
+	new_iter_for_caller(&it);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (*v == 3 && skb->len > 100)
+			bpf_throw(0);
+	}
+	bpf_iter_num_destroy(&it);
+	return 0;
+}
+
+/*
+ * A loop the verifier walks reserves a record at one insn on each of two
+ * iterations and holds both at once, where no throw finds them: one slot
+ * could not hold both, and none is needed.
+ */
+SEC("tc")
+__description("frame_desc: two records reserved at one insn, away from the throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 0")
+__naked int two_from_one_insn(void)
+{
+	asm volatile (
+	"r8 = *(u32 *)(r1 + %[len]);"
+	"if r8 < 1000 goto +2;"
+	"r1 = 0;"
+	"call %[bpf_throw];"
+	"r7 = 0;"
+	"r6 = 0;"
+	"1: r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 4f;"
+	"if r7 != 0 goto 2f;"
+	"r7 = r0;"
+	"goto 3f;"
+	"2: *(u64 *)(r10 - 8) = r0;"
+	"3: r6 += 1;"
+	"if r6 < 2 goto 1b;"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"4: if r7 == 0 goto 5f;"
+	"r1 = r7;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"5: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
 /*
  * A loop the verifier walks reserves a record at one insn on each of two
- * iterations, the first kept in R7 and the second spilled: the call has one
- * slot in the frame, which cannot hold both records.
+ * iterations, the first kept in R7 and the second spilled, and a throw finds
+ * both held: the call would need a slot, which cannot hold both records.
  */
 SEC("tc")
 __description("frame_desc: two records reserved at one insn are held at once")
-- 
2.53.0

