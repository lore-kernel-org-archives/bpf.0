Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76437474A
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809852; cv=none; b=BWMLHcgHlEjUQBzaYJdgLNlHzRhcwMJ8NWWVzVJReiH93G6AezWK9BBTL/4y5PDjUirBFWP188M3/n/UNwATj0tQZvTi3dV5M7eWEO65y9KXtvBtsZy3/GcQ/Z2i4ptHEzX61zVbkUr9c6xKIJgFKdXzwtkNSzLhWWvsIMk3Rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809852; c=relaxed/simple;
	bh=SuNCKboR9/qMnKV199RmrKzsF4XnE5gzMhvdzv4lxUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIL/wVlsGQJHqkFnJGksgYnxzUfwuFVWbHdc+3xWcrUm3An8XeqZfQJ2W6TKWz0Qpt1K9FOX5jDsoa/2vRDbLxZbs/GGiOBkiOq357G7CpvpZy3w9G30SQajat7PSjO3izUheKCP/Q3sfLfe/a/xRhWlcamBxrp/grnpPxRqF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkvB071C; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkvB071C"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso43383245e9.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779809849; x=1780414649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mEu5haSOg9MswhbLQuLwhfuoJ04JYV0iIkWmF1VBvMA=;
        b=WkvB071CxkUfIm/2/yI5hloTKjLTL9aaMIzQmYu8NKsiupx0NfvPTxnCKXcq7QY3GH
         ed3SSIcHGmE9aVUpahwQkEKOhoDXRkdWTJSxZtaVKxhUPCpsqSOANAasRbqAHLGs+8Pz
         5Y2LXEG2AFvNm0Eom0xeKbwyjQSha0TUEL9kZLdCbw1PvtmtH/QCa3/DeKoHxKb06Wn2
         KxN4TX/yk13qAnMSVlcmTMOVeSHzgohreF9HRjg1G9Brx2xJlcsSZRxacwTNV8Tw8FOJ
         0FGpccpUvOh9KJy1RrTIxVLlq7FEOQ6CLxLZiPsNw0AyMPxwrKYbE2Lb90+cpu2s9utL
         IDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809849; x=1780414649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEu5haSOg9MswhbLQuLwhfuoJ04JYV0iIkWmF1VBvMA=;
        b=hf895JkN0X/A1ICgtMYslZG/hWyIUcpPv7KLjJbjazFtYFXfYY+mGog6LPd0yndYK2
         Rac7ELLvswqQKHu2qynjjvX8zaQkcgD42CLJihqJrto86vIR8sR3tUivrqaHEFYNqSmX
         qI8bdPJX5dBk0Tw7Jye4uU9EBCXRcr4RpzTJqEYdAv0nSGQcdjWfLp0zX6JsZ6EZasdf
         tOQZQBw19cRMBjqvhHC8WeOoQ34IPz0xkNoeE/31mqlQ0s3FpyfDLPCW654lfHB1BvwE
         f5bkacJ8EpmBBpHUYF60yw4WfuU3qtltSKilDeNVcnjrAp/qbFZuOSP1ho765QjU5qsi
         dKJg==
X-Gm-Message-State: AOJu0YwkEPxSTvxUObNp8G9/4S4Qm3h1+iJtrt7AjD6EBMJzkI+cZCOn
	WGLAx9sQeE+SEuiRbzwE87yanyESxxG+2mm9RffTO2f2SRZRRQ+IknD47KRcIniS
X-Gm-Gg: Acq92OG6eRzW3I0RQK1ekYBhOwDlsnMXt6CRfmleIF8HUWc/XCdGlNbb8Vk2DsJYUC3
	lVWl66dFdQnCcRlGsbzoxcTvAleqfJjpyrfCijDZzyVURjcFTp0UOGpWDKNBFG7blnmmayOoq7T
	200pxsIwD6OsudxPmkB/URfFpiGC6N5pVirWJrADUV9f0KHhxEVdG3H5CRqeUD8ETLXB151+vKc
	p/29INP8kdZ0EcEO9FdzwGy3ZZliivJoFACmcCZlEgFOwARHbiYA6U/ezSPuuA7n+YhueJ1fa6f
	9CAX7d24/B2mJd4vL01etn3uIaDHmxGgfP3gUjTKTYPDE/KXQiy4ZXYEuIkX2Clg2Jga5aUEykW
	3GascgOEIWyahgzEf1bqlK73p5mMXMcf4gd8Rp6B1xOXhZNmYW/lMfwZAYE5SDp0f2k3CLyVcv7
	PxsnIfHalO7VgVoa2z+tJzWxAx0L0=
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490426cd8c4mr338065445e9.20.1779809844415;
        Tue, 26 May 2026 08:37:24 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4907df9edeasm1083655e9.9.2026.05.26.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:37:23 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 0/7] bpf: add icmp_send kfunc
Date: Tue, 26 May 2026 15:37:01 +0000
Message-Id: <20260526153708.279717-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v7 of adding the icmp_send kfunc, as suggested during LSF/MM/BPF
2025[^1]. The goal is to allow cgroup_skb programs to actively reject
east-west traffic, similarly to what is possible to do with netfilter
reject target. Applications can receive early feedback that something
went wrong during the TCP handshake.

The first step to implement this is using ICMP control messages, with
the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
than a TCP RST reply and will already hint the client TCP stack to abort
the connection and not retry extensively.

Note that this is different than the sock_destroy kfunc, that along
calls tcp_abort and thus sends a reset, destroying the underlying
socket.

Caveats of this kfunc design are that a program can call this function N
times, thus send N ICMP unreach control messages and that the program
can return from the BPF filter with pass leading to a potential
confusing situation where the TCP connection was established while the
client received ICMP_DEST_UNREACH messages.

v2 updates:
- fix a build error from a missing function call rename;
- avoid changing return line in bpf_kfunc_init;
- return SK_DROP from the kfunc (similarly to bpf_redirect);
- check the return value in the selftest.

v3 update:
- fix an undefined reference build error.

v4 updates:
- prevent the kfunc to be called recursively and add a test (thanks to
  Martin).
- do not fetch dst route when unnecessary (thanks to Martin).
- extend the test for IPv6 (thanks to Martin).
- use SK_DROP in examples and use non blocking sockets for testing
  (thanks to Martin).
- test when the kfunc returns -EINVAL (thanks to Jordan).
- add the kfunc to bpf_kfunc_set_skb as suggested by Alexei.
- guard the IPv4 parts with IS_ENABLED(CONFIG_INET).
- fix a wrong initial value for client_fd (thanks to Yonghong).
- add documentation to the kfunc.
- to Jordan: I couldn't include <linux/icmp.h> because of redefines from
  <network_helpers.h>.

v5 updates:
- kfunc name is now icmp_send and takes the control message type as
  parameter for future potential extension (daniel)
- drop the net patches to route packet since now the kfunc is limited to
  cgroup_skb and tc progs (daniel & martin)
- linearize skb headers (sashiko)
- zero SKB control block (sashiko)
- bind to port 0 instead of fixed port (sashiko)
- poll to wait for POLLERR event (sashiko)
- do not use ASSERT_EQ in CMSG_NXTHDR loop (sashiko)
- fix comment about byte order (sashiko)
- fix endianness IP address issue (sashiko)
- add forgotten cleanup_cgroup_environment (sashiko)
- let packets pass in recursion test (sashiko)
- clarify evaluation order for recursion test (sashiko)

v6 updates (all from sashiko):
- bring back the net patches to route packet since tc ingress needs it.
- rename the ip_route_reply helpers from fetch to fill.
- call pskb_network_may_pull on the cloned pkt.
- check explicitly that we received one and only one ICMP err ctrl msg.

v7 updates:
- use consume_skb on success path (stanislav)
- replace recursion protection with CPU_ARRAY by checking the nature of
  the sk (daniel, offline)
- use reverse xmas tree in read_icmp_errqueue (jordan)
- use ASSERT_OK_FD instead of ASSERT_GE whenever possible (jordan)
- add a test for tc (jordan)
- better filtering from host cgroup test progs (sashiko)

[^1]: https://lwn.net/Articles/1022034/

Link to v6: https://lore.kernel.org/bpf/20260518122842.218522-1-mahe.tardy@gmail.com/

Mahe Tardy (7):
  net: move netfilter nf_reject_fill_skb_dst to core ipv4
  net: move netfilter nf_reject6_fill_skb_dst to core ipv6
  bpf: add bpf_icmp_send kfunc
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
  selftests/bpf: add bpf_icmp_send kfunc tc tests
  selftests/bpf: add bpf_icmp_send recursion test

 include/net/ip6_route.h                       |   2 +
 include/net/route.h                           |   1 +
 net/core/filter.c                             | 109 ++++++++
 net/ipv4/netfilter/nf_reject_ipv4.c           |  19 +-
 net/ipv4/route.c                              |  15 ++
 net/ipv6/netfilter/nf_reject_ipv6.c           |  17 +-
 net/ipv6/route.c                              |  18 ++
 .../bpf/prog_tests/icmp_send_kfunc.c          | 243 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 172 +++++++++++++
 9 files changed, 563 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

--
2.34.1

