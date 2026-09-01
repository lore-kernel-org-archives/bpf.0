Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02341468C38;
	Tue,  1 Sep 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788297492; cv=none; b=Pw5TggjBIHe5dZ+wENhff/2JG/NiYVu4oZLxXBUttLn4oyD8lS7vRcoxTKizNqHDXXL8nvNUqry2MBjqFbiKlTTi0P5YuDMh4+dTxCzFv1czQ+xZ4Hpi85ca1BYk/lEx5FfqI/1ILwXIgkwOVjf34T8uZI7d4KWydofbPbEV3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788297492; c=relaxed/simple;
	bh=ogGcDOG1SVS9gY0603tIYZGDKfXpYnc+f7C9UbaeK20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjySxIJcqLbBbEbp65k9gr5n2+Hv0j0jrtDd2h8ONC4mpQfR8OLcFP4WVa8nrNI1oeKjj0jwVn45t0AXG4JYtFV3PqAVphT4wzgGVjW4N44mIRYQdkARtx0t4OvUU6IxGbTPbHnue8yel9ETHzcEkpl5zaWJ/GoJcAOmN0cdHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9DsOHWk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9DsOHWk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788297492; x=1819833492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ogGcDOG1SVS9gY0603tIYZGDKfXpYnc+f7C9UbaeK20=;
  b=J9DsOHWkoQebG5fqWNESGpdi3+htvqDr742i+uux576NS3grD54fskR1
   zKr1mrUssnRR5FpZjYNT8BJMXHTxqN8fCDmmst0q1Oe2AgaP6JMk8mUbf
   t59oAP42Sb+slLtlcHF6ugqzAQWTET6yYV1XC+sAdPZTJz3Rrx9Gl/Fif
   +Z6nvPcAJLcjbGBsX2JjmTDcIN1IeksUJKRNI86eXQSKzSCKwH5JLtKn6
   97JgJiWsWlaeYyfupJS5J/oLpE0Sn36hvF9m2RqfXN0moY9X1GVqzDdpU
   CTOdA8uXv8/04MYL4ixUIlft+3Vpz3ycfX1Rv6jK/7Z/c0UrS+AJgNdb8
   A==;
X-CSE-ConnectionGUID: 8IkhdlCrSxSUUR0s1pkJBA==
X-CSE-MsgGUID: wNFDFTzFQzCuq7xn62jXGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88670384"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88670384"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 14:18:06 -0700
X-CSE-ConnectionGUID: Wj5JgWVkQCCABWFmythlyQ==
X-CSE-MsgGUID: ZNXUneT+SM2AUKNM+bvBAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267439760"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 14:18:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	enjuk@amazon.com,
	przemyslaw.kitszel@intel.com,
	blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 4/4] i40e: Avoid repeating RX filter warning
Date: Tue,  1 Sep 2026 14:17:50 -0700
Message-ID: <20260901211752.1922993-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
References: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

When the i40e runs out of space for RX filters the driver switches to
promiscuous mode and warns that it has done so. In scenarios with a
large number of these filters this can generate a lot of warnings. For
example:

  $ dmesg -c > /dev/null
  $ ip link add dev br0 type bridge vlan_filtering 1 vlan_default_pvid 1
  $ ip link set dev eth7 master br0
  $ bridge vlan add vid 1 dev eth7 pvid untagged self
  $ bridge vlan add vid 2-4094 dev eth7 tagged
  $ dmesg
  [   25.601705] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.601833] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.601961] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.602088] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.602216] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.602344] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  ...

Use test_and_set_bit() so that the warning is only issued when the
driver enables promiscuous mode and not on the addition of subsequent RX
filters.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 719f45b5cb40..abbc71e815ae 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2412,10 +2412,12 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 
 	if (fcnt != num_add) {
 		if (vsi->type == I40E_VSI_MAIN) {
-			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
-			dev_warn(&vsi->back->pdev->dev,
-				 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
-				 libie_aq_str(aq_status), vsi_name);
+			if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC,
+					      vsi->state)) {
+				dev_warn(&vsi->back->pdev->dev,
+					 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
+					 libie_aq_str(aq_status), vsi_name);
+			}
 		} else if (vsi->type == I40E_VSI_SRIOV ||
 			   vsi->type == I40E_VSI_VMDQ1 ||
 			   vsi->type == I40E_VSI_VMDQ2) {
@@ -2465,10 +2467,11 @@ i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
 	}
 
 	if (aq_ret) {
-		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
-		dev_warn(&vsi->back->pdev->dev,
-			 "Error %s, forcing overflow promiscuous on %s\n",
-			 libie_aq_str(hw->aq.asq_last_status), vsi_name);
+		if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
+			dev_warn(&vsi->back->pdev->dev,
+				 "Error %s, forcing overflow promiscuous on %s\n",
+				 libie_aq_str(hw->aq.asq_last_status), vsi_name);
+		}
 	}
 
 	return aq_ret;
-- 
2.47.1

