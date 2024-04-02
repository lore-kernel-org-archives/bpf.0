Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC0DDBE
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029257; cv=none; b=DCYpIYgNvmubgkTxbu/1BLSgzkbvpTpyQf8Fl70mfZ7IZv9lxcJCMfKaD+vCRmLt4jxhl9iZmXCFFMAxH4c2bJRhXAjrQT6hBd2h1fWcf4pfhTiPlFt0pFP3k0tRbaopXzf0uq3Ty4/fLlG0mW0rA2XxhnrW55i7WWhzZPd4294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029257; c=relaxed/simple;
	bh=Sgh63qY1JfD8EdWXcI3hpU/Xo67ea599nAr0p4E7axw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZGyNVhTGBG+2p1V9JV9q86mlFmkxNR4J7fn95339Sg/FjpCjcvqvNZ6gT6iyaNol+obL9Wq1UnksToBNXzlMgjYI717pVnlHnTNscRFUp28inITZgMk7AeU386RQTRJznB6tNmn4lWg3MFiZPY47dFlxLQEIOH+Lr1YMiijucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=S1FDvp0T; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="S1FDvp0T"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7cc01644f51so270767839f.2
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 20:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1712029255; x=1712634055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uX8FY+yrv4e9F04J0bM9+L1yQ/5xwgRq+sJn0HZQg6k=;
        b=S1FDvp0TCpC+mR3rNkqMxxSVnAr/kPdp7itzB5hejlT/qpveIMtQtN+9UpZ+zLYwCr
         2bfVcnOqY86MxdHJp0vXR3Qr20BYzvyTXDv1F6f6ks4pRtb3XCxJZ9KUt/zzMsd5qL05
         gP6r49eZ0GUehH62HRlR4taVmJcL3CJ4RK3i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712029255; x=1712634055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uX8FY+yrv4e9F04J0bM9+L1yQ/5xwgRq+sJn0HZQg6k=;
        b=AvteRuEmzbVcc2ZEacOZlpUDRtRNnwI9WIoMypkxmkS2liCKiFe0soP5mkaMK0dvjg
         d2sFe2MOEt4HLYNmJb9MUukYD6SW+khp6o3k6WgD1QDhq2gBF7Ge8f0q1mgcmNwZ+rqE
         b0Y1uJSiImSO59N5bQ1LE5zhdWSlHdKN2xl8BWcw5ex8rr4D7b5zNQR4CDLWWGkCzeoE
         t+p7bVJpLnxNE6MbtRP6E5HQyiBqkAggmC9JoY3CR7wO2fzkyfMaIKsyzL8wDJ5l+WYj
         B2M7dV+MGOHebNADTSaac9nmHGf4cSqH7FsetqCdo+Y9iAFWBYF/up/V8xQqcc/x6MuP
         F76Q==
X-Gm-Message-State: AOJu0YwJRSAC0t2sahzZlpJmiA+cWD/XI2QO/1L4qyBcvrf7g2Xlodhd
	DCEv8SYOsFbNeq8fJOCYyXpG38RPzOMdRHa7Q153K/TEX1CFHdUkIWUXdOD71zUGdDwUe51v3Bk
	cdYY2UA==
X-Google-Smtp-Source: AGHT+IEVZFp5NogyCjeODd2w7QwpYPWEJeno9InvtwF7nz44KJMu9yq9vyGYzyosKFmM88AZh0ZkRA==
X-Received: by 2002:a05:6602:2741:b0:7d0:883d:ee02 with SMTP id b1-20020a056602274100b007d0883dee02mr13010287ioe.18.1712029255281;
        Mon, 01 Apr 2024 20:40:55 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:4221:ce52:3081:c975])
        by smtp.gmail.com with UTF8SMTPSA id r15-20020a6b5d0f000000b007d03f311753sm3195270iob.51.2024.04.01.20.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 20:40:54 -0700 (PDT)
From: Jose Fernandez <josef@netflix.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>
Subject: [PATCH bpf-next] bpf: Improve program stats run-time calculation
Date: Mon,  1 Apr 2024 21:40:10 -0600
Message-Id: <20240402034010.25060-1-josef@netflix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch improves the run-time calculation for program stats by
capturing the duration as soon as possible after the program returns.
Previously, the duration included u64_stats_t operations. While the
instrumentation overhead is part of the total time spent when stats are
enabled, distinguishing between the program's native execution time and
the time spent due to instrumentation is crucial for accurate
performance analysis. By making this change, the patch facilitates more
precise optimization of BPF programs, enabling users to understand their
performance in environments without stats enabled.

I used a virtualized environment to measure the run-time over one minute
for a basic raw_tracepoint/sys_enter program, which just increments a
local counter. Although the virtualization introduced some performance
degradation that could affect the results, I observed approximately a
16% decrease in average run-time reported by stats with this change
(310 -> 260 nsec).

Signed-off-by: Jose Fernandez <josef@netflix.com>
---
 include/linux/filter.h  | 5 ++++-
 kernel/bpf/trampoline.c | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44934b968b57..2a8eb6fe2489 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -654,14 +654,17 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 	cant_migrate();
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		struct bpf_prog_stats *stats;
+		u64 duration;
 		u64 start = sched_clock();
 		unsigned long flags;
 
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+
+		duration = sched_clock() - start;
 		stats = this_cpu_ptr(prog->stats);
 		flags = u64_stats_update_begin_irqsave(&stats->syncp);
 		u64_stats_inc(&stats->cnt);
-		u64_stats_add(&stats->nsecs, sched_clock() - start);
+		u64_stats_add(&stats->nsecs, duration);
 		u64_stats_update_end_irqrestore(&stats->syncp, flags);
 	} else {
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index cc50607f8d8c..778453137b07 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -886,11 +886,12 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
 	     */
 	    start > NO_START_TIME) {
 		unsigned long flags;
+		u64 duration = sched_clock() - start;
 
 		stats = this_cpu_ptr(prog->stats);
 		flags = u64_stats_update_begin_irqsave(&stats->syncp);
 		u64_stats_inc(&stats->cnt);
-		u64_stats_add(&stats->nsecs, sched_clock() - start);
+		u64_stats_add(&stats->nsecs, duration);
 		u64_stats_update_end_irqrestore(&stats->syncp, flags);
 	}
 }

base-commit: 623bdd58be3727318d374f0052f9dfff1e87b854
-- 
2.34.1

