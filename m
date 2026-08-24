Received: from mta0.migadu.com (out-160.mta0.migadu.com [91.218.175.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5D411F8F
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577692; cv=none; b=qRR3U6Fz9s2do0c6rcT+orjCiUWyjbBks9YJizHZDEVCl79C+mlFe8hFWlDFDHnieXU1oi9a6GwfLZ+sM64RMbBP7d37CjtRdO4c1b6BfhPdtaYEifUydMmSzBWPL5NWKZlLU07Cn/InWEatQXgDuQAYCJNSr8BS404MWmAoaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577692; c=relaxed/simple;
	bh=qf+Yc6atM2RgkejUvwoRCwv1bc3J5o3sptHpC4Mb9oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiCX/dZ8ju1KQr5GE7JCOLdJJ0l3K9K50E1nrHL7LLSbWrsZK5f5ec/a7j3A7ynx7TEJEkgN/JOzrYWsn72b0fisaclUIP5Kxv52MsWQQAC8eFYAVeGoFjzqgPK3ed6ajkw1dRNCHavNwh5zt/xuFoj8UlwI31YPIyZowIx281E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CzV45v8T; arc=none smtp.client-ip=91.218.175.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CzV45v8T"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qf+Yc6atM2RgkejUvwoRCwv1bc3J5o3sptHpC4Mb9oE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787577688; v=1; x=1788182488;
 b=CzV45v8T5sS3IsLrFoFPOrrNyb8sWVaHBs2w9nGw01b6lInETnKEqdhtCG9vM0Rbc72iDuez
 EPm26wKF90SkD7/wLhguR9xU5HUzgtic3dSFCu861h+pimoNKZYStiXEMZKH+v+qyAT9Bt2c/J2
 HdMofJ62YLEwbLnuWC/B9fMg=
X-Envelope-To: bpf@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 4b68cc2e2bd4e7c7;
	Mon, 24 Aug 2026 13:21:28 +0000
X-Mizu-Trace-ID: 4b68cc2e2bd4e7c7
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	arighi@nvidia.com
Cc: void@manifault.com,
	changwoo@igalia.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v4] docs/sched_ext: document that cgroup CPU knobs are scheduler-dependent
Date: Mon, 24 Aug 2026 21:21:16 +0800
Message-ID: <20260824132116.560347-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The scheduler core communicates the initial cpu controller settings
to the BPF scheduler through ops.cgroup_init() and reports subsequent
changes through the corresponding ops.cgroup_set_*() callbacks.
Whether and how a knob takes effect is up to the loaded scheduler:
it may implement the corresponding callback partially or not at all,
so cpu.max, cpu.weight and friends can silently have no effect.

Document this in the basics section of sched-ext.rst.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
v3 -> v4: Rephrase per Andrea's suggestion: mention ops.cgroup_init()
for the initial values, ops.cgroup_set_*() only for subsequent
changes, and disambiguate per-task nice (ops.set_weight()) from
cpu.weight.nice.

v3: https://lore.kernel.org/r/20260824091501.547649-1-cui.tao@linux.dev

 Documentation/scheduler/sched-ext.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 35b550671ca7..794ae80b3ba3 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -242,6 +242,21 @@ optional. The following modified excerpt is from
             .name                   = "simple",
     };
 
+Scheduler-Dependent Knobs
+-------------------------
+
+The fair-class scheduler enforces CPU controller settings such as
+``cpu.max``, ``cpu.weight`` and ``cpu.idle``. For sched_ext tasks, the
+scheduler core communicates these settings to the BPF scheduler
+through ``ops.cgroup_init()`` and reports subsequent changes through
+the corresponding ``ops.cgroup_set_*()`` callbacks. Similarly, per-task
+nice changes are converted to weights and reported through
+``ops.set_weight()``.
+
+Each BPF scheduler is responsible for implementing the scheduling
+semantics of these settings and may choose to ignore them. Consult the
+loaded scheduler's documentation before relying on these controls.
+
 Dispatch Queues
 ---------------
 
-- 
2.43.0

