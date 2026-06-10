Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100C30F7E8
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102193; cv=none; b=H1hC3NZa15ogwS2jxpOVN5usxcSZ2cyFEd070iQ9FqLWyPdSZlOfnTz/R2zjAYVtlvnSyjwIJVKML0/jCJCw6y6b+Q1A4gyhcWGgFmBTebETBaOOqfVt5aYvErlIL2h48bse333gM8H7rnUkVjjBt39tN3EFrVQVAN/ICJZXn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102193; c=relaxed/simple;
	bh=G6NoOv1HOEfGF+2dVEm6n+vhZebm1PRJO9L8W4r11MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYa0PRo4ytnF2nmAQY5+JvgCtApVT8aj5p9gaP8sC/+KZ9+Ga+iVqbDxoADkfTpI4XifxwNddkiXIxw3dszwneTW9BFra1biad+v4R1HsLcBpOlbzrcLtCKn1tnqgzCvpM8d3p5qB+Lobb886EC7KhvzdqDWNbeSluhEu/8LbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBmjcs3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBmjcs3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864F01F00893;
	Wed, 10 Jun 2026 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102192;
	bh=KdIGRve+EO4lVikA9vwxg7ZJkj4akKzGmw0anV+dyXk=;
	h=From:To:Cc:Subject:Date;
	b=WBmjcs3tSGPrvrWQoB/ueRTRsugQk7tUhKXjOjPWS1av6KHNOpSbAlla7Gax5cybg
	 ZaG3iSzNJUtP8GWaz4l596Fs7Qykso81Ouu42NzUfrDI6C3KXPFen76leeUaqeGuN6
	 Iqzuuy89whhCfpBRvS919jf7cJS1RKIHlm/wBF6j2B15IVcdCQoImm4aDvULjw8sA+
	 PvgEcmmAC5XWPeRFuKw4juLuMDY81wT64x9OMkhD3GbptAPlsnjMhef8CaVdM8OWNe
	 bux5ZpZYOzrZ0kfVoeVil3aoAOo1e4DTO0zyorMfGNnrbOWeJGW2oP2NGLff6R8St2
	 Zju57faDYsO8g==
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
Subject: [PATCHv2 bpf-next 0/6] bpf: Allow uprobe_multi binary specified by file descriptor
Date: Wed, 10 Jun 2026 16:36:21 +0200
Message-ID: <20260610143627.804790-1-jolsa@kernel.org>
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

v2 changes:
- move path retrieval in separate function so CLASS(..) is not used in function
  with goto-based cleanup [sashiko]
- force zero path_fd in case BPF_F_UPROBE_MULTI_PATH_FD is not set [sashiko]
- add space around | in bpf_uprobe_multi_link_attach [Alexei]

thanks,
jirka


---
Jiri Olsa (6):
      bpf: Use user_path_at for path resolution in uprobe_multi
      bpf: Add support to specify uprobe_multi target via file descriptor
      libbpf: Add path_fd to struct bpf_link_create_opts
      selftests/bpf: Add uprobe_multi path_fd test
      selftests/bpf: Add uprobe_multi path_fd fail tests
      selftests/bpf: Fix typo in verify_umulti_link_info

 include/uapi/linux/bpf.h                                   |  7 +++++-
 kernel/bpf/syscall.c                                       |  4 +--
 kernel/trace/bpf_trace.c                                   | 51 +++++++++++++++++++++++++++-----------
 tools/include/uapi/linux/bpf.h                             |  7 +++++-
 tools/lib/bpf/bpf.c                                        |  1 +
 tools/lib/bpf/bpf.h                                        |  3 ++-
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 148 insertions(+), 21 deletions(-)
