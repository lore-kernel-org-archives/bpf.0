Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FB3BCD37
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178157; cv=none; b=osAIXjre3fjrLoEYZYxJ0Pb2TT9hqlViifvGsm3toe3cHTICpIivunqJ1pb0X4uBDpF3sVTTq1e5jmZi22hzr649+d70AsZM2x2CtSH2p0Od59bSpU4ZJ4uqseg/2vXRtm4WZ8Jt4e0YR8ultEKKA7k/Ss1v62wdseHtkwgvERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178157; c=relaxed/simple;
	bh=WEGhoserM1412gnx1ZeN56uM4ILmX7JJeEjebWJeVBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBLh2jklsJGSlRR6DQIu/yDpCwFiEMZ7/bSmm825WJDWjYGdMbCkX9QhgWPzdcfrBfvDYTRieDUZBff5lMIxAI/b/ce6JJt62mtK7iuLnjI7SeqCYkHrUxox8V8z8tXo60ajWaSsI1P3+Utuizjx9YOna+xWxXLNpfNn7kG971g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmZheIfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmZheIfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286B91F00893;
	Thu, 11 Jun 2026 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178155;
	bh=dWjKFTTW03aCEjoC5HnSEENvJH2K0flSX+zK+WhM/mo=;
	h=From:To:Cc:Subject:Date;
	b=gmZheIfNWYAQbF51n0ywUTevL698ZjpsQYLYKYBh2317uQc7wZZ7q2LKuzE4T/Sw7
	 Kp7PBfaiEzYc/q8NF/0buCtgogsYCk32HL9r94MtHsKO5wuhb/EhViGrFLSkZ5rG6x
	 YnjFKfxJsMYtetSGs5/CrafBkzJEtwT/JgYtsixfjoY0GZV6wCGLQSPdumFTi8qrmn
	 EwW5YXa4U7y8xbPtBM9dIyR2rcJ3pi8apqofElrHR8Q90jYu5XVK55vPK4ILImyyjk
	 tVHNv+0B9DQVmKnna5Q4TZY7pNV8fOgpYmHv7W8H6xj9CjYna0hnlfRRfeOETxaqag
	 bHFaAbcEmzDCQ==
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
Subject: [PATCHv3 bpf-next 0/7] bpf: Allow uprobe_multi binary specified by file descriptor
Date: Thu, 11 Jun 2026 13:42:23 +0200
Message-ID: <20260611114230.950379-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we'd like to be able to open uprobe_multi link on top of binary identified
by file descriptor. This allows us to avoid the race where the binary is
replaced between path resolution and attachment, ensuring we monitor the
intended binary.

v1: https://lore.kernel.org/bpf/20260609104244.588321-1-jolsa@kernel.org/T/#m0275d5f39805c57dc8fd3308c640237dc7aec4db
v2: https://lore.kernel.org/bpf/20260610143627.804790-1-jolsa@kernel.org/T/#m153e18fa426140fdcc773cc97b10e006531656c0

v3 changes:
- guard t_user acesss with access_ok [sashiko]

v2 changes:
- move path retrieval in separate function so CLASS(..) is not used in function
  with goto-based cleanup [sashiko]
- force zero path_fd in case BPF_F_UPROBE_MULTI_PATH_FD is not set [sashiko]
- add space around | in bpf_uprobe_multi_link_attach [Alexei]

thanks,
jirka


---
Jiri Olsa (7):
      bpf: Guard __get_user acesss with access_ok for uprobe_multi data
      bpf: Use user_path_at for path resolution in uprobe_multi
      bpf: Add support to specify uprobe_multi target via file descriptor
      libbpf: Add path_fd to struct bpf_link_create_opts
      selftests/bpf: Add uprobe_multi path_fd test
      selftests/bpf: Add uprobe_multi path_fd fail tests
      selftests/bpf: Fix typo in verify_umulti_link_info

 include/uapi/linux/bpf.h                                   |  7 +++++-
 kernel/bpf/syscall.c                                       |  4 +--
 kernel/trace/bpf_trace.c                                   | 60 +++++++++++++++++++++++++++++++++++----------
 tools/include/uapi/linux/bpf.h                             |  7 +++++-
 tools/lib/bpf/bpf.c                                        |  1 +
 tools/lib/bpf/bpf.h                                        |  3 ++-
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 158 insertions(+), 20 deletions(-)
