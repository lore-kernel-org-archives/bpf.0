Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979606;
	b=fvS7Bo/6epMVs+xwggRgMKv47DuVEj017UhRbAxd8WtYOC+/WnKhnqe44yKXUpBos1uM
	 hVAAsKnosMDpmbo1zYIFVUeKQaLIqiKawzZ9H8+vxFH8IIWmUdJmz+E7wfY8hhwQ9wBdJ
	 6lZ97IXWwWPv2rLiOgODAzwAeFq5Wv6UuPTSEX4SrdluXD6iWaByzRmdc3Lv4DbepxMxG
	 fbbWJGZx0ipDUXW/N0CxqE+RXhCRG6zI2Ye28M6SnL6kf2f2hhDeEO8VEHoUbyYL/iJmT
	 N3E3Iw9cDNuIOw6+eK3NDk44aywXiymwnktBV/rXWCPrIcmARCEkZ13rNr9IeOyrYQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xjb1mAInVk1HzEdMNZJyI7Brud2BvIWrU6/hsR1V99o=;
	b=4P79NLcmK3DCgd7DyjiOznVhMV+bCpcgZbgFZSjROgwxO034WMRi2KdY9Ddk+t810aSy
	 RgPQRlpvlBbff9pjVcnXDvG4ZlLLYuo1o/bMbJCMJNl1mZLJDlFTNxN1eIJ7eCv/wQKzb
	 Q/ZxHSq7Ni0IieZKau7IQhUc85DuPTk0prK3xuVUVrl97KrrevJvOLB5Cp4RY97XNW2oU
	 do+V4BVY9WJtjx6MV3zowpBfBK6dsomjGxG/C3X98PKxlay4Fhdt1zOoA53xo3V5ncS71
	 GZPCWNVEgPrxVMWd+Y+rnHLVW7FGhmUl+zFEZr5iew6zBf3+Ya4bWJWQPoVFs2t2bJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYvu7PZA;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A7606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 01:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B88A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYvu7PZA
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e987a2ba0cso15637665ad.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 18:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792979605; x=1793584405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjb1mAInVk1HzEdMNZJyI7Brud2BvIWrU6/hsR1V99o=;
        b=KYvu7PZAowTmf2dOYvKPpMuRlxFdicgWp+ZkgZcvfFbs8OZHihEl43jKXfWvqsNBiP
         A9QVA561SdLihfyOOISiQ/IpAKb1Z+aSAQu0EFRi6DQFLfjqg/PW+6+C4FQNhYe1VYpN
         wScJ3VIUtompHzhbTiVN4C0RaZmHe1S3BwV9RzUrFEoTi3Ok3W8go6PKPg5cmxIZoHmn
         BytuQlZ/io8ccewH7GKzgaky7mRiE8rYg3NEMUHsHyu8YPEzhcFF9nS4ZK9enMsxjoyx
         HrXfJ+Z3E3l2jlOZv5O/T1k63mKp0WBxa/nQlZlWJRN2qL9sBkE1d6BB/p6iSf7iqQCe
         m/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979605; x=1793584405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjb1mAInVk1HzEdMNZJyI7Brud2BvIWrU6/hsR1V99o=;
        b=s2+AjscelRhrpmtcjIPJ71an9BHT+txMARxRI9mGe2/CwbLt239JWn5Wo5CnCZT+4n
         aG1lmFYmOwa6BT6hUOXM8RLqnBRro7Qqm0a1e6IZpIjuZbPv6tsQgxxM79vZbOVIAOa/
         JBVDZySgXMBeKeHbOAEik30dZpm6J9XUMNhLIz232g4kroYKfHzlzi9r4VBxcuksF7Cs
         98oev/KYKigxvlIXbG+WOo9SJEuc97U30Q5KfYbsiL9QvS3+/6crQ4c/wUfMjcPTSFGG
         JJ5xlIgKWMFCsVUfvkDvL3MsTF7kd30+gjLQpQ6S2OGui5iV0on3tn8Agr6Bvkig5oH+
         vgEQ==
X-Gm-Message-State: AFq9FYJLmGUDJ1Eccjqn1mz1Hkz0bs+b4zzyvYJzJNiskxoXkh/I+6sg
	eaPVjy3GF9NDtDt8QlXZ+tcVDtMgh6ZKss5OoQFqLpizB2PsLVAc58Nt
X-Gm-Gg: AYBFou3Sos3V29RHwHFwG0NJ3T3c5Pt4XyrlNOUnUAe6Fby20OvYaVzf5BFkWDwFtxk
	zBVFEyOOxA9IPXx8kG+I5PO1iUj6UFKmuuyXCFIVN++6Lj0sqxWA10Vs3u9rLR/Z0SRPdpZfNS/
	BqwG7m4Gw+dLxfyvFe2/bGed34cQqCb+rONiuByetoTq/842S1QeK8M5E6DdRvFkFjQqEsdKKF6
	9NiI4BaeojwFj8yP9T0SEnRPVKJomEPSPHrVGaYEbbWVvylnnntjUcc4eogB8ny2SyBqLCx8QKf
	m6mwI8OWRdKRrgVdDKMhipYeyH30rJQitPqTIGSLu/ocbc8sW5+o4PkwC2cpDjClsfOZPg9E0ba
	m0OuRgimGfdmuVuEInFYPpXI2DYttJMr0H0PLUkil61uLs5EYeekcyWZ1weYLsOM4WyG15atgFA
	8QLPWJRsErDUhFeL2A6V/dSaoY7D3bei5WnDBSqAi1oVqxYKinMKbPQYgMt5aDa2WMkfN8n6UWO
	Cb7z0eLDwc3lcRhwtAiO2ldtOCbgURgq7hsy6HHfHnhevloYJq4hNch90KWx+U6GkIxcdeO8FZM
	J44YFVTBQBHNZUQllg7VfSN8Rg2e
X-Received: by 2002:a17:903:1a2b:b0:2e5:6af9:a745 with SMTP id d9443c01a7336-2ea9c8194afmr46914005ad.23.1792979604989;
        Sun, 25 Oct 2026 18:53:24 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af3232bsm10137655ad.10.2026.10.25.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:53:23 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+eada64ce90ecebce@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test missing and callback stack arguments
Date: Sun, 25 Oct 2026 18:52:50 -0700
Message-ID: <20261026015250.1674676-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026015250.1674676-1-bestswngs@gmail.com>
References: <20261026015250.1674676-1-bestswngs@gmail.com>
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

Exercise the path where a static seven-argument subprogram has unreliable
BTF and is called through a bridge with only one initialized outgoing stack
argument. The callee expects two stack arguments, but the unreliable-BTF
path skips check_outgoing_stack_args(). Expect the verifier to reject the
second r11 load at offset 16.

Also exercise synchronous and asynchronous callbacks whose BTF prototypes
declare a sixth argument. Initialize the outgoing slot at each helper call
site so the programs reach the callback-specific rejection. Keep a valid
six-argument direct call in each program so bpf_fixup_call_args() records
the stack-argument requirement and cannot become an unrelated rejection
fallback.

The fix also rejects the existing uninitialized-stack-argument test before
the later unreadable-register check. Update that test's expected diagnostic
accordingly.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v3:
- Rebase onto the bpf tree at commit 00d2cdf1637e ("Merge branch
  'bpf-track-borrowed-iterator-result-lifetimes'").

Changes in v2:
- Add synchronous bpf_loop callback coverage.
- Add asynchronous bpf_timer callback coverage.
- Add the six-argument callback BTF prototype and initialize the outgoing
  stack slot so both tests reach the callback-specific rejection.

 .../bpf/progs/btf__verifier_stack_arg_order.c |  10 ++
 .../bpf/progs/verifier_stack_arg_order.c      | 121 +++++++++++++++++-
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
index a980a3a399d3fe..f4fb8f81afa777 100644
--- a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
@@ -26,6 +26,11 @@ void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, int f, int g)
 {
 }
 
+int callback_6args(long a, long b, long c, long d, long e, long f)
+{
+	return a + b + c + d + e + f;
+}
+
 #else
 
 int subprog_bad_order_6args(void)
@@ -47,4 +52,9 @@ void subprog_bad_ptr_7args(void)
 {
 }
 
+int callback_6args(void)
+{
+	return 0;
+}
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index ab195585223343..5bfcd300c7a09a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -5,6 +5,17 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+struct timer_value {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer_value);
+} timer_map SEC(".maps");
+
 #if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
@@ -130,6 +141,25 @@ static void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, int f, in
 	);
 }
 
+__noinline __used __naked
+static int callback_6args(long a, long b, long c, long d, long e, long f)
+{
+	asm volatile ("r0 = *(u64 *)(r11 + 8);"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__noinline __used __naked
+static void subprog_call_bad_ptr_7args(void)
+{
+	asm volatile ("*(u64 *)(r11 - 8) = 0;"
+		"call subprog_bad_ptr_7args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 SEC("tc")
 __description("stack_arg: read without caller write")
 __failure
@@ -152,7 +182,7 @@ __naked void stack_arg_read_without_write_1(void)
 SEC("tc")
 __description("stack_arg: read with not-initialized caller write")
 __failure
-__msg("R0 !read_ok")
+__msg("invalid read from uninitialized stack arg off 8")
 __btf_func_path("btf__verifier_stack_arg_order.bpf.o")
 __naked void stack_arg_read_without_write_2(void)
 {
@@ -171,6 +201,95 @@ __naked void stack_arg_read_without_write_2(void)
 	);
 }
 
+SEC("tc")
+__description("stack_arg: unreliable callee with too few stack args")
+__failure
+__msg("invalid read from uninitialized stack arg off 16")
+__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
+__naked void stack_arg_read_with_short_bridge_write(void)
+{
+	asm volatile ("r1 = 0;"
+		"r2 = 0;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"r5 = 0;"
+		"*(u64 *)(r11 - 8) = 0;"
+		"*(u64 *)(r11 - 16) = 0;"
+		"call subprog_bad_ptr_7args;"
+		"call subprog_call_bad_ptr_7args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: synchronous callback with stack args")
+__failure
+__msg("callback subprog cannot have stack args")
+__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
+__naked void stack_arg_sync_callback(void)
+{
+	asm volatile ("r6 = 0;"
+		"*(u64 *)(r11 - 8) = r6;"
+		"r1 = 1;"
+		"r2 = %[callback_6args];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"call callback_6args;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_ptr(callback_6args),
+		  __imm(bpf_loop)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("tc")
+__description("stack_arg: asynchronous callback with stack args")
+__failure
+__msg("callback subprog cannot have stack args")
+__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
+__naked void stack_arg_async_callback(void)
+{
+	asm volatile ("r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"r1 = %[timer_map] ll;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto l0_%=;"
+		"r6 = r0;"
+		"r7 = 0;"
+		"*(u64 *)(r11 - 8) = r7;"
+		"r1 = r6;"
+		"r2 = %[callback_6args];"
+		"call %[bpf_timer_set_callback];"
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"call callback_6args;"
+	"l0_%=: r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(timer_map),
+		  __imm_ptr(callback_6args),
+		  __imm(bpf_map_lookup_elem),
+		  __imm(bpf_timer_set_callback)
+		: __clobber_common, "r6", "r7"
+	);
+}
+
 #else
 
 SEC("socket")
-- 
2.56.0

