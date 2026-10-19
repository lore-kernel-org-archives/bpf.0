Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35A474252
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792387145; cv=none; b=LvqHRjzHlvLtpqdmNdqpubrH+mMX5KZW914sYO9qKFtBaGzXTliDXOfg1Pj7vpx0NcF81Nt0IzFrOcM22wTVyuMwp1b4bL7/6u5ZWfFBuMC6NjZdzVAm/2cvIaYuYnhdir50/7+MQriLgOYT3VvLzhlfxx1CJfzCWLmeWq8uo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792387145; c=relaxed/simple;
	bh=j8rtDZMH6EGTP0pr1wOWydhPs5CWWpgpd6OXpRWWukA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlLIMMGILwVjPKP6ox4LL1dirsqRHKCIipggND9Zfbu+lx1hI5nYvlPPNdNfLiMKvqrSnWszyhPZRwch4dMa6dAIM9RB2HQhd9nwscMiza2ObSKJB5v2HdgUNuYe2wDMNHlYeH3vAVxiCJTo4OlAjqvMRhTZ4dewUDmE5fNs7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWI4Qpl1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWI4Qpl1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9d7791b00so2839815ad.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 22:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792387143; x=1792991943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tczsazrTMkB9R/d4AhDBwG5zs2e2U2Tzs9r17SE4/+0=;
        b=HWI4Qpl1egCk6HWN0pP+swAF/OJnSTiUC2DeOYP1y4Gw7BLXYkKPMhP3+x3LXA8VrZ
         w3Ko/3Pe1/GUlay7wICPMq0ICd8pzVmYb9rhyOTeTGOddsIEvWrTgvcv73hGXKD8WzjL
         URnjSJNf1GhTb6sbNcqdZwAuq8k7sBPyvDzfWdjlav6eAQ98mPb6bLG5NYS1DIb6ASk0
         w0+0wRsu2esHBKGw6LzFhhG1QmvKILEVyCAozHHILvrJh76KzRWlBVttvEhdd2KfeSqR
         z7U41XxH3onk8cc7awMLz4int7eqZSiHTGcML/8C9qWd6LOiNLxlwlc9MF4xU7baV2Xa
         S6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792387143; x=1792991943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tczsazrTMkB9R/d4AhDBwG5zs2e2U2Tzs9r17SE4/+0=;
        b=a4/0KiJycUMmfcD/+n7fRMv9iIJwQZ57qlYx8bdMe1hUg+9sqt+Tk3TPCoASMTWDo3
         Zm8jAjMyHFT+rC9ro74mZKNJDbaw790qMUNG+J8P2JZBBNaY0LeJyqRPWO2U4vS3ztce
         GniAIp1Ss/AsbArCL10OqAhIs8WGSMBLz+RAIOATS27K51lgzsT86EdMurod5asbPimR
         EWBXoEFuMnvZJUyZ3gvc2jncQSfGDENlU93k1PnenVXW+J+EQapQX/pJkCaYMo0nVY4n
         +/Fgjj/I5Z7yMri45Gr/O3bu9Kfj3qLmD5OsKGlBQtEhvf4t0L83OGMN98aw8xvK5f33
         qX7g==
X-Gm-Message-State: AFq9FYJTCeHUrfsWrb1gh/qhOJuefnY6vI4Ncg6Qd/EP3P1xlRLMOT5U
	06fnkQiFvnthO/uCYP6+Q5r9fLwUN0gAyuDHOdIVzs7UQZutjETFtbsfN9QcvA==
X-Gm-Gg: AYBFou34NalWSRCh91/Q2z21zWNxKQ4WgWWTVWqfZx2jRFdVdxiis+CYAuoMoBL2MDL
	7taoQxxf/B8pdR01tfFpHea8yM9xJR2NN1mcMD/vNaGuI0zxkYEaoJcHTVj2QWZmkKTjVUvCV2x
	Igvzfsawb/gkv3jibuHNG+kPANOetCvlEIkWpsOnR/8RAA/o/BqwNEJrkCHhFQ/5U14EicqJb6a
	Omd0ZXT6x616JZiEXMWfjlkmQ0uqKvTzW+n4VNU1t4uJIoUQcaZbRBQjl18wHC+hOt8Dr097iTV
	VrQCYj3gh/to0gldQoa3NiHQwg2iifXjQHer8Ad7DflPNEDzB0M08U30LO1rPYVGQna9ZOWlrAt
	t96LNyUwVxIrd0Z1ht7Wuyi7MGwioPdTd3mjff78TZZ4KTOYGQf+GKtKdCg0M+C4YSGJWo76aC1
	fwJQYHZSAAE8bwsDXGGyFAmG/iEeJk0K1GGgzy9dc5zEANv6utM3iR7p17o6vZRgs/pLIocXDkm
	JmI1f5udx+4nxw9FdMvSR+en5TAuzjYyiFKE4DxZ6gIzioFuECI0hp08jOA/B6y+XTaClLJ+UhW
	vrq2lSReocIsGKxru+1nQAb1T34RG3LoxPx9xzogwCKg
X-Received: by 2002:a17:903:acd:b0:2df:b250:ad9a with SMTP id d9443c01a7336-2e9a6e56429mr52812565ad.48.1792387142866;
        Sun, 18 Oct 2026 22:19:02 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e868f6bsm34382355ad.53.2026.10.18.22.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:19:02 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf-next 2/5] bpf, x86: Support unwind_goto and unwind_exit
Date: Mon, 19 Oct 2026 05:18:43 +0000
Message-ID: <20261019051846.3012089-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
References: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

  bpf                         x86
  call inner                  call inner
  unwind_goto pad
  w0 = w6                     mov eax, ebx

  r0 = 0                      xor eax, eax
  unwind_exit                 push rax
                              push rsi
                              mov rdi, [rbp + 8]
                              call bpf_unwind_target
                              mov [rbp + 8], rax
                              pop rsi
                              pop rax
                              leave
                              ret

unwind_goto is an extable entry and no code. unwind_exit looks its return
address up there and returns to the pad. r0 and r2 are what a subprog
returns, so rax and rsi are saved around the lookup.

The caller of the main prog doesn't tell exit from unwind_exit, so there
it's exit.

With private stack r9 is saved around a call, and 'pop r9' has to be done
on the way to the pad too. In such progs unwind_goto is:

  push r9
  call foo
  pop r9       <- exit returns here
  jmp 1f
  pop r9       <- unwind_exit returns here
  jmp pad
1:

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 83 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d3843045dc71..abb870c77c49 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2511,6 +2511,50 @@ static void adjust_cmp_imm(u32 *op, s32 *imm)
 	}
 }
 
+/* unwind_goto: an entry for bpf_unwind_target() */
+static int add_unwind_exentry(struct bpf_prog *prog, u8 *image, u8 *rw_image, int *excnt,
+			      int ret_addr, int target)
+{
+	struct exception_table_entry *ex;
+	s64 delta;
+
+	if (!prog->aux->extable)
+		return 0;
+	if (*excnt >= prog->aux->num_exentries) {
+		pr_err("unwind extable bug\n");
+		return -EFAULT;
+	}
+	ex = &prog->aux->extable[(*excnt)++];
+	delta = image + ret_addr - 1 - (u8 *)&ex->insn;
+	if (!is_simm32(delta)) {
+		pr_err("extable->insn doesn't fit into 32-bit\n");
+		return -EFAULT;
+	}
+	/* switch ex to rw buffer for writes */
+	ex = (void *)rw_image + ((void *)ex - (void *)image);
+	ex->insn = delta;
+	ex->fixup = target - ret_addr;
+	ex->data = EX_TYPE_BPF;
+	return 0;
+}
+
+/* unwind_exit: fix the return address of this frame. r0 and r2 are returned. */
+static int emit_unwind_ret_addr(u8 **pprog, u8 *ip)
+{
+	u8 *prog = *pprog, *start = prog;
+
+	EMIT2(0x50, 0x56);			/* push rax; push rsi */
+	EMIT4(0x48, 0x8B, 0x7D, 0x08);		/* mov rdi, [rbp + 8] */
+	ip += prog - start;
+	ip += x86_call_depth_emit_accounting(&prog, bpf_unwind_target, ip);
+	if (emit_call(&prog, bpf_unwind_target, ip))
+		return -EINVAL;
+	EMIT4(0x48, 0x89, 0x45, 0x08);		/* mov [rbp + 8], rax */
+	EMIT2(0x5E, 0x58);			/* pop rsi; pop rax */
+	*pprog = prog;
+	return 0;
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -3491,6 +3535,34 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				pop_r9(&prog);
 			break;
 
+			/* unwind_goto. The verifier expanded may_goto. */
+		case BPF_JMP | BPF_JCOND:
+			if (!priv_frame_ptr) {
+				err = add_unwind_exentry(bpf_prog, image, rw_image, &excnt,
+							 addrs[i - 1], addrs[i + insn->off]);
+				if (err)
+					return err;
+				break;
+			}
+			/*
+			 * 'pop r9' after the call has to be done on the way to
+			 * the pad too:
+			 *   call foo
+			 *   pop r9      <- exit returns here
+			 *   jmp 1f
+			 *   pop r9      <- unwind_exit returns here
+			 *   jmp pad
+			 * 1:
+			 */
+			err = add_unwind_exentry(bpf_prog, image, rw_image, &excnt,
+						 addrs[i - 1] - 2, addrs[i - 1] + 2);
+			if (err)
+				return err;
+			EMIT2(0xEB, 7);
+			pop_r9(&prog);
+			EMIT1_off32(0xE9, addrs[i + insn->off] - (addrs[i - 1] + 9));
+			break;
+
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
 				emit_bpf_tail_call_direct(bpf_prog,
@@ -3772,13 +3844,17 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			break;
 
 		case BPF_JMP | BPF_EXIT:
+			/* The caller of the main prog doesn't tell them apart */
+			if (src_reg == BPF_UNWIND_EXIT && bpf_is_subprog(bpf_prog) &&
+			    emit_unwind_ret_addr(&prog, ip))
+				return -EINVAL;
 			if (seen_exit) {
 				jmp_offset = ctx->cleanup_addr - addrs[i];
 				goto emit_jmp;
 			}
 			seen_exit = true;
 			/* Update cleanup_addr */
-			ctx->cleanup_addr = proglen;
+			ctx->cleanup_addr = proglen + (prog - temp);
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
@@ -5025,6 +5101,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
 
+bool bpf_jit_supports_unwind(void)
+{
+	return true;
+}
+
 const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void)
 {
 	return &x86_arg_abi;
-- 
2.55.0

