Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC71C84A2
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121600; cv=none; b=bXbpogIRKiR/YP+ipvwCr6+mIKkyWt91FZetj+ZPn/hCzsy/oeZiFTmIAx8AWPop0FO1tRnMGXxyurGk0W4ruCjUyE+ji8CrAzaCg+xoRmnqLv5cE0gk+TGd2BFYjJCvo8JuWiXa9H71f2B76/GzMzXlhWgnP6Jg/RAyRgkGCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121600; c=relaxed/simple;
	bh=698a073YtdcNv2PF7blbPB+XeYWFONBCV3INYhUT46g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bqaQyxDey8bHhPVUpSJiD0WjnxJztDSzmMZeUxNjAGTWPKbkthEb/8/MX8TsvXTvwr3wHPyAYW85zTdtFOd+jcR+ijemdFAKBIfK2qMrw3gUstu4Z8EtXzuLpAFCaalQ15/0LhYAT8/o/v3JNRsLS0x5nsv9z2xIXHEECwYtwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF4e3G/+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF4e3G/+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso27910805e9.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779121598; x=1779726398; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gicoQlYdDOYVmuA34vHwu/Jt1gncKkKI3uZ0DPbJpNM=;
        b=SF4e3G/+ej8VFyEG6dlMdsUFu4LyakKaet45Eagq+K6LxjlSe1pVqCr82b/aVZFHlT
         mR5okWeMjg193GnWFpN7anRsJ6lFYj6Uc9unZxQE6rhNtUwWgR8cLGJQap28nfs0jEmY
         119+m4Um0M3aqP8DDddkIJzOGIujFJt4ZMBEMGDzYSqSCfSSkl6O2t4NQfgQOZB4MUPJ
         8dvzS+aVYePt4VJ/LDCGMaEeqLQbcXev3QPefgYM/J/5ql8d3x2SuH9cGIMANYGOnnxI
         AR76wrHlsdq4Qlyi5uFXBuwTB7B886IoUGFfX7LTUVpQHz8CNA7uprV4ENHsiseva2UT
         p2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121598; x=1779726398;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gicoQlYdDOYVmuA34vHwu/Jt1gncKkKI3uZ0DPbJpNM=;
        b=rmDie32/K7AscN/vwaZp5PPoPs2MjxyumsXsBJh2Qeywu9oYQ1NqqOQXyo2PhGNCmJ
         wzfFV0lGr24v1kgYR0QFRpxKAUErc7G2z9rMUrPo3OOpn1tsfd7O5UHOz/8X7Dw1MBgz
         ra8YILWRdCwl7A+hhyuR7nPwDDkUNpUQwbUNxYVY+7AaiHdrpK2BA5TrjmnmuGbFX7ro
         treUyV8XClGXLNHU6Jp4Vi8Abr1oUWULgwYnvPzIOS+slWuHxhgnllieD4UyEyAVNzKP
         A/GfBES7WyGLj+jNKE/gbdwdFtfr90TIhc8NTsrqa+BRwPXWmIZD2WOsZKBS8N/1xmFU
         XdOg==
X-Gm-Message-State: AOJu0Yy4XPH6F2dvKZL+Z9Zkk9QLWvaFNP2Ll7wtMC2+ANaHsPR3UY7a
	m+wr+hKsMl3H5MCY6sxUNHxx38Imw0xXRf6HxUIWV1Tasdo0YcjUtj/y8sATt6hF
X-Gm-Gg: Acq92OE03xz/mswEJ7OyMLg1d28rXPMlz/0J99+h5Ym5qZRxB4UFS8GTVubu0tF5i/S
	lX9efK+5mhfsax9Z5wiX8V5jPtaEUvrB0IZ4yccQwMVSJUc3FFsuAq7iolbpes41xSc9ltNpBrx
	ynzDQ77gbcntnN+JOKngGuZELggYlOCxMSPAIUpUieAcsr+GajlJ9mbEKRfDVg+Z7TMZMgm4xrE
	8g3tGus8pHmxUBa4CIfkOrNO5kdHx1exTMjdjWMQ20ZbOyhxCnUrqarR6toMzaZ2zKvdm4J5KwS
	6LZ+qy/+4Zc8B1KTbk1DmaAEvzbE1LRZreMLYpu3WeO0NEU5MDoQeRceudYRoXzgsCwtxWfhCaj
	y2LOTN5EkYdAmXqsYcH4Od/ugsT7dNkDMVgw3IfLYi7rSo2RzZtlHp6oowaAupktgzqLeKakmNm
	MZmt98FcGGRyj0YmRldtqRgp7CpKka1aN4nZHwkOyIouXBAvP8+lg85hmP2iu38IyFTE0gVWebh
	/TVPRLrXNJstAOweXo/STUo5loOqBmqe5HL9wB5Fl1JNTIJnIcEW9jQw6mCtGEI3EgdlRAcctg2
	RVs9zmGvGTlAoVhWri0rbmrP8WezSsQbfbU3gjgsWg==
X-Received: by 2002:a05:600c:609b:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48fe4cadfeemr244187115e9.2.1779121597606;
        Mon, 18 May 2026 09:26:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0002302090c50a60b9.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:230:2090:c50a:60b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm98002805e9.9.2026.05.18.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:26:36 -0700 (PDT)
Date: Mon, 18 May 2026 18:26:35 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix test for refinement of
 single-value tnum
Message-ID: <be2dc2c3d85120286e60b3029b3338fff339f942.1779121582.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes the "bounds refinement with single-value tnum on umin"
verifier selftest. This selftest was introduced in commit e6ad477d1bf8
("selftests/bpf: Test refinement of single-value tnum") to cover the
logic from __update_reg64_bounds(), introduced in commit efc11a667878
("bpf: Improve bounds when tnum has a single possible value"). However,
the test still passes if that last commit is reverted.

The test is supposed to cover the case when the tnum and u64 range (or
cnum64 now) overlap in a single value. __update_reg64_bounds() detects
that case and refines the bounds to a known constant. However, the
constants for the test were poorly chosen and the bounds get refined to
a known constant even without __update_reg64_bounds(). The code is as
follows:

  0: call bpf_get_prandom_u32#7  ; R0=scalar()
  1: r0 |= 224                   ; R0=scalar(umin=umin32=224,var_off=(0xe0; 0xffffffffffffff1f))
  2: r0 &= 240                   ; R0=scalar(smin=umin=smin32=umin32=224,smax=umax=smax32=umax32=240,var_off=(0xe0; 0x10))
  3: if r0 == 0xf0 goto pc+2     ; R0=224

After instruction 3, we have u64=[0xe0; 0xef] and tnum=(0xe0; 0x10).
__reg_bound_offset() is able to deduce a new tnum from the u64,
tnum=(0xe0; 0x0f), which combined with the existing tnum gives us a
constant: 0xe0 or 224.

We can easily fix this by choosing different starting bounds. If we make
it u64=[0xe1; 0xf0], then __reg_bound_offset() doesn't have any impact.

Fixes: e6ad477d1bf8 ("selftests/bpf: Test refinement of single-value tnum")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index a3e4c0945137..bc038ac2df98 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1892,25 +1892,25 @@ __naked void bounds_refinement_tnum_umax(void *ctx)
 /* This test covers the bounds deduction when the u64 range and the tnum
  * overlap only at umin. After instruction 3, the ranges look as follows:
  *
- * 0    umin=0xe00     umax=0xeff                              U64_MAX
+ * 0    umin=0xe1      umax=0xf0                               U64_MAX
  * |    [xxxxxxxxxxxxxx]                                       |
  * |----------------------------|------------------------------|
  * |    x               x                                      | tnum values
  *
- * The verifier can therefore deduce that the R0=0xe0=224.
+ * The verifier can therefore deduce that the R0=0xe1=225.
  */
 SEC("socket")
 __description("bounds refinement with single-value tnum on umin")
-__msg("3: (15) if r0 == 0xf0 {{.*}} R0=224")
+__msg("3: (15) if r0 == 0xf1 {{.*}} R0=225")
 __success __log_level(2)
 __naked void bounds_refinement_tnum_umin(void *ctx)
 {
 	asm volatile("			\
 	call %[bpf_get_prandom_u32];	\
-	r0 |= 0xe0;			\
-	r0 &= 0xf0;			\
-	if r0 == 0xf0 goto +2;		\
-	if r0 == 0xe0 goto +1;		\
+	r0 |= 0xe1;			\
+	r0 &= 0xf1;			\
+	if r0 == 0xf1 goto +2;		\
+	if r0 == 0xe1 goto +1;		\
 	r10 = 0;			\
 	exit;				\
 "	:
-- 
2.43.0

