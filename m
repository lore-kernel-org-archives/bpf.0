Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401895;
	b=4nlLdKe88LcMMS/QjKdRkbo/bjVKfYAbEo2DW8I3QYapkR+zKk+lmF+VAN1Ioqe+zG2q
	 fmhsLYnnjlE9OasKJ3L4/fyvAvjJPTfD3fQ8k5SxnRWWVnFCLoIGohNvkGtq3/9Eynub7
	 E0qgkGZJoMJbYJv5kxQeXJKNB9kVHF88v9bgTxmeCCYe7iHQmyB+fRSuRb6wWmU0n2TxY
	 z06JEOlMHz/26se22lqN0stZKZIjA816BOVY343Sh5TRPfcV4DVWJm5OZ9kzhl4r6CkWs
	 NOdJ7c9TagBaMuRKWKfnqf0Zxv+jPvv0xXq0i9FiMicwR/aWYXAgjpL8hSHNlKyDj7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=8OmOt7hMFYbyv7TXNNuXfG4KOTVT0t5tMEhvp8J758w=;
	b=ldodZeZyC6CoU55jRMgJzHz4nsmuUrAo6R4PbJe6zNFVKlbjstQrcLYsuTCHbydyeBhw
	 +AMN2hWMvaAJX3G0aDR2DzVPiYp4ktzr5LwLKam4QNiDQG3IWyrzosJi8A1RFoN/1uX65
	 mqq2tMpZC9dn5ndPu8HMM7JDDoTNBQmIQqiebbjwjX9t50OaFkDqEe6ErNbw//pVXR2PO
	 SH4bIf2JAWdCi+Om7383Zq+o9oqm9hQNDa/xr+H5duOaxsdNuYPVxlPZpzDn1CktLY9tK
	 9HPFz0FIs+lGO8VaMfTEfQpGPZP2aUIGdFuHnh5MDbaxLJiP8A/hbBhTuJvreGATuGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWfYILgF;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC6606A327
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3BC6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWfYILgF
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-4a35e178418so12008035e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401893; x=1795006693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OmOt7hMFYbyv7TXNNuXfG4KOTVT0t5tMEhvp8J758w=;
        b=VWfYILgFI5xDqS8X1IUjkNjkRC9DxPm5ERKFgide6jaqbXW+GTLGM6lD+ElN+BDHzR
         oOmojbCnsoc1plJqBgAqzr37rgeAcxmS8FmftWFxqKN46hdA6SAMZgbgkDa6yUdSzaw3
         /IrxqnroclyAziLqczxpXxlvV3fayYL8qgaNYd4b79A+PSMMjXwz6ex+KaZ7x4gCGdDf
         zcZlO2zs+N5ZWCu8BQ+PyT7G4egvvJYo+hy3ovI0y1nmCJ1TDNe88bpT2c4Txys14e26
         4O6uRxrscxsM92Rl5bkIumyPjzCwFMb/AG5quJaIcX+T5RFgr3nqu91ROY5RGoWuHo4Z
         BAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401893; x=1795006693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OmOt7hMFYbyv7TXNNuXfG4KOTVT0t5tMEhvp8J758w=;
        b=O6TSRTpX6oINEnYmdjW95Rxl+VOE8P1orxyTqavTbQxAsGyJ0asB2Dy+jNzWC0wbKA
         uhuAv8YAL2arjWTH6lY9BAQwHZL0acauKoYkirh9c+ZtT0Kx8/bLN8V4pJ6AE8QayiNE
         o8mqnVICSPIv4mO10mGCacNja9bfJ2B7BbfZhHPxgEXYZ2hWObS2+Uf1lso+zyg+s5dp
         aPsg33VSbMGj9HcCxjN97lR5ND6WPOLM++MveMbVYzaOy9CQgaFRd2uoNUoNJSa337MB
         rG7PpnSiyGUzxDMczT7+1+lpdth2pwtj7Gb0U7hCIVV3s96K4qyim2BYJHF0zjIekJiG
         8kRg==
X-Gm-Message-State: APuU4Z/LnZQZAe8dOTRLs2/2mOjHvDYvoKPzrg0qbJjIEockAeWfC+/C
	y9Tl7EX7djguFzDbAHkR/JmQuQsdld83/sTXQYOYS2Nhelq891ikLEZbrV3FPTKgLaw=
X-Gm-Gg: AYBFou2qhlpafiqlB4mz2n2r4sRnvbTn6kcvZveB+fkjAXlPoN+AxQXu0rJ0gBD8Eyl
	Xf7ZVf2f+r7HZ6uzn1boMGzFM3uDQF9u+HJ9gIJFgkgwotZqmDVSQpIWdsgmtDVVSbsACc31sye
	yhSOSXDidsBBFzrX/REblNB59sVaRyS2G5jWMUt4I35WGNB4FrSZUiseImX4/439ydXVbJ6sa04
	Ir1/A+duQFAkw9wqsRcJSXDGIKFa0NzlJwkRTIYxi2oIoR/8U8IJtcoRM+swrZfY3vrjlfCAjiE
	knrsTLQDhRpemEL6W1u9LBz7wsU/mZxn2mCelyPpeXfnFeqQF7tWpmvmJofNRg5cLLDe+wzWbOB
	YDs984RDwT1IA9PdDTFAoN8/kFQWC9XQ90fZlJwvljJ1UJoU557CZz0c6fHgtQn0EgKR2qBft2L
	pYm/3D0KIzfzpDvuBkZOv0R9XLQmr10R/ouGugLbO+yqBqqrf7ynFOaq0DNsUH7USIPWocSiRHd
	DDIHmW57yGqW4mQMju5EUGqH7Y7ORyWBcVEQTIguPtFcUzRT6QwXy4EoZYoqbKHRJDTLqL+JIkV
	gCDXHUp11lC8O+Gt0DhvGrTViM3IAxxjkYUu1pD/nHR/xLPUWbiNBxBM4hiNHFqjeC/cJ7ZG/Pa
	EDhkLDCs1kxXebqu0BGY2eDp+4U/hCvpsrWGFsqG3rPPYPZXBPNRGdCZ8ZDdWUebw4ab1
X-Received: by 2002:a05:600c:8b22:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4ba0938a590mr41782165e9.27.1794401893031;
        Wed, 11 Nov 2026 04:58:13 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe63e6sm218711695e9.7.2026.11.11.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:11 -0800 (PST)
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
Subject: [PATCH bpf-next v1 26/29] selftests/bpf: Test callees releasing caller resources
Date: Wed, 11 Nov 2026 13:57:24 +0100
Message-ID: <9df09095b8fb9690bb7356ed8b81c4a9d566b3f9.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18640; i=memxor@gmail.com; h=from:subject:message-id; bh=qJxHcBj/aKIqDvV28g1Pf5leXkzT+4UHpxq0JZ07hhA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzJLM+LO8fi4Pz/TbXZ60p73Uz2T5ozkLmjLXV/89p vym8j5/RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZyMYOR4eK8Ojm/WJ+JLu/m X/Wf8Jj3+u33ef132R+fuXVk01Ez+xZGhp+Lazc9/bW7XvZvPH9QCufV8LgdIhXbozffunrBKmP OGXYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add programs to exceptions_cleanup where a callee releases a resource of
its caller:

 - the callee discards a record that the caller keeps in R6, and the
   caller throws before or after the call;
 - the caller passes the record without keeping a copy, and the callee
   throws before or after its discard, with the record in R6;
 - the same, with the record in a hidden slot of the caller, which the
   call clears;
 - the callee has the record in no register or stack slot when it
   throws, and keeps it in a hidden slot of its own;
 - the callee unlocks the lock of a map element that the caller keeps in
   a hidden slot, which the caller clears before the call.

Check in verifier_frame_desc how many hidden slots, inserted instructions
and site descriptors each case takes. Also check that a lock at a fixed
address that a callee unlocks takes a site descriptor and no slot.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/exceptions_cleanup.c       |  30 ++
 .../selftests/bpf/progs/exceptions_cleanup.c  | 281 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_frame_desc.c | 253 ++++++++++++++++
 3 files changed, 564 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index a88cbdafdf77..55624ba4d992 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -232,6 +232,36 @@ static void run_suite(const char *prefix)
 	THROW(throw_reg_caller_saved, 1, "0");
 	RUN_AS(throw_reg_node, "throw_reg_node_popped", THROWN, 1, "0", .param = 0);
 	RUN_AS(throw_reg_node, "throw_reg_node_empty", THROWN, 0, "", .param = 1);
+	/* A callee releases what its caller holds: a throw finds it held, or released. */
+	RUN_AS(throw_callee_releases, "throw_callee_releases_before", THROWN, 1, "0", .param = 1);
+	RUN_AS(throw_callee_releases, "throw_callee_releases_after", THROWN, 1, "", .param = 2);
+	RUN_AS(throw_callee_releases, "throw_callee_releases_return", 0, 1, "", .param = 0);
+	/* A callee that is handed what it releases holds it from the call on. */
+	RUN_AS(throw_callee_consumes, "throw_callee_consumes_before", THROWN, 1, "0", .param = 1);
+	RUN_AS(throw_callee_consumes, "throw_callee_consumes_after", THROWN, 1, "", .param = 2);
+	RUN_AS(throw_callee_consumes, "throw_callee_consumes_return", 0, 1, "", .param = 0);
+	/* the caller keeps it in a slot, which the call empties */
+	RUN_AS(throw_callee_consumes_from_slot, "throw_callee_consumes_from_slot_caller_r6", THROWN,
+	       1, "0", .param = 3);
+	RUN_AS(throw_callee_consumes_from_slot, "throw_callee_consumes_from_slot_caller_r9", THROWN,
+	       1, "0", .param = 11);
+	RUN_AS(throw_callee_consumes_from_slot, "throw_callee_consumes_from_slot_callee_r6", THROWN,
+	       1, "0", .param = 1);
+	RUN_AS(throw_callee_consumes_from_slot, "throw_callee_consumes_from_slot_callee_r9", THROWN,
+	       1, "0", .param = 9);
+	RUN_AS(throw_callee_consumes_from_slot, "throw_callee_consumes_from_slot_after", THROWN,
+	       1, "", .param = 10);
+	RUN_AS(throw_callee_consumes_from_slot, "throw_callee_consumes_from_slot_return", 0,
+	       1, "", .param = 8);
+	/* the callee has it nowhere at its throw and keeps it in a slot of its own */
+	RUN_AS(throw_callee_consumes_slot, "throw_callee_consumes_slot_throw", THROWN, 1, "0",
+	       .param = 1);
+	RUN_AS(throw_callee_consumes_slot, "throw_callee_consumes_slot_return", 0, 1, "",
+	       .param = 0);
+	/* A lock a callee unlocks leaves the slot of the caller in front of the call. */
+	RUN_AS(throw_callee_unlocks, "throw_callee_unlocks_before", THROWN, 1, "0", .param = 1);
+	RUN_AS(throw_callee_unlocks, "throw_callee_unlocks_after", THROWN, 1, "", .param = 2);
+	RUN_AS(throw_callee_unlocks, "throw_callee_unlocks_return", 0, 1, "", .param = 0);
 	/* A file and the reader of its dynptr, which goes first. */
 	snprintf(name, sizeof(name), "%sthrow_file_dynptr_held", prefix);
 	if (test__start_subtest(name))
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
index 10397d157a48..6e16caee66da 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -1563,4 +1563,285 @@ __naked int throw_reg_node(void)
 	: __clobber_all);
 }
 
+/* ---- a callee that releases what its caller holds ---- */
+
+/* Discards the record of its caller. */
+__used static __noinline int discard_in_callee(void *rec)
+{
+	bpf_ringbuf_discard(rec, 0);
+	return 0;
+}
+
+/*
+ * The callee discards the record its caller passes it. A throw in front of
+ * the call finds the caller holding the record, in R6, and one after the call
+ * finds it holding nothing: no slot keeps the record, so the call that hands
+ * it to the callee has none to empty.
+ */
+SEC("tc")
+__naked int throw_callee_releases(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 3f;"
+	"r6 = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"r7 = %[param] ll;"
+	"r7 = *(u32 *)(r7 + 0);"
+	"if r7 != 1 goto 1f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"call discard_in_callee;"
+	"if r7 != 2 goto 2f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"2: r0 = 0;"
+	"3: exit;"
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
+/*
+ * Keeps the record its caller hands it in R6, discards it, and throws in
+ * front of the discard or after it when the low bits of the test's choice
+ * say so.
+ */
+__used __naked static __noinline int consume_in_callee(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r7 = %[param] ll;"
+	"r7 = *(u32 *)(r7 + 0);"
+	"r7 &= 7;"
+	"if r7 != 1 goto 1f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"if r7 != 2 goto 2f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(param),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * The caller hands the record to the callee that discards it, and keeps no
+ * copy. The record is the callee's from the call on: a throw of the callee in
+ * front of the discard finds it in R6 of the callee, and one after the
+ * discard finds nothing.
+ */
+SEC("tc")
+__naked int throw_callee_consumes(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r1 = r0;"
+	"r0 = 0;"
+	"call consume_in_callee;"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_ringbuf_reserve)
+	: __clobber_all);
+}
+
+/*
+ * The record is in R6 on one path to the throw of the caller and in R9 on the
+ * other, so the caller keeps it in a slot. The call that hands the record to
+ * the callee empties the slot: a throw of the callee in front of its discard
+ * releases the record once, from the callee, and one after it releases
+ * nothing.
+ */
+SEC("tc")
+__naked int throw_callee_consumes_from_slot(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 4f;"
+	"r6 = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"r9 = 0;"
+	"r8 = %[param] ll;"
+	"r8 = *(u32 *)(r8 + 0);"
+	"r7 = r8;"
+	"r7 &= 8;"
+	"if r7 == 0 goto 1f;"
+	"r9 = r6;"
+	"r6 = 0;"
+	"1: r8 &= 7;"
+	"if r8 != 3 goto 2f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"2: r1 = r6;"
+	"if r1 != 0 goto 3f;"
+	"r1 = r9;"
+	"3: call consume_in_callee;"
+	"4: r0 = 0;"
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
+/*
+ * Discards the record its caller hands it. When it throws instead the record
+ * is in no register: the cookie has taken its place in R1.
+ */
+__used __naked static __noinline int consume_or_lose(void)
+{
+	asm volatile (
+	"r2 = %[param] ll;"
+	"r2 = *(u32 *)(r2 + 0);"
+	"if r2 != 1 goto 1f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(param),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * The callee that is handed the record has it nowhere when it throws, so it
+ * keeps it in a slot of its own, which its entry fills from the argument.
+ */
+SEC("tc")
+__naked int throw_callee_consumes_slot(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r1 = r0;"
+	"r0 = 0;"
+	"call consume_or_lose;"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_ringbuf_reserve)
+	: __clobber_all);
+}
+
+/* Unlocks the lock of the element its caller locked. */
+__used static __noinline int unlock_in_callee(struct locked_foo *foo)
+{
+	bpf_spin_unlock(&foo->lock);
+	return 0;
+}
+
+/*
+ * The lock of a map element is held at the first throw, where the frame has
+ * the pointer to the element nowhere: the lock is in a slot of the caller,
+ * which the callee that unlocks it cannot reach. The caller empties the slot
+ * in front of the call, and the throw after the call finds nothing held.
+ */
+SEC("tc")
+__naked int throw_callee_unlocks(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r1 = %[lock_map] ll;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"r2 = r6;"
+	"r2 += %[lock_off];"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r2;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r1 = r6;"
+	"r1 += %[lock_off];"
+	"call %[bpf_spin_lock];"
+	"r7 = %[param] ll;"
+	"r7 = *(u32 *)(r7 + 0);"
+	"if r7 != 1 goto 1f;"
+	"r6 = 0;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"call unlock_in_callee;"
+	"if r7 != 2 goto 2f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(lock_map),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm_addr(param),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_throw),
+	  [lock_off]"i"(offsetof(struct locked_foo, lock))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
index 5f2425194b1a..e98d1caf27f3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
+++ b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
@@ -546,6 +546,259 @@ static long discard_record(void)
 	: __clobber_all);
 }
 
+/*
+ * The callee discards the record its caller passes it and keeps in R6. The
+ * throw in front of the call finds the record in the register and the one
+ * after it finds nothing held: the record has no slot, so the call that hands
+ * it to the callee has none to empty.
+ */
+SEC("tc")
+__description("frame_desc: a callee discards what its caller holds without a slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int callee_releases_no_slot(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[len]);"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 3f;"
+	"r6 = r0;"
+	"r0 = 0;"
+	"if r7 != 1 goto 1f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"call discard_record;"
+	"if r7 != 2 goto 2f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"2: r0 = 0;"
+	"3: exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+/* A choice the callees below read without a call, which would clobber their argument. */
+__u32 throw_flag;
+
+/*
+ * Keeps the record its caller hands it in R6 and discards it, and may throw
+ * in front of the discard and after it.
+ */
+__used __naked static __noinline int consume_record(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r7 = %[throw_flag] ll;"
+	"r7 = *(u32 *)(r7 + 0);"
+	"if r7 != 1 goto 1f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"if r7 != 2 goto 2f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(throw_flag),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * The caller hands the record to a callee that discards it and keeps no copy
+ * of it. The record is the callee's from the call on: the throw in front of
+ * the discard finds it in R6 of the callee, the one after it finds nothing,
+ * and no frame keeps a slot.
+ */
+SEC("tc")
+__description("frame_desc: a callee that is handed a record holds it in a register")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int callee_consumes_record(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r1 = r0;"
+	"r0 = 0;"
+	"call consume_record;"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve)
+	: __clobber_all);
+}
+
+/* Discards the record its caller hands it, or throws with the cookie in its place in R1. */
+__used __naked static __noinline int consume_or_lose_record(void)
+{
+	asm volatile (
+	"r2 = %[throw_flag] ll;"
+	"r2 = *(u32 *)(r2 + 0);"
+	"if r2 != 1 goto 1f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(throw_flag),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * The callee has the record it is handed nowhere when it throws, so it keeps
+ * it in a slot of its own: its entry stores the argument there, and the
+ * discard clears the slot.
+ */
+SEC("tc")
+__description("frame_desc: a callee that is handed a record keeps it in a slot of its own")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 4 sites 0 classes 1")
+__naked int callee_consumes_record_slot(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r1 = r0;"
+	"r0 = 0;"
+	"call consume_or_lose_record;"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve)
+	: __clobber_all);
+}
+
+private(B) struct bpf_spin_lock slock;
+
+/* Unlocks the lock its caller took. */
+__used static __noinline int unlock_slock(void)
+{
+	bpf_spin_unlock(&slock);
+	return 0;
+}
+
+/*
+ * The lock of a global variable is at a fixed address, which the descriptor
+ * of the throw gives: it has no slot, so the callee that unlocks it has none
+ * to empty.
+ */
+SEC("tc")
+__description("frame_desc: a callee unlocks the lock its caller holds at a throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int callee_unlocks(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + %[len]);"
+	"r1 = %[slock] ll;"
+	"call %[bpf_spin_lock];"
+	"if r6 != 1 goto 1f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: call unlock_slock;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(slock),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+struct lock_value {
+	int data;
+	struct bpf_spin_lock lock;
+};
+
+/* Two elements, so that a lock of one is found through the pointer to it, not at a fixed address. */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct lock_value);
+	__uint(max_entries, 2);
+} lock_values SEC(".maps");
+
+/* Unlocks the lock of the value its caller locked. */
+__used static __noinline int unlock_value(struct lock_value *val)
+{
+	bpf_spin_unlock(&val->lock);
+	return 0;
+}
+
+/*
+ * The frame has the pointer to the value nowhere at the throw, so the lock is
+ * in a slot of the caller: stored in front of the lock, empty at the entry,
+ * and emptied in front of the call of the callee that unlocks, which cannot
+ * reach it.
+ */
+SEC("tc")
+__description("frame_desc: the caller empties the slot of a lock its callee unlocks")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 3 sites 0 classes 1")
+__naked int callee_unlocks_slot(void)
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
+	"call unlock_value;"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(lock_values),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len)),
+	  [lock_off]"i"(offsetof(struct lock_value, lock))
+	: __clobber_all);
+}
+
 /*
  * A loop the verifier walks reserves a record at one insn on each of two
  * iterations, the first kept in R7 and the second spilled: the call has one
-- 
2.53.0

