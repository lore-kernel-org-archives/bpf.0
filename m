Return-Path: <SRS0=JBMC=ZI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002CC43141
	for <bpf@archiver.kernel.org>; Sat, 16 Nov 2019 16:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFB521845
	for <bpf@archiver.kernel.org>; Sat, 16 Nov 2019 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921453;
	bh=SqMAJqA3YHvVV9J5WhrstskH1pJ06XfwMtA3zAsaE7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kDjM+tO7Ke3BT/VmHPsduPdF/fkdwKxEt/KXsDAsKsetIVDP6RmBybY4mCxbqLoWz
	 ZiNGnEIv2WwiwyT6kl5B2H5SUq1p/W+SmfHuCYErSRwV5XBg5Eq3a7/icpcWJnwNhD
	 jCSVAGtNnm4AFJsNYehPMLYDU0wG2xPBzDGm4C+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfKPQYE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbfKPPmp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:45 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EBD82073B;
        Sat, 16 Nov 2019 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918964;
        bh=SqMAJqA3YHvVV9J5WhrstskH1pJ06XfwMtA3zAsaE7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrtA7PNRaCa05URnBlRGCWEb/Xqkk4Hb8qFj6mTj4hvvTYhwwlZyUVBdMOOFxuQrq
         513E7LYAAPCWjdvKhvAU2mjgSa40sBau7t3oOmMD6fxVJSfJzYqfZq9HOWgKl/3TMK
         aaj4QazclojQsIbXfa6tDrWBtNEDenop3ONAP1EY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 081/237] selftests/bpf: fix file resource leak in load_kallsyms
Date:   Sat, 16 Nov 2019 10:38:36 -0500
Message-Id: <20191116154113.7417-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>

[ Upstream commit 1bd70d2eba9d90eb787634361f0f6fa2c86b3f6d ]

FILE pointer variable f is opened but never closed.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index cf156b3536798..82922f13dcd3a 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -41,6 +41,7 @@ int load_kallsyms(void)
 		syms[i].name = strdup(func);
 		i++;
 	}
+	fclose(f);
 	sym_cnt = i;
 	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
 	return 0;
-- 
2.20.1

