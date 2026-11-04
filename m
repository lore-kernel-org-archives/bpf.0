Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829385;
	b=mxlHCGQTPyFKQFPLfLzdmUHep7at7kdgF+8Oo59mlaDi0EKlloeh5G1AMn0hZuLteCfP
	 HHHC/oLfNrX3OYCnQgcgUUz5eLF/vFvOC0gYb6OiTSY9uwfjyHg7OmsPtBUNUwitUtIx1
	 bTE2Q8GKTyGrriaznpTLeiZlDU6200/suOJ6QUtfo2tahsZ49sA5F9Y9cUeX2JCZLRQsf
	 vuNVFH8FCbtk9tJ3Zir4bLGHVh4Yr/Ql4BHYwLCzF9suYft8SFxP6YaEwDrWxcWhc5SwH
	 sF1iNS3gBjB73fCq3yHIovG3f5PP+zpIk5J7Lzw34agqnTFywlavJN4qkmnPu/txm9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vDERcbB7tNc9VgBrkYc0VMjo0TUfwQF1HKC3bV1gXZw=;
	b=4OzF6xL1S8YK0hPHTZNr4kiQGDePmrNbLx/pz7Kwr1a3GBkjA3xPvYmv6x/nZTfq0TDH
	 mznQHqz5NnuENdKntSoB0jiSEPwMU5gjguj+ZxzchgxS3HmW8NxrOY7DwZ0f2GQHcn0qE
	 Fsp/rTWLb6bROkgpUjQQV/Bcxn9xWXWftedhm3C4X1jkQByFLiXbSJ0HZbPtnaDyCUmyU
	 39cIswJLUqeGd4ZYZFbzUy9ng9CPZbVMTkmEkXuVoDdAAqUkNXuPc8I+4mSwRH4maUZ0Q
	 q9+g6bpvzOMKEGzCPmM0lehj7V1UfpY5QJRlGu4to4U2PJb+Otp1Z25rn+B/5LaTjtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e0xuu5n1;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7364606A865
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7364606A865
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e0xuu5n1
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9d1114320so9763145ad.3
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829384; x=1794434184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDERcbB7tNc9VgBrkYc0VMjo0TUfwQF1HKC3bV1gXZw=;
        b=e0xuu5n1hB/Uq+mzXFXrxId6pZHTNUyQfDQAXdREQo6VuYqsxpf/V0kkR8JqSFY18y
         v5H/BUm96H8Qu8Jj9w70MD3HjXyr+tx6OcNniBdcPG1P2rvcXGQll2fMggHKfXgNZlXN
         yH/7fKwzEF6SqgH1JEMXn3i/v2+/boDnb1I4UqTJ5FfGKbFlYF25tVphJ+ab0t5ZidSn
         rZ3t4QBrGS/jdEuNakcyIQABdcbki5mcdvXNPoLdBssez6ew+/Nd3RzwdHR0RIRU9mvb
         dyyJaP9irNHt1zjqeY1u6lscrncYzgQ78dSmnNq24SxOOu1n+E0e0e0BqYyIi+82uma/
         fbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829384; x=1794434184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDERcbB7tNc9VgBrkYc0VMjo0TUfwQF1HKC3bV1gXZw=;
        b=iGtnTXyNhx2qT2sRgh6CRYTKWFfO3hEWg00hI7O8QryvGggdw+XoGsNe/i+reXK1nC
         AXSop/KfjDUK8LtdkFFW9haromTb4OrI+XbSTWS6zTwZ/Z49O7FbiB1y1JCYzvJS0TjN
         l9v3Pm4oFGchsMBxaAHYhyF1tRDfAE+Qh/u9BWNu3bL9xGi/PnQhHm0LMyrdYyAXyEo9
         Bhoa9ksG7JrVn1SkdpWYgI1oaqlQnPkS/6iKWX5N38cAasKfQcxZ+kD4yJxrBxulxBDj
         IkHT63azcq7uWwOLpPR+OU02KJkbAGm6ByApmaoYmEQ6SC0H+tu/VZghqkPHYIVtoyh7
         uhdQ==
X-Gm-Message-State: APuU4Z8+vPK+5ElisxVIsICAmsrK3vWB9DozZMwFTaYVOYPlLxq7QYAu
	hKQow5nmtGdxzbzFIkaKlQIm5G/Fv7ijNMAxtp+F4rfJpU3MNu1vDHJuCakXew==
X-Gm-Gg: AYBFou3HnWLkDr8TOoPq6XtiB3uZpyVchKLr2z68Crsqa0K71Gh32sdzki+7CV32uM8
	UgQUC+Tq5ylweBMEztngTP25FZBZ1f3MGyeFxCzI/OpdLSjWAoV+WAQNiP5u+it3frZQS+J1V1i
	Fkvt6GtfjWmya/lp2/2oPoPym1jO+Q5+3MvTfWcMoQqy0ICj7JqOwSnmXBLgnkKydT34w/GJCkq
	3jh+zXXqhW/TedoVCazswXUkKLkBLysssw7/FmG0ulgkwHF8t4IESeSCkF85IWGj18SzfucJyYT
	2xmvcLnltaYDA6NtkVYLZ/R0t00YYr9PITumNl+wTY/mJBnp90dVTXsfBFj3opHLcuKd5S64aER
	5TI6gE/G12HSLuJfMg6DcKvsfz24KmS8vIJVszTxAQQLHmry1SDPaLneLIkc/wbU7+FtNI4NYWr
	ydAhQ8lrYwwM5kJZDr60Wtr/y9zumYvh5sytcphsYAAhU95Flpox2AeIzbRTo0NVlzy717ngH40
	K5zQEYsIpg82vLOPB3y7d+OSrTPpF47IxnPqxxrEDS055uYuLHy1SqKML3xzRTwpGvjFeaciJxp
	99Jbkguo8Sv2d9pD4v4UoueAAb6WDbl0qdcOik9nzptlYlmWtgBjhfAY0s81DmUHZl3UggLzpm1
	0xDtdgv6Glo8YCR++9rr0uAuo/9Sxu7SAI8vj+CpJsyCKkuXAteI5XsM4u+a1npx5JriztM9ONg
	==
X-Received: by 2002:a17:90b:1c10:b0:39e:6a80:b799 with SMTP id 98e67ed59e1d1-3ae89799522mr15680715a91.41.1793829384021;
        Wed, 04 Nov 2026 13:56:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31aacedsm677622a91.12.2026.11.04.13.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:56:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 9/9] selftests/bpf: Test 32 call frames
Date: Wed,  4 Nov 2026 21:55:23 +0000
Message-ID: <20261104215523.1852636-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
References: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
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

The limit is 32 frames now. Add progs that have exactly 32 frames, and one
that has 33.

  prog                                  frames                 result
  ------------------------------------  ---------------------  ----------
  global_func3_32_frames                main, f31 .. f1: 32    loads
  global_func3_32_frames_stack_pointer  main, p1 .. p31: 32    returns 60
  global_func3_33_frames_stack_pointer  main, p0 .. p31: 33    rejected
  static_func_deep_stack_marks          main, fm30 .. fm0: 32  rejected

The stack_pointer progs pass a pointer to the stack down the chain.
analyze_subprog() calls itself for each frame of such a chain. It sees the
chain before the main pass, so the 33 frames get its two messages.

static_func_deep_stack_marks has an invalid access in frame 31, on the path
that is verified second. The verifier gets there only if the marks that the
first path leaves have the right frame number. Liveness needs it in the
mask of frames, precision in the jump history and in the linked registers.
No other test depends on a frame number above 15 there.

A chain of more than 16 frames requires the JIT. The two progs that load
run with the JIT only.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/test_global_func3.c   | 81 +++++++++++++++++++
 .../bpf/progs/test_global_func_deep_stack.c   | 33 ++++++++
 2 files changed, 114 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 16a353195494..b332704b395c 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -197,6 +197,87 @@ int f32(struct __sk_buff *skb)
 	return f31(skb);
 }
 
+SEC("tc")
+__success
+__load_if_JITed()
+int global_func3_32_frames(struct __sk_buff *skb)
+{
+	return f31(skb);
+}
+
+#define PTR_FRAME(name, next)			\
+static __attribute__ ((noinline))		\
+long name(long *p)				\
+{						\
+	*p += 1;				\
+	return next(p) + 1;			\
+}
+
+static __attribute__ ((noinline))
+long p31(long *p)
+{
+	/* volatile: the compiler must not pass the value in place of the pointer */
+	return *(volatile long *)p;
+}
+
+PTR_FRAME(p30, p31)
+PTR_FRAME(p29, p30)
+PTR_FRAME(p28, p29)
+PTR_FRAME(p27, p28)
+PTR_FRAME(p26, p27)
+PTR_FRAME(p25, p26)
+PTR_FRAME(p24, p25)
+PTR_FRAME(p23, p24)
+PTR_FRAME(p22, p23)
+PTR_FRAME(p21, p22)
+PTR_FRAME(p20, p21)
+PTR_FRAME(p19, p20)
+PTR_FRAME(p18, p19)
+PTR_FRAME(p17, p18)
+PTR_FRAME(p16, p17)
+PTR_FRAME(p15, p16)
+PTR_FRAME(p14, p15)
+PTR_FRAME(p13, p14)
+PTR_FRAME(p12, p13)
+PTR_FRAME(p11, p12)
+PTR_FRAME(p10, p11)
+PTR_FRAME(p9, p10)
+PTR_FRAME(p8, p9)
+PTR_FRAME(p7, p8)
+PTR_FRAME(p6, p7)
+PTR_FRAME(p5, p6)
+PTR_FRAME(p4, p5)
+PTR_FRAME(p3, p4)
+PTR_FRAME(p2, p3)
+PTR_FRAME(p1, p2)
+PTR_FRAME(p0, p1)
+
+/*
+ * What a subprog does with the stack of its callers is found for every chain of calls that
+ * hands a pointer to the stack down. The function that does it calls itself for every frame.
+ */
+SEC("tc")
+__success __retval(60)
+__load_if_JITed()
+int global_func3_32_frames_stack_pointer(struct __sk_buff *skb)
+{
+	long x = 0;
+
+	return p1(&x);
+}
+
+/* That function sees the chain before the main pass does. */
+SEC("tc")
+__failure
+__msg("p30() passes a pointer to the stack to p31()")
+__msg("the call stack of 33 frames is too deep")
+int global_func3_33_frames_stack_pointer(struct __sk_buff *skb)
+{
+	long x = 0;
+
+	return p0(&x);
+}
+
 SEC("tc")
 __failure __msg("the call stack of {{3[23]}} frames")
 int global_func3(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
index 1b111a65614f..11af79aa2ced 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
@@ -142,6 +142,39 @@ __naked int static_func_deep_stack_second_caller(void)
 	asm volatile ("r1 = 15; call fs15; r1 = 15; call fs31; exit;" ::: __clobber_all);
 }
 
+/*
+ * fm0() is frame 31. On the path that is verified first fp-16 and r7 are linked, so 'r7 > 7'
+ * bounds fp-16. On the second path they are not. To see that, the verifier needs fp-16 live and
+ * fp-16 and r7 precise in the checkpoint at 'goto +0'. These marks go through all that holds
+ * a frame number: the mask of frames in the liveness pass, for which r1 can point to each of
+ * the 32 frames, the jump history, and the linked registers in it. The liveness pass counts
+ * the frames of a chain of calls that passes a pointer to the stack: here r10 of the main prog.
+ */
+#undef F_0
+#undef FN
+#define F_0								\
+	ASM_FUNC(static, fm0,						\
+		 "call %[bpf_get_prandom_u32]; r6 = r0; r6 &= 0xff;"	\
+		 "call %[bpf_get_prandom_u32]; r7 = r0; r7 &= 0xff;"	\
+		 "call %[bpf_get_prandom_u32];"				\
+		 "if r0 > 1 goto +1; r7 = r6;"				\
+		 "*(u64 *)(r10 - 16) = r6; r1 = r10; r1 += -16;"	\
+		 "r2 = -8; r3 = r10; r3 += r2;"				\
+		 "*(u64 *)(r3 + 0) = r1; r1 = *(u64 *)(r3 + 0);"	\
+		 "goto +0;"						\
+		 "if r7 > 7 goto +3; r2 = *(u64 *)(r1 + 0);"		\
+		 "if r2 <= 7 goto +1; r0 = *(u8 *)(r2 + 0);")
+#define FN(n, prev) ASM_FUNC(static, fm##n, "call fm" #prev ";")
+F(30)
+
+SEC("syscall")
+__failure __msg("R2 invalid mem access 'scalar'")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked int static_func_deep_stack_marks(void)
+{
+	asm volatile ("r1 = r10; call fm30; exit;" ::: __clobber_all);
+}
+
 /* Ensure that even 32 levels deep, the function verifies. */
 SEC("syscall")
 __success
-- 
2.55.0

