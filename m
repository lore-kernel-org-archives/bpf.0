Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749298;
	b=mgQzwOhLZIy8Q9b2B+M1cH8n6Ye3dwy3MoK4qrWXKI+L6z/BpwZexNUci5EH6onzHmww
	 iPsUIEFanRlSIH0dpqPGRqbN7QBfmrjAF/8YrfuW0ZvNcojH0lTRhZqpKmbPIMbnHjbLJ
	 go+Pac0JILJysalGHRYdOwr/7JzcyFVeywwH6XfPHOOYgPABgL3ZcjtCQ12ROm1F1GQe5
	 iULvoAtqL4vJXcWQyab/5oCSOktWOwteakIpT/1loSmUN51BF0btiiJ+ElG4MHvdJrMU2
	 g0PirtDuTXsEjBd0XBDIV22Fe5f+NSe/XWvKCmng6XwT4t/zbPEZnW3nXfll40jC9ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0RCaW/EaGePAjy6kmDzdtAnMLiVkitpp853anBrhjoc=;
	b=OTP7NjhlZm7l7AL2EiVf6pmvx0eKicudJhGat84fFduHzJpn+TAnPyt6bFlhNtxKZ0oc
	 6FbtIDGSUa9waAjqRcMOkMPLC2uekQEIyyqqkpAlWhK5NHW7lFOU4OhbpEUEQ5ZIn37fa
	 2btLJ4hiWODeTtvO8LvDXyaV7Q0ZJDZPtahNMyfhP44g/4m84oV3pT+ZuCc+ooaSHlyPs
	 j1b7QDtG60rw9KBEMVaOcNt9RdqE+LK8r9Rdriw2Yp7ziFBy4au7VxeE/3Crs8h+pISLN
	 tsOU10oBxeJlkRp/5a5jYZCk1ZEN3EldDJZmSmAAqjtUVX4cnj0bfRRr3Trq3wx1Myg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iiM3+0Oi;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6245606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6245606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iiM3+0Oi
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso89316a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749297; x=1794354097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RCaW/EaGePAjy6kmDzdtAnMLiVkitpp853anBrhjoc=;
        b=iiM3+0Oi/vZEOrV3hDE4wZ1kgFYM5yVuqHotJf/LTfNRlGS5upuPGHe+wT9AJWRqbR
         1NkdpwGZmmXDZ092985wlLu8ylVYpxn+cREP1Ms+r2EVG2MSymNLI+sMi7izYqScua5b
         60OiOYA82ft27iYEj0LDoqVoulDqCr/KYw2iXXNHvZV49vH+qLYdF1DyUWHHvpBRSOAJ
         7CyfAdLwPL64nmwUpi5edhhVwUT9+4B0p/hKJN3s9AZi8Wg21S/JEkYTXkMrbDSaJasr
         jiAln5dwbgbbxlF/14hF2nQCgPiefoVFvzOX/tDTogA48fs6USyVayvtFQAp41PvpYxu
         u33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749297; x=1794354097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RCaW/EaGePAjy6kmDzdtAnMLiVkitpp853anBrhjoc=;
        b=cC+cGqnsXJRXqxZ30Ik0UusvsP3c1revFhpQXrhUT2Ai5FbCPIYWZuapRkk6JKQdPg
         xhvWbjbPrKSDk7j6tlJ1Q4Zl6gyMlkQ7Sjb5MhdzfzeENLMT9nLWJfbgUFWBcPFRYMM5
         Bc8W2eiOiQAQipwFQObgXZp48siPu4hpqfkYMVBErBAB423f8ldCZfu20P9ToAl6DtXh
         U5ZVNSURMtdHgFGZiS0XtjQFFfLAnvz/Ug2AEha8Ycbb3zZ2GklDyKVErvCCj1zoi2ml
         pPjDGq3jiop5GTtEPakmj7TV7HRpl9d3swKjoXQ7VmvjjLbcxGcoBLU4UApeHJjptAdv
         QqYg==
X-Gm-Message-State: APuU4Z/7mtIUdfMonRf+74L2Tz5tS2TxB1rncmeSbT9OKCFyA3rBlDUN
	NuU/r/HPVnODi/sdtYxEWLDikj4cai4AE4lf/+xzkv+wIJNmj+6H4ThuLX200w==
X-Gm-Gg: AYBFou2BpUA+C3ZCdF1aWGxjSOCxfH5ZAQtpeGn+19AaCyIoz3BpK/AlulR3A+x7Zj8
	eWmPZfl2V/R/RCIfxYlLaMoDvxd5Bb5kPovrnH8bQUMD7CKfQi51JWuFcxB5yV/hdw9904ulxPv
	okElKPnYRfKcYysHlrcyJlObAjYJymUi+lN8boNbvYbPRhb5kYL4S2TO1Du98qsexzoibRNI0RT
	3roUGXLGGieBQUl4uJbzWaj/yoyguIzl4gBMcdTifDAnU8g23qjCutcbdo1+lk7wAjnAlVVc3Fe
	C93V0lvzANdyDpMMrgzj+n3YSV9r+9heiEii1yTeEPgZk+f4ehypYIUEqE5AYw/1iIapTupwlZM
	j82gMpmil8ryNeSjL6a6FpJoGRt4SkbX4UIyOD6gsQxixNalQrdhFuQg8rUy5WfqoWbEvDtcZq1
	uhmJ49z1vJxT9G62ACV0qIVn5qLYMkWlYPoTfMKAn9Jas7PtKe1zw1joWGifqZeF/Ong6tkg79F
	P872txBp0j1hMmK74105Pw5JDw2vY8eym1/1rD5GhfF6yukM94Ls58nhXyDP74ZV/wMw+C18oUS
	X15e3bfqOsRCym9/Yr7S1DcaZBz3tFkTDecDcbuuUlv3dlrsBA64DTJl3y8rnJ6KX+9ighFGTAU
	MJz4A3edbLUwIKFlwrrg/7Cl6WDWhP4qz4JfK/t07qKBFL04QM1bbIzgOmDKql+65M21bCGjMvA
	==
X-Received: by 2002:a17:90b:3d4b:b0:3ae:2969:903f with SMTP id 98e67ed59e1d1-3ae89771936mr12257689a91.45.1793749296800;
        Tue, 03 Nov 2026 15:41:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b095314e85sm848578a91.15.2026.11.03.15.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 05/37] selftests/bpf: Test trampolines on subprogs that take more than BTF says
Date: Tue,  3 Nov 2026 23:40:30 +0000
Message-ID: <20261103234104.208239-6-alexei.starovoitov@gmail.com>
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

callee_takes_r5() has one parameter in BTF. Its code also reads r5, and it
returns in r0 and r2.

  test                   attached  expected
  ---------------------  --------  ------------------------------------
  int128_tgt_prog        fentry    the subprog gets r5 of its caller
  tgt_prog_returns_pair  fexit     the verifier refuses to load the prog

The fentry prog reads r5 from its context. That loads only when the
trampoline has 5 u64 arguments. Then it clobbers r1-r5, so that the result
does not depend on what the kernel leaves in these registers.

test_tgt_prog_unreliable() gets the prog, the target and the message as
arguments, so that both refusals share it.

The two cases need no stack arguments. They still run only where the
compiler and the JIT have them, because they share that function and the
block of the static subprogs with the cases that need them.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_struct.c | 27 +++++++++++++------
 .../bpf/progs/tracing_struct_int128_tgt.c     | 15 ++++++++++-
 .../bpf/progs/tracing_struct_int128_tracer.c  |  6 ++++-
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index de358f335d98..ab74ba077041 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -198,6 +198,10 @@ static void test_int128_tgt_prog(void)
 							     "callee_split");
 		err = err ?: bpf_program__set_attach_target(tracer->progs.split_exit, fd,
 							     "callee_split");
+		/* The trampoline has to keep r5, which BTF doesn't have. */
+		bpf_program__set_autoload(tracer->progs.unreliable_entry, true);
+		err = err ?: bpf_program__set_attach_target(tracer->progs.unreliable_entry, fd,
+							     "callee_takes_r5");
 	} else {
 		bpf_program__set_autoload(tracer->progs.stack_entry, false);
 		bpf_program__set_autoload(tracer->progs.stack_exit, false);
@@ -239,6 +243,8 @@ static void test_int128_tgt_prog(void)
 		ASSERT_EQ(tracer->bss->split_i, 10, "split:i");
 		ASSERT_EQ(tgt->bss->ret_split, 246, "split ret");
 		ASSERT_EQ(tracer->bss->split_ret, 246, "split fexit ret");
+		ASSERT_EQ(tracer->bss->unreliable_r5, 2, "takes more:r5");
+		ASSERT_EQ(tgt->bss->ret_takes_more, 11, "takes more ret");
 	}
 
 out:
@@ -252,14 +258,15 @@ static void test_int128_tgt_prog(void)
 /*
  * A static function whose BTF is unreliable gets a trampoline that only knows
  * of the register arguments, so one taking stack arguments must be refused.
+ * It only knows of r0 too, so fexit to one returning in r0 and r2 must be refused.
  */
-static void test_tgt_prog_unreliable(void)
+static void test_tgt_prog_unreliable(const char *name, const char *func, const char *msg)
 {
 #if defined(__x86_64__) || defined(__aarch64__)
 	struct tracing_struct_int128_tracer *tracer = NULL;
 	struct tracing_struct_int128_tgt *tgt;
+	struct bpf_program *prog, *entry;
 	char log_buf[4096] = {};
-	struct bpf_program *prog;
 	int err, fd;
 
 	tgt = tracing_struct_int128_tgt__open_and_load();
@@ -277,16 +284,16 @@ static void test_tgt_prog_unreliable(void)
 
 	bpf_object__for_each_program(prog, tracer->obj)
 		bpf_program__set_autoload(prog, false);
-	bpf_program__set_autoload(tracer->progs.unreliable_entry, true);
-	bpf_program__set_log_buf(tracer->progs.unreliable_entry, log_buf, sizeof(log_buf));
-	err = bpf_program__set_attach_target(tracer->progs.unreliable_entry, fd,
-					     "callee_unreliable");
+	entry = bpf_object__find_program_by_name(tracer->obj, name);
+	bpf_program__set_autoload(entry, true);
+	bpf_program__set_log_buf(entry, log_buf, sizeof(log_buf));
+	err = bpf_program__set_attach_target(entry, fd, func);
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
 
 	err = tracing_struct_int128_tracer__load(tracer);
 	ASSERT_ERR(err, "tracer__load");
-	ASSERT_HAS_SUBSTR(log_buf, "unreliable BTF and stack arguments", "log");
+	ASSERT_HAS_SUBSTR(log_buf, msg, "log");
 
 out:
 	tracing_struct_int128_tracer__destroy(tracer);
@@ -389,7 +396,11 @@ void test_tracing_struct(void)
 	if (test__start_subtest("int128_tgt_prog"))
 		test_int128_tgt_prog();
 	if (test__start_subtest("tgt_prog_unreliable"))
-		test_tgt_prog_unreliable();
+		test_tgt_prog_unreliable("unreliable_entry", "callee_unreliable",
+					 "unreliable BTF and stack arguments");
+	if (test__start_subtest("tgt_prog_returns_pair"))
+		test_tgt_prog_unreliable("odd_exit", "callee_takes_r5",
+					 "with a >8 byte return value");
 	if (test__start_subtest("stack_arg_tailcall"))
 		test_stack_arg_tailcall();
 	if (test__start_subtest("union_args"))
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
index 2561422c25dd..2e2ddd1b52df 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
@@ -2,13 +2,14 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct int128_arg {
 	__int128 v;
 };
 
 __u64 base;
-__u64 ret_odd, ret_stack, ret_split, ret_unreliable;
+__u64 ret_odd, ret_stack, ret_split, ret_unreliable, ret_takes_more;
 
 #if defined(__clang__)
 
@@ -68,6 +69,17 @@ static __noinline __u64 callee_unreliable(__u64 *p, __u64 b, __u64 c, __u64 d,
 	return *p + b * 2 + c * 3 + d * 4 + e * 5 + f * 6;
 }
 
+/* BTF has 'a'. The code also takes r5. It returns in r0 and r2. */
+static __naked __noinline __used __int128 callee_takes_r5(__u64 a)
+{
+	asm volatile ("r0 = r1; r0 += r5; r2 = r5; exit;");
+}
+
+static __naked __noinline __u64 call_takes_more(void)
+{
+	asm volatile ("r1 = 7; r5 = 2; call callee_takes_r5; r0 += r2; exit;");
+}
+
 #else
 
 const volatile bool has_stack_arg = false;
@@ -93,6 +105,7 @@ int run(void *ctx)
 		ret_unreliable = callee_unreliable(&x, base + 2, base + 3,
 						   base + 4, base + 5, base + 6);
 	}
+	ret_takes_more = call_takes_more();
 #endif
 #endif
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
index fc81c2eea4a8..6a1d5ce0c171 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
@@ -67,10 +67,14 @@ int split_exit(unsigned long long *ctx)
 	return 0;
 }
 
-/* Refused: the trampoline would lose the stack argument. */
+long unreliable_r5;
+
+/* For static functions with unreliable BTF: the arguments are r1-r5. It clobbers them. */
 SEC("?fentry/callee_unreliable")
 int unreliable_entry(unsigned long long *ctx)
 {
+	unreliable_r5 = ctx[4];
+	asm volatile ("r1 = 0; r2 = 0; r3 = 0; r4 = 0; r5 = 0;" ::: "r1", "r2", "r3", "r4", "r5");
 	return 0;
 }
 
-- 
2.55.0

