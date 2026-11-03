Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749333;
	b=FRN9ezN0VW28+b9658hnZNLLYwr9O1gEnmmNqJ5zlTyPacFJkRModRefKn4VYDL7x5NX
	 A+PGtFeIrp8/w209P2tcFTSPVPA26CCPpvPMirMy7BuPUebFa6K8saS1+Fc8SZvwDFFoP
	 PWE7bQX+W1PmWC0VZu3CtRDzIjkkrBIjs3yYl0ZmztCcepqqIHVBPQYJSqNzW8IRsPVAk
	 3cFmrVGoxB6LFXWy9stWGYk1YknigzZbkPrIGy+klETEQiUPO62zWfN5YvN9nwzgxB3og
	 0CESAsjCceO+pt7/l1HOJ62fVTe5psNHYEYDuK3qMw0yxY9aRE6NPsd7/q8iY3pPtvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HOWF1VGfJkUZrxL/o2DrHx8r84QWo5PJ6X8ahPt9owM=;
	b=kYMt2Gqfj01JGMWU0yhEK9RX8moZLCflf9SxlbQifE8gkYiFXKjz8avyNOpp3we6QFY8
	 gubH+Sq24Doh1YwIhXX9nt392yX00FOFwnv/T5szVy2XXKpYWPQJrsM2VpH4eY2hUW49M
	 zFueUtJoILMPivRGUhrmVSDXdarkDKrxzK9z+EfvxNL6ddeJRLqBlI1C8wjwqrtpSFqLN
	 ISkVckFU8//JoOs/OYWkw1LvXStomWvM3bn4J+HtUqcaWkKKnBnz1d7nJaiUnNYBimFa1
	 ge8EkPOB9UFb8mkSuSuKZwGHyn6sgV51/pnGTI3QuOtjtr3MpOkqb+9UFw2urpViBzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ft9S6Lc4;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17AE606A32F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17AE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ft9S6Lc4
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89f85edd210so76933b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749332; x=1794354132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOWF1VGfJkUZrxL/o2DrHx8r84QWo5PJ6X8ahPt9owM=;
        b=ft9S6Lc43XRI4Je5KhAGBQCVggfNLH6oHHWCXM41JZ06Gb/ChNQFitezgJnA4YqUjG
         HqWvKJ+Jsf9MhQxvnWO9XKMYgNkPf2/okbQKqLKCKpQgn7Ya6Nne3jokRZKot+6ouj74
         CoqA6i9HzrgLUk4IWVTJLldcMlj0XPCovfTUotiy0hfmP/Y2pRXm5HsLG+rX0ojG5XCO
         nU3DaSdI4ZtfDrH5lGM1ap15apUf5m096OOsY8c3B0vQqWGrRVLmAWO57Rm+w6EpcHOI
         XC2NpLmYP24s7mCbcMX6teVDoKCr+/i3GoFLrgYVPprm8TS2rkfOJ7SvpZqA9oXrF978
         OY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749332; x=1794354132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HOWF1VGfJkUZrxL/o2DrHx8r84QWo5PJ6X8ahPt9owM=;
        b=tU0hNU359VLYE7cAnyvU0s1eV+ewTHX+tQJlxUYvEkPZ8Ix3lgRgy74N+MOLHVwWW1
         17niHY7HDTnwv+xvKbd1gUs7GVWaqZj5UonpT+iUSlvyp5TKCsP+5zwAaWRuH2lCKI+0
         MXrb1BQAopJzFoT2iefuJCusaxucIV2NcwLndhk+UmA71ANPz/harEu+dRR/WbdjC/Kg
         0KCAMarRQY4JB/jLAsRu75LX+nn7fAG0ALmCmor1tL6PCOuB9t44kF0zW+rpQaNS4dxu
         mXpJVbvmmLd8b10jZ3ivzdvGcF2mu4CY+Z7HP7+3ArYiiP40i2lA1X2XL1b1pUGsUqBD
         FMEA==
X-Gm-Message-State: APuU4Z+0hqZE4s65gwen0qBJIO+rnXWU41WaNTs8bVwRL0q/rVe2yj5x
	gA/YXItyXQUYTEpBxaMy3kPTZa6w59t17WvXIzG/EeRe1KWZeyy+woFk5G+b3Q==
X-Gm-Gg: AYBFou2HfZjhWMc48ejLXNDDCoRnHp8XXMFaMGquzcSRxpeiW+7oSjMdSTiX2HkUMb3
	BSH0MbNjrlX/Z7rGxJNJMjeuMlw/ODkvs4rjo8Dr+9Xz6sNWnVMfqmSGy2kGwOyyp2uKE1WM5Gp
	fcmD1asA5wRulTuY3RVF9JDhLnHi+1vEGthFr2BctSIiW9A6CRR+/7Cm0480y3lmCJZYSeEuuWU
	QrGvwXoLcATdkgxo4zQqOvGKArVl7P2nU4/wh4L4rZTKH/PzqsbpTL9g2G3jYHTMNgZj0QKCTAN
	Mts6iGPpvm3pVQSvzpYQsaxB2ILT5DAS9C/4WB0m42HSmBn//tNZrOE0l8k+ahA5s382Chbgrav
	2Y0If7GD91UqXj0OqJHgBxeEj2j6F/ZhS9MCnKKCUuA1olOjRQb1nsAdYyiwZTPN2+XqI4mw4Mv
	fPHqPYLUW1SiWR0klU8u1BM6l0VRAvEt1bR/LamSQoIBJmeuqZGx7IZHaLCbQt7YXHphp3sKHNn
	1rh19m5QhmoKBU5bZyvMxURAHcEr4KBoH7KFD56ID81/CEYEOhQb19m5ttazErd6FunrNi5MOwU
	kqY9UkkVKx9nhYiUQabrHmHW0Z2B97oB9yjSqcAcQSuA3h6oh7tmzju+gVcLPeT/3tD7zAgNiMR
	wzJ2M9hpDT1NCSDHe/8IKoWiR7j/fqzEWuWpmT3+lrjlkiYwV7OXpfQQWGbsFmoMbKUlL7x+fXq
	czxa8Xy9S7vGuzOms6ILde
X-Received: by 2002:a05:6a00:a245:b0:89f:9ea6:1dd9 with SMTP id d2e1a72fcca58-8a9bddbda77mr11544244b3a.38.1793749332007;
        Tue, 03 Nov 2026 15:42:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b097fdf387sm167049b3a.5.2026.11.03.15.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 11/37] selftests/bpf: Test scalar evolution with a loop bound in .rodata
Date: Tue,  3 Nov 2026 23:40:36 +0000
Message-ID: <20261103234104.208239-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

The prog loads the bound of the loop in each iteration, as clang does for a
'const volatile' variable. A second jump limits the loop to 16 iterations.
 - The bound is 10 and in .rodata. It gives the count:

     loop header at 3, header_count is [0..10]

 - The bound is in .data. The prog and user space can write to this map,
   thus the bound must not count: the second jump does.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 682f22d5fe1f..f33e5b51f7e9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1528,6 +1528,34 @@ __naked void eval_expr_unallocated_stack_bound(void)
 "	::: __clobber_all);
 }
 
+const volatile __u32 rodata_bound = 10;
+volatile __u32 data_bound = 10;
+
+/*
+ * for (i = 0; i < bound; i++): the bound is loaded in each iteration. It gives the count when the
+ * map is read-only. If not, the second jump does.
+ */
+#define BOUND_IN_MAP_TEST(name, bound, count)					\
+SEC("socket")									\
+__success __retval(10) __log_level(2)						\
+__msg("loop header at 3, header_count is [0.." #count "]")			\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r6 = 0;"								\
+	"r7 = %[" #bound "] ll;"						\
+"1:	r6 += 1;"								\
+	"r1 = *(u32 *)(r7 + 0);"						\
+	"if r6 >= r1 goto 2f;"							\
+	"if r6 < 16 goto 1b;"							\
+"2:	r0 = r6;"								\
+	"exit;"									\
+	:: __imm_addr(bound) : __clobber_all);					\
+}
+
+BOUND_IN_MAP_TEST(bound_in_rodata, rodata_bound, 10)
+BOUND_IN_MAP_TEST(bound_in_data, data_bound, 16)
+
 SEC("xdp")
 __success
 __log_level(2)
-- 
2.55.0

