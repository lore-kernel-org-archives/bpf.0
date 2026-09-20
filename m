Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43503612DB
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938283; cv=none; b=M0OFM0bXoC4/Y4wmK/Y8hJJG/A+GTO+kiEWD0JBYjvH+4rDMxfNsz99VzZWdJtlZ2cbm/JHaqFwgmhaGFbFYCbaKeYckYzpLRX6T51aVcXaKosyqIahRF6b/NSTibWMHGrwcfZh8eEjkwsPulIJCBxNi8WCTXhNre8AfBd3b9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938283; c=relaxed/simple;
	bh=QJnothmHygug47bquJnhMV+w3gxfxOrYiX5x9gT85DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGOP2+WDkiC1iKaTviIhtBYH0T4Jkt3LHOYgbzXOvhTsR2Bug8dmX0ZCybbpXyxzHem7gdlkwlLmjv9IPL5IFwmsgkUMYSmJngJxb+dqBELgEOv3wSOuqcf+fYK8Cj7fOBh3zTvuk0NSkHpMf5rxCaqSL2NKxeN5YU491Mkh2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=lyhBlmA7; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="lyhBlmA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=tIlPY3f6TfHJ9BOcet6e4/AMrf2CqaMqVt
	Hn/Bj96Ms=; b=lyhBlmA7w3oM3x5E6ZBSKWEV82awXP8/pxW62OteJEKxb6WSo8
	kQ1OnT2+BeCRxbZUWrION4Qp7BQ1rdtz8Pd182hq4d5aQ6eRwJsLboiIuGT7g7/L
	y+QU+7oypVj/I0O03rJgUZQW+e9SKZHjeiuC1Z9MEl0MDBW11jdAZHs/I=
Received: from localhost (unknown [222.195.81.68])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBnajFoSrBqBjFAAQ--.2097S2;
	Mon, 21 Sep 2026 05:04:40 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v5 1/2] bpf: Destroy callee-local dynptrs on subprog return
Date: Mon, 21 Sep 2026 05:04:37 +0800
Message-ID: <20260920210438.345847-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920210438.345847-1-xyx2021@mail.ustc.edu.cn>
References: <20260920210438.345847-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBnajFoSrBqBjFAAQ--.2097S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWDGF4UGr1fZFWxAFy8Grg_yoWrZr17pF
	4ru39FqF48tF42kwnrZr4kZF1Yyan5Xay3GrWYk34fAF1Fyry3ZF40gry5XrnIkrW0yw4j
	v3Wavrs8Ja1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r
	1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6F4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYbL07UUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

A data slice is valid only while the specific dynptr that produced it
remains valid. prepare_func_exit() copies a subprogram return value into
the caller and then frees the callee state without applying the normal
destruction semantics to dynptrs in the callee stack.

A callee can therefore derive a slice from a local dynptr, return or spill
the slice into its caller, and then let the dynptr disappear with the
callee frame. The slice retains the id of a dynptr that is no longer in the
verifier state, so the verifier continues to accept accesses through it.

Before the object relationship refactor, bpf_dynptr_data() slices from
referenced dynptrs also carried the shared reference id, allowing a later
release to catch some of these escaped slices. The refactor made those
slices precise children of their source dynptr and exposed the missing
teardown as an accepted stale access even after the shared resource is
released.

Before freeing a callee, scan the first slot of every dynptr in its stack
and call destroy_if_dynptr_stack_slot(). The existing teardown rejects
losing the last dynptr for a referenced resource and invalidates the dynptr
and all of its descendants, including slices held in the caller. Propagate
any teardown error through prepare_func_exit().

Reuse the existing teardown API and diagnostic. Update the affected
callback test expectation in this change so the commit remains test-clean.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel.org
Suggested-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A9u-HhxY3UDA@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c                         | 28 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 18aad4886f9cf..99b8f9add5c47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -843,6 +843,31 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
 	return ref_cnt;
 }
 
+static int destroy_dynptrs_on_func_exit(struct bpf_verifier_env *env,
+					struct bpf_func_state *callee)
+{
+	int i, err;
+
+	for (i = 0; i < callee->allocated_stack / BPF_REG_SIZE; i++) {
+		struct bpf_stack_state *slot = &callee->stack[i];
+
+		if (slot->slot_type[0] != STACK_DYNPTR ||
+		    !slot->spilled_ptr.dynptr.first_slot)
+			continue;
+
+		/*
+		 * A callee-local dynptr is destroyed when its stack frame goes
+		 * away. Apply the normal stack-slot teardown so references cannot
+		 * be lost and slices derived from that dynptr are invalidated.
+		 */
+		err = destroy_if_dynptr_stack_slot(env, callee, i);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
@@ -11061,6 +11086,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			bpf_diag_mod_end(env);
 		}
 	}
+	err = destroy_dynptrs_on_func_exit(env, callee);
+	if (err)
+		return err;
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit. If iteration
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cd61d72c166f..55c9a6be7fc56 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -125,9 +125,9 @@ static int missing_release_callback_fn(__u32 index, void *data)
 	return 0;
 }
 
-/* Any dynptr initialized within a callback must have bpf_dynptr_put called */
+/* A callback cannot return with the last dynptr for a referenced resource. */
 SEC("?raw_tp")
-__failure __msg("Unreleased reference id")
+__failure __msg("cannot overwrite referenced dynptr")
 int ringbuf_missing_release_callback(void *ctx)
 {
 	bpf_loop(10, missing_release_callback_fn, NULL, 0);
-- 
2.43.0

