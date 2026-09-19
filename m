Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A7379ED4;
	Sat, 19 Sep 2026 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811101; cv=none; b=XGuWzt8XJFHxOWp2YPjd/f61rmDwGKzNcGop8M0D5X/COWVvjL3UwI3Wk5ghGU3+uXudkQRTw5mIJ9VVo1Tjah9Vy0CmAs10iuWDCdRN6jl7Tpmm3aMtZbtK0NImp6XA5VbjnSHptD5+A+REP7YX+x8ddvXkQjGbo0XHDluOgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811101; c=relaxed/simple;
	bh=LBXWLT6zpmOvJBVjpiGlVWsXd1BU+jaESa/VoO4WcBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJe3/c/frWSkNbV83ikwIDj+JNS13tp+oyTFDHV1nLfLn+onpLQrGWetdLWScHKWd4GvcfaJgdNZICz6a95g0jn7TDONaGM30KcX9V8DjDeDwVXltf9BNU3uC+PpCrX0GA4tjVtcggr3EZJTS84/4qzmPagbRv+NIT4yVopWZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=grl20je9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="grl20je9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+K
	xGjC8dWEgeGk9sMimmqqU0ygs8py1rnPREC6LRd/o=; b=grl20je9Ce4VU2pk27
	yToVB/Gy8a8f2j2x65LZKOHzvjo07lqQN6cfM9rQso9osoOAoYpUHeg6nqY/SEE0
	bt/c3UxBp5SieZCQ7DkoRA7hYcObpvpHkqvWwltXa7IKZqym4xcVq9f1VMW4khtG
	w+9Lqt+0kikqS92P3IGfFJjEQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3_p9gWa5q3POmBQ--.726S2;
	Sat, 19 Sep 2026 17:44:01 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf-next v2 0/3] bpf: expose cgroup preorder attachment state to userspace
Date: Sat, 19 Sep 2026 18:43:57 +0900
Message-ID: <20260919094400.600585-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3_p9gWa5q3POmBQ--.726S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryDuw1rWw4xZF4DJw1rtFb_yoW5Gr4UpF
	WkurZxWw18Xw13AF1xA3y09rZYkFs3XF4UCFy3t34UXF4xXry0yrWSkF15Zr43X39xJr17
	Zr9Yvr9xW3WjvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi75r7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/

Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
introduced BPF_F_PREORDER to request top-down (ancestor to descendant)
execution ordering across the cgroup hierarchy. While this flag is stored
in struct bpf_prog_list::flags and affects the effective program ordering,
direct BPF_PROG_QUERY currently reports only the cgroup-wide flags and
omits BPF_F_PREORDER from prog_attach_flags[].

This series extends direct cgroup program queries to expose the per-program
BPF_F_PREORDER state, adds selftests to validate the reported flags, and
updates bpftool to support inspection, attachment, documentation, and bash
completion.

Structure of the series:
- Patch 1 extends __cgroup_bpf_query() so that prog_attach_flags[] includes
  BPF_F_PREORDER for direct queries.
- Patch 2 adds query verification to cgroup_mprog_opts selftests for both
  direct program and bpf_link attachments.
- Patch 3 updates bpftool with bitmask attach flag formatting, preorder
  attachment CLI support, bash completion for valid flag combinations,
  and documentation.

Testing:
- Verified that baseline kernel reports 0x2 for PREORDER multi-attachments
  through BPF_PROG_QUERY.
- Verified that the patched kernel reports 0x42 (BPF_F_ALLOW_MULTI |
  BPF_F_PREORDER).
- Selftests cgroup_mprog_opts (all subtests) and cgroup_preorder pass in an
  x86_64 QEMU/KVM guest.
- bpftool and its documentation build cleanly without warnings or errors.
- Bash completion verified for standalone and composite flag combinations.
- checkpatch.pl reports 0 errors and 0 warnings across all patches.

Changes in v2:
- Rebase onto bpf-next and drop the Fixes tag, as requested by
  Alexei Starovoitov.
- Document the userspace-visible BPF_PROG_QUERY flag extension.
- Factor the duplicated PREORDER query checks and fix comment style.
- Clarify PREORDER ordering and single/multi attachment semantics.
- Fix bash completion for valid PREORDER flag combinations.

Hui Su (3):
  bpf: Report BPF_F_PREORDER in cgroup program queries
  selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
  bpftool: Add support for BPF_F_PREORDER cgroup attach flag

 kernel/bpf/cgroup.c                           | 16 ++---
 .../bpftool/Documentation/bpftool-cgroup.rst  | 25 ++++---
 tools/bpf/bpftool/bash-completion/bpftool     |  4 +-
 tools/bpf/bpftool/cgroup.c                    | 55 +++++++++-----
 .../bpf/prog_tests/cgroup_mprog_opts.c        | 72 ++++++++++++++++++-
 5 files changed, 134 insertions(+), 38 deletions(-)

-- 
2.55.0

