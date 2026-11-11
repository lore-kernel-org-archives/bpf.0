Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401893;
	b=c9h4R+xTlB07/b8mUMZMNyxMmpSJgeyxLkDo54mxYYlXBrzfqXgromGNtyZSYT7u/Q4V
	 ar/KS5s0252f8V3Mh0MXEvnySxWpvX28M8HrkaCiSLQmAZEd2cYEB06VE+B2Uk1LBGhoh
	 4axWbNZnqdKOJ8ex3B/fuIQJn3aS5sBuvsJQGWB3KJ6I7lEelAaIflghBP/bOvOQUVHGr
	 uU1b+9/jZRkw5wXRMyxR5yBtDNY0e9QRMVF43E3kCeJVERpjG1EIWpC5FWGXzbjOoaHjY
	 vqxCYtStUd9sFRYagVKx8vHN2P181sii/+BSXAYHknPmkYhc/TiVSEGBg9niIQE45HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=Mp7KYHgMMkahaQEYnxp70dOwOHKojDqd6RoIfNdvskk=;
	b=t9wDPbTNjT/pNRVL/t86Kpe8jO3jSL7zY+l6iUiLSJ44eRS1SW+gEeU1mRcqP8fYpGAm
	 8OKXJwoKq1svu7/21POExVKebqqcdAmG0fa3ja2B1feiqpxEwgj5d3X/EBgxhKtENmCgS
	 GQCO+dgiwAqouO+nb4QywXb7JqDFR5OSCyZVeDd3cnMwfP6D7oE85Fa+nvkZ5c8rOiU+0
	 GJEaPsPxjO5aHkE7F+38CkuKzAJ67l8xuF4rW0+PWYPT7W0QkiouiTEjVREdr7uYIm+7w
	 r1VUTsaersqFNFBULr/Wezz7JikqTYwvbgVVCElR1tkNYF+YFHZLNGb+PEEtTB9CQbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjICmMDD;
	arc=none smtp.remote-ip=74.125.225.132
Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9996606A335
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9996606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjICmMDD
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4a1efc90eb9so2613175e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401891; x=1795006691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mp7KYHgMMkahaQEYnxp70dOwOHKojDqd6RoIfNdvskk=;
        b=YjICmMDDYkPVJRZsR0RgKmjb0/sGrCw5+YzoIVyBm85OXqBNkwJ2HzvWj2zybZk0rO
         qvbX4REZetwm7OzJadt9adz3BImY8f7h0D3VhDy4aWizejbGy+1qnd561jWUHA2AN0nw
         +XxVp3RC0EsYgAYvbbhgq1Kc/EVVJNYT3dDE2EpA2Al+ROw3B0Y4wrJkd8GQ4OjIr4NB
         uHkO0H5/+8SV7mmAaK1KaN8SbtQHSBZimSf9I3gDrXVLN4UBttZBsVVg95BOyeuBX1Pe
         IaiU/8xDikxm9BmBN1ScdBxYMs4R6EEYnI5pXZiuFmAnGKZzjCae8vwt65uMoe55oURt
         a4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401891; x=1795006691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mp7KYHgMMkahaQEYnxp70dOwOHKojDqd6RoIfNdvskk=;
        b=zqJJZPF8/VfasnQ0aN6PCKnO1bbRXvPxuiZ7/Z+KZho1Ux5nXP4tGooNXaL+hFH4Dl
         uAgmyWgluPljzB6grLwd5ldp8Kic6EchK84PO4S+M4MrfeoD4G3LfuUaiJ9A9ypm/4UL
         Du12UomVFd2PHqX83751jpa88zFykGHgR6wlQjtb0vQ87wjkGW4duzGZDrdRBIps9xJB
         GxPZ/pZsznxFqfpZwWpB8pEELUyp3Kj3FWqbqmzIMCzG0j+8epIM7km4Khp82jrHGVsa
         xRzQu5pwusAt9WFZuYp8mwZNfcXDFQatyCQE9ciOxlVK5bx1Z1xeyfSjKf0u2UHsV50E
         mLfA==
X-Gm-Message-State: APuU4Z/6vBLYYvaKN/YUriG3Q6ySOC8AmSVO+U4rX4+D0O0fBzJu52iu
	xm8ZDCn0/htecEXhVWL852NtJA5kqDngFNy6pTdu4O1IHbrXpAzB0jAnTqvFbWINb/k=
X-Gm-Gg: AYBFou32c+hCdybjr2ysRQK0KkriCKYsmmoev78jtKjT6B8ORMMgHZYePaBlqIFB0Y4
	hGD9KVyGTf/EXDOwzjbJOBrI/KkQlrHTxEoWD5GErXOSpVgEoRsj6CVUOf8fUB72ZbQQcEP95cQ
	QxRqSNoF4Klkz4Q2/WXW0CgQYiwtieIBR4smCSUVAJhp+NkdFEh8cewjYXiqUG58v6sKhPj7QqZ
	ekR2bJzKn6ZYUcqVNVfiJyzpV1A8APW6dlQxygJzcIkpyj4FMGbscXPuIlWy7JX+MYr4IPlMyQA
	Jt/SJIStPv8z6NhrI9UVt68mutRvNXsJfsD9u/Lu7VHc5igB56bqwNf7rOD+cBABJUE8OhvIuhW
	vVr6zu1t25RNnq1fyfuAZ5ApuSI0c2UWwG8REwT8HVSfvsNYNpOYNPXFMp4YlkNJn52YKHUpSt2
	5Y8GfxB+XM6ZWk8cBwGGmX0Rf4ObZnfSR9BxoZcRLGz+OEFJ/kFYH7b9jJBfL5puh2pHb5hnohU
	dL4jRafHuVo6Ydjwe7nopIY0yrpKshZAC6k2EmVuiL038jVZZJKdLq28v7caz80B+ClKEHZwPVu
	AB4jl4cmlTRG0U1hdXj5X0dyzTIfCo7R7O7j8bWHDJ+0P1cKeaD/MPOqAABH+EYL2wPrN35WfR6
	jcTi8szOmkFDPKoEmtkBUYhDfz3GE9/SYG34z/iR3+TovWeyjRBqjDHaiqrvPl3SSf1zn
X-Received: by 2002:a05:600c:1547:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4ba0935bcdfmr43575725e9.3.1794401890971;
        Wed, 11 Nov 2026 04:58:10 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951fe22sm62266265e9.3.2026.11.11.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:10 -0800 (PST)
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
Subject: [PATCH bpf-next v1 25/29] selftests/bpf: Test cleanup of handles in registers
Date: Wed, 11 Nov 2026 13:57:23 +0100
Message-ID: <91e13288843771c680577afb263d7f5a1743b4e1.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11313; i=memxor@gmail.com; h=from:subject:message-id; bh=mHjSmhtEeKSRXq1t5hpekc+0kKsIklsP396RaAi+Zx4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzJIN3e9eZ61aJSUjfoM945TxKqUvPTKpzzzE2MuS9 eSyZl7uKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESOz2JkmPrXp8z54a1/Jb+n huqckG7adzW6s5fBY7vkjMLXvPdL6hkZptVJqKjcOHnuiXfSVZ/4nVb8s9fesY7Uv6DG29V/2mQ GLwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add programs to exceptions_cleanup that keep their resources only in
registers when they throw:

 - three records, two frames up from the throw: one in a register that
   the callee saves and overwrites, one in a register that no frame
   touches, and one of the callee's in a register that the throwing
   frame does not save;
 - a record in R3 in the frame that throws;
 - a popped list node, a pointer into its object, in R6, or NULL.

Check in verifier_frame_desc that the verifier reports a site descriptor
and no slot for a record in R6 or R0 at the throw, and for a record in R6
in the caller of a subprog that may throw. A record in R2 there takes a
slot.

Also check that a register that is not read again is still found at the
throw when two paths join before it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/exceptions_cleanup.c       |   5 +
 .../selftests/bpf/progs/exceptions_cleanup.c  | 164 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_frame_desc.c | 155 +++++++++++++++++
 3 files changed, 324 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index 63909280e349..a88cbdafdf77 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -227,6 +227,11 @@ static void run_suite(const char *prefix)
 	THROW(throw_callee_left_rcu, 1, "0");
 	RUN_AS(throw_rcu_some_paths, "throw_rcu_some_paths_in", THROWN, 0, "s", .param = 1);
 	RUN_AS(throw_rcu_some_paths, "throw_rcu_some_paths_out", THROWN, 0, "", .param = 0);
+	/* What the frames keep in registers at the throw is released from them. */
+	THROW(throw_regs_callers, 3, "201");
+	THROW(throw_reg_caller_saved, 1, "0");
+	RUN_AS(throw_reg_node, "throw_reg_node_popped", THROWN, 1, "0", .param = 0);
+	RUN_AS(throw_reg_node, "throw_reg_node_empty", THROWN, 0, "", .param = 1);
 	/* A file and the reader of its dynptr, which goes first. */
 	snprintf(name, sizeof(name), "%sthrow_file_dynptr_held", prefix);
 	if (test__start_subtest(name))
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
index addcc509c6c2..10397d157a48 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -1399,4 +1399,168 @@ __naked int throw_rcu_some_paths(void)
 	: __clobber_all);
 }
 
+/* ---- what the frames keep in registers at the throw ---- */
+
+/* Throws, and uses no register but R1. */
+__used __naked static __noinline int throw_leaf(void)
+{
+	asm volatile (
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * Holds a record of its own in R7 and overwrites R6, which its prologue has
+ * to save for its caller then, before it calls the subprog that throws.
+ */
+__used __naked static __noinline int throw_mid(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r7 = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 16) = r0;"
+	"r2 = 3;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r6 = 42;"
+	"call throw_leaf;"
+	"r1 = r7;"
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
+ * Three records in registers only, two frames up from the throw. The main
+ * program has one in R6, which its callee saves and overwrites, and one in
+ * R8, which no frame touches. The callee has one in R7, which the frame that
+ * throws does not save. The unwinder has the registers of the throw, and
+ * those of each caller from where the frame it called saved them: the frame
+ * that throws holds nothing, its caller's record goes first, then the two of
+ * the main program in the order it acquired them.
+ */
+SEC("tc")
+__naked int throw_regs_callers(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r8 = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r6;"
+	"*(u64 *)(r1 + 8) = r8;"
+	"r2 = 2;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"call throw_mid;"
+	"r1 = r8;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"1: r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"2: r0 = 0;"
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
+ * The record is in R3 only when the frame throws, a register no call
+ * preserves: the unwinder has every register of the frame that throws.
+ */
+SEC("tc")
+__naked int throw_reg_caller_saved(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r3 = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r0 = 0;"
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
+/*
+ * The node that was popped is in R6 at the throw, a pointer 8 bytes into its
+ * object or NULL when the list was empty: the unwinder releases the object
+ * the register points into, and nothing when it holds NULL.
+ */
+SEC("tc")
+__naked int throw_reg_node(void)
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
+	"r6 = r0;"
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
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
index 00a6dce52dfb..5f2425194b1a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
+++ b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
@@ -299,6 +299,161 @@ __naked int dead_spill_at_call(void)
 	: __clobber_all);
 }
 
+/*
+ * The record is in R6 when the frame throws: the descriptor of the throw
+ * names the register.
+ */
+SEC("tc")
+__description("frame_desc: a record in R6 at the throw has no slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int record_in_r6_at_throw(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r6 = r0;"
+	"r0 = 0;"
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
+ * The record is in R0 only, where the call that reserved it left it: the
+ * unwinder has every register of the frame that throws.
+ */
+SEC("tc")
+__description("frame_desc: a record in R0 at the throw has no slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int record_in_r0_at_throw(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
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
+ * The record is in R6 in the caller of the subprog that may throw: R6 is
+ * callee-saved, so the unwinder has it for a frame in a call, and the
+ * descriptor of the call names it.
+ */
+SEC("tc")
+__description("frame_desc: a record in R6 in the caller of a throw has no slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int record_in_r6_in_caller(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r6 = r0;"
+	"call throw_maybe;"
+	"r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard)
+	: __clobber_all);
+}
+
+/*
+ * The record is in R2 only in the caller of the subprog that throws, a
+ * register the call does not preserve: the unwinder has it for the frame that
+ * throws only, so the record is kept in a slot.
+ */
+SEC("tc")
+__description("frame_desc: a record in R2 in the caller of a throw keeps its slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 2 sites 0 classes 1")
+__naked int record_in_r2_in_caller(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r2 = r0;"
+	"r0 = 0;"
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
+ * The record is in R6, which nothing reads again, and two paths join in front
+ * of the throw. The verifier forgets what dead registers hold where paths
+ * join, so the throw reads the registers: the record is still known to be in
+ * R6 at the throw, and its descriptor names the register.
+ */
+SEC("tc")
+__description("frame_desc: a register nothing reads again is found at the throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5) __flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame descriptors: slots 0 insns 0 sites 1 classes 1")
+__naked int dead_reg_at_throw(void)
+{
+	asm volatile (
+	"r8 = *(u32 *)(r1 + %[len]);"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"r0 = 0;"
+	"if r8 == 0 goto 1f;"
+	"r7 = 0;"
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
 /* An iterator is on the stack wherever it is held: the descriptor of the throw names it. */
 SEC("tc")
 __description("frame_desc: an iterator at the throw has no slot")
-- 
2.53.0

