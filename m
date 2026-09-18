Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14304F85B5;
	Fri, 18 Sep 2026 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766710; cv=none; b=XlpcoNr4wq8bM1xKMszvWOl/7heEXVHI52KWBXoJhJtALnSAbFwHa+26h5EErXGu7RyQyTZDBXysmBhhZNBsOlmem+CBk9J+z36ZgM7RJphiNQsArlZa2YqhKJ/i+BP6XmwB5uss4W+dp4aXsAg3hw+7wCvNABpvUZDPMqVc7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766710; c=relaxed/simple;
	bh=BGccWyARoa8qGNbdbcxMGNVArncT0J8YuPq8spMP5po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef4DjywG9iajTeDZCE7pV36SwwQsjkwaVku0//4YDBqOwLcReCygdgP+7roN5xwFCUPTEYx2dIwyOHSuAhs8J4ZoSOBfvQ2NhKPYF6We+JZwM7zPMuGk9GT+PoiegODrer2OYz2WFuyW21235m8Rfwfbxue9SniM9xFtHLlxnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9z9MMS7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9z9MMS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789766708; x=1821302708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGccWyARoa8qGNbdbcxMGNVArncT0J8YuPq8spMP5po=;
  b=B9z9MMS7SWcTLwEtuLgGzvvcmacEts5PdPpjtgWZkEO17zzJiRn3ET+k
   hWDzgch4jZCGYNYTbXucVRgibvdl6hAN15C3Tqzy2miz8w5GnTRYNQSj+
   zzDj93pEhxHTNMsxcd3b5Va6QEQGn4Veh1szGKjo8thp3R1oeidKNTxW7
   jPsBuGK44kdUg4ao1qVXqB8oB7hpbOzUksH+7iLvj3k5PxSXyrrE9O70x
   0l0C8bL4Om/9ICx7Q+IG32MLgj/VlSCoYAN5QhGfJL9auv1lw/eKBCCKw
   kLFTq5tgva+qbx/Yw64zxw+6WoTAb6O5QdGEheifn5vrcaB3mnPJ8xVTk
   A==;
X-CSE-ConnectionGUID: T412KQJAQP+VOQGc8JM5SQ==
X-CSE-MsgGUID: qKD1/30MTe+hZwUHNAA3tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89436240"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89436240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:25:06 -0700
X-CSE-ConnectionGUID: q5ki98q+RqizjYr6eFbbOQ==
X-CSE-MsgGUID: b8oG14ncTkef3G85kRMCtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271251393"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 14:25:05 -0700
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
Subject: [PATCH net 3/8] i40e: make ring pointers unreachable before freeing via rcu
Date: Fri, 18 Sep 2026 14:24:50 -0700
Message-ID: <20260918212458.550425-4-anthony.l.nguyen@intel.com>
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

Sashiko reports:
***
>  err_config:
> +	i40e_vsi_free_q_vectors(vsi);
> +err_qvec:
>  	i40e_vsi_clear_rings(vsi);
This is a pre-existing issue, but can the sequence in i40e_vsi_clear_rings()
lead to an RCU ordering violation?
In i40e_vsi_clear_rings(), the rings are freed before the array pointers are
nullified:
	kfree_rcu(vsi->tx_rings[i], rcu);
	WRITE_ONCE(vsi->tx_rings[i], NULL);
Under RCU rules, a pointer must be made unreachable to new readers before it
is handed off to kfree_rcu(). Could a new RCU reader (like
i40e_get_netdev_stats_struct_tx()) fetch the pointer after kfree_rcu() is
invoked, and access freed memory if the grace period expires while the
reader is still active?
***

Save the Tx ring pointer before clearing the published ring array slots
and pass the saved pointer to kfree_rcu(). This preserves the intended
RCU ordering, where new readers can no longer discover the ring through
vsi->tx_rings/rx_rings/xdp_rings before the object is queued for
deferred freeing, while avoiding a NULL kfree_rcu() argument after the
slot has already been cleared. Since the Tx pointer is the base of the
per-queue-pair allocation block, re-reading vsi->tx_rings[i] after
WRITE_ONCE(..., NULL) would otherwise turn the free into a no-op and
leak the whole ring block.

Fixes: 9f65e15b4f98 ("i40e: Move rings from pointer to array to array of pointers")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index de4c0737f72e..65aa50330aac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11693,11 +11693,13 @@ static void i40e_vsi_clear_rings(struct i40e_vsi *vsi)
 
 	if (vsi->tx_rings && vsi->tx_rings[0]) {
 		for (i = 0; i < vsi->alloc_queue_pairs; i++) {
-			kfree_rcu(vsi->tx_rings[i], rcu);
+			struct i40e_ring *tx_ring = vsi->tx_rings[i];
+
 			WRITE_ONCE(vsi->tx_rings[i], NULL);
 			WRITE_ONCE(vsi->rx_rings[i], NULL);
 			if (vsi->xdp_rings)
 				WRITE_ONCE(vsi->xdp_rings[i], NULL);
+			kfree_rcu(tx_ring, rcu);
 		}
 	}
 }
-- 
2.47.1

