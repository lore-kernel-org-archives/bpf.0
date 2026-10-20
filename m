Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519311;
	b=piriBXiDzjkftAOQFymwqURKwbVCGaV6ev2Xso6qH58YjeXuuBrvwpI5r47BXq6iCIyw
	 3ttBUvXfN8vHSvOeD+6IzUuTlAC/3eCC678QGspmxf2yQIo41W83V5p3hQSi0ukof6Nts
	 JMNg5VgZZ2/7m6UvQCaocd/PdZZ4J13PX0bE4UAS+Gm5IdXYgj7w9CVCNnSwgBDw2Kk7Q
	 tsy/6bxg4+81ZHgwtXBn58Oj06wj3EGEwYZmBI//wLKloDthzzOFbJ/5kJKjGZDZ1Kp4f
	 nghvrx9sT+ILDQfL+CvT/8SyWzTGJnrNYgW8WZtxk2l4t3nhu2ldIBh+uAwAPz4L0yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=P8d+SFG9cye9kINhwYj32YlaC6AwQ7WatHGgNGgbEQc=;
	b=n+Ahg8WeQBiqfFMRH8eKivwPqdo+RGSriDxXJrTgdWRst6l2r5arbE0UgwmYz1HJws8u
	 eqiEIRbkHK6a4iF6T3iVmtOOEkeSpukEVVwB1d5XuhZFvBLXL8YT2uTQm683y8JHsst1g
	 cuFCUmdDoPlvdp81rCDDk5vuwYILvY3RfBm8mEsJaZms5UzSFA3n6houSN91d86sD6u0w
	 LY+Effsa1kT5RaU0aVLdZQ4GQl4d3UE4L+XOpdEqqomBg9JKbS6H7veqLb6QOwAyfzIbe
	 KXJDy/R9f11EU4Osda3REeXG82h304siAGFATivFYdgYPACZbpTmlDOK1+Yp0jjzISQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ir4+NZSF;
	arc=none smtp.remote-ip=74.125.225.136
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE0606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DCE0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ir4+NZSF
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4a1963cf318so19940905e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519309; x=1793124109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8d+SFG9cye9kINhwYj32YlaC6AwQ7WatHGgNGgbEQc=;
        b=Ir4+NZSF6jvfkqDa31+xGzJntaqB+tTEVWwG52LJgTmoQ0NgPcKJExnHJKK5DEr9J/
         8ely6dobcmhICFmonVrWFI8QEH/zPZdxvxu71HAEAqTOs2Cv3WDDybqZxvG2blSRl5Bk
         kEZh8fU5RV0j18W5stV3+J6Q+Q29coYxHFSOubsK6d0km3xlMKo0z74a4Ksb2K77frP0
         DEUJrGenKFiDIQ9TEtkPC4fyZVWhW9Bx+pTz8ARSuPcdk6BwFwdwKkz/zV/Rrk1QMRLD
         MY58mCdnq9v9pYGD2s3Vm4dO2Rwjqi/rBR8CLz0OW+uA1CTsCX/XP5jO7wj5CO8pM0px
         YWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519309; x=1793124109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8d+SFG9cye9kINhwYj32YlaC6AwQ7WatHGgNGgbEQc=;
        b=wZxk8s02F7LMe8BgUYJYcjVK4l/UVvLoXs6l3kH3tpq15+g0iRotSIG4KZNQCU3+T0
         G/sLGvPuGfCeEh75W7Pn22oHtS0uSElHmh1FdCEabm4Ni8GQzUE+N/XT+GtGSfPkwhMy
         bb8SqAkp0G3QT/YEssOgTvcRTUuIvBGsnEvfqriz0oKzWLu6fN1ghV0GNI+eqvStnMT6
         rpNwVHl92SjRPcyFbfM8Cu/5cqLQMiC0gCS9WNFdU+fUVyns1cxz5nKy/iohNyL3Cuhf
         Ro0aumcmQPIBMn8vTarrOgZ64ur1uuw3Q+BR3txJkK0lOZ9LI+217ksjPddtOAXBEDan
         57Rw==
X-Gm-Message-State: AFq9FYIOGUNWxjKr95CKzHisF1jhj5WnuWozzIH6bd8lCXw+95Ji5BpG
	VCOKqtBMvEOw12cZ/0kcO4cXNZmXRgsgVma67G4dA2etX+znt43ZbGpqhUoZwMyx
X-Gm-Gg: AYBFou0vM0BueMvH0vQOS1jCdWa/Sss6BNwy/+qkbrES6p4nOOzvtUwGtc5oA93nYRn
	ROdzNzuUPihDuKsVyW+gE1BO6hoJe6iG+rE2HHUy1qM/F/AaeCZz/tqbISqPiVsjPRYzVtw6tZ9
	m4bqN44Ku7qOB7fi7OL7OgGH6/obdo5/kjLW+RQ55qR4/y8rmj9yGgsoVvBmeBo4cCNNzy8eLA4
	b+qlq78xdVivEtKGuJNKI+BQpTYbuuGZsWHaUCu1EwAH60Hqib7Ms66A69g8EUoQ7wNcpUjnBGP
	W+F//Zy/ivyT4gpox2Lp5VyKMV4sdQUX335wEc0Z61Js5Dzyu3lqaNqrvPQxRQ8jjmgY+tY3s1D
	WzeILmt2TxCDctHeEYmMy2E2OZcg4v7xZp04S2r3rBrUtzv8q2e7MvadvuQ1oOA6T90P+tBHnCV
	Jpo0y1wJtKpy0+IUQriL96b5Ge863tUhAb6X4bcFe9ErKLPKTLeo90rt+i2RHAsUMV24X6gnYVr
	enAo9fkNy/s2dCjczPnlZB2Gw3vuvVIC9UPtShchaqwWs3RktvEmDedGGYTBKT7IlZoNBdCMJwM
	BBjsMaD38ZOh97WvunMcYe0VsgfzBArMLmJsJg==
X-Received: by 2002:a05:600c:3b09:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4a1f7f47d43mr53851295e9.17.1792519309195;
        Tue, 20 Oct 2026 11:01:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2e8daffsm96863805e9.4.2026.10.20.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:01:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/6] Eliminate spill overhead for bpf_throw()
Date: Tue, 20 Oct 2026 20:01:36 +0200
Message-ID: <20261020180147.1769873-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=memxor@gmail.com; h=from:subject; bh=pLFL8WxYRfl/OBAOlZnIr5NUSLMOJkJ6x/1Uray5t5c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIev6igcXJjE9t+vYvy3J+4nqjIg/n7LcV/f+8QxYvPzTj srKz9Y7O0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCR6k0M/6zdVKvSGPWymQza dy3xvdr/fiFHc02eo93p9quGy3YfecrIMHE/s2q2iYeG9L05BlNDD6w6Vj816FDv1p530X//BlU mswMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A program that may throw is an exception boundary: its prologue pushes
every callee-saved register the JIT could clobber, five on x86-64 and
ten on arm64, whether the program uses them or not, and the exception
callback pops them all from the boundary frame before it runs. Every
invocation of such a program pays the pushes and pops: 18 bytes of code
on x86-64 for a program that uses none of the registers, five stp/ldp
pairs and 80 bytes of stack on arm64.

This series moves that work to the throw path. Each JITed function
records where its prologue saved the caller's callee-saved registers,
and bpf_throw() enters through a native entry that captures the
callee-saved registers of the throw site. The unwinder walks from the
throw site outwards, starting from the captured values and taking in
each frame the values the frame saved of its caller's; past the main
frame they are the registers the program's caller expects back. The
exception callback receives them and loads them before it reuses the
main frame. The boundary prologue is then an ordinary prologue on x86-64
and arm64.

Architectures without a native entry, s390 and powerpc, keep their
boundary scheme unchanged. arm64 is compile-tested only.

Kumar Kartikeya Dwivedi (6):
  bpf, x86: Account for the r9 push in exception boundary program
  bpf: Record where JITed subprograms keep callee-saved registers
  bpf: Add bpf_throw_unwind() and a hook for bpf_throw() entry
  bpf, x86: Add a native bpf_throw() entry that captures R6 to R9
  bpf, arm64: Add a native bpf_throw() entry that captures R6 to R9
  bpf: Restore callee-saved registers from the frames being unwound

 arch/arm64/net/Makefile                       |   1 +
 arch/arm64/net/bpf_jit_comp.c                 | 151 ++++++++++--------
 arch/arm64/net/bpf_throw.S                    |  30 ++++
 arch/x86/net/Makefile                         |   1 +
 arch/x86/net/bpf_jit_comp.c                   | 134 +++++++++-------
 arch/x86/net/bpf_throw.S                      |  39 +++++
 include/linux/bpf.h                           |  17 +-
 include/linux/bpf_throw.h                     |  49 ++++++
 kernel/bpf/core.c                             |   9 ++
 kernel/bpf/fixups.c                           |   1 -
 kernel/bpf/helpers.c                          |  47 +++++-
 kernel/bpf/verifier.c                         |   5 +
 .../bpf/progs/verifier_private_stack.c        |  12 +-
 13 files changed, 356 insertions(+), 140 deletions(-)
 create mode 100644 arch/arm64/net/bpf_throw.S
 create mode 100644 arch/x86/net/bpf_throw.S
 create mode 100644 include/linux/bpf_throw.h


base-commit: b71326388a8a24674846c1d8d3b6dd831d9843a9
-- 
2.53.0

