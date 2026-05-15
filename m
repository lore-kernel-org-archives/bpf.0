Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41161DED5C
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885452; cv=none; b=WgGDWuCRfYBy5MjhNgV2AnDo3U3CStm8RTXQDDe7IWe2jAeWt83op8WPPrx4cfKe9wqPPhXZbYvOAOnqkFmNo7dMWofYpSFXj/8VGboCvwWqiYet2g8jg/z1ihPmKncnrLUWeGNrVOzbandw17URBTd+DIpfyIHo5BdXcaHvbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885452; c=relaxed/simple;
	bh=iOEUGqvCwNVqBFdUQN0+U8Eo12XX5ktfKOiqpib0yOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H36KfMtH676yi9nFeizqtXvMY6WVvaGMQGRG8ZZgUROy3v0XlD2P/meNwQeTYZ4iR6GDkUEJwlMX7NZTbu+I9euAkvaUFglxC9BcHaBa/FapO6GN6zh0ZQrHkgnbCFKRKho/zZcEk/cacOc47aZ09NhPd3NVVHlk+Q8BRDTAM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AE74FC060B423; Fri, 15 May 2026 15:50:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/7] bpf: Follow-up fixes for stack argument support
Date: Fri, 15 May 2026 15:50:35 -0700
Message-ID: <20260515225035.821178-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit cd59fa185a03 ("bpf: Support stack arguments for BPF functions and =
kfuncs")
added stack argument support for bpf functions and kfuncs. This patch set
is to fix various issues related to stack arguments, mainly include:
  - Validate outgoing stack args when btf_prepare_func_args fails
  - Fix arg_track_join log to use sa prefix for stack arg slots
  - Clean up redundant stack arg checks for non-JITed programs
  - Fix exception unwinding with outgoing stack arguments

Changelog:
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260515014958.1186132-1-yonghong.s=
ong@linux.dev/
    - Add additional fix (fix arg_track_join log, fix exception with outg=
oing stack
      arguments, some cleanup, etc.).
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260514184827.1619863-1-yonghong.s=
ong@linux.dev/
    - Remove 'Reported-by: Sashiko <sashiko-bot@kernel.org>'.
    - Add proper fix tag.

Yonghong Song (7):
  bpf: Validate outgoing stack args when btf_prepare_func_args fails
  selftests/bpf: Add test for stack arg read without caller write
  selftests/bpf: Log arg_track_join for stack arg slots in liveness
    analysis
  bpf: Fix arg_track_join log to use sa prefix for stack arg slots
  bpf: Clean up redundant stack arg checks for non-JITed programs
  bpf,x86: Fix exception unwinding with outgoing stack arguments
  selftests/bpf: Add exception tests with stack arguments

 arch/x86/net/bpf_jit_comp.c                   |   9 +-
 include/linux/bpf.h                           |   3 +-
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/fixups.c                           |   3 +-
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/liveness.c                         |   4 +-
 kernel/bpf/verifier.c                         |  10 +-
 .../selftests/bpf/prog_tests/exceptions.c     |   7 ++
 .../bpf/progs/btf__verifier_stack_arg_order.c |   8 ++
 .../testing/selftests/bpf/progs/exceptions.c  | 113 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_stack_arg.c  |   8 +-
 .../bpf/progs/verifier_stack_arg_order.c      |  58 +++++++++
 12 files changed, 216 insertions(+), 11 deletions(-)

--=20
2.53.0-Meta

