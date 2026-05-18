Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16D40DFCC
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107341; cv=none; b=k3rzYZXWr7sAn7k9tNxL1KeFFt5Iki2Ip4ra/1Fj3PWf5MW6nD4BWVSD7eHH8p9eAjqnRZ2rTX/EnI487I9fr8drpKEIT/MY5hmI+F52ggUzXUGMrERRLJoFzcAEJwGQHkmFESRmCbP22YiTE46PLAgc1wLG1IJEnIy20YIvZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107341; c=relaxed/simple;
	bh=x1/KdkH948uDsLZN+TPq8Fn0u85r+3KGQ7Dz/dF0Pf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSkvBbksbua9A55VTTEkp0df3Pnu5iOa/dlhNKzf1gsUs+otvGM1otTeifLWc21+7LCwltccBlzzVREImkOVme8TQHQ8Up2QWhdRZJq8NdWhhP91nyNbMOR02xT/kbdjNqWhPhms7nWqbY1iyUFIEjtJZMw+g4s0e3fL2oA9KYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXKie+Xz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXKie+Xz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7645adbdso1414488f8f.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107338; x=1779712138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5HZfTGxzuF7Lu+NtHZ07U4frd9hqPt9a5u2U3vDU68=;
        b=OXKie+XzykG2MIXPbyRxBwicE8xV7MoLoYj8NShGo3wuwdKfP3uFUw8qLv7O81N4gF
         UDwfDq5zbyCIo0jzXnwGJx8gG1ZKFww5mgVPEDrmjmeAj2wyluifTc4p9IcUhYE0d/hQ
         lQEWoHJyytdxY5+tF1UNjv6A7Vei7C8TkXcXzCKqRsnTGsPjIIuD/mxsHCLY4BstwKcY
         oS/TXgxQqfWZM5HDDfeNkmx4cF6/hQO10dHA85RD5UbnCSvAbACfrHfSgJ8SSdT9vZoW
         guFeakJCpUqd8Ah0vpUwpesxIWxJlQipU+rOsyaq1f2Sa/kFQEY1veQHBt76CQDB8PAs
         KjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107338; x=1779712138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5HZfTGxzuF7Lu+NtHZ07U4frd9hqPt9a5u2U3vDU68=;
        b=L0yZhxU3k5xKS4yi4qTCMegSEhg/5Sb7Ma2JTkhrFwdTroQ63KF8fHdJmafNKgZvcV
         k99mAKI8tPMiADx/VN66ZTT0CC0NOjqQ74VvSy1Ao5fLK0iX+zhf00EgyQ2XXYthIlqs
         feX+ZrNH9sPzg/MPTeMogcNczF7Et+pTgReSq71a5qQ396asYj39ZcOzAabOePgxg3cY
         +2C2GplI3Prdy+tr7JqekyeNO/wrJnlFcQ/CXTOOywyiy1JiSMjYyF7Ad7JQiXAEa4QM
         i1xJ/ZpKR1tqFQVfCpzALVpDuUsBggiVfArM9f3MbK9tAsxKU5WUjl5VrI7n9vYeakT/
         fWXQ==
X-Gm-Message-State: AOJu0YyFlcRj+RNDNlQ0GerBnQrJEYYgzkgER2a7jh2tj5z18/ETbrql
	OIa7H+ohp2GDNFhYqlGMdzX72OTFIhMWIv+Rp2hujkmfLZlfcPAz9aIARsp3b18J
X-Gm-Gg: Acq92OGW85dv+TZ0jzOB+gBhKHs7powK9O5Pz25Uof3RRcKGUQIl53QImXkl1ewPkPn
	5OzTk4pEqLuPq5HPGo2Ikvw/7gT17b/DyvG/uvlphXVJmynRj6P1dS0ec+VrUBKnvdWk52fVZVm
	se6iFQfPtINwGiBeUv6Ir9QkyrnUfyfVCV/tnuDoLqSmhM3EYwtkIDctrb8Nph00sI3xtVuxZMB
	eiNiTiBRxJaHL9/VpJvlp8+CSuDgxbGebxLd8xV1uB/gx8wtprgVY2jGq4Vz3iS9IT/1MMp7USR
	uEf0iEiHqrafEhXSU54DAVlYAZULZyEXW7g7G88tgps10oFiX4U54ZHAlkUadG7DDSprRcB6M2O
	WkKVGfLcTT/NsXVKtVGiKqZdjRf6YQbT3Ox/D+Upj6ZzpK6b4MNbLbHIb3kA3hMTMNpA24OTKkU
	PuBlpLN/whpR2rTQoSxvvQuccaYnKQRJAROtRnpplVkPkJL/i8
X-Received: by 2002:a05:600c:6211:b0:48f:e230:72fc with SMTP id 5b1f17b1804b1-48fe663152cmr229712275e9.33.1779107337576;
        Mon, 18 May 2026 05:28:57 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48ff2cb4ae0sm104304315e9.0.2026.05.18.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:28:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/4] bpf: add icmp_send kfunc
Date: Mon, 18 May 2026 12:28:36 +0000
Message-Id: <20260518122842.218522-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v6 of adding the icmp_send kfunc, as suggested during LSF/MM/BPF
2025[^1]. The goal is to allow cgroup_skb programs to actively reject
east-west traffic, similarly to what is possible to do with netfilter
reject target.

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

Initially this kfunc was named icmp_send_unreach but now the interface
accepts a type parameter to facilitate future extension to other ICMP
control message types. Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH
are currently supported.

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

[^1]: https://lwn.net/Articles/1022034/

Link to v5: https://lore.kernel.org/bpf/20260515194746.50920-1-mahe.tardy@gmail.com/

Mahe Tardy (6):
  net: move netfilter nf_reject_fill_skb_dst to core ipv4
  net: move netfilter nf_reject6_fill_skb_dst to core ipv6
  bpf: add bpf_icmp_send kfunc
  selftests/bpf: add bpf_icmp_send kfunc tests
  selftests/bpf: add bpf_icmp_send kfunc IPv6 tests
  selftests/bpf: add bpf_icmp_send recursion test

 include/net/ip6_route.h                       |   2 +
 include/net/route.h                           |   1 +
 net/core/filter.c                             | 118 ++++++++++
 net/ipv4/netfilter/nf_reject_ipv4.c           |  19 +-
 net/ipv4/route.c                              |  15 ++
 net/ipv6/netfilter/nf_reject_ipv6.c           |  17 +-
 net/ipv6/route.c                              |  18 ++
 .../bpf/prog_tests/icmp_send_kfunc.c          | 218 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c |  99 ++++++++
 9 files changed, 474 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

--
2.34.1

