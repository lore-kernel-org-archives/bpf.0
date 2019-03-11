Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96FBC43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 19:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1F62147C
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 19:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRxS0zqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfCKTa1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:30:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41483 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727147AbfCKTa1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Mar 2019 15:30:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3AE48250B1;
        Mon, 11 Mar 2019 15:30:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 11 Mar 2019 15:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6fFNmScQfgrQpZ6cl
        pWQQY/j9DsG5eC9wlv+zC1NA9Y=; b=cRxS0zqw1xmQidVTfEg/VADZAYmOy3HIP
        FZup+X1tsX/QO3V2ehpgOzRkDJmxLtpQC+lwb3/1fot2kNVDud3vtbfkmXdSfZJo
        1p9sMI1UkRipbR8lpoSZUG4vhTmDbbdanF4w5Rsft1pX/73gujpmqSAuFNCQiBkf
        eBK+EpqBKXG1jdQjf21iEEpPSSZe8m4udIU0ZtkEKtiqeVzJq4nEVIl+Ij+9BttX
        TZ+DmO8un9boYWVklLkZ54vQBksQuXWrVGPA/TWUcfDXKObI6fi4T8UIh1LVGCF2
        CeJJW021JBNiiKpXXglFmLN2RQGukGDgmwmYJVLsXXkP7aMTgRQjg==
X-ME-Sender: <xms:ULeGXMVRWySv-iY_sDHFGFVp3LpbX7KAA8FrEMGjpNiDtSpiAupJGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghmsggu
    rgdrlhhtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudejrdduge
    elrdduieehrdduudelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdr
    lhhtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ULeGXF4EaIgoyjY5O-_Ad0rUJS_19tdwN0DorThvIadbCywpF2i-ZQ>
    <xmx:ULeGXMdHrG-LKjvwXI5nby2W7APV9VhS8ApmcFSo2pToP5k2bwptZA>
    <xmx:ULeGXH482O8mAV2mkiXh521r9a9BbUfOnL2cOt9jbHxDbQpAIz5iVw>
    <xmx:UreGXGM3bYx3v_K7_NlYyauZllILS57Snk2IsW3UpVKP2BVL8mAWUQ>
Received: from ceuse.localdomain (217-149-165-119.nat.highway.telekom.at [217.149.165.119])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A8F0E456D;
        Mon, 11 Mar 2019 15:30:22 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        mhocko@suse.com, m@lambda.lt
Subject: [PATCH] bpf: Try harder when allocating memory for large maps
Date:   Mon, 11 Mar 2019 20:31:12 +0100
Message-Id: <20190311193112.25527-1-m@lambda.lt>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It has been observed that sometimes a higher order memory allocation
for BPF maps fails when there is no obvious memory pressure in a system.

E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
could not be created due to vmalloc unable to allocate 75497472B,
when the system's memory consumption (in MB) was the following:

    Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727

Later analysis [1] by Michal Hocko showed that the vmalloc was not trying
to reclaim memory from the page cache and was failing prematurely due to
__GFP_NORETRY.

Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
__GFP_RETRY_MAYFAIL with more useful semantic") and [1], we can replace
__GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
and will try harder to fulfil allocation requests.

The change has been tested with the workloads mentioned above and by
observing oom_kill value from /proc/vmstat.

[1]: https://lore.kernel.org/bpf/20190310071318.GW5232@dhcp22.suse.cz/

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 kernel/bpf/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 62f6bced3a3c..1b0a057ed6d5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -136,20 +136,26 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 
 void *bpf_map_area_alloc(size_t size, int numa_node)
 {
-	/* We definitely need __GFP_NORETRY, so OOM killer doesn't
-	 * trigger under memory pressure as we really just want to
-	 * fail instead.
+	/* We definitely need __GFP_NORETRY or __GFP_RETRY_MAYFAIL, so
+	 * OOM killer doesn't trigger under memory pressure as we really
+	 * just want to fail instead.
 	 */
-	const gfp_t flags = __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO;
+	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
 	void *area;
 
 	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
-		area = kmalloc_node(size, GFP_USER | flags, numa_node);
+		/* To avoid bypassing slab alloc for lower order allocs,
+		 * __GFP_NORETRY is used instead of __GFP_RETRY_MAYFAIL.
+		 */
+		area = kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
+				    numa_node);
 		if (area != NULL)
 			return area;
 	}
 
-	return __vmalloc_node_flags_caller(size, numa_node, GFP_KERNEL | flags,
+	return __vmalloc_node_flags_caller(size, numa_node,
+					   GFP_KERNEL | __GFP_RETRY_MAYFAIL |
+					   flags,
 					   __builtin_return_address(0));
 }
 
-- 
2.21.0

