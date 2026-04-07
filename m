Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C92E2EF9
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528875; cv=none; b=qpykf/q/JFwSdxoEGj8pcNM1jPkBOXugpMKwNopnCV8xkJraAHVO0/mVy1erTf9RjI6sn2uuZnfM6WNLcfnkP7eAgftsHVU+vdqro6MC0ejRpr0bIQMDY86PN/LV+GpaeW0zMmNczLDEmpM3U69mCq4y77eF4H6/gsqGmr3cp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528875; c=relaxed/simple;
	bh=xr116ENgh6GConTk+CrKHjqqli2+OmQT78h7tAHpoFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVAJQAFinBGOi+w3EEr27xVrRVA/nNsTQPTS+CdSil9cG5HkVl3p1oGxXFztJjUoiWWAWGKBJbhDkqMfkdWGtVA6AaxN17d65OXOK+V4gUw5V0Du+wO//u5bdpXDfZPbVcO843kzh8c544v8j0LtMctNcgBhCugiaEQ4V0b0iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pRlteTRF; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRlteTRF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775528862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/BTSRSfR0uEztwllvIBtGt3uj4LQXe+9g40tIFFHvFA=;
	b=pRlteTRFCngwuqCfB/JPjTWBX+W/RnoxhfZoknK1Mz5RfmhefF+5ylpwY6KKZSsIYGwvV2
	ZPFBxVFOoExV/l0+Kisefx27Vx26fjtBxsSp4Gjie32VCqGcq2m1+3DCPMXTggiMfKqBlA
	E9WnvR1wIxK+1jb/NZvvrzMI4xL0XoU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: werner@verivus.ai,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB read in sock_ops and add selftest
Date: Tue,  7 Apr 2026 10:26:26 +0800
Message-ID: <20260407022720.162151-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a BPF sock_ops program accesses ctx fields with dst_reg == src_reg,
the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
destination register in the !fullsock / !locked_tcp_sock path, leading to
OOB read (GET_SK) and kernel pointer leak (GET_FIELD).

Patch 1: Fix both macros by adding BPF_MOV64_IMM(si->dst_reg, 0) in the
!fullsock landing pad.
Patch 2: Add selftests covering same-register and different-register cases
for both GET_SK and GET_FIELD.

[1] https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn/T/#u

Changes since v2:
https://lore.kernel.org/bpf/20260406031330.187630-1-jiayuan.chen@linux.dev/
- Addressed selftest review from Martin KaFai Lau: removed unused skel
  parameter, renamed to test_ns_ for automatic netns, ASSERT_GE -> ASSERT_OK_FD
- Add reviewed-by tags.

Changes since v1:
https://lore.kernel.org/bpf/20260404141010.247536-1-jiayuan.chen@linux.dev/
- Fixed the same bug in SOCK_OPS_GET_FIELD() (pointed out by AI review)
- Added SOCK_OPS_GET_FIELD same-register and GET_SK different-register
  subtests

Jiayuan Chen (2):
  bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
  selftests/bpf: Add tests for sock_ops ctx access with same src/dst
    register

 net/core/filter.c                             |   6 +-
 .../bpf/prog_tests/sock_ops_get_sk.c          |  76 ++++++++++++
 .../selftests/bpf/progs/sock_ops_get_sk.c     | 117 ++++++++++++++++++
 3 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_ops_get_sk.c

-- 
2.43.0

