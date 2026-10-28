Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148309;
	b=TnK/D+2VG9uXtzY8juxa9sNrqY0CN6r2OpMr3lsNEjbqTFDnsi98AWzEWc524tR7eUtM
	 pQDkqZuWWnzMcPndYFNP8q14ET0SgJlspvBchC6soeCdegbF/15/7tLWPU1w7fR6HhfMo
	 ENdkW7PmlMuTHgTF7Rm8dpwCfcma8JhATR01OCR1Ztzb1sdrc36qqTeIFukQaFLA8Gfwb
	 ag/SrZvKH34iGCbKmTxUUwWp+012EV76Xef6dvrGu2eDjyZkjok5WzBjUHQZ+cXOt+8HO
	 z4ppblgiZQ5Rq/IV5J8v+KvdUtJqLf9XD07BZJXXKlFnzC/yF3xykhMizEG8PxHXxtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=QmzatCzYHImUcFGCoOViqY60uiMo92rPmsGLzb4hPHk=;
	b=uEzp4QnyWUKxWbJ9XZB4q1XgywlfU3aJ5hI0g8+x/u5J/jgKHzuntUSVATqZsH1LwWUE
	 15hxfG7YfsrIu9OliyVGVSxCsn7Afa6I117jaR2so1l9TQ3WKuDXEwDXIPj0sRh9sWqEo
	 1iv+A4dneG8fP6s9uUTJCKq1GTjMqoyNHdjPXfZyKA2QHexhqc1b/Q4Lrs+HDbHpXKlze
	 nj/sXsX+UFqoP+VzgmlFB5yeV5pm979lbRmFqKkxbhxbuAlOmSWEhnZDSHNmQfhOmtcQk
	 Fwigr7z5TUlqA77Y+kJDUf0KAxkhLMNRGAG63xD2tWRRy7A2vPfdEgBRshKdh+QmMTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Sl/AHa5P";
	arc=none smtp.remote-ip=74.125.225.72
Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF50606A324
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF50606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sl/AHa5P
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48df4afd489so107932f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148307; x=1793753107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QmzatCzYHImUcFGCoOViqY60uiMo92rPmsGLzb4hPHk=;
        b=Sl/AHa5P85wt8Z3pv0jL/oD6fyuJR/ZeuKTjgjShYpxMXLn/Gej8VJb1kMnza6CQfp
         t2BAJXcOFvGlYm33l7HvWqYOp8JPlSPZjQtbFgeTmWZj3S45qYmZBwTYCO4Gh8wxSWpT
         LZ6+rwUxEL4ULELKVJjtqH2UGunnVj/fA2/CY/l+6tN7AsoohgsY+lsUb9YVIi+jlWde
         6Qo2uw7U8lTyxKFd8Xg22kfQmU3vT3Ia1+QAPXmnjV4FAFIElvMARSsEpeATSPPw5fBx
         7yvx3CBwW5W/I/AF5Su7H2lzfIgoPSoxS9e7qs5IvKH2MPhoo9KS+FWmbVV9mweH0PrQ
         ioxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148307; x=1793753107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QmzatCzYHImUcFGCoOViqY60uiMo92rPmsGLzb4hPHk=;
        b=kapac7ZvuRUkVXPaYApZihD3CVz8oGOOamFduSRLEY6nYFS1dpbtKks83SeU/V+h7p
         zEuZxOVWrLKIg3pSb54NX2PjrOyr4hbUSh9SATjxJA1j54k9Cf1chhGeBVN2lwR0UOUL
         24P2TxtHqT2XAg2AB7bOzwpUqyc/z/3rgEbQS4ocAWqIuBY+TXJRYNzWrzpOoS8GA1nY
         qSJ4udJOcZQedZI9HmILPnIueniZFLk++o0wpBTl2AlWwz2whXD62XxLdgK2i8bdb+f0
         VA9OldFNJBjZnWoj7DGeqYEy+oZnLJworgawd0eprG+BeS7MGAjWU/Usz+fmodeGtHf1
         25oQ==
X-Gm-Message-State: AFq9FYId5hDLpp055ovyZ0i5wCjK2UJ2mLOhLjVN+Zi1vkbY42enL/CO
	KrjwPJYv6rhurRzVBZV/NGdevqPrA4DVzcJIXsGNyTfcZBxo6z4Zqt31YASYBi3M
X-Gm-Gg: AYBFou2TQx7kvSsaBSjyY+4ItFvhIPwEMXc/xQX1xg+c5LsoIf0mM99bmxiZaGhK4r9
	EjvhrfV+jzG+5oNg7JCmgsJeim7+yK2s8Q/fOMZPsqIWGeLHnqEYRi2vkz9GNbGW87AaDeUQz3i
	31UNAFkpizt4uMASrdKE+0850i8Tu/qANMiRGk3+SXmpBVcemfUR50CuO4oruxIrKDix5YoYlxS
	5o2K0a6j3m1FChVBOoU1xRmucFgi7iW9RUgHbY/SQfpE41A9T3/sA6FzhvbSaVvH6HldRoFJPnr
	LmkEc6wY0SyTwrr/rz1ht/wYLld+hPkk8eSjPiyr+75zSApIhsUsc59qpyN5v10Z90bWJA8HGCF
	BGnmSkLbzV0SpmT46KNn0rGTHUC+ZT+lDhQb4H7PjdGYVGgyvuUaa8NN/PDiGI1VF4TfkYg8AHB
	zsPT/GisrJskU7bbiGzF+Plrw1YAp0jEIgeaYFeM+kyrB7Yjmm4k16V8I2ttKmnUN2oUkz0LGTe
	J6Zs6kT9BBa+0+xOBHfpIOfIGZIkVdpNOX1s9Umhk654c+iXPcHr7E+nT5w0u/uLLwSfTyYP9AG
	OEi2cGoI/ccm4TewEg8+BePjO7+npV+BIuQx7j3lpXFB3V+gPLONh9UdJl+xw36vpjcTQugwa7U
	p4Si5U1ULl2lnEROhxWg=
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr2291224f8f.7.1793148306866;
        Tue, 27 Oct 2026 17:45:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm25734317f8f.1.2026.10.27.17.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:45:06 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 11/11] selftests/bpf: Test what a callback unwinds with
Date: Wed, 28 Oct 2026 01:44:48 +0100
Message-ID: <b22c7e8b1099de6b60ec5561fcadef26f34527e2.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14109; i=memxor@gmail.com; h=from:subject:message-id; bh=ruqMPNzi/mdBDRDE7qyjv7qzjS/6nh7Zrb72pGyRQUA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh44tk14kvnCM/lZyqnv3B2G7Jn3ObuCX2Ps6w0P+to /Vg9+2YjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwkJJ2Rob0gwHBrcW2kpmqV VvWuQ6/7JP67zf916czEAw9yDm/a8YHhD9ecbdPu/TX2v7b7nvW5rD2KHK7eO4r+P1IVNEtr7Mn 1YwIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

What a callback unwinds with reaches the pad as it is. A callback that
unwinds with a pointer to an element of the array loads, and the pad reads
through it: 6, which the callback put there, plus 41. A callback that
unwinds with a reference it took hands it to the pad, which drops it, or
is refused for leaking it. A pointer into the stack of the callback is
refused as at any return.

The pad knows what the callback unwound with: it adds the 5 of cb_unwinds
to fp and reads the slot that is there, which an unknown r0 could not do,
and the index of the run, which the callback may unwind with, it does not
know. Two callbacks on two paths into one call unwind with 5 and with 100,
and the pad is checked with each: with 100 the read is out of the frame.
A loop of one unwinds on its only round. A helper in the pad, after a
callback unwound on the first of two rounds, starts its rounds afresh, so
its callback is checked and its call needs an unwind_goto of its own. The
pad before the call of an inlined bpf_loop() is reached from the inlined
loop.

The comparator of bpf_rbtree_add() that unwinds with the node being added
gets its pad refused for reading through it, and so is a read of the node
after the call: the kfunc dropped it. What the caller holds of the tree is
gone with the unwind as well, as at an unlock.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_unwind_cb.c  | 497 +++++++++++++++++-
 1 file changed, 496 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind_cb.c b/tools/testing/selftests/bpf/progs/verifier_unwind_cb.c
index 8a3dee4330ac..d9db8084b843 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unwind_cb.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind_cb.c
@@ -11,7 +11,7 @@
  * BPF_RAW_INSN(), so here they are raw words: the code, src_reg = 1 in the
  * high nibble of the second byte, off in the next two bytes.
  */
-#define unwind_goto(off) ".8byte (" #off " << 16) | 0x10e5;"	/* BPF_JMP | BPF_JCOND */
+#define unwind_goto(off) ".8byte ((" #off " & 0xffff) << 16) | 0x10e5;"	/* BPF_JMP | BPF_JCOND */
 #define unwind_exit ".8byte 0x1095;"				/* BPF_JMP | BPF_EXIT */
 
 struct {
@@ -259,6 +259,374 @@ __naked int loop_cb_unwinds_no_pad(void)
 	);
 }
 
+/* Unwinds with a pointer in r0: the element of the array, with 6 in it */
+__naked __noinline __used
+static unsigned long cb_unwinds_with_ptr(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"r1 = %[array] ll;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1f;"
+		"r1 = 6;"
+		"*(u32 *)(r0 + 0) = r1;"
+		unwind_exit
+	"1:"
+		"exit;"
+		:
+		: __imm_addr(array),
+		  __imm(bpf_map_lookup_elem)
+		: __clobber_all
+	);
+}
+
+/* The helper hands r0 on as it is: the pad reads through the pointer */
+SEC("tc")
+__description("unwind cb: the callback unwinds with a pointer in r0")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__naked int loop_cb_unwinds_with_ptr(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"r2 = %[cb_unwinds_with_ptr];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		"r0 = *(u32 *)(r0 + 0);"
+		"r0 += 41;"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds_with_ptr),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/* Unwinds with a pointer into its own stack */
+__naked __noinline __used
+static unsigned long cb_unwinds_with_fp(void)
+{
+	asm volatile (
+		"r0 = r10;"
+		"r0 += -8;"
+		unwind_exit
+	);
+}
+
+SEC("tc")
+__description("unwind cb: the callback unwinds with a pointer into its stack")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("cannot return stack pointer to the caller")
+__naked int loop_cb_unwinds_with_fp(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"r2 = %[cb_unwinds_with_fp];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds_with_fp),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/*
+ * The pad knows what the callback unwound with: 5, which cb_unwinds leaves in
+ * r0, and reads the slot through it. An unknown r0 would be no offset for fp.
+ */
+SEC("tc")
+__description("unwind cb: the pad knows what the callback unwound with")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(9)
+__naked int loop_cb_r0_known(void)
+{
+	asm volatile (
+		"r1 = 9;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r1 = 10;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		"r1 = r10;"
+		"r1 += r0;"
+		"r0 = *(u8 *)(r1 - 13);"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/* Allocates a node and unwinds with it: the reference comes back in r0 */
+static __noinline long cb_unwinds_with_obj(u64 i, void *ctx)
+{
+	struct node_data *n = bpf_obj_new(typeof(*n));
+
+	if (n)
+		asm volatile ("r0 = %[n];" unwind_exit :: [n] "r"(n) : "r0");
+	return 0;
+}
+
+/* The pad drops what came back */
+SEC("tc")
+__description("unwind cb: the callback unwinds with a reference, which the pad drops")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int loop_cb_obj_dropped(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"r2 = %[cb_unwinds_with_obj];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		"r1 = r0;"
+		"call %[bpf_obj_drop];"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds_with_obj),
+		  __imm(bpf_loop),
+		  __imm(bpf_obj_drop)
+		: __clobber_common
+	);
+}
+
+/* The pad may not leave without dropping it: the reference is the prog's now */
+SEC("tc")
+__description("unwind cb: the callback unwinds with a reference, which the pad leaks")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("Unreleased reference")
+__naked int loop_cb_obj_leaked(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"r2 = %[cb_unwinds_with_obj];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds_with_obj),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/* Unwinds with the index of the run, which the pad doesn't know */
+__naked __noinline __used
+static unsigned long cb_unwinds_with_index(void)
+{
+	asm volatile (
+		"r0 = r1;"
+		count_run()
+		unwind_exit
+		:
+		: __imm_addr(runs)
+	);
+}
+
+SEC("tc")
+__description("unwind cb: the pad doesn't know the index the callback unwound with")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("math between fp pointer and register with unbounded min value is not allowed")
+__naked int loop_cb_index_unknown(void)
+{
+	asm volatile (
+		"r1 = 9;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r1 = 10;"
+		"r2 = %[cb_unwinds_with_index];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		"r1 = r10;"
+		"r1 += r0;"
+		"r0 = *(u8 *)(r1 - 13);"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds_with_index),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/* Unwinds with r0 = 100, no offset for the slot */
+__naked __noinline __used
+static unsigned long cb_unwinds_100(void)
+{
+	asm volatile (
+		"r0 = 100;"
+		unwind_exit
+	);
+}
+
+/*
+ * Two callbacks on two paths into one call, unwinding with 5 and with 100. The
+ * pad is checked with each: the second one puts the read out of the frame.
+ */
+SEC("tc")
+__description("unwind cb: the pad is checked with what each callback unwound with")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("invalid read from stack")
+__naked int loop_cbs_differ_pad_checked(void)
+{
+	asm volatile (
+		"r6 = *(u32 *)(r1 + %[len]);"
+		"r2 = %[cb_unwinds];"
+		"if r6 == 64 goto 1f;"
+		"r2 = %[cb_unwinds_100];"
+	"1:"
+		"r1 = 9;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r1 = 10;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		"r1 = r10;"
+		"r1 += r0;"
+		"r0 = *(u8 *)(r1 - 13);"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_ptr(cb_unwinds),
+		  __imm_ptr(cb_unwinds_100),
+		  __imm(bpf_loop)
+		: __clobber_common, "r6"
+	);
+}
+
+/* A loop of one: the round that unwinds is the last the loop had */
+SEC("tc")
+__description("unwind cb: the callback of a loop of one unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__naked int loop_once_cb_unwinds(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_ptr(cb_unwinds),
+		  __imm_addr(runs),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/*
+ * The callback unwinds on the first of two rounds. The helper in the pad starts
+ * its rounds afresh, so its callback is checked, and the call needs its own
+ * unwind_goto.
+ */
+SEC("tc")
+__description("unwind cb: a helper in the pad starts its rounds afresh")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("no unwind_goto after the call of bpf_loop()")
+__naked int loop_cb_unwinds_then_loops(void)
+{
+	asm volatile (
+		"r1 = 2;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		"r1 = 1;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/*
+ * The pad before the call: the inlined loop jumps back to it. Insn 13 is the
+ * unwind_goto, insn 1 the pad: the callback is loaded in the asm, so that the
+ * compiler puts nothing in front of it.
+ */
+SEC("tc")
+__description("unwind cb: the pad before the call of the inlined bpf_loop")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__xlated("unwind_goto pc+7")
+__naked int loop_cb_pad_before_call(void)
+{
+	asm volatile (
+		"goto 1f;"
+		PAD
+	"1:"
+		"r1 = 10;"
+		"r2 = %[cb_unwinds] ll;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(-13)
+		"exit;"
+		:
+		: __imm_addr(cb_unwinds),
+		  __imm_addr(runs),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
 /*
  * A loop of no rounds never runs its callback, so the call needs no unwind_goto,
  * and the inlined loop gets no pad: the insn after the call is what it was, not
@@ -566,4 +934,131 @@ int rbtree_impl_cb_unwinds(void *ctx)
 	return rbtree_cb_unwinds_via(true);
 }
 
+/* Unwinds with the node it is handed first: the one being added */
+__naked __noinline __used
+static bool less_unwinds_with_node(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	asm volatile (
+		"r0 = r1;"
+		unwind_exit
+	);
+}
+
+/* The pad reads the key of the node that came back in r0 */
+__naked __noinline __used
+static int rbtree_add_pad_reads_node(void *root, void *node, void *less)
+{
+	asm volatile (
+		"call %[bpf_rbtree_add];"
+		unwind_goto(1)
+		"exit;"
+		"r0 = *(u64 *)(r0 - 8);"
+		"exit;"
+		:
+		: __imm(bpf_rbtree_add)
+		: __clobber_all
+	);
+}
+
+/*
+ * The comparator unwinds with the node being added, which the kfunc drops on
+ * its way to the pad: there is nothing left to read through it.
+ */
+SEC("tc")
+__description("unwind cb: the comparator unwinds with the node the kfunc dropped")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("invalid mem access")
+int rbtree_cb_unwinds_with_node(void *ctx)
+{
+	struct node_data *n, *m;
+	int ret;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+	m = bpf_obj_new(typeof(*m));
+	if (!m) {
+		bpf_obj_drop(n);
+		return 2;
+	}
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less_returns);
+	ret = rbtree_add_pad_reads_node(&groot, &m->node, (void *)less_unwinds_with_node);
+	bpf_spin_unlock(&glock);
+	return ret;
+}
+
+/*
+ * The node the comparator unwound on is not in the tree: the kfunc dropped it
+ * on its way to the pad, and the caller has nothing left to read.
+ */
+SEC("tc")
+__description("unwind cb: the node the comparator unwound on is gone")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("invalid mem access")
+int rbtree_cb_unwinds_node_gone(void *ctx)
+{
+	struct node_data *n, *m;
+	long key;
+	int ret;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+	m = bpf_obj_new(typeof(*m));
+	if (!m) {
+		bpf_obj_drop(n);
+		return 2;
+	}
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less_returns);
+	ret = rbtree_add_with_pad(&groot, &m->node, (void *)less_unwinds);
+	key = m->key;
+	bpf_spin_unlock(&glock);
+	return ret + key;
+}
+
+/*
+ * The comparator was handed the node in the tree as well, and could have
+ * unwound with it, so what the caller holds of the tree is gone too, as at an
+ * unlock.
+ */
+SEC("tc")
+__description("unwind cb: what the caller holds of the tree is gone when the comparator unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("invalid mem access")
+int rbtree_cb_unwinds_first_gone(void *ctx)
+{
+	struct node_data *n, *m;
+	struct bpf_rb_node *f;
+	long key = 0;
+	int ret;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+	m = bpf_obj_new(typeof(*m));
+	if (!m) {
+		bpf_obj_drop(n);
+		return 2;
+	}
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less_returns);
+	f = bpf_rbtree_first(&groot);
+	ret = rbtree_add_with_pad(&groot, &m->node, (void *)less_unwinds);
+	if (f)
+		key = ((struct node_data *)((void *)f - offsetof(struct node_data, node)))->key;
+	bpf_spin_unlock(&glock);
+	return ret + key;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

