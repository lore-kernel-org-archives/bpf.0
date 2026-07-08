Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4FF3EA969
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501327; cv=none; b=fdsN8zZOzpRROWnhi0Kw9qxNMxTlL2gFwppthdw7hw7xeamTD/xpPTMPt02c7Tg/6abwqhrDJAmp4AuIP5rE18Mqk0Wn5Bppul6+HGJnSDZ+JZeFrCvkfE02o23kyk3aqX3HhUwNKV1ejm8G2lv06JTmYZGCScIMiggXAetOup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501327; c=relaxed/simple;
	bh=M1P4/cPSFe+WUlSiXFOFYdixMqAxgBQz5tvO8+L8ULM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNt7g18kwwyeUF67IahZst/p0z73hu7bb5C+cbz6BJVmO5ZbHNRC71XznWJLftltauzUbRxTaUQJImpzTwyYQv5VxQ/8JCUZXyIifHU+VVs0oEugwBxbcnSAilCiHLriBS4GApYYWCS4lpOfi4aRGUQr0zbDnJcmZr7az8663bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6NUFI4/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6NUFI4/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caed617615so4215685ad.3
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783501326; x=1784106126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zJQzme8jzbB96K3QvlmGt0r3KOuvo5Qma1CtSmtIkL0=;
        b=Y6NUFI4/RyFPywcEmi6jt5TPey6KLqdTPlqU9MQezey4TDnrO4EjwO6zPfvOAv/oco
         BQ+WDTz4/wwV/ewpbv8/SpnLeUxeVMOsfs7cbiRtqgm6jdCM26OiGVDa7qzxmJ+h/M+T
         KpjrISxIZDh/MCILPC4afB8rqwWmqnkAa79RCeYj0UONHyW+OV0pBGemcfnlicIlcDLy
         ZFauA5HCfjaZ1yO9sNu6RZ8MsXRbaRkqKzg3UfANZvpTmCcvrsZIBajx/xV4MMA4E+ta
         iGAYKv91JIKX/IwuHhIqULBGdGWj/NMUM/AAHix/nQYaxs73gw/P1qbiOXkx8712Ot46
         q/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501326; x=1784106126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zJQzme8jzbB96K3QvlmGt0r3KOuvo5Qma1CtSmtIkL0=;
        b=ekt1ilJdDXhYd+WMQ1uowJlgEXUNPiLMYSgx2qWa3OlIcysYRECnGm/Dg+zHnDVYW6
         ow0jHep8wuAvRRgWCh94/obyDxU5qPPYNQ+eUopzNzGOqhkwuVBFI000AWU6lh1Nac3T
         EiUiHtZri4O+ZQaWoTjAChyUhcneER2p9a1x6+TSo7XSHG/UzGN2Ct/DnCDgQhpUWjax
         ksz12/Dpow3lIP+klcxTvnApWj43Mqkxky23xHYfn9S4bmLWlnOibGbEifr3r2reZOO+
         Uz3u24QOn/yMFFejmS4M3nSWncfegjsGBnGJ3shtLNutOOf4dSNf3k7Wm/FfLC8SFI0Z
         2vlw==
X-Gm-Message-State: AOJu0Yy85M6RqeBUiq4PF1pbx2fPIgJJTvR7UUyI0B9iXviK9YtjtsMl
	KEAsevx2yOpPz9zqCeUfKGCNv0RKItvW9aNgTn+dM7eFtJwt+mgL1xeSyEXvf02pFoAa3w==
X-Gm-Gg: AfdE7cnLimH0Jk+BvD3vgPb4gIqOQ4CYDaWjbFHsh1LOVJQXCFtYnV0AlWEaB5AMTZU
	D3CCy9yI5IopI+6rdAffo2QGPvLONFo9WWPbTJyVqi6hbc68WerRTVK/TenLwZED7GYxoGpCp4E
	nEGEpTWt/JVD1REd+MWIyYAXUiJJTIbXQRau2LpSYfNYYHfpb5TrI3jO93BSqcrtGAgyCb4mJVJ
	nfd8JcLQancn3/yzCkmwyNt1h7bcH6DUWtsmTZ5AxPHnyqgM+13fGDFz5um334zjiYadlV+PKdL
	J/FMEXCf5YnicVVAP3rhMqLACtfXNSFv6UHHdGH08MW1+57OE6iR3pBm8B2eGTzpHLJcwTX9SSs
	z9ZUbS8zCGrMdpMTLBU6ExW1gLb6wvSDkyg6dIZzixtghOO6/6lOg6OEDbeG5xYrmuP8efYuyPX
	S94RfsAfOJbnOjhyCHMh+VFoH7PUISlQToJaZ+FzPUaTxWPQpz40D+oYQKl4Sr+24toPYq/Ct32
	LEcqe4zRnxdpOywPAdbyZ9C3rbe6kAeAw==
X-Received: by 2002:a17:90b:5290:b0:381:6466:7160 with SMTP id 98e67ed59e1d1-38941acc1ddmr1716634a91.26.1783501325649;
        Wed, 08 Jul 2026 02:02:05 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.tailf6b5e0.ts.net ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm19515493eec.30.2026.07.08.02.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:02:05 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	mmullins@fb.com,
	shung-hsi.yu@suse.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4 0/2] bpf: Reject negative const offsets for buffer pointers
Date: Wed,  8 Jul 2026 02:01:49 -0700
Message-ID: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject negative effective offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
buffer accesses, and add raw tracepoint writable coverage for both
load-time rejection and the attach-time max_tp_access path.

---

Changes in v4:
- Correct the Fixes tag to point to 022ac0750883, where pointer offsets
  were folded into reg->var_off.
- Drop the end > U32_MAX check, which is unreachable after bounding const
  var_off with BPF_MAX_VAR_OFF while keeping instruction offsets and access
  sizes bounded.

Changes in v3:
- Check constant var_off against +/-BPF_MAX_VAR_OFF before computing
  the effective access range, matching the existing verifier pointer
  offset convention.
- Keep explicit rejection of negative instruction offsets and keep
  bounded negative constant var_off valid when the effective offset is
  non-negative.

Changes in v2:
- Split the kernel fix and selftests into separate patches.
- Add an attach-time raw tracepoint writable test that exercises
  max_tp_access against nbd_send_request's writable size.
- Adjust selftest formatting to use the 100 character line width.

Tested:
- ./test_progs -t verifier_raw_tp_writable
- ./test_progs -t raw_tp_writable_reject_nbd_invalid -v
- ./test_progs -t raw_tp_writable_test_run

v3: https://lore.kernel.org/bpf/20260708040715.116680-1-sun.jian.kdev@gmail.com/
v2: https://lore.kernel.org/bpf/20260707060804.93561-1-sun.jian.kdev@gmail.com/
v1: https://lore.kernel.org/bpf/20260703035137.109608-1-sun.jian.kdev@gmail.com/

Sun Jian (2):
  bpf: Reject negative const offsets for buffer pointers
  selftests/bpf: Cover negative raw_tp writable buffer offsets

 kernel/bpf/verifier.c                         | 40 +++++++++++--
 .../raw_tp_writable_reject_nbd_invalid.c      | 58 +++++++++++--------
 .../bpf/progs/verifier_raw_tp_writable.c      | 16 +++++
 3 files changed, 85 insertions(+), 29 deletions(-)


base-commit: 12091470c6b4c1c14b2de12dcbae2ada6cb6d20b
-- 
2.43.0

