Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E6C33CAF
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 17:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBF024694
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194725;
	bh=sfpKkZFrh5g6jwVycqE/JJD+LVoEXASUDwo3JwoTaeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q55DKDuT+KDWT1NtJnOZsUZzRri5HCcHcqWKG9ERhpMgoRM9ZwoHlk31vqHzHdI21
	 O8xEx59whfcRpB0Pz7x8eMGuO2VBYhXnwv8woYPnYoC047smRGzg4my8mUCMfu7X/K
	 XqytkZpMSASbKkFgO8mb7QnbDydiaUYZJdjdMBg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbgAPRME (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbgAPRME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765CB24697;
        Thu, 16 Jan 2020 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194723;
        bh=sfpKkZFrh5g6jwVycqE/JJD+LVoEXASUDwo3JwoTaeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4eAo4DEa6gUIpzoWju3qxy3c2sInn8N+ichoQ6Oln9SN1EpJ5citd/k9orGnrsy0
         EfC+M0V9Ef1DEpWtUF41jFG5lD7FipyGSUWnx5scMohyYsGhpPVHXu5fkKjhwUEu4I
         oceOu1E0DP6foJi+XTNVI4ilLxvZyltegHwVPEfY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 558/671] bpf: fix BTF limits
Date:   Thu, 16 Jan 2020 12:03:16 -0500
Message-Id: <20200116170509.12787-295-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit a0791f0df7d212c245761538b17a9ea93607b667 ]

vmlinux BTF has more than 64k types.
Its string section is also at the offset larger than 64k.
Adjust both limits to make in-kernel BTF verifier successfully parse in-kernel BTF.

Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/btf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 972265f32871..1e2662ff0529 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -22,9 +22,9 @@ struct btf_header {
 };
 
 /* Max # of type identifier */
-#define BTF_MAX_TYPE	0x0000ffff
+#define BTF_MAX_TYPE	0x000fffff
 /* Max offset into the string section */
-#define BTF_MAX_NAME_OFFSET	0x0000ffff
+#define BTF_MAX_NAME_OFFSET	0x00ffffff
 /* Max # of struct/union/enum members or func args */
 #define BTF_MAX_VLEN	0xffff
 
-- 
2.20.1

