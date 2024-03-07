Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A93309C
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854036; cv=none; b=Tyvrfu4gHKzMo9S3wK5igL9pjDo2/aCOxsmL7o/qy1vh+OuorLqpP8oIIvWMT8tx2WsI/SOqmmyaRiurq/WS1eYEoyy12Af2eYIg1SbbE36ziz1wfH/o0qWlX0eLSIZRhPeEPgTC18GrNYVI3dVq+xLc2RlaM0xtZzcub7WjQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854036; c=relaxed/simple;
	bh=TFexT1JF1Faw/hJCvZHF+lnZJinRZ50jyIcy+IsB6Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5Xje8l4cCwwSW4XqV7i785+Yff7AL4KM6bK+hyaIOpSCmwcK9ZQs+7zFoCs7KVDjfmqK6fRiszhojyaQsrErUBbFWjKf/HH8qC2yQ4/KVhFmvmJRV7/Z0/ZFSy8ofjXU+3cP8ZmRaZ/f8bGOgwD7bSPLhnKxgRZ0UPAWcVyWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B939B164A15E; Thu,  7 Mar 2024 15:26:59 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next 0/5] bpf: Allow helper bpf_get_ns_current_pid_tgid() in cgroup/sk_msg programs
Date: Thu,  7 Mar 2024 15:26:58 -0800
Message-ID: <20240307232659.1115872-1-yonghong.song@linux.dev>
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
is sk_msg and this patch set added it as well.

Patch 1 added the kernel support and patches 2-5 added
the test for cgroup and sk_msg.

Yonghong Song (5):
  bpf: Allow helper bpf_get_ns_current_pid_tgid() in cgroup and sk_msg
    programs
  selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test
  selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
  selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
  selftests/bpf: Add a sk_msg prog bpf_get_ns_current_pid_tgid() test

 kernel/bpf/cgroup.c                           |   2 +
 net/core/filter.c                             |   2 +
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 195 +++++++++++++++---
 .../bpf/progs/test_ns_current_pid_tgid.c      |  31 ++-
 4 files changed, 196 insertions(+), 34 deletions(-)

--=20
2.43.0

