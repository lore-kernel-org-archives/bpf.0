Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135853DDDA1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095054; cv=none; b=lYoshcbn1mvyYVnvfleuRGZkubfPrjsO3buakyO/0VIUcuDgOQGhlx588NnuDaXDdq57BknWfZcv5wlkgzte3o4MT298Khro6hNjxK9d+0lFUaILGkg78+5mS54YYD9cxUJVHHfelPN9tzIBySzmeGW/Wth17+t2ooclmUhulGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095054; c=relaxed/simple;
	bh=epmlN9OVx9BrZJP/DwEn2fIy+3NjmkMOFdqRGbLZu6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUJk4GDac6L/tbmONyF4bOgUO5vYLhrIzIvSDabPSE9A7ShOxthI6jJoju7yYIyTXIyNtKTWY8EmjxGLNPdnc62LiFVkPrQUa/WeAmQknRus4Tvg0WdtiUt95wxZvXarfKfEvyg3YhRB9UPFeROOYgtkQZl1peEaUuoBa+XLswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OykOHBF0; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OykOHBF0"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc1631a57d2so203127a12.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095052; x=1789699852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wqyR2wao86Q9nPBO5k9SKbv+jrQgU0fSqFyrHKM0Jqo=;
        b=OykOHBF01ggKcAbZAG3N4O+BakrrhbuOstf3jHIeb3RBAjiJIpA3M8lwyxddpjhpcU
         Q0/9EvbygE+9gzUP8I3bWlireoLoZ51H5IzwZeVuTv6lJx4HrGnhpo6tmtpBZc1ENxrw
         PkvdZuQ1rcHlGbWelAfnl76jgkvML045KH/YBh4OQJ2G7MXw15Z7nRJFnkCorfLRHOTo
         z+KO/5iGmxGX7NvsaCTyxyM40cdQyPxn9N9sw2h1xPIMcHstufGo6qHQj9ORRhQ6tqX4
         Dom38DjyLPFV3/Mw88JhFLubC7GggDpprfzqPGCs4rTopUpFHIWiLYF2xhyoy83962sC
         /0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095052; x=1789699852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wqyR2wao86Q9nPBO5k9SKbv+jrQgU0fSqFyrHKM0Jqo=;
        b=Hl8TRBCZcJNcwMjPuoJA4Fxi8R51LUqMIK1997PEFihpRgEYRc115rhC2CxnzN7WaK
         I4mqt0hEG2bdyGn0zrjHNdX27DlV418GgtTw43YdR4GkcASyjKDiNfDmKk926/eH5WvX
         8MLglIXjEb91zCdoNfgAQa32xW4frE1RYh1tEmpMCfMl5hMrP35s+In5BMoxqm7o8mVM
         wQlvwvx9VpII4bj60yvppZhlyI2zMztZAIeX2GI+HPi6eU1kwVm0rx4W9vPBqW8D/Vm4
         x5McnAQV0j3nWUvB/dS0Z7tx+IHM3nNDDEA5KxfyJQDyCNykqLkJRBRDI3r7bobApMcg
         YzRg==
X-Forwarded-Encrypted: i=1; AKwUvBxDNHir1k9o9iaV+Wu10bYYNc0YPldYKV2OjO2o9ZQL9RhkYf27xW0Tgc9+2Sk3LQy5tLE=@vger.kernel.org
X-Gm-Message-State: AFuF++ljrcMN89k1+1KZjs8XdOx0q5lzA+zMrSMeluH287vZroJdIAn3
	sWFalTAOUY9qZYFbzI1jEq7EOy9y0/mBJ7jLN9RUENj6/vAa3S4gpnqQ
X-Gm-Gg: AYBFou2+LKBp6tM4+dnZXDJgY9AGFnLB2UvrWFKOSCcCdfX7BfI/YRzwJluuU7+SRyQ
	P1Ky4+jzW6JF1NU4rAHeYnLKEXTXnLqdCu4IKZJvr2HJ6xJGsq3gDvVpWIxezmicWV7FGXvSWSs
	q6ccheRcupm1TXsxpVstJEoHO7Mlo9ykx7FWrWV8cXGYZpsNOgWLWeOiIiBjRhUmj0yUHD9NXDP
	V/UsrsIEocvCriF6IQTzrJFFG4EzFKBGn0qjgq0BBW1HpycXhTcbShWbS2zaIOr5C6hIv9zwNBZ
	+6Ai/+6BLPizjfhY3fgNo0ErrpHeVjfkqcxocVGOg1UUMo5edT+x5NhmfJmny+vJKSKY4hSzw7o
	C5wjP9x4wRvif35VShxZKODPdqnjDuqInk+/n6EbRZ+oDlGwJhpTQHZAmVCBguybYlwi7HhgLxo
	HlQjkPqScPC7gDGT4+qkv9rq5c1h+LGArkQG1NiQgjN+fVASVc0mkZge8derKXSUSL
X-Received: by 2002:a05:6a00:218e:b0:857:72f8:dc94 with SMTP id d2e1a72fcca58-86b31dfa566mr3130465b3a.21.1789095052137;
        Thu, 10 Sep 2026 19:50:52 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29bb8f28sm385299b3a.40.2026.09.10.19.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:50:51 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpftool: Support symbolic map creation flags
Date: Fri, 11 Sep 2026 10:50:42 +0800
Message-ID: <20260911025044.190540-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comma-separated BPF_F_* names to map create flags while retaining
base-0 numeric input, with matching documentation, completion and tests.

Changes in v4:
- Add FLAGS to the map-create synopsis in the manual.
- Rebase onto current bpf-next and shorten the commit descriptions.
- Use Assisted-by: LLM.

The v3 parser, shared feature-list table and completion behavior are
unchanged. Earlier requested functional changes were included in v2/v3.

v3: https://lore.kernel.org/r/178874713816.1519295.5079603775338308680.flags-v3-0@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/57

The previous version's CI PR expired after repeated "Patch is empty"
reports. The revised series applies cleanly to the current tree and is
sent as a new thread using git format-patch and git send-email.

Validation:
- Built bpftool and its manual pages, and built the focused selftest
  runner with LLVM 20.
- All 29 bpftool_map_flags subtests passed with no skips or failures
  in an x86-64 KVM guest running Linux 7.3.0-rc2 from current bpf/master.
- The four bpftool series were tested together: all 69 subtests passed.
  The cpumask suite (36 subtests) and test_maps also passed with no skips.
- Bash syntax and the existing bpftool synchronization checks passed.

This was a focused run; unrelated selftests requiring unavailable kernel
features were excluded from the build with PERMISSIVE=1.

Tianyi Chen (2):
  bpftool: Accept symbolic map creation flags
  selftests/bpf: Cover symbolic bpftool map creation flags

 .../bpftool/Documentation/bpftool-feature.rst |  10 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |  14 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |  22 +++-
 tools/bpf/bpftool/feature.c                   |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       |  85 ++++++++++++++-
 .../bpf/prog_tests/bpftool_map_flags.c        | 100 ++++++++++++++++++
 7 files changed, 226 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c


base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.55.0

