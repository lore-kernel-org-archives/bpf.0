Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401891;
	b=cv72ipPwJDY6e0Wc/SGhyd5jUKRWjWdpWdtvBfpopPq5w8Ugd45TvijWKjYC5FUys8Od
	 u/IRX7n1oqLskFyFSSKDKvvxfQexnNrNTIBP9+Inul28sWJPvRRZMdtKdA6tARZjPShvH
	 /xg309AKXV4guE+MpagWDPEhtzDhqWsslRkpb3ZkXvXyu5nyuE1SW3Qt1oKe5oMY06UED
	 5FkUM6NsxQqcvrepKJbldt0qSUHc73BS1bN2osZQVRcrgbwSLaRyRgVMgj/Fz7KR8p6a0
	 C98pzhChddgqzjtDNTHZp6/uSXD1ps0s6Y3vf+kfsWSaH5Q4tSKRt3HBdl4EyscXnVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=DnicefNYhAxjhCtJ6vQ0g/w1n0cd8byYOkbrhL3NuIU=;
	b=qXYNLAqhEGsEj8y+5r33n8dY6lzgCu8EI18FffJh7wpXOOs5RYiY7GSImRKCJD2l2ZdJ
	 soClF3oiwgGeEDotI/XNKkuLkQZDyI2ePbmn+m5n/DJHQtoHQteE1MkSomCsrGv3VsL3M
	 A3kz2+R5orygzG3g1OAFIqBRPrBl5TH4gQ3spB6TkcV+F8eeGlsgGhyvrVk285fkhHH9M
	 4w0nm/otTDeXmgLON8ipwGDSBzL2lKE+Sw6jeqjn5aDwKdV/t85MZjKeyxFTkuB+ShVJe
	 nTB8bpd9WHiVFQ3IMNc1amWHGPr22MQ0fkmecrrYawYz19f3UA9uuiT1iQU44G9IQew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mq+cLZmH;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C8606A32D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4C8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mq+cLZmH
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4b769975b2bso12861765e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401890; x=1795006690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnicefNYhAxjhCtJ6vQ0g/w1n0cd8byYOkbrhL3NuIU=;
        b=mq+cLZmHFUvIs6g1IXJ6HYC7CXgGuvV8v0bK4t8z4/hQN4T52CJyk6M9/OyJqAUnWi
         7DzH5mTObhYq8tdt0DoDtW5c0B3INzJsW3WF1sR08xpRdp8O2AVpPyg/WWacCKhJ1MSz
         v4m5V/rR0m5wEzhOZ60LgnX+mqfTFR29iMQ6DLZ5kAHXvRDvq7r+47xQlldeV/R29u4E
         CL1dJ/MZGTomjkZ1Ee2egbNgMI02L3DAZDkqZWSrpcnHtR/RuxvUy0DRL1zkWJCgvpCU
         nrYlKxrNMYXe/zLXvBwyFI8sE1y0LufdPj0t4sX5fJNO+vuyqOYmopJ5dta+x/K++bMZ
         UGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401890; x=1795006690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DnicefNYhAxjhCtJ6vQ0g/w1n0cd8byYOkbrhL3NuIU=;
        b=S3tJLLHybog+Z4PmDbrc0PgajFC48e9RkTM7VdAXVcm+SczB5FFJAIlVBZvHm9bcLk
         2GJAPW1FiFc6moNEy1aL3DXI4/pbIMzNHcJWex5rgzAdvJN5lSgstv43C+nnreTF9P7K
         VDiZ8x3wrhyMiMdnao4vtJZyU7g7Iwn8kguEwz5/nxQliBRUsThy/O3ARwoYK4O23IxY
         Q0UhNVjigP0uG4yf3xT34TeKcUUrwVfytsZTxmCR/h6KVespKEmiC3GABt+vyOEP4g+B
         KpnAP+0sk/m372LV5py+xwgPlwolnpplJ8+0EU196X1diI2Z5NjKJTDIjit04NXLUEkX
         lP6w==
X-Gm-Message-State: APuU4Z8m+A89VQ8/fpQgYzTeloZ/Ain8/Zp/bsQ8sC2dGRQjG49rI9qm
	kEwzqsY5bisdYLI8v72Da/r2T4FWNovFpGtmk7sriOSQfbIpyZhTqXCuHVe+W9qstc0=
X-Gm-Gg: AYBFou3xplNkule+Kv2BHJBdixY4nd+M8hD6PoY3eExmgvj8QegiBrsYcz+jazdL9QT
	NCn/eqY3T+6vHKzQYFcD0Q6IvBJGtB/fW3G/zgz0R3oTp2x7QGC6v4Mqmtp9kG84ExJA88PgCWk
	V8N4ULagd79lnzQ7s6Tox/ioSUpJXR2GCCTwRin4Z8RZqvCeYdsigEKcYDT7cx+R6UR2n61aLTd
	faC+cNJAbHV17yphZbcr/GT9HwjofYNDwfxYci9xZvxJCpG0Z3UwuwGhu4ouLSOY8j3Ic3OH3Zg
	p9d3HzguQSByPELyU9wgIeqQEqguL2BU4LvFjxRCsdQ5MLsE+MnKzlazXVyQemOGS4cpfnJ7A7J
	OwJ90bI8BwHzgvb1/EjGiwlpnZHnbZ3dJ0jeZbAYbA0/GYOC6hN48ydrhtWFHSlo1K3HVe07C2a
	oJXlTOojeJSqvxSmj6cnErHmZgIwIoGh0KFgDwFsV+5zN/cLwdYdK6efvv5uMiBIehGsmCrETkS
	SjgEG4Bo+i5o/xomRAW4SObQkrB1/i5KFj8TK1bw4t/aZ5XN9cnjCdp4+n+DLP8qUg6OkQWpetV
	IsXzRYnZWFfzo5KYITnKGtRCQ9YFMzYNmxlPRK9GCXv2NjEIsQQKbO+TAXZF7vNMjcHLDGI0UiJ
	ryWqeQMKelRN0Bk1/1zkjthYpy2T/MtR7W09yh0Hm60I/q7oPv0sEXpV59U6fzYdAeuO6pA==
X-Received: by 2002:a05:600c:3551:b0:4a6:b49f:9ae5 with SMTP id 5b1f17b1804b1-4ba0938b879mr39523305e9.34.1794401889543;
        Wed, 11 Nov 2026 04:58:09 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08ddd467sm47510145e9.0.2026.11.11.04.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:08 -0800 (PST)
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
Subject: [PATCH bpf-next v1 24/29] selftests/bpf: Test cleanup of handles on the stack
Date: Wed, 11 Nov 2026 13:57:22 +0100
Message-ID: <794d4fec85f6cc00c6877d1bb32b1972dee1b695.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15962; i=memxor@gmail.com; h=from:subject:message-id; bh=02nhY6vOofrTLFH1OQyKCxSqK7+Sf65qjQw5rO5Bu6o=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzBK3wNq4k4nMPSoLvXO4jbzOap87eNM5tTB7+7ci/ viJHS4dpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmEj4E4Z/to+7ps635bm52vbo mjMSX3oW/vo9IX7Bj4fadzO9O5Q9rjL8s5i6WnVGSpaF7lo2NVOuszwRTm/eR9iF2ktzr/Rn3jy DEwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add programs to exceptions_cleanup that keep their resources on their own
stack when they throw, where the unwinder reads them:

 - a record spilled in the frame that throws, and in its caller;
 - a popped list node, a pointer into its object, that is spilled, or
   NULL;
 - a record that is spilled on one path to the throw and in a register on
   the other, which takes a hidden slot;
 - a callee that leaves the RCU read section of its caller and throws;
 - a section entered on only one path to the throw, which is counted.

Check in verifier_frame_desc how many hidden slots, inserted
instructions and site descriptors the verifier reports:

 - none for a socket released before the throw;
 - a site descriptor and no slot for a spilled record, in the frame that
   throws and in its caller, for an iterator, and for an RCU read
   section;
 - the same for a record spilled in a slot that is not read again, where
   two paths join before a call to a subprog that may throw;
 - a slot for a record or a section that differs between the paths to
   the throw.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/exceptions_cleanup.c       |  18 +-
 .../selftests/bpf/progs/exceptions_cleanup.c  | 202 +++++++++++++++
 .../selftests/bpf/progs/verifier_frame_desc.c | 240 ++++++++++++++++++
 3 files changed, 459 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index b4213036cea7..63909280e349 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -214,6 +214,19 @@ static void run_suite(const char *prefix)
 	/* One call that takes the object on one path and NULL on the other. */
 	RUN_AS(throw_xchg_maybe, "throw_xchg_maybe_kept", THROWN, 1, "0", .param = 0);
 	RUN_AS(throw_xchg_maybe, "throw_xchg_maybe_given", THROWN, 1, "", .param = 1);
+	/* What the frames keep in their own stack at the throw is released from there. */
+	THROW(throw_spilled, 1, "0");
+	RUN_AS(throw_spilled_caller, "throw_spilled_caller_throw", THROWN, 1, "0", .param = 0);
+	RUN_AS(throw_spilled_caller, "throw_spilled_caller_return", 0, 1, "", .param = 1);
+	RUN_AS(throw_spilled_node, "throw_spilled_node_popped", THROWN, 1, "0", .param = 0);
+	RUN_AS(throw_spilled_node, "throw_spilled_node_empty", THROWN, 0, "", .param = 1);
+	RUN_AS(throw_spilled_some_paths, "throw_spilled_some_paths_reg", THROWN, 1, "0", .param = 0);
+	RUN_AS(throw_spilled_some_paths, "throw_spilled_some_paths_stack", THROWN, 1, "0",
+	       .param = 1);
+	/* The sections the frames are in, counted where the paths to a throw differ. */
+	THROW(throw_callee_left_rcu, 1, "0");
+	RUN_AS(throw_rcu_some_paths, "throw_rcu_some_paths_in", THROWN, 0, "s", .param = 1);
+	RUN_AS(throw_rcu_some_paths, "throw_rcu_some_paths_out", THROWN, 0, "", .param = 0);
 	/* A file and the reader of its dynptr, which goes first. */
 	snprintf(name, sizeof(name), "%sthrow_file_dynptr_held", prefix);
 	if (test__start_subtest(name))
@@ -249,7 +262,10 @@ void serial_test_exceptions_cleanup(void)
 	return;
 #endif
 	run_suite("");
-	/* Constant blinding rewrites the program, with the insns that keep the slots in it. */
+	/*
+	 * Constant blinding rewrites the program, with the insns that keep the
+	 * slots in it, and moves the calls the sites are at.
+	 */
 	if (sysctl_set_or_fail(harden, old, "2"))
 		return;
 	run_suite("harden_");
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
index af7c439c7e09..addcc509c6c2 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -1197,4 +1197,206 @@ int throw_xchg_maybe(struct __sk_buff *ctx)
 	return 0;
 }
 
+/* ---- what the frames keep in their own stack at the throw ---- */
+
+/*
+ * The record is spilled when the throw is reached, on every path to it: the
+ * unwinder takes it from the slot of the program's stack that the descriptor
+ * of the throw names, and the frame keeps no slot for it.
+ */
+SEC("tc")
+__naked int throw_spilled(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/* Throws when the test says so. */
+__used static __noinline int throw_if_param(void)
+{
+	if (!param)
+		bpf_throw(0xeB9F);
+	return 0;
+}
+
+/*
+ * The record is spilled in the caller of the subprog that throws: the
+ * unwinder takes it from the caller's stack, where the descriptor of the
+ * call says it is. When the callee returns the caller discards it.
+ */
+SEC("tc")
+__naked int throw_spilled_caller(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"call throw_if_param;"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard)
+	: __clobber_all);
+}
+
+/*
+ * The node that was popped is spilled, a pointer 8 bytes into its object or
+ * NULL when the list was empty: the unwinder releases the object the spilled
+ * pointer is in, and nothing when the slot holds NULL.
+ */
+SEC("tc")
+__naked int throw_spilled_node(void)
+{
+	asm volatile (
+	"r1 = %[param] ll;"
+	"r1 = *(u32 *)(r1 + 0);"
+	"if r1 != 0 goto 1f;"
+	"call push_one;"
+	"1: r1 = %[pop_lock] ll;"
+	"call %[bpf_spin_lock];"
+	"r1 = %[pop_head] ll;"
+	"call %[bpf_list_pop_front];"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r1 = %[pop_lock] ll;"
+	"call %[bpf_spin_unlock];"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm_addr(param),
+	  __imm_addr(pop_lock),
+	  __imm_addr(pop_head),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm(bpf_list_pop_front),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * The record is spilled on one path to the throw and in R6 on the other, and
+ * in no other register: the paths do not agree on where it is, so the frame
+ * keeps it in a slot, and it is released once on either path.
+ */
+SEC("tc")
+__naked int throw_spilled_some_paths(void)
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
+	"r1 = %[param] ll;"
+	"r1 = *(u32 *)(r1 + 0);"
+	"if r1 == 0 goto 1f;"
+	"*(u64 *)(r10 - 8) = r6;"
+	"r6 = 0;"
+	"1: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm_addr(param),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/* Leaves the RCU read section of its caller and throws. */
+static __noinline int rcu_unlock_and_throw(void)
+{
+	bpf_rcu_read_unlock();
+	bpf_throw(0xeB9F);
+	return 0;
+}
+
+/*
+ * The callee leaves the section its caller entered and throws: the caller is
+ * in one section at the call, the callee in one less than it was called in,
+ * and no section is left to leave.
+ */
+SEC("tc")
+int throw_callee_left_rcu(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	bpf_rcu_read_lock();
+	rcu_unlock_and_throw();
+	bpf_obj_drop(f);
+	return 0;
+}
+
+/*
+ * The section is entered on one path to the throw only: the frame counts its
+ * sections in a slot, and the unwinder leaves as many as it counted.
+ */
+SEC("tc")
+__naked int throw_rcu_some_paths(void)
+{
+	asm volatile (
+	"r6 = %[param] ll;"
+	"r6 = *(u32 *)(r6 + 0);"
+	"if r6 == 0 goto 1f;"
+	"call %[bpf_rcu_read_lock];"
+	"1: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm_addr(param),
+	  __imm(bpf_rcu_read_lock),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
index 4a8280bc95cd..00a6dce52dfb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
+++ b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
@@ -137,6 +137,246 @@ struct {
 	__uint(max_entries, 4096);
 } ringbuf SEC(".maps");
 
+/*
+ * The socket is released before the throw: no frame is unwound while it
+ * holds the socket, so nothing keeps track of it.
+ */
+SEC("tc")
+__description("frame_desc: a socket released before the throw has no slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 0 classes 1")
+int sock_released_before_throw(struct __sk_buff *skb)
+{
+	struct bpf_sock_tuple tuple = {};
+	struct bpf_sock *sk;
+
+	sk = bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), -1, 0);
+	if (!sk)
+		return 0;
+	bpf_sk_release(sk);
+	bpf_throw(0);
+	return 1;
+}
+
+/*
+ * The record is spilled on every path to the throw: the descriptor of the
+ * throw names the slot of the program's stack, and the frame has no hidden
+ * slot.
+ */
+SEC("tc")
+__description("frame_desc: a record spilled at the throw has no slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int record_spilled_at_throw(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * The record is spilled in the caller of the subprog that throws: the
+ * descriptor is that of the call, the site the caller is unwound at.
+ */
+SEC("tc")
+__description("frame_desc: a record spilled in the caller of a throw has no slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int record_spilled_in_caller(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"*(u64 *)(r10 - 8) = r0;"
+	"call throw_unconditionally;"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve)
+	: __clobber_all);
+}
+
+/*
+ * The record is spilled on one path to the throw and in R6 on the other, and
+ * in no other register: the visits of the throw do not agree on where it is,
+ * so it is kept in a slot.
+ */
+SEC("tc")
+__description("frame_desc: a record spilled on one path to the throw keeps its slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 2 sites 0 classes 1")
+__naked int record_spilled_on_one_path(void)
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
+	"if r7 == 0 goto 1f;"
+	"*(u64 *)(r10 - 8) = r6;"
+	"r6 = 0;"
+	"1: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+/* May throw, and returns when it does not. */
+__used static __noinline int throw_maybe(void)
+{
+	if (bpf_get_prandom_u32() & 1)
+		bpf_throw(0);
+	return 0;
+}
+
+/*
+ * The record is spilled in a slot nothing reads again, and two paths join
+ * between the spill and the call of a subprog that may throw. The verifier
+ * forgets what dead slots hold where paths join, so the call reads every slot
+ * of the stack: the spill is still known at the call, and its descriptor
+ * names the slot.
+ */
+SEC("tc")
+__description("frame_desc: a spill nothing reads again is found at a call that may throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5) __flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int dead_spill_at_call(void)
+{
+	asm volatile (
+	"r8 = *(u32 *)(r1 + %[len]);"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"*(u64 *)(r10 - 8) = r6;"
+	"if r8 == 0 goto 1f;"
+	"r7 = 0;"
+	"1: call throw_maybe;"
+	"r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+/* An iterator is on the stack wherever it is held: the descriptor of the throw names it. */
+SEC("tc")
+__description("frame_desc: an iterator at the throw has no slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+int iter_at_throw(struct __sk_buff *skb)
+{
+	struct bpf_iter_num it;
+	int *v;
+
+	bpf_iter_num_new(&it, 0, 10);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (*v == 3 && skb->len > 100)
+			bpf_throw(0);
+	}
+	bpf_iter_num_destroy(&it);
+	return 0;
+}
+
+/*
+ * BTF FUNC records are not generated for kfuncs that only inline assembly
+ * refers to, and libbpf needs them to link the programs.
+ */
+void __kfunc_btf_root(void)
+{
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+}
+
+/*
+ * Every path to the throw is in one RCU read section: the descriptor of the
+ * throw says so, and the frame does not count its sections.
+ */
+SEC("tc")
+__description("frame_desc: a section at the throw has no count")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int rcu_at_throw(void)
+{
+	asm volatile (
+	"call %[bpf_rcu_read_lock];"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm(bpf_rcu_read_lock),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * One path to the throw is in an RCU read section and the other is not: the
+ * frame counts its sections in a slot, which starts at zero and which the
+ * lock adds one to.
+ */
+SEC("tc")
+__description("frame_desc: a section on one path to the throw is counted")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 4 sites 0 classes 1")
+__naked int rcu_on_one_path(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + %[len]);"
+	"if r6 == 0 goto 1f;"
+	"call %[bpf_rcu_read_lock];"
+	"1: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm(bpf_rcu_read_lock),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
 /* Discards the record in R1. */
 __naked __noinline __used
 static long discard_record(void)
-- 
2.53.0

