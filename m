Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E2260566
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660638; cv=none; b=XSGkNkhv42J34mq2HaoLM3bxMoDFImXcMY6V3kn/zSfGYarFpFaxoitEl9mJiNdkiflX60f3DaVOC8lbK2Rn8DjsX4XP0Buoqj9ssITrFJzn7P1hSxr7CcAN5MX2GTg3bIGvJotp5JH3DBE1P12fDRqf7lKEMld8kM8zgRNZjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660638; c=relaxed/simple;
	bh=Dbe77nWU58sMNDZjnL8Milx4inFgxmSITLkmETZcgUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8VanIJBQZDkdpEAa5M94SjpnTPFDYHk5RJooTL0MrC9rKEJVgmxJx2U44K7u4KJzKRAJvisRuhwdUI1+eIFIRUsW65c5k0oimt8jAfw0h6bDPF2yLAyrSazgECdlmZWxpPJ8T3HQiSq5fXozgMih1dIBet9CCdZTKZPYJTjwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwvMhzAt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwvMhzAt"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b613a17bso17901895e9.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780660636; x=1781265436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4TEd+4TYiE1Jj1gNATanEWxBTZIObCwIlDo0eo0tjQ=;
        b=FwvMhzAtG2YKAk7urawA44Tq/92yIffNQcG+Z7gKNBcfm51u8NMxjFE/6H8tWE9dG6
         d6kD37eUO7mQo/k3xYyxFJ3XC4QPxwe1tv7ndKhlvLVfLHtjYk/zZ7gtu9wK7v6LYbGW
         SbZkpUzhmqkuf9Ii4UFA5mXD7qQNGsQxfM1g1d6OhlZ0sYNFb+FS6NFVPTGcpLTmbgKR
         FCsHQB9y6eeZaBbrOS64bB9LndDySBZPE1adP9bggHRPeK7I63eF7JgC32rcMTBrMVSv
         zbgt9bWfyE7BmGC58dBJARcr4qj4at1giBEnyu+dfRaxYklaNtPXTayA+qiNFWZd98jx
         8WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660636; x=1781265436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4TEd+4TYiE1Jj1gNATanEWxBTZIObCwIlDo0eo0tjQ=;
        b=WPrGWYD4is1C8QCcpz1IGAt+VulltzwRfCJIz51tmB+r2L3edbpdA6C/4Oh/RFOuDI
         xysXgL5mQwyR0UNDSp3KA0tQFDaoh6zaLnNnAsC4o5wmBqbNOiHxQW17Y/6CuoMgiNTE
         pKdMPWiqru/eRtWgwsbgtsTy9VNhPID8TXOvwhdS4GUrGAn3iICEQeNIW9EFVFZcRHeZ
         0cI5K+QHp8TXxQYOAuDHfnF+hNMyNpBVB4HM5yl3vUk2ypFiDoFDIOvgJDJs+x6e0V4j
         WUiFFZ2wuno9fa1gVhSOdgBSpv//Gkzl/Ya4IbP5Z9aEsQFzG0J1nThsRLxLZ3ox5Zir
         g5CQ==
X-Gm-Message-State: AOJu0Yy3bxL4TZjfDyu9Iz3U3f4yNnoIycj9WlivOYpQLoQgDsW+0Iag
	ZgkKLx9epiTCRRw+JlHMPJXpzspi6JwqkrR5Z+oPMzEJxG6E4/p2oxeZz5Yu3haz8Ex2vw==
X-Gm-Gg: Acq92OHw3KI/R/Y9h7+fny7ECsKJOQyS/pbM+nC+qK+dxC3GRMMDgimp6eOkFsE8Fe6
	lL5cnPcADbylFMVH6CH9E3kba3xT0SPKh2ykx3mfRtUKYlv7DlSTN/TLHqGJDMRwbPxCdS3W5jo
	GW9KovkuIHad8JExYmX8/cYRDM3vJiXvwrz/jleo0ssoVEdrAs1Lyycx4XuXkmU4enZhzLEn1TB
	6uONnQbICYdPEig2fzAHa/DF+P30+bVGHUwOAAZZ5nentZ58GoH0apnW9Zt5w/Obg52f+wfsbQg
	HHcWpXH4S9ZOylmuL0jJqmthC8+1HjlyyecKZFTMWpYP7FlB7nrA9R0iRNCXtvVhR7DC/oyG9tE
	lQAapkwY30U3Cb13Bo1pbx81YxwfmsTdkjGOH5MVigIIpnUgJ2BK+83xU0AtoyxA+/f9YfktQlY
	N5TWH7FQnm8nc8KnuwPvA3WrR+ab4p7FvmHHXdTL55YIfpCETGGoWb
X-Received: by 2002:a05:600c:6096:b0:490:b115:e03f with SMTP id 5b1f17b1804b1-490c25ba56cmr51175565e9.8.1780660635434;
        Fri, 05 Jun 2026 04:57:15 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm15402201f8f.7.2026.06.05.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:57:15 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	memxor@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com
Subject: [PATCH v2 bpf-next] selftests/bpf: add arena split and fork tests
Date: Fri,  5 Jun 2026 13:57:13 +0200
Message-ID: <20260605115713.3224051-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DJ0F0WFEP78A.1VV9Z7T71JJX5@etsalapatis.com>
References: <DJ0F0WFEP78A.1VV9Z7T71JJX5@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two tests for an arena map's mmap()ed region: arena_split checks
that a partial munmap() that would split the mapping fails with -EINVAL,
and arena_fork checks that a forked child does not inherit the mapping
(mincore() reports the range as unmapped).

Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
v2:
- Drop the regression-test framing and per-callback details; use
  short one-line comments.
- Split into two separate tests, arena_split (partial unmap) and
  arena_fork.
- Unpack the mincore() child check into explicit statements.

 .../selftests/bpf/prog_tests/arena_fork.c     | 53 +++++++++++++++++++
 .../selftests/bpf/prog_tests/arena_split.c    | 34 ++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_split.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
new file mode 100644
index 0000000000000..bb134e9adb607
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+/* Make sure an arena mapping is not inherited across fork(). */
+
+#define NR_PAGES 3
+
+void test_arena_fork(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	long ps = sysconf(_SC_PAGESIZE);
+	size_t sz = (size_t)NR_PAGES * ps;
+	void *area;
+	int fd, ret, status;
+	pid_t pid;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_fork", 0, 0, NR_PAGES, &opts);
+	if (!ASSERT_OK_FD(fd, "arena map create"))
+		return;
+
+	area = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(area, MAP_FAILED, "mmap arena"))
+		goto close_fd;
+
+	pid = fork();
+	if (pid == 0) {
+		unsigned char vec;
+		int rc;
+
+		/* If the mapping was not inherited the range is unmapped in
+		 * the child, so mincore() fails with ENOMEM. A success means
+		 * the child wrongly inherited the mapping.
+		 */
+		rc = mincore(area, ps, &vec);
+		if (rc == 0)
+			_exit(1);
+		_exit(errno == ENOMEM ? 0 : 2);
+	}
+	if (ASSERT_GE(pid, 0, "fork")) {
+		while ((ret = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
+			;
+		if (ASSERT_EQ(ret, pid, "waitpid"))
+			ASSERT_TRUE(WIFEXITED(status) && WEXITSTATUS(status) == 0,
+				    "child must not inherit arena mapping");
+	}
+
+	munmap(area, sz);
+close_fd:
+	close(fd);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_split.c b/tools/testing/selftests/bpf/prog_tests/arena_split.c
new file mode 100644
index 0000000000000..8a59cfdb2ef89
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_split.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+/* Make sure an arena mapping cannot be split by a partial munmap(). */
+
+#define NR_PAGES 3
+
+void test_arena_split(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	long ps = sysconf(_SC_PAGESIZE);
+	size_t sz = (size_t)NR_PAGES * ps;
+	void *area;
+	int fd, ret, err;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_split", 0, 0, NR_PAGES, &opts);
+	if (!ASSERT_OK_FD(fd, "arena map create"))
+		return;
+
+	area = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(area, MAP_FAILED, "mmap arena"))
+		goto close_fd;
+
+	ret = munmap((char *)area + ps, ps);
+	err = errno;
+	if (ASSERT_ERR(ret, "split munmap"))
+		ASSERT_EQ(err, EINVAL, "split munmap errno");
+
+	munmap(area, sz);
+close_fd:
+	close(fd);
+}

base-commit: 174914ea551314c52a61713b9c4bde9e42d48073
-- 
2.43.0

