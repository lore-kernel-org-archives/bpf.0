Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC99C433DF
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7573220737
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664595;
	bh=UpSHGXHv/QX6A4IS4joM6P1Hlv2s0Ot6ssUtVZvGDcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4rfFzYccXX0juF6q47uGrqIo14adoMtN0rLTbn2bMwJtLQn6rm3hZ4/JWJRnWLCl
	 Awm7/NL8NMyCckEoXOrSiLSbjTup/L2+4bkw0k3E7gjXHUMjt+qMRAkjta36yzp4M6
	 F0gO6goVpbUBeWlayrGBiUtlcCs3yKmatTReAK4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgFIBDP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgFHXHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CF22086A;
        Mon,  8 Jun 2020 23:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657664;
        bh=UpSHGXHv/QX6A4IS4joM6P1Hlv2s0Ot6ssUtVZvGDcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Irnm2iouMUWw8XYm3CAJQ7FcwuhUpKfTkxpj4hbR7WmmxBwqkeQLPE7+1HF9yf5+w
         LB8aV9TfHmtxUW3hhk3Bgaa1XlbzBiC9uiSm8FexDC6ofABsdMcGiKzoZcAVjaVW/U
         vNobKHNDAhfy2MEmm78zS9acSutFmE/5OMVdcRcY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marta Plantykow <marta.a.plantykow@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 075/274] ice: Change number of XDP TxQ to 0 when destroying rings
Date:   Mon,  8 Jun 2020 19:02:48 -0400
Message-Id: <20200608230607.3361041-75-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Marta Plantykow <marta.a.plantykow@intel.com>

[ Upstream commit c8f135c6ee7851ad72bd4d877216950fcbd45fb6 ]

When XDP Tx rings are destroyed the number of XDP Tx queues
is not changing. This patch is changing this number to 0.

Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5b190c257124..599dab844034 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1898,6 +1898,9 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
 	for (i = 0; i < vsi->tc_cfg.numtc; i++)
 		max_txqs[i] = vsi->num_txq;
 
+	/* change number of XDP Tx queues to 0 */
+	vsi->num_xdp_txq = 0;
+
 	return ice_cfg_vsi_lan(vsi->port_info, vsi->idx, vsi->tc_cfg.ena_tc,
 			       max_txqs);
 }
-- 
2.25.1

