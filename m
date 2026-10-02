Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9121409285
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946531; cv=none; b=U78UAcNgRFjdSq4IHGnZwgfs9qc7YeZBabn8FkLvJeGfT7Wqeb1a6U27dKc2GRAXx/3pmkmviRSklZXfAaZWE1dED18NmR+C9PbRHJPj2yHeaCXgjp8KDvKpoWlxj4tSOmglX9jsyOxTnfoyi44iFxiG+sWRQT3FY3sIfxtuzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946531; c=relaxed/simple;
	bh=AYSBucpVLMJSSeh/qGfbTNQGoN6rCWTOBYR7pNP9scQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRvGIvwaTjFIDpxV1C9KWQJQyAd+N0lJqJpQJAv0YhNuEnXQ/tlGxD33V8oqtFJrxjYL9YPmVc3V6EO4O+cAYQRGsEveHLccacBzUgeNNPgugUphpmDkOgpWenrw0c5IsuA+uWg91BSCnhw/Fodz62oiHL2q0+EvvX7iOtjdbSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CI9HwCNf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI9HwCNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eN97Wzb1hwaGIFrjsjx3HavMNO3OT/k+Ap5QlKepMp4=;
	b=CI9HwCNfZpE1YOTcIAac1hXIXHOZr5JQHHWUDKoXyrwC+8/TmRnnwmm5kQzRepqv26zX04
	ya0KrrB2rMbtSc9QstmwaH/wK+83Ro0EmiloV/ivzzLdm8sCNatXKBtN/Vmg2X/kZ1uEu5
	wWyjJRxV8ujib6QWnjXA0Si3HzkBcb0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-zxc_ipEqP0ychNpcLssyoA-1; Fri,
 02 Oct 2026 09:08:41 -0400
X-MC-Unique: zxc_ipEqP0ychNpcLssyoA-1
X-Mimecast-MFC-AGG-ID: zxc_ipEqP0ychNpcLssyoA_1790946517
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC6801954219;
	Fri,  2 Oct 2026 13:08:37 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC7F2754;
	Fri,  2 Oct 2026 13:08:31 +0000 (UTC)
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
Subject: [PATCH iwl-net 05/10] ice: report VF tx_dropped with tx_errors instead of tx_discards
Date: Fri,  2 Oct 2026 15:07:47 +0200
Message-ID: <20261002130752.2597259-6-poros@redhat.com>
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

ice_get_vf_stats() fills tx_dropped from eth_stats.tx_discards, which
ice_update_eth_stats() never updates because the GLV_TDPC register it
would come from is not implemented in E810 hardware. The Tx drops of a
VF, such as switch drops on an anti spoof violation, malicious driver
drops or TTL expiry, are counted by GLV_TEPC into eth_stats.tx_errors
instead, so the VF always reports zero dropped packets.

With spoof checking on, a VF sending 60 valid frames and 30 frames with
a forged source MAC shows:

  vf 0 ... spoof checking on, link-state auto, trust off
    TX: bytes  packets   dropped
          3600       60        0

Report tx_errors as tx_dropped, the VF stats have no separate error
field. With the change the same test reports 30 dropped packets.

i40e fixed the same issue in commit 50b2af451597 ("i40e: report VF
tx_dropped with tx_errors instead of tx_discards").

Fixes: 730fdea40bef ("ice: implement VF stats NDO")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index b21279f0f5f1e1..8faddf8ba0d523 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1640,7 +1640,7 @@ int ice_get_vf_stats(struct net_device *netdev, int vf_id,
 	vf_stats->broadcast  = stats->rx_broadcast;
 	vf_stats->multicast  = stats->rx_multicast;
 	vf_stats->rx_dropped = stats->rx_discards;
-	vf_stats->tx_dropped = stats->tx_discards;
+	vf_stats->tx_dropped = stats->tx_errors;
 
 out_put_vf:
 	ice_put_vf(vf);
-- 
2.55.0

