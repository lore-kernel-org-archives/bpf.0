Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829340;
	b=jKvTF8s9OriF+l8tbMTqYT2cPJgX8kFL/yCd2L2yPubKfgu8W8ohqiFhPbtRtsSgqB9w
	 IsQPYfBnokR+hMXWUEsIBs4qY1ZTk81fW0Go3SGmz3pYmS3027dDCWfHzf//gVFgQw+vF
	 2yZ8g/IHxqtZ0cTKpA5tgky8gWZEKW/omoYIevzxLnnT9UEfkQ9INIwmiTm6WFwcvWb3B
	 hkIMGT7B45am6tEouy6r1gziSNEUst9VSQejsaFA5Ygel+HD3vUpJ7FEPUOqdobh8+l6/
	 fpNPq5fkk8cSVRkMGVoMy8DgJQGCe7ebiWqAtwZwoQJGRArh1Ei0yTWerqVhRAnG0+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AApaTpO6I5mR3Iq52DdzMrq8aicL1VwTkThLthvWsig=;
	b=UZqU+xc2jL9rA1OHR8KfNV62WWXzLCjPjfG0gmlaAdT3vKnHOZrn/PJoRF0jneMybaau
	 IpX5AK+d0usjvcNI21xMfniKbmRJV5dXSxdeDn2fwnf0sHj/ZmN7Onr+kbVSE1NZLx69T
	 nYD+Cj4V/0lPrs9Plh2RA02BDUrEYIFwF0rHz69ruIiII0qH4sIcDhtHbLDGaO2LI82co
	 O4IqQ3mdN02Iabi2LTROsyuQDJBZ8q8tKMV2Z1wJ9gHQb+PF5IlTR6unwNn1PgsuYHDkH
	 nW0/ADkhGledkp8chMKiEXBBDOwfq/toYVSAgi9Ho2ekdZ3gfEA5ymrHYNZP0X/5YxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jVWilyLg;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0460A3834
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02E0460A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jVWilyLg
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso861109a91.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829339; x=1794434139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AApaTpO6I5mR3Iq52DdzMrq8aicL1VwTkThLthvWsig=;
        b=jVWilyLgwkoYN/itUbbBEwZgH597j0Sc7wMlqSdUPed3c8EOIrOYzKFqpoA/Y+aSis
         XTHDG9V4vOcxpNJ1yaygrSXnqZFEm5JzoXGNr3cjves32g7A7CFQUFdxvL6lTGlUDnJz
         3QYpv8mePzgGn1hB0rL9wabTsDoKMDCbfcw6CxWbHOIvhDyvcaI41DF2j6/uDWQ9WADR
         riEMwjDaT+0zIRg97I2grhv7UgI5P6TKxCnpMU0kIDqkFbKWCFQNnrqENqVZfspy5Ctw
         8xCFNW++Awr/8dN6/7I0v9bOqxy2685IWJaJUSe7V6U7N0xEWdOZtPyJHrE/gLoFRwtL
         pBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829339; x=1794434139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AApaTpO6I5mR3Iq52DdzMrq8aicL1VwTkThLthvWsig=;
        b=HuYi2FRckvP5xtgStGmUjB5E5Q3bND/Cig44Gq7VrB6jL9UYe3yKIXV4UoHy9UGG6Z
         H31bvjtqcHp1bmyRMEnhcMBhwZddxy74Gd0XTYJVjVelLbVDl6smgUNIUjxAiYobDOUH
         0CKJ/S7e0CeBkSyGAUtXmlcLx2nbZMMEkkEFgNY13/081cxATLTNnYW6RQmpW3HRBl/U
         A5EbiBAea4jzsjdZ7RU7cgZfPRUvDwgLuxPgvrx8YlyNiZNGMO0d3dd6OMOPIa8WVjM0
         YJAIxMKldpZU1Sh8co2YvoL+MRGs93eNxVuloGPKy5C1i9xrOzCp5RhBf/dHLMOLkuYK
         quIA==
X-Gm-Message-State: APuU4Z+1FU1c0pQ51OCsv5RY0khDLHUWdW43qBJXRTSbtp8IT/3Tsnxy
	nWdvsszc4mpQMRVGBNEUhYNjgC0UqPEEPYR1mShHFz5BxipczinIyEtxAZ+Cjg==
X-Gm-Gg: AYBFou0fAmFTaLx0M2DqLFjFPVrdMDd+Kp9w8kkTAZY/i1pov45oMoXLTcuK5J1F/eX
	3muTsfdmTVBT3pqBKawO8Gjw+Esqx+viX6OA9NASqjk285qtu0AjZY/07lGew4YX2SN4Y3P7GM2
	aSvq5wPOSMdKM9hmWqfwTsN+rieePY9fxuC45IDIGu08iLcIk8wNqWyk3k8vt7+XxnWIxBuiLMX
	pvfTlaYD+lLGtbgbWA55rxEUsPyk1xLZ4stD8deoOl95sWVna0cdueGUw5rovI+TsH9/ZLjpwo1
	O+Vle7D0qAATh2732Ff4c95thWwiKTC1dnqrg3y8H1pJm/abq/XoQo0+ZZdKbp6fvWQj0W+c5AE
	xVQdVtkJzAP7GVN9ftD9idarIgEUb1ZcmckNj/M0tdPqRYxcf/JHTfOXIed1XessLPV2Fa78Tin
	a9qtlWyNdGLQAcLnvm6UXm2QqhHe3Wu5A6Pc4MduwuVCrwmkIDg4J/TWWX1D6SblXi/TRETZ0RN
	rDlJDcpBM66Atd/bv3oOpojJBLGnNSYrcsylIXw6WwsbvqEV1Vct4g/he/j3pLpZM32Xt+9adUC
	c1ULZ6xr/JM7+XFAke/nrFYGVqjasql6Pxh8lr2oRh0cUKw9ZQuVA/YvX/AI+npwZzdzHL7as03
	wP6Jl/Dq0KWJ3+h3i/TG32IbWTYBT49t0sqpyub9PdAM1SvfKsxRqx8xJ6g+6lakX6K68nPvNyc
	A=
X-Received: by 2002:a17:90b:58cb:b0:3a8:1943:cb7a with SMTP id 98e67ed59e1d1-3ae896f8320mr14619027a91.18.1793829338992;
        Wed, 04 Nov 2026 13:55:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3280378sm616766a91.12.2026.11.04.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:55:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/9] bpf: Use the call graph to find what runs in a callback
Date: Wed,  4 Nov 2026 21:55:16 +0000
Message-ID: <20261104215523.1852636-3-alexei.starovoitov@gmail.com>
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

A callback cannot use BPF_LD_[ABS|IND] and cannot call bpf_throw(). The
same holds for every subprog that the callback gets to. When the walk of
the chains of calls meets such an insn, it looks for a callback among the
callers in the current chain.

In the call graph it is one set: the live callbacks and what they get to.
Look for these insns in the subprogs of the set. This is done before the
walk, so a prog that breaks two rules can get the other message and errno.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 58 +++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d94c273aa3b4..ef2af44afb0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5808,6 +5808,7 @@ struct bpf_call_graph {
 	unsigned long *calls; /* calls + s * words: the subprogs that s calls */
 	unsigned long *reach; /* reach + s * words: the subprogs that s gets to */
 	unsigned long *live; /* what the kernel calls and what that gets to */
+	unsigned long *in_cb; /* callbacks and what they get to */
 };
 
 static unsigned long *subprog_calls(struct bpf_call_graph *cg, int s)
@@ -5836,11 +5837,12 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 
 	cg->cnt = cnt;
 	cg->words = words;
-	cg->calls = kvcalloc((2 * cnt + 1) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	cg->calls = kvcalloc((2 * cnt + 2) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
 	if (!cg->calls)
 		return -ENOMEM;
 	cg->reach = cg->calls + cnt * words;
 	cg->live = cg->reach + cnt * words;
+	cg->in_cb = cg->live + words;
 
 	for (s = 0; s < cnt; s++) {
 		for (i = si[s].start; i < si[s + 1].start; i++) {
@@ -5869,6 +5871,10 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 	for (s = 0; s < cnt; s++)
 		if (!s || si[s].is_async_cb)
 			add_reach(cg, cg->live, s);
+	for_each_set_bit(s, cg->live, cnt) {
+		if (si[s].is_cb)
+			add_reach(cg, cg->in_cb, s);
+	}
 	return 0;
 }
 
@@ -5938,6 +5944,29 @@ static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *
 	return 0;
 }
 
+static int check_callbacks(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int i, s;
+
+	for_each_set_bit(s, cg->in_cb, cg->cnt) {
+		if (si[s].has_ld_abs) {
+			verbose(env, "cannot use BPF_LD_[ABS|IND] within callback\n");
+			return -EINVAL;
+		}
+		for (i = si[s].start; i < si[s + 1].start; i++) {
+			if (!bpf_is_throw_kfunc(insn + i))
+				continue;
+			verbose(env,
+				"bpf_throw kfunc (insn %d) cannot be called from callback subprog %d\n",
+				i, s);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /* temporary state used for call frame depth calculation */
 struct bpf_subprog_call_depth_info {
 	int ret_insn; /* caller instruction where we return to. */
@@ -5973,14 +6002,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		subprog[idx].priv_stack_mode = NO_PRIV_STACK;
 process_func:
 	dinfo[idx].callx_insn = -1;
-	if (subprog[idx].has_ld_abs) {
-		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
-			if (subprog[tmp].is_cb) {
-				verbose(env, "cannot use BPF_LD_[ABS|IND] within callback\n");
-				return -EINVAL;
-			}
-		}
-	}
 
 	/* protect against potential stack overflow that might happen when
 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
@@ -6067,24 +6088,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	for (; i < subprog_end; i++) {
 		int next_insn, sidx;
 
-		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off &&
-		    bpf_is_throw_kfunc(insn + i)) {
-			bool err = false;
-
-			for (tmp = idx; tmp >= 0 && !err; tmp = dinfo[tmp].caller) {
-				if (subprog[tmp].is_cb) {
-					err = true;
-					break;
-				}
-			}
-			if (!err)
-				continue;
-			verbose(env,
-				"bpf_throw kfunc (insn %d) cannot be called from callback subprog %d\n",
-				i, idx);
-			return -EINVAL;
-		}
-
 		if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i)) {
 			/*
 			 * Walk the callees and the callbacks recorded by
@@ -6228,6 +6231,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	ret = build_call_graph(env, &cg);
 	ret = ret ?: check_exception_cb(env, &cg);
 	ret = ret ?: check_recursion(env, &cg);
+	ret = ret ?: check_callbacks(env, &cg);
 	if (ret)
 		goto out;
 
-- 
2.55.0

