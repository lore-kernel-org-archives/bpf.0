Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051759;
	b=ZeYcyy7qHPo8SgJS693YEEPnjMP736wSubkFCJrqvh1Ao39sTZXJKl9sY1ReAnmOM0NH
	 tVkIiH3kzPcRdb7aOUdimQ83VKDf1gjfNmCe1JM2bNHefA0895XCPhJ7ue2BVnEC3FwXa
	 gI843HCrWDHfPIuo4q61ujziH6u7C9UO5WiwFLP0nyvL0T26kkxZshgGWNCyqffkl2bM3
	 GBFyRt+01RLbM5ufk+OYxRMWt6WuKSU85Q7joiQ+jVhdYtLBtDMDqrNthd7rtvxnVluz9
	 6LCvkzh1XlXNtU4Y8+8Bglkh4/Rz1EzC+mRpOw0S4U30POeDNOrj08NmqB1SfFXEQ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rqXAu+epHHwkgFRUdSFYjAHn0UvU3aBZNQLcuY0v5lI=;
	b=fxEYXDJYyzD091a6wtA9MKb3Q7DmdXFQnzj3DUHCBIkYYBruWqApLnb2wKMlY6eYZ228
	 YEmyUYCudyhjPaPfXfYcwset6dFhI27JwS4JpR1rx6yrgBMBLmdefCBfVcno/XD3Gm8HV
	 619Ji+J9RufaAD7mjZCicQ8Get0I4x2NEisAUl9YOBhLukOu2K7hapIUHh+trubnpvM60
	 OPF+iicHfnid5OADaFV6f76jmhBqmZDd65K8QH8P8J6UYTxIzx/8MqBWDLkTFmSboJltv
	 n3sMVqSsTq0wEqSPBt0nBKGF6j5xAYCACG0beeUuXqaQ0S0YkpugBydrsMb5T5Oeiiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEcCQfwi;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7996D606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7996D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEcCQfwi
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso962335a12.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051759; x=1795656559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rqXAu+epHHwkgFRUdSFYjAHn0UvU3aBZNQLcuY0v5lI=;
        b=cEcCQfwi/d1PS8VsVTdZktOMXgnaiaqYrvOAxWzFXbeWo/vppOwjbs2OwJnoqUsGUH
         oxo0A2YrU/cfzLJTNILuaQMeNvrJ/vFCqcQoENzd/6N4Qw+hk6CxhaiSH2su5j3SV/96
         LIw2nWAmba+9old7UodN7aE8u2Fgp9a1Wayq0anMxqkS2e6XetzHURQeECIPVzMxstb+
         Uv+k15gSJcWExPopyRBLVsAXtdBAe5DvEc36atoxsMR3zAVOku/bTX55OTT80QY1iroV
         YKVbeYLCtAUE4jBUyOF3NpVE8rfiy1hTpRzYYILvAORxGMqEESuRvWT76yzy3PX4QtaB
         Zqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051759; x=1795656559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rqXAu+epHHwkgFRUdSFYjAHn0UvU3aBZNQLcuY0v5lI=;
        b=ULfeLnXQ1WI8TRH7u3R36siXoWDXnHZrwvMjdWgNpoJ0Rep2UHJN5Az3aW7mHCozAE
         VNpmhieK7DUuWjHzwguJgIocb1be/Qnr4dWIBnb8SVcEqF92r00dHBnOGmVHyBIwqEEY
         sW7cP4MWCoQ2pXrTWUyW7qSz01X6qPhpOS5d4ENnfWvp7uph8rNtNn9f5eKxs483YgTz
         SWf93atstEns9QZX2CKlN19qYbDilCeUP0dL7upEHvh33VQ+oJVb5UNiGN8lCWjpfNwe
         shfqIntwS3fPxwFXdyC2KxJQAYMgxcXqvjCu4BCihOkznzPPFpIAH8UmxutjDXFHKzxl
         T4hA==
X-Gm-Message-State: APuU4Z/2v3xD0Eat/aF0/zPDfp/cLtGOkW/noi6GfHPXP6WKbQv/3b1S
	8h2w5e1cEHBf5GPBLwhLb/eGZAozUzPcJ/VIZp0UoRyTC5AlnQVaoDiTQj/q1g==
X-Gm-Gg: AZFdTZe97B0kACOHeG056cE0I0LxeJbkrKTSLNXOpaeXj18dbbOUTXB/JlVsl2+SQAA
	Qr+zX5eQfpEejsFSfb4Ez03xUlVM1hKxkAyz1FOTms68f7y7u88Uy3TTuxvOxcq9aG80dOlcq72
	ikJ+mCsCB9pTXQeqJKQwjj3u86WFPU2x7as/M07IwUC11NmAZmH/V9opIBZstl78P05BXLPrvhz
	MQtsaukplEDarXtZZNUSNM1USclHQZjnPe7HCgvp/qjJtHS1ZA6GdyXPfEjPIhYTimFkrHK9YGx
	gfyGtwYY/+jVWjZyBluHQV/R0Sk6arRffRRW6PpyT6BMNAhpy30RDH9lmxxAm7Hnf/pIDNt/QAR
	/k4igzVGjRsAFwcOWFZJQ8/buo39MVzeQ6WGdr+NAmlCmVR2G4ys+58uNUA5iqUYDdOy8T3lRu8
	5W36NwlZDJxzj5Bg5P3bBGeYClpZ31S/PAZr0sTNQpWod4SuJHCAjWhT5YnTZTHqa7hoQ7xKdrj
	6HE+hCfs6NHo1GTeh7s9YzWcTJ5uEGUQ7hUr88JW1zQ4goiw3eXMOop3Qk1BS/De6xSvI7yp57k
	hYrn6DKcfSq2qao2Mp62Q4Aa2UV4xiij1HnElQrZe82CbhEvP5w02clHGl1l8PbL8cM5RlLFFUD
	QMj2Kab3DeQhdiBrLLinlcu+GtWT85vCZOZKhiaKKqrUxXkdlNmiv5yNzvkcxRJkMYBet2gh+kw
	==
X-Received: by 2002:a17:90b:39cc:b0:3b0:a7e7:68f5 with SMTP id 98e67ed59e1d1-3b3d0689954mr4020516a91.7.1795051758689;
        Wed, 18 Nov 2026 17:29:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b401f75ee4sm148710a91.0.2026.11.18.17.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:29:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/5] bpf, x86: Count the size of a trampoline, do not emit it
Date: Thu, 19 Nov 2026 01:29:05 +0000
Message-ID: <20261119012909.3657417-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
References: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
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

arch_bpf_trampoline_size() emits the trampoline into a scratch page to
learn its size. The emitter does not look at the end of the image while
it writes. Only the WARN_ON_ONCE() behind the last instruction does.

BPF_MAX_TRAMP_LINKS programs fit in a page in the common case. With call
depth tracking each call takes 9 more bytes, and they may not fit. Then
the attach fails with the warning and -EFAULT, or the size pass writes
past its page.

The JITs of the other architectures have a pass that counts and stores
nothing. Do the same. Without an image the cursor starts at NULL, and
emit_code() only moves it. Two places of the trampoline code stored on
their own: the template of the call depth accounting and the jump over
a program. They go through emit_code() now.

There is nothing to overflow. bpf_trampoline_update() sees a size above
PAGE_SIZE and returns -E2BIG, as on arm64. The scratch page is gone.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 54 +++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8b5772262e13..d10a36daeeec 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -9,12 +9,10 @@
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
 #include <linux/bitfield.h>
-#include <linux/init.h>
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
-#include <linux/execmem.h>
 #include <linux/extable.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
@@ -37,23 +35,15 @@ void __asan_store8(void *p);
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
-static void *trampoline_size_image;
-
-static int __init init_trampoline_size_image(void)
+static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
 	/*
-	 * The generated trampoline contains calls and jumps with 32bit relative
-	 * offsets, so the scratch image must be in the execmem range.
-	 * On x86, module data and executable memory share the same address range,
-	 * so using EXECMEM_MODULE_DATA to get writable memory.
+	 * arch_bpf_trampoline_size() has no image. Its cursor starts at NULL,
+	 * so it is not a kernel address: count, do not store.
 	 */
-	trampoline_size_image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
-	return trampoline_size_image ? 0 : -ENOMEM;
-}
-late_initcall(init_trampoline_size_image);
+	if ((long)ptr >= 0)
+		return ptr + len;
 
-static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
-{
 	if (len == 1)
 		*ptr = bytes;
 	else if (len == 2)
@@ -598,10 +588,24 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
+/* x86_call_depth_emit_accounting() stores. Let emit_code() decide about that. */
+static int emit_call_depth_accounting(u8 **pprog, void *func, void *ip)
+{
+	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
+	u8 *prog = *pprog, *end = temp;
+	int i, len;
+
+	len = x86_call_depth_emit_accounting(&end, func, ip);
+	for (i = 0; i < len; i++)
+		EMIT1(temp[i]);
+	*pprog = prog;
+	return len;
+}
+
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
 	OPTIMIZER_HIDE_VAR(func);
-	ip += x86_call_depth_emit_accounting(pprog, func, ip);
+	ip += emit_call_depth_accounting(pprog, func, ip);
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
@@ -4075,8 +4079,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 
 	/* replace 2 nops with JE insn, since jmp target is known */
-	jmp_insn[0] = X86_JE;
-	jmp_insn[1] = prog - jmp_insn - 2;
+	emit_code(jmp_insn, X86_JE + ((prog - jmp_insn - 2) << 8), 2);
 
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
@@ -4392,7 +4395,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * Direct-call fentry stub, as such it needs accounting for the
 		 * __fentry__ call.
 		 */
-		x86_call_depth_emit_accounting(&prog, NULL, image);
+		emit_call_depth_accounting(&prog, NULL, image);
 	}
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
@@ -4547,7 +4550,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
-	if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
+	if (rw_image && WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
 		ret = -EFAULT;
 		goto cleanup;
 	}
@@ -4607,12 +4610,11 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 {
 	struct bpf_tramp_image im = {};
 
-	if (!trampoline_size_image)
-		return -ENOMEM;
-
-	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
-					     trampoline_size_image + PAGE_SIZE,
-					     trampoline_size_image, m, flags,
+	/*
+	 * No image: emit_code() counts. The calls and jumps have 32-bit offsets
+	 * from where the image is going to be. func_addr is in their range.
+	 */
+	return __arch_prepare_bpf_trampoline(&im, NULL, NULL, func_addr, m, flags,
 					     tnodes, func_addr);
 }
 
-- 
2.55.0

