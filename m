Return-Path: <SRS0=5TR3=DF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D875C2D0A8
	for <bpf@archiver.kernel.org>; Mon, 28 Sep 2020 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373EC21D95
	for <bpf@archiver.kernel.org>; Mon, 28 Sep 2020 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601292340;
	bh=coB7kugviXWgFNAtg+pjbvIM06kqe3qbDxbESPKvT0g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AE0EV8B9ycTWJv5drSNgH/B6gRhr6EZtSWVT7Lx4en0sbBaWC7+WefMHw1cLN/dv4
	 85h2W7YFUJbnQDtks9wIKWlSxKmCrKXqEMh8j+vdefytiNBhfEDxtE8D92OY/ZskTF
	 QJUt8pbtc27h3IuGtEOyYrNg69WiNKXeplmD5X50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgI1LZj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1LZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 07:25:39 -0400
Received: from lore-desk.redhat.com (unknown [151.66.98.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F2021D46;
        Mon, 28 Sep 2020 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601292339;
        bh=coB7kugviXWgFNAtg+pjbvIM06kqe3qbDxbESPKvT0g=;
        h=From:To:Cc:Subject:Date:From;
        b=L7Zlfy5GaJ6WYjHrPMv1nXuJjLbfpspr3WrzHhqEr84tMcKMizUSPkqx9U5VN9F2P
         sYFmTnTl+61bw2IUOXByXyMkvoWy0pHF4+nOLU50LvG5vYdbVm/1RDFwfjDGFiyHmX
         5eTTRlEDqtPJqxF9xH5t4WAf755p+jEBWKh6exRo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        brouer@redhat.com, lorenzo.bianconi@redhat.com
Subject: [PATCH bpf-next] bpf: cpumap: remove rcpu pointer from cpu_map_build_skb signature
Date:   Mon, 28 Sep 2020 13:24:57 +0200
Message-Id: <33cb9b7dc447de3ea6fd6ce713ac41bca8794423.1601292015.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Get rid of bpf_cpu_map_entry pointer in cpu_map_build_skb routine
signature since it is no longer needed

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 kernel/bpf/cpumap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 7e1a8ad0c32a..c61a23b564aa 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -155,8 +155,7 @@ static void cpu_map_kthread_stop(struct work_struct *work)
 	kthread_stop(rcpu->kthread);
 }
 
-static struct sk_buff *cpu_map_build_skb(struct bpf_cpu_map_entry *rcpu,
-					 struct xdp_frame *xdpf,
+static struct sk_buff *cpu_map_build_skb(struct xdp_frame *xdpf,
 					 struct sk_buff *skb)
 {
 	unsigned int hard_start_headroom;
@@ -365,7 +364,7 @@ static int cpu_map_kthread_run(void *data)
 			struct sk_buff *skb = skbs[i];
 			int ret;
 
-			skb = cpu_map_build_skb(rcpu, xdpf, skb);
+			skb = cpu_map_build_skb(xdpf, skb);
 			if (!skb) {
 				xdp_return_frame(xdpf);
 				continue;
-- 
2.26.2

