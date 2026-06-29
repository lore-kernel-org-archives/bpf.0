Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9840D57B
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768137; cv=none; b=UvSTINeTP+0ss3QXGsWkIX9bCzvz0SjWA4ke6b7dlk8Lu9CbKyk0Lxo9SWZ8IbS+4BqaK+BIjhCeTavo6jM5BFwtLAQbejYNOTD4ssystYUJNFS1tuloCKgKhJV08gR20c3f07pDbgqSzyCaVAjOwUFAPzei7smMZ1YR/bEYePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768137; c=relaxed/simple;
	bh=kctU5XVrqBZwdV9BC3j1ili2fdmCoTJCvKNmLI8JROg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svPyzVfxOCRzxPxBReHL6OhGQ8pSqKdPC/QYapX7qtnm/7l1vTZBYTclwnFecoLwSsTN+KYbOo0s0exrc0zkqEx4U9oW0ePAiS6NinO/PT28FkhqwKB9zikM97rurx2xfWqsgCuy4QuIPLslUQE1zEOQm19Wtw3341V65ORiiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwFilec2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwFilec2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168081F000E9;
	Mon, 29 Jun 2026 21:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782768136;
	bh=M7vPGLF2HBEke0sFiTDcnndoE7fJx2SY5Y4KDK9GvgU=;
	h=From:To:Cc:Subject:Date;
	b=KwFilec2gcUMx5AUAmGSvU5EJbgvvmWbXXcQCupl8R76KP3SUb66fbcNy3uBfmYQ7
	 H7G9h6No+u6V9U7uB2afsPMbc6GLm7mgA2W0Z41wgaO3iLCxlsQVLDC5lZuHZumpQK
	 1Ba9DelDxwlSYiG2yEN6x8m0Z+rI6bn1kJQCuqoyjOwuzQkFTGrE886EQ8qjWqz4KC
	 CGFuaKJ1wTmmipVXKXMYCU+zkpizSbug7Qy2074sY02N0MceG9fG+BaRAGpFr+uChg
	 OCkMMTrh+7wqJZbjlfhKje1t/BebIqKybZouzq9NhWwWS7gb3ktN0xn9N8TdBFhqcH
	 D70/VCkpcI9+A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCHv4 bpf-next 0/3] bpf: tracing_multi link info support
Date: Mon, 29 Jun 2026 23:22:05 +0200
Message-ID: <20260629212208.895962-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding link info support for tracing_multi link.

Adding the kernel support with related selftests and bpftool support
to display the tracing_multi link info, the output looks like:

  # bpftool link
  ...
  61: tracing_multi  prog 167
          attach_type trace_fentry_multi  btf_obj_id 1  count 3
          btf_id           addr             cookie           func [module]
          92598            ffffffff825017c4 10               bpf_fentry_test1
          92600            ffffffff82503814 30               bpf_fentry_test2
          92601            ffffffff82503824 20               bpf_fentry_test3
          pids test_progs(1540)

thanks,
jirka


v1: https://lore.kernel.org/bpf/20260621204524.61067-1-jolsa@kernel.org/
v2: https://lore.kernel.org/bpf/20260623142417.275892-1-jolsa@kernel.org/
v3: https://lore.kernel.org/bpf/20260629143844.862369-1-jolsa@kernel.org/

v4 changes:
- fix wrong allocation check [Alexei]

v3 changes:
- added acks [Andrii, Leon]
- display cookies as decimal numbers [Andrii]
- renamed obj_id to btf_obj_id [Andrii]
- several fixes in bpftool change [Andrii]

v2 changes:
- fix kernel symbol search logic [sashiko]
- typo fixes [bots]


---
Jiri Olsa (3):
      bpf: Add tracing_multi link info support
      selftests/bpf: Add tracing_multi link info tests
      bpftool: Add tracing_multi link info output

 include/uapi/linux/bpf.h                                |   9 +++
 kernel/trace/bpf_trace.c                                |  55 +++++++++++++++++
 tools/bpf/bpftool/link.c                                | 133 ++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                          |   9 +++
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 ++
 6 files changed, 454 insertions(+)
