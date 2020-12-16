Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD070C0018C
	for <bpf@archiver.kernel.org>; Wed, 16 Dec 2020 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F46206CB
	for <bpf@archiver.kernel.org>; Wed, 16 Dec 2020 19:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388757AbgLPTdD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388753AbgLPTdC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 14:33:02 -0500
From:   Lorenzo Bianconi <lorenzo@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, brouer@redhat.com,
        lorenzo.bianconi@redhat.com, toshiaki.makita1@gmail.com
Subject: [PATCH bpf-next 0/2] add xdp_build_skb_from_frame utility routine
Date:   Wed, 16 Dec 2020 19:38:32 +0100
Message-Id: <cover.1608142960.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce __xdp_build_skb_from_frame and xdp_build_skb_from_frame routines to
build the skb from a xdp_frame. Respect to __xdp_build_skb_from_frame,
xdp_build_skb_from_frame will allocate the skb object.
Rely on __xdp_build_skb_from_frame/xdp_build_skb_from_frame in cpumap and veth
code.

Lorenzo Bianconi (2):
  net: xdp: introduce __xdp_build_skb_from_frame utility routine
  net: xdp: introduce xdp_build_skb_from_frame utility routine

 drivers/net/veth.c  | 18 +++-----------
 include/net/xdp.h   |  5 ++++
 kernel/bpf/cpumap.c | 45 +---------------------------------
 net/core/xdp.c      | 59 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 59 deletions(-)

-- 
2.29.2

