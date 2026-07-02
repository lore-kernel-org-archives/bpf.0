Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4024BC023;
	Thu,  2 Jul 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000847; cv=none; b=XNuYBfryhZQejJCyb/s69CdxMJpDv83Uu/zUAPIoD6Xr1/h29zx5aSmQ8zLtGIzpACHeNBGDuWwWLjaTxsi8SsORINkz5M/SpLINK5oN6uROl/vl3CKIy95OHryyE9oGK8mWpxpJRbhc9JdKhpQoZA8h28g+RYrfFaOSDznNOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000847; c=relaxed/simple;
	bh=YuhUWRZpR/c1SudsXYIC5lMZQuSethdihqWAAr75cPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PG9h6B4CDppEWmQoBOzpnMquDTdc56t2vJ4kChUnBWt9jlh5I/9TQDnFqtqGGXVf0Cc6QtAyXwqiH7KkLifUTQMBJpcS6SOzRMdTUEzwJFoyTJsE8QvI5dBzGg/kizsP/zmuRgf1SAbcgEtLqD/GewNQg715KGpOcEV3r3ENtSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fifDBkAh; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fifDBkAh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eo8+43bLrgXbWMfkPUZYZdjX4uWxuSiabcFDBuDhWzA=;
	b=fifDBkAhUOPF9EKncJRUp87E+/Ldvh8Sc+3vOcYq0akLduHBIYBRjGPKHsiUgzPPlSPbs2FPN
	QYw7Jtj+4vqHVYf1Nh6xm59q8teDm+lkn1ZlH5F/3JJpWtlFUG2Fa34UiO/nDn1MWSMzrgJ+ofr
	5XG7Wp6hzNbYWLvBHA7it10=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4grdb23VzgzKmTt;
	Thu,  2 Jul 2026 21:51:26 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 701F74048B;
	Thu,  2 Jul 2026 22:00:39 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Jul 2026 22:00:39 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Jul 2026 22:00:38 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <daniel@iogearbox.net>, <edumazet@google.com>, <ncardwell@google.com>,
	<kuniyu@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<jiayuan.chen@linux.dev>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <zhangchangzhong@huawei.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net 0/2] bpf, sockmap: fix copied_seq after partial TCP read
Date: Thu, 2 Jul 2026 22:09:57 +0800
Message-ID: <20260702140959.1806754-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)

tcp_eat_skb() assumes that an skb dequeued by the sockmap verdict path
has not previously been consumed. However, a socket can be inserted
into a sockmap after userspace has partially read the skb at the head of
its receive queue.

When new data invokes the verdict path, tcp_eat_skb() advances
copied_seq by the full skb length. This counts the already-read prefix
twice, moves copied_seq beyond rcv_nxt, and makes later native TCP reads
fail. TCP_ZEROCOPY_RECEIVE then triggers the tcp_recvmsg_locked()
sequence warning reported by syzbot.

TCP recvmsg seq # bug 2: copied AA28C633, seq AA28C601, rcvnxt AA28C602
WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked
RIP: 0010:tcp_recvmsg_locked (net/ipv4/tcp.c:2745)
Call Trace:
<TASK>
tcp_zerocopy_receive (net/ipv4/tcp.c:1995 net/ipv4/tcp.c:2227)
do_tcp_getsockopt (net/ipv4/tcp.c:4771)
tcp_getsockopt (net/ipv4/tcp.c:4869)
do_sock_getsockopt (net/socket.c:2487)
__sys_getsockopt (net/socket.c:2518)
__x64_sys_getsockopt (net/socket.c:2525 net/socket.c:2522)
do_syscall_64 (arch/x86/entry/syscall_64.c:63)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Patch 1 advances copied_seq to the skb end sequence and accounts only
the unread sequence-space delta during receive-buffer cleanup.

Patch 2 adds a deterministic regression test which reproduces the
tcp_recvmsg_locked() warning on the unpatched kernel.

Dong Chenchen (2):
  bpf, sockmap: account only unread data in tcp_eat_skb
  selftests/bpf: cover sockmap drop after partial TCP read

 net/ipv4/tcp_bpf.c                            |  9 ++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 73 +++++++++++++++++++
 2 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.43.0

