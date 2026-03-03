Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9A3822A0
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 04:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512277; cv=none; b=OzxB/qr8Xu2g+XlgP0EoiwLyBEa5GVXOPNF/Q+s4Bl6sYwVxg+7XqnB7quwvi6f9cJ57M83U532m8SH+gjJyzHQnLEaIDt2Ntm1gG8tdjN2CsaaBgAb+u1azWy7HPTa8OCztgC/zFRuT+zOd/3oACBSnQ5vlvaBkEv5Ya+ulN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512277; c=relaxed/simple;
	bh=aB22p6nO//saJbzGE5GROh6eEFQRLfmou7d5d9Y1xlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrtedXNrPUfUFZwD3KCBLQs0PcD7sr3L1NPN4lqki5L7MfSrSlK3JnEviu9leK+O5j7Fe4xu5TBBhchtOk1PoIuxszBYcgKI1dnTIHrAbNtMtPvOR76RjNEWNXCsKz2DSF4MzklomCuqYekkQowcfj3umyxhkMawwl2mwb3bV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=EafmCvgv; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="EafmCvgv"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899fb030812so23250266d6.2
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 20:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772512275; x=1773117075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUG4aM2JercIUUix60Q6rWBt5L2Lqy0BpyyOIpuE+Og=;
        b=EafmCvgvdvb6PLnOCwcxQ/agSc4Auwd8LKElUExNAaLpMM1ZLqefvFNiPuTXs6MlOa
         ByXNj+35pal8vBHpZv3eFRXg7qFNSi1fUOKZmuy/W4RpQ/O+PVrMcqEPY9vekM2xfjFz
         2ZKXKHJjmIvODCQKXi9To5tgXWbOouQDi54AbKByx8oQ/BZUg50GJDtZq87/RssmiP0K
         f1mXZc/dmfo7TgCNtVPZDlZrjTGAn0BSMYyAl/EG6Mq3UO7oa5yoWogqeEXEUU0NzFey
         go3Bh3j79v79rISLD1A8NGWuCmDHri3n6+DQtebhSpHbHeGNeHogobOmmy1xWS+6U1Dk
         MPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772512275; x=1773117075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUG4aM2JercIUUix60Q6rWBt5L2Lqy0BpyyOIpuE+Og=;
        b=GZLB/2XR2ol3EFkMrI4d67rmxlxqouhypIoxlwd3DFMrCKzbI8pHG6d/7SixRqvBUj
         d1AfD+3+Pf8gR7jxBaVZK/Bpuh6//uWBzYvMunfqimDtUrsZAjH1pNlaihkXcE/yKXlb
         cGn9L3amg1Yhw2ZuMmS011owkZCDccfDktZI/hYAIJhJR/FL9AmlRNKQQgyJv7WW237v
         5KesbnOO+VAbFM6kgyXOqj16wp6kWfUFLSe2iTBuXYXzYzTZYyZYqQN/rCpfWHqdoB0T
         CKbnXMG5+Arb5XVOMogPgqMHOBATRXPiH+ggsrkuISLViGhQn3t9x9FzTKgnEIH0WKYv
         gMNw==
X-Gm-Message-State: AOJu0Yy/yMQMD0plCTTG6CS1v0jH9T0q97pgBhsfbsstUC7FY+7LEoVM
	LBUDuQAUHZqgHBfXa+ZqBLBD3hosfY9JTQjMyjDo0oza61qSIjfWFkt0dYeLnF6nxHGxExuN4vj
	jQAYEeFE=
X-Gm-Gg: ATEYQzxZjSj6ihkIFTtKXN+CH/aJwLCqt2Nez0/fEX/DT9jBR4ZAztZl/LbAge9awLf
	aZcp4bXRe7uznGHiczRNxrBmJJs9WRwRtVCi4Z3fa2FQJGsiH3SWf3JRMZFXg14jwr+9OmTFLL9
	nsqwkxfXAygPXlKY0+xwS5AlUik7PA/lexRU6t+wDVWok07B9As5QCgFPsh4JO2cfO8ZYr/DVrn
	N4ZvYI/tqcZraaqBK2BEl7rCCMTH7mV2RT1+XgLI0rHol5s8hRKlbltiFkD5+ttGxndzHZgu8tK
	rtYox5iHg1fKQ8U4ZDL7zgwlrp2XHh36u6aVMy2RN2mp+mDnn9kytqRzXls/DlkwGE3XznxV47a
	fD4w/JqE9B7oI3ZQpvBOIj1MRhqUxtZohoFdEAnnE0797k26Z1ZG0VgbcOb4GCcjdCHKzxcyYTo
	OorNwxletCff15d1HDly/Buw==
X-Received: by 2002:a05:620a:3192:b0:8c7:1156:efd8 with SMTP id af79cd13be357-8cbc8decb67mr1776385285a.29.1772512275029;
        Mon, 02 Mar 2026 20:31:15 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a04849cb3sm20876966d6.6.2026.03.02.20.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:31:14 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
Date: Mon,  2 Mar 2026 23:31:05 -0500
Message-ID: <20260303043106.406099-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260303043106.406099-1-emil@etsalapatis.com>
References: <20260303043106.406099-1-emil@etsalapatis.com>
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
 include/linux/bpf_verifier.h                  |  6 +++
 kernel/bpf/verifier.c                         | 43 ++++++++++++-------
 .../selftests/bpf/progs/test_global_func3.c   | 18 ++++----
 3 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c1e30096ea7b..39a54e631bcd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -650,6 +650,8 @@ enum priv_stack_mode {
 	PRIV_STACK_ADAPTIVE,
 };
 
+struct bpf_subprog_info;
+
 struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
@@ -677,6 +679,10 @@ struct bpf_subprog_info {
 
 	enum priv_stack_mode priv_stack_mode;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
+
+	int ret_insn;
+	int frame;
+	int cidx;
 };
 
 struct bpf_verifier_env;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1153a828ce8d..d362ddd47d71 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6652,9 +6652,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
+	subprog[idx].cidx = -1;
 
 	i = subprog[idx].start;
 	if (!priv_stack_supported)
@@ -6706,8 +6708,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	} else {
 		depth += subprog_depth;
 		if (depth > MAX_BPF_STACK) {
+			for (total = 1; subprog[idx].cidx >= 0 ; total++)
+				idx = subprog[idx].cidx;
+
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
-				frame + 1, depth);
+				total, depth);
 			return -EACCES;
 		}
 	}
@@ -6723,8 +6728,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 				continue;
 			if (subprog[idx].is_cb)
 				err = true;
-			for (int c = 0; c < frame && !err; c++) {
-				if (subprog[ret_prog[c]].is_cb) {
+			for (tmp = idx; tmp >= 0 && !err; tmp = subprog[tmp].cidx) {
+				if (subprog[tmp].is_cb) {
 					err = true;
 					break;
 				}
@@ -6740,8 +6745,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
 		/* remember insn and function to return to */
-		ret_insn[frame] = i + 1;
-		ret_prog[frame] = idx;
+
+		subprog[idx].frame = frame;
+		subprog[idx].ret_insn = i + 1;
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
@@ -6762,6 +6768,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			}
 		}
 		i = next_insn;
+
+		/* caller idx */
+		subprog[sidx].cidx = idx;
 		idx = sidx;
 		if (!priv_stack_supported)
 			subprog[idx].priv_stack_mode = NO_PRIV_STACK;
@@ -6769,7 +6778,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
 
-		frame++;
+		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
@@ -6783,12 +6792,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
 	 */
 	if (tail_call_reachable)
-		for (j = 0; j < frame; j++) {
-			if (subprog[ret_prog[j]].is_exception_cb) {
+		for (tmp = idx; tmp >= 0; tmp = subprog[tmp].cidx) {
+			if (subprog[tmp].is_exception_cb) {
 				verbose(env, "cannot tail call within exception cb\n");
 				return -EINVAL;
 			}
-			subprog[ret_prog[j]].tail_call_reachable = true;
+			subprog[tmp].tail_call_reachable = true;
 		}
 	if (subprog[0].tail_call_reachable)
 		env->prog->aux->tail_call_reachable = true;
@@ -6796,13 +6805,15 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	/* end of for() loop means the last insn of the 'subprog'
 	 * was reached. Doesn't matter whether it was JA or EXIT
 	 */
-	if (frame == 0)
+	if (frame == 0 && subprog[idx].cidx < 0)
 		return 0;
 	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
 		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
-	frame--;
-	i = ret_insn[frame];
-	idx = ret_prog[frame];
+
+	idx = subprog[idx].cidx;
+	frame = subprog[idx].frame;
+	i = subprog[idx].ret_insn;
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

