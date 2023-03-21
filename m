Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2598BC6FD1D
	for <bpf@archiver.kernel.org>; Tue, 21 Mar 2023 01:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCUBl3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 20 Mar 2023 21:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCUBl2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 21:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18344ECC;
        Mon, 20 Mar 2023 18:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 816FE618F4;
        Tue, 21 Mar 2023 01:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FAAC433D2;
        Tue, 21 Mar 2023 01:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679362886;
        bh=B8HUVMUele/eV9xqSClhVIh/hFcyS0yRlOAyMdO7npA=;
        h=From:To:Cc:Subject:Date:From;
        b=p+GhLjeZjoQIQ0flXz/qsth1X6iWMQ+kT4Kmk27+H8obm/x0TmbRUwy9vi2y0TcxD
         oNH1P6ZUUjkUpf1qUqfKNy33X39NawC7BSKhi5sjd1lqVFjFCJ35fxUiZG0iMkNPse
         pj12pbL33Eam/Kn/loZE/6ulfKl1M1EQ0cBvAqYO+SHJQR+3lcdeog+qF3Y1zw31SQ
         Kty/Rdk8qYGlBrR3XlGrKg1Rl8HZF008cixtUG1C1hz3YpZyuy+qpEorYjIDnbOrK3
         GE2X+tTs9UrV8Ty4hb+RLkYb1TNb1PC2y0SjnYDfiejYTXSSDgCV8XR6IhCUSjtvAP
         XnbOf5xtEGD1Q==
From:   Jakub Kicinski <kuba@kernel.org>
To:     martin.lau@linux.dev
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v2 0/3] net: skbuff: skb bitfield compaction - bpf
Date:   Mon, 20 Mar 2023 18:41:12 -0700
Message-Id: <20230321014115.997841-1-kuba@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm trying to make more of the sk_buff bits optional.
Move the BPF-accessed bits a little - because they must
be at coding-time-constant offsets they must precede any
optional bit. While at it clean up the naming a bit.

v1: https://lore.kernel.org/all/20230308003159.441580-1-kuba@kernel.org/

Jakub Kicinski (3):
  net: skbuff: rename __pkt_vlan_present_offset to __mono_tc_offset
  net: skbuff: reorder bytes 2 and 3 of the bitfield
  net: skbuff: move the fields BPF cares about directly next to the
    offset marker

 include/linux/skbuff.h                        | 36 +++++++++----------
 net/core/filter.c                             |  8 ++---
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 14 ++++----
 3 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.39.2

