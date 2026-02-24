Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6E37C0ED;
	Tue, 24 Feb 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932385; cv=none; b=hND8bDNhx581fLokq0aFs3J2fvS7UXxZ/sPzL+igTa0ynuBkDH6WsM/Tu9lxMbphz+ikogldp0ZI6kJMiGPxRJmF6GJdY53S4pSmHZaM8gyV3FnlA/YH21eJQygVoYEtET0o4zZAvm5xwrzWLsjaBACiQqz5BFDREx9b3ZxAfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932385; c=relaxed/simple;
	bh=jKGpRtkQmoW/eINjEEeqokeSEboufukG5iJM7QvxWh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvcjVKoOY2pOzR5qvwpwgmdRggse3hwa+rKzN5US9Jd2BtINAssKy4T2axbysB+pXVKmIwswKZKHqIR6GMOLkUx01IAEgT8iD7DIHDmzEYZYuRYbWGMQyakVGuGqCFY3k1Sy9VBMGbhpviXGdRXVCglBq/T/74vNb3+F58n98Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KdMRzram; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KdMRzram"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771932381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9tpplCFFUxBSafBcz5oJn5FmlATJrojlSyiIAZIo2Y=;
	b=KdMRzramMNNyoFSDwyRphg5gnvY3iXBbKZPBKhM7p/qNhi5CVmpDAad73Xf2qBPXAlI1NR
	tst3CG+ZlPeWnvuCODmSQA74++8DkYTlRIDCG8lAfwpKrdYakZBLhOt0IOAf6zg9gdaV+z
	Vxi9nP3KXi7qT5bEh02Fw5CvK4ZjLjg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
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
Subject: [PATCH bpf v1 1/2] net/bpf: fix null-ptr-deref in xdp_master_redirect() for bonding
Date: Tue, 24 Feb 2026 19:25:41 +0800
Message-ID: <20260224112545.37888-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260224112545.37888-1-jiayuan.chen@linux.dev>
References: <20260224112545.37888-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

xdp_master_redirect() dereferences the master device pointer and calls
ndo_xdp_get_xmit_slave() without checking whether the master is valid
or running. When a bond device in round-robin mode has never been brought
up, bond->rr_tx_counter is not allocated (only allocated in bond_open()).
The XDP redirect path can still reach bond_rr_gen_slave_id() via
xdp_master_redirect() → bond_xdp_get_xmit_slave() →
bond_xdp_xmit_roundrobin_slave_get(), causing a null-ptr-deref on
rr_tx_counter.

bpf_master_redirect_enabled_key is a global static key. When any bond
device has native XDP attached, this key is enabled system-wide, causing
the XDP_TX → xdp_master_redirect interception to fire for all bond
slaves, even slaves of other bond devices that have never been opened.

To trigger, the following conditions must be met:
1. A bond (bond0) with native XDP attached, enabling the global key
2. Another bond (bond1) in round-robin mode, never brought up
3. A slave (veth1) of bond1 with generic XDP returning XDP_TX
4. Packets hitting the generic XDP path on veth1

Add a check in xdp_master_redirect() to verify the master device is
valid and running before proceeding with the redirect. This is
semantically correct because redirecting to a non-running master is
meaningless, and safe from a concurrency perspective because
xdp_master_redirect() runs under RCU protection and the master's
resources are not freed until after an RCU grace period.

Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba019ded773d..9a45dabd0044 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4387,6 +4387,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 	struct net_device *master, *slave;
 
 	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
+	if (unlikely(!master || !netif_running(master)))
+		return XDP_TX;
+
 	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
 	if (slave && slave != xdp->rxq->dev) {
 		/* The target device is different from the receiving device, so
-- 
2.43.0

