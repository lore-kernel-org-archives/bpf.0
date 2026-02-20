Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B9340DA6
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585777; cv=none; b=Fvd9Sqg1V7uNqN2tpWSv1iADYTDWK+idbirE3BRcaaXvM7axbSJNouJ0jJzlZDxPNq6+qwFeocvW0OUezLjE5HfCYJaDN/gMi0ILZyUHE3qeCDCY7CHGmWwyX/0R31Kd2cQiWvJOcnSJCbzyVLfKTUR7LATNzuFzcSJXYnriqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585777; c=relaxed/simple;
	bh=9Vd/vU2OOT5YdMAIsfa4uj1uXtxEkk9tOj+MqX6QAzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1ZSb8Y66nU6xn4nJTsE5cqbIhR80DKw7dH3BgMqo3icB63mfI4qvUJdbqaSTv/anTmWUScdSeX/NkYQn4aCSaAQwoGSEPXvwPQceYdJvro/hwMVV/imd9737jS/8nEasBgbS1+4g1iBIcZp0NRA8thkTeskJWY4W7eTdBcPZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=nwlE0XfE; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="nwlE0XfE"
Received: from ms-a2 (54.52.30.125.dy.iij4u.or.jp [125.30.52.54])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61KB9NnI040209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Feb 2026 20:09:25 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=wTepkiaRF/hdxZuhpHfCAhj6kmf4sZflDY7X5BlhPCE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771585766; v=1;
        b=nwlE0XfEmpGymRX1tpzxeqddRsbvAqyLC+cIR4WrUGW4MNbAJPs1ixw/1u3ziYEu
         UvHsjQBMr+LMKg+XJcFLRg5hsdGM06H4dTGqxC/YipLP8ytQBaeydQQMw1FTEqRg
         SFs5ntTbkhk1zprf8VPpkk9yMAb6PF5dvz0fYlqaviruHjoKqP1qB1qSIbXIUqxV
         9nX7rKSHhWilw33mRwm+E0ohvYMV2+wxhjAUlxyyzS24h/h4kRJu/5K2wHWVg47s
         zBYCTcp1lS0KkmaJ8BexgWtSrqTAtjEmCeklT6tu5AtSFv0zcAkR7vNIsIMo+l2+
         hPfrZjZ4wCFz7/NJXDFVDQ==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 bpf-next] net: core: allow netdev_upper_get_next_dev_rcu from bh context
Date: Fri, 20 Feb 2026 11:09:17 +0000
Message-ID: <20260220110922.94781-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since XDP programs are called from a NAPI poll context, the RCU
reference liveness is ensured by local_bh_disable().

Commit aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master
device") started to call netdev_upper_get_next_dev_rcu() from this
context, but missed adding rcu_read_lock_bh_held() as a condition to the
RCU checks.
While both bh_disabled and rcu_read_lock() provide RCU protection,
lockdep complains since the check condition is insufficient [1].

Add rcu_read_lock_bh_held() as condition to help lockdep to understand
the dereference is safe, in the same way as commit 694cea395fde ("bpf:
Allow RCU-protected lookups to happen from bh context").

[1]
 WARNING: net/core/dev.c:8099 at netdev_upper_get_next_dev_rcu+0x96/0xd0, CPU#0: swapper/0/0
 ...
 RIP: 0010:netdev_upper_get_next_dev_rcu+0x96/0xd0
 ...
  <IRQ>
  dev_map_enqueue_multi+0x411/0x970
  xdp_do_redirect+0xdf2/0x1030
  __igc_xdp_run_prog+0x6a0/0xc80
  igc_poll+0x34b0/0x70b0
  __napi_poll.constprop.0+0x98/0x490
  net_rx_action+0x8f2/0xfa0
  handle_softirqs+0x1c7/0x710
  __irq_exit_rcu+0xb1/0xf0
  irq_exit_rcu+0x9/0x20
  common_interrupt+0x7f/0x90
  </IRQ>

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b..b99d46b682c6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8103,7 +8103,8 @@ struct net_device *netdev_upper_get_next_dev_rcu(struct net_device *dev,
 {
 	struct netdev_adjacent *upper;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_rtnl_is_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held() &&
+		     !lockdep_rtnl_is_held());
 
 	upper = list_entry_rcu((*iter)->next, struct netdev_adjacent, list);
 
-- 
2.51.0

