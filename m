Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755752D2B7;
	Fri, 18 Sep 2026 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766709; cv=none; b=jLthjvbdEWDZfeQwBvz103OwVTemTAxPI2Qe2VM4VQteuTs008GGsDU/zBn+EpfPdndknocv+A7vpiC/yE5WLATJQnIOAInI60ATp9udAKe3cNn27c4QlV6y2q5Taq1+j+xyt3P3NqO1UMQ4G+syCGHN/8BuShMFUL9QJxiV/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766709; c=relaxed/simple;
	bh=TXk1998ZMT3DVpOAZlGg2Ppj9wkNz65sBaU8fP9q+a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDV5d0b5Wr/5AXBrnnMu52F/VuEQlSenZ1mLFK6HbQxMXZBxrAO5dN0e5QbgEu5TNBYC2YurvkO4gMKXzJiZZR0nDwtaqtlh2iUlvN54xdUvOs1vgJE//myH6F10luefvGhYkzs9TSTk98bwFM9/g0eBZpUqbCmU3rY+5rnBzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WX57A5X9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WX57A5X9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789766708; x=1821302708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXk1998ZMT3DVpOAZlGg2Ppj9wkNz65sBaU8fP9q+a8=;
  b=WX57A5X9aFnL/FY/OgcMcsBhRj4oJgDTPf7+hpHJ9pgQsHHMcXyISXNH
   +GQG4UHANNi5TpalQ5dMB+Ke6bUpUtevuIB+KiaZGlQz+C4gLhig5acrv
   1BQ1BjqGR0ZicublY8k+Fwzfg48YcLk0pDAY5Fi2N/edkeeKhCY+jKTQk
   9vGpvFxFVD/sHQgbXAZJdNrki/Nb8hnAUOhlOxGtuJQ97LrMqMcC+ophl
   f+YI+/pJpIt51xpIF6nbtAJBbPQ5FFFfnGbVJWTiq9UW7GcjAs54HGWeZ
   YGxHSB2Q4P2eE9IeuUn53Mm91KE74lGeJ+EjPBrs+10MUzk/7EIn2Qz8x
   g==;
X-CSE-ConnectionGUID: ePrdN4liTb6rRk/1fdYvkQ==
X-CSE-MsgGUID: 396EvzMHQUS+e016vEN6zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89436250"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89436250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:25:06 -0700
X-CSE-ConnectionGUID: W4PJ3HjmS0SpA5cfQRv8dw==
X-CSE-MsgGUID: 8ydR3X2aQCyG+FMI1gtr3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271251399"
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
Subject: [PATCH net 4/8] i40e: avoid deadlock when calling unregister_netdev()
Date: Fri, 18 Sep 2026 14:24:51 -0700
Message-ID: <20260918212458.550425-5-anthony.l.nguyen@intel.com>
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
> +err_netdev:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
Could this result in a deadlock when called during a device rebuild?
Looking at i40e_rebuild(), it explicitly acquires the RTNL lock before
proceeding:
drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_rebuild() {
    ...
	if (!lock_acquired)
		rtnl_lock();
	ret = i40e_setup_pf_switch(pf, reinit, true);
    ...
}
If i40e_setup_pf_switch() calls i40e_vsi_reinit_setup() and takes this new
err_netdev path, unregister_netdev() will unconditionally attempt to acquire
rtnl_lock(), leading to a deadlock on the non-recursive mutex.
***

Use unregister_netdevice() when the rebuild path already holds RTNL, and
keep unregister_netdev() for callers that do not. This avoids both
recursive RTNL locking and dropping RTNL in the middle of the VSI unwind
path.

Fixes: bc7d338fbb3f ("i40e: reinit flow for the main VSI")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 65aa50330aac..5ea8731ece08 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14245,13 +14245,15 @@ static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
 /**
  * i40e_vsi_reinit_setup - return and reallocate resources for a VSI
  * @vsi: pointer to the vsi.
+ * @lock_acquired: indicates whether or not the lock has been acquired
  *
  * This re-allocates a vsi's queue resources.
  *
  * Returns pointer to the successfully allocated and configured VSI sw struct
  * on success, otherwise returns NULL on failure.
  **/
-static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
+static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
+					      bool lock_acquired)
 {
 	struct i40e_vsi *main_vsi;
 	u16 alloc_queue_pairs;
@@ -14308,7 +14310,10 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 err_netdev:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
-		unregister_netdev(vsi->netdev);
+		if (lock_acquired)
+			unregister_netdevice(vsi->netdev);
+		else
+			unregister_netdev(vsi->netdev);
 		free_netdev(vsi->netdev);
 		vsi->netdev = NULL;
 	}
@@ -15030,7 +15035,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 			main_vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN,
 						  uplink_seid, 0);
 		else if (reinit)
-			main_vsi = i40e_vsi_reinit_setup(main_vsi);
+			main_vsi = i40e_vsi_reinit_setup(main_vsi, lock_acquired);
 		if (!main_vsi) {
 			dev_info(&pf->pdev->dev, "setup of MAIN VSI failed\n");
 			i40e_cloud_filter_exit(pf);
-- 
2.47.1

