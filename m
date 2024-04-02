Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032E712DD96
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071614; cv=none; b=FnCNhxr3rQFf3yjHVHyqSOyl17+A975/fTYCpNVF+z7edJ7lp2xoAUAt8FL5vCjrxisqsykLrWLSNZ36lk2e2V4qhkK9R4vU0/EFO6Jspsl4xup2P8iSYwalO0ARJFIyuClEp2xmm3FP8JNGoO3udJu2/DlBwJOjk+DKut5d6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071614; c=relaxed/simple;
	bh=cDIwmR/+pigqsQwn0iqfrP1ItD6gYhfHtFwl42YT9cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDaIosOQt9OlaQ8JZ3HiFKGmZck5+ocrO/ll4LipwiIVZQWCXX65UTevvOkzdWRuapSMdr3Uin6Q2SZq4ehfnWYHFpXJxpcp71FRe/yQeaKeue3WvcJ/+yuwU/erCWFhvsVJPqRgub2pGiJjK6NgX/OCm/1Kn5jo5RdLrfU6mTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB4JiSrf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB4JiSrf"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so4314058b3a.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712071611; x=1712676411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBwtS3QL2CZW11tJQLizCPuFJLAttf7XaWqZP4MBaco=;
        b=QB4JiSrfytm0d5g/lji7N7iArIb8ZFHE8QOnK5KXnjJK1v7FPIOlUMDCp8QV91ZOp+
         k4Zph6UyO/i8ZGtXsQKuuHhQ4OvCF73Ry6UyTTdcfSpDUBl0zmdFWlOKEynmqbR1w3jZ
         4Z19Y0uTpdi/WAMdxZ6TviSBVs3xCQ2s6WWlQNBUH5IVnSf+wzBW8PkGZZFwi4AYnPs6
         uzU5c3ocHwr6j4nqX6y9YEzKJ7Of334duANeLOIYwZ8Ziz7Qyj74XAyMBwjhRFa8fGu4
         U2ghyHOVJkDHs1GAhZ33MkrPOBFBMxcFoISsyThA5rHgEFCcLWMvQHl3S7SLusnydXW9
         QcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712071611; x=1712676411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBwtS3QL2CZW11tJQLizCPuFJLAttf7XaWqZP4MBaco=;
        b=MCTZyoGiDlKkspKoEVxD+BPXvXmHjps4eH5Y5xhkHbjqqtSMFcR2aOlaYW8knpLw94
         K1CXDl5kJCUpIrgREyTpOCf5+oFrj+ssaZbDOJRcqlXGnHG8Wa6Tu/OknVIpCVI5/o91
         GXeuUhupzP2NvKLgtQ7IOvMyodgkOnmCo7gXRcY0ceE+JTMO0/bDh6PjLyk1OX/f+Qh0
         pvgjetFGnxVTXYXhBinBd1qiFZodHPY9Obpxpc4wnExP5c1cYck1XjOKo/0UdSp3TU1Q
         m9tGRMfug8nnyLqAc78+VvKmsbCnZTqyQCWdP98rsN6Kx2pbCtk7velPq0Y3yhgnP8ne
         67kg==
X-Gm-Message-State: AOJu0YwkWGmS/93gMizqExktswbbM11f/nGitX64lfr4andmKsGn3wdO
	fw23VToOkk5OaJuShO7EUKXZoyUjJjScuwAWQCdQZ6GZPHGgL6L0ONfc19Vr
X-Google-Smtp-Source: AGHT+IEu91007ETlz+BPE0HnTlbSzTFM19pFOt8talEqrMirtU4I42q8ckbjMA8lCBnCdN7pBm9Tvg==
X-Received: by 2002:a05:6a20:1b04:b0:1a3:55f9:332d with SMTP id ch4-20020a056a201b0400b001a355f9332dmr9104570pzb.25.1712071611121;
        Tue, 02 Apr 2024 08:26:51 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001e0a08bbe49sm1640505plb.140.2024.04.02.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 08:26:50 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 0/3] bpf, x64: Fix tailcall hierarchy
Date: Tue,  2 Apr 2024 23:26:35 +0800
Message-ID: <20240402152638.31377-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset fixes a tailcall hierarchy issue.

The issue is confirmed in the discussions of "bpf, x64: Fix tailcall infinite
loop"[0].

The issue is only resolved on x86.

This CI history[1] confirms the issue on aarch64.

I provide a long commit message in the second patch to describe how the issue
happens and how this patchset resolves the issue in details.

In short, it stores tail_call_cnt at task_struct.

First, at the prologue of bpf prog, it initialise the tail_call_cnt at
task_struct like "current->bpf_tail_call_cnt = 0;".

Then, when a tailcall happens, it compares the tail_call_cnt with
MAX_TAIL_CALL_CNT, and then increment it.

v2 -> v3:
  * Solution changes from percpu tail_call_cnt to tail_call_cnt at task_struct.

v1 -> v2:
  * Solution changes from extra run-time call insn to percpu tail_call_cnt.
  * Address comments from Alexei:
    * Use percpu tail_call_cnt.
    * Use asm to make sure no callee saved registers are touched.

RFC v2 -> v1:
  * Solution changes from propagating tail_call_cnt with its pointer to extra
    run-time call insn.
  * Address comments from Maciej:
    * Replace all memcpy(prog, x86_nops[5], X86_PATCH_SIZE) with
        emit_nops(&prog, X86_PATCH_SIZE)

RFC v1 -> RFC v2:
  * Address comments from Stanislav:
    * Separate moving emit_nops() as first patch.

Links:
[0] https://lore.kernel.org/bpf/6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com/
[1] https://github.com/kernel-patches/bpf/pull/6721/checks

Leon Hwang (3):
  bpf: Add bpf_tail_call_cnt to task_struct
  bpf, x64: Fix tailcall hierarchy
  selftests/bpf: Add testcases for tailcall hierarchy fixing

 arch/x86/net/bpf_jit_comp.c                   | 137 +++---
 include/linux/sched.h                         |   2 +
 .../selftests/bpf/prog_tests/tailcalls.c      | 418 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  38 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  63 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  50 +++
 6 files changed, 652 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c


base-commit: 8f1ff3cf139bc1269eebae5d43ffbe482675f360
-- 
2.44.0

