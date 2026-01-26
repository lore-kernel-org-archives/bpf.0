Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C523F42D;
	Mon, 26 Jan 2026 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769469173; cv=none; b=pzb8Pim46Q/pPBo5MSzQ3Vimz/MRvnuEKpisAqqCvIRevLO1W7hcTlOCgunMVxdOsG3CdKym+h/9KU1PuumuWLxc1k/e/F+lP5IvTkLjwHTZtON2F/p0kHF8VKG65dQGhOuvUgge+eKnD64TImod36dVsqc34gE0g2MSX5O7VQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769469173; c=relaxed/simple;
	bh=mQXwCuGIROQD6rXZM8amVwlvI+IZR5slrw7/8WPVRw8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=GPJz4DMelW/IhotqPyk6oClKDiwc1YrrtZRAKZ4cyifwt2QAg8zJJtKVRyXrZYeAVBfB9KLODTYRAN/Q2vpmKGvmu3TBIyrTx3mFW0m7oOhVukHeL0jwCmkxeRpPoNC2JvLkl3K6G/i2CfI+nzqVlKdJOMSsnsr2x1DBA+9Sjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8pisTiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8pisTiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C0DC116C6;
	Mon, 26 Jan 2026 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769469172;
	bh=mQXwCuGIROQD6rXZM8amVwlvI+IZR5slrw7/8WPVRw8=;
	h=Date:From:To:Cc:Subject:From;
	b=l8pisTiO7IyqKjWkwLCkKRAdADpf0uz94ZIgfwQUMiE0ZNO4j9NA+8aOW4Prc4nR9
	 NhFpoizNBYthaLfF3nAZjQJo6RTj72JBkcV+GqtlJTuFptEgoUi56j0wLV3NSU361e
	 jo9jb28oLUJxaB9fZN1ocn97bgG4KStKDN6XFKqrGzYO5tPOZNAr+3W9SUM7aYZUGt
	 N7XQjtw49vP1DX4ISv7w7KcI2NS42sEchDPyq1rJ/ALim5MCycbzIStrQB8p5WhEpO
	 DTipuh+kaIHBnHuF38fM8MNdTCZDUJOBSCKKl3ExyMFRilSnbOsrpp+Oac41pbJBOc
	 xRFtbhe1cHe0A==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vkVlQ-00000000Bzm-0cZK;
	Mon, 26 Jan 2026 18:12:56 -0500
Message-ID: <20260126231145.728172709@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 26 Jan 2026 18:11:45 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 0/3] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
to protect invocation of __DO_TRACE_CALL() means that BPF programs
attached to tracepoints are non-preemptible.  This is unhelpful in
real-time systems, whose users apparently wish to use BPF while also
achieving low latencies.

Change the protection of tracepoints to use fast_srcu() instead.
This will allow the callbacks to be able to be preempted. This also
means that the callbacks themselves need to be able to handle this
new found preemption ability.

For perf, add a guard(preempt) inside its handler too keep the old behavior
of perf events being called with preemption disabled.

For BPF, add a migrate_disable() to its handler. Actually, just replace
the rcu_read_lock() with rcu_read_lock_dont_migrate() and make it
cover more of the BPF callback handler.

[ I would have sent this out earlier, but had a death in the family
  which cause everything to be postponed ]

Changes since v5: https://patch.msgid.link/20260108220550.2f6638f3@fedora

- Add separate patch for perf to call preempt_disable()

- Add patch that has bpf call migrate_disable() directly.

- Just change from preempt_disable() to srcu_fast() always
  Do not do anything different for PREEMPT_RT.
  Now that BPF disables migration directly, do not have tracepoints
  disable migration in its code.

Steven Rostedt (3):
      tracing: perf: Have perf tracepoint callbacks always disable preemption
      bpf: Have __bpf_trace_run() use rcu_read_lock_dont_migrate()
      tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast

----
 include/linux/tracepoint.h   |  9 +++++----
 include/trace/perf.h         |  4 ++--
 include/trace/trace_events.h |  4 ++--
 kernel/trace/bpf_trace.c     |  5 ++---
 kernel/tracepoint.c          | 18 ++++++++++++++----
 5 files changed, 25 insertions(+), 15 deletions(-)
