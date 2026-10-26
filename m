Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984039;
	b=MrnibPe1s+G7YsFoEfheO4PL1ErTnPdTUN2OO8ASUm5b4/B+gfNNF39vQMNFj1/+i6UZ
	 anEZSfOqpMYZsAIhpXm0b/hddoF2PpdxNhWggpE3w9wqorHTit2/Ja6rRQv72YMQkX/RP
	 h4o4z/IbDVLpiBPWGe6DaMzI7H596XC+jjoXX/4DxE4S/whmVI2PwbMTVs+3B4zV2G3I4
	 aci+9hEV2l7K+qUs/+vL7mShCCgE0UWgXN82H1Hw+393V7CnZ/cucUBW4Rz7lm4gtsw2c
	 3n1fOCxtmDz3+a2aP4y6rlJ5BNCB6GKZfNVk3QF4/2FuNo4f7D+SV8+cDgmzttnKpbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N9FiXtIwaRNAuf3/hifoDK5fqky0Ekpo/u1QHv2IrvM=;
	b=CZfWPkr5BlCjGkSMfmCIpbgIIArMx3fNKRZV7i4RSCdR67cpsEKh+ZsdnACm9d8rq2f8
	 mMq90PjZg1HMh/9pEE66X42+Btf1ixc62sSKm8zUMVLBYlsvhaarU1wz6W3gg0hR1rC65
	 R5OWghcVWlQD6xktBkMxELpaBJe0lBtzMXz2fc7eTxRwArH0XkJGFlP0IUjl4LHb/jsVZ
	 xWE6TAXOKdRI3ZS2umBFQmcLdzi/FrvZ9MZKsH8jxnfcP+O4VODoP9cD9OpNvxnGbiMlo
	 hgm2FF6I7VTD9M3jk3BGeigVf+MomolsIqLaBMIX2Leq6OSnwiSchJ5x6pPEi3vgtHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZWE6W7bn;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7F606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A7F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZWE6W7bn
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ea138a3497so15812985ad.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984038; x=1793588838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9FiXtIwaRNAuf3/hifoDK5fqky0Ekpo/u1QHv2IrvM=;
        b=ZWE6W7bnx33TxIFfFLJFg2tn7r5obR+KXW4D0nt3x1vy2I0kVWTa0541YSUOsKCzhr
         tq1h5epojbdt/CyAeih8PNSVpwYk6YayGi1/WK+yoYrN1as15IBSKWDs0VtbgPX17QYl
         hR/mTIUwQLkPEAMJWzAY7aSWWP7l0yijPy3CcH1M8f1XSNYrrGiWXw52PnBKu8L8JsS1
         u0RNxqAQMKAlZ+Qu0HtPNlOMp9ZscuvL76MaLB5FDwVbLItzq9SmzIDHcOZFiNAwR899
         wmxswgJosbPCWVSkxPcKiWVuH2Xs6w/5G57lBS2xOHu9EKTBx0WDi8ozi2QSnTCi8d2G
         gxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984038; x=1793588838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9FiXtIwaRNAuf3/hifoDK5fqky0Ekpo/u1QHv2IrvM=;
        b=CQHMd8Hh7UjmH+p39aIRwbEPQCBHSb5GXPqC6D6n/zyYCRRx1/vH4wM2OSh4xriwr4
         Tbc28LFBHFGQuLxkM8bq6lYJMJfp1i37Nk+rtKH9Jlgtt++4J/fkoP+zl5QxFZAvY5Y6
         kEUy9WHtquYIky2DBTMQULrLm61AbIqVwj9wO6LZdKr1LjC6HvgH2+QYzU5gVgcUJjLi
         u7NP3PUM+aMb6fwAPbcBfR0Q5aDFUkz18G6zsLGdcuDSyJtIaJIr5+rzDM29+r2RU6cX
         Zhhdh4+6WtehEPyy2W3OTklKEHkBDcpds7R0GTf2HwnFHy3UJJN1zoTAq2KDzdDk4hK9
         QUQw==
X-Gm-Message-State: AFq9FYLDvr93Y8OL0vxWcsfPKwdzOXT8u6MjrNBWAP7r1QgmErE23VTG
	x5gLAEi2z4NFw9h/dWj7akEyt7CWWl7R+tU0i38O6hRWjA+Q0keBGWj6qDNg3A==
X-Gm-Gg: AYBFou1qJWpA98Wheu1a7djk9nvtZZomcPX9xSJGG25ZGWlrsBcSX2fg/dyfB26Wbkj
	6TiY56cuMna/9bFS/GokK33Tc27ZOTRv3A3Mds/3CVWnOC9cfgC5I9urf6MtvhCBy5LQUktd03h
	4wvWIic/TuGUkAWaDsiQeo1rNvvk6aooebhwnlsjnvaldKPbkefDwEF0yoLaOax5ePHdQ+C9q3O
	3cy7ErhQNKZZte5v/4Hd0BYnk4tLwNsFO2xD+a5nCUquMH50kHwJgdeVEj4UY4Luptb5d1FhLLG
	5Gjn2cA05vCcAulWJ9YngcvNLoRRWAxu6ACYeUaBzZ4zGHAe8JVnh9/8iSONi/8ilXs7R5qOJVA
	U9LQarTbPrcHB0WOxFTzcAHlq+802yEh5w2QVLyCR4n/sNUBBmDaJ/gQkEH/WbYjm1jz4LkynIL
	gTr4H0zp8LNeHiPH3LO+OS2q7ebxgWfshMMJVPpKMIYcM4Qzl2+AapOr39xAmp3DnlB8DnjFxdl
	D0Y81SOmOjxEeB+Q+DL3eSHqQM6+1MCQGRBCK3kjPYKAadSocguAup2s5qQWJ+0/8pvuDl480XO
	eMNyHHbocQMcK1VzVG7BJBsziejV8Ux6YXqnpP7kPA05gYroNOHItT2nd83z3NdkdDJmAs+hj9b
	m6tbyWTglkamlDhrmlEror+go
X-Received: by 2002:a17:902:c946:b0:2e9:5507:b538 with SMTP id d9443c01a7336-2ea9c0c610bmr51854225ad.3.1792984037615;
        Sun, 25 Oct 2026 20:07:17 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af32085sm10481135ad.2.2026.10.25.20.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:07:17 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 77/81] selftests/bpf: Test states that are not joined
Date: Mon, 26 Oct 2026 02:59:38 +0000
Message-ID: <20261026025943.404450-78-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

Where two paths of a prog meet, the verifier joins their states into one
state that covers both. For example, ret = -2 and ret = 0 give
ret = [-2, 0]. Then the verifier verifies the subsequent code one time. But
a join loses the relation between registers, and progs depend on such
relations:

  ret = lookup(&p);      /* ret = -ENOENT and p is not set, or */
  if (ret < 0)           /* ret = 0 and p is set               */
          goto drop;
  use(p);

When the compiler inlines lookup(), the two states meet before the jump.
Their join gets to use(p) without p. Thus the verifier keeps both states,
and verifies each of them, when the prog can depend on the difference.

  the two states differ in             example                    result
  -----------------------------------  -------------------------  ---------
  a register that only one state       p is set, p is not set     both stay
  initializes
  a scalar that a later jump compares  ret = -2, ret = 0          both stay
  with a constant, the ranges leave
  a gap
  such a scalar, the ranges touch      ret = -1, ret = 0          joined
  two such scalars                     err = 1 and ret = 1,       both stay
                                       err = 0 and ret = 0
  a constant that becomes an offset    off = 0, off = 8           both stay
  in the stack

The join of two ranges with a gap has values that neither state has. A
later jump can send these values to code that neither state gets to. The
join of the two pairs has err = 1 with ret = 0, which never occurs. Ranges
that touch have no such values. But their join loses what ret says about
other registers:

  ret = idx < 8 ? 0 : -1;
  if (ret < 0)
          goto drop;
  use(buf[idx]);         /* rejected, the range of idx is lost */

A verifier that follows each path accepts this prog. With -EINVAL in place
of -1 it loads.

verifier_jumps_ahead.c has the first four rows, with patterns from Cilium.
verifier_var_off.c has the last row, with patterns from sched-ext
schedulers. The progs load only if both states stay. The verifier must
reject the unsafe variants.

The last row applies around a loop too. A prog that pushes to and pops from
'u8 stack[10]' gets one state for each value of the index. The compiler
tests a copy of the index and calculates the index again for the access.
When the index is a constant, the verifier knows the result of both. When
it is a range, the test of the copy says nothing about the index.

States that stay multiply: 20 flags give 2^20 combinations. Thus the rules
apply only while less than half of each limit on the number of states is
used. After that the verifier joins the states. Progs with 2^20
combinations must load.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_jumps_ahead.c          | 864 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_var_off.c    | 554 +++++++++++
 3 files changed, 1420 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 089d8ea3f651..78bce26662c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -65,6 +65,7 @@
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
+#include "verifier_jumps_ahead.skel.h"
 #include "verifier_kfunc_packet_access.skel.h"
 #include "verifier_kfunc_uninit.skel.h"
 #include "verifier_kfunc_uninit_multi.skel.h"
@@ -258,6 +259,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
+void test_verifier_jumps_ahead(void)          { RUN(verifier_jumps_ahead); }
 void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
 void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
 void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_uninit_multi); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c b/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
new file mode 100644
index 000000000000..a862f46fb3de
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
@@ -0,0 +1,864 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * A join must not make up what neither state has where a jump ahead can see it:
+ *	ret = lookup(&p);
+ *	if (ret < 0)
+ *		goto drop;
+ *	use(p);
+ * When lookup() is inlined (ret = -ENOENT, p is not set) and (ret = 0, p is set) meet in front of
+ * the jump.
+ */
+
+SEC("socket")
+__description("jumps ahead: a register is set when ret is 0")
+__success __retval(0)
+__naked void ret_and_register(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w6 = -2;"
+		"if r0 == 0 goto 1f;"
+		"r8 = 0;"
+		"w6 = 0;"
+	"1:"
+		"w7 = 0;"
+		"if w6 s< 0 goto 2f;"
+		"r0 = r8;"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("jumps ahead: a register is not set and ret doesn't tell")
+__failure __msg("R8 !read_ok")
+__naked void ret_does_not_tell(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w6 = 1;"
+		"if r0 == 0 goto 1f;"
+		"r8 = 0;"
+		"w6 = 0;"
+	"1:"
+		"w7 = 0;"
+		"if w6 s< 0 goto 2f;"
+		"r0 = r8;"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/*
+ * As in bpf_host.o of cilium:
+ *	err = helper();
+ *	ret = err < 0 ? -155 : 0;
+ *	if (err < 0)
+ *		goto out;
+ *	...
+ * out:
+ *	if (ret < 0)
+ *		goto drop;
+ * The states differ in what two jumps look at, and in nothing else.
+ * (err < 0, ret = 0) is neither of them.
+ */
+SEC("socket")
+__description("jumps ahead: two numbers that go together")
+__success
+__naked void two_numbers(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w6 = 0;"
+		"if w0 s> -1 goto 1f;"
+		"w6 = -155;"
+	"1:"
+		"w7 = 0;"
+		"if w0 s< 0 goto 2f;"
+		"r0 = 0;"
+		"exit;"
+	"2:"
+		"if w6 s< 0 goto 3f;"
+		"r0 = r8;"
+	"3:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/* -134 and -135 go the same way */
+SEC("socket")
+__description("jumps ahead: states that go the same way are joined")
+__success __log_level(2)
+__msg("from 4 to 7: joined")
+__msg("7: R6=scalar({{.*}}smin32=-135,smax32=-134{{.*}}) R10=fp0")
+__msg("from 6 to 7: R6=0 R8=0 R10=fp0")
+__naked void same_way(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w6 = -134;"
+		"if r0 == 1 goto 1f;"
+		"w6 = -135;"
+		"if r0 == 2 goto 1f;"
+		"r8 = 0;"
+		"w6 = 0;"
+	"1:"
+		"w7 = 0;"
+		"if w6 s< 0 goto 2f;"
+		"r0 = r8;"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/*
+ * As in bpf_lxc.o of cilium. -134 and -160 go the same way at both jumps, [-160, -134] does not
+ * at the second one.
+ */
+SEC("socket")
+__description("jumps ahead: the join goes where neither state goes")
+__success __retval(0)
+__naked void two_jumps(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w6 = -134;"
+		"if r0 == 1 goto 1f;"
+		"w6 = -160;"
+		"if r0 == 2 goto 1f;"
+		"r8 = 0;"
+		"w6 = -158;"
+		"if r0 == 3 goto 1f;"
+		"w6 = 0;"
+	"1:"
+		"w7 = 0;"
+		"if w6 s> -1 goto 3f;"
+		"if w6 != -158 goto 2f;"
+	"3:"
+		"r0 = r8;"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/* What a helper returned is looked at twice. These are ranges, not constants. */
+SEC("socket")
+__description("jumps ahead: ranges on both sides of the jump")
+__success
+__naked void ranges(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if w0 s< 0 goto 1f;"
+		"r8 = 0;"
+	"1:"
+		"w7 = 0;"
+		"if w0 s< 0 goto 2f;"
+		"r0 = r8;"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/* The jump is decided in one state only. The other one goes both ways, with r8. */
+SEC("socket")
+__description("jumps ahead: decided in one of the states")
+__success
+__naked void decided_in_one(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w6 = 0;"
+		"if r0 == 0 goto 1f;"
+		"call %[bpf_get_prandom_u32];"
+		"w6 = w0;"
+		"r8 = 0;"
+	"1:"
+		"w7 = 0;"
+		"if w6 s> -1 goto 2f;"
+		"r0 = r8;"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("jumps ahead: ret is in the stack where the states meet")
+__success __retval(0)
+__naked void ret_is_spilled(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w6 = -2;"
+		"*(u32 *)(r10 - 8) = r6;"
+		"if r0 == 0 goto 1f;"
+		"r8 = 0;"
+		"w6 = 0;"
+		"*(u32 *)(r10 - 8) = r6;"
+	"1:"
+		"w7 = 0;"
+		"r1 = *(u32 *)(r10 - 8);"
+		"w2 = w1;"
+		"if w2 s< 0 goto 2f;"
+		"r0 = r8;"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/* They go different ways, and that is all. One state does for both. */
+SEC("socket")
+__description("jumps ahead: states that differ in nothing else are joined")
+__success __log_level(2)
+__msg("4: R6=scalar({{.*}}smax=umax=smax32=umax32=1,{{.*}}) R10=fp0")
+__msg("processed 10 insns")
+__naked void nothing_else(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w6 = 1;"
+		"if r0 == 0 goto 1f;"
+		"w6 = 0;"
+	"1:"
+		"w7 = 0;"
+		"if w6 == 0 goto 2f;"
+		"r0 = 1;"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/*
+ *	ret = idx < 8 ? 0 : -EINVAL;
+ *	if (ret < 0)
+ *		goto drop;
+ *	use(buf[idx]);
+ * 0 and -EINVAL leave a gap, so the states are not joined, and idx keeps its range.
+ */
+SEC("socket")
+__description("jumps ahead: ret vouches for the range of another number")
+__success
+__naked void ret_and_range(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"call %[bpf_get_prandom_u32];"
+		"r7 = r0;"
+		"w6 = 0;"
+		"if r7 < 8 goto 1f;"
+		"w6 = -22;"
+	"1:"
+		"w8 = 0;"
+		"if w6 s< 0 goto 2f;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r1 += r7;"
+		"r0 = *(u8 *)(r1 + 0);"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/*
+ * 16 flags, each goes together with a number, all are looked at later: 2^16 ways.
+ * There is a limit to what is kept apart.
+ */
+#define FLAG(flag, num)					\
+		"call %[bpf_get_prandom_u32];"		\
+		"r1 = 0;"				\
+		"r2 = 0;"				\
+		"if r0 == 0 goto +2;"			\
+		"r1 = 1;"				\
+		"r2 = 2;"				\
+		"*(u64 *)(r10 - " #flag ") = r1;"	\
+		"*(u64 *)(r10 - " #num ") = r2;"
+#define LOOK(flag, num)					\
+		"r1 = *(u64 *)(r10 - " #flag ");"	\
+		"r2 = *(u64 *)(r10 - " #num ");"	\
+		"if r1 == 0 goto +1;"			\
+		"r6 += r2;"
+
+SEC("socket")
+__description("jumps ahead: 16 flags")
+__success
+__naked void many_flags(void)
+{
+	asm volatile (
+		"r6 = 0;"
+		FLAG(8, 16) FLAG(24, 32) FLAG(40, 48) FLAG(56, 64)
+		FLAG(72, 80) FLAG(88, 96) FLAG(104, 112) FLAG(120, 128)
+		FLAG(136, 144) FLAG(152, 160) FLAG(168, 176) FLAG(184, 192)
+		FLAG(200, 208) FLAG(216, 224) FLAG(232, 240) FLAG(248, 256)
+		LOOK(8, 16) LOOK(24, 32) LOOK(40, 48) LOOK(56, 64)
+		LOOK(72, 80) LOOK(88, 96) LOOK(104, 112) LOOK(120, 128)
+		LOOK(136, 144) LOOK(152, 160) LOOK(168, 176) LOOK(184, 192)
+		LOOK(200, 208) LOOK(216, 224) LOOK(232, 240) LOOK(248, 256)
+		"r0 = r6;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/*
+ * -2 and 1 are not joined: [-2, 1] has 0, which gets through both jumps, and r8 is set
+ * only in the state that really has 0.
+ */
+SEC("socket")
+__description("jumps ahead: less, greater, or use it")
+__success
+__naked void three_ways(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = -2;"
+	"if r0 == 1 goto 1f;"
+	"r6 = 1;"
+	"if r0 == 2 goto 1f;"
+	"r8 = 0;"
+	"r6 = 0;"
+"1:"
+	"if r6 s< 0 goto 2f;"
+	"if r6 s> 0 goto 2f;"
+	"r0 = r8;"
+	"exit;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+SEC("socket")
+__description("jumps ahead: not 0, or use it")
+__success
+__naked void not_zero(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = -2;"
+	"if r0 == 1 goto 1f;"
+	"r6 = 1;"
+	"if r0 == 2 goto 1f;"
+	"r8 = 0;"
+	"r6 = 0;"
+"1:"
+	"if r6 != 0 goto 2f;"
+	"r0 = r8;"
+	"exit;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/* ret = -1 and ret = 0 touch. What -1 says about idx is lost. Test idx where it is used. */
+SEC("socket")
+__description("jumps ahead: numbers that touch are joined")
+__failure __msg("math between fp pointer and register with unbounded min value is not allowed")
+__naked void ret_and_range_touch(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"call %[bpf_get_prandom_u32];"
+		"r7 = r0;"
+		"r6 = 0;"
+		"if r7 < 8 goto 1f;"
+		"r6 = -1;"
+	"1:"
+		"w8 = 0;"
+		"if r6 s< 0 goto 2f;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r1 += r7;"
+		"r0 = *(u8 *)(r1 + 0);"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/*
+ * A register that is set in one state and not in the other: these states are not joined,
+ * whatever it is that tells them apart later.
+ */
+#define ADD8 "r0 += 1; r0 += 1; r0 += 1; r0 += 1; r0 += 1; r0 += 1; r0 += 1; r0 += 1;"
+#define ADD64 ADD8 ADD8 ADD8 ADD8 ADD8 ADD8 ADD8 ADD8
+
+SEC("socket")
+__description("set or not: a register is set when a bit of flags is, the bit is tested in a copy")
+__success
+__naked void flag_and(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = 0;"
+	"if r0 == 0 goto 1f;"
+	"r8 = 0;"
+	"r6 = 1;"
+"1:"
+	"r1 = r6;"
+	"r1 &= 1;"
+	"if r1 == 0 goto 2f;"
+	"r0 = r8;"
+	"exit;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+SEC("socket")
+__description("set or not: a register is set when ret is 0, ret + 1 is tested")
+__success
+__naked void flag_add(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = 0;"
+	"if r0 == 0 goto 1f;"
+	"r8 = 0;"
+	"r6 = 1;"
+"1:"
+	"r1 = r6;"
+	"r1 += 4;"
+	"if r1 != 5 goto 2f;"
+	"r0 = r8;"
+	"exit;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+SEC("socket")
+__description("set or not: a register is set when ret is 0, the jump is 264 insns away")
+__success
+__naked void jump_is_far(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"w6 = -2;"
+	"if r0 == 0 goto 1f;"
+	"r8 = 5;"
+	"w6 = 0;"
+"1:"
+	"r0 = 0;"
+	ADD64 ADD64 ADD64 ADD64 ADD8
+	"if w6 s< 0 goto 2f;"
+	"r0 = r8;"
+	"exit;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+SEC("socket")
+__description("set or not: a register is set when ret is 0, ret is spilled with 4 and with 8 bytes")
+__success
+__naked void spill32_move(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"w1 = -2;"
+	"*(u32 *)(r10 - 8) = r1;"
+	"if r0 == 0 goto 1f;"
+	"r8 = 0;"
+	"w1 = 0;"
+	"*(u32 *)(r10 - 8) = r1;"
+"1:"
+	"r1 = *(u32 *)(r10 - 8);"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r2 = *(u64 *)(r10 - 16);"
+	"if w2 s< 0 goto 2f;"
+	"r0 = r8;"
+	"exit;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, char[64]);
+} h SEC(".maps");
+
+/*
+ *	p = NULL;
+ *	ret = find(key, &p);	-ENOENT, 1: nothing to do, 0: p is the entry
+ *	if (ret < 0)
+ *		goto err;
+ *	if (ret > 0)
+ *		goto skip;
+ *	return p->x;
+ */
+SEC("socket")
+__description("jumps ahead: less, greater, or load through the pointer")
+__success
+__naked void ptr_three_ways(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r8 = 0;"
+	"r6 = 1;"
+	"if r0 == 0 goto 1f;"
+	"*(u32 *)(r10 - 4) = r0;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"r1 = %[h] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"r6 = -2;"
+	"if r0 == 0 goto 1f;"
+	"r8 = r0;"
+	"r6 = 0;"
+"1:"
+	"if r6 s< 0 goto 2f;"
+	"if r6 s> 0 goto 2f;"
+	"r0 = *(u32 *)(r8 + 0);"
+	"exit;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32), __imm(bpf_map_lookup_elem), __imm_addr(h) : __clobber_all);
+}
+
+/*
+ *	ret = 0;
+ *	state = lookup(&h, &key);
+ *	if (!state) {
+ *		err = update(&h, &key, &new, 0);
+ *		ret = err < 0 ? DROP : 0;
+ *		...
+ *		if (err < 0)
+ *			goto out;
+ *		state = lookup(&h, &key);
+ *		if (!state)
+ *			return 0;
+ *	}
+ * out:
+ *	if (ret < 0)
+ *		goto drop;
+ *	return state->x;
+ */
+SEC("socket")
+__description("jumps ahead: err and ret, load through the pointer")
+__success
+__naked void ptr_err_and_ret(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"*(u64 *)(r10 - 72) = r1;"
+	"*(u64 *)(r10 - 64) = r1;"
+	"*(u64 *)(r10 - 56) = r1;"
+	"*(u64 *)(r10 - 48) = r1;"
+	"*(u64 *)(r10 - 40) = r1;"
+	"*(u64 *)(r10 - 32) = r1;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"r1 = %[h] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"r8 = r0;"
+	"w9 = 0;"
+	"if r8 != 0 goto 3f;"
+	"r1 = %[h] ll;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"r3 = r10;"
+	"r3 += -72;"
+	"r4 = 0;"
+	"call %[bpf_map_update_elem];"
+	"w9 = 0;"
+	"if w0 s> -1 goto 1f;"
+	"w9 = -155;"
+"1:"
+	"w6 = 0;"
+	"if w0 s< 0 goto 3f;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"r1 = %[h] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"r8 = r0;"
+	"if r8 == 0 goto 4f;"
+"3:"
+	"if w9 s< 0 goto 4f;"
+	"r0 = *(u32 *)(r8 + 0);"
+	"exit;"
+"4:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_map_lookup_elem), __imm(bpf_map_update_elem), __imm_addr(h) : __clobber_all);
+}
+
+#define PAIR(name, desc, is_err, drop, is_drop)				\
+SEC("socket")								\
+__description(desc)							\
+__success								\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	"r1 = 0;"							\
+	"*(u32 *)(r10 - 4) = r1;"					\
+	"*(u64 *)(r10 - 72) = r1;"					\
+	"*(u64 *)(r10 - 64) = r1;"					\
+	"*(u64 *)(r10 - 56) = r1;"					\
+	"*(u64 *)(r10 - 48) = r1;"					\
+	"*(u64 *)(r10 - 40) = r1;"					\
+	"*(u64 *)(r10 - 32) = r1;"					\
+	"*(u64 *)(r10 - 24) = r1;"					\
+	"*(u64 *)(r10 - 16) = r1;"					\
+	"r2 = r10;"							\
+	"r2 += -4;"							\
+	"r1 = %[h] ll;"							\
+	"call %[bpf_map_lookup_elem];"					\
+	"r8 = r0;"							\
+	"w9 = 0;"							\
+	"if r8 != 0 goto 3f;"						\
+	"r1 = %[h] ll;"							\
+	"r2 = r10;"							\
+	"r2 += -4;"							\
+	"r3 = r10;"							\
+	"r3 += -72;"							\
+	"r4 = 0;"							\
+	"call %[bpf_map_update_elem];"					\
+	is_err								\
+	"w9 = 0;"							\
+	"if w7 == 0 goto 1f;"						\
+	"w9 = " drop ";"						\
+"1:"									\
+	"w6 = 0;"							\
+	"if w7 != 0 goto 3f;"						\
+	"r2 = r10;"							\
+	"r2 += -4;"							\
+	"r1 = %[h] ll;"							\
+	"call %[bpf_map_lookup_elem];"					\
+	"r8 = r0;"							\
+	"if r8 == 0 goto 4f;"						\
+"3:"									\
+	"if w9 " is_drop " goto 4f;"					\
+	"r0 = *(u32 *)(r8 + 0);"					\
+	"exit;"								\
+"4:"									\
+	"r0 = 0;"							\
+	"exit;"								\
+	:: __imm(bpf_map_lookup_elem), __imm(bpf_map_update_elem),	\
+	   __imm_addr(h) : __clobber_all);				\
+}
+
+/* 0 and 1 touch, in both numbers. The join would have err = 1 with ret = 0. */
+PAIR(ptr_two_flags, "jumps ahead: two flags, load through the pointer",
+     "w7 = 1; if w0 s< 0 goto +1; w7 = 0;", "1", "!= 0")
+
+/*
+ * 20 flags, 0 or 5, all are looked at later: 2^20 ways, and 0 and 5 leave a gap.
+ * States are kept apart while there is room. After that they are joined.
+ */
+#define PICK_FLAG(slot)					\
+	"call %[bpf_get_prandom_u32];"			\
+	"r1 = 0;"					\
+	"if r0 == 0 goto +1;"				\
+	"r1 = 5;"					\
+	"*(u64*)(r10 - " #slot ") = r1;"
+#define USE_FLAG(slot)					\
+	"r1 = *(u64*)(r10 - " #slot ");"		\
+	"if r1 == 0 goto +1;"				\
+	"r6 += 1;"
+
+SEC("socket")
+__description("jumps ahead: 20 flags that leave a gap")
+__success
+__naked void many_flags_gap(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	PICK_FLAG(8) PICK_FLAG(16) PICK_FLAG(24) PICK_FLAG(32) PICK_FLAG(40) PICK_FLAG(48)
+	PICK_FLAG(56) PICK_FLAG(64) PICK_FLAG(72) PICK_FLAG(80) PICK_FLAG(88) PICK_FLAG(96)
+	PICK_FLAG(104) PICK_FLAG(112) PICK_FLAG(120) PICK_FLAG(128) PICK_FLAG(136) PICK_FLAG(144)
+	PICK_FLAG(152) PICK_FLAG(160)
+	USE_FLAG(8) USE_FLAG(16) USE_FLAG(24) USE_FLAG(32) USE_FLAG(40) USE_FLAG(48)
+	USE_FLAG(56) USE_FLAG(64) USE_FLAG(72) USE_FLAG(80) USE_FLAG(88) USE_FLAG(96)
+	USE_FLAG(104) USE_FLAG(112) USE_FLAG(120) USE_FLAG(128) USE_FLAG(136) USE_FLAG(144)
+	USE_FLAG(152) USE_FLAG(160)
+	"r0 = r6;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/* 33 numbers, each with an exit of its own */
+static __naked __noinline __used int ret_exits(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"if r1 != 0 goto +2; r0 = 0; exit;"
+	"if r1 != 1 goto +2; r0 = 3; exit;"
+	"if r1 != 2 goto +2; r0 = 6; exit;"
+	"if r1 != 3 goto +2; r0 = 9; exit;"
+	"if r1 != 4 goto +2; r0 = 12; exit;"
+	"if r1 != 5 goto +2; r0 = 15; exit;"
+	"if r1 != 6 goto +2; r0 = 18; exit;"
+	"if r1 != 7 goto +2; r0 = 21; exit;"
+	"if r1 != 8 goto +2; r0 = 24; exit;"
+	"if r1 != 9 goto +2; r0 = 27; exit;"
+	"if r1 != 10 goto +2; r0 = 30; exit;"
+	"if r1 != 11 goto +2; r0 = 33; exit;"
+	"if r1 != 12 goto +2; r0 = 36; exit;"
+	"if r1 != 13 goto +2; r0 = 39; exit;"
+	"if r1 != 14 goto +2; r0 = 42; exit;"
+	"if r1 != 15 goto +2; r0 = 45; exit;"
+	"if r1 != 16 goto +2; r0 = 48; exit;"
+	"if r1 != 17 goto +2; r0 = 51; exit;"
+	"if r1 != 18 goto +2; r0 = 54; exit;"
+	"if r1 != 19 goto +2; r0 = 57; exit;"
+	"if r1 != 20 goto +2; r0 = 60; exit;"
+	"if r1 != 21 goto +2; r0 = 63; exit;"
+	"if r1 != 22 goto +2; r0 = 66; exit;"
+	"if r1 != 23 goto +2; r0 = 69; exit;"
+	"if r1 != 24 goto +2; r0 = 72; exit;"
+	"if r1 != 25 goto +2; r0 = 75; exit;"
+	"if r1 != 26 goto +2; r0 = 78; exit;"
+	"if r1 != 27 goto +2; r0 = 81; exit;"
+	"if r1 != 28 goto +2; r0 = 84; exit;"
+	"if r1 != 29 goto +2; r0 = 87; exit;"
+	"if r1 != 30 goto +2; r0 = 90; exit;"
+	"if r1 != 31 goto +2; r0 = 93; exit;"
+	"r0 = 99;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/* 25 is not one of them, and r8 is not set */
+SEC("socket")
+__description("jumps ahead: one of 33 numbers out of a function")
+__success
+__naked void rets_33(void)
+{
+	asm volatile (
+	"call ret_exits;"
+	"if r0 != 25 goto 1f;"
+	"r0 = r8;"
+	"exit;"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* 33^4 ways: not all of them are looked at */
+SEC("socket")
+__description("jumps ahead: one of 33 numbers out of a function, 4 times")
+__success
+__naked void rets_33_4_times(void)
+{
+	asm volatile (
+	"call ret_exits; r6 = r0;"
+	"call ret_exits; r7 = r0;"
+	"call ret_exits; r8 = r0;"
+	"call ret_exits; r9 = r0;"
+	"r0 = 0;"
+	"if r6 != 3 goto +1; r0 += 1;"
+	"if r7 != 6 goto +1; r0 += 1;"
+	"if r8 != 9 goto +1; r0 += 1;"
+	"if r9 != 12 goto +1; r0 += 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* 16 numbers, 0 or not, all are looked at later: 2^16 ways */
+#define PICK_NULL(slot)					\
+	"call %[bpf_get_prandom_u32];"			\
+	"r0 <<= 32;"					\
+	"r7 = r0;"					\
+	"call %[bpf_get_prandom_u32];"			\
+	"r0 |= r7;"					\
+	"if r0 == 0 goto +0;"				\
+	"*(u64*)(r10 - " #slot ") = r0;"
+#define USE_NULL(slot)					\
+	"r1 = *(u64*)(r10 - " #slot ");"		\
+	"if r1 == 0 goto +1;"				\
+	"r6 += 1;"
+
+SEC("socket")
+__description("jumps ahead: 16 times 0 or not")
+__success
+__naked void many_nulls(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	PICK_NULL(8) PICK_NULL(16) PICK_NULL(24) PICK_NULL(32) PICK_NULL(40) PICK_NULL(48)
+	PICK_NULL(56) PICK_NULL(64) PICK_NULL(72) PICK_NULL(80) PICK_NULL(88) PICK_NULL(96)
+	PICK_NULL(104) PICK_NULL(112) PICK_NULL(120) PICK_NULL(128)
+	USE_NULL(8) USE_NULL(16) USE_NULL(24) USE_NULL(32) USE_NULL(40) USE_NULL(48)
+	USE_NULL(56) USE_NULL(64) USE_NULL(72) USE_NULL(80) USE_NULL(88) USE_NULL(96)
+	USE_NULL(104) USE_NULL(112) USE_NULL(120) USE_NULL(128)
+	"r0 = r6;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index d92215c5b923..1891995df973 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -12,6 +12,13 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long long);
+} map_array_8b SEC(".maps");
+
 SEC("lwt_in")
 __description("variable-offset ctx access")
 __failure __msg("variable ctx access var_off=(0x0; 0x4)")
@@ -556,4 +563,551 @@ __naked void variable_offset_stack_access_ok(void)
 	: __clobber_all);
 }
 
+/*
+ * if (x) a[0] = p; else a[1] = p; with one store. The paths meet in front of it.
+ * The offset is known on each of them.
+ */
+SEC("tc")
+__description("pointer is spilled at one of two offsets")
+__success __retval(0)
+__naked void ptr_at_one_of_two_offsets(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_array_8b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r6 = r0;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 16) = r1;				\
+	*(u64*)(r10 - 24) = r1;				\
+	call %[bpf_get_prandom_u32];			\
+	r7 = 0;						\
+	if r0 > 100 goto l0_%=;				\
+	r7 = 8;						\
+l0_%=:	r2 = r10;					\
+	r2 += -24;					\
+	r2 += r7;					\
+	*(u64*)(r2 + 0) = r6;				\
+	if r7 != 0 goto l1_%=;				\
+	r3 = *(u64*)(r10 - 24);				\
+	r0 = *(u64*)(r3 + 0);				\
+	exit;						\
+l1_%=:	r3 = *(u64*)(r10 - 16);				\
+	r0 = *(u64*)(r3 + 0);				\
+	exit;						\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("pointer is spilled at one of two offsets, the offset is spilled too")
+__success __retval(0)
+__naked void ptr_at_one_of_two_spilled_offsets(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_array_8b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r6 = r0;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 16) = r1;				\
+	*(u64*)(r10 - 24) = r1;				\
+	*(u64*)(r10 - 32) = r1;				\
+	call %[bpf_get_prandom_u32];			\
+	if r0 > 100 goto l0_%=;				\
+	r1 = 8;						\
+	*(u64*)(r10 - 32) = r1;				\
+l0_%=:	r7 = *(u64*)(r10 - 32);				\
+	r2 = r10;					\
+	r2 += -24;					\
+	r2 += r7;					\
+	*(u64*)(r2 + 0) = r6;				\
+	if r7 != 0 goto l1_%=;				\
+	r3 = *(u64*)(r10 - 24);				\
+	r0 = *(u64*)(r3 + 0);				\
+	exit;						\
+l1_%=:	r3 = *(u64*)(r10 - 16);				\
+	r0 = *(u64*)(r3 + 0);				\
+	exit;						\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_8b)
+	: __clobber_all);
+}
+
+static __naked __noinline __used void spill_r3_at_r1_plus_r2(void)
+{
+	asm volatile ("					\
+	r1 += r2;					\
+	*(u64*)(r1 + 0) = r3;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("pointer is spilled at one of two offsets by a subprog")
+__success __retval(0)
+__naked void ptr_at_one_of_two_offsets_subprog(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_array_8b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r6 = r0;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 16) = r1;				\
+	*(u64*)(r10 - 24) = r1;				\
+	call %[bpf_get_prandom_u32];			\
+	r7 = 0;						\
+	if r0 > 100 goto l0_%=;				\
+	r7 = 8;						\
+l0_%=:	r1 = r10;					\
+	r1 += -24;					\
+	r2 = r7;					\
+	r3 = r6;					\
+	call spill_r3_at_r1_plus_r2;			\
+	if r7 != 0 goto l1_%=;				\
+	r3 = *(u64*)(r10 - 24);				\
+	r0 = *(u64*)(r3 + 0);				\
+	exit;						\
+l1_%=:	r3 = *(u64*)(r10 - 16);				\
+	r0 = *(u64*)(r3 + 0);				\
+	exit;						\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_8b)
+	: __clobber_all);
+}
+
+#define PICK_OFF(slot)					\
+	"call %[bpf_get_prandom_u32];"			\
+	"r1 = 0;"					\
+	"if r0 > 100 goto +1;"				\
+	"r1 = 8;"					\
+	"*(u64*)(r10 - " #slot ") = r1;"
+
+#define USE_OFF(slot)					\
+	"r1 = *(u64*)(r10 - " #slot ");"		\
+	"r2 = r10;"					\
+	"r2 += -16;"					\
+	"r2 += r1;"					\
+	"*(u64*)(r2 + 0) = r0;"
+
+/* 4096 combinations of offsets that are known: not all of them are looked at */
+SEC("tc")
+__description("12 times one of two offsets")
+__success __retval(0)
+__naked void many_offsets(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"*(u64*)(r10 - 16) = r1;"
+	PICK_OFF(24) PICK_OFF(32) PICK_OFF(40) PICK_OFF(48)
+	PICK_OFF(56) PICK_OFF(64) PICK_OFF(72) PICK_OFF(80)
+	PICK_OFF(88) PICK_OFF(96) PICK_OFF(104) PICK_OFF(112)
+	USE_OFF(24) USE_OFF(32) USE_OFF(40) USE_OFF(48)
+	USE_OFF(56) USE_OFF(64) USE_OFF(72) USE_OFF(80)
+	USE_OFF(88) USE_OFF(96) USE_OFF(104) USE_OFF(112)
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __ksym;
+extern int *bpf_iter_num_next(struct bpf_iter_num *it) __ksym;
+extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
+
+/* The verifier doesn't know what is in there */
+unsigned long zero;
+
+#define ITER_NEW	"r1 = r10; r1 += -24; w2 = 0; w3 = 100; call %[bpf_iter_num_new];"
+#define ITER_NEXT	"r1 = r10; r1 += -24; call %[bpf_iter_num_next];"
+#define ITER_DESTROY	"r1 = r10; r1 += -24; call %[bpf_iter_num_destroy];"
+#define __imm_iter	__imm(bpf_iter_num_new), __imm(bpf_iter_num_next), \
+			__imm(bpf_iter_num_destroy)
+
+/*
+ *	u8 stack[10], depth = 0;
+ *	loop {
+ *		if (x) { if (depth >= 10) break; stack[depth++] = 1; }
+ *		else { depth--; if (depth >= 10) break; y = stack[depth]; }
+ *	}
+ * depth is in a 32-bit register. 'depth & 255' is tested, and computed anew for the index.
+ */
+#define PUSH_OR_POP					\
+		"r1 = *(u64 *)(r6 + 0);"		\
+		"if r1 == 0 goto 2f;"			\
+		"w7 = w8;"				\
+		"w7 &= 255;"				\
+		"if w7 > 9 goto 9f;"			\
+		"r1 = r8;"				\
+		"r1 &= 255;"				\
+		"r2 = r10;"				\
+		"r2 += -10;"				\
+		"r2 += r1;"				\
+		"*(u8 *)(r2 + 0) = r1;"			\
+		"w8 += 1;"				\
+		"goto 1b;"				\
+	"2:"						\
+		"w8 += -1;"				\
+		"w2 = w8;"				\
+		"w2 &= 255;"				\
+		"if w2 > 9 goto 9f;"			\
+		"r2 = r8;"				\
+		"r2 &= 255;"				\
+		"r3 = r10;"				\
+		"r3 += -10;"				\
+		"r3 += r2;"				\
+		"r9 = *(u8 *)(r3 + 0);"			\
+		"goto 1b;"
+
+SEC("tc")
+__description("depth of a stack on the stack: a copy is tested")
+__success __retval(0)
+__naked void depth_copy_is_tested(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"*(u64 *)(r10 - 16) = r1;"
+		"w8 = 0;"
+		ITER_NEW
+	"1:"
+		ITER_NEXT
+		"if r0 == 0 goto 9f;"
+		PUSH_OR_POP
+	"9:"
+		ITER_DESTROY
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(zero), __imm_iter
+		: __clobber_all);
+}
+
+/* Nothing of the prog stops the loop */
+SEC("tc")
+__description("depth of a stack on the stack: a copy is tested, no iterator")
+__success __retval(0)
+__naked void depth_copy_is_tested_no_iter(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"*(u64 *)(r10 - 16) = r1;"
+		"w8 = 0;"
+	"1:"
+		PUSH_OR_POP
+	"9:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all);
+}
+
+/*
+ * u32 stack[16]. The copy that is tested is volatile: it's stored once and read twice.
+ * depth takes 18 values: 0..16 and 255.
+ */
+SEC("tc")
+__description("depth of a stack on the stack: a volatile copy is tested")
+__success __retval(0)
+__naked void depth_volatile_copy_is_tested(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"w8 = 0;"
+		ITER_NEW
+	"1:"
+		ITER_NEXT
+		"if r0 == 0 goto 9f;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 == 0 goto 2f;"
+		"w2 = w8;"
+		"w2 &= 255;"
+		"if w2 > 15 goto 9f;"
+		"*(u8 *)(r10 - 32) = r8;"
+		"r2 = *(u8 *)(r10 - 32);"
+		"if w2 > 15 goto 9f;"
+		"r2 = *(u8 *)(r10 - 32);"
+		"r2 <<= 2;"
+		"r3 = r10;"
+		"r3 += -96;"
+		"r3 += r2;"
+		"*(u32 *)(r3 + 0) = r1;"
+		"w8 += 1;"
+		"goto 1b;"
+	"2:"
+		"*(u8 *)(r10 - 32) = r8;"
+		"r1 = *(u8 *)(r10 - 32);"
+		"r1 += -1;"
+		"*(u8 *)(r10 - 32) = r1;"
+		"r1 = *(u8 *)(r10 - 32);"
+		"if r1 > 15 goto 9f;"
+		"r1 = *(u8 *)(r10 - 32);"
+		"r1 <<= 2;"
+		"r3 = r10;"
+		"r3 += -96;"
+		"r3 += r1;"
+		"r7 = *(u32 *)(r3 + 0);"
+		"r8 = *(u8 *)(r10 - 32);"
+		"goto 1b;"
+	"9:"
+		ITER_DESTROY
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(zero), __imm_iter
+		: __clobber_all);
+}
+
+SEC("tc")
+__description("depth of a stack on the stack: no bound")
+__failure __msg("invalid variable-offset write to stack R2")
+__naked void depth_without_a_bound(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"*(u64 *)(r10 - 16) = r1;"
+		"w8 = 0;"
+		ITER_NEW
+	"1:"
+		ITER_NEXT
+		"if r0 == 0 goto 9f;"
+		"r1 = r8;"
+		"r1 &= 255;"
+		"r2 = r10;"
+		"r2 += -10;"
+		"r2 += r1;"
+		"*(u8 *)(r2 + 0) = r1;"
+		"w8 += 1;"
+		"goto 1b;"
+	"9:"
+		ITER_DESTROY
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_iter
+		: __clobber_all);
+}
+
+/*
+ * The counters never come to rest, and go up by 1 or by 2, so that there is no summary of them.
+ * There are so many constants, then it's a range.
+ */
+#define UP(r)	"call %[bpf_get_prandom_u32]; " #r " += 1; if r0 > 100 goto +1; " #r " += 1;"
+
+SEC("tc")
+__description("counters without a bound are masked for an offset in the stack")
+__success __retval(0)
+__naked void masked_counters(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"*(u64 *)(r10 - 16) = r1;"
+		"w7 = 0;"
+		"w8 = 0;"
+		"w9 = 0;"
+	"1:"
+		UP(w7)
+	"2:"
+		UP(w8)
+	"3:"
+		UP(w9)
+		"r1 = r7;"
+		"r1 += r8;"
+		"r1 += r9;"
+		"r1 &= 15;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"r2 += r1;"
+		"*(u8 *)(r2 + 0) = r1;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 == 1 goto 3b;"
+		"if r1 == 2 goto 2b;"
+		"if r1 == 3 goto 1b;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(zero), __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_iter_num_new(0, 0, 0);
+	bpf_iter_num_next(0);
+	bpf_iter_num_destroy(0);
+}
+
+/* u8 stack[40] and u8 stack[200]: depth takes 42 and 202 values */
+SEC("tc")
+__description("depth of a stack on the stack: 40 deep")
+__success __retval(0)
+__naked void depth_40(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"*(u64 *)(r10 - 16) = r1;"
+		"*(u64 *)(r10 - 24) = r1;"
+		"*(u64 *)(r10 - 32) = r1;"
+		"*(u64 *)(r10 - 40) = r1;"
+		"w8 = 0;"
+	"1:"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 == 0 goto 2f;"
+		"w7 = w8;"
+		"w7 &= 255;"
+		"if w7 > 39 goto 9f;"
+		"r1 = r8;"
+		"r1 &= 255;"
+		"r2 = r10;"
+		"r2 += -40;"
+		"r2 += r1;"
+		"*(u8 *)(r2 + 0) = r1;"
+		"w8 += 1;"
+		"goto 1b;"
+	"2:"
+		"w8 += -1;"
+		"w2 = w8;"
+		"w2 &= 255;"
+		"if w2 > 39 goto 9f;"
+		"r2 = r8;"
+		"r2 &= 255;"
+		"r3 = r10;"
+		"r3 += -40;"
+		"r3 += r2;"
+		"r9 = *(u8 *)(r3 + 0);"
+		"goto 1b;"
+	"9:"
+		"r0 = 0;"
+		"exit;"
+		:: __imm_addr(zero) : __clobber_all);
+}
+
+SEC("tc")
+__description("depth of a stack on the stack: 200 deep")
+__success __retval(0)
+__naked void depth_200(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"*(u64 *)(r10 - 16) = r1;"
+		"*(u64 *)(r10 - 24) = r1;"
+		"*(u64 *)(r10 - 32) = r1;"
+		"*(u64 *)(r10 - 40) = r1;"
+		"*(u64 *)(r10 - 48) = r1;"
+		"*(u64 *)(r10 - 56) = r1;"
+		"*(u64 *)(r10 - 64) = r1;"
+		"*(u64 *)(r10 - 72) = r1;"
+		"*(u64 *)(r10 - 80) = r1;"
+		"*(u64 *)(r10 - 88) = r1;"
+		"*(u64 *)(r10 - 96) = r1;"
+		"*(u64 *)(r10 - 104) = r1;"
+		"*(u64 *)(r10 - 112) = r1;"
+		"*(u64 *)(r10 - 120) = r1;"
+		"*(u64 *)(r10 - 128) = r1;"
+		"*(u64 *)(r10 - 136) = r1;"
+		"*(u64 *)(r10 - 144) = r1;"
+		"*(u64 *)(r10 - 152) = r1;"
+		"*(u64 *)(r10 - 160) = r1;"
+		"*(u64 *)(r10 - 168) = r1;"
+		"*(u64 *)(r10 - 176) = r1;"
+		"*(u64 *)(r10 - 184) = r1;"
+		"*(u64 *)(r10 - 192) = r1;"
+		"*(u64 *)(r10 - 200) = r1;"
+		"w8 = 0;"
+	"1:"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 == 0 goto 2f;"
+		"w7 = w8;"
+		"w7 &= 255;"
+		"if w7 > 199 goto 9f;"
+		"r1 = r8;"
+		"r1 &= 255;"
+		"r2 = r10;"
+		"r2 += -200;"
+		"r2 += r1;"
+		"*(u8 *)(r2 + 0) = r1;"
+		"w8 += 1;"
+		"goto 1b;"
+	"2:"
+		"w8 += -1;"
+		"w2 = w8;"
+		"w2 &= 255;"
+		"if w2 > 199 goto 9f;"
+		"r2 = r8;"
+		"r2 &= 255;"
+		"r3 = r10;"
+		"r3 += -200;"
+		"r3 += r2;"
+		"r9 = *(u8 *)(r3 + 0);"
+		"goto 1b;"
+	"9:"
+		"r0 = 0;"
+		"exit;"
+		:: __imm_addr(zero) : __clobber_all);
+}
+
+/* 2^20 combinations */
+SEC("tc")
+__description("20 times one of two offsets")
+__success __retval(0)
+__naked void many_more_offsets(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"*(u64*)(r10 - 16) = r1;"
+	PICK_OFF(24) PICK_OFF(32) PICK_OFF(40) PICK_OFF(48) PICK_OFF(56) PICK_OFF(64) PICK_OFF(72)
+	PICK_OFF(80) PICK_OFF(88) PICK_OFF(96) PICK_OFF(104) PICK_OFF(112) PICK_OFF(120)
+	PICK_OFF(128) PICK_OFF(136) PICK_OFF(144) PICK_OFF(152) PICK_OFF(160) PICK_OFF(168)
+	PICK_OFF(176)
+	USE_OFF(24) USE_OFF(32) USE_OFF(40) USE_OFF(48) USE_OFF(56) USE_OFF(64) USE_OFF(72)
+	USE_OFF(80) USE_OFF(88) USE_OFF(96) USE_OFF(104) USE_OFF(112) USE_OFF(120)
+	USE_OFF(128) USE_OFF(136) USE_OFF(144) USE_OFF(152) USE_OFF(160) USE_OFF(168)
+	USE_OFF(176)
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

