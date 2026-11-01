Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502390;
	b=tVivSHYqY15K3qIfZ1B0LOVsS3ieuZJpnfZWu7emlj6M67qwtHT7lkGtpqhGGmYkS/w1
	 K4Ub92kGq5LFJVALShcjJzcaSlAZowiwvGb3798vnTnrZrKQ1dOEVzbmaMlAMb+c7NweK
	 exbZ/v8ZpsMQ5QN9b2jGH9NqSY9swlUfR6mvlggCmZwcek9/4b5em87irxx5P51uUlLZE
	 bamMgxjn2yFclIuYjbfcU26WQRdv6hYuxlFw+UsSV80q4ru/odG7u9jEt+qvd+aqlSXs4
	 EBZGAV7+fw94E+aVXUdQmWxjNntFuQHR3jB7qGFheNtv8+7fhuOq+yDcKYAVhSqbQ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lr/wxfOS32+ALQofs1tJZPZvXT4JxRnn24bqDnojpHE=;
	b=e4d4GPfvm3LOPQviroP5fMRVg53lGZfSCQIMZ/KOADhPZaILhd+Xr0ulNROfb8QlxJpA
	 gutHTSbkol02d1d0cgFsOHbA8a1Ic9Ou158vOSiD3adgyouhxuoBRfMhyTgWkLlUWw0+U
	 LmEUagRrKqJ6mBXtfYUf3hlYiIkt640wFfCPbb+9olQ1/wS6TWylFMb77Gdx2GRJiTVqP
	 oSufR0y6F+8GzbVm4BqwAHkyYkZbRWUHm5wr6zkcwVG6vY0D0VH7iA30YiEqpqsL7kqez
	 WAPD3sgC6i7yw0z6K52yXJ593La1L0QqB0a1TYxc9VaoXJyVPx1DWkdau95wTJEJ1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTURMcyX;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF2606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80DF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTURMcyX
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9d7791b00so14499165ad.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502390; x=1794107190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lr/wxfOS32+ALQofs1tJZPZvXT4JxRnn24bqDnojpHE=;
        b=NTURMcyXIPSNMABshII64kov3Q0m8ZW4qDzZgKjEsI1QHCK0HOt/hPAkSD4vKQLh/C
         Qtk1qysQtRdcYeXgJ9BefxivFlUtQaLHg/zrnljf0Cu5RS5KwS4z08v/c+eYgzs+oUVz
         jXVjVIhyftipwBSUFFUya0ye+CAuUI726NKqQy0Vu+wsGgC3qEdW70RCYN/7OQPFwCQi
         UjjmrhPf0ElIUOS2LfOGvxMGuFqDp4/6uLdLBOtyuTDhIFEVEDPg07eT3SFKWIXdXXPv
         e1bEdebxSfYhoXkC1nti53x9SQNpxYUZXe9UkKRCiQcPU7fRvZnZAH1pbw0vAHSPkQnA
         qUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502390; x=1794107190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lr/wxfOS32+ALQofs1tJZPZvXT4JxRnn24bqDnojpHE=;
        b=st5mGA6IbSEizvT/Cf/1Ahm71GBeRvWwKousGIffDIbn3iZxTn7GK0eRAxBixEggh4
         beq+qO160ygwFi/QYAY7YKrtN5mrquMY/lu4OmWM5rVKWLznBcfqgd6j7u4lQNshqRLK
         2PLtjGfUeU1FOAoSzaELvUkQC/dG/gCbCLqMhNRSLsbCqsU3dZUe09xy5pS8zy2otOGz
         lBa1xOa90zAxOFLH1302SSApr50sWVmiBewb8bestJIUSMrYE0uIW6OgwrbbcC7t4SEO
         AxYn23GxfgfzrTtXypqIXYriuvd52CFxR1CYgwcQ92K5YhUQKN38Hmltq8BtZTNEOuOc
         z9fw==
X-Gm-Message-State: APuU4Z95laWq/QJdAMrr6uxi1tuhgoUr/Pwddhibb6KteAtCoVg7b3Vt
	2K6LL5GvNeA3U+Qui1EeBLKF/Hi5TlMEJf60l9ysOHeoV+iEWStrJGsR3h0M/Q==
X-Gm-Gg: AYBFou1jzJtMEypLugCvosSiy5Ug/njHJ5LPLpxSf/5vJUVmWkjOdx0ffMayyMsR1O0
	ERySj7KbQxrP1y9It+40APUAOpJFp4v9y1A5KvPwwB0CzAOgOUGWUGR0EhAQAY6zFZOlUDENjd2
	429pAnjD10sCwJeB+dn+eyqVJHBqfyl5tSSh1tVzYHtuil/Xp5FdH+w+uzgHhmFvKvUDofeyEdG
	4rJDSeTyiAiNU0V4zkUN/OfXBOE+XTyGD68R7BjFoT/SBWsX8cvlG8oKI594QrrxOGMrh5NYeX+
	+RCGHe/aMfITRacKkO2JR7cvYFQieSU1tXGeB8lAOJn7xtpARGNyJAki5Qh4tZQpW/f3JzM4BWz
	XeohMt64GejWV1gwKU6+lWKWRc//w/mDWhvErtP3V8fWIrxL7YkorZ9+umxcMcfbx2d/U6qhT42
	CkoTMZZ7jGeM5KjbNmvfxSV0GR/qY0X3bOzkNbYpSCSWMBWoIbjqd2jBIkDi00cn35fayqfg5p1
	tf0Y1qQbmvjfiVjN2DbUUqINBc2ND/p2ru7tqEZuT8Gn76C5qGsfI3OrkI2UnDZUXkXC+dz2vlA
	Yj0Nlh3ZTg1fWN/oNEbVf96Dv2MwLwpddON/JDWfV5fw/CSDpjkQWHcLNIYGHSA9lE1Gayx9Nvd
	A8ueRKk0dYRa9YAnUy3yXWPjL9O/8MtWrwEBoCRGcC1EFkFn49rgUkdI4xKUlqS95uhfKylSkNQ
	==
X-Received: by 2002:a17:903:2352:b0:2e9:4e83:1979 with SMTP id d9443c01a7336-2eb364b55d5mr57246075ad.32.1793502389715;
        Sat, 31 Oct 2026 20:06:29 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f635sm17933185ad.17.2026.10.31.20.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:06:29 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 13/14] bpf, arm64: Support BPF_REG_ARENA_SP
Date: Sun,  1 Nov 2026 03:05:09 +0000
Message-ID: <20261101030511.1578690-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

r12 (BPF_REG_ARENA_SP) is the stack pointer of the second stack of a prog.
This stack is in arena. The verifier replaces the insns that use r12 with
insns that the JIT already knows: a 32-bit add, addr_space_cast, and loads
and stores in arena. Thus the JIT only has to supply a register.

Map r12 to x23. The JIT does not use x23 for other data. x23 is callee
saved, thus helpers and kfuncs keep its value. It is not an argument
register, thus calls do not change.

The kernel calls the main prog and callbacks, and it does not know about
r12. The main prog, and a callback that uses r12, take a stack at entry and
set r12. Thus they save x23 at entry and restore it at exit. Other subprogs
get x23 from the caller.

Progs without r12 get the same code. The cost in progs with r12:

  save and restore of x23      0 or 2 insns (stp, ldp). The JIT saves
                               registers in pairs.
  load or store through r12    3 insns: add of the base of arena, mov of
                               the negative offset, ldr or str.
  load or store through r10    1 insn, for reference.

Tested in QEMU with the selftests of this series and bpf_testmod: with LSE
atomics and without, at EL1 and at EL2 (VHE), with 2 and 4 cpus, with
bpf_jit_harden 0 and 2, with pages of 4 Kbyte and of 64 Kbyte, with KASAN
and lockdep.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e99f105b7f61..e6d6df96fa99 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -61,6 +61,8 @@ static const int bpf2a64[] = {
 	[BPF_REG_9] = A64_R(22),
 	/* read-only frame pointer to access stack */
 	[BPF_REG_FP] = A64_R(25),
+	/* callee saved register for the pointer to the stack in arena */
+	[BPF_REG_ARENA_SP] = A64_R(23),
 	/* temporary registers for BPF JIT */
 	[TMP_REG_1] = A64_R(10),
 	[TMP_REG_2] = A64_R(11),
@@ -430,6 +432,11 @@ static void find_used_callee_regs(struct jit_ctx *ctx)
 	if (ctx->arena_vm_start)
 		ctx->used_callee_reg[i++] = bpf2a64[ARENA_VM_START];
 
+	/* subprogs get it from the caller and leave it as it was, unless the kernel calls them */
+	if (prog->aux->arena_stack_size &&
+	    (!bpf_is_subprog(prog) || prog->aux->arena_stack_entry))
+		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_ARENA_SP];
+
 	ctx->nr_used_callee_reg = i;
 }
 
@@ -2548,6 +2555,11 @@ bool bpf_jit_supports_private_stack(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_stack(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
-- 
2.55.0

