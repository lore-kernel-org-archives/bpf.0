Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415675;
	b=qXFLx2uee652G7cRUYw9DfcBosq8dK/tVk5QsAlf03J6n1V50QAz0SBhHRK8PXbh8OSe
	 G98CLHhA2a2G8ixsabJIR2Ab9Fa2V9zZVOu6PqKCG5htWVJzc3vGIEbmYfSUfH9nsmsAt
	 UFijP+KDHrUhecDaseNT3TJVSRZjHaUk85Oqk74zouxqbeGtJLcIQBsWFO6fghhs3xKg2
	 p+PBYpY9iTXGzc6XDBHW3fr7JYQbjkDQOGnEUqpWPOED1wi5SVGQbEpR5c/wCE1qrIqen
	 ZA25ocThDrEqHz9TGfWnUtySQupUitdTL/9drfuMhqbQ+W+q+9aeBusIIt4P40jeGaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0q+5WWTBn7o8h37MNS2jsKgeYGkC1WPd30EfCSWpWJo=;
	b=4S+sZz9Z90PJr09ubW6Fup4kzswbD6LTptLIehrji5F37DLzIt5vDAqq6OicogzSfklm
	 rRI90w7h1NMWXNVy7k+gPSSbJWXnCkaiaEBY+tMq3d04IWmDT/2o+GBm16RYrE/ytO9/V
	 fTy3rwy2yWGO70/bJsdVL0kdwNeXCcrYr3Wj7v2HMKqHGF2y7wH4RxU0RTa9v4KIHKJ22
	 sCZjSw/S+RFNx6EkPQQvqruIUlZqGIZAURsZ987HY6bkZ4xFVZ+R6S/FGFqZc2zOp2n3z
	 tnjPpzj8pj42OY/qtSLyVzovZbsFskkaTbguLar+j6pGbX5MeEiL0XDOB/DLFMegB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdgrO13M;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7D606A330
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9E7D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdgrO13M
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso1344853b3a.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415674; x=1795020474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0q+5WWTBn7o8h37MNS2jsKgeYGkC1WPd30EfCSWpWJo=;
        b=RdgrO13Mo4Zl/63euJYRUc12OyMul9zP6sAPdrijy9k0io1GY4CbbZazM7P/FmLc6R
         hhlv4lCWnMl/KPRJUjuwGaBlcEUJSXJX9K19NlNIG+/npD2OSHGhODp4Wmro0obhJ9JT
         JY41huGqI/RJODcOdv4aLk3C3easj8i/YsE9ANMhcfjcN0KbK4uosfrVh+XMpb94zFK7
         zwlaqlUUIEoD8J8OcHBQLRoutW5g1MdfAeR1rkxSuKGyix7B9bAhmalCF4ewW+kbjt9H
         cBUCyXRJEBTBGcfRRrB4UCUC+PtoOFZ+mR4/vKtub418CwzLrC8haXHol/6TZ9TC/Wm2
         Dbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415674; x=1795020474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0q+5WWTBn7o8h37MNS2jsKgeYGkC1WPd30EfCSWpWJo=;
        b=a/xuGNwwj+YWtq516IyQy3q32jLCP9G3PONuCQbvroyhuep2N+iYK2kSCGd8RkivNr
         Lf2zCToxxmFYoB/s92IILtKo2d4BYc3MpK7Gl5VZg+MBb/bGF5P49pj+G23Q2bSsch+R
         tr966L6P5feUNRlomaNWbM7uPPUdgS+Csw15A+NoiSl9CGlfQ3goOK+KOVKo+chtBStP
         5eKP1RulnhNcA57MadBPp4XuLHmcxE1PgQbInFrax4G9dbHlsIp+0eY/WescvoNN/Hoe
         HVjx09bizYNZP3DdrrNLWMPYFxmQYxj21G/TTs7vvnKRG3CB6g/OrlIK4QplchwSY2ML
         OLOQ==
X-Gm-Message-State: APuU4Z9n+nlCBVKXf8LyPUBjibWIjngoPMggz5pzvmKX9t6KIKUoIy2z
	3v6KMalQXfAn0tIqgyaVYyBhVpL/to4/itUcotHQfHCMUCPPzcNqANzTSsn9zA==
X-Gm-Gg: AYBFou1vmPTteV4y8JGSeZpiH2Q7hMz46c3oeFyBn61j0VHI3IPgCbTQEX22dRaqvpZ
	F87ZmD7PEGw0ybhDLaq+buV8tRucCqaXiA3bUQGU3eBfH1UnY9/vs+XuzgscANLmaUh8TcHWCHE
	vh6e4JtO9tY3pwav7cdDBzYIIvLBcc92pNVYGg8Q+YDGgPR8pOOLY+isZmPgQdZw+w3il+rB2sJ
	SSH4zspW4CaWXsHiY0gSR3wCENaNreTI2hSmxUyOZzP57plEYXHGIouXtINv8f8ewhTbM/QWJw/
	BgBn+rnl2q4UMTigKCaPsbJoPVOQvCD6dTJEdUEc0DlVuDIR2m5pA//Q7+dQtG+sBxQG74Pfd8o
	4Meufq8R9bSmCL7g/PuSgXaF8UNMhGiu57MnaFaaL9ACNRDIW/t+ZiPLP+pFaFPv6TmKnOWVCFZ
	0inItKKuz13bxUBwModHyUoA5wWSW+0qvm/g0f+FHRrwd26kE195Sj2tpCcepzQYEiKr4vtcssh
	nX7GvUON3lhhZi3qVIpRAdlWlms3uCqgd7cLF40cgAeDc7YyQYqKmi0Abuur0zbrVAs3+m+Sb4A
	zP1jjBklxfNvqt57Oahcac3IhzmB+dcRNv3R/wSvXl6TvmZDtmhRabjdjLqPigAWZRlzPzxlyQ3
	89beKy4uUpEdYEtk910QV2EmDJzwkSdP/BM2r+5/8V04w3j7Y0homid5af2xymawwpK90mr4F/A
	==
X-Received: by 2002:a05:6a20:918e:b0:3e2:819f:8a7f with SMTP id adf61e73a8af0-3f2fffc060emr3271619637.74.1794415673814;
        Wed, 11 Nov 2026 08:47:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa1b1bf1sm2327674b3a.12.2026.11.11.08.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:47:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 19/29] selftests/bpf: Test the memory of a caller that a jump tests
Date: Wed, 11 Nov 2026 16:45:42 +0000
Message-ID: <20261111164557.2659679-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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
index 0659ed1bab41..7db9caedc7d5 100644
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
@@ -3405,6 +3405,67 @@ LINKED(index_is_empty, VALID __flag(BPF_F_TEST_REG_INVARIANTS),
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

