Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72C2FD1DA
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514759; cv=none; b=mc1zcHHjsTy0rBF77UHue9tYeR82UEhSju+uZA8Dk1CWBbkM0MeBn/FRT7+byZTpC/qEnny5TZkBnzFuAOFsMYfEHV4esMETLbx4h256CPkmq/ZrpHOScEv4TMZVFnB3vgc4EfuJX/RjCF+wYRrLqWy/J0Dg16p1yhqP8uT5mMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514759; c=relaxed/simple;
	bh=JGZx8D3AiFrErTuoU0FrqK/CT7oLLn4i4hc1DaMaC+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMiwILfOnLTfYNZykvyHfVdvuy8HGL87FBmWKB+M6IRh7/pMgKQ4X8sFLRNYjkJx79mwPxBw5V5dqKdM9+At81eGkt2+ri0mFvARaHooUTa+LJCJpvdcw+LmtzogfOMTJ7RFXzISaTsgT4VH7NxS/W8zV14GUC/qB3xXqvgEJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MENHj7sa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MENHj7sa"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381b831d535so993913a91.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 23:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786514757; x=1787119557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJeRc6NIdYJWpqiv4BgLI37pnQKi0Y2aUwjG7aMbH1Y=;
        b=MENHj7sanhwRTXFXydhQp459nRhEbwAWRQkg6cN7ap20hfJSbLO5q2BuX8890E1MuQ
         7GN5/2npZD6UVJiW3Ug3HwaCVGnXHCMu4LICNqmidNP5XXvjyZm5fPAUQrDLg5hJGfwU
         6UAbTYWkI7kyI8dVTON8KbLGQWzumffOEfI/wiUtB/KQ0DHjuxjgtXO1i2gLagZWeDCN
         p/DmTTyluZkb4PwRpwwxKvwjQ6/YXTdb4CHBFExrM554ImBWGTi1FNWYujyQy+Zi/Ijm
         xVKXpV+t1zWRZ2Rg08Zt76kbvZiFMgotNkk4a7FuYvFNboU/p1kFifryVYEc+UioT7Q4
         PX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786514757; x=1787119557;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FJeRc6NIdYJWpqiv4BgLI37pnQKi0Y2aUwjG7aMbH1Y=;
        b=SeirZNQ9077uc9P2IugukX5mbNU1YWLJSeHRExIVPYQ097LuHbTzWx71FW8wBWDLuZ
         U9u58s2/J133n1ykveuL9xtfGT7zyG6D5pMePtjOohuYyOhPeTfE5zY0/I+F0Mej+7HQ
         h08cMBMaacPdlJXz83uwcDZNAvJl3HmX0JnwE4DdXO6b+qJkSUkEs/36YoTyUQWE+HfN
         S2Pxjd6KGvKdxAsQkAAlLlEce9/rMHJU7LLpZTxARs9oRGcBZHHiMp3kOIhW6PTfjFb3
         /jaAeAgbPBG1BC5ZYER+Fy9zYsPA7sWfWevquUMyY+1Y8KxmCVsePBa1jnnCA29Xueem
         A9YA==
X-Gm-Message-State: AOJu0Yxa9UaqH5Seoa07kL22PZHJVPZNDa1ocpIT+OAcF4eDGKgiZOn+
	GMcn7GwZKkPztbl6jGOPPDp4LppeWd+BGO1PNmG4GR5xpau5UpPnn68xoRwlUQcv
X-Gm-Gg: AR+sD10tvAa0uKDoNlpBxT6lgWW2eoN1fRsePo7mC43ZHTzQqziNwRZlqUhWZlJ5zOS
	IddxHYZQTBO3TxZFwfPl1cbwFZV2nLIa2vG2/lSInrOeux1lkpkEIwcC2gED/Xg4oRq3FfcnxqR
	vFPY6YQ0k6/woFaqaTABow9dQv3aAHNhI5uZwwNH2RG0SWgrfcp07lrVBZCmNn1RBperHkirdCF
	VhxoCADoEhT1aVX3v12jkhgoLd1YUGGE0uVfVrNzE2GXzUyynVRXGtbPOFQ/JfT6sUwD6yea40C
	GLkZpO2dsi0RKtdHFRoJPNfY22h15xd3A27ftskXm+PQCDDYqwV1pI8pN6t8WJjNLdUFQeMckPC
	Tgry4rAOYIPERbF1K1WXadSTWZameafue14RWJ10qREAlst8krjuDmIzddD+vs3uYAMpTb5sP0z
	yloIkVywUFwjfL0D8iWv1AwM57XO1AfZH8gD9VZKb6kp6SK6dS+OEVcaD2QGJ3MLLsCokHQpK6x
	3MHdA==
X-Received: by 2002:a17:90b:4b81:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-393011b2a20mr2529203a91.1.1786514757306;
        Tue, 11 Aug 2026 23:05:57 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f88d1e8csm2314520a91.5.2026.08.11.23.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:05:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: fix for veristat file/prog filters processing
Date: Tue, 11 Aug 2026 23:05:41 -0700
Message-ID: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260811-veristat-filter-fix-920cff2a288a
Content-Transfer-Encoding: 8bit

At the moment veristat filtering behaves unexpectedly for the
following filter expression:

  -f !file/prog

The expression rejects all programs with name 'prog', and all programs
in a file with name 'file'. Fix the expression to exclude only a
program 'prog' from a file 'file', also add a set of tests to exercise
filtering logic.

Changelog:
v1 -> v2:
- added fixes tag for patch #1 (bot+bpf-ci);
- extended test cases for '!*foo*' and '*foo*' filters in patch #2
  (bot+bpf-ci);
- added patch #3, replacing direct read() calls with calls to
  read_output(), guaranteeing input buffer null termination
  (bot+bpf-ci).

v1: https://lore.kernel.org/bpf/20260811-veristat-filter-fix-v1-0-b5b43c431550@gmail.com/
---
Eduard Zingerman (3):
      selftests/bpf: fix for veristat file/prog filters processing
      selftests/bpf: exercise veristat filtering logic in a selftest
      selftests/bpf: guarantee zero termination for veristat test buffers

 .../selftests/bpf/prog_tests/test_veristat.c       | 113 +++++++++++++++++++--
 tools/testing/selftests/bpf/progs/veristat_bar.c   |   3 +
 tools/testing/selftests/bpf/progs/veristat_foo.c   |  31 ++++++
 tools/testing/selftests/bpf/veristat.c             |  76 +++++++++-----
 4 files changed, 190 insertions(+), 33 deletions(-)
---
base-commit: d114bb98936770c501c958bf2bc5fb6b7c0bad7b
change-id: 20260811-veristat-filter-fix-920cff2a288a
