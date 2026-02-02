Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7B2FE578
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075442; cv=none; b=AR2cdEQcOR4HScuubtmFGc9D2wValm4CqUCVBk2RRJBCSW2u4wpMqeVJ4b+9Uuy3BCXtBEnZAvW0TcmBF1U+Luxq9OvAdSSqctdAcSMM/y9lgTgcqRKSJa6tiwXBri2bvdeMIk0YLlQRoMjPEuLt5d0tapM86gg3y1TpAafR4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075442; c=relaxed/simple;
	bh=41PWgcA9GU81h1QwWJiHkGlC6zJtHzdC1CiX/UCzVkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k07CxQgZZFqlZx+p3NAtQvA5e3BPNUKCPL8VQPKNQjIHFBkDs+d7YkFL1QFq3183ukdc45ZPf79ZcfFScSzYB94LZY8WQ3wsGLn+LoJsxVkxb/1pI6TGDwuZZNp7Alejy+djMpqjapbIl9jDjBa9RpVPtJhLagkV89bqVPipEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=M93yRP1A; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="M93yRP1A"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c52c67f64cso468117885a.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 15:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770075440; x=1770680240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mU5iV5P5yIAue/p9HNFFfSWias1dsf7XHWQ10OZTncs=;
        b=M93yRP1AAOqrjJDhiDlqRyoG3O33Sq7amSZjDf5SfaYZHjv/GtZXj21jCy7gG1QNK+
         jDeTwefOBMoWJWK2bCdDfUk/BK5rRVSVYVibUQAk7MsKhlTjjO23vfTrRwjsqxmkulCd
         4I7OesUff2tCnX+dajEsfSqRWp1FPBBBzxPuuXwDeJTX5XMnFNi1m7CfFLabU5EIbw6i
         OBeh6VY3tpyr9saKZQ+9SYxr7uED37XZv8XclW7I9+KGdtkrwtVbEZcg+Yu3NHbqYpri
         utp3iH8hXjKDs0tkxweOCBQ9aeh5erLXWqaYdU/4i/1gMK6bx24dGX1tiJMJzrBCyiy3
         RCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770075440; x=1770680240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU5iV5P5yIAue/p9HNFFfSWias1dsf7XHWQ10OZTncs=;
        b=TW7QDvRPAmRjp/iU9R92M1gFlUPM/T7yToQYU6Q0BHSkvoPs+H9OjAyjBs1u0lpzpQ
         TRfBPVmNV+Nq5OmlXS1fl9PW+vjOfIuIsLBZHGXTiMHfw20SCOHWyAQhS5vmQCRbxGcy
         el8ziZtcgw1AWoisB/DSY095nuG0pwl9VWDbwoU1Oiy2ejRwxBPTj9wH0QCDVVwhTYhg
         sntiLg4sxI/mZGzDldYbuCBu9mPqI2kSCsYUymmYgOZr1hdhuqZgRbyxCNhVz39hvtU/
         vkTPlVVO35CQGYermqWn6H8BYpy3m6Go6i+vt3VPnEcF3JcbDpw4a1eR0j31pNWojbWz
         Tuog==
X-Gm-Message-State: AOJu0YxL/JpDPgJTF7sC/XqlRTwz6gelNiNjOxUUA7lutesgsg9cPtE/
	sXAEB4dDRctV3WpFBesLfxk++ntx1kCpaEm5ej6YbX3nP/d5KDIt0Z2LHZbdPVCdejcnUhHBzDQ
	IReg0
X-Gm-Gg: AZuq6aK31OGb5yufoYloEIJUZEHL36tmssFqJ+k0QN+8lzgaKIfGdG6GbBKUcza5UXi
	eXjjfrp7EriQQ9DTn0vZHA9bfW52UgZ5qNW1ulRNekK7hMXEJrdHhAxqyAzZnakY4iC4TVQZESB
	1sQamzFOHXCx7VHxawDl2lQrEdYVIXJnTLkKQyn3kaG647qhjiHsQs5DLLBhUWbelRsn1ibT6A4
	z2ffGqbmLOodpq4vBp5siQS77iDI9kftO7vDZlTxWfyXSfQSCSXM1bjjK0qOWvymSTfn1NT3hWs
	QrKGCtIDzg1gHxcOzdcvkmjg3oYPZrhXJ/y07CfmQ8IJuJs4HyJ86kDh0o6hX5AKl7zQeyW6+ej
	0fmmtsRNJYdVZ9Bz/l75GLl8tqgU7EDoiVtivCkHYmN9e7TXLaUHhFhus1PH/gptbgsm3Bcb2sz
	jR1rgmn2NZOw==
X-Received: by 2002:a05:620a:4887:b0:8bb:a346:8c84 with SMTP id af79cd13be357-8c9eb275f93mr1543552085a.30.1770075439673;
        Mon, 02 Feb 2026 15:37:19 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b95e43sm1338578185a.17.2026.02.02.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 15:37:19 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next] bpf: Bump maximum call stack depth to 16
Date: Mon,  2 Feb 2026 18:37:16 -0500
Message-ID: <20260202233716.835638-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier currently limits the maximum call stack depth to
8 frames. Larger BPF programs like sched-ext schedulers routinely
fail verification because they exceed this limit, even as they use
very little actual stack space for each frame.

Bump the maximum call stack depth to 16 stack frames. This does not
adjust the maximum stack size of 512.

Also adjust selftests that assume the max call stack depth is 8.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h                  | 18 +++----
 .../selftests/bpf/progs/test_global_func3.c   | 52 +++++++++++++++++-
 .../selftests/bpf/progs/verifier_loops1.c     |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  | 54 +++++++++++++++++--
 4 files changed, 111 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8355b585cd18..9f7fc990f380 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -317,25 +317,25 @@ struct bpf_func_state {
 	int allocated_stack;
 };
 
-#define MAX_CALL_FRAMES 8
+#define MAX_CALL_FRAMES 16
 
 /* instruction history flags, used in bpf_jmp_history_entry.flags field */
 enum {
 	/* instruction references stack slot through PTR_TO_STACK register;
-	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
+	 * we also store stack's frame number in lower 4 bits (MAX_CALL_FRAMES is 16)
 	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512,
 	 * 8 bytes per slot, so slot index (spi) is [0, 63])
 	 */
-	INSN_F_FRAMENO_MASK = 0x7, /* 3 bits */
+	INSN_F_FRAMENO_MASK = 0xf, /* 4 bits */
 
 	INSN_F_SPI_MASK = 0x3f, /* 6 bits */
-	INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
+	INSN_F_SPI_SHIFT = 4, /* shifted 4 bits to the left */
 
-	INSN_F_STACK_ACCESS = BIT(9),
+	INSN_F_STACK_ACCESS = BIT(10),
 
-	INSN_F_DST_REG_STACK = BIT(10), /* dst_reg is PTR_TO_STACK */
-	INSN_F_SRC_REG_STACK = BIT(11), /* src_reg is PTR_TO_STACK */
-	/* total 12 bits are used now. */
+	INSN_F_DST_REG_STACK = BIT(11), /* dst_reg is PTR_TO_STACK */
+	INSN_F_SRC_REG_STACK = BIT(12), /* src_reg is PTR_TO_STACK */
+	/* total 13 bits are used now. */
 };
 
 static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
@@ -346,7 +346,7 @@ struct bpf_jmp_history_entry {
 	/* insn idx can't be bigger than 1 million */
 	u32 prev_idx : 20;
 	/* special INSN_F_xxx flags */
-	u32 flags : 12;
+	u32 flags : 13;
 	/* additional registers that need precision tracking when this
 	 * jump is backtracked, vector of six 10-bit records
 	 */
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 142b682d3c2f..7a0b7c4b9274 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -53,9 +53,57 @@ int f8(struct __sk_buff *skb)
 	return f7(skb);
 }
 
+__attribute__ ((noinline))
+int f9(struct __sk_buff *skb)
+{
+	return f8(skb);
+}
+
+__attribute__ ((noinline))
+int f10(struct __sk_buff *skb)
+{
+	return f9(skb);
+}
+
+__attribute__ ((noinline))
+int f11(struct __sk_buff *skb)
+{
+	return f10(skb);
+}
+
+__attribute__ ((noinline))
+int f12(struct __sk_buff *skb)
+{
+	return f11(skb);
+}
+
+__attribute__ ((noinline))
+int f13(struct __sk_buff *skb)
+{
+	return f12(skb);
+}
+
+__attribute__ ((noinline))
+int f14(struct __sk_buff *skb)
+{
+	return f13(skb);
+}
+
+__attribute__ ((noinline))
+int f15(struct __sk_buff *skb)
+{
+	return f14(skb);
+}
+
+__attribute__ ((noinline))
+int f16(struct __sk_buff *skb)
+{
+	return f15(skb);
+}
+
 SEC("tc")
-__failure __msg("the call stack of 8 frames")
+__failure __msg("the call stack of 16 frames")
 int global_func3(struct __sk_buff *skb)
 {
-	return f8(skb);
+	return f16(skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index fbdde80e7b90..0970f25f9c60 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -139,7 +139,7 @@ SEC("tracepoint")
 __description("bounded recursion")
 __failure
 /* verifier limitation in detecting max stack depth */
-__msg("the call stack of 8 frames is too deep !")
+__msg("the call stack of 16 frames is too deep !")
 __naked void bounded_recursion(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 9ca83dce100d..077db99d6a1f 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -455,7 +455,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "the call stack of 9 frames is too deep",
+	.errstr = "the call stack of 17 frames is too deep",
 	.result = REJECT,
 },
 {
@@ -812,7 +812,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "the call stack of 9 frames is too deep",
+	.errstr = "the call stack of 17 frames is too deep",
 	.result = REJECT,
 },
 {
@@ -824,7 +824,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "the call stack of 9 frames is too deep",
+	.errstr = "the call stack of 17 frames is too deep",
 	.result = REJECT,
 },
 {
@@ -1219,6 +1219,30 @@
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call H */
 	BPF_EXIT_INSN(),
 	/* H */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call I */
+	BPF_EXIT_INSN(),
+	/* I */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call J */
+	BPF_EXIT_INSN(),
+	/* J */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call K */
+	BPF_EXIT_INSN(),
+	/* K */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call L */
+	BPF_EXIT_INSN(),
+	/* L */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call M */
+	BPF_EXIT_INSN(),
+	/* M */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call N */
+	BPF_EXIT_INSN(),
+	/* N */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call O */
+	BPF_EXIT_INSN(),
+	/* O */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P */
+	BPF_EXIT_INSN(),
+	/* P */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1257,6 +1281,30 @@
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call H */
 	BPF_EXIT_INSN(),
 	/* H */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call I */
+	BPF_EXIT_INSN(),
+	/* I */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call J */
+	BPF_EXIT_INSN(),
+	/* J */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call K */
+	BPF_EXIT_INSN(),
+	/* K */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call L */
+	BPF_EXIT_INSN(),
+	/* L */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call M */
+	BPF_EXIT_INSN(),
+	/* M */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call N */
+	BPF_EXIT_INSN(),
+	/* N */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call O */
+	BPF_EXIT_INSN(),
+	/* O */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P */
+	BPF_EXIT_INSN(),
+	/* P */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-- 
2.49.0

