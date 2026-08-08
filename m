Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4201223DE7
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149613; cv=none; b=EY1ErKQRpQaruzX6ncCen5h6bO+qMMrmJV4Y+emgTCYMEr9FE1J526seZnbk4+qSMv25mOB4HUX2kdECZ4sWhFVc72c4+t2KzvpyYxFUMzBxKFd29cYq0tqPHTDhjUEP9AlYz7sHJ9FHkMUc91tg7n2oKeugYq8AqWtngGdOnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149613; c=relaxed/simple;
	bh=ZBmisTz1y7n7+orGeQmWNaOgVmaR5iHbcw/A4y2L5ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGy6jJCezenRZZx5jpy/3OzoKTpUjwR8iDRa02dAFcq6CApZRTEC+Im7jZCG96eeaT3qtNSWmDYhAJ+ZJT/gjrJMB/DGLTBStMGq08A2B3hglVrP2FdDrbF0LZWRacbUpERqrup23ySO429+0jfCFezIwtM1MEZSoXhO/rIj47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTgX33hf; arc=none smtp.client-ip=74.125.231.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTgX33hf"
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-7ea63f91262so48488a34.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149610; x=1786754410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bSEGlE0KTn7NDWEUMdwFEmeelSZFcBTfw1LKPaxbgxA=;
        b=TTgX33hfnTGVQsAHMd5garbbF59veM+Tu076QVMaSFYgujydiO6OY7N21jBswj4vkX
         Iz8ev3A02E8Bw4sYDBBHY/zlIP/RzrObi6IPhVPpb5JzZRB/HDLjmQKWNigXWddERKcb
         lrhs6GQRu0IFyEPBJTym3wyZcXM9DR5FInv9Wx9eUIOJe6QGaAt5lyGZCmfqor8Ca1UP
         Wk9IvXKiMYPhqX2jIjsQnOJsa/hQ/r6m/jbPP7YOLcSkGdPdRfbvi0+G/uH7Nr53rCJU
         SCVTsohnl/iTepHAHWvy6JtOChyBt/UydWbC/NqyoGmiPEirXtMRS//YDcrKPMuYYqvX
         QcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149610; x=1786754410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bSEGlE0KTn7NDWEUMdwFEmeelSZFcBTfw1LKPaxbgxA=;
        b=DBmeWO2teR5plXJyZYpx3e1e4n0uC2Hd31DJqA7CDrWTFJGd6FFbgiFR5CgAUoNVfl
         4+dVWI+cBNtiF8s2CgxGXSh7UW6zQLGcJxRhQFXdVcoCACrZADGuvYF5X56XsOkn9k1T
         bx4tv11yRIxFq127vq6kdMWrvm9Kn/KbirwYjW5XY6X7iQoy+hacSinlkLV74V6qUxxJ
         CCB7RRLnY479OFjUPOhvhrtfG2TLqSYgSe3y96UQ9MdbWaO3Dl9EhT2TG+7hQbSUXXCW
         rye2guJeubHROF39ZQzp+y3zETJDuIKA6gnNqHx60+jdbz8VpLxUomspN8TR+J1+FbC5
         I83w==
X-Gm-Message-State: AOJu0YyP4PkcfJXFCgQsuI6B6/Z6/i+fZhbij+SMuijh19Xjau8DP5XJ
	DPallmnU2eom9L9MYHuOU3+iKSkTPlBspOi3E8GV0geEQ4HMg9p7KrpkzsyxAJp/VnU=
X-Gm-Gg: AR+sD10LmYx7Y1xrJLUty+/kFC+FVqrgvHMWZy3GNxnEzAw2gD7MUTEmW92SM87F8qm
	AIKb/rDjh0/DEqXT8t+ZFTxVg7jvv9X+7MY8MryIENwz7tdY8RcYovY5KJiOeQPLYKYgycJVCva
	lNHXKAy6foXMSXgqDI4laxebC/uiyYjRmIf2NOwldYPPeqJqnfFx7QTmeQS5hLgWzwKpvI0tfJQ
	z6JG7k/DPBJjmjfN93FlYyhW1sRirNKBMM/dn4aaefMJBhQr1SPVxg/uWr76dL29dmTBXsUitSG
	FQp+bKCC/NcP7vmlW+bof+1h84vJtDXyQ0SywYw9lzMdsWhiIi8cGFcbh9TWB0tDvmHPTZyWpvz
	inFein2KjR100DdHo6KkEL/oHDj038ItGREG5PpTcIOnuehH6prFF93Lvd+4SnR05a9P7ISenvl
	d35B2n3GgsWL1UPQtszQjXKs6BiJLgNhoBFIs9uou6aEB2MzBTzIhQZbspc7OyWBDu/LU01U8+r
	IZDWzMiU+NSHbbpRwBRueVh/nTD5ykpbZ5qFj9m7Ft5miEl+yfgWvi0whM9MbE9MMHJTmwKH7Ge
	Eot4jH8=
X-Received: by 2002:a05:6830:6d0d:b0:7e6:d384:459e with SMTP id 46e09a7af769-7f1e5c0dee9mr17143926a34.3.1786149610493;
        Fri, 07 Aug 2026 17:40:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b807256sm2279213a34.26.2026.08.07.17.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:40:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 11/14] bpf, x86: Fix stack-passed arguments for indirect trampolines
Date: Sat,  8 Aug 2026 02:39:31 +0200
Message-ID: <20260808003938.3486067-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2650; i=memxor@gmail.com; h=from:subject; bh=Q6NS2g6OZpIP5cej7F510hSGJqbaOOGntOoQkzlMTvM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqvIzy4uWuCSt4KpVaZpSYW3eVbsF3rzc49HseakmZPPO yoKOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATOTmM4Y/3MZ3ZuywNiq6/Un/46/ftQ d2fdzy+llCmf3GAye68t++ZGT4Z/LPWbzDwz7ScHbZ1pO9VSqLmjqbp6YbBKQbLQy9pCfPAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

save_args() reads stack-passed arguments relative to rbp assuming two
return addresses sit between the saved rbp and the arguments, which
holds when the trampoline is entered through the fentry call from a
traced function. An indirect trampoline is called through a function
pointer, so only the caller's return address is on the stack and the
arguments start at rbp + 16, not rbp + 24. Every stack-passed argument
of a struct_ops callback with more than six argument slots is read one
slot off.

This has gone unnoticed because no in-tree struct_ops member passes
arguments on the stack. The jmp-entry form already accounts for having
a single return address; treat BPF_TRAMP_F_INDIRECT the same way.

Fixes: 473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING")
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 162fbd2ba1df..8dddb5d7af21 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3080,6 +3080,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
+	int stack_args_off = (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16 : 24;
 	int i, j;
 
 	/* Store function arguments to stack.
@@ -3114,16 +3115,16 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			/* copy function arguments from origin stack frame
 			 * into current stack frame.
 			 *
-			 * The starting address of the arguments on-stack
-			 * is:
-			 *   rbp + 8(push rbp) +
-			 *   8(return addr of origin call) +
-			 *   8(return addr of the caller)
-			 * which means: rbp + 24
+			 * The arguments on-stack start above the saved rbp
+			 * and the return addresses: two return addresses
+			 * (origin call and caller) when the trampoline is
+			 * entered through the fentry call, so rbp + 24, and
+			 * a single one when it is entered with a jmp or
+			 * called indirectly, so rbp + 16.
 			 */
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
-					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
+					 nr_stack_slots * 8 + stack_args_off);
 				if (arena_arg)
 					emit_arena_arg_conv(prog, BPF_REG_0, nullable,
 							    (u32)arena_base);
-- 
2.53.0-Meta

