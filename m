Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9FD3E16A1
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510730; cv=none; b=OBthkNgxfTJktay5JQGBjUca6XQMoc0RQPIoUfBSaDPwZCp1pyyRNBYyImb8o5PWflAN7na1TPWYK8rSgn9d3tLKbbyedRb8ebYrRQDVKyAPLgPUANv+ZBSsyGaDNOYJ+zqMoOIzYqkyEPcXz0L0ABItnNDOM9eRI2mWlDhTp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510730; c=relaxed/simple;
	bh=dTalOcpYgbAFirvZnl/Pw0wzdV00vRrI4NrGqpYhk4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kATV68UF8nfBix8gQcLFjspzi6qKGahcahYqmwmXF6dH4Ydyh72DFDLt/InD3PQ2Msh5GDLGtN0cGddI7Mvb969Vy0alcDvTVigMg14y2sXhlJAsOFb7qRJZJWGmPyLzzfKV8TLyzUOL2yXehMG9PtsZDwgswGcVDCy+abGfV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=FYhVOYKs; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="FYhVOYKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=QJDS3rcjylLbmip4B2X5ndlG78REASmVhy
	tfhO1SRog=; b=FYhVOYKsSy6uJXVxgyghYSOE4qy1GHwYwC2imq8DYtW/uTKj+x
	cfzBfoK1ML9BQ5V9qcGbZwXBhydjCuzaS1V3MYTZQ1ibkW0EQ0QtFiuHjLEgHLkf
	mGpu22E9aYcPBMn5KozNxgn024mVtwp5Td22RJkgELDSwSQlettHyqQto=
Received: from localhost (unknown [222.195.81.76])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgB3bCNJBrlqLYlqAQ--.1502S2;
	Sun, 27 Sep 2026 20:04:25 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v6 1/2] bpf: Destroy callee-local dynptrs on subprog return
Date: Sun, 27 Sep 2026 20:04:21 +0800
Message-ID: <20260927120422.1042107-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
References: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgB3bCNJBrlqLYlqAQ--.1502S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XryrWFy5GF45Gry5KFy8Krg_yoW7KFWkpF
	sak3sFgr4vqF4xK3ZrZF4DZFy5Kan5XrW3GrWY9a4fAF1rJrykZF10gryFqrnIkFWFyw47
	AwsIvrs8Xw4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bwiiDUUUUU=
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

Add destroy_dynptrs_in_stack_slots() to apply the existing dynptr teardown
to an inclusive range of stack slots. Reuse it for dynptr initialization,
variable-offset stack writes, and the entire callee stack before freeing
the frame. The teardown rejects losing the last dynptr for a referenced
resource and invalidates the dynptr and all its descendants, including
slices held in the caller. Propagate errors through prepare_func_exit().

Reuse the existing teardown API and diagnostic. Update the affected
callback test expectation in this change so the commit remains test-clean.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel.org
Suggested-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A9u-HhxY3UDA@mail.gmail.com
Link: https://lore.kernel.org/r/CAMB2axMmrTb+UZ84UD48MwMtXbk1s9bWtreU3AOfjzU0fPT0BA@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c                         | 40 +++++++++++++------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03dbc0e003986..7dca855aecb1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -723,6 +723,21 @@ static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi);
 
+static int destroy_dynptrs_in_stack_slots(struct bpf_verifier_env *env,
+					  struct bpf_func_state *state,
+					  int first_spi, int last_spi)
+{
+	int spi, err;
+
+	for (spi = first_spi; spi <= last_spi; spi++) {
+		err = destroy_if_dynptr_stack_slot(env, state, spi);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx,
 				   struct ref_obj_desc *ref_obj, struct bpf_dynptr_desc *dynptr)
@@ -736,7 +751,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		return spi;
 
 	/* We cannot assume both spi and spi - 1 belong to the same dynptr,
-	 * hence we need to call destroy_if_dynptr_stack_slot twice for both,
+	 * hence we need to destroy dynptrs in both slots,
 	 * to ensure that for the following example:
 	 *	[d1][d1][d2][d2]
 	 * spi    3   2   1   0
@@ -744,10 +759,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	 * case they do belong to same dynptr, second call won't see slot_type
 	 * as STACK_DYNPTR and will simply skip destruction.
 	 */
-	err = destroy_if_dynptr_stack_slot(env, state, spi);
-	if (err)
-		return err;
-	err = destroy_if_dynptr_stack_slot(env, state, spi - 1);
+	err = destroy_dynptrs_in_stack_slots(env, state, spi - 1, spi);
 	if (err)
 		return err;
 
@@ -3823,14 +3835,10 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
 
-	for (i = min_off; i < max_off; i++) {
-		int spi;
-
-		spi = bpf_get_spi(i);
-		err = destroy_if_dynptr_stack_slot(env, state, spi);
-		if (err)
-			return err;
-	}
+	err = destroy_dynptrs_in_stack_slots(env, state, bpf_get_spi(max_off - 1),
+					     bpf_get_spi(min_off));
+	if (err)
+		return err;
 
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
@@ -11675,6 +11683,12 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		}
 	}
 
+	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
+	err = destroy_dynptrs_in_stack_slots(env, callee, 0,
+					     callee->allocated_stack / BPF_REG_SIZE - 1);
+	if (err)
+		return err;
+
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit. If iteration
 	 * converges is_state_visited() would prune that visit eventually.
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 9418dfe4d7b7f..0d13f828710e7 100644
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

