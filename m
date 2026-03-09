Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933F36AB7C
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086118; cv=none; b=O1arOqioq4nAomP5yVtitgMp0BVwXpWr41Jp1U/kDEU/GplD5mZxs3zSaB4Mk9HwkQNLUPWWjlrCEur0Wi1zDUl+YwJZfnv+YrAb/GfPvcEtMsTh/C9ylpsu25lBz5jQkfgREIT2rznyxZldNs3TnyG+5BMDxsDtxx2En+296yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086118; c=relaxed/simple;
	bh=EJdVD1L6g203nYafJu+0ydmi7h/+sZQ+w2DkUuJU8NM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nJGsfMHgts50d4LhyvWYqPmy20CQ/BwkGnT1KkqA9KVMPXyP5qQ0yLkAy9TzTQi81Z+Pmae0gSOf4GgCgP1EuRPvDB1KrKbUFudW6jIuI+R5ILv3oeRyNcKCr89u/ZLeiubO5UpCcAoFwRslOx7iov+6mFX7vrLGaKso7uUrfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKw3+2Us; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKw3+2Us"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a04vp0f5nYbiJJbrU1fnZhtMYiLV2Gp1bYe9yuSAagQ=;
	b=RKw3+2UsFBSP7v66HZyUHD5MHkPP+rfH/bHnVb3iO4wWMWVpllAzJ+juR+ihr+gIBXRt7n
	jy16EMdnQUHsMIP+OECkGjMdZREK22Qveb7oN7tEESVnQ4n1Y35YHUHxawb9I4dywF3dHm
	0J78RJE0JzC2KA8TQBVgvD331ESm9EA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-AuWqQx-pM12eQaf3Wi0aIg-1; Mon,
 09 Mar 2026 15:55:12 -0400
X-MC-Unique: AuWqQx-pM12eQaf3Wi0aIg-1
X-Mimecast-MFC-AGG-ID: AuWqQx-pM12eQaf3Wi0aIg_1773086111
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3DEF1800616;
	Mon,  9 Mar 2026 19:55:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8764430001A2;
	Mon,  9 Mar 2026 19:55:05 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 00/18] rtla: Robustness and code quality improvements
Date: Mon,  9 Mar 2026 16:46:13 -0300
Message-ID: <20260309195040.1019085-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series addresses multiple issues in the rtla codebase related to
error handling, string manipulation safety, and code maintainability.
The changes improve the tool's reliability and bring the code more in
line with kernel coding practices.

The series can be broadly divided into three categories:

Bug fixes address several correctness issues: a resource leak where
opendir() was not paired with closedir() on success paths, I/O loops
that failed to handle EINTR and partial writes correctly, a missing
bounds check when indexing the softirq_name array with kernel-provided
data, improper handling of pthread_create() failures, and a loop
condition that checked a pointer instead of the character it points to.

String handling improvements replace unsafe patterns throughout the
codebase. The strncpy() function is replaced with a new strscpy()
implementation that guarantees NUL-termination and provides truncation
detection. A str_has_prefix() helper replaces verbose strncmp/strlen
patterns for prefix matching. String comparisons are tightened to use
exact matching where appropriate, preventing silent acceptance of
malformed input like "100nsx" being parsed as "100ns".

Code quality improvements reduce duplication and improve readability.
A common_threshold_handler() consolidates repeated threshold action
logic. The extract_arg() macro simplifies key=value parsing. Magic
numbers are replaced with named constants (MAX_PATH, ARRAY_SIZE), and
redundant strlen() calls are cached in local variables.

All changes have been tested with the existing rtla test suite.

v4:
- Patch 3: Rename commit title from "rtla: Simplify argument parsing"
  to "rtla/actions: Simplify argument parsing" to clarify scope. Remove
  spurious whitespace change to container_of macro (Tomas Glozar).
- Patch 12: Fix a regression where strcmp() broke SCHED_DEADLINE
  priority parsing in "d:runtime:period" format (e.g., "d:10ms:100ms").
  Introduce match_time_unit() helper that checks the suffix is followed
  by end-of-string or ':' delimiter. Note that strncmp_static() was
  also considered but would fail because ARRAY_SIZE() includes the NUL
  terminator (Tomas Glozar).
- Patch 15: Add Fixes tag for stable backport tracking (Tomas Glozar).

v3:
- Address v2 feedback:
  - Rename common_restart() to common_threshold_handler() to better
    reflect its purpose (Tomas Glozar).
  - Implement a proper strscpy() for safer string handling instead of
    manual buffer sizing (Steven Rostedt).
  - Remove restart_result enum in favor of simpler, direct return
    values (Tomas Glozar).
- Add several new bug fixes, including a softirq vector bounds check,
  pthread_create() failure handling, robust I/O handling for
  EINTR/partial writes, and a resource leak fix.
- Introduce str_has_prefix() helper to replace verbose strncmp/strlen
  patterns.
- Tighten string parsing to enforce exact matching and reject invalid
  suffixes (e.g., "100nsx").
- Drop patches already merged via RTLA v6.20 pull request.

v2:
- exit on memory allocation failure
- remove redundant strlen() calls
- fix possible race on condition on stop_tracing variable access
- ensure null termination on read() calls
- fix checkpatch reports
- make extract_args() an inline function
- add the usage of common_restart() in more places

Wander Lairson Costa (18):
  rtla: Exit on memory allocation failures during initialization
  rtla: Use strdup() to simplify code
  rtla/actions: Simplify argument parsing
  rtla: Introduce common_threshold_handler() helper
  rtla: Replace magic number with MAX_PATH
  rtla: Simplify code by caching string lengths
  rtla: Add strscpy() and replace strncpy() calls
  rtla/timerlat: Add bounds check for softirq vector
  rtla: Handle pthread_create() failure properly
  rtla: Add str_has_prefix() helper function
  rtla: Use str_has_prefix() for prefix checks
  rtla: Enforce exact match for time unit suffixes
  rtla: Use str_has_prefix() for option prefix check
  rtla/timerlat: Simplify RTLA_NO_BPF environment variable check
  rtla/trace: Fix write loop in trace_event_save_hist()
  rtla/trace: Fix I/O handling in save_trace_to_file()
  rtla/utils: Fix resource leak in set_comm_sched_attr()
  rtla/utils: Fix loop condition in PID validation

 tools/tracing/rtla/src/actions.c       | 103 ++++++++++++---------
 tools/tracing/rtla/src/actions.h       |   8 +-
 tools/tracing/rtla/src/common.c        |  65 ++++++++++----
 tools/tracing/rtla/src/common.h        |  18 ++++
 tools/tracing/rtla/src/osnoise.c       |  26 ++----
 tools/tracing/rtla/src/osnoise_hist.c  |  22 ++---
 tools/tracing/rtla/src/osnoise_top.c   |  22 ++---
 tools/tracing/rtla/src/timerlat.c      |   5 +-
 tools/tracing/rtla/src/timerlat_aa.c   |  10 +--
 tools/tracing/rtla/src/timerlat_hist.c |  41 ++++-----
 tools/tracing/rtla/src/timerlat_top.c  |  54 +++++------
 tools/tracing/rtla/src/timerlat_u.c    |   4 +-
 tools/tracing/rtla/src/trace.c         | 102 +++++++++++----------
 tools/tracing/rtla/src/trace.h         |   4 +-
 tools/tracing/rtla/src/utils.c         | 119 +++++++++++++++++++++----
 tools/tracing/rtla/src/utils.h         |  29 +++++-
 16 files changed, 388 insertions(+), 244 deletions(-)

-- 
2.53.0

