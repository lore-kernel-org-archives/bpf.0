Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8439F8A0
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147902; cv=none; b=SLl7WfzhuUM2YgsHg/87O58ccmJvorKCfcAC0t4ldTfCH7g1jJpROLgnAk7Z8EUX7yzemVZNRc0BRrlqA2cmlVaKRu7//yWv9IFQcAfU6H0eQ38tqyjQcjQiLNYWLX4SREpvAGa0hrq5KPpLL0Ggq0qe9fT7fNKfOX+vKjqp8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147902; c=relaxed/simple;
	bh=TCl7BhzQBbCsnY5l3o/WXYJUkdGYEXIPu5Fwe/8SYRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mc+D2ZweB0EsVSOmDxx7/0hYwTJWYwe0NHLZjqhy1c0uqPFS8XqcNB5qWtx+P30mwLBjYFJMCkxvAq1A8l+2MdrRtxntQmJyGjaBRh2LAzqHR2y1vvKocpOAA7V/QAsvIJJ++nVTG7vMG9dwWFxsT47NJPQYijK5TF4grSBMTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nlt3RCPi; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nlt3RCPi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769147880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rmfqlows6e91jpPk0/FW9KCyzMfQvrkQ0b/7PZSyhy8=;
	b=Nlt3RCPiygZsD8xzXrzBZTjVLR8Nzc/xsnSmcl6L9nP7155Q12nCVEUkShcyb17baLVif6
	v+Uy/66BnQLpg7T3wkg7zA71qAy5g21BGx6vLph8uEVVX8+bFB/3IAvbQ+/0jymx2gitwU
	dV5JPC1RfmA3jNmm2D2mnI87GwNLBhg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/2] bpf: Disallow BPF_F_LOCK with mixed special fields
Date: Fri, 23 Jan 2026 13:56:56 +0800
Message-ID: <20260123055658.372869-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Disallow combining BPF_F_LOCK with map values that mix bpf_spin_lock and
other special BTF fields, which may lead to undefined behavior. Such cases
are now rejected with -EOPNOTSUPP.

Map update flag validation is centralized in
bpf_map_check_op_flags() and reused across array, hash, local-storage,
and task-storage update paths, with selftests added to verify the new
behavior.

Changes:
v1 -> v2:
* Reject any unknown flag bits in map_flags when updating maps (per AI review).
* v1: https://lore.kernel.org/bpf/20260122153120.69249-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Disallow BPF_F_LOCK with mixed special fields and centralize flag
    checks
  selftests/bpf: Add tests to verify BPF_F_LOCK restrictions

 include/linux/bpf.h                           |  7 ++
 kernel/bpf/arraymap.c                         | 11 ++-
 kernel/bpf/bpf_local_storage.c                |  7 --
 kernel/bpf/bpf_task_storage.c                 |  3 -
 kernel/bpf/hashtab.c                          |  8 +--
 kernel/bpf/syscall.c                          |  4 +-
 .../selftests/bpf/prog_tests/map_lock.c       | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_map_lock.c       | 31 +++++++-
 8 files changed, 117 insertions(+), 24 deletions(-)

--
2.52.0

