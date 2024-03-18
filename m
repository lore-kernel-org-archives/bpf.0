Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5172CCB3
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754303; cv=none; b=LJCMZSst8eB8YuP1VwfcQamRgnlAIpAM5+Twzg7/5VKk8vQY6ayH+wtL3Bixwa6Rm6FbHw6djYqAmHqp6IRUbfeVbpenpYfN04MwEYkMSSQd7pWxaF6hVA+MBb7j6dVut6BJeOZlNPNza3sa9obdQqZFSWAgGLENSoXcVIo21Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754303; c=relaxed/simple;
	bh=pu2XrpZj27kZNaF1YLZf5Uy6+QNwdBOYyKCa/lBmGLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J43BmrfzUSEwhgEy0tDP8exfx0ufamZkiLVzmAqJLVz+wpg6m6GMRoYqx+I8iuOQNJG7XNc7kYQ7kUfl611uC2bXi7gX0xChxVR/ol47nBz4FrzYd9//hLqP6KwaHv0YWhuWBW/Z+hDs1OcsG8oZOwVX9UEvF6oeuxtn4K9rq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abZc9UsU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abZc9UsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC30DC433F1;
	Mon, 18 Mar 2024 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710754303;
	bh=pu2XrpZj27kZNaF1YLZf5Uy6+QNwdBOYyKCa/lBmGLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=abZc9UsUy1Xk8uTkB4fV5auF2vm5Oe4x03i1mtTlLtRMRic1Bf2PA5QCKY49bRuGb
	 HpZgEYCgroYPUNaoPvvHfBfma0553M0FinkLZ81imDnwmknBWb+vHiwJGuZTNAZlyE
	 YWTRPtN+neHZEDHImSrAnWXSL2yxicEHPioBRNFyRd+k6x9HO0tZKMAklKS+Jp0pl/
	 GcqI5J5Zosr7eGcPhQ02kaNdJ+79gW3hQN/yu4DHkzbBHzzIWt3dUMhag5JW7hr7Om
	 6kLyjtgWU7SAiaGB10MsFArlYPwGDIJuTxEvTBNOdsnMyHZ9R4/1Q9nL1U0hTeLxve
	 xVqp/MnOkWvLA==
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
Subject: [PATCH RFC bpf-next 0/3] uprobe: uretprobe speed up
Date: Mon, 18 Mar 2024 10:31:35 +0100
Message-ID: <20240318093139.293497-1-jolsa@kernel.org>
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

reasons for this being RFC:

 - I'm not sure we want specific uretprobe syscall and not generic
   uprobe syscall to extend in future.. when I added extra code to
   read registers from stack I did not see any notable performance
   degradation, so I think we could survive restoring another register
   for argument

 - I'm not sure how we want to handle assembly code in bpf selftests

thanks,
jirka


[0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
---
Jiri Olsa (3):
      uprobe: Add uretprobe syscall to speed up return probe
      selftests/bpf: Add uretprobe syscall test
      selftests/bpf: Mark uprobe trigger functions with nocf_check attribute

 arch/x86/entry/syscalls/syscall_64.tbl                           |  1 +
 arch/x86/kernel/uprobes.c                                        | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h                                         |  2 ++
 include/linux/uprobes.h                                          |  2 ++
 include/uapi/asm-generic/unistd.h                                |  5 ++++-
 kernel/events/uprobes.c                                          | 18 ++++++++++++++----
 kernel/sys_ni.c                                                  |  2 ++
 tools/include/linux/compiler.h                                   |  4 ++++
 tools/testing/selftests/bpf/Makefile                             | 15 +++++++++++++--
 tools/testing/selftests/bpf/benchs/bench_trigger.c               |  6 +++---
 tools/testing/selftests/bpf/prog_tests/arch/x86/uprobe_syscall.S | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c          | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_syscall.c               | 15 +++++++++++++++
 13 files changed, 281 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arch/x86/uprobe_syscall.S
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
