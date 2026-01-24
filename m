Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189B318EE9;
	Sat, 24 Jan 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769261256; cv=none; b=mBBBrV4paQwH4YZc2DXQVx8wwgZtYI9HKSGn9aHCbYbyWlzGiIBLNnol9fEP8u4ZBwJtFKtf6B/sPSs+vVNYW3wLr1zcBraoOgc1f2H4ubSuoZKhPpFItbApQv+3U9I5aAz5nwSamhxEgNM/LEWqTRm9nYXRN+2Ky/5o14JFyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769261256; c=relaxed/simple;
	bh=7lWjXNt1tKyyfxb7E5X6pw47TSDceYxan+mIb6JP/uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2mAqGqEwLwpw4xaVzxt3Gld+AEsZuc7t18LOGr9mQYDjV39HcdlgCPQ/CGY2HKz1ZcbcQcZBN2l8krXxmbmlb0fdvNbCObyb8JVo57uDI0dqEzx0MEQGyntApRXJHP+iRwhqvk/+iOz7qiP23QcdNSyUQjOnTKZL9nbMijXuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rCjNIO2z; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rCjNIO2z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=29S7Y/VvO1YjQ75s2kG2K+G9TbRNachfHt6K/QZx1vk=; b=rCjNIO2zbIjmvpQgPSCXJU27N6
	felHCtolwQ773cKx7V33UZatgysUL8JJi1WApu3IA2FjI02GHPHJVHLNdFTQbc1ykKJ8jb2HlFVUv
	z16X1vyYfFjMxP9fSwmkP3SGpYXuOjS5hb3k4HArPTuLdGHQ1pCKjzKWzirvKkdr0a8JdfTNJCtaL
	F60t673fT2ThS3jOe2794lfY3fmJfa8EIrudaVOs8W1xrg3KDrMphPfF4dAY/+imASUqBFql/hiPp
	X3M7B5R/quNLz+VlOQm5x+An9RnJ9Y+FA5PLM0OaZrLVfcVQMle0d6gr+9YsC2bY5tTvmJf9ZXGhH
	XDEwxAcQ==;
Received: from [175.114.83.198] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjdfa-009OAq-E9; Sat, 24 Jan 2026 14:27:19 +0100
From: Changwoo Min <changwoo@igalia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	kernel-dev@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Introduce execution context detection helpers
Date: Sat, 24 Jan 2026 22:27:04 +0900
Message-ID: <20260124132706.183681-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces four new BPF-native inline helpers -- bpf_in_nmi(),
bpf_in_hardirq(), bpf_in_serving_softirq(), and bpf_in_task() -- to allow
BPF programs to query the current execution context.

Following the feedback on v1, these are implemented in bpf_experimental.h
as inline helpers wrapping get_preempt_count(). This approach allows the
logic to be JIT-inlined for better performance compared to a kfunc call,
while providing the granular context detection (e.g., hardirq vs. softirq)
required by subsystems like sched_ext.

The series includes a new selftest suite, exe_ctx, which uses bpf_testmod
to verify context detection across Task, HardIRQ, and SoftIRQ boundaries
via irq_work and tasklets. NMI context testing is omitted as NMIs cannot
be triggered deterministically within software-only BPF CI environments.

ChangeLog v1 -> v2:
- Dropped the core kernel kfunc implementations, and implemented context
  detection as inline BPF helpers in bpf_experimental.h.
- Renamed the selftest suite from ctx_kfunc to exe_ctx to reflect the
  change from kfuncs to helpers.
- Updated BPF programs to use the new inline helpers.
- Swapped clean-up order between tasklet and irqwork in bpf_testmod to 
  avoid re-scheduling the already-killed tasklet (reported by bot+bpf-ci).

Changwoo Min (2):
  selftests/bpf: Introduce execution context detection helpers
  selftests/bpf: Add tests for execution context helpers

 .../testing/selftests/bpf/bpf_experimental.h  | 38 ++++++++++++
 .../selftests/bpf/prog_tests/exe_ctx.c        | 59 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_ctx.c  | 48 +++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 ++++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  4 ++
 5 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exe_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ctx.c

-- 
2.52.0

