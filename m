Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62473C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 21:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315952146E
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 21:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3/afYDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCSVx2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:53:28 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43802 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfCSVx2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 17:53:28 -0400
Received: by mail-pf1-f201.google.com with SMTP id 14so285043pfh.10
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 14:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JBvWYqlzKNPS5WdmEkTVKiNDhgt7l7OmpyXWv3wePXk=;
        b=n3/afYDT1Yqh3yHL6rUpG9pJ+SYGQbt3+CbBQPhxhsOmtWwQ9Vqb2uCqErzdKZ5MEV
         pZkhE5HqSbqwG+q5qbh4QcJEss21JQMStOFXF7HcFTnvaFl2crrIiGQQO6KY8DwHT0p3
         HwGmz4tIPmRh+8XKdUoOWRDRG/N0ikjrm+8Dz7fOE/jPb0iBemIubUZChdx4vU+t6zlN
         Dz/rGP7YgU9QEM5IxkfeEbtWc4RLlUhCBN7gY4ye0SSQui1HRyqs2EIKiUoBjzo7Vc44
         GNxMyHLoM1OMBEXciRl0GHCCJlAlPHekBW/nuj7S61KWyD6hRff68AnQHEN2Fbojw5d4
         5juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JBvWYqlzKNPS5WdmEkTVKiNDhgt7l7OmpyXWv3wePXk=;
        b=Q/9QngfhMEGQmIgkybPLWzIDfLFF119/j+4ox4dEJeOySmuTs83HFLXdhzQS0GC7kf
         VESHw65dAqMzvkJA6tzlB3GzjLYeoTb+XU7LdDqtlyDp10bdWHSqvcLZKFNd5ZpWinqO
         evJRoSW3Y0ry4GenwzrfIDKgWiqeoh4sgscrYzpmQyhirY3uYeAURSjcr7ePSWn3Q8HE
         sHET4hFXo4NZgnNOsY7NvOicTG/w3WIXomC26re2ahHgBt+MaaG0DsOEdHMqD7b/6rcJ
         jIuJo5TMwtH+VxdrV4hcZE1cgvTy2MtBfV6LHYrzNVL5hVAnoLg9yaf3Z2VlFV8K3fFC
         rLXw==
X-Gm-Message-State: APjAAAUPzO2byfKOS6x4ieofTlu4MZOnfmxDH45QrL+Q1S7g3hZzYweM
        e3B/cLJLgC0t3IzBLl7zNJ8rlyQ=
X-Google-Smtp-Source: APXvYqxCgI/WryfuFC2gEC3Xk+lkLMTtW7vDw2FB9dxI229oVPDXyCJd5MnMxlszQbVRnzj46zrJo/4=
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr2867042plr.89.1553032407642;
 Tue, 19 Mar 2019 14:53:27 -0700 (PDT)
Date:   Tue, 19 Mar 2019 14:53:24 -0700
Message-Id: <20190319215324.37242-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH bpf-next] selftests: bpf: don't depend on hardcoded perf sample_freq
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When running stacktrace_build_id_nmi, try to query
kernel.perf_event_max_sample_rate sysctl and use it as a sample_freq.
If there was an error reading sysctl, fallback to 5000.

kernel.perf_event_max_sample_rate sysctl can drift and/or can be
adjusted by the perf tool, so assuming a fixed number might be
problematic on a long running machine.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/stacktrace_build_id_nmi.c     | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index 8a114bb1c379..1c1a2f75f3d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -1,13 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 
+static __u64 read_perf_max_sample_freq(void)
+{
+	__u64 sample_freq = 5000; /* fallback to 5000 on error */
+	FILE *f;
+
+	f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
+	if (f == NULL)
+		return sample_freq;
+	fscanf(f, "%llu", &sample_freq);
+	fclose(f);
+	return sample_freq;
+}
+
 void test_stacktrace_build_id_nmi(void)
 {
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
 	const char *file = "./test_stacktrace_build_id.o";
 	int err, pmu_fd, prog_fd;
 	struct perf_event_attr attr = {
-		.sample_freq = 5000,
 		.freq = 1,
 		.type = PERF_TYPE_HARDWARE,
 		.config = PERF_COUNT_HW_CPU_CYCLES,
@@ -20,6 +32,8 @@ void test_stacktrace_build_id_nmi(void)
 	int build_id_matches = 0;
 	int retry = 1;
 
+	attr.sample_freq = read_perf_max_sample_freq();
+
 retry:
 	err = bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
-- 
2.21.0.225.g810b269d1ac-goog

