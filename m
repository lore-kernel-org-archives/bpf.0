Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127908;
	b=RQStcfK72dim1hKwG7lmAeTPMBdOHt0AXzickPhe5Xo1WiKHbZBKSEBLcHF1FRDpLBGr
	 iP9RMJjhqPqIaKa/3dNdpj05OXGHxMLWuyHkolPykeAZv1LdbYiuteIMt4nRRJ/fm7vQT
	 G/JQ6QE7mw5bS1rNTGh/Stir7oHkN0fdWB//yjlvGkb8u11bbKZT8w5IVICdBZbm/egp9
	 jT48N4QBjyI+Y5IHBuqu6KzQqBYHcmmQLWTr1uCnKSHym63ZDoMZmNRO6taBTZMxECvQ0
	 jvuHV7mw8YFRXwbApO0lxOzOwfCgvemzzGH0Cm6UXTU4M3rpt8jabY5Ep7vh8X/VDdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EF+co8JQJPRkhDw/kZagI7FEhfUNsm5toRJ6sjR203I=;
	b=xwDzoURp3Kffzt679fUDmf+fx/41wVepmfaj40QuR4NIA9GtVgJpGEmA0oPHGBratD2d
	 ru0Ypn44FiU3n2udtoJovYXpCapAf9HyK++zjRg9CWpXoxxLeBRc9duYCxDbJ8yhEK+gK
	 /9Ui6goVSF5hoGKqCIg7b/PcNlQKQQYbjdeV6CEXLDC7rfxG1cNkx4836ezSV4JZkDobA
	 dd66SfdRrWD8lRqYrg3Vhrh/edIg/YbmgOtEa6Ox3/IKTRwJvrN0j4mSDYjd4Kfe++d6y
	 7PECkPnuwPbnrn+4O1Odx24RGPOEbjQdTYNrGXSjLtT6/cC+W/tkXo6ia2eNX0J5lRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IncxEk/0";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46920606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46920606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IncxEk/0
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so114752a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127908; x=1793732708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF+co8JQJPRkhDw/kZagI7FEhfUNsm5toRJ6sjR203I=;
        b=IncxEk/063dq/wJCFU+taFbbcxKYDjjTJnBS28F4jleWGuZuk/sYafUEq/JmuoIHR/
         JFzZ7Qr5n1WZaO7LXPylB035sONPTXcvT/OxPXUnaghEYxQw8SwTos0eUMOpbBiYK+oz
         UeIbjIW/hyLhTLu9IyWB7o4F9oJNh/dvPpoC/QIadH0AFFRW/CzA2nB+oN0g1LlL/fpr
         dwlgB4rYKx7QKJAYNUs0NJKB7lkfgcNb+vGGSxtRaGoK/3jvJN6xOxPG0G0bRGFazlIc
         k95UK464LKwfBPRdNkFt0BZ87KG1+ZAe8fPPIKxcXB629HB29CKrarqv1uljwAYPOMhg
         gY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127908; x=1793732708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF+co8JQJPRkhDw/kZagI7FEhfUNsm5toRJ6sjR203I=;
        b=kHjOdOK2o5KMPtTbL+jbLZruSHUebzgKZlanjoUQKk4F29fJwAaErNuBr9ExEQ5/kH
         s8lkxkoWLuV7NxCjm9kAhI9AEnzQP/j5C27+6MSLbPrqf1Jw63Y8+JoKy35g9zbSJh5S
         TA+ENDry/5Epvf2yHDcVKuSltjWYo0KrHdwd8jSylI2e8NhZEWrUE0ZrFSoshriujLqZ
         otvxXappKqAACMe1BZ21VTAPzyk6+dbeNdgfNUMm8fGXJv/GPjorfqY4tQ+KRsPnQ2s4
         cuQpUOAfY2NBm9vk75RQCAvNzXVUfKbFmKGSexvVJd5wmuD5SJXuWyKoHk8cQA4ccwKY
         KT7w==
X-Gm-Message-State: AFq9FYK1KkVY5y35LtLiG6CuNWw9RcS9pp+iumdkFrxie+cZODaJlYJR
	wX0smU9S1alvLyuGk3jOHAqttt0GTwmoUvxPU2O+VQAFokAGgGv3DtwSHNso7A==
X-Gm-Gg: AYBFou09GjvvV45atFCG6CC/G2LyXw7RAX83xx2YKAzvk2LN/s0ry6L2ymgHBmOG8Xz
	/hg131a5Yffix6uGW9Ya2PKvJLuktc5Ev/JGWonYtgX27yT/ayAPNjhQh/pOLgZ+2f9hDkSq56x
	YWQyPXuEbrhBwGTiLQ9ksL4qGJB6c1ko+Qs05ODRqu/tPEFViy+zoc0GKPFuAk9zryu7OGbpJ4U
	eX0s3n40oXMEJj8hSi8uRBBDNggMtK8b6RN6JyRXVUlCRr1954whW7L4ApUYiIm+OmkkhkcejJx
	rV9KcV4498P4qgP84yugQtegTNgDsKx0K3vnoqJ8XIcl/8C/kYmORWf11VSHJjQQSxdmwwmGaEc
	QhIrRMXeDgtQ+6HEj0LsEKTsJof/Y6DrTJ6sjPH91jrUeHmQXMq2dufzQPQQq2ZAjX7f5dkR09c
	qqTe4oeaALUPBajTuaE5nMrIOND7e612G0D/9rSQYnif5N7ZZqgGIBqm6ecmIojDtyyG0uUPIH0
	J/MkGikmWsalpF8DIf0oKEW4NTv3ZV+0AQnmfp/b4EHFiylZZMlCw1xQMQD6uyx3s7BYTlrRLfu
	SnckUzyk375DVQdc1N93cKsBQRPS8sGYMVXQaSUF0maoJMfAY3v6Zmox1h7EiUm5QF3U/GliO+J
	0/Fy96Wf0K9/fSqgZLKFJz77cWAi6A//hC6pR0UAxJ8KgWS8MFWh9gqFZzE2IUIDP+r4dkCLa4l
	GTvbg7aN2lLmUuYZK/9H4=
X-Received: by 2002:a17:90b:5607:b0:3ac:6e91:3f14 with SMTP id 98e67ed59e1d1-3ae580a8368mr10522a91.22.1793127907372;
        Tue, 27 Oct 2026 12:05:07 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae578f1602sm117293a91.15.2026.10.27.12.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:05:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 19/19] selftests/bpf: Test stack arguments across may_goto
Date: Tue, 27 Oct 2026 19:03:14 +0000
Message-ID: <20261027190314.1440199-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

Each test passes arguments 6-8 on the stack. Thus it uses all the registers
in which the JITs of x86-64, arm64 and riscv64 pass stack arguments.

  may_goto                                     then
  -------------------------------------------  ---------------------------
  70000 iterations in the callee               the callee reads the args
  the time is up in the callee                 the callee reads the args
  70000 iterations in the caller, after the    the caller calls the callee
  writes of the args

70000 iterations have one look at the clock. Without the fix on x86-64 the
second test fails, and the first test fails with the hpet clocksource. The
third test passes there. The result depends on the registers that the C
code uses.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_stack_arg.c  | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index b9f799f6e405..15a12497e074 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -433,6 +433,125 @@ __naked void stack_arg_sequential_calls(void)
 	);
 }
 
+/*
+ * A JIT passes the first stack arguments in registers. may_goto is not a call: they must be
+ * the same after it, also when it looks at the clock. That is once in 65535 iterations.
+ */
+__naked __noinline __used
+static long loops_then_reads_8args(long a, long b, long c, long d, long e, long f, long g, long h)
+{
+	asm volatile (
+		"r1 = 0;"
+	"1:"
+		"may_goto 2f;"
+		"r1 += 1;"
+		"if r1 < 70000 goto 1b;"
+	"2:"
+		"r0 = *(u64 *)(r11 + 8);"
+		"r1 = *(u64 *)(r11 + 16);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 24);"
+		"r0 += r1;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("stack_arg: may_goto looks at the clock, then the callee reads its args")
+__success __retval(876)
+__naked void stack_arg_may_goto_in_callee(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"*(u64 *)(r11 - 24) = 800;"
+		"*(u64 *)(r11 - 16) = 70;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"call loops_then_reads_8args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static long spins_then_reads_8args(long a, long b, long c, long d, long e, long f, long g, long h)
+{
+	asm volatile (
+	"1:"
+		"may_goto 2f;"
+		"goto 1b;"
+	"2:"
+		"r0 = *(u64 *)(r11 + 8);"
+		"r1 = *(u64 *)(r11 + 16);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 24);"
+		"r0 += r1;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("stack_arg: the time of may_goto is up, then the callee reads its args")
+__success __retval(876)
+__naked void stack_arg_may_goto_timeout_in_callee(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"*(u64 *)(r11 - 24) = 800;"
+		"*(u64 *)(r11 - 16) = 70;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"call spins_then_reads_8args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static long reads_8args(long a, long b, long c, long d, long e, long f, long g, long h)
+{
+	asm volatile (
+		"r0 = *(u64 *)(r11 + 8);"
+		"r1 = *(u64 *)(r11 + 16);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 24);"
+		"r0 += r1;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("stack_arg: may_goto looks at the clock between the stores of the args and the call")
+__success __retval(876)
+__naked void stack_arg_may_goto_in_caller(void)
+{
+	asm volatile (
+		"*(u64 *)(r11 - 24) = 800;"
+		"*(u64 *)(r11 - 16) = 70;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"r6 = 0;"
+	"1:"
+		"may_goto 2f;"
+		"r6 += 1;"
+		"if r6 < 70000 goto 1b;"
+	"2:"
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"call reads_8args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 #else
 
 SEC("socket")
-- 
2.55.0

