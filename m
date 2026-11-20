Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187211;
	b=RK8uNn/I6+jbVQ0402leRCiuvCY58hQKjHlga2x13IF5nDk/M+C6385STGNGHth9MQFA
	 pi6tArYxNIi6RpE4TpP2fUOP7PbJRwDRc6Lv15aW9Q7KUbGUwUzF682bSgeNJIdI7hdKj
	 r1AJvw9UaB13PZCdqvw8WFzZwYcCnrPxBhM9g8nqiUd21S8yVMIYtjfaGFUhnXo1vnANa
	 wrjnSQ4OjLkYm4IBt9IPksoiSK3vK30fQC2TJjhjSou6WHQ8lxekViBXjhXFbsjJF7Cod
	 cYQPAiFA/GpeJ7pcXWAmYxs8HJMniqhbE8hHpRouKnEuKtWcNzQR7eJ3cKX6uuOmDGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zX8OGEfLFGtorWxYFS4Yag3CUaXahlHcZyg8u0XBH7A=;
	b=Unpq8oSJAZYjHfnDpXK0g+hTB/wCcwhWC2BlHhYrLNu7KFXDJzRYOY/o3c0S0Ub/ovpT
	 /opR61+fXpoH/qRAW+QXa08QK26O2xIMcyIBqeRuyNRehc1C3fJPr9rcx5HCES198e3A3
	 x4PrWW2RpQBFmBbpMonJC8+O6r42E0t5MblJWAw5tcTOtkqUWm4A0tBPa6+1FopDKwXp4
	 OIrgddB9fB29uCIDrzCliZr5O/up7koiR0MJwTd4r1RV7LtcW+RAxtRIdIpLfOCMjCaaA
	 CSPeTSNCYCIvqushFeuj5Npj3ju9BAQ+cIsp/6600XiEYd5AiE6RlcFruaRj6YhxB0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U9Xs8Go0;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C363606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C363606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U9Xs8Go0
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3b4944a0eso859152c88.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187210; x=1795792010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zX8OGEfLFGtorWxYFS4Yag3CUaXahlHcZyg8u0XBH7A=;
        b=U9Xs8Go0LI27CFYgd/KCrk8P8ekUhLrKSnTDBEHNpIoBVvnC5u5iTzLGHtq5DpGw4N
         L1/DcuNq3sdjBEdI1uA7K2NAdvnBGMLRkQ+EHZYGtYWSmnC1NC0rwHBpRmdsrt5fINvb
         OOGZuk19fM0kUOfoGeROKz3/J41QB5h005Kuv0VvYKgjkAlsSVmyg3+g6l3G1Y6XDZfa
         HeuU7hx9G9Ri1fF+iENd7oFiDbR5P1mUQRA+K8RSVMvo5TQAJJPQNidav/ZUPRSdAtUG
         tQcMl3m4TgoJE0OSPhS2tXOBt23YAKlS26L+6gaeRTg4b6QaDj5aYprw3UJM/RovJOYH
         JFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187210; x=1795792010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zX8OGEfLFGtorWxYFS4Yag3CUaXahlHcZyg8u0XBH7A=;
        b=eLTOHxTK2UtsCd+eGWiq9XXsJgdG26GT3Km2tXSkBt/yXgph4M6jYHP8zdcj0xDUWJ
         XPYstAFQMBQGuHlfs+mwA4+DOWyI6wG2jH77lo4cuhdlg+4nulPrSBuRj6pxgK09vyFP
         HpCC9R3pOjpcKbcP/diET9ps0uIE8PAyPlvrvdarAtkifDepFkO5Xo+ISOE6TkT8rnNf
         zbcjYo40la0uPuEXFKIppQ9DDfJfexQRefWOhrZ+TzCmdfNY7YQIOEpxx922B1IAvCeR
         j70h99n2ItOoF17x+imTEcr+y1KZvvne5/YNn6MDDLrKkVR1Zzkyu4ZvSAmMM2Yo4V2J
         g18w==
X-Forwarded-Encrypted: i=1; AL+hErGx8Ne6v+yT3ySdxmH2bO9kjxvw2UixjR4rjU90yGb3Q9qeUJRlmBU5Ri6cK2lM2i3PjFI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ouAbu5fDTHo2we8fghODr+UZb0uej49TBk8vAB2Tov4txW+Is
	b6wL4l1yjv6HMnK2ra/VA3VN7CXV1wcMmpubkcSfDQFL2/muraSYyaeQ
X-Gm-Gg: AYBFou31QT6MAGos8MdrhUdFUUrFG10pY+1F3Zc7YjpP3kbynzg8hn91r2aS1JFO8nX
	ygyC1eysJdu+rsEHbuxuOoSPMYFZiMAMUAgf65bG0xyEhfoZjWXPNkpZKqwdNpsiyYSPvBBawtO
	QrEkCEw4vl0T4c0Xyajs30vjKOdg92xUntyQkT8I4hHGxfF3okKl6RNRIfviaXLk9FBP7sqXrRs
	T0PiWlpUC8w3+6lBqIJy+6p2Px9Ksoz8UqxbgAF97/SCwMzOG/7hjgmaLtbBez2rD3y5cCOvbaN
	vnUnIpLZ540oiCiJ4ZfwguHDkBM17HiA1VXbU7boNTf/PKKhUWM+trPmlpLl5pTqxK0UKJFgK4d
	Ra8V24KSt+q+CPMrJTtfuu/2ARIxHRvL4Fd6er3X0wc/aGSlQ6SovioXKXK02UANs0M2WQa/Hdz
	ra4nA3qEv3ondGJm7Z92tE1WnI9dXLLWKIwcoVaa7RQu0eMLPWaZqYW9+V4S2f+xZ+tI9sGbZ/b
	gtmMbiE8Y4+3iJZNItQO9BaULqoM8rYbfjOVLraUFi4XtZZ/LbGxjEYJrXa8Gf9X6g3ph50Naa+
	ZrDSU9jxptZHOmlKS+x8K6Q5QDYLD93ikoW2ZKSAIAz4z1zFPgre1whKa9QxOyg=
X-Received: by 2002:a05:7022:3a83:b0:1b0:20:6444 with SMTP id a92af1059eb24-1b55690779bmr3017028c88.39.1795187210255;
        Fri, 20 Nov 2026 07:06:50 -0800 (PST)
Received: from IN01-9QQVVV3.CAMNWK.COM ([171.76.82.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm7844902c88.12.2026.11.20.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:06:49 -0800 (PST)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Subject: [PATCH iwl-next 1/2] i40e: wait for one RCU grace period in i40e_down(), not one per queue
Date: Fri, 20 Nov 2026 15:05:26 +0000
Message-ID: <20261120150527.14649-2-shital.gandhi45@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120150527.14649-1-shital.gandhi45@gmail.com>
References: <20261120150527.14649-1-shital.gandhi45@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i40e_down() calls synchronize_rcu() inside the per-queue loop whenever
XDP is enabled, so bringing a VSI down waits for num_queue_pairs
back-to-back grace periods. This is paid on every ifdown, reset, MTU
change and XDP attach/detach.

The wait is there so that in-progress ndo_xdp_xmit and ndo_xsk_wakeup
calls have finished before the XDP rings are cleaned. Both bail out
when __I40E_VSI_DOWN is set. When the caller has set it, as
i40e_vsi_close() and the reset path do, a single grace period after
that covers every ring. Callers that do not set it,
i40e_vsi_reinit_locked() and i40e_set_ringparam(), are not protected
against new calls by the per-queue wait either: a call can start right
after any of those grace periods.

Wait once, before the loop. While at it, use synchronize_net(), which
takes the expedited path when rtnl is held, as commit 405d9999aa0b
("ice: replace synchronize_rcu with synchronize_net") did for the same
pattern in ice.

Signed-off-by: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e81..99f59079d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7611,15 +7611,18 @@ void i40e_down(struct i40e_vsi *vsi)
 		i40e_force_link_state(vsi->back, false);
 	i40e_napi_disable_all(vsi);
 
+	/* Make sure that in-progress ndo_xdp_xmit and ndo_xsk_wakeup calls
+	 * are completed before the XDP rings are cleaned. They bail out on
+	 * __I40E_VSI_DOWN, which the caller has set, so a single grace
+	 * period covers all rings.
+	 */
+	if (i40e_enabled_xdp_vsi(vsi))
+		synchronize_net();
+
 	for (i = 0; i < vsi->num_queue_pairs; i++) {
 		i40e_clean_tx_ring(vsi->tx_rings[i]);
-		if (i40e_enabled_xdp_vsi(vsi)) {
-			/* Make sure that in-progress ndo_xdp_xmit and
-			 * ndo_xsk_wakeup calls are completed.
-			 */
-			synchronize_rcu();
+		if (i40e_enabled_xdp_vsi(vsi))
 			i40e_clean_tx_ring(vsi->xdp_rings[i]);
-		}
 		i40e_clean_rx_ring(vsi->rx_rings[i]);
 	}
 
-- 
2.53.0

