Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797803C98B7
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152865; cv=none; b=RLe0aZQIbnQsx+VfBXup1aDhS/MeWT8IYO0f8DKcuka3rLmwrVzhzflDQj+3SHppkDjG/u0BFHB6cwwbbMIzkoldBdaiVlt0wXlKetN3TixvqV/4zjEJBgRLYxJWbagEP2ey/dyQIBPtbBm02UEKxsgJYTaxIddiKlXDnRSl1BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152865; c=relaxed/simple;
	bh=nWWa4WteqCUom8MJ/zy5E2zD42S1pM8iQdC2q6g/pLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDfhP8VENeyoL8tvZZcXIYf8i+YJZiuXloFSprLs/YGBRAhZVo6ubYaB13QRi7TesPhBfQkO3zGr+yRtriLEI4mK0w7qnXS8HOKIF0NvwUO/WMCyYrV/UxFit+Z3nnmNuSITd3fJsUbU4+Z1LBnGtOmj5+HjHyuwRrYTMJt1li0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+O1MPhN; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+O1MPhN"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so969747f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152863; x=1784757663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJalazeNXHmJU72TXaYLe8TdoQ5UevYjLb9B+4VMgwA=;
        b=a+O1MPhNixTOcFjrXzn1tZQKI7zntW7pHcnQDv9lBiNWzIHFDPElAfPPBcd3O0JOKG
         qyRVV7wla5N/SOTz7IoA0EQQNJPxHaPBPLrJUQbPKo8tuEnDqmq60c7yYVtZOGILEETn
         utG+2pYA2EmxBd8K5KYtKXOOl06ZdIqbBfcSz8xWJqR2dS3g2Y1avrJDMeGg51I0fRXX
         BqaMDIdSCS5gP37hT8m++VoYdssPNboTsJYwcx4vuYy3pJ+G9+nNvZMip/ZG8qshuxPX
         KlhC+oAXKLGIlWkFCVV0YGYiI58cmkRIvHnZnrYVwtgwtGBpzv5EqT789B1oLJGQhINL
         FyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152863; x=1784757663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QJalazeNXHmJU72TXaYLe8TdoQ5UevYjLb9B+4VMgwA=;
        b=hwRgpBnpKU6yDLNli7rLF+5KzGicZqmxAnMzYSuodpJX7DO0OCWchZX1CnHKYonlz4
         xxpqBlJxxL9ZG37JZVrLsDvhi17L9PlXGMTuGuMrORRpbMzfQcW9h5LbyG7kiB52k0Ls
         YcxL24I/72KnSuiOTSMO/HXS/HrK2fxPhs1l0pSZa/5w8+D0MigXnCObfYj8fJZy3xVo
         fPHtLsO0kLLOOYLppI7PhpaWP2uvU3upTldCtuzR8PfpOksRWcRmF3gnRbMip/+vt7MW
         sYfZpLaCFNPMcRyvboDoe68JdxCJgr7n7RXBuf2MIao1TZzTfKGdhaluA/Z0vKRTmJxA
         MFDQ==
X-Gm-Message-State: AOJu0Yxgep1NxykeU6/jfliy/xCMjtX6Kbl6V9toaNQ/5iazlDIAOxeu
	nwtCERYy7Bh405gmDCGrxBGEtpGEOeFBJ6WR2t08ScWTE3bzDZ6AGF5rsNuvhDOR
X-Gm-Gg: AfdE7cmgBqikITUQa3MeL/IiHEHF5EgI0svcoKRQ7g3xKQ5N/8Q3bYCUaf4wacc2aTT
	jdxpGpwbBIWf/28R4twAbmaNqfR32m1koNH3DX7GTBzq12RU1OSIbp/DVVU2rnv8IzA8gaTzKac
	XqpeRyaPcEoTYSvMMf2X92R76Ipde1XXXjcrxtPncECKIxZQm5r9UX2aCZ0mr8gM5ISmH4N9+9Z
	8FRZMAaPIWIemkA8SgIiViirIkJ8o5sEb/xVU032Qzs5a8fV1txVFSdI32YMsaO3Vn9XpLR4P3C
	7ZAdD5lAiNoIs+swmUGvg0DDwIr5TXDGR4LymTYvkNcXeTRwXxJV9Q9A95U9/flv86lUgTfVIuB
	P45HQulyA91bfuHpJeRt5mUoXh6GIhpJEhJ4UX2WgT7HBZow7ClCgwtxPWJorlN38iFDbViCJCf
	yy0zoDvjQWmZeKDf6MoD6551tVpqDMxJTWNxO0GgFihRKevrmTi9ppy4G3+XWyi2Qaypp1nboO3
	kVcr8ooFMyijGLYU5MlWd1xXQ2gHnqiwkd47upMq7L+
X-Received: by 2002:a05:6000:178e:b0:47d:eddb:c10f with SMTP id ffacd0b85a97d-47f4fc9983amr5588655f8f.7.1784152862606;
        Wed, 15 Jul 2026 15:01:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635ac2esm19913865f8f.13.2026.07.15.15.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:01:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 8/9] bpf, x86: Fix stack-passed arguments for indirect trampolines
Date: Thu, 16 Jul 2026 00:00:48 +0200
Message-ID: <20260715220052.1590783-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715220052.1590783-1-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2605; i=memxor@gmail.com; h=from:subject; bh=1ct/hxltmnSiXyjXwfPj7VSv8n/pmFE1tLV22VQsZzM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6Q5rTPIn154Ut7m/7NqtegLjGB7wtMmXfSv4F3Dwz +aAnMcdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMjTXQz/1IwYJwkELmK6s8VW Jmb6xO0ae6svb9r+66jsY45vcvXtXQz/o2RVXfXW1nf5/XgYMn2rxLIQlSvMO8s/flaZc/15esp jbgA=
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
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2f25353f135b..672fe54dfeb8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3074,6 +3074,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
+	int stack_args_off = (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16 : 24;
 	int i, j, slot = 0;
 
 	/* Store function arguments to stack.
@@ -3105,16 +3106,16 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
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

