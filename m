Return-Path: <SRS0=N9AH=77=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DCBC433E1
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 02:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760BC20720
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 02:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447515;
	bh=hWvsQYDqO6ODPc2VivaR0tA2XykBahjovGY7dkG8Gk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kAsUEyEVewEqm1w6H8kp1l4vDLdJBo3epteYqUloK5qXLOfeoQ8jR4mf5Nb2Uzb+0
	 6GusLzXXcDyWhpfOcbOUpio9GLofcWQW25r5mImXemu+lVuXBcUTSVBhra15aNp2q4
	 XsuQMJJUypGjQ397lv+BHHRLpLfQQp8ScPWvrXPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgFRBPZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbgFRBPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4532088E;
        Thu, 18 Jun 2020 01:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442917;
        bh=hWvsQYDqO6ODPc2VivaR0tA2XykBahjovGY7dkG8Gk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSJ4YnZkQFbsdQVpkI1DtK5v+O+YLp70YFL66+jJiny4i3Yq2E5soGiJ3CLYX0qi5
         4jmSNY+pypFlSZN0DpdyDLSX+DllGr91Tw0qxGzGytL19zzl2O1w2yf1DcOBWrT0du
         WlEgsee6uEitn78U21ObRzbWTcIGI02t6f0M5i08=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 334/388] bpf: Fix an error code in check_btf_func()
Date:   Wed, 17 Jun 2020 21:07:11 -0400
Message-Id: <20200618010805.600873-334-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e7ed83d6fa1a00d0f2ad0327e73d3ea9e7ea8de1 ]

This code returns success if the "info_aux" allocation fails but it
should return -ENOMEM.

Fixes: 8c1b6e69dcc1 ("bpf: Compare BTF types of functions arguments with actual types")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200604085436.GA943001@mwanda
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index efe14cf24bc6..739d9ba3ba6b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7366,7 +7366,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	const struct btf *btf;
 	void __user *urecord;
 	u32 prev_offset = 0;
-	int ret = 0;
+	int ret = -ENOMEM;
 
 	nfuncs = attr->func_info_cnt;
 	if (!nfuncs)
-- 
2.25.1

