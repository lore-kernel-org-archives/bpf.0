Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0257C07E99
	for <bpf@archiver.kernel.org>; Fri,  9 Jul 2021 11:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8845E61374
	for <bpf@archiver.kernel.org>; Fri,  9 Jul 2021 11:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhGILNa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 9 Jul 2021 07:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhGILNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Jul 2021 07:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D563061206;
        Fri,  9 Jul 2021 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625829047;
        bh=SVgriyeFWdjQ15TjzhSzoQsASOWuvYO30wIKTiQXGms=;
        h=From:To:Cc:Subject:Date:From;
        b=Bv7zWQW0OLYQBEbHQ6BRhValx4liGXw9FxXPWL7ShDelDUJeEQyrev/DRzBMwTGx9
         1Lz3Ul2Ta+TWuhPY9t66ZeEI7xY2bpFF6Y4TRt7mWNc1gLcOEw4pmb/LswDOiVvrqq
         to3dhUukTuvUdhi+F1Y6aRhLYg+VcOrdjv/p6ue0ZzJh9xTjOUaxydkGmBAoiPVCGA
         qvIMbRZ8t3MJag8lmbKRSxjYj7d6gd04reutbB923kX6WO9xAiRihhHWLuJ3xyHOgk
         B6VkdRKfml8k8tzqderdVTM1UdVXjvKR5kB8lYhtCS767pN/3Z9mswFxgxnoSVBzwP
         81pcgZNC+bRSQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, alexander.duyck@gmail.com, brouer@redhat.com,
        echaudro@redhat.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: [PATCH bpf-next 0/2] Add xdp_update_skb_shared_info utility routine
Date:   Fri,  9 Jul 2021 13:10:26 +0200
Message-Id: <cover.1625828537.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce xdp_update_skb_shared_info routine to update frags array metadata
from a given xdp_buffer/xdp_frame.
Add xdp_frags_tsize field to skb_shared_info.

Lorenzo Bianconi (2):
  net: skbuff: add xdp_frags_tsize field to skb_shared_info
  net: xdp: add xdp_update_skb_shared_info utility routine

 drivers/net/ethernet/marvell/mvneta.c | 29 +++++++++++++++------------
 include/linux/skbuff.h                |  2 ++
 include/net/xdp.h                     |  3 +++
 net/core/xdp.c                        | 27 +++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 13 deletions(-)

-- 
2.31.1

