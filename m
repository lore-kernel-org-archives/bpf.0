Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990F434409
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694913; cv=none; b=rovZ2DO0/OH/AUIf/dTGWwU64Q2x3wxA8j6wCNODdrMpELQ8/H0ICXh81y/T95KoWGVbi7J6+qdJaYy4d865XpEo6wQj/hQ1h5YdOsA+QrB95rIoIIGFFLIy0ySSnJEIVSCDyZGJ2F4w7VLCJY1zYqIK5yGvXaX0PThD9utUNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694913; c=relaxed/simple;
	bh=Fzun0pbCgqagkdMATIaCkUd+AoRGLeO2GOi5x47UYy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+53VIyRHPVKFGcXc96SJt+bO9VQz0QYSZuOTIpCjGob4biadt+OOhYnzo81DgY8OyIBAwmrXH5o7DvOaG3SVNBdiuc127mFvHbOukUYqotDLhCRMSikJX4HHncweXcLhuMkLNk280lBTYqIQWZaTHc2LDxW3bYYM9emSi4AWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kkh481XA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kkh481XA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783694898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Gzc+GQ/gUywc6SaUDedG3PHNHMNZAoxutaEWyAZEAI=;
	b=Kkh481XAbbS/+uISSQ4JkHst2WNDmcM02+RtDDEngCiMXfhncp6uVbDWGPyLrUycARWzJS
	p/t1IDwLwFnEdyLadAlP7Qyk8VX2h0AZhCiUPVaFp5BbsvuWNIKx6PsmhQR8aTXkAy1Y6k
	3TidiZAw92F+C0oDc1Syae+PMG5ZY7U=
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
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/2] bpf: Fix WARNING in bpf_trampoline_multi_detach
Date: Fri, 10 Jul 2026 22:47:32 +0800
Message-ID: <20260710144734.78203-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since tracing_multi link does not set ftrace_managed, it would fail to
release the tracing_multi link when attaching tracing_multi link and
then attaching fentry link.

[    3.714215] WARNING: kernel/bpf/trampoline.c:1727 at bpf_trampoline_multi_detach+0x20b/0x240, CPU#1: test_progs/97
...
[    3.733170]  bpf_tracing_multi_link_release+0x14/0x30
[    3.733890]  bpf_link_free+0x58/0x130
[    3.734414]  bpf_link_release+0x23/0x30

Fix it by setting 'ftrace_managed = true' in register_fentry_multi().

Note: the reason of targeting bpf-next tree is I'm planning to add
tracing_multi link support for bpf progs, that would rely on the fix and
have code conflict with the test.

Leon Hwang (2):
  bpf: Mark tracing_multi trampolines as ftrace managed
  selftests/bpf: Test fentry link after tracing_multi link

 kernel/bpf/trampoline.c                       |  1 +
 .../selftests/bpf/prog_tests/tracing_multi.c  | 69 +++++++++++++++++++
 .../progs/tracing_multi_intersect_attach.c    |  8 +++
 3 files changed, 78 insertions(+)

-- 
2.55.0

