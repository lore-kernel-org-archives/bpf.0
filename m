Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EB13957E
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312443; cv=none; b=BlH8ntQZj/xxylY6T/xikm6/ecAxTEeWFli8Vmd1+Yk1BuJprzD+JKpZ/BcCBSHdlVxYbM18r1RGr1+BLKFV4VlyTvL2a86yO4Pa4LgTavF3bjnpGpcT2sPcB+GSt2ex6HUqwMfqyDxOJatSi4h7eH0sjolB+V7OimX5Zs/WowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312443; c=relaxed/simple;
	bh=JcOgNfYX5Fr+NIiNpGfDBLZGynCBhQ9Kevw5R9SUXOI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rnvp1nxzxsS2E7E+MMVWwkp4sQ3o+b8U70TzJAPT5EoixIcwmAbLr9MdafAkfNjCMOiqnZKBUSLSlxhI39W0eAK4e5+FXIY8o98+1AziVbgyhDxfayXje6ROf9cfdUg7rj081MojwaLSd9vzlVAnJIem6bmf+kPYSKqY4BM+gsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjSeLpfY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjSeLpfY"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c10cd7df22so21416915ad.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781312442; x=1781917242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfnHQTzprvfZIViqMRRKupB/GjOqKriHJyW+HN00hFg=;
        b=IjSeLpfY32buFZ58u0xA9jovQllopEI9dytbx8tDtAb7LkX1ajd48WvT/P8U2MxclI
         /80n/PLTcfrPa7ZEa9X32Rc3BxJp5V+e4pqQ+fzcKOBZeLZBxtwatYnWjqDz1NW8pX9k
         qjarmiykamtTTxLBjPsOUHRnaoQB1ptD8MHz8I+0MkRWwTWHFwrMqKAVpXbh1HMFEX8K
         x00WiBpPJ1TA1JhQAJ9vYU3GeRNkUHpIndD8oYMKvFkGu01YHBzhxXDvPcGCGc021uQK
         UYf6agJLkz2SEVoOX9kex2WjNRSMzLOIOgg6u4zyVgvnAnGI1HL5wFfH92Nyx74v3q4k
         F3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781312442; x=1781917242;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfnHQTzprvfZIViqMRRKupB/GjOqKriHJyW+HN00hFg=;
        b=B835Myam2DmUFV6RkgOwOiB24oLQUWoHx7qAi9EcohAnBe0PcCDPngKRsajxapJpwk
         yRAmGe8cQYihUXu+1kKFx6Z7t/gp7jMt/+6DtMJuMraGdA6ouLfTH9DhomUeJUKLOCXL
         dchV0FWgG1TcQ0E7Kc+2hrfwZkSk7BiAxwd6ebw5el7fnemxZCxhvtucnLi/EsKY4LAk
         YwUHl004J15rLmwu9dkFvNv/2nVoy8Jz6oBz9hqdvWPk+hnXhUbJVOqtkveY4nujyQJV
         aqReNEo5f2fF+FFoQ0jbdsVgfhMRiiCqmth35Lbc5WxM5lVJByBkbc0N+wCgy6uwZ4Qp
         WcFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fG4XU50XAfx0mFrjXP9UV9osPFgon9anNXoBkkvtOP1MlCL0UpYX3xswpmqefFw7+L2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkjeORssIWmf24FngT4mIH1kHx4pvEj5sb5xbx5Yuqp0Lj5UJ
	P1nf3EfPuVboqbok8ehYWpgo4fT0QjGSj+RyjK72BYU9V5DTUbF3BDwhOT/IeE0VPUroaaRurvA
	pl+sfCA==
X-Received: from plbjx8.prod.google.com ([2002:a17:903:1388:b0:2bc:c1af:322f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b47:b0:2c1:98b7:ecf3
 with SMTP id d9443c01a7336-2c41235e35cmr60019365ad.23.1781312441612; Fri, 12
 Jun 2026 18:00:41 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:59:57 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613010039.1362312-1-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp proxy.
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


Changes:
  v2:
    * Patch 3:
      * Remove __packed and use unnamed bit-field in struct bpf_hwtstamp (Alexei Starovoitov)
      * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)

    * Patch 4
      * Remove __packed and use unnamed bit-field in struct bpf_tx_tstamp_cmpl (Alexei Starovoitov)
      * Check !skb_at_tc_ingress() in bpf_skb_complete_tx_tstamp() (Sashiko)
      * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)

    * Patch 5
      * Use scm_timestamping64 (Sashiko)
      * Correct saw_tskey check (Sashiko)
      * Fix retval check for bpf_skb_get_tunnel_opt() with (int) cast (Sashiko)
      * bpf-style comment

  v1: https://lore.kernel.org/bpf/20260612001803.23341-1-kuniyu@google.com/


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
 net/core/filter.c                             |  98 ++-
 net/ethtool/common.c                          |   4 +
 net/ethtool/netlink.c                         |   8 +
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/tsconfig.c                        |   7 +-
 net/ethtool/tsinfo.c                          | 123 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 .../selftests/bpf/prog_tests/proxy_hwtstamp.c | 588 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/proxy_hwtstamp.c      | 236 +++++++
 21 files changed, 1186 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
 create mode 100644 tools/testing/selftests/bpf/progs/proxy_hwtstamp.c

-- 
2.54.0.1136.gdb2ca164c4-goog

