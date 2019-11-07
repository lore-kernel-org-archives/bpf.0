Return-Path: <SRS0=ta3s=Y7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2818C5DF60
	for <bpf@archiver.kernel.org>; Thu,  7 Nov 2019 22:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6602166E
	for <bpf@archiver.kernel.org>; Thu,  7 Nov 2019 22:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgQrPYHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKGWOv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:14:51 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:34912 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfKGWOv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 17:14:51 -0500
Received: by mail-vk1-f202.google.com with SMTP id i124so1785803vkc.2
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 14:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rdpklo87Cbnc0oQfbWbjnhJvVaMXzhYZMl0FgWRkGnU=;
        b=bgQrPYHrhKXSpGUFfX1LxbonrqWUext52v0flekqJvgvBguDLpbp7reGofJVCdC7L2
         sM9MVXS9NETEurVbRr9UwLAfRlvw1WbnPDrdUhAcu6LJGt9HjxXnfprHm0rQZJjcAvMN
         OwHpTc6tGw5jyc4qsD2ealU5qtUpgLNpsbA5jfyHez4U0BbtI22f9ClSfu0kpcpAK+V0
         Urq2Icc2Aa7LcZHTUzxVLQKaL2ZCZlA5DRTK8E9k9ucVLhyzEIfdICSTaj3QT9+j15ci
         0s8eBcbDUjjXXt2x++C66Irs9zA8jOHuNYxE/raWoL68J7lx+t5+Fk9jxWZJliCStVjU
         ueIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rdpklo87Cbnc0oQfbWbjnhJvVaMXzhYZMl0FgWRkGnU=;
        b=Qqfx3MiM+wZkHI3nrw/0TRnCjEAVuMCKfE738tj8hMboXJRfVnTxWCwhF0X1EwGKip
         b6+9UKCTMCKt3606H6WiwS66k9KnDQYjJu4oHSjgY5/+HoaqNGwaJInlZjNYiZQXU1Ln
         HArJAMzzBJNj1BA8KoBvh7KiYbvkFncy6U5u/7E16/MUEwUhj0oj2nn60xmMp1rZPW0Z
         2POutDHFuXFdDHWVsrgqp50i4kFSSkT1MU1GeC8HBduN9vEzwEHCOODaa8Qbgh2BxmdF
         AgroUcJchnm/H4v1HyZ/lgGbHvSA/EGgRRpgHELLJTg+109bV9s0c3DzC29rssDBNUKY
         pkfw==
X-Gm-Message-State: APjAAAV4JxGPTsa219nh9fO521iViY/p3VTGfJd83eyomJNh+4purkT4
        IDsgycQTJ6YGvc9Q9zaHc0xMpbNsf8qa
X-Google-Smtp-Source: APXvYqz5bNeOCzhT6Gi4ljfOAEEIKtiXk1Y/E29tiX0hIVNxqvj2G3LdSuVpD0YdwTVjUVgXfD7RJRp4RMQ2
X-Received: by 2002:ab0:63:: with SMTP id 90mr4121250uai.91.1573164889634;
 Thu, 07 Nov 2019 14:14:49 -0800 (PST)
Date:   Thu,  7 Nov 2019 14:14:21 -0800
In-Reply-To: <20191107221428.168286-1-irogers@google.com>
Message-Id: <20191107221428.168286-4-irogers@google.com>
Mime-Version: 1.0
References: <20191030223448.12930-1-irogers@google.com> <20191107221428.168286-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v6 03/10] perf tools: avoid a malloc for array events
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
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use realloc rather than malloc+memcpy to possibly avoid a memory
allocation when appending array elements.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 5863acb34780..ffa1a1b63796 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -689,14 +689,12 @@ array_terms ',' array_term
 	struct parse_events_array new_array;
 
 	new_array.nr_ranges = $1.nr_ranges + $3.nr_ranges;
-	new_array.ranges = malloc(sizeof(new_array.ranges[0]) *
-				  new_array.nr_ranges);
+	new_array.ranges = realloc($1.ranges,
+				sizeof(new_array.ranges[0]) *
+				new_array.nr_ranges);
 	ABORT_ON(!new_array.ranges);
-	memcpy(&new_array.ranges[0], $1.ranges,
-	       $1.nr_ranges * sizeof(new_array.ranges[0]));
 	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
 	       $3.nr_ranges * sizeof(new_array.ranges[0]));
-	free($1.ranges);
 	free($3.ranges);
 	$$ = new_array;
 }
-- 
2.24.0.432.g9d3f5f5b63-goog

