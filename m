Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E098438026
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432477; cv=none; b=cgE+91RfSdbXTV7QXdDEttxM/40BQUr6skphB2OUMUIzGntvBsNz6V1EKUHizkURKIvO/2ZgbuYTHquX/WCuOgW6CTaryddAZzc07vsN10ic4vuEM7Y3nCo5qLAnNjHHwzqThl8RUwAv4WNUVL6usR/165NGtqWywY7ndFiuEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432477; c=relaxed/simple;
	bh=5TTlv4/VvsPncIUAym/9dxV8Lw9ZSwExPaMCp3sBrfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBjoN74q4NSzFR+pU8In4LZsOshYwMPaSDxoOZhM4qk8nly9Jvxx6zXF1WlPzdiPZJvoYBtCFiSaSX8BfBu6vBANZSzm2/4njxgY/RssCx86WQfBVes3d7tI7/2NEFnDUm3r34U2sSSq0CQKdm2css/Z+gWTvwgQkfp/iHYudUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3037lu3; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3037lu3"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so956003a91.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432475; x=1791037275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CDvbzcUUtNn3x1k8DnXxAqU9+2+p5OeX8rEpc+Y9ekY=;
        b=G3037lu3HjOBjQ+rXTxXTl6xkTYYQ8joRsz+tP+jMJGnudpT1O3NwMx9TioRTvhv3I
         sV+hTuUZp0cvtyW0707gcpbltReudsVF5/3UtB8KgkZb4GRFf7izK5f6xHTWnwMCCmSu
         KgXk3YFDAWkS7Bu9KacNFuCR2KajfAl6GuzoWaQGmZl/JFogZYRAMRyrt7+ud/DuCCbV
         8EDXlZAxOtCL94hcMAmblDL9nOMSQOmgGnTVlxfJx+KP0giO9XAdLVAQIFQHJxNCmCei
         mmdx/TdLvJTqwpQB8gpnWkDvPvSDw0wcLGiliuDyMfxBwpP6CH46nFm6jPPxusKhkuLS
         PX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432475; x=1791037275;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDvbzcUUtNn3x1k8DnXxAqU9+2+p5OeX8rEpc+Y9ekY=;
        b=1asngBESzbrbG5zY+J1yXYAjA938wsoTGwWcsdTXfZLDibK+vsdz744EXk4LGibcGV
         kmNRF2pBreQD7VbaHYZ71PPEXuCbeMQMwt/Lg7a20BQuS/bZRBeW3OelS2E4NFb8Qmao
         8bDGaVGz76mS1MHzoGGCA4bWsOiF9NWR/e8RygQmTEE1bOIW75AsdU4D/GauRYgtp5Ha
         p1G3PinH17PEVRvFj+fIGEmSZ5UNqRepXTdd7H9ENYl5mO5KTkYBZTOqYAiT5LLXvNNv
         6Ov19qzZY0KLtTTHAZzPwf6o+cLIMlWWBNeliqUyULN8SRYC1Ai1paooPOxirqlv6LKR
         C/cQ==
X-Gm-Message-State: AFq9FYI2lP14VTXbEc1eew5qcK6LuGWQdC3pcYS9Pm59vDMaNsVitFdg
	d69NeEBsCuOZTruv9+35EF5zNwRHqaeec/iqwXxmzSlKZw2gE6gVaLXrhea26MkM+RI=
X-Gm-Gg: AYBFou0KGgnvTyiSyUryh5UC2huS/dTE0FdSx6M4olIuWhAkZDQBPzvoUCoNEzZlGGe
	CSalzegVhCcdNj4/b+lLSqoBbWnXCKiHhprJbpYeMdWDJqcoHaLvCK6ygAN8XK49lsTxoBJO8xk
	KydclJisydYPL0bf6bNik1Z3gMKNe/fNTNNzFQPfVi6BvoVPrCGw3ck6s81DCpjbaWNI4zBO6hM
	19H55wxtttGi5Tsss91+Khs+jLz9PPy5LI9G/O+Q13BXo5lJOXDh2mLtzCVMA7faFmZEgw6Dt78
	cZ6N33SNZ/L8Vfaf9q811srFpNRKHNPyiMK+y1xv7iYnII/bV21QYGwyKvbkqRdy74r847s+uOy
	3mGAd35+crqfJt055p5LWh5H5VK7wuqhFCbfFiDPYxw/JN1M+nFY96wXpZeleDU/R9iF67G94LS
	GNilv0rg8rX8MdJJ13WyrpO8s95+TOP/i2UtCXU03nBdXRvf/8lhThRM+d2hJW6NhOXV8L8piyl
	8ykZIkqAt/OqMh0i04gJuSPbnGJA3avo8ZqNZaoww==
X-Received: by 2002:a17:90b:1c84:b0:39e:6a81:5a94 with SMTP id 98e67ed59e1d1-3a098e39a55mr7051188a91.40.1790432474747;
        Sat, 26 Sep 2026 07:21:14 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:14 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 31/36] selftests/bpf: tests for register base/step arithmetic
Date: Sat, 26 Sep 2026 07:20:29 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-31-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

- step_mul_non_pow2: Retain step 3 after multiplying a bounded scalar
  by a non-power-of-two constant.
- step_lsh: Record step 4 after shifting a bounded scalar left by two.
- step_add_const_base: Shift the base to 1 while preserving step 4
  after adding a constant.
- step_neg_value_range: Preserve the signed range of {-3, 0, 3, 6}
  when intersecting with a non-power-of-two step across zero.
- step_neg_value_sound: Reject a reachable invalid access that would
  be hidden by incorrectly narrowing that range's upper bound to 4.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_bounds_step.c     | 124 +++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8a6d341b754a..e1d559ba1271 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -19,6 +19,7 @@
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
 #include "verifier_bounds.skel.h"
+#include "verifier_bounds_step.skel.h"
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
@@ -203,6 +204,7 @@ void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
+void test_verifier_bounds_step(void)          { RUN(verifier_bounds_step); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
new file mode 100644
index 000000000000..a8358b625ce7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * Tests for the linear "base + step * k" description tracked per scalar
+ * register.
+ *
+ * The base/step computed by scalar arithmetic is observed directly in the
+ * level-2 register dump, printed as "step=<base>+<step>" when the register is
+ * not the trivial base=0, step=1. Range inference that depends on the line
+ * (e.g. a sign-crossing range with a non-power-of-2 step) is checked via the
+ * resulting smin/smax, which feed ordinary signed branch decisions.
+ *
+ * Note: eq/neq branch checks do not consult base/step, so impossible-value
+ * pruning is intentionally not relied upon here; the register dump is the
+ * reliable signal.
+ */
+
+/* a &= 0xff; a *= 3  =>  multiples of 3, step=0+3 (not representable as tnum) */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 *= 3 {{.*}}step=0+3)")
+__naked void step_mul_non_pow2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r0 *= 3;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* a &= 0xff; a <<= 2  =>  step=0+4 */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 <<= 2 {{.*}}step=0+4)")
+__naked void step_lsh(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r0 <<= 2;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* a &= 0xff; a *= 4; a += 1  =>  base shifts to 1, step=1+4 */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 += 1 {{.*}}step=1+4)")
+__naked void step_add_const_base(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r0 *= 4;					\
+	r0 += 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Sign-crossing range with a non-power-of-2 step. After "*= 3; += -3" the value
+ * set is {-3, 0, 3, 6}. The line description is tracked in signed space, so the
+ * intersection keeps smax=6. A u64-modular intersection would mis-place the
+ * line for the negative values and wrongly narrow smax to 4.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 += -3 {{.*}}smax=smax32=6)")
+__naked void step_neg_value_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 3;					\
+	r0 *= 3;					\
+	r0 += -3;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Same {-3, 0, 3, 6} value set: 6 is reachable, so "if r0 s> 4" can be taken
+ * and the illegal scalar dereference behind it must be rejected. Guards against
+ * the unsound narrowing (smax=4) that would prune the branch and accept the
+ * program. This rides on the signed comparison, which uses smin/smax.
+ */
+SEC("socket")
+__failure __msg("invalid mem access 'scalar'")
+__naked void step_neg_value_sound(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 3;					\
+	r0 *= 3;					\
+	r0 += -3;					\
+	if r0 s> 4 goto l_bad_%=;			\
+	r0 = 0;						\
+	exit;						\
+l_bad_%=:						\
+	r1 = *(u8 *)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.55.0
