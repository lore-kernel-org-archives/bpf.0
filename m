Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520019;
	b=mT9ugjzTT3MSNFR2RYvLbvNOKPPd+rvolZHgB9KVUpJ0GSrpoVMm4AC2ziE6AGG60HKd
	 OB1XHmiqz9tOJ3DeoCbrWoHVg6/5fPPOIzPy9rEQbnp/MvmFWcQIwX/htyERAoa6May6Z
	 rq8WljLHxXngnh9cifDZMCupZIHcTvPUoDb5Cf4D7NYi+hk0mijKwJ4oVKdUcBidc0Vo2
	 6O8ypZu2Tq30+MtstKitUE1WzQHTcS9VFuRvzCrBhb/dO0o6x6mFijIxKigVmYZ9Hsh1r
	 CT18laTjY306PYBwcnDT2yQoyECr3BIue1l2glPlXiJJcjW41VHoooQU4V+Ixk4M21A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Db74klC66CBksTvcfwg3EV4RLSh9va8TK1+QVPxZijY=;
	b=JnXWU30/TDOIYsgytT5S9v7GUC+/9ltCc8As4v5a5SPAOGCG8uwM7LL+MIiiJYMQ7X5Y
	 k0VeNlvsPMT1TG8rGpw1t/7zAKzm4NTvYy9NZZyAYy3TcnGkHl/YAnrSNhbY7xJn7GXI1
	 kDUTgCyBsW4srfr9bU9o//HKcNLlfCckOPprJgAIWLU7LgFPm859zBbCovvbJvRKl5Hyp
	 55nNdKqKy88kJo5AK6pWixDX4mR8loc8MaS5sFMFhxRRUXJHhD4CpwzmusbtD6rJPG4aA
	 HyGz4Wr28BLMEEdxCrEdHGI9JZzAN35mSMeneEj37Z8gxR3wMQXrpmGrYej6Im4MBIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpFwGvht;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26BA606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A26BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpFwGvht
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso800382b3a.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520018; x=1793124818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Db74klC66CBksTvcfwg3EV4RLSh9va8TK1+QVPxZijY=;
        b=LpFwGvhtq0JG1OYJpcjp5BlA2NWhf5GI266CnN+h/avN+6wBXjev441HJkQpCLZ3/z
         406K9DpQTtlTg/jIMSMnMf8kuwABWN1ykYOl2Gfoi0YEtj6nTHUG9LdKa7/TRZ31Twxv
         74Ci1As6sW16cspZ7mMdIzqHVjEgKv/UeGKdWQDp4IX8rWY5kNiiOKagt2Z2oMEz/pWC
         slLMqifqdn/wxNi6lx3Z1aVAbeOZ8tT7ZgyoarNLPRarEZHx1QuOrT7iXeELU4CHORrB
         57vadSP052/Rdng10yoCojUYdwXeEr8KbeD48kTufzMld+XqnVAY3UBdR/R4gDy+4T3T
         b3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520018; x=1793124818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Db74klC66CBksTvcfwg3EV4RLSh9va8TK1+QVPxZijY=;
        b=kxzlSgW4zylH7qgMESHun8ycmuPqfDtaL9MtHNNp7y+C9Iq1bDymHn4ySC2hA2abYc
         T6WoQT2RUqX+1SCPQ1I9NQMqE9/vH6cLHtrfXFfkPbn2a3IA0CvxdFm2bUB/gQYaVkqE
         sLdXG0Wt0O6qQw27pDInyB19syeATRs54Md2fkv4W+eYVvQrrsd2p4MFTVP49YXOVJfB
         Bg1011VyXCBTwkI0Kt53SPR9YE4Nvq6C3FyAHwXi/M5dYQ1JnTybfLWA/RhYkpo5cZUc
         yI17pRC3JVO4jTx/cXrPZjrerRzTMt2Ko9mJVRkKWh+jOhKHrsU/VwROdVI+boGgCqJz
         a69w==
X-Gm-Message-State: AFq9FYLP/1ITmbXJ+f/EF/jZFn3EMG/BxBPDd1KEHzQHX5XskEYodDpU
	JPFuEtXAVXZOlqO8bXRc7NMxMPTZswuuR68uPnTrnKo380MwybJvdF8XsSvWFQ==
X-Gm-Gg: AYBFou3YLn36LktE4ZQ5RE1Lu2qLFxuVCkt9FvLMiWkrnhCcAn7vVaY+bNBkJsdBrc5
	OQk1j67T3GZt0EkeQhDGptowct39xhrgXttIVmV7XTvvANbWYRHxPt0fsYT/8vWyVJhJQozUWIz
	4jh8XdI++IsPrnNzgof6mu1OyQ41Tu9CElIaIAgdsuPu/OaZSCSzJB2AywKOLX3iusoj5lG5NoK
	q8he+w2SxWF7ZfOVPUoaNW4kepkIqX8f/fivytuON8CSyK9hFXMNqLpoe48EViU423NPOICKjsJ
	QF3t5ta8ibcvbv9ujAeUn/kf94gqRT6orArhbE0+nab+o1TePLygRJmI5K25xFI6DP7obHEe66q
	2BP/vtMPwKdYY90Taq8P7pJwf3VbIXpnC7CJOVYBNoz+1BIjXRbhM3mUEMB+MnwVggETYb8f0Oo
	jCV4J3mOZDteAsGfMEXiKEaxfCCGDE/AhxzC8nisPxvzPYK1IFqw6IoRx/jju1UJfvHoDS/lMpu
	o+DZzUcSUgi8P9HWBPTthNpcLufkl9fYg1iNFU3kIxLGhJaq+gaDM8pY2yNEJh3pVEO7qpdBiBC
	jsz3nxE00TiQ7iHpkljqEiPyQWO84FlIg/+jWpUvdzonGWNmhaPQXA==
X-Received: by 2002:a05:6a21:482:b0:3e1:bce3:c3cb with SMTP id adf61e73a8af0-3e225fd83dcmr10049752637.44.1792520017747;
        Tue, 20 Oct 2026 11:13:37 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6a8711d27sm47250a12.22.2026.10.20.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:13:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v4 bpf-next 2/6] bpf, x86: Support unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 18:13:16 +0000
Message-ID: <20261020181320.1284798-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
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

When there is no entry, the kernel called the subprog as an async or an
exception callback, and unwind_exit is exit.

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
 arch/x86/net/bpf_jit_comp.c | 101 +++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 72a2a0a89e03..d3ab36281144 100644
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
@@ -2511,6 +2512,68 @@ static void adjust_cmp_imm(u32 *op, s32 *imm)
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
+	/*
+	 * The verifier made sure that unwind_goto follows a call in a prog. When
+	 * the kernel called an async or an exception callback, it's exit.
+	 */
+	return e ? ret_addr + e->fixup : ret_addr;
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
@@ -3493,6 +3556,34 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -3774,13 +3865,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -5027,6 +5121,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
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

