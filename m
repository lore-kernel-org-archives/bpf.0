Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749472;
	b=knXYe+3qLHCAVz2ALGOaxVcmvgqDuiEg5qdIdPjuG9XeSdB9YfThzMNTR+QJ6y2vsp9d
	 vYSWsb/D3mEkbJKfxW1HBC6qnrq2tVo/bg/HKzzNMziZkRn5IBxCjwrwJXnT+/7UlI/J6
	 CIduJ2k2QMvyA7eL7YomZA5GI4VZWu03h0jEXyCx9sDQpbNVZ0bV2MgS9rfs2cdGfuNUG
	 OVUoFYe0KLIUosKu10JzqgCjiQyBrXm3f1pIQd0bsFmp5rk9cO4Y/+uJeAedxkLSQiGjI
	 omGQq3u6mZ5cFKsW331SEPDfrSnzs2+o6iiHY6bgo/cTBOkVNeiJNRXBY8npykG5geQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qffWh7cmlhmXxZn2lXbmpou+IuBzU7nW3+ngTMJtyio=;
	b=Hfo3itI7GA4JpYwEfQL9pDKChjX6sIeHskED0dY/UJfmRLCIealLQYzi//GfUlLXp+Hs
	 VrnvynbBTky7gVdYfs+bjgh3JchhxfNaddHzdXhJtTjyNIgJoYY8XX2qPsGm6sfL3xCyP
	 bwq6eTKgkJr/SJ0Q5x3Jo09ubkExzZRgQutZtHZoxHeUkIupUSj9b8fVV+5t0dpot9Fo/
	 JSUPgf1tSvEekBZ1Z0QALLCA7Z+TagEzVoW8IARwRwreu2R35guKXLsCBOhccwe6Joucr
	 mRUJ0W/RshDYc5/0U6hAgTT5WXAWUtXKUn1nypXotiP2ichntkMbyjNNItq8IKHHcgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L917JZZJ;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE20606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE20606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L917JZZJ
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so117358b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749471; x=1794354271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qffWh7cmlhmXxZn2lXbmpou+IuBzU7nW3+ngTMJtyio=;
        b=L917JZZJ7/H/d3PO4kP2Es3+TU1tanmEyGp2BNN6i/z+hJ7LbjaIZJ4fMAlnhPT7vq
         CAKzPx+9KbANxpMWK6AIOMSk7PYE6icN0GRzd8MwMVKY/rKhXigD2G2PphuoSELSY1j1
         JihKicpjhb9hTT1KHbCHE1YLQ4eOb3mSDNsY/sLlTfRjPICO+zKjOJpF1tri+1Q9Ysh8
         GQ6uO1ruOf2A4xtWYOf0s12bvQclKW+6QUTkkUKNNxDrfOdKWTRggU37+KnhQNk5HMY5
         vwr8gJZQexGQ7hnpy1gn9nPDqatyPT8ujVxQ711SM4rGp5mpuckFgoSorA9amHqY5vwO
         0cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749471; x=1794354271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qffWh7cmlhmXxZn2lXbmpou+IuBzU7nW3+ngTMJtyio=;
        b=x71NossDWxRtiT5F9U7oOUpLpkUrdfl4C5Jx6lUN0sodPn3IBCeD4gm0sz6YLgktKl
         Q4K4GjuipNnGqcAKpcAD50EmYSn+IvKrfB/1N/DNaHyhU7B4iyKrOB/8SPA6Un3NsJAU
         BwQu4lW7pj0HswYeLtaQJb5ON1UyQKT2eG69iz0UXLscU+vT38pdeXzUpSqMkVe2MrPS
         c7fF0LgNa4wW2AcospBKJpA6CJpoInBBVjlpE3UTd69lcOFfdxkzZzXUmNjV6nwzqVtP
         1pKNfiRa82f58BFf88PIVFh57Rof7z/pE+WL5vTHXJbveLr/BtzPj4pOjWygO5+piXXA
         dDzw==
X-Gm-Message-State: APuU4Z/5MBsQJCss0nq3s2vXozUnmWaSsU0v7LASQdDnVhJfZGiEMpHe
	bBAWyBX/BxSiMwRnhh9fIZGuDhT0fikIV5hYLRK7n3oO6wGVlFk3o68a2XRnUQ==
X-Gm-Gg: AYBFou0BlhaA9jzujLMDp3HIkodPhgLMb92+dtzCO8Qv7KcDzyCmW7dL/OvgQw8HZoY
	yP2VVU3rYvTf+CQMKeSwpgCK0+oAMPC7ue/eGEV7ksbNI8bu0pzF+DnAfasxfIBqTsHq32eFnzt
	Cl3l9odSoQ74MpBef0R6eIXXlzcANFPP0i+Ye1+aeBgQKJNouMILfP4Xi8vKMlsbN14ROJchHg+
	yrykYKuvnDTxkOlQsrM5Gf5eTW9D7TB5NSpXsnbDodezn+bvEeVZ9AlCKYknMfy8x5n1ltfuscV
	fIBDZOHoHk5npobqgb19so18q+8MrJX4P00ui/Z0o0hXnSGQD2b0fJmy2J0BTOv9XXSAws69/M4
	5/MlIKQoncZWcPixNjYcGVG9aWG/EvVsL3X94emZqt7WrgHeMdf9ltB9ALmvSX8dyPUGP0X0+De
	Q6lGene9eNbRGLNPTSSHILptov+exBt7gWr/glQLz80h5nDaK+Ti2CoVQytsNmK7A86h244cTu3
	vNpwWa4WL0sg2I+bGYttrZNEwQRixOJhQTcLJtuJHNU+i6mIbv9NDrs4UmnaS0AZfZoM7htA1M2
	rUDlgwV/DQhSHwQKIUoOUvpIzV3t9h4n7vz2mknA7yhAHQHBJSYGrUNjs4ev+NDKhUsQkrVWuM3
	7UDdrQhJx8gGJmzYs4j0PwWwIs5Pekn+qwIzxtFDBCltvMKCU0OXIQDMq63r1sQr0IBQXZKr3Gg
	==
X-Received: by 2002:a05:6a00:2d16:b0:893:8a6:3801 with SMTP id d2e1a72fcca58-8a9bea6a19cmr11769566b3a.24.1793749470467;
        Tue, 03 Nov 2026 15:44:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b667995sm150367b3a.40.2026.11.03.15.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:44:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 34/37] bpf: Allow 24 arguments of static subprogs
Date: Tue,  3 Nov 2026 23:40:59 +0000
Message-ID: <20261103234104.208239-35-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

A BPF function takes 12 arguments at most: 5 in registers and 7 in stack
slots. Rust needs more, because it passes a slice or a trait object in two
slots. For a struct with 5 fields derive(Debug) calls
core::fmt::Formatter::debug_struct_field5_finish(), which takes up to
23 slots.

The limit of 12 is for calls in which the kernel takes part. Only BPF code
calls a static subprog. Thus a static subprog can have a different limit:
MAX_BPF_STATIC_FUNC_ARGS.

  callee               arguments
  -------------------  ----------------------------------------
  kfunc, trampoline    12, no change
  global subprog       5, no change
  static subprog       12 -> 24: 5 registers and 19 stack slots

The verifier counts the stack arguments of a static subprog from its code,
and JITs get the number of stack slots from the verifier. Thus JITs do not
change. The field that counts these slots, and the mask of stack arguments
in struct backtrack_state, get wider.

BTF still describes 12 parameters at most. The verifier marks BTF of a
static subprog with more parameters as unreliable and continues, as before.

The test that stores behind the last slot now stores to slot 20:

  stack arg write offset -160 exceeds max 19 stack args

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                               | 15 +++++++++++----
 include/linux/bpf_verifier.h                      |  6 +++---
 kernel/bpf/backtrack.c                            |  2 +-
 kernel/bpf/verifier.c                             |  4 ++--
 .../selftests/bpf/progs/verifier_stack_arg.c      |  6 +++---
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ca8992702dbd..7e022591dc23 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1008,13 +1008,20 @@ static_assert(__BPF_RET_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
  *
- * Also reuse this macro for maximum number of arguments a BPF function
- * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
- * stack arg slots. The JIT may map some stack arg slots to registers based
- * on the native calling convention (e.g., arg 6 to R9 on x86-64).
+ * Also reuse this macro for maximum number of arguments a kfunc can have and
+ * BTF of a BPF function can describe. Args 1-5 are passed in registers, args
+ * 6-12 via stack arg slots. The JIT may map some stack arg slots to registers
+ * based on the native calling convention (e.g., arg 6 to R9 on x86-64).
  */
 #define MAX_BPF_FUNC_ARGS 12
 
+/*
+ * A static BPF function is called by BPF code only, with what the compiler
+ * makes of its arguments. A slice or a trait object of Rust takes two slots. The
+ * function that derive(Debug) calls for a struct with five fields takes 23.
+ */
+#define MAX_BPF_STATIC_FUNC_ARGS 24
+
 /* The maximum number of arguments passed through registers
  * a single function may have.
  */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index dfecdfac75ff..54d45407ac1d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -487,7 +487,7 @@ static_assert(MAX_CALL_FRAMES <= (1 << 4));
 static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
 /* Maximum number of bpf_reg_state objects that can exist at once */
-#define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
+#define MAX_STACK_ARG_SLOTS (MAX_BPF_STATIC_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
 			 MAX_CALL_FRAMES)
 
@@ -1007,7 +1007,7 @@ struct bpf_subprog_info {
 	 * a hidden pointer to the result, a pair in two registers, no dead arguments.
 	 */
 	bool stack_args_from_code: 1;
-	u8 code_stack_args:4;
+	u8 code_stack_args;
 	u16 stack_arg_cnt; /* incoming + max outgoing */
 	u16 max_out_stack_arg_cnt;
 };
@@ -1029,7 +1029,7 @@ struct backtrack_state {
 	u32 frame;
 	u32 reg_masks[MAX_CALL_FRAMES];
 	unsigned long stack_masks[MAX_CALL_FRAMES][BITS_TO_LONGS(MAX_BPF_STACK_SLOTS)];
-	u8 stack_arg_masks[MAX_CALL_FRAMES];
+	u32 stack_arg_masks[MAX_CALL_FRAMES];
 };
 
 struct bpf_id_pair {
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 2d6535f271a6..6d448f503de9 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -223,7 +223,7 @@ static inline unsigned long *bt_stack_mask(struct backtrack_state *bt)
 	return bt_frame_stack_mask(bt, bt->frame);
 }
 
-static inline u8 bt_stack_arg_mask(struct backtrack_state *bt)
+static inline u32 bt_stack_arg_mask(struct backtrack_state *bt)
 {
 	return bt->stack_arg_masks[bt->frame];
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d503dc7cea1f..563313809078 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4633,7 +4633,7 @@ static int check_stack_write(struct bpf_verifier_env *env,
 static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
 				 int off, struct bpf_reg_state *value_reg)
 {
-	int max_stack_arg_regs = MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
+	int max_stack_arg_regs = MAX_STACK_ARG_SLOTS;
 	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
 	int spi = -off / BPF_REG_SIZE - 1;
 	struct bpf_reg_state *arg;
@@ -15257,7 +15257,7 @@ static void prepare_subprog_args(struct bpf_verifier_env *env)
 				cnt = max(cnt, insn->off / BPF_REG_SIZE);
 		}
 		sub->stack_args_from_code = true;
-		sub->code_stack_args = min(cnt, MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS);
+		sub->code_stack_args = min(cnt, MAX_STACK_ARG_SLOTS);
 		/* incoming + max outgoing. Calls add the latter. */
 		sub->stack_arg_cnt = sub->code_stack_args;
 		if (env->prog->aux->func_info_aux)
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index d1fd5a402565..c54a9b80ced4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -443,7 +443,7 @@ __naked void stack_arg_shared_store(void)
 SEC("tc")
 __description("stack_arg: write beyond max outgoing depth")
 __failure
-__msg("stack arg write offset -80 exceeds max 7 stack args")
+__msg("stack arg write offset -160 exceeds max 19 stack args")
 __naked void stack_arg_write_beyond_max(void)
 {
 	asm volatile (
@@ -452,8 +452,8 @@ __naked void stack_arg_write_beyond_max(void)
 		"r3 = 3;"
 		"r4 = 4;"
 		"r5 = 5;"
-		/* Write to offset -80, way beyond any callee's needs */
-		"*(u64 *)(r11 - 80) = 99;"
+		/* Write to offset -160, way beyond any callee's needs */
+		"*(u64 *)(r11 - 160) = 99;"
 		"*(u64 *)(r11 - 16) = 20;"
 		"*(u64 *)(r11 - 8) = 10;"
 		"call subprog_7args;"
-- 
2.55.0

