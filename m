Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467440;
	b=n4XI08SSf26X+kW5RgYFHocxXWGe9enRCKcl9BvY3sozokvO5MdpgP2a//Z3MWCvXhZi
	 1Ueuq46wb8kj5I7f1D3UbUuWdMP30aJ6EXq4tw++P8J9SR6lHHBSqVUvmZOpwha7dvSEX
	 OjN5ImXRyfMuk2l9LS2Q0cln+XLGomgXW6xnzrRVp6xHd2YY9l6lDe54rm5ADx9retgwK
	 MHUCTzwsvYmKNjSt9LQVRpmYWAU93waAQEkLhcpvQsC2i3+0uQ+uLvX/Lb0sblHMKZ9Er
	 G7ydZW1KnUkqymu0VQxXh5Mlo8plkzC2ReqDNFDlVlwvaGL/9+snBpgjZ7TOdGOnbqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lUOFn48dRsfmmegK7oOCfLEp5LAp84t1RzeB/ETKpuQ=;
	b=lbaIF6yeHdMGMuBaaYwR08lpvmgjW34OUHqgn56h4MAr4mNCib9YQ9qZs2iQOoqDEy1C
	 Oqt71aEsE53YRlJGS6kcvhX9qTlEuNyZWASNaP8TymlSaJ+FnEmzxzWh+shbbaEMa+pV8
	 6sbVFSVxFUZlKyYaQ63UPLhxZkd3IGP/xNvR+uTS9dRa/voOYsG3RZvwBQeFsJ8j/t26a
	 eQB8Wc9VXd3xvM54QySAebdgk4DBM2MsdvnfmZpuuFV0gut0iGXrXekqH0JYq7EP599z/
	 cW5SEFmBHiw6c3/+Ozi+467EiclVtKGhfRsS+Le4/wy6beJKyLxph4XyIp1ZzJqB32Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcCo0KIE;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A280606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 20:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A280606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcCo0KIE
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1227735b3a.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795467440; x=1796072240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lUOFn48dRsfmmegK7oOCfLEp5LAp84t1RzeB/ETKpuQ=;
        b=OcCo0KIEjGPiymFAu7p4DmJy8xe8HuZx/4oYEpJsOaGqJXRJjl8Nu/h4cO78+Q/eaL
         ybdR401VQS6JMT/FS8dJdM6J8H8ds9gQLjQ3kuIUm+N9Bn9Lto/4lKeIiIcFhu2erRbn
         fozBYT2ksXozlst3syNFddTBWpY4SbB6fF4Qt4qwIi7gBXeb+mR2CsFqtTql17R2QVe4
         6uVclpfkRcZahTYXqPQ7Tc5x6LIWvfAIRGrgxREIlF2Sqcj4bybXFgCcqEAvgON6cJCR
         5VpbbmBw+XbadKKDyK2atXsCMlILZSSrn2QXWSj4Gfa89VP5/usoVGx8i23M66dYHmBe
         usqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795467440; x=1796072240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lUOFn48dRsfmmegK7oOCfLEp5LAp84t1RzeB/ETKpuQ=;
        b=ZtU0OxCml+WOVEPWLW54W/1x70WlyuX2fUna/u6j1bz2NHv07P9Z6UltrJv38wE7wN
         4vSyx5e0iurBIbBW0+Hzdzt/+vm7Xk5Wz8NVwywf6A6Kj6Qf3xMbMIpsdF/livAf31uo
         UxFgfGS+R6DOApvikY8kZxM8pwycdmac1g7Iiaip7ODPR7uFOhPqWfoRygNNQvZtptXs
         lmBpI7c6i3+HEYv2TVh6KLzd6O6EXgM61Oe6tRs0EfWi5v1vjv3bH0qmlm/WZfUcDJkX
         M1o8hIi9Z+OQyGEI1oIiD8M0x9dv/djbv4OixCZAc5ifioNnsik92DdOBk922j6D5E2a
         QHyA==
X-Gm-Message-State: APuU4Z/r1/SzxGwDSzSL6eDa5WuZ5takEEkHrFHXpBP4HxnnwyV/BBcf
	aJoRZp8nTQ2C/u5D+EW9tbHgKw501tJdzmAIB8HBTWkCcMQN3IbA16N4X8/9aw==
X-Gm-Gg: AZFdTZcae27A7yBDCDQG82Dfj8fcYgQS/4ZhuJyRLeMFJUi/5+YZN4ZhDl2GjrVRLyh
	nQGSIl6zuEohPt8Sbe9u3VBrxSXR8VGlghqtc2KXzKjYXBL4EyTpPoAErTSlg6Gz8JpOrN1o2L6
	ZGLTrKAaUFg/kwZPqxcg+yenmTVwXDDqRJRonEsj/L8OPHotrJ3Q2jfyMr/Y5bIm+dFcsc+bnhu
	dSJKR1Qnj+ljVwPMXQUgXcqR7sBIqRKqy/MnV2tZigUYYQyGmQ3sUI71SmxzQBEVjv52KNA5kq3
	U4pxrCufur5EWj/LCn6Dlev2fxaLe6HFu0lyv6C48V7F3VTke9DUaFkdlfx6hzNbZpIwvxalMZT
	8reR6jqv9wbZvG6M9vZHeAmgUnZR6ryWqjG2vX+Xa6bKt3GgpGAzLWFMocZ3C74/Yc+EOFr4DC+
	5F/RHXjmeKZ11sFpzuAGiekJCZCJzmkap9BX+ypWFtWgfmaQlTlp39La9+CftUhuAgTjYUKo4xK
	CPuYAsHStrk0OU+buRO2kxQaFMl4d+b2cezy+c/mdK/qPq7HR68t097ex19sx3pzTO85MLXRUKJ
	+txHlCyPGP6Vv6XZQGyP0398S6LRCjnE3fWSdKAVo2K7Nc2KHmbQ3AcMkpf++DZ4FVLKgNSfJTh
	VBxzltVSCyA+fA2Je7hAIVxnL51+8E64Zp08eq3exDzvg81oZWAfOWy2I9WE4P1byvQxvdQerHg
	==
X-Received: by 2002:a05:6a20:9187:b0:3e2:3392:5408 with SMTP id adf61e73a8af0-4014e064cc4mr12887430637.79.1795467439535;
        Mon, 23 Nov 2026 12:57:19 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b27900sm6190452b3a.47.2026.11.23.12.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:57:19 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] bpf: Force BPF_JIT on x86-64 and arm64
Date: Mon, 23 Nov 2026 20:57:13 +0000
Message-ID: <20261123205713.4094553-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

An arm64 kernel with CONFIG_BPF_SYSCALL=y and CONFIG_BPF_JIT=n is open
to Spectre v1 if unprivileged BPF is enabled. The verifier adds
BPF_NOSPEC to such progs. The interpreter calls barrier_nospec() for it,
which is empty on arm64.

A real barrier doesn't make the interpreter safe, since it sits behind
an indirect branch:

  goto *jumptable[insn->code];

If the prog trains this branch, the CPU can skip the barrier and run the
next insn. arm64 has no retpoline. x86-64 turns it off when it picks
eIBRS or IBRS. The JITs emit the barrier inline.

Commit 8db2aca155a4 ("bpf: Force BPF_JIT_ALWAYS_ON on x86-64 and arm64")
kept the interpreter for CONFIG_BPF_JIT=n. Select BPF_JIT from
BPF_SYSCALL on these archs.

KMSAN kernels keep the interpreter. KMSAN doesn't see the stores of JITed
progs and reports a map key on the prog stack as uninit. syzbot runs
KMSAN with CONFIG_BPF_JIT=n.

Link: https://lore.kernel.org/bpf/20261117172341.3152407-1-ryan.roberts@arm.com/
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index d705d7b38b5f..307aa5a2b293 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -26,8 +26,8 @@ config HAVE_EBPF_JIT_KASAN
 config ARCH_WANT_DEFAULT_BPF_JIT
 	bool
 
-# Used by archs to tell that kernels that were compiled with BPF JIT support
-# have no BPF interpreter.
+# Used by archs to tell that kernels with the bpf() system call have the
+# BPF JIT compiler and no BPF interpreter.
 config ARCH_WANT_BPF_JIT_ALWAYS_ON
 	bool
 
@@ -36,6 +36,8 @@ menu "BPF subsystem"
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
+	# KMSAN doesn't see the stores of JITed progs and reports false errors.
+	select BPF_JIT if ARCH_WANT_BPF_JIT_ALWAYS_ON && !KMSAN
 	select IRQ_WORK
 	select NEED_TASKS_RCU
 	select TASKS_TRACE_RCU
-- 
2.55.0

