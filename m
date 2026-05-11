Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD63C3C02
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489644; cv=none; b=jufbznVoGyNXKoKI6Pu1VRcf7HEgz5CZ08nkMiOKsIM4xqXNzmgQ29zBOxty7K0IABT4+4P1gH7oZ5Dnrs5rMN0HW0SUJL5ERLxH39194j/kJa8bc7JeCQiqYdPwYULA/atjZVkhsr/9X+6w1tVL+/PsTCV9FCgAia3H8GWUbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489644; c=relaxed/simple;
	bh=hWHJ518lQk1XWA2g21E9PVWg6raFRZeCI87Kgqks3tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KnstOv69Vi4MzBphlr+1eGSgf8xALWQDjbZfbC0fML5p9I6gc+w44xXDO2ppV4Dgy3n6TOeR0FIo60ij0FQljVUooUXUbTbjabM6IGFCmFBRSJeYwQp1qsnTOz3gQRITJYoATM0rLDLjZXWUQrfHMFyygMZvxlvUlzX6fBczRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eO1M92uj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO1M92uj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44a14580111so2963459f8f.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489641; x=1779094441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKATXbbbik98T4osySgXFD363jQScfFmEc0e0hzkEd0=;
        b=eO1M92ujDF40ZVb4nCQhTzXwxGjIBArbTgvcOU+O5CAW+eX2TmZfrkamNF+eS/z8up
         6K++Mg9hy3v84VAYmlCzrH0pMhYwhwx+jp56b0OGtN45asGLyDgueL462xMTwPAwVmrl
         AgcNXz8oImHfgENRZW+gqcum62y68/1L/QW023WBFVbvWEhThjUD3mvJfD3VOCuAdIR5
         XvXTVkDb/F05xlvW9rg7mjXaIWIYLQPRaa8LHZAsJ5yv21l8Wg8iFYK3GYqyceVAVIlJ
         oBVZ0MyNQSL4MFyZH6r4vhODhYTltp0SQxbaULOAllmQD2PLOp7NEklwqaSza6o30V4A
         hsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489641; x=1779094441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKATXbbbik98T4osySgXFD363jQScfFmEc0e0hzkEd0=;
        b=pW30cUVwEDnlFhNcX+DMn4F2HVULkw+0pnjeFWNb/74743A/+W2P2SAZgJYITqpqGy
         wk/2L4pIb1EIJJtBSiSNjjTcQuHKELEWWWAEpsawrDn0eOSbISdosrOVbPlz31aZC6y+
         S+JY6gkJIRIdr2gqCMt5WgrUtKse26c4Nz70gRryaIqaUmXCyWhNBHpe5/rZRCFxGbdj
         fVRjgxJvJGQrsfUpSwmfqHZRNVEcOS0BD6eVURqbs+yjNcE4zMaNTaiPETgkSdvZzTK1
         hGhg1BJFH625iR+/G+BZug92U61mqjPwnKe0pcV6rq64JNjC/M0MRFgsm1UitntBnf0X
         a9tg==
X-Gm-Message-State: AOJu0YxFiCoBxNNvxnJJ6YNpwSm9kppZWsc9uNa9XjOxR5R/cOmnXFLe
	dcW6S9XW0siv08g91mNT/Oexn25WzB+oXItLaaaYblMaiw3WlcHJ20IJUSepPuwB
X-Gm-Gg: Acq92OE5kt8tRQfJsKLYFpaYzWYW6Q/GCFkaln2EfNRc0oGmrIV0FlX51x30lfhCM8o
	SiRe3v1M/nGxvOcrqtXnhyI5A5ksmobeSeumOVR/DS6o62uL5s/vdMTuoufAWyOTlZh32aa8gJA
	9hHNOMM3M6es9zdlZhHXvX7aon4q5gdIwauoLPxoFCdkTuKNSU8JLZfKGn0At2mSgoMTgxlHug2
	xnnOQb1g0ZudDPVD6ek/5KoG2h+dqhtXF9bNG5VtGAIA5lIMmvyR97ylNIQaTvIe/zhtUZuwc0h
	uuf8JEmGhz3yxSeF34ynsMg6DvqluXkyqIy/oH80/cnf7IZsw8c5J+MvZmbMBHD+mWv3yEVDE2w
	liK6NchM0C3LZJq8eN5E+EzoTpWKaSf33uxhMHx9iSJVWe6d/SMOapAsb3CS4MEioHGd4m8qnqU
	pJWY9bj+PLzpEvE+/YAKaEex7IpKs=
X-Received: by 2002:a5d:5d08:0:b0:43f:ea25:c965 with SMTP id ffacd0b85a97d-4515d3dc1femr33335939f8f.32.1778489640164;
        Mon, 11 May 2026 01:54:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-454919c13c9sm23817156f8f.27.2026.05.11.01.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:59 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	liamwisehart@meta.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH v1 0/4] bpf: Introduce bpf_netpoll
Date: Mon, 11 May 2026 08:53:40 +0000
Message-Id: <20260511085344.3302-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces bpf_netpoll, a set of BPF kfuncs that allow
BPF programs to send UDP packets via the netpoll infrastructure. This
provides a mechanism for BPF programs (e.g., LSM hooks) to emit
telemetry over UDP without depending on the regular networking stack.

For reference, this was discussed at LSF/MM/BPF 2025[^1] in Montreal,
again at Plumbers 2025 in Tokyo. Liam Wisehart mentioned this work
during his presentation of BpfJailer[^2]. Then it was also discussed
during LSF/MM/BPF 2026.

The main use case is to be able to completely dispense with
agents/daemons for BPF programs after startup. In the case of
Isovalent's Tetragon, the idea would be to be able to emit security
alerts or export data from BPF even when the agent is down. For meta,
according to Liam presentation[^2], this could replace logging via
ringbuffers which created cross-binary versioning issues.

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration), for example used by the network bpf_crypto kfuncs.

Note that network program types should not encounter recursion issues as
netpoll bypasses the network stack and sends directly to the driver.

v1 updates:
- use kzalloc_obj instead of kzalloc after tree wide update (alexei)
- extend bpf_netpoll_send_udp to all program types (mahe)
- correct documentation on send return value (ci bpf bot)
- add IPv6 tests as a subtest (mahe)
- we had some discussions at LSF/MM/BPF 2026 in Zagreb, demoing how this
  could be used, generally agreeing we could move forward with such an API.
 
[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lpc.events/event/19/contributions/2159/

Mahe Tardy (2):
  selftests/bpf: Add netpoll kfunc IPv6 variant test
  selftests/bpf: Add netpoll setup basic tests

Song Liu (2):
  bpf: Add netpoll kfuncs for sending UDP packets
  selftests/bpf: Add netpoll kfunc sanity test

 drivers/net/Kconfig                           |  11 +
 include/linux/bpf_netpoll.h                   |  38 ++++
 kernel/bpf/verifier.c                         |   3 +
 net/core/Makefile                             |   1 +
 net/core/bpf_netpoll.c                        | 209 ++++++++++++++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/netpoll.c        | 139 ++++++++++++
 .../selftests/bpf/progs/netpoll_basic.c       |  47 ++++
 .../selftests/bpf/progs/netpoll_common.h      |  64 ++++++
 .../selftests/bpf/progs/netpoll_sanity.c      | 135 +++++++++++
 10 files changed, 648 insertions(+)
 create mode 100644 include/linux/bpf_netpoll.h
 create mode 100644 net/core/bpf_netpoll.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netpoll.c
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_sanity.c

--
2.34.1

