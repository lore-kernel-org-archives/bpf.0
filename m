Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567897;
	b=bUh2NJppV2uv8Mj3oULblw1teQ3yS+Z9I4ibvgwW5xKzr7MmzeqvzeqIv085yt1nFDQU
	 HGDdjao8yhAZSSGXvyUtTrlV8Rvm6p6Wc8BEZ/qKhZ5t62K9ulQsRbJhMS/jOlzaaNk1X
	 ngLwNBGSNrcC28i2mTVbInDJLEZgTA8RbG9Wf7jJ5uQUlHLIb5X9MZ16RmTcmy3TMKqk3
	 8f+7ngo32gth3FbVtxym820ckewZdSmUUYGbXibjpBWzlyNdklRkwLz2ntAY2Scf7jQth
	 ryP1O1EV84cGVsYsJS6+bf3Gavv25L0qF7uLkO+W9qUK6NcKIbMVMDBdpJ1odmiHN2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KDtWFQ1q0UEvySt+h1bvsMcMVBiQ9DnzI5ILdoKuc08=;
	b=4eG4ow6HgxxCc0+k+l3+z5+B64myZh9ZpkHD177yD6enI9sUaJYaNpxSU0en1swBIKVi
	 EeUJPvd12SjuwKYELmecN4ZIlO99TKgtUK5BLjYxdPENkApTCcvrOAL/+/7SNBoGtRe3o
	 B1J+LOhbsY7nAqyJyt2KZKkjzDg/RnBD7ChPwI7KHBALxtEyyQNa416Z0a0FX+2ljvR8H
	 c4gkAGZZxu8s6CAjPxZy7LFKgjqkLg/biBAOgRlCCP7dIZ+5UlY95GA/Hnm4y05V4jwRP
	 BKIe5DdKUOD6y5NjOstA6sTs4PzlK4EZ98/CkxQ5TSdoVBgym3Po2P6qn0Bw2svkbcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YZveO649;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C460A2613
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20C460A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YZveO649
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5670821eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567895; x=1796172695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDtWFQ1q0UEvySt+h1bvsMcMVBiQ9DnzI5ILdoKuc08=;
        b=YZveO649Rof8FPLG3vQia5PljE+TdVi4/r18kV6gm9nsGxHTmIW2IakL3b3FLglRHs
         MF7zXN+ex8329VUIhlV3qOsDLP0anHCKrVKGOuckVH7N206qyP5e1KuuBErp7DXNAozg
         ePWt9nD2Qj7ib0TXS9JjuloOY+UMUVP6WVafTbJknN0D5otFw1YWXy9ae+WWZETAvKh+
         O6G6pSWz4YfLjAt3cbrUc5N0kCPDyJic4PYjtStsuX8sILVTogZyyWFr808Ys4o20RPV
         +CkvH76/GgKdKQAaWJrx3AbcTRFtXz4KUpmedC2zrFDe6f9Aw2nYKZ4DF/IKJ5oDTyE0
         wNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567895; x=1796172695;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDtWFQ1q0UEvySt+h1bvsMcMVBiQ9DnzI5ILdoKuc08=;
        b=qjfOyhcoNMuuZxCPZuhUjV1gKlDgXyXhD63mRf1ByibxeL9YWAZA92NpaIOljHes/t
         4EDBQVAmZURGvwtAI7P/aa98SvcnEx9ttitlbeWYDVFLW4+/Idd2HmEZ7/ZRm83fQn8O
         Stibzx9zKvpCPWO3gyHn7YLQrfBy+lHPnkWf5O60LC8SPfi90dtqaPWJ8sEawR6QvcKm
         lcdt5zREhNOyfE03JZc1wxFcbZxqDjisw3kFuYJZKjha6knp7oOnqj7E4ye/8NoaEpc1
         /fRkwSnQH7RhjuhrnEBQaOZ9nLuTL+MhK0/2rooV9BNWGBKgImpg+gE4a5cJeeUnqiOi
         9PQQ==
X-Forwarded-Encrypted: i=1; AL+hErGgTgy0tO6FxzaHKS3jKhB07USEIq1+dvZXBhOz59oSdM2qJAZbpT9pKsfoMw0cqttmBkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9poApiz0gXyGPpXbAmYtfiZ5681WmBWtCWonL99nyftYpiFNXl
	a+9MYSNVRAifPHSTCRHAcJcc3KTOAfH0BRozsbU+7+jy6GG7VTn/FDbOlVQkc/F7N+kBtQucZmv
	Eml4IaV+7Bg==
X-Received: from dyhd10.prod.google.com ([2002:a05:7300:828a:b0:386:95bc:ec27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:140b:b0:386:ca0e:430a
 with SMTP id 5a478bee46e88-386ca0e44c5mr1999211eec.24.1795567894549; Tue, 24
 Nov 2026 16:51:34 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:56 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-8-irogers@google.com>
Subject: [PATCH v4 07/19] perf inject: Set ordered_events and
 ordering_requires_timestamps for --aslr
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 0ce6cf53db5b ("perf inject: Set ordering_requires_timestamps
before creating session") initialized ordered_events and
ordering_requires_timestamps on inject.tool before creating delegate
tools and the session, but omitted inject.aslr. Also set
ordering_requires_timestamps on aslr->tool.tool alongside ordered_events
in aslr_tool__init() so --aslr orders MMAP and sample events by
timestamp consistently.

Fixes: febea9ec382f ("perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 4 ++--
 tools/perf/util/aslr.c      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3f3108fd3981..b887a4398f96 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2810,7 +2810,7 @@ int cmd_inject(int argc, const char **argv)
 
 	data.path = inject.input_name;
 
-	ordered_events = inject.jit_mode || inject.sched_stat ||
+	ordered_events = inject.jit_mode || inject.sched_stat || inject.aslr ||
 		inject.itrace_synth_opts.vm_time_correlation ||
 		inject.itrace_synth_opts.set ||
 		inject.guest_session.perf_data_file ||
@@ -2861,7 +2861,7 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.tool.merge_deferred_callchains = false;
-	if (inject.jit_mode ||
+	if (inject.jit_mode || inject.aslr ||
 	    inject.itrace_synth_opts.vm_time_correlation ||
 	    inject.itrace_synth_opts.set ||
 	    inject.guest_session.perf_data_file ||
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index f9ecb6d3f5fb..03d6fe064559 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -1275,6 +1275,7 @@ static int aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 {
 	delegate_tool__init(&aslr->tool, delegate);
 	aslr->tool.tool.ordered_events = true;
+	aslr->tool.tool.ordering_requires_timestamps = true;
 
 	if (machines__init(&aslr->machines, /*session=*/NULL))
 		return -ENOMEM;
-- 
2.56.1.831.g720f3f5937-goog

