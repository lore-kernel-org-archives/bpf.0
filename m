Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9BF2DB7BD
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319066; cv=none; b=rs9tQoWTQqZZ90HTDsbibwSpQTJrtdk7mYiGUYXeQhheoJDCoZU18zoe47WbjysL9hWpzqDO1CftsxLdb9HMApdgrGPkEd2r2KciSHMKF+6EWt6yvMHhVYn5LOOKB6vNppuscgMOAPIz6SzNHzsdueSvA8iRx4w5Zh2+WAjM7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319066; c=relaxed/simple;
	bh=yNUCXZxrqmvRqfHc8zHB5J/ar78BnBHpKtDhvgPNuMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=najxiioWBg5AjMcXyW7JONC7NwyV1ZSJKdHV3ARryDriUMcTWZ/Xu9BGJfVqklDhcv9go7TrRyIPgAsqxZFK0mJZjQTXkMDw2LwJXuBnRVvifhVgffGOhcj8VgPTCkL3QYsxr+rU8dxGb79vCT7PjXsZGyQC1GRPWADrgdlG4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxtIlIn+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxtIlIn+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso24319785e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 01:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771319063; x=1771923863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7QUlYTW0zbqfDHbbMICRhjgVwChXwtfr/18sCwTvFI=;
        b=cxtIlIn+SKODQoVFa/7wx2lvpV1gNREdT0jbGXJsKsAc8imDYVa7N5k/4rMgTN/wF3
         Nd99zANwFK7wMcyLneFMDvxt46qBpkImMv4MOzhIUnV6XUKrB2imywkshTuRPONic/M+
         GhrBCKSJXZ/KTvC0RRJEAAwQJrwaDOeuXLe0lziMWYeRele2QYn9Zx8kHoNUvzWhuYb/
         b/0Ffo7RISyEUCZy3PgY7u9WOjjtoWQb/wxbMwcj/HGFrcaihNc2k/uG6/5LJhI2XTWD
         NAQQeAwSKZzoJB8BkJp6Eort9xhe4JuCUEQKqGKi18SowQ15sVrjzz8lKhNqTITgwIom
         Zn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771319063; x=1771923863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7QUlYTW0zbqfDHbbMICRhjgVwChXwtfr/18sCwTvFI=;
        b=W4K+e5qyZQMKdIxGxdU5iqsKF4Reio3gvb5CcB6NJlGLBwyG23YfPNQXGtkIIWFHkk
         0PCAdRgrursZgwwuFTZbiz5rpbs/NobD6gbPkYFyO+8ztAjJw64HPMqxpYWFJlJgxNib
         dz3sawo2E/FhCD0pMXnRAXKviP3ozMKXAGcxB3DGHM2SVdS6O0eM93WmH/bkPokvupID
         cqgT1FA7MHe24N2FBWBWRTmooaDefF2jhNHrq2DuMCCZbbUT9RYUO9mNcMlYRz9fKwR1
         r+OkcEDvybAea0TSJZpgck2DNRM4vsyNo3B49mK5OHhDgGXSh6axXTCMeRr5L+rtPg6n
         FKNA==
X-Gm-Message-State: AOJu0YzoJHxYCdYzPm53JpL4X0LrDcWt59+yxnQ9tI3UTZF8lSwUQTXE
	UYXNwcoCPzBwbFWGd6yLGpIL2qBc9rIenZ3yaz/4YqoinLFNFy0ZfpVvyfghOg==
X-Gm-Gg: AZuq6aJFdP77RsuYa6tyqHXbMLDpEHm9xVlXsogK8P9kT+03vzQH4m6PHbEcCzxP9+E
	qrLpu614wviasVYal/NZEuCdAYgjnoYRD7swcFeVFmPytZ96qnIocXGTbTufI9kwzZ6ZHI+Zdir
	uUYAJjO3d/txWJ/nNwj4jEFQoEkk6159TEfQ/TP6SYeLbHSLE2u+BGQaX2AV0ngabpXvApHDVBF
	zyDSmHEXTjGAe4rs6DvGTYmhoAIqx8CneUu4kyLJFoJPXnfk/Ba5/6FW2DWlSMx8xTJo336AA4E
	qojJvTzzq9Y8OHbL+H+pXSSUIZffePPGVSzdfVeROrQlRYkJPREMuvzQ6FqMA35WKepEZca/UXZ
	BAopLC7lbqvwUf6ElfxGVFA2xMfRuujkTNcOVfnhFj/am3qxnJtd4rwweq6RymamD7JEYOuR3pD
	krLEQPvhCrbuSmlCsuxzR653iSixn/VtsGRW+AqQHDoA1DZ8DpnODq7R9axJycXmnXe4HjD1UmT
	7Cf1y+PO8/ew5hClZqp8gEmyRQ4pIp99nvp7GYAf0NsSHZdo6j/8AArTsTtiP0rBfAJFwnYrzdW
	gIxhxnEKzYo=
X-Received: by 2002:a05:600c:4446:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-48378d58817mr180115695e9.3.1771319062754;
        Tue, 17 Feb 2026 01:04:22 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e003025d1eb71f3ff18.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:3025:d1eb:71f3:ff18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd1bsm562551265e9.6.2026.02.17.01.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 01:04:19 -0800 (PST)
Date: Tue, 17 Feb 2026 10:04:17 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf 3/4] selftests/bpf: Test refinement of single-value tnum
Message-ID: <3bf3de652420888730da989eb50c8040bcd987c5.1771316309.git.paul.chaignon@gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771316309.git.paul.chaignon@gmail.com>

This patch introduces selftests to cover the new bounds refinement
logic introduced in the previous patch. Without the previous patch,
the first two tests fail because of the invariant violation they
trigger. The last test fails because the R10 access is not detected as
dead code. In addition, all tests fail because of R0 having a
non-constant value in the verifier logs.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 560531404bce..41dd249faadd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1863,4 +1863,95 @@ l1_%=:	r0 = 1;				\
 	: __clobber_all);
 }
 
+/* This test covers the bounds deduction when the u64 range and the tnum
+ * overlap only at umax. After instruction 3, the ranges look as follows:
+ *
+ * 0    umin=0xe01     umax=0xf00                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |   x               x                                       | tnum values
+ *
+ * The verifier can therefore deduce that the R0=0xf00=3840.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umax")
+__msg("3: (15) if r0 == 0xe00 {{.*}} R0=3840")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umax(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe00;			\
+	r0 &= 0xf00;			\
+	if r0 == 0xe00 goto +2;		\
+	if r0 == 0xf00 goto +1;		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction when the u64 range and the tnum
+ * overlap only at umin. After instruction 3, the ranges look as follows:
+ *
+ * 0    umin=0xe00     umax=0xeff                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |    x               x                                      | tnum values
+ *
+ * The verifier can therefore deduce that the R0=0xe00=3584.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umin")
+__msg("3: (15) if r0 == 0xf00 {{.*}} R0=3584")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umin(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe00;			\
+	r0 &= 0xf00;			\
+	if r0 == 0xf00 goto +2;		\
+	if r0 == 0xe00 goto +1;		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction when the only possible tnum value is
+ * in the middle of the u64 range. After instruction 3, the ranges look as
+ * follows:
+ *
+ * 0    umin=0x7cf     umax=0x7df                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |      x            x            x            x            x| tnum values
+ *
+ * The verifier can therefore deduce that the R0=0x7d0=2000. Instruction 5 is
+ * therefore dead code.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum in middle of range")
+__msg("3: (a5) if r0 < 0x7cf {{.*}} R0=2000")
+__success __log_level(2)
+__naked void bounds_refinement_tnum_middle(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 & 0x0f goto +4;		\
+	if r0 > 0x7df goto +3;		\
+	if r0 < 0x7cf goto +2;		\
+	if r0 == 0x7d0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

