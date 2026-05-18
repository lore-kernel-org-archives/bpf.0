Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D3385529
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079701; cv=none; b=mDidEE6xH2E0dwp5gDS49CeoOHc4hrr688VCHeLRssB/0SwIWpx2GDW+cULrPgp0VPVo20MJn54nyssm4u1xd8oR4O1kZZKwbkNCke0kTLXwu02nNRapryzV485VeVIeXkZYQxjSUqC5YITgNr8coMpet0ANzOTUBwhBb1eqWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079701; c=relaxed/simple;
	bh=L14klLZVHgQZQ5seTQndooWBR1p+rofTHdL1BdJlPEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qaTtO3BRMq0Au/7E59S9DVVSnOq4Mln6nQvz2E9Hq3P2ycq88VrZmBovCJVqMuJquQib6HWt9P1hNRyccVdb5/ZpuGBmm1gwiHybZVAozWCVRsy4J9ud7LgeRp7RNj54s+eoozEy13x+omPFGYawjmfRgje7Sxu2fAbZ0H0L080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L120rP5q; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L120rP5q"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dece274b1so2396373c88.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 21:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079696; x=1779684496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/d6+paeaMcTTaPCQt35CLTxbLauWsR41NVkCLRNdE7I=;
        b=L120rP5qKuAEv8/Efs4dUUqAFQjVLfQaQPO/Kr5XI9SY08AqHHIQGlThU/DXOrCn+i
         tqkDPGT5AB6Uuoe85c3DD8bYDCOQI2cnHsXhUZL0VyxKQMn7+4oQTCrUk377mkn+sOc2
         1brDg/EB7Pz94CE6eDhnSHoc/xxuCoP2rBcMmgjQe+YbHj8KpRQAIvovYUKnv8pznbDB
         2R0ZeDW70bd0//ArNPWdo9qMC0Ny1AwyA7aFN4/NR5oDOXB/oYIfrpsNOjr4EVUUxZiD
         mdOqoHkUbY9hB45N/cPLXczcnsNaN61TGdMxpbOkQPP0cFJ53ZbMOHxtqkTvS1rsKdW7
         c9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079696; x=1779684496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d6+paeaMcTTaPCQt35CLTxbLauWsR41NVkCLRNdE7I=;
        b=fT+dKIO3eC/K2K+0EuHDj22ftZvrzVknDjUlLRANlUZl9kQiNsnfJJEWVK6DLhIsiy
         lNzb9rahUAG4r3ct1ZU7HgkiEVfkedZ4980zGPGvFrb0l1I00uJJHqqs+ApcDrkWwUVS
         4zNIUvtMYPlxun46XLuNvMRaybafXaDx+nfXa4ROhJ/SVVdMBw3YzSqA4sFkqu2Wx24q
         20qF23CCuA5v0v5udnXoqU0adBwg1i5tWZMDGk5YvZLgNXy8W25cikd5MsbooxiWlScO
         i5khqqxV3QLClpjmDOCfzRIrThHWGHVExh9g/+A9bTQxOhWMBOIfJz21zzB9pCVxN9UV
         TXtA==
X-Forwarded-Encrypted: i=1; AFNElJ9bpO8mmA0/ReoRpfmjBK2GrMjp+sNQ2warXxVuwhNku7WNHJ7mx4e4X73XxU0zv/lTNVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcIQT86Arc6a3wgUGGSRCO8ZX9jlMsAaIz1I1Z8aMfCjKE2PP
	fvLKj2daQJj3whIseu0srD1Z5d1Xn0uVWJLuQyQsl+vIhXIDrwVueywaRWGaz4m8rHEbTF/kBzn
	7sSBPPeyNvA==
X-Received: from dlaj12.prod.google.com ([2002:a05:701b:280c:b0:134:a6ef:d90f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:388a:b0:12c:2cf8:2f30
 with SMTP id a92af1059eb24-13504414f41mr5095665c88.15.1779079695812; Sun, 17
 May 2026 21:48:15 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:37 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-12-irogers@google.com>
Subject: [PATCH v6 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Currently, jevents.py parses hundreds of JSON event and metric files
sequentially across all CPU architectures during Kbuild startup, taking
~3.3 seconds of pure single-core execution time.

Refactor jevents.py to pre-populate its internal JSON AST cache in parallel
across all available CPU cores using ProcessPoolExecutor. Define the worker
process initializer _init_worker at the top-level module scope to guarantee
flawless pickling and standard event mapping inheritance under spawn
multiprocessing semantics (avoiding AttributeError crashes when spawn is
used instead of fork). This accelerates jevents.py execution by over 11x
(from 3.3s down to ~290ms), fully reclaiming multi-core concurrency during
the build generation phase.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 7344940e776a..807c42edcd33 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -457,8 +457,8 @@ class JsonEvent:
     return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
 
 
-@lru_cache(maxsize=None)
-def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
+_json_cache = {}
+def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
   try:
     events = json.load(open(path), object_hook=JsonEvent)
@@ -474,12 +474,16 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
   if updates:
     for event in events:
       if event.metric_name in updates:
-        # print(f'Updated {event.metric_name} from\n"{event.metric_expr}"\n'
-        #       f'to\n"{updates[event.metric_name]}"')
         event.metric_expr = updates[event.metric_name]
 
   return events
 
+def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
+  key = (path, topic)
+  if key not in _json_cache:
+    _json_cache[key] = _read_json_events_impl(path, topic)
+  return _json_cache[key]
+
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
   global _arch_std_events
@@ -1381,6 +1385,14 @@ const char *describe_metricgroup(const char *group)
 }
 """)
 
+def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, str, Sequence[JsonEvent]]:
+  path, topic = task
+  return path, topic, _read_json_events_impl(path, topic)
+
+def _init_worker(std_events: dict) -> None:
+  global _arch_std_events
+  _arch_std_events = std_events
+
 def main() -> None:
   global _args
 
@@ -1459,9 +1471,25 @@ struct pmu_table_entry {
     raise IOError(f'Missing architecture directory \'{_args.arch}\'')
 
   archs.sort()
+  import concurrent.futures
+  tasks = []
+  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
+    if len(parents) == 0:
+      return
+    if item.is_file() and item.name.endswith('.json') and not item.name.endswith('metricgroups.json'):
+      tasks.append((item.path, get_topic(item.name)))
+
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     preprocess_arch_std_files(arch_path)
+    ftw(arch_path, [], collect_json)
+
+  with concurrent.futures.ProcessPoolExecutor(initializer=_init_worker, initargs=(_arch_std_events,)) as executor:
+    for path, topic, events in executor.map(_parallel_read_json_events, tasks):
+      _json_cache[(path, topic)] = events
+
+  for arch in archs:
+    arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], preprocess_one_file)
 
   _bcs.compute()
-- 
2.54.0.563.g4f69b47b94-goog

