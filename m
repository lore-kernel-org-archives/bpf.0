Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF444317D
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680856; cv=none; b=ZPZzkuCxnBPdZWi6fXS4ldmqOFuFPaCtSM5BUvBgq2vzEoIUCiDvmvbZIPRw1QelaxevWd1wTX7jYMpBVlgMjprzMdfVL8asN0YoAETl85X+28f7WN43AlZRLMsRhGAQhjx+06i2RHB1ILOft1j42/x0JZxsYpJ0fOVJOBoLfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680856; c=relaxed/simple;
	bh=DFzEof505OaO9ntKSvhTKY2SzlOUkeAgsiNNDd7k6aY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dq1SWBiGfpQva/H/yh/yWrpvsB42f9+A/1hHqj5k+VFHdPOr3JaywC9O/pItc6qQqOoNWxN4wYaT5TlWpK5ifQXQYt3nZCcfzQyNJthQTCuO08LOO0uSW7fM7xPFsmhAiLgWfYnLFLTeHgZ3fTjH9IaKMMkSgISsbttSPcb6xBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+pW3UN0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+pW3UN0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba840146so1179115e9.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775680854; x=1776285654; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7bTGXl3wwzVOK9QazImnpebR0N7CfiWXg62GhNteVQ=;
        b=U+pW3UN0yFD8BZ95kuqFfFRIHlmWJAs80+wQoOFt33sSmIdaBFmmCbUyvT7kjLszeM
         Rzo/KypMAhs736x3i85rIeZCYP9iU2BPpFuWY4VOo64xs1oEaud7TCUmcpZXvPs2JCSM
         MPwx1gatRmDjk9NaLPZEbc6rSVqClEd8uZQ62++BHuVwlZpUNsRTF+56jI0Slchmdcsy
         ctoZgBUskOu+JlIlN/vYZ8AIsmmx2ZxX99qvMMj8Kw+cjbpEmYqkUnODi1hEYmJIfEV+
         z3vvGtRcbhEs/Xt2BYWhCcCh6E8+LW6GHQRtSiF6wHY1ixOEhVXZQcY+ubJsto/7jJ8Z
         0WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775680854; x=1776285654;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7bTGXl3wwzVOK9QazImnpebR0N7CfiWXg62GhNteVQ=;
        b=pzzadbbYZoW5n6oHnuyUSJ7JT65NMC2v2CI12tS8ShT+u9AJhRKsIln0Lazkkp/m3k
         fBvN5FanQfFkRkH9AXAggdSONlVfN+nJ39xlRAT0pbyXaSuj9G+BI/vhvasu00E6tcGn
         VcmlZbWjBOa6yln622cVmTKRNovgbbXnvdmpV6ZnF89/4UDoXHl1jXm8Ti25sqSh6A0t
         mOCbfUAb7o071HI0oi2b9NYv8HisPgJhXZCTjw60zx+Lh/WoMCvGZ/CyWyNJzozgCvH3
         BwLXcRh8Exmgbi/UFjGz7q3ZfARqTFpfKQHQNcVg6F88FU6LQfjWpEtoWI/OwFgoVzlD
         PucA==
X-Gm-Message-State: AOJu0YwQ+vZAAWx2U1/GNiwFE0L7WrwTsv5neHyIUgpHRpx8DsxNWueu
	n+ePEBT04fss9+8EGHfzE31W3kIR6PxvSIIs9JlU4c7FF8sOHmO4MKFFB7A6d71I
X-Gm-Gg: AeBDieutW+opeLbKT/Z9y6pip6snwDzgDA3MJ0uqQoTc56gylfAHU43+Up4xkw5XzZr
	vPrJ3RdB9mWfIkbRFGbNMk3NBFOWBWq2dDXZa8KgDi8+X7vMIaB0wr7wGn7Uf927QBkbBAWyAlc
	Qzeau3cyzBflFjTbWd8c5lvQgzxakW2iaz5JtVS1V+dcFZHAgtmamYfzpXK9egXPpxPbLP2hMDK
	EcvLO4qc1qVdd8er/OHqF8POCC/UdDWvyoleXmG8ZwVtBUGboB9PDZdjJnhbyoQNhLvM2Wsmk6z
	N9CPUkztWLzKFR0YesKpEQlIs5h107Bu+lxmLbeivvACtH83TLrixBVPlL18nnXngEa5GkB4nCh
	Cd4TBy/naAL/zZV81OfpKTRNMydqXSYr6AjS4fJH0PViY5TauizX7Zk8lycH8l7k8xzeMIwjuOI
	I4MlT/DyPY27wATsA9SRMGLB8DGojUzLwbk5SkT3NKHgAYbjw81jzHDbpDsFFKfkQTrS8Ypb82h
	+W3cYTftvPoruryivji0pFAQs8GmpDC/0L88dY+cKkhLh5IN3HlWKpkHE0hVAb3uTFzTgmXnCkr
	cmzKbGg/4PMv0Fk/0p/yvIIxdI8VIdERN4GvEpTLRg==
X-Received: by 2002:a05:600c:1e0f:b0:488:c120:480a with SMTP id 5b1f17b1804b1-488cd01b803mr16166625e9.31.1775680853304;
        Wed, 08 Apr 2026 13:40:53 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00037c778b43d13a98.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:37c:778b:43d1:3a98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd17bbe1sm5374125e9.17.2026.04.08.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:40:52 -0700 (PDT)
Date: Wed, 8 Apr 2026 22:40:50 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix reg_bounds to match new
 tnum-based refinement
Message-ID: <ada9UuSQi2SE2IfB@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit efc11a667878 ("bpf: Improve bounds when tnum has a single
possible value") improved the bounds refinement to detect when the tnum
and u64 range overlap in a single value (and the bounds can thus be set
to that value).

Eduard then noticed that it broke the slow-mode reg_bounds selftests
because they don't have an equivalent logic and are therefore unable to
refine the bounds as much as the verifier. The following test case
illustrates this.

  ACTUAL   TRUE1:  scalar(u64=0xffffffff00000000,u32=0,s64=0xffffffff00000000,s32=0)
  EXPECTED TRUE1:  scalar(u64=[0xfffffffe00000001; 0xffffffff00000000],u32=0,s64=[0xfffffffe00000001; 0xffffffff00000000],s32=0)
  [...]
  #323/1007 reg_bounds_gen_consts_s64_s32/(s64)[0xfffffffe00000001; 0xffffffff00000000] (s32)<op> S64_MIN:FAIL

with the verifier logs:

  [...]
  19: w0 = w6                 ; R0=scalar(smin=0,smax=umax=0xffffffff,
                                          var_off=(0x0; 0xffffffff))
                                R6=scalar(smin=0xfffffffe00000001,smax=0xffffffff00000000,
                                          umin=0xfffffffe00000001,umax=0xffffffff00000000,
                                          var_off=(0xfffffffe00000000; 0x1ffffffff))
  20: w0 = w7                 ; R0=0 R7=0x8000000000000000
  21: if w6 == w7 goto pc+3
  [...]
  from 21 to 25: [...]
  25: w0 = w6                 ; R0=0 R6=0xffffffff00000000
                              ;         ^
                              ;         unexpected refined value
  26: w0 = w7                 ; R0=0 R7=0x8000000000000000
  27: exit

When w6 == w7 is true, the verifier can deduce that the R6's tnum is
equal to (0xfffffffe00000000; 0x100000000) and then use that information
to refine the bounds: the tnum only overlap with the u64 range in
0xffffffff00000000. The reg_bounds selftest doesn't know about tnums
and therefore fails to perform the same refinement.

This issue happens when the tnum carries information that cannot be
represented in the ranges, as otherwise the selftest could reach the
same refined value using just the ranges. The tnum thus needs to
represent non-contiguous values (ex., R6's tnum above, after the
condition). The only way this can happen in the reg_bounds selftest is
at the boundary between the 32 and 64bit ranges. We therefore only need
to handle that case.

This patch fixes the selftest refinement logic by checking if the u32
and u64 ranges overlap in a single value. If so, the ranges can be set
to that value. We need to handle two cases: either they overlap in
umin64...

  u64 values
  matching u32 range:     xxx        xxx        xxx        xxx
                      |--------------------------------------|
  u64 range:          0                xxxxx                 UMAX64

or in umax64:

  u64 values
  matching u32 range:     xxx        xxx        xxx        xxx
                      |--------------------------------------|
  u64 range:          0          xxxxx                       UMAX64

To detect the first case, we decrease umax64 to the maximum value that
matches the u32 range. If that happens to be umin64, then umin64 is the
only overlap. We proceed similarly for the second case, increasing
umin64 to the minimum value that matches the u32 range.

Note this is similar to how the verifier handles the general case using
tnum, but we don't need to care about a single-value overlap in the
middle of the range. That case is not possible when comparing two
ranges.

This patch also adds two test cases reproducing this bug as part of the
normal test runs (without SLOW_TESTS=1).

Fixes: efc11a667878 ("bpf: Improve bounds when tnum has a single possible value")
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Closes: https://lore.kernel.org/bpf/4e6dd64a162b3cab3635706ae6abfdd0be4db5db.camel@gmail.com/
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 569ae09bdd76..71f5240cc5b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -500,6 +500,39 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 	    (s64)x.a >= S32_MIN && (s64)x.b <= S32_MAX)
 		return range_intersection(x_t, x, y_cast);
 
+	if (y_t == U32 && x_t == U64) {
+		u64 xmin_swap, xmax_swap, xmin_lower32, xmax_lower32;
+
+		xmin_lower32 = x.a & 0xffffffff;
+		xmax_lower32 = x.b & 0xffffffff;
+		if (xmin_lower32 < y.a || xmin_lower32 > y.b) {
+			/* The 32 lower bits of the umin64 are outside the u32
+			 * range. Let's update umin64 to match the u32 range.
+			 * We want to *increase* the umin64 to the *minimum*
+			 * value that matches the u32 range.
+			 */
+			xmin_swap = swap_low32(x.a, y.a);
+			/* We should always only increase the minimum, so if
+			 * the new value is lower than before, we need to
+			 * increase the 32 upper bits by 1.
+			 */
+			if (xmin_swap < x.a)
+				xmin_swap += 0x100000000;
+			if (xmin_swap == x.b)
+				return range(x_t, x.b, x.b);
+		} else if (xmax_lower32 < y.a || xmax_lower32 > y.b) {
+			/* Same for the umax64, but we want to *decrease*
+			 * umax64 to the *maximum* value that matches the u32
+			 * range.
+			 */
+			xmax_swap = swap_low32(x.b, y.b);
+			if (xmax_swap > x.b)
+				xmax_swap -= 0x100000000;
+			if (xmax_swap == x.a)
+				return range(x_t, x.a, x.a);
+		}
+	}
+
 	/* the case when new range knowledge, *y*, is a 32-bit subregister
 	 * range, while previous range knowledge, *x*, is a full register
 	 * 64-bit range, needs special treatment to take into account upper 32
@@ -2145,6 +2178,8 @@ static struct subtest_case crafted_cases[] = {
 	{U64, S64, {0x7fffffff00000001ULL, 0xffffffff00000000ULL}, {0, 0}},
 	{U64, S64, {0, 0xffffffffULL}, {1, 1}},
 	{U64, S64, {0, 0xffffffffULL}, {0x7fffffff, 0x7fffffff}},
+	{U64, S32, {0xfffffffe00000001, 0xffffffff00000000}, {S64_MIN, S64_MIN}},
+	{U64, U32, {0xfffffffe00000000, U64_MAX - 1}, {U64_MAX, U64_MAX}},
 
 	{U64, U32, {0, 0x100000000}, {0, 0}},
 	{U64, U32, {0xfffffffe, 0x300000000}, {0x80000000, 0x80000000}},
-- 
2.43.0

