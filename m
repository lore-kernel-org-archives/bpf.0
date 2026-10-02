Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0779409285
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946521; cv=none; b=fIpUjAY93M2MgQ0z9HlH5tE4ortR4CrxN5nUtSNJDGjgJCFiAXnsbg7H4fapBKQ+tqUhCOwyBG6GJDmFiUsTWGtDZRWR2/qx3YCkmcRz4Z8onAw8PJe6QJZleCDfvpPjKIzJSkt7S1ptjYN2Nx2d/d/L+CBkhYvRc933sP2r4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946521; c=relaxed/simple;
	bh=BsOmyTLRxXj5mV8UAW7p0quPoKvfnvvSiG/iz/+xEYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjWnJLyyppD3i87TzJmipeuOrVEiVE06kfdizotrZPy07cDvJsppWvL8ykK5fsN5sLrjSTI7oZYcLmttv/4FG29tuwRtWq+VVmuCcTnRkR99D8kqWsnBkAB+n6NiexM/7dQm3vKEfG584wVou3WK+Is0TU+VIwdzGxeUWAdmlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXMQifgX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXMQifgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czBirh9gsxqopfneZqb59N/cedGnNYhxy5ysmWPWLCU=;
	b=IXMQifgXXKzi149/JNSXkdp0DCZ0Plfz51LYnL4oKH7qJYwwCRJNzQh6isV5Ao2W3qyBPW
	W+yCIkzBUgRoOFDDevdKbqeP0VHFfsTE1evTIfCZQeSOQTgBcxtji+uQl+I/0tTyO5zUOg
	jj8UmTAG8K4Z6bQ80vxXvOAauIlMw64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-1JIUFIEjORuZQTPXb4QapQ-1; Fri,
 02 Oct 2026 09:08:29 -0400
X-MC-Unique: 1JIUFIEjORuZQTPXb4QapQ-1
X-Mimecast-MFC-AGG-ID: 1JIUFIEjORuZQTPXb4QapQ_1790946505
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C60061954B30;
	Fri,  2 Oct 2026 13:08:24 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AFD2433;
	Fri,  2 Oct 2026 13:08:18 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Henry Tieman <henry.w.tieman@intel.com>,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Preethi Banala <preethi.banala@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when ice_vsi_open() fails
Date: Fri,  2 Oct 2026 15:07:45 +0200
Message-ID: <20261002130752.2597259-4-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

ice_vsi_cfg_lan() adds the LAN (and XDP) Tx queues to the scheduler and
enables them in hardware. If anything after it fails in ice_vsi_open(),
for example requesting the MSI-X vectors, the error path only frees the
ring memory and leaves the queues configured. Every following open then
fails to add the same queues again and the netdev can not be brought up
until the driver is reloaded:

  ice 0000:04:00.2: Failed to set LAN Tx queue context, error: -5
  ice 0000:04:00.2 enp4s0f2np2: Failed to open VSI 0x0010 on switch 0x0002

Stop the Tx queues on the error paths that run after ice_vsi_cfg_lan().
The ice_up_complete() failure path already does it through ice_down(),
so let it skip the new step.

There is no i40e counterpart of this fix, i40e does not add its Tx
queues through the admin queue. It was found while verifying the
previous patch. With the IRQ unwind fixed the warnings were gone, but
the netdev still could not be opened again after the forced
request_irq failure.

Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d246cde36ae726..e62a8f544345a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7561,13 +7561,13 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	err = ice_vsi_cfg_lan(vsi);
 	if (err)
-		goto err_setup_rx;
+		goto err_stop_tx;
 
 	snprintf(int_name, sizeof(int_name) - 1, "%s-%s",
 		 dev_driver_string(ice_pf_to_dev(pf)), vsi->netdev->name);
 	err = ice_vsi_req_irq_msix(vsi, int_name);
 	if (err)
-		goto err_setup_rx;
+		goto err_stop_tx;
 
 	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
 		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
@@ -7593,8 +7593,14 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 err_up_complete:
 	ice_down(vsi);
+	ice_vsi_free_irq(vsi);
+	goto err_setup_rx;
 err_set_qs:
 	ice_vsi_free_irq(vsi);
+err_stop_tx:
+	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
+	if (vsi->xdp_rings)
+		ice_vsi_stop_xdp_tx_rings(vsi);
 err_setup_rx:
 	ice_vsi_free_rx_rings(vsi);
 err_setup_tx:
-- 
2.55.0

