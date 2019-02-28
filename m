Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37EEC10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CDB20C01
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368017;
	bh=AnhWVgnVb0OGBs6aSQS24Wxbaos0WWg4rNVPGSnLip0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ofc31LIVILzmcJA2SJM0jMJUM3N5ZJ917A+EhAmA+zdFHGXLbhfVoSvenvfcd5ks
	 qLwHM8OkbRFQAwDm44P2Q2SiMYC96qBIUari0zSjnTPQmQgm+1vUaF5009Af1mA74I
	 LK1q/2VAB5GsH/RpkHZXQaeoKNh3saPoSP58A5cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfB1Pd3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733061AbfB1PIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B39A218CD;
        Thu, 28 Feb 2019 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366522;
        bh=AnhWVgnVb0OGBs6aSQS24Wxbaos0WWg4rNVPGSnLip0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=js8bh34wNhISjJRW0heusUyqzyIQ9jo4hFBPHdixYwld3KBNGASr8HjFreoZyrb+T
         1co6Q1VcJYSnEN78ydXs8QD0fxFcHb7cHOJxUjMRpbFID7CZjYrnitoRkoDwAl8KXa
         9OEiz3vETlpT4qZ3z0miAt9NdlZO4sX0uDQ8RmJY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 17/81] bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()
Date:   Thu, 28 Feb 2019 10:07:09 -0500
Message-Id: <20190228150813.10256-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit c9e4576743eeda8d24dedc164d65b78877f9a98c ]

When sock recvbuff is set by bpf_setsockopt(), the value must by
limited by rmem_max. It is the same with sendbuff.

Fixes: 8c4b4c7e9ff0 ("bpf: Add setsockopt helper function to bpf")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 16350f8c8815a..821050957acad 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3927,10 +3927,12 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 		/* Only some socketops are supported */
 		switch (optname) {
 		case SO_RCVBUF:
+			val = min_t(u32, val, sysctl_rmem_max);
 			sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
 			sk->sk_rcvbuf = max_t(int, val * 2, SOCK_MIN_RCVBUF);
 			break;
 		case SO_SNDBUF:
+			val = min_t(u32, val, sysctl_wmem_max);
 			sk->sk_userlocks |= SOCK_SNDBUF_LOCK;
 			sk->sk_sndbuf = max_t(int, val * 2, SOCK_MIN_SNDBUF);
 			break;
-- 
2.19.1

