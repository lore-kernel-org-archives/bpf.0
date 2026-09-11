Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EFE38910F
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098444; cv=none; b=OBq10PIoFBG8N5KwphYdg9BffZVMazuJsIK4jpNMUbyaB6fkaDzNORMum0h+LrAQ6mHog8iZof9I2d7E4FG/EEZTsEON+MApDCzeRc3ITYLm87lQVTZXyZq9FtWNv1fJKs9/t8cR8wJN75e3rlnRO+8sQOeTS5XRWoc1m+HFEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098444; c=relaxed/simple;
	bh=gmceD+kcd31gk8AHVFIPSSY2mHOqJkd58Q5xs0xiIwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXcOSjCImt5aK1HqUT0mCwgxtW+dXt5lbgMgTUXLLWpWrypqmzr/bEv35KJxseFhgflpVPSx5vHrh3kYZ+NJfZTBBWsrMMSyLRXVdXyf/DoMASVAP/AfKt9q+mZE7PeiOxypX9SdV6KqXRTzl0Awqnw3lx2+33x1F1HQRtjuZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn3gEQRD; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn3gEQRD"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso251628a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098442; x=1789703242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tSBKj7tTPySUdL+bd87lctXiwO66A/DYslG01UthkyY=;
        b=Bn3gEQRDJo6lJDe0T84k0ourugy9WXUzMjlnadikKv+dtfwWPeFyKVUHdqnJ8mDF7D
         bY35LTgVNxzo6UubLOhMx2wBEt9MrsGdUMg+GQJotGBIQ7UPAECq0+V4GP31QIDfp4Zq
         Yn7s/cN10RD4liPzufNGarUYC6DsFLSpeyaKRdepF6xRe9VERmoVDslh0TsgmGp7EV4z
         x8aiFzZN0XnSe9B/kdgLpxDjWU3FA1+zbc2r2Dlp59LKBLCc0cdmrwhE5dc3AWrFHbJA
         ZQpqZes5tezRvW9HvMxlf+iOlVAAwdyEeWHFre+5xsQEVIRXF6IFLWL6IoGEoj3gzyco
         rPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098442; x=1789703242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSBKj7tTPySUdL+bd87lctXiwO66A/DYslG01UthkyY=;
        b=ThdoVmnKFRwSh4KzLs8DjAI8bz/ai5SY7IUh6C11M5KcQye5auCXI3b9IVVbzRORrx
         vNH0YK8Ux1CSev37H96pYzx9GgdV5bp4scJ9egd8hOtgj96xoRYxa36dErqP0Fz+rbTQ
         E+dx6gWM/o5FBTcFQ8ASwBJYz0fsQbKUmcUv9R+7ujBtstESudVV1ttvwRg3AwfU4ls/
         wX+28B2RVfivy2tDH0XJ6tIpXbe/h/eyFIkfI7emSDlqA3PR/jye22MtY8ZB94wD7Gl/
         JPq0vcPLCgd5U16HSjy2n5poJqT+vXmpEbxrl8x70hl6c3S4t+YvKHky7Ar/e065a+uG
         FByw==
X-Forwarded-Encrypted: i=1; AKwUvBxY4jUbFXnqa6xOGO7sukexJASnnzmaO6CR4WPIYzIkZA2z1aaWei7+fF4ldTKGQt9ReKA=@vger.kernel.org
X-Gm-Message-State: AFuF++nFaQgefFH3RGqNlHEPyYYDU6Shr96zU8xxZhsmsIsYBPBjmf/+
	6xy1LuS8qFGqV3pF+3430PdYJV5jT2razxMpb8opeZna99TUhFJoZYHI
X-Gm-Gg: AYBFou20JRt+JNSWZLMw/6sMKdhuAFQfaqLkLVc2mp7FkIY5CHK9bf+nISMOQaLO8hO
	71bH37KXBSC1EEIERY2VsvPWVDhV++j9qY2PDi/k41Dh9EUcYzHR2zxm9ppT6Q5APWQrIwpPDQT
	7aEFQop5e2TGVIgVu8MSzKSmwzPhK1UVD3+i5wmoMDVBcLF+tBL8a+VZbqtx00rKP1ICc5lLIYe
	jDAMH/+WMogx1J3tnLJ5+SX6iIZmIgTyFAxO3Qy50i2fPGF8XRo3UJjSQMiFRolm9DO0pB5mvv6
	+i7nrCC6NGvoIPDp75Xljmu37k3vzhDHCzLvj8QmBa4SdmrySgvjTNJnrLoXuxfTxLSCs8b5aaM
	X20b+m0uqmwlQyhDKyD8/A5sxw9TK9BwCbeiIguW7Y2/ppXsODlLJk050ztUsZku0MGy0Vi4UI5
	Wm2gYwKGsTpW6CKU/tnzMakx/USbua9HTewnvVN5hhjEvgoBcfEj9vUiEYyHu2wciU
X-Received: by 2002:a17:90b:1f8e:b0:39b:2b5a:8dc5 with SMTP id 98e67ed59e1d1-39d9bd987a6mr3393887a91.6.1789098441884;
        Thu, 10 Sep 2026 20:47:21 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2285195a91.14.2026.09.10.20.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:47:21 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] bpftool: Add recursive map dumping
Date: Fri, 11 Sep 2026 11:47:13 +0800
Message-ID: <20260911034715.219552-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add -r/--recursive to dump referenced inner maps after the selected roots,
with deduplication and bounded descriptor use. The second patch checks
output formats and operation under a low descriptor limit.

Changes in v5:
- Name the child-process exit codes for descriptor cleanup, limit setup,
  command failure, entry counts, map IDs and JSON framing. Preserve the
  existing values and failure paths.

The implementation is unchanged. Keep the explicit expected JSON
documents in the tests so each case's output structure is visible where
it is checked; the suggested formatter helper is not needed for this
revision.

v4: https://lore.kernel.org/r/20260911025100.190706-1-diannaaav@gmail.com
Review: https://lore.kernel.org/r/43836e91c05ebc17a327d26c28c018d8e09ed2dcaca6fd02b562e37a17a55dd4@mail.kernel.org

Validation:
- Rebuilt bpftool, its manual pages and the focused selftest runner.
- All 12 bpftool_map_dump subtests passed. The three revised series
  were tested together: 52 subtests passed with no skips or failures in
  an x86-64 KVM guest running Linux 7.3.0-rc2 from bpf/master, with
  LLVM 20-built BPF test objects.
- Bash syntax, bpftool synchronization checks and diff checks passed.
- The generated patches apply cleanly to current bpf-next.

This was a focused run. Unrelated selftests requiring unavailable kernel
features were excluded from the build with PERMISSIVE=1.

Tianyi Chen (2):
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  22 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/main.c                      |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       | 131 ++++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 474 ++++++++++++++++++
 6 files changed, 626 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.55.0

