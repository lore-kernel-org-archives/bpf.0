Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414933D5247
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025437; cv=none; b=s9UWFQ7lMxD+zyna6pZrhSRdWD73ovxiGoGsOzushlw83RjIRG36srZRYCjVtv2OYqaUaNcqIRfnunIxsN9KKznJb7a9k3Hwd+BJ3TpZ0EjE792oRCDs4iitTWYDlNt0ww51ACiQZuNMdHDgWta5fb1f8lz9beOtHA/qqoqOKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025437; c=relaxed/simple;
	bh=gt1QrHwvD5m3++X8pXxsyXHYy8214Nw2a5DaeCP9mC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MewhyTUmyOE0kB9HEVuSVbr2kNqm2pW6VLWUmhpOGybO3weLraUZFlsPdUJbZB6excbll6N+KnS5VcDk7SGgWP7KRxUXzmJB2UOJSC5n8aEXAs6MRwlhj85XFelm+PmcMUw6V9m/XsT/MstKjt3/nf0Ppp+FD2Jpf4hQKdztF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzAs+BVQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzAs+BVQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fb112c09so6660765e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025434; x=1774630234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHOJ2gNX6qqNJNLQgJyXXnyn4FydkLyVzCbcJFTPL8I=;
        b=mzAs+BVQ6Zvp+I2eg9wqxThbI3fj1qqDXxTQoJWRXmoAYPDL5FqEEzbdbukCTYjo22
         t3TtwAMmZMF0sDwVgcbjMviIX2VZPol6FDTxGWqQRZpkyWSoX/yCndesF8Pk7xlV04aP
         9MlyGu8mhjDwv7TKnEKqDTCnhjVs8fmCuxQM58Wk9KNHkVYqfd+1RcINIgJY1gwEsUd6
         HVhc7vMwfRf4oY1QmxwjgmUJ6HTjdw3pwbDVNDYJ8D9QfrlGMgPSTxupQXUWFp51jmvc
         kWY+AumU1X/NKigMsIcgojNz8YFHVxe9cS9sp/7f2Ov3NgDvDswjLFyGGx+l2751xHhM
         xWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025434; x=1774630234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHOJ2gNX6qqNJNLQgJyXXnyn4FydkLyVzCbcJFTPL8I=;
        b=c9UQN/36c2zP18MPjV53f/Mq5giTWlb95i47cW/5fbEQgs81x0vVF5o2g25WyRZrh8
         z7H88j/1EeIpkcMdBBOgMixYl/xZUqvpdLYwR9KRSaKGJP5AlocsBzHGZT8PJjtH10Yh
         2yRCulv2mr58vKqXo1jei0VHssx4XiqvzE+VW/X8a76q95d73CUqrgn8OKKNuQmZ0rik
         PCd3Gk3pWfoG3rcR77jKJhZtNP1gbU6ILDdIvipUkySENyLakMiZPZci4bSMzdyE2I9c
         zLTIXAAMjPOJD7zR/Drx3cIuDmzLtiWb/aBwbTlAlaUd21QRgXqdx1xVhH0q+/lg5WD6
         mvEw==
X-Gm-Message-State: AOJu0Ywkoj54EHjBTeJE2ya2LEFTx0To0cuhhbq8CRHzHGEWe8pUlBd5
	B9imvC2c4VKofR2FFQ6k/4AtdQRj/NzvHGdPDM1hWzLVvMWMU+RSJS4TQDDhNaCK
X-Gm-Gg: ATEYQzxFNbTI9r+90us9upBVppI24giNg+vl1Do1r7noR3fnDYIy0/HddDFO/D9qb7q
	1DSuiAXBOwt1ZcmIx6IhBirHMtrABscYEHxbmdQ7jf75RfvHXEC9dHRkq4KUz8pHcLnf6jLLtde
	IonMLAc6L5IYTGnsnJF/RueguLOwy/qi/hAJYb2p23UV4iKPlZPYin7eDbqpqZK2sHqx4fY7Zwt
	A36kZ8URo2FQCK9JbT3asAkZzWjGkC0Uczv7oMSa+ck8zdYtwUyB3IeVZlpcH6uJDv88e3wFUhk
	XfVAwl7LlhkKTArvjU9LEdjQDdTKi1/OI5PpuK9qWU+dQHM9kIUW/shEgCwzoyN/saUZa71NOEm
	HZ6tbBxaJqUZPBH+j9+yVEvXwI9NX1kNWH4KNP+w6pBjTX//JdDYTy/wuZ3SkHMgBQAycVjH3OY
	jO/czVDYA9CxgEKQlqZ6LlV5YEhngghB9d8o5VqfnkZldeaqErAqjPytrqD8xkUbuL3wShKJHC0
	36knGFZQODOpGWSyr0JZSGGIZwm7SgDg92XJFszUiXXTJMHvLdz3BmDSJ7Jtv3BKlnQ7aOat4yd
X-Received: by 2002:a05:600c:1c0a:b0:483:7783:537b with SMTP id 5b1f17b1804b1-486fee29560mr54759295e9.24.1774025433492;
        Fri, 20 Mar 2026 09:50:33 -0700 (PDT)
Received: from Tunnel (2a01cb09b013a2c6b23e8799d065d8e3.ipv6.abo.wanadoo.fr. [2a01:cb09:b013:a2c6:b23e:8799:d065:d8e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe8159dcsm28543405e9.0.2026.03.20.09.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:50:32 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:50:18 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: Remove invariant violation
 flags
Message-ID: <e6da1ecc47f206f9fb6dabcf735b34382dffd885.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774025082.git.paul.chaignon@gmail.com>

With the changes to the verifier in previous commits, we're not
expecting any invariant violations anymore. We should therefore always
enable BPF_F_TEST_REG_INVARIANTS to fail on invariant violations. Turns
out that's already the case and we've been explicitly setting this flag
in selftests when it wasn't necessary. This commit removes those flags
from selftests, which should hopefully make clearer that it's always
enabled.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 24 ++++++-------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 818efa08404d..1ebc99d75862 100644
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
@@ -2076,7 +2067,6 @@ __naked void refinement_32bounds_not_overwriting_64bounds(void *ctx)
 SEC("socket")
 __description("dead branch: tnums give impossible constant if equal")
 __success
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void tnums_equal_impossible_constant(void *ctx)
 {
 	asm volatile("										\
-- 
2.43.0

