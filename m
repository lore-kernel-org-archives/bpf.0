Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B152CCFC;
	Fri, 18 Sep 2026 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766709; cv=none; b=Xlvg497KeOLs6Fnl2wZzVr0pFDJKu1MVdxswvaaUirhtCR8KbRfuzxqKlYdv+tZEkOkKmYokfQFX06H4SxpJksEZYiXkC/3oOo/C1HL0f3UW9nhKh498kolh8WKI/jjiXwMQvdva0RirEYHrwqfXPWOY7gV8zKsj0aDgwSEL2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766709; c=relaxed/simple;
	bh=FFcwJNLPuS1s/owpJ9SQohe27SVOxg9CQqEA3CsBAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYaXZQaORLq1fmicEbqkLhRUcLNSXeFVtZT4lYWMsM4Xlh55e3FeIwx6czktsLDf09ur4KWi/ayZWEYbjf54g9arGmaqCeRokA7Z8ia1P8n4YE01gJVGVSMMsmApq1DJwusIuflzRzND5nm024bO5cgXln1MidC+iFHzgPE4MDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWKeOu5W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWKeOu5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789766707; x=1821302707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFcwJNLPuS1s/owpJ9SQohe27SVOxg9CQqEA3CsBAzw=;
  b=eWKeOu5WqsxZGtRDSTHn9xFgD/pwWp2nl8reCp/McC1IctbPiW29WEXg
   wstar/euqLDPrmvex9porGFgsZGcig7CFDV0KN3aYiaN4JR2QcmGXtXfK
   A7d46uU8boVqlfkC6PND1SjAF+R/lxzhTsnm3+53u7RzBktRWbRMRtQkJ
   G+hLMUiUpfL6Ovt2r0KSsyXautiUm2UCWj/u2kJN43KKXQDsSLGxa5Syq
   Exoit0GfJQpFG6rLU4pDtROwBDLFx6Lw+6WguIsiqEJb2cfFeRCgJrZRa
   EEeF1Fmpp5gBoMbfzpqjZXwLyqUP6o27J/FR1njjM7JYXr1f5QEncygEO
   g==;
X-CSE-ConnectionGUID: njS24EOAQ3+UOYBYhmKpGw==
X-CSE-MsgGUID: rEmIAxZeRviaUalj5lInsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89436229"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89436229"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:25:05 -0700
X-CSE-ConnectionGUID: aFu1DdKnRhODSzS6bfnK3g==
X-CSE-MsgGUID: iREDh5ttQ2m1md59zUfXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271251370"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 14:25:04 -0700
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
Subject: [PATCH net 2/8] i40e: avoid null ptr dereference in i40e_ptp_stop()
Date: Fri, 18 Sep 2026 14:24:49 -0700
Message-ID: <20260918212458.550425-3-anthony.l.nguyen@intel.com>
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
If an allocation fails here during i40e_rebuild(), i40e_vsi_clear()
frees the
main VSI and sets pf->vsi[vsi->idx] = NULL, and the rebuild will abort
without
stopping the PTP clock.
Later, if the device is removed or unbound, i40e_remove()
unconditionally
calls i40e_ptp_stop(), which does:
drivers/net/ethernet/intel/i40e/i40e_ptp.c:i40e_ptp_stop() {
    ...
	struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
    ...
	dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
		 main_vsi->netdev->name);
    ...
}
Would this cause a NULL pointer dereference since main_vsi is now NULL?
***

Check if main_vsi is not null before calling dev_info().

Fixes: beb0dff1251d ("i40e: enable PTP")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index ff62b5f2c815..ca93df4d6785 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1556,8 +1556,9 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	if (pf->ptp_clock) {
 		ptp_clock_unregister(pf->ptp_clock);
 		pf->ptp_clock = NULL;
-		dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
-			 main_vsi->netdev->name);
+		if (main_vsi)
+			dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
+				 main_vsi->netdev->name);
 	}
 
 	if (i40e_is_ptp_pin_dev(&pf->hw)) {
-- 
2.47.1

