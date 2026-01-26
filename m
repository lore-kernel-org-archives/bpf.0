Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876F2E2DEF;
	Mon, 26 Jan 2026 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462363; cv=none; b=jvqZHQ0y42NPhIfB2CpfD8uG7IjZmERqUwjBFaerk855H27RZNJCTnk/fekZeEjt3qXYp8ZLBzxO6IXhFjgOQAzu/mTqK3bLKYsFny66st+SOF2231/D8owjiavQahOgHKMMLbLXdXCv7x4KOEAincFP5iY9HxHuUhpd5sGiORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462363; c=relaxed/simple;
	bh=OGjWCrJY6b5nTOnhbKjdWgQinec1OT95CX/Xhdw7z24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHr6+Y2VT95PZUOrnJWz8KQ2d1srs6Ue6gD04pJjMz7T6z1Al4TqIUnXOSsms16df6WNm3TQ1eyddvBC2qsLwlrWnXat+3tRshS7LIpXoj/gdifvLIo4BvV01LRAWIiX2dyJvlzwIJ1GcsFQ7SDTzQbB1Qr8FATx6iUQcOug+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMwgb5Zc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMwgb5Zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10432C116C6;
	Mon, 26 Jan 2026 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462362;
	bh=OGjWCrJY6b5nTOnhbKjdWgQinec1OT95CX/Xhdw7z24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMwgb5Zcg0HsMmgi93zVkWOS8Tnw2xSji0aKviSPsEvaly1fQIlgIRYFfz+qx286G
	 XFwKjGWXFEAR/3ZvXGGu8WjCFkPZflbO2r//WFWPCuPUmjKDLPB4fhOONsf+LdJbpB
	 P4jiX503jHADsKNnNEK6Ka00tRq0mQbXHYXshGZ9Pfn9/mIehCw29zBe6J4a7eeT7L
	 uPn4TtpgtoWn67oRc/Dqr6EKWjIJPVDC+vgFi8z72f5M3paTy/QzxJwWydUaPGD9E4
	 YZPTPOW0BqQkrPvWwrPOeeWUFLM+9PTQEk+AW2kl0HbumcLwviO5J6MoZl2V92+rOb
	 ZMOlySFLUePsA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCHv2 bpf-next 3/6] selftests/bpf: Fix kprobe multi stacktrace_ips test
Date: Mon, 26 Jan 2026 22:18:34 +0100
Message-ID: <20260126211837.472802-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126211837.472802-1-jolsa@kernel.org>
References: <20260126211837.472802-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now include the attached function in the stack trace,
fixing the test accordingly.

Fixes: c9e208fa93cd ("selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
index c9efdd2a5b18..c93718dafd9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -74,11 +74,20 @@ static void test_stacktrace_ips_kprobe_multi(bool retprobe)
 
 	load_kallsyms();
 
-	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 4,
-			     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
-			     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
-			     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
-			     ksym_get_addr("bpf_testmod_test_read"));
+	if (retprobe) {
+		check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 4,
+				     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
+				     ksym_get_addr("bpf_testmod_test_read"));
+	} else {
+		check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 5,
+				     ksym_get_addr("bpf_testmod_stacktrace_test"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
+				     ksym_get_addr("bpf_testmod_test_read"));
+	}
 
 cleanup:
 	stacktrace_ips__destroy(skel);
-- 
2.52.0

