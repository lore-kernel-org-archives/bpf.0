Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68B3EDAA2
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142774; cv=none; b=Xxac4fNLiiBEJZHAMLfTB1N2bc+VOwh/pmPq/NOzmb50WZXu9/K8zrcTvDWv/+scJZrM2pHYZQ/Ehe08Lc5ZgkuT2Va34iA0E4lbrImTKYXQYnEkTsymjK4doWyzA5BBTOVit9D/SUDZBebq5FeaIYVu38FtVxPXcfKIZIrhvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142774; c=relaxed/simple;
	bh=Q25svoyuZcoygN8An/Ds28gnMlMRFYaYF9np9jwUxlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7A1DmzMHjgsMrNKzFOMpKkDY5YYAIwIDtvLWQEBfuq5IchkbIplYjFk6H3kwcjQ9Ik7OFgPYRpwz4oSlH24degK0Vko+qMM2TYBV/kX6qDWkigj1dEzPWrYP/Ql5ZBuEEvUhepOq1vMVcJwUzUTdn4A3bGoKscdM475S50zUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osiR8CNb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osiR8CNb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso668658f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142771; x=1775747571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kXFvuo8RzvGG5MQ5BeeEJjjmN2FW2PH1eE4LFQGhj5U=;
        b=osiR8CNbrhqZ74Oti8tHVQOJoblBttqtWpI+U0AEcdQ1dqiQxy3PsGVvU0I2fcuNpR
         ryqkBICQyCjac4IT03c+b8OIyXNTkjVb05Osdc0kuh0Qx09zQFS4/yuN2C2za6DeEfer
         C+tIf/iXEWcahBQSBCUyOGfGZI3Ynu+rFsesYPQXw0VCsol/sDXdKkwlu9dO/atSWQZi
         QL8bd+nvlEnsz0ZmRpHciqarzp8/o1e4gK+yZpaJA+dH9rQCOuGPdK7NClgtdBawRaaY
         TQTw3PF/mV4zNuK+lgs60ovZM3TBpgmWTrvUAtK4NuqV5etrqkR5omHf69Y3zf51hQ8g
         Uggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142771; x=1775747571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXFvuo8RzvGG5MQ5BeeEJjjmN2FW2PH1eE4LFQGhj5U=;
        b=coDM+kKri+zz+89QvM6N7bXlxGHUYlpuTs+C+XYZrNZ7V4JLjlaGX2bpjEzydJ+pMR
         Q5GKUtQ/xB69U+yRoFDv3licCxjUVx2xFVSoTRHmCpJsQvoJZLNo91JG9/BkmE5kgVri
         7dFmssNEu2XG2O3qH3RLSoW08xeR6sUOnwsRoaD3mCJ98zDiy8XH6p0pn5Lmm3uWSQSb
         qvjfrUA68KMkuOdMwHk3jVzYq/CZwZTxfqFHH+sp3Af7XyQ/deLwBTJ44CjXxMKib4Q0
         JppDQ4gE5YfTmVo6b6pPz6z04whxllw78VnAGC0LUME2wWWbUjHJdVnoPo6/6ij6AWNT
         c3Hg==
X-Gm-Message-State: AOJu0YxrXJrTUm7czE8fN1JkQ7PYyfR6dTdVuYeoePPitdGV/3SQVWWk
	xhS/k9PRT1t/BgQbzs9QHQsme8ZeVAXuKvP3s8njz08BiivOiLWCmNctp8SCa2O2
X-Gm-Gg: AeBDies3lsAIxdDukkpybb4HVv+d0KHrfUxQhT4XkbE+XTU8k6HoccLSsB/kBTll/8i
	nykW85e3Go+cSQiDeMIKG+ffJt0nmLfARWAwSDvAWPd993nRf2/Z6/1G/j7ovxjGe+WEYFYewOF
	ooMIrv94m436gxuay4ebrz1umuLO0J3MadZPSDSDk/4JU3LsdVbtB8YVRaMLtNEglwhyz4x0HPN
	GHQR1eYi4AFSZWF2+psgc91v/soSTVnRgYj/o62RYeB+ia3ukI8XjTb4OtTKkAI76arVmg9wzPC
	c8CfSAhTibdDA6OR+jXvCQOeF/y3zJ7rmUCAQFlNct1bgZRpH/cgJq9eNZoC+Do3O3NsoMMiO2/
	praIn7gXIyapy9/t3TqAah9mJnCOSZpOWISvuEH3SX2eGS9hQqsib3Cpa8FGabW7lMq8e4hACj3
	ySYSE5rEMImJtGiCLzO4MtbvYMB2s0jSVU4kIy1sBp27SRr/OwnguVx7+1VwPcR/qTDYaOCjDOX
	G12d75Us4UO4gWp1ReREChebZ6h3vZmiOGAAR8EK8lTKNDckHwHhUJWILLcr0rrWVywACc9KT+q
	qxr1uE4u46KQIUkiujCddtxsLCHC7mZBp9bVW2svZ+RFZy9DzBXeTg==
X-Received: by 2002:a05:6000:3112:b0:43b:80a0:d92 with SMTP id ffacd0b85a97d-43d150f81a5mr14055599f8f.45.1775142770713;
        Thu, 02 Apr 2026 08:12:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm7747644f8f.9.2026.04.02.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:12:50 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:12:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Remove invariant violation
 flags
Message-ID: <9afce92510a7d44569dc3af63c9b8c608e69298a.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775142354.git.paul.chaignon@gmail.com>

With the changes to the verifier in previous commits, we're not
expecting any invariant violations anymore. We should therefore always
enable BPF_F_TEST_REG_INVARIANTS to fail on invariant violations. Turns
out that's already the case and we've been explicitly setting this flag
in selftests when it wasn't necessary. This commit removes those flags
from selftests, which should hopefully make clearer that it's always
enabled.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 24 ++++++-------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index df7c62a12318..c1ae013dee29 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1066,7 +1066,6 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP_JSLT for crossing 64-bit signed boundary")
 __success __retval(0)
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_64_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
@@ -1148,7 +1147,6 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP32_JSLT for crossing 32-bit signed boundary")
 __success __retval(0)
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_32_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
@@ -1536,7 +1534,7 @@ __naked void sub32_partial_overflow(void)
 SEC("socket")
 __description("dead branch on jset, does not result in invariants violation error")
 __success __log_level(2)
-__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__retval(0)
 __naked void jset_range_analysis(void)
 {
 	asm volatile ("			\
@@ -1572,7 +1570,7 @@ l0_%=:	r0 = 0;				\
  */
 SEC("socket")
 __description("bounds deduction cross sign boundary, negative overlap")
-__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__success __log_level(2)
 __msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=smin32=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,umin32=0xfffffd71,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
 __retval(0)
 __naked void bounds_deduct_negative_overlap(void)
@@ -1616,7 +1614,7 @@ l0_%=:	r0 = 0;				\
  */
 SEC("socket")
 __description("bounds deduction cross sign boundary, positive overlap")
-__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__success __log_level(2)
 __msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
 __retval(0)
 __naked void bounds_deduct_positive_overlap(void)
@@ -1649,7 +1647,7 @@ l0_%=:	r0 = 0;				\
  */
 SEC("socket")
 __description("bounds deduction cross sign boundary, two overlaps")
-__failure __flag(BPF_F_TEST_REG_INVARIANTS)
+__failure
 __msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=-128,smax=smax32=127,umax=0xffffffffffffff80)")
 __msg("frame pointer is read only")
 __naked void bounds_deduct_two_overlaps(void)
@@ -1713,7 +1711,7 @@ SEC("socket")
 __description("conditional jump on same register, branch taken")
 __not_msg("20: (b7) r0 = 1 {{.*}} R0=1")
 __success __log_level(2)
-__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__retval(0)
 __naked void condition_jump_on_same_register(void *ctx)
 {
 	asm volatile("			\
@@ -1748,7 +1746,7 @@ SEC("socket")
 __description("jset on same register, constant value branch taken")
 __not_msg("7: (b7) r0 = 1 {{.*}} R0=1")
 __success __log_level(2)
-__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__retval(0)
 __naked void jset_on_same_register_1(void *ctx)
 {
 	asm volatile("			\
@@ -1770,7 +1768,7 @@ SEC("socket")
 __description("jset on same register, scalar value branch taken")
 __not_msg("12: (b7) r0 = 1 {{.*}} R0=1")
 __success __log_level(2)
-__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__retval(0)
 __naked void jset_on_same_register_2(void *ctx)
 {
 	asm volatile("			\
@@ -1800,7 +1798,6 @@ __description("jset on same register, scalar value unknown branch 1")
 __msg("3: (b7) r0 = 0 {{.*}} R0=0")
 __msg("5: (b7) r0 = 1 {{.*}} R0=1")
 __success __log_level(2)
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void jset_on_same_register_3(void *ctx)
 {
 	asm volatile("			\
@@ -1822,7 +1819,6 @@ __description("jset on same register, scalar value unknown branch 2")
 __msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __msg("6: (b7) r0 = 1 {{.*}} R0=1")
 __success __log_level(2)
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void jset_on_same_register_4(void *ctx)
 {
 	asm volatile("			\
@@ -1845,7 +1841,6 @@ __description("jset on same register, scalar value unknown branch 3")
 __msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __msg("6: (b7) r0 = 1 {{.*}} R0=1")
 __success __log_level(2)
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void jset_on_same_register_5(void *ctx)
 {
 	asm volatile("			\
@@ -1877,7 +1872,6 @@ SEC("socket")
 __description("bounds refinement with single-value tnum on umax")
 __msg("3: (15) if r0 == 0xe0 {{.*}} R0=240")
 __success __log_level(2)
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void bounds_refinement_tnum_umax(void *ctx)
 {
 	asm volatile("			\
@@ -1907,7 +1901,6 @@ SEC("socket")
 __description("bounds refinement with single-value tnum on umin")
 __msg("3: (15) if r0 == 0xf0 {{.*}} R0=224")
 __success __log_level(2)
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void bounds_refinement_tnum_umin(void *ctx)
 {
 	asm volatile("			\
@@ -2002,7 +1995,6 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
 
 SEC("socket")
 __success
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void signed_unsigned_intersection32_case1(void *ctx)
 {
 	asm volatile("									\
@@ -2020,7 +2012,6 @@ __naked void signed_unsigned_intersection32_case1(void *ctx)
 
 SEC("socket")
 __success
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void signed_unsigned_intersection32_case2(void *ctx)
 {
 	asm volatile("									\
@@ -2172,7 +2163,6 @@ l0_%=:	r0 = 0;						\
 SEC("socket")
 __description("dead branch: tnums give impossible constant if equal")
 __success
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void tnums_equal_impossible_constant(void *ctx)
 {
 	asm volatile("						\
-- 
2.43.0

