Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCF2F9984
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041538; cv=none; b=Ke5BDu+Z350rMBveOPAryMj+OiwOErlNTDydV78Vk4NdivQCM9qtRRgdhNWHlDWxzFXGYYVkRT73kMDCm01yhGB56ijv/aZb+hiKkuEr8OSQcIX/O56NTIz4xWg01t3aFezObfvEqZzV0TeDXwC1PhkbDpwDJ7eYRI6En0YxlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041538; c=relaxed/simple;
	bh=QX6YcIS8aDtWOlo3nRiP3ADhmeIP9kM1kSmfsZ36zGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzU1fMXhhxu3w/ue5fkFrrkmXi7pdlRPteX6Wr8/KnnVh7k4RnyryOF8hnjh4TDktIsneYR05pzFwam6WVS5DuQstWQ98X3mRc9iyr7ncxBH5QnnoZe7T9Oxf2peadodAsUD9yvaigiozGB6+TfooN2rzmNgtffGRQ1x0z0LyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nWUFtDZ0; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nWUFtDZ0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775041533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=awnZxp/u7WMTZ1nHWIvAJbHaDUNgRFNmp2rxXHzr9ZM=;
	b=nWUFtDZ0inpwwANY7t9NH3zzcZy082lPqJffG3i4D0YFe9DbO9YIPUMKrg4pW4Z4hEeCZq
	u5goBt3tcq08TrKgsu9+juK5EM2T62h6eqOPTIG+Cre0y8YQbbVLac3KJRqQuTEbbVs844
	uJ7iMq0zmop90zZTldYOXaDLT8lf3fQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v5 0/2] bpf: tcp: Fix null-ptr-deref in arbitrary SYN Cookie
Date: Wed,  1 Apr 2026 19:04:48 +0800
Message-ID: <20260401110511.73355-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

bpf_sk_assign_tcp_reqsk() does not validate the L4 protocol of the skb,
only checking skb->protocol (L3). A BPF program that calls this kfunc on
a non-TCP skb (e.g. UDP) will succeed, attaching a TCP reqsk to the skb.

When the skb enters the UDP receive path, skb_steal_sock() returns the
TCP listener socket from the reqsk. The UDP code then casts this TCP
socket to udp_sock and accesses UDP-specific fields at invalid offsets,
causing a null pointer dereference:

  BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
  Read of size 4 at addr 0000000000000008 by task test_progs/537

  CPU: 1 UID: 0 PID: 537 Comm: test_progs Not tainted 7.0.0-rc4+ #46 PREEMPT
  Call Trace:
   <IRQ>
   dump_stack_lvl (lib/dump_stack.c:123)
   print_report (mm/kasan/report.c:487)
   kasan_report (mm/kasan/report.c:597)
   __kasan_check_read (mm/kasan/shadow.c:32)
   __udp_enqueue_schedule_skb (net/ipv4/udp.c:1719)
   udp_queue_rcv_one_skb (net/ipv4/udp.c:2370 net/ipv4/udp.c:2500)
   udp_queue_rcv_skb (net/ipv4/udp.c:2532)
   udp_unicast_rcv_skb (net/ipv4/udp.c:2684)
   __udp4_lib_rcv (net/ipv4/udp.c:2742)
   udp_rcv (net/ipv4/udp.c:2937)
   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
   ip_local_deliver_finish (./include/linux/rcupdate.h:879 net/ipv4/ip_input.c:242)
   ip_local_deliver (net/ipv4/ip_input.c:265)
   __netif_receive_skb_one_core (net/core/dev.c:6164 (discriminator 4))
   __netif_receive_skb (net/core/dev.c:6280)

Solution

Patch 1: Add L4 protocol validation in bpf_sk_assign_tcp_reqsk(). Check
ip_hdr(skb)->protocol (IPv4) and ipv6_hdr(skb)->nexthdr (IPv6) against
IPPROTO_TCP, returning -EINVAL for non-TCP skbs.
Patch 2: Add selftest that calls bpf_sk_assign_tcp_reqsk() on a UDP skb
and verifies the kfunc rejects it.


---
v1: https://lore.kernel.org/bpf/20260323105510.51990-1-jiayuan.chen@linux.dev/
v2: https://lore.kernel.org/bpf/20260326062657.88446-1-jiayuan.chen@linux.dev/
v3: https://lore.kernel.org/bpf/20260327133915.286037-1-jiayuan.chen@linux.dev/
v4: https://lore.kernel.org/bpf/20260330080746.319680-1-jiayuan.chen@linux.dev/

Changes in v5:
- Add pskb_may_pull before accessing IP/IPv6 headers in kfunc
- Use buf[] instead of buf[32], verify recv data with ASSERT_STREQ
- Remove unnecessary variable initializations in selftest and BPF

Changes in v4:
- Check if assign_ret is EINVAL instead of checking if it is 0

Changes in v3:
- Add IPv6 test coverage, reuse test_cases[] to iterate over both
  address families
- Share TCP/UDP port to simplify BPF program, remove unnecessary
  global variables
- Use connect_to_fd() + send()/recv() instead of manual sockaddr
  construction
- Suggested by Kuniyuki Iwashima

Changes in v2:
- Add Reviewed-by tag from Kuniyuki Iwashima for patch 1
- Use UDP socket recv() instead of kern_sync_rcu() for synchronization
  in selftest

Jiayuan Chen (2):
  bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
  selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()

 net/core/filter.c                             |  12 ++
 .../bpf/prog_tests/tcp_custom_syncookie.c     |  93 ++++++++++++++-
 .../bpf/progs/test_tcp_custom_syncookie.c     | 109 ++++++++++++++++++
 3 files changed, 210 insertions(+), 4 deletions(-)

-- 
2.43.0

