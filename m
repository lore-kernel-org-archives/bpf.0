Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842916;
	b=Y5wVFVzFcc8Ml/6n5u0xAokejVD4A8cotDXihNv+2+PpNuJnJhLVhqVEVxgM0sJDAIhd
	 kuBQFLIc27HMUG8Usm2yj/37cmu/fU6bx+SNpK1lC7tKTqmYQqlrRi9EL/vVK25RNgtu9
	 WlSstHURc3rr5j4mxgd/tTc1uTb1EwzbxB8+/dpoFnNT6h1Jd66iB6gsZLO2uza6mQjeM
	 jzg/MJgyiNgexuxqYYzHx+CSbEaIs7k0a+yOJskQEvmrFsGZBBw2N2CsZQdXO9pnnctcq
	 DYDgDgODzvawdUHRRWUM4KOgY4rMEEOmHFw2YNUU9U9E1aotHATD/ued6pZhzLJZ7Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=27KF7Wy7RdsIIHwk4zVsW/CXu6CgufWdNwmBA8ngV1g=;
	b=qSZVjEVLsA/DNPInEmBZxtrnOGAJ4s4qtw172LXgy6aV3QLmDe1GzfDQoUWSFhiql81b
	 NUX7MUPgir15WMDya/X7QnDnc6XqHs0T8VVpmrh7vhZnthKEUk8nEckoAA7G/S7CqOm9X
	 PuEXq8Z6zxmWBO1JODkv/o2ttAdDOFO4tW6Ix6+vBYzrVl5kirl69nxFmLH7EzyfcwxQ7
	 kPHwnmxt/A0jr6reikBxrzqStVsnTtrpKQ7fZHIWH9YfNyt33G5kErwzrJnOC3KZrKZoy
	 EmGISUIpMNZBGFWu8JaovW4I8n2Snhobw2qgfn/jf0ewEUx94c6Yehnvf2NHOwxiYZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+LR2te0;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D406606A337
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D406606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+LR2te0
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so3085071a91.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842915; x=1795447715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27KF7Wy7RdsIIHwk4zVsW/CXu6CgufWdNwmBA8ngV1g=;
        b=H+LR2te0/T3VacmVZuha4+sFJUwlcJKVfNgM3MI0wJX7qoYwijkiO8+4ZmHXPEJGW6
         StG7F6LUe4VgE/nWKKtysJQoN6TS0mjnNvcxccbnrsoeQoIcynFtuI/cL1MrsHKpkRIB
         CCye+x/9kOlxQJ/kt/I02n4wTP/AbjU0QdRj4dP5ABE+m+lnV2dJAUkNAu+STgD1Cy89
         6Yi/YlXrdBrgQZPqxTnptoFxocbbmF12LY5R270oHcL+rJBmgpKxRUipYzGa+rLLxwQy
         uwkgUpgY/JsyqhzmJxmy96xJvNt4mMq1zOek9n0JO3qEd6BZOxFSTQrk0f+sGMob5IUo
         0mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842915; x=1795447715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=27KF7Wy7RdsIIHwk4zVsW/CXu6CgufWdNwmBA8ngV1g=;
        b=vzYXtcO408HbmfZA/6bu9QoTBJgskOeLvAfs/uji8M+2xeRH5ErULIkEv7KGr4iO93
         N8GfuWDkv7wVT1fMpa79nhiN9Zc3U+SrHfBkAc3gw37MIiOyAv9prA0MIiOQjAQFtJ8g
         jRe0UGN7NAhwUKVU1aPCtdti2B214q0u7Haq2wfmP+j4fcs/aECE1Kd71Kf1hBR7hj1t
         7cpyhGpw3cvCIPbwzm1+dT6TmkT+desd/b9Qktrp+NHbK/W3V1PHBv6RN8qHK7d3+Cgi
         wwfGJBOZYkMNJ7FLLndom75SMacyOy33ExC0o88WdrteJhetX7WRKTunOBhfs//kewg5
         5f3Q==
X-Gm-Message-State: APuU4Z8x3b9P7ZRiAp+dolWWlv8+/ddlw/DqtXLyITQNCKgM7n0uBAQK
	WguQR/OI6KUiqDD6yagjI5kuXru4LUkRlTngPu8oe1k0W4NeUbskFaXt5QgiXg==
X-Gm-Gg: AZFdTZeoPRcGMqxBxS+zIjm9P+g2Icj8bw8Wc0lETaaDupL53d098gVmWVRUQ1y/k/H
	V73igxYF6n5nIXcKzk2v8qwtZ4WtcWADtAhz8pEKw/aS4clsOUnii1pjUPT7scdjhjHSgdz6Fvm
	nFYNsyC31igAhd4Amn3Lzp80AF4rli5nG6iay01nOaG6D1tvb94Y4HejK3xpZyzM5qVJdtz4qZN
	sP0KSMsRYGQ5LpMZPxuNB7t/ILrtGV/sWD2/NawHudtlLRo/jkJw6iaIE/jeBeCfs5ePQfcSJBy
	CMGaMJfI9LkFMhLEd6M6uddKo9A94L7CKkQT86xShiJ/M+57TeH0hKBMe9s6hzPp32VtRG4eLsP
	ztpomPThA8kMj/fG0rYtGO/2oCBtpOYeCL0ESwINupmzsNCAnhsn6o4WhrG3lJXXBagiedLwhaX
	aa66Xqq/FpPmtfFmeCVke+P+pZ8lTc5r0bFExgKsBKcRDsXms6AMzam4qZSTwBjTh8C7hgxgICf
	4mBtGBWSMrp/h1aILf5Qq0j1yn/xxhQPwvj0vtIXg2pTiek40Cbz3Cc+LUvhVypjJd5/ZuWju8p
	jBJixK8oSZG6nrlOW+oFjvjbXfZeShU/8xED5qOBdL9mFM8Y+jVF3AQ08J0iMOBQlDjDoNt1HXR
	M6GPSEv3U/Xx7XtLjUs34JJ6kkeRZ3X+v819uMnXzPEqU5zVksJ9s89Ybrl7tY0IjFWiZo+pXDw
	==
X-Received: by 2002:a17:90b:2642:b0:3b0:9162:948e with SMTP id 98e67ed59e1d1-3b1b0ba0a60mr9584027a91.27.1794842914766;
        Mon, 16 Nov 2026 07:28:34 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb3d2d4sm17303896a91.7.2026.11.16.07.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:28:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 20/21] selftests/bpf: Test programs above the old limits
Date: Mon, 16 Nov 2026 15:26:25 +0000
Message-ID: <20261116152626.4032587-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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

100 maps, 1100 subprogs, calls in dead code, 1000 kptrs, far cleanup
pads, bpf_loop() with a dead callback. Unsafe twins must fail.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../bpf/progs/verifier_callx_dead_cb.c        |  60 +++++
 .../selftests/bpf/progs/verifier_no_limits.c  | 224 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_unwind.c     |  32 +++
 4 files changed, 320 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_dead_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_no_limits.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4d77b8fd4eab..57ff2578a991 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -39,6 +39,7 @@
 #include "verifier_call_large_imm.skel.h"
 #include "verifier_calls_in_a_row.skel.h"
 #include "verifier_callx.skel.h"
+#include "verifier_callx_dead_cb.skel.h"
 #include "verifier_callx_many.skel.h"
 #include "verifier_callx_rodata.skel.h"
 #include "verifier_cfg.skel.h"
@@ -110,6 +111,7 @@
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_bpf_fastcall.skel.h"
 #include "verifier_or_jmp32_k.skel.h"
+#include "verifier_no_limits.skel.h"
 #include "verifier_patch_list.skel.h"
 #include "verifier_percpu_addr.skel.h"
 #include "verifier_precision.skel.h"
@@ -248,6 +250,7 @@ void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
 void test_verifier_calls_in_a_row(void)       { RUN(verifier_calls_in_a_row); }
 void test_verifier_callx(void)                { RUN_JITED(verifier_callx); }
+void test_verifier_callx_dead_cb(void)        { RUN_JITED(verifier_callx_dead_cb); }
 void test_verifier_callx_many(void)           { RUN_JITED(verifier_callx_many); }
 void test_verifier_callx_rodata(void)         { RUN_JITED(verifier_callx_rodata); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
@@ -317,6 +320,7 @@ void test_verifier_mul(void)                  { RUN(verifier_mul); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
 void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
+void test_verifier_no_limits(void)            { RUN_JITED(verifier_no_limits); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
 /*
  * Run serially with bpf_jit_harden at 0: blinding changes the xlated insns that
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_dead_cb.c b/tools/testing/selftests/bpf/progs/verifier_callx_dead_cb.c
new file mode 100644
index 000000000000..a0873095566b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_dead_cb.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* libbpf appends all functions of the table to the prog, hence a file of its own. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#ifdef CAN_USE_CALLX
+
+__naked __noinline __used static int live_func(void)
+{
+	asm volatile ("r0 = 3; exit;");
+}
+
+__naked __noinline __used static int dead_cb(void)
+{
+	asm volatile ("r0 = 0; exit;");
+}
+
+/* The loop has no iterations. The callback is the last function and it is removed. */
+SEC("socket")
+__success __retval(3)
+__naked void loop_with_dead_callback(void)
+{
+	asm volatile (
+	".pushsection .rodata,\"a\",@progbits;"
+	".balign 8;"
+"funcs_%=:"
+	".quad live_func;"
+	".quad dead_cb;"
+	".type funcs_%=, @object;"
+	".size funcs_%=, .-funcs_%=;"
+	".popsection;"
+	"r6 = funcs_%= ll;"
+	"r1 = 0;"
+	"r2 = *(u64 *)(r6 + 8);"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r2 = *(u64 *)(r6 + 0);"
+	"callx r2;"
+	"exit;"
+	:
+	: __imm(bpf_loop)
+	: __clobber_all);
+}
+
+#else
+
+SEC("socket")
+__skip("callx needs arch JIT and compiler support")
+__success
+int dummy(void *ctx)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_no_limits.c b/tools/testing/selftests/bpf/progs/verifier_no_limits.c
new file mode 100644
index 000000000000..a38d75293238
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_no_limits.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Programs above the limits that the verifier used to have, and unsafe twins of them */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define REP10(M, p) M(p##0) M(p##1) M(p##2) M(p##3) M(p##4) M(p##5) M(p##6) M(p##7) M(p##8) M(p##9)
+#define REP100(M, p) REP10(M, p##0) REP10(M, p##1) REP10(M, p##2) REP10(M, p##3) REP10(M, p##4) \
+		     REP10(M, p##5) REP10(M, p##6) REP10(M, p##7) REP10(M, p##8) REP10(M, p##9)
+
+/* 100 maps */
+
+#define MAP(n) char map##n[8] SEC(".data.map" #n) = { 1 };
+#define MAP_READ(n) "r1 = map" #n " ll; r1 = *(u8 *)(r1 + 0); r0 += r1;"
+REP100(MAP, 1)
+
+SEC("?tc")
+__success __retval(100)
+__naked void maps_100(void)
+{
+	asm volatile ("r0 = 0;" REP100(MAP_READ, 1) "exit;" ::: __clobber_all);
+}
+
+SEC("?tc")
+__failure __msg("invalid access to map value, value_size=8 off=8 size=1")
+__naked void maps_100_bad(void)
+{
+	asm volatile ("r0 = 0;" REP100(MAP_READ, 1) "r1 = map199 ll; r0 = *(u8 *)(r1 + 8); exit;"
+		      ::: __clobber_all);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} jmp_table SEC(".maps");
+
+/* 1100 subprogs */
+
+#define REP1100(M) REP100(M, 10) REP100(M, 11) REP100(M, 12) REP100(M, 13) REP100(M, 14) \
+		   REP100(M, 15) REP100(M, 16) REP100(M, 17) REP100(M, 18) REP100(M, 19) \
+		   REP100(M, 20)
+#define FUNC(n) __naked __noinline __used static void func##n(void) \
+		{ asm volatile ("r0 = r1; r0 += 1; r2 = 0; exit;"); }
+#define FUNC_CALL(n) "r1 = r0; call func" #n ";"
+REP1100(FUNC)
+
+SEC("?tc")
+__success __retval(1100)
+__naked void subprogs_1100(void)
+{
+	asm volatile ("r0 = 0;" REP1100(FUNC_CALL) "exit;" ::: __clobber_all);
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+__naked void subprogs_1100_bad(void)
+{
+	asm volatile ("r0 = 0;" REP1100(FUNC_CALL) "r0 = *(u8 *)(r0 + 0); exit;" ::: __clobber_all);
+}
+
+/* Calls in dead code do not count. Only the main pass knows that (x & 7) > 7 is false. */
+
+#define DEAD_IF(limit)			\
+	"call %[bpf_get_prandom_u32];"	\
+	"r0 &= 7;"			\
+	"if r0 <= " #limit " goto 1f;"
+
+#define RECURSION(name, limit)					\
+__naked __noinline __used static void name##_func(void)	\
+{								\
+	asm volatile (						\
+	DEAD_IF(limit)						\
+	"call " #name "_func;"					\
+"1:	r0 = 0;"						\
+	"exit;"							\
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);		\
+}								\
+__naked void name(void)						\
+{								\
+	asm volatile ("call " #name "_func; exit;" ::: __clobber_all); \
+}
+
+void dead_recursion(void) SEC("?raw_tp") __success;
+RECURSION(dead_recursion, 7)
+
+void live_recursion(void) SEC("?raw_tp") __arch_x86_64 __arch_arm64
+__failure __msg("in a tracing program");
+RECURSION(live_recursion, 6)
+
+#define TAIL_CALL_IN_CB(name, limit)				\
+__naked __noinline __used static void name##_cb(void)		\
+{								\
+	asm volatile (						\
+	"r6 = *(u64 *)(r2 + 0);"				\
+	DEAD_IF(limit)						\
+	"r1 = r6;"						\
+	"r2 = %[jmp_table] ll;"					\
+	"r3 = 0;"						\
+	"call %[bpf_tail_call];"				\
+"1:	r0 = 1;"						\
+	"exit;"							\
+	:: __imm(bpf_get_prandom_u32), __imm(bpf_tail_call),	\
+	   __imm_addr(jmp_table) : __clobber_all);		\
+}								\
+__naked void name(void)						\
+{								\
+	asm volatile (						\
+	"*(u64 *)(r10 - 8) = r1;"				\
+	"r1 = 1;"						\
+	"r2 = " #name "_cb ll;"					\
+	"r3 = r10;"						\
+	"r3 += -8;"						\
+	"r4 = 0;"						\
+	"call %[bpf_loop];"					\
+	"exit;"							\
+	:: __imm(bpf_loop) : __clobber_all);			\
+}
+
+void dead_tail_call_in_cb(void) SEC("?tc") __success __retval(1);
+TAIL_CALL_IN_CB(dead_tail_call_in_cb, 7)
+
+void live_tail_call_in_cb(void) SEC("?tc") __failure __msg("tail call");
+TAIL_CALL_IN_CB(live_tail_call_in_cb, 6)
+
+/* Many edges to one insn: the dominators take linear time */
+SEC("?tc")
+__success __retval(0)
+__naked void goto_out_30000(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + 0);"
+	".rept 30000;"
+	"if r6 == 1 goto 1f;"
+	".endr;"
+"1:	r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* GCC loses the tag of 'struct task_struct __kptr *task[1000]' */
+struct one_kptr {
+	struct task_struct __kptr *p;
+};
+
+/* 1000 kptrs in a map value. The struct is too big for an allocated object. */
+
+struct many_kptrs {
+	long x;
+	struct task_struct __kptr *first;
+	struct one_kptr task[1000];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct many_kptrs);
+} kptr_map SEC(".maps");
+
+SEC("?tc")
+__success __retval(0)
+int kptrs_1000(void *ctx)
+{
+	struct many_kptrs *v = bpf_map_lookup_elem(&kptr_map, &(int){ 0 });
+	struct task_struct *t;
+
+	if (!v)
+		return 1;
+	t = bpf_kptr_xchg(&v->task[999].p, NULL);
+	if (t)
+		bpf_task_release(t);
+	return v->x;
+}
+
+SEC("?tc")
+__failure __msg("kptr access misaligned")
+int kptrs_1000_bad(void *ctx)
+{
+	struct many_kptrs *v = bpf_map_lookup_elem(&kptr_map, &(int){ 0 });
+
+	if (!v)
+		return 1;
+	*(volatile int *)((void *)&v->task[999].p + 4) = 1;
+	return 0;
+}
+
+SEC("?tc")
+__success __retval(1)
+int kptrs_1000_obj_new(void *ctx)
+{
+	struct many_kptrs *p = bpf_obj_new(typeof(*p));
+
+	if (!p)
+		return 1;
+	bpf_obj_drop(p);
+	return 0;
+}
+
+/* 500 kptrs in an allocated object */
+
+struct obj_kptrs {
+	struct task_struct __kptr *first;
+	struct one_kptr task[499];
+};
+
+SEC("?tc")
+__failure __msg("direct access to kptr is disallowed")
+int kptrs_500_obj_bad(void *ctx)
+{
+	struct obj_kptrs *p = bpf_obj_new(typeof(*p));
+
+	if (!p)
+		return 1;
+	*(volatile long *)&p->task[498].p = 1;
+	bpf_obj_drop(p);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/testing/selftests/bpf/progs/verifier_unwind.c
index 5a21345c34d4..596e5e0301e5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unwind.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
@@ -69,6 +69,38 @@ static unsigned long may_unwind(void)
 	);
 }
 
+/* The patches of the divisions push the pad out of the 16-bit range */
+#define FAR_PAD(name, sub)					\
+__naked void name(void)						\
+{								\
+	asm volatile (						\
+		"r6 = *(u32 *)(r1 + 0);"			\
+		"r1 = r6;"					\
+		"r1 -= " #sub ";"				\
+		"call may_unwind;"				\
+		unwind_goto(8202)				\
+		"r7 = 1;"					\
+		".rept 8200; r7 /= r6; .endr;"			\
+		"exit;"						\
+		"r0 += 100;"					\
+		"exit;"						\
+		:						\
+		: __imm_unwind_goto(8202)			\
+		: __clobber_all);				\
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__success __retval(7)
+__load_if_JITed()
+FAR_PAD(far_pad_returns, 64)
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__success __retval(105)
+__load_if_JITed()
+FAR_PAD(far_pad_unwinds, 0)
+
 /* owns nothing: its pad only carries on */
 __naked __noinline __used
 static unsigned long passes_on(void)
-- 
2.55.0

