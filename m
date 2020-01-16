Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E814C33CAF
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F16E2073A
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202675;
	bh=sq5OqsXtfabk0lzYM/DJk5XuO8zXil5wi76LZgBG4NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2sulGCnFLci8f5OxI3LL6hUsb3l92Sg1z3Dw0dooXpBQ9OFzzkbDk1BaaRk2ZbFA7
	 mIwEOA18yFRQR/d3G7NUwhWuuM0AEQ3qJLuyjWow/RB6F1oWi0mhoKYCax1/90ZCXk
	 EcV3WglScC3nc+xBnOOSXv7usmgcz6NcJTN0XQ2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgAPQwu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbgAPQwt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 11:52:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE8624679;
        Thu, 16 Jan 2020 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193568;
        bh=sq5OqsXtfabk0lzYM/DJk5XuO8zXil5wi76LZgBG4NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wThEQS3hdX0VuKK9TNLG5kHbDawjADyoqySukadSK9hxy30CWJs+J27eS4ADIDrXT
         8FPok6kVzlPe6xXU5U1T+0jbkLVOGBAsFCPJ9QroSwlcY2rt78MOAU/8vQo8uuiOFf
         xqq/Uq5McFF3N+CUGxYm96mVJCP1uplQFkOOqOXs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 112/205] libbpf: Fix potential overflow issue
Date:   Thu, 16 Jan 2020 11:41:27 -0500
Message-Id: <20200116164300.6705-112-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit 4ee1135615713387b869dfd099ffdf8656be6784 ]

Fix a potential overflow issue found by LGTM analysis, based on Github libbpf
source code.

Fixes: 3d65014146c6 ("bpf: libbpf: Add btf_line_info support to libbpf")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20191107020855.3834758-3-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index cbb933532981..9d0485959308 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -189,7 +189,7 @@ static void *
 alloc_zero_tailing_info(const void *orecord, __u32 cnt,
 			__u32 actual_rec_size, __u32 expected_rec_size)
 {
-	__u64 info_len = actual_rec_size * cnt;
+	__u64 info_len = (__u64)actual_rec_size * cnt;
 	void *info, *nrecord;
 	int i;
 
-- 
2.20.1

