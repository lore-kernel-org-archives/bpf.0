Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE63D5640
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 04:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222696; cv=none; b=siqk/B4j+Y2hB4/PBKS2u4l5Dle0t5vR4WTwP4ATZ8aeeWOt+07A2UWL5qSHrwIIU1J8LZXUAFhXqYkXlJXeBseItWQux7fcoz4kyBqGOXkBF3Qh/RqUlU9EnPDscTX6xvwEDpFT07nyGK4VXivHtrlIHcn4ku6g3iF8LkdetOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222696; c=relaxed/simple;
	bh=EZyImxcigBOaI3Lh03J91/GKsa2Gh4enEbwmZ8MnhwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EN0GJ2y2h4Hvq6sz5pVg6KyxAQMCUTh73EImb/IG/x1NFJnMbh/pKfPDVoVOdWlIBb0rmSG67X9p2k1zTbR95MeRN2nH2P3AHRvci9tlk+rtYkG0ooe89SPimAL4A3nTfOJJv7vGwlF35LTb4P1MhNc82D1m9/mFknVS0mFhZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tEnr57V5; arc=none smtp.client-ip=95.215.58.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tEnr57V5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EZyImxcigBOaI3Lh03J91/GKsa2Gh4enEbwmZ8MnhwA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790222691; v=1; x=1790827491;
 b=tEnr57V5/cXCI7HFITG5I+4K4yZBm74dKG0omFoTyFbw/0uK+R2pZC4+P5gfoBZWFTZWcWqD
 ecuoRSAgpBBxcCM0WGJQOGj7fVqSFJ6QKXa8QXQ9aR0Qj5s9ZX/Rh/YxRDN3fAQl2R35tJduvPK
 tjIn18cBTX2DrgheCvU30WyE=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id b65a1ef1592237cd;
	Thu, 24 Sep 2026 04:04:51 +0000
X-Mizu-Trace-ID: b65a1ef1592237cd
X-Migadu-Flow: FLOW_OUT
From: Hui Zhu <hui.zhu@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next 0/2] selftests and sample for bpf_proactive_reclaim
Date: Thu, 24 Sep 2026 12:04:31 +0800
Message-ID: <cover.1790222105.git.zhuhui@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Zhu <zhuhui@kylinos.cn>

This series follows the bpf_proactive_reclaim() kfunc patch (v14, acked
by Shakeel Butt, reviewed by JP Kobryn and Barry Song). Review feedback
on that series was that ~1200 lines of selftest for a ~20 line kfunc is
overkill, so the test material is split in two:

1/2 is the minimal selftest. It mirrors the memory.reclaim selftest:
charge a cgroup, call the kfunc once, and check the single bounded pass
semantics (one call reclaims at most MEMCG_CHARGE_BATCH pages and, unlike
a write to memory.reclaim, does not retry until the goal is reached).

2/2 moves the complex asynchronous scenario out of the selftests and into
samples/bpf, where it belongs: a BPF program watches the workingset
refaults of a pressured cgroup and, when they grow, reclaims a target
cgroup from a bpf_wq callback through bpf_proactive_reclaim(). It runs
in two modes: bench recreates the high/low priority benchmark of the old
selftest, and watch keeps reclaiming for user-specified cgroups as a
simple proactive-reclaim daemon. Besides exercising the kfunc end to
end, the sample is meant as a design reference for anyone building their
own BPF-driven reclaim policy on bpf_proactive_reclaim(), bpf_wq and the
memcg kfuncs.

Hui Zhu (2):
  selftests/bpf: Add bpf_proactive_reclaim test
  samples/bpf: Add memcg async reclaim example

 samples/bpf/.gitignore                        |    1 +
 samples/bpf/Makefile                          |   10 +-
 samples/bpf/memcg_async_reclaim.bpf.c         |  349 +++++
 samples/bpf/memcg_async_reclaim.h             |   39 +
 samples/bpf/memcg_async_reclaim_user.c        | 1141 +++++++++++++++++
 tools/testing/selftests/bpf/config            |    1 +
 .../bpf/prog_tests/memcg_proactive_reclaim.c  |  124 ++
 .../bpf/progs/memcg_proactive_reclaim.c       |   34 +
 8 files changed, 1698 insertions(+), 1 deletion(-)
 create mode 100644 samples/bpf/memcg_async_reclaim.bpf.c
 create mode 100644 samples/bpf/memcg_async_reclaim.h
 create mode 100644 samples/bpf/memcg_async_reclaim_user.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_proactive_reclaim.c

-- 
2.43.0

