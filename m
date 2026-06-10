Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64943331EBD
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102251; cv=none; b=hB5dgUmMYFX4g9VzkAqreoaoVHUgtpCM4Btnpe43hza9FWNOvI5gbqxU2dUOsCUd+vMBQvF31ov25L8xSAXwEUxwbVNNLk+A9RAUGoU4AlTNMnfmc/VQsboNRT/y8sXe6iXPJVxEdmHzQrfdgQ0b1J+OoIbUcgOCfCK6AdBylXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102251; c=relaxed/simple;
	bh=GY53+V3JiVpOg8CqDvd6M1ozZNaWg13g7MqXVy7nFhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNdlA4UxGVHvLiTa3hfDoAkHHFgnqye9I6kbrxl2cv3DQA8EJIquy/uLPA+R7tAvQ4evK2TgW1Mm2rjrLey5jnCaLY34oQAFrUVM7sGk1FpBYIXOLkKoImQPfNKd8RhN08w+MNUascWG5UcHdat26bo0/hbhfrXi7DS0zA6uG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNlthR6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNlthR6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C65A1F00898;
	Wed, 10 Jun 2026 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102250;
	bh=16WniKoIEb4BpYzobLHhPPBTgQWYnQ6y4Qcbzsskkdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNlthR6+fqqhyZ7sl583csUPB9pmxs9AgRTmd4GaRCyMo0zNdbemePiNOxJ5WZnss
	 UYdBXS8/C19qILgIYwksynI/QV+H/QdKU7TnwsC5uMvyp5xrTosxqvRbLuCmWtkIUx
	 +OP90W0udvahvOO/QepyOadLma/R4R/MHB/jEKkHDZnN+hDXiHaYYG8Oe6a2W7aq9b
	 ny8ykUzq8VwG2zChNzaPF1nz65NZCXfhYS+zYuw0+6qnqsp8/6/wClo2zhLFrsC0gv
	 cBiDZbhR5MG94KayzayUm4gRICixO5zb+OsktdR9IJQRYuBmv5gw85n+7VpDZxWzl/
	 F62ua9hfKzmvw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 6/6] selftests/bpf: Fix typo in verify_umulti_link_info
Date: Wed, 10 Jun 2026 16:36:27 +0200
Message-ID: <20260610143627.804790-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610143627.804790-1-jolsa@kernel.org>
References: <20260610143627.804790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We verify info.uprobe_multi.flags against wrong kprobe-multi flag
(BPF_F_KPROBE_MULTI_RETURN). It's the same value as the correct
flag (BPF_F_UPROBE_MULTI_RETURN), so there's not functional change.

Fixes: 147c69307bcf ("selftests/bpf: Add link_info test for uprobe_multi link")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index e40114620751..f589eefbf9fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -469,7 +469,7 @@ verify_umulti_link_info(int fd, bool retprobe, __u64 *offsets,
 
 		ASSERT_EQ(info.uprobe_multi.pid, getpid(), "info.uprobe_multi.pid");
 		ASSERT_EQ(info.uprobe_multi.count, 3, "info.uprobe_multi.count");
-		ASSERT_EQ(info.uprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN,
+		ASSERT_EQ(info.uprobe_multi.flags & BPF_F_UPROBE_MULTI_RETURN,
 			  retprobe, "info.uprobe_multi.flags.retprobe");
 		ASSERT_EQ(info.uprobe_multi.path_size, strlen(path) + 1, "info.uprobe_multi.path_size");
 		ASSERT_STREQ(path_buf, path, "info.uprobe_multi.path");
-- 
2.54.0

