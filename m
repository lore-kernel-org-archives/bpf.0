Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CF43803C
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957176; cv=none; b=Ood+KKlONbxCwZeAeUFKAyOexQkhY380NwQe5jCOzYidN3LnBOS27/HQrusiTS/mCTofep3Q3lLK8RejTtPhcp/3XICIp+ckyMhbXtpc4XbBi8pQD9en278vtfaE1IMSUQ0riJjXLij19ipU8BGDe2qA+psKdeVJNKuneYkqZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957176; c=relaxed/simple;
	bh=Deh/eIKuIIJmWDKMTvvNPLkpoi/hujWY50J6G1vHPe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiebZ9hLMxJReuTF37W6IxqaMzkBrT11LGmMDG900r7hWUlt9DEZiWeEp0tC6bAM8tbwNwwHYqxFPsDkMAEGWF4P4vew6W7LJrOCo605xJMKVAgK4l8H9NnOLifFgRxOeAt361CyIQh92gcawXQtKXCOhHkCK0iynE8nMkvdHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCi6nGCM; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCi6nGCM"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so224775e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957173; x=1784561973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DA/EPMcozA197ilQoMPWhddRL2aCpDFdpA8lrhPUEqI=;
        b=QCi6nGCMhhHAyNz8Ww8S9hXk3lpaNx9IqbzfJr2MC3nGG3N6TI3ffxtXg2FsI3ZxNo
         vP6XAUTlBdc3pwVvB+WaOBSk1eBgaXw3hLEUYh9o9NXYVoAyCyh4cStWiZQvUZeUPzzu
         l58J4RU9nnwpZ0HnWu2q2ba3O36JM1uT42kvEgLzjbkfYpdRYSITPi1e+sXLjclLUGZz
         KKkBIYNwnXerNtzwBQoWZOTqEssSCq59kCHhXytruXa9WflJ2Uo22GMP1/Mh5ZO8zzw5
         IQBiBzPSj6InCBlR9SOlnYRX4zWf+oI4Zx/PMgnPS4MIavCS+rCCSkrIqRGT7pxuHLAp
         Pv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957173; x=1784561973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DA/EPMcozA197ilQoMPWhddRL2aCpDFdpA8lrhPUEqI=;
        b=defmFsRsHtxWwkTUmy0qDx8b3F6WPcbPrFX2eVbqVxtBhvnTzUCRTF08slfYbvCyXV
         l4ovMZuRwEojrwaVoYMzvZ/NMMQB/VXw521aJCEaT49HsEEwDd3yTIkeq74wUnGbo1l0
         lJKBmjtFNsbrxZRoQdIChDW7KmtCr3bodiVRRmISy10FS8KGM9XPyXr2sHTBUoN3Y3tk
         0BKFBEhQE/3bIoxHXug9RbodNkdjs/nzD6W/PccjVWf4A5hxgBjO2NDvRukmkIscaDwX
         0OnvccT4i5OJbG7mXdeB+p4/3LyhvmVYbavsR5y4DeqqTXfa7O3an5m91jKBj4qLhulN
         MBYw==
X-Gm-Message-State: AOJu0YwYHHbdhmzFGEfCEmhjsfl88XH4+hoESky1yM8ZePvSoAeuSzvP
	0CfI6tKaGRxMSaUIOQVbbXBrA8MMTgU+kabAi00bwY2JWAOPDB8/OcvtA4pEaUJv
X-Gm-Gg: AfdE7ckipeNrZXHKodl8206z56UZlj/znoorD56OMMR0aaiLSTeouW3f1myybQOMJK3
	CzZRvQoBUh8hOmJdLX0HghoBlwFma8RZcE89ijmkekt6eWWpa2OZHaqwf4UI6PFnlcRjIpkfDIL
	pxyu3/dMobydCaX6iGpvxpYIED+MDA/+JfXCpzQXZz+82fK44aoSKnl7Flx1q7axpaCT+x9ouSk
	A4xoP3KLtPSMxXv0p6BbjcJQ2m+BDVagZifJ/3IRx0D22vhJlVeX26dPO5ho7/jerFyO5mL6Bfe
	X37u7nKKFLYFi9BSpMslVVV5fCmUMDiTzcogWLaKFMexduEOGh62QzH3Fn+5056SNmtBjyoxmiW
	13+jU93LOn2yT2uayt0zzzLvYC4RuBFwk9cpV8rqx2jGTZoA6wmm9HxYIrx6p0KH3tE2pvid9IA
	Nmq+f0b2MW4KYkEKFjc9eyjkUtQqzGjF+pmEbBuBNj12+qd1jdVcaINUA3jXgIgFwXgB5/U5OT1
	IzRYPfJzMIDF1TB+l07z3g8PgqPi9XnSl+qAc3Rae/OS15xuYh9LXiO2RKw+NzwWw==
X-Received: by 2002:a05:600c:6097:b0:493:faf3:3ead with SMTP id 5b1f17b1804b1-494033f5d7dmr28380185e9.4.1783957173431;
        Mon, 13 Jul 2026 08:39:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871cbd6sm4918555e9.3.2026.07.13.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:33 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 17/17] bpf: Gate verifier diagnostics on log level
Date: Mon, 13 Jul 2026 17:39:06 +0200
Message-ID: <20260713153910.2556007-18-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4058; i=memxor@gmail.com; h=from:subject; bh=Deh/eIKuIIJmWDKMTvvNPLkpoi/hujWY50J6G1vHPe4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURXnaz8scxqyW+t1Je6Qj5T1WbH3t75wqonY6v2Lfu R0d9vodpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMivEEaGSUYZsSZ7XqmJvrnX OvNauucu7gqGi3J7Yx99WH8/K14ngOG/q0nwUoFL8/grRRYkvzvaVsZ9pmBFh8emwyrJeYoyDPV MAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Verifier diagnostics collect active-path history and render richer reports for
selected verifier failures. That work is useful only when the caller requests
normal verifier log output.

Do not enable diagnostic collection or report rendering for BPF_LOG_STATS-only
loads. Stats-only loads still need the verifier's summary counters, but not
the extra path history used by diagnostic reports.

Keep enablement in the verifier environment and requested log mode so async
callback verification uses the same diagnostic policy as the main verifier
pass.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f7c5beb88217..9da36f850748 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5509,7 +5509,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * of caller's stack as shown on the example above.
 	 */
 	if (idx && subprog[idx].has_tail_call && depth >= 256) {
-		char *chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+		char *chain = bpf_diag_enabled(env) ?
+				      bpf_diag_alloc_subprog_call_chain(env, dinfo, idx) :
+				      NULL;
 
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
@@ -5543,11 +5545,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog_depth > env->max_stack_depth)
 			env->max_stack_depth = subprog_depth;
 		if (subprog_depth > MAX_BPF_STACK) {
-			char *chain;
+			char *chain = NULL;
 
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
-			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			if (bpf_diag_enabled(env))
+				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
 			bpf_diag_report_limit(env, subprog[idx].start, "subprogram stack depth",
 					      "Reduce stack usage in this subprogram, or move "
 					      "large data out of the BPF stack.",
@@ -5571,9 +5574,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
 				total, depth);
 			{
-				char *chain;
+				char *chain = NULL;
 
-				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+				if (bpf_diag_enabled(env))
+					chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
 				bpf_diag_report_limit(env, subprog[idx].start,
 						      "combined call stack depth",
 						      "Reduce stack usage or call depth along this "
@@ -5654,11 +5658,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
-			char *chain;
+			char *chain = NULL;
 
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
-			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			if (bpf_diag_enabled(env))
+				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
 			bpf_diag_report_limit(env, call_insn, "bpf2bpf call frames",
 					      "Reduce the number of nested bpf2bpf calls on this "
 					      "path.",
@@ -9963,11 +9968,12 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	int err;
 
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
-		char *chain;
+		char *chain = NULL;
 
 		verbose(env, "the call stack of %d frames is too deep\n",
 			state->curframe + 2);
-		chain = bpf_diag_alloc_state_call_chain(env, state, subprog);
+		if (bpf_diag_enabled(env))
+			chain = bpf_diag_alloc_state_call_chain(env, state, subprog);
 		bpf_diag_report_limit(env, callsite, "bpf2bpf call frames",
 				      "Reduce the number of nested bpf2bpf calls on this path.",
 				      "Call chain %s would create %d verifier call frames, "
-- 
2.53.0

