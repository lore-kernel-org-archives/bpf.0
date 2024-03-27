Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEA481C4
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534842; cv=none; b=M/Cl/LGRkSsjpod9FUkQD9L0BYwO22XTEFX/ruPHkCnlpewgqI5DG0lXeybvf3qX6xicWyb1EhJtks4xfmEPVuBmnQ5vTqeTLNj/NfstIX47DIm0voz71iS7RBtFI6AIVNr3tL5la+b9pbcDOTG4V6fJHvm/qWl11n8xL+bqDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534842; c=relaxed/simple;
	bh=pBRBhHinvugllgkzCsvFsoRJzEpKfHc14fv3oqiZyGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMO4I4q8DEIQyN0MmoK6WfgXtjXhxCNaKoXYh/io+BH/EJLkZ7ucHnEwpZ4pDE9Q1eofR3OzhCwxIWAGKM0qabmdf0xIM1rgwZRYAJvOTwDsnuynvrfN2dULmWbzCosP8bPRk4MiJmCwHMPO95GT18Du0eOfVrL0SeKqhPwBzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD7EW6M6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD7EW6M6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04499C433F1;
	Wed, 27 Mar 2024 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711534842;
	bh=pBRBhHinvugllgkzCsvFsoRJzEpKfHc14fv3oqiZyGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=cD7EW6M6dY8+mdn01fI6i+tPtFdUzhaSDWy4s/9BY6mFCi5EUYJizG9fEZEiVmAz/
	 CDznZjVQTTaKY/gqTdhAhFWAGBg7+OiynR1L5hRbjrkfqsWsEagbsfLc9iTUEWkMTJ
	 lXT31kCi8U7llCjpQIaDvdAWUC4wp4zY9zxV5PzrWHdlpHHEHBFkMMyh0DeC9u2mCK
	 6HkWnnFqcPStIdWH1sVPE39QQseVgBj6GAoDKb0wWjkM/kPcMcma+703l/1Euv6ZXm
	 eA2NeyByNku4bKIflVIqekGinozge4evA5PU5T+5uiGrNGhcKTN2KBXAXDXWWvGGtd
	 i7jFG3FSkNQNg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH bpf-next 0/3] uprobe: uretprobe speed up
Date: Wed, 27 Mar 2024 11:20:33 +0100
Message-ID: <20240327102036.543283-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
as part of the effort on speeding up the uprobes [0] coming with
return uprobe optimization by using syscall instead of the trap
on the uretprobe trampoline.

The speed up depends on instruction type that uprobe is installed
and depends on specific HW type, please check patch 1 for details.

I added extra bpf selftest to check on registers values before and
after uretprobe to make sure the syscall saves all the needed regs.

changes from RFC:
  - using __NR_uretprobe instead hardcoded syscall value [Andrii]
  - using __builtin_memcpy to copy registers [Andrii]
  - adding more comments
  - Oleg provided the code that enabled the syscall to take the
    sysret path, which made it lot faster [Oleg]
  - nocf_check attribute change was sent separatelly
  - added test for checking up changed registers in uprobe consumer

thanks,
jirka


[0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
---
Jiri Olsa (3):
      uprobe: Add uretprobe syscall to speed up return probe
      selftests/bpf: Add uretprobe syscall test for regs integrity
      selftests/bpf: Add uretprobe syscall test for regs changes

 arch/x86/entry/syscalls/syscall_64.tbl                  |   1 +
 arch/x86/kernel/uprobes.c                               |  83 ++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h                                |   2 +
 include/linux/uprobes.h                                 |   2 +
 include/uapi/asm-generic/unistd.h                       |   5 ++-
 kernel/events/uprobes.c                                 |  18 ++++++--
 kernel/sys_ni.c                                         |   2 +
 tools/include/linux/compiler.h                          |   4 ++
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c   | 119 ++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_syscall.c      |  15 +++++++
 11 files changed, 475 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
