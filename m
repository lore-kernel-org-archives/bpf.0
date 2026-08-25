Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE242FF672
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625378; cv=none; b=SRciXnHmfxXo62ux5tFHnjaJsd0xegwws3DG7TdJB9d96lsJxvIY0cK6hXYesGDnqfUHr7VqTuT9/i4z/WedgNPHMLCtzKzlqDxp2Y1IOayl4LS8Gs7dvxpk5JkqZermpMBVCuEEA10XuhxMjq0ErM5wNsjew3nGJ2pT5qc53f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625378; c=relaxed/simple;
	bh=mrpRGuen2KGmyKtUXu56TYY8k8w9GN1WoAwOuJn64RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVBQNIDRTg77tPhJPVqvD0PIS5SQyys/SRAAkdvgXCeT8bOMPPPNSnYeRlFAh0noz+IrXrbpycR9A2rCZuoz3qQIxjYCO+OUqP7SxKoBxxWQxU4JGcBbSaoWFcF1hmxTtxXEQiAXyyybnLJ1IAlaAuglqjoMPbkSMnAhfvfZTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8mzvqb4; arc=none smtp.client-ip=95.215.58.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8mzvqb4"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mrpRGuen2KGmyKtUXu56TYY8k8w9GN1WoAwOuJn64RI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787625374; v=1; x=1788230174;
 b=n8mzvqb4xEqXeDHjJUNYXHkMQ9wMsF0RuYPVADZ1Fr8TZmGcqDeUVlj+UbD/cZL7KomHI0R0
 kubTVIKSPBoZVrtYTEsKIhIcS+Q7XDzZXCOawUX/pld3SseRVj1KnfQ4Mg+WdtedVvXZIYslvyB
 9ngGXpZhJlPb83fPkpMn96KY=
X-Envelope-To: bpf@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 8fa0f5375f5d2478;
	Tue, 25 Aug 2026 02:36:14 +0000
X-Mizu-Trace-ID: 8fa0f5375f5d2478
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: changwoo@igalia.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 0/2] sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
Date: Tue, 25 Aug 2026 10:35:55 +0800
Message-ID: <20260825023557.27881-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

This carries the initial cpu.idle state of a cgroup through
ops.cgroup_init(), which was the only cpu controller knob whose
initial value never reached the BPF scheduler. Patch 1 is the fix;
patch 2 renames tg->scx.idle to tg->scx.sched_idle, suggested in
review, as a separate cleanup.

Changes since v2:

- rename the new field to sched_idle, as a bare "idle" reads as CPU
  idle state in sched_ext (Tejun)
- split the tg->scx.idle rename into 2/2 so 1/2 stays minimal for
  stable backport
- add the Fixes: tag (Andrea)
- regenerate on top of current linux-next, which also resolves the CI
  conflict reported against v2

v2: https://lore.kernel.org/r/20260824142817.568085-1-cui.tao@linux.dev
v1: https://lore.kernel.org/r/20260824133954.561956-1-cui.tao@linux.dev

Tao Cui (2):
  sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
  sched_ext: rename tg->scx.idle to tg->scx.sched_idle

 include/linux/sched/ext.h   | 2 +-
 kernel/sched/ext/ext.c      | 8 +++++---
 kernel/sched/ext/internal.h | 3 +++
 kernel/sched/ext/sub.c      | 2 ++
 4 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.43.0

