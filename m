Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423178;
	b=nde58TorQ3NUv0a8aLKT7XUf2/ReHz6v5Yzc6Z7B1fcgXLwmct8TRzPLA4xd9qq5SOsj
	 Kb8gzMl5UyMiKbBFlnFt1lw1Zn2u4EzydMlqcEHSziykwa0dQvfQ6uMr2SDh+h0socBJy
	 GQO8K/Sc40fr6inJ6DnJpluvvWTNdMtJP7GJL2fIKxc8cfueXqSTsIcNz8A/RycTsWHrh
	 D7uaEP8p3RHw7fWYl3K3i0Dc5hE133NNvjcs0nmEBMYjsTd515luzWfgseAZWIwUuLfz7
	 zlc3yZPjeo4euZgBMm79t1mOfQNzP1nABmPbiPoKfZ9c+/hO1GD7esIaHiYEBGUThzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xtnzhqsyxqtBsrf+x5l6GUk0PKf3PUrVmPhlFlC233U=;
	b=eE1+9EPu7tMuiAvag3uZ+TgWzN5J8ExFnQdbKXQPzLAHMsuzYssWwqrul7p18NpjxuU/
	 Nmta7m3QjCZ1Szdw7nOWcf5rTS6/9v3sd07KzOdU2CClmYj1vdBI0CZ6N+jpz8uYJltZY
	 K1tiKq/E46TUWkN6DwgukLDQO2qX4clQ+Ht8xoGsnow4jL8SJSxOgNWbSl4qrnXNw/wag
	 RAS+lLoSsdePGWLyNbnPmYvpY/WJdiNluyVvQbzByEgGgNlglk1SMF7WUQ6i/F0tYtzRn
	 GC7i8Rr76Wb9mEtIT2tGVUV3BOvNBR+mLyjPlBoBhLBlN7KWMdklmeF24a+Ag9BrEug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+z9usNL;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F269606A31D
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 05:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F269606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+z9usNL
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9ae391a05so9852975ad.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793423177; x=1794027977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtnzhqsyxqtBsrf+x5l6GUk0PKf3PUrVmPhlFlC233U=;
        b=D+z9usNLwPnJNCyVOLbkFYKOzIAtuIyaS2j8Ycz2AeKGiJTavDH5cUwJ/CbuXHsmLQ
         Fjdk5Z5hXV1WXkY7tUhxBM3K9gsEmK1bqSZwFis3LMUI23jlUJEMRPodRUAWli0k/Neb
         liAuZweMnbSuu3+LmEQeG8pG0lZEo725auJ6pCWSlI6oHO0jXNyeKXjXxShgg3in72lM
         EgWid+QEleUbYbkm+58WwpcBaVXU0nZRmwQz63ddaAxmwnUoySJIb0D3EZJGa7tq6waz
         W9J/OWdbrLGfSY1qGQp3+HnbUHUBYr1rsAAH/jTMOMvKk3nSvFYCbXgJib3CyrvL2Qk1
         sJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793423177; x=1794027977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtnzhqsyxqtBsrf+x5l6GUk0PKf3PUrVmPhlFlC233U=;
        b=MtUgRAM/AzmukeINvk4hoTpUIWpI7in7pFcnOvy85e55Z6xFv8AjDuGPdv3zSOGf54
         qFZii8ZpCGmv7KekTOu+e8IYVjO6S8+xERouVVnaw+uFG65cExU5NHhFy2/sWdgLFiPU
         TG7APBGVSqXMkPRbSIHSbxgtK9ha4CYv2SicsF7kuhzsjmT5++nTp7qmHtX4fdvf0BU0
         ncWZKlk9J6871K8wY2jG8KF3AJzz6ZiMi+AvxpdftClebyVZuTWffjRJ0qzp218Oiq2r
         r6uOsdOMoJbvjuLE9ignUpV8aVeNbTY12a3rtmnLoGMpwR2YqGWTIEcteAjHyrx8hHKH
         vwwg==
X-Gm-Message-State: AFq9FYJJeiiJSiqrUO+8i6itiWO48jpBGWgbdskxMRRbzxl/vDB+iH/0
	8pi1x/7xtO88VHw2uB2rUfBQK1Q0kNaY2ff5xOwiGVhFF1cgN4wYL89zJsXWIw==
X-Gm-Gg: AYBFou2ul12vYhoGmbaK5mcSQDyTf0f6ss0B5OenUf9LBDWE05vq8+I6bCsesXdCOPV
	VJT8VAuj6BfGIHOMr91BLFGc0HMI/sjuD2DxjwenFkALl7hkiXkAWrFClUI863nKnkjkOuizKhl
	Y1K5lyeKVH95RJ8LF6s+LsjxXix8P9do6kNWtdtXupUOLjNdj23LvgtrxaOu2VVXT1+3Ro3pm6t
	FxRkSVq0dl3SB+XGo077m9pJwnxgRWPwTPKOPKglQ+QuV4rlFk/WlnnGVVAFZBNbtR40bEWb0Hq
	wpJ5RRRFTYxDCQIMqs3k5d56PQUY2ukC9INqeBklXHLot494kLHc43zsj7FkUIYgzgSOAc7TZee
	L/E3MVE5o0dzQd6b8hZ5QSSGCLOtdh8w2s3nTgUXDvQI5zWsINZJH9xUpS8RMfPHULvxFybU+RF
	khXSjh9ftP+iCObBy8JBbBLzux/hEOzFuou2G/7lh6LscUe995squbopM7c5lun20nnGU+x930f
	JV/myZuY1QQMMLg8JOigZxup0LXFFuodEhh4zPqP8q80KXfOkR7kkw7DuqHQRzvoGfEXdBK9RO6
	n2jI5PzOj+C4ds3NvqUJjfSD1htLCcKwquGA6gU8XJKro+GdjXJ/AIWq6N1Ck8UbijtepT+uiB1
	3s+qoy5nGdNA9rAyV/ZGB5g+OUK29szmoxU0m6mkWjF3v6HJ3CQ98/6qlVtIhuJij9x7gWXc4zK
	M=
X-Received: by 2002:a17:903:190:b0:2df:b004:df28 with SMTP id d9443c01a7336-2eb365055admr32016515ad.35.1793423176736;
        Fri, 30 Oct 2026 22:06:16 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392965fesm12804265ad.59.2026.10.30.22.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:06:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 2/2] selftests/bpf: Test bpf_throw() in a prog with a private stack
Date: Sat, 31 Oct 2026 05:05:58 +0000
Message-ID: <20261031050558.2410721-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031050558.2410721-1-alexei.starovoitov@gmail.com>
References: <20261031050558.2410721-1-alexei.starovoitov@gmail.com>
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

'Private stack, exception in main prog' and 'Private stack, exception in
subprog' are fentry progs. The test loader does not attach them, and
BPF_PROG_TEST_RUN of a fentry prog does not call the prog. They are
loaded, but they never run.

Add three raw_tp progs. BPF_PROG_TEST_RUN runs them, and the default
exception callback returns the cookie of bpf_throw():
 - the main prog has a private stack and throws
 - the main prog has a private stack, its subprog throws
 - the main prog has no private stack, its subprog has one and throws

Without the fix of the x86-64 JIT the first two crash the kernel. The
third one passes with and without it: it makes sure that only the frame
of the main prog is taken into account.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_private_stack.c        | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 3d9994a52464..bbc09f516d92 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -279,6 +279,105 @@ int private_stack_exception_sub_prog(void)
 	return 0;
 }
 
+/*
+ * Nothing attaches the two fentry progs above, so they are loaded, but never
+ * run. BPF_PROG_TEST_RUN does run a raw_tp prog. The default exception callback
+ * returns the cookie of bpf_throw().
+ */
+SEC("raw_tp")
+__description("Private stack, run, exception in main prog")
+__success __retval(1)
+__arch_x86_64
+__jited("	movq	%rdi, -0x200(%r9)")
+__jited("	movl	$0x1, %edi")
+__jited("	pushq	%r9")
+__jited("...")
+__jited("	callq")
+__naked void private_stack_run_exception_main_prog(void)
+{
+	asm volatile ("			\
+	r1 = 42;			\
+	*(u64 *)(r10 - 512) = r1;	\
+	r1 = 1;				\
+	call %[bpf_throw];		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_throw)
+	: __clobber_all);
+}
+
+__used
+__naked static void subprog_throw(void)
+{
+	asm volatile ("			\
+	r1 = 2;				\
+	call %[bpf_throw];		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_throw)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("Private stack, run, exception in subprog")
+__success __retval(2)
+__arch_x86_64
+__jited("	movq	%rdi, -0x200(%r9)")
+__jited("	pushq	%r9")
+__jited("...")
+__jited("	callq")
+__jited("	popq	%r9")
+__naked void private_stack_run_exception_sub_prog(void)
+{
+	asm volatile ("			\
+	r1 = 42;			\
+	*(u64 *)(r10 - 512) = r1;	\
+	call subprog_throw;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+__used
+__naked static void private_stack_subprog_throw(void)
+{
+	asm volatile ("			\
+	r1 = 42;			\
+	*(u64 *)(r10 - 512) = r1;	\
+	r1 = 3;				\
+	call %[bpf_throw];		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/* Only the frame of the main prog counts, and it has nothing pushed at the call */
+SEC("raw_tp")
+__description("Private stack, run, exception in subprog, no private stack in main prog")
+__success __retval(3)
+__arch_x86_64
+__jited("	subq	$0x8, %rsp")
+__jited("...")
+__jited("func #1")
+__jited("...")
+__jited("	movq	%rdi, -0x200(%r9)")
+__jited("	movl	$0x3, %edi")
+__jited("	pushq	%r9")
+__naked void no_private_stack_run_exception_sub_prog(void)
+{
+	asm volatile ("				\
+	r1 = 42;				\
+	*(u64 *)(r10 - 8) = r1;			\
+	call private_stack_subprog_throw;	\
+	r0 = 0;					\
+	exit;					\
+"	::: __clobber_all);
+}
+
 int glob;
 __noinline static void subprog2(int *val)
 {
-- 
2.55.0

