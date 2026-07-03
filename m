Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529A25785D;
	Fri,  3 Jul 2026 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079448; cv=none; b=t6kKHVxXpyT/a8+ZGi6u8XSpgd6ApVrvroWZLtQ66urvQvjH5stDeCTNA3uFvAUvme+ZMzyrCQPJAGEVNbvskY6xHSMDCGH3BHy63KA1gs7cajmmTl8S9vtutiGfk0TgDqSTGasD1TbFbmUC38fl6+T6hcHjIB/n8/472p4OH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079448; c=relaxed/simple;
	bh=o1B2PiD7Dcjro3AZUtHdlmXGHnIGf5m1awLr6Wj1acE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VljfsWHTX6710CkXDb729ndZ+9K528BglvdewPxgRql/M1qsz5pIvuDm1TKwwuakniKvTi0gu8T7wZFf37IMSRIVg1fXzFUvlqMPy88EL/cZMiUU29KcsmvnBHc1OLDIKlBJmJFBmhAMsZ3ANiK9vgv3T6eV6N5CzwOY9VAXIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE8FeGLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE8FeGLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6932F1F000E9;
	Fri,  3 Jul 2026 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079447;
	bh=uOkmul1W1VL2+7L25PolcRw2cNoza+fUstOlngHhH3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LE8FeGLlALS5DVoWjr2xy9pUxfvQg5zfOjOXMIIiTzTDUWoreR7xnNysN7hKTgBL0
	 Ufy+BvzwbhBtfG75M53njtS1JkYiylFfp//5lrv/3fswAfghTOEV2YrhCxmYuomSYc
	 tI4ESVOiqIevB689PdYmMn8s2u6PIRxeJOUImINAkoGke/JxxNBcQgWeGRPoJunTmk
	 +KIfaBfnS8g+FdagXfj0kjoecNm3y1t9fuZiJZu5wBTr7rxa/oqsxeeXJP6CROCkiN
	 kCl/9UxB5jGE7lVkMwaGoiozxK0L8DbJtgnt/Dtkt9BprRVzMnTeGhD8hvxAD8NEAT
	 jQDwnLEPaJoAw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 07/13] libbpf: Detect uprobe syscall with new error
Date: Fri,  3 Jul 2026 13:49:11 +0200
Message-ID: <20260703114917.238144-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703114917.238144-1-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
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
2.54.0

