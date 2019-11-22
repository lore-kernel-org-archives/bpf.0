Return-Path: <SRS0=6bUS=ZO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAC7C432C0
	for <bpf@archiver.kernel.org>; Fri, 22 Nov 2019 05:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AFB2068F
	for <bpf@archiver.kernel.org>; Fri, 22 Nov 2019 05:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402343;
	bh=Nh+HcfVHCez8hEtRqsXlfDz3c1EZS0DjrPKmFW0Nb7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UTsDo45+dmib6PI5RYEawiOtfOmc9b/qTvwiX2CPwzMZehLsUFh4/jjgsJJXUp5Xo
	 fXe3NsBBjp3Pl7mKhgW4APT8rUGucpbyuJTnUops3ueXTgtO6qnLOhV+45oo15UH0i
	 ik9b9NfGfknSnAbPnlCcfax7gAxeztouE/700GRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfKVF57 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:57:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbfKVF56 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70832072E;
        Fri, 22 Nov 2019 05:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402277;
        bh=Nh+HcfVHCez8hEtRqsXlfDz3c1EZS0DjrPKmFW0Nb7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BA7acYJz4I5D+VE+Mvav2N6zreakivsWmqvDbvaw5PUB0I0qFBixHFhLB0Eot2rXR
         z3XI9/8qlNvbJPfowgcwwfexdvTe+p1+N2GmpEzmiOwcVNn3MkLvbdzZXUCcw9E7vE
         f7RaXxMThPyJIOaRKd5r65nXiF75xR+qIwaKgnBI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Sun <sironhide0null@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 117/127] bpf: drop refcount if bpf_map_new_fd() fails in map_create()
Date:   Fri, 22 Nov 2019 00:55:34 -0500
Message-Id: <20191122055544.3299-115-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peng Sun <sironhide0null@gmail.com>

[ Upstream commit 352d20d611414715353ee65fc206ee57ab1a6984 ]

In bpf/syscall.c, map_create() first set map->usercnt to 1, a file
descriptor is supposed to return to userspace. When bpf_map_new_fd()
fails, drop the refcount.

Fixes: bd5f5f4ecb78 ("bpf: Add BPF_MAP_GET_FD_BY_ID")
Signed-off-by: Peng Sun <sironhide0null@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 34110450a78f2..f5c1d5479ba3d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -348,12 +348,12 @@ static int map_create(union bpf_attr *attr)
 	err = bpf_map_new_fd(map);
 	if (err < 0) {
 		/* failed to allocate fd.
-		 * bpf_map_put() is needed because the above
+		 * bpf_map_put_with_uref() is needed because the above
 		 * bpf_map_alloc_id() has published the map
 		 * to the userspace and the userspace may
 		 * have refcnt-ed it through BPF_MAP_GET_FD_BY_ID.
 		 */
-		bpf_map_put(map);
+		bpf_map_put_with_uref(map);
 		return err;
 	}
 
-- 
2.20.1

