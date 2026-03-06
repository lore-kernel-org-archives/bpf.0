Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53493750DB;
	Fri,  6 Mar 2026 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782490; cv=none; b=rigPuNSUSSLxns8STnDgR/IyuJhO6OHJsqDruF3j2STksLPkP7QUfXoRgq+4/ZDauXRFsAv9UOCySUrZQ3uti2BVzF58YbgERKjvhxc80TExdFui2vm8+jIz/aJuoJmrxYgpUrB0Sf00CzDFXbdFIABmy36/PQB/Ieq7A5eqwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782490; c=relaxed/simple;
	bh=88acVRlysKdGeot1IXpVpgEyypbibFl8zgCEXFjaGFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWV31/ROdCnrcgAn3SnEmmT4O0EYMynuRRoPO4b6s4d5GQYR60wCdBgePMYgNaDHwlNAPtN+obzfbTd4j0dogusgKQz3r8gVpMpBvjz1efLSS4xy2Hm9555SViS/H1F71qw2O7R9o5DYDYG+Rzt4fu2CnjLuR+BLQjzO9XNcxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=oOFn3xdy; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oOFn3xdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fg
	BNT47x0ICjUsPF5sKNqyBRVwaqlSp8sJKPeJg4Cgg=; b=oOFn3xdy0kO+G2vt1l
	UToxT5oVkpucJCb21cqY5Jn5owohDUv+rTYUFVpPNZMs62WsIYrPfuF0FMzMrEd7
	H/OErPIwQQFL8UZ6YomdEcHK9s0Y494N8K6zY6WbZEDDs76OMbx/jWX2JCF1RdTf
	0cLd3UOENdxdXbIUtm/RbLE0o=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCHt9PNgqppuc55BQ--.55212S2;
	Fri, 06 Mar 2026 15:31:25 +0800 (CST)
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
Subject: [PATCH 0/3] sched_ext cleanup and toolchain compatibility fixes
Date: Fri,  6 Mar 2026 15:31:07 +0800
Message-ID: <20260306073110.229595-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgCHt9PNgqppuc55BQ--.55212S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1DZFyrGw4ktw47CF4Durg_yoWftrc_u3
	WSk34UJFZYga48AFWakr4UKFy8KF45tFn8XF1agFZ8C39xtFn8WFn5CFyUWr95Wr43CFy7
	XF4vvF18Jrna9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbEfO3UUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlw7YUGmqgs4FiwAA3Q

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

This series contains:
1. remove SCX_OPS_HAS_CGROUP_WEIGHT, which was documented to
be deleted on 6.18. 
2. Update scx enum autogens by using scripts in scx repo.
3. Make scheduler scx_sdt runnable on older clang version. clang 17 and
18 tested with no verifier rejections.

Zhao Mengmeng (3):
  sched_ext: remove SCX_OPS_HAS_CGROUP_WEIGHT
  tools/sched_ext: Update scx enum autogens
  tools/sched_ext: scx_sdt: Fix BPF verifier rejection on older LLVMs

 kernel/sched/ext.c                            |  3 ---
 kernel/sched/ext_internal.h                   |  8 +-----
 .../sched_ext/include/scx/enum_defs.autogen.h | 26 ++++++++++++++-----
 .../sched_ext/include/scx/enums.autogen.bpf.h |  4 +--
 tools/sched_ext/include/scx/enums.autogen.h   |  3 +--
 tools/sched_ext/scx_flatcg.bpf.c              |  2 +-
 tools/sched_ext/scx_sdt.bpf.c                 | 20 +++++++++++++-
 7 files changed, 42 insertions(+), 24 deletions(-)

-- 
2.43.0

