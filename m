Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6493C1966
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622414; cv=none; b=P+/G5TIvJLoySgIeErinDGAcuXlGmAV+GD+djRGcb46SCJctj7V6P7oHpsVhXCSkvwkBGbWnnEUqSKDbuqyo8Q2XZoNZBhG/prKXQfnPa9JP0edpJm1zJs9XeLlhdcjCvkZTqPnC4+lj11HqQHj9iFlLnVuESetCczPzKc6QFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622414; c=relaxed/simple;
	bh=pR0YwYBCq0LvBDGQ1bHpmQsE2+wDT1nZwvB3pW2LJEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB71ZDVMj8nfv0izgm/pgDX8cAtHFJYUX2FQxmXfE0pnXWhBme7otllOhkiDLXNmB7dUBb1PA+dCN5KBMFRpMg3/y6eoC2bgclDsKicQOhKxqAmh07YkFnm08Z7ocdx6oucfxCwfdn9oRSxQWla2alFU+uNZ1ws7W8D12gbgrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=ohIdozPI; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="ohIdozPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=5bPOyERYKjLocsbNZqpORDrD3tBc76pWkL
	cz6SoBTyM=; b=ohIdozPIolRfx4ulJlY5Z1fg4Tc1JBAALsvG+P5yBUUNlPesKG
	GUrpGZs3mI4EKilP0bDv/koWg1dA2AMsV2UecfFH+ShjyoCVVk9E6a1eESJrPhio
	T8LLBcpHG34IfdP+VTe91dCc/O+06Kh7yx+9+5HSLObgIuqMxx1W2RDGI=
Received: from localhost (unknown [222.195.81.43])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHcRiCeKtqFacqAQ--.500S2;
	Thu, 17 Sep 2026 13:20:03 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v4 1/2] bpf: Destroy callee-local dynptrs on subprog return
Date: Thu, 17 Sep 2026 13:19:59 +0800
Message-ID: <20260917052000.1589643-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917052000.1589643-1-xyx2021@mail.ustc.edu.cn>
References: <20260917052000.1589643-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCHcRiCeKtqFacqAQ--.500S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XryrWFy5GF45Gry5KFy8Krg_yoWxur48pF
	s5C3sFqr48Xr47KanrAr4kZFWYkF4Fqay3GrWY9a4fZF15tryDZF40gryrXwn0krWFyw47
	Za1avFs8XayUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bOxRgUUUUU=
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

Tell destroy_if_dynptr_stack_slot() when it is running for a departing
frame so the last-reference diagnostic describes a function return and
recommends releasing the resource before returning. Update the affected
callback test expectation in this change so this commit remains test-clean.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel.org
Suggested-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A9u-HhxY3UDA@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c                         | 51 ++++++++++++++++---
 .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cdf..4beca102c11d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -709,7 +709,8 @@ static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
-				        struct bpf_func_state *state, int spi);
+					struct bpf_func_state *state, int spi,
+					bool on_func_exit);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx,
@@ -732,10 +733,10 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	 * case they do belong to same dynptr, second call won't see slot_type
 	 * as STACK_DYNPTR and will simply skip destruction.
 	 */
-	err = destroy_if_dynptr_stack_slot(env, state, spi);
+	err = destroy_if_dynptr_stack_slot(env, state, spi, false);
 	if (err)
 		return err;
-	err = destroy_if_dynptr_stack_slot(env, state, spi - 1);
+	err = destroy_if_dynptr_stack_slot(env, state, spi - 1, false);
 	if (err)
 		return err;
 
@@ -843,8 +844,34 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
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
+		err = destroy_if_dynptr_stack_slot(env, callee, i, true);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
-				        struct bpf_func_state *state, int spi)
+					struct bpf_func_state *state, int spi,
+					bool on_func_exit)
 {
 	int err = 0;
 
@@ -867,6 +894,15 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	 */
 	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
 	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
+		if (on_func_exit) {
+			verbose(env, "cannot return with referenced dynptr in callee stack\n");
+			bpf_diag_res(env, env->insn_idx,
+				     "referenced dynptr on function return",
+				     "The departing stack frame contains the last dynptr that can release a referenced resource.",
+				     "Release the referenced resource before returning from this function.");
+			return -EINVAL;
+		}
+
 		verbose(env, "cannot overwrite referenced dynptr\n");
 		bpf_diag_res(
 			env, env->insn_idx, "referenced dynptr overwrite",
@@ -3630,7 +3666,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			env->insn_aux_data[insn_idx].nospec_result = true;
 	}
 
-	err = destroy_if_dynptr_stack_slot(env, state, spi);
+	err = destroy_if_dynptr_stack_slot(env, state, spi, false);
 	if (err)
 		return err;
 
@@ -3750,7 +3786,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		int spi;
 
 		spi = bpf_get_spi(i);
-		err = destroy_if_dynptr_stack_slot(env, state, spi);
+		err = destroy_if_dynptr_stack_slot(env, state, spi, false);
 		if (err)
 			return err;
 	}
@@ -11043,6 +11079,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			bpf_diag_mod_end(env);
 		}
 	}
+	err = destroy_dynptrs_on_func_exit(env, callee);
+	if (err)
+		return err;
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit. If iteration
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cd61d72c166f..24122addad327 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -125,9 +125,9 @@ static int missing_release_callback_fn(__u32 index, void *data)
 	return 0;
 }
 
-/* Any dynptr initialized within a callback must have bpf_dynptr_put called */
+/* A callback cannot return with the last dynptr for a referenced resource. */
 SEC("?raw_tp")
-__failure __msg("Unreleased reference id")
+__failure __msg("cannot return with referenced dynptr")
 int ringbuf_missing_release_callback(void *ctx)
 {
 	bpf_loop(10, missing_release_callback_fn, NULL, 0);
-- 
2.43.0

