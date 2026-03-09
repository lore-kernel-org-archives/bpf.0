Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA1274B39
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773025673; cv=none; b=gMdssNjDDCMQTfK8Q4Ep3mIlz9GA9x4yUnOQ2K4gGckdrdD2lTyS0ZfkH34ULE3nANTkJwhJQ93dnzm1ex8ATot1L6swLnPZWsPqnbhsT9MbaNY91hfMvlSWWSwkMJ+Wnxt8e7+MILw9T/KQ88nOqz8qLCw649xoAxYqmFK4KVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773025673; c=relaxed/simple;
	bh=tJ/pTv6wX8ExsgyoJF3yLI2hLyBi6GJLVsyfYdXAxI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/1am+EAuy9veIqGQWgYbTUGHJMYX9feCYzUbNtCYOMUZ7lwnNUqp481wGsj/4MlnjvZGMZlHhJSNgAjh3ubbWJXrfJpsTEQ6vU37M1VY1pmE4L1ExNC0w6AUPq2uK46/i6dlmcyQvo7nac6Ca7Aq7EoYFqY8Q0XIQNezzRDcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Af5aiOgg; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Af5aiOgg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773025660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uZf1FeGkzRRE1cAOWeb+lVObskQJt5zW4BxFFAy4ozo=;
	b=Af5aiOgguXzrwsMqWN3BM3pugpZVKe6ceJk+xfz79ctLhEngJo0Kueh+X7+kew+Fxvf9Ut
	bXTEggmiMAahXKZeE5qmHjz6SoWXSrzfEmwwYETjTh8fiDJMHML2vqaW0nioFMtZ0j5dQK
	E8GBv0p27UJFmOYXKTpf1nbCS1gDLFE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org,
	jiayuan.chen@shopee.com,
	jiayuan.chen@linux.dev,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v5 0/2] net,bpf: fix null-ptr-deref in xdp_master_redirect() for bonding and add selftest
Date: Mon,  9 Mar 2026 11:06:57 +0800
Message-ID: <20260309030702.128520-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

syzkaller reported a kernel panic [1] with the following crash stack:

Call Trace:
BUG: unable to handle page fault for address: ffff8ebd08580000
PF: supervisor write access in kernel mode
PF: error_code(0x0002) - not-present page
PGD 11f201067 P4D 11f201067 PUD 0
Oops: Oops: 0002 [#1] SMP PTI
CPU: 2 UID: 0 PID: 451 Comm: test_progs Not tainted 6.19.0+ #161 PREEMPT_RT
RIP: 0010:bond_rr_gen_slave_id+0x90/0xd0
RSP: 0018:ffffd3f4815f3448 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8ebc8728b17e
RDX: 0000000000000000 RSI: ffffd3f4815f3538 RDI: ffff8ebc8abcce40
RBP: ffffd3f4815f3460 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffd3f4815f3538
R13: ffff8ebc8abcce40 R14: ffff8ebc8728b17f R15: ffff8ebc8728b170
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8ebd08580000 CR3: 000000010a808006 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 bond_xdp_get_xmit_slave+0xc0/0x240
 xdp_master_redirect+0x74/0xc0
 bpf_prog_run_generic_xdp+0x2f2/0x3f0
 do_xdp_generic+0x1fd/0x3d0
 __netif_receive_skb_core.constprop.0+0x30d/0x1220
 __netif_receive_skb_list_core+0xfc/0x250
 netif_receive_skb_list_internal+0x20c/0x3d0
 ? eth_type_trans+0x137/0x160
 netif_receive_skb_list+0x25/0x140
 xdp_test_run_batch.constprop.0+0x65b/0x6e0
 bpf_test_run_xdp_live+0x1ec/0x3b0
 bpf_prog_test_run_xdp+0x49d/0x6e0
 __sys_bpf+0x446/0x27b0
 __x64_sys_bpf+0x1a/0x30
 x64_sys_call+0x146c/0x26e0
 do_syscall_64+0xd3/0x1510
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Problem Description

bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
when the bond mode is round-robin. If the bond device was never brought
up, rr_tx_counter remains NULL.

The XDP redirect path can reach this code even when the bond is not up:
bpf_master_redirect_enabled_key is a global static key, so when any bond
device has native XDP attached, the XDP_TX -> xdp_master_redirect()
interception is enabled for all bond slaves system-wide.

Solution

Patch 1: Add a NULL check with unlikely() in bond_rr_gen_slave_id() before
dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was never
opened), fall back to get_random_u32() for slave selection. The existing
allocation in bond_open() is kept, with WRITE_ONCE() added to pair with
the READ_ONCE() in the NULL check.
Patch 2: Add a selftest that reproduces the above scenario.

Changes since v4:
https://lore.kernel.org/netdev/20260304074301.35482-1-jiayuan.chen@linux.dev/
- Reverted unconditional alloc in bond_init(); instead add a NULL check
  with unlikely()/READ_ONCE() in bond_rr_gen_slave_id() and WRITE_ONCE()
  in bond_open(), avoiding memory waste for non-RR modes
  (Suggested by Nikolay Aleksandrov, patch by Jay Vosburgh)

Changes since v3:
https://lore.kernel.org/netdev/20260228021918.141002-1-jiayuan.chen@linux.dev/T/#t
- Added code comment and commit log explaining why rr_tx_counter is
  allocated unconditionally for all modes (Suggested by Jay Vosburgh)

Changes since v2:
https://lore.kernel.org/netdev/20260227092254.272603-1-jiayuan.chen@linux.dev/T/#t
- Moved allocation from bond_create_init() helper into bond_init()
  (ndo_init), which is the natural single point covering both creation
  paths and also handles post-creation mode changes to round-robin

Changes since v1:
https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#t
- Moved the guard for NULL rr_tx_counter from xdp_master_redirect()
  into the bonding subsystem itself
  (Suggested by Sebastian Andrzej Siewior <bigeasy@linutronix.de>)

[1] https://syzkaller.appspot.com/bug?extid=80e046b8da2820b6ba73

Jiayuan Chen (2):
  bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
  selftests/bpf: add test for xdp_master_redirect with bond not up

 drivers/net/bonding/bond_main.c               |   9 +-
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
 2 files changed, 106 insertions(+), 4 deletions(-)

-- 
2.43.0

