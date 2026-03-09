Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF536BCC2
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089078; cv=none; b=jg3ifoW/PwJJXEhDX5b/KNglox5C6LVkPgzsfxjefsjDrkSWpSSuawkpEh+cakSn8ko4NnEYtQUGwapBtTAGJJcMvP4eyHrAtUWbM8vYHTAo+GFGCg+CqH4q5ixiQQvC2ZX2c94wzqIy2VwOoCj7ldAZ4dx99Hb4sUP7/uviFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089078; c=relaxed/simple;
	bh=mTtVyoZd9wwhl4sH2CMKi8MTP50dxmcsM8gJRSG9G3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+p/eJVADdbUOh1Bwl8QO4bjPhHrEdaamUoQ34MaapsVdImtBE+nBHRB+E83liuLoBFP2ZxbpEvELH+DHyI8uYbj7k7rEsr5tnkUoJVZ42UTE4uTwsnJjA7/8s3y83uPOwmSMc8x8i934b4xhQ4O7or6rpIyoYeVSRAW3iA4ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=FKxlG1u5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="FKxlG1u5"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506362ac5f7so111253681cf.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773089076; x=1773693876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S22c+whx0lMvvlfGW6Ok5/HfkkTI1IaoEqy7tR558lc=;
        b=FKxlG1u5YuW0aB2URh7EntbUykkZ+IViRv83f6lUjNs61t8fe+Js4Xq5JC9yZfQ9n7
         iks9EgquO7dqsuvSNvPz1jm1UZnT6gk1XtZoZsb3zwVMsYi23x58cf6L32K+uD/BcgLb
         IoydFf6jo27JKKZnH9IWwAZlP+ECWMbs9XT10poFoiE1XSjfwUwOmW6DfvAqA9H0D1AM
         ioV4sClG3et3mjhyvCTMu1MjGnyBqHI3q5+FtwUKbX3k/o8fYkTsFlO054/WHfEjbUZB
         4+9w8D+NvjTE0yYhRfh321sKzHomdEIR0vScCTbpIFtYssdPWRqhBzY4WgK8KgY4y2lx
         7LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773089076; x=1773693876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S22c+whx0lMvvlfGW6Ok5/HfkkTI1IaoEqy7tR558lc=;
        b=Hde3V2Um6KEN+X00eNprcoLONi5Ea6B3xyfnYFnHM9HaKuLAIqvqxDVBm6bp8ERQv+
         EVkON2z+5VrM7+iklLOjyW0bqS2x3Mi3ecRiIdzdtvjPLJirzTCuw593OkSw51oKCQ6N
         4cCkvDwumZt+6MS+V9P6x2Fw5IABePrRP7hX7km9ghV1cgg0KHsAtFu/W/UDtSRToSxO
         SftgD4swaybRtZwcoJuZ9wP0axfYSY0ArjzdYoS0uRzaiChGAUu/1/2sAXwDBJ+Cl1Dy
         pDj6gvhiW6hK8BGvsbZ+vewAfw5FwT6zxvlXYHI3TkTaTUB6nJ34+HIFsCk7qKn9x8qC
         GKZw==
X-Gm-Message-State: AOJu0YzGATovWMISmHvr7JNnuYrW6pisZOzms+83D3jHjne+JhUcVfHz
	W3m0cfUnKKPU5ZpcE7YvrKdReKdXISFDZrN63QyKKJaczsNG/4+RyRiu6zLr57kTuczuSsjFPeK
	KW5Ra
X-Gm-Gg: ATEYQzwdT1AsC5rFrjQS4B+1woL5ZuJVefft4OYggbI1BJM+wrMg2cG0MGJoUTaKUzW
	LGfWgL9rupbO4nmmKWIFxXWRsKxgzOoxy2YnPVSdwIEFUgwUaELBD+Tl5NEDUci9otVaIDX9ZZz
	cQMjc+oQGFB5FR5c47kZCPLKCbOSU4TvVYFj91L21wDvO2qpYx+kiTQIlUgZ5CrTjdp8ftrFsq6
	RjqxUkzpsEp0Bz/suoQfHZp/CRhYlmP+HF/F0DRumW2BXbOlyX+1PB71x/YTuJAgAkVpZ/gDZJY
	Z6La0/jvfiK57Hl1+OSZR0tT2HCoOS+beng7mucoH2xA1fpxlz9O3E2/vf5IGl3Co6Up5TqqHfM
	x+1PZ453alZ5/5LlIu58JU7gPljj6SnqX10I+UV5i9jdq4I5VdVQHZVdZgtb78LpRbE0BdAl9uS
	tFxEkTeppfTnkeh1iPI+WIOg==
X-Received: by 2002:a05:622a:11c7:b0:501:17b4:d559 with SMTP id d75a77b69052e-508f4916ce8mr164454441cf.20.1773089075540;
        Mon, 09 Mar 2026 13:44:35 -0700 (PDT)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f650ec74sm72109841cf.1.2026.03.09.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 13:44:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
Date: Mon,  9 Mar 2026 16:44:29 -0400
Message-ID: <20260309204430.201219-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260309204430.201219-1-emil@etsalapatis.com>
References: <20260309204430.201219-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier currently enforces a call stack depth of 8 frames,
regardless of the actual stack space consumption of those frames. The
limit is necessary for static call stacks, because the bookkeeping data
structures used by the verifier when stepping into static functions
during verification only support 8 stack frames. However, this
limitation only matters for static stack frames: Global subprogs are
verified by themselves and do not require limiting the call depth.

Relax this limitation to only apply to static stack frames. Verification
now only fails when there is a sequence of 8 calls to non-global
subprogs. Calling into a global subprog resets the counter. This allows
deeper call stacks, provided all frames still fit in the stack.

The change does not increase the maximum size of the call stack, only
the maximum number of frames we can place in it.

Also change the progs/test_global_func3.c selftest to use static
functions, since with the new patch it would otherwise unexpectedly
pass verification.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h                  |  9 ++++
 kernel/bpf/verifier.c                         | 52 ++++++++++++-------
 .../selftests/bpf/progs/test_global_func3.c   | 18 +++----
 3 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 090aa26d1c98..b45c3bb801c5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -651,6 +651,12 @@ enum priv_stack_mode {
 	PRIV_STACK_ADAPTIVE,
 };
 
+struct bpf_subprog_call_depth_info {
+	int ret_insn; /* caller instruction where we return to. */
+	int caller; /* caller subprogram idx */
+	int frame; /* # of consecutive static call stack frames on top of stack */
+};
+
 struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
@@ -678,6 +684,9 @@ struct bpf_subprog_info {
 
 	enum priv_stack_mode priv_stack_mode;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
+
+	/* temporary state used for call frame depth calculation */
+	struct bpf_subprog_call_depth_info dinfo;
 };
 
 struct bpf_verifier_env;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e4f69918693..ccd4efec179d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6733,9 +6733,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	struct bpf_insn *insn = env->prog->insnsi;
 	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
 	bool tail_call_reachable = false;
-	int ret_insn[MAX_CALL_FRAMES];
-	int ret_prog[MAX_CALL_FRAMES];
-	int j;
+	int total;
+	int tmp;
+
+	/* no caller idx */
+	subprog[idx].dinfo.caller = -1;
 
 	i = subprog[idx].start;
 	if (!priv_stack_supported)
@@ -6787,8 +6789,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	} else {
 		depth += subprog_depth;
 		if (depth > MAX_BPF_STACK) {
+			total = 0;
+			for (tmp = idx; tmp >= 0; tmp = subprog[tmp].dinfo.caller)
+				total++;
+
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
-				frame + 1, depth);
+				total, depth);
 			return -EACCES;
 		}
 	}
@@ -6802,10 +6808,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 			if (!is_bpf_throw_kfunc(insn + i))
 				continue;
-			if (subprog[idx].is_cb)
-				err = true;
-			for (int c = 0; c < frame && !err; c++) {
-				if (subprog[ret_prog[c]].is_cb) {
+			for (tmp = idx; tmp >= 0 && !err; tmp = subprog[tmp].dinfo.caller) {
+				if (subprog[tmp].is_cb) {
 					err = true;
 					break;
 				}
@@ -6821,8 +6825,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
 		/* remember insn and function to return to */
-		ret_insn[frame] = i + 1;
-		ret_prog[frame] = idx;
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
@@ -6842,7 +6844,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 				return -EINVAL;
 			}
 		}
+
+		/* store caller info for after we return from callee */
+		subprog[idx].dinfo.frame = frame;
+		subprog[idx].dinfo.ret_insn = i + 1;
+
+		/* push caller idx into callee's dinfo */
+		subprog[sidx].dinfo.caller = idx;
+
 		i = next_insn;
+
 		idx = sidx;
 		if (!priv_stack_supported)
 			subprog[idx].priv_stack_mode = NO_PRIV_STACK;
@@ -6850,7 +6861,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
 
-		frame++;
+		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
@@ -6864,12 +6875,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
 	 */
 	if (tail_call_reachable)
-		for (j = 0; j < frame; j++) {
-			if (subprog[ret_prog[j]].is_exception_cb) {
+		for (tmp = idx; tmp >= 0; tmp = subprog[tmp].dinfo.caller) {
+			if (subprog[tmp].is_exception_cb) {
 				verbose(env, "cannot tail call within exception cb\n");
 				return -EINVAL;
 			}
-			subprog[ret_prog[j]].tail_call_reachable = true;
+			subprog[tmp].tail_call_reachable = true;
 		}
 	if (subprog[0].tail_call_reachable)
 		env->prog->aux->tail_call_reachable = true;
@@ -6877,13 +6888,18 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	/* end of for() loop means the last insn of the 'subprog'
 	 * was reached. Doesn't matter whether it was JA or EXIT
 	 */
-	if (frame == 0)
+	if (frame == 0 && subprog[idx].dinfo.caller < 0)
 		return 0;
 	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
 		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
-	frame--;
-	i = ret_insn[frame];
-	idx = ret_prog[frame];
+
+	/* pop caller idx from callee */
+	idx = subprog[idx].dinfo.caller;
+
+	/* retrieve caller state from its frame */
+	frame = subprog[idx].dinfo.frame;
+	i = subprog[idx].dinfo.ret_insn;
+
 	goto continue_func;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 142b682d3c2f..974fd8c19561 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -5,56 +5,56 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
 {
 	return skb->len;
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f2(int val, struct __sk_buff *skb)
 {
 	return f1(skb) + val;
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f3(int val, struct __sk_buff *skb, int var)
 {
 	return f2(var, skb) + val;
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f4(struct __sk_buff *skb)
 {
 	return f3(1, skb, 2);
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f5(struct __sk_buff *skb)
 {
 	return f4(skb);
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f6(struct __sk_buff *skb)
 {
 	return f5(skb);
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f7(struct __sk_buff *skb)
 {
 	return f6(skb);
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f8(struct __sk_buff *skb)
 {
 	return f7(skb);
 }
 
 SEC("tc")
-__failure __msg("the call stack of 8 frames")
+__failure __msg("the call stack of 9 frames")
 int global_func3(struct __sk_buff *skb)
 {
 	return f8(skb);
-- 
2.49.0

