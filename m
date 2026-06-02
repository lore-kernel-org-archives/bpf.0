Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85397221DB6
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433952; cv=none; b=BAD+hTZHxe7TKRFNmTsnIdz3Del0r0PNEHJX8pvGA/YrpRp1qRzYH1fPOUC/prQHSLJjL6t3K/GFU8C/r8reI6WZFv5wfau+s/lpf6UGYW58G6ppSAHdpiZHvV5KvLDpSMQU0ptqiAmtEFK7b2rFRozwDLwp3WacrfcgIo/RTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433952; c=relaxed/simple;
	bh=+jtKDsdspxU/PcXSW3DyLJRlMvpgXNbAEVECdmHVt7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEK1aXJItCvgfD9LD5bXezO99cLWhnFKyboamJ0fBvsFzmhB5Rz5H/MQwsCik1KxxmGQbkTnvmsMUR59c3EKil7I3po+Ym2/gK4k/+HjkiF3E/VHBd17dPH1lwu1po1bG3Aq/P+EGKv8QTv5GCHbjhMjbGLpJ1yFvh7kgWfXSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAmhpdOU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAmhpdOU"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85ba774551so1000886a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433950; x=1781038750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LsFwosRJQ7xuFenuTgaUzNnNnhs7WZU/8+qcwovvf0=;
        b=iAmhpdOUQ9B+bw7TIWvxoIFWpdvLvoW6kDNUKy+l8fysF0F6tler+7ubzKMnscHCe5
         t61U8m2+6D8AjzMMkd2mHTynBJ5DA574tRJ87wLNo7pYHICUkYABAeIjPJlteMMkouF/
         JrqR5LKZ3wlHxnT7ifaNO9Er6aJdxCS/BbjpSRDD6hHsBltUSsrur3wnrb/sJRHN4cT5
         d2dHe/OHRDyGsdAPX2cdlXyzSj0+p4biHx87Npg9QfnCp9JmyjuQnuj2RgvHTbEGsVBj
         aB5cgLr9+FAbPZno1jJF1PNLWLQlJ5h3Uh7QBKqoMR9Ou3I9PEF2hGHLKf7FWeWaIefj
         49iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433950; x=1781038750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LsFwosRJQ7xuFenuTgaUzNnNnhs7WZU/8+qcwovvf0=;
        b=a9LYxCMTkEGvAtPDvzFaDJfOslIm1Ss2Q1DhZ3FFOopi52FXwBpynSZi5F62/iTv9M
         cMTRiM/JzgX5Q3mIEDsFsDMaNUMJFlw1lmKBNn9imOBvJaMLrf+IkWxt75ILdHZQQaw5
         zpqolg8s9qvUVqnmEdBtp8cSZEw9OTTvxPb9RNNgMbLKMsKgIK2jE/2pJQAxVoltNTzH
         ymc0ubaf4suFJFIz+CiCGKU5QbIGvpMM9bre0/KAK/RSC8C/TQJ9ZZR8c3pgRnyTDpBC
         dXdQEJvkvMrRB6VwzoxMXLjGUfKOobO/+j9T2qwTN794/AySa7JSLMw3Td8tDxbe/ZH6
         MreA==
X-Gm-Message-State: AOJu0Ywt5oqkmmRMu2cegb6DtJ5YGwwdgVGCUOj9F3d9yw1+V/bNLbWw
	LX1SBAZ+MOg4HWPMpsBIPROMtU4iKiNXURdqTSZ0oj11n+rRsW2W0O/XQINqfACg
X-Gm-Gg: Acq92OFtEPY70TCsdJseExoHa9ylyAKrE/Gga106S0jDpSetkB6ekjySLB2pSUKOPpX
	e93iJ5F5OswoC+xCtVU3CrAQYv1av6ma8e5Z1ZIesFKZLBlLPQ3SnhWMdLAXbCX3V77GIgjtpUu
	WuhL6OhS80liI68DvScaXk62EH/EpdYqb6b16j0IhvsRoSajsf2FZseYgGlJcwXoqYvBPERqMv3
	Cq/i6L/eB+Ahk9jg7SNOX1ZQJ/ox/hyBeagtxN/8ulJKqE9yrAvFP+SHKScAUWs5ZApaP9Tl6IJ
	3Ky1fqgnCRVxsnqgW1FnOFkDySwdI4EZmApqj2Y/kIEpEUKGP66qr1V5lhvLgqlaF7KeuuUuN83
	M+nSLOlMq3JVgRJjhOWdMNymjssq+3S+CuP11FvQJiRg1+obpagiASmx8ixIvFl0j15i+evaaXD
	s/jWqo/cAOVmfO99Cs2XiblDNpI1/FxFJyEduNe4N86F64+oLifSpbDjBNT8q0Bm9jc4l+LZDBq
	flDnw==
X-Received: by 2002:a05:6a21:6c11:b0:3b0:7771:ca57 with SMTP id adf61e73a8af0-3b497669eacmr475117637.38.1780433949708;
        Tue, 02 Jun 2026 13:59:09 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:3b4a:11cd::1c6:2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df043223sm157354a12.8.2026.06.02.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:59:09 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	puranjay@kernel.org,
	menglong8.dong@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	pulehui@huawei.com,
	alex@ghiti.fr,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next 0/2] RISC-V JIT support for bpf_get_current_task/_btf
Date: Wed,  3 Jun 2026 02:28:45 +0530
Message-ID: <20260602205847.102825-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches add support for the bpf_get_current_task and
bpf_get_current_task_btf kfuncs in RISC-V JIT and add a selftest.

The first patch adds support for cpu and feature detection on
the JIT disassembly helper function as RISC-V JITed code was not
being disassembled using `LLVMCreateDisasm` as it was missing the
"+c" CPU feature and JITed code contained RISC-V Compressed (C)
Extension. This patch generalizes that to detect CPU features and
enables testing on more RISC-V JIT work ahead.

The second patch, which actually adds this support has been benchmarked
on QEMU RISC-V and shows significant improvements.
It was benchmarked using a simple loop inside a bpf program that ran
bpf_get_current_task() and execution time was measured. It used
bpf_prog_test_run_opts() to repeatedly trigger the BPF program. The loop
ran in 1 second intervals and it kept firing bpf_prog_test_run_opts() as
fast as possible until a second had elapsed and then reported statistics.

Varun R Mallya (2):
  selftests/bpf: use host CPU features in JIT disassembler
  bpf, riscv: inline bpf_get_current_task() and
    bpf_get_current_task_btf()

 arch/riscv/net/bpf_jit_comp64.c                     |  9 +++++++++
 tools/testing/selftests/bpf/jit_disasm_helpers.c    | 13 +++++++++++--
 .../selftests/bpf/progs/verifier_jit_inline.c       |  2 ++
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.54.0

