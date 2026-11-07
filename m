Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022900;
	b=rh5x5T3yuM9J35AoCTAqGXd6+T6Hfg6PGpKjtv1+jpzzeNofAjlJkRdm6jq5J65aCuOe
	 AglUJUyEEjhPYGlTHeSnk2a5xTeC5BFKzPVpzMLWtXTHzPM8ZOtC8MMCfEe9pFSpGLgIs
	 RMcEU1WFoHFeKB0xwuyHYiMBfdw5mAIKLpqyEythGrbpQBstPOxpngh2lWpcec7bNjUlO
	 N/tSmWhWMVFXd4+Y8ZZ5JPRizNVdXpZIjIDDL3jP2sXk4ugR7wRa1YrPhF7fvz9flhCkq
	 ZH6oCtA+Srj6gULdCUB4efCGsPe//oqeg7dP+QKVFuNPv6w3YJ8gv1sOHVGP9kti5jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n9+L363wjpVGEQ+6oxIr0eZhtQwT8+ovBDPJGqXsaKM=;
	b=JYu84V0kcnLxBkBFrtYOExVW/3jXI0Gkh8rY6ltzBoT4rJb5BsFLHlP9MQXWsZRpotdv
	 8ZMrNK6/Wsz2t3edXEb18obDEzmX9Y8Ea4TV5GxX5Q7/cDEJmwcZF0pNjJAr0OqsMANEC
	 kSdDw1seKvPugG5i5NIOnQYieJfaPAiLZSiE3VaF5IwOOI8xlHSBpS89yj4odhRS5LC73
	 vK8hiI0DOTgnKpt4Bg89WZzvrSXpEjaqBsRb5G2Gw9tLLxzQ2zmU4b0DLshWyEdZxQ4B6
	 61I4WnWtApZKaamAv3daFi5mkpjbNjMN9UrFJwJtKMN7idV/DG/O8/uGgWvYa2FL5Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QVrkq0Ff;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F747606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F747606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QVrkq0Ff
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so8623a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022900; x=1794627700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9+L363wjpVGEQ+6oxIr0eZhtQwT8+ovBDPJGqXsaKM=;
        b=QVrkq0FfYmJp4aXar5LpYQ7q2LFuHwzM03C8JoyAI1GmGthUpvEOxdz+I9ZhHVizAA
         eKkN/2AvP5pyXr+Wa8GZbm7EIobN1V/lIv1Y7W4RPO+6Sdt+L04T7PTBw7QYsPT2uvIX
         nipY7lK6WTjMNqyr2BzQsDG4Wn9TiQ5HlgB83xcG2bd+jZCvM31TVs1Wrj2LOuP2duw3
         jBWsJUXf5G5QD97qJYOVf94+6I8zAf6Kjs/44MliTBBO32RNXtK4/r3dBofgciGbe8QE
         SxV5NF2t6gST7CU54fPUkNo6J/j4FdB+GAzS28lB68Tuxnk8YBEmAyq7a5SL3ZW5hPga
         H+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022900; x=1794627700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9+L363wjpVGEQ+6oxIr0eZhtQwT8+ovBDPJGqXsaKM=;
        b=WsaycazSf7g6lYu610ikTaYwV6J6TjTEMBbEE2ZK0iRyjhpw9REAjpvha/7H1dV/Uz
         AE/8oTeh//dXWLk9tkIvvRXlAnfMNFSL6LRsX6dLlX7xx0QHwMUedtFWfFCe7ySsJHMj
         80uQKkUDxO9aVcxRU0EWyDubHSnA/g8x9SCL+41m/NXOBpTc00LcjpPfEdIkHJ4dBxZv
         SQF63KBuyTyLgR2UlnwSDhjaW1lFW/iraNIzS6Q15LAsOobFqpiMMeC/Ivm79NxiWCUy
         zQ9t4tQYxMR34ULCMh0n9PUWkZNcusJwa1OWAbekS1zXtKHAYEeuVX33fDBUj/b1BjWv
         U7gw==
X-Gm-Message-State: APuU4Z8NJuuN1ygwO/NMleMWUQI90iLJOyHwKl0qw6ajkVaoe8UBgJPy
	E8eZlf8SG28LZ6jYoIDvMbPs7Dpf1lIRQT0W8aO1yLO9p67xj9r+C4YpOlrHPg==
X-Gm-Gg: AYBFou3UibsiYoBE5nb2BUzbmdMHoXVv4/rdTZzNedviLuUin2cSnOS+REnSkBriwmQ
	IGgt7c33yikeHM7qqIXqC/aCdxBRkgJUVDkBKiNsyLAbLM4WRf8oqBziNx0LAlIjAMtwPPYG0+a
	L7kBVoTk4GDmYM7HR9NjoGTYqsU207hi9Ylo609DTyq2CB0yEFgD7X9tTRhgwoSx3lY87+gDEjk
	5hUA9xQIN2AcW0PagtE8So8eVY//h4UuxoNbQITJnvTXD9On5Q2uiiVKfNcYG+JWPZoJe7GrJoP
	ubBWk1aXEIIakvKzF1DzHXWZtFIy9bT5iE/06IJ3uH0xHic2ZI3q+nQTQE//whQ8P0gWvSY5mee
	1yc8m7JaLJ234+LZnUZDpuusUAR0WeH69eAysx3s3j8QKfOKo8vtoPtwm8pSDnXraj1/Gltf0Oi
	94FO9gVm5Fsgg4UgAK0gcZQPUSdf2qdRvd3seCkFoNqNsSb2ycJ8kIN3V3i6a3QWe4xBk2/3dbT
	2gPumxDsJ5hY/tGKZooblIxhXIwQmTjcIIPGvIyhTe/PoI1cB6a8mfZuzkjeCvQwpsV2Vljrn9e
	DXW30RPALZ4vIR3WSbBRytT1Sa5aaZZhhkY7sHmMxNH1XB3bfj+PBJQE01LJrbsDrPkIV4wPKh3
	dknP79G7QJNzTjH7MQBfzl0ECqQJcOkUDVW/m3n6yxyNjnt6+XjnxYW7a7YAXQi9kzAdybZpTvA
	yCMjweGjPZ8hs+e8D7gGs=
X-Received: by 2002:a17:90b:1d05:b0:3ac:96a3:77d5 with SMTP id 98e67ed59e1d1-3b0db70ac05mr3684933a91.36.1794022899349;
        Fri, 06 Nov 2026 19:41:39 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057c3db1sm1542957a91.4.2026.11.06.19.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:41:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 36/46] bpf: A part of a pointer that is spilled is a number
Date: Sat,  7 Nov 2026 03:37:44 +0000
Message-ID: <20261107033758.1547725-37-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

xdp->data is a u32 in C and a pointer to the packet for the verifier.
test_dynptr_copy_xdp_overlap() of dynptr_success.c makes a length of it:

  void *data_end = (void *)(long)xdp->data_end;
  void *data = (void *)(long)xdp->data;
  __u32 off = data_end - data - 1000;

  if (fill_xdp(&ptr, off, 1300)) ...
  err = bpf_dynptr_copy(&ptr, off + 100, &ptr, off, 1200);
  if (check_xdp(&ptr, off + 100, 1200, off)) ...

fill_xdp() and check_xdp() are inlined loops. With plain
'for (i = 0; i < n; i++)' in place of their bpf_for() no register is left
for off. The compiler keeps the u32 that it loaded on the stack and
subtracts once more behind the first loop:

  0: r7 = *(u32 *)(r1 +0)          ; R7=pkt(r=0)
  8: *(u32 *)(r10 -48) = r7
  invalid size of register spill

No loop is looked at. The three test_dynptr_copy_xdp_overlap*() progs are
rejected like that, with clang 18 and with today's clang.

With CAP_PERFMON the prog may see the value of a pointer. It can store
4 bytes of it into a map value, or shift it, and has a number. The stack
is the only place that refuses. Treat the store like a store of any
other data: the bytes are STACK_MISC, what was spilled in the slot is
gone. Whatever is filled from the slot is a number, also when it has the
value of the pointer:

  *(u32 *)(r10 - 8) = r1
  r1 >>= 32
  *(u32 *)(r10 - 4) = r1
  r0 = *(u64 *)(r10 - 8)
  r0 = *(u32 *)(r0 + 0)            ; R0 invalid mem access 'scalar'

Nothing changes without CAP_PERFMON.

dynptr/slice_buf_narrow_spill stores 4 bytes of a slice into the buffer
of the slice. It is rejected by the next insn, which reads through the
slice. Update the expected message.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                           | 9 +++++++--
 tools/testing/selftests/bpf/progs/dynptr_fail.c | 5 ++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index afb5b9dd18b4..8dff321ea723 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3798,8 +3798,13 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		__mark_reg_known(tmp_reg, insn->imm);
 		tmp_reg->type = SCALAR_VALUE;
 		save_register_state(env, state, spi, tmp_reg, size);
-	} else if (reg && is_pointer_regtype(reg->type)) {
-		/* register containing pointer is being spilled into stack */
+	} else if (reg && is_pointer_regtype(reg->type) &&
+		   (size == BPF_REG_SIZE || !env->allow_ptr_leaks)) {
+		/*
+		 * register containing pointer is being spilled into stack.
+		 * A part of it is a number, which is fine when the program
+		 * may see values of pointers anyway.
+		 */
 		if (size != BPF_REG_SIZE) {
 			verbose_linfo(env, insn_idx, "; ");
 			verbose(env, "invalid size of register spill\n");
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 3770ffdeaaaa..7f8a38c37d9e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1343,7 +1343,6 @@ __naked int name(void)					\
 
 /* Not in the line of SLICE_BUF_TEST(): the log of the verifier has a copy of that line */
 #define SLICE_BUF_INVALID __failure __msg("R7 invalid mem access 'scalar'")
-#define SLICE_BUF_POINTER __failure __msg("invalid size of register spill")
 
 SLICE_BUF_TEST(slice_buf_first_byte, SLICE_BUF_INVALID,
 	SLICE_BUF(12, 4)
@@ -1375,8 +1374,8 @@ SLICE_BUF_TEST(slice_buf_var_off, SLICE_BUF_INVALID,
 	SLICE_BUF_CHECK
 	"*(u64 *)(r10 - 8) = 0;")
 
-/* the slice is a pointer when it is stored to its buffer, and invalid after that */
-SLICE_BUF_TEST(slice_buf_narrow_spill, SLICE_BUF_POINTER,
+/* the slice is a pointer when a part of it is stored to its buffer, and invalid after that */
+SLICE_BUF_TEST(slice_buf_narrow_spill, SLICE_BUF_INVALID,
 	SLICE_BUF(8, 8)
 	"*(u32 *)(r10 - 8) = r7;")
 
-- 
2.55.0

