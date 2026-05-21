Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5F25783A;
	Thu, 21 May 2026 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367516; cv=none; b=AzJqpNiB92EDW0eucMmGEIrjwnuVuuHKfargdYO57vE8v5IAT/6WmF5F5wD0eTMZQ7pKX7HMXuYJ3bHm1nGXOK9WkGO/7oue5hZ6Mu7T3doaAZMCVwbfycZHIl5A5hwPgAWkndyJB2YtLGQph5AfOESugGRWn8v4t6xIXNGh9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367516; c=relaxed/simple;
	bh=2+BSJdhxvezVCEn1aJUXuP41qyeyW77kxzFBlh3cf4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myeC0eIxDeMNcfiOPHDCUyESlvoNwaxxfJquetrtvxwa9UcPZsLt3zqpxNfjFbtefCfHeMYhgOScoNbOQxXvNJ+mdK+45td3YZRZrDhYHH9Tl3wJvDnWm0osV19RUGQen3hF2vgHWvBIZSWNrkhMdNxBEDe94C6EcqV1KPsLon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldV0m9Di; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldV0m9Di"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CF91F000E9;
	Thu, 21 May 2026 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367514;
	bh=yEdRrscJj1x+mspAq35Wlc8hehCVJONc370yQG6QRic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ldV0m9DiF+n41mWcrtyEL2P7hbyuFek0YD2c59f6QFomW0EV28koVQJLdjyBjChJP
	 UP9/ImYT9PmIgZzcKgc81jYqREEwIR8yLPOXhMXlZFwR6z23GOMoZ0mKB6y/LvIyYw
	 jQ4/gpqqISmMpbZ/jORW31OHqbTivZf4fVHw59SSfvSPeuOAXknV2wR/eZN8QpG65I
	 SdlRbXbGkMYawpGwZ0acBalUx4bpGvoNzZI6peGgwx+nHxA3qtNi3ONMOODyf2CCyv
	 fl+vlnUILStiQKc0RfjlhJSBFMcyv8e/g5v6hqHazkrdOTRH8e4HSbHG46iCmbTv0b
	 D7VO5UlEL2eKA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 06/12] libbpf: Detect uprobe syscall with new error
Date: Thu, 21 May 2026 14:44:05 +0200
Message-ID: <20260521124411.31133-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous optimized uprobe fix we changed the syscall
error used for its detection from ENXIO to EPROTO.

Changing related probe_uprobe_syscall detection check.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 05738da0efa1 ("libbpf: Add uprobe syscall feature detection")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/features.c                                | 4 ++--
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b7e388f99d0b..e5641fa60163 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -577,10 +577,10 @@ static int probe_ldimm64_full_range_off(int token_fd)
 static int probe_uprobe_syscall(int token_fd)
 {
 	/*
-	 * If kernel supports uprobe() syscall, it will return -ENXIO when called
+	 * If kernel supports uprobe() syscall, it will return -EPROTO when called
 	 * from the outside of a kernel-generated uprobe trampoline.
 	 */
-	return syscall(__NR_uprobe) < 0 && errno == ENXIO;
+	return syscall(__NR_uprobe) < 0 && errno == EPROTO;
 }
 #else
 static int probe_uprobe_syscall(int token_fd)
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 955a37751b52..c944136252c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -762,7 +762,7 @@ static void test_uprobe_error(void)
 	long err = syscall(__NR_uprobe);
 
 	ASSERT_EQ(err, -1, "error");
-	ASSERT_EQ(errno, ENXIO, "errno");
+	ASSERT_EQ(errno, EPROTO, "errno");
 }
 
 static void __test_uprobe_syscall(void)
-- 
2.53.0

