Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF332B13A
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845471; cv=none; b=R/tGwx/vyGUoH2r7gUDbwj71DAekenvpqiNatbvhRYmRbirCjb31o/QD4QrOc9n28/JhMp960GsPIkQeT0PO10oyjfC2jJrRphXilvuPRQ7rgFZbJmkBKgXXgPGm78NWrIq2GqziAiqgv4I4WLMIWm6LZkVT+nAxnp0t9MgbKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845471; c=relaxed/simple;
	bh=rmjRXKU3+1yuW+bwtzwUCNpOX9wX8FgDEB9FrwurdQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wi/j2o67x3YMmgVBSlul8xOmuqoGrC5FZiBA+elNXLrf9dPIrz7QS3GXZIon12w1GSmk9fo6EPksmvNEyEplCON/oSlWSMIcdvH6TS70C4R3UhnD44nG1+1TOneO0Vqv2Y9sMOWOx+lwvXrtNwWkL2IGxQSxV09TZOCbMy8UKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcOum++S; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcOum++S"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-481512c85ffso935074f8f.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845468; x=1787450268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nVxb6G4xQXJD/mXg4m6AzSd2sAZvdY8O5rYSykKLTBM=;
        b=ZcOum++S/cwSh4YFn9JQL22RrbAP70OMXGAG7xMKReLV9VkZzQhxQDumXXzWGUc3C4
         H6IhAT+N6jIpId9cQR6Pa2KmYk3k5wreymlqosqiC/6PLMwOv9vybaTaLalO05DoqobZ
         WZpi08u+S5jqJSzrF9MJJCnVZFtrk4YgjkRvmChIACJpf0/8Ow+7OQgNUlOlcU6HHHFf
         YKuvjotT1GK9wr+FzwibadP3ssqJA1zYwIW/3bFnSj6jwVcCdti7TJgjuD7pYeOC++3n
         Tkp/YGLWi61N3lWgSiq4dUBZUqMy/RS6GmZuJ1bFbXKfHioex3n5JhMQPm/FPZo0a7Nh
         cS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845468; x=1787450268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nVxb6G4xQXJD/mXg4m6AzSd2sAZvdY8O5rYSykKLTBM=;
        b=cjyGXQtB6wtR4yYQLUgPyixiw8MXH56TOoRimhP68R1t0jyayCbVXz/Qg22aXB8KGp
         GlaPoaXYbhpGn1gWT6QbDUWX5RoIBUqtBxLoMQvLsmeP7/JoM16LRaNQ/281SKpvxAkK
         ByBAMTsOBPnwB3xe+FL3CuCDltiweJLxjruIT67XCnE+JcfSoxtwO9ke05aS5zOrOaEH
         Bsf5zGktbnqMkxlHU9Kfpjfx8SNh6GMdE/sagjVYRgC76aASG2+9F4qEd37nH2U7EX5N
         fwWGTd5bJkIMVLZkPiu0JMcan07s7pYjD/ICvrI6omR7+QvoHGtlY4Z5QikYZfWfUbld
         ZssQ==
X-Gm-Message-State: AOJu0Yzjv/ICLHCb05RMeSaW9bUPOEfva72iHbMdg6Aw6PIfiwpXXeDJ
	hW0K4VjRiU3+6cLj9KCcESzCWidliHD1cTYY6Tmgdcjf6lqcRy4YsIPsoScIa/pH
X-Gm-Gg: AR+sD13MymlMabxLpkMb/5lBdsuKiYyUfKA54pSvGhX2XIRgI9ftJS+elSrykFYlqi5
	cJNY7iRRROBtwM6ZZTid0tYfIkaHoZSFQD8HFFrctuSh9AR/IZlJT+otOdcLovcuWY7c8+vGng8
	uYXGzsCvNEkSMBOQ+dnN0h/YLnayUHcMXAWdcLf27pikpkxEwpqHsawvRQgcU/zbuvWvsZvTVK1
	O9ozSOWueg/BlVidKF/3AwcCpiKasYNGoCDtU1D+mgcZr067DCcHV93qXBBpVrPJU3GNhWjT4/l
	p9LU+hfSSGhz0ZHZ7rlKCYj2csRsLQHGlcocUTtjjpROSO9ItSvFT7H7uldnOKmjc7M/DWzempC
	LqhbyRhGynoUwuFFPMtQ/Q+iHwaMY+NHdSW6Hk4Nz+ZKumAcsnU6uQZwtoXJ/GLaIWR5gmQW5ZI
	Q3APpPOeL74RSXPFw0EpDIApHnwl8sP4sPezMHtesTD0JVfXVIPYgyDr6efl/IKk1z1mD9wa2X9
	gRjSnRDixqyqUuWxtch66yIHRC+ip0XEQimB9lZ+qBE8eU0rE+MqCFdEBwtdUsZnlyRnnkHk324
	OObjQCQlk+VKUZDK97iH9qMtcSk=
X-Received: by 2002:a05:6000:4383:b0:481:512c:b6b3 with SMTP id ffacd0b85a97d-481606f4671mr20169783f8f.3.1786845467633;
        Sat, 15 Aug 2026 18:57:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219e12sm19340574f8f.10.2026.08.15.18.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/14] Follow ups for verifier errors set
Date: Sun, 16 Aug 2026 03:57:28 +0200
Message-ID: <20260816015746.2632990-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=memxor@gmail.com; h=from:subject; bh=rmjRXKU3+1yuW+bwtzwUCNpOX9wX8FgDEB9FrwurdQY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQsRivmjpsdq5i4+9+dN1bi7ze+1fE6cuvP7t6v1Nd 2Vef9ju1FHKwiDGxSArpshS8n8fk/GJyt+Btsu4YeawMoEMYeDiFICJzLdlZPh4K+708vOXls5b aGX3+61g+OP8wwdeekn4fzksknaySJib4X9e4Rqv3TkH7gof35CxhkfZnFX8a2/Bcq+mV4mJYsv eKHADAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some follow up changes based on comments from Eduard, Sashiko, and BPF
CI Bot. See commits for details.

Kumar Kartikeya Dwivedi (14):
  bpf: Correct verifier diagnostic attribution for stack reads
  selftests/bpf: Test verifier stack-read diagnostic attribution
  bpf: Preserve R0 lineage across helper calls
  bpf: Drop dead spill diagnostic condition
  bpf: Use canonical stack argument names in diagnostics
  bpf: Correct kfunc argument diagnostics
  selftests/bpf: Test kfunc argument diagnostics
  bpf: Report non-sleepable kfunc programs accurately
  selftests/bpf: Test non-sleepable kfunc context
  bpf: Correct Program Structure diagnostic context
  bpf: Preserve source attribution without source text
  selftests/bpf: Test Program Structure diagnostic context
  bpf: Distinguish function references in policy diagnostics
  selftests/bpf: Test pseudo-function policy diagnostics

 kernel/bpf/btf.c                              |   8 +-
 kernel/bpf/cfg.c                              |   6 +-
 kernel/bpf/diagnostics.c                      |  21 +-
 kernel/bpf/verifier.c                         | 180 ++++++++++++------
 .../testing/selftests/bpf/progs/dynptr_fail.c |   5 +
 tools/testing/selftests/bpf/progs/irq.c       |  13 ++
 .../selftests/bpf/progs/iters_state_safety.c  |   3 +
 .../selftests/bpf/progs/preempt_lock.c        |  15 ++
 .../bpf/progs/refcounted_kptr_fail.c          |   9 +
 .../selftests/bpf/progs/verifier_cfg.c        |  40 ++++
 .../selftests/bpf/progs/verifier_gotox.c      |   2 +
 .../selftests/bpf/progs/verifier_loops1.c     |   1 +
 .../selftests/bpf/progs/verifier_unpriv.c     |  18 ++
 .../selftests/bpf/progs/verifier_xadd.c       |  27 +++
 14 files changed, 275 insertions(+), 73 deletions(-)


base-commit: c93cbdb13f995f87b5356329b3fe551c80bb482d
-- 
2.53.0

