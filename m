Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074309;
	b=3t0f5/zJPGx0nA5796fUSSU5t8xmJOkvRBjRfeuXbUkMpj3dhbGoioZlj3x1GIfkuAB/
	 d0Nu3z1YF9z1XP4oLjwP8EDxhFuV7A4+wWb+Q+TJAfB0wkKubsqYrV3yy4fxdVru+J69u
	 nkPwp+3rdD/KOw5yLqAalsz2DkNvzYae2S5Nv17O7VM0+tYwUMOTd3JkWk42IQmyij98u
	 2A4wLQ/2AET0RZwNnr3qBy0mLhqU5TCk+GBdZXTJhDAKJGgVEsRfC6C7lM+xKeGX34YZu
	 mRcpu+dI+xUlJVWxmhCN4jGIk+na+gYNXaESN2V6Ghu+hOY28KojEt2T2Fe+2JYkvHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nugVOIIJtSLhCPS80KFyBXrcNmpq1tVrJlbt9177XRU=;
	b=0cWbhvOw+hg2fnFVoJCRN0IEH8vMZUXpr9kww/PDAvtj0RB/gskvdTcDZjjRpmHBZiua
	 KNfkZLk0YuIYueabbvI38WCghdiOKUx2WMbgOiazx/Lyr3ujRXKTjx/XG9462jGerFJrl
	 oK2Ku9WUzSzHwIhf0VtN5Jv5QUSzE0yeqirGHG2k1keOCOdSm7rOHZQQuTR/6EkJs8CIO
	 DlwpCvAaRmPPRFk8Ms0cEHUGAU9abjdho6eB9hjQy6DUvKw/s24+dsP9jUoJTvl7T+FRK
	 /OcBgzuvN9KwXQRCBPPyK13KnR7iSeDPui7QC+dOBW5jAcMIR/pviQEirKfmj4bIBZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udxUO5Uw;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADCA606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ADCA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udxUO5Uw
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso933826a91.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794074308; x=1794679108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nugVOIIJtSLhCPS80KFyBXrcNmpq1tVrJlbt9177XRU=;
        b=udxUO5UwF8Dyd2CKryw09+zN+OnjX5ckWqTezxslNkxhtLZyQirLcRw138+RcFBB5H
         LSUNX14V8aFT/cH/4a7YtpjXp1Qt01/bou20hA9firV7dUMQ/IqJH9xsOpYEXnjf6i+m
         YU8EaoA8MBy7WaHQvNuamKrUfXbxNY4ivyrPjl3wXjPl8zPWzVSOTeF0cfdl0AGQcgp4
         hl5IgqapEHSYobiBaAr8ucs7YA5Wgi6Uy5SNh2nSSNhyR9O0x+vUmCcmwNCC4LDEZ/NL
         qzdZ8ykt59Z/NQbCOBwVY6+fAMAo5LPOnTV3AyZ7/jFcI0GzN+3NGUp9VY+Mz8tJ+BKX
         2s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794074308; x=1794679108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nugVOIIJtSLhCPS80KFyBXrcNmpq1tVrJlbt9177XRU=;
        b=pG0nfxa5hMvmB766GKSwULlA9YF4m7222lDOeAu3++LMbPnCP5lrQ1QoRYb63Mj+z6
         OA6BkHiWoMv+uTWbA5iC2hIUjI0/rODutl2zqW3vrX3GbL9sPv/pNQkELXabY8HhO0F3
         0Bgrr00SMZzu5A7tcywmbhGHClxPLKQYnzfXx1Q2jWxNKwryKsGjahRj4czrtTYddXDV
         Yk0T0jwyTX2TUHyCjjqr9e7qctX0CWVCuUm3rs/ugkFJDXJ61l75wAFHGh/TB3uguRk1
         9fVRNhfyGmGbeii7/+8AquZdsImiyCEVY6XcLNPbqGhR6OzTwNNq3tqbaEnhWJfQTcm3
         jp8g==
X-Gm-Message-State: APuU4Z/R69/K3u6y/Bi3fDCIEtp/LTHM2MxhpnsIEuvVXRQ+z4By/rPI
	0/nsNi21dCbMR8Or0GA/BY7DG8AwtVIYm8bsG7DEdwGGPUoNa4nzW5AlOskdTA==
X-Gm-Gg: AYBFou3JkYX2PjhPucAAzGYbl9fn0bOHr84Rt3AWOaZJTYgJBhykjPLlR5KTxPc0a1X
	r4ixpPJcb/7gGueMInnmNQxRkO8pfOJ9cL/TgSWuKryR60nWWmmlSFRf8BrKWGGA6mKgBOZxfb6
	2yZRszh3l7y8Jish+FS10Qpg4DKfBSvmDaqbVjkjsubp+v22LdWGKkURahFgMlsJEeP2eZ2P8+X
	BLrD8dJPpCtPdPY9gcSpmONtB/IX/58Z6yS1qHNXqWhmZcuY2dFLzTE1Ws4IPKHetgj6oBWCmK0
	Gp5hPBnX+Ao+s9UJF6gL0Hc9a+uCm9vSWbFnRRb3ajAwUK43H2c+Gac9zVxsZDt7bGEfUjz6k3l
	/LbUIouqzae1mhReuek+XLtKChsaopNtbhJwF5wnYBI5QVsaGNjGtdmOj0E+TKCs/4kypkE9+m1
	irmoprYKV+4vPriRTqhU2A/Rs2IUzEM+6itVftR3TNrx4N+1P6iXRwytlWIFOD17R4BK6a5OjXg
	tkSA59vdkAO54kK/0xm8I8hmR9QISxO9CIyVFU/zrXf+IL6zHp75ea6g2a4Sg4ZuKDBiHl9fgYk
	EBj5mqT1btGxnOnC26BOPDfr3IZ6fHEEoLbXKM5T3vvgNaFrqR8jL9NuvVDMYn1NtcT5YKkIgQZ
	qvAwy/Bqawboey7l8A9iJT1PGLvoPWP6Vnt5qqu9oXoC/v2fCyaoGnG/8Fk8KksZEtSG2S5OcV2
	mNH3+4UNDnMFtl4+RO9xWh
X-Received: by 2002:a17:90b:2c86:b0:3ac:7449:40b4 with SMTP id 98e67ed59e1d1-3b0db7085aemr6171906a91.45.1794074308356;
        Sat, 07 Nov 2026 09:58:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101bc56fbsm1956969a91.2.2026.11.07.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:58:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test short loops that carry what they load
Date: Sat,  7 Nov 2026 17:58:19 +0000
Message-ID: <20261107175819.3707050-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107175819.3707050-1-alexei.starovoitov@gmail.com>
References: <20261107175819.3707050-1-alexei.starovoitov@gmail.com>
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

A loop of 4 iterations loads a number and sets a flag if the number is a
valid index. The next iteration tests the flag only. Another loop takes the
index of the next iteration from a table in .rodata. Both load if the loop
is walked. Each has a twin that reads past the end of the map value.

A loop that fills a stack slot with what it loads is not walked if the slot
is only copied later: 17 insns for 40 iterations.

The two tests of a first iteration that is kept apart get 100000
iterations. 10 are walked now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_loop_need.c  | 95 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_scev.c       | 14 +--
 2 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_need.c b/tools/testing/selftests/bpf/progs/verifier_loop_need.c
index 281f94bfeb47..cfc98aeb155b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_need.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_need.c
@@ -346,6 +346,101 @@ __naked void read_in_the_first_iteration(void)
 	SUM_OF_PREV(1, 40, "*(u64 *)(r10 - 8) = r9;");
 }
 
+/*
+ *	for (i = 0; i < 4; i++) { if (ok) sum += v[x]; x = *v; ok = x <= max; }
+ * x is loaded in every iteration and ok goes with it. One state for all iterations has both values
+ * of ok for each x.
+ */
+#define LOADED_WITH_FLAG(max)						\
+	asm volatile (							\
+	"r6 = %[vals] ll;"						\
+	"r7 = 0;"							\
+	"r8 = 0;"							\
+	"r9 = 0;"							\
+"1:	if r9 == 0 goto 2f;"						\
+	"r1 = r6;"							\
+	"r1 += r8;"							\
+	"r0 = *(u8 *)(r1 + 0);"						\
+"2:	r8 = *(u64 *)(r6 + 0);"						\
+	"r9 = 0;"							\
+	"if r8 > " #max " goto 3f;"					\
+	"r9 = 1;"							\
+"3:	r7 += 1;"							\
+	"if r7 < 4 goto 1b;"						\
+	"r0 = 0;"							\
+	"exit;"								\
+	:: __imm_addr(vals) : __clobber_all)
+
+OK("a short loop is walked for the flag that goes with what it loads")
+__naked void loaded_with_flag(void)
+{
+	LOADED_WITH_FLAG(63);
+}
+
+BAD("the flag is set for a number that is too large")
+__msg("invalid access to map value")
+__naked void loaded_with_wrong_flag(void)
+{
+	LOADED_WITH_FLAG(64);
+}
+
+/*
+ *	for (i = 0; i < 4; i++) { sum += v[x]; x = table[i]; }
+ * The table is in .rodata: in a walk each x is a known number.
+ */
+const u8 in_vals[4] = { 8, 16, 56, 255 }, past_vals[4] = { 8, 16, 57, 0 };
+
+#define INDEX_FROM_RODATA(table)					\
+	asm volatile (							\
+	"r6 = %[vals] ll;"						\
+	"r7 = 0;"							\
+	"r8 = 0;"							\
+"1:	r1 = r6;"							\
+	"r1 += r8;"							\
+	"r0 = *(u64 *)(r1 + 0);"					\
+	"r1 = %[" #table "] ll;"					\
+	"r1 += r7;"							\
+	"r8 = *(u8 *)(r1 + 0);"						\
+	"r7 += 1;"							\
+	"if r7 < 4 goto 1b;"						\
+	"r0 = 0;"							\
+	"exit;"								\
+	:: __imm_addr(vals), __imm_addr(table) : __clobber_all)
+
+OK("a short loop is walked for the numbers that it loads from .rodata")
+__naked void index_from_rodata(void)
+{
+	INDEX_FROM_RODATA(in_vals);
+}
+
+BAD("a number from .rodata is too large")
+__msg("invalid access to map value")
+__naked void index_from_rodata_too_large(void)
+{
+	INDEX_FROM_RODATA(past_vals);
+}
+
+/* A slot holds a leftover pointer. The loop fills it with what it loads. It's only copied later. */
+OK("no walk for what the loop loads if nothing looks at it")
+__log_level(2) __msg("processed 17 insns")
+__naked void leftover_in_a_slot(void)
+{
+	asm volatile (
+	"r6 = %[vals] ll;"
+	"*(u64 *)(r10 - 8) = r6;"
+	"r7 = 0;"
+"1:	if r7 >= 40 goto 2f;"
+	"r1 = *(u64 *)(r6 + 0);"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r7 += 1;"
+	"goto 1b;"
+"2:	r1 = *(u64 *)(r10 - 8);"
+	"*(u64 *)(r6 + 0) = r1;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(vals) : __clobber_all);
+}
+
 /* What a call returns is made anew in every iteration, like what is loaded */
 OK("a long loop carries what a call returns")
 int call_in_a_long_loop(void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index c1aede6fa4ae..5c9c832fbbe0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -4411,17 +4411,17 @@ __naked void post_cond_jlt32_copy(void)
 }
 
 /*
- * The loop loads r6 again in every iteration. It's 0 at the entry and a byte in all iterations
- * but the first one: the first iteration is verified on its own, the state that comes back to
- * the head stands for the rest.
+ * The loop loads r6 again in every iteration, and is too long for a walk. r6 is 0 at the entry and
+ * a byte in all iterations but the first one: the first iteration is verified on its own, the state
+ * that comes back to the head stands for the rest.
  */
 SEC("socket")
 __success __retval(0)
 __log_level(2)
-__msg("header_count is 10 ")
+__msg("header_count is 100000 ")
 __msg("can't widen r6, expr is _")
 __not_msg("widening r8")
-__msg("clamping r8 to 0..9 step 1")
+__msg("clamping r8 to 0..0x1869f step 1")
 __naked void index_loaded_in_previous_iteration(void)
 {
 	asm volatile ("					\
@@ -4439,7 +4439,7 @@ __naked void index_loaded_in_previous_iteration(void)
 	r0 = *(u8 *)(r1 + 0);				\
 	r6 = *(u8 *)(r7 + 0);				\
 	r8 += 1;					\
-	if r8 < 10 goto 1b;				\
+	if r8 < 100000 goto 1b;				\
 2:	r0 = 0;						\
 	exit;						\
 "	:
@@ -4473,7 +4473,7 @@ __naked void first_iteration_loads_less(void)
 	goto 3f;					\
 2:	r6 = *(u16 *)(r7 + 0);				\
 3:	r8 += 1;					\
-	if r8 < 10 goto 1b;				\
+	if r8 < 100000 goto 1b;				\
 4:	r0 = 0;						\
 	exit;						\
 "	:
-- 
2.55.0

