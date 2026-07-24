Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6443B3F7
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902496; cv=none; b=Uh6Lf+xp6kqG95knRF85WWw7KdOFaZGb+cbpwTFu/b1uFXJldovFTV0ebCZgb/dPCjB9UB1tU3BFE2Sh4kk+gHVNb6hkTfwkwwIVQk2E4lsa19dbhwOAr66PxLl5VYw+Ixc+++RReaWwwmrISvlLJjQL+D1tQHDm8Mmz8jlgPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902496; c=relaxed/simple;
	bh=Tt+UEmTFxd7iIyw7MfgL+uNlQo6gA6khaMWvBDZLW3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkRIsj58O083L6rXA0KV2Fx2gL0rnTHXlXjaVXKPhTFz56KTR4CDELUA8EcjoTOOf09974StMOs+flgFryi5TMqHC6+uJOTPdNdAXGxNaWa1KvJ5Dl3eSUD/MDlT8aVupulEXBkcdBq0cYJtq1j5pFj1LYJgCxDKORWvC7VM4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XqUctygG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XqUctygG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784902479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JPyX50IABgrOGeZ8jbVvs7VqYszA+zBxUPlFYmDs4Ww=;
	b=XqUctygGDzls3X2zdXD9FyoHZu8nxm+3TFuH4vnBCDVAAWQMbZqLA+mCn38sh/TfEQ0ZLA
	s10TO9u3PlwXNgl/hcxJgp7Iv38YoT+n2VzH/3zDL9ntHZoOgoiZOMc+1wA/erMgOp3CyA
	KsIMH/Z3exbvXkLpY/FN7CjqSqceVwg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Fix sleepable check for tracing prog
Date: Fri, 24 Jul 2026 22:14:20 +0800
Message-ID: <20260724141422.10463-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
is allowed to attach to '__x64_'-alike prefix symbols.

It is because the verifier does not verify whether the symbol is a kernel
function or a bpf prog. That said, a sleepable tracing prog is allowed to
attach to a bpf prog target whose name has '__x64_'-alike prefix.

For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
prog, and copies buffer from a user pointer with bpf_copy_from_user()
helper. After attaching the XDP prog to lo interface, the kernel BUG
could be triggered by 'ping -c 1 -W 1 127.0.0.1':

[    3.460756] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:1324

Fix it by disallowing sleepable tracing prog always when its target is
bpf prog.

Leon Hwang (2):
  bpf: Fix sleepable check for tracing prog
  selftests/bpf: Verify rejection of sleepable tracing prog

 kernel/bpf/verifier.c                         |  9 ++-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 57 +++++++++++++++++++
 .../selftests/bpf/progs/fentry_sleepable.c    | 19 +++++++
 tools/testing/selftests/bpf/progs/xdp_dummy.c |  6 ++
 4 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c

-- 
2.55.0

