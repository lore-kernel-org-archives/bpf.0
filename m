Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FC3C276A
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833555; cv=none; b=iG+xJryiJBaJZQvHXFJ91R8TYnprM/LaNK2QFPbMK1/RV7atXUekvnNCZD6+6MYsHFsUs/yNKxZGCt84MS2R9yONE32QvTX3e64WyZF+GlGmHc4ZbHXyChqxq1PHJQzB59QYZQnKY1HF3LKrec1CqmkZJ7wX9TrTaY3Y2AmII60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833555; c=relaxed/simple;
	bh=GAVO22yDoGw0SBaEj0BSp0p2E/UvxCnP6A22HFTCZGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7LCPN/MxQ2EEbfq0POlVKCSWNimCqjxmv7hY54Tjty7FjcfT+64fkIv8al+Y7ERtwnMsnRT6jgemzOxv/VgSkZOQG7M+ji6V8RlcU9q5pggdfBJQWDXjEmr5hqsp2bc9YHx2JckunKFsZ+grGFrhYbWytG7pIay37XtyvzL/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+zE9srx; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+zE9srx"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1271257ae53so9470606c88.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773833552; x=1774438352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngahEQYPHkZNv+yZVK/PCN/gTdSgCME8Ml08zDKTYuU=;
        b=P+zE9srxoTrXqSAXOWNzRT5zTPSTeQq0gxfjFFW2O0NEqXdTl+gQogrEZ78MsHFZE8
         ESKK7augDSYHCHe6TZ+VivZnUrHSQUGrsZV9S/uC44CUKNqAuMtH5S4IWOZN3gxdYmOa
         t4mfcrfkf/NDjfSb1BXxhGeBkNBYZMZWV4/bpPD1u44suiKvOSnUqm+JyEooux9B8b5t
         n7gAfkJbjzQWD4vm1eSKnMMVsJpcXsjG3gSCOozSAoqRCE/pOwLIqEFndGX3nkSyhsO/
         wy5QCVhcefTzyA1q4tNGd0dE6eJtMJlpVfPHKdYm0nkP6W/vQSWZNmSXdyO/a5tddAId
         eMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773833552; x=1774438352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngahEQYPHkZNv+yZVK/PCN/gTdSgCME8Ml08zDKTYuU=;
        b=qya4W7vngdSfhni5PUK/7QfxguCxkVLSNnqsUzg54tp0Nie8l6Dmi93FY7EoKM8S2R
         CSqcZd+SBjgU3FvXmwCkLncYpJTNcy1acX0SZewda4hfvNiKSPrdm48dV9ZioNG1ftjR
         2MPCg6HMPNQEov4HPN3WUA5TUMdfvjiZg6fFTpKcM4TGyBOqGEfALhAm1HAa8tXbubv/
         c7llRw18GHu//onJFtMDNvDpgTAm+9zvm4ym8gjmvzjsXl3PpIB72hfevYz83iC9JnJE
         g3WD6jPi5IDYQZdsG3yhq+y6DKkp4pZVO9c2PX5RsOnl5Zn5R3ZyFzByxi/XtzsbqAwm
         /zsA==
X-Gm-Message-State: AOJu0Yx1zPf4N9IUERHh9WjTdlsqNQZAJNuHh2RZQNqJhqAeZhehCNEh
	rcYn/LPC9NmINksswOjD1e7u/S+pJdczRfLCVF4dGhIASZC1FULu5b4tGWRV4GGxGKw=
X-Gm-Gg: ATEYQzwBZViU0I8YiTWUGs+gZM1Ak82p84JowWBQd5kmI2PwnSyS50eJuzD+cp+ql2N
	PvhUSkoj3iwEqP59S+LW0SRTN8NsOmKNKL3KMsoiTdf9I5Sih6IQPuk6zwX8qi6Xhw9i6zpL1C5
	dn9Kp18CRPHWVMs0zOhDAtFbF2yjOPm1l77UV5VjVZR9plq7NZiQYcDVvVgsJ52V56xu/MLLYsz
	LSxw6+DvADGm568WggcACD2MwMkYnWUlFUIG5utfiiuH4ECIjp1WV54L2YABeH1E+41KfUNwHTv
	E/AiKi1YVq4snTX6LUgh5Ybp2DmNcvQPb/eL4P/C14cZ6XzTvclkZ3vnSl0WEXt0qinLXb8WOGA
	M7D1QIzMVlzjOLR7Su5VTJB3Q46JHpDh+ZD2KmVUK641lxSxKVbJikqE2dMuUkT1HKIlGt9tcFX
	cEiPGtlYVswMP2WfyEfkZ99RvsMVB7p7dHn66rmId9e/Nm9XLeGGLCVJRvftSNtJ1v/h5zSHgs+
	jDYsv/IplUKxHWZd3GAkT5HKiM=
X-Received: by 2002:a05:7022:4581:b0:11b:9386:a386 with SMTP id a92af1059eb24-129a718ddcemr1365887c88.41.1773833551785;
        Wed, 18 Mar 2026 04:32:31 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b3e8dc1fsm4140623c88.8.2026.03.18.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 04:32:31 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	paul.chaignon@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] selftests/bpf: add a 32-bit bounds deduction case
Date: Wed, 18 Mar 2026 19:32:00 +0800
Message-ID: <20260318113200.303824-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

verifier_bounds.c already has 64-bit cross-sign-boundary bounds
deduction coverage.

Recent 32-bit signed/unsigned intersection tests extended the refinement
coverage, but a corresponding negative case is still missing.

Add a 32-bit selftest for that case and assert that the program is
rejected, confirming that verifier remains conservative there.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index e526315c718a..242c3d6d23b1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2037,4 +2037,24 @@ __naked void signed_unsigned_intersection32_case2(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("32-bit bounds deduction cross sign boundary, two overlaps")
+__failure
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("frame pointer is read only")
+__naked void bounds_deduct_two_overlaps_32(void)
+{
+	asm volatile("				\
+	call %[bpf_get_prandom_u32];		\
+	r0 = (s8)r0;				\
+	w1 = 0xffffff80;			\
+	if w0 > w1 goto l0_%=;			\
+	if w0 < 128 goto l0_%=;			\
+	r10 = 0;				\
+l0_%=:	exit;					\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

base-commit: a989fde763f4f24209e4702f50a45be572340e68
-- 
2.43.0

