Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AD430BA9
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300825; cv=none; b=jvYUfD+2gr3Wr4W2PJluoG4bl2nYbYIcAhIbIfkJh76f1DiFEuroINbnyvlCmydfS52jmQMj3KZ3Vd+vpWSY6ANz61YmDHsEcJxo3p+8wpm2Hid7k/BwNroNhaCfLN9t/VUsN++Opl5JEL8WT+Zjdls01DhfAfHbV3+Zij74A/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300825; c=relaxed/simple;
	bh=6Vq2LsRK/4jiYa/npkCuXmW6QF4BbW5GSecwBZSxdcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmLyAnNLXdMNS7JBr9/r87W5x8w4uOMvR89oYjKWH0UKJERrH9uSXdVqHysxQAOTCqEtw37X6p2+pUXb9LFkyAoaEZc3sds6vGMU4GOymj6yqDKHj6nVq9B7EP16ejOJHwVqgDNxJn3wkSPoSJrhs7BimjPwk9D+rvqYPL20cBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WBW7VvjU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WBW7VvjU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so34695685e9.2
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772300823; x=1772905623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COP0NwgzPdsKfGpPNF1RnyK8e2xrZgwnox+a68B1Ldg=;
        b=WBW7VvjUcPFlx3wZvEXOT/olZZEWTHFLLjp/OQdVBg7bmEh8aaMvJ+MiCnzkC8LK/e
         G6adkcJ6v17R1ZwB2P6KIkccP7OIygT/556mtVzwRqYLwkXBpvAGKZrzrhCB3o6qbnp3
         m3TQZDa3D4fDc9nTmrU5erqAxwO6MxCChX47PhIfdaNF+2K/Gg060BAQfOCxtow4dIQV
         kj1LLYKr7bxQq8+kKatbiTL2e9nRESfR4pXvVb3h1+bm7Qy0u5MkG2IIv7/339DERR0p
         Q1IZ0+IMiuTe7radC5sLxaYYZw/FreAj6y7951Pae5HXAzJW0m+8fD5M2ZfBl2bie/GA
         yidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300823; x=1772905623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=COP0NwgzPdsKfGpPNF1RnyK8e2xrZgwnox+a68B1Ldg=;
        b=PhitQ56y7PpIV3f0FsB+uui+VsRgGw5NOWbsrhamfPx3PuTw6wDw9mw6w4DAAqmou5
         CmGiytSqzoqjTcGPgUyosItpi+3x3nelqGx0jPc8JfxaJcOkyKH7ltxOOAW53XcqlOQI
         xCbB1ir+lZV8eZEo2N5jxKHcfI9CIvoiysPdqSv65rmO6jT13jpAUJgQ8ll7/zQeIzDu
         peY0BPYaWH8ARgVg4BN1SeMDWA3p6bSskn1DhEqWk54Y/mgH7Pxk8H2KPy9GzeUNyOh4
         +3O6NGy/U2pAY5luimXJHCncHhVIToyKA058qVonzaystrsaJteqqS2IixN7lWwQsBzh
         JPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAWqwrtAGF0xHbTviM21z6jTOYCgF+MPXn9hNps8ipn63Ga5bZIbCihFKmchg+4Y5fFhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhmxO3L8yVFIRW7pKf0FaCFfoDSHwgJp+rvxV1ERDXh23mCrD
	RiOn+E0XObl4hMpi3p5cilNvRdO9AINSzpApmChjArO6abkMwHD5wSDfepOAf2S8ztQ=
X-Gm-Gg: ATEYQzxSqSdOxDAzo9rBqqWkN2XvYmN3+8ay88QFiSQ/i/C1NePajOm04pGfrSZ63Wd
	kRBhjUhURP4iaCYQGoP2C8QaYzX1VryCDGTVCvPk9yWgfnIR91TnxiS+z8rwpIv/CeG4eAC6+8K
	GKspi7UK83olchOdp0dKZCNVZzrlWSLxthiAulWJWTRia5TZazf5ania22Jl1UAqdgym+R4my29
	QVTvxynD+NYNpOSyJzsLa4+PKY4n8BIHLwCfYuypuh/Os78sO4YvIGKkE1/pLwEUM/EbyogVrVO
	4dDHQimwmibIhQtW7JyUFTPp5BDLgJJ/tTX9m332JZO5nxUDv6L/1cIRj/FYDdHQ6+E+wtY61nN
	VLaLXvcUW7njpw/A+sGMEE52c8CC/nxS6qW5oZD4IOMjysyS3nxCh1f1YtpBnDJ5sTbEJmrjtkI
	WifL/HcSZZ
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-483c9bb1fb0mr111358285e9.10.1772300822706;
        Sat, 28 Feb 2026 09:47:02 -0800 (PST)
Received: from localhost ([189.99.238.12])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e845aabsm8703044137.7.2026.02.28.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:47:02 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 28 Feb 2026 14:46:28 -0300
Subject: [PATCH net 3/3] net: bonding: Fix nd_tbl NULL dereference when
 IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260228-net-nd_tbl_fixes-v1-3-2b2a274df9bb@suse.com>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
In-Reply-To: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772300803; l=2807;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=6Vq2LsRK/4jiYa/npkCuXmW6QF4BbW5GSecwBZSxdcI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH6rfP/je5CBrV2Jby9mnvCs0cF3g4KzP79mNzoDtuBgIKQoDkGjqs0qNmfdqL272G6H56/P0nd
 IxpFrS7ofxgo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called
which initializes it. If bonding ARP/NS validation is enabled, an IPv6
NS/NA packet received on a slave can reach bond_validate_na(), which
calls bond_has_this_ip6(). That path calls ipv6_chk_addr() and can
crash in __ipv6_chk_addr_and_flags().

 BUG: kernel NULL pointer dereference, address: 00000000000005d8
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:__ipv6_chk_addr_and_flags+0x69/0x170
 Call Trace:
  <IRQ>
  ipv6_chk_addr+0x1f/0x30
  bond_validate_na+0x12e/0x1d0 [bonding]
  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
  bond_rcv_validate+0x1a0/0x450 [bonding]
  bond_handle_frame+0x5e/0x290 [bonding]
  ? srso_alias_return_thunk+0x5/0xfbef5
  __netif_receive_skb_core.constprop.0+0x3e8/0xe50
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? update_cfs_rq_load_avg+0x1a/0x240
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __enqueue_entity+0x5e/0x240
  __netif_receive_skb_one_core+0x39/0xa0
  process_backlog+0x9c/0x150
  __napi_poll+0x30/0x200
  ? srso_alias_return_thunk+0x5/0xfbef5
  net_rx_action+0x338/0x3b0
  handle_softirqs+0xc9/0x2a0
  do_softirq+0x42/0x60
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x62/0x70
  __dev_queue_xmit+0x2d3/0x1000
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? packet_parse_headers+0x10a/0x1a0
  packet_sendmsg+0x10da/0x1700
  ? kick_pool+0x5f/0x140
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __queue_work+0x12d/0x4f0
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in bond_confirm_addr6(). If
ipv6_stub->nd_tbl is NULL, return before calling ipv6_chk_addr().

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 drivers/net/bonding/bond_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a1de08ee3815..013d037b644a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -90,6 +90,7 @@
 #include <net/tls.h>
 #endif
 #include <net/ip6_route.h>
+#include <net/ipv6_stubs.h>
 #include <net/netdev_lock.h>
 #include <net/xdp.h>
 
@@ -3251,6 +3252,9 @@ static int bond_confirm_addr6(struct net_device *dev,
 {
 	struct in6_addr *addr = (struct in6_addr *)priv->data;
 
+	if (!ipv6_stub->nd_tbl)
+		return 0;
+
 	return ipv6_chk_addr(dev_net(dev), addr, dev, 0);
 }
 

-- 
2.53.0

