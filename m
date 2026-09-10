Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EAD3B14B0
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015232; cv=none; b=oUXUlZeA15ycClyLQgoOGmAfjj0vhrSeQmBbtj9bR1awBda2P5difpzZ4wzvgUIn86IopJCNUtSGg2aSTcss8XF0p78VxEjmwZ5uC9y7PfFRdbmMT/M0rhnPJQ27AX3XMxXPVhalRrKlmFNepKLWgWffRwuWQbspbs1Vhfpa1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015232; c=relaxed/simple;
	bh=7VPXsn43t/XzmLXTsi85Nic4QexLxpeyzqmt+z5zzA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTlXKdCqKSEDYqibPFJbe893NMWNsIg2ZrkeAWL+OOb1SRagiF9VG+fViIKEufItW7M1sSapcHiua9MOmbho0v19xrJ9YXQBpyFpOHmV6RJi+kJsWRdpojUY2193cYsGHzD6B5dj7ACbP03U3W30cwRNNTqRUK8Ff91TKJF8OAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=GGFJNpjm; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="GGFJNpjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=F8jouxfMUaVJ/PZzUrfHxqSt0HdHjMLV7P
	CR/6zQu7Q=; b=GGFJNpjm72Z2WH5kzCFOBZSaRkBV1YjFFiUEwOeRrS92Gv/nfW
	7nFvanNq5ZcTuhEizwxhjxKAuye1XHYYOL9iE/pZ9O3n2uyOYn1n7GCdXrvOMukp
	f9Hc1akPDGbsNA45h+85nSszZunnXZAkYLuaYZXZLVIHCym8gRcCje4bE=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHBCuwNKJqnTL_AA--.333S2;
	Thu, 10 Sep 2026 12:40:16 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf v2 1/2] bpf: Preserve escaped dynptr slice ancestry on subprog return
Date: Thu, 10 Sep 2026 12:40:05 +0800
Message-ID: <20260910044006.2279547-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn>
References: <20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAHBCuwNKJqnTL_AA--.333S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF13WrW7KrykJrWDGFW5GFg_yoW5Kry8pF
	4F9r9FgF4kJr42krsxXa1DAr90kan5X343GrySy34fAFWrJry5ZF4jg34UXFn0yrWkCw4U
	Zr1vvwn8Ww4UtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5l0PPUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Dynptr slices use parent_id to link their lifetime to the dynptr that
produced them. bpf_dynptr_clone() gives each clone a unique id while
retaining the shared reference parent_id.

Before the object relationship refactor, a slice also carried the shared
reference id directly. The refactor instead made the slice a child of its
source dynptr's unique id. If a callee derives a slice from a local clone
and returns the slice to its caller, freeing the callee removes that clone
id from the verifier state. A later release of the original dynptr can no
longer reach the escaped slice, so the verifier keeps accepting accesses
after the ring buffer reservation has been released.

A similar disconnect affects dynptrs constructed from referenced objects.
For example, a qdisc skb dynptr records the skb reference as its parent,
but the skb dynptr type itself does not own a reference.

Before freeing a callee, reparent surviving PTR_TO_MEM slices of every
dynptr with a parent to that parent. This preserves the lifetime link after
the local dynptr disappears for both reference-owning dynptrs and dynptrs
constructed from referenced objects.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel.org
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd27..ee41b7386f752 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -800,6 +800,39 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
 	return ref_cnt;
 }
 
+static void reparent_dynptr_slices_on_func_exit(struct bpf_verifier_env *env,
+						struct bpf_func_state *callee)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	int i;
+
+	for (i = 0; i < callee->allocated_stack / BPF_REG_SIZE; i++) {
+		struct bpf_stack_state *slot = &callee->stack[i];
+		struct bpf_reg_state *dynptr = &slot->spilled_ptr;
+
+		if (slot->slot_type[0] != STACK_DYNPTR ||
+		    !dynptr->dynptr.first_slot ||
+		    !dynptr->parent_id)
+			continue;
+
+		/*
+		 * A callee can spill a slice derived from its local dynptr into
+		 * the caller's stack. The slice then outlives the dynptr id that
+		 * links it to the rest of the object tree. Preserve that link by
+		 * making escaped slices children of the dynptr's parent before
+		 * the callee frame is freed.
+		 */
+		bpf_for_each_reg_in_vstate(vstate, state, reg, ({
+			if (state == callee || reg->parent_id != dynptr->id ||
+			    base_type(reg->type) != PTR_TO_MEM)
+				continue;
+			reg->parent_id = dynptr->parent_id;
+		}));
+	}
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
@@ -10399,6 +10432,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		print_verifier_state(env, state, caller->frameno, true);
 	}
 	account_processed_insns(env, callee, caller);
+	reparent_dynptr_slices_on_func_exit(env, callee);
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
 	free_func_state(callee);
-- 
2.43.0

