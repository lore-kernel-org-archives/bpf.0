Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693413EEAC0
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994235; cv=none; b=R0QYfUtGq4WRTQzBjFv9b2AiVVGJY4+Bk+zhgbEp6J5MhKkniIfM+9bwd6zi4h7zn5cKhwTQzxkbF2RKSRQ8TeNid06uTiCTXA+nXeFat0RWtgo9T/jSNik8m13Kvqd+0XHi8hRVSGVA/zHrkQge23++sb5tqNrIN/ct4xh4eFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994235; c=relaxed/simple;
	bh=FI3HyvltGCN1lEcr6gWhS9Vs9/UlTo3yw4aQMJRT9lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnyJKQzaBQiDCsQFRM0PCK8jNXAwZwGiUf9V1eGdGuAlvREzXHttqMqbrZdMGTICxYABJNf49SXQB0yaZmPzpA5ciGE7qOECMIjyOEaIGSnZ88qLY1+bhzWp8b3JdszHvkozDtfb2sMBA9t4crnnhMgf1xIrDq7C2CHf3vL5cf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aalvvgS0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aalvvgS0"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so3542890f8f.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780994233; x=1781599033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHCBKb70pBHWaqA32a1vUNsq5X0M/X53fnRAAz9tOiQ=;
        b=aalvvgS0Ca4VsESqWmzfkj4wzqVH4yYsn47h4KHxhpwsRypLgWNcPrGVjX0Td+BpMe
         iSXDSCHEtcjmArtAmQQCrF0XrlEQ50w6gjepPbh2NfNjJovUxrl87MGwj9IbBqdkRELd
         8VUAoS2UCegVWJt8lJJ++5/eN2ldSKG3DBIza4vvIKCqxlmPRMyL7dUcf16+JVIfMBwi
         IiiSM1nVSfWXzy4p8RwbVlai0aVS/Zrb8MKj5BedHhd/K5xvoqANOm+67PJYZDGVil2i
         8Q8Nq7UxgTja1pW+Q2SwIDqXsDXnd74/wg+B5HmZQKcyg7EPeUAzq+exMFMiw2nhFcba
         yxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994233; x=1781599033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHCBKb70pBHWaqA32a1vUNsq5X0M/X53fnRAAz9tOiQ=;
        b=kT5GPllY3TjPYZ4nBJ89TJU2IcQyK40cBsYFiEKkkkL6hLkHgSjIwbnFg4h754k4ZI
         aBv1ckp108VkEZCPt1zGU6lkbIx4C18N9wC/sgYGb/ufckD9Dsvvrnu/TRS/bUZ/xJvS
         wFGN6b38IXJK770LVHz467fMMYUXywGOxOmjg55CECg9ZKGDbD2IfEQera1k3/6ggvBD
         5nvhtBP84U76EAAQlu3+HycsYIf7/qT/UhXsLKu0ZEkAiQapkzBxLPLNAwVCvVrIBfWU
         GLWhR8ljET9Yx/A/2Hd8lkL/sUCr7PeW/dwBmY3Z46Vn0skcJeGNFB2KgvlojUp8g8PS
         mQiw==
X-Gm-Message-State: AOJu0YyooBu02/EnBxVsPUdeDPV0YyO3J/t2XHFoyUVYMCW4FCAlyKBn
	x/XwZowvDLLo3Mi6LCacamXLICk1/6V2/xoAcPTE/ZxCfa8aKQGFhSQjSS6RMdaHkiD3rg==
X-Gm-Gg: Acq92OFxgkYXlOrIbyC1IHEZ2rvUp3kZWOiHfM6KleS34R4Ts1l3zA/4fd2jdWQj4A6
	yKUuV+Q+X7/g9UiiKKQHRJlA42PPIe9sf0HJ+q4yNt7wJrycS+Zj/1CPiKcsEaiwJKYomZz/pvF
	Cysv/KQGHUxlgqRJ2vw+VhLG1t2UZ32z/JWsfuZd5SXsEfSDnQS7lHaRqs6FGj5U5TTDWUqyGmr
	tnxGyBt8EgU7G+JKA/uxJxn+uLO/vDTxlNTLELS7xo/JnMTXxj7D73SOEvNec49cvEZCCH1Q/4W
	aglPvZPXBkwc1J17MZPyD12UNho4DJTMijTUxzGI0Pyn+VGSzAlTxf3Uk7hrR0Q7t0XAwN53lts
	8+NCHrgqeB8BarsXKkTvsPcKGzD/fCen/C90pcfhrA+dq/edFyUkbm+Is+YW2uow2TtliFErOGh
	9ZTp3WS1I+JxhAtmVXny/eSqW+g+H3KhJIBiFrTzjF4LxKjCqViy1r
X-Received: by 2002:a05:600c:45d1:b0:490:51e2:bc86 with SMTP id 5b1f17b1804b1-490c260a60bmr292477295e9.23.1780994232489;
        Tue, 09 Jun 2026 01:37:12 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d5d2b4sm304149135e9.2.2026.06.09.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:37:12 -0700 (PDT)
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
	emil@etsalapatis.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v3 bpf-next] selftests/bpf: add tests for arena vma split and fork
Date: Tue,  9 Jun 2026 10:37:09 +0200
Message-ID: <20260609083709.168755-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d12081a0-b933-44cd-8c46-5d7b83cf0347@gmail.com>
References: <d12081a0-b933-44cd-8c46-5d7b83cf0347@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that an arena map's mmap()ed region cannot be split by a
partial munmap() (the "split" subtest, which expects -EINVAL) and is not
inherited across fork() (the "fork" subtest, where mincore() reports the
child's range as unmapped).

Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
v3:
- Consolidate into one file with a shared setup helper and two
  subtests.
- Put the opening /* of the multi-line comment on its own line.
v2:
- Drop the regression-test framing and per-callback details.
- Split the original single test; unpack the mincore() check.

 .../selftests/bpf/prog_tests/arena_vma.c      | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_vma.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_vma.c b/tools/testing/selftests/bpf/prog_tests/arena_vma.c
new file mode 100644
index 0000000000000..f6c07cd31d08b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_vma.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+/* Make sure arena mappings cannot be split or inherited. */
+
+#define NR_PAGES 3
+
+static int arena_mmap(int *fd, void **area, size_t *sz)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+
+	*sz = (size_t)NR_PAGES * sysconf(_SC_PAGESIZE);
+
+	*fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_vma", 0, 0, NR_PAGES, &opts);
+	if (!ASSERT_OK_FD(*fd, "arena map create"))
+		return -1;
+
+	*area = mmap(NULL, *sz, PROT_READ | PROT_WRITE, MAP_SHARED, *fd, 0);
+	if (!ASSERT_NEQ(*area, MAP_FAILED, "mmap arena")) {
+		close(*fd);
+		return -1;
+	}
+	return 0;
+}
+
+/* A partial munmap that would split the arena mapping must be rejected. */
+static void split_test(void)
+{
+	long ps = sysconf(_SC_PAGESIZE);
+	void *area;
+	size_t sz;
+	int fd, ret, err;
+
+	if (arena_mmap(&fd, &area, &sz))
+		return;
+
+	ret = munmap((char *)area + ps, ps);
+	err = errno;
+	if (ASSERT_ERR(ret, "split munmap"))
+		ASSERT_EQ(err, EINVAL, "split munmap errno");
+
+	munmap(area, sz);
+	close(fd);
+}
+
+/* A forked child must not inherit the arena mapping. */
+static void fork_test(void)
+{
+	long ps = sysconf(_SC_PAGESIZE);
+	void *area;
+	size_t sz;
+	int fd, ret, status;
+	pid_t pid;
+
+	if (arena_mmap(&fd, &area, &sz))
+		return;
+
+	pid = fork();
+	if (pid == 0) {
+		unsigned char vec;
+		int rc;
+
+		/*
+		 * If the mapping was not inherited the range is unmapped in
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
+	close(fd);
+}
+
+void test_arena_vma(void)
+{
+	if (test__start_subtest("split"))
+		split_test();
+	if (test__start_subtest("fork"))
+		fork_test();
+}

base-commit: 174914ea551314c52a61713b9c4bde9e42d48073
-- 
2.43.0

