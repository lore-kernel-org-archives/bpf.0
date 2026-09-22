Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AA3AEF45;
	Tue, 22 Sep 2026 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045730; cv=none; b=H/T/LPemZvqpBADdT1FKpyZCNwaHZOiDxP18UNzoPdIYIeyL/zp6NY4FsM5wbEm5bu+Ew23NgGAIGSNHiPmM2hfZ4g5sgfYbfXSpTizOBgv0Kt+XEBKslw/jBXdqyDmDJI3SOXv48dLicOTwZuQI+g5rKr4CnmWDF27EOQ37jtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045730; c=relaxed/simple;
	bh=JrEPSEG+2GMgTccrrptW0dhR3BsGXub2ydxPSWL4s48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjfJ8pBd4S+v5c7Uv445QMdrFJo5dJT+GxtoHTz7IFkt66aZzC6GkQn603+zDZvHeiSMiNsD6iF6bMyQuTui0DIg723YOlt+ReKepd99n+7bCcl93mqoV0QRaQlNMCl5GaWO/HQC32FjQtDVu5LZBDgbphTjGwZVWwj04HfSc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PLcMX0jv; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PLcMX0jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ad
	g7kbz1bBWlYlX55aUt4LHA4s1d7qVYz81vMeI5iy4=; b=PLcMX0jvAHPIBtSDgt
	HAS+QZXXRC4EcPvePpaiDNvVg9lJH+nef3RDpN7wRMGjIKcLGAfxRMDYEIFbthDp
	l7MK6DnnSltvplbvC3ltEdUISqDq6wJlMQV/CBoufuSaU0sGnvMUqISDc8yGF6ie
	sn1EPV7FIo19R8oOshrCVz7Z4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3t9ry7bFqfwUZAA--.3726S2;
	Tue, 22 Sep 2026 10:54:43 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/3] bpf: expose cgroup preorder attachment state to userspace
Date: Tue, 22 Sep 2026 11:54:39 +0900
Message-ID: <20260922025442.3176057-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t9ry7bFqfwUZAA--.3726S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw47CF43Ary5ZF1kGF17Wrg_yoW8CrWxpa
	95WrW3Kw15GF1fArWfK3yIgrZYkan3JF4DGF13t348ZF47Xry0yrZakF4Fvr13XFW7CF47
	Z34Yyr9xWw1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi7GYPUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hS-H2qx7fTSWQAA3X

The BPF_F_PREORDER attach flag changes the ordering of programs in the
effective cgroup program array, but BPF_PROG_QUERY did not report the
per-program flag. This series exposes that state and updates bpftool to
display, accept, and document this flag.

The series is split into three patches:

1. Report BPF_F_PREORDER in direct cgroup program queries.
2. Add selftests for direct and link-based program queries.
3. Add bpftool support for text, JSON, command-line, completion, and
   documentation handling of BPF_F_PREORDER.

Changes in v3:
- Simplify the changelogs for patches 1 and 2.
- Simplify the ATTACH_FLAGS synopsis and represent attach flags as an
  array in JSON output, as suggested by Quentin Monnet.
- Widen the plain-text AttachFlags column for combined flags.
- Address checkpatch line-length and alignment warnings.

Testing:
- PASS: cgroup_mprog_opts, cgroup_preorder, and bpftool cgroup
  plain-text/JSON smoke (x86_64 QEMU/KVM).
- PASS: bpftool build, Documentation build, bash -n, and checkpatch on
  generated v3 patches.

Previous versions:
v2: https://lore.kernel.org/bpf/20260919094400.600585-1-sh_def@163.com/
v1: https://lore.kernel.org/bpf/20260918172407.3459188-1-sh_def@163.com/

Hui Su (3):
  bpf: Report BPF_F_PREORDER in cgroup program queries
  selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
  bpftool: Add support for BPF_F_PREORDER cgroup attach flag

 kernel/bpf/cgroup.c                           | 16 +--
 .../bpftool/Documentation/bpftool-cgroup.rst  | 25 +++--
 tools/bpf/bpftool/bash-completion/bpftool     |  4 +-
 tools/bpf/bpftool/cgroup.c                    | 99 +++++++++++++------
 .../bpf/prog_tests/cgroup_mprog_opts.c        | 71 ++++++++++++-
 5 files changed, 166 insertions(+), 49 deletions(-)


base-commit: 79dc258c9392051420a26f1504c647bd3d27c66a
-- 
2.55.0

