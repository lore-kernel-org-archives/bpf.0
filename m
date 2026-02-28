Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D612459E5;
	Sat, 28 Feb 2026 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772245179; cv=none; b=ioXpZv6LVEsjEqHL2UjaVXACvZnC68wBate7MGoHgJGzBwtjdjuc2bVX1IoXHudntrsz82yxtV+nLpt+SLiH+rAYizPoYSXTrRyXP/jr41a9O2H2ZNzHPkF8K3zNc1+izge3rfBEuLHz6Ie3oDPHSjQl0lK7AWctBWMOD3ooB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772245179; c=relaxed/simple;
	bh=rXow/PRXQEfMD31sAZeBu8Jf9CdmQ4mCbIebBHbaD/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Af6VgMJE0FhOhx5+xmTEetYYD4Yin9fxEQEwoHfp02ubXBWEPf+us0oSlWw400qYlai7NAqUHWhHg6MuAJGGJMhO03uhYvqEQWMowpUxpXNbiF2khSPQ4LYZvoaaJemK5TpIMC2fmcTZrt4KVodTIkTW1rh/8bPLdKWhnGQjoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kqHcyjtP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kqHcyjtP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772245175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaJBbEzRJdsFnp51qeiA4kb7YNrOB8BN6YafYX4UbiI=;
	b=kqHcyjtPfncBW/XP7POg97ovV0m1kmRCEuZrb1i0LRXY/QOcBf48vxPTUbKBnxYVElrMm7
	KHC6+GcZQLTHJfJWtJvIPV+XLkgnwnlCmyBfdvn3nZ9uc8jgWqPlofGYmcDBlXVKrQADlj
	V9y+mXnPTQ5Qjf0O5tP0Ta7EtLKGzOM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuna.chen@linux.dev,
	jiayuna.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
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
Subject: [PATCH net v3 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
Date: Sat, 28 Feb 2026 10:19:13 +0800
Message-ID: <20260228021918.141002-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260228021918.141002-1-jiayuan.chen@linux.dev>
References: <20260228021918.141002-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
when the bond mode is round-robin. If the bond device was never brought
up, rr_tx_counter remains NULL, causing a null-ptr-deref.

The XDP redirect path can reach this code even when the bond is not up:
bpf_master_redirect_enabled_key is a global static key, so when any bond
device has native XDP attached, the XDP_TX -> xdp_master_redirect()
interception is enabled for all bond slaves system-wide. This allows the
path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
reached on a bond that was never opened.

The normal TX path (bond_xmit_roundrobin) is not affected because TX
requires the bond to be UP, which guarantees rr_tx_counter is allocated.
However, bond_xmit_get_slave() (ndo_get_xmit_slave) has the same code
pattern via bond_xmit_roundrobin_slave_get() and could theoretically
hit the same issue.

Fix this by allocating rr_tx_counter unconditionally in bond_init()
(ndo_init), which is called by register_netdevice() and covers both
device creation paths (bond_create() and bond_newlink()). This also
handles the case where bond mode is changed to round-robin after device
creation. The conditional allocation in bond_open() is removed. Since
bond_destructor() already unconditionally calls
free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
ndo_init, free at destructor.

Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 drivers/net/bonding/bond_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 78cff904cdc3..9f63f67d8418 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4279,12 +4279,6 @@ static int bond_open(struct net_device *bond_dev)
 	struct list_head *iter;
 	struct slave *slave;
 
-	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
-		bond->rr_tx_counter = alloc_percpu(u32);
-		if (!bond->rr_tx_counter)
-			return -ENOMEM;
-	}
-
 	/* reset slave->backup and slave->inactive */
 	if (bond_has_slaves(bond)) {
 		bond_for_each_slave(bond, slave, iter) {
@@ -6411,6 +6405,12 @@ static int bond_init(struct net_device *bond_dev)
 	if (!bond->wq)
 		return -ENOMEM;
 
+	bond->rr_tx_counter = alloc_percpu(u32);
+	if (!bond->rr_tx_counter) {
+		destroy_workqueue(bond->wq);
+		return -ENOMEM;
+	}
+
 	bond->notifier_ctx = false;
 
 	spin_lock_init(&bond->stats_lock);
-- 
2.43.0

