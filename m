Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05D392C2D
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093023; cv=none; b=OQOMrf3T3g0jdIgoTTNg7ACdDDWgbSYkTR2eifKiQzgqboUz/CAYxnMr57RVdSx/ANniAlGwSdhfuk+1cfk0PqQjTzIHqdi+SzXtDiUxf8DbyxHKBr1wB9L3jMPVZFtHu/pS02VYwGOeVe3VrmG4+3Du9vy614sb7HW/mwnPWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093023; c=relaxed/simple;
	bh=pPm1NQz/awEqft25cau5tHZU/n5KX7QXvnMptYjLpO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYAhLoWBKkKJ0jJnllkNg5XTUpvzKrgpuf9x0qkmtBH4N4/AFZk4zWZf4c9qggV790iUI9miRRlfsyrTo/0ZIX9dMUCuyrh52if6kMk6bKf74Jbjzo8mB/CFGcSV//ia9J/jL9Cgokgh31ml3D3RZQ2o5dWhsnuYH7kdK9se2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iI/lRdQ2; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iI/lRdQ2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772093013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LFrUacmVzVoIS6rMkKRo1xTKd0v7vZ9gwEve89bhung=;
	b=iI/lRdQ2SWmjXq2Hr1/U+VqOq9KdMyadXmMHD7m+CFEEQ92yrtzDKXAfPjMpvfWMCJ4OaL
	LupU75VXMrM6btpHTBCgZ6UOS3pkFZDh3ha6LcaA1pzospddQOLeU4bEOsEx64TzpzdwXD
	IAeHJdUTHHGhwwPSG8RH5ItE3JYW7hM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	Jussi Maki <joamaki@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v1 0/2] bonding: fix missing XDP compat check on xmit_hash_policy change
Date: Thu, 26 Feb 2026 16:03:00 +0800
Message-ID: <20260226080306.98766-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

syzkaller reported a bug https://syzkaller.appspot.com/bug?extid=5a287bcdc08104bc3132

When a bond device is in 802.3ad or balance-xor mode, XDP is supported
only when xmit_hash_policy != vlan+srcmac.  This constraint is enforced
in bond_option_mode_set() via bond_xdp_check(), which prevents switching
to an XDP-incompatible mode while a program is loaded.  However, the
symmetric path -- changing xmit_hash_policy while XDP is loaded -- had
no such guard in bond_option_xmit_hash_policy_set().

This means the following sequence silently creates an inconsistent state:

  1. Create a bond in 802.3ad mode with xmit_hash_policy=layer2+3.
  2. Attach a native XDP program to the bond.
  3. Change xmit_hash_policy to vlan+srcmac (no error, not checked).

Now bond->xdp_prog is set but bond_xdp_check() returns false for the
same device.  When the bond is later torn down (e.g. netns deletion),
dev_xdp_uninstall() calls bond_xdp_set(dev, NULL) to remove the
program, which hits the bond_xdp_check() guard and returns -EOPNOTSUPP,
triggering a kernel WARNING:

  bond1 (unregistering): Error: No native XDP support for the current bonding mode
  ------------[ cut here ]------------
  dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL)
  WARNING: net/core/dev.c:10361 at dev_xdp_uninstall net/core/dev.c:10361 [inline], CPU#0: kworker/u8:22/11031
  Modules linked in:
  CPU: 0 UID: 0 PID: 11031 Comm: kworker/u8:22 Not tainted syzkaller #0 PREEMPT(full)
  Workqueue: netns cleanup_net
  RIP: 0010:dev_xdp_uninstall net/core/dev.c:10361 [inline]
  RIP: 0010:unregister_netdevice_many_notify+0x1efd/0x2370 net/core/dev.c:12393
  RSP: 0018:ffffc90003b2f7c0 EFLAGS: 00010293
  RAX: ffffffff8971e99c RBX: ffff888052f84c40 RCX: ffff88807896bc80
  RDX: 0000000000000000 RSI: 00000000ffffffa1 RDI: 0000000000000000
  RBP: ffffc90003b2f930 R08: ffffc90003b2f207 R09: 1ffff92000765e40
  R10: dffffc0000000000 R11: fffff52000765e41 R12: 00000000ffffffa1
  R13: ffff888052f84c38 R14: 1ffff1100a5f0988 R15: ffffc9000df67000
  FS:  0000000000000000(0000) GS:ffff8881254ae000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f60871d5d58 CR3: 000000006c41c000 CR4: 00000000003526f0
  Call Trace:
   <TASK>
   ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
   ops_undo_list+0x3d3/0x940 net/core/net_namespace.c:248
   cleanup_net+0x56b/0x800 net/core/net_namespace.c:704
   process_one_work kernel/workqueue.c:3275 [inline]
   process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3358
   worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
   kthread+0x388/0x470 kernel/kthread.c:467
   ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

Beyond the WARNING itself, when dev_xdp_install() fails during
dev_xdp_uninstall(), bond_xdp_set() returns early without calling
bpf_prog_put() on the old program.  dev_xdp_uninstall() then releases
only the reference held by dev->xdp_state[], while the reference held
by bond->xdp_prog is never dropped, leaking the struct bpf_prog.

The fix refactors the core logic of bond_xdp_check() into a new helper
__bond_xdp_check_mode(mode, xmit_policy) that takes both parameters
explicitly, avoiding the need to read them from the bond struct.
bond_xdp_check() becomes a thin wrapper around it.
bond_option_xmit_hash_policy_set() then uses __bond_xdp_check_mode()
directly, passing the candidate xmit_policy before it is committed,
mirroring exactly what bond_option_mode_set() already does for mode
changes.

Patch 1 adds the kernel fix.
Patch 2 adds a selftest that reproduces the WARNING by attaching native
XDP to a bond in 802.3ad mode, then attempting to change xmit_hash_policy
to vlan+srcmac -- verifying the change is rejected with the fix applied.

Jiayuan Chen (2):
  bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is
    loaded
  selftests/bpf: add test for xdp_bonding xmit_hash_policy compat

 drivers/net/bonding/bond_main.c               |  9 ++-
 drivers/net/bonding/bond_options.c            |  2 +
 include/net/bonding.h                         |  1 +
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 58 +++++++++++++++++++
 4 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.43.0

