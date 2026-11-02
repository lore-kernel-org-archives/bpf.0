Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639401;
	b=ge3iX1MAKrLF+qxYqMOhWYS1yvLo6bQBxwR6pfBEBe1OfS4KQX7sOUP2Yw/uxe9SGYMb
	 iy+iEVDzfliCUfVbCYi0PZT37HHbITDbwUOi0jhkBNDeyKIYX5aOn3J8uZypJQrqUtXSK
	 oKSI9fdhXffIXdJbQ9ulzTVPzOJm8O+73Cd2AmweFHOS2/Dc0lGyQUSIOeVU2tn9UuvLU
	 5aumuklCFe8NVHSGHgQErxjJsaAjxnaq8VE3NqYujXFMtZZwfbiNbi5L7aMWkqd7LANSC
	 Ea/82yggX7t0Qtup/Ns3x4AojoKXSQ9ebQyaNNKudZpivuKAN1WcKc6q6qPcU5gTMWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ObarEpSKwjlTTcOOrkpmxkzT/Cr/R/c/+rKemdGTWno=;
	b=HBQ/xhghSZyAgV9jWItPCsBTHxR+OSZE4HLs2GiBmbFq1OZPQ4ph3U6+SO5jPYTIbYiK
	 cVPcZ2jHzNWN+KmJlXqJ+2kCv19O3lcTpjZMsJiMcNcNnV9HCU14u7c1eerZq2qsiX55m
	 0Mabycv/ZRyVNVfY8coNQg70es27BbLSvCe2ET1QZMWsgKxksUcDvyryghEaygZISCKoD
	 Vu1yBPaO7L6Zn5B/RU1MAvdrE1/mfwhismaygJrT3cFJ//8uWdAMknyOWB0nk1Ezqbclg
	 5x3eKfil/bZ/i77XQ8az+v6LMCHfDjerZZ/hLPV1AOj0/fHqjzGjHvGubrhVtVrZJ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXEBTi+F;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074C606A91A
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7074C606A91A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXEBTi+F
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb2893531bso742126a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793639401; x=1794244201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObarEpSKwjlTTcOOrkpmxkzT/Cr/R/c/+rKemdGTWno=;
        b=UXEBTi+Fz8w9gh/USvecAdbwxHWNA5mSkfmgzRz/oQg2BHFB9zQq3YAVHRDut5k2zx
         XO30mqGjkrhFIG/CQkxFwe5dAW1zp0goNOLu6EkROW/Khxc+HYL7Z45yvJiFqZaSODOi
         3LkyU+hnyyWIisxP2RFppO1yirvRXQCWUIgSVsW4Dj6gg1IC9u9n9NBvu0XDZ1QSbbER
         1a8uGWK1joSl3rR/aEIGrr/N6I4Yn3aSovcgtgyKrOTPJeQwRKqu2dwNqUBmJ84AzpKp
         LdM7oYISZ+SKbvDUZqY+8b3Wds+XZgzoqaox6h4mrl8OG3gAypN0R9jk2MijqkNuLDi7
         9NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639401; x=1794244201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObarEpSKwjlTTcOOrkpmxkzT/Cr/R/c/+rKemdGTWno=;
        b=eeFPm0i6YsoM4eThpphPKRD+orm5HopGaxWPBMP8rAAN2RUnWWy9PD1NACe18p9KZ+
         Tx1v3C3l9DKvUJEjlzp8R8wgXoX9OvufeqmhH1qbajkNGKn0sB23nhGBcyGnS542tntO
         P7/0IaYBlezPElivGbrXnSF1Ue+rIh1Fji0YFEOsZQXpZBfVQbISW8varFuB3egdHqAJ
         OLpxLTft7gWUlzcTl69/rr99nfbFPgr/ft/Q37NSnmRH5F7E+wel8M3mjgaLst0qL5qA
         vL/M4jmmgF0bXhKZDcxvJRp0g3OTGRRfPxtClm52iWgqgiqHy7PHtVdKC+9Mzf+O9aLn
         oj9w==
X-Gm-Message-State: APuU4Z+DvgE0lB+J7TE0FkazqSUhzbQsRORd0EXbCzC2e2m1dYkAk4UT
	SY0z0NQQrVqVk3rGMY+bHhSkIQOVwVUBMevdI8a5kR3RDpUlu8xPENWsFTQ4Qw==
X-Gm-Gg: AYBFou3/iAw4aPxj9MzTRe2SSF/ygZ4kCQYpA0Ig84qIFx96dkPraHpUma0Wdqhkf3y
	CL6X3Xspr1ix2G+wYt5VVvSSBJTVpgLHqXdmhYWeBlIWPh9ebXWIurk5M7zirfemG9QM8y/wv58
	H/8A7xZJ+/Xqzh2DzJQSXklKWzHmFTp/V9ZRes7kVDKYh51vu3IDWD0l3iQzS3hYeCAFA6CzrMu
	HBBHL6XBGVWzAW2W4B/R/AuEcqMKdpySMblvvwh7/vE/QGJ3efnewhoiaFGcD4Pyrg0S+Bbt6Oo
	0oRSlLnEEue7ehgSAD/DyRl8CDf+lTNoXgv9HwNrD/BJwQSWtv+CucMqKfvaPlF0/oR+0HJhRw1
	k9M1S4fzNsKWEqV90u29ZcfsVqrCAsxMAAAMLBn4e+PdBU/Anmd9W18HX34M+M2rnp3SwNchWir
	vRJIY/Q8rhDG3DS4WnYIWg19P/6uApUnoBNGkgO0k3lXlByZo3SgvOXClKMdfLnNF0eY9RCX98q
	kmbRmVmok9z67BpXnmZknGYAlbhZpDPL9BmMHTwfXStszJFgUgrVCzzhHQm9cFE6u4TCJUyAMIy
	83JVqgtX5hBVxF4+FBh85Ec1urnFMtYUVggfnhckNkRbk+gCTAWHXcnnBAAfSTYS53O+0iHbX+K
	jhuOXkyoU+m4mjZoXqmV3M+S6UITyEdhuxG6trW+l40tshXAG/JCJeJ2LW4coDzBTquz9Lvok4A
	==
X-Received: by 2002:a17:90b:1b02:b0:3ac:929d:ba5c with SMTP id 98e67ed59e1d1-3ae89847b50mr8240488a91.45.1793639400659;
        Mon, 02 Nov 2026 09:10:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm11067a91.9.2026.11.02.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:09:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 0/2] bpf: Fix the stack buffer that bpf_dynptr_slice_rdwr() returns
Date: Mon,  2 Nov 2026 17:09:56 +0000
Message-ID: <20261102170958.3586893-1-alexei.starovoitov@gmail.com>
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

bpf_dynptr_slice_rdwr() and bpf_dynptr_slice() can return the buffer. When
the buffer is on the stack, the prog has two pointers to the same stack
slot, and the verifier knows only one of them. A store through the slice
changes data that the verifier tracks in the slot: a known scalar, a
spilled pointer, a dynptr, an iterator. Such a prog loads today and can
crash the kernel. A load through the slice reads such data as a scalar.

Patch 1 invalidates the slice when the prog stores to the buffer, or when
the frame of the buffer returns. Patch 2 has the tests.

The selftests that pass a stack buffer to the kfuncs only read the buffer
after the call. They load as before, with the same number of processed
insns. Cilium and sched-ext/scx do not use the kfuncs. test_progs and
test_verifier have no new failure.

v1 -> v2:
 - Read-only slices of bpf_dynptr_slice() follow the same rule (Sashiko).
 - Tests for read-only slices, one of them with a file dynptr. The progs
   end with a load through the slice.
 - Shorter tests: a macro for the callees, less in the run-time test.

v1: https://lore.kernel.org/bpf/20261102055543.3584718-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Invalidate a dynptr slice when its stack buffer is written
  selftests/bpf: Test writes to the buffer of bpf_dynptr_slice_rdwr()

 include/linux/bpf_verifier.h                  |  17 ++
 kernel/bpf/diagnostics.c                      |   6 +-
 kernel/bpf/diagnostics.h                      |   1 +
 kernel/bpf/helpers.c                          |  10 +
 kernel/bpf/log.c                              |   2 +
 kernel/bpf/scev.c                             |   6 +-
 kernel/bpf/verifier.c                         |  65 ++++-
 .../testing/selftests/bpf/prog_tests/dynptr.c |   1 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 264 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  34 +++
 10 files changed, 401 insertions(+), 5 deletions(-)


base-commit: 714b7112017fc7f8b2afabccf562acdb12d2ea7d
-- 
2.55.0

