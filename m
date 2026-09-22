Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94E35C1BD
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039043; cv=none; b=tynajQ2KXnP+CfBUHZNxCnUBYcMU0CHATYOsEO4wt22vKf592SVBrNKKfB2gQ8CHJBnTfbb0E/yMbDvhmDC8yV8Xo15fGlJXDR93XXJIVAQKtUWRzbTqPKUGtD4tYyLg73KFVtMrABweZlHpgK2OxWWeN8EGhIVG28Oj7M0/2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039043; c=relaxed/simple;
	bh=zuITKrDzK/W04QHVPRkQzNSVbpIuObx0xfz+lo2tIGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kesSz7QeXI1AJev3J9LHhyQI3xRT5N/FwkzjxenHwpbEF0EWA8L1JBEN6T1EYOjspuFEXKpX+/2JBREyciwowthnrgp2RXnhZb0FJf4PyNYLDCyYiIzrm3OobjLeXV1A5+mDOFygfup+C4xTyJqV8e/N700u+FGiu7/F8xkl9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=po37Qn95; arc=none smtp.client-ip=95.215.58.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="po37Qn95"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zuITKrDzK/W04QHVPRkQzNSVbpIuObx0xfz+lo2tIGI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790039040; v=1; x=1790643840;
 b=po37Qn95s8NCUgBqP9yLGPar77/YYmG/1NrsB63a8GCcJauT084FtuoSlEZRrmxPCdFoizIa
 Z9D6J1WVdfXRzJcMaV5ocg3izUpNYgZo6aanH+15NuYPiHmjJBOz63FNtvBntqNYYEwDwP2LKr3
 Dd8fKAHknK4+8hVEre34TLYI=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 94195cd9d5b62b7a;
	Tue, 22 Sep 2026 01:04:00 +0000
X-Mizu-Trace-ID: 94195cd9d5b62b7a
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
Subject: [PATCH bpf-next v1 2/6] bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
Date: Mon, 21 Sep 2026 18:03:29 -0700
Message-ID: <20260922010333.1226537-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_user_ringbuf_drain() peeks a sample, initialises a struct
bpf_dynptr_kern on its own stack, passes it to the callback, and calls
__bpf_user_ringbuf_sample_release() as soon as the callback returns.
Neither the descriptor nor the sample it describes is valid afterwards.

set_user_ringbuf_callback_state() only gives the callback's R1 a type.
The callback can therefore store the CONST_PTR_TO_DYNPTR register into
callback_ctx, which points into a frame that outlives the call, and the
program can use it after the drain returns. Three routes reach past the
callback:

  - the register itself, spillable since v7.3-rc1, which points at a
    descriptor on reused kernel stack and gives the program an arbitrary
    kernel read/write

  - a bpf_dynptr_data() or bpf_dynptr_slice() result, which carries
    the dynptr's id as its parent_id

  - a bpf_dynptr_clone(), which is a by-value copy in the caller's
    frame and can be sliced after the drain returns

Declare R1 frame-scoped so all three are invalidated when the callback
frame is popped.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0a9d3d18f63..9775a6d38d3b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -707,11 +707,15 @@ static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 	__mark_dynptr_reg(sreg2, type, false, id, parent_id);
 }
 
-static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg,
+/*
+ * A callback dynptr argument is valid only until the frame is popped, so
+ * setup_func_entry() assigns its id along with the frame reference.
+ */
+static void mark_dynptr_cb_reg(struct bpf_func_state *callee, u32 regno,
 			       enum bpf_dynptr_type type)
 {
-	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0);
+	__mark_dynptr_reg(&callee->regs[regno], type, true, 0, 0);
+	mark_frame_scoped_arg(callee, regno);
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
@@ -10962,7 +10966,7 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
 	 */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
-	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
+	mark_dynptr_cb_reg(callee, BPF_REG_1, BPF_DYNPTR_TYPE_LOCAL);
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
 	/* unused */
-- 
2.55.0

