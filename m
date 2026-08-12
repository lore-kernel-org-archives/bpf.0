Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34354334C3
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542556; cv=none; b=pMTqfZpGDptMKPnGXCR5pHIi7Y83gAhiNA8B1MVwl5LjBYX1/StG4V5KQ81xcNz7P9U3EWvGR5yjacFnF9ztDLX7iiHdffDgxWgL5xp87NKKbeOwDQxrdz/RRTLAMntrd1wYFM/o9Otmxcbo7A1eydvP5HcDU9P0259i6eUCNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542556; c=relaxed/simple;
	bh=JBovGLTQDNZvVB1kX5xGnBWZWunagAeDDllcGJP/3kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ufGQZTGzZyu5sioH0prTmFBJoH9HIp2LMQw8Q/UvD0CGW7xEoO7GcdRyo32nStytZsvwD7NN3uUkiVwepExhhhD5xcxIoKrZTZgQHWsOoRcNsIu0ze0Yh71z39hrQAhBi4TpXhnwiyF0bOQtZuY+xtUqu/gz3yNycY4jJuH1zxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmG6YmuO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmG6YmuO"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbeeaac53a9so432371a12.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786542554; x=1787147354; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hstRaZBm6Ruysx0BcAFOKD/4xYhykDDvb4hgaRpnKSo=;
        b=AmG6YmuOHCI6Q+fwYbQJmIBKdizCshFKVE+01tYyBTs0tjKCuD8PkkYaeYK92cDsqi
         d5jA94Otu81nu2ISSKDWqINbSM34esrpuakgW1C5K2HaSMVs0yZ4zGWJ7n0j+t2lppW7
         L1cx8NsTYkQNFm0xuORX6yoaYgS4D/ag6sM5s3NT6u7u/l1R84D/dUgV3IERUcLJ5lDk
         zmh/xJvL1etWBQ/QBLtGfCOuEVIRuNJm6DQAHl7wExV7hPzoUHpYILD48QJHfmTFO7II
         hDleHc5QB7immZGpSQl7Vmx+RNRopnFUOUfTQxVnQOa/jJMFdAIRmXxTW98l4DqUXR2Q
         iFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542554; x=1787147354;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hstRaZBm6Ruysx0BcAFOKD/4xYhykDDvb4hgaRpnKSo=;
        b=R12qs58LxTh/6tetjBXbCnX6CcnC2h0vNzC2A1/vDoBq6m/yX5KvjgmR2nVTN9HLL+
         3Z6JJTI09JQCqiWHg5YXYIZYOZrKj30b5QCpqsu0cL73NIjUWYyZ2qgs3hDeqQ+H1PBj
         5MtAYpUaTLKmHJFJAzdFi84Ts4AbfeIcN06PhUgzG3m/I5ZHZ3Xomq/+c9cMWBUDVJbd
         pp3beM4Qf3XiA1LbUgBaIbUKZ/eu6/5Ow41vfdUYnTkXfHeQ7VIUmRyIgkvG4WFt/w/c
         Cps446Grlc/FVLkJyBf3Nfcr2jLAZzBpDZ/ODnw1uwIbBDFYmNvYNsZaLEZVT3RgzuCZ
         +tNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtszOqYNqqsGQUJGdl+w2O/ttL/YKAFA6uKoYbt9E1vHijwLhXDAPlh1nU50WoQYzp6Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XXUOo3O/NvubnuqzhGdI6j1c3VPrwBawxTmeaiFF8BHjZw5j
	NrJ2xortInzGQSeQZcyhbQAFniOXEWdh6RJgC//VcNHIBNwJYKiozyVG
X-Gm-Gg: AR+sD13xYMXLiaCCHDKqfR23qnv66pHunNdVGgH92FCUaCoZTmZbN+IK8hkh4LbRQoJ
	WugpN8Jn4TE52xXWtXhPet5WqLKGmD2TKLzNp7MHLVHbCzgM0oKrrDiotDnfl8id1zU3Mi9jIgm
	3ZyNyW8nca8IIjxN7Q0eHfOZD8Vybd0gZCZ6o2atnrKOkSnLkMiUQ5CvsX0/20GQDC4IMbJ1IHp
	F7p4le1e0RAb7P2c4BvlHOniEpzw7XvZwHHevzNnISKEw+4fpW/SxuvaXUmxVqPNcgB1VYmP1dF
	bxB6Jbx+6kkv55nMXSeX13TrB6LXRXc4TYw04bGaruC3yOL3VRG0SXCmYPgNHPlILAFPj29w1hf
	SgUkZrrImHqNw6O4F2v0z9qmxLR0GS7APBvoWzDQtSkFvUECtHosR5rWgXz8nhe+1mcXdczR0y1
	rkkVy/DvgOekmgLZLW0t/YMUjRAq3fDRNabo/KZftpmvc1wF7K5mCBILaWNydOO45/Gggf
X-Received: by 2002:a05:6a21:694:b0:3bf:d0c8:2aa4 with SMTP id adf61e73a8af0-3cc3f5177e3mr6404225637.8.1786542553933;
        Wed, 12 Aug 2026 06:49:13 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:3:d079:2e5c:2c6d:3026])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3624c6dsm15956350eec.4.2026.08.12.06.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:49:13 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Date: Wed, 12 Aug 2026 19:19:06 +0530
Subject: [PATCH] netdevsim: update rxq->napi pointer during queue reset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-netdevsim-v1-1-521a85e4fe91@gmail.com>
X-B4-Tracking: v=1; b=H4sIANF5fGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Mj3bzUEhBOSS0rzszVTUxMMTM0MLAwNklJUQLqKShKTcusAJsXHVt
 bCwD0G13kXwAAAA==
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, syzbot+c06674caba265dc61d46@syzkaller.appspotmail.com, 
 Subasri S <subasris1210@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786542548; l=3078;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=JBovGLTQDNZvVB1kX5xGnBWZWunagAeDDllcGJP/3kI=;
 b=9k7BLfuE5+3VxkFzwPNSm1+ERLTHfUaxtuaP65b2YkwFDdV5LKds77A3VQw9M8Mzcs3X0Mc+v
 GYim/2OFa72D5J3/4gzNr8Fq6MPocKPuT6F5fcGc0uA5Y9gKB7tJQDp
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

In netdevsim, when queue reset is performed using debugfs, it triggers
these sequence of operations: nsim_queue_stop() -> nsim_queue_start()
-> nsim_queue_mem_free(). nsim_queue_mem_free() frees the old
nsim_rq struct which embeds the napi_struct. But the rxq->napi pointer
in the struct netdev_rx_queue still points to the old nsim_rq's embedded
napi_struct. So, any subsequent xsk_bind() which reads rxq->napi->napi_id
after a queue reset is a use-after-free.

Add netif_queue_set_napi() calls to nsim_queue_stop() and
nsim_queue_start() which clears the rxq->napi during stop
and sets it to the new napi instance during start.

KASAN report:

Call Trace:
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 xsk_bind+0x1582/0x16c0 net/xdp/xsk.c:1758
 __sys_bind_socket net/socket.c:1920 [inline]
 __sys_bind_socket net/socket.c:1912 [inline]
 __sys_bind+0x1a9/0x260 net/socket.c:1951

Allocated by task 5622:
 nsim_queue_alloc+0x3c/0x140 drivers/net/netdevsim/netdev.c:715
 nsim_queue_init drivers/net/netdevsim/netdev.c:1012 [inline]
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1059 [inline]
 nsim_create+0xb13/0x1420 drivers/net/netdevsim/netdev.c:1152
 __nsim_dev_port_add+0x3ba/0x8f0 drivers/net/netdevsim/dev.c:1509
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1570 [inline]
 nsim_drv_probe+0xdbd/0x13a0 drivers/net/netdevsim/dev.c:1731

Freed by task 5659:
 slab_free mm/slub.c:6377 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6692
 nsim_queue_mem_free+0xfe/0x190 drivers/net/netdevsim/netdev.c:796
 netdev_rx_queue_reconfig+0x405/0x630 net/core/netdev_rx_queue.c:144
 netdev_rx_queue_restart+0x8f/0xc0 net/core/netdev_rx_queue.c:183
 nsim_qreset_write+0x2e3/0x410 drivers/net/netdevsim/netdev.c:887

Reported-by: syzbot+c06674caba265dc61d46@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c06674caba265dc61d46
Fixes: 5bc8e8dbef27 ("netdevsim: add queue management API support")
Tested-by: syzbot+c06674caba265dc61d46@syzkaller.appspotmail.com
Signed-off-by: Subasri S <subasris1210@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 4e9d7e10b527..c18f9f540084 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -826,6 +826,8 @@ nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
 	}
 
 	ns->rq[idx] = qmem->rq;
+	netif_queue_set_napi(dev, idx, NETDEV_QUEUE_TYPE_RX,
+			     &ns->rq[idx]->napi);
 	napi_enable_locked(&ns->rq[idx]->napi);
 
 	return 0;
@@ -838,6 +840,7 @@ static int nsim_queue_stop(struct net_device *dev, void *per_queue_mem, int idx)
 
 	netdev_assert_locked(dev);
 
+	netif_queue_set_napi(dev, idx, NETDEV_QUEUE_TYPE_RX, NULL);
 	napi_disable_locked(&ns->rq[idx]->napi);
 
 	if (ns->rq_reset_mode == 1) {

---
base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
change-id: 20260812-net-netdevsim-aad6100834dd

Best regards,
-- 
Subasri S <subasris1210@gmail.com>

