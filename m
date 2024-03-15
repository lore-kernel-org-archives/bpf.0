Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C591F94B
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529165; cv=none; b=YJVP9iBvvpqEkbysNnBKgv/2sq2UFh4wxOW12aXe/PZr3TtbDiVDiIIYfrI9t3e/DlF3Prqli/dhzKwsNFG94Ih8pphNo8oMC8Wop8sjgvDrgDot/yCp/Ef78k/dztx4BnWToKUadvldKYv3iGY4aLQP4/vUisbWqcFgq6WJnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529165; c=relaxed/simple;
	bh=Hl/0/Lrwvue/oAS6NiXKTYxWUSO07EdwNo8HvrI9494=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0wnFJTfFlpEfCZwq6QyRBq0p5/51W4JJLpVfkhmRVm8AdR1Mr7AlojSdJcLueBYPts3zEkYvQE7kT+j/gq/ggQq0edEEsRL9TylqWWiJ3KIOvpA4WPIaMy58T8n05TdHGA36T2zY3ThLpolt73uJUrjo/USEu+1a/fmUw8/iCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9C5511D1E576; Fri, 15 Mar 2024 11:48:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next v2 0/5] bpf: Allow helper bpf_get_[ns_]current_pid_tgid() for all prog types
Date: Fri, 15 Mar 2024 11:48:49 -0700
Message-ID: <20240315184849.2974556-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
in tracing progs.

We have an internal use case where for an application running
in a container (with pid namespace), user wants to get
the pid associated with the pid namespace in a cgroup bpf
program. Besides cgroup, the only prog type, supporting
bpf_get_current_pid_tgid() but not bpf_get_ns_current_pid_tgid(),
is sk_msg.

But actually both bpf_get_current_pid_tgid() and
bpf_get_ns_current_pid_tgid() helpers do not reveal kernel internal
data and there is no reason that they cannot be used in other
program types. This patch just did this and enabled these
two helpers for all program types.

Patch 1 added the kernel support and patches 2-5 added
the test for cgroup and sk_msg.

Change logs:
  v1 -> v2:
    - allow bpf_get_[ns_]current_pid_tgid() for all prog types.
    - for network related selftests, using netns.

Yonghong Song (5):
  bpf: Allow helper bpf_get_[ns_]current_pid_tgid() for all prog types
  selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test
  selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
  selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
  selftests/bpf: Add a sk_msg prog bpf_get_ns_current_pid_tgid() test

 kernel/bpf/cgroup.c                           |   2 -
 kernel/bpf/helpers.c                          |   4 +
 kernel/trace/bpf_trace.c                      |   4 -
 net/core/filter.c                             |   2 -
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 214 +++++++++++++++---
 .../bpf/progs/test_ns_current_pid_tgid.c      |  31 ++-
 6 files changed, 215 insertions(+), 42 deletions(-)

--=20
2.43.0

