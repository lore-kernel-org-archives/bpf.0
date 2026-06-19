Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EE3BBA05
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902807; cv=none; b=Hjfglq0k2uI69IG6q5g0VJWItZ87GbzAfrtrazKVa2qU9dXLRCWAEuZJe8wBMJVhgvWbOJnpfoi2N4ySu1P+iei3x9tpM5dKNsH/DiX3Cu/NDGiE7OsKAc0FAxUaPXoOoQJ4AH+16jXm2yZCoFuODL7wVcVmGmuHeIxSvfFP1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902807; c=relaxed/simple;
	bh=C+TJlg5Mq5hj4XsCboajvS6mceTLJbD0mnjiCQvsfK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHUZrXZbOUrklqyiRiEncd55P57JrGDi+sX+Qu5dIgQ4XbgaXiyD0sqfpX1oW9ES6PfIX3JEWjJ7yRc7aZVMjs925OfLtmtTXOR5BhuKmjiSwZDupXq6i2EVx+3C733XL9DcOMx2pGDfw1vyBvKtq8Mvtr1485jso7Sl6nvEBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gypA9TNo; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gypA9TNo"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b9318997so17438175e9.2
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902794; x=1782507594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GsSkKk6M6t263pkTs75XCU17blcbQ67NmPhPEAdySY=;
        b=gypA9TNouWOQBGVYIYgIwzPNKaP0MHqIvPvMCsEAoEFD6jsv6XBGkOECBuDq87+cfd
         c3Uf6uyWbEIbEmk0Z0Lc/yrP8A3VNlXOyi5zSuufQaCuEMFzFmjbpugs3f2gi1yzx4ti
         BAxZAW/iJlgMyLnOYLZ1Gi1BNfzszVNRs5uMz/GhvzthtViBG64ngFPsv/3D5lsYTjAz
         ropdP2Q6dSvX4/SIVrjmLdzMz8SMXgqvbg7kj6fAfVLTvUwQDUslFwDiAvDAfdLMUaUP
         xun5QhKijzVHTtMjTTRIzZUGXC33w3K3amO1C1RUvGBG+ILFm0rgJSNryEPOKH50znCP
         xaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902794; x=1782507594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8GsSkKk6M6t263pkTs75XCU17blcbQ67NmPhPEAdySY=;
        b=M216RkH1zQfK4HKA+fi8mLECTkSBAih/EGPHL9IqulmfEAMpGUGjT1Z5JMGrvCXG6X
         dkCahRQYQwWuAzKhH0McBCMpJ6e277HKGQCftFkcXbZ3So/MW3KUl19SLHEBRmlBXYZS
         T44WTByPCjHMKZR2J3jGecyp67X4DMO82lzFTeDcHjjDGg7XZC3GdBc+0aCSoppufQKL
         FlexTJnwurdus1wq7E/N/jL+B10AWry7QZjAUz8W7bQb/YcFiZAAwTMxzrecGj3IeZMO
         oZrzASCdTvAm1Zrzf/GHOuFmX9hH3MFnxZ0WDWRM4W1QWEkF+rL+GpBjVDpsnF5btPlY
         8RRg==
X-Gm-Message-State: AOJu0Yz60YMTWXmDMZEg72qvXh1hq66FM9kBiMqb3MGjcUvjIiPpuy/Y
	cMoS+oIJn2Xtwj/qe2TE8e391QG7IsFxL0ArTo0Dy2DJM+4JWnKjevvuEgcrdUr2
X-Gm-Gg: AfdE7cnaOnKMzQPcelksER8A0ReihY9aRYrDAzcAZ29ZQCrMiwpdER7lDbz9lYKcLDG
	d/y2to4C9aeglXAtIoeFgdJbQ10q9IBD1peIhj3P7uOYz0mahYd7ejE76vlVn+3oZ51e52kL1xg
	e2Od17533WnAux/ter9aBxgAByKa7limGHqE3lAdcKjNJGO5o/lr+QxwMbMrGkwmqFSJw2oBvHk
	JcCRl37RnoppqFNfkw3Y7K1OZ5fEaWJCSVnrre4u+VGVOePW9apLbmGXgj4FSfQOZET+oD87Vvh
	FrP2ShFxZ9Iyzq71WY715Devi7QuH33FTDTmAm6kZT0bQXKpRiirk39POzn4TcnKQcEF0qh8P5k
	g87/yO0yKMJWK4hdVed1DWh5b57sU6SGvbdk244W6o/K9S4PNbQnJsFl0SQ9xVWlRpBPE+xlJ/p
	Ny5SSOS0AKDzVzhryr3JmeelDr0bI2lkLDDd8eH65uybX5Wd1NXltoEEddZLrPttGkQTyCA+V8Z
	OQwL4tO2Qcw92pGUEcZk7Fs4g5kJRSN9HvRa8wFWFPNuxi8yMt5dl8=
X-Received: by 2002:a05:600c:8b42:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4923f5944eemr107492295e9.33.1781902793666;
        Fri, 19 Jun 2026 13:59:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923392dsm25165575e9.2.2026.06.19.13.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 17/17] bpf: Gate verifier diagnostics on log level
Date: Fri, 19 Jun 2026 22:59:30 +0200
Message-ID: <20260619205934.1312876-18-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4858; i=memxor@gmail.com; h=from:subject; bh=C+TJlg5Mq5hj4XsCboajvS6mceTLJbD0mnjiCQvsfK0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct0FdOaVZIH+Co4TQ5EZq28E2jHeiLCca4+w/oJCrMMt Paf5rzWUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImk5DAyzFzEz2FsJ1zxyrP/ w3OmKduXLy/8LxrcdWjrdZnIvyLmUxkZpivduJe+lG3vgrdf9kg0Hkj2Os1Y5MPy58Q5mZOvvdf HsAEA
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
 kernel/bpf/diagnostics.c |  6 ++++++
 kernel/bpf/verifier.c    | 24 +++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index d27bd314d194..f10654dc6af8 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1162,6 +1162,9 @@ void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
 	char *reason, *text;
 	va_list args;
 
+	if (!bpf_diag_enabled(env))
+		return;
+
 	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_VERIFIER_LIMIT,
 			       "limit exceeded");
 	bpf_diag_report_section(env, "Reason");
@@ -2422,6 +2425,9 @@ void bpf_diag_print_history(struct bpf_verifier_env *env,
 	int start_idx;
 	u32 i;
 
+	if (!bpf_diag_enabled(env))
+		return;
+
 	bpf_diag_report_section(env, "Causal path");
 
 	if (!env->diag) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c60fe033271..cdba76eb35bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5359,7 +5359,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * of caller's stack as shown on the example above.
 	 */
 	if (idx && subprog[idx].has_tail_call && depth >= 256) {
-		char *chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+		char *chain = bpf_diag_enabled(env) ?
+			      bpf_diag_alloc_subprog_call_chain(env, dinfo, idx) :
+			      NULL;
 
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
@@ -5391,11 +5393,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
 			bpf_diag_report_limit(env, subprog[idx].start,
 					      "subprogram stack depth",
 					      "Reduce stack usage in this subprogram, or move large data out of the BPF stack.",
@@ -5417,9 +5420,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
 						      "Reduce stack usage or call depth along this call chain.",
@@ -5497,11 +5501,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
-			char *chain;
+			char *chain = NULL;
 
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
-			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			if (bpf_diag_enabled(env))
+				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
 			bpf_diag_report_limit(env, call_insn,
 					      "bpf2bpf call frames",
 					      "Reduce the number of nested bpf2bpf calls on this path.",
@@ -9760,11 +9765,12 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
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
 				      "Call chain %s would create %d verifier call frames, exceeding the %d frame limit",
-- 
2.53.0

