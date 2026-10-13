Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BE413D69
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887953; cv=none; b=X1VDNgQhlbsy0X5j6Y4L7TXU4/7Sk/oF3zqiMWEBrO+dK3qG0/8mxULpXtbjmI4U9+vZFzeoOblZZRXxxd7uPrJtD7RmAsZxcCiL96wDC+z/FG9wQBycV0jzLnyIVlO8ZiWC7L8o0pTeja57cNQhFE3e3HRLPeFOpu/l8ooSIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887953; c=relaxed/simple;
	bh=MOY5s2x3l4fytmxVNA6OCa/Ehzog/oyOEDrzzWNi6Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkQhu+ILCdf4hMahlNHPHZJCQJSu5ZGQBLiqF8uqWfzucKtabhvaWM4qIIPLO8nPfdrqegUgL4cSCUtDCtpluEI5OlObAZr2djzRJA9r+uON2P4rR8cxarp87JovugO41pUXs8GSck7yOlR7kUwobyMggQqJl9opRhWU2SaV5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=G8St/8lV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="G8St/8lV"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2e36c3478aso359402666b.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791887949; x=1792492749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wcYYVZ6kSKJctnaWoWaxCg0rByraUo6R00V4/dmaqd0=;
        b=G8St/8lV4Ysm5FKhvQ5kFsqlOJV3853Nwh54lp/zRIVEVe/5s84a1G01jwxnrH2JIj
         cjuMxca1nRQVRquXN52tayKRW4ERlV7nHhDxvA401NbSXU5cfvvy1tK0CwefN5toG6yL
         BvMDto3qESfe9dVhZvAGbbWLYrXB/j5WawP9qM2/vIit/HPOpF6qHU2+2qMrEV9rPPBL
         fkqyY1xKyj2jNMvyUbaV11NyFhvMZNLixVHvC79a8vZkaZDWUmjbWcuiRGDUDG+fpJwS
         UQ8jb24oUHj2pJKmulLplOCk7TLlCJDEci4zZHqC6KBTGcUaUDKKbaiSkS/Tx1GVWe4e
         Jurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887949; x=1792492749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcYYVZ6kSKJctnaWoWaxCg0rByraUo6R00V4/dmaqd0=;
        b=F7Z/TVQNIxyZXAdwqxbjLokGrFO0Rbr0bg9R7Fszh1OpHmxXRE7AKuqRqX8tS/fgQE
         3iGF17HKjNx+ivsfmA9NFoQa22da3vo54klZ82QDLn2homC+p68zlZuNN7P1mlJjZLvw
         frRaqmNyQqPjtwIWZ8EveSsQxHtZ9G/2bqXxFo6YskNzYKnt4a3Q2EQLI05Fmq1QhRok
         L4imSOgWml//uQHMg7/vXpmyyUUoOGrVgB/RcEeCM7049pNoxJYCaDNMCqYVtSwSN+hb
         /Qf0zp/TNL86HcbCb19BznHEf0eS6izOEolEGG+84p97G9auoCPjSVeCD+C7QK01FI4H
         +XNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfirKpMUaW9nyGSXgy0hgGpIVDwBAXbg7BaanqGIm7B0yCw45q64M5g+R3lnnPQujzNZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQRmzShr3SNcXM51DuDmFvFQolyelBDBQ1GNiUiRGeqnb9mAi5
	Kzy/bgoCe1SqTDKxzqvU1lu6u8b8gkHImJHvW+c4gkSqIy/Ry62gajDdJJ5zertXmmw=
X-Gm-Gg: AYBFou2FP92G3EiPR+RN7isuZhkagteJAb66uFv00Zae/277M2gkGVhLuXxjMIgbh1h
	wAiRJaJ3UOf0XxCPIc1UZVf0Pvps2iLNlZh+akI7D6VKK9+HyjLsOvu8baD2qcWwsXMLpU6r2yd
	694JFJjETLBkaKGUZES1Yevall5kSmODkdL21w8eEz2W3HdTkxECQe52qWifha9GrY60VF3cZ4X
	iDELwgAAYnvbJ97kksctQNIP9agMOi+0c/aijqDkwukUO7ZBaMc4CjqI6UJLUnGSNjAqorR3V2g
	v5cUsulDyFsm+RB5bmSHDiJX+zWFgV/DWid7NjMXGQshfPxjkCIPZjDiQXAk13+blo+SYGwGANY
	EQAQUahBpx/O1kBTS2qac57zuIOtK6QmfLVIi2FxNK+j1WOj7nvkDdYfyhUPGiQ+NNJ1jvRG08t
	gi+xRCekbLhX4l6gGfFRJUeyE2i+0zeXYwrfxnP49UKSWFrnbSJ+B9FTIQ+B+Dfin9UDFTb5bSs
	e2tKIUM0Ysf9Sc+oufyCyoPtUNQFQ/5fS1J
X-Received: by 2002:a17:906:dc8e:b0:c29:4513:f6fd with SMTP id a640c23a62f3a-c31aa081b78mr1169935566b.35.1791887949584;
        Tue, 13 Oct 2026 03:39:09 -0700 (PDT)
Received: from 8951987238ab.arnhem.chello.nl ([104.28.187.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ac62a7sm552462166b.63.2026.10.13.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:39:09 -0700 (PDT)
From: Willem Ferguson <wferguson@cloudflare.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [RFC PATCH net-next 0/4] tcp: carry a BPF-chosen identifier in TSval low bits
Date: Tue, 13 Oct 2026 10:39:02 +0000
Message-ID: <20261013103906.2660384-1-wferguson@cloudflare.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets a listener encode a small per-connection identifier in
the low bits of the TCP timestamp values it sends. The peer echoes TSval
back in TSecr, so every segment the peer sends after the handshake
carries the identifier in its TSecr.

In Anycast networks, mid-stream path changes caused by BGP route flapping
or ECMP shifts frequently deliver active TCP packets to an ingress Point
of Presence (PoP) that lacks the flow's socket state, resulting in abrupt
connection resets (RST). While protocols like QUIC avoid this using explicit
Connection IDs, TCP lacks an in-band routing token to help ingress
nodes identify where a flow actually lives. To address this problem,
we propose embedding an N-bit data center ID into the lower-order bits
of the TCP Timestamp option (TSval, RFC 7323), allowing edge load balancers
to recognize misdirected packets and steer them to the correct origin data
center holding the active session.

How it works:

 - tcp_ts_id_bits (per netns, 0..8, default 0) sets how many low TSval
   bits are reserved. The millisecond clock is shifted up by that many
   bits.
 - A sock_ops program opts a listener in with
   BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG and is called with
   BPF_SOCK_OPS_TCP_TS_ID_CB for each SYN, before the SYN-ACK is sent.
   It sees the SYN and optionally returns the identifier
 - The identifier and width are stored in the request socket, then in
   the full and timewait sockets. Incoming TSecr values are decoded
   before RTT estimation and PAWS use them.
 - TCP_TS_ID reads back the identifier, and /proc/net/netstat gains
   TCPTSIdAssigned, TCPTSIdDeclined, TCPTSIdSkipped and
   TCPTSIdEchoMismatch.

RTT estimation on the encoding host sees the same decoded timestamps
as before, so they are unchanged. On the peer, PAWS keeps working too;
the only effects are a shorter idle limit and a narrower tolerance for
reordered segments, both described below.

Scope and limitations:

 - Passive opens only. SYN cookies, microsecond timestamps and peers
   without timestamps are left unencoded.
 - The peer sees a clock running 2^bits times faster. That narrows the
   real-time span of its PAWS window, so the width should be no larger
   than the identifiers need.
 - Peers that keep ts_recent for the RFC 7323 24 days (e.g. FreeBSD,
   macOS) stall connections that stay idle longer than 24.8/2^bits days
   (about 37 hours at 4 bits). Linux peers stop enforcing PAWS after
   TCP_PAWS_WRAP and are unaffected.
 - TCP_REPAIR cannot restore the identifier, so hosts that migrate
   established connections should leave the feature off.

All of this is documented under tcp_ts_id_bits in ip-sysctl.rst. With
the sysctl at 0 (the default) the only new cost on the established fast
path is one likely() branch when parsing TSecr.

Questions for reviewers:

 1. Is encoding an identifier in the low bits of TSval acceptable in
    principle, given the trade-offs above?
 2. If so, what feedback do you have on the implementation?

Patch 1 adds the encoding and decoding, which stay inert until patch 2
lets BPF set an identifier. Patch 3 adds the TCP_TS_ID read-back, and
patch 4 adds a BPF selftest.

Testing:

 - A kernel with this series and tcp_ts_id_bits=7 is serving production
   traffic on a few Cloudflare hosts and assigning ids to all CDN
   connections. Key TCP metrics on those hosts show no difference from
   hosts without the series.

Willem Ferguson (4):
  tcp: add plumbing to carry an identifier in TSval low bits
  tcp: add BPF_SOCK_OPS_TCP_TS_ID_CB to assign a TSval identifier
  tcp: add TCP_TS_ID socket option
  selftests/bpf: add tcp_ts_id test

 Documentation/networking/ip-sysctl.rst        |  38 +++++
 .../net_cachelines/netns_ipv4_sysctl.rst      |   1 +
 .../networking/net_cachelines/tcp_sock.rst    |   2 +
 include/linux/tcp.h                           |   8 +
 include/net/netns/ipv4.h                      |   1 +
 include/net/tcp.h                             |  58 ++++++-
 include/uapi/linux/bpf.h                      |  15 +-
 include/uapi/linux/snmp.h                     |   4 +
 include/uapi/linux/tcp.h                      |   8 +
 net/core/filter.c                             |   2 +
 net/ipv4/proc.c                               |   4 +
 net/ipv4/syncookies.c                         |   2 +
 net/ipv4/sysctl_net_ipv4.c                    |  10 ++
 net/ipv4/tcp.c                                |  16 ++
 net/ipv4/tcp_input.c                          |  61 ++++++-
 net/ipv4/tcp_ipv4.c                           |   1 +
 net/ipv4/tcp_minisocks.c                      |  27 +++-
 net/ipv4/tcp_output.c                         |  15 +-
 tools/include/uapi/linux/bpf.h                |  15 +-
 .../selftests/bpf/prog_tests/tcp_ts_id.c      | 150 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |   2 +-
 .../selftests/bpf/progs/test_tcp_ts_id_kern.c |  32 ++++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |   2 +-
 23 files changed, 459 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_ts_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_ts_id_kern.c


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
--
2.47.3

