Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615A9C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 08:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABE920684
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 08:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BrQfMHtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfCHIIQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:08:16 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56657 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfCHIIQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Mar 2019 03:08:16 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B908B220A5;
        Fri,  8 Mar 2019 03:08:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 08 Mar 2019 03:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=f1E2hiZYXHVnWN98s
        CmbGELhCEtVorgyGVbvdsi/lLA=; b=BrQfMHtxQe643kcUUMwH5BDdYstGlSdjP
        OAtHU7Cox2oiZnja31V0hk2yXDoyoByYRzKuwmiT7S/soapykg5rTSbKBBc7imGI
        KHJRw+BEu3dckvZYaU9AEHHIX6EbRUB4EJoFpw+RSAFO/KSuMtsm+M3z3MhMc00t
        05jiR7Y80LOVSGe5nplyCtL+6H7g3ZeqcoEfJo4Lt8pJZM8oZqyW0jdgJHUvKYSn
        GJB69NQd9Mu5cSwa+sETUXLy73+X2Qd9nUAuG2IZwYoa/3YW0uowPjHspk18KYcZ
        7w4cUdT2ZctwDdR7UskxXFaos3vOxRMPWkOmrwYC4x3zS34VgdRhQ==
X-ME-Sender: <xms:7iKCXPHb_JLcY0eYITmzqiXoRVo2_BZhGml8zvs0-bh1slLaTH2_nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghmsggu
    rgdrlhhtqeenucfkphepfedurdduieegrdduvdefrddvfeelnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehlrghmsggurgdrlhhtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:7iKCXC3L3egbEO-IzJ3XGUwdhTDr8Kon78g_QpG2HqItcaIVujLgIQ>
    <xmx:7iKCXPL6X1feAbJP74gNvcRKEUHob6bsWlGYKWgEIKMv-KM5_VYCIg>
    <xmx:7iKCXP2QFbAPXhpTWZ5qrxKCIv-SKcEjhxIRbsFUO4PU64a8KW5x6A>
    <xmx:7yKCXOl3HZ7RmbCCZw7eUlSbu6c3fpWLcLhQ2l2o-9LLhuLahZhA2g>
Received: from localhost.localdomain (xdsl-31-164-123-239.adslplus.ch [31.164.123.239])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9EEF3E46A1;
        Fri,  8 Mar 2019 03:08:13 -0500 (EST)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, mhocko@suse.com, m@lambda.lt
Subject: [PATCH] bpf: Try harder when allocating memory for maps
Date:   Fri,  8 Mar 2019 09:08:57 +0100
Message-Id: <20190308080857.12005-1-m@lambda.lt>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It has been observed that sometimes memory allocation for BPF maps
fails when there is no obvious memory pressure in a system.

E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
could not be created due to due to vmalloc unable to allocate 75497472B,
when the system's memory consumption (in MB) was the following:

    Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727

Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
__GFP_RETRY_MAYFAIL with more useful semantic") we can replace
__GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
and will try harder to fulfil allocation requests.

The change has been tested with the workloads mentioned above and by
observing oom_kill value from /proc/vmstat.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 kernel/bpf/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 62f6bced3a3c..eb5cefe44af3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -136,11 +136,11 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 
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
+	const gfp_t flags = __GFP_NOWARN | __GFP_RETRY_MAYFAIL | __GFP_ZERO;
 	void *area;
 
 	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
-- 
2.21.0

