Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B3C15503
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE0A64EF9
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449662AbhCCWx3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:53:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:62500 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350800AbhCCTHT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 14:07:19 -0500
IronPort-SDR: AEziBZrS5z174NoCWuykj0QZjcz30bRPASwri3k8aLeNl8gDnvxLKmgTWRQ7/+kkpXzdMdbNu0
 /j0RjrhAgF8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="251309585"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="251309585"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:06:39 -0800
IronPort-SDR: wqW5vLNrKW+5mXU2dWDdBNxVkC1AJVEhureftlVXpcMtFBrPjVY55jtEU7XHq3MT+t4ViMe+d2
 k2vtatxOV0Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="506992640"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 11:06:37 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        john.fastabend@gmail.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf v2 1/3] xsk: remove dangling function declaration from header file
Date:   Wed,  3 Mar 2021 19:56:34 +0100
Message-Id: <20210303185636.18070-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
References: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

xdp_umem_query() is dead for a long time, drop the declaration from
include/linux/netdevice.h

Fixes: c9b47cc1fabc ("xsk: fix bug when trying to use both copy and zero-copy on one queue id")
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/linux/netdevice.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 6cef47b76cc6..226303976310 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3932,8 +3932,6 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
-int xdp_umem_query(struct net_device *dev, u16 queue_id);
-
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
-- 
2.20.1

