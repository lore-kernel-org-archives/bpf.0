Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B023E833F
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178224; cv=none; b=Rd7mvnzxct++XV1jW/bVowWpKiXET4j+2VJX2tgO5VXAmiIwlfbSa4ixabeYTGmNQNSXekYLP84u/EhJUEgka4/A6mhUIH6rGu/BZJpMnz/T01VqqZw8izm7LJRMgPX7uU2dlsJAlXKxg2yjqx5zh/k48mKseVjgrxhe+fkZgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178224; c=relaxed/simple;
	bh=GY53+V3JiVpOg8CqDvd6M1ozZNaWg13g7MqXVy7nFhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOZfYCGR64XB/UlMlnmS8WWeOYflrEg8IpLbQypjjRH41n6jsN5bIvp2Ey+hj0YknrfI64Avm42GMPiDhCml+c/5AG04RlJ+wAworUlRbfDmuTuRB/FpzTTR2dc6SL5V1Jt/BdIFbySi5c2HvsWnUAyrYTX/trJXK7AJnQfhpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnFBE68A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnFBE68A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8980C1F00893;
	Thu, 11 Jun 2026 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178223;
	bh=16WniKoIEb4BpYzobLHhPPBTgQWYnQ6y4Qcbzsskkdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnFBE68AaLESP31UVdaDeS7db3OkRliyzP/S6vjsFnhZRD1LruDeCB7lDd2LXlDcS
	 VY/KThHgigdN6t3kp+x2ubCT5fJjR1rULdfOPmeA/fCT3QHTyqXHRY3FM0n6JQrOvV
	 DEUWLemOvuCjhqhjYdIQ+THeWdqgwBoO6CyDNNqbRz4q8lWxgW8Kn5KlfuWmI9hwxY
	 KsRsE3q6HfrYcCeuqk4OXa9whJCm5jtrODRXoqLWjyECnLiRvsXUxWnRxv4T6Izye3
	 ZbqPFb8RCam3hxMCCjFZDNWN5+odNXy4JIruoCd+iW5EGqPOslJ9mi1Z1nA6vxUB2w
	 hyBAoIs40WMCA==
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
Subject: [PATCHv3 bpf-next 7/7] selftests/bpf: Fix typo in verify_umulti_link_info
Date: Thu, 11 Jun 2026 13:42:30 +0200
Message-ID: <20260611114230.950379-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611114230.950379-1-jolsa@kernel.org>
References: <20260611114230.950379-1-jolsa@kernel.org>
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

