Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8325DD1E;
	Mon,  9 Mar 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023408; cv=none; b=ESe2Z3p6KKc60ztKI3D3DVzQYzL6vNrbwP6+tLLZMxTbQY1WR3Q428L8ScCV5sX8dP1piE3PczLbOrapvrKa0ofAUXfaMdweLXab6womiRNkT5eGAfGWoiZhUBOCFF7LklYbFO/vZJwr5iJ7QtiVhXkxOXGRGBdQiSqY+Fq1Tmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023408; c=relaxed/simple;
	bh=hENTq/aGe5YJgX+cZ9sFJj6Ywu60K27ZzqXQietSRYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCvqO9OKyXDqapUNmqZ1yolqgISfuLSzaC16AXnqMKST6JOWB8gBM3Sp+Otb9iikFLPOokvgVj3QmzqTZKipBgRxRMZ+VlZZ4FjJ0d5eiHw6DteJ+Z+L7MjZ8YArW6zdEf9NYkrAOPgNs1u7OpWkZLdUjcB3lc1CghgaNEeyzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QAcMXKGI; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QAcMXKGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PV
	Oyp7dJuLxWJ0ZYpqW/PPOYcZ59hmYfkcBoTxaoaxI=; b=QAcMXKGIaJHLMHs5hr
	vzPLADyQPUJLNFghvLMNj4rVO+F+hRoSHFPV6L6W8znAsQRhC/LfEinZTOs6FvQf
	1VTtG0I2QX1x1kHN1T5Nm8uFCgczLW6A8pauzloZnWUh22SMK4tJ+jNi1YUrEHwW
	tXzi9s+/+jg98s44ghe8fBXiA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgDHb_5qMK5pKd7+BA--.65315S2;
	Mon, 09 Mar 2026 10:28:59 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	emil@etsalapatis.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	zhaomengmeng@kylinos.cn
Subject: [PATCH v2 0/2] sched_ext cleanup and toolchain compatibility fixes
Date: Mon,  9 Mar 2026 10:28:45 +0800
Message-ID: <20260309022847.106150-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCkvCgDHb_5qMK5pKd7+BA--.65315S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4rWrWrZry8uFWrWFyDWrg_yoW3XrX_ua
	4Ska4DGF4qqa48JFWakr4aqry5KF48KFs8X3W3KrZ5C3yrKFn8XFn5CFy8WrykXrsxCFW7
	X3ZaqF1kJrn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1-6pPUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqgsso2muMGsTaQAA3I

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

This series contains commits rebase on lastest for-next branch:
1. remove SCX_OPS_HAS_CGROUP_WEIGHT, which was documented to
be deleted on 6.18.
2. Make scheduler scx_sdt runnable on older clang version. clang 17 and
18 tested with no verifier rejections.

Zhao Mengmeng (2):
  sched_ext: remove SCX_OPS_HAS_CGROUP_WEIGHT
  tools/sched_ext: scx_sdt: Fix BPF verifier rejection on older LLVMs

 kernel/sched/ext.c                            |  3 ---
 kernel/sched/ext_internal.h                   |  8 +-------
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 -
 tools/sched_ext/scx_flatcg.bpf.c              |  2 +-
 tools/sched_ext/scx_sdt.bpf.c                 | 20 ++++++++++++++++++-
 5 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.43.0

