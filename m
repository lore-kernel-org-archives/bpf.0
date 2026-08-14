Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F547668D
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718491; cv=none; b=MEhPq3WXkfCEAM1jw986cBz06E3pIfSpkHcvNBPQfjFs6sSd1YJ8nRt98Qy53bnCJ40c4sVBsKjJMpzvNh/itexMY5+hKsottEWQtWoSWib7PqqtLDJLtn5/irxJfpSUT905voXFeIUi0s+PtoKefLs5iGXstxAqVknp8+WAau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718491; c=relaxed/simple;
	bh=zKqD03tzPSsnzH6fyDRxCjMMu9x+GbKs2vMnjO2CWAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuWl/+WUz73hOl5Dg4zS0TFYYm71gwkr4CiKcFSeJL6v5SMiTmdFxiCaRjgrI1IpPdf0xKct/A9ehlKHA8OBLu127BSRRI/C7cGG+LEWC/jduM2ozmloq7yrkWgt/I6/nbOW2TH8CdV2VXFwJ38EUn7k/84m/cLUuDIOgXMV9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KHDL3CHz; arc=none smtp.client-ip=95.215.58.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KHDL3CHz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zKqD03tzPSsnzH6fyDRxCjMMu9x+GbKs2vMnjO2CWAw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786718487; v=1; x=1787323287;
 b=KHDL3CHzvkBLsEegukQIMyFisxV1BTimtAVx8OiFDii94runlD2pCthIkAbLHUU0vo9hZCVL
 QO72XuD/EDYMWVc+h1zrzTQIA9e/yyS0ZCBxgsh1NM7ovbKXxr2B4E27Pp0+p53iQDXYi8fV+ae
 VbMfuzKgsn3meWnsMRNHmQb8=
X-Envelope-To: bpf@vger.kernel.org
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 2b9e08ee58c887bc;
	Fri, 14 Aug 2026 14:41:27 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	suzhidao@xiaomi.com,
	yphbchou0911@gmail.com,
	zhaomengmeng@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] sched_ext/scx_flatcg: expire cached hweights on weight changes
Date: Fri, 14 Aug 2026 22:41:16 +0800
Message-ID: <20260814144116.2767304-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

fcg_cgroup_set_weight() updates cgc->weight and the parent's
child_weight_sum but doesn't bump hweight_gen, so the hweights cached by
cgrp_refresh_hweight() stay stale until some task activation bumps the
generation. For cgroups whose tasks never go through a 0->n runnable
transition (e.g. persistently busy ones), a cpu.weight change never
propagates to scheduling at all.

Bump hweight_gen on weight changes so the next refresh recomputes with
the new weight.

Verified on a flatcg VM: a live cpu.weight 100->800 change on a busy
cgroup leaves HWT update at 0 and the distribution unchanged; with it,
hweight_gen increments and the refresh recomputes.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0fd214cc61da..2d178c2ecacc 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -605,6 +605,9 @@ void BPF_STRUCT_OPS(fcg_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
 		pcgc->child_weight_sum += (s64)weight - cgc->weight;
 	cgc->weight = weight;
 	bpf_spin_unlock(&cgv_tree_lock);
+
+	/* expire cached hweights so the new weight propagates */
+	__sync_fetch_and_add(&hweight_gen, 1);
 }

 static bool try_pick_next_cgroup(u64 *cgidp)
-- 
2.43.0
