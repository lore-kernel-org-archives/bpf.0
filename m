Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794116382;
	b=QoFSeUQP0+kItBRAL9iQWD+e4XR2VfvseySQhYZA24cJi2Azncv7xRmyMdS03FxJligi
	 /7hFup2gJNm5Avs0JCXmWg++hWMq3MU20MtbwiWB6LiurP5+xqtvkzwueMyyOzE2w8e6O
	 fRIx6rua2S66yyWWettSv3o5iCFIApvZO6MHAyZdxQ1hZOW8hUbig02FKv5msDlpoMeTQ
	 /JzQoU0quy4kKVKR8naI9G8Q5N4MgKp/3cBDptlTrxl6VOkHCWnDVG+VdEOY2nHo3b4hY
	 mLyRZa69STbaoYIRoF/gy72n5wvyuQEfnSNqXEnl0tuWE6PWyolA0842hT1LALJpqLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794116382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=C7Qyndblm5a3s4EqOs6ldTJfmw0WVe2SU8ewYvntx6o=;
	b=Q3/mYP8ZQzy1k/6UqbqG/qKTJyGQZP4dfHjXL8B0R1voHzEgc9ekHEzWFhTqIJG8JbwX
	 6/iLsLV/6VmqC+HT4urOeXOH1KPgreV2RL8MFzbZzoc9bPPpFuomTw9sDTX3VmyRI77ar
	 JgNWoJRMJgofxMGVm+7u0DgvpiupKtqEI0UZw1qNDQyDR52YDsKxSTKh3cF2l+8DyHsQm
	 JQlGeI/j6e2EWWxwo1t6OWs75mWlEsJUt7AFyLxrYLPxlAN08J/F/Dm/flIJ/gNnNKmUH
	 evueI3Wn5B4+AGa9G4R6bn27PgtZu+Q4HH57+JbdWqXji/SGChJna3CXPUDYeI+b2yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UaJlzZje;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B72606A31A
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 05:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B72606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UaJlzZje
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so124434a91.3
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 21:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794116381; x=1794721181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C7Qyndblm5a3s4EqOs6ldTJfmw0WVe2SU8ewYvntx6o=;
        b=UaJlzZje/nsVWFU9Jbsj7rbAGSU2YexMFSa4L/0O5L+M+yDAWmNoZNEFyY+S0P8e3L
         I8j+cMsBVpNEpMBYV+TVlBVdfIUnvn9moSZmmPF4kokLZr/U48wMSc7w0XK1QB6paJUA
         Nces3nrsjWtDQDuiHJwt2rFveJf0dP2rHENhDdFuavYklUKzKplwxkE3i7NOB4MxXMYi
         Ck8uR8/XsuETwQ4O1KoTIBd7P064xrfaZGwmyUQhgOOmQbjeAUuKo2RraMM9RoDNnzWt
         hl4MK0cq19hxxWfFjUR9b/5gZJAXfaAIPEVhQ8IzhL0ToVOMhRcrNG3VXtm4bVC9sThs
         4oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794116381; x=1794721181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7Qyndblm5a3s4EqOs6ldTJfmw0WVe2SU8ewYvntx6o=;
        b=fSXKlS8DmccDYjgQODQ6rK3DYyAAChbuG0n3R+HMKppYhVFtY6PTXoIgsW8y2bJWxF
         bCZXWinNhp04cgSPZ2vWtJ2Ur3dD5GTjE0lRtp2ZgsIw+QmUPGaIMuPGW5d/uX0qq6fi
         tcAL5wfqj6QO2AMxnmIMkEGCGT1A/GOJPbGj/xdUK1rOlAOd3+mJgXbKvWhMaCktaWZz
         SiUukVJ4/m/ZRAkvzPZzsfkmzeNLri+7Bd3HozggUe5pioMKGGIp8hpAEygMS7xhgfV2
         rxbKkBMdY9Vzn2f9P41RM4R1n4hg+YTn3S4knT4Km4+fe03WlyinK2pmDGCQtaT3MoK6
         nSYQ==
X-Gm-Message-State: APuU4Z/P4yLwu3cvJhM013LTZdyrT4nBpsgu3ft1U/2w/nFPYNpob8nX
	/QOJ4tEB8j7UFIGoESCWgEsvi/ZkANK2CrUCNsR+hn+wSiYakOGQlvQL6c89OA==
X-Gm-Gg: AYBFou0/db7ulxIQVw6cj3ZwxltQ2o+jnJQ/A5QF0wY1pIuz6EjUhTsDmv48giVE6pm
	1aqy9ZTlFA01iRZ6BaKG7Tp1lSVekDVUw82FR775Fx1jx2D3J9pP2B/qrnyulG+drBbstZqQZKU
	8xVto8Beymvn2DfJXKb5pub2nCGKYFX+2W/RE76rNPjr0evHODSl9vebdiSBjAcWp/wXLJv+hHi
	Gi/dlluE0b41cWlgzqNGBT6IrNi9S1dN4jvofReXxqybbnTH0CFsY2ptAhwRMi6jaa2PVrKQQZu
	JLRtpQCQ7lB2+d1bs/olOqqF7EyI+kdUwGFiFeQlYVe+fdM0DQXHC+6Hqi+uPP1oi3TddqA+nFm
	0BlgO0oYW+RKUqxVgJuoTI+KLSNZ6XXCRUApn0JWKBzUAX7u8ByFLnA68kpq7pPl3iPnGPyAb2v
	yN8JxxC6aJXuE4EwLA9dKJ7Hbgy6XV+5kkuv/Hc9PHb+JA8Yh8O3jgt7JOHN1OKXwFeoUf/Eikh
	b1iwrM4vmSbh1vs9YCsctLjJefHFSy89AMoRwVfVE6vEhP/MknbhJLKdLRB7TA2LSmfSZomkUKI
	ztXkiKTycvGuLAozx2Og9lf8m1a+Y+umD3LIBX+TMgQfwXQUm3iTSjDUVQCMHN5xst5PptxWhra
	MYtxFMXPRxTtLXOz3MxWXdsx7tGOBQva91uvjrrbOxY2Pff5CJyc/DjjgzlPQuKo+Bf/skW/KXA
	==
X-Received: by 2002:a17:90b:17c3:b0:3a6:e99b:bbdb with SMTP id 98e67ed59e1d1-3b12d56152fmr571170a91.50.1794116380890;
        Sat, 07 Nov 2026 21:39:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1152fa888sm3112216a91.9.2026.11.07.21.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 21:39:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: One basic block and the way to it in the level 1 log
Date: Sun,  8 Nov 2026 05:39:35 +0000
Message-ID: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
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

At log level 1 the verifier prints each insn when it verifies it. It used
to follow one path at a time. push_stack() noted the end of the log when
it put a branch aside, and pop_stack() moved the log back there when it
took the branch. So the log was the path from the first insn to the
current one: never larger than the longest path, and for a rejected prog
the path to the error.

Since commit 2d0b457611c0 ("Merge branch
'bpf-a-verifier-that-joins-states'") there are no paths. Basic blocks are
verified in the order of the control flow graph, and the states that get
to a block are joined. pop_stack() is gone, push_stack() notes nothing,
and nothing else moves the log back while a function is verified. The log
holds every block that was verified, each time it was verified.

Two things broke:

- The log of a large prog is many times larger, 15 to 35 times for the
  three below. The text is dropped when the prog is safe, but the buffer
  has to hold the log at its largest. Valid progs of Cilium, katran and
  scx that are loaded the way bpf(2) shows it, with log_level 1 and
  a static buffer, get -ENOSPC with 64K.
- The log of a rejected prog is not the path to the error. It has all
  blocks, both arms of each branch, in the order in which they were
  verified.

1  Two helpers for the log: take its end out, append it later.
2  The level 1 log holds one basic block at a time. When a block is
   rejected the way to it is printed in front of it, from the edges that
   the states at joins came by. Nothing is verified twice. A prog that
   loads pays two stores per state.

log_true_size at level 1           one path   all blocks   this series
  bpf_lxc/tail_ipv4_ct_egress         51434       774446         7652
  bpf_host/cil_to_netdev             101212      1789015         9778
  katran/balancer_ingress            103567      3668559        22603
  progs with -ENOSPC at 64K            2841         5503           45
  the builds of a prog as one           435         1018           23

Level 2 is not changed.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Take the end of the verifier log out and append it later
  bpf: Keep one basic block in the level 1 log and print the way to it

 include/linux/bpf_verifier.h                       |  10 ++
 kernel/bpf/flow.c                                  | 111 ++++++++++++++++++--
 kernel/bpf/log.c                                   |  47 +++++++++
 kernel/bpf/verifier.c                              |  20 +++-
 .../testing/selftests/bpf/progs/linked_list_peek.c |   2 +-
 tools/testing/selftests/bpf/progs/rbtree_search.c  |   4 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   2 +-
 7 files changed, 181 insertions(+), 15 deletions(-)

-- 
2.55.0

