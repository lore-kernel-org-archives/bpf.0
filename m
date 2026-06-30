Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52AF425CF5
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828724; cv=none; b=BxTtLWGFnjKpD2Fa/NPpQLicMoYgEd/X8amOKhkO8sOt7d8tLMH8kcnDBqNwKEyBFoOnBL291i9zWzRSmLvnFFGoTqpVm8zeSXS0X8NoY7UGwD81+K//pq2TqZAKtK4fPND+jrb/PrOathUqW9PweZWXaqLk5ufXgXx2vD/TdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828724; c=relaxed/simple;
	bh=JzP1yxmg6e+Mtu+IeE4xuIgbRjLfd5PdDeIp224oNjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rWpjTu3rQR4FNCdOt/q/sbMmuBr8OikNxDAkB85Z4VctdGv+yLV5vq4tYZs9w2vTxjCyq2uxJvoJDnj1LZntR2kaFTRmpZvhLEzKZJecClGwQVE1rHPxKZbZ86T02JvWAneQOu8+p7K2LzhZq2ZYb5Wkvt9bGP8cWRltNyK6WTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgPEo0PR; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgPEo0PR"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13980b6561dso14034389c88.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782828720; x=1783433520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5/ECPpXuCvMKEHtyjrc4cXo1HwIzQL9XhONegyQaRk=;
        b=QgPEo0PRLMVmiHMuh3IxBK5CIPdi0noHQZFLKkUe/FxYxRDfNye0xyim0uO1654sb/
         H5Fez7KOLqV24MAQc6nQY497x+EtlQaYIXrtaLid7RHbf8eH/WKCGr0GOTT9h79NWyXq
         yWqiCa6H2y0s39lf5N0wO8vqE9ZdnLTcOgXTNZEJjv5Qudu1FElS0KoTi57EQ7fiM9/I
         w8wAUoS5srfvAP1sI/4Q3Wi0MI8TAXmSY3Mj+a2xkxQGKQrNBHsEO8xyVp21jE3Q3UyD
         anf6OqqbCEbG5iM6/asv8H3rql4sFZ/A4fiJzpC/xixb2A7TTCUZJTEreXoYJaVPk6Qx
         VcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828720; x=1783433520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5/ECPpXuCvMKEHtyjrc4cXo1HwIzQL9XhONegyQaRk=;
        b=KsK5Ttjae1fZQ3rYRwSZMNPV4ISEec0HIBGL3Ys/k64hdLqk/RLC25NtgF2tjHCw2O
         3svz/SneiNP4znlmWHUqeV7T5EWaPg6sjTojoAd7YH/v0tcPNYLROQxsvKBRESBLO97C
         wthiNV1+PGvVraGnc9p1pyyd9OwpFObHgAUGY2HH3j4VB/JrJxgwtDIZQYN7tYAlpK9O
         qBuqN6LuL+ONuXnT8KuA9dzjq4uSoJrouKHCe2URDitnDbKbV2F6Z06oaVoaqyWPeRW7
         M8BugfOv2Nh5o4ZsJM2XGf8SgJP6Tc10LUobH4zePFtoVvsdyFA4pZXWLAoVfq3d8Ov8
         MaKA==
X-Forwarded-Encrypted: i=1; AFNElJ/8sVsFeSsqOMC3JcIC93DZUATCtEK9eFgqYvSWrve/g10EVJOSl0SeMWChV6WuHRtICKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhU8VRtCJW+UTiS8qLVor+7Qau/rM4GMuphvAbNOqWTyrrwXE
	QgeNl70YWoLcUKR9f3fKHtuQSHDhma55TLQ3qj8egTUv7qIunL8pW13wy2dmPpy21XVVMEPp5ZL
	tkOlP4EA13cDy7VVy77vXKA==
X-Received: from dlbcm2.prod.google.com ([2002:a05:7022:6882:b0:138:90f:8181])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:b16:b0:139:90ab:36bc with SMTP id a92af1059eb24-13b2a1dcbb5mr2425952c88.38.1782828719580;
 Tue, 30 Jun 2026 07:11:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:11:52 +0000
In-Reply-To: <20260630141152.3757722-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630141152.3757722-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630141152.3757722-2-aaronlewis@google.com>
Subject: [PATCH 1/1] tools/bpftrace: Add a simple instrumented kernel profiler
From: Aaron Lewis <aaronlewis@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, seanjc@google.com, dmatlack@google.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a simple instrumented profiler for the kernel using BpfTrace.
This profiler can arbitrarily trace kernel functions and tracepoints.
The results are then aggregated to display a hierarchical view with
accompanying timing data.

This approach allows a BpfTrace script to be used as a dedicated
kernel tracing tool (e.g., kvm_trace.bt or vfio_trace.bt) that captures
instrumented profiling data. The captured data can then be
post-processed using the provided Python script,
aggregate_bpf_results.py, which summarizes the output into a concise and
readable format.

To capture a kernel trace of the KVM selftest userspace_msr_exit_test.c
with aggregated results, run the following steps:

  1. Ensure BpfTrace is installed on the host machine.
  2. Start the tracing script:
       $ bpftrace kvm_trace.bt > kvm_trace.txt
  3. Run the experiment, e.g. selftest.
  4. Press Ctrl+C to stop the trace. The results will be written to
     kvm_trace.txt.
  5. Run the Python script to aggregate the results:
       $ python aggregate_bpf_results.py kvm_trace.txt

Example output from the python script:

  kvm_arch_vcpu_load, thread_time = 0.14ms, wall_time = 72.19ms, max = 0.01, avg = 0.00, count = 79, thread_count = 4
  kvm_arch_vcpu_put, thread_time = 0.14ms, wall_time = 72.16ms, max = 0.00, avg = 0.00, count = 79, thread_count = 4
  kvm_arch_vcpu_ioctl_run, thread_time = 1.24ms, wall_time = 51.62ms, max = 0.30, avg = 0.03, count = 37, thread_count = 3
    kvm_arch_vcpu_load, thread_time = 0.06ms, wall_time = 51.52ms, max = 0.00, avg = 0.00, count = 37, thread_count = 3
    run_guest, thread_time = 0.23ms, wall_time = 51.36ms, max = 0.01, avg = 0.00, count = 83, thread_count = 3
    kvm_vcpu_block, thread_time = 0.13ms, wall_time = 47.79ms, max = 0.01, avg = 0.00, count = 54, thread_count = 3
    kvm_arch_vcpu_put, thread_time = 0.07ms, wall_time = 51.32ms, max = 0.00, avg = 0.00, count = 37, thread_count = 3

Similarly, running the profiler against the VFIO selftest
"vfio_dma_mapping_test.c" produces:

  vfio_group_ioctl_get_device_fd, thread_time = 3039.11ms, wall_time = 6148.26ms, max = 128.16, avg = 126.63, count = 24, thread_count = 24
    vfio_df_open, thread_time = 3038.71ms, wall_time = 6148.23ms, max = 128.14, avg = 126.61, count = 24, thread_count = 24
      pcie_flr, thread_time = 2488.03ms, wall_time = 6135.88ms, max = 104.89, avg = 103.67, count = 24, thread_count = 24
        pci_dev_wait, thread_time = 0.08ms, wall_time = 6031.91ms, max = 0.00, avg = 0.00, count = 24, thread_count = 24
  vfio_iommu_type1_map_dma, thread_time = 0.14ms, wall_time = 4640.25ms, max = 0.03, avg = 0.02, count = 8, thread_count = 8
    vfio_pin_map_dma, thread_time = 0.11ms, wall_time = 4407.45ms, max = 0.02, avg = 0.02, count = 6, thread_count = 6
      vfio_pin_pages_remote, thread_time = 0.06ms, wall_time = 4407.44ms, max = 0.01, avg = 0.01, count = 6, thread_count = 6
        vaddr_get_pfns, thread_time = 0.04ms, wall_time = 4407.44ms, max = 0.01, avg = 0.01, count = 6, thread_count = 6
  vfio_iommu_type1_unmap_dma, thread_time = 0.07ms, wall_time = 4640.17ms, max = 0.01, avg = 0.01, count = 8, thread_count = 8
    vfio_unmap_unpin, thread_time = 0.05ms, wall_time = 4407.37ms, max = 0.01, avg = 0.01, count = 6, thread_count = 6
      vfio_sync_unpin, thread_time = 0.03ms, wall_time = 4407.37ms, max = 0.01, avg = 0.01, count = 6, thread_count = 6
  pcie_flr, thread_time = 2483.20ms, wall_time = 6134.88ms, max = 103.72, avg = 103.47, count = 24, thread_count = 24
    pci_dev_wait, thread_time = 0.08ms, wall_time = 6032.00ms, max = 0.01, avg = 0.00, count = 24, thread_count = 24
  vfio_df_ioctl_bind_iommufd, thread_time = 762.41ms, wall_time = 5926.98ms, max = 127.29, avg = 127.07, count = 6, thread_count = 6
    vfio_df_open, thread_time = 762.38ms, wall_time = 5926.97ms, max = 127.28, avg = 127.06, count = 6, thread_count = 6
      pcie_flr, thread_time = 621.72ms, wall_time = 5903.59ms, max = 104.03, avg = 103.62, count = 6, thread_count = 6
        pci_dev_wait, thread_time = 0.02ms, wall_time = 5800.05ms, max = 0.00, avg = 0.00, count = 6, thread_count = 6
  vfio_df_unbind_iommufd, thread_time = 622.29ms, wall_time = 5903.73ms, max = 103.78, avg = 103.71, count = 6, thread_count = 6
    pcie_flr, thread_time = 621.52ms, wall_time = 5903.60ms, max = 103.66, avg = 103.59, count = 6, thread_count = 6
      pci_dev_wait, thread_time = 0.02ms, wall_time = 5800.07ms, max = 0.01, avg = 0.00, count = 6, thread_count = 6

The results display a variety of metrics, defined as follows:

  - "thread_time": The total time captured across all threads for a given
    function or tracepoint between START_TIMER() and STOP_TIMER().
  - "wall_time": The elapsed time from when the first START_TIMER() was
    captured for a given function or tracepoint until the last STOP_TIMER().
  - "max": The largest single duration recorded from START_TIMER() to
    STOP_TIMER().
  - "avg": The average duration of a given function or tracepoint from
    START_TIMER() to STOP_TIMER().
  - "count": The number of occurrences a given function or tracepoint was
    encountered.
  - "thread_count": The number of unique threads on which a given function
    or tracepoint was observed.

It is important to note that this profiler does not come with zero
overhead. Because it relies on BpfTrace, recording the trace data
inherently introduces overhead. Tracing a high volume of events in a
short period will proportionally increase this overhead. Therefore, the
goal is not to create an instrumented profiler that traces everything in
the kernel with a single script. Instead, the goal is to create a
focused script that captures targeted, concrete timing data. This data
can then be paired with a sample profiler (e.g., perf) and
potentially an off-CPU profiler to more accurately reason about
performance bottlenecks.

For example, having both the total duration of a function and its
off-CPU time allows us to determine the exact breakdown of time spent
running versus sleeping. If a function spends the majority of its time
running, the perf data will highlight the bottleneck; conversely, if
more time is spent sleeping, the off-CPU trace will pinpoint the issue.
By providing the total time, we can definitively point to where the problem
lies. Furthermore, this approach adds critical context to the sample
profiler by grounding its data with concrete run times.

Alternatively, this tool can be utilized for general runtime monitoring.
It provides visibility into code execution flow, tracks the frequency
of function calls, and offers an overall understanding of system runtime
behavior.

A future development opportunity could be to extend a flamegraph
generator to accept this tool's output. Given the hierarchy, the
function name, and the thread time, all the necessary data is already
present to successfully generate a flamegraph.
---
 .../aggregate_bpf_results.py                  | 318 ++++++++++++++++++
 .../samples/kvm_trace.bt                      | 197 +++++++++++
 .../samples/vfio_trace.bt                     | 315 +++++++++++++++++
 3 files changed, 830 insertions(+)
 create mode 100644 tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py
 create mode 100644 tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt
 create mode 100644 tools/bpftrace/instrumented_profiler/samples/vfio_trace.bt

diff --git a/tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py b/tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py
new file mode 100644
index 000000000000..f4ffe8cff441
--- /dev/null
+++ b/tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py
@@ -0,0 +1,318 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Prints the aggregate results of an instrumented BPF trace.
+#
+# Copyright 2026 Google LLC
+#
+# Author: Aaron Lewis <aaronlewis@google.com>
+
+import fileinput
+import re
+import sys
+import warnings
+from typing import List, Sequence
+
+class ProfilerResult:
+  """Class for holding the profiler results."""
+
+  def __init__(
+      self,
+      name: str,
+      thread_usec: int,
+      wall_usec: int,
+      max_usec: int,
+      avg_usec: int,
+      count: int,
+      thread_count: int,
+      incomplete_count: int,
+      depth: int,
+  ):
+    self.name = name
+    self.thread_usec = thread_usec
+    self.wall_usec = wall_usec
+    self.max_usec = max_usec
+    self.avg_usec = avg_usec
+    self.count = count
+    self.thread_count = thread_count
+    self.incomplete_count = incomplete_count
+    self.depth = depth
+
+class BpfTimer:
+  """Class for holding a timer."""
+
+  def __init__(
+      self,
+      name: str,
+      start_time_us: int,
+      duration_us: int,
+      depth: int,
+  ):
+    self.name = name
+    self.start_time_us = start_time_us
+    self.duration_us = duration_us
+    self.depth = depth
+
+class BpfResult:
+  """Class for holding the profiler results."""
+
+  def __init__(
+      self,
+      name: str,
+      wall_time_start_us: int,
+      wall_time_end_us: int,
+      thread_us: int,
+      max_us: int,
+      avg_us: int,
+      count: int,
+      thread_count: int,
+      depth: int,
+      tid: int,
+  ):
+    self.name = name
+    self.wall_time_start_us = wall_time_start_us
+    self.wall_time_end_us = wall_time_end_us
+    self.thread_us = thread_us
+    self.max_us = max_us
+    self.avg_us = avg_us
+    self.count = count
+    self.thread_count = thread_count
+    self.depth = depth
+    self.children = []
+    self.child_index = {}
+    self.threads = {}
+    self.threads[tid] = True
+
+def update_child(r: BpfResult, timer: BpfTimer, tid: int) -> int:
+  i = r.child_index.get(timer.name)
+  if i is None:
+    i = len(r.children)
+    r.children.append(BpfResult(
+        timer.name,
+        timer.start_time_us,
+        timer.start_time_us + timer.duration_us,
+        timer.duration_us,
+        timer.duration_us,
+        timer.duration_us,
+        1,
+        1,
+        timer.depth,
+        tid))
+    r.child_index[timer.name] = i
+  else:
+    r.children[i].wall_time_start_us = min(r.children[i].wall_time_start_us, timer.start_time_us)
+    r.children[i].wall_time_end_us = max(r.children[i].wall_time_end_us, timer.start_time_us + timer.duration_us)
+    r.children[i].thread_us += timer.duration_us
+    r.children[i].max_us = max(r.children[i].max_us, timer.duration_us)
+    r.children[i].count += 1
+    r.children[i].avg_us = r.children[i].thread_us / r.children[i].count
+    if r.children[i].threads.get(tid) is None:
+      r.children[i].threads[tid] = True
+      r.children[i].thread_count += 1
+
+  return i
+
+def merge_recursive(r: BpfResult, tid: int, timers: List[BpfTimer], index: int, child_index: int) -> int:
+  while index < len(timers):
+    while index < len(timers) and timers[index] == None:
+      index += 1
+
+    if index >= len(timers):
+      return index
+
+    # The timer is a child of 'r'. (Child case)
+    if timers[index].depth == (r.depth + 1):
+      # Add child
+      child_index = update_child(r, timers[index], tid)
+
+      # Now that the timer has been handled increment to the next one.
+      index += 1
+
+    # The timer is a child of 'r'. (Grandchild case)
+    elif timers[index].depth == (r.depth + 2):
+      if child_index < 0:
+        raise ValueError("Invalid 'child_index'")
+      # Recurse down the child becuase that is the parent this timer.
+      index = merge_recursive(r.children[child_index], tid, timers, index, child_index)
+
+    # The timer is a descendant of 'r', but not the child... Invalid case!
+    elif timers[index].depth > (r.depth + 2):
+      raise ValueError("Invalid depth.  descendant can only be children. name = '%s', tid = %d, index = %d" % (timers[index].name, tid, index))
+
+    # New family tree.  Pop out of this one.
+    elif timers[index].depth <= r.depth:
+      # The timer is an ancestor of 'r'.  Return so it can be processed elsewhere.
+      return index
+
+  return index
+
+def merge_timers(r: BpfResult, tid: int, timers: List[BpfTimer]):
+  if len(timers) == 0:
+    return
+
+  if timers[0].depth != 0:
+    raise ValueError("Expected a depth of 0.  '%s', depth = %d" % (timers[0].name, timers[0].depth))
+
+  merge_recursive(r, tid, timers, 0, -1)
+
+def print_recursive(r: BpfResult, results : List[ProfilerResult]):
+  thread_time = float(r.thread_us) / 1000.0
+  wall_time_us = r.wall_time_end_us - r.wall_time_start_us
+  wall_time = float(wall_time_us) / 1000.0
+  max_time = float(r.max_us) / 1000.0
+  avg_time = float(r.avg_us) / 1000.0
+
+  indent = ""
+  for i in range(r.depth):
+    indent += "  "
+
+  print("%s%s, thread_time = %.2fms, wall_time = %.2fms, max = %.2f, avg = %.2f, count = %d, thread_count = %d" %
+        (indent, r.name, thread_time, wall_time, max_time, avg_time, r.count, r.thread_count));
+
+  results.append(
+      ProfilerResult(
+          r.name,
+          r.thread_us,
+          wall_time_us,
+          r.max_us,
+          r.avg_us,
+          r.count,
+          r.thread_count,
+          0,
+          r.depth,
+      )
+  )
+
+  for child in r.children:
+    print_recursive(child, results)
+
+def print_results(r: BpfResult, results : List[ProfilerResult]):
+  for child in r.children:
+    print_recursive(child, results)
+
+def generate_from_log(files: Sequence[str]):
+  """Read the trace and return a list of ProfilerResult objects."""
+
+  timer_counts = {}
+  all_timers = {}
+
+  count_regex = re.compile(
+      r"^@timer_count\[(?P<tid>[0-9]+)\]:\W(?P<count>[-0-9]+)"
+  )
+  name_regex = re.compile(
+      r"^@timer_name\[(?P<tid>[0-9]+),\W*(?P<index>[0-9]+)\]:\W(?P<name>[\w\.0-9]+)"
+  )
+  start_time_regex = re.compile(
+      r"^@timer_start\[(?P<tid>[0-9]+),\W*(?P<index>[0-9]+)\]:\W(?P<start_time_us>[-0-9]+)"
+  )
+  duration_regex = re.compile(
+      r"^@timer_duration\[(?P<tid>[0-9]+),\W*(?P<index>[0-9]+)\]:\W(?P<duration_us>[-0-9]+)"
+  )
+  depth_regex = re.compile(
+      r"^@timer_depth\[(?P<tid>[0-9]+),\W*(?P<index>[0-9]+)\]:\W(?P<depth>[-0-9]+)"
+  )
+
+  attaching_regex = re.compile(
+      r"^Attaching.*"
+  )
+
+  # Get all counts.  That way we know how many timers each thread used.
+  for line in fileinput.input(files=files):
+    line = line.rstrip()
+
+    m = re.fullmatch(duration_regex, line)
+    if m:
+      tid = int(m.group("tid"))
+      index = int(m.group("index"))
+      duration_str = m.group("duration_us")
+      duration = int(m.group("duration_us"))
+
+      if not tid in timer_counts:
+        timer_counts[tid] = index
+      else:
+        timer_counts[tid] = max(timer_counts[tid], index)
+
+  # Allocate enough timers to fit the trace.
+  for tid, count in timer_counts.items():
+    all_timers[tid] = [None] * (count + 1)
+
+  # Populate the trace.
+  for line in fileinput.input(files=files):
+    line = line.rstrip()
+
+    m = re.fullmatch(name_regex, line)
+    if m:
+      tid = int(m.group("tid"))
+      index = int(m.group("index"))
+      name = m.group("name")
+      if all_timers[tid][index] == None:
+        all_timers[tid][index] = BpfTimer("", 0, -1, -1)
+      all_timers[tid][index].name = name
+      continue
+
+    m = re.fullmatch(start_time_regex, line)
+    if m:
+      tid = int(m.group("tid"))
+      index = int(m.group("index"))
+      start_time = int(m.group("start_time_us"))
+      if all_timers[tid][index] == None:
+        all_timers[tid][index] = BpfTimer("", 0, -1, -1)
+      all_timers[tid][index].start_time_us = start_time
+      continue
+
+    m = re.fullmatch(duration_regex, line)
+    if m:
+      tid = int(m.group("tid"))
+      index = int(m.group("index"))
+      duration = int(m.group("duration_us"))
+      if all_timers[tid][index] == None:
+        all_timers[tid][index] = BpfTimer("", 0, -1, -1)
+      all_timers[tid][index].duration_us = duration
+      continue
+
+    m = re.fullmatch(depth_regex, line)
+    if m:
+      tid = int(m.group("tid"))
+      index = int(m.group("index"))
+      depth = int(m.group("depth"))
+      if all_timers[tid][index] == None:
+        all_timers[tid][index] = BpfTimer("", 0, -1, -1)
+      all_timers[tid][index].depth = depth
+      continue
+
+    if re.fullmatch(count_regex, line):
+      # Skip this case.  It's already been processed.
+      continue
+    if re.fullmatch(attaching_regex, line):
+      # Skip "Attaching XX probes..."
+      continue
+    if not line:
+      # Skip empty strings.
+      continue
+
+    raise ValueError("Invalid input, '%s'" % (line))
+
+  root = BpfResult("", 0, 0, 0, 0, 0, 1, 1, -1, -1)
+  results = []
+  for tid, timers in all_timers.items():
+    merge_timers(root, tid, timers)
+  print_results(root, results)
+
+  if fileinput.fileno() == 0:
+    raise ValueError("Expected a file to read.")
+
+  if fileinput.fileno() > 1:
+    raise ValueError("Too many files read.  Expected 1")
+
+def main() -> None:
+  """Main function."""
+
+  if len(sys.argv) <= 1:
+    print("Error: Not enough command-line arguments. Expected an input file", file=sys.stderr)
+    sys.exit(1)
+
+  generate_from_log(sys.argv[1:])
+
+
+if __name__ == "__main__":
+  main()
diff --git a/tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt b/tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt
new file mode 100644
index 000000000000..bd341e408570
--- /dev/null
+++ b/tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt
@@ -0,0 +1,197 @@
+#define usecs (nsecs / 1000)
+#define msecs (nsecs / 1000 / 1000)
+#define DURATION_UNSET ((uint64)-1)
+
+config = { max_map_keys=4194304; }
+
+macro INIT_MAPS(@trace_stack_top, @timer_count)
+{
+	@trace_stack_top[0] = 0;
+	@timer_count[0] = 0;
+}
+
+macro CLEAR_MAPS(@trace_stack, @trace_stack_top, @timer_count)
+{
+	clear(@trace_stack);
+	clear(@trace_stack_top);
+	clear(@timer_count);
+}
+
+macro START_TIMER(name, @timer_name, @trace_stack, @timer_start, @timer_duration,
+		  @timer_depth, @timer_count, @trace_stack_top)
+{
+	@timer_name[tid, @timer_count[tid]] = name;
+	@trace_stack[tid, @trace_stack_top[tid]] = @timer_count[tid];
+	@timer_start[tid, @timer_count[tid]] = usecs;
+	@timer_duration[tid, @timer_count[tid]] = DURATION_UNSET;
+	@timer_depth[tid, @timer_count[tid]] = @trace_stack_top[tid];
+	@timer_count[tid]++;
+	@trace_stack_top[tid]++;
+}
+
+/*
+ * Unfortunately branch statements crash the bpftrace compiler.  As a result,
+ * the branch has been moved directly into the probe.  Reverse this if the
+ * compiler ever gets that fixed.
+ */
+macro STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start)
+{
+	$idx = @trace_stack[tid, --@trace_stack_top[tid]];
+	@timer_duration[tid, $idx] = usecs - @timer_start[tid, $idx];
+}
+
+BEGIN
+{
+	INIT_MAPS(@trace_stack_top, @timer_count);
+}
+
+/*
+ * Time 'kvm_sched_in()'.
+ *
+ * Check: sudo grep kvm_sched_in /proc/kallsyms
+ */
+kfunc:kvm_sched_in
+{
+	START_TIMER("kvm_sched_in",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:kvm_sched_in
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'kvm_sched_out()'.
+ *
+ * Check: sudo grep kvm_sched_out /proc/kallsyms
+ */
+kfunc:kvm_sched_out
+{
+	START_TIMER("kvm_sched_out",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+
+kretfunc:kvm_sched_out
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'kvm_arch_vcpu_load()'.
+ *
+ * Check: sudo grep kvm_arch_vcpu_load /proc/kallsyms
+ */
+kfunc:kvm_arch_vcpu_load
+{
+	START_TIMER("kvm_arch_vcpu_load",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:kvm_arch_vcpu_load
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'kvm_arch_vcpu_put()'.
+ *
+ * Check: sudo grep kvm_arch_vcpu_put /proc/kallsyms
+ */
+kfunc:kvm_arch_vcpu_put
+{
+	START_TIMER("kvm_arch_vcpu_put",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:kvm_arch_vcpu_put
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'KVM_RUN', i.e. kvm_arch_vcpu_ioctl_run().
+ *
+ * Check: sudo grep kvm_arch_vcpu_ioctl_run /proc/kallsyms
+ */
+kfunc:kvm_arch_vcpu_ioctl_run
+{
+	START_TIMER("kvm_arch_vcpu_ioctl_run",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:kvm_arch_vcpu_ioctl_run
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time how long a guest runs using tracepoints "kvm_entry" and "kvm_exit".
+ */
+tracepoint:kvm:kvm_entry
+{
+	START_TIMER("run_guest",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+tracepoint:kvm:kvm_exit
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'kvm_vcpu_block()'.
+ *
+ * Check: sudo grep kvm_vcpu_block /proc/kallsyms
+ */
+kfunc:kvm_vcpu_block
+{
+	START_TIMER("kvm_vcpu_block",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:kvm_vcpu_block
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'kvm_mmu_page_fault()'.
+ *
+ * Check: sudo grep kvm_mmu_page_fault /proc/kallsyms
+ */
+kfunc:kvm_mmu_page_fault
+{
+	START_TIMER("kvm_vcpu_block",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:kvm_mmu_page_fault
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Dump the results to stdout.
+ */
+END
+{
+	CLEAR_MAPS(@trace_stack, @trace_stack_top, @timer_count);
+}
diff --git a/tools/bpftrace/instrumented_profiler/samples/vfio_trace.bt b/tools/bpftrace/instrumented_profiler/samples/vfio_trace.bt
new file mode 100644
index 000000000000..3b8cb7ff6210
--- /dev/null
+++ b/tools/bpftrace/instrumented_profiler/samples/vfio_trace.bt
@@ -0,0 +1,315 @@
+#define usecs (nsecs / 1000)
+#define msecs (nsecs / 1000 / 1000)
+#define DURATION_UNSET ((uint64)-1)
+
+config = { max_map_keys=4194304; }
+
+macro INIT_MAPS(@trace_stack_top, @timer_count)
+{
+	@trace_stack_top[0] = 0;
+	@timer_count[0] = 0;
+}
+
+macro CLEAR_MAPS(@trace_stack, @trace_stack_top, @timer_count)
+{
+	clear(@trace_stack);
+	clear(@trace_stack_top);
+	clear(@timer_count);
+}
+
+macro START_TIMER(name, @timer_name, @trace_stack, @timer_start, @timer_duration,
+		  @timer_depth, @timer_count, @trace_stack_top)
+{
+	@timer_name[tid, @timer_count[tid]] = name;
+	@trace_stack[tid, @trace_stack_top[tid]] = @timer_count[tid];
+	@timer_start[tid, @timer_count[tid]] = usecs;
+	@timer_duration[tid, @timer_count[tid]] = DURATION_UNSET;
+	@timer_depth[tid, @timer_count[tid]] = @trace_stack_top[tid];
+	@timer_count[tid]++;
+	@trace_stack_top[tid]++;
+}
+
+/*
+ * Unfortunately branch statements crash the bpftrace compiler.  As a result,
+ * the branch has been moved directly into the probe.  Reverse this if the
+ * compiler ever gets that fixed.
+ */
+macro STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start)
+{
+	$idx = @trace_stack[tid, --@trace_stack_top[tid]];
+	@timer_duration[tid, $idx] = usecs - @timer_start[tid, $idx];
+}
+
+BEGIN
+{
+	INIT_MAPS(@trace_stack_top, @timer_count);
+}
+
+/*
+ * Time 'vfio_group_fops_unl_ioctl()'.
+ *
+ * VFIO_GROUP_GET_DEVICE_FD = 0x3b6a
+ *
+ * Check: sudo grep vfio_group_fops_unl_ioctl /proc/kallsyms
+ */
+kfunc:vfio_group_fops_unl_ioctl /args->cmd == 0x3b6a/
+{
+	START_TIMER("vfio_group_ioctl_get_device_fd",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_group_fops_unl_ioctl /args->cmd == 0x3b6a/
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vfio_df_ioctl_bind_iommufd()'.
+ *
+ * Check: sudo grep vfio_df_ioctl_bind_iommufd /proc/kallsyms
+ */
+kfunc:vfio_df_ioctl_bind_iommufd
+{
+	START_TIMER("vfio_df_ioctl_bind_iommufd",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_df_ioctl_bind_iommufd
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vfio_df_unbind_iommufd()'.
+ *
+ * Check: sudo grep vfio_df_unbind_iommufd /proc/kallsyms
+ */
+kfunc:vfio_df_unbind_iommufd
+{
+	START_TIMER("vfio_df_unbind_iommufd",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_df_unbind_iommufd
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vfio_df_open()'.
+ *
+ * Check: sudo grep vfio_df_open /proc/kallsyms
+ */
+kfunc:vfio_df_open
+{
+	START_TIMER("vfio_df_open",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_df_open
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'pcie_flr()'.
+ *
+ * Check: sudo grep pcie_flr /proc/kallsyms
+ */
+kfunc:pcie_flr
+{
+	START_TIMER("pcie_flr",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:pcie_flr
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'pci_dev_wait()'.
+ *
+ * Check: sudo grep pci_dev_wait /proc/kallsyms
+ */
+kfunc:pci_dev_wait
+{
+	START_TIMER("pci_dev_wait",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:pci_dev_wait
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vfio_iommu_type1_ioctl()' when 'VFIO_IOMMU_MAP_DMA' is called.
+ *
+ *
+ * VFIO_IOMMU_MAP_DMA = 0x3b71
+ *
+ * Check: sudo grep vfio_iommu_type1_ioctl /proc/kallsyms
+ */
+kfunc:vfio_iommu_type1_ioctl /args->cmd == 0x3b71/
+{
+	START_TIMER("vfio_iommu_type1_map_dma",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_iommu_type1_ioctl /args->cmd == 0x3b71/
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vfio_pin_map_dma()'.
+ *
+ * Check: sudo grep vfio_pin_map_dma /proc/kallsyms
+ */
+kfunc:vfio_pin_map_dma
+{
+	START_TIMER("vfio_pin_map_dma",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_pin_map_dma
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vfio_pin_pages_remote()'.
+ *
+ * Check: sudo grep vfio_pin_pages_remote /proc/kallsyms
+ */
+kfunc:vfio_pin_pages_remote
+{
+	START_TIMER("vfio_pin_pages_remote",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_pin_pages_remote
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vaddr_get_pfns()'.
+ *
+ * Check: sudo grep vaddr_get_pfns /proc/kallsyms
+ */
+kfunc:vaddr_get_pfns
+{
+	START_TIMER("vaddr_get_pfns",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vaddr_get_pfns
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+// /*
+//  * Time 'iommu_map()'.
+//  *
+//  * Check: sudo grep iommu_map /proc/kallsyms
+//  */
+// kfunc:iommu_map
+// {
+// 	START_TIMER("iommu_map",
+// 		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+// 		    @timer_depth, @timer_count, @trace_stack_top);
+// }
+// kretfunc:iommu_map
+// {
+// 	if (@trace_stack_top[tid] > 0) {
+// 		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+// 	}
+// }
+
+
+
+/*
+ * Time 'vfio_iommu_type1_ioctl()' when 'VFIO_IOMMU_UNMAP_DMA' is called.
+ *
+ * VFIO_IOMMU_UNMAP_DMA = 0x3b72
+ *
+ * Check: sudo grep vfio_iommu_type1_ioctl /proc/kallsyms
+ */
+kfunc:vfio_iommu_type1_ioctl /args->cmd == 0x3b72/
+{
+	START_TIMER("vfio_iommu_type1_unmap_dma",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_iommu_type1_ioctl /args->cmd == 0x3b72/
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vfio_unmap_unpin()'.
+ *
+ * Check: sudo grep vfio_unmap_unpin /proc/kallsyms
+ */
+kfunc:vfio_unmap_unpin
+{
+	START_TIMER("vfio_unmap_unpin",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_unmap_unpin
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Time 'vfio_sync_unpin()'.
+ *
+ * Check: sudo grep vfio_sync_unpin /proc/kallsyms
+ */
+kfunc:vfio_sync_unpin
+{
+	START_TIMER("vfio_sync_unpin",
+		    @timer_name, @trace_stack, @timer_start, @timer_duration,
+		    @timer_depth, @timer_count, @trace_stack_top);
+}
+kretfunc:vfio_sync_unpin
+{
+	if (@trace_stack_top[tid] > 0) {
+		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_start);
+	}
+}
+
+/*
+ * Dump the results to stdout.
+ */
+END
+{
+	CLEAR_MAPS(@trace_stack, @trace_stack_top, @timer_count);
+}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

