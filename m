Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CB3A4F55
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947710; cv=none; b=KLI0uN9wG14EA0AOmBawVr0vMbq8lsPXxyJc/STaXBgGgT7OjTpzgF1QlLKyvBuIKUtGKcwQlXe136MHzf39Vzqqi6MK6tNFPG1qJc3x/r2mDeoG/vWqZaTW3VBdVmWC6xdpCQC9ldpN5EZiVqd+nJbWr7E9aLXvYrM2tAtQw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947710; c=relaxed/simple;
	bh=Qky58vhSg7ngpuiMAI0wXwi0OB8jKBtIVpl989hW15k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZdOPK2mlYnqMwzhGiVfO63M1bMHG0ayOIlX4PAf9kQszVGH8u3yLe5d4hj8MNGLy29qTWqNfTt9R+QjqjKaeCIA9GYI7nzsni9LIu2UfZpb92rcqkpxQaZqd3k9NCA3C2ScTv9kyVIWUBrmSoNQM1EOd6o3F9ke5HMawIRpW5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YZPphYPs; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YZPphYPs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vsRHNcJt7Fs8ijA/eSOjtaTvGBC9pS0O7xztTp+2ST4=;
	b=YZPphYPsH39NChvKkNn89BC4zucxFJ/ynOhlt1DDuCL5ye5eRYswqwiXFxTOEVIdPKXsQR
	jSQmoLyGkQTyCDHzO1ncUoqcfjn51p088GVhtLnuZr5QWVxldt33zd9iay+02fdd1qfh4r
	snGXhJzPJWJQlfxv/ckYZ855x7WvZUU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/8] bpf: Enhance __bpf_prog_map_compatible()
Date: Tue, 24 Feb 2026 23:40:16 +0800
Message-ID: <20260224154024.12504-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Following discussion in the "bpf: tail calls in sleepable programs" [1],
this series extends __bpf_prog_map_compatible() with additional per-program
compatibility checks.

The series validates these attributes:

* kprobe_write_ctx: for uprobe programs that can update pt_regs.
* call_get_func_ip: for tracing programs using bpf_get_func_ip().
* call_session_cookie: for fsession programs using bpf_session_cookie().
* call_session_is_return: for fsession programs using bpf_session_is_return().

For each attribute, prog_array compatibility is one-way:
programs without the requirement are rejected when tail-calling into
programs that require it.

This keeps tail-call runtime assumptions consistent. For example,
call_get_func_ip programs rely on func_ip metadata prepared on trampoline
stack; tail-calling from a !call_get_func_ip program into such a callee can
produce invalid func_ip values. The same class of issue applies to
call_session_cookie and call_session_is_return.

Links:
[1] https://lore.kernel.org/bpf/20260130081208.1130204-1-jolsa@kernel.org/

Leon Hwang (8):
  bpf: Add fsession to verbose log in check_get_func_ip()
  bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx
    progs
  bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip
    progs
  bpf: Disallow !call_session_cookie progs tail-calling
    call_session_cookie progs
  bpf: Disallow !call_session_is_return progs tail-calling
    call_session_is_return progs
  selftests/bpf: Add a test to verify kprobe_write_ctx compatibility
    enforcement
  selftests/bpf: Add a test to verify call_get_func_ip compatibility
    enforcement
  selftests/bpf: Add a test to verify session-kfunc compatibility
    enforcement

 include/linux/bpf.h                           | 11 +++--
 kernel/bpf/core.c                             | 15 ++++++
 kernel/bpf/verifier.c                         |  4 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 44 +++++++++++++++++
 .../selftests/bpf/prog_tests/fsession_test.c  | 47 +++++++++++++++++++
 .../bpf/prog_tests/get_func_ip_test.c         | 46 ++++++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       |  6 +++
 .../selftests/bpf/progs/get_func_ip_test.c    |  6 +++
 .../selftests/bpf/progs/kprobe_write_ctx.c    |  6 +++
 9 files changed, 181 insertions(+), 4 deletions(-)

-- 
2.52.0

