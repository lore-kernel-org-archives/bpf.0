Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358303;
	b=qZCOgxMWnZqzN7jOizQaf9o03HNKXL9FcV3W3ijlOpTk4BJMc9joavM9QU9/vAPaTMIX
	 wNsObxPO/Bs2kX9CEQYD1p6E/x5jCbiK4eKO0c4m5zQUrOumDlWcZqm/EfdB9ay8IgrrD
	 D8/Gtfosh5/iCNyoU4bop7LfcPEt6rQ6CdFi0mCggme3eGAup50IIQrCa+wM5hcHqq8f6
	 7KcICK6LEjWxAVvNfaWzrHM6AxgBJblNHCsGwbLfmSrDC+OKaTdke5DYMa/ORCdgAPbF/
	 ANEyD7cfj6jjIrB+zCK+T9+h/Z1Vg5o2TOlecdugZK/fceDW47MwXCSEcaCYBIUBTeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zR3wUD/INy/nbqIL6qlCIoQGBzJRNDMCQAEgHUUSukk=;
	b=0kY73tKP9L5w+51dFpWKR9nYm13sgb0lV8FSEmn2yK6gHqyaqq7R+ilAf3URC4fcx/lL
	 0o4a7z+cGN93xz9avC3AMcDOBAr+BEo/G3N11qldCDEdxq37EYRF/U9nwtrfB2hSqhq82
	 qlJ6PUPO5F/FVSa+ybviJxiojhD40RmjdLy0qPGdSRN6b9tgtvTZP4z8jIxtUgWTAzqrv
	 5SddokqtepfSnOJ0T59Zoqk+uG5fKuUVimv7auTm7sKNY/1htXKIK19le462gHNjFuBDF
	 ghR+/+23YIoAYyKNtKKzCyq1s6bFqWqCGK5f+3/pNF0TNA+VQICNwUvMdN0eZWWxVhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ng0H2chT;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB1606A32A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 14:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EAB1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ng0H2chT
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a8cc11ac42so2044271c88.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795358302; x=1795963102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zR3wUD/INy/nbqIL6qlCIoQGBzJRNDMCQAEgHUUSukk=;
        b=Ng0H2chTucQOmqDOWc/deVu2zZkFiT3XII8uF41QhbU29FW2Z9mp4MOdWULdD4cN97
         8GgqbSZ5j0KN3mJbhbgWzl3wC8HiSMBCFlsbZoS4012TjpYOlTm8B6V4BxByKwgKhGWq
         UnOxo8Cnt/nZkjvtZXH5OFDCKTXopPB5ukAx/zFtnwh2PGrT+h0nmJx9WQh5NdL4yS7i
         3iXy1XqV8wUTXfkA2jEs6zOrk9rHgzCzoGwOD2lObxwtPrq+J23K5WkOwROj/+UCqMu1
         CUx+10DsnTJgI86Pglpo1YiP5fjTKiz3iunErCVabpjDs5vsN8GsPeDNzgRs0niZfbzu
         rQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795358302; x=1795963102;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zR3wUD/INy/nbqIL6qlCIoQGBzJRNDMCQAEgHUUSukk=;
        b=BYUScLZ67Ize/ZUYLABwTIMjxhr/+U1YxZRO0v29we66LiG0w4WGA156BIVWECtFyt
         Gfa/eikELXCcduAjeE8Ndpok90agdx8byqt4PIZYvKGLMOpLuJ2aEJ/xi+CebUQB3ywa
         JkPdXKkx0yYTibq4n9s9H0EqkdKbjEnbqjt7I+zdsT3MzERFBvrhJmxsW4m1lwpKUjat
         c4xCke4QT+Neo+TsVB6+3Tml65ykA4Nv26Li2upi+GfxANVwgLTS5E41CClnpF36Z7+H
         w4spKRZHk5geiUTlOdUSFR1tLZ8d8PCJcOIVAhVoGS1+D/ccUwn3R87+r66tGPo+bmP3
         N6Rw==
X-Gm-Message-State: APuU4Z9p1Oggv5sP50A+5li35lb2WpBrzrvLQEb08ubZ+u9PxO+73NLK
	oOI3k1GXBli+V18nWVY1zM7JSP/LMjo/eVVDTwbLmSxGnXJIW6d0LLdmi35O+P6yEnQ=
X-Gm-Gg: AZFdTZcdS1oriO0IwVks4SdwzIE3bic+8gw/USkemYA0FrnOKvWeDiICLCA/O546k0O
	u5pqcQ21vUONooWaRklDKJwbqs+eMC4qRK8V8Su9rHOxXTN2tDPAHOyDB7c0pjD9ZQ8ZNOb1IKg
	f7anrQnlkR5k9vb5vdjsSsWpFKkx+pGCS8wjkEtnEXMd6SJqlGWqZ/pnEF1GEdp6ErhaNRXgmsl
	xfjIUJ03L4+926yQT8CmUb7bQONxCYmE2qcdGxa3IcWMP9SlOzt3YzPB7BYFtW5sAIHiyT7aOpO
	iEUWe7Znk3XkstsUX5uXOlRt0OYsXy+Ilvg+p48D9CjL225sJLn5UQwAkx95cEuCbBwXOWsLNUk
	+wMSfDOHslGEBNNHCypQP2sH/YdY2VVvX4WF25qU9H8PyLypLuJNbp7Yx27k+F83aXMDDx0LZEt
	ajGS9ybW8h6GNUzEy72HfEGe5GxKdO7E4ZPhhTNI8HYqQHFYGBMZ2Kn6QYMHisTZLzjDGQsOclI
	LzBXKu+IygPOUdIYWMyutfrBl9pazxFFxrsZNSOh9a8Y9Dkh0+2+hgtVfdjwADWwoF0S9JKL01I
	dJoCAuV2i/kU/dBDWJnDb3Q4TpO9ikE9ulTr2ipzAyF5GSY1SojZYHTyOUGeegTsi/SBk1S3AjD
	KdeUlRreXcTo=
X-Received: by 2002:a05:701b:4306:20b0:1b2:4c54:d976 with SMTP id a92af1059eb24-1b55ff0e104mr6523208c88.31.1795358301950;
        Sun, 22 Nov 2026 06:38:21 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm21265456c88.8.2026.11.22.06.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:38:21 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 20:08:13 +0530
Message-ID: <20261122143815.330528-1-abhishekkhade69@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces two new BPF kfuncs for binary-safe
substring searching in flat memory buffers and BPF dynptrs:
- bpf_memmem(): Searches for a binary needle within a memory buffer with
  verifier bounds safety.
- bpf_dynptr_memmem(): Performs substring searching across BPF dynptrs.

Both kfuncs utilize an allocation-free scanning routine based on the
Crochemore-Perrin Two-Way string matching algorithm. By computing the
critical factorization of the needle in O(m) time and O(1) space, the
Two-Way algorithm guarantees strict O(N) worst-case linear time (at most
2*N comparisons), preventing quadratic O(N*M) RCU CPU stalls without
requiring artificial comparison budget counters or risking premature
abort false negatives.

Buffer sizes are capped at BPF_MEMMEM_MAX_LEN (2 MB) and needle patterns
at BPF_MEMMEM_MAX_NEEDLE_SZ (4 KB). Verifier bounds safety is enforced via
the standard __sz naming convention and dynptr type tracking. Both
kfuncs are registered in common_btf_ids to allow access across all program
types.

Changes in v3:
- Replaced naive loop with the Crochemore-Perrin Two-Way string matching
  algorithm: guarantees O(N) linear-time execution (at most 2*N
  comparisons) with strictly O(1) space, eliminating quadratic RCU stall
  risks without artificial comparison budgets, premature aborts, or false
  -ENOENTs on repetitive patterns.
- Expanded automated BPF selftest suite to 29 test cases covering all
  boundary, size, zero-length, periodic, and pathological repetitive
  patterns for both flat buffers and dynptrs.
- Formally verified all 5 safety and liveness invariants with Z3 solver.
- Verified 100% equivalence against glibc memmem across 50,000 differential
  fuzzing iterations.

Changes in v2:
- Moved __bpf_memmem(), bpf_memmem(), and bpf_dynptr_memmem() outside
  #ifdef CONFIG_CGROUPS in kernel/bpf/helpers.c to fix build failures
  when CONFIG_CGROUPS is disabled.
- Removed direct access to 'ptr->data' in bpf_dynptr_memmem() to preserve
  the dynptr encapsulation layer, delegating buffer resolution and checks
  to __bpf_dynptr_data().
- Fixed 64-bit size truncation in bpf_dynptr_memmem() by changing
  'u32 size' to 'u64 size' so dynptr sizes exceeding 4 GB cannot bypass
  the BPF_MEMMEM_MAX_LEN boundary check.
- Registered bpf_memmem and bpf_dynptr_memmem in common_btf_ids (instead
  of generic_btf_ids) so they are accessible to all program types
  including KPROBE, SOCKET_FILTER, NETFILTER, and TC/XDP.

Abhishek Khade (2):
  bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
  selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem
    kfuncs

 kernel/bpf/helpers.c                          | 247 +++++++++++++++
 .../selftests/bpf/prog_tests/memmem_kfunc.c   |   9 +
 .../selftests/bpf/progs/memmem_kfunc.c        | 299 ++++++++++++++++++
 3 files changed, 555 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memmem_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/memmem_kfunc.c

-- 
2.53.0

