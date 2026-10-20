Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470816;
	b=KH7soFnvqsaD032CSDXFn+Xzs0rdnaMclqXjcSO08QCVGDJHPv/39IxDCKSwfxSnp1Zf
	 5CvBn+DQPqRVOfhqWaMKAcp+1oNFvwSLys6h5XpoqGf2d2JgD7reD+v0das4rI9DV+QRR
	 dTRdfJsx6nW9xvUHCQpXujJSGdLiM1IFdPjS3A5ldIbqjheM4qeWfW4FPDZIXf+FzDG/e
	 STksj6m0EVhAnC4HDwnc+87XvFFg/ogFbAVuifDbZY/YfH1YqLOTzS9quPo9ntooAG9HB
	 N31uplPLDfQwj399yJGYOl0OETeuJ3WM/RQBfvh1cRWIpCqS1w+Beta/1fLRIXGKrAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aRsibwdciduFXL+k0PdadZNRREzsRgWNXF79QbIYtFc=;
	b=Dmp6utK7Izoqy0XabsYTL1yl5Um5ed4jg+zutEHqvR9pEWsJSEK/KkIebSzkVfvzaUCE
	 sEe3PEo/n3Ef3HoBWerjJqvx7crOExRM3ksnVJiqZU0VrvaJQdoeJqJ8FQQYcUudU21lS
	 1ipX1U2RF9BZxaQaC7E8X3NnsHVuG18K8hRXY1aa1ui48RXjMQkNHagqKdMWVKbz4n2Nv
	 72FnzUX7ZpdowBrrxKxIfSF8iZ0/pikw2tnAKoMpw9EYgajaeEEXz9B2nBmMmp06IcxKB
	 8BGOUDVq0zPyZtNPYxrLJ5gy/pSwmzz/1kq1kek612BTJ8tXVp/yyIHHMMCC3CKdokA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GXPBLpdQ;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF3606A31D
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4BF3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GXPBLpdQ
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2dd76b1361dso2317525ad.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 21:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792470815; x=1793075615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRsibwdciduFXL+k0PdadZNRREzsRgWNXF79QbIYtFc=;
        b=GXPBLpdQT+bIw+WY5j+LSJziYyYi45hlgCH3NtDrJrlueN7wPf6fsS7KZ9yCkq0fjP
         wpB1zkFp7v7wf11VWaRPzq+kkdPvamdItQapEjzU2+g/HUN4MX+nvKwjPljd6gmrYACA
         IophaWeKWa2DS9L58CWfF7kDES9EsgJm7QMoM56nUsNRVseUzjYoe+jhmwWFOBS7HjX3
         h9ehDiXNBQer5EBHNeF5bZG/4zUnpBMD9OAMCrin52VJJeoAi8nU44HFxzEv9uzHW5eg
         a7jvn/LATiLSziAJ3unm14/dfNQvq6PW3RyiM85inthqDTUxNposXaOihr0kyDAHQSed
         Nauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792470815; x=1793075615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aRsibwdciduFXL+k0PdadZNRREzsRgWNXF79QbIYtFc=;
        b=v7jBSAPFemvYAjad/FmDf5pifeVKrNbpSJA84Vnfe7M+vLfIQP4CoZEsqGahmpU38u
         69QBxJBCRS5eZEL1acIZ9nXv5NKtVt90JkhAwnPrSP3vGxqVRnhX/tPUYZ84XSwG455Q
         ubts/GYPGOd9VWHlaRznu21IiNSjCLW5VZc4y/SQ9iRav5RCnlUTlhQvx9FeqV9wpwGu
         RMYWbTaYB+SEjXmbB0QFC7R5jdLLcmpF+hNyaVqFo2kxTiJyiYLigHGvZfX+HXFD0FyR
         /4TIzwifRD6mTVJwS4V1v7jqueaRUL8QIMURemAZLK1+K4WAGnSajwROwdR0I2OFjEZA
         wdpg==
X-Gm-Message-State: AFq9FYLK7dGmPUi3ylyp8vm59CXZHyZdsnKXsXB++yodRf1nJIvF0kCN
	TL1n8LW311pKl/wUWXO4I47BpMqohjNVS6JZbVVt8puH1xrM+yziT5lKt6AGYw==
X-Gm-Gg: AYBFou0v+hiZHihpGblcOtkWqgxcJ1JX87oHzt+0Oa973v25mVYEJ57Uw3AAzbDS78J
	afDxHwCe5Yhp+JdpY+NkFY07blmeqq5X1EDkz4i8EyLlTM4B6+jC6ibINVigeTHyC+SuS4ps38a
	ftOXKzc2JwJ80zMsARWRpWUzE28wVQLjqbAA7VCSL+7VLfK/8gf03Ompc6M/r614sCKezrmi7dI
	kB8nQFpdtP5Sm/ycw1h3G+ux3ApCi299E8ID4mHrT66vKiNOVPKL73CFB6xlon+FrN6Ee/j7BSN
	wOfgUtmetcUlkNbHKOP4EOui+0yXynmGjClWGtZXW1GSUSHoFp+K+okv0yPv2lzcXlxzFVhwB5R
	rgnoS2ht7ycbdNweZ26o8wNEkBXFVvBakiHRDbp4lwTHiFSJ/2v6sby3A7zk7txJWcr6RCpIujw
	Q9fkw21Aov6coRksdFNT+mNLKxt5MHcSuqReXIfcaCAyKMSm/V6gi6Q1qiOb1iwCuraUfEPynKB
	dV0vdUvIjdYtPQU5tfk/MxcLWsL96sEz3DAmU7J76JEGaw4E/c8H1QbCKx1HnESBS7KXRwDMBeU
	CA3pyJ3JTsouZISSV7Hxm7FwtIYTQz5rgK7YslBFI/ZvoUp+SM3izjZOb7Zxi0Vo7rkeN5xXPAV
	KupZpspNdIe+xpuTKbGJXcUNl
X-Received: by 2002:a17:902:db09:b0:2e6:943:39de with SMTP id d9443c01a7336-2e9a6d26461mr80878605ad.30.1792470814985;
        Mon, 19 Oct 2026 21:33:34 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1d5acf1esm3795665ad.10.2026.10.19.21.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 21:33:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v3 bpf-next 2/6] bpf, x86: Support unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 04:33:15 +0000
Message-ID: <20261020043319.3031996-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
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
it's exit. An extension is different. freplace is a jump, so its return
address is the one of the subprog that it replaced.

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
 arch/x86/net/bpf_jit_comp.c | 100 +++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 72a2a0a89e03..c583eed4e954 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,6 +15,7 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <linux/execmem.h>
+#include <linux/extable.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -2511,6 +2512,67 @@ static void adjust_cmp_imm(u32 *op, s32 *imm)
 	}
 }
 
+/*
+ * There is no branch for unwind_goto, only an extable entry
+ *   { .insn = ret_addr - 1, .fixup = target - ret_addr }
+ * where ret_addr is the return address of the call in front of it. unwind_exit
+ * replaces the return address of its frame with bpf_unwind_target() of it.
+ * ret_addr - 1, because what follows the call can have an entry of its own.
+ * No insn starts there, so a fault cannot hit the entry.
+ */
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
+static u64 bpf_unwind_target(u64 ret_addr)
+{
+	const struct exception_table_entry *e = search_bpf_extables(ret_addr - 1);
+
+	/* The verifier made sure that unwind_goto follows the call */
+	if (WARN_ON_ONCE(!e))
+		return ret_addr;
+	return ret_addr + e->fixup;
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
@@ -3493,6 +3555,34 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -3774,13 +3864,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			break;
 
 		case BPF_JMP | BPF_EXIT:
+			if (src_reg == BPF_UNWIND_EXIT && bpf_prog_can_unwind(bpf_prog) &&
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
@@ -5027,6 +5120,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
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

