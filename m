Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604937649B
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785029477; cv=none; b=unZrpkKZoWPmPD+Dxex0sQr6KdnGarCNX2WhF8m0IldAOzVIn/gReJ3yOv1kbtyOzxYKlh9O3N68yVQHlafsdXMFACGkV6Uijo1u7NYUmcppj5w8d7BBGWFNtPnfnjLwtmxF1Jsew66GXVMYzM01feGTfEYDBDqVM5xWAON/6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785029477; c=relaxed/simple;
	bh=569zwIUDA2V9OuETpnR7TeQwETZC8dLrTOrR4p/7aPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hz/8l0UXGnjNHMcMc+8Yr6t+uM59xumxef0GvhmKlE2NoXgxgbeL+VqbrxqKw6XFM5rUEqnGwH9SrqZyuw6d/nQqnwvptauOSB9TH1WoAG1bWSHK3GWxvjb3tqC0BnySgpyYX+8soCjAgR2kwoEaTttH8fab06aOX31VzgJZ6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEezsxgU; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEezsxgU"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso7124815e9.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 18:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785029474; x=1785634274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0gkpyxs4wCe/5i2QFjm+DZ8BExsSpp6m1gTEtdbRGw=;
        b=iEezsxgU75axXQScLWvVuqZD3eouIU/wHEfJrnUvsg8KCeXc7Amk2iRXk8G364aFVK
         voI/x6vDeQlXDeQBqHBmQnEfAh5vPGrx3Q1GLfO/Nx3xPDVAddS3ntn/YW2r61/0gFj0
         /uIXYLFpr9Bql1OqGAbUht0r3vs8jn+422BkkwM4nH5vlW7I8qmGjitwwiMhcGyFDlr+
         k9S9OFUpdXrvQ3tEXf/qInCfTPIHUIoG0h6jnAqLaIAB44srDI8bTRc0w0+oNPscCYIs
         1g1jsAREvReo+NwPm/jKzWU6FvPLUScTMfMCzT8hwfsurayQ1C4zzdPTrmz992OFQzsT
         WuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785029474; x=1785634274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0gkpyxs4wCe/5i2QFjm+DZ8BExsSpp6m1gTEtdbRGw=;
        b=SqoYPbJish68/yGa0sUSVjb9iWEfX6HG9j66AeMxo+0mxpOU8kLrChdfL1aRmIZvqI
         3k4HB2+BsL05kP0fb6xE3UV76OVPa/tGWO5sJ3LKLIRBaGLV4OG4FNRVZ0RZsWkp1Vtd
         CaKyJmxY3ERPJcYsuHLTuPB4+RKRsqPylAtnkARB2Sw5pZTUxEyWMUWwC4x8mcs87P+C
         jS49bcBBjwgCQwawdAf0USXL9/q46x1K90bRTOCrhLHieRSEg1Q+2zILtOJPWyVp67HF
         gzPwptzXp5APzgDYmRUXRKjd95tJA49qNwn2d11Rk2W9yT8DmYWJWkrZqbOIEhTidp0Q
         KfbQ==
X-Gm-Message-State: AOJu0YxbglkjU7YZ4/MIBRqbmQ4seLGuHRWkNUjQGK3YhbzhxzrBIq02
	hfW8jMBkDS7sVhkYiGYVpojTf+ZLX1lSs1jHbGU89R7O2oOd+VYQQd+y/jefmABC
X-Gm-Gg: AR+sD127yi47SEu/vLuqguOAnXog1iPXnvmYcXXP06NgObvQxbVVgT3QGHljxHIg0Lv
	9IXMbE1EK8rTkKYFLTB9K7YkAGQWWSmJBNr4Z9CDM86YAXW0/p1ms7UAmHZTyX/gTljrUuehYle
	yeksL8WFfLc1j++bcDrmO5rChJsAbbYqM0oRDPVXa1q4lLoOyQwAid8GEZ9v70ASoP0+4KVjHa4
	Z1VJD+jUxobT8AGtybUgZ6M3jfJleJgK1uBturzzGFNHuDpORFENEEVsXcSnU+xDpw+4oPGbhss
	IQJtOLncgp0JOkwMGYI1u+hkHXs4rWF+8HKM2kb5R//iMYhyMiB6IYnmsLjXhbk6UuHF01/TsM9
	R913K8tOK0F7AczBHE7TufmgeL5VycD3yJQmSuNGQXjZAZicXLtVlSSvI8oNDBRc2WsspcSguGd
	vpc5Us2k0mP8mNuXH2Ah+YkyApwDD7uktkZAyYT7oVgydW62HgV7ywiLLq3yiPc6gsldJbtXXb6
	JZ++L7Noug8vth1BLetgC717XevR8Dn7q+wR5G+Yho4
X-Received: by 2002:a05:600c:4f0d:b0:495:5d5b:7533 with SMTP id 5b1f17b1804b1-496b6a31f12mr43276575e9.13.1785029474299;
        Sat, 25 Jul 2026 18:31:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b49a8547sm104920075e9.14.2026.07.25.18.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:31:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 8/9] bpf, x86: Fix stack-passed arguments for indirect trampolines
Date: Sun, 26 Jul 2026 03:31:01 +0200
Message-ID: <20260726013105.3689867-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726013105.3689867-1-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; i=memxor@gmail.com; h=from:subject; bh=cT7rsmFNoX6js2Yrn3qUECqmxAOBvpIrUZx54hfrNHM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISs12frK3gu1YaEr9iasiRDe8kw8+4Ri5QoHfUnJo8L3b 6Wt+7Ouo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNJX8zIsDj0U9OlkMfp4X8W XjytHP3xlD/rPd71S8zvbJ9y7+ufxk+MDN+uMtkr/tORP6Pws/237EeBzY8YvrqGKJ/MmnLix9E VBzgA
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index dfb5335ad837..4b349ae35ebf 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3075,6 +3075,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
+	int stack_args_off = (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16 : 24;
 	int i, j, slot = 0;
 
 	/* Store function arguments to stack.
@@ -3106,16 +3107,16 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
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
 				if (aargs && (aargs->slots & BIT(slot)))
 					emit_arena_arg_conv(prog, BPF_REG_0,
 							    aargs->nullable_slots & BIT(slot),
-- 
2.53.0

