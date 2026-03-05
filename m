Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66252EBBA1
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758290; cv=none; b=pDJ4q/zogFW8Wx7XzhmLDVmKAhNRAAjTx2alLGk3xgn7zAXmYyQxw27KStTPX4SsLgPW0DFH5SmFB6fB4X0xFClC+G14y+PgmBg1vzjPIGqLYr44E5Mi/UoxoYSZNBqZerbIO9Y1WcZjzygLX3jR0W7o0rDwkPYVDm9NypnvCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758290; c=relaxed/simple;
	bh=cnxiDzaTG3dDRmVmA/NbvEgeXNe7TfmfMEbBpvNLqsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YB78HwApfi/cJNzuw9SshLwYDZz5pFQpG+OlcbVPJxu36oT3Ry6+BQ7CQHOsWlr5IXEM8W517nlOT2GrltKhpfYANVQ0yI2/LTaNDVUQeYWbXilZjrBq/iV+kxXMVF48nO1Q5sRqBdm5J0qqk7bLysJ4xVNOy9E/rvBuVTGpekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y9ulyBN2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y9ulyBN2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso74457065e9.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772758287; x=1773363087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBymiq7nID2vF4wesRN60I/529SDzorxfefrpkxAGsE=;
        b=Y9ulyBN2TboxJapIVU/QpaaqcuqdNZsdKSPhDbqn7M1wb+Gt7W3RHQrv+943Ji8pVv
         GdpSdvhxVnHWqSyg36PVB3tJeAy1OckKk/kzs2zU/G2IQTBMp+3It1M7cGbC0JmdnnQf
         zkR7VwWHUe8BO35sz2CwVqHaVMDo6tdV+1IXdZaUFxov8ebg9noVx3IpgoAvzb0yZ9TF
         /R6ltZq3LjkD20KGYgAV8Q217kJE4Y6a/FlgEHehq7PKsp71JllfSqAsTHHIKh8om+fb
         Vaqh3JELWmYoN+BI+XITiXjatczzHzMKUQhmeC9jDXLilzFv84DOO87bf78Km2JfOYlA
         xHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758287; x=1773363087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBymiq7nID2vF4wesRN60I/529SDzorxfefrpkxAGsE=;
        b=wUAcQSC7ZK5xVuZv0jbt3cvnafAjllDeCU2711f/ESBNZVcZ74F3xyrjrpdcKyShu3
         mZrpVHNktdM/h8AFhw7gA7MNT/DQ7zv/a2bbRNj95iWUy5H5wK9u9lW6GmNHL0Xwq2er
         1KKbIix5FV2MKt0NNJ+ScarhVGPPs8TVuldxddmzOSzfGXvmIsmxfJVAj8iuZi21IjaC
         0lznFy86UKNeyNVi3EndOewgagUpa6xRet5+zTLQHzfXe/SV+WfZTq9Zz+8q4r0XUqXf
         /AAm3PGTxf0zKQzXgBkmoUNMjU6X38fK56HRZMl7ef0KHZmyh8Azmode5QvnQZtabC3Y
         J3sw==
X-Forwarded-Encrypted: i=1; AJvYcCVPlzrXE7M9/Ue9qVZYYinzRm/0hm8cdNGprInWVhzHabRFO5qopw2upgnVEYsNODiHW6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bncokaXsqVFhOHBwoDrqY4HYpmp95I7bZc07APCF3BNKuGUN
	YqaeYoUgG7Zx89YXxW9XK+Sic/g/0vyWfYCGGBe8LyfXpnP0pmkgPtr6iygzO0w5NUuoFO4EG/O
	t4zrlIz8=
X-Gm-Gg: ATEYQzzayYV6cMRQKwFWqFzq4mZjax+I665w8KckVeGmnetxf3ZD7J9kU+e+WkmkoN8
	RTWZ/xs0IwDshbewNxpJ6qV3l7WEkKBdZcYbNYYSt4zlew/MI8DEtKc9uWuSutfdKv49lh1aqvW
	zurhfN/m+k8XLtbzUEAQSxlVAIvGJfVbLyWDqZWsKqguR9k0LDEXSQcUu30ONHf/wXzo+9txWI6
	FnCAz3C26hjZu57AZ+/YgVCUp+3k/1LtBc8s5gGPbh6HssSGegFR7CmtZ1X++TNyDudoc7T7/8u
	i3w1yNTsR8GFz3E5C+ivwXH0GvJpm2yxpYQKMiH5iAtp4aQ1zvkofPpD+6QLuWzPgn8d20Vi5o2
	rq9JX3gpH+OSPGQeyG7D3FDJPqzuwOUW47oqqGHSKVhDQX4ZJsmDuykkOBtP971cIRvJnOMMgZx
	jEquuHPrjqhQ==
X-Received: by 2002:a05:600c:6091:b0:483:348a:d3f3 with SMTP id 5b1f17b1804b1-48526951407mr3034345e9.18.1772758287161;
        Thu, 05 Mar 2026 16:51:27 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b30a7dfsm18159241.1.2026.03.05.16.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:51:25 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 18:29:57 -0300
Subject: [PATCH net v3 3/3] net: bonding: Fix nd_tbl NULL dereference when
 IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v3-3-fde28b30a744@suse.com>
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
In-Reply-To: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772758271; l=2650;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=cnxiDzaTG3dDRmVmA/NbvEgeXNe7TfmfMEbBpvNLqsY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCeaab2VG6SN19YjJGx7LvW/Cy/wUY7jy/zKw3gbh62MKk0ZHFa2/59rF5Mk/7noRZ3PhAaA1dT
 CttVGN1hT0AY=
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
 drivers/net/bonding/bond_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14ed91391fcc..7d32cd231633 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3256,6 +3256,9 @@ static int bond_confirm_addr6(struct net_device *dev,
 {
 	struct in6_addr *addr = (struct in6_addr *)priv->data;
 
+	if (unlikely(!ipv6_mod_enabled()))
+		return 0;
+
 	return ipv6_chk_addr(dev_net(dev), addr, dev, 0);
 }
 

-- 
2.53.0

