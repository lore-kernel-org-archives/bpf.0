Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C03164D4;
	Sun, 25 Jan 2026 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769342123; cv=none; b=N449dcWQHilmg32radmC/4NcSWDw7GYykL+4qI8Nd+tqYnjn3y7JHRr8Avqz7GeNPfhbLxt6LF2Ff6RFhrGXzkHGbiendSlAo6a1Q/wX3UXr89JF9RRo8NlED5SVxA4Qrb9jkDh5228TgoW1V2XHTeTS4gDQWZ6nYeish4axpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769342123; c=relaxed/simple;
	bh=bqKUYSWOlsEA8hYzIdFkkFlQIms809T5yZCQuxye8hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=humIL9e2ZuuHxlp9+lqmg0QVwChlBwC+oRdelU/OABVosYZZrn4nl8EC55HRzlb9Bw8L40F4m/O3Y+GIMGmSBIsiW4VgLV9Xv6915b0P1Mlfn0b0jR6A2vR7a8AYhDlbeqI9iMKeKybtXwLNHs7SgGPG5+mRtZhx3ngYs7+WTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DBDor3wj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DBDor3wj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wqqrEQWF0gRtivPQxqItu1roCtHQJyepGYwQCF2dIpA=; b=DBDor3wj/7vN08vmstk8Wx9I4r
	g5ovskPzpyz0QkHvFFGNcBqIGGoRypAR6eeMpeC3j/LBK9MZhsjNo+FF1i2O9TnaSPC0UYVImccCt
	Es0Q6VVFeEeX5bpISFEbtgpWD5GTVFUURt2UjYtxS3RLlz0lG3z8KAAe97thps+YA5W2JcnAeG9Db
	pU0Rv968n5NJUkO4syg8A4yrrGF288fLIrmzJ86aONnEtdU+TsguiYf5qvck6z2lX8eAlHd2pCQTz
	7ftdhnZRBx74X80+N+iNu7V0FJ7J9WhQHneqFpS0KzTVR2MhO05jUI8YexqR4UW2Ax8AMtMWjvKoR
	S7j22EcQ==;
Received: from [175.114.83.198] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjyhi-009frG-Pk; Sun, 25 Jan 2026 12:54:55 +0100
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
Subject: [PATCH bpf-next v3 0/2] selftests/bpf: Introduce execution context detection helpers
Date: Sun, 25 Jan 2026 20:54:11 +0900
Message-ID: <20260125115413.117502-1-changwoo@igalia.com>
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

ChangeLog v2 -> v3:
- Added exe_ctx to DENYLIST.s390x since new helpers are supported only
  on x86 and arm64 (patch 2).
- Added comments to helpers describing supported architectures (patch 1).

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

 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../testing/selftests/bpf/bpf_experimental.h  | 58 ++++++++++++++++++
 .../selftests/bpf/prog_tests/exe_ctx.c        | 59 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_ctx.c  | 48 +++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 ++++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  4 ++
 6 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exe_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ctx.c

-- 
2.52.0

