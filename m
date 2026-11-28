Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795872998;
	b=q/0BAxFS20WyW9PYo6zUNhmKcM1m4YoJSh4sUXU6BcT941xY5phXI1PFKyUPy6K0SETT
	 V3ucm8EAr6f7tDg0yauUIySUbU+Xt5sW6bBavjzcsJMSGRuQCqoOLwmjRtEkzqR6/v9x6
	 lRWmeor3Txf17K1zeWWc95PD6YKaPpRggKAPg+MY1DOQ/dAu9NLuNyiLa39Xv5stwAEuJ
	 k/FzkG5UafTcbIF5Bz8rRmO15I4iBQYA6RqyDySQ4RjzD8C/HhhUtRs8EHpmzPzdIEBeV
	 zjJbay63G+omcFTQ+goZMZdgSPH/DoLCkSSWX0UZ8VplfnHqh3LVwzX+XS4vg1SXasw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795872998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=a5WxxRcYdBHgsweyummlp7eYA7vC+58yNVZbC9L/D58=;
	b=fZrTaYu4wax+qOqMs3spEQUyfCDva0+f+y3DPst+SPMR3XHvjdMxJsjV8+k+pf3pSlVK
	 1pJjKCRgjeU4W5ZVZD34MrTYBFpgKZwvqtqNbrkxSSSNmNVBUI5sZyuoi/D6IuwrlKDIc
	 99bQimqtHhxnrDm5rkP/mZ1Hvz1m5+TesQeLqk/sVSfViLUxb9KmvHVvWwMA0JikI4mK6
	 A54kBUa6+S3yaJ0W/lTltT2y1nYhmDS9/mHgefJBIPEEWul6rxeoU0TYWWYc/0PBXsPnO
	 KPLskK6xTOX/XnnCXIdHPIw94SoUbpe+oDCLWZLdfAxUBX9wPKD4376U9bCfBPkYUyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kp/deqQ9";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD3606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 13:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FAD3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kp/deqQ9
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so6980186f8f.0
        for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 05:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795872997; x=1796477797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a5WxxRcYdBHgsweyummlp7eYA7vC+58yNVZbC9L/D58=;
        b=kp/deqQ9IVh4qK8O0NDOHe7xQOIWdZ4nMx5bHaOb10okIw0aUCzCFBujPy9iUIEqzs
         sCZ/nWvycqf4/xC+0TaYXn+HUlLCPpvKf3pF6SZknBVO02qRgjbqkIPiEVYMN0K/2Tsm
         VNqWmPh7DpUsOzylXrV+yNFHfYwA63e1u00wFZW8HYj0XF2Ru45lgYQ/eDKgPapphx1x
         NSwM+3PP1qjAnACQGbGdK65NisXXmyLaiQ8uDMV/W7GAeCS57ZeHCJ3ro9hnVVR0k/n3
         Uhge6yisrtubcJB7cMzN6RDaIyD4cg7onO0u7xUytLj2DU2tjDepqxeL8rrGZ2Bq+OZD
         KRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795872997; x=1796477797;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5WxxRcYdBHgsweyummlp7eYA7vC+58yNVZbC9L/D58=;
        b=cB3Y+AqaxgPrct/uZi8OqNBSr1+eZf3/mS8Ta6pJ8qBWac3TqmSt8ox439ckpGLVQ8
         X2gsaZbOd4ar7caZYWnkf3GgMf/UIMqp2zUUMFnX1sFcEL2w0Xf1iKMlgXK2DKd0NhYJ
         2nTnku2AKcY2MMG8tRzAulrv1ItLew9QJUDOwfi+sq+yKuLWKwxnVGvk/2uY2Y8Elr/T
         crqBjs5V1rwFxFYuSnue7jftvmvum34I7naBxXbqo/bQiOQ9pPpHUgAgROQJ8kfT4M3s
         82uSrro9VdzEXdkPsYZ6xoGBQ5wSEOPlo2i6VCAhTTXU/wp2SSg7k8lI8ZEHXLVYT294
         TNSw==
X-Forwarded-Encrypted: i=1; AL+hErGpXF+y6X6NRMqh6LI5r3k+kDApzMgqrB+qrwU3ZTY0dcnw9g2YU/LAsJcKNHorCykygD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QoTp0jWg/Tr3cvRA3OAgge+kXi7JWh0GK9joDRsg0qhN1Cm1H
	z/UvV3xGKOUT4O8sFU8J8NSbBhTlYIgmaYeJOk0JL21QTs+fFE+oAIKL
X-Gm-Gg: AZFdTZf35ZgMs6h0y/cOZeJDQYEANqCpl4oURN3DPC/JhZY7RcHexLj6GZx5sNVnIvQ
	JWeOb2mVHFEjXYpWkWwSHGHA+oCu+51h9AWsrs3RVkxQeEXcS2xPlWkaMbiO9WKcjFOt2Da9hXi
	NnnkzF2lyYAOXHxP4Q1fmlriRpcOY4NdIoe8FgbdlRprfW4LMpgF9j1rxw+WdQoQTLnJX0uh45F
	SLMaowR7dZrRtjY9Km34Qvq1FTlU2UiITh96meFjczl4VBM6kz0DjYFa/OlmwG6q06j0KPb75MO
	5apP9XVuuRxTiAnxp2fP8959iqxlyZ0D14SWSa1lo5rLdV+dMs9cCwwz4CaSPLJLaaUeQynYIsJ
	Te7/W45VY/o1qBQZvD1CewOMxKMKCW1Pz0IbwVlsaXjTLC08C/abMQwx2sFHoZ9wBTKYsvz/nh7
	QfdK2H7mudZiPi01UqbUbKI+R518A8/atrHqrjJocWVePjwgxWkSmr4NjmXlUyYC01k4h8zq9p8
	lfkyr/JAmeVuvtm/E3pdeATCTcqAND8CG4MRBN3J8SsNz5NtFEyrnC6ap0s+/bKPxYvRPY+MQbF
	rGzGLBU+eiJVuivXaOPVpL95mIVkHOAoz193ivXMPhYFc69Z4E4MQqY5dmqTgJkSJg4TOkN7IV/
	cOX24qajKwrJFwWZrP+BKDNmhcXfKG1mTxBw=
X-Received: by 2002:a5d:64c9:0:b0:4a6:bc53:2478 with SMTP id ffacd0b85a97d-4abb0d5256fmr54313922f8f.13.1795872996813;
        Sat, 28 Nov 2026 05:36:36 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm54895678f8f.58.2026.11.28.05.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:36:36 -0800 (PST)
Date: Sat, 28 Nov 2026 15:36:33 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 1/6] igb: don't touch rings that don't exist when
 disabling an XSK pool
Message-ID: <qyifvivvv45lstdhummsoji6jdlgxzkfcai5uet53w2spppj6g@amdcea4m54w5>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-2-antonio@mandelbit.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-2-antonio@mandelbit.com>

On 25 Nov 00:57, Antonio Quartulli wrote:
>xsk_get_pool_from_qid() checks the queue id against the stack's real
>queue counts, which can be higher than the number of rings the device
>has: on 82576, enabling VFs leaves a single Tx queue while keeping two
>Rx queues, and igb can fall back from MSI-X to MSI with a single queue
>on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
>before enabling VFs, then passes a NULL Tx ring to
>igb_txrx_ring_disable().
>
>Only disable and re-enable the rings the device has: skip the queue if
>it has no Rx ring, and only the Tx part if it has no Tx ring, so that
>an Rx ring using the pool still stops using it. This also stops a NULL
>dereference when the socket is closed while the device is runtime
>suspended, which frees its rings.
>
>Tested with the 82576 emulated by QEMU and a zero-copy AF_XDP socket on
>queue 1: closing it after enabling a VF no longer oopses and the Rx ring
>no longer references the pool afterwards (checked with a debug print, as
>QEMU doesn't spread traffic over the PF queues with VFs), and without
>VFs queue 1 keeps receiving after the close. Not run under KASAN.
>
>Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
>Cc: stable@vger.kernel.org # 6.14+
>Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: the message also mentions the runtime suspended case (no code
>changes)
>v4: also handle queues with an Rx but no Tx ring, as with VFs (Sashiko):
>tear down the Rx ring and skip only the Tx part; tested with a
>zero-copy AF_XDP socket; subject was "don't disable rings that don't exist
>..."
>v3: new patch.
>
> drivers/net/ethernet/intel/igb/igb_xsk.c | 37 +++++++++++++++++-------
> 1 file changed, 26 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
>index ce4a7b5..3b4212a 100644
>--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
>+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
>@@ -31,15 +31,22 @@ static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
> 	return 0;
> }
>
>+/* With VFs, the device has a single Tx queue but can have more Rx queues */
>+static struct igb_ring *igb_xsk_tx_ring(struct igb_adapter *adapter, u16 qid)
>+{
>+	return qid < adapter->num_tx_queues ? adapter->tx_ring[qid] : NULL;
>+}
>+
> static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
> {
>-	struct igb_ring *tx_ring = adapter->tx_ring[qid];
>+	struct igb_ring *tx_ring = igb_xsk_tx_ring(adapter, qid);
> 	struct igb_ring *rx_ring = adapter->rx_ring[qid];
> 	struct e1000_hw *hw = &adapter->hw;
>
>-	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
>-
>-	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
>+	if (tx_ring) {
>+		set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
>+		wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
>+	}
> 	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
>
> 	synchronize_net();
>@@ -47,24 +54,27 @@ static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
> 	/* Rx/Tx share the same napi context. */
> 	napi_disable(&rx_ring->q_vector->napi);
>
>-	igb_clean_tx_ring(tx_ring);
>+	if (tx_ring) {
>+		igb_clean_tx_ring(tx_ring);
>+		memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
>+	}
> 	igb_clean_rx_ring(rx_ring);
>-
> 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
>-	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
> }
>
> static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
> {
>-	struct igb_ring *tx_ring = adapter->tx_ring[qid];
>+	struct igb_ring *tx_ring = igb_xsk_tx_ring(adapter, qid);
> 	struct igb_ring *rx_ring = adapter->rx_ring[qid];
>
>-	igb_configure_tx_ring(adapter, tx_ring);
>+	if (tx_ring)
>+		igb_configure_tx_ring(adapter, tx_ring);
> 	igb_configure_rx_ring(adapter, rx_ring);
>
> 	synchronize_net();
>
>-	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
>+	if (tx_ring)
>+		clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
>
> 	/* call igb_desc_unused which always leaves
> 	 * at least 1 descriptor unused to make sure
>@@ -148,7 +158,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
> 		return -EINVAL;
>
> 	rx_ring = adapter->rx_ring[qid];
>-	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
>+	/* The stack can know more queues than the device has, e.g. after a
>+	 * fallback to fewer queues on resume: skip the rings it doesn't have.
>+	 */
>+	if_running = netif_running(adapter->netdev) &&
>+		     igb_xdp_is_enabled(adapter) &&
>+		     qid < adapter->num_rx_queues;
> 	if (if_running)
> 		igb_txrx_ring_disable(adapter, qid);
>
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
