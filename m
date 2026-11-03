Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749310;
	b=CsBaZ1xj5zrimE/ZjEUBGQg3h1dZjvGpxv5YzZQw7V6UB7mJTRyHjZcgxzn4hFc2yP/q
	 nKODmFytj24Z0mV5OqOW/dnFjoCNYHWNEROuw0QV9xDc87wk+IDqQJIw8/7islxWs38t4
	 CutTKaZPMuHNdJkHyrb3An9AAyHcwdVVeY/E2Cd8gmr0WbjQQ+n567UTnpuj+vz4C29XY
	 Z1VQ5h6oaLBq7VhMkQ1knUmQqbTrvc9eMZSjBqDzaVfW6ecWtXeXiCIX1I9Kdv7TSTEoA
	 lf8JXBD1Sja+m7p6qBa/8/YgLRpZ8An1B4jAjbo20Dkw7DOac3jNRE4bmK8nDYnFm6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3E1g13XDoAecDocbkvJHQ9QmuNGVLptTMmbLjXJLoWs=;
	b=ly7A9M2qrcB/hIxhcaNilggbIw3Me3/6Nrc0zv5FWP+HDS7hKBBC/Jv/eT3oDLHKc1J5
	 3+KOe+4A6GE3F6brkEpV9O3XqgA8WZ5p+f9pL3z5GBsddwj0oIKF11fO352fISnL9iT9N
	 vRbINUqwg7i5wbT5bU7kZvfY8yPEPiVVeqiNHwPWQUCUzqD9XSbIhdHz68N/mM/S6pnsm
	 t40kyn9MiJ6UoRGmulRWm6NZPejpGYJH401qVZaNDNDA6+g9RqRfxD1RqMYf6b/mCKc3E
	 zgzM/JOqgGqlB53F2ifjslJBCwNILWPZM5zY5ZhUhh9Q4yaI2yA3qJutpcOQFqpp3dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKapkSwt;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE36606A330
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE36606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKapkSwt
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so78318a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749309; x=1794354109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3E1g13XDoAecDocbkvJHQ9QmuNGVLptTMmbLjXJLoWs=;
        b=wKapkSwtoTkoJZg6DZJTuxgRebUnvk+v+vDtvToSePB+CC2SQL9XudIHO8M3mWic6s
         BQ9m8ygE0E0rTYmLq64iLmadJ/AiZH6ZA29SamS0PxuP+milXLjbAJG9UKJg7MF6iY6a
         yUTw86oLgGZGmEx+v9pNlceHVaP/TpisHU1MlObIxm+8GjcqWKmok2hsoopaUSpa3Kyg
         YjMn+z0X7jg8TAeY3n46udKQKLOLqbtylk4fgN2HfJH0utcgoLdWonDCgH/OxzM9j/z6
         zJH8U7RpaTc/+rlse/V1RpsiJ+ZoCbHMjfl1t7I79oL85Of/vfAlnIqajSAobWcCR6gu
         /DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749309; x=1794354109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3E1g13XDoAecDocbkvJHQ9QmuNGVLptTMmbLjXJLoWs=;
        b=BaLX4nqbICxwpdeH37qo/zQg9RrHkFm2pNbFqDc6vkui+SDiQNjqK/RewMhT7fC5Yu
         e6DJnS0Xq8ALihp9fLZEN0kS3E3Hl9AE2zy+fa0hnzJjNJUO06PdY0EM3Wz9aoOB7Q0m
         ivHNGkfaUFH1pGiM9rNFrjeDNQrmzq7iExJbGEz7Sw+Rh3msz6povoInWY1297WzjyMc
         0H2gACCF3pknl1iNQxizJDBGMt25OrDFikCwiwo21mxvCc9z3JhuX/A+evS0I8pcmFEa
         v+bFLyLaaSTd8jzLVOQwAyffFAM48sU4hviMMSSf3nFkDVaSJoy3J0RJPQZsP2CCuODg
         U1lg==
X-Gm-Message-State: APuU4Z9htkrjD7r81JAhF+Q29bU5Cm1JaQKIKa28uW2QFx3qmwVbkFOj
	zoLoZweIykt9w2IP87NZXInobqTnOGJnA9OMZ44/WnbPRKDdSnQnCBTB5gXETw==
X-Gm-Gg: AYBFou0JuDtW3gHf5ViSNvBFBy9QQtcoegCSGXJ2j/3rYllv01qMXzqr+xXyZHWigpC
	YfkmXB/pIEVpb53kNOBoq8OX8cE7vYzhleYjYqjCX1L4Gc//8kpUyM8R6UpxWebju0UOZTGyUWD
	WNKi5/mT+jIToyOZgBBrj0X7KpUzYlDRXD/KuQhL4YMbhMagEZN+Iv4VocSuj36IJSuQpHJkf7q
	yLv07wFZ+XGZVbYIAP61h0aKuv9aMjROTtp6UUJv5pzmrN1vXbDYCBPnnePybu6uDO1E/lMUAzY
	brLkXwwgBjyBPfyDc9WQCzoBhw5M2y5g3rhDIxQ4/9WhUzgKjPQ2CwKoovL+6Jc9Zgw+oPR6+gV
	rmD6A+tfhKl93z2rYjsVFAca0Ta+wN0yYmUnooOlI9TeYPv7BrvUlhU11PKJlcLL/2rUOKR58i5
	H3Na54EwHmn/pzKSkN9vOOGkh2tue5jXr3rgrcHFLIc/7hd9P4OWLiQJYb9y0NQzRcbnl0QT6qz
	EvNP9iHXcdyrdiCMQ7/LxEPDCXkGIpBi3GjCL2ae5goOCjehJ4c5uRNPOW+qLQSABdusV3SiDPa
	Le0+9LGz8V2ZrFsLL5ooRs+qfqtXXen02kdj1VBgnWuswkKg5rWMyHDQkpCuRPC2g7+SUtSLDJv
	CLzGC1Z0bWs1KDw8rC2DO83m81J8n2bGtW8HSQa/wRrqzqGb5L0ReHMTKe12vsTpxFZuMPi8FNg
	==
X-Received: by 2002:a17:90b:4a11:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3ae896f8539mr11192005a91.18.1793749308482;
        Tue, 03 Nov 2026 15:41:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094d70a60sm491722a91.1.2026.11.03.15.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 07/37] selftests/bpf: Test static subprogs that don't take what BTF says
Date: Tue,  3 Nov 2026 23:40:32 +0000
Message-ID: <20261103234104.208239-8-alexei.starovoitov@gmail.com>
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

The compiler can pass more or fewer arguments to a static subprog than its
BTF prototype has parameters.

  test                             the subprog                   result
  -------------------------------  ----------------------------  ----------
  more_than_prototype              1 in BTF, loads the 6th       returns 7
  more_than_prototype_no_store     the same, the caller stores   reject
                                   nothing
  less_than_prototype              7 in BTF, reads r1-r5, the    returns 15
                                   caller stores nothing
  stack_arg_write_prototype_slots  the same, the caller stores   returns 15
                                   the 6th and the 7th
  r11_no_jit_support               a store through r11, the JIT  reject
                                   has no stack arguments
  global_more_than_prototype       global, 1 in BTF, loads the   reject
                                   6th
  tgt_prog_takes_6th               1 in BTF, loads the 6th,      refuse
                                   fentry attaches to it

more_than_prototype also examines the x86 code of the subprog. The subprog
passes no stack arguments to other functions. Thus the JIT must not move
rsp in it.

less_than_prototype has no insn that uses r11. It has a tail call, which a
prog with stack arguments cannot have. Thus it runs only with a JIT that
mixes tail calls and subprogs, also where that JIT has no stack arguments.

more_than_prototype and stack_arg_write_prototype_slots store through r11.
The interpreter has no stack arguments: they load only when the JIT is on.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_struct.c |   3 +
 .../bpf/progs/tracing_struct_int128_tgt.c     |   9 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  | 102 ++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index ab74ba077041..a08b480eca73 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -398,6 +398,9 @@ void test_tracing_struct(void)
 	if (test__start_subtest("tgt_prog_unreliable"))
 		test_tgt_prog_unreliable("unreliable_entry", "callee_unreliable",
 					 "unreliable BTF and stack arguments");
+	if (test__start_subtest("tgt_prog_takes_6th"))
+		test_tgt_prog_unreliable("unreliable_entry", "callee_takes_6th",
+					 "unreliable BTF and stack arguments");
 	if (test__start_subtest("tgt_prog_returns_pair"))
 		test_tgt_prog_unreliable("odd_exit", "callee_takes_r5",
 					 "with a >8 byte return value");
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
index 2e2ddd1b52df..6a8079fe809b 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
@@ -69,6 +69,12 @@ static __noinline __u64 callee_unreliable(__u64 *p, __u64 b, __u64 c, __u64 d,
 	return *p + b * 2 + c * 3 + d * 4 + e * 5 + f * 6;
 }
 
+/* BTF has 'a'. The code also takes the 6th argument, on the stack. */
+static __naked __noinline __used __u64 callee_takes_6th(__u64 a)
+{
+	asm volatile ("r0 = *(u64 *)(r11 + 8); r0 += r1; exit;");
+}
+
 /* BTF has 'a'. The code also takes r5. It returns in r0 and r2. */
 static __naked __noinline __used __int128 callee_takes_r5(__u64 a)
 {
@@ -77,7 +83,8 @@ static __naked __noinline __used __int128 callee_takes_r5(__u64 a)
 
 static __naked __noinline __u64 call_takes_more(void)
 {
-	asm volatile ("r1 = 7; r5 = 2; call callee_takes_r5; r0 += r2; exit;");
+	asm volatile ("r1 = 1; *(u64 *)(r11 - 8) = 6; call callee_takes_6th;"
+		      "r1 = r0; r5 = 2; call callee_takes_r5; r0 += r2; exit;");
 }
 
 #else
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index abf319cb8514..d1fd5a402565 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
 struct {
@@ -12,6 +13,40 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+/* BTF has what the source says. The compiler dropped the arguments that are not used. */
+static __naked __noinline __used
+long takes_5_says_7(long a, long b, long c, long d, long e, long f, long g)
+{
+	asm volatile ("r0 = r1; r0 += r2; r0 += r3; r0 += r4; r0 += r5; exit;" ::: __clobber_all);
+}
+
+#define CALL_TAKES_5_SAYS_7(stores) \
+	"r1 = 1; r2 = 2; r3 = 3; r4 = 4; r5 = 5;" stores "call takes_5_says_7; exit;"
+
+/* No insn uses r11: the JIT needs no stack arguments, and a tail call is allowed */
+SEC("tc")
+__description("stack_arg: static subprog takes less than its prototype says")
+__success __retval(15)
+__load_if_JITed()
+__arch_x86_64 __arch_arm64 __arch_riscv64 __arch_s390x __arch_loongarch
+__naked void less_than_prototype(void)
+{
+	asm volatile ("r2 = %[jmp_table] ll; r3 = 0; call %[bpf_tail_call];"
+		      CALL_TAKES_5_SAYS_7("")
+		      :: __imm_addr(jmp_table), __imm(bpf_tail_call) : __clobber_all);
+}
+
+#endif
+
 #if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
@@ -94,6 +129,52 @@ __naked void stack_arg_read_uninitialized(void)
 	);
 }
 
+/* BTF has 'a'. The code also takes the 6th argument. It passes none: rsp stays where it is. */
+static __naked __noinline __used long takes_6th_says_1(long a)
+{
+	asm volatile ("r0 = *(u64 *)(r11 + 8); r0 += r1; exit;" ::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: static subprog takes more than its prototype says")
+__success __retval(7)
+__load_if_JITed()
+__arch_x86_64
+__jited("func #1")
+__jited("...")
+__jited("	movq	%r9, %rax")
+__jited("	addq	%rdi, %rax")
+__jited("	leave")
+__arch_arm64 __arch_riscv64
+__naked void more_than_prototype(void)
+{
+	asm volatile ("r1 = 1; *(u64 *)(r11 - 8) = 6; call takes_6th_says_1; exit;"
+		      ::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: static subprog takes more than its prototype says, no store")
+__failure __msg("callee expects 6 args, stack arg1 is not initialized")
+__naked void more_than_prototype_no_store(void)
+{
+	asm volatile ("r1 = 1; call takes_6th_says_1; exit;" ::: __clobber_all);
+}
+
+/* BTF is the only source for a global subprog: it has no stack arguments. */
+__noinline __used long global_loads_6th(long a)
+{
+	asm volatile ("%0 = *(u64 *)(r11 + 8);" : "=r"(a));
+	return a;
+}
+
+SEC("tc")
+__description("stack_arg: global subprog loads the 6th argument")
+__failure __msg("invalid read from stack arg off 8 depth 0")
+__naked void global_more_than_prototype(void)
+{
+	asm volatile ("r1 = 1; call global_loads_6th; exit;" ::: __clobber_all);
+}
+
 SEC("tc")
 __description("stack_arg: gap at offset -8, only wrote -16")
 __failure
@@ -405,6 +486,16 @@ __naked void stack_arg_write_unused_slot(void)
 	);
 }
 
+SEC("tc")
+__description("stack_arg: write the slots of the prototype, the callee loads none")
+__success __retval(15)
+__load_if_JITed()
+__naked void stack_arg_write_prototype_slots(void)
+{
+	asm volatile (CALL_TAKES_5_SAYS_7("*(u64 *)(r11 - 8) = 6; *(u64 *)(r11 - 16) = 7;")
+		      ::: __clobber_all);
+}
+
 SEC("tc")
 __description("stack_arg: sequential calls reuse slots")
 __failure
@@ -669,6 +760,17 @@ __naked void stack_arg_precision_fallback(void)
 
 #else
 
+/* No BTF tells about this store. The insn is what JIT has to deal with. */
+SEC("tc")
+__description("stack_arg: r11 where JIT has no stack arguments")
+__failure __msg("JIT does not support stack arguments")
+__arch_s390x __arch_loongarch
+__naked void r11_no_jit_support(void)
+{
+	asm volatile (".8byte %[st_r11]; r0 = 0; exit;"
+		      :: __imm_insn(st_r11, BPF_ST_MEM(BPF_DW, 11, -8, 1)) : __clobber_all);
+}
+
 SEC("socket")
 __description("stack_arg is not supported by compiler or jit, use a dummy test")
 __skip("stack_arg is not supported by compiler or jit")
-- 
2.55.0

