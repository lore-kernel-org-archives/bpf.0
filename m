Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911683;
	b=hNrd9gTFd9PUPJaxpyUh/7s5fZyZbuYRIX8+QCId/1FeZgkS0LmYwH22P7m1/Z7PNozX
	 YUtWGd1WT5ZVn6J6szfWbCErzdmx2XpSDaioSqbsi+6VkKNZgG885OLu4LCJ/9GjcWgYf
	 t4VTFYsFM3A2sbDZ/jo/mMIPGqRWCXUMw3RQmMlS7tBA4qkK4N2ETytGhsuZFV1Oxge8n
	 bRdTBw94aNMrybaupOYwpVVcP9uucvRVmwV7wFlu5cXiO8mSndGS4bIfDgYHp9TAQ85c8
	 +v5sKb1GHn/NmDThuwbFyh/l/1sb6/43CnvzStiBuGisbXnMFbcZITYbW/IRQDnhVIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q9NQtH6mvFsBz7h2u9ZhJ5YSEcZHbZ6BNNKzoLC9Q94=;
	b=L2voKopg0VdinJx71ClNNZe5LIFReffUVr8IQt36B19Si7TUhiNwWe0hzoLwda6KU0Yf
	 Jt3T+HYyAKjXDr3PDi5iZcMLVIIYbQSzYFexXa8PKyzqcQYApgUSij1/0E3F4FiiRXgjH
	 YR5op/MY53fXopOS8pmNA8gRplh1mmNNLQt7XFe+N1s5NvXNyGdIeqqSLjrEkSUkibaST
	 cBE6t7uFlExzDVsrz6Ofdw284eOdzv6lwcGFaHMv98YwZydjAW+wnPHYr2MBVp7dO0qxc
	 lAZwKU/+xvi0/rpm1jCufv/Ms7mS3SfrPF5uK56mI9lPE6a8dm0pWzw3VO6ENxdqo9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YolocH+O;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E69606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E69606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YolocH+O
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1078063a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911682; x=1794516482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9NQtH6mvFsBz7h2u9ZhJ5YSEcZHbZ6BNNKzoLC9Q94=;
        b=YolocH+OdHY/52MXS9W9OpcX+sEDrBBjSX2elnf2i9TTVt2CY58SBXFvBtrVbAmpaJ
         rpny/I9w+m1gM1317y7zTyAxo2vCBM/Gh+6GOLTyjYfF9BagLyJ3PgzIRBCYN98sWB+l
         d2I+vf/oceR4PyA68tVuvxfvlp3ioD7ttqU/teSwF7xstxbOuvfR9eary6/nJexWihmn
         TuVahTJ/Cz5l3gQtl6OlWHB6sVUMqG1cKxEZa0c/RjhOD8DHfWr1iC4TK5PFAYohMVOc
         c+WwcZJPwBW31uHij5R5RTrvOsQAvFnS33/PbOJYLoVJ5PpRKkx8YRi29WKfzhzVc47a
         keww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911682; x=1794516482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9NQtH6mvFsBz7h2u9ZhJ5YSEcZHbZ6BNNKzoLC9Q94=;
        b=r+d2FCEdJ0aDDvkrBrVuD8O78WzwrMAk2dwguIo3F0cOGgNtIezX7NCS5rMonx/CM3
         5xuOHYYZHv8B0p7qLTH7BqB3I8N6L+0DTS7YpwFeQdUDp9gU7FHWFbnBmzbx+SJIWuN8
         SsCS6BO4pPzQz13SG0Z0Kszr3PwqIwN5W5oVFZjkrw2nxt0Byrbz3BrhLyoNe+Z6buSX
         BhRQecmb+Fq3NgDWvAcksqqqTFuCyfbpkNrMOR9tdLgiM7NO4FkXCvEMNrXHBtZhfwJ3
         Eoq2o+sDV4//3UzRPW5P3pJncc93BNzpm22NRB7KEPHAc38HEOEIz02B6ueGm1GMll2Q
         n7rw==
X-Gm-Message-State: APuU4Z8nQcHaG6Mw0kg8TTt80K9WmI2OOJVKXZpUUzeUP6ITFfDEk8Ql
	pamVwak+nGtzMrZZO91tUbLck908ct///XPnKOtwDYnkrYYvEr49yfvEGtMtlg==
X-Gm-Gg: AYBFou20wvdm14lbmwwX1lr4MN6EzlF2ghWCLv9uccu+Bo3TphYFbOUKgR0m/kwg29o
	TWcTySgiP9Le95tIlYUoaB1r6zEESVLwG41lXEz/0FT9WfK0dSucUIHOkxtdHYIukt7TUn4IOJw
	tA60E/01wRKtSaeL/vkx4r9C7+FhKEx6v6yxX+mdH+DEX9Ok70EkacX6wc9poSj3Dxh7A4pXbRd
	TLf+CHP4aoSA6Ako+dCYecQwULXMsLPCQ5RWqr/5uJD/IWl42t1ORQu6DlImyUsBc5Poljzhzzh
	7YPs65xrwq8wN8ovC8Y2wPAuJri1ca86lM6d2iej+5Aiwaui6mubliz2FTWO7AzAPtecHfGQMga
	DXWyGOB5Oa2E76JtG5EGHDYuVK4hrwdqrw6RlognEPMIWuPmuVzx7bKNhC/1v9hqWSm67zFCRM/
	zh+bB/tt0TVg6UswDqOizlnXDHVJoJug8qALiAZ8nMEcRm/gpophbLhf/xtGZN7yd8jRUrOWkxs
	enxDfJaz4RnScdDQ6JSxN59c2bOlqoU/VEk1HLMycmnB08WDsET0vtcq4Yt+HknTF2CKoGveFUY
	tHmmkDQ17T0MzSI+7VHePZKYNHReSBoLRnC1pSI8NbIDb74WdLterx1nLdd5/8aoyCyX0Lq/uun
	yNu7LhN0eA7cLzQIpOZL1zLvQIIMRPY86Xji675gPeW5Y27tamr7NwzB38NDxy+6VdTgjwUsfsw
	==
X-Received: by 2002:a17:90a:e7cd:b0:3ac:a11a:7c79 with SMTP id 98e67ed59e1d1-3b0db6df03dmr167678a91.16.1793911682116;
        Thu, 05 Nov 2026 12:48:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42c65sm605219a91.4.2026.11.05.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:48:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 28/35] bpf: callx reads what the subprogs whose address is taken read
Date: Thu,  5 Nov 2026 20:45:05 +0000
Message-ID: <20261105204513.2230344-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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

core::fmt::write() is in each Rust prog that prints. It reads the options
of a '{}' and calls the fmt() function of the argument through a pointer:

  if n & 8 != 0  { arg_index = ...(template.cast_array().read()); }
  if n & 16 != 0 { opt.width = args.add(opt.width)...as_u16(); }
  if n & 32 != 0 { opt.precision = args.add(opt.precision)...as_u16(); }
  args.add(arg_index).as_ref().fmt(&mut Formatter::new(output, opt))?;

The last line is callx with two arguments, r1 and r2. The pass that finds
the live registers does not know the callee: callx counts as a read of
r1-r5. What the branches leave in r4 and r5 stays live:

  w4 &= 16
  if w4 == 0 goto +4          ; r4 = 0
  r3 <<= 4
  r4 = *(u64 *)(r10 - 24)     ; r4 = args, a pointer to arena
  ...
  callx r3

r4 is 0 or a pointer, r5 is a byte or a pointer. A number and a pointer
have no join: 4 states go to callx in the first pass over the loop, 2 in
each later pass, where 1 is enough. A subprog with callx in it also seems
to take 5 arguments: what its callers leave in r3-r5 is a part of its entry
state, and it is verified again for each such leftover.

callx calls only a static subprog whose address the prog takes: with
ld_imm64, or in a table in a read-only map. mark_recursive_subprogs() has
this set. Store it in addr_taken of bpf_subprog_info. The passes in flow.c
that look through callx ahead of the main pass read the bit already.
Nothing set it so far: they took no subprog for a target of callx.

  insn                        the registers of r1-r5 that it reads
  --------------------------  ---------------------------------------------
  call of a static subprog f  live at the first insn of f, as before
  callx, before               all
  callx, this patch           live at the first insn of a subprog that has
                              addr_taken, or declared in its BTF

bpf_compute_live_registers() finds both in one loop, until nothing changes.
zext_dst comes from the same result, thus check_func_callx_one() reports
a verifier bug if the callee has no addr_taken.

bpfland_stopping of scx_bpfland.rs: -9 % insns, -15 % states. 99 of the 225
progs of the schedulers of rust-bpf change: -3 % insns, -6 % states.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 28 ++++++++++++++++++++++++++--
 kernel/bpf/verifier.c | 11 ++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 290d6e8147de..c8f74063913c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2732,9 +2732,12 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			}
 			def = mask_widen(def);
 			use = mask_widen(use);
-			/* callx reads the address of the callee from dst_reg */
+			/*
+			 * callx reads the address of the callee from dst_reg. What the callee
+			 * reads is added in bpf_compute_live_registers().
+			 */
 			if (bpf_is_callx(insn))
-				use |= dst;
+				use = dst;
 			break;
 		default:
 			def = 0;
@@ -2801,6 +2804,25 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 
 	changed = true;
 	while (changed) {
+		u32 args = mask_widen(GENMASK(BPF_REG_5, BPF_REG_1)), callx_use = 0, declared;
+		bool taken = false;
+
+		/*
+		 * callx calls one of the subprogs whose address is taken, see
+		 * check_func_callx_one(). It reads what they read, as computed so far.
+		 */
+		for (subprog = 0; subprog < env->subprog_cnt; subprog++) {
+			if (!env->subprog_info[subprog].addr_taken)
+				continue;
+			callx_use |= state[env->subprog_info[subprog].start].in & args;
+			/* and what its BTF declares: the BTF is unreliable when one is not set */
+			declared = env->subprog_info[subprog].arg_slot_cnt;
+			callx_use |= mask_widen(GENMASK(declared, 1)) & args;
+			taken = true;
+		}
+		if (!taken)
+			callx_use = args;
+
 		changed = false;
 		/* a cycle of calls takes a round for each link */
 		if (signal_pending(current)) {
@@ -2829,6 +2851,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			    !bpf_subprog_is_global(env, callee_subprog(env, &insns[insn_idx])))
 				use |= state[insn_idx + insns[insn_idx].imm + 1].in &
 				       mask_widen(GENMASK(BPF_REG_5, BPF_REG_1));
+			if (bpf_is_callx(&insns[insn_idx]))
+				use |= callx_use;
 			new_in = (new_out & ~live->def) | use;
 			/* may_goto that is added at the head of a loop goes there */
 			t = bpf_head_guard_target(env, insn_idx);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d9323a7a552f..93eac926b392 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6059,6 +6059,8 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 	}
 	for_each_set_bit(s, callx, cnt)
 		bitmap_or(calls + s * words, calls + s * words, taken, cnt);
+	for_each_set_bit(s, taken, cnt)
+		si[s].addr_taken = true;
 
 	/*
 	 * Callers of a global subprog look at can_unwind before the subprog is verified.
@@ -11320,7 +11322,8 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 
 /*
  * The argument slots that the code of a static subprog takes, whatever its BTF says.
- * Liveness errs on the safe side: a callx in the subprog counts as a read of r1-r5.
+ * Liveness errs on the safe side: a callx in the subprog counts as a read of all that the subprogs
+ * whose address is taken read or declare.
  * But it misses r3-r5 of bpf_trace_printk() and the flags of bpf_get_branch_snapshot(), which
  * their protos do not declare. Such a subprog prints or passes a wrong number under a tracer.
  * The helpers are safe with any value there: the verifier never checks these registers.
@@ -12029,6 +12032,12 @@ static int check_func_callx_one(struct bpf_verifier_env *env, int subprog, int *
 	if (err == -EFAULT)
 		return err;
 
+	/* bpf_compute_live_registers() counts on it */
+	if (verifier_bug_if(!env->subprog_info[subprog].addr_taken, env,
+			    "callx of %s() whose address is not taken",
+			    bpf_subprog_name(env, subprog)))
+		return -EFAULT;
+
 	err = record_callx_edge(env, cur_func(env)->subprogno, subprog);
 	if (err)
 		return err;
-- 
2.55.0

