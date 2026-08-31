Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8C3B7B71
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215600; cv=none; b=jhdpx07exK673NIYeiB5ojn9SECHOfpaYHvNUbgvhs+awm9LErGBlhwtOumtekX9pcWeapgirGHEz0Qt82YFGqnaCkaPQQu85TF3PQEpA6S6vxUvonxXKRSSg2+6z5xQ9i/Od9rRWfaBJyvJYU+vPdYl1OSt23YpYJN2wtbltnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215600; c=relaxed/simple;
	bh=N34LfzdwV1z6TqLJZOHKUUyzgYv9dhkINPjKCWxo7Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=at7JzLJH1ACwWW2Gsh6MDwfiBAeDuf/ySyRbTEDAF/3nPWTb1T1n0aqf6jW/eURAqovxDJXqIJWCN2/7F252Pu4jbuGw/EqiBiUH1AcCwGIJMx7FVY56+rRwzPgwAFsqi5couJ3ppZmLEK8e7wzfYT5BNrOQhpLfKdPQf/h2gDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLOLOYvB; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLOLOYvB"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so3437185a12.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788215598; x=1788820398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQ/PN0T5jWJ7k3P44JypAakDcWsl3bFHp+PT6Swpz5g=;
        b=gLOLOYvBxf/aLPBU8yq1bGs07IrA2JjNic/WvWd2jA2l4cRWLO9vKtXhLK2+/3nFO/
         X3OhB1sS7Le/PfET7PjV1O0slgcEiPZQGHici1K7pPSuYEqgA17uGqq99sXNVzZlp3dE
         sDhnNe74vOocbh5qNh2K+W2zwZfElLYJStVj9t2D0Ua4GEfj6ttScGwxa7HxjknEU0zu
         O4jvS9kB5t7pRzpJkVS84bElpzTpFKy/6i+PWruEtyQQFjRVQqABvSQXRF7MsSwThjQZ
         pI6yCqPnkj8FraWEWvyDTQsm/ByryyhkwzFioWaDBe8XrTP60xo1+z+SxavNVdckjdmt
         QnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788215598; x=1788820398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KQ/PN0T5jWJ7k3P44JypAakDcWsl3bFHp+PT6Swpz5g=;
        b=dM1j2hiCUTm2Tkt3qeBFbAFdO9fgk8uoSJLCbE57hS9VrSg6hMSCnonTpHz4VW3H3F
         WFQpuWWxnbwqoDJ/UK8S/NKweFY9ZHFOr1tNgP3HCAX+JGRYawmHQpKbNy/+fcT3sJ4h
         3NiOzeJp9nL/kiyL+JDw10/kUBDZxHmqXY18wY9pyAE0xu3k7MVew0F+tQq1NYIpQVwx
         bPxy48rUwx06xg7VSlGg3tYvvroHvro/1poLyw2KwCuNsgoVe+paJx+kxcIsFW59uXoo
         gW122K/3D8IVudH+8P0Vc9L+r5+CdC6beD2WHiw6lXRSr/Mx4/J+Q9MUCtVcSDl5ao6R
         HFlA==
X-Gm-Message-State: AFuF++lb/OvbIdOkX9UvzafUBdy/pyCVSlSAgICZ7J2+dj1mO2oBM/Xv
	JsbxoY+OYKT9MStWWUHCLBkeeummxvm6bxWHWIydNts8/Ystvs41ccnbGHK1oA==
X-Gm-Gg: AR+sD1082sd23MXnuoPeD4KQ25dZpA74mrRSP1/Poi/dz/7pElyAILqlJWYb6JUg069
	2BAGjzBJmLeKUhxIKI6OgpjlVvmYvi3UJT9a0mI5+66xRg3TqZSHkoilIoD2uMFKmJ7rPNjhsHV
	40P35U9C2KZ5+f327tPvxnfH13mk8t2caNguIW5IxJsdcsEZdSM3pddPvBwDucT8Xg77Q4K5XCk
	FrleXd+7E0bViCudxOPssm6Tb/AcHvKUG0KANwBp/o6YdiDIPZQdL96ZfDbIolUWakoepBtNLIU
	+OWDxinCC5lkPEgKPS4TPxboOsRrqB7X2gq0BSy14GlnsVd1EoA4GoqU7brGmnS+oCY5ZhZ0nUw
	AHEg+1oqDkq+Nx1MjgMjIFFgiHbHiMmK9b5ZVa4v/qZcEbb1I6kMkHgWWZUlMZ+kmhICp8WKiMe
	VD9jYZFZykf8etr5HJRqnfh0HyxR92Cw6IJDqLemH+Qc+t0RZXi6WFdecWJSOwpOlTfA1s47jF3
	Yzo9jyXJJzDVaNAckOF6ieQB0R+Ty9IAS1NRgm0M8ss97xhZqrCe8jKzi7mtDmh4kPtAwotgPwt
	Kk6PJh/YbNOmoZKtTbwQEmGZFqNWvhQ+92h2pO/trIgXgUyXRXbI4bAAZ0YHzMP/R1sX/OBTiVk
	=
X-Received: by 2002:a05:6a21:3390:b0:3d0:9590:7148 with SMTP id adf61e73a8af0-3d2685a9673mr43681977637.17.1788215598090;
        Mon, 31 Aug 2026 15:33:18 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36ee01asm4795243a12.28.2026.08.31.15.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 15:33:17 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rlmenge@gmail.com,
	hargar@microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test terminal gotox instructions
Date: Mon, 31 Aug 2026 22:33:14 +0000
Message-ID: <20260831223314.89787-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831223314.89787-1-sidchintamaneni@gmail.com>
References: <20260831223314.89787-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that place gotox at the end of the main program and a
subprogram, with each jump-table target preceding the gotox instruction.
This tests gotox as a valid non-fallthrough terminal instruction.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../selftests/bpf/progs/verifier_gotox.c      | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 5b18c9a27717..89067ab7baaa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -47,6 +47,67 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
 DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
 DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
 
+SEC("socket")
+__success __retval(0)
+__naked void jump_table_terminal_gotox(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:							\
+	.quad ret0_%= - socket;					\
+	.size jt0_%=, 8;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	goto end_%=;						\
+ret0_%=:							\
+	r0 = 0;							\
+	exit;							\
+end_%=:							\
+	.8byte %[gotox_r0];					\
+"	:
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
+					    BPF_REG_0, 0, 0, 0))
+	: __clobber_all);
+}
+
+static __naked __noinline __used
+void terminal_gotox_subprog(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:							\
+	.quad ret0_%= - .text;					\
+	.size jt0_%=, 8;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	goto end_%=;						\
+ret0_%=:							\
+	r0 = 0;							\
+	exit;							\
+end_%=:							\
+	.8byte %[gotox_r0];					\
+"	:
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
+					    BPF_REG_0, 0, 0, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(0)
+__naked void jump_table_terminal_gotox_subprog(void)
+{
+	asm volatile ("						\
+	call terminal_gotox_subprog;				\
+	exit;							\
+"	::: __clobber_all);
+}
+
 /*
  * Gotox is forbidden when there is no jump table loaded
  * which points to the sub-function where the gotox is used
-- 
2.43.0

