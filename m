Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4239184F
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763798; cv=none; b=nsf4lFl5nOPgHILzug0Y/mO/w1eZpn9NJJMU+s5W3QkXg3m1AhHumd4FqNWZkm6hDIJL7xY8LNVpWggM3zxtIvVQFQiu0kDu6BQyr9q+P+caEcQUizQ+NCJMrg4FGGG9It/Mp1FCiAXoQfsulgjDkePboDK5ZZmuRziPASXTjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763798; c=relaxed/simple;
	bh=wP/VmfgG8uegsHyz+t5uqy0UJrm9m3L+wrFlNnRkDRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtzIf5DnqYoDtDXplWCyHvy0tyT15W0Ed0NJJoOAsl+/rvkZy9zDiubvmxGdkza/hYGj56OMSQtbs9RP22nl9dDKuYKtub9y32UnPIucj83sHGxsYgWRqW2qcMnZ1hNwRmjyrlSINJO95rCMFoy1uCdSj+prsnBGTwaCdIS507o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am2d/ton; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am2d/ton"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso3421155a91.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763796; x=1789368596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JvX58P+MDa4sWTy74Vbi1oLHS8rHG4kgimKkPCwJ7mg=;
        b=am2d/tonGCziKysd2t/tAOhK6U/C4fYVx8sBLIUNeMarz5jlmLkz1jeqUZKvs3hky8
         W9+fC2mI39xkWFWevkpaq8kFJDL9138NfdNEC/DhoEl6g9zA4EhPKPX00PV7Ph5bCa4D
         OtYIX2MRM/R5/wt1NJyqlg0ZswFlFXGKeF5ImxTBRkzrG9kpH9TuucOTRnsAGsI8XkVD
         xzp1DIo+z5IAYnYwtU4XHrfVWXoIdOY0HLEAHl92zq1WERzMfc9Pqogt5OJYw1o9bH0T
         ImDVQza6M4mXiqWCXVyza4CGM+ocherHvujaV0+JeSC9H4t0PLfm5pdn5smtxsRhifwV
         OwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763796; x=1789368596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JvX58P+MDa4sWTy74Vbi1oLHS8rHG4kgimKkPCwJ7mg=;
        b=SZRKF0Ag/Eh2vi7RTq5a/MiMJz6E0NVc43AvbXK0qlhhljCyZjfGyWNb977Ruv8oMH
         4jClX3YRmjNyYE/XUBCztJPrZWux9XvNNtVmjk+OcLR4n+hYrnBO4NptcT4soFHWCmHC
         a8CwOT66QFWdFxeynhAp7H+l2ZYIrurFA7kN9w0c9OVzPJmbx4LnLPt4vyDUFG8RvKkN
         WxavB6eZeJy1fN69i5y+KTueTS80ocCjzOswjrl+9p8DBLPWzVhaaeekAnkwevrLPkhz
         VCXlIDmWbIokbPmjd3PcOI00kkfvCA2V6lcJYWnCRLRFjVV9WdPoJNYIPV5IjGZiMaUw
         lGIQ==
X-Forwarded-Encrypted: i=1; AKwUvBykC76I01sZWP+JVRbzrXZR2X6qREy3lgpihsH/XRFFsjkp5QLnWtzksrE3VBB84/DXWdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ntIyEQzCfS8uRGsT1SAN/XMeFgsuWxSJOlKKiKDRH4QkfzLluv
	hawm1WxduLY61MI7XmQ8gKX5X2Vdc2f7Gr0qMKIwqzH1AMTCF8ULk13t
X-Gm-Gg: AYBFou3lIkJU/KlrQtZu81cs00YvbnMj9SQICBTH+3UCpDGgFwurK/pH8pRtNpHAkOs
	SoCUf5kIu5z7GVNp78UVezWJygoZsjGTMtW5V9EC/xCJuAahfwsYqeKV5/Z0LtBKYBsk4DANGCf
	BC0TZB+4S1qLvIbtOaIUIC2fZLdGABmZytN7sX/GGx7mEvXK67JkQMvR+sldz1WSKcRFw0mcxDv
	x/oQqeoiuGd36ZmzWlEb/n3xS3yuLMLQ1pGICFHrimRm4j7k6KnPVj+xZO+qvnKKzqwVuJaFqtR
	5HVUnAAwxZ3fRZJcT9f0KaeY/gteMwQywDDK8XM8aT9R3HH1faFHuKrxiLYEtQZFcnwOBLfR6rY
	Dv7zO+cM7dImUjzWBeCCd1DYaihJ1kc+NDXlrIZ7x1kHfH7MKFdo4aqAYGrjB/Np+Z9a9ULu3lX
	IpdpHMTIbP33x8XerGWhHQFil0Yk9hGKdTZ0gsG4S8u0RwlK/RBdRa5FpK9klKG4E4SbWlb0RHO
	+17RAoD2P0w2jVsQ+bK9Roz
X-Received: by 2002:a17:90a:e7d2:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-39b260d296cmr29785514a91.3.1788763796366;
        Sun, 06 Sep 2026 23:49:56 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm465210eec.31.2026.09.06.23.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:49:56 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] sched: fix typo "upto" in comments
Date: Mon,  7 Sep 2026 12:19:42 +0530
Message-ID: <20260907064943.25304-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064943.25304-1-hemanth.selam@gmail.com>
References: <20260907064943.25304-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 kernel/sched/ext/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 713aa26b2828..721f0b3c5c07 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5840,7 +5840,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
 	/*
 	 * We don't want CPUs to have more than $nr_donor_target tasks and
-	 * balancing to fill donee CPUs upto $nr_target. Once targets are
+	 * balancing to fill donee CPUs up to $nr_target. Once targets are
 	 * calculated, find the donee CPUs.
 	 */
 	nr_target = DIV_ROUND_UP(nr_tasks, nr_cpus);
@@ -8816,7 +8816,7 @@ __bpf_kfunc_start_defs();
  * task is inserted.
  *
  * When called from ops.dispatch(), there are no restrictions on @p or @dsq_id
- * and this function can be called upto ops.dispatch_max_batch times to insert
+ * and this function can be called up to ops.dispatch_max_batch times to insert
  * multiple tasks. scx_bpf_dispatch_nr_slots() returns the number of the
  * remaining slots. scx_bpf_dsq_move_to_local() flushes the batch and resets the
  * counter.
-- 
2.48.1

