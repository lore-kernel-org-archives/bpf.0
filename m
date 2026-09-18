Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781C52CCF6;
	Fri, 18 Sep 2026 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766707; cv=none; b=l9g29itImjxz87FbV65wyyMiq7RhHUpmdOj0nEv65NIUtUswJJeA9tJrXpgKgWzn7KJSmkDH4aFkZtRcyR0SLHo1nDLtONmD9UCu3hsFm1SgM2DpX0ruX2f0ObOawwEIivAwAzxZahN+E+DVUCTWf1FgDBF8BIVDckAkUGLuQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766707; c=relaxed/simple;
	bh=Niqyt9NpDuogLUYnI5x2PuTve3M2I3GE/vPvtLi/reA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifpS5+LF+JHEv+lgHEB1YO0yPe8n1JnoxJU+LQzBKN2FR2CZ6V3nAyfJGxucY+RraI+m9K/QBbpzUqBXutNbDtcwNB7MgrEx1DEjf8g5VEDKkb0UM9fUZje0PSUqXlpQ7AIJWAJDxj+uRsRj+6IxOSogbOoTvgeF88zsnPuuIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqXaMJlv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqXaMJlv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789766706; x=1821302706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Niqyt9NpDuogLUYnI5x2PuTve3M2I3GE/vPvtLi/reA=;
  b=HqXaMJlvBJBAeQTIVnquNybY2oVr3tSA8yfdKdoyGxIXn+mhMhEVy/RY
   4EgRVkF1ikJsEevD2xmfYcGhgg+Hz5CCSZC22uBazwqOz8EIjBDtrAU6K
   cbZdfIZKxfPgrA6K79cuYNPDz7G/Fob33cqGv8oQyZBe86MeBrLdAu7f6
   n4cWm1LGa0nRBDaL5W9HD5wcej0utkmDTEeTd3YVyBUMIJDM/Qb11LKyE
   MGz6VCQKu05SdluxfB+ajJ39uE3wlagiGBDZ4q1WaeKgIf5vZg++DN2dA
   ey8HLFH/5xXFxR54THuQKbmtW5Em9rUSomkjgWYa/qHMbV9AC6Gp6KAUV
   g==;
X-CSE-ConnectionGUID: vVG4JvrmT+evFrEvv/1/Ow==
X-CSE-MsgGUID: XbN1Cm6FSBOrmcrXx24DKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89436218"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89436218"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:25:04 -0700
X-CSE-ConnectionGUID: gdli3f+GTzS9NLacW31c9w==
X-CSE-MsgGUID: JYQIoZb7RuqblrvGbZ+7hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271251354"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 14:25:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	zhaochenguang@kylinos.cn,
	magnus.karlsson@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 1/8] i40e: unregister netdev before clearing VSI on reinit failure
Date: Fri, 18 Sep 2026 14:24:48 -0700
Message-ID: <20260918212458.550425-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
References: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

i40e_vsi_reinit_setup() tears down the existing VSI queue/ring backing
state before allocating replacement arrays and queue tracking. If one of
these early allocations fails, the function jumps directly to err_vsi
and calls i40e_vsi_clear().

For a registered netdev, this frees the VSI while
netdev_priv(netdev)->vsi can still point at it, leaving the registered
netdev with dangling private driver state.

Split the error path so failures after destructive reinit teardown first
unregister and free the netdev before clearing the VSI.

Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0cd0e5597c90..de4c0737f72e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14268,7 +14268,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	i40e_set_num_rings_in_vsi(vsi);
 	ret = i40e_vsi_alloc_arrays(vsi, false);
 	if (ret)
-		goto err_vsi;
+		goto err_netdev;
 
 	alloc_queue_pairs = vsi->alloc_queue_pairs *
 			    (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
@@ -14278,7 +14278,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_vsi;
+		goto err_netdev;
 	}
 	vsi->base_queue = ret;
 
@@ -14303,6 +14303,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 err_rings:
 	i40e_vsi_free_q_vectors(vsi);
+err_netdev:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
@@ -14312,7 +14313,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
-err_vsi:
 	i40e_vsi_clear(vsi);
 	return NULL;
 }
-- 
2.47.1

