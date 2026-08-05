Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8C42BEA2
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963883; cv=none; b=SiUc2nDe+kJe/2qcXrhsOOT3YgdfuHLmFpNAzKvB9npfYiKJH9QD9QkSdxAKeKSosxuwTUtH7aPj3zvhtF1AU+mMOpfUTOMjZCuVuBXIiS+UBrTXzS2rFDkgGe9iJa/KcVRVbHvxvXgE/z/p6yv1kYKkbPteOsKm6n3q9+nx5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963883; c=relaxed/simple;
	bh=hJa1c18KeddMcYzmBYwIzYRDM9P6y/XIKuxbv1YO3Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNrYQKSgE22imatgRGtBiodHk4zhwFBuMSUPBwFUfEJCEUkHBX3zDhlFL4KxMxph7I/ikopIig+ciuctDBRlv6f2Odx6vbkCSC4miV5C8ZwY1UevPX2LyBS95tvY3RVn3+3y+Y74cgzHrZisUXjga9SACAeIlbIN22Ztti4kN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8Yu5iIR; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8Yu5iIR"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so3078605e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963880; x=1786568680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxpTc6QeID4NdUVwXfBvGdQlBSg/S+7waolixIP677g=;
        b=g8Yu5iIR3IMweb8gkOoBi5PVSWngTYwr98oawW6lvYM6VQmWMvt4ejWT3Hz649oZ0u
         32nYaVdhllay6KzEfvZWGktNmXX85zPNw0PzZHjgxN5AZsQwksbPYLBGIbY6ZV/h7AkV
         RWASOFEjdwzqvNM2PKmR6Y5zqyQxf2hJiodSZp51Kyjbif3iEsUXDwNSg0DFY/5xN3e0
         5hL99pPd89um7R3/w0Oj7oV2ZW22cQwjnX2nfyUzeGacSJucUhg5ANWsJLX3FVQMf+Ug
         roH87xhxhoblqzYCwK3BrKSBmwucBU8W6sldfU7rJRcS2Zf7nm09jILduxeUsGd2wmQp
         UZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963880; x=1786568680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wxpTc6QeID4NdUVwXfBvGdQlBSg/S+7waolixIP677g=;
        b=YbIY6XOhJfkF2xXIUNYcGg0Gm1uAOzhdzSz8UDw+KOksrjbAzs9hjK7tTUYAJL0ZXw
         eXxjrosqNJbBKgcYzApTQgt35f8GEvOo8Wp8szWviMQg3tdr7VvbQJKvsqP1Q3qiQ0bX
         HLoPcBVQpSNSolOefwIDmtgBEW4YOOllgcRRzbX3j2cNAq4nwNmxLHvG6TZnitaJ3bjz
         +ydM2odAlaX6uS+dyQepF+OuqOthh9inRaJBN9eNwx+EtnSgBgL/a+sYUJJpvbOST7ax
         XprtKjCbUFdVhDn4dYDBuEaTYWgGj/AuwACgH0+4zY06TTWUoSUCN3KeXV1YNQ29wWxn
         kpQw==
X-Gm-Message-State: AOJu0YzTXfFCUTZNCc/Hm28kyXwbeWJN4m6JRF2i89XsK6eofQ3l30nt
	vJiJCUM6TpmsXTHG2hWQlq8ZNmbZGKUYBlVjcUEH4IZnvXXCnt1R+3OK0cCAmvYT
X-Gm-Gg: AR+sD13T/QjWPJBWK1ZHaJ5ZLs938epxewE/jJ8T2E15UvLKpi14ZMkry/fQZqwGkKv
	LTxxjU83qWl0NYy0RukhHl+t4Fb5yzvp4dJPl37zbg/teofgHk6aE2Nc+a5uBVGg8+JDOeRElMv
	758Fgr2ao3FXOXvLZref2qmGdDkwvEDsXBq7nK49DPlqDhPZaqZwAL4vETnhwXLhPcuxGcHw+l5
	sJAjl3gEUx2qX+3dF/asbaAhN+bl7otAqL6fg2J2kUVEXoJY1AbSZfrE/o9ScUg03Ram8maAGgg
	/kgUEbeF05ylqN/PAIvuXL+Z9hDX+Cy1pmIXqXfPOxJkn+WdzMtUXmQS5iI8yKa2Rlj2A6gkOye
	c9Ck9CakHZtAmAqkXc5CJ1FUzH89Aa5a82XNJL8hxITGBJpc57tiuRpRQ6yuGlB/OA6RHE8RM/7
	rKDMlH7ppxmiHKmSiQx+gIELRmB2fe02WOin+RZGd07GO87WmNGbDaPC0+9TBwDW09lsqsmYAOL
	MpmNc10NFHQaVsF5bI2iGiSYbJWmi70nAaxI81Z2MpPuba77V+dExbzocKRQjM4TqxYaAmoDLGZ
	ho216Na0+rz33BcTWmdoeobV10V19OsY1EEXxLApmF62tjlb6g==
X-Received: by 2002:a05:600c:840f:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-4994e72605emr117682445e9.4.1785963880504;
        Wed, 05 Aug 2026 14:04:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b819dsm319931f8f.16.2026.08.05.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 11/13] bpf, x86: Fix stack-passed arguments for indirect trampolines
Date: Wed,  5 Aug 2026 23:04:22 +0200
Message-ID: <20260805210427.3218326-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645; i=memxor@gmail.com; h=from:subject; bh=MmJ3UAiCfPbrcgBmdWv0TN/EstXDIAPXCzTE/QUxvKE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40TRBwVPHE46fmr3kM1eAx6YdsVxxlbeKHjc7Bp1I3 F/2o6S3o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMp2sbIcH26wcbHnP6q100U TkwQ8M+o3Kr4fRbnxVv1LFe/bQ1+qM3wT//A7Ck3VMrWXdAxWZL2aTGLpL3hovNLmTYneio8jVW LYgcA
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
index cb8ee0f3a642..5c5c32aba239 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3075,6 +3075,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
+	int stack_args_off = (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16 : 24;
 	int i, j;
 
 	/* Store function arguments to stack.
@@ -3109,16 +3110,16 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
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
2.53.0

