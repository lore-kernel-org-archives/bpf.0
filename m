Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F13ACA4A
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184230; cv=none; b=aV2T4DVYpRAO0EZ4Idnp/5JUm3UzBBNsXG23of0z1vL/0GQBR7taykMYBuKGex4wummVssUORCuWpy8KGsuoDLKzKcJcZC5w3ehUOw6DrkcLoW88r2Qvdh4fi1K9HGlWflhCuiN8AGxQd7D8nhNi5Smjrpb9V37FxkQlw8Zj+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184230; c=relaxed/simple;
	bh=AIESFvuth3DeEeSKdneKlGsA7uyXKPsKBqWHiiqTj90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra9pl3J5IDiW3DO3eJazICWF8SCnQ+z+K0OddJ3c6Kv7y4WVYQ+dTB1wLNocvvWxu96gqpifrzTFrVkCzxtzFLwlF0BCf3W2yPgkJwk+sysza6eZtoghb6pUhWBZEvAPwZbEegW0sHE9lKCeZrCw7xmqvg5F3VbexOb0bB4tDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4Gptl9T; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4Gptl9T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772184226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwg9RmMG4JXHFIgUL0EjGRr0qhwpwmEi0IbWd7zyiZI=;
	b=u4Gptl9TRLPT42tbPSiERnevQbfCMeHQBOpUXpOfTn8NR6HxMGZqpEs1peTAnZ16gcysrr
	v/Q1yRw38AqOEYmUdPXXj854vCWRP+7T9hbF+IL9BOcMHgpCPawb/IvqaTl0KqtI3Lk6n4
	7Ao5+brJLmy13uZIBiTsQSnjYNGaVqQ=
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v2 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
Date: Fri, 27 Feb 2026 17:22:49 +0800
Message-ID: <20260227092254.272603-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260227092254.272603-1-jiayuan.chen@linux.dev>
References: <20260227092254.272603-1-jiayuan.chen@linux.dev>
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

Fix this by introducing bond_create_init() to allocate rr_tx_counter
unconditionally at device creation time. It is called from both
bond_create() and bond_newlink() before register_netdevice(), and
returns -ENOMEM on failure so callers can propagate the error cleanly.
bond_setup() is not suitable for this allocation as it is a void
callback with no error return path. The conditional allocation in
bond_open() is removed. Since bond_destructor() already unconditionally
calls free_percpu(bond->rr_tx_counter), the lifecycle is clean:
allocate at creation, free at destruction.

Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 drivers/net/bonding/bond_main.c    | 18 ++++++++++++------
 drivers/net/bonding/bond_netlink.c |  4 ++++
 include/net/bonding.h              |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 78cff904cdc3..806034dc301f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4273,18 +4273,18 @@ void bond_work_cancel_all(struct bonding *bond)
 	cancel_delayed_work_sync(&bond->peer_notify_work);
 }
 
+int bond_create_init(struct bonding *bond)
+{
+	bond->rr_tx_counter = alloc_percpu(u32);
+	return bond->rr_tx_counter ? 0 : -ENOMEM;
+}
+
 static int bond_open(struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
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
@@ -6458,6 +6458,12 @@ int bond_create(struct net *net, const char *name)
 	dev_net_set(bond_dev, net);
 	bond_dev->rtnl_link_ops = &bond_link_ops;
 
+	res = bond_create_init(bond);
+	if (res) {
+		free_netdev(bond_dev);
+		goto out;
+	}
+
 	res = register_netdevice(bond_dev);
 	if (res < 0) {
 		free_netdev(bond_dev);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 286f11c517f7..91595df85f06 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -598,6 +598,10 @@ static int bond_newlink(struct net_device *bond_dev,
 	struct nlattr **tb = params->tb;
 	int err;
 
+	err = bond_create_init(bond);
+	if (err)
+		return err;
+
 	err = register_netdevice(bond_dev);
 	if (err)
 		return err;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 4ad5521e7731..dac4725f3ac0 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -714,6 +714,7 @@ void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
 void bond_work_cancel_all(struct bonding *bond);
+int bond_create_init(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.43.0

