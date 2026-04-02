Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF238AC86
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167057; cv=none; b=RwBP0Vj/aBlmaYXoyTTsl4pxxIZcmK+fq31V0+CU/iVBIfj3aJI4Rf6EmSniUBHP7pFbGUQjM01dsfMvg6p6qr0HIYovQhaBdJR2bjCKxYgpZcRmZMMCAuw5D+vOlGH06ZAVlGxP94p3PxxrBkTRWQOI8PfY6gEMHFloSsZqXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167057; c=relaxed/simple;
	bh=siRI0ffl20AQmueI8A3TOxwowDSSjh9DIdAqWO1oi/E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=eeUGV2PZqS+zcleM0pwGFTIg/jC/jnjOb/NyFdPNx7pBrHCpMkiUMAF+JAkBS6+7CPXSBkdw4aFdGhPb+SY8XWf8l3V4lRZdmRxSKtFsWJQbzNkDzRUMNOF5PCML+z1IglEZP1CNyDTC+/IUkpFfuENpmxcOhWDHeR8L2SVBFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6InZzXP; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6InZzXP"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128edc72e5bso555333c88.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775167052; x=1775771852; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tQ3+wXp52+vINavkRYclxQ9XykPvN9/1RMTQP4wILHI=;
        b=s6InZzXPCztg7/FO1NJS7XcLGD20y6GgeG5IOYuLcdko7JTtgSyqAFyXVXw1wMgWZX
         RmxfZOIBvpAoE8fkeDZV6VSJRzRlEPcF7ERaoCsgvGuirZGpkxzleZ2eGz/khXSgmi+I
         KfTE7ewwzEppvNQyiIo8D93nPjvl7EKLENmNJFTn1X9FnX0jkTJY5SYrDFgclTHfZqon
         AJA/O+IrJA6gPiHQshIHCuPqeVynKnIDvEt5Dpg0HZO5IoxdTvYEcAqOywnCdM8bEq1c
         MiXmn5hvONdCQ5fhSpA+UUzNxgci53nhyfwSjDbvPHuDCQ7gsMN/nJbREieUqLmkkg0/
         za9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775167052; x=1775771852;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQ3+wXp52+vINavkRYclxQ9XykPvN9/1RMTQP4wILHI=;
        b=EXs0GDSatkwceUhGt4/d3rBrJbNNhHXbbfuGIO613e2MD0GkVU1O/xWhbUUMYKbrO1
         puhEKMFqkf6vi+6r0ovQTj5IpvfdcERFzdQiLwSS7G2R98J+YWzAX0Rsmj9+6LSwXzom
         nNIHdrvMUJqnwpkxktOFjQOrzoFWiifo6AE2rTp8pg3Aax0yOBILjnJC1zWvkA/k95h3
         mO+JlIYOqHNGZJlkPGF9mKSBs5VhX/3AeebJkn2+8rGR62F5/Xss/TG8dfqjhRzp3K//
         R9yTtCmvtYmU7pgeL4h2ll4PRuezeCic6Vvf2EY4US0gzR/ASR4lMRJYb4P2IiTDzRTt
         t4SA==
X-Forwarded-Encrypted: i=1; AJvYcCXiXm+2WNMULR8m7dgr9zwlKfwXn0+r1Gw9rihl/i1St8d7FvXlrZP7EcMxgfHrKqw06bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPl5F2gPPNIQGDTh7423TRd2CUwm1PBtGTpWbd+Ojw7t3/BWT
	WDWcF2h4PqGnbDLLO6sFWjoBv6vcsSVk1/1/1VsYojwJcBT95iAyhRpIILufL0mYZf/bP2igYha
	Uv23DJ8CbOg==
X-Received: from dlec15-n1.prod.google.com ([2002:a05:701b:428f:10b0:12a:c4d6:354a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:212:b0:11b:ec5f:1c37
 with SMTP id a92af1059eb24-12bfb74468cmr361309c88.18.1775167051893; Thu, 02
 Apr 2026 14:57:31 -0700 (PDT)
Date: Thu,  2 Apr 2026 14:57:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402215727.980993-1-irogers@google.com>
Subject: [PATCH v1] perf cgroup: Update metric leader in evlist__expand_cgroup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the evlist is expanded the metric leader wasn't being updated. As
the original evsel is deleted this creates a use-after-free in
stat-shadow's prepare_metric. This was detected running the "perf stat
--bpf-counters --for-each-cgroup test" with sanitizers.

The change itself puts the copied evsel into the priv field (known
unused because of evsel__clone use) and then in a second pass over the
list updates the copied values using the priv pointer.

Fixes: d1c5a0e86a4e ("perf stat: Add --for-each-cgroup option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cgroup.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 040eb75f0804..1e0fef283826 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -417,7 +417,6 @@ static bool has_pattern_string(const char *str)
 int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgroup)
 {
 	struct evlist *orig_list, *tmp_list;
-	struct evsel *pos, *evsel, *leader;
 	struct rblist orig_metric_events;
 	struct cgroup *cgrp = NULL;
 	struct cgroup_name *cn;
@@ -452,6 +451,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgro
 		goto out_err;
 
 	list_for_each_entry(cn, &cgroup_list, list) {
+		struct evsel *pos;
 		char *name;
 
 		if (!cn->used)
@@ -467,21 +467,41 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgro
 		if (cgrp == NULL)
 			continue;
 
-		leader = NULL;
+		/* copy the list and set to the new cgroup. */
 		evlist__for_each_entry(orig_list, pos) {
-			evsel = evsel__clone(/*dest=*/NULL, pos);
+			struct evsel *evsel = evsel__clone(/*dest=*/NULL, pos);
+
 			if (evsel == NULL)
 				goto out_err;
 
+			/* stash the copy during the copying. */
+			pos->priv = &evsel->core;
 			cgroup__put(evsel->cgrp);
 			evsel->cgrp = cgroup__get(cgrp);
 
-			if (evsel__is_group_leader(pos))
-				leader = evsel;
-			evsel__set_leader(evsel, leader);
-
 			evlist__add(tmp_list, evsel);
 		}
+		/* update leader information using stashed pointer to copy. */
+		evlist__for_each_entry(orig_list, pos) {
+			struct evsel *evsel = pos->priv;
+
+			if (evsel__leader(pos))
+				evsel->core.leader = evsel__leader(pos)->priv;
+
+			if (pos->metric_leader) {
+				evsel->metric_leader =
+					container_of(pos->metric_leader->priv, struct evsel, core);
+			}
+			if (pos->first_wildcard_match) {
+				evsel->first_wildcard_match =
+					container_of(pos->first_wildcard_match->priv,
+						     struct evsel, core);
+			}
+		}
+		/* the stashed copy is no longer used. */
+		evlist__for_each_entry(orig_list, pos)
+			pos->priv = NULL;
+
 		/* cgroup__new() has a refcount, release it here */
 		cgroup__put(cgrp);
 		nr_cgroups++;
-- 
2.53.0.1213.gd9a14994de-goog

