Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374141;
	b=qeS7xF9nkvJdkWrPUtVO4fqii+46XJCtT0FqZVOU5voTxGJiksbhafGL+u9bW3AhubEh
	 +YSY+Afe3Cnyzo5FAB0HYYe7Z6MEqcXmrMlaJ7/BU/5msqJ+RDX/EjUaxmT0peJe0BY86
	 xPJdV/tWZPgrGCszZoaJe3TkLIouw2moPX35U0vswNqKdJGDBaKI1Zn7gKsa6cYKLJivN
	 pYMIJnY5GUMguH7UTECQQgoqmmy03oozv0xDJfScWq4mcIbxZYCjT1Pdp0ziXx+lUYU7V
	 KM2E0lRNhzfLwiWCi57UvQ8XQjFZKdbLEnozigGY/RMXaF36glKlIIkV3aixibFzwRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7YyvJGTRi4jzolyX921z0Ebm6swRdDew9rQ6iIGp0a0=;
	b=os74xAQ2zRKBhXLyL17Jsq1+19ep2DHCtPG1Mj4XtcjqNqZqF6ubUFgiCByWNEtF7skZ
	 hlSp0T/4V8Rjyi4sYbQYB0LV01Ef4Gk0s6LjzzGLDDNvtSIZQqA0dNDRUgv43suRrbaOH
	 GqiAvxUSX9gMTjlPGJG2wc23XhBPhv7wnXvOiT7Fn4MX2k1qcSX1IhfqVrlXc5Vn8qTck
	 yzTRk+gvwE2CJJTBJ/AWYMAzChIpDXnqyklm8pKLVHFgzBtoAWNou/3FFQYHpEBC9EOmI
	 M5io7TcO16cWFiTiX637ZgiLorQEOnBDmNiuMNs0DS0J+vBo/HZoo6dny2UFL2JFROA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0sWk30UL;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6607606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6607606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0sWk30UL
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so1743510a91.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374140; x=1794978940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YyvJGTRi4jzolyX921z0Ebm6swRdDew9rQ6iIGp0a0=;
        b=0sWk30ULho7Qku6kGcgb9TPOhwJWeD++RSow4mxBpN8++tbmRPP+PeDsOfr1T5fciX
         UtPsyvoKIna6E9L43tHn6swE1+gPJSGqf9b6WflgAXv61g1WFZmFohGcRgm1ddkQyvjR
         w8ub8CiK0LPScbFelM/dARjaEtRC4EoztWdP1l9NxvTbf1AzLpWVk76g4tn+A26uCj0x
         3jYdKukA+xVdvheJ1AtGYW2HQHFg4J59QR4HRAA5WtqmRbyw0Y0lUv5daYgTmNnrqoOI
         zvwoCrsEGbn/+sMv1NUNJ3lZ5OVd4RFQENX057hJ1RFRWNMLc5QSDQwt/349xn6Krx+g
         JsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374140; x=1794978940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7YyvJGTRi4jzolyX921z0Ebm6swRdDew9rQ6iIGp0a0=;
        b=kttzH5ae8BYgFcoFf4D9rvHgofr09WLn3dofButyFRzWWGfpzbK7gw/oh+XXQgWV00
         /TzO0nmv8G3U+sB2zz2SuIUFD1+dwH+k2MMgbeQhjJhQqxI+EASFt3tB5xzdGMKiD2Hw
         LSRvao4zwP+MBc3gYGMJuBWArAWmiwZ3n3uchulkYFuvQ5h5wx/ixuL/Zrg+bmUAkfSE
         pi8Htjz7WyJPzgxnAE8kC0wbB7SuU/2m/jPvNFRKd9IaOWxER49BXhZOTlsItcNfm6xv
         4BgMpxx5bNXWk9+b50YedBvyu2rXIhSdq2zisjHQQoXd78KQ8iWIa11rWJWo9ynC4Rib
         Y/dQ==
X-Gm-Message-State: APuU4Z8LhPM80SxoMfpz25Tvc08CQ12H9gcmVb0bo61wFrWkYoDRj9vo
	DGslIs5Z6HAq2Fz5zOdPnvZqemwCt7DmGr2gRAPx15o0o7A8248yZ+39aYKRdQ==
X-Gm-Gg: AYBFou1UofhL8GXbZI13X5VbEjj9HFDjc27AghGs9GtgMqYGJaf6tBBm/edXCv1wiRw
	lelaWXOYDbGuOAFHqLKNzxYlSrwqAOSXACMiZVaAmXVlAP6F6/ZvqHT+c/RkEzcRIazyf+Su1T0
	df9OOdqlHxjqUFIAwTnMaVV9aW572PwZP6yjN15ApGcTzGVArlxQQiFGAPLfhBdUTv7uxunalHw
	cwY9QIVqL2PlNVyat0P/+PEJ0U+wg+63g1iJqiuFgROweZ6JtuOmz9IjG8x45+LnBITkkCXfJFA
	GGaGGJfLHPD/bo7NlVtOR4oViHx6XJuU7BKbYlw9EodrfCIakPWR3bLGGl5i0D/gEJhiCRUDrXE
	3cBRsYZW4jdBvBWtCDbnFYCcmBfeFBd7e2NDp3noAIyNF7944KmMDtcJHtDHiHhbSJHQNrlnbEr
	HdMNS1j+U8CSRpUgveTkWKNnwM4qP148qbjXq63SDABqYXvrgSY7mUJ3GSkycYbZw9h9wzJZuAL
	RjC64OgwkTZp2/9s6QbyPO1IkXkrhWlk8G+3ylonCCQ4fg6RR2RUI3xP71VOW7nL0+fTrLvmyY5
	/BIYs8PbhYdHBoKrYIxH4ib/bYSYH8f+36EsQXVDMvoMi5/O/UD48HOQw82tYIc3DvJ8U9lPj3v
	/svGmsvMmP23OsCUeAa40z8fUcDppq6HvtIh5io48vja7gy9aYqV3RXFiw8TTIAmAJHPwR3Dgpg
	==
X-Received: by 2002:a17:90b:4a4f:b0:3b1:6978:5be with SMTP id 98e67ed59e1d1-3b182ee219cmr1173441a91.33.1794374140044;
        Tue, 10 Nov 2026 21:15:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e0df70asm2737065a91.9.2026.11.10.21.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 19/29] selftests/bpf: Test the memory of a caller that a jump tests
Date: Wed, 11 Nov 2026 05:13:30 +0000
Message-ID: <20261111051341.2800252-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Tests for memory locations in scev.c: a jump that tests what was loaded or
stored through a pointer refines the stack slot of the caller that the
pointer points to. They use LINKED() of verifier_scev.c: r6 is a map value
of 64 bytes, r8 an unbounded scalar. What loads is run.

 - A static subprog clamps memory of its caller in place,
   'if (b->len > 63) b->len = 0;', and the caller takes b.len for an index.
   Negative test: the subprog stores to b->len between load and jump.
 - The subprog tests what it stored to b->len.
 - It stores to the next field between load and jump: the same address
   base, no overlap. Negative test: it stores through a second pointer to
   b->len, another address base.
 - A bpf_loop() callback tests a field of its ctx, which is on the stack of
   the caller, calls a helper and loads the field again. Negative test: the
   field is written between load and jump.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 3588a0a005e2..0f737ca6bd07 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3365,7 +3365,7 @@ __naked void name(void)								\
 	:									\
 	: __imm(bpf_map_lookup_elem), __imm(bpf_get_prandom_u32), __imm(bpf_ktime_get_ns),	\
 	  __imm(bpf_dynptr_from_skb), __imm(bpf_dynptr_slice_rdwr),		\
-	  __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard),		\
+	  __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard), __imm(bpf_loop),	\
 	  __imm_addr(map64), __imm_addr(ringbuf)				\
 	: __clobber_all);							\
 }
@@ -3393,6 +3393,67 @@ LINKED(index_is_empty, VALID __flag(BPF_F_TEST_REG_INVARIANTS),
 	"r7 &= 1; r7 *= 7; r7 += -2; r1 = r6; r1 += r7; r1 += 2; if r7 & 1 goto l_%=; goto out_%=;"
 	"l_%=: if r7 & 2 goto m_%=; goto out_%=; m_%=: r1 += 1;" USE_R6)
 
+/*
+ *	static void clamp(struct buf *b) { if (b->len > 63) b->len = 0; }
+ *	clamp(&b); c = b.data[b.len];
+ * The callee tests memory of its caller: the slot is refined. Not if it may have been written since
+ * the load. r1 and r4 point to b.len, r2 is not bounded.
+ */
+#define CLAMP(name, before_the_jump)						\
+static __naked __noinline __used void name(void)				\
+{										\
+	asm volatile (								\
+	"r3 = *(u64 *)(r1 + 0);" before_the_jump				\
+	"if r3 <= 63 goto +2; r3 = 0; *(u64 *)(r1 + 0) = r3; r0 = 0; exit;"	\
+	::: __clobber_all);							\
+}
+#define CALL(callee)								\
+	"*(u64 *)(r10 - 16) = r8; r1 = r10; r1 += -16; r4 = r1; r2 = r8; r2 >>= 1;"	\
+	"call " #callee "; r2 = *(u64 *)(r10 - 16); r1 = r6; r1 += r2;"
+
+CLAMP(clamp, "")
+LINKED(callee_tests_memory_of_caller, VALID, CALL(clamp))
+CLAMP(store_and_clamp, "*(u64 *)(r1 + 0) = r2;")
+LINKED(callee_writes_memory_of_caller, __failure, CALL(store_and_clamp))
+/* a store defines the memory */
+CLAMP(store_and_test, "r3 = r2; *(u64 *)(r1 + 0) = r3;")
+LINKED(callee_tests_what_it_stored, VALID, CALL(store_and_test))
+/* the same address base, no overlap */
+CLAMP(store_next_and_clamp, "*(u64 *)(r1 + 8) = r2;")
+LINKED(callee_writes_next_field, VALID, CALL(store_next_and_clamp))
+/* another address base can be another name of the memory */
+CLAMP(store_alias_and_clamp, "*(u64 *)(r4 + 0) = r2;")
+LINKED(callee_writes_through_alias, __failure, CALL(store_alias_and_clamp))
+
+/*
+ *	struct { char *buf; u64 len; } c = { buf, 0 };		bpf_loop(100, append, &c, 0);
+ *	append: if (c->len > 63) return 1; bpf_get_prandom_u32(); c->buf[c->len]; c->len++;
+ * The compiler loads c->len again after a call. c is on the stack of the caller, where len grows
+ * until it is widened. The jump refines that slot: it still holds what the tested register was
+ * loaded from.
+ */
+#define APPEND(name, before_the_jump)						\
+static __naked __used void name(void)						\
+{										\
+	asm volatile (								\
+	"r6 = r2; r1 = *(u64 *)(r6 + 8);" before_the_jump			\
+	"if r1 > 63 goto l_%=;"							\
+	"call %[bpf_get_prandom_u32];"						\
+	"r2 = *(u64 *)(r6 + 8); r1 = *(u64 *)(r6 + 0); r1 += r2; r0 = *(u8 *)(r1 + 0);"	\
+	"r2 += 1; *(u64 *)(r6 + 8) = r2; r0 = 0; exit;"				\
+	"l_%=: r0 = 1; exit;"							\
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);				\
+}
+#define CALL_APPEND(name)							\
+	"*(u64 *)(r10 - 16) = r6; r1 = 0; *(u64 *)(r10 - 8) = r1;"		\
+	"r1 = 100; r2 = " #name " ll; r3 = r10; r3 += -16; r4 = 0; call %[bpf_loop]; r1 = r6;"
+
+APPEND(append, "")
+LINKED(callback_tests_slot_of_caller, VALID, CALL_APPEND(append))
+/* The slot is written between the load and the jump: len is 0 1 3 7 15 31 63, the slot 126 */
+APPEND(append_stale, "r2 = r1; r2 <<= 1; *(u64 *)(r6 + 8) = r2;")
+LINKED(callback_tests_stale_copy_of_slot, UNBOUND, CALL_APPEND(append_stale))
+
 /*
  *	p = buf; i = 0; do { if (i > 62) break; i = *(u16 *)p; p = buf + i; } while (i);
  * r1 == r6 + r2 at the header in every iteration: it holds at loop entry, the backedge preserves it
-- 
2.55.0

