Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2E42E424
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946511; cv=none; b=ANJwzgyvlcO00rK0QtZdKR/YnETncFQXRGJMi4oe/LCQz8nShNZiUgCzlL9irL+6YO7geCNpEypoyQZ1ALEQDtP1xqai22KewLtnI4TjoyeSdfoFWTJbHZALIvh6vu4dGUqZVqFVCEBtUbuwp2xBAqCULtKXfHgoheLVsvCcxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946511; c=relaxed/simple;
	bh=hpORNAInQY4YIDil5qPoyicTIbpKgGs8vIsuPQzrju4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E031tUHkKoBEfeVSSI8Im1FWA3KJwutoz6kmBtGqD47CqG8FHpc2FqCt5qt+8eW1qWzydjsrcAbW1TWriMs9lFcPlGvjcryDobpIo0RixepcZhI+T0d7+TfL6x0qp/ItJFpOGLjjGn2bpsq8TSoevc3l/QFlGLGBaMsIg0IB12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrDlB+xG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrDlB+xG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
	b=BrDlB+xGtW6AFVmIJ/DTvMgZE4Byrr1G8VmjWOycuagWB0lLtKokmd70RZ1yoYkngxJICk
	D3VF4s8tXGP/xGup78Vm9XNbr/Qao7i8CMHfDLiBO2ze5gbvuRdzPnqjt9HsbOND67csTL
	LC/5G71EVYlnkgIAiCHQMOK3Q3tDBw4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-PRbX39NwOhW8XAmihcVDpw-1; Fri,
 02 Oct 2026 09:08:15 -0400
X-MC-Unique: PRbX39NwOhW8XAmihcVDpw-1
X-Mimecast-MFC-AGG-ID: PRbX39NwOhW8XAmihcVDpw_1790946492
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7919E1800627;
	Fri,  2 Oct 2026 13:08:11 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52B8B214;
	Fri,  2 Oct 2026 13:08:04 +0000 (UTC)
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
Subject: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core or global reset
Date: Fri,  2 Oct 2026 15:07:43 +0200
Message-ID: <20261002130752.2597259-2-poros@redhat.com>
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

A CORER, GLOBR or EMPR reloads the DDP package in ice_rebuild() and
ice_init_pkg_hints() clears hw->tnl, so every offloaded VXLAN and GENEVE
port is gone from both the boost TCAM and the driver table. The
udp_tunnel_nic core is never told about it and still considers the ports
programmed, so the Rx tunnel offloads silently stop working after the
reset. With VXLAN port 4789 offloaded, 64 flows that differ only in the
inner headers are spread over all six Rx queues of the test port by
RSS, after a CORER they all land in a single queue, the same as without
the port. Removing the port later trips the WARN_ON() in
ice_destroy_tunnel() because its table entry is no longer valid:

  WARNING: ice_flex_pipe.c:524 at ice_udp_tunnel_unset_port+0x56/0x280 [ice]
  ice 0000:04:00.3 enp4s0f3np3: Error removing UDP tunnel - -5
  ice 0000:04:00.3 enp4s0f3np3: UDP tunnel port sync failed port 4789 type vxlan: -5

Call udp_tunnel_nic_reset_ntf() once the main VSI is rebuilt so the core
programs the ports again. A PF reset keeps the package and the table, so
it is left alone. No rtnl_lock is needed since commit 1ead7501094c
("udp_tunnel: remove rtnl_lock dependency").

i40e fixed the same problem in commit 1f190d936948 ("i40e: Reprogram
port offloads after reset").

Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8c4b0fbc790644..f2121e79fca993 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7859,8 +7859,11 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_rebuild_arfs(pf);
 	}
 
-	if (vsi && vsi->netdev)
+	if (vsi && vsi->netdev) {
 		netif_device_attach(vsi->netdev);
+		if (reset_type != ICE_RESET_PFR)
+			udp_tunnel_nic_reset_ntf(vsi->netdev);
+	}
 
 	ice_update_pf_netdev_link(pf);
 
-- 
2.55.0

