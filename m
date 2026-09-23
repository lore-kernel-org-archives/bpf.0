Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2F59E349
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202985; cv=none; b=mTpo+PuOHGKcpzHBX5ACrbaG/dZ479ZzwE18IbqJxOgoTLb7glvVYdHeYtAQqxOkb9WPE3aETgZ+khKgBZInZitvvx0wQqT0dIcuMXEkRRBjxYZvAuDcMIu41zSelf7luVh5EkzBFdF4dEhYYAtx5hVmJgQR5ySD9mRMh0R+l7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202985; c=relaxed/simple;
	bh=urmtphIzt8lh360etwe3gEDMvtgUbtXcGq9iBFJ9M4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8pceYgeSS9E5brXOehqyPwj4zv/1QXaCe/Xcbtli6yoBDcSy0OjBk2lU3OzmSo1d/1lqQs0vqC+XvFUT81kMfn92wfEWeMnUS4YXNC1Nv0swG5quyO+f7MXKjXb321exjjvOjTLRcsGqY0shk5zOr0gr+BwOKO/woGU/ZmA83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6mb8hWm; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6mb8hWm"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso891023a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202981; x=1790807781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQzaQp0XuHktyR3UA4DWIV+Ohv6BhTFsk8mq7ueE+As=;
        b=l6mb8hWmfmRQfGsgSvU9D9dHUocPlkqGup5To0FwH8vykPN1qVwja4kN2+4NYmZs6+
         3Yju6v/08qLH6+Xr2B0a5PC883Ww6Ow8PM96tMT2RMjeNf5j+tSPhVVtXxhiNOkbkFu5
         1iTa0QLoJEeVUg0OQ/Y/LTMqZ0IHhyxfttLGrZfc9pvWOuD/+7FkoZXE0zu+/5CiyClx
         HKthZYJEk/4QktWqNaWK1bpDuSdyiYIzJIMnXo+gdxybzxG2ZEWwM0f89kEasn64Ccqx
         C5t4cg6R/lkz/wFijdXI3k8btCodQ0VGQaHKftKcVeZxeqx9oGnuZ+OXw2wUXXOTIa1D
         JqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202981; x=1790807781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gQzaQp0XuHktyR3UA4DWIV+Ohv6BhTFsk8mq7ueE+As=;
        b=dCsBuIesUwpyYwFrd9Bqj5pPPI07zVIqioWgHFe8tvlPdCqB+cAINq+6h43eOt0x3G
         ECZQTpLf/7BzPJ25aPjsKKGj5X+YX6+Dg0aLAkauw2mNu1ri2gj3vfWVju309dnXJhXu
         byExPVMy9olL7729kaz+xVk2gKKOoXlk3OwKQMVz4alX8gU3Ng0KjEHZozpcBZk6OEu/
         LarDSfUe70lzrHDKXgku9uT0pOt2C4X7I86JeWLDaG+jJyEKMzfqS8l/+E3BumlbFUYD
         edAS/8dXYr5IxhYQnkIwHGGHENkgTF9aJ2poehKno/0HhKPDz88o+7x/Tq8H7JQeN4+S
         6zkA==
X-Gm-Message-State: AFuF++lZZp8hCjdSz2JDG9hWHhdw9QP+Pw9v/9FuHZeDMCVD/KLFmDLv
	sGj6ngriHdivHP/XtbnkkOLlvE1p2VT/KPmWEMI1aclnBPj1xUZEk2q9Mjovdw==
X-Gm-Gg: AYBFou1l9QsN3X/+OeTVRKeJqZe6uVbvL6XYJBFis+HTX9puRhCb9G8zHuQt7uMLWJq
	6sDm5KXSdAggy+iL7y5KJILiFklp+DgUxUtc/dBtjJ+WNAErugmVg3MyHyZ0KquS91oVcn7fySU
	WOearB3jsX9JHbem/Bws19mAcZghZHKNyMQQNyKnZQq5vshxwcXfcVZHHqrJ4osusgg5lVtu/vr
	GORTX1bbjKt8ZBghLirHcowtfDk2hSRE37pDqBQnkP3zjupr/TpESB4aMZ6YSKN6bDcZHeIX5gG
	eg9C7HvExcgNMVT7qXAjSOe9reei4pKBfprMosAlAVKV7bETVjMbMFsWbvzl9hYXcHmVztD15K8
	j2UjDqOgtobLVnboFwfbOorQNtNvJWEEsE5i8FUBJyUYGCy3XbrU7laG1TSu5QdWVxHM6aDBnUx
	iuV/d9N1sbNaDo1S8CJO7YuKJJJs+HM5W/iRObElZ+lxG2UzDSvTwMbprCu8Hv2P1pF1jeAxsUL
	vfZ29jv6cjnl2c4mL8Yaenu1kn9WQPM5Tzdw5IzRshndtLqjxPQaH6DY1DvoFDte3EiXaKEuWej
	mWWsmbrGL4RbM281iNTtoJRu7ko9wBrX+dLtvW45ln8=
X-Received: by 2002:a17:90b:314e:b0:39e:6a81:5a90 with SMTP id 98e67ed59e1d1-3a098e37387mr377888a91.36.1790202980992;
        Wed, 23 Sep 2026 15:36:20 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773a515sm1104434a91.15.2026.09.23.15.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:20 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 8/8] selftests/bpf: Add tests for widened loops
Date: Wed, 23 Sep 2026 22:35:54 +0000
Message-ID: <20260923223554.562379-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Loops with the counter that steps by 1, 4, 8, up and down, with 64-bit
and 32-bit counter, nested, with too many iterations to walk every
one of them. The ones with the step other than 1 that leave the loop
on '!=' need range ends trimmed to var_off members.

Negative tests: the loop with one iteration too many, the counter that
never equals the bound, the access at the exit value of the counter.

spin_until_flag tests run the loop that never ends and check that
may_goto added by the verifier ends the program. loop_with_reference
cannot have may_goto and is walked every iteration.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_loop_widen.c | 344 ++++++++++++++++++
 2 files changed, 346 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_widen.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4f1e1c1cd5ab..5bed8f958777 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -65,6 +65,7 @@
 #include "verifier_live_stack.skel.h"
 #include "verifier_liveness_exp.skel.h"
 #include "verifier_load_acquire.skel.h"
+#include "verifier_loop_widen.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
@@ -234,6 +235,7 @@ void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
 void test_verifier_live_stack(void)           { RUN(verifier_live_stack); }
 void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_exp); }
+void test_verifier_loop_widen(void)           { RUN(verifier_loop_widen); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_widen.c b/tools/testing/selftests/bpf/progs/verifier_loop_widen.c
new file mode 100644
index 000000000000..4bdfc198bfaa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_widen.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Loops that are verified by widening the state at the loop head. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct small_val {
+	char buf[400];
+};
+
+struct big_val {
+	char buf[1000000];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct small_val);
+} map_small SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct big_val);
+} map_big SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+#define LOOKUP(map)					\
+	"r1 = 0;"					\
+	"*(u64*)(r10 - 8) = r1;"			\
+	"r2 = r10;"					\
+	"r2 += -8;"					\
+	"r1 = %[" #map "] ll;"				\
+	"call %[bpf_map_lookup_elem];"			\
+	"if r0 == 0 goto l_exit_%=;"			\
+	"r7 = r0;"
+
+/* counter steps by 4 and the loop is left on '!=', 100 trips */
+SEC("socket")
+__success
+__naked void stride4_ne_100(void)
+{
+	asm volatile (
+	LOOKUP(map_small)
+	"r6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+	"r6 += 4;"
+	"if r6 != 400 goto l_loop_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_small)
+	: __clobber_all);
+}
+
+/* same loop, 250000 trips, too many to walk every one of them */
+SEC("socket")
+__success
+__naked void stride4_ne_250k(void)
+{
+	asm volatile (
+	LOOKUP(map_big)
+	"r6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+	"r6 += 4;"
+	"if r6 != 1000000 goto l_loop_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_big)
+	: __clobber_all);
+}
+
+/* 8 byte stride, 32-bit counter */
+SEC("socket")
+__success
+__naked void stride8_ne_w_125k(void)
+{
+	asm volatile (
+	LOOKUP(map_big)
+	"w6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u64*)(r1 + 0);"
+	"w6 += 8;"
+	"if w6 != 1000000 goto l_loop_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_big)
+	: __clobber_all);
+}
+
+/* counts down by 4 to zero */
+SEC("socket")
+__success
+__naked void stride4_down_250k(void)
+{
+	asm volatile (
+	LOOKUP(map_big)
+	"r6 = 1000000;"
+"l_loop_%=:"
+	"r6 += -4;"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+	"if r6 != 0 goto l_loop_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_big)
+	: __clobber_all);
+}
+
+/* step of 1 and '<', no alignment to make use of */
+SEC("socket")
+__success
+__naked void stride1_lt_1m(void)
+{
+	asm volatile (
+	LOOKUP(map_big)
+	"r6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u8*)(r1 + 0);"
+	"r6 += 1;"
+	"if r6 < 1000000 goto l_loop_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_big)
+	: __clobber_all);
+}
+
+/* two loops, one in the other */
+SEC("socket")
+__success
+__naked void nested_stride4(void)
+{
+	asm volatile (
+	LOOKUP(map_big)
+	"r8 = 0;"
+"l_outer_%=:"
+	"r6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+	"r6 += 4;"
+	"if r6 != 1000000 goto l_loop_%=;"
+	"r8 += 1;"
+	"if r8 != 1000 goto l_outer_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_big)
+	: __clobber_all);
+}
+
+/* the last trip reads 4 bytes at offset 400 of 400 */
+SEC("socket")
+__failure __msg("invalid access to map value")
+__naked void stride4_ne_one_too_many(void)
+{
+	asm volatile (
+	LOOKUP(map_small)
+	"r6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+	"r6 += 4;"
+	"if r6 != 404 goto l_loop_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_small)
+	: __clobber_all);
+}
+
+/* same with too many trips to walk */
+SEC("socket")
+__failure __msg("BPF program is too large")
+__naked void stride4_ne_250k_one_too_many(void)
+{
+	asm volatile (
+	LOOKUP(map_big)
+	"r6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+	"r6 += 4;"
+	"if r6 != 1000004 goto l_loop_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_big)
+	: __clobber_all);
+}
+
+/* the counter never equals the bound and reads out of bounds */
+SEC("socket")
+__failure __msg("BPF program is too large")
+__naked void stride4_ne_misses_bound(void)
+{
+	asm volatile (
+	LOOKUP(map_big)
+	"r6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+	"r6 += 4;"
+	"if r6 != 999998 goto l_loop_%=;"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_big)
+	: __clobber_all);
+}
+
+/* the value read after the loop is at the exit value of the counter */
+SEC("socket")
+__failure __msg("BPF program is too large")
+__naked void stride4_ne_use_after_loop(void)
+{
+	asm volatile (
+	LOOKUP(map_big)
+	"r6 = 0;"
+"l_loop_%=:"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+	"r6 += 4;"
+	"if r6 != 1000000 goto l_loop_%=;"
+	"r1 = r7;"
+	"r1 += r6;"
+	"r0 = *(u32*)(r1 + 0);"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_big)
+	: __clobber_all);
+}
+
+/*
+ * Nothing in the loop changes what it tests. may_goto that the verifier
+ * adds to the back-edge ends the program: 0 is returned instead of 2.
+ */
+SEC("socket")
+__success __retval(0)
+__naked void spin_until_flag(void)
+{
+	asm volatile (
+	LOOKUP(map_small)
+"l_loop_%=:"
+	"r0 = *(u32*)(r7 + 0);"
+	"if r0 == 0 goto l_loop_%=;"
+	"r0 = 2;"
+	"exit;"
+"l_exit_%=:"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_small)
+	: __clobber_all);
+}
+
+/* same with the back-edge that is not a conditional jump */
+SEC("socket")
+__success __retval(0)
+__naked void spin_until_flag_ja(void)
+{
+	asm volatile (
+	LOOKUP(map_small)
+"l_loop_%=:"
+	"r0 = *(u32*)(r7 + 0);"
+	"if r0 != 0 goto l_done_%=;"
+	"goto l_loop_%=;"
+"l_done_%=:"
+	"r0 = 2;"
+	"exit;"
+"l_exit_%=:"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map_small)
+	: __clobber_all);
+}
+
+/* may_goto cannot end the program that holds a reference, every iteration is walked */
+SEC("socket")
+__success __retval(0)
+__naked void loop_with_reference(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto l_exit_%=;"
+	"r7 = r0;"
+	"r6 = 0;"
+"l_loop_%=:"
+	"r6 += 1;"
+	"if r6 != 100 goto l_loop_%=;"
+	"r1 = r7;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard), __imm_addr(ringbuf)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

