Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E83EC69C
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334127; cv=none; b=D2K/EmslDkeSMCdr/1Ber2R/+5jzQGijMR/fKR84/1z7jfIpct5rwI3+HrgL5rtnp808mimns+3HDejgvO6pkZ9Wp8CBGTi/dsQK9nPWo2v50Jplg9Q1RgR0lYglJw6ta3+rrRr0hsAqn0NppR8UqVcFRYUy1Nhxrtsq7lKDXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334127; c=relaxed/simple;
	bh=caK3YQhscIVtTqPF383EgVDd2plNpnkjR8MPdMqnPCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlAr7DW+jPPx5ajDq1SGoUcIW5ImuHQX5BozqkLYsGJziorZKtSzzgJW/oNW+6nvQU3steWGqCYQpNNqt1vyhPgnvjlEVGwHYZlb9Oz1YaSPdS3BQNjjHQzNXnPg21heT2E4VUdMoZbiNo58we/WjyCtEniSeTLKJoJdkb+F070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT62JuJO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT62JuJO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d6efd73032so16447805ad.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334126; x=1788938926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tfng2JiR/0ECboMQl6RA203DWPhramX3l7RBL4beIyg=;
        b=IT62JuJOZ5Bsu716eScuUFXQot2cP//G7VRzv80SyGl50S66tBWXaTiZmqlAXbz9ko
         6avHI5SXD+HWjPj6YTLdxVUbT3DDVNPis7ZfwXTwBKKF6FQO6e9lcBFUPoEeUQEgPcGR
         SS5sV/+FdS7F1J5u9Zb5WHfAe1F/tyMr5FtJP3HBfFDUJ4fwBjvLeTIDBKWcwUzMiXqQ
         fQIgs7dIPiQehr57TrykZgNGm1dXSD5Js4L7HxEI6uixxtvkRW/stltyaBVyQ/cBqUrh
         mosO3aC06Cd7sUAbN3Zmqm0KwmmgjxUEvic3GHbveReqimPl7HiITT1V7RDZhOavenEU
         Hbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334126; x=1788938926;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tfng2JiR/0ECboMQl6RA203DWPhramX3l7RBL4beIyg=;
        b=s0QsN1ILK4YcHrZk0QWZ42tB+Db6HdbtyGjBb0YK7Tt+rX4nUCxeB8MVQ3JgTm3/Tb
         3QyEEwaoB7C5+CfEcmwB4I47wo3rHt25e/ssH4kXJqj8GUK4uP0AvODN/7LxV2g7L9Te
         nl04J0XFUVEzQY6mQnXdu27ZI9pPhiH0HKNF8wcbovICvC3Gj12GaCJ2pIm3hm+Olva4
         7Udo2yWhkgWEObSr/T/BmzK70VFZsfQ6O/Ra+eJyEi/m39tWjGN9Y7ZeZbhRf2VmueRd
         bPO8YOhp0TSNC9YAfxlP5hVvwEOkTa0tzYPQ8egKl6CpnWcuLUY/v3fCosSEI0bjcZkt
         RJKQ==
X-Gm-Message-State: AFuF++kdyC4u0hpJexRw+Cu9NPM6smTSZzzfAmXVNJmJrMc5pbybyWHR
	pHTN0XMWkqIRLYcux25J7vXmzyMiq51qHGPGEopep8YGkz8HU49hEtd7RhyzdLu0
X-Gm-Gg: AYBFou1/IPHP0fOEEuR4Qjr4tgJyFNrFDNTXdJjjd494gnILkb38+SJwIO/Pi/F+Wgb
	uIO4yXUsudAUXCS/vlo/6O8K6h4yhaMjduudZQFVG4qWzAE1/nsFJX3Zx8xvemLpQC0zIAodxp5
	sO5Zfasu8XctBYdGp64s1xLMuWJePv6KTbZ/o9eA5O1xdOapG3WHgxPF1Bs3SB1+Az/GyQYEhjn
	NCYQvZ4mNpgsKtrzLXLAWvZnW093iIc3yYaSdAWIYnbGGw+MVUNXTqJkgUgbFRsVzw2sFIIBB8H
	sUPqV5v1H6PGlEQGGDUxqBE3d0xEnsGY9ROWTFvi51NmcBtx4yc574wIZ3T7P3ZPEpT2Vwo9lUX
	rrgG6fsARir1lcffxkEbbMxUlbs82qufdVWTq78T4hF1/oSKhZ19MZm8YlLlnZCk/dk0cNsgB7h
	oj/A4EzvjKNCqHfbGL2kK0UQ1faXHVVjjIpNY4F3TQsaBVAzBrP3VleK3uI/Gf+mOvqodlxmIs4
	vrx1Q==
X-Received: by 2002:a17:902:f546:b0:2d8:d4cf:fe47 with SMTP id d9443c01a7336-2daf1359c47mr9703495ad.13.1788334125787;
        Wed, 02 Sep 2026 00:28:45 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2daefcbc86fsm3978355ad.62.2026.09.02.00.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:28:45 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	npc@anthropic.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: precision tracking across BPF_ABS subprog exit
Date: Wed,  2 Sep 2026 00:28:35 -0700
Message-ID: <20260901-bug-016-backtrack-ld-abs-v1-2-59368f1be435@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901-bug-016-backtrack-ld-abs-v1-1-59368f1be435@gmail.com>
References: <20260901-bug-016-backtrack-ld-abs-v1-1-59368f1be435@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A test case checking that the verifier properly backtracks both
fallthrough and implicit subprogram exit paths modelled for
BPF_LD | BPF_ABS instruction.

Without the previous patch:
- the verifier did not call bt_subprog_enter() on the implicit
  subprogram exit path;
- bpf_pseudo_call() branch in backtrack_insn() executed
  'bpf_bt_set_frame_reg(bt, bt->frame - 1, i);' with bt->frame == 0;
- causing a segmentation fault.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_subprog_precision.c         | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index d21d32f6a676..e174a905c562 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -846,4 +846,55 @@ __naked int subprog_result_tail_call(void)
 	);
 }
 
+__naked __noinline __used
+static int ld_abs_subprog(void)
+{
+	asm volatile (
+		"r6 = r1;"
+		"r7 = r1;"
+		".8byte %[ld_abs];"
+		"exit;"
+		:
+		: __imm_insn(ld_abs, BPF_LD_ABS(BPF_W, 0))
+		: __clobber_all);
+}
+
+/*
+ * Buggy verifier did not properly backtrack early subprogram exit
+ * modelled for BPF_LD | BPF_ABS instruction, causing a segfault.
+ */
+SEC("socket")
+__success
+__log_level(2)
+/* early exit path */
+__msg("3: (0f) r1 += r7")
+__msg("mark_precise: frame0: regs=r7 stack= before 2: (bf) r1 = r10")
+__msg("mark_precise: frame0: regs=r7 stack= before 9: (20) r0 = *(u32 *)skb[0]")
+__msg("mark_precise: frame1: regs= stack= before 8: (bf) r7 = r1")
+__msg("mark_precise: frame1: regs= stack= before 7: (bf) r6 = r1")
+__msg("mark_precise: frame1: regs= stack= before 1: (85) call pc+5")
+__msg("mark_precise: frame0: regs=r7 stack= before 0: (b7) r7 = -8")
+/* fallthrough path */
+__msg("3: (0f) r1 += r7")
+__msg("mark_precise: frame0: regs=r7 stack= before 2: (bf) r1 = r10")
+__msg("mark_precise: frame0: regs=r7 stack= before 10: (95) exit")
+__msg("mark_precise: frame1: regs= stack= before 9: (20) r0 = *(u32 *)skb[0]")
+__msg("mark_precise: frame1: regs= stack= before 8: (bf) r7 = r1")
+__msg("mark_precise: frame1: regs= stack= before 7: (bf) r6 = r1")
+__msg("mark_precise: frame1: regs= stack= before 1: (85) call pc+5")
+__msg("mark_precise: frame0: regs=r7 stack= before 0: (b7) r7 = -8")
+__naked int ld_abs_backtrack_both_paths(void)
+{
+	asm volatile (
+		"r7 = -8;"
+		"call ld_abs_subprog;"
+		"r1 = r10;"
+		"r1 += r7;" /* mark r7 as precise */
+		"*(u64 *)(r1 + 0) = 0;"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
