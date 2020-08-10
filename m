Return-Path: <SRS0=CgHR=BU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A32C433DF
	for <bpf@archiver.kernel.org>; Mon, 10 Aug 2020 19:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4222BF3
	for <bpf@archiver.kernel.org>; Mon, 10 Aug 2020 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087460;
	bh=fawSJcfUm9T8ngtROovH+G7OVNYMfbyCkgJlVlGEZDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qZvNHYJs66NNmuZllGGmsbrO7lwSiD/bBPNuD1Pmt3ta3fyNLCRLql0XsG9tcymWU
	 ptjebERBdtuOQ6rZrD/mzs3b30GTLjagX8zL5OSSRyL7at2lWwwx0tq5gmh1RCWTSX
	 7ofD3l4rtlBvhO2lk0jENTVolD1VDsBjWBdUO98o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHJTYN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbgHJTMf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 15:12:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9A6E207FF;
        Mon, 10 Aug 2020 19:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086754;
        bh=fawSJcfUm9T8ngtROovH+G7OVNYMfbyCkgJlVlGEZDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYOTBr64Tyc/KdHIKSd0MeAyfl4KiGOUVD29ryxEUyzBpLfogjJIJzwzpFyX65qCr
         +V4NgiYyWIoLbgGV8KvSnLpZwNCAZMewRtJGJ62zFcvU5/m7cU1ak4OWIJCVwgM5gR
         1017n3gidwDJOtP6ncQBMFAJ/D7Au3TgqGO0+Mio=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenbo Zhang <ethercflow@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 29/45] bpf: Fix fds_example SIGSEGV error
Date:   Mon, 10 Aug 2020 15:11:37 -0400
Message-Id: <20200810191153.3794446-29-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191153.3794446-1-sashal@kernel.org>
References: <20200810191153.3794446-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Wenbo Zhang <ethercflow@gmail.com>

[ Upstream commit eef8a42d6ce087d1c81c960ae0d14f955b742feb ]

The `BPF_LOG_BUF_SIZE`'s value is `UINT32_MAX >> 8`, so define an array
with it on stack caused an overflow.

Signed-off-by: Wenbo Zhang <ethercflow@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200710092035.28919-1-ethercflow@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/fds_example.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/fds_example.c b/samples/bpf/fds_example.c
index 2d4b717726b64..34b3fca788e8d 100644
--- a/samples/bpf/fds_example.c
+++ b/samples/bpf/fds_example.c
@@ -30,6 +30,8 @@
 #define BPF_M_MAP	1
 #define BPF_M_PROG	2
 
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
 static void usage(void)
 {
 	printf("Usage: fds_example [...]\n");
@@ -57,7 +59,6 @@ static int bpf_prog_create(const char *object)
 		BPF_EXIT_INSN(),
 	};
 	size_t insns_cnt = sizeof(insns) / sizeof(struct bpf_insn);
-	char bpf_log_buf[BPF_LOG_BUF_SIZE];
 	struct bpf_object *obj;
 	int prog_fd;
 
-- 
2.25.1

