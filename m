Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127751AFEA;
	Fri, 18 Sep 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752297; cv=none; b=rWomO53zBghXHCXgm8KbTHiwlQU8RijDGP7tY17H3FgAxs64ZgwnksCPIfPROS3w6ljtTKyPWdGh5jEpaO0UB4cQOw1KpxIKO2WXlhsxEG1kzXYeJIOJ860Dg7+9b6e0igTW2wf6xzzhwJO3vMqY9cUFjqaNgpNRgidI6KkSZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752297; c=relaxed/simple;
	bh=ewm89oLwdgqoff9BKgJbHCnB264ne4OCj7LKEJTGXow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QN5KtRSOF77AnHpEyTKh16jIpK3Bgt4F2hrrvFVWSEXLgI44oiHHtpLQUx06e/L2BVrQKqLJOul/8kIcjI/Fi7fpoGZiDTPdmjvGoj63iVS4cHSPJRrenlBsqSvbsTriF1e4E3XAOMaeQZs+YLc7xLZoCFlCDySn63pUQuvqwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WFbIdxwr; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WFbIdxwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=go
	hjN9hBMAGWK5ad3+hPjR3cuLDekbzWSmw+EIY8kR4=; b=WFbIdxwrxyV2kcECj4
	npgwskZP4bq38X9XGixzHCBELIC2SV/bstQ47LSIR5MW3MRxzf1TErFmXAbevkEr
	LkBnU8rle4ExctUSL9DE3mrTQQZAtEJlsCmPUW4irZb9snI9Ds8itYlOhj3quRru
	QjIVxKVX+dF3Yw/TCQ3g7Vy4E=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3P5e3c61qq5pkBg--.59142S2;
	Sat, 19 Sep 2026 01:24:08 +0800 (CST)
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
Subject: [PATCH bpf 0/3] bpf: expose cgroup preorder attachment state to userspace
Date: Sat, 19 Sep 2026 02:24:04 +0900
Message-ID: <20260918172407.3459188-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P5e3c61qq5pkBg--.59142S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr17AFyDJFy5Aw48tr17GFg_yoW8Cry3pF
	Z5uFs8Wa4fG343A3say3y0qFWSkFs3Xr4UCF1rtry8Cr4Iqry8trWIkF1rZr1aqFZxtry2
	vwsavr93Gw1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi75r7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hkRcGqtc7md1wAA3V

Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
introduced BPF_F_PREORDER to request pre-order execution across the
cgroup hierarchy. While the kernel records BPF_F_PREORDER in pl->flags,
__cgroup_bpf_query() currently fails to report it to user space in
prog_attach_flags[] during direct cgroup program queries.

This series fixes the kernel query path, extends BPF selftests to
verify the fix, and updates bpftool to recognize and format the
BPF_F_PREORDER flag.

Patch 1 fixes __cgroup_bpf_query() to merge (pl->flags & BPF_F_PREORDER)
with cgroup flags when copying per-program attach flags to user space.

Patch 2 extends selftests/bpf (cgroup_mprog_opts) to verify that direct
and link queries report BPF_F_PREORDER (0x42), matching programs by
prog_id with guarded failure paths.

Patch 3 adds bpftool support: a bitmask flags formatter for cgroup show,
support for "preorder" in cgroup attach, documentation updates, and bash
completion.

Testing:
- Verified on unpatched kernel: selftest reproduces failure
  (actual 2 != expected 66).
- Verified on patched kernel (bpf/master): both cgroup_mprog_opts and
  cgroup_preorder pass 100% in QEMU guest environment.
- Verified bpftool build, format unit tests, and checkpatch
  (0 errors, 0 warnings).

Hui Su (3):
  bpf: Report BPF_F_PREORDER in cgroup program queries
  selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
  bpftool: Add support for BPF_F_PREORDER cgroup attach flag

 kernel/bpf/cgroup.c                           | 16 ++--
 .../bpftool/Documentation/bpftool-cgroup.rst  |  9 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/cgroup.c                    | 55 +++++++----
 .../bpf/prog_tests/cgroup_mprog_opts.c        | 94 ++++++++++++++++++-
 5 files changed, 144 insertions(+), 32 deletions(-)

-- 
2.55.0

