Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306E2C11D9
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098310; cv=none; b=bLjyAfhFYSg3g5eMwkspZLjSr6VE2Nbd8/TecZyvVuxMiCGj4LbEwiLeT7aC9amNSLLu62UoJy4VV0hgabM7zpuhyhYl6h9aWgQZabThCt6FZ4iAH9tAA9GC6Xvog2m+hdtWMm9ij8ysn3Wtp8YN+mVv88X0Q2vU241QrzsXFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098310; c=relaxed/simple;
	bh=oFo6+sTPLkyTSFK4Ji1vRa5rCyrSWUa3s+0eVqdj7KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+Z4kqJgJzZ73Gvc4Jb4t4hFTFFuEC3vapSLiWmwyGKD42V4QpmlyCgM1saUTP/1W1xj8itEAnL8swSu3yaxAMUkCAGh97Sj/GwZLl2XuMgGwLZ7CBtgfMKr0Zn6KRMvgk8oxTZyCEqgQTl85mfWDPIsj+PpkpNhT4y7g1Vhrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chc6P9J6; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chc6P9J6"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271195d2a7so383706c88.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098307; x=1772703107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nm7W+k2pCT1m1taH8JfT56CcqjdfxYGmMvs5ermu7M=;
        b=chc6P9J6k5YDf5LOpQGnpJ5A6fIPmSogKJz813HXg7tz+DtrSYvsJ+h5seqUVe3zA/
         fTvGC2KlPL0mz0DPlFeTFjqwVUWGmviIzDnsclKHFBKJB4y7z7LRgGhG4GYGRH72egOE
         OFlpZaZQQqAwl8yNhJWMNKXRXG38r7vPZn+2fwT0RFEUIj9kV4LFkIl/6xU65/JTTNxb
         gIqUPyjuItyhFoLALhrLm+v9T1b62HWe46/f3ELw53qDTOO5Pxf4efz2RHv3JY6MjTy1
         DfZdWYhpdEcpzGzsh5XKau0CdY393LeEge/H9DbbNAertAH8cxpXvhw8Jcbouqih5owT
         ECUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098307; x=1772703107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nm7W+k2pCT1m1taH8JfT56CcqjdfxYGmMvs5ermu7M=;
        b=thh13T/MlUOnovvWjdPtCaBJAeQ/ZDG8avgOm1ku/6JG5X8f+dDKjA4MjV5Tauumb0
         WistpVfX6t8m3YZW+uYHPPyWX7AwAEQyyvd/+iIu5FAU+L4iAoIFjzbELCbTc1ASnbjf
         LoUTANnldd9cjkd4CCqERf81bLmE4h8Wov/l48P9EjxyUuEsoWt2XnOundBuRg+w0I80
         0kbOB6V1wsjsYTI6me9KrfC5YC373qgw+YghATZLyu9Y894C/SdNGTvrJHJdsNP4yA6U
         lsiG6w8Bm6c/O7ZwBsFPWKwGJW63o+gYROZWupFfnJzk0jFXrgl9/VV5z1sAFC91KZxE
         dMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp8M3GMidV3Gm456gUK+OgZjOsrmcC0iTQ52BbFXcxHZ0J3+ZNzGBYovMnl3KF4HEveBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJpHN4jz0+i3c11Ao8crKTZMv/tRVNt8KXD5WRaf67RYNAbSW
	oXe9fl82ngEwB4FnhAWM74+TT2ln4Eu1xDFsgY8sr1A8QPxUjRjhZPLE
X-Gm-Gg: ATEYQzw6S4hAAw4+4HCew5qIFXPRSkvyqz4HiwXIT1x/LyXZhZLvewkfSE09QMyRZAa
	BPRT5MN6FJ+Yy/VTK/ZcsGKUlqtWVX50LZsMYfmCGsVN7nP1unZdSHbFFKMcZiwte4fW8UKd1S9
	UzRWtVO6C/IcAlNxDW3/4Y1cbv9s21TtzqXwHHNIa63fL0rabrYFdoQEDG2jKf0XSRjK64o6dcH
	pLVFjeWhbxkJPX/pBjdVKYpdM1vQjAZ1QAIgJYzPYM4X2J/Ms5Na23Ct3PH2lWXurwvz98YomQz
	KwhX6vnw/3B2M6FAeKjNm9N+hyKpQeukPl2t8oH3M3Pz+6jBVrXplaA6YxN63/QtoClwL0E1YUS
	MOIAVMOy4ZWBm/maxZntXPGz0nfwPkY7WLtLQJ3xctgCSkycEaznpT8g+ETxj9QTDpr4J86UFKG
	T4Xps4GLsqPF4Wz9JWIuJuBIC5w4U+lVH3B5uI9niFPKw3oOpzEgo6MMqpDNiw5KTHn44c6vJ53
	fDgFpNSQq3g0vK/KMqk4xY=
X-Received: by 2002:a05:7022:612:b0:119:e569:f274 with SMTP id a92af1059eb24-12786990d3fmr1837855c88.29.1772098307410;
        Thu, 26 Feb 2026 01:31:47 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43c12sm1771904c88.14.2026.02.26.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:31:46 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2 0/2] selftests/bpf: make probe_user safe for parallel runs
Date: Thu, 26 Feb 2026 17:31:30 +0800
Message-ID: <20260226093132.437206-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe_user selftest attaches ksyscall hooks for connect() (and
socketcall() on s390). Historically it could corrupt other tests
calling connect() in parallel, causing flaky failures.

This series confines the instrumentation to the current test process only,
and then drops the serial restriction and removes the stale TODO.

v1: <https://lore.kernel.org/all/cover.1772079741.git.sun.jian.kdev@gmail.com/>

Changes in v2: 
  - Replace pid_map with a global .bss struct initialized via 
    bpf_map__set_initial_value() before bpf_object__load().
  - Add bpf_map__value_size() check for the .bss map to catch
    layout mismatch.
  - Move PID filtering into handle_sys_connect_common() (covers both
    connect() and s390 socketcall() paths).
  - Keep existing validation flow intact (bridge via tmp buffer).

Tested:
  - cd .kselftest-out/selftests-bpf
    ./test_progs -t probe_user -v
  - cd .kselftest-out/selftests-bpf
    ./test_progs -j"$(nproc)" -t probe_user -v

Sun Jian (2):
  selftests/bpf: probe_user: filter by pid to avoid cross-test
    interference
  selftests/bpf: probe_user: drop serial restriction

 .../selftests/bpf/prog_tests/probe_user.c     | 30 +++++++++++++++++--
 .../selftests/bpf/progs/test_probe_user.c     | 13 ++++++--
 2 files changed, 38 insertions(+), 5 deletions(-)


base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.43.0

