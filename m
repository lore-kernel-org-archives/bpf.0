Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022925;
	b=2es9WvOAZ2evCuMZThCuzLkzxYznDRtAoZdqIU9IJmgQAnLeuI5FS4omYWwHKDDhsIB1
	 oI3ByR/K519OHrk+GV9gq8VgJv8y0nRBsIfZi9QTjyE2kvUtJXXdl9vpyKStiVwb35C5p
	 lPv5sgzUjMu70ULAXlZvOpLLeNuFnCMQhUpWePBRKXjPwNS5zzvw/zto7l6+nLPQVGPd2
	 f4RsfmILEYNNRg5z+Km86GBnhOnsQOXlRrAA4mg2P+owOvPnLBtM6obrPuYJZLa7fSeD2
	 ss8V8AsFberqUUTsVqY4T1OhnPzP8hZcqbF6RWKZ0MTvC+9o0ePXgCVCZAoiHzVwIyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1ejrGJ/GEUPg0LTxNeyfThJWIhnj8s/kDTqhMt3VH98=;
	b=1WGWETevxhf0igz3+slsiBOGBR9Zbfqus0q/g4QZHvVlDexnfRrFK7QEYCEjqAA8Uc3K
	 F28WWyjvzTjWf48GE+/t9TsR9y3IUVkZpu1E9TfNhgXFtrUSlabzSgGtOCot+R1KGBVp7
	 QlP07/Aji2JY/CQgDtDL60FyFZShgfxmUyp+h0G0rcsIivOG+A0jIRF/DRq115AWwgoFo
	 to+xUTsFodNaepjmJDX1odQHU3YSYKrTm5+b1rFUy0xhSnvTC6oXcd2z85ZH3CzNl8zJO
	 fTfefs7NUVRivVbpYzT0a6+5cc0KGVyyAdqu5nl3IKfT+KzEVoki3uNPB8d8YcpT3QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/386h7I";
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB854606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB854606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/386h7I
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so512614b3a.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022924; x=1794627724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ejrGJ/GEUPg0LTxNeyfThJWIhnj8s/kDTqhMt3VH98=;
        b=I/386h7IBOKBIauYDYrkFeSQezPc2XX6TdPkTcFNhMf1gN6rswjxDUaGDi3NvaJfPk
         gv5/l1jXql+PkwkK/3O1Hls+XKbxZtG9oV3NABdQBMqwLEEtCideD9T4hrIwGFjJT37o
         JGMpIyar/mVy6IPWPsKtg5rAy5KBsRNwby4/YrgKNzkdB8y4ELuHfr/wiMTz5CujdfQj
         56IhF2s0bf0WFuZkWAPUpFtGHd2A3v61/r5gLQ/vffFxYk6+iP/zMe1eHQHIbYhvW95S
         0sHpUKqytvlHF/u8fRaeisFtYg8Oju+7tLedrXPgk7BVDtCFrwHxbFWvzs7XMA9kHiDJ
         PAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022924; x=1794627724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ejrGJ/GEUPg0LTxNeyfThJWIhnj8s/kDTqhMt3VH98=;
        b=v/e+kua0MDpbjYUCYnRC46sytJBlK9oDq8xFJ6E5/E09bSh4UgAeIAQAiMQoOvsOXs
         p+Z8KK3Gx0+80fQymW6jVf9i4/OozzY75Itd8Ym/2bOwT/JBJ8rXpHu0AdhVt4pLFmWq
         iDwFmdb5jcOCVxEgYeikfLFc/+26s6/tlBK4s0HnhdKcP2tsKPiZLXcJ+k/h0FPndNwg
         I5tmZrUrM3YddoNv+3/vr4w/hnAdzkLhjIFqJGqBDk2VjkrS7sHzt4qe2bCJJkZFVnXb
         IKchfceJYzaHA6/086jEcOsPxl5cuIUjtVNhajbkX+WkygUtveaf5wxev+nD6JHtnen4
         7p7A==
X-Gm-Message-State: APuU4Z+deoxdAhByB0xmSKRIpcHpOJQpYgZH8pctEXSd3M+elQXqjOkz
	lSDLiRCOenqrtx4ifQv8eurGPq0iIAZKxZsH2MBsTxSaCSChoBK4wcAEb757qQ==
X-Gm-Gg: AYBFou1yr9EitviRHk6gEcJqK+R0hDK8b7dQyMQW96xsO+IGDD8NKGUba+ocPbA9gZX
	l4lokPeTV35Cv9ZrlCE5dtbSq9zMfufqDyJjnvbWvuue5uetc7Dzh+etHGw784M8wi2hV0ObcE0
	LVuNbm3qtqCYbk3jriAfHeeppH91QxhN5IOM/wcQmmUmc3FZUP6BzZbC4qKK7bKRm2SpkyJkFtl
	9FzzyNjm35FT0DOdqO4qWodyMjG1o3J+ohhR2/j9iQ8F4ItkUmU0PirXrB1ajd6gRYCdqtLkR/i
	nefdXbozx2w3vjI4GorwVYnNdk3VUWNCoZxkjY7qOm8g6f01gbjsCCj/LQx07N5kWMaMgZfAVnF
	S8jQEcwXDVHO3N875QJTwH92i6rm57+Yq3e1eCV/2xctcrkTgxncR+ydTYd9fib4UtosVL/gAuK
	eDfO4TDBobCvRiulDuxMXzZozjY04T4eEXrvpa05/rMeHadibNvvZUePRowJO4rw9VbVhYmiMg/
	0oHcTc3WUBFaMPmDm/Uhb+kx8FxGljqnvP+XmeSth6P9Pno0iolyBeZew56oQZl7eS7b7wdN9ws
	J7oxSLafiaBPd+Cyasqgyx7WspC4f05sK2HqSfYglZ64Jf8niaHJ85vSSlNnU0cWXtlg337CDxf
	0Q6dpL5dihh9jphiw5GsRlPo1TFdwEI3FGSfDmXZKWABf5Pt1M51oUTI9h+A4gRoKjoslVpyRHA
	==
X-Received: by 2002:a17:90b:3c8e:b0:3ab:de4:7fa5 with SMTP id 98e67ed59e1d1-3b0db71d9f8mr4477349a91.56.1794022923299;
        Fri, 06 Nov 2026 19:42:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101e3e513sm1041613a91.4.2026.11.06.19.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:42:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 40/46] selftests/bpf: Test states that are not joined
Date: Sat,  7 Nov 2026 03:37:48 +0000
Message-ID: <20261107033758.1547725-41-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

  ret = lookup(&p);      /* ret = -ENOENT and p is not set, or */
  if (ret < 0)           /* ret = 0 and p is set               */
          goto drop;
  use(p);

When the compiler inlines lookup(), the two states meet in front of the
jump. A verifier that follows paths keeps them apart and loads the prog.
Their join, ret = [-2, 0], gets to use(p) without p. Thus the verifier does
not join states when a check ahead can depend on the difference. Each test
has one such difference, in the form that a real prog has.

  [J] "bpf: Add join of registers and stack slots"
  [K] "bpf: Find the registers that hold a number or a pointer to arena"
  [A] "bpf: Find the registers and stack slots that later checks depend on"
  [N] "bpf: Decide which states are not joined"
  [M] "bpf: Merge the state that arrives into the set at an insn"
  [F] "bpf: Verify programs as a fixpoint over the control flow graph"

  verifier_..     the two states differ in                   as in
  --------------  -----------------------------------------  --------------
  jumps_ahead.c   [N] a number that a jump ahead tests, the  Cilium,
                  ranges have a gap: -155 and 0              profiler,
                  [N] two such numbers that go together      test_seg6_loop
                  [N] a register that only one state sets
                  [N] 0 or not 0, in one of two slots        xdp_synproxy
                  [N] a flag, 0 and 1, that a jump in this
                  block or the next one tests
                  [M] a register that only a loop sets
  ptr_off.c       [A] a constant that is added to a pointer
                  [J] how much of the packet is checked
                  [K] the offset of one of two fields behind
                  bpf_core_cast(), bpf_cast_to_kern_ctx()
                  [K] 20 or 40 bytes of a packet whose       test_cls_
                  context was in a struct                    redirect
  var_off.c       [A] a constant offset in the stack
  mem_size_reg.c  [A] a size that a helper or a kfunc must
                  know

States that stay multiply. The verifier must join what no check can tell
apart: -134 and -135 ([N]), NULL or not in an array that a loop reads
(bpfjailer), an offset in a map value that has only numbers ([K]). 20 flags
and 12 offsets give 2^20 and 2^12 states: the rules apply only while less
than half of each limit on states is used ([N]). 4 calls that each return
one of 33 numbers give 33^4: bpf_flow_exit() widens an exit state that was
joined 16 times.

[F]: maybe_fork_scalars() makes -1 and 0 of [-1, 0]. The state with 0 must
not go back to an insn where [-1, 0] covers it (verifier_bounds.c). 1 and 2
are joined at exit: a prog that can return 2 must not attach to ingress
(cgroup_skb_egress_ret.c).

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/cgroup_skb_egress_ret.c    |  23 +
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../bpf/progs/cgroup_skb_egress_ret.c         |  12 +
 .../selftests/bpf/progs/verifier_bounds.c     | 108 +++
 .../bpf/progs/verifier_jumps_ahead.c          | 670 ++++++++++++++++++
 .../bpf/progs/verifier_mem_size_reg.c         |  48 ++
 .../selftests/bpf/progs/verifier_ptr_off.c    | 279 ++++++++
 .../selftests/bpf/progs/verifier_var_off.c    | 203 ++++++
 8 files changed, 1347 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_egress_ret.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_egress_ret.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ptr_off.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_egress_ret.c b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_egress_ret.c
new file mode 100644
index 000000000000..e261caac35e6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_egress_ret.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "cgroup_skb_egress_ret.skel.h"
+
+void test_cgroup_skb_egress_ret(void)
+{
+	struct cgroup_skb_egress_ret *skel;
+	int cg, fd;
+
+	cg = test__join_cgroup("/cgroup_skb_egress_ret");
+	if (!ASSERT_OK_FD(cg, "join_cgroup"))
+		return;
+	skel = cgroup_skb_egress_ret__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out;
+	fd = bpf_program__fd(skel->progs.one_or_two);
+	ASSERT_EQ(bpf_prog_attach(fd, cg, BPF_CGROUP_INET_INGRESS, 0), -EINVAL, "ingress");
+	ASSERT_OK(bpf_prog_attach(fd, cg, BPF_CGROUP_INET_EGRESS, 0), "egress");
+	cgroup_skb_egress_ret__destroy(skel);
+out:
+	close(cg);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d41339ef00d8..2f34a34e3d54 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -69,6 +69,7 @@
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
+#include "verifier_jumps_ahead.skel.h"
 #include "verifier_kfunc_packet_access.skel.h"
 #include "verifier_kfunc_uninit.skel.h"
 #include "verifier_kfunc_uninit_multi.skel.h"
@@ -107,6 +108,7 @@
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_private_stack.skel.h"
+#include "verifier_ptr_off.skel.h"
 #include "verifier_ptr_to_buf.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
@@ -267,6 +269,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
+void test_verifier_jumps_ahead(void)          { RUN(verifier_jumps_ahead); }
 void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
 void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
 void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_uninit_multi); }
@@ -317,6 +320,7 @@ void test_verifier_percpu_addr(void)          { RUN(verifier_percpu_addr); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_private_stack(void)        { RUN(verifier_private_stack); }
+void test_verifier_ptr_off(void)              { RUN(verifier_ptr_off); }
 void test_verifier_ptr_to_buf(void)           { RUN(verifier_ptr_to_buf); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
diff --git a/tools/testing/selftests/bpf/progs/cgroup_skb_egress_ret.c b/tools/testing/selftests/bpf/progs/cgroup_skb_egress_ret.c
new file mode 100644
index 000000000000..107f61d77538
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_skb_egress_ret.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* Only a prog at egress returns 2. At exit the verifier has 1 and 2 in one state. */
+SEC("cgroup_skb/egress")
+int one_or_two(struct __sk_buff *skb)
+{
+	return skb->len > 100 ? 2 : 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 6fede778971c..28d48e5fbc4f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2159,6 +2159,74 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+/*
+ * -1 and 0 meet at the insn that forks. The state with [-1, 0] is kept there. The
+ * pushed state is within it, so it's not there that it is pushed to.
+ */
+SEC("socket")
+__description("maybe_fork_scalars: AND where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	r6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: 32-bit AND of a 32-bit range where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and32_scalar32_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	w6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	w6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 /*
  * The insn that forks is the head of a loop that scalar evolution counted. The state with
  * [-1, 0] is kept there, and the state with 0 that is split off is within it.
@@ -2200,6 +2268,46 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+#define FORK						\
+	"r6 = *(u64*)(r9 + 0);"				\
+	"r6 s>>= 63;"					\
+	"r6 &= 4;"					\
+	"*(u64*)(r9 + 0) = r6;"
+#define FORK4 FORK FORK FORK FORK
+
+/*
+ * The pushed states of one block that don't differ in what is live are one state: 16 forks
+ * are not 2^16 states.
+ */
+SEC("socket")
+__description("maybe_fork_scalars: 16 forks in a block")
+__success __retval(0)
+__log_level(4)
+__msg("processed {{[0-9][0-9]?[0-9]?}} insns")
+__naked void and_scalar_16_forks_in_a_block(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_hash_8b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto l0_%=;"
+	"r9 = r0;"
+	FORK4 FORK4 FORK4 FORK4
+"l0_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+#undef FORK4
+#undef FORK
+
 /*
  * Last jump can be detected as always taken because the intersection of R5 and
  * R7 32bit tnums produces a constant that isn't within R7's s32 bounds.
diff --git a/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c b/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
new file mode 100644
index 000000000000..66d8a7c4a6a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
@@ -0,0 +1,670 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
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
+ *	ok = i < 8 && x == 2;
+ *	if (x == 7)
+ *		n++;
+ *	if (ok)
+ *		use(buf[i]);
+ * A compiler keeps ok in a register: "w6 &= 1; if w6 == 0". (ok = 0, i >= 8), (ok = 1, i < 8) and
+ * (ok = 0, i < 8) meet in front of "if (x == 7)". 0 and 1 leave no gap, and i < 8 comes with
+ * either. They are not joined when the jump that tells 0 from 1 ends this basic block or the next.
+ */
+#define FLAG_SET(max, no, yes)			\
+	"r1 = 0;"				\
+	"*(u64 *)(r10 - 8) = r1;"		\
+	"call %[bpf_get_prandom_u32];"		\
+	"r7 = r0;"				\
+	"call %[bpf_get_prandom_u32];"		\
+	"w6 = " #no ";"				\
+	"if r7 > " #max " goto +3;"		\
+	"w6 = " #yes ";"			\
+	"if r0 == 2 goto +1;"			\
+	"w6 = " #no ";"
+#define FLAG_USE(unless)				\
+	"if " #unless " goto +4;"		\
+	"r1 = r10;"				\
+	"r1 += -8;"				\
+	"r1 += r7;"				\
+	"r0 = *(u8 *)(r1 + 0);"
+#define FLAG_PROG(name, max, no, yes, rest)	\
+__naked void name(void)				\
+{						\
+	asm volatile (				\
+	FLAG_SET(max, no, yes)			\
+	rest					\
+	"exit;"					\
+	:: __imm(bpf_get_prandom_u32) : __clobber_all); \
+}
+
+SEC("socket")
+__description("jumps ahead: a flag, another jump, the test of the flag")
+__success
+FLAG_PROG(flag_next_block, 7, 0, 1, "if r0 != 7 goto +1; r0 = 0; w6 &= 1;" FLAG_USE(w6 == 0))
+
+SEC("socket")
+__description("jumps ahead: a flag that says too much")
+__failure __msg("invalid variable-offset read from stack R1")
+FLAG_PROG(flag_next_block_bad, 8, 0, 1, "if r0 != 7 goto +1; r0 = 0; w6 &= 1;" FLAG_USE(w6 == 0))
+
+/* "f = i < 8 ? in[i] : 0; ... if (f) use(buf[i]);" A compiler makes a flag of "f == 0" */
+SEC("socket")
+__description("jumps ahead: a flag that is 1 for no")
+__success
+FLAG_PROG(flag_for_no, 7, 1, 0, "if r0 != 7 goto +1; r0 = 0; w6 &= 1;" FLAG_USE(w6 != 0))
+
+SEC("socket")
+__description("jumps ahead: a flag is tested twice")
+__success
+FLAG_PROG(flag_twice, 7, 0, 1, FLAG_USE(w6 == 0) "r0 = 0;" FLAG_USE(w6 == 0))
+
+SEC("socket")
+__description("jumps ahead: the other value of a flag that is tested twice")
+__failure __msg("math between fp pointer and register with unbounded min value")
+FLAG_PROG(flag_twice_bad, 7, 0, 1, FLAG_USE(w6 == 0) "w6 ^= 1;" FLAG_USE(w6 == 0))
+
+SEC("socket")
+__description("jumps ahead: a flag is spilled, filled, copied and extended")
+__success
+FLAG_PROG(flag_moves, 7, 0, 1, "*(u64 *)(r10 - 16) = r6; r1 = *(u64 *)(r10 - 16);"
+			       "r2 = r1; r2 <<= 32; r2 >>= 32;" FLAG_USE(r2 == 0))
+
+/* if and else: two ends of basic blocks on every way to the test */
+SEC("socket")
+__description("jumps ahead: the test of a flag is too far")
+__success __log_level(2)
+__msg("from 8 to 10: joined")
+FLAG_PROG(flag_too_far, 7, 0, 1, "if r0 != 7 goto +2; r0 = 0; goto +1; r0 = 1;"
+				 "if w6 == 0 goto +1; r0 = 2;")
+
+SEC("socket")
+__description("jumps ahead: the jump tests another register than the flag")
+__success __log_level(2)
+__msg("from 8 to 10: joined")
+FLAG_PROG(flag_not_tested, 7, 0, 1, "if r0 == 1 goto +1; r0 = r6;")
+
+/* the first values of a counter */
+SEC("socket")
+__description("jumps ahead: 1 and 2 are no flag")
+__success __log_level(2)
+__msg("from 8 to 10: joined")
+FLAG_PROG(flag_1_and_2, 7, 1, 2, "if w6 == 1 goto +1; r0 = 0;")
+
+/*
+ * A register that is set in one state and not in the other: these states are not joined,
+ * whatever it is that tells them apart later.
+ */
+SEC("socket")
+__description("set or not: a register is set when a flag is 1, flag + 4 is tested")
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
+/* The first iteration sets r7 and the flag. The states meet at the head of the loop. */
+SEC("socket")
+__description("set or not: a loop sets a register and a flag")
+__success
+__naked void set_in_a_loop(void)
+{
+	asm volatile (
+	"r6 = 0;"
+"1:"
+	".8byte %[may_goto];"
+	"if r6 == 0 goto 2f;"
+	"r8 = r7;"
+"2:"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 = 1;"
+	"goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 6, 0))
+	: __clobber_all);
+}
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
+#define PICK_ANY(slot)					\
+	"call %[bpf_get_prandom_u32];"			\
+	"r0 <<= 32;"					\
+	"r7 = r0;"					\
+	"call %[bpf_get_prandom_u32];"			\
+	"r0 |= r7;"					\
+	"*(u64*)(r10 - " #slot ") = r0;"
+
+/*
+ * As in bpfj_jailer_free() of bpfjailer:
+ *	for (i = 0; i < 8; i++) {
+ *		p = a[i];
+ *		if (!p)
+ *			continue;
+ *		put(p);
+ *	}
+ * The jump finds out about a[i] too, which nothing looks at again. All of a[] is live while
+ * the loop goes on, because it is read through a pointer that moves. The states have to be
+ * joined behind the jump, or there are 2^8 of them. They are, because a slot that is filled
+ * through another register than r10 doesn't count as one that a jump ahead looks at.
+ */
+SEC("socket")
+__description("0 or not: an array on the stack that a loop goes through")
+__success __log_level(4)
+__msg("max_states_per_insn {{[0-9]}} total_states")
+__naked void array_of_nulls(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	PICK_ANY(8) PICK_ANY(16) PICK_ANY(24) PICK_ANY(32)
+	PICK_ANY(40) PICK_ANY(48) PICK_ANY(56) PICK_ANY(64)
+	"r8 = r10;"
+	"r8 += -64;"
+	"r7 = 0;"
+"1:"
+	"r1 = *(u64*)(r8 + 0);"
+	"if r1 == 0 goto 2f;"
+	"r6 += 1;"
+"2:"
+	"r8 += 8;"
+	"r7 += 1;"
+	"if r7 < 8 goto 1b;"
+	"r0 = r6;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/*
+ * As in xdp_synproxy_kern.c: hdr->ipv4 or hdr->ipv6 is there, the other one is 0.
+ *	if (hdr->ipv4) ... else if (hdr->ipv6) ...
+ * (0, x) and (y, 0) are not joined: (?, ?) has both, and r9 is not set.
+ */
+SEC("socket")
+__description("0 or not: one of two things is there")
+__success
+__naked void one_of_two(void)
+{
+	asm volatile (
+	PICK_ANY(8)
+	"r6 = r0;"
+	"r7 = 0;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r7 = r6;"
+	"r6 = 0;"
+"1:"
+	"r0 = 0;"
+	"if r6 == 0 goto 2f;"
+	"if r7 == 0 goto 2f;"
+	"r0 = r9;"
+"2:"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/*
+ * As in bpf_sock.o of cilium:
+ *	err = xlate();
+ *	if (err == -EHOSTUNREACH || err == -ENOMEM) {
+ *		bpf_set_retval(err);
+ *		return 0;
+ *	}
+ *	return 1;
+ * A compiler computes the condition where err is set. 0 and 1 touch, and it's not a jump that
+ * looks at err.
+ */
+SEC("cgroup/connect4")
+__description("jumps ahead: a flag goes together with what bpf_set_retval() takes")
+__success
+__naked void flag_and_retval(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"w8 = 0;"
+		"w1 = 1;"
+		"if r0 == 0 goto 1f;"
+		"w8 = 1;"
+		"w1 = -113;"
+	"1:"
+		"w0 = 1;"
+		"if w8 == 0 goto 2f;"
+		"call %[bpf_set_retval];"
+		"w0 = 0;"
+	"2:"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32), __imm(bpf_set_retval)
+		: __clobber_all
+	);
+}
+
+char buf[8];
+
+/* As in test_seg6_loop.c without 32-bit insns: the copy is tested, the original is used */
+SEC("socket")
+__description("jumps ahead: the jump looks at a copy that two shifts extend")
+__success
+__naked void extended_copy(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r8 = 0;"
+		"if r0 == 0 goto 1f;"
+		"r8 = 5;"
+	"1:"
+		"r7 = r8;"
+		"r7 <<= 32;"
+		"r7 >>= 32;"
+		"if r7 == 0 goto 2f;"
+		"r8 += -5;"
+		"r1 = %[buf] ll;"
+		"r1 += r8;"
+		"r0 = *(u8 *)(r1 + 0);"
+		"exit;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32), __imm_addr(buf)
+		: __clobber_all
+	);
+}
+
+static __naked __noinline __used __u64 index_or_minus_1(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 = r0;"
+		"r0 = 0xffffffff ll;"
+		"if r1 > 7 goto 1f;"
+		"r0 = r1;"
+	"1:"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/*
+ * As in profiler.inc.h without 32-bit insns:
+ *	int index = find();
+ *	if (index == -1)
+ *		return 0;
+ *	use(array[index]);
+ * The numbers meet at the exit of find(). -1 doesn't fit in the jump, it is in a register.
+ */
+SEC("socket")
+__description("jumps ahead: the caller looks at what the function returns")
+__success
+__naked void caller_looks(void)
+{
+	asm volatile (
+		"call index_or_minus_1;"
+		"r0 <<= 32;"
+		"r1 = r0;"
+		"r1 >>= 32;"
+		"r2 = 0xffffffff ll;"
+		"if r1 == r2 goto 1f;"
+		"r0 s>>= 32;"
+		"r1 = %[buf] ll;"
+		"r1 += r0;"
+		"r0 = *(u8 *)(r1 + 0);"
+		"exit;"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(buf)
+		: __clobber_all
+	);
+}
+
+/*
+ * A state that arrives is compared with the states that it may be related to. Its shape tells:
+ * the same pointers in the same places at the same constant offsets. These states are related
+ * and don't look alike. They have to find each other.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, char[48]);
+} shape_map SEC(".maps");
+
+/*
+ * 16 states with R9 at 16 places of the stack get to "1:". With that many states at an insn
+ * their shapes are looked at. Then comes one more, which @last makes of the 16th. The two are
+ * related and don't have the same shape.
+ */
+#define SHAPE_16_PLACES	"8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,128"
+#define SHAPE_MANY(first, last, use)					\
+	asm volatile (							\
+		first							\
+		"r1 = 0;"						\
+		".irp off," SHAPE_16_PLACES ";"				\
+		"*(u64 *)(r10 - \\off) = r1;"				\
+		".endr;"						\
+		"call %[bpf_get_prandom_u32];"				\
+		"r6 = r0;"						\
+		"call %[bpf_get_prandom_u32];"				\
+		"r7 = r0;"						\
+		"r7 &= 1;"						\
+		".irp off," SHAPE_16_PLACES ";"				\
+		"r9 = r10;"						\
+		"r9 += -\\off;"						\
+		"if r6 == \\off goto 1f;"				\
+		".endr;"						\
+		last							\
+	"1:"								\
+		use							\
+		"r0 = *(u64 *)(r9 + 0);"				\
+	"2:"								\
+		"r0 = 0;"						\
+		"exit;"							\
+		:							\
+		: __imm(bpf_get_prandom_u32), __imm(bpf_map_lookup_elem),	\
+		  __imm_addr(shape_map),				\
+		  __imm_const(data, offsetof(struct __sk_buff, data)),	\
+		  __imm_const(data_end, offsetof(struct __sk_buff, data_end))	\
+		: __clobber_all						\
+	)
+
+SEC("socket")
+__description("shape: nothing in a register stands for a pointer")
+__success __log_level(2)
+__msg("processed 135 insns")
+__naked void shape_unset(void)
+{
+	SHAPE_MANY("",
+		   "r8 = r10;",
+		   "if r7 < 2 goto +1;"
+		   "r0 = *(u64 *)(r8 - 8);");
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
index aba9510a1c08..5a4a29b30b7a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
@@ -2,11 +2,59 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
+/*
+ * A size that has to be a known constant is one of two constants, and a compiler makes one call
+ * of the two. The constants must not be joined on the way to the call.
+ */
+SEC("?tc")
+__description("one of two constants: __szk, the header of IPv4 or of IPv6")
+__success
+int dynptr_slice_two_sizes(struct __sk_buff *skb)
+{
+	char buf[sizeof(struct ipv6hdr)];
+	__u32 sz = sizeof(struct iphdr);
+	struct bpf_dynptr dptr;
+	__u8 *p;
+
+	bpf_dynptr_from_skb(skb, 0, &dptr);
+
+	if (skb->protocol != bpf_htons(0x0800))
+		sz = sizeof(struct ipv6hdr);
+	p = bpf_dynptr_slice(&dptr, 14, buf, sz);
+	if (p)
+		return p[0] >> 4;
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+SEC("?tc")
+__description("one of two constants: the size of bpf_ringbuf_reserve()")
+__success
+int ringbuf_reserve_two_sizes(struct __sk_buff *skb)
+{
+	__u32 sz = 8;
+	char *p;
+
+	if (skb->len > 100)
+		sz = 16;
+	p = bpf_ringbuf_reserve(&ringbuf, sz, 0);
+	if (!p)
+		return 0;
+	p[7] = 1;
+	bpf_ringbuf_discard(p, 0);
+	return 0;
+}
+
 /* The __szk size of a kfunc memory/size pair when the nullable buffer is passed as NULL */
 SEC("?tc")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_ptr_off.c b/tools/testing/selftests/bpf/progs/verifier_ptr_off.c
new file mode 100644
index 000000000000..260f7ea50b9f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ptr_off.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/* One of two constants is added to a pointer. A compiler makes one add and one load of it. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+
+struct with_timer {
+	int before[4];
+	struct bpf_timer timer;
+	int after[4];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct with_timer);
+} timers SEC(".maps");
+
+__u64 in_bss[8];
+
+#define __imm_pkt								\
+	__imm_const(data, offsetof(struct __sk_buff, data)),			\
+	__imm_const(data_end, offsetof(struct __sk_buff, data_end))
+
+/*
+ *	len = v6 ? 40 : 20;
+ *	if (data + len > data_end) return 0;
+ *	if (v6) use(data[39]);
+ * 1 and 2 touch, so nothing else keeps the states apart.
+ */
+SEC("tc")
+__description("offset of a pointer: the length of a header goes with its kind")
+__success __retval(0)
+__naked void pkt_len_and_kind(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"r8 = 1;"
+	"r9 = 20;"
+	"if r0 == 0 goto 1f;"
+	"r8 = 2;"
+	"r9 = 40;"
+"1:	r1 = *(u32 *)(r6 + %[data]);"
+	"r3 = *(u32 *)(r6 + %[data_end]);"
+	"r2 = r1;"
+	"r2 += r9;"
+	"if r2 > r3 goto 2f;"
+	"if r8 != 2 goto 2f;"
+	"r0 = *(u8 *)(r1 + 39);"
+"2:	r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32), __imm_pkt
+	: __clobber_all);
+}
+
+/* The same with c->skb->data: the context comes out of a struct on the stack */
+SEC("tc")
+__description("offset of a pointer: the packet of a context that was in a struct")
+__success __retval(0)
+__naked void pkt_of_ctx_in_struct(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = r1;"
+	"r7 = r10;"
+	"r7 += -8;"
+	"call %[bpf_get_prandom_u32];"
+	"r8 = 1;"
+	"r9 = 20;"
+	"if r0 == 0 goto 1f;"
+	"r8 = 2;"
+	"r9 = 40;"
+"1:	r6 = *(u64 *)(r7 + 0);"
+	"r1 = *(u32 *)(r6 + %[data]);"
+	"r3 = *(u32 *)(r6 + %[data_end]);"
+	"r2 = r1;"
+	"r2 += r9;"
+	"if r2 > r3 goto 2f;"
+	"if r8 != 2 goto 2f;"
+	"r0 = *(u8 *)(r1 + 39);"
+"2:	r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32), __imm_pkt
+	: __clobber_all);
+}
+
+/* data - 1 or data + 30000. A range of the two plus 1 would vouch for 30001 bytes behind data. */
+SEC("tc")
+__description("offset of a pointer: one of two places, none of them in the packet")
+__failure __msg("invalid access to packet, off=30000 size=1, R1(id=0,off=30000,r=0)")
+__naked void pkt_two_places(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 = *(u32 *)(r6 + %[data]);"
+	"r3 = *(u32 *)(r6 + %[data_end]);"
+	"r2 = r1;"
+	"if r0 == 0 goto 1f;"
+	"r2 += 30000;"
+	"goto 2f;"
+"1:	r2 += -1;"
+"2:	r2 += 1;"
+	"if r2 > r3 goto 3f;"
+	"r0 = *(u8 *)(r1 + 30000);"
+"3:	r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32), __imm_pkt
+	: __clobber_all);
+}
+
+/* A range of offsets would go over the timer */
+SEC("socket")
+__description("offset of a pointer: in front of a timer or behind it")
+__success __retval(0)
+__naked void around_timer(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"r1 = %[timers] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 = %[before];"
+	"if r0 == 0 goto 1f;"
+	"r1 = %[after];"
+"1:	r6 += r1;"
+	"r0 = *(u32 *)(r6 + 0);"
+"2:	r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32), __imm(bpf_map_lookup_elem), __imm_addr(timers),
+	  __imm_const(before, offsetof(struct with_timer, before[3])),
+	  __imm_const(after, offsetof(struct with_timer, after[0]))
+	: __clobber_all);
+}
+
+/* Nothing looks at the offset but for its ends: the states are joined */
+SEC("socket")
+__description("offset of a pointer: a map value that holds nothing but numbers")
+__success __retval(0) __log_level(2)
+__msg("from 4 to 5: R1=scalar({{.*}}smin32=umin32=8,smax=umax=smax32=umax32=48{{.*}}) R10=fp0")
+__msg("max_states_per_insn 1 ")
+__naked void plain_value(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = 8;"
+	"r2 = 0;"
+	"if r0 == 0 goto 1f;"
+	"r1 = 48;"
+"1:	r6 = %[in_bss] ll;"
+	"r6 += r1;"
+	"r0 = *(u64 *)(r6 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32), __imm_addr(in_bss)
+	: __clobber_all);
+}
+
+const volatile struct {
+	int size;
+	int kind;
+} cfgs[2] = { { 8, 1 }, { 32, 2 } };
+
+/* What is at a known offset of a read-only map is known */
+SEC("tc")
+__description("offset of a pointer: one of two elements of a read-only map")
+__success
+int size_of_two(struct __sk_buff *skb)
+{
+	char buf[32];
+
+	return bpf_skb_load_bytes(skb, 0, buf, (skb->mark ? &cfgs[0] : &cfgs[1])->size);
+}
+
+/* The prototypes of the two kfuncs say void *. The verifier makes a pointer to a struct of it. */
+SEC("tc")
+__description("offset of a pointer: one of two fields behind bpf_core_cast()")
+__success
+int field_behind_core_cast(struct __sk_buff *skb)
+{
+	struct task_struct *task = bpf_core_cast((void *)bpf_get_current_task(), struct task_struct);
+
+	return skb->mark ? task->pid : task->tgid;
+}
+
+SEC("tc")
+__description("offset of a pointer: one of two fields behind bpf_cast_to_kern_ctx()")
+__success
+int field_behind_kern_ctx(struct __sk_buff *ctx)
+{
+	struct sk_buff *skb = bpf_cast_to_kern_ctx(ctx);
+
+	return ctx->mark ? skb->len : skb->data_len;
+}
+
+static __naked __noinline __used void random(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Two states enter the loop, one with each offset. r9 is not what it was when they come around.
+ * Each of them is joined with the state at the head of the loop that it comes from.
+ */
+SEC("tp_btf/sched_switch")
+__description("offset of a pointer: two offsets enter a loop")
+__success
+__naked void two_offsets_in_a_loop(void)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r1 + 8);"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = %[pid];"
+	"if r0 == 0 goto 1f;"
+	"r7 = %[tgid];"
+"1:	r9 = 0;"
+"2:	if r9 == 7 goto 3f;"
+	"r1 = r6;"
+	"r1 += r7;"
+	"r0 = *(u32 *)(r1 + 0);"
+	"call random;"
+	"r9 = r0;"
+	"goto 2b;"
+"3:	r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(pid, offsetof(struct task_struct, pid)),
+	  __imm_const(tgid, offsetof(struct task_struct, tgid))
+	: __clobber_all);
+}
+
+/* The offset is what changes in the loop: it's forgotten, and the loop ends */
+SEC("tc")
+__description("offset of a pointer: the offset changes in a loop")
+__success
+__naked void offset_changes_in_a_loop(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r7 = 0;"
+"1:	r1 = *(u32 *)(r6 + %[data]);"
+	"r2 = *(u32 *)(r6 + %[data_end]);"
+	"r7 &= 0xff;"
+	"r1 += r7;"
+	"r3 = r1;"
+	"r3 += 4;"
+	"if r3 > r2 goto 2f;"
+	"r0 = *(u32 *)(r1 + 0);"
+"2:	call %[bpf_get_prandom_u32];"
+	"r7 += 3;"
+	"if r0 != 7 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32), __imm_pkt
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index d92215c5b923..4cfdedca8890 100644
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
@@ -310,6 +317,202 @@ __naked void stack_write_clobbers_spilled_regs(void)
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
+	r8 = 1;						\
+	if r0 > 100 goto l0_%=;				\
+	r7 = 8;						\
+	r8 = 2;						\
+l0_%=:	r2 = r10;					\
+	r2 += -24;					\
+	r2 += r7;					\
+	*(u64*)(r2 + 0) = r6;				\
+	if r8 != 1 goto l1_%=;				\
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
+SEC("tc")
+__description("depth of a stack on the stack: no bound")
+__failure __msg("invalid write to stack R2 off=0 size=1")
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
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_iter_num_new(0, 0, 0);
+	bpf_iter_num_next(0);
+	bpf_iter_num_destroy(0);
+}
+
 SEC("sockops")
 __description("indirect variable-offset stack access, unbounded")
 __failure __msg("invalid unbounded variable-offset write to stack R4")
-- 
2.55.0

