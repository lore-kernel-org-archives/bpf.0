Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09B3B6C1C
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334271; cv=none; b=SA/mSGPb6TjosVh5odLJPAwLNh6K66GhvCk6T4KdNF878dWedgI0a1mJ6fNvxTDpraSP6Hl7O4qsAryM+t4XgIc5rAqnX6KZKbbUuAFGuNtEBIXZHL3TrhXx+E7bNIxWIJULq3vFh+pH7dXHM/js64Svp+hKMFZ/At4E8hGSPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334271; c=relaxed/simple;
	bh=V2AH+acn2Z++GkmXXpOL1qYXkafGx8voxVCueTe4AjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OMCgxFdmRDrXbRJUuN6DZQ9NN+jqLNMAjzK3wP0enW47DSyAdo09qW5DL7W5QIFTpk0Gtzu2ETStYrRSsv5HITmjUX10PvID1HjZ9dQHb6Fh9CJPnPWIBks4p/GilLSno/1iwRzAloJx3Ehaci8fZeg6liR7zWDgP94DWT+UZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNqYSNDO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNqYSNDO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777334266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=HK3fGTvUSK6Pf6uv4CRxer5Mvc4QTCiYiSwv9+Xo7Nw=;
	b=MNqYSNDOTerfl2yHBbZx+VMPp+ShXOiifuwVn+lqfA/DSUrQqVSlqIwqv5TUYPvvsHSctR
	VXohM5a8eXd6MKN386ljv/LXXta5LZjMX+wBqdh+AXNj4xIZiAISIAxPziMRybdC515Vvl
	xh0aw5nQTZyo+7G2Y+Iof5+Libe14mI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Vlastimil
 Babka <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org> , lsf-pc
 <lsf-pc@lists.linux-foundation.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Subject: [LSF/MM/BPF TOPIC] Using BPF in MM
Date: Mon, 27 Apr 2026 23:57:26 +0000
Message-ID: <7ia4o6j4c5y1.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

[LSF/MM/BPF TOPIC] Using BPF in MM
----------------------------------

Over the last decade, BPF successfully penetrated into multiple kernel
subsystems: started as a feature to filter (out) networking packets,
it captured its place in networking, tracing, security, HID drivers,
and scheduling. Memory management is a logical next step, and recently
we saw a growing number of proposals in this area.

In (approximately) historical order:
  - BPF OOM
  - BPF-based memcg stats access (landed)
  - BPF-based NUMA balancing
  - eBPF-mm
  - cache_ext (BPF Page Cache)
  - memcg_ext

There are some obvious target which haven't been covered yet:
  - BPF-driven readahead control
  - BPF-driven KSM
  - BPF-driven guest memory control

Despite a large number of suggestions only a relatively small feature
(query memcg statistics from BPF) made it to upstream.

It looks like using BPF in the MM subsystem comes with a set of somewhat
unique challenges and questions to be answered.


Problem 1. In-Tree/Out-of-Tree BPF Programs
-------------------------------------------
Historically, BPF was created and used to create relatively simple programs
which implemented custom policies, which are arguably mostly user-specific
and have limited value being shared. So keeping them outside of the Linux
source tree was totally reasonable. In the tree we had relatively simple
programs which played a role of examples, tests and documentation. But with
the growing capabilities of BPF, more and more complex BPF programs and
sets of programs are becoming viable. Arguably sched_ext and specific
scheduler implementations are the most complex BPF interfaces now.
Sched_ext developers decided to keep minimalist reference schedulers
in-tree, while production-grade schedulers are developed outside.
There are pros and cons: it allows for much faster iteration but
at the cost of fragmentation risk.

It seems like memory management maintainers (at least Andrew Morton)
are willing to see production-grade BPF programs in the tree. It solves
the fragmentation concern and brings more attention and collaborators,
but somewhat eliminates the strong sides of BPF: speed of iterations
and easy of the customization. And some of the programs are simple too
business-specific to upstream them (e.g. and OOM policy which relies on
cloud orchestrator logic for the victim selection).

So in practice I expect to see both in practice: policy-heavy programs
will live outside the tree, while generic mechanisms (e.g., BPF-driven
memory tiering or cgroup-aware OOM killer) will live within the tree.
Keeping complex bpf programs in tree requires some help from the BPF
community: we need to decide where to keep them, what's the maintenance
policy and potentially ship them with the kernel binary.


Problem 2. Performance in Hot Paths & Cgroup Hierarchy
------------------------------------------------------
BPF was always optimized for speed, and it's really fast. However,
for *some* MM use cases, this might not be enough. Especially if we
simultaneously want to keep it safe (see the next problem). Traffic
control programs which run for every packet need to be very fast,
but at least there is usually no state to manage. If we allow BPF
programs to actually manipulate low-level MM data types in a safe way
(e.g., folio's LRU pointers), it almost inevitably hurts performance.

Also, the lifetime tracking of objects becomes more complex: BPF often
relies on RCU to guarantee memory safety, but it's not trivial and
certainly not free to provide RCU guarantees to, e.g., all folios.
And if we do it using reference counting, it's a performance overhead.

I believe that the solution is to provide safe and performant kfuncs
to operate with low-level data structures, but there is likely a tradeoff
to make between performance, safety guarantees, and flexibility.

For MM programs which operate with memory cgroups, there is a separate
question: how to implement attachment to cgroups? For ordinary BPF programs
there is a complex infrastructure to propagate attached programs to all
cgroups in the sub-tree. For struct_ops'es which are increasingly used to
implement complex BPF mechanisms, there is no such mechanism yet. And
it's not obvious what the best way to implement it: there might be
some state on specific cgroup level, different mechanisms require
different hierarchical behavior, etc. E.g., for BPF OOM, it's perfectly
fine and even desirable to have it attached to some levels and traverse
the hierarchy when it needs to be invoked. But for some programs on very
hot paths, this overhead might not be acceptable.

Finally, MM heavily relies on batching for minimizing the performance
overhead, but it comes with it's own set of tradeoffs. E.g. for large
machines with hundred of CPUs which are  running thousands of cgroups
it's really hard to come up with memcg statistics which is reasonable
accurate but also not slowing everything down. If we add bpf on top of
batching, it's somewhat limited, e.g. a user can't implement a custom
batching mechanism. But most likely we can't do otherwise: the performance
overhead is simple too high.


Problem 3. Safety guarantees and fallback mechanisms
----------------------------------------------------
Safety guarantees were always one of the main, if not the main, selling
points for BPF. Otherwise, why simply not use kernel modules? But what
exactly does the BPF verifier and runtime engine guarantee? For networking,
tracing, and even the scheduler, the answer is the the stability of the
kernel itself (no oopses, UAF, or data corruption).

But the quality of service or usefulness of the system from a user's
perspective is not strictly guaranteed. A malformed BPF program which
drops all the traffic and makes the system unreachable over SSH is
considered acceptable. Sched_ext falls back to CFS if the BPF scheduler
is doing an obviously poor job scheduling tasks, but it takes time and,
of course, it doesn't guarantee performance, so a particularly bad BPF
scheduler can make the system barely useful.

What's the acceptable level of service for MM?

Given how critical MM is to the functioning of the system, it's hard to
guarantee the system stability without sacrificing the flexibility.
The trivial example: if we allow BPF OOM handler to do nothing and let
the system deadlock on memory, is it still acceptable? And if not,
how to implement the safety guarantee? One way is to add a layer of kfuncs
which limit what bpf can achieve and also record what it does. E.g.
bpf programs are allowed to kill processes only using a special helper
and a bpf program has to invoke it at least once. But it's complicated
even for the OOM handling, for hotter paths adding such layer will likely
come with an non-acceptable performance overhead.

Scheduler-like time-based fallback is also not easily applicable:
MM has historically had no notion of time, relying on refault distances,
LRU length, ratio of scanned vs reclaimed pages etc. So time-based
fallback mechanisms will not work well without more systematic changes.

In MM, it's usually not trivial to determine if things are really off
(even without BPF). The kernel historically has trouble deciding when
it's actually time to invoke the OOM killer. The effectiveness of,
for example, a specific readahead implementation or a certain reclaim
policy is not trivial to measure, yet it is even harder to draw
dynamically calculated acceptance criteria which can be calculated
with an acceptable overhead. If things are mildly off, it can be
considered a sub-optimal performance. But if a faulty bpf program
is leading to heavy trashing, how to make sure the system ends up
unloading the bpf program instead of killing all userspace programs?

And to make things worse, BPF itself can't be totally isolated from
relying on MM. BPF maps are backed by slabs and/or vmalloc's. How we can
make sure there are no circular dependencies and associated memory leaks?

--

It seems obvious at this point that there is a huge potential and a lot
of interest in using BPF in MM. Answering questions above seems to be
required to get the initial adoption. But I bet adding more use cases
will go faster and smoother.
