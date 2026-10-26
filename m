Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983874;
	b=MGifDHYHnH1opSGa8As67V5vIU9AnrgoQUsAUmCG+EpDxxU6dUDEsMLAg3249hckdHP5
	 nHvzl8PsgF58mQOwB+ZzP2AeDIwhv9+EnlgWLEumVKiLRNW42L5tebG/9h6OJpYrjui7C
	 JhVcHhCdYMjLT0ZmgdQJLstHTFxUk5xrc7NixWwrNoG1WuYZ4ssOHhkMARfjwkfjlWbX+
	 vG7rt6cOm74pczLX2tK3DC/GIczn11fcSef4Cpzohjx8qaV1sNsxivOxQz4DalknnAmnn
	 oTyFGM/F46Cvg3SYNqd45kYCirpMrtBSlAT8oP+c/+mgcQzMWMeEwhwEabu0K1KtpYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hn2/drErc92/US3ik/1cVatbJarCdIsTX3J4xeOhZ+E=;
	b=NqdVXdCbPtj3CIkueWMpT59eTnOCB3OHvx001a5Z95gCH3/OI394PzMgVoQQYDH4yxEQ
	 7MV+TK2Yb2ArSBPFPrgzQ5WMOqFpOgoL41QjUrkCJ+pP//2hXY0w8BD5GtyyR+bh5G6yO
	 +Nc2QYblLgptEikkng0sSzKsqfx0BA+ykM+Qlr0njPZvgkN8XrfnAVfR6794Wctfkhg4Z
	 BA4mgPTnDhZ6qwhbZjnCgxPJatrJGbrOtJXehSQpE7+33uEHmd60dqx1PRq9l9zydDypd
	 7gq0RNxkQUrf1kfzhY0bLX2bIgf8uJZnBy0VYfE7YBmuihUAx58lnLDzpCwezQJaKYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbMspFe3;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE7606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19DE7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbMspFe3
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9f6a16aedso16351035ad.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983873; x=1793588673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hn2/drErc92/US3ik/1cVatbJarCdIsTX3J4xeOhZ+E=;
        b=TbMspFe3QjiFeyknefOJIgl3mf7Rokx18Wc3mlHpNatIB4Empz0uqbmcAz+3/hdPDt
         LIeJDFkg63w6lRpmOgAaSPT9tqoOd3NWpQRUPEJvUHj0jSQJXE7y016Aixq1nTvzdZCP
         QFclGGAtCLZI1LHAlDzy5eAs/XwGs48hWWKMOR0wRoyZfSn5d4G5UH4PaZMpj8viOyfx
         jbhCiGI8UNGdIwDb2BoJ5zmR9cVG9/k8uAE0ALMVid15oxeUEZKMtwEp8/cCppPTgqtg
         OOi3XnOqWNXrxUgPXY5FGNFR2kOvvNoiB/uYVy6p/+iQ9XwUwwEq3Ucazx0+vwnND5FK
         wNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983873; x=1793588673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hn2/drErc92/US3ik/1cVatbJarCdIsTX3J4xeOhZ+E=;
        b=t3Ph5gYb29wigsZsDaDglM88qNM6Den5CH1gUv/4hvbCews3cD/bWCTIUp8BtKNaOx
         SY7LGTQW8BYF4eC+x4u7FvOxnfiRT+J6SwrpyXSMq8aCnXe3AlYg5ZbFwesvO5f0/sRh
         lIulGGJ8drVzv5acFQqDdQzOm/XynjA/kPLtnBlL4eY2Ftv+X0sY0hdZSLHkEK24HYN9
         jafM4IlV2MlaU8Tbj1LF77v8sofXC5RpIxAuA3cioXteTnGp1GDXoA3Ks2KEqrM9Rb+w
         wMIvEg+eBCyEfNisQ3NIFwMOKBUxh2D48RNhM7u8VH3R6f2c0sd9OTFln65GmTTXpIif
         soqw==
X-Gm-Message-State: AFq9FYIRJ3/LXKWYKZs1sp/2Pn38f4VQ1zWi+6flDdPe62wUUTZT/QO/
	KuHPFG2c0AWKMYMxgsyUYInNEyTXA9Q1xc166EHC05usan5uc++DWDMH1gOLHg==
X-Gm-Gg: AYBFou12zG9zmPoesYsNzHgwojZTmFLEvNqDdM9iPZe5286LKnvN5BZlwUwUvjHVKCF
	A18EJbgBuKzRqGzScO7orY9H4d5XrlWwpx8qHuJkhcRKYDwf7mIwA6cIN8tW6vVlB3iQyN4sMGm
	Eu7h+2Z6fZeNde+Yi8NwHMS12nu9jj5wHtKlVOnhq2wRIIIj8Jhl12C1V5rGda19t5roUtaFDjq
	2ppLzQg/Svk7ERPP1IvRohUtE0wNseE6DIjrnyj4McREwcpJ6leVpguqBRkz8WmnEeE8DORd1p4
	jHpyCAgUViLN8z8SFuE6088jw2u1Px1qroKDdw/mnAP3kLIUk7jX1RxFHiUwHuksIUbWNTrf+2i
	Qkg+/UjLioiS8bvG2ENaGLwMBlb5E6OlkczirrfhXj94YhtxgrjIgpkDeTdbDsz+dJKl34qW40X
	OtLtbM8BhmRJ7360vRwIscYcJvYy62wA1GoHLJj8bH89bwhVS4nl8hKlIli9P7xNCV8cUoMfBjj
	mJ56aPF5eJFEjTFBGKwfWqrYPH9R9EJoE9Ij/CSfruQI3wYBQ21oHAuTy5H8QZcVp+SjPEDNULR
	bwvT4b9xQWjSKkrluhzE5zPc19H/R8f6nVqhKhuPNzRyho4xgAs8a1PF2X10+CNw3OfNSAdgXZl
	0mQOQHE502a74GYQj4Jpyxr2hjO4by0pz1qmE6MfHH82tEA==
X-Received: by 2002:a17:90b:57e5:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3adeaae625fmr4738962a91.26.1792983873198;
        Sun, 25 Oct 2026 20:04:33 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb24a83sm6288563a91.17.2026.10.25.20.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 49/81] selftests/bpf: Adjust tests to loops that are counted now
Date: Mon, 26 Oct 2026 02:59:10 +0000
Message-ID: <20261026025943.404450-50-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

"bpf: Describe loops that scalar evolution cannot count exactly" counts
more loops. Three tests expected a loop that is not counted. All progs
load.

  test                          the test expects now
  ----------------------------  -------------------------------------------
  no_widen_small_spill_counter  header_count is [0..266]
  uninit_slot_counter           header_count is [0..11]
  state_loop_first_last_equal   the prog loads
  kfunc_implicit_arg (new)      r5 is not live before the call of the kfunc

The first two loops count from a stack slot with unknown contents. The
count has an upper bound for each first value.

state_loop_first_last_equal examined the log of precision backtracking in a
loop that was not counted. 'r0 += 1; r0 += 1' is now a step of 2, and the
loop is counted. Keep the prog as a load test:
"bpf: Remove precision tracking" removes backtracking.

The verifier fills in r5, the implicit argument of bpf_stream_vprintk().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/compute_live_registers.c        | 13 ++++++++++
 .../selftests/bpf/progs/verifier_precision.c  | 25 ++-----------------
 .../selftests/bpf/progs/verifier_scev.c       |  6 +++--
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 1ff24bbc7beb..de0496ce7d5e 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -538,6 +538,19 @@ void gotox(void)
 
 #endif /* gotox: x86, arm64, riscv64 */
 
+extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
+			      __u32 len__sz) __weak __ksym;
+
+/* The verifier fills in the implicit argument of the kfunc. The prog does not pass r5. */
+SEC("syscall")
+__log_level(2)
+__msg(": .1234..... (85) call bpf_stream_vprintk")
+int kfunc_implicit_arg(void *ctx)
+{
+	bpf_stream_printk(1 /* BPF_STDOUT */, "x");
+	return 0;
+}
+
 /* to retain debug info for BTF generation */
 void kfunc_root(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index f4459561bf39..2ec3ee7821c0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -150,24 +150,7 @@ __naked int bpf_store_release(void)
 #endif /* v4 instruction */
 
 SEC("?raw_tp")
-__success __log_level(2)
-/*
- * Without the bug fix there will be no history between "last_idx 3 first_idx 3"
- * and "parent state regs=" lines. "R0=6" parts are here to help anchor
- * expected log messages to the one specific mark_chain_precision operation.
- *
- * This is quite fragile: if verifier checkpointing heuristic changes, this
- * might need adjusting.
- */
-__msg("2: (07) r0 += 1                       ; R0=6")
-__msg("3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 2: (07) r0 += 1")
-__msg("mark_precise: frame0: regs=r0 stack= before 1: (07) r0 += 1")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (05) goto pc-4")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R0=P4")
-__msg("3: R0=6")
+__success
 __naked int state_loop_first_last_equal(void)
 {
 	asm volatile (
@@ -175,11 +158,7 @@ __naked int state_loop_first_last_equal(void)
 	"l0_%=:"
 		"r0 += 1;"
 		"r0 += 1;"
-		/* every few iterations we'll have a checkpoint here with
-		 * first_idx == last_idx, potentially confusing precision
-		 * backtracking logic
-		 */
-		"if r0 >= 10 goto l1_%=;"	/* checkpoint + mark_precise */
+		"if r0 >= 10 goto l1_%=;"
 		"goto l0_%=;"
 	"l1_%=:"
 		"exit;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index a68a2368aa71..b30802c9e9e3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1188,7 +1188,8 @@ __success
 __log_level(2)
 __msg("scev at header 2:")
 __msg_next("  *fp-8=(+ *fp-8 1) / (linear *fp-8 1)")
-__msg("loop header at 2, can't compute iterations count")
+/* whatever is in the other bytes of the slot */
+__msg("loop header at 2, header_count is [0..266] ")
 __not_msg("widening")
 __naked void no_widen_small_spill_counter(void)
 {
@@ -2405,7 +2406,8 @@ __naked void sibling_inner_loops(void)
 SEC("socket")
 __success
 __log_level(2)
-__msg("loop header at 0, can't compute iterations count")
+/* whatever is in the slot */
+__msg("loop header at 0, header_count is [0..11] ")
 __naked void uninit_slot_counter(void)
 {
 	asm volatile ("					\
-- 
2.55.0

