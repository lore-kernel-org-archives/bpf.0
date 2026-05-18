Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FA44D6A1
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119241; cv=none; b=Dy1ndFWpiIWip1J670GYQxp/D5YANilfeF/kK+ZjgWgAXLSMgqwtm4NtCJY+8IRoD3LdeVlqMG9CPYBsbxAgPu/q1aKcaACaV9eMG5EVj+W7M75dWfm9E/08RZFpyb9OAgAZN+/p4D5ZmeMR9PaXCT7uK5JoNAhiUXUGRJrHQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119241; c=relaxed/simple;
	bh=L14klLZVHgQZQ5seTQndooWBR1p+rofTHdL1BdJlPEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RDQA4AWj++26eAiQkQyN/ZDcZOA411HhX0cdVUABHDOMRP0CC8JlJzPWvgbXBJGccEvWRyj9bLHfAFENf+USJYD3k84R3uzH6Z4rDTV1VVtd/NcHuKVtbWRDYnMOCyTnIUxKPqhGA81mp+hz34XYXnxj9iB5CEdf9Ht5mrwBpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0k/gMd3; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0k/gMd3"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d631edaaso12810672c88.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119228; x=1779724028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/d6+paeaMcTTaPCQt35CLTxbLauWsR41NVkCLRNdE7I=;
        b=H0k/gMd30KAQYok4yNOI0BBiOPDSnBn0MLL82+2G0B9XMQEEwUDwefYukbmHfGPEnm
         RqOyGVwxdqVdQRFNOWUMqpIRYFZ4rTsOtrERCRu+aJ2WRF8lJ4OVGKgi7GqSrOwco5SR
         Ip8ZYwnWkIhapNn4Emd5njwb4ByzZ68TegQWp8f+pUcHAjnqpiRqpHSZqfwTgopJeIZi
         7IzIDQ4m0rj+oxww1dCXhuLtNwQ8Qnw4+pyOuc/f3rcETHQSEX5TL2xqJMd0gyu1IaVN
         u0pjnmdJGRAQ4yBhC/XqWto5xQTWvwO5+tRZ+rLf8mBt+da9/93IEnJ/QV1CCUSq+t+o
         aT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119228; x=1779724028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d6+paeaMcTTaPCQt35CLTxbLauWsR41NVkCLRNdE7I=;
        b=g+epV7YRjOik+USwm4f3LxsLGKxwh19CUUOZ94NjYgcpjL8P8832Ro2aZo1mF1v4f1
         /qFDi9lsI2ZOYwwRpuLZAbX63erd8ZpQRc3YL8r2QvcumOGho27cWfkAUwudEm7Hy7no
         gispHTATEiWgZDKlJf9M2UiIPOSXe7uN638ixj5T5dY+aMXILUAILPr+SBZJFsBuY8yA
         IDPwYb2sOY98pLrGfQu4DXmslPrKElE/oK9fjj1ZqTKMdM0U8MFrG7Kg0VDKlyaz5jcA
         fWizI3aD9CLG4fZfZNqAxXNLUfy6TN8iXjac4RP7I0Vu8ShPZ9ZNytXYqAZG1RFpB3Rb
         w5pg==
X-Forwarded-Encrypted: i=1; AFNElJ8qdP5O0yJsCJzTeROqm2fizO+MVJcJ9kj+EgYGDhLobavqe70fkq+UlnQ+w2HBar/wewA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMlKiD1LI4wT7syIxjitlPBlMn6WnMgLFhCamfH3Zxuh77OqIk
	kVnjV2wvilBqWGYW9JvRcVifN3GKb5iNWIArDsEmVLSR4Ufw9QCp4FaHWeOwQo7LGCnYYZder0q
	KM5TQ7SS87A==
X-Received: from dlbpt3.prod.google.com ([2002:a05:7022:e803:b0:135:3471:e411])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:689d:b0:12d:ca32:5a2
 with SMTP id a92af1059eb24-135044192c9mr6931834c88.6.1779119227537; Mon, 18
 May 2026 08:47:07 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:35 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-12-irogers@google.com>
Subject: [PATCH v7 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
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

