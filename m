Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555226;
	b=FFBZBi2/fNzm/BOaV9f+ZkbKgAc3eA/W9Dlc16+V3Ei+PzxoCNCP1X/kq4P80jjBJW61
	 nV/ev9GEGgSq7WuP+KXdILEvb5jnD/k9yZ6twyGJNDP4NNUPmVkEfUQn0KjLF8bSHRO5Z
	 81skE4YY1VgeWSXRlJ2VK5QsenhzZpQK99LI2gR8yV9Obg8QEIGUcWTAVgvD0KlQM4Nnh
	 CZqAckmvvAubYuXiI9xFLCKZQ29HBFkzUNW6Np+l8VrZTyC7IIxbh0QVebhlkfu5FtYhd
	 R1gdVBFACJs7YwqVq2CAdiyoNyfdLVi1i6+lJBECRk8ZmFQjKkUb1y7/Lt3GiRXM3rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Pxgf9cvWbSYKVp93yG88n3vImKWoHSAOauFaqlsNeCk=;
	b=gamxTgF5I+XuxrHsgrkNcY/1vKPqo6KMd3gmrNV6erH46NypH8RqtSege6JWHxyj3f7D
	 YdE8iFKJQaOKbvEiP6vxAxIQOobnJJYQLUqZewmWqi7nyGRyNUAvX6iT2QVsXS173Nj8T
	 cdQc2NrMNuRi3YuVu/s7zdrOaNnQrKH1otWOAWuMSbWaMdIwvDh4i41YRCCuU+20HqpqN
	 sSxi2ZRzyYaXSJPg5rH8OzcXR2gRyqBW+ogHJvw7vzgwHPGHlQ8jrp+z8zm4inrSiR4aj
	 cDf0k9/p5pBJp2n729EEUzI55xJKcepjH2/wFPZrsym8iKYKkzLbRx2EkPssnQaSLwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRJEZcca;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B6606A334
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 17:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 277B6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRJEZcca
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b2d149693fso4806997b3.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 09:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793555225; x=1794160025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pxgf9cvWbSYKVp93yG88n3vImKWoHSAOauFaqlsNeCk=;
        b=vRJEZcca0kWsUYurp24B3N9EMZZ10YKNcvYYKchOZT0onPnAbX0fFr1xFcZogJtRCf
         p7JcdFVu58HG6XckQWJwp7vFwsWlmCdVOicnV3IqTc8+wTGzl0K0vtWXuYT/J3mmQRCP
         OnOHwq+CRnN3K3t0LKnKLBdPizoktBfZzryDnYEckr2Si38lRw8PmUnsOrYAI54IAJ2A
         BRN0Sr8kHvsaMXWqI8udEoKUGdFu7ahZDpkQN1lD7x5dmfNILaj6MxDjoICpxI4Gl2MJ
         fGNE9Xm05DUtvWRUDnaJjEHKPpDpFYM32HxvN9/FoMoxxlpSWRDACHYxqKSwPh+zGZiv
         wTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555225; x=1794160025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pxgf9cvWbSYKVp93yG88n3vImKWoHSAOauFaqlsNeCk=;
        b=eSJpGlWEt4l3HmfIdEbCejN072JUJjId20Br5CbVdZUkWd8yAKqu0mS3YV80+YNJJU
         iqmKQHgt91qIb0R9FMDnB/510b3a5gm9Gt4HCtX47Xle1ZXqA02wTbOhmBcYjuKKZ+Gp
         rvs2ffUQsF3uEJcqTrcJ2ywapHvr1KaYSLwFAXAGuN4Uz+SPf972ZkpI2Hzskejc5ZcD
         vZ1o5n+o0nrppvGR5/tB+nAqu8hP7qul6POLCLiEOz1Qyurt9gQJ5ULE1ogexqNN8N8K
         xKFBLXGaRYqQ9IpqUrN+Jz+N6rkjX7rFrgphZi337gzGPg+rOhGtglpZlpq8Bs41sCYR
         AdbA==
X-Gm-Message-State: APuU4Z9RYhsWJ69r9E5bc8YOQa5bZNNO/OXzVv744U/UN5WIGoWeoelk
	9zvDRgUg9hak34g9cILasxzkF9/1ytgzyPIxs1W7SMAFQy1xu0/5xGBa+jVEOQ==
X-Gm-Gg: AYBFou0NeEjM4QWlddYFU1bTtd2+8EUmpNMTgTMFGPiWJ4dH7ScA+FhmOk6K2mPZ1tX
	M4cxNB8BmM4FOFG9K4praZtiOS8sozcr567RUvOXFhUGOuAx8O2jYjl+9a9hl3Fln+sWJFfvyzI
	EKhsyf0/SHJtMjTQwMslIeit11/QY3NpR3E8kq/4nxxzph863fYGlUnD9uLp/TD8sp4u1uAFg6b
	9Fdn1RTGXsjjZUO9OY8fvx7v1Fq4356poJxAGkhCIVoQN4cZaYwcROVdakKCHLi39XGn3WzGi0T
	ZNKVJWL40AozjqQHookOcwtegNFtesf4j5K51BQShkuwCNK580MYvgSEJlp4QxPGg8EqIp0nmxr
	BhqrsqiaR4BzV4A2bMdbeCs9IBGkp6pC1iZRSBKBHpg+Bx80dJgL6HjEU/Z5lD/1PCNE4wN+QxW
	UqWqhDUP6v0wDKY0v+2AuCKTcea57ermkKqY1biciy+Lcu+3w9XS8RxS13iQFToVagwCnBucjFl
	8CgylIgPLP71R6x4Xk7t2fueQdTO9DgftkibSKkCMnJxK7PQjcJBKI29DfTo+2xu+urnsY2ihG2
	nyThxXlz1jOUTbfX9LpOLYP/NbbUosH0jLl+PTaQoPAE93o83FNQB1ws020n8Yf7ZWNdLo7OPLn
	xVuvlcRbrdfS+4kR7mLBg72f/R8BOYSGGyZXXCBa5ZnhIjKPTBpYK4QXLMptTdsLcfs8riKScnq
	w=
X-Received: by 2002:a05:690c:e3eb:b0:8ae:9448:14c2 with SMTP id 00721157ae682-8b2b67dad22mr46466867b3.99.1793555225032;
        Sun, 01 Nov 2026 09:47:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf2aa655sm3516610d50.10.2026.11.01.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:47:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: A lookup in an array is not NULL when the largest key is below max_entries
Date: Sun,  1 Nov 2026 17:46:58 +0000
Message-ID: <20261101174700.4086827-1-alexei.starovoitov@gmail.com>
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

A lookup in an array or in a per-cpu array returns NULL only when the key
is not below max_entries. The verifier knows that for a key that is a
constant. Then the prog needs no NULL check, and the verifier does not
examine a NULL branch that the prog cannot take.

Patch 1 does the same for a key that has a range, for example 'cpu & 3'.
Patch 2 has the tests.

The counter of a loop is such a key since scalar evolution gives it one
range for all iterations. The verifier rejects this loop today, and it
accepted the loop before scalar evolution:

  for (i = 0; i < 64; i++) {
          key = i;
          bpf_map_lookup_elem(&array, &key)->cnt = 0;
  }

veristat, progs that load before (A) and after (B):

  progs of               progs  that change   insns
  ---------------------  -----  -----------  -------
  sched-ext/scx            493           29   -4.22%
  scx, as BPF CI has it    428           25  -11.84%
  36 builds of Cilium     5029            0
  selftests               3891            0

No verdict changes. Progs of the two sets of scx that change by more than
5%:

Program            Insns (A)  Insns (B)       Insns (DIFF)
-----------------  ---------  ---------  -----------------
flow_select_cpu       293093     145475  -147618 (-50.37%)
mlfq_running             600        333     -267 (-44.50%)
mlfq_select_cpu         7227       6293     -934 (-12.92%)
mlfq_exit_task            54         50        -4 (-7.41%)
flow_running              92         99        +7 (+7.61%)
forge_init               535        772     +237 (+44.30%)
flow_dispatch (CI)    411387     186252  -225135 (-54.73%)
flow_enqueue (CI)      19362      28793    +9431 (+48.71%)

A prog needs more insns when its key is precise now: two states with
different ranges of the key are not equal.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: A lookup in an array is not NULL when the largest key is below
    max_entries
  selftests/bpf: Test array lookups with a key that is not a constant

 include/linux/bpf_verifier.h                  |   2 +-
 kernel/bpf/verifier.c                         |  38 ++--
 .../bpf/progs/verifier_array_access.c         | 165 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_map_in_map.c |  31 ++++
 4 files changed, 220 insertions(+), 16 deletions(-)


base-commit: a30c772627b2ef4bc715332b1b04938a914556cd
-- 
2.55.0

