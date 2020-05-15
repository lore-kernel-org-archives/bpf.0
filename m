Return-Path: <SRS0=Xcm6=65=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F2BC433E0
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B36820758
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 22:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BG6dftwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEOWRp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 May 2020 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgEOWRm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 18:17:42 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C616C05BD0C
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 15:17:42 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d11so4067652qvv.10
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WCzTCCGLOmnXKTfycmI4FwJUOkiifCaukEuyzWz74RE=;
        b=BG6dftwFF8ZH5yTvZvbKc2IJYlA6INCsvT+QzwW+cFz0r2DBOqgRfiH/kp5XTfYe47
         1JJHyrf5ZdSlIZaIJh8MuG3yUNinsdLul0pRDxl6CmayDFj/VMEZN+GqfNWdXxNKJ5Fu
         NrzKdyyMbG86pk1CZuM2HB7VNM9ywiRJ5oM3NXvOYzCy9oIAgb9KDN7rgj9q9skZ1nsH
         YElDQKEfG/k4S8CORnCJV7Q3VewS7q+wtq96Ox9Dq6G51fDpAeFIQmt3EZHeiVIi1Esu
         mFB33Abbnt6diuNImH+RwJxovTuW544YjxxGFquakl/Sm2i1vDd21g7P72GmlXgBJOd7
         qt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WCzTCCGLOmnXKTfycmI4FwJUOkiifCaukEuyzWz74RE=;
        b=UGIAcSt8HvXsomJAnYLtEcxxi0N3+fujKo8YTaHD16SVM1TuRdlWQt7yx3XA5VOqCJ
         c8e0QmCHj0vbLptlOeWsSwIniG+bPOBCe6arXXWRMwk624IXbUjSXbvGxgmrBZja+qWT
         RV2s1goiijVHE5M+BErWy5hlJyYJyAWhTVC6VvM2P7IXq1fjF120V+0GtWuh6MinkXPF
         27bQo4QMh2b9g/F6+h/Yv8ReJEOcahpEa8plSGPeMNu87p8oIFENGfiNudojv5M2lN17
         rSRI9YLSmNBTiOL7YSCFfHIdq/T5K41aaHdUNHxpnyQTxaz82rX7q+iX4aWCEkEJw9Ts
         x05Q==
X-Gm-Message-State: AOAM532aze8fs1Hisbv594Stc95ZIWZK9kbdmQZHart1Daeub3tQEPSb
        1GSs98zStwbK04Qoio6IEfvsCn/dt2pL
X-Google-Smtp-Source: ABdhPJzBqKBJJo83Ab/EA4hliZGmCNRhlzF7+LSl1/6H/hVOkVHxQlYeN5jI3zTx0nbbJvFLskdY4DNlu4mw
X-Received: by 2002:a0c:ec44:: with SMTP id n4mr5623243qvq.237.1589581061558;
 Fri, 15 May 2020 15:17:41 -0700 (PDT)
Date:   Fri, 15 May 2020 15:17:27 -0700
In-Reply-To: <20200515221732.44078-1-irogers@google.com>
Message-Id: <20200515221732.44078-3-irogers@google.com>
Mime-Version: 1.0
References: <20200515221732.44078-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v3 2/7] libbpf hashmap: Remove unused #include
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove #include of libbpf_internal.h that is unused.
Discussed in this thread:
https://lore.kernel.org/lkml/CAEf4BzZRmiEds_8R8g4vaAeWvJzPb4xYLnpF0X2VNY8oTzkphQ@mail.gmail.com/

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index bae8879cdf58..e823b35e7371 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -15,7 +15,6 @@
 #else
 #include <bits/reg.h>
 #endif
-#include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
 {
-- 
2.26.2.761.g0e0b3e54be-goog

