Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158245A2B2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292709; cv=none; b=n/A6HCokC5lOwE8DOBU52ywDhiVj+GKODaLoS997cJo3SB7pnRAwk1la2mfs2kUXvLOkz60kQ8waYr5ip0RPJ4mPxPHJ2Bji1kMzrZ6E6WTYIzKhz5GZW7P+b6b03GVEn3JBVtJXpsyfnjldSTcP2Xed1rwdI1DqoY0iRHLDG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292709; c=relaxed/simple;
	bh=9Lkw/7CAFlDSNb17rAx0WTaEzFhkuf6OJhgX0toWUbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ht2t2XFeDWeqnkGbjsfaf+7hJ93mxHNtUYLo++BUqONpvo981PklK+Lu3IR50m3W9moxeoPjVt48N5TQsJDruKJRxatw7/G7RepDmX89vWlaPennr42m/sKhJUvMdixRjhkXC10yP4t5syoBY8Vabp3AEN+rj2gfXZjeQNpYrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rliuLauA; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rliuLauA"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9866so2072785ad.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292707; x=1790897507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K11NGpyST4JQKnhovY+q9p0SS4LCdKDiLAJEQUQB8hA=;
        b=rliuLauAbowFaWkAyagcF5RXatH8senUMmKk0OO+Lq6qUBtb4g0J4ErnB7co7fbhbw
         03GEr9zdi3dbbea137qgZPHSpfl03pCRfjovGCkWQXETPRPtQAtERwsWvB/ECXpm96OZ
         syZv6NazQqRxKU9CHhOidU12DaiWVXfz9KnfE2355W4iJgK7R5h4bNm7jeDz7r3Dnsbr
         dzCvvfdU9KBZjl+GtCLwG3DMtxSDod6OBguexXFs2oECNgmm7a2+soQMHnnxmqq9gUbO
         Vt9skwDMAIMH6ltG/i0pn8v1XPddo/7nXM8irygOlcPCFTbMW5wHFdcpy8cFwvj86LyS
         PqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292707; x=1790897507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K11NGpyST4JQKnhovY+q9p0SS4LCdKDiLAJEQUQB8hA=;
        b=T1bsc5vdvxZgYaJfni5tKawQFnfY+JWyC8hXMxQXsA7qwTIseswNJCYhwQbsxLU7oa
         rm3dIorUX//TDIri+n/LaBDTVfk2vmD9/OpYEM+1rwq/AqHQQVh3EGO/bVLWT2M6klqz
         7NTvSzCwAbSJNzxWHZfj4kG4cTWyKphlKlOoo7uTh/LfO6VjClophWKrifCCLEzkV3S8
         XA5/fUKwpbJeB78KRDtwY80EHJT7fwD6cbYPno1B+AP8V4DC9HDuLu0jX+9ZkErSdug3
         Ld6WayGUorqFUFoqNOjTXy3VEizM4zDaR7DVz2V3wHS+UsZdjtgec0rtyCzeor3PKuTc
         EcLA==
X-Gm-Message-State: AFuF++lSKi8hZy0iDWOChxanc8r+OQzZ4GUEWkkG+GMpYsIlux/AWKNc
	uOhX/+y8O2zN4aF4PSTQi1NtdG6heB793JS3Lw5J3sW6Qu1JtpEoequCK9gtHg==
X-Gm-Gg: AYBFou2YpEf8k8xZsSsTUniw0MWDkXobKRN13OunbI9Sylxf1k9iMajNdaYZv/gabD1
	ec2iYKdGkmHW0RUaD+H1n+3B4IJ8pPHmxaL9J617Fm2arb8adcVNYjST+8SgAzmNWk321Xf7Lbg
	ShfPCm+jw1Uk7+8rS5z/let1mfOPw3fOaNvXxDQTEtCZEeF3vZJLlfCKthySP6kiz1Xao6Qa2W8
	ZFpei1+j/DBG5P7F6l56xGGM5j8HuFLx8JePTysVI/yu/F204b92lHvyHdtigU4/oHzfcbVFfBG
	eygU81dL12uAWNJYXBssqcpT9Vt+5ICABFB65uk7JiAieUZzpD0J/0Rn1bctQcFxS3zwrXkaGy8
	kT9ZSalUmewrwvga6nHF5DlDdj3elbeVO8efFgaBQD62CV52WKTW9xt5jAHjJLCl4QhP6pKbxzH
	Qr2wLYzit/bU93ibtQeNUgPGGGx+s8RVaJKD+4uHrgjA7wSRtZ936sAUx3yNmfRHdlreTNvj5WF
	fW1S/5Fx0xRC4csZVdZhSZAqf5QpRhV7nW+o9pSIDLMIL4SHWp1p5rEluIopdsC6QTUeMustipK
	P446b9kB1eKrBdFY5E3bPrm2LPa3dEDNGwsqkEWj2K1gR6xBIRC/j/g=
X-Received: by 2002:a17:903:1aa5:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2df7da5d7abmr33269385ad.3.1790292707009;
        Thu, 24 Sep 2026 16:31:47 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91475206sm1927665ad.82.2026.09.24.16.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:46 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/8] selftests/bpf: Add tests for pc-relative insn copied into its own patch
Date: Thu, 24 Sep 2026 23:31:26 +0000
Message-ID: <20260924233130.1213812-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add tests for may_goto in a subprog that starts with a call or with
ld_imm64 of a func located in front of it, and for nospec inserted
in front of such call.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_may_goto_1.c | 121 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_unpriv.c     |  37 ++++++
 2 files changed, 158 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index db7e30da234f..faf9eec0a63e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -173,4 +173,125 @@ __naked void timed_may_goto_preserves_regs(void)
 	: __clobber_all);
 }
 
+__used __naked static void mg_ret1(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__used __naked static void mg_ret2(void)
+{
+	asm volatile (
+	"r0 = 2;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__used __naked static void mg_call_first(void)
+{
+	asm volatile (
+	"call mg_ret1;"
+	"r1 = 0;"
+"1:"
+	".8byte %[may_goto];"
+	"r1 += 1;"
+	"if r1 < 10 goto 1b;"
+	"exit;"
+	:
+	: __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2, 0))
+	: __clobber_all);
+}
+
+/*
+ * mg_ret1 and mg_ret2 are placed in front of mg_call_first,
+ * so the offset of its call is negative.
+ */
+SEC("socket")
+__description("may_goto in subprog that starts with a call")
+__success
+__retval(1)
+__naked void may_goto_subprog_call_first(void)
+{
+	asm volatile (
+	"call mg_ret1;"
+	"call mg_ret2;"
+	"call mg_call_first;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__used __naked static void mg_cb_stop(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__used __naked static void mg_cb_cont(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* r1 is zero, but not a constant, so that bpf_loop() is not inlined */
+__used __naked static void mg_func_first(void)
+{
+	asm volatile (
+	"r2 = %[mg_cb_stop] ll;"
+	"r4 = r1;"
+	"r1 = 2;"
+	"r3 = 0;"
+	"call %[bpf_loop];"
+	"r1 = 0;"
+"1:"
+	".8byte %[may_goto];"
+	"r1 += 1;"
+	"if r1 < 10 goto 1b;"
+	"exit;"
+	:
+	: __imm_addr(mg_cb_stop),
+	  __imm(bpf_loop),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2, 0))
+	: __clobber_all);
+}
+
+/*
+ * mg_cb_stop stops bpf_loop() after the first iteration,
+ * mg_cb_cont lets it do both.
+ */
+SEC("socket")
+__description("may_goto in subprog that starts with ld_imm64 of a func")
+__success
+__retval(1)
+__naked void may_goto_subprog_func_first(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = %[mg_cb_stop] ll;"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r1 = 1;"
+	"r2 = %[mg_cb_cont] ll;"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"call %[bpf_ktime_get_ns];"
+	"r1 = r0;"
+	"r1 >>= 63;"
+	"call mg_func_first;"
+	"exit;"
+	:
+	: __imm_addr(mg_cb_stop),
+	  __imm_addr(mg_cb_cont),
+	  __imm(bpf_loop),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 3069e70fbcbd..a54b5a58b945 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -1035,4 +1035,41 @@ __naked void stack_write_nospec_slot_index(void)
 "	::: __clobber_all);
 }
 
+__noinline int nospec_global_func(int x)
+{
+	return x + 1;
+}
+
+__used __naked static void nospec_call_subprog(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = 0;						\
+	if r0 < 0x100 goto l0_%=;			\
+	/* executed only speculatively */		\
+	r1 = r10;					\
+l0_%=:	call nospec_global_func;			\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* nospec_global_func is placed in front of nospec_call_subprog */
+SEC("socket")
+__description("unpriv: nospec in front of a call")
+__success __success_unpriv
+__caps_unpriv(CAP_BPF)
+__retval(1)
+__naked void nospec_backward_call(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	call nospec_global_func;			\
+	call nospec_call_subprog;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

