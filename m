Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829365;
	b=B7WuQJ8Mg2VIV+0x6Q5lO5ofJPT2mGw89VikkOd7U8t6BS10UK6BGMd+jv1Z1g/zMnKv
	 1sDwNjWHMQo/0JWgDL+TtiTJ+2CfYCHWwpxmN6cuw8nERVhbGOzoq1k22F06p0nWN3Les
	 bBhRut6nIlt2vW9V7VGhRIBo+zZeFlmngyJ/et4vNHw9Qs7+6EFHQeh6W0f2lO8+6/vHN
	 EkU0JkfKSYnR/0HBo/LP5wkUV08/aXDt5/dqzr5gFj4R0/fpabvIbs4PB+CAcoEh7pxay
	 8xD85cCskAJ5w9uxm3dPNKNr1dv1XM517DK9JWqEQQk/sHfq0pnTUeQURQ9yiQdRwlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sAJoJfE3nkXJ7yx10D2cQVkiaA5saG7UBkzdQrDunRw=;
	b=FzUbRnxm+NMCYmeJJOS+ipJjsre4bUyGIBfTQZeA/YNCoexJ7odpIcP7BJoKhIjBl4W4
	 hR7NyNWPq+cExGRQxfzzXbNyBma4cjMBKJrAO5x+LtrSUzhU/QTBqj0a9nNRFqUyDbZ0a
	 1hiceO4ptA3UYZFYjUpti2nx4ir1gA7FMgeSm1mSgItuZz+9sZqrX5CCDc6SZs0DhDBpM
	 AmhjCx7cqKGX6o2rkGw1wtLaukuCpz2Jz/o6EmQWQrYjIg/Xqig9nzLel1DtiE6DKU67d
	 lxYSUcfCzGbYzUjt/qqC+M5/7WBTVwe5ONraRFy5dHlxT7kM5jqsCSPp7A6F7iImCOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hg9TpYi5;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105B60BF2DD
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7105B60BF2DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hg9TpYi5
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05b210703so677649b3a.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829365; x=1794434165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAJoJfE3nkXJ7yx10D2cQVkiaA5saG7UBkzdQrDunRw=;
        b=hg9TpYi5c2VSVzGXGOExzO7p7pRD86RDQXe2k5lX/b//xqpPXi/haOEd4dazzysnpz
         Z/fYzYuq3mBpgA3pxA60A9YdhjvyGv6lKwSuhBxGce85hVfzHrNeb33nC6/FsI2Np5Sn
         fooZIH748LntudzX94HLiySE0Dw8/eDjyXienyDJJ1xQaCKakI2aW5vj5X4h0Js/eAlF
         mIew8j9SjbIOFJsBRi2K+OhvzQWnQwjtARtF4tcd6ZYkCIPBNYliBGkvVUv6Soe97ci3
         +x7RzlqeLUfxtAR5hjX0vC7DMhbDtBdgjyaqTd77B3CDfr+h4OA/PlqXjCP4uRHzRvVm
         q7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829365; x=1794434165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sAJoJfE3nkXJ7yx10D2cQVkiaA5saG7UBkzdQrDunRw=;
        b=G61b9o0Qeboa93TeHRR8hJmE6WD+5IsD7DZgCwZFiMGeLVLHAofGKj0nOV2VsuPWtB
         K4GJGISt42reiStIpyEUP+Qki88U6snpb6ZufWWtg+VsYtrBfa1oa1dDX77Unc59qUtU
         KLwLme5aK1crFluBJ+jcEVWlxgVBsEFOZSd5CHwmcOWMUPMsZ2oFc659IWMsifJD6Y95
         XWeC4sKlex8f7qS1VRXN7Hpv7WhZEPi4sq6aEWfIvgJa6fiiH8P0hIj+FLbB1L2YMJRy
         0StpUJgZgxlQEtpmTQ66YEL9Qs5wY6lahCUBsSnFQG1F/CJp7veP+jbhM0iruj3rg2zh
         iSeA==
X-Gm-Message-State: APuU4Z/1qHCmiJloP3Ku2sDeXZaCPukXOitO3Myl+HFfdvTUEwsyTefD
	j50VOR/HArMytj1Nq0bEneJCVxZDlUPfUPSaINu/uGDFnu2JoJovDpFVGCIujA==
X-Gm-Gg: AYBFou3233VJhkRQPG7fikgfrx5VqFq5a2P2V/r4WWt0uwUrq5D+iPUgZvQJZXVQtWW
	K4uqoRjEfV1zDiotRZ3nYG7QPqMG7c+mS3hFyd/rHGDhQYNwzUh2KW2ZNEPesHJMKcu+nYk1/hU
	q68mysCxiWiLkcY7iTPNSLMEOCI/KRrQhouPapDPbOfwxpFgW5mprMVsx8TJdGaqdzIyZuGuSEz
	W2LUijL0in2++Riahlpt6+bYzsIiyF4P3yqzIAF62gzebcLEYPjQv44ieCHUyihn7OwK+uFycAj
	pqGrPD2vHD91Vg6Hn3lbsKhqWnVLFdG2/x2hdePq9jdxizk5PTSE5k13kFuQ4yY54K3wkRsibtU
	ths6WxpXLufkZZku/mOoJHHgeJclvnLV1TTDRLvva3vVk9xh7wAYBwEG2quON9NDQLa/bgQMgmH
	1fY5SEoOqhJG+CmAfiqa8reLwM8GTJ7aPnJ6k9dawnb+DIqIlt+m/IDOVccajX8BDRET39/cH0g
	817JY+Vli4uHQ5CPvvyO51DQZdHQ7MUn+DvgPIF+5bTDJ06pbFtcjVr+QCxusGZW93DmrT0DUYA
	M+qzB4Y+p3ApOxjLPalHt6dDe520s7fTMpNzcAhRzpWDE0G9c5jpo0GQvkPB1ZHn/MIGJBHCd3Q
	VgWcMaGFBUTFq8WqeIdC2CThRJ2kM6crFT/45ZivxZyR9aSO1hvhwdPkEn+K7ikCRptG0Z5OSoQ
	==
X-Received: by 2002:a05:6a00:b90:b0:89f:c156:d209 with SMTP id d2e1a72fcca58-8a9beb6a102mr15103006b3a.39.1793829364463;
        Wed, 04 Nov 2026 13:56:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b1ee455336sm123263b3a.54.2026.11.04.13.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:56:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 6/9] bpf: Use the call graph to compute the depth of chains of calls
Date: Wed,  4 Nov 2026 21:55:20 +0000
Message-ID: <20261104215523.1852636-7-alexei.starovoitov@gmail.com>
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

Three sums are left in the walk of the chains of calls: the bytes of stack,
the bytes of the stack in arena, and the number of frames since the last
global subprog.

The walk adds them up for every chain. Only the largest sum counts, and it
follows from the largest sums of the callers:

  depth(callee) = max over the callers (depth(caller) + frame(caller))

Start with 0 at the main prog and at the async callbacks, and repeat until
nothing changes. The graph has no cycles, so this comes to an end. Then
compare the sums of every live subprog with the limits.

As before, the sums have the frames as the main verification pass leaves
them. What later passes add to a frame, like the inlined bpf_loop(), is not
counted.

Nothing is left in the walk. Remove it.

Time to load N global functions that call the next one in both branches of
an 'if':

    N    before     after
   16      4 ms    0.4 ms
   20     70 ms    0.5 ms
   24    1.3 sec   0.6 ms
   28     24 sec   0.7 ms
   60         -    1.3 ms
  250         -    5.7 ms

250 global functions where each one calls all that follow, 31125 calls,
load in 20 ms.

The messages are the same. The subprog that goes over a limit is reported,
and not what it calls. When several subprogs go over it, the message is
about the first one in the prog and has the numbers of its longest chain,
and not of the chain that the walk got to first. A prog that breaks two
rules can get the other message and errno.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 282 +++++++++++++++++++-----------------------
 1 file changed, 129 insertions(+), 153 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5362687eba8b..b8f4549da6db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6045,170 +6045,159 @@ static void mark_arena_stack_entries(struct bpf_verifier_env *env, struct bpf_ca
 
 /* temporary state used for call frame depth calculation */
 struct bpf_subprog_call_depth_info {
-	int ret_insn; /* caller instruction where we return to. */
-	int caller; /* caller subprogram idx */
-	int frame; /* # of consecutive static call stack frames on top of stack */
-	int callx_insn; /* callx instruction whose callees are being walked */
-	int callx_next; /* next callee of callx_insn to walk */
+	int caller; /* the caller that has the most on the stack. -1: the kernel */
+	int depth; /* the most that the frames of the callers take. -1: not known yet */
+	int arena_depth; /* the same in the stack in arena */
+	int frame; /* the most consecutive static call stack frames on top of stack */
 };
 
-/* starting from main bpf function walk all instructions of the function
- * and recursively walk all callees that given function can call.
- * Ignore jump and exit insns.
- */
-static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
-					 struct bpf_subprog_call_depth_info *dinfo)
+/* what the frame of the subprog adds to the frames of its callers */
+static int subprog_stack_size(struct bpf_verifier_env *env, int s)
 {
-	struct bpf_subprog_info *subprog = env->subprog_info;
-	struct bpf_insn *insn = env->prog->insnsi;
-	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
-	int arena_depth = 0;
-	int total;
-	int tmp;
-
-	/* no caller idx */
-	dinfo[idx].caller = -1;
-
-	i = subprog[idx].start;
-process_func:
-	dinfo[idx].callx_insn = -1;
-
-	/* protect against potential stack overflow that might happen when
-	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
-	 * depth for such case down to 256 so that the worst case scenario
-	 * would result in 8k stack size (32 which is tailcall limit * 256 =
-	 * 8k).
-	 *
-	 * To get the idea what might happen, see an example:
-	 * func1 -> sub rsp, 128
-	 *  subfunc1 -> sub rsp, 256
-	 *  tailcall1 -> add rsp, 256
-	 *   func2 -> sub rsp, 192 (total stack size = 128 + 192 = 320)
-	 *   subfunc2 -> sub rsp, 64
-	 *   subfunc22 -> sub rsp, 128
-	 *   tailcall2 -> add rsp, 128
-	 *    func3 -> sub rsp, 32 (total stack size 128 + 192 + 64 + 32 = 416)
-	 *
-	 * tailcall will unwind the current stack frame but it will not get rid
-	 * of caller's stack as shown on the example above.
-	 */
-	arena_depth += subprog[idx].arena_stack_depth;
-	if (arena_depth > env->max_arena_stack_depth)
-		env->max_arena_stack_depth = arena_depth;
-	if (arena_depth > BPF_ARENA_STACK_MAX) {
-		verbose(env, "combined size of the frames in the stack in arena is %d. Too large\n",
-			arena_depth);
-		return -EACCES;
-	}
+	struct bpf_subprog_info *sub = &env->subprog_info[s];
 
-	if (idx && subprog[idx].has_tail_call && depth >= 256) {
-		verbose(env,
-			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
-			depth);
-		return -EACCES;
-	}
+	if (sub->priv_stack_mode == PRIV_STACK_ADAPTIVE)
+		return 0;
+	return round_up_stack_depth(env, sub->stack_depth);
+}
 
-	subprog_depth = round_up_stack_depth(env, subprog[idx].stack_depth);
-	if (subprog[idx].priv_stack_mode == PRIV_STACK_ADAPTIVE) {
-		if (subprog_depth > env->max_stack_depth)
-			env->max_stack_depth = subprog_depth;
-		if (subprog_depth > env->stack_limit) {
-			verbose(env, "stack size of subprog %d is %d. Too large\n",
-				idx, subprog_depth);
-			return -EACCES;
-		}
-	} else {
-		depth += subprog_depth;
-		if (depth > env->max_stack_depth)
-			env->max_stack_depth = depth;
-		if (depth > env->stack_limit) {
-			total = 0;
-			for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
-				total++;
+/*
+ * A subprog is entered with no more than what one of its callers is entered with plus
+ * the frame of that caller. The graph has no cycles, so this comes to an end.
+ */
+static void compute_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph *cg,
+			       struct bpf_subprog_call_depth_info *dinfo)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_subprog_call_depth_info *callee;
+	int depth, arena_depth, frame, j, s;
+	bool changed;
 
-			verbose(env, "combined stack size of %d calls is %d. Too large\n",
-				total, depth);
-			return -EACCES;
-		}
+	for (s = 0; s < cg->cnt; s++) {
+		dinfo[s].caller = -1;
+		dinfo[s].depth = !s || si[s].is_async_cb ? 0 : -1;
 	}
-continue_func:
-	subprog_end = subprog[idx + 1].start;
-	for (; i < subprog_end; i++) {
-		int next_insn, sidx;
-
-		if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i)) {
-			/*
-			 * Walk the callees and the callbacks recorded by
-			 * the main verification pass one by one, returning to
-			 * this insn after each.
-			 */
-			if (dinfo[idx].callx_insn != i) {
-				dinfo[idx].callx_insn = i;
-				dinfo[idx].callx_next = 0;
-			}
-			sidx = next_callx_callee(env, idx, dinfo[idx].callx_next);
-			if (sidx < 0)
+	do {
+		cond_resched();
+		changed = false;
+		for_each_set_bit(s, cg->live, cg->cnt) {
+			if (dinfo[s].depth < 0)
 				continue;
-			dinfo[idx].callx_next = sidx + 1;
-			dinfo[idx].ret_insn = i;
-			next_insn = subprog[sidx].start;
-		} else if (bpf_pseudo_call(insn + i) || bpf_pseudo_func(insn + i)) {
-			/* find the callee */
-			next_insn = i + insn[i].imm + 1;
-			sidx = bpf_find_subprog(env, next_insn);
-			if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next_insn))
-				return -EFAULT;
-			if (subprog[sidx].is_async_cb) {
-				/* async callbacks don't increase bpf prog stack size unless called directly */
-				if (!bpf_pseudo_call(insn + i))
+			depth = dinfo[s].depth + subprog_stack_size(env, s);
+			arena_depth = dinfo[s].arena_depth + si[s].arena_stack_depth;
+			for_each_set_bit(j, subprog_calls(cg, s), cg->cnt) {
+				callee = &dinfo[j];
+				frame = bpf_subprog_is_global(env, j) ? 0 : dinfo[s].frame + 1;
+				if (depth <= callee->depth && arena_depth <= callee->arena_depth &&
+				    frame <= callee->frame)
 					continue;
+				if (depth > callee->depth) {
+					callee->depth = depth;
+					callee->caller = s;
+				}
+				callee->arena_depth = max(callee->arena_depth, arena_depth);
+				callee->frame = max(callee->frame, frame);
+				changed = true;
 			}
-			/* remember insn to return to */
-			dinfo[idx].ret_insn = i + 1;
-		} else {
-			continue;
 		}
+	} while (changed);
+}
 
-		/* store caller info for after we return from callee */
-		dinfo[idx].frame = frame;
+static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_subprog_call_depth_info *dinfo;
+	int depth, total, tmp, s, err;
 
-		/* push caller idx into callee's dinfo */
-		dinfo[sidx].caller = idx;
+	dinfo = kvzalloc_objs(*dinfo, cg->cnt, GFP_KERNEL_ACCOUNT);
+	if (!dinfo)
+		return -ENOMEM;
+	compute_call_depth(env, cg, dinfo);
 
-		i = next_insn;
+	for_each_set_bit(s, cg->live, cg->cnt) {
+		/* A caller of it is over a limit. That one is reported, not what it calls. */
+		if (dinfo[s].frame > MAX_CALL_FRAMES || dinfo[s].depth > env->stack_limit ||
+		    dinfo[s].arena_depth > BPF_ARENA_STACK_MAX)
+			continue;
 
-		idx = sidx;
-		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
-		if (frame >= MAX_CALL_FRAMES) {
+		err = -E2BIG;
+		if (dinfo[s].frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
-				frame);
-			return -E2BIG;
+				dinfo[s].frame);
+			goto out;
 		}
-		goto process_func;
-	}
-	/* end of for() loop means the last insn of the 'subprog'
-	 * was reached. Doesn't matter whether it was JA or EXIT
-	 */
-	if (frame == 0 && dinfo[idx].caller < 0)
-		return 0;
-	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
-		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
-	arena_depth -= subprog[idx].arena_stack_depth;
 
-	/* pop caller idx from callee */
-	idx = dinfo[idx].caller;
+		err = -EACCES;
+		depth = dinfo[s].arena_depth + si[s].arena_stack_depth;
+		if (depth > env->max_arena_stack_depth)
+			env->max_arena_stack_depth = depth;
+		if (depth > BPF_ARENA_STACK_MAX) {
+			verbose(env, "combined size of the frames in the stack in arena is %d. Too large\n",
+				depth);
+			goto out;
+		}
 
-	/* retrieve caller state from its frame */
-	frame = dinfo[idx].frame;
-	i = dinfo[idx].ret_insn;
+		/*
+		 * protect against potential stack overflow that might happen when
+		 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
+		 * depth for such case down to 256 so that the worst case scenario
+		 * would result in 8k stack size (32 which is tailcall limit * 256 =
+		 * 8k).
+		 *
+		 * To get the idea what might happen, see an example:
+		 * func1 -> sub rsp, 128
+		 *  subfunc1 -> sub rsp, 256
+		 *  tailcall1 -> add rsp, 256
+		 *   func2 -> sub rsp, 192 (total stack size = 128 + 192 = 320)
+		 *   subfunc2 -> sub rsp, 64
+		 *   subfunc22 -> sub rsp, 128
+		 *   tailcall2 -> add rsp, 128
+		 *    func3 -> sub rsp, 32 (total stack size 128 + 192 + 64 + 32 = 416)
+		 *
+		 * tailcall will unwind the current stack frame but it will not get rid
+		 * of caller's stack as shown on the example above.
+		 */
+		depth = dinfo[s].depth;
+		if (s && si[s].has_tail_call && depth >= 256) {
+			verbose(env,
+				"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
+				depth);
+			goto out;
+		}
 
-	goto continue_func;
+		if (si[s].priv_stack_mode == PRIV_STACK_ADAPTIVE) {
+			depth = round_up_stack_depth(env, si[s].stack_depth);
+			if (depth > env->max_stack_depth)
+				env->max_stack_depth = depth;
+			if (depth > env->stack_limit) {
+				verbose(env, "stack size of subprog %d is %d. Too large\n",
+					s, depth);
+				goto out;
+			}
+			continue;
+		}
+		depth = dinfo[s].depth + subprog_stack_size(env, s);
+		if (depth > env->max_stack_depth)
+			env->max_stack_depth = depth;
+		if (depth > env->stack_limit) {
+			total = 0;
+			for (tmp = s; tmp >= 0; tmp = dinfo[tmp].caller)
+				total++;
+
+			verbose(env, "combined stack size of %d calls is %d. Too large\n",
+				total, depth);
+			goto out;
+		}
+	}
+	err = 0;
+out:
+	kvfree(dinfo);
+	return err;
 }
 
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	enum priv_stack_mode priv_stack_mode = PRIV_STACK_UNKNOWN;
-	struct bpf_subprog_call_depth_info *dinfo = NULL;
 	struct bpf_subprog_info *si = env->subprog_info;
 	struct bpf_call_graph cg = {};
 	int s, ret;
@@ -6264,21 +6253,8 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		}
 	}
 
-	dinfo = kvzalloc_objs(*dinfo, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
-	if (!dinfo) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	for (int i = env->subprog_cnt - 1; i >= 0; i--) {
-		if (!i || si[i].is_async_cb) {
-			ret = check_max_stack_depth_subprog(env, i, dinfo);
-			if (ret < 0)
-				goto out;
-		}
-	}
+	ret = check_call_depth(env, &cg);
 out:
-	kvfree(dinfo);
 	kvfree(cg.calls);
 	return ret;
 }
-- 
2.55.0

