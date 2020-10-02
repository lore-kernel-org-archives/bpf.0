Return-Path: <SRS0=svjS=DJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21423C35257
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 23:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA920206CD
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601681789;
	bh=iOVObYJsM+EFNqUv+ULTp5M07bWQLZYcS5493ovJNM4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mCRGxFLMStGfrKh27BUJInfZucfM52urYXQieESXywg5hAOcHmmkKOo/lF+HxokI8
	 Dm4B8HdpMq5w9hKWcJszbLOR5ZkFdn2wyoSnSAPcdiOSEfQeQ+/9prJFsB1vLKr/xc
	 7utz+fG43cb3x/tn23qeSIEPVvh0UhfrlxhFtV0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgJBXg3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBXg3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 19:36:29 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFBD206B7;
        Fri,  2 Oct 2020 23:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601681788;
        bh=iOVObYJsM+EFNqUv+ULTp5M07bWQLZYcS5493ovJNM4=;
        h=Date:From:To:Cc:Subject:From;
        b=VhJb/GwO/mAoRHW9/eBJv4/NvJiJX94JViRvsHucqBIgoPhRJjxsMM51Q9/yYoSYm
         CbefN5tC9q9a7mTBdA/BhW9lu+8gyo8mDhTRv0Vh2Euz1DmowE6LkwSNkoA6sahnjT
         /eIh+XhXj6eIS5MNieK40/WwquhUCt/B3VZrcMVM=
Date:   Fri, 2 Oct 2020 18:42:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] bpf: verifier: Use fallthrough pseudo-keyword
Message-ID: <20201002234217.GA12280@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace /* fallthrough */ comments with the new pseudo-keyword macro
fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 015a1c074b6b..fcef04b80b66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2667,7 +2667,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		if (t == BPF_WRITE)
 			return false;
-		/* fallthrough */
+		fallthrough;
 
 	/* Program types with direct read + write access go here! */
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -5432,7 +5432,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		/* smin_val represents the known value */
 		if (known && smin_val == 0 && opcode == BPF_ADD)
 			break;
-		/* fall-through */
+		fallthrough;
 	case PTR_TO_PACKET_END:
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCKET_OR_NULL:
-- 
2.27.0

