Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C263407575
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463868; cv=none; b=kNHR5SQaNh/hw8OD7lpOWau9nw8B0az9KGnvns7HrXpIUuyG2fiG76jFFruy5rTeAt1qsp195rI5ycdIbKMbj7+T3xLZMEcMfBNlGv2Wt6WidSqabhlo5ydi7V83r70+i/QAmp5qY2QMenJ5Sr/DDdCR9Lu1VeQUfPrVrK8OOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463868; c=relaxed/simple;
	bh=0Cux9E8x1HBobNPf+np0AEXixVPIHPYUe2OdlIeRVlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyIdW464CIjsYZ2TszASCu4D+linuOUUq1yzLzoIrpDZt9yIcIO2usQPPaaR1bMc1BdHcI9GgBYCJbfAHTGA8eA7SMtSMMWVohlP9d3qLTR7jjkch3zRTnGeJ5doDJPK509gSbhxO+rZ3zgGwFEhXxYi9O2zFdULaV0v1eH5vbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YyCs94Yx; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YyCs94Yx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772463854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4x2c/h/IO7icPhWaROlNgoWAWAawEGFNHWfgkfkTrZs=;
	b=YyCs94Yxt+Go/xfh5eZa2bCJ+FbMG7rS1JEESNMQii+LMyGrQE0Mq37UJm0C/G68Hptvma
	MqVDfnMFrJQm1yCj4i0hLVHGqmy/BaHDRETza3zsx+oxEp2/9MWYxWlYI3SfjwdUvNUQFx
	5XxUGJW5n6JxohzHZp3PkTcd3IjYq60=
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
Subject: [PATCH bpf-next v2 0/6] bpf: Enhance __bpf_prog_map_compatible()
Date: Mon,  2 Mar 2026 23:03:36 +0800
Message-ID: <20260302150342.55709-1-leon.hwang@linux.dev>
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

kprobe_write_ctx progs can be abused to modify pt_regs of kprobe progs via
tail calls. As in the test in patch #6, a kprobe prog can "regs->di = 0;"
when it runs as a tail callee. Thus, bpf_prog_test_run_opts() gets -EFAULT
instead of success.

call_get_func_ip progs could get a bogus func IP when they run as tail
callees, because the tail caller does not prepare the func IP on the
trampoline stack. As in the test in patch #6, it gets the RBX value on
stack instead of the true func IP.

call_session_cookie progs can modify the first arg value on the trampoline
stack. As in the test in patch #6, bpf_prog_test_run_opts() also gets -EFAULT
because the first arg is modified by "*cookie = 0;".

Links:
[1] https://lore.kernel.org/bpf/20260130081208.1130204-1-jolsa@kernel.org/

Changes:
v1 -> v2:
* Factor out bpf_map_owner_init() and bpf_map_owner_matches() helpers.
* Drop the "call_session_is_return" case, because the "is_return" value is
  always prepared for fsession progs.
* Address comments from Alexei:
  * Use bitfields like 'u32 jited:1;'.
  * Reimplement selftests.
* v1: https://lore.kernel.org/bpf/20260224154024.12504-1-leon.hwang@linux.dev/

Leon Hwang (6):
  bpf: Add fsession to verbose log in check_get_func_ip()
  bpf: Factor out bpf_map_owner_[init,matches]() helpers
  bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx
    progs
  bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip
    progs
  bpf: Disallow !call_session_cookie progs tail-calling
    call_session_cookie progs
  selftests/bpf: Add tests to verify prog_array map compatibility

 include/linux/bpf.h                           |   9 +-
 kernel/bpf/core.c                             | 138 +++++---
 kernel/bpf/verifier.c                         |   2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 319 ++++++++++++++++++
 .../bpf/progs/tailcall_map_compatible.c       | 103 ++++++
 5 files changed, 521 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_map_compatible.c

--
2.52.0

