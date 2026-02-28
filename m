Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1536074A
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262717; cv=none; b=AaE2StC2xH8TgbSdntaeb2+fYv6rkobFA/MQNMd2y5Np33bABggEnnQUqqI+7lsR2shS/OLOkCUq3lML4Q4TcXAd8QvXq5iNTKzXCoX3iriXUeKFUKFArKwtleZ6ugPGPLmtoGzQM1wa4E37I3kqRsLYlpSi40WBkpWROXFIXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262717; c=relaxed/simple;
	bh=Ms8EsG22uyxthQIhvEAUl3ZDeaePaVnq+5tFenw3cwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEl7PJPcTmnQi9Ad9miHqlLeaS58v3Oh/8Lo2GbkxpsPoc1yPJG+HKkQkCV8+08IbRo13IoXumHfptMkvt23FNFO5+NA6DVIULou2SzIisgDJwx/I4W4ZXKI8CXayIjv8EJEaWw32x4eq5onEYp0TnU7ideC3vHa2liRUtgPmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VGo8nkMY; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VGo8nkMY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772262703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VELKfnMBQLDAugkLbOYU4A0kuCXRtG63sf7fY2MjdNU=;
	b=VGo8nkMYniA0MwSmnu9y65v2n5JxOrygnByhaa5Ofl391RF7ry+xYhBb5PjLveYGMOKBqi
	afomGA+GLWjFcP/p2EcHwlfcVqz1b6X2Zw7se3mQQF+XmNR9QbSeGB7eszIVHn9GG+XIUk
	M/+o6xwUEj4fC1ULiOGEEeB+Jz52sRE=
From: Hui Zhu <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
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
	JP Kobryn <inwardvessel@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v3 0/3] Fix test_cgroup_iter_memcg issues found during back-porting
Date: Sat, 28 Feb 2026 15:11:20 +0800
Message-ID: <cover.1772261955.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

While back-porting "mm: bpf kfuncs to access memcg data", I
encountered issues with test_cgroup_iter_memcg, specifically
in test_kmem.

These patches are my fixes for the problems I encountered.

Changelog:
v3:
According to the comments of JP Kobryn, remove kmem subtest from
cgroup_iter_memcg and fix assertion string in test_pgfault.
v2:
According to the comments of JP Kobryn, added bpf_core_enum_value()
usage in the BPF program to handle cross-kernel enum value differences
at load-time instead of compile-time.
Dropped the mm/memcontrol.c patch.
Modified test_kmem handling: instead of skipping when nokmem is set,
verify that kmem value is zero as expected.
According to the comments of bot, fixed assertion message: changed
"bpf_mem_cgroup_page_state" to "bpf_mem_cgroup_vm_events" for PGFAULT
check.

Hui Zhu (3):
  selftests/bpf: Remove kmem subtest from cgroup_iter_memcg
  bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg
  selftests/bpf: Check bpf_mem_cgroup_page_state return value

 .../testing/selftests/bpf/cgroup_iter_memcg.h |  2 -
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 38 +++++--------------
 .../selftests/bpf/progs/cgroup_iter_memcg.c   | 18 ++++++---
 3 files changed, 22 insertions(+), 36 deletions(-)

-- 
2.43.0

