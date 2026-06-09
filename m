Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7463F54A4
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001771; cv=none; b=Zmh+ZF9MnTykiuUXaSAM1Z0xwBZSoFZFRbbgfc11mwMbtW618GvNj2ZV0XALhtK0wZKPC+eEvALu7erIhX0xKLmNbZiDb7GHPwD0ymfDotcTqHXcHp+XiMMWj5th7sT0TN8ORylh48krdo8/CRFA6BQa0JNNtedHoweCW0D3qQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001771; c=relaxed/simple;
	bh=T9CQphSqmIERPUlCSL2Ex5VHlUB9JvyNMQmEyvUBc48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/dkzii+aKOtW7ph15IFkqIDejyzqtyJaBAeXgfBSdzSSIcqGBZIo98M87NqB0bdQlydj6+2JQaHour5zyySpuH+zngFREGcj19G7oS29SfjyGd3zRtwnag7FQXjTNoOFrm7q0CMcoCt9YSV98O32PnHFx1YJbi5hguwW5jcF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKp/Btt6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKp/Btt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626DF1F00893;
	Tue,  9 Jun 2026 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001770;
	bh=jpSVIntC6xMlI2yUQXxpKv8gX/GySTUR6bKMNryYfl8=;
	h=From:To:Cc:Subject:Date;
	b=nKp/Btt63niDNMgWf3dQtQ7E9ZaWlDYwYceRvxP4+6aER/NguSZFEJidxDq8xDlZy
	 US/r7xayaz7IIkkLxTW8/nzUhM7W0xq/gCxG9NyGYw4Zj31G9MHMQ1+uFsZkPehgQH
	 iibBhhVCVRC8S0b2e1ntcqn2Xk9ubr6iJSQG5oMcI7M3WHCaxacJpHAe2a7Izjdydj
	 KcuLtuISCefQi0vK4roJgTyrgVh5udFmeS6b9+1yye8dOtsA/hPBkXpH0NVqamz529
	 WQZzTUPwruometGkTdp4gsfoXJ5Lfi2/kkDvBCAiVggzA623AkG9eEUsnxnXRkhZjI
	 W4+prTrMcsDlw==
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
Subject: [PATCH bpf-next 0/6] bpf: Allow uprobe_multi binary specified by file descriptor
Date: Tue,  9 Jun 2026 12:42:38 +0200
Message-ID: <20260609104244.588321-1-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c                                   | 43 +++++++++++++++++++++-----------
 tools/include/uapi/linux/bpf.h                             |  7 +++++-
 tools/lib/bpf/bpf.c                                        |  1 +
 tools/lib/bpf/bpf.h                                        |  3 ++-
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 140 insertions(+), 21 deletions(-)
