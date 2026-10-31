Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483795;
	b=odh5VmUWJCuVlgajHjIwIc7zsKDN1a7k6iWakYb86OO4rEcSsJSoUoUBYgdoTRoVyeqF
	 d6qH8FqTNoJnGEtEmdHx1d6WFYNBJeTZVa8G6ozrQyw/tamZLvuEM17/GjLzX9q7AOa8R
	 2TOQTk9DMsC6QjekwJCu4ovMCR02lpjPJsAxzV0kQ1Oggot4oNXFBLFUBcup+eZrwSxQG
	 0nLq8N7GNw6uzL70fe+Gc6XdywK/qn5Rx1nXB0X1QGmlxiMo3m2lhbQys1F4pl4YZs1lV
	 uVNKxPlwQ5tcFLBYFQl3YqljmtldVLwl8YVgxSc4hv/6xi6WfmiEkEzCXtKlJL47yRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qE7aO/KbhJ3/k9+8k6khTozBrDX9VsPHviAi9LssYCQ=;
	b=xcXcBH2wUmK5iIWHwQwPJiuYCDsjGKF4jFf3FDT0sHbop4R7BFcNvRu4niNdX8FYe8xS
	 fXEAZIDJ7PnmrwNs3ZTsDNzWpFdAyrG7V9HYinxbl0OcN/B1RRHiSLtjxAdSr0V2C+k6j
	 9kCGvreJvO5XiISK934ZDwEy86xERY6X7PrGlD3SOjlwAVyM4n4Af6o2M42uKUf0m+lCT
	 4gGSuvrrWfMb6ILh13M6jPXY60I0xZ/ahOvt7oa2EiJF5us2LtMCvswPLlWxtoLeMTCdZ
	 A4cDCH7G3Cps7HCVAsIyxZXtiwOEY3k1P8pomu512TrV1aimNergRUwhHdAJm7OwbOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W/QJ+mX9";
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC39606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W/QJ+mX9
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e977109392so12310155ad.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483794; x=1794088594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qE7aO/KbhJ3/k9+8k6khTozBrDX9VsPHviAi9LssYCQ=;
        b=W/QJ+mX9umhfJcJoCubjJDHG85kmwT3kgbRpP/JW6g1cY+deQmA3kw5D+fLVKTe64j
         tNnJd4mfm2mYY1omqItq9R8Wa72VGTHdVZUIPUwSmXECLSj42TIOkuJ3cbSNvyG6BGia
         nRohaiJdmPs5uitrVCeJTFEpfmwZFQ0VFf43qZ0TeEkJPOHGo8XU1rTUTg27L4ix4A1F
         xQvt1SUUJIlqUQys+z6H9z+guxUVody+lIEMEY73CmHZEIY3PKXfAaETPOfV8thiki8m
         PNvDtUZisZQDKVCZVbG+t0RsxLig3lDOKJTSolgnFU7YTVfNiZqIjnNEXDHdZq1KXGu+
         Ey9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483794; x=1794088594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qE7aO/KbhJ3/k9+8k6khTozBrDX9VsPHviAi9LssYCQ=;
        b=nMCwRZMw9H83e9YiKEmhhck8o7kKMWlJ3Ez/Dl9jmWY3RUWsJTDGAEf0ZN46k8MCvA
         Zrtufrfiu0VrT0Ybyjfd9HuUjBUxYKa1C3kp2VQCsqJyS2ai8Sgypuu9nuVQAg+Dd9jm
         ZlkvDZpdroWL8opmTum8ctw2aSU71z+SI3Duu1nW/tUC6kCCLgmjYO1P/mNCGNADgDeV
         YYOynWpzIPIloF1x0tOhgYN1iluXJxAgbMg5ri/ZwYbYTxQQ/uIDxR39bjGrK5yISr3E
         tf6yFmrj7rErA60TigyiqvSB7VLwK44QI6y47N/qk5r6F7WVILBrga1D9U00m6QKP1mD
         +AfA==
X-Gm-Message-State: AFq9FYLE1e1LAFkdF8+Ubw/D1W6s42q9bed2NnkpOEdGw75HqZixwiLK
	DkNpzdi0VVFEHHVtDsLz/dR7M11lbojBrbMTrf5VKaeeAFCPqvmj8vmw4IyY2g==
X-Gm-Gg: AYBFou1Kdt7O+H23jEmtFOJNtOSy6otUyakcIEcdQrDl2+23LlkQVFNMdcitl7Gs9rt
	E7hBq/5POFhyHYtw/xtg9yGhxlCuXwHTB5Zr7iKClB2hr5VWBjGoRuQgVt+p+mt9W2MalfD4T8j
	rTxVXqH+FplRTJRxevv0e8Iqe8GyN5qWWvT4OziIRhhGHf8NT8pWsk28fYLlV4CiirRnOGMoDI3
	XUkPU2HM0LS8WbZzC3+HrtCw/F+qXnzHb7SXAAwIXpqpMi9jjhC/FR/z2guS41EaCILt4odv+gb
	82P3fkAcJRv0Qa5HjnvWEgjXrWFMwuxxFuGytlQ9Od7YzzIPhjBAZiFDtZLNPEOnezagYhmrAAr
	3byJJJrAAnpuFhCTOBJmlFWSTn/UeZIY62FzL28yh6TYX6YOPUn540nSgzRvjdb0pJLemRBCn1h
	FPs6xfOWal4jzkc0L937/f9zAee96ozhB75nQVIlfxgqfIhOmmXzzOM2V3SckOL/EmhXWbKxWDv
	V1YoogvdploM6tH15ayNi0uc5XZPT6CyvblCua8V2NSDp0vzje7zf0cpIGk/AqKpzgoe9tLN730
	uIimp8qoktSyQK2b2n1TuxgB5atX7QeXvQ04wPTVmR82WrUySieNv+o65xec4fAqMf8iy4dc/Qq
	qIkNndZ49WTDx5YXoR8pxUlp94bgpipgkJvxckYbjvV0GRS9u2IOw30OlRhoVYRNv8Z1Tobv0d8
	6ClwGqUS8Xk4KiwKLZAGk=
X-Received: by 2002:a17:90b:4f88:b0:3ac:b185:fa16 with SMTP id 98e67ed59e1d1-3ae898185bamr5154981a91.43.1793483793887;
        Sat, 31 Oct 2026 14:56:33 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb2c5sm13129830a91.3.2026.10.31.14.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:56:33 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 8/9] bpf: End bpf_loop() when the time of may_goto is up
Date: Sat, 31 Oct 2026 21:55:42 +0000
Message-ID: <20261031215543.682284-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
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

When the time of a prog is up all loops with may_goto end, but bpf_loop()
goes on. It calls its callback up to 1 << 23 times. The loops in the
callback make no iteration, but the rest of the callback runs, and that can
be another bpf_loop(). Two test progs with bpf_loop(1 << 23, cb) and some
work in cb return after 4 sec and 10 sec. With this patch they return after
250 ms.

bpf_loop() and bpf_for_each_map_elem() end their loop when the callback
returns 1. So return 1 in the first insns of the callback when the time is
up:

  r0 = address of the count
  r0 = &(void __percpu *)(r0)
  r0 = *(u64 *)(r0 +0)
  if r0 != 0x0 goto pc+2
  r0 = 1
  exit

The verifier has seen what follows: the loop of the helper can end after
each call of the callback.

A function that BPF code calls too, or that is the callback of another
helper or kfunc, stays as it is: there the return value has another
meaning. The callback of bpf_user_ringbuf_drain() stays as it is too. The
helper takes a sample out of the buffer for each call, so a call that
does nothing loses the sample. Its loop ends after 128K samples.

This patch does not limit bpf_loop() itself. Only may_goto counts and reads
the clock. So nested bpf_loop() are not stopped when the prog has no
may_goto, or has none in the callbacks: bpf_loop(1 << 20, cb) with
bpf_loop(4096, cb2) in cb takes 5 sec. Nested open coded iterators have the
same problem. A follow up will fix these holes.

A call of such a callback executes 4 more insns. The cost on x86-64 (Zen 5)
in nsec:

                                                   before  after
  callback makes 1 iteration, inlined bpf_loop()    1.16    1.54
  callback makes 1 iteration, bpf_loop()            6.52    6.74
  callback without may_goto, inlined bpf_loop()     1.16    1.16
  callback without may_goto, bpf_loop()             4.95    4.95
  callback without may_goto, nested bpf_loop()      1.13    1.38

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  4 ++++
 kernel/bpf/fixups.c          | 26 +++++++++++++++++++++-----
 kernel/bpf/verifier.c        |  7 +++++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7baeb831281f..12ec5b14007f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -964,6 +964,10 @@ struct bpf_subprog_info {
 	bool is_cb: 1;
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
+	/* bpf_loop() or bpf_for_each_map_elem() call it in a loop */
+	bool is_loop_cb: 1;
+	/* BPF code, another helper or a kfunc call it */
+	bool is_called: 1;
 	bool args_cached: 1;
 	/* true if the return value is passed in the R0:R2 register pair */
 	bool ret_reg_pair: 1;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 66b9d1d9e961..a656634fa9e4 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2771,9 +2771,12 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		int stack_slots = subprogs[i].stack_extra / 8;
 		/* an invocation begins, see bpf_timed_may_goto_save() for async callbacks */
 		bool main_prog = tmg && !i;
+		/* only a helper calls it, in a loop that ends when it returns 1 */
+		bool loop_cb = tmg && i && subprogs[i].is_loop_cb && !subprogs[i].is_called &&
+			       !subprogs[i].is_async_cb;
 		int cnt = 0;
 
-		if (timed_may_goto ? !main_prog : !stack_slots)
+		if (timed_may_goto ? !main_prog && !loop_cb : !stack_slots)
 			continue;
 		if (stack_slots > 1) {
 			verifier_bug(env, "stack_slots supports may_goto only");
@@ -2793,10 +2796,23 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = ld_tmg[0];
 			insn_buf[cnt++] = ld_tmg[1];
 			insn_buf[cnt++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, count_off,
-						     BPF_MAX_TIMED_LOOPS);
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);
+			if (main_prog) {
+				insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, count_off,
+							     BPF_MAX_TIMED_LOOPS);
+				insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
+				insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);
+			} else {
+				/*
+				 * The time is up, but the helper would call the function again and
+				 * again. End its loop. The verifier has seen that: the loop can end
+				 * after each call.
+				 */
+				insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0,
+							      count_off);
+				insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2);
+				insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 1);
+				insn_buf[cnt++] = BPF_EXIT_INSN();
+			}
 		} else {
 			/* Add ST insn to subprog prologue to init extra stack */
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26a5ee0708a3..383cdc11b5b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11469,6 +11469,12 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (err)
 		return err;
 
+	if (!bpf_pseudo_kfunc_call(insn) &&
+	    (insn->imm == BPF_FUNC_loop || insn->imm == BPF_FUNC_for_each_map_elem))
+		env->subprog_info[subprog].is_loop_cb = true;
+	else
+		env->subprog_info[subprog].is_called = true;
+
 	/* for callback functions enqueue entry to callback and
 	 * proceed with next instruction within current frame.
 	 */
@@ -11505,6 +11511,7 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	int err;
 
 	caller = state->frame[state->curframe];
+	env->subprog_info[subprog].is_called = true;
 
 	/*
 	 * Track caller's total stack arg count (incoming + max outgoing).
-- 
2.55.0

