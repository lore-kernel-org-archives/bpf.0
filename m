Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3FA4EA37A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577730; cv=none; b=qx7Pavmzei5fsGwATSQk5DKLeI9VGgzpdxAA/ULqCgx2mhKTkUeNuvSkjmiOzobbts4bj/OvJFu2FwgN3VulXEEqSQFeRiaR/mqLFrk69peZslCUgpcahHHlp9t/OShoC/zYfszoZ3QMSeh504ohs2aNE9x3xm9kV94H8BjEYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577730; c=relaxed/simple;
	bh=gMjaT5hA9VF+GVQsBhcMHUZOLtEqJEvu9tk5vfwqSIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mby0M0VXxLq4POC2ry89/pTVTtP/ibH/sA0T/7bloIN8hiYZJP1lwvwLye2j4+apxobpvoYqok8aENzD9JRaXT+S/BI5KtvnlAcVU4KPdBrAsuCsr1YJBqiTD3dwMGa8n2LK3BeUk0o4vnhfcaZcjuZQ8IqLVZtS1cqZQKAxOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RcceH2OX; arc=none smtp.client-ip=95.215.58.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RcceH2OX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gMjaT5hA9VF+GVQsBhcMHUZOLtEqJEvu9tk5vfwqSIM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577727; v=1; x=1792182527;
 b=RcceH2OX3UDQVWiOqIIXZhRuH8/nqKtSsVBK8093DBIwi3liVpMPJIwP9k5RLHoCXP+SjoxB
 6QiMTnJv6TJvVACl1lBqChFGedL4a386EWtnwv8o75C4Ohh30o7BnMPTxelMJP56A45aIl9f4nw
 qmSLXAdkn1rUzspH6GDxMkwg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 425e0ea8813fb66f;
	Fri, 09 Oct 2026 20:28:46 +0000
X-Mizu-Trace-ID: 425e0ea8813fb66f
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/11] bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
Date: Fri,  9 Oct 2026 13:27:55 -0700
Message-ID: <20261009202759.50520-9-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009202759.50520-1-ihor.solodrai@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dynptr argument to a bpf_user_ringbuf_drain() callback points to a
descriptor on the helper's stack. The descriptor and the sample it
describes are valid only during that callback invocation.

The callback can save the dynptr pointer, a slice, or a clone in the
caller's frame and use it after the drain returns. An escaped descriptor
pointer can allow arbitrary kernel read/write once the helper's stack
is reused.

The verifier assigns the dynptr a type and an id, but does not tie it
or its descendants to the callback's lifetime.

Anchor R1 to a frame reference so the argument and its descendants are
invalidated when the callback frame is popped.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c969fef2d452..edc78e50dc22 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -713,11 +713,12 @@ static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 	__mark_dynptr_reg(sreg2, type, false, id, parent_id);
 }
 
-static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg,
-			       enum bpf_dynptr_type type)
+static int mark_dynptr_cb_reg(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+			      struct bpf_func_state *callee, u32 regno,
+			      enum bpf_dynptr_type type)
 {
-	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0);
+	__mark_dynptr_reg(&callee->regs[regno], type, true, 0, 0);
+	return mark_frame_scoped_arg(env, state, callee, regno);
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
@@ -11456,11 +11457,15 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 					   struct bpf_func_state *callee,
 					   int insn_idx)
 {
+	int err;
+
 	/* bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void
 	 *			  callback_ctx, u64 flags);
 	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
 	 */
-	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
+	err = mark_dynptr_cb_reg(env, state, callee, BPF_REG_1, BPF_DYNPTR_TYPE_LOCAL);
+	if (err)
+		return err;
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
 	callee->in_callback_fn = true;
-- 
2.56.0

