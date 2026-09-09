Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755130569F
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928157; cv=none; b=rY5szcPQoLinfijd3EKPTeztERM9gcRo9IxUljo7VsaNQBCyhGezraZU+DyQwc9Iqw9MzSDgIYO/NTmwcJpZozghpgrL/LaaPnMVK/8jKCOVkVuwptDiSmfVhYOJ7KFXAlkgltYXaD56kVKv7sqaEEq403izTL08fTxMcSig+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928157; c=relaxed/simple;
	bh=dLMGcw2hl3NA29IBBzh/QRWT6FPBt11jwKtJUuWL0Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZJKm8lExjm73gOsCLYJX9TQHMzy3KIvFtozRtPb5+HsngXnCqXeQJhx3yNcpLghFjD0fL9No+o/viIMf6gctjyQzyUeH8MkHguwMPdVaM3PeyrYH28iP11kGWlekJF5Y165923fJPxlx8s8zI0CFUW8w8kUm61E2BxSGGp0Idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=Gb5lQA0a; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Gb5lQA0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=eiqgsNkyUFFgFCMKz/uR+zU7Pm+J92igUi
	CAjfr1pdw=; b=Gb5lQA0apdSP2Yb0HFNGQYXUytZp4g/i01ZhL0MyzkLTvV4ZPi
	ixRLsLc6h+F2Rfzrjli4uV8sz0SlaVuGO0vmx+k4cG70whOt+avlq32DAFJMsR64
	IXrJ8yEZm6NL1H9TIt4G5kpGeh0ePdAv9CFBBLkrv1/V7inJ1Ii+1g5Ng=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHCC+Q4KBqDz_5AA--.312S2;
	Wed, 09 Sep 2026 12:29:04 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf 1/2] bpf: Preserve escaped dynptr slice ancestry on subprog return
Date: Wed,  9 Sep 2026 12:28:57 +0800
Message-ID: <20260909042858.1734125-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn>
References: <20260829040712.B1B511F000E9@smtp.kernel.org>
 <20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAHCC+Q4KBqDz_5AA--.312S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF13WrW7KrykJrWDGFW5GFg_yoW5uF1fpF
	4F9F9FgF4kJw42krsxXF4DAr90kan5X343Gry2y34SyFW5Jry5XF4jg34UXrs0yrWkCw4U
	ZrnYvwn8Gw4UtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Before freeing a callee, reparent surviving PTR_TO_MEM slices of its
referenced dynptrs to the dynptr parent. This preserves the lifetime link
after the local clone disappears without changing non-referenced dynptr
handling.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel.org
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd27..d1e0b1a7d0a3e 100644
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
+		    !dynptr_type_referenced(dynptr->dynptr.type))
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

