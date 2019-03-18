Return-Path: <SRS0=JidB=RV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8808DC43381
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 15:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576D52085A
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 15:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0Zies4gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCRPJZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:09:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36017 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbfCRPJY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Mar 2019 11:09:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F4C822414;
        Mon, 18 Mar 2019 11:09:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 18 Mar 2019 11:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qPZtzvFiu/5ExqyuG
        9Jy11sE5ua6cRfkmWpx5ufKrHc=; b=0Zies4gxtsoLmXkKzWoTbGxOjnhLAQmvM
        weSuMMJ2kqebaOt5fpj9EqKWZexpaPFFnom4ZSbCEFRg5/bjMuMfdiq7mbbajLdn
        zJD1Q9g9+kCRPRrzvHh8atoIn1gwyPN+JvhXqPQShQpUGCER68f9ZnrEGcYKeQN6
        RTikRFnpi7MAs9IM92KiZvWq0xrNra7wH/wSlwMAzw+jSRgw7ulaA9344jtuDLYx
        pPliIRwZ5PjvdIY4b3wYUsN3/MkQcxgoAEQNMbJ5J/n5Pv9LoSdUD5zhOkMJi9ZN
        6yhhKmphfyfFKAPfWNMhL4Wg0WYzggmp6KKUEQ0/5XbkoCc7QGG9w==
X-ME-Sender: <xms:orSPXOeQ9yC43MjkbK1Xn0WLuWnzg8GF0qThgqEqX1t62NKj9-ZFQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedugdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeforghrthihnhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggr
    rdhltheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudekkedrieefrd
    dvtdejrddvfeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:orSPXJjtXfpMe9_s_SDLL_Lkl6cdUrlN_Kc0HGi4ucUySkNDJgbi-Q>
    <xmx:orSPXEK-w3CYV-syuCnmPMndb6-gpUg7DOI7EKvreWdASOAlO4fY_A>
    <xmx:orSPXOr12itEYWGj8VKYKDtOdR10ismojYUUoSox_iwxaqMf971GiA>
    <xmx:o7SPXD5IO7kSCKe8tBfJM2K45nx6O4oh_pqyAouSjRTQkNcPy4LNag>
Received: from ceuse.home (235.207.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.207.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id A890D10319;
        Mon, 18 Mar 2019 11:09:20 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        mhocko@suse.com, m@lambda.lt, Yonghong Song <yhs@fb.com>
Subject: [PATCH v3 bpf] bpf: Try harder when allocating memory for large maps
Date:   Mon, 18 Mar 2019 16:10:26 +0100
Message-Id: <20190318151026.21539-1-m@lambda.lt>
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

Unfortunately, replacing the body of the BPF map memory allocation
function with the kvmalloc_node helper function is not an option at this
point in time, given 1) kmalloc is non-optional for higher order
allocations, and 2) passing __GFP_RETRY_MAYFAIL to the kmalloc would stress
the slab allocator too much for large requests.

The change has been tested with the workloads mentioned above and by
observing oom_kill value from /proc/vmstat.

[1]: https://lore.kernel.org/bpf/20190310071318.GW5232@dhcp22.suse.cz/

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 kernel/bpf/syscall.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 62f6bced3a3c..afca36f53c49 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -136,21 +136,29 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 
 void *bpf_map_area_alloc(size_t size, int numa_node)
 {
-	/* We definitely need __GFP_NORETRY, so OOM killer doesn't
-	 * trigger under memory pressure as we really just want to
-	 * fail instead.
+	/* We really just want to fail instead of triggering OOM killer
+	 * under memory pressure, therefore we set __GFP_NORETRY to kmalloc,
+	 * which is used for lower order allocation requests.
+	 *
+	 * It has been observed that higher order allocation requests done by
+	 * vmalloc with __GFP_NORETRY being set might fail due to not trying
+	 * to reclaim memory from the page cache, thus we set
+	 * __GFP_RETRY_MAYFAIL to avoid such situations.
 	 */
-	const gfp_t flags = __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO;
+
+	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
 	void *area;
 
 	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
-		area = kmalloc_node(size, GFP_USER | flags, numa_node);
+		area = kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
+				    numa_node);
 		if (area != NULL)
 			return area;
 	}
 
-	return __vmalloc_node_flags_caller(size, numa_node, GFP_KERNEL | flags,
-					   __builtin_return_address(0));
+	return __vmalloc_node_flags_caller(size, numa_node,
+					   GFP_KERNEL | __GFP_RETRY_MAYFAIL |
+					   flags, __builtin_return_address(0));
 }
 
 void bpf_map_area_free(void *area)
-- 
2.21.0

