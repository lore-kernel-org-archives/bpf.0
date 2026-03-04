Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E337F00C
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610219; cv=none; b=dqbp+QfDn1gNSzDeVsM5U5Hkum39GXzsb29DUHs1vriYxxm0nTtlZU6mNaPiiGvHUXneOqLzmdMHc+Vbh9Si9JiAp9PVCv8HRyPxz6GYzY03Jj4xJBd0YeVe/mNCBHLftQ87jkDNN1u2MGHXRL4SKxEMwo9yLujteKolEtb/xQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610219; c=relaxed/simple;
	bh=wH3V4MM4ibZuqlVLueOLPg0XvWndbKtQ3w1OHdd6RV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTuxK/4kY+km8DF9daJojC2ddblbMnwr1B3HtP1Lsmg6q6/phVaeH4XBg0RvGZowL4YPQmIyQLv3bpt5UBnNxkho47UFsl43iyI2TEH2Wu/NKn/iGRpGzD2C2ZWO4iTaPk4tjC21R/Gt9l5nJXWZEu+qEGE3SwhgzU8WlhjSeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ktbuWBfA; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ktbuWBfA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772610205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8U80aI+bQWRsc4zqht607p+XRB/MdpsnHnQWvGKu6Ks=;
	b=ktbuWBfAzbzI5aSK17M4MRtFeRCZNmtuTDRHWlbwlCGwoUchLD50TYiq+sd4xyq0gzH7BU
	zYQ5ZzElcUnmgXS3/qJG2maxEGamTUmS3xJqa5Fdqm/iZ3pp4/Ajwl5L7kBFpjkjMEkD/s
	lLwvpISN1Wo0M150i7rqcaGPesPCM+k=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: jv@jvosburgh.net,
	netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
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
Subject: [PATCH net v4 0/2] net,bpf: fix null-ptr-deref in xdp_master_redirect() for bonding and add selftest
Date: Wed,  4 Mar 2026 15:42:56 +0800
Message-ID: <20260304074301.35482-1-jiayuan.chen@linux.dev>
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

Patch 1: Allocate rr_tx_counter unconditionally in bond_init() (ndo_init).
Patch 2: Add a selftest that reproduces the above scenario.

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

 drivers/net/bonding/bond_main.c               |  19 ++--
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
 2 files changed, 112 insertions(+), 8 deletions(-)

-- 
2.43.0

