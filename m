Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC4367B92
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332371; cv=none; b=TPS+7wGdNo/nsNtw58RO5CC4ngOX4/coIzZiNkPIdg76QURbAR/kNOBnL9GtK8xrZoOcgzR8jEbYShOR0VaYnJSwfh6PnBYpu7tYms9R9Nrpd0xXvzLBX4LXQ5R3vLZfPuOEdpgemdeptOHng/jc2QWwVvOPPhJskYR+bBQxczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332371; c=relaxed/simple;
	bh=SzXfkIfY5nT6XTJMo7kSDB18r4QbXHUNY3qQrByfAUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHfPRKrNgRfgtvGkE66tz6cWbacYzVUQqqfcnIDdID/Np3i1cgVh1PEjq7C8/XHOUlroCgnH67frHJd5JHNQtull93MI2aANk0+wGTd1yZZg1qP78p53u8iMOaSM5JzBqZ/JZgKPN5sEWtn1cF3JekYN/xdr2HytbW8Zz+W0TWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=cYe92JE9; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="cYe92JE9"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651c36a7ee9so774995d50.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1779332369; x=1779937169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPHH7NKYNQc2juIfrHQQIsBoYOBJaS924Jc2tnnxbtQ=;
        b=cYe92JE9oIgyilzRaXBYdeLKspUgroAO074kz6nT87uF39eYzYt8Rbgoc9xqHDDiCm
         8p35rh/O5qXzhfkzi4yoKMMn6mgRxWjy5Md/eTNd7aBSOhKfYTp0N7wBvUHm6tJS6cFe
         EVRbXE5uomiGkw9u7wJILnei/4MhkccwP+3VOf1KHAFr/RASx1o+cWGPLmr9jUNks08t
         BnqWNPthFGGdXlMbi85iLTkECxVMktnlhQaHPozC9PetrpuWM3twFI23i7WRmPWQQ6Iq
         i7XEeBAvT6f6WY4i2iAHzkQqrxLAsHABneslMEsH0iW3L8s1i6K8glTI88z3EyQ4p62f
         0uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779332369; x=1779937169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPHH7NKYNQc2juIfrHQQIsBoYOBJaS924Jc2tnnxbtQ=;
        b=suRdHhdlcKw7qy0SeD8gBG29noDAJ/jNFcaKWWJ18r0olwaC7T0qRGBkK7UmdZn3Or
         mW3Ah2VVaIhv0xetz7SQwfwzQwshbrK2W8OmbVM6HRDEjmOb8fvEcHJZpFlJr3+JZy7Q
         RWFsWRk4PrFjekSSE/nupQVGp1WjIku3ox8gJ+R5hL0o6ehOiUwLyfH3R1s+b2B4Xe/B
         GzPM16XMt9to9UMjcEzyLCsyb8AocZgiWs42KSPiZucoxgWUSxHU5JLtgGmlcPXIgsx1
         GcmfaLe0JnQsXkmqlV+JXDOxNkpoDZryh7mttFbJKmq3u2xWpi+YyRzFYXSpROSg4QSZ
         zecA==
X-Forwarded-Encrypted: i=1; AFNElJ8FCspBztfIuPdRrTMGUddc03EUm9L7HLHZsCi+x7y6z2bhWGJids+gPWTaAqyslSJ6IOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFwxlhM820St4I7EJlHsH9ETOVl1x9r3aNa249qMOpB5Mhq+3d
	WBzNPVGRJxnhfm1UC+mGTRLEyITsuU4JvcLp5efP0ME3cB0GbYt++Z7hLFZn+93bQxub
X-Gm-Gg: Acq92OHghtJvX/w9yL67u1kB4IpQQ2qvvCPzixTF+L0itD81hM/ui07T286gKBGsMvS
	d4p1386rAlX+oFeRIvP8xC2V+8yAY2g+8KKt0gCo0LhPDW0q+p2ifQkTDE98PKZZ0msv6G3jybK
	B2YH/b3fjQXmfiEUdNKzKJCPMAb5nj7vnn1cS0s1rjkSdpjAYRspb4pPQu1pIrpvLGdCJhHx5js
	sc5kK1l/7smzfgo238CRRlzxGRDmICDXob0w+yN3oEKh3udcHUdgR8R+yUakWkg+K2AdqBJmBs+
	j1EI+RYukVqoP+OCejJ+ifAOW7z4GRf+yf2dxcR2HlLt+e/VwZypfeNikMrOISnZSE1gTkQNGt7
	M0Cmzhw/cLg1yLanK7g6pCOSpK+X7f9da0/ZiGg1RrDwQtR99EoVpi5PW/zVFWhwxaK8S9D39DN
	oQMyRTpmIaaBcsXRisnDUlh8NTpL9dFNOPLIq897GZVGvULUNLE+mVSr1EOCVhlWjQrx4XkX/f2
	C7zseRHIVb7lmnGljYcDhjEGQ==
X-Received: by 2002:a05:690e:4144:b0:65c:27b5:414c with SMTP id 956f58d0204a3-65eae175db1mr577751d50.5.1779332368618;
        Wed, 20 May 2026 19:59:28 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86c850sm10092743d50.1.2026.05.20.19.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:59:27 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: tls: fix async split record handling
Date: Wed, 20 May 2026 22:58:38 -0400
Message-ID: <20260521025840.976378-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BPF sk_msg apply_bytes splits an open kTLS TX record and the
selected AEAD provider completes asynchronously, tls_push_record()
currently returns -EINPROGRESS before reattaching the split remainder.
The peer can receive a truncated stream and the detached tls_rec
remainder is leaked.

Patch 1 keeps the split remainder rooted before returning
-EINPROGRESS, continues the BPF verdict drain loop after queueing an
async record, and waits for already-queued async encryption if a later
verdict iteration must return a hard error. That last part addresses
the return-value masking issue reported by Sashiko on v1.

Patch 2 adds a selftest covering the sync and async providers for the
split-record path. v2 also checks the BPF program fd before attaching
the selftest program.

This report and patch were prepared with AI assistance. The generated
analysis was checked against the current source, the reproducer was run
against vulnerable and fixed kernels, and the fix was runtime-validated
on QEMU/KVM with a KASAN+LOCKDEP-instrumented kernel against net base
5db89c995. The pass-then-drop BPF probe that exercises Finding 1's
failure mode ran clean (no KASAN report, no lockdep splat).

v1:
https://lore.kernel.org/all/20260515151556.189841-1-clusk@northecho.dev/

Sashiko review:
https://sashiko.dev/#/patchset/20260515151556.189841-1-clusk@northecho.dev

John Fastabend reply on v1 (confirmed Sashiko's return-value masking
finding is a legitimate concern; this v2 is the response):
https://lore.kernel.org/all/huduxtn6parzgiaf5cyiyrrvjjvx6jsdedowvrd4nkwmuyeind@j6migjgofh2i/

Changes since v1:
- Preserve the later hard error from bpf_exec_tx_verdict() after waiting
  for any earlier async encryption queued in the same verdict drain loop.
- Flush completed async records after that local wait.
- Check bpf_program__fd() before bpf_prog_attach() in the selftest.
- Leave the __SK_REDIRECT socket-lock-drop finding out of this series;
  it appears pre-existing and should be handled separately if maintainers
  want to pursue it.

Christopher Lusk (2):
  net: tls: preserve split open record on async encrypt
  selftests: net: add kTLS async split record regression

 net/tls/tls_sw.c                              |  40 +-
 tools/testing/selftests/net/Makefile          |   5 +
 .../selftests/net/ktls_async_split.bpf.c      |  24 ++
 .../testing/selftests/net/ktls_async_split.c  | 393 ++++++++++++++++++
 4 files changed, 454 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/ktls_async_split.bpf.c
 create mode 100644 tools/testing/selftests/net/ktls_async_split.c

-- 
2.54.0
