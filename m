Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17203493D4A
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946551; cv=none; b=cXGWPDCI/e7UYb8KU/pYRigdG9thydPQ/A39FWJCVO4q9LHAz/6CEepdI/XFNBHXVA9n95/+FOXxHl/lFoG+RoLhl0n365BTX7hPe1eRlw6WUuJDoDJxykXwTwsyxpR6nlo1J10OewN4yew3BX5sVsYJqWJi5N3Pc3sQFZ4uScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946551; c=relaxed/simple;
	bh=XZUd+CjnM5ts7asAU3/CULg8sUv0gG5A5bc8ep1NyH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcODTrRb766OvjmXYAgETW2H5CUY1q00jFyflIfAx6jaJa3dYut9giD8St5IkwDchMoJhxv5T2AsETz7KkOq/R6+rdHCD4aVuMz12AjGwxhcwBHI8UScjQFi69lLO0RevEw/Izm/SPUTfnkFtOop9qYGyve9L1P/gPSmrM2JjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReyBQioJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReyBQioJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQSqLz5OriNDY7xfFl5J4UkpqFctIlNQ7RGwSyJ7FGY=;
	b=ReyBQioJWbUlX66Oseb5ACLD0wg2fVa4p197DOts4ozAKQhlSoWa59HcN7nQauaSV7puAl
	elGF4HsId1i6RN4vFzDCgDXFPxVeQi9imaKoxuDwhMXYLxYaxoHWrNoieuxOdu9SMBky8p
	ZB/HoqapiFnNaR3mwWoz8wft2E/X2Mg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-dQ1eSqRdP66QrJr-KhpdFQ-1; Fri,
 02 Oct 2026 09:09:00 -0400
X-MC-Unique: dQ1eSqRdP66QrJr-KhpdFQ-1
X-Mimecast-MFC-AGG-ID: dQ1eSqRdP66QrJr-KhpdFQ_1790946537
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 728C7195F149;
	Fri,  2 Oct 2026 13:08:57 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9561D214;
	Fri,  2 Oct 2026 13:08:51 +0000 (UTC)
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
Subject: [PATCH iwl-net 08/10] ice: detect a PF reset that does not complete
Date: Fri,  2 Oct 2026 15:07:50 +0200
Message-ID: <20261002130752.2597259-9-poros@redhat.com>
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

ice_pf_reset() polls PFGEN_CTRL.PFSWR for up to
ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT iterations, but
the timeout check after the loop still compares the counter with
ICE_PF_RESET_WAIT_COUNT alone. When the reset never completes the loop
ends with cnt == 5300, the check does not match and the function
returns success with PFSWR still set. A reset that completes just when
the counter reaches ICE_PF_RESET_WAIT_COUNT is reported as a failure
instead.

Check the PFSWR bit read last instead of the loop counter, the same
way i40e_pf_reset() does after its poll loop.

Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 04633103e3e610..0ffd6b5b81239e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
 		mdelay(1);
 	}
 
-	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
+	if (reg & PFGEN_CTRL_PFSWR_M) {
 		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete.\n");
 		return -EIO;
 	}
-- 
2.55.0

