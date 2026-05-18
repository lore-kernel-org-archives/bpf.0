Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778A3C4579;
	Mon, 18 May 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102050; cv=none; b=Kn6y/K81ZfzseP4P3CwniLc6dBopTtSbDLUrLmjwmPT3XaQJDHwQ2jpY8B4UNqtIYJDQePspr+zz5YhW0QDzYb9+5MYf+pZAHuueY2dsuWTSBe0HXeD98OshxssNwSSnz1ghkKGhIXRMLRRI6RfeaYMP88uoI7rMSf73jirjljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102050; c=relaxed/simple;
	bh=EwIt42YLT93sKKsdVpgwfMS1we3y5aK/+KrhhfNYpJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8VGh3jQkQn81NpYVMZ3Sm5PAbZSq3AyQKyywNHjstG+jg0rrwquu5VXP4Bf8gB5YjN9o5ZiXqulSkh5f3fWvX0KSKIPUeNE6vvPB8tzvDejXj85wThtWrl7ZIYrnNSwLx8H+emfPwxmUjX4+k04whrQ7zjgdFxDdYmpQ1cFeAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir7Gv68g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir7Gv68g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315C0C2BCC6;
	Mon, 18 May 2026 11:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102050;
	bh=EwIt42YLT93sKKsdVpgwfMS1we3y5aK/+KrhhfNYpJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ir7Gv68gH01MtxG/7Ngt63Dey7DoHr4uJ6oXaIl/AgyIGqN7yLbON9qeH8hUf1Umb
	 KbWddXnX8+hdFlKZpyFJ6WfjQBcxb2pU2X2OJG84Zn3PCZYXpWBzxG+7ZAcDzNL/dy
	 hrftV0QfAvT94EYZSbSkFIHn2NUAotXSQ4QsE+KDngb9LzPC5KiyCaG+v4RrZ2xch/
	 IMhFAKw5tp++kOtwdno+HznPHKhZE2rg1H4jicwz6Zq53ztHRrh9cA1CFgepyLemX6
	 J7kYfZmI97QK+jlOdNzwYMmPCJiGC8Cm50X68AKq6IyKGboulSIcRabzXPG4+bvGha
	 MhpyMlhrSJbMw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 05/11] libbpf: Detect uprobe syscall with new error
Date: Mon, 18 May 2026 12:59:51 +0200
Message-ID: <20260518105957.123445-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518105957.123445-1-jolsa@kernel.org>
References: <20260518105957.123445-1-jolsa@kernel.org>
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

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
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

