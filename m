Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612081A6808
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223487; cv=none; b=lBYuRTZiHN8e7twstcaFzo+naMxnxVhOmFYiz91ukYWoh7mJKxOpPO1zM7xJlmrttyHbXjWdLmOndVHUoSkTPg83vdspz7uWC9SG+JJpT4PvU9W4ylIKfyt7fTNS8wCLJjVUDVqCmlXKXVdDVloqfJYgXS6DgZBZGnTqkK6ZLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223487; c=relaxed/simple;
	bh=nrJEujpdtWenU75xWFosdMAwzUUl2fVjUsBe4NrU64U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pdwkJ0+PHIhM7JAIFUu5C7xokUej2eHgAcBDInn3gnDBD//EgOa5ZjtMnZXBo5RIDOc+wbUj1HpuUxLUy8dtdnIrREdDIydkae1ro88/QfqDxaEvb//g1VUA7BOP60KHstK4JiLEjMNvlXYdUSyGGZ6o+49DFt+zhyf2sH53cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYOKrmbp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYOKrmbp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so7160655ad.3
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 17:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781223486; x=1781828286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jw+mb2Oix6vlzmX2fEritHAtIrKXijXb9hNuLq3RszM=;
        b=eYOKrmbpLYV8EgRFUXPJr2IIoaPZJapAFc+fyNDYgCYdJC9ukFnDbWfHt4MvtmYlFp
         WpW+rGYDhm4emvSvGO4d5Z32nTglwh6gPsOteq+WgMBB/Cns6Y9xNCJcSfTYWAb5dr2h
         u90gCdsL9Ugi4Ri/qV2PtTFgdSvFcpohBXmAbFzz1bF1EkJCOC7p1XThW7b0G8gLW70B
         acmxTYL7LbufO2Tgdjjuu4jEqjdoxuBjRJeY7V/ch9A5+LggZdBTSpkfFyEyQaM7zEhX
         M4/jV1t/4a2TjV5FGc7mxGzXYHT8lKKKJk9owpWfJxXsrBcSgn6j26MjvY1ayj+4SeD2
         5n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223486; x=1781828286;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jw+mb2Oix6vlzmX2fEritHAtIrKXijXb9hNuLq3RszM=;
        b=GtSeGtW7YFvBZQdEHaLUd0Uk8yU2A6hHcIMH2z7D6CK/sOaz0PjK/rlsdBhEBNt2gp
         t+Om1YTeMA5XjPkn4lYHIP5vzKGJXwCi8zglj2dLiKltVKaNG25XhBaO0+GABEOdKaWy
         ttWjmNxhjAYr6zUoqPAy9IAdq9EfmdgVqvAgDANL2QCm+Fd/ELsBlSXDVBQ6Z5SIle+3
         yTB1Ty+9AGxeZOMAPx4Bba9pfF6Z3ioU6wKXOz9bGVblKimic2AHYraizf0IqjXX15DK
         wRj4YrymnES1rjMAd8UwUyLmRRf2YJtnTlCquCfWnYfNOJ8qyKiD54ZB9bKRNkX9uzRD
         nPew==
X-Forwarded-Encrypted: i=1; AFNElJ/UUDz6zxx42XDJS2mzlUc31d+7qATWj/cHNyxs2IfPdsgy4g89K7RACv5NwJnW1DHHYgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwJ97UKKt5CrXWma5rv5RcRYAOqR7PUVLrY6QwPdak6JRnM2b
	4ZlkOlqu8o9MQHJs4e8i4ehbfLi3ABny+H2v1cpdhifdxo4UaWV4eUPXmLCK8nBTh39k4lG8rGg
	DnM6HGw==
X-Received: from plbbh3.prod.google.com ([2002:a17:902:a983:b0:2ae:ceb3:f968])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54c:b0:2c1:f262:495f
 with SMTP id d9443c01a7336-2c41235c4acmr6889605ad.26.1781223485353; Thu, 11
 Jun 2026 17:18:05 -0700 (PDT)
Date: Fri, 12 Jun 2026 00:17:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612001803.23341-1-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp proxy.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have some hosts where packets come from special hardware
and are provided directly to userspace, bypassing the kernel
networking stack.

When standard socket applications are run on these hosts,
a userspace proxy is required to mediate traffic between the
hardware and the applications.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     ^                               ^
  userspace   |     |                               |
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|  virtual interface  |<---'
  kernel     | |   skb   +---------------------+
  -----------| |-----------------------------------------------
              |
              v
       +------------+
       |  hardware  |
       +------------+

However, even though the hardware fully supports timestamping,
the HW timestamps are not directly accessible to the socket
applications because the skb is consumed/injected by the proxy.

This series extends ethtool and adds BPF kfuncs to transparently
support HW timestamp on such a setup.

Patch 1 is pure net-next patch to advertise fake timestamping
capability on virtual interfaces (e.g. ipvlan, geneve, etc).

Patch 2 is misc cleanup.

Patch 3 & 4 add kfunc to proxy RX/TX hwtstamp.

Patch 5 is selftest to demonstrate how it works.

Note the test requires this iproute2 commit:
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c9a9f12aa619288fd3d4e16bc4b3c73b655a4efe


Kuniyuki Iwashima (5):
  ethtool: Introduce ETHTOOL_MSG_TSINFO_SET for virtual interfaces.
  bpf: Rename bpf_kfunc_set_tcp_reqsk to bpf_kfunc_set_sched_cls.
  bpf: Add bpf_skb_set_hwtstamp().
  bpf: Add kfunc to proxy TX HW Timestamp.
  selftest: bpf: Add test for hwtstamp proxy.

 Documentation/netlink/specs/ethtool.yaml      |  13 +
 include/linux/filter.h                        |   2 +
 include/linux/netdevice.h                     |  11 +
 include/linux/skbuff.h                        |  13 +
 include/net/tcx.h                             |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 include/uapi/linux/pkt_cls.h                  |   3 +-
 kernel/bpf/verifier.c                         |  13 +-
 net/core/dev.c                                |  39 ++
 net/core/dev_ioctl.c                          |  31 +-
 net/core/filter.c                             |  91 ++-
 net/ethtool/common.c                          |   4 +
 net/ethtool/netlink.c                         |   8 +
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/tsconfig.c                        |   7 +-
 net/ethtool/tsinfo.c                          | 123 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 .../selftests/bpf/prog_tests/proxy_hwtstamp.c | 580 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/proxy_hwtstamp.c      | 234 +++++++
 21 files changed, 1169 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
 create mode 100644 tools/testing/selftests/bpf/progs/proxy_hwtstamp.c

-- 
2.54.0.1136.gdb2ca164c4-goog

