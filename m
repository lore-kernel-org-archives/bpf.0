Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2EF342CBD
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442517; cv=none; b=FsMrx4JUc4NxgOaoy9E08CG4at/ZqcuWm7qWtVLVwC8vWYazTU0xu9qFYibe14j4zzD1fTfDxCwmftMWaJo9mRXnIMsBHmVbG8yH1H5g7XrpN/7YOfaTZUmRiCiG6TZrhX2ZyRnDEFkQN9rl1SM2BabMcV3MNMJwVThu9IDoEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442517; c=relaxed/simple;
	bh=BCF2hz+4OWx+gsg0UI0B09AetIarNZoVAKSIRELaGGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxs+kSr0EAMw8F1lnkNWv9/88c3RGM6VLOrXycHJMFM9SWqDoEv5RqxBHtdIjCoMhSM7h4K7Xkl/GVknommuZIUm57+raUmhyFuc30JzeMIVWIu+EdyD0NfY05mo+9QqEUXtLJ3P45eC21ifaz/3r/yxVPwoiP/s+IdLrWuX5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KliWwUZ/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KliWwUZ/"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b78b638eso2808056f8f.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773442514; x=1774047314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ize0aMgcjAih5TVcVaFT4u6hV1wOYZZIUdBAfK4zAfE=;
        b=KliWwUZ/jOD2/BLQ7Z6iA9fif5DC2o+IwjSczzjSXXC3T3oT7+pIeb1P5g+SrctV1T
         YCxgG8lZvbms6TVEEQTdi3p94336EAjGxWcXkQ3PbQ+apHHlFW2iJVkkOPT6fBzua54N
         cxAynG0ySqWVzRzc18/+6Evzsy7B96K1j2BTNv2vuxTRdwR/6YAOqYCcNDJjcIm8tP/1
         PUnF0WoF2qwwFRp0V50m3aJIMg8DGKwYsFPa1XDHVEhEYW919Qf/AIdwNDqTsX1kNtBJ
         beP/iWKeLpR/Fy1GUCoWw82knQj1IERh9s/5isoPUdRNhPgymzxY8dArkRooYfU2c35l
         UoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442514; x=1774047314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ize0aMgcjAih5TVcVaFT4u6hV1wOYZZIUdBAfK4zAfE=;
        b=VRREMjuhWc/psEWboptsFknO4cDqc8bbHZtiGvjPTZ+gG1gNu3/OK+70beR7TQlBiB
         enkSCnIpHV+DS6Z7DynCKXzw4v74kzAnSsC+AMly8DAnoL8/Ft019aFVjzELWoz1N8fD
         jW0IksEPBbg86m4w2ygt3Wf6nlqQ5YCKuQprjE/MYheWPpIvI6Zh+cKcTvwm3txQV68T
         kNZ/1eeYI8YcHtB96jE2RywAd3+QyTR1XeCrnnpb5FGF2sF8Y7FkKRUEfj4E5uhsTj4A
         vdGfoJKzsPRLDtb6BQdqlySxrp4CCJ6UPwv2WGkWVznsIwpRxVngkqi3qGImMWXXtKDQ
         uuzw==
X-Gm-Message-State: AOJu0YygQoEl0N2hsfAKyWOeC7BD5XlikoNTL7PuvLshM9zGq/VG/Scy
	XrI0DP3Zs8I34OFzTnZHV2PEyYRiypZs8W0uKlbVEMcx+kWpn5QnjAXbzH8U7Q==
X-Gm-Gg: ATEYQzyuY/npXLjyVxq4lYzJMpqYS92mcTAaNWsMR5X3HsdkAMCRI5ade+WwFocNANH
	1oJ3g4O/vUjgFGMSUlNKrtkyHg8MaUfhzKaw4MPyrkpixH0cWesgfeYiNiLpwnsRj0QiRz61a/I
	ny0oKYmEBF5s3oFLJaS5yudQ6zvClIfUWXB4xDu1dWtNbuba8lqVSd65byzuhabb6pthazG75mF
	Q99QBudyCII9SpZ+d77DqWFCtWvohpXT5t4p/tKNFrjDCwjiA/vnwYTkNCKPKxY79U/VF3jcEVg
	ro0pMN1MKae44vh3PyOu38Q2kEYHJ+82/gEv0xwNrCULIJeMbcYIU9GKj9BBj3hZXZszaMyE5xf
	2BlAj7UP3InxUckp+/DTsCoSn+OfPsbwelwWWcRgm+T/5V/RT/XOv8t9SPJtuQnbydQcZvFKlCv
	imKYudK2fLPNUq5nHE+LBYLNnYQsG6swYwRIHe9IWV4L9l8sIjUkUAF5Q7xgSgNlt598w9XgXkN
	Oj37yTKFZhOUX/2h4wkKlTUu1qWW/h+lJuVoWP6NKcYFSUXNNnM4yltZ44iaW6v5GL9mrtmGrv7
	ncHrviaQ/TY=
X-Received: by 2002:a05:6000:2403:b0:439:c5cf:fc73 with SMTP id ffacd0b85a97d-43a04d7a050mr9272481f8f.12.1773442514048;
        Fri, 13 Mar 2026 15:55:14 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ad9asm21711843f8f.7.2026.03.13.15.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:55:13 -0700 (PDT)
Date: Fri, 13 Mar 2026 23:55:12 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Remove invariant violation flags
Message-ID: <58a668169bde565701135d9705c819b7f4707dca.1773441432.git.paul.chaignon@gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773441432.git.paul.chaignon@gmail.com>

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
index 20c857ba21a8..96df2950cdad 100644
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
@@ -2043,7 +2034,6 @@ __naked void signed_unsigned_intersection32_case2(void *ctx)
 SEC("socket")
 __description("dead branch: tnums give impossible constant if equal")
 __success
-__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void tnums_equal_impossible_constant(void *ctx)
 {
 	asm volatile("										\
-- 
2.43.0

