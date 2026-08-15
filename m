Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D613BB4A
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786762182; cv=none; b=NJ6kYPVBLs+DLNeuO7zeP1rKvhXmnmTOvruNtts9BUj++wf+AxkNYeg1+BFvZfZuAKNKhC3mZ+Jgb0dQ4ffBRYvNxWOQgJMErz/IQQrlYu4z4lxE0BiysZ2esF6ORUoeA7Glo7sjc5sGYFaLlSdV4BB4Osvdeb77l1kqBeyCwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786762182; c=relaxed/simple;
	bh=8erP/Asya2a+kNntt8VAAbctyJ5EvZRb6q6Emq0p8mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O0A37h0aqZCTHhhmDUPFgmKRtSG5at9ClZZTd7XGVTQam/nHwwQ4bGBKPqdvCd1l7M8hhHBgjWqOPKV7RTZmpIfKQYCJuDIN/NZNAA2B1iNqN9bbP5x2dX2nYIu/Scxgv/VkWl7ZXSYcklBKReGuCsbe4xCNGMBUHmPFn8iFHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC1gyp7x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC1gyp7x"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce98cb8165so16922655ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 19:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786762180; x=1787366980; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IIvJ1blTz+UFWJgsOaLwrhZp/iq583kjurc/RnG/+o0=;
        b=kC1gyp7xsgMniYuWwZXrC5+ZOmsiGYY6kprbMKvvWxj6YhP9PNtIKSwQBnxVjG3atr
         y90wKEeNPSqy9RMboiXKJXPAU0NL5WRN3vRYe3QXmwp0g/cyEauxNwGSBhAQs9gyxhfH
         PXmqlrI7RlULUK9Dwq7S0Zw2v/d/KUWnwk3oQdo39gz3izGtNptYHxHpw7hfN7ex54Nh
         RTKjZgUfmFI9goJg+ZOx1+YmA1a9nmVjao3/FLD+v9XGzHnvtTLN1dBft+OojYd2v+EC
         WbHXsJxQQyjLrrLWXHjGb7PsS+ZJ0yNZbY+81qQdeigkCsGm7Ie59KtZFF7Uq7m0NAtX
         I0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786762180; x=1787366980;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IIvJ1blTz+UFWJgsOaLwrhZp/iq583kjurc/RnG/+o0=;
        b=qSk+yWJ04HpfKpSVdtoe9jqPycLNZSbMBfWt5c31VOkzg1yOM451/BnFEGSfnO3yZC
         o6Mt5FXhRz+BKIRgEnG1blvlZ5bUkJc5IhxM2OMOd4fuw5sAFdxGSP9+zia2F1O1a4XJ
         keuah/Ymw7UlbxP2kQS8NznxRffcGysNKJENdhMjZOZdOc/rtpS/lDnB9wD8Vid+jSr7
         YiLAKuozpfVacfCEdBTdHy0BqowEnZZn+V1xg1xqkgPr4KrnDSt+Db2JNEsqzZc1ywel
         Ugn4qF/2YsskUfy8fgVHEeKE7uQUZjxTKzVszspeXxyBmzp4VCZTcYFdQdXGv+bzk3b2
         yIKQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVR8nERX1azpIbE6f1Oa6x96V5NuyXmWW++Il9zfAtDTnWYJEinq3+oTFQAHIm46xtw74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJKPw0QKnZbyTKXfVyGSo9vmloBd1Pv1Al/1T1KCShFrm4sTd
	H+eA6cjy5wm69F+nQ+Og5Viejzs8DRwDxzb+T9N7TE+4HNlkPpSPLszw
X-Gm-Gg: AR+sD12tIwunkzDq4XD4fJuBj0TnwwcsxHneUn+1OB81DSTNnJyygXntcGrrIA31xGn
	QTZdxLEYvOvdnmRnfRUD5HB4hvB1OZFx7NBUv92l0PxKAq+kBHRD1ay8uBzvyrBfhl40bukDpue
	S7ZVKzI9+VjaciC+NmZHtaKtyf5eAxunn24N/wRyMEEeYUidzCsO+Wq7DxvO8dkjjDEMZuhWiYm
	b/AC4abROQnGmnP1ldsePvZr4XCzi6jGGSoIV1KC7gsBbh+9aGLbcDBbN/qToQ9NNXtBSDzytIT
	HCWGasmNIH5wqPEpQamHl9HS6+m1VqeeYX6AHLvYEP9PB3iB8vb94Vb9f932BhMx05ZsZXt2gT0
	y3aTgv1qZbAUkxMKcpPdOP6HzXmsW+HX4j7bYvi2AScvqXIMWzTRFa+A1Qn4tPgZueHxtNSc+OA
	A3z0PiGo2KQAFGVAzbe7SqRy3Lr8R8ndKvhF6suVMz0bezw9WUws75pLlaqg177/O8
X-Received: by 2002:a17:903:28f:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2d37f5cdcebmr193217485ad.2.1786762180080;
        Fri, 14 Aug 2026 19:49:40 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:3:acc1:3aed:cc76:df6c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df03f9sm10088705eec.19.2026.08.14.19.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 19:49:39 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Date: Sat, 15 Aug 2026 08:19:32 +0530
Subject: [PATCH v2] netdevsim: update rxq->napi pointer during queue reset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-net-netdevsim-v2-1-d6c85c5157a7@gmail.com>
X-B4-Tracking: v=1; b=H4sIALvTf2oC/3WMQQqDMBBFryKzbkomVUm78h7FRTCjDjRJSSS0S
 O7e6L6Lv3gf3tshUWRK8Gh2iJQ5cfAV1KWBaTV+IcG2MiipeqlRCU/bMUs5sRPG2B6l1LfWWqj
 OO9LMn7P3HCuvnLYQv2c+4/H+K2UUKDqFRnfUznTHYXGGX9cpOBhLKT9RVi+YqgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786762174; l=3558;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=8erP/Asya2a+kNntt8VAAbctyJ5EvZRb6q6Emq0p8mA=;
 b=O+eSHxzLdB1EtYOQbQ9sXoXITZP5TFippK4+RNrQuwJrewJQL9FPYqtY+fpt8x+8+K32adMz1
 e117INoBBaVAcAwu7heRrUWcjUP5xdv8iOLbjQUjQl8eDQCbYrCFeAN
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
Changes in v2:
- Restore rxq->napi when reset mode is 1
- Link to v1: https://lore.kernel.org/r/20260812-net-netdevsim-v1-1-521a85e4fe91@gmail.com
---
 drivers/net/netdevsim/netdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 4e9d7e10b527..291d34718b2e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -808,6 +808,8 @@ nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
 
 	if (ns->rq_reset_mode == 1) {
 		ns->rq[idx]->page_pool = qmem->pp;
+		netif_queue_set_napi(dev, idx, NETDEV_QUEUE_TYPE_RX,
+				     &ns->rq[idx]->napi);
 		napi_enable_locked(&ns->rq[idx]->napi);
 		return 0;
 	}
@@ -826,6 +828,8 @@ nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
 	}
 
 	ns->rq[idx] = qmem->rq;
+	netif_queue_set_napi(dev, idx, NETDEV_QUEUE_TYPE_RX,
+			     &ns->rq[idx]->napi);
 	napi_enable_locked(&ns->rq[idx]->napi);
 
 	return 0;
@@ -838,6 +842,7 @@ static int nsim_queue_stop(struct net_device *dev, void *per_queue_mem, int idx)
 
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

