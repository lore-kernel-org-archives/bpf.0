Return-Path: <SRS0=w90l=6G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC776C55186
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 08:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FA12074F
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 08:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDVI3W (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:29:22 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:33031 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgDVI3W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Apr 2020 04:29:22 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2020 04:29:21 EDT
Received: from mxplan6.mail.ovh.net (unknown [10.109.156.244])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id C994E3765BFA;
        Wed, 22 Apr 2020 10:23:28 +0200 (CEST)
Received: from jwilk.net (37.59.142.97) by DAG4EX2.mxp6.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 22 Apr
 2020 10:23:27 +0200
From:   Jakub Wilk <jwilk@jwilk.net>
To:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH v2] bpf: Fix reStructuredText markup
Date:   Wed, 22 Apr 2020 10:23:24 +0200
Message-ID: <20200422082324.2030-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200420144753.3718-1-jwilk@jwilk.net>
References: <20200420144753.3718-1-jwilk@jwilk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG7EX2.mxp6.local (172.16.2.62) To DAG4EX2.mxp6.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 22f6e39c-ead6-478b-ba0e-78f47e12fb86
X-Ovh-Tracer-Id: 18374686482964535078
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgrkhhusgcuhghilhhkuceojhifihhlkhesjhifihhlkhdrnhgvtheqnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnheirdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhifihhlkhesjhifihhlkhdrnhgvthdprhgtphhtthhopehmthhkrdhmrghnphgrghgvshesghhmrghilhdrtghomh
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes:

    $ scripts/bpf_helpers_doc.py > bpf-helpers.rst
    $ rst2man bpf-helpers.rst > bpf-helpers.7
    bpf-helpers.rst:1105: (WARNING/2) Inline strong start-string without end-string.

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
v2: "flags" should be italic, not bold

 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2e29a671d67e..7bbf1b65be10 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1642,7 +1642,7 @@ union bpf_attr {
  * 		ifindex, but doesn't require a map to do so.
  * 	Return
  * 		**XDP_REDIRECT** on success, or the value of the two lower bits
- * 		of the **flags* argument on error.
+ * 		of the *flags* argument on error.
  *
  * int bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key, u64 flags)
  * 	Description
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2e29a671d67e..7bbf1b65be10 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1642,7 +1642,7 @@ union bpf_attr {
  * 		ifindex, but doesn't require a map to do so.
  * 	Return
  * 		**XDP_REDIRECT** on success, or the value of the two lower bits
- * 		of the **flags* argument on error.
+ * 		of the *flags* argument on error.
  *
  * int bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key, u64 flags)
  * 	Description
-- 
2.26.2

