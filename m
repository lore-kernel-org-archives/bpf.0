Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7579380FF2
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271439; cv=none; b=K69ln2SDhaWV5qIwCu3uL3tHFB/h976i1DzzHDQdpsDN8saMQmiAnztwWbQKvjgYKU5p9Th/REXqBvGd384voflMCatam+tJHevHwEk9+AE7xnxCI6G8P507VRu+kP/7zgRI3NFaoDldY66dq7oJRhVS5vLErsEpIhD43/+A38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271439; c=relaxed/simple;
	bh=nFoGK7xzSYqq0pGLmub7H78N8M/IUIz56nwCH/3Wu4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFyRd41UAJtLP1mBhznIDzvp5vJl7jy2YDMliscuE6E3rJbzctiMpDglmRiPtvzSx8pwPAR2/NXSJAQzlmOTev9GmJdfnRsBhjx448ehcgQDfHWum6J++N2qvFcSq7jBbVNav1xDSM15IvZq8Fw+/n1esnmLqJAfNa8ZgMtKi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dp0Xu22+; arc=none smtp.client-ip=91.218.175.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dp0Xu22+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nFoGK7xzSYqq0pGLmub7H78N8M/IUIz56nwCH/3Wu4M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788271435; v=1; x=1788876235;
 b=Dp0Xu22+LnxfPFFIJzLD+j4wTKaDP/uXxGeCMQz0WEgPN7kV8jj7K80YPqdVSEl3si3MfXKL
 nKAOSK463pyaKgF5txlo8MQwum52meBnNpMmfPb2phueQR08w7CUYzYOs1P8hOd/PPS/ihsCfvI
 xYkol2AdIB/KsFeV2QuT0vX0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 404391b07950eb01;
	Tue, 01 Sep 2026 14:03:55 +0000
X-Mizu-Trace-ID: 404391b07950eb01
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	arighi@nvidia.com
Cc: void@manifault.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 0/2] sched_ext: document and enforce vtime ordering constraints
Date: Tue,  1 Sep 2026 22:03:41 +0800
Message-ID: <20260901140343.764080-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Patch 1 documents the rolling-cursor and half-range requirement for
dsq_vtime ordering in scx_bpf_dsq_insert_vtime(). Patch 2 fixes
scx_flatcg's comparator to use the cyclic comparison, which is
correct there because cgrp_cap_budget() upholds that requirement.

Changes since v1:
- drop 1/2 (kernel priq comparator change): the cyclic ordering is
  the documented contract; a plain comparison causes unbounded
  starvation at the natural wrap (Andrea, Tejun)
- new 1/2: document the rolling-cursor requirement instead (Tejun)
- 2/2 (flatcg) unchanged

Tao Cui (2):
  sched_ext: document the rolling-cursor requirement for dsq_vtime
  sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe

 kernel/sched/ext/ext.c           | 5 +++++
 tools/sched_ext/scx_flatcg.bpf.c | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0

