Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D903E008F
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946550; cv=none; b=lMByUrOArwVs2pianPSMbhOumWh6UKHwnuE1X5mgBp6zyTf7mFOaHP4UtktbrmB8WOYLmhkNCcT785hjLq05C2lZmYoAqeAkVakxvyGdwg3LeLt6XHUG7k2gRTp5pZjg0Uxh9yBzkO/3PjvkyJ38aVnQ577Op1/Q8nhvWk/BRhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946550; c=relaxed/simple;
	bh=0RS4bXmexIbmcn/QJxQGhC1U0Yffzr5KxteV+uXWSoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exgPIvVHOP+gdqoWrA8O6dmdRumaRc7x7IGsWTh57y39YmblQOcbhzn2r5GWv/yjR/peaoi5dIf2dzbTeHtVjfJes/vBeHoiIEv8WAQpaAEiOV5gcG76yjtMrd1TWDkawVYmUDtsPWWdUwvITiGv6hy+tF8hgrpFrSAYIik33D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYmZ7cws; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYmZ7cws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RM9N9byrk/K2mhYiTQy1Gjh5yftd80iFuZlc/Uf09mM=;
	b=GYmZ7cwsapPAs4s7lfQbwLUVw2kXHTMbA509UyQO7KEnvBumPG74PMpdwLTSbTiBXBzKYW
	lUIBXmkXruJHo034KYOM6wD1oJw7Tv6KZd654OBebJMEDkIoAx5lGpiB1VGVftuXUiW85H
	+IGeWUbMybu4Wv001aLD1YBbydCc1ac=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-QYC0D381NGqY5jFs4IjyXQ-1; Fri,
 02 Oct 2026 09:08:55 -0400
X-MC-Unique: QYC0D381NGqY5jFs4IjyXQ-1
X-Mimecast-MFC-AGG-ID: QYC0D381NGqY5jFs4IjyXQ_1790946531
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 331AD19560B9;
	Fri,  2 Oct 2026 13:08:51 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 105C7214;
	Fri,  2 Oct 2026 13:08:44 +0000 (UTC)
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
Subject: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from the response descriptor
Date: Fri,  2 Oct 2026 15:07:49 +0200
Message-ID: <20261002130752.2597259-8-poros@redhat.com>
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

ice_aq_sw_rules() decides whether a rule removal failed with ENOENT by
reading hw->adminq.sq_last_status after ice_aq_send_cmd() returned. That
field is shared by every admin queue user and is only stable while the
send queue lock is held. Another AQ command completing in between can
overwrite it, so a failed removal is reported as a generic error, and a
successful one can even be turned into -ENOENT, because the check is
not limited to the failure case. A caller that sees -ENOENT keeps its
rule bookkeeping while the rule is gone from the hardware.

ice_vsi_sync_fltr() has the same problem with ENOSPC. It checks
sq_last_status only after it has freed the list of filters it tried to
add. Every entry is a separate devres allocation, so freeing a list of
thousands of entries takes seconds, and by then the value usually
belongs to a different command, so the MAC filter overflow handling is
never entered. With debug prints of the error and sq_last_status added
to both places:

  ice_aq_sw_rules: opc 0x2a0 status -5 aq 16
  ice 0000:04:00.0 enp4s0f0np0: Failed to add MAC filters err -5 aq 0

Use the retval of the descriptor that ice_aq_send_cmd() copies back,
only when the command failed, translate ENOSPC on add to -ENOSPC and
let ice_vsi_sync_fltr() check the return code instead of
sq_last_status.

i40e fixed the same kind of race in commit 53a9e346e159 ("i40e: Fix race
condition while adding/deleting MAC/VLAN filters").

Fixes: ca1fdb885e5f ("ice: return correct error code from ice_aq_sw_rules")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  4 +---
 drivers/net/ethernet/intel/ice/ice_switch.c | 13 ++++++++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8a21f87eb6ca21..ceb9fec2af21e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -396,8 +396,6 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	struct net_device *netdev = vsi->netdev;
 	bool promisc_forced_on = false;
-	struct ice_pf *pf = vsi->back;
-	struct ice_hw *hw = &pf->hw;
 	u32 changed_flags = 0;
 	int err;
 
@@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 		 * should go into promiscuous mode. There should be some
 		 * space reserved for promiscuous filters.
 		 */
-		if (hw->adminq.sq_last_status == LIBIE_AQ_RC_ENOSPC &&
+		if (err == -ENOSPC &&
 		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
 				      vsi->state)) {
 			promisc_forced_on = true;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 239d4d9633baa6..ae96a2003d5c5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1959,9 +1959,16 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list, u16 rule_list_sz,
 	desc.flags |= cpu_to_le16(LIBIE_AQ_FLAG_RD);
 	cmd->num_rules_fltr_entry_index = cpu_to_le16(num_rules);
 	status = ice_aq_send_cmd(hw, &desc, rule_list, rule_list_sz, cd);
-	if (opc != ice_aqc_opc_add_sw_rules &&
-	    hw->adminq.sq_last_status == LIBIE_AQ_RC_ENOENT)
-		status = -ENOENT;
+	if (status) {
+		enum libie_aq_err aq_err = le16_to_cpu(desc.retval) & 0xff;
+
+		if (opc != ice_aqc_opc_add_sw_rules &&
+		    aq_err == LIBIE_AQ_RC_ENOENT)
+			status = -ENOENT;
+		else if (opc == ice_aqc_opc_add_sw_rules &&
+			 aq_err == LIBIE_AQ_RC_ENOSPC)
+			status = -ENOSPC;
+	}
 
 	if (!status) {
 		if (opc == ice_aqc_opc_add_sw_rules)
-- 
2.55.0

