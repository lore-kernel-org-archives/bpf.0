Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01125F7A9
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772517239; cv=none; b=mRZ7lqKjcprSQASsO14m2576FZbUIRQUH8zrf081Y01CbuYvw0xxH32rKNip0uKpdusYGZRJxh2lEcviN2jndUbt6iXRnwye9BO371EWOXUnPPTgZhSnaVc37sGLvKmhXi7tLglak8kFrQp6RaIMFSkwpZBHBDfOeRGRksScMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772517239; c=relaxed/simple;
	bh=ZGrj0j/IEip8S1DXZUxjWsPrdRhmssS4yIc31rZ7NRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Da6SsqOSeo5hnDRaC5xURc2Ph8a5UJzIzqvgs2lEummdQGiUIHPKPhLaL8xqNo/8WSAMvsI0anq8HYcr+XsJbGT36c7w5IuB8Y2CzjFFePN3Y1uhU6gph2jHm6xQs/TN3oteM7+kpnNqTNk6Bv6P/Nd8qEmB5mcu+BQv6pxcVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XvH6QivB; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XvH6QivB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772517226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kM8+aenz/ANMqnQp+57N2W5LB8WvOkGoJfAFS3XVydc=;
	b=XvH6QivBqp1s/pY5Zf+k5PI81jGpW8mY9PtTyhX6aGYPOrolJOEfaAg/sfzMJpQdnTgT5s
	WPbDzUG0l6ZQQ/nNn0JbMYNT7Tlv4nN40BH2RQuiomDXdCVDBKpeW/kfJi429QxqvYBo5d
	PoA+ebzWTtDLPwhDGx9twvAU6NWt9ZM=
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v5 0/2] Fix test_cgroup_iter_memcg issues found during back-porting
Date: Tue,  3 Mar 2026 13:53:07 +0800
Message-ID: <cover.1772505399.git.zhuhui@kylinos.cn>
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
The test_cgroup_iter_memcg test would falsely pass when
bpf_mem_cgroup_page_state() failed due to incompatible enum
values across kernel versions. Additionally, test_kmem would
fail on systems with cgroup.memory=nokmem enabled.

These patches are my fixes for the problems I encountered.

Changelog:
v5:
According to the comments of Emil Tsalapatis and JP Kobryn, dropped
"selftests/bpf: Check bpf_mem_cgroup_page_state return value".
v4:
Fixed wrong git commit log in "bpf: Use bpf_core_enum_value for stats in
cgroup_iter_memcg".
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

Hui Zhu (2):
  selftests/bpf: Remove kmem subtest from cgroup_iter_memcg
  bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg

 .../testing/selftests/bpf/cgroup_iter_memcg.h |  2 --
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 28 -------------------
 .../selftests/bpf/progs/cgroup_iter_memcg.c   | 18 ++++++++----
 3 files changed, 12 insertions(+), 36 deletions(-)

-- 
2.43.0

