Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C88391850
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779370; cv=none; b=U9MlJZsZ3psRaD/0GVlF3TxdqKV437cPgECau03ajPqlr2DAiP+aPaWf7Yh6Hwksbeo0JitUsSw1OM4CaQy5ldaEaGWFvBh3NIV47jT0BG6VlKlEa0lRyKHJNswKqPb5GGQe/mUlCOcf2RvP2rlxmucHFzO5FwEoD68HL+rEhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779370; c=relaxed/simple;
	bh=AUkEXZ9shK/AEw9rish8lLHvzIx+b3il3PP8PxYF4lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjKAj4g3jh0YlnExgI1E0xXHqX7d4ck7XMDTHWoNHJ96lelhgI1BR4j1Y5BC0vmCkHhpoP8WZWbAINluhMiC7kegE7F+zUMDm04XxO/P5tbbox6chazJE9cSw/UPSoPUvM3nfrip5Kwu7b/wkb6iY6oQKCFhp/XuXaqsHfTYCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhC9n54V; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhC9n54V"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso81513755ad.2
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779366; x=1779384166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yopC/9MxA39yKranAJ5Os3jyJpUN93ONWaDD2qEA7s=;
        b=hhC9n54VZ84cvwcMzJlpSU1MH0hA1f/oYJpnYy/Q1Bz8o2YAC4g4b1KRCIJFj7jbcG
         17MbTa+7oIHCkTa3U7ukQjglNo2cP4KYEHgqt7DbWkjppbSR2O1yagSEEwfrjbBOq+Gz
         GFg+70CFvzzzzVT48L9ooA+aipUvQwOe7Pnu8GEVIka24yUbXA5Y4pTkCX5s17E9jXd7
         uQif0SqOsAPWI3KFa5IE3rHZW1rgBxNJEHltQ20cCMwkVvA/Kvw1Wd+IvnJQOpF6vNrJ
         t++uC3Eehj9/it/gXWn/eN8FvV9UfvrTgOQz7bPJJ11kXFagMzCIf6BbT8iyr/kniXPU
         tlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779366; x=1779384166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7yopC/9MxA39yKranAJ5Os3jyJpUN93ONWaDD2qEA7s=;
        b=WPDQNn6dQ9qpxuCAtLmXnm2R+XbFbZnPSlNmXMXMtmqxZzWPdY6g33+Lf4DLmu9UdO
         R6wv2yXlf6pQTsyX4/MfoabKEJdbTDMiHHfSZKtvMxzzyMNftsExehgv40tAAgSxLExp
         obbdOTl/I6ESPO+tl3XjaSm2sitzGPPqXm/OvCwrM9zJQ7jsUwnZRZVLIyqeR6fMZOYH
         g5kyYu2KpYhqWtde2ttPywrbfWVNmJ/2RQ7wfPGZQE09diwM56ZYlzTR2sX3CjhURLi1
         9Iuz96ELfPaXfxq8eqnOo6bzSNmXem7ciajOUwZZj4la3CeXf2p8I4Z+2W28kTF8mB0l
         LOJA==
X-Forwarded-Encrypted: i=1; AFNElJ8U6cqF1nqlX5EEHIg3JudjTIrpkq+7V4bnDKc2hfBnTNa0LcmeMk6xp3Gsy+SDLJLbjGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZNQ3x5XLaNghcnoKH3ci46kTFW+kpB+RC/5u8Q1UIx02tHS3
	4FILQe6xmNlTdPXu77ftctnHxXblivh5Ul2ijMTebE3ki/XPyXVgMpFd
X-Gm-Gg: Acq92OF9enDcOcWfWz/tsx8xCVO7Mj/QaBu3gcPxnB78n1l+x4M/BiAKcIPtC+PZAO2
	d53WeDVeSWR4LSPQ1Xt8wgBnHN11Z4ucL21XMG+q7i8cey5F9BDVRGqnl/MahHWaPWVShL/ebsV
	u13Cr2mZj/EqFJ3Kz5XfdE5gr/wS/CXBBu4D+CcyD9bq5pmhTNQLdh3if0T5i9nChNRGomOLSEy
	GmifwaeegzIx9FGwiCbqg0tPfxzgvGEgave5YBfcsiK6FR8sKq0xngH8pxmF7ZerVxgBx4h37oD
	9MDEov3nX/AvJWXG2icP+0VszCjWQorPVyK5rxBUqEi77VHUHIIbZ3NPVfvFtiRIQmE9bqjaDyM
	ZkLCmClX/rZMumWWggZCeOAKfz+JFP+68mLvKm89aNgY4Xgg0oCsMVaExPxnVqkrG3Lcx3BrRnc
	NrK2Z7bnsUB0eL5YIlPktr
X-Received: by 2002:a17:903:46d0:b0:2bd:657f:3a1a with SMTP id d9443c01a7336-2bd7e77ab65mr5300005ad.8.1778779366071;
        Thu, 14 May 2026 10:22:46 -0700 (PDT)
Received: from localhost ([2a03:2880:f80c:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fcb10sm32152215ad.60.2026.05.14.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:45 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:29 -0700
Subject: [PATCH net-next v5 2/8] net: netkit: declare NETMEM_TX_NO_DMA mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-tcp-dm-netkit-v5-2-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Some virtual devices like netkit (or ifb) never DMA and never touch frag
contents, they just forward the skb to another device. They are unable
to forward unreadable skbs, however, because they fail to pass TX
validation checks on dev->netmem_tx. The existing two-state
NETMEM_TX_NONE / NETMEM_TX_DMA doesn't give the TX validator enough
information to differentiate devices that will attempt DMA on the
unreadable skb from those that will simply route it untouched.

Add a third mode to the enum so drivers can indicate 1) if they have
netmem TX support, and 2) if they do, whether they are DMA-capable:

NETMEM_TX_NO_DMA - pass-through, device never DMAs

Widen dev->netmem_tx from a 1-bit field to 2 bits to fit the new value,
and declare netkit as NETMEM_TX_NO_DMA. Devmem TX support over these
devices comes in a follow-up patch.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- net_cachelines/net_device.rst: align the netmem_tx row's type column
  with the rest of the table by using "unsigned_long:2" instead of
  "unsigned long:2"
- Split this into a distinct patch (Jakub)
---
 Documentation/networking/net_cachelines/net_device.rst | 2 +-
 Documentation/networking/netmem.rst                    | 3 +++
 Documentation/translations/zh_CN/networking/netmem.rst | 3 +++
 drivers/net/netkit.c                                   | 1 +
 include/linux/netdevice.h                              | 3 ++-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 1c19bb7705df..7b3392553fd6 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -10,7 +10,7 @@ Type                                Name                        fastpath_tx_acce
 =================================== =========================== =================== =================== ===================================================================================
 unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
 unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
-unsigned long:1                     netmem_tx:1;                read_mostly
+unsigned_long:2                     netmem_tx:2;                read_mostly
 char                                name[16]
 struct netdev_name_node*            name_node
 struct dev_ifalias*                 ifalias
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 5ccadba4f373..217869d1108d 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -99,3 +99,6 @@ Driver TX Requirements
    appropriate mode:
 
    - `NETMEM_TX_DMA`: for physical devices that perform DMA.
+
+   - `NETMEM_TX_NO_DMA`: for virtual or passthrough devices that do
+     not DMA, but still support handling of netmem-backed skbs.
diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
index 9c84423b7528..320f3eacf51b 100644
--- a/Documentation/translations/zh_CN/networking/netmem.rst
+++ b/Documentation/translations/zh_CN/networking/netmem.rst
@@ -92,3 +92,6 @@ dma-mapping API 去处理。
 2. 驱动程序应将 `netdev->netmem_tx` 设置为适当的模式：
 
    - `NETMEM_TX_DMA`：适用于执行 DMA 的物理设备。
+
+   - `NETMEM_TX_NO_DMA`：适用于不执行 DMA 的虚拟或透传设备，但仍支持
+     处理 netmem 支持的 skb。
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5e2eecc3165d..0ad6a806d7d5 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -466,6 +466,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->netmem_tx = NETMEM_TX_NO_DMA;
 
 	dev->netdev_ops     = &netkit_netdev_ops;
 	dev->ethtool_ops    = &netkit_ethtool_ops;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b7a4503f7cdb..bf3dd9b2c1a7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1797,6 +1797,7 @@ enum netdev_stat_type {
 enum netmem_tx_mode {
 	NETMEM_TX_NONE,		/* no netmem TX support */
 	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
+	NETMEM_TX_NO_DMA,	/* no DMA, e.g. passthrough for virtual devs */
 };
 
 enum netdev_reg_state {
@@ -2143,7 +2144,7 @@ struct net_device {
 	struct_group(priv_flags_fast,
 		unsigned long		priv_flags:32;
 		unsigned long		lltx:1;
-		unsigned long		netmem_tx:1;
+		unsigned long		netmem_tx:2;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;

-- 
2.53.0-Meta

