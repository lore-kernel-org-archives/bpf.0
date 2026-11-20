Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160896;
	b=quUx6pT4cGZeXa9YJfoOMavL5l1IeMKT3IKg2ZhwV0oAmhumsrVUhfjHZ/i826B0nuZN
	 Oz0BqzTDj6HZy+njDzdyWrbmRiK1w1fKZIgHHHoVePaLIdbnsu3rXRhtTPMDgbedC8PUF
	 Re2I06bPo5ftDBfU7d/vgp60R90EpaY4vVBliaBMGaT8AP9LQW9ott5P6O1QzyVV9HGMy
	 8oYTCllWPnkfwDX/nRcfAINn+7ch8wWTSmoKAzt1im17nlMTcXFuC2bluRgeYL2yvNINo
	 v79EQ5YxHBbn3nkWjJIqKlcQ6hQoR3sfpBwa2a31a+fT/TAg0803IIwki/dHiksPQJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kDpBq3LuCvRExraAe4mDoncktCg1vfbq4TvXp+c4pfI=;
	b=1tY+bV2ut9G9Skpn/+ucjsDW3dyEvYb9k+AmvXND3T2nCiit5AwUMF65iRCIFIEqtJsh
	 UQIQFF/uz3RbkDRDOdi/bqiKd2JziCz2IDBN/6fjLOXvfloDOm7cIyh0yY0x2EopJ+qBK
	 lnljCfEeedVNibK4I4phQi4HsAylA7ygA+K/RpNogVw8u638G/j/CLuBMcFQPYbQhQ+er
	 kqWwXBMYGZeN3d8eLRgmm/bIl+OjULbwpf0PkKJ1leuv8g/5PylwtDET0DjZc6oLGFBoT
	 KPuh1sPNhSq0S/fbFFhJo8EeT/mP/6msbq+S8NIUwinQD+lGykysuNYKhq+OAA35B0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wbZ2LZoU;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786CC606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 786CC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wbZ2LZoU
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso344438a12.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160896; x=1795765696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDpBq3LuCvRExraAe4mDoncktCg1vfbq4TvXp+c4pfI=;
        b=wbZ2LZoUWDgMx8gnOzGr4i+00Hkq/v2L13QLeRfyDQL/YYp54NjQ4b1Ol3Md6Z07Af
         PZa30gXJFkGTMstPENWszDHR4Bfn2ql2wfiJL0aH1YNanS01I8YXQ8Sn2eYG3x2/FBIb
         IQTHH2z0ohZPJc8IBLBEWPYXWJHsXPWctLx6YZybBdYdTh2ZXK7GtoIQ555rT554SiAU
         60ZFVzR5Ik0Ukr6arVRMoz/yu8a5FuNzgeVNXZ1wu2BwyQWifL1becDi6XdelHgGE93a
         2+akpQC3VWKptA/mMRj4LbXlroWNT2GFk3ZTAW2HR05nzhi1dNGbKfC5cS9ntl94sNRX
         mMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160896; x=1795765696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDpBq3LuCvRExraAe4mDoncktCg1vfbq4TvXp+c4pfI=;
        b=uXeqV1OKv+Ssv2g4t4L1J8ot6vJeaKUs9wEqT/Ogc2JI/sgDNCICzXHLuBOJPnFl76
         TNBKbH07K1HCyLuEmRvjFI8QfYVHPphY2Sv5zOTffaCqLZ5dDVn1BR7euBDtDtI5zOM5
         0FsAcUp/6WV0QHLAaqkaz/cr9Z2I+kAUH6ShGAtDrieVWNPMHIvMNd47PuZP1FNmRqgf
         KX+lpU3n8D9skjeKApvQO41ub0COxZb6VeDppPT2kM3rxMQsgF9HE6Mt5NQ1UuDi4l72
         O3vP53B6xmhnKJ0aEnlegiWn9oAQ6lGXs0cgnySoIY3SqQtLJvET4X4MMfbm4y0pq2Rl
         JKRA==
X-Gm-Message-State: APuU4Z/GTyfVIitYiqFwQ+zKMiGl/VbryRzDEB+QQR4HF72a2mRzLts/
	wqlEsbPsAuKQMUK14NqiQ2OMEhFzrBoLPMiBjr9mIZf3fBUn6Upc1cVHAQRYBQ==
X-Gm-Gg: AZFdTZcOkU4NNE2Y9c9ZoQCruiZ9kgzAF2AEpmPwF9/qJ6zv/7foEv/Ip2EtMOuuZGS
	EBF56/8KuUr8cSMGHhyrFrsE41ER7+BauELhvG3E+xkWRRcaEA89cdKO3QQhmcvUUoA1b3LymeU
	9Jhuudi7xO+2vlLOty8A2qwP+EQt8fLpe+0wwaBgdoF2Rsm5TvrZ1jogMZQR4KjY5ESxm2aoraL
	PP0F7FPCYHndrSBXtqEKTcqwWeD+VcC9VL1/BwHsA+Tds6mbLxYnlRbccvLgb07BdcoNPt/Nfek
	NwifwQE8DuD4DHu1CfQLDtvKocArjH4fBW/2VE8pnI6CUdnp17fNEYPA6eYwHSfh8N9e/EcuN6M
	EN6zG5c/UEXe8T1o/7LCgsHumohiEDdgGy9ZOOAhlgyJcwhosCtDqH7dUTTf2/DEJAsrkeAi8Hq
	PoJcSTa/DpXg6XXhaFmILfdy13fctsK2Ztmxl8WUTfH+upcTryQGWMwXrHolZZN9y7KTnPcObDX
	CKcJ4mSF7IwNoRg0UCQ8F9UrO0+j9ibcwQwX0v8IBMV2UerqFfowWlWdeADTJ3RVpquqXcLYA9D
	9XgldIWE6uWzG+CfAAsXzY5b18+j6ddr+0TqlxOeEDZLXLuZFD5djBVqjBAi9Ma0LcpqyoSYiya
	/bMc3IvMMKrrLqutE+XHKNVj2mYvixYbKhSDdWXF8hWja/Ifv8ey48C9eA7Phk64fLvWMm6OiDv
	E=
X-Received: by 2002:a17:90b:1801:b0:3b3:ffa8:6bc5 with SMTP id 98e67ed59e1d1-3b41c9823cemr1910044a91.60.1795160895650;
        Thu, 19 Nov 2026 23:48:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm6387437a91.10.2026.11.19.23.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:48:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 38/49] bpf: Make a returned pointer to the stack unreadable
Date: Fri, 20 Nov 2026 07:42:10 +0000
Message-ID: <20261120074430.2704488-39-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

A void static function does not set r0. So r0 can hold a pointer to the
stack at the exit:

  static void f(void) { char buf[8]; r0 = buf; ...; }
  f();                  <- nothing reads r0

The exit failed with "cannot return stack pointer to the caller".
Let the read fail, not the exit: the register is unreadable in the
caller.

  old:  exit of f() -> fails
  new:  exit of f() -> r0 is unreadable -> a read fails

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/kfuncs.rst |  4 ++--
 kernel/bpf/diagnostics.c     |  3 +++
 kernel/bpf/diagnostics.h     |  1 +
 kernel/bpf/verifier.c        | 40 ++++++++++++++++++------------------
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c7da603cab7..335dbb833bf 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -704,8 +704,8 @@ from a pointer is a leak, so the verifier rejects it with::
 Initialize the whole return value, for example ``struct pair p = {};``, to
 avoid this. A static subprogram is exempt from the scalar-only rule: it is
 verified inline, so an unassigned R2 is simply passed back to the caller as
-uninitialized and only a caller that reads it fails. A stack pointer left in
-R2 is still rejected there, just as one in R0 is.
+uninitialized and only a caller that reads it fails. The same holds for a
+stack pointer left in R2 or in R0.
 
 .. _BPF_kfunc_lifecycle_expectations:
 
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 8972b429bbc..e17689d638b 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -2233,6 +2233,9 @@ static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_h
 			 "call invalidated this outgoing stack argument" :
 			 "call invalidated this caller-saved register";
 		break;
+	case BPF_DIAG_MOD_RET_STACK_PTR:
+		reason = "the caller cannot read a returned pointer to the stack";
+		break;
 	case BPF_DIAG_MOD_WRITE:
 		if (target->kind == BPF_DIAG_MOD_TARGET_STACK_SLOT)
 			reason = "a later stack write overwrote this spilled value";
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index cb255218c41..c0303c4aab4 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -26,6 +26,7 @@ enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_SLICE_BUF,
 	BPF_DIAG_MOD_NON_OWN_REF,
 	BPF_DIAG_MOD_CALLER_SAVED,
+	BPF_DIAG_MOD_RET_STACK_PTR,
 };
 
 enum bpf_diag_context_kind {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 33f7b17b2bf..e29a72eba02 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11629,21 +11629,32 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 	return err ?: PROCESS_BPF_EXIT;
 }
 
+/*
+ * A void function can leave a pointer to the stack in r0. The caller cannot read it. That holds
+ * for the stack of a caller too: for stack liveness a call returns no pointer to the stack.
+ */
+static void hide_returned_stack_ptrs(struct bpf_verifier_env *env, int subprog,
+				     struct bpf_reg_state *regs)
+{
+	u32 i, nregs = bpf_ret_reg_pair(env, subprog) ? 2 : 1;
+
+	for (i = 0; i < nregs; i++) {
+		if (regs[ret_regs[i]].type != PTR_TO_STACK)
+			continue;
+		verbose(env, "the caller cannot read the stack pointer in R%d\n", ret_regs[i]);
+		bpf_diag_record_scrub(env, &regs[ret_regs[i]], BPF_DIAG_MOD_RET_STACK_PTR);
+		bpf_mark_reg_not_init(env, &regs[ret_regs[i]]);
+	}
+}
+
 /* The current state is at exit of a function that is verified on its own. */
 static int exit_func_on_its_own(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_func_state *callee = state->frame[0];
-	u32 i, nregs;
 	int err;
 
-	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
-	for (i = 0; i < nregs; i++) {
-		if (callee->regs[ret_regs[i]].type != PTR_TO_STACK)
-			continue;
-		verbose(env, "cannot return stack pointer to the caller\n");
-		return -EINVAL;
-	}
+	hide_returned_stack_ptrs(env, callee->subprogno, callee->regs);
 	state->unwound |= bpf_is_unwind_exit(&env->prog->insnsi[env->insn_idx]);
 
 	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
@@ -12402,18 +12413,6 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	callee = state->frame[state->curframe];
 	r0 = &callee->regs[BPF_REG_0];
 	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
-	for (i = 0; i < nregs; i++) {
-		if (callee->regs[ret_regs[i]].type != PTR_TO_STACK)
-			continue;
-		/* technically it's ok to return caller's stack pointer
-		 * (or caller's caller's pointer) back to the caller,
-		 * since these pointers are valid. Only current stack
-		 * pointer will be invalid as soon as function exits,
-		 * but let's be conservative
-		 */
-		verbose(env, "cannot return stack pointer to the caller\n");
-		return -EINVAL;
-	}
 
 	caller = state->frame[state->curframe - 1];
 	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx]) || state->unwound) {
@@ -12472,6 +12471,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			caller->regs[regno] = callee->regs[regno];
 			bpf_diag_mod_end(env);
 		}
+		hide_returned_stack_ptrs(env, callee->subprogno, caller->regs);
 	}
 
 	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
-- 
2.55.0

