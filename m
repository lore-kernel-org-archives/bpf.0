Received: from mail-m1057.netease.com (mail-m1057.netease.com [154.81.10.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D5369D66;
	Fri, 29 May 2026 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024265; cv=none; b=BuZNER++W7ldc2Vu+Js7GHIt9MAa56jtzmo7JQEKKL02HjrXMyz1JJXJc1AXuqupQ9i1JKWnYDPxe2n895jqBmpeAC4qRItH80Wzngamm6YaUbULug1Q/On3vtjvCGm0CQmz1uYVsmv9FKr39Jt7mCmsoSyKIx2eX3tiNRLud4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024265; c=relaxed/simple;
	bh=VfV0jMmLnnwa1IszFYTNEBDCI9rcPfLM4jngcIyCMXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KAWn2s9VUVNr0Xv9VOChPScGa1yZRhM390wKwT2vHGQmXVI3m3NjULpfX8KAM2vuM/mvHJBhoZmbnvu5p8u5AG7J2mcOFfHe1J8QaWP3SOlRnv1DfDl/N4gB3zKDrHKdRjhQ9vhzArSsoRtxK9n17Du06E2/5EY3Cs/qX7OatY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SealUhaG; arc=none smtp.client-ip=154.81.10.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SealUhaG"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40433aa43;
	Fri, 29 May 2026 11:10:51 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: martin.lau@linux.dev
Cc: emil@etsalapatis.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>
Subject: [PATCH v2 0/3] bpf: cgroup: fix sysctl new-value handling in __cgroup_bpf_run_filter_sysctl
Date: Fri, 29 May 2026 11:10:23 +0800
Message-Id: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e71b6942a03a2kunm60a0b1e7a413c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZThhKVkxDTEIdTE1OGR9OTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=SealUhaGiNY1dbi8DxRAHuR0e772ejw3SZJyYV28S0dq3k5ByTHY6EbBBEbQKukLHSp7pNB/SXwTxhqjIMCK0XVnGOfhAEETP7ckhrNUiATFFgabP4Hoaxy+ExHB72eYZRhEMZU3SPPHsqyOnhD7Tmu6qUxJWxKG8UTppbCvUVA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=VFS8RWcgQ6cc/NneqOG3eqZOTNHVezA93vYHQTaU7jQ=;
	h=date:mime-version:subject:message-id:from;

This series fixes three bugs in the sysctl write-buffer replacement path
of __cgroup_bpf_run_filter_sysctl(). It resolves a kvzalloc()/kfree()
mismatch, adds a missing NUL terminator to the replacement string, and
updates a stale return value check to safely restore the replacement
functionality.

Patch Summary:
- patch 1 uses kvfree() for the replaced sysctl write buffer
- patch 2 NUL-terminates the replaced sysctl value
- patch 3 restores sysctl new-value replacement

Changelog:
v1 -> v2:
- added patch 2 to fix an out-of-bounds access in
  bpf_sysctl_set_new_value() by properly NUL-terminating the replaced
  sysctl value buffer.
- reordered patches 1 and 3.

Dawei Feng (3):
  bpf: cgroup: use kvfree() for replaced sysctl write buffer
  bpf: cgroup: NUL-terminate replaced sysctl value
  bpf: cgroup: restore sysctl new-value replacement

 kernel/bpf/cgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1
