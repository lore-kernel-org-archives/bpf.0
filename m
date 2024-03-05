Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84241EB2A
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620903; cv=none; b=oazGh+D6etqoFrUEf375VVzmvX3Tir0urU6HO3Ny5/9AnYXfT1gwt+qlajiZ5qe1Ez6A2fpqZMkb2O3jfUsAteKUqgb0qQGNHpICrxiwypL5jLG4prCpXcxuyp9X1wkUfo/jCHFBaq3nefojfn6o1XEB7W8QAwcP7ogIEOUkpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620903; c=relaxed/simple;
	bh=+BO2AvzQiK098/Z61yrwaOl6Vy5/AXyx6y0L4eoy/DU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDLCJ7SQFglj7Z0p+Rx7bWCVhTn4Cetb39HTsIOJevY43fOezJf7nIn3AO58XSnIqlYKfw0tD9YszX19D4CEuYohU8hBOvwwywerxUHGxrD8uI50aqE5FT9zjQ29ONnNdCNxKx/udjtMsOW0Xyt4ygg4j2gvBsgDtKFpPYMLTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyS5pwZs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyS5pwZs"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e64261e712so48905b3a.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 22:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709620901; x=1710225701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVis27mvpfhKNM7pAuV0lL5raWoeMmtfZqZ4U3D+98c=;
        b=UyS5pwZsygfRvT/NkwSW3i99eyJhhElOrEa69lwGJFsDCW6nMeUx4g/Ir7x93DDFWs
         qDRNMcnuU/xzC8SvbB0JzJza3X7daVFPidVNQuJDdYnfcgjfXaSaa2xaduQT2Y+7/l3U
         curJrPG2LftmCGo/uBWFwY5r0xOsEkNOQL5qve/dkCEBvysyUwSy4T8cx1auFJrdDSk8
         2EpBKn/R2TO45JEjIkb5bVKfNHjsSy9R2V5xAO/ZlifhRMdz9vJZXL59oLzYU4eJpfG9
         AjDEiiNG+vqsq1HgFeytwIZAqAFHXC4JSH/WhSqfUuQydp3Pz7LbjfqEUrDL1maroiJu
         PggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709620901; x=1710225701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVis27mvpfhKNM7pAuV0lL5raWoeMmtfZqZ4U3D+98c=;
        b=ZbHf2dLFV8hJFN6FyfLVhDGYLg0wWtS5+3/qDUVek8qy9fxCMYxIa8hcKi8O8wmY2F
         +cKdcCqbo21jtG2sbdlTDSKWjCDblVrhRm5jq/3FAdId/783EolyHA5C4+7KeVR961pC
         gPEDe4vRHE3oBsEc7HgHLSw2Hfy2iCPC6uKF47R9d6c+WZPOEqeTeqiRGhUkkVDfXmCQ
         4UYmN2OEmQsGyfeF01fB9nBr7fBwM7cFJc7xobuZeE3NKOX+9LeeJXUhsmXgaNEb9UKE
         YMN7fkIs6BeBjNCzZjpZTn8IjUP+k+fn5r7uXtlzS0UpoJgYSdkOifTKLrmguJ1yyDfA
         Qmbw==
X-Gm-Message-State: AOJu0YyxaL+xPmx9gBhvEnAxTHQAbet1EHOcizZgCN/kD/jw6eUmPgMJ
	Nois+7vENJhNp0F0a65zrtHFkGgLLWkHY0m/X+TDoE5u8yObBEds
X-Google-Smtp-Source: AGHT+IFE172sjMqgr1XRNryIqOSeBSmQpm2/3b+HqsB87wj0L8KkvrbfkCpV370S0XmpG/vz6D0vOg==
X-Received: by 2002:a05:6a00:3d10:b0:6e5:ad7d:d031 with SMTP id lo16-20020a056a003d1000b006e5ad7dd031mr10868098pfb.32.1709620901110;
        Mon, 04 Mar 2024 22:41:41 -0800 (PST)
Received: from localhost.localdomain ([39.144.105.163])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b006e0debc1b75sm8395399pfo.90.2024.03.04.22.41.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2024 22:41:40 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 0/2] bpf: Add a generic bits iterator
Date: Tue,  5 Mar 2024 14:40:54 +0800
Message-Id: <20240305064056.69536-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
added for the new bpf_iter_bits functionality. These kfuncs enable the
iteration of the bits from a given address and a given number of bits.

- bpf_iter_bits_new
  Initialize a new bits iterator for a given memory area. Due to the
  limitation of bpf memalloc, the max number of bits to be iterated
  over is (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator can be used in any context and on any address.

In our specific use case, we leverage the cgroup iterator to traverse
percpu data, subsequently exposing it to userspace through a seq file.
Refer to example in patch #2 for the usage.

Changes:
- v2->v3:
  - Optimization for u64/u32 mask (Andrii)
- v1->v2:
  - Simplify the CPU number verification code to avoid the failure on s390x
    (Eduard)
- bpf: Add bpf_iter_cpumask
  https://lwn.net/Articles/961104/
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/Articles/939939/


Yafang Shao (2):
  bpf: Add bits iterator
  selftests/bpf: Add selftest for bits iter

 kernel/bpf/helpers.c                          | 117 +++++++++++++++
 tools/testing/selftests/bpf/DENYLIST.s390x    |   3 +-
 .../selftests/bpf/prog_tests/bits_iter.c      | 137 ++++++++++++++++++
 .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
 .../bpf/progs/test_bits_iter_success.c        | 122 ++++++++++++++++
 5 files changed, 432 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_success.c

-- 
2.39.1

