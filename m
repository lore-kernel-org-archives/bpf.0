Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599158;
	b=DDEnhnfRVxfg3LCe0GLXJKoGF3zWXdISaK5zvXlYDiMjNwIXfQcYsTZ4b/I2SKntTXpi
	 QASMEbBz7fzDFSP7noMtW9IZlmgr5dfKLjfC7XsoApoDiM9mLFRDYRrpC6xLFVV/nS/+L
	 67BaH4PJDxv6F5r1bNM6eDOYsrOJM4dd/Fi6XANuiZiJZhu+3rHJViUARQXKrysZ6W492
	 9KiF1eM4mDSadM9m3VeDhcXA0dBRXsZp4pXj6buoUOemHIhp52od81aW0mlhNWQLk2x+s
	 h/wJnZrmXeBDuqsOKVNfovQ7UxQNlCl10rJ+1uqH0X6fSWdvOcKQTBgpNxnDgGPJSpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tkKfclwJLcP/msY7Quep9cRd2yIlYlEc6WnK27yVlNg=;
	b=4Gf3meGqRK7+t6WQUh6D174vwMPCnVxiSANLh5tc9V/JNglq6CEPHYV5+kudDPjA+7tC
	 T472MLnVVBtCMyBnsGRK0pZVytRidN5QAv295+VcIqESnPc6HzEkm2PQkr+CgKfqMtpQe
	 5w520OqHATv5Lf+X4ETX+nXBiU1SLw10a0ZwbCI1dzrr0ic61I3Jno0tSLVFWtjzW2qxs
	 RRQXfqh1lOY1twKo/ArL728TktqcWwr2aar1LNOVxynJWdP0veqOOjAWs+5RWA/kym8C/
	 PAeItPvkfXj3uTGoI28h8RMLL2B5JSpT1cydFFtBcx6GLrW7LWqQOOLR1K8RmDSusZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R80wSRys;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531E606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 05:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8531E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R80wSRys
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1172182a91.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 21:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793599158; x=1794203958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tkKfclwJLcP/msY7Quep9cRd2yIlYlEc6WnK27yVlNg=;
        b=R80wSRyspXNA1PmEFnKkqOkWzO1sYkKw8IymntC4dJ7lw5UYHV56meXnoIseI8sJPQ
         YdXE5J8mS71EGpwo+gw09fKsT7RcI8VP6Tfi68ZvygQNjFDDehnhmpbValkzfUvX+fdT
         aJd9Of2rsBnPbkcOEKgEcBvpXryFeEj7fe+vzwDNthxvXegXc8WJ8T0kOi2pV/2np2rn
         dyjMOWE3ESk4NSkPeL8+5ANhcifsDOQhRwuoM8si1+dsmsf4Z7cDev1V0pI+pd11SqTb
         /Mn4XCAksW/bxjE1840IO18P9o7piGjTNL/JlVGyCGiNBENll36EQkhYG4LeHy5PI+hM
         By8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793599158; x=1794203958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tkKfclwJLcP/msY7Quep9cRd2yIlYlEc6WnK27yVlNg=;
        b=GTfrGJm555VhExX8I+WAzhQiIlbopy44Zmev84lkJxmLB1o46KqgldLB6RFgEG9Rvt
         h81uS4k8+IkANVY09NPgJQkfUtU+CTTkQZeBX7Y5HtNlsyaQoyY5rYzvokI9K3tdPa0y
         x4aMDfyHKL3mNdVnE3tLUsg66pQGCvW2mjsV2M8yHI2ggPRhU823kXmGnY4Pc6zz8Wtq
         ynyCVFlBleP509YicrgPtnXN1T56Jl942Uy/HIFQ/qEpkZns3TTUEwy1ej5cFFbUYEkI
         U8h7gve7odlm6A+3NvParjX7CnUygDOJVDPvaq8gRbgZ+OJqmJxeHsws81vmnljAKiCk
         4JFw==
X-Gm-Message-State: APuU4Z+uyvLl9f60cGtn6aVqCACzTV9xCODuysxZFgFZZEwpjBoYi9j3
	fcoKkG9T7XCGMARJhf9k+Qt2ffeqKdeuzelWT/fyy1mySS8v301YGWnYpe+DUA==
X-Gm-Gg: AYBFou07e6hVGzpNqKmi/otrjLPfNLJL8o3T+LFEUZAZFiBO1Fs8pxYDLFUiBSJrDA/
	57SJZbXsavyEBTX6+eoao6++2qrDmy85IV36HEzMYLmo/0DuiQLtg9A9eL0/O3n+2Gv4B+y53zb
	zSDsBDD8mr4usy6ZkRBu9OywJNS57qSot9q7/AIVIj8ZPhXM4zv9K/QFcCJcH2Jk88KHKpKCbWp
	IH+OJcFmy0YOHMb4iDx7MzgkAFf7A5lGY6BpOH9ej8mp7Xf4/9JgAKny2t3m9+jLTDK/VnJgpvw
	7cUOiZlr11dhO+HjK2+qE7K5Tb7CFakVcKlrXw2HZ09/YaxQ+pFTdsAT+hXnBDsG9JOymrM5y9g
	5QPaoAnPfPfOKitTK2G40Ajhu1dckbDumE4aBaiBLtQIw6l5Dw+oPtrfpU/3x1UnIuTvqg65mkT
	+O2BSNW6SrIb3UXT8e1Oid2kjzikB7aaQihqsbgwEa6c1799Rj4S/1kq85QYIYiPZEG7rwQ57ML
	gukpktxVOoqSgcJorK3Siuh23t6cZDuwn3qtDpUM/Vg7FIygbf112MuJjOgbHHXuLQeVj2JU/4S
	hmDRXg41TTzmaEalbtaiCYw+HGs99Ph8acejnFRBOYbz0tm31tvYRgsNVoHR+teMl/7Aa6I+mBi
	Jjm8l86ixBf3c7bJ1fdvxs5RUUAPoWR4GTxcUkRujZgz1bJcSP/+5U7ExUov1Lbp0nn8WuA/VeA
	==
X-Received: by 2002:a17:90b:3807:b0:3ac:9e76:aa93 with SMTP id 98e67ed59e1d1-3ae89573cbcmr7086195a91.7.1793599157765;
        Sun, 01 Nov 2026 21:59:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm12863058a91.13.2026.11.01.21.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:59:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 0/4] bpf: Fix two holes in the analysis of stack arguments
Date: Mon,  2 Nov 2026 05:59:09 +0000
Message-ID: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Before the main pass, arg_track follows pointers to the stack through
registers and spills. For each insn it tells which slots the insn can read,
which slots it can write, and which slot it writes for certain. Scalar
evolution and the removal of dead slots rely on the answer.

In two cases a store to other memory counts as a certain write to a stack
slot. Then scalar evolution misses a real write to the counter of a loop,
and a prog that accesses a map value out of bounds loads.

  patch 1   "r10, or not a pointer to the stack" counts as "exactly r10".
  patch 3   A call does not change what is known about the pointers that
            are spilled in the frame of the caller. But a static subprog or
            a callback can replace such a pointer with a pointer to a map
            value. Valid progs are rejected too.

Patches 2 and 4 are the tests. Patch 3 needs patch 1 for a spilled copy of
r10.

v1 -> v2:
- One series. v1 was two series [1] [2], and CI applied [2] without [1]
- Rebase on the bpf tree: patch 2 did not apply
- Test a callee that overwrites a spilled copy of r10: the case in which
  patch 3 needs patch 1 (CI bot)
- Change the two tests that match the log in patch 3, not in patch 4: they
  failed in between
- Load the test with a callback only when progs are JITed
- Make the tests shorter. None of them is in verifier_scev.c now
- Patch 1: the example in the log stores a pointer to a map value, as the
  test does. With 0 the prog does not load

[1] https://lore.kernel.org/bpf/20261031220615.804426-1-alexei.starovoitov@gmail.com/
[2] https://lore.kernel.org/bpf/20261101004657.3406576-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (4):
  bpf: Fix the join of fp+0 with a value that is not a pointer to stack
  selftests/bpf: Test the join of fp+0 with a value that is not a
    pointer to stack
  bpf: Don't trust pointers spilled in slots that a callee can write
  selftests/bpf: Test a callee that overwrites a spilled pointer of its
    caller

 kernel/bpf/liveness.c                         |  83 +++++---
 .../selftests/bpf/progs/verifier_callx.c      |  20 ++
 .../selftests/bpf/progs/verifier_live_stack.c | 195 +++++++++++++++++-
 3 files changed, 267 insertions(+), 31 deletions(-)


base-commit: 714b7112017fc7f8b2afabccf562acdb12d2ea7d
-- 
2.55.0

