Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689B3EA963
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103470; cv=none; b=jldFi0U9//m5bt5X4ePPgxVt3l9B26E0AY1qAaIEW3hWFeKPQF3TD2QyaMUw0mtTu4z0xMaAkoSOoYNP8aTGSYeUVG7/JHwx1QxnyjOZwPr5cHZN0lEcWV25tBYvCnnrvozGQbQ/QrTveSL6wj7xyCqPTXDKi+sbeU0M2Q2cy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103470; c=relaxed/simple;
	bh=7IvC7itx4XTxq3spcZoa8LyRZc07ShqqbOnpseo9EUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPHojPxoFQRtIBSHkdkGLuSwr+pUl4TSbGP/hAdgsy6oOr2szdU8EDvo4VqX4jAWYWjM8cV02IcnZtZQ87YCGQhydm6KNwJZaXfCANy8WH3PoOt1Y3WFHTXYrb2H5Q30EhKijxhduVW+lQv74O8guG4O82HuEytvx45yCOHFHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etT9271o; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etT9271o"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6fbdc8772so1790885ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103469; x=1789708269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+y0Q5tFoIi1MyCWL57hyIY3/f1lBE/4yfnjE9Ega5LU=;
        b=etT9271oK5A23hpDWNTPRyYPQi6TYatjpbwrDFlA/4A5Yaon6+7Lmev0nNbN5JDd50
         2hQCKO0OY89gceouR+yEGGE0Ghm9u2evA40udDUiTtOMl7JhAQgiHNAAMlN3Ad7Tqu39
         FuDJocSpJSsE7pfJdZus6X2vcdYlOAJUz1Eim5O5bNLZzX2pJMuuKsiQkXWepRgeXd1s
         BKo1AfIc7M/cYn+jyt/sggWHciefvrpQ1f1+Nz5BG3AsTAW2eadmrfFSAdLX3M+slV6f
         xzV+qPao7Vz5tQdNDdPPrxKZyCqA6e9LQ/hIPkWmvmU/zs78xLWPYVq+ltc27ysXC1yh
         MKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103469; x=1789708269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+y0Q5tFoIi1MyCWL57hyIY3/f1lBE/4yfnjE9Ega5LU=;
        b=mZRM7SDtXJPUJn6a3PIV5qGKOOz9A9VqZ93eceE9dJkUBEMQKkb/ACjVLnlqR8Tl4L
         TidvekGDeUqYExOstEQsYSDXu7GrQdhN6XhQXHXCou3RYN7ATWUeJg/Mbq9yhgx1z5V0
         eOuBzGrhzRpL6s6FSkiPrDa2GT7Oe+9jqt7pS58bM+cAJ7GKHSY7I1E1PQygQTOWgGvj
         24GMRe6IuPhABPzTLbb8iEGtYpMMPhY7VY8bKoprkpSaKJat0Lwift86vvl7SxMbNasU
         cscGJs/BQ9v1bQ8spk0Zh/huHAX2vzvLD34OrPuaMyFRW0FRhwv0VQVfNQgqrsMMiICU
         Cdww==
X-Forwarded-Encrypted: i=1; AKwUvByU4varNelVqojYSXzBuC2vwuRAYKX0pqmqD7xJYYLisn8kL7QiUSFw3CHcfZJI8gWnxnc=@vger.kernel.org
X-Gm-Message-State: AFuF++n5X4LqAfiR0fJFPdW8z0QDmi4/WOgA4DHPY8MHYxaMEsK+c4Gr
	0xMc96BLV0brb+JRDe1TNa89OnLUCfAsG6WoNakKwnMhrfV91ry5ZNiQ
X-Gm-Gg: AYBFou25itTWEO2zbFqqWgKwzlwtgcb7KGTYllNNBXoDRDmQYk2hSZQYvezpZqFNgdc
	K0SCJCbc5a/AHsopEHpeP1ltiKliATixylq3epzQGEV6+WpC758ZM8CJoiSMzX9SY4h2K1+FRvv
	StAl5pwxtIDgJjQYEhwQOB+ynOI4l0I5617wbUkHSkOFbJSqrWm4mlgCDG5qUfmOQTQ7OI7TBRL
	ceQGbENmjFIAYmrwS+719aKpqaixBFbFgY0EIMrm6at+wH9npVPQXDQtveZ4HdPI0gR69sywSrb
	+bEaPBFROn5FdfiaReDs/RMHPzmKiANYa2X9QpKmgbD+1QXs1IgBRzbR8KolsAMqtco0bOFCGal
	cypbrlLewP8paG3SjSwjx+0o/JZGPWpUSZTihZGsEQvLvmaaTcmH/gQH3qtKF4B0E8hlI4YG2Cz
	uNOIHQogTZ0bGv+mjuNHW4kZPDEU5l2PeOaGpf1NjvmA==
X-Received: by 2002:a17:902:ea0f:b0:2dd:319:c9ef with SMTP id d9443c01a7336-2dd2a1c41camr49447845ad.3.1789103468401;
        Thu, 10 Sep 2026 22:11:08 -0700 (PDT)
Received: from fedora ([2602:f921:f20:17::a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e5182fsm3018993eec.9.2026.09.10.22.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:11:07 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 0/2] bpftool: Add recursive map dumping
Date: Fri, 11 Sep 2026 13:10:51 +0800
Message-ID: <20260911051053.283421-1-diannaaav@gmail.com>
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

Changes in v6:
- Grow the pending inner-map ID array with libbpf_ensure_mem() instead of
  reallocating for every ID. Keep the existing bound on open descriptors.
- Check snprintf() failures and truncation before advancing the expected
  JSON buffer offset in the multiple-root selftest.
- Clarify the unused array-slot comment, name the large output buffer
  size, and shorten the selftest commit message.

The formatting check is defensive; I have not established the reported
stack overflow in v5's fixed four-map fixture.

v5: https://lore.kernel.org/r/20260911034715.219552-1-diannaaav@gmail.com
AI reviews:
https://lore.kernel.org/r/c55811f4eb2a0d4884ee2eb3167557cd405a5b7aecd988a51acf525c77e3a0e1@mail.kernel.org
https://lore.kernel.org/r/4fba1aedc906d6c5072a1ae9a72496e6d307abd60c456cb870077cf93cc8f4ce@mail.kernel.org
https://lore.kernel.org/r/20260911035503.891321F000FF@smtp.kernel.org

Validation:
- Rebuilt bpftool and the focused selftest runner.
- All 12 bpftool_map_dump subtests passed, including the 64-inner-map
  cases under RLIMIT_NOFILE=32 and the multiple-root JSON check.
- Tested alongside the pending batch-dump series: all 23 selected
  subtests passed, with no skips or failures, in an x86-64 KVM guest
  running Linux 7.3.0-rc2 from bpf/master, using LLVM 20 BPF objects.
- Diff and bpftool synchronization checks passed; checkpatch reported
  no errors. The generated patches apply cleanly to current bpf-next.

This was a focused run. Unrelated selftests requiring unavailable kernel
features were excluded from the build with PERMISSIVE=1.

Tianyi Chen (2):
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  22 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/main.c                      |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       | 130 ++++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 480 ++++++++++++++++++
 6 files changed, 631 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.55.0
