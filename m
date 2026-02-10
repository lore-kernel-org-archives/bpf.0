Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D8278165
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759372; cv=none; b=t+EjSRMiyvMuCGnYHcovWdb/O/fA6KeX35aR8j/GNc0sdR/TmE+zpkwS0DNCGzowDB9Bi2BcX2NmDANTfFOIF9dyRw+cBOoGmy3SZZVNDpN1cxCQoKE8Y6g0IhQ3PwWwjwo9rPcjq1SkW6aHUoYpdZLgxdXGqb+Ftjk1uCR3hPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759372; c=relaxed/simple;
	bh=V0jxypAvyM1+z9rvxsM4/9YmZq69AiYDmWmBELYOs14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2OGV40fCsinw0cwej++s+Vj86G4atlogPKgyi59qdAeGMFksTgP+vm46/b5Z5wjpWfBU7DazTuYSBX1FX8lbs5K+5Ks0K18hhY1AC4EcD6HHesg0xT1iz+sKxwYDCpNz2UX4LJLJcmSRFZZMHFJmx+Pl0nKKDU60gtZXBXVOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=z/SO8i4u; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="z/SO8i4u"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50334dd44d2so53361331cf.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770759369; x=1771364169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KmSPGk+jaguVuXlrIgE/hPpqrZJRcpS0ueR0F8OkcLo=;
        b=z/SO8i4u7CA6cHl4oqWucDlL6WbHnFgZ9v46TgO8TNTTUtv4xDwJ0IjqZHrjDNLA9a
         bDHmwUksrzRM73TGMJqRKZ6wjBsMPQLfWAyXdhDO8Ju2aLdpQ3YEYMetDLbkvYamxBzH
         eik6Tk+aEWCd9KugXXqj/Oz/4OHlcLWFz8QuXRzElFG+ZG8iKocg6pBH9XgxHBKM0oDv
         YoYp6rzrzKJye1mc+4MmmVHTmIJn7QUXpGLlkKiXuQluSaWsgOvmZZQC5aZMVTC5aren
         Y2igz9nsCZVG7SKacPI/fkeXvu+hqTJRcuIgtJ/I8UELohPssh+tnaP6chq69R9DmUJB
         7uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770759369; x=1771364169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmSPGk+jaguVuXlrIgE/hPpqrZJRcpS0ueR0F8OkcLo=;
        b=dJdeSK1bulHtY1KpivJn3SqJiKlZAYsZU9vYNW1I+vSbPN0dtIIeGko6thC4RcOjO1
         prWtaubgMd4TVxBYC4HjdKAP/WRzsrSO46mSSuE+kQjm3SInH+l7cOs47AnuKYeKN8/m
         dxY5yrRSXr0wFA/v+LCXH7nQn6nJIYx7SLOmqq4wtQ0oVfov3f8IrWopGHji8Doks4Ut
         yGuDozJszy/gZdKPv/SW+VhzOvSNV8Nv2cwFOnXyzvG4OKDsJkSRKgPc4B/HxjxQ2Chr
         oCFOOo4E1HIgAR13Kkbm9d3jmLHT+JMHzaO9dukP1u/2dwXWJLH7afLu6YbfRISGSdpV
         ZlnA==
X-Gm-Message-State: AOJu0YwTUfMvrdbFfXQe0hnepCuroPA4Zlz/rD9KTH6SRR+6SVuVlD+L
	QxBTxC304bSEpplbk7HLGsWU5VDa3lL9hW41Jk2/9zOt3daaKm3YMqn4uZlrWA67SSretOJvUtq
	Y7nCX+6A=
X-Gm-Gg: AZuq6aKd89t/f0l7XSNJgH3/C2ihTgdY32NIXhFX2OPEAzgFepLLscmwmN8Rkw2hy16
	4dJ9AXHlOgjPJpSHu8xak1nRwAN+1CiEME8AG8B8RM1hgh3lgeCcroEd3n1Sl/T1xlQVnUCxYeK
	1GwVyWjWhTnlKAVZZgml0GF5vO/xuFRMAEWZnxWlRTZx3LVElNW2DvPurrzsE4iRQuVhafnAc27
	q4QfK8S0Xo5LNHSyhtakqjXNF65HvYu5q+/Z4oy8JHMg7qbxJgPmX2FQylvZWD2OzUAEjjOtGW3
	5arIuMYIms1Neo9V8e3ikQRtAJvHTogGMOB0EcFiyveNhfW+dBwTxmqgZUK9RCauBZP8WEpjS+s
	k9eyYJ4CAG+kVeJDjDIHnOozgFYbddpgaEC61F3qFgboCWAiwSLSQOMgDKi8uwcnW5anGFbf2sX
	oS01IggBRHwunS4nQXFSSLcg==
X-Received: by 2002:ac8:574a:0:b0:503:333f:9a25 with SMTP id d75a77b69052e-5068100d025mr10065311cf.2.1770759369295;
        Tue, 10 Feb 2026 13:36:09 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f2868sm1115772385a.3.2026.02.10.13.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:36:08 -0800 (PST)
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
Subject: [PATCH bpf-next v2] bpf: Bump maximum runtime call stack depth to 16
Date: Tue, 10 Feb 2026 16:36:06 -0500
Message-ID: <20260210213606.475415-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier currently limits the maximum runtime call stack to
8 frames. Larger BPF programs like sched-ext schedulers routinely
fail verification because they exceed this limit, even as they use
very little actual stack space for each frame.

Bump the maximum runtime call stack depth to 16 stack frames. Also
adjust selftests that assume the max runtime call stack depth is 8.

This patch does not change the verification time limit of 8 stack
frames. Static functions that are inlined for verification purposes
still only go 8 frames deep to avoid changing the verifier's internal
data structures used for verification. These data structures only
support holding information on up to 8 stack frames.

Global functions are each verified in isolation, so the old 8 stack
frame limit now only applies to call stacks composed entirely of
static function calls.

This patch also does not adjust the actual maximum stack size of 512.

CHANGELOG
=========

v1 -> v2 (https://lore.kernel.org/bpf/DG510ANGXEZH.BJ9EMMKHP5WT@etsalapatis.com)

- Adjust patch to only increase the runtime stack depth, leaving the
verification-time stack depth unchanged (Alexei)

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h                  |  3 +-
 kernel/bpf/verifier.c                         | 40 +++++++++-----
 .../selftests/bpf/progs/test_global_func3.c   | 52 ++++++++++++++++++-
 3 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ef8e45a362d9..057f52a6b840 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -321,7 +321,8 @@ struct bpf_func_state {
 	int allocated_stack;
 };
 
-#define MAX_CALL_FRAMES 8
+#define MAX_CALL_FRAMES 8 /* How many frames we can verify at the same time */
+#define MAX_CALL_DEPTH 16 /* How deep of a stack we can have at runtime */
 
 /* instruction history flags, used in bpf_jmp_history_entry.flags field */
 enum {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..7e41d1dad284 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6660,17 +6660,17 @@ static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
  * Since recursion is prevented by check_cfg() this algorithm
- * only needs a local stack of MAX_CALL_FRAMES to remember callsites
+ * only needs a local stack of MAX_CALL_DEPTH to remember callsites
  */
 static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 					 bool priv_stack_supported)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
-	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
+	int depth = 0, frame = 0, calldepth = 0, i, subprog_end, subprog_depth;
 	bool tail_call_reachable = false;
-	int ret_insn[MAX_CALL_FRAMES];
-	int ret_prog[MAX_CALL_FRAMES];
+	int ret_insn[MAX_CALL_DEPTH];
+	int ret_prog[MAX_CALL_DEPTH];
 	int j;
 
 	i = subprog[idx].start;
@@ -6724,7 +6724,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		depth += subprog_depth;
 		if (depth > MAX_BPF_STACK) {
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
-				frame + 1, depth);
+				calldepth + 1, depth);
 			return -EACCES;
 		}
 	}
@@ -6740,7 +6740,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 				continue;
 			if (subprog[idx].is_cb)
 				err = true;
-			for (int c = 0; c < frame && !err; c++) {
+			for (int c = 0; c < calldepth && !err; c++) {
 				if (subprog[ret_prog[c]].is_cb) {
 					err = true;
 					break;
@@ -6757,8 +6757,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
 		/* remember insn and function to return to */
-		ret_insn[frame] = i + 1;
-		ret_prog[frame] = idx;
+		ret_insn[calldepth] = i + 1;
+		ret_prog[calldepth] = idx;
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
@@ -6786,7 +6786,17 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
 
-		frame++;
+		if (!subprog_is_global(env, sidx))
+			frame++;
+		calldepth++;
+		/* Total call depth including globals */
+		if (calldepth >= MAX_CALL_DEPTH) {
+			verbose(env, "total call depth is %d frames, too deep\n",
+				calldepth);
+			return -E2BIG;
+		}
+
+		/* Total stack frames in use (globals not included). */
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
@@ -6800,7 +6810,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
 	 */
 	if (tail_call_reachable)
-		for (j = 0; j < frame; j++) {
+		for (j = 0; j < calldepth; j++) {
 			if (subprog[ret_prog[j]].is_exception_cb) {
 				verbose(env, "cannot tail call within exception cb\n");
 				return -EINVAL;
@@ -6813,13 +6823,15 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	/* end of for() loop means the last insn of the 'subprog'
 	 * was reached. Doesn't matter whether it was JA or EXIT
 	 */
-	if (frame == 0)
+	if (calldepth == 0)
 		return 0;
 	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
 		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
-	frame--;
-	i = ret_insn[frame];
-	idx = ret_prog[frame];
+	if (!subprog_is_global(env, idx))
+		frame--;
+	calldepth--;
+	i = ret_insn[calldepth];
+	idx = ret_prog[calldepth];
 	goto continue_func;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 142b682d3c2f..9cef3ee3b473 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -53,9 +53,57 @@ int f8(struct __sk_buff *skb)
 	return f7(skb);
 }
 
+__attribute__ ((noinline))
+int f9(struct __sk_buff *skb)
+{
+	return f8(skb);
+}
+
+__attribute__ ((noinline))
+int f10(struct __sk_buff *skb)
+{
+	return f9(skb);
+}
+
+__attribute__ ((noinline))
+int f11(struct __sk_buff *skb)
+{
+	return f10(skb);
+}
+
+__attribute__ ((noinline))
+int f12(struct __sk_buff *skb)
+{
+	return f11(skb);
+}
+
+__attribute__ ((noinline))
+int f13(struct __sk_buff *skb)
+{
+	return f12(skb);
+}
+
+__attribute__ ((noinline))
+int f14(struct __sk_buff *skb)
+{
+	return f13(skb);
+}
+
+__attribute__ ((noinline))
+int f15(struct __sk_buff *skb)
+{
+	return f14(skb);
+}
+
+__attribute__ ((noinline))
+int f16(struct __sk_buff *skb)
+{
+	return f15(skb);
+}
+
 SEC("tc")
-__failure __msg("the call stack of 8 frames")
+__failure __msg("total call depth is 16 frames, too deep")
 int global_func3(struct __sk_buff *skb)
 {
-	return f8(skb);
+	return f16(skb);
 }
-- 
2.49.0

