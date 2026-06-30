Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884654279F6;
	Tue, 30 Jun 2026 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829406; cv=none; b=eH5E8uYMy/D5uMn4EZiFcTzdsOJ5UeVFfTqvrCDM/UYC/lJ/0T/Dpc5iwT/0QiKtjGyf6GExG+XEfg3/UouU6gKqepMs4O9yp+iVULkn0mJiKIQ8JlOs0AE9/e39j8i02+0UAvR0Kisy/cjO6rbrKN2kd5AOl+KfVM7RyxQ/tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829406; c=relaxed/simple;
	bh=4Mdk6PeJVz2qKvGO8sh40YuDeFqEaJZUp90ErRdeae4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YknTcq6S+P5/aP7NkRN76R/Bj6Bj8ZEGXp35h45XEypDi+cru5evaWhODPD3BUj64vrc/XlG4ZrY7gHsvDovw5dTIr6mKwN81hmbNQxM9+kvnWd6Ryy7vH+PgakwcTMip8J+cRAKxUkY8ug25ZxFuN1zN3nU1r0f//WUBV5YsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVINqA4+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVINqA4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDC11F000E9;
	Tue, 30 Jun 2026 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829405;
	bh=fUSz7eEHYpvlOzsm+PvIOL5UMpwSX4asWnIG8SXRQ9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AVINqA4+0mKW2mbjg4vu8fM695FCCJx6R/nwzY2PZ9fiJJhPzAVXWL6lf61XNUJX/
	 YJgPmk14Czg6d1p3zQ6jRrrqJiVjg6hCw20WvCNSVB2/3Dg9hyUFMK01SFn0i6YZRA
	 ke5H+Ol0omhT/06YZVLMeNP6fYuOXzNwNNlxEV118f0F4Tr2ws4GZeVIEezcbOhCz8
	 DTr5q5lTordecxRlTR2Dbk80KcMsX0bQKQlehHmdhtqGOoOAMc3So3Md5K+aaIi383
	 9ps14BNr62/RAx+azFG7eu+B8stugu9/fNb0XdtiwTXekuzayIMYXk3s6e8QJcq7CS
	 q5oaNrL6Oi12Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] tools/bpftrace: Add a simple instrumented kernel
 profiler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: bpf@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260630141152.3757722-2-aaronlewis@google.com>
References: <20260630141152.3757722-1-aaronlewis@google.com>
 <20260630141152.3757722-2-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:23:24 +0000
Message-Id: <20260630142325.0FDC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] Incomplete timers (DURATION_UNSET) are blindly aggregated, corru=
pting profile metrics.
- [Medium] The `kvm_mmu_page_fault` probe incorrectly names its timer `kvm_=
vcpu_block`.
- [Medium] Two-pass parsing architecture breaks when reading from standard =
input, causing an AttributeError.
- [Medium] Fragile parsing logic crashes the script if any BPF trace map ev=
ents are dropped.
- [Low] File validation checks evaluate against closed file descriptors, re=
ndering them dead code.
--

commit 991cf3dc11faba4afe46fa2281e4850e5407d45b
Author: Aaron Lewis <aaronlewis@google.com>

tools/bpftrace: Add a simple instrumented kernel profiler

This commit introduces a simple instrumented profiler for the kernel using
BpfTrace. It allows arbitrary tracing of kernel functions and tracepoints,
and includes a Python script to aggregate and display the results in a
hierarchical view with timing data.

> diff --git a/tools/bpftrace/instrumented_profiler/aggregate_bpf_results.p=
y b/tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py
> new file mode 100644
> index 0000000000000..f4ffe8cff4418
> --- /dev/null
> +++ b/tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py

[ ... ]

> +def update_child(r: BpfResult, timer: BpfTimer, tid: int) -> int:
> +  i =3D r.child_index.get(timer.name)
> +  if i is None:
> +    i =3D len(r.children)
> +    r.children.append(BpfResult(
> +        timer.name,
> +        timer.start_time_us,
> +        timer.start_time_us + timer.duration_us,
> +        timer.duration_us,
> +        timer.duration_us,
> +        timer.duration_us,
> +        1,
> +        1,
> +        timer.depth,
> +        tid))
> +    r.child_index[timer.name] =3D i
> +  else:
> +    r.children[i].wall_time_start_us =3D min(r.children[i].wall_time_sta=
rt_us, timer.start_time_us)
> +    r.children[i].wall_time_end_us =3D max(r.children[i].wall_time_end_u=
s, timer.start_time_us + timer.duration_us)
> +    r.children[i].thread_us +=3D timer.duration_us
> +    r.children[i].max_us =3D max(r.children[i].max_us, timer.duration_us)

[Severity: Medium]
When a traced function does not complete before tracing ends (for example, =
if
interrupted via Ctrl-C), the duration remains at its initialization value of
DURATION_UNSET (-1 cast to uint64).

Are we blindly aggregating incomplete timers here?

Adding this massive sentinel value directly to thread_us and max_us will
severely corrupt the aggregated timing metrics.

[ ... ]

> +def merge_recursive(r: BpfResult, tid: int, timers: List[BpfTimer], inde=
x: int, child_index: int) -> int:
> +  while index < len(timers):
> +    while index < len(timers) and timers[index] =3D=3D None:
> +      index +=3D 1
> +
> +    if index >=3D len(timers):
> +      return index
> +
> +    # The timer is a child of 'r'. (Child case)
> +    if timers[index].depth =3D=3D (r.depth + 1):
> +      # Add child
> +      child_index =3D update_child(r, timers[index], tid)
> +
> +      # Now that the timer has been handled increment to the next one.
> +      index +=3D 1
> +
> +    # The timer is a child of 'r'. (Grandchild case)
> +    elif timers[index].depth =3D=3D (r.depth + 2):
> +      if child_index < 0:
> +        raise ValueError("Invalid 'child_index'")
> +      # Recurse down the child becuase that is the parent this timer.
> +      index =3D merge_recursive(r.children[child_index], tid, timers, in=
dex, child_index)
> +
> +    # The timer is a descendant of 'r', but not the child... Invalid cas=
e!
> +    elif timers[index].depth > (r.depth + 2):
> +      raise ValueError("Invalid depth.  descendant can only be children.=
 name =3D '%s', tid =3D %d, index =3D %d" % (timers[index].name, tid, index=
))

[Severity: Medium]
Will this script crash with a ValueError or IndexError if bpftrace drops any
map events due to ring buffer overflow or map eviction under heavy load?

The parsing logic appears to assume a flawless 1:1 correlation across all
dumped maps. If events are dropped, it might create a gap in the call depth
triggering this strict ValueError, or result in an IndexError during array
assignment in generate_from_log() when index expectations are broken.

[ ... ]

> +def generate_from_log(files: Sequence[str]):
> +  """Read the trace and return a list of ProfilerResult objects."""
> +
> +  timer_counts =3D {}
> +  all_timers =3D {}
> +
> +  count_regex =3D re.compile(
> +      r"^@timer_count\[(?P<tid>[0-9]+)\]:\W(?P<count>[-0-9]+)"
> +  )
> +  name_regex =3D re.compile(
> +      r"^@timer_name\[(?P<tid>[0-9]+),\W*(?P<index>[0-9]+)\]:\W(?P<name>=
[\w\.0-9]+)"
> +  )
> +  start_time_regex =3D re.compile(
> +      r"^@timer_start\[(?P<tid>[0-9]+),\W*(?P<index>[0-9]+)\]:\W(?P<star=
t_time_us>[-0-9]+)"
> +  )
> +  duration_regex =3D re.compile(
> +      r"^@timer_duration\[(?P<tid>[0-9]+),\W*(?P<index>[0-9]+)\]:\W(?P<d=
uration_us>[-0-9]+)"
> +  )
> +  depth_regex =3D re.compile(
> +      r"^@timer_depth\[(?P<tid>[0-9]+),\W*(?P<index>[0-9]+)\]:\W(?P<dept=
h>[-0-9]+)"
> +  )
> +
> +  attaching_regex =3D re.compile(
> +      r"^Attaching.*"
> +  )
> +
> +  # Get all counts.  That way we know how many timers each thread used.
> +  for line in fileinput.input(files=3Dfiles):

[Severity: Medium]
Could this two-pass parsing architecture break when reading trace data dire=
ctly
from standard input?

If a user pipes bpftrace output into this script, this first loop will cons=
ume
the entire stream until EOF.

The second fileinput.input() loop below will then read nothing, leaving the
timer arrays filled with None values. This leads to an AttributeError in
merge_timers() when attempting to read timers[0].depth.

> +    line =3D line.rstrip()
> +
> +    m =3D re.fullmatch(duration_regex, line)
> +    if m:
> +      tid =3D int(m.group("tid"))
> +      index =3D int(m.group("index"))
> +      duration_str =3D m.group("duration_us")
> +      duration =3D int(m.group("duration_us"))
> +
> +      if not tid in timer_counts:
> +        timer_counts[tid] =3D index
> +      else:
> +        timer_counts[tid] =3D max(timer_counts[tid], index)
> +
> +  # Allocate enough timers to fit the trace.
> +  for tid, count in timer_counts.items():
> +    all_timers[tid] =3D [None] * (count + 1)
> +
> +  # Populate the trace.
> +  for line in fileinput.input(files=3Dfiles):

[ ... ]

> +  root =3D BpfResult("", 0, 0, 0, 0, 0, 1, 1, -1, -1)
> +  results =3D []
> +  for tid, timers in all_timers.items():
> +    merge_timers(root, tid, timers)
> +  print_results(root, results)
> +
> +  if fileinput.fileno() =3D=3D 0:
> +    raise ValueError("Expected a file to read.")

[Severity: Low]
Does this file validation check evaluate against closed file descriptors?

The fileinput loops have already exhausted and closed the files by this poi=
nt.
Calling fileinput.fileno() returns the active UNIX file descriptor, which is
-1 when closed, not the count of parsed files.

Both this check and the one below will always evaluate to false, rendering
this block dead code.

> +
> +  if fileinput.fileno() > 1:
> +    raise ValueError("Too many files read.  Expected 1")
> +
> +def main() -> None:

[ ... ]

> diff --git a/tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt b/=
tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt
> new file mode 100644
> index 0000000000000..bd341e408570e
> --- /dev/null
> +++ b/tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt

[ ... ]

> +/*
> + * Time 'kvm_mmu_page_fault()'.
> + *
> + * Check: sudo grep kvm_mmu_page_fault /proc/kallsyms
> + */
> +kfunc:kvm_mmu_page_fault
> +{
> +	START_TIMER("kvm_vcpu_block",
> +		    @timer_name, @trace_stack, @timer_start, @timer_duration,
> +		    @timer_depth, @timer_count, @trace_stack_top);
> +}

[Severity: Medium]
Is there a copy-paste error here where the timer for kvm_mmu_page_fault is
incorrectly named kvm_vcpu_block?

This will falsely attribute page fault durations to kvm_vcpu_block, distort=
ing
the captured metrics for the profile.

> +kretfunc:kvm_mmu_page_fault
> +{
> +	if (@trace_stack_top[tid] > 0) {
> +		STOP_TIMER(@trace_stack_top, @trace_stack, @timer_duration, @timer_sta=
rt);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630141152.3757=
722-2-aaronlewis@google.com?part=3D1
