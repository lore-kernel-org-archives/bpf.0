Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B8468C17
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116173; cv=none; b=ZK4A1YLZEcflcJS+Obo7kWlut53ohDIEFCYvyczQPev4K64ky9i8mTZ9IUcdRAdhLMe9f/8PTwJxClrRZzHlH+FxPg+bvibI1v7J4aiWqOMXbAazEFagg+zUF7qNCORJY54FqNNmFh2kMKTntoYMMsbjNqgK8ms0cuOFTVuTNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116173; c=relaxed/simple;
	bh=4bRje7jSJXUkCC9Y2cSYdykmhK5nlCj4zFCGIW45EG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdm7u3+RbczXMqSjfjFfWfG15CKJ5iTeiidBsnu2N2ABap67V1ucgukq9Ue5pW4Xi5HUACHdbJlKjKMXoEWJgJl/i83rGhy4GNe/bfPL0yQC97TtYzPHNWHrJYUpG03ChvAZ475j9Ti790gReJrvcUzuTJtTGhJPoZXQLdUOkp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=Yuru1cC/; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Yuru1cC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=cd3yzMUdejFhMBpp8mRl9z7i6/YFi+Wx0N
	w6XNPyQEY=; b=Yuru1cC/0cScDdYX3EIaRVOSg+hIVxrXJ9UdDrdDqaX+bw4Ir7
	lXnoL8C3bal0wgLaXk4gyTX/mI+6l+sBBfWPGaCKoxCkCTjT8d/BTK7pik0dTuNA
	LuNHdPYy/UHxPuruhTCMe8BdQz2YZW+9Cy+KRsuHDcq0a9Z+JAGv/buZA=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCXiyL_vqNqXe8GAQ--.482S2;
	Fri, 11 Sep 2026 16:42:40 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf v3 1/2] bpf: Destroy callee-local dynptrs on subprog return
Date: Fri, 11 Sep 2026 16:42:08 +0800
Message-ID: <20260911084209.3481285-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911084209.3481285-1-xyx2021@mail.ustc.edu.cn>
References: <20260911084209.3481285-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCXiyL_vqNqXe8GAQ--.482S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWDGF4UGr1fZFWxAFy8Grg_yoW5Kr15pF
	4fCFZFgF48J3WIkwsxAr4UZFyYkan5X3y3Gryav3yfAF4Fyry5ZF40gry5XFn0yrW0yw4j
	vF4SvFs8G3yUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bF6pQUUUUU=
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

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel.org
Suggested-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A9u-HhxY3UDA@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd27..c9c1df27b2699 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -800,6 +800,31 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
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
@@ -10399,6 +10424,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		print_verifier_state(env, state, caller->frameno, true);
 	}
 	account_processed_insns(env, callee, caller);
+	err = destroy_dynptrs_on_func_exit(env, callee);
+	if (err)
+		return err;
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
 	free_func_state(callee);

base-commit: e4a62833adff6ef0fe7c0b90393204fe3c26b5c5
-- 
2.43.0

