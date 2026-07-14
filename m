Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0025B0B2
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997235; cv=none; b=SXwbwW/QXtrtzq1ufAPQKEssuSgAijNHzAPH29umorj/KTrep4XsYPcGzZVTGeuuPNx5ImrAGXlmpTE8SJpNYsVY5ZGonTq88Pik+04tOGiSgV9pScGGjGPrZVKdRfhNKE7FjjA9rKzPHPajRYRnUzIpFQ32+Qm4+fp7y7lYpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997235; c=relaxed/simple;
	bh=Jmbq4Z26iQHkmKxrnQWds2dMifspHX44AzT9QT2tZJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9KV/HKUTButfK3BtyweDKEXmzrwWgKfmAitSO6n9sZ5dXMbDYy74eU07ugBdjolQwQVHS9uVVpvNJXin0XoEq5UkvI/q96hsxD3SgSTeTuslPTwdDDZVtoMvxhakA/SezBTzpqDDie6yIMifXijQh6QTXbp6U/1DFYpoNvKQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLL2BHep; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLL2BHep"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2122420a12.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 19:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783997233; x=1784602033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/jMBU38+ad+mYHMb9OoGQI14GFwZsPgUUyAfPzMVGI=;
        b=cLL2BHep5GnbdtjZWLOklxl7i55FZc+gVX8Nt28uZfCgevk2yWeNcRv9CPMlMA99E0
         rIX6dVZNZOH2yAT/iKqWVIJ4rZ/Cudg9kEr135VgrnDhw7GRckIMPGusDdXyyAdY7/eM
         7EhB3BBBaxHj/xTD6WS13CxwljcQ2S5yvZryjctzc8AGZwUFg0Uazz1OQ9467w8mGFeH
         HyxGCrz8V+HwV/sNw2X9DS7BqPxpMVtuA8wsF9QYAW5ly4uEbDYFUyra42tOkTdmulvk
         vGZLaFs8dQ3VJQSOhC3OCmkV0xUMZZsXVzT7Ek4/XopAT8b1SEM2Q4DPsuotyBbIWVkH
         Lwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783997233; x=1784602033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/jMBU38+ad+mYHMb9OoGQI14GFwZsPgUUyAfPzMVGI=;
        b=BvBCqntY05PHkAVtDKhxibyx6dNA68cy3AAtQ/OZK6vEtgOslmPntdTGdUBUjTP1bC
         ORcx8U0F5tpahu/ocXVx2NRw454dbNhIwOPlJ8VLohtoL6mTcpkfAVW9tNxXB+p3G27T
         spmxWvzQKC/XsIATeQgYcmMag95tUv2719HtjVLQZSuOEtEawkalFS2Mo+glw3yvbegd
         +Av1tr3QI2ZhPcwkvKjzKwfjdGbvTVcA262AgHEq+xOW867apI59OQBmXSixALWhph/Y
         QqsKf/K1ofHnKYNWfXo4x4t9E4FCkbgu4WMIpmE5srKajG807oSjXnebgefbfdlAdWfH
         OBUg==
X-Forwarded-Encrypted: i=1; AHgh+RqCTLDXlCYM07vTz9oVNbzys7MQ82kpakgpvFGzRYCUJ0OUBinjXCn+IeZLxd5QXQ4PjsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyePPQu+UiKJdxEkmoEXLZFh3ctJrmlTZ/bOqQF7TgC0OaRa1sI
	8fKjgh+b64mgDzUnC8sBdzQfn3Xhvk+ZZTavGtSDg/ubclnbjm1gaof+
X-Gm-Gg: AfdE7ckktWnFO7iI148jqSD//RVTL6CdgqXZnck7/nZVr6QUb0VhVpIUVLpIdEm6zdi
	vQ59/b8gLAIxrmRcrTBhbWo8myZeN8SXp7HEoSCan20z5bVwCn3f1eqJhbguaf5da3maoj7RmfK
	ojwB6OAUaRuwRS1pVbbfe4VECotwZLCJDYPBbM08BDCNZx5fLPjgcWJVDeDCWDuR4sqJzsgqwbw
	WzpIuqGcgVWhN3H++YMQZD6mBIj9TKiCGONSIQMvcyiDwJZyZKK51iXNPqits/Q3IsoZLZzBVAZ
	xGKg8/kDnTtattmmKahl7dN6C9RLWJihU8ukOeYceNwDml4Gbqv6+8icbkKD/lFFJeIPYP+RgG/
	EiwHLsbscTgWZPRzIngu8TYO5t5GN1Twrdh6vfHdC02/jYTCPLM/HwLLcYSNPNTkwyN4Gnazwt5
	d9bLaBQ4IsQsiJeR30QTmlpYhCpuCmX3mYgeIzOZ2dt2ayWiUVdSTzDGSHGG5Azwo+Ng==
X-Received: by 2002:a05:6a00:f89:b0:842:2419:6c0b with SMTP id d2e1a72fcca58-84889637ff9mr9176103b3a.10.1783997233424;
        Mon, 13 Jul 2026 19:47:13 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f29c7d9sm671460b3a.26.2026.07.13.19.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 19:47:13 -0700 (PDT)
From: "zhidao su (Xiaomi)" <soolaugust@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
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
	K Prateek Nayak <kprateek.nayak@amd.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"zhidao su (Xiaomi)" <soolaugust@gmail.com>
Subject: [PATCH] sched_ext: Validate cid override before updating tables
Date: Tue, 14 Jul 2026 10:47:04 +0800
Message-ID: <20260714024704.3318132-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cid_override() currently updates the cid lookup tables as it
walks the user supplied mapping. If validation fails midway, earlier
entries may remain installed.

Split validation and table updates so a failed override leaves the
existing mapping unchanged.

Signed-off-by: zhidao su (Xiaomi) <soolaugust@gmail.com>
---
 kernel/sched/ext/cid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index f31113b080e9..9e3a466f296f 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -329,6 +329,11 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
 			scx_error(sch, "cid %d assigned to multiple cpus", c);
 			return;
 		}
+	}
+
+	for_each_possible_cpu(cpu) {
+		s32 c = cpu_to_cid[cpu];
+
 		scx_cpu_to_cid_tbl[cpu] = c;
 		scx_cid_to_cpu_tbl[c] = cpu;
 	}
-- 
2.43.0

