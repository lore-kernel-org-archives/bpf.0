Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2298380FEA
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551499; cv=none; b=dF+uatLHiPBcgXmF482jN3AVlB8vqY55nDmgwgns1y4doSxmyxbtrd/xIFnIXUGHwIvVFnhkVifQtLAJYcttfo/YMXWagDGglqJb07B66aQAw5D790f2YW1rirZFstqeTh7y3+kJDI6S2ZgbMeshTKH78/0k5mJwVwKK56E/10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551499; c=relaxed/simple;
	bh=+uN4T6fpz76fkQR6WHSLomy4qLe4nZX50dqq9h8xTVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1+7Hk7DbPu6NWI3SP4VYm8WjZjkD8XbbLqYnsAZDPCWMoxPxWkZi2EEAPRHpfT5fNEpTLlKfqbmNFHgaZBXBndt3iDtJkFTrZUiTYH4FGsOA5OEvP/VravYieUjtJfJccUd8cOA8/6or1NMNt5MnVnDaeRfACMESzUCS9qP9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do6Mj8+q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do6Mj8+q"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-85339ed040aso1190335b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551496; x=1789156296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKfMAbI9WP00e34xfYRqukO9FWyuttxaiqoWfdsqtb0=;
        b=Do6Mj8+qWLOOjAK58g5xLEuYtLfjG/GzM9iOdxxTnHyfomlcbwqR6RurY/ZaPBg1QS
         BJG08KnIIBS5yWblkDXIXo1krX/YkBifbwbOsuDFhILIGq62WxChFzeHiDD6Hvr4YIau
         pnb068BVdVie7i8e3hjtdEwcDhR850TFgQcst5b8MLlBfgBlrEtQ9yuRkERH+ttRj9zv
         GtNJYoFwSi7jheYK041DF+urPSnypVmzInC7GxyERA9B0yhgKgrZkmWrHVjXsCrYIvs3
         9dg+bcyHFJazBbIOHoZxLN06gAROhaBf5iccY8wbSS9XDnKEp4UzppNFD4Rv4v67S3tb
         /4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551496; x=1789156296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKfMAbI9WP00e34xfYRqukO9FWyuttxaiqoWfdsqtb0=;
        b=iszU1xWf0HwI2qhzzS1v9LRG019WbsPoBqDPfAEO9wROstg2soYJKrMXlNt+kPI3hf
         w0hbxRgWJUUowUEvDowR4JBjP9Q35EKM7PsZRZCyNAkMoJ1toUphZR8iUYJozHeUmsJ5
         qyEQogkOjXoJ0TqX0dC86PSdmVYq/KbC3AlI3deu7m0mFz/kB4qHoGUew3roq3bvnpCa
         3Q4wmQU5HZf8P3Dij9MdOX3eBR6nkl5Yp4Boq4WhX4ezW174tmJkYEssNdyAiza940wP
         2WGEiMqfwIR+l//LfvwfJLakAGoRhP7IoIUvjSYt7NrXJ0grN/5JLCoX7wODolDAAvek
         qm/Q==
X-Gm-Message-State: AFuF++nQZRnSBEGPbyNHDZV2lp/+/b+VAJjLGNTv66rHiWmSJcb3JknI
	N27R5CYIqKmzvUNiR12hvZO6yZL+ODLyxVnD1E8kKUZAA3pVGcJq6RUtc/UNMw==
X-Gm-Gg: AYBFou2zBDJNrfmf1Da4fhI53VIqR1kcBjDa9POxlNyCczQwQeZzogfJLBVS6pqsOwR
	gbyMClbKnvrrM3g47m/pQtojxfV8Y0lkh9rPs3UHmYFzPQqavd2zUsowop9p/fKPKfWw6KjolNV
	GlQP5S2oRdd6zfqLTFiuBzocm1YC2lXPDOhTNxOmlPGGNpWeWm85CZ/vYI3d6H7CqeSRLlvUzVy
	6HoHRxDxtnnpnILoT5+gf+5e52E8Bou7DuHNSj3WXvKfnWkP7A+iuJ/yQtsupEriF15wfXEjMNT
	7DSqR0/xbA68jOX4QPFT6+UfC+Pe0wHujKXfmd04SyDVaLIMTvgPusbLBULD1Hoc+8navMkGlkB
	x7DYdk3BzAQVGNELVng+g8zsGAk7+4xL1VPgdWTA8CX4g8x6FRxvEos1KDAlj65OFNiuMIAj69Q
	ZDIl4OzEi6S8lUs7gLMLX6DvYcTYdLecf6TJiCoB15iZMYcNIVpU/sX4u99fopSRWwvKymuMU0V
	PLdWI5dITk//+No0WezpCG5xybBpGYBse+WppGkk7zcJOtlHHC0s1GEE2GUH4M0riX1qKpOPHvK
	7LH9/ksnL7iKY1ZbxutrrsC4wZpdsZa7UpidG0XKOF6Y+S/alSoygMmOUAj5/DaX1GrbVch7TuI
	=
X-Received: by 2002:a05:6a00:b94:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-861660e2f8amr11334624b3a.4.1788551495503;
        Fri, 04 Sep 2026 12:51:35 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:35 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 0/7] Fix timed may_goto with private stacks
Date: Fri,  4 Sep 2026 19:51:25 +0000
Message-ID: <20260904195132.141068-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeremy reported a bug[1] while executing a BPF program containing
timed_may_goto instructions with private stacks.

timed_may_goto[2] is a runtime safety mechanism that allows BPF
programs to execute longer loops[3]. The BPF verifier replaces each
may_goto instruction with a loop counter initialized to 0xffff and a
timestamp check[4] that terminates the loop after 250 ms.

Private stacks[5] allow BPF programs to use per-CPU memory instead of
consuming more of the native kernel stack when BPF programs are deeply
nested.

To make timed may_goto work, the BPF program reserves 16 bytes of stack
space. The first 8 bytes store the loop counter and the next 8 bytes
store the timestamp.

After the loop counter is exhausted, arch_bpf_timed_may_goto() is
called. On x86, it adds the counter's stack offset to RBP to obtain a
pointer to the counter and timestamp[6]. This works when the BPF
program uses the normal stack because RBP is also the BPF frame pointer.

When a private stack is used, the x86 JIT uses R9 as the BPF frame pointer.
The verifier-generated loads and stores therefore access the counter and
timestamp through R9. However, arch_bpf_timed_may_goto() still adds the
offset to RBP and accesses an unrelated location in the native JIT stack
frame. This is the mismatch Jeremy reported.

Fix the mismatch by resolving the address in the generated BPF
instructions:

        BPF_REG_AX = BPF_REG_FP
        BPF_REG_AX += stack_offset

The JIT can then select the correct BPF frame pointer before calling
arch_bpf_timed_may_goto(). The function receives the resolved pointer
instead of reconstructing it from RBP.

The LoongArch timed may_goto implementation is currently queued through
the loongarch-next tree[7], while its selftests were merged separately
through the bpf-next tree[8]. This series is based on bpf-next and
therefore does not include the LoongArch trampoline update.

[1] https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
[2] https://lore.kernel.org/all/20250304003239.2390751-1-memxor@gmail.com/
[3] https://elixir.bootlin.com/linux/v7.2.2/source/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h#L8
[4] https://elixir.bootlin.com/linux/v7.2.2/source/kernel/bpf/core.c#L3407
[5] https://lore.kernel.org/bpf/20260417034658.2625353-1-yonghong.song@linux.dev/
[6] https://elixir.bootlin.com/linux/v7.2.2/source/arch/x86/net/bpf_timed_may_goto.S#L18
[7] https://lore.kernel.org/loongarch/20260804153938.16129-3-dongtai.guo@linux.dev/
[8] https://lore.kernel.org/bpf/20260813070906.5164-1-yangtiezhu@loongson.cn/

Siddharth Chintamaneni (7):
  bpf: Fix timed may_goto stack pointer for private stacks
  bpf, x86: Use resolved pointer for timed may_goto
  bpf, arm64: Use resolved pointer for timed may_goto
  bpf, powerpc64: Use resolved pointer for timed may_goto
  bpf, riscv: Use resolved pointer for timed may_goto
  bpf, s390: Use resolved pointer for timed may_goto
  selftests/bpf: Test timed may_goto with private stacks

 arch/arm64/net/bpf_timed_may_goto.S           | 12 ++------
 arch/powerpc/net/bpf_timed_may_goto.S         |  8 ++---
 arch/riscv/net/bpf_timed_may_goto.S           | 13 ++++----
 arch/s390/net/bpf_jit_comp.c                  |  6 ++--
 arch/s390/net/bpf_timed_may_goto.S            |  8 ++---
 arch/x86/net/bpf_timed_may_goto.S             |  6 ----
 kernel/bpf/fixups.c                           | 19 ++++++------
 .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
 .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
 .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
 10 files changed, 75 insertions(+), 63 deletions(-)


base-commit: d761934c9483ecde93fe99d8705282f716dfee50
-- 
2.43.0
