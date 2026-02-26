Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE922176ADE
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772080269; cv=none; b=iBiC5i1VEntgX5Id4cIcwbWakk3R+EaQPWrJrK9Myz6k7zZVDrmFZsSBfG+yP5gyGrhxbZ7CX3xYdgfzAiZT3cx3NmqwOz25CWRuMi60MQzB9WW7SlIEQ4xd7mCxTXpe/5IchHJvbHgnKLEYZBpHwraLPISoZVrZy9ujGLWtjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772080269; c=relaxed/simple;
	bh=8EcXOIfbxB7R08O7d8G9wK5+qWq7+MR2cpJanGaLWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXkYhA4XBCHjum4tJ2hwn2JlsUdfVK+pWX/lTLUtno0jF09DiI+AqOeziciLrylTj4aR96y1PGtZF3AQBDEke4AFc13TpHJlZ5R1h4f61SPWrBkpC6n62CdEOnzdh9wsoL2oxTY6JwF0y1u8+ElTUGMj468gh4O4Nj0FiD8OzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk36eV3S; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk36eV3S"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4c9537f90so289994a34.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 20:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772080267; x=1772685067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYwfESLjaCDRSRMKB4RVN6Z8w5OQLpXEkzl6yPxOR/w=;
        b=Vk36eV3SWC7hpBZiRmwr6w3f4QgaGXtYMCl7L5VXZNO9fF8Nhw62Y73MDbratIrOPA
         +Y+X08ZDW4/QxAqumMdPEyjIZcAahcG9g65YPgouYznAjzeI+H4asn7cl8M98DdroZgW
         N1VjLH0odpwkrV7iWDOSpgaGBgDEXIWNHGASImhMafDT8Yd3RNMeRwjjAsFo4t8Mr09V
         Q5I8tyiNCBePLo4OrDDWeJ45Qfx9Ojqun/Jv/fe8VFe1HcRMJTfrJgYEtyeqQ0sj4J7l
         Cpd+NiibBi0sTBSoF9HTahKVjCv8c/KeAPpK1ETxBHFkUJQ305QCrX7SnroXDMNlVINk
         OatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772080267; x=1772685067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYwfESLjaCDRSRMKB4RVN6Z8w5OQLpXEkzl6yPxOR/w=;
        b=ulBov+ngGjmoWIDmO1EFKlVgyCPvfm5r2Tqqwha5arbDU0V5Vv/ew2KLaZ66kKP/QD
         fushBYqe1iiCvOfgzZ2/UZhNFdu75K+6uBKc+W99OFEjEx6A9z+Zyx9Vpx14rsODmh2+
         wfdUpEEElq/DGcu+DwxloXujTUM6CowqrcGnIpumHsXWpJvVVYN8TgRBe34PFuq6480Z
         0RLK77OwePmEy4OGQLy6Wx4wOseURtGsCgLAWpUntCktyNABKXWmjFGWdAfFtegylMW1
         UkN0mJn7XopApSWD/VkCKdaKfIVnF69bCCig6Vi2kjWohntQXy60lbP0xmd8Zyi/j/dh
         TgCw==
X-Gm-Message-State: AOJu0YyEo4j2sNRBlFih0qktUe462VZBhW4w3FoLiBx6IRd6EmyRjDAC
	arXI03LcufjE7sSdGzRFDeH4ztROvNGe4wcXmA+MdWiB2V5+hthoT9qX
X-Gm-Gg: ATEYQzxcg+HmIHVTMyTerO8whBFYR+IxHWwPvARKbM/rQSLebzEoUcKvcGvu93pVWjX
	zCFp4iVDxFEP3w7pyVwi+O7m28tFhvO8vXB2y+IZj+bKtvY6n7hH8svEHXhyyg9WkbE50sfcuRc
	3d05Q+iddak/Fwi/P9dUHnsvz6YXdXUU15hWXge+qVBZBR38P5R2zsdTwt/hcy1plyiZNIED24C
	/SdbVNi9fpMybtiJQqGT5jJk1vdMe1BTSakwvC3m1SjltHhmontRw/m10hp/MZBhV/QRBGgOnst
	o5UhCbXCdv0XRAs2m01SOWEeUQ1HyGJlCQL+hXLWfAv6wBvNoVk52VKyHlrYWAlA72axzpSA1hF
	5xI7KiJsLD1sGMUGGdZMD4lj+KvVQQnUOAbd3xPLihjayfl2xZuXSbaaPy75E4sqtXStOO2tsdg
	hUripMa22gaP+UT2Hi4SF5yls5YR9D953GMEHgi/6Tvn6v/ANtEgeGmoSI353tE7kqi0ZTGPNpC
	oLx511nhntf22VX6bAAo74=
X-Received: by 2002:a05:6830:3908:b0:7d1:9832:4796 with SMTP id 46e09a7af769-7d586eb9657mr684628a34.16.1772080266855;
        Wed, 25 Feb 2026 20:31:06 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586653f81sm806659a34.23.2026.02.25.20.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:31:06 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 0/2] selftests/bpf: make probe_user safe for parallel runs
Date: Thu, 26 Feb 2026 12:29:47 +0800
Message-ID: <cover.1772079741.git.sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe_user selftest attaches ksyscall hooks for connect() (and
socketcall() on s390). Historically this could corrupt other tests
calling connect(), which is why the test was marked as serial and
carried a TODO warning about cross-test corruption.

This series makes the test safe for parallel execution by filtering the
BPF-side instrumentation to the current test process only, and then
drops the serial restriction and the stale TODO comment.

Patch 1/2 adds a single-entry pid_map and checks current tgid (process
ID) before calling bpf_probe_read_user()/bpf_probe_write_user(). The
userspace test writes its PID into the map after loading the object.

Patch 2/2 drops the serial_ prefix and removes the outdated TODO, since
cross-test interference is no longer possible.

Tested on x86_64 (clang):
  ./test_progs -t probe_user -v
  ./test_progs -j$(nproc) -t probe_user

Sun Jian (2):
  selftests/bpf: probe_user: filter by pid to avoid cross-test
    interference
  selftests/bpf: probe_user: drop serial restriction

 .../selftests/bpf/prog_tests/probe_user.c     | 16 +++++++++++---
 .../selftests/bpf/progs/test_probe_user.c     | 22 +++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)


base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.43.0

