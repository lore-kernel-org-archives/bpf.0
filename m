Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF2037C113;
	Tue, 24 Feb 2026 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932386; cv=none; b=t1HeZpjvicZuUJTvObP01weKBKh2/TF2GSZtnJbwQlWgyzhz8qUGk/CkNJ/Lws9d72u6K67POwDu8vK8pFUm1D6ocY2jzRPKwNLjaSH+ALhEP/1sks38bCozn8uqvtSepQJzOSU6kDwKMPAOSqbJEkW3g/VwZjGQb1nGFyQy06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932386; c=relaxed/simple;
	bh=UptIgokb/dyF6wInuhYy2T2AigqgL83BU9KqYv4HoaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SgtXNc/QeWi8j+BZwGGKssOfUsBgr69U0VObDITt5oSiVJORboNqV4mrWHObIHKs/p69LBnH771EAM6exdSWq5jQmHt6yH/eKE1HUYO4Q86RpTLSjTFSyZpB/VbJ5QuMPFxTNKlomRDvjuMPhZW7nePRbtCkfo/n88RUAX+DZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgrubxoI; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgrubxoI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771932372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x1FoqKbqHHIMBsFABc86KciTK4bzrTfxYrVwEv4or98=;
	b=AgrubxoID+ZtORvE3INcpLH4BZONuBbImcx9ft05Ug+FKR+XvSaxH0B16lHiB14GfccWRQ
	gtRf/CsAABr5JMCu+gBv4as463CCpDZ+RnoqX3cknkMEE0zMiDkKErp2O4c1EjrdVWAHt5
	8ZMeU++6NpLzdyDF+SmKM/APFpDluqo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf v1 0/2] net,bpf: fix null-ptr-deref in xdp_master_redirect() for bonding and add selftest
Date: Tue, 24 Feb 2026 19:25:40 +0800
Message-ID: <20260224112545.37888-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This issue occurs when the following conditions are met:

1. A bond device is in round-robin mode but has never been brought UP
 (bond_open() was never called)
 - rr_tx_counter is only allocated in bond_open()

2. bpf_master_redirect_enabled_key is a global static key
 - When any bond device attaches native XDP, this key is globally enabled
 - It affects XDP processing for ALL bond slaves system-wide

3. The XDP redirect data path can reach bond_rr_gen_slave_id()
 - Via: xdp_master_redirect()->bond_xdp_get_xmit_slave()->bond_rr_gen_slave_id()
 - bond_rr_gen_slave_id() directly dereferences rr_tx_counter without NULL check
 - When the bond is not UP, rr_tx_counter is NULL, causing a null-ptr-deref crash

Solution

Patch 1: Add netif_running() check in xdp_master_redirect() to verify the master
	   device is in the running state before proceeding with the redirect.

Patch 2: Add a selftest that reproduces the above scenario and verifies the fix.

[1] https://syzkaller.appspot.com/bug?extid=80e046b8da2820b6ba73

Jiayuan Chen (2):
  net/bpf: fix null-ptr-deref in xdp_master_redirect() for bonding
  selftests/bpf: add test for xdp_master_redirect with bond not up

 net/core/filter.c                             |   3 +
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
 2 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.43.0

