Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208037;
	b=DhqTWnSAV9ex5bLYWZGAYbgT5zsQfVdLb/FmeT5xPvw6WMmH+Qoq/8y2393WU5nybRWz
	 M7Tw2/H9RpoXwj5f6qwcdwZeZuPjtYi1UlSFc1vl2yLsgfrE/z52qWORYDjvVnqKKL+NK
	 aP4cfU34nUhFZQrXGadpS/dFL/fR9h+AsqJZTTb24x3Kz0a9GrnjW99/pB59PIG3nXIua
	 jqsnnJy5xocKjQxZjKMhgxCHHakL2Wawzvco92YXkIoX2S/y62IknEAusOCLwKVZDkUsn
	 a8r7nSkbJMk71CLLhIcxTh2wdUSNCOQH1VC1GYx5i1zbDadhZiAhVo3tBqugderio9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VxtGXoi5o3hRksrty1A9nIzWwXSjO2JWnApL68lov0I=;
	b=i5wu1cYPz9WWwBUAwDedASjQmZ1HkaAkvjclEkTopmcY34CGrQsuFvsSkQYrjDAZRDO1
	 DF/gAGzIUsq9vNrkLlYJdhjqadzt6HAEXUyPWrcAaxD60+VnMae4Xhe2XEDbeNHMrMjhC
	 kGL+8Ydx5/68wIL6/ySOx+LPDIXfUsE/BwXd/Z5LW3xyLOzY4YWzKTihcX18r/XS8GUXm
	 rZQJR+PXm6mq5UJqpAyLChXqUBtZoxc6y3jJ55mcZTVBNvF8H6LyFg5N9HCg9M4UMlOod
	 /Zsst4kB4IHPcZiarLVOWUhvBczkR+5ea6jX5rWByA2dctVuCOSbSw0V7CEQ5w4UQBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nfe0Ovtw;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D2606A69F
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 366D2606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nfe0Ovtw
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso1310811a12.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208027; x=1795812827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxtGXoi5o3hRksrty1A9nIzWwXSjO2JWnApL68lov0I=;
        b=nfe0Ovtwde1qg5/G484YXnOUT6pxkpz62Co6ClgT80SVO3+77yd1BDvaWSGuWhufIt
         VL3TBJjm6JxkKSGPBbNoGFQT9Ilk5EUC6PhGZDLZ6nZb6HGrWg2PChuKGFyUuOT/NaSj
         Bk67NZcHaFPQDOpr1mlImxraL/MDm76W4+nlVxQhLpI7iUdxTx4qF70MI3YXxtzFqzj/
         mOmQ+Kt8pHk0uplsDlkhiA9acALhSZFlj/t+mMVLKrHLqByCKN2QTFQGlSNHKClXanUf
         Ba62RoOuIoS1AZS/qnJhgv/WMqUU36QC2zl4IFXpp5ZVxYlc7TrTYRkwg+O/awJFjQQ1
         J7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208027; x=1795812827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VxtGXoi5o3hRksrty1A9nIzWwXSjO2JWnApL68lov0I=;
        b=G2c9Q0j0ICC/HDqZOP/laCYBi6VPwp34UiKbOQ9Q1Vuo6bZHRvyzfUa2XxDeCfm4CB
         K7c+fngL3cb6shq49t+NZDTmOgRyYBhYMPT6eaO+cNwrdBhoKM3/VTuvfrJjUmjNHp9+
         VtUHhuWI7Q2kRopnRutjBSqZCebDWHzJiVZJpQXU+X4b+PqSIxX65hzl9JjWoIJTISu5
         jeBlnia4HrK2dy3HV9s3UeBD8qSyFWGngyUbDATxak/aKVdJXs/StDyrWjhd7jLZcTAZ
         5pTDL/pdDVC2ezBPAX2/GVNlCqoWrB14iQ7mdYMXz0A287qous3BUubqzLiVlo+S6cck
         pPGQ==
X-Gm-Message-State: APuU4Z/SuHAn6Be4upz3R0v/gz8ifnQdfnUuzF6l2KldqC7MYaEtHvap
	yRmmfobcbi2ybynX0bLs6iec/DDOKcD07Gg14sBgFZ9Z9LCKUYIwH9iwICK9SA==
X-Gm-Gg: AZFdTZd8CZFxLcJ9W8FAw51HcpKeD2CGrZj1LQnSMG6zr51JNlglYVuG48Ifbk5bs5R
	ewyVXGxwfRYJN4Jud3lFEfi5vYCDI1jv0QGIS1YObNyKyl1dgPh3HjPG1O/sraS2WW3ZpKHK6wo
	BI59oQnQFVxmY7+IPP0+Ti54xC0kDaoogvirc2vYfS4KIozeA2rjo+W0oL80zEjNSOAm97cJRUV
	T6wayemhJfT4cIVL14syrinWb5z1e5KSvc6laMGRN3wmJHi1oSrJKH7yFnK4ZRmS0CLhpPovuQ4
	xIoMApQxo1JZOAWOYP5XcoPRfPEXUvwTmWUjLC430qu5Z50Q6hHA5seY8/mC8hYExawlpJYCXWa
	CWvnZ4kdwU2UbwBBWlFJfPavZRKL9m92Rb2Tc82nIVlTHjOP96rFk2t8aPuw/nQQYOKP6FuW5bi
	jma96VBF+9GLgsCmQTGceIvQN+WXAamhMrNVxq9U5Cgam/CasjrO2WnS6XKzA4QbMTkv77FoaSi
	HeEhXtRTMyuIMZPTe7MPIWGgcUbBBGjAQT7NcLr4Owof3h4Gzys/jrzbWmRnpfPEsOhyI9rwoIf
	0Smg4znIgQ8BDZjkW2yBVR8nNOJ8PeaDRL7vE7iJap0Ey/AeEJI7f+0DZgye6CUhYZI20Vom5da
	JymXnVsFlJxG0GpXlBtnEXTOKZq1uOcwTTa9Fcepp9KJ9Zz5JL0W2BqIn5SVSRFIhJHdzzU5YPA
	==
X-Received: by 2002:a17:90a:d2cf:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3b41c8e0507mr2504017a91.8.1795208027305;
        Fri, 20 Nov 2026 12:53:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b704cfesm276837a91.1.2026.11.20.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 38/49] bpf: Make a returned pointer to the stack unreadable
Date: Fri, 20 Nov 2026 20:49:46 +0000
Message-ID: <20261120204959.614908-39-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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
index 92b0f4bbf89..94499fdaaf9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11641,21 +11641,32 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
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
@@ -12417,18 +12428,6 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
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
@@ -12487,6 +12486,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			caller->regs[regno] = callee->regs[regno];
 			bpf_diag_mod_end(env);
 		}
+		hide_returned_stack_ptrs(env, callee->subprogno, caller->regs);
 	}
 
 	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
-- 
2.55.0

