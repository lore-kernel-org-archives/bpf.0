Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF76C433F5
	for <bpf@archiver.kernel.org>; Fri, 11 Feb 2022 01:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346731AbiBKBVJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Feb 2022 20:21:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbiBKBVI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 20:21:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B94E2651;
        Thu, 10 Feb 2022 17:21:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF12860ABC;
        Fri, 11 Feb 2022 01:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E844C004E1;
        Fri, 11 Feb 2022 01:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644542467;
        bh=ZXZN2fvhfZn1TkiH27WiU6jw0/YcH+Rp9+ZubYS6P2c=;
        h=From:To:Cc:Subject:Date:From;
        b=HmW4iX+YvfpmI4klP7rtko9onlQflOcR3mCKfb+HTYCriQG0d0Ndm0ZBSDUgycpym
         c2DKiou9HPO+ab+CtvuGp5PmVOUD6+PkT19ezBwk2Bgo4KBB8NmxDBOrsaWZh45chE
         6+obwa8IS9OBOiqcD3ulCbXQv3WUXHLJ9QXttoapTVID0ScorwLijr4KRMACKZ0iYe
         J44JmZU7I5qBS2tyYEIFq3INsSjxtaDzh+euWqPduGn++0oBfDHnqa9RliwT9TPHbI
         gAmRmILwpbqLgkCJM7EsQ/YJrRYh4LbuBwtZFnDaXjAROoiuaRiZbPN9W1HWHgqVyH
         vld8ZCnolWvNA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, brouer@redhat.com, toke@redhat.com,
        pabeni@redhat.com, echaudro@redhat.com,
        lorenzo.bianconi@redhat.com, toshiaki.makita1@gmail.com,
        andrii@kernel.org
Subject: [PATCH bpf-next 0/3] introduce xdp frags support to veth driver
Date:   Fri, 11 Feb 2022 02:20:29 +0100
Message-Id: <cover.1644541123.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce xdp frags support to veth driver in order to allow increasing the mtu
over the page boundary if the attached xdp program declares to support xdp
fragments. Enable NETIF_F_ALL_TSO when the device is running in xdp mode.
This series has been tested running xdp_router_ipv4 sample available in the
kernel tree redirecting tcp traffic from veth pair into the mvneta driver.

Lorenzo Bianconi (3):
  net: veth: account total xdp_frame len running ndo_xdp_xmit
  veth: rework veth_xdp_rcv_skb in order to accept non-linear skb
  veth: allow jumbo frames in xdp mode

 drivers/net/veth.c | 197 ++++++++++++++++++++++++++++-----------------
 include/net/xdp.h  |  14 ++++
 net/core/xdp.c     |   1 +
 3 files changed, 138 insertions(+), 74 deletions(-)

-- 
2.34.1

