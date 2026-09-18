Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C252E06C;
	Fri, 18 Sep 2026 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766710; cv=none; b=F6SrznoCZNhA8QtrBEdH96ffvR/4dO6SUwzbdOa7vZswHb2TE22tXbv92wNzETZA4cSwFfcWYW182GPcdtnO13XF8fOWxPNVw5tj8j+8xLSw07Vj8n5mGQtojb9cYH0EPhQR0djdrc5ELmtguFrFzoLKUfD71FyrIJvxl/rH8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766710; c=relaxed/simple;
	bh=Ct/eWCgCBmIc1+qcyQqmAa14L/+fEJEdyHiFaKcfEe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm9ipn51OKJqglz1iL5AXJJVho0ulBGae9TY4B/0HSWVvFLEToLIyNNJAKGzm8DMDHsgBNWmOJNxDyzxy9kPXhWKGCuxlXeHndHB3OO2umLek9C4UFw6+/3C5tumLeAQBzix4BwnZ2KPUUq7SZSO/6Co9qAqiQCe99wegHac6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOvcTTuS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOvcTTuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789766709; x=1821302709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ct/eWCgCBmIc1+qcyQqmAa14L/+fEJEdyHiFaKcfEe0=;
  b=jOvcTTuS6bgMVzAytb3FAWfU05tQM1p5fuHW8s0/GM8tn1l1U9g+OusG
   Gh1/8eAIebfYY00EDu5ZeBjH0t35yYKXCHjEQSv+kBVhn8ArrpODNd2A+
   0BGszEhUeBHdg38JEXRsh00ykV8T/3LeOcJWQnr9/bZfNxjfNc0cf/jiA
   3T9axTnm91dGI6GhR0MCnkLuU2tTvp8HSUxWoxxnYKeMFk72dD+cPhShS
   NyuJf1Rr7eKKtUo43R/lXQp0+K48Bv6cCHuoS7umoTQvMHezEVRYHC2QQ
   6QoGHOPkpMOia/ONh0f33O7U4IR8GIiwhpaFTBQftfG5luukGPbBziDit
   w==;
X-CSE-ConnectionGUID: P95fbD8BS2CmLMmpA1ehjQ==
X-CSE-MsgGUID: GFQmTU72TZi68i7Jeeo8qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89436260"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89436260"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:25:07 -0700
X-CSE-ConnectionGUID: AKKGXFLKR6Gd5MrvD+W3NQ==
X-CSE-MsgGUID: 0eWW/AMrRWWCdR7Czmb7dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271251409"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 14:25:06 -0700
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
	Sunitha Mekala <sunithax.d.mekala@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 5/8] i40e: fix potential UAF in i40e_vsi_setup()'s error path
Date: Fri, 18 Sep 2026 14:24:52 -0700
Message-ID: <20260918212458.550425-6-anthony.l.nguyen@intel.com>
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

Sashiko pointed out an issue where error path in i40e_vsi_reinit_setup()
released ring memory but then when freeing q_vectors, the rings mapped
to q_vectors where touched which implies a regular use-after-free bug.

Apparently i40e_vsi_setup() has the same problem, so swap the allocation
and freeing order and fix the 13 year old bug.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5ea8731ece08..2b4b061302db 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14461,14 +14461,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		fallthrough;
 	case I40E_VSI_FDIR:
 		/* set up vectors and rings if needed */
-		ret = i40e_vsi_setup_vectors(vsi);
-		if (ret)
-			goto err_msix;
-
 		ret = i40e_alloc_rings(vsi);
 		if (ret)
 			goto err_rings;
 
+		ret = i40e_vsi_setup_vectors(vsi);
+		if (ret)
+			goto err_qvec;
+
 		/* map all of the rings to the q_vectors */
 		i40e_vsi_map_rings_to_vectors(vsi);
 
@@ -14488,10 +14488,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	return vsi;
 
 err_config:
+	i40e_vsi_free_q_vectors(vsi);
+err_qvec:
 	i40e_vsi_clear_rings(vsi);
 err_rings:
-	i40e_vsi_free_q_vectors(vsi);
-err_msix:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
-- 
2.47.1

